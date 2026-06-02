Return-Path: <netdev+bounces-293980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HnRFh5FHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:51:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D110062768C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE45430611AD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB68369D6D;
	Tue,  2 Jun 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYf57x23"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C57369206
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368616; cv=none; b=eo+1n5y8HNCiPF04jN7YRTWU2iz7nIOIaRE8pjLOuVMmSsYOfoTWFGvkLTmyNs9yQ+UgMWPjDUvX6tGiGjIho/LeZD6C6pH+6ZTlfaa6o2KBCuMWJXXgpSkuRahMI69u0Z5QMPauE9KPq6pJKBEU+izdDzclhUIa55YRhIXJHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368616; c=relaxed/simple;
	bh=JB+phtUTb3WzFVRLog49ztcJWE2W4yGxfF+gcew9lrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eqDwtEPAB2zBo2LrMGrwazHSFjtsIQpRDYOUZaoNtDKYUj5eD0DRWeT6WXXoCvXqs1H7CP463r1p0V2/BfY6KyKWK8V8KTTk6YVXajyTowQSmIXe5NRjKvjCLC1q8/JzwplKpzEcSNhcr9BpXwpIH+HEmg+Z+4B9t63zYB3akFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYf57x23; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B64A1F00893;
	Tue,  2 Jun 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368615;
	bh=dqd0/8D0VKZfLvDiH3sAfol3DvHhaUTBPG57AlmijKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SYf57x23LcDEVBI01/WZaPsP/pIZO6C7nEHkM+IVctwue9lnnjNl7AivvbHs1zH5k
	 66/i4xHcZE8J2iRYeyxoHLbtfhx4y+ZSNKS6dV6KAhI657mGCcwYv5ncyIiECDLVuv
	 dXpHfENOZjYivweAT/8iGMaTGD9u0dDT/UmWz29Z4Aa4o/jCcvvqWFwEbtKSakHSlk
	 IssagNde/UCiWBldeqHIhHELKtiZVcfOnyIaQLm0V1nk2sZTIgovO62rWHs2eIGzYp
	 0Ww/oI0axnakqc/E9vJuTjlKROmMHI3kfrjKz/k+Zo3G9Lw4rODEayOJ8a2bQSgDnp
	 0vimoKt5Mk/yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391238119F9;
	Tue,  2 Jun 2026 02:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: txgbe: fix phylink leak on AML init failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036861714.217677.1789667062425965646.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:50:17 +0000
References: <20260528013258.129146-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260528013258.129146-1-zhaochenguang@kylinos.cn>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[kylinos.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-293980-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.628];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: D110062768C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 09:32:58 +0800 you wrote:
> Destroy the phylink instance when fixed-link setup fails.
> 
> Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: txgbe: fix phylink leak on AML init failure
    https://git.kernel.org/netdev/net-next/c/9c89f975e669

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



