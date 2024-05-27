Return-Path: <netdev+bounces-98161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B98CFD7A
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180DB1C21776
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508FC13A899;
	Mon, 27 May 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq0FV7Ts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE813A87E
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803430; cv=none; b=Ixdu858i59Fiz8xrHQ5vPoxJidJpmhc0WGR8nDP+/NSfqb99EDO2182IQGz+LGqtxn4iSerG7xZWqmxCbe7bLVbzuvVWaE7Bf5bQtmvVauiBWCD4aIGJGgu0FRu2rGWLbJpWmaW6kR+nSSvbX4F+++gbEFYNHPiYslH2ouq0CP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803430; c=relaxed/simple;
	bh=lsxa6fXmtlLKF2Ke+e3ImR3FMHGMfI1afOkbAtk/7Wg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IaHAgK22a/7DhZomwGQlWgGVlvzKrOo8TgxOfDrJ7Tx0D8gymuPojVy1EAnQQwmC8VNT7nqi/AI/GJUUp3+iXP1e3EgCZUSv3APh1o2qQCX7LhwL3m84auHCmXz6Oy/o6HIjQIYG3sc1eShPmbQpDY6H+4YArSywLavdujuEOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq0FV7Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBFB6C32781;
	Mon, 27 May 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716803429;
	bh=lsxa6fXmtlLKF2Ke+e3ImR3FMHGMfI1afOkbAtk/7Wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oq0FV7TspgSr04hitJAAnFRKOsuTx9+qlHE9imOol+TdPsatzdC02xAzOdNnQ3HTs
	 YjRsnZI/FrJ2c+fvbUqZe6Fzu8HwCrEHDls8RZUZT8gnqgPHvZD02jazKVWS0RWQec
	 i8/kWz5cH5HzgC4K6DxFShL9F5Wa0l6p/e7gAwWFZYx1Yccm3lTfnWtNg90PnKiY7B
	 rOhIkflKr/eZDzQJH0Gu7/Y40W47npGx11AVpgDZL8vSW7Srlz9vzAxhHJsONaGZOv
	 FfCZ41RXiMi8c2guqo6WRn6z4WufTomr0YSbaC5AFqMzAvrTrCoaqRL86Lo8Tm7fml
	 ZgQVNFBPDHnQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6B5FD3C6E2;
	Mon, 27 May 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] af_unix: Read sk->sk_hash under bindlock during
 bind().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171680342967.8026.16561372161491949292.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 09:50:29 +0000
References: <20240522154218.78088-1-kuniyu@amazon.com>
In-Reply-To: <20240522154218.78088-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 May 2024 00:42:18 +0900 you wrote:
> syzkaller reported data-race of sk->sk_hash in unix_autobind() [0],
> and the same ones exist in unix_bind_bsd() and unix_bind_abstract().
> 
> The three bind() functions prefetch sk->sk_hash locklessly and
> use it later after validating that unix_sk(sk)->addr is NULL under
> unix_sk(sk)->bindlock.
> 
> [...]

Here is the summary with links:
  - [v2,net] af_unix: Read sk->sk_hash under bindlock during bind().
    https://git.kernel.org/netdev/net/c/51d1b25a7209

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



