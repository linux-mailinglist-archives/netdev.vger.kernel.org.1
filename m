Return-Path: <netdev+bounces-40818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA57C8B01
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29549B20B55
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102F18021;
	Fri, 13 Oct 2023 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4On1qqi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E89219E6;
	Fri, 13 Oct 2023 16:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB43FC433C7;
	Fri, 13 Oct 2023 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697214659;
	bh=UhsiyLWpL6PODRiDXR4L4zDoj2dJa8jOUZmaiu9xQhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A4On1qqi9cYF0h0xfOzqALiK7J8ty6wIJR7FhK0Mbn8GtYEwXnZB1WyTNgSI/goeM
	 tAl5egrMh/qfmDRZD7ef+6TKTH9ODYM3/F97YXDBIqJZCLKwP5UPiAfBcHK3MNAQZS
	 WmSYHua4BjFOOkYc9uKg6a+TfN06hU4HAIqqpjxsisp2u9Sk/QVGU7eEa7UrSH5VbD
	 s7sRuR/Iz1hj1URMAVIjojCtHG3emblLfBvpmPRjCKdEhzrLDd0n290Uqe6dPKg1ce
	 umrTGrZyjDNHtj0DL6D7TmGZuV3z0gm0jeJuI/Rc50P+syD80ZwiR9zMKXzwH9oKn/
	 eE1WgQXlD96EA==
Date: Fri, 13 Oct 2023 09:30:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Michael Walle <michael@walle.cc>, Jacob
 Keller <jacob.e.keller@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231013093056.4f915df1@kernel.org>
In-Reply-To: <20231013161446.st7tlemyaj3ggkgk@skbuf>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
	<20231009155138.86458-9-kory.maincent@bootlin.com>
	<2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
	<20231010102343.3529e4a7@kmaincent-XPS-13-7390>
	<20231013090020.34e9f125@kernel.org>
	<20231013161446.st7tlemyaj3ggkgk@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 19:14:46 +0300 Vladimir Oltean wrote:
> > What is "PRECISION"? DMA is a separate block like MAC and PHY.  
> 
> If DMA is a separate block like MAC and PHY, can it have its own PHC
> device, and the ethtool UAPI only lists the timestamping-capable PHCs
> for one NIC, and is able to select between them? 

Possibly, I guess. There are some devices which use generic (i.e.
modeled by Linux as separate struct device) DMA controllers to read 
out packets from "MAC" FIFOs. In practice I'm not sure if any of those
DMA controllers has time stamping capabilities.

> Translation between the UAPI-visible PHC index and MAC, DMA, phylib
> PHY, other PHY etc can then be done by the kernel as needed.

Translation by the kernel at which point?

IMHO it'd indeed be clearer for the user to have an ability to read 
the PHC for SOF_..._DMA via ETHTOOL_MSG_TS_LIST_GET_REPLY as a separate
entry, rather than e.g. assume that DMA uses the same PHC as MAC.

