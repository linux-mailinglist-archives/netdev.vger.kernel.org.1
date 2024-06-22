Return-Path: <netdev+bounces-105870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EB91355D
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481A31F228B3
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535A017C7C;
	Sat, 22 Jun 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wrAds5SA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2A15E88;
	Sat, 22 Jun 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077399; cv=none; b=VjAOFiu46dtlB2u6EIjjOBeFtwm7eC//5xA1/fyj25hi4QVZQJ4s0V25Vu2vzqgu+7FYR5rwSFidgmeOsBFdHqy2w68LJwI1q/ahZZ5+iWr+I81k0xehx/PXYPD/IffwWPa3bTz6Os7BSk0Dlw+yskmOWPthVVpQgmKvNllbfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077399; c=relaxed/simple;
	bh=dANH7hvp+WXm9Zg9xxdvrDY1Nk4QnHpdRV0KbZdEreQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLOeRIMj4TlccBdgTuz+gmz35XEyng3KlGVWS04X+kGfipDbdUp2044XfobB5436yOycZQWogQsnPnE32+UJuSy8heIeeTIVJWz+SDvtxw2dc970zEmkcTyrBnM6XsUMcR1b1XWQCCcgysnJsK1rbGqX6kWq366wytN5IeMIc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wrAds5SA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZK35UKRjoOKYFhurJCkNTHut1SmtzsCztmANaZj1AbM=; b=wrAds5SADLPr0Os1vmzBTGmoOi
	FxMvcYrCrTyie1niDYeLmFq1ZQs9kmr1NaiMt4PfQPUzvqv5EuGB3fLPPGfdr+aRUyuC7ghH5gWCd
	tXRhQD7YqIaO9hrQnjJ14fiZmW+9hPdTw+eng3HC4H4GRe68cRpJ44XXX4QsueO8WosQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4Yb-000k1P-BW; Sat, 22 Jun 2024 19:29:45 +0200
Date: Sat, 22 Jun 2024 19:29:45 +0200
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
Subject: Re: [PATCH net-next v8 06/13] net: phy: mediatek: Hook LED helper
 functions in mtk-ge.c
Message-ID: <e1ed191f-7c70-4c34-ad1f-40aaae18582b@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-7-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-7-SkyLake.Huang@mediatek.com>

> +static int mt753x_phy_led_blink_set(struct phy_device *phydev, u8 index,
> +				    unsigned long *delay_on,
> +				    unsigned long *delay_off)
> +{
> +	struct mtk_gephy_priv *priv = phydev->priv;
> +	bool blinking = false;
> +	int err = 0;
> +
> +	if (index > 1)
> +		return -EINVAL;
> +

It looks like this test could be moved into the common code. It seems
like all variants have a single LED.

> +	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
> +		blinking = true;
> +		*delay_on = 50;
> +		*delay_off = 50;
> +	}

Do the different hardware variants have different blink speeds? If
not, maybe also move this into the common code. Otherwise maybe add a
comment in the commit message explaining the differences between the
hardware variants.

    Andrew

---
pw-bot: cr

