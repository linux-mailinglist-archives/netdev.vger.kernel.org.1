Return-Path: <netdev+bounces-176197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86848A694BF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5C4462DAE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06821DE4FF;
	Wed, 19 Mar 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3RvGWYs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E61361;
	Wed, 19 Mar 2025 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401381; cv=none; b=C1KwuCC/8IPcie+rbIWjfVuUAcZFuIJ6RRySPQZyDP1L/jlrlttqvB8rl6cCDOhQxhzu0h/q1caL/+q9JpqUixfLfv6laQkrwjWjUE+Y4pLWxdMvmXaE1g+h2lAmex9/QecXNCC8gZv/4wi1gF0L8GaIvq2CAUhghfVGF4LUlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401381; c=relaxed/simple;
	bh=iHIqJYLkK9BQSabqoYL+rnhGusscRAiHOJAuHss1rpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE2CkWMIEPIhkBfuJ7001/TuLNUrrlUksYh79ZwWbFlZuwtuC47ygDpfUqZBo64eluzSd9h4MyDWDo4waoYoYsytT+Sb5ohYh2PiLrOKZGLD8JHSG5x8BJLuYnqUb5nd8SHT1v11ac0rgSBlH1i/o+a1N+UvacfxRA0r1Ju5MzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3RvGWYs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742401380; x=1773937380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iHIqJYLkK9BQSabqoYL+rnhGusscRAiHOJAuHss1rpw=;
  b=Q3RvGWYs5dyEMmbWkEhz7VB+ekngt+pyaXt6lB0ajJnKiNyDFsdQ7DPD
   e8n3JMatyvp00do8n5KzYyAKufuYSWzi7gdwVadQxa5Jj81o1xvY1gGcU
   4Osa9Mln2GryE5OiU7XKNkE/o/VHK657ilJQftQt6xN+KfH70MwuJe7Sj
   QuNbtJPC9JMcn3nRn1lMmcWdIilotLFs+OGuKt1fU2Dh3AjVSO40oT7/b
   tkhkZaCJaeMm2ncbZQ0NbytGg501dEqQjLaLY6gjWav53dJ3lGW0rL3+W
   w7zu7xtDXZfDkcW8arFyCpyjnpgx4K7SB+Woo/HO07TU++saMAyCgnHlb
   g==;
X-CSE-ConnectionGUID: DzaUMRsTS7KizNck39E/wA==
X-CSE-MsgGUID: DSFERfr8ThGUztdES/562g==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43706740"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43706740"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:22:59 -0700
X-CSE-ConnectionGUID: f6Se1N2cSmGnWOKmbjot4g==
X-CSE-MsgGUID: YOUeaOX4RA6fuvBBn2aMTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123174041"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:22:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuwBy-00000003zXS-1rOo;
	Wed, 19 Mar 2025 18:22:54 +0200
Date: Wed, 19 Mar 2025 18:22:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v2 2/2] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9rvXilnPCblbfIv@smile.fi.intel.com>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
 <Z9rYHDL3dNbaK9jZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9rYHDL3dNbaK9jZ@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 02:43:40PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 19, 2025 at 12:54:34PM +0200, Andy Shevchenko wrote:

> > GCC compiler (Debian 14.2.0-17) is not happy about printing
> > into a short buffer (when build with `make W=1`):
> > 
> >  drivers/net/usb/ax88172a.c: In function ‘ax88172a_reset’:
> >  include/linux/phy.h:312:20: error: ‘%s’ directive output may be truncated writing up to 60 bytes into a region of size 20 [-Werror=format-truncation=]
> 
> GCC reckons this can be up to 60 bytes...

It has two complains, but they a bit differ, first one was about %s, as you see
above, the other one which I missed to add here is about %02x:

drivers/net/usb/ax88172a.c:311:9: note: ‘snprintf’ output between 4 and 66 bytes into a destination of size 20

...

> > -	char phy_name[20];
> > +	char phy_name[MII_BUS_ID_SIZE + 3];
> 
> MII_BUS_ID_SIZE is sized to 61, and is what is used in struct
> mii_bus::id. Why there a +3 here, which seems like a random constant to
> make it 64-bit aligned in size. If we have need to increase
> MII_BUS_ID_SIZE in the future, this kind of alignment then goes
> wrong...
> 
> If the intention is to align it to 64-bit then there's surely a better
> and future-proof ways to do that.

Nope, intention is to cover the rest after %s.

...

> I'm also surprised that the +3 randomness wasn't described in the
> commit message.

It was referred in the cover letter and previous discussion, but I agree that
it has to be clarified here, it's ':%02x', the %s case, i.e. MII_BUS_ID_SIZE
covers 60 characters + NUL.

...

> > +	if (ret >= PHY_MAX_ADDR) {
> > +		netdev_err(dev->net, "Invalid PHY ID %x\n", ret);
> 
> An address is not a "PHY ID". "Invalid PHY address %d\n" probably makes
> more sense, but if you want to keep the hex, then it really should be
> %#x or 0x%x to make it clear that e.g. "20" is hex and not decimal.

Sure, I fix it locally, but we need to understand how to go with the
+3/+whatever fix, so format specifier won't hit us back.

...

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



