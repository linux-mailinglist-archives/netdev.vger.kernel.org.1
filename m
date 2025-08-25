Return-Path: <netdev+bounces-216699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C10B34F91
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32B11B26719
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB192BDC3B;
	Mon, 25 Aug 2025 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZM1h3CDO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA651227EB9;
	Mon, 25 Aug 2025 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163495; cv=none; b=opkP5QU6rh7ysvlWE45lh7oIXTaYuH7eP0/EYkUr9Pg/Vqe9dLSIpH8b0axh/JmtoS0HnrijuS/YAaxCH8jZcg/jZ2lRdH+fJYSqFmDJJ/30+OXZvkWL8FiOY3euuWnp3zlyPzwXvAEMnQ21Dwchu6oib2p0NiAgy/BjNwifi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163495; c=relaxed/simple;
	bh=dX0WPvw6Z2duV/oMvI6uF8YtaW7C+G9cXZzIwVXrqwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3yWmI0prOQ4mxQYuT3S/z8G2IP5MRJ7QP0ycLiTZZIFmA+knaXK9Sn0dHOxh+jqvWe65iLjHgbOZWTSeG3ts/+JnZcRJ2XrUkYY5SuiWiHMK41oKqncJDkFsMAplG103ZftjfGSGhwubjg3nNXbZq6uhJ78RmbCIenpT7zF2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZM1h3CDO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O+51kTZ62ru3n3XCOY5pFCT7+kOe09oJo7Lbf7jNWik=; b=ZM1h3CDO3aqr62912jrjY9rQ6p
	XjER8woQtaKLo85x5QU057HozW568CpY10uW92Rnx456I6JrbWLfD0BD1FjHJnQ03dY5a+QEC5Qg1
	IoZAq4cXQNPmsbLYl2LUTV50EfnwsfGZIE7QeGvadB+wBfeRkgCnaMNPq7QAkF6pzNmo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqgLM-0060PS-2T; Tue, 26 Aug 2025 01:11:16 +0200
Date: Tue, 26 Aug 2025 01:11:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michael@fossekall.de, daniel@makrotopia.org,
	daniel.braunwarth@kuka.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: support for
 TRIGGER_NETDEV_LINK on RTL8211E and RTL8211F
Message-ID: <ab856e5a-2a30-47f9-abc3-0c372017b10f@lunn.ch>
References: <20250825211059.143231-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825211059.143231-1-olek2@wp.pl>

On Mon, Aug 25, 2025 at 11:09:49PM +0200, Aleksander Jan Bajkowski wrote:
> This patch adds support for the TRIGGER_NETDEV_LINK trigger. It activates
> the LED when a link is established, regardless of the speed.
> 
> Tested on Orange Pi PC2 with RTL8211E PHY.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>


Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

