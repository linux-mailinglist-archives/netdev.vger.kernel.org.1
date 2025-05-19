Return-Path: <netdev+bounces-191403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F7ABB6E0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2CE1896D77
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B01DE2D7;
	Mon, 19 May 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAgZje2H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F405269816
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642520; cv=none; b=oEhxmu/e8+4powZ03WaXy++rtfwzJqAGJGKep/+yloDBE72CNKOS04OKJXwsJnQZzQ8hwzPHjXlMmD9qFsY9i8TEaWHdLeI5GweH9UaW9VvhkZpfPnJT4FsgCJpxN+wxD4vlxkiPo7wtE42znK+A7gMRhLAqoMLtV1estjVUzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642520; c=relaxed/simple;
	bh=9vsowWxkUMRcodHntjk/RwSuPf0YasMYtrTCEPq2UPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVGGmi3bcDzy9mv5xeLjwu0yQyiH/Fwgv571Cobb/QwXyBRB614YkikqrNl+9IJ4WoKLdvDugCXYXljijsSLKdUnR3xdpGWoBC+XObsLlfWIQuYmMk2p6rR3yWRs1KPBHD1w3+ISm47fwwsnQZem1Iof9GER/8xWH8r2hjotLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAgZje2H; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747642519; x=1779178519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9vsowWxkUMRcodHntjk/RwSuPf0YasMYtrTCEPq2UPA=;
  b=VAgZje2HtCBYyj0YjJ/mpqBMrumPpf2wrYc/r3LT6DGv3TXc+OQqMHej
   LAumXyfug7zut35jIKivipt8OQg+Im52BGzkS3VqMOrTp76bxRBjUjUPp
   pxNrHcIuNf2+4tEmrqdQYRijCHNPJeKpmK3vmH8cQKsRRyBAbPgkAvgcB
   LyK7XMq+kQF4J0eKM6j2PZv3LzDY10SBx5zrtV/yWJ/2r9gMdyuUorOB3
   HDIFjkeZDt946Bz2wanDfVu1ouWh2yGi+V0+H4GYxaDHUXwC8bjXFw8Zm
   P3EtuDRYBLCXzZNR+xokZLIleZ/OMxGrnkXtzAe8d99eZd0ZJaKuLfQU1
   w==;
X-CSE-ConnectionGUID: wS1opwczRlKDZpLUHe7wRA==
X-CSE-MsgGUID: 9wJWvQj/TCCXGIUenNrjEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="48642547"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="48642547"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:15:18 -0700
X-CSE-ConnectionGUID: OzMvJs+lTn6bUQNEI1CRnw==
X-CSE-MsgGUID: ssDPqK8ASdKnl+t9d+jTlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139206699"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:15:16 -0700
Date: Mon, 19 May 2025 10:14:41 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Michal Swiatkowski' <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next] net: libwx: Fix log level
Message-ID: <aCrocTkoD9BoOTCm@mev-dev.igk.intel.com>
References: <67409DB57B87E2F0+20250519063357.21164-1-jiawenwu@trustnetic.com>
 <aCrV/xlFlxoDsOVl@mev-dev.igk.intel.com>
 <000301dbc88c$ca5757e0$5f0607a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301dbc88c$ca5757e0$5f0607a0$@trustnetic.com>

On Mon, May 19, 2025 at 03:08:15PM +0800, Jiawen Wu wrote:
> On Mon, May 19, 2025 2:56 PM, Michal Swiatkowski wrote:
> > On Mon, May 19, 2025 at 02:33:57PM +0800, Jiawen Wu wrote:
> > > There is a log should be printed as info level, not error level.
> > >
> > > Fixes: 9bfd65980f8d ("net: libwx: Add sriov api for wangxun nics")
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > ---
> > >  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > > index 52e6a6faf715..195f64baedab 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > > @@ -76,7 +76,7 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
> > >  	u32 value = 0;
> > >
> > >  	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> > > -	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
> > > +	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
> > >
> > >  	/* Enable VMDq flag so device will be set in VM mode */
> > >  	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
> > 
> > It is unclear if you want it to go to net, or net-next (net-next in
> > subject, but fixes tag in commit message). I think it should go to
> > net-next, so fixes tag can be dropped.
> 
> It is because the fixes tag commit is not merged in net yet, so I give it a prefix net-next.
> 
> 

Oh, sorry for not checking that.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

