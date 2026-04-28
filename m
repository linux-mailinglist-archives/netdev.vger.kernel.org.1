Return-Path: <netdev+bounces-281696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCECJ9lp8GkITAEAu9opvQ
	(envelope-from <netdev+bounces-281696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB6247F8DD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B68B309171E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5993B634C;
	Tue, 28 Apr 2026 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2NCZxMM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C643A0E8E;
	Tue, 28 Apr 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362179; cv=none; b=H658+OYX3GDl6kugi0pYTFwuhWEUgf1l1ppfUS6Jmc/pzbdXy+5d1xKJfXjHPtiYtbz/AFVbDsrgdzpZaRhJkbwyBxNmkaUDxCCCKBAOX7FetSSmSkvC44y7OCiAYad5pv9zOCUkDHr2lUqQxLySKfk628mG6Am7k9Zh05LGzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362179; c=relaxed/simple;
	bh=WkfwgEy4xpwHn+VhVmIheSHazkvkv+HEQOBMy9vIyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa19GlrsdI0F5D9XeBQn7TDnWgV7PGm+zlwJ2DOpXGD0fxVRA2JJVXVHPOkxMZJ+34hM2ndeyptLfq6FVy8udvJsF+kECymQP9LO89X/rzRKJ/9cPbJYCLtj7kiufgUSDJWCJdsivh3lp5a1vzGxLEw5VO2uEAm3UN+/VbYf1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2NCZxMM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777362178; x=1808898178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WkfwgEy4xpwHn+VhVmIheSHazkvkv+HEQOBMy9vIyCI=;
  b=J2NCZxMMxGpgm0NKI84IxlaRp5ZPVyU/l3EB8jzuRK5qYLdq2KspfP2f
   a/hX/z9VXd+nr+9eZv5DU+hEVdynmNAOgpSDR6rW9WCg9XcrLoOa937jk
   PhbBxHbm0JYoI/iClRH3WeQRFhHICAmkzE3JxJN0S7I7BI1hq3Ip2yDPf
   r3uYDD6jFRnwV/ISusHa2pKj2fXpoPXQ2v5U6ocLVSV/k8OUM0R/jxETJ
   gIP29sZY6Nm3q1EsRdjr7aQEZtFDrsH/z+r8DMBlJq7y56g8tRB07ZIRU
   ogjMi5YJtUpK1nFVwPJU4jeBAc/Hld7Dp/389rDMheNDRqtBk/CUAr/Jg
   A==;
X-CSE-ConnectionGUID: dwzuz60pRxiOKULhJ5kPWw==
X-CSE-MsgGUID: zXJh1p16SYCKuBeFmXQ2QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89642703"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89642703"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:42:57 -0700
X-CSE-ConnectionGUID: Pjdk7IkgQ3aQ/BHoXUMwZg==
X-CSE-MsgGUID: agFps5F4QN6PgRr3lSP7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="264265535"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 28 Apr 2026 00:42:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 2CE1795; Tue, 28 Apr 2026 09:42:53 +0200 (CEST)
Date: Tue, 28 Apr 2026 09:42:53 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Benjamin Berman <benjamin.s.berman@gmail.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
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
Message-ID: <20260428074253.GP557136@black.igk.intel.com>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
 <20260428015521.3454006-3-benjamin.s.berman@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428015521.3454006-3-benjamin.s.berman@gmail.com>
X-Rspamd-Queue-Id: 7CB6247F8DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[black.igk.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,anthropic.com:email]

On Mon, Apr 27, 2026 at 06:55:21PM -0700, Benjamin Berman wrote:
> The default TBNET_RING_SIZE of 256 and the NAPI_POLL_WEIGHT of 64
> implicit in netif_napi_add() are too small for host-to-host Thunderbolt
> networking under sustained bulk traffic.  Running NCCL all-reduce over
> tb-lo on a three-node chain (two TB3 endpoints plus a TB4 Maple Ridge
> transit) produces rx_missed_errors at ~1 % of rx_packets on the transit
> and ~0.6 % on the endpoints, with rx_packets stalling against a peer's
> continuing tx_packets.
> 
> Raise TBNET_RING_SIZE to 2048 (8x) and use netif_napi_add_weight() with
> a per-NAPI weight of 256 so tbnet_poll() drains more frames per softirq
> invocation.  With matching sysctls (net.core.netdev_budget=1024,
> net.core.netdev_budget_usecs=8000) rx_missed_errors stays below 0.005 %
> over a 192 GB all-reduce workload on the same hardware.
> 
> Generated-by: Claude Opus 4.7 <claude-opus-4-7@anthropic.com>
> Tested-by: Benjamin Berman <benjamin.s.berman@gmail.com>
> Signed-off-by: Benjamin Berman <benjamin.s.berman@gmail.com>

For ring size I don't have any objections. The current ring size 256 is
arbitrary and at the time seemed reasonable.

For the poll weigth there is the comment in netdevice.h:

/* Default NAPI poll() weight
 * Device drivers are strongly advised to not use bigger value
 */
#define NAPI_POLL_WEIGHT 64

But if you see improvement using 256 here I'm fine with that unless the
network folks advice otherwise.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

