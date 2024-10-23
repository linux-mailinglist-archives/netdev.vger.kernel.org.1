Return-Path: <netdev+bounces-138185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D69AC86B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CF91C21298
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8519DF45;
	Wed, 23 Oct 2024 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sF2Rp3kn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711DF15C13F;
	Wed, 23 Oct 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681259; cv=none; b=L54wcpL+hNr+mEJUUVwo+3Y22MdpMi4A5tpgsZ2xayLisfr9HIBRDe+6yqstKoJT5Xf8kOZh5TQ8w9Xr4fwZZTx+vqnQDwvxhfUq57SdoDlJz9A2VLh8JmtSRrSmrqjO+OIRvwkK1QPT5vfu2Ea2Y3aniZvNO1ieIJeuwm8JQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681259; c=relaxed/simple;
	bh=gNTtwUARn5PRS9rR2cWgZZqKEgR1+SjxqQ6LRsIxNTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxfC7KkNt33dWiSRKEZDfZSIqqqw/7ZQalVeI1+Qkl5x7b0G5Rq8l+DSfRB2jTony+JWH3+7VQlLJiUJHsOiD7IvdcU616nnHSoUxnRtHN3eZOpLsP6IiYLUrVuoQbXlEVx63NwluUNCrP5/i0EzKWhPkEVWgCRBKVCqpTdiYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sF2Rp3kn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729681257; x=1761217257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNTtwUARn5PRS9rR2cWgZZqKEgR1+SjxqQ6LRsIxNTg=;
  b=sF2Rp3kn2CmlrFDh/gC34wS5WkuBgijOr9E7JngVRvuU+ic5JwJQ2CvI
   LsqDO8N9VlXatGxVXTIp7GacXblRndE/1iZUqlRothyYTZOIB27XwqIWE
   6HTAmDcCfYav0AIKXTfLc4WnaSt9m8Xud9MfGhnAaTYlLRzgFsVMs5tQj
   Z95XsKgL1gfzBFuEDyzuXxGZEX5BwzwX7QGBoU1ovUkLIGTRN2gG2aF71
   MY7mAfHoZrYa2oR0fvTR5vA7b9NI4w7gD6HkR55n581QpmyWUpHWYj/tp
   OOUs0pYRRFiyVsdEnqTK53eo++HjiOWGpAtyry/m6I/Gh2b9rUiljtH2n
   Q==;
X-CSE-ConnectionGUID: xFJ1gZBCTEelQDgk0yaFAw==
X-CSE-MsgGUID: O8SN6ZFJQXyTkpqIH5dq8Q==
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="33153951"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 04:00:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 04:00:38 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 23 Oct 2024 04:00:34 -0700
Date: Wed, 23 Oct 2024 11:00:34 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Message-ID: <20241023110034.jpwoblwrds3ln5nr@DEN-DL-M70577>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
 <cetor3ohhg6rzf3w2cm6hqxsqukh52nm54mp7tizb2qc3x44j4@n53v6btq6t6r>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cetor3ohhg6rzf3w2cm6hqxsqukh52nm54mp7tizb2qc3x44j4@n53v6btq6t6r>

Hi Krzysztof,

