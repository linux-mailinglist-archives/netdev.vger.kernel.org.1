Return-Path: <netdev+bounces-193406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F088AC3D48
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216663A47F0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283F1E1DEC;
	Mon, 26 May 2025 09:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73172619
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252971; cv=none; b=sv4rYhtcd7N16cMwSBGVlnN1wVUTi9k2U2QeRdyvSLTkCEfbuEWqpik/IuaQ8TpzHw2Yk084VyKA55/FFujDeo1q1Jc7bM+CI1i1DT6ki4r5F2Fwi/L/zGKLfFH2iLpFj55/ACtJZxRxY7DV/cjYemGD6k1K5T3PFjw6rO1AldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252971; c=relaxed/simple;
	bh=7ve21rc2dwO31o1Azsco8Wk0jQ5KnyC7a9Zc7PdbQa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoJoRWIXXKenSZIACBVSrsMb+MnI7fzmZScBaCVp08aa0v8qd79UWWenUHQZ8i3d1jrovfu2+9ji/IXprjXUlyF+hSkHjNn3pUgJeVg7bv/nI8c4wjlvAEWwytReL2jJRx2Rjj0AjP3D4P/k4/XJdgSVgrQAQV7VdRCjbmRB/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uJUSA-0004c3-96; Mon, 26 May 2025 11:49:06 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uJUS7-000E8i-1Z;
	Mon, 26 May 2025 11:49:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uJUS7-00AUml-17;
	Mon, 26 May 2025 11:49:03 +0200
Date: Mon, 26 May 2025 11:49:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget evaluation
 strategy
Message-ID: <aDQ5D8EFAL6JhMbM@pengutronix.de>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

A short positive feedback: I partially tested this series and committed
patches for PSE support and impressed how easy it is now to configure
and use a switch with PoE support!

For testing I used "Novarq Tactical 1000" switch with Microchip EV14Y36A PSE
evaluation board attached to it.

I didn't had enough equipment for actual prioritization testing,
otherwise I would add my Tested-by here :)

Thank you!

