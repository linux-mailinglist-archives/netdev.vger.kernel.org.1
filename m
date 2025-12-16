Return-Path: <netdev+bounces-244887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19207CC0DE4
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06E383004A57
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8AE32F74E;
	Tue, 16 Dec 2025 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da9F/POK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mti4RPMp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8E32D45C
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858639; cv=none; b=KIdI50SRhkbK5SXQE7Kx6wgm3jrYxyT4DMtbh0SfQ51Xmi4l+mtQJFCjh9n7G9Oqa2uywU/Dy+2rTdqVkyz8i3ddPt3US38tCecbmrBw9v0Qg4/1PK4B6S0nNishEI6KCWJxPUYucMRwucmQ5BurOzBo7CB8dYkDKJsxE8EoQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858639; c=relaxed/simple;
	bh=NVogfeqIDzm0ZVcmf3i8W8lCuvj7tXdcAP3yVfM4Au0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4lr4uvByiVZxBUMRaUExS8M09W4ks+yI7LKsBaELopbvEdNQvqlFG+rUqlbUZTnBmfXkOSSaYD/j/Eo877uWO6U7eCgUMqGo8RqG+1Crt5tKhzeSc5HhAiRRhEMyCIFVkM9R2qauVH0sZebs1VvUpcuOP+40Zvd/AiUvbRUI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=da9F/POK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mti4RPMp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765858619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/7C6iWC38arx7WP7XqqTHBbFfRoe8KEuJM7pBpU1is=;
	b=da9F/POKB8Wp8E6IlcyBNekSgFhKKjNeFwZSzat5sn3TQmw4U72G2qNqvVUj6R93udd8ku
	fHLQ4zqk6KvcrEqkIeAPZpf9Kj+jG6jwcxq9oCXIQBqELXFfwUdNH1HkY7b7UDx+Xzodjw
	+9XyIztOmW8yKH6MWjbwfQ4qdnFZAlA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-xe3UEExJN9-mb0lOzI_vfg-1; Mon, 15 Dec 2025 23:16:58 -0500
X-MC-Unique: xe3UEExJN9-mb0lOzI_vfg-1
X-Mimecast-MFC-AGG-ID: xe3UEExJN9-mb0lOzI_vfg_1765858617
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0d058fc56so28998735ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 20:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765858617; x=1766463417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/7C6iWC38arx7WP7XqqTHBbFfRoe8KEuJM7pBpU1is=;
        b=mti4RPMpfrFo8bVqd/5d5EFdvIhIKst4F1TermYAmSmi6LgaA33DHOl0XEG6K/HqBK
         Kbsqgyb7L26DqjVuJPMANiXNRc+g6G77/ZxilimNMv8cNuZoqH27tHDC0e90Ksm06oko
         GJsX3pMStRM6idVsvs15Z0EtPj+AZNCuUUJn1AE4/zMR7urQmCBTAU7vWaVttr5C8WRs
         whNlk48YA0XyoCbxiLvJTyMYn+9Xc1hD9pRQ50I0iNLPix7Jn2nRlHIhnpnq8r61Ee/j
         0sWUc9oscetWAznjAphWeAlP3QvFemZOh3lI9Fry1t5pjClH4jloKRzNn8jRQfTiL2Qi
         pfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765858617; x=1766463417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/7C6iWC38arx7WP7XqqTHBbFfRoe8KEuJM7pBpU1is=;
        b=ovZlalpk/cpgH8wsKdyjYX2n92nN0AenKxkWOaLcu9n5liFdzcX/DmGrAnJMxiw6dU
         nmqVvhvtwTEJBQf4yiW7iJor3mUi9IHoD9mR9ls+rado15TfqWofFT54MjjFELqTiNzc
         syPKPWglqgJSS8/JUP0eiFpc9KHXvhu39aZnvZ3LG/FjUXdHe3BUKiZjnS4xsEW0ZCWf
         7iYMKcTaHtig0878U7ZCax09uq1510XiGp7sAGbQBVGiq6NmV50zyameeudi1UXtyuoJ
         N5BJMtuybYW6++rDalb4dGaEw2pKvNJUumnu/ZjEPsTbGNkclrTZMWoT9NMTGZNPkQ72
         Ga3w==
