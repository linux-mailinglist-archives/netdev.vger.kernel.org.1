Return-Path: <netdev+bounces-189437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAD8AB20F0
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676607B6630
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B966F266B66;
	Sat, 10 May 2025 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NluB3y7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF8125DF
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842452; cv=none; b=E4TlHMXgY9DYcW+/f5DDbE5OnmK//VvqHZdVhgtXTi9hlPeHmE6aWt1upZKToiCroVDUne9wnTRZiRSGu0Iqi0XKNyZEDhYBMPIuuNXEKbTTTVlP8BtJB6hz9UbyMTOfilhBP1HEsVgRpJzxttVUqWM5gF8Jm/05NhraJItwoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842452; c=relaxed/simple;
	bh=IA+qdALayl+t1penUQ7EF65kNaLr4JL+04KIgpMXGNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTvCSIGZC2YNBQ5py2b7w3lxL+pujO7uXE0jGunXc/AuXwi/U+lMRy7SB28ISiuJmFRSefcR9+qMRTnmAZnE/mfqrFka+/GZKxt0zQRBzudYJApmrVi0DnVtKT7wZskluUtdQ9YXKBGRaZeUARAgx5/ukv2j7pLb77Yr8Y9Pahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NluB3y7x; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842452; x=1778378452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoDhawaKKO5R/HIP+TOVKUiLk6p0PNb8C0D0WGN1Nig=;
  b=NluB3y7x0ZIvBrUUHgRZiOaAmtcHitLT+n7/BL0jWEELji2TfEGcej49
   XtzZ9NWtMyZ7+vvUjz0DJHXh1Fcu4thK+gRW4ACCCpu7HDEHypM+emLcq
   muO/Z7VwZTbu0VIlJitQ4btJrBxcOlGj4KpOmIjD2el9kTJ+7leS29g5p
   pAipIYCBdLqZeb53oXiNn18q3l+rzEopYriJdJk7IZSNqJpkHdhVwZ6xA
   svOSYGDS8ZDZoHSD+9pn3QWU+YiU4i+1gLB87J918VKjBBsfcOw6TpkXR
   /54Me2aU4j8lsvTT4w98UksXiH6RuJT3xtEIKc/Yf8ex1l3X/Vol0jHps
   g==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="91744860"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 02:00:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:58840]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id d831932f-40d5-45f8-8696-92ced9c5c98c; Sat, 10 May 2025 02:00:47 +0000 (UTC)
X-Farcaster-Flow-ID: d831932f-40d5-45f8-8696-92ced9c5c98c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 02:00:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 02:00:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 9/9] selftest: af_unix: Test SO_PASSRIGHTS.
Date: Fri, 9 May 2025 18:56:32 -0700
Message-ID: <20250510015652.9931-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250510015652.9931-1-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

scm_rights.c has various patterns of tests to exercise GC.

Let's add cases where SO_PASSRIGHTS is disabled.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 .../selftests/net/af_unix/scm_rights.c        | 84 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index d66336256580..7589f690fe2f 100644
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
@@ -227,10 +297,18 @@ void __send_fd(struct __test_metadata *_metadata,
 		.msg_control = &cmsg,
 		.msg_controllen = CMSG_SPACE(sizeof(cmsg.fd)),
 	};
-	int ret;
+	int ret, saved_errno;
 
+	errno = 0;
 	ret = sendmsg(self->fd[receiver * 2 + 1], &msg, variant->flags);
-	ASSERT_EQ(MSGLEN, ret);
+	saved_errno = errno;
+
+	if (variant->disabled) {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(-EPERM, -saved_errno);
+	} else {
+		ASSERT_EQ(MSGLEN, ret);
+	}
 }
 
 #define create_sockets(n)					\
-- 
2.49.0


