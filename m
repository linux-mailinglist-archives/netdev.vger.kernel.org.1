Return-Path: <netdev+bounces-206391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E16B02D85
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 01:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2984B174F71
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCE522F74E;
	Sat, 12 Jul 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb99/zvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1D218580
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752362384; cv=none; b=lqmMkCuzngDirjkM5gzaOQSi3QkvAODTMKANPMrMknkE4FhiXW0Hc32IayNbPPLprcs52S2lOXabDSaRN7cTAHYT5BGOTBfzEsANxe0/GH8NR6jZI/z4Pox680yYf0wy3+VNrnGkMy6pfgcBwDIilJKgeNOskaO4hgiEgY1EUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752362384; c=relaxed/simple;
	bh=6k6ZJG8y2gjXEtSfgJTNM5qhzsFQ+FXj66vts9y8Elw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m1Y6NmAgN8BGagZcdXK/Jgbd+1JUh+yNwWBziwT3676mfbPCshN/d/Vo4kef73/qgYtQrs5BjwNMxCppd171eo6DmHlJPMVmJAVfpwBjUXeYhPCQ8OQegImLNE4vkcaq8BncEwgonrSiDLCE80QMtotdGUcHSpWsWwpXwhVtX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb99/zvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF22C4CEF1;
	Sat, 12 Jul 2025 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752362384;
	bh=6k6ZJG8y2gjXEtSfgJTNM5qhzsFQ+FXj66vts9y8Elw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vb99/zvFUJeM3+4chi8sCPKL+uj5uInlj2TzzYiCocrE5hHnldOsaLhn8+9W9n6OI
	 La2awvQt4cQ+FsyH/flZPkw3aTD0oiHf+paafI24FmIxtIFs2tpNlepM0MyQJfndod
	 8XtvYq0exQ1Y4XgiZ1B7SAZRIHNgQ5x3IQEIG3aYlRjDefPppwgBanVOmCqBpE6Se1
	 cg5UJVtXV/gSlXE6Tvgq8g1JI49Uk4UiE4ASOiJD4w5ajfKzaUB09psCcOg71RNP4R
	 GQBTCFBWTde8bCdqC5OqO4uROhyKoHfPe0DkW5UUBog8r7swsU7IarI0l0kvGKqgKc
	 DESgjMy9s3HFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B65383B276;
	Sat, 12 Jul 2025 23:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175236240601.2661528.9742901935027710125.git-patchwork-notify@kernel.org>
Date: Sat, 12 Jul 2025 23:20:06 +0000
References: <20250710100942.1274194-1-xmei5@asu.edu>
In-Reply-To: <20250710100942.1274194-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Jul 2025 03:09:42 -0700 you wrote:
> A race condition can occur when 'agg' is modified in qfq_change_agg
> (called during qfq_enqueue) while other threads access it
> concurrently. For example, qfq_dump_class may trigger a NULL
> dereference, and qfq_delete_class may cause a use-after-free.
> 
> This patch addresses the issue by:
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: sch_qfq: Fix race condition on qfq_aggregate
    https://git.kernel.org/netdev/net/c/5e28d5a3f774

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



