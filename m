Return-Path: <netdev+bounces-192101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D8ABE8C7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F1B1B6614C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334313CF9C;
	Wed, 21 May 2025 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M39czcrZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3D13BAE3
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789351; cv=none; b=Nx8UfYcy89L9tAazQdbCRpgV/3r9hVm6fXYvJDQz3Ssbtefgi3EZDdI/DipZ9nqQFEvs37RLIFlhtQl3d7t9Ua6LRvKMNL94+c1wc9rmzoSV6RPA/AR+HtVNmp8HGe4gBJ0qufSgj0MObuwjJgPrGwExkw07q7dW+Bn0IVCLKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789351; c=relaxed/simple;
	bh=O33VdhTCzVm3TAY1aERPfCWJvZB/zfCLqnEIZIZqyig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZpU5eFTxVImB77R4zZv0ylye15NRSk44Rx0VnF6L+tvAGvCEFIWcs8TGdJyU8x03PplYZTkUJagXmTpi3mBV6q2jt5f3+m6dl/pCNK428tunzWI+w7Os3Ra5m6+bGMQAA1QRtYQtddfFUEx8ZIpSjE8Jym2OwL5tI0KyFTTfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M39czcrZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747789348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rc0wCNIYnwUJVUAky1/kj4SQFT8RKF0SdRFnhcDQNLk=;
	b=M39czcrZZiYquveJ15YHXZ4wEvPJudpeN1fzj+jLIZxn8xGnVa9VVdu3wZrLpxFJN1yWaQ
	401BjT0tgBBMfE8sE/ZgsjEAZEtvJJmPzIo4Ikitu9aVZ/7rnrteECo01pZckiiiuCZiyJ
	NHS608PeVkvYAGouXyfsIb5pj1rKbSo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-keSRjMJ4MaKvhDp15mlSzw-1; Tue, 20 May 2025 21:02:11 -0400
X-MC-Unique: keSRjMJ4MaKvhDp15mlSzw-1
X-Mimecast-MFC-AGG-ID: keSRjMJ4MaKvhDp15mlSzw_1747789331
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af9564001cbso4092068a12.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 18:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747789330; x=1748394130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc0wCNIYnwUJVUAky1/kj4SQFT8RKF0SdRFnhcDQNLk=;
        b=nCa4rH7EEWWXXNPIi74vQ9zoAVLLTm3R3DMbmlb6h+n3apQIn2EBU1y5Ntw65LLQ+Y
         ASS0VdsHue3vG03VBcorUrZlSUsTRKzAHIBAsuGdE2/l+8vXtGmBWMgUTTjNY1ehqzcN
         ks8l28/hkOElDc4Oif2DEWY54bedHX2eRz1t8UrdsLq77niduEojt6UHp4d2XQYKfqZ9
         qKtiMACNLhWopnQWhm6lojoBtq1YGslDIA/F+j8VRnEtNVwE61wGlNwHy3VzWNKrRCvS
         sP3q5khRCsgBEijvBun8h0SaEaXGf6B5qyvmy03CQImE8rwgAo7q3pxCC2T4+DLZK9d5
         JEng==
X-Forwarded-Encrypted: i=1; AJvYcCUQtf76S5M9WIbvUE6JPElHHrooDC7a07rT5W64CUoOyvZ+24HWoLsFxhO7XlwrmfxCs+bOSow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQguc6RdS22VnC8l1JO6MufWJMAfVCR1jtERvZ0TeTiPEoafzJ
	kuP/lf33dZEXTMm2ujmmZZpEXEIFb0bR9SifNx93KAkxeUdT/f8TAmkuvv/PGnt+Kn9Gp4ktdRp
	uLy6+0+t4x6ZW17NO9opBrejcgY41GSlvgT5hodxv+BLbtdj/5H912ucFVUPwmgoTVUgFBGECuy
	wAiMZrOa1yiUf7/9iZifJBcplr+LVvtauKk3EB34EnW4PKWw==
X-Gm-Gg: ASbGncs2lL2uiv0jXhypTV89mGL9utaJxQK/26HXjs1Cv9UmPr8H7FklGnv3xNAnDNK
	BLjykgD6Toz1tW/uYfk8xJiVIt+zT4qUv0EJkgNA01E9Azhro1xgIOKxRyH+lr58HXMT5ZA==
X-Received: by 2002:a17:90b:574c:b0:2f1:2fa5:1924 with SMTP id 98e67ed59e1d1-30e7d5b6f64mr24922203a91.26.1747789330317;
        Tue, 20 May 2025 18:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVVFvpZdZ4r+oVmhw4/sv1St3/fu3mLokNhAk5APUxIRZZh/XvVJIFYhEQHYIh8xHlAFatT9Pn513p5tplJJ4=
X-Received: by 2002:a17:90b:574c:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-30e7d5b6f64mr24922153a91.26.1747789329792; Tue, 20 May 2025
 18:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520110526.635507-1-lvivier@redhat.com> <20250520110526.635507-3-lvivier@redhat.com>
In-Reply-To: <20250520110526.635507-3-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 May 2025 09:01:58 +0800
X-Gm-Features: AX0GCFsaYO4uVJj44snCtrWXyqLzuFjw3y_DOy4i26ruogIAYBQCZYeNoq2bDaQ
Message-ID: <CACGkMEudOrbPjwLbQKXeLc9K4oSq8vDH5YD-hbrsJn1aYK6xxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio_net: Enforce minimum TX ring size for reliability
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:05=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> The `tx_may_stop()` logic stops TX queues if free descriptors
> (`sq->vq->num_free`) fall below the threshold of (2 + `MAX_SKB_FRAGS`).
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
> greater than (2 + MAX_SKB_FRAGS). This ensures that the ring is
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
> index e53ba600605a..866961f368a2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *=
vi, struct send_queue *sq,
>  {
>         int qindex, err;
>
> +       if (ring_num <=3D 2+MAX_SKB_FRAGS) {

Nit: space is probably needed around "+"

> +               netdev_err(vi->dev, "tx size (%d) cannot be smaller than =
%d\n",
> +                          ring_num, 2+MAX_SKB_FRAGS);

And here.

> +               return -EINVAL;
> +       }
> +
>         qindex =3D sq - vi->sq;
>
>         virtnet_tx_pause(vi, sq);
> --
> 2.49.0
>

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

(Maybe we can proceed on don't stall if we had at least 1 left if
indirect descriptors are supported).

Thanks


