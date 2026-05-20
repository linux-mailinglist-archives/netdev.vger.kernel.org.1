Return-Path: <netdev+bounces-289723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNcjEwcdDWrZtQUAu9opvQ
	(envelope-from <netdev+bounces-289723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB3586D8C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBE38304B69E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92ED30274D;
	Wed, 20 May 2026 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyNmdiGt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921683033CB
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244198; cv=none; b=rF1NjVJyFpEt2kjBBqeR3Ltq/Eg1Jh0tpvslM/ARvIG4Bw66KpAYiSCBdMpjxo2ZSs0syIsZfW0VkiKFsHx3Psl4Q3zJTkuxhzCaS2f3oxg1VMN1kvdRfcyJ6JnuEGeU14S3Dj7ioJUYegN+GYU/t342FAK6ULgRH6FPTbcZLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244198; c=relaxed/simple;
	bh=NT0ip8ZnqhTqmY9UYkQQa6xN4koYqjXBSZlNBqZJ/8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DogNPFLLqX8A6mXln23k6VQrYBXx1qwdC7VM+WG6w4RSTWGq26g6e1Pct3pkMfeyvua1Tgm0SuPAfrr+EB33hzi+Zg9W9eZauEV8oP/v2EiJKKSQMEh6jd8Q/qrfVKRnWBGMVKA9Dtg3rWgaAAl4htzueYXijbHd2a6zisMW71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyNmdiGt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBA61F000E9;
	Wed, 20 May 2026 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779244197;
	bh=F1exHMrtcGVghEsmCAsMstryBc+/m8fA56it2S26bWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HyNmdiGt5R/JR/PEWMruJowJVrVFUBoBArNk2yL3scCcG8+pwsZw3/Qx+ju82QU/N
	 rUA0B9c/qJysi/4rQ96xgggRwrvFPQzl9evC4fQ8Fs26MvoQ61ovyj+gGY4FjD5vZE
	 HNVJmeVa6EqE4Dtnq8aiLiNp/oqfN3s7jDKHGvuRsPmLe/iyN/3DntxcmkQ2Ovc5B9
	 WZv8IscrSKp94O1GYynYNoSbpEpr8Gh6uxploB0GGZlzGUOKqbGT24nF62mkrXL2xN
	 RAQ7ayKDdCnH2Tq1ow7WSHT8W5HWIbLvM2PEGW7yDlmCGtnMu+/ofHvNOGFXjY2iCL
	 71gUzs4MRANzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D0383BF53;
	Wed, 20 May 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: fix error handling in pdsc_devcmd_wait
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924420789.2955096.17691182285422233632.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:30:07 +0000
References: <20260515212907.998028-1-nikhil.rao@amd.com>
In-Reply-To: <20260515212907.998028-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289723-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BAFB3586D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 21:29:05 +0000 you wrote:
> Fix two cases where pdsc_devcmd_wait() returns stale success from
> the completion register instead of an error:
> 
> 1. FW crash: If firmware stops running, the wait loop breaks early with
>    running=false. The condition "if ((!done || timeout) && running)" is
>    false, so error handling is bypassed and stale status is returned.
>    Check !running first and return -ENXIO.
> 
> [...]

Here is the summary with links:
  - [net] pds_core: fix error handling in pdsc_devcmd_wait
    https://git.kernel.org/netdev/net/c/0e46b6635b03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



