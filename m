Return-Path: <netdev+bounces-90568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF98AE864
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95081F21453
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13DB13666F;
	Tue, 23 Apr 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMrdRWCC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF3641
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879628; cv=none; b=ZMhmzmo41MwKanlX1umWP+JeZLgKCp7qdQVNvAsvkZ0pnz/F/DDni2looK98hgsEFbi8L2ohppY2mWJLfTbT3ZEmIhdvtFgh4tnhxtKhZLoJ7U9Sx6j47O6QLItSDU5D67ZpThtkyejGOzgWgODfrkGG6UIVyypRLCYmzC9IAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879628; c=relaxed/simple;
	bh=ejvlNksT+rAJAEUVEYHSiADgm+c7YEH0WnCW0JpnhW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XmsXfIffVx+EaQoRRMtCA1yVBSN0qidEKbOOa51AJaCpP3+iTucTHun3ERw6nRFD70ddw5R9uXL/BUffhYWwTTvX3IhaTBiixYXzzkJhEcXI3uXljEqtnU/teDu/KTdJuF+JMgu8fSDZO0vkm1b2gHszdxUyxJkrXEuRNjYcA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMrdRWCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09328C3277B;
	Tue, 23 Apr 2024 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713879628;
	bh=ejvlNksT+rAJAEUVEYHSiADgm+c7YEH0WnCW0JpnhW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gMrdRWCCIjgNFIy8SzGONFjyNuDKOFgQnDEF2Zh+zJYU+5ouNF7KIfZK7tX6SXY1V
	 /weLs7PW3CoF1gGLONckNaQQYwS8XscHq9K1155pQdd7kYyCeA47zOWarMJ4Yq9I6c
	 AJBcFS+Xy1XABjj9r280IiWKHWunbHkPVQJINVgw9bqcV4Z6AXUMtqXlGP675/wjaU
	 N8zvysxUJIlol8THIl2QuwmkPlbU2umkl/unt7bmZOoXnmAYLyA8w4CyqJc8fAcBht
	 fZbLv9QvdFO431+stGNLpuLrHhUiGqYVtdhoKVNxEmjteSRXHrUqL81afXoLbLIX4E
	 7J1DymutVoT6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA45EC433E9;
	Tue, 23 Apr 2024 13:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] af_unix: Don't access successor in
 unix_del_edges() during GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171387962795.30639.15729476746620345894.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 13:40:27 +0000
References: <20240419235102.31707-1-kuniyu@amazon.com>
In-Reply-To: <20240419235102.31707-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Apr 2024 16:51:02 -0700 you wrote:
> syzbot reported use-after-free in unix_del_edges().  [0]
> 
> What the repro does is basically repeat the following quickly.
> 
>   1. pass a fd of an AF_UNIX socket to itself
> 
>     socketpair(AF_UNIX, SOCK_DGRAM, 0, [3, 4]) = 0
>     sendmsg(3, {..., msg_control=[{cmsg_len=20, cmsg_level=SOL_SOCKET,
>                                    cmsg_type=SCM_RIGHTS, cmsg_data=[4]}], ...}, 0) = 0
> 
> [...]

Here is the summary with links:
  - [v1,net-next] af_unix: Don't access successor in unix_del_edges() during GC.
    https://git.kernel.org/netdev/net-next/c/1af2dface5d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



