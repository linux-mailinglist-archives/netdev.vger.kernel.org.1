Return-Path: <netdev+bounces-69679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9584C28E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D688B288758
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4467B10962;
	Wed,  7 Feb 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVUwWom8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E09810961
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273627; cv=none; b=ZlNsJ10N2Msdn0ZtF9WwvAszC/Q6QgN28Q490pRpzD8XgortxVUU774utBTQns1lNjMH21uKZLzWgfNWzMhPMc4l8Kj2IgZEQyG0MwSPVQdbBxoAIARyp5Zfl9D9nSn72E8OZsYUlCiw3vCxlHkyaz5xaqMrNqHaaeJQhPpfISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273627; c=relaxed/simple;
	bh=g+SoCxSF6kiZLoXNy+14ShM4+s+IWHUrONiLpTe3cKo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qAZ8NNXdH4ZEWjjWLlR/ZMkusBpKYntyVH3TZ273Im5u3kB5XSnmcuf61AX/rPq0KrWDiii1gCII6f4SlUUwd24jX+I79a5NltIo715UWjascGsEoBx5j0l8QhSraQF8jAv4XHQvbe1MmodQnHbiqDp2pDQ1mTQ0llvecRxCbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVUwWom8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CC40C43390;
	Wed,  7 Feb 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707273626;
	bh=g+SoCxSF6kiZLoXNy+14ShM4+s+IWHUrONiLpTe3cKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FVUwWom8da6CuPbiuQ6UgvHA8ydrLmCpFddCvau59clqb04F6ZhKdnxPsIreCzDlW
	 DjvEfNJSx8bF2DoeSMz2A7nDKzfxuZjr8In7zWgl6OO3A1c1c4dIumV2qHw+lR0ppd
	 inWlKgfX9kORG1lkaeJW7n3Aj5p/+EGs9gExUqjpMjZF3nsdHa+8BxU3Db192dYNzV
	 opGsOMcFtoM3IWFCkqMfpkrVjucO0KXoIdkjJno/vGnPMryl1yC9NmNAnmP/e4c/sQ
	 GEwka9ziECcwDp/okcnk3jmc/bSZ/hec8GZiJnKZCCu7mLDepyhPe2UTB2VUETis/A
	 eSsFaYCKAZjbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6ECD0E2F2F9;
	Wed,  7 Feb 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb
 in GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170727362644.24781.15529744831223761876.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 02:40:26 +0000
References: <20240203183149.63573-1-kuniyu@amazon.com>
In-Reply-To: <20240203183149.63573-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 3 Feb 2024 10:31:49 -0800 you wrote:
> syzbot reported a warning [0] in __unix_gc() with a repro, which
> creates a socketpair and sends one socket's fd to itself using the
> peer.
> 
>   socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
>   sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\360", iov_len=1}],
>           msg_iovlen=1, msg_control=[{cmsg_len=20, cmsg_level=SOL_SOCKET,
>                                       cmsg_type=SCM_RIGHTS, cmsg_data=[3]}],
>           msg_controllen=24, msg_flags=0}, MSG_OOB|MSG_PROBE|MSG_DONTWAIT|MSG_ZEROCOPY) = 1
> 
> [...]

Here is the summary with links:
  - [v2,net] af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
    https://git.kernel.org/netdev/net/c/1279f9d9dec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



