Return-Path: <netdev+bounces-91184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14898B199C
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE37F283254
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B923767;
	Thu, 25 Apr 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbwMjWNa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9022F14
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016428; cv=none; b=MKJ7fWAlkypWwHUH2VUt3eEdL8Tq/Jw2buuGf60A6Z06r1c8AAKsVpZq1K3pee5Qlfxbh7FXAASlSOFe5sIsqzjris68GhTdQP/UkcuOz3DFskNIJZ+0yoscCcL+XQIjdgjHdVHRvR0mA3As0CDAydnmta4iGWwjQWOcReh3uDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016428; c=relaxed/simple;
	bh=Vne75Uw5Aya1OBLD6yNvNi+f2IqlqPH4rgUOv3aE8Wk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TlFVX6qhvEKQ2qjYPclOwgtaPuYQnJR9pAtPnpMVtz27+/Je45hHyriYzmMsC0XtprQ0rY/PB8GCoI5lSC7zVKnWeu2chP0lAG7afznKux+8mWjQPjPRj/pfHFRsFlWA7GB7yyMIw38k4k8VwZI8h5J9/hPP4QYemU75ucl6qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbwMjWNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94B7BC2BD10;
	Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016427;
	bh=Vne75Uw5Aya1OBLD6yNvNi+f2IqlqPH4rgUOv3aE8Wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lbwMjWNa4c1XcfhdOWgBsuEe4QSUG+dMLENTKP0hDLIWvrALPT3GfB66aJ7LBwBuu
	 SEjARc+69oXLjz7vlzYdiBqOVomJzgeVZJBqgI1d4QZc8o1cJ+mdD9A2pYpI81b+NW
	 6uD9L8Sj4B78Qe/SWVDrxZEsJopf55Uxnmv2RDi/8jx6SzT/JdBit/MhBHGZB1GI+e
	 px2aFJj3cZdEtMV4W34ANHfVBoMkglxZGkfSv6R6ryYSAF8EuSa/KYU/eoIQLMyoZk
	 bnTdUzn0CaEUF9sDjNan0ch1WlD21Qrn6pg26Oel/XjTyH39OxHHxqMlCX58wCXiIa
	 0bKq6da/6hqMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82232CF21C2;
	Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401642752.20465.12165002714639664326.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:40:27 +0000
References: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, lukas@wunner.de,
 sasha.neftin@intel.com, lozko.roma@gmail.com,
 marmarek@invisiblethingslab.com, kurt@linutronix.de, hkallweit1@gmail.com,
 horms@kernel.org, naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 13:45:02 -0700 you wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> Roman reports a deadlock on unplug of a Thunderbolt docking station
> containing an Intel I225 Ethernet adapter.
> 
> The root cause is that led_classdev's for LEDs on the adapter are
> registered such that they're device-managed by the netdev.  That
> results in recursive acquisition of the rtnl_lock() mutex on unplug:
> 
> [...]

Here is the summary with links:
  - [net] igc: Fix LED-related deadlock on driver unbind
    https://git.kernel.org/netdev/net/c/c04d1b9ecce5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



