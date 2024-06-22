Return-Path: <netdev+bounces-105878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A630091359D
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8DB1F21888
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECA273FC;
	Sat, 22 Jun 2024 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ykFaPT4T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599861C294;
	Sat, 22 Jun 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081097; cv=none; b=mYID+ALTAb+HejthyykxxWjv+RSHVtCglBbwKC5WX9YpnS873QgNVOWVUEFmnHVKcVrRbMB/xFq91QFNgWBMtRr7ot2a/EhnFF9AT7E8uYxLRWTZRO0Lc+cwA5FrDNMjztATKe7POSKEfeo/UByrOsgKsvg/Qm0uQRzYl5LH4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081097; c=relaxed/simple;
	bh=mW+4vJ1tQI/8gjEcWUy/cZLaGCAzd8lV7SYw2zjiAfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6qItedg4DYqoko5/oEWM47pMPGOx4I/y8J+xpnojA2cjXXzof6w2zPatoTLNhp6CYgRxh0dp8FYAzfXfBuL/fR8+ZDKd9pQZMfL81ApzO3ZozaHhGjjD1XgYzo+eZAJtfYJK6k42m0Bf7PIUHmKKpQfa6LKJkuaHIUNwIz5A4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ykFaPT4T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SP6B4EIRqrajIl5UW80inICDhMtctoSu23bR4HxC0R0=; b=ykFaPT4TLCF6op/yM+c5upAFJl
	9zP1Jk9COu+k6QHLmEF446cQEFY3/5dMI7hskUtU8tsl/oePMjEJjU9mw7iHuuMW5M0k/78zwyOr4
	ce4dgXrr0ho9WG2xk4Zs96tvvhh7X4kD4ee/vw5AhaXrtk5KzVkagbsWivT+xxGTt8N4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL5WJ-000kEr-2j; Sat, 22 Jun 2024 20:31:27 +0200
Date: Sat, 22 Jun 2024 20:31:27 +0200
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
Subject: Re: [PATCH net-next v8 13/13] net: phy: mediatek: Remove unnecessary
 outer parens of "supported_triggers" var
Message-ID: <8ab10980-250f-475f-aacd-02510a3a03b7@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-14-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-14-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:45PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch removes unnecessary outer parens of "supported_triggers" vars
> in mtk-ge.c & mtk-ge-soc.c to improve readability.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

