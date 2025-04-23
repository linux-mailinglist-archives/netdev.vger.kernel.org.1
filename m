Return-Path: <netdev+bounces-185220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5919EA99571
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D56188E382
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC6284B42;
	Wed, 23 Apr 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9R+8h+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2835280CD1;
	Wed, 23 Apr 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426069; cv=none; b=dm5IgplUW+q31SShJLv6s4M1RK83zicOghwEfDI7h6nurJo7feRlQuakQVjiikV0ac+Oz+ZUnDDM1ciH2YG3QvMBmHTUvT9p3LnqIKMEEG7lDgF3t12FO1WlyGtkPI85TPeCdVBj7zW++m1EFbmeqUrtwMG6DSBNbuVooWnOvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426069; c=relaxed/simple;
	bh=mN8F7NbzDaBbeVXijWSv4xXDoOWK3C4w28jSbiy3Hms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUOsvQVseB/UsJErbIU1HcIdfSMtGoZIdZVmfIHjSLH3Imgy6ep4ayODDj1IS6H15xQqOVedjafzXQY0MrnfoUdvSpTdYKRgSfc0tp1SPWDU8G5wpchJUOd2vY86Ml9ERC/rSodx3TxE1aCMaIlqyclMS3d7ucgmcV3+JxiPvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9R+8h+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54D7C4CEE2;
	Wed, 23 Apr 2025 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745426068;
	bh=mN8F7NbzDaBbeVXijWSv4xXDoOWK3C4w28jSbiy3Hms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9R+8h+VZLxdc49EdXOrzCaWtvHbYKtHhsO9lJ2niGl1lNAuUgTvPqh/fv5wPfH2u
	 VfzW/eVzN043ohsT93YB9Z9MIrfIHcXEXps2WRxByoc8gS/Ut13n205MlcO6ormi0w
	 A2qH+i78VNkk37qvbeNXaIFeQQRnRbvxr7JCPe9sOUQocH4BJHAYTmGTuc0v8mz90s
	 wCDNXL8O7OWik/DhIrSIhHXPCuqYMzZTVgUGkFrov4FiIO9whDyJFAtFHob0un8H2z
	 2h/VNx751b85E3BbY8c1O7e1D7vNGb4xTuGpp1SV30peT/2SAgO+5W6yRPT9alwKp1
	 9yUQ8xYmE/qlA==
Date: Wed, 23 Apr 2025 17:34:19 +0100
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	tony@atomide.com, richardcochran@gmail.com, glaroque@baylibre.com,
	schnelle@linux.ibm.com, m-karicheri2@ti.com, s.hauer@pengutronix.de,
	rdunlap@infradead.org, diogo.ivo@siemens.com, basharath@couthit.com,
	jacob.e.keller@intel.com, m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
	srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 05/11] net: ti: prueth: Adds ethtool support
 for ICSSM PRUETH Driver
Message-ID: <20250423163419.GE2843373@horms.kernel.org>
References: <20250414113458.1913823-1-parvathi@couthit.com>
 <20250414130237.1915448-6-parvathi@couthit.com>
 <20250423162816.GD2843373@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423162816.GD2843373@horms.kernel.org>

