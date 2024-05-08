Return-Path: <netdev+bounces-94575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532078BFEC4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9541F26739
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818FA7C6C1;
	Wed,  8 May 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz8oSlPv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB107C09F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175032; cv=none; b=TEKSaXydLTJblpygJ8x/P6eR6jOgJOWi/jQEbdyN3Ii9OOZthR6DpewUZR5jPg4DBhAm2eMWms2hHT+AkVZlNlff2FakuUCohOjnUElBXgGo9RZLgxE99ot1fdAoyB6WDBUSQisTI6lrG+ZMItojh3auWf+VI/rsU5EKxmREkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175032; c=relaxed/simple;
	bh=92y71R4tBQoG4Dwu4d1bMd6z5Nt1z6HCvurVLQMoYxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RSJIodxsu2whd8t+Q8BkFfwR9ku9Nw27+JMDtY3or4ZokuXftums6cMdqGVo4RHvRlat7WCfIKaZbsyTX42F2sTtMD4UBpghuiiTJrx2KegG7NMaXE+PnkUaLudAG5X8we8hWe6HA7eBZEeXH8/Y69b3Wk4KJ6+jKKJ4zx5lVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz8oSlPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB553C4AF17;
	Wed,  8 May 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715175031;
	bh=92y71R4tBQoG4Dwu4d1bMd6z5Nt1z6HCvurVLQMoYxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hz8oSlPvxCsuJDWwQ8xgvzndmQi4R1qhA92iimphRlW62ZWO0BT8K2PSZE5NjH6j/
	 JVSXPZvMmHFltxrMcszfeZAenx9JPWe6CABmyeOAqeYZnoTvPfNJIXK2qXIIXaStt3
	 RKQOeZEG0OFRI0l1ctEhLEsajZqRQALVA969Vo2JMb9RdivXHNkFhb+l4CNlCteLDc
	 4OV2YPO48hYJvmri7y5tXO3KJkrSuNBDnD1UxuieTeLICALTA/eJ+uJ6ISp5pLnlzQ
	 L1PQLy8gk7DPK/sHIPNYdnXKFjpEY4qsgWVG+4joepv5WT1a7vsJyqXlKBfqR49h1A
	 FELnj/jDd7LjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF7C0C43331;
	Wed,  8 May 2024 13:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: test_bridge_neigh_suppress.sh: Fix failures
 due to duplicate MAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171517503178.23124.4341235866409463101.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 13:30:31 +0000
References: <20240507113033.1732534-1-idosch@nvidia.com>
In-Reply-To: <20240507113033.1732534-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, razor@blackwall.org, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 7 May 2024 14:30:33 +0300 you wrote:
> When creating the topology for the test, three veth pairs are created in
> the initial network namespace before being moved to one of the network
> namespaces created by the test.
> 
> On systems where systemd-udev uses MACAddressPolicy=persistent (default
> since systemd version 242), this will result in some net devices having
> the same MAC address since they were created with the same name in the
> initial network namespace. In turn, this leads to arping / ndisc6
> failing since packets are dropped by the bridge's loopback filter.
> 
> [...]

Here is the summary with links:
  - [net] selftests: test_bridge_neigh_suppress.sh: Fix failures due to duplicate MAC
    https://git.kernel.org/netdev/net/c/9a169c267e94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



