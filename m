Return-Path: <netdev+bounces-197932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA62ADA69C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC7A3A648A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367A21991CD;
	Mon, 16 Jun 2025 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxx/WMJZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A827453
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042920; cv=none; b=P9o+gxEq5cQzmDxOI4ZCbPaWZvKKLzSqgtX8S/CeBjoR3TLUO9HPNXGAlcqI3RvNZ/i8aOefzBrpADucCDaP3dGWNnk1b3L/xH+oSy7Bxl4PzKAqT6/P4tEWOKIsq6eN9/CWJtoRBmwU0pch9CBpY/wsd0iD3jKs8U99k6Mu9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042920; c=relaxed/simple;
	bh=82AhWuVQoAuMPbM6xTSjCUZ/9oJnawVRvPBYrGktsSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMjLkibGuhnEHhiWRSjfPzgW8M+XMx8nZNHckS5K5zGg9j9LXhQSz702zu3Tjzyt71zfJ/2gTkXnkYhbXgPW/ucj3CRpBHLyOvYC3ghBr4LwW0Io8qPmEbuyfPD8wOSEts0DLXOhz/cfhcnV4L1ie6YQWPLwX1zOhfWJgbBEoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxx/WMJZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750042917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCKkRtoSzZbTAPs+ac64tFtNoEnWSOUuabd/mn0iDV4=;
	b=bxx/WMJZARB0MllLERPqWQBy7vC326ES4odNXZTQiiielq1WsylTVw9H7K2fNP7vKuKH3h
	lqPagwpLxmzaaiRjIscJ9TjeoOEz3IvnqgTZkZz1+2J506UtULmTQsJubakBaUfAOCp7KT
	VqRfB8gQA+1OYDmpEdlJl7yURWN9SPs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Gchs8kFAMcm-blTvtiaTVA-1; Sun, 15 Jun 2025 23:01:55 -0400
X-MC-Unique: Gchs8kFAMcm-blTvtiaTVA-1
X-Mimecast-MFC-AGG-ID: Gchs8kFAMcm-blTvtiaTVA_1750042914
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311b6d25163so3443882a91.0
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750042914; x=1750647714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCKkRtoSzZbTAPs+ac64tFtNoEnWSOUuabd/mn0iDV4=;
        b=wiyMwV/wnPRquUo47PmicmP/Bx7gJOv99s9dTJwVUymf88fJog6qbwCb1bMfDIFFBm
         LLOrAElgRubptJBFsQmCJP4bFDDKQvfd5blnqOEpLsXRVgA89yh+uD6YzEuvOZSjNttF
         uIZIbOi+jM93HgSjiaYZBq4ovq/MLJVq6JvI7CdLwqW5aNZ8eVpPCLXIvRVg2BT8ysUU
         Gz7tyKLy1/dZJKQouvdTPDpGfP4a+8AjTNg0D6rYyEW+ZhYIocLF/QeyjB+sfe65qNGv
         UdzduHcarpN05Trq9xtcd3ildJCFzrOyRieSQFG3cN/YaMjzIvJ0GmXl8EpPaOT5A6BF
         D5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoBL1fjlPtGufPr3YXwhqnbwqRS9DsBnGFJJwBRVzvVyc06sSsT1LyqdQamyl055fBW0wyOa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9DptPDrQBHX8iaoB2DzsmGqjapsqNOiUabiR7mJNYsbPjvob
	+SJOVzaRr76FqU0rMq5G3h2/LxLGR9uIk6+E+vOGTOMmp1SEd/qpsYLFf/Zp5/kO078xsVBdKIL
	Q4z17fmap7BBXUgtGxZT926s4KUUtI9E3XIBnMuWAywMPv0UX5L2kLpWloPxL52OcJ6HTXxNLW5
	/JZWq26vyKIcLpPJIJwis63VRi9lsiW+bv
X-Gm-Gg: ASbGncvpfBoJRuGXex/gK53oPU//pVd51s2fki1rV8tQVljMf72w3Hc4eUGvZmPSBIu
	7M+YKByZ3Fw7UVLDaNrBphXKYGYW8cpriUOyRJ2KfhVw5FetHSlnAf/ORYieILiMzUIpjae0yz/
	4xpw==
X-Received: by 2002:a17:90b:4c09:b0:311:c939:c851 with SMTP id 98e67ed59e1d1-313f1ca12edmr11875506a91.4.1750042914284;
        Sun, 15 Jun 2025 20:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDgoqXu/ryVb1qiAXAGjdpMZc6vHNXfms6UXRPPQBfj+M9c5as5mZfMjZanre+4SB2mOQj6vOqZlGwhMGx3nQ=
X-Received: by 2002:a17:90b:4c09:b0:311:c939:c851 with SMTP id
 98e67ed59e1d1-313f1ca12edmr11875456a91.4.1750042913801; Sun, 15 Jun 2025
 20:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612083213.2704-1-jasowang@redhat.com> <20250612083213.2704-2-jasowang@redhat.com>
 <684b89de38e3_dcc452944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <684b89de38e3_dcc452944e@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jun 2025 11:01:41 +0800
X-Gm-Features: AX0GCFsoBTIoj8eDkU_o6slNuA7yTes0y0TTyhZGfKJwDR3Xf-iokYyjHozULQs
Message-ID: <CACGkMEsKTLfD1nz-CQdn5+ZmxyWdVDwhBOAcB9fO4TUcwzuLPA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] vhost-net: reduce one userspace copy when
 building XDP buff
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, davem@davemloft.net, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:16=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Wang wrote:
> > We used to do twice copy_from_iter() to copy virtio-net and packet
> > separately. This introduce overheads for userspace access hardening as
> > well as SMAP (for x86 it's stac/clac). So this patch tries to use one
> > copy_from_iter() to copy them once and move the virtio-net header
> > afterwards to reduce overheads.
> >
> > Testpmd + vhost_net shows 10% improvement from 5.45Mpps to 6.0Mpps.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Acked-by: Willem de Bruijn <willemb@google.com>
>
> > ---
> >  drivers/vhost/net.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 777eb6193985..2845e0a473ea 100644
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
> > @@ -715,12 +715,7 @@ static int vhost_net_build_xdp(struct vhost_net_vi=
rtqueue *nvq,
> >               }
> >       }
> >
> > -     len -=3D sock_hlen;
> > -     copied =3D copy_from_iter(buf + pad, len, from);
> > -     if (copied !=3D len) {
> > -             ret =3D -EFAULT;
> > -             goto err;
> > -     }
> > +     memcpy(buf, buf + pad - sock_hlen, sock_hlen);
>
> It's not trivial to see that the dst and src do not overlap, and does
> does not need memmove.
>
> Minimal pad that I can find is 32B and and maximal sock_hlen is 12B.
>
> So this is safe. But not obviously so. Unfortunately, these offsets
> are not all known at compile time, so a BUILD_BUG_ON is not possible.

We had this:

int pad =3D SKB_DATA_ALIGN(VHOST_NET_RX_PAD + headroom + nvq->sock_hlen);
int sock_hlen =3D nvq->sock_hlen;

So pad - sock_len is guaranteed to be greater than zero.

If this is not obvious, I can add a comment in the next version.

Thanks

>
> >       xdp_init_buff(xdp, buflen, NULL);
> >       xdp_prepare_buff(xdp, buf, pad, len, true);
> > --
> > 2.34.1
> >
>
>