X-Gm-Message-State: AOJu0YxvK71/zG5urZc5YJ58a5j/uavlEBXei0TWvOP8hwUFGgIlM/M2
	9KzIp+SPDBCqE2urNEWN3ckzlFO4cG7+IXYV5iVKF6rlhT+z8yux1E+dnZJZYIdy9GYToKgBO0P
	h50K2q+Crl5JSR7QURVZm097i0kTHcM1QQ2yRgRP3RcOSu/AbW7VjoHvlWsKf+1j0/DuGkDlL2D
	un7rWBQQN+u+wYWXhwpviNMraosxIZd3uFJFuuONv7r/Q=
X-Gm-Gg: AY/fxX44al01usiigVjAQ/m+AnN3q5Yj56GtWpDBXuQcvAeJhoGSZ5kVO8+/x31Q1uh
	t8deRrZnAhZJRZu7Y5VpFJL3f4GilApJzrYIq2lyTi3Q2nFvR08N9wReXnRvQN5K+TZUb4b/Abt
	RroZCyqkqzSCMF2TBYLWPBnLbQ/5wlvHs/WjAe9lYBejhK2xkoziiGWHndxGVfPsrz0w==
X-Received: by 2002:a17:903:40c5:b0:29e:990f:26fc with SMTP id d9443c01a7336-29f24151a49mr118996665ad.34.1765858616882;
        Mon, 15 Dec 2025 20:16:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBqYHoSd5RnxXGboawatvoaucHngeAk1hvIj3fRwgwVvh9tkLlDG8X5JjDrNhZMlvI0/FkZ6YshQlWBMxRoq8=
X-Received: by 2002:a17:903:40c5:b0:29e:990f:26fc with SMTP id
 d9443c01a7336-29f24151a49mr118996395ad.34.1765858616395; Mon, 15 Dec 2025
 20:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
In-Reply-To: <20251212152741.11656-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Dec 2025 12:16:43 +0800
X-Gm-Features: AQt7F2rLgj9mBy_vlMKMnQnGh9qrrbw_X7JiGf_a-Ty6nGioYVq51ByvbdTH2jw
Message-ID: <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:28=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
>
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
>
> This fixes the deadlock by ensuring all receive queue's napis are
> enabled before we enable the delayed refill work in
> virtnet_rx_resume_all() and virtnet_open().
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results=
/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v2:
> - Move try_fill_recv() before rx napi_enable()
> - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhq=
uangbui99@gmail.com/
> ---
>  drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..4e08880a9467 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtne=
t_info *vi)
>  static int virtnet_open(struct net_device *dev)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> +       bool schedule_refill =3D false;
>         int i, err;
>
> -       enable_delayed_refill(vi);
> -
> +       /* - We must call try_fill_recv before enabling napi of the same =
receive
> +        * queue so that it doesn't race with the call in virtnet_receive=
.
> +        * - We must enable and schedule delayed refill work only when we=
 have
> +        * enabled all the receive queue's napi. Otherwise, in refill_wor=
k, we
> +        * have a deadlock when calling napi_disable on an already disabl=
ed
> +        * napi.
> +        */
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 if (i < vi->curr_queue_pairs)
>                         /* Make sure we have some buffers: if oom use wq.=
 */
>                         if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                               schedule_delayed_work(&vi->refill, 0);
> +                               schedule_refill =3D true;
>
>                 err =3D virtnet_enable_queue_pair(vi, i);
>                 if (err < 0)
>                         goto err_enable_qp;
>         }

So NAPI could be scheduled and it may want to refill but since refill
is not enabled, there would be no refill work.

Is this a problem?


>
> +       enable_delayed_refill(vi);
> +       if (schedule_refill)
> +               schedule_delayed_work(&vi->refill, 0);
> +
>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>                 if (vi->status & VIRTIO_NET_S_LINK_UP)
>                         netif_carrier_on(vi->dev);
> @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info =
*vi, struct receive_queue *rq)
>         __virtnet_rx_pause(vi, rq);
>  }
>

Thanks


