Return-Path: <netdev+bounces-59684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FE81BC28
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2E41C25C0C
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032D1DA43;
	Thu, 21 Dec 2023 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoNpn7R3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B255821E
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703176703; x=1734712703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGkuftQgsylYEyECeywOAFl+BMYJXvMoY4AhEa2ZXdc=;
  b=RoNpn7R3OmiPxhg6m3dXUMbNcXAjAcGEkdVGL6knXg0nf6ZNinudKXKE
   yoz+nbZVwYov89ed+KHX5lNY8hM6/xJfu0U89TILkVFpv64AoMz030wkW
   i5iIbuZnSG696PAg1kxfL5M9Nqtcldaz7YggZiI3/e7kHSt1rCbTIg0At
   3hdTrACoZ6zhDvt/lm0f8mRiWHd6itTe9ijXWQl+IaoWEb/eWTQKoYpwN
   SKyBN0+3+HmUuJwz1oBtHFnXVfJhbbYUSGHu3wkYhuHB+2kLiUvLm+I9T
   XU+CLdC1E21JmuHVy0vzcgn1QNXNxQdZhM/DuEXOYP23F7nt3+HYNAicV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="394890995"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="394890995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:38:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920379561"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="920379561"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:38:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGLvN-00000007tWW-0tjd;
	Thu, 21 Dec 2023 18:29:29 +0200
Date: Thu, 21 Dec 2023 18:29:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	nhorman@tuxdriver.com, matttbe@kernel.org, martineau@kernel.org,
	yotam.gi@gmail.com, jiri@resnulli.us, jacob.e.keller@intel.com,
	johannes@sipsolutions.net, fw@strlen.de
Subject: Re: [PATCH net-next v2] genetlink: Use internal flags for multicast
 groups
Message-ID: <ZYRn6AVAJ_QErXSw@smile.fi.intel.com>
References: <20231220154358.2063280-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220154358.2063280-1-idosch@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 05:43:58PM +0200, Ido Schimmel wrote:
> As explained in commit e03781879a0d ("drop_monitor: Require
> 'CAP_SYS_ADMIN' when joining "events" group"), the "flags" field in the
> multicast group structure reuses uAPI flags despite the field not being
> exposed to user space. This makes it impossible to extend its use
> without adding new uAPI flags, which is inappropriate for internal
> kernel checks.
> 
> Solve this by adding internal flags (i.e., "GENL_MCAST_*") and convert
> the existing users to use them instead of the uAPI flags.
> 
> Tested using the reproducers in commit 44ec98ea5ea9 ("psample: Require
> 'CAP_NET_ADMIN' when joining "packets" group") and commit e03781879a0d
> ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group").
> 
> No functional changes intended.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



