Return-Path: <netdev+bounces-106421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1F916255
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714D41C20F93
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CC913C90B;
	Tue, 25 Jun 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pejh88eK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F3FBEF
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307833; cv=none; b=NC+Dy0doPo2qcuB26+WBA3N2qvhbR0YGwFJHqTcMyiAxsKfD1tsOV/Swow/JVtRDLouBDthx8BXaUQC+WBWAhEmYvF+s242tyYmSfVOWyzKD/rN6l/OclxsL5Pc5oQbg8oQ0YRqFkzhJ+W5tptpcVSXz5tbV7Bkt22P5ocP64A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307833; c=relaxed/simple;
	bh=rPjZPypixzE+9fgICv5dcdG8kPO1vKQG7Y9IpzGCqWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nZaz9t55K3EghriI9hmh4xaAquomSr11GJGjSsJ9ofD7m80nhGtwmXHUAncElkMTQBMDCHlj6s4NX5GYq7SPNGF+ZRgXIo7rRCuxqD2YEMcw4w40tYCY5rWNNqAr0k3os7smNxlJaN6z/H62Aou04Dem9tyardguk68hdDRwYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pejh88eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8E57C32786;
	Tue, 25 Jun 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719307833;
	bh=rPjZPypixzE+9fgICv5dcdG8kPO1vKQG7Y9IpzGCqWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pejh88eKmBS3LxHXY48m+0XuZ+lWgntiZVPNbf88fBZXhXLb/+enlNULtoIdS1jfk
	 y8nZcQ38kBDY3PFKxl9sN19OYBO0kyYWOBNwqf7zNdD+Ys92zJ3T36ucMBYTqQhbkO
	 gbDvwc344OmLvu2v5rljkQPGMdMOSTpmN6PL6cpL6D/cpO3gXwHB7ZW1XsZTjfr2ET
	 dJcwADAQAZrAuWYjhOCoyhg9wUFch7NGpKddT/FtwpCq7LBZ8IJdoZCAcXVpCl6N6j
	 dTxG6pNt1igVShYPZOZxbW9WwgNCnAjkYR2XtAJ/MASq26xOZAaUnJsbVGgJbvolwC
	 jxOh2Vy2htUbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB271C32767;
	Tue, 25 Jun 2024 09:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/11] af_unix: Remove spin_lock_nested() and
 convert to lock_cmp_fn.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171930783289.15965.17351249975983635455.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 09:30:32 +0000
References: <20240620205623.60139-1-kuniyu@amazon.com>
In-Reply-To: <20240620205623.60139-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kent.overstreet@linux.dev, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Jun 2024 13:56:12 -0700 you wrote:
> This series removes spin_lock_nested() in AF_UNIX and instead
> defines the locking orders as functions tied to each lock by
> lockdep_set_lock_cmp_fn().
> 
> When the defined function returns a negative value, lockdep
> considers it will not cause deadlock.  (See ->cmp_fn() in
> check_deadlock() and check_prev_add().)
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/11] af_unix: Define locking order for unix_table_double_lock().
    https://git.kernel.org/netdev/net-next/c/3955802f160b
  - [v4,net-next,02/11] af_unix: Define locking order for U_LOCK_SECOND in unix_state_double_lock().
    https://git.kernel.org/netdev/net-next/c/ed99822817cb
  - [v4,net-next,03/11] af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().
    https://git.kernel.org/netdev/net-next/c/1ca27e0c8c13
  - [v4,net-next,04/11] af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().
    https://git.kernel.org/netdev/net-next/c/98f706de445b
  - [v4,net-next,05/11] af_unix: Don't acquire unix_state_lock() for sock_i_ino().
    https://git.kernel.org/netdev/net-next/c/b380b18102a0
  - [v4,net-next,06/11] af_unix: Remove U_LOCK_DIAG.
    https://git.kernel.org/netdev/net-next/c/c4da4661d985
  - [v4,net-next,07/11] af_unix: Remove U_LOCK_GC_LISTENER.
    https://git.kernel.org/netdev/net-next/c/7202cb591624
  - [v4,net-next,08/11] af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
    https://git.kernel.org/netdev/net-next/c/8647ece4814f
  - [v4,net-next,09/11] af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
    https://git.kernel.org/netdev/net-next/c/faf489e6896d
  - [v4,net-next,10/11] af_unix: Remove put_pid()/put_cred() in copy_peercred().
    https://git.kernel.org/netdev/net-next/c/e4bd881d9871
  - [v4,net-next,11/11] af_unix: Don't use spin_lock_nested() in copy_peercred().
    https://git.kernel.org/netdev/net-next/c/22e5751b0524

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



