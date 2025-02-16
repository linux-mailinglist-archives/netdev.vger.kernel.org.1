Return-Path: <netdev+bounces-166835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF9A377F2
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C727A3D09
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD5155C8C;
	Sun, 16 Feb 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gicE0ak8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AF33C5
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742986; cv=none; b=LX8JDIs2puocHgKVlxPhcJSHuMph81hIUDSvGyLO096qDAKyAnVu1pR0BBHyz9uh9U3tyJdPO24xNOO2UbUFAhBDFUy3ybOQWi6lUxwCyycjZquAh2451SiHiDBL9GT962inr7wzhjb0UEHhlK9CpvG1tEqrsmq/KRjK+Kv5CrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742986; c=relaxed/simple;
	bh=rbIS8gKcaUCM9cZyW1Fr+OEvJ/5tUOWl4JZwieirsdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQVG322mnDoB/t8kvWcEkAX1wbiz/NiPrK7xXo08yafay+S+6hI46Ye5tzOmbxgTavsVAmG4uYwNcQtc+Y/IQK5jzCx1FnYe2hi4frwyPoFrev8cL3Ysr4LRkfxyrE9dZcu+4Gu66AB6En00UouVhbPbgXqITF+P7/qdusRO1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gicE0ak8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KMEk890AOqsmQoSBuIsRKRSlkMN667XzqZHAtMlMEsY=; b=gicE0ak8XI8TSGE0YP7jfxuoGh
	oGjMLxnhwickRqrrxvGCNcjQCKPkmemozmih+QCIbBLF21L1n+Sp8bij/Gcq1WXiHby+44EiD5H4+
	2SmTH/CYDSylcvgwobHSCUTLB3r1XAERYpvot8q3sWDvFI5P8ee2ALabMpz6WB1+7iak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjmcX-00ElXl-6s; Sun, 16 Feb 2025 22:56:13 +0100
Date: Sun, 16 Feb 2025 22:56:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] net: phy: move definition of phy_is_started
 before phy_disable_eee_mode
Message-ID: <e955a760-6cef-4e4f-8198-c9a305a090a5@lunn.ch>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <04d1e7a5-f4c0-42ab-8fa4-88ad26b74813@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d1e7a5-f4c0-42ab-8fa4-88ad26b74813@gmail.com>

On Sun, Feb 16, 2025 at 10:15:42PM +0100, Heiner Kallweit wrote:
> In preparation of a follow-up patch, move phy_is_started() to before
> phy_disable_eee_mode().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

