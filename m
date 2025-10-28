Return-Path: <netdev+bounces-233359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D634FC127E6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08CA4EACBC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39741DEFE8;
	Tue, 28 Oct 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/WDPO0C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C61B3923;
	Tue, 28 Oct 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613838; cv=none; b=bYCESCcPzKPQCx6mFeDjSajKvIrr2kTxS0ZjGcaZcngnWSKtndimJ7c3HmLi9TfPQWvM7do3V6bvu0KiiCS/24VDY6CRo1qqnyJraHlHm6UCrVZ05LOe9cz30Oxd7whckjcXH4tFlIoU2XodBtQy8Ow1ypFylRO3U6JO52mwpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613838; c=relaxed/simple;
	bh=SeBA5WRNw0Gv8YAhRx2Kb+5RI7p8fUc2j6qLJWcs320=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y//cZmtjMr5ygcf8PNgSPihBcy/TqFFwNkeh4x++cPoKgUleBE9xLOC56i5ABnQbj0UuzMsNwqcLq/cmC5ql1pJzYWzeyRtHPzqisbezweZ6lZdV4vIPk/QojEyk61hU1nNWIQxoII5D3RbVVRloVIn7OGMyM0Pd01DIEVfJjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/WDPO0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258A9C4CEF1;
	Tue, 28 Oct 2025 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761613837;
	bh=SeBA5WRNw0Gv8YAhRx2Kb+5RI7p8fUc2j6qLJWcs320=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u/WDPO0COiCY4bvX5O9QpJyVMeFgeMaSQTdhzTGwckpTEd6asWGWGrTkAzC+Bswkq
	 PnwKYJ540JdKRpchUaNx+aBwJaIXFaZ5A6yy6q2ATVcxFJgOtH08qAcB3iuLmbQkKS
	 +CFnD5cvx7BwPD8mmdRi9vb1XIypap7/taWSaW9mThQKc/rjRUpRU5unC/ftwxsCNt
	 tszWkkBK+hr0kvNSUJ3sWoggCpVBz7teJZgq/77Gd/6THf1kI0I3OtqJNwdE2tQbCV
	 ObcP02NIfsGt27l08e+QDbl2sAQf8/qJfZSBeFbRu7fFShtcKMTyyF4frhT0+uPw6t
	 5ucmGiZkt8FWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8C39D60B9;
	Tue, 28 Oct 2025 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: bridge: Flush multicast groups when
 snooping is disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161381524.1648894.2633054895735715691.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:10:15 +0000
References: 
 <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
In-Reply-To: 
 <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 idosch@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 16:45:37 +0200 you wrote:
> When forwarding multicast packets, the bridge takes MDB into account when
> IGMP / MLD snooping is enabled. Currently, when snooping is disabled, the
> MDB is retained, even though it is not used anymore.
> 
> At the same time, during the time that snooping is disabled, the IGMP / MLD
> control packets are obviously ignored, and after the snooping is reenabled,
> the administrator has to assume it is out of sync. In particular, missed
> join and leave messages would lead to traffic being forwarded to wrong
> interfaces.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: bridge: Flush multicast groups when snooping is disabled
    https://git.kernel.org/netdev/net-next/c/68800bbf583f
  - [net-next,2/2] selftests: bridge_mdb: Add a test for MDB flush on snooping disable
    https://git.kernel.org/netdev/net-next/c/d10920607ffe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



