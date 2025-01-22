Return-Path: <netdev+bounces-160212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92DBA18DB1
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF32B1604E8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CC20FA96;
	Wed, 22 Jan 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnxJNTer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE320F990
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535358; cv=none; b=q9FmTDTFzHTjAmNoPYgITp3u90r14vBy1RUQh8YDR7wJAx/MaixcBugmbt4nKR4wpF2Qry/EfGTxuFmBvt5Q6EUISH7aflXZJiD19ff2X8IHeeSKafW28CpaOCCNqJhoyXsfTiQkYNaziDqcVQ/Eb4F3VFPCOXnbZK7Kr/oCcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535358; c=relaxed/simple;
	bh=eLpKY8Esec2ZgBLlswQX47+RlqWyrIYGkfDxGR4KqXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezIMXzumg5Iby07hVDBRT2e4MVUeICmHin7LqVdgkSrNcAimjSr0pVkfg5sbWDZuG6uxpD1HjnLVfGkhhE3VBD5C7dcTmxyMJiiWs2J4HHTowkNwfQG+MVXsBvjrkmj6UvGEaNA3J/a2+v203uwzf+sKmpfLxEMvpX16/XlPreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnxJNTer; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5db6890b64eso4465764a12.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737535355; x=1738140155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBgGROKNAN66v+GuJsp9FXjJ7ICI4HAgUQQzNp05ABs=;
        b=bnxJNTerCke9rjOxqp5rNH+YJTvPolgYjn2aem/9XP6okIUP/1qU7eEp3+WJ3DyH4i
         grzgRcId+c2AxIJ3GG4icr1sK8WAJFIduABEfCbCs/SrGptoU4H5eoze8pwRWYHlr3Ey
         280R7OJjwNiC6LQA4BMZ5xfmpQSjvl/k65qn3D2cw781dcdSrVlHNQ+d9GTjFPi4cMI0
         3s32AWpkSwdr2aspk/9af7ll2nkxf2FMJ/Mq3VOPBn40p7z2AzINVHHee7AKunIE6DEd
         dhSKA8DRJ6wNVpXnnWOkS5PWlTIXdfTiVTz9hv+tELiO5FcivGHnNJ3gM98bMCCK9fSC
         56mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737535355; x=1738140155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBgGROKNAN66v+GuJsp9FXjJ7ICI4HAgUQQzNp05ABs=;
        b=d1RCqGNa2rqHqbbAUBk2aMLNKVTtIXZcU6D7GUEjogd7pNt/9CW0BiNkc9/f5YPkSC
         t08Jwh6BBcqEVTXAOEvVoATmJBOUyn+2vZQuwSMhpYljdTYPw+mD4erp+/0eA3IjanpE
         SaoTq+60C2j1Q5tCEt2fNaq7aiRYM6bbvc9gbtJuqLBrmS5njYyrMmI1SJjZJ/zhoTT8
         Tr22P7FUoQhcgqx6y+ZIpAXGZUkzoLHnQpR4r1+FYNkW0Rlfft4qNoJHLH41qt2Upevk
         m41QNY1i2nMWC5Xn85M5bGNF3G/ceA60tuMHcmZX5f+9Vn+xr6EqlMzjeuTpt7RuCMM9
         StVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPYOpSmCAQlWZnjg5JfmR7pmQxDWosUvIo93efvekUIn4XcZmzwmp3fj7Y7iAxOZyVXw9iHhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTycgcokmgeF1aoeCcXsLBK/LW2pYwHVIepgQXnI6VgcDl1URr
	BaqLgJTagYkjlVFyyGmItVCct3utNV490SxUBjpS6yRCzeX5sQ9pnluGPUswd63psGU9PcGn79r
	Vov1bk++9Tcl5xehXCJq/SPOUuuE=
X-Gm-Gg: ASbGncuzFDOg0oK4rSf2mILpdQ//iI1exMxttJzxmLVKl0xY7ng7bEkZjnqqhH/WvCp
	3wyiPb8hvpoDu6ujGA++SCgGVJGG/Mb9ZyEQpWtOuSh7ClhUeQjFzmW0VPeUSCCnn7nJYkaS6OX
	0Su0/+IaSX
X-Google-Smtp-Source: AGHT+IH4qqhe3LEwB8zmv1z0hxucBii601YupMVTbuLuVpZhdmc25o8IU8bIQt3Hqi99xm3o3GEGH1YA28WcXU2hkkU=
X-Received: by 2002:a17:907:7fab:b0:ab2:c1e2:1da9 with SMTP id
 a640c23a62f3a-ab38b4c6ac9mr2113194466b.51.1737535354712; Wed, 22 Jan 2025
 00:42:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-4-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-4-kuba@kernel.org>
From: Zhu Logan <zyjzyj2000@gmail.com>
Date: Wed, 22 Jan 2025 09:42:21 +0100
X-Gm-Features: AbW1kvbpBMrs24jCd7XBCGBxnpoIWQYOLP4vNWBIgYOoyOMdr-Po94h8Nkg9r2o
Message-ID: <CAD=hENe+xLEfdBwfAYiguc-ttubi3v=ur3chN=tAYqe0v-4+pg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] eth: forcedeth: fix calling napi_enable() in
 atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	dan.carpenter@linaro.org, rain.1986.08.12@gmail.com, kuniyu@amazon.com, 
	romieu@fr.zoreil.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> napi_enable() may sleep now, take netdev_lock() before np->lock.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks,
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
> CC: rain.1986.08.12@gmail.com
> CC: zyjzyj2000@gmail.com
> CC: kuniyu@amazon.com
> CC: romieu@fr.zoreil.com
> ---
>  drivers/net/ethernet/nvidia/forcedeth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethern=
et/nvidia/forcedeth.c
> index b00df57f2ca3..499e5e39d513 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -5562,6 +5562,7 @@ static int nv_open(struct net_device *dev)
>         /* ask for interrupts */
>         nv_enable_hw_interrupts(dev, np->irqmask);
>
> +       netdev_lock(dev);
>         spin_lock_irq(&np->lock);
>         writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
>         writel(0, base + NvRegMulticastAddrB);
> @@ -5580,7 +5581,7 @@ static int nv_open(struct net_device *dev)
>         ret =3D nv_update_linkspeed(dev);
>         nv_start_rxtx(dev);
>         netif_start_queue(dev);
> -       napi_enable(&np->napi);
> +       napi_enable_locked(&np->napi);
>
>         if (ret) {
>                 netif_carrier_on(dev);
> @@ -5597,6 +5598,7 @@ static int nv_open(struct net_device *dev)
>                         round_jiffies(jiffies + STATS_INTERVAL));
>
>         spin_unlock_irq(&np->lock);
> +       netdev_unlock(dev);
>
>         /* If the loopback feature was set while the device was down, mak=
e sure
>          * that it's set correctly now.
> --
> 2.48.1
>

