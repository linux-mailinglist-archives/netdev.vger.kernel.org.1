Return-Path: <netdev+bounces-78697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08978762C6
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693D61F25E08
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6955C20;
	Fri,  8 Mar 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4mAjaH0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB255C27
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896265; cv=none; b=Q273FmyxbEG8VKP9QlXLivApMG6yEVAryyaIPUj9+Yee4Eet59FiLjJA19hhMFHE92YRwCqGcOhfj+DntUOOWIdrnRmqhiU9dAYDvhyUN6n9OSZQKLYgVb0xCKa5znQh//W02oxRM3MAJmn/5Q+r9FlEry2v2H8ePbXI1MVvRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896265; c=relaxed/simple;
	bh=wwy1/eEaLzMW7pgDTgWx/d0pxPnpOewhYdhwlMBZjq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UylJfdutmZxktjGjEJ0ZHiZ+tIln7SLj9zFGHE/gcZaJ749pYMtnUxviIHXbDpl9Hg+Q0LKe20gS/JaJckRq4WRH2u4ugZJfzmHcdHx8P3Co/pVtCGxZxTSHH+gTMnn1Ja4UmrDZiMMYF4zW8C6pYuw+bhTWozEeWQ/iNkZ2miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4mAjaH0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709896259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r5du8dMiTLiH2n8xTrt2xFjkE47VcUGqyd0Kdnpb9VM=;
	b=G4mAjaH0nSmbPM161+gykppc/9jz9iuJME94WEfUxDl/9kz4I3qnQFhbMrzN4+mkHBtYih
	9FEMRtg2So7lJEtSvHP4PF/n/sZzVGSDSbEyuoCY/3nZWboDLAgMTD6pQAlQkyN224jFGo
	4RX8cIPFGbU5jefc9GpP2ES0zou8SCE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-xD8JbdJOP9KYBLQO_O9ETQ-1; Fri, 08 Mar 2024 06:10:58 -0500
X-MC-Unique: xD8JbdJOP9KYBLQO_O9ETQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e78387a4fso134297f8f.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 03:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896257; x=1710501057;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5du8dMiTLiH2n8xTrt2xFjkE47VcUGqyd0Kdnpb9VM=;
        b=m3+vMuHI4Y70t1tOHrvyGrL/1oKCHSwNE9v/ETb6bQBqgDgQSZxHIeTj8AwswHkXE+
         3CvI36EKfxhfR9I+exR6WzRug0i1D8gKT/KNZTDrNrWty9pSScHP4p2C8k/+iM/RTP/+
         XV3C8egMwNbhBeE+r5Or6pvjkK3CM1Bfpt2kH7mtV05Tnnha9DgcU8dTVxwmk8hnypad
         SELFOltTS8L6Ml0pHjI5borfyLv5yMJhJVr/yuAKW9gl3gwZqOYvCZAvjD++7Yjze+IB
         v1UYvKoZXdbjHXjEym8B9GhqCGJ0pW9xXoqcsJYV7SpcUt/95/lzDKkGrRwPIHEKYkZ4
         dayg==
X-Forwarded-Encrypted: i=1; AJvYcCWe/z0SUmgu9o2NFDrJo2sfYbCocdDp2Oa/UhULktCNH1RKUtAp12gm8W7oWg8kfzC0rVzvb/ZCvOb92mzxLILsl1l6Qsgm
X-Gm-Message-State: AOJu0Yxiz+LVnKOrqRlZJR3hWEyWHlZYusARud+jKYnr2Ygof7ayaAlB
	Mfi/5X7Rr5idQtdzclq1RzM+B39lbl+7i7CVJ21n/DGclq9zWoz0gCyY77NtrG1L2K3mXv2jkJe
	dNOVaSRi2g/jHVnz9pBy8Jo8NILDHyuYbCDK8lbkgAgjtWKFuo49gwg==
X-Received: by 2002:adf:e950:0:b0:33e:142f:7cb6 with SMTP id m16-20020adfe950000000b0033e142f7cb6mr1126460wrn.0.1709896257046;
        Fri, 08 Mar 2024 03:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGbMU5V19DYGtUSF8Zp0NfJm8r1W7l9D1Dpu88YV2NfYT6/cZbNFhpaX4OuTi4ki+u47/B1w==
X-Received: by 2002:adf:e950:0:b0:33e:142f:7cb6 with SMTP id m16-20020adfe950000000b0033e142f7cb6mr1126442wrn.0.1709896256674;
        Fri, 08 Mar 2024 03:10:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-226-193.dyn.eolo.it. [146.241.226.193])
        by smtp.gmail.com with ESMTPSA id n8-20020a056000170800b0033e2291fbc0sm19408970wrc.68.2024.03.08.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:10:56 -0800 (PST)
Message-ID: <3eb282be85ab035e36c80d73949c33868e698d43.camel@redhat.com>
Subject: Re: [PATCH net-next] udp: no longer touch sk->sk_refcnt in early
 demux
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  netdev@vger.kernel.org, eric.dumazet@gmail.com, Martin
 KaFai Lau <kafai@fb.com>,  Joe Stringer <joe@wand.net.nz>, Alexei
 Starovoitov <ast@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Florian Westphal <fw@strlen.de>
Date: Fri, 08 Mar 2024 12:10:54 +0100
In-Reply-To: <CANn89iJ+1Y9a9DmR54QUO4S1NRX_yMQaJwsVqU0dr_0c5J4_ZQ@mail.gmail.com>
References: <20240307220016.3147666-1-edumazet@google.com>
	 <d149f4511c39f39fa6dc8e7c7324962434ae82e9.camel@redhat.com>
	 <CANn89iJ+1Y9a9DmR54QUO4S1NRX_yMQaJwsVqU0dr_0c5J4_ZQ@mail.gmail.com>
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

On Fri, 2024-03-08 at 10:21 +0100, Eric Dumazet wrote:
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index a8acea17b4e5344d022ae8f8eb674d1a36f8035a..e43ad1d846bdc2ddf5767=
606b78bbd055f692aa8 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -2570,11 +2570,12 @@ int udp_v4_early_demux(struct sk_buff *skb)
> > >                                            uh->source, iph->saddr, di=
f, sdif);
> > >       }
> > >=20
> > > -     if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
> > > +     if (!sk)
> > >               return 0;
> > >=20
> > >       skb->sk =3D sk;
> > > -     skb->destructor =3D sock_efree;
> > > +     DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
> > > +     skb->destructor =3D sock_pfree;
> >=20
> > I *think* that the skb may escape the current rcu section if e.g. if
> > matches a nf dup target in the input tables.
>=20
> You mean the netfilter queueing stuff perhaps ?
>=20
> This is already safe, it uses a refcount_inc_not_zero(&sk->sk_refcnt):
>=20
> if (skb_sk_is_prefetched(skb)) {
>     struct sock *sk =3D skb->sk;
>=20
>     if (!sk_is_refcounted(sk)) {
>              if (!refcount_inc_not_zero(&sk->sk_refcnt))
>                    return -ENOTCONN;
>=20
>         /* drop refcount on skb_orphan */
>         skb->destructor =3D sock_edemux;
>     }
> }
>=20
> I would think a duplicate can not duplicate skb->sk in general, or must a=
lso
> attempt an refcount_inc_not_zero(&sk->sk_refcnt) and use a related destru=
ctor.

Right, looks safe.

Acked-by: Paolo Abeni <pabeni@redhat.com>


