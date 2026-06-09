Return-Path: <netdev+bounces-296799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M4PROsFeJ2oevQIAu9opvQ
	(envelope-from <netdev+bounces-296799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47F65B595
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="D/LUZLLn";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296799-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 935A83088156
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8D267B05;
	Tue,  9 Jun 2026 00:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479AC253B42;
	Tue,  9 Jun 2026 00:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965019; cv=none; b=G/4VcpajIL1kfYTVSocu1pCqjNxPevFMZ2gwA94yNJzgyBsLuAYTPlCSRZPIGFzQo6MjxOyUBokAxPYP1sQ1yGKl+u8+tuePZM3PDFylOtTBzCjI1H/Vu9fEfFSfgZsekEr1k1w/T5Pqyo6yQhtNqYq3z4S7J4SeYH+1/uiJseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965019; c=relaxed/simple;
	bh=/r7UX83fksvvC8dPRln3Smk45KDY8bpvY9ya0AJWu70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sGzSKFfgA3AtvLZLZi6BwjMLSe1NkJNZvF4cH1fEmve5vAROJzhq0CQlXYBQvQ064nmyHjpMeTbrzWWU7DXggH0dLbzIknZkeDrY2UOY7zApG78OWY/+WZT5eoMPNZmHuybFaHZKeoREJJkszMb3eKU+m+R3KqiGHsXPtA2a8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/LUZLLn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2191F00898;
	Tue,  9 Jun 2026 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965018;
	bh=4y8HAiyOMRqIk+A63W6o980Kd5PM76PlpzNJJUSR1MM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D/LUZLLn2QiEEW5sY3F9Z25HW8TyxZgn8fjglzI3hF3SF8pTQkVEG2wqQWZC8n7Nk
	 xo8GSthux40/zBdtpwhi/qJ69q0zbDv5jZ6ATecp58rvai62ZWPqwHZK9NmZVRZP/N
	 ZovSEcrd6JvcGLtyXPEJjupgqMJIRMkXjBiMluHe2IUl6NNZofRWQFLeIZ4bhzreJT
	 q7CqR+129BFfVco/sHomnObJY0Oscv34zn9KTurTfsOfcjh6SmFzSR2NJGhpMm8+lq
	 zwbscw/Dleik+GfstfnfcDkqtYUyayz5pv+LHVHGwu33blgpXjXqEpcKoJDcEMA7AX
	 T8AKyJpMYM8GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197523812FDA;
	Tue,  9 Jun 2026 00:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] net: ibm: emac: mal: fix unchecked platform_get_irq
 return values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096501664.1726280.10497532304483486994.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:30:16 +0000
References: <20260603211734.30750-1-rosenp@gmail.com>
In-Reply-To: <20260603211734.30750-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296799-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C47F65B595

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 14:17:34 -0700 you wrote:
> platform_get_irq() returns a negative errno on failure.
> Commit c4f5d0454cab5 moved the platform_get_irq() calls and explicitly
> removed the error checks that were previously present, claiming
> devm_request_irq() can handle it. However, a negative IRQ number
> passed to devm_request_irq() fails with -EINVAL instead of
> propagating the real error from platform_get_irq().
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] net: ibm: emac: mal: fix unchecked platform_get_irq return values
    https://git.kernel.org/netdev/net-next/c/8084fc9292c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



