Return-Path: <netdev+bounces-178918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA0A79907
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345BC1893686
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0B1F7545;
	Wed,  2 Apr 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx7AWUlT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C221F4C8F
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637197; cv=none; b=YMUefgBoABpC4mG1qohI1KMXntd893ZT2afu1XTOXZlYi+C53C4QVrJIYoxdj6zbrLUR+klsH0hHlv+NL8jcg1A7jQ+gb91mNBk4DPa9pHc5dmGtL9aNd704qH1yjwavO+TwofZ6EQg5Hlu8I/+g2jn4tFy3LU22eDaTTRkcvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637197; c=relaxed/simple;
	bh=dhpKoxKvOUaRSme/PPICufZGLOC4/cD283yqf6sAvyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hop1ahPltbkeZ1bNsEKY1ET0Xe/0jwVU4376xm0zuaUwyjxpruL4VhZDbI8nixwtkPGQxlD4c3OkJd1IDX0Ye35rsB2uys282ZXUxkfkaGThfL1KgFqw0jdIkf3GJ6D0mNjL6B19PdXxzfZ97A/rlou7Q/Jln1Uef3INLOXs340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx7AWUlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F5EC4CEDD;
	Wed,  2 Apr 2025 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637196;
	bh=dhpKoxKvOUaRSme/PPICufZGLOC4/cD283yqf6sAvyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jx7AWUlTOC/EdrKPFfcEB+9aY2OkmmA0GWABD3nDIVNrAjqutPcObSiqEsdApFsJB
	 GaKmNnmWSUhdD+KmCqrsB1D+TcOo51O7qKZnlr4wEVKFylixwcE+4uUSNXnru9JbYw
	 1sevs/AWb/aykrWH+JI721LJAek1vYnYMzZxTN7rJUbtFFEadiQjAhhfqbv7clsznR
	 wZvZV5Q6JLbNlOLzF+X0xptOoGIAjixZyAoSakEw9yUooBOHm+F24XO2mOXOkoyvUW
	 p18kPSF/BSOSwQE/Bb/W3Cx5hTgTSNppXd88KMH2M+pbciNR1NGPLvR9EYSXrWtw7S
	 TCsjwLil917Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E7B380CEE3;
	Wed,  2 Apr 2025 23:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: add mutual exclusion in proc_sctp_do_udp_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363723326.1716091.14559512719175692970.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:33 +0000
References: <20250331091532.224982-1-edumazet@google.com>
In-Reply-To: <20250331091532.224982-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Mar 2025 09:15:32 +0000 you wrote:
> We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_start()
> or risk a crash as syzbot reported:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller-g7f2ff7b62617 #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
>  RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
> Call Trace:
>  <TASK>
>   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
>   sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
>   proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
>   proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
>   iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
>   do_splice_from fs/splice.c:935 [inline]
>   direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
>   splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
>   do_splice_direct_actor fs/splice.c:1201 [inline]
>   do_splice_direct+0x174/0x240 fs/splice.c:1227
>   do_sendfile+0xafd/0xe50 fs/read_write.c:1368
>   __do_sys_sendfile64 fs/read_write.c:1429 [inline]
>   __se_sys_sendfile64 fs/read_write.c:1415 [inline]
>   __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> 
> [...]

Here is the summary with links:
  - [net] sctp: add mutual exclusion in proc_sctp_do_udp_port()
    https://git.kernel.org/netdev/net/c/10206302af85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



