Return-Path: <netdev+bounces-116672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8994B578
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CEE1C217F3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9F243AA4;
	Thu,  8 Aug 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPEp6zKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDE8BF0
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087833; cv=none; b=um4fZ4RThpvuYPbIag4FDddY+llHyaICsHf1zUhYRAsBHFpO+97+V59Qr74rSQAx0Cut5VO8YdYJ9DGOXEmgw7cOM+pycvtzQr2ARGg1EkkXBltrYC4G6i8FBC2Px9+ZrsbGK7/JPwx66zemRZ1WjGBT6DATKV6+U5vJyx2j1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087833; c=relaxed/simple;
	bh=gQqkhc2ACrua9fwGxiKEWgmos/M4xV4jcl4UPbFYKRE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M3OyiZxJ5++t7Rcdj+A4vnMM4wrpXQIlgZ0/ciiA3Q6BOgQdsgin0W9YQBSkXT3NUdZL659rDMxS38lbykBFKH9kuyvJyVaxZZiB2ZPwLMweadpDdOfesFULk2pQZ/f3/Zdq1kY9/OhGCM7uLMgPppBF6eAi08rrfq/0RJEzvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPEp6zKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2989FC4AF0F;
	Thu,  8 Aug 2024 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087833;
	bh=gQqkhc2ACrua9fwGxiKEWgmos/M4xV4jcl4UPbFYKRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GPEp6zKh0qohO62c3p8nGVv9sntSAaWMbGRg7MSypn3WYglMj/EtMWiAInrFyWw3L
	 xqNvgZBsp3VJ9U2VuzXJsAsoEgTE5mZAg50b2+7RaCFFGfhK0sApGLgQTiJeXaZOun
	 lomBOmGlQAsJTIfalEE1s8LVh3CDGaNJ7l8+GT2CTHCjlMz48CE3PKVY5Y7MpZW/AL
	 hqnhLaYVOZaIXxAUUh7rmxpoVcTitST44+e9LFjfBpokDC8ET+8vWm/J/cMQrNmqC8
	 3wQ7Vo6TsJIVGSLPxfpV999xLm/UTS4XyWUaMna0OiivzzKKZimKHR1Rr0CsinvF47
	 lDn08zfKZt1iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DCC3822D3B;
	Thu,  8 Aug 2024 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en : Fix memory out-of-bounds in
 bnxt_fill_hw_rss_tbl()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308783175.2759733.3534817825068610873.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:31 +0000
References: <20240806053742.140304-1-michael.chan@broadcom.com>
In-Reply-To: <20240806053742.140304-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, leitao@debian.org,
 kalesh-anakkur.purayil@broadcom.com, somnath.kotur@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Aug 2024 22:37:42 -0700 you wrote:
> A recent commit has modified the code in __bnxt_reserve_rings() to
> set the default RSS indirection table to default only when the number
> of RX rings is changing.  While this works for newer firmware that
> requires RX ring reservations, it causes the regression on older
> firmware not requiring RX ring resrvations (BNXT_NEW_RM() returns
> false).
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en : Fix memory out-of-bounds in bnxt_fill_hw_rss_tbl()
    https://git.kernel.org/netdev/net/c/da03f5d1b2c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



