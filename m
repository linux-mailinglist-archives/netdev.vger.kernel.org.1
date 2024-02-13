Return-Path: <netdev+bounces-71275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF1852E2E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8C8281C4A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712F249F3;
	Tue, 13 Feb 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAxAwuyk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110524211
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820827; cv=none; b=Z3j/9XyUH5E4REYPi/34Yz/PP1ULLJcOLtS374zhRKlAHggD0K44je7XHfImmjZqQ249pHdWEgfKTewwl25pGI7tu7UTiWOW5A67MQ/wHBtCpoegOtatQDagvzmmXPvjg3XzAGSxFI6UNEdI1g2Vlvx7xY268+1kBrVV5Md67vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820827; c=relaxed/simple;
	bh=uIX/I29Mo/L/azA+K48J+w2yoBKIiTMLqCasSoVpILU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VU4SJk44JdQ3OgzPs/hPLiMIzc/bgQfQHTh4Ak3X8yKjNETP1lNdGsn8d06hW4H2/GURol3H8yInDA6my4vbx6b772GdJxs5B8q0HpFoiLJQOhg6p1MV6noe6hZup2TgzCJP4st5QT34O64elGaFO+i5RnkHLdjF3TGZqDaR/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAxAwuyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31036C433B1;
	Tue, 13 Feb 2024 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707820827;
	bh=uIX/I29Mo/L/azA+K48J+w2yoBKIiTMLqCasSoVpILU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uAxAwuykCoP5jAdr+1gXK5U4W23yNwoozWLFDDcJ8CC7I3YsamtLDdAN6stkMtvMD
	 5RelOzzKeo8B4QO174XzmBw9BIXDT2PrmSlvMRiRznRwZGrrzSqWgYPqIzO4x1zF5J
	 dZqTcypI9dD6Mm+KKp7orsQfW/pfl4w8phkDpflS5deYerD6Yd4KIC5hCtHQmDL/PO
	 9jz457G+wM6GnOONK8E5Ub6FLrUQtY19UQoDchizpkQT+QTQ1gBZOesMOObAivF7ps
	 yBMqQogDf00rkaV9ENGRn60NMv4GRtsrV4Sd552dGZgn8gFA093rmLgqubd9LsM08s
	 IA5O5a1je8P0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A43DC1614E;
	Tue, 13 Feb 2024 10:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Fix task hung while purging oob_skb in GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170782082710.6419.2279357982489740229.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 10:40:27 +0000
References: <20240209220453.96053-1-kuniyu@amazon.com>
In-Reply-To: <20240209220453.96053-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 9 Feb 2024 14:04:53 -0800 you wrote:
> syzbot reported a task hung; at the same time, GC was looping infinitely
> in list_for_each_entry_safe() for OOB skb.  [0]
> 
> syzbot demonstrated that the list_for_each_entry_safe() was not actually
> safe in this case.
> 
> A single skb could have references for multiple sockets.  If we free such
> a skb in the list_for_each_entry_safe(), the current and next sockets could
> be unlinked in a single iteration.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Fix task hung while purging oob_skb in GC.
    https://git.kernel.org/netdev/net/c/25236c91b5ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



