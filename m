Return-Path: <netdev+bounces-142978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B469C0D50
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DD41C2208E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B29216DE6;
	Thu,  7 Nov 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pallv/nJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7F216DE8;
	Thu,  7 Nov 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001913; cv=none; b=ivtBdraDGIGTxv8VPMtKvLb1WWMFhtl1Wse8GRV4TmC59JwXIzM4fSmYE3nEOXQr/ckEiW/99dB6Lm9Jj952ulmwzLSIh+xWEl5z1w0hgmmvL4sB9f4c6mg/+0pNXfCaLscQf+zoNa859PMhJwvY4ShZ4+8g3sb734fcZcnjICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001913; c=relaxed/simple;
	bh=MJYbF1lfNlKUtgQ7aj8FENyIimX/V2VvFiWmS2+L6zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWY3eG8Rwo/yNJeq9lLRjos3PcrxCQiKhg5db5Udl/yIKQoCuvf/nfd14zaHT5ixMnopET7xrKWBK+nhZtFUX++b81v8cP3FT3mBZZs4AT8Q9+vxt+OWHS93yo2dvI3rmKw5rgpghnH4z20ECAycKeFlB9vc+PoB/2Klf5hcX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pallv/nJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VTX/qMfY3i1jVfedgdybn7RbAb/9rhIjtakkTYoriP8=; b=Pallv/nJMHV7iZux+Ob/roeq9X
	/E2DpyqXe6D/fqUEme2NP5f/inf0Ze4v8P1V3BPjrdWJ0OMhZBkZ02WkQ/W2N00lRtzcvSyX2J22T
	un2gub2wdSq3ZJxTgZ3CY2+Fx3od6i/baWCCy/S+G2597Kfx/w4Ptt1qhkSmuEEwPqPc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t96fY-00CUYV-67; Thu, 07 Nov 2024 18:51:44 +0100
Date: Thu, 7 Nov 2024 18:51:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 6/7] net: freescale: ucc_geth: Hardcode the
 preamble length to 7 bytes
Message-ID: <7c8e1d44-cdcf-4d46-b9a8-b93e0cd39d43@lunn.ch>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170255.1058124-7-maxime.chevallier@bootlin.com>

On Thu, Nov 07, 2024 at 06:02:53PM +0100, Maxime Chevallier wrote:
> The preamble length can be configured in ucc_geth, however it just
> ends-up always being configured to 7 bytes, as nothing ever changes the
> default value of 7.
> 
> Make that value the default value when the MACCFG2 register gets
> initialized, and remove the code to configure that value altogether.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

