Return-Path: <netdev+bounces-159629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D1A1632E
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FD03A56AA
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D61DE8BD;
	Sun, 19 Jan 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qcoQ99WH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD261184;
	Sun, 19 Jan 2025 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737306767; cv=none; b=WEfIJIBOl3IpxTxmAw+FhlgWEUf4Wa0qUCPMIHF4XB1DPXfRQvEt6/qWZEx6xOfAxrBdlRw8aLISeXpPcojxdsKbXIDJkMMh8jfquFDRXTiYO/ripHTHaZ5hjIdnYgDZmCjJaXjQ6BIBotmAGzvofLA4qjSph/NGO0h4Jw2NgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737306767; c=relaxed/simple;
	bh=Pw4Bi7a+mSDtZFDfjMtCoGSl6OjJ958L8/XQUm/6NjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7hNIusV0SIGuaG54eRLjBO/9QAhLLhGxxrHXSOQxQCjeHAsSYBwS6NwvXgc6z8aQz0ij8e9ohoWLkJcQkwkSdAX28xcckpUG5ESJ7Ksy9IDWMm6UcEFnh3pOKUUyrAVqcj3BBrqRGulK3HVr8pcM1lUpsHeuVhiXnFopnFc6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qcoQ99WH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cwa9u2fPg49cZpocEba1WtOgv+XdMwm9Yjg+x4Tw2Kw=; b=qcoQ99WHAN7cfwSzN6lDUgQrGL
	DcMMdKlPmI8yJe/ME+IE+OpMS4LIg6/MBZpp7TZXARng3wzB+n9UFeb7tOtPkMBwZpGAcqgW11+9a
	OPyWC45IwFc4Z4Ea4M+cBA7b2d8l09Jhynzp+CGM2wHu7Gk627RtcTMPKDxyKF+ZvpPQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZYqb-0066bO-BZ; Sun, 19 Jan 2025 18:12:29 +0100
Date: Sun, 19 Jan 2025 18:12:29 +0100
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
Subject: Re: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Message-ID: <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>

> +/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
> +/* MrvlTrFix100Kp */
> +#define MRVL_TR_FIX_100KP_MASK			GENMASK(22, 20)
> +/* MrvlTrFix100Kf */
> +#define MRVL_TR_FIX_100KF_MASK			GENMASK(19, 17)
> +/* MrvlTrFix1000Kp */
> +#define MRVL_TR_FIX_1000KP_MASK			GENMASK(16, 14)
> +/* MrvlTrFix1000Kf */
> +#define MRVL_TR_FIX_1000KF_MASK			GENMASK(13, 11)

What does the Mrvl prefix stand for?

This patch is pretty much impossible to review because it makes so
many changes. Please split it up into lots of small simple changes.

    Andrew

---
pw-bot: cr

