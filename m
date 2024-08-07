Return-Path: <netdev+bounces-116330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC694A116
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD8B28BCF8
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06861B86C8;
	Wed,  7 Aug 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GkF5WhJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F891B29CF
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013481; cv=none; b=tczZIKXZPVXGFMEYlUAbu/8DeBB+KdjHxcAzLJydF3Eebo2pFwEtszAzEec9F54/vhyDuPubgNu9ojVii7Lkzjg3AbUBGxuYgdFgmDr13WOh9wT9meoAYIgHLWcvHpOKVZl2qec8Axon5+c84zidw0dVYyXCYl3mMIqZwXDt5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013481; c=relaxed/simple;
	bh=8SS8xh27Srkd07oBe/XBz0n37DjFfVRPjxCGchkKUTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geyso+FtrLPqvOhce/HaD9dT/ZbOpmjUiC7OXuKJD3HLP1q5QobXJKKpmnDVPhAcUqmQsAk2zCIOeXAepUrgEyP/5hEILxJsfp0W/2qotHiEX8+TrvGABigKhYsFZJr+ZvMCjJziTTxu0VkRfVnLuXqEQ8jRE2TbxMth9OC2RcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GkF5WhJf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so489963a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723013478; x=1723618278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVRqweytOy1Es40wSZZBhJ6u67lYhJfqhSsQD20/ucI=;
        b=GkF5WhJfGkSwvC0x7scKJcVeTjQF3TQOzeSVTf6dlYpevpvIWH2sdJ3gTv7jlUskYd
         rG8ztaFuzxv9JvWNPp8klZId02nHY7H6r3aDmsYXFNnwZ25ACjmD+E1iNiREcS1IiucV
         /bs35S1/8Cp/8ftRjx6ZehLJMmFDkbE6X6oeyZtSufnormdaonRmRbugehr8ABT2X5MG
         zuopAqCOAReymrSguaOEW7nDFVcK9aeT38LKYYE/LVBVjgYdag0SjZ9ag3qcRkt9xt58
         j/L7cQo+dI1PNA5trBr0qGWUa8mjeiq9hUdVOv/benb6uO431y2WHXVOu/j0lK04CwYZ
         G50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013478; x=1723618278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVRqweytOy1Es40wSZZBhJ6u67lYhJfqhSsQD20/ucI=;
        b=MJpoGmLVtBpdSPrZjKt3Sg+Y1y+0O7YM73ju59I2gYAm2ivWOyDUKz9Iz2aIh71rDu
         qoUU9+IHrWmtt1GnN84HEk5qDC81UsshcI/vcO1yWCgw+RskYj8GAYpsVbRDM/hX/8EK
         C7HauL97zYuL4NtfW+9j6Tks06x2nGX89rG6zccFtw/eOylqncAmOq7K/kJtVCDDxF/C
         c5YDvmyLUhrLj9JyAWN7s59xr7G7lFoiu9nqd9EKrjJWazUOpnIOAGrfiyGIrULAbbdB
         hymtGfyU9oBHD875S16RdJhK+Xt/RulDDfLQlN+c0tb2cKHiuZDHoTfxWh/+uyod4Ftg
         JFUg==
X-Gm-Message-State: AOJu0YwQuaVtSXWvS/pU4syQd9yU+5bFWLydw2jip6Lusw3sem9ak66k
	Ebs7AiEuYFzGlYJEFJxLXkPB1TAP7sXBxYzSjx7dMIqnCi7e0lwGq7mRiFC/8YM=
X-Google-Smtp-Source: AGHT+IFowUh+wk9ECaKD+w32GEcBg1W0kjOGfb6mBoKeboiEMRvMfjlYKpphtZLhurDvEjj9zaFCwg==
X-Received: by 2002:a05:6402:40ce:b0:5b8:eb1d:7fec with SMTP id 4fb4d7f45d1cf-5bba367cec8mr1039052a12.6.1723013477908;
        Tue, 06 Aug 2024 23:51:17 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bd4566csm6703995a12.85.2024.08.06.23.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 23:51:17 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:51:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: Re: [PATCH net-next 0/5] devlink: embed driver's priv data callback
 param into devlink_resource
Message-ID: <ZrMZZL7vV-5KLR-l@nanopsycho.orion>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>

Tue, Aug 06, 2024 at 04:33:02PM CEST, przemyslaw.kitszel@intel.com wrote:
>(Patch 1)
>Convert dsa to use devl_* variants of devlink resource related
>calls, so we could remove devlink_* variants in next 2 patches.
>
>(Patches 2,3)
>Remove some unused functions that would otherwise need an update.
>
>(Patch 4, the main one)
>Then extend devlink resource to embed driver's priv data callback,
>instead just storing a pointer (so drivers could put more context for
>similar resource getters, to handle them via simple single function
>instead of dumb duplication).
>
>(Patch 5)
>Make use of the new possibility from patch 4, I've picked the most
>repetitive case.
>
>Motivation: current API was to distracting for me to focus on adding my
>new resources :)

Hmm, I don't really understand how this justifies. It just makes code
harder to follow and introduces oddities, like passing sizeof(void *).
Please don't.

>
>I'm fine with it going through mlxsw or just netdev tree.
>
>Przemek Kitszel (5):
>  net: dsa: replace devlink resource registration calls by devl_
>    variants
>  devlink: remove unused devlink_resource_occ_get_register() and
>    _unregister()
>  devlink: remove unused devlink_resource_register()
>  devlink: embed driver's priv data callback param into devlink_resource
>  mlxsw: spectrum_kvdl: combine devlink resource occupation getters
>
> .../net/ethernet/mellanox/mlxsw/spectrum.h    |  5 +
> include/net/devlink.h                         | 18 +---
> .../ethernet/mellanox/mlx5/core/sf/hw_table.c |  5 +-
> drivers/net/ethernet/mellanox/mlxsw/core.c    |  5 +-
> .../net/ethernet/mellanox/mlxsw/spectrum.c    | 19 ++--
> .../ethernet/mellanox/mlxsw/spectrum1_kvdl.c  | 80 +++++++--------
> .../ethernet/mellanox/mlxsw/spectrum_cnt.c    |  9 +-
> .../mellanox/mlxsw/spectrum_policer.c         |  6 +-
> .../mellanox/mlxsw/spectrum_port_range.c      |  2 +-
> .../ethernet/mellanox/mlxsw/spectrum_router.c |  4 +-
> .../ethernet/mellanox/mlxsw/spectrum_span.c   |  3 +-
> drivers/net/netdevsim/dev.c                   | 14 +--
> drivers/net/netdevsim/fib.c                   | 10 +-
> net/devlink/resource.c                        | 97 +++----------------
> net/dsa/devlink.c                             | 23 +++--
> 15 files changed, 115 insertions(+), 185 deletions(-)
>
>
>base-commit: 10a6545f0bdcbb920c6a8a033fe342111d204915
>-- 
>2.39.3
>

