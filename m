Return-Path: <netdev+bounces-261157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OlqK+m7n2ktdgQAu9opvQ
	(envelope-from <netdev+bounces-261157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:20:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 387A91A0727
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80EB93015D86
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745038551D;
	Thu, 26 Feb 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgsK0sCb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132A32B99F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076007; cv=none; b=EynlrqQQEg0tT2egLDlrs25Nzf+4/BjM3POTxfgEuNqjPvgFeic5NvCPgJaywq9EZKGphZYhEuy8yjFhwe5jIaICf552t6L7kVAWDHxsaZaE0xEXO9PtKKcoD1TOK1I9bNs366TIsjXJckR2DlyNJaS4fUbirBSjuNPOvwvV85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076007; c=relaxed/simple;
	bh=AXFIRSjHXB3AC9Amsj68Q4lWvNZydmQVbVkBF4nDmak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lsiqCmEGhum7yA1Xm3nZuF8Ro/IJ6ffLaWDTR9gMLfyGFmyRcw3swGbG+JZvBJNXYjFx4H9RePSeOTIbSFmjqQVlMaBc4Hmp1yTsewmt+dxmdgN15qHwuz3K5iJxMDQa9wTZSHSMNl5RWK2DyN2UIPuIS5LVf9qB47XcHUqqjDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgsK0sCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD08C116D0;
	Thu, 26 Feb 2026 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076006;
	bh=AXFIRSjHXB3AC9Amsj68Q4lWvNZydmQVbVkBF4nDmak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgsK0sCbUPYYw3RmZwHHkPNrLwQmz26fnPUymAnrq3MJ1Qah9Cd/0tc9kMXNfk9lN
	 y+cQSaU3lXVZOFXYqrue/IVXBu98iTVwtdI7YKnsRURnn6fYvO7XXlEQy6/oQSKJ15
	 wYaekAtV3AVeTqE0ZkUNrS3VqCzbHso/ojfwIIju75eI5ejk+ZkggxDrwcQI8s22yI
	 NUkgkr/eXIFlYhEO/m70wtezJVr+7deOXropATM1yXG1pQZr8FWl58hkmmQ82T8qbJ
	 +LtVN1E/fFO9b+sss6xSNXj582eak9wCylA0o7heBE3Hf0SotD2g6jRqCn/+qwBOrp
	 EQp4/c3CBH9/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FD1380A94B;
	Thu, 26 Feb 2026 03:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] team: Fix reference count leak when changing
 port
 netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207601154.1018003.1626571189104356486.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:20:11 +0000
References: <20260224125709.317574-1-idosch@nvidia.com>
In-Reply-To: <20260224125709.317574-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, jiri@resnulli.us,
 andrew+netdev@lunn.ch, penguin-kernel@I-love.SAKURA.ne.jp,
 stfomichev@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,resnulli.us,lunn.ch,I-love.SAKURA.ne.jp,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-261157-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 387A91A0727
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 14:57:07 +0200 you wrote:
> Patch #1 fixes a reference count leak that was reported by syzkaller.
> The leak happens when a net device that is member in a team is changing
> netns. The fix is to align the team driver with the bond driver and have
> it suppress NETDEV_CHANGEMTU events for a net device that is being
> unregistered.
> 
> Without this change, the NETDEV_CHANGEMTU event causes inetdev_event()
> to recreate an inet device for this net device in its original netns,
> after it was previously destroyed upon NETDEV_UNREGISTER. Later on, when
> inetdev_event() receives a NETDEV_REGISTER event for this net device in
> the new nents, it simply leaks the reference:
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] team: avoid NETDEV_CHANGEMTU event when unregistering slave
    https://git.kernel.org/netdev/net/c/bb4c698633c0
  - [net,v3,2/2] selftests: team: Add a reference count leak test
    https://git.kernel.org/netdev/net/c/58f8ef625e23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



