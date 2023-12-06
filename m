Return-Path: <netdev+bounces-54510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A0B80758B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169FF1F2165C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4E48784;
	Wed,  6 Dec 2023 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3ZWq60m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA883FB14
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 16:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772F4C433CA;
	Wed,  6 Dec 2023 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701881089;
	bh=UpS9rXQHkRGB/A7GmDu5H0BY/+OWg9oz5VPzgnFW7cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G3ZWq60m3rAkFdj72xv74bCepk7HlZBuDDsl0YXxg0AlMvCJKAtj1cToasIfdmf3k
	 ZI535MWK7mEkoH8Hy2bsHbQF8SWrvZXpYKQj0rHDX1AwQaGMjRSkMjRDXzd/sl3+Se
	 G2fM1d3ORTH2O9IQNF6Qie5fwXNBKjZvv4/pMwH/Er/4Bq4u9qjST3leJvscP6L9Ng
	 37k1cyjmQV30qU3DbJFRseEfjZosh2PniP/EHIlvKslukzOvM/udFxm9jFpjRhIySl
	 0GKPhwzsgfQpZGFGt/LHcFTacErcygNbDWEdswrjl9fd3MlNJKAabAFK769ZBfpz9B
	 +8xFWda1tuetg==
Date: Wed, 6 Dec 2023 08:44:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, Johannes
 Berg <johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231206084448.53b48c49@kernel.org>
In-Reply-To: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 11:39:32 +0100 Johannes Berg wrote:
> As reported by Marc MERLIN, at least one driver (igc) wants or
> needs to acquire the RTNL inside suspend/resume ops, which can
> be called from here in ethtool if runtime PM is enabled.
> 
> Allow this by doing runtime PM transitions without the RTNL
> held. For the ioctl to have the same operations order, this
> required reworking the code to separately check validity and
> do the operation. For the netlink code, this now has to do
> the runtime_pm_put a bit later.

I was really, really hoping that this would serve as a motivation
for Intel to sort out the igb/igc implementation. The flow AFAICT
is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
back down immediately (!?) then it schedules a link check from a work
queue, which opens it again (!?). It's a source of never ending bugs.

nit: please don't repost within 24h on netdev:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

