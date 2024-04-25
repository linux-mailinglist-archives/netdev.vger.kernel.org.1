Return-Path: <netdev+bounces-91376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF28B25AB
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050E4B2557D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CE14BFA3;
	Thu, 25 Apr 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyxnrUCP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAD14B084
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060228; cv=none; b=q7hBQ9pK8kLYzhEbw5lPu9VsdXaP8+VfeTnKjqWLODx2snQLdPNWDQwITF4Q912n9zdiieY2DuWks7cpeOhMVn9K9DtDvBAdIeq4pEuRKcwm2+v/9+Vgi5D0GUjwn74tYsBEJacmWCbkpisEtSHobfFabKvo/0gpU2HkPixtSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060228; c=relaxed/simple;
	bh=V2UgF04EV4cy7R5SRKZ+wVV1SG6GzJT/cLT5ErNIZt0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QFkU3T70xkLoE5/XmRdxvE5k4bOypXRrgMyRsGTfpv0i/JJZxNIwyNyxWibZHeleJI24PRKSl36rvajFyuKYPskyUBY4WJwSj6WEZnQMJbG7vNkjVfxLD49BTqmcwt89wG2vn90zx5TOtp7q2VANvsNil8oOV5vt5uN6uWKt/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyxnrUCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F833C2BD10;
	Thu, 25 Apr 2024 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060228;
	bh=V2UgF04EV4cy7R5SRKZ+wVV1SG6GzJT/cLT5ErNIZt0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jyxnrUCPuxkbZwiIrtKqSU6oS88IPycIMcKA83xHWHBPAJ6CDPBeYZiVQMUJ3UzSE
	 QnligXpQJ2wMsFhalMd7PZn7GtF8NTPD6BJKpvhLz7GJce6ovM3gqK/gkhvIxTLH0V
	 W2nYv3KloF4QgianKu6qxs4SGjWzFHPADuzWuMcuihk2MFkHi3EBsm+GlErBiquR/v
	 PAVI6pE+8GD+CWw0klmuD+53l0vCvMVslWQvHQHwZnT1mjeyQ3KKvU989KdP4AbR/f
	 nxXx89NQKrMcLMoxKobU1GxxKXwO48oqbNWjnPw1aL5JmIjOgyiX/a1QvNm23ywqxb
	 loRPSFowxp4Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D558C595C5;
	Thu, 25 Apr 2024 15:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] af_unix: Suppress false-positive lockdep splat for
 spin_lock() in __unix_gc().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171406022824.18400.12892759544477412542.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:50:28 +0000
References: <20240424170443.9832-1-kuniyu@amazon.com>
In-Reply-To: <20240424170443.9832-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mhal@rbox.co, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 10:04:43 -0700 you wrote:
> syzbot reported a lockdep splat regarding unix_gc_lock and
> unix_state_lock().
> 
> One is called from recvmsg() for a connected socket, and another
> is called from GC for TCP_LISTEN socket.
> 
> So, the splat is false-positive.
> 
> [...]

Here is the summary with links:
  - [v3,net] af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().
    https://git.kernel.org/netdev/net/c/1971d13ffa84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



