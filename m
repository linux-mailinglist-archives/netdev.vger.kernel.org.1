Return-Path: <netdev+bounces-86377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E934989E85D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810A71F226D9
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0A8F6C;
	Wed, 10 Apr 2024 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wEdBBSsf"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57664A
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712718808; cv=none; b=EELiXSN18zYJmQG3j+yFhr4SczqVBbTDDztCqqUxPOCWcTxZFCLSSe3jQJfGC5v03PHrJIk783csLG/vXICilnUEgJpfgKkfTwb3aO8zZ3TWCEi1zhl1gTOjt5RvqveRb6e2V8S6MGVvxkORQXmrpc3Lcnz3hgiux41qXt2dqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712718808; c=relaxed/simple;
	bh=wvEgyk3NZQlKLuu84W7KDUZ3iF87v5vXeh/4kYtby10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRrs4SupAIVf0PUcqiKkjkP39G5RwesqZzfceygemkKeWFzPVwgJK77vdrVyYq1b9uSwX4bNoX/b4Lt7v/EZnFUqAppxEnXnzGArzQTPTOJ3054d1Kz4MtrYFUJwzcD+Hh5xXMXYGHosZoh3Bh3cTvKCEE3jLMfhnOUnxHpFCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wEdBBSsf; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712718798; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F4KaBEfcefOiJnTDntEDlBTr829WslVYeJ1u0b9cvjg=;
	b=wEdBBSsf6d1kGrimrB8ORpNuhiC5IKIkzt+HFFdTtTCFW2ARpUfL+kZfhZFv4WjBlO28Itn3cmk7iIc2UMhOcpB3wEQeH46vJH/JCx2UV33mN1MbGfNx1kxAXuSnEfZPQggAURWVUPH8JHLcBiHMCTLSSQRwDsr1HsJAbF13Ozs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4GJFM-_1712718796;
Received: from 30.221.148.212(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4GJFM-_1712718796)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 11:13:17 +0800
Message-ID: <a07d16d9-60cf-4263-abd5-a1adea0959ad@linux.alibaba.com>
Date: Wed, 10 Apr 2024 11:13:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
 <1712664204-83147-2-git-send-email-hengqi@linux.alibaba.com>
 <20240409184400.4e5444f3@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240409184400.4e5444f3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/10 上午9:44, Jakub Kicinski 写道:
> On Tue,  9 Apr 2024 20:03:21 +0800 Heng Qi wrote:
>> +/**
>> + * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
>> + * @skb: socket buffer the message is stored in
>> + * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
>> + * @profile: data passed to userspace
>> + * @supported_params: modifiable parameters supported by the driver
>> + *
>> + * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_MODERATION.
> unfortunately kdoc got more picky and it also wants us to document
> return values now,

Will add it.

> you gotta add something like
>
>   * Returns: true if ..
>
> actually this functions seems to return negative error codes as bool..

This works, in its wrapper function its error will be passed.:)

>
>> +static bool coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
>> +				 const struct dim_cq_moder *profile,
>> +				 u32 supported_params)
>> +{
>> +	struct nlattr *profile_attr, *moder_attr;
>> +	bool valid = false;
>> +	int i;
>> +
>> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
>> +		if (profile[i].usec || profile[i].pkts || profile[i].comps) {
>> +			valid = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!valid || !(supported_params & attr_to_mask(attr_type)))
>> +		return false;
>> +
>> +	profile_attr = nla_nest_start(skb, attr_type);
>> +	if (!profile_attr)
>> +		return -EMSGSIZE;
>> +
>> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
>> +		moder_attr = nla_nest_start(skb, ETHTOOL_A_MODERATIONS_MODERATION);
>> +		if (!moder_attr)
>> +			goto nla_cancel_profile;
>> +
>> +		if (nla_put_u16(skb, ETHTOOL_A_MODERATION_USEC, profile[i].usec) ||
>> +		    nla_put_u16(skb, ETHTOOL_A_MODERATION_PKTS, profile[i].pkts) ||
>> +		    nla_put_u16(skb, ETHTOOL_A_MODERATION_COMPS, profile[i].comps))
> u16 in netlink is almost always the wrong choice, sizes are rounded
> up to 4B, anyway, let's use u32 at netlink level.

OK.

Thanks for your comments.





