Return-Path: <netdev+bounces-213535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C8B2586D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180EC5A26E3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961844C63;
	Thu, 14 Aug 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXtchryM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A365513C8FF
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131997; cv=none; b=lm1jeaVjQuyA8s/4n1SiHBn0In3RVhL9XbEXXCgu962+0UOrxlCeJWw0XiT/QmCPBI+gbZPfg17pofy9M+QXBIgWTkWFz6MIIu+7L8kGC6L4Ix+APRhd9XI4zUpr9jWPtsNjmZaYmL5Lio3Zl+P8zNwD8/3XnMvDAunzes0V2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131997; c=relaxed/simple;
	bh=9iq/bF+YMiKIYhNHilGasMvzyfJFqe6GU5i4xQhWdB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BB81qB6rhDYK2jUKwIqdGqhCElkiZ3bAeQ+NLSWOYJbupHDmRUdjRmkrbZ4xB6GC2TCpZcA/nVi4BFUsatlQJ/KLKFxiENpSWYo6FFB9A/bIsYaf6ycjJtTIWDe/XRvEgKhhNUtxtsOhChU47xi2vmAu+pDP3kB5WVj71zOzWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXtchryM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23408C4CEED;
	Thu, 14 Aug 2025 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755131997;
	bh=9iq/bF+YMiKIYhNHilGasMvzyfJFqe6GU5i4xQhWdB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXtchryMfXQHshEcqU0oLKdCNtRWXQyHkXdy10JYfGo8g+r/OefDRwCy/f9DjR6Ao
	 4/J8cZS658cfIB99j8mthADWYRuTKnVa/aFlZPceOgbDb/IZWsa3aFMDoXndTzURRU
	 dxfpjzGgFlciYa5E8Qyru/xF8vuw31Arlosq3NZZkfuhK5D3pZ6kslatKfBoQbeGP0
	 5xI0vrgvCow4+qabEowTNjKrnm28COUQQXbgw75ut78MV/Ph1vv8W54o75RN6N48SI
	 g1HJxOdKvmQi7tcYT0v39cUtPbOSwqvtypgHySMCzR4NEyyMOUCt/2i4MtHBouHrL3
	 dflWzhlHXT+1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF239D0C37;
	Thu, 14 Aug 2025 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] netdevsim: Fix wild pointer access in
 nsim_queue_free().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513200874.3832372.5771149734300875391.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:40:08 +0000
References: <20250812162130.4129322-1-kuniyu@google.com>
In-Reply-To: <20250812162130.4129322-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 16:21:26 +0000 you wrote:
> syzbot reported the splat below. [0]
> 
> When nsim_queue_uninit() is called from nsim_init_netdevsim(),
> register_netdevice() has not been called, thus dev->dstats has
> not been allocated.
> 
> Let's not call dev_dstats_rx_dropped_add() in such a case.
> 
> [...]

Here is the summary with links:
  - [v2,net] netdevsim: Fix wild pointer access in nsim_queue_free().
    https://git.kernel.org/netdev/net/c/b2cafefaf047

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



