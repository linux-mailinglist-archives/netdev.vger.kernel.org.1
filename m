Return-Path: <netdev+bounces-247867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD92CFFD39
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 20:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05E973070D74
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A54264A74;
	Wed,  7 Jan 2026 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsTuXvjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA61EB9E1
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812724; cv=none; b=tXX1in5u6I0RydOWylu+Qx1UJs14PZFIUwl2pZroqbpWIWDU+5cfFF2RJBnPgWG3xLHKTXwMPuXuBq5M79aeaKe46D+sDPsK3twgup6qZFjqmwsJO5Nyt4jH849lyLfmV5FfebQ3XPUmBYkuKlmF6krjlCPRnbYsGcBYyyAPnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812724; c=relaxed/simple;
	bh=fqIIKDF1SzhUdqOs6bcNenM5vD3ZDIbqoK+ryPILNsw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Emh1i9jfOk09ntykhDrEEtCdOGHfTezgv2Bcr/cBdvKBQOPtiQFA6uaW2yND6S7ZWuMbx4NWhE3QJMFiB58ggOtrdTwt/ke6d3YqvPLpDg1s8zzUk9YV8CTL7RfNlPHyDONScrIrCJ3sYJLer/3tpkabHa/93bhDdP9bhzdSqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsTuXvjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BEBC4CEF1;
	Wed,  7 Jan 2026 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767812722;
	bh=fqIIKDF1SzhUdqOs6bcNenM5vD3ZDIbqoK+ryPILNsw=;
	h=Date:From:To:Subject:From;
	b=gsTuXvjjlENRJ8zSucdOndBB7rMuBnsHgIiyElzXh+/NqxZXXU+7Sej0OcGfaPoe2
	 iTxqCXx0hoeHJHzY3gz8u7sVW9wsmIZ9a6dAm0l4MAO94wjQUZywyMhZoxOsoBpnmC
	 3u2c/NVY9zUcgJGQcFjZeGjjlz9D74tDShmJswDpH7ozzVd4Sy1rmsYz6zRkxxdYFx
	 u3pMyxpvp5epWV37JcaETdYDK4pOCt+Rvapbpq6Wu0sSk6vpUoT+HiViW1OxpRtEDP
	 3+v5DbtflZ7KpbNSoCS4v7+BI+o88rBo9Yikew4K4D762dwWbSW0VHyetbjA8BacFQ
	 58OTMbT0Fi4ng==
Date: Wed, 7 Jan 2026 11:05:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemb@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [TEST] txtimestamp.sh pains after netdev foundation migration
Message-ID: <20260107110521.1aab55e9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Willem!

We discussed instability of txtimestamp.sh in the past but it has
gotten even worse after we migrated from AWS to netdev foundation
machines. Possibly because it's different HW. Possibly because we
now run much newer kernels (AWS Linux vs Fedora).

The test flakes a lot (we're talking about non-debug builds):
https://netdev.bots.linux.dev/contest.html?test=txtimestamp-sh

I tried a few things. The VM threads (vCPU, not IO) are now all pinned
to dedicated CPUs. I added this patch to avoid long idle periods:
https://github.com/linux-netdev/testing/commit/d468f582c617adece2a576788746a09d91e91574

These both help a little bit, but w still get 10+ flakes a week.
I believe you have access to netdev foundation machines so feel
free to poke if you have cycles..

