Return-Path: <netdev+bounces-280103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOY/HbZu52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:33:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216043AA9C
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB5930471C9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B093C9EDF;
	Tue, 21 Apr 2026 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJqC2I33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C62FFDDE
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774681; cv=none; b=LwikXz7Ii/oR2VlGyKpifyxJTKvmwdB4L6DF9hRyAZrY2fKYTLEW3SfIKwBS1kk6hH1bCGKV8Rgnl5R6rTwv0L0sm9nIKNA1OfeOedNKhtA3kaw11fh33mxV5ncHl2XAntUfEYU04YoCOUb++tdZCIvswfEEe1Lpo2EyWVVMChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774681; c=relaxed/simple;
	bh=zFtsG+q7uxMvPKrlZCiZD0zWArHu+RI9bCRU8wEOyRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rH1ubYbP6lz9UeZ6Py0/kzERcZJCpttdYfuq9Ds7kkVu5nFKDy3/H+HOypRj8lbNERDPrd6MC+V2Gep2UGA2TVAHyDI+2/x30oBlOFLRjwN4wM1aj42Aln7n+rABLtxDs0NN9sxXYvVeufQb5fMZSN44xnWi9Dvi4nWwRptKlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJqC2I33; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a9296b3926so24137805ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776774678; x=1777379478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=quKExtcxNcqwsw2W1PK/404UiMVFWlMem8o5xQPR6rw=;
        b=PJqC2I33uOM81yHtKv3u+kwQB1aXkD5RLICYCfpLCZ373Tq9V3DhJtEH2tVAI001H0
         kUakDvIfoKf6L9LdNj8KdexZSOmFOEFe4jqX1/ys+FJzTk8DlRMqqRU5DMo8diYbxo4K
         BX4gdTU99lwkfzdJC7kbrsr2yY4K+4/cmBQY9qHR+OcZVO6Qa5nKcw4cuZzJaJVDOraI
         WIk8n+eXOdEi/lAIxa2L5aO8ZpmYYEvEifV4qhZuv7yVCl5fKA9OmwiYV6G5TsZn5Uss
         xbRqCvTuTiaU/uHkWOgIDfnYtXfQMRDzMUphOxRadkqOYLn6iLs9zBEgZ9c80sgLi17K
         WyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774678; x=1777379478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quKExtcxNcqwsw2W1PK/404UiMVFWlMem8o5xQPR6rw=;
        b=I0uLWqgNkUPz1N8NLshUeQD1GEKnkTBRzPpNJvB0FaHiETQ8+6FdB1g7tcxiMhmyQJ
         3LHgQGbwnp/nJk0A0PvyrbWhS6U/4wh4jrqxK0o3q+grilJTx1588iNo3+yu/IGus3HU
         7jdfpNXlPgDmwM9eFybwdL5fsX0JQ5xDEo3E0x5VDHuGq2mPJ22XED3Oye3dEc8TLk/j
         PBKejvQeuH5cPySfCJ7v268swQ6zEJ692/BUCJMrcsHlNUzDfXrK+Rr2S4Hnpxh3GnAw
         yIyzMAYZMeSS3U3vGezYas5070hUiowul/CV70R+c/0ehO1144AxVWRk1sIXWF9vK068
         T3Ag==
X-Gm-Message-State: AOJu0YwYYGYWKsahKQ/R7j18hPrGhOs7V5mo3lmMXkk966dcMM7QFufJ
	WGhd9KNkQSblc/hYOd63QGT/HDjwyZ2TjFOYKYHhgXImrUfuwf4enT779oMk9uzPNrfbMA==
X-Gm-Gg: AeBDiev7URGV20U6jkIprIvNa50taOPoYQjvM//4q8yi7suZz7QT763xXJ2ubjOx7NI
	n58KfJS1aHvK+1jFLqsJDrlbw9SbYFgvt3YwQrnRx+g4wsZJj68+4itydFziAvPuKzJR6NxA2qI
	3EWizpXpN2cvezPwxwHLloLlEa1GlXVgsGNFAsrp26wzfWfsYvqbgpT9L2nwkKM42ZxO4spRVR2
	0WBrmWeMB/SKsZviTgDEkhTjeDHjZbDsXwUXHu3P/rqnPyAOiK79Ms4IZeQxmM0AMG/1b0kPoF5
	sKm5o3zFIc5dhzPSTrABz4hZjHXG4fO6Cu0eIhSgX2/qzbFtmHVZkKu17uCfmUFUg6zSe9x4Q7A
	/OligoCEcbge0d3JMil9t1u7r40gjFZ+SLD+NbgOejVNZuk4A80/vFFK5CL7yuAT/gUq/9aDAEm
	UQfXFcv+p/L2fzr/jySPDgVwCFCihfbEm5IwLSt4ZoeeMi1rc79kHdFKnrAP9ySg==
