Return-Path: <netdev+bounces-149257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137D9E4EB0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CDF1881578
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A71CEADA;
	Thu,  5 Dec 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuChJRyi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F361CBEA4
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384005; cv=none; b=CRnAGqAQKpABSSZAjQWKTt7Hppy2gohTVZbP6kxse3JHyV2J391i0f8Dfco8EofWVg0Pii3J2PsK69VdAbIi5RpbQo8H8ThOV8XAMr1qa0QuEbzSvOl9e1kBN0bH8FIzi86mVPAkCvMgVi5zNDKcdisKgQemhmjeMCR5LtS8wCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384005; c=relaxed/simple;
	bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H49eOVnwPq3Jq+NttCKZ+JaLzdCk0YCLqXwwTBkZkyvNYVjVicBZhMm109Yt/Rx0HfEuLgptHbl8k2H50z5XdxXIXSNN+j3DqnJ37Eb/B2oYCr+jHHmIsXIS+bCCRHPkmo+31+Rlk+46WRYBOKmXoEEKWhkrhSzfrHIkPpbf9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuChJRyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733384002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
	b=KuChJRyiL7529Dd9mQYgTJ8YdklBt+JdXQn9KpnPpxvkCT2LCuoRILBQgRQcTad9/ulOAc
	aB78C90Uot8JPUsm29rRRWtq+YcJFY5jXn3bM1FS3vT3qRMjqt/7XBDtNSHnuACU0h0mqX
	Rh70PjoSsbUOjX3LTZvxi3iXrEhOq5w=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Ga3NWg_iNpGdUsettSFnuQ-1; Thu, 05 Dec 2024 02:33:20 -0500
X-MC-Unique: Ga3NWg_iNpGdUsettSFnuQ-1
X-Mimecast-MFC-AGG-ID: Ga3NWg_iNpGdUsettSFnuQ
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-85b8c2b6ab1so167056241.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 23:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733384000; x=1733988800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
        b=TEP6OXFTmAyxDPfLf/E1ZIHZB6dAYNIl13r5ceV4x0aTHE99zL/7Siaz4i+kTpkiNA
         42HAV7K28NzVH5kjAN5uN28VKOm7EOFHn+/oKxB84Kl68ml9MjD70vYVjw74CPIsrz0O
         cNaPCQpFAZFSa9TQHNjV9sskAKdenQoRdhJlFmQEVNK5jIQbtSzGAW/+i0DIc59qlmhO
         e2n3ZChBH1ea6d2tTWVxOJ1lpGgdv2ztsgZkDmbdkOK9jgiBFIE+URHVxfUoGCNt5gCB
         bK6eXgUjWUXzIZq3c/8+W3VWz216cBr9Kdgqf35vBt9H3ErbvRE9j+m8zSbp9P0e8ckG
         jrRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlxmp8MTHs8MA3C8TkxL3waEMx5umiBidG36FJUsefByCFKrW/Z1ZVZR7nQ2zmIlUX9fzAVrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvV4cKcuqMWmtgv4jVgUbO1nipx80OYcN5A3ldKALxSqnLuS7B
	T4+Rm3xr9yareHbysSlMgk8HTjHlMcOjDf15CNzi1su3S6tD76xiCsQrwon5LTD4itV8wgAvq0P
	ZJy8D/MR522q8j4VapMAoZAzmI4cSzPNxfYjzkqqwUcXSQ0edYNdOsk3/IM62H8KiGbS7695J+o
	4fERzVXt320+CIj9x6OMznhAA7THFo
X-Gm-Gg: ASbGncvoMmSgp8N3Ym46teJw0UeraDY1o4rIuUyhErBJBYSSt4BZ7SwBNuhNw16llc2
	U6exgIFwlUf3OoDkAA05KDaAWJZvto3KD
X-Received: by 2002:a05:6102:e13:b0:4ad:5c22:8412 with SMTP id ada2fe7eead31-4af973616d8mr12754221137.17.1733384000436;
        Wed, 04 Dec 2024 23:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELTyIwlkQV/FRs6ijjhpSGbcHEbQmTZ4PYlrb2mZ2b3HG32XEj4FFiezBBQtrrkcWKDD+bF56IdeIGqAxNni4=
X-Received: by 2002:a05:6102:e13:b0:4ad:5c22:8412 with SMTP id
 ada2fe7eead31-4af973616d8mr12754214137.17.1733384000076; Wed, 04 Dec 2024
 23:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-8-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-8-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:33:04 +0800
Message-ID: <CACGkMEtd9-=TD2J-ds_NGnim-EeKYJxLiqJXemMP0JY8EuMeQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] virtio_net: ensure netdev_tx_reset_queue
 is called on bind xsk for tx
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
> DQL counters need to be reset when flushing has actually occurred, Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
> to handle this.
>
> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


