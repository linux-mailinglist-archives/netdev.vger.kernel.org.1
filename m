Return-Path: <netdev+bounces-223901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A23B7C4CD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49342465B02
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748A305E32;
	Wed, 17 Sep 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoKeeMTK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0E306B1E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096964; cv=none; b=IRvoOK447rC8noaCn8Ml/mSThjdMznMhcTMVdUPhvpkJuU3C0wxV7EpgXltpyWMakVMpNSEG1P4Oe+Ly+gEpbwNgK8FnjYBgJJkTw35sCNwhL+Mss8bqkSBdI0LbFG3h6tt0XIrzKkyIsbPcnTKAokjLbCIYQwMiyIC1d3HrjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096964; c=relaxed/simple;
	bh=DZJjEilvh8soI1BKTSfA4Ey5iDL2dw9rLc+r+sxOjtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE1TjKJEErvoIaYtT3O7+tYnePlZgPEdttQ6xcr8V9YMIsZQ9eZ5WJIy7sCjkuJ211vGCv/wNPS/A3+bjvzmXWDDb6zh6OmrpSgTr7IEPeCSyWA3SYUECPpsbfigDYCckJ+l/DMWtqsV3KVqXPHey2G31yfpyRn726J6D7/bEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoKeeMTK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758096961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eedUNpaU5+NqwyQ8eXKTY11TfX3TYBW7jRyqO48Q8K4=;
	b=XoKeeMTKu0gpgfJHuLWswxJAGqCjjKpuINRBQraqSY9q8vgpNcBVtjXiFhSYkG8W4YN65/
	4No2q9FHPyuJunUXhi+DU1IrMASJ8MZbKZ05kGdhWhR4jesmx7GqtO92rXF0vz9CIUef5g
	2e0YdnswDRE6uKV5HwS3Q7hKbtluozk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-bYKE44zHOju7ZwDaET6MTA-1; Wed, 17 Sep 2025 04:16:00 -0400
X-MC-Unique: bYKE44zHOju7ZwDaET6MTA-1
X-Mimecast-MFC-AGG-ID: bYKE44zHOju7ZwDaET6MTA_1758096960
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7216c46b069so66626427b3.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096960; x=1758701760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eedUNpaU5+NqwyQ8eXKTY11TfX3TYBW7jRyqO48Q8K4=;
        b=kOle6t4BHpKM547gQgmYu6pT5uRer9x8SZBEliCAxDBCoc0UTcppOxb0Kw5hguJVhM
         Q5uHJ4/nn2Pu4SXJQNlyyXImheU7bDSlERrHL+hLQ4MYFsK5aApF4En7YC99+PBBSqTy
         I+d/AoEc9VYeenPWyaC8w6IDnO8bK6dR0EvKnPOhdORhLD7suhEZVdSQk8wX2rg/lk37
         zKxsw20rIL2LBJKc5oVibsk7GohGpgVKuxL5631xMCVFiG0N4GP0E0r1N5XbXudo1FsC
         DrMQYidLnCcfXLE1hhznHPzbBegNpoP/nqQZmDcIJ4UeUNi+pU+MEJgGX7kZC4Y4q5YX
         K68w==
X-Forwarded-Encrypted: i=1; AJvYcCXiX7ndV/2Q/jdutgMjMpW6gYyeKdKLAdOM8sChFzH2NEODXJNy6OcNe66aGv44qtyPx/I89ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/e6NoXgQ2TFLBUmFzzAEBfPGoOsQ3RvUlHP7xWrXL8WfU41u
	QSTUQ4qn1m+YMpSH/HSYQTLoENCT984LoWpok+gFL6ZEsYwVD9GsLb3gJ2AqNyltg7oOs9URML/
	bjbtdQspj7NVoUiRgPccIiZviYWgoTepQXjH8JTMc8nIof/qCHq5nptWqbHd5+nyHMXCNgBomXA
	VlAi81iGHn1Y5nJ3MOZqA/nc1TcWcODyu0
X-Gm-Gg: ASbGncua2EpVt1KDcXcDyYrBBX7vpxyYfExiW2GFbU1r1i8CVofYogyuOU7p7s3FZqB
	Wh7NnPuboI120C9ox0dWrLRQzIwSvhEbalKWHTDwSW/Qm9274bkjvKiPAYcPSKwKbRz4FWGj600
	2hm2WlpBxNMwpUNY8ZwH13/nhEM2+zWllbE+1NvkHaVajrwcoP+Apl5Z1PF0uBo8K72IZC2xASl
	oimAlZY
X-Received: by 2002:a05:690c:6c86:b0:723:b37b:f75f with SMTP id 00721157ae682-73891b87784mr10853857b3.26.1758096959689;
        Wed, 17 Sep 2025 01:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyEE0NjY/G5cvHcAfaFUYZLAJa4QZLLCvZPWadjWH10jQVSkAeb7QCxJDkVvvAIV4aZoNVgVWuy6Xs42oRk5I=
X-Received: by 2002:a05:690c:6c86:b0:723:b37b:f75f with SMTP id
 00721157ae682-73891b87784mr10853617b3.26.1758096959304; Wed, 17 Sep 2025
 01:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:15:22 +0200
X-Gm-Features: AS18NWDDF_GZcJeZupVOj5tO-bkVG3qVNzTBHe2X19uvGqJmtk3QOixi1mHlzhU
Message-ID: <CAJaqyWdoLiXJ8Skgwp14Ov66WP1wjnJkR0wwUdmcziSAFJoxCA@mail.gmail.com>
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> of used elem to vhost_net_rx_peek_head_len() to make sure it can
> signal the used correctly before trying to do busy polling. But it
> forgets to clear the count, this would cause the count run out of sync
> with handle_rx() and break the busy polling.
>
> Fixing this by passing the pointer of the count and clearing it after
> the signaling the used.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Cc: stable@vger.kernel.org
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c6508fe0d5c8..16e39f3ab956 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue=
 *rvq, struct sock *sk)
>  }
>
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock=
 *sk,
> -                                     bool *busyloop_intr, unsigned int c=
ount)
> +                                     bool *busyloop_intr, unsigned int *=
count)
>  {
>         struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_VQ_RX];
>         struct vhost_net_virtqueue *tnvq =3D &net->vqs[VHOST_NET_VQ_TX];
> @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_=
net *net, struct sock *sk,
>
>         if (!len && rvq->busyloop_timeout) {
>                 /* Flush batched heads first */
> -               vhost_net_signal_used(rnvq, count);
> +               vhost_net_signal_used(rnvq, *count);
> +               *count =3D 0;
>                 /* Both tx vq and rx socket were polled here */
>                 vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>
> @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
>
>         do {
>                 sock_len =3D vhost_net_rx_peek_head_len(net, sock->sk,
> -                                                     &busyloop_intr, cou=
nt);
> +                                                     &busyloop_intr, &co=
unt);
>                 if (!sock_len)
>                         break;
>                 sock_len +=3D sock_hlen;
> --
> 2.34.1
>


