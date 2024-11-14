Return-Path: <netdev+bounces-144624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004449C7F2A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6980E1F22808
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75256B640;
	Thu, 14 Nov 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hV5UYlwy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AECA94A
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543381; cv=none; b=nMQIyN9j/lQ+U3F6s1msnR5Z0N4/w9Wlo3N3xgrRBZ3fWA3pQ9Oxqv8PLOkTZlTDR2uKt2fgepUD7btubaNowaRvj5MWIGoyHiOpzpNW1WG56OrSnjhUjPWGCAwnH97FJYR3c6wmuFNPhAN/hHpZKHT2PsSkhsGKv9iGwbaSfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543381; c=relaxed/simple;
	bh=SmM9lzE/xl0lhfhPg38MnZXVu+NoZr8qcZF6hb9xj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHeRvijvCBEYPAmXZvL4BQnepficEOjue6VOMNj/gnfVJroIRw45P6wMs6Yu+9+OXcZeZ50RHI2Gz7x7NVFFt/MgMVQasO+FNVzHtqIoJAU9RsBHMrHqVAIC+fXFT4TK0HRkRmCQKrdPGt7DDD915XyHQu8g6NrbQdGWDfPXRUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hV5UYlwy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731543378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGiWMkbbZ4wXd653FrpAzPkRyzlyuoN6kxu5JsuvJxE=;
	b=hV5UYlwyN6pVzi9luWZr18luPVdKjxU4v+Uh1hoUaPoJnryAVCVWqvs3l1uqcgXM4ns42e
	Rc0exU/ufav6fgFj0mpNt0wA8dnmHnulxnMRnGdPRCGInrdN1D9Rx/x0C0xiyrfV0Q5eGY
	b0N32svVGhjBYq69MfbQoVfJfc79An8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-mLhR8um3Pzqku6JpS0Riig-1; Wed, 13 Nov 2024 19:16:16 -0500
X-MC-Unique: mLhR8um3Pzqku6JpS0Riig-1
X-Mimecast-MFC-AGG-ID: mLhR8um3Pzqku6JpS0Riig
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso556855e9.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 16:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731543375; x=1732148175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGiWMkbbZ4wXd653FrpAzPkRyzlyuoN6kxu5JsuvJxE=;
        b=n35MJLVNG0lpoJAb6Fkf1fPytJnbWRw+1TJVd2z/TniNTiKGmhwNMWMgTYZ4LRoU66
         9b6NJ+NeoSA7xV9RhPHskK0lRgu24EIeGdOnubAaCW2yZ+iqX/5eLc3C8y5xVvLu6zcH
         GeUqe/E5Indnm8xitRjKlN8R+AGfpOJQbJubVn0DqarD+trdofaZhZjiVYTyT150M/Ut
         Etbe2T5b2ND/mqjDtEEdpiWghZZvxOMBhX0cd36rtMR1arZq66MLLhVnzPJ4LwaS52Q6
         Fhiy1dq/V7ipg6hQ5h9XV96L6p+f+ReN9C4IX3SGd2712H399lRabixBjUsKuP7OyS3J
         HVQA==
X-Forwarded-Encrypted: i=1; AJvYcCVSndYLBS1DugNoMflvJTHGBviv7qXSN/YjoiZwjZGTItoHm5r3h2tt44TUne7XmgNaEDuluL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hsNhZ5fkQ3hdkzEma1RybjE822RS4kEfn800muH3IJxOpaI4
	Ow9PMwVFsvu/Uo0QMilE+X6l7+T2LwcNqjDv4UOk0ArSW3c3Hud++JP5r4jPiGLohqHTqtQwFUm
	4BQldlcCmxq0dmAUgtlw5b12SfLf5RzoUPCXbSADtMydz92++rLkmqA==
X-Received: by 2002:a05:600c:510a:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-432b74fdee3mr182191895e9.1.1731543375359;
        Wed, 13 Nov 2024 16:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxsk6041ZO1egyOz9QrsKPVB7t17ecHSk68BX7Uss/fbbhsCJduun+tQJJFQH/rQUGXuDMAg==
X-Received: by 2002:a05:600c:510a:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-432b74fdee3mr182191775e9.1.1731543374982;
        Wed, 13 Nov 2024 16:16:14 -0800 (PST)
Received: from debian (2a01cb058d23d600736cb2b04c893998.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:736c:b2b0:4c89:3998])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997313sm19532952f8f.53.2024.11.13.16.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 16:16:13 -0800 (PST)
Date: Thu, 14 Nov 2024 01:16:11 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-omap@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next v3 2/2] net: ethernet: ti: am65-cpsw: enable
 DSCP to priority map for RX
Message-ID: <ZzVBS1zXIy31pnaf@debian>
References: <20241109-am65-cpsw-multi-rx-dscp-v3-0-1cfb76928490@kernel.org>
 <20241109-am65-cpsw-multi-rx-dscp-v3-2-1cfb76928490@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109-am65-cpsw-multi-rx-dscp-v3-2-1cfb76928490@kernel.org>

