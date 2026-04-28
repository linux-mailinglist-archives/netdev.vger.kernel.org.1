Return-Path: <netdev+bounces-281919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE1tMg3K8GkKYwEAu9opvQ
	(envelope-from <netdev+bounces-281919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:54:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B22248760C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0507930839D2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4044B679;
	Tue, 28 Apr 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYq8WcA5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37899449EAB;
	Tue, 28 Apr 2026 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386015; cv=none; b=nQ+EEVKLhMjD5jPH8/UONOSIKLh+2XisqFJpQa16wQIaxIL2wwivkJ9PV9XFyeoKv2IoQEJ/iu9oGaEjmsViHJ0ZKdH/bdAUg2F/Jo5+8JfXUEbVS/n1X1hbkNCY8jVkIU3ShAm4uf+0LAi/nFqUOp/bxvbixFLG8af/9zJtYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386015; c=relaxed/simple;
	bh=kIuxbgIaJCMhQuNLYkCckOFDeUskSr2OVQDRPgW9pF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/OeNfxyxOj3eynDJrNUvEfFGmsqaxgaADBI2buwNXTvxSgdb6DrlVrugsClkLXZiBNbgXCkmaeOkIQE7SNYhdXOaT6pavM5NExcZMZkFyil9VwDqg9SyfXeKsIrzc1ic0sHlhGro4ltX6vmJ1ZuIqmsgvucybLRAUG7Q49UO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYq8WcA5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777386005; x=1808922005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kIuxbgIaJCMhQuNLYkCckOFDeUskSr2OVQDRPgW9pF4=;
  b=eYq8WcA5G8HO9oKh1BmeKoYJzNZuOB/huR0pDFhCv8MiMtOixkujrIdB
   TwBwPS9rn9QjJT/TSOVNWXo0jBdGEIeEPEa8fGyRyC5ilwFrLbxM9F2P5
   mWG5urdieC5Z7WeSUrXMZ0Or5+VOO+jnmwM5XpFF7ZabgjZ8nqQxWrgZC
   Qefd/SEH8ElxpgH4Ryvpulnd3VLDw1ZYHouycjkjbCvx5EjKeKhlqkgeA
   dQHYoN+OOTuvmsl/PeZcXS2QNws/I1lH57+EbABik0YNeYLz7a2M/5LWi
   C2mrD0D5iZIXhU73K1dX4yCuJ3IeYrYc5zOXuLWtRa238brkW2wELapxv
   Q==;
X-CSE-ConnectionGUID: i6j1PG9BSi2EsHhoGUQ13A==
X-CSE-MsgGUID: MDsVBLIRQr+3x4PrQXjeXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78279286"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78279286"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:20:00 -0700
X-CSE-ConnectionGUID: otW1OplASGq46IDj0untFQ==
X-CSE-MsgGUID: oNunmfWLRSa2/fFupSSg8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="238940813"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 28 Apr 2026 07:19:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 02F5695; Tue, 28 Apr 2026 16:19:55 +0200 (CEST)
Date: Tue, 28 Apr 2026 16:19:54 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Berman <benjamin.s.berman@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: thunderbolt: enlarge RX/TX ring and set NAPI
 weight for sustained load
Message-ID: <20260428141954.GT557136@black.igk.intel.com>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
 <20260428015521.3454006-3-benjamin.s.berman@gmail.com>
 <20260428074253.GP557136@black.igk.intel.com>
 <e6a249d5-8b11-43cf-89ee-14d436c70cf8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6a249d5-8b11-43cf-89ee-14d436c70cf8@lunn.ch>
X-Rspamd-Queue-Id: 4B22248760C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281919-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]

On Tue, Apr 28, 2026 at 02:54:58PM +0200, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 09:42:53AM +0200, Mika Westerberg wrote:
> > On Mon, Apr 27, 2026 at 06:55:21PM -0700, Benjamin Berman wrote:
> > > The default TBNET_RING_SIZE of 256 and the NAPI_POLL_WEIGHT of 64
> > > implicit in netif_napi_add() are too small for host-to-host Thunderbolt
> > > networking under sustained bulk traffic.  Running NCCL all-reduce over
> > > tb-lo on a three-node chain (two TB3 endpoints plus a TB4 Maple Ridge
> > > transit) produces rx_missed_errors at ~1 % of rx_packets on the transit
> > > and ~0.6 % on the endpoints, with rx_packets stalling against a peer's
> > > continuing tx_packets.
> > > 
> > > Raise TBNET_RING_SIZE to 2048 (8x) and use netif_napi_add_weight() with
> > > a per-NAPI weight of 256 so tbnet_poll() drains more frames per softirq
> > > invocation.  With matching sysctls (net.core.netdev_budget=1024,
> > > net.core.netdev_budget_usecs=8000) rx_missed_errors stays below 0.005 %
> > > over a 192 GB all-reduce workload on the same hardware.
> > > 
> > > Generated-by: Claude Opus 4.7 <claude-opus-4-7@anthropic.com>
> > > Tested-by: Benjamin Berman <benjamin.s.berman@gmail.com>
> > > Signed-off-by: Benjamin Berman <benjamin.s.berman@gmail.com>
> > 
> > For ring size I don't have any objections. The current ring size 256 is
> > arbitrary and at the time seemed reasonable.
> > 
> > For the poll weigth there is the comment in netdevice.h:
> > 
> > /* Default NAPI poll() weight
> >  * Device drivers are strongly advised to not use bigger value
> >  */
> > #define NAPI_POLL_WEIGHT 64
> > 
> > But if you see improvement using 256 here I'm fine with that unless the
> > network folks advice otherwise.
> 
> I just did a quick sample of other drivers which change the NAPI
> weight. Of the 10 i looked at, 9 reduced the weight. Only one
> increased it.

Yeah, I noticed it too. That's why asking for consultancy :)

> I would like the core netdev people to comment on this, before it is
> accepted.
> 
> Questions which come to mind:
> 
> Why is the polling not happening frequently enough? 
> 
> Is it frequently swapping between polling and interrupts?
> 
> Is there interrupt coalesce going on, and the coalesce time set too
> high, so that by the time the interrupt fires the ring is full? Can
> you play with ethtool -C?

Thanks!

I'll leave these to Benjamin and Claude AI to answer.

One thing that could affect is the interrupt throttling that the hardware
is doing. We have quite big value there by default. Lowering that may have
affect as well. I just posted a patch series where one of the patches makes
this configurable in the tbnet driver so you could apply that and play with
the throttling value:

https://lore.kernel.org/linux-usb/20260428072209.3084930-6-mika.westerberg@linux.intel.com/

