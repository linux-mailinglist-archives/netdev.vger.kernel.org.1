Return-Path: <netdev+bounces-249128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB28D14AA4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9A030935CA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7232B3803FD;
	Mon, 12 Jan 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3tdV0YV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jhd2Aqry"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6D3803FC
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241050; cv=none; b=uKSJz/lY8FG45ox/w5uqkQitxvzMIi9c1ztBNPFZTeFMDquJoazfa0KjWuXXCILEQ7HTY35nxeie5udlKg5bKxJcdxoMAdkwwVCtHcpg7VrAjtGGhkgT1wlHzeYskdXAK44NefgM3hWqpNSNnqlewHRTFL4dy+jxGW5AGgHh9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241050; c=relaxed/simple;
	bh=Iavh03TY5rGjXb0qFvEJfW6qnYQtMHWYb1cCMI4+Vo4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kLuolK/68eGju2kkKGDADXcLhigIAr31IFU3tkmBzrXMgWmRgATFv0npgRhYN0AMIVa/mDb+kUhZsG30EGAg8bJrbj31P3mEaWkaI+PfAuDmdNTwuv865hcek+pwudklRc/VCfPAD2uCl0qS/edYnfXoj4t/Eb+tnzj5jDnW++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3tdV0YV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jhd2Aqry; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768241047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGMJ5LbPFmGC8KsyFzZBiUpjaLMx+kfqn+JlgSdWn4Q=;
	b=G3tdV0YVtqaZwU/JxwnYc7Pp5q1DkKKKOoXWkACh1xDZ4iPa5Rja7dfrzXZpzQl2L9rVdj
	4NLSAlA4bjuX9iXkgWRrTWuZL07GzrBLGwko3WiK5CSMf+sUE1zF7UeWmebqNAd3sNpqwn
	+FSTFuL6ASosclHEH11O69TSgcok4Kw=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-XRBpfJ80PAuwvvE0nuKMsA-1; Mon, 12 Jan 2026 13:04:05 -0500
X-MC-Unique: XRBpfJ80PAuwvvE0nuKMsA-1
X-Mimecast-MFC-AGG-ID: XRBpfJ80PAuwvvE0nuKMsA_1768241045
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5635d2bec8bso9103643e0c.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768241045; x=1768845845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nGMJ5LbPFmGC8KsyFzZBiUpjaLMx+kfqn+JlgSdWn4Q=;
        b=Jhd2Aqryx6Ox2MJbtXyvKBOpO43V8dczTEH0pP7Yh1mQFQJNTZUQUvOPahfuDbvpDw
         47KE+d/IK64MrNdI86dhLQkM6t6/cMoaPHWjpCtGcrBipKe7D9zTqQAtNwAZIFpDdzQ/
         2UxXz1F52L5SXl8QP6mzAaJ5i8j9/HMovFu3uAYs3d4Ps5reYCgMfsGHrJCkfZkcwXH6
         NBsQLjMk71ELOAnpTXLG6m0LNp1PdEDOms8b9dZ1iMTIoUfGp8DwCZJIeFic5UjAVRfx
         Ef+MMZXvlBOUxrBgw1qI2TI5B/SNx0LsE1yrDyts9JiVSbSncvqMFsJc0nDxwybhchfo
         HTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241045; x=1768845845;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGMJ5LbPFmGC8KsyFzZBiUpjaLMx+kfqn+JlgSdWn4Q=;
        b=i3TtEo7hZ/uKSUZv+34l75FIJmAYB353jzQHGS/ie9oUb71dO0pi7ljFwuwPDWj/xA
         7zY5TSnARLBgApIl3FMlMbC21Nxr8+AYMNnXEMXIF1KsiEmXL+6/MfwjMW1WOTYJgKjs
         ZoUU1hgcEDXWBoFW3wsXYoJ0NmLuevm/d9HWjo6ecSUoVz+jEWVB5x/288laIJZVfg/W
         SGgzV3vycfq6Y6MjAdfc2RzTk0rpplE7OhevO08a78WPVs01aUI9+sLvqM+LhJWnlQ4x
         cnsigfBZB5GVhrKbRduGUlyveE3k54Uk7HOUAJDKaNo6TNOS+agBbynyxlUEPxn8IjF2
         pyig==
