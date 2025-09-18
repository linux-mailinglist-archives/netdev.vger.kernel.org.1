Return-Path: <netdev+bounces-224551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE6B86047
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBAE3AE58F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724863112DD;
	Thu, 18 Sep 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gC3GzEZp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254D307AFE;
	Thu, 18 Sep 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212600; cv=none; b=TSo46fvSU7A8S6oPb6xo+9DA153wvflj1KOvELI8ay6u6AuEAZWqcil+Bt9t98DS7V2dMEUtL1FyfN7Yd8GwWux6n4yd3iIhWBRb8Nuj6BHD2D+p2sBPA8K31kSN0L446gir9YSoVZTJWih/GzFqZDqTYW0CaRY7JDSawIzBn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212600; c=relaxed/simple;
	bh=n/hd5t6CHABWdzF41a1SUfYrY33AjbVj4GD6gVVNiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnpyDxQNGIXHd72r/jF6ONaM9Fr6oSG2WCn9H3w+C7iZRGrnr7is8wlhI2KdtCm70RvG2vPUuXk/nV5kCX1l2VtWl8k/qarGlrLDisp+8LpT6Z7Wf4DGABz7GqfWfiDSRqUT9kSxTCcQlGauRdtlk3yRu0KkzjTSlnjgnZaYNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gC3GzEZp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=auJypmeJ+OauCPuHoVkkb7kVeyHnCM7wOf2csNOyrVY=; b=gC3GzEZpYgzgaODE8Qx09xGxd5
	aKmaCrfkx6RvRQi5dtsT6j6wCHLtcxDGkrAWRmeyif2AuS15ZLiOHDkw19LuQPA/tUPgqAyj81VBA
	y/ODtYc1TLaYdO8IvF8nF24U9CTIWGwrv92jSCr/g8N8c4KlN1lH8J0Y4kBFbBHye7jU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzHPN-008qth-Hn; Thu, 18 Sep 2025 18:22:57 +0200
Date: Thu, 18 Sep 2025 18:22:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
	anthony.l.nguyen@intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, inochiama@gmail.com,
	0x1207@gmail.com, boon.khai.ng@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v7 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <28e282d0-ca3d-43ce-8c10-3517ca963a3b@lunn.ch>
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918090026.3280-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918090026.3280-1-weishangjuan@eswincomputing.com>

On Thu, Sep 18, 2025 at 05:00:26PM +0800, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add Ethernet controller support for Eswin's eic7700 SoC. The driver
> implements hardware initialization, clock configuration, delay
> adjustment functions based on DWC Ethernet controller, and supports
> device tree configuration and platform driver integration.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

