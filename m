Return-Path: <netdev+bounces-104008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B143690AD58
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4811C218D7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FA5194ADE;
	Mon, 17 Jun 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+oBvuNh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62F186E56;
	Mon, 17 Jun 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625098; cv=none; b=jFbYqooPcvUgwuiQuzFebmWlrwwPaRHimB4fFP4pb4Q+SQaHQ3JY14gR308OAzXEx+ByvWV6UAcncRNHdroD36Gwv3XVEWjRWuA4WuYM5RxlK5bsn1F1P6r0+mW4JNEObqkR/ZLKmXGpcZc8NVec92DGLEVdqu5vkseCGL7nhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625098; c=relaxed/simple;
	bh=mc0bGXWJFZ4yGc+KJkzDwcQtkgRCAWRR3tEfYbXyIuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ7fikp+NpqEw/HaInpsrLWbCB1gXZRnCoI9AqgZ9NUDKtdlar1RwIBrYUjxh13yzDtENH4jpyUDqqMpSD/LTr3hX4QAunHil32keRAqVczxCTmL268MaF3xslfvTOwphAHdRZKEEDtDM0UmoUX1u7pgEeDh5uC452qZLyDF9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+oBvuNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9DCC2BD10;
	Mon, 17 Jun 2024 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718625098;
	bh=mc0bGXWJFZ4yGc+KJkzDwcQtkgRCAWRR3tEfYbXyIuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+oBvuNh6ziIKKRNICnMZeU0cB+khP6dnovw3xE/Ot4mNRf+Bqy1Ap8yu4OGexTcp
	 giIpK+xqCu3YiTLaXxTVSc/2ycOOCgiX53oHmtwE6cFiT8+aLwFdNB6N8Xyk5vqNp7
	 jpG4qKeEfyyzi2ifWAVyqBOamnVZJHP7FxApnNo+dNqxvfaSFW15brcimSJ/zjezD+
	 XkFwIdFyiJxaQ1uA9bExGlMv6B16ARH08Lel0W6QlZDKhG6ocLrFK61+o28wLm4Q2X
	 8fPPREB8kQHLQR8WxU97DEmoeCtQFNX9sm+OJsanfg4wMOrh8Bq2ILfqM6S0k7yayT
	 NOvGvtq/BmolA==
Date: Mon, 17 Jun 2024 12:51:32 +0100
From: Simon Horman <horms@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: Re: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Message-ID: <20240617115132.GR8447@kernel.org>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
 <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613104023.13044-3-SkyLake.Huang@mediatek.com>

On Thu, Jun 13, 2024 at 06:40:20PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch moves mtk-ge-soc.c's LED code into mtk phy lib. We
> can use those helper functions in mtk-ge.c as well. That is to
> say, we have almost the same HW LED controller design in
> mt7530/mt7531/mt7981/mt7988's Giga ethernet phy.
> 
> Also integrate read/write pages into one helper function. They
> are basically the same.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

...

>  static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
>  				    unsigned long *delay_on,
>  				    unsigned long *delay_off)
>  {
>  	bool blinking = false;
>  	int err = 0;
> +	struct mtk_socphy_priv *priv = phydev->priv;

Hi Sky,

A minor nit from my side.

If you need to respin this patchset for some other reason, please consider
preserving reverse xmas tree order - longest line to shortest - in this
function.

Likewise there are a few other changes in this patch which look like they
could be trivially updated to preserve or adopt reverse xmas tree order.

Edward Cree's tool can be of assistance here:
https://github.com/ecree-solarflare/xmastree

>  
>  	if (index > 1)
>  		return -EINVAL;

