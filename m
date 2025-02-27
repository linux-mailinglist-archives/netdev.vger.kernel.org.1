Return-Path: <netdev+bounces-170269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F890A48053
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20273B56D4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD19523099F;
	Thu, 27 Feb 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LwaQ2qNB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554DD14B950
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664867; cv=none; b=NMxQ8o0RQ+oBaufK+ekBPkF7pZw7IwD5oRjq5mPsBKvDlIlaelBLki1oddb9m2sHAsS40rPGmMKP2es/DDrfXXCdoyQFqGbJJUHyHe/QkMHG2r8a8xYemjwb1rPv42UFR5kwxzTXDohyoRLUqTbOYSvMxF2q85rSGcAJufCmrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664867; c=relaxed/simple;
	bh=lr4dJszKOL8igFsztkgpYmE0ztp+lJvqHFcK1acTH1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMKVXPWxHu6BdJ1h0NpfbIYeRJoHLb8+Xt3wnZvcTWCdXlrx/hvWXb2NfDeU5/YIAO2nKHo9YGUuYM63FkO4NZlFH2uATzLZGWVcTy0hezQU8nUt0qFmFe8tGrVNXSYyvxjQs9zAqD7bmN4Cn7eQhbV5XZe63I5p3lQcsRbZPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LwaQ2qNB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zdBL2ustKED09k8F64jH3NHmgRRmM2pU9xBW2XfZOhI=; b=LwaQ2qNBaxRa3eXI35Ka3vVouC
	uUALaAOEVFLmZcRI7O88XOseZElmcbbiQMfs+2TZ3/oVzqgv2Ue5ir00BSqHYC+6c99tPb/6ytVfC
	X+9f+FYYuFmEBlyYzcU80/qGNQy7Qmh//DmvXCmDbzizzWAaH74A6RFKevbxcsYa8VWA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneRd-000bv7-Kr; Thu, 27 Feb 2025 15:00:57 +0100
Date: Thu, 27 Feb 2025 15:00:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 06/11] net: stmmac: intel: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <fb394b41-f632-43a9-afc0-077fe1a7d9ac@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0f-0052sw-8r@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0f-0052sw-8r@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:49AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
> 
> Note that given the current unpatched driver structure,
> plat_dat->fix_mac_speed will always be populated with
> kmb_eth_fix_mac_speed(), even when no clock is present. We preserve
> this behaviour in this patch by always initialising plat_dat->clk_tx_i
> and plat_dat->set_clk_tx_rate.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

