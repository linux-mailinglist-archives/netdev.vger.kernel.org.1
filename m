Return-Path: <netdev+bounces-143538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727EC9C2EB5
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1534C1F211FA
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1D19D890;
	Sat,  9 Nov 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkeLzzLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96FECF
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172823; cv=none; b=awdCHdFhxrY40cuDGLALoK/9YKmQqChigS84g5NGGpO5awuuRcLU4YsbNMPEmzjRwwLrdYN5XXHs4QzmgS+H42Qixfa0fRmhU2Ta5dOGm+iF6tRsrKaQ+RyO1TquwXNLnn3q+tsTutig5Ss/1r30xKHf0ylRQtKaDX6lzQRAGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172823; c=relaxed/simple;
	bh=kE2cz7X63NASuIe5oGmjdNHQiIXPjoN1iHjcBqfxB68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VZQbV+LXGKeclk+qKyGzmIqvWve47WU6v3G7Y3UhSzKCrnyqIHye+KV4BppwdiYNJMlXrCMxWN2HEjU46ooqp+5WosDZX0mQXWur9CE/nGrACELO0Q1FTglihu3qiSkRVk0m1iCggw3roZ0159KWW9M2cLit8ZHRKvuSKQwVpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkeLzzLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CCBC4CECE;
	Sat,  9 Nov 2024 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731172822;
	bh=kE2cz7X63NASuIe5oGmjdNHQiIXPjoN1iHjcBqfxB68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkeLzzLO8j756TKyimCmQ4c7aTBuKZm3IB7nOaIjVxyon5ULQNcwgEpW0KOiZ4orE
	 PvmapkZZ6HjBRxQwzwnxXawKxvaJedznmC7lXqmmNPy80p3R+4O03T4OCODuktuMRu
	 iE8EsDYVzOlmwnQcVFmgM0uD5r3BtxW2Oe3PaavEuIuXonDxmePT928vT5fvN5fBUJ
	 3XJdVNZf/bTFDtjNHMe2OGziopH7CUKL34g/+AFwcoM1z1TqUXHdZR8FRptjIwv6QJ
	 5Va8+9G/fe4yJ0evyeRrWtF1c79WkOPdBVzkoGcgbbgnAwwy4r7BvUD8Q+diCgZVGf
	 qluOptS5f+10w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE43809A80;
	Sat,  9 Nov 2024 17:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: fix possible UAF in sctp_v6_available()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173117283227.2976734.4081832173323355514.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 17:20:32 +0000
References: <20241107192021.2579789-1-edumazet@google.com>
In-Reply-To: <20241107192021.2579789-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, lucien.xin@gmail.com,
 marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 19:20:21 +0000 you wrote:
> A lockdep report [1] with CONFIG_PROVE_RCU_LIST=y hints
> that sctp_v6_available() is calling dev_get_by_index_rcu()
> and ipv6_chk_addr() without holding rcu.
> 
> [1]
>  =============================
>  WARNING: suspicious RCU usage
>  6.12.0-rc5-virtme #1216 Tainted: G        W
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: fix possible UAF in sctp_v6_available()
    https://git.kernel.org/netdev/net/c/eb72e7fcc839

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



