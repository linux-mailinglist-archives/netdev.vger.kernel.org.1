Return-Path: <netdev+bounces-123445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0258964E2B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA00281105
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47FF1B790B;
	Thu, 29 Aug 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dh73UPK9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D81B375A;
	Thu, 29 Aug 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957242; cv=none; b=puOLqWAjmljI0i1EXlfnO7YnXXCsX5cd1bDxLSQc1SyqRspfb97JqS5udWuhooWrLlJzfvPTtZy48/I/gI3oZbbiwEKiR1526YrK5d7OYWC5V3bLSJ42UNIkc2htt88G8wRyec8e4c16BRYkaUa9DWNulVMzIgG9dxZ4cnAhr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957242; c=relaxed/simple;
	bh=lw4WuOtFskiWnrS5jSONbN64nqc3rMpyfJ+XYFxqlkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0T6RopcuYm6Ms+7WKVqgU7GaZPfcg+6NhK99q/Ozpz9ZNNa3frhiyfzgafozwv+0NjEHfYLZfoCOMlQJxD5g+Ic5gNPjuyNeh1D/wJ7JIIySCadOBNSv47hUqBiDXRn07Z0ydYkmKtFVDXvsc8Lr0rV2+2reB+ba031Oson9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dh73UPK9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Bp32jBiqSLZI/T090uDwM/rXDdtbKaMXGudQmiRiig=; b=Dh73UPK996iwRUWWsAZSLIo4gl
	WQ1yBJKYsxSpaVpk9xtkEHAaatmpbrYEjE6Jb2CJV7P0GBkUMWy6gd3iSpmVR3GTaiKv+Ja74Bk/C
	wg7lUORJn2MpT9pQnzDqC5pELllVM7Lrj99+NB8aQrqDw4VHbzkfpn+/0ggPC9RFlaGM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjkAi-0063yr-Gp; Thu, 29 Aug 2024 20:47:04 +0200
Date: Thu, 29 Aug 2024 20:47:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, hkallweit1@gmail.com,
	linux@armlinux.org.uk, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, linux-doc@vger.kernel.org
Subject: Re: [RFC net-next 2/2] net: ethtool: add phy(dev) specific stats
 over netlink
Message-ID: <056e03a1-ed13-40b0-b66d-755dd2760988@lunn.ch>
References: <20240829174342.3255168-1-kuba@kernel.org>
 <20240829174342.3255168-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829174342.3255168-3-kuba@kernel.org>

> +/* Additional PHY statistics, not defined by IEEE */
> +struct ethtool_phy_stats {
> +	/* Basic packet / byte counters are meant for PHY drivers */
> +	u64 rx_packets;
> +	u64 rx_bytes;
> +	u64 rx_error; /* TODO: we need to define here whether packet
> +		       * counted here is also counted as rx_packets,
> +		       * and whether it's passed to the MAC with some
> +		       * error indication or MAC never sees it.
> +		       */
> +	u64 tx_packets;
> +	u64 tx_bytes;
> +	u64 tx_error; /* TODO: same as for rx */
> +};

I'm not sure these are actually useful.

adin.c:
        { "total_frames_checked_count",         0x940A, 0x940B }, /* hi + lo */
        { "length_error_frames_count",          0x940C },
        { "alignment_error_frames_count",       0x940D },
        { "symbol_error_count",                 0x940E },
        { "oversized_frames_count",             0x940F },
        { "undersized_frames_count",            0x9410 },
        { "odd_nibble_frames_count",            0x9411 },
        { "odd_preamble_packet_count",          0x9412 },
        { "dribble_bits_frames_count",          0x9413 },
        { "false_carrier_events_count",         0x9414 },

bcm-phy-lib.c:
        { "phy_receive_errors", -1, MII_BRCM_CORE_BASE12, 0, 16 },
        { "phy_serdes_ber_errors", -1, MII_BRCM_CORE_BASE13, 8, 8 },
        { "phy_false_carrier_sense_errors", -1, MII_BRCM_CORE_BASE13, 0, 8 },
        { "phy_local_rcvr_nok", -1, MII_BRCM_CORE_BASE14, 8, 8 },
        { "phy_remote_rcv_nok", -1, MII_BRCM_CORE_BASE14, 0, 8 },
        { "phy_lpi_count", MDIO_MMD_AN, BRCM_CL45VEN_EEE_LPI_CNT, 0, 16 },

icplus.c:
        { "phy_crc_errors", 1 },
        { "phy_symbol_errors", 11, },

marvell.c:
        { "phy_receive_errors_copper", 0, 21, 16},
        { "phy_idle_errors", 0, 10, 8 },
        { "phy_receive_errors_fiber", 1, 21, 16},

micrel.c:
        { "phy_receive_errors", 21, 16},
        { "phy_idle_errors", 10, 8 },

nxp-c45-tja11xx.c:
        { "phy_link_status_drop_cnt",
        { "phy_link_availability_drop_cnt",
        { "phy_link_loss_cnt",
        { "phy_link_failure_cnt",
        { "phy_symbol_error_cnt",
        { "rx_preamble_count",
        { "tx_preamble_count",
        { "rx_ipg_length",
        { "tx_ipg_length",
        { "phy_symbol_error_cnt_ext",
        { "tx_frames_xtd",
        { "tx_frames",
        { "rx_frames_xtd",
        { "rx_frames",
        { "tx_lost_frames_xtd",
        { "tx_lost_frames",
        { "rx_lost_frames_xtd",
        { "rx_lost_frames",

smsc.c:
        { "phy_symbol_errors", 26, 16},

802.3 does not define in PHY statistics, the same as it does not
define any MAC statistics. As a result it is a wild west, vendors
doing whatever they want.

The exception is the Open Alliance, which have defined a number of
different standards defining statistics which Automotive vendors can
optionally follow.

https://opensig.org/automotive-ethernet-specifications/

These could be defined as either one or three groups, with the
expectation more will be added later.

	Andrew

