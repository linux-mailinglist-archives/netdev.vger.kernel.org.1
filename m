Return-Path: <netdev+bounces-235213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCBC2D88A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08293BEB92
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47DD21CFFA;
	Mon,  3 Nov 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1S+kAWmP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD721E0BB
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192083; cv=none; b=DbMSBWQyzujHhy15+cXwWnydMxTrCO22cp3DRsat9HzLNKjcZ9D3TGkXJWPBUG4hHNqceg3N9b7hzonVK4IB9pBP7LOYbWWMY0J8E7d4Ot/647BNa++6Djw/xYVY+LhGPdWZ9/CT2g3QB8Fqo9MXo1xmfBy8qTZogPJJHlWTArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192083; c=relaxed/simple;
	bh=+ny4WmJGLInbpZYl1rkPWa3nSXpyywYv2y/Dt67mfpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB99XKUZZHC4MICOdmKXHTT3medEy/du/vxBYhGF6z5d0u/sMLs5VA4sf22vaMPUTSFWi559y7AojITiDsrfv8dKTH+UnP+IjBZGq/2TRoyCJ3AV3FIUj4BP5ufjn9NrpSeP/DDwiImPzkoPbbQRCnJFJLxDjN3C/Bya6MmuTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1S+kAWmP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F4tY0xEk/s5ULMTQoKRyP5pA33pYTTb8mq761OpBQB4=; b=1S+kAWmPcSXXqHXeST9tva6/P5
	Tt50B0vUgtkWTwo7oONe2d1OQrmZDsBM62fGIqskdOh3K3NoLi+LhMSoORuLCYiRmcM/f0NRNoHXQ
	BWMbkaEyIAQnuaJCEp1aIhqUHZVI9UM6iOEJdN6v/d44t/43g32x2A9oZSvDniDLrea3ou/Tbyyzv
	5cgQtTTuiYbMzSi2TmZ0w1MXW6N7BRRoMKzSi5y3cWFkKnhkWhU2EGsGaHKqlPCuxeDh583Cbeocd
	4fjGFVWuclE5cR+41OR6fkeEdBlsoHuuSvxYJSE/6+JwX4ew+y329EnsnTGW0eMhTdWR4XraVykdt
	Sqfwj9QQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58818)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFyes-000000001Ej-42Kw;
	Mon, 03 Nov 2025 17:47:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFyer-000000003zO-0rSd;
	Mon, 03 Nov 2025 17:47:57 +0000
Date: Mon, 3 Nov 2025 17:47:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [net-next PATCH v2 06/11] fbnic: Rename PCS IRQ to MAC IRQ as it
 is actually a MAC interrupt
Message-ID: <aQjqzVL6SYKeg5uI@shell.armlinux.org.uk>
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218924103.2759873.8687328716983200406.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176218924103.2759873.8687328716983200406.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 09:00:41AM -0800, Alexander Duyck wrote:
> @@ -131,26 +131,26 @@ static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
>  
>  	fbn = netdev_priv(fbd->netdev);
>  
> -	phylink_pcs_change(&fbn->phylink_pcs, false);
> +	phylink_mac_change(fbn->phylink, false);

Please don't. phylink_mac_change() is the older version from before
phylink ended up with split PCS support. Some drivers still use it
(because I haven't got around to sorting those out - I've got the
mess formerly known as stmmac that I'm dealing with.)

It only makes sense to tell phylink about a change in status if there
is a PCS, because that's the only way phylink can be told of updated
status.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

