Return-Path: <netdev+bounces-198542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF8ADC9D2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B853F1899259
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CA82D9EEA;
	Tue, 17 Jun 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPLrYHYe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59081219E8;
	Tue, 17 Jun 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160836; cv=none; b=umVMtCq2150zOWYSRl+1miyULUqnJPk7+Mdx8oOzNnijw9f8TZIBonFUrvmjwd73EfD6De5Q7SlYFMnrswQuYdkoxgu7flyVLl1GsJQvjgeU1fzGKW0OOTztwyFc+PBlGv/mKEzsC3AZFyFJsWTA3J51x+jKGKlHRPtmd5YBXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160836; c=relaxed/simple;
	bh=D4cWphzFJj/UaQJbAKSv7XhUeS0tG0u2/6A0vfd9Gro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt6yk45PuDs+A2PSutIGjTsoYMYHP0y78r44Pk4qCfNceA0wKWg0dH5rfGaf69P8g8ryoSrQZ6PjSW4ni0dfhcGiHAAc1rwjeSnF00tZ2wpaDC9PDaXGqDFRsjGpVwCiOHDfbCFNasreDjWADDnQkffkOEJ0p0F8ilXF8+hzwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPLrYHYe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750160836; x=1781696836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D4cWphzFJj/UaQJbAKSv7XhUeS0tG0u2/6A0vfd9Gro=;
  b=lPLrYHYeMZyGvVY/rZTNCTeYtKchrZavu7oY/Vv4GJacb8G6qp4PyeMu
   YdcZHQfzfIBInGo8Er1dQoWFFZxYWrVxblrXwmmv+TQhik2fmU/ReQ6nF
   no09sBRN8DriSJDq2EKK39wGBOZcUHNCTpO048LvCVNvdyvO/fjFZAqEb
   8nzSlaIe2La37a7oapNL2Ep9ArmUsJwAo0F664k9ADkBrs3lFHCK5P7r+
   DbVNUu9FNb61RfNN5c/9X5xXdaWPgexKPmSJz8hrpBzQv64QXuRrhcO2D
   JqLo4GVi7WQlNm4dwYwrP0d3cI1nAPJDobXwZ3zzQHedSnpi1Iat/X2hD
   Q==;
X-CSE-ConnectionGUID: QFrFXV2+Smm5cXxI/hy7RA==
X-CSE-MsgGUID: GLBZVfp3SyeFSD/8BdxNgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52038543"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52038543"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 04:47:15 -0700
X-CSE-ConnectionGUID: GqPMbYe5Tn+nRS6rFimovQ==
X-CSE-MsgGUID: 6ia4pwTrRcqCHnUetdW5uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="148612202"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jun 2025 04:47:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5CE1C15B; Tue, 17 Jun 2025 14:47:10 +0300 (EEST)
Date: Tue, 17 Jun 2025 14:47:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-next: gianfar: Use
 device_get_named_child_node_count()
Message-ID: <aFFVvjM4Dho863x2@black.fi.intel.com>
References: <22ded703f447ecda728ec6d03e6ec5e7ae68019f.1750157720.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ded703f447ecda728ec6d03e6ec5e7ae68019f.1750157720.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 17, 2025 at 01:58:26PM +0300, Matti Vaittinen wrote:
> We can avoid open-coding the loop construct which counts firmware child
> nodes with a specific name by using the newly added
> device_get_named_child_node_count().
> 
> The gianfar driver has such open-coded loop. Replace it with the
> device_get_child_node_count_named().

Just a side note: The net-next is assumed to be in the square brackets, so when
you format patch, use something like

	git format-patch --subject-prefix="PATCH, net-next" ...

-- 
With Best Regards,
Andy Shevchenko



