Return-Path: <netdev+bounces-170116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E0A47559
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 06:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EB53AEF0B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E0E1C5D6E;
	Thu, 27 Feb 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzaH2ROu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667223C9
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635130; cv=none; b=jur1E+eKjTO19gBv7vS5/kw/XctEl6Xf7+lLhwzGCNcbeSAKe/C1/uD0qaf3wv9nju8ENEFfdhEZE9gPKL5siI+MWHvmQo7fUfysVAw3Ov+vJZmyxkUH19aLTbtZyCisa9S6Ve+etu5YFYUd3x6E0cTgiHHllkiSnHO6r/18ZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635130; c=relaxed/simple;
	bh=CY+nOK5w7XaJKOOuJPeqVS7h4CvPHShBrAOlrt7ZQo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnNMygtawWhkj89+uvr1wD206gSHIbbTyEuPyrJ93kJqeKXSvggoPymGC0z8vLu6wWPFGTv0CDxKN+XMAxt/wR4XbAdFOe0eAPkSVgN1pkKq6i5Kn1oAJzq8SjYEGKmo0sk03SgaAZm0EZyiadJUZBs2mHmELUNC93YWlgNI380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzaH2ROu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740635128; x=1772171128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CY+nOK5w7XaJKOOuJPeqVS7h4CvPHShBrAOlrt7ZQo8=;
  b=WzaH2ROumOmdlOiGbUzz8fWN+7wngmnknN47b5ekf93MaPMDFfViM+ko
   fr6RZ0RrYO1QYBxG6rYSB1RexuNXXlCfYvaWnKtgFQYZyZi83hoAsXhF8
   PHfjURHaFUHLK4stetagTNOAjLapbt3TSgWyRVm5s0y9TFWXsxKnlv6VB
   OyHGCLQRg2bYnjWkQ4IJfulAn4jhPTKQ7P6uLlZJFfhxMRykxFGkMQka7
   5iuSu5k+stwcE4B5b/Fvm5/KzoNjcP3lKoKgQuFkUfiqLoiSbIuJi3dz5
   LEHd8gxBIoBbRcMlGWfp0Nad8ZbLWnmOggRDP92jRwVJAJGAWDoquvpWE
   A==;
X-CSE-ConnectionGUID: lE3VuWBST8ey4rUxogSY/A==
X-CSE-MsgGUID: pCVBKRcaQ72PNZRuWr4M8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="29112667"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="29112667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:45:27 -0800
X-CSE-ConnectionGUID: PPbz5SSKRgS5W7bOXbkKAw==
X-CSE-MsgGUID: FB3aVhCDSUmshCUj37HwYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154112594"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:45:23 -0800
Date: Thu, 27 Feb 2025 06:41:39 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH net-next 0/5] Add missing netlink error message macros to
 coccinelle test
Message-ID: <Z7/7E0kfDHvK1hXd@mev-dev.igk.intel.com>
References: <20250226093904.6632-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226093904.6632-1-gal@nvidia.com>

On Wed, Feb 26, 2025 at 11:38:59AM +0200, Gal Pressman wrote:
> The newline_in_nl_msg.cocci test is missing some variants in the list of
> checked macros, add them and fix all reported issues.
> 
> Thanks,
> Gal
> 
> Gal Pressman (5):
>   coccinelle: Add missing (GE)NL_SET_ERR_MSG_* to strings ending with
>     newline test
>   net/mlx5: Remove newline at the end of a netlink error message
>   sfc: Remove newline at the end of a netlink error message
>   net: sched: Remove newline at the end of a netlink error message
>   ice: dpll: Remove newline at the end of a netlink error message
> 
>  drivers/net/ethernet/intel/ice/ice_dpll.c          | 14 +++++++-------
>  drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |  2 +-
>  .../ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c  |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |  6 +++---
>  drivers/net/ethernet/sfc/mae.c                     |  2 +-
>  drivers/net/ethernet/sfc/tc.c                      |  6 +++---
>  net/sched/sch_qfq.c                                |  2 +-
>  scripts/coccinelle/misc/newline_in_nl_msg.cocci    | 13 ++++++++-----
>  9 files changed, 26 insertions(+), 23 deletions(-)
> 

I looked at the whole series, thanks:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.40.1

