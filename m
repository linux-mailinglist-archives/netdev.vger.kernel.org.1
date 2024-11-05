Return-Path: <netdev+bounces-141878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE99BC973
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E719F1F220CC
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42F1D095C;
	Tue,  5 Nov 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh7amOpD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF51CEE88
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799602; cv=none; b=Nqzel3JW9U8XGp08qyMFBwoJ60EXevDZolW2N2aOI9tKqGEPasfmEOaEVkq9IuaiT8x77qmlKgW1q7VxBTjMH8oKQA7cu4fPWxXqr6ZpFdUtgliymJLaOhUACkQksDnmekt60MpzI7xL68ImxEv47Cka5IgZYmGs+Y58UQk8ypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799602; c=relaxed/simple;
	bh=zbV55dwHjJ2kbTTg3MViuRzCwoRMxpq1N/C5N+zK6zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9iYdCncYZleF+a950MHTAaVduPCnYkKhSzoumju9IjLu2xKX4tW0M1psIzRl7JqAFEq49bf2/1gEU0xODxJIEKeaOADiz/W+68XUNQOt2cCneskNrAs+aVe/SsELz26dXETDT6nTX/RREkZupL+HWe10hT3EJCk+cpPYUHsYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fh7amOpD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRwsPPiBOKl8pP2TdmsQrIwR4zMRwzINJIydDBGwl0M=;
	b=Fh7amOpDm4hiVNHB0UFY7bJrvHiztk93bKXPOZKFVVeijMAO1zv6TY62AaeKKsGg4i+oC/
	VNizlOdiT6ktwMB32sU2S45m7qaDXpiukosRaIIlY/EDea63F/ADM8rnHVpdMwPqZ34CO1
	WF7hJl2/IAsh2noKtgJsyzYbu3Sm4PY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-bmTlHQ9uPfiY3S-qTF4WSA-1; Tue, 05 Nov 2024 04:39:57 -0500
X-MC-Unique: bmTlHQ9uPfiY3S-qTF4WSA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e2ffb47515so6810489a91.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799596; x=1731404396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRwsPPiBOKl8pP2TdmsQrIwR4zMRwzINJIydDBGwl0M=;
        b=QwbfaG8cBiFQk3PBnLxTfoqijjfNNIhHPW5gXVfwScNAkTyvDam5JzxfS0puaKx7g4
         qLRE9uvFOUnoVwL5B70JKiSbCyAeoxuQJtG15hWv5FNxP7E8M0Nvw/+kN0+TpTShJ954
         W/aHxl5genVnS+N2ObOaUaVuAM57xu4DzvCkhvqG++EUOXgnlKMWpJUM62MR4z0jCqAM
         OhznGy/l6Sp/fQmW8bbBCJeDoqlh3MydNC7SwTVLxAoTjtRoV8NvwRH7VYsdp0XRfz6r
         wHjt1/3JiNFfYgquXxYaymSZ1OpbXoyz0G2g1DlQNj6szo+QOETqzZCg9wZiJbgXX83q
         ecZg==
X-Forwarded-Encrypted: i=1; AJvYcCXqugnsoa/SZMgXvAFW1a6jO4HmO5o+VbytwfxuyrQ1MbNzbIGxHK7P8lq+EHhp6qDeJXs0iAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+aY9bZyyPApDeRFyYhNFNvKDmx00V/ARQT0q264yvQcH2NDC
	85U0lo1Dl6JDv/MCy5L2u4CemFEuis6MXGGPMoHALVJCsFzeSk+JW2m3rHmtUfesrR+74+VeFpy
	+J4GO4bMOyxwxCeSnDAysCU2iPyqOuHW/F/Xp8bEgabqzRxQgk8olW9pYZqTczP0AjITmHExJ9/
	hlkAuf9kYhpIkbsnBfYE/t1O01h3uG
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id 98e67ed59e1d1-2e93c1239b8mr24582872a91.3.1730799596554;
        Tue, 05 Nov 2024 01:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkWs7EprrlFH5lqTZLM7dQHu2gPsz4loSVUjvX2t1vhkBm4E6upLHhA0nfNQI6ZN+O5cxUBaSpekre3l5wCV0=
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id
 98e67ed59e1d1-2e93c1239b8mr24582850a91.3.1730799596044; Tue, 05 Nov 2024
 01:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-8-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:39:44 +0800
Message-ID: <CACGkMEuEyXC7pOfwUTKSSrc-vrGW-v7SucV0qAHDE5Lo-b7zYA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 15 ++++++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c17dc01febcc..70c793b63905 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       bool inherit_owner;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
> @@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>                 if (ctx)
>                         eventfd_ctx_put(ctx);
>                 break;
> +       case VHOST_SET_INHERIT_FROM_OWNER:
> +               /*inherit_owner can only be modified before owner is set*=
/
> +               if (vhost_dev_has_owner(d))
> +                       break;
> +
> +               if (copy_from_user(&inherit_owner, argp,
> +                                  sizeof(inherit_owner))) {
> +                       r =3D -EFAULT;
> +                       break;
> +               }
> +               d->inherit_owner =3D inherit_owner;
> +               break;

Is there any case that we need to switch from owner back to kthread?
If not I would choose a more simplified API that is just
VHOST_INHERIT_OWNER.

>         default:
>                 r =3D -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
>  #endif
> --
> 2.45.0

Thanks

>


