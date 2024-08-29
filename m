Return-Path: <netdev+bounces-123002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59119636CD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C7BB23817
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58365C8E9;
	Thu, 29 Aug 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG1hZYK+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31638DDA0;
	Thu, 29 Aug 2024 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890840; cv=none; b=GBo9PfOjXI7/52+0HHtR1xLquVe4uFia8gjYHkUSixNmb0j0GI6RLnin/acta3A2KNmn6qF130VpfjTER5JkPAIoRVDWmVwVgAnpTRcdZgLcYc16ICKewqjqt6VCbRTKzrhPpljbcYNoy5rZuUnhtaxVU01JFHP01hlblqJadQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890840; c=relaxed/simple;
	bh=eBdRKI+jWY2+i6cFgW77TOP+7WLPwhi0XxTqy7tOYoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YsSWEzIAwsFlbCKzxkXfxYZce80mr8NeVpmskFsuYJmqJPY92NddA0XJAf30GFVkcmq0i5DaXko8GG54s/bEtNyh6zGSZozi4F4QMySn8aBuGc+nhgcwSXL/o0YFe6lwJ84JAb72XQ9w8k4NDWk5QjpDyLbDAvhQPgCTd/QbbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG1hZYK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42F1C4CEC4;
	Thu, 29 Aug 2024 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724890839;
	bh=eBdRKI+jWY2+i6cFgW77TOP+7WLPwhi0XxTqy7tOYoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sG1hZYK+1QTmNn/xbvTl/6TmcYKrlLn8u9HAdFHg1HqiuxyU94OLWvTBxmNM0eqoW
	 DnNYMXacQ4k0o/Ws4OGIWghS/JNfQ+Qo/CKJhMG5xzdyLjqDVX79Ni8DyFswA4+UiS
	 Eky6Rl3d7QF1ctg0XH4RWHmvmdMwbzq3KB9PuiP/bynIJ47CcjvLo5IgKlPYv17jRG
	 kI5y1tvcY9shy+rurvFuA3ns9a6f3KTMd2LC3Sb/C4+93bJUhrvRvl81WgbTiyso4K
	 xHhSqjdLjP9L0dZxNkbLSOEiJ+qVLgpsf2MKrmC/kMM2kahN7iIrU4ixvlifr2UK2k
	 N2cE+9qfsB+mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB73809A80;
	Thu, 29 Aug 2024 00:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/xen-netback: prevent UAF in xenvif_flush_hash()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489083974.1473828.6183768950292270791.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 00:20:39 +0000
References: <20240822181109.2577354-1-aha310510@gmail.com>
In-Reply-To: <20240822181109.2577354-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: wei.liu@kernel.org, paul@xen.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 madhuparnabhowmik04@gmail.com, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 03:11:09 +0900 you wrote:
> During the list_for_each_entry_rcu iteration call of xenvif_flush_hash,
> kfree_rcu does not exist inside the rcu read critical section, so if
> kfree_rcu is called when the rcu grace period ends during the iteration,
> UAF occurs when accessing head->next after the entry becomes free.
> 
> Therefore, to solve this, you need to change it to list_for_each_entry_safe.
> 
> [...]

Here is the summary with links:
  - [net] net/xen-netback: prevent UAF in xenvif_flush_hash()
    https://git.kernel.org/netdev/net-next/c/0fa5e94a1811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



