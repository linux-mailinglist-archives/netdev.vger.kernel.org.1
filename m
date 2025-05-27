Return-Path: <netdev+bounces-193578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C36AC495D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D67F16B915
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745C24888D;
	Tue, 27 May 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzGdjdbT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1D242D69
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331204; cv=none; b=ivIm55gl9y/Cozb4Ba4+ePsQIsoLEXr5x8JApLj+WswMaT3oOii6LOEaegjRQD679DKP3/1X6wh2h49YRQ/ytBdB53IBs4cxnVwg89QRUlrQuZjXe4cMqhnDP0Vsyr6LnmQK2leGFchoMRTWYtBWkA/NtfC+C+y6ZiUodpYAANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331204; c=relaxed/simple;
	bh=Q5exNgIPZ3rcCXxGY7JdPG10hbHpapVoeEeX30T1eXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9wmFVECWSVK4jxghok6GKjox9FbiKM1LOKlzUVk2CzQYw6AEusghP9xL2LhhUw9U3E4nvx/Xca8+j+ls86kx0ApVChvnLu0jcFTreON5CDTRbyyr2lVTAUAJl/VobkKQNmW9686XZaa0vN70PIVzL6hBOvL+vRWCabAUViooAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzGdjdbT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748331201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cunzgH7S+aLdgPq0k81WwhGwjgYto2/OQbbZ283U668=;
	b=FzGdjdbTDMJvRnfzABiT54n0xWrGxx2+LUlJkFpPPWKzukBVga2nWsdeRHFrDuddEUZKpm
	WrBE/UHLtqZzoOyht50WNMsKCJ14zs4Rs3ejLp9TMNQsHt8wdp+FoAgqkp5emdiPO6E4T+
	zEc/Z45gIL/fYsAuSqN1BFcm8irTzwo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Cumz0UP2NLGxltSL1K5sww-1; Tue, 27 May 2025 03:33:17 -0400
X-MC-Unique: Cumz0UP2NLGxltSL1K5sww-1
X-Mimecast-MFC-AGG-ID: Cumz0UP2NLGxltSL1K5sww_1748331196
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad5271a051eso276242066b.1
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 00:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748331196; x=1748935996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cunzgH7S+aLdgPq0k81WwhGwjgYto2/OQbbZ283U668=;
        b=jZDRF6matnKcHkMvt6YZA318JcuO0+KnINENcsHzZoOrQ2JBhMjAoTTNAG9l6uPWMk
         7J5XQVE9XjdesxQ9FYUJBBEi9z3HyRzC6gu4yRtVlmYH/6T2ZzhZ5WAhsgfW3bik6y7b
         FwuQ/lTB+Osz1JW5tqPloYpTj4jhKxgheKe4d5+/JwPxF4vZ5o2FOmt/20yGO4J6/I5O
         nNVt7j0lUNBhjSWHHTw9gfSMLj1gLf291tAyD+ny0eAwbw1QSC4L1sQa87PqQL4TNpIF
         Tt0CpkOnEyjTAwa/2l8IhDhLm9h84gwz4mRAyWHDsefwdrVy0V9EmXgpHnDiaThBoQhE
         kCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbGCTLoEWqqup9+6bUjPPsXVMhn08ZxyooQ7LL85kQzo0Myb0PApSKVx4xfnudjSD6npNb+Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUirgdakafN9eaBfwH4op/iq10rLgKrnhjusHFnA/k4TxFhKM
	JPEDpkd5Q8WKjo57JmCvSopdf5qPU89+YQQO6mgTaFId/pR7lGZUR/3K7QYp+pAt6Dz9IRW9sjG
	wXQgfCQr2+Tor2s2E+y3YyhlT5csDsUX5gSyZ6wSb13623pBMSgSKaqDVnzHomn+jxnz5qaMrjX
	zievvFlN8u7v/FgQ/c1mFmjtFXBW9gFpT0
X-Gm-Gg: ASbGncuihm7r2aISrcPBNjteU4elcecDEKGRxYalSJro5fCrNkI2PJd2bYc0QlQq0/L
	gLk9lXMHcjs5sRgsLZ22XFT6Nm8KvgiBcFO99+CkxfKWnRlQpig0hBX7EnHcgSVS2j92HtQ==
X-Received: by 2002:a17:907:2d06:b0:ad8:91e4:a939 with SMTP id a640c23a62f3a-ad891e4ab88mr90913366b.31.1748331196133;
        Tue, 27 May 2025 00:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE+yREw9Xt70cyZxJq0TzH4IO2hkS3lRZlAYZQR0TOm58NlaFFrIin3Tp0JuOk9uXg1wuPKl8my3Y4oIddiFk=
X-Received: by 2002:a17:907:2d06:b0:ad8:91e4:a939 with SMTP id
 a640c23a62f3a-ad891e4ab88mr90911466b.31.1748331195805; Tue, 27 May 2025
 00:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521092236.661410-1-lvivier@redhat.com>
In-Reply-To: <20250521092236.661410-1-lvivier@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 27 May 2025 15:32:39 +0800
X-Gm-Features: AX0GCFu3yaPuYSMtDazhp-Ne51miEA8ZjlwJwMW50oQSQAStMU3hnrGf9ypWHq0
Message-ID: <CAPpAL=ytK4SA-m0ZWvByVJrTNTGzvqkpiC-yGvDB7KBBXWwm=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error reporting
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested pass this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, May 21, 2025 at 5:23=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> This patch series contains two fixes and a cleanup for the virtio subsyst=
em.
>
> The first patch fixes an error reporting bug in virtio_ring's
> virtqueue_resize() function. Previously, errors from internal resize
> helpers could be masked if the subsequent re-enabling of the virtqueue
> succeeded. This patch restores the correct error propagation, ensuring th=
at
> callers of virtqueue_resize() are properly informed of underlying resize
> failures.
>
> The second patch does a cleanup of the use of '2+MAX_SKB_FRAGS'
>
> The third patch addresses a reliability issue in virtio_net where the TX
> ring size could be configured too small, potentially leading to
> persistently stopped queues and degraded performance. It enforces a
> minimum TX ring size to ensure there's always enough space for at least o=
ne
> maximally-fragmented packet plus an additional slot.
>
> v2: clenup '2+MAX_SKB_FRAGS'
>
> Laurent Vivier (3):
>   virtio_ring: Fix error reporting in virtqueue_resize
>   virtio_net: Cleanup '2+MAX_SKB_FRAGS'
>   virtio_net: Enforce minimum TX ring size for reliability
>
>  drivers/net/virtio_net.c     | 14 ++++++++++----
>  drivers/virtio/virtio_ring.c |  8 ++++++--
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> --
> 2.49.0
>
>
>


