Return-Path: <netdev+bounces-110198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C954A92B41D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DF1F23255
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C58155751;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa/A5elr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1C1527B8;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518031; cv=none; b=NtyTLWRWpKG+rgDVv0DG9KusrAS7qt0q2grryWLRDVEKa43mrNKNSJUQVRxoteVMZAiG+nsLV/C4Qfyd9OGKs8pGCvAtX6CUbbssCgiKj+Gz/npfYlTC4dbtLa22AGi7q2II8+N9TnLmP+UpBXvlBzkzYOBU1D0WoYzdGzUau9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518031; c=relaxed/simple;
	bh=FY3MxCA57lP59uTzf5TmSdwtfYPfEU3i2RCHRvJXZHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YJaNAX5VEPUS+T4kMdh370izouI3yJRBqzGUSDN/jwP6AzZTHdpoOzkYgIXSPhhA7OcOMyV/UfInAgLJGt2LKi7hkCi2DsSs2+8wG9OuJA7xuU5v3jeA9Vn9XlaoH28pyPdR4Wu2TXGrK7Hqcdr5QAgIZhXh7JH/Y9BJalHHsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa/A5elr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 311A5C4AF0A;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720518031;
	bh=FY3MxCA57lP59uTzf5TmSdwtfYPfEU3i2RCHRvJXZHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sa/A5elreZlA50marMQIq0/zp2PA4wRCrc/fwGA4vACup7QH7WEoAkqsCQvx37aVO
	 mT4EVXCDkqiHYnGHBEOg6qecDOWX1KOQh297T3APp8tvq8x4eWqFjwMOV0HkfTmNYc
	 +Qxh4s6sTS3vFUJBAg4QMJZ5e+tGr/FE8/di5PX2ZyGRcduaZcF3cr4m4y9hDSsumf
	 lfbMETm+JY/2dCGBvXJxj8mEDmbm6f9WFlA7NGYswcAREFrZkcOOXbtkcCqx+pp6Tf
	 XR9+v3e+nHJvB3kS+40LuToehcpBxivWgBuw/b5ozEIBTdpFZ8+pSbtULqmJFzzG1Q
	 oPhq/zLEn+dpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 188FDC433E9;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] l2tp: fix possible UAF when cleaning up tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172051803109.11180.9963479985374691387.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 09:40:31 +0000
References: <20240704152508.1923908-1-jchapman@katalix.com>
In-Reply-To: <20240704152508.1923908-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, tparkin@katalix.com, hdanton@sina.com,
 syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com,
 syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Jul 2024 16:25:08 +0100 you wrote:
> syzbot reported a UAF caused by a race when the L2TP work queue closes a
> tunnel at the same time as a userspace thread closes a session in that
> tunnel.
> 
> Tunnel cleanup is handled by a work queue which iterates through the
> sessions contained within a tunnel, and closes them in turn.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] l2tp: fix possible UAF when cleaning up tunnels
    https://git.kernel.org/netdev/net-next/c/f8ad00f3fb2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



