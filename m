Return-Path: <netdev+bounces-81697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384BC88AD83
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3AF1C2AC45
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C134A29;
	Mon, 25 Mar 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCH7Q9mX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE217FF
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388715; cv=none; b=eVNBbstU3VS6TjkHPZQezr0yXsRkHkFI9qUEKzCzhT+ERKGybEKFlYJTSMjTt+EkbfkceS1HJ/bcV2sS2UbnXGdMWnXuSX7jWOl0iKhfIsEquiP2kQEwxNF+m8pKHNWrKPpXOFccgJUVM+Fbsxr1yuy4pdmjXvXV1JYr6ktAjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388715; c=relaxed/simple;
	bh=pDZKQc6ecvkphwAYRU2Enq0nSASTo3gjVQAEK+jg+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9MIwia2gRDLC8DQqVUT2EVyyVG+8wVU1iwezPafnBSwW6zYHaeYEPZi1w+wpD8LTuPbgD3yeRWq7GQpImjqG9+s8J5ldRilqCTwofP8wbuTiOQutiq3Xzt7ksdmxZGKSK9yEz+4H8pjRBWNr5I7ftYu/nsNdcCzXu3ukXA6zxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCH7Q9mX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711388712; x=1742924712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDZKQc6ecvkphwAYRU2Enq0nSASTo3gjVQAEK+jg+qA=;
  b=KCH7Q9mX1jES2KIdB+gmtXdRTuMBtHpcFjAOwenOycwqQGHP1Hop0xBt
   oUqSy8JLJmI0xHtFiWjioq4dsdgJ/GibHUSZdWXV20YoXlU9bDEQdlkkO
   6sElkbljWkalIq6nrLpy54zx0OtZwIAoKKt5kPEbBBUb0Fj+NZSV6/BGf
   rERj3ir1YNZM5Ybct1XkhsO9ZoY6C0VU+2uZviWErq3ridbJAhBPIEU2B
   0OtHCr8TpsnPp8LEVXFsg4PGjCO+ZddwDaLsQZ228n8HOSZaVjdJ1Swxc
   P5kXhm6Y2h3l6z5/wV4LKRcL7OyE9Eb1gm9wU/f8E0VPCD1jdA3OGHg48
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6590088"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6590088"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914850267"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914850267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:45:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rooNd-0000000G4LT-195N;
	Mon, 25 Mar 2024 19:45:05 +0200
Date: Mon, 25 Mar 2024 19:45:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dw@davidwei.uk, jiri@resnulli.us,
	Sven Eckelmann <sven@narfation.org>, Jason@zx2c4.com,
	mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
	pshelar@ovn.org, wireguard@lists.zx2c4.com, dev@openvswitch.org
Subject: Re: [PATCH net-next v2 3/3] genetlink: remove linux/genetlink.h
Message-ID: <ZgG4IebcrI1RCKAe@smile.fi.intel.com>
References: <20240325173716.2390605-1-kuba@kernel.org>
 <20240325173716.2390605-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325173716.2390605-4-kuba@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 10:37:16AM -0700, Jakub Kicinski wrote:
> genetlink.h is a shell of what used to be a combined uAPI
> and kernel header over a decade ago. It has fewer than
> 10 lines of code. Merge it into net/genetlink.h.
> In some ways it'd be better to keep the combined header
> under linux/ but it would make looking through git history
> harder.

Some last moment minor comments (no need to send a new version, JFYI,
maybe you tide this up when applying).

...

> +/* Non-parallel generic netlink requests are serialized by a global lock.  */

While at it, maybe drop extra space? (I noticed it was originally like this.

...

> +#define MODULE_ALIAS_GENL_FAMILY(family) \
> + MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)

I would still make this TAB indented.

-- 
With Best Regards,
Andy Shevchenko



