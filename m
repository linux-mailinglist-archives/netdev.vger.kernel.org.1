Return-Path: <netdev+bounces-233378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3DAC128E6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48E49506946
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E325A633;
	Tue, 28 Oct 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6JTZ2j5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12A235061
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615042; cv=none; b=gVqtjGyqcZNmFFgLhvViMoobZeQ4uOJ6oUWtOv+amv/f3dS0Fvj/yVHgWu4QGKCnvf462eQm0zyeqm3FmxZv3vvXPoUEAIdSUI8Dz3P00qyfjoMEXY8ywt1pQVfau8aMmjsbrVJoSmY0bHIWIgI86EIwd3qPT2MSNsFZQB7gjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615042; c=relaxed/simple;
	bh=L6LInI8n5HKCd1x/q8x2PxQyncN+O9m29Uqn13EjN/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N5WTsfc6aNfOiKRFEsNpGJNw9QyOHgzWjd7wPdAgkQCj2uY0pmJ5Kwq/vj1M02pLRgRpdd5x7bQS3sZ4exA9D9+vxAHQRytbnyW1uUyRv0IF2a5a2vH+mNx1ozNKLZkpJ7G4ZO+1AvtT/9iRf5j/s0FTnAf95PujF3la3K73Rgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6JTZ2j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84E2C4CEF1;
	Tue, 28 Oct 2025 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615041;
	bh=L6LInI8n5HKCd1x/q8x2PxQyncN+O9m29Uqn13EjN/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P6JTZ2j5JsfdxIVHe9EyW6jHeE6FscbqZ3tqzGsAclZEvpIv99l+l0Dy/gk7okskr
	 1hHWjV0UMCfhgkvJ4WpJqZIm5prr9pXq800OBZfqDwf3MvpE64uAZA9+EkM3lTqSnf
	 AmC1Gwidpykau0fD5LvzckMYQWJIVYmxe3va3w78iIW/YsAZ6ZrPbKHKRF80a3vZCi
	 u/OzINkp4iX5zabTTh0cB8HOybZurvZi0RqyH3PTDetxsW2hlD89oIiKNioy6lpl3k
	 rYHh3TAUrbSSP5AHGRLaXo5rF3MXg9KJ2e0jISvjE9dgwSUaxjSiDlF0fZQ/TlYfGW
	 0gi84pm8J+Pyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB739D60B9;
	Tue, 28 Oct 2025 01:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: remove one ktime_get() from recvmsg() fast
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161501988.1653952.12715566515253447091.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:30:19 +0000
References: <20251024120707.3516550-1-edumazet@google.com>
In-Reply-To: <20251024120707.3516550-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 12:07:07 +0000 you wrote:
> Each time some payload is consumed by user space (recvmsg() and friends),
> TCP calls tcp_rcv_space_adjust() to run DRS algorithm to check
> if an increase of sk->sk_rcvbuf is needed.
> 
> This function is based on time sampling, and currently calls
> tcp_mstamp_refresh(tp), which is a wrapper around ktime_get_ns().
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: remove one ktime_get() from recvmsg() fast path
    https://git.kernel.org/netdev/net-next/c/0ae1ac7335ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



