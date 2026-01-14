Return-Path: <netdev+bounces-249959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61162D21ADF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB2F305467F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEA38B9B1;
	Wed, 14 Jan 2026 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC0CYTo8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1138BF60
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431468; cv=none; b=a98Rg4NTl0At4Eu71/pZPHCY26KY2f4QewhUCO4Q4x6UHpXpPJxInCC2lekEag4ly/GLru7I4tWQnU0vJBS/u+x3kXw8brrFzc8yGH0saZyMYbLhXsxLNfhePmyPrRVwq5YBZU/uPvMaYULTvLorxlCByVv7bRKlNQiXnx70gAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431468; c=relaxed/simple;
	bh=X4m5VYxNJdf+yKlu1tqW+laO95L93p8ppKJQ7NmDSNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Haa3cVnI+2ENDptVR9SztI4FyYsHB3parMFg/qGMniHsYSdOkDTpchXUwGPkBA8hQbaS64I3YWVWtJ9ZPXSj4YbtqnkIZLDVKNu+h/1N7no/YkJUZ6YiL88zZJFk8Sh29FLUxQtAePIFJ0SE0Kk45rfUzOODbCCrS+2LweaIJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC0CYTo8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee307e2ebso443975e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768431462; x=1769036262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDobwa87FnFNj7Jj1JsOkjtdbqkfgMfRw4tVEyrijTI=;
        b=KC0CYTo86H+DHpVcySlUbm1ce14VT3pI3B/Er2bJodB/2MMqNXzxvSlolLjKqKiFaI
         0EhPeYgHxywPdUeFcDLzgXZ7LuXAi/ocH1i1lE6yDiFiQC++0GXzlpvMdh+4QyXebU4j
         lv7nTJrrYM6B9e+9lKS93XFiLEEcnsM+mwXUZsMiHGtqd9WF88zyvlNtTWk64r6/Y5W+
         t3pTcJOI3EjSMhYUg6sWVwvfEcYLvZcWLrBBT9UeG3in7DdvoqXXiWkdBF8SX28eNUGL
         ji58X9wsLa1OPm7z/ONeSbf6ca3y4dkMYv69ylvKgJUDp0jSm4/G+T7d0raEacOTUJnn
         rkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768431462; x=1769036262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDobwa87FnFNj7Jj1JsOkjtdbqkfgMfRw4tVEyrijTI=;
        b=uZISczB7LR5odtaCcMHioQVa7PdONK+mO8tzKhXHke/ihKgMyIvPG3vLyXvUlqmnq1
         LtGHZWzylp7n5+Nxd6fx+RMePyVcyv2oXFNdoHmUqrP3SVvS/ahyraGA0syRP5B7XqNT
         w/LOyZrBmA7P0r10wqq5js8lt/6TnLCgLlhXlSS0FrxIFgFkBNg4ulG3TdcfuqzaybO/
         yoZW4HPfDJqFW3GrGug2+2GPrTTQ2rwCMr4b/MDViGqLQf+wyQ72fZitgs2LuZ5h7LJS
         NeIgjkTiPJfJPZxGQLIKPIeRyGw5fPcuAMW3weWuMo4DBSsdRCT0SGpCGhUj8bf62cCM
         5ZDA==
X-Forwarded-Encrypted: i=1; AJvYcCWR5DEV00XMOvpLk893SPV3UgsaVLo8FAeMhcsh1vZpvPgbeoZ4iBI6NPruAD1TeNgCplWcoDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/L0AmDHnyo+HBI//55mqXzvJo27/rt9wNJiHd4DmZEkDAmXw
	Ltlomkq3LgvyqhgJgwn7BCd/RJ0GgloRULg3/LJEbaspTNfgD8SfNuel
X-Gm-Gg: AY/fxX5zh/8ZMKqrzCD/EM5FSnFxqEmSzJOh9t/oKKEnH8ZtFra//69BZHcKUkj6RkN
	9WVAA1Y9CPK8SWOmMgokGYIjKXO4/x+vvaUuDKGb3CgRGBN0tJrgsakfPDc1V8svGzjw6Fc92MT
	IO8IqhILMz91a4xM6cc7qb2uMBZ5IuNAU7e83Tyo0V28ApLkhAY/aikxv8H5OM/egs4AQxQzR/6
	fDTaMNg9PMTDGqKcc5zecnmBJd2w6/G7R2iR1EQrYlStWr237wn5Lx51w+/Z1x45AnVBhruEP0x
	NvDXtuoFeyvYfBJlr+xgIKYQwf8ysK8ADqqO7kjdewqm5YLsqDPRK10P8CEwJCLFXtzs4XdQkZ+
	o5QsSrUtVETzbsnDM7h8TuBqqWDfFyFMG3GQEbmAtQiwXGm/mIhh16a09Ittm2o44jpboMR5/Y3
	SXsg==
