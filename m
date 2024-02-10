Return-Path: <netdev+bounces-70751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E115B850404
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 11:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C31F23EE4
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAC364B7;
	Sat, 10 Feb 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuND8qsX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5131D684
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707562139; cv=none; b=TCdRUu6kaNM6K9RP93jmSbBJqwUnDFIWHqxPDzi7e4bLp2o5j0hcaE9XrMfjSqlOH0h9UYPqIO7I/19Ds3aZ1Qx8Zzgllm0xNwDlQl2xwziiSJVQ0gBzPFc5gVJy8f+nP6IoY78nR5uTNp/+g+tvidfwNeDewc8NFX87JciNj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707562139; c=relaxed/simple;
	bh=cK6BUBE+KcUOObi6eZQQ6/x8Kp9qpahf/9Ka06C0Hh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3QVqLVqZ7HJkENJR3bBZ5DN55DQD2wnuicAsijQ6Rxh22KiWn7IN3apOI09Rzi3r/kj1OeSfStW7v78PAvhQn55/6Da6J5/3NNt4f8Bvg7u9RRvjZfuh6DSEeNFctSZQVDEdY8Z8KiFfVfohSNlszOM29H8muYEGYY0n7pyq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuND8qsX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707562138; x=1739098138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cK6BUBE+KcUOObi6eZQQ6/x8Kp9qpahf/9Ka06C0Hh0=;
  b=ZuND8qsXL3XnRGLhgIEX9AHJknXvpg371LDEVfGxUTatYDQO1Unv+gP5
   KtnPf+mOYp37tBap8Jb7Jp5A9aneALTz1OYzZcCUfUMfHatOjyrEWHn9Z
   EP4ApvQYz+Te8b24zkUcb1j2/iGW2gQis7w48SmxkuVNF9Kv7Dlq+F9Oq
   w/Q92akxfWal4RxDwxqI6d8OMRxE/Mkh9BpRebI3og7Ze/zgIJtB56vwa
   QWK+Sbwy0tenjDZOtrM48mZlJ+d86ra9wtnoqdJLScKs8L3PHWOfpz4Em
   vqvrE93duwvO2Ij7TGhzdcqtFgxWc2yGTmC/FcDZNmm7z8m7ehoxK1sDB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="27007489"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="27007489"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 02:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="6796404"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.138])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 02:48:54 -0800
Date: Sat, 10 Feb 2024 11:48:51 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Rafael J . Wysocki " <rafael@kernel.org>
Subject: Re: [PATCH] net: avoid net core runtime resume for most drivers
Message-ID: <ZcdUk5c0M7bTUOSv@linux.intel.com>
References: <20240207095111.1593146-1-stanislaw.gruszka@linux.intel.com>
 <20240209124536.75599e91@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209124536.75599e91@kernel.org>

On Fri, Feb 09, 2024 at 12:45:36PM -0800, Jakub Kicinski wrote:
> On Wed,  7 Feb 2024 10:51:11 +0100 Stanislaw Gruszka wrote:
> > Introducing runtime resume before ndo_open and ethtool ops by commits:
> > 
> > d43c65b05b84 ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
> > bd869245a3dc ("net: core: try to runtime-resume detached device in __dev_open")
> 
> We should revisit whether core should try to help drivers with PM
> or not once the Intel drivers are fixed. Taking the global networking
> lock from device resume routine is inexcusable.

Ok, we need get rid of it in igc (and fix broken assertion in igb).

> I really don't want to
> make precedents for adjusting the core because driver code is poor
> quality :(

I see this rather as removal of special core adjustment added
by above commits. It's only needed for r8169. For all others
it is just pure harm. It could be done without the priv flag,
but then r8169 probably would need changes.

Regards
Stanislaw

