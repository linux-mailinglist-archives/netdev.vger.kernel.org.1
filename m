Return-Path: <netdev+bounces-172643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5A5A559BC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DBA1718B2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845601FC11F;
	Thu,  6 Mar 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bidKEMmE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35E279338
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299974; cv=none; b=ngtwQRyrWuKgND1SkM7m5H49+qQx31syn4Hk4Lr7pmwqzJYEeMW+PL+WTAJkmA6U73hnBvpW7BczWXjpfWnWVLmbf7fcmAgZHPDw+jhWRpBnCuo+U3x2ue4/+W7o5fhqoPOYrJFWEnlUqy52UkI7gSV6iAV+CIq9Rlx5WiowOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299974; c=relaxed/simple;
	bh=VcVQVZsw2Mva33VX5MMwYKuFglGYXsfKFw0U7WHnkBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssahAAaVfTaZhfH8M0bgn62TADZZs7emnwPmwnsVw40CZHj9iEZ0SrrXbZ6Z7MlmkjPLBOqcEC+Uufw4+B4HDXMYhFrtkmqZ66xahxjOPPWDraWJTcSCYLRA7KdBhRpKB/L4e3UmcqC7qCdW2sIvvyg9WD79Yp4ICCQxi8XPVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bidKEMmE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54954fa61c8so1365319e87.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741299971; x=1741904771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz+ztoFCrEz7wTkdNhztSYbp1A3kxnM2qM63vYDcoyQ=;
        b=bidKEMmEOqsQMkatYlDa90JsXAQ6g33ZGgKuKrKNt5oXjMj/Y98Vi44krQ7AS4XpGa
         xtoryV0ha7KwB8E/mRFGGEZCoi7GGvj0yXRPS72yZ8cKGzvgB8SJZw7GqR78R/Pq6qbe
         9M7cV+apF3KgZX3IQHK1Xhw1ced3nHIIZp1+HtZLqBqUxZldo5tHaRbYWQrRew5KPrGA
         aMQjlDS/CcUO1de/5RApopCuQhsH1768SlHdYvLMPYaeTFUyyY7utY1jA27oyPEZxhN1
         dBUG9HpFkukoeB8EU+0fH2q1Z6OgDFyK0emC9qDPI94OcGCuPNidNxUih6pAFQ6j+koh
         3lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299971; x=1741904771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz+ztoFCrEz7wTkdNhztSYbp1A3kxnM2qM63vYDcoyQ=;
        b=hoE51LECx0l8h1KhL7PoLi28XNC4KLRhNEiQfaGlfLR/ze7E1ermf4hDZ8OB59KJa1
         igUTS75pjfq7o7D+zoMQydZsaZyDoOmVmPSc55Op6JMLqgfGlv1FdchFOTRXp+WanWhW
         BgN1sxEdjFmTHjgwtik3wUhXJAnHbSBzpHyCMsb0jFLeMxDlZerSb8BpJnlGx0yIX1D4
         keyeq/uMp5e6lLm4e9SCkQGcHImtsRqaiA5BoQF7y2eK7rhxs3ksv/FV/QapA920azZL
         eIZ8UFyeUl3tc6MdsVScK1LDtJjcqsYgydUhZ5Etr16aV46FqKem26wp7pzygjSl4Bta
         GMEw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZjrB9nS9yUDfRrI/qFQeyl1rcY/b1zuqgS9xDFhxdoUTcU6Ub+j0lLrdMTLi6KRp2UnD8MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhhZa4lFAqW0hhTNBrOZP8gw+SM5vmNpTwSoQRXVou44wlmw/
	UM386UL+Tl+/JwLmk8VGEXoB7mG1oNqwtewi0FaR3OY2yICUDwOxNZJSjQl8jARICTpK97E6n/Y
	W4sSynRoXUj5z2aaymDbNQVlYrqX+RkqvWuQN
X-Gm-Gg: ASbGncuo0Rdd5gpsTjGnxBboyIMDkyiRnuA2DqVrnwTqvjvglvHcjzh1tKeMYcEc1Kf
	RHsSBO2edJovwoTruG+HQoXKaP91Bfru1r5AmZpoGuR4yOyMFPfjWAwk17jypmwm8lx30DXFUk6
	Fe3VoeMns0EhAHp6r2Hx3vs8PrxjTVBZpWDP0AA5UDvFWNT3sHSad3Y8kGAM/3
