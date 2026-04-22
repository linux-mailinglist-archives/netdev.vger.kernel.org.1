Return-Path: <netdev+bounces-280291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCAxC2E46GkbHAIAu9opvQ
	(envelope-from <netdev+bounces-280291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:54:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95787441A4C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46382302A6A5
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ECE39769E;
	Wed, 22 Apr 2026 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlY59O+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3883932D0
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826009; cv=none; b=p4o16mTgAb2tfG7RDxRRw1JfvB6rXs9XWXpG3UbU6Dq+OrfW0YlpgiMXiYeKMGoD/Ov2/g8/+chaniQWDZiI46E9rzsigqG+oF4sxERgbGnuI3wEA/+CRRQFH1rt1p/jMqrAcvveq8ugiDldvatJvR/P8XHYXECn+HFf0W1ZIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826009; c=relaxed/simple;
	bh=OaQovPa9+EGt0TGv46fnTHFkH7yaRjfaIRFduQr/UYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvqotenSCubg5JYSfm/0WA4RPq7mRN3cT2WoS1jGmEB8iUEQU2dTZ/7WtXfQ+J+SwoGCyJkVyTETyQvNfAg4BP0siwBdzJyk8BOEVkARSAwNO/AHDj6MhmwDwKbAVaet1mqTjpfV4IknlB5PZbjeq2zXXm2CVcczJtLRCMywfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlY59O+2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f1f6103afso2283723b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776825986; x=1777430786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfsVOB0fT6t3Cc1A7FO/ne2eHtXjxBYweMBP+Bjao20=;
        b=FlY59O+2+cAEFXGSvhuuINNDm5uHJnpwY0VA5Ez97mYcbqStGUaqnZ7LK42d/f1TVi
         BB1BvUaNt4/tDDAiFIbVc4kGrd+3cNY0+1u/tlZv6qJ9IG7QoeIutDdOZWcS/R3oxepw
         tTsnIlxYiTmHN8BJ6Iazgutnt7l35r7pvfnpZqwRH8LfEF8IGxEjmyaj0c5FP8KvCmex
         3sKmB9JadEbKXbBlwpMsaVUNzO6FzxkFOUVW9rXxwGp1py7XX8xUfrx103X1BI7Dc99d
         554OZ6ZhPHN+Md+Lxr46EtfvsGXEGltjQt5lTKe/4lWCt44RRbd3DgxNmVJkHnOU+POR
         WIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776825986; x=1777430786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfsVOB0fT6t3Cc1A7FO/ne2eHtXjxBYweMBP+Bjao20=;
        b=gxfiaU2uEoXnPVqifYpph6Q6FPoQSzNciG7V78jhAnCL+f7BKo7Tj57uYydGywZ3XX
         Inn1hZGwx3NGpW4h6Hp/VNjYnbftCJwTxT/S/281qoc3x2oYul7TJYm3zxocBGG/ffLS
         D61ECowatVY5LxU1aLwheqrdddaeuXhdXn7UQ8MGjlBC6RKSGVFerIfwoTekwegZrXM4
         CGS5djRSVmESAcBpbRqtJ7sMj574DXClTpQwF8jeC0WpDEgoFVt326QrNLn9AaDBh2BH
         TWp9YJEFrRJiierEWlKR9+GjTRbVXaL6pOxRmIE8FUbqHhyNb+w72GiygX37uTE0z0IC
         BLaw==
X-Gm-Message-State: AOJu0Yy1PuiJ6JqVBbMH2qhGZaX2ov2GYagETK+9D3cZKjTv8Z1YnlxB
	gJW+Y4zWsea6MBRE/Pegxk+71wJgLTU/WIyH/ktQiP/GLi3oVqdAWjbtv2SIkStNcnA53Q==
X-Gm-Gg: AeBDiesFgihY/FUE4JVj4CJTtj0puB630lxInsKLxvq5rJrchhxzq74Ft7q5h24VtyH
	M35Ef/eZV48EPdXJjK6gX4cBRaWzWidjJbtlFEasaH2MBMbVrk8yu6QjKx0NoE6cPfrQYTHekrt
	6DXjqb1YIjJo7nVBblj7DUEj89KXt3n+cGrPROOBAz2CJfBQQJMzKPXYwLA6GoRDqKmuMe2jquK
	MZry1TVGC0V/jbSg3J4k9WL5PVTtNHc7skEerxfhM+nqXy5n1siQfmOSDE/x+G8qSfNDGfXgEpH
	+yRIIZKIhYO3k+eK9PW1f/cM0B1WSgwzu+oqv9SDPyhKGIXZEER7DWWtxVFozWFpo6SYbpkcKjb
	G46idzUOj23pJ4LKQSAl9VYrah9s77nT8QQnzwo9h1Z+A3EecYWdDPAJ4NbGstFMmUW72cy3lTS
	fN+Y3fRZViV0W9fmRHAQTkoIK0iOF89HltPJU++Ed7QhrIIOfRd8t52nryJhPT3Q==
X-Received: by 2002:a05:6a20:7f92:b0:398:b95c:51f7 with SMTP id adf61e73a8af0-3a08d8e2805mr22818050637.37.1776825986281;
        Tue, 21 Apr 2026 19:46:26 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f92183sm10656632a12.3.2026.04.21.19.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:46:25 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] tcp: fix listener wakeup after reuseport migration
Date: Wed, 22 Apr 2026 10:45:52 +0800
Message-ID: <20260422024554.130346-1-jt26wzz@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-280291-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 95787441A4C
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

v4:
- fix patch 2 to route shutdown() failures through the epoll cleanup path
- guard patch 2's epoll cleanup when no epoll fd was created

v3:
  https://lore.kernel.org/netdev/20260421123106.142299-1-jt26wzz@gmail.com/

v2:
  https://lore.kernel.org/netdev/20260418181333.1713389-1-jt26wzz@gmail.com/

v1:
  https://lore.kernel.org/netdev/20260418041633.691435-1-jt26wzz@gmail.com/

Zhenzhong Wu (2):
  tcp: call sk_data_ready() after listener migration
  selftests/bpf: check epoll readiness during reuseport migration

 net/ipv4/inet_connection_sock.c               |  3 ++
 .../bpf/prog_tests/migrate_reuseport.c        | 49 ++++++++++++++++---
 2 files changed, 45 insertions(+), 7 deletions(-)


base-commit: 52bcb57a4e8a0865a76c587c2451906342ae1b2d
-- 
2.43.0

