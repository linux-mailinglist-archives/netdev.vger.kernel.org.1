Return-Path: <netdev+bounces-149565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8C9E63E0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E43116A2C0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29B14A4D1;
	Fri,  6 Dec 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA1NhxWv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE913BAC6
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451015; cv=none; b=URhy9SIfSPi+tgYsVj0saSSQpTQOvD2qMZS3D1yxP44kcGCbQ5D1PJ9Vs3qBlYmPNnlPeq+4OwZJvPQ4DZzZpNTD9LeIQJLf2pWxq0OkLObigtMY8UFspND5U3YTnOlRfZmPkIB+mRU3U+l/oUxNhrxGo2MfXD+fIqT7IXsDSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451015; c=relaxed/simple;
	bh=YtUEBCE5Fd3UjG3ttl+tv+VOiH2nDO4T9nNpWtQy0Tg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJTCU8TDkrYiuZ1gfkjU5YAkJPqGW2HjBuIx5xCmCceLS8I1oq8q+rbRXsNATY9qpNolfax296kg9qJCbGF4bsu6aXPNQVZ1uV+qQyjJGPtIuYWkqWoWXv4GMBSh5iajBog8vipiK7xoCRF7QJ86O0xyrEKMHIh6b5HSt36T1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA1NhxWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AEDC4CED1;
	Fri,  6 Dec 2024 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733451014;
	bh=YtUEBCE5Fd3UjG3ttl+tv+VOiH2nDO4T9nNpWtQy0Tg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gA1NhxWvlvExq81LWQkYY4x902VQoCBCb88Cbo3VFVl7FmrgUVhSOXRRSk2w/GJ6O
	 CV5lNVbAaTgZW82cgsJiA9/OztJYp4Kln2yoVQ1pc5o5h1etWc9oY4FbWGpapQAgJl
	 5J5jm7w9Ag8cK0jgzF7lygUYhuXVRrx2nfsZvom14+5mHb8O3jcXrY2nR/nmY+zfqY
	 pHcIF57Tz8Bt3KTv8oLgI2whPwkvbr1iCFqNKoxF1377N/Oaf9ffB2bNaylMW5Fwbs
	 Obnf1gRs5OSBhM+gVPBnLke+OHvZZs2B02rbKuESAFupffYKt7u2zliHycNV68KAJ1
	 QPbKXGO79NzdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE157380A953;
	Fri,  6 Dec 2024 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix NULL deref in cleanup_bearer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173345102951.2157140.16749150922708261258.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 02:10:29 +0000
References: <20241204170548.4152658-1-edumazet@google.com>
In-Reply-To: <20241204170548.4152658-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 17:05:48 +0000 you wrote:
> syzbot found [1] that after blamed commit, ub->ubsock->sk
> was NULL when attempting the atomic_dec() :
> 
> atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> 
> Fix this by caching the tipc_net pointer.
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix NULL deref in cleanup_bearer()
    https://git.kernel.org/netdev/net/c/b04d86fff66b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



