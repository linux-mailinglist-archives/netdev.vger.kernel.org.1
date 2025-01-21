Return-Path: <netdev+bounces-159967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D751CA1785F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 08:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779C718846F0
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6508117A58F;
	Tue, 21 Jan 2025 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hT3waeYs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69B1BF24;
	Tue, 21 Jan 2025 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443357; cv=none; b=DgqsJkcerBu/Ygpg0BO6U6B5N1CPc2X5dcyxB+1S6wCaNIs69vdwvmtgTAtLEbrFg9yAThex+PgT1TM43Zwyal4d7N5ko1za6d3ULKUv2j2KwlIHiCHBlNo3MGrMSNsprByPTmV2qxnhD5DGZY3NojDzHvdUGC8Jioj+QHxr6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443357; c=relaxed/simple;
	bh=RLFh8XyWWxDP5m5rANmWVFlEBIT1KM91vYhc8/tFgTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlN2bUJKqMJ9iWLM/71VKNfADoZjTKZSN8d4G78yGquyp6W0e+mNAOC/DGvKZx/FYX3rcbtZKPe62jj9kyUNzgGYRwrtmBiAKppIU3SOt+ihFkXHPTKoPhp9Az1QRGhBLCQXu++ayPGw7JLnmVQMERcR8iANSu8fK8wUvYVYKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hT3waeYs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737443356; x=1768979356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RLFh8XyWWxDP5m5rANmWVFlEBIT1KM91vYhc8/tFgTA=;
  b=hT3waeYsdtIfG+5BUOMyk61B3rsKY5PlkZJ3h6DU3WILFHhQMxTMXv6o
   sERcoulPePXi33RLn5aSDmPvcdxTtRJ/tdNBiyONndMbeBIbWHU8tZ6Rr
   L/8oGC1eO+RAbyeQThppx+VOro0SVf8+uH01T9wNT2H/Y/RlNbuey5Nfv
   IUjT6rz49Pu673ILKqZHfY+Mw/6NDkFZXwvv1k6FoewcsQWSfHC7PcsDv
   rjS2TyKbS03F2x8Ud8UuvcEpkPE5jOyDWaWp/EzvLjwb+xxXjUk5GFlb5
   9yi/Y8Al4QhGdqqzQnqK7cR0mm07NEn5lsz/AfroOwUm4yjixQugCKGcQ
   A==;
X-CSE-ConnectionGUID: VsuGnJ3RTD+D4pBu/eF90A==
X-CSE-MsgGUID: +gBhSaLIQjWzZjCPhUkAEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37725898"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; 
   d="scan'208";a="37725898"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 23:09:15 -0800
X-CSE-ConnectionGUID: CBLSqrz4SIe847ybkI0jyw==
X-CSE-MsgGUID: 4aDPKEj2Rd6JsJNZNdQ4ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106548970"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 23:09:12 -0800
Date: Tue, 21 Jan 2025 08:05:48 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: mvpp2: Add parser configuration for DSA tags
Message-ID: <Z49HTA5MYooJcH0g@mev-dev.igk.intel.com>
References: <20250121021804.1302042-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121021804.1302042-1-aryan.srivastava@alliedtelesis.co.nz>

On Tue, Jan 21, 2025 at 03:18:04PM +1300, Aryan Srivastava wrote:
> Allow the header parser to consider DSA and EDSA tagging. Currently the
> parser is always configured to use the MH tag, but this results in poor
> traffic distribution across queues and sub-optimal performance (in the
> case where DSA or EDSA tags are in the header).
> 
> Add mechanism to check for tag type in use and then configure the
> parser correctly for this tag. This results in proper traffic
> distribution and hash calculation.
> 
> Use mvpp2_get_tag instead of reading the MH register to determine tag
> type. As the MH register is set during mvpp2_open it is subject to
> change and not a proper reflection of the tagging type in use.
> 
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

You didn't specify the tree, but it look like a feature implementation,
not a fix; net-next is closed now [1].

[1] https://lore.kernel.org/netdev/20250120163446.3bd93e30@kernel.org/#t

