Return-Path: <netdev+bounces-183636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B565A915AE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E524019E1743
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1E1DE3BA;
	Thu, 17 Apr 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKRz7xQw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAC21C9F8
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876130; cv=none; b=usNpgF3D6O4IF40DKw30uOyFqCHvk9XL/rKJazLMi2Y8EUID41sHFOrLJ/2IRTIdhtp1WYxenJO9zW1hEiUvbsD1f1caVLQM3OkXd37935JAYpkrfPB7xN7WfhtHTUEWkWKxdM9VWo1pe9fgxYVYaXmIcHuLua5zDktGA8l6MAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876130; c=relaxed/simple;
	bh=AJDZ7g9e7QmBIngwpIsFAzOeQfTEjm5Sb3aXttAvypM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIuQAjtUOb9s8J2Ba1aG0NFv0+1MaMqhrdi4RxnFyXGej4YyxkcYy/Qwbr3nC17Ul4BFtSsQnHyuNTShdYQI1EvUNzWVfZV+ifhTRYl/izxJFgtGd/Pfn06dRxD4g0KD4l4YQBLUhzd+kfukVmqjfQ9Z8He7+uijBgXqQQf+Smc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKRz7xQw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744876129; x=1776412129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AJDZ7g9e7QmBIngwpIsFAzOeQfTEjm5Sb3aXttAvypM=;
  b=jKRz7xQwk/7XAka51FFCU3rs3FFQ9vtdyxKubMaPCzRiFpk3HtzFz17Z
   E4FKc0hChLzsr+10EeFaBmC6GsHukqj5v0mzC/7V9U8EEFXHhh+PjD4sY
   D76EV+04Fwm0UL1Eva7NSJtQGH4MauYALhazz1xCHOK3Y6V5+njKT6oGQ
   u3prZNzCxTXZDpckPwu6vVcpTGzqbJfZCHL3Y1cmEvFuK70Qo+kTpQ4kx
   DsI8IYM1kQzMqUzZfTlsutjHm9FyIABKpgdnVq3TUUBtuWOJA90hWx5On
   x48Bwv/BqGD0NL1cvj1UqeKWgr2X6TMAx30W6lkGgcHwK6pHcWIpoe3t4
   g==;
X-CSE-ConnectionGUID: N6PVQmmWTTKXtSNHsiXU+Q==
X-CSE-MsgGUID: vVEAL4W7S2m73EYVdslTZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="34066280"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="34066280"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 00:48:48 -0700
X-CSE-ConnectionGUID: Ulxf/l1DTvKPfFBNMUKtMw==
X-CSE-MsgGUID: ojzmiwjyT1abjQjC4jZfTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="131054723"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 00:48:47 -0700
Date: Thu, 17 Apr 2025 09:48:28 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	horms@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 2/3] net: ibmveth: Reset the adapter when
 unexpected states are detected
Message-ID: <aACyTHFwKonUwLv+@mev-dev.igk.intel.com>
References: <20250416205751.66365-1-davemarq@linux.ibm.com>
 <20250416205751.66365-3-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416205751.66365-3-davemarq@linux.ibm.com>

On Wed, Apr 16, 2025 at 03:57:50PM -0500, Dave Marquardt wrote:
> Reset the adapter through new function ibmveth_reset, called in
> WARN_ON situations. Removed conflicting and unneeded forward
> declaration.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 116 ++++++++++++++++++++++++-----
>  drivers/net/ethernet/ibm/ibmveth.h |   1 +
>  2 files changed, 98 insertions(+), 19 deletions(-)
> 

Thanks for addressing comments
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

