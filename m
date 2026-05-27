Return-Path: <netdev+bounces-292026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEnNAhZCFmrnjwcAu9opvQ
	(envelope-from <netdev+bounces-292026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:00:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 624895DE1A5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14C1300D6A5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F5303CAE;
	Wed, 27 May 2026 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEzRKpKx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95E15C14F;
	Wed, 27 May 2026 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843600; cv=none; b=nh1BBCwmDjbjht+UhNtw155KfQEsWpITogNxWEAbS1IyYVYRkuNPviRDklhi36ECQfHsmZH0+Lx3OVN/GUTG08D3RPi0L6qg6rI3c+8FPGAXgySd5TccaslwcEdIEOhAXKJ3VovSIWRWoHpodK1WIIu21AWCzp7U26S4LZjk3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843600; c=relaxed/simple;
	bh=rmi0RurxxVWf++A+g3SHLdVJi20++Lvbl+nOW5v2Gu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KlIWHnwu1mZqpCAfdm3t4Pyn9QflRcU9Ifb8Rtp7KdPADN975ZKzmDW9nQYZvslVOEWGDjr26eb/fY3z8ZgkYXnbd/55IMvHfEKb++FJL/YxPaYnOQsginG4Zh/yfoOsVF7HCjn8uS/JYBQSpIUmTwpqoWJrdKmp+pkUN5FMoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEzRKpKx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9B51F000E9;
	Wed, 27 May 2026 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843599;
	bh=s4G6be054KaCv44PzyYCwvc4TrggQ/Amex8z/IEj1+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lEzRKpKx6Io/q9qjG/kS6e7T1TfxcHPIP9QJ1OuzgPgS42f3Rt0uE8Ss3QmpnQljm
	 +uEI4KyLODfuyQGRrVT8n4/JTu3ergmXmwfsTzB4hc6QOd4021ayuzZINJ4i16zr+H
	 F+jxt4qq/hwzv+x2j4Wmlj5keAM6Ai0JeP4W42eDJGma6K3hiKlnx62FbEI5XOZWB5
	 KX1twR6zG9IgUVv1m8CtB3OnBJ4gt/xBwPmAqdC/fZtoGee9byJbsJlUCgwlYPnvGT
	 jrBZCfGYWg0BumS3NmhJpkqJkFnxPrd6gJWMSJf1Cgea/DF0vUx1r4RLzeQveBdsKE
	 iPVuiav8tltOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AE4380CEED;
	Wed, 27 May 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: use refcount_inc_not_zero in
 l2tp_session_get_by_ifname
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984360514.4034294.17375502908023740818.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:00:05 +0000
References: <20260523023423.2568972-1-michael.bommarito@gmail.com>
In-Reply-To: <20260523023423.2568972-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jchapman@katalix.com, tparkin@katalix.com,
 gnault@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, kees@kernel.org,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292026-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 624895DE1A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 22:34:23 -0400 you wrote:
> A reader in l2tp_session_get_by_ifname() can return a pointer to a
> session whose refcount has reached zero. The getter takes its
> reference with plain refcount_inc(), but every other session getter
> in the same file (l2tp_v2_session_get, l2tp_v3_session_get, and the
> corresponding _get_next variants) uses refcount_inc_not_zero()
> because the IDR/RCU lookup can race with refcount_dec_and_test() ->
> l2tp_session_free() -> kfree_rcu(). The ifname getter is the only
> outlier; the inconsistency was raised on-list after 979c017803c4
> ("l2tp: use list_del_rcu in l2tp_session_unhash").
> 
> [...]

Here is the summary with links:
  - [net] l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname
    https://git.kernel.org/netdev/net/c/05f95729ca84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



