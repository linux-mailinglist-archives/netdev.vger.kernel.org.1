Return-Path: <netdev+bounces-239210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E90C65993
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EE904E2BF1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38230B520;
	Mon, 17 Nov 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaHfipOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355423C8C7
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401668; cv=none; b=iphFjGTKo46MIjbpwyTvY0Zi19gJoEheXOeQkJ1E7YDPf+f9FnMP7eXI5E67N3fL1c0ko3rCopuHpTw5g3VcRVTe4KSh8BznuKF8fQ5qa/7wJBCCMALZUE/a6X8oQtTsd7BPPfVzt06G8OECQgSl0wDu8zYnfXsQTMCmlDKsTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401668; c=relaxed/simple;
	bh=bOYKoR59HQaKP717DZydcRDylyAHbL3D+6RnVNAK7BQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=os+oc4n7WkNwthArru1zm50iylM6eFZr5qs/0EEAg1YxnNL2XJnssi3bgUTBPXKZquyjRMsAXRtCjVQFWIJiF69tvbeXJIE+QLtjn6gIL74H7cTVGLzpE2qKWPZDLE+74L5UYUFz8+WLxr29Cd11OhEBoryLbbHwuBkC+4bX+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaHfipOS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-298389232c4so64602055ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763401666; x=1764006466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpVZkb6IlszUoxEr+HJV1H+udwymGsBBYKy+5AMIQR0=;
        b=zaHfipOSXBODg2VHiS2dvofhHJjopLOQBb3SY10Fg99mxHuKDMRAAv/p5rqpOx4T5Z
         QcrgGQDhIMToyM7Ox2rolAcayEzN05ywbiGcaq0wTD5dmMalChluguVU08OTIxSnBlHs
         IDKxNIY8ZA7ia27bgIvbbERZtdQuLQOrtcMkzL2UyC0NwKJJLakR7+M2Wsoq9YPXlQJ+
         A8pnlfFBq/XfAWvH/MQv24eg0heMf7Ne/5BNBFmQxLejS+Tirz3tbNN7zBnt1fgKVgw5
         bPeZcLhhZqScncfQ6uz2S8rIAEpCi2orI8i3hBVc3LqCm5DhzqV+9zcbjXSe86Ywqqca
         V9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401666; x=1764006466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpVZkb6IlszUoxEr+HJV1H+udwymGsBBYKy+5AMIQR0=;
        b=ZhHUSIrBwIXxTzRnKKWdy/kywFIihVUZ+4VeG+LfDojQs5idTCWkLSuS1Pe31Q/D5s
         8ynDjdnIeTYOalJF+F0uO6AX2NiB6GYalYBcWN10cwjFU4Vy4OWjElwAimnFND5RgzQZ
         B+n6XCYKzFmKHS7r2x7uN7nBqgRaaR/la8xRXF1Mtj1N+gp1kvrLDWaTY6BY5EO3/xK8
         qjk9Ol6s/1t8m8nYqPbDJPXRRZLeMO9fxZ+jjpE1neChMYTP+X/lkt76OWFh2qQlkAFz
         PcDUUsBVSVtUiMeVetNQ2pqhAXQ5VuL59ozLdveC1kqkkfkmC0InSG5w7vlMFsMg25ic
         q1rw==
X-Forwarded-Encrypted: i=1; AJvYcCUYfczRF4RURDxzappV6n6+NxinV3mu80Lm8pdoLQ4MKHr0rookfsXsAqO1WcZsNScWbIg+C6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvAwAMXKWgQBTjXkuja+YMra0bP6jdZvyCzMfcAtigRz2YIkBh
	Om+0GYG2E7ujznsPbGkMp+jQ3iIta5+4XTGF2eFvLzO6OzqXZ/sUNIfqi0PjCQs1/f55oQDpPp6
	k3rrnFw==
X-Google-Smtp-Source: AGHT+IFqnsuWDdAlLo2J0ShpUxM5phkhSniWkYC9mIWwDs6XyFfXH1SlwduGuXXJ0ZilXu9yajgSlZEYUpY=
X-Received: from plnt5.prod.google.com ([2002:a17:903:1965:b0:295:45fa:234])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70c:b0:298:3e3a:ae6
 with SMTP id d9443c01a7336-2986a7420f6mr152850355ad.48.1763401666076; Mon, 17
 Nov 2025 09:47:46 -0800 (PST)
Date: Mon, 17 Nov 2025 17:47:11 +0000
In-Reply-To: <20251117174740.3684604-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117174740.3684604-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117174740.3684604-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] selftest: af_unix: Add test for SO_PEEK_OFF.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Aaron Conole <aconole@bytheb.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test covers various cases to verify SO_PEEK_OFF behaviour
for all AF_UNIX socket types.

two_chunks_blocking and two_chunks_overlap_blocking reproduce
the issue mentioned in the previous patch.

Without the patch, the two tests fail:

  #  RUN           so_peek_off.stream.two_chunks_blocking ...
  # so_peek_off.c:121:two_chunks_blocking:Expected 'bbbb' == 'aaaabbbb'.
  # two_chunks_blocking: Test terminated by assertion
  #          FAIL  so_peek_off.stream.two_chunks_blocking
  not ok 3 so_peek_off.stream.two_chunks_blocking

  #  RUN           so_peek_off.stream.two_chunks_overlap_blocking ...
  # so_peek_off.c:159:two_chunks_overlap_blocking:Expected 'bbbb' == 'aaaabbbb'.
  # two_chunks_overlap_blocking: Test terminated by assertion
  #          FAIL  so_peek_off.stream.two_chunks_overlap_blocking
  not ok 5 so_peek_off.stream.two_chunks_overlap_blocking

