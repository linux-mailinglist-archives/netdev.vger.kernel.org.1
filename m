Return-Path: <netdev+bounces-96012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECBD8C3FBF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01861C216B9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388714C595;
	Mon, 13 May 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdqWtABd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02296146A8B;
	Mon, 13 May 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599353; cv=none; b=lWNSe4VhKp4itwhZJGQAJiImoz+QLURdc7v5zeiZ/wwm7Agfjg+78KzU1CE0OUEi99z8f/tzneKs03+WHoHqlzV64poC/LNJZANcOqdbPE2P/ST/pt95/4WKiEwSMcsTVXOiCVImGhuXSVphEhwAfCI+zhSUOcVJQo6H9p7Q2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599353; c=relaxed/simple;
	bh=/hr2bOpRFgqi9fvGXlP0M2gVxTzgKVlXnL3zKDV3ZG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZKN4xpUA1scBTA0kiTgx3RsH8emFxtXH4NZ9eybZG+jF7fTd/OIZLtu055MQvE0tWahW23WKP985nhUbTXm1GRUMdoTakXbWpqKvuawkZAoVvSYHg6O/ToOvW672ijmBXnyKretDUB606iG3xtgNZVs/UdD2A4L3AiCNhnk+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdqWtABd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715599352; x=1747135352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/hr2bOpRFgqi9fvGXlP0M2gVxTzgKVlXnL3zKDV3ZG4=;
  b=FdqWtABdOrz4htu8eEOe9Lo1CfofH1QTdchMGWqgloNY5j+/Gb9lG9qd
   nY2xvFT1QlmAX1vBgdkjY+ThiTZTqTurZYZ6WnEX5nXHS3F8rOCh9A0hj
   TfM2cKqOKIM0vCA5xiEQjoHp8va+Qu9Mhh6VY83LrCyd+IXBn5FLDWxDN
   ngUqrv23YnpGAzBKUK1pCWYs46HKOzHwTVtSQaSiyMt3uEhzPXc09Vo2k
   Rz/Xs76kgd3UMGLaju4gaYolsJ8+adDYVi+60Bx7P/8kFsW3npjAjpxS2
   E4Pi5nf3krv2Z60PRDLGPuNlaulCOtGHfQxYT7NoURtT4dWSxLy1DceGa
   Q==;
X-CSE-ConnectionGUID: xABn3XmfT4qkB5V3N6YLzw==
X-CSE-MsgGUID: XtB/xx0ETKKYwvfEj3XgJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22676147"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22676147"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:22:31 -0700
X-CSE-ConnectionGUID: 8npUnQQuTcWgTKsh91B/bw==
X-CSE-MsgGUID: DXVFtzbcRkqhUIKafUb5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30866900"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:22:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6Tl8-000000076qh-0yhd;
	Mon, 13 May 2024 14:22:22 +0300
Date: Mon, 13 May 2024 14:22:21 +0300
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
Subject: Re: [PATCH v8 12/12] ABI: pps: Add ABI documentation for Intel TIO
Message-ID: <ZkH37Sc9LU4zmcGB@smile.fi.intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-13-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513103813.5666-13-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 13, 2024 at 04:08:13PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver.

...

> +Date:		June 2024

Is this checked by phb?

"the v6.11 kernel predictions: merge window closes on Sunday, 2024-08-04 and
 release on Sunday, 2024-09-29"

> +KernelVersion:	6.11

-- 
With Best Regards,
Andy Shevchenko



