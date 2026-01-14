Return-Path: <netdev+bounces-249933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1CED20F63
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DE2E300CB4E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5FC3033ED;
	Wed, 14 Jan 2026 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnQmk6tW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3702FD68D
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417422; cv=none; b=Xf4NIP9xziq/31X+CVty14DjhEkKqvGZnSUZNmekiMt/gjiN7XV7n6v9d8DmwZRc9kLOkqBkrrWufDunF0zgbT3q9y7dKHMLjXUpevZJHWPYLzHAj/NWf2fPUXwPqVDols76WOUmRw9CZsZEQ3mk1LFWGOw+oHk8AeRKurOpvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417422; c=relaxed/simple;
	bh=nzILRIDnMVs7teAJbzhmBDuy84tqzfW9+ZyIw2t/VDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IxGYlA7UnUJzaszbUaoUCLsldzZHhbcDBsOv9yFiupb7J6cSFuZoce1kS+wNvW4TsWPRhCv3RsywhyNiyyjqDW/Cus8XO9PNk/ddhbfhBuIKSBZ2yiP+aEFoyk99Rj0pAEZn8/9rCuXwcsw0UHDsfUGU212QWD1cuBKJsWaQBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnQmk6tW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8411DC4CEF7;
	Wed, 14 Jan 2026 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768417422;
	bh=nzILRIDnMVs7teAJbzhmBDuy84tqzfW9+ZyIw2t/VDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MnQmk6tWJlHmbxMu9pE7Ht0H//pb02UuB2cXxQN5KyISFiBLz17+r1YzaOuasCRc7
	 VtnYoSE/Ike00jH9v+feWxMiSzDX/FI53qWqNTssr/DMXAJareiiDMXNzRzTIFrAc5
	 LhOuBQSMjg+8kgMxbF61Sa7/ZPzuX7vAtcTd5sc6sE7Efbjna/1+Mm6ix+d0rBBmpt
	 G3jR91Dc1d64WD7UiglDzESgtvOVCWxJ+MzLH2ayrkT++Cr3rAICreHad5bOrdj/Mq
	 AE1hxsHZoDFm6HTogp/eCnULNUiiFZyq0YQbofUbYi+KE2aFmaIfFxEs6V3DaaQ8rQ
	 nzzviIYmexyzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789D53809A2A;
	Wed, 14 Jan 2026 19:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ip/iplink: fix off-by-one KIND length in
 modify()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176841721529.3282087.11570218416437244921.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 19:00:15 +0000
References: <20260113114127.36386-1-jvaclav@redhat.com>
In-Reply-To: <20260113114127.36386-1-jvaclav@redhat.com>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, fge@redhat.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 13 Jan 2026 12:41:27 +0100 you wrote:
> The expected size for IFLA_INFO_KIND in kernel is strlen(kind) + 1.
> See `size` in rtnl_link_get_size() in net/core/rtnetlink.c.
> 
> Fixes: 1d93483985f0 ("iplink: use netlink for link configuration")
> Reported-by: Gris Ge <fge@redhat.com>
> Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
> 
> [...]

Here is the summary with links:
  - [iproute2] ip/iplink: fix off-by-one KIND length in modify()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=683815ed61ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



