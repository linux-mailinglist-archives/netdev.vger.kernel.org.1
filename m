Return-Path: <netdev+bounces-293922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IrzJgwdHmqbhQkAu9opvQ
	(envelope-from <netdev+bounces-293922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:00:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F04ED626742
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E848F3009F92
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ABE308F03;
	Tue,  2 Jun 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM05SXDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E152BE65B;
	Tue,  2 Jun 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358409; cv=none; b=muyHwRA9aOoJQNCcJ0h5NI3olVFG7WdrUaOqrDFSUPYfRUkxpOyLIDumjkGfDgWr8QRtqSl3aAZ7eqGnmcXldBYHBYBna03sgSq2qVtJubX0pQ0yrKMuC0flHMUOvIwV4THaPJhjhGog26e0Yp2/6C+kyC8c37sAMwh8GFsUg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358409; c=relaxed/simple;
	bh=B4YtSsqQKcq6jx+Hdhiq/RdjNzPFQYNEuE8cycRrCS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IXITqsEF7RXyEwC/IN+YUN+IyhZz99N6SqQht89pBI41kFzqnznO4y0cKIP9fCRwgEKX2C3TbbLaKrF0MeQbjS6Xv7Dy2/TXNAHRUA43A7MqVQU8jgaYuOVtRX4IC7Tk4V0h2IU4TJwhOisQbgTizRFBnrd5KVJCqAIKKBTLbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM05SXDu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7921F00893;
	Tue,  2 Jun 2026 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780358407;
	bh=BUbBi5qbB71pOo63O7PIAIkAStJ6sXsIKghh+iZXm2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AM05SXDuql07gbrdUZgny9+w4o+ps9FxqMzpEhzmAQ7Zdp6SYDFeB8N7M2ASuzKoT
	 K0Y3kLG8U+MPEgPY+37Jv7Jarm0pSjhf+10RFNh1MxXVAKv9eOD0q9PZIHDe8CMjKh
	 ba7vVyi2On7LYeUrFp8MBq5KigDgWXyCeSxLykJtkLa2zQXQlSfTwPrYhpGXjo7bwe
	 wT3+GgXLbN4sDsVZ7joXw3UEbqX8A3faL8QBbz0M520e3VZcMc6K5p5UwThgdvjztX
	 bjQhGVFu5Zg7/0Pl0kjqgQ2Ee1MA9HwxybgscpBXxcbhjo8WAKz+052G4yQiudKEZc
	 N5yb2PaDfXM0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A1738119F8;
	Tue,  2 Jun 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net/sched: act_api: use RCU with deferred
 freeing
 for action lifecycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178035840972.174748.574168539743805573.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 00:00:09 +0000
References: <20260531160812.68020-1-jhs@mojatatu.com>
In-Reply-To: <20260531160812.68020-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com,
 kylebot@openai.com, jiri@resnulli.us, vladbu@nvidia.com,
 linux-kernel@vger.kernel.org, security@kernel.org, stable@kernel.org,
 syzbot@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293922-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F04ED626742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 May 2026 12:08:12 -0400 you wrote:
> When NEWTFILTER and DELFILTER are run concurrently it is possible to create a
> race with an associated action.
> 
> Let's illustrate with CPU0 running NEWTFILTER and CPU1 running DELFILTER:
> 
>  0: mutex_lock() <-- holds the idr lock
>  0: rcu_read_lock()
>  0: p = idr_find(idr, index) <-- action p is valid (RCU protects IDR)
>  0: mutex_unlock() <-- releases the idr lock
>  1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
>  1: idr_remove(idr, index) <-- Action removed from IDR
>  1: mutex_unlock() <-- mutex released allowing us to delete the action
>  1: tcf_action_cleanup(p); kfree(p) <-- Kfrees p immediately, no deferral
>  0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- ouch, UAF p points to freed memory
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net/sched: act_api: use RCU with deferred freeing for action lifecycle
    https://git.kernel.org/netdev/net/c/5057e1aca011

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



