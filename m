Return-Path: <netdev+bounces-239669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA331C6B37B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 224E44E72A2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EF2DAFA9;
	Tue, 18 Nov 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1cyRrxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913AA2DA746;
	Tue, 18 Nov 2025 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490675; cv=none; b=FFbP7/dorqZCGnMBMEuFaUduvM7IkW5jixjg1STj+fa0trFe/2T3hm9zLbi4BuHduvj3ueLcMVsFp/ROSuw900YMqyg3/fGJMqnvLzYiOPGfnVYdQiJtl2iuSEAZV725XutyIyYvDwXMAfloTJ3bt4EhaQabf+9CqJqNihjZUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490675; c=relaxed/simple;
	bh=WHE6fEbSFB+M4z+84cWisGXo1CFTEI0Z2qy8Hupts14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUla7mokaz3hDmFUVSW0QmFCeS69wjqqW0hA2AY7bIdM2J9uEKYPiGfcxqr4plQ50Z7OvP4bLBs5vlPhruNMyQxuMh6ZxQVzLm4NHdcvdONleLZihgl0Hh6HplAfA/Y/EVIzNu0YLogKOvFfCg7+M2Jm4KS3Ug/hIvvPlDqLNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1cyRrxZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490674; x=1795026674;
  h=resent-from:resent-date:resent-message-id:resent-to:date:
   from:to:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=WHE6fEbSFB+M4z+84cWisGXo1CFTEI0Z2qy8Hupts14=;
  b=l1cyRrxZ61MwheN4oU6AIS3yOJ62tdqGYq061QabGjvB/Ud9YLwh8z57
   LyaCV+mZAccNXHzpwzOq0BK1RB+JcQK1HNNYlVA78xaNJeldVmr8J+TuG
   nUEjZ6keuMg6OUZKs5QXdoETtGgTT0b3KtQSe1SZD7bNkETFlyXP4TsH1
   pdgSIyh7EyN3kLrbevNWF1cWnchhiqyi3D4Bw4e3oMHplPyujdyp1KmKh
   Cm1caP9XD+IQCCuy5DQUrh+yD0KYzy4xlNFDrV5QQiOtSFKeu3BAZPY9l
   E+X/AgEZzQR1iOgQBu7eeIzGetNuBuI9Hiy2qpaECKLgyOjSRPA3Luxwz
   w==;
X-CSE-ConnectionGUID: /q9o71FqRS+p4276zjJRgQ==
X-CSE-MsgGUID: 4veCIHmiSAaApCkId4Vl1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69373908"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69373908"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:13 -0800
X-CSE-ConnectionGUID: pTHrSlRPTG2ZUlamUEpGiQ==
X-CSE-MsgGUID: d8aRJePhS4OhK7hiw9dsvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190862538"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:11 -0800
Resent-From: Andy Shevchenko <andriy.shevchenko@intel.com>
Resent-Date: Tue, 18 Nov 2025 20:31:08 +0200
Resent-Message-ID: <aRy7bNwTm9ODIBXM@ashevche-desk.local>
Resent-To: vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, linux-kernel@vger.kernel.org
Date: Wed, 12 Nov 2025 17:04:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 3/7] ptp: ocp: Refactor
 ptp_ocp_i2c_notifier_call()
Message-ID: <aRSh_dNeOPFRjXyD@smile.fi.intel.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
 <20251111165232.1198222-4-andriy.shevchenko@linux.intel.com>
 <7ae9b0c0-c84a-4c2c-b2ee-9252e9c411b0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae9b0c0-c84a-4c2c-b2ee-9252e9c411b0@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 12, 2025 at 01:45:31PM +0000, Vadim Fedorenko wrote:
> On 11/11/2025 16:52, Andy Shevchenko wrote:
> > Refactor ptp_ocp_i2c_notifier_call() to avoid unneeded local variable.

...

> the reason we've done it is to avoid iterating over devices and do
> string comparisons for actions we don't care about. We can still avoid
> local variable by changing if condition later in the code, but I'm not
> sure this refactor gives any benefits.

This is definitely a slow path and having less LoCs and straightforward code
flow is important for readability and maintenance. I find my proposed change
useful.

-- 
With Best Regards,
Andy Shevchenko



