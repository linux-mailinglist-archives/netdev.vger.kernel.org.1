Return-Path: <netdev+bounces-92415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F08B6FB2
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 12:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF1A2841EE
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F9B12C53B;
	Tue, 30 Apr 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va2aozyk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9B12C49F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473085; cv=none; b=E1p8etbjWu5EN3o+uC9ECKnXHcrYD+hTBh0yhpj77lGt7/M/wH1tjVWdMAOc6HnGAu9xq76M5BtQrZr7gHLV9Fwqd0ALJ/yKrRHJj9oeBnkeAVRLPCZr+w6KZFsuQKBEu7L8ZcuebcM8aOW+5GKw2QB7SY5OwjLSXVUK+qFkZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473085; c=relaxed/simple;
	bh=ljw03fQaJwNAPt45c5cOrae5aDZjWuANUhBxMaIT5qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fra3osWhaX8gI1MkgbGibqYQWVldntoWvHWZYBxfXk/cByJ7RmpbdUlpy5MKc2dDV2nmGl3+MXCuNdDtrIQ1vmNjOI6zVNsIe+hxIrIezmB6XtTT2Zgq0dm1WUdXOcVCX8gaoBDqfjY4ciTMV57rXBoPl4/sN4FQdopJwoM0wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va2aozyk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714473082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h2GbztPPgBy7pklRNmyoZeFa1LsX3EFvPdCRgPdDry8=;
	b=Va2aozykpMDPnSNt17xQO0MuZnVaEaETRBKHMOMtfLKog3qGOyeexcY/xj1Gae7LrHjZjB
	fI5sfWF9lU3JlQVwETGyrRUeuvSHhn1rsVQ9fnWbkkZyHRduATDG27KlhB+SXk5gy2qjd2
	y5LyJzN/KLlJz0MV6meE+il5232shVU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-P-rD8FpcPFOOudG7x3dq8w-1; Tue, 30 Apr 2024 06:31:18 -0400
X-MC-Unique: P-rD8FpcPFOOudG7x3dq8w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2df08116d5eso4554401fa.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 03:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473077; x=1715077877;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2GbztPPgBy7pklRNmyoZeFa1LsX3EFvPdCRgPdDry8=;
        b=rNPubqnyyIbV5bi5PXPVgUooFInkHyBwe1rzMc0atpdmNjEQS50jS/9i9MmZLE4JGv
         S+aBQkXRNyUZhtyxHEz1dt9FDYLGRsmXXO8o6Aa1Y/4wq9PkywLVKQgVYnvuzpkbUhqA
         Hug4TWivdAzWzH46YzpQ3OSeYPsnrLtdp6ddlRbc7D+5jqUVJwca3bqqW7OIRlyfRAsK
         fFThUOTBWIZ3yeBf27Uc9W2QVE6wHb0CkkAutlCJHPIEM8YEeRr0nCbrWyaZGAQo/mAK
         6pe5RZiOwc56P2thrkCHuhTlcbAPr4h8mfq1Wcd3G6YOKfRA8r4k1DxTxOjt85+8QWFf
         Zuhg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ps8QYE0R7E+LbIcD69aR+8Nd89tTfbEVyRPvOcZVAsAgPujfBn60J/CjRxRLVYY/pnLlJ//PgdIxU2x7zGnN9H9EOJeP
X-Gm-Message-State: AOJu0Yx+MWbEImMCnknVHx0UWKHqIoQdLjhJ1m5LgNbamj8whMpHjv2/
	LNoOEjzBVu+WdS9NeBT29wmbfd43nxle+BBCXx7g+/6a37fNFD1YPfJBstkAbH8rwXbPV0Pwj8A
	vacoStt9+D8E7L/XSEkeGUnurKA2DLop3RSALD0zBnix6ryWqu2aWFA==
X-Received: by 2002:ac2:5bcc:0:b0:513:ec32:aa89 with SMTP id u12-20020ac25bcc000000b00513ec32aa89mr8408520lfn.2.1714473077303;
        Tue, 30 Apr 2024 03:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfQ70OmJ/4CmNxPT8RzTiwhHubkmQJuSfnaDv4b3DeotVbrrkQCx1omoN9O0uu5HhW9woNxg==
