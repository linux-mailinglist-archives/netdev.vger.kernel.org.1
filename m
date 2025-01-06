Return-Path: <netdev+bounces-155541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A89A02E94
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED65916613C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9191DC9BC;
	Mon,  6 Jan 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LKSdrFhI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFA1DD9AD
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183127; cv=none; b=NLlMSP55Uzb7ZB/ueC3aXCHhWut+YAIpEOL1pBS1uao8zbsiR5LprOaBlMHfBCwxx0Kv60ma4nrNPmMpYWqRFdMfI8VVs0gFSscbZUaDRfTn8e6A4x8PVOU+yoiyp1jOH4NTXYEZC4mv6eccjPQky4yL1aU27DafHrxQ90gUawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183127; c=relaxed/simple;
	bh=EF7puJmCKQWZu2TvEGBvfJkB5EoyFsRczEicG1ceOMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAvghDu2dRa/bLAiT8CpeEqccd0Ly1KB7CGipoKD8J7IhYvPIPf/oCSsD2QXrJKF7j6G5FriTPAT7Kr/VpxcMzgLzkdpnAhbzVzjmlddjawCGAEoPYOCUNsXvmb5q4ZpK48Dxm2osSCGMu40LFWRSkuP6n/UesLW2DEK6hgOW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LKSdrFhI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xVK3OuoKPRRhKUwmrmkPiCJ+TccugzJyyYcNsoxCanY=; b=LKSdrFhIzCcIlqu3LdHPECSTog
	9L625YOQ9TmFQKNbgmSrFnhIc2MHJRbJw99gkBhyCX9sNvzjdJIsrLq+mFpHB6EgoCtHkiJtTRajg
	u72lYMupNpqfQGJN7Ii1vyqLrh1dV5kM8jzI3n0Am7NUPEscF4bPU6OCgduyofLJX0rg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqXT-001wN7-U1; Mon, 06 Jan 2025 18:05:15 +0100
Date: Mon, 6 Jan 2025 18:05:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 13/17] net: stmmac: use boolean for
 eee_enabled and eee_active
Message-ID: <5e8b280b-acb5-4b84-8abb-ee7a48a84004@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmB4-007VXt-4o@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmB4-007VXt-4o@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:50PM +0000, Russell King (Oracle) wrote:
> priv->eee_enabled and priv->eee_active are both assigned using boolean
> values. Type them as bool rather than int.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

