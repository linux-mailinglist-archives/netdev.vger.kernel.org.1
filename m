Return-Path: <netdev+bounces-252856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBWQOViGc2krxAAAu9opvQ
	(envelope-from <netdev+bounces-252856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:31:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE777190
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E9D300598D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695092D838C;
	Fri, 23 Jan 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9vQ0AC3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4EC31281B;
	Fri, 23 Jan 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178707; cv=none; b=YZB9+UI0kcG0fkdYLdWGVYAxT3LdzyQQPdxG1yZCxbZBsOvj/GrVe+9H07HIPgKatVZ+t0pJcrLVqT3fsTqP59qiCYJih+2D36X8VtTgPHKrr3EpLqUKwlAayU+URikQfwULKHOVxi36qxIaPWCQFm+PwRMK6tbsFJGkqWKAFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178707; c=relaxed/simple;
	bh=isCnd4QlNaYJeFXZJPH6Zy8is0mOx160GX4nVSmSfBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7dX8gnvGw8SaHFaBMSSTM7pepA0rcGyv6b6Bw2ortAn3Ep8Tj/BSO7ZgtEe9gf9wCAyOIP79o0hLj5QQv3DDGw+I+NZXT0UmmWgj3uQ+d1LVJA24g3iSth173Zle27c+BTsbmmwFOSDEQIx8J01zTTgwv1tpSLj5pPxlCXv0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9vQ0AC3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769178703; x=1800714703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=isCnd4QlNaYJeFXZJPH6Zy8is0mOx160GX4nVSmSfBY=;
  b=E9vQ0AC3mlpXtGQhrGIifa9do5wXymeTfflQXKPC3u3h+YKSMrg5kDkQ
   9Lrr1XdJBCRA6um1+OEY+JpSe7fE/7vUS+BozZ9cLNPBbibkvU3ipyKOG
   oC0jdh8YT61ubE5RGxlOVhALB0yrjOTzm8LCCnd+KpVLBuvmNHzUDqSVE
   Ru4Px3uxQP3rXNlQ+m6xLWHl5Kjk+n0x/szn+S0XZqfKZLecFaxQftdOe
   Ydai4NcmyyYUOTVxbCKvERSz4H4UQ1Rcvm1QlP+fwXch3KKk7gxi/snhU
   x196q5iXZm8+4m2r0RRd7ood2Z0LDed4l9CqQvmSDJwLtNQEtvon1YTEM
   w==;
X-CSE-ConnectionGUID: 2tgIXc2jSj6VVGQWvtHXbg==
X-CSE-MsgGUID: 7akBVfOfTM+ZhaBo8bHv3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="87849902"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="87849902"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:31:33 -0800
X-CSE-ConnectionGUID: d3Ml0qkzRNKhmGuNEieM8w==
X-CSE-MsgGUID: 8jlkQLQdR6mqAUWLLOJo7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="237690920"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:31:28 -0800
Date: Fri, 23 Jan 2026 16:31:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <aXOGPUP5pfGeAQKN@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
 <20260122221848.py4p7mwxzybicnsq@skbuf>
 <aXMhWo0NpPK-BELG@smile.fi.intel.com>
 <20260123121529.inik6xrfdianljq6@skbuf>
 <20260123135501.7m5wqkcfluxqeowb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123135501.7m5wqkcfluxqeowb@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252856-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 8BDE777190
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 03:55:01PM +0200, Vladimir Oltean wrote:
> On Fri, Jan 23, 2026 at 02:15:29PM +0200, Vladimir Oltean wrote:

...

> A data structure which I find a bit under-utilized in the kernel is
> 
> /**
>  * struct regmap_range - A register range, used for access related checks
>  *                       (readable/writeable/volatile/precious checks)
>  *
>  * @range_min: address of first register
>  * @range_max: address of last register
>  */
> struct regmap_range {
> 	unsigned int range_min;
> 	unsigned int range_max;
> };

Not sure. See below.

> I could imagine a helper like:
> 
> /* Type adaptation between phy_addr_t and unsigned int */
> static inline int __must_check regmap_range_from_resource(const struct resource *res,
> 							  struct regmap_range *range)
> {
> 	struct resource r4g = DEFINE_RES(0, SZ_4G, res->flags);
> 
> 	if (res->flags != IORESOURCE_REG) {
> 		pr_err("%s should be used only with IORESOURCE_REG resources\n");
> 		return -EINVAL;
> 	}
> 
> 	if (!resource_contains(&r4g, res)) {
> 		pr_err("Resource exceeds regmap API addressing possibilities\n");

%pR

> 		return -EINVAL;
> 	}
> 
> 	range->range_min = res->start;
> 	range->range_max = res->end;
> 
> 	return 0;
> }
> 
> and then proceed to use the simpler and validated regmap_range structure in the driver.
> Too bad such use is not an established coding pattern...

Dunno about semantics, as I only saw the use of that in regard to the special
slices of regmap.

Also we have struct range in range.h. Maybe that one suits better? It has also
some interesting APIs.

-- 
With Best Regards,
Andy Shevchenko



