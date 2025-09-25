Return-Path: <netdev+bounces-226257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9117B9E9C5
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12C219C765F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE592E9756;
	Thu, 25 Sep 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMB/XfBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9BFE55A
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795812; cv=none; b=rudVEYU1jEJsuRmQJky6S7WzP5Z/p/679Wo+qU8DXxhuvyYaMoDICThKuwA/WQUr+mGOHQduyC7LZuj3xrLN5LIS0UV5HJe5F6n8wtxyuwMPNdIjuw6E/ilyna3+ysLOYEL63Tz5YYbbnyJFidVlME1UvS5E2ovzXKr5HM9chh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795812; c=relaxed/simple;
	bh=OzvOPimuho1XXzUgEr9jUak4enQoJYy5xoQyA/0QHN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U67PvUgGNMlSJ+Uy56IW+hSWpOX1OaWTtrZiCwcSNQHhQ5daWO9WTGIwQXduChg+lR2JOG2w0it+qYRBlkbR7poE7MyZTJYV8cBP0v3GHoN/feBtw51A5O0aKhXL84VvfrRFmOsfnEAL7G+GQNoCLRs0aE6OWTvZMHNio1/PAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMB/XfBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15028C4CEF0;
	Thu, 25 Sep 2025 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758795812;
	bh=OzvOPimuho1XXzUgEr9jUak4enQoJYy5xoQyA/0QHN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMB/XfBAZLP61G2ycUdnY3VX+1lhcYL9fFqXR/FUlb4D85NZZAx0fPytsAPALVQdT
	 YTlKd5HcgFfc6rQhZkYW8iZlA1APTtWP4fmeawh0vHJr9p5Z5nMp1eREOtx1LKI0X/
	 rk/9JFDr458LtIyavmY7iltsBnDhIxg4340QEHKAr+t9RLXWxY6j7bWBevlybw8tQC
	 YzVmHHERudlOM5QVeXI/IN2l8E5nsIN+qaIN6aQAt+DPVS7RybV7P1WP4cZlJtFah+
	 JxeboVcX9DH/TtM/QDSeGYx3AU5H6ZgI/lsav2jh7u9fVyX1cTk4XB3Qk3Yy1Qo5Dj
	 mlBz/XU2ZwXzg==
Date: Thu, 25 Sep 2025 11:23:29 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next] ixgbe: avoid redundant call to
 ixgbe_non_sfp_link_config()
Message-ID: <20250925102329.GE836419@horms.kernel.org>
References: <20250924193403.360122-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924193403.360122-1-alok.a.tiwari@oracle.com>

On Wed, Sep 24, 2025 at 12:33:54PM -0700, Alok Tiwari wrote:
> ixgbe_non_sfp_link_config() is called twice in ixgbe_open()
> once to assign its return value to err and again in the
> conditional check. This patch uses the stored err value
> instead of calling the function a second time. This avoids
> redundant work and ensures consistent error reporting.
> 
> Also fix a small typo in the ixgbe_remove() comment:
> "The could be caused" -> "This could be caused".
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 90d4e57b1c93..39ef604af3eb 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7449,7 +7449,7 @@ int ixgbe_open(struct net_device *netdev)
>  					 adapter->hw.link.link_info.link_cfg_err);
>  
>  		err = ixgbe_non_sfp_link_config(&adapter->hw);
> -		if (ixgbe_non_sfp_link_config(&adapter->hw))
> +		if (err)
>  			e_dev_err("Link setup failed, err %d.\n", err);
>  	}
>  

I am wondering if there is some intended side-effect of
calling ixgbe_non_sfp_link_config() twice.

...

