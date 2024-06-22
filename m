Return-Path: <netdev+bounces-105874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5591356F
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A781F2243C
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44836101E4;
	Sat, 22 Jun 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K9bBFnDX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54B2F34;
	Sat, 22 Jun 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719078380; cv=none; b=duw0+gg6fO80z4rLfBTVjJuzceCrkrEBMSB7SkmcPTLXSEsqaSyxyBgz5kRCyw7I+yl8/f3+757hbtuqtlBFESYyaoLEc/oZSqFi1f9VNxobwk6Z58mw+SoZvILkJaHttzK7mCx6M8EsPH7m5ZDDXPpBJk5iSdRfxSeTSMFoFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719078380; c=relaxed/simple;
	bh=f2OxD6XvjLv7pbvaMrqEE0xE2vjjwW9IXNlM9ijNyyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNQKQwlNMzNg86HJlR97hNxZkEHmsr2rzm0sz1yK1yMaFEr5JMSFqMeRKpAIaNxCFJ2u68XbfZB0wNNDkSJd/V2WzjWd1rFcETnXvJ0waETjt2xlDZPxh9qDY+b675El7GTNZ9JpccKCWNZNmgGKU1mlCSFDIZlMnTumeSkJQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K9bBFnDX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OcgMK+5YJcdqMyiYP8fkeg/M5NHnhiFXPSXYcM43Mq4=; b=K9bBFnDXh7iz3AI37g7bBLc//t
	o2tA0mm4p2wQdTuMpABmoHHCqLV0/q0pwQj4utVv03lAzNzFaj2bIgw28nMpoJ8PKLacO9FBMLGBm
	iAOPND1nAt4HmpHtCW5Mj0e1mqxGDOrM7wsaniT13LSWzvL4HpplAOiKrtpNCTGgF9bU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4oR-000k6g-IV; Sat, 22 Jun 2024 19:46:07 +0200
Date: Sat, 22 Jun 2024 19:46:07 +0200
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
Subject: Re: [PATCH net-next v8 10/13] net: phy: mediatek: Extend 1G TX/RX
 link pulse time
Message-ID: <931dec9e-e1c3-496c-9242-e5b24595a409@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-11-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-11-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:42PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> We observe that some 10G devices' (mostly Marvell's chips inside) 1G
> training time violates specification, which may last 2230ms and affect
> later TX/RX link pulse time. This will invalidate MediaTek series
> gigabit Ethernet PHYs' hardware auto downshift mechanism.
> 
> Without this patch, if someone is trying to use "4-wire" cable to
> connect above devices, MediaTek' gigabit Ethernet PHYs may fail
> to downshift to 100Mbps. (If partner 10G devices' downshift mechanism
> stops at 1G)
> 
> This patch extends our 1G TX/RX link pulse time so that we can still
> link up with those 10G devices.
> 
> Tested device:
> - Netgear GS110EMX's 10G port (Marvell 88X3340P)
> - QNAP QSW-M408-4C
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