> ---
> Changes in v1:
> - use mvpp2_get_tag to ascertain tagging type in use.
> 
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  3 ++
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 37 ++++++++++++++++++-
>  .../net/ethernet/marvell/mvpp2/mvpp2_prs.c    | 16 +++++---
>  3 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index 44fe9b68d1c2..456f9aeb4d82 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -59,6 +59,8 @@
>  
>  /* Top Registers */
>  #define MVPP2_MH_REG(port)			(0x5040 + 4 * (port))
> +#define MVPP2_MH_EN				BIT(0)
Defined, but not used.

> +#define MVPP2_DSA_NON_EXTENDED			BIT(4)
>  #define MVPP2_DSA_EXTENDED			BIT(5)
>  #define MVPP2_VER_ID_REG			0x50b0
>  #define MVPP2_VER_PP22				0x10
> @@ -1538,6 +1540,7 @@ void mvpp2_dbgfs_cleanup(struct mvpp2 *priv);
>  void mvpp2_dbgfs_exit(void);
>  
>  void mvpp23_rx_fifo_fc_en(struct mvpp2 *priv, int port, bool en);
> +int mvpp2_get_tag(struct net_device *dev);
>  
>  #ifdef CONFIG_MVPP2_PTP
>  int mvpp22_tai_probe(struct device *dev, struct mvpp2 *priv);
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index dd76c1b7ed3a..3a954da7660f 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -38,6 +38,7 @@
>  #include <net/page_pool/helpers.h>
>  #include <net/tso.h>
>  #include <linux/bpf_trace.h>
> +#include <net/dsa.h>

Nit, can be in alphabetic order (rest is, so it will be cleaner to add
new following alphabetic order).
>  
>  #include "mvpp2.h"
>  #include "mvpp2_prs.h"
> @@ -4769,6 +4770,36 @@ static bool mvpp22_rss_is_supported(struct mvpp2_port *port)
>  		!(port->flags & MVPP2_F_LOOPBACK);
>  }
>  
> +int mvpp2_get_tag(struct net_device *dev)
> +{
> +	int tag;
> +	int dsa_proto = DSA_TAG_PROTO_NONE;

RCT (int dsa_proto before int tag)

> +
> +#if IS_ENABLED(CONFIG_NET_DSA)
> +	if (netdev_uses_dsa(dev))
> +		dsa_proto = dev->dsa_ptr->tag_ops->proto;
> +#endif
> +
> +	switch (dsa_proto) {
> +	case DSA_TAG_PROTO_DSA:
> +		tag = MVPP2_TAG_TYPE_DSA;
> +		break;
> +	case DSA_TAG_PROTO_EDSA:
> +	/**
> +	 * DSA_TAG_PROTO_EDSA and MVPP2_TAG_TYPE_EDSA are
> +	 * referring to separate things. MVPP2_TAG_TYPE_EDSA
> +	 * refers to extended DSA, while DSA_TAG_PROTO_EDSA
> +	 * refers to Ethertype DSA. Ethertype DSA requires no
> +	 * setting in the parser.
> +	 */
> +	default:
> +		tag = MVPP2_TAG_TYPE_MH;
> +		break;

if (dsa_proto == DSA_TAG_PROTO_DSA)
	return MVPP2_TAG_TYPE_DSA

resturn MVPP2_TAG_TYPE_MH;

looks simpler, you can move comment above the if.

> +	}
> +
> +	return tag;
> +}
> +
>  static int mvpp2_open(struct net_device *dev)
>  {
>  	struct mvpp2_port *port = netdev_priv(dev);
> @@ -4788,7 +4819,11 @@ static int mvpp2_open(struct net_device *dev)
>  		netdev_err(dev, "mvpp2_prs_mac_da_accept own addr failed\n");
>  		return err;
>  	}
> -	err = mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH);
> +
> +	if (netdev_uses_dsa(dev))
> +		err = mvpp2_prs_tag_mode_set(port->priv, port->id, mvpp2_get_tag(dev));

