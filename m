Return-Path: <netdev+bounces-165258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7395A314D5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BB07A2B2B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4FE1E4929;
	Tue, 11 Feb 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdM+eg5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE81E2858
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301452; cv=none; b=avrfHty14Y6olZSSswWurkV1vquyEon5lQInBiPejFocx3ULQLNhPwXu+DOzi3XpZX5a/oZ4N1hLrhImNV59yCfZ5aMSUvLjwfW3RIKrZ1EGhgsLwhaNiSCa40dxisG+VtW2RCwIsBsGQ0yM5reEfrfsWBzp3P5k/1oIAi9s6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301452; c=relaxed/simple;
	bh=hj5Z2u8LqaMazd2JJDrbNqOEFjkYiAsCjMTZP1KykXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bl7L7LKrYzkhy1FDl0iG8jEaW5EXDflU87yprVCEv9fjktMEkyA4qPT9/atepv5etRGtTFwwxUqx50gmcZXkPCqlHxAgq4EwupeGJWHtBAXZ7O6VJi2cRLgCNjzlQeqm3EVvG+thYaHI98sDUWFu6EI3tMJ/J7zzs9xnEW2yl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdM+eg5i; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de5a8a96abso6085174a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739301448; x=1739906248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pb4sV0RkhYvx4VeJ0GQL+kfIhOVpji/TT+K2/0/4C0=;
        b=gdM+eg5ixQ8nqXc0dkGSAjoQqnJu+4RFMQ1U6+YFCNxiUTzI+GfMXVNGV/UZJ6cPtD
         QsGvtHrrPgXd+vMfFzr8u22P4xFB03zkNVIuIz5J7qJtMHXAFqBKVe2iH8N9y6kZ1gAF
         HOzaIc4ZHHWd1y9jHs91nhQr9fFLh7VzAnVVcOMY/ZKBahEN3kku2ondZlezPgJUd+nN
         KR8/g8eelES2vzjNgcYPB/shcQg3zuaKFq/VmMgwAKwG5QNCWz34pp4f8hwAH1ftL+GY
         tdg48/j1EXtJ3A1ce4CmB+csEOteopxgrYlDOpXXrCwX7SstJKfKYbhlWdpk+MZdOC4D
         zXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301448; x=1739906248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pb4sV0RkhYvx4VeJ0GQL+kfIhOVpji/TT+K2/0/4C0=;
        b=nfEXB2k0GCz6NyTodnpEbxKv58l5xpABJgR0WQ3yN0npU9qQMPv7XGfDbzBGLZLXEZ
         at4Dli/o2viCNDlYlHIz9Ov6JOU4DHKHaPSx7sTXHWokxohhXksHLai0/AVxXTekJP4n
         jlBSYt3LssjBfBXr9egBKho5wmiKl1D3lruxnyfXhsoW5IqL2g3ZW09/j3RG1OlDuJ+W
         mPdXL94dMNbukA1xCi2hrX4SELpFAJcZ5JY50uBVarJbYQTclEkmapysBpD4KqfzfzXt
         ckGgqlaEOVZ+pKaQXoYWBSHumV8PoxrJy3cVasxHFT1rK1KvaPLUenGv91Uft2JeRb48
         f9XQ==
X-Gm-Message-State: AOJu0Yz/2NcGbET2qpb/AXzCFKB/iA9staAzHiK44a3br1Fx/SXaez+g
	PUNFv7l/ac/qE1GuzfH8fHtFiYy0UtSrt5IcM7gsTpvU0OHsMoEcIWP+OWCViODllTVSZzF1lzA
	S6xV0EJnonGv141PZOx5fOOYM9j4csOAGyU7C
X-Gm-Gg: ASbGnctAyDQ41NFU8IvRpUxToPNb9ySmU7JU9CULtZjSOrPKQGRqhTcao2A+ggG6Zmi
	4K5w6ojxY52QcWjAxKf83gl2Rj3humIv9lVwDRlOrFJ9gKQufo7zgU0nWRrUM/zj1dg9OuGZ7nQ
	==
