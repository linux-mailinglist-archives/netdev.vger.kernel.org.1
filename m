Return-Path: <netdev+bounces-301389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W+q9FhOYOmpABAgAu9opvQ
	(envelope-from <netdev+bounces-301389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:28:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6226B7E0D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:28:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=2sogVQLN;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=0lmDUG5H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301389-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D88305E48A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899138CFE7;
	Tue, 23 Jun 2026 14:27:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E12BE7BE;
	Tue, 23 Jun 2026 14:27:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224828; cv=none; b=Zxt0VXYSrFsxk7aoJnLW5Vju19QIshkA7w5W81J0758QGGHvD+kCinViUx1rmFbiEluO2KQqpdH5vgdJZodXa8N4K4aU1AP8V0PmTD103BAr5A4X5/uTwYlK32pOOArZDDVJusUkKiagRLe4kkxysj+0hR/8JK19q4V2TAP5b+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224828; c=relaxed/simple;
	bh=aC9j6+/PUOfq+WMbyfBUdmM51dUpMhp6Zat62Hg0mec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=psrZ9Z0oQw6xSLvkxl2r2GA5/f/Cg76kvfrbQLIYN5WaB7lsQ2BmPb+Kx4BytYlHX8rc84kfLdcfelUQQEgsq8FO2D2gscvnDjM4LCDDx5Eyw9lFms4q6ZeTFx8f+unYHh/AEh/3/qv6rR7vBjcsgiPKat7corPkOkRrrh4YaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2sogVQLN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0lmDUG5H; arc=none smtp.client-ip=193.142.43.55
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782224824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+VxJ/hTLLC3ZO1J8xkJJx8VcM1svBl0A5SvgrNP8pzI=;
	b=2sogVQLNN9CTsNkjahoNiflubLnZ/1cTJQPBxue2C/SUtts4ataMYlzS2wqPhOFL3KZp+w
	FSkdu8uu4NPBrn6/q24vmf5+IKmjSNBe2anxVYPbF+RNS/QmzreXIzCi7nwdChdpg/V7Ce
	JLSxrdTnv9KjAMsCxR1eKThfFo5HN4elcILVjnO8F4mcvzFZUoO3bDNAczzDaun1245OnX
	a4TB8SWKBKwc3UJT7g6YleQMIdUwQM4/3RVCdezUwSjJNWOj0zc8S9exoFII0/7xFZ0s8o
	Uur6XzfVI9G7jczsG/wCRaxy8woWecAr3S6QgNgyQ0GQwzirpu6HjhqNyoIZGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782224824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+VxJ/hTLLC3ZO1J8xkJJx8VcM1svBl0A5SvgrNP8pzI=;
	b=0lmDUG5Ha/0kmALYCixA5mZ8+0hCiCtCCjPG47cW8MfhG2qe6G1R2nw1HxOxynYaBW7PWq
	7UMqZoTjZ4lEDXCw==
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] sched: Introduce and use deferred WARNs in sched
Date: Tue, 23 Jun 2026 16:26:48 +0200
Message-ID: <20260623142650.265721-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301389-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:pmladek@suse.com,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:bigeasy@linutronix.de,m:vladwing@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,amd.com,infradead.org,suse.com,chromium.org,goodmis.org,linaro.org,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB6226B7E0D

This is a follow-up to the netconsole lockup reported
	https://lore.kernel.org/all/20260610183621.3915271-1-vlad.wing@gmail.com/

The idea is to use deferred printing for WARNs and use them in sched. I
tried to use only where it looks that the rq lock acquired instead a
plain s/WARN_ON/WARN_ON_DEFFERED which would be simpler.

This unholy deferred mess can be removed once we don't have legacy
consoles anymore _or_ force force_legacy_kthread=3Dtrue.

The initial report is against v6.16 and netconsole. The reported problem
does not occur upstream since commit 7eab73b18630e ("netconsole: convert
to NBCON console infrastructure") which is v7.0-rc1.

Should this be rejected outright because the preferred sollution is to
| - stick msg in buffer (lockless)
| - print to atomic consoles (lockless)
| - use irq_work to wake console kthreads (lockless)
| - each kthread then tries to flush buffer to its own non-atomic console
|   in non-atomic context."

then this means to force force_legacy_kthread=3Dtrue.
The threaded legacy printer is available since v6.12-rc1. It terms of stable
fix, this could go back as of v6.12 stable and not earlier (in case we care=
).

I tested this on a x86 box with 8250 and warning in put_prev_entity().
After it printed the initial warning, it dead-locked shortly after
because systemd was writing to the kernel buffer it acquired the
uart_port_lock then attempted to write lockdep report which required the
same lock=E2=80=A6

Sebastian Andrzej Siewior (2):
  bug: Provide WARN_ON.*DEFERRED() macros for console deferred output
  sched: Use WARN_ON.*_DEFERRED()

 include/asm-generic/bug.h  |  41 ++++++++++++++
 kernel/sched/core.c        |  78 +++++++++++++-------------
 kernel/sched/core_sched.c  |   6 +-
 kernel/sched/cpudeadline.c |   6 +-
 kernel/sched/deadline.c    |  62 ++++++++++-----------
 kernel/sched/ext.c         | 110 ++++++++++++++++++-------------------
 kernel/sched/fair.c        |  88 ++++++++++++++---------------
 kernel/sched/rt.c          |  36 ++++++------
 kernel/sched/sched.h       |  18 +++---
 lib/bug.c                  |  16 +++++-
 10 files changed, 257 insertions(+), 204 deletions(-)

--=20
2.53.0


