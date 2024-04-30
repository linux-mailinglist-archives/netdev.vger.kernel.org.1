Return-Path: <netdev+bounces-92613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3F08B81AA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A122849E2
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B229190660;
	Tue, 30 Apr 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kFnv34Pu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446FF9D6
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510317; cv=none; b=arennA4dj5jHZr8ZG7KJ5LiUzfzzL35xSHOl1NHDGXm3s6M8vvgIic+uvoVYrRJGaEWyXggyDqm8PZQbIW8x4RGRIIaAKGRyz0P0NjiUlzMYeYF2TZutEXBIhAjBDIelVeLVCv024YJFd92iTXntpme8a6O29vZxvf/HoRWh9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510317; c=relaxed/simple;
	bh=eEuigc1vZwDWO7neFJjNuCPGI/RAWv0km+/1ToT7Pg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHD7ulm70yLE7crHLzBqVSAex3TnrT4zOShpp86th0BJIb3FtdKvm1NSvG4kWN6bcIQdT8LpUJK9b7EAnic21xcBlFlx38XLMCrU9HFp8X7DduaFkrL21jpKTJvBQrAqpF6xjzsGcOufRp6QlOjdk33O3zDnyVxf4b33EJ+ogoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kFnv34Pu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KOmvBKFBinIvBDoqWY07Ww0wYY09rwVqiaRc5ylxug8=; b=kFnv34PuQNScyfiRmKc/SR7PNv
	OqUFiC4fw8kBM+H4IVKV311EdetROXqKWelm/WR43+Wh3JVUYk3S4oGkKvn8Ov/3ETwzjqnDMVwnT
	qmMD0FbNkXhoo1AMeOyFtcxvroQx0y0Vw9R9aJHbotbKXWkastsrQJOiXORH0n3GZWoI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1uS8-00ENvD-Gb; Tue, 30 Apr 2024 22:51:52 +0200
Date: Tue, 30 Apr 2024 22:51:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v3 5/6] net: tn40xx: add mdio bus support
Message-ID: <1dc56a84-771a-478c-b302-769186d6497e@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
 <20240429043827.44407-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429043827.44407-6-fujita.tomonori@gmail.com>

> diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
> index a93b83e343d3..2719a31fe86c 100644
> --- a/drivers/net/ethernet/tehuti/tn40.h
> +++ b/drivers/net/ethernet/tehuti/tn40.h
> @@ -11,6 +11,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/in.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/ip.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>

> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) Tehuti Networks Ltd. */
> +
> +#include "tn40.h"
> +

Part of the reason we want to see includes here, and not in a .h file
is that you are including lots of things which an MDIO driver does not
need. That slows down the build.

> +static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
> +{
> +	void __iomem *regs = priv->regs;
> +	int mdio_cfg;
> +
> +	mdio_cfg = readl(regs + TN40_REG_MDIO_CMD_STAT);
> +	if (speed == 1)
> +		mdio_cfg = (0x7d << 7) | 0x08;	/* 1MHz */
> +	else
> +		mdio_cfg = 0xA08;	/* 6MHz */
> +	mdio_cfg |= (1 << 6);

Is there any documentation about these bits? 

> +static int tn40_mdio_get(struct tn40_priv *priv, u32 *val)
> +{
> +	u32 stat;
> +	int ret;
> +
> +	ret = readx_poll_timeout_atomic(tn40_mdio_stat, priv, stat,
> +					TN40_GET_MDIO_BUSY(stat) == 0, 10,
> +					10000);
> +	return ret;

You don't need the ret variable. Just:

	return readx_poll_timeout_atomic(...);

	Andrew

