Return-Path: <netdev+bounces-151733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24BF9F0BF8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0088167E15
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952B51DF242;
	Fri, 13 Dec 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toIvpomR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B16364D6
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092032; cv=none; b=XYMEWcY9CpEsKZMdOvF7pNG6KUjuVqiVQ/dfHnlMopK4BsmSs0E3HVEgykfh0WIpX8D9tVavVDLvqFhv4SI0heNxp3VpcUJo8k+AbUwMKgIy57qiPa69P2ukhvFi4asCm7M8/yrIUOeB4kuif7/a47CdMlj73zMUkRtU2PuFZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092032; c=relaxed/simple;
	bh=7t+kkzJExkS19We2Fk9Jcotmw6QznUhuyVG2TQQ0ojM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re2SvaPTbP4P880sN1e2t72nFDAya7KmfwgOcyb0QEdLmp/iCurJQsKQpsyp9FCQR/QnPQza2WvAjjyJx3n35D9fsD9k4gXm6lCtYaLcOHUDw7qK3VmOluaQ9xN5EHPhEspc72iXvOmY3jbHcoL8ZdYH3072U9KBI7GcpTAgIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toIvpomR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E217CC4CED0;
	Fri, 13 Dec 2024 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734092032;
	bh=7t+kkzJExkS19We2Fk9Jcotmw6QznUhuyVG2TQQ0ojM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toIvpomRmqcfYndqHTqOzdHRKHR2iwvdjIicrnImKgGV788dM5OipDqSdsaD/JurX
	 rBorhB+VEISkg2l9BF1eWlukNX3RcLsSzPR//iig+WLA3gf4dfw/9/Irx6tCZIkA44
	 uaZaIz2ALyGuoyZZ1wr3u2EiN4ZdZtF7m2d0bYP+wXLD6He7oW6UalOCWTF2Ple5Hu
	 nrTVmwabfw1qpbm7U2mbsQZeWFdZdVjRpmFzaBA1oAZZjZEXsOuNxUzQs7bpmka3xC
	 5Z8hSUdec+RUQQvIhc5jsQfAjaUOpmDnnnEXcyMotJZGPez1uNrDbxehXxg89jDrP1
	 KRmQn8sgCHQTA==
Date: Fri, 13 Dec 2024 12:13:47 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net] net: mscc: ocelot: fix incorrect IFH SRC_PORT field
 in ocelot_ifh_set_basic()
Message-ID: <20241213121347.GT2110@kernel.org>
References: <20241212165546.879567-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212165546.879567-1-vladimir.oltean@nxp.com>

On Thu, Dec 12, 2024 at 06:55:45PM +0200, Vladimir Oltean wrote:
> Packets injected by the CPU should have a SRC_PORT field equal to the
> CPU port module index in the Analyzer block (ocelot->num_phys_ports).
> 
> The blamed commit copied the ocelot_ifh_set_basic() call incorrectly
> from ocelot_xmit_common() in net/dsa/tag_ocelot.c. Instead of calling
> with "x", it calls with BIT_ULL(x), but the field is not a port mask,
> but rather a single port index.
> 
> [ side note: this is the technical debt of code duplication :( ]
> 
> The error used to be silent and doesn't appear to have other
> user-visible manifestations, but with new changes in the packing
> library, it now fails loudly as follows:
> 
> ------------[ cut here ]------------
> Cannot store 0x40 inside bits 46-43 - will truncate
> sja1105 spi2.0: xmit timed out
> WARNING: CPU: 1 PID: 102 at lib/packing.c:98 __pack+0x90/0x198
> sja1105 spi2.0: timed out polling for tstamp
> CPU: 1 UID: 0 PID: 102 Comm: felix_xmit
> Tainted: G        W        N 6.13.0-rc1-00372-gf706b85d972d-dirty #2605
> Call trace:
>  __pack+0x90/0x198 (P)
>  __pack+0x90/0x198 (L)
>  packing+0x78/0x98
>  ocelot_ifh_set_basic+0x260/0x368
>  ocelot_port_inject_frame+0xa8/0x250
>  felix_port_deferred_xmit+0x14c/0x258
>  kthread_worker_fn+0x134/0x350
>  kthread+0x114/0x138
> 
> The code path pertains to the ocelot switchdev driver and to the felix
> secondary DSA tag protocol, ocelot-8021q. Here seen with ocelot-8021q.
> 
> The messenger (packing) is not really to blame, so fix the original
> commit instead.
> 
> Fixes: e1b9e80236c5 ("net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