On Sat, May 24, 2025 at 12:56:02PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This series brings support for budget evaluation strategy in the PSE
> subsystem. PSE controllers can set priorities to decide which ports should
> be turned off in case of special events like over-current.
> 
> This patch series adds support for two budget evaluation strategy.
> 1. Static Method:
> 
>    This method involves distributing power based on PD classification.
>    It’s straightforward and stable, the PSE core keeping track of the
>    budget and subtracting the power requested by each PD’s class.
> 
>    Advantages: Every PD gets its promised power at any time, which
>    guarantees reliability.
> 
>    Disadvantages: PD classification steps are large, meaning devices
>    request much more power than they actually need. As a result, the power
>    supply may only operate at, say, 50% capacity, which is inefficient and
>    wastes money.
> 
> 2. Dynamic Method:
> 
>    To address the inefficiencies of the static method, vendors like
>    Microchip have introduced dynamic power budgeting, as seen in the
>    PD692x0 firmware. This method monitors the current consumption per port
>    and subtracts it from the available power budget. When the budget is
>    exceeded, lower-priority ports are shut down.
> 
>    Advantages: This method optimizes resource utilization, saving costs.
> 
>    Disadvantages: Low-priority devices may experience instability.
> 
> The UAPI allows adding support for software port priority mode managed from
> userspace later if needed.
> 
> Patches 1-2: Add support for interrupt event report in PSE core, ethtool
> 	     and ethtool specs.
> Patch 3: Adds support for interrupt and event report in TPS23881 driver.
> Patches 4,5: Add support for PSE power domain in PSE core and ethtool.
> Patches 6-8: Add support for budget evaluation strategy in PSE core,
> 	     ethtool and ethtool specs.
> Patches 9-11: Add support for port priority and power supplies in PD692x0
> 	      drivers.
> Patches 12,13: Add support for port priority in TPS23881 drivers.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> ---
> Changes in v12:
> - Rebase on net-next.
> - Link to v11: https://lore.kernel.org/r/20250520-feature_poe_port_prio-v11-0-bbaf447e1b28@bootlin.com
> 
> Changes in v11:
> - Move the PSE events enum description fully in the ethtool spec.
> - Remove the first patch which was useless as not used.
> - Split the second patch to separate the attached_phydev introduction to
>   the PSE interrupt support.
> - Link to v10: https://lore.kernel.org/r/20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com
> 
> Changes in v10:
> - Change patch 2 and 7 due to possible used after free scenario or
>   deadlock scenario. Move the PSE notification send management to a
>   workqueue to protect it from the deadlock scenario.
> - Link to v9: https://lore.kernel.org/r/20250422-feature_poe_port_prio-v9-0-417fc007572d@bootlin.com
> 
> Changes in v9:
> - Add a missing check after skb creation.
> - Link to v8: https://lore.kernel.org/r/20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com
> 
> Changes in v8:
> - Rename a few functions for better clarity.
> - Add missing kref_init in PSE power domain support and a wrong error
>   check condition.
> - Link to v7: https://lore.kernel.org/r/20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com
> 
> Changes in v7:
> - Add reference count and mutex lock for PSE power domain.
> - Add support to retry enabling port that failed to be powered in case of
>   port disconnection or priority change.
> - Use flags definition for pse events in ethtool specs.
> - Small changes in the TPS23881 driver.
> - Link to v6: https://lore.kernel.org/r/20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com
> 
> Changes in v6:
> - Few typos.
> - Use uint instead of bitset for PSE_EVENT.
> - Remove report of budget evaluation strategy in the uAPI.
> - Link to v5: https://lore.kernel.org/r/20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com
> 
> Changes in v5:
> - Remove the first part of the patch series which tackled PSE
>   improvement and already gets merged:
>   https://lore.kernel.org/netdev/20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com/
> - Remove the PSE index support which is useless for now. The PSE power
>   domain ID is sufficient.
> - Add support for PD692x0 power supplies other than Vmain which was already
>   in the patch series.
> - Few other small fixes.
> - Link to v4: https://lore.kernel.org/r/20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com
> 
> Changes in v4:
> - Remove disconnection policy.
> - Rename port priority mode to budget evaluation strategy.
> - Add cosmetic changes in PSE core.
> - Add support for port priority in PD692x0 driver.
> - Link to v3: https://lore.kernel.org/r/20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com
> 
> Changes in v3:
> - Move power budget to regulator core.
> - Add disconnection policies with PIs using the same priority.
> - Several fixes on the TPS23881 drivers.
> - Several new cosmetic patches.
> - Link to v2: https://lore.kernel.org/r/20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com
> 
> Changes in v2:
> - Rethink the port priority management.
> - Add PSE id.
> - Add support for PSE power domains.
> - Add get power budget regulator constraint.
> - Link to v1: https://lore.kernel.org/r/20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com
> 
> ---
> Kory Maincent (13):
>       net: pse-pd: Introduce attached_phydev to pse control
>       net: pse-pd: Add support for reporting events
>       net: pse-pd: tps23881: Add support for PSE events and interrupts
>       net: pse-pd: Add support for PSE power domains
>       net: ethtool: Add support for new power domains index description
>       net: pse-pd: Add helper to report hardware enable status of the PI
>       net: pse-pd: Add support for budget evaluation strategies
>       net: ethtool: Add PSE port priority support feature
>       net: pse-pd: pd692x0: Add support for PSE PI priority feature
>       net: pse-pd: pd692x0: Add support for controller and manager power supplies
>       dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
>       net: pse-pd: tps23881: Add support for static port priority feature
>       dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description
> 
>  .../bindings/net/pse-pd/microchip,pd692x0.yaml     |   22 +-
>  .../bindings/net/pse-pd/ti,tps23881.yaml           |    8 +
>  Documentation/netlink/specs/ethtool.yaml           |   76 ++
>  Documentation/networking/ethtool-netlink.rst       |   49 +
>  drivers/net/mdio/fwnode_mdio.c                     |   26 +-
>  drivers/net/pse-pd/pd692x0.c                       |  225 +++++
>  drivers/net/pse-pd/pse_core.c                      | 1068 +++++++++++++++++++-
>  drivers/net/pse-pd/tps23881.c                      |  403 +++++++-
>  include/linux/ethtool_netlink.h                    |    9 +
>  include/linux/pse-pd/pse.h                         |  108 +-
>  include/uapi/linux/ethtool_netlink_generated.h     |   40 +
>  net/ethtool/pse-pd.c                               |   63 ++
>  12 files changed, 2043 insertions(+), 54 deletions(-)
> ---
> base-commit: 573d51a171a9237a8ecd9921d9c69af74cc51ce8
> change-id: 20240913-feature_poe_port_prio-a51aed7332ec
> 
> Best regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

