Return-Path: <netdev+bounces-160469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBFDA19D79
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 05:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB84E7A51FA
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 04:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E574C08;
	Thu, 23 Jan 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATN3HJOy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2661EA80;
	Thu, 23 Jan 2025 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605407; cv=none; b=SlorF5ej/R2iO5SXNjH4WcY2NK1KuXZosiHleQtNSOrYYGtV/1WIGab9VQXDc2D9cTu5nLVh4XmLw+ruIXncWr0HgP79QpAhdmKlJ3HHuNdT5N0x2tttQmHqT1ZkF05omXMKkwzQFhJiWWK22sdAXG1Sl/jsK1YJR7WTQhVhbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605407; c=relaxed/simple;
	bh=imTtN7rF/OdbUjVXQxMuzTmzvPpWK/sSu9e40fb7FoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jQlnueJ4AIoEdQK/JrEO79ZSGF/6/xLCZuMtNC2dsb5rcrcLNmtoJkuVAJB8lGR5p5pKL3/fS0iTDGci+r8rpM1PEQw6OPOk9x1CP2t6O1GhegtiVlnLQJnEzDfWt2kcjmBMDwp5z93mfnWsohYfvPYO4q/wIZDXkQ70H19ivh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATN3HJOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715C7C4CEDD;
	Thu, 23 Jan 2025 04:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737605405;
	bh=imTtN7rF/OdbUjVXQxMuzTmzvPpWK/sSu9e40fb7FoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ATN3HJOyy7qLHCNnWRiGrDvGyrBdvK48vavmHtqdDy4QzmIxUHADeqo968N5P1QcO
	 CSllhXle1tN5H447kas0h3h9+hivGUm0eO2dxQrBV6v369Rqljs9DnMTvadlOfLFAH
	 aZEOcvvbWq2JqNXGD7d5KpHQj2QVn5+ddUl/GHRBQBY45zwWXF44aU6mWI8G0ofP1k
	 FaFVJjyOB3mAC+AhV4dmxDM1ZgEsW3u/tKRs5O2+Lp5u35ZrDkkN3Ibl77muIeuNzv
	 R2LtCaFM/TNY+L532ER6ml2D618VK4QYGBp4TKC/o2ZtpPdyLKwXdo5JidWXuTlvoj
	 vxQ/qDOvHN/Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7C380AA70;
	Thu, 23 Jan 2025 04:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NFC: nci: Add bounds checking in nci_hci_create_pipe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173760543003.917319.8232121908443720165.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 04:10:30 +0000
References: <bcf5453b-7204-4297-9c20-4d8c7dacf586@stanley.mountain>
In-Reply-To: <bcf5453b-7204-4297-9c20-4d8c7dacf586@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: christophe.ricard@gmail.com, sameo@linux.intel.com, krzk@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 12:38:41 +0300 you wrote:
> The "pipe" variable is a u8 which comes from the network.  If it's more
> than 127, then it results in memory corruption in the caller,
> nci_hci_connect_gate().
> 
> Cc: stable@vger.kernel.org
> Fixes: a1b0b9415817 ("NFC: nci: Create pipe on specific gate in nci_hci_connect_gate")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - NFC: nci: Add bounds checking in nci_hci_create_pipe()
    https://git.kernel.org/netdev/net/c/110b43ef0534

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



