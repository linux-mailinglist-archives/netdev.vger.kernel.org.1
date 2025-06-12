Return-Path: <netdev+bounces-197219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8663CAD7CEF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C093A34AD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36292D542F;
	Thu, 12 Jun 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ukyhG9A1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7522D6624
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762548; cv=none; b=rkHbvZcNDgIOGi7Zpy2n4Wk6+z0LK3nsDScWNjYxiEwyJ4t58gh/F9tw4hv7qqX5SdwBSy2d4nwMNWACd+FpPZgaMhNjFeTYGqB3W5pj/GnAO3ZhnpjPuj+bYzwppSC/vBbhWtUK9Kw7ZRuvqYCo3L85IoGyYEo4FmacvWzzlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762548; c=relaxed/simple;
	bh=m7oou1dHujPBgqJuAwN9g9R2smh8qT/xltRdemukCJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofwaVlZu4XyE3y46jXjK8PbeaOR6nOGz3EcM0if73Z46DqLibIEjkE1/RKoFzFN/AXjvNQu3Ph6RQhEL+ZXOlNUR3nswR9MXT3Cefs9LvyEn3URm0odR9YG7A8D2RjDBMtHXPSQbVZ1t8rprJFhLCtdXadd5hbloxfeWeX2Au8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ukyhG9A1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1725921f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749762544; x=1750367344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq3+yK1phccQ3oaWkqHGXWvj3PMsQEpv/itLEx5vl2A=;
        b=ukyhG9A1v3TBtjFyrRkK1yVVrZ5yx8Sv8TNvp7e5rfGB3UFSyuIrp/o/NMopv88QtQ
         SbCkcrFscZaYymjZ8TVdUjz66eLoBv0zox5ha/lmqvgKag7cf1o327jh2yhPGvEExfGp
         ESQX1IKzD0Z6gRxDekG5vjQ9Zu/alZM4l/gHOiQldcEmRZlbDbF3W700qehHxu2MLoc+
         6Zg78v3OAw3+wTSo4dOJa1E6Skwxd1Z9FTEerl4VMap2m+phi3gUeWyid/wzGrCm2CW3
         vbK123jXwx5nKh5imfEs+0iH+A30qIM5kSE+4oaf6RjBA+8m7XG5JvFuee0Ir55p8bIC
         bNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749762544; x=1750367344;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq3+yK1phccQ3oaWkqHGXWvj3PMsQEpv/itLEx5vl2A=;
        b=fQF48RC/X1nb7+xNwb4TWotH91Xn+uU9XB6FYMUJMJ2niPLC4LQV7bydb2oIZuRU/m
         AijqvZ/MzTs8PmaQu3V1zE7nYMcUSKErLO0ya22VAfK/U/xopcnan40p0X3gCYDLXye8
         pdS/c6xBzV//nZtPxBu/NwEZ+f2Rf2mFcQzCiB1IK8i84OpQBcDyBsEdeHnV8mLomwJ5
         4CZuMobLWhWE9Xex+4vCc1hEFZwpCTp8lmBma/fxe2Oi8txadNOG55glHsbiSlY1DxgJ
         C1LpQ4IqLX74Nml3kSj564ippSz0SVfSFGofQn1qQVOEBwW/KYyrWQWuLGy6d9BeOklU
         Ja4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE2Qk4ZorYVGLT4tGFOn8zsrF2QzOQc7JiUQAEJDpkNJJuEao7x3jzRoATkxfiaDB+2DEx9eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGgYnpdyqS2LcSCwUM9Ve7WMg9BHx5Xb6GIeWZkAsziebVIXX
	8Ek45GMiGLkimPn4hWyG985V/p9BfFwvzy/n63y3zW5MM+cbNUDEonD67AkFXi5Yr20=
X-Gm-Gg: ASbGncu+OgKsipzkNIdImOgOp2yn+mt6VqhskEiQ+6h8X7Nt2BYHPQ7EqOZqcpnrx9O
	MvbPKzkhkvTbPClLvmgG1iH3KuTBM0WD213F7RrW5LUhUGwnG2u0zp1HkkhpMfuHC5kE3IPm0xZ
	iUpxE8Ff1FXTRk03oW35/5K/N5gxDXTH5G0cJEgFz3RaHPlpoXsTSqXBS7Es4a+5O3AeCWopm6r
	G2AAJdUIWmazwd+Ly2BO6vDnrKqTeduQQ3RhDss9ZWsnnAJtxLF3/3dn1idhvTYlRrtT26+yF6m
	CeMxV/rWOzj4ANcUgoweYNRUr2MX+ZtSFBzNaj9SGbhXOUKWQSlH/uBB01xmn3DXgF0=
X-Google-Smtp-Source: AGHT+IHo3dXHz3hfp/oSpJOLVWdZC25HXQQCxbtTzIPWB8b8q5Ww8A/XoI2b0SmZY5SwEK+xrXw+fA==
X-Received: by 2002:a05:6000:2dc5:b0:3a4:d9d3:b7cc with SMTP id ffacd0b85a97d-3a56a31ca98mr20121f8f.28.1749762544081;
        Thu, 12 Jun 2025 14:09:04 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25e89fsm30934285e9.33.2025.06.12.14.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:09:03 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:09:00 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ecree.xilinx@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-net-drivers@amd.com
Subject: Re: [PATCH net-next 3/9] net: ethtool: require drivers to opt into
 the per-RSS ctx RXFH
Message-ID: <aEtB7G5HVX2-jB9H@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com,
	saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-net-drivers@amd.com
References: <20250611145949.2674086-1-kuba@kernel.org>
 <20250611145949.2674086-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611145949.2674086-4-kuba@kernel.org>

On Wed, Jun 11, 2025 at 07:59:43AM -0700, Jakub Kicinski wrote:
> RX Flow Hashing supports using different configuration for different
> RSS contexts. Only two drivers seem to support it. Make sure we
> uniformly error out for drivers which don't.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: saeedm@nvidia.com
> CC: tariqt@nvidia.com
> CC: leon@kernel.org
> CC: ecree.xilinx@gmail.com
> CC: linux-rdma@vger.kernel.org
> CC: linux-net-drivers@amd.com
> ---
>  include/linux/ethtool.h                              | 3 +++
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
>  drivers/net/ethernet/sfc/ethtool.c                   | 1 +
>  net/ethtool/ioctl.c                                  | 8 ++++++++
>  4 files changed, 13 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>

