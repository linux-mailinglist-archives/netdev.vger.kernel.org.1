Return-Path: <netdev+bounces-129644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FC98515E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 05:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D018B20B8A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 03:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A514883B;
	Wed, 25 Sep 2024 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bbHWULm2"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E31487FF;
	Wed, 25 Sep 2024 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727234221; cv=none; b=QPnPmes+0VJnnOsou64o5ZjpI8ynjEWfh0y+BxMBStqqZN/J571mafNu8JQftiLdwYjnzbaNArXcvhn+hm/qaVMemJIoRj4AarCvUVEuuLSFCYmMEbevQBZBgSBSIa2l6U47GmJbC+0HQrQLsrN2RDg28oRHQ9r33eZBXGf0PJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727234221; c=relaxed/simple;
	bh=eSLOudwo/gNlwHCaosTH6LuuU8d+3VhzM0tpxUzQTkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOxKxn+Vz1bKguoDNolM7mJAcBHdrXh/jDU3cwoeulcs7ITXJjWVlbSxl1RAnBIVMt/9hw9CmBymBfg/3lR1Gr3t7KXpHFqv6+lE9VJMbgHWXwT2kPXAMxRRxab5SH6BT+SDvqdpE5VRl5oKYICFDXSiaZ5uMb7QCIHMe2cd/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bbHWULm2; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727234216; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vBmybkyManHrqJ/9QxLToxzghGi40MtTOZyEj7zvSaU=;
	b=bbHWULm2HBnxfmV0uarqZnPEelxAaICiV5E8QdervlCD11ul8ISzV/Le0FCmy9WLc2SVGMTIXgmIIHn0vbWHiB5tVC3T/l5irKneHNo67PldZ8lll2BY5oGx/UYPAHOUAi/5u3jelchvabvAZAVyJbMZUq+ufCrhtneMRvAB2tg=
Received: from 30.221.128.100(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFi0I1F_1727234213)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 11:16:54 +0800
Message-ID: <0fb425e0-5482-4cdf-9dc1-3906751f8f81@linux.alibaba.com>
Date: Wed, 25 Sep 2024 11:16:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 net-next 3/3] ipv4/udp: Add 4-tuple hash for
 connected socket
To: Gur Stavi <gur.stavi@huawei.com>
Cc: antony.antony@secunet.com, davem@davemloft.net, dsahern@kernel.org,
 dust.li@linux.alibaba.com, edumazet@google.com, fred.cc@alibaba-inc.com,
 jakub@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 willemdebruijn.kernel@gmail.com, yubing.qiuyubing@alibaba-inc.com
References: <20240924110414.52618-4-lulie@linux.alibaba.com>
 <20240924123113.1688315-1-gur.stavi@huawei.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20240924123113.1688315-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/9/24 20:31, Gur Stavi wrote:
>> +/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
>> +static void udp4_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
>> +{
>> +	struct udp_hslot *hslot4, *nhslot4;
>> +
>> +	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
>> +	nhslot4 = udp_hashslot4(udptable, newhash4);
>> +	udp_sk(sk)->udp_lrpa_hash = newhash4;
>> +
>> +	if (hslot4 != nhslot4) {
>> +		spin_lock_bh(&hslot4->lock);
>> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
>> +		hslot4->count--;
>> +		spin_unlock_bh(&hslot4->lock);
> 
> I realize this is copied from udp_lib_rehash, but isn't it an RCU bug?
> Once a node is removed from a list, shouldn't synchronize_rcu be called
> before it is reused for a new list? A reader that was traversing the
> old list may find itself on the new list.
> 
>> +
>> +		spin_lock_bh(&nhslot4->lock);
>> +		hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
>> +		nhslot4->count++;
>> +		spin_unlock_bh(&nhslot4->lock);
>> +	}
>> +}
>> +

Good catch! IIUC, synchronize_rcu() is needed here, or otherwise, this 
could happen:

    Reader(lookup)     Writer(rehash)
    -----------------  ---------------
1. rcu_read_lock()
2. pos = sk;
3.                     hlist_del_init_rcu(sk, old_slot)
4.                     hlist_add_head_rcu(sk, new_slot)
5. pos = pos->next; <=
6. rcu_read_unlock()

In step 5, we wrongly moved from old_slot to new_slot.

Perhaps the similar codes in udp_lib_rehash() for hslot2 also need a fix.

Thanks.
-- 
Philo


