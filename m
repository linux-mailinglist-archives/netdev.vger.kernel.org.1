Return-Path: <netdev+bounces-178797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02FA78F2E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A0A16800D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CEF23959D;
	Wed,  2 Apr 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSs8p4TL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296E218ADD;
	Wed,  2 Apr 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598545; cv=none; b=hvMKQmYQ1Eqd+T/JQf2YOk0qAeNMnGRaKwTFFbGcA3ljdOmhfhvq7AlZBAxmvUCSyPakvBs07vG1TVdhG6+DCcNAgalfjplIBmAdLGzgYpaJFTsOLLMakgwuu1BWuCh4PFAxHrfCx8UehoVBVKOsVGY+8Y0ci4CMnJcLMAD+S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598545; c=relaxed/simple;
	bh=TXtLquoRRAqtrc02VbnTtQ9X9BjOAMh9LtUpk4wHJVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNoFK9zuKGOX64cpRiTU8MaSLZIwLur4E34V/MNt5rMaI+3Oj4BW8SvtWEpZR2xIS0frE6IqIZ3QYfrj7EsBnBj5/+ygiq7vhEYH1Hw/TuDb5kF+dRAnKuP+Sb+nDpf21xoXgAoaEws0WUKYXMKfO7i9ReemIlTVkridj6ghvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSs8p4TL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743598545; x=1775134545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TXtLquoRRAqtrc02VbnTtQ9X9BjOAMh9LtUpk4wHJVY=;
  b=LSs8p4TLXKntODjuiLjsV3xe8XE1hMKVbTOLuYg7aLvJJZWapRbXcjU/
   XKNgUjBDeOEykp+XFBr2koeVRtETY7fCI6KooWWQLdYYAHsxwVwD/MFfD
   nJ13QaRIod5DKhI7dPECALqveoW4yDloFIW+D0XOqQPnaZFXiWSY299u7
   6iPitRKgev4ou10EZsuRyqAoTUAZ7s/MZP8tmNIi3pBSpZMqNXKBibFk8
   yNPPIllo/iCiVvCLcHJnUQcrUT6MECkWu+0vOWb7bSXmQdV+CsOiBhrSW
   F7huz5TWeXUbHaBCX7JgHHnw/W6WdbEHkuzTaKx8lTtPiwtlT2X7ZdgxU
   Q==;
X-CSE-ConnectionGUID: 6zoZj8oeSYW8RhVMqWAKFQ==
X-CSE-MsgGUID: SxfbFDUPRFauchmAwORIHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55955133"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="55955133"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:55:44 -0700
X-CSE-ConnectionGUID: zOjX9rwPToG2JDLyvrPKUA==
X-CSE-MsgGUID: LT6rlRGDQG61zNwAkljtKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126650218"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:55:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tzxd4-00000008ToG-2Zb4;
	Wed, 02 Apr 2025 15:55:38 +0300
Date: Wed, 2 Apr 2025 15:55:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	torvalds@linux-foundation.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <Z-0zykUvrF-73MXI@smile.fi.intel.com>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
 <20250402122104.GK25239@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402122104.GK25239@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 02, 2025 at 02:21:04PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 02, 2025 at 01:32:51PM +0300, Andy Shevchenko wrote:
> > What would be better in my opinion is to have it something like DEFINE_*()
> > type, which will look more naturally in the current kernel codebase
> > (as we have tons of DEFINE_FOO().
> > 
> > 	DEFINE_AUTO_KFREE_VAR(name, struct foo);
> 
> Still weird. Much better to have the compiler complain about the
> obvious use of uninitialized.

That would be ideal!

-- 
With Best Regards,
Andy Shevchenko



