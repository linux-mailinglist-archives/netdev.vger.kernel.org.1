Return-Path: <netdev+bounces-279539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLZ5OjrK42kEKwEAu9opvQ
	(envelope-from <netdev+bounces-279539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:15:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F64421F17
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 20:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9F003025F42
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177103396EE;
	Sat, 18 Apr 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eALkrFDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D63368B4
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536047; cv=none; b=SSnTWKLn1/jjZGCFwMxwwOY7BxkDltfOjkvIekh0K5DBRmxZSuIm5gcbovm+VeVGtqFbW43kVVjcA+qOn6I42xf7bKm+LuXuLSPRIWINXdliD3msBY7q62VW56nGIXchfwwnAUP7yRNShGBi3OA07hGn5/mWt4KBNVrpnadiPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536047; c=relaxed/simple;
	bh=7RBn27jm2AVfQcHGM0Run5F5ojS7pQWf7fH3/FxJq4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0FwZQqlRWpBoDVdsM3dClELQkHft7D/fDxaaA8KMHcckTDqcZKEjwlLMM/cvBxm/7Vw4Zjsb7oj/q2Nx7FrL9p8m0wylDmOgJZAIV0SMc73lpUuT3DdF6gtuvcmMTrRQPz1ujPn52BiHbHbhc8hr8zYjM2LBw5muWEvKp4rTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eALkrFDr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82d0b68837aso1073222b3a.2
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776536044; x=1777140844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEq5CzQFwtAXQUDE7BtOjkL3C6G38PVDQBhAKTNWHjg=;
        b=eALkrFDrAHvlzw/c96wLEydh0GLNFhsEgQGrlraVxNIpyhKmp5Fpp1HMnk0KKfOYar
         JGKusaA17cJdbHEQzA3wK2QiiwwA785o6hIv8Uin/hqLXbTHDa0/0FD5UT0SyAhe+0Af
         3dow/EBliWkLfRdZnywsnUiIZ0OTAQokGpUihUdSwzWr4Y/CUM1oWow83us3Y1YwrKRT
         GFbW8TXEOzob0UOmwmZ67/1+7TecuXQxK6QgNhP5Uw5FjZUURDvdkWQ2w9lExyFYKLgl
         +oT3DztYSiWmWViHF3+h+khG7RwgCreu7rWrNsD5O4O34b8BRr5y08SBkdbFt1n/dNCb
         QKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776536044; x=1777140844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kEq5CzQFwtAXQUDE7BtOjkL3C6G38PVDQBhAKTNWHjg=;
        b=bul+yPqeE3VpMlw+/SiAZ6gdtSQCjAoWQwoJHUGoBggrso+DM1rKQ3YpxKYQX+Fg/K
         ommcuXCyokcxFTLoG37tPAlw9bCW+s6zaNOgJyOI5tLknId8Iqe1Qn+nRquP4mS0ccio
         zwZ6rzseOymg7djR7eW33NfDqD1Mr8sApgBJkq55pUwVuQeLDQCkw/xCnPl0MmrGBpuS
         lXPSeXsmupguepjKJ3LdAtB3qp47ihY+KkRD+WB1y1Pn+BGVV7regvr9PN9lNHXvzzwh
         grL+VXFHuRjskV77wsyE5dwkz4EYHxF+pofNlLA9W/fPz4UfRU39hDJ1O24F+Fr6LWv3
         7WKg==
X-Gm-Message-State: AOJu0YzlEjJ0KBwbwxwYX9bMVOEa6ftG/G1hDIquob+TXB+kG9BSh/fc
	MSXV0Ax9dCWk1S9JTytZ9V/OjWca/cv6s7wg3NEoZX5v0R+gKsmH+jh4DzMlP8c/Zb1jc3Am
X-Gm-Gg: AeBDiev68UtPBBxxEFSzrig00PibYLJoh5ZiRj/ATiKvu9AxSUx4aqUtq7ySNuVgHZK
	dZ2nGe085w1KrTSYV5v5OQhsYcJ+UjPi3X7BnvDy7mhXapzapaMzxEEzZEw+sML8qZzxfhyMiVG
	XwXskYzrmfM6c8BpByuZW+gTzby0qYlBAyK1ttEzaoNVXi3HjdWWdlW+AnGE+sNyvXtGrcjLPB9
	O71oTEErMOfC+incY9Dv28LdyMHmjrdb8M0M0gLKGfe68LTN4I4xU/8WGSdkUehuC2YRaRiSdNu
	JCxJT8p7Y7CHk/rPfiH0LghjTWXTxD4E/6mA4TpSTDRvPmxzqQ/l4+OSzgHWPsVebn/qbF+gfAb
	xEZ65+sbuudE+ajCWraEk5V+KCqYRUgULlTjHUJjNNdEREjRaUSTymYxnNxFHsNc7bc1u4f9DRR
	V8SM3VUw9U6JYBkeA5vKScsRMbT6xsvrY3BWXnKfDVa/V6RZklb3u32vC/6QD+Pg==
X-Received: by 2002:a05:6a00:14c2:b0:82f:8332:4933 with SMTP id d2e1a72fcca58-82f8c7dd158mr7842814b3a.3.1776536044462;
        Sat, 18 Apr 2026 11:14:04 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm5659402b3a.21.2026.04.18.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 11:14:03 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] selftests/bpf: check epoll readiness after reuseport migration
