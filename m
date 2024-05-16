Return-Path: <netdev+bounces-96735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2998C77CF
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B247F1C2178A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD81474B4;
	Thu, 16 May 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbQzUSOQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B629CEA
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866704; cv=none; b=MIQWHJbMmHZRO3XBWaVGujrrwYdC3FRz/udO2XvDEH/33OoM521wkkpdhYlaff0anvNNY+vqPO6AcYw4xYWBUfbVPMl8kvHg7QKjXHDVZurkKXymF3WoBXA3Soprv2eIRNy2quJ6Yc0X1Rm/NrttmzQxOdJHkDfXFzGIbfXbYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866704; c=relaxed/simple;
	bh=H4uJfIWjhvWKU9/lF6/ReCaGNL4KXA9cAwJNwXPUNXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jENUV222BgPTDkhbT35OaJSwmEHAXAPHyWYYr+1CPqnQes3Qym+KqmjlXI2bbOMf2sFyUdHraJn8KwusWkPgDDy9qpLhkjjwcCGpd0V2W0UxfQxTJPXeSxTtHaO2QJrbvnpxOMLLmtixDm2TOAq5TtFemwAtvsWUc8KB/c5AJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbQzUSOQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715866701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MotCgp3e2fj15EogMUNC34bh/DK0Sdeid+nwujT2pQ=;
	b=CbQzUSOQyoklWKj2KBBe8p70Kcp2WX4WZQL7BApCgQwD5x5kfpvBmzU2uWTIqlH0avP14t
	83qNcPcrzBqnB+Maf+Dp4IYHf6FTf4AdrdPLz79DpGgPTFLnUMXx25ZqEfn4ZJYxxD0I+K
	KaRmDKcfDHlyoxZJwxyxlcdAKhDuo/I=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-G5cAuapxNs66FnO49iqh0w-1; Thu, 16 May 2024 09:38:20 -0400
X-MC-Unique: G5cAuapxNs66FnO49iqh0w-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-61b028ae5easo118154737b3.3
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866699; x=1716471499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MotCgp3e2fj15EogMUNC34bh/DK0Sdeid+nwujT2pQ=;
        b=Wizp7jngXD19VOemRPZSlVYzkFGm7mWPuQLdoMFzkVuAXXzsk0fMCgTadcJ3VKPEMI
         8kkxiUXIRDczp12CYmgGQrBY1djEK9D8pIjnSAFSb1DC57pE8OLpoWNCbR+EgU5SzFZs
         0Q+NOi2+vs1zb/8ElIKlf9qotq6tQ2Qk2rqRNK3j8Kgx8SqkQ67nJfxrzrV73K45pRSa
         nB26Sc4BOGRFbeDheBLwm+V1yUTPC6Qbe7eaDoTkYDHz0+bD/PmzaQinqmBwOzGT2AMZ
         0lBMqypnfQNnaoblY2zEgOhuqojGtcMwvw/8i76eXq2NR0k25ob2bjV1blk58C3hLsyI
         kOVA==
X-Forwarded-Encrypted: i=1; AJvYcCWgrhRVRCdHJhzEIhy1wthQCEsyXiPrDcS97mLMuG6gUdcepDCvWN4UVM9JiL7K919FAfPwELnsnNiVgQZ6JwmzPKG8TowB
X-Gm-Message-State: AOJu0YyF0zVVvDXm/crh5LFjACnoJ3Yfi4MqhR+WV3zscl9igVomQiOT
	ruWoWsiOYhU2tWJgFP84XbUBea1SGUT8HT8MCft8vghwMVYMB2XNJvL6yJaX18m2CGYULeuM0j4
	Ja37ifXYcaSBY/5esT1l/IA2uVUeFF2XQj6QZtEPf85eOGjRooigWGHBKo2ur0KpTfQ/kcoBGYY
	ZU5WaMQXKPEQdNaziPM2u9fwP/dVsy
X-Received: by 2002:a05:690c:b9d:b0:615:8c1:d7ec with SMTP id 00721157ae682-622b00218ccmr188220067b3.33.1715866699389;
        Thu, 16 May 2024 06:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4QKAuxEG0E9OIW18GgVRzmoNCx6cWbvCv+mq9BFFlhSCQTKIOOTMs34WnZPrmXQWnkLEbeQ4BQeEoXduizoU=
X-Received: by 2002:a05:690c:b9d:b0:615:8c1:d7ec with SMTP id
 00721157ae682-622b00218ccmr188219907b3.33.1715866699113; Thu, 16 May 2024
 06:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 May 2024 15:37:42 +0200
Message-ID: <CAJaqyWd9-fhrxBv3gTq82bGnSVdC_vw_LXg+XVNHT3B6cD0VOg@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	Jeongjun Park <aha310510@gmail.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>, 
	"David S . Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 5:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> There are two issues around seqpacket_allow:
> 1. seqpacket_allow is not initialized when socket is
>    created. Thus if features are never set, it will be
>    read uninitialized.
> 2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>    then seqpacket_allow will not be cleared appropriately
>    (existing apps I know about don't usually do this but
>     it's legal and there's no way to be sure no one relies
>     on this).
>
> To fix:
>         - initialize seqpacket_allow after allocation
>         - set it unconditionally in set_features
>
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> Reported-by: Jeongjun Park <aha310510@gmail.com>
> Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
> Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>
>
> Reposting now it's been tested.
>
>  drivers/vhost/vsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ec20ecff85c7..bf664ec9341b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -667,6 +667,7 @@ static int vhost_vsock_dev_open(struct inode *inode, =
struct file *file)
>         }
>
>         vsock->guest_cid =3D 0; /* no CID assigned yet */
> +       vsock->seqpacket_allow =3D false;
>
>         atomic_set(&vsock->queued_replies, 0);
>
> @@ -810,8 +811,7 @@ static int vhost_vsock_set_features(struct vhost_vsoc=
k *vsock, u64 features)
>                         goto err;
>         }
>
> -       if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
> -               vsock->seqpacket_allow =3D true;
> +       vsock->seqpacket_allow =3D features & (1ULL << VIRTIO_VSOCK_F_SEQ=
PACKET);
>
>         for (i =3D 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>                 vq =3D &vsock->vqs[i];
> --
> MST
>


