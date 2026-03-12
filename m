Return-Path: <netdev+bounces-267210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAGYARQms2kMSwAAu9opvQ
	(envelope-from <netdev+bounces-267210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73241279874
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05077305DB94
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CCA346FB3;
	Thu, 12 Mar 2026 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaWn1mOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBC26C3BD
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348010; cv=none; b=s0xpOAbancbqsrApOPoRZi48VaOYwqooV+tq/3AXVfXFhhEYnEbeaMy4uzEtZs9RfO1TPamg01Lu/6XuzG1X+4WQhLLo60HY6KhdpQQPIdJODHZtWRao2yU93uiS4ggv2vE2obFnY1+YnA+dqXI62XPm4qh8s76heL5ObD2TQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348010; c=relaxed/simple;
	bh=4Ll0LznFTgnUowS2n8puUk9wvUp/PtShOxWtDQsAMaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dnRpNGdjuLChI2+Z6ntvDkiQns+Nmq1fEzgw7Hhw47YWg5LeTvCVBVw6hKc/3WwM1eI6KSB2rQnPfY8tSdn3NU+13fbcIO2M5P3xvNE5DbHiokNJaXFUcuFe85aUXsga3NSGa0RVucVYrCoQ4RVOr5tbwqOuauvcKGNcsPAU0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaWn1mOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B6AC19425;
	Thu, 12 Mar 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348010;
	bh=4Ll0LznFTgnUowS2n8puUk9wvUp/PtShOxWtDQsAMaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MaWn1mOe7L5aQz8ZqPZG6kBA0AcHbLobgTMnc7sU8DO2n13u0cDS0BV8qHgvoDCKP
	 ngc9IEepv3uApw2BFMr9kCqAi+SHQqS2M3YqOkBDIfiMMkKFdwWLoSp7TQ1GkPnqRc
	 plynsnflbVtbhKtUi6j8WJbB2/R2G3y8tPrIBzrd7h3A4PyhXty4nxBSnW3s/wRCBZ
	 kYvwGD6yD4sWTJ5joM3eyywLEYWhC7LwjsjbI/O8P4aS+/pwGWUU8AdIywvXx20dfY
	 ZfJOevQozGMnt9lC3X+clSxL7kicyPoPZThADoQM7KjIyoGvlXXGZp5APGNSpb2z42
	 7EVKnro2L0Spg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030193808200;
	Thu, 12 Mar 2026 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] af_unix: Give up GC if MSG_PEEK intervened.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177334800580.549113.8658019831602946307.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 20:40:05 +0000
References: <20260311054043.1231316-1-kuniyu@google.com>
In-Reply-To: <20260311054043.1231316-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 torvalds@linuxfoundation.org, netdev@vger.kernel.org, sysroot314@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linuxfoundation.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267210-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73241279874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 05:40:40 +0000 you wrote:
> Igor Ushakov reported that GC purged the receive queue of
> an alive socket due to a race with MSG_PEEK with a nice repro.
> 
> This is the exact same issue previously fixed by commit
> cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").
> 
> After GC was replaced with the current algorithm, the cited
> commit removed the locking dance in unix_peek_fds() and
> reintroduced the same issue.
> 
> [...]

Here is the summary with links:
  - [v3,net] af_unix: Give up GC if MSG_PEEK intervened.
    https://git.kernel.org/netdev/net/c/e5b31d988a41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



