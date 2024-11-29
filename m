Return-Path: <netdev+bounces-147822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A49DC148
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE151621AC
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FC170A2C;
	Fri, 29 Nov 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgV+m5zx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149515820C
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871689; cv=none; b=AnSw5zIabxqNtkr644LajqNxtppaRx/BfBzXnnHaAbN9d/7B5aDqfbqG8YHJ/Rl1OAsiSxjtp9QbSktGOYd3aoyeD8KDVB9V79WfX1QxONeS7SPlWqbFFR6SDaCuzAX0Q/k4QOdl+/8NrkLb9xtx4mQ6qyMPP5jN6Bc4fkQele0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871689; c=relaxed/simple;
	bh=YuCYWnWiyUrOvA46Sf7tAuoHbpFAABzCTmo61Q92FH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyWTw3JZ2jNdy89YlLZmgATgkS85AvSTnFdwPNVRH8Pq4aZyWDYwhUELXrGG1pwX/7A3g1ES3cjpf5UfTdyHQ6LSn9Q6PCyYrVywEv29ig1HgFt3yf6XQU8ULYMawtPA85KLdX/XTfGF2Hyk2KT1d5TJ+SvVCYVAy15c+v2S87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgV+m5zx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa503cced42so225484666b.3
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732871686; x=1733476486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+M5rEikpzo5V+SqLQ6sSqX/aUjNRgKO1XHt64QPiQY=;
        b=zgV+m5zxP6q+nKqfl7C2pfXhN1wsb6hnCSvoj0SgnB3xj9GVd5xIj1sIpzP8Z2z2ub
         P1RGVSLtKuvl+zaNn52MTv+dIxrE7XAiFASnO/jennXCpjhclh78gBBgA6X9hhAUlvFZ
         Ddq8ZGgacjZn26WRD90QDyVL297LQwCrcWeR40PFEzimsNAh1VIl/gyzYpMZSt+eY+tA
         KO1cVpn799Z4p+nmQtZIW29ZqmbNt8UoNsAmzApgelC5uubsqD1l/PKoQdWKf5YjRCk4
         u4qrivz/3R9iKN+RUkbCkgak7m4X9Y+csTWKA5l9FlraikQsezS5i8tGbFdYHimn9OZ5
         NmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871686; x=1733476486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+M5rEikpzo5V+SqLQ6sSqX/aUjNRgKO1XHt64QPiQY=;
        b=GFTklQBlpsFtKPHS6mTIzR7F9Et1XvkfrLVLfHJErXyJGfjtWTrcXYpbDdnMGs3+u0
         Ht5csdHx1gwRF/q+R3LP9dK8cWSFT9X1Q0h8w59i5RdgZk2V4udiQsYTum+3iya2OdC0
         Ivbx6jpBE2kPvNh+6XuRtTUFrs2sCgq+Jsay5gHWGrEqkahZpAuAio8EJIeo9cKQh915
         TLF27/yQ9BntRZtKLXt/3QapQaI+a6XUy+KZqm1ftOVpTsnKB/f7zwLeQ8hyP5yNLC5+
         g/1yfWQp5cZNpwew/ELmbV8QZ3K4sJzc64jBdqr8puCBQmjetfEQzkEADfX7ZKuvKVhX
         HrdA==
X-Forwarded-Encrypted: i=1; AJvYcCVHhX+CAhZpRdGx0W5q4RlfiVDqUKTnMB94Fpvbjlb+VB1WqPKMqfuk88/k1hdGXiyqGxgbr04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIxqpC+630EnFaCIyKs2fm+G7DybwiF3gUqZHThYw7Hh3+KRh
	3W3h3T1+7xFV083wySd59LNQQtnziNIXvcm/IK2g4uv62softZ50P6Sw7dFxPi+sb4FF3GbiQ92
	k9yGV3vZ7IQun+kT8PA36VrO+fUqD0v+F+bqQ
X-Gm-Gg: ASbGncuQlT3Ql+S09LSnsSmJcBTCzG3+IF0RqD4a1lJ5LY0hIDnIH7gyPgsApGn2Ens
	oYqcJJpJpY+Yw2GKyNcv689UCMcBYCIc=
