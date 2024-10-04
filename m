Return-Path: <netdev+bounces-132072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34BE9904DA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6328E281D7D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE74212EE8;
	Fri,  4 Oct 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvfG7u9+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6422101B0;
	Fri,  4 Oct 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049933; cv=none; b=fsc+IlF3W5b4XnO4WHEnGjbrcRrkMC1kbYQCLoMjwnzo9thS41GfDv/DUobjK5xBGZyt85S9su5vwoDW4SvoaRiH4vcQbPbnzYCNuotQBuxITe/Qzeorwb2ZeINfq60REIIFA2QvtOEct3XZcXDomus8yx8y2i5pNTV/0jqXdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049933; c=relaxed/simple;
	bh=aEtq4osjabaRUs7y50Bxwj5wtp8wTPVFs2pegUenVxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyvcB9Kckkftc896giPq2nUB/rLlzy/0q+aAjmVOp2zV/S+3WPIws2rWOsxLpmWtWKvUfaaXHCjzd8T8v/sTLyUNP0qHmPgaPxWX1Tda4aiBEZzytql7QDlQocoF4oN1X0S76CYRHd91ux/dgQjyp35UW1UFUogOfI2qhlNGLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvfG7u9+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728049932; x=1759585932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aEtq4osjabaRUs7y50Bxwj5wtp8wTPVFs2pegUenVxQ=;
  b=TvfG7u9+fqh+Zjh86yQzGeiJY64/j4R2n8QKquY9YK3vkIraue5xPL8E
   4c/6adgOIAoF5BcRNX/u4E5GMqNy7f7xQBSa2nX+f7lhru6ulhV1Py28U
   u8z9zy7Rq59emAozBK6OvnSBDDPK9jiqOfgRWj+bNGkmlxiIl6vtE2UFT
   tIsbb+ykCEsvzGEI+9bT/K44QvDdXfhhSXs91lEsbMXn6qUKkt5omyXXD
   vUVvLW5z5QTqUrh12g2YnsN1ysn4/ftBBNnVpIB7HYqDpVhoegBroDjg2
   gt5lAe/og39eMzrhHrXQwrVLRtT6HgDfcpQ94m/l6pa0fIGEz8olveaxa
   Q==;
X-CSE-ConnectionGUID: jArmUhy7QteDyioZDiAgWQ==
X-CSE-MsgGUID: 7mCNYxVzSdSKRSsVdM/GcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="52676772"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52676772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 06:52:12 -0700
X-CSE-ConnectionGUID: MQUDCC1WTz2K9lDVCQJN9w==
X-CSE-MsgGUID: +tjWUo/HS9qhyUNxPmi/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="105452813"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 06:52:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1swij0-0000000GaKE-1Dpv;
	Fri, 04 Oct 2024 16:52:06 +0300
Date: Fri, 4 Oct 2024 16:52:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <Zv_zBvkq4jsvOVdY@smile.fi.intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <Zv6RZS3bjfNcwh-B@smile.fi.intel.com>
 <Zv6SIHeN_nOWSH41@smile.fi.intel.com>
 <20241003141221.GT5594@noisy.programming.kicks-ass.net>
 <Zv7ZsieITDle2lgl@smile.fi.intel.com>
 <20241004093308.GI18071@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004093308.GI18071@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 04, 2024 at 11:33:08AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 03, 2024 at 08:51:46PM +0300, Andy Shevchenko wrote:
> > > I would really like to understand why you don't like this; care to
> > > elaborate Andy?
> > 
> > To me the idea of
> > 
> > int my_foo(...)
> > {
> > 	NOT_my_foo_macro(...)
> > 		return X;
> > }
> > 
> > is counter intuitive from C programming. Without knowing the magic behind the
> > scenes of NOT_my_foo_macro() I would eager to ask for adding a dead code like
> > 
> > int my_foo(...)
> > {
> > 	NOT_my_foo_macro(...)
> > 		return X;
> > 	return 0;
> > }
> 
> Well, this is kernel coding, we don't really do (std) C anymore, and
> using *anything* without knowing the magic behind it is asking for fail.

True in many cases, mostly for macros themselves, but in the functions
I would prefer to stay away from magic as possible.

> Also, something like:
> 
> int my_foo()
> {
> 	for (;;)
> 		return X;
> }
> 
> or
> 
> int my_foo()
> {
> 	do {
> 		return X;
> 	} while (0);
> }
> 
> is perfectly valid C that no compiler should be complaining about. Yes
> its a wee bit daft, but if you want to write it, that's fine.

Yes, the difference is that it's not hidden from the reader.
The code behind the macro is magic for the reader by default.

> The point being that the compiler can determine there is no path not
> hitting that return.
> 
> Apparently the current for loop is defeating the compiler, I see no
> reason not to change it in such a way that the compiler is able to
> determine wtf happens -- that can only help.
> 
> > What I would agree on is
> > 
> > int my_foo(...)
> > {
> > 	return NOT_my_foo_macro(..., X);
> > }
> 
> That just really won't work with things as they are ofcourse.
> 
> > Or just using guard()().

Okay, thanks for sharing your view on this. Since you are the author
of the original code and seems fine with a change, I can't help myself
from withdrawing my NACK. OTOH, I am not going to give an Ack either.

> That's always an option. You don't *have* to use the -- to you -- weird
> form.

Yes, I am not convinced that using scoped_guard() (or any other macro)
in a described way is okay. Definitely, *I am* not going to do a such
until I understand the real benefit of it.

-- 
With Best Regards,
Andy Shevchenko



