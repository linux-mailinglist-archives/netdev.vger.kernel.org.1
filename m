Return-Path: <netdev+bounces-249699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E85D1C36C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A47FB300EE65
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93662313E3D;
	Wed, 14 Jan 2026 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evBF4ech"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C725228C
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360415; cv=none; b=Jid0nfLPa7KfRPsakASdx0wOL7Mzj01FpZ9N28Qraon4SkRJktYP9mBVWXizVyCg8n3a7wQCO2z009879BbSFBfZ+cW1UmRMQXK2xag4rur+oQdoF8HxPOTYOn6wRhNvHEUEbzOo3QSuDF84OuuRp1EEBz5gTRJjrClkaGxvGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360415; c=relaxed/simple;
	bh=jOHPouqn622XoWbux8LzVeDbfNcf3EuFozrahtJ3/fA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lp7iX4wij2BbGmmDAaV094gj7aeJpk5ogqbUHdEvspDy2k+2cquTmOeKTd26uzxxR+rMOD2/bLzYO68EYGqSdqh1eTHfeOKRJbrUK9eszVuvrjGeWU9s00mELZ/r9nO2devoEAD4u4RxHEuuDT6ZSpUCiZ0oY0ieLTTAwBTSy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evBF4ech; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA01C116C6;
	Wed, 14 Jan 2026 03:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768360414;
	bh=jOHPouqn622XoWbux8LzVeDbfNcf3EuFozrahtJ3/fA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=evBF4echpjEUh0ilp3HdzluDhq7MY8k3yRvNg88YppssIa+lHDLIwzHZlM5exxftJ
	 fWhKSoQY8avB6s09nwTE4Fe3rokziCG/h9VA6O0TdaGjz59hItkkVzyigoUSs3oZC5
	 Ktr3TOxdx/0JfDfJrc1+4B8N4AzYS82CQFAGTjDOQCg0Z3jnSFXVmGlAg86AAgu9DH
	 ULtthfUUgcFIi4SIuaeiyseofGqOx/f6C6F8HMVTYcbEfrYkjHyoQ6QLDqcEOTt8ZU
	 CaQfIh5DLXqsxqA6bL4y9veyOO8koxbMRKyiS9ziqPaYyymFJffE20uoM6FSXYVqRC
	 I+qB1faHcxIgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BB9A3808200;
	Wed, 14 Jan 2026 03:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Fix use-after-free in inet6_addr_del().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836020805.2567523.17097289084265459734.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:10:08 +0000
References: <20260113010538.2019411-1-kuniyu@google.com>
In-Reply-To: <20260113010538.2019411-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, liuhangbin@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 01:05:08 +0000 you wrote:
> syzbot reported use-after-free of inet6_ifaddr in
> inet6_addr_del(). [0]
> 
> The cited commit accidentally moved ipv6_del_addr() for
> mngtmpaddr before reading its ifp->flags for temporary
> addresses in inet6_addr_del().
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Fix use-after-free in inet6_addr_del().
    https://git.kernel.org/netdev/net/c/ddf96c393a33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



