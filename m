Return-Path: <netdev+bounces-204124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB6AF8F5F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A706158699F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256612EE96F;
	Fri,  4 Jul 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJnu80K5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6E2900AA
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623445; cv=none; b=P+xJp8SsnBkqHY2lyfHoBjN94feb6U7hopTnDkKbidzr4HSxwcAVF1+Fw9yGYPN6YUPzXDPtXxprgWsXVaW8L8FWOmrzy4+pg3MPY4QYuHiiq6uzR+UNcaqWbqrcHlD7P1RMEiyHygblQV/3qXSuKEcnwkuC7+vCPuj9UCxCawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623445; c=relaxed/simple;
	bh=B7aUvk/jHjdAbP1Txi087l61k45RNX1ZWe+SIygilVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n10zkM94HWN4NoSzCqBRDmL2sc1frIt3L5azcSgSPrn9X7L97YWRzH/hnL6CV50EmsZeXK4PVTK5UNtUoIcT2DUCgcatL17f/LyAAyMTAyNI1WdrtyvpVUU/S18Fquee0uepqN3J7C2ZiwZaH78Q0epwyIfxtwva0g4TNlTtAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJnu80K5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751623442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWi88a+JkVfvhFesKDsYwPcS3Up3wpcEEvDnhl9YEKo=;
	b=UJnu80K5FfXIcTUpsh0CkcpNPZnGSZ0u2illoO2/caqzWH3NvBO7eprHjWYS7TWoKpQhvj
	m15ViQNmfDSEUk/rHj48kJqOBaAFylOHi73lVP9X/z7JGCA91zlsgkJ4JJ8lt0gItZI3l6
	s5Vc0r6TExzAwTFfSFn3PL6t598J8ns=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-zzS39xkCOY-UIyh8i2hMrg-1; Fri, 04 Jul 2025 06:04:01 -0400
X-MC-Unique: zzS39xkCOY-UIyh8i2hMrg-1
X-Mimecast-MFC-AGG-ID: zzS39xkCOY-UIyh8i2hMrg_1751623440
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae371f9e3f5so185957966b.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 03:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751623440; x=1752228240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWi88a+JkVfvhFesKDsYwPcS3Up3wpcEEvDnhl9YEKo=;
        b=wx2dQz2JkQ83FBfKtjnet2RMkAjmf4aFYd3oWT2ShZ7gO33h3OuePmYs8Hnx5evM4w
         Sgrnjt5xNGU5z4BJDcvjRSigPMLYrKUW6X9njKfyNiUNY9qBKIugqvEWj3XfMbxm6kvd
         igssVFaKQ42LKzdFvT4JNNkOrLAgVlHznQFfRkmwlW+fnOPlpviwegWtTb67QLPkX0xK
         G2PXUwjSviashMGXzHnC1pM3ZtjYg8ziTNxaJW9B9ol0chimEbmOHbZ4dhRKtMOaELvw
         qExvsfNOdd5BhYfRLjMLSryf0AgfCR8pvfwcInHf0StFhUN4ujIWSsoM4owVGyYk+j3a
         frCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVEUqZSCBcXASAcIa1yr+MADBDbVBr0MT7hNzcaBVR1H6iURxybl8n9gftH0b1aMoP2Pp6b44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQXL7mE2TCjR0NO5neTyIVBFq8LAC7ejpLTGVPRfwORpI9MbY
	45OrhZlIc8p8j0ZpBF9tU+k/0ID6BNVdsK/oHjC9a/Mgd3Dp8y49aeMOlH0UK2PbS9D530hq2/1
	VBO97W2Qe+oaKWJ4KwIQec3xG+lVHURUEnyv+g2MeZ79ZXBPcBKsvB1T4efWhElsmDK1z8g37K3
	G0vi+uayOiWDGPWf/f992p20SURwj7mQLZ
X-Gm-Gg: ASbGncuLC4hfcSmQP+W8hJG2hx0t6x2UsQARiVk/Q80NT38B0rjKv87+yK4HUd4xTqT
	iUvVrcq3I18An/DxnecIQ/sZSJWGXhcVN58EmRUQ0izgsJcqoeANNSRPyZEaJBce9NmfSGfYkaR
	MwWy9Q
X-Received: by 2002:a17:907:1b28:b0:ae3:6038:ad6f with SMTP id a640c23a62f3a-ae3f801ffffmr257591966b.3.1751623439672;
        Fri, 04 Jul 2025 03:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS9N1eCIk/WZ0O55TJaTXfCqhycvxAdX3gpiv7v0S1xEAaaTDokoaZNHnw35/eNshgWtKvOMMHV8DKBFb9MEc=
X-Received: by 2002:a17:907:1b28:b0:ae3:6038:ad6f with SMTP id
 a640c23a62f3a-ae3f801ffffmr257584266b.3.1751623438615; Fri, 04 Jul 2025
 03:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702014139.721-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20250702014139.721-1-liming.wu@jaguarmicro.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 4 Jul 2025 18:03:21 +0800
X-Gm-Features: Ac12FXx2LPRflMaDOhrK2WN9s4Zkqha02pwAGwf7MkpIy2PH8obbz9l4skjV1c8
Message-ID: <CAPpAL=wY_JU7r8oWgcF_keq+rbpGdkhS5KF0K67g=rbX7_nwng@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: simplify tx queue wake condition check
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virito-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jul 2, 2025 at 9:42=E2=80=AFAM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  drivers/net/virtio_net.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..6f3d69feb427 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2998,12 +2998,11 @@ static void virtnet_poll_cleantx(struct receive_q=
ueue *rq, int budget)
>                         free_old_xmit(sq, txq, !!budget);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> -                       if (netif_tx_queue_stopped(txq)) {
> -                               u64_stats_update_begin(&sq->stats.syncp);
> -                               u64_stats_inc(&sq->stats.wake);
> -                               u64_stats_update_end(&sq->stats.syncp);
> -                       }
> +               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS &&
> +                   netif_tx_queue_stopped(txq)) {
> +                       u64_stats_update_begin(&sq->stats.syncp);
> +                       u64_stats_inc(&sq->stats.wake);
> +                       u64_stats_update_end(&sq->stats.syncp);
>                         netif_tx_wake_queue(txq);
>                 }
>
> @@ -3195,12 +3194,11 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
>         else
>                 free_old_xmit(sq, txq, !!budget);
>
> -       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> -               if (netif_tx_queue_stopped(txq)) {
> -                       u64_stats_update_begin(&sq->stats.syncp);
> -                       u64_stats_inc(&sq->stats.wake);
> -                       u64_stats_update_end(&sq->stats.syncp);
> -               }
> +       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS &&
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
>


