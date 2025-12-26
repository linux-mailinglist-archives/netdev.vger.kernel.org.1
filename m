Return-Path: <netdev+bounces-246103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22BCDF151
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 23:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5404C3006A78
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5872DD60F;
	Fri, 26 Dec 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0pJk+UB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jZnPWdDm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F319F11B
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787425; cv=none; b=ZeUM63LXXF4KrTkqMQeO9OnzyOWkpABycP8P1QKHn4RXG1plKDMboMHcc3pBkzuPs8qpPaR9uJCxeXoQmzPTcO/7HuiPVr7zIJOUs7EY2m5SDSb++0pqWIOpEE+v3WkSdgwLsF59TrAwYGcroLKqUjHLRekZERYgQGMclItM/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787425; c=relaxed/simple;
	bh=K7jrXMCamOjh0o8gNLafIFaofRuPpjA5ujgvXl1Ddrs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hjmjrt30ArV9fm3a8FOw47G0a/5enBrq0K4CRe73V3w7cyw2pE6PRYCrEDnPNsI71L8p7BnPdy/N+ybsDT0BI4LiWzaYz/bu4CRKHqaFMsCLeH1li+0DHbtKah9nzn1nii8o2PCwY39e1QiPuYTJ1dhRf+LcngAar/UAPCZznx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0pJk+UB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jZnPWdDm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb98MWMdlEGo36TvwfyminxMDlqaYbAnnXftxbdSDi0=;
	b=d0pJk+UBil7d0TNuXgVSAFqSsz1UkHMD+fhnWvxd2VU79CI/VKTpCKYpMJH7xiQIxokCt4
	Xq5M636MDoPCsC6InRJb/TvcbKzvuZgdCgyBjddreTDCZ9A/Q8SA3mcw3xbn0lKhC1vf8X
	wr7P3l0c7OCIGk2JfW3LtoyTLBDpJAY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-O-Ozj1NPNCyGmg2dSWQL7A-1; Fri, 26 Dec 2025 17:16:59 -0500
X-MC-Unique: O-Ozj1NPNCyGmg2dSWQL7A-1
X-Mimecast-MFC-AGG-ID: O-Ozj1NPNCyGmg2dSWQL7A_1766787419
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee1b7293e7so269875311cf.0
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787419; x=1767392219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gb98MWMdlEGo36TvwfyminxMDlqaYbAnnXftxbdSDi0=;
        b=jZnPWdDmBeHLIjSB7h2/OdxQx/d2Cxydu0/9C8QTALGQcDT2AYZEdOSXBcP5WAKnUB
         CdfeBH7kvPmwrL4MvrojWpFB37z4tmCCncerf/KILZa4R2kY7baUSvSunLoC6uQAmWKb
         jECC3PYtRfh7Y7uluo3z0riiK1MMYMgj8+Ro+ba3r93f389pDzBfIKUTUNZtB5el4GNs
         R2DrDSA6BNtd0cd1bKRnYJC23muYBiPlhgICpmR/iTAzc2U5dX/fZW1kZFmcg/Ic98Ax
         q/MVQdJMPCo764auu+8uy+Uhy9rePrkh4UB5HcCaTf00pd0eXMJ0UB0/tUzUQByEvjBo
         bFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787419; x=1767392219;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb98MWMdlEGo36TvwfyminxMDlqaYbAnnXftxbdSDi0=;
        b=rJaGagCHTlfXtY8fbFZ8lTENVjs6XeREBwrCXyuiEKM16epsdJoKhD8CoepEsUDOaW
         Hlfrg7tQ4tZU489jpN4gkrNlbOx2OHOhsu50f1uYjpIzPqybs/5ckHCOLOepUZW99dt9
         XgsptWIb+2HTrz3dkr2UZ+1kxMouD78Axq+Vpau346lTEDCIp4N5VbPy6yVn9mUi+43k
         3cGPVUp3Xhybzvhwow2Kz97+A3Lk3XSUgAkosCHyagFG84DYksPANVUUvWRrYtGifzHs
         8+Q0ut4kjfiImp9pOZzotIZ5if0ZZWEStTWqO3bQpqEIuxOQOufZ1whS+1ONCOM9D0i1
         Mi4A==
