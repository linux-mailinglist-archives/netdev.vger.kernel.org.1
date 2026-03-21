Return-Path: <netdev+bounces-270148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wpAKFLP7vWkgEwMAu9opvQ
	(envelope-from <netdev+bounces-270148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:00:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B822E2D84
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9303027944
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66362266581;
	Sat, 21 Mar 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHQUmo5A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA9175A8A;
	Sat, 21 Mar 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774058415; cv=none; b=f/c/U/FAOIPsoaqxbIyd6hbqwEiXvVYPRDcigtQJPM39TfV/WlSJuk0j8wpa3Rp07I0kFBm4eX/iA7nhfszqFYW/BY/lwJnjHzNwWkO6p0gsI+solQk0Ndbexp5NVPf+DD37u3OPflhWJgtZiCic1HMD6Mgqx4R5otTW4RpSxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774058415; c=relaxed/simple;
	bh=jSFJx1GaeQHqMMDYFYx6cOZmFp8yAW8+gY0ttTRYwLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qpk1WQIK+xoW3JDjQaE3Vy5oICz3Gv7i7aptN1UiNmCxIHl0gGTX5lAZGhdfCIfcxbekSSmt+89m5jTM5vGcH6bFwsesZYpLUGKLG5Jn9x9De4RHpZCI/cYcGPH5Y8pTe4TYGMMfZNDszAqfcyN+9IvIHwoNdqn06LZSJFf1kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHQUmo5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D5DC4CEF7;
	Sat, 21 Mar 2026 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774058414;
	bh=jSFJx1GaeQHqMMDYFYx6cOZmFp8yAW8+gY0ttTRYwLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sHQUmo5AhhLqdA8+1mxhxKqXm2ydnxeuspDh1aGsXylSg4tSibmPulrw3JEH0yKGp
	 L0ZVDL7jyv5yOQH+GSOVxkdPBKGXSrPmIw/44ZAGLwpLWOiZuxYsFrcYm7GBLjYSqm
	 ooXqE/H0TG7Bb/WvHDCHAKXAsAJ/MAixvEaqzWrYmuBgrUgtsmMZcnijmkypmzISFF
	 PssoBF+xnhOz8LnW6DMu5qoSPqEN/E1Kq5JPqasJtUuWm7j/8IHxo93hesdwCNOYUy
	 EnDZ1Diu4QzmUJi4m3iaj8lbycJj4B/Q1vFOXTM52U9vsdtJA1MJ+c7ec4vLzSluyE
	 luX6Ne4bMHD8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EBC3808200;
	Sat, 21 Mar 2026 02:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: lan743x: fix SGMII detection on PCI1xxxx
 B0+
 during warm reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405840454.2721591.5803348695168085577.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 02:00:04 +0000
References: <20260318063228.17110-1-thangaraj.s@microchip.com>
In-Reply-To: <20260318063228.17110-1-thangaraj.s@microchip.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-270148-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: A0B822E2D84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 12:02:28 +0530 you wrote:
> A warm reset on boards using an EEPROM-only strap configuration (where
> no MAC address is set in the image) can cause the driver to incorrectly
> revert to RGMII mode. This occurs because the ENET_CONFIG_LOAD_STARTED
> bit may not persist or behave as expected.
> 
> Update pci11x1x_strap_get_status() to use revision-specific validation:
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: lan743x: fix SGMII detection on PCI1xxxx B0+ during warm reset
    https://git.kernel.org/netdev/net-next/c/e783e40fb689

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



