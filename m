Return-Path: <netdev+bounces-109704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BFB929A16
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 00:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A411F2107D
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FEF13FF9;
	Sun,  7 Jul 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="HhQAF2is"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6C79D2
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720392371; cv=none; b=BkaGFUHzBmCt3K0Yg1TF0cHV0cNT8iODEK8FQKNx40x9mHlPsXM0zovCsU0weeLXSfyV9e66kOk5MEwnNRIZUSAbCZMn13csLRSeW83XQdDADf6zvOXgK0jFn2aL18Ps8g4OXe8m6iCGDCoiZMMEKAmEr9/07g04zu7Mr50Fsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720392371; c=relaxed/simple;
	bh=yNwHYkAOCmlJNvypb0TAJ2pUkHpu6UqqKg+zFVXg++4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGYynYVlNcEEM0n5n7gbSzaH792Lc4YHXjnNL5z5v2uye0jOafnVnbIJ3/0tf7hTXhGW2FRogtGTdjcAt2qNMbGrqnlB3tAjMmPytEkh6OzaoocNX+XNqmoJwuiiBjfPWyhnOpFMHWJ8D9jE6UGC+14XHgEhPZVlU4CDUVqbAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=HhQAF2is; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNx-00Eptr-Ri; Mon, 08 Jul 2024 00:29:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=BKuhIUlMW8s1SuZt1nyqI32uXlG0E+DHjgfZWeAUcCY=; b=HhQAF2isE6g3xlniqZ7sK8cEsA
	UqNa94MXmJeVCNvpeCnlYiUaQ4mg8L+r2HDTmKaEalR5dVbZ6UEYRy/AngBaWGu/zxHWx1EEQm4br
	w86GzcXNeLjop0nzO5PM2/nZO8bM5dY+0L+HnIE3NoWFr94Vufx13trvMTeSMNA1stadAjBEsnKFH
	Y2Kc1Gc35DLSBBvjPJ9tFiqQwpU4p/Zk8Xq+bvXAXku5y6VV2YAEL86312+BR4Lod5uZZ4vlGniTX
	uVzYSJ4IrqFU4jA6s5EM1g1dT6alFu1twpegOHyX0Te9mvsRw4s9z0iPfbnqq5MN1Q004485pD9w5
	nqNi9sIQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNx-0003Nf-IK; Mon, 08 Jul 2024 00:29:33 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sQaNc-009IHx-1O; Mon, 08 Jul 2024 00:29:12 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	kuniyu@amazon.com,
	Rao.Shoaib@oracle.com,
	cong.wang@bytedance.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v3 4/4] selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB
Date: Sun,  7 Jul 2024 23:28:25 +0200
Message-ID: <20240707222842.4119416-5-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707222842.4119416-1-mhal@rbox.co>
References: <20240707222842.4119416-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that out-of-band packets are silently dropped before they reach the
redirection logic. Attempt to recv() stale data that might have been
erroneously left reachable from the original socket.

The idea is to test with a 2 byte long send(). Should a MSG_OOB flag be in
use, only the last byte will be treated as out-of-band. Test fails if
verd_mapfd indicates a wrong number of packets processed (e.g. if OOB data
wasn't dropped at the source) or if it was still somehow possble to recv()
OOB from the mapped socket.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 59e16f8f2090..878fcca36a55 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1397,10 +1397,10 @@ static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 			return;
 	}
 
-	n = xsend(cli1, "a", 1, send_flags);
-	if (n == 0)
+	n = xsend(cli1, "ab", 2, send_flags);
+	if (n >= 0 && n < 2)
 		FAIL("%s: incomplete send", log_prefix);
-	if (n < 1)
+	if (n < 2)
 		return;
 
 	key = SK_PASS;
@@ -1415,6 +1415,19 @@ static void __pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 		FAIL_ERRNO("%s: recv_timeout", log_prefix);
 	if (n == 0)
 		FAIL("%s: incomplete recv", log_prefix);
+
+	if (send_flags & MSG_OOB) {
+		key = 0;
+		xbpf_map_delete_elem(sock_mapfd, &key);
+		key = 1;
+		xbpf_map_delete_elem(sock_mapfd, &key);
+
+		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
+		if (n > 0)
+			FAIL("%s: recv(MSG_OOB) succeeded", log_prefix);
+		if (n == 0)
+			FAIL("%s: recv(MSG_OOB) returned 0", log_prefix);
+	}
 }
 
 static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
@@ -1883,6 +1896,10 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
 				     REDIR_EGRESS);
+	__unix_inet_redir_to_connected(family, SOCK_STREAM,
+				       sock_map, nop_map, verdict_map,
+				       REDIR_EGRESS, MSG_OOB);
+
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM,
 				     sock_map, -1, verdict_map,
@@ -1897,6 +1914,9 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	unix_inet_redir_to_connected(family, SOCK_STREAM,
 				     sock_map, nop_map, verdict_map,
 				     REDIR_INGRESS);
+	__unix_inet_redir_to_connected(family, SOCK_STREAM,
+				       sock_map, nop_map, verdict_map,
+				       REDIR_INGRESS, MSG_OOB);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
-- 
2.45.2


