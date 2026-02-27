Return-Path: <netdev+bounces-261690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGfHJNAPoWlDqAQAu9opvQ
	(envelope-from <netdev+bounces-261690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2C71B243A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E7430B4825
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8332BF26;
	Fri, 27 Feb 2026 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR8lHz63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F932B997;
	Fri, 27 Feb 2026 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163012; cv=none; b=aFeo1V4FEo0kKaV5GleeOZmvGhkt4UHbtBy7ri/R7itth5VI3tPQPn0gbmVgbPnbB8WMpjLKt1zIrpoOn3bmueKUB0z/vbh0ME2TzNJ5Udwp1w0HpY3uV3qkrqFiHMj7DRlXC79rcc7ji6du8jNcdlqTwA86hQ5sYyRkwDGJnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163012; c=relaxed/simple;
	bh=phc4cEunpmXR7caKrnfBjErtANR8e3xbIcsM/an6w0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbY9BVZqUQOvhHYkAq7DJgwpeB0+6bKxZNW1ye3+JUdFohvF/BPu/azIuAqtqSIvzXSf+Nnll8DuBZ6q5LpkTW+DL1jwmpLSehHgPzpJs1OzuHrx3KljX4apJ0BVjktpMwGMF5+tl0l2+d4iUykHgLHCoeQK8BjojCaYvEsXfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR8lHz63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA58C19423;
	Fri, 27 Feb 2026 03:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163012;
	bh=phc4cEunpmXR7caKrnfBjErtANR8e3xbIcsM/an6w0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AR8lHz63a2VHQMotrj0P60JX6OTuJS+QF2Nykj1TI5H3MvvSMGNxaKd19Z6hfjUri
	 pBR7O4olaMXW7du4LWc0W4Lh+cKwYBqqiw9huY35R4sfKfPFI8PZjP11QJLVrcp5me
	 BVpdvssyaRmVvfOcxTGvMSWqsjgbRYxGQdoXeGLj7PqnKuCEou16ocuYi3Kh1Gy5kD
	 cAL9yo1ZTFyugUVjdm6Zt6fmRffUES1/tmSvRaq1sGUQXC4isZ5gv+bQH7bz1Wx+w6
	 01ki9Y78D5nr5HTBvzu5tAPAylUmFvJUFGIWUKQJrcK6MkAD4uWP57Lpol/4RtAFVP
	 DEPV3r1t8nPbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF1E393109B;
	Fri, 27 Feb 2026 03:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: atlantic: fix reading SFP module info on
 some AQC100 cards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216301603.1958105.14900113839246297319.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:30:16 +0000
References: <20260225002026.1754045-1-thubble@thubble.ca>
In-Reply-To: <20260225002026.1754045-1-thubble@thubble.ca>
To: Tiernan Hubble <thubble@thubble.ca>
Cc: irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261690-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF2C71B243A
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 18:20:25 -0600 you wrote:
> Commit 853a2944aaf3 ("net: atlantic: support reading SFP module info")
> added support for reading SFP module info on AQC100-based cards. However,
> it only supports reading directly from the controller's hardware
> registers, and this does not seem to be supported on certain cards,
> including my TRENDnet TEG-10GECSFP V3. "ethtool -m" times out when reading
> certain registers, even when I increase the read poll timeout values.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: atlantic: fix reading SFP module info on some AQC100 cards
    https://git.kernel.org/netdev/net-next/c/b70190d767be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



