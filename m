Return-Path: <netdev+bounces-49329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F307F1BD7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AA61C208CC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F8224A1E;
	Mon, 20 Nov 2023 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hjw7Emvb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40E92;
	Mon, 20 Nov 2023 10:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5wD7wBF+lHKdF+Dqen+lnC7hkw+eQyJUlyzbsg0+08c=; b=hjw7EmvbLqLK70QVQXYoHYyWgE
	RaWMzEwXzQL+xor+owvdn5Wjz6Y5h8Epeo4tVEyFU0JK/NbxjR7oNneI5ZpBkBr4sh33W1orqVd2M
	qpzH1sFnaWwBCtj6mv06ydHv1PZiHRm2u8s/SmRynOvHJesAIZyNGXRKzx5zDli7KgL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r58Z1-000g3L-Tr; Mon, 20 Nov 2023 19:00:03 +0100
Date: Mon, 20 Nov 2023 19:00:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
 <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
 <20231120110944.66938859@kmaincent-XPS-13-7390>
 <20231120111008.GC590719@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120111008.GC590719@pengutronix.de>

> > > >  struct pse_control_config {
> > > >  	enum ethtool_podl_pse_admin_state podl_admin_control;
> > > > +	enum ethtool_pse_admin_state admin_control;  
> > > 
> > > When i look at this, it seems to me admin_control should be generic
> > > across all schemes which put power down the cable, and
> > > podl_admin_control is specific to how PoDL puts power down the cable.
> > >
> > > Since you appear to be adding support for a second way to put power
> > > down the cable, i would expect something like poe_admin_control being
> > > added here. But maybe that is in a later patch?
> > 
> > No as said above admin_control is for PoE and podl_admin_control is for PoDL.
> > Maybe you prefer to use poe_admin_control, and add poe prefix in the poe
> > variables. It will differ a bit from the IEEE standard naming but I agreed that
> > it would be more understandable in the development part.
> 
> Official name for "PoE" is "Power via Media Dependent Interface". PoE is
> not used in the IEEE 802.3-2018. Using names not used in the specification,
> make development even harder :)
> Especially since there are even more marketing names (names not used in the
> specification) for different PoE variants:
> - 802.3af (802.3at Type 1), PoE
> - 802.3at Type 2, PoE+
> - 802.3bt Type 3, 4PPoE or PoE++
> - 802.3bt Type 4, 4PPoE or PoE++

From the 2018 standard:

  1.4.407 Power Sourcing Equipment (PSE): A DTE or midspan device that
  provides the power to a single link section. PSEs are defined for
  use with two different types of balanced twisted-pair PHYs. When
  used with 2 or 4 pair balanced twisted-pair (BASE-T) PHYs, (see IEEE
  Std 802.3, Clause 33), DTE powering is intended to provide a single
  10BASE-T, 100BASE-TX, or 1000BASE-T device with a unified interface
  for both the data it requires and the power to process these
  data. When used with single balanced twisted-pair (BASE-T1) PHYs
  (see IEEE Std 802.3, Clause 104), DTE powering is intended to
  provide a single 100BASE-T1 or 1000BASE-T1 device with a unified
  interface for both the data it requires and the power to process
  these data. A PSE used with balanced single twisted-pair PHYs is
  also referred to as a PoDL PSE.

So it seems like, anything not PoDL PSE does not have a name :-(

However, everything not PoDL PSE seems to be clause 33. So how about:

	enum ethtool_podl_pse_admin_state podl_admin_control;
	enum ethtool_c33_pse_admin_state c33_admin_control;  

At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
are visible to userspace, but if we don't have a better name, maybe we
have to use c33 in userspace as well.

I do think naming like this makes it clear we are talking about two
parallel technologies, not a generic layer and then extensions for
podl.

What do you think?

	Andrew

