Return-Path: <netdev+bounces-132556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B69921AF
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352681C20A2B
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EA170A3E;
	Sun,  6 Oct 2024 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U3bo49Wd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23718BC03;
	Sun,  6 Oct 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250332; cv=none; b=qzQUHZVlV+vaZjOa+Y++P8dZjCLJISSEArtinE8Qg5BvGkz2+DZaN8BDHVhCHVlKr9rEMyE8Rps8LL4n1uJ0Gp/9qf2VNRPPm4zvyGUz0WAQLpi8o945s4a6LwPyhWq6AaArXOHxyqhAtJQ+9b6CnQ7LsjwDKE49h7KZj+1uirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250332; c=relaxed/simple;
	bh=C0S26EJeqgQ9PSGxAjR5f8GfmnVLfYOpAu5sFww+Ml8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQo5ouHLzdmbYGfGaAILzYotc4QBe2nycf1zJa1HB7HrwwomJ+tWkmnSJZkaO5qHmNK+TfnrvsmyOsLsk+wxTZTVRBh8EnQ9FjmLcqWPopRO5XsXcutfRQ6xtP0lc7lxLy3JZ89W3yMDwNafVTWOUPfWoIDef0OzgQw8nVB2Sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U3bo49Wd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rXMG2Z09dsxVPz1ySWzPmMvuK9suEebz7Xj94z8NvIc=; b=U3bo49WdJkqQnHQFGpUaObggd3
	P5kvBkTE5IOQqT/8x0isC7sFsQSGIgZuPLqIdvXE6eKgBjtMvhXHANEx/aUpH5xQH3/Q103ADIghP
	JeF2ap9Zzked66JrRcWw4q1wYlpTVSL5kaKBFkGB6AB7zZc6tx0lAcfC/FZsHBfXG88Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYrA-009D3J-68; Sun, 06 Oct 2024 23:32:00 +0200
Date: Sun, 6 Oct 2024 23:32:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 6/9] net: phy: mediatek: Hook LED helper
 functions in mtk-ge.c
Message-ID: <3e27eddb-91c6-4903-9de5-f3df8098a38c@lunn.ch>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-7-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-7-SkyLake.Huang@mediatek.com>

> +static int mt753x_phy_led_blink_set(struct phy_device *phydev, u8 index,
> +				    unsigned long *delay_on,
> +				    unsigned long *delay_off)
> +{
> +	struct mtk_gephy_priv *priv = phydev->priv;
> +	bool blinking = false;
> +	int err = 0;

There is no need to set err.

> +
> +	err = mtk_phy_led_num_dly_cfg(index, delay_on, delay_off, &blinking);
> +	if (err < 0)
> +		return err;


    Andrew

---
pw-bot: cr

