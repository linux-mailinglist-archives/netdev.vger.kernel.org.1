Return-Path: <netdev+bounces-184331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65524A94BBD
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22013188EA7E
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D492571AA;
	Mon, 21 Apr 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYAgiJzn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457B5FDA7
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745207155; cv=none; b=CN1jC7LcW3HG9n7Iwd8DH0oBNXnsIYzQpaPIuv5w38Y8fQMhkh3VzjmVB/ZfLlvO5V3ZpHnMdws6ujCGC9nIlSCoxOjTq4PqjQEXaaokzEcH/bbQxFO3hJ0JtqCpGHZuWtnywjewAinxq7VemcTBJyizd3MVAuekhURuLMsAkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745207155; c=relaxed/simple;
	bh=KNP4l2yPMw2FLp/XhZlTQQJKvOxgUeTNWGn0vwmpkpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNy3WPxpZAfT+BuJ64LP2qJraMTlOXUCDXFDPME8W13Ssw+6N8da6MyOrkCJB4j0xBG2HB0OvEQfCUTVsIVyPLPe4azwcGFJ7bfXpRFeA306O0yIhzXEAl1omkDdUcdv21nRs3fi4FFh0PhPYFzKQUiBkkYMnmkUJPU19PpBAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYAgiJzn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745207152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCTn28hDkTI90JLQ1WUbwuCZY09MgQ9MgcwPXgLFgGw=;
	b=ZYAgiJznyHX/YzCNmKjiAr3DhT3T3hIzxtAPBNUJFm/IUi89eCINfbXnf1JhbwtKiLttLu
	0Ye+FNdBWnTYxXSpCigq4gelTCHRn1P3PTBtjDQoxaQcWbvjwtzGt8+Dk0ORpZM1TKqSUO
	McVudVBU2rIj184FYMRFdF6BrN0JJ0M=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-aRUxGiJzM8GK9YaXNw15Bg-1; Sun, 20 Apr 2025 23:45:51 -0400
X-MC-Unique: aRUxGiJzM8GK9YaXNw15Bg-1
X-Mimecast-MFC-AGG-ID: aRUxGiJzM8GK9YaXNw15Bg_1745207151
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-523f15eb8ceso663630e0c.1
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 20:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745207149; x=1745811949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCTn28hDkTI90JLQ1WUbwuCZY09MgQ9MgcwPXgLFgGw=;
        b=CcNoQ5lXGGY+jAqyQsttrLNhHwr7i1hPi5Pfi+GFeYlUKq+6eqSwI78QXin0Hvdy9u
         c2r1fug0tj+iPWkahuM3hfWGteVX9Uh+Lx5gWzISOz6zlhysZ6REErjyqgkHkrP+d1qq
         VhNUCVyGZB7263jJFdv0Q2BkuWXIBZ2mZJ9zc6yIMqN/pMzmccmjNg6b8O4oYxL/HA5x
         8Q+5TTge0Cf0Qkwmz2Xoo2U35jkFc0KvOeo1Fh1599M9/ByryX8CfUkKJU+DNQHZosc7
         3guk/NGQzuh3QV5gnWMTjXVQI7Gq0QZHbxTk1JZ0ua4B1ePfa56o8k8fnIOVoT2DtqPR
         OG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxFWlVjMIk0bVnPF6ClKi/tKRmQeqZ9D7/8S6xsW025ISWaTIkzkv0P3RYrlYbWxD+Dbh1CVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9W5+//WomMfUntfDwAW2j2qC2xknzxK8QGV/4i7GAR6d7Anqu
	FEiq+pSJzYp1UVjHw8aWwvmygEvnKJI12Y6DzwTM06PCXnkP+TNd7wgi3NnkwllGlCkzTXjNGXg
	dBkU67d1t9JXnN2FXPb7eK42qlvPIKTjrq+UyYnDYov/hFroaxR62thgPuNHV+ak7rDX8iH7BEM
	bUBS90hw1vgrAoSYEWQq+YjIwg1r8xOiIjfIiohcQdZw==
X-Gm-Gg: ASbGncuzFuteLYFRrqkFOmwASpIo05XhT9jYkqPJkC+bcBIWav1O+S9IqD0v319BfMD
	a4ZJQnal3z4uexyxnJ8YvrWm6glbATrLM7DndKLcZ1DoFSr98MZ6to3GxzSlOEccM8tb+iA==
X-Received: by 2002:a67:f089:0:b0:4bb:9b46:3f87 with SMTP id ada2fe7eead31-4cb8011d7e6mr5033337137.6.1745207149223;
        Sun, 20 Apr 2025 20:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1i5MplA0k7CxdohZHJOAN8NXQrZKkjU3zR0UFMuopnzkvSvPRh2gSe1jL70oe+NUnRQzp/TgYqM732XBN6FQ=
X-Received: by 2002:a67:f089:0:b0:4bb:9b46:3f87 with SMTP id
 ada2fe7eead31-4cb8011d7e6mr5033333137.6.1745207148893; Sun, 20 Apr 2025
 20:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:45:32 +0800
X-Gm-Features: ATxdqUFgCCkJJ0JXdJQwN88OxMbo6yfhaiyGCN8WzeAS9Lrj99kC3ES_wTxfQwY
Message-ID: <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> is disabled, and any attempt to use it will result in failure.

I think we need to describe why the default value was chosen to be false.

What's more, should we document the implications here?

inherit_owner was set to false: this means "legacy" userspace may
still be broken unless it can do VHOST_FORK_FROM_OWNER which is
impractical. Does this defeat the purpose of this series actually?

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig | 15 +++++++++++++++
>  drivers/vhost/vhost.c |  3 +++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 020d4fbb947c..bc8fadb06f98 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
>           If unsure, say "N".
>
>  endif
> +
> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> +       default n
> +       help
> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> +         userspace applications to modify the thread mode for vhost devi=
ces.
> +
> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `=
n`,
> +          meaning the ioctl is disabled and any operation using this ioc=
tl
> +          will fail.
> +          When the configuration is enabled (y), the ioctl becomes
> +          available, allowing users to set the mode if needed.
> +
> +         If unsure, say "N".
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index fb0c7fb43f78..568e43cb54a9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +
> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
>                 u8 inherit_owner;
>                 /*inherit_owner can only be modified before owner is set*=
/
> @@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>                 r =3D 0;
>                 goto done;
>         }
> +#endif
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> --
> 2.45.0
>

Thanks


