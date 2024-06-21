Return-Path: <netdev+bounces-105669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B4912331
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6671A1F231CB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C1171648;
	Fri, 21 Jun 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psQ1SRtH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD212D771
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968828; cv=none; b=Xr5dWBVSV+SMdx/V4JvfO69jiLkpFzqDFMmUu72aPgBWkguFqJks3vHzzEqvPnG/+PVZTAR0g7/G+GgJcsMhc0M0Qjf6EeiooZZaDW3doaC/DMrQy8c1CbmighzZxWXq4Qtr04IwMqzxTlsyjPbcvz9q7hQ1WCngWQfJymEC0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968828; c=relaxed/simple;
	bh=CnNF2D2oVplA0A/mIiBJQ7Udb893XUm/Hj0gZiq/s5k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UhxhmI+DxKYqK8X8CslS8ALWpUUehUmJVDgGLX4X4U6ZJtSC95bb6dAlo9BDSv9F2ygiRA9BRXpDk65L16qAhhN9OIwMFnw0QI89ZxCKMxllYg5H1Los2w0roUy5kqECOMv7EdwJ8UzsNC9MiQHqj3e6WVdLYTMeCpBJHZ+D+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psQ1SRtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB4A3C3277B;
	Fri, 21 Jun 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718968827;
	bh=CnNF2D2oVplA0A/mIiBJQ7Udb893XUm/Hj0gZiq/s5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=psQ1SRtHiCBgBby632LiXUi8Hc2uVIDuqIL95+UCUfY4YeqSmS6OXKPP9o3qZwOdO
	 ja1lTUUghbzGa+UQpKq2nXgJ4kugl5SmMEMi6jbc3locS2IrBh33H0MlEbql/kPZHv
	 1z/EO6yGheQWSr/53R2/sjIiSnUxFu1WBIIXcBX8yRGGPJCfT+Y+K6EU6khTf+zgFj
	 ERX2tdqhPcBZWg57VPO/pH3cMm6hs4yt3A8Gv+yahhV0J/4NfFOVqMDVyrwErVoBUZ
	 YY1U63RrSd2ztwHbHiv8dXjs+A0sTBCkOIn2Rt1eDjbRamQK29XDuJ+ussz2Z3OqTM
	 e6JseJOKC5jSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDA8ECF3B9A;
	Fri, 21 Jun 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add softirq safety to netdev_rename_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896882777.29143.5981157285009773585.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 11:20:27 +0000
References: <20240620133119.1135480-1-edumazet@google.com>
In-Reply-To: <20240620133119.1135480-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 13:31:19 +0000 you wrote:
> syzbot reported a lockdep violation involving bridge driver [1]
> 
> Make sure netdev_rename_lock is softirq safe to fix this issue.
> 
> [1]
> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> 6.10.0-rc2-syzkaller-00249-gbe27b8965297 #0 Not tainted
> 
> [...]

Here is the summary with links:
  - [net] net: add softirq safety to netdev_rename_lock
    https://git.kernel.org/netdev/net/c/62e58ddb1465

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



