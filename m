Return-Path: <netdev+bounces-259716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMGOJ+1imGkVHgMAu9opvQ
	(envelope-from <netdev+bounces-259716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:34:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC70167D74
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 549CD3013CBA
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70D32D7DE;
	Fri, 20 Feb 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJiN8UzI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665B33987;
	Fri, 20 Feb 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594470; cv=none; b=VZgcV/bdztNnjYD3Qze1vrKwxCBxL7f2e0uKIEefG5zwgkpdYaapg7uRWYBZhK4FYx86XgFJ4ecI2qttK48OZckJjcgqY05psBgZkPx0yoO48hTqAJe7K7nToIdiNM4TriSdAI4F8waoG2iOyhvY/C5jYW7XORNAY5KYp+ZfrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594470; c=relaxed/simple;
	bh=m1QgOYW40aFhzQ8JhTfL3QaG1cANNqKXW578Fy/kw9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARXZM+7v1QIRBhwERHgYhV+czY+Bvkuta5m5CjBZlqmQiuu3/1OElMJt3X56x7lfBsC6IKew/W1Qm1Kn98PUwfNfqLfOwBTMKqsoXAyORfGFq4/4go3KPiy7JiZirzHU8Kab4wb76NlKl8k9nHekornr1Cgz5EIcanub92oAJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJiN8UzI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771594469; x=1803130469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m1QgOYW40aFhzQ8JhTfL3QaG1cANNqKXW578Fy/kw9Y=;
  b=aJiN8UzIA+9wn95Xub0e1o+9lA3Bs93+6sscjPBXGgIcP+i6LgjxlXkB
   mTj7cvC4J0r/xeLmbPNZ4MfIoUuE38q82sv0JJewQiAuw6PiEix+yaCWb
   EVeqfnQ1z7iq3U2fdCjwSoqJWLPsBUQWKyPDGNN0T5d9oRwTYIMUNi3OW
   BuaR+d81u2d9PefGTHfR6kokI6mIJByYxcriYp3husDRtrjbxLjoeGk0P
   DQLziO+XjuGOKMo3Y3mHAU57FoVlel4YRHiI8WTy/9YqvUf6a5d/CZqw3
   JELWieeEls2j/+SjdNBShDQqO8vX2OjVMkZdlDyrBhqVcEZCWOZUwK0F+
   A==;
X-CSE-ConnectionGUID: mwcM9laYSDeidkH3nY0diw==
X-CSE-MsgGUID: qFCg502fQNmPN0G/+qmNLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="90268073"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="90268073"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:34:29 -0800
X-CSE-ConnectionGUID: dZ1u3LKJQTK99IVUMNj3TA==
X-CSE-MsgGUID: H14YBqZrRJmNurFMhCeeRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219394598"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:34:26 -0800
Date: Fri, 20 Feb 2026 15:34:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, netdev@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v1 1/1] clk: baikal-t1: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <aZhi4Jn_TRRPtkJH@smile.fi.intel.com>
References: <20260220082210.2320303-1-andriy.shevchenko@linux.intel.com>
 <aZhQoY55bwGj8LJc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZhQoY55bwGj8LJc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[aspeedtech.com,google.com,vger.kernel.org,baylibre.com,kernel.org,gmail.com,pengutronix.de];
	TAGGED_FROM(0.00)[bounces-259716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCC70167D74
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:16:33AM -0500, Brian Masney wrote:
> On Fri, Feb 20, 2026 at 09:22:10AM +0100, Andy Shevchenko wrote:
> > As noticed in the discussion [1] the Baikal SoC and platforms
> > are not going to be finalized, hence remove stale code.
> > 
> > Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>

Thanks.
We also need to remove YAML. I take your tag and remove those files in v2.

-- 
With Best Regards,
Andy Shevchenko



