Return-Path: <netdev+bounces-160311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32F7A193C6
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE467A1487
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F1213259;
	Wed, 22 Jan 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i17328DL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636517C220
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555625; cv=none; b=Yf1Qfa2uUE7hQblP51/9YLv0OtOj5wAFUE4nU7dioWUcUdG6KWDl/4NaOSKhAo1p/vrCSW0abLJaq9Z5/peHqBd3Jc5ynltLWWecCM+7Ble8tV1T8ajODf/On/+6108yIENzE5PeHm6tDX5nSr7rBER5uQyWxQzw3K6bdvSxwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555625; c=relaxed/simple;
	bh=Kd7ffCWJJDPDK0MqYx2DzGL/vy5oBFzl/6FDdxzHO3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEx4gRzVsI7xCHrZW6gDW+ABMCoxiyoYcjjvHrIp1b8twNGV+4YQxR9+d1erHCpkQ4FhuMaCdCGBXsOautOZZvoBApQSWduxckKt3NK3eATC0c4z1MPHmhzBQ0QZfE+SUBgBEuzskVMwRk9obbSo8BWqbgXz6SDNSEa0AEDtSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i17328DL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so13723405a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737555622; x=1738160422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mlafg6MOPSTIjG417jWhXstBad4Qjud1/UhdpyiAyfY=;
        b=i17328DLr2MKCJ2v1K7nUSktGYwCxydQwYpfpeLT6yXaMk9CNe72JWmWYY6sqL0TGB
         7Da6LW/7lOQe7YZ5d5HNjzfDcTT2CnJ1/K+YF1huzcatYZHrSN2oD2Cm1ZGNrW4jWURe
         cjYKA0Qf5nFoxadWCiLcRGerxEX5RwHm08iF5E5GCyPAbtoe1fMtXeByY32iF+8rd1zu
         BOqbTWEOYgcAC3aAuLppAoMA3w7NVmJaFTPLx4WmS9lfdU4UTQ+Wxigt1lWjbXUip/Jf
         m1FM+ta1pTxCewyPTGerrp9gtRVJVPKaImjLXbUMF/ubfQutuOhmHU0FJcoJPwjkT7QQ
         u+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737555622; x=1738160422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mlafg6MOPSTIjG417jWhXstBad4Qjud1/UhdpyiAyfY=;
        b=oGt5RLqDTtovDxSqylOCX7/5InpxfrHCVTS8jaaaORuxO6W8Ng/TZMjtPZUqdejGMh
         qRs4g6fKu0pxAxEMMeQKqZiphSBsnaez7xnSoMv+VDzharDUZrLEYOWrysa3LHwibuLq
         p3+lgkHcChHYOYSZSO8lhqszcT/aw2WHkzxToKeCb0retxHNNc9hA0LwYZIfWz+4EvKw
         QseaPc7WNvFUyjTG9tP1c8pHqpYudn0H2DRJ03obCzNlhJL4GbYxYPSX52UUTzQOSsfx
         eEUIKZpxK7H4/f4XRJvsc22Lg98tN7riGFV/4efq+gqXjEkmYICqs+TJmvaUwOFptVEO
         zzAg==
X-Forwarded-Encrypted: i=1; AJvYcCV2o+FREuT7I87LuDpbWu85YtvmwRb/0vCul2WGGBAEwouFjvDOupvdfXwTsMlF9Qj0FUZkDxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76tw5vbKD0ONaP+DDTbwP5DF8/5OK/IwAu9p0bXbGtgYN9cf4
	RuSgZxC62H71IdVASBeUbnjkwB4mbbCT5wl7ndFWURwFtO8gfaLkBcYDdMtqj3pUXXNl6ylqFVv
	2BtpRV3P7tzhXA4/a5t8hb2ylAAJbkS95g51w
X-Gm-Gg: ASbGnculaXyVxVieo0XoHkR/jI+gZEvCJ7+tshtHuvU6O8bl5OwuqQpd0XLNUagrqj8
	2FClMdDlhucMCgLUWkGyw618gXV0Rj2WgInYpYP2u80H4omIVsQ==
