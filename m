Return-Path: <netdev+bounces-297355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +PBSFuinKGqAHQMAu9opvQ
	(envelope-from <netdev+bounces-297355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF50664DB4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:55:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FYmNCNRL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297355-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E259230A19B7
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890C3EAC86;
	Tue,  9 Jun 2026 23:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77981E492D
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 23:51:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049107; cv=none; b=tTIhvOfpnkyUvlMeihrAtPVz82OADi31OhNCRmsWAiAHuzxlxIqcYOmpVe2meOQ+FRZUUjO/jM5aT3cOEMbOVb6L0YLgxamIw5SlWpfcNi275PeRx1qC5ObwcMeBi+EcbwpST4xNn5R6OOthi6Qf5wIdN3lZy6cFVJXOFcwctLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049107; c=relaxed/simple;
	bh=GFvYv6F5JXSgGBdTvAtYZW/jY+Zo6S7GJXvCZR5lYOg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhzzoGi3a6KweQjEkDZrffbkN8lMcUeMWMplN6KolAeMYf2BFL+XlGciiqOcLvxEPlaUEXYp4yuEjokpNWMzF0HrVgGzgSay5bnk07+6v8zd5PrlnCRaI9LMGz7pzCmLsWy/LDGrhVOiNmnc6QIGH74WwYWI/3p21Yt2QUzH9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYmNCNRL; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4908b92904fso70518875e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 16:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781049104; x=1781653904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sEcoODBbAmHhF71HEbR7vlQdemMO8cJnQFdN0SVH2Vk=;
        b=FYmNCNRLZsa4l7hZoLRwEFsBFMiZf3ZUZoFZVVMtifpI3eOYTPUx1IGBjqbnAVS+Fk
         EA2n2vnau2d3QHnI1cqU4iH8vKx1BU3QoRWtcJB9MS2LkICqzAyINtlfVEGPvYgxDa7e
         e0z0cDE4lYxtDWrNyLI0j827zuIAOwrz5skytVFc83/nteS+mbQRrWWsKwyTta4r63ve
         XOQEppStMLHB41z/aN9BH3M58ZyuvhryiCx/x+4jIwxR7Q8a74JcrnjVMsPuYF7JHoOi
         I63FWzRxioCtWnJyAtD0HOSvF9fbXLjmQW/qaVR2RLSBKmU4WKkIqgwAketGOoC7dgE2
         /89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781049104; x=1781653904;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEcoODBbAmHhF71HEbR7vlQdemMO8cJnQFdN0SVH2Vk=;
        b=UiDHFKjDepH6Ap3u7fbkwU1+ZF5mFuu0cdt7V2G7IGkc2tYBLrEY57e5bmsZPVuDFk
         FMq6gUxHg2g8ay7vC0jhyY7WfZ6MWxNTFnTdsCxopAUo66jGE9qfRDr/WtSgLceUWxYI
         3bP7cWeiOdIcKd8HOXG/qdqNvZNrCeQ+/d27J8CgeB1cjqEEdm/BmOaPlvYFuCz2e/lb
         wJZSa9J6EewQtTAzUkZwxw2bB/sR3NWJxn67wwDiYqoqKGq0SJjpbBBQaXwad05FqxHX
         WuQ6ATArdx61lPBCjETxxP94U0wNmSYedmOVa9oOWwJTol12qU3oiOfUk5yFYbdMqdn3
         Z2yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iIYlgsDNDiVZUMWJ9tFP1Kt0GNo+sYrYzcZD1pMotUKMKcJKe6yCynRIzJgF34adyjm0Xifk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRT3wUPpacNbe6vMJLYREPrg04SU3A4JmNmtuC1bcGPTFJSo2
	yRhIHyIJk5nsdvxChFdEIWLyjxIap3myaZTidY6Cjc1UJDA3N0rnD+gt
X-Gm-Gg: Acq92OEA5kthEb1/8GcZcZH1Vi5wXvHa2MEx2Rv86ipogwNnAVSl5y7O8WtxRqd9Y+H
	gYnYH8eG8JWRMr3ybgBbDqcK+Nn1144YE1FXYnqcUalb34gJfOuMKTQ98EfUIiGJh3VBm8YVEzO
	9bRv4bTncPAnEMTIaPPxer6r48xcAriPYKq5eMYQ9uwLOaFBMwooiH/F0Wh+t0d/IAAkmCmZNkQ
	BJBtr3JlVH30CABgjTHY476uGfqqoYQglwpRctQnFINiYoA4+kZaUwsPJbWZBBQdTHhxT/AeaYU
	t7uGcPZ9SGThmYJYGiQdl4DAfOGh0TjQL4XqoqJroJ4piqHQYR7XeHX7SbNGnvkYwoll9YV4ct6
	lJ3gvoyBlx2K4FxQy0aZSoYm1sD1x0u6uWuiY/XfvmJulJLXAld+gQyGFCFukH61xX2ciqHmRW3
	UlnT/r1yQBHZWIbI1R5A+5C+bCT1jlsTOjUOZPT9YOxsUi4xfQEuRq/oZDk3dMwWZx
X-Received: by 2002:a05:600c:c165:b0:490:a2fd:e1e5 with SMTP id 5b1f17b1804b1-490c2623527mr425785595e9.17.1781049103934;
        Tue, 09 Jun 2026 16:51:43 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dcaa924bsm23335215e9.1.2026.06.09.16.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:51:43 -0700 (PDT)
Message-ID: <6a28a70f.3dabba3e.312002.39c0@mx.google.com>
X-Google-Original-Message-ID: <aiinCyCvlCBpEVQX@Ansuel-XPS.>
Date: Wed, 10 Jun 2026 01:51:39 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v6 12/12] net: airoha: add phylink support
References: <20260609151212.29469-1-ansuelsmth@gmail.com>
 <20260609151212.29469-13-ansuelsmth@gmail.com>
 <aigxaDtZDnI-RTwN@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigxaDtZDnI-RTwN@lore-desk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACF50664DB4

