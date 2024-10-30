Return-Path: <netdev+bounces-140557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2009B6F42
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 22:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0771C225E0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847D229137;
	Wed, 30 Oct 2024 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6ODvVexG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14CD22912E;
	Wed, 30 Oct 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324129; cv=none; b=a30VHXvg1D2VhilfCri+X0BW3DvXF1RC34optJquAyFTOx6JisD705QQh9rqWNhjEEIZEuYE9k897l9Z+08//DVGsch7wvqGdc7eH73aJOKnQbRW3lUNoxU+Y/oo6IVci//LjOXLKVKCJYemaatMcatI/JwrMXieweJKEYvWiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324129; c=relaxed/simple;
	bh=rm1fOaMV8+ZvaLA3SVdwxChD9HtTwnn7bmt8JS4Yi6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/pvKI5pjZE5XZ+Ez5+pH29Q2svKs817MuMQe77ilTZq0XAa+VD2ELTYzTykqQRFN4slt1Nq/+uEKu/3W4Bj+5moDUSPXbRJZdTJ30Pqc6NIUkRbduuIt/RX5hZDkL3uyVTnbmOom42SJy6JHUmJjv34V0FTSPR04myskgzxRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6ODvVexG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NyNMPjO7MMUd6ojdX9/UDWNYw2O+FoxGF7IwqpNjl2U=; b=6ODvVexGP24auXYynC9wLkGhzw
	Ij5b5N2p3PUMIHkDOtE4nr8am56jtAaFUhmf/2F9T8z891JnfVvg327KEtn58HBHyEZ050bRc/cTP
	08HGvuZ+j1tH62+k+BM0/SYAdhM+Lp5LpgXMRSsVm2j+A2zLM7zJCLN+myVyboiCPnAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6GLP-00BjTa-At; Wed, 30 Oct 2024 22:35:11 +0100
Date: Wed, 30 Oct 2024 22:35:11 +0100
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
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <cd2f249b-6257-4692-ac2f-93252534cff4@lunn.ch>
References: <20241030103554.29218-1-SkyLake.Huang@mediatek.com>
 <20241030103554.29218-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030103554.29218-2-SkyLake.Huang@mediatek.com>

On Wed, Oct 30, 2024 at 06:35:50PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Re-organize MediaTek ethernet phy driver files and get ready to integrate
> some common functions and add new 2.5G phy driver.
> mtk-ge.c: MT7530 Gphy on MT7621 & MT7531 Gphy
> mtk-ge-soc.c: Built-in Gphy on MT7981 & Built-in switch Gphy on MT7988
> mtk-2p5ge.c: Planned for built-in 2.5G phy on MT7988
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> ---
> No change since commit:
> https://lore.kernel.org/netdev/20241004102413.5838-2-SkyLake.Huang@mediatek.com/
> 
> Andrew Lunn has already reviewed this.

You should append the Reviewed-by: Andrew Lunn <andrew@lunn.ch> to the
commit message, just before your Signed-off-by:. Taking the patches
out of a series like this should not invalidate a Reviewed-by, so long
as you don't make any changes to the patch.

    Andrew

---
pw-bot: cr


