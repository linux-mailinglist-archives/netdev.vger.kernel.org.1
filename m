Return-Path: <netdev+bounces-71407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76A853315
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237EF1F26230
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45FA57873;
	Tue, 13 Feb 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xes+m9Ej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07A57875
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834528; cv=none; b=HlSfoC8bSXHpxHlgrEzMtgMm+usi1KI7ifo6KR8LK2LbRQ7klILmmWE3dV3JR5qAEREReENiTp9fi7qjKChO+qaJ79jbIRRR5FOfM8jp1FUlBwtlpuLO8ZWsyhr7IKYO+GA36te5ADDdbvZyFjBknaOQs3ZYfWMj840j1HTbbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834528; c=relaxed/simple;
	bh=m8BKtEKYmFACguBQEee1bM3ToNMhG7KzTNQsN6ZSmD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNCWiptJeqpOXM7S9V0ICCQC88PGKTLzEu0r2Aptsz8269OvkfzQ5ROasrm3djB91Ks7PlGjdxdfo0ZNxJY9uYv6IY2/8t8B0sBG/N1WJodJPmDqzA5dz2rOkfi2qigO0gbHsq6LB+AIKtizzUhxa35iq2lh4PmgEToavBQaAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xes+m9Ej; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso9948a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707834525; x=1708439325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6TsXUlYE4eDjo4HxvZHAA9eZc9GJx+BqZTfQgO2G+Y=;
        b=xes+m9EjmSzt2VLtIkCzQuLChThP8XGHO8WM5OsYOr0Ax6pRvzonEL89raN74E1BP/
         tmu2mlvAd4aPSceaHnxz856ffReikzWIHy+dxc8/9Fr4htofc9l+dwbeM2q1NUCdeDZr
         3Isb/VNHZQpCHEsciOiJf2IwFyBlx3jZTw0vrAeA2k4loi9B0gYSr40TpAuhI9NYKBN/
         UWnVWpDYZprbnzNk7Rty+JISLBP/gnInlx+7sLw3UkVpR4l4S4R56Gh+BrcHCfsDI21b
         jefAi/qZ4BBBvedjiHVcO/ORQZMwykAjOOZgY0sNlo9P2S1cwTpZqQzpFo3XSya3G5Jg
         oKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834525; x=1708439325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6TsXUlYE4eDjo4HxvZHAA9eZc9GJx+BqZTfQgO2G+Y=;
        b=EqVcRkL5hjI3icda8f80JwnxOVz8nQi1pUxP0dheMxgZyhbCBjxgjhFJmQb7qqLbUF
         epXdYsPeg3jGQdRbr7Gu5jeyPAETu00OrJ37lxj+vLQJIqDwdaFHPKjplZpscft07qqF
         Kz5PyyEgzO+z9HoGBKzK2f5DAmy1vRLsh61WJN9aKa7p0enJRgHQKciEJDAQIz57eNnA
         ueFk20ikklZuMh22TN9vSFmXfrbTp0cJkQAg+2iEmYGVaPe+oj3BeTamI3mXLURAZuV3
         gQ+UaiIxdy1RzMP9+1YO7FDts8J4tml7B1WjlW76LSovRbRgR67tf+VWo290zEx688Ze
         Zpbw==
X-Gm-Message-State: AOJu0Yzu4KLArdHsScGqHBVsr+QpN+IQi/LZcM0VmpWTSbUs6+odCvjA
	NG5aZTn+sVzJq4C/KHkHxt5bQjwfcZ8MSpmHSuwaT8gatHJH14jbCbODIvCpF7XTu/yd2/OTXX5
	HgpM+W8ux1vBXY2oUxd4KPZeOQp8W2AyA8w7H
X-Google-Smtp-Source: AGHT+IFiiuBRYZ2n2az0BBr83cdeSbr0ROhSQvkwL1lO9pIVByfu5CRKxGgCPEbwTZCWyvrHHeBujSQ2cw4+4E7k21o=
X-Received: by 2002:a50:cd59:0:b0:560:e82e:2cc4 with SMTP id
 d25-20020a50cd59000000b00560e82e2cc4mr118180edj.3.1707834525091; Tue, 13 Feb
 2024 06:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
 <CANn89iJBQLv7JKq5OUYu7gv2y9nh4HOFmG_N7g1S1fVfbn=-uA@mail.gmail.com> <457b4869-8f35-4619-8807-f79fc0122313@gmail.com>
In-Reply-To: <457b4869-8f35-4619-8807-f79fc0122313@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 15:28:34 +0100
Message-ID: <CANn89iL4ViyMQ3gm32K6LqfLWEvTeGSn27j729d1x3vaDyCzXQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:17=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/13/24 13:53, Eric Dumazet wrote:
> > On Tue, Feb 13, 2024 at 2:42=E2=80=AFPM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> Optimise skb_attempt_defer_free() executed by the CPU the skb was
> >> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> >> disable softirqs and put the buffer into cpu local caches.
> >>
> >> Trying it with a TCP CPU bound ping pong benchmark (i.e. netbench), it
> >> showed a 1% throughput improvement (392.2 -> 396.4 Krps). Cross checki=
ng
> >> with profiles, the total CPU share of skb_attempt_defer_free() dropped=
 by
> >> 0.6%. Note, I'd expect the win doubled with rx only benchmarks, as the
> >> optimisation is for the receive path, but the test spends >55% of CPU
> >> doing writes.
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>
> >> v2: remove in_hardirq()
> >>
> >>   net/core/skbuff.c | 16 +++++++++++++++-
> >>   1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index 9b790994da0c..f32f358ef1d8 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -6947,6 +6947,20 @@ void __skb_ext_put(struct skb_ext *ext)
> >>   EXPORT_SYMBOL(__skb_ext_put);
> >>   #endif /* CONFIG_SKB_EXTENSIONS */
> >>
> >> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> >> +{
> >> +       /* if SKB is a clone, don't handle this case */
> >> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE) {
> >> +               __kfree_skb(skb);
> >> +               return;
> >> +       }
> >> +
> >> +       local_bh_disable();
> >> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
> >
> > I am trying to understand why we use false instead of true here ?
> > Or if you prefer:
> > local_bh_disable();
> > __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> > local_bh_enable();
>
> Maybe it's my misunderstanding but disabled bh !=3D "napi safe",
> e.g. the napi_struct we're interested in might be scheduled for
> another CPU. Which is also why "napi" prefix in percpu
> napi_alloc_cache sounds a bit misleading to me.

Indeed, this is very misleading.

napi_skb_cache_put() & napi_skb_cache_get() should be renamed eventually.

Thanks.

