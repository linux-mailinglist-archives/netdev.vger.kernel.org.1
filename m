Return-Path: <netdev+bounces-49482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420497F22A7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0A02813F0
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93917D4;
	Tue, 21 Nov 2023 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uOvoVaCj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536AD9;
	Mon, 20 Nov 2023 16:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A8vz8TaYFW7rrQPE0TRvK3Ar7EWIRyR4z4redBV7BfE=; b=uOvoVaCjQvPcT6g1+O0TAssver
	UJpoOtZyKIiJsPGnusZiXNozXHlD/FkuqvdCF6el+hAy10z1R7fssEYFkaMzYCMf6dhyWVNEHvfJ8
	HZhNsr6txQPQRl8sQE6sX+/fsVR9MeKp9BfK5qMXHtlgH2nLP/7U7n68qwc7i8MR47/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5F4u-000hxy-3U; Tue, 21 Nov 2023 01:57:24 +0100
Date: Tue, 21 Nov 2023 01:57:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 03/10] net: phy: add helpers to handle
 sfp phy connect/disconnect
Message-ID: <ac7d9aa6-e403-482b-a12a-d5821787dd4c@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117162323.626979-4-maxime.chevallier@bootlin.com>

> +/**
> + * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
> + * @upstream: pointer to the upstream phy device
> + * @phy: pointer to the SFP module's phy device
> + *
> + * This helper allows keeping track of PHY devices on the link. It adds the
> + * SFP module's phy to the phy namespace of the upstream phy
> + */
> +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
> +{
> +	struct phy_device *phydev = upstream;

Will this function only ever be called from a PHY driver? If so, we
know upstream is PHY. So we can avoid using void * and make it a
struct phy_device *. 

       Andrew

