Return-Path: <netdev+bounces-236784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C3C401F3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEA2A34E2A0
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724821E32B9;
	Fri,  7 Nov 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EXytYuNb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4A1E8329
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522242; cv=none; b=q6o+/Romxlv8Bd97dIh2nnqe60UvKNetjhxTCzrlxbsrv9eSGqe+oTmEidvKmmoVKe3L9YqTBYVFfm00snksuHXiYO7D8zLrcQfP4GvqHwqwRy1tWL2KeVr7fujzADO5PkxLmY4N2S57fESGJU8/ELbJUMAsyea1lbTMRBwcGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522242; c=relaxed/simple;
	bh=CB8LxivVfoJzTOIyp28RJYHNs0uHzInSlkVyRrsqnU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5eEP8MtRt9c7/wuCU77/JVN1pUwA4XQVOHQqANeHK1MzYPb6QMi+Nj0xX2Sk0KjjAJGYUEH7eDP246bczjLkz6AAEUZNoPfrvk/w3ZLVndS0QciKx+bRT6960OYwI6cL6EtNe081gbTWA/lpxU8qYT7BX9V0f0ecOoItdSrlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EXytYuNb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wCtHp+RTMDsXZkrypzcXqyWr80jozipO654ec5rQnQc=; b=EXytYuNb9nGQfuqYqwHInjD5lI
	Qc9/85uKbg2wJ+mv/UHeCH3i0ywv7kMZNFlY+oCOmxxw2rzmrnbr4YGTXO/psB91iLCEPgWad/l8N
	yYQnahrGBK+BpsaYN9rkwgOzyzK3ZbxtqTiO8rzEF8E5sTj1g43ky/GEJSbjNCph3NMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHMY2-00DEKT-OF; Fri, 07 Nov 2025 14:30:38 +0100
Date: Fri, 7 Nov 2025 14:30:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 5/6] net: phy: realtek: eliminate
 priv->phycr1 variable
Message-ID: <4ce87e6e-ee6e-4d3c-a5f0-73081999f5ea@lunn.ch>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-6-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107110817.324389-6-vladimir.oltean@nxp.com>

On Fri, Nov 07, 2025 at 01:08:16PM +0200, Vladimir Oltean wrote:
> Previous changes have replaced the machine-level priv->phycr2 with a
> high-level priv->disable_clk_out. This created a discrepancy with
> priv->phycr1 which is resolved here, for uniformity.
> 
> One advantage of this new implementation is that we don't read
> priv->phycr1 in rtl821x_probe() if we're never going to modify it.
> 
> We never test the positive return code from phy_modify_mmd_changed(), so
> we could just as well use phy_modify_mmd().
> 
> I took the ALDPS feature description from commit d90db36a9e74 ("net:
> phy: realtek: add dt property to enable ALDPS mode") and transformed it
> into a function comment - the feature is sufficiently non-obvious to
> deserve that.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

