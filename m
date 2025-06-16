Return-Path: <netdev+bounces-198200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A0ADB926
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC9174054
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96E289E10;
	Mon, 16 Jun 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Q6ZHB7iG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3916289E2E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100103; cv=none; b=emHZUsxcWeSv0yoYkVSlRoqbQandtiivcRGH4Tq9Q0dx2ZKLfQ+PhDFrjhhUEkB7PxIspBlF8DFR+jm9AVSqPAAwtKLjdVwjLW37jzwJPpx5YLLNweR2HC+EWnLdphFww5UKMC4xWsYz2L9yeuT+3SWA8w8h3tJpezyIOGi7nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100103; c=relaxed/simple;
	bh=GUHcWBv3v6WOfLMVNou9LijYypkXBouBKN+DfHXaI3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoPOTRm1IXwcEYef25KuWuYRCTnCjk0SMo7uBvR3XKqziWCKVCApAmfZNYLZ287WVySgkoet0BiC1Iw/J7DWx2FT4O+EQDF78Ci4+uaFBEHXU7RwIFfEQettiiOd2+72dwlu60hn1pAJy4NbsqiNg4voKwva2Q5+UqurSI8m3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Q6ZHB7iG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2360ff7ac1bso34183665ad.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750100101; x=1750704901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbIbknM3WMvrCMCQc65HhIO1Itulu6nDy9KVhZ3RXwE=;
        b=Q6ZHB7iG1iik0obO3yW6awRmP9gURd9h9t688jBYT4Trm/WhVhhc/NBDbusfWcroPk
         38xtegIKlcziFgUHo/wRnI6/qL1Bl8934nyrKQjrdz2xStadrfEovfG/YCciTmtEJVm3
         NnTYYvfaweto1cqAWGe1JGMXW0xzBJOVG+Cyc1eKHlqJi0shwRN2DPP8yMRy0xxqMrps
         L3ybPNIpqKzOBcs5yH1sq3yr0hp3lVpJMtBj2zgZPv1ZnkSJxecZKu4p4b+HZaHCf5DU
         ahaJBP/sklpEaO9LxdbD/Bk8p/QWUj2aH8iJFXQZnyEP6+3XD9l88fh5aTnWDX/o6jS1
         kAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100101; x=1750704901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbIbknM3WMvrCMCQc65HhIO1Itulu6nDy9KVhZ3RXwE=;
        b=WYGZJZZ7911G4B6277yoIVzKuQRfJT8rl5qjjLjfGB/hA3eIwRpR1hYkpxvTT9z5fB
         Z5WhmuSpPk6y81zmxW+7P3PLLcY+aNuPO/37jACctxrwUgc2h2cbQkjY1/9IXzMrFFnz
         lNwL7tN9kJQCt0b8DMwkMCYTwpI2kyXdVyTg8Hb6nnIdds3BuW8otwpyaUBH3ypKD2dA
         ZurGr95mdZLYYP/d59/8Q68Z/IJFvD3EKTSSCHOp10dYlfgVRiJF/gchWQTiQZmdxV55
         xCWk4YPZQt+pLXQeKOV7fnHQqH0rFz50Vv2JD5QJ1HwEdFLFmRepyIIEStndlO4QVpt3
         cNsA==
X-Gm-Message-State: AOJu0YwXeMSRHfNqTxVxrREspwaR0i94XMajxxErLAapgFe16CQPHeDL
	ywVg5rC6CuT06AXa592Tc2gSIR20jETd4ygG4cqzuvboNJ8HZkjpE9M09oHQSD1dKWSabOOIcWx
	V405Y
X-Gm-Gg: ASbGnctEvwMBGRm2qFjXzdlC9aJnl9wMabmUlW2rhYW3XLIt0rI0eV+L8IInXnCBR7s
	tYpBdm5Kk9wLgFkgNzJbw8XQUO1ARkBsWFivGIKMrAPJxbk/go8wbZ/yGw/X58lSpd1Qk5i3pzS
	4rwlubRZoaniU5o+84Vdk6/5b5uO/IMFuBToedFgFmVUDKdw+0+YCcJ/bqn34O4DX171UGO3TfY
	459MRY0B7aYNzGVBBhVY0sKWztQRw5j5G8Iz7yaYnAUoppAqs9zYZ2nBP6e9TEzVB0uV4CCHDWg
	dckn2QTPOcS59SjzTadNsfINO5VQN1qRHAdjrEWeUGH+7qNDiKWZRz2cjA==
X-Google-Smtp-Source: AGHT+IGdtSakqEvEJMNRJx1hD7nGhGKpIz64bMtro0E6Hgn+XaGOa/cmYNfjNY3DdSMDPGhc+3JPKA==
X-Received: by 2002:a17:902:d2c9:b0:234:c8f6:1b03 with SMTP id d9443c01a7336-2366b16e795mr159117955ad.47.1750100100535;
        Mon, 16 Jun 2025 11:55:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea88d2sm64462165ad.148.2025.06.16.11.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:55:00 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v1 2/4] selftests: net: add passive TFO test binary
Date: Mon, 16 Jun 2025 11:54:54 -0700
Message-ID: <20250616185456.2644238-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616185456.2644238-1-dw@davidwei.uk>
References: <20250616185456.2644238-1-dw@davidwei.uk>
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


