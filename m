Return-Path: <netdev+bounces-100941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2868FC935
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D561F2326D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF9191483;
	Wed,  5 Jun 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHdG+NYx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DA191461
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583865; cv=none; b=slH+sHrpIRAySDc9HPQJJ54faYu12nyFof6MiUu0tv8nSD2ArLMk5/xmGwiD54wlDQ/3pyqetkg7T5ewDNsoD0DcQjISy2KcEE/79gQBWiQwBi3hwE8+0fIrubCOFsJNZkGIuCdFFNd4okkvWJhrOQ2IMU40FK7BnE4FJ9zB8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583865; c=relaxed/simple;
	bh=mhePjjOWJijsByiVLZ5nqSDunxe3JEHHTJ2OBLVs9LY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+mu+Ggx3kAiB2km2rVwiW3gTeL5NzDetlft84mFLo11NaLaH5qQVhdXgqSr7udcvteM3Y+ppNLXiiES3/Z3ZM1aGOpqjQ2iiD/MMRkQGlqKxv/SnJwLDXEuq1WqoX1Pjn0W1T+Xnk8k1SJ3v4pJgTiRqnDAAe5H1Q8udFkcuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHdG+NYx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717583862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOuK2cqI4c7KL2BWpDNCdpK3QljK3hDq+BToleThPj0=;
	b=ZHdG+NYxM3fKAUZWbX7rhZT/zeUf9nyCF++xk08eDdziKs/FlFROkFRPgDpmSyl0uHwO5N
	V3HB25b4ba7kECrMVR5q1fWP1/jBOoEG+1ONdJ2oYagCTpvvVR7doJxF3lCXCorXscFopC
	OlgJmDIaeK7nweVSWh0kb9k6XwMpHlk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-a5imsAe6OluUSyh4RX5mrA-1; Wed, 05 Jun 2024 06:37:40 -0400
X-MC-Unique: a5imsAe6OluUSyh4RX5mrA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52b98e99f0eso2363003e87.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 03:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583858; x=1718188658;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOuK2cqI4c7KL2BWpDNCdpK3QljK3hDq+BToleThPj0=;
        b=FfSlEsLPA2FN5raIspgXLnp/TuXTtL9+kEsI5r0SbcI/wn3k2H4gsG10bGBOS4FrV8
         QX+CFsL7015AaJW/mKKmzameYNKp4P2mVxso3V6xHOZmBSUmI4iBHtEJmwlDiujdu+LY
         5BmqmGqm3WNW4VqvmRtdlKW/5VJpyfwBZPnWbDqE0ALaTEZepC2C0VScqp6uMw+bLZ5u
         N5U1Knh4akfSP2UkyJuNfqKgC0f9wHcv8icZ+f6Pn2b3Ms3CzcDi0lHAmysRAryPF0AC
         Utsh4Oc3USFGvfJOPGfwt7g++NpyJhoH2/J93u/jshcUSAQJ3Bx1AxggrP+F/gvid3oR
         ohxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMjsXGVQo66Lt8ilzxlH4cpGFjaIsZs50coDvajhNAPzkGoBuBhkxLr3FqpHaHvukplGAA7w/WOT7bRFondmJsTX4EkZ4N
X-Gm-Message-State: AOJu0YxLPZ6N5x3hUrFFO055hznj9mtGHWJMDDJYrKwN/ViwWhTvWHt4
	N+RkqjM7d0RB0KgCVxhF6EAgmqtUwTijp7jVJmgFlYoqBZhxbyjpXbsXgORUQ7RfKGgD6tffUo2
	hub8j2HUldysIWUe0SMXmZEgyDDPoThoxN6RTIljDqXH0I1LW6apGZg==
X-Received: by 2002:a05:6512:110f:b0:52b:8435:8f26 with SMTP id 2adb3069b0e04-52bab4f43b5mr1651640e87.44.1717583858214;
        Wed, 05 Jun 2024 03:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIB3f5h9VIv9ftObM90qzaaplOueJP9zCegw13CgZoRfjLUxHIuKEU/8+3apf8GnzLwLliRQ==
X-Received: by 2002:a05:6512:110f:b0:52b:8435:8f26 with SMTP id 2adb3069b0e04-52bab4f43b5mr1651629e87.44.1717583857818;
        Wed, 05 Jun 2024 03:37:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8e405sm1762081e87.284.2024.06.05.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:37:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DBBEE1385513; Wed, 05 Jun 2024 12:37:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
 <20240529162927.403425-15-bigeasy@linutronix.de> <87y17sfey6.fsf@toke.dk>
 <20240531103807.QjzIOAOh@linutronix.de>
 <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jun 2024 12:37:36 +0200
Message-ID: <871q5bad5b.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 31/05/2024 12.38, Sebastian Andrzej Siewior wrote:
>> On 2024-05-30 00:09:21 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> [...]
>>>> @@ -240,12 +240,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_m=
ap_entry *rcpu, void **frames,
>>>>   				int xdp_n, struct xdp_cpumap_stats *stats,
>>>>   				struct list_head *list)
>>>>   {
>>>> +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>>>>   	int nframes;
>  >>
>>> I think we need to zero-initialise all the context objects we allocate
>>> on the stack.
>>>
>> Okay, I can do that.
>
> Hmm, but how will this affect performance?

My hunch would be that this would be in a cache line we're touching
anyway, so it won't make much difference? But better measure, I suppose :)

-Toke


