Return-Path: <netdev+bounces-166174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3DA34D40
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B91892176
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F324A049;
	Thu, 13 Feb 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2+R+i7Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50524A044;
	Thu, 13 Feb 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470209; cv=none; b=QvKGBBgKm6DWAk3Cn7clqlq2TtxE/kM+3wdQySrPYhWJZu257BT6tzIXuuLAUsYpLSJk+A2KnUFIaFUdbef8+iONaWYThMbdhup/7KqKY+htYudY4KXRMzMSsMTJSJZRGOABjUZnssZNHE7GE4kx7mLirCHDA+hOp49ihYmne9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470209; c=relaxed/simple;
	bh=ePk4yPiDnB7Xvx2xl1vHt1xkicFhnAcJOBJaRRcvRW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a74g43iUkV+P2Wr/u7HxuQTw68cP/5NbPI56fe9to9gz0v1oNV4nLITW0cH1yBKGZ1oqpFTIZRH4sEUMyGA95uC8MB1X44sQoVe3nWC4Gjz5eP2EJWqCkDo3Itaw3UfLYLUMCTVgoFda5N/9cipE5IuAleEcBsz4TRJKIB4oSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2+R+i7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBE3C4CED1;
	Thu, 13 Feb 2025 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470208;
	bh=ePk4yPiDnB7Xvx2xl1vHt1xkicFhnAcJOBJaRRcvRW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c2+R+i7Z6deC1WOoJb9MMC7tVI+rRrsqd9QdAnWJAr4wnUxc9gOuTkJkNbU8QRHgZ
	 JmlKKE3JsoLr/r15VGdP0l0h8VzHApcz9WAidsvfTyU+n8SCUREF/bnUX8HZpsdFlB
	 +5qkhAY5VnRDrrjnSxIegfmflQh/PHQuIfeNcLBiF/5XTwusW12DEO+3OGZfKjMEpr
	 1Vd0C31W5p3GkhajO48OAOHWZZZX4ghfHgk5/rqn7ldcn4W+5tGI/SXmksewhXInVh
	 i6bCgmWFNy3nlgP9U0QILDydx9opoteDoHIXvXkyuDEMim5d/oXmGK8k+KmTbc+yHO
	 HBTyp+fhitl5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3561B380CEEF;
	Thu, 13 Feb 2025 18:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix ipv6 path MTU discovery
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173947023801.1322759.11705974512765179739.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:10:38 +0000
References: <3517283.1739359284@warthog.procyon.org.uk>
In-Reply-To: <3517283.1739359284@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, chuck.lever@oracle.com, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 11:21:24 +0000 you wrote:
> rxrpc path MTU discovery currently only makes use of ICMPv4, but not
> ICMPv6, which means that pmtud for IPv6 doesn't work correctly.  Fix it to
> check for ICMPv6 messages also.
> 
> Fixes: eeaedc5449d9 ("rxrpc: Implement path-MTU probing using padded PING ACKs (RFC8899)")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix ipv6 path MTU discovery
    https://git.kernel.org/netdev/net/c/540cda75884a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



