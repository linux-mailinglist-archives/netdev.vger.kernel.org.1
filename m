Return-Path: <netdev+bounces-198799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B39ADDDD7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDA017DA06
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D202F0C4E;
	Tue, 17 Jun 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ef2kJDqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136512EBBBA
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195273; cv=none; b=Z290tNMwtzzL8QrXwLMQZB1ieKRiVbvPB3dQZMajr983A0mjcQzoMSD3CACfg3I6JZzAztCscVx5xg3bhWbmuC1PEaTRZuvybhCb0wbB73ISDIleF/FdRTAyLhvPgtZ7hVUBOtAcLj7vEEgGyOJc3aVjLY33x9Ds1hltOxEKnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195273; c=relaxed/simple;
	bh=GUHcWBv3v6WOfLMVNou9LijYypkXBouBKN+DfHXaI3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzykMrz1UEDu6dojoJd687IET9ZEa/fQo0Zba3dL+gyrUwab6rIZ2Eidl+NIlX2c1coNeUUCvJf5JQ2Ttv+C2gqhSUJE0KXjR64ixRGOuRfLTWxcQUYVh8a1zRruZyP/Hn6mXBy340HnWNjExnLUWM0miunN1ghcTjpho4zonIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ef2kJDqD; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b170c99aa49so4263299a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750195271; x=1750800071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbIbknM3WMvrCMCQc65HhIO1Itulu6nDy9KVhZ3RXwE=;
        b=ef2kJDqD+vzVmktfeGylaM7r6AQdm8tJqmfbPbtXuMqCzTaw+CQSJS0lAk2Ea+lbXg
         9l+L6tvyjsh4LxwNjOqfNkjCs7zyEqQIidkMo8/EqqdDgG8/3uZ0Uh1yqBHu0zDhG+SI
         wycWG5Rd4RGtj9bg3jnJtdPptBpqMXgvufpDZkRNh/zToYzAAXxYvwy7/cvCv+aV70C7
         ysvftwCw0RCtqM/2vLFUNUwxJfFev/0vGAP1LmFG27chpdIKeKaWgiKAw58DhuWqpye8
         32F5oJ/aLvNs/jrs5dw4vged72PqkckaPfquJK5xA8lSogcP4KSUnK9yTvU90v7dzAFc
         5xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195271; x=1750800071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbIbknM3WMvrCMCQc65HhIO1Itulu6nDy9KVhZ3RXwE=;
        b=GE0OWKUS9YVRZicVUKlItRF5XgCUszW5E720si+X+3NJFMjXzo1Dqk+hIetuYN6mIr
         39XjKXEJc8o/ybhkfFxQBkztpcAYUJaLUnD6i5CfpbENXf3yKjPySfvUrSx6TNHjfd9x
         XSLrDhW8f6ISt4n6LfxhbBliQi6/myIcZUTtzef7tnSehifxtMnS2d1jduKvHfrWxzG1
         gV3uMkeKFm//LGmDHKTTWPLlEyUPv6DvdVA4yRYVMR6ocpvi/dqCcsAlO+mtRjUZ9D1r
         wrFXPgt3pmOdqEyxmOy4/1dNSXYSxLHIrioYPf6i5/EKhlMEM1HD0CKvRGtq4BfdH98B
         XFiQ==
X-Gm-Message-State: AOJu0Yw1auu9wyJxs7q9hbB2DV45Pffq6vvBR3ODOoJykJ+LzqvfxpHB
	8XNCNOS70OpypBBUkaabz+N1P6/qYXgT0LEfTitnWFLYbSmwSFvl4mLqY7rsQpHbsLnYrbwnf8H
	NeE3v
X-Gm-Gg: ASbGncuUo1VZkY9wv5gzQB/sZtrgSqoMBchB8fhTPak0coV3PZRPy2TnY8j2jD22f+V
	YgINPHsB/BHRgOtAFqt8C+QlVWRPWtKdiACR3Egp0kmwsRFnSTIDCDaZy6Uh6nfkWMsgjDYcdSA
	zXsaF5Y9iflKhnOmDfNb/rA/451i3Psmr34XrbFZdefcjmw6rn9uLwC4Xcs1my/fUIXRudYaUmI
	BV+l/7SL1gcXU+aiZhKwr2UxzVbPeams2s7VQo/VSaJIc7FS2GrfrzOAhsPvitznRTHN9R+qeHY
	HDvOu1Ohf520OUEf7DAPeyh4Jbtj+VMXzflSqWARxqkdNgZA
X-Google-Smtp-Source: AGHT+IGsyGVRj2QmnJaR0Cc+Y3wn8CQl8JG9YaHsrPuxI++GbDCjj+7oZmuDLPvgFQXNvKwNaJxEgQ==
X-Received: by 2002:a17:90b:55cd:b0:312:639:a06a with SMTP id 98e67ed59e1d1-313f1d0aa4emr21614954a91.31.1750195271248;
        Tue, 17 Jun 2025 14:21:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782b2sm85586535ad.111.2025.06.17.14.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:21:10 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v2 2/4] selftests: net: add passive TFO test binary
