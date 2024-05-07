Return-Path: <netdev+bounces-93927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF2B8BD9A4
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 05:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC0283AE7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636E3FB1D;
	Tue,  7 May 2024 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNGqYTia"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FD40BE6
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051740; cv=none; b=UdRvaVhQ/xWM+gQhaqWoWDjGF8jvcLPsJeEbdIpU//Fgp8DRPcPXsUSYCpwBBUiIhLfhTsGnPlvQ4r0LVOmhu+ORKMrMiI/YjVnvDwaqL+r6WgeoY3jXtFf9qzGwkBlcdDdF1ydOQuEZBMjJp1ooqJZV1+J1RvWZMZEaw88JrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051740; c=relaxed/simple;
	bh=qsMSj74a6wtKbQn4FwSltQZ5iQWMntRYCKeVSm0ggfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as8KoPQYGqiAqVw44pcdAPbY1VS8c8m5c2BmBsBzxN+WgbMvWekNzsZXAAhkCDCdOOlkw/Wm5TWgcvo5+jBCyNfcSSl8dyEw3TCMy7Bjpb3JI+zV0mlgQynMp/qXKD9e1lOVwDrq3EC0xr39uw+oqHmg6FfysDeZ5ZifqMFLZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNGqYTia; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715051737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCtYHW0NjKLB0nCSn+O1Vd5dx6sDKEmMFyLfXDFnc2s=;
	b=ZNGqYTiatC1R1ptpRZCfaq5vE2kmHbpj/79C7OoUsznruMRzspy29+QekKmwMWePulBIKg
	bIygZEQl7hXNmrOPOuZ/+aw9wAD/BwtYy+9kVYcFYsL4/N3sTRLAz/0MDzUDv1k7tBKiAy
	n9bLmZbZ/HHTEfnJjljIMa8x6v8UcPA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-2lANPNXdPDm8oCpxlfrPhA-1; Mon, 06 May 2024 23:15:35 -0400
X-MC-Unique: 2lANPNXdPDm8oCpxlfrPhA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso2574717a12.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 20:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715051735; x=1715656535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCtYHW0NjKLB0nCSn+O1Vd5dx6sDKEmMFyLfXDFnc2s=;
        b=t32b2CRY5u7SvOPLo8kbBS9aEsWMyzSV0PxbJFIzv9P6Z8FGAfvdTBGBAkRszXUsaz
         c1LNnL0BkxpISL+WvBBPGgjY6TebcotkhBXjZhC2JcPHj6wQXPg3ypJko5EvPwHGUXmD
         FiG6jK0hB3/7Rh8UufsfvwbG/7bYmWCjGPcXTW4wZQXfVztr/amoWJQpWGA0UL9TAWuc
         n+T/INKZot/ZRjCk53JCKlQyMs1di5Ywud8VniZ0+Y4JL1csJGl6ZMOu/Ngkj7tMqsAH
         mz9ZpfxLXuu7ImPtwK4STNVVzqDqgOfQQAH6cDeVRbLWNP2vkQqnpbM9r78KPU7Z7XBF
         gbqQ==
X-Gm-Message-State: AOJu0Yz5GXDRlKqBl8aeHbPabios4BIqQd+aUbOXsqRY2+SnGX3Iw8wO
	zg+Bb7Sq5MFZuD99+ICzGTC8tQj24/huFamI10D9DGX++F+33F2khVlGkVKbf15gIzxq3FjLejp
	KDyJ20nBUVX7wXlVNVvDFyB09HUGIqQTxajoJZ1SW09FbkA37wiaa840GEDwz7m1RlsebZglOBE
	Vo6y3vbwMq5Cnc8giFzsujVnO/k3Vf
X-Received: by 2002:a05:6a20:daa0:b0:1af:3cb0:f2db with SMTP id iy32-20020a056a20daa000b001af3cb0f2dbmr12688849pzb.33.1715051734407;
        Mon, 06 May 2024 20:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX9sBdeavQCqp0GC2N3/y/+ZLxAXe4p2CEF5HWhRGx/SCiedoMN/x52vC1mUZO9m/vk0Q/ebW/v1owRqISEss=
