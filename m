Return-Path: <netdev+bounces-99817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC38D6960
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530CDB21B83
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406B7F7D1;
	Fri, 31 May 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LhVIrZAi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B947F482
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182331; cv=none; b=R4JwaG4CtrfN2P16RkfdoPb0Cwqr6Jt9UjCFyNXIUUmzhcISLHmkevXPpAe4I3yagDcOgYbBTu6FZqirvUVtRSw43/cqYZg1D8epn1rk5pupTeilEjUW8K96oylGJBul5IIaceILR6QbQWBMgGsBAU7/JRgGAWTyUcG6XkPfE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182331; c=relaxed/simple;
	bh=JLgUk4/H0I49wI7AFpjfE5SBqXIrl4DmbD4W1JvveUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXETYv5Dw5/USlMFAlMWe2tJ3r7YJR6j7RapXnRsOc0yAcbJtXMHit/MchQdvE5zwyHa/KlLhDZDfmDw4pIAvLtSCurrse+Yag1c7Mgmn4kxu9AuroYPnmED2K2p6Kf+MLys8h1/Kdxr4e9vg98D5H6P/Crx/3QPbPCFl3lG/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LhVIrZAi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso1517170a12.2
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717182328; x=1717787128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI3ySpP1YuGuRU+0r2fjh+wjdLvP3upJGIzwxGrKcXs=;
        b=LhVIrZAiHb7iMJSGRxvYzuyS37uhblIV4+4flec2xUd0h9+pTRbsY6S4E1cRvrORPH
         jH3wgPoZVNRSrLa1erSkHI44EtEqEYqBhCSvrBg7kSAbQvB0M9Ry2Qv8xYmDoDTOPIDr
         /fjGQjac5/PT8FxjEb5NO+Vri925HWedruGDHcBobRcrJWZ7Bb/dTSCqxXbUNGs3lZV2
         UxUefJ9UHX83icT+tfjtNoWYvSypj8EL+IDbyQUzHVLWkP1yAze33zV57m0xWNF8UOMX
         +R/cBr5aqrGHNrv4+j8ix/BGlbzngEVcPvVGhSdWHYRv026D2OKiszL+7KUnjizxx8J9
         CNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182328; x=1717787128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI3ySpP1YuGuRU+0r2fjh+wjdLvP3upJGIzwxGrKcXs=;
        b=Do5CI1Uc2npCyXugKXp3EyZXbUhRguOZCYJ3J0E0Hg+GRwTrOFW8W+R6uDCfLr/0gZ
         fKgJdh6yznFNh8bWhNzD0o10HY1Kj5or8lOy3F2l18qdzu6uC6wDlwnr2FPifQvQG056
         aTJGvqJbIiVyfeMh+yAZbPnqPchSDsFHc6o37MUVHRtopxo/uR+VLB375gza0JocjpGy
         Z8u6GhVwr/uWEv6ViQfVuv5SqGellLjFI07QPxC6w8I6oZdKLDHVnZUpSCfUBHzxbM85
         6hzsdfuNZtDXrD0bOPx8T3IuHjgFIKZZ76BjdRf5cak6EkZbIzYXbk4oMWnVBSIsrgGJ
         sF8w==
X-Gm-Message-State: AOJu0YznpwUuUTl/pNpNK1zHKAI80m0x9YFc3Te1u3PmpibB9HinevSG
	sWr1YsiULRu1+h/ZwEdSoUMzWABiXU2xCV3jubZX/zvgM0GFdR37l09r8G5tEqaetRyutkrm826
	47DlNW4no6QNY7FNQp5jRCzf+8QCZx8s5z/fvIQ==
X-Google-Smtp-Source: AGHT+IGHM+cFCKr3cD4qLfBdzN50PJ4EDyUgAhS4Wnkb4lkIVrzCC1xfhFir50c+Rban7OD/Mp5ebucWbvjCKDVrJhg=
X-Received: by 2002:a50:9f22:0:b0:57a:2bfd:82b3 with SMTP id
 4fb4d7f45d1cf-57a36430e90mr1727721a12.23.1717182327616; Fri, 31 May 2024
 12:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
 <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
 <CAO3-PboQ68+xFe4Z10L-s-k3NCgciGXNWM00-3wgqbPmGaBB9A@mail.gmail.com> <CANn89iJ_rd_vUH1LPbby5vV=s=jWdpzvDKnm6H1YK=wRPWBiyw@mail.gmail.com>
In-Reply-To: <CANn89iJ_rd_vUH1LPbby5vV=s=jWdpzvDKnm6H1YK=wRPWBiyw@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 May 2024 14:05:16 -0500
Message-ID: <CAO3-PbqaiqWvc1vgHzj2-DEQUPCxTByp4r+zTBWyo-XP4u1G4A@mail.gmail.com>
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

On Fri, May 31, 2024 at 12:32=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, May 31, 2024 at 6:58=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > Hi Eric,
> >
> >  Thanks for the feedback.
> >
> > On Fri, May 31, 2024 at 1:51=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, May 30, 2024 at 11:46=E2=80=AFPM Yan Zhai <yan@cloudflare.com=
> wrote:
> > > >
> > > > Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a f=
ew
> > > > local receive path. The function accepts an extra receiving socket
> > > > argument, which will be set in skb->cb for kfree_skb/consume_skb
> > > > tracepoint consumption. With this extra bit of information, it will=
 be
