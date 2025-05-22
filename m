Return-Path: <netdev+bounces-192505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC81AC01F7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF871659D3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE878F4A;
	Thu, 22 May 2025 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="In5ujSIl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDB7346F
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879040; cv=none; b=Boa7Di+YRXBLhQnvQAD9w4J9LPzpoOxbgzYrNYkl/bgabs3zjwAl00gEoRfHW0mJmqex8NEkCXu8mBp7l4FI9NtRNBXYdb8K8OvY0R58vGwB5SmVGQhu+TsjMdSmAViHkPclWJ9a6qttcF5FzOAORsGqhbC7bQ8+K9Uh9UpecwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879040; c=relaxed/simple;
	bh=YoSCo1OLY/cJ9CLaYfzANnDqrQr4fOYlitnClfwyP30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2+g0q8AY3mQWk/EMTPngwOFz4cTAsdlqnSXvXa2X/INoMcR+3aUZeNzzThhN3Hw9DpVt1erplkqxldVMhMIiAFaoTVD3Bmkd4vJLwMf9NtBRA9c15iA4x4HjabElsTA4QwD5gSFOvA2h42xzY+HCMEgp+hkXJTSxzV/C81VN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=In5ujSIl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747879035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVv0T3X/nkiRNcQ1lUMwhZJmi4NAvNXbrMSeB9cuTI4=;
	b=In5ujSIldDvxYV5LSwYiDauTja3U4U81WAV/i+9IaWsmG+QlsoAPOGleIIJ4MtTod8TBQT
	Vok74a5wAf7JhpyLQU+0XTMPEu1yPcmzzMMfUt7d5yCzXmnw7NaB7wEW//GK2ECx2RRoH0
	Q30cl0+Z+7vkd4mK5rrzo1Wpkb8n+54=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-wJFvwUcdMA2e7ogoQLnI5Q-1; Wed, 21 May 2025 21:57:11 -0400
X-MC-Unique: wJFvwUcdMA2e7ogoQLnI5Q-1
X-Mimecast-MFC-AGG-ID: wJFvwUcdMA2e7ogoQLnI5Q_1747879029
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2706b51df9so3638553a12.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 18:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747879028; x=1748483828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVv0T3X/nkiRNcQ1lUMwhZJmi4NAvNXbrMSeB9cuTI4=;
        b=swdkplVl6WLD+6SqEiLwNUVMOCRMqZj8GqT4+YVEB6gSjFUuM9iB4ZKTplaC7HCNL3
         xBEDXuhOkO81rH6pQCYxsL7WJKCprFhYKmXv1deRqufYzDQj/a/IQdLl+wIScXOMWD3r
         kpNfpNIvvf0oZFzUbUVNnqO5vCQ5ot0sNwLaHezRoLcBMY15oytimGg07YiM2Gtcaqm3
         ubTCstEF8jxg12fBM373Vw/XYXTJWAzNZjjMSNQJwWpr8cnQPiyYEKkMiqow1R26cNHn
         T/ewhPH63KPLA4mvmbwinqEVMWPPwGHqVuuYif/2diTyQLZmysu08k8Pk92PQOdEI6z9
         m5xA==
X-Forwarded-Encrypted: i=1; AJvYcCV4gShHtrMKFW8ucNd2uR8FksRq99SwQPeI12myLrsx0XF0wxdxNXQB7LS7L5b464a3miXXimI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk21iW4ZjY+2N9+oWPohMogxXHOStbdgJM/tXyoKruiEDjf2JS
	vE+t76uezplAQoVb2USlJ5cHpFe1oajIJkGy6yvsLEvx0m9JLVByTEZg7U7sf0n7EtK3w9EPJIn
	yGcE9XPBIW81WPjDgjnsSAO5FyReU8Q+WXmQUBu+jYNxCoqszPWVet1Hv0q+px2gk9dp4bhl/pU
	X1c9/ABqh7gAvK0DO3dXc6UWu2xP7gF46SF+opfdnrNMEp1g==
X-Gm-Gg: ASbGncv3WTBtDpxf97Kkt7Jb9MYcdON9S/ySsl+vrIaQ7Vq850zEA3vsL/h6Ta8OTJn
	OurBdnErf7l6+5TXDmCQ/N5U+ca7v0pa0k9i2RM/Dcyn0rx6la206c2mPU3wJC46aqtCE5g==
X-Received: by 2002:a17:90a:ec8b:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-30e7de633ecmr35326471a91.10.1747879028222;
        Wed, 21 May 2025 18:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5z4/0/D7/zhmwxsFA9hlVnqABSKxCuovnN31Uf36DePUPnzuC9RA1PtrB9u1qV0YRXdqm2r7m67cykpEmzeQ=
X-Received: by 2002:a17:90a:ec8b:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-30e7de633ecmr35326439a91.10.1747879027764; Wed, 21 May 2025
 18:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521092236.661410-1-lvivier@redhat.com> <20250521092236.661410-4-lvivier@redhat.com>
In-Reply-To: <20250521092236.661410-4-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 May 2025 09:56:56 +0800
X-Gm-Features: AX0GCFtopRBJ8l40BSYI5k4Wdowo2Yl85Lt_6lA34RTQrfvR4Hig-8myMr3FqXk
Message-ID: <CACGkMEugbqFKEQ5zZrhz7wxETQQcGZK=SqQRbd59OOoy3y-MQg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio_net: Enforce minimum TX ring size for reliability
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:22=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> The `tx_may_stop()` logic stops TX queues if free descriptors
> (`sq->vq->num_free`) fall below the threshold of (`MAX_SKB_FRAGS` + 2).
> If the total ring size (`ring_num`) is not strictly greater than this
> value, queues can become persistently stopped or stop after minimal
> use, severely degrading performance.
>
> A single sk_buff transmission typically requires descriptors for:
> - The virtio_net_hdr (1 descriptor)
> - The sk_buff's linear data (head) (1 descriptor)
> - Paged fragments (up to MAX_SKB_FRAGS descriptors)
>
> This patch enforces that the TX ring size ('ring_num') must be strictly
> greater than (MAX_SKB_FRAGS + 2). This ensures that the ring is
> always large enough to hold at least one maximally-fragmented packet
> plus at least one additional slot.
>
> Reported-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ff4160243538..50b851834ae2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *=
vi, struct send_queue *sq,
>  {
>         int qindex, err;
>
> +       if (ring_num <=3D MAX_SKB_FRAGS + 2) {
> +               netdev_err(vi->dev, "tx size (%d) cannot be smaller than =
%d\n",
> +                          ring_num, MAX_SKB_FRAGS + 2);
> +               return -EINVAL;
> +       }
> +
>         qindex =3D sq - vi->sq;
>
>         virtnet_tx_pause(vi, sq);
> --
> 2.49.0
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


