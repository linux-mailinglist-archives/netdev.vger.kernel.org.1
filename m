Return-Path: <netdev+bounces-85970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73389D10B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 05:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2AD1C23FDE
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113654900;
	Tue,  9 Apr 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/bPD8qO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45D548EB
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633427; cv=none; b=M6BuYORF28OgxeiRGwnnyWgqwlkW6XOSFuaBY0qoOCfc6UAgIvjoYs309h9YsNkRmebKQRNi88y9yxMkkEnFZSZ9wHMugUFihV+tAUdtP5y+mo+7lw9MpTLYhjMuJgQQNf7c1V5i/dNLb//HZ6l7DxXj1yA+y9dNlkBNaUwdEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633427; c=relaxed/simple;
	bh=Fa1GgTdwxiOWZVJkg84uiPbyNHnuzMlSAOrBDYnlgFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tqmwIhw0afb27Fosc/pu60Dg83KV8UB6DD3aeUEzYc4Nwh35ZB9zKH46UkcsfL9iomOgAssgApKfJWpE49Wq0+2Uk7yMH7eUtoXNcO9iKSf+blI6DEibdxZa6a/RaLRQQukE6ltccLseylLP1LC6+RlZVCQUfChsrE+TajHxF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/bPD8qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72B6BC43330;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633427;
	bh=Fa1GgTdwxiOWZVJkg84uiPbyNHnuzMlSAOrBDYnlgFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u/bPD8qO3oI68xUOprUJgIMg6Nrygd41g3Kf8JxsZ0c4rBjdNzwhYjYpGC9NPTiIU
	 uv5NYuK+lsI8dbIOzx5xDCsg6Jz1imOqNwoyOsGEmLmxCAmOtjAKrpH+No0pvnzLvx
	 KCAdfi1egPYOHRFaWQzNOvNqpSD1RizIfXwkcwA6l3Mu46SAxL8xalTy3s9QerxYbA
	 YF4iLa3WX/Br1Es0pLJaQ1XU+1RO3vXE0vELX3NxIuQ/CtmabDeu5cC0ggpXo3NGId
	 Pz3/CW1zg4x9lZO25GkUW5ysrtXeRHaVW9H0aGtWuP6p2Urrk3Dgk141MGLYP1Bm0v
	 YprA0QkIxzcSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F966C54BD5;
	Tue,  9 Apr 2024 03:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] af_unix: Clear stale u->oob_skb.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171263342737.31710.14440688827391421815.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 03:30:27 +0000
References: <20240405221057.2406-1-kuniyu@amazon.com>
In-Reply-To: <20240405221057.2406-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rao.shoaib@oracle.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 5 Apr 2024 15:10:57 -0700 you wrote:
> syzkaller started to report deadlock of unix_gc_lock after commit
> 4090fa373f0e ("af_unix: Replace garbage collection algorithm."), but
> it just uncovers the bug that has been there since commit 314001f0bf92
> ("af_unix: Add OOB support").
> 
> The repro basically does the following.
> 
> [...]

Here is the summary with links:
  - [v2,net] af_unix: Clear stale u->oob_skb.
    https://git.kernel.org/netdev/net/c/b46f4eaa4f0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



