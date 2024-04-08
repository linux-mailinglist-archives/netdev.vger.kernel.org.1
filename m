Return-Path: <netdev+bounces-85828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4A89C7AC
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E0FB28B98
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DD13F003;
	Mon,  8 Apr 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSn37N0r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037013E411
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587961; cv=none; b=gmcFjmfVzQ0uU/EJIhViA/sA0DAomHp2mxlg/voPoARpRwceIRzJbpgPgSQUdCjiGTqKlkZjy6IaCLCUBZlUWBQCdEHOwl9X5D/dWbOnT2bbzjlsIdleVeHWRB8hTOSTkaQWUdk2eIEZKOnsNptwPn6bPJQhb5h5ag/Q19ZK/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587961; c=relaxed/simple;
	bh=PyGbBoxwTcpZIFhrwiY6j8YepityY5IbE3Wl1MQOwm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9UAWFgtGXHmL6L5UGMjlhngS5XyxreUauczWGMJlsn6ndZc+RTvFhOvazU3rFMUtuy7H2A+6fp1uyyAfiPWZsBOtAzOcaaekFl1xpXP9BHtpl7FzYX+vOCFznj9Ah2Ca3SmpHPRJClDOnPKFPj+cRVgY9OZ8FCJteDplJEi1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSn37N0r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712587960; x=1744123960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyGbBoxwTcpZIFhrwiY6j8YepityY5IbE3Wl1MQOwm8=;
  b=MSn37N0rplSemdh/6fhF3XNvqU9BP86kwF5sOJfiDHW075zv52cS3t1x
   bf/aGEckaCIsRJK61L2OPrIZy/C90ehhOG3J5ak/5c2b3vB/SGk9XU3Tl
   vZDPhqXj7Vp6dieFNURfMslLoQhtuQ5/GrSiH4F+k3yFzNos+L2CZGlQj
   h/e/yposDMljFiUlPq0/jWbyGw9QyZKwsMxiFqtkNo/2XqavHbm/M09J/
   UinriWZ7TTc+CXR7sYCwnDW9bwRK5NjUDELqjUnv5ebGxP6P0VUbba7lV
   n/ve5eAmWpifU2Fg92k7TuEFw+l/GpnzI6xdypEoJW37S7tHVpnBW7qWo
   A==;
X-CSE-ConnectionGUID: A5NCd0CYTVablvyXcCrXvg==
X-CSE-MsgGUID: bqfbWbD6Qp+J4MRVUaX4Kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7726040"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7726040"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915367702"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915367702"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:52:29 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtqME-00000002YSX-3a5b;
	Mon, 08 Apr 2024 17:52:26 +0300
Date: Mon, 8 Apr 2024 17:52:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 2/2] net: ks8851: Handle softirqs at the end of
 IRQ thread to fix hang
Message-ID: <ZhQEqizpGMrxe_wT@smile.fi.intel.com>
References: <20240405203204.82062-1-marex@denx.de>
 <20240405203204.82062-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405203204.82062-2-marex@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 10:30:40PM +0200, Marek Vasut wrote:
> The ks8851_irq() thread may call ks8851_rx_pkts() in case there are
> any packets in the MAC FIFO, which calls netif_rx(). This netif_rx()
> implementation is guarded by local_bh_disable() and local_bh_enable().
> The local_bh_enable() may call do_softirq() to run softirqs in case
> any are pending. One of the softirqs is net_rx_action, which ultimately
> reaches the driver .start_xmit callback. If that happens, the system
> hangs. The entire call chain is below:
> 
> ks8851_start_xmit_par from netdev_start_xmit
> netdev_start_xmit from dev_hard_start_xmit
> dev_hard_start_xmit from sch_direct_xmit
> sch_direct_xmit from __dev_queue_xmit
> __dev_queue_xmit from __neigh_update
> __neigh_update from neigh_update
> neigh_update from arp_process.constprop.0
> arp_process.constprop.0 from __netif_receive_skb_one_core
> __netif_receive_skb_one_core from process_backlog
> process_backlog from __napi_poll.constprop.0
> __napi_poll.constprop.0 from net_rx_action
> net_rx_action from __do_softirq
> __do_softirq from call_with_stack
> call_with_stack from do_softirq
> do_softirq from __local_bh_enable_ip
> __local_bh_enable_ip from netif_rx
> netif_rx from ks8851_irq
> ks8851_irq from irq_thread_fn

> irq_thread_fn from irq_thread
> irq_thread from kthread
> kthread from ret_from_fork

These lines are unneeded (in case you need a new version, you can drop them).

> The hang happens because ks8851_irq() first locks a spinlock in
> ks8851_par.c ks8851_lock_par() spin_lock_irqsave(&ksp->lock, ...)
> and with that spinlock locked, calls netif_rx(). Once the execution
> reaches ks8851_start_xmit_par(), it calls ks8851_lock_par() again
> which attempts to claim the already locked spinlock again, and the
> hang happens.
> 
> Move the do_softirq() call outside of the spinlock protected section
> of ks8851_irq() by disabling BHs around the entire spinlock protected
> section of ks8851_irq() handler. Place local_bh_enable() outside of
> the spinlock protected section, so that it can trigger do_softirq()
> without the ks8851_par.c ks8851_lock_par() spinlock being held, and
> safely call ks8851_start_xmit_par() without attempting to lock the
> already locked spinlock.
> 
> Since ks8851_irq() is protected by local_bh_disable()/local_bh_enable()
> now, replace netif_rx() with __netif_rx() which is not duplicating the
> local_bh_disable()/local_bh_enable() calls.

-- 
With Best Regards,
Andy Shevchenko



