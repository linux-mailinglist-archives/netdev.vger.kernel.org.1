Return-Path: <netdev+bounces-156161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1AA05308
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE231886BB9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E90C19ABD4;
	Wed,  8 Jan 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4tABHUM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADD1A239F
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736316254; cv=none; b=NzgQWiex0KmcqJbpYUpuqnaFXO7XCPDcm/vyB5w6Bmq6GL8zPzyw/1MnuhnHvaW4CQ5roIkG0yHELoaZb1TDGt8M44Qx2VFO6p3pldFhZ9eKVpWW1wR4Yf/7jrtwq1dK7zrBAzJa5m/2UWIrv8O4Rs5ID8hHRUNh8ai4tpJq9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736316254; c=relaxed/simple;
	bh=Syb4zXNRjnjUa2FEViaWcch/uizJBOrTAYasrXQXuyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEVZExcY2E+M+OeEtZUqipssPlae7kHM9UDCmuVLn0qp8p7GsjWLiuAe8ucp/lC4KrrQT+7Zd1dsgfwiQZ91j0iokr/vMVFSrMYl8MDS3siv8S+6Hf4gDcJ7D6/OMBc1aES8vuA2exbpIKqWEF2SEefkdXlAUo7Nl0f+Aohkm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4tABHUM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736316252; x=1767852252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Syb4zXNRjnjUa2FEViaWcch/uizJBOrTAYasrXQXuyw=;
  b=J4tABHUM6W3keEDexXxxt9m8hpyP2FqkpWo4x1JBIERXyY7w13+Cb2i/
   ImCEZXwWjFFwlKpo2q6626PDJ2C0B2B4sFjX1MylXpZtm7nkPvwse5t7D
   /5gnfVl1xV2aFUuGfCNwiDVqLttFCslEX/QjhxhjQCvqd9Sohuu4AHdKk
   JUyBqC6Z14OInT350jcHCv2hNbsaNvkyqt2K53EArnuyoHDht2CgRSBdC
   gk3A5tsyv7A6QiCFeRxCgKB19FqgKOWjP6sxzAt5+sVKTPdYO4nECYpQU
   ciaeM0eLFyOn2mUgPJw8zX3V/uGns5vFISmFKF6XaD/ut5nHidXAE0Sdd
   g==;
X-CSE-ConnectionGUID: 7ZUekCQqT66dh/yIg3nwGg==
X-CSE-MsgGUID: iVwpMsajQNu+H0Bv4+pEiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="61904691"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="61904691"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 22:04:10 -0800
X-CSE-ConnectionGUID: GxVoEqoFQK23ZkvbJwfQpA==
X-CSE-MsgGUID: RsKsQ9vpSIa50J6fsCN61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107027506"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 22:04:07 -0800
Date: Wed, 8 Jan 2025 07:00:51 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: John Daley <johndale@cisco.com>
Cc: andrew+netdev@lunn.ch, benve@cisco.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, neescoba@cisco.com,
	netdev@vger.kernel.org, pabeni@redhat.com, satishkh@cisco.com
Subject: Re: [PATCH net-next 2/2] enic: Obtain the Link speed only after the
 link comes up
Message-ID: <Z34UgXz6ota8D27W@mev-dev.igk.intel.com>
References: <Z3zCfiwPl2Xu/Zvi@mev-dev.igk.intel.com>
 <20250107195304.2671-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107195304.2671-1-johndale@cisco.com>

On Tue, Jan 07, 2025 at 11:53:04AM -0800, John Daley wrote:
> >> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> >> index 957efe73e41a..49f6cab01ed5 100644
> >> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> >> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> >> @@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
> >>  static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
> >>  	{0,  0}, /* 0  - 4  Gbps */
> >>  	{0,  3}, /* 4  - 10 Gbps */
> >> -	{3,  6}, /* 10 - 40 Gbps */
> >> +	{3,  6}, /* 10+ Gbps */
> >
> >Is this on purpose? You didn't mention anything about speed range in
> >commit message. Just wondering, patch looks fine, thanks.
> 
> I changed the comment on purpose since it applies to adapters way past
> 40 Gbps nowdays. I should have mentioned the change. Thanks for the
> reveiw.

Reasonable, thanks

> >
> >Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

