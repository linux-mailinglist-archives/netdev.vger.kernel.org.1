Return-Path: <netdev+bounces-163704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DDFA2B65B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242443A5641
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD682417DF;
	Thu,  6 Feb 2025 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mI0BvOGB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA282417C0
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883182; cv=none; b=FRVAW2TC41v2MUxVNnjoCC451GH4Nbm3J4835HVSaVKYnfofiZKNmtHw68XwSIvp+RHxcIrDwOpA82xE+ykUPo4/mJiPuWLzexwls3Ks20sjQ8rBeQ5r+Hom6vgpeMNU3MLLBWPrm5x1DllI5Wiw67Fv2P5DaTSZ+HUcPGzoR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883182; c=relaxed/simple;
	bh=6kOblQMIAk6rS4rTWzB9VVHz5zrNKra8UWOa/nIGO80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6LrBXjRe0Rim7gVz9Z8Fah1t+insNL5fOIfv+SujaPSrpYwYk1yU3bYbcJDTXERJ7O1OKcMli9ImCRmhe54DXhn1lqS6BB4dwccX2cuO4jw1tEmfcWg6E6c8Xk595mwWj52VMi/XlL1JCxe+dmCCtYY34Drn/CqmdA5zaZ0Yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mI0BvOGB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6l3pTyokc3ChQpn3RO/x1ZI35HVloqsCU1JG2eB4MVY=; b=mI0BvOGBxf16pPW4QLYo8kOgX2
	b8v7sHswfIqTI1JsVYh+MmktbfecT028W9CalpY9TVHbd16umkZbBvkNGwPNdKQSeuUY54e7p/cXX
	+3QulPDuJW3WaG8VhqirJYpHif2XtOarrAT1VWuwmYZWM6gcqYP8BYBYF13oiUsFiSng=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tgAwo-00BfBa-GW; Fri, 07 Feb 2025 00:06:14 +0100
Date: Fri, 7 Feb 2025 00:06:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: gianfar: simplify init_phy()
Message-ID: <4e4cb052-460c-484a-bf82-a4ddacb4d42a@lunn.ch>
References: <b863dcf7-31e8-45a1-a284-7075da958ff0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b863dcf7-31e8-45a1-a284-7075da958ff0@gmail.com>

On Thu, Feb 06, 2025 at 11:06:07PM +0100, Heiner Kallweit wrote:
> Use phy_set_max_speed() to simplify init_phy().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

