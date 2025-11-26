Return-Path: <netdev+bounces-241807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E91C88835
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1DF3B29D1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B7028B40E;
	Wed, 26 Nov 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaNf+Nq4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB23595D;
	Wed, 26 Nov 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143637; cv=none; b=GIjX6ClkS0bDcY4LgYYgUTusQy379m0LOIzEFtHYqodMsLFCQi9uwEDk7IdwOQP5ZUHt5c6ozde8Dp0xmTLabtUSHIuINy8iSx5mR236CRc5zM3QKg9106XFqdoZOX41pm8MmlvhM6grgMd6q9A4Jshmp2q/YX1uFzo7sN2IYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143637; c=relaxed/simple;
	bh=PrFs4bYCzBU2Z3ZyP+JdWwbV9Tc/Os8OwQQbN3NgVRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwNuQ9vnKIkxy6RWmFtzWU/rqSVApmd005W8+4fG+ecKY+bvjsOlbK9YT1MTG68B9GSg1PBnWurjoNRN43MV4AWuQ6PKvkzguqMZiQ+pIp/T86CfPv2HQWRNkQ1GtLm5DJFMmN7hAc/QT7rdVkE7oqINGbQ/oBRshXC2bGAY5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaNf+Nq4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143635; x=1795679635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrFs4bYCzBU2Z3ZyP+JdWwbV9Tc/Os8OwQQbN3NgVRU=;
  b=PaNf+Nq47/L/vyIhRslpMfTLvsPfNz3llups7JHnmDQN+5BrzGv9wzIx
   azOYwWEwuSn1t0Njw4kw/hYUkxy0GiJluPRc+GeidnMGQSuZissYAGBrx
   epMqKeKvGy/hVspTpUntyvk4534GjAk87KyTrphY0RgrIjVXsvuatjdjS
   gANuolZK4+DFMoblT4+nzYX0SPuuH7NCkEhsi0TABW3fLB+eKAuhtDeSs
   Cv5DJHXpFClxwyoyB/nXsc1D4E2qSEkT91kJVfy7/3psOjzk4AeYEdNhl
   ICutHZ62dnvJjHpJ5N5NcvofrId35Cf5sswru5KpJdca8aGYqLtIofVvK
   Q==;
X-CSE-ConnectionGUID: KuT9yGriS7eFmVuDnMBTVw==
X-CSE-MsgGUID: GaR3Dp7BQz2U8eROoWnwMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="88820040"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="88820040"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:53:54 -0800
X-CSE-ConnectionGUID: HtZ0x8w5R+6KwfJPN61S2Q==
X-CSE-MsgGUID: B8jRA5QFTam0U2VHHNLg4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192764270"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:53:52 -0800
Date: Wed, 26 Nov 2025 09:53:50 +0200
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
Message-ID: <aSayDu8yVe7prrsx@smile.fi.intel.com>
References: <20251124174239.941037-1-andriy.shevchenko@linux.intel.com>
 <abf25d3d-30af-479f-9342-9955ec23d92f@intel.com>
 <IA3PR11MB8986A3FDF77D49598C5F4C89E5DEA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986A3FDF77D49598C5F4C89E5DEA@IA3PR11MB8986.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 07:24:40AM +0000, Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Sent: Wednesday, November 26, 2025 7:30 AM
> > On 11/24/25 18:42, Andy Shevchenko wrote:

...

> > >   /**
> > > - * idpf_tx_splitq_has_room - check if enough Tx splitq resources are
> > > available
> > > + * idpf_txq_has_room - check if enough Tx splitq resources are
> > > + available
> > >    * @tx_q: the queue to be checked
> > >    * @descs_needed: number of descriptors required for this packet
> > >    * @bufs_needed: number of Tx buffers required for this packet @@

> > > unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,

> > >    * idpf_tx_splitq_bump_ntu - adjust NTU and generation
> > >    * @txq: the tx ring to wrap
> > >    * @ntu: ring index to bump
> > > + *
> > > + * Return: the next ring index hopping to 0 when wraps around
> > >    */
> > >   static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq, u16 ntu)
> Strange idpf_tx_splitq_bump_ntu() is not idpf_txq_has_room 
> Can you doublecheck?

I didn't get. What do you mean? Please elaborate.

-- 
With Best Regards,
Andy Shevchenko



