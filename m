Return-Path: <netdev+bounces-96008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B019B8C3FA6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386791F21AF6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270014D281;
	Mon, 13 May 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXIz1x4z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD4114C591;
	Mon, 13 May 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599141; cv=none; b=thsBUszX8D02joM94qRGZSS7s1t47PaGqBIbh6pYeagCDmx1He1QrrVXBIZ5Zb0BthgcSHfN4l5u1ZFF0V/LUOImZO7lgW1zQGDQIlRw92bvPhnm3+eyI1SWSqsyzuy5PSvBIeHLC2t2r3s27C8Gy+FUWKf2EI/GiqBAnFa0MPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599141; c=relaxed/simple;
	bh=Hq107+KzbP8LLfL/8/jiKEoxV4uQvEu20/9t6yULhgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpFssj9aaXuKAnHi16PV8OtPHf6FM/lD90jaui4Ywc+Z0WFXK9SkUq54Ca/ruwgjLX1hovdri9oMC242/tLJq7CN6uk5c4l1aRy8wSoyCcG7BwEAfrcu+4bqJYhI0b+c4+Hz/8B8dm8VaMhttWB6rdKbgDtyZSD5qoxA35pit+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXIz1x4z; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715599139; x=1747135139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hq107+KzbP8LLfL/8/jiKEoxV4uQvEu20/9t6yULhgY=;
  b=VXIz1x4zN7CGf108Oit/tDx6Ijfe5sFzd+w61hHKxRIV4S6fP0+YD+Sk
   znr7WG2l1a9pZ2Ptr7AG+sOBXXvKvkVo29EKqxbU1QU5ktATAP0LTx5G+
   Us+1fFuIfi6n0UBfQL+trogIwFfeyGfm5D+osC78wO9b4sE8N7GExDWJK
   pQpAhfFnQQWF12EQiAPszWXoTBdgVtUyU65UP1RjAlZhdEySEwC9LE7nT
   E/T9pb0mpRx1fjQUJUgyRw5HWFD+PDjNDEi/WQCRDsPzI6pteDLmZEwKO
   q/05b6cKB28/mc3zbJqdmnZaFMjSs5PNpRVu9xKK8cKomEsnlf906pd/1
   w==;
X-CSE-ConnectionGUID: yrb9+5eXTO66xLQJviy6qw==
X-CSE-MsgGUID: kBlGDfLdTtOA7uI8/s1QbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11349939"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11349939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:18:58 -0700
X-CSE-ConnectionGUID: Em0EdL3kS+ebItk6iQqS3Q==
X-CSE-MsgGUID: 2h063URmRbasVo6zRP4CkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61123834"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 04:18:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6Thh-000000076l1-1gxQ;
	Mon, 13 May 2024 14:18:49 +0300
Date: Mon, 13 May 2024 14:18:48 +0300
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
Subject: Re: [PATCH v8 10/12] pps: generators: Add PPS Generator TIO Driver
Message-ID: <ZkH3GP2b9WTz9W3W@smile.fi.intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-11-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513103813.5666-11-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 13, 2024 at 04:08:11PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> The Intel Timed IO PPS generator driver outputs a PPS signal using
> dedicated hardware that is more accurate than software actuated PPS.
> The Timed IO hardware generates output events using the ART timer.
> The ART timer period varies based on platform type, but is less than 100
> nanoseconds for all current platforms. Timed IO output accuracy is
> within 1 ART period.
> 
> PPS output is enabled by writing '1' the 'enable' sysfs attribute. The
> driver uses hrtimers to schedule a wake-up 10 ms before each event
> (edge) target time. At wakeup, the driver converts the target time in
> terms of CLOCK_REALTIME to ART trigger time and writes this to the Timed
> IO hardware. The Timed IO hardware generates an event precisely at the
> requested system time without software involvement.

...

> +static ssize_t enable_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			    size_t count)
> +{
> +	struct pps_tio *tio = dev_get_drvdata(dev);
> +	bool enable;
> +	int err;

(1)

> +	err = kstrtobool(buf, &enable);
> +	if (err)
> +		return err;
> +
> +	guard(spinlock_irqsave)(&tio->lock);
> +	if (enable && !tio->enabled) {

> +		if (!timekeeping_clocksource_has_base(CSID_X86_ART)) {
> +			dev_err(tio->dev, "PPS cannot be started as clock is not related to ART");

Why not simply dev_err(dev, ...)?

> +			return -EPERM;
> +		}

I'm wondering if we can move this check to (1) above.
Because currently it's a good question if we are able to stop PPS which was run
by somebody else without this check done.

I.o.w. this sounds too weird to me and reading the code doesn't give any hint
if it's even possible. And if it is, are we supposed to touch that since it was
definitely *not* us who ran it.

> +		pps_tio_direction_output(tio);
> +		hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);
> +		tio->enabled = true;
> +	} else if (!enable && tio->enabled) {
> +		hrtimer_cancel(&tio->timer);
> +		pps_tio_disable(tio);
> +		tio->enabled = false;
> +	}
> +	return count;
> +}

...

> +static int pps_tio_probe(struct platform_device *pdev)
> +{

	struct device *dev = &pdev->dev;

> +	struct pps_tio *tio;
> +
> +	if (!(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ) &&
> +	      cpu_feature_enabled(X86_FEATURE_ART))) {
> +		dev_warn(&pdev->dev, "TSC/ART is not enabled");

		dev_warn(dev, "TSC/ART is not enabled");

> +		return -ENODEV;
> +	}
> +
> +	tio = devm_kzalloc(&pdev->dev, sizeof(*tio), GFP_KERNEL);

	tio = devm_kzalloc(dev, sizeof(*tio), GFP_KERNEL);


> +	if (!tio)
> +		return -ENOMEM;
> +
> +	tio->dev = &pdev->dev;

	tio->dev = dev;

> +	tio->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tio->base))
> +		return PTR_ERR(tio->base);

> +	pps_tio_disable(tio);

This...

> +	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
> +	tio->timer.function = hrtimer_callback;
> +	spin_lock_init(&tio->lock);

> +	tio->enabled = false;

...and this should go together, which makes me look at the enabled flag over
the code and it seems there are a few places where you missed to sync it with
the reality.

I would think of something like this:

	pps_tio_direction_output() ==> true
	pps_tio_disable(tio) ==> false

where "==> X" means assignment of enabled flag.

And perhaps this:

	tio->enabled = pps_generate_next_pulse(tio, expires + SAFE_TIME_NS);
	if (!tio->enabled)
		...

But the above is just thinking out loudly, you may find the better approach(es).

> +	platform_set_drvdata(pdev, tio);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



