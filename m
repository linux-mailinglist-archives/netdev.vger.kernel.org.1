Return-Path: <netdev+bounces-136045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C19A016F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714101C219BF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 06:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6F18BBB7;
	Wed, 16 Oct 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mwhjqkE1"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D8171E70;
	Wed, 16 Oct 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060266; cv=none; b=RO99dzaUtVYX9nniIZlrC78ke+JRwsvA0pG8YUTi360pKY+INocI+d9BaZWXbubxfEsUCCJrmwRsG1S9mz5CsljXMxaKzSczrSChuM7Wt0HhN7kbPKoL1pGKKYynGBjrf7HAwEN5pY7mWTS+xPgTyDDeqEEDi4E0l8biqk8N0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060266; c=relaxed/simple;
	bh=vd1kShkEAAY9b/H1YcxxkckWvZM983ebztMGg3218AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeESCAgCOmBJH9o5FHIHYyLk9IzfzrU4mpaFIr8fYzAcRd/A0ZW18m6AGuC8KHnC5DdFdKxG1ke6rMy8mUiObT/DmaD2OtSkPgd/LxA0kfcUo9SV8jZA5FPOkw0BlrSTj1gfNLTCTbS/OBbQ6Uj7kLN+XKAmMpOpj9+wBllpslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mwhjqkE1; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729060259; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DVYZ4s29ZW4ZB3Y9mFTDBjLtH0bK73rSgGthvVvT36E=;
	b=mwhjqkE1SOU+wYP58Nh2RqOURkc4g1LY2qTsa6FQD04myz6n6bNkMMzXQc0MYu7Pm/HVcByy+a5dT3wCpMUTHJjPJKLWgc7Qt+rjueZgywA3zVzu1o6jrW4lqXdFzkrPRypMPFfx9q4XNxNy9zYcW0kisiQ1YD9cNHZoAMtG6gs=
Received: from 30.221.128.116(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHGBfOf_1729060257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 14:30:58 +0800
Message-ID: <2888bb8f-1ee4-4342-968f-82573d583709@linux.alibaba.com>
Date: Wed, 16 Oct 2024 14:30:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/3] net/udp: Add 4-tuple hash list basis
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-3-lulie@linux.alibaba.com>
 <9d611cbc-3728-463d-ba8a-5732e28b8cf4@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <9d611cbc-3728-463d-ba8a-5732e28b8cf4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/14 18:07, Paolo Abeni wrote:
> Hi,
> 
> On 10/12/24 03:29, Philo Lu wrote:
>> @@ -3480,13 +3486,14 @@ static struct udp_table __net_init 
>> *udp_pernet_table_alloc(unsigned int hash_ent
>>       if (!udptable)
>>           goto out;
>> -    slot_size = sizeof(struct udp_hslot) + sizeof(struct 
>> udp_hslot_main);
>> +    slot_size = 2 * sizeof(struct udp_hslot) + sizeof(struct 
>> udp_hslot_main);
>>       udptable->hash = vmalloc_huge(hash_entries * slot_size,
>>                         GFP_KERNEL_ACCOUNT);
> 
> I'm sorry for the late feedback.
> 
> I think it would be better to make the hash4 infra a no op (no lookup, 
> no additional memory used) for CONFIG_BASE_SMALL=y builds.
> 

Got it. There are 2 affected structs, udp_hslot and udp_sock. They (as 
well as related helpers like udp4_hash4) can be wrapped with 
CONFIG_BASE_SMALL, and then we can enable BASE_SMALL to eliminate 
additional overhead of hash4.

```
+struct udp_hslot_main {
+	struct udp_hslot	hslot; /* must be the first member */
+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+	u32			hash4_cnt;
+#endif
+} __aligned(2 * sizeof(long));


@@ -56,6 +56,12 @@ struct udp_sock {
  	int		 pending;	/* Any pending frames ? */
  	__u8		 encap_type;	/* Is this an Encapsulation socket? */

+#if !IS_ENABLED(CONFIG_BASE_SMALL)
+	/* For UDP 4-tuple hash */
+	__u16 udp_lrpa_hash;
+	struct hlist_node udp_lrpa_node;
+#endif
+
```

> It would be great if you could please share some benchmark showing the 
> raw max receive PPS performances for unconnected sockets, with and 
> without this series applied, to ensure this does not cause any real 
> regression for such workloads.
> 

Tested using sockperf tp with default msgsize (14B), 3 times for w/ and 
w/o the patch set, and results show no obvious difference:

[msg/sec]  test1    test2    test3    mean
w/o patch  514,664  519,040  527,115  520.3k
w/  patch  516,863  526,337  527,195  523.5k (+0.6%)

Thank you for review, Paolo.
-- 
Philo