X-Google-Smtp-Source: AGHT+IEZMBOl8mcJGucIs7utdDF/nANkEK1tkzwbM09rzS4qHV2knasFSB5ur9DDYL1fDDtG2d9Jv7GI+HD6fyBcgHs=
X-Received: by 2002:a05:6402:4306:b0:5d0:e570:508d with SMTP id
 4fb4d7f45d1cf-5db7d2fe766mr23195622a12.17.1737555622296; Wed, 22 Jan 2025
 06:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-7-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-7-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 15:20:11 +0100
X-Gm-Features: AbW1kva2uR5eMnCkWX43QCdPfZGGwdKW38VODm1EnwnYhpxh-2NTpFCQTQkBhrc
Message-ID: <CANn89iJ7XcNJDKqzZ6pRo4peSd9MntiSjoxMyrrhCrrvjjHObg@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] eth: via-rhine: fix calling napi_enable() in
 atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	kevinbrace@bracecomputerlab.com, romieu@fr.zoreil.com, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> napi_enable() may sleep now, take netdev_lock() before rp->lock.
> napi_enable() is hidden inside init_registers().
>
> Note that this patch orders netdev_lock after rp->task_lock,
> to avoid having to take the netdev_lock() around disable path.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: kevinbrace@bracecomputerlab.com
> CC: romieu@fr.zoreil.com
> CC: kuniyu@amazon.com
> ---
>  drivers/net/ethernet/via/via-rhine.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Hmm. I  think you forgot this chunk :

diff --git a/drivers/net/ethernet/via/via-rhine.c
b/drivers/net/ethernet/via/via-rhine.c
index 894911f3d5603c109cba7651b6b047b59ec85c9..4e59b5da063e1690fce0f210c331=
43a42745810
100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -1568,7 +1568,7 @@ static void init_registers(struct net_device *dev)
        if (rp->quirks & rqMgmt)
                rhine_init_cam_filter(dev);

-       napi_enable(&rp->napi);
+       napi_enable_locked(&rp->napi);

        iowrite16(RHINE_EVENT & 0xffff, ioaddr + IntrEnable);





> diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/=
via/via-rhine.c
> index 894911f3d560..f27157561082 100644
> --- a/drivers/net/ethernet/via/via-rhine.c
> +++ b/drivers/net/ethernet/via/via-rhine.c
> @@ -1696,7 +1696,10 @@ static int rhine_open(struct net_device *dev)
>         rhine_power_init(dev);
>         rhine_chip_reset(dev);
>         rhine_task_enable(rp);
> +
> +       netdev_lock(dev);
>         init_registers(dev);
> +       netdev_unlock(dev);
>
>         netif_dbg(rp, ifup, dev, "%s() Done - status %04x MII status: %04=
x\n",
>                   __func__, ioread16(ioaddr + ChipCmd),
> @@ -1727,6 +1730,8 @@ static void rhine_reset_task(struct work_struct *wo=
rk)
>
>         napi_disable(&rp->napi);
>         netif_tx_disable(dev);
> +
> +       netdev_lock(dev);
>         spin_lock_bh(&rp->lock);
>
>         /* clear all descriptors */
> @@ -1740,6 +1745,7 @@ static void rhine_reset_task(struct work_struct *wo=
rk)
>         init_registers(dev);
>
>         spin_unlock_bh(&rp->lock);
> +       netdev_unlock(dev);
>
>         netif_trans_update(dev); /* prevent tx timeout */
>         dev->stats.tx_errors++;
> @@ -2541,9 +2547,12 @@ static int rhine_resume(struct device *device)
>         alloc_tbufs(dev);
>         rhine_reset_rbufs(rp);
>         rhine_task_enable(rp);
> +
> +       netdev_lock(dev);
>         spin_lock_bh(&rp->lock);
>         init_registers(dev);
>         spin_unlock_bh(&rp->lock);
> +       netdev_unlock(dev);
>
>         netif_device_attach(dev);
>
> --
> 2.48.1
>

