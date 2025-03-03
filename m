Return-Path: <netdev+bounces-171092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF22A4B7BC
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 06:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC25C1685B7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 05:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC371E2847;
	Mon,  3 Mar 2025 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIlTPZD9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE221922E7
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740981157; cv=none; b=XwwoAvVXfQzLqVhDi/JWAPpT9xU0IHGiS1YHWjp5SgmchsCpEGtzh1pGK4ccRzdoTjN5pA7CzZM6gWX3RYEASI8MM5ji1vpa8nHpTyGYrKMc4DRjjZTHZaeJICtc8M58/cXGRSyVc9X5zrRvToODOxbD3dMYQ86gZeZ9571oCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740981157; c=relaxed/simple;
	bh=gLGOdr0gUHxApp4Lbm9o/HiERNBdmbBhaZlmMFU99LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTVS749bZvbHTm/Vjj+A3DiTxPwWumGhocgNFUIRQ8hiI39o9otKnVPAksz4Vceh1JIACUoPWiN8VbeZT04ecnZGqGOGGkPQ6V66l/v9mDz0S7FZzEXJzGJy1bSAY2VXBxKpVfvgsgbQWh6OVYczn5vW908qdHeA1qGuopahl3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIlTPZD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740981155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftdu/1Kbak1I91E2tCsRVJqvNKhfPSzve6d3GLs9Dlw=;
	b=UIlTPZD9phqXFb24yMZXJeemKoUTm5bZyuUP7t3nGAG8zzf8JQC184J3KoUnqfhv8XY2JP
	DaLizwCMy420HMsw04AR+ntpFLMRzHs1dUCZuaySgj57u7rtZGD7GwEVngHnlJWjdu4GOp
	E1EHj/NVJkxE+hml3pjvRmb4q1Sb1NU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-dPVTk5pPNTaaS2tNR1U_8g-1; Mon, 03 Mar 2025 00:52:20 -0500
X-MC-Unique: dPVTk5pPNTaaS2tNR1U_8g-1
X-Mimecast-MFC-AGG-ID: dPVTk5pPNTaaS2tNR1U_8g_1740981139
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2feb4648d4dso11527956a91.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 21:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740981139; x=1741585939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ftdu/1Kbak1I91E2tCsRVJqvNKhfPSzve6d3GLs9Dlw=;
        b=qvKL1dN2asFHAKSPJKOuVJeaUXavFGTdCDnikVATgZc1Mr/Q+frXet+CCfItTWQ7CT
         06QHGSM0gVSwNe7qi1n98eFzkEBuMpDHiEQ4VEyo4WspYdeuEdJCKmeeFbW8E1wSiYSE
         u4LrENRGYQqFEoK1YJERoLRceqg6YjehOCC9LJ0rBCYMPOQ+2aP2n9K/8V7EBuQqT1Fv
         Fhnf4iTNsH2iQuonF82byTHX6b7GBdItJmJQlpCutzAP8xFh2ajjNSddjHjr1ggDwB64
         379W5sTaEIiknoP43oRTVYOXIjUKhl1kpPsAi2FlLvM9Zex0oUHhCBoQoqn3wou6Oh7L
         gwlg==
X-Forwarded-Encrypted: i=1; AJvYcCU8xr4rovbQGxEbliSh8VPZ3VKTtYvx2QeI4jckPB86YDJ2dSBJXY1sXQlsbgyEC7gB7ai7thI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoesdboVvKs9f31IBgZvuYQTGSlc3onExKlHozd09HFMLIiqN
	9V26sjhOJHp1UDyFFfiTDVRCWDIog19PfvnvL23xDpAa7PAYMoNiVyJu4mvbmPDXPPf1LPvRnsU
	7WBy0sBN5QGJ0j3J4MTP++3csIQ5PjrTp9/ot6DlFpe/tMaWznbOisD/ck+lbF6oMSqy8VlrPea
	dy2YGgYB9UNOoJLFIWHPDLEejoPkyv
X-Gm-Gg: ASbGnctw7JrOsLkXgzMiGej0Rp5u0cQvvcMxGgL61hPyfxxmr7z3qngc0AR0Y0hlOub
	KPL9rs4t62iBZWouFMHuYOMH+q52c9j4Os+sJes23S6k32MvzCMcFex/4xjWQbTH678gFBBe/NQ
	==
X-Received: by 2002:a17:90b:554f:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2febabf8577mr18654163a91.29.1740981139232;
        Sun, 02 Mar 2025 21:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhYuZxnpRojNpvlHkuk7NDb2qHnc13DCXse6EtUeiPs2yK5wok7qMMepunLQoYKyM78lF2mK6cW4eqe6uBJnU=
X-Received: by 2002:a17:90b:554f:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2febabf8577mr18654149a91.29.1740981138899; Sun, 02 Mar 2025
 21:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-9-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Mar 2025 13:52:06 +0800
X-Gm-Features: AQ5f1JoMEQP4W-edssF3skwLm-BwfJKNJ3aGcD-m4x5KSoAF-9cVDu-CpqhKZBQ
Message-ID: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> is disabled, and any attempt to use it will result in failure.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig | 15 +++++++++++++++
>  drivers/vhost/vhost.c | 11 +++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index b455d9ab6f3d..e5b9dcbf31b6 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
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
> index fb0c7fb43f78..09e5e44dc516 100644
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
> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>                 r =3D 0;
>                 goto done;
>         }
> +
> +#else
> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', retu=
rn error */
> +               r =3D -ENOTTY;
> +               goto done;
> +       }
> +#endif
> +
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> --
> 2.45.0

Do we need to change the default value of the inhert_owner? For example:

#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
inherit_owner =3D false;
#else
inherit_onwer =3D true;
#endif

?

Other patches look good to me.

Thanks

>


