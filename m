Return-Path: <netdev+bounces-15161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA8745FD4
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0AA1C209AA
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92990100B3;
	Mon,  3 Jul 2023 15:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FD79D5
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:27:27 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250CE58
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:27:26 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 33922212D5;
	Mon,  3 Jul 2023 17:27:24 +0200 (CEST)
Date: Mon, 3 Jul 2023 17:27:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, francesco.dolcini@toradex.com
Subject: Re: [PATCH v1 2/2] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2110 PHY
Message-ID: <ZKLo2NjOJhlK117I@francesco-nb.int.toradex.com>
References: <20230703124440.391970-1-eichest@gmail.com>
 <20230703124440.391970-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703124440.391970-3-eichest@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 02:44:40PM +0200, Stefan Eichenberger wrote:
> Add a driver for the Marvell 88Q2110. This driver is minimalistic, but
> already allows to detect the link, switch between 100BASE-T1 and
> 1000BASE-T1 and switch between master and slave mode. Autonegotiation
> supported by the PHY is not yet implemented.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

...

> --- /dev/null
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Marvell 88Q2XXX automotive 100BASE-T1/1000BASE-T1 PHY driver
> + */
> +
> +#include <linux/marvell_phy.h>
> +#include <linux/phy.h>
> +#include <linux/ethtool_netlink.h>
sort?

> +#define MARVELL_PHY_ID_88Q2110		0x002b0981
> +
> +static int mv88q2xxx_soft_reset(struct phy_device *phydev)
> +{
> +	phy_write_mmd(phydev, 3, 0x0900, 0x8000);
> +
> +	return 0;
Should we `return phy_write_mmd()` to allow error propagation? This
eventually applies to other functions.

Francesco


