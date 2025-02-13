Return-Path: <netdev+bounces-165833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0951A33771
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324F9188BBF3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587DB1E98F2;
	Thu, 13 Feb 2025 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVUc8Ial"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2404EC4;
	Thu, 13 Feb 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425600; cv=none; b=WcJnzEc9oDyuN1HHR099Gw7n8ykCQ63AXExm1iDUAY6kz4ompL/rJycGBnk6MJt4Z1tJMfL5tkeOQcGmZ9N7A/gqKGALlcm1E1xT7Hbzy1W95+xr59CQRwLPvQ4Bx1pPTo7IV7E9vtm4OvoqLhiyktKyU4wHXX8o2WTVqHeeew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425600; c=relaxed/simple;
	bh=XpQbPKI9igVHpQ1tZ0XhK2uclZOpgu9lc0//4ojmblA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEsQqZs4w1ANGn7xOhsOQqCvKYuZ4QifH2gOBDfEAUk7mb+M8gQ6cAILszdAcecYa7L4ZGhShBFijHIoGTzbV6ZWkBtfantqD8cp0Jf4yApwhzcxLvjZPLBqjsjmfaWgEMYEzUqnP87uBRJKTBY9v7SMYYVTjM2wuPAVR4HxYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVUc8Ial; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739425599; x=1770961599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpQbPKI9igVHpQ1tZ0XhK2uclZOpgu9lc0//4ojmblA=;
  b=HVUc8IalV33nO9hp3Dza/O8tQUBeFP3NzaMaY3fx0ko6hO8DDgXVQVCp
   fTkieZciUfQV4xhXTK3dxbc4YCafJL5UKhjVjv5TXFrtnWpIXrRU+Pu2d
   oTrDkmzTgqh+e5999LmnVYYHJHiiTlHNf73cTw2PQlKbVvP5BN7zESfa9
   J8JOlS01v4e3BExn6hh1Jpbv8YI/i1fLFD05Mwp6+AVN6+73SdTx5rS2J
   CyrLzwdn1GEyquYkpBPLMAT+ri26hGlIJNeYqVw7BnC0amZiu8MyEXZ2n
   Y59YYs5inp3hRHQR2Y5PiwTPoxq2SPCggqU5T/FR8wk+0UE9qOFbA0FGS
   g==;
X-CSE-ConnectionGUID: mP3QPefVRt+cgIKbHNzYgA==
X-CSE-MsgGUID: 3XnfgGWXT7qaA46VLtfgqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50759320"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="50759320"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:46:38 -0800
X-CSE-ConnectionGUID: Ehqxx3epQAqWCOvT9B475Q==
X-CSE-MsgGUID: +1XcehPlTYSICABEwY7chg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113565134"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:46:34 -0800
Date: Thu, 13 Feb 2025 06:43:02 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] ice: Fix signedness bug in
 ice_init_interrupt_scheme()
Message-ID: <Z62GZkcQ5TnKBc2O@mev-dev.igk.intel.com>
References: <14ebc311-6fd6-4b0b-b314-8347c4efd9fc@stanley.mountain>
 <f66b15a3-1d83-43f9-8af2-071b76b133c0@intel.com>
 <20250212175901.11199ce1@kernel.org>
 <d6eaa268-e4ef-4d90-bb1e-37a7f546da93@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6eaa268-e4ef-4d90-bb1e-37a7f546da93@stanley.mountain>

On Thu, Feb 13, 2025 at 08:26:09AM +0300, Dan Carpenter wrote:
> On Wed, Feb 12, 2025 at 05:59:01PM -0800, Jakub Kicinski wrote:
> > On Wed, 12 Feb 2025 17:46:54 +0100 Alexander Lobakin wrote:
> > > > [PATCH next] ice: Fix signedness bug in ice_init_interrupt_scheme()  
> > > 
> > > I believe it should be "PATCH net" with
> > > 
> > > > If pci_alloc_irq_vectors() can't allocate the minimum number of vectors
> > > > then it returns -ENOSPC so there is no need to check for that in the
> > > > caller.  In fact, because pf->msix.min is an unsigned int, it means that
> > > > any negative error codes are type promoted to high positive values and
> > > > treated as success.  So here the "return -ENOMEM;" is unreachable code.
> > > > Check for negatives instead.
> > > > 
> > > > Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")  
> > > 
> > > a 'Stable:' tag here.
> > 
> > Bug only exists in net-next if it comes from commit under Fixes.
> > So I think the patch is good as is.
> 
> I want to resen this.  My scripts should have put a net-next in the
> subject and I think that changing:
> 
> -		return -ENOMEM;
> +		return vectors;
> 
> actually does fall within the scope of the patch so I want to change
> that as well.  There is no point in really breaking that into a separate
> patch from a practical perspective.

Thanks for fixing, I blindly followed scheme from idpf (there is the
same issue). However in ice it was done correctly before my patch.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 
> regards,
> dan carpenter

