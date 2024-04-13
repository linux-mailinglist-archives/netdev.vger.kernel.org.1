Return-Path: <netdev+bounces-87606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA78A3C2F
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 12:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7991C20CD9
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C01F94C;
	Sat, 13 Apr 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Wky/w8tK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2523E468
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003283; cv=none; b=BPisi3umL58PCjacsAcbu54Qo/1JF1zu54uW0XSIXXCi6OB1r6sRLFIErxerOrzpnEJC6gXjhvOQqQkSf5u/EGz3wUcQWijlIarTSZjePt6L7Gg7vn2oJyEE663g3Vh2c/fsu/ssonE749qfDeyBX9pp6GH8KmOr16+RbYCsVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003283; c=relaxed/simple;
	bh=eTJ1gfvX/QILdkNIQKUKa84lThtZZ9IC3aAceSvbG5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0LclYEdrfvMBI4BywPB+rhFoTFddb9BpAhWQaivdb0kXjjCF6HIq6zH0kEPSQjDUZLI+aFrjg9aq9yhENZpOCHfJfztRaXwPY+I8yzE3emri1HOD1yloPHdEuVolsxGp6mwI4bPfyqAKhCicFlrPU9zKxsUnC6lsStP04X+hxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Wky/w8tK; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713003272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D2bsoSZVNVKdkcGk5UCSuE8H7BnzbJmApWRn2E3fRak=;
	b=Wky/w8tKc5u2lEmWypLCeo5LFDbh3l6HPbXBYmSBwI3DLJIjNaEftafHE4U8L/iQf98MItVA2dggVzYg17H5yT0jL2IcxWk6URVCPZjZySG7CKzffG5W6qkNkwJM6ozVclfoKFbl2CsLe2kBN59TQNT7eygoubp2Ckx7QLbl2iM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4QLnpd_1713003271;
Received: from 30.121.51.84(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4QLnpd_1713003271)
          by smtp.aliyun-inc.com;
          Sat, 13 Apr 2024 18:14:32 +0800
Message-ID: <a69d85f5-d11d-40e9-9c0b-1db210aaa359@linux.alibaba.com>
Date: Sat, 13 Apr 2024 18:14:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
 <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
 <20240412192645.2c0b745b@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240412192645.2c0b745b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/13 上午10:26, Jakub Kicinski 写道:
> On Thu, 11 Apr 2024 22:12:29 +0800 Heng Qi wrote:
>> +#include <linux/dim.h>
>>   #include <net/net_trackers.h>
>>   #include <net/net_debug.h>
>>   #include <net/dropreason-core.h>
>> @@ -1649,6 +1650,9 @@ struct net_device_ops {
>>    * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
>>    *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
>>    *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
>> + * @IFF_PROFILE_USEC: device supports adjusting the DIM profile's usec field
>> + * @IFF_PROFILE_PKTS: device supports adjusting the DIM profile's pkts field
>> + * @IFF_PROFILE_COMPS: device supports adjusting the DIM profile's comps field
>>    */
>>   enum netdev_priv_flags {
>>   	IFF_802_1Q_VLAN			= 1<<0,
>> @@ -1685,6 +1689,9 @@ enum netdev_priv_flags {
>>   	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
>>   	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
>>   	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
>> +	IFF_PROFILE_USEC		= BIT_ULL(34),
>> +	IFF_PROFILE_PKTS		= BIT_ULL(35),
>> +	IFF_PROFILE_COMPS		= BIT_ULL(36),
>>   };
>>   
>>   #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
>> @@ -2400,6 +2407,14 @@ struct net_device {
>>   	/** @page_pools: page pools created for this netdevice */
>>   	struct hlist_head	page_pools;
>>   #endif
>> +
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	/* DIM profile lists for different dim cq modes */
>> +	struct dim_cq_moder *rx_eqe_profile;
>> +	struct dim_cq_moder *rx_cqe_profile;
>> +	struct dim_cq_moder *tx_eqe_profile;
>> +	struct dim_cq_moder *tx_cqe_profile;
>> +#endif
> just one pointer to a new wrapper struct, put the pointers and a flag
> field in there.
>
> netdevice.h is included by thousands of files, please use a forward
> declaration for the type and avoid including dim.h

I will update this.

Thanks for the constructive comments!


