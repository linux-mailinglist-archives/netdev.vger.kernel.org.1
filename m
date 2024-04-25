Return-Path: <netdev+bounces-91150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7C8B18C7
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 04:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C837F281704
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 02:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174D111A1;
	Thu, 25 Apr 2024 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAlMJxXr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383A1173F
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011132; cv=none; b=Bwfgc5WlROtNokuHQE/rukmN/UTagdm3BwFRWYkLum+5eLkDulHx6qdjjinvI38bzJl5t3hDg31EcikK9F+TK0FoUxM0XBUGwhTDQ/Wez58kC1+KVQDt/T4KbCPTA7bHlTlsoMCpgU4g9ADRonoCkJcgvVL+T0B7PqHYVO6g7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011132; c=relaxed/simple;
	bh=yShuvNccjLyvICZ3HWa71xpZjSNMMVy9zeSiecZZBQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3yZYYOdLy7GrjsMEbuygUkeVQ1e3Slhhse+KNiCWyhvUX9cZSdo1C9n1oMQI1xt8jLotz98fiG7589lEC7v0lScCp2XDdqFZKchyPu9F9jjgWWunJP1BNialzyUYYWOf+L9RRIJTsnEdxe/QxBjVYSGi+qN0dWr6BvoK6J4xdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAlMJxXr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714011129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VieOJoodA3aQktmUt4XUYLH0Iv/muRLCMET0Cp2G8Wk=;
	b=LAlMJxXrBmit1iI1WfMVe20jryIvWvLN1wdd1fX5Hx0SvCAIfiC3aDaUFp8eFrtzJot/Kp
	+sT2m2wO2TTq0qe92md74dh4QP16+RFem0Ddg+GZxrV9s217hW0q2VDD46l6t7eiVwzgT3
	YR+mSGuDlV17BjX4NCyUMkfDO60iSmQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-mnR-ejAlO1CnHSDN22hivQ-1; Wed, 24 Apr 2024 22:12:08 -0400
X-MC-Unique: mnR-ejAlO1CnHSDN22hivQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-60a8670c960so58818a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 19:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714011127; x=1714615927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VieOJoodA3aQktmUt4XUYLH0Iv/muRLCMET0Cp2G8Wk=;
        b=qMNEWl5VepzvKLEwcEpB+46ZUrxiuMMI2OtGOuu3yKA8cY94FsA2AkkhdqI3oPSc1j
         CaL68Ae3TEqBigGhUxC4IoypSU7iLPBD9zvLGtgj+p7PtCPyEpjNiyuIyLGRW+JZXbwb
         SZXvJxMZDpdrUT1jHSiiwWoPSxMK5Pv0Y+lqPyv6WZq9t0lHCXXaMg2e2hkrB4g4dLsB
         UPHvsXji3GxMQUfhL85nhsQoAfH4j23sBGxyUHQm+Fsz0GrdJ4SnkkZ0BAN/v/jN2/Li
         RYuIP6ar0CaD83U//UoweXqjdkt9Qa0sqh/Prq7RkfesPIIc8yIt4exHTOjdoIiqoozn
         +HEg==
X-Forwarded-Encrypted: i=1; AJvYcCVc3t9nP9wY5/3aZ3ARiJm0KFFRykYId8ow9lOllvHC9YLXfHVWQ0J6gxlAJxIXsDhCXz3ihPrHoRy7elx+es7K9V9CGaQ6
X-Gm-Message-State: AOJu0YyPVQW/KleN1MSshOy829vKjXDCfGzJArAZkLsvgaVmQshNGTi4
	lANDHpxCXU8y4G7wvo1rRcLGcbFGCTxnt9+BLuyDn1v5faBJyVDIVbbqqH0gDzM/YCJHTzN9H2X
	BV6MaapvP8+AOpWK/Xo6LHv6LPD8dL+M8ERJWe71SPcwANQAtlVZB5ZCHe8GVtyy+SDWo8LQxfF
	r9geXe9WhfwfXBn0+eCak+t3CGQVpt
X-Received: by 2002:a05:6a20:7f90:b0:1aa:5d76:1916 with SMTP id d16-20020a056a207f9000b001aa5d761916mr5294563pzj.34.1714011127333;
        Wed, 24 Apr 2024 19:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtdiizeK+BxYnb7LzT0xWj3CdDiw5EZJx2ei/mgBGSNkE5gfIWc7AbKJjR5bL2uY7hDXujeHJ1mq1UP9aZCVE=
X-Received: by 2002:a05:6a20:7f90:b0:1aa:5d76:1916 with SMTP id
 d16-20020a056a207f9000b001aa5d761916mr5294552pzj.34.1714011127014; Wed, 24
 Apr 2024 19:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com> <20240424081636.124029-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240424081636.124029-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Apr 2024 10:11:55 +0800
Message-ID: <CACGkMEtf9twxTSGpGpmcR4LYS_k1g=NRO78NhkG4uLJ3d+TqAA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 2/4] virtio_net: big mode skip the unmap check
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 4:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The virtio-net big mode did not enable premapped mode,
> so we did not need to check the unmap. And the subsequent
> commit will remove the failover code for failing enable
> premapped for merge and small mode. So we need to remove
> the checking do_dma code in the big mode path.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..16d84c95779c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -820,7 +820,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueu=
e *vq, void *buf)
>
>         rq =3D &vi->rq[i];
>
> -       if (rq->do_dma)
> +       if (!vi->big_packets || vi->mergeable_rx_bufs)

This seems to be equivalent to

if (!vi->big_packets)


>                 virtnet_rq_unmap(rq, buf, 0);
>
>         virtnet_rq_free_buf(vi, rq, buf);
> @@ -2128,7 +2128,7 @@ static int virtnet_receive(struct receive_queue *rq=
, int budget,
>                 }
>         } else {
>                 while (packets < budget &&
> -                      (buf =3D virtnet_rq_get_buf(rq, &len, NULL)) !=3D =
NULL) {
> +                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D NUL=
L) {
>                         receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &st=
ats);
>                         packets++;
>                 }

Other part looks good.

Thanks

> --
> 2.32.0.3.g01195cf9f
>


