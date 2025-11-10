Return-Path: <netdev+bounces-237266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E16C47E3F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FE264F9464
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FF274FC1;
	Mon, 10 Nov 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWgnCEPm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwSUzKFb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706E22FDEC
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791053; cv=none; b=jtVvbUKmsMDI0ge1c1VQIAeCTYIFG1/rqWdF0d6hQuKxGIiivmWmx2nVsAFMHTsle+XVzNXmI+LiykLVrVlRb80q8yNR3AdQ284ys5xr6q+G6rHIabEj7J+cnImmSR12J4L0aSzjBHwMC6El5oLBP5u3NeMZPLOb38nEq5zUSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791053; c=relaxed/simple;
	bh=yWwqc79ICtjxfNEwAhdveBII+kI6tv7V46J5xGUbxqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Beeo92fzi91vcqj+9IyHJk/Xc5S080SRHjmQI8lMCKEp+z+3yYj3IMD8i8qeO4GDRNatcdAPo6c8ELSiLSANuAkfWkwjq9hZr58T577jtlYqH9vgQMx/28Nx9vBCKmDhZGgxZXZ9C4PrhHMjq5zw46utTPi9s+ZJmgLyX2zsx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWgnCEPm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwSUzKFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762791051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcHc3rh06YWG1Go43rMQsJeOtpbumA9Fnt4ZDm9Fg9Q=;
	b=EWgnCEPmrLHoDP8+s8JWioZEogvHO8lMQujTWIwx128kpIMIHK/RDVU+3PdZ03gt5/s2Nd
	N4auRo8E2LCQyWiRkZVGcY/rsf+Ig6lxCQPy2UD/WE+5mjBmFH34oq3H0F2J7cFM42JDSC
	KAYBX43ettHPKOY35da3REicUgnKU8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-VxaD9nJlM1OkpWaF8mgONQ-1; Mon, 10 Nov 2025 11:10:49 -0500
X-MC-Unique: VxaD9nJlM1OkpWaF8mgONQ-1
X-Mimecast-MFC-AGG-ID: VxaD9nJlM1OkpWaF8mgONQ_1762791047
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4777a022d1fso10822155e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762791047; x=1763395847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BcHc3rh06YWG1Go43rMQsJeOtpbumA9Fnt4ZDm9Fg9Q=;
        b=cwSUzKFbu6QWJx2zwwH7yz/80lSEqXyzdxeHbzpP7DPyRBWeoq2CHMZdB4BKMOA/E6
         UyA3lA8a/rxp9ScL3wgOH2o1nyhxj7D/WB7qDP5V0oMuzHC5QEHpIpWpHYrt0IEBHEGa
         dE53alEDjanX2H2PrqDhlGYB/1LjrHhQ8bYRHoivOdCLS+SrAHLSQD8Ixm7A6aMj1VOE
         b4K/3+9+55lLIsOuXORXQugd/wNR3zIAmkDwV1W2MRN5tGuXqeGcmaIa4XeTtcs3UvcL
         r5tEjBPZr26PrQ5a9bJCxgX3HmVq+jFHEatrPnZlLBtPlqMOV2PGW/ob3Ijf/GUxUeR9
         gTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762791047; x=1763395847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcHc3rh06YWG1Go43rMQsJeOtpbumA9Fnt4ZDm9Fg9Q=;
        b=hc6v+MBn3wThmTSbew5m6zr1tbC0IFug0R+Xtx5sMqyW+S3ssB4lIHn9XyX/b/mKry
         M4TY11H2vXOKvWLwrsfnFq4RqNIWiaEuG3PFM1vbzhdeXmLAk/LG5ird8Mma+DLNvggg
         70CC+ylt6tbH9p+5JwPl1GrYllYXSlUiOlRycg9x5FN+IzYxK1DZQbWJv7DsuTIrQGGZ
         OOdlZHZygOpG9afhayN7IVQlvd7CO5Cafaz5KWqfkgbFpaw/D3NTEnr/nWtBYfun3xFd
         Di4xh3sCaRlUWVOU6K4h441vpfxGbMPeq9n7XHANpu1fhK1pcqXMXOgo5xk/JTIfdb8V
         B6eg==
