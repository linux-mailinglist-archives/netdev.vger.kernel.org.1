Return-Path: <netdev+bounces-262016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCRNLMk0ommn0wQAu9opvQ
	(envelope-from <netdev+bounces-262016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:20:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B041BF616
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFBD93098752
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A9237180;
	Sat, 28 Feb 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy/UMOQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880D21FF2E;
	Sat, 28 Feb 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238006; cv=none; b=RKvVL4LRECQNo6UDt/TRpIu/QYLAWucxi42GDVbx4BtgH9Ea0VX/K4ol85le8aRuSaAKkPsFcW377bVsqkaGIzRFsHxJr7WLb9NI/zRVwMkZsB3wf+WD5cmLtk4whDTmAnxSxjLwNbqmwqgRh9DDmbL18SU6m9PLzP1Pl7MQoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238006; c=relaxed/simple;
	bh=rFLs49bIoTa/GDiTlmR2it7GbdnW1QvlONvz4DeIYmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BopNUucw1gj0Z/pXR0BCJqULe2uohwdL+RVD7ncRh28XVuxFwLDrWYIVTFMxtmxVRrNAw535Xs8BLyPk14oZr/ooGqPiBOQLUq9Zg/ypTgPzUVUpQIr5ZEy0GtLYCl/O4Khe6dsahMBR3Gs04BJ7MiYisZd9DY/gTSnNgxwZwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy/UMOQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5A2C116C6;
	Sat, 28 Feb 2026 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772238006;
	bh=rFLs49bIoTa/GDiTlmR2it7GbdnW1QvlONvz4DeIYmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hy/UMOQdPitkxPPdo2+cm6lPD82U6zQEyfmPGssSnw8liegLi5HWctSiKMbGLyjSv
	 LxceG9tUktXkK08BlCWuFK3R9CNP/ueUseB32YXPWIx5CjxeDwWDdLRAnKBE7bZ2Qg
	 gW0syhlQCu40Puxyj5CWGBvbzIsPdGnFvLLWZpZR1+zPPSgTTnVaCbfKRfEkDodX1Q
	 YxyN9tJTkeB1GE/3f1xBBFDa9czIAZnUemKpM2JVz3jpo/skm645i59JxtEjlPDZcV
	 tKXx2P/CFb1JFIdFMosA1r6Ja1vbmTo05Pv0yYfDi62QfDp4rD5RUsWCHctTQVqFRJ
	 fP2zfExxPlRxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA09839EF967;
	Sat, 28 Feb 2026 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: cpumap/devmap: fix per-CPU bulk queue
 races
 on PREEMPT_RT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177223800954.2812023.3473953942632581583.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 00:20:09 +0000
References: <20260225121459.183121-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260225121459.183121-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, tglx@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262016-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,linutronix.de,goodmis.org,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18B041BF616
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Feb 2026 20:14:54 +0800 you wrote:
> On PREEMPT_RT kernels, local_bh_disable() only calls migrate_disable()
> (when PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
> preemption. This means CFS scheduling can preempt a task inside the
> per-CPU bulk queue (bq) operations in cpumap and devmap, allowing
> another task on the same CPU to concurrently access the same bq,
> leading to use-after-free, list corruption, and kernel panics.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: cpumap: fix race in bq_flush_to_queue on PREEMPT_RT
    https://git.kernel.org/bpf/bpf/c/869c63d5975d
  - [bpf,v4,2/2] bpf: devmap: fix race in bq_xmit_all on PREEMPT_RT
    https://git.kernel.org/bpf/bpf/c/1872e75375c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



