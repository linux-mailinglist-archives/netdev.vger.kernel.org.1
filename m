Return-Path: <netdev+bounces-188841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD2AAF0A9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC163BAD36
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D033FD;
	Thu,  8 May 2025 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SwWKaRpt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA444B1E7F
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668005; cv=none; b=mTSTUGyLELx7aPdZCDOVvSMvk8qDidf8ctO/ykjP/cP6+gaFzOYQcs7ICC8kX856dftEnHCdR0GfLRvqR3f+iPP60KLXNpWBG0M6F8zozHfEYPXnblwXyQwY9BnqvEmBXKpsdAdtz72wsczkAnBd8OaYDM2nqn3BuqSZZAUdlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668005; c=relaxed/simple;
	bh=IA+qdALayl+t1penUQ7EF65kNaLr4JL+04KIgpMXGNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2DREE57n7h/JaGeMm5ZZnrlleNbRZkv2wPC8jX13eY6KZWHALReWrTku6qqADutHq8picqopeaTBSXh/GYa3yEmYfuER0kIFkzJNqaM3w6mKVApENBKPSFfM8Jyl14RQIpDLl288cKQpfXaXpYkj5975ta8xxPz3Htl0VQ1wIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SwWKaRpt; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746668005; x=1778204005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoDhawaKKO5R/HIP+TOVKUiLk6p0PNb8C0D0WGN1Nig=;
  b=SwWKaRptxqkNIZOFrG/KfyFcrg90LT5pU9KvNEquR/2MQ12/n7a4Sm90
   H9rh9mgUaZaa9yCY1LmJ9JhbqdfQW/HxRxVGS2nK3CF8f/7EgJ1wwNact
   Wa5YAWFGQqjoiLwKZu8GM31uFQojzgYyhshoGgLT+ZmfT/FpxzO+Otd9o
   SV9aKz75peuALU58kHpxfxsJILdyF9k5FDJVmoxThimwt9pccs37Ji07b
   3zRBGe5NcQ80prYlTRmFJjz9hwI+aaKKiW9PHwnTD2McfA3nj/pSwy3e+
   VEoarOZ3ZWoBHBs9q3w8o0Vx3y8RXvU6CJ3zfwFKei5UFIMnuXWQfDFI5
   g==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="518449733"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:33:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:8732]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.6:2525] with esmtp (Farcaster)
 id d5a41967-54d0-4fc8-9077-dd3af32c5a5f; Thu, 8 May 2025 01:33:22 +0000 (UTC)
X-Farcaster-Flow-ID: d5a41967-54d0-4fc8-9077-dd3af32c5a5f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:33:22 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:33:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 7/7] selftest: af_unix: Test SO_PASSRIGHTS.
Date: Wed, 7 May 2025 18:29:19 -0700
Message-ID: <20250508013021.79654-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508013021.79654-1-kuniyu@amazon.com>
References: <20250508013021.79654-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
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


