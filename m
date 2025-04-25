Return-Path: <netdev+bounces-185838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF2A9BD8E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D406A3A7019
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DC8140E30;
	Fri, 25 Apr 2025 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVBozJmW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B026AC3
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 04:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555331; cv=none; b=eLSM+dX5NTor0Gq7cAd4X8FWHnQP70Pb6MzKf1CkHVqoiwN6G2X2Ns4ARwy76/2LU5u/sO0f7tDh2SyAZIW2aTUc0OFT+SL70pBbStEnoM9oQ8NEbYquyBAddYrDIejlhB/VncEbeaOeNiDJQvNRTUNa0Im27xi5NnY2zDXGqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555331; c=relaxed/simple;
	bh=mUwKmpSiftDQFWb84758vCTbsmaHpPDT/l2BtxaPHOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZgsdOKkKYtjGpB8NxXWnGOz57RlirA3gXgcMIt/fE6fFJhWQHXnvlQVayVdcC7XV/Cm5aXusA1spGnja0fgqAbXcIyNVTFGAM0Wek4NurW4zz2t9Usx+DfPWq7yNDRw8gbSeyRjWfh6JtscqqWtNOUnIVhoaTU6DRyIS5GNc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVBozJmW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745555330; x=1777091330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mUwKmpSiftDQFWb84758vCTbsmaHpPDT/l2BtxaPHOg=;
  b=YVBozJmWSdJCo+OQpYAX5qai9zSp+wz6Xur7DWSsxmU6zlpmTItg2DeX
   jNX+PBlFohesfr48NlTciSdsmQaC2QJKRm5tBE/xT0ZnGpNj3UvHZUZk0
   Q0HrxFiPkr2NKek6+Flcxd5I6W0uwZ1m8IjQLrG2z6yMGovRHWkVL/vk7
   12sJIg1hexvv8drzLzMcEZ/OfMkcqA24qzTsO6n44O3DibgTjyuKKoZ1J
   ndXOJ1eYaQueQLuTN3y/yFrP15DhzeKZgWzE6r6z+b6e6B/l6V0DrgQgz
   eTto3zUfEUwglThXWveEJwyZhtYpQ776EN442R4ANkAGnK7YzMRuDIVKF
   A==;
X-CSE-ConnectionGUID: VSfJIh2rSm2wrwKAt8d7ig==
X-CSE-MsgGUID: k6X37O0DRU2aHVjpkB8ObQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47082752"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47082752"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 21:28:49 -0700
X-CSE-ConnectionGUID: dslbe/EER86DCVEyRxP2tA==
X-CSE-MsgGUID: RAwXs4lSTYm05Q/7sOH+Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137799898"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 21:28:46 -0700
Date: Fri, 25 Apr 2025 06:28:26 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	marcin.szycik@intel.com
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <aAsPamW5qmCp+O3e@mev-dev.igk.intel.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
 <20250418003259.48017-3-kuniyu@amazon.com>
 <20250422194757.67ba67d6@kernel.org>
 <aAimsamTlQOq3/aD@mev-dev.igk.intel.com>
 <20250423063350.49025e5e@kernel.org>
 <aAnAxEXgyyhfgHWw@mev-dev.igk.intel.com>
 <20250424152638.5915c020@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152638.5915c020@kernel.org>

On Thu, Apr 24, 2025 at 03:26:38PM -0700, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 06:40:36 +0200 Michal Swiatkowski wrote:
> > > > Uh, I remember that we used it to add tc filter. Maybe we can fix it?  
> > > 
> > > If it really was broken for over a year and nobody noticed -
> > > my preference would be to delete it. I don't think you need
> > > an actual tunnel dev to add TC filters?  
> > 
> > Our approach was to follow scheme from exsisting ones.
> > For example, vxlan filter:
> > tc filter add dev vxlan ingress protocol ip ...
> > PFCP filter:
> > tc filter add dev pfcp ingress protocol ip ...
> > 
> > so in this case we need sth to point and pass the information that this
> > tunnel is PFCP. If you have an idea how to do it without actual tunnel
> > we are willing to implement it. AFAIR simple matching on specific port
> > number isn't good solution as tunnel specific fields can't be passed in
> > such scenario.
> 
> You're right, not sure what I was thinking.. probably about 
> the offloaded flow.
> 
> Could you please fix this and provide a selftests for offloaded 
> and non-offloaded operation? To make sure this code is exercised?

Sure, I will do that. I am going for a two week vacation from today, so it
can take some time for v1.

Thanks

