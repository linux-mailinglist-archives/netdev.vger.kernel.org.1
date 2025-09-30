Return-Path: <netdev+bounces-227244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10484BAADCA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8FD3B6176
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63331E3769;
	Tue, 30 Sep 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG2cGJQN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234D1E2307
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195256; cv=none; b=Xey4nLK9DmBJceJ3qI54jiCxX5TS6J+un7b9hYOuJbzhArOMphgzR+uc2Tqq6JCqosaFBW+RDEYdqg3p7tgKLDGrgk15xelVTtxDz9MDO8Kc/SWzrxkiiUy3qS2uZgiqtQ1qW3mcGe0EAVERw3q9Av7TE+wASQgW/02+CH3R/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195256; c=relaxed/simple;
	bh=ftV/ueZUiqyECZ1vZAaNKIfAIS84y8EfGkSk+VSsDM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X5I07+kV+xCVXYacIfJ3v54mmTTSafSaB5H1WU1ePPSxw+mrigGjlPRoOnNSQV4jWZkFKCUrlrv0N2zOppe31DRpIztjOaxkfuS+x/eOp3zRD8bxK+XJAZ3BaWsDHowSL/Tdhi3jXqNKOMZqhjx6I2V93GhYr3aZOEdd7l+d3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG2cGJQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01481C116C6;
	Tue, 30 Sep 2025 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195256;
	bh=ftV/ueZUiqyECZ1vZAaNKIfAIS84y8EfGkSk+VSsDM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GG2cGJQNWcYJBZUSrhKshb38FUDiPzeflL30tkk9GnRmty2g5IH/3bGI2XqW6MgtH
	 NqgVeDAA27fxVXVishcz0UabeB20pj1/tUAnuULrNSxO8FAxLA/NUBhAX6h8hKc36l
	 9BDPz1iEvm6GfURfHq8rw4nK6tyxc/328BVWrMyQ4Mx97TT1OcqlyjekukLQAA3uD8
	 NhbeULHkEcGjRmsqos4iSepiqjY3fKyroLZyRUBjQg8JjJhkynPHCvJTDGFYPYQ6JJ
	 krO4JDmx0gDStnb1UtxwXXLVNKovJJ478sum0gNf6z6+bMCIo8DbCv979Ytf8M9Lfp
	 VdZ1jtSyTnM0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9F39D0C1A;
	Tue, 30 Sep 2025 01:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] scm: use masked_user_access_begin() in
 put_cmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919524924.1775912.12413588605500909970.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:49 +0000
References: <20250925224914.3590290-1-edumazet@google.com>
In-Reply-To: <20250925224914.3590290-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 22:49:14 +0000 you wrote:
> Use the greatest and latest uaccess construct to get an optimal code.
> 
> Before :
> 
> 	lea    (%r9,%rcx,1),%r10
> 	movabs $<USER_PTR_MAX>,%r11
> 	mov    $0xfffffff2,%eax
> 	cmp    %rcx,%r10
> 	jb     ffffffff81cdc312 <put_cmsg+0x152>
> 	cmp    %r11,%r10
> 	ja     ffffffff81cdc312 <put_cmsg+0x152>
> 	stac
> 	lfence
> 	mov    %r9,(%rcx)
> 
> [...]

Here is the summary with links:
  - [net-next] scm: use masked_user_access_begin() in put_cmsg()
    https://git.kernel.org/netdev/net-next/c/2b235765e9d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