X-Google-Smtp-Source: AGHT+IFP/4Yxgf5No9UVIYTmXc4yG3IxJcA2vYZEnGPhPpjV7rxv2FmagKq4Z30VvIxlWj5jUEC6NZTVoAcIHxQ2e5U=
X-Received: by 2002:a17:907:7856:b0:aa5:27a8:4cbc with SMTP id
 a640c23a62f3a-aa580f266c6mr809216166b.15.1732871685549; Fri, 29 Nov 2024
 01:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128123840.49034-1-pablo@netfilter.org> <20241128123840.49034-5-pablo@netfilter.org>
In-Reply-To: <20241128123840.49034-5-pablo@netfilter.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Nov 2024 10:14:34 +0100
Message-ID: <CANn89iKGUKxLGY4UG9JrAVQR5bahHrUurf7TVwPcE4rf4g3cAQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] netfilter: nft_inner: incorrect percpu area
 handling under softirq
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:38=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> Softirq can interrupt packet from process context which walks over the
> percpu area.
>
> Add routines to disable bh while restoring and saving the tunnel parser
> context from percpu area to stack. Add a skbuff owner for this percpu
> area to catch softirq interference to exercise the packet tunnel parser
> again in such case.
>
> Reported-by: syzbot+84d0441b9860f0d63285@syzkaller.appspotmail.com
> Fixes: 3a07327d10a0 ("netfilter: nft_inner: support for inner tunnel head=
er matching")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  include/net/netfilter/nf_tables_core.h |  1 +
>  net/netfilter/nft_inner.c              | 56 ++++++++++++++++++++------
>  2 files changed, 45 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilt=
er/nf_tables_core.h
> index ff27cb2e1662..dae0e7592934 100644
> --- a/include/net/netfilter/nf_tables_core.h
> +++ b/include/net/netfilter/nf_tables_core.h
> @@ -161,6 +161,7 @@ enum {
>  };
>
>  struct nft_inner_tun_ctx {
> +       struct sk_buff *skb;    /* percpu area owner */
>         u16     type;
>         u16     inner_tunoff;
>         u16     inner_lloff;
> diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
> index 928312d01eb1..fcaa126ac8da 100644
> --- a/net/netfilter/nft_inner.c
> +++ b/net/netfilter/nft_inner.c
> @@ -210,35 +210,65 @@ static int nft_inner_parse(const struct nft_inner *=
priv,
>                            struct nft_pktinfo *pkt,
>                            struct nft_inner_tun_ctx *tun_ctx)
>  {
> -       struct nft_inner_tun_ctx ctx =3D {};
>         u32 off =3D pkt->inneroff;
>
>         if (priv->flags & NFT_INNER_HDRSIZE &&
> -           nft_inner_parse_tunhdr(priv, pkt, &ctx, &off) < 0)
> +           nft_inner_parse_tunhdr(priv, pkt, tun_ctx, &off) < 0)
>                 return -1;
>
>         if (priv->flags & (NFT_INNER_LL | NFT_INNER_NH)) {
> -               if (nft_inner_parse_l2l3(priv, pkt, &ctx, off) < 0)
> +               if (nft_inner_parse_l2l3(priv, pkt, tun_ctx, off) < 0)
>                         return -1;
>         } else if (priv->flags & NFT_INNER_TH) {
> -               ctx.inner_thoff =3D off;
> -               ctx.flags |=3D NFT_PAYLOAD_CTX_INNER_TH;
> +               tun_ctx->inner_thoff =3D off;
> +               tun_ctx->flags |=3D NFT_PAYLOAD_CTX_INNER_TH;
>         }
>
> -       *tun_ctx =3D ctx;
>         tun_ctx->type =3D priv->type;
> +       tun_ctx->skb =3D pkt->skb;
>         pkt->flags |=3D NFT_PKTINFO_INNER_FULL;
>
>         return 0;
>  }
>
> +static bool nft_inner_restore_tun_ctx(const struct nft_pktinfo *pkt,
> +                                     struct nft_inner_tun_ctx *tun_ctx)
> +{
> +       struct nft_inner_tun_ctx *this_cpu_tun_ctx;
> +
> +       local_bh_disable();
> +       this_cpu_tun_ctx =3D this_cpu_ptr(&nft_pcpu_tun_ctx);
> +       if (this_cpu_tun_ctx->skb !=3D pkt->skb) {

I must say I do not understand this patch.

If a context is used by a save/restore more than one time per packet
traversal, then this means we can not use per-cpu storage,
or risk flakes.

Also, skb could be freed and re-allocated ?

Perhaps describe a bit more what is going on in the changelog.

