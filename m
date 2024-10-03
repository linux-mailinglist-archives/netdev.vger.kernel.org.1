Return-Path: <netdev+bounces-131426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED298E7D5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97AD1C22BF1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD9BA41;
	Thu,  3 Oct 2024 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz6aSCbe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422617C98
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916037; cv=none; b=K2HQPes0uNL4DgaPjjUSe8Q7E0YybakSnSGyLrd4k+tpTS4frLeHUD+spza2WByI0S2KuDoGNJtpSTuKDlDuHsmwvF1/w/seo6U6F6ztVivKFxMizVAWII1EEwmgQ+5MsZriyJ9tHAcJF/IW6cKZjKjQQnNb2K2qVESFQYj0TN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916037; c=relaxed/simple;
	bh=GfH2e0j5R1a8uJQy0Fes02MNyx2Mq5bQF3LGPZWV12E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uzy31eFgNnMndT1U5636jFWkc6nQqkwe+3NKWg30A7g8IWThAWtjPxfmsGq41LvK5OfYvGmK5F5gasZaiOqTGbQkhpeF4UZzKWEXv11DxcRoLPNSlwFu8gTI37eS+PcK4GjXd8Wb6IuaBnvTvqEOek42sR+uJzYQ+kZ3s0pXeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz6aSCbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73394C4CEC2;
	Thu,  3 Oct 2024 00:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916036;
	bh=GfH2e0j5R1a8uJQy0Fes02MNyx2Mq5bQF3LGPZWV12E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kz6aSCbeK/SclYoRqT1f/SgBJaEzlFbmdWY4F1IvhIzQXVrbuXM/A7P07Mtg+ncx/
	 +b1zG5uGO5Yl2gVD+STHuBnBE5SsPwPqYmiWrNQsWd8syFBEsQeMlZlNeJlqNgobAO
	 d3pkCvNPHtADHO5fVLzf5i/5xhHnKC9KMYzK2pyH9/JAePdc+XRuaXea3HiNjoEVXg
	 dVHKaTl8pYuBKt+RA1UewDV2Mo+lmW+yJb8NuV2DiS8U99Lo34U3ocBz7qHH+Zr2kS
	 7GTydO3agufiUc8cJRBz+IToDJucMKP0rAPsQR4E0vvkgM8iXtDzYi3S8o5QSgHO7+
	 1G2M/NDGp2XtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8BE380DBD1;
	Thu,  3 Oct 2024 00:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp: do not assume bh is held in
 ppp_channel_bridge_input()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791603949.1387504.5843939967896249330.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:39 +0000
References: <20240927074553.341910-1-edumazet@google.com>
In-Reply-To: <20240927074553.341910-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+bd8d55ee2acd0a71d8ce@syzkaller.appspotmail.com, tparkin@katalix.com,
 jchapman@katalix.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Sep 2024 07:45:53 +0000 you wrote:
> Networking receive path is usually handled from BH handler.
> However, some protocols need to acquire the socket lock, and
> packets might be stored in the socket backlog is the socket was
> owned by a user process.
> 
> In this case, release_sock(), __release_sock(), and sk_backlog_rcv()
> might call the sk->sk_backlog_rcv() handler in process context.
> 
> [...]

Here is the summary with links:
  - [net] ppp: do not assume bh is held in ppp_channel_bridge_input()
    https://git.kernel.org/netdev/net/c/aec7291003df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



