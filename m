Return-Path: <netdev+bounces-281403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFqTL32K72kPCgEAu9opvQ
	(envelope-from <netdev+bounces-281403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:10:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BFA47608D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7442303AEF3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDDE348860;
	Mon, 27 Apr 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="kmnqlfzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FD345738
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305715; cv=none; b=rtdX8kiBjskqnWkFu6iasgG+Fal3ivpoi/rixnACwqgjJUFSUg9nIMDf93qjooU1GrQ/DMlqv/1XfMfBM6TqmnNxla0GzYrPy7a71aDKN6C7h0jzmgdVXksiLMkAfQ6FHbWwAj8wvWoq7gvijtN/brhmzk43RZG5tROPu3Q324U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305715; c=relaxed/simple;
	bh=3nI4jh0qSpjXgDdJgMsEeE+LnWsU7E6SKeCla5t9yI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkpbdQHEgNP3MAibyXKLBV+QlVFi5fOpl/Q+BnnGnc9iRrlrUHgIE7Z5KOL1Ihozg7tLcXTooQg/Szcbu2SeMrV7uAlwjURqgZkfrMImjF5JqfQDjTN6BJb5X0YARgEJHIls7Gqv0YxfQJ7q1VuQSRSOgslxsn51BIkOzXIZK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=kmnqlfzT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b150559bso82928805e9.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1777305712; x=1777910512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUIn/GeHnKQMX3ItFkglQNbpq/QxkRY25o0nGMIbjjc=;
        b=kmnqlfzT+VLa4gehYeZswkCKagxg08sH8GjJYZl2/2/P1VC3/8sMxqAT8tyWytFdp/
         gujNcseGsm4It1DG1yAtSZbt0fAExk07ewBTz0BDE3j/au0wHaRWWCUUesoCh4Nn7gOb
         5+20SiBbryxZ2gYymMKFbEGYq4CZy8nhDYqSFiQzUdLBcdiAv1WjLJ7sCHIF+mlQnBKZ
         hZv9RqMX1bJvPshZXlOChFYQ7DPMThWEvQSYBr/n8df7hpo3L2jcDHbAhUVfscbX0mF7
         33y6L63pADVRMkSZenN80mt6DlUoqZOQj1weSbI3Dc7prHxkrs7US46qS62iXrZaw3mm
         cNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777305712; x=1777910512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUIn/GeHnKQMX3ItFkglQNbpq/QxkRY25o0nGMIbjjc=;
        b=CQTimFKJq7Lol5nKmdZUC7KYZ7OpGY2bvwvrEw+eyvXww6XUQO26Yxiczc6/9BSWOA
         uBIn7DSepXOfUllQ3BsUvdx9q3hsFzhZgOYMOS5fa3/frPw/Tz8q7AqyNtuJEfRmNEab
         krkw/tk6G3aV3Y4IehlGlNKFsDmrk4C2DDcvmE635EbajxqLdpngTif4EhtSvmUBzHVU
         zrh+ttiBnVVm2O2MFtgtUDSpL4j5CFB6l1q3RbCdJxUifFkKuRp+DH+DDAsLW4shx1yt
         HjFb9IqaPoG5CKpkVq6LikjHRI2XfYDP9sxKV9owYSXAocXz8VTA+npwhzRHaH8oGnp7
         Jy7w==
X-Forwarded-Encrypted: i=1; AFNElJ9lpBOalX6lbtj2UX2ZyCHzRrbg9lp8gxTlYIcPD3DqBIdEUoeUbYUF6f96sSZxp8d38mVN8GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEEtwj0mUyv8Was3jUCpxNzSjkr9KSpaYtSFymN32mxNi8Z2K
	FmgihwMKvznHA06gGIoASd5+dhS63yQZFOw6UwrygvimVi/eu3Ok5tAPdcQahN7bG2k=
X-Gm-Gg: AeBDieu6TD0uPzs0EwV2UJpAJNQ/eaP8rIBK50JZiJlor9rZdwUUzhLRgN7oCRBOycE
	+03oZTlVZKARGEiC8Fu/MGWk+y4kdW/e6vJmM64A9LgueDEEug94TwKLuZHWoByt0HR5Ow9Qp39
	fETP4OOhCdD9DvaNg5K0k+2Qhj3UZYkYvHwk0oi2o6HWjF8Enib7PKutSwVsVM8/UAlfuHTneTC
	7FqRxEPXstzqSLqz19ujQ0vknrWxpPlQJH5ES0kCfARQw6LX/IhhWPuiAvytGwhRvHnxLcmiJps
	17R7kz3+OZifaw7Epz6r3rNCOzpYW/YeNLK6b1ox8jZqOGWlKheuUUPfsK5d67u3eFe03q4tf4K
	frJtAhHgKT7pcQNg5laA7y72DYl4gGj7UNDLv5vPByPYjnrkXeqSd6gn6Zxy2671gJU5r5P8Zvm
	0uF9Iyt50ClPlyfBwS2fxbicdXpB7x68GWNVvi9laTjo6gWBXfIy2MkHiivO8OjFeWf3SO3LT0W
	SKCeuV7PMnYRRT2isd4GfAUYhdMTkWSg+SA
X-Received: by 2002:a05:600c:6216:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a76f53b01mr8705e9.11.1777305711990;
        Mon, 27 Apr 2026 09:01:51 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:142d:11f2:435b:9d94? ([2620:10d:c092:500::7:64e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a59816b71sm230488865e9.1.2026.04.27.09.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 09:01:51 -0700 (PDT)
Message-ID: <5d5f74ae-602e-4380-b4d3-442b4dc2ceb4@davidwei.uk>
Date: Mon, 27 Apr 2026 17:01:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kuba@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org> <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
 <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
 <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59BFA47608D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 2026-04-25 01:05, Dipayaan Roy wrote:
> On Fri, Apr 24, 2026 at 01:05:24PM -0700, David Wei wrote:
>> On 2026-04-23 05:48, Dipayaan Roy wrote:
>>> On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
>>>> On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
>>>>> I still see roughly a 5% overhead from the atomic refcount operation
>>>>> itself, but on that platform there is no throughput drop when using
>>>>> page fragments versus full-page mode.
>>>>
>>>> That seems to contradict your claim that it's a problem with a specific
>>>> platform.. Since we're in the merge window I asked David Wei to try to
>>>> experiment with disabling page fragmentation on the ARM64 platforms we
>>>> have at Meta. If it repros we should use the generic rx-buf-len
>>>> ringparam because more NICs may want to implement this strategy.
>>>
>>> Hi Jakub,
>>>
>>> Thanks. I think I was not precise enough in my previous reply.
>>>
>>> What I meant is that the atomic refcount cost itself does not appear to
>>> be unique to the affected platform. I see a similar ~5% overhead on
>>> another ARM64 platformi (different vendor) as well. However, on that platform
>>> there is no throughput delta between fragment mode and full-page mode; both reach
>>> line rate.
>>>
>>> On the affected platform, fragment mode shows an additional ~15%
>>> throughput drop versus full-page mode. So the current data suggests that
>>> the atomic overhead is common, but the throughput regression is not
>>> explained by that overhead alone and likely depends on an additional
>>> platform-specific factor.
>>>
>>> Separately, the hardware team collected PCIe traces on the affected
>>> platform and reported stalls in the fragment-mode case that are not seen
>>> in full-page mode. They are still investigating the root cause, but
>>> their current hypothesis is that this is related to that platform’s
>>> PCIe/root-port microarchitecture rather than to page_pool refcounting
>>> alone.
>>>
>>> That said, I agree the right direction depends on whether this
>>> reproduces on other ARM64 platforms. If David is able to reproduce the
>>> same behavior, then using the generic rx-buf-len ringparam sounds like
>>> the better direction.
>>>
>>> Please let me know what David finds, and I can rework the patch
>>> accordingly.
>>
>> I ran a test on Grace, 4 KB pages, 72 cores, 1 NUMA node.
>>
>> Broadcom NIC, bnxt driver, 50 Gbps bandwidth. Hacked it up to either
>> give me 1 or 2 frags per page. No agg ring, no HDS, no HW GRO.
>>
>> Use 1 combined queue only for the server. Affinitized its net rx softirq
>> to run on core 4.
>>
>> Ran iperf3 server, taskset onto cpu cores 32-47. The iperf3 client is
>> running on a host w/ same hw in the same region. Using 32 queues, no
>> softirq affinities. The idea is to hammer page->pp_ref_count from
>> different cores.
>>
>> * 1 frag/page  -> 32.3 Gbps
>> * 2 frags/page -> 36.0 Gbps
>>
>> Comparing perf, for 2 frags/page the cost of skb_release_data() hitting
>> pp_ref_count goes up, as expected. Is this what you see? When you say
>> there's a +5% overhead, what function?
>>
>> Overall tput is higher with multiple frags. That's to be expected w/
>> page pool.
> 
> Hi David,
> 
> Thanks for running this. Your results are consistent with mine.
> 
> I have tested this on 2 ARM64 platforms from different vendors,
> running ntttcp and iperf3 using 4k as base page size.
> In my observation I see both platforms show a 5% overhead in
> napi_pp_put_page (~3.9%) and page_pool_alloc_frag_netmem (~1.9%)
> when running in fragment mode, both stalling on the LSE ldaddal
> atomic that maintains pp_ref_count.
> This seems to be same as your observation as well. However in my
> observation one of the platform shows 15% drop in throughput when
> in fragment mode vs page mode. The other platform I ran the test on
> infact performs slighty better in fragment mode than in full page
> mode (simillar observation as yours).

That's not what I observe. I don't see napi_pp_put_page at all, and
page_pool_alloc_frag_netmem is actually lower with 2 frags/page (4.06%)
than 1 frag/page (5.73%).

The main difference is in skb_release_data which goes from
0.85% (1 frag/page) to 3.32% (2 frags/page).

> 
> So the atomic refcount overhead appears to be common across ARM64
> platforms, but it does not cause a throughput regression.
> The throughput regression seems specific to one platform only for which
> we want to have the full page work around, also the HW team has
> identified PCIe stalls in fragment mode that are absent in full-page mode.
> Their investigation points to a suspected microarchitectural
> issue in the PCIe root port. IMO, there seems to be no issue with
> page_pool itself.
> 
> Given that:
>   - Grace shows fragments are faster (your data)
>   - A second ARM64 platform shows no regression (my data)
>   - Only the affected platform shows a throughput drop
>   - The HW team suspects this to a platform-specific PCIe issue,
>     also form our experiment data the drop in throughput seems to
>     be platform specific only.
> 
> I believe this remains a platform-specific workaround rather than
> a generic issue. Would a private flag still be acceptable for this
> case?
> 
> 
>>
>> There are some 200 Gbps NICs but they're mlx5 so I'd have to redo the
>> driver hack. Are you going to re-implement this change with rx-buf-len
>> instead of a private flag? If so, I won't spend more time running this
>> test.
>>
> I can go either way depending on what Jakub prefers.
> Hi Jakub,
> with this new data from David, is it convincing enough for a mana driver
> specific private flag, which can be set from user space by a udev rule
> by detecting the underlying platform? If not then I will send the next
> version with the other rxbuflen approach.
>>>
>>>
>>> Regards
>>> Dipayaan Roy
> 
> 
> Thanks and Regards
> Dipayaan Roy

