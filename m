Return-Path: <netdev+bounces-280292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAzTMlg46GkbHAIAu9opvQ
	(envelope-from <netdev+bounces-280292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:54:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A7441A45
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E758A30210F1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B362739526F;
	Wed, 22 Apr 2026 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pikjsedV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DA1E89C
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826009; cv=none; b=CgbGVYxUTDBd2KUnhnjqmjcF5YGV74uUIrb5cpIVl2iaT00Hq/DyI81LeuQZGswDzPee1/K8ts2o0fV+i/FAqv3dxv+q9yekKzpr0gzmgITh2wrKaUxAVhimTbC42A+qtOJpDa2fq4TY+k24ZkYG7pVaFuGJdLeYJcKxSkMHVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826009; c=relaxed/simple;
	bh=0sA2sLWOI1+YrADOtn/nn5LqfxqcE06IldheBa+ejVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHZRDvsiudR7VJ8sHTLMMZhXxa4Ikt2J2vsIWTAQ3HrCBzDVvze7TRjnYUWBLKZv8LEkOnl3lH0+5KzeBsxp+OUweCKBnBdjShSnR57Kp44N17rK5xQ/1cNoIQUxBaTX6IE/LVX6pomtPrTD0BEfSWwQx2LQNy6NaJecZFgvMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pikjsedV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c648bc907ebso3159682a12.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776825999; x=1777430799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS/6+OQwHBm0U4E/bt3m5g//SPZTdfGBYdVOL3eGpDw=;
        b=pikjsedV/6GXojXW6P3fNbkfSD/yuiKE62Q2hOY9r3IVyzRPPoSJecEYQ/6QplW3IU
         UeJSINZG+lkosuUVyjBCF8oJjqLW+1AirhSLsKfsKPL7XnlDaZSBUSP8UDp9+mtkZEqr
         rOXj+aJSkOMTSy1102dXwJeKZWbNJibAsjhZGEbtD1Hja4GCTqbmcHr0CHBfzVDRVonY
         M6BjClsCLIiMcSkWvyepNz66U6HAoJlLL4EHYibdVFaDKQKTjX2w/Avjx9jCAkQ8dn+G
         Iu2RTIY2e67W0XKDqLIFygz2yE24Q7cftRn3Y638OWsgOURs9D5sgMYiDF7KWdzD+CqL
         eXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776825999; x=1777430799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lS/6+OQwHBm0U4E/bt3m5g//SPZTdfGBYdVOL3eGpDw=;
        b=fdehMTe0vVo9s6eTXEqkekMO8UhdLcGBWmYggEjXT79dPSfJXfY2GshJfcRJwAoywu
         fkGYelNjFcICC1Ulx5a40kyhGFIxfL5vLbferzbt6quGcE7T9A8sFkPUgT833E6Lkh/H
         vRRW+MdqfD8ppVFW1rd3TWLu/ZVX2/hfXdXntdDYLsaMU66nL30GDAyUr4/nPjQcdO42
         0sRenPMul12PT8+WrIxwirKH+7tSull1VJ62UP169FaW9DlA2lGxxWYnSuLb0nH9DZUd
         Nblc/8TWcG+MDVQ+TPB6/3xpXmo/VK7SeamKPWrXVVxoLTOEe2sWJ6W7tP1h/usbflgs
         F2lQ==
X-Gm-Message-State: AOJu0YySLiDUsRoHCtBxE0UOl2eRGWKdOCXsNPpvG/EMFAsgdulDvsjs
	3PJTHctKrIPrLeSI/VuDgag2tBIu4wNUSZ9+FHvtWv+cG+ux9yzBOWauLkCUCnIsd+aYhA==
X-Gm-Gg: AeBDiesfmUSgaVayL1XeniIJl/DOTQIFzqZ8d0kWhecxyrUnDReXLrb8X841dg9pLI2
	7Jh2maJj57hIsEVRsFgJGw6uZ55sVyQwkDbFgCXILfE0LDdVT3MzG+/Dh96J+71CeUJiyDJoPml
	XU5jDNWG8nxfwrOFiM5E0Uk5yfkf+Y+PUEt2LqmDlrG7TFX1cpDjN27ISl6KDJoiKc3aJ9shZdW
	70V+o65nblcnRBDFNwhDbfl1AY+l2gtPg2iQwbEUN4NL2GwXP2fpsMzyt0seRM+4ayJYxODdMD/
	+RUrQOZTIAJiYaJ2e8rCoxq3OTGZ7Zh3KPVLiZ8l8yWT4y1DiQrw+SbxZvX7U648cVfmcAAsGo0
	TXGt4EoOHJUqoXAltBRcgyWrBVSvJzh8E75Td3XjLp0TMX0BvE75mzWAZJ9DFGkXlCsU9z4FOiD
	zQfmLxUp8ijJ9G1mBlgzB3Rh9X8mcM3BRm/e6KHi/cBAJfKdxWFfN8A0OwXVlzKg==
X-Received: by 2002:a05:6a21:32a1:b0:3a2:f402:50fb with SMTP id adf61e73a8af0-3a2f402551emr4604812637.34.1776825999302;
        Tue, 21 Apr 2026 19:46:39 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f92183sm10656632a12.3.2026.04.21.19.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:46:38 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] selftests/bpf: check epoll readiness during reuseport migration
Date: Wed, 22 Apr 2026 10:45:54 +0800
Message-ID: <20260422024554.130346-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422024554.130346-1-jt26wzz@gmail.com>
References: <20260422024554.130346-1-jt26wzz@gmail.com>
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
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,amazon.co.jp:server fail];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-280292-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2D6A7441A45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Inside migrate_dance(), add epoll checks around shutdown() to
verify that the target listener is not ready before shutdown()
and becomes ready immediately after shutdown() triggers migration.

Cover TCP_ESTABLISHED and TCP_SYN_RECV. Exclude TCP_NEW_SYN_RECV
as it depends on later handshake completion.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../bpf/prog_tests/migrate_reuseport.c        | 49 ++++++++++++++++---
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
index 653b0a20f..c62907732 100644
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
@@ -350,21 +355,51 @@ static int update_maps(struct migrate_reuseport_test_case *test_case,
 
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
 	for (i = 0; i < MIGRATED_TO; i++) {
 		err = shutdown(test_case->servers[i], SHUT_RDWR);
 		if (!ASSERT_OK(err, "shutdown"))
-			return -1;
+			goto close_epoll;
 	}
 
 	/* No dance for TCP_NEW_SYN_RECV to migrate based on eBPF */
 	if (test_case->state == BPF_TCP_NEW_SYN_RECV)
 		return 0;
 
+	nfds = epoll_wait(epoll, &ev, 1, 0);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait 2")) {
+close_epoll:
+		if (epoll >= 0)
+			close(epoll);
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

