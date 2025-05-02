Return-Path: <netdev+bounces-187366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFDEAA68DE
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 04:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD1A1BC4C91
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E018A6AB;
	Fri,  2 May 2025 02:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca [129.97.134.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AA18024;
	Fri,  2 May 2025 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.97.134.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746154053; cv=none; b=jJHkGWaZeDc959X6FZePZpYtbL5yhBCW69sscCmdDaL9PKjvlPCX1NiKh3Giedrkngb822hBKdLoREKrWqXAf2/yl9RjGMY3YxflOVNeNExkPASVj3RXorhE6wKuTptZJRHbLvt4T4Ua7L/FEz1uHequjpm1fl4yfeurbuzmRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746154053; c=relaxed/simple;
	bh=fO4WwaX2Nb5zYofHwBkMb8GPMf/sNSL3tcrHoD6pMlc=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=JaoBNCm7V4Nyw5uCvGfcLAmLDWb6mTYoU6TudKHGzpoQ2xNyYep17QVKyD1/Q9LpteVdg+/CJa5q+YtM0J2xzYfUULfCN6QgqHgI+/6eluWjeqw4LR4D9kdDgP3eH1K/XKuKKqS2aQkQoCVg1BVdTNfblmcTCKXvhU923DgtoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csclub.uwaterloo.ca; spf=pass smtp.mailfrom=csclub.uwaterloo.ca; arc=none smtp.client-ip=129.97.134.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csclub.uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csclub.uwaterloo.ca
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 20367)
	id F32084603B6; Thu,  1 May 2025 22:48:35 -0400 (EDT)
Date: Thu, 1 May 2025 22:48:35 -0400
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>
Subject: Re: Fix promiscous and multicast mode on iavf after reset
Message-ID: <aBQyg2RBReEBc47P@csclub.uwaterloo.ca>
References: <aAkflkxbvC8MB8PG@csclub.uwaterloo.ca>
 <8236bef5-d1e3-42ab-ba1f-b1d89f305d0a@intel.com>
 <aAu2zoNIuRk-nwWt@csclub.uwaterloo.ca>
 <ffe2bfff-ffc5-4ae0-b95b-6915e5274bd7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe2bfff-ffc5-4ae0-b95b-6915e5274bd7@intel.com>
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

On Tue, Apr 29, 2025 at 11:44:55AM -0700, Jacob Keller wrote:
> Yes. That's the trouble with the current approach. The VF interface has
> to work well when the VF driver is running different operating systems
> or versions, and if we change the behavior with a new opcode or similar
> that would be difficult.
> 
> The reset logic is likely a haphazard mess of different "solutions" to
> various issues we've had. It grew more or less organically out of i40evf
> code from years ago.
> 
> Agreed. Obviously, our own testing never caught this. :(

Yes you need to actually run with promisc on, not just using tcpdump
once in a while.  So someone using the interface connected to a virtual
bridge that would want promisc to allow all traffic to be received that
then hits a tx hang would see it, but probably that is about the only
time you would have hit it.  tx hangs don't seem to be nearly as common
as they were back in the igbe and ixgbe days fortunately.

In my particular case it was enabling promisc mode, then changing the
mtu that resulted in very often loosing promisc mode.

> We might be able to get away with improving the PF to stop losing as
> much data, but I worry that could lead to a similar sort of race
> condition as this but in reverse, where VF thinks that it was cleared. I
> guess the VF would send a new config and that would either be a no-op or
> just restore config.
> 
> That makes me think this fix to the VF is required regardless of what or
> how we modify the PF.

It seems better to make the VF driver handle it since you don't know
what kernel version the host is running and hence what it is going to
do when you do reset (unless you up the API version of course, which
seems excessive just for this, and you would still have to handle the
case when the host is older).

Of course it seems that if the driver wasn't caching the current settings
for promisc and multicast and simply sent the config everytime any config
changed, it would be working, but it would also be wasteful.  I don't
remember when the cache was introduced, but I think it was done as part
of not sending a message for promisc and a separate one for multicast
since it sometimes resulted in the wrong setting in the end.  But the
caching thing has not been around for the entire life of the iavf/i40evf
driver so it may in fact have worked in the past and was accidentally
broken as part of fixing the other issue.

-- 
Len Sorensen

