Return-Path: <netdev+bounces-280852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BdsAClw6mlBzQIAu9opvQ
	(envelope-from <netdev+bounces-280852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:16:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0824569E8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5949A306EC7B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99C399013;
	Thu, 23 Apr 2026 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rompg8gT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D1639182F;
	Thu, 23 Apr 2026 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971462; cv=none; b=gojSjEXEQK85qSn4WvVONXrnCFwVICexMzpguxkiN0KEP0KSIQd9wEvxLI+2oJiLWmM75ZA3Z9iAKAb+rIWNCe/BiLvyj1U6owmYywjnooY+XodELLIWs5exoRCTDzdnWVM/HNBwkuHUf8n/GVuHgkxM55JKM+Tl5xpAR/yVQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971462; c=relaxed/simple;
	bh=vjVqVhvWxeMTiSxEEvA9MdqR8/azVIp0uegSPMDs8Uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FB5l1Dx87WQg/+lf6HAc+eZ2zRwtOwhSbt2PqSXtWDz7VI7z9HpVzRRdY3kDB3mjN0aUKG7lNUhgE3h6Y16e8FXwK5KKQQ7SddOKVHRTOL3taZr4Z/FYs2oj0YwyB3+4ele1LCbBkaDXFPXAdt8nydb1cMnTOFoxW4B+O3Xu4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rompg8gT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC8BC2BCB6;
	Thu, 23 Apr 2026 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971461;
	bh=vjVqVhvWxeMTiSxEEvA9MdqR8/azVIp0uegSPMDs8Uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rompg8gTHCFnpuS40Wiz3vHUbXWlWrHWfJzI4TrpKvxq5XuUY9+LEeGhB5oc5k/Tm
	 nEko+cuGCXsJYA2KJ2tK3nzzh87qy8ozo7K4LybswYNSNGsxeRU1UgjZd0jPCq2TYc
	 UTEotcoCntShZ6YMgc1aFBUclSz8+JgAEPag+UcPurx1i2q3+pcF1rgwXwNQp55NrA
	 xsj7g4TPKO26uCuxK8ACLK32Q2HoDLEXY1Iv5f86dUpRDxpOX4Bt010WtSTh8MoUGn
	 uhW/Pwyw8+mqlAr8yQpHIfi+sycSZbdceKu8ukcsEnrGOWM2VLzBU4M+zzLkDE70dq
	 JxjPcEH0SRcUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC933809A90;
	Thu, 23 Apr 2026 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] tcp: fix listener wakeup after reuseport
 migration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697142304.724716.2732259563165568513.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:10:23 +0000
References: <20260422024554.130346-1-jt26wzz@gmail.com>
In-Reply-To: <20260422024554.130346-1-jt26wzz@gmail.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, tamird@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280852-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B0824569E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 10:45:52 +0800 you wrote:
> This series fixes a missing wakeup when inet_csk_listen_stop() migrates
> an established child socket from a closing listener to another socket
> in the same SO_REUSEPORT group after the child has already been queued
> for accept.
> 
> The target listener receives the migrated accept-queue entry via
> inet_csk_reqsk_queue_add(), but its waiters are not notified.
> Nonblocking accept() still succeeds because it checks the accept queue
> directly, but readiness-based waiters can remain asleep until another
> connection generates a wakeup.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] tcp: call sk_data_ready() after listener migration
    https://git.kernel.org/netdev/net/c/3864c6ba1e04
  - [net,v4,2/2] selftests/bpf: check epoll readiness during reuseport migration
    https://git.kernel.org/netdev/net/c/c01cfc488675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



