Return-Path: <netdev+bounces-161306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D0A20943
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA423188936C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F21A0711;
	Tue, 28 Jan 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP7MKTOy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744C1A01BF;
	Tue, 28 Jan 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062606; cv=none; b=WbLhMEQVuXtf7LiPrXGl24ECNyT3HVgdaJRNytCQBvKT7uMG1nr6GIB8+0ORzlIEYT+1tElVT73ixbzApEPt0lvmdMv+YYDryGn2bPUG02FoJ3uj0my3v7UBqjJJFzRcFsqCgKZlzOjKG+8oOrvz82adMcIyPwi59AvNabvF14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062606; c=relaxed/simple;
	bh=FmWRL0mDSs1CYZ7eIDarhdAtcTTpaIAjICcw4wxU9Ms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+siteIOkXp2Yyfzxz5lF2NB2BHu7wfqold6ok7ssxc+8/ZkGamWM564t6UByNUHSx36toUm6JlWkzURf5ZlijOFhhxUp+d3MUemZTvfdERY6yjq3Ox4dm8ILYOAS8QpM2LnA+IaN7qEuNoBJac6LajNkA/8KzfsWyBJmJNP4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP7MKTOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1E8C4CEE3;
	Tue, 28 Jan 2025 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738062605;
	bh=FmWRL0mDSs1CYZ7eIDarhdAtcTTpaIAjICcw4wxU9Ms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FP7MKTOyjlsX8z78Sjdgyk6Bxed3zRALoL8c/0uMBCTy6NMS0kSyRNpXBC3tVKnHu
	 RVu3SSJgyT1Gms+15/R3ONMKnI+bn5F5JIi9q4EsgBKwj2iyBgwo1wPoLEC9nPHVwE
	 CLWxhzAJ/PhlqZdprKQ+m3L9Oi8CW40q3PWJCuJ29TpBzIkgNG17H0TvdX8kBmNOL0
	 V9oSyW6cYQDfPqmzFg0Y1PgprvqH5WGeBKWBb4FDNwEJR8VXfFOuaa7p52Dq4THrOe
	 c+P8Pik85IWWi6cdHG4uz+tv4/sC8/ND34nz6fuKJtpG/6PJcndtiB5ks6i3j1SdQD
	 OjJ0nedxJzynw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEC1F380AA66;
	Tue, 28 Jan 2025 11:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ptp: Properly handle compat ioctls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173806263149.3755886.15811094950826923330.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 11:10:31 +0000
References: <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
In-Reply-To: <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 jstultz@google.com, arnd@arndb.de, john.stultz@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gorcunov@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Jan 2025 10:28:38 +0100 you wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
> Detect compat mode at runtime and call compat_ptr() for those commands
> which do take pointer arguments.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/1ba5d3a4-7931-455b-a3ce-85a968a7cb10@app.fastmail.com/
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> [...]

Here is the summary with links:
  - [net,v2] ptp: Properly handle compat ioctls
    https://git.kernel.org/netdev/net/c/19ae40f572a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



