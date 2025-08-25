Return-Path: <netdev+bounces-216642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C3B34B94
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6916A1A8826D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2086E22C355;
	Mon, 25 Aug 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2DKZD7t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBB28153A
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153057; cv=none; b=ijT+j80YyqolGPVzrgP7zznzJX8WSgA1fhqduAT3ERRZTPW+6RluxLxNTk+6zEwpLBT1nJvXsQ0jyOM2O/I1lDQJQY/TF8H9HvbhUq21xKcciUGETacfBGrZXkGuWdDF7pcSyIMo2PRX7E5fNmccOtGQRdtVDYUaIOE5Ww0l8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153057; c=relaxed/simple;
	bh=BT7gbQqNyNbBUdjc8yDBlFvyUQ/SPV9uvzCpHQAnKd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjXJpZQAgEJiBC3yripf5zLupUy6WbuhffjU3JRsFIaGRhoQUPAbz+nT554cR5qw4vvMCoA/6fKHOl5tB7ka3MTki9gjCC4ITd5i2ehYrtAxGpNQWkiBGXZqW+N4g7o2ign52L4ARWBT1aoE1yh9XJMb4AXEZuCeX6GORIKRbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2DKZD7t; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so608781a12.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756153053; x=1756757853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XsjqR7enywy8/exz6ZOmZmhzo4A0EEOQ8Bcl9WBb48=;
        b=T2DKZD7tRnYBgsfw57of9Bs6it0KEgFcKIciYi+0axpxoxjf/YnOr0CNLYx/kJVFwc
         f3O1EN5gjvCybaazAuTKkLNtFxI+x7jWU9dLQoE2BE1G3jcch0/157NLLWg0KY1tkEly
         TamIPVWtQVws7cCXA0RSEzvHZvurmOTnoFtKLVD9yhG1A7MD9evMQeI/pEm0DWBftkJE
         HGgGMPlVBJYw9L2kDb/plMsLfE/u/rawbDGbRVuPRnHVBqms5xXL2OH06TsnpsuLE7YS
         c5/izz6tjKjxt2sva3QY68nt4kXFkW+vZaU7BHgVOfZOtP+kjvDKSL8Nm2ooYkQqRbqu
         S4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756153053; x=1756757853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XsjqR7enywy8/exz6ZOmZmhzo4A0EEOQ8Bcl9WBb48=;
        b=E25xmsJzRBTIeIYgtn9ozTyZnWiMHsQAg3AutdSg7dZwoZV8oqU1GSg0HHJj2/oxRO
         s/QNYsg/COYHOycbHm9V6apdnpv6nThUknK4b5o0DH8nLmyRUQV/kvYWlGOWwH3/6BqH
         YoyYmtyHgK39bJhnsmRd6Aps1gQaA3O+sWsNAyhEwtEN253rojV/NXP0tv/+McuW1DR5
         McvqmlNBulp8nirMGTDOlZcVTHfOZdEkb7UXuekJRE1RxFBCdh3Qe7tQppnnG6MqWOVc
         wfDCbo46UqoysAwV555z3gVqTfEwCV2SvXX1hS6MkL7D5lvf0iuwEyvwiaVYJWePMx6n
         BKIg==
X-Forwarded-Encrypted: i=1; AJvYcCVIZQ1FOpBTGnTdgaYGhRh2vQxwg4fE/27csl8PVpBstprev63Jq/mQsZBjs1w6uDeYkBq8hdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwctSB/pbV3Wb7osSyhbja2ILquEr+UAp8Wq66x66LaWXCjeB+5
	CdGCc3ASMpBEtjiR/2Yw8GMfg5rn7prAWR0lGRt9jeO9KDHlfJDP5DAkbu8xnmhOpoE17yz5zcH
	9Tiv0knbHXR/vW19xmSW+Cwo8R4OISvlwc8MazQXO
