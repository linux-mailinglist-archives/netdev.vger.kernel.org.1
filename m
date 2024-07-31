Return-Path: <netdev+bounces-114363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20E942460
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5BF1C231F7
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8733B12B63;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag3Qi5mS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595FC101EE;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391235; cv=none; b=qZrt1qANXcxx+XcDyWoNMxZyVnSTMEWv9Eav6Ol8uMKr9z8G/qpl7p1B2QCbEQJHe6hG/vQ/oNnmfkEQ0JAP2THurr6i+vfbTgmw3GoPtRFTyGXxD4XjIWPIgj7ltm13jfxZy0hkIXGIwPEgVRvTSmTCndoJb1noy8T+qCstcKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391235; c=relaxed/simple;
	bh=sdz++PZ6RZ23VmIE/Z+Z64A5WI/0VoJIYJRyBM+f5pU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItQ3bKUu5X4uNAoJhtLt1h30MTN8iGjAxETibVo9PQ+JHvP9rjJ7I4GyEYoG3VwlvEWabSXoYUIGDHM9N9fCNQAfhyvT3Mus4b1+fknlLEnSxeo3pDWMnEJozcY9oz3wPHF/79sVYYoqrfSSg2PO0cLi+vlRmM2EWQB2Jzd8UL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag3Qi5mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BA11C4AF18;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722391235;
	bh=sdz++PZ6RZ23VmIE/Z+Z64A5WI/0VoJIYJRyBM+f5pU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ag3Qi5mSFoFAcbeFNgKczshNVXb88OAEvsu5nwRcTBh86eiIiYz99kVA0HonuU7oJ
	 8nzUZd2reXACfqxH2gN4nl4qMisWysb3/wTjIhA2vwxj6GgJSOIrvX96xT1AjzCk1U
	 XE1mn9ehfiBnyUrae6zv9I10Kxu1Amhl0pKCQ6mdPU+jl0TsDyIkNbhHASgj+jsyP4
	 duYNT7xJcORkRi5F1QsMQBJ5PK9QBGH0HOpS1PqWcTM57ohBN1yJTgXtr9UEUpNexQ
	 /nFuHVmfa11hSIPbstCkJ5GuIC3dbgiHO0AX7Jcy3p/cokRjC6s1V30YqOS229drJ4
	 mBb8+4vvqNcag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F26B1C6E39C;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: wangxun: use net_prefetch to simplify logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172239123498.15322.8541759926396935716.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 02:00:34 +0000
References: <20240729152651.258713-1-jdamato@fastly.com>
In-Reply-To: <20240729152651.258713-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 duanqiangwen@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jul 2024 15:26:47 +0000 you wrote:
> Use net_prefetch to remove #ifdef and simplify prefetch logic. This
> follows the pattern introduced in a previous commit f468f21b7af0 ("net:
> Take common prefetch code structure into a function"), which replaced
> the same logic in all existing drivers at that time.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: wangxun: use net_prefetch to simplify logic
    https://git.kernel.org/netdev/net-next/c/e832bc9e818c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



