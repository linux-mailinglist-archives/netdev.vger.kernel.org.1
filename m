Return-Path: <netdev+bounces-183807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FADA92165
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38B15A83D0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001E253938;
	Thu, 17 Apr 2025 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KC1H5SWX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE026253331;
	Thu, 17 Apr 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903504; cv=none; b=gn8RK+MMdyWjceWgycA/Dpo0o7eiBZ48Wd1NmxvQEdWWFqHqN3ikLDFbygSUZstJ5yT7ELWKQFlllTeqpR6P7nIgrJnJ8ee+SDE4XG8G5X9IqH+QHTJhjCjOhYPjcpkV27THKbaz6kyop+duwDpdqG50Vi0KyDafrm3qOtbwquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903504; c=relaxed/simple;
	bh=C8qNFEegEQATcD2qD4w/okl4sRFw+bvCwfZCp8qgKkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSmADixrQ40ixNgFpkvvzycUXQzUWe9/wK9UKqbwvhBceKs57Ky8XoOMylUAwAtcBDXuEi0c+EbhUmaL7eni/OUSjsD8BJPRFNcADyinFbw/e/VoscnxqZsIantSqxS+KktEvx89TbAJOp9LNYkDtV3IzrDHV/EEYJvYdDHf+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KC1H5SWX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JySm67fHnESL8Q88SmdhwLZQvpKI176J17Nt4E7e3iU=; b=KC1H5SWXs4IhtqrhqF+IT+bXNh
	1p1IGLwEPJ099yvDwibR2YPvXWdKd5lg3xmXcvuaPUMc3T3NzKoGwEVmVxbz3WBSUALRVD9Ei2rxm
	sNUVJsBg2HxVKqO9f8IFgFYxXo0BtIeqtyK+a+zoGo9KbUS5p7yNwLz6Ocbck5v9WF9xCCpcEOBfT
	ZPJMFuiozWGc+UCZBE0pgxgkvgjF7cW5TUFje/A/9oqOZLqF9+y4sP0Q8sgg3PdDcMLy0esYoo584
	mH/ML+Xq91/hsfGObldta2xSMWejPgLhtS3c46I4+GE+ywZpHb73c9mq/GHs9mEV1GTGApXiiVbrP
	RDAANTWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45184)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5R6m-0007Vs-0O;
	Thu, 17 Apr 2025 16:24:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5R6f-0002Y8-2W;
	Thu, 17 Apr 2025 16:24:49 +0100
Date: Thu, 17 Apr 2025 16:24:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>, Joyce Ooi <joyce.ooi@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Robert Hancock <robert.hancock@calian.com>,
	Saravana Kannan <saravanak@google.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 00/11] Add PCS core support
Message-ID: <aAEdQVd5Wn7EaxXp@shell.armlinux.org.uk>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <aADzVrN1yb6UOcLh@shell.armlinux.org.uk>
 <13357f38-f27f-45b5-8c6a-9a7aca41156f@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13357f38-f27f-45b5-8c6a-9a7aca41156f@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 17, 2025 at 10:22:09AM -0400, Sean Anderson wrote:
> Hi Russell,
> 
> On 4/17/25 08:25, Russell King (Oracle) wrote:
> > On Tue, Apr 15, 2025 at 03:33:12PM -0400, Sean Anderson wrote:
> >> This series adds support for creating PCSs as devices on a bus with a
> >> driver (patch 3). As initial users,
> > 
> > As per previous, unless I respond (this response not included) then I
> > haven't had time to look at it - and today is total ratshit so, not
> > today.
> 
> Sorry if I resent this too soon. I had another look at the request for
> #pcs-cells [1], and determined that a simpler approach would be
> possible. So I wanted to resend with that change since it would let me
> drop the fwnode_property_get_reference_optional_args patches.

Please can you send them as RFC so I don't feel the pressure to say
something before they get merged (remember, non-RFC patches to netdev
get queued up in patchwork for merging.)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

