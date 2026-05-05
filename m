Return-Path: <netdev+bounces-284259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBvEGxCp+WnF+gIAu9opvQ
	(envelope-from <netdev+bounces-284259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:23:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5674C89C6
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BED35300B983
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07823D565E;
	Tue,  5 May 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OimqTLy/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986453A6F05;
	Tue,  5 May 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969419; cv=none; b=SGylEyN8XKBd7BxGlEbuA7ZOP+hlowsypIa6SmeQk70phmnsS36j857tnPbzmVHLcZJB4HjaNYxUOyiHTjucuH0Q6v0cVOWyss5aU+mcsxgln2r7RN+sgDKmK4He81AemAhzbW/SVFcgAIC6tWrJroI6E0jGBwCNHdLe96dSueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969419; c=relaxed/simple;
	bh=1nwZwcd0lw+L3LC6fBbFFthVGiDhYjKf43nqBs4UiIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkmhwBXvC6HF4XVdSAKWJxKfmXvLLUlYta10RITOqbGYLGlIKPciM0AL2MJrrzD1GQQulJDJvPXIApmNtYaksDT6YCPY2ezVMyiklaxZTRDGl9vx5Vfxglvq0zPLMZAvquuQdXLyqm+haoUqjQD/xoiKIXm9tRhE5IN72AWZLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OimqTLy/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777969419; x=1809505419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1nwZwcd0lw+L3LC6fBbFFthVGiDhYjKf43nqBs4UiIQ=;
  b=OimqTLy/YahCE6ujYa+CDkEp70PE4CNgyZW4xkHOP0f1MtMVgu419Nt8
   IReFdoKJX6Jf+Drh82+LyfrWzw50noHjHMDppH0qMDDkeO0X19HMVAj2Y
   LjLsqzniKafo1r6+IoJ79EaZGdL3Q147CthpZKOglr96vQyCxNCWKTGCS
   3VHC1R1H8wtddq7OP+JCBYMpbX+kMgGC856t5K5kqsk2GDaXMsuUojCUd
   +T+9L/38IRypg3OTNJ1by/8FF5xKXQ4CvUOkzNKQ0afRs2zwBTFz9OQ9f
   mDSdolfGt2THKF5HgGthFc5dkPmHJoy7K6Bnys8p9kAnI/ef3uEM9Q8vU
   Q==;
X-CSE-ConnectionGUID: 2wiXfKnrQYuXfMP5hS9TVw==
X-CSE-MsgGUID: U4kDY1NUSyulVAwWQKNCLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82686151"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="82686151"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:23:38 -0700
X-CSE-ConnectionGUID: 5ydEHKiiTBy6ySr5CnKKdg==
X-CSE-MsgGUID: Jx0TBBiIQjSA/SI2YNKlvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240728858"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:23:32 -0700
Date: Tue, 5 May 2026 11:23:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rodrigo.vivi@intel.com, wojciech.drewek@intel.com,
	michael.brooks@intel.com, heikki.krogerus@intel.com,
	michael.j.ruhl@intel.com, thomas.hellstrom@linux.intel.com,
	michal.winiarski@intel.com, anshuman.gupta@intel.com,
	jacob.e.keller@intel.com, maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, mika.westerberg@linux.intel.com,
	singaravelan.nallasellan@intel.com, kelvin.gardiner@intel.com,
	jk@codeconstruct.com.au, matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, james.ausmus@intel.com
Subject: Re: [RFC PATCH 1/1] xe/xe_mctp_mailbox: Add support for MCTP
 transport over mailbox
Message-ID: <afmpAXjwU16J0RG5@ashevche-desk.local>
References: <20260504193420.1232842-3-badal.nilawar@intel.com>
 <20260504193420.1232842-4-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504193420.1232842-4-badal.nilawar@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: CE5674C89C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284259-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]

On Tue, May 05, 2026 at 01:04:22AM +0530, Badal Nilawar wrote:
> Add support for MCTP transport over the Intel vendor-specific mailbox
> protocol to enable in-band firmware updates for GPU/AMC via PLDM

...

> +#include "xe_device_types.h"

Why is the location of this inclusion is here?

> +#include <linux/netdevice.h>
> +#include <linux/jiffies.h>
> +#include <linux/workqueue.h>
> +
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +#include <net/pkt_sched.h>
> +
> +#include <uapi/linux/if_arp.h>
> +

The above doesn't sound like more generic than linux/* ones. Move it here.

> +#include "xe_mctp_mailbox.h"

...

> +static void mctp_mailbox_rx_handler(struct work_struct *work)
> +{
> +	struct xe_mctp_mailbox *mctp_mailbox =
> +		container_of(work, struct xe_mctp_mailbox, work.work);

> +	struct net_device *netdev = mctp_mailbox->netdev;
> +
> +	if (!netdev)
> +		return;

This is bad style from maintenance perspective. Use

	struct net_device *netdev;

	netdev = mctp_mailbox->netdev;
	if (!netdev)
		return;

> +	dev_hold(netdev);
> +
> +	/*
> +	 * if (mctp_mailbox_rx_ready()) {
> +	 * Get data over MAILBOX
> +	 * Allocate skb and copy rx data to skb
> +	 * Queue skb to upper layer
> +	 * netif_rx(skb);
> +	}
> +	 */

What is this?! If you want to put a nice comment, format it accordingly.

> +	dev_put(netdev);
> +
> +	if (mctp_mailbox->running)
> +		queue_delayed_work(mctp_mailbox->wq, &mctp_mailbox->work,
> +				   msecs_to_jiffies(XE_MCTP_MAILBOX_RX_POLL_MS));
> +}

...

> +static void mctp_mailbox_netdev_setup(struct net_device *dev)
> +{
> +	/* Populate netdev structure */
> +	dev->type = ARPHRD_MCTP;
> +	/*
> +	 *	dev->mtu = MCTP_MAILBOX_MTU_MIN;
> +	 *	dev->min_mtu = MCTP_MAILBOX_MTU_MIN;
> +	 *	dev->max_mtu = MCTP_MAILBOX_MTU_MAX;
> +	 *
> +	 *	dev->hard_header_len = sizeof(struct mctp_mailbox_hdr);
> +	 *	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
> +	 */

Even for RFC these should not exist in this form. Always add the respective
FIXME/TODO/et cetera to explain the commented out code.

> +	dev->flags = IFF_NOARP;
> +	dev->netdev_ops = &mctp_mailbox_netdev_ops;
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}


-- 
With Best Regards,
Andy Shevchenko



