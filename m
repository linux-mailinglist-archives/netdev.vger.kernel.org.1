Return-Path: <netdev+bounces-279537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC78HOvJ42kEKwEAu9opvQ
	(envelope-from <netdev+bounces-279537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:14:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F6421ED5
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D7FB3007ACE
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A83264CF;
	Sat, 18 Apr 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peRZ0NWz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3AB3090DE
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536035; cv=none; b=LRyn0OiDg38NJEiWKtVkpvzSdovj+j1ILNF77XeTjpOOAB5yyHJGIHvbFhwpfqJQSpuTEE8bXTRYgxWF14TPol/P5Rm2KG5zVPT3QSQvw7el4+ZtiKmGD5R7pN0xnx+nZ+SMKwDM4OS+LpV0iQymmxQsHTDE+gN163Nco/EL+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536035; c=relaxed/simple;
	bh=YYQJavEnd1fnX+vR3sVF/zbo5SR6pv0KkvAYvprHc3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkN/96ely6PANQiAAm1oHbfQsh2eDkybKsbb1W/Wd5DwiVwnDOxD7PsPWUfV71N5kgmDxmBfvOQQux68iwKtlwEkpAWeLpl6y2uXvSzk/UfVhkV5idPaEffYH0C12mBVnxDKEUnrtrXOnq7rHg0C5GSAszozM4lwOZiQq4RNMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peRZ0NWz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f69a286dbso1352899b3a.2
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776536033; x=1777140833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hm7Zzjznl6z94RlMoEkmeGxVQZOGZnEHpCrSYXcXznI=;
        b=peRZ0NWzgz3gIKgXV+x4hIxwp/Ty+F11ETRtasR4XVbt0UjTg3Ba0tMZwfGFvWcmPa
         EZCnIaluTs3jvRTdHDdul0EUvO99Jzv7Pm+SG8/PhunoPxlfmnd4aHl3FnIaL1mRy7Py
         48FcrF7XCc/GH4P6kHkVhid9zXCaECPSSzlkN0Ir7TtclmG5NgDtHTcIlv6HluM0pAyz
         zDwh+0ulGDbl/O8auu+eASVAxMjyff429YQm4PB6FedCmzZc1EGIZuqYDSreSApF/Iax
         EgsyYALjdIw+b8f/88I8ltsIsjSLCm3r1EDqTXRkKajD60KcxV8hnITuDIM7uWgMGxb2
         OCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776536033; x=1777140833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm7Zzjznl6z94RlMoEkmeGxVQZOGZnEHpCrSYXcXznI=;
        b=G2DZJmmcfTXX1jYTcxvwNg8ptl9U0HO/y/JiNaLQPb8pALA9l2leegl+nS4vqIJqKz
         Oi7xqP57jemMolIuQ9o/8mOP4YGN/ZPsnvUZ7CYi24vSPVklih1KVc9+91qpq7uR3PAj
         Tlk/OnjbdcspcBMU3Xo1zpqPRAbq9067SuWjfYp9LqshHkiRzqrgwdlhHNyZalw0nmQ0
         esE0V56khjd//nhpUq/GdSZtvhBKd7rrEt4NTDZ3tn/d/LGY/wPNbTCyD/e1FN+j0l9p
         hKWp+i/nHPcEHvdIIt5KK52dbl2vGKH7Admhc5Az020H5cgi5m74I4OrmWTIotW4NEV/
         qcFw==
X-Gm-Message-State: AOJu0YzDt5yZuhG0xJBeWQMtLnb6jlYG3XDnjfyr0rPXK0tVxXlfkGyW
	73nkCgQVlIpq9cMBL6p5zloJFmqvBMSiMsMXVFqBib73daQXvdkORoTrTc5lZneBXg7Ou9jF
X-Gm-Gg: AeBDieuGLH16F11JaBoWmjFoZ7cksqPqL5GCQdc64ulEdJnB9ZGdMjLUN77xSuC2dLg
	f1GXeVKa5NssPexH6LpC95Nk0rZBddLezbSeRv1h+aPtkFN3XpIn2RY2Cqug8Ob3hb20GRaj7au
	tJNZ9JC73R5hToV2p6Akk8dzOhe8pskocNWbcj2aNT2kLdvOdd0x7pZrLLGp5EGNnXpABCUkTCG
	/oLN+y6CuJc7JTyWXvKSJwHBXwlPo4fRA2X8qJjb47jY7z+zafzydok0PgwHAsgGqg41pjgQccP
	+XdyRd1E3EXVp5AAofHSeySJv4wp0OegTTFWyUGZjthcWg9N37qGAnc6RdMTEEfZiVE41ugUQ5S
	1sorIaMqt2ebbcQAJBpCO0p0zxWoOQWIq6MpW7m6ezcKSIzW8afjPUPxxca0qU8Cdy1KuzQrRuH
	xTW4OMYAa1ok9S/MmER87R7yuybnt185C92g0qcaSh7P+mD56iO81PUSscT0T1Ug==
X-Received: by 2002:a05:6a00:4ac9:b0:82c:217c:98ca with SMTP id d2e1a72fcca58-82f8c828d95mr7744394b3a.12.1776536033299;
        Sat, 18 Apr 2026 11:13:53 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm5659402b3a.21.2026.04.18.11.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 11:13:52 -0700 (PDT)
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
Subject: [PATCH net v2 0/2] tcp: fix listener wakeup after reuseport migration
Date: Sun, 19 Apr 2026 02:13:31 +0800
Message-ID: <20260418181333.1713389-1-jt26wzz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-279537-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 671F6421ED5
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

Patch 2 extends the existing migrate_reuseport BPF selftest with an
epoll readiness check for the TCP_ESTABLISHED migration case.

Testing:
- On a patched kernel booted under QEMU, the full migrate_reuseport
  selftest passes with SELFTEST_RC=0.

---

v2:
- wrap the post-queue_add() nsk dereferences with rcu_read_lock()/
  rcu_read_unlock() to prevent a potential UAF (Eric Dumazet)
- extend tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
  instead of adding standalone net selftests (Kuniyuki Iwashima)
- limit the epoll readiness check to TCP_ESTABLISHED cases

v1:
  https://lore.kernel.org/netdev/20260418041633.691435-1-jt26wzz@gmail.com/

Zhenzhong Wu (2):
  tcp: call sk_data_ready() after listener migration
  selftests/bpf: check epoll readiness after reuseport migration

 net/ipv4/inet_connection_sock.c               |  3 ++
 .../bpf/prog_tests/migrate_reuseport.c        | 32 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)


base-commit: 52bcb57a4e8a0865a76c587c2451906342ae1b2d
-- 
2.43.0