In mvpp2_get_tag() netdev_uses_dsa() is guarded by CONFIG_NET_DSA,
shouldn't it be here too? Or better, check for it is already in
mvpp2_get_tag() you can simple call

err = mvpp2_prs_tag_mode_set(port->priv, port->id, mvpp2_get_tag(dev));

as mvpp2_get_tag(dev) returns MVPP2_TAG_TYPE_MH in case
netdev_uses_dsa() returns 0.

> +	else
> +		err = mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH);
>  	if (err) {
>  		netdev_err(dev, "mvpp2_prs_tag_mode_set failed\n");
>  		return err;
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
> index 9af22f497a40..f14b9e8c301e 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
> @@ -1963,7 +1963,7 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
>  {
>  	unsigned int vid_start = MVPP2_PE_VID_FILT_RANGE_START +
>  				 port->id * MVPP2_PRS_VLAN_FILT_MAX;
> -	unsigned int mask = 0xfff, reg_val, shift;
> +	unsigned int mask = 0xfff, tag, shift;
>  	struct mvpp2 *priv = port->priv;
>  	struct mvpp2_prs_entry pe;
>  	int tid;
> @@ -1973,8 +1973,8 @@ int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
>  	/* Scan TCAM and see if entry with this <vid,port> already exist */
>  	tid = mvpp2_prs_vid_range_find(port, vid, mask);
>  
> -	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
> -	if (reg_val & MVPP2_DSA_EXTENDED)
> +	tag = mvpp2_get_tag(port->dev);
> +	if (tag & MVPP2_DSA_EXTENDED)

I will drop tag and use mvpp2_get_tag() directly (it isn't used anywhere
else in this function). This is only preference, ignore it if you prefer
to store it somewhere.

Am I right that code under if is unreachable? tag can be 1 or 2
(MVPP2_TAG_TYPE_MH or MVPP2_TAG_TYPE_DSA) and MVPP2_DSA_EXTENDED is
BIT(5). It looks like sth is missing between getting the tag and
checking it with this value.

>  		shift = MVPP2_VLAN_TAG_EDSA_LEN;
>  	else
>  		shift = MVPP2_VLAN_TAG_LEN;
> @@ -2071,7 +2071,7 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
>  {
>  	unsigned int tid = MVPP2_PRS_VID_PORT_DFLT(port->id);
>  	struct mvpp2 *priv = port->priv;
> -	unsigned int reg_val, shift;
> +	unsigned int tag, shift;
>  	struct mvpp2_prs_entry pe;
>  
>  	if (priv->prs_shadow[tid].valid)
> @@ -2081,8 +2081,8 @@ void mvpp2_prs_vid_enable_filtering(struct mvpp2_port *port)
>  
>  	pe.index = tid;
>  
> -	reg_val = mvpp2_read(priv, MVPP2_MH_REG(port->id));
> -	if (reg_val & MVPP2_DSA_EXTENDED)
> +	tag = mvpp2_get_tag(port->dev);
> +	if (tag & MVPP2_DSA_EXTENDED)

The same here, unreachable.

>  		shift = MVPP2_VLAN_TAG_EDSA_LEN;
>  	else
>  		shift = MVPP2_VLAN_TAG_LEN;
> @@ -2393,6 +2393,8 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
>  				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
>  		mvpp2_prs_dsa_tag_set(priv, port, false,
>  				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
> +		/* Set Marvell Header register for Ext. DSA tag */
> +		mvpp2_write(priv, MVPP2_MH_REG(port), MVPP2_DSA_EXTENDED);
>  		break;
>  
>  	case MVPP2_TAG_TYPE_DSA:
> @@ -2406,6 +2408,8 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
>  				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
>  		mvpp2_prs_dsa_tag_set(priv, port, false,
>  				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
> +		/* Set Marvell Header register for DSA tag */
> +		mvpp2_write(priv, MVPP2_MH_REG(port), MVPP2_DSA_NON_EXTENDED);
>  		break;
>  
>  	case MVPP2_TAG_TYPE_MH:
> -- 
> 2.47.1

