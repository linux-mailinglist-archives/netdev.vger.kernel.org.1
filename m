Return-Path: <netdev+bounces-251117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4EFD3ABDF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE2A312953C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63237C10E;
	Mon, 19 Jan 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIJXm10n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576C37C0F8
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832528; cv=none; b=XK0eXV/GrHcF7MmfyQR75v05tyC3jzV5OYAFOJwiUjO8SDKHsQAaEOIKkEpw7GtQoXtuIVxyVivbXB19AhZdrk2Uuxqn14fcwH1jjgumXF/hxHt2mXN10GzTLAkPsVcgWy89LuWWYLWDGFfJENubGl+nXqeJrY5b3hFaRCAl1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832528; c=relaxed/simple;
	bh=s+hyo97WnS3hz5TR4z1FoNy/rw/C4bPhQKNknHxMok0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=na8NZ4QGHfo6j+XkvB8BJ6A5phgGLINf93Cg0NaokudPQ2TWdmV51b3pZImRQzvuKK+9E2WOFeSmfgZsuwvrBAREUsYq2HCX8XhOm6ggcLredNQ4hVXrnaRcpyrZs8gl+dXt1eb1C+x++y+725BvGOEkWV3r80T60dQOdDzo5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIJXm10n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE244C19423;
	Mon, 19 Jan 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832526;
	bh=s+hyo97WnS3hz5TR4z1FoNy/rw/C4bPhQKNknHxMok0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oIJXm10nKBiWtkB13lXVmhO5dl4rKHniVk9FgvkKrRQ3k92Ka5JQiGyKIksKcCDnk
	 OZC8NaNgM7NHWEnjhE7LE4ZezISXz3zG9SyHNIGirZ9pEDJ0rHfNrlecU6fE+xpPGs
	 c+3GroLmBhMHNSSO2ODqm+xFb28QpmKnaiAU8B5APxSHMZHG0TJ3nEjH8nhq60mUIb
	 kx5OZQei348cT0A6MtXmfiygkNDqnxXNVnDq/aGEXvxvZ0gNUJUDGJ0Oe6YGoMMNN8
	 VuKpxevVvpFq9nC1T5ErRUZNGkqsoKUPQgAwmEeVTZ+b/ev4rqGElcoT+ksFLHckdw
	 mBSNoMjw/u1cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F313B3A55FAF;
	Mon, 19 Jan 2026 14:18:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] amd-xgbe: avoid misleading per-packet error log
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883231552.1426077.2769109296574901743.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:35 +0000
References: <20260114163037.2062606-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260114163037.2062606-1-Raju.Rangoju@amd.com>
To: Rangoju@codeaurora.org, Raju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 22:00:37 +0530 you wrote:
> On the receive path, packet can be damaged because of buffer
> overflow in Rx FIFO. Avoid misleading per-packet error log when
> packet->errors is set, this can flood the log. Instead, rely on the
> standard rtnl_link_stats64 stats.
> 
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] amd-xgbe: avoid misleading per-packet error log
    https://git.kernel.org/netdev/net/c/c158f985cf6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



