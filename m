Return-Path: <netdev+bounces-152630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A99F4EF1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4451895373
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A81F7073;
	Tue, 17 Dec 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SybrRRdA"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA61EBFE3;
	Tue, 17 Dec 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448027; cv=none; b=TgZFjn3xg3Pu8YX0cuJKcCw/0l1nvZMGY4liA8hxuPeLmN50s8Ygieb8fsL8+9x7BWSd8MNIVVbsvmY3CbquHI5T0n/SAQzl+JuS5V68jMX1lvLuxSaqPTH12Sw0dsFByF1FlOai43rS1QFT8eBbjg0q+JyLyll1rKMQKj+kQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448027; c=relaxed/simple;
	bh=ihP95DVIO1LT5aZ6gKaVUlAQ0ZvFvhDPgkPDr0pFcMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJM5tDmQjJjPsLWLXw1GOz63tg58nijXp38DNwVnYbRm/ICY/+EDsh1eGc0wDnvYn8hRDtdEXPFD8P6QmM77qR82Cd5kiOnTiPJ9NAxC4VZeA+eGbMchcIhCH4+4dsVZz24A0Y1evLVB4503iNVJbhSX/9FICtE9uIgFiL36m1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SybrRRdA; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D11BB60009;
	Tue, 17 Dec 2024 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734448023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eGcF78PnRCgMjDMS2quanXGAcbh8iyhTUjv/20yif4=;
	b=SybrRRdAVa2Ax8rFkE/tHwWK1Xxc+xoZXDJA7QbI6ffdDgfUtjl25UhREeafQ9s/BKMHZz
	c3QZmEFctAvFxDW2M/pwe7zcZDpYTO40Lh1C1lYqgguAhVGeRNistALf/X4S0gEP7dxhKo
	ay1dKhF+eFe/RYKGUJhARD6pTleL7Vomqcc1gmFJfHacSSCKy51a+wkAfjLK0MUU1EInZq
	zQB7YRqm9ydvmwz4DhcKuyRcr+d6FR5j+q2RlRM4vpXXPTBUV6rzPsCV/4LHEz/W/tbO8F
	idPN2p90Sa5oXPUPb5VmvGCFK5VcNMr9zqwgX9Ov2P3I8hdnMaedbeU3j/wUBQ==
Date: Tue, 17 Dec 2024 16:07:00 +0100
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
Message-ID: <20241217160700.1b4256b4@fedora.home>
In-Reply-To: <20241217064907.0e509769@kernel.org>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
	<20241213090526.71516-3-maxime.chevallier@bootlin.com>
	<Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
	<20241213182904.55eb2504@fedora.home>
	<Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<20241216094224.199e8df7@fedora.home>
	<20241216173333.55e35f34@kernel.org>
	<20241217135932.60711288@fedora.home>
	<20241217064907.0e509769@kernel.org>
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

On Tue, 17 Dec 2024 06:49:07 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> Let me triple check ;)
> 
> On Tue, 17 Dec 2024 13:59:32 +0100 Maxime Chevallier wrote:
> > - The priv->phylink_config.supported_interfaces is incomplete on
> > dwmac-socfpga. Russell's patch 5 intersects these modes with that the  
>                                    ^^^^^^^^^^
> > PCS supports :
> > 
> > +		phy_interface_or(priv->phylink_config.supported_interfaces,  
>                               ^^
> > +				 priv->phylink_config.supported_interfaces,
> > +				 pcs->supported_interfaces);
> > 
> > So without patch 2 in the series, we'll be missing
> > PHY_INTERFACE_MODE_1000BASEX in the end result :)  
> 
> "Or" is a sum/union, not intersection.
> 
> You set the bits in priv->phylink_config.supported_interfaces.
> Russell does:
> 
> 	priv->phylink_config.supported_interfaces |=
> 		pcs->supported_interfaces;
> 
> If I'm missing the point please repost once Russell's patches 
> are merged :)

Erf no I was missing the point, time to catch-up on some sleep I
guess... I read an 'and' and it was firmly stuck in my mind...

nevermind then, patch 2 isn't required anymore...

Maxime

