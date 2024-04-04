Return-Path: <netdev+bounces-84777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CFC8984F5
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E971F23708
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526F76035;
	Thu,  4 Apr 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IwhsQb2P"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E55D734;
	Thu,  4 Apr 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226450; cv=none; b=LZ3E+AoEIXnzo+hwkmDRaCGGHsUp8asU5XRJ+01EYuU00VhsAZ4ArkiNtddeBemyPUCjTedpD/QeT1K86/PNe4WPqqPQdAQn5KhG43EVHSdcHD5IIF9WSX5X0J1S6r7dunlLJrSqNg1gbSSDWvMo9uchQpZcmUQDQi/XZIzSc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226450; c=relaxed/simple;
	bh=ryU2IkP4OWePjNg0hnaelrT7lyEeM4tcB4zAcpA0qN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Blj9kdqZ6d4zXQ0oly0NGj63Cz2obmHv6Eut6AYPqlH+b24Zltz0sj6WD4J/xcyJrKu6fcy6TvyoymCRjTVcCwbT7WQarry+A/DWyUC0aiKSQA153Hw3DWYi1i5eEIYNeUV7759xiO2zHIyoz6h1ApN3+lzLWM008hJcUE5eCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IwhsQb2P; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712226438; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OYa6vtv11IJHbKUa9Rgq5qOFn0SiPGCaPskyGuje160=;
	b=IwhsQb2P6J7W3xVYdsI6cKmiu6xg2Owc5HzWRHmJOpPD+agc0i3ZXhfquSSaHBH8PiF9XE+uci/C+bktSjs55p9vN21AhSRdsmn5PKY3K6hAL7x96sC6q1nKpaGOD85JEHKTPTphdpy0ZapYfcmIneHv7yHkKUbvMV4dpLvww7s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W3uBuFf_1712226435;
Received: from 30.39.185.155(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3uBuFf_1712226435)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 18:27:17 +0800
Message-ID: <ba524e7f-beeb-49fa-a7c7-eeeedceb1c3c@linux.alibaba.com>
Date: Thu, 4 Apr 2024 18:27:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Gerd Bayer <gbayer@linux.ibm.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <ae3ea4bc-4a9c-416e-a593-2885fea96ae5@linux.alibaba.com>
 <27deaa5dbb30c467fcdaa0667ef39da86bcee03f.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <27deaa5dbb30c467fcdaa0667ef39da86bcee03f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/3 19:10, Gerd Bayer wrote:
> On Wed, 2024-04-03 at 14:35 +0800, Wen Gu wrote:
>>
>>
>> On 2024/3/24 21:55, Wen Gu wrote:
>>> This patch set acts as the second part of the new version of [1]
>>> (The first
>>> part can be referred from [2]), the updated things of this version
>>> are listed
>>> at the end.
>>
>>> Change log:
>>>
>>> RFC v5->RFC v4:
>>> - Patch #2: minor changes in description of config SMC_LO and
>>> comments.
>>> - Patch #10: minor changes in comments and
>>> if(smc_ism_support_dmb_nocopy())
>>>     check in smcd_cdc_msg_send().
>>> - Patch #3: change smc_lo_generate_id() to smc_lo_generate_ids()
>>> and SMC_LO_CHID
>>>     to SMC_LO_RESERVED_CHID.
>>> - Patch #5: memcpy while holding the ldev->dmb_ht_lock.
>>> - Some expression changes in commit logs.
>>>
>>
>> Hi, Jan. Do you have any comments on this version and should I post a
>> new patch series without 'RFC'? Thank you.
> 
> Hi Wen,
> 
> Jan has been out sick for a little while now, and Wenjia is expected
> back from a longer vacation tomorrow. So if you could hold off until
> begin of next week, Wenjia might have some more feedback.
> 
> In the meantime, I'm looking at your patchset...
> 
> Thank you, Gerd
> 

Hi Gerd,

Thank you for the information and comments! I guess I will post a new
version at the beginning of next week.

Thanks!

