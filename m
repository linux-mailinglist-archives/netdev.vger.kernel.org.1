Return-Path: <netdev+bounces-96011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A635E8C3FB4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478941F22416
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49714C586;
	Mon, 13 May 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N64xO3GZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53291487DE;
	Mon, 13 May 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599221; cv=none; b=VWD1W4BgSHaXTkxa5lt65ZqnPJLKQepSzDEgsFUHdY2G8vZDgzrO8eSzU51Jfwn1SkpzwIohsNP9WpdsENJbQr+UbsLXYJXML4YvrpsLBZauMABjJC2YZg3/YRxtuw4jysFIfU5GXo9n+ZyEWNR5sIXaBtkvl0FqzVkk9hkpSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599221; c=relaxed/simple;
	bh=RH4wkxhYNMrJGXF3Af+Oo/w1xDf5vFVpf71RPqH/jJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dThPnUARbyMic1xbIqk1RM2XAEzwM1kuHbOgBwdpbANvaXnR9/bEpXwrCNIzr8WUrUTaytRIHM/sXiaAYEJii3jckeyZP9wheKX+mmPeMYPin83A4+SOQqnb9BOarmcQ21l2E2ZOaIEsxlee9IJK1Ex6Z1BZJ1/DBGH2VRiMEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N64xO3GZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715599220; x=1747135220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RH4wkxhYNMrJGXF3Af+Oo/w1xDf5vFVpf71RPqH/jJ4=;
  b=N64xO3GZ3owZy6uMOVYjpGhIL9x/eKQYJI/60d8DvjDXnxf3rcV055q6
   mTixYGtHjQ1BXYEKxS/Y8GXbakDqvsMzKCOmyWpFhO6OgU7w7YyyVvgkq
   +2m0O2ZfLHhA0JPnzXrGXXlALW0smIOu0sR0Vm0mDNVs0I15a5XiJb8sI
   q0tXH/vbW1CrY1Xr3Kb2Q569y6J9P1KKfSszpJPBycCN/L3J8zca745B1
   tn0p1U5TQuE02TDEoyP8ZYj4d4IBibJfZGsHZOjJdQqguv/qPIA5h65VV
   DYffnE0e6W9o65/H7KEbw0MDuJuLkpRm30ykkt9QMp4jhDIC2tQhvdaH2
   w==;
X-CSE-ConnectionGUID: kQ4ma5zSTQGmRJtf/aopiw==
X-CSE-MsgGUID: xKfj1rizQ++dJkB6ubkgCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11688044"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11688044"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:20:19 -0700
X-CSE-ConnectionGUID: J/4b2f0ARZOReGHXD88oMA==
X-CSE-MsgGUID: AtogBFklRTOPGTXqvev16A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="35067355"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:20:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6Tj0-000000076o9-0ukO;
	Mon, 13 May 2024 14:20:10 +0300
Date: Mon, 13 May 2024 14:20:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org, x86@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, eddie.dong@intel.com,
	christopher.s.hall@intel.com, jesse.brandeburg@intel.com,
	davem@davemloft.net, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, perex@perex.cz,
	linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v8 10/12] pps: generators: Add PPS Generator TIO Driver
Message-ID: <ZkH3aUDaFMR-8Mlo@smile.fi.intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-11-lakshmi.sowjanya.d@intel.com>
 <ZkH3GP2b9WTz9W3W@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkH3GP2b9WTz9W3W@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 13, 2024 at 02:18:49PM +0300, Andy Shevchenko wrote:
> On Mon, May 13, 2024 at 04:08:11PM +0530, lakshmi.sowjanya.d@intel.com wrote:

> > +	pps_tio_disable(tio);
> 
> This...

> > +	tio->enabled = false;
> 
> ...and this should go together, which makes me look at the enabled flag over
> the code and it seems there are a few places where you missed to sync it with
> the reality.
> 
> I would think of something like this:
> 
> 	pps_tio_direction_output() ==> true
> 	pps_tio_disable(tio) ==> false
> 
> where "==> X" means assignment of enabled flag.
> 
> And perhaps this:
> 
> 	tio->enabled = pps_generate_next_pulse(tio, expires + SAFE_TIME_NS);
> 	if (!tio->enabled)
> 		...
> 
> But the above is just thinking out loudly, you may find the better approach(es).

You might need to introduce pps_tio_enable() counterpart, in such case it would
be more natural to have enabled be assigned accordingly.

-- 
With Best Regards,
Andy Shevchenko



