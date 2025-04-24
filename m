Return-Path: <netdev+bounces-185396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D434DA9A02C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 06:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2456844556F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961AC1B4159;
	Thu, 24 Apr 2025 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQNR1Ui/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA091B0420
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469663; cv=none; b=ntCak0R6KpcBZmAZ16PIA7WtpRRJnbUj1K+XwnsLGiF3eHH5a8UHLNoMWoRHmL5yv68+W4btXI9aJZ69nIweI0czii1l0+N2Bwr+0cnmdiUnTOZb7DCMVbCefS2ui4q1vhUqXX4YgNL9+Cy3L2wGbGI1mBZqwd88DIWAA8JJ37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469663; c=relaxed/simple;
	bh=7jCcNvEZo6U7UBGAeCE1vti5ixzAX9WirqfOyR0loG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZo5VLMM2tN/yoE8OXpSjLoPV+yz7Z3kbCqB6puimEo1Eg5rQSTLwLCUMDbk+xaryxCqmrRXc6RuTCwaxJDrZtVxp1z+Q4LfFNYnVKjdlB8bQrwLdXfrnyWl/VXuH6lkGCEtvkOH2TTFqS5StDS+J70wQTkDDhGMve4vc+gL+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQNR1Ui/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745469662; x=1777005662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7jCcNvEZo6U7UBGAeCE1vti5ixzAX9WirqfOyR0loG8=;
  b=jQNR1Ui/4rrCPyPU0sMF/PyfcIMmtkhUDfGraKfOT9dWMQcYcVIqpiB8
   SN5CZOqbm0YTGkVMJ+v1WhZaTdurshtkuv6JirxePp8s+m71B2F7XOc6Z
   rvWfPU/uJgTLDafTrpjEck3cbrNQqAZ+hMzUAgWsO3fDaNRVF5PCU5YZb
   OlZl3bbPlhaF83kHZjQ8RHIdOLmMIzbNwBdVjDP6ny1K+ehrLC3TkLhm8
   y5wWZfMq5vojb8E62d9vRzAHqtDJ0gV1ry9Mf43mn7qLAIF4U6Df0x5tp
   Mn6EyQ1LvFhpwRTa8LuQ6s3UJr17kxOQBkDJ+xiTwi13x/x4HOjMmsdWt
   A==;
X-CSE-ConnectionGUID: 2pN0wMidR3ChT0WGatIQpg==
X-CSE-MsgGUID: Ovh82eDWROKOqb7npum3DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46203754"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46203754"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:41:01 -0700
X-CSE-ConnectionGUID: LF78ESVIQCyjRkOfxkZpyA==
X-CSE-MsgGUID: MmkbuvrIQ3+puRbkoQrSlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133030730"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:40:58 -0700
Date: Thu, 24 Apr 2025 06:40:36 +0200
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
Message-ID: <aAnAxEXgyyhfgHWw@mev-dev.igk.intel.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
 <20250418003259.48017-3-kuniyu@amazon.com>
 <20250422194757.67ba67d6@kernel.org>
 <aAimsamTlQOq3/aD@mev-dev.igk.intel.com>
 <20250423063350.49025e5e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423063350.49025e5e@kernel.org>

On Wed, Apr 23, 2025 at 06:33:50AM -0700, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 10:37:05 +0200 Michal Swiatkowski wrote:
> > On Tue, Apr 22, 2025 at 07:47:57PM -0700, Jakub Kicinski wrote:
> > > On Thu, 17 Apr 2025 17:32:33 -0700 Kuniyuki Iwashima wrote:  
> > > >  drivers/net/pfcp.c | 23 +++++++----------------  
> > > 
> > > Wojciech, Michał, does anyone use this driver?
> > > It seems that it hooks dev_get_tstats64 as ndo_get_stats64 
> > > but it never allocates tstats, so any ifconfig / ip link
> > > run after the device is create immediately crashes the kernel.
> > > I don't see any tstats in this driver history or UDP tunnel
> > > code so I'm moderately confused as how this worked / when
> > > it broke.
> > > 
> > > If I'm not missing anything and indeed this driver was always
> > > broken we should just delete it ?  
> > 
> > Uh, I remember that we used it to add tc filter. Maybe we can fix it?
> 
> If it really was broken for over a year and nobody noticed -
> my preference would be to delete it. I don't think you need
> an actual tunnel dev to add TC filters?

Our approach was to follow scheme from exsisting ones.
For example, vxlan filter:
tc filter add dev vxlan ingress protocol ip ...
PFCP filter:
tc filter add dev pfcp ingress protocol ip ...

so in this case we need sth to point and pass the information that this
tunnel is PFCP. If you have an idea how to do it without actual tunnel
we are willing to implement it. AFAIR simple matching on specific port
number isn't good solution as tunnel specific fields can't be passed in
such scenario.

Thanks


