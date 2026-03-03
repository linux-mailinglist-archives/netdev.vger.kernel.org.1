Return-Path: <netdev+bounces-263454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EyTB0lnp2mghAAAu9opvQ
	(envelope-from <netdev+bounces-263454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:57:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB21F8372
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A283230523F7
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D14A390224;
	Tue,  3 Mar 2026 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2uw9J4n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90A3644CB
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578521; cv=none; b=AXAmQ2ASsTGsUFJvKRc+66ZiDKItZ4wdGk9+F45y+D2F5otiF9akih2J0J91xvXd1Fu8c1YJs77SrOytYK5jlPv5mm6C5ViMLDMEH4uc4Um/icVo11aeamRz4rgEclP5uGne067inxDPhnHFozdIhPVdjTisZOC3tFK4QIWca6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578521; c=relaxed/simple;
	bh=VGKG2ImUg34B0C6o1nUVQQpbbrDIgsJoShVgk68zd9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ2V4jwDDOqUhp22Tpvx3hkNHq9a+/8DA2M4LRtdAu+LOAMcG6uMdNUaJipqN0UDVpmClhP+5Injvt5HZArgCgYtZkj7AwWtTiVvWJTUiHW8dKp/jQ7p5m/54CAelawXJRkTEMagOz+8fhOhsy+XM4VsFVwD7YZl6fih0zBshek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2uw9J4n; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772578520; x=1804114520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VGKG2ImUg34B0C6o1nUVQQpbbrDIgsJoShVgk68zd9w=;
  b=g2uw9J4n/8uvZ4iPMQw03b2B+FMd4Z8Y1OjVARIuRmj50IjGKd8JfHs1
   pvO+hQgoZ4tkrF+UNPlc8C6Qicm+vC3HmGMaydiRKcsqWP8aGmutmIp5F
   pc/x5UQPIgTEd34ZWwp0WeJMZfjYXvqyeLM7CPRSheD+AjIS8t4P1G5R7
   cO9QMf8gxe50mNKCLFoHqh0oy/t06V6J4UEdO3nRh99LCQNHMzAM3tWBq
   rLlFu06pxIXDgpEoRRMWgeLJbM081M/X1flGdg9umGTWcP2Ml8phPJQbs
   GGoUpaajBz1mvOz7yNoq8T4qUmoV0Ips39X0xpiZ7acfFz7Gu/PQox4Wy
   g==;
X-CSE-ConnectionGUID: Bh+njRcGR+iBXQiEZKAqUA==
X-CSE-MsgGUID: LNFMc7jYQwK3oagjXu1PaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73547943"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73547943"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:55:19 -0800
X-CSE-ConnectionGUID: LoWXKm9/SEKsrfaX9rkAkw==
X-CSE-MsgGUID: UlLP56elSZSO6XuI64meaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="223149268"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 14:55:17 -0800
Date: Wed, 4 Mar 2026 00:55:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 3/4] i40e: Add missing header
Message-ID: <aadm0q5QuWM3hGNx@ashevche-desk.local>
References: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
 <20260302234105.2658400-4-anthony.l.nguyen@intel.com>
 <aaaVnmx_QHcpiVbG@ashevche-desk.local>
 <39f4c46c-4db9-4178-99e0-8e3f3a452ab4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f4c46c-4db9-4178-99e0-8e3f3a452ab4@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: E3AB21F8372
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:?];
	TAGGED_FROM(0.00)[bounces-263454-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.419];
	R_DKIM_TEMPFAIL(0.00)[intel.com:s=Intel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_DNSFAIL(0.00)[intel.com : SPF/DKIM temp error,none];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:37:40AM -0800, Tony Nguyen wrote:
> On 3/3/2026 12:02 AM, Andy Shevchenko wrote:
> > On Mon, Mar 02, 2026 at 03:41:01PM -0800, Tony Nguyen wrote:
> > 
> > > When cleaning up another header I have met this build error:
> > > 
> > > drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
> > >    105 |         val1 = (u32)(upper_32_bits(pa));                                \
> > > 
> > > This is due to missing header, add it to fix the possible issue.
> > 
> > There was a v2 with the other (missing here) tag is added (it was given against
> > v1 conditionally) and Subject amendeded.
> 
> I assumed you had found another missing header with that other patch; guess
> I should've looked closer :(

I was talking about commit message tag and an updated Subject. The code is
the same.

> I'll update the PR with the new one.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



