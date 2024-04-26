Return-Path: <netdev+bounces-91797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D367E8B3F39
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611981F25375
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8516DED9;
	Fri, 26 Apr 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oOvXIabc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15316D9DF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156120; cv=none; b=mQR6ivd89N68ZFfRaDgmAm/1uEJcA2APUHyzqtaImqM0ed/eYTiyJDFKEClQGqYrMyEudDGQSvQ/j7Q1JUdrwjZj4HX6zmsOFep81H0Vr9s4+BeOShtG4kCbi8fULusB/OYv1PlXY5tHS6gMcQ1DzTFNZto9+iBSFlX31Bl5bxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156120; c=relaxed/simple;
	bh=faChdLL5XkkWwH0eCjLtQtfUevMjKcC2aKXpJ2qGG3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muAjN1LAG/pkOwewi+Sw7hDMLTX3hCfHt6E5KLu4zOAkLnyxhvRMOn6o6wwN2Hq3Pv4zPWTnMbPfJd3JK8OmEQ2xAcEUKYxPqHwwTCjqesm6jsm9eptP3Fp0pcnXznoeCAnCZgVkUsA/aLUwN4+QmmnWU4gQFCFWLZllEdNpkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oOvXIabc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QHpPhP023034;
	Fri, 26 Apr 2024 18:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=9H+VVYN0JGjzkNGUjBNWPptTuPyWVDN0E28eym/1eLc=;
 b=oOvXIabcUWkUuMxWnmSuk2ydP+yHbl3nODZyX0BnhXCt3j7Ds9k83IeepKHa+B3f0eA5
 NozL4fUR0aliFHv8x36Gyjj7X1pumbXOZOhJzLPfBfJMqvoNaV+L8hkykS4tX77Kqhg7
 7digOFBZMrCJIYSr14XLliRP8hzAStfnmAqc8FbKsItQiSBaU6D+kKJAF61/UlBqLhNq
 bJaAGaMIV/7bVlj0FcCj4V8/whEY/Ef3TCNx913jgsPfGoWtjXHYQQrtM3s9rahh9KZu
 B4xsj9qCp0QtBvmQDtC/pmSctinWv9DsZmLbCK5cXKUU42fVifcpQQQCeOCVB10iIxt3 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgw8g2u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 18:28:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QISYNe017070;
	Fri, 26 Apr 2024 18:28:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgw8g2r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 18:28:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43QFeoi7023065;
	Fri, 26 Apr 2024 18:26:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1ph6qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 18:26:03 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QIQ07G16057028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 18:26:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B615358060;
	Fri, 26 Apr 2024 18:26:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 735575803F;
	Fri, 26 Apr 2024 18:26:00 +0000 (GMT)
