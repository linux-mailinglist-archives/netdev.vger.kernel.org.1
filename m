Return-Path: <netdev+bounces-273535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGewCmeOy2kuIwYAu9opvQ
	(envelope-from <netdev+bounces-273535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:05:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99049366AE3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03D0F3022572
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFA3ECBD9;
	Tue, 31 Mar 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6POi2pN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5613ECBCD
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947622; cv=none; b=XbN2AP4cRgq993FvzgfRz+BAZ6/TwbZG92v5LPP03jGNH+Ul1IS3jHRut8COk+dOV78EmGjlVcbGKNjNay9oGqwsq9519tukt9Tu2Ucn8kZGfgNtbhZquFaJwXRaCqaDvknoYtSjRzPCe433a477qAp0nVg67cc4EbZysUZXsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947622; c=relaxed/simple;
	bh=BHV8FOomuN9CNlk1VQf3MLW6YCYGdPlzGQvxnVFF3tE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sej9ABlaiERo55hhUJz/k4GAO/XF5ACitKwde9P+cXiVxGAKo3+CYS5YB+YB8szDt3rRX22girJx1g7qq+uGFslNfjdLikdgVvu3zWPON/TYFiAUorhc0Ei77vmNlQ3tgMZ8pVvNoGoruR50H67EXG4Y+F0gk9gw8gk9ParxDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6POi2pN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AE4C2BCB0;
	Tue, 31 Mar 2026 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774947621;
	bh=BHV8FOomuN9CNlk1VQf3MLW6YCYGdPlzGQvxnVFF3tE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D6POi2pNf6MhN84pwDj7TciFAHxmE2ZEBGn6+kCdeQAodYbOenZ/Yw7jezg3KRuuY
	 U+dHmQojUj1U1rObRM3N2Bp37i3Nqfx0dU6uVCXxPmsmNkFYz0kDKpXrKwk+W0wbrd
	 kACJtcRpI4u1ycRaOdHa7U8BX/Jar2M3fWa0wgDqsGXp14rn6hCKFXW51MYGNEojBY
	 AWGCx7NI+ZtCu4P1fDycR2xml3Ja7YRLPj8gRzRD9zirM9HSHQzjbAPihY+w0E2Dy1
	 MKVlY+n5ZgT2RanmXbQAXZik8Uc3XtJj28wnChvMw8P7J3OU64BfYlM6562XY2TfMH
	 cWwRJbz6Xblig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DD8392FF56;
	Tue, 31 Mar 2026 09:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: bonding: fix use-after-free in
 bond_xmit_broadcast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177494760554.2186964.8180525366556770901.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 09:00:05 +0000
References: <20260326075553.3960562-1-xmei5@asu.edu>
In-Reply-To: <20260326075553.3960562-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bestswngs@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-273535-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99049366AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Mar 2026 00:55:53 -0700 you wrote:
> bond_xmit_broadcast() reuses the original skb for the last slave
> (determined by bond_is_last_slave()) and clones it for others.
> Concurrent slave enslave/release can mutate the slave list during
> RCU-protected iteration, changing which slave is "last" mid-loop.
> This causes the original skb to be double-consumed (double-freed).
> 
> Replace the racy bond_is_last_slave() check with a simple index
> comparison (i + 1 == slaves_count) against the pre-snapshot slave
> count taken via READ_ONCE() before the loop.  This preserves the
> zero-copy optimization for the last slave while making the "last"
> determination stable against concurrent list mutations.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: bonding: fix use-after-free in bond_xmit_broadcast()
    https://git.kernel.org/netdev/net/c/2884bf72fb8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



