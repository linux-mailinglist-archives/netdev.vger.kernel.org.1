Return-Path: <netdev+bounces-246810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D03CF141B
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 20:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDF73027CFD
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB0314D37;
	Sun,  4 Jan 2026 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPPhGhXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F13314D34
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767554177; cv=none; b=TpWn4pQrh0EIhm1tQwEpReMBY0S3MgzdOwwBduLUvd5WvzAAOJ5/H83D3D3NPjMg5gpfzKoSmqktGj2MDYgGCY9I/TNIcsUxA1d6UgYoSk/pwXia9kOmqYhGMwxinD8bLU4Acw2kk6gugYvknlPi3scM1eQCWoMPpgKw/MjOJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767554177; c=relaxed/simple;
	bh=k+tc4nffR00HT68m/7sTXfEtZbKF4OLenMt8jnrPKeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S9T7KvNh0IPFr2/ZU28GuoPCldYi3SH0Eixu8A9Fb+YjDwZfCLpRQykU9FksEfKXiR+zFF1ptqtC0O+Vnpv0HLyqAoQM29lad7Ozg7gQYGXntqggNlZY/925vCsKqxemcy6gEtFoX7eQtvM0nfObNIMOzHncXxwnetzbaVrINq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPPhGhXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65E9C4CEF7;
	Sun,  4 Jan 2026 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767554176;
	bh=k+tc4nffR00HT68m/7sTXfEtZbKF4OLenMt8jnrPKeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VPPhGhXoNubahzqS+fLe+w8NtEhOw1zY3siOdE0I3HsOOnH5DZ7ssGwZEABeOgsKv
	 HOXuJy1Qhw2ImvwKmI06fDI0eqRSxSQhCRGg0WwgDLRm5MSHoy4vKj6YXqZ1DKwdvd
	 /HWJLOtZGlHH1IajCpg+Qs8kBlEIfAuzsUpMtsZG33lIURSejb0aHhz0gTeqzN87lv
	 eYoRs+7HmSfMAmvMzFbQ4K8sHct975UYw/1kT/ZIoHBqiqi9ATTvSAM6IXFK2pW0eC
	 o7z6GgegApff6bNRgpB6Ipjv027Y0y7fVbxhoIZTwBbyMPPGwP3rkhF+B9ifKY/66s
	 xk9DeSvyng7SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F299D380AA4F;
	Sun,  4 Jan 2026 19:12:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/ena: fix missing lock when update devlink params
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755397552.149133.10266412473839626438.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 19:12:55 +0000
References: <20251231145808.6103-1-xiliang@redhat.com>
In-Reply-To: <20251231145808.6103-1-xiliang@redhat.com>
To: Xiao Liang <xiliang@redhat.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
 saeedb@amazon.com, jiri@resnulli.us, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Dec 2025 22:58:08 +0800 you wrote:
> From: Frank Liang <xiliang@redhat.com>
> 
> Fix assert lock warning while calling devl_param_driverinit_value_set()
> in ena.
> 
> WARNING: net/devlink/core.c:261 at devl_assert_locked+0x62/0x90, CPU#0: kworker/0:0/9
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.19.0-rc2+ #1 PREEMPT(lazy)
> Hardware name: Amazon EC2 m8i-flex.4xlarge/, BIOS 1.0 10/16/2017
> Workqueue: events work_for_cpu_fn
> RIP: 0010:devl_assert_locked+0x62/0x90
> 
> [...]

Here is the summary with links:
  - [v3] net/ena: fix missing lock when update devlink params
    https://git.kernel.org/netdev/net/c/8da901ffe497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



