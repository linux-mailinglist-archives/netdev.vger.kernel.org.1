Return-Path: <netdev+bounces-109096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B801C926D9E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D3B22AD0
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D154F179A8;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc3BL8Ux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801617557;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061431; cv=none; b=c3jgp/sBVfwlZO+IHpFGEzCxSZ8WerMdMJoZMQKzNUc8QUXedDpepFYTbFLKy/2u0BDIxgPmZFgALsxp4WKSgY4hHyZrJZ2PUgzYWXJ8d68f1J6YcVf/d0RmqzrN67c9NS/C3QzZC4y9+j/K/4utq7mLEKtp2ycfmGuAEcJi+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061431; c=relaxed/simple;
	bh=lZUr2FIuhYbAvhUxzfrFPdLamcX6KK3sbZyj5NsYEgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cRDC83R5rseVKLqsq6FAyvydCN1sr/vCkL2gz/yZcEPAnwRnVPpL5i45Dzh6WCzNswOzruH/a/zN/mlZWhpQFFN79TtWJt9KcMNRQ+GZb1jdF64nepOPkxuAMjjSp0hISCNyplF63uUowN2goq/RcnhTABwGZVvMnmuJBdVTkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc3BL8Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 364DAC4AF07;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720061431;
	bh=lZUr2FIuhYbAvhUxzfrFPdLamcX6KK3sbZyj5NsYEgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xc3BL8UxxBoY5OG8pFu8G9+WMUDJGQBvXnxIMn3OIK0aSJqoESOMK5/F8bWSCwWyA
	 Mq+faLFauEYyM/I7+1FcHkIzfH4Bns9iM+GYAgHXrYuLYaVKI1B8p+Awh89fFKvABZ
	 hG3sg+L25QUTUeLXM5kXZV7OQO4dsb8VzYgSuAnfJlwDMW6l2lzLLWTEA6h7R5spBm
	 1jbAU/kDs6rkuVHbRI+4SmdXcq8RiEIhxrmuCLbkFcvU9m4zbMHfLooyjf/4hLlWSa
	 nKv6yXtoL+7k0N1P1CDDL5edIpFquup6QAJ0SJv45nb6iNFP5TOSUIwHgPn+Nj+jzY
	 Ll8r7nqzmxNzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 223DBC43614;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] af_unix: Fix uninit-value in __unix_walk_scc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006143113.17004.7669070239744050939.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:50:31 +0000
References: <20240702160428.10153-1-syoshida@redhat.com>
In-Reply-To: <20240702160428.10153-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jul 2024 01:04:27 +0900 you wrote:
> KMSAN reported uninit-value access in __unix_walk_scc() [1].
> 
> In the list_for_each_entry_reverse() loop, when the vertex's index
> equals it's scc_index, the loop uses the variable vertex as a
> temporary variable that points to a vertex in scc. And when the loop
> is finished, the variable vertex points to the list head, in this case
> scc, which is a local variable on the stack (more precisely, it's not
> even scc and might underflow the call stack of __unix_walk_scc():
> container_of(&scc, struct unix_vertex, scc_entry)).
> 
> [...]

Here is the summary with links:
  - [net,1/2] af_unix: Fix uninit-value in __unix_walk_scc()
    https://git.kernel.org/netdev/net/c/927fa5b3e4f5
  - [net,2/2] selftest: af_unix: Add test case for backtrack after finalising SCC.
    https://git.kernel.org/netdev/net/c/2a79651bf2fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