With the patch, all tests pass:

  # PASSED: 15 / 15 tests passed.
  # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/so_peek_off.c       | 162 ++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/so_peek_off.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 439101b518ee..8f9850a71f54 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -45,6 +45,7 @@ skf_net_off
 socket
 so_incoming_cpu
 so_netns_cookie
+so_peek_off
 so_txtime
 so_rcv_listener
 stress_reuseport_listen
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index de805cbbdf69..528d14c598bb 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -6,6 +6,7 @@ TEST_GEN_PROGS := \
 	scm_inq \
 	scm_pidfd \
 	scm_rights \
+	so_peek_off \
 	unix_connect \
 # end of TEST_GEN_PROGS
 
diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/testing/selftests/net/af_unix/so_peek_off.c
new file mode 100644
index 000000000000..1a77728128e5
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 Google LLC */
+
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+
+#include "../../kselftest_harness.h"
+
+FIXTURE(so_peek_off)
+{
+	int fd[2];	/* 0: sender, 1: receiver */
+};
+
+FIXTURE_VARIANT(so_peek_off)
+{
+	int type;
+};
+
+FIXTURE_VARIANT_ADD(so_peek_off, stream)
+{
+	.type = SOCK_STREAM,
+};
+
+FIXTURE_VARIANT_ADD(so_peek_off, dgram)
+{
+	.type = SOCK_DGRAM,
+};
+
+FIXTURE_VARIANT_ADD(so_peek_off, seqpacket)
+{
+	.type = SOCK_SEQPACKET,
+};
+
+FIXTURE_SETUP(so_peek_off)
+{
+	struct timeval timeout = {
+		.tv_sec = 0,
+		.tv_usec = 3000,
+	};
+	int ret;
+
+	ret = socketpair(AF_UNIX, variant->type, 0, self->fd);
+	ASSERT_EQ(0, ret);
+
+	ret = setsockopt(self->fd[1], SOL_SOCKET, SO_RCVTIMEO_NEW,
+			 &timeout, sizeof(timeout));
+	ASSERT_EQ(0, ret);
+
+	ret = setsockopt(self->fd[1], SOL_SOCKET, SO_PEEK_OFF,
+			 &(int){0}, sizeof(int));
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_TEARDOWN(so_peek_off)
+{
+	close_range(self->fd[0], self->fd[1], 0);
+}
+
+#define sendeq(fd, str, flags)					\
+	do {							\
+		int bytes, len = strlen(str);			\
+								\
+		bytes = send(fd, str, len, flags);		\
+		ASSERT_EQ(len, bytes);				\
+	} while (0)
+
+#define recveq(fd, str, buflen, flags)				\
+	do {							\
+		char buf[(buflen) + 1] = {};			\
+		int bytes;					\
+								\
+		bytes = recv(fd, buf, buflen, flags);		\
+		ASSERT_NE(-1, bytes);				\
+		ASSERT_STREQ(str, buf);				\
+	} while (0)
+
+#define async							\
+	for (pid_t pid = (pid = fork(),				\
+			  pid < 0 ?				\
+			  __TH_LOG("Failed to start async {}"),	\
+			  _metadata->exit_code = KSFT_FAIL,	\
+			  __bail(1, _metadata),			\
+			  0xdead :				\
+			  pid);					\
+	     !pid; exit(0))
+
+TEST_F(so_peek_off, single_chunk)
+{
+	sendeq(self->fd[0], "aaaabbbb", 0);
+
+	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
+	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+}
+
+TEST_F(so_peek_off, two_chunks)
+{
+	sendeq(self->fd[0], "aaaa", 0);
+	sendeq(self->fd[0], "bbbb", 0);
+
+	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
+	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+}
+
+TEST_F(so_peek_off, two_chunks_blocking)
+{
+	async {
+		usleep(1000);
+		sendeq(self->fd[0], "aaaa", 0);
+	}
+
+	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
+
+	async {
+		usleep(1000);
+		sendeq(self->fd[0], "bbbb", 0);
+	}
+
+	/* goto again; -> goto redo; in unix_stream_read_generic(). */
+	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+}
+
+TEST_F(so_peek_off, two_chunks_overlap)
+{
+	sendeq(self->fd[0], "aaaa", 0);
+	recveq(self->fd[1], "aa", 2, MSG_PEEK);
+
+	sendeq(self->fd[0], "bbbb", 0);
+
+	if (variant->type == SOCK_STREAM) {
+		/* SOCK_STREAM tries to fill the buffer. */
+		recveq(self->fd[1], "aabb", 4, MSG_PEEK);
+		recveq(self->fd[1], "bb", 100, MSG_PEEK);
+	} else {
+		/* SOCK_DGRAM and SOCK_SEQPACKET returns at the skb boundary. */
+		recveq(self->fd[1], "aa", 100, MSG_PEEK);
+		recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+	}
+}
+
+TEST_F(so_peek_off, two_chunks_overlap_blocking)
+{
+	async {
+		usleep(1000);
+		sendeq(self->fd[0], "aaaa", 0);
+	}
+
+	recveq(self->fd[1], "aa", 2, MSG_PEEK);
+
+	async {
+		usleep(1000);
+		sendeq(self->fd[0], "bbbb", 0);
+	}
+
+	/* Even SOCK_STREAM does not wait if at least one byte is read. */
+	recveq(self->fd[1], "aa", 100, MSG_PEEK);
+
+	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
+}
+
+TEST_HARNESS_MAIN
-- 
2.52.0.rc1.455.g30608eb744-goog


