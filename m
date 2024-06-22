Return-Path: <netdev+bounces-105867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7D391354F
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548A8B20AB5
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8085883D;
	Sat, 22 Jun 2024 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K3rxZIzW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60482179AB;
	Sat, 22 Jun 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719076612; cv=none; b=Rt4n5uZHNICAfWzyjRhA6uRU1F18xxXKPQigaByP4lr/IZ84NSQ2OwRDyrJz3g3AhWufIpccZFMJ14vD9RiCiPFx9RYWVb+ElToWavxU9qx/aXdszHs7NZQcWmOvspYIGT1HHBpmrshT/ReP8sHrwt5UfJTnznbozHn4gBbZNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719076612; c=relaxed/simple;
	bh=zsGmUagLnivs/4FDlELqCqbvnDCZNgVnefnumCKmwyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et627GXH8PQVQDOrsyAwRjZeo6FOWmtRQb7tgw5X0szmtBLtv3CsoqdloUjUwSzLZ1l7xqMiTcOIBWLfleHA4xtqr+tVxwH9DKZQmwV/NKTGENRT5EycmmnLa4pDow9yh1pRtmNx+jFS51BEiPAyKLwG7nattNiSFPc5MT6q0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K3rxZIzW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YoD/pwtVYuvdX+OKMVNTg6bIq6p1zqS47s0pFLwsBFg=; b=K3rxZIzWiqOqJy0ttSnuxlA0ul
	O1UYuOquEG/QNI9kg+A0eyQhpNsa6wpcJEni+J8K57iWLy28WuEty05FM05Wuv5fVMqMATNS1XEYi
	cbD6as6xKaMrK8W96rPN/+0MF4Kfg15+JWUZ6tERG9qhBt+iZzr+9VqCCQDfovki1AZ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4Lx-000jwS-2e; Sat, 22 Jun 2024 19:16:41 +0200
Date: Sat, 22 Jun 2024 19:16:41 +0200
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
Subject: Re: [PATCH net-next v8 03/13] net: phy: mediatek: Move LED helper
 functions into mtk phy lib
Message-ID: <8726efc3-83e6-4246-852c-994fd9ed8224@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-4-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:35PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch creates mtk-phy-lib.c & mtk-phy.h and integrates mtk-ge-soc.c's
> LED helper functions so that we can use those helper functions in other
> MTK's ethernet phy driver.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

