Return-Path: <netdev+bounces-93159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB598BA532
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 04:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77541C21C8B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8A14277;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1vi4jiD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05813ACC
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702229; cv=none; b=Zl7YFn3ghSlkgiZg0DL8FFeDBITVqvCrTvJffsbiyQWyW0GQaF759SONrB1V5w7zE4YXjodY1E58J864PoqEI8CdibIDKu1Vi8mwZz+Y45bdNmEZjdW3/pmYYy0zXz8niPnRLC7a9NC4NyINgbl6bmPcQNfobCJ8Illqykv/DcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702229; c=relaxed/simple;
	bh=xtUlUZ9wZV/rrZ12/JPIwJhKmRu8FAxhvwP4uhRDbdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vEWZiA1A2jjHVVwImkgGcGNtgI5OldMMn8Pjs6i6boiaXUsygmv/tg0J+lmnGZv1V8Jy4YrPh6b0eVTdE2BpGAY1Ym5YW/aMYbLCbaC3zLf6dm67NvzwHLqSNDPvMnOvSAx4OpenNNPuQ+YDT7mpUYNUKtIWeDaFt8tYntWWGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1vi4jiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33A6EC116B1;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714702229;
	bh=xtUlUZ9wZV/rrZ12/JPIwJhKmRu8FAxhvwP4uhRDbdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F1vi4jiDuvJe5CV0uIzSflFi9C6MWcc0jlffaHp1alQnTc98U+r3E4PK58Y/AJ0qx
	 H3yOiIZWOQsoepvuYNNIXVkfbrarF7tOqJw1/gzwp3crZwu7BHDNGcoFN33sgmllhW
	 1Me8uZNxzpP77NwWOANiD6IrZeS2kGouu1qCIuMJKf+ef7o81OcsoksSEzi+qGpD+9
	 NakBZmQanfVbQXbASpm//suoH1WRWQemJBLn5CRjjvj9tv4YJ4+xykGoARIt22+QaA
	 Jkfnpy34w0CmXUan+RDhYxnm4qOmoAbe00CRjTvRB9bQgmhYOmVQUZd9E36z9y7JH2
	 qjZFOE6Tc4noA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 225D3C43335;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470222913.28714.15494712742844412793.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 02:10:29 +0000
References: <20240501213145.62261-1-kuniyu@amazon.com>
In-Reply-To: <20240501213145.62261-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, anderson@allelesecurity.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 1 May 2024 14:31:45 -0700 you wrote:
> Anderson Nascimento reported a use-after-free splat in tcp_twsk_unique()
> with nice analysis.
> 
> Since commit ec94c2696f0b ("tcp/dccp: avoid one atomic operation for
> timewait hashdance"), inet_twsk_hashdance() sets TIME-WAIT socket's
> sk_refcnt after putting it into ehash and releasing the bucket lock.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().
    https://git.kernel.org/netdev/net/c/f2db7230f73a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



