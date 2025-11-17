Return-Path: <netdev+bounces-239221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC283C65F3B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 20:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 701CC4E544C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522282F2916;
	Mon, 17 Nov 2025 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SaZRkxyr"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7F2D0638
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407331; cv=none; b=qGKVvs6EicoKFprGP6q/G0VZBP6qPR88GrR+b7J0BOknIkwCB9GYwPJI0HV1LGS2PEyELrJ3KbNkEaAQgvu1macDEubSt6gMu46tfFAaR3N/RfDVnNEwY3Vk/1jjJbuFUXshM+qcZ8S0hSb5pb7I8UG2R/oAgyW/RT1nIYq0+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407331; c=relaxed/simple;
	bh=6OzAaa8iDws0lcwjqF+XKbYPhYhAfB1q4BqeCW3R5JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovBKYE1588kBX6ZIU73zhUobFzx9iKS1FU7CrlhX+wPmnXWn6bpDORBk2SL3SdzJk3TbAzZEu+XErM8IGtHBCQ5NskDf6GcHoq+gpEYfynh7QwP9yV//vwU5FO15NGMtZDJVZ/WhRV9SZmFtxqXCfpDQmDNliaRGkhYbZSEv/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SaZRkxyr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ebbf8915-1404-4d4f-9b5a-b2f3924ec43a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763407323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbe+9JyBXKDiB3Lmr5harb1LuYhqhGndoF1DwtiK2Wc=;
	b=SaZRkxyrfN0vRx6wzM50Jmklt08m7NIoAgk4YCVnJUPh9TNLat3ooxU+Jl+8namMz/jRw3
	VJ4rLD9/6dbgiVBuDVc0/BOG/3GTs90YdonudQiN7Je433jZ8w0ce8ySzUU01ywS26P+JY
	o6U7fvsAOJn7Qw7CkSk25glE4jkV04o=
Date: Mon, 17 Nov 2025 11:21:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/14/25 6:01 PM, Alexei Starovoitov wrote:
> On Fri, Nov 14, 2025 at 12:13 PM Amery Hung <ameryhung@gmail.com> wrote:
>>
>>
>> -       if (smap->bpf_ma) {
>> +       if (smap->use_kmalloc_nolock) {
>>                  rcu_barrier_tasks_trace();
>> -               if (!rcu_trace_implies_rcu_gp())
>> -                       rcu_barrier();
>> -               bpf_mem_alloc_destroy(&smap->selem_ma);
>> -               bpf_mem_alloc_destroy(&smap->storage_ma);
>> +               rcu_barrier();
> 
> Why unconditional rcu_barrier() ?
> It's implied in rcu_barrier_tasks_trace().
> What am I missing?

Amery probably can confirm. I think the bpf_obj_free_fields() may only need to
wait for a rcu gp without going through a rcu_tasks_trace gp and the tasks_trace
cb, so it needs to ensure all rcu callbacks has finished.

@@ -247,18 +231,11 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
  	}
  
  	if (reuse_now) {
-		/* reuse_now == true only happens when the storage owner
-		 * (e.g. task_struct) is being destructed or the map itself
-		 * is being destructed (ie map_free). In both cases,
-		 * no bpf prog can have a hold on the selem. It is
-		 * safe to unpin the uptrs and free the selem now.
-		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-		/* Instead of using the vanilla call_rcu(),
-		 * bpf_mem_cache_free will be able to reuse selem
-		 * immediately.
+		/*
+		 * While it is okay to call bpf_obj_free_fields() that unpins uptr when
+		 * reuse_now == true, keep it in bpf_selem_free_rcu() for simplicity.
  		 */
-		bpf_mem_cache_free(&smap->selem_ma, selem);
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
  		return;
  	}


Others lgtm also,

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

