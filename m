Return-Path: <netdev+bounces-219134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCFBB400E8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92621B602AD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD428C2CE;
	Tue,  2 Sep 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qG0KUtAn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AC28C011;
	Tue,  2 Sep 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816876; cv=none; b=a5q5Vsv/lY9HLtLa/qSvc7K2EuCgAunj3Vi7y8D84Ove/NWR+a7/NaDeHS3rYM0Io0z+4QncUCooIXvKYuTzQUUt/mWb+B+Y4r8OF/cvJTydRE1qivwp+hH7baUaLs1g2XglFS2ltD7GB/XZ/sracQBp+kCNPKTkZPl4vyCYiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816876; c=relaxed/simple;
	bh=chLF2nlQTy4Kpvo2bXrIx+leLqO+VioC8WiW4UtGceU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj9gG/Sfpj89j47SAee0YIzbbm9Jc2Ci+3yzX7a6lFHPEg0sC5fAGdfub90gSr/FhD0+CVYccEnAJvxtDRQquqYU2cAyJh4uJx58JWbtcNsHGOGoFIkF8mNHJQ65/Mf4FwbhlQ4Pvj7iCSz3iwPhIh4FESZiKTu2fhoWjE0d5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qG0KUtAn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bqMz1bhGC904dYzAluW4uQ3RkfYk6nuO3qGuIBL/alw=; b=qG0KUtAnicsr8K9ndh/X1WMezO
	n2qI2cZKqaaEQeG5pue+0lnkeBCyvhDzIqLa97+XkkmeHdZTPGJ9mIcRMxN+8QHZFEYVzagoDFHMF
	EcZiDncaojNfus08Q9XkK9esSZO91SXwYljRxPngi450hhF79gNg9LOKdYB3yQOgl+qQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utQJt-006t1f-7H; Tue, 02 Sep 2025 14:41:05 +0200
Date: Tue, 2 Sep 2025 14:41:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rohan.g.thomas@altera.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next] net: phy: marvell: Fix 88e1510 downshift
 counter errata
Message-ID: <b1501674-5a24-4ebb-829b-4f2972f7e886@lunn.ch>
References: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>

On Tue, Sep 02, 2025 at 01:59:57PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> The 88e1510 PHY has an erratum where the phy downshift counter is not
> cleared on a link power down/up. This can cause the gigabit link to
> intermittently downshift to a lower speed.
> 
> Disabling and re-enabling the downshift feature clears the counter,
> allowing the PHY to retry gigabit link negotiation up to the programmed
> retry count times before downshifting. This behavior has been observed
> on copper links.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