On Wed, Apr 23, 2025 at 05:28:16PM +0100, Simon Horman wrote:
> On Mon, Apr 14, 2025 at 06:32:31PM +0530, Parvathi Pudi wrote:
> > From: Roger Quadros <rogerq@ti.com>
> > 
> > Changes for enabling ethtool support for the newly added PRU Ethernet
> > interfaces. Extends the support for statistics collection from PRU internal
> > memory and displays it in the user space. Along with statistics,
> > enable/disable of features, configuring link speed etc.are now supported.
> > 
> > The firmware running on PRU maintains statistics in internal data memory.
> > When requested ethtool collects all the statistics for the specified
> > interface and displays it in the user space.
> > 
> > Makefile is updated to include ethtool support into PRUETH driver.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Andrew F. Davis <afd@ti.com>
> > Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> > Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> 
> ...
> 
> > @@ -108,6 +114,119 @@ struct prueth_packet_info {
> >  	bool timestamp;
> >  };
> >  
> > +/**
> > + * struct port_statistics - Statistics structure for capturing statistics
> > + *			    on PRUs
> > + * @tx_bcast: Number of broadcast packets sent
> > + * @tx_mcast:Number of multicast packets sent
> > + * @tx_ucast:Number of unicast packets sent
> > + *
> > + * @tx_octets:Number of undersized frames rcvd
> > + *
> > + * @rx_bcast:Number of broadcast packets rcvd
> > + * @rx_mcast:Number of multicast packets rcvd
> > + * @rx_ucast:Number of unicast packets rcvd
> > + *
> > + * @rx_octets:Number of Rx packets
> > + *
> > + * @tx64byte:Number of 64 byte packets sent
> > + * @tx65_127byte:Number of 65-127 byte packets sent
> > + * @tx128_255byte:Number of 128-255 byte packets sent
> > + * @tx256_511byte:Number of 256-511 byte packets sent
> > + * @tx512_1023byte:Number of 512-1023 byte packets sent
> > + * @tx1024byte:Number of 1024 and larger size packets sent
> > + *
> > + * @rx64byte:Number of 64 byte packets rcvd
> > + * @rx65_127byte:Number of 65-127 byte packets rcvd
> > + * @rx128_255byte:Number of 128-255 byte packets rcvd
> > + * @rx256_511byte:Number of 256-511 byte packets rcvd
> > + * @rx512_1023byte:Number of 512-1023 byte packets rcvd
> > + * @rx1024byte:Number of 1024 and larger size packets rcvd
> > + *
> > + * @late_coll:Number of late collisions(Half Duplex)
> > + * @single_coll:Number of single collisions (Half Duplex)
> > + * @multi_coll:Number of multiple collisions (Half Duplex)
> > + * @excess_coll:Number of excess collisions(Half Duplex)
> > + *
> > + * @rx_misalignment_frames:Number of non multiple of 8 byte frames rcvd
> > + * @stormprev_counter:Number of packets dropped because of Storm Prevention
> 
> nit: It looks like the documentation of @stormprev_counter should
>      be replaced by documentation of:
>      @u32 stormprev_counter_bc;
>      @u32 stormprev_counter_mc;
>      @u32 stormprev_counter_uc;
> 
> > + * @mac_rxerror:Number of MAC receive errors
> > + * @sfd_error:Number of invalid SFD
> > + * @def_tx:Number of transmissions deferred
> > + * @mac_txerror:Number of MAC transmit errors
> > + * @rx_oversized_frames:Number of oversized frames rcvd
> > + * @rx_undersized_frames:Number of undersized frames rcvd
> > + * @rx_crc_frames:Number of CRC error frames rcvd
> > + * @dropped_packets:Number of packets dropped due to link down on opposite port
> > + *
> > + * @tx_hwq_overflow:Hardware Tx Queue (on PRU) over flow count
> > + * @tx_hwq_underflow:Hardware Tx Queue (on PRU) under flow count
> > + *
> > + * @u32 cs_error: Number of carrier sense errors
> 
> nit: @cs_error
> 
>      i.e. remove "u32 "
> 
> Documentation nits flagged by ./scripts/kernel-doc -none
> 
> > + * @sqe_test_error: Number of MAC receive errors
> > + *
> > + * Above fields are aligned so that it's consistent
> > + * with the memory layout in PRU DRAM, this is to facilitate easy
> > + * memcpy. Don't change the order of the fields.
> > + *
> > + * @vlan_dropped: Number of VLAN tagged packets dropped
> > + * @multicast_dropped: Number of multicast packets dropped
> > + */
> > +struct port_statistics {
> > +	u32 tx_bcast;
> > +	u32 tx_mcast;
> > +	u32 tx_ucast;
> > +
> > +	u32 tx_octets;
> > +
> > +	u32 rx_bcast;
> > +	u32 rx_mcast;
> > +	u32 rx_ucast;
> > +
> > +	u32 rx_octets;
> > +
> > +	u32 tx64byte;
> > +	u32 tx65_127byte;
> > +	u32 tx128_255byte;
> > +	u32 tx256_511byte;
> > +	u32 tx512_1023byte;
> > +	u32 tx1024byte;
> > +
> > +	u32 rx64byte;
> > +	u32 rx65_127byte;
> > +	u32 rx128_255byte;
> > +	u32 rx256_511byte;
> > +	u32 rx512_1023byte;
> > +	u32 rx1024byte;
> > +
> > +	u32 late_coll;
> > +	u32 single_coll;
> > +	u32 multi_coll;
> > +	u32 excess_coll;
> > +
> > +	u32 rx_misalignment_frames;
> > +	u32 stormprev_counter_bc;
> > +	u32 stormprev_counter_mc;
> > +	u32 stormprev_counter_uc;
> > +	u32 mac_rxerror;
> > +	u32 sfd_error;
> > +	u32 def_tx;
> > +	u32 mac_txerror;
> > +	u32 rx_oversized_frames;
> > +	u32 rx_undersized_frames;
> > +	u32 rx_crc_frames;
> > +	u32 dropped_packets;
> > +
> > +	u32 tx_hwq_overflow;
> > +	u32 tx_hwq_underflow;
> > +
> > +	u32 cs_error;
> > +	u32 sqe_test_error;
> > +
> > +	u32 vlan_dropped;
> > +	u32 multicast_dropped;
> > +} __packed;
> 
> ...

Oops, I seem to have replied to an old version of this patch-set.
My comments above do still seem relevant to v6.
But as v6 exits the comment below is nonsense. Sorry about that.

> 
> The above notwithstanding, it seems based on comment's elsewhere in this
> thread that there will be another revision of this patchset. Let patchwork
> know about that.
> 
> pw-bot: changes-requested
> 

