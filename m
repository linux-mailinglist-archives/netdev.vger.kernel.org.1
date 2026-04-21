Return-Path: <netdev+bounces-280105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP8LO6du52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:33:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E3B43AA85
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818C33053DC1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3CB3CA493;
	Tue, 21 Apr 2026 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAFCK7qZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C043C872E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774694; cv=none; b=GIPaBtuVLewkc5vhFZHlmndLFh5BMyLRWcIiN/SyZBM7Nkw0+qXX68ex6INJRIWM8cTxSx4747+sLuvGpKGRsvNxXCxuEUWcEcy1cxyBbYr7xGOVCvb+dbiEni/9NVtU4zeBev+gDpKYqpvLa7vSkzGTRY1FTHfRQePbD7GUvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774694; c=relaxed/simple;
	bh=w884/R5pRr4A9Ao3FZ4s632FkuobTk5hiTXn9qCtIm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFE+AkhxtKaUsD8TLWow/AnAj/e4aiQ7njQ62EFnXy3EREvvidRVrBDMVXZZuW7IpPc1FVbZAZDmZhhB8KYM4ZU0bXROu1PMa7igj6OYYZ+8nxDE9OQ7CEwObErAZAi1XcDbCYgMTjLmSSMk2gWNxGr9sJhg6SnWcLvTSWYgoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAFCK7qZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab46931cf1so36415505ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776774689; x=1777379489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfSMMYYOulor7sfQhsaown6uCtV1QzJ0oZSRjmjzgNk=;
        b=lAFCK7qZfgCVLE2+iHUNp76bMMvpI5XdqYHfJC++v1x1nV2sxfP1mGU+XZF49eY3Qg
         GY8/l8VeSKedA68mv63mRQO/AOePhkriKrZCCSpWimFlIiEYWg2/3LUWWdpzTVjFEdGc
         Y+NeGfcHfB0u76IeKYVEgDPb18UY8RFbcfd2eBfRQBkHCid8LGdMgTEpqtBER0GCdMly
         VFJ0/WBignMqLlCs5+DRddlJPh+9T8+92b5cNWeVKb6/Hdfm8gGAXIAZEv9v3dKU/b1p
         6uOhwfChOVgUs/ObL6xV7kdZ74eIuKsLm/ZkF50I4T88vcgF0uAEpzaTJa6TwelkgHBh
         bZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774689; x=1777379489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfSMMYYOulor7sfQhsaown6uCtV1QzJ0oZSRjmjzgNk=;
        b=fGNPgVwpvOVRoF8XWaYAYWWFx799tJ0OiDK77Pv02le3BjYOFm++QjUKovG41MTfcn
         ksFrgl+PrSTF0AjaSNH+/R5IhPaBr4z+dDso2AVfrWtBD4tuwhrreuCAOQ/YtKtpIngh
         UszUW8muujhEuNx51lUWAXUIz838WN1jBXOC2v46pcDQOfZbqQEYRHVQXQXQhHLYS/Hr
         V4NPj/gl38H/UtKpsG6WJmXlMWVf10gaS13mC33AZGweW8IjEsW0qZ4rPbeO6elv0Wn5
         rqoohbgC8zdtQLKyAaPHWLnGPDCiNBhXZYsrGJw4YXxzJ7OK/Q9oflNi+UkFq8ni2waJ
         KmzA==
X-Gm-Message-State: AOJu0YxJ6B15dYhqsCg+cni3MrqIR99wZvijilqXsUMTERsKYDhIFUXE
	6h2ds+uzMKv5FKFqmqtAJJLw+ixkTflI3jTi9cocN89p+UitKeMsxLhSqF1zo83wBKG6NA==
X-Gm-Gg: AeBDiesyvbxZVaC+kSJIJdZto7mv2ZhcVQMG+vwVIbCaoUlfI63//C+3QXvsxtSl1Ih
	u0TfLeo32rRbAOidZDX5RjZSZ1SG0z6W1v1EjmzsUimUmfJW8Lv3FlDwR+6cm6c6gy1+BVV7NPz
	WWWelQzsvEinrkWVjnpAGn7LUnrdEEWYJ7jvKubeLrW8WjWUdglYOq4iieRJsBnbhRq0FqMMQtj
	/7u+Gm3NyN4fgCd9U8/R+qH2/z6jafpa5p5tdMQQCm+eEU3kBSKmAs+ib1KcasZ7OSezmP15j09
	Oj5eLMar5P9OXAlvul5gLrjzQvn1PuHik6i5BbVSp+oKBNeWPBtpJWBfUhoIE4FLKh12GbCw7GD
	tDC670B50ZlZiQHjf9FTQsPDAhSdbtYVzqLmNvw+vbjucTB3KRCKJZnpeFgq/Z7YU/ZrDikqGVC
	+Efxm2ZCZ5LkPhpdB0yoiVN5EWejlPer24B5vwP6f6hjJ7S3KVVkU5wEHuZKHjLm/io36J9Spz
