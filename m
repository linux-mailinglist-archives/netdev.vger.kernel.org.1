Return-Path: <netdev+bounces-148016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801E9DFCDC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5C9281D16
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6D1F9EAA;
	Mon,  2 Dec 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiFtGDXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2C1F943E
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131045; cv=none; b=oK+V/K8VNTxziVzFPLq7EFR6nPE9emdQ37UMxlN2k+ATjgkb2CgcH/33DCQGTBijqsx3u+7E1Roak3gcbk1SXxWJLcKPfWk4xSavszAoWHdQbtiUqXzBFswt8JpbCXicXuk/RqmFhQ39ENabCFsOygWwT6UDzpiyILsPC7w6NEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131045; c=relaxed/simple;
	bh=/9q60xITuihiB2x5RUYBEu35G0+4Mu1zEvnVGD62rlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjbqGg6XrtncH/CaBZz1n1swBTmAUc2Tqe592hpGmWC/0Xmu2DN5esAJ1XnmKi+5uGZ6BJ3Rb5HIjTstLOyjX1uMe0QGXT+e9pWTHZcWGI/nJ7MiqwtgpSCfgIy6Abpn1e5pMrLZhOADWRHeCbiv8pQLwQE6N+G5hWOKkOwOJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiFtGDXK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc357ea33so40538821fa.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733131042; x=1733735842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ+S0Fhs1g+ccvTIHmEYibUCAqQP8aYZxwamy8uh644=;
        b=tiFtGDXKr61Jh2vx1SzX84h5MV3mGkidM7M3B1rkV/qF/KbenbUKHohXj8zP+xl6T1
         RUC2RlfAMuEb8LFSX/RqnkGtnZyQY8Hl1rKewmqQRaYCH8IkfBtE/8Ihco8/VRPFQMdr
         1FGhK3bo1uJMR4+ZAKKYLlhg3iJiTFdqlmlbifIHc1ctNniqG8WL3g1sYVS0EPiovWRg
         57S6/DgxqQ/Znu79PfQfqvUspMi+duyttQj2FMyJaUe9R+4iLADYBHEMKdL22y7NqHPe
         fYbNAWOVyjq/+7qx8aj3jvCO9aj87wJ6ulOlU9U1sGmW9hns7SoHFU4ymSbAVo13RXIS
         ORMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131042; x=1733735842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ+S0Fhs1g+ccvTIHmEYibUCAqQP8aYZxwamy8uh644=;
        b=V5mgEGBH11cAvZjOUDjc68zReYh1ywbhydLwwfCInMht6bz3ZI38uplgBkld1QjSx3
         aDsKp9NO9jiLL72OoJdA7TLlAjaEzndXL7+eREQPTuQqVEVUkbFkrTLDPuA3Whv939b/
         QYhvzodddYXi0wYDHUVLG0hemoGrYkz9z2nHkgEfP8x02ySfHhCzlKVwRG6UCxV9jzBz
         hos7gDXYWIudHdmdknnPwQ1iKLFhMm7AF0hgE0t4xcGkJ9zewaCXJvCvH8FnlvUP+SYX
         Nb3LHj1j+RKgLlcV3OXQ0Vo6PUwV9n7SZOVAFU08+X6j+9qJNJOJgUAeuraAsmPKsKCq
         9loQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVYwob8mB4AAA4tPNfaxBWc0B7BbL5jjWsM7wsbSUzBCS9r2BC9loQ4waOCIQgFKvKSfdOzxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EoLsug2rybgmGeoAUtBo4ImwgDWTbBWfnJTQupDk9CwoDeFb
	PkrVUYu1wKNs3GD8Mb8cwBubNLLPJ8u6GoX/+0NefbtxHhcmvK5YY7UQkgpQSsVMvvhFtpO9Pst
	b7bDQ0OSIu4SKbEZtOzhADpZIlhuG/cNri0tU
X-Gm-Gg: ASbGncuNdE0YC6M8lkSyo+aub+gpklqpqc29SpXbbEME8Snw9OcI4IoIWJuRcTJI35i
	+UvdTGblp7b4rfi8ypIzDXyVBTNHUyg==
X-Google-Smtp-Source: AGHT+IEV4/Bp+fN78qACrtcWAVHEc1WPCJ5w/IU3xtm4onOV+GcCm9EI0O1Ws2OkU/ftmZnEW1+KdScotcR8aQOrOVw=
X-Received: by 2002:a05:651c:a0a:b0:2ff:ef8b:9e6 with SMTP id
 38308e7fff4ca-2ffef8b0ac2mr30879001fa.16.1733131041454; Mon, 02 Dec 2024
 01:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128123840.49034-1-pablo@netfilter.org> <20241128123840.49034-5-pablo@netfilter.org>
 <CANn89iKGUKxLGY4UG9JrAVQR5bahHrUurf7TVwPcE4rf4g3cAQ@mail.gmail.com> <Z00MOYmYgmlrrpWN@calendula>
