Return-Path: <netdev+bounces-159647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4126A16368
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 18:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18997A1D42
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892281DE3A7;
	Sun, 19 Jan 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c36Dp0WN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9E4502A;
	Sun, 19 Jan 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737308147; cv=none; b=CHcERtahcGNUR4k7VrJU+TqYLclDXGiuWjBMeZol8pmLDlAyKwe+haTN7AhP+9fb01SNlGL8sZCJkblaThmXJBaJ/xPxfmmPba2IOyNy4I8ROhRzXVq37cZSG4yByh2CdElCFl/edBAxvgU9DZZZYJ+USLXS/kGzo3XOgmHAAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737308147; c=relaxed/simple;
	bh=u1ICc0pvW0VMq2Ms7e/2f3/ASo1hJ+FtHBSDtEkuN8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM1/8uvu2FQWdEyxSFd/LRTCLap3I6VgSixQrqT242GXyDcW2nnGXOObGdOGK168isneE84AsedvGRSSzgxBYi9ZeWUpETc20JhKadRoci57WapCc1cuc87I/ZBVzTm37VKDu85Lbi/l4ffD5pqOSEEXkhviqAFPiaTmc2FCVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c36Dp0WN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zcyrOMr6zvuz/PUU6lJSLE9ffbpG6Aa6FrDGrG0kTrg=; b=c36Dp0WN/a+gMwnf0aWi3xcE4w
	ic4ZR8EMddMMANdQv7A4gbrEyTpzfF/m2MC6Jv2B4H4b45iIzIUhHPnqx5EzgtVlwLgxsUF64FE0h
	+zLyznJUiM5fP72AXql0RVleiDIRZq512/CF/hMUeoqkhVxWwwEBD82nTTPAXpFm7xqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZZCw-0066wg-T0; Sun, 19 Jan 2025 18:35:34 +0100
Date: Sun, 19 Jan 2025 18:35:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Message-ID: <c339e887-b576-4f0e-988c-4cd8f27d47a7@lunn.ch>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>
 <Z4hnv2lzy8Ntd_Hp@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4hnv2lzy8Ntd_Hp@makrotopia.org>

> Imho it's fine to add the driver without support for the LEDs for now
> and add LED support later on. But in that case you also shouldn't call
> mtk_phy_leds_state_init().

It is also O.K. to hard code the default LED meanings, different to
the reset defaults. But you need to think ahead to when you do add
full LED support, you want the defaults to be something which the LED
subsystem can represent and take over when it controls the LEDs.

	Andrew