> > Add compatible strings for the twelve lan969x SKU's (Stock Keeping Unit)
> > that we support, and verify that the devicetree target is supported by
> > the chip target.
> >
> > Each SKU supports different bandwidths and features (see [1] for
> > details). We want to be able to run a SKU with a lower bandwidth and/or
> > feature set, than what is supported by the actual chip. In order to
> > accomplish this we:
> >
> >     - add new field sparx5->target_dt that reflects the target from the
> >       devicetree (compatible string).
> >
> >     - compare the devicetree target with the actual chip target. If the
> >       bandwidth and features provided by the devicetree target is
> >       supported by the chip, we approve - otherwise reject.
> >
> >     - set the core clock and features based on the devicetree target
> >
> > [1] https://www.microchip.com/en-us/product/lan9698
> >
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
> >  .../net/ethernet/microchip/sparx5/sparx5_main.c    | 194 ++++++++++++++++++++-
> >  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
> >  3 files changed, 193 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
> > index 3435ca86dd70..8fe302415563 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/Makefile
> > +++ b/drivers/net/ethernet/microchip/sparx5/Makefile
> > @@ -19,3 +19,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
> >  # Provide include files
> >  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
> >  ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
> > +ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/lan969x
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > index 5c986c373b3e..edbe639d98c5 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> > @@ -24,6 +24,8 @@
> >  #include <linux/types.h>
> >  #include <linux/reset.h>
> >
> > +#include "lan969x.h" /* lan969x_desc */
> > +
> >  #include "sparx5_main_regs.h"
> >  #include "sparx5_main.h"
> >  #include "sparx5_port.h"
> > @@ -227,6 +229,168 @@ bool is_sparx5(struct sparx5 *sparx5)
> >       }
> >  }
> >
> > +/* Set the devicetree target based on the compatible string */
> > +static int sparx5_set_target_dt(struct sparx5 *sparx5)
> > +{
> > +     struct device_node *node = sparx5->pdev->dev.of_node;
> > +
> > +     if (is_sparx5(sparx5))
> > +             /* For Sparx5 the devicetree target is always the chip target */
> > +             sparx5->target_dt = sparx5->target_ct;
> > +     else if (of_device_is_compatible(node, "microchip,lan9691-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9691VAO;
> > +     else if (of_device_is_compatible(node, "microchip,lan9692-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9692VAO;
> > +     else if (of_device_is_compatible(node, "microchip,lan9693-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9693VAO;
> > +     else if (of_device_is_compatible(node, "microchip,lan9694-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694;
> > +     else if (of_device_is_compatible(node, "microchip,lan9695-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694TSN;
> > +     else if (of_device_is_compatible(node, "microchip,lan9696-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696;
> > +     else if (of_device_is_compatible(node, "microchip,lan9697-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696TSN;
> > +     else if (of_device_is_compatible(node, "microchip,lan9698-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698;
> > +     else if (of_device_is_compatible(node, "microchip,lan9699-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698TSN;
> > +     else if (of_device_is_compatible(node, "microchip,lan969a-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694RED;
> > +     else if (of_device_is_compatible(node, "microchip,lan969b-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696RED;
> > +     else if (of_device_is_compatible(node, "microchip,lan969c-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698RED;
> > +     else
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +/* Compare the devicetree target with the chip target.
> > + * Make sure the chip target supports the features and bandwidth requested
> > + * from the devicetree target.
> > + */
> > +static int sparx5_verify_target(struct sparx5 *sparx5)
> > +{
> > +     switch (sparx5->target_dt) {
> > +     case SPX5_TARGET_CT_7546:
> > +     case SPX5_TARGET_CT_7549:
> > +     case SPX5_TARGET_CT_7552:
> > +     case SPX5_TARGET_CT_7556:
> > +     case SPX5_TARGET_CT_7558:
> > +     case SPX5_TARGET_CT_7546TSN:
> > +     case SPX5_TARGET_CT_7549TSN:
> > +     case SPX5_TARGET_CT_7552TSN:
> > +     case SPX5_TARGET_CT_7556TSN:
> > +     case SPX5_TARGET_CT_7558TSN:
> > +             return 0;
> 
> All this is weird. Why would you verify? You were matched, it cannot be
> mis-matching.

We are verifying that the match (target/compatible string) from the
device tree is supported by the chip. Maybe I wasn't too clear about the
intend in v1.

Each target supports different bandwidths and features. If you have a
lan9698 chip, it must, obviously, be possible to run it as a lan9698
target. However, some targets can be run on chip targets other than
themselves, given that the chip supports the bandwidth and features of
the provided target. In contrary, trying to run as a target with a
feature not supported by the chip, or a bandwidth higher than what the
chip supports, should be rejected.

Without this logic, the chip id is read and a target is determined. That
means on a lan9698 chip you will always match the lan9698 target.

With the new logic, it is possible to run as a different target than
what is read from the chip id, given that the target you are trying to
run as, is supported by the chip.

> 
> > +     case SPX5_TARGET_CT_LAN9698RED:
> > +             if (sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
> 
> What is "ct"? sorry, all this code is a big no.

In this case we were matched as a SPX5_TARGET_CT_LAN9698RED target. We
are verifying that the chip target (target_ct, which is read from the
chip) supports the target we were matched as.

> Krzysztof
>

This is a feature that we would like, as it gives the flexibility of
running different targets on the same chip. Now if this is something
that cannot be accepted, I will have to ditch this part.

Let me know.

/Daniel


