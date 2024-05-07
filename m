Return-Path: <netdev+bounces-94134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3358BE4B7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638E91F26859
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0215E5DD;
	Tue,  7 May 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmD0p47D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09415E5D7
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089856; cv=none; b=Q2/zHsxoLJSDLQ6UcOGh94o7onCsfm4mLZZ5lea2FJ7flkZOvxq3Y8ykntlQkF0TytbaL8yqGKcmbYXrKB+RolkKQUvaGhF7k2QSUhR+rnRRAdJGaBzkgcCDo6whz45WHKCSnv5e1jr3YhbVStx1EFYmRsoUYKEtjdHwwmvhvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089856; c=relaxed/simple;
	bh=TIJT24/Y/Kk/+RWnfVxsYYSG3i19tMA8dCXENC479kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AApEq/zgpLJZfQqRhysywEgB0c3EJQzY2M90tAXP64m9w+klz6ubxEwWoZVJLLCdrHVTiNqrm+NSVicUuv+wnWjfLMFZy7t3ixw5mhX80HQSz9rORU9FPEYw6wSCaVF38EfOJNVDJT3D3uScc/hpXOhmJkq1oIiCu2rBnyOXsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmD0p47D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715089854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTODE9eHYN04ukhQbjsh3NfbLHwJO8ke2b2LYl5imOw=;
	b=QmD0p47DDS36/tfeC5lWnhS7wPjlFyFUuQuyQ1PUICB+0jCs5kc2Ebd7/bxnWYz0VFU+W4
	CJ37UVS/Ci04hPYRuogNRpXfQ9385roCkttFjGzylYiZFArnv1g6XT2s0ohFbb9jyng0hH
	IYE14Semdk4ryGT7QMn8Ia+LOaAUoqg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-lQuQbLMCOjWr7upeBSuyzA-1; Tue, 07 May 2024 09:50:52 -0400
X-MC-Unique: lQuQbLMCOjWr7upeBSuyzA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51f22618c20so2518442e87.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 06:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089851; x=1715694651;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTODE9eHYN04ukhQbjsh3NfbLHwJO8ke2b2LYl5imOw=;
        b=X7U65dP46PPC5oUpugRnsnR9eM5RfwyDXE5j37XVNk9xnUP8uzslB7eJaZ0JPygAt9
         73sKBUzGSCjCrrwIZl5GeJcBK2mL3crJ62hakDDLMzL/5aXls0hu27xkGkkvjAusA3F7
         vLmSoAkh/miRv16+3FizE1PjhYRildoyaO2WcgzQI3ofrTZkyPi5SlpHfam7Hhf1GnZ2
         spQHz75Gldn5Dt49suN5TSC00C0JIXeAHt2kASsHw0AYRU+9SNEyDMWusI8kU8JE64rn
         WURODNfX/V8gNztFisMgMbl2/yeaGFX3mqEkKuLxrf9+5DUb1SKWITcYSH0WfIsQT6+U
         FnZg==
X-Forwarded-Encrypted: i=1; AJvYcCVO78oJYzNP/k9zglI+uH2eN4p2pgopxmqsS2JZ7jKwJQrpXjOK+TBq1XyU2yVA4udK76jiovNNsa3v0qVxPtfDI7KVUNVm
X-Gm-Message-State: AOJu0YyxC3ExktzT+Ss0EHOoeUPPHaXuXZwq7coCwnr1epcMqPf0ypho
	wAu/E2afCCXF8nnlfS0pM1E6S5ilVqmP7ZPG96W0H4Z+lgMWTfeFmcAFIePZ756Z9bUVHylfaFN
	E2K27JJsdl7zEgR/8t1b2E08D/99H7SXg3dv42aXpXZpx0r36G2fMxQ==
X-Received: by 2002:a05:6512:1588:b0:518:b283:1078 with SMTP id bp8-20020a056512158800b00518b2831078mr14091449lfb.26.1715089851198;
        Tue, 07 May 2024 06:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv9UwS+EKurT0TjqicSwHazMqzSvX4nL5tG19yPraKVt7fxXPC1+UwQnvq4wdl4VKNZqfd2w==
X-Received: by 2002:a05:6512:1588:b0:518:b283:1078 with SMTP id bp8-20020a056512158800b00518b2831078mr14091422lfb.26.1715089850709;
        Tue, 07 May 2024 06:50:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ek10-20020a056402370a00b00572033ec969sm6344723edb.60.2024.05.07.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:50:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6C3FE1275DC8; Tue, 07 May 2024 15:50:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240507105731.bjCHl0YH@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de> <87y18mohhp.fsf@toke.dk>
 <20240507105731.bjCHl0YH@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 07 May 2024 15:50:49 +0200
Message-ID: <874jb9ohmu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

>> > +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
>> > +{
>> > +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>> > +
>> > +	if (!bpf_net_ctx)
>> > +		return NULL;
>> 
>> ... do we really need all the NULL checks?
>> 
>> (not just here, but in the code below as well).
>> 
>> I'm a little concerned that we are introducing a bunch of new branches
>> in the XDP hot path. Which is also why I'm asking for benchmarks :)
>
> We could hide the WARN behind CONFIG_DEBUG_NET. The only purpose is to
> see the backtrace where the context is missing. Having just an error
> somewhere will make it difficult to track.
>
> The NULL check is to avoid a crash if the context is missing. You could
> argue that this should be noticed in development and never hit
> production. If so, then we get the backtrace from NULL-pointer
> dereference and don't need the checks and WARN.

Yup, this (relying on the NULL deref) SGTM :)

-Toke