X-Forwarded-Encrypted: i=1; AJvYcCUxjRIRpvIuxMImklnWfvY18E+zS0FGn/HLPtwULfai+jKIS5CIhi0abHYLiSabT4CVoETYxlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwARR+wtacH/1QeF4JmCImkdLYFG4+mNa8ha+b+Z5uWNYmQLj1s
	K3doPJveOBxv363evFN85mFHQz+LSxIDFFezcrpF8L0vALhiIi5Smgqhzn25icz4NmTDsx6e/hl
	4u/2mjAZC215QtpERBuqWPdajeYRmALImfZ+fA+VzV2h3ycnvSpSnizUvrQ==
X-Gm-Gg: ASbGncuN8dYGSsrAdf71npIbp7HOVNfh/qUYYowK2/hegomkfYA6MRXxuIbdPpMINBD
	9hWJLJgFV4CuhrcyXt6OtlbA5tMgEqqrJRLPfhVpUkmsNSK/tGd9oOjRkBRm5LSqzlCDA7DPImx
	FZ2IOosjs0XhLtGxgvVOQHnit++2IKygNTyH61Oss93EuupPJ2T4MTP8ouaas0jdqammkHWnNho
	VXCRYuV6hKAgXr1NLZBHExG5TUNrBnBVPIuX3UBFSIjSQkw0MeHyhQCkUJ95hA+Fj0jSHbZLgy+
	d/xupa7ojnl04eB+x+FVygXAl+5bJL5lJVSI7LTDUHH3bWXFFl8ZqXOla3kTjY90HvQ=
X-Received: by 2002:a05:600c:46ce:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47773288bbfmr90576155e9.31.1762791047359;
        Mon, 10 Nov 2025 08:10:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlSd9E64YfjmEcCoLlPhCD+mhQhwPyWeJ7FNhdbF5w48th7xgvNaehDUYwbRr0JRyKdDFjYQ==
X-Received: by 2002:a05:600c:46ce:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47773288bbfmr90575765e9.31.1762791046799;
        Mon, 10 Nov 2025 08:10:46 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bccd41bsm208552935e9.2.2025.11.10.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:10:46 -0800 (PST)
Date: Mon, 10 Nov 2025 11:10:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251110110751-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org>
 <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
 <20251110022550-mutt-send-email-mst@kernel.org>
 <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>

On Mon, Nov 10, 2025 at 03:39:50PM +0800, Jason Wang wrote:
> On Mon, Nov 10, 2025 at 3:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> > > On Mon, Nov 10, 2025 at 5:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > > > On Wed, Oct 29, 2025 at 11:09 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >
> > > > > > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > > > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > > > > feature in virtio-net.
> > > > > >
> > > > > > This feature requires virtio-net to set hdr_len to the actual header
> > > > > > length of the packet when transmitting, the number of
> > > > > > bytes from the start of the packet to the beginning of the
> > > > > > transport-layer payload.
> > > > > >
> > > > > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > > > > which is clearly incorrect. This commit fixes that issue.
> > > > >
> > > > > I still think it would be more safe to check the feature
> > > >
> > > > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> > > >
> > >
> > > Yes.
> > >
> > > Thanks
> >
> > Seems more conservative for sure, though an extra mode to maintain isn't
> > great. Hmm?
> 
> Considering it's not a lot of code, it might be worth it to reduce the risk.
> 
> But I'm fine if you think we can go with this patch.
> 
> Thanks

hard to say what does "not a lot of code" mean here.
but generally if VIRTIO_NET_F_GUEST_HDRLEN is not set
just doing a quick skb_headlen and not poking at
the transport things sounds like a win.

I'd like to at least see the patch along the lines you propose,
and we will judge if it's too much mess to support.


> >
> > --
> > MST
> >