X-Forwarded-Encrypted: i=1; AJvYcCWdVt+TfC3bL8Gxt//e0qRIMGRDHxQGf6uRtUix9KuJy7P7+/rLVzs1yfnEL4qJXaV3t8HWT0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabXR8yJZLqJ1VVDZa+q2hgT5pWrMwnoh2K9hFCFajvnMRaTW6
	CjKknzid412aOTHHKxm3JEqeV08xx4HSNFOSTRrKeUTaZmdt+RzY5BmN5THvePDBHvz9P/4NM8w
	d/gdU2+BeiVViiO93vIVKAn4Rga1Ky7nyfvpnbndV6VrZGDW/01Mqh4Aehg==
X-Gm-Gg: AY/fxX5kCy+fs1/H+vbeJs+XahZKDu8b5HTFP1JNCq5RgBW371H2AJN53ycdfhhcU/w
	+W1HdttoNKoAeSY0KokedM0A649B2qiKUoUZuEzPvYT9Sl8O8LIoe6bglMi4ZaqSYNIYEEJDikt
	NNkjH2suHnPXPj//8ynPEII4QFGpUJm6YpFbED2ywnx8NHKM2DOFAYNR+Nfkcr8II2FvfAuxki7
	o8MGoDT/a0ozDZ6yacZUcJuHYD6Mnvd/8AIkX8olu7qBuLJzx/DUGT521bDO9hNScuqugGFARFG
	T0GbxPergkP90rFrpRKgYZJoqVf0U9vJ3TgCRloIsYaE3ekfFKVhHOnyABjBeIAPUV0SWIKOMRU
	gAHh/sJl5UUBKwCVw2oI5zfMeBPXeotJ5u7W55qyfXgN/h0RrXOifxx78
X-Received: by 2002:a05:6122:4897:b0:563:7886:5e7a with SMTP id 71dfb90a1353d-563788663a0mr2842022e0c.9.1768241044907;
        Mon, 12 Jan 2026 10:04:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM6+Ba4s/MEV+9Zbgj4Jf91uX/qo/VCXWtL6yFKP9LvZ7kJD7E9gBdpreY2pV75Zsq8xOxKw==
X-Received: by 2002:a05:6122:4897:b0:563:7886:5e7a with SMTP id 71dfb90a1353d-563788663a0mr2841898e0c.9.1768241043068;
        Mon, 12 Jan 2026 10:04:03 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563667cf148sm10043559e0c.2.2026.01.12.10.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 10:04:02 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c1cac1a6-22fe-479f-bfc5-89a5d3aabda5@redhat.com>
Date: Mon, 12 Jan 2026 13:03:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
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
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-6-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20260101221359.22298-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>   include/linux/sched/isolation.h | 4 ++++
>   kernel/sched/isolation.c        | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..c7cf6934489c 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,8 +7,12 @@
>   #include <linux/tick.h>
>   
>   enum hk_type {
> +	/* Inverse of boot-time isolcpus= argument */
> +	HK_TYPE_DOMAIN_BOOT,
>   	HK_TYPE_DOMAIN,
> +	/* Inverse of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
> +	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
>   	HK_TYPE_KERNEL_NOISE,
>   	HK_TYPE_MAX,
>   
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 3ad0d6df6a0a..11a623fa6320 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -11,6 +11,7 @@
>   #include "sched.h"
>   
>   enum hk_flags {
> +	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
>   	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
>   	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
>   	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> @@ -239,7 +240,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>   
>   		if (!strncmp(str, "domain,", 7)) {
>   			str += 7;
> -			flags |= HK_FLAG_DOMAIN;
> +			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>   			continue;
>   		}
>   
> @@ -269,7 +270,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>   
>   	/* Default behaviour for isolcpus without flags */
>   	if (!flags)
> -		flags |= HK_FLAG_DOMAIN;
> +		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>   
>   	return housekeeping_setup(str, flags);
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