Date: Tue, 17 Jun 2025 14:21:00 -0700
Message-ID: <20250617212102.175711-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617212102.175711-1-dw@davidwei.uk>
References: <20250617212102.175711-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple passive TFO server and client test binary. This will be
used to test the SO_INCOMING_NAPI_ID of passive TFO accepted sockets.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   1 +
 tools/testing/selftests/net/tfo.c      | 171 +++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 tools/testing/selftests/net/tfo.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 532bb732bc6d..c6dd2a335cf4 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -50,6 +50,7 @@ tap
 tcp_fastopen_backup_key
 tcp_inq
 tcp_mmap
+tfo
 timestamping
 tls
 toeplitz
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index ab996bd22a5f..ab8da438fd78 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -110,6 +110,7 @@ TEST_GEN_PROGS += proc_net_pktgen
 TEST_PROGS += lwt_dst_cache_ref_loop.sh
 TEST_PROGS += skf_net_off.sh
 TEST_GEN_FILES += skf_net_off
+TEST_GEN_FILES += tfo
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
new file mode 100644
index 000000000000..eb3cac5e583c
--- /dev/null
+++ b/tools/testing/selftests/net/tfo.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <sys/socket.h>
+#include <netinet/tcp.h>
+#include <errno.h>
+
+static int cfg_server;
+static int cfg_client;
+static int cfg_port = 8000;
+static struct sockaddr_in6 cfg_addr;
+static char *cfg_outfile;
+
+static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
+{
+	int ret;
+
+	sin6->sin6_family = AF_INET6;
+	sin6->sin6_port = htons(port);
+
+	ret = inet_pton(sin6->sin6_family, str, &sin6->sin6_addr);
+	if (ret != 1) {
+		/* fallback to plain IPv4 */
+		ret = inet_pton(AF_INET, str, &sin6->sin6_addr.s6_addr32[3]);
+		if (ret != 1)
+			return -1;
+
+		/* add ::ffff prefix */
+		sin6->sin6_addr.s6_addr32[0] = 0;
+		sin6->sin6_addr.s6_addr32[1] = 0;
+		sin6->sin6_addr.s6_addr16[4] = 0;
+		sin6->sin6_addr.s6_addr16[5] = 0xffff;
+	}
+
+	return 0;
+}
+
+static void run_server(void)
+{
+	unsigned long qlen = 32;
+	int fd, opt, connfd;
+	socklen_t len;
+	char buf[64];
+	FILE *outfile;
+
+	outfile = fopen(cfg_outfile, "w");
+	if (!outfile)
+		error(1, errno, "fopen() outfile");
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd == -1)
+		error(1, errno, "socket()");
+
+	opt = 1;
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0)
+		error(1, errno, "setsockopt(SO_REUSEADDR)");
+
+	if (setsockopt(fd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) < 0)
+		error(1, errno, "setsockopt(TCP_FASTOPEN)");
+
+	if (bind(fd, (struct sockaddr *)&cfg_addr, sizeof(cfg_addr)) < 0)
+		error(1, errno, "bind()");
+
+	if (listen(fd, 5) < 0)
+		error(1, errno, "listen()");
+
+	len = sizeof(cfg_addr);
+	connfd = accept(fd, (struct sockaddr *)&cfg_addr, &len);
+	if (connfd < 0)
+		error(1, errno, "accept()");
+
+	len = sizeof(opt);
+	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
+		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
+
+	read(connfd, buf, 64);
+	fprintf(outfile, "%d\n", opt);
+
+	fclose(outfile);
+	close(connfd);
+	close(fd);
+}
+
+static void run_client(void)
+{
+	int fd;
+	char *msg = "Hello, world!";
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd == -1)
+		error(1, errno, "socket()");
+
+	sendto(fd, msg, strlen(msg), MSG_FASTOPEN, (struct sockaddr *)&cfg_addr, sizeof(cfg_addr));
+
+	close(fd);
+}
+
+static void usage(const char *filepath)
+{
+	error(1, 0, "Usage: %s (-s|-c) -h<server_ip> -p<port> -o<outfile> ", filepath);
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	struct sockaddr_in6 *addr6 = (void *) &cfg_addr;
+	char *addr = NULL;
+	int ret;
+	int c;
+
+	if (argc <= 1)
+		usage(argv[0]);
+
+	while ((c = getopt(argc, argv, "sch:p:o:")) != -1) {
+		switch (c) {
+		case 's':
+			if (cfg_client)
+				error(1, 0, "Pass one of -s or -c");
+			cfg_server = 1;
+			break;
+		case 'c':
+			if (cfg_server)
+				error(1, 0, "Pass one of -s or -c");
+			cfg_client = 1;
+			break;
+		case 'h':
+			addr = optarg;
+			break;
+		case 'p':
+			cfg_port = strtoul(optarg, NULL, 0);
+			break;
+		case 'o':
+			cfg_outfile = strdup(optarg);
+			if (!cfg_outfile)
+				error(1, 0, "outfile invalid");
+			break;
+		}
+	}
+
+	if (cfg_server && addr)
+		error(1, 0, "Server cannot have -h specified");
+
+	memset(addr6, 0, sizeof(*addr6));
+	addr6->sin6_family = AF_INET6;
+	addr6->sin6_port = htons(cfg_port);
+	addr6->sin6_addr = in6addr_any;
+	if (addr) {
+		ret = parse_address(addr, cfg_port, addr6);
+		if (ret)
+			error(1, 0, "Client address parse error: %s", addr);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	parse_opts(argc, argv);
+
+	if (cfg_server)
+		run_server();
+	else if (cfg_client)
+		run_client();
+
+	return 0;
+}
-- 
2.47.1


