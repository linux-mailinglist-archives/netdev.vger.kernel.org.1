Return-Path: <netdev+bounces-105868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1843B913553
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C703F281023
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285601799B;
	Sat, 22 Jun 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vwtXfi4D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD7B674;
	Sat, 22 Jun 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719076652; cv=none; b=Sz5sDIz+VlrIxL4cDleECRUxqap8fnoCwJdmFEufokShRccSf/regt30fn3xc4kzUu6JQjJEK+86H2D7Tu61xAuLHzwMtVCTst6OBP/CWBH/U3v1+2qrxSRyIDwUFyq8VKz0bg3F+E2bCpmKhSxxoOntqrvlpLQXEfOA5xs6/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719076652; c=relaxed/simple;
	bh=A7NTukUeUTbxIe/jvbifWpqsoqmRZRG7eur6UTbhqGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7DSKJmBdvu3UjSwTgsioTNB4ZJa2fld9Rx9a9vIhWowd1ANm825dKQ1TzMLdEhZgHyjNp/YjaWi3ESZAbQSEQtCOr5Gk0abDbRAwhVQGiGEBH1USif1743YvKuz9i3DWsW3vk7knM8nVcjEBk5iR/mn2HQ4JG0/22ueAS//nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vwtXfi4D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2E3OxTGXpjA6c/uZTQwY7Hec6L2/Z3L3S37SoGDANsI=; b=vwtXfi4D6EZw2pkIVasMYmBkSb
	GJn68XY+bPRE57V1+J3a+5ZjuT4lXjwYDl9DoZx4cd8AB+nkY5X9RDVCx6Oi788y0hOF16YX9mF64
	2kjnxb6bnxp4clsyGfo0d/XGkk0aWJpz4frBu01xhvhOoRm0ZJtCwLHZoU9bl5pYWqqA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4MZ-000jxU-Kr; Sat, 22 Jun 2024 19:17:19 +0200
Date: Sat, 22 Jun 2024 19:17:19 +0200
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
Subject: Re: [PATCH net-next v8 04/13] net: phy: mediatek: Improve
 readability of mtk-phy-lib.c's mtk_phy_led_hw_ctrl_set()
Message-ID: <ae10d557-be1f-47e5-9c2c-4d71d1131919@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-5-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:36PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch removes parens around TRIGGER_NETDEV_RX/TRIGGER_NETDEV_TX in
> mtk_phy_led_hw_ctrl_set(), which improves readability.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

