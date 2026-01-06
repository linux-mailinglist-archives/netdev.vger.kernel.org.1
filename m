Return-Path: <netdev+bounces-247360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B24CF863E
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 288553015838
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38832B9A8;
	Tue,  6 Jan 2026 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4nE8BVg/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2B32692D;
	Tue,  6 Jan 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704059; cv=none; b=u3xZKxoNjx8wPdj2OLG4RMl4YbA7T/N+PX6LdladecpQaZdvyzzoEFQFedyQ8NGO+heyZaa8Aq/paV0gipKbl1juMYQ1qnV9QNWn+XvYERUEng8jsD9KIWoLo3FR51fAPqGb5NHle5jdy3Cv01u9Cf9h2igIwZs64ybmg8dd56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704059; c=relaxed/simple;
	bh=93gh9+VDzi+8yVCF9d3h6WpeiVbzmwxN2sfEx8EWLLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWkZutlSeV02PFuxNHWEl+ejSXUVZnoWpCJo0EpEwIUVLUpZKUSw0Y/YJpypX8pRTj0lxSZZK8wCqui9ACK6QdXbaD0Bzk8oxq0KzUsJ3blBBHBv0yo+J3cKPtAYemaLKqNEok+G6CV9r97GEHWMAwxgAR+TCRCD8T2HuGcoqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4nE8BVg/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tDXsteGd4Cd3IMBJ9PXzx1xR+9oA/9cQlHgLCmWx+qs=; b=4nE8BVg//+OMorD8xMCIyVHC02
	W4/0GzmevQaE8BzZ7nJaciCxEGdrQCITrSBTrtosro+0mawZGZk11541DkmNqaEBXhjGypLRMnkE/
	MWz5ZPpqrzGQAh53AKYfgdGx5J1sxON6qp+nfApesWHvQDuvM1OHQ7Qv7HvLfyZDX5Iw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vd6ZH-001cPO-T2; Tue, 06 Jan 2026 13:53:47 +0100
Date: Tue, 6 Jan 2026 13:53:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] net: phy: move mmd_phy_read and
 mmd_phy_write to phylib.h
Message-ID: <e957ec9e-6732-4229-872f-e961be3d6c56@lunn.ch>
References: <cover.1767630451.git.daniel@makrotopia.org>
 <79169cd624a3572d426e42c7b13cd2654a35d0cb.1767630451.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79169cd624a3572d426e42c7b13cd2654a35d0cb.1767630451.git.daniel@makrotopia.org>

On Mon, Jan 05, 2026 at 04:38:29PM +0000, Daniel Golle wrote:
> Helper functions mmd_phy_read and mmd_phy_write are useful for PHYs
> which require custom MMD access functions for some but not all MMDs.
> Move mmd_phy_read and mmd_phy_write function prototypes from
> phylib-internal.h to phylib.h to make them available for PHY drivers.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

