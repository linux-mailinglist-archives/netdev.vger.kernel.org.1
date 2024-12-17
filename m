Return-Path: <netdev+bounces-152595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609DB9F4C38
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6D5170E88
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA41F3D5A;
	Tue, 17 Dec 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="idBqgFdV"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE51D1730;
	Tue, 17 Dec 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441359; cv=none; b=cV8XeJ0GVeZR1DHPMUxzsSRLa2SoC9l0clvDnNFx7Rnc1EiEHKBaneaZdwmYaLFP55r4vhFCAbn9G7JktpMvs2S9TTRM/5fsJPVzemL0tdADDcrjdXL2O6MvFQy7dn8yP4hZ+8rTKZe7sViV1kkbVU2UMrqW3fPLzgvEpsMrjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441359; c=relaxed/simple;
	bh=0sCzv0yCEB30e+kBHiFoMn6tSSyhTb3x4pYNc6DoRzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roBvi7t0tnpsEUL6nRwypg7iAvIScZ7LK++X82KMZl7h9NqDG7zQmITeCziVzQDpFst9XA0REb9Xrj50X9fNPyYakSmnDv58kggoFt7AFILPLssuH/udCMDx48vzCh9jz4gl2ViF1WomZzgyl3JivrAyoKpOUBXbBMHmbf4n04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=idBqgFdV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 416AE240004;
	Tue, 17 Dec 2024 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734441350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj+ACVgblctd82Lp3dspwycdphb6HP2RNNRGhMPntpQ=;
	b=idBqgFdV0mScu6bL3/tWYXiGeBR7mWbY3IzrqYH/Fc+6vloVBOEIQO6g6CIJKoNV8hnM/q
	SJkhzwivV3nXMDSugkw9gWMTzzbNSsrWyEwZB+cVUhK3Lfa45fzMMwlQyuln346jNXaclw
	jqG5gDuFw8QJyBb/p5rovRr2UxN7ytfSpyeN37O3Q0SHW/W2coj8kHg7Cmpiy5sFn0S3NB
	St+50ISmlf8N2fr/xzRIqjxyrRezlo87QQwC5ZgrymkEdK8y3sZrlFwi1mZOdv6+JqoKzo
	asgs9IoEIedxxYscVI/i4OaSEZgeJWLXLB4DhMiolyLWDBKHCyv6EpVN7Em4XA==
Date: Tue, 17 Dec 2024 14:15:47 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: pcs: mtk-lynxi: fill in PCS
 supported_interfaces
Message-ID: <20241217141547.7748b3d3@fedora.home>
In-Reply-To: <E1tMBRF-006vae-WC@rmk-PC.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<E1tMBRF-006vae-WC@rmk-PC.armlinux.org.uk>
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

Hi Russell,

On Fri, 13 Dec 2024 19:35:01 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Fill in the new PCS supported_interfaces member with the interfaces
> that the Mediatek LynxI supports.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/pcs/pcs-mtk-lynxi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> index 7de804535229..1377fb78eaa1 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -306,6 +306,11 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
>  	mpcs->pcs.poll = true;
>  	mpcs->interface = PHY_INTERFACE_MODE_NA;
>  
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, mpcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_QSGMII, mpcs->pcs.supported_interfaces);

I'm sorry if I missed something, but I don't find where the QSGMII
support comes from based on the current codebase :/

I didn't spot that in the inband_caps commit, sorry :(

> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX, mpcs->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX, mpcs->pcs.supported_interfaces);

Thanks,

Maxime


