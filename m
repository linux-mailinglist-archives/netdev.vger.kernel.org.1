Return-Path: <netdev+bounces-13860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C345C73D7C5
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A861C2074B
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BE5637;
	Mon, 26 Jun 2023 06:31:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD0A51
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52035C433C0;
	Mon, 26 Jun 2023 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687761092;
	bh=yTWynjpAhpo2gu8Y4caUg/BFG5wYbkP2zkvjL/DB+iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LaDimiIMDAPdF/zygITg2soLuLIZLvuykkxrp0pq2SxUk+MIRbHLJo3CZojzxrv6o
	 qvKl2hXpxJliJcF/VrevKzExYeltWMqPqIscp8kGuI6iG4XkzcQQ2BAAP2+4gI+qki
	 aB1pplzRZuNsz57kX9mxY3R7ymmmtJ9G+0Q3wR2jrAMqknyEeC81mitslpQuaLkwur
	 riAKJEejphOvrZuUQ//AQoDxN4tnjfnrG3VkLQbvoYZifm/LC/1os9DGFVrzdmbYaJ
	 5WI1zjg4v++1OlRkUTc2djVrB1JMbU7t/DBaG3uCZvOx2LHO0EfC90mLA0mZBG0lgo
	 OY7s9HcP/xnHQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 Jun 2023 08:31:26 +0200
From: Michael Walle <mwalle@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/10] net: phy: replace is_c45 with
 phy_accces_mode
In-Reply-To: <6fcd887a-c731-4c31-bb43-e8d14071524e@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-4-def0ab9ccee2@kernel.org>
 <52cdebe9-0f94-430d-93ff-11f26d2e3c5b@lunn.ch>
 <6fcd887a-c731-4c31-bb43-e8d14071524e@lunn.ch>
Message-ID: <353752b143bca56f79035635808e8e30@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2023-06-23 21:54, schrieb Andrew Lunn:
> On Fri, Jun 23, 2023 at 07:34:22PM +0200, Andrew Lunn wrote:
>> > @@ -131,9 +131,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>> >
>> >  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
>> >  	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
>> > -		phy = get_phy_device(bus, addr, is_c45);
>> > +		phy = get_phy_device(bus, addr,
>> > +				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
>> >  	else
>> > -		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
>> > +		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
>> > +					NULL);
>> 
>> Documentation/devicetree/bindings/net/ethernet-phy.yaml says:
>> 
>>   compatible:
>>     oneOf:
>>       - const: ethernet-phy-ieee802.3-c22
>>         description: PHYs that implement IEEE802.3 clause 22
>>       - const: ethernet-phy-ieee802.3-c45
>>         description: PHYs that implement IEEE802.3 clause 45
>> 
>> It would be nice to make this documentation more specific. It now
>> refers to 'bus transaction', so maybe we want to append that to these
>> lines?
> 
> Humm, looking at patch 9, maybe i got this wrong. Patch 9 seems to
> suggest ethernet-phy-ieee802.3-c45 means c45 register space, and it is
> upto the core to figure out how to access that register space, either
> using c45 transactions, or C45 over C22.

Yes. And I think the core has all information to determine what mode
should be used. Use C45 transfers first and iff that's not possible
switch to C45-over-C22. Therefore, there isn't really a choice. It's
either "it will work" or "it won't work at all".

For all supported C45 PHYs right now, the mode should stay with C45
because, that was the only supported mode. Except, if a C45 PHY was
probed as a C22 PHY and stayed that way. With this patchset they
would now be probed a PHY with C45 registers and using C45-over-C22.
But I'm not sure if that's a thing.

-michael