> > > > easier to attribute dropped packets to netns/containers and
> > > > sockets/services for performance and error monitoring purposes.
> > >
> > > This is a lot of code churn...
> > >
> > > I have to ask : Why not simply adding an sk parameter to an existing
> > > trace point ?
> > >
> > Modifying a signature of the current tracepoint seems like a breaking
> > change, that's why I was saving the context inside skb->cb, hoping to
> > not impact any existing programs watching this tracepoint. But
> > thinking it twice, it might not cause a problem if the signature
> > becomes:
> >
> >  trace_kfree_skb(const struct sk_buff *skb, void *location, enum
> > skb_drop_reason reason, const struct sock *sk)
> >
> > As return values are usually not a thing for tracepoints, it is
> > probably still compatible. The cons is that the last "sk" still breaks
> > the integrity of naming. How about making a "kfree_skb_context"
> > internal struct and putting it as the last argument to "hide" the
> > naming confusion?
> >
> > > If this not possible, I would rather add new tracepoints, adding new =
classes,
> > > because it will ease your debugging :
> > >
> > > When looking for TCP drops, simply use a tcp_event_sk_skb_reason inst=
ance,
> > > and voila, no distractions caused by RAW/ICMP/ICMPv6/af_packet drops.
> > >
> > > DECLARE_EVENT_CLASS(tcp_event_sk_skb_reason,
> > >
> > >      TP_PROTO(const struct sock *sk, const struct sk_buff *skb, enum
> > > skb_drop_reason reason),
> > > ...
> > > );
> >
> > The alternative of adding another tracepoint could indeed work, we had
> > a few cases like that in the past, e.g.
> >
> > https://lore.kernel.org/lkml/20230711043453.64095-1-ivan@cloudflare.com=
/
> > https://lore.kernel.org/netdev/20230707043923.35578-1-ivan@cloudflare.c=
om/
> >
> > But it does feel like a whack-a-mole thing. The problems are solvable
> > if we extend the kfree_skb tracepoint, so I would prefer to not add a
> > new tracepoint.
>
> Solvable with many future merge conflicts for stable teams.
>
I don't quite follow it. I think this specific commit using skb->cb is
unnecessary so I am going to re-work it. As you initially mentioned,
maybe I should just extend kfree_skb tracepoint. I saw a similar
change dd1b527831a3("net: add location to trace_consume_skb()"), is it
something I might follow, or do you specifically mean changes like
this can annoy stable teams?

>
> >
> > >
> > > Also, the name ( kfree_skb_for_sk) and order of parameters is confusi=
ng.
> > >
> > > I always prefer this kind of ordering/names :
> > >
> > > void sk_skb_reason_drop( [struct net *net ] // not relevant here, but
> > > to expand the rationale
> > >               struct sock *sk, struct sk_buff *skb, enum skb_drop_rea=
son reason)
> > >
> > > Looking at the name, we immediately see the parameter order.
> > >
> > > The consume one (no @reason there) would be called
> > >
> > > void sk_skb_consume(struct sock *sk, struct sk_buff *skb);
> >
> > I was intending to keep the "kfree_skb" prefix initially since it
> > would appear less surprising to kernel developers who used kfree_skb
> > and kfree_skb_reason. But your points do make good sense. How about
> > "kfree_sk_skb_reason" and "consume_sk_skb" here?
> >
>
> IMO kfree_skb() and consume_skb() were a wrong choice. We have to live
> with them.
>
> It should have been skb_free(), skb_consume(), skb_alloc(),
> to be consistent.
>
> Following (partial) list was much better:
>
> skb_add_rx_frag_netmem, skb_coalesce_rx_frag, skb_pp_cow_data,
> skb_cow_data_for_xdp,
> skb_dump, skb_tx_error, skb_morph, skb_zerocopy_iter_stream, skb_copy_ubu=
fs,
> skb_clone, skb_headers_offset_update, skb_copy_header, skb_copy,
> skb_realloc_headroom, skb_expand_head, skb_copy_expand, skb_put,
> skb_push, skb_pull, skb_pull_data, skb_trim, skb_copy_bits,
> skb_splice_bits, skb_send_sock_locked, skb_store_bits,
> skb_checksum, skb_copy_and_csum_bits, skb_zerocopy_headlen,
> skb_zerocopy, skb_copy_and_csum_dev, skb_dequeue,
> skb_dequeue_tail, skb_queue_purge_reason, skb_errqueue_purge,
> skb_queue_head, skb_queue_tail, skb_unlink, skb_append,
> skb_split, skb_prepare_seq_read, skb_seq_read, skb_abort_seq_read,
> skb_find_text, skb_append_pagefrags, skb_pull_rcsum, skb_segment_list,
> skb_segment, skb_to_sgvec, skb_to_sgvec_nomark, skb_cow_data, skb_clone_s=
k,
> skb_complete_tx_timestamp, skb_tstamp_tx, skb_complete_wifi_ack,
> skb_partial_csum_set, skb_checksum_setup, skb_checksum_trimmed,
> skb_try_coalesce, skb_scrub_packet, skb_vlan_untag, skb_ensure_writable,
> skb_ensure_writable_head_tail, skb_vlan_pop, skb_vlan_push, skb_eth_pop,
> skb_eth_push, skb_mpls_push, skb_mpls_pop, skb_mpls_update_lse,
> skb_mpls_dec_ttl, skb_condense, skb_ext_add, skb_splice_from_iter
>
> (just to make my point very very clear)
>
> Instead we have a myriad of functions with illogical parameter
> ordering vs their names.
>
> I see no reason to add more confusion for new helpers.

ACK. Thanks for clarifying.

Yan

