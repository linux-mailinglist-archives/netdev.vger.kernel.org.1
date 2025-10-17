Return-Path: <netdev+bounces-230561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B96BEB1F9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601BB4E3C80
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138932C949;
	Fri, 17 Oct 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GrQYhuD/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803732B98D;
	Fri, 17 Oct 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723575; cv=none; b=N+nF0vakuyfJl4GP8dGCnZ3/v0tHql4/ZoTiglwYcqw+kEdMQg5dE7t4YD0WOqxzvTsZs5yOQmyJiV2EDzjxieKJG07A1XrLnO3sc2gU59J2r0MKrgSCDPzHKWtV7TqZJO8uCJQDHWMF09wISxpubA9Pd+0ziGh1HzJnJyMf/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723575; c=relaxed/simple;
	bh=/AAtJbZIzife83BhcEdb7e3iAJ1phzVX1WWoC7hBd/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiPCboHZaDJIXXI4RCKIfNnTtdTjzOAEWYSY5vcF+KxjW1tiFroB0OZww8GGRPwnIRFC7tqgRKI+uicjOiie/c7Yqt+XnFJ2nSppxw4+Wn+dXeJgGPbBNG/zruzZ0nDf2ACDqC1Kt92y7eXPSvuWQLChj+KuKb0I5Tf7Z1HDJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GrQYhuD/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=KmfJCjmokZLUjt62bEkcRDY2jCPPtEcJwREx2XHeVas=; b=Gr
	QYhuD/nT4iVGP4S1XuHaN+Xuln7kybBwVq+1wYr30kz2IRnK8o+yLRrvov5qXncw9fpQNTowY3vP5
	qNBfanGF/QX0ILq912ezOoNzLztz6ujF82jf1pDnsLHcqXZFECarNJ6qwdKTi05HCazcX2Vr1ILs1
	DGBLgOk0e9mI2ic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9od9-00BJP1-M1; Fri, 17 Oct 2025 19:52:43 +0200
Date: Fri, 17 Oct 2025 19:52:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 03/15] net: macb: remove gap in MACB_CAPS_* flags
Message-ID: <26db9699-f71a-4e98-8f07-286e333bbeb6@lunn.ch>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-3-31cd266e22cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-macb-cleanup-v1-3-31cd266e22cd@bootlin.com>

On Tue, Oct 14, 2025 at 05:25:04PM +0200, Théo Lebrun wrote:
> MACB_CAPS_* are bit constants that get used in bp->caps. They occupy
> bits 0..12 + 24..31. Remove 11..23 gap by moving bits 24..31 to 13..20.
> 
> Occupation bitfields:
> 
>    31  29  27  25  23  21  19  17  15  13  11  09  07  05  03  01
>      30  28  26  24  22  20  18  16  14  12  10  08  06  04  02  00
>    -- Before ------------------------------------------------------
>     1 1 1 1 1 1 1 1                       1 1 1 1 1 1 1 1 1 1 1 1 1
>                     0 0 0 0 0 0 0 0 0 0 0
>    -- After -------------------------------------------------------
>                           1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
>     0 0 0 0 0 0 0 0 0 0 0
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

