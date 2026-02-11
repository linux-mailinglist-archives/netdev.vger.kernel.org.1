Return-Path: <netdev+bounces-258196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vUQwFTYPjGn9fgAAu9opvQ
	(envelope-from <netdev+bounces-258196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:10:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF31214B2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5D8B3009882
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12C33FE33;
	Wed, 11 Feb 2026 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlzW3tW+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F13327BF3
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786610; cv=none; b=OoNAEJSBUF06EOtQR/OF6w8O/erdHfqdLyjd5G6MMvF/DvnSWhj93oLYfnmuwxyYCRJ7GEczFa8MreNm2NlTsth7RzMUwxG1akso31MDZIYskW13lFLxE1yDyhpiQw4ZurZtUo9ttyqsWCij5+MN+jjRww5ga6JjBM5G01zwX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786610; c=relaxed/simple;
	bh=2Wsk9J6KBxK3iA8HSQ84vhrIO8hdJFvwB7BYJoWDo8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nDDWr0SExrrqY09QSEzh1kfB5si49aMY8IJ9LMW+P4XOdzgRAqnwbcklEaB4Tz8hhSQR3GqRtCbWw1FgEuLrZclTYC5swYl7DKQ90N0Hzgp0cUFFm6qwODOcKwAU6zndmElxctMURUwIMuYGpkTeQ67D0e3XdE3DpxoPPUE1FUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlzW3tW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7127C4CEF7;
	Wed, 11 Feb 2026 05:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770786609;
	bh=2Wsk9J6KBxK3iA8HSQ84vhrIO8hdJFvwB7BYJoWDo8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DlzW3tW+aGIoaQuNTRsaSoJvnZPm3i1vpqB+Uaqc+Ytg1aaBOTWtRLKSHcDpCbHO+
	 00VF7EYT9BUx3TL+/QbMnKelEN86NcEJRaKHbvF71v2IgDu4rclsRLaGPf55ebfJoF
	 DdAh9o7+THj8dwpJ9FibmxqHYT2UalzDXvNWBZlVR71Hmqdm0Aqza8rVH5KR904AVT
	 QDmlsVLMOjOBPr39KloKb7fu68D7jEAqCi38EgDFhJD5YxLoP7Ppg2S3d8b00YgTWS
	 YcxuNAj61mYb8uwYmfXAzuY7XULd2bUuDy9XINGpVWKmTyFCiDFYDEajE1eXc3vnTE
	 McZc7hCJYszOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B07B380AA50;
	Wed, 11 Feb 2026 05:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: Rate limit unknown xcvr type messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078660483.7583.7365563668694669374.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 05:10:04 +0000
References: <20260206224651.1491-1-eric.joyner@amd.com>
In-Reply-To: <20260206224651.1491-1-eric.joyner@amd.com>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258196-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5AF31214B2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Feb 2026 14:46:51 -0800 you wrote:
> Running ethtool repeatedly with a transceiver unknown to the driver or
> firmware will cause the driver to spam the kernel logs with "unknown
> xcvr type" messages which can distract from real issues; and this isn't
> interesting information outside of debugging. Fix this by rate limiting
> the output so that there are still notifications but not so many that
> they flood the log.
> 
> [...]

Here is the summary with links:
  - [net] ionic: Rate limit unknown xcvr type messages
    https://git.kernel.org/netdev/net/c/cdb1634de3bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



