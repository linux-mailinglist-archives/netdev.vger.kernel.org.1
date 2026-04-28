Return-Path: <netdev+bounces-282022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GJJFXTv8Gn9bAEAu9opvQ
	(envelope-from <netdev+bounces-282022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:33:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB148A03E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B688B30094F5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99437BE71;
	Tue, 28 Apr 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csvNM0zM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC42CCB9;
	Tue, 28 Apr 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397280; cv=none; b=Mh6alqJqs9C6DERabqfriNBR+ndSucEaJ4TuIFYWfAKYLYyKz1bguhe955ymaoGXshA6qsqLPk52g/iyHDoIRorEPdTKCCyFEglvtogZ2EPA2cgP0MOk+ifd5cifU4zl/C+Oac4jubpkPsMtMybKFbDM+PUGFu03YSwXdHtzRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397280; c=relaxed/simple;
	bh=fFzheG6pg0w3mu3tSRdcQjekznVtxOE8N/J6sYf6EFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDyxe2vHf6S4o7xek60HQqrA1T5ITCEImQvgEhJ7KJPqD/OzcqMBRR6n45nMAp8WdpBhr0Sg1MLdqAS8d3/5vqL8tKFh20JwRo2QL4Q+e8g6TdC5qgeUCDzNdvRrMewKtLiOGMuRNgpC/dPPysb2d8BzNdLW0uucBXP3TyNtMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csvNM0zM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777397279; x=1808933279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fFzheG6pg0w3mu3tSRdcQjekznVtxOE8N/J6sYf6EFs=;
  b=csvNM0zM0+epkMuqr9mJ9vBpq/VzfazMcV595UiUpi6e/j6ZR7wNrgEZ
   A3GacPjHLMS2Su1Y0HPHTUkgm/p2XgaabHQVzlgRWb3Z+VznP2L3tqeY2
   6c6vh1qczyXgmdGdfhQAIw2R+cEw73HSsEt/Hk3xFj6EH9sOhoysHP64H
   +yOKYyotrzHG2jHFOX/0dEm02NTn0oUfc0lviDjKtLEuOMmw6ky0R0SYL
   H8G5H6b1/rOLR4U4G4Y93VJ4+LehYdRyM1kTCK1B5jSqG2PEePBmWn/eg
   Q/bC/t1UvGwmhx8lYwa2cxl/1vwx95B/44FDj+cn7V47dBe7fkuSsxOpq
   Q==;
X-CSE-ConnectionGUID: emdfPmxrSgeaOzHnSLHb0A==
X-CSE-MsgGUID: lb1Sx3kzTFy7Fsuiq56uAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="82170827"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="82170827"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:27:59 -0700
X-CSE-ConnectionGUID: LK4b8zHrR3imNa2AdjG/0g==
X-CSE-MsgGUID: aDRFTRLARlSNFySST34g5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233980345"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 28 Apr 2026 10:27:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1C2C995; Tue, 28 Apr 2026 19:27:55 +0200 (CEST)
Date: Tue, 28 Apr 2026 19:27:55 +0200
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
Message-ID: <20260428172755.GX557136@black.igk.intel.com>
References: <20260428015521.3454006-1-benjamin.s.berman@gmail.com>
 <20260428015521.3454006-3-benjamin.s.berman@gmail.com>
 <20260428074253.GP557136@black.igk.intel.com>
 <e6a249d5-8b11-43cf-89ee-14d436c70cf8@lunn.ch>
 <20260428141954.GT557136@black.igk.intel.com>
 <0dce1878-f54a-44f4-b755-2ea6899c8c9f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0dce1878-f54a-44f4-b755-2ea6899c8c9f@lunn.ch>
X-Rspamd-Queue-Id: C1EB148A03E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282022-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]

On Tue, Apr 28, 2026 at 04:39:25PM +0200, Andrew Lunn wrote:
> > > Is there interrupt coalesce going on, and the coalesce time set too
> > > high, so that by the time the interrupt fires the ring is full? Can
> > > you play with ethtool -C?
> > 
> > Thanks!
> > 
> > I'll leave these to Benjamin and Claude AI to answer.
> > 
> > One thing that could affect is the interrupt throttling that the hardware
> > is doing. We have quite big value there by default. Lowering that may have
> > affect as well. I just posted a patch series where one of the patches makes
> > this configurable in the tbnet driver so you could apply that and play with
> > the throttling value:
> > 
> > https://lore.kernel.org/linux-usb/20260428072209.3084930-6-mika.westerberg@linux.intel.com/
> 
> So i guess this is interrupt coalesce by another name.
> 
> In netdev, the module parameter would get NACKed.

Okay.

> [Looks more closely at the code].
> 
> So, you are adding the module parameter in
> drivers/net/thunderbolt/main.c. That clearly is netdev code. So sorry,
> please don't do that.
> 
> But ethtool provides an API for configuring these things:
> 
>        ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-tx on|off]
>               [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-irq N]
>               [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-irq N]
>               [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
>               [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
>               [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
>               [tx-usecs-high N] [tx-frames-high N] [sample-interval N]
> 
> So i hope you can map these parameters to your tb_ring_throttling()
> call.

Sure, that's not mandatory (as I explain in the other thread). I can just
drop that part.

