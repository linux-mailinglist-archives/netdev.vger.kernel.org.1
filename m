Return-Path: <netdev+bounces-157657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFCCA0B26B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839BF3A59CB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0C239787;
	Mon, 13 Jan 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKAwsPBt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80D23874D;
	Mon, 13 Jan 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759410; cv=none; b=XMwxes+tW/jtFrw4WyZvMd4vrSVdKdYazQZ8n8YgJ0CBstoxlBadGLjBJ83wJ96NGZhfbNu+mxDpB8acRAXaUjrTqkwgTgK7/jWuljXiJSnbUQ9JjgwlONCP3kS0oEzKDt+Dnh6c1bONyYygO9FLuOgLsajSEE+wFIiqUJFbUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759410; c=relaxed/simple;
	bh=9Aa1qPmlin2WfecpMS1NoRkzYNdA7miPSI+lNJlumUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fxhGVMVwL84IE8NHXlpTKMXqRXNZp1CiNnG08NKh84SIx6M/bo3yyROpoSa/hNLaQvWqV9d8BgD33N3/UF2KhlZhGRFXTyoOBf8yV0N8roz4W9g6dw3navF83mlM+chaJ9ADcgAH+vfDk2XLmIuxkH4y3VfWnCWDmmHKGf+VS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKAwsPBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D355C4CED6;
	Mon, 13 Jan 2025 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736759410;
	bh=9Aa1qPmlin2WfecpMS1NoRkzYNdA7miPSI+lNJlumUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KKAwsPBt6fSORKobBqiGpHGF0iTiYCbP0G44cXlDEczdsk4yDy0jrnH7ir3Cc+K/o
	 mwjAp2QJtD2R8rK626UtrqzVoJhFrvBnt4trbBi8MKUqrl3kNKtmxlM42qxgU/16ai
	 iStO8kVnswfgtju+nFbOMu9txXyFtE8ywMMN3+X+hpkzJ8X6F/93zx7HMaBCA7W94S
	 NpCqZWGdVkn0AabiRXKTYac1v6akoAaVDyRq8+srnBN8K4ThSK5XOr0s8fOLRWOnN5
	 Me0i5ssIj4Q37McCZXrq9uylY9BYMJKpJPgG+/uVDvuzQpinB8aAc/ji/fmyFvxK3L
	 BYlC2MGE0Pdpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFA380AA61;
	Mon, 13 Jan 2025 09:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] pktgen: Avoid out-of-bounds access in get_imix_entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173675943251.3415908.7564815246317322659.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jan 2025 09:10:32 +0000
References: <20250109083039.14004-1-pchelkin@ispras.ru>
In-Reply-To: <20250109083039.14004-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, artem.chernyshev@red-soft.ru,
 richardsonnick@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  9 Jan 2025 11:30:39 +0300 you wrote:
> From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> 
> Passing a sufficient amount of imix entries leads to invalid access to the
> pkt_dev->imix_entries array because of the incorrect boundary check.
> 
> UBSAN: array-index-out-of-bounds in net/core/pktgen.c:874:24
> index 20 is out of range for type 'imix_pkt [20]'
> CPU: 2 PID: 1210 Comm: bash Not tainted 6.10.0-rc1 #121
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
> <TASK>
> dump_stack_lvl lib/dump_stack.c:117
> __ubsan_handle_out_of_bounds lib/ubsan.c:429
> get_imix_entries net/core/pktgen.c:874
> pktgen_if_write net/core/pktgen.c:1063
> pde_write fs/proc/inode.c:334
> proc_reg_write fs/proc/inode.c:346
> vfs_write fs/read_write.c:593
> ksys_write fs/read_write.c:644
> do_syscall_64 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe arch/x86/entry/entry_64.S:130
> 
> [...]

Here is the summary with links:
  - [net,v2] pktgen: Avoid out-of-bounds access in get_imix_entries
    https://git.kernel.org/netdev/net/c/76201b597976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