X-Received: by 2002:a17:902:bb96:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b5f9ed4d0cmr96165515ad.24.1776774689295;
        Tue, 21 Apr 2026 05:31:29 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff409sm169724315ad.14.2026.04.21.05.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:31:28 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] selftests/bpf: check epoll readiness during reuseport migration
Date: Tue, 21 Apr 2026 20:31:06 +0800
Message-ID: <20260421123106.142299-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421123106.142299-1-jt26wzz@gmail.com>
References: <20260421123106.142299-1-jt26wzz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-280105-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49E3B43AA85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Inside migrate_dance(), add epoll checks around shutdown() to
verify that the target listener is not ready before shutdown()
and becomes ready immediately after shutdown() triggers migration.

Cover TCP_ESTABLISHED and TCP_SYN_RECV. Exclude TCP_NEW_SYN_RECV
as it depends on later handshake completion.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../bpf/prog_tests/migrate_reuseport.c        | 46 ++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
index 653b0a20f..6180a79a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
@@ -7,24 +7,29 @@
  *   3. call listen() for 1 server socket. (migration target)
  *   4. update a map to migrate all child sockets
  *        to the last server socket (migrate_map[cookie] = 4)
- *   5. call shutdown() for first 4 server sockets
+ *   5. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
+ *        that the last server socket is not ready before migration.
+ *   6. call shutdown() for first 4 server sockets
  *        and migrate the requests in the accept queue
  *        to the last server socket.
- *   6. call listen() for the second server socket.
- *   7. call shutdown() for the last server
+ *   7. for TCP_ESTABLISHED and TCP_SYN_RECV cases, verify via epoll
+ *        that the last server socket is ready after migration.
+ *   8. call listen() for the second server socket.
+ *   9. call shutdown() for the last server
  *        and migrate the requests in the accept queue
  *        to the second server socket.
- *   8. call listen() for the last server.
- *   9. call shutdown() for the second server
+ *  10. call listen() for the last server.
+ *  11. call shutdown() for the second server
  *        and migrate the requests in the accept queue
  *        to the last server socket.
- *  10. call accept() for the last server socket.
+ *  12. call accept() for the last server socket.
  *
  * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
  */
 
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <sys/epoll.h>
 
 #include "test_progs.h"
 #include "test_migrate_reuseport.skel.h"
@@ -350,8 +355,28 @@ static int update_maps(struct migrate_reuseport_test_case *test_case,
 
 static int migrate_dance(struct migrate_reuseport_test_case *test_case)
 {
+	struct epoll_event ev = {
+		.events = EPOLLIN,
+	};
+	int epoll = -1, nfds;
 	int i, err;
 
+	if (test_case->state != BPF_TCP_NEW_SYN_RECV) {
+		epoll = epoll_create1(0);
+		if (!ASSERT_NEQ(epoll, -1, "epoll_create1"))
+			return -1;
+
+		ev.data.fd = test_case->servers[MIGRATED_TO];
+		if (!ASSERT_OK(epoll_ctl(epoll, EPOLL_CTL_ADD,
+					 test_case->servers[MIGRATED_TO], &ev),
+			       "epoll_ctl"))
+			goto close_epoll;
+
+		nfds = epoll_wait(epoll, &ev, 1, 0);
+		if (!ASSERT_EQ(nfds, 0, "epoll_wait 1"))
+			goto close_epoll;
+	}
+
 	/* Migrate TCP_ESTABLISHED and TCP_SYN_RECV requests
 	 * to the last listener based on eBPF.
 	 */
@@ -365,6 +390,15 @@ static int migrate_dance(struct migrate_reuseport_test_case *test_case)
 	if (test_case->state == BPF_TCP_NEW_SYN_RECV)
 		return 0;
 
+	nfds = epoll_wait(epoll, &ev, 1, 0);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
+close_epoll:
+		close(epoll);
+		return -1;
+	}
+
+	close(epoll);
+
 	/* Note that we use the second listener instead of the
 	 * first one here.
 	 *
-- 
2.43.0


