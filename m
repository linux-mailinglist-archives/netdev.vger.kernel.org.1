Return-Path: <netdev+bounces-151693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543779F0A14
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149A428144A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398591C3BE4;
	Fri, 13 Dec 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Bv7uJRh0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F91B85EC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087118; cv=none; b=O+mNYCubiS9D8aMir/M520MdgLExS9wIpO5QBpBgQYkDXkXosXw8EBr9q2xCcDAaydHHy/LPQ2GLPc0u8r09EHIEiV29A7vCmPB8nOykrFvdsbxzINvfZQLfr6VDyG3V9XYmLGJlEL1m+noECt+928IokzYqJeipUyEyf7ye1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087118; c=relaxed/simple;
	bh=nytldVIxQoedVFwG6zeE4kih7O9pdfvB2c1eL1TLg20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inmQLImSC16URzyi66K5HpZfINB7Zhsm82QQXcjpeGRvYl95dpC/4hfhQteUorqGGpbv9KRwX0bBJun5AK0FgZZ5reRrbb9auEXbYUF63knzfBlaWDl/PcDYu8kPWKwu4TZ6xut/vcovJZU5WLYPu+7zbkZZKF+AoH9RnW+xMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Bv7uJRh0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GqDA7GwGJi1W4VCQOtACsJIZc4D7wagL1RUDNZkVopE=; b=Bv7uJRh0oQssgQQjeO9qmKvlC4
	hgHNP7OphSsGrei5ULZQOeaBRR7vcWtovzLbIxP+j7IgKwt4om8My8ruD2CfmlzC5OX4xwI9eKkfn
	cZnegTw8W7NwbNfneSh2/Q2YusqTP/3xE07zyEUU4mBZlhU5T57kaCYh8zQtqrelJohOejU7vbRqs
	dlFvLQxiPO3A7EwzXCwawJL2/OhPgOjcDlpbjNPtHWbdaUqKyRwKv+wom2No6W2RJiSdSQ0qwrpWZ
	wHrSLs2TeB1ftTt4iefXBCQiquw9RJSBnKkwk7iCdVpLVQhcJ4O5631eKnJ6NxYs2Eadg+QdyJPxT
	nDxkJNBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tM3Gs-0006a9-2W;
	Fri, 13 Dec 2024 10:51:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tM3Gq-0006Fj-0b;
	Fri, 13 Dec 2024 10:51:44 +0000
Date: Fri, 13 Dec 2024 10:51:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 07/10] net: mvneta: convert to phylink EEE
 implementation
Message-ID: <Z1wRwLSgTutZyitP@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefs-006SN1-PG@rmk-PC.armlinux.org.uk>
 <20241213100415.GF2110@kernel.org>
 <20241213102211.GG2110@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213102211.GG2110@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 13, 2024 at 10:22:11AM +0000, Simon Horman wrote:
> > Hi Russell,
> > 
> > I think that the val and field arguments to u32_replace_bits() are
> > inverted here and this should be:
> > 
> > 	lpi0 = u32_replace_bits(lpi0, ts, MVNETA_LPI_CTRL_0_TS);
> > 
> > > +	mvreg_write(pp, MVNETA_LPI_CTRL_0, lpi0);
> > > +
> > > +	/* Configure tw and enable LPI generation */
> > > +	lpi1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
> > > +	lpi1 = u32_replace_bits(lpi1, MVNETA_LPI_CTRL_1_TW, tw);
> > 
> > Ditto.
> > 
> > > +	lpi1 |= MVNETA_LPI_CTRL_1_REQUEST_ENABLE;
> > > +	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi1);
> > >  }
> > >  
> > >  static const struct phylink_mac_ops mvneta_phylink_ops = {
> > 
> > Flagged by clang-19 and gcc-14 W=1 builds.
> > 
> > ...
> 
> Sorry for more noise, and perhaps this is obvious.
> But a similar problem seems to also exists in the following patch,
> [PATCH] net: mvpp2: add EEE implementation.

Thanks Simon, the 0-day bot flagged them and have already been fixed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