On Tue, Jun 09, 2026 at 05:29:44PM +0200, Lorenzo Bianconi wrote:
> > Add phylink support for each GDM port. For GDM1 add the internal interface
> > mode as the only supported mode. For GDM2/3/4 add the required
> > configuration of the PCS to make the external PHY or attached SFP cage
> > work.
> > 
> > These needs to be defined in the GDM port node using the pcs-handle
> > property.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Hi Christian,
> 
> some nits inline.
> 
> Regards,
> Lorenzo
> 
> > ---
> >  drivers/net/ethernet/airoha/Kconfig       |   1 +
> >  drivers/net/ethernet/airoha/airoha_eth.c  | 167 +++++++++++++++++++++-
> >  drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
> >  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
> >  4 files changed, 181 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
> > index ad3ce501e7a5..38dcc76e5998 100644
> > --- a/drivers/net/ethernet/airoha/Kconfig
> > +++ b/drivers/net/ethernet/airoha/Kconfig
> > @@ -20,6 +20,7 @@ config NET_AIROHA
> >  	depends on NET_DSA || !NET_DSA
> >  	select NET_AIROHA_NPU
> >  	select PAGE_POOL
> > +	select PHYLINK
> >  	help
> >  	  This driver supports the gigabit ethernet MACs in the
> >  	  Airoha SoC family.
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > index 5a8e84fa9918..eabd7b058f82 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/tcp.h>
> > +#include <linux/pcs/pcs.h>
> 
> Can you please respect the alphabetic order?
> 
> >  #include <linux/u64_stats_sync.h>
> >  #include <net/dst_metadata.h>
> >  #include <net/page_pool/helpers.h>
> > @@ -1779,6 +1780,15 @@ static int airoha_dev_open(struct net_device *netdev)
> >  	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
> >  	struct airoha_qdma *qdma = dev->qdma;
> >  
> > +	err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
> > +	if (err) {
> > +		netdev_err(netdev, "%s: could not attach PHY: %d\n", __func__,
> > +			   err);
> 
> Do we need specify the __func__ argument here?
>

I was following a pattern also used in other driver. Maybe we should stop
following it?
 
> > +		return err;
> > +	}
> > +
> > +	phylink_start(dev->phylink);
> > +
> >  	netif_tx_start_all_queues(netdev);
> >  	err = airoha_set_vip_for_gdm_port(dev, true);
> >  	if (err)
> > @@ -1876,6 +1886,9 @@ static int airoha_dev_stop(struct net_device *netdev)
> >  		}
> >  	}
> >  
> > +	phylink_stop(dev->phylink);
> > +	phylink_disconnect_phy(dev->phylink);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -3148,6 +3161,153 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
> >  	return false;
> >  }
> >  
> > +/* Nothing to do in MAC, everything is handled in PCS */
> > +static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
> > +			      const struct phylink_link_state *state)
> > +{
> > +}
> > +
> > +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> > +			       unsigned int mode, phy_interface_t interface,
> > +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +	struct airoha_gdm_dev *dev = container_of(config, struct airoha_gdm_dev,
> > +						  phylink_config);
> > +	struct airoha_gdm_port *port = dev->port;
> > +	struct airoha_eth *eth = dev->eth;
> > +	u32 frag_size_tx, frag_size_rx;
> > +	u32 mask, val;
> > +
> > +	/* TX/RX frag is configured only for GDM4 */
> > +	if (port->id != 4)
> 
> 	if (port->id != AIROHA_GDM4_IDX)
> 		...
> 
> > +		return;
> > +
> > +	switch (speed) {
> > +	case SPEED_10000:
> > +	case SPEED_5000:
> > +		frag_size_tx = 8;
> > +		frag_size_rx = 8;
> > +		break;
> > +	case SPEED_2500:
> > +		frag_size_tx = 2;
> > +		frag_size_rx = 1;
> > +		break;
> > +	default:
> > +		frag_size_tx = 1;
> > +		frag_size_rx = 0;
> > +	}
> > +
> > +	/* Configure TX/RX frag based on speed */
> > +	if (dev->nbq == 1) {
> > +		mask = GDMA4_SGMII1_TX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDMA4_SGMII1_TX_FRAG_SIZE_MASK,
> > +				 frag_size_tx);
> > +	}  else {
> > +		mask = GDMA4_SGMII0_TX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> > +				 frag_size_tx);
> > +	}
> > +	airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG, mask, val);
> > +
> > +	if (dev->nbq == 1) {
> > +		mask = GDMA4_SGMII1_RX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDMA4_SGMII1_RX_FRAG_SIZE_MASK,
> > +				 frag_size_tx);
> > +	} else {
> > +		mask = GDMA4_SGMII0_RX_FRAG_SIZE_MASK;
> > +		val = FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> > +				 frag_size_tx);
> > +	}
> > +	airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG, mask, val);
> > +}
> > +
> > +/* Nothing to do in MAC, everything is handled in PCS */
> > +static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
> > +				 phy_interface_t interface)
> > +{
> > +}
> > +
> > +static const struct phylink_mac_ops airoha_phylink_ops = {
> > +	.mac_config = airoha_mac_config,
> > +	.mac_link_up = airoha_mac_link_up,
> > +	.mac_link_down = airoha_mac_link_down,
> > +};
> > +
> > +static int airoha_fill_available_pcs(struct phylink_config *config,
> > +				     struct phylink_pcs **available_pcs,
> > +				     unsigned int num_available_pcs)
> > +{
> > +	struct device *dev = config->dev;
> > +
> > +	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> > +					&num_available_pcs);
> > +}
> > +
> > +static int airoha_setup_phylink(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_dev *dev = netdev_priv(netdev);
> > +	struct device_node *np = netdev->dev.of_node;
> > +	struct airoha_gdm_port *port = dev->port;
> > +	struct phylink_config *config;
> > +	phy_interface_t phy_mode;
> > +	struct phylink *phylink;
> > +	int err;
> > +
> > +	err = of_get_phy_mode(np, &phy_mode);
> > +	if (err) {
> > +		dev_err(&netdev->dev, "incorrect phy-mode\n");
> > +		return err;
> > +	}
> > +
> > +	config = &dev->phylink_config;
> 
> remove new-line here.
> 
> > +
> > +	config->dev = &netdev->dev;
> > +	config->type = PHYLINK_NETDEV;
> > +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |  MAC_10000FD;
> > +	if (port->id > AIROHA_GDM1_IDX)
> 
> maybe
> 	if (port->id != AIROHA_GDM1_IDX)
> 		...
> 
> > +		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000 |
> > +					    MAC_2500FD | MAC_5000FD;
> > +
> > +	err = fwnode_phylink_pcs_parse(dev_fwnode(&netdev->dev), NULL,
> > +				       &config->num_available_pcs);
> > +	if (err)
> > +		return err;
> > +
> > +	config->fill_available_pcs = airoha_fill_available_pcs;
> > +
> > +	/*
> > +	 * GDM1 only supports internal for Embedded Switch
> > +	 * and doesn't require a PCS.
> > +	 */
> > +	if (port->id == AIROHA_GDM1_IDX) {
> > +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +			  config->supported_interfaces);
> > +	} else {
> > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> > +			  config->supported_interfaces);
> > +
> > +		phy_interface_copy(config->pcs_interfaces,
> > +				   config->supported_interfaces);
> > +	}
> > +
> > +	phylink = phylink_create(config, of_fwnode_handle(np),
> > +				 phy_mode, &airoha_phylink_ops);
> > +	if (IS_ERR(phylink))
> > +		return PTR_ERR(phylink);
> > +
> > +	dev->phylink = phylink;
> > +
> > +	return 0;
> > +}
> > +
> >  static int airoha_alloc_gdm_device(struct airoha_eth *eth,
> >  				   struct airoha_gdm_port *port,
> >  				   int nbq, struct device_node *np)
> > @@ -3210,7 +3370,7 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
> >  	dev->nbq = nbq;
> >  	port->devs[index] = dev;
> >  
> > -	return 0;
> > +	return airoha_setup_phylink(netdev);
> >  }
> >  
> >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> > @@ -3435,8 +3595,10 @@ static int airoha_probe(struct platform_device *pdev)
> >  				continue;
> >  
> >  			netdev = netdev_from_priv(dev);
> > -			if (netdev->reg_state == NETREG_REGISTERED)
> > +			if (netdev->reg_state == NETREG_REGISTERED) {
> > +				phylink_destroy(dev->phylink);
> >  				unregister_netdev(netdev);
> > +			}
> >  			of_node_put(netdev->dev.of_node);
> >  		}
> >  		airoha_metadata_dst_free(port);
> > @@ -3472,6 +3634,7 @@ static void airoha_remove(struct platform_device *pdev)
> >  				continue;
> >  
> >  			netdev = netdev_from_priv(dev);
> > +			phylink_destroy(dev->phylink);
> >  			unregister_netdev(netdev);
> >  			of_node_put(netdev->dev.of_node);
> >  		}
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> > index 8f42973f9cf5..1b25603dc64d 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -554,6 +554,9 @@ struct airoha_gdm_dev {
> >  
> >  	u32 flags;
> >  	int nbq;
> > +
> > +	struct phylink *phylink;
> > +	struct phylink_config phylink_config;
> >  };
> >  
> >  struct airoha_gdm_port {
> > diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
> > index 436f3c8779c1..27f2583e143a 100644
> > --- a/drivers/net/ethernet/airoha/airoha_regs.h
> > +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> > @@ -358,6 +358,18 @@
> >  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
> >  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
> >  
> > +#define REG_GDMA4_TMBI_FRAG		0x2028
> > +#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> > +#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > +#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> > +#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > +
> > +#define REG_GDMA4_RMBI_FRAG		0x202c
> > +#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> > +#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> > +#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> > +#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> > +
> >  #define REG_MC_VLAN_EN			0x2100
> >  #define MC_VLAN_EN_MASK			BIT(0)
> >  
> > -- 
> > 2.53.0
> > 



-- 
	Ansuel

