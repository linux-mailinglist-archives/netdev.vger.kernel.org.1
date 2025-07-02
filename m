Return-Path: <netdev+bounces-203545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051F7AF655F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8754E428D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107332FC3BF;
	Wed,  2 Jul 2025 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+5ATI4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B02FC3AD
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495781; cv=none; b=b74zKrVkkqRaZAEDrepVbsw6vCcsQKRQ0vtFZz0SwG6USuSQCCWri2F9hJxbSOgRH2J6bgFvzLe81YBHlh6SxulOMqRc0AU8V9/PzBElRb7zDNnrCxLgklZvV5pSswX8YqbT3lrr1+ofjVY9yXc5eKBlLeT3dbIWUye0rtwEn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495781; c=relaxed/simple;
	bh=8Psec7NfL7Sg7ApBU6Lsqxq5w7EgK83RT7SZmZOFZBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gsQBBLg40BQufDYLEm8JY7cJLdTH7+JkzYzOXbPFtpWT8Dgbu8NrwxPgs7iEKMCnpnU0CeWyTl10ZKZ0XfX/209LW+J0GLM1HGiGK4AaXlcEPJzAqqQO4luyXOdVjTqQ4/RjraQfI+Ccjg2iYNGyj/0UFLnwJUzq40OeCkOehOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+5ATI4K; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313c3915345so10959242a91.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495779; x=1752100579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBPqMESuHz/XLhM0hLB1GqVtS4J6k7NDaRLsOCjlXBY=;
        b=d+5ATI4KAFVv0srIZK+79yPQYNT1Aspkmog6gsB8EHbIbBVZ5bBQUliX0X1YF9LCVn
         uOlypo11vLEOXtKekMO5GsTRR0gJOIJu/ZIe96KBpMngxjzUhqpD/LPqOn5L7MnZe8vh
         5nkHZ0bBeCDN4L8dUy4vsG9hcwigHW6UsAHYGFImyDtNwRQ7phQdLLZ3ZQ8PEwR88jiE
         dUB9jVzY5eY91iMUaMxqknndOxg6REMUCod1/NflaBo0XcR37DhevIVjW1BBX9PJ3Cwn
         lBuNrHAYlZrghZAKrky04rr/dNgUWxAFAQQzRhY37Jf0YAmumoYtLWJcoxzK5poAcRM2
         70sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495779; x=1752100579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBPqMESuHz/XLhM0hLB1GqVtS4J6k7NDaRLsOCjlXBY=;
        b=kQbBNGB98FNN3hDN3P8YpUnDzHCXW3JA9FWIIUcz7Zes3DELk6E4+d1p+c9NpgPGBy
         G1sA5lqc56zWIH0+r0qtibLeFM5U3FawILgkXrdkU+j4SI0jKfNa1ZZYDszk7g4lqIoo
         F1m9YM+RjkrPpyp5Jg7AvJIdlklBJ0VWc9/nDYKdosFcsYrt2uJHUP6MYocVBV527F70
         o0E7wDL8OYuf+56AxVtTp3sjRnY70K2u50QoNd1gt4W/AfKf8IAXDQZzKpP9hCpFJKaH
         Hd8rfT+3j7tKn0Pn08tASC69FgOe2JzDMYcK15mQIx9EDvcw2fsrgtJbaappgEFptxxj
         q75A==
X-Forwarded-Encrypted: i=1; AJvYcCX8Jm2pC26t5hifa1ds1aib2NtMTPQB7eIO35HUeg1y2PLOf0UQ5u5TAiF4ms0ObitmXmuZOcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XQhG32PEwlqr/CMBiLCrj9w/U/Y4xK+aC4bigDy0IZIXFQsk
	OIds6dDFYn+PfpXo06TJWNgia7/qDaOubROhlxux2oVyQBpFlQOaI8F7Aq/Uahzg3vLrL8u+Yd6
	5VB1rtw==
