Return-Path: <netdev+bounces-181986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A38A873FA
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 23:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1811816B88C
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C414D1F2BA1;
	Sun, 13 Apr 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FRSxE84e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F512B94
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744578609; cv=none; b=XrE6stOPJAtMK3aYgy8K+PAf6uq0wZjJLDOZl2ML/lrRvdrcKCuy9oBsMzuAkkKn6xPHvtdRi3c108wJku/I9rl+FlXDQwXYprbZ+IcyYcxqX3AhIM97Srd9ZU4anOkaJ7aEH2TRQf9aiaabV3QfhSIGzap83xhn617tgnII958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744578609; c=relaxed/simple;
	bh=KlCSdJfkvtJmym+5ju/Q5878gbX93ioip8SZExAWXso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgHA2mjBMC4LwSGkRTgo8FiXISm4ZxITCQNdWG7yzfiR4dZt5lClb8b+f7qdFHCah8K4BZFw798b+SggaNbV+SE6aeMT6C+TP59IALAFcqj5NFN+99A0SotvbsKaI6E9gX7VC09d5VLUNfhzgh9b0ArTY2e9prgDTvFXZnYQUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FRSxE84e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IXdTX5kNhB8Djet/lPdjXM/642r9m5weD6j19yKVYFA=; b=FRSxE84ew4LfwgbmZReX+x79zc
	rz3klM8nhxyD49snBpcJ853XwqQKmr5P37dt0cZ/vV4jYkdOQki1lpZ40kUndBgU9EqVdioAi5lx3
	3b87SH9EH/vOZF4Pfb3oHExIl1dQnVKj2BucLqiW0avubRdQCGdoOvp45Yv5Ec3Fq0m4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u44aW-0096N2-0t; Sun, 13 Apr 2025 23:10:00 +0200
Date: Sun, 13 Apr 2025 23:10:00 +0200
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
Subject: Re: [PATCH net-next 3/4] net: stmmac: anarion: use
 stmmac_pltfr_probe()
Message-ID: <0828d7ed-3ba5-4678-9f1e-9bbab07cfdee@lunn.ch>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
 <E1u3bfP-000Elx-JE@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u3bfP-000Elx-JE@rmk-PC.armlinux.org.uk>

On Sat, Apr 12, 2025 at 03:17:07PM +0100, Russell King (Oracle) wrote:
> Rather than open-coding the call to anarion_gmac_init() and then
> stmmac_dvr_probe(), omitting the cleanup of calling
> anarion_gmac_exit(), use stmmac_pltfr_probe() which will handle this
> for us.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

