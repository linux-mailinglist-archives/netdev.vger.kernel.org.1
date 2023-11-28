Return-Path: <netdev+bounces-51769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D847E7FBF11
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5DA1C20AA2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79337D33;
	Tue, 28 Nov 2023 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOp/ZuGd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069BD66
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701188311; x=1732724311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dyhMoaYimvk4r41Pj0UDu5KYx3byEDtXluNCU1ZKuZ4=;
  b=kOp/ZuGdzCKlziJuFdQd7X2ibw6JmNYEsbx8DGMxuow2+6m14YHpE+eo
   fLuBSRPKbfY0cPB0O5xlESc16VbUJcyBjGJjmNZIxJUGWxyqAPv+gYrQT
   VPrmCX1UFp6px67IZ6qn/i53is2APVzE1sSNovJAoC66GTrwkKuTCJ8eJ
   0lDUhpf1Pw6zIsVIHVxxJKQFHdSM6pnUmfuceeoZJLI8fnC9FI9v6kbKn
   YZRsMpocDRt5B5l/mSvO30Om5C1liC/qRpFNi3mhca3hIIkICZRwHIXbD
   KyITlVHNRf5zaLVFrXWp0lkQC12QtzZufksNeIuWJ3hyboZP/L50POlIY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457284805"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457284805"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:18:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="839106135"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="839106135"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:18:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r80n2-00000000CtW-0kul;
	Tue, 28 Nov 2023 18:18:24 +0200
Date: Tue, 28 Nov 2023 18:18:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWYSz87OfY_J8RYq@smile.fi.intel.com>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 28, 2023 at 01:30:51PM +0100, Przemek Kitszel wrote:
> On 11/23/23 19:15, Jiri Pirko wrote:

...

> > + * Returns: valid pointer on success, otherwise NULL.
> 
> since you are going to post next revision,
> 
> kernel-doc requires "Return:" section (singular form)
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> 
> for new code we should strive to fulfil the requirement
> (or piss-off someone powerful enough to change the requirement ;))

Interestingly that the script accepts plural for a few keywords.
Is it documented somewhere as deprecated?

-- 
With Best Regards,
Andy Shevchenko



