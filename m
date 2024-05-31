Return-Path: <netdev+bounces-99789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C68D6782
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC04283079
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44016D9AC;
	Fri, 31 May 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BGHtCbBt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F5157A74
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174708; cv=none; b=HAntzGTo18RfM1qnqNuks3Sap2KQCiIQRYueID76KJakqtZ9LXveJlwzKxcfybA5NmuxTt7Q2hDWhSrH2/Hxmzky4NFgTFw1/aUyrHrZe8hGyoJVKE5O1Az+WKPlyFuBMaebrtIoptPvG0WKlZl7/Z+LoCwVuq5CNpSKsHG+rTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174708; c=relaxed/simple;
	bh=hhhEDWLVE4M5G+vhOXoMR9p4anhHS0Vwh9WszXG8WM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikkgNl6qvoYSZWV3U/H04b9eMF/1jf+E/Mcg0PreMCsrxsoos0EDyPkb76Y3H+wDob9yv2ctk6KYNYuw7zFWy78fZBIXYYsT83XYvyyqoSfsTjYfJp7WCuhiWEb71kYj/FVG4rJtVZtBhh6YtIqOpxXEkPDfyG4IpFV+h/wqwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BGHtCbBt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so2455215a12.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717174705; x=1717779505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5xx0RyZHVRYdA+i2tq2L6FCdad/7w6t5hRkVK59jgU=;
        b=BGHtCbBtidgcG+d4AV9P5FvOm6akq0QKNk9NwM+fRneFarDgdpL3m/1N8In9KT9LLy
         /+rQvv8Tzs4V+/m1FCmh8o7Dw60M5+otq/NkVnpDuq4xxjmvxmSeA3BSTz2jwPw3H4R4
         rKuu0OqxFta1qLwQhEOSj4sOt/IftLDBeomjTfGdWsOWrRFdbUsIg/gaI1LYizkzOWon
         LhSJ45UueIY53qtJYjNjJtUDRb+uXiTMiqMqm+9Yl1mQ8Y53GoNULkO+fB088P3BOeFU
         yGSkO6rwg9PcOp9eRqNoo/98DCYeEuVHOix6fA2GjfPJigBlGf+jI89HIgrdjCjfymy7
         88eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717174705; x=1717779505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5xx0RyZHVRYdA+i2tq2L6FCdad/7w6t5hRkVK59jgU=;
        b=mSalU9/bvKjndn93xq4KNnCZ/3wIfc540u/ymKLE1n71H1+LQx0JyU8UFAlqUl7hri
         bE7Q/2lG4/LNStvz/6naQmBkHv7fCO1DBxkCg6p2zBnhyGZbZnxQhmSRqZuY4cUuy4nl
         34K73JrAPV4d3+xLjzGwGDLFiJ73uAoJD6+4+KJda9M6B0OS4CqXaG9e1g2bnO8rm0R3
         EvJ469wDBzZb30hwTTV8H65+jvSc3u/mCdF/zb7gNXq93JQSSpHUEoUnyWyxeLj29IYG
         wyrbnzh4LReXrqeP98M/o9mwLyUw4IGyD0S93uhViog95KdqGQrnGFGrZ1gCC8deysGM
         w+EA==
X-Gm-Message-State: AOJu0Yz4gQ9Wnt7UHg9ASSjX75sShSBlnk8IlfRIBaZkwRBKbGPVtIXM
	/pWQyo58hgioTMcleZEAp1a/gvZ2HB1C2t9lScFb2tr3RSCwKZy1zPg7FWST/uqu/eBEHiY8CSN
	T8i4rQ+kS/wdC7RRyRoA2+dUl1/Xlg9pz4cH+5g==
X-Google-Smtp-Source: AGHT+IGLriP1YxK99Pam+kTFTQWmuJHkERLmVNSyEIQ+k8i0LCvU0BLDob6DGhcSuNAm2Q2bkGLCQixte550DbTbqa8=
X-Received: by 2002:a50:cc9b:0:b0:578:197b:30d3 with SMTP id
 4fb4d7f45d1cf-57a36382541mr1679095a12.2.1717174705169; Fri, 31 May 2024
 09:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
 <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
In-Reply-To: <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 May 2024 11:58:13 -0500
Message-ID: <CAO3-PboQ68+xFe4Z10L-s-k3NCgciGXNWM00-3wgqbPmGaBB9A@mail.gmail.com>
Subject: Re: [RFC net-next 1/6] net: add kfree_skb_for_sk function
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells <dhowells@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

 Thanks for the feedback.

On Fri, May 31, 2024 at 1:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, May 30, 2024 at 11:46=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wr=
ote:
> >
> > Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a few
> > local receive path. The function accepts an extra receiving socket
> > argument, which will be set in skb->cb for kfree_skb/consume_skb
> > tracepoint consumption. With this extra bit of information, it will be
> > easier to attribute dropped packets to netns/containers and
> > sockets/services for performance and error monitoring purposes.
>
> This is a lot of code churn...
>
> I have to ask : Why not simply adding an sk parameter to an existing
> trace point ?
>
Modifying a signature of the current tracepoint seems like a breaking
change, that's why I was saving the context inside skb->cb, hoping to
not impact any existing programs watching this tracepoint. But
thinking it twice, it might not cause a problem if the signature
becomes:

 trace_kfree_skb(const struct sk_buff *skb, void *location, enum
skb_drop_reason reason, const struct sock *sk)

As return values are usually not a thing for tracepoints, it is
probably still compatible. The cons is that the last "sk" still breaks
the integrity of naming. How about making a "kfree_skb_context"
internal struct and putting it as the last argument to "hide" the
naming confusion?

> If this not possible, I would rather add new tracepoints, adding new clas=
ses,
> because it will ease your debugging :
>
> When looking for TCP drops, simply use a tcp_event_sk_skb_reason instance=
,
> and voila, no distractions caused by RAW/ICMP/ICMPv6/af_packet drops.
>
> DECLARE_EVENT_CLASS(tcp_event_sk_skb_reason,
>
>      TP_PROTO(const struct sock *sk, const struct sk_buff *skb, enum
> skb_drop_reason reason),
> ...
> );

The alternative of adding another tracepoint could indeed work, we had
a few cases like that in the past, e.g.

https://lore.kernel.org/lkml/20230711043453.64095-1-ivan@cloudflare.com/
https://lore.kernel.org/netdev/20230707043923.35578-1-ivan@cloudflare.com/

But it does feel like a whack-a-mole thing. The problems are solvable
if we extend the kfree_skb tracepoint, so I would prefer to not add a
new tracepoint.

>
> Also, the name ( kfree_skb_for_sk) and order of parameters is confusing.
>
> I always prefer this kind of ordering/names :
>
> void sk_skb_reason_drop( [struct net *net ] // not relevant here, but
> to expand the rationale
>               struct sock *sk, struct sk_buff *skb, enum skb_drop_reason =
reason)
>
> Looking at the name, we immediately see the parameter order.
>
> The consume one (no @reason there) would be called
>
> void sk_skb_consume(struct sock *sk, struct sk_buff *skb);

I was intending to keep the "kfree_skb" prefix initially since it
would appear less surprising to kernel developers who used kfree_skb
and kfree_skb_reason. But your points do make good sense. How about
"kfree_sk_skb_reason" and "consume_sk_skb" here?

thanks
Yan

