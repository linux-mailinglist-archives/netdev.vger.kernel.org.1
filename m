Return-Path: <netdev+bounces-194856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB1ACD0B5
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 02:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7897160CF7
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D614286;
	Wed,  4 Jun 2025 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeyVi1Bx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328C79F5
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997455; cv=none; b=CxMgHIZA66ews4yFXw4MErW3MW6Fx39YkIPXUwXin1JwT0GzktxK1QboJzODPJ/GsUhXik95WzfM37Wf52tz6H+uFZzPGV5l4+dQTZrHPxg2/Xnu/TzkXNF/cVWpoB9O75MQ1dvm6csI6HoEH1v8AH0yVnzGHzasevDWREZFz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997455; c=relaxed/simple;
	bh=FIhhwRMnEvPjuGUpf9qf+tqZDLEP9lZKLjQ3YYZd4as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edhciX6Umtlko9iq8CnWGR9HZ1WbCkB9ue51aSqP71f2alke5qJiL3agwBNeAdTRmaoMisRzbFfc9g/AYjEOqDUdawFzKmV8yGA3g41H6kuGmqvxdJfpm+6uHdsRO92gPHYmdTHYcjVaNUGrottWU2UzJyC0WUaizwQxD/ARHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeyVi1Bx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748997452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
	b=IeyVi1BxRcWuhlZAvHSmxFJmdP5hBXqbCxwsPS8J0plqYgBA+U7TgZcdGD+Yd+vWoWudlP
	Ha1TejpBZ8g1yBzqaku97nhAzVHc4LesjiZ8bxSKx31UrgukMPrkIxpKs9AyFROtcaZgER
	HZkzUR99jlSltGRmTPxIpJWFdzj2NzA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Tvg01p9QOAeRpuhC5zmxcQ-1; Tue, 03 Jun 2025 20:37:30 -0400
X-MC-Unique: Tvg01p9QOAeRpuhC5zmxcQ-1
X-Mimecast-MFC-AGG-ID: Tvg01p9QOAeRpuhC5zmxcQ_1748997450
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311b6d25163so5661836a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 17:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748997449; x=1749602249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
        b=EJ3KxP3gu3nrK5rPraNBwIuBN6LntGfL5/pfvSHEH21CP29T72c0JaHPE39108B0p2
         FfhOgmZt2ciQOeyZQbfsgQbRDrvtYaIFS72V5r2MiINEzNI9lpNOaZWdmRsIMj9vG7MD
         F9gguUGRtIBbwHjRgbGTFr4nrZf6BxuCURo0CZOCCJShv8/kr0r39vic0VIOKr+IKki/
         cOtjoFHmJs5gPRjowD6IKVaQDfaBqJyDPsP7mGnB6cV1QUQ7HOidfh6ONiE6y48u0Mua
         dkQEbkWsfh1ARza6l0kJthPoCmH0vR60pnYDecnV/QpGcrwYiFtwM8eVer6FWhAdzzU2
         Yggw==
X-Gm-Message-State: AOJu0YzALZEtsiRdk2Rt9b2DAagv1WsgJ3OFl+1JeBauRqV8g3oWrsZ8
	4DwmJNVO2CgR6hpTK5K9qmxCIpjtuLjHphR6k6XVEFml3V7sG+kDlNCrkt4xdW6cawuff7+O/9w
	rcAEZ1dpwLMSe7l+tBboVenZhk06JOdqutQxZOLWXpcF0tOlLF7WQ829tHIHgE0Uh0IAo0iIUxf
	P39pOsEwlzKWA6MNlYcByzUs7fA/CSusvDAh/jmbY2MpU=
X-Gm-Gg: ASbGncuXsKVAg8tikFmrxT5O1UbgvcL2UQ0hgU9L/KJY5wNfKsvTXqM0OtgzBYSs/qG
	sXs1KLa1D+/jhjws7jmhcGMkHV5SAj4vmm0PfGomfQ9KeGvXbnCPzdntv0I46ui38xRbTmw==
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id 98e67ed59e1d1-3130cd65aaemr1426536a91.27.1748997449158;
        Tue, 03 Jun 2025 17:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQeODWbQfUbRlPw0j1gKXQJysD64GEXXnB2RuYnjq0y+PzQoFeIG5PN3PQdqbkgUndiDNUyG9oiwKSrJbbewE=
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id
 98e67ed59e1d1-3130cd65aaemr1426509a91.27.1748997448759; Tue, 03 Jun 2025
 17:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jun 2025 08:37:16 +0800
X-Gm-Features: AX0GCFt_tMiNdtyDIBlXvuQJILPten36fjn0u2OKQnhU-6uwjA7mU6t1xM2SrDY
Message-ID: <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 11:07=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. This commit instead returns
> XDP_DROP in that case.
>
> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..4c35324d6e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(s=
truct net_device *dev, struct
>         ret =3D XDP_PASS;

It would be simpler to just assign XDP_DROP here?

Or if you wish to stick to the way, we can simply remove this assignment.

>         rcu_read_lock();
>         prog =3D rcu_dereference(rq->xdp_prog);
> -       /* TODO: support multi buffer. */
> -       if (prog && num_buf =3D=3D 1)
> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);
> +       if (prog) {
> +               /* TODO: support multi buffer. */
> +               if (num_buf =3D=3D 1)
> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_x=
mit,
> +                                                 stats);
> +               else
> +                       ret =3D XDP_DROP;
> +       }
>         rcu_read_unlock();
>
>         switch (ret) {
> --
> 2.43.0
>

Thanks


