Return-Path: <netdev+bounces-62238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB2826517
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528F8B213C7
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4A113ADF;
	Sun,  7 Jan 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P0ueCcCX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90E13AD9
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r96zCp9sU3iAaynso5Jq8D+X2fqOPP0MUZv1zQt26sc=; b=P0ueCcCXMqNM8Pp1oO7NK8VgxU
	krcgNo+V09eJ2v8SSwvMPS5XyuMoVs8vqQs9l7wuNUozIAXlcICRLJZrprAdWmc52GzKMraip9kNl
	A/8D7nNooGOqRE/+DqDrp4kV14Ug6cBhnDnm95/SWzod9pRu4F+hKUJEpbubXFIeNgA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMW11-004ZrV-Bc; Sun, 07 Jan 2024 17:28:47 +0100
Date: Sun, 7 Jan 2024 17:28:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 RFC 2/5] ethtool: switch back from ethtool_keee to
 ethtool_eee for ioctl
Message-ID: <d822d4c9-051d-4cc6-aee3-901e9c15c797@lunn.ch>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
 <ba3105df-74ae-4883-b9e9-d517036a73b3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3105df-74ae-4883-b9e9-d517036a73b3@gmail.com>

> +static void eee_to_keee(struct ethtool_keee *keee,
> +			const struct ethtool_eee *eee)
> +{
> +	memset(keee, 0, sizeof(*keee));
> +
> +	keee->supported = eee->supported;
> +	keee->advertised = eee->advertised;
> +	keee->lp_advertised = eee->lp_advertised;
> +	keee->eee_active = eee->eee_active;
> +	keee->eee_enabled = eee->eee_enabled;
> +	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
> +	keee->tx_lpi_timer = eee->tx_lpi_timer;

Just to avoid surprises, i would also copy keee->cmd to eee->cmd.

> +}
> +
> +static void keee_to_eee(struct ethtool_eee *eee,
> +			const struct ethtool_keee *keee)
> +{
> +	memset(eee, 0, sizeof(*eee));
> +
> +	eee->supported = keee->supported;
> +	eee->advertised = keee->advertised;
> +	eee->lp_advertised = keee->lp_advertised;
> +	eee->eee_active = keee->eee_active;
> +	eee->eee_enabled = keee->eee_enabled;
> +	eee->tx_lpi_enabled = keee->tx_lpi_enabled;
> +	eee->tx_lpi_timer = keee->tx_lpi_timer;

Same here.

Since reserved is not supposed to be used, not copying that is O.K.

	Andrew

