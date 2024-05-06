Return-Path: <netdev+bounces-93838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387C8BD587
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFC71F21C48
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE58415ADA1;
	Mon,  6 May 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SunZxGZo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380FB157487
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024506; cv=none; b=hwOMUcHJofPh5JiOkIMe7/HyxyPBQUJ8SP1NjdllTtORX8PfX0Snn2nFM8hH7+er5cWR8pqS2nw4b24ZPDJX4GMtzwKPhYtzidgVbEjhM5VjMnYxxnfnv0OZWY+YPq1QjAivtOdh+ks7oeFN0lishDCctklgodLbQCcgvpvKSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024506; c=relaxed/simple;
	bh=PrBhS5DyGnBu39z/bV+pMeXm6EsKEDKCW+dJYY8AEjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=meQ6TxiTUZZWTeq8xS7DbyR32QB21QzdRLcGnn9SSPRqQzOED4wKgf4AZvu2dP2+AZ0otVvga55+4ThtUSevGfCDX+bofVKY389pWt1Qu6oMs4VJhSHuhYFGeg+A5qpifxHoOLGELvyLed8zz1r4YsUrEGH2bPAC43RT4v1bh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SunZxGZo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715024504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DY+sYZC8mturY+dnlOrnmUuxCVCJqkhdnmld3ulR81I=;
	b=SunZxGZotsJolMnWS30YjV394mjL70YkVHY4QY3hY9BDXU66A6z6Koj8kRa2zCrGlbRawF
	g+ijPI/9rKv77+S/DAG9n42vUbVmGv9Gm/m2yWaBmPjkNR6HyaFYF1u8XyBWFXMPA48igy
	+GxQKQIIsFkHY0vSE5x62QbqJDvAgoc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-LpTrYG6KP323YjPbsk6aLw-1; Mon, 06 May 2024 15:41:41 -0400
X-MC-Unique: LpTrYG6KP323YjPbsk6aLw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34d99cc6c3dso1447162f8f.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 12:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024500; x=1715629300;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY+sYZC8mturY+dnlOrnmUuxCVCJqkhdnmld3ulR81I=;
        b=tzQCnsRPyaiOItVTk8mwPcIZ8FmYn1ks6MbKel3CjHMKhWBN6uTA6Bgk6d4hxYEhv2
         LgKWA6eT4qN01MVjO+OaJkSOUVAKKazEsdMwcLRBK9uQplINeWYKdeb4yPaEjpt/Y+OO
         6eHlNczzYBRn7zXRQYOvmLRhsjwo9FIMsgJIZwPqJUgqQx3Y9ARTmgwiwUHmY2xxmmVA
         6taBBdIHwrC2/vk9tp3bzHz4nZnwJdpXFI9OIW4MsZ/khnLNjSxULrYNhI0FcqhY7I6s
         4jWh0hdtQT0EaESR5WnsYjjCmE2JP9V51HU2Yofdnw+D5TDo6xaTEpoahsnpkAqvBvbF
         n1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe9csJcF96qXnFW6hiOkR3dNPBgKIVgJ2aHaBRXWSnC9d+qQx0pTzQcsolRUX7qq0uUKR7LZt8i8UMmYUGbHmEPOSI+ttt
X-Gm-Message-State: AOJu0Yxnny4fnNLVjfc94iqwBpGTyZm0FvhErjKlsJPhYxqO/y/QuvjJ
	eIeXD1A5YgVWwpd4QCGkYiXTP0F2u+MpukMi6moKa89mK2glro/AjAOiOklyn/k++JSYCUWUV98
	RbbueL+VLM/RlRbre4cR2SyoG4BnPVwBOBSaC+CUlPqJsdsuam1TvAA==
X-Received: by 2002:a5d:4404:0:b0:34d:354:b9ba with SMTP id z4-20020a5d4404000000b0034d0354b9bamr7042486wrq.30.1715024500700;
        Mon, 06 May 2024 12:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaokgN4DJrI/5hz3+xQUzTXmGqJHdlwJ5Sbtxf1d7FO21ctPZPxyFm8wyqqr/TggXdaqWO3w==
X-Received: by 2002:a5d:4404:0:b0:34d:354:b9ba with SMTP id z4-20020a5d4404000000b0034d0354b9bamr7042472wrq.30.1715024500275;
        Mon, 06 May 2024 12:41:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d58e6000000b0034dd063e8dasm11301564wrd.86.2024.05.06.12.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:41:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D92311275C73; Mon, 06 May 2024 21:41:38 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao
 Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240503182957.1042122-15-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 06 May 2024 21:41:38 +0200
Message-ID: <87y18mohhp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>   packet and makes decisions. While doing that, the per-CPU variable
>   bpf_redirect_info is used.
>
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>   and it may also access other per-CPU variables like xskmap_flush_list.
>
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
>
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking.
>
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided.
>
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it. Use the __free() annotation to automatically reset the pointer once
> function returns.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
>
> On PREEMPT_RT the pointer to bpf_net_context is saved task's
> task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> variable (which is always NODE-local memory). Using always the
> bpf_net_context approach has the advantage that there is almost zero
> differences between PREEMPT_RT and non-PREEMPT_RT builds.

Did you ever manage to get any performance data to see if this has an
impact?

[...]

> +static inline struct bpf_net_context *bpf_net_ctx_get(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = this_cpu_read(bpf_net_context);
> +
> +	WARN_ON_ONCE(!bpf_net_ctx);

If we have this WARN...

> +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> +
> +	if (!bpf_net_ctx)
> +		return NULL;

... do we really need all the NULL checks?

(not just here, but in the code below as well).

I'm a little concerned that we are introducing a bunch of new branches
in the XDP hot path. Which is also why I'm asking for benchmarks :)

[...]

> +	/* ri->map is assigned in __bpf_xdp_redirect_map() from within a eBPF
> +	 * program/ during NAPI callback. It is used during
> +	 * xdp_do_generic_redirect_map()/ __xdp_do_redirect_frame() from the
> +	 * redirect callback afterwards. ri->map is cleared after usage.
> +	 * The path has no explicit RCU read section but the local_bh_disable()
> +	 * is also a RCU read section which makes the complete softirq callback
> +	 * RCU protected. This in turn makes ri->map RCU protocted and it is

s/protocted/protected/

> +	 * sufficient to wait a grace period to ensure that no "ri->map == map"
> +	 * exist.  dev_map_free() removes the map from the list and then

s/exist/exists/


-Toke