X-Received: by 2002:ac2:5bcc:0:b0:513:ec32:aa89 with SMTP id u12-20020ac25bcc000000b00513ec32aa89mr8408502lfn.2.1714473076862;
        Tue, 30 Apr 2024 03:31:16 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:6a10::f71])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d5602000000b0034d117df264sm4798470wrv.114.2024.04.30.03.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:31:16 -0700 (PDT)
Message-ID: <18dee53b6ae7cd75196141e4c5d8984bc0f3296f.camel@redhat.com>
Subject: Re: [PATCH v4 net-next v4 6/6] net: add heuristic for enabling TCP
 fraglist GRO
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 12:31:14 +0200
In-Reply-To: <e3a3a499-11b3-4906-b0f1-b94e70825ca9@nbd.name>
References: <20240427182305.24461-1-nbd@nbd.name>
	 <20240427182305.24461-7-nbd@nbd.name>
	 <e590ba4608c9810d3d75fefdcbba9f2a02c23a0f.camel@redhat.com>
	 <e3a3a499-11b3-4906-b0f1-b94e70825ca9@nbd.name>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-30 at 12:23 +0200, Felix Fietkau wrote:
> On 30.04.24 12:12, Paolo Abeni wrote:
> > On Sat, 2024-04-27 at 20:23 +0200, Felix Fietkau wrote:
> > > When forwarding TCP after GRO, software segmentation is very expensiv=
e,
> > > especially when the checksum needs to be recalculated.
> > > One case where that's currently unavoidable is when routing packets o=
ver
> > > PPPoE. Performance improves significantly when using fraglist GRO
> > > implemented in the same way as for UDP.
> > >=20
> > > When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an establi=
shed
> > > socket in the same netns as the receiving device. While this may not
> > > cover all relevant use cases in multi-netns configurations, it should=
 be
> > > good enough for most configurations that need this.
> > >=20
> > > Here's a measurement of running 2 TCP streams through a MediaTek MT76=
22
> > > device (2-core Cortex-A53), which runs NAT with flow offload enabled =
from
> > > one ethernet port to PPPoE on another ethernet port + cake qdisc set =
to
> > > 1Gbps.
> > >=20
> > > rx-gro-list off: 630 Mbit/s, CPU 35% idle
> > > rx-gro-list on:  770 Mbit/s, CPU 40% idle
> > >=20
> > > Signe-off-by: Felix Fietkau <nbd@nbd.name>
> > > ---
> > >  net/ipv4/tcp_offload.c   | 32 ++++++++++++++++++++++++++++++++
> > >  net/ipv6/tcpv6_offload.c | 35 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 67 insertions(+)
> > >=20
> > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > > index 87ae9808e260..3e9b8c6f9c8c 100644
> > > --- a/net/ipv4/tcp_offload.c
> > > +++ b/net/ipv4/tcp_offload.c
> > > @@ -407,6 +407,36 @@ void tcp_gro_complete(struct sk_buff *skb)
> > >  }
> > >  EXPORT_SYMBOL(tcp_gro_complete);
> > > =20
> > > +static void tcp4_check_fraglist_gro(struct list_head *head, struct s=
k_buff *skb,
> > > +				    struct tcphdr *th)
> > > +{
> > > +	const struct iphdr *iph;
> > > +	struct sk_buff *p;
> > > +	struct sock *sk;
> > > +	struct net *net;
> > > +	int iif, sdif;
> > > +
> > > +	if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> >=20
> > Should we add an 'unlikely()' here to pair with unlikely(is_flist) in
> > *gro_receive / *gro_complete?
> Not sure if unlikely() will make any difference here. I think it makes=
=20
> more sense in the other places than here.

Why? AFAICS this will be called for every packet on the wire, exactly
as the code getting this annotation in patch 3/6.

> > Should this test be moved into the caller, to avoid an unconditional
> > function call in the ipv6 code?
>=20
> The function is already called from tcp4_gro_receive, which is only=20
> called by IPv4 code. Also, since it's a static function called in only=
=20
> one place, it gets inlined by the compiler (at least in my builds).
> Not sure what unconditional function call you're referring to.

Right you are. I just got fooled by my hope to reuse the same function
for ipv4 and v6. Please just ignore this last part.

Cheers,

Paolo


