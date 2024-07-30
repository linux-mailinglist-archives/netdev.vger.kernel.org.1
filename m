Return-Path: <netdev+bounces-114122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08260941030
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891681F23C0F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE01953BA;
	Tue, 30 Jul 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USwzNjsJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1819ADAC
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337504; cv=none; b=u2WTQ6HUYPBA5UAVAfn2JldFHjxd+ryL/GQZYpq3jLbRMee7Q/vcNHea4XIAVHc4/r+/qKjGFjwnfYnxjwfmJeRKWOgwCEfZTFoWucamgwlc3QaEU1n8EEOu8cD9pJOxj+cBucoGEsE4l0mjv7DOis7XXd/fDV9vi9h0V14vvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337504; c=relaxed/simple;
	bh=f/gw5g15wTHKr48hY+hyHzqdgUY3CrBD090e33xvywA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GesyG0Mh7dbBC+YhYJ2z7kx4pSbXXhoY4aXVDnNjRvl/ybJtf3KPPYdrbkUuj7qVXb1L4mOp1lwWFNCcquBoVPpyagUhoseeTLE0bWyS3KbXKelaRmnN3qRbwe7m677fcBrb8uZS1EudsP9WXnzK8AwQwTup39bT0VyGpCkgvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USwzNjsJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722337501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S79Mm994sEW4BvAIyVoQYJTT5VMn2Pbd/zrnW1wpgO8=;
	b=USwzNjsJLdGelx3yJkIvuwvqjPaeuA3f0Assyu/6Uopfb0avcv35Q0lvmXzrkyMxqxg3kz
	gDmwOtInk7DZ9X+o37+TFgqS8WF5SpZutR7fps/+BF5AST7a5Q496wz06d7HZS2e0NIV9b
	5OOAE8YoKg6cVwK5YjZWymvNYZtaU7w=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-9_-tkAAIPZ-SvnIrPDnubQ-1; Tue, 30 Jul 2024 07:04:59 -0400
X-MC-Unique: 9_-tkAAIPZ-SvnIrPDnubQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-664bc570740so55210477b3.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 04:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337499; x=1722942299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S79Mm994sEW4BvAIyVoQYJTT5VMn2Pbd/zrnW1wpgO8=;
        b=BbxS0hdh6fAFe7nJ4yHR8SA6V+AXP6nYH9BzaJDuWC0WuM1ESAYIGcrAW09AEolnmv
         OxrIG6yWMVGtZct3JsorB0UG5H073U2wxQvyibXmdcF7qcO0PAVji19mFb2CsPdPtcoB
         F81QCHvElzBT3sgQIHIZqRXNAqbVeisTosBfgqwf2/7sZIOqaSFNc3NAZoHUvPqGFZCl
         dNcuDaW9WP2XXj2pMhYrdexk4dkBvRs4UM0SldrdrsOEJgXq0PFujv6VNGsJxyFCc3x3
         BkGTB3AGFYLRQskXZwJC99MTjG9Kr027g39Xx6yooZcSO1yhsIemWM6rnP+oFgk4khsn
         3mhg==
X-Gm-Message-State: AOJu0YxhM95OtYlzxhegiEoBw6WZIJGgI3HG4BBb1fE/vZh2mm777TLM
	po1ZRTXWzVhvkBSkCpYVkghiZk41MV0U5G9dxyfyWJBpEUPcMyumesUT/7qbw0kbQ4+WvEMJt5q
	JOrsP5mhzGpbuk9bTByWFPhKSvRXMQbyw956Uy816UyxULWXnj273MsBRBm0x8iHagNnztvKdjE
	CW0quy6tUNsUOKK50aGz0H1irCpRVY
X-Received: by 2002:a0d:fec4:0:b0:65f:cdb7:46a7 with SMTP id 00721157ae682-6826d4349a5mr14880047b3.22.1722337499247;
        Tue, 30 Jul 2024 04:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvq5rMoFu9LqacC+P0Kfq2pQmfz3t1RdLZrFXLSzkvnEneXakdi1b8mE4ArvawUUBUj04oZUqGLTJf0qaz+K4=
X-Received: by 2002:a0d:fec4:0:b0:65f:cdb7:46a7 with SMTP id
 00721157ae682-6826d4349a5mr14879897b3.22.1722337498953; Tue, 30 Jul 2024
 04:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240729124755.35719-1-hengqi@linux.alibaba.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 30 Jul 2024 13:04:23 +0200
Message-ID: <CAJaqyWd+euHy1S_eaxTEY3v9QmAH6pCSG=CnRiZJuNE07=mMTw@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:48=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> From the virtio spec:
>
>         The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>         feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>         and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
>
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq re=
size")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..eb115e807882 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device =
*dev,
>         u32 rx_pending, tx_pending;
>         struct receive_queue *rq;
>         struct send_queue *sq;
> +       u32 pkts, usecs;
>         int i, err;
>
>         if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> @@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>                          * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET c=
ommand, or, if the driver
>                          * did not set any TX coalescing parameters, to 0=
.
>                          */
> -                       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> -                                                              vi->intr_c=
oal_tx.max_usecs,
> -                                                              vi->intr_c=
oal_tx.max_packets);
> -                       if (err)
> -                               return err;
> +                       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_=
NOTF_COAL)) {
> +                               usecs =3D vi->intr_coal_tx.max_usecs;
> +                               pkts =3D vi->intr_coal_tx.max_packets;
> +                               err =3D virtnet_send_tx_ctrl_coal_vq_cmd(=
vi, i, usecs, pkts);
> +                               if (err)
> +                                       return err;
> +                       }
>                 }
>
>                 if (ring->rx_pending !=3D rx_pending) {
> @@ -3753,13 +3756,15 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>                                 return err;
>
>                         /* The reason is same as the transmit virtqueue r=
eset */
> -                       mutex_lock(&vi->rq[i].dim_lock);
> -                       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> -                                                              vi->intr_c=
oal_rx.max_usecs,
> -                                                              vi->intr_c=
oal_rx.max_packets);
> -                       mutex_unlock(&vi->rq[i].dim_lock);
> -                       if (err)
> -                               return err;
> +                       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_=
NOTF_COAL)) {
> +                               usecs =3D vi->intr_coal_rx.max_usecs;
> +                               pkts =3D vi->intr_coal_rx.max_packets;
> +                               mutex_lock(&vi->rq[i].dim_lock);
> +                               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(=
vi, i, usecs, pkts);
> +                               mutex_unlock(&vi->rq[i].dim_lock);
> +                               if (err)
> +                                       return err;
> +                       }
>                 }
>         }
>
> --
> 2.32.0.3.g01195cf9f
>


