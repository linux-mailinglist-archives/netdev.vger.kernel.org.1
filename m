Return-Path: <netdev+bounces-226812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B324ABA5548
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3D8380991
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71062288EE;
	Fri, 26 Sep 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HasqbAM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA6433AD;
	Fri, 26 Sep 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925816; cv=none; b=QpLEn+86vLJyutUYwArfoW1iddq5ECGJPrALD7THAfMFQJy5W6RvHUZh+YrnLH5UQJabQPxYO51FQTrKtLCKz1iU8oiVDnEwj00eawZXj9DbIEKyUnS994vAIF4hZLFPBub/HbNxkvR6TSv9yUFX5RwEAYz2dTFcqaWrfSaXjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925816; c=relaxed/simple;
	bh=MiyKNnG8zTc+6RsPfPKid4TJomwqt7rOOXsO2nMcGdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c6VMNPU2L3EGRkXybxSCMCzKTR2pzXpfNOF4pKxg9BZNCshTlWHf75DVXrULsg5JtrpvYbQEwkHYRXYh70OmGWvBxdPuPJEpVJCfvFmL57qgPkpZjH9bkYLwazEOP4iZNM2D40mwCIeefRY166o9TwjCZarHU+D2haUp15qf6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HasqbAM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8598BC4CEF4;
	Fri, 26 Sep 2025 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925816;
	bh=MiyKNnG8zTc+6RsPfPKid4TJomwqt7rOOXsO2nMcGdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HasqbAM3t9KZpuT1R9s0G7U0qFqyInPVc+uu2s8dyZLSSrUP/aLXP/QFC7fAGRRFW
	 9GLiiWOJynSj7BMO5+9MH/Z8zt0+KZ57zvLYs1LEK9J2dKhHbMkaZ+5s3coWjYz9HL
	 rhvdx+LqY78qSazGVmq/EbgudO0Nn7qjOUgzji+oVz6EcptTKl/IYjthIiuiQxZ1K3
	 Zqq3B4JcvEdW2I0HMi9B822is/IrXpdTncZDAuFfpNN3av8SzX1R7ijyW8ObU/GHGx
	 5uiNnduGlTYc7nL3c2zHo+a3Oc6chOk1Ss9wZ689vuNy1UVSWRJOO0uiPGrlmj2hNo
	 o7dfDP0jY8sgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF639D0C3F;
	Fri, 26 Sep 2025 22:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptr_ring: drop duplicated tail zeroing code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892581176.80352.17113730544408747678.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:30:11 +0000
References: 
 <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
In-Reply-To: 
 <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 01:27:07 -0400 you wrote:
> We have some rather subtle code around zeroing tail entries, minimizing
> cache bouncing.  Let's put it all in one place.
> 
> Doing this also reduces the text size slightly, e.g. for
> drivers/vhost/net.o
>   Before: text: 15,114 bytes
>   After: text: 15,082 bytes
> 
> [...]

Here is the summary with links:
  - [net] ptr_ring: drop duplicated tail zeroing code
    https://git.kernel.org/netdev/net-next/c/4e9510f16218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