X-Received: by 2002:a05:6a20:daa0:b0:1af:3cb0:f2db with SMTP id
 iy32-20020a056a20daa000b001af3cb0f2dbmr12688838pzb.33.1715051733995; Mon, 06
 May 2024 20:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425125855.87025-1-hengqi@linux.alibaba.com> <20240425125855.87025-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240425125855.87025-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 11:15:22 +0800
Message-ID: <CACGkMEtpy0ZDcGQReaPVtJy4hDcqdKQwEF2Uhf5W4+7g=jts-Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Control vq polling request results consume more CPU.
> Especially when dim issues more control requests to the device,
> it's beneficial to the guest to enable control vq's irq.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a4d3c76654a4..79a1b30c173c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -287,6 +287,12 @@ struct virtnet_info {
>         bool has_cvq;
>         struct mutex cvq_lock;
>
> +       /* Wait for the device to complete the request */
> +       struct completion completion;
> +
> +       /* Work struct for acquisition of cvq processing results. */
> +       struct work_struct get_cvq;
> +
>         /* Host can handle any s/g split between our header and packet da=
ta */
>         bool any_header_sg;
>
> @@ -520,6 +526,13 @@ static bool virtqueue_napi_complete(struct napi_stru=
ct *napi,
>         return false;
>  }
>
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +       struct virtnet_info *vi =3D cvq->vdev->priv;
> +
> +       schedule_work(&vi->get_cvq);
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>         struct virtnet_info *vi =3D vq->vdev->priv;
> @@ -2036,6 +2049,20 @@ static bool try_fill_recv(struct virtnet_info *vi,=
 struct receive_queue *rq,
>         return !oom;
>  }
>
> +static void virtnet_get_cvq_work(struct work_struct *work)
> +{
> +       struct virtnet_info *vi =3D
> +               container_of(work, struct virtnet_info, get_cvq);
> +       unsigned int tmp;
> +       void *res;
> +
> +       mutex_lock(&vi->cvq_lock);
> +       res =3D virtqueue_get_buf(vi->cvq, &tmp);
> +       if (res)
> +               complete(&vi->completion);
> +       mutex_unlock(&vi->cvq_lock);
> +}
> +
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>         struct virtnet_info *vi =3D rvq->vdev->priv;
> @@ -2531,7 +2558,7 @@ static bool virtnet_send_command(struct virtnet_inf=
o *vi, u8 class, u8 cmd,
>                                  struct scatterlist *out)
>  {
>         struct scatterlist *sgs[4], hdr, stat;
> -       unsigned out_num =3D 0, tmp;
> +       unsigned out_num =3D 0;
>         int ret;
>
>         /* Caller should know better */
> @@ -2566,16 +2593,10 @@ static bool virtnet_send_command(struct virtnet_i=
nfo *vi, u8 class, u8 cmd,
>                 return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>         }
>
> -       /* Spin for a response, the kick causes an ioport write, trapping
> -        * into the hypervisor, so the request should be handled immediat=
ely.
> -        */
> -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -              !virtqueue_is_broken(vi->cvq)) {
> -               cond_resched();
> -               cpu_relax();
> -       }
> -
>         mutex_unlock(&vi->cvq_lock);
> +
> +       wait_for_completion(&vi->completion);
> +

A question here, can multiple cvq requests be submitted to the device?
If yes, what happens if the device completes them out of order?

Thanks

>         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>  }
>
> @@ -4433,7 +4454,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi=
)
>
>         /* Parameters for control virtqueue, if any */
>         if (vi->has_cvq) {
> -               callbacks[total_vqs - 1] =3D NULL;
> +               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
>                 names[total_vqs - 1] =3D "control";
>         }
>
> @@ -4952,6 +4973,8 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         if (vi->has_rss || vi->has_rss_hash_report)
>                 virtnet_init_default_rss(vi);
>
> +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
> +       init_completion(&vi->completion);
>         enable_rx_mode_work(vi);
>
>         /* serialize netdev register + virtio_device_ready() with ndo_ope=
n() */
> --
> 2.32.0.3.g01195cf9f
>


