Return-Path: <netdev+bounces-290986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ1AIuL3EGoxgAYAu9opvQ
	(envelope-from <netdev+bounces-290986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:42:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E005BC20F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08B75301D334
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866B1F419A;
	Sat, 23 May 2026 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmTFVVr/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23DB1D86FF
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496828; cv=none; b=GSEjjn918TAIV+IYEnEI1n0zeGtnc1AXzoGVNRqLRVpUz4aQRoxRKnWZ7J09q5F45c6vvHuELiE+LiQ9PAKyu+Ou3mx4YC2wdIiBCjMyEeFWdb7EsYmc4Ki1gfJxorf1IG8T0ancngFsEaK9ucSg/yC0hTS6gO/u9fyd3sTrPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496828; c=relaxed/simple;
	bh=qbJhAF7p05KJL7a8fbmy5h/QOaM87c25sMW0GIN/UQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D8LxCqX8X77Nciqzj3GhxWMVHrYCcOk7/nx/WIc7dHFC65wD0Y4c+6l9NeqtDqWt4ZkYEQGDxWu5Hb3hDL41Af7p/dBfkOO4wFk96mgbAhjXjByZ6pUEiVj6dqb6KcRuNnnSjxJOZcWAM5NAl/+Kqv1qA4+yooCI/Sx+KtKgU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmTFVVr/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4161F00A3E;
	Sat, 23 May 2026 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496824;
	bh=iN57Mi4Wz0yAXoM64Y2BAnBtuasqdeM0ZWYiNG6dT1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hmTFVVr/D7Jcn/51kAsrzcyMZyFVqFlvsnBgMObsxlBdkH6NomW0gQCOpNwK3ACi8
	 tqwpSs6wRv80/G0IxMNtcTD1FnajKULKIO1+pE1aNb0tqnLME/g/4sjzsJSHj+aJqT
	 rZ0OtsLBloKZAWpuqEPayLQNJvoik4VZXWA/1JwTc+9Mp4uy0kIT2jTQY001Ugj83J
	 ZOf0hS0is2cuj1IIw58gddB70FHb3m5RPwLQjVwD5lQp2XbLeiTmzK/bmdmJCWFENx
	 x4sadke+f7kPUQNOu0pvOhQdvzxHcDR4omsah7LpsbLIvnyxPylgHQrcTbp9foRtR/
	 b5BMgE+671FIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93914393100F;
	Sat, 23 May 2026 00:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rtnetlink: do not use RTNL in rtnl_af_register()
 and
 rtnl_af_unregister()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949683314.1426243.13346631798945431019.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:40:33 +0000
References: <20260521174038.204481-1-edumazet@google.com>
In-Reply-To: <20260521174038.204481-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290986-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 06E005BC20F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 17:40:38 +0000 you wrote:
> rtnl_af_lookup() does not rely on RTNL anymoe, remove the stale
> ASSERT_RTNL().
> 
> Add a private spinlock (rtnl_af_ops_lock) to protect rtnl_af_ops
> list instead of using RTNL.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] rtnetlink: do not use RTNL in rtnl_af_register() and rtnl_af_unregister()
    https://git.kernel.org/netdev/net-next/c/b8de39a06535

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