Date: Sun, 19 Apr 2026 02:13:33 +0800
Message-ID: <20260418181333.1713389-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418181333.1713389-1-jt26wzz@gmail.com>
References: <20260418181333.1713389-1-jt26wzz@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-279539-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazon.co.jp:email]
X-Rspamd-Queue-Id: 56F64421F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After migrate_dance() moves established children to the target
listener, add it to an epoll set and verify that epoll_wait(..., 0)
reports it ready before accept().

This adds epoll coverage for the TCP_ESTABLISHED reuseport migration
case in migrate_reuseport.

Keep the check limited to TCP_ESTABLISHED cases. TCP_SYN_RECV and
TCP_NEW_SYN_RECV still depend on asynchronous handshake completion,
so a zero-timeout epoll_wait() would race there.

Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../bpf/prog_tests/migrate_reuseport.c        | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
index 653b0a20f..580a53424 100644
--- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
@@ -18,13 +18,16 @@
  *   9. call shutdown() for the second server
  *        and migrate the requests in the accept queue
  *        to the last server socket.
- *  10. call accept() for the last server socket.
+ *  10. for TCP_ESTABLISHED cases, call epoll_wait(..., 0)
+ *        for the last server socket.
+ *  11. call accept() for the last server socket.
  *
  * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
  */
 
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <sys/epoll.h>
 
 #include "test_progs.h"
 #include "test_migrate_reuseport.skel.h"
@@ -522,6 +525,33 @@ static void run_test(struct migrate_reuseport_test_case *test_case,
 			goto close_clients;
 	}
 
+	/* Only TCP_ESTABLISHED has already-migrated accept-queue entries
+	 * here.  Later states still depend on follow-up handshake work.
+	 */
+	if (test_case->state == BPF_TCP_ESTABLISHED) {
+		struct epoll_event ev = {
+			.events = EPOLLIN,
+		};
+		int epfd;
+		int nfds;
+
+		epfd = epoll_create1(EPOLL_CLOEXEC);
+		if (!ASSERT_NEQ(epfd, -1, "epoll_create1"))
+			goto close_clients;
+
+		ev.data.fd = test_case->servers[MIGRATED_TO];
+		if (!ASSERT_OK(epoll_ctl(epfd, EPOLL_CTL_ADD,
+					 test_case->servers[MIGRATED_TO], &ev),
+			       "epoll_ctl"))
+			goto close_epfd;
+
+		nfds = epoll_wait(epfd, &ev, 1, 0);
+		ASSERT_EQ(nfds, 1, "epoll_wait");
+
+close_epfd:
+		close(epfd);
+	}
+
 	count_requests(test_case, skel);
 
 close_clients:
-- 
2.43.0


