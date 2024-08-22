Return-Path: <netdev+bounces-121089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB9495BA9D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F51C233ED
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11371CBE96;
	Thu, 22 Aug 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltBk4uJR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD631CB30A
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341039; cv=none; b=E7xkt5KEMlPjCh+6wMKOFBGfpaoc9m0OkhRbNzoHYLpS7LZR2xORFLdzZ27p7sV4xyEFO0adUTm2efcCVIMR7O8UCOEXCIKxQDwCWZ5y1GGUeNJd5CgDaIB82gGedM6p+staI6MEbXKHR7PlGwsidbxi40Dl35htse7tAcihANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341039; c=relaxed/simple;
	bh=5OU9oqoII91OWevjA1moCK6j35dRUrtNfxAig4v9TjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YtnslgN2pAWCa/MToXi3i2C5TbDNzNo3GLGwv05w5wOrHCqY1aW4ULVMjgeLOT5Y1MB+LbBOYzD5xkvsuSQZ158kXOJGpuVe9h2mPqSa+zOvu6ARfpTh9G2Tjlh1UAlqwgzDZk6Ht5403z/9Jb2qsyNfuNuDY2gNXqEOc/ELm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltBk4uJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF2FC32782;
	Thu, 22 Aug 2024 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724341039;
	bh=5OU9oqoII91OWevjA1moCK6j35dRUrtNfxAig4v9TjU=;
	h=Date:From:To:Cc:Subject:From;
	b=ltBk4uJRnAplkycfJiaZw2D+UXe5LtvsRjGoxMwq8HIerxsbFN5wFXmwVchEXbZcO
	 cKh0CKNGUOqIlh0RSuSvuloHPKveBKQAn8BEbDXpU1Doy7R+3Ag7qMN78ZDqU3TMV7
	 CBMfGw02KDyN7+fTgjNS3PhwEkmB1HUPtQlKjzLWLzPPq7TL1w4NscROw+/NFL0yM4
	 9x2u7r3TyJXfecgMVH+xLEsygrCg3HktfJxxE1dmCpkWRC+cCtGDgHQU4KGdsBiEY8
	 gB1yPg1CucCpgtB4XyoSuOKodtPy7b6ewlBx29iuIUPG91OIZ42pQjX8KqAcHkq02O
	 rDkGed9zvt4Jw==
Date: Thu, 22 Aug 2024 08:37:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] forwarding/router_bridge_lag.sh started to flake on Monday
Message-ID: <20240822083718.140e9e65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Looks like forwarding/router_bridge_lag.sh has gotten a lot more flaky
this week. It flaked very occasionally (and in a different way) before:

https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding&test=router-bridge-lag-sh&ld_cnt=250

There doesn't seem to be any obvious commit that could have caused this.

Any ideas?