X-Received: by 2002:a17:902:c9c4:b0:2b2:eb9d:1648 with SMTP id d9443c01a7336-2b5f9fb33dbmr116307155ad.37.1776774678330;
        Tue, 21 Apr 2026 05:31:18 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff409sm169724315ad.14.2026.04.21.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:31:17 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tamird@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>
Subject: [PATCH net v3 0/2] tcp: fix listener wakeup after reuseport migration
Date: Tue, 21 Apr 2026 20:31:04 +0800
Message-ID: <20260421123106.142299-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-280103-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1216043AA9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a missing wakeup when inet_csk_listen_stop() migrates
an established child socket from a closing listener to another socket
in the same SO_REUSEPORT group after the child has already been queued
for accept.

The target listener receives the migrated accept-queue entry via
inet_csk_reqsk_queue_add(), but its waiters are not notified.
Nonblocking accept() still succeeds because it checks the accept queue
directly, but readiness-based waiters can remain asleep until another
connection generates a wakeup.

Patch 1 notifies the target listener after a successful migration in
inet_csk_listen_stop() and protects the post-queue_add() nsk accesses
with rcu_read_lock()/rcu_read_unlock().

Patch 2 extends the existing migrate_reuseport BPF selftest with epoll
readiness checks inside migrate_dance(), around shutdown() where the
migration happens. The test now verifies that the target listener is
not ready before migration and becomes ready immediately after it, for
both TCP_ESTABLISHED and TCP_SYN_RECV. TCP_NEW_SYN_RECV remains
excluded because it still depends on later handshake completion.

Testing:
- On a local unpatched kernel, the focused migrate_reuseport test
  fails for the listener-migration cases and passes for the
  TCP_NEW_SYN_RECV cases:
    not ok 1 IPv4 TCP_ESTABLISHED  inet_csk_listen_stop
    not ok 2 IPv4 TCP_SYN_RECV     inet_csk_listen_stop
    ok 3 IPv4 TCP_NEW_SYN_RECV reqsk_timer_handler
    ok 4 IPv4 TCP_NEW_SYN_RECV inet_csk_complete_hashdance
    not ok 5 IPv6 TCP_ESTABLISHED  inet_csk_listen_stop
    not ok 6 IPv6 TCP_SYN_RECV     inet_csk_listen_stop
    ok 7 IPv6 TCP_NEW_SYN_RECV reqsk_timer_handler
    ok 8 IPv6 TCP_NEW_SYN_RECV inet_csk_complete_hashdance
- On a patched kernel booted under QEMU, the full migrate_reuseport
  selftest passes:
    ok 1 IPv4 TCP_ESTABLISHED  inet_csk_listen_stop
    ok 2 IPv4 TCP_SYN_RECV     inet_csk_listen_stop
    ok 3 IPv4 TCP_NEW_SYN_RECV reqsk_timer_handler
    ok 4 IPv4 TCP_NEW_SYN_RECV inet_csk_complete_hashdance
    ok 5 IPv6 TCP_ESTABLISHED  inet_csk_listen_stop
    ok 6 IPv6 TCP_SYN_RECV     inet_csk_listen_stop
    ok 7 IPv6 TCP_NEW_SYN_RECV reqsk_timer_handler
    ok 8 IPv6 TCP_NEW_SYN_RECV inet_csk_complete_hashdance
    SELFTEST_RC=0

---

v3:
- update the selftest patch as suggested by Kuniyuki Iwashima
- update the test flow comment to match the new epoll checks
- initialize epoll to -1 to avoid a compiler warning in the selftest

v2:
  https://lore.kernel.org/netdev/20260418181333.1713389-1-jt26wzz@gmail.com/

v1:
  https://lore.kernel.org/netdev/20260418041633.691435-1-jt26wzz@gmail.com/

Zhenzhong Wu (2):
  tcp: call sk_data_ready() after listener migration
  selftests/bpf: check epoll readiness during reuseport migration

 net/ipv4/inet_connection_sock.c               |  3 ++
 .../bpf/prog_tests/migrate_reuseport.c        | 46 ++++++++++++++++---
 2 files changed, 43 insertions(+), 6 deletions(-)


base-commit: 52bcb57a4e8a0865a76c587c2451906342ae1b2d
-- 
2.43.0

