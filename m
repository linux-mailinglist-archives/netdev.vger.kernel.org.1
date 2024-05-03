Return-Path: <netdev+bounces-93290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5238BAF02
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A472B20D65
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189A046BF;
	Fri,  3 May 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOYH9wpa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789BC57CB8
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746614; cv=none; b=rhhKgcdTdiy3ZxbBVAh0CWlkDo9Gc/8g3Rrr2Jd8VsrHZeVxCEBIq+0zT95xnp/L4CL4ppBtgJo8PESCe+kOofG51nEm6AiatbcXx5nC69m9hS25xMygYUlNuU3OfB2R+ZbR/MCb0sJzcc0jNrdWgmHCDBrZ393HV5mEuGie/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746614; c=relaxed/simple;
	bh=xLtXEDgEEga1kBde+15DEwEFjuiuSnjwz9eXNCO7l+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSt13yVfK1rK7gHnWLNcMWPOvX5G0JNn0yR/cCQx+OfwNWp8DgJUCfODT3fEi0IG0/XkJtGeNZcpdmGEodjcN43rSp6/k95wFgEVBl7JbNLJjN1zW1LsuABnP7FnlFfN0dPZBVyMPCmaREkTU2UJUOfN/wmyUr0Z2sVfnleCSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOYH9wpa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714746611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQyDPEWquSneZazAM7l5FC7MEA777Fbe13YTst9r4EA=;
	b=WOYH9wpa3i+nyotjVjjyFnjgE5Ud98Kypi4Hp9gZaI1Z/KfTiZWnkmsCX7hSosdUPyDHy0
	Qpod/cdGy6kuthtJsoqxk3IjqgV8DTEsbRfk9TlTuUo12EUAuyUsxKUEiFOyaKdMcvq9p+
	8Tm5Ckt4kYRuvy7KxvgTw5EsYhIgE4k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ICRn6dGgNDi-dtbBCnTnow-1; Fri, 03 May 2024 10:30:04 -0400
X-MC-Unique: ICRn6dGgNDi-dtbBCnTnow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 283148A9146;
	Fri,  3 May 2024 14:30:03 +0000 (UTC)
Received: from [10.22.34.156] (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F549C13FA4;
	Fri,  3 May 2024 14:30:02 +0000 (UTC)
Message-ID: <ca46435a-f67a-4d85-bf8d-b5d3289b6185@redhat.com>
Date: Fri, 3 May 2024 10:30:02 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
 yosryahmed@google.com
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com>
 <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
 <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
 <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


On 5/3/24 10:00, Jesper Dangaard Brouer wrote:
>> I may have mistakenly thinking the lock hold time refers to just the 
>> cpu_lock. Your reported times here are about the cgroup_rstat_lock. 
>> Right? If so, the numbers make sense to me.
>>
>
> True, my reported number here are about the cgroup_rstat_lock.
> Glad to hear, we are more aligned then 🙂
>
> Given I just got some prod machines online with this patch
> cgroup_rstat_cpu_lock tracepoints, I can give you some early results,
> about hold-time for the cgroup_rstat_cpu_lock.
>
> From this oneliner bpftrace commands:
>
>   sudo bpftrace -e '
>          tracepoint:cgroup:cgroup_rstat_cpu_lock_contended {
>            @start[tid]=nsecs; @cnt[probe]=count()}
>          tracepoint:cgroup:cgroup_rstat_cpu_locked {
>            $now=nsecs;
>            if (args->contended) {
>              @wait_per_cpu_ns=hist($now-@start[tid]); 
> delete(@start[tid]);}
>            @cnt[probe]=count(); @locked[tid]=$now}
>          tracepoint:cgroup:cgroup_rstat_cpu_unlock {
>            $now=nsecs;
>            @locked_per_cpu_ns=hist($now-@locked[tid]); 
> delete(@locked[tid]);
>            @cnt[probe]=count()}
>          interval:s:1 {time("%H:%M:%S "); print(@wait_per_cpu_ns);
>            print(@locked_per_cpu_ns); print(@cnt); clear(@cnt);}'
>
> Results from one 1 sec period:
>
> 13:39:55 @wait_per_cpu_ns:
> [512, 1K)              3 |      |
> [1K, 2K)              12 |@      |
> [2K, 4K)             390 
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4K, 8K)              70 |@@@@@@@@@      |
> [8K, 16K)             24 |@@@      |
> [16K, 32K)           183 |@@@@@@@@@@@@@@@@@@@@@@@@      |
> [32K, 64K)            11 |@      |
>
> @locked_per_cpu_ns:
> [256, 512)         75592 |@      |
> [512, 1K)        2537357 
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1K, 2K)          528615 |@@@@@@@@@@      |
> [2K, 4K)          168519 |@@@      |
> [4K, 8K)          162039 |@@@      |
> [8K, 16K)         100730 |@@      |
> [16K, 32K)         42276 |      |
> [32K, 64K)          1423 |      |
> [64K, 128K)           89 |      |
>
>  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_lock_contended]: 3 /sec
>  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_unlock]: 3200  /sec
>  @cnt[tracepoint:cgroup:cgroup_rstat_cpu_locked]: 3200  /sec
>
>
> So, we see "flush-code-path" per-CPU-holding @locked_per_cpu_ns isn't
> exceeding 128 usec.
>
> My latency requirements, to avoid RX-queue overflow, with 1024 slots,
> running at 25 Gbit/s, is 27.6 usec with small packets, and 500 usec
> (0.5ms) with MTU size packets.  This is very close to my latency
> requirements. 

Thanks for sharing the data.

This is more aligned with what I would have expected. Still, a high up 
to 128 usec is still on the high side. I remembered during my latency 
testing when I worked on cpu_lock latency patch, it was in the 2 digit 
range. Perhaps there are other sources of noise or the update list is 
really long. Anyway, it may be a bit hard to reach the 27.6 usec target 
for small packets.

Cheers,
Longman


