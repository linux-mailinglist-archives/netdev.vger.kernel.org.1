Return-Path: <netdev+bounces-158109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4201A10781
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D101887655
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E3234D1B;
	Tue, 14 Jan 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9gbqhLg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D1236A91
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860481; cv=none; b=Nax3PepAqiHkMyJp/ODnTQyb1wOBA4TFqF0lxeVEHv2D23lyx/7zsrtA1EJYa0qR05xknqYmZ8I/VpHR3Or6c1vDyCJYALroJEUiir91rTJYt8lunNgAyAdFg0HHAVPglPVXdxYLByiIjz6vytKxm2TKjGkkRGU6Wo/wL7B+k8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860481; c=relaxed/simple;
	bh=l6+iGgowSPphpTGUafiUxn5ra1sHemuk6zcfp20ac7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEiX67D9/c5ikhRLWaoAEs2C5TSp/3nK3279lEOO55+qOTw6ZW7PstTyiEUWgyNpAgrfx+DCPCXrU97wT8hYPkQHyIG8hnBiAm1yG+bLpCxuiQYH7ee+h7kg38k17gPM0kHU7Qstpok8LIaqiB0sr7jQ8NWqyVZVhy/h+9z9hPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9gbqhLg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaef00ab172so876502966b.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736860477; x=1737465277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aDIwlNC0yep+1mAuNUN0AqyjkRiFfdtq1PhTBWjaQg=;
        b=D9gbqhLgsM2ZoxJ27aWK4D0fw7nmpXRYRDq3FJa+BnJJx/fKtU3ieOtmPaP5Casfm7
         LM6rjtuy5lRhQC84RMJKZyOc52t/uyAdgf+eAq9cYGROpE79Y1pNrYs8A1E0bNuckx4+
         4Mr/bONfKgymVHTC+LKAfy64t2jJT0q1OoazGicmZ+/bnc4o33dB+WTsobqB1DsfKfGI
         MbbNgS+6Lp12n/68WbF2cV6GP0sjSI9VjP/x6WjFoMjxQrfx9FXXQlVGalwMrOky+0Bk
         ee82I2qSemcsnV/3/cmdgGy9MhP5aeHGepyIP77+W4g6bEK6rmtSnOgI+lfIuMNYEVNu
         h1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860477; x=1737465277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aDIwlNC0yep+1mAuNUN0AqyjkRiFfdtq1PhTBWjaQg=;
        b=HPzuc37i6QbpeKykvPDnMdFvPA5uXdUtlHb7sVDtGgujj8iQy6WkVaeIlQ9IpsAGh9
         TJ94USHTvWpeYpUeinJNqFVskcaGUWLyHfCNQ6fctoUCYnlY1ZhgZW7WY+EcRdAimyva
         /61TajX46ePGeqLcgxIgQ87dgyJw/rf7SxozRG9bI0vgLXBZipwnAwWUIYk5SbWqrF5q
         gHdFiocYNYlSe4Pvfa/U86iudHRrFx3/zEo+8wNFPPCq5xa5FchWZBl90XZCQkpdTjw/
         z/m4u7ZjA53xT2kKGDPX1UpWoh7jkniAvLq3KJaJrqMH5PRJc0t+OpEqGDVorQ0YKkX9
         edkA==
X-Forwarded-Encrypted: i=1; AJvYcCVnfPq1qnEl2RMQ2IdhK/2XpGpnPT9YFaKXrIVwuCVIIVk1wDf2QuRvbCShX89ZwRPUoXbtyjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2tyLpeac5V+2O49EWc72qS/HdL0Y9BG1CsbK3Ur5gT6Xfw1R
	Y7x/qsdO6VxSwicSSLNd6LnVjI3yirt5YcW557KfN29oNxJD7RfiN/T0Eve5Br+wItccWgDL0sr
	BhlCEIUVvK6wBucNMsDGXS0Ku+pbhFLs0y+K0
X-Gm-Gg: ASbGncsP/DsQMTIM7lBkCA7RUjqLLeP799UQWx6vX7E79Xi2FVlBvEZDcgADxGKMqHn
	v+q/SAXIjBbaFSLm0b7P/zwlLVKnKxzw9gYcdIw==
X-Google-Smtp-Source: AGHT+IHhul9anDv566V9sjX6ITjdtalz5OSVNecMlqgWNPiplOXo2Z2pOncVFJPVZzTaauzQ89Qf1DZUg2ZfajVxe2o=
X-Received: by 2002:a50:858c:0:b0:5d9:857e:b259 with SMTP id
 4fb4d7f45d1cf-5d9857eb31cmr39346670a12.31.1736860477407; Tue, 14 Jan 2025
 05:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-7-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-7-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:14:26 +0100
X-Gm-Features: AbW1kvaRV3gZUsOIcLDEPPZHomILAzF21VKqnqM74rElZXqdn4FjDNUHBeoHD2E
Message-ID: <CANn89i+x3UbQWS_5jn4FLX0j8THitepvKUtK1rj3qxk1pVoKZA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/11] net: protect NAPI enablement with netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com, 
	pcnet32@frontier.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com, romieu@fr.zoreil.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Wrap napi_enable() / napi_disable() with netdev_lock().
> Provide the "already locked" flavor of the API"
>
> iavf needs the usual adjustment. A number of drivers call
> napi_enable() under a spin lock, so they have to be modified
> to take netdev_lock() first, then spin lock then call
> napi_enable_locked().
>
> Protecting napi_enable() implies that napi->napi_id is protected
> by netdev_lock().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: pcnet32@frontier.com
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: marcin.s.wojtas@gmail.com
> CC: romieu@fr.zoreil.com
> ---
>  include/linux/netdevice.h                   | 11 ++----
>  drivers/net/ethernet/amd/pcnet32.c          | 11 +++++-
>  drivers/net/ethernet/intel/iavf/iavf_main.c |  4 +-
>  drivers/net/ethernet/marvell/mvneta.c       |  5 ++-
>  drivers/net/ethernet/via/via-velocity.c     |  4 +-
>  net/core/dev.c                              | 41 +++++++++++++++++----
>  6 files changed, 55 insertions(+), 21 deletions(-)
>


> diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethern=
et/via/via-velocity.c
> index dd4a07c97eee..892dc6ef3d3a 100644
> --- a/drivers/net/ethernet/via/via-velocity.c
> +++ b/drivers/net/ethernet/via/via-velocity.c
> @@ -2322,6 +2322,7 @@ static int velocity_change_mtu(struct net_device *d=
ev, int new_mtu)
>
>                 napi_disable(&vptr->napi);
very minor nit: this line could be moved after netdev_lock() and
become napi_disable_locked();

>
> +               netdev_lock(dev);
>                 spin_lock_irqsave(&vptr->lock, flags);
>
>                 netif_stop_queue(dev);
> @@ -2342,12 +2343,13 @@ static int velocity_change_mtu(struct net_device =
*dev, int new_mtu)
>
>                 velocity_give_many_rx_descs(vptr);
>
> -               napi_enable(&vptr->napi);
> +               napi_enable_locked(&vptr->napi);
>
>                 mac_enable_int(vptr->mac_regs);
>                 netif_start_queue(dev);
>
>                 spin_unlock_irqrestore(&vptr->lock, flags);
> +               netdev_unlock(dev);
>
>                 velocity_free_rings(tmp_vptr);
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

