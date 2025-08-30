Return-Path: <netdev+bounces-218438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE17B3C75C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1C4587813
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D93257851;
	Sat, 30 Aug 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLiW41nk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE82571D8;
	Sat, 30 Aug 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520404; cv=none; b=tG+donNHT+7Yvcat9VQCsgOClOxu1peja55unCjtWjY+6gO2dTrTbsECowig0u6mRE0WlvW8zq/khvK0SsK2uocEoHjpkam3JtLbIdX6f9Eu/mojXfAqFEPlOAmQgk9C/Q82Ilp/ypK7oOgep62VTdycDGwUkFhqcCtX+w5m1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520404; c=relaxed/simple;
	bh=6V+LWgYfOJrPhCEV/6UzzZqpKFBPYsC58+HES4tof5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P8n6xaEaYpG9qmbl+Sves2Z45ruVkwF/ByP95bPbvlMN8znTSIwNYSkV81Fq0SMnsZ+BR6mlO2u0ScvCnXtqQ4of9rgKm6pCgQimMjknBZ5y/a9f0K726CWcgUp40aG3za7ZHBCAIM+5whCEfmwufTre1O1P7aBm8xF9+mXXupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLiW41nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95693C4CEF0;
	Sat, 30 Aug 2025 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520404;
	bh=6V+LWgYfOJrPhCEV/6UzzZqpKFBPYsC58+HES4tof5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VLiW41nkDaN6R0MSL31+s1nUqtviZnYc0oFXjkdRI41guBZVYlAvtxa+DTa+iHfZu
	 EVjalt3kolYyvds+7F3cVo0Iui0fXHYlNL8QUHi7SmGlOOB9D6HltMLSfhiUW+fn99
	 DlnQ9u6JH8CztpqFXFNEMrMyPFJh+eRiZjq2uiyGbqsb+9BOYksSs9uaieE1T2tPQG
	 en4HTFzU20yYhzXV+XfzH4vSAWGvknskbuev4j/2iGP5uEOcuYdDmKZ+fg1b8D6508
	 LHcNlRM9rbwuwGsaRlGi8d3mG6mN1U6f0418/SFYpTCTwF4GgKRHieWDP/Jm7lsl7E
	 526ZSVTHmxgLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B0B383BF75;
	Sat, 30 Aug 2025 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: ocp: fix use-after-free bugs causing by
 ptp_ocp_watchdog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652041099.2398246.16448506468320735865.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:20:10 +0000
References: <20250828082949.28189-1-duoming@zju.edu.cn>
In-Reply-To: <20250828082949.28189-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, jonathan.lemon@gmail.com,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 16:29:49 +0800 you wrote:
> The ptp_ocp_detach() only shuts down the watchdog timer if it is
> pending. However, if the timer handler is already running, the
> timer_delete_sync() is not called. This leads to race conditions
> where the devlink that contains the ptp_ocp is deallocated while
> the timer handler is still accessing it, resulting in use-after-free
> bugs. The following details one of the race scenarios.
> 
> [...]

Here is the summary with links:
  - [net] ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog
    https://git.kernel.org/netdev/net/c/8bf935cf7898

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



