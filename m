Return-Path: <netdev+bounces-204107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4BAF8F1D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74661764FE
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C072EE604;
	Fri,  4 Jul 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpiG6HzS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3AF2ED85E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622660; cv=none; b=C6ocuOch/yp/+FWBNsHo0XdmgiNZfMDHd4KM6DUWSZU4CcRGh0pl4Rfut1wWL3NFP4Osa+NvV+E4/FHBZOK4ueBNMitIxCfSuCCDupY+o0/8YcInrQ2QXw6S9LIRdrGcUICReBIZqE/THGDJTCrSvJo/YVGSDAe4wgrwK0vPAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622660; c=relaxed/simple;
	bh=Zec5aAtgje1saqg3959mi64eaXHhk/cKgvNvFwImF30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RS+pomXtEG0jwlfd2Rp6jZQleUDhEBvmVV9wC21dTuCSjrrmBimh2E/cEoB44Sw14+yCaUmQVcy6rhttiEAgbdSdI1+dHtyg1nHOeKHR5RD5tQOop2qT3NMQSLfo6ILw9mk3TMHP49319ZZgzZ45AEGiqch2IPPb8l6R29K0TQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpiG6HzS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751622657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTdyBwlWGAyaHdEmFmxeJ+/oXgj79IJdQhxBgmlSUqU=;
	b=hpiG6HzSAhQ2OfLL0nfyN9Pfq1y34L1y4zmMYa7VmCbWT8CCi2Z57nUUnDZIJo0aV37uCl
	iCUbozZJFe6MV9tHCycbEwi4oUVAaKNgAAVERZnYTmBLBJOIYpXbuV3vjM0U+h0FUprkoD
	7gmdxjOImS8AXAORQxvLmeN2liYoeDs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286--GIEnf0VNaOfDLnbQMOu0g-1; Fri, 04 Jul 2025 05:50:55 -0400
X-MC-Unique: -GIEnf0VNaOfDLnbQMOu0g-1
X-Mimecast-MFC-AGG-ID: -GIEnf0VNaOfDLnbQMOu0g_1751622655
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae3b2630529so51530266b.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 02:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751622655; x=1752227455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTdyBwlWGAyaHdEmFmxeJ+/oXgj79IJdQhxBgmlSUqU=;
        b=PJWAzPjlcrW7klv9/FJU8IB47ZnPDDcLvMkYCOY5mIPSVJXQ4dzyqgxZjWwWFBsSUR
         WtOhapsWCEy42Ychpj16E9pnQSsSdvrBFZlzCwrH22Uhu3bBCwcnm1ZD+PNCFfRidaQV
         b8MxGDuaP5LTRByXZ3iQ7HQW+tshMkjoCVJ2FChCo9edJB3YBbJmTV8V7w7+30/ptjNa
         Mhq8Ow2TFeYbFxjs2mqG9DL9F2fhpV0aPTuY3ktHVEN8jsf/bgTZEtl1FMIRi+oe1CWX
         /S1j7o654KD8UKNV690zcxMGOV6+ovKPd+ma840mQrxEiDwXknWAf3nlqBdcfs3ttXNw
         uZhg==
X-Forwarded-Encrypted: i=1; AJvYcCVZnC5GM8mhqEcC8DH4QbQAaM6Zk+qUp35WccishCz9PEtLw2hPrrrAkLR4PB+gDwOKOHHVOUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xntLiDM/zd6u62Bx4F4y7fIG2WejJ/QNU7ONwOmuHmdId9tF
	e4FujCdvofkj73R63AME7pP5xFyzAsDiRWnWVTv6FibaJ3HCIOqBOaZQcuI8cYOyR2Mc/pNzaC8
	2+Jt1oG0GK+/xhJm0VfejdAXkudfjDdxRuRXpcc3EIZUnDj/vZ5IGeQTkIzBtq9EaneaP8U3l4H
	9U91PCVvmGfuuTFmKeymqvA6Sa0Fa1IY6E
X-Gm-Gg: ASbGncskXeRlSwIaoMGZcXBeyt6eQqvV63pwEieW0xHMtsNtHdLHo1HJ2dmgw8xB1C7
	57qtTHGk81ES2vZ+05644u2z42tIxcrm++AFvOmO1Ai6rrlfs1gPRKwL7fzOBdoyXBNt9do8Fly
	kzP5sQ
X-Received: by 2002:a17:907:d0b:b0:ade:9b52:4da0 with SMTP id a640c23a62f3a-ae3fe791341mr118180166b.60.1751622654593;
        Fri, 04 Jul 2025 02:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ6rmo441u00rCw39ALIYLXhXjrSJGPTmWEcD7E0TeZdIInSkqrp6WRoYHqk0yeiuf4JW6qAtpz5TNgnRXERw=
X-Received: by 2002:a17:907:d0b:b0:ade:9b52:4da0 with SMTP id
 a640c23a62f3a-ae3fe791341mr118177466b.60.1751622654163; Fri, 04 Jul 2025
 02:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701164507.14883-1-will@kernel.org>
In-Reply-To: <20250701164507.14883-1-will@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 4 Jul 2025 17:50:16 +0800
X-Gm-Features: Ac12FXwqxd82V3LOjpodDJwMF_q2dHh_J7JtDHMWUmQsDfy8ZtrC-XST6Mt-11Y
Message-ID: <CAPpAL=zBxWBTQ8s-DGG-NywoE2+rDJQ4=9XGGn-YZSFH3R_mZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] vsock/virtio: SKB allocation improvements
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jul 2, 2025 at 12:48=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hello again,
>
> Here is version two of the patches I previously posted here:
>
>   https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>
> Changes since v1 include:
>
>   * Remove virtio_vsock_alloc_skb_with_frags() and instead push decision
>     to allocate nonlinear SKBs into virtio_vsock_alloc_skb()
>
>   * Remove VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE and inline its definition
>     along with a comment
>
>   * Validate the length advertised by the packet header on the guest
>     receive path
>
>   * Minor tweaks to the commit messages and addition of stable tags
>
> Thanks to Stefano for all the review feedback so far.
>
> Cheers,
>
> Will
>
> Cc: Keir Fraser <keirf@google.com>
> Cc: Steven Moreland <smoreland@google.com>
> Cc: Frederick Mayle <fmayle@google.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: virtualization@lists.linux.dev
>
> --->8
>
> Will Deacon (8):
>   vhost/vsock: Avoid allocating arbitrarily-sized SKBs
>   vsock/virtio: Validate length in packet header before skb_put()
>   vsock/virtio: Move length check to callers of
>     virtio_vsock_skb_rx_put()
>   vsock/virtio: Resize receive buffers so that each SKB fits in a page
>   vsock/virtio: Add vsock helper for linear SKB allocation
>   vhost/vsock: Allocate nonlinear SKBs for handling large receive
>     buffers
>   vsock/virtio: Rename virtio_vsock_skb_rx_put() to
>     virtio_vsock_skb_put()
>   vsock/virtio: Allocate nonlinear SKBs for handling large transmit
>     buffers
>
>  drivers/vhost/vsock.c                   | 15 +++++-----
>  include/linux/virtio_vsock.h            | 37 +++++++++++++++++++------
>  net/vmw_vsock/virtio_transport.c        | 25 +++++++++++++----
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  4 files changed, 59 insertions(+), 21 deletions(-)
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
>


