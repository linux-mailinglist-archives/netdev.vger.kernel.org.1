Return-Path: <netdev+bounces-242896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7558C95C84
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 07:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8ABDA34222C
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 06:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA72147F9;
	Mon,  1 Dec 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEPsrOwu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEE19C556
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764569968; cv=none; b=vBpxz+h0p70OZeDkcc8+FWwCVl5LWMyE+lCzSHmshYWS2CRfuOyAT995Xxl2rZVtTWmaJw7natRDh11REM5kmhnICfnq1e8PI9Yuj4QCwHZrDJ8Q4tJs3ckt3aXxXI/bqSTEYlHa3sxjbE0uzkmEK9udKON+3sp0NvJ/5P1sArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764569968; c=relaxed/simple;
	bh=nWU+YgARz3HgtNOjS+2AoceQVaAKqRvcwZJ4d9Hkfts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0WEPw2TnlUqYvBvWqNcFUbac2avTO63y4/8ZPX0j6K8icpgH7/oMdIpBm2xk96fKktqAnX76zazdi8NlBPd/li1SCwV5xYorfKqEmPSdlmdsP75yzFppB0bG3S1Axr4OhFBPchM48cTRvTHNgRNAzY1aEh3gPsf5qAqkHQCnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEPsrOwu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764569965; x=1796105965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nWU+YgARz3HgtNOjS+2AoceQVaAKqRvcwZJ4d9Hkfts=;
  b=WEPsrOwuoxOHOkrZpmcNGuPLfvW8tyYK5grL4FQgzeXd0mbWHIfoTh7B
   XY7YppuZ0G3eGte6tMXTeZglXoE+c02Juo1uTlIzFF1ZVuTu6a/BnDtA7
   vTIiN15v7CiHsqFOO/NtPn5JSHMYFHrhBcw6aCTy19OgSC9fFXu83xPO9
   xa4+0b5mb9eLaBehjCLxC3PKTctECXl2DK2N72QOJiMt0cwonKv7yJLuq
   B0BPFhgw6K8zRs1b5idKLEwc+vTyM7iKeFHq/VrOffYdnmnqah3LcYdx1
   NzFeZjFIqYrLbFVlRK89BfxKu+cg0TNnyqEpePpyoPQ9yuDoupHLAcDcO
   A==;
X-CSE-ConnectionGUID: BeF0Qs6GQ0KE5Uj6NHan9A==
X-CSE-MsgGUID: EQ0kx2OyQhqmcD4mEWRSig==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66571138"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="66571138"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 22:19:24 -0800
X-CSE-ConnectionGUID: TF6KedGWQCa2MxD+sqaDYg==
X-CSE-MsgGUID: HuQLsXwrR5uPJM1Itsl+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="194769861"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 30 Nov 2025 22:19:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E113E93; Mon, 01 Dec 2025 07:19:22 +0100 (CET)
Date: Mon, 1 Dec 2025 07:19:22 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: thunderbolt: Allow reading link
 settings
Message-ID: <20251201061922.GC2580184@black.igk.intel.com>
References: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
 <20251127131521.2580237-4-mika.westerberg@linux.intel.com>
 <3ac72bf4-aa0e-4e3f-b6ef-4ed2dce923e1@lunn.ch>
 <20251128072351.GB2580184@black.igk.intel.com>
 <e4f3eefa-9a01-413d-9ba6-ec9ebc381061@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4f3eefa-9a01-413d-9ba6-ec9ebc381061@lunn.ch>

On Fri, Nov 28, 2025 at 03:57:07PM +0100, Andrew Lunn wrote:
> > > Please add SPEED_80000.
> > 
> > Sure. One additional question though. Comment on top of SPEED_ definitions
> > suggest changing __get_link_speed() of the bonding driver accordingly but
> > it basically converts from SPEED_ to AD_LINK_SPEED_ which I think we need
> > to add too. However, these are user-facing values so should I add the
> > AD_LINK_SPEED_80000 entry to the end of that enum to avoid any possible
> > breakage?
> 
> Are they user facing? They should be define in include/uapi if they
> were. I would keep the list sorted, and Cc: the bonding driver
> Maintainer, Jay Vosburgh <jv@jvosburgh.net> (maintainer:BONDING DRIVER).

Indeed, they look like they are not. As you pointed out these are internals
of the drivers/net/bonding/bond_3ad.c and not exposed as is to the
userspace.

I'll add the 80G there for both of these in v2 and Cd Jay just in case.
Since merge window is open I'll send v2 after v6.19-rc1 is released.