On Sat, Nov 09, 2024 at 01:00:08PM +0200, Roger Quadros wrote:
> AM65 CPSW hardware can map the 6-bit DSCP/TOS field to
> appropriate priority queue via DSCP to Priority mapping registers
> (CPSW_PN_RX_PRI_MAP_REG).
> 
> We use the upper 3 bits of the DSCP field that indicate IP Precedence
> to map traffic to 8 priority queues.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 0520e9f4bea7..fab35e6aac7f 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -71,6 +71,8 @@
>  #define AM65_CPSW_PORT_REG_RX_PRI_MAP		0x020
>  #define AM65_CPSW_PORT_REG_RX_MAXLEN		0x024
>  
> +#define AM65_CPSW_PORTN_REG_CTL			0x004
> +#define AM65_CPSW_PORTN_REG_DSCP_MAP		0x120
>  #define AM65_CPSW_PORTN_REG_SA_L		0x308
>  #define AM65_CPSW_PORTN_REG_SA_H		0x30c
>  #define AM65_CPSW_PORTN_REG_TS_CTL              0x310
> @@ -94,6 +96,10 @@
>  /* AM65_CPSW_PORT_REG_PRI_CTL */
>  #define AM65_CPSW_PORT_REG_PRI_CTL_RX_PTYPE_RROBIN	BIT(8)
>  
> +/* AM65_CPSW_PN_REG_CTL */
> +#define AM65_CPSW_PN_REG_CTL_DSCP_IPV4_EN	BIT(1)
> +#define AM65_CPSW_PN_REG_CTL_DSCP_IPV6_EN	BIT(2)
> +
>  /* AM65_CPSW_PN_TS_CTL register fields */
>  #define AM65_CPSW_PN_TS_CTL_TX_ANX_F_EN		BIT(4)
>  #define AM65_CPSW_PN_TS_CTL_TX_VLAN_LT1_EN	BIT(5)
> @@ -176,6 +182,53 @@ static void am65_cpsw_port_set_sl_mac(struct am65_cpsw_port *slave,
>  	writel(mac_lo, slave->port_base + AM65_CPSW_PORTN_REG_SA_L);
>  }
>  
> +#define AM65_CPSW_DSCP_MAX	GENMASK(5, 0)
> +#define AM65_CPSW_PRI_MAX	GENMASK(2, 0)
> +#define AM65_CPSW_DSCP_PRI_PER_REG	8
> +#define AM65_CPSW_DSCP_PRI_SIZE		4	/* in bits */
> +static int am65_cpsw_port_set_dscp_map(struct am65_cpsw_port *slave, u8 dscp, u8 pri)
> +{
> +	int reg_ofs;
> +	int bit_ofs;
> +	u32 val;
> +
> +	if (dscp > AM65_CPSW_DSCP_MAX)
> +		return -EINVAL;
> +
> +	if (pri > AM65_CPSW_PRI_MAX)
> +		return -EINVAL;
> +
> +	/* 32-bit register offset to this dscp */
> +	reg_ofs = (dscp / AM65_CPSW_DSCP_PRI_PER_REG) * 4;
> +	/* bit field offset to this dscp */
> +	bit_ofs = AM65_CPSW_DSCP_PRI_SIZE * (dscp % AM65_CPSW_DSCP_PRI_PER_REG);
> +
> +	val = readl(slave->port_base + AM65_CPSW_PORTN_REG_DSCP_MAP + reg_ofs);
> +	val &= ~(AM65_CPSW_PRI_MAX << bit_ofs);	/* clear */
> +	val |= pri << bit_ofs;			/* set */
> +	writel(val, slave->port_base + AM65_CPSW_PORTN_REG_DSCP_MAP + reg_ofs);
> +
> +	return 0;
> +}
> +
> +static void am65_cpsw_port_enable_dscp_map(struct am65_cpsw_port *slave)
> +{
> +	int dscp, pri;
> +	u32 val;
> +
> +	/* Map IP Precedence field to Priority */
> +	for (dscp = 0; dscp <= AM65_CPSW_DSCP_MAX; dscp++) {
> +		pri = dscp >> 3; /* Extract IP Precedence */
> +		am65_cpsw_port_set_dscp_map(slave, dscp, pri);
> +	}
> +
> +	/* enable port IPV4 and IPV6 DSCP for this port */
> +	val = readl(slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> +	val |= AM65_CPSW_PN_REG_CTL_DSCP_IPV4_EN |
> +		AM65_CPSW_PN_REG_CTL_DSCP_IPV6_EN;
> +	writel(val, slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> +}

It seems that this hardware is capable of mapping all possible DSCP
values. Then why restricting the mapping to the 3 high order bits only?
According to RFC 8325 section 2.3, this seem to be a common practice,
which this RFC considers a problem:
https://datatracker.ietf.org/doc/html/rfc8325#section-2.3

I know this RFC is about 802.11, not 802.1p, but as far as I know, the
user priority (UP) are the same for both, so that shouldn't make a
difference.

So what about following the IETF mapping found in section 4.3?
https://datatracker.ietf.org/doc/html/rfc8325#section-4.3

>  static void am65_cpsw_sl_ctl_reset(struct am65_cpsw_port *port)
>  {
>  	cpsw_sl_reset(port->slave.mac_sl, 100);
> @@ -921,6 +974,7 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
>  	common->usage_count++;
>  
>  	am65_cpsw_port_set_sl_mac(port, ndev->dev_addr);
> +	am65_cpsw_port_enable_dscp_map(port);
>  
>  	if (common->is_emac_mode)
>  		am65_cpsw_init_port_emac_ale(port);
> 
> -- 
> 2.34.1
> 
> 


