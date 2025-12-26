Return-Path: <netdev+bounces-246102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1ECDF141
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 23:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E546300CBBB
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8E1E520A;
	Fri, 26 Dec 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLlGyUwt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRhC2VIt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B045C0B
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787215; cv=none; b=aN5l1Gd0djYoCJkqW7IKNuP7DVGLtvJ4kL/VU8X4mHJSgGkdOyEvtKikEbV7++Ft18MQibtx+ohYytJ3Y/DlEPEFvGJ7IGpffoJgZL2BlYP7aoKel/c/OL9AYwPhXWO5eYpbEjrEv2QiWssRcL3Xbhy2VIIGRxtgiT24KdigSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787215; c=relaxed/simple;
	bh=38SETu3HZwoc8bpPyvY57PyJDti9cAF1uQy2Al3c77g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kr9acGCiO4NM4HEgyc4nfM6nRKGhh7d7FGwCHjttAHFkT6/RuqUiR9Upt2IG5aW6khbQDoEp3UVLyqg/HrPfdIP+trrb7q2/Che2PhZF03FlZ/5uz9ZGHU5LdkPlxi1YKSeVoj5+ENtDGse9hT5672llUX/TloXC5JrXVeoz6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLlGyUwt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRhC2VIt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
	b=RLlGyUwtYevISZY2BzXkC+HU2I13BJVJnZfdig3vmf1eRamCR6Z5+pBqr9wf1y5Gh76d8l
	uwjAfSZrC3YEokcCIZU7r+bV0UqYuQdTPhGNAe+phYMbNYerhjryR/wEpLw/JAvgPLwK24
	/1qDKqfSCVpV5gLipzIhB33e1BMKU+Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-gRcNWG5gMN-8eNRqgBPdoQ-1; Fri, 26 Dec 2025 17:13:31 -0500
X-MC-Unique: gRcNWG5gMN-8eNRqgBPdoQ-1
X-Mimecast-MFC-AGG-ID: gRcNWG5gMN-8eNRqgBPdoQ_1766787210
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a360b8086so182216546d6.3
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787210; x=1767392010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
        b=FRhC2VItRuJvOg2H7zCbbHgRrbqiQs7UhLao4Y5EJob/ZLXo7HRhCK0SFMQHx9oylD
         Et5xRRYE8wpnraa7C4PoZT79EZvfYkJlCpn7o+yGMGqQkQqS/Sd1uAfLsrcQpwp0Rdfj
         nHaNosZwd/L3bxQawUw66njcan+mTievdwuVyj966FFivyOzGn5UHw7h9avcAdnC2lA1
         a0qM2HhshEGXRGzm4/V6XEnhiwKBnSALZHK+HfFbAje8h9rFpjUsgqSXf6PG0pdKOMU9
         1l+EOVPwigSiRKDsy2rYt3bQ6a5v4aqnFDum2zbORqxcV7sqsOqQ7GbTByuAt8LSEPrW
         kb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787210; x=1767392010;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbQAbHkG6iNX6LkB+q4ATv+TKkhtMlH6KHEacyY50T0=;
        b=UAdYZ2WJPl1yIHfImsePBvo+7ZhSjKM58ZVaZTc7Q2OuaGlBPxCGworoxPyGWX2ODB
         MXPKgC9QBkg9F/3GsccWPQ+9WQCSbYqu3N8BcK2DVfDWzh4xLpnwXVlyWKEL5c7CGvOT
         yg90VeisoFPC/opd+FeCZ23m/uLT2Ltwiqvcjwgizi3dchSuIE+kjL96fEdyMV/T2pmo
         +z8DgCt7FHSSafHIy8S2R5PgGlmMVE6CZteas8d0VDQK40BVvLlf401pSQ87hVAcwCcK
         rD39EIDPh3KDVzPLsvnLKDjLe/PdtV1hbbjD+j/OIY1+Vz6LsMuPMkWKkLYfeRFw+T+l
         H/ag==
X-Forwarded-Encrypted: i=1; AJvYcCWsgvF/kD/VPeGefPGLWRSvKqvikfCIc7Xmlkrq+r7V8N69uJj7f6oNoq6TBu04rnh2sQ3xiwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvriMapztr5IUAcO5CUQ3z2spvTM/kwjefQKE89X5qR6pI+ney
	MrsZCUylmda9VezK/8SDK5MVedk49cXBlmewg9IqGa5Jc+TMIMoXWbE8oXSBf6miEG7y8pyvOil
	6dpsyXUIIryzkJoaVm2SeSgSnixI8NV8szi8+1AlIey/G7RpvapSHRxH+QQ==
X-Gm-Gg: AY/fxX745OX99E1Wh5UP+p70kCHMgKwKaG3aTBxM8IKkRvJz2y0vDntAek4Gc9HWn/d
	TM1I/PyBQFdtudZMZ+M3mUQ8IDUSzZQZLUqXxAs510p5Zht2F71MgH1bGrDC6hIJc4kRCu15Qu8
	obSo5rGeWVIarxSCmnmrwIj3oeCXTWo8fIR6kbS0Ittz3Vh7jm7UoEpu6zBFOBT6cyiysSMk+RZ
	KgOLN7Kk0MROUWZ483VYMowfNP5l31DtNTpLQ3NamNkpsyilktFIoL6FlPdSq1uTr9zhKlZFwbi
	mJsaXYgOWKsDpF3eeb6TcyGhZTyNazNADW/YQllODlTjai6Hn3slz/0GRubP/PqBti3jO9Bbw1P
	GI1X6W/19uccHoO8BCUjIm7aS0/5vO5kQp7emdDOCRM0pEKWbKkVE+fqo
X-Received: by 2002:a05:6214:c2e:b0:888:8047:e514 with SMTP id 6a1803df08f44-88d81278a7bmr406254496d6.5.1766787210443;
        Fri, 26 Dec 2025 14:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYVLwcCzEd9vRQ5ZAiqiA7WVLjHHO5Pqc++xoxQfNciNGScOhGispLouTYQ6DDT3yyTzTvrQ==
X-Received: by 2002:a05:6214:c2e:b0:888:8047:e514 with SMTP id 6a1803df08f44-88d81278a7bmr406253916d6.5.1766787209977;
        Fri, 26 Dec 2025 14:13:29 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4d5b4c975sm115870181cf.1.2025.12.26.14.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:13:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <48f8bff9-178c-4ab7-a8ef-7edba9b0e7bb@redhat.com>
Date: Fri, 26 Dec 2025 17:13:25 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] kthread: Include kthreadd to the managed affinity
 list
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
 <20251224134520.33231-27-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-27-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> The unbound kthreads affinity management performed by cpuset is going to
> be imported to the kthread core code for consolidation purposes.
>
> Treat kthreadd just like any other kthread.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 51c0908d3d02..85ccf5bb17c9 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -818,12 +818,13 @@ int kthreadd(void *unused)
>   	/* Setup a clean context for our children to inherit. */
>   	set_task_comm(tsk, comm);
>   	ignore_signals(tsk);
> -	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
>   	set_mems_allowed(node_states[N_MEMORY]);
>   
>   	current->flags |= PF_NOFREEZE;
>   	cgroup_init_kthreadd();
>   
> +	kthread_affine_node();
> +
>   	for (;;) {
>   		set_current_state(TASK_INTERRUPTIBLE);
>   		if (list_empty(&kthread_create_list))
Reviewed-by: Waiman Long <longman@redhat.com>


