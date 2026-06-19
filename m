Return-Path: <netdev+bounces-300579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2y/ABq+bNGrScgYAu9opvQ
	(envelope-from <netdev+bounces-300579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:30:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508C6A38DA
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:30:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AOTOggpO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300579-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300579-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80343020A74
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A333065C;
	Fri, 19 Jun 2026 01:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382532BF41;
	Fri, 19 Jun 2026 01:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832616; cv=none; b=cdrPKTnk98Dmce8jF8zwX8SvbI2OrULg4KILMpB4FC2+WMGyvE9RdN825xEE5CTSOkGCGH5TXgzni/1omHxbHt1XAYFEVkDUCXAw8pz4pCtevsR9owg9RCasjop+PYXbnro8n+BAtQrdlgKpOU1r6qYahp4DUoXmIhKjDWMgJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832616; c=relaxed/simple;
	bh=rqCnPt9UWQZ9N+SmSwpSAaHSK2BHtDKJuRz5iVjhGvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JQgKPsErQxAeeF5gfJ0WrtHSwb2lMtYDeb0Zi62NncvB0p/KfnFTY3zvzagCyhAAGGNoMg1ad0LjtC5SnRPMqExKPYnYonmjYuIP9x/JGXduUhlzGnKI7AHYPQpPUnpWrKaTBQWt+DiPbEz3FOyoUTZo4pHuP3x51SVeHBwlsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOTOggpO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152551F00A3A;
	Fri, 19 Jun 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832615;
	bh=CQxFkWboFGY2OsfQJ3ndg7wjlp98H8xEd0k8qSRbFso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AOTOggpOlB2ik6dai44yjrLeCU67F85692QJo9+cBsqTA0OnynuxvJDq8zkECGiUz
	 eBdSuD7Cz6URTMS4kKEdnF+71KPj3Do0eSuIJ0sNTlCjHmBjFDzX/CBer/DMabCLZn
	 zE2R1i0/T6k+XrB8icjKEKo+uB3c+VXw6tHWk1aODQ4ypmVc2ypmyRRN3ug96yjUgN
	 MAppPykLxZHeM+dO0dgMXhxmoODoDiQlW/HBRTpSwPHKvnCUyU4IW471bz8C0VKjKD
	 IAiKCfWyU4nmAGrpoSfWyM3aJShLG34H2Reh9g0tCAI+seRhfrpOFMcsjCd7C5mDOe
	 4TM9gNuK+ONVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939963A78A7C;
	Fri, 19 Jun 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] selftests: net: fix file owner for
 broadcast_ether_dst
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183260813.3153236.3577914361274386462.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:30:08 +0000
References: <20260617061039.79717-1-ross.porter@canonical.com>
In-Reply-To: <20260617061039.79717-1-ross.porter@canonical.com>
To: Ross Porter <ross.porter@canonical.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, oscmaes92@gmail.com, bacs@librecast.net,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300579-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,librecast.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:ross.porter@canonical.com,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:oscmaes92@gmail.com,m:bacs@librecast.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6508C6A38DA

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 18:10:38 +1200 you wrote:
> The broadcast_ether_dst test can spuriously fail due to file
> permissions, depending on which flags tcpdump is compiled with: If
> tcpdump is compiled with the `--with-user` flag then tcpdump will
> step down to the provided user after opening the device. In this
> case the test fails due to permission issues, as the output file
> is owned by a different user.
> Debian ships tcpdump with this flag enabled, so this bug
> appears as part of our kernel testing.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] selftests: net: fix file owner for broadcast_ether_dst test
    https://git.kernel.org/netdev/net/c/b8613e979200

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



