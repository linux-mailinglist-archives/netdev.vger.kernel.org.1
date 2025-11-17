Return-Path: <netdev+bounces-239078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3844C638CC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D53814F5B53
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46F331D75C;
	Mon, 17 Nov 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xM7yx4Hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DA31E11C
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374775; cv=none; b=djntYRC09rr41p/GlNf27CWme2/Ikr5s48WFRZzqvTu8kvirVNFmgi2hKqr/HOlKWexpWXHAjpTmvfC0E90uO771vNtnQHudDAkm+FpEK2CV1kPol16F6vZdOZJT5DCWeJyfeYgoEUCOi+ruHMxR+NKr881HElE1s/X9y31pmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374775; c=relaxed/simple;
	bh=NuRSXh4vBPgeZ0kN8tjhHfqQ+6JkRGee0nDYtW8KL2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y03kCYU+v56RynWX044wajNULI4nyxu9fhiKTDGZxvauCeaMRgjJ+wMXCezmznK3RxMr8ws52WbI9+x/6d57Vh1pq0RQ2ogxZEsGd9n3JSN272kjvuk773i+Z45PWjVd67hvqW+zJu/RnMk+vMTCTAaZJ12C6Gj2zkMWBb8K37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xM7yx4Hu; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso13813211cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763374773; x=1763979573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzJH/FbBvB/0zoEXtKgv9RafSXKN7cHjIySxSEUk3sw=;
        b=xM7yx4Hu8Ywp7zRpClWvKwVz4+jJSZXHDbb6fbAUudNvgnbBQYWzLvEtH1sIU4e8Ot
         UzeIf18lvcZlBrVtT/86vg5wiOEeCTXjLq9Qe+MVvDzuVrh8GKP5e4b2Ou8p56XFPw+/
         bK8g9hHiGq2tJB0HfWXliwJiiU0V4pYwtJifs+hrK4G49IAidRjKw5atT58DoLsEpw9T
         zFeR2Yf+lEsXik7TkN6YfbjHlcK67Z6KH2pu0eirK2IcquWe2DcTEp0oYDs4XC+a39sy
         zF1R8yvbjSAQcWLsdBQV9abF3Hl+7H0/7/HDgxhQgTpoeJiAZsgfz6HOs09nxM2aSStu
         FiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374773; x=1763979573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TzJH/FbBvB/0zoEXtKgv9RafSXKN7cHjIySxSEUk3sw=;
        b=wNIglK788PcLst7cEiC86SmfKLxD6gy+uFyiDwWTuGTW0qVg1aL+14RaxlQFkvzavg
         NFlKw23UiwqfgHxVYfB7ohIzvU6C4QgjKw1qKtzW6uwTyuqdJQ/5oRhhxhaMCWOK8U05
         kqFpwDDoGI8XnufLzmMjGdbtWw7Tlc6zEtsvEoNtn77Ixf9dbXnW/0SvaRiLEZKHhIvY
         mBm5duC8KrFGxkeU1T/9XuTyAPYw0BgK8zHY5XO8QY+L791gQ1CfU6ptyOOoWJ39skOF
         eRo9sJLHDMjlX6cGtIKhGMgbOcweDvg54L3Gus0vkpAD4UxRKMozYPpmV+VkgJWi5wDA
         RbhA==
X-Forwarded-Encrypted: i=1; AJvYcCXqcr35xjhrwwjZdJ7v88+WsoHrmpsvwc0ygjptsFjNzXKIU5+LT83vjTUVBefwsjfzY8aTvkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3cnWHNuLdik5qgxm6DKj29WZNHGujuAPHQUCA8Vitz7wKJlP
	Pby+RM1xkH66PAjuFYyGqbMvtgZIjsLsiiMTMV41mxzGjwDQ1i5srzDAHP7e/mwo8rd4/Y8edAt
	Ye3biJ8rzWLIi9xX04f4o9/BBQky0iJcc5sZxC2wR
X-Gm-Gg: ASbGncufbz1+Jx24rB5rYV6LPEgEZVpRBLHMG1CFpSQ2eye9HXOaa15LKzTWlynToJ3
	wS8psqgN6hD+8apAva8yX2LKfWflqtWNkDt98AbLoffIo3kbd+SAxGFIZPDsxjCDudadbPkMqHm
	oBdlsuYWlf6Gwy3hiBkrbC8eTVU9T+wql94ulHI5g4vRVrEcMmY1ts5RTBCdHWhsl+9fyWPGcXf
	fyA/F2TBDwakCNukEMUMNyWuBhU1nImEqIHqZm68G17tp+kbBgmr8cPSTmPdYmFS6qr/wcPvshZ
	QJxTQg==
X-Google-Smtp-Source: AGHT+IGKM4PNFcjlh6umZZpKIqQdtW+kamtr4JC0zHoFvBONE6FE78e0rEu8PQtxZ/JMtxxERpqrbrX6EjFez8BJvUg=
X-Received: by 2002:ac8:7d4e:0:b0:4ed:8264:9199 with SMTP id
 d75a77b69052e-4edf212eb24mr169144121cf.67.1763374772622; Mon, 17 Nov 2025
 02:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114121243.3519133-1-edumazet@google.com> <20251114121243.3519133-4-edumazet@google.com>
 <74e58481-91fc-470e-9e5d-959289c8ab2c@redhat.com>
In-Reply-To: <74e58481-91fc-470e-9e5d-959289c8ab2c@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Nov 2025 02:19:21 -0800
X-Gm-Features: AWmQ_bntiLtGgOTA1hCRT4ICejkbwGjMs3qXgzwUI1aWunrNIGl0Fkfd0odLIhI
Message-ID: <CANn89i+o6QAUXJkmVJv1HTCGxK05uGjtOT5SUF4ujZ4XCLQRXw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] net: use napi_skb_cache even in process context
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 2:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/14/25 1:12 PM, Eric Dumazet wrote:
> > This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
> > with alien skbs").
> >
> > Now the per-cpu napi_skb_cache is populated from TX completion path,
> > we can make use of this cache, especially for cpus not used
> > from a driver NAPI poll (primary user of napi_cache).
> >
> > We can use the napi_skb_cache only if current context is not from hard =
irq.
> >
> > With this patch, I consistently reach 130 Mpps on my UDP tx stress test
> > and reduce SLUB spinlock contention to smaller values.
> >
> > Note there is still some SLUB contention for skb->head allocations.
> >
> > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > on the platform taxonomy.
>
> Double checking I read the above correctly: you did the tune to reduce
> the SLUB contention on skb->head and reach the 130Mpps target, am I corre=
ct?
>
> If so, could you please share the used values for future memory?
>

Note that skbuff_small_head is mostly used by TCP tx packets, incoming
GRO packets (where all payload is in page frags)
and small UDP packets (my benchmark)

On an AMD Turin host, and IDPF nic (which unfortunately limits each
napi poll TX completions to 256 packets),
i had to change them to :

echo 80 >/sys/kernel/slab/skbuff_small_head/cpu_partial
echo 45 >/sys/kernel/slab/skbuff_small_head/min_partial

An increase to 100, 80 was also showing benefits.

It is very possible recent SLUB sheaves could help, I was enable to
test  this yet because IDPF in upstream kernels
just does not work on my lab hosts (something probably caused by our
own firmware code)

Anyone has a very fast NIC to test if we can leverage SLUB sheaves on
some critical skb caches ?

