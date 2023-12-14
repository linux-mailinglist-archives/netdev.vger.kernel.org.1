Return-Path: <netdev+bounces-57459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA8A8131EF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409CE1C21A3A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B9956B6D;
	Thu, 14 Dec 2023 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt+DATdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AB55C29
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD26C433C7;
	Thu, 14 Dec 2023 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702561450;
	bh=YEhNauNXCKrZSOyW3uIlrreJdFz41AlCRaCt3xbA90M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jt+DATdIMtlVrRmpBI7LYjoyqwQljY5bew3/NVq3YtIcPSdB8EgUmN+C3NDPMOUoI
	 NqU02XbiX0YQZ2RTfCg+NCWMf22E7N5EVfvUv5gG1cMna4A4PvR8hOlReG+7YFWzmM
	 1Vr64Cxr8T9gcBIy5tIakgDeof2vAmLPYpIFObBPZ0p0DBlpm+qkVl0hJ2se/vlezW
	 +e3sivZoepYdLzh+QVC7nzjYc1axQFmgXEhKbdp34xFO2G7eAAeJWpLA2lmKY0mKyB
	 YEG5r8vruE8Nz+KufONzk8MVx/r8oQc5I1IuXU+PBYbF/dbDsTp3vn4f34rkG1UArG
	 k3nZXtwfIr8cQ==
Message-ID: <c08814cb-86b6-44bb-8682-00a5b6a0c0bc@kernel.org>
Date: Thu, 14 Dec 2023 15:44:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 09/11] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
 p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-10-rogerq@kernel.org>
 <20231214110448.lycg7yusrusbd7w2@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231214110448.lycg7yusrusbd7w2@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 13:04, Vladimir Oltean wrote:
> On Wed, Dec 13, 2023 at 01:07:19PM +0200, Roger Quadros wrote:
>> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>>   1G link if link is inactive.
>> +
>> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>> +			    struct netlink_ext_ack *extack)
>> +{
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (cfg->verify_enabled) {
>> +		val &= ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
>> +		/* Reset Verify state machine. Verification won't start here.
>> +		 * Verification will be done once link-up.
>> +		 */
>> +		val |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +	} else {
>> +		val |= AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
>> +		/* Clear LINKFAIL to allow verify/response packets */
>> +		val &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +	}
>> +
>> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
>> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +	/* verify_timeout_count can only be set at valid link */
>> +	if (cfg->verify_time > 0)
>> +		port->qos.iet.verify_time_ms = cfg->verify_time;
>> +	else
>> +		port->qos.iet.verify_time_ms = 10;
> 
> I don't think I understand what the check is for? The netlink policy for
> ETHTOOL_A_MM_VERIFY_TIME limits the range between 1 ms and 128 ms.
> How can it be 0?

I didn't check ETHTOOL_A_MM_VERIFY_TIME before.
Indeed, this check is pointless.

> 
>> +
>> +	/* enable/disable preemption based on link status */
>> +	am65_cpsw_iet_commit_preemptible_tcs(port);
>> +
>> +	return 0;
>> +}

-- 
cheers,
-roger

