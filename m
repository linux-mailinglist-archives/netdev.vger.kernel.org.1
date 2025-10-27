Return-Path: <netdev+bounces-233260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF4C0F9C9
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62386463FAF
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE54314D16;
	Mon, 27 Oct 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuGKN4Km"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1C28935A
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585514; cv=none; b=eKCcq3nZHa/4y4MAWVh6mItTypjsjStpl06gYO4vhOx83zcOJLJwc5zKQTAcuTJdEDLH1bxJ1YyynJxtBhLdqN2S18k+v2r2mHyE3ifL+wPXly1iyb33fWhRcW2PQi5aQaHAnm9wSOLKDKLuOSvLvKHORbT1DnYCmiFeHyeL0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585514; c=relaxed/simple;
	bh=IOqH2JWzhdGgsH6o1xttTcCVqend8cTv6mFd4Q8se5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7NXLULcPIu7V0XLAw6y8u/bmhHEtC8WGiXUf6HjWCWfm76u8uUhwhXdQkgKlEqlVQ4Q3c+iGLIr9goFg6S68SdSrkDnAnDd+jZ7XhnWCZDDqZ0+bXcWt+5dtbPlw0yDUa1FxOo4mlIdx9CmgTlMk9nQSvDx7S6WbobqphLSDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JuGKN4Km; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf257f325so4000698a12.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761585512; x=1762190312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOIx0HIToYFoIala6Rgd03oc1y+eVEtfTq6/VvCohPU=;
        b=JuGKN4KmDFQWE4jQG+BUrfIH1El789o9VzjaF2OT4bTWWYtk9ZNqD4BGYWn+rF0J4f
         2dxsm1mmmAaE4KqY8O2+bTwdBeeuCFhGfVkzOsTAvFOYPscbvFVnFi8xmch32PH1wVhH
         fpl72er7oSHzIVyPGK74roErz6yvmC7MqiYbQqVoZEgkTUOKjB+2P3M5I8ra1CNp+LNy
         yXTteNw5cLUpTSMscWJHnwGwIIX/a+CaRpK71ZTNBl6u7WptNA7g0fCI3gDJLNiUW0Cd
         mDtnpbIAKch/Uh1VnoFmMP7wbRSnSF3JZuDSrVsZRbfooLZFZvlF1sYG6dM5rRtqUGDa
         MEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585512; x=1762190312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOIx0HIToYFoIala6Rgd03oc1y+eVEtfTq6/VvCohPU=;
        b=tqBFarwTUUP71lK4nItn6r+LuUty5ZvvVdsU0dwmyrI2xQ313Ph6SyliwBvpA4MANA
         3T5Uno7mmF7GiNMUlnCs9sk+afTfxOzhQqxKtUe/gYZm+ET98UYKjrS49FEYuuleEX3z
         KYmGqgrudN7MCIfRISuSYFm0OKoC/s/VF7u5B+jkcQDWZvNaiPa1lRaLykVgoZMTS1Fx
         KGXjh00hfC/x7tX5XfpjR7ANjhTnh8N7yhuyjvFf+CEEGJUYjPLm9R9P0mYEK7r8XF3S
         10FPLqK06QVWcSan0QmuLG57kOiTwBTDbwFba7FhkqW3YLkAICzY6Ti13EaNVcpe39BM
         Pr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUqP+q9PmFbv0KaYTWUL0VrbJxcb6m59qiJ65eYDcyJLyztm/SXlJ0y4bZL2pP7t/twEylhhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFhj3bRHoui5/Ew+eUDzOc+/wEGnjbRPFKae8t233qP9REZ4+
	kU4RAYSc6RK4y97NVY+1MJ5S0phbKo5zKiCvFWT83UXNXwpuNZkTPUAlR1/x6Anqv8yhkaENZVf
	vnnMlUV726Tkvb61D9XvLWilRlea0i42HuO0Wax1k
X-Gm-Gg: ASbGncsEHfLAauDouJzogGYoZ9Nkn4gRoO0CRCMSkhWH23t4cQ1vCPOWm4QDNhG20zm
	XHhcornLOTYRtljalYbWrLb9B+VYErYuZw3z1BOrbCJS2MIsBHlHkSdJCofrPZRSQI/tAxucDH6
	71Vt+cfqvFUnvlgv4k2Mnx4wohfxQo2y1veXTC9sbcn9eMK1so4xljIAMUJtWMvLaq53slZynJq
	4lIfltMWnzon2ZwX0egwlilOkflvG8hEuvLnmuiaCpcfzglrH5mqTM7hslEAMbKGOrjhgRMe29U
	vu76CPOQQYR1qqs=
X-Google-Smtp-Source: AGHT+IHPXfnGaQSr5FOOLQRKLD0YYQYyoKqQ7bPQB/hIx1EXkIiPon3EMhGAvzwFaoL3bqhvnkkXY05GR3b09F6gxWs=
X-Received: by 2002:a17:903:22c1:b0:286:d3c5:4d15 with SMTP id
 d9443c01a7336-294cb524ebamr7391055ad.36.1761585511560; Mon, 27 Oct 2025
 10:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024091240.3292546-1-edumazet@google.com>
In-Reply-To: <20251024091240.3292546-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 10:18:19 -0700
X-Gm-Features: AWmQ_blFI6XZJuzW1ARfRNB-BND7fbP-kR1RMqfJwKHLC9oy5oewAzjIV1eCBqg
Message-ID: <CAAVpQUDRgnuxf5gcX21AfBzr6MbcTL7UJgkfGgAMb2zHdYXOxw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: rps: softnet_data reorg to make
 enqueue_to_backlog() fast
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:12=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> enqueue_to_backlog() is showing up in kernel profiles on hosts
> with many cores, when RFS/RPS is used.
>
> The following softnet_data fields need to be updated:
>
> - input_queue_tail
> - input_pkt_queue (next, prev, qlen, lock)
> - backlog.state (if input_pkt_queue was empty)
>
> Unfortunately they are currenly using two cache lines:
>
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         call_single_data_t         csd __attribute__((__aligned__(64))); =
/*  0xc0  0x20 */
>         struct softnet_data *      rps_ipi_next;         /*  0xe0   0x8 *=
/
>         unsigned int               cpu;                  /*  0xe8   0x4 *=
/
>         unsigned int               input_queue_tail;     /*  0xec   0x4 *=
/
>         struct sk_buff_head        input_pkt_queue;      /*  0xf0  0x18 *=
/
>
>         /* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
>
>         struct napi_struct         backlog __attribute__((__aligned__(8))=
); /* 0x108 0x1f0 */
>
> Add one ____cacheline_aligned_in_smp to make sure they now are using
> a single cache line.
>
> Also, because napi_struct has written fields, make @state its first field=
.
>
> We want to make sure that cpus adding packets to sd->input_pkt_queue
> are not slowing down cpus processing their backlog because of
> false sharing.
>
> After this patch new layout is:
>
>         /* --- cacheline 5 boundary (320 bytes) --- */
>         long int                   pad[3] __attribute__((__aligned__(64))=
); /* 0x140  0x18 */
>         unsigned int               input_queue_tail;     /* 0x158   0x4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct sk_buff_head        input_pkt_queue;      /* 0x160  0x18 *=
/
>         struct napi_struct         backlog __attribute__((__aligned__(8))=
); /* 0x178 0x1f0 */
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

