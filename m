Return-Path: <netdev+bounces-97196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE98C9DD7
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311131C21163
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12B135A5A;
	Mon, 20 May 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z/KBZBgR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE61FC0E;
	Mon, 20 May 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210530; cv=none; b=KWqtW1aLuSpYKwNmR2S8ZpAnFDlXWcwlPjtzdMGRTIhAKNAJd5B7oqrx8YzqwajODeYZKAhKWD+jTSfUX359Cek2IyKZyxBTYMUBEC7P/U66prQt/k/QQxnPEL4H+ubYbbw3vuTsNN+rDltqTQ0WPlsSNd+GnCNvjvoLJ6FWEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210530; c=relaxed/simple;
	bh=2K7lbmcu3s6hJcwOPQ9FFk8diEPPTsdGyGbNERzgQuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQxb77RRsG1p3Yf9Uq1BQOqVq9yhKWLsO7VY5vWrPKtwD7vizKPnp2qYGhvTbPIShIKvFp1NTGwuvWJuGJ4oeQCss4FKlUNMc1AXOzsM2btwKiSZW7nfIhdg8Cn6PiKAcxyqCguok3ro65TjVwzIjZFUMCPVUuFkOCmNRRu/Rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z/KBZBgR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bHF3BtaLOWYPvtUAsE4ipGd1oB8QLh6bTIlXXHFYa8s=; b=Z/KBZBgR6vjxnU4+ybcRzSDNlP
	7/hfeviGZY6lEYm0rBVxDU5ncFfh/+d542Yr7KKP2A8Io1PJGCG9PP8O1sEskdAzQ1H4tDlyFlER5
	hkzJtAapnSPNS1i/O1ZZd1Qv+xk8PH9zWtW55CsLRlHZqwZfjjRNqa95JTIxT/eZqDKg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s92kn-00FhIp-OK; Mon, 20 May 2024 15:08:37 +0200
Date: Mon, 20 May 2024 15:08:37 +0200
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
Subject: Re: [PATCH net-next v3 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <f239d30e-dc4e-4427-b239-3736385dd51a@lunn.ch>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
 <20240520113456.21675-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520113456.21675-2-SkyLake.Huang@mediatek.com>

On Mon, May 20, 2024 at 07:34:52PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Re-organize MediaTek ethernet phy driver files and get ready to integrate
> some common functions and add new 2.5G phy driver.
> mtk-ge.c: MT7530 Gphy on MT7621 & MT7531 Gphy
> mtk-ge-soc.c: Built-in Gphy on MT7981 & Built-in switch Gphy on MT7988
> mtk-2p5ge.c: Planned for built-in 2.5G phy on MT7988
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

