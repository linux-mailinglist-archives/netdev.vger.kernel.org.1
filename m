Return-Path: <netdev+bounces-148922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305D9E3734
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61A9280D24
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360CF1A7AC7;
	Wed,  4 Dec 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRKHa7nc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC5199EA8
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306962; cv=none; b=BK59VwevxgpipnnlS/3s+5JFZk29FlMR+BvBEamaPqAPrAodHitwRF16hIQeCZbjXjO3b0zfOINYjKTnkVZgsYovQ8EeS96fVgTqx6slzPZEjf7hqYYUv6Ah73U9Q0oHpLJn2zZVXyloCAOb1p0YdL+IixY+gub1NcYiS9T5Bns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306962; c=relaxed/simple;
	bh=kg0krfEeQJgoKo+q2PJr+YhJ5Ml6xZZ/X2EVCQW260c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rks41y41B5XFKxQTk8iN/wTn9e7aYS4KIdoaCLklDku7+xe+NCvqhoeq2sBqAtYGBgsN593BS9PgAKODFiTLOwnYGcycMQ6KQPmEZlq5uIk0OPcDHIjEcB/dyhaP+hUSgsbm/Ei662PKsRMfghHNW3FA02q+UlU9zeqzieD16hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRKHa7nc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733306961; x=1764842961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kg0krfEeQJgoKo+q2PJr+YhJ5Ml6xZZ/X2EVCQW260c=;
  b=WRKHa7ncXodECIpx0QGCrX6T/4bmS6ra4SyutMb34R97OzkzQgyokxJi
   KDGMQo0cD+BdWPQw80rFxLApvH3tbMfTQpS9veovTmYcQdtaH4fKVvyVi
   FjxflZRPzy0BemgBq9YIISY+sIyiVDZ9Ch4RKXlXalgk9swsYwZYYbO08
   wzKHhJ4CWiu0yRWi0vzgsJoAYQDLxTvPCCpAwPIRYXr7l0PWI04pQwrE2
   NBv+CrHddCinpTaIcEBFFatkkzH01CIx4W+tnJKQDdGzX7NEMIFmF7V+b
   lrKQ97FrMQ2G4r+5J78NjJ2Nk8dHYpO3m1kXZhhQP5Inz2HyEXttwujew
   Q==;
X-CSE-ConnectionGUID: mKH0Zl20RDmoJ6MURvq1Jg==
X-CSE-MsgGUID: k42a73OVSGmKf9bsMumeUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="36410140"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="36410140"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:09:20 -0800
X-CSE-ConnectionGUID: AZEc3PYLTgOTE/vRlrr5gw==
X-CSE-MsgGUID: 1AUVrbN4Qva3w+aCcWZ/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98537197"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:09:17 -0800
Date: Wed, 4 Dec 2024 11:06:20 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: simplify setting hwmon attribute
 visibility
Message-ID: <Z1ApnLK0fYS0dAeY@mev-dev.igk.intel.com>
References: <dba77e76-be45-4a30-96c7-45e284072ad2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba77e76-be45-4a30-96c7-45e284072ad2@gmail.com>

On Tue, Dec 03, 2024 at 10:33:22PM +0100, Heiner Kallweit wrote:
> Use new member visible to simplify setting the static visibility.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index cc14cd540..6934bdee2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5332,13 +5332,6 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> -static umode_t r8169_hwmon_is_visible(const void *drvdata,
> -				      enum hwmon_sensor_types type,
> -				      u32 attr, int channel)
> -{
> -	return 0444;
> -}
> -
>  static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			    u32 attr, int channel, long *val)
>  {
> @@ -5355,7 +5348,7 @@ static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  }
>  
>  static const struct hwmon_ops r8169_hwmon_ops = {
> -	.is_visible =  r8169_hwmon_is_visible,
> +	.visible = 0444,
>  	.read = r8169_hwmon_read,
>  };

Nice simplification, thanks. I checked that it is the only driver under
ethernet that use fixed value in is_visible().

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>  
> -- 
> 2.47.1

