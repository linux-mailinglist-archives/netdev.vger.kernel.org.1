Return-Path: <netdev+bounces-223236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BAAB58786
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D62E4E1652
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC472C11E2;
	Mon, 15 Sep 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1cBgAOyt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28026279788;
	Mon, 15 Sep 2025 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975331; cv=none; b=uOg2QqA2Uj7I7bwsJw+n2qOf8FDqXvndglKWcLaQc0D6e4YgAjZKevv6IkXCPByQ76AMckd7QMYSHtjtiM1YnbcSqfN3uH7mYtqEWwJaytvt9h4VnDrNkRFZ7i8X86oU90hMyuwxI77kTXyNyKG/vTeL78/WFvyrAwhUPhpmuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975331; c=relaxed/simple;
	bh=jd6GGC+30T9RQnbvk7IwOMnNZhBAzgeyy5zPU8wIM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxmRzn7rV6zmoi9yldhB+igxJT9FPo2qcDTY9KZDCe6jf2knAsDZQ9OCqvfqtdshgh/RqnEbp5Sa9fh0qoOqX/cBzN9qOdEZoY8Tph4wafH4Nc+uFs8CN3bhFvEngcMv2Kysztey/P6VDal4dzkWhSuAhdRV1GWY8aYmSYRfqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1cBgAOyt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZQyoYQGAJwhQAzn2ihmmL92u5Rz5sk79tIy6t8re57c=; b=1cBgAOytVI6cYc4DiGAiqAIxtn
	AO/kZ7LouAE+x2C7OoyZPn/1/pOJncYGTPr9aNuJ2xXDCbyoOiJ2UGnsXq6+XTJuitQ8VUVjM9Jed
	OibsEVq37344CR4GoSnD8Jdv0CkdISnewBvilVqLI5al8g6MLyw0eP3Qh7ONwhwWpnOdZaVJ+zA+t
	q1HpAd8NoSZuDdEvcdQ94rw3YoxJcV18DFR1lTkD7mzNtTsy21RWB3EEsuY/+X1a6bDEk0Pwv1Ry3
	9RYTrC6kNE17Kn7kCaCaLq7d/94wUP1r43hgvW1EXSzHIANBp5MseIt9pFMKqnx/P/DqVn1atXeCG
	10Hc11IQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34060)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyHgd-0000000028k-0VD1;
	Mon, 15 Sep 2025 23:28:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyHga-00000000725-1DxD;
	Mon, 15 Sep 2025 23:28:36 +0100
Date: Mon, 15 Sep 2025 23:28:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: phy: clear EEE runtime state in
 PHY_HALTED/PHY_ERROR
Message-ID: <aMiTFLYFMnwtk38S@shell.armlinux.org.uk>
References: <20250912132000.1598234-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912132000.1598234-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 12, 2025 at 03:20:00PM +0200, Oleksij Rempel wrote:
> Clear EEE runtime flags when the PHY transitions to HALTED or ERROR
> and the state machine drops the link. This avoids stale EEE state being
> reported via ethtool after the PHY is stopped or hits an error.
> 
> This change intentionally only clears software runtime flags and avoids
> MDIO accesses in HALTED/ERROR. A follow-up patch will address other
> link state variables.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

