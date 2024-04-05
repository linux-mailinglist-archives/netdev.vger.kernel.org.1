Return-Path: <netdev+bounces-85219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C16899CE3
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA0B28360B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0816C852;
	Fri,  5 Apr 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvN2lQI5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787921FDD
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320196; cv=none; b=KPtjRejt9ozdH4ieJzApq+3A0HHzzgXH/m8EbZ7vHK1l7/ek9HVXXraG8SQHI1YXoaJ161tdevdcA/qGPOs0sb0jmtYF18AJrviiNrZ0ucQet0Dzo2u2ijl4n+3QbQ8CRZqXGz4Jd9XxpEF76Z+pshtl4pN6YXBKM8JED3mELdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320196; c=relaxed/simple;
	bh=CTgA1V1bE/UrHfZ8Aj1dsL2IKlvZIuMDjzYDzQm+Tug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9H7aXjj+WUBMpoKTxbwKqvpu9Qg5iQqI1QSi/4csPgIYNXvgHxj6lbmQHbFOY0OPhBLonoMUnEjfrhKDibZmONivmq7POVoF1pRKa8i8T7P90D6Y3cxn6OOt3wXnejVP4Fuu8HXQhwiK7sgI0f1/fi5wIGUpvNFlArVzo5j8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvN2lQI5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4715991c32so312546966b.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712320193; x=1712924993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/iREVVmfPQKewKnpXiwLhgHsfDeu7QKMqI6W+z9dOM=;
        b=mvN2lQI5/lhYh9AI3woBEzHNQcpZPZsfGkajCP+OreMA843ICB6u/DbFljx521H2hB
         11rmMHnIpyufVTP49c4c1ICO8Ed9Rwa3BNKN71i6zKFJT2ww52Ddx2Y9dM83kNPBtE/V
         rVQ9JtgMcvRYE6Aw9ynQA20fuXkUavF0cn7mEeJnqBIWmUHWyijROQ+NrKGQQuAiFGY+
         x6xrG7ls8XCTaCWd0pHjfsPrCmcsZyM3mJIVpPoc7MQq98n02eM3DSfocsK5rWw1vOyt
         yKjrpuNzKb5Cv5f06XR5btHQRMRduNGHBQykblLlhl5nRWlUc3MQWGQt36hWpOQY4PMx
         xJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320193; x=1712924993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/iREVVmfPQKewKnpXiwLhgHsfDeu7QKMqI6W+z9dOM=;
        b=ioBgI/mcXL44sX8u1b/8aUwFKG80I5qSXvH6rYYsYNUn/UeBado+9yqW4lEJcuYe5h
         w1DDjZhzdD+TAmRamB6/uK92TGIqE9EO4sIWA/GKX0yulFdp1EV7UkvYUkfF0lESIGtH
         M1pWcE48QGWcvvZv8UN5+HKj19supP6yvOWiDNe2fgZfVTiKB/K0Hl/EdR4as6MXQ6QP
         MKx4uyfXZ5ngAMzINzQM1oED/Dk2fkO1nCDh95qVErpHCy95hSUZh4f8CAvobffJWqdf
         5QMKrPS5wSUH6YDQ9jEFMOKB8M8bkgO4k1PojsGa1BiWhAaHL2MTJFmZewT+mg1VDsLf
         WChA==
X-Forwarded-Encrypted: i=1; AJvYcCX7H6BTK3LDGdD4jjSS47VHxPOzfOThXeUv3zNl6h7pg+Jb0gDpVKgwrCYTDqhuivyxfuIhlm354v13cw8ym6SZIfeeDCtt
X-Gm-Message-State: AOJu0YzS54dA8Lf9eqcCZ/OwIQo5qkneD4J9/oV3gOwkxeGXAManWlnC
	KZwxDOWX4gqRZ8/03tdq9o0pLSYyEhglPebpJGQxnoLhrZ3KsP5p0zYG6wwvmVuQ3CBbnp6UHgx
	JETapsnJ0A1LX7f8kaV+syWF59xs=
X-Google-Smtp-Source: AGHT+IFtGzB15kZDt/rtz0BV6kZ2SzZqeTm7GJpY2rDuNL66LYs9GQJHkSgddGlixxHUOo+SUp6OpIl5UYgIps2AjVM=
X-Received: by 2002:a17:906:7107:b0:a47:3555:6b73 with SMTP id
 x7-20020a170906710700b00a4735556b73mr836710ejj.39.1712320192586; Fri, 05 Apr
 2024 05:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
 <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com> <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
In-Reply-To: <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 20:29:15 +0800
Message-ID: <CAL+tcoC4m7wO386UiCoax1rsuAYANgjfHyaqBz7=Usme_2jxuw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
To: Eric Dumazet <edumazet@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Fri, Apr 5, 2024 at 8:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Apr 5, 2024 at 1:55=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
> >
> > On 4/5/24 09:46, Eric Dumazet wrote:
> > > On Fri, Apr 5, 2024 at 1:38=E2=80=AFAM Pavel Begunkov <asml.silence@g=
mail.com> wrote:
> > >>
> > >> Optimise skb_attempt_defer_free() when run by the same CPU the skb w=
as
> > >> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> > >> disable softirqs and put the buffer into cpu local caches.
> > >>
> > >> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a =
1%
> > >> throughput increase (392.2 -> 396.4 Krps). Cross checking with profi=
les,
> > >> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Not=
e,
> > >> I'd expect the win doubled with rx only benchmarks, as the optimisat=
ion
> > >> is for the receive path, but the test spends >55% of CPU doing write=
s.
> > >>
> > >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > >> ---
> > >>
> > >> v3: rebased, no changes otherwise
> > >>
> > >> v2: pass @napi_safe=3Dtrue by using __napi_kfree_skb()
> > >>
> > >>   net/core/skbuff.c | 15 ++++++++++++++-
> > >>   1 file changed, 14 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > >> index 2a5ce6667bbb..c4d36e462a9a 100644
> > >> --- a/net/core/skbuff.c
> > >> +++ b/net/core/skbuff.c
> > >> @@ -6968,6 +6968,19 @@ void __skb_ext_put(struct skb_ext *ext)
> > >>   EXPORT_SYMBOL(__skb_ext_put);
> > >>   #endif /* CONFIG_SKB_EXTENSIONS */
> > >>
> > >> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> > >> +{
> > >> +       /* if SKB is a clone, don't handle this case */
> > >> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE) {
> > >> +               __kfree_skb(skb);
> > >> +               return;
> > >> +       }
> > >> +
> > >> +       local_bh_disable();
> > >> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> > >
> > > This needs to be SKB_CONSUMED
> >
> > Net folks and yourself were previously strictly insisting that
> > every patch should do only one thing at a time without introducing
> > unrelated changes. Considering it replaces __kfree_skb, which
> > passes SKB_DROP_REASON_NOT_SPECIFIED, that should rather be a
> > separate patch.
>
> OK, I will send a patch myself.
>
> __kfree_skb(skb) had no drop reason yet.

Can I ask one question: is it meaningless to add reason in this
internal function since I observed those callers and noticed that
there are no important reasons?

>
> Here you are explicitly adding one wrong reason, this is why I gave feedb=
ack.
>

Agreed. It's also what I suggested before
(https://lore.kernel.org/netdev/CAL+tcoA=3D3KNFGNv4DSqnWcUu4LTY3Pz5ex+fRr4L=
kyS8ZNNKwQ@mail.gmail.com/).

