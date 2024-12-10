Return-Path: <netdev+bounces-150464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E025E9EA4FE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F360A188BD68
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16F919DF7D;
	Tue, 10 Dec 2024 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4ZtsEtaD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA411946DA;
	Tue, 10 Dec 2024 02:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796814; cv=none; b=lD+2K9mXGRgzhTQjnqVGOO+TS64CJiE6l0dP6VVXReXix+oS/EgyzMLDqU1/TvvOsnQxMBSwQFhHNyL4i6PycSR6GGYJVrNmtd34ufr0/f5pWMqtR9fifEce4TjTLtlfghfhRJ3hMQ+IPHujs61XaJHDnX9m072xS5jNFt+6wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796814; c=relaxed/simple;
	bh=7O98vRtnaEdu730nQRwyeGUu0Mb0tOJM5Hi5VaUvqQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9qJ+1nOW/Ci8xATsUhzIgsQXs1jlVhfSAUxCC/k+A+ypGI/pRxMhtjgvqOSdzyIilFp1mQFglCqM0Yu0IPU09vaGDhF1LA4Tzxr+EbarlSNWENr+L4K190FMEgLrAWoC3LTmWGjrkuUzPCiz4Qp2F0Knv3/iZWVmKga9Xc4LGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4ZtsEtaD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ubAVteXO9Hp+IB+xrZH2DsQtgmSavWPrjYhzDvWuX1o=; b=4ZtsEtaDJM+Un6iYiOu2ljI2GE
	mXz35RqeLSEJSTrhKD9C9XOBAKlAFQxZ3u/gVK69z8mLY89LZJP5TvC/XZEYQ6xEVdaU4jcZJ61kz
	8lIdhdUC2Ag9hi5HJyQg/5cmFdqY/WbwQYWkMsXegsH4ZC0Nj7iAwpvRIxWMTa0h0/5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpkd-00FkAP-Aa; Tue, 10 Dec 2024 03:13:27 +0100
Date: Tue, 10 Dec 2024 03:13:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 11/11] net: usb: lan78xx: Improve error
 handling in WoL operations
Message-ID: <189487eb-dfba-4d1b-ae62-c25a7e5574f1@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-12-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-12-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:51PM +0100, Oleksij Rempel wrote:
> Enhance error handling in Wake-on-LAN (WoL) operations:
> - Log a warning in `lan78xx_get_wol` if `lan78xx_read_reg` fails.
> - Check and handle errors from `device_set_wakeup_enable` and
>   `phy_ethtool_set_wol` in `lan78xx_set_wol`.
> - Ensure proper cleanup with a unified error handling path.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

