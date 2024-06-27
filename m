Return-Path: <netdev+bounces-107179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D182691A386
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D191C210F8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329413C807;
	Thu, 27 Jun 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe3ObOk7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8F13A89B
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483032; cv=none; b=guvZzt0CQqFVyOL4/FmUktDxmub4HHY3K158nNdm2WJTx969pA8DD5QYIcmPmlTiaI8JaOLn+r3F7vBd0CB4EsbvG4ZODwjz4uBtKe/0PjyqEjr77yucNb07y6/zLsgxVPIt/7HUWx2LREZgVi8E3YQkxY3y4hcGV4n2XEBX63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483032; c=relaxed/simple;
	bh=A5XfFdu5PLEkJFZ9yXdCmTT0G5UF0jfVXVT7pW6FY9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RqKvlbDIdmVv0XVhoVqnj0l2Y6GyTV+FG1PjQE8Af9QkGmz3YAtNwuJV7mblrYy8KxdK9UpHn5A5ljYWsDAcnNA9f1FIZB9gzbgUdnrTH76WPaEX3w3fGydeY5TjoE7nutDgP6Hav1NX4jEay/qYlZu/c8s46wTrT2oeU0PDkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe3ObOk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B3C3C32789;
	Thu, 27 Jun 2024 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719483030;
	bh=A5XfFdu5PLEkJFZ9yXdCmTT0G5UF0jfVXVT7pW6FY9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fe3ObOk7xHaxssayuf8Ptl23wprDnPIFP4eXgyVAt+VK9c+Yhe/nNzAhbVtHck8fs
	 q9z8m502NmLdju1rWezS6qMg2pz1NUct+gBlQnAwVkrk4+YhjxRKvmEbjE+kgIEjix
	 Xw1fQJ2U8+MON4FYKEgeNORn1BtYvb2iZu975p4uEwQSFr9sRhcct9vFcgtvGLwPta
	 FRXp8hJsbmM4SIPC+cfXaNUA6xnc+t3ykfkDX3QhDEzFwCJwCtZoB9U1JsUwhViN8E
	 PfzKXSvs5rCIpgvcaNBA88wr7s0W5rHgx6um4zt16WSskobD65/rxYWfr7gd6nWUmQ
	 Yhn95TrCfkEng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C1C2DE8DE0;
	Thu, 27 Jun 2024 10:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 00/11] af_unix: Fix bunch of MSG_OOB bugs and add new
 tests.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171948303050.16357.13370911395111712454.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 10:10:30 +0000
References: <20240625013645.45034-1-kuniyu@amazon.com>
In-Reply-To: <20240625013645.45034-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Rao.Shoaib@oracle.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 24 Jun 2024 18:36:34 -0700 you wrote:
> This series rewrites the selftest for AF_UNIX MSG_OOB and fixes
> bunch of bugs that AF_UNIX behaves differently compared to TCP.
> 
> Note that the test discovered few more bugs in TCP side, which
> will be fixed in another series.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net,01/11] selftest: af_unix: Remove test_unix_oob.c.
    https://git.kernel.org/netdev/net/c/7d139181a891
  - [v1,net,02/11] selftest: af_unix: Add msg_oob.c.
    https://git.kernel.org/netdev/net/c/d098d77232c3
  - [v1,net,03/11] af_unix: Stop recv(MSG_PEEK) at consumed OOB skb.
    https://git.kernel.org/netdev/net/c/b94038d841a9
  - [v1,net,04/11] af_unix: Don't stop recv(MSG_DONTWAIT) if consumed OOB skb is at the head.
    https://git.kernel.org/netdev/net/c/93c99f21db36
  - [v1,net,05/11] selftest: af_unix: Add non-TCP-compliant test cases in msg_oob.c.
    https://git.kernel.org/netdev/net/c/f5ea0768a255
  - [v1,net,06/11] af_unix: Don't stop recv() at consumed ex-OOB skb.
    https://git.kernel.org/netdev/net/c/36893ef0b661
  - [v1,net,07/11] selftest: af_unix: Add SO_OOBINLINE test cases in msg_oob.c
    https://git.kernel.org/netdev/net/c/436352e8e57e
  - [v1,net,08/11] selftest: af_unix: Check SIGURG after every send() in msg_oob.c
    https://git.kernel.org/netdev/net/c/d02689e6860d
  - [v1,net,09/11] selftest: af_unix: Check EPOLLPRI after every send()/recv() in msg_oob.c
    https://git.kernel.org/netdev/net/c/48a998373090
  - [v1,net,10/11] af_unix: Fix wrong ioctl(SIOCATMARK) when consumed OOB skb is at the head.
    https://git.kernel.org/netdev/net/c/e400cfa38bb0
  - [v1,net,11/11] selftest: af_unix: Check SIOCATMARK after every send()/recv() in msg_oob.c.
    https://git.kernel.org/netdev/net/c/91b7186c8d14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