X-Forwarded-Encrypted: i=1; AJvYcCX00KCtzRj2aC8Lt8Frnlw30LiiZ9D+5TztiVzULBH0aEH+YJQopSc41f57AiBTl6QsZWSVGj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUPJh9KqHETYquSlBJDBUhiEtD8tzB6muhqSgWCyuTGLrMkf5
	9LGr+U5Qht2l1LJpcvVujo/YIyyehQXR6sW0ATPtbsq4pmA/m5e2t7fBtng3VaXGgoPpJXV72OP
	+agy0dzEzZOc7jpKqU7WJwXvusCSve8wuCgyQAHOKAdi30/LUtnQ9+KvIDA==
X-Gm-Gg: AY/fxX5FHtWZjK49hsDikFUfdFPZPTw/cGXwMQi7bCZJJLzTsoaEduxLDd8yKinYLMG
	1ZkpO/shHDU935YZQrK/vfyUv97gSUvRObknDdcgYaqZAg+k4EyBHhWHpVjo5UDjdfKLI3eM+/L
	/37OgxTXpDnkoz7mdexZQGwf29acTxhmiv/j9UgqaPReHfNfeu+JC3HyGSLUAoK0PG3Mt9jA9eC
	XqwQ/WajSykiGlrALc7G0spkDF7BINjc3n2SBvoMp5P5uOoiQDchBxTAVXQMwkgXECwrWG8l6qo
	vyWSHYRKMIpJdztwFQ0wvX2PQ95YTy4GFO53Tp8Vny9ElWr3EfD+AWgh/MC83rdTnmmvePjPY4W
	RCXHO2D8M7FPSdT/w1F+yXLWudhODpH404VLP/P3l8fwgyS3eF39kEs4Z
X-Received: by 2002:a05:622a:cc:b0:4f0:22df:9afe with SMTP id d75a77b69052e-4f4abd801f1mr367336511cf.51.1766787419326;
        Fri, 26 Dec 2025 14:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRvuLHSyqUpCT4r+1J8I9GjzOXah9qpvn8vbYEiTnx2y0sMdtY9oMwdnxWWZ/KZalKRQ1OSQ==
X-Received: by 2002:a05:622a:cc:b0:4f0:22df:9afe with SMTP id d75a77b69052e-4f4abd801f1mr367336221cf.51.1766787418961;
        Fri, 26 Dec 2025 14:16:58 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac54adb9sm164334711cf.10.2025.12.26.14.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:16:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <46a613e8-cf5b-4fbc-9299-48ab1a6f347b@redhat.com>
Date: Fri, 26 Dec 2025 17:16:54 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] kthread: Rely on HK_TYPE_DOMAIN for preferred
 affinity management
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-28-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-28-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> Unbound kthreads want to run neither on nohz_full CPUs nor on domain
> isolated CPUs. And since nohz_full implies domain isolation, checking
> the latter is enough to verify both.
>
> Therefore exclude kthreads from domain isolation.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 85ccf5bb17c9..968fa5868d21 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -362,18 +362,20 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
>   {
>   	const struct cpumask *pref;
>   
> +	guard(rcu)();
> +
>   	if (kthread->preferred_affinity) {
>   		pref = kthread->preferred_affinity;
>   	} else {
>   		if (kthread->node == NUMA_NO_NODE)
> -			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
> +			pref = housekeeping_cpumask(HK_TYPE_DOMAIN);
>   		else
>   			pref = cpumask_of_node(kthread->node);
>   	}
>   
> -	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
> +	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   	if (cpumask_empty(cpumask))
> -		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_KTHREAD));
> +		cpumask_copy(cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   }
>   
>   static void kthread_affine_node(void)
Reviewed-by: Waiman Long <longman@redhat.com>


