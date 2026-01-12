Return-Path: <netdev+bounces-249206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62863D15720
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E8F43038070
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D0341072;
	Mon, 12 Jan 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI6ZuP5k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1207259C92
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253512; cv=none; b=WESYbqxke0Cyuvql94bvdLyNxQBRz6XqIVGbXpMrIyaeSk6ieVFS/iU9dNUfLjX5Qcpts860aElHYUxxU/sj+3KcNEwm0eH8KSO7kPWnCKj+YbX7HUvYkCf8JQlNrKdnN4oGL9EkkWNemGWjKBpqkZuL2SIf+rsz02YwmjXZ/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253512; c=relaxed/simple;
	bh=/fNLp8qv24765kD68dagU/blGDpfuFLIf1JRcIvriQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDxkNCGdgODzP3rAInIgtSQ3HoyU4oR0Iim3inOosohCt9fB4aROULAkHBvGJpmMqLVlcuPLG5X1F2Wzoqj55BTlsvjmFLJrCZsub2mWeF3v9CeeT6R6//L6AMKhfdLu6lJsddXt2IPmLql921tIcnrshHdj0xxiPMprIWnbeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI6ZuP5k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779b49d724so7401895e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768253509; x=1768858309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyB95cN21Ac7820lJiFfVd4t5W1gEzud5dsjuETRfq4=;
        b=VI6ZuP5kmKp0S8kze+T0/1qSTjLBWT7kpWJIReYhrR7WkRhuMi3HdpC8RwvXhBg2Su
         Ptsp70t+IZqvIFIga9alcFOXurImv3fnM2Cobxi9IgAVRQ+z/GG8/Yjy3rDKSrz4Jrra
         5aui/pJmY2yB3rdXKy1we4OhUqrtpD1BLJD6JIEyrT9mhH49/0srGmVYehK/UxURkTl7
         HsZYglbgxXAaJ/Tqw39IcyUJXfa69renDztbGpT4pYpixfgUnbfb5F/VbFczJCVgIFuM
         q4xAphcePYPqGWGC1RqyuhCvDh7xjpZxBEnx61UWiZfztoexxKeaTDoJW/C3GzAc/Fx5
         pozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768253509; x=1768858309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyB95cN21Ac7820lJiFfVd4t5W1gEzud5dsjuETRfq4=;
        b=N4wdh3PVsME8Qx+Y4VJlL6UgnBTvpi4G+neRpUJq1qSOujtzuAMf078OWiag/0a5YN
         jD2QUjTHDDv97E6oEW8uoeVMJIwzCNNgGgh4JukMop2jsY1lCENpg3JaRge94UOWE3gL
         uPjOTXPV15la65t4NOR74W40idQzPL7wHgQTruUAq2A0SjiFuoCRy0g+q6zEiSj5CgKj
         3ySVNR4Ox4Ts08J5CbA1bBIxEIoR7x9vshAjUtW4NIL0foMgSB8NlKDQkjtlBV8dOgGQ
         +d0nADuJLfPsdc0V2EVb6lmfXZOr1BqIxf5r+FcnmuJXX5xpHTZxfgNvnlO9IShQzCrF
         oixA==
X-Forwarded-Encrypted: i=1; AJvYcCWRrdxo5Ed82XP5LaqRqWzrF1NUq3voQZpzGO363mv2hEERR2pcWl7VmB/6Ik7urzkSFIKfG1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMcKK5Vry/ODiTjfvJnpSLprjnU8PHim/2sHTRKQvk3O2g04L
	7VxdwK/2jC0/U7ONyc2uKiUkLmx9sJQEi33cHuVDvMKG6ZkzMKTsWpLj
X-Gm-Gg: AY/fxX7AooTVV+tS2w2X2MUGAMNn0iEcBmzfZOaUJmfYHS4VTmafcMOXDXS7OcOQ2PQ
	z3sKan/ahk/PyaJwgMij+oH4RZNKv4sKw3PhH54TrfI4+Aiyi07ScCM149Ikiua6fhH8YKIOij+
	6O1LRN34fmxvWkyeSonDA97aPu7ybHn8TryYaT0cub2e7po5bOYAIjN3Ar7UTlpaWyzTM2FpLeP
	W+wl8ySFY3vA7hzK8ILJR6NRkRxPcSYFZrWMtA9kuzyG/n1DgmruSR/gWYM9f8bwH+3WUK1UAHJ
	J2tAuBdzDJHj8hnJ8SFj6IJhntNk6VgcN9oWPUA1AYmggxddHntEleCwsbf0qZ+sgelCfvKRSbe
	++FUvbL4Xg9HNsk/Ee1JlekB67sSVfEOx3eexeU4qvU2GTRVz3I3MaMhVLVJrCmtk57qt5wOuSA
	ugkA==
