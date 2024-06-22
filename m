Return-Path: <netdev+bounces-105877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927091359B
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9AD1C20D78
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987B219E4;
	Sat, 22 Jun 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2pEnDPoR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A89470;
	Sat, 22 Jun 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081076; cv=none; b=OhP9B+cqhmeLWR9fiFTBJlBtF7Nc/n4jmNwKbPqOCxnLcWcw4A97lXADOzk832lehJcNkdsTtLE5UB16S2euCpH7RufNT5ml0iGjfzgIOZyGLqA+mdg6PMjmZ95V6eKDlDnbMfpzUqjDUD6Bzh0g0Fvhd7DKzzHWvcy5yrcrqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081076; c=relaxed/simple;
	bh=Bu1c4TBD78MgTL/+Ueid/B5ectKfutMf9Op1U3dKYb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itxV5JySgoZCrWQEanGInILFt63gOE8H8VmeF1T/cPKoVuJtj/YNF2JezaOYozkQG9d/ZEI9RLDysxRORDGQ5ds4WH6C2jHYb1++Yf1cvzdlMHCEt2OEFuj/SQ06swZblwmRUlAjowo7M/75tWttO706eyK330ECghjMp13ULFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2pEnDPoR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7fIMwbUzHN4iz5w0V7HIL86j5pwhlLZgaN9zrCy1ciM=; b=2pEnDPoR0Majl9M3HZM1qbMsw5
	rgv3cLtbDjMrupC7vkdbgk2OII3A22nkK9G7dfDTZw3hLG0ucndqT9wMLpGdpy8YjAFXEjd2M3fxC
	7Q5Q9gpmhq9++wk3Cxp3EOC8ew6ToCvshdgpUyKQGzCAlELqY/pFX+vyI7Kq4F52MGj8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL5Vq-000kE5-HH; Sat, 22 Jun 2024 20:30:58 +0200
Date: Sat, 22 Jun 2024 20:30:58 +0200
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
Subject: Re: [PATCH net-next v8 12/13] net: phy: mediatek: Fix alignment in
 callback functions' hook
Message-ID: <2a040d91-3514-4502-b6d6-7c147f91cf6b@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-13-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-13-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:44PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Align declarations in mtk_gephy_driver(mtk-ge.c) and
> mtk_socphy_driver(mtk-ge-soc.c). At first, some of them are
> ".foo<tab>= method_foo", and others are ".bar<space>= method_bar".
> Use space instead for all of them here in case line is longer than
> 80 chars.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

