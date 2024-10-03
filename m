Return-Path: <netdev+bounces-131596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A591A98EF79
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BDD2819EA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF174186E3C;
	Thu,  3 Oct 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gb+YIOaR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDF16BE1C;
	Thu,  3 Oct 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959404; cv=none; b=S/eJfTS0a8Jo1pUinVGdONs6q5fpAmwgjlXrz6PtVRryz/IUM8/y39myrZ/riA/s8dqcBaqia4nn/bp6UQpUzZYDoKKPMuzM9h99Pc421RP/y6tkWEfcgp3hdBrO6Ol9okpTpDFKf2ih93bykKYvDrvKyBofZ9Av0sbEt/cZalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959404; c=relaxed/simple;
	bh=xhWFuP0rsp7vvJJeztFgfzvw0/OXIPZ4Vuby2+k1uRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFRc8k9p/wkkuRUoY4sMiFSOPB8S891+bDJbK1CqE4jIqy/74emsC9vSJblWfjWx8vPEWaS3dS0ohY7Yabyern/w6ZdWbQu/zw1qQQftFzpQYe6mHiO7jawXFU/esn9FTZYzq8FzSyojHMhMwBI8ZJoG8fv4C9otSw9QKVT8qxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gb+YIOaR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727959404; x=1759495404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhWFuP0rsp7vvJJeztFgfzvw0/OXIPZ4Vuby2+k1uRk=;
  b=gb+YIOaRoRX0HUjYuGqfoMPZTWcPp/IvY0tTv8QfhXXd0tdDmWBrkptT
   ge7W4oZRIkTBd13+9G7wavXbZpAk1oic5hnISZgNJGHb7T1/oGTEXnA2y
   W0/RCbEmz0iGNUVDO8/YPusCuY/eL+I4ZcxIOYiDsmwqge5t3rcyudfp6
   M++pBIX+nagQTgYqke0GTp/Z+ggZuskMI59vo747Yyax3UwHn2KuYMvqg
   i+O3voDy26zSsUafDB4EcB/qoifIkhlFfhQ0dbFByibGaspIpPdkHZwsv
   EpGPRe4o8GZ9CKNSlu8AIEVPmdvHK3OejwPYAeAC2hpsBF+Lk2F+5fJ4g
   A==;
X-CSE-ConnectionGUID: BZw5w6U3Qv6Mwn+3FNbO4g==
X-CSE-MsgGUID: 3R0hvC3qRXqcoq7eb5ZaJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="44676864"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="44676864"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:43:23 -0700
X-CSE-ConnectionGUID: q4hsEp9NRGaNUduK88iSuw==
X-CSE-MsgGUID: 5lwGxnAEThuNWDuZ+Vuxqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="105105586"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:43:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1swLAr-0000000G912-2F03;
	Thu, 03 Oct 2024 15:43:17 +0300
Date: Thu, 3 Oct 2024 15:43:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 03, 2024 at 01:39:06PM +0200, Przemek Kitszel wrote:
> Change scoped_guard() to make reasoning about it easier for static
> analysis tools (smatch, compiler diagnostics), especially to enable them
> to tell if the given scoped_guard() is conditional (interruptible-locks,
> try-locks) or not (like simple mutex_lock()).
> 
> Add compile-time error if scoped_cond_guard() is used for non-conditional
> lock class.
> 
> Beyond easier tooling and a little shrink reported by bloat-o-meter:
> add/remove: 3/2 grow/shrink: 45/55 up/down: 1573/-2069 (-496)
> this patch enables developer to write code like:
> 
> int foo(struct my_drv *adapter)
> {
> 	scoped_guard(spinlock, &adapter->some_spinlock)
> 		return adapter->spinlock_protected_var;
> }
> 
> Current scoped_guard() implementation does not support that,
> due to compiler complaining:
> error: control reaches end of non-void function [-Werror=return-type]
> 
> Technical stuff about the change:
> scoped_guard() macro uses common idiom of using "for" statement to declare
> a scoped variable. Unfortunately, current logic is too hard for compiler
> diagnostics to be sure that there is exactly one loop step; fix that.
> 
> To make any loop so trivial that there is no above warning, it must not
> depend on any non-const variable to tell if there are more steps. There is
> no obvious solution for that in C, but one could use the compound
> statement expression with "goto" jumping past the "loop", effectively
> leaving only the subscope part of the loop semantics.
> 
> More impl details:
> one more level of macro indirection is now needed to avoid duplicating
> label names;
> I didn't spot any other place that is using the
> "for (...; goto label) if (0) label: break;" idiom, so it's not packed
> for reuse, what makes actual macros code cleaner.
> 
> There was also a need to introduce const true/false variable per lock
> class, it is used to aid compiler diagnostics reasoning about "exactly
> 1 step" loops (note that converting that to function would undo the whole
> benefit).

...

> +#define __scoped_guard_labeled(_label, _name, args...)			\
> +	for (CLASS(_name, scope)(args);					\
> +	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
> +		     ({ goto _label; }))				\
> +		if (0)							\
> +		_label:							\
> +			break;						\
> +		else

I believe the following will folow more the style we use in the kernel:

#define __scoped_guard_labeled(_label, _name, args...)			\
	for (CLASS(_name, scope)(args);					\
	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
		     ({ goto _label; }))				\
		if (0) {						\
_label:									\
			break;						\
		} else

...

> -	     *done = NULL; !done; done = (void *)1) \
> +	     *done = NULL; !done; done = (void *)1 +  	\

You have TABs/spaces mix in this line now.

-- 
With Best Regards,
Andy Shevchenko



