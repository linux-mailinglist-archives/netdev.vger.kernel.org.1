Return-Path: <netdev+bounces-153201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5C9F7281
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E983188AD74
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87117770E2;
	Thu, 19 Dec 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXMOfoh7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244B3FD1
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734574215; cv=none; b=iEzd/LZACiRvGUpYas1foRTd7DsBcAtdKZqFWKD5g+HBBHpCXPtZ8Xb9TVvJzTQDP52dIqSTQlsnJApoj7tV1LkgpRPh2aTZucJvaN6swl5iTUUUCNvlg7Ys6e4xpk2Atp3YStajP25XqwOya8W7DDavRItXh1Xo6Ez3bkviSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734574215; c=relaxed/simple;
	bh=uBtFwB9qs5M8PfjgNB1GkeUh3D+RYmw8wRXBnf8fvNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qGcwBo9H0GnsCgcWiV5hZq+RK/K6pAfNjge604mg838aH/j9hW6x3reCnj8vfTd2E3PMV+rD0vN4+pOLvpBfDqXpa1asDTkcFBiH5bLJOW1F+g/fKmwdFEIXsMHS4Wtfuvfy0Ie47f62NOOIXxEYVxs9vmpU6CfKOv1Hf1xkpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXMOfoh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF12C4CECD;
	Thu, 19 Dec 2024 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734574214;
	bh=uBtFwB9qs5M8PfjgNB1GkeUh3D+RYmw8wRXBnf8fvNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EXMOfoh7rb6hB95EDVqsD38UJfXymeAMVr/R2okz8GUQoKuPu3/1eMhWdl1ErWOkK
	 jPv2hWOkkoeeroYFNdm9OCYzuOEglQ+Nl9wLLfaaacxrnbgfYrqHsJcHrixn72boC0
	 oth6Js0RoirWutvqzfgWBl1wY/4WRd6pB/n73pzG6HFvvJX583+xvPVTUrAtkKZUjP
	 /0ZK/QRsOCAo5x5TTQlP4A+ahkBxVVPtCrXVI8cEsAdsInDQBk8mWA5HkkHzcEe2fX
	 lk3cjafayjA/z+x0rkdLSCZocTF9eNLg/1XlHw4YyImIrlG2b41ouyYOwxhLjyqDRp
	 NiU5XAGfH+W4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE55E3805DB1;
	Thu, 19 Dec 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptr_ring: do not block hard interrupts in
 ptr_ring_resize_multiple()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457423152.1793000.3704693558599997628.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 02:10:31 +0000
References: <20241217135121.326370-1-edumazet@google.com>
In-Reply-To: <20241217135121.326370-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com, jasowang@redhat.com,
 mst@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 13:51:21 +0000 you wrote:
> Jakub added a lockdep_assert_no_hardirq() check in __page_pool_put_page()
> to increase test coverage.
> 
> syzbot found a splat caused by hard irq blocking in
> ptr_ring_resize_multiple() [1]
> 
> As current users of ptr_ring_resize_multiple() do not require
> hard irqs being masked, replace it to only block BH.
> 
> [...]

Here is the summary with links:
  - [net-next] ptr_ring: do not block hard interrupts in ptr_ring_resize_multiple()
    https://git.kernel.org/netdev/net-next/c/a126061c80d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



