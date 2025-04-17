Return-Path: <netdev+bounces-183574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E73A91127
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FFE1907273
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697F1AAA0F;
	Thu, 17 Apr 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjO3iHgD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C21C6B4;
	Thu, 17 Apr 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853441; cv=none; b=rLPs6zoML2jlPp3L4B0CE/W9xDgTshNJ6NcV5DSUXNQGpKGv65lhRxRyM4gsFRZs6nylq8YISyCKBZ8DPM5s03WjDEwVY+IXgNpvuGQDOYLGMeGwfGxp1g3FI5PbaV8W7akARVnKPVyyFGKJRo1ZWMR/ef8U0WhKFj75VJqLqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853441; c=relaxed/simple;
	bh=PhWVwTpHj86o5e0Z8WUMyee0WXWjJBGKgJQGYvsrx6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q5HQpoZvWxscHjwf1qhDFXxz+O1Q45sc2tAPpGt5HosZG0wg5O6icKuID72xEwpG456TCbg/TXXZJ356OZyZ5KImaYXw+vesyn4kZWhQzZOatAsG41W4hpBmrwDktckwKXswQ/pZTssqG9+SREzoLUP2i2rFGaigxRk6jf8EPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjO3iHgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA85C4CEE2;
	Thu, 17 Apr 2025 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744853440;
	bh=PhWVwTpHj86o5e0Z8WUMyee0WXWjJBGKgJQGYvsrx6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LjO3iHgDfJcj65mV005RFMXKJhrhv5hyiUnM7NDFb2uHkMnVpp6pe39H2bosfJLs4
	 3XFaKLLYuu3ECQfMPXk9xBl1ffbQq1reG5py6S/ORe+0VOfbsiwvxxRAcAeVjLmO/Q
	 XSH9j4iNkoEtEH5CSBa3mwY6SgwJjvx+r0j0JbfMInau4mel28GXJxVEYie/PlUAu0
	 6axn7c1d4F9k6RMdhcc4axnDir3wCnoTdXInxpKSUhsAbtX/wjSu2i4h/hlcMDERW7
	 0Q4Nr/j9db2QDExNn+9jnhLnTw31VG6/xenRZSsmi+UPEhwyLbeW/pQE5/vW5i9qG3
	 kU00IV/0CLrcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8D3822D5A;
	Thu, 17 Apr 2025 01:31:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ptp: ocp: fix start time alignment in ptp_ocp_signal_set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485347869.3557841.6627337378264323196.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:31:18 +0000
References: <20250415053131.129413-1-maimon.sagi@gmail.com>
In-Reply-To: <20250415053131.129413-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 08:31:31 +0300 you wrote:
> In ptp_ocp_signal_set, the start time for periodic signals is not
> aligned to the next period boundary. The current code rounds up the
> start time and divides by the period but fails to multiply back by
> the period, causing misaligned signal starts. Fix this by multiplying
> the rounded-up value by the period to ensure the start time is the
> closest next period.
> 
> [...]

Here is the summary with links:
  - [v2] ptp: ocp: fix start time alignment in ptp_ocp_signal_set
    https://git.kernel.org/netdev/net/c/2a5970d5aaff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



