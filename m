Return-Path: <netdev+bounces-224680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99646B88268
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA481B22F23
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237CB2D0626;
	Fri, 19 Sep 2025 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLqTpl8P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366DF2C234F
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266750; cv=none; b=sV8jqY1Hh1BfhW/47oPYevPciDr/c/6W5/jCeFV3VImi54ZM9Ns/x+wWcmDLCilRpH/19FC+/Qc9++dMR82nfubtW7CPT+uQVhUHE7CxtRc3j04fNjG/dN33o5CnKmrKjbsgjPsWesfrENgcfHUKyMSq4aiJ42SBw4C/l7vHHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266750; c=relaxed/simple;
	bh=zkVkIoUOl03T+4kpYux31FAUF2pWUEphOE/XLbf//wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc2Dszzj7lplzvkqdYUoqvYy8ZMBNj/ruLBJFRz+/fuOP/7pBOb1YH7/oXVg3Bd86iMt2huw5UsmkG6B15xZ91Ol5Mtx5b5NpqvT5q3mAPy4GH9WUbEE5WgTV2DOAKe/PkfNAxSwNcca92VIv7njc4q05eDu+gepELXrmypD7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLqTpl8P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758266747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
	b=SLqTpl8PZ5Obw38PQe4Roo5NfFT7ET+y5FMAOIjQr9qAqgLz2DJsnHG4L3m7ZAWGw1qzpf
	UHwEOdq8J7o56OIkMN0LBZ+CqthE2kJnvr9ZMqiIU78iqUW4GHXoHMkkmk0W+4uGhhUI6t
	KOwObpwdxrcKEFEndUmThJbIE8W9zKM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-CyAosApPNii7K2H9jvsLxg-1; Fri, 19 Sep 2025 03:25:45 -0400
X-MC-Unique: CyAosApPNii7K2H9jvsLxg-1
X-Mimecast-MFC-AGG-ID: CyAosApPNii7K2H9jvsLxg_1758266744
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso1769191a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 00:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758266744; x=1758871544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
        b=AzUHZ0yDS/SGAaOWaTywRrLHVSQEEPvcyOtEdmu4HjXr05LKGcjD9UUA7u/YcMnbnA
         ACPgm026qe7foecgWJzP51nRXTKODul/96ff7KoQbW+oGqcsa1qwxI7mT5Jk9suLGiuJ
         Pwa2y/saAcvB/Te7zEOhdXxFLRUtF5pMdMANRC9USwvToxSjC+S/obyepBbiii17UU7y
         xWAIlED0qj29M8BUckw7hwRmWTELCkYg9UoO/EPvtHv+41PEm+CP+ZGM5MLnzIi9XOzr
         7EWpqNqrPIX2zX17UgiNC3aa+mjcl597wu82ZWPR5RiW5pKUe7PM75i6/f3OWCTAje5a
         OXOw==
X-Forwarded-Encrypted: i=1; AJvYcCVNflPdlHG4S0I4Wfdl7J/TCwEMiPt4jiKZFueAsUv2mBmBOWK/TM2VkQIlaOFVeIu+V/se+M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9L+96A82W95cxhaIuNbXcU/DO2cjNTePv/0jBPSqs9+x/ybM
	vnDBy30GliWgMwpAfWo8Pwy99kaLD+7i7VAQ/lvtCmmuBYaSFSAMjLQB6xKBouhfUqjAZ7i6Bp/
	PclwTZfJCWm6c/GW+xiyqdTehfcPLFtwRYrfMPB+etQsAl2aMbxDEKgelYYipSRjZT8PEyub7ri
	0NyJwCxPbND6qM1tMOjfnyLUctH7r2872d9k4Ps97PCgE=
X-Gm-Gg: ASbGncuhU+mXLX08RZEtLqLyrxPB+BII8H50DCenRDkr7Jx6i4y0118FAgPuP4d6pfR
	1i4AvGDiu6plxCzeVKWcRo38Oy+J9yfrL30yv6GTZJ/InpVNGr6cv1TZKrSItv/wAOFwPF6RVqu
	gBrxRjWIxFNqiPFhUGjWx2UA==
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3309838e07dmr3146554a91.33.1758266744222;
        Fri, 19 Sep 2025 00:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHioX/aUb/kf3X7YbtUfx1ZTiAhYMo4GyJt6XgUNBRLxjMQjBMLN0ziU1pYTAvo5cwkJNciXxXsSL6B3HEhWEE=
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-3309838e07dmr3146523a91.33.1758266743790; Fri, 19 Sep 2025
 00:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250918105037-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250918105037-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 15:25:32 +0800
X-Gm-Features: AS18NWCuouHf_lzYXemPvsvzosa6Qbb26dhl00LIb1AvW_Yc0kDUxptSh5xarsQ
Message-ID: <CACGkMEsUb0sXqt8yRwnNfhgmqWKm1nkMNYfgxSgz-5CtE3CSUA@mail.gmail.com>
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, 
	jon@nutanix.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Sep 17, 2025 at 02:30:43PM +0800, Jason Wang wrote:
> > Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> > of used elem to vhost_net_rx_peek_head_len() to make sure it can
> > signal the used correctly before trying to do busy polling. But it
> > forgets to clear the count, this would cause the count run out of sync
> > with handle_rx() and break the busy polling.
> >
> > Fixing this by passing the pointer of the count and clearing it after
> > the signaling the used.
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 67a873df0c41 ("vhost: basic in order support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I queued this but no promises this gets into this release - depending
> on whether there is another rc or no. I had the console revert which
> I wanted in this release and don't want it to be held up.
>

I see.

> for the future, I expect either a cover letter explaining
> what unites the patchset, or just separate patches.

Ok.

Thanks

>
> > ---
> >  drivers/vhost/net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index c6508fe0d5c8..16e39f3ab956 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtque=
ue *rvq, struct sock *sk)
> >  }
> >
> >  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct so=
ck *sk,
> > -                                   bool *busyloop_intr, unsigned int c=
ount)
> > +                                   bool *busyloop_intr, unsigned int *=
count)
> >  {
> >       struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_VQ_RX];
> >       struct vhost_net_virtqueue *tnvq =3D &net->vqs[VHOST_NET_VQ_TX];
> > @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhos=
t_net *net, struct sock *sk,
> >
> >       if (!len && rvq->busyloop_timeout) {
> >               /* Flush batched heads first */
> > -             vhost_net_signal_used(rnvq, count);
> > +             vhost_net_signal_used(rnvq, *count);
> > +             *count =3D 0;
> >               /* Both tx vq and rx socket were polled here */
> >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
> >
> > @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
> >
> >       do {
> >               sock_len =3D vhost_net_rx_peek_head_len(net, sock->sk,
> > -                                                   &busyloop_intr, cou=
nt);
> > +                                                   &busyloop_intr, &co=
unt);
> >               if (!sock_len)
> >                       break;
> >               sock_len +=3D sock_hlen;
> > --
> > 2.34.1
>


