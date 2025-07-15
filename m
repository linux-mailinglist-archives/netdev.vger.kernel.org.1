Return-Path: <netdev+bounces-207201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13A3B062FA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D333C188EE40
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4123A9AC;
	Tue, 15 Jul 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv18ZkRH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB82566
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593538; cv=none; b=gLlJ6BVfwoPL+s1Jl68ybwwxA1RYqsNBDcVXjn+Kr73jAHE/W4MSFljcWA9SphTGi09GqLe4OXgN3fg2hrpr1H3Xi+P/GncNaD6lhaERIqjyZNylo5osurKpQKCw3caS7ruIUvweNKNM0xFoD6oHDwym6uYpUNSIiG41B+xC+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593538; c=relaxed/simple;
	bh=5rdRvK0/wv3rgyzsgXz0n1m+AdOdwgEE5BaXSVwhhTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0+QRJS2CgQ/6dA8FnK8/Z3vGd0C4WRirUOfsqbJngsazze/h8QSyK1o7RzosFL5VApxKS/7C7LL0mOlNRNl1MML/P7WmCdDfNNOlniNWIqoDyKTSaww55wvnKREOTlTmpEEBhYAJNJgOBn+3qcCH8netxHuuihBo6BJbSjjVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv18ZkRH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752593535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wnh22gI/k+OIEWCf+4ySowORAdVnUSIEoD4hbUCmi1M=;
	b=dv18ZkRH0oiu1oQitSuGn0p4yL4eV1N6U0PvL+YXWpRsHzEmkKcIomeOIJNHBcnkGkn5XT
	bdmmdWNgs9gcO47yIIwIZXCsDxkv4N3f1zuau6hoIzoLsTkANLAnLEKt6ILGbT1xdeQ5K+
	mSgUQmbBNNAjxJWI8kK8GQ/S8FbsX24=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-lSCPU5KIN4aMMuBBZTtRgg-1; Tue, 15 Jul 2025 11:32:14 -0400
X-MC-Unique: lSCPU5KIN4aMMuBBZTtRgg-1
X-Mimecast-MFC-AGG-ID: lSCPU5KIN4aMMuBBZTtRgg_1752593533
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae354979e7aso467668366b.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593533; x=1753198333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wnh22gI/k+OIEWCf+4ySowORAdVnUSIEoD4hbUCmi1M=;
        b=Wd3Gbsj1ZwrVIDyr1hvdaU7znu8bHVdo2PC0FT0/at2f02xGQw3Hm94LV+XZlkyKnx
         6jmpyvlWv6yk0j+VUnTeCTkJkOWxIYkhwFMlJAhSPAaDm8VBQbGhXBaUqHATSvaqYm2x
         F3mgHApy/E2UycQtZfHg0+ikYLUQTIfZCW3q8x0NzrZ7FHVEcX87lt4mfq/8/i4Cg0nG
         dHtuYxLPbqzIxuQzWv105Y98K6jSuUJnZe6xxmY/vusueOJ+AStNeNiFW+ZqiCd+RnEA
         +0INqmhAa3A/PhqncobHzuYhrM7eddWY80oOF68l03wtrg3k+tI2LtJ4nfTECbLKyXoQ
         cY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzT+JUySRxANG2HQqWsyJBlRYOja2gRBO92JP3IThla7UsoVMr73OoC9043MVfS8qRVX2gRVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDs6u8z5Wu43A+3//gh4D0FRHY/QvePGaPF3Eux/ws3a7qTWyv
	OlxECsIdo72tha9n3v1fYNYsVnstfer5rCFKbTwrj3XQD6N5YOx2dmD0+agQU1tXHg5sycLKgYU
	UHjhNV99KxgB8b7nIuXtkH2husDgdHluZqfLD1ZnYRvd4cRna6mMuVLWKVDskykG+3cWUF0xls3
	wSoyi5/Q7hCPJYlysMDz68baAxKq6X/i4y
X-Gm-Gg: ASbGnctUK7DefFDjkCa20pTQYfEhcs6gE2fJLcj1T6NgCdQSHJUdcvloRbICoOuwkp7
	EqAi2fDrWJcDiZg5YbRK0+pKV27deJU6jVilMsIpy3jtAOVkRAkv8GtE6DB99c50i8h+UScXzLX
	5K2hmfKCqeKaaZGGOoUX+oKg==
X-Received: by 2002:a17:907:cf93:b0:ae3:cf41:b93b with SMTP id a640c23a62f3a-ae6fc0a7f90mr1582698966b.41.1752593533369;
        Tue, 15 Jul 2025 08:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOIuENMcFdE7XVF/eBak/JoBXEh87UvUrI/EctpEOdONudRuCPXduAkkRmy07jHtjgT20K0pXxQIEZJ9U0ySo=
X-Received: by 2002:a17:907:cf93:b0:ae3:cf41:b93b with SMTP id
 a640c23a62f3a-ae6fc0a7f90mr1582696366b.41.1752593532954; Tue, 15 Jul 2025
 08:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710023208.846-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20250710023208.846-1-liming.wu@jaguarmicro.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:31:35 +0800
X-Gm-Features: Ac12FXx0K4HuoaUKypyFETVzBZg3F6wzzVt1s3aBwTTAZbrGnPQbtaOUcuDFRP8
Message-ID: <CAPpAL=wvL2LfRV5BFgLVG69hUoO5fYVx6WEK-PimjoQpy1S7ZA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: simplify tx queue wake condition check
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches v2 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 10, 2025 at 10:32=E2=80=AFAM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..07a378220643 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3021,12 +3021,11 @@ static void virtnet_poll_cleantx(struct receive_q=
ueue *rq, int budget)
>                         free_old_xmit(sq, txq, !!budget);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2) {
> -                       if (netif_tx_queue_stopped(txq)) {
> -                               u64_stats_update_begin(&sq->stats.syncp);
> -                               u64_stats_inc(&sq->stats.wake);
> -                               u64_stats_update_end(&sq->stats.syncp);
> -                       }
> +               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> +                   netif_tx_queue_stopped(txq)) {
> +                       u64_stats_update_begin(&sq->stats.syncp);
> +                       u64_stats_inc(&sq->stats.wake);
> +                       u64_stats_update_end(&sq->stats.syncp);
>                         netif_tx_wake_queue(txq);
>                 }
>
> @@ -3218,12 +3217,11 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
>         else
>                 free_old_xmit(sq, txq, !!budget);
>
> -       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2) {
> -               if (netif_tx_queue_stopped(txq)) {
> -                       u64_stats_update_begin(&sq->stats.syncp);
> -                       u64_stats_inc(&sq->stats.wake);
> -                       u64_stats_update_end(&sq->stats.syncp);
> -               }
> +       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> +           netif_tx_queue_stopped(txq)) {
> +               u64_stats_update_begin(&sq->stats.syncp);
> +               u64_stats_inc(&sq->stats.wake);
> +               u64_stats_update_end(&sq->stats.syncp);
>                 netif_tx_wake_queue(txq);
>         }
>
> --
> 2.34.1
>


