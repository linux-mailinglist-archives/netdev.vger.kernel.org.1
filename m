Return-Path: <netdev+bounces-185814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B788A9BCB5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6702B7AAADA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7292C42AA5;
	Fri, 25 Apr 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP4Cseuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457067483;
	Fri, 25 Apr 2025 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547465; cv=none; b=bczrbrSLgJ5zBD1chmPEmIoR8X+q6u2fc8FWG1EEmLKlCBv35vssJqhjU86D96n4Z/lX6yW0GIsgi+5D3FbVbLWnujof9bpM/yfO7/UZTRJltNiWMfTrzVE+x5Sqrusg0MLLR6hfXwHG/1oD1j/sIZcjVtgyx2GTwA9erQtvUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547465; c=relaxed/simple;
	bh=rnde/5LKcrXee61FnkPpAl7VxLLLULNpXCvsaDr67Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbIQZGUiJ0gN4QpQtHHAD3TK9/kDIb8bTqr4Kxkd2aGsF26My/P/443fQ/gi9D6TD03BaQmNPSWHbZjldmrvGLuQyT2WXly3J4cI75WhDU3wbtpDH7YlFMNUa9qH+5m+Jhwu7wRTQN/8sHkH0Khzu2rRWoH989WgnwmjvwC/jgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP4Cseuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A9CC4CEE8;
	Fri, 25 Apr 2025 02:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745547463;
	bh=rnde/5LKcrXee61FnkPpAl7VxLLLULNpXCvsaDr67Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MP4CseuyCo8bNn2ZW4hcPWDWOtViWj1ZG+QwEYuIVYqgqkLG/LKego/Vl3SVMQYCN
	 9tvkWHtXY2lQ0vrTzzCk0PmCac9260ag0nlNHIz1d5JAK4FLmrZK1UOQqwH9+/yUJ4
	 6dfFcPjv6POUuo9r9q93DOuA2JeAfLBiqIfIZStEj27UuQHwyYQq9nN4Qk25UqHGMc
	 kD8eDJP00j6tc9gEpLOIbg8eRtY3/MhoJEKYaobcjMrZDFLHRJzxtYwu/jALChEXh9
	 70RRTQPCvvH3NHc54/AnbLJhbHCcAq6vASxhqtoSm/JeXjnrOgmenKgFnmbH7LRGpu
	 kKhh/tMhTrgYw==
Date: Thu, 24 Apr 2025 19:17:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, tony@atomide.com, richardcochran@gmail.com,
 glaroque@baylibre.com, schnelle@linux.ibm.com, m-karicheri2@ti.com,
 s.hauer@pengutronix.de, rdunlap@infradead.org, diogo.ivo@siemens.com,
 basharath@couthit.com, horms@kernel.org, jacob.e.keller@intel.com,
 m-malladi@ti.com, javier.carrasco.cruz@gmail.com, afd@ti.com,
 s-anna@ti.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratheesh@ti.com, prajith@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v6 05/11] net: ti: prueth: Adds ethtool support
 for ICSSM PRUETH Driver
Message-ID: <20250424191741.55323f28@kernel.org>
In-Reply-To: <20250423072356.146726-6-parvathi@couthit.com>
References: <20250423060707.145166-1-parvathi@couthit.com>
	<20250423072356.146726-6-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 12:53:50 +0530 Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Changes for enabling ethtool support for the newly added PRU Ethernet
> interfaces. Extends the support for statistics collection from PRU internal
> memory and displays it in the user space. Along with statistics,
> enable/disable of features, configuring link speed etc.are now supported.
> 
> The firmware running on PRU maintains statistics in internal data memory.
> When requested ethtool collects all the statistics for the specified
> interface and displays it in the user space.
> 
> Makefile is updated to include ethtool support into PRUETH driver.

drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or struct member 'stormprev_counter_bc' not described in 'port_statistics'
drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or struct member 'stormprev_counter_mc' not described in 'port_statistics'
drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or struct member 'stormprev_counter_uc' not described in 'port_statistics'
drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or struct member 'cs_error' not described in 'port_statistics'
drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Excess struct member 'stormprev_counter' description in 'port_statistics'

> +static const struct {
> +	char string[ETH_GSTRING_LEN];
> +	u32 offset;
> +} prueth_ethtool_stats[] = {
> +	{"txBcast", PRUETH_STAT_OFFSET(tx_bcast)},
> +	{"txMcast", PRUETH_STAT_OFFSET(tx_mcast)},
> +	{"txUcast", PRUETH_STAT_OFFSET(tx_ucast)},
> +	{"txOctets", PRUETH_STAT_OFFSET(tx_octets)},
> +	{"rxBcast", PRUETH_STAT_OFFSET(rx_bcast)},
> +	{"rxMcast", PRUETH_STAT_OFFSET(rx_mcast)},
> +	{"rxUcast", PRUETH_STAT_OFFSET(rx_ucast)},
> +	{"rxOctets", PRUETH_STAT_OFFSET(rx_octets)},
> +
> +	{"tx64byte", PRUETH_STAT_OFFSET(tx64byte)},
> +	{"tx65_127byte", PRUETH_STAT_OFFSET(tx65_127byte)},
> +	{"tx128_255byte", PRUETH_STAT_OFFSET(tx128_255byte)},
> +	{"tx256_511byte", PRUETH_STAT_OFFSET(tx256_511byte)},
> +	{"tx512_1023byte", PRUETH_STAT_OFFSET(tx512_1023byte)},
> +	{"tx1024byte", PRUETH_STAT_OFFSET(tx1024byte)},
> +	{"rx64byte", PRUETH_STAT_OFFSET(rx64byte)},
> +	{"rx65_127byte", PRUETH_STAT_OFFSET(rx65_127byte)},
> +	{"rx128_255byte", PRUETH_STAT_OFFSET(rx128_255byte)},
> +	{"rx256_511byte", PRUETH_STAT_OFFSET(rx256_511byte)},
> +	{"rx512_1023byte", PRUETH_STAT_OFFSET(rx512_1023byte)},
> +	{"rx1024byte", PRUETH_STAT_OFFSET(rx1024byte)},
> +
> +	{"lateColl", PRUETH_STAT_OFFSET(late_coll)},
> +	{"singleColl", PRUETH_STAT_OFFSET(single_coll)},
> +	{"multiColl", PRUETH_STAT_OFFSET(multi_coll)},
> +	{"excessColl", PRUETH_STAT_OFFSET(excess_coll)},

Do not dump into ethtool -S what's reported via standard stats.

