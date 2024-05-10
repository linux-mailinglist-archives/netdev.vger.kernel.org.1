Return-Path: <netdev+bounces-95498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D48C26D2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3C5B22DD3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD8A170820;
	Fri, 10 May 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5/qGu4S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8714B08C;
	Fri, 10 May 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351286; cv=none; b=p4MmoLjnXFG5feiCcBlZPUjYcY4j4OGcAEzK7gDWEsskv+lJpSypSmMyQjQXoc8r6oJRc7+e/DvbsXSwpnG0ic8Vm90t82J+0Qsu13yy0Jx0UeeQsFb8Ynhb/7C55U+/BOT+rDIcKtP82fJaoTCsBrbamNSyajtsa4ApSFeNDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351286; c=relaxed/simple;
	bh=kz2991U92lAyIp31g+FlBWFiotk7FNz3VZrEBJoZ0qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1M2TvrmCzO5Jx9qcsmLxpe/QkcRkR8GfrX7W6oGiKf3tub7m0UFht6h9rDBl5XWpAW/KKYEMOvs80tXwZQrJv0VLDlhH3Rya+orpv2z7Kkyh7sXj6nEj3pLjp6PPOW0SBrLX037T809ay9aoQgvgcSEvzQILThep6mkQsx7rz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5/qGu4S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351285; x=1746887285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kz2991U92lAyIp31g+FlBWFiotk7FNz3VZrEBJoZ0qw=;
  b=f5/qGu4SOegdF3tV4GDCqoDMA5A80t7wq/e9VwcKWcwcTGPwIfnHvzWL
   UJc792Y/jGVyq3G1ICQ6O9T3tyskM7n2bXT3o3F2StxhrcOAevYY0Vj44
   rcnO3mPZwhV7b3ehf8g8mUAXz+9RrnvHXemfJ73BmRUT8Hw7NDye+Fdd2
   S9ZIngBTJsidgaS0USe28ConIL74sMe0FRExOwYbE6xqKBhH0ytF6eDM2
   a0rMi2Xbe8oRTvUGZLUD8gLUl3MCsnIJkz3pHOXFLOe7jQs6baASXnHwC
   0aL+t2NF/iDn5H/m9QpiJf/aTaIIaPXpKh2LsPwJQkRWukS2H04E/RIgk
   g==;
X-CSE-ConnectionGUID: YQDjtZIKR0KADxFttf2G7Q==
X-CSE-MsgGUID: fA+uijg/TdymXqi10xw/nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11460536"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11460536"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:28:04 -0700
X-CSE-ConnectionGUID: RfUGcRtZRjGlOkFb8E3Fkg==
X-CSE-MsgGUID: haEr3iRVQ/+b1G/BD2RmpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29577789"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:27:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5RE3-000000067xv-15tJ;
	Fri, 10 May 2024 17:27:55 +0300
Date: Fri, 10 May 2024 17:27:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"jstultz@google.com" <jstultz@google.com>,
	"giometti@enneenne.com" <giometti@enneenne.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Dong, Eddie" <eddie.dong@intel.com>,
	"Hall, Christopher S" <christopher.s.hall@intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"peter.hilber@opensynergy.com" <peter.hilber@opensynergy.com>,
	"N, Pandith" <pandith.n@intel.com>,
	"Mohan, Subramanian" <subramanian.mohan@intel.com>,
	"T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: Re: [PATCH v7 10/12] pps: generators: Add PPS Generator TIO Driver
Message-ID: <Zj4u64qC4d2FXSQW@smile.fi.intel.com>
References: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
 <20240430085225.18086-11-lakshmi.sowjanya.d@intel.com>
 <ZjD3ztepVkb5RlVE@smile.fi.intel.com>
 <CY8PR11MB7364F43C08D75878205599A5C4E62@CY8PR11MB7364.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7364F43C08D75878205599A5C4E62@CY8PR11MB7364.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 09, 2024 at 04:38:49AM +0000, D, Lakshmi Sowjanya wrote:

> Will update as suggested.

Just a side note: Since the series most likely missed v6.10, don't forget to
bump dates and versions in ABI documentation in the next version.

-- 
With Best Regards,
Andy Shevchenko