X-Received: by 2002:a05:6000:1a8a:b0:429:d084:d217 with SMTP id ffacd0b85a97d-4342c38bf52mr2902416f8f.0.1768431461615;
        Wed, 14 Jan 2026 14:57:41 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:d5b0:b41:b5b3:8c4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6e1698sm1957816f8f.37.2026.01.14.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:57:39 -0800 (PST)
Date: Thu, 15 Jan 2026 00:57:36 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260114225736.c7w3tpfol7bdc4so@skbuf>
References: <cover.1768225363.git.daniel@makrotopia.org>
 <cover.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>

On Mon, Jan 12, 2026 at 01:52:52PM +0000, Daniel Golle wrote:
> Add very basic DSA driver for MaxLinear's MxL862xx switches.
> 
> In contrast to previous MaxLinear switches the MxL862xx has a built-in
> processor that runs a sophisticated firmware based on Zephyr RTOS.
> Interaction between the host and the switch hence is organized using a
> software API of that firmware rather than accessing hardware registers
> directly.
> 
> Add descriptions of the most basic firmware API calls to access the
> built-in MDIO bus hosting the 2.5GE PHYs, basic port control as well as
> setting up the CPU port.
> 
> Implement a very basic DSA driver using that API which is sufficient to
> get packets flowing between the user ports and the CPU port.
> 
> The firmware offers all features one would expect from a modern switch
> hardware, they will be added one by one in follow-up patch series.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v5:
>  * output warning in .setup regarding unknown pre-configuration
>  * add comment explaining why CFGGET is used in reset function
> 
> RFC v4:
>  * poll switch readiness after reset
>  * implement driver shutdown
>  * added port_fast_aging API call and driver op
>  * unified port setup in new .port_setup op
>  * improve comment explaining special handlign for unaligned API read
>  * various typos
> 
> RFC v3:
>  * fix return value being uninitialized on error in mxl862xx_api_wrap()
>  * add missing descrition in kerneldoc comment of
>    struct mxl862xx_ss_sp_tag
> 
> RFC v2:
>  * make use of struct mdio_device
>  * add phylink_mac_ops stubs
>  * drop leftover nonsense from mxl862xx_phylink_get_caps()
>  * use __le32 instead of enum types in over-the-wire structs
>  * use existing MDIO_* macros whenever possible
>  * simplify API constants to be more readable
>  * use readx_poll_timeout instead of open-coding poll timeout loop
>  * add mxl862xx_reg_read() and mxl862xx_reg_write() helpers
>  * demystify error codes returned by the firmware
>  * add #defines for mxl862xx_ss_sp_tag member values
>  * move reset to dedicated function, clarify magic number being the
>    reset command ID
> 
>  MAINTAINERS                              |   1 +
>  drivers/net/dsa/Kconfig                  |   2 +
>  drivers/net/dsa/Makefile                 |   1 +
>  drivers/net/dsa/mxl862xx/Kconfig         |  12 +
>  drivers/net/dsa/mxl862xx/Makefile        |   3 +
>  drivers/net/dsa/mxl862xx/mxl862xx-api.h  | 177 +++++++++
>  drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |  32 ++
>  drivers/net/dsa/mxl862xx/mxl862xx-host.c | 230 ++++++++++++
>  drivers/net/dsa/mxl862xx/mxl862xx-host.h |   5 +
>  drivers/net/dsa/mxl862xx/mxl862xx.c      | 433 +++++++++++++++++++++++
>  drivers/net/dsa/mxl862xx/mxl862xx.h      |  24 ++
>  11 files changed, 920 insertions(+)
>  create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
>  create mode 100644 drivers/net/dsa/mxl862xx/Makefile
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
>  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h
> 
> +static int mxl862xx_setup(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	int ret;
> +
> +	ret = mxl862xx_reset(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_wait_ready(ds);
> +	if (ret)
> +		return ret;
> +
> +	ret = mxl862xx_setup_mdio(ds);
> +	if (ret)
> +		return ret;
> +
> +	dev_warn(ds->dev, "Unknown switch pre-configuration, ports may be bridged!\n");

Nack. User space needs to be in control of the forwarding domain of the
ports, and isolating user ports is the bare minimum requirement,
otherwise you cannot even connect the ports of this device to a switch
without creating L2 loops.

It seems that it is too early for this switch to be supported by
mainline. Maybe in staging...

> +
> +	return 0;
> +}

