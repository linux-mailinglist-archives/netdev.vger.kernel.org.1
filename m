Return-Path: <netdev+bounces-65591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3C83B1AA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06642883FA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A780B131E23;
	Wed, 24 Jan 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v6tDCOLV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F77CF33
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122843; cv=none; b=fCCQ/+6hAL3EXzHlZoFHijVx5XQOLghbs9KUNcTgAQLj9xNz+16AnKzkckHlRCDXDMtPPTdh9bMoGkzBpNE/lDA7K5IlmuWIocLIZ9HNe0rTB5KOhjR8ImT28WL6qE6gkSBMKDQ982TcfvuaQyYglQ60MBrkTqtBSDoN3gE8Prs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122843; c=relaxed/simple;
	bh=p5nhWyIAycQ6cVBS/HribWtrxcxz9r5FFna+9Y+MWNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImJixvABpMq1ZdY3ozyBn1609hyDhZ25j3qex0pL2y9z8zH6EqBpVA0Nhz0Of1EZa829Nitx/v5o+eJxS/YmDlAI+YaOwWV29C9OdKJVvtsUZ+7sD4321Ye/+i141oJ5m6HVg03T2yze1zCobGr69WI2teMmS9ANNop08abeXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v6tDCOLV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BtsgWd3kFF899ZUaNO/15jxz87oEa2vxonZymTbaUMI=; b=v6tDCOLVtEg9HEBcSP6mjiMHdc
	sHyouiafxIKpFWUFVg9W2nWytaVmr3uZBWYCayvL9N+xlLAxC1/TdCpXUV9lPTAnGAHCNGTxkblCl
	fEh292YUrV64JEgYaujRUS6hWyZRc79z2cN9VxH27P6AxfDFbJyCQVq5J9DxoLeVoKQMpL8GyYOsc
	LLjmmG7C9w5CKQx1JJ8xPo2MANSDq0HBbUpi1L0F48lToInZTWlUZgOlQn686ctlI3UVc4QyzzlJc
	oFujNleOfYKUOdwar9BvQRDDxckBg/EtRt/EqNFz8LmA0w1f0SLVthD2wVUVmvRsvE5pC1oREx8Ti
	Lb9sLKFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34266)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSiU9-0004HQ-17;
	Wed, 24 Jan 2024 19:00:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSiU7-00035Q-N8; Wed, 24 Jan 2024 19:00:27 +0000
Date: Wed, 24 Jan 2024 19:00:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Network Development <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: Race in PHY subsystem? Attaching to PHY devices before they get
 probed
Message-ID: <ZbFeS+Jspx8T228P@shell.armlinux.org.uk>
References: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
 <a9e79494-b94a-40f7-9c28-22b6220db5c2@lunn.ch>
 <Za6eMg0y2QxogfmD@shell.armlinux.org.uk>
 <65b12597.050a0220.66e91.7b3b@mx.google.com>
 <c3282db2-b1e5-422a-b62f-c081042da9de@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3282db2-b1e5-422a-b62f-c081042da9de@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 24, 2024 at 06:52:35PM +0100, Andrew Lunn wrote:
> This is assuming we cannot actually fix phylib to correctly use the
> driver model, PHYs are not visible until probe is complete, and the
> MAC drivers can handle that.

The only thing I can think is some kind of kbuild extension that looks
through all the PHY drivers that are enabled in some way, generates a
table of PHY driver match IDs, and use that as an "exclude" list for
the generic PHY drivers.

This would preclude the use of out of tree PHY drivers. Whether we
think that's a good or bad thing depends on ones own point of view.

However, the default fall-back to the generic PHY driver can't work
through the driver model because of the reasons we already know.
(If someone wants them expanded, then please ask, but Andrew and
myself are aware, so as I'm replying to Andrew here...)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

