Return-Path: <netdev+bounces-216707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB653B34FB2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D31207EB7
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D8E2C3261;
	Mon, 25 Aug 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af/mVhQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE82C2343
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164605; cv=none; b=RIOqrj7h1LeAMc2jzSwgtWUowqloAmF6hIYq9N1yNbR05CaXKvJM/Sk8VqjrCmFgJ8mo5Te1olpmgF9Ug1E7MlgxmwYlwz35oeXp6wQ17F59JUsQnhg+BhplJn6rgMA/JecqpONm4x87wg9/IfseUxBEeKqjPR23CaevgG2u3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164605; c=relaxed/simple;
	bh=5+bdL5JUsFowFV2U9GEQmj2JYrehl6riT0aFZFB32tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uV5c4jC4w8hRgt2SN2Sfwu9TAcpmG9x490Z5ciqlCTJ60IkTbO0WCgPNOu9D0jnNZzcqr81rLjXL3/V5XI9bWt4sHzxN+pOxiwftp0ow6HWLEJnMNmkbpFGxAwPUIwQI69XGpx7ra2gWFSW66cGjlfMp/I5E1VxUE2qUMgMzgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af/mVhQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553EEC4CEF4;
	Mon, 25 Aug 2025 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756164605;
	bh=5+bdL5JUsFowFV2U9GEQmj2JYrehl6riT0aFZFB32tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=af/mVhQnOhIHbXHDGAXK6+Ll7e1ou/cNJIsnaue77ceFsL9J9GC0ubhxNV8FeXej/
	 EmMGkQzUYKzH7ijg1M+dyeDau5gcBlp5kVe3cDjblL4HaizJ1hY88OgR+Vh2o7rbSI
	 IXwCzzt5kv67lUc0smSyYybMa3O1VumDoujT56sNmqiKlnd1DPyOnW7rm21o58O5dC
	 OXXIr741Xq/I4KUIm6Qb5dZh57MLBi6gMhUwAj5doeQ7OtOgGREyIXmZ0A/f0YbNot
	 dVcCDX5oBnvBd1AdCfxf41GydHHzTM8a40q/K9qL2q3P3NDax5rGo5Wk3a83Iq8mCL
	 QLwi5vAGoSJug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBB383BF70;
	Mon, 25 Aug 2025 23:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: annotate data-races around
 icsk_retransmits
 and icsk_probes_out
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616461324.3594857.17395313375711810598.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 23:30:13 +0000
References: <20250822091727.835869-1-edumazet@google.com>
In-Reply-To: <20250822091727.835869-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 09:17:24 +0000 you wrote:
> icsk->icsk_retransmits is read locklessly from inet_sk_diag_fill(),
> tcp_get_timestamping_opt_stats, get_tcp4_sock() and get_tcp6_sock().
> 
> icsk->icsk_probes_out is read locklessly from inet_sk_diag_fill(),
> get_tcp4_sock() and get_tcp6_sock().
> 
> Add corresponding READ_ONCE()/WRITE_ONCE() annotations.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: annotate data-races around icsk->icsk_retransmits
    https://git.kernel.org/netdev/net-next/c/e6f178be3c12
  - [net-next,2/2] tcp: annotate data-races around icsk->icsk_probes_out
    https://git.kernel.org/netdev/net-next/c/9bd999eb35cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