X-Google-Smtp-Source: AGHT+IFqx+auB67WYNFwYtQrV5xYuIOa0AnowYZlEdLYfoMVKLoii0Cf7iweqDm2aZGPqBJrZ2oH/so4temsURZCb+Y=
X-Received: by 2002:a05:6402:3892:b0:5de:4a8b:4c9c with SMTP id
 4fb4d7f45d1cf-5deade09820mr791268a12.32.1739301448202; Tue, 11 Feb 2025
 11:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net>
 <CANn89iJbzed1HnW7QHSRWno92hLAbQH+iaitAutqRh=CK9koaw@mail.gmail.com> <Z6ucMj5FukT_lecR@hog>
In-Reply-To: <Z6ucMj5FukT_lecR@hog>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 20:17:17 +0100
X-Gm-Features: AWEUYZl3QKOxZ6EWVcp40ku5rSWQYF0djnimmK0eUYGYGGhL0DgxMKQ3mfBWb5w
Message-ID: <CANn89iJ=qUt=tgPUMUcAjeNunuYByMNCOcTzqABe_qLu-BiAPQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: drop skb extensions before skb_attempt_defer_free
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, Xiumei Mu <xmu@redhat.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:51=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2025-02-10, 17:24:43 +0100, Eric Dumazet wrote:
> > On Mon, Feb 10, 2025 at 5:02=E2=80=AFPM Sabrina Dubroca <sd@queasysnail=
.net> wrote:
> > >
> > > Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> > > running tests that boil down to:
> > >  - create a pair of netns
> > >  - run a basic TCP test over ipcomp6
> > >  - delete the pair of netns
> > >
> > > The xfrm_state found on spi_byaddr was not deleted at the time we
> > > delete the netns, because we still have a reference on it. This
> > > lingering reference comes from a secpath (which holds a ref on the
> > > xfrm_state), which is still attached to an skb. This skb is not
> > > leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> > > skb_attempt_defer_free.
> > >
> > > The problem happens when we defer freeing an skb (push it on one CPU'=
s
> > > defer_list), and don't flush that list before the netns is deleted. I=
n
> > > that case, we still have a reference on the xfrm_state that we don't
> > > expect at this point.
> > >
> > > tcp_eat_recv_skb is currently the only caller of skb_attempt_defer_fr=
ee,
> > > so I'm fixing it here. This patch also adds a DEBUG_NET_WARN_ON_ONCE
> > > in skb_attempt_defer_free, to make sure we don't re-introduce this
> > > problem.
> > >
> > > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu=
 lists")
