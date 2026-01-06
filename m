Return-Path: <netdev+bounces-247280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB315CF6696
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54BB1300769D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044F5223DC1;
	Tue,  6 Jan 2026 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN3GscNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CEC22172C
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 02:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665235; cv=none; b=T72bhgTNV7tTNevtJ8B8/T85xrPG0LomRRwk1+1SijTHJIuoonLuTLEvLvkyUvNSFgYFm4mKFlkWh7UoiqKlG/WnIW7x2AJkOsGA6cxoPv7lyijy6S96QkfL3tQJudk2NUaa1yVlZ7wwO9476smMfk6CT0dD3Oj4SHalY6ao1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665235; c=relaxed/simple;
	bh=Iq3LL3sAdS4auCZHMzIVfTuZ1csMLEPUU4B0B6p4A8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FqeCubSY0uQfKadLXvrX9ALlzw9pSqQD57TJ7l0MRGDIadzdMNWZ60xdcZi72g0dzET8Xy75TDpLtxMF6Dx/AgUiahabRv+LDmC8qsUPaMCYjDfKWoLy+scfvElZbtaFhv0sA2617eGbJ/JjecOe2YrUGJEz3QcZHhFEbWux9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN3GscNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50260C116D0;
	Tue,  6 Jan 2026 02:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767665234;
	bh=Iq3LL3sAdS4auCZHMzIVfTuZ1csMLEPUU4B0B6p4A8g=;
	h=Date:From:To:Cc:Subject:From;
	b=eN3GscNyk7J7qkk9oVsWDBuDEijJQK9n5PkDThDcUHgB2Auf0Q4kdV0qcpR26OsB+
	 UC5MRgbMlDYcRcXg7vnV+zW1fLcSH7bqBJlEeFivbhGTmF/aI46AXHn860E+lC2QwH
	 +ZV6YfxkUTtfmKh6yB23gVm1bRzCo6IIdMu7+ICaB7eBucd8P/xBStFXAdwqgowMJi
	 4bE/n69fUpri4ZO5VHwgIab9d/WK7+39oLkL0OthOiheJN7/UK25nquWdxXVkVhCQF
	 cDifkAcC0kOrvNaXJzuXOBrsvnfyBDLM86Kwz1t4cjGCADrEEDIVKW2n9AFAVZnC3t
	 sG3vQnRvtAfTg==
Date: Mon, 5 Jan 2026 18:07:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [TEST] amt.sh flaking
Message-ID: <20260105180712.46da1eb4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Taehee!

After migration to netdev foundation machines the amt.sh test has
gotten a bit more flaky:

https://netdev.bots.linux.dev/contest.html?test=amt-sh

In fact it's the second most flaky test we have after txtimestamp.sh.

All the failures are on non-debug kernels, and look like this:

TAP version 13
1..1
# timeout set to 3600
# selftests: net: amt.sh
# 0.26 [+0.26] TEST: amt discovery                                                 [ OK ]
# 15.27 [+15.01] 2026/01/05 19:33:27 socat[4075] W exiting on signal 15
# 15.28 [+0.01] TEST: IPv4 amt multicast forwarding                                 [FAIL]
# 17.30 [+2.02] TEST: IPv6 amt multicast forwarding                                 [ OK ]
# 17.30 [+0.00] TEST: IPv4 amt traffic forwarding torture               ..........  [ OK ]
# 19.48 [+2.18] TEST: IPv6 amt traffic forwarding torture               ..........  [ OK ]
# 26.71 [+7.22] Some tests failed.
not ok 1 selftests: net: amt.sh # exit=1

FWIW the new setup is based on Fedora 43 with:

# cat /etc/systemd/network/99-default.link
[Match]
OriginalName=*

[Link]
NamePolicy=keep kernel database onboard slot path
AlternativeNamesPolicy=database onboard slot path mac
MACAddressPolicy=none

