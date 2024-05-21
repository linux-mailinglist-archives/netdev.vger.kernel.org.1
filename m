Return-Path: <netdev+bounces-97349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E28CAF3C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F64B20AD1
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD783D982;
	Tue, 21 May 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zFDyqK+G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297D1CD32;
	Tue, 21 May 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297360; cv=none; b=IRgMuSfJYXFHoB/wqKzmSP1o1bFS91INyFGgRtWMJhJoIWoxAtsYrM+v3CRG4UmCpeF2WwDACgiKY6C/t1mfiBNAbMmgpwWiC0LuDHojbZKY0ve+cqQdz5y8DOEg8cVQshqise3D725hCpRkghtm15CPTs/PeliQb3UCog96fB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297360; c=relaxed/simple;
	bh=IOeI3hHTxpKJRxqMJz94Ukn6BOnC5xNHpbHdHmceGH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ7Zt1Q2J7iwQjrIMcSU9gO29Rjvw67qzqrYQT2yAMD6Ch12QYXMvyTw86tTaurZterF9vXpyTCaOUruEHZfxuRpXLMus+mRWRLe5TUIxLQ31lQIDciohXwXvUStNil/RdgDXiceU3dGQOctFAyz7CuRhXFjpT7V5nLA9ngPAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zFDyqK+G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BFRehB/GDW22WEVdSVIndBEfguGCbpOMzZOO/CrlY5Y=; b=zFDyqK+Gfj3rf8gORrZJRRY6b4
	mfuVqCNU39JlBT6l5vhjeF+ZSDPOFpY4CAwAJ6rOIZf2R533tkFBYX0RvH1VM+rgG4tAua7x12BeJ
	R7/YdlQAEpSyDNOj5WUQgYTkalfcPrBpr+NJeSYqj5qgvH9bFcYPgGMkUsfm+FxNT8Ss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9PLD-00FlFs-Hj; Tue, 21 May 2024 15:15:43 +0200
Date: Tue, 21 May 2024 15:15:43 +0200
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
Subject: Re: [PATCH net-next v4 0/5] net: phy: mediatek: Introduce
 mtk-phy-lib and add 2.5Gphy support
Message-ID: <80186a3c-8e9a-4a7e-9ead-6773c0bf0ebf@lunn.ch>
References: <20240521101548.9286-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521101548.9286-1-SkyLake.Huang@mediatek.com>

On Tue, May 21, 2024 at 06:15:43PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> e-organize MTK ethernet phy drivers and integrate common manipulations
> into mtk-phy-lib. Also, add support for build-in 2.5Gphy on MT7988.
> 
> v2:
> - Apply correct PATCH tag.
> - Break LED/Token ring/Extend-link-pulse-time features into 3 patches.
> - Fix contents according to v1 comments.
> 
> v3:
> - Fix patch 4/5 & 5/5. Please see changes in 4/5 & 5/5's commit log.
> - Rebase code and now this patch series can apply to net-next tree.
> 
> v4:
> - Fix patch 4/5 & 5/5. Please see changes in 4/5 & 5/5's commit log.

Please slow down. Discussion on the previous version has not come to a
conclusion yet. Posting a new version just wastes reviewer time.

Also, we are in the merge window at the moment, so nothing is going to
get merged until it closes.

	Andrew

