Return-Path: <netdev+bounces-111246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178B9305FB
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38043B20F95
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE5137745;
	Sat, 13 Jul 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYzT3Xtb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26113A865;
	Sat, 13 Jul 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720881912; cv=none; b=GvVDO+PfXwVe5E7RA40DjcJKEHrPsH+KgONTP/3fcgYSJJ+BULjGyDe5tAI6TS7RL2T1h+aq0+D1QYWyaDbKgE2aTeibreXsyYCBJ2LjJDB2yV5QhXypgtHxhloEnC5wnyb4sCNCGpcj4ob0c0/KYmZQgy7LbPwaeqotLUmK+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720881912; c=relaxed/simple;
	bh=/SWgNzbJVBtyti4FfmCayIFeMgb7IKVPsUfN62wmNk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnJ92w9cAg/QS/vLTSuakPyzKgA/gP+sHVRXwQ1kK9Od72sIvFGJ+T5opzUjY2IZVmg2drw3MkbiO4VZsIja5gjS8mtDJl7ePW7l6djzPRaE2pjrE6tYkwcfp7fRJJLiEMDY8BVA8fAsifM+zqwODwSS+65tKgXomPZVBh5MqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYzT3Xtb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yhF8Omts//IzlZQskbNJ7mjK8Q3NO/lQnbu9ulrQAgE=; b=tY
	zT3XtbYbLP/jnQz7n9IZHf23hrEHSs7OSHiYTx2M8XbEXuJotOkvUruZhG+VgrwblVJLTFhXuk+DQ
	BfKt5aiuU+0m+hGuFxWJWB2m2M3JaSpdAhVqVSCKij/KoFc5y4OhNPgnaEb9rU1kp2ER2BAgiMCEk
	h1OUdp4qfWQOKn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSdzX-002SiA-W2; Sat, 13 Jul 2024 16:44:51 +0200
Date: Sat, 13 Jul 2024 16:44:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"srk@ti.com" <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split out
 common object into module
Message-ID: <8ef9cb0a-9e0a-4f2e-8799-546ce2be63a7@lunn.ch>
References: <20240712120636.814564-1-danishanwar@ti.com>
 <BY3PR18MB4707DE9F8280CE67EDF3D146A0A72@BY3PR18MB4707.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR18MB4707DE9F8280CE67EDF3D146A0A72@BY3PR18MB4707.namprd18.prod.outlook.com>

On Sat, Jul 13, 2024 at 08:33:42AM +0000, Sai Krishna Gajula wrote:
> > -----Original Message-----
> > From: MD Danish Anwar <danishanwar@ti.com>
> > Sent: Friday, July 12, 2024 5:37 PM
> > To: Heiner Kallweit <hkallweit1@gmail.com>; Simon Horman
> > <horms@kernel.org>; Dan Carpenter <dan.carpenter@linaro.org>; Jan Kiszka
> > <jan.kiszka@siemens.com>; Wolfram Sang <wsa+renesas@sang-
> > engineering.com>; Diogo Ivo <diogo.ivo@siemens.com>; Andrew Lunn
> > <andrew@lunn.ch>; Roger Quadros <rogerq@kernel.org>; MD Danish Anwar
> > <danishanwar@ti.com>; Paolo Abeni <pabeni@redhat.com>; Jakub Kicinski
> > <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>; David S. Miller
> > <davem@davemloft.net>
> > Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; srk@ti.com; Vignesh Raghavendra
> > <vigneshr@ti.com>; Thorsten Leemhuis <linux@leemhuis.info>
> > Subject: [EXTERNAL] [PATCH net-next v3] net: ti: icssg-prueth: Split out
> > common object into module
> > 
> > icssg_prueth. c and icssg_prueth_sr1. c drivers use multiple common .c files.
> > These common objects are getting added to multiple modules. As a result
> > when both drivers are enabled in .config, below warning is seen.
> > drivers/net/ethernet/ti/Makefile: 
> > icssg_prueth.c and icssg_prueth_sr1.c drivers use multiple common .c files.
> > These common objects are getting added to multiple modules. As a result
> > when both drivers are enabled in .config, below warning is seen.
> > 
> > drivers/net/ethernet/ti/Makefile: icssg/icssg_common.o is added to multiple
> > modules: icssg-prueth icssg-prueth-sr1
> > drivers/net/ethernet/ti/Makefile: icssg/icssg_classifier.o is added to multiple
> > modules: icssg-prueth icssg-prueth-sr1
> > drivers/net/ethernet/ti/Makefile: icssg/icssg_config.o is added to multiple
> > modules: icssg-prueth icssg-prueth-sr1
> > drivers/net/ethernet/ti/Makefile: icssg/icssg_mii_cfg.o is added to multiple
> > modules: icssg-prueth icssg-prueth-sr1
> > drivers/net/ethernet/ti/Makefile: icssg/icssg_stats.o is added to multiple
> > modules: icssg-prueth icssg-prueth-sr1
> > drivers/net/ethernet/ti/Makefile: icssg/icssg_ethtool.o is added to multiple
> > modules: icssg-prueth icssg-prueth-sr1
> > 
> > Fix this by building a new module (icssg.o) for all the common objects.
> > Both the driver can then depend on this common module.
> > 
> > Some APIs being exported have emac_ as the prefix which may result into
> > confusion with other existing APIs with emac_ prefix, to avoid confusion,
> > rename the APIs being exported with emac_ to icssg_ prefix.
> > 
> > This also fixes below error seen when both drivers are built.
> > ERROR: modpost: "icssg_queue_pop"
> > [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> > ERROR: modpost: "icssg_queue_push"
> > [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> > 
> > Reported-and-tested-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Closes: https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__lore.kernel.org_oe-2Dkbuild-2Dall_202405182038.ncf1mL7Z-2Dlkp-
> > 40intel.com_&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=c3MsgrR-U-
> > HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=nS910f-bVPllINeciu3zcX-
> > RmmuaN-hU--Y3YDvgknBD5A8sRk6hE3pZSocV-
> > 37f&s=sIjxhBrYXEW3mtC1p8o5MaV-xpJ3n16Ct0mRhE52PCQ&e=
> > Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure
> > FDB")
> > Reviewed-by: Roger Quadros <rogerq@kernel.org>
> > Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> > ---
> > Cc: Thorsten Leemhuis <linux@leemhuis.info>

> > base-commit: 2146b7dd354c2a1384381ca3cd5751bfff6137d6
> > --
> > 2.34.1
> > 
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>

Please trim emails when replying.

If you look what everybody else does with tags like this, they place
it directly after the Signed-off-by: and delete the actual patch.

   Andrew

