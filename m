Return-Path: <netdev+bounces-60961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E104822070
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B9B1F22F67
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73945154B1;
	Tue,  2 Jan 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIKxHN22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC6154AB
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so79a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 09:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704216850; x=1704821650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4H4STx0XR17w8qdB0s8hsPN6AziBcrpsvvrusepEl8=;
        b=eIKxHN22uF4ipZEbLfODcakewE4ub9/F+bb1dYH9tupsBPW2YIaKE4oiYgqJCz1ZBm
         ijN0/H2iRO7BrSt2f1+40qumD5oTf4Or9wps8rQfOnBnxqHB6+wd873X3BkMRIO0Bn9r
         6ug04rSW23EUlK3iDBodaERaDBEjyo8EY9/olsXcRuysdcAIMN3rKt7ARAQ57zryxuV3
         NNdApwgtGobV9WKWympscfUXdcTlnFu3JG6gHFOWwkTU40Y7kkVUkXC5qXnUwgggk4LR
         phEN/r8G6RuCG8veF9m6NKn7+E0a6OcBBehZ2OW9SqhwWTrJ2TmCoCGHvRElERarsJg7
         xPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704216850; x=1704821650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4H4STx0XR17w8qdB0s8hsPN6AziBcrpsvvrusepEl8=;
        b=QEhzJx8mKOTtMN9pga6dCZUh/WGOK8PTIARGQSnJj88LyX5LQ6DnumVCDQMRNC7oDf
         D6eOliN+FEwuujxHYrin6Wz1EaV1H33VArJSiujD2wY2f+0bVSdB4sSbdUMDvQlXJ9qR
         ZIzQ/ha367TwfMOoZxO+/YTkA4H/I3frfHGf4QOUn1zeJCg3IvtGh9KofGj9VWr68gom
         zEw8gun79c2sPdzX6ZnZTfmYnCyXO68Wshl9jSEY/ZMcwX0tqJglLx5y2FsFPo0di0oO
         oRKcVUc21cVVSuShSbWYk/XZRAT7W9yJ8m0mXpNYmfKobFHXhtmLTIncOop6kQm4t/EA
         lvqw==
X-Gm-Message-State: AOJu0YxOluUcg2QUhGyCzfBZ3I3uRnAE8oAOp/BdQwUjx6YqkQtoCq/u
	ciQ4zl0PHQPVkffEKobd2yN23lUiktr/bOMgVGwwHr+ymuOO
X-Google-Smtp-Source: AGHT+IFvEcIrqZ9aUSnNEmLKXBrUPXMwi6f7bv82qceodEBrqeWWCV70ozR3PyflHs50XEz9U6Tm24vgKfbfCzlUAAY=
X-Received: by 2002:a50:ba8e:0:b0:554:228f:4b8e with SMTP id
 x14-20020a50ba8e000000b00554228f4b8emr1136022ede.2.1704216849665; Tue, 02 Jan
 2024 09:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com> <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com>
In-Reply-To: <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 18:33:58 +0100
Message-ID: <CANn89i+GJOgcDWK=C0+vmomt2ShotrOKyLiXzFkfT1W8vpJv1Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:25=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> The existing code always pulls the IPv6 header and sets the transport
> offset initially. Then optionally again pulls any extension headers in
> ipv6_gso_pull_exthdrs and sets the transport offset again on return from
> that call. skb->data is set at the start of the first extension header
> before calling ipv6_gso_pull_exthdrs, and must disable the frag0
> optimization because that function uses pskb_may_pull/pskb_pull instead o=
f
> skb_gro_ helpers. It sets the GRO offset to the TCP header with
> skb_gro_pull and sets the transport header. Then returns skb->data to its
> position before this block.
>
> This commit introduces a new helper function - ipv6_gro_pull_exthdrs -
> which is used in ipv6_gro_receive to pull ipv6 ext headers instead of
> ipv6_gso_pull_exthdrs. Thus, there is no modification of skb->data, all
> operations use skb_gro_* helpers, and the frag0 fast path can be taken fo=
r
> IPv6 packets with ext headers.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  include/net/ipv6.h     |  1 +
>  net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 78d38dd88aba..217240efa182 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -26,6 +26,7 @@ struct ip_tunnel_info;
>  #define SIN6_LEN_RFC2133       24
>
>  #define IPV6_MAXPLEN           65535
> +#define IPV6_MIN_EXTHDR_LEN    8

// Hmm see my following comment.

>
>  /*
>   *     NextHeader field of IPv6 header
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index 0e0b5fed0995..c07111d8f56a 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -37,6 +37,40 @@
>                 INDIRECT_CALL_L4(cb, f2, f1, head, skb);        \
>  })
>
> +static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto=
)
> +{
> +       const struct net_offload *ops =3D NULL;
> +       struct ipv6_opt_hdr *opth;
> +
> +       for (;;) {
> +               int len;
> +
> +               ops =3D rcu_dereference(inet6_offloads[proto]);
> +
> +               if (unlikely(!ops))
> +                       break;
> +
> +               if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
> +                       break;
> +
> +               opth =3D skb_gro_header(skb, off + IPV6_MIN_EXTHDR_LEN, o=
ff);

I do not see a compelling reason for adding yet another constant here.

I would stick to

   opth =3D skb_gro_header(skb, off + sizeof(*opth), off);

Consistency with similar helpers is desirable.

> +               if (unlikely(!opth))
> +                       break;
> +
> +               len =3D ipv6_optlen(opth);
> +
> +               opth =3D skb_gro_header(skb, off + len, off);

Note this call will take care of precise pull.

> +               if (unlikely(!opth))
> +                       break;
> +               proto =3D opth->nexthdr;
> +
> +               off +=3D len;
> +       }
> +
> +       skb_gro_pull(skb, off - skb_network_offset(skb));
> +       return proto;
> +}
> +
>  static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
>  {
>         const struct net_offload *ops =3D NULL;
> @@ -203,28 +237,25 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_re=
ceive(struct list_head *head,
>                 goto out;
>
>         skb_set_network_header(skb, off);
> -       skb_gro_pull(skb, sizeof(*iph));
> -       skb_set_transport_header(skb, skb_gro_offset(skb));
>
> -       flush +=3D ntohs(iph->payload_len) !=3D skb_gro_len(skb);
> +       flush +=3D ntohs(iph->payload_len) !=3D skb->len - hlen;
>
>         proto =3D iph->nexthdr;
>         ops =3D rcu_dereference(inet6_offloads[proto]);
>         if (!ops || !ops->callbacks.gro_receive) {
> -               pskb_pull(skb, skb_gro_offset(skb));
> -               skb_gro_frag0_invalidate(skb);
> -               proto =3D ipv6_gso_pull_exthdrs(skb, proto);
> -               skb_gro_pull(skb, -skb_transport_offset(skb));
> -               skb_reset_transport_header(skb);
> -               __skb_push(skb, skb_gro_offset(skb));
> +               proto =3D ipv6_gro_pull_exthdrs(skb, hlen, proto);
>
>                 ops =3D rcu_dereference(inet6_offloads[proto]);
>                 if (!ops || !ops->callbacks.gro_receive)
>                         goto out;
>
> -               iph =3D ipv6_hdr(skb);
> +               iph =3D skb_gro_network_header(skb);
> +       } else {
> +               skb_gro_pull(skb, sizeof(*iph));
>         }
>
> +       skb_set_transport_header(skb, skb_gro_offset(skb));
> +
>         NAPI_GRO_CB(skb)->proto =3D proto;
>
>         flush--;
> --
> 2.36.1
>