X-Google-Smtp-Source: AGHT+IFA+tN0laTQ0wbQLy5AyrNHomLVhw7MjPMP3WSQtVEg1FEjodPrecLmUDuuz7/aYEXcakm/l3ENnb4cOa17ID0=
X-Received: by 2002:a05:6512:3b9b:b0:549:3b4f:4b39 with SMTP id
 2adb3069b0e04-54990e298bfmr342834e87.10.1741299970426; Thu, 06 Mar 2025
 14:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741275846.git.pabeni@redhat.com> <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
 <67c9fb8199ef0_15800294cc@willemb.c.googlers.com.notmuch> <840bec2f-51a6-4036-bf9a-f215a4db1be5@redhat.com>
In-Reply-To: <840bec2f-51a6-4036-bf9a-f215a4db1be5@redhat.com>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 6 Mar 2025 17:25:33 -0500
X-Gm-Features: AQ5f1Joopu4YWZIW9KmRM-IkbRvCLNIyHENj0As-tPQOKGWmp5UT6LXVhlsZwnA
Message-ID: <CA+FuTScuTVjJLZFzMrufhp9+WzUnvmtsvShN6FWPx1R_Cau7Uw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] udp_tunnel: create a fast-path GRO lookup.
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 3/6/25 8:46 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> Most UDP tunnels bind a socket to a local port, with ANY address, no
> >> peer and no interface index specified.
> >> Additionally it's quite common to have a single tunnel device per
> >> namespace.
> >>
> >> Track in each namespace the UDP tunnel socket respecting the above.
> >> When only a single one is present, store a reference in the netns.
> >>
> >> When such reference is not NULL, UDP tunnel GRO lookup just need to
> >> match the incoming packet destination port vs the socket local port.
> >>
> >> The tunnel socket never set the reuse[port] flag[s], when bound to no
> >> address and interface, no other socket can exist in the same netns
> >> matching the specified local port.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >
> >> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> >> index c1a85b300ee87..ac6dd2703190e 100644
> >> --- a/net/ipv4/udp_offload.c
> >> +++ b/net/ipv4/udp_offload.c
> >> @@ -12,6 +12,38 @@
> >>  #include <net/udp.h>
> >>  #include <net/protocol.h>
> >>  #include <net/inet_common.h>
> >> +#include <net/udp_tunnel.h>
> >> +
> >> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> >> +static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
> >> +
> >> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, b=
ool add)
> >> +{
> >> +    bool is_ipv6 =3D sk->sk_family =3D=3D AF_INET6;
> >> +    struct udp_sock *tup, *up =3D udp_sk(sk);
> >> +    struct udp_tunnel_gro *udp_tunnel_gro;
> >> +
> >> +    spin_lock(&udp_tunnel_gro_lock);
> >> +    udp_tunnel_gro =3D &net->ipv4.udp_tunnel_gro[is_ipv6];
> >
> > It's a bit odd to have an ipv6 member in netns.ipv4. Does it
> > significantly simplify the code vs a separate entry in netns.ipv6?
>
> The code complexity should not change much. I place both the ipv4 and
> ipv6 data there to allow cache-line based optimization, as all the netns
> fast-path fields are under struct netns_ipv4.
>
> Currently the UDP tunnel related fields share the same cache-line of
> `udp_table`.

That's reason enough. Since you have to respin, please add a comment
in the commit message. It looked surprising at first read.

> >> @@ -631,8 +663,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk=
_buff *skb, __be16 sport,
> >>  {
> >>      const struct iphdr *iph =3D skb_gro_network_header(skb);
> >>      struct net *net =3D dev_net_rcu(skb->dev);
> >> +    struct sock *sk;
> >>      int iif, sdif;
> >>
> >> +    sk =3D udp_tunnel_sk(net, false);
> >> +    if (sk && dport =3D=3D htons(sk->sk_num))
> >> +            return sk;
> >> +
> >
> > This improves tunnel performance at a slight cost to everything else,
> > by having the tunnel check before the normal socket path.
> >
> > Does a 5% best case gain warrant that? Not snark, I don't have a
> > good answer.
>
> We enter this function only when udp_encap_needed_key is true: ~an UDP
> tunnel has been configured[1].
>
> When tunnels are enabled, AFAIK the single tunnel device is the most
> common and most relevant scenario, and in such setup this gives
> measurable performance improvement. Other tunnel-based scenarios will
> see the additional cost of a single conditional (using data on an
> already hot cacheline, due to the above layout).
>
> If you are concerned about such cost, I can add an additional static
> branch protecting the above code chunk, so that the conditional will be
> performed only when there is a single UDP tunnel configured. Please, let
> me know.
>
> Thanks,
>
> Paolo
>
> [1] to be more accurate: an UDP tunnel or an UDP socket with GRO enabled

Oh right, not all regular UDP GRO. That is okay then.

