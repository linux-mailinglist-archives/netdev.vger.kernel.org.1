Return-Path: <netdev+bounces-223907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D5B7CE57
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 312AF4E24B9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051482F291D;
	Wed, 17 Sep 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYY/7VuB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084B2D59EF
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098132; cv=none; b=KPCQ/zcLGEGaAb1bk6bxadFT+f3/LYNu8500v/MPHXns5hmSAdlUp6yLyuZepuhytZcVZdRhV+svlmpdkY79BvLLvm+GVWWK+GjMP0jrNzl/fy5bmQka/pDeNrXeWGqSj4H7C4VAN8s8qDGMtrGuuKIwL+TAGn7XhqFsFT7ff6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098132; c=relaxed/simple;
	bh=q998US9DM6OvRET551aJFQGCAmTK69Gkhu3kFz33Lo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kS+zHfey5TcI/cjrLtUNsCL02tb/h89AXufeSF6SOQ4uU5d2vTPRX0iiFPq6EG+do+6MbyoCblnA/nUhxLVTngMwb4dML8K6NCLjbc2kP+5F+9kA0IrHAqIpymeUki1ZYwHNUs/149RjJPCOcyROpiZUckW9xl4KHJeuGw3QxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYY/7VuB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
	b=bYY/7VuBDQgVnIvBa68t7Czgxs0EY88Ub4ilLZj+2DbhGWJkIBgACQiX34rQDvQPEMNr+W
	pF3N6q1Ors9ZiIkG2hxipYAebcXvwbhUIn/bYJAsvvUR9NvnBq9ipRtt+Rv3WqK1DEBQZv
	7arakdAFanKnOvLfntGGy72a5tw2EQY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-h7M7uyvsN3-B4CO_rZsiBw-1; Wed, 17 Sep 2025 04:35:29 -0400
X-MC-Unique: h7M7uyvsN3-B4CO_rZsiBw-1
X-Mimecast-MFC-AGG-ID: h7M7uyvsN3-B4CO_rZsiBw_1758098128
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-72f7e04f805so60518287b3.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098128; x=1758702928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
        b=qgKyu9ix0yJ5Z7hnqmn30Hcx3ikNEOn2xfUumW11I9u2HNqDWM9WukcfCISzHQ2c+P
         v7yw3rw5ZaAFGzfP2yGWLSCjVP2xkNPgfl4MXGpbcPVhfYuwmVvXPvHYceVjan/KqtmH
         7giiz0eVQrUSWLdPeJIr1KfSKKkT2RjTQcEriF9p9Vokr0O6F0QW25LkmfJEKpMKUIdP
         X6LSo9LEUlpFyjf3rRw8pEC/sQ7ZhvjR37nBhn/MgVWE/y79jOzSeGF5iShrJtqSAkbn
         X0rYqOgEK0LQ1KOqvBx2IwYgo3OBYo8lNVK241kLjrK+pooibOhreug+7bLwMfThhuF0
         H/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpXOkuOlNhr0E/YepPtmKl6tAxHZ5afbE7Td8p3PApHWoPFbv51Zb+mWcZs1g+fyTopv2Bs6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfwcFBMgL7j/pZsV8CKMr2iDvzCoFvpr1GiB+JlcUdT52eMJn
	ogb2I9wawAWXwLX9TfA+0lHl5CUeWppUd18SRaOeY0avM+WC7Bcg3UESVo8a65USDZrEU/UH3rW
	8zWTO3lEvGFyaTC/wo3XHbhf5mWT+vLkMVykXQ9FoQsha9Zn+k5wYM9Fy//6N6yY/22B6WQj01F
	2PaVZQdrWrMJb4Q3o8T7lgrD41bod+tWix
