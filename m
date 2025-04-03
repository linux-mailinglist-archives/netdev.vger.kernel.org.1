Return-Path: <netdev+bounces-179089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 402BFA7A8D1
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39797A6358
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6572528F9;
	Thu,  3 Apr 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGZmO3yG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BC24BBE9;
	Thu,  3 Apr 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702389; cv=none; b=aUrChNfC+ObQx8yBSkECJdUw7y2lcmwGYf3f+yBZ7X1NSxpJT5ClyP4h2ujMKTJ57C06yBbzgWnp2a59MicdpM410XMisYlVuEgABSXuvmUA0q18aX8K1Dv0hTibI6WP5TWPmAZ8pUaYZCQ0GsIgW7J91Uy6oWi/vC379kyEH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702389; c=relaxed/simple;
	bh=CrVVJHvTACiAZiAbOqNpxsX5Sm/7YBaDo7amhX5eups=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re6UXnE0xbOaRPkB5ShmevOX+w84S26sF8K3kktu9zTDsHDQKtaaiJ5VrozXPRSwU8FZUWEc81ZDAoGweC6Yq7dRsAoTJyUrEzNT21KZqqPLEZwgFsFJ0TkILq/k9CcuLhPcQxN87SxiCzdqL7PlRCtksWEIH9PrIOral4AYlaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGZmO3yG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743702388; x=1775238388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CrVVJHvTACiAZiAbOqNpxsX5Sm/7YBaDo7amhX5eups=;
  b=ZGZmO3yGH5xYed/hHCi6XnPYnhJHt5z+mSXCMEJV8aWe2oaHofjeIygd
   KzOyLjJX49KZPBsX919wmk5TcbDHOHcyd09W7YlzlPg/PJKks3hLUvz0w
   oV5Me9Ut42XEc6qYMtZG7CR7zJ41q574hAJfeSPTRVTpfsGKwwXLqjtOL
   Cbjdija+y8AAHsCS8djEvP/JJKrCTSQpw3QwHSQcJ7nIBrA5iYtqh2TqX
   G74E37OG6T5JmJ1KF9uf1Uoz6+aSLzfSKwW7Hos0P77SZZAXl/v+/bIuO
   2uq4jYutnA2VCo5nYqLhTvDT4Jv+crpYpuf9IotDMeVkk8K/7T7AC8Y53
   w==;
X-CSE-ConnectionGUID: ZQ3GbaH6TzahkG/A5JKI+w==
X-CSE-MsgGUID: Qs74iPb+RVaWSn7FWNcHaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45247842"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="45247842"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 10:46:27 -0700
X-CSE-ConnectionGUID: XL8V0+HVRweSrPe2l+1fFA==
X-CSE-MsgGUID: fYhD+ywtTVC4LwHnZlU8Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="164309309"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 10:46:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0Odw-00000008ssY-2AYW;
	Thu, 03 Apr 2025 20:46:20 +0300
Date: Thu, 3 Apr 2025 20:46:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	torvalds@linux-foundation.org, peterz@infradead.org,
	Jann Horn <jannh@google.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
	Christoph Lameter <cl@gentwo.org>
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <Z-7JbPeMlnpspKM_@smile.fi.intel.com>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <3f387b13-5482-46ed-9f52-4a9ed7001e67@suse.cz>
 <202504030955.5C4B7D82@keescook>
 <Z-7G6_jm4SKtSO7a@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-7G6_jm4SKtSO7a@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 06:35:39PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 03, 2025 at 09:59:41AM -0700, Kees Cook wrote:
> > On Wed, Apr 02, 2025 at 12:44:50PM +0200, Vlastimil Babka wrote:
> > > Cc Kees and others from his related efforts:
> > > 
> > > https://lore.kernel.org/all/20250321202620.work.175-kees@kernel.org/
> > 
> > I think, unfortunately, the consensus is that "invisible side-effects"
> > are not going to be tolerated. After I finish with kmalloc_obj(), I'd
> > like to take another run at this for basically providing something like:
> > 
> > static inline __must_check
> > void *kfree(void *p) { __kfree(p); return NULL; }
> > 
> > And then switch all:
> > 
> > 	kfree(s->ptr);
> > 
> > to
> > 
> > 	s->ptr = kfree(s->ptr);
> > 
> > Where s->ptr isn't used again.
> 
> Umm ... kfree is now going to be __must_check?  That's a lot of churn.
> 
> I'd just go with making kfree() return NULL and leave off the
> __must_check.  It doesn't need the __kfree() indirection either.
> That lets individual functions opt into the new safety.

Maybe something like

void kfree_and_null(void **ptr)
{
	__kfree(*ptr);
	*ptr = NULL;
}

?

-- 
With Best Regards,
Andy Shevchenko



