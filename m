Return-Path: <netdev+bounces-193336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF89AC38D0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C85E170C91
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF841C4A2D;
	Mon, 26 May 2025 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkM6Mnv7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70A1C2437
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748235026; cv=none; b=tACXCf93pH84mwnMXz2wDNnd9FDdKnR6U0Gu3Hd4dd2tUReP2zfQly0iK+p4suIYzLOfdR/NK6BTxq10kTS085Im/Ja7btLp2rdayarx++ULAKyRXaFsLz9vd4TzoUEI8QLYY3KY5j/5vY7Onfc/nKEvptRVRPL9pd+Vv12Z/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748235026; c=relaxed/simple;
	bh=1qtOHnj9cZDZ1SLPicu9+HbB0wK3+BH4r85M66/sAbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUNdoE3dLVSUrU8duOpv1ZRmi2SRuaWnOPgyW+aCnCw9jwfeoRIatpmIPWJ6HYBJno5IuhhST2EAkIHEEt8MDiWMQu0vkZXkaX7ZtiVa9+lHnhn4b0uBXI5x5nHWPbVHgoISybK9AGoXcCgZjEV6wbW/WKlXjmV4T74Av0bHAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkM6Mnv7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748235025; x=1779771025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1qtOHnj9cZDZ1SLPicu9+HbB0wK3+BH4r85M66/sAbc=;
  b=BkM6Mnv7WDzQZit7Gmqjho94RtABqZB0Ycz9/Xxea6xW/wNWmjwC0bK0
   /SGo2I7ooe1u3Mnqu0+JavwK3T8GqaiUex10ce8HGZl4RjW9sCzR5j4bC
   GV7sdGh4qCmSqgKR798uudHRzQ6fkNR4vBN8NLU6YG2PsR2V7d8Bng/LQ
   hqM8WlQN/gmZH6VEy/niNe/hWK804PX8XnTUDm5lDA19pPlg9JXxvshbF
   5Ny8QRKDw/7mPD0w8iVZTRz1ol2bo5VIQ9ynwG77kqQ7Yf0jhsX9HoY1n
   EY1wir8G5lShmRrzjkEb9MAjduNg25q405d5bCVQXZqIvIF3lyJk4edHS
   A==;
X-CSE-ConnectionGUID: YHAtjip2Ro+gUsaW7AdWrg==
X-CSE-MsgGUID: X7O82TeqRFy9zrQUbAyYEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="67607761"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="67607761"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 21:50:10 -0700
X-CSE-ConnectionGUID: DA394MNFSiKTDcvh4S/l3g==
X-CSE-MsgGUID: QFiqzujWRIiTcrBD8tSmCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="142788444"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 25 May 2025 21:50:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 35D1413A; Mon, 26 May 2025 07:50:04 +0300 (EEST)
Date: Mon, 26 May 2025 07:50:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <20250526045004.GL88033@black.fi.intel.com>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>

Hi,

On Fri, May 23, 2025 at 05:07:02PM +0200, Ricard Bejarano wrote:
> > What is the performance without bridging?
> 
> I actually tested this as soon as I sent my original message. Interestingly
> enough, performance without bridging is about the same: ~930Mbps in the
> purple->red direction, ~5Mbps in red->purple.
> 
> I also tested running eBPF/XDP programs attached to both eno1 and tb0 to
> immediately XDP_REDIRECT to each other. This worked, as confirmed by successful
> ping/iperf even after bringing br0 down, and I could see the XDP program
> invocation counts growing in 'bpftool prog list'.
> But all I got was maybe (IMO falls within measurement error margin) a ~1Mbps
> average increase in throughput in the red->purple direction.
> But I guess we've now isolated the problem out of the bridge completely, right?
> 
> As instructured, I've attached the full 'dmesg' output after setting the
> 'thunderbolt.dyndbg=+p' kernel command line flag.

Thanks for the logs. See below my analysis.

> [    4.144711] thunderbolt 0000:04:00.0: using firmware connection manager

This means the tunnels are controlled by firmware not the kernel driver.
E.g this is an older non-USB4 system. The firmware connection manager does
not support lane bonding whic means your link only can use the 20 Gb/s
single lane. However, there is even more to this:

> [    5.497037] thunderbolt 0-1: current link speed 10.0 Gb/s
> [    5.497049] thunderbolt 0-1: current link width symmetric, single lane

This one shows that the link was trained only to gen2. That's instead of 20
Gb/s you get only 10 Gb/s.  Now since this if firmware the driver only logs
these but I suggest to check this by running:

  # tblist -Av

You can get tbtools here [1].

Reason for this typically is bad cable. The ones that has the small
ligthning logo should work the best. If you use something else then the
link may get degraded. You can check the negotiated link speed running the
above command. I think this explains why you see the "low" throughput. Hope
this helps.

[1] https://github.com/intel/tbtools/wiki/Useful-Commands#list-all-devices-including-other-hosts-and-retimers

