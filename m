Return-Path: <netdev+bounces-80945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013B881C4C
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 07:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719A21C21098
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D687D39ACA;
	Thu, 21 Mar 2024 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz093ayf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486B3A1C5
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000951; cv=none; b=qWoJwUcG6IRmVpV/7R3RlgPJL8NZEwMKFb53+C4k4h60xBpzLO508EgHpYNGyYO/HURGjOKQOjKByQTSXz3j6whIQgYnpyg6J1EOD4rIcUHJoHy3Trv8DWAuFqhvHM4m+I21wyQ057DDamQ4emftGDrqA/LX7A4WM55x2TxlCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000951; c=relaxed/simple;
	bh=/XNaH2GsOU/WDny4Wlc5IeXExDMJDiR5r+yWcuxVMGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ8ky4lF0Hsg4bd/0J/EKNgTgI1nmUfZbNfnfUCH82eUPzYtf4gQiFW6nqoKJ0/HJXEigGqD4texX/BxXHHGIzly/E6lAwBiIOCbSD0fFmtXP3ToZWXXyz0fbUykLpoxqnhZauVnfVhs9JcQ/b+OWVOIfybpE0zqxr+swnIQQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zz093ayf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711000949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vuicHnylxzGQDV+/ztVXw13jQ4DoAJlRs6KRNLC5Rs=;
	b=Zz093ayfUUlwx88jSHSWf3vvzzcKyjuN5ZF49+fyB9mrla5A0mQuSn4hW+LfKN5N0z12vF
	wS+J/aUb2BWEZA+8ZiyV9p1Iu+nYV8T+4VxPpyw1oZO5s2VgWXMgOall8qrYSOB+PqOgOl
	V4Jaxm64Bc2uKM+vjN799sfp63PPYJw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-FZI4PwqjM329Ln8f6zLITg-1; Thu, 21 Mar 2024 02:02:27 -0400
X-MC-Unique: FZI4PwqjM329Ln8f6zLITg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29a5bae5b3fso504332a91.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 23:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000946; x=1711605746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vuicHnylxzGQDV+/ztVXw13jQ4DoAJlRs6KRNLC5Rs=;
        b=ubzRc4R5HQMzU4Nu5QVic0qDz3NTP9JGTNXAuCS/1qClWvyrzdYLXiHmKxST/QPvwA
         iVO/TosOK4jElmnL6p7Ae76jO8rs6txeLT5+ckoSsUBUVV3z3ZUIq9vVqIYhUqlreMiX
         syECGtmViGeYssI/dVg7++st7VrUNYhBC0deQEKgM+rP/L13e/nbPM1vQe4zlnbDX05s
         pZrizxuc0WPPgfRzCYNcrBeyM3j2ZbCNgnYL4vyab2JGstAe1W0QWNdHYm9nVjX+Zon+
         T2xETO0ZyFg0a8beR1I8uwLKpg8rKSSh3w1KfYjge94A6ZG7TVPdpnZH3OQjRNeHtYZ1
         NOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc+CAuzbDlPKT7QzOyIT5xxxGJj+/hOTXge4zQiHWV88s8Z8vc5sGpBS5YxpwzxPDTvggmSvhkrZj/A1L1BEsaubv6swES
X-Gm-Message-State: AOJu0Yzs+ykx2u6dvDtV0fNJlquwueVI+EecYSz1NUklZpQFiwMCWiPj
	ghBg15rBo2maVhPQvSfmvYAHNjTCzJw8ebUOGUPtZFS5gvDkO6w9dDMrFuY5FMFvb5CtGPB5xxI
	Jpozlm3PtMMOjIttOmc1KUS6R/wDzYYGQSuyqplOElpMLkJenbMh5S6J2b8t+Q6+vCBNMJQwNDP
	pkpGjuoIMUMAhcZdeUXBV5vhloYHls9GGn0L4R
X-Received: by 2002:a17:90a:c205:b0:2a0:1f2:e3ca with SMTP id e5-20020a17090ac20500b002a001f2e3camr3552637pjt.36.1711000945859;
        Wed, 20 Mar 2024 23:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHeLVf5h4LzIZIfZKxP80v82NuonNGoI4t71vA7UUS8pYlEZwb9YyuJi9GDa0d3KhkDallWmzSZ2z5u2omwAU=
X-Received: by 2002:a17:90a:c205:b0:2a0:1f2:e3ca with SMTP id
 e5-20020a17090ac20500b002a001f2e3camr3552621pjt.36.1711000945573; Wed, 20 Mar
 2024 23:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240312033557.6351-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312033557.6351-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 14:02:14 +0800
Message-ID: <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
Subject: Re: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped
 support disable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, the API virtqueue_set_dma_premapped just support to
> enable premapped mode.
>
> If we allow enabling the premapped dynamically, we should
> make this API to support disable the premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++--------
>  include/linux/virtio.h       |  2 +-
>  2 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 34f4b2c0c31e..3bf69cae4965 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>  /**
>   * virtqueue_set_dma_premapped - set the vring premapped mode
>   * @_vq: the struct virtqueue we're talking about.
> + * @premapped: enable/disable the premapped mode.
>   *
>   * Enable the premapped mode of the vq.
>   *
> @@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * 0: success.
>   * -EINVAL: vring does not use the dma api, so we can not enable premapp=
ed mode.
>   */
> -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)

I think we need to document the requirement for calling this.

Looking at the code, it seems it requires to stop the datapath and
detach all the used buffers?

Thanks


