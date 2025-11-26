Return-Path: <netdev+bounces-241815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0242C88B08
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF2E03575C4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECD319847;
	Wed, 26 Nov 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6QFVRs1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D630FC1D;
	Wed, 26 Nov 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146372; cv=none; b=TmH21Xn1pDinlqveRBkiVVWgtIWVWCx62IQMcMkZbSrgqmRyRUSOjy/6GyS0Wtw4oUe1O6sTZBNut3LZR+MRyVBzRAZU+TysiHn9iqFY6YJkZEE0JWw3MNgzEuqgD2oNVyW9yHt0Fpkz6h8G38IDzYdTm5Qx8gTXorUnZA5GCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146372; c=relaxed/simple;
	bh=oyveJ8q/G9dWeEH8sazloAw9I8YtyoEMfWjwG29AkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4ajXccgb3Eg1mBXny/+gZkX0Ne8nyD+g7kIuerN9gPG7yf49IvY+Y3Vvc6Ea0x0nS+uAOi/gqIAARNgNC6SvdfdmmEfXa8upq5/30Xca9F5xlwLWr7Syd6O3mZQrXhYb4Fwi4ZyWzeRboi/tnKipAgxgM6KOVpVNH81tacPYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6QFVRs1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764146370; x=1795682370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oyveJ8q/G9dWeEH8sazloAw9I8YtyoEMfWjwG29AkUs=;
  b=O6QFVRs16HNJ1qkRxUwT+UP8g5FZo2WRsFX5iVkNuNgaOj/kXR2HKrKj
   4lUReWY5DLaUNi2oplKslRx5cHcYkocysGZehCau7rbR4xyhzUMdFA0ke
   Jbqu2NIpXu1jxCJuIpoFsnNoTNZx6JDpKmexbwUzOO7Oqbc1OM3I4ldmN
   DQZk15GbUOqXJz1SXYSica1FxJMHMqAmGlJp66yvm0fyk06bh7/RqXCfe
   IRQKShaM0HojHGhPTlcPhTyMsYzZ4mlE/hNMst/Y7jU9qXa3wqNeHPZ/G
   VzqKl4WIBX4JUp4CyRPTIYoQ6qle23mn8L4vNurOcOAcKXFR00hxpDmd7
   Q==;
X-CSE-ConnectionGUID: 7SJJveX3QFCkOxCNhj7MUw==
X-CSE-MsgGUID: xHsLTyIRR5SGqXLt2fAiow==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66254562"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66254562"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 00:39:30 -0800
X-CSE-ConnectionGUID: nLonSe3hTm2/JSdiBCUflQ==
X-CSE-MsgGUID: l/7kE/pRT2uWPQ2V+gAa0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="193308811"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 00:39:27 -0800
Date: Wed, 26 Nov 2025 10:39:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] idpf: Fix kernel-doc descriptions to avoid
 warnings
Message-ID: <aSa8vXXM6ShdtVvN@smile.fi.intel.com>
References: <20251124174239.941037-1-andriy.shevchenko@linux.intel.com>
 <abf25d3d-30af-479f-9342-9955ec23d92f@intel.com>
 <IA3PR11MB8986A3FDF77D49598C5F4C89E5DEA@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aSayDu8yVe7prrsx@smile.fi.intel.com>
 <IA3PR11MB8986CF43DFB0EFBFDABA34EFE5DEA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986CF43DFB0EFBFDABA34EFE5DEA@IA3PR11MB8986.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 08:06:30AM +0000, Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, November 26, 2025 8:54 AM
> > On Wed, Nov 26, 2025 at 07:24:40AM +0000, Loktionov, Aleksandr wrote:
> > > > -----Original Message-----
> > > > From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > > > Sent: Wednesday, November 26, 2025 7:30 AM On 11/24/25 18:42, Andy
> > > > Shevchenko wrote:

...

> > > > > - * idpf_tx_splitq_has_room - check if enough Tx splitq resources
> > > > > are available
> > > > > + * idpf_txq_has_room - check if enough Tx splitq resources are
> > > > > + available

> > > Strange idpf_tx_splitq_bump_ntu() is not idpf_txq_has_room Can you
> > > doublecheck?
> > 
> > I didn't get. What do you mean? Please elaborate.
> 
> In the kdoc I see function was renamed: idpf_tx_splitq_has_room -> idpf_txq_has_room
> But I don't see idpf_txq_has_room() function name in the patch.
> Only idpf_tx_splitq_build_flow_desc() before and idpf_tx_res_count_required() after.
> Could it be a mistake?

No, it's not a mistake. This is in the category of fixing other kernel doc issues.
Citing the commit message "...and other warnings."

You can run kernel-doc locally and test.

> Everything else looks good for me.

I believe everything including the above looks good.

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



