Return-Path: <netdev+bounces-99793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321748D682D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD3E2812A4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976F15DBB2;
	Fri, 31 May 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRFkAU7s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA02E3F2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176779; cv=none; b=IB3odjOS9PEQx9c+cEAxwRm9z1840tk/chpIqLTlcTOoEDab/m6a2eC0VfSjsIOG7r/be47t7aYcw0KzCsbko5EOdsUrxZbjpH/qfinyfEwV0YCbQpJvC6N/JSskigUucSe25TKvHAt1JPAwGTb2eGm/uQVOgRF25bbP/HpkxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176779; c=relaxed/simple;
	bh=Yjwu0m+erAt8XFKFMLD6Bnxw1BqoPUA8ibnGos7ynxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGqHTnzDQaVlAHzOLUSN4hbCFXi8QyVndiHK8RMe9NpFUsSnhdrM0tJ2VZ31q66YXW9cAHLDUjiYua/IXKbQx7+i0LRUdcAPbiHQN9fJxQyZ/oX7f28SmF6BsY5bWq1rq2sekuqw0h+ODjMxZ7LmdrTKTp7yNiFPryO7sl1vUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRFkAU7s; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so1206a12.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717176776; x=1717781576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMppGFFrT5MnAdCHtOHnnUXgbQ/hA3PsMnZtuj4qBMk=;
        b=KRFkAU7st43Cdiq4nVUn5JGa6MxYne7t9z/z4hoIkUhr4ERXBz6LctBHaW90cbNCYX
         m/qnrRnvDUof3V1psMG9Qfd0qGtlF2i/fqZHlsmQ9dazFEplzTrhAIPCXfMDMbz9eIHs
         7TjQhHynZOqwxYcRt7OJU8fi2wA9XKLJUDC7YuiahiK27dYnEHW3OKZTMTFMb8VEiwCR
         HhQk7M0MTcvDGP7aQWNgKUcDqT55p5mstWMIyzO6h+oGzKjXvHQvhWerIEqI0Mow5TDg
         i027iyUVFrMg9oprSDjToQyTORLdxlYzG17kGJ3h9K54t1WSslEB8al8jl3Sp1xKexpl
         BqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717176776; x=1717781576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMppGFFrT5MnAdCHtOHnnUXgbQ/hA3PsMnZtuj4qBMk=;
        b=TsilhCArgEv9HesnLp3WDNmZ6+nXs8XHQpRx1ik+a6+x+ovoYQ/xKDvKO1sivG1IbF
         p5ai9X+aAHCfz/3H6bK5OK9w9T8lAT6OVs05K2dIhsnp6DqKXvphi7rLBPIlFLgHPR+V
         XPO9PHrFaJqw2YPapTH5vL8B4ZvFjeqbhbLWwp6gHx23LpajiRWK2JcNVAqjGp0hHopa
         Ltm496WuWnZ4nTXvkvmEOecsdxSh/a5PrpF1Bqu0FHf1lvcCcpeT+O/0YmJYT83AnngQ
         tKj+wgQ3jPc28dLssc3CIdD3trso89hqPcLXPDiNkdES9WDAC0vPQ34eeaei5bDctE6O
         6DgA==
X-Gm-Message-State: AOJu0Ywm0hTEc6VfbxcxE6mfB/FoylqnanpzOOfGJS6c6BwJ9f+I1Vqy
	XlQdtT+CYfWgTNuC8JxRMFvKl6rK1YBePBvDmSjnjSvZUhFEkQJcq/v5LG2DNOA9+uKli+k0hsO
	lB/1BnjGIpA7BYOuTriFZg5CJM8GUvHuZ5YNN
X-Google-Smtp-Source: AGHT+IHjgVhIXQvVdwtHzJuyaNq2GU/GVBnM8Bv/P4NUq/vSKvPAUzqUKZazgAiWkdEk2muNzf0p2aUiASM34KOmnMk=
X-Received: by 2002:a05:6402:682:b0:57a:3103:9372 with SMTP id
 4fb4d7f45d1cf-57a37923832mr160622a12.7.1717176773754; Fri, 31 May 2024
 10:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
 <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com> <CAO3-PboQ68+xFe4Z10L-s-k3NCgciGXNWM00-3wgqbPmGaBB9A@mail.gmail.com>
In-Reply-To: <CAO3-PboQ68+xFe4Z10L-s-k3NCgciGXNWM00-3wgqbPmGaBB9A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 19:32:40 +0200
Message-ID: <CANn89iJ_rd_vUH1LPbby5vV=s=jWdpzvDKnm6H1YK=wRPWBiyw@mail.gmail.com>
Subject: Re: [RFC net-next 1/6] net: add kfree_skb_for_sk function
To: Yan Zhai <yan@cloudflare.com>
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

