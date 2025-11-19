Return-Path: <netdev+bounces-240070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E39C70142
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DAE84FBF12
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F235BDAB;
	Wed, 19 Nov 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgblkGQo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA430F938;
	Wed, 19 Nov 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569076; cv=none; b=iShCXZIyWUJ+jtiOSh+S/uyO/NCdztY8AcQLrNNIX5gKanZN206WEHxVdjtsZgKiqba/YwL85qrQcsnvweOkeYDJgCUVqhVaNHrwlwPqBbbG18VgLmoTqArqCEyJMO0hoZ6IfX3HZppLFG2uoQ/niDEJXyy3/BFazphx+cu0rzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569076; c=relaxed/simple;
	bh=KZojjTAuT7Jo/IAEhOuOTd7OhdZ6sgudnBZtwsb7/Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzhIFu2WyxZSHa4ogdpQxzXhdsEUffAe6HARERarGtoTFrwr1ITGpFAcYHBuVm/BiR5of121WViwjGILfJ6awzFnMN1RlIkbbWJOoMByvdxlreCbNq6JhgyWWa3WRVocp1rS7AI4lRtm1aW4s6VTON68bxf625yqOoWKIRbAqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgblkGQo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763569074; x=1795105074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZojjTAuT7Jo/IAEhOuOTd7OhdZ6sgudnBZtwsb7/Po=;
  b=LgblkGQo1CDnRg2hL9shlL9wy2ZNQB+L7yet5DEaOS7fduS8fTndSdVz
   pXz7fpMPLPvvhtpP7dG7Q4Ecbz3XYrnREG7NlYvlvQAGEEuDFsqiyTTTE
   sdutX8X812XHDdYOB5iy6/LhO+uU+7Tm20ykEYZy5WZt3gM9Te/ssE6po
   ZZ56TTYt9ukS00h08AuhN82oQSMtp1bP0eopJAdLNVbRC4ADohyovcoNp
   r96Sk9v3ACrALBDspLGjiAttimMByxC/veBdk6z2XCl93k9jhFmgev3GD
   cXXBVi/F1Klh+QWTAOIsWCYUhKtBhV5sZqWYC7v1yAqeCFjKxwFeZdDEx
   A==;
X-CSE-ConnectionGUID: kGTKlBSmR8a+MuWPkwervQ==
X-CSE-MsgGUID: /9BSKdIgS9+sCcDqsm1/vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64812777"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64812777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 08:17:53 -0800
X-CSE-ConnectionGUID: yad8mbXFQV+zDTAHMNdg0Q==
X-CSE-MsgGUID: /+VV7mzjSI6pL4Pac6nzlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="222025487"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 08:17:50 -0800
Date: Wed, 19 Nov 2025 18:17:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <aR3trBo3xqZ0sDyr@smile.fi.intel.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
 <20251119095942.bu64kg6whi4gtnwe@skbuf>
 <aR2cf91qdcKMy5PB@smile.fi.intel.com>
 <20251119112522.dcfrh6x6msnw4cmi@skbuf>
 <20251119081112.3bcaf923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119081112.3bcaf923@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 08:11:12AM -0800, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 13:25:22 +0200 Vladimir Oltean wrote:
> > I think it's due to the fact that the "contest" checks are fundamentally
> > so slow, that they can't be run on individual patch sets, and are run on
> > batches of patch sets merged into a single branch (of which there seem
> > to be 8 per day).
> 
> Correct, looking at the logs AFAICT coccicheck takes 25min on a
> relatively beefy machine, and we only run it on path that were actually
> modified by pending changes. We get 100+ patches a day, and 40+ series,
> and coccicheck fails relatively rarely. So on the NIPA side it's not
> worth it.
> 
> But, we can certainly integrate it into ingest_mdir.
> 
> FTR make htmldocs and of course selftests are also not executed by
> ingest_mdir.

Btw, do you do `make W=1` while having CONFIG_WERROR=y?
And if so, do you also compile with clang?

Sorry if it's documented / answered already, please point me to that discussion
/ documentation.

-- 
With Best Regards,
Andy Shevchenko



