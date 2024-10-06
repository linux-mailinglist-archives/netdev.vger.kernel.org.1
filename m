Return-Path: <netdev+bounces-132557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9859921B2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081831C204DA
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B7171E76;
	Sun,  6 Oct 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LAwA+vDM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A41714C9;
	Sun,  6 Oct 2024 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250372; cv=none; b=QHPSZaUljsaBDPMitfNAeCPWP3HqfRCRTKRdCa6F7p12YD10cE1wbYOoYpnReXf1Hv8MQ+IIMxBsp+VvQMYgQIG+Ly/RyDmlAxK23uxF9lqtWWiWw6g41BAf5vinAtXx01tfF5gf6/PGQXbb4rlVdwe/P7FaqOqqrA+K4479MdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250372; c=relaxed/simple;
	bh=mU2hB0cmalnXq1+NX1pqhGYQiTsgOp5W2v7gYpTruwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViBdck2aBoL2RFeHm+ebeFsk4KGRwWUruhgRZ3pTfMksatGd6jcrLqa+8vqW5/UN3UHmT4JXK4ZsHOvMMgDSmiKectKld4FEHpyecDWjzgNd8ArHgJuaLBWJs1dX0pqqqk68Lastsh+Wttam7x9Ea0NrXdDZOFp5mdQ5sVSozlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LAwA+vDM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QjAiG+gB78HjMWcOMiyB5jhJywd7e5WoZXeGJ9LHNpo=; b=LAwA+vDM/Uwf6VV2pugcuGmLH0
	B1MjzRrUsSf4dr8pj7zEYJ++koJooLjAwW2xuPRHRlcZPCxmuE8Cym6Pn0H3OnceeTuP2Z7Z52N3t
	UmbcxWKLY4TEeInCJTZf1xdvsP5jRHFxG/CaLT4hM2m6DC+eLC1+Y+jmD3jiHvp6F4XU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYro-009D4Q-40; Sun, 06 Oct 2024 23:32:40 +0200
Date: Sun, 6 Oct 2024 23:32:40 +0200
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
Subject: Re: [PATCH net-next 7/9] net: phy: mediatek: add MT7530 & MT7531's
 PHY ID macros
Message-ID: <be92c617-8293-4ebb-876f-18d17dd95093@lunn.ch>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-8-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-8-SkyLake.Huang@mediatek.com>

On Fri, Oct 04, 2024 at 06:24:11PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch adds MT7530 & MT7531's PHY ID macros in mtk-ge.c so that
> it follows the same rule of mtk-ge-soc.c.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

