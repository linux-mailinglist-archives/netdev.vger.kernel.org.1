Return-Path: <netdev+bounces-106312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED9915BC0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0927B210CD
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0F182D8;
	Tue, 25 Jun 2024 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v3HlVSuM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFF101D5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279549; cv=none; b=lNvBCm2E9TkV786u8OPSW99MmmvMwOGLf9QZcpN/1GpafZWPTTp8kX4kXzdwLhnpKYv+MZ+ajJ70M3NKkdY611sAEWNVS7GbmZcJ17hWVViRr/HZ2Nc0uUn9CJ1/2bPWu4lQ+3roTrchesT/Gj+3ZZcgkLCtH2DPT4o5GTY1h6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279549; c=relaxed/simple;
	bh=PjyE8uAJSl7Gd5oTmPzKESdYfJfHk5EPylCwzbiQh80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmqk81iw+q6epAfdFAs30iYj8fLdUy41+ozlR+x7Wd2/hGsJLzqvApwT2CDdyHj+PtW6iPiV3IYwYR5cPcVIMjIIZTBIRJiZu2Vu4OJkTcECHS6nsSmROqqIprw0XibUazAbK/1KpkmPEdcqJ2dvkdKw+KhZiBA0yxm9QnLTVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v3HlVSuM; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279548; x=1750815548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=deK2s3OySZyiDTN09vrjF+MQuc7xP+mitLAS81/3M3U=;
  b=v3HlVSuMrfWJHaTFSYA8fmV7DEvfiRBSq6YBtnfban+odItLLJH5mLqi
   ivZJDSLZuNKd5FWoyEfJ23BomSTzd+NC83uNJyk3/YssCDtI7ZepHYCq7
   2DQxsgS7+nlK2da1k81xcOl9yukRhsCdoHlPU+XohMLUFZmHeXkjrLSl9
   s=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="641437120"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:39:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:40312]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.193:2525] with esmtp (Farcaster)
 id 7cb70b75-badd-4910-8a52-236b9d1028a7; Tue, 25 Jun 2024 01:39:06 +0000 (UTC)
X-Farcaster-Flow-ID: 7cb70b75-badd-4910-8a52-236b9d1028a7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:39:04 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:39:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 05/11] selftest: af_unix: Add non-TCP-compliant test cases in msg_oob.c.
Date: Mon, 24 Jun 2024 18:36:39 -0700
Message-ID: <20240625013645.45034-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240625013645.45034-1-kuniyu@amazon.com>
References: <20240625013645.45034-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While testing, I found some weird behaviour on the TCP side as well.

For example, TCP drops the preceding OOB data when queueing a new
OOB data if the old OOB data is at the head of recvq.

  #  RUN           msg_oob.no_peek.ex_oob_drop ...
  # msg_oob.c:146:ex_oob_drop:AF_UNIX :x
  # msg_oob.c:147:ex_oob_drop:TCP     :Resource temporarily unavailable
  # msg_oob.c:146:ex_oob_drop:AF_UNIX :y
  # msg_oob.c:147:ex_oob_drop:TCP     :Invalid argument
  #            OK  msg_oob.no_peek.ex_oob_drop
  ok 9 msg_oob.no_peek.ex_oob_drop

  #  RUN           msg_oob.no_peek.ex_oob_drop_2 ...
  # msg_oob.c:146:ex_oob_drop_2:AF_UNIX :x
  # msg_oob.c:147:ex_oob_drop_2:TCP     :Resource temporarily unavailable
  #            OK  msg_oob.no_peek.ex_oob_drop_2
  ok 10 msg_oob.no_peek.ex_oob_drop_2

This patch allows AF_UNIX's MSG_OOB implementation to produce different
results from TCP when operations are guarded with tcp_incompliant{}.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 49 +++++++++++++++++--
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index b5226ccec3ec..46e92d06b0a3 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -19,6 +19,7 @@ FIXTURE(msg_oob)
 				 * 2: TCP sender
 				 * 3: TCP receiver
 				 */
+	bool tcp_compliant;
 };
 
 FIXTURE_VARIANT(msg_oob)
@@ -88,6 +89,8 @@ FIXTURE_SETUP(msg_oob)
 {
 	create_unix_socketpair(_metadata, self);
 	create_tcp_socketpair(_metadata, self);
+
+	self->tcp_compliant = true;
 }
 
 FIXTURE_TEARDOWN(msg_oob)
@@ -115,6 +118,7 @@ static void __recvpair(struct __test_metadata *_metadata,
 {
 	int i, ret[2], recv_errno[2], expected_errno = 0;
 	char recv_buf[2][BUF_SZ] = {};
+	bool printed = false;
 
 	ASSERT_GE(BUF_SZ, buf_len);
 
@@ -142,8 +146,12 @@ static void __recvpair(struct __test_metadata *_metadata,
 		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
 		TH_LOG("TCP     :%s", ret[1] < 0 ? strerror(recv_errno[1]) : recv_buf[1]);
 
-		ASSERT_EQ(ret[0], ret[1]);
-		ASSERT_EQ(recv_errno[0], recv_errno[1]);
+		printed = true;
+
+		if (self->tcp_compliant) {
+			ASSERT_EQ(ret[0], ret[1]);
+			ASSERT_EQ(recv_errno[0], recv_errno[1]);
+		}
 	}
 
 	if (expected_len >= 0) {
@@ -159,10 +167,13 @@ static void __recvpair(struct __test_metadata *_metadata,
 
 		cmp = strncmp(recv_buf[0], recv_buf[1], expected_len);
 		if (cmp) {
-			TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
-			TH_LOG("TCP     :%s", ret[1] < 0 ? strerror(recv_errno[1]) : recv_buf[1]);
+			if (!printed) {
+				TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
+				TH_LOG("TCP     :%s", ret[1] < 0 ? strerror(recv_errno[1]) : recv_buf[1]);
+			}
 
-			ASSERT_EQ(cmp, 0);
+			if (self->tcp_compliant)
+				ASSERT_EQ(cmp, 0);
 		}
 	}
 }
@@ -180,6 +191,11 @@ static void __recvpair(struct __test_metadata *_metadata,
 			   expected_buf, expected_len, buf_len, flags);	\
 	} while (0)
 
+#define tcp_incompliant							\
+	for (self->tcp_compliant = false;				\
+	     self->tcp_compliant == false;				\
+	     self->tcp_compliant = true)
+
 TEST_F(msg_oob, non_oob)
 {
 	sendpair("x", 1, 0);
@@ -249,4 +265,27 @@ TEST_F(msg_oob, ex_oob_break)
 	recvpair("ld", 2, 2, 0);
 }
 
+TEST_F(msg_oob, ex_oob_drop)
+{
+	sendpair("x", 1, MSG_OOB);
+	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+
+	tcp_incompliant {
+		recvpair("x", 1, 1, 0);		/* TCP drops "y" by passing through it. */
+		recvpair("y", 1, 1, MSG_OOB);	/* TCP returns -EINVAL. */
+	}
+}
+
+TEST_F(msg_oob, ex_oob_drop_2)
+{
+	sendpair("x", 1, MSG_OOB);
+	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+
+	recvpair("y", 1, 1, MSG_OOB);
+
+	tcp_incompliant {
+		recvpair("x", 1, 1, 0);		/* TCP returns -EAGAIN. */
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.30.2


