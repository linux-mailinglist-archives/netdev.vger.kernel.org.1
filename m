Return-Path: <netdev+bounces-230705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24DBEDD15
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 02:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D54E4E2047
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693EBA41;
	Sun, 19 Oct 2025 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AcN5Xqb1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BE1373;
	Sun, 19 Oct 2025 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760832292; cv=none; b=H4YfrTCq9HkHScBz52/KtK+xXtgjUBFBWvb5vU/VeZLEmrOSl1xA09umYg0sGwHmWobsQhUGkl5Y+ESFILH1iLNWCC3rRVNqY/TB3zpRxVTf72mRRv5FdUdxYuLzY2/l7rB6qkF5OWY+qHzxhZExeUkQWsiFIJFz0QURj+ptUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760832292; c=relaxed/simple;
	bh=NIlHXsTrn95hUwIwQiqLjVMv/ZLorBcbB6zrOrzvKRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azlLtUvIldOUCNdMWB+Oarka9+d9b0tA9s4MGjCLArulDOHl6wnYz+nChXHlBIvapq/sg/2GUSAKEYWmCD1zBfYF/YGiCZnN6r399oUkorQwuReLX2MYdgqR3IE929Zt3nLutYYwb6WM4cWSO03ZyvsZq82z2VDlekfHDvetnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AcN5Xqb1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rz0DjI9FG3R+Vf1dNEL5GbVU6jXA/C1j8hwA+dUf/6I=; b=AcN5Xqb1JNtWQtEk5ZUe7Vs44j
	z6+QascX8RZXSMzyNmZzlFs0g6XLvpMzTZ0U8eTgVmWGTWkCOapk0xir30PnWmjZ3UOLRQTKoWVuS
	ukLu99pJOm6qI3+yfv+f7nNyf4DISn160d2zMZr8VTYh9aVfCTZXUGhortzxREz4zatY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vAGu2-00BP9M-KF; Sun, 19 Oct 2025 02:04:02 +0200
Date: Sun, 19 Oct 2025 02:04:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <370d13b7-bba8-449d-9050-e0719d20b57c@lunn.ch>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>
 <i5prc7y4fxt3krghgvs7buyfkwwulxnsc2oagbwdjx4tbqjqls@fx4nkkyz6tdt>
 <c16e53f9-f506-41e8-b3c6-cc3bdb1843e1@lunn.ch>
 <aPP9cjzwihca-h6C@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPP9cjzwihca-h6C@shell.armlinux.org.uk>

> "rgmii-id" doesn't mean "there is a delay _somewhere_ in the system".
> It's supposed to mean that the PHY should add delays on both tx and
> rx paths.

When passed to the PHY it means that.

However, DT describes the hardware, the PCB. "rgmii-id" means the PCB
does not provide the delays. So the MAC/PHY combination needs to add
the delays. We normally have the PHY provide the delays, so the
phy-mode is normally passed straight to the PHY. However, if the MAC
is adding a delay, which it is in this case, in one direction and
cannot be turned off, the value passed to the PHY needs to reflect
this, to avoid double delays.

And because the MAC delay cannot be turned off, it means there are PCB
designs which don't work, double delays. So it would be nice not to
list them in the binding.

	Andrew

