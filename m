Return-Path: <netdev+bounces-132555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB19921A5
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6651F213D8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E316EC19;
	Sun,  6 Oct 2024 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CDDwfPPM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBE1552E0;
	Sun,  6 Oct 2024 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250212; cv=none; b=VSZbRH4+pZGoIKVIbbL34Y1moCUuew9+pZYlYLoDqDMD5b9QLFfaQD4urbxu3hXj0jJ9jvTZcm9GzB9WVIa3RY9+M2E+0xTaVGaL7u03CT7WhZw1tuqsayEAui9KHN595BaNwVhaXodk8VxpuDs7vNvEqIoMiA8JqMTBaIhpDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250212; c=relaxed/simple;
	bh=HkcZbobe0T77ZG/v3OCwNPybjSy+p2XhmJr8eAzGYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqBAFNrFaXauY0FV23XQwRbztj2B/+U7Wra0soI7Y/Sfc+HnqwxMwZjRDzfGRK0hcvfq1iSW+IqIlIESxU0HhCGs6p6vXJDMus49rs0UCX4WBDdvbOiE7JrrvVl+Hak4qZ7jCdbQy/hLDQhvHGme06m7n5cNOOYyX9ScnIPKKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CDDwfPPM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EgvA/9l6auZt4qcCNq+2MnBkMDpsGfgpkiJPvA3gtns=; b=CDDwfPPMH5eTARFVwdr6M+Cxlo
	U0tlT9Xpqm9MsNQeu965BfHZKuUOTsGwtEDZSKSyYws677w5M0TncXL7XMTftl5+tKTF5u+SMcDan
	6+qMe0zh91YdEHLjD38T84JU2VDJrIump+U6PDwTR57BUdyBPfKR9qVl7nbzLx+FKHng=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYpC-009D25-Iw; Sun, 06 Oct 2024 23:29:58 +0200
Date: Sun, 6 Oct 2024 23:29:58 +0200
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
Subject: Re: [PATCH net-next 5/9] net: phy: mediatek: Integrate read/write
 page helper functions
Message-ID: <b049fe23-ebc8-45a5-90b8-87a9378fd784@lunn.ch>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-6-SkyLake.Huang@mediatek.com>

On Fri, Oct 04, 2024 at 06:24:09PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch integrates read/write page helper functions as MTK phy lib.
> They are basically the same in mtk-ge.c & mtk-ge-soc.c.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

