Return-Path: <netdev+bounces-247061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35933CF3FC2
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C58073010D61
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC9333739;
	Mon,  5 Jan 2026 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE0GDLa2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyfJUffD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264CC330673
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621370; cv=none; b=ra7xjBeC5UgRFLpSqDT7P/sUdh8/1JoKaeuwUqssazgLjvWhUJiwn6ebDEZ7K+QdRCgPYpBwzZaWg/jS2p4hIQptzAIcsWLVTwDQXjFrKa5pkaxnXeI+ibwkCv6BkDtX9X0UEVNLoh6xYVYcgU2wSH6VAOeKsNdY0V6+uvJM9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621370; c=relaxed/simple;
	bh=2AXve2RVv3Fx6YOvospEYEqh4Y9K3EooVWW06ml7JoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSGUio13P02loKvoNYugLnTh2lURtxmw/bdAAp4e3k6fWRz0NAZM30pZ/tjBLdlP5cK6BPp29YRodH/7cX5UMK0MhI8zbRXELgoF3156I7eJo5hUYDDSw6ta6bpZxeyx/8UX09d2mEQOqyAHM8LoMLffXUdPxB1zreAyzsLmkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE0GDLa2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyfJUffD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767621364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4zxKV5KisOZLklnIhqPWg8+R5Qnw1OvgpHfGWe2u6k=;
	b=PE0GDLa2rMNgDDc9Pg34ZbyEPIDgxi5ca6FVVJdFdKbjsNHblk+GBfZCBox0EwtIXc1DE+
	mG0kB4Q7nQpmGz2eFZV5cLH/x7p+C+AEk8ObnREQJoPN9zVqKuGffDGhHQbNftVZtKE+1U
	9XNthiBGYSYljEa/5/6ddPV7QtGR/rs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-qQuTlIpDNyGIGgakkMmJZQ-1; Mon, 05 Jan 2026 08:56:03 -0500
X-MC-Unique: qQuTlIpDNyGIGgakkMmJZQ-1
X-Mimecast-MFC-AGG-ID: qQuTlIpDNyGIGgakkMmJZQ_1767621362
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47a97b719ccso84391675e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 05:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767621362; x=1768226162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4zxKV5KisOZLklnIhqPWg8+R5Qnw1OvgpHfGWe2u6k=;
        b=gyfJUffDFt5mae0t85GIAmi87ApazsnpkkbLhJNmUnBvWWrJeFcqINDzCs+3IF1YmV
         MIim5WoAY2QJ03r4k/5bZttR0XwbNoyk6EySm592atFJfsG/RqJgisSYlB6BdPD/CX4Z
         E+UCTn6pvWtjwP8mh645le6ucE9xgH+3RhXCRnTWIHPCGsZ2Ce6mhoEi3ySrqoLSm8yB
         nzqQl73ZEI13u9mGo2gc4vhH0vMsiSfWojE14wy69vbAbyPbgdH1FiQEYCZADav6f1Kj
         AkG18Wz/58xvBCgLvKtC16fbHRbdyJbQwYHZ3O1IO/X78D6cCTLPVnId/oigQAJ5L2UR
         1uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767621362; x=1768226162;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4zxKV5KisOZLklnIhqPWg8+R5Qnw1OvgpHfGWe2u6k=;
        b=NdJITtS0OJ9sTvS+8fXGIY3A2FGwAEyCU/YxyIVe+SNP4O93PnGvjXgoLgbDuql1wl
         F7c9eV31LP39+eJ/GYjjDhNc/KVwO0HlIQVyonEkv8PdiNzizg2Rj1Pe2+Sa0Kq+iMFr
         zubqtLx8ndT/f6AeHbOMsOQoA8CkStPlRebR1bPPdgxYoQsvz4t4KFv6K5SyB8c97QvY
         SaWRsal8LirBeB5s5gun5j/pJr7siono/1xSbubK/CPNFLTn6dbKJ+fzsGeDRGCBjF08
         QOTglolJNkc1yiuFZAmScKBB40TJD6EL3icRYV5IDN4r2km5A12ArkPvV/R4OwEgClED
         emgA==
X-Forwarded-Encrypted: i=1; AJvYcCU/UpDpykLLoF1SRmy7FQAxxncZs8HP4V+uqh0Bak+lRVgpAgc0E758afuU7L8nXxDEhNNv/qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynhzwR/Z+MZ+euDYRGgDXl0qTHFAj2G+brXtZeIvqB4wNkcvtt
	0oa955yX2Uo4iMTGzo5pStAErychj0YptjyEUimoLxehSMHaPehmnWqdtfWFphZzCCi9xHYWZbt
	j51JPcXmGK4tExRqXVYOeeTkeYX0mI4lXPaJuys77R39jstuONAEmVo8e
