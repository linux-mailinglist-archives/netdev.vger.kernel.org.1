Return-Path: <netdev+bounces-251211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C8D3B512
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCED7305FFC8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571232D7DE;
	Mon, 19 Jan 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpvFwI6t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCB2C21DD
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845608; cv=none; b=DN8S+Onv1ooYC4k3tYURb9CUiHzPSpFwJkhHu+xxlQQ9WQ+htuHEt0r4bXDS+xVQWSyHiQqcens8RDhnL2WyJDd5O1PyDz1OnBOCEYhhrIhc5nlkexTm/wyjSp9er9+RN1BW6vJmNTeFd5jRNRS1dXdmexpneHqDigSGueiQsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845608; c=relaxed/simple;
	bh=aJVowhlGOK5Lzc+ge24qME0qcPOZEOxjGJ92Tsx6RX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=naWlltOwMEjJiP6uqMh1JLocfCmyBA6cdyqqw91bKq+gYidFO1wijASrknLp6En+u+K8JfjFbFwI/cvJHaaS9FlbPaUC2rOtlpzi3Mbi9gTtZ6mqZiUvcK29qwTzuk1hJAMgW64g5PwyG/+SYVMG5lk+XkEilGO7jX1Mecsw/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpvFwI6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF29C116C6;
	Mon, 19 Jan 2026 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768845607;
	bh=aJVowhlGOK5Lzc+ge24qME0qcPOZEOxjGJ92Tsx6RX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jpvFwI6tX1wmBqxwRLEy8qOTKzukdoEirEj5U+sTVuNB3uv63xmL2/O6nePEhqt/t
	 M0LXzHSaKgCuvmokjbrraqjqvctUL7uE/uqOmqVzz/YcDveLdL7juUFDllSpVRjiLM
	 tJTARMenj8AyyD/uubhMvkzRnwkWYgL+e5EydKcS++wL5vLRn7VwK4tOMujkz24la9
	 DE7rZWTyplcRTfEbljpX5APqRowYA3D39uG/Iq3vdKen3KJ8ZNyiY91QQK1i3L+U3y
	 Jhj4yAqXS1fy97NLDQNDTgMY5GyFVw0XLQrdPKKEaSFHEhC1KcIi0Su/f6F3FG+sB6
	 xvyNASFq1d5yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 01CDA3806905;
	Mon, 19 Jan 2026 18:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: avoid one data-race in l2tp_tunnel_del_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884560579.82416.4300596156942866885.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:00:05 +0000
References: <20260115092139.3066180-1-edumazet@google.com>
In-Reply-To: <20260115092139.3066180-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+7312e82745f7fa2526db@syzkaller.appspotmail.com, jchapman@katalix.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 09:21:39 +0000 you wrote:
> We should read sk->sk_socket only when dealing with kernel sockets.
> 
> syzbot reported the following data-race:
> 
> BUG: KCSAN: data-race in l2tp_tunnel_del_work / sk_common_release
> 
> write to 0xffff88811c182b20 of 8 bytes by task 5365 on cpu 0:
>   sk_set_socket include/net/sock.h:2092 [inline]
>   sock_orphan include/net/sock.h:2118 [inline]
>   sk_common_release+0xae/0x230 net/core/sock.c:4003
>   udp_lib_close+0x15/0x20 include/net/udp.h:325
>   inet_release+0xce/0xf0 net/ipv4/af_inet.c:437
>   __sock_release net/socket.c:662 [inline]
>   sock_close+0x6b/0x150 net/socket.c:1455
>   __fput+0x29b/0x650 fs/file_table.c:468
>   ____fput+0x1c/0x30 fs/file_table.c:496
>   task_work_run+0x131/0x1a0 kernel/task_work.c:233
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
>   exit_to_user_mode_loop+0x1fe/0x740 kernel/entry/common.c:75
>   __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>   syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>   syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
>   do_syscall_64+0x1e1/0x2b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] l2tp: avoid one data-race in l2tp_tunnel_del_work()
    https://git.kernel.org/netdev/net/c/7a29f6bf60f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