X-Gm-Gg: ASbGncs8r9Zb4cdOtuxp+84ctzNzi24B4Jt5kDhWO68Js1HSxy+q8iLuPpBQQFbGckk
	h7NwQ9an1Hcujud9jZhrnGqWOx+ZBNjlDgAuRvta6ys/16YhrV7lmJ4M3XMaVLeq/L7B3L8u+e3
	szvjpjZ0WsVrS0Fa50oBBJs5IiqC3gjDheSi+gL3L4xrH+hmeIhzR8W21C9y3e8blex2Lf79rBC
	6WfNyRS
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id 00721157ae682-7389284e5e5mr9726497b3.37.1758098128455;
        Wed, 17 Sep 2025 01:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7WOF0rEFwoWJH/Fs+cwlNlhklNtr7tfG2XSvbAwX8kIp4ppyqh9Npvtpo12WegIqko71EKOuElGMUL7KcsA=
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id
 00721157ae682-7389284e5e5mr9726207b3.37.1758098127956; Wed, 17 Sep 2025
 01:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250917063045.2042-2-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:34:50 +0200
X-Gm-Features: AS18NWCp8aMeKQoIpGNO8gXB409fPKuCuu417M71iyj7YQxnhfTZ79uY8_vwglw
Message-ID: <CAJaqyWeWy9L322_-=MNno9JABegb+ByXEHmEyBsqXHUVTiBndg@mail.gmail.com>
Subject: Re: [PATCH vhost 2/3] Revert "vhost/net: Defer TX queue re-enable
 until after sendmsg"
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This reverts commit 8c2e6b26ffe243be1e78f5a4bfb1a857d6e6f6d6. It tries
> to defer the notification enabling by moving the logic out of the loop
> after the vhost_tx_batch() when nothing new is spotted. This will
> bring side effects as the new logic would be reused for several other
> error conditions.
>
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and
> trigger the TX watchdog in the guest as reported in
> https://lkml.org/lkml/2025/9/10/1596.
>
> To fix, revert the change. A follow up patch will being the performance
> back in a safe way.
>
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sen=
dmsg")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..57efd5c55f89 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>         int err;
>         int sent_pkts =3D 0;
>         bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_MAX);
> -       bool busyloop_intr;
>         bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>
>         do {
> -               busyloop_intr =3D false;
> +               bool busyloop_intr =3D false;
> +
>                 if (nvq->done_idx =3D=3D VHOST_NET_BATCH)
>                         vhost_tx_batch(net, nvq, sock, &msg);
>
> @@ -780,10 +780,13 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>                         break;
>                 /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
>                 if (head =3D=3D vq->num) {
> -                       /* Kicks are disabled at this point, break loop a=
nd
> -                        * process any remaining batched packets. Queue w=
ill
> -                        * be re-enabled afterwards.
> -                        */
> +                       if (unlikely(busyloop_intr)) {
> +                               vhost_poll_queue(&vq->poll);
> +                       } else if (unlikely(vhost_enable_notify(&net->dev=
,
> +                                                               vq))) {
> +                               vhost_disable_notify(&net->dev, vq);
> +                               continue;
> +                       }
>                         break;
>                 }
>
> @@ -839,22 +842,7 @@ static void handle_tx_copy(struct vhost_net *net, st=
ruct socket *sock)
>                 ++nvq->done_idx;
>         } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)=
));
>
> -       /* Kicks are still disabled, dispatch any remaining batched msgs.=
 */
>         vhost_tx_batch(net, nvq, sock, &msg);
> -
> -       if (unlikely(busyloop_intr))
> -               /* If interrupted while doing busy polling, requeue the
> -                * handler to be fair handle_rx as well as other tasks
> -                * waiting on cpu.
> -                */
> -               vhost_poll_queue(&vq->poll);
> -       else
> -               /* All of our work has been completed; however, before
> -                * leaving the TX handler, do one last check for work,
> -                * and requeue handler if necessary. If there is no work,
> -                * queue will be reenabled.
> -                */
> -               vhost_net_busy_poll_try_queue(net, vq);
>  }
>
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *soc=
k)
> --
> 2.34.1
>