Received: from localhost (unknown [9.61.50.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 18:26:00 +0000 (GMT)
From: David J Wilder <dwilder@us.ibm.com>
To: edumazet@google.com
Cc: dwilder@linux.ibm.com, netdev@vger.kernel.org, pabeni@redhat.com,
        sd@queasysnail.net, wilder@us.ibm.com
Subject: Re: [RFC PATCH] net: skb: Increasing allocation in __napi_alloc_skb() to 2k when needed.
Date: Fri, 26 Apr 2024 11:25:59 -0700
Message-Id: <20240426182559.3836970-1-dwilder@us.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CANn89iKWA=LjMUtLOXUfzRMirYfBa+uAfNsfs_Mpq9z0ngGgmA@mail.gmail.com>
References: <CANn89iKWA=LjMUtLOXUfzRMirYfBa+uAfNsfs_Mpq9z0ngGgmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i9PzY2lSxBb-4z7eDSVzGSh4AFDANs7r
X-Proofpoint-ORIG-GUID: 1RauAGK-Xdm0r2EEgknKNuqoMd1bcOtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_15,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260126

On Wed, Apr 24, 2024 at 10:49 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
>>
>> 2024-04-23, 09:56:33 +0200, Paolo Abeni wrote:
>> > On Fri, 2024-04-19 at 15:23 -0700, David J Wilder wrote:
>> > > When testing CONFIG_MAX_SKB_FRAGS=45 on ppc64le and x86_64 I ran into a
>> > > couple of issues.
>> > >
>> > > __napi_alloc_skb() assumes its smallest fragment allocations will fit in
>> > > 1K. When CONFIG_MAX_SKB_FRAGS is increased this may no longer be true
>> > > resulting in __napi_alloc_skb() reverting to using page_frag_alloc().
>> > > This results in the return of the bug fixed in:
>> > > Commit 3226b158e67c ("net: avoid 32 x truesize under-estimation for
>> > > tiny skbs")
>> > >
>> > > That commit insured that "small skb head fragments are kmalloc backed,
>> > > so that other objects in the slab page can be reused instead of being held
>> > > as long as skbs are sitting in socket queues."
>> > >
>> > > On ppc64le the warning from napi_get_frags_check() is displayed when
>> > > CONFIG_MAX_SKB_FRAGS is set to 45. The purpose of the warning is to detect
>> > > when an increase of MAX_SKB_FRAGS has reintroduced the aforementioned bug.
>> > > Unfortunately on x86_64 this warning is not seen, even though it should be.
>> > > I found the warning was disabled by:
>> > > commit dbae2b062824 ("net: skb: introduce and use a single page frag
>> > > cache")
>> > >
>> > > This RFC patch to __napi_alloc_skb() determines if an skbuff allocation
>> > > with a head fragment of size GRO_MAX_HEAD will fit in a 1k allocation,
>> > > increasing the allocation to 2k if needed.
>> > >
>> > > I have functionally tested this patch, performance testing is still needed.
>> > >
>> > > TBD: Remove the limitation on 4k page size from the single page frag cache
>> > > allowing ppc64le (64K page size) to benefit from this change.
>> > >
>> > > TBD: I have not address the warning in napi_get_frags_check() on x86_64.
>> > > Will the warning still be needed once the other changes are completed?
>> >
>> >
>> > Thanks for the detailed analysis.
>> >
>> > As mentioned by Eric in commit
>> > bf9f1baa279f0758dc2297080360c5a616843927, it should be now possible to
>> > revert dbae2b062824 without incurring in performance regressions for
>> > the relevant use-case. I had that on my todo list since a lot of time,
>> > but I was unable to allocate time for that.
>> >
>> > I think such revert would be preferable. Would you be able to evaluate
>> > such option?

Thanks Paolo,  yes, I can evaluate removing dbae2b062824. 

>>
>> I don't think reverting dbae2b062824 would fix David's issue.
>>
>> The problem is that with MAX_SKB_FRAGS=45, skb_shared_info becomes
>> huge, so 1024 is not enough for those small packets, and we use a
>> pagefrag instead of kmalloc, which makes napi_get_frags_check unhappy.
>>
>
> 768 bytes is not huge ...
>
>> Even after reverting dbae2b062824, we would still go through the
>> pagefrag path and not __alloc_skb.
>>
>> What about something like this?  (boot-tested on x86 only, but I
>> disabled NAPI_HAS_SMALL_PAGE_FRAG. no perf testing at all.)
>>
>> -------- 8< --------
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index f85e6989c36c..88923b7b64fe 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -108,6 +108,8 @@ static struct kmem_cache *skbuff_ext_cache __ro_after_init;
>>  #define SKB_SMALL_HEAD_HEADROOM                                                \
>>         SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)
>>
>> +#define SKB_SMALL_HEAD_THRESHOLD (SKB_SMALL_HEAD_HEADROOM + NET_SKB_PAD + NET_IP_ALIGN)
>> +
>>  int sysctl_max_skb_frags __read_mostly = MAX_SKB_FRAGS;
>>  EXPORT_SYMBOL(sysctl_max_skb_frags);
>>
>> @@ -726,7 +728,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
>>         /* If requested length is either too small or too big,
>>          * we use kmalloc() for skb->head allocation.
>>          */
>> -       if (len <= SKB_WITH_OVERHEAD(1024) ||
>> +       if (len <= SKB_SMALL_HEAD_THRESHOLD ||
>>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
>>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
>>                 skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
>> @@ -802,7 +804,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
>>          * When the small frag allocator is available, prefer it over kmalloc
>>          * for small fragments
>>          */
>> -       if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) ||
>> +       if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_SMALL_HEAD_THRESHOLD) ||
>>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
>>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
>>                 skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
>> -------- 8< --------
>>
>> (__)napi_alloc_skb extends the GRO_MAX_HEAD size by NET_SKB_PAD +
>> NET_IP_ALIGN, so I added them here as well. Mainly this is reusing a
>> size that we know if big enough to fit a small header and whatever
>> size skb_shared_info is on the current build. Maybe this could be
>> max(SKB_WITH_OVERHEAD(1024), <...>) to preserve the current behavior
>> on MAX_SKB_FRAGS=17, since in that case
>> SKB_WITH_OVERHEAD(1024) > SKB_SMALL_HEAD_HEADROOM
>>
>>

Thanks for the suggestion Sabrina, I will incorporate it. 

> 
> Here we simply use
> 
> #define GRO_MAX_HEAD 192

Sorry Eric, where did 192 come from?