In-Reply-To: <Z00MOYmYgmlrrpWN@calendula>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Dec 2024 10:17:10 +0100
Message-ID: <CANn89i+G3_0QzdOsoCMOk-Qgd+Vv7hKEtogMNJ00pUGC1wX=ow@mail.gmail.com>
Subject: Re: [PATCH net 4/4] netfilter: nft_inner: incorrect percpu area
 handling under softirq
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:24=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
>
> Hi Eric,
>
> On Fri, Nov 29, 2024 at 10:14:34AM +0100, Eric Dumazet wrote:
> > On Thu, Nov 28, 2024 at 1:38=E2=80=AFPM Pablo Neira Ayuso <pablo@netfil=
ter.org> wrote:
> > >
> > > Softirq can interrupt packet from process context which walks over th=
e
> > > percpu area.
> > >
> > > Add routines to disable bh while restoring and saving the tunnel pars=
er
> > > context from percpu area to stack. Add a skbuff owner for this percpu
> > > area to catch softirq interference to exercise the packet tunnel pars=
er
> > > again in such case.
> > >
> > > Reported-by: syzbot+84d0441b9860f0d63285@syzkaller.appspotmail.com
> > > Fixes: 3a07327d10a0 ("netfilter: nft_inner: support for inner tunnel =
header matching")
> > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > ---
> > >  include/net/netfilter/nf_tables_core.h |  1 +
> > >  net/netfilter/nft_inner.c              | 56 ++++++++++++++++++++----=
--
> > >  2 files changed, 45 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/net=
filter/nf_tables_core.h
> > > index ff27cb2e1662..dae0e7592934 100644
> > > --- a/include/net/netfilter/nf_tables_core.h
> > > +++ b/include/net/netfilter/nf_tables_core.h
> > > @@ -161,6 +161,7 @@ enum {
> > >  };
> > >
> > >  struct nft_inner_tun_ctx {
> > > +       struct sk_buff *skb;    /* percpu area owner */
> > >         u16     type;
> > >         u16     inner_tunoff;
> > >         u16     inner_lloff;
> > > diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
> > > index 928312d01eb1..fcaa126ac8da 100644
> > > --- a/net/netfilter/nft_inner.c
> > > +++ b/net/netfilter/nft_inner.c
> > > @@ -210,35 +210,65 @@ static int nft_inner_parse(const struct nft_inn=
er *priv,
> > >                            struct nft_pktinfo *pkt,
> > >                            struct nft_inner_tun_ctx *tun_ctx)
> > >  {
> > > -       struct nft_inner_tun_ctx ctx =3D {};
> > >         u32 off =3D pkt->inneroff;
> > >
> > >         if (priv->flags & NFT_INNER_HDRSIZE &&
> > > -           nft_inner_parse_tunhdr(priv, pkt, &ctx, &off) < 0)
> > > +           nft_inner_parse_tunhdr(priv, pkt, tun_ctx, &off) < 0)
> > >                 return -1;
> > >
> > >         if (priv->flags & (NFT_INNER_LL | NFT_INNER_NH)) {
> > > -               if (nft_inner_parse_l2l3(priv, pkt, &ctx, off) < 0)
> > > +               if (nft_inner_parse_l2l3(priv, pkt, tun_ctx, off) < 0=
)
> > >                         return -1;
> > >         } else if (priv->flags & NFT_INNER_TH) {
> > > -               ctx.inner_thoff =3D off;
> > > -               ctx.flags |=3D NFT_PAYLOAD_CTX_INNER_TH;
> > > +               tun_ctx->inner_thoff =3D off;
> > > +               tun_ctx->flags |=3D NFT_PAYLOAD_CTX_INNER_TH;
> > >         }
> > >
> > > -       *tun_ctx =3D ctx;
> > >         tun_ctx->type =3D priv->type;
> > > +       tun_ctx->skb =3D pkt->skb;
> > >         pkt->flags |=3D NFT_PKTINFO_INNER_FULL;
> > >
> > >         return 0;
> > >  }
> > >
> > > +static bool nft_inner_restore_tun_ctx(const struct nft_pktinfo *pkt,
> > > +                                     struct nft_inner_tun_ctx *tun_c=
tx)
> > > +{
> > > +       struct nft_inner_tun_ctx *this_cpu_tun_ctx;
> > > +
> > > +       local_bh_disable();
> > > +       this_cpu_tun_ctx =3D this_cpu_ptr(&nft_pcpu_tun_ctx);
> > > +       if (this_cpu_tun_ctx->skb !=3D pkt->skb) {
> >
> > I must say I do not understand this patch.
> >
> > If a context is used by a save/restore more than one time per packet
> > traversal, then this means we can not use per-cpu storage,
> > or risk flakes.
> >
> > Also, skb could be freed and re-allocated ?
> >
> > Perhaps describe a bit more what is going on in the changelog.
>
> There is an on-stack nft_pktinfo structure with a flags field. This
> nft_pktinfo is a wrapper for the sk_buff, containing header offsets
> and metainformation. This is initialize when entering this chain.
>
> If the NFT_PKTINFO_INNER_FULL flag is set on, then the percpu area
> could contain information on the inner header offsets (ie. packet was
> already parsed in this chain).
>
> There is a check to validate that the percpu area refers to this
> skbuff. If there is a mismatch, then this needs to parse the inner
> headers because the data in the percpu area is stale. Otherwise, if
> there is a match, the percpu area is copied on-stack.
>
> After processing (payload/meta fetching), the on-stack copy is stored
> back to the percpu area. I can make an improvement on this patch to
> check if this skbuff still owns the percpu area in the store/exit
> section of this inner evaluation routine, to avoid a unnecessary update.
>
> So, it is basically the NFT_PKTINFO_INNER_FULL flag that handles the
> skbuff reallocation scenario. This is not blindly trusting this percpu
> area per-se.
>
> One comestic change I can apply to this: I can also turn the struct
> sk_buff into unsigned long so it clear to the reader this pointer to
> skbuff is not meant to be used for being dereferenced.
>
> If the explaination above is sufficient, I can revamp to extend the
> changelog as you suggest and post a new version of this patch.
>
> Thanks.

The part I do not understand is that tun_ctx->skb is not cleared at
the end of processing (or at some point)

That would make clear that a future (tun_ctx->skb =3D=3D skb) test is not
confused by skb reuse (free/alloc).

If you use it as a cookie, then we need something else than a pointer.

