Return-Path: <netdev+bounces-132207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90061990F92
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC541C23002
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCC1FBC83;
	Fri,  4 Oct 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkOfJvy0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A491FBC80
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069077; cv=none; b=c02bu3/Dlul6aIIlxT7/JqXRPO/KmUOD/s+m6zL1ISQytaFp85OzRODKdKJHXmGCtNeMFpFV2ksfLHAv/DVPxi2oNNLH60qlRX2txCcDXiMf6M+hwuUoYgztQOMqLVk5MLYmy1fGGSRCtuTmbS0BA3MTsBOzifLJPM/G+5ONAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069077; c=relaxed/simple;
	bh=m1rqKaZrp3Bozw4PZwIBSi3ugOd0u+fg1zYLcVpqVCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NzvI/EyccKcxh2aoG8gYy/2pj2PvGiP8JaBlKn1mFdeu4KnOD1MvlSgEZ0ZdM3s5ojpTKPTf4sT2/lYB9cM8nlks4Rfd1DvrlwTz9FDSTV9s+rbT2n1JEuq1Hq6e334f1BsQSSDHeprCsKQg328C2nEPhx7B6PpnDTdizaYV23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkOfJvy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D79DC4CECD;
	Fri,  4 Oct 2024 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069077;
	bh=m1rqKaZrp3Bozw4PZwIBSi3ugOd0u+fg1zYLcVpqVCM=;
	h=Date:From:To:Cc:Subject:From;
	b=EkOfJvy0gxyep1+xEEr+RdEyLnxgAKLxRjOEW5+Hb5LHEYBkuA3i+ZAsIOVrd1f4/
	 MBZqQZEBAg70O3B05JDTcYcSpX7/cqBeg/QmyzwvKzc8GynzTm6oBP+C2CfjfR4rjP
	 is1eLYrQ2wBv4WVTIRxJnozvwwCzCT6cGVnshXUfxjeFstV5AXbhQuWi8Fvhg/dtBB
	 FwRNLlTBavfV+lfR43Ql4bJIZXAC+GAAjQn/KiDrmLpPkyCMdcIY0fz22VVA0qy4bd
	 hu/O/VgMM8wKltaLeHdPf+BdjBJiR7q2hPE2S5W013znq2cwjc6cSwr/ZV+RAfLfr9
	 ncYNEvJgPK32Q==
Date: Fri, 4 Oct 2024 12:11:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] forwarding: bridge_mld.sh flaky after the merge window
Message-ID: <20241004121116.1b9a2e5e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Nik!

Looks like bridge_mld.sh got a little bit flaky after we pulled the
6.12 merge window material (I'm just guessing it's the merge window
because it seems to have started last Thu after forwarding our trees):

# 240.89 [+21.95] TEST: MLDv2 group ff02::cc exclude timeout                          [FAIL]
# 240.89 [+0.00] Entry 2001:db8:1::2 has zero timer succeeded, but should have failed

https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=bridge-mld-sh
https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding-dbg&test=bridge-mld-sh

