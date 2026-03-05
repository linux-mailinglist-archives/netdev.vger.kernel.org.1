Return-Path: <netdev+bounces-264478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBrfNj6rqWlSBwEAu9opvQ
	(envelope-from <netdev+bounces-264478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:11:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA3021531F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F763135EBB
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A23CE48E;
	Thu,  5 Mar 2026 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9xwlYdq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16203CE48A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727029; cv=none; b=BVUjJBV7byPYTExsqAYczouruaRNWM6eI+6PBQjwEqzDKT8a0m1f9LAntz6xiCkTzMQUd4GUaBDbNl9fw07RHsgpvYyKCRGteLLXWDpEBrkNprC4DFj5nxMxCwkv+CO1V3b/7D4sffH8g/94/wPiGZtj+yIY6IH1MwuuDch1CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727029; c=relaxed/simple;
	bh=A0c80+YQmM/2EH73odsX+k9tsSMR++rnvZ9OdR3D6y8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDFz0opVcoTT/D6un6AjsY4uJEkTF/xSW6w4rzXFKyM9GOXAFZm/eItU/RQKHIAPYLZpB+kAPk5WMbIVojJMBHHdKnUeP0vfFTrDSAOkgRTpDNgoclYMKIk+5Q2pYmhx98GsFQkad8jbGhc3mJzrzgvzPlSoImsJ9xR4AVwsy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9xwlYdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB92C116C6;
	Thu,  5 Mar 2026 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772727029;
	bh=A0c80+YQmM/2EH73odsX+k9tsSMR++rnvZ9OdR3D6y8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q9xwlYdqh49W4YMcG1Ig/DxYbAFv6SYGNk6Y9qWOKY25hJ3w2pHqC8JJ79CPdC4gq
	 xY3KpQbxTkdf7xwljTzsY/AO8UwiuAaxXJVJj2O8jOFQi/Bbl2m3sWSpmPkrkttANg
	 HTE5rSRpu5jTprv+8Ujf8cFwGJh+XtW9CmUG7FmXMNmmDywiQ6ipsuWVv41/88Rxk1
	 pT594fe0xoxuidySidx0XS0R8fSUzffisswDpFrjyszaOufW0dO2LPvK8cRaJq9L2x
	 s3hpvwcbVBpBnGfjVWm+34ZT3RcDM1s75N0fkIIfDQ6AO5/ItA2QIU5jKcKk1muv1G
	 7GrbvrbRnqRyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FB53808200;
	Thu,  5 Mar 2026 16:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: act_ife: Fix metalist update behavior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272702930.3188128.17664051968350541473.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 16:10:29 +0000
References: <20260304140603.76500-1-jhs@mojatatu.com>
In-Reply-To: <20260304140603.76500-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, cnitlrt@gmail.com
X-Rspamd-Queue-Id: 5FA3021531F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264478-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 09:06:02 -0500 you wrote:
> Whenever an ife action replace changes the metalist, instead of
> replacing the old data on the metalist, the current ife code is appending
> the new metadata. Aside from being innapropriate behavior, this may lead
> to an unbounded addition of metadata to the metalist which might cause an
> out of bounds error when running the encode op:
> 
> [  138.423369][    C1] ==================================================================
> [  138.424317][    C1] BUG: KASAN: slab-out-of-bounds in ife_tlv_meta_encode (net/ife/ife.c:168)
> [  138.424906][    C1] Write of size 4 at addr ffff8880077f4ffe by task ife_out_out_bou/255
> [  138.425778][    C1] CPU: 1 UID: 0 PID: 255 Comm: ife_out_out_bou Not tainted 7.0.0-rc1-00169-gfbdfa8da05b6 #624 PREEMPT(full)
> [  138.425795][    C1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  138.425800][    C1] Call Trace:
> [  138.425804][    C1]  <IRQ>
> [  138.425808][    C1]  dump_stack_lvl (lib/dump_stack.c:122)
> [  138.425828][    C1]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> [  138.425839][    C1]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [  138.425844][    C1]  ? __virt_addr_valid (./arch/x86/include/asm/preempt.h:95 (discriminator 1) ./include/linux/rcupdate.h:975 (discriminator 1) ./include/linux/mmzone.h:2207 (discriminator 1) arch/x86/mm/physaddr.c:54 (discriminator 1))
> [  138.425853][    C1]  ? ife_tlv_meta_encode (net/ife/ife.c:168)
> [  138.425859][    C1]  kasan_report (mm/kasan/report.c:221 mm/kasan/report.c:597)
> [  138.425868][    C1]  ? ife_tlv_meta_encode (net/ife/ife.c:168)
> [  138.425878][    C1]  kasan_check_range (mm/kasan/generic.c:186 (discriminator 1) mm/kasan/generic.c:200 (discriminator 1))
> [  138.425884][    C1]  __asan_memset (mm/kasan/shadow.c:84 (discriminator 2))
> [  138.425889][    C1]  ife_tlv_meta_encode (net/ife/ife.c:168)
> [  138.425893][    C1]  ? ife_tlv_meta_encode (net/ife/ife.c:171)
> [  138.425898][    C1]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [  138.425903][    C1]  ife_encode_meta_u16 (net/sched/act_ife.c:57)
> [  138.425910][    C1]  ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114)
> [  138.425916][    C1]  ? __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 3))
> [  138.425921][    C1]  ? __pfx_ife_encode_meta_u16 (net/sched/act_ife.c:45)
> [  138.425927][    C1]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [  138.425931][    C1]  tcf_ife_act (net/sched/act_ife.c:847 net/sched/act_ife.c:879)
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: act_ife: Fix metalist update behavior
    https://git.kernel.org/netdev/net/c/e2cedd400c3e
  - [net,2/2] selftests/tc-testing: Add tests exercising act_ife metalist replace behaviour
    https://git.kernel.org/netdev/net/c/5d1271ff4c13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