> > > Reported-by: Xiumei Mu <xmu@redhat.com>
> > > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > > ---
> > > A few comments:
> > >  - AFAICT this could not happen before 68822bdf76f1, since we would
> > >    have emptied the (per-socket) defer_list before getting to ->exit(=
)
> > >    for the netns
> > >  - I thought about dropping the extensions at the same time as we
> > >    already drop the dst, but Paolo said this is probably not correct =
due
> > >    to IP_CMSG_PASSSEC
> >
> > I think we discussed this issue in the past.
> >
> > Are you sure IP_CMSG_PASSSEC  is ever used by TCP ?
>
> After checking, I don't think so. The only way TCP can get to
> IP_CMSG_PASSSEC is through the error queue, so it shouldn't matter.
>
> The original commit (2c7946a7bf45 ("[SECURITY]: TCP/UDP getpeersec"))
> also says that TCP should be using SO_PEERSEC for that purpose
> (although likely based on the secpath as well, but not packet per
> packet).
>
> Based on the chat you had with Paul Moore back in November, it seems
> any point after tcp_filter should be fine:
>
> https://lore.kernel.org/netdev/CAHC9VhS3yuwrOPcH5_iRy50O_TtBCh_OVWHZgzfFT=
Yqyfrw_zQ@mail.gmail.com
>
>
> > Many layers in TCP can aggregate packets, are they aware of XFRM yet ?
>
> I'm not so familiar with the depths of TCP, but with what you're
> suggesting below, AFAIU the cleanup should happen before any
> aggregation attempt (well, there's GRO...).
>
>
> [...]
> > If we think about it, storing thousands of packets in TCP sockets recei=
ve queues
> > with XFRM state is consuming memory for absolutely no purpose.
>
> True. I went with the simpler (less likely to break things
> unexpectedly) fix for v1.
>
> > It is worth noting MPTCP  calls skb_ext_reset(skb) after
> > commit 4e637c70b503b686aae45716a25a94dc3a434f3a ("mptcp: attempt
> > coalescing when moving skbs to mptcp rx queue")
> >
> > I would suggest calling secpath_reset() earlier in TCP, from BH
> > handler, while cpu caches are hot,
> > instead of waiting for recvmsg() to drain the receive queue much later =
?
>
> Ok. So in the end it would look a lot like what you proposed in a
> discussion with Ilya:
> https://lore.kernel.org/netdev/CANn89i+JdDukwEhZ%3D41FxY-w63eER6JVixkwL+s=
2eSOjo6aWEQ@mail.gmail.com/
>
> (as Paolo noticed, we can't just do skb_ext_reset because at least in
> tcp_data_queue the MPTCP extension has just been attached)
>
> An additional patch could maybe add DEBUG_NET_WARN_ON_ONCE at the time
> we add skbs to sk_receive_queue, to check we didn't miss (or remove in
> the future) places where the dst or secpath should have been dropped?

Sure, adding the  DEBUG_NET_WARN_ON_ONCE() is absolutely fine.

>
> -------- 8< --------
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5b2b04835688..87c1e98d76cf 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -683,6 +683,12 @@ void tcp_fin(struct sock *sk);
>  void tcp_check_space(struct sock *sk);
>  void tcp_sack_compress_send_ack(struct sock *sk);
>
> +static inline void tcp_skb_cleanup(struct sk_buff *skb)
> +{
> +       skb_dst_drop(skb);
> +       secpath_reset(skb);
> +}
> +
>  /* tcp_timer.c */
>  void tcp_init_xmit_timers(struct sock *);
>  static inline void tcp_clear_xmit_timers(struct sock *sk)
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 0f523cbfe329..b815b9fc604c 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -178,7 +178,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_=
buff *skb)
>         if (!skb)
>                 return;
>
> -       skb_dst_drop(skb);
> +       tcp_cleanup_skb(skb);
>         /* segs_in has been initialized to 1 in tcp_create_openreq_child(=
).
>          * Hence, reset segs_in to 0 before calling tcp_segs_in()
>          * to avoid double counting.  Also, tcp_segs_in() expects
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index eb82e01da911..bb0811c38908 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5245,7 +5245,7 @@ static void tcp_data_queue(struct sock *sk, struct =
sk_buff *skb)
>                 __kfree_skb(skb);
>                 return;
>         }
> -       skb_dst_drop(skb);
> +       tcp_cleanup_skb(skb);
>         __skb_pull(skb, tcp_hdr(skb)->doff * 4);
>
>         reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> @@ -6226,7 +6226,7 @@ void tcp_rcv_established(struct sock *sk, struct sk=
_buff *skb)
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPHITS);
>
>                         /* Bulk data transfer: receiver */
> -                       skb_dst_drop(skb);
> +                       tcp_cleanup_skb(skb);
>                         __skb_pull(skb, tcp_header_len);
>                         eaten =3D tcp_queue_rcv(sk, skb, &fragstolen);
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index cc2b5194a18d..2632844d2c35 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2027,7 +2027,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buf=
f *skb,
>          */
>         skb_condense(skb);
>
> -       skb_dst_drop(skb);
> +       tcp_cleanup_skb(skb);
>
>         if (unlikely(tcp_checksum_complete(skb))) {
>                 bh_unlock_sock(sk);
> --

This looks much better to me ;)

