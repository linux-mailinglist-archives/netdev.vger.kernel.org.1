Return-Path: <netdev+bounces-90897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A18B0A87
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705A62857E8
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CCD15B99E;
	Wed, 24 Apr 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h/6rdd7D"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24C15B56F;
	Wed, 24 Apr 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964271; cv=none; b=iRpRvWXWmCidZkMbGUC/YwmdaOyd5y/ouJtaq53P9TIHH8KbVm/XmE+zYwzlEWVQMum2zVkeDc91fVQNlzd65wCD0XZVAaSq8m+01UvrSVbdomxdLSYikCLsPPTceHRf8LQiaVEt86ZrybSG7N+b0J0MkT4coI2VOGrLq40inhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964271; c=relaxed/simple;
	bh=LIDqAQu4uQ/HQYk5mOyL+t0L0UHjVQlLHfWCIRPYElM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OGnAwAksXP6cmjCdN3smsNFTGT/hDuMyin5mcCVwrMyyQvAD4UeKDEfEEbhrvfRdwi5+ljoK1TimAW2A5f80HKBbG7Imm3yIS1IVXlBE08augRG4KfvanEQg4nHArT+4vco3TiWR/Nwy7zaA+/bmxNG+YYCcTFdIBAcqapMrpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h/6rdd7D; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713964260; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=wdSVvWDX+Np6cNQGBuY/SvU5jYu+onGWyo5SDaMi794=;
	b=h/6rdd7DSUXYdOS0eIVVB8R73ngppXjj89YMA27srac6g4rwOaeCf0xGQbhNX191pBs+bunF8z4AVDlVHF/2OxB4UqD6V+vQAuzR5JQ9KT5+Z9vDtnYrQJdwXluQn9cRs93c7a+Jg3dm7NO3d2wRvRgRgNoYr9tNUQrcnGSpCa8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5CPai0_1713964256;
Received: from 30.221.148.255(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5CPai0_1713964256)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 21:10:58 +0800
Message-ID: <76b75fcc-aa2f-4c75-b28f-7f7a513a2cf1@linux.alibaba.com>
Date: Wed, 24 Apr 2024 21:10:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, "justinstitt@google.com"
 <justinstitt@google.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
 <20240417155546.25691-3-hengqi@linux.alibaba.com>
 <20240418174843.492078d5@kernel.org>
 <96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
 <20240422113943.736861fc@kernel.org>
In-Reply-To: <20240422113943.736861fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

@@ -227,7 +315,19 @@ const struct nla_policy ethnl_coalesce_set_policy[] = {
>>>>    	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
>>>>    	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
>>>>    	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
>>>> +	[ETHTOOL_A_COALESCE_RX_EQE_PROFILE]     = { .type = NLA_NESTED },
>>>> +	[ETHTOOL_A_COALESCE_RX_CQE_PROFILE]     = { .type = NLA_NESTED },
>>>> +	[ETHTOOL_A_COALESCE_TX_EQE_PROFILE]     = { .type = NLA_NESTED },
>>>> +	[ETHTOOL_A_COALESCE_TX_CQE_PROFILE]     = { .type = NLA_NESTED },
>>> NLA_POLICY_NESTED(coalesce_set_profile_policy)
>> This doesn't work because the first level of sub-nesting of
>> ETHTOOL_A_COALESCE_RX_CQE_PROFILE is ETHTOOL_A_PROFILE_IRQ_MODERATION.
> So declare a policy for IRQ_MODERATION which has one entry -> nested
> profile policy?

Still doesn't work because one profile corresponds to 5 IRQ_MODERATION sub-nests.

In the same example, strset also uses NLA_NESTED.

Thanks.