X-Gm-Gg: AY/fxX4mVvNto88SWEL+hrJ+8WH2Epe+6UbZx6dlrDkHpSHrzRL0nHBNAKDH/2fxL1J
	Ukzm6QampKrSHY+n+38EjvCnweFnYx+2v3VfpacFV2mY5FrORaubo+HLxUp2+DzCCqo12iidYST
	lma7EP4XrA2bXt8Jwmmrza8+JwHhoNR2Xh5qJd3yRQSJflUfB78VWA37gXTj0+DfSjJb1FqnhuG
	AJ21LIamfznpFADB4zbn+WxB8/H8wFGPtrp3Z/ufbTmBcnIXIMeLB80YeDPt3eqXHG3uzk9c914
	6rkQWzeZT8rFryHY4hGzdGbe4y/xlzfU0fqAbq9KoTCYXsLbf1P5FYXRFeQyB5gl8njYHtuHnJu
	NsfzIMDoRQ/kj3c7A0DQe1lutEieFnA2UBRU7k8IOO/qD
X-Received: by 2002:a05:600c:4e8f:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-47d1957da79mr548081935e9.18.1767621362384;
        Mon, 05 Jan 2026 05:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwkc9xT5MvAHbAzqBog1JNIM9VFxAc64wmZIIOhWpWsIlDZ7Xk0cIs/gMJo0V9qDmhI+RJwA==
X-Received: by 2002:a05:600c:4e8f:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-47d1957da79mr548081655e9.18.1767621361932;
        Mon, 05 Jan 2026 05:56:01 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f57sm155098545e9.4.2026.01.05.05.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 05:56:01 -0800 (PST)
Message-ID: <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
Date: Mon, 5 Jan 2026 14:55:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/4] Use correct destructor kfunc types
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>
References: <20251126221724.897221-6-samitolvanen@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 23:17, Sami Tolvanen wrote:
> Hi folks,
> 
> While running BPF self-tests with CONFIG_CFI (Control Flow
> Integrity) enabled, I ran into a couple of failures in
> bpf_obj_free_fields() caused by type mismatches between the
> btf_dtor_kfunc_t function pointer type and the registered
> destructor functions.
> 
> It looks like we can't change the argument type for these
> functions to match btf_dtor_kfunc_t because the verifier doesn't
> like void pointer arguments for functions used in BPF programs,
> so this series fixes the issue by adding stubs with correct types
> to use as destructors for each instance of this I found in the
> kernel tree.
> 
> The last patch changes btf_check_dtor_kfuncs() to enforce the
> function type when CFI is enabled, so we don't end up registering
> destructors that panic the kernel.

Hi,

this seems to have slipped through the cracks so I'm bumping the thread.
It would be nice if we could merge this.

Thanks.
Viktor

> 
> Sami
> 
> ---
> v4:
> - Rebased on bpf-next/master.
> - Renamed CONFIG_CFI_CLANG to CONFIG_CFI.
> - Picked up Acked/Tested-by tags.
> 
> v3: https://lore.kernel.org/bpf/20250728202656.559071-6-samitolvanen@google.com/
> - Renamed the functions and went back to __bpf_kfunc based
>   on review feedback.
> 
> v2: https://lore.kernel.org/bpf/20250725214401.1475224-6-samitolvanen@google.com/
> - Annotated the stubs with CFI_NOSEAL to fix issues with IBT
>   sealing on x86.
> - Changed __bpf_kfunc to explicit __used __retain.
> 
> v1: https://lore.kernel.org/bpf/20250724223225.1481960-6-samitolvanen@google.com/
> 
> ---
> Sami Tolvanen (4):
>   bpf: crypto: Use the correct destructor kfunc type
>   bpf: net_sched: Use the correct destructor kfunc type
>   selftests/bpf: Use the correct destructor kfunc type
>   bpf, btf: Enforce destructor kfunc type with CFI
> 
>  kernel/bpf/btf.c                                     | 7 +++++++
>  kernel/bpf/crypto.c                                  | 8 +++++++-
>  net/sched/bpf_qdisc.c                                | 8 +++++++-
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
>  4 files changed, 28 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 688b745401ab16e2e1a3b504863f0a45fd345638


