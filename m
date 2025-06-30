Return-Path: <netdev+bounces-202316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B380EAED2F6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436C2172895
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B51A2381;
	Mon, 30 Jun 2025 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXto7RWp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B549620
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751254636; cv=none; b=J/nmr8qsUzfBroe0ZNpyJGdsj/BSNokoCt4KwxvWJStwD3da6qt2pxEtidsYWDh8xZsNbUD4ZvfvEpPJnu5FiEOsj+b2EUpe6aE1CSo76tCeDuxj9AwDuczWd9BQ0Ak4xMeN3XA03i2kZ4o64DrgJU9IjQNj2XaEzH0ml1wPO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751254636; c=relaxed/simple;
	bh=nHAXEaVkqOjEIQ+g+zG5hflRIdiMhOy/cbZJ03K4CfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQGdhGRY1g3b5fFx/a5ourX+9I1cQINqny8PKJCJRDex94tG3EM1q92omzWVKtcOnjzdIfbOEolP8QrZMhGt2AlbSWYji1M3wFKg7SGNC3eZr1vzy6XrAqmJsqwahh++SJIfcBmKoh9li4Di5Ji2wYvk6da2aAc5vGkdWK3Kp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXto7RWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751254633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkwpDUZl+sZWek7ZXNsWkAYIEZO6e0RDLuiHFNjssRY=;
	b=PXto7RWphnbFmG2NOEAIoh9geuuDM5Lx8drOGAC/osoVQC2cZ4rBtEIaQAsZydgeP5LD5+
	SmDfZFHZ2dKgqc2xNg7xL37Vkov5zEbxcotBOw3q2Ee1giB3CdYA6qFw40hOYakNLErRRV
	95qnWyIbbczaEen+eYO05SfqybfGnw4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-128wNEdRNGqLlEgz6RBBpA-1; Sun, 29 Jun 2025 23:37:11 -0400
X-MC-Unique: 128wNEdRNGqLlEgz6RBBpA-1
X-Mimecast-MFC-AGG-ID: 128wNEdRNGqLlEgz6RBBpA_1751254630
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3138e671316so3041707a91.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 20:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751254630; x=1751859430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkwpDUZl+sZWek7ZXNsWkAYIEZO6e0RDLuiHFNjssRY=;
        b=U2Y3PQ256Jx4XluiP9I+Z2ocxrQDd4JqCIoAOGGSqF1o2Lr3/lnQblRfpwMaes+Eek
         skLRvBnR/zoBe6rLrfoU6khze4XfJR1sMmXwPxHMReeCZ5MbZ8mthzqTsnyKBGOmwKn6
         epMdKYhkC+l705Sh9TOP190ZFZ08qVOjll1VpH8DNz26ErSflHp6PA7Gz9E+C20RaKPH
         Z7W1FxoM1oCVM9Ni0bAkJ0rxRlAZouwIz3ZDfXOZFfui5Uo8Yv4ssdnCDjWfovUDQzjW
         RNZ6l2yCadXZojPnq+otER3Klu9zkUvZqhvMXDsr+OWhNWecpBY0RAP6cWCt7RrOMT8M
         SRVw==
X-Forwarded-Encrypted: i=1; AJvYcCU27SuxMPHtwdOb09P4sQIyGtJO5yp4EUfb8gft4v5L3tihAO2Gsl+6gMB306Ca7/UitNM+6Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoe8oC3IiYSumK7dXKTaX6AUiAq/lPGxve9IM8Yf6cXzui7qQC
	22ZEqsf2+7kB5DUcjcOAhVqmV2y82aPXozyMYmv1f99xT3E1zVBy6NKaJ7MIaZLrocJTvJfKqOP
	PnkA0pX1JypSXxLdk57pFMa5J06xoQPtaIJ5UyrW0c9niTx5ARzbMP26KzmyttttosOAVVOhBIK
	SAklDX5Pgjr/1M0GyVrjIjYns20f5LMHee
X-Gm-Gg: ASbGnctyE0z0h1HbLENKgSaJR6jRBirL4xp4rVh+Dhk9HCz/CWjd8dvrsDNG74kMpEb
	b1DeFzeo+iuxq3BwSUsUQrDitUbUOLVocHL9z5vfXLliwbjEvBqCPmo1Nf0uPyPpewxnvujeoIg
	QuOIS+
X-Received: by 2002:a17:90b:380f:b0:313:f995:91cc with SMTP id 98e67ed59e1d1-316d69a9ebamr23854597a91.2.1751254630216;
        Sun, 29 Jun 2025 20:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC/PxeY2zPgmoqHLa5NYsPNWTtefEChjOO7AtX/7ybsjX+NZLbIw2wSOZC+yvf746Z7vQ9ZeDBKqdlVvccnBo=
X-Received: by 2002:a17:90b:380f:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-316d69a9ebamr23854562a91.2.1751254629758; Sun, 29 Jun 2025
 20:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626021445.49068-1-jasowang@redhat.com> <20250626021445.49068-2-jasowang@redhat.com>
 <20250627174825.667e1e5f@kernel.org>
In-Reply-To: <20250627174825.667e1e5f@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Jun 2025 11:36:56 +0800
X-Gm-Features: Ac12FXwSsmp5J2RbQVOjDCPt8sIK9w2DQyUQ567Xil-xT9G4D8CIR57TUiVmXz8
Message-ID: <CACGkMEu6r66Jg3--eOCyMdd1WqKeP9Jvfv+DFmWk07oTJUKZyQ@mail.gmail.com>
Subject: Re: [PATCH V2 net-next 2/2] vhost-net: reduce one userspace copy when
 building XDP buff
To: Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, mst@redhat.com, 
	eperezma@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 8:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 26 Jun 2025 10:14:45 +0800 Jason Wang wrote:
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -690,13 +690,13 @@ static int vhost_net_build_xdp(struct vhost_net_v=
irtqueue *nvq,
> >       if (unlikely(!buf))
> >               return -ENOMEM;
> >
> > -     copied =3D copy_from_iter(buf, sock_hlen, from);
> > -     if (copied !=3D sock_hlen) {
> > +     copied =3D copy_from_iter(buf + pad - sock_hlen, len, from);
> > +     if (copied !=3D len) {
> >               ret =3D -EFAULT;
> >               goto err;
> >       }
> >
> > -     gso =3D buf;
> > +     gso =3D buf + pad - sock_hlen;
> >
> >       if (!sock_hlen)
> >               memset(buf, 0, pad);
> > @@ -715,12 +715,8 @@ static int vhost_net_build_xdp(struct vhost_net_vi=
rtqueue *nvq,
> >               }
> >       }
> >
> > -     len -=3D sock_hlen;
>
> we used to adjust @len here, now we don't..
>
> > -     copied =3D copy_from_iter(buf + pad, len, from);
> > -     if (copied !=3D len) {
> > -             ret =3D -EFAULT;
> > -             goto err;
> > -     }
> > +     /* pad contains sock_hlen */
> > +     memcpy(buf, buf + pad - sock_hlen, sock_hlen);
> >
> >       xdp_init_buff(xdp, buflen, NULL);
> >       xdp_prepare_buff(xdp, buf, pad, len, true);
>
> .. yet we still use len as the packet size here.

Exactly, it should be len - sock_hlen here.

Thanks

> --
> pw-bot: cr
>


