Return-Path: <netdev+bounces-111722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED3932443
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352271C20852
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739AD198A21;
	Tue, 16 Jul 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8y+GgBd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69843146
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126436; cv=none; b=eEaejCTsyk5JOXRpd0wJ4fx+4ORhGUOU9t2+5lnXdpB2WRS023fr3T+M78sBrBZVJBH9HnBBdPMqq+lMzznPqivNnjoirJM6vlE9ZQpKZn9f9613BYAXPimDsFAVjOXqEr/dQ5jDzp5yPvZYVJcMCaebTm9zDzfvRcGyda8Pnxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126436; c=relaxed/simple;
	bh=Pvp1qpGxTJMv06SJPGR7eU7S0TPI6U5PyBD3ta16FAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MzPTO17r2/jPBMyoYd3b4WrkIOfjcKmltKxTuMRG5egitQERqHEY6pojS18vsEBpR9kZ/GgF5aN7MYKdSHO3AIC/RHbkmTwWY5Ps3ucBDktLPTy26SkathOtVV7OckdcUZPRalaOv6PZ+q94JtezjiwchIIeuM/woeCL8onDmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8y+GgBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFFE7C4AF0C;
	Tue, 16 Jul 2024 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721126435;
	bh=Pvp1qpGxTJMv06SJPGR7eU7S0TPI6U5PyBD3ta16FAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q8y+GgBdn3PVN2DuTNyq/7ONniBhPFd185AsDPCKW3cCcgSeeF/96zawtV5tn5xgm
	 LHus0/0xiHJd+SZQsIZTHaHEnXtXyJoi20sJC4YXEkRgnT88M27jzZHlSDTzJi5fGK
	 DwJqaZIDdcAVY/AzA3uqiqEJ/JRmMtSQpx2n6Llp6Ly0Xqphq4E7JPuYdXmDsLKdBW
	 vQXBsvz9rTkjfJUCHmvPUfEufirjdi0QfsHOuVl/6G2/CY9rDZ+CZSjRLBHURlx5rp
	 uZQeqSscPhPtI0Rwq2QwKXgI2tZRXCuzZNZ3WbFtLbBtzmi5c4mSfKlztAFUCZPAVk
	 xpzI8p+Hn3fHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0468C43443;
	Tue, 16 Jul 2024 10:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Don't access uninit tcp_rsk(req)->ao_keyid in
 tcp_create_openreq_child().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172112643578.8025.6920574380576655534.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jul 2024 10:40:35 +0000
References: <20240714161719.6528-1-kuniyu@amazon.com>
In-Reply-To: <20240714161719.6528-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, 0x7f454c46@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 14 Jul 2024 09:17:19 -0700 you wrote:
> syzkaller reported KMSAN splat in tcp_create_openreq_child(). [0]
> 
> The uninit variable is tcp_rsk(req)->ao_keyid.
> 
> tcp_rsk(req)->ao_keyid is initialised only when tcp_conn_request() finds
> a valid TCP AO option in SYN.  Then, tcp_rsk(req)->used_tcp_ao is set
> accordingly.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Don't access uninit tcp_rsk(req)->ao_keyid in tcp_create_openreq_child().
    https://git.kernel.org/netdev/net-next/c/3f45181358e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



