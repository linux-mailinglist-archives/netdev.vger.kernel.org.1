Return-Path: <netdev+bounces-79121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80928877D85
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F651C20B06
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D85199AD;
	Mon, 11 Mar 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7hbzxs0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9C2E3F9
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151266; cv=none; b=kkDzevH+6y4StBkkMo7qXMM8nuNbqLb+TZbgPlNKQOcWqAgw/byIeql1NJxB1fcPSQQeZK6H8g+WtfyBGa/OEB7nrWJk8j3gJ/jZ6HmUniZ6oyMGMr8nuK7yjHtWyHctnH1YNGiPL9SUULG/VqKsKR2gqJjBHEPD1i5dFxe8muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151266; c=relaxed/simple;
	bh=zKjzyi61+cKiGXB1eb9jj5q7YL5px2kJANb0CTHwR6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AANT0imAf8CqRWRaVfm8sMj8BR7Ddighn94IbiKKR7uxhE848Px2bukEOsJYP6SeYAyMs91VLET241VNH1HV2J7ZHM7w7tq8eovP54+fGaaaNXi++5ThCHBbkgWojenSWLJnLKrRpAhCDIP1BTu/FhGLst1rQv0tuwTYLe0YWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7hbzxs0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710151265; x=1741687265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKjzyi61+cKiGXB1eb9jj5q7YL5px2kJANb0CTHwR6M=;
  b=V7hbzxs0yVIofTOq2iBBk7HOejUrxZDdqRDPHuRLiffAYFmkV6rzPyU7
   QhMuQVkcT7blhrFJTfNTpiq03HA4n/gqKvisjPCfItIxUBNW+vbng/I87
   /cmBrjoeH1Zjpqk3MVc27gfXU0n2AqH9Z830s5K21eLP0h1GAy31NloUL
   WZVwP5PA67njHea3T1ocFpYzRtIsMRZTsIsWG+WRwStT8RLg4s9sJVV6v
   RBe3DgN9wlMKglzQRiYpjkrI2+ziF4hV033mh/1HGH6Y4lmftM6ms7y8q
   Ydo8y5Eg7E3ZT0Kiv2lbEV9OJeX/HrDk390EKyEPvK1uWOlJHWJAaffXc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4941271"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4941271"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914354455"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914354455"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:01:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjcSn-0000000BaPF-0v4c;
	Mon, 11 Mar 2024 12:00:57 +0200
Date: Mon, 11 Mar 2024 12:00:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, Jason@zx2c4.com,
	mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
	sven@narfation.org, pshelar@ovn.org, wireguard@lists.zx2c4.com,
	dev@openvswitch.org
Subject: Re: [PATCH net-next 3/3] genetlink: remove linux/genetlink.h
Message-ID: <Ze7WWLK-xcFHsJyo@smile.fi.intel.com>
References: <20240309183458.3014713-1-kuba@kernel.org>
 <20240309183458.3014713-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309183458.3014713-4-kuba@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 09, 2024 at 10:34:58AM -0800, Jakub Kicinski wrote:
> genetlink.h is a shell of what used to be a combined uAPI
> and kernel header over a decade ago. It has fewer than
> 10 lines of code. Merge it into net/genetlink.h.
> In some ways it'd be better to keep the combined header
> under linux/ but it would make looking through git history
> harder.

...

> +/* All generic netlink requests are serialized by a global lock.  */
> +extern void genl_lock(void);
> +extern void genl_unlock(void);

Do you need to inherit unneeded 'extern' here?

...

> +#define MODULE_ALIAS_GENL_FAMILY(family) \
> + MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)

This is using the macro defined in net.h which seems not being included.

-- 
With Best Regards,
Andy Shevchenko