X-Google-Smtp-Source: AGHT+IFoNn4Sp3mBwmgrhdGOCGOtQfNUC6BIxJRaPuwmDyn4u4ZjqvvjHMOse1pFzAzSk6T54pMZCQ==
X-Received: by 2002:a05:600c:a48:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-47d84b34ab6mr136470025e9.3.1768253509066;
        Mon, 12 Jan 2026 13:31:49 -0800 (PST)
Received: from skbuf ([2a02:2f04:d804:300:5991:1d11:eff7:807a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7035f2sm355811195e9.12.2026.01.12.13.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:31:47 -0800 (PST)
Date: Mon, 12 Jan 2026 23:31:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: ks8995: Add DSA tagging to KS8995
Message-ID: <20260112213145.4sw3mu2oqstbafmb@skbuf>
References: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-2-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-2-1a92832c1540@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-ks8995-dsa-tagging-v1-2-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-2-1a92832c1540@kernel.org>

On Wed, Jan 07, 2026 at 01:57:15PM +0100, Linus Walleij wrote:
> This makes the KS8995 DSA switch use the special tags to direct
> traffic to a specific port and identify traffic coming in on a
> specific port.
> 
> These tags are not available on the sibling devices KSZ8895
> or KSZ8795.
> 
> To do this the switch require us to enable "special tags" in a
> register, then enable tag insertion on the CPU port, meaning the
> CPU port will deliver packets with a special tag indicating which
> port the traffic is coming from, and then we need to enable
> tag removal on all outgoing (LAN) ports, this means that the
> special egress tag is stripped off by the switch before exiting
> the PHY-backed ports.
> 
> Add a MAINTAINERS entry while we're at it.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  MAINTAINERS              |  8 +++++
>  drivers/net/dsa/Kconfig  |  1 +
>  drivers/net/dsa/ks8995.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..310accf05153 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16942,6 +16942,14 @@ F:	drivers/bus/mhi/
>  F:	drivers/pci/endpoint/functions/pci-epf-mhi.c
>  F:	include/linux/mhi.h
>  
> +MICREL KS8995 DSA SWITCH
> +M:	Linus Walleij <linusw@kernel.org>
> +S:	Supported
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml
> +F:	drivers/net/dsa/ks8995.c
> +F:	net/dsa/tag_ks8995.c
> +
>  MICROBLAZE ARCHITECTURE
>  M:	Michal Simek <monstr@monstr.eu>
>  S:	Supported
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 7eb301fd987d..8925308cc7d7 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -97,6 +97,7 @@ config NET_DSA_KS8995
>  	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
>  	depends on SPI
>  	select NET_DSA_TAG_NONE
> +	select NET_DSA_TAG_KS8995
>  	help
>  	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
>  	  switches, managed over SPI.
> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> index 77d8b842693c..00c8c7853c61 100644
> --- a/drivers/net/dsa/ks8995.c
> +++ b/drivers/net/dsa/ks8995.c
> @@ -3,7 +3,7 @@
>   * SPI driver for Micrel/Kendin KS8995M and KSZ8864RMN ethernet switches
>   *
>   * Copyright (C) 2008 Gabor Juhos <juhosg at openwrt.org>
> - * Copyright (C) 2025 Linus Walleij <linus.walleij@linaro.org>
> + * Copyright (C) 2025-2026 Linus Walleij <linusw@kernel.org>
>   *
>   * This file was based on: drivers/spi/at25.c
>   *     Copyright (C) 2006 David Brownell
> @@ -338,6 +338,12 @@ static int ks8995_reset(struct ks8995_switch *ks)
>  	return ks8995_start(ks);
>  }
>  
> +static bool ks8995_is_ks8995(struct ks8995_switch *ks)
> +{
> +	return ((ks->chip->family_id == FAMILY_KS8995) &&
> +		(ks->chip->chip_id == KS8995_CHIP_ID));
> +}
> +
>  /* ks8995_get_revision - get chip revision
>   * @ks: pointer to switch instance
>   *
> @@ -532,12 +538,89 @@ dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
>  					 int port,
>  					 enum dsa_tag_protocol mp)
>  {
> -	/* This switch actually uses the 6 byte KS8995 protocol */
> +	struct ks8995_switch *ks = ds->priv;
> +
> +	if (ks8995_is_ks8995(ks))
> +		/* This switch uses the KS8995 protocol */
> +		return DSA_TAG_PROTO_KS8995;
> +
>  	return DSA_TAG_PROTO_NONE;
>  }
>  
> +/* Only the KS8995 supports special (DSA) tagging with special bits
> + * set for the ingress and egress ports. The "special tag" register bit
> + * in the other versions is used for clock edge setting so make sure
> + * to only enable this on the KS8995.

Can you enumerate the part numbers for which this special tag doesn't
exist? I see there is some overlap between switches supported by the
ks8995 driver and the ksz_common driver, correct? At least KSZ8864 and
KSZ8795 can be seen in the ksz_common driver as well, and there they use
the "ksz8795" tail tagging protocol. Correct? Are these the same part
numbers?

> + */
> +static int ks8995_special_tags_setup(struct ks8995_switch *ks)
> +{
> +	int ret;
> +	u8 val;
> +	int i;
> +
> +	ret = ks8995_read_reg(ks, KS8995_REG_GC9, &val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to read KS8995_REG_GC9\n");
> +		return ret;
> +	}
> +
> +	/* Enable the "special tag" (the DSA port tagging) */
> +	val |= KS8995_GC9_SPECIAL;
> +
> +	ret = ks8995_write_reg(ks, KS8995_REG_GC9, val);
> +	if (ret)
> +		dev_err(ks->dev, "failed to set KS8995_REG_GC11\n");

Does it make sense to introduce ks8995_rmw_reg()?
Also, I believe that this register write error should be fatal.

> +
> +	ret = ks8995_read_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC0), &val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to read KS8995_REG_PC0 on CPU port\n");
> +		return ret;
> +	}
> +
> +	/* Enable tag INSERTION on the CPU port, this will add the special KS8995 DSA tag
> +	 * to packets entering from the chip, indicating the source port.
> +	 */
> +	val &= ~KS8995_PC0_TAG_REM;
> +	val |= KS8995_PC0_TAG_INS;
> +
> +	ret = ks8995_write_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC0), val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to write KS8995_REG_PC0 on CPU port\n");
> +		return ret;
> +	}
> +
> +	/* Enable tag REMOVAL on all the LAN-facing ports: this will strip the special
> +	 * DSA tag that we add during transmission of the egress packets before they exit
> +	 * the router chip.
> +	 */

