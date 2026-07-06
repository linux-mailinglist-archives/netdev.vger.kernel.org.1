Return-Path: <netdev+bounces-305197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6STZLlkLTGpJfQEAu9opvQ
	(envelope-from <netdev+bounces-305197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:08:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD37154EA
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:08:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=VHnOOmJL;
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305197-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305197-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F616310B60F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064D3C3440;
	Mon,  6 Jul 2026 18:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C9386450;
	Mon,  6 Jul 2026 18:56:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364174; cv=none; b=KACVyqiwj4fUvgomHoVlw6G9ALIGf6bZS7FyHzKSfW0/z5Vp3c4n7bFPDOCnVNXF08v+VM4NAabbzHzgLY8QuCUIIX1f061gzq/7KNKXUbKw0TsxfRhyQS07Mv9340uM3/Un6Pir9YllQE9Yudv41ZHRHlZi4Q1qrUx2Fy3ZDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364174; c=relaxed/simple;
	bh=DnqQH3Ns8ijK/qIj9sMWeyEO0RrEk6NgD4q96g4A2FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3jPmNAVjOBlaio6tAHCMEHpheAFC2o+Y0u2QLKZG+q8UwZXXvxYk9Q6rDX1DIuyBvhSPpiybnjETIG8GU3M6+KwiXUpsWeaHa2BewUG+BiqYUyIpQl1SFDXAQeTkxCSeZ/uED0l8TRi+XkINvjvyJS/9+/FjEusM9ZtPX05g+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VHnOOmJL; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=C0ZdpmCSsBgmr9judXMm3+P3KGMl0lmu2e+KakqgAGY=; b=VHnOOmJLbFZ/vlBv31b1dFC5em
	KVHiIm5aA9W5LVr3SULB4XQO1bzSzfwIS6hzJp6czVXy+onEyCLCNTl5KD8MjORn5WkKQrdWR4VQk
	Z/t3jwjpLafvrVpWzBTcK6IXkzadsD4ZWxyeuX/0DbuvXCZKW4WrqfUYJIrP946dFPEHLo4TcxDWJ
	kbXIfxsPrApQ3SxrX1Sek+lJfOtiNcv++89XIRoX800Z1O2XmprCg09lr5uJRTPwY8xHhtxzCWhiz
	41aDMc4GeGKbt8QKCN64tlvtRCu4bALYU35mZXWiR1uRiJiPGFb81pbXGQ4cHg94IuvW03rvK16q+
	oYIJJ0EQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgoUE-000Psa-0U;
	Mon, 06 Jul 2026 20:56:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	jhs@mojatatu.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2 0/3] Fix broken TC_ACT_REDIRECT from qdiscs
Date: Mon,  6 Jul 2026 20:56:06 +0200
Message-ID: <20260706185609.330006-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,mojatatu.com,linutronix.de,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305197-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:from_mime,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EFD37154EA

This is an alternative fix to [0] in order to not uglify
__dev_queue_xmit() with sprinkled ifdefs given this can be
simplified and isolated through a simple test into the BPF
redirect helper itself.

I've also added a proper BPF selftest, so there is no need
to check-in a binary BPF object into selftests given we do
have BPF infra for all of this.

  [0] https://lore.kernel.org/netdev/20260629102157.737306-1-jhs@mojatatu.com/
  [1] https://lore.kernel.org/netdev/20260629102157.737306-4-jhs@mojatatu.com/

v1 -> v2:
  - Added Sebastian's Reviewed-by
  - Rebase to latest net, rest is same (Paolo)

Daniel Borkmann (2):
  bpf: Reject redirect helpers without a bpf_net_context
  selftests/bpf: Add test for redirect from qdisc qevent block

Jamal Hadi Salim (1):
  net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

 include/net/pkt_cls.h                         |  14 ++-
 net/core/filter.c                             |  17 ++-
 net/sched/cls_api.c                           |   6 +-
 net/sched/sch_cake.c                          |   2 +-
 net/sched/sch_drr.c                           |   2 +-
 net/sched/sch_dualpi2.c                       |   2 +-
 net/sched/sch_ets.c                           |   2 +-
 net/sched/sch_fq_codel.c                      |   2 +-
 net/sched/sch_fq_pie.c                        |   2 +-
 net/sched/sch_hfsc.c                          |   2 +-
 net/sched/sch_htb.c                           |   2 +-
 net/sched/sch_multiq.c                        |   2 +-
 net/sched/sch_prio.c                          |   2 +-
 net/sched/sch_qfq.c                           |   2 +-
 net/sched/sch_sfb.c                           |   2 +-
 net/sched/sch_sfq.c                           |   2 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/tc_qevent.c      | 113 ++++++++++++++++++
 .../selftests/bpf/progs/test_tc_qevent.c      |  23 ++++
 19 files changed, 175 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_qevent.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_qevent.c

-- 
2.43.0


