Return-Path: <netdev+bounces-158190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2307A10E02
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0166167417
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C61FA14A;
	Tue, 14 Jan 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOCaVblg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41DB1DFD8B
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876609; cv=none; b=lF/uEIXSUJe/f0gotQa+3kNbH+NrE7RIyhSG8B9EUKqx4mS7hMUx5T7qdLaXc7NMqKLJaSXiagOwhLjHFZfVZCMP0qe9UfHWC+pBDyfHjcLFkzAYBhosp39X/Jr+cUa9gdqCaO2KlJCT7og9yRdJr6jlh1HZGg8gCjyUa8o5tOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876609; c=relaxed/simple;
	bh=g3RSz4tvQ+K8kYL7EDIG9hyMf9wv0irpaIEFqf7Zn+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQN90rskK4BC/L4zIWegpxz8b9AE6cyB37rHsU4D6jVOzSdy6H9OmIeNlfMq9JAWCZd6FYi6NsKdfWnex61B1nGPjV5wV+suK6FjDcC3ZhhPodKv4Dt9jCh1a91Pws2YiOKxHuv0qUZeKr/9rFtn0iuTDoMxWq3Br5HUtJng8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOCaVblg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso9580015a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736876606; x=1737481406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNTVUbPev2Susw6wdu2cyGHrOMaUb0OBH3JWwwciS6A=;
        b=WOCaVblgMUyP/pmpvBWG52jBpIqtdwrKwtIMmrM0LJXKMa35c7WtXO4N5MjwxEnZzl
         oQajoro2cdUNe8dYi20Uf8ol9fSwNmCQxQp3PKzKHn/h+uzUz5NENErhZhgP6Cz08+Fa
         QrsLy7nJCwD5c4AtO7Gf6MRsKoca8R/N/nQedxELfRErVfoL5KdTZhmHf5moGfN7dzgu
         ZP+VsS2yXDJ1BpBd/x20GBV/cTjaSUw1zdeLm1Ch9g+q+Bjvi8VRvOv+f7t0AjmmdM+J
         /YvvvCjAjzh1mETYt1ou3SbETG2iIMaT3x/2fcCXEZMKg5GlE71mEvmsrp9muE89LPyd
         Rntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736876606; x=1737481406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNTVUbPev2Susw6wdu2cyGHrOMaUb0OBH3JWwwciS6A=;
        b=B4QHZb/4rXPjxHNXlaZEEIGrK3orjbk5goCjIbzT0hxOnPkXUBs2mrVz/FLeouHGQE
         gbhPOXk7pU5/UJ1OvI4dnnzDE7eWJxwixlyd7x0cu6KJVdE1jcU5pQ5ut61ZigUiroRV
         9vaE0AUj0W9K3Ops0aSSqAWLrKFqwgpXTqWNVcaP8MXvq1XCyfJrujlntkglQH46M+JR
         60ulInNkZGtP8DLxt0kg9tgyE4TxpAmyE8jGPcheCUIxlB7sj0Ny6/7d0BUywRuBWKnH
         TTSeBSke148AAJQvea89OLy8EsoObO902AF35Hb1rrmzi7pKzEIAbDqjW58lk0PJ5Ui1
         JJhw==
X-Forwarded-Encrypted: i=1; AJvYcCU8x8EsCdDy5SYd5dAmOOUAz+ToNgNvNIG46JBqlgsKIh3my4vC38i/YEcO6pkPl26ES2wFNdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7ZR58KfnzWpVUaqsWi0ISV3rdnwO5l92HbjMiCJbm/iVlWub
	2cCx3GCQuqHJtrLbq/sBTU7lc8q/0y+jgVJUvWHOE6joK0OLX+JKud2jej/g3rVmza8e3k4+rZ7
	ckkZDludHnAn8FNUfYunWzW3iTflodFGMcZB9
X-Gm-Gg: ASbGncut2qUan5OZSFSvsK+V6MG8GviQ0tKH5zyzu9GTZxCpVdFe0TpvVZcuAUdGHwR
	1jLgrZ+mJ0yeH604cw8nvq5itEm9PdtnedaKufQ==
X-Google-Smtp-Source: AGHT+IFzTWI62UvqCB5IdmtsIaLJLBkThu6h1KkwDfNMS0U5jS0EWO8wF3L9m6Rj6WOPwj6CnnraA+RdB+SsYxlHrA8=
X-Received: by 2002:a05:6402:50d4:b0:5d0:9054:b119 with SMTP id
 4fb4d7f45d1cf-5d972e63dd4mr56979803a12.21.1736876606178; Tue, 14 Jan 2025
 09:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed399406a6ffad5097fa618c3bc7a4ac59546c62.1736869543.git.gnault@redhat.com>
In-Reply-To: <ed399406a6ffad5097fa618c3bc7a4ac59546c62.1736869543.git.gnault@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 18:43:15 +0100
X-Gm-Features: AbW1kvZeC67blwoiBPqZHrEQE5Xccb5vHPa0Wzmu4PYZWSG7h3tJf1ebn1aW8gQ
Message-ID: <CANn89iJQus-pqLta39df06DJLES8KgytN5iaVz9xv_HAz3F6Vw@mail.gmail.com>
Subject: Re: [PATCH net-next] dccp: Prepare dccp_v4_route_skb() to .flowi4_tos conversion.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	dccp@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:46=E2=80=AFPM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
> ip_sock_rt_tos() which returns a __u8. This will ease the conversion
> of fl4->flowi4_tos to dscp_t, as it will just require to drop the
> inet_dscp_to_dsfield() call.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  net/dccp/ipv4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index 5926159a6f20..9e64dbd38cd7 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -15,6 +15,7 @@
>
>  #include <net/icmp.h>
>  #include <net/inet_common.h>
> +#include <net/inet_dscp.h>
>  #include <net/inet_hashtables.h>
>  #include <net/inet_sock.h>
>  #include <net/protocol.h>
> @@ -473,7 +474,7 @@ static struct dst_entry* dccp_v4_route_skb(struct net=
 *net, struct sock *sk,
>                 .flowi4_oif =3D inet_iif(skb),
>                 .daddr =3D iph->saddr,
>                 .saddr =3D iph->daddr,
> -               .flowi4_tos =3D ip_sock_rt_tos(sk),
> +               .flowi4_tos =3D inet_dscp_to_dsfield(inet_sk_dscp((inet_s=
k(sk)))),

You probably can replace ((X)) with (X) ?
->
 .flowi4_tos =3D inet_dscp_to_dsfield(inet_sk_dscp(inet_sk(sk))),


>                 .flowi4_scope =3D ip_sock_rt_scope(sk),
>                 .flowi4_proto =3D sk->sk_protocol,
>                 .fl4_sport =3D dccp_hdr(skb)->dccph_dport,
> --
> 2.39.2
>

