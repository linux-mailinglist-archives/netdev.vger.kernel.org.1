Return-Path: <netdev+bounces-67210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6B8425C0
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE958B2C4CB
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C16A03B;
	Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy+tidcS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F084C66
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619627; cv=none; b=btYaJLAefW7WCKdewy5pzQ8TgR1Z2nUSnUGvl+xpTXMGv5uwmg9MXrLmDauGBA+PiNaDGT4yGRUbLX8/38+EukErVTrK1QaE+mCzrzcvAmqNsYgzJ6zZe82iVM3dwPMYhEPuXE4nwUZQxuQHGS5ha64FhNFjSrau2s9sd77VpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619627; c=relaxed/simple;
	bh=ok6OgG3Z+LqAEOxpfLCLaYnPb9PsLqyjjTlcDdVjgzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CTRfxBI9oCRhMj3t/f3ws7G7y38WubWXBxNCuvRiM16MqMghZfDzapg733qr2F2ngNZYuQZyhDndLPZvEnxX4MV3DWvkPO49mM7kyh4cj/7tyjwbJ/hOgdkqe7uuxi/nuBYnmQF3feG3fzyLfUudIiVmtVuPlK7/OLMPN734VUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy+tidcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DB40C43390;
	Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619627;
	bh=ok6OgG3Z+LqAEOxpfLCLaYnPb9PsLqyjjTlcDdVjgzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cy+tidcS1K5L+3v7JAeajukvUKma3QAdyBaHCRPwyfDA8X1v5sT6PKSjz2Cvcmksr
	 9n9u9CGW3kqPu/5yVgCwkAqcFUB1HfOT4beLHhZjTRZgBk+geC4LZspWER49ARjcsq
	 BIckzYGjLILZxC8NcteQsUj8momXzlVqClFUPTTy5SDjoMl6D1SRXNDn4SybUgNCTz
	 73uImZe1PX5xmy6iKIotjtZH7Gmh146TRVctUUOTvHNfjxqEIQYxmWAjmrdGL1IbwG
	 FAcAhg55jseAIMT9GndB3By2ugyEgJc/cpeSqtlNqVqCJ7GVc4mwqwtC+aiguEtdek
	 rNUT1pc+FBoQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04270E3237E;
	Tue, 30 Jan 2024 13:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] llc: call sock_orphan() at release time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170661962701.22779.6523636010595073464.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 13:00:27 +0000
References: <20240126165532.3396702-1-edumazet@google.com>
In-Reply-To: <20240126165532.3396702-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+32b89eaa102b372ff76d@syzkaller.appspotmail.com, ebiggers@google.com,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Jan 2024 16:55:32 +0000 you wrote:
> syzbot reported an interesting trace [1] caused by a stale sk->sk_wq
> pointer in a closed llc socket.
> 
> In commit ff7b11aa481f ("net: socket: set sock->sk to NULL after
> calling proto_ops::release()") Eric Biggers hinted that some protocols
> are missing a sock_orphan(), we need to perform a full audit.
> 
> [...]

Here is the summary with links:
  - [net] llc: call sock_orphan() at release time
    https://git.kernel.org/netdev/net/c/aa2b2eb39348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



