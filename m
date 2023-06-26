Return-Path: <netdev+bounces-13884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E033073D8A7
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 09:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857D71C204E8
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF21440C;
	Mon, 26 Jun 2023 07:37:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EA20F6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 07:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DEC433C8;
	Mon, 26 Jun 2023 07:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687765073;
	bh=RKPoNxTE7vcvysXf4LPjc4udS84UlrS8TNGtbR/i1LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JvD6qUdQCSq/1egAvme7X/GHETIBaQmDFD6mhyJxV5fUXJ5A08wSqYgbiu7RCfnwv
	 yRWZh4DmDvj+LV2IRW6uYa92Y3GNwMdSXUMM5ftsL6EZdH5dJRviIhrhEvbG16FPV9
	 d8W5QLqYkLMXvl8B51Geber6X9Ci2r4JqHOH9DPizVroZbL07wJUFSidD7bfYdOpqx
	 Q5p7ilCG1ee4EDZLdFW2eST+55JwOKLV4pp0fsl/5ZQgU0R1dyN1q9jB2JGcRWLwxQ
	 oE4xcdjp0K1R19HjP6FsqpZoyno/bXy/d8x732wGEV7/X777cOqVfWl4DHRHVjyjIW
	 0sn3hT1qVWPsQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 Jun 2023 09:37:47 +0200
From: Michael Walle <mwalle@kernel.org>
To: Simon Horman <simon.horman@corigine.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Marek_Beh?=
 =?UTF-8?Q?=C3=BAn?= <kabel@kernel.org>, Xu Liang <lxu@maxlinear.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: mdio: support C45-over-C22 when
 probed via OF
In-Reply-To: <ZJYFDcbZqI+EC3OX@corigine.com>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-10-def0ab9ccee2@kernel.org>
 <ZJYFDcbZqI+EC3OX@corigine.com>
Message-ID: <e5e1af31a4e609c94ac306f4f5140193@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

Am 2023-06-23 22:48, schrieb Simon Horman:
> On Fri, Jun 23, 2023 at 12:29:19PM +0200, Michael Walle wrote:
> 
> ...
> 
>> @@ -178,24 +209,26 @@ int __of_mdiobus_register(struct mii_bus *mdio, 
>> struct device_node *np,
>>  	if (rc)
>>  		return rc;
>> 
>> -	/* Loop over the child nodes and register a phy_device for each phy 
>> */
>> +	/* Loop over the child nodes, skipping C45 PHYs so we can scan for
>> +	 * broken C22 PHYs. The C45 PHYs will be registered afterwards.
>> +	 */
>>  	for_each_available_child_of_node(np, child) {
>> -		addr = of_mdio_parse_addr(&mdio->dev, child);
>> -		if (addr < 0) {
>> -			scanphys = true;
>> +		if (of_mdiobus_child_is_c45_phy(child))
>>  			continue;
>> -		}
>> +		rc = of_mdiobus_register_child(mdio, child, &scanphys);
>> +		if (rc)
>> +			goto unregister;
>> +	}
>> 
>> -		if (of_mdiobus_child_is_phy(child))
>> -			rc = of_mdiobus_register_phy(mdio, child, addr);
>> -		else
>> -			rc = of_mdiobus_register_device(mdio, child, addr);
>> +	/* Some C22 PHYs are broken with C45 transactions. */
>> +	mdiobus_scan_for_broken_c45_access(mdio);
> 
> Hi Michael,
> 
> Unfortunately this seems to cause a build fauilure
> for x86_64 allmodconfig.
> 
> ERROR: modpost: "mdiobus_scan_for_broken_c45_access" 
> [drivers/net/mdio/of_mdio.ko] undefined!

Oops, sorry. Seems I've forgot to export it. I guess it should
be EXPORT_SYMBOL_GPL().

-michael

