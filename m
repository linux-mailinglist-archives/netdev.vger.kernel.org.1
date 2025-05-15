Return-Path: <netdev+bounces-190876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E29AB927C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEF67B6F18
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA22296FAD;
	Thu, 15 May 2025 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nQIV5+Ju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE88296FC0
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349623; cv=none; b=TazZpUdCbdOYY3+jCEubg/VOR4BkCC1Ak7WmjZUbYL4ld4H0LCBCRqLnXx3Hp8ZssKCi0iUeY2ZnMiCIWDfQFqGUFq7uL+Stb1XfKuidKSR/r1iuGctSS6AE9WiZVDLi+zGxz02ya3nU4CzgNWUTmUnIv56YurBwFDxckt6pyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349623; c=relaxed/simple;
	bh=sSeE3my2YYc83GoZ3QBi0i0llaYO0eFafewfwD0pMtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q36sngUb1RtDpsztA626eaQiunMJtMH30R6LPK+B50SuNwztptWizB23tK5y1v8ZHrZjKJwOODGh8oQM1xhj5sbRykRq3mCA/TD1nlqCL3cbufXiXYq6hegoJEcFbOPvNxwqvvV/v7WwOozIE4ZzsUaoJIKdcJeYDx7NWPwGyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nQIV5+Ju; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747349622; x=1778885622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPw2hOmfnwFBhCMWXJi69v7gFIpk88PsbzE2BeHuAuA=;
  b=nQIV5+JuvFSWucIZEpEXmvXgGhSI4gwH7SRLwxfRlk0a+4XvpcqzzcqJ
   tBojUx0KF3uqn4ykrYUc1CN6XEJSR0X5fmqgMSxm64LvrdV8flkNVhRFP
   KPOEsaCaO1Bup3FwWbcgIbXF8pAzwk+/3dk29GgckRqPmgaHpZaT1IQ5h
   ko1IAnJydgtBNuQhiuua6e/FXEVQNRD07mJ4LJEEvR28E4WE2Kc0Ib0mV
   0YzSsrjMO95KCVHvDEpVGUsksAsgBdJdvm6s/AOQo/MHhlHwlFVZB+Fij
   qVDgMkC4otGXqOf7gJUOSt8oQ8ghp8Dl0CsJEZ+6cGoT0Eyq157frPz1O
   g==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="745084454"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:53:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:30411]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.47:2525] with esmtp (Farcaster)
 id be77f89d-c5fe-45aa-82de-a83e31f0563b; Thu, 15 May 2025 22:53:36 +0000 (UTC)
X-Farcaster-Flow-ID: be77f89d-c5fe-45aa-82de-a83e31f0563b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:53:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:53:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 9/9] selftest: af_unix: Test SO_PASSRIGHTS.
Date: Thu, 15 May 2025 15:49:17 -0700
Message-ID: <20250515224946.6931-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515224946.6931-1-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

scm_rights.c has various patterns of tests to exercise GC.

Let's add cases where SO_PASSRIGHTS is disabled.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v4: Removed errno juggling
---
 .../selftests/net/af_unix/scm_rights.c        | 80 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index d66336256580..8b015f16c03d 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -23,6 +23,7 @@ FIXTURE_VARIANT(scm_rights)
 	int type;
 	int flags;
 	bool test_listener;
+	bool disabled;
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, dgram)
@@ -31,6 +32,16 @@ FIXTURE_VARIANT_ADD(scm_rights, dgram)
 	.type = SOCK_DGRAM,
 	.flags = 0,
 	.test_listener = false,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, dgram_disabled)
+{
+	.name = "UNIX ",
+	.type = SOCK_DGRAM,
+	.flags = 0,
+	.test_listener = false,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream)
@@ -39,6 +50,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream)
 	.type = SOCK_STREAM,
 	.flags = 0,
 	.test_listener = false,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = 0,
+	.test_listener = false,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream_oob)
@@ -47,6 +68,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_oob)
 	.type = SOCK_STREAM,
 	.flags = MSG_OOB,
 	.test_listener = false,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_oob_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = MSG_OOB,
+	.test_listener = false,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
@@ -55,6 +86,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
 	.type = SOCK_STREAM,
 	.flags = 0,
 	.test_listener = true,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_listener_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = 0,
+	.test_listener = true,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob)
@@ -63,6 +104,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob)
 	.type = SOCK_STREAM,
 	.flags = MSG_OOB,
 	.test_listener = true,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = MSG_OOB,
+	.test_listener = true,
+	.disabled = true,
 };
 
 static int count_sockets(struct __test_metadata *_metadata,
@@ -105,6 +156,9 @@ FIXTURE_SETUP(scm_rights)
 	ret = unshare(CLONE_NEWNET);
 	ASSERT_EQ(0, ret);
 
+	if (variant->disabled)
+		return;
+
 	ret = count_sockets(_metadata, variant);
 	ASSERT_EQ(0, ret);
 }
@@ -113,6 +167,9 @@ FIXTURE_TEARDOWN(scm_rights)
 {
 	int ret;
 
+	if (variant->disabled)
+		return;
+
 	sleep(1);
 
 	ret = count_sockets(_metadata, variant);
@@ -121,6 +178,7 @@ FIXTURE_TEARDOWN(scm_rights)
 
 static void create_listeners(struct __test_metadata *_metadata,
 			     FIXTURE_DATA(scm_rights) *self,
+			     const FIXTURE_VARIANT(scm_rights) *variant,
 			     int n)
 {
 	struct sockaddr_un addr = {
@@ -140,6 +198,12 @@ static void create_listeners(struct __test_metadata *_metadata,
 		ret = listen(self->fd[i], -1);
 		ASSERT_EQ(0, ret);
 
+		if (variant->disabled) {
+			ret = setsockopt(self->fd[i], SOL_SOCKET, SO_PASSRIGHTS,
+					 &(int){0}, sizeof(int));
+			ASSERT_EQ(0, ret);
+		}
+
 		addrlen = sizeof(addr);
 		ret = getsockname(self->fd[i], (struct sockaddr *)&addr, &addrlen);
 		ASSERT_EQ(0, ret);
@@ -164,6 +228,12 @@ static void create_socketpairs(struct __test_metadata *_metadata,
 	for (i = 0; i < n * 2; i += 2) {
 		ret = socketpair(AF_UNIX, variant->type, 0, self->fd + i);
 		ASSERT_EQ(0, ret);
+
+		if (variant->disabled) {
+			ret = setsockopt(self->fd[i], SOL_SOCKET, SO_PASSRIGHTS,
+					 &(int){0}, sizeof(int));
+			ASSERT_EQ(0, ret);
+		}
 	}
 }
 
@@ -175,7 +245,7 @@ static void __create_sockets(struct __test_metadata *_metadata,
 	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
 
 	if (variant->test_listener)
-		create_listeners(_metadata, self, n);
+		create_listeners(_metadata, self, variant, n);
 	else
 		create_socketpairs(_metadata, self, variant, n);
 }
@@ -230,7 +300,13 @@ void __send_fd(struct __test_metadata *_metadata,
 	int ret;
 
 	ret = sendmsg(self->fd[receiver * 2 + 1], &msg, variant->flags);
-	ASSERT_EQ(MSGLEN, ret);
+
+	if (variant->disabled) {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(-EPERM, -errno);
+	} else {
+		ASSERT_EQ(MSGLEN, ret);
+	}
 }
 
 #define create_sockets(n)					\
-- 
2.49.0


