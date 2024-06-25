Return-Path: <netdev+bounces-106316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAC915BC8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF15B1F21245
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0E18637;
	Tue, 25 Jun 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d5SYWbAZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36F101D5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279630; cv=none; b=BiRYO0LVZEq43K0X7bw9oZ9qeucBZo7fnPu6NVDQuMLXKloz5jogjpxgm0a6Q2qCFolbZZBApinWrPyxkV9YkG5hGvnfL1UaXgGlEMgWUsEhH7Tu6tXE1pr2tNCeai9kowBnvB8iQd5rujgGdqXM4VZ4cLe/nteJCFaakZuikq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279630; c=relaxed/simple;
	bh=KkftYp+8cc7n6g1ll5n6XH6CxWRS9lbo4MkZB7Y3dzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCMGJ87VJq8FnJxVxNa0rjnuuGEbOqdQpslATU3DiPIGenJV/tFMyMowwS1cMbsw+a3gpOYSwF52lO3+bLMSPF0CB/vq87JQ4xPZG6ld6ub+Kaye4hva2th1UTSQ0LVxamrCSnLA/9cson9wqevAsBJmTHAJ/2n8iGt9dNL6WU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d5SYWbAZ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279626; x=1750815626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znn7yY8aiy7lzpVhgW5NwaHXFBjR/r7tyGyMweo7MQs=;
  b=d5SYWbAZZ4zDNM6FvW0bssgbA2/NMU83qt25qBmkn17ZPdfrVKVZ/Ytw
   RrCrlCR1cL5cknBHimkyqfl4Gi+VF+uU2aA6LcJPqVGdFQ68Ud1O+iaEZ
   fltKROFWQMbI7rB+JmwxXZxgDmydrb/4ZUgXEAsGmmq9ytDA+fTPOVMO9
   s=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="735219639"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:40:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:5624]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.222:2525] with esmtp (Farcaster)
 id e132314e-572b-4c1d-a038-8fb9b1d2fc99; Tue, 25 Jun 2024 01:40:19 +0000 (UTC)
X-Farcaster-Flow-ID: e132314e-572b-4c1d-a038-8fb9b1d2fc99
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:40:19 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:40:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 08/11] selftest: af_unix: Check SIGURG after every send() in msg_oob.c
Date: Mon, 24 Jun 2024 18:36:42 -0700
Message-ID: <20240625013645.45034-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When data is sent with MSG_OOB, SIGURG is sent to a process if the
receiver socket has set its owner to the process by ioctl(FIOSETOWN)
or fcntl(F_SETOWN).

This patch adds SIGURG check after every send(MSG_OOB) call.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 62361b5e98c3..123dee0b6739 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -6,6 +6,8 @@
 #include <unistd.h>
 
 #include <netinet/in.h>
+#include <sys/ioctl.h>
+#include <sys/signalfd.h>
 #include <sys/socket.h>
 
 #include "../../kselftest_harness.h"
@@ -19,6 +21,7 @@ FIXTURE(msg_oob)
 				 * 2: TCP sender
 				 * 3: TCP receiver
 				 */
+	int signal_fd;
 	bool tcp_compliant;
 };
 
@@ -77,6 +80,35 @@ static void create_tcp_socketpair(struct __test_metadata *_metadata,
 	ASSERT_EQ(ret, 0);
 }
 
+static void setup_sigurg(struct __test_metadata *_metadata,
+			 FIXTURE_DATA(msg_oob) *self)
+{
+	struct signalfd_siginfo siginfo;
+	int pid = getpid();
+	sigset_t mask;
+	int i, ret;
+
+	for (i = 0; i < 2; i++) {
+		ret = ioctl(self->fd[i * 2 + 1], FIOSETOWN, &pid);
+		ASSERT_EQ(ret, 0);
+	}
+
+	ret = sigemptyset(&mask);
+	ASSERT_EQ(ret, 0);
+
+	ret = sigaddset(&mask, SIGURG);
+	ASSERT_EQ(ret, 0);
+
+	ret = sigprocmask(SIG_BLOCK, &mask, NULL);
+	ASSERT_EQ(ret, 0);
+
+	self->signal_fd = signalfd(-1, &mask, SFD_NONBLOCK);
+	ASSERT_GE(self->signal_fd, 0);
+
+	ret = read(self->signal_fd, &siginfo, sizeof(siginfo));
+	ASSERT_EQ(ret, -1);
+}
+
 static void close_sockets(FIXTURE_DATA(msg_oob) *self)
 {
 	int i;
@@ -90,6 +122,8 @@ FIXTURE_SETUP(msg_oob)
 	create_unix_socketpair(_metadata, self);
 	create_tcp_socketpair(_metadata, self);
 
+	setup_sigurg(_metadata, self);
+
 	self->tcp_compliant = true;
 }
 
@@ -104,9 +138,24 @@ static void __sendpair(struct __test_metadata *_metadata,
 {
 	int i, ret[2];
 
-	for (i = 0; i < 2; i++)
+	for (i = 0; i < 2; i++) {
+		struct signalfd_siginfo siginfo = {};
+		int bytes;
+
 		ret[i] = send(self->fd[i * 2], buf, len, flags);
 
+		bytes = read(self->signal_fd, &siginfo, sizeof(siginfo));
+
+		if (flags & MSG_OOB) {
+			ASSERT_EQ(bytes, sizeof(siginfo));
+			ASSERT_EQ(siginfo.ssi_signo, SIGURG);
+
+			bytes = read(self->signal_fd, &siginfo, sizeof(siginfo));
+		}
+
+		ASSERT_EQ(bytes, -1);
+	}
+
 	ASSERT_EQ(ret[0], len);
 	ASSERT_EQ(ret[0], ret[1]);
 }
-- 
2.30.2


