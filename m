Return-Path: <netdev+bounces-203824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64AAF75A8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAE5564C0D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583C2E7BDB;
	Thu,  3 Jul 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzHoaPe/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF842E7BD6;
	Thu,  3 Jul 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549382; cv=none; b=mtuCIUOkNuh8McPOUUUud0/KtBD4OCZudWhzPRszqKN13SqB+YO+bGnqF+X4YMRP8DgE2wpd+4biV4QLmJbe+Az0hCTb1v4wGk532NvRH0IBn61qoX1U7awXMyXVlhYbIIkJhg3Eq98CHcNNfRF2kKh6MlKEJRuWR11Q1ieNKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549382; c=relaxed/simple;
	bh=3tUymL6xjx4clRzBeqwvtTm9KaapLckMSHFmrwbJtlg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KgfGW+BDnZyEp6/Y9H2Ugg8BKBJCImIKemqQQsMFkJnK+c8Z7n+9v1ds1asIYQjoDnwb5g3HdlVPpB104a9ycViroP3e3e0yLxQ6G512OEYoo+7BMdhRAXCBOXtgANrcyzB2UxAI2Jum+xD2mE0Wpp/ExzV/7+w/c3aRWLe87J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzHoaPe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F1BC4CEF1;
	Thu,  3 Jul 2025 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751549381;
	bh=3tUymL6xjx4clRzBeqwvtTm9KaapLckMSHFmrwbJtlg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AzHoaPe/R65JsEbh4DFlKlYo4fOo6uIJa+95MoOU7ZdhpV3HCAoYZg+yQxPowytqT
	 jI7MkfWSGlUyrpa+uQJCLBDEPpj2iU+3FkCVNY2m5nxpYAYmgiUDOu7N/Tn797RSXb
	 FxhBuFqoq2rUB3d32tIitT98A0Gpwu9XvlUESLl4TLFAnu1YxfLTRsHV58WSg6xMn5
	 j2MTRmjuWFtBmIdrcyt0yAaK2Rkc/bCwJfCHo7/Ez5lFy2IaPQJayrmc/ztVPJj3tI
	 SUYRyRex1SL+a5pwkHi9jjC6ZOoaLSwtnUrU1OH8T32jEZ43B6vwRiWZBbPEOVvsql
	 /u9ebRHaTau6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34166383B273;
	Thu,  3 Jul 2025 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bonding: don't force LACPDU tx to ~333 ms boundaries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175154940611.1481668.18355488754972268861.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 13:30:06 +0000
References: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
In-Reply-To: <20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org>
To: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 carlos.bilbao@kernel.org, tonghao@bamaicloud.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Jun 2025 11:01:24 -0500 you wrote:
> The timer which ensures that no more than 3 LACPDUs are transmitted in
> a second rearms itself every 333ms regardless of whether an LACPDU is
> transmitted when the timer expires. This causes LACPDU tx to be delayed
> until the next expiration of the timer, which effectively aligns LACPDUs
> to ~333ms boundaries. This results in a variable amount of jitter in the
> timing of periodic LACPDUs.
> 
> [...]

Here is the summary with links:
  - bonding: don't force LACPDU tx to ~333 ms boundaries
    https://git.kernel.org/netdev/net-next/c/135faae63218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



