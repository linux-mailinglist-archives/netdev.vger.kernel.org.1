Return-Path: <netdev+bounces-251465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBAwClxqcWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-251465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:07:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A24505FD10
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D463D743B75
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365FD3EDAB5;
	Tue, 20 Jan 2026 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIFF6mYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6440FDAC
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909306; cv=none; b=sYxBjBOE5h3/2yRgyOcUFmQkqfAvWlS2C1/hjoqiK6CAV9rJDAIgsPX2irOxC+lz6078c1XBqm4nwgvNyQC9fks2PKOFsLX3WKeEp3V6MuhSlaBB9v/+T7ZOFAYUgVezRPqNzWENtn36rr412n1MreSIe9x0KsFH+Ty0/ULy4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909306; c=relaxed/simple;
	bh=2OE/hSoh1It8bhcmM1nk9V99B9U/eNy3jRJxpR7UOWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zeqs1tLqXJCcG4I7/rdqtQj7fUtKnVhtGuVop6xkX8l3+hVIOiLS9zPFhh9gl3LFRUc0oHRu+joqteCCNzSix/Gr7JwcKZJUz+J95ohYDvXB47mgDTq30GLGGYljwCvZJLpCE6NeKWUL6jf9aHGhkeJB3YxZHCbqCBr72syakYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIFF6mYx; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5416386eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768909303; x=1769514103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjkNqktI4MZMt6SSfHT5UbzSxH8+GJApfRaBdqEuizY=;
        b=UIFF6mYx2dZkW2YyBu46xc/JcAdbXfHwdZd4q1/IQM03y1I00PaeuTgdIo8l7YRQ8l
         vytXN83hV/lPiWSxzUbN06PE46qk9gdgtpIW9vLdM7cRSImFWA23oCb4r2JG778l9zYT
         qEQ607Btu9LXwXrktdFFFvOpdNpLEbjHVpoWyktO31DAYChpHTGxC267aSJ93PP7qz4x
         Aswzek26AFUVMThFtHHJsu/d39AeNhISjgB1bJ4J+P7CC7hslnRm6vQiu9kp5/3VZhGj
         n0Vp+pogAcW7fUPucmJwbPqhNPBelwH+msv/qW3dnwrF9shVFiF5S7u4ye4U761plhrT
         0X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909303; x=1769514103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjkNqktI4MZMt6SSfHT5UbzSxH8+GJApfRaBdqEuizY=;
        b=BUU1/T9x2lMmzKj+WCkJrbPNv6GcUaWbojMwrQv54JURxBT7sl2hgUGruYQPisaWAe
         tplN+nz++HzVnMONjc7i1Z8zUZYLl/mvT6/67ue5Tqnbix2RgBAng2Hd1WojcZWY95wu
         5TZ6zt52UNi4fiQRoNdrRXVskzDxmiOZux2EalY8dbeA00BBzb1CHB8oJWuJbplkYlD2
         11S1cMQFZGNewringCsCfmBREG4IeJWFqDqEDILAvnTGIsj+ihZ0rYhriivU5zHM4Uue
         r8lSOCz//71AJPxaRu8g6JRVz5JhJvXL9YuodYXfynvAYxq4UIbmkDLNOL5m2aCQmLCq
         nz4g==
X-Gm-Message-State: AOJu0Yzq1Vy5UNBZvxdWN18zyCoowrjdLKWCnB4SfXC7p804GhtPvS4y
	ifVR6vSQyJTqX3zuWc9P1+b+S5gX5z8dlavkz8lflnatFbdVAgvIsddQ
X-Gm-Gg: AZuq6aJZh6D5Km8Tz3yB4SBsKNUVo0nvxGbB7g3k95VZV5ML4/8zhTLGrbDdtnD8n5z
	NPqE+qzrLCLRBmsJ4Iy7lVJvtLFv9gmGZErXgWnd59A7h9QQwTRuYRsURUOedhc9LxObe8lBovy
	NO2T5ySVkFvvKNupb9x/gBn0z2ZHb7N/nI2JXDQmZEZz3f05kthDIpUORbtA8uwpvvtE0urBv7Z
	PoTRdQDKPD2QnsZFbim6KOHFs38v6S8DTx6BpTkAcUwamh6th7PWwHym0LJvp7hroKT4aVESZwz
	xSDCxbjgJ7mz72ToIr2Q/Euj9T5hN4fWM83pBz9KUsaDG8yn9Pfy2Cg1OrvcKRgjSHsBABLQuXI
	G4EGmep6w9FO9uss6tWtFTndfBa8Zok1bS9+SCjeAhs5CtK5tgsoPeiOwsxKQahR6xYAKP34rT+
	Xwp94ew75yrw==