X-Google-Smtp-Source: AGHT+IHtAJIr5rMnRKVne+zOCX3kkLHmuEpIHdlcbObr33jlewVmOtagtn4QOCxp6o7L25mIVger5LH6L54=
X-Received: from pjbsu14.prod.google.com ([2002:a17:90b:534e:b0:312:1900:72e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5544:b0:312:db8:dbdc
 with SMTP id 98e67ed59e1d1-31a90bcae1amr6526284a91.20.1751495778814; Wed, 02
 Jul 2025 15:36:18 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:19 +0000
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 7/7] selftest: af_unix: Add test for SO_INQ.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's add a simple test to check the basic functionality of SO_INQ.

The test does the following:

  1. Create socketpair in self->fd[]
  2. Enable SO_INQ
  3. Send data via self->fd[0]
  4. Receive data from self->fd[1]
  5. Compare the SCM_INQ cmsg with ioctl(SIOCINQ)

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 tools/testing/selftests/net/af_unix/scm_inq.c | 125 ++++++++++++++++++
 3 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_inq.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index c6dd2a335cf4..47c293c2962f 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -34,6 +34,7 @@ reuseport_bpf_numa
 reuseport_dualstack
 rxtimestamp
 sctp_hello
+scm_inq
 scm_pidfd
 scm_rights
 sk_bind_sendto_listen
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 50584479540b..a4b61c6d0290 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := diag_uid msg_oob scm_pidfd scm_rights unix_connect
+TEST_GEN_PROGS := diag_uid msg_oob scm_inq scm_pidfd scm_rights unix_connect
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testing/selftests/net/af_unix/scm_inq.c
new file mode 100644
index 000000000000..9d22561e7b8f
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_inq.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include <linux/sockios.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+
+#include "../../kselftest_harness.h"
+
+#define NR_CHUNKS	100
+#define MSG_LEN		256
+
+struct scm_inq {
+	struct cmsghdr cmsghdr;
+	int inq;
+};
+
+FIXTURE(scm_inq)
+{
+	int fd[2];
+};
+
+FIXTURE_VARIANT(scm_inq)
+{
+	int type;
+};
+
+FIXTURE_VARIANT_ADD(scm_inq, stream)
+{
+	.type = SOCK_STREAM,
+};
+
+FIXTURE_VARIANT_ADD(scm_inq, dgram)
+{
+	.type = SOCK_DGRAM,
+};
+
+FIXTURE_VARIANT_ADD(scm_inq, seqpacket)
+{
+	.type = SOCK_SEQPACKET,
+};
+
+FIXTURE_SETUP(scm_inq)
+{
+	int err;
+
+	err = socketpair(AF_UNIX, variant->type | SOCK_NONBLOCK, 0, self->fd);
+	ASSERT_EQ(0, err);
+}
+
+FIXTURE_TEARDOWN(scm_inq)
+{
+	close(self->fd[0]);
+	close(self->fd[1]);
+}
+
+static void send_chunks(struct __test_metadata *_metadata,
+			FIXTURE_DATA(scm_inq) *self)
+{
+	char buf[MSG_LEN] = {};
+	int i, ret;
+
+	for (i = 0; i < NR_CHUNKS; i++) {
+		ret = send(self->fd[0], buf, sizeof(buf), 0);
+		ASSERT_EQ(sizeof(buf), ret);
+	}
+}
+
+static void recv_chunks(struct __test_metadata *_metadata,
+			FIXTURE_DATA(scm_inq) *self)
+{
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct scm_inq cmsg;
+	char buf[MSG_LEN];
+	int i, ret;
+	int inq;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = &cmsg;
+	msg.msg_controllen = CMSG_SPACE(sizeof(cmsg.inq));
+
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+
+	for (i = 0; i < NR_CHUNKS; i++) {
+		memset(buf, 0, sizeof(buf));
+		memset(&cmsg, 0, sizeof(cmsg));
+
+		ret = recvmsg(self->fd[1], &msg, 0);
+		ASSERT_EQ(MSG_LEN, ret);
+		ASSERT_NE(NULL, CMSG_FIRSTHDR(&msg));
+		ASSERT_EQ(CMSG_LEN(sizeof(cmsg.inq)), cmsg.cmsghdr.cmsg_len);
+		ASSERT_EQ(SOL_SOCKET, cmsg.cmsghdr.cmsg_level);
+		ASSERT_EQ(SCM_INQ, cmsg.cmsghdr.cmsg_type);
+
+		ret = ioctl(self->fd[1], SIOCINQ, &inq);
+		ASSERT_EQ(0, ret);
+		ASSERT_EQ(cmsg.inq, inq);
+	}
+}
+
+TEST_F(scm_inq, basic)
+{
+	int err, inq;
+
+	err = setsockopt(self->fd[1], SOL_SOCKET, SO_INQ, &(int){1}, sizeof(int));
+	if (variant->type != SOCK_STREAM) {
+		ASSERT_EQ(-ENOPROTOOPT, -errno);
+		return;
+	}
+
+	ASSERT_EQ(0, err);
+
+	err = ioctl(self->fd[1], SIOCINQ, &inq);
+	ASSERT_EQ(0, err);
+	ASSERT_EQ(0, inq);
+
+	send_chunks(_metadata, self);
+	recv_chunks(_metadata, self);
+}
+
+TEST_HARNESS_MAIN
-- 
2.50.0.727.gbf7dc18ff4-goog


