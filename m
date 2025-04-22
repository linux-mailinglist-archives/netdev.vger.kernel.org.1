Return-Path: <netdev+bounces-184700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609DA96F24
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B033A5221
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B466C2857F6;
	Tue, 22 Apr 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mQbOxbPV"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5DA35897
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332957; cv=none; b=NjA9WlZbS4aHeyd6S6RFpGPEzeNjbhtJ7r/0g3uPDs+dlTat8jl0os/RI3pHQj9IAZblvnPxnOfQLGBdOF8Qc1uTJ3iz1EI+8NCN+/OT2Kpy4ZPZL5DOT3VQd+oyRCItTMDN02ao6dpXXzmmsAQnhUfg7lUTGqP6k6pePpQVLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332957; c=relaxed/simple;
	bh=tGrt3F4436LOcPHiTDoHr4XrIReYCHafMCHvGqaziRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WScLHk64wgFosyYWBcEZXqsAG89ll0ov3LgsVyUEu+7aN8v2QC5PWgY99kjtBfg+jzMu9ifrJ/xfHzmPxWIlztbjpuPTEShIoEyO/UqkVfDkGXizfw+5VleYNWpRpntXVgVDCbNyhCZXEEAPHihX5vo/OFaQJyOeBUAr6iwqDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mQbOxbPV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE75A41CFD;
	Tue, 22 Apr 2025 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745332953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jt9Mkr75c4uKAU1hZ+a3wXo6IhuSBSJ1I5FWD7KkaKo=;
	b=mQbOxbPVkr5b4cEsk2QiCO7WlOWZoOOT2oQwWVn4K5DxpU27RzMBPjwNtHVpQXZ6MRWV37
	7r/QCuZm1iooze+gyHGRrPPHg3qH9N9eM/QHV8BT3oorCPuUv7hAXz7mSa/cIfzJbcQV3Q
	5nvO6MfJBWe8Nm7WbilLrZfs/JspuxXqYB9SgtcbKkuMZhmnvntW9cULdVIRydNZF8/y7N
	AqO+Cxa6Ik5c1YyfNby9a13BHYfA5rO0cGviemIoPAVKy2wQeSiLfS3bpicrVK2Z8J61Ej
	ZX15rnnmRt1SH65uFg6azI3W9YYkAD+AW9QIWjgtPa1xREx7kpYWJ6Mt3xc/lQ==
Date: Tue, 22 Apr 2025 16:42:30 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jon Hunter
 <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: calibrate tegra with
 mdio bus idle
Message-ID: <20250422164230.5ffb90d3@fedora.home>
In-Reply-To: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
References: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegtddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgto
 hhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Tue, 22 Apr 2025 15:24:55 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Thierry states that there are prerequists for Tegra's calibration
> that should be met before starting calibration - both the RGMII and
> MDIO interfaces should be idle.
> 
> This commit adds the necessary MII bus locking to ensure that the MDIO
> interface is idle during calibration.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[...]
	
> -static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
> +static void tegra_eqos_fix_speed(void *bsp_priv, int speed, unsigned int mode)
>  {
> -	struct tegra_eqos *eqos = priv;
> +	struct tegra_eqos *eqos = bsp_priv;
>  	bool needs_calibration = false;
> +	struct stmmac_priv *priv;
>  	u32 value;
>  	int err;
>  
> @@ -158,6 +159,11 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
>  	}
>  
>  	if (needs_calibration) {
> +		priv = netdev_priv(dev_get_drvdata(eqos->dev));
> +
> +		/* Calibration should be done with the MDIO bus idle */
> +		mutex_lock(&priv->mii->mdio_lock);

Can't priv->mii be NULL, if the PHY for that MAC is connected to
another MDIO bus for instance ?

Maxime

