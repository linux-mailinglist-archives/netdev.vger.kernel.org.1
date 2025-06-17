Return-Path: <netdev+bounces-198709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD544ADD1EE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3050A18984E6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B02E9753;
	Tue, 17 Jun 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LKKEHTRf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABA18A6AE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174594; cv=none; b=EB85aL2UOoxMdAEFH6QD0Y5jTA4NqxXqY2gkRbs2ijafuT2B49vs3hevkU7FmOWaVFcLQj8qJUyfroyLPN4BU+e2e8NxannTpSYu35gA1bnM9Ujhxj50McHAAvCKa7d8u+3CScZ3JvDfBs+jR9vEftapEy2E7JJ1ZV9gwpk5OzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174594; c=relaxed/simple;
	bh=RzI4WFj/o9lCMsAtrttm0TXbZTU5czQFYClXNUz5454=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+YCrNWlde3MxO0E796uPSd/LvjlXtOGSQuZ+HyvMXPkJBIRaBHNw272Qk+ZCjSDRSmBadp43CGcrgftF5yQGd7Ekbos12HOZHj7BVHap5PpXe5zu9qn0eR7+E/BPJQcTklh4HjpSth0ePVjvOFauRvfpLTUC/yi4k0WuzdEB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LKKEHTRf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yIkvKwYryqw/OJaDF+byo9m8SfDT9RZ+4IuivpDG+qk=; b=LKKEHTRfan1/C8iG3d54wMfY1I
	dczD+VVKUeLXgc9lZX528bleO/9HfkAl9Jip1QGvKP+Vt8UpiOFk5npPQShFvtHF4VDCNj2BaneDY
	ReqvfSZ5sBvm0Wd1JR1b9Dd83sRQVGdXxLw+dcsWVCswJucpAMFPRlr36ZrbwcDPcIrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRYMC-00GBcz-B6; Tue, 17 Jun 2025 17:36:16 +0200
Date: Tue, 17 Jun 2025 17:36:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michael@fossekall.de, daniel@makrotopia.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: convert RTL8226-CG to c45 only
Message-ID: <6e0e38b4-db64-4b63-ac36-4a432b762767@lunn.ch>
References: <20250617150147.2602135-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617150147.2602135-1-markus.stockhausen@gmx.de>

On Tue, Jun 17, 2025 at 11:01:47AM -0400, Markus Stockhausen wrote:
> The RTL8226-CG can be found on devices like the Zyxel XGS1210-12. These
> are driven by a RTL9302B SoC that has active phy hardware polling in
> the background.

It would be a lot better to just turn that polling off.

> As soon as this is active and set to c45 most c22
> register accesses are blocked and will stop working. Convert the
> phy to a c45-only function set.
> 
> For documentation purposes some register extracts that where taken to
> verify proper detection.

Please could you show us the output from ethtool before/after.

>  		PHY_ID_MATCH_EXACT(0x001cc838),
>  		.name           = "RTL8226-CG 2.5Gbps PHY",
> -		.get_features   = rtl822x_get_features,

You can see this calls genphy_read_abilities(phydev) at the end, so
reading information about 10/100/1G speeds, using the standard C22
registers.

> -		.config_aneg    = rtl822x_config_aneg,
> -		.read_status    = rtl822x_read_status,
> -		.suspend        = genphy_suspend,
> -		.resume         = rtlgen_resume,
> +		.soft_reset     = rtl822x_c45_soft_reset,
> +		.get_features   = rtl822x_c45_get_features,

This only calls genphy_c45_pma_read_abilities(). So i expect 10/100/1G
is missing.

	Andrew