On Fri, May 31, 2024 at 6:58=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Hi Eric,
>
>  Thanks for the feedback.
>
> On Fri, May 31, 2024 at 1:51=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, May 30, 2024 at 11:46=E2=80=AFPM Yan Zhai <yan@cloudflare.com> =
wrote:
> > >
> > > Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a few
> > > local receive path. The function accepts an extra receiving socket
> > > argument, which will be set in skb->cb for kfree_skb/consume_skb
> > > tracepoint consumption. With this extra bit of information, it will b=
e
> > > easier to attribute dropped packets to netns/containers and
> > > sockets/services for performance and error monitoring purposes.
> >
> > This is a lot of code churn...
> >
> > I have to ask : Why not simply adding an sk parameter to an existing
> > trace point ?
> >
> Modifying a signature of the current tracepoint seems like a breaking
> change, that's why I was saving the context inside skb->cb, hoping to
> not impact any existing programs watching this tracepoint. But
> thinking it twice, it might not cause a problem if the signature
> becomes:
>
>  trace_kfree_skb(const struct sk_buff *skb, void *location, enum
> skb_drop_reason reason, const struct sock *sk)
>
> As return values are usually not a thing for tracepoints, it is
> probably still compatible. The cons is that the last "sk" still breaks
> the integrity of naming. How about making a "kfree_skb_context"
> internal struct and putting it as the last argument to "hide" the
> naming confusion?
>
> > If this not possible, I would rather add new tracepoints, adding new cl=
asses,
> > because it will ease your debugging :
> >
> > When looking for TCP drops, simply use a tcp_event_sk_skb_reason instan=
ce,
> > and voila, no distractions caused by RAW/ICMP/ICMPv6/af_packet drops.
> >
> > DECLARE_EVENT_CLASS(tcp_event_sk_skb_reason,
> >
> >      TP_PROTO(const struct sock *sk, const struct sk_buff *skb, enum
> > skb_drop_reason reason),
> > ...
> > );
>
> The alternative of adding another tracepoint could indeed work, we had
> a few cases like that in the past, e.g.
>
> https://lore.kernel.org/lkml/20230711043453.64095-1-ivan@cloudflare.com/
> https://lore.kernel.org/netdev/20230707043923.35578-1-ivan@cloudflare.com=
/
>
> But it does feel like a whack-a-mole thing. The problems are solvable
> if we extend the kfree_skb tracepoint, so I would prefer to not add a
> new tracepoint.

Solvable with many future merge conflicts for stable teams.


>
> >
> > Also, the name ( kfree_skb_for_sk) and order of parameters is confusing=
.
> >
> > I always prefer this kind of ordering/names :
> >
> > void sk_skb_reason_drop( [struct net *net ] // not relevant here, but
> > to expand the rationale
> >               struct sock *sk, struct sk_buff *skb, enum skb_drop_reaso=
n reason)
> >
> > Looking at the name, we immediately see the parameter order.
> >
> > The consume one (no @reason there) would be called
> >
> > void sk_skb_consume(struct sock *sk, struct sk_buff *skb);
>
> I was intending to keep the "kfree_skb" prefix initially since it
> would appear less surprising to kernel developers who used kfree_skb
> and kfree_skb_reason. But your points do make good sense. How about
> "kfree_sk_skb_reason" and "consume_sk_skb" here?
>

IMO kfree_skb() and consume_skb() were a wrong choice. We have to live
with them.

It should have been skb_free(), skb_consume(), skb_alloc(),
to be consistent.

Following (partial) list was much better:

skb_add_rx_frag_netmem, skb_coalesce_rx_frag, skb_pp_cow_data,
skb_cow_data_for_xdp,
skb_dump, skb_tx_error, skb_morph, skb_zerocopy_iter_stream, skb_copy_ubufs=
,
skb_clone, skb_headers_offset_update, skb_copy_header, skb_copy,
skb_realloc_headroom, skb_expand_head, skb_copy_expand, skb_put,
skb_push, skb_pull, skb_pull_data, skb_trim, skb_copy_bits,
skb_splice_bits, skb_send_sock_locked, skb_store_bits,
skb_checksum, skb_copy_and_csum_bits, skb_zerocopy_headlen,
skb_zerocopy, skb_copy_and_csum_dev, skb_dequeue,
skb_dequeue_tail, skb_queue_purge_reason, skb_errqueue_purge,
skb_queue_head, skb_queue_tail, skb_unlink, skb_append,
skb_split, skb_prepare_seq_read, skb_seq_read, skb_abort_seq_read,
skb_find_text, skb_append_pagefrags, skb_pull_rcsum, skb_segment_list,
skb_segment, skb_to_sgvec, skb_to_sgvec_nomark, skb_cow_data, skb_clone_sk,
skb_complete_tx_timestamp, skb_tstamp_tx, skb_complete_wifi_ack,
skb_partial_csum_set, skb_checksum_setup, skb_checksum_trimmed,
skb_try_coalesce, skb_scrub_packet, skb_vlan_untag, skb_ensure_writable,
skb_ensure_writable_head_tail, skb_vlan_pop, skb_vlan_push, skb_eth_pop,
skb_eth_push, skb_mpls_push, skb_mpls_pop, skb_mpls_update_lse,
skb_mpls_dec_ttl, skb_condense, skb_ext_add, skb_splice_from_iter

(just to make my point very very clear)

Instead we have a myriad of functions with illogical parameter
ordering vs their names.

I see no reason to add more confusion for new helpers.

