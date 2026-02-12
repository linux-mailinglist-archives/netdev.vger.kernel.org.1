Return-Path: <netdev+bounces-258429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI42B3eijWlh5gAAu9opvQ
	(envelope-from <netdev+bounces-258429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:50:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBDC12C078
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31BCD308E37B
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B862BF00B;
	Thu, 12 Feb 2026 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDHiFy8K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94F2C234C;
	Thu, 12 Feb 2026 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889820; cv=none; b=dcqmr9/LMHLoW2d0eybA+xzaKxtbZhm2UIpqbEhvlzVedKFqtAPpLYTkP0AMQUtzK3++uD9VGM7y08gw0N7uxLHKhKjoTnLvLd6Gi7cc0cxWfXRiFV6AqJAc8/1eSrR9J2dKDWcfw+XyrjuI2glpHsdfnbYoLqJsByS+WxFq9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889820; c=relaxed/simple;
	bh=uqYHV6WHUvhDsOBpe5pUyJM0Yd06seajXeuYOQbHbXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgRVGUdzqovimDc09sIMmVr4IBX3nNK8BezhdA/wW0mbr0H5XuvIHkxdg5s3yRL/UqTcxnwMv0jpXebLfylSUBDq6pdE2yLpoI7BV/aeB8hm03Wj5XcBhtz/ngUDWi0N6+aOOpY7HPPuJzY/Vh3Z++I9HIChs61Q+QEg136285I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDHiFy8K; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770889819; x=1802425819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uqYHV6WHUvhDsOBpe5pUyJM0Yd06seajXeuYOQbHbXI=;
  b=fDHiFy8K9aPFSwW4cpYx8sb5QPWHZgahAj5mIrs2sPwsnoOJvxntepHG
   T9o02/z1avK3/khZtCIafIWQBfHtS1YhN855fAVqwpUwHEVra6PT8ocyJ
   NMvq32htb8R+mVzCySPGoWxMI9IcOwFS8VYDa1Ay9C9WtjXr4czP6Xaa0
   k2QsI5tnQ7yv6GHeqDK0L+9X5Izj5eehQ+xmchr3k3VvJMXPEaJD6PR27
   vNLcoBBsHPrfqhgD4Pno137D/zhbo9k/PYuaa3AaEi9e07apZBiasxUek
   aSABWceG2G35HMsijOAIWFl7vDjRONlMXDnjQ4zOddH3/CKBTxZyPGdog
   w==;
X-CSE-ConnectionGUID: 1tJ/AlokQVuCUEXTWX9poA==
X-CSE-MsgGUID: c9Vsv0ZkTkuykOw5VXDoFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="82782874"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="82782874"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 01:50:19 -0800
X-CSE-ConnectionGUID: khGUbtBfQzOmjeG1/MJmHw==
X-CSE-MsgGUID: tYbxTNxvSGuPd92sVt40hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="216708934"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 01:50:15 -0800
Date: Thu, 12 Feb 2026 10:47:11 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net 1/2] ice: fix inverted ready check for VF
 representors
Message-ID: <aY2hnyXFM9wplF3i@mev-dev.igk.intel.com>
References: <cover.1770882260.git.poros@redhat.com>
 <a76096058dd9b6d0cccaa5c2c699458351d02cec.1770882260.git.poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76096058dd9b6d0cccaa5c2c699458351d02cec.1770882260.git.poros@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258429-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev-dev.igk.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 7BBDC12C078
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 08:53:10AM +0100, Petr Oros wrote:
> Commit 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
> refactored the VF readiness check into a generic repr->ops.ready()
> callback but implemented ice_repr_ready_vf() with inverted logic:
> 
>   return !ice_check_vf_ready_for_cfg(repr->vf);
> 
> ice_check_vf_ready_for_cfg() returns 0 on success, so the negation
> makes ready() return non-zero when the VF is ready. All callers treat
> non-zero as "not ready, skip", causing ndo_get_stats64, get_drvinfo,
> get_strings and get_ethtool_stats to always bail out in switchdev mode.
> 
> Remove the erroneous negation. The SF variant ice_repr_ready_sf() is
> already correct (returns !active, i.e. non-zero when not active).
> 
> Fixes: 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_repr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
> index cb08746556a670..2a84f656405828 100644
> --- a/drivers/net/ethernet/intel/ice/ice_repr.c
> +++ b/drivers/net/ethernet/intel/ice/ice_repr.c
> @@ -315,7 +315,7 @@ ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
>  
>  static int ice_repr_ready_vf(struct ice_repr *repr)
>  {
> -	return !ice_check_vf_ready_for_cfg(repr->vf);
> +	return ice_check_vf_ready_for_cfg(repr->vf);
>  }
>  
>  static int ice_repr_ready_sf(struct ice_repr *repr)
> -- 
> 2.52.0
> 

Thanks for fixing
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