X-Gm-Gg: ASbGncuEzRIrBXWt3f6TJTb5pR/otFFK1H5h9IHVmolW7eMOXYE4VxlKCRpHmjWrcyJ
	tutfTDjlAgZtoZ/RXjGiouDPbDjMLpJUwDYp90ZpqvKMqOCNrsyRyRz3sXdfDOFQi0tB6Bfxgv2
	+kEMU1AhNFtSYWCwd9W4tcaRUpPUaA7dDAleKFs/AkAdyWBKY1vhwcYK+EOh8ZtMi1cDzCoRuAR
	squbuFGyQ5QecVVpF4XnB4R7ekkSbJtZ7NLKYrOFSK5dpXJBP5fDifPR4tL/wHoFdjD+o6Jlpo=
X-Google-Smtp-Source: AGHT+IH2vigvxLTkn5G8aJIVwzqKiUsL4r+kRCPHFruwpiGc6z5bMapnJZothCiISbcc6af7rwhfjXnQmdteDvJPJ1M=
X-Received: by 2002:a17:903:3bcc:b0:235:f091:11e5 with SMTP id
 d9443c01a7336-2483df2deffmr8443255ad.10.1756153052650; Mon, 25 Aug 2025
 13:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com> <20250825195947.4073595-3-edumazet@google.com>
In-Reply-To: <20250825195947.4073595-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 13:17:21 -0700
X-Gm-Features: Ac12FXwovtMjAKEpiEXymXWLyyqW5g8iVHIZTAc6Izac5h_8D2w28dDFPZsB9ao
Message-ID: <CAAVpQUBRV2jEArNrBJumKaUep4V5uL7ez2iSKgvd0L51-1Co8w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: move sk_drops out of sock_write_rx group
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:59=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Move sk_drops into a dedicated cache line.
>
> When a packet flood hits one or more sockets, many cpus
> have to update sk->sk_drops.
>
> This slows down consumers, because currently
> sk_drops is in sock_write_rx group.
>
> Moving sk->sk_drops into a dedicated cache line
> makes sure that consumers no longer suffer from
> false sharing if/when producers only change sk->sk_drops.
>
> Tested with the following stress test, sending about 11 Mpps:
>
> super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
> Note: due to socket lookup, only one UDP socket will receive
> packets on DUT.
>
> Then measure receiver (DUT) behavior. We can see both
> consumer and BH handlers can process more packets per second.
>
> Before:
>
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 615091             0.0
> Udp6InErrors                    3904277            0.0
> Udp6RcvbufErrors                3904277            0.0
>
> After:
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 855592             0.0
> Udp6InErrors                    5621467            0.0
> Udp6RcvbufErrors                5621467            0.0
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
>  include/net/sock.h | 6 +++---
>  net/core/sock.c    | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 34d7029eb622773e40e7c4ebd422d33b1c0a7836..f40e3c4883be32c8282694ab2=
15bcf79eb87cbd7 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -390,7 +390,6 @@ struct sock {
>
>         __cacheline_group_begin(sock_write_rx);
>
> -       atomic_t                sk_drops;
>         __s32                   sk_peek_off;
>         struct sk_buff_head     sk_error_queue;
>         struct sk_buff_head     sk_receive_queue;
> @@ -564,13 +563,14 @@ struct sock {
>  #ifdef CONFIG_BPF_SYSCALL
>         struct bpf_local_storage __rcu  *sk_bpf_storage;
>  #endif
> -       struct rcu_head         sk_rcu;
> -       netns_tracker           ns_tracker;
>         struct xarray           sk_user_frags;
>
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>         struct module           *sk_owner;
>  #endif
> +       atomic_t                sk_drops ____cacheline_aligned_in_smp;
> +       struct rcu_head         sk_rcu;
> +       netns_tracker           ns_tracker;
>  };
>
>  struct sock_bh_locked {
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 75368823969a7992a55a6f40d87ffb8886de2f39..cd7c7ed7ff51070d20658684f=
f796c58c8c09995 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -4436,7 +4436,6 @@ EXPORT_SYMBOL(sk_ioctl);
>
>  static int __init sock_struct_check(void)
>  {
> -       CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_drop=
s);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_peek=
_off);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_erro=
r_queue);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_rece=
ive_queue);
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

