Return-Path: <netdev+bounces-190286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF9FAB6026
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 02:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E03D19E2B78
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCA1EA73;
	Wed, 14 May 2025 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0lmm3iN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443A819;
	Wed, 14 May 2025 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182399; cv=none; b=bN6HlOnr051zY3RzDyrmRgCr4fN+JIX4zEWpUsJnV6G3MJWmOo70ApoJ4Z9c/zh8/FDjipxpndD0YeHoj5lj9n+7wbavsme4/3UEr2Bm9WweK00EqcinB62KzzJGQj1+3Acwm+/Yav2Po2Yc7aFT2jYs1tCmNph0/XB+YIFpCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182399; c=relaxed/simple;
	bh=EUluESMZDGaIO+DzKufN5yyjenqOI9VWfQxvCpUImNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3DxVa+IZAdSki8vE9RUI4MrC+GdrPlaBgmdmOpDSf560VTGOfAhXZCt1O8aMAWUVrQDifBT6ALehA5JWseHGIBlDQ0+aQF1a4XzCa4K4dwKSRSO7jD7WScMMpSETzCs6Rwwusa0/w3WuUoRF6qo7I9LymPMmKCa4wHYZ48XS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0lmm3iN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355CFC4CEE4;
	Wed, 14 May 2025 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747182398;
	bh=EUluESMZDGaIO+DzKufN5yyjenqOI9VWfQxvCpUImNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0lmm3iN4inA8geQlL9uLNH9ydXunty8+r6V04c8henGjojGqR5BbLBQH/JSUEVXH
	 PrgETC5srsGw9EWkPVnn76z2AqENuxc2tOfMaYpVzHwM9M8lHgl63sx3fVzhDsfSRx
	 KxPYNai0lG3ZC6u0kLIQlTnBYSeuHPRbRbYYQ2RYhOMfD8TEFxEbBrhhuWHp/1IwRl
	 PJCVUf+aWlIwLmRUXW4MX3qlr5JV1u0OnaaLs6qpv8PIkjuz2wMThus1/rJVVQxqBm
	 J5gkXZulYFBuDhYPxIjeZm2OU7+7W6n6zBNiiO/2KhQxLJGcgedE+/Gicy0ZiiW2oD
	 /u7wG7JGNsxvQ==
Date: Tue, 13 May 2025 17:26:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Pazdan <mpazdan@arista.com>
Cc: andrew@lunn.ch, aleksander.lobakin@intel.com, almasrymina@google.com,
 andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, daniel.zahka@gmail.com,
 davem@davemloft.net, ecree.xilinx@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, intel-wired-lan@lists.osuosl.org,
 jianbol@nvidia.com, kory.maincent@bootlin.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, willemb@google.com
Subject: Re: [PATCH net-next v2 1/2] ethtool: qsfp transceiver reset,
 interrupt and presence pin control
Message-ID: <20250513172637.2e2b2faf@kernel.org>
In-Reply-To: <20250513224017.202236-1-mpazdan@arista.com>
References: <6f127b5b-77c6-4bd4-8124-8eea6a12ca61@lunn.ch>
	<20250513224017.202236-1-mpazdan@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 22:40:00 +0000 Marek Pazdan wrote:
> Common Management Interface Specification defines
> Management Signaling Layer (MSL) control and status signals. This change
> provides API for following signals status reading:
> - signal allowing the host to request module reset (Reset)
> - signal allowing the host to detect module presence (Presence)
> - signal allowing the host to detect module interrupt (Int)
> Additionally API allows for Reset signal assertion with
> following constraints:
> - reset cannot be asserted if firmware update is in progress
> - if reset is asserted, firmware update cannot be started
> - if reset is asserted, power mode cannot be get/set
> In all above constraint cases -EBUSY error is returned.
> 
> After reset, module will set all registers to default
> values. Default value for Page0 byte 93 register is 0x00 what implies that
> module power mode after reset depends on LPMode HW pin state.
> If software power mode control is required, bit 0 of Page0 byte93 needs
> to be enabled.
> Module reset assertion implies failure of every module's related
> SMBus transactions. Device driver developers should take this into
> consideration if driver provides API for querying module's related data.
> One example can be HWMON providing module temperature report.
> In such case driver should monitor module status and in time of reset
> assertion it should return HWMON report which informs that temperature
> data is not available due to module's reset state.
> The same applies to power mode set/get. Ethtool API has already
> checking for module reset state but similar checking needs to be
> implemented in the driver if it requests power mode for other
> functionality.
> Additionally module reset is link hitful operation. Link is brought down
> when reset is asserted. If device driver doesn't provide functionality
> for monitoring transceiver state, it needs to be implemented in parallel
> to get/set_module_mgmt_signal API. When module reset gets deasserted,
> transceiver process reinitialization. The end of reinitialization
> process is signalled via Page 00h Byte 6 bit 0 "Initialization complete
> flags". If there is no implementation for monitoring this bit in place,
> it needs to be added to bring up the link after transceiver
> initialization is complete.
> 
> Signed-off-by: Marek Pazdan <mpazdan@arista.com>

A few drive by comments, I leave the real review to Andrew.

Instead of posting in-reply-to please add lore links to previous
versions, eg.
v2:
https://lore.kernel.org/all/20250513224017.202236-1-mpazdan@arista.com/ under the --- separator.

I almost missed this posting.

When you post v3 please make sure to CC Ido and Danielle who
implemented the FW flashing for modules.

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index c650cd3dcb80..38eebbe18f55 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1528,6 +1528,24 @@ attribute-sets:
>          name: hwtstamp-flags
>          type: nest
>          nested-attributes: bitset
> +  -
> +    name: module-mgmt
> +    attr-cnt-name: __ethtool-a-module-mgmt-cnt
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0

no need, just skip the unspec attr and YNL will number the first one
from 1 keeping 0 as rejected type.

> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: type
> +        type: u8

u32 will give us more flexibility later. And attr sizes in netlink are
aligned to 4B so a u8 consumes 4 bytes anyway.

> +      -
> +        name: value
> +        type: u8

Do you think we'll never need to set / clear / change multiple bits at
once? We could wrap the type / value into a nest and support repeating
that nest (multi-attr: true)

> +/**
> + * enum ethtool_module_mgmt_signal_type - plug-in module discrete
> + *	status hardware signals for management as per CMIS spec.
> + * @ETHTOOL_MODULE_MGMT_RESET: Signal allowing the host to request
> + *	a module reset.
> + * @ETHTOOL_MODULE_MGMT_INT: Signal allowing the module to assert
> + *	an interrupt request to the host.
> + * @ETHTOOL_MODULE_MGMT_PRESENT: Signal allowing the module to signal
> + *	its presence status to the host.

Not sure what the use case would be for setting INT and PRESENT.
So the combined API (driver facing) to treat RESET and read-only
bits as equivalent may not be the best fit. Just a feeling tho.

> + */
> +enum ethtool_module_mgmt_signal_type {
> +	ETHTOOL_MODULE_MGMT_RESET = 1,
> +	ETHTOOL_MODULE_MGMT_INT,
> +	ETHTOOL_MODULE_MGMT_PRESENT,

Please define the enums in the YNL spec, see
https://lore.kernel.org/all/20250508193645.78e1e4d9@kernel.org/