Ok, but I disagree with the explanation. The special tag is a VLAN tag,
and is treated as such. These settings actually make the user ports
egress-untagged for all VLANs, and the CPU port egress-tagged for all
VLANs. Right?

This is fine for now, because there is no bridge offloading, but the code
positioning will have to be revisited by then (the driver will have to
count its egress-tagged and egress-untagged VLANs on each port, and
reject combinations of tagged+untagged, similar to ocelot_vlan_prepare()).

> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC0), &val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to read KS8995_REG_PC0 on port %d\n", i);
> +			return ret;
> +		}
> +
> +		val |= KS8995_PC0_TAG_REM;
> +		val &= ~KS8995_PC0_TAG_INS;
> +
> +		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC0), val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to write KS8995_REG_PC0 on port %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int ks8995_setup(struct dsa_switch *ds)
>  {
> +	struct ks8995_switch *ks = ds->priv;
> +
> +	if (ks8995_is_ks8995(ks))
> +		/* This switch uses the KS8995 protocol */
> +		return ks8995_special_tags_setup(ks);
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.52.0
> 


Some other things I didn't get the chance to comment on, when this
driver was first moved to DSA in August (sorry):
- The ks8995_driver needs a shutdown method that calls
  dsa_switch_shutdown(). This is non-optional, see how other drivers
  call things.
- I have no idea why the driver implements
  ks8995_port_pre_bridge_flags() and ks8995_port_bridge_flags() when it
  doesn't implement port_bridge_join(). This is dead code.
- I see there is no effort being made to implement user port isolation
  via Port Control 1 (KS8995_REG_PC1) bits 4-0 (Port VLAN membership).
  When the tagging protocol was DSA_TAG_PROTO_NONE, let's say this was
  more or less tolerable as a wacky swconfig-style setup, but with a
  tagging protocol implemented, the user ports absolutely have to be
  isolated between each other, and if you want forwarding, you use the
  Linux bridge for that.
- Unbridged user ports are supposed to have address learning disabled.
  This is a bridge-specific function. Having it in ks8995_port_bridge_flags()
  is fine, but you also have to disable it at probe time.

