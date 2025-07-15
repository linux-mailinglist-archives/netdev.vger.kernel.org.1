Return-Path: <netdev+bounces-207198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B6B062CD
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F016B05B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BFE235BEE;
	Tue, 15 Jul 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2GBqhP4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6E23ABB9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592921; cv=none; b=VBg1wxaEGwXa3XVX0XxHsIM/cV2frgyGZ/25nZUZS2QFDShE5LRGI8DiITTNkFnUk6Ngq/6Sd0p424FLCBUneVYtpTAedmN+8/vAGE7wESWoRq5hCFlUgiVuIUFb1e5Hcg/8RFjvMVCIrBXyiP+1FFVGpRsK23tnZiUGsCK7UT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592921; c=relaxed/simple;
	bh=OA8jfvqB94WTqblc7B6TblgCAhJnB1BowDnSQb7RcJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoO5VPNzGt03ttCFTOGJZ+1wdjucP+rFNiIHDhog6RFq5gBVJA2E3G0B8w6ptCjVZZ6of6nGgmkw3AcRkee4bVO5DEWzcQ1wVBPuGvtljUEqK7y95fI6fOLvEKeKTYwXf03EkzHDyF7g65c5Gh/nbPXgoqcDL1E70rf8W7BghVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2GBqhP4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752592918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fI0v1yI+mRa3f2C1cjF3TQ6M2kT1SS2IwxcIibzixE=;
	b=V2GBqhP4ZXTGis/HRDSF7tgWRnSetfYG/kNwxq7rCMgRi3g86TzgLc0P+RJIrHg/BcZdbc
	Of0FndCjpkubHIlCkROgtjvybm5juhXojFKTd7ArgX1tVQdo6AJ0RIwIaOVCuDIAsnpsyd
	Oy4P3/J6hS/cenfT2nVrckgX3T3QPrE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-yxBq-AXtMquDcGFQ9WrWSg-1; Tue, 15 Jul 2025 11:21:57 -0400
X-MC-Unique: yxBq-AXtMquDcGFQ9WrWSg-1
X-Mimecast-MFC-AGG-ID: yxBq-AXtMquDcGFQ9WrWSg_1752592916
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae6c9aa2c93so491915566b.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592916; x=1753197716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fI0v1yI+mRa3f2C1cjF3TQ6M2kT1SS2IwxcIibzixE=;
        b=R3Qg1lfTBTsTPGan/EJ/491RITIZu63C4dPZ+Lumj/H+4f/jc8pcw6lz5hzL6yGaWA
         UG4P1zXvzls+aoMb5KroqVCbOIfGzeVfSUb9xd1yntYOyA9pup2iZMCBGzBytcYOAXSR
         WSce6g6mP9k4sv1iYxn17ggQYHm5oqCXCqW7VAjoXX2rHRStJ5qHhjJOQbz8vob0M9mv
         uKedp8QuRdNRiL1czSCKw5YpAs7pv2kLy8JrcWuQL+D4BKcYexJ+edBl4Id/s8Zq3pFd
         /43N3NIK1/6eOyLkwwHSkea5gGEY+6uKUir5Mo5y/l9gkTYcusZwCDJsZ+fCXDYoe97G
         t/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU/sIzSrCorf9AClrEW5PmB47WRGbXU2CB/Z2O17U3IrTjLzQO9L75QtPc+JDSxPG8OkseY0EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyelNd5yo4kmGXQI8B1wPA/GWZfNmGv4aLey6b/DQMwvYWgtEtl
	vRChvbjmGhEgA63KyKF/jypJD1iTF8lmGgmbwfObVwwzPSkghzVeS2rf8aZ32gNpRRnsdq6f0oW
	iexYgaV+TjUU81rAm5SLnKq8EIc6kbOAAWpKZVWnJp638aRw8wUGnWsvqvKBAGi2sU03meERAco
	YYb3qAW32CyvNGtkHwG0Xq9pdk0cppGesD
X-Gm-Gg: ASbGncsbDPSuY92OnXEJd8P6tt7yGiPXdoA+SybeYkJJaC6JInG6dpEGqBxwu9BdE9V
	RTpR6+Al/KYAJcbHOL08EIaEJMC0DO7DvkKyUPntG7hNUQT4c0RX0OmwoJpwM3Yes8YNQE3awTy
	tsvHCs7GqqBKpIX8OqBB3hpA==
X-Received: by 2002:a17:906:f59f:b0:ae3:5be2:d9e8 with SMTP id a640c23a62f3a-ae6fc6f5e4amr2016854566b.18.1752592915705;
        Tue, 15 Jul 2025 08:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG04Q0/L7+tw1PxjEvUIsfEfnfanZh/MEfguoQzygMTmlyTx8BJASaAiyVGdXWILSHA5dGrH0aEap7oQDpZqQo=
X-Received: by 2002:a17:906:f59f:b0:ae3:5be2:d9e8 with SMTP id
 a640c23a62f3a-ae6fc6f5e4amr2016851466b.18.1752592915292; Tue, 15 Jul 2025
 08:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com> <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
In-Reply-To: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:21:16 +0800
X-Gm-Features: Ac12FXz1YLuKyuuRFUqAPOMa3ysRrX3OPGeF3wFUvNM12KNl4C21Kk7IWP1rQN8
Message-ID: <CAPpAL=wSKdNA_q=zSN4c+7dhj6D7bWxKBNo+9o8ZCvFpYp+5FA@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 10, 2025 at 6:44=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jul 10, 2025 at 5:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > > for big packets"), the allocated size for big packets is not
> > > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > > number of allocated frags for big packets is stored in
> > > vi->big_packets_num_skbfrags. This commit fixes the received length
> > > check corresponding to that change. The current incorrect check can l=
ead
> > > to NULL page pointer dereference in the below while loop when erroneo=
us
> > > length is received.
> > >
> > > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for b=
ig packets")
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Remove incorrect give_pages call
> > > ---
> > >  drivers/net/virtio_net.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 5d674eb9a0f2..3a7f435c95ae 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> > >  {
> > >       struct sk_buff *skb;
> > >       struct virtio_net_common_hdr *hdr;
> > > -     unsigned int copy, hdr_len, hdr_padded_len;
> > > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> > >       struct page *page_to_free =3D NULL;
> > >       int tailroom, shinfo_size;
> > >       char *p, *hdr_p, *buf;
> > > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtn=
et_info *vi,
> > >        * tries to receive more than is possible. This is usually
> > >        * the case of a broken device.
> > >        */
> > > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > > +     BUG_ON(offset >=3D PAGE_SIZE);
> >
> > Minor nit (not intended to block this patch): since you are touching
> > this, you could consider replacing the BUG_ON() with a:
> >
> >  if (WARN_ON_ONCE()) <goto error path>.
>
> I'm not sure I get this, but using BUG_ON() can help to prevent bugs
> from being explored.
>
> Thanks
>
> >
> > /P
> >
>
>


