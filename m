Return-Path: <netdev+bounces-231279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C80BF6F03
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D5F1890DAE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40492F0698;
	Tue, 21 Oct 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u37/Xexc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4823E334
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055225; cv=none; b=F82H/S7KcfmwdQxph1E+9Zx2+vtRhLc+aevlW7aw9nDzGD3ejNzCiaL5DglORgryhB/U08XrZdirR3vRGzpedy+wG6b+A7DwkvlJHFh/EiOHSLgXWNXEH4EXE/6EQuKIPEZwePjTpuj7QF6SdIZl34zBS+80HzlIamqQlBS+qP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055225; c=relaxed/simple;
	bh=oMEQUp/7UGlxhJdj8FlUlqkOxmA0Jqu8fL1JETsy/LQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MOf7oJblZ0LNhyIrsZG9/qC6+7CqewGu3kRonXkxdk0f6nny1oOWn5fx3KKqVVZxWZ4Qn69L0v/rNGGZeau2eoWMbD8Vav5oanbo6qkWy3aA4D8L3MdynsM6qRemCHkm2/z/qCd2cixhhNMW/hhZBjHzrNADgTpdkzb0brTWwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u37/Xexc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3918BC4CEF1;
	Tue, 21 Oct 2025 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761055225;
	bh=oMEQUp/7UGlxhJdj8FlUlqkOxmA0Jqu8fL1JETsy/LQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u37/Xexc7G+s+Ww4eI1KpABvVYTAgwV+891D179wOgxL4hOwKr0261fzsVHaVr7LG
	 zRZ3ju+7BGhQXBFc39YC1+XJAz+y3nVpD5kIuqvScMrJt5vcinWlCHRpe40FIGTxxd
	 gp/7l83t/MHKCNQ9ilw8Yhl/DosOReqAS6toTNmWJjx0a5x8jv6EWTFNkQUMUJ1M9Q
	 n+m2MQS1Rg9vlFqyb0skv2Ni1VczdWvzUwJn7sCimPDGgmLkb5lNGvzWTbq0XWx0wB
	 zDK3QZBF30SBPvCMpJ7JIeBPzxAMpurYyQaVzOOx/vHwtPIuXMKeCGcqjGJljrKAmc
	 yyr7V5vnb2KUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1CE3A55F85;
	Tue, 21 Oct 2025 14:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: avoid extra acces to sk->sk_wmem_alloc in
 sock_wfree()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176105520683.1093757.15942345339550067934.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 14:00:06 +0000
References: <20251017133712.2842665-1-edumazet@google.com>
In-Reply-To: <20251017133712.2842665-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Oct 2025 13:37:12 +0000 you wrote:
> UDP TX packets destructor is sock_wfree().
> 
> It suffers from a cache line bouncing in sock_def_write_space_wfree().
> 
> Instead of reading sk->sk_wmem_alloc after we just did an atomic RMW
> on it, use __refcount_sub_and_test() to get the old value for free,
> and pass the new value to sock_def_write_space_wfree().
> 
> [...]

Here is the summary with links:
  - [net-next] net: avoid extra acces to sk->sk_wmem_alloc in sock_wfree()
    https://git.kernel.org/netdev/net-next/c/3ff9bcecce83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



