Return-Path: <netdev+bounces-176074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906A4A689BC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3EC16BA15
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77949253B49;
	Wed, 19 Mar 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRFr29Lh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09D253352;
	Wed, 19 Mar 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380528; cv=none; b=SJ7Kvm5I1OfeZFcd2mSLt+tQ/rU1Eg5ZJQAdm9DniWSIJKTuyjp3WG/TMw1XnLVsYr4VcsrEQAs9WBRZUSodnazRcvOzbssYfY+sXOBJx1mv6M3uu2dFs4JsLdDyJqr0s5TO61HtYJFcA5Cice4EmvMV+7drpfD+YuU+CxoZs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380528; c=relaxed/simple;
	bh=bkb2aj+ND5fVbPnCKkskLmtkIcJtDAREoubFFIC7OjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhOE71uoc05ItHB4iLTdRM665Vz0AjLELOOVQGhhmKnRPnxFAwgFBnud70OYfXfnqwHqXC6LnfAZBdbp3z/imeBlQySmvzKYDX6iaNB5zIm9L0p6WVQLpUIboLgT5cq2VvThLXBszdrOUXpOFaAGKXFIJBYfVdeUM/t8sFvO/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRFr29Lh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742380527; x=1773916527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bkb2aj+ND5fVbPnCKkskLmtkIcJtDAREoubFFIC7OjM=;
  b=NRFr29LhLkiVrsJmm5UP0jTuNzmuYl0BgDE5WnplT+6zZMsWw+Zgq9Si
   cbtMsFADx03KJuRVf3BTckmH8Txf4eLtt5cTdyx3SrckXhpm9JrwxgXYc
   B/NRWXqTi7uLabfE8n/CQK5rDQJqGzgbq6X9my4qdz44L+MC+Xu8EsmyI
   X2Sj53M7imvJq0XMirlyKcHc7k/cLD+m82sKsj/YuzmFmNn6fXokjeINk
   lcw02t11ynQLubXzP0fo91HD8vd6CHIhY4xxeKGjmJ0weQRHTFb4Ksl/y
   ARkpKA7gtUz2xXvUqsSmkPCSWxnr3G87z5rRh8dDMU4AHhgXkYmR8ihj7
   w==;
X-CSE-ConnectionGUID: wyC+1B9uSby7zZ2mxwvZew==
X-CSE-MsgGUID: YOBV8RoZTF25jy6rFJkYjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54232793"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54232793"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:35:26 -0700
X-CSE-ConnectionGUID: d0W5vS45RIOvYcKW4YxbiQ==
X-CSE-MsgGUID: oPJRO9ezR1KCXX9CLxG3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="126770318"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:35:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuqld-00000003tIn-0VmX;
	Wed, 19 Mar 2025 12:35:21 +0200
Date: Wed, 19 Mar 2025 12:35:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9qd6HfmfE18Clxv@smile.fi.intel.com>
References: <20250318161702.2982063-1-andriy.shevchenko@linux.intel.com>
 <481268aa-c8e9-4475-bd5c-8d0f82a6652a@lunn.ch>
 <Z9mlWNdvWXohc6aM@smile.fi.intel.com>
 <f9640312-3641-4f32-9803-a76b2b010d7d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9640312-3641-4f32-9803-a76b2b010d7d@lunn.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 06:09:12PM +0100, Andrew Lunn wrote:
> On Tue, Mar 18, 2025 at 06:54:48PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:49:05PM +0100, Andrew Lunn wrote:

...

> > > > -	char phy_name[20];
> > > > +	char phy_name[MII_BUS_ID_SIZE + 5];
> > > 
> > > Could you explain the + 5?
> > > 
> > > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/davicom/dm9051.c#L1156
> > > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/freescale/fec_main.c#L2454
> > > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/xilinx/ll_temac.h#L348
> > > 
> > > The consensus seems to be + 3.

And shouldn't it be 4 actually? %s [MII_BUS_ID_SIZE] + ':' + '%02x' + nul

> > u16, gcc can't proove the range, it assumes 65536 is the maximum.
> > 
> > include/linux/phy.h:312:20: note: directive argument in the range [0, 65535]
> 
> How about after
> 
>         ret = asix_read_phy_addr(dev, priv->use_embdphy);
> 	if (ret < 0)
> 		goto free;
> 
> add
> 
>         if (ret > 31) {
> 	        netdev_err(dev->net, "Invalid PHY ID %d\n", ret);
> 	        return -ENODEV;
> 	}
> 
> and see if GCC can follow that?

No, with + 3 it doesn't work, need + 4.

Another possibility to change the _FMT to have %02hhx instead of %02x.

Tell me which one should I take?

-- 
With Best Regards,
Andy Shevchenko



