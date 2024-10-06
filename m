Return-Path: <netdev+bounces-132554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2059921A3
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DA0B20ECD
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245118BB83;
	Sun,  6 Oct 2024 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MPRk0YC1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249B16E87D;
	Sun,  6 Oct 2024 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250153; cv=none; b=iglRqj6+UDbnwUW2UcTrehUzCTEwOCGF+UqPEn2RU2Me+6qyPzSv0q00C62NYTAV65wv2tOELgmzIa8dJ3JXy+X85sHqbCzoVp1KQWyr9YDpPtWWm6xXlHuEHL2XTWRsBSx39sbjnopNN37ARamaUbJf2DM2UuCsmAvdr7jJ8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250153; c=relaxed/simple;
	bh=LJgXNrHE5Kp9xyq2WaecTex/dR7Pio2nlZ8ptov0ghE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5/kNr+yKFVtqNEt/rFG84RjF8KO92nfWWXjNEDJgO3O9ksCdqBsscVXDTLus6FPFhl+bhvtQw/xH+EB8A9TT6h4SfQbKWTW9lJHO2QPNiT1v864QisJP4ZUQD2KIXvhMXXGugy6cXMDP+ACb8eLoV+eXMkaouqSb0Z8do9wKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MPRk0YC1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Vwp7jhZ4eQQwPerXpo3ib5yaRSU7+t7Wsu3NKWXK2Q=; b=MPRk0YC1cos8akG/wY+ouuWX4D
	v3bxw0qU5eparRFgI9WqJQwJIMLWOxador8xuSMN0uO1y/TCG2kdt059mcruzE2YrHIqBBEofAV9N
	dvpklMBid1posalHqGnxXvwG49MyqYm3cKbdeKFS+ymEzGc79uJOLdm7jZR6Dpu7b+OQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYoH-009D0w-Pr; Sun, 06 Oct 2024 23:29:01 +0200
Date: Sun, 6 Oct 2024 23:29:01 +0200
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
Subject: Re: [PATCH net-next 4/9] net: phy: mediatek: Improve readability of
 mtk-phy-lib.c's mtk_phy_led_hw_ctrl_set()
Message-ID: <33996c3f-f2ae-4fea-90ab-38fc805f5aaa@lunn.ch>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-5-SkyLake.Huang@mediatek.com>

On Fri, Oct 04, 2024 at 06:24:08PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch removes parens around TRIGGER_NETDEV_RX/TRIGGER_NETDEV_TX in
> mtk_phy_led_hw_ctrl_set(), which improves readability.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