X-Received: by 2002:a05:7301:3d0d:b0:2ab:ca55:89c6 with SMTP id 5a478bee46e88-2b6b412b2cemr9952612eec.41.1768909302992;
        Tue, 20 Jan 2026 03:41:42 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6c2de1f29sm14737037eec.15.2026.01.20.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:41:42 -0800 (PST)
Date: Tue, 20 Jan 2026 19:41:32 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yao Zi <me@ziyao.cc>, Inochi Amaoto <inochiama@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Yao Zi <ziyao@disroot.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Choong Yong Liang <yong.liang.choong@linux.intel.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3
 SoC
Message-ID: <aW9plNvIujPTqHtZ@inochi.infowork>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
 <aW9jbqBSgkiLLw8r@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9jbqBSgkiLLw8r@pie>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[36];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-251465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziyao.cc,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A24505FD10
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 11:13:50AM +0000, Yao Zi wrote:
> On Tue, Jan 20, 2026 at 12:36:08PM +0800, Inochi Amaoto wrote:
> > Adds Spacemit dwmac driver support on the Spacemit K3 SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 224 ++++++++++++++++++
> >  3 files changed, 237 insertions(+)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> > new file mode 100644
> > index 000000000000..72744e60d02a
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> > @@ -0,0 +1,224 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Spacemit DWMAC platform driver
> > + *
> > + * Copyright (C) 2026 Inochi Amaoto <inochiama@gmail.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/math.h>
> 
> These are the only two headers listed out-of-order. Is this intended?
> 

I will fix this.

> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> 
> ...
> 
> > +static int spacemit_dwmac_detected_delay_value(unsigned int delay,
> > +					       unsigned int *config)
> > +{
> > +	int i;
> > +	int code, best_code = 0;
> > +	unsigned int best_delay = 0;
> > +	unsigned int best_config = 0;
> > +
> > +	if (delay == 0)
> > +		return 0;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(k3_delay_step_10x); i++) {
> > +		unsigned int step = k3_delay_step_10x[i];
> > +
> > +		for (code = 1; code <= MAX_DLINE_DELAY_CODE; code++) {
> > +			/*
> > +			 * Note K3 require a specific factor for calculate
> > +			 * the delay, in this scenario it is 0.9. So the
> > +			 * formula is code * step / 10 * 0.9
> > +			 */
> > +			unsigned int tmp = code * step * 9 / 10 / 10;
> > +
> > +			if (abs(tmp - delay) < abs(best_delay - delay)) {
> > +				best_code = code;
> > +				best_delay = tmp;
> > +				best_config = i;
> > +			}
> 
> Is the inner loop really necessary? Could it be replaced by
> 
> 	this_code = DIV_ROUND_CLOSEST(delay * 10 * 10, step * 9);
> 	this_delay = this_code * step * 9 / 10 / 10;
> 
> Then comparing abs(this_delay - delay) and abs(best_delay - delay)?
> 

This is a good idea, thanks.

> > +		}
> > +	}
> > +
> > +	*config = best_config;
> > +
> > +	return best_code;
> > +}
> 
> ...
> 
> > +static int spacemit_dwmac_update_ifconfig(struct plat_stmmacenet_data *plat_dat,
> > +					  struct stmmac_resources *stmmac_res,
> > +					  struct regmap *apmu,
> > +					  unsigned int ctrl_offset)
> > +{
> > +	unsigned int mask = PHY_INTF_MII | PHY_INTF_RGMII | WAKE_IRQ_EN;
> > +	unsigned int val = 0;
> > +
> > +	switch (plat_dat->phy_interface) {
> > +	case PHY_INTERFACE_MODE_MII:
> > +		val |= PHY_INTF_MII;
> > +		break;
> 
> The OR operation seems unnecessary and could be replaced with an
> assignment. Same for PHY_INTERFACE_MODE_RGMII's case.
> 

That's tree, an assignment is better than the OR operation, I will
change this in the next version.

> > +
> > +	case PHY_INTERFACE_MODE_RMII:
> > +		break;
> > +
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +		val |= PHY_INTF_RGMII;
> > +		break;
> > +
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> 
> ...
> 
> > +static int spacemit_dwmac_probe(struct platform_device *pdev)
> > +{
> 
> ...
> 
> > +	of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps", &tx_delay);
> > +	of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps", &rx_delay);
> 
> According to of.h, of_property_read_u32, which in turn calls
> of_property_read_u32_array, could fail with -ENODATA if there's no value
> associated with the property. Should the case be handled?
> 
> Regards,
> Yao Zi

