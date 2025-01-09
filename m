Return-Path: <netdev+bounces-156795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612CA07D85
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC053A852B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA87221DBA;
	Thu,  9 Jan 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVqJFcTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6C21CA14
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440209; cv=none; b=C1BWsEFkZsbUn2qXlC6aH+h6GjOxxRbbeInMjdYkiWuKKuVhZIy5nXHR8p6UgwhiCKY3qZxt6BWGa7YY+GreBgROQZBRnz+xk+Q/d8TFuzxrFmgoq6kLABOt6TBkVyj6aqQRRWNZbnsaH+L43zp3euyIhyT1XEDspXT4hGdwajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440209; c=relaxed/simple;
	bh=FtUi4iVLWWEBvVmgZhzZFhwc04tacUyme484/wGGMuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q9yNsUeOxxVfLKWj1CF5uEE+b8WrzshzIyRcI6TKUtW2xDEudigk687wT+yIL6rK5VTFYmQca5J+GGKxsXToQ0ZWkuevgyhNef3BIx3pBb8bKX1dPu+lDSGrZlsU5csFMiWWmOCz8H2VheAFpFEeetuH7ICOCblQWiWzI26xtGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVqJFcTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AADC4CED3;
	Thu,  9 Jan 2025 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440209;
	bh=FtUi4iVLWWEBvVmgZhzZFhwc04tacUyme484/wGGMuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVqJFcTy4kHJZKVA9aU80zA1Y/8NBo+06usHT33uNrDYxuJGrMZqISiFy0DBN8zeA
	 3jZ8kij8O7azX4YKvSEcNC988CQN36zEPW0o+34hSV4zRE6ssJxoVjKKsF0KImIZhf
	 zCyr7h99cdZwU6W8qvr5PxSYmJ9ZEXvlq1fXjlFToxs696XPUwwbFMhdEqiIKV4PPz
	 2RIdA5gXA6ktd8yJnosaDvSI5FqAfd+SzlOZIwtiiglaL6mm12acvzwu3ej0qQnfBJ
	 8d142nNQb6h0gt7/D/mb67lnMBLGG55MwdWZW2T6BIcAeXzgBDJEjLybVDr3KVRAXw
	 p7J+4ZTwl0Amw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D343805DB2;
	Thu,  9 Jan 2025 16:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] sched: sch_cake: add bounds checks to host bulk flow
 fairness counts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173644023101.1439025.9438524585009364765.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:30:31 +0000
References: <20250109160900.192138-1-toke@redhat.com>
In-Reply-To: <20250109160900.192138-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, pabeni@redhat.com,
 syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com, dave.taht@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 17:08:59 +0100 you wrote:
> Even though we fixed a logic error in the commit cited below, syzbot
> still managed to trigger an underflow of the per-host bulk flow
> counters, leading to an out of bounds memory access.
> 
> To avoid any such logic errors causing out of bounds memory accesses,
> this commit factors out all accesses to the per-host bulk flow counters
> to a series of helpers that perform bounds-checking before any
> increments and decrements. This also has the benefit of improving
> readability by moving the conditional checks for the flow mode into
> these helpers, instead of having them spread out throughout the
> code (which was the cause of the original logic error).
> 
> [...]

Here is the summary with links:
  - [net,v3] sched: sch_cake: add bounds checks to host bulk flow fairness counts
    https://git.kernel.org/netdev/net/c/737d4d91d35b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



