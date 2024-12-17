Return-Path: <netdev+bounces-152591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E919F4B60
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C5E7A20E9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEA1F3D45;
	Tue, 17 Dec 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b9Mvdrgk"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0011B7F4;
	Tue, 17 Dec 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440382; cv=none; b=mHdL9QGQ4+36QhTgDgjZFfrCtTdpYAJUQh5NnasiJIvoR0R3NQgJHxcL+xgkKPk/oA42+93dRyxLNlgfumFSiGySaZ2ANstuuQOgRckiMWe0zPVRfSiqC7ZZgKt9IfGaYfcL74yaTRGgTfbhQIHSU57iefXFArbo0KMjcGH/ybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440382; c=relaxed/simple;
	bh=FSxSWgBbPRAxchKdx7g6FzZTBA/xgsJu1BpPekpZ/yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTUea9PXg5uOCt5HFtO/a6xpUT4DXyiV1ZD56CORm5pPPMfFoOQJ9tG/+lNmICkdEkt2/I3ngDsRUNoJdtpWLNi/kezxfK65uzo5AQksK5DrmcsPxgw1jT+3mugGzpW2zu75TAdiN80kEjYzDM1Q1+3mGHZsIR5FT1+2cK0eT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b9Mvdrgk; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20B3460002;
	Tue, 17 Dec 2024 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734440377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI25amw8mKM1HUCW0J89cbc4oV1eC9Wev0IA+2/p98M=;
	b=b9Mvdrgk1gOB+P6K9XMFfCT86n5yIqey2T6btCwQpOPjmkMEhdo+bdktDZbWNe8soVdAE3
	LowYzA2SUu2X0MPvuk5nJxStHOkDykumdcRoIHfmAsnqYUtEiRFlUG85B5TcYvihSNfvAb
	5J9pCRemqeaF5jrWwhAB5AdAKc1JtpDALj3nANjEuatRhLSxmoQCEdSZhYLH3dz6hkNoET
	bNOdqFyci3R+hRclrlTymBcRCeXcnHJZdgh2Cwiw5Ii5Uyq8BIWDCuicrW9B7jCw4fxJGE
	cQfPFYGtcPFsmXt2wUaFeqxIXUmleh0kGWs5jFHT4jbTaXQodFc2EsrmudIWjw==
Date: Tue, 17 Dec 2024 13:59:32 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Set interface
 modes from Lynx PCS as supported
Message-ID: <20241217135932.60711288@fedora.home>
In-Reply-To: <20241216173333.55e35f34@kernel.org>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
	<20241213090526.71516-3-maxime.chevallier@bootlin.com>
	<Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
	<20241213182904.55eb2504@fedora.home>
	<Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<20241216094224.199e8df7@fedora.home>
	<20241216173333.55e35f34@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Mon, 16 Dec 2024 17:33:33 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 16 Dec 2024 09:42:24 +0100 Maxime Chevallier wrote:
> > > I've actually already created that series!    
> > 
> > Woaw that was fast ! I'll review and give it a test on my setup then.
> > 
> > Maybe one thing to clarify with the net maintainers is that this work
> > you've done doesn't replace the series this thread is replying to,
> > which still makes sense (we need the
> > stmmac_priv->phylink_config.supported_interfaces to be correctly
> > populated on socfpga).  
> 
> Ah, sorry. Should have asked. 
> 
> I assumed since Lynx PCS will have the SGMII and 1000BASEX set -
> Russell's patch 5 will copy them for you to
> priv->phylink_config.supported_interfaces. Your patch 1 is still needed.
> Did I get it wrong?

Both are needed actually :) There are 2 issues on socfpga :

 - 1000BaseX needs to be understood by the socfpga wrapper
(dwmac-socfpga) so that the internal serdes is enabled in the wrapper,
that would be patch 1

- The priv->phylink_config.supported_interfaces is incomplete on
dwmac-socfpga. Russell's patch 5 intersects these modes with that the
PCS supports :

+		phy_interface_or(priv->phylink_config.supported_interfaces,
+				 priv->phylink_config.supported_interfaces,
+				 pcs->supported_interfaces);

So without patch 2 in the series, we'll be missing
PHY_INTERFACE_MODE_1000BASEX in the end result :)

Thanks,

Maxime

