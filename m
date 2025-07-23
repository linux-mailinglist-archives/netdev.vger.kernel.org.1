Return-Path: <netdev+bounces-209330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA13B0F286
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86C31AA0DEC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45F2E6106;
	Wed, 23 Jul 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuuTngFO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC442E611F
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274972; cv=none; b=bry0/XjrNNg2pwwUthTW6B5jD8Gft57AZmvsBwLhaVXTO5vdK/7g62oFE4rUGAk6xPVwsviNz3e+m1cWCoy9/SEal9TcGLXpXYzk5gsgil9L4LFSYz+uaVt7bm8OAyA8VTbwMj0nmlpQFe6KAV6I2HC9WFjebDxIMUo41/LC+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274972; c=relaxed/simple;
	bh=gE8760DYEPgX/ZZDL1cHPaepLzGsEIAzE/+xPF12xgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elnPUfNfnu4eEWoPQXM/T7dNb+FgSR+HGBsl7W2J5AGsiqYEZDSPtmM2AUh+WP9M7p8GmX2vM1jHaizlc3ycCSChKl8GrLS7uGIW9UtCbDxzkMlapFCcAIVVXtXot1Da2Cqens6Jpc/kvhcnLkKkywmyirVLMLCmIBwnzAgfQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuuTngFO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753274971; x=1784810971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gE8760DYEPgX/ZZDL1cHPaepLzGsEIAzE/+xPF12xgw=;
  b=CuuTngFO0mtK30U0JeGfYDiIzh0siCO8+J2LZJihJpSeWIgJYch4IIU3
   pS8k1G45w7/kFaRDIOsGhISIXzfI5Z6ifZXBgP9cxpYq/mWEsDziqwV1j
   QjIomL2EEBABwsjL4dWeTuY46YF10kHaBmQMFJbZobn+IsaFLtpSHau+V
   PRGaAQnQInmI0RiVf07ty8n0iKYZUWpfQvWiNAf6yk5GA5fpduqv6wjoM
   v8VqK2feHcu+Z9h4tuEXDmRXC9YDKSQFnaAY95Z4uQ6HA9ZzQBRl2bfKj
   CPg2BeJZe76Mp2teJYZKDfx6wVlWNkk9nai0h/vMc5Jsif3o5HtQgWx2Z
   Q==;
X-CSE-ConnectionGUID: F4Jd+DRJSX6/K+P7QLh2LQ==
X-CSE-MsgGUID: pTHuINNkR7KMBjGjPfk53A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66987741"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="66987741"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 05:49:30 -0700
X-CSE-ConnectionGUID: US+X/B+KQiW1H6RezBwV0A==
X-CSE-MsgGUID: j70Ib76qQiSgVJTiNZONKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163992831"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 05:49:29 -0700
Date: Wed, 23 Jul 2025 14:48:17 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com
Subject: Re: [PATCH iwl-next v1 00/15] Fwlog support in ixgbe
Message-ID: <aIDaET+R4p+FQdNP@mev-dev.igk.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
 <2hgukyjbhhafp5zruf5yb5rjddmjsyo4hwjd5gyyuomuugr5wu@vrftn6sxn4yr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2hgukyjbhhafp5zruf5yb5rjddmjsyo4hwjd5gyyuomuugr5wu@vrftn6sxn4yr>

On Wed, Jul 23, 2025 at 02:12:56PM +0200, Jiri Pirko wrote:
> Tue, Jul 22, 2025 at 12:45:45PM +0200, michal.swiatkowski@linux.intel.com wrote:
> >Hi,
> >
> >Firmware logging is a feature that allow user to dump firmware log using
> >debugfs interface. It is supported on device that can handle specific
> 
> Did you consider using devlink health reporter for dumping this?

This is only moving already implemented code to the lib to reuse it in
another driver (which supports the same interface).

First implementation was added here [1]. And there was a discussion
about using devlink for it [2].

[1] https://lore.kernel.org/netdev/20230810170109.1963832-1-anthony.l.nguyen@intel.com/
[2] https://lore.kernel.org/netdev/fea3e7bc-db75-ce15-1330-d80483267ee2@intel.com/

