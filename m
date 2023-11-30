Return-Path: <netdev+bounces-52548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DB7FF1B3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BDBB21078
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECB051001;
	Thu, 30 Nov 2023 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG68xzPy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30502482E6
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE68BC433C9;
	Thu, 30 Nov 2023 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701354235;
	bh=wZi0hGsQ3XSwYWlqArpLeqdlNCo/znhk/QdMHk4tYUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dG68xzPyU20XZ30fUI7KF112zmAlPo7LLNpOLogfgPUVOG25PZTzaCKISCVXCNQH5
	 vAmfvzQ5wSTCLD9v/km1KtpC8tGC+PdmSrNUMWkuuNSyENbR/kQxnw/Csu946O2Q7j
	 PvA96I/ZxY8C1IG5aVog//9/ItsnjXqQITnhoefE7fjIzgocOUKlyCXK6XZQf3hJfG
	 MeIbwy62yYT0qjuibndhPLU6qiYktfioL6Uk5V3bOui/Yd3M1a1M6CUmTRA51OYHEY
	 05pvA00Q58cb/ODMJdQhpBnjPTFDABXbwwD05sLHM5CYIop9dlu7lXPgKJYVH8k9D7
	 TGeqggUxTBODA==
Message-ID: <030c7d65-bead-46d0-8422-8a9ff0548d72@kernel.org>
Date: Thu, 30 Nov 2023 16:23:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
 <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
 <20231121115314.deuvdjk64rcwktl4@skbuf>
 <6def78e7-8264-4745-94f3-b32b854af0c2@kernel.org>
 <20231130132222.w2irs5c4lxh5jcv7@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231130132222.w2irs5c4lxh5jcv7@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/11/2023 15:22, Vladimir Oltean wrote:
> On Thu, Nov 30, 2023 at 01:49:03PM +0200, Roger Quadros wrote:
>> Thanks for the debug instructions. Indeed lldpad tries to enable MM TX and the
>> network drivers set_mm() hook gets called and returns success but still
>> lldpad sees some error.
>>
>> I've also confirmed that ethnl_set_mm() runs successfully and returns 1.
>> I suppose something is going wrong in user-space with libnl?
>>
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability supported
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not enabled
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not active
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner minimum fragment size: 124 octets
>> Nov 21 11:50:02 am62xx lldpad[708]: eth0: initiating MM verification with a retry interval of 134 ms...
>> Nov 21 11:50:02 am62xx lldpad[708]: ethtool: kernel reports: integer out of range
>>
>>
>> full debug log is below.
> 
> Ah, you got confused. Openlldp issues multiple ETHTOOL_MSG_MM_SET
> netlink messages. What you observe is that one of them succeeds, and
> then another one returns -ERANGE before even calling the driver's
> set_mm() method.
> 
> And that comes from here in net/ethtool/mm.c:
> 
> 149 const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1] = {
> 150 »       [ETHTOOL_A_MM_HEADER]»  »       = NLA_POLICY_NESTED(ethnl_header_policy),
> 151 »       [ETHTOOL_A_MM_VERIFY_ENABLED]»  = NLA_POLICY_MAX(NLA_U8, 1),
> 152 »       [ETHTOOL_A_MM_VERIFY_TIME]»     = NLA_POLICY_RANGE(NLA_U32, 1, 128), // <---- here
> 153 »       [ETHTOOL_A_MM_TX_ENABLED]»      = NLA_POLICY_MAX(NLA_U8, 1),
> 154 »       [ETHTOOL_A_MM_PMAC_ENABLED]»    = NLA_POLICY_MAX(NLA_U8, 1),
> 155 »       [ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]»= NLA_POLICY_RANGE(NLA_U32, 60, 252),
> 156 };
> 
> You are reporting in .get_mm() a maximum verify time which is larger
> than the core ethtool is willing to accept in a further .set_mm() call.
> And openlldp will try to max out on the verify time. Hence the -ERANGE.

You are spot on on this. Thanks. :)

> 
> The range I chose for the policy comes from 802.3-2018 clause 30.14.1.6,
> which says that the aMACMergeVerifyTime variable has a range between 1
> and 128 ms inclusive.

I forced driver state->max_verify_time = 128; and now that -ERANGE
error is gone and the lldp test case passes.

I also applied your patch to ethtool_mm.sh and don't see the error with 
'addFragSize 0' anymore

Should I include your patch in the next revision of this series?

-- 
cheers,
-roger

