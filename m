Return-Path: <netdev+bounces-165047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B2A30314
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788517A066E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 05:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1B1E572A;
	Tue, 11 Feb 2025 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy1LI0Hz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3B2C9A;
	Tue, 11 Feb 2025 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253277; cv=none; b=pGUPfkcpWEoqP4oL8c8/C2IUcc6+SMXU4Q1uFD6RFOmXTBTXwpoDLUL5ZiOSDexk3AxgOaDWvOrQmIf45f4pJMSDwNibnOzZAz5Iw5u/47TN1tEdFX2Fa8ckVFc3cEYx0eWWhd13lN7a7/ATbxp0ZZ6qaSSwmGaJNirXS/qYoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253277; c=relaxed/simple;
	bh=hVmFd14xdvqxZNoX8n/AztacQV0z9P6ENxKHHDjuzL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krdAMi1jnbCxXkDIryw80nZVrH29mdO3pXh8wOL9M3YKFV+jC4v5WEl5JxwaQE+kWlYaguGl3rf43Bk29Cwi1IOM6cWwGK1tvf+vhYaskG0cRtDn7BgD3MyTX5SKs09McmrZdzpgMMQ8cmAz2XZEI5LU7BB5JIgXdJ6b8X9Tcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy1LI0Hz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739253275; x=1770789275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hVmFd14xdvqxZNoX8n/AztacQV0z9P6ENxKHHDjuzL4=;
  b=Qy1LI0Hzi/aYyjWOfgYyamLy5KEk3NDue4PN04/v0CXv8l5rf45SKP0K
   Hu+ff7WQoCfXUUn/nUIn9Dt4odIX9g9n4b9HJS3/+GKTQygfmyA76++b5
   eeUsg50+sXKY1j1kvlHOaBuKeyBwRI5WZPSWpZsuQgIQPUZMZS+dxeE3e
   XhamQYgEH9x0Z0GTy+msgvgARp11XVXiFhruNoqUF7Tu50kms35FlTUXh
   UQXs6Op1hpCzcZTfv/0yxwTQpWrNRINfxfvVy7LoF6wYcZetw4L4G6GLB
   AThpAq5CYduPcik2IY6V109ecDhlFUb0hRt4vZ5RzrOZYp9Nbq8L1n7Vd
   w==;
X-CSE-ConnectionGUID: TSA9MU24R/qzM54cWzCP1Q==
X-CSE-MsgGUID: 6OdS7neCSzO7dgsVmtiZZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51288710"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51288710"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 21:54:34 -0800
X-CSE-ConnectionGUID: xj7JgrJwRl+YPqx4HtZBpA==
X-CSE-MsgGUID: R0B+Cx0sTLyTFUH0k0ebvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135666689"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 21:54:31 -0800
Date: Tue, 11 Feb 2025 06:50:56 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: hariprasad <hkelam@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Fix uninitialized scalar variable
Message-ID: <Z6rk3Z6TuFSJgSaV@mev-dev.igk.intel.com>
References: <20250210-otx2_common-v1-1-954570a3666d@ethancedwards.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-otx2_common-v1-1-954570a3666d@ethancedwards.com>

On Mon, Feb 10, 2025 at 09:01:52PM -0500, Ethan Carter Edwards wrote:
> The variable *max_mtu* is uninitialized in the function
> otx2_get_max_mtu. It is only assigned in the if-statement, leaving the
> possibility of returning an uninitialized value.

In which case? If rc == 0 at the end of the function max_mtu is set to
custom value from HW. If rc != it will reach the if after goto label and
set max_mtu to default.

In my opinion this change is good. It is easier to see that the variable
is alwyas correct initialized, but I don't think it is a fix for real
issue.

Thanks,
Michal

> 
> 1500 is the industry standard networking mtu and therefore should be the
> default. If the function detects that the hardware custom sets the mtu,
> then it will use it instead.
> 
> Addresses-Coverity-ID: 1636407 ("Uninitialized scalar variable")
> Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 2b49bfec78692cf1f63c793ec49511607cda7c3e..6c1b03690a9c24c5232ff9f07befb1cc553490f7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1909,7 +1909,7 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
>  {
>  	struct nix_hw_info *rsp;
>  	struct msg_req *req;
> -	u16 max_mtu;
> +	u16 max_mtu = 1500;
>  	int rc;
>  
>  	mutex_lock(&pfvf->mbox.lock);
> @@ -1948,7 +1948,6 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
>  	if (rc) {
>  		dev_warn(pfvf->dev,
>  			 "Failed to get MTU from hardware setting default value(1500)\n");
> -		max_mtu = 1500;
>  	}
>  	return max_mtu;
>  }
> 
> ---
> base-commit: febbc555cf0fff895546ddb8ba2c9a523692fb55
> change-id: 20250210-otx2_common-453132aa0a24
> 
> Best regards,
> -- 
> Ethan Carter Edwards <ethan@ethancedwards.com>

