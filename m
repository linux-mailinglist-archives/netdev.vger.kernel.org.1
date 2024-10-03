Return-Path: <netdev+bounces-131597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7D98EF85
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F928214B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3830186E40;
	Thu,  3 Oct 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJyRPNKj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C81865EB;
	Thu,  3 Oct 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959474; cv=none; b=MqHNEQkSYQ3/hFa+Cx0SZCi9c8hmQjoolZINsXZnfurcZFR0lHERIo5HL5pWBYi9ger9n185nup4Bj7TS00y3X2QXwMC6WY3ZINlvu/nWVoq/EaKbomJgcPBpd+XzgDIsPv+6cHTZKogdmttRTyF77Uw/zKGuJ6qGgPDZbw5c9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959474; c=relaxed/simple;
	bh=hHTa+rAtpAcTiJMT8p5Ir1owNRAx0NVTTC2N/UvQ84w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2I8dnRG3KezvGYnBd+ZYuMtzPw2oQvsLMhUYJg7EpBXFpDGRAeKjt9Hu98+GOZ2GeeCLy6n97+2FRlK4W6Z9ZIFBXgnpodRxAVKYhpPSP7EAvz0gBBHm/r42pzIAizFpJ7QZPv048jJIC1PyW08t3u31hRt8tmnJbe/w9MzlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJyRPNKj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727959473; x=1759495473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hHTa+rAtpAcTiJMT8p5Ir1owNRAx0NVTTC2N/UvQ84w=;
  b=UJyRPNKjTN6FaGoDdpT78Q1GN5+2DPJ8fwiFWqc6UrE8IW/sWZII0Myy
   lebryQaRB2CB8NYVhZ1ve/w+83wFnpu7WVKporeG3P5QEpFnN5HBKwKN+
   3w5HImzjFhSl1n6H2GAVNxXsA5SITqG2sb9gXvGdhvLFYrBGt440C8DZA
   AfcO1xnIie3hL6GNUeCxOTDj4tfzp7fZ0w2/sbcdQW7UfNCQrC7JcuFxG
   SdTQMy57vA6qwKvmk8/X54ucoRG7LDayxCGvKfujSpcy/fhXOjMZBytiE
   Z2OQdOcDJgdU0wBJ7nVa4RZhfhouhoWgBrNgBvykEdD7STTWgL7cPlxC5
   w==;
X-CSE-ConnectionGUID: /DV/iRS6S9ehfgOcemb3+Q==
X-CSE-MsgGUID: 5+BT3gW6QxGW/5LVH0i/gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30942401"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="30942401"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:44:32 -0700
X-CSE-ConnectionGUID: Q5AXRh74TPe3cU+bbYtg6g==
X-CSE-MsgGUID: 7z03l8egQGuAXjBaMdi1/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74589434"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:44:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1swLBy-0000000G92y-0g4l;
	Thu, 03 Oct 2024 15:44:26 +0300
Date: Thu, 3 Oct 2024 15:44:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
Message-ID: <Zv6RqeKBaeqEWcGO@smile.fi.intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <63de96f1-bd25-4433-bb7b-80021429af99@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63de96f1-bd25-4433-bb7b-80021429af99@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 03, 2024 at 02:34:57PM +0200, Markus Elfring wrote:

…

> >  "__" prefix added to internal macros;

…

> Would you get into the mood to reconsider the usage of leading underscores
> any more for selected identifiers?
> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier

The mentioned URL doesn't cover the special cases like the kernels of the
operating systems or other quite low level code.

-- 
With Best Regards,
Andy Shevchenko



