Return-Path: <netdev+bounces-226532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD33BA17F9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494BE3AD604
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07A322766;
	Thu, 25 Sep 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNt4Ny/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813D321F46
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835016; cv=none; b=R4uheYAaNb/qYxKQUKjcZBBAEAMxGaw+y1JXnfQvZIesso354OBZSGfDmyWi5WSYSWEEA3lpVO+1WOdCzxW+zTSHef8G46qlrT7lxJ6ZVr/KoiEvkX40vBWeV1cWSi6pA3jqXAUPXNfiSuNgLO4Fndb7MfzDPWDq707UUsy7EEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835016; c=relaxed/simple;
	bh=5hdBoX/gAdgJ4AQ0Q7zTcABidx3y2p7pFV6RYQ6YBAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVGyLkmsMfeoxdc5C8ySV1o6ERpPanPTwcz4K+nrMWZfln59BmEZ8UctBiVa5XyWqiRUL+mWJZkfGNSUP/L0V/5bd0HC4OGW3SEUOECH0WOXemVsgzMIih9WsAvpTtZykijGCMFPG5nG142QRPT3Qn2r3hXq8XTmM5qE4pwWscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNt4Ny/V; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60110772so13248937b3.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835014; x=1759439814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7XHNfE8ohgHYsa0pWPadCxcSuEw1dDsvo7uU7bKKp4=;
        b=eNt4Ny/VDytWHIiskYw6bN/4+C2rAyPoeTHoVEVLHMHSXgtpRVSCe0/bhvxQFwdLI0
         lwBc8AM9bB5Tv+VKqCR8X3LIGP7FUPrVVkbbvMsrM9MUeJLGceqAbv1dmiLAfEF+m7qu
         sYsTKrMg8HZW4IQGU7pe0bVAfJGNFi7dqxTVSANKwY+u9Ka1MpPK+vWJUFzIKfHvN77k
         6AT4hJsONFjWTWc5eOTBWqzNffxK5MzYnVrNMOcIz3iYZOvVhxs+gnYwWfz/AVTghfah
         cYZR2OTgczrzUK7DAnklnRqqDAIL3YNubNv4vUSvXHCsGHKZZHHgKnQl00F5VM7ooPdZ
         O3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835014; x=1759439814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7XHNfE8ohgHYsa0pWPadCxcSuEw1dDsvo7uU7bKKp4=;
        b=DAV482jfL8aNdPRdSY6FQU85bkozLXuyZUn9xtPK0pzVK5KdFkiVc34VggDAv5taRz
         uAp7fjloLFIpD+EAqr+7S9Wmt1yPLjLXMXo9/gCmMPq8xMQOCJK2dlRAtA1xftXwvJpQ
         ORvYCI1TblJoznSyf781ndf7Y3KxRmrPKRbOhOCWsd3M5bxCRKC+pd1ihY+40Lwq/RlD
         Sy/5HEt21iX9i387mB/Aoa1IX+OhJmK5bcNVlF6vACjnG8S6yB8lkqI7556vzz4jlJZj
         Xv+2MbSRrALvIO/wRKHthRvLOuQ07A4hPaYPEY0ibvUE2zdE/aCr5JE+p93r0q9Hg/Sr
         mjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW21HmgIPBtuE1nBHeUrZXLTrr61l4AuYl1KsvhXcMLyUikL9lxXKrriE4dsnJM/zp+Y9MFrBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFHaQo4qn0J3hhrrVgM/Fis3BiuxMBbvkdW872fUa4qh+LLRk
	cj7Q+hncICTjY6Nu+3Ars7w5vp5LSRcA2SE09aVF29Ln8JgUDXcYMYkO
X-Gm-Gg: ASbGncvFC/7A0dTxFHS0tD33oXAmvu5ucdgPa+2pi3DmSAAwmf5Tb0U+zLw5bNDPxWC
	lK9UtWTRwLNkHciulW9ecivwPq+SYxS9Nq4T5lXtaSfX2o0w4WaT06UbVOw6XiedUawth35cc3Z
	zi0vtCVs66buPEQfsR6vXAy71Rps9lJVT6r/QpoVDQAaXKh8YUJczugkop1DO7YE0qivMwFfYa5
	bvv3wwvBO/IX0clGkD0OGu5X8ApmKsNSQlCBcYVdngtOGRl9PmvnasAVHZhBu1ETiE0qVrfAjPn
	mRSAR+FJ4CCyuc+V1Yj64EaQaq9RWqRrgrV1NzgufBW4n5w6dn+Nw6eOJ0+kKFeo1mehD0mibbS
	nXC55DCQXU5ljue550rER
X-Google-Smtp-Source: AGHT+IFewdJCZiYS4EIvoDB0JFklDog7csH+JqaeHC1iXJjiS4vzbek83HliRJFpY1rFetsHR1ZqBw==
X-Received: by 2002:a05:690c:9416:20b0:748:74b9:467a with SMTP id 00721157ae682-76403423b48mr40110577b3.32.1758835013558;
        Thu, 25 Sep 2025 14:16:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765be76d954sm7327087b3.33.2025.09.25.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:52 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 3/8] selftests: drv-net: add PSP responder
Date: Thu, 25 Sep 2025 14:16:39 -0700
Message-ID: <20250925211647.3450332-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925211647.3450332-1-daniel.zahka@gmail.com>
References: <20250925211647.3450332-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

PSP tests need the remote system to support PSP, and some PSP capable
application to exchange data with. Create a simple PSP responder app
which we can build and deploy to the remote host. The tests themselves
can be written in Python but for ease of deploying the responder is in C
(using C YNL).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   9 +
 .../selftests/drivers/net/psp_responder.c     | 483 ++++++++++++++++++
 3 files changed, 493 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/psp_responder.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index d634d8395d90..585ecb4d5dc4 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 napi_id_helper
+psp_responder
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 102cfb36846c..bd3af9a34e2f 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -27,4 +27,13 @@ TEST_PROGS := \
 	xdp.py \
 # end of TEST_PROGS
 
+# YNL files, must be before "include ..lib.mk"
+YNL_GEN_FILES := psp_responder
+TEST_GEN_FILES += $(YNL_GEN_FILES)
+
 include ../../lib.mk
+
+# YNL build
+YNL_GENS := psp
+
+include ../../net/ynl.mk
diff --git a/tools/testing/selftests/drivers/net/psp_responder.c b/tools/testing/selftests/drivers/net/psp_responder.c
new file mode 100644
index 000000000000..f309e0d73cbf
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/psp_responder.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
+#include <sys/poll.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <netinet/in.h>
+#include <unistd.h>
+
+#include <ynl.h>
+
+#include "psp-user.h"
+
+#define dbg(msg...)				\
+do {						\
+	if (opts->verbose)			\
+		fprintf(stderr, "DEBUG: " msg);	\
+} while (0)
+
+static bool should_quit;
+
+struct opts {
+	int port;
+	int devid;
+	bool verbose;
+};
+
+enum accept_cfg {
+	ACCEPT_CFG_NONE = 0,
+	ACCEPT_CFG_CLEAR,
+	ACCEPT_CFG_PSP,
+};
+
+static struct {
+	unsigned char tx;
+	unsigned char rx;
+} psp_vers;
+
+static int conn_setup_psp(struct ynl_sock *ys, struct opts *opts, int data_sock)
+{
+	struct psp_rx_assoc_rsp *rsp;
+	struct psp_rx_assoc_req *req;
+	struct psp_tx_assoc_rsp *tsp;
+	struct psp_tx_assoc_req *teq;
+	char info[300];
+	int key_len;
+	ssize_t sz;
+	__u32 spi;
+
+	dbg("create PSP connection\n");
+
+	// Rx assoc alloc
+	req = psp_rx_assoc_req_alloc();
+
+	psp_rx_assoc_req_set_sock_fd(req, data_sock);
+	psp_rx_assoc_req_set_version(req, psp_vers.rx);
+
+	rsp = psp_rx_assoc(ys, req);
+	psp_rx_assoc_req_free(req);
+
+	if (!rsp) {
+		perror("ERROR: failed to Rx assoc");
+		return -1;
+	}
+
+	// SPI exchange
+	key_len = rsp->rx_key._len.key;
+	memcpy(info, &rsp->rx_key.spi, sizeof(spi));
+	memcpy(&info[sizeof(spi)], rsp->rx_key.key, key_len);
+	sz = sizeof(spi) + key_len;
+
+	send(data_sock, info, sz, MSG_WAITALL);
+	psp_rx_assoc_rsp_free(rsp);
+
+	sz = recv(data_sock, info, sz, MSG_WAITALL);
+	if (sz < 0) {
+		perror("ERROR: failed to read PSP key from sock");
+		return -1;
+	}
+	memcpy(&spi, info, sizeof(spi));
+
+	// Setup Tx assoc
+	teq = psp_tx_assoc_req_alloc();
+
+	psp_tx_assoc_req_set_sock_fd(teq, data_sock);
+	psp_tx_assoc_req_set_version(teq, psp_vers.tx);
+	psp_tx_assoc_req_set_tx_key_spi(teq, spi);
+	psp_tx_assoc_req_set_tx_key_key(teq, &info[sizeof(spi)], key_len);
+
+	tsp = psp_tx_assoc(ys, teq);
+	psp_tx_assoc_req_free(teq);
+	if (!tsp) {
+		perror("ERROR: failed to Tx assoc");
+		return -1;
+	}
+	psp_tx_assoc_rsp_free(tsp);
+
+	return 0;
+}
+
+static void send_ack(int sock)
+{
+	send(sock, "ack", 4, MSG_WAITALL);
+}
+
+static void send_err(int sock)
+{
+	send(sock, "err", 4, MSG_WAITALL);
+}
+
+static void send_str(int sock, int value)
+{
+	char buf[128];
+	int ret;
+
+	ret = snprintf(buf, sizeof(buf), "%d", value);
+	send(sock, buf, ret + 1, MSG_WAITALL);
+}
+
+static void
+run_session(struct ynl_sock *ys, struct opts *opts,
+	    int server_sock, int comm_sock)
+{
+	enum accept_cfg accept_cfg = ACCEPT_CFG_NONE;
+	struct pollfd pfds[3];
+	size_t data_read = 0;
+	int data_sock = -1;
+
+	while (true) {
+		bool race_close = false;
+		int nfds;
+
+		memset(pfds, 0, sizeof(pfds));
+
+		pfds[0].fd = server_sock;
+		pfds[0].events = POLLIN;
+
+		pfds[1].fd = comm_sock;
+		pfds[1].events = POLLIN;
+
+		nfds = 2;
+		if (data_sock >= 0) {
+			pfds[2].fd = data_sock;
+			pfds[2].events = POLLIN;
+			nfds++;
+		}
+
+		dbg(" ...\n");
+		if (poll(pfds, nfds, -1) < 0) {
+			perror("poll");
+			break;
+		}
+
+		/* data sock */
+		if (pfds[2].revents & POLLIN) {
+			char buf[8192];
+			ssize_t n;
+
+			n = recv(data_sock, buf, sizeof(buf), 0);
+			if (n <= 0) {
+				if (n < 0)
+					perror("data read");
+				close(data_sock);
+				data_sock = -1;
+				dbg("data sock closed\n");
+			} else {
+				data_read += n;
+				dbg("data read %zd\n", data_read);
+			}
+		}
+
+		/* comm sock */
+		if (pfds[1].revents & POLLIN) {
+			static char buf[4096];
+			static ssize_t off;
+			bool consumed;
+			ssize_t n;
+
+			n = recv(comm_sock, &buf[off], sizeof(buf) - off, 0);
+			if (n <= 0) {
+				if (n < 0)
+					perror("comm read");
+				return;
+			}
+
+			off += n;
+			n = off;
+
+#define __consume(sz)						\
+		({						\
+			if (n == (sz)) {			\
+				off = 0;			\
+			} else {				\
+				off -= (sz);			\
+				memmove(buf, &buf[(sz)], off);	\
+			}					\
+		})
+
+#define cmd(_name)							\
+		({							\
+			ssize_t sz = sizeof(_name);			\
+			bool match = n >= sz &&	!memcmp(buf, _name, sz); \
+									\
+			if (match) {					\
+				dbg("command: " _name "\n");		\
+				__consume(sz);				\
+			}						\
+			consumed |= match;				\
+			match;						\
+		})
+
+			do {
+				consumed = false;
+
+				if (cmd("read len"))
+					send_str(comm_sock, data_read);
+
+				if (cmd("data echo")) {
+					if (data_sock >= 0)
+						send(data_sock, "echo", 5,
+						     MSG_WAITALL);
+					else
+						fprintf(stderr, "WARN: echo but no data sock\n");
+					send_ack(comm_sock);
+				}
+				if (cmd("data close")) {
+					if (data_sock >= 0) {
+						close(data_sock);
+						data_sock = -1;
+						send_ack(comm_sock);
+					} else {
+						race_close = true;
+					}
+				}
+				if (cmd("conn psp")) {
+					if (accept_cfg != ACCEPT_CFG_NONE)
+						fprintf(stderr, "WARN: old conn config still set!\n");
+					accept_cfg = ACCEPT_CFG_PSP;
+					send_ack(comm_sock);
+					/* next two bytes are versions */
+					if (off >= 2) {
+						memcpy(&psp_vers, buf, 2);
+						__consume(2);
+					} else {
+						fprintf(stderr, "WARN: short conn psp command!\n");
+					}
+				}
+				if (cmd("conn clr")) {
+					if (accept_cfg != ACCEPT_CFG_NONE)
+						fprintf(stderr, "WARN: old conn config still set!\n");
+					accept_cfg = ACCEPT_CFG_CLEAR;
+					send_ack(comm_sock);
+				}
+				if (cmd("exit"))
+					should_quit = true;
+#undef cmd
+
+				if (!consumed) {
+					fprintf(stderr, "WARN: unknown cmd: [%zd] %s\n",
+						off, buf);
+				}
+			} while (consumed && off);
+		}
+
+		/* server sock */
+		if (pfds[0].revents & POLLIN) {
+			if (data_sock >= 0) {
+				fprintf(stderr, "WARN: new data sock but old one still here\n");
+				close(data_sock);
+				data_sock = -1;
+			}
+			data_sock = accept(server_sock, NULL, NULL);
+			if (data_sock < 0) {
+				perror("accept");
+				continue;
+			}
+			data_read = 0;
+
+			if (accept_cfg == ACCEPT_CFG_CLEAR) {
+				dbg("new data sock: clear\n");
+				/* nothing to do */
+			} else if (accept_cfg == ACCEPT_CFG_PSP) {
+				dbg("new data sock: psp\n");
+				conn_setup_psp(ys, opts, data_sock);
+			} else {
+				fprintf(stderr, "WARN: new data sock but no config\n");
+			}
+			accept_cfg = ACCEPT_CFG_NONE;
+		}
+
+		if (race_close) {
+			if (data_sock >= 0) {
+				/* indeed, ordering problem, handle the close */
+				close(data_sock);
+				data_sock = -1;
+				send_ack(comm_sock);
+			} else {
+				fprintf(stderr, "WARN: close but no data sock\n");
+				send_err(comm_sock);
+			}
+		}
+	}
+	dbg("session ending\n");
+}
+
+static int spawn_server(struct opts *opts)
+{
+	struct sockaddr_in6 addr;
+	int fd;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("can't open socket");
+		return -1;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+
+	addr.sin6_family = AF_INET6;
+	addr.sin6_addr = in6addr_any;
+	addr.sin6_port = htons(opts->port);
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
+		perror("can't bind socket");
+		return -1;
+	}
+
+	if (listen(fd, 5)) {
+		perror("can't listen");
+		return -1;
+	}
+
+	return fd;
+}
+
+static int run_responder(struct ynl_sock *ys, struct opts *opts)
+{
+	int server_sock, comm;
+
+	server_sock = spawn_server(opts);
+	if (server_sock < 0)
+		return 4;
+
+	while (!should_quit) {
+		comm = accept(server_sock, NULL, NULL);
+		if (comm < 0) {
+			perror("accept failed");
+		} else {
+			run_session(ys, opts, server_sock, comm);
+			close(comm);
+		}
+	}
+
+	return 0;
+}
+
+static void usage(const char *name, const char *miss)
+{
+	if (miss)
+		fprintf(stderr, "Missing argument: %s\n", miss);
+
+	fprintf(stderr, "Usage: %s -p port [-v] [-d psp-dev-id]\n", name);
+	exit(EXIT_FAILURE);
+}
+
+static void parse_cmd_opts(int argc, char **argv, struct opts *opts)
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "vp:d:")) != -1) {
+		switch (opt) {
+		case 'v':
+			opts->verbose = 1;
+			break;
+		case 'p':
+			opts->port = atoi(optarg);
+			break;
+		case 'd':
+			opts->devid = atoi(optarg);
+			break;
+		default:
+			usage(argv[0], NULL);
+		}
+	}
+}
+
+static int psp_dev_set_ena(struct ynl_sock *ys, __u32 dev_id, __u32 versions)
+{
+	struct psp_dev_set_req *sreq;
+	struct psp_dev_set_rsp *srsp;
+
+	fprintf(stderr, "Set PSP enable on device %d to 0x%x\n",
+		dev_id, versions);
+
+	sreq = psp_dev_set_req_alloc();
+
+	psp_dev_set_req_set_id(sreq, dev_id);
+	psp_dev_set_req_set_psp_versions_ena(sreq, versions);
+
+	srsp = psp_dev_set(ys, sreq);
+	psp_dev_set_req_free(sreq);
+	if (!srsp)
+		return 10;
+
+	psp_dev_set_rsp_free(srsp);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	struct psp_dev_get_list *dev_list;
+	bool devid_found = false;
+	__u32 ver_ena, ver_cap;
+	struct opts opts = {};
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int first_id = 0;
+	int ret;
+
+	parse_cmd_opts(argc, argv, &opts);
+	if (!opts.port)
+		usage(argv[0], "port"); // exits
+
+	ys = ynl_sock_create(&ynl_psp_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 1;
+	}
+
+	dev_list = psp_dev_get_dump(ys);
+	if (ynl_dump_empty(dev_list)) {
+		if (ys->err.code)
+			goto err_close;
+		fprintf(stderr, "No PSP devices\n");
+		goto err_close_silent;
+	}
+
+	ynl_dump_foreach(dev_list, d) {
+		if (opts.devid) {
+			devid_found = true;
+			ver_ena = d->psp_versions_ena;
+			ver_cap = d->psp_versions_cap;
+		} else if (!first_id) {
+			first_id = d->id;
+			ver_ena = d->psp_versions_ena;
+			ver_cap = d->psp_versions_cap;
+		} else {
+			fprintf(stderr, "Multiple PSP devices found\n");
+			goto err_close_silent;
+		}
+	}
+	psp_dev_get_list_free(dev_list);
+
+	if (opts.devid && !devid_found) {
+		fprintf(stderr, "PSP device %d requested on cmdline, not found\n",
+			opts.devid);
+		goto err_close_silent;
+	} else if (!opts.devid) {
+		opts.devid = first_id;
+	}
+
+	if (ver_ena != ver_cap) {
+		ret = psp_dev_set_ena(ys, opts.devid, ver_cap);
+		if (ret)
+			goto err_close;
+	}
+
+	ret = run_responder(ys, &opts);
+
+	if (ver_ena != ver_cap && psp_dev_set_ena(ys, opts.devid, ver_ena))
+		fprintf(stderr, "WARN: failed to set the PSP versions back\n");
+
+	ynl_sock_destroy(ys);
+
+	return ret;
+
+err_close:
+	fprintf(stderr, "YNL: %s\n", ys->err.msg);
+err_close_silent:
+	ynl_sock_destroy(ys);
+	return 2;
+}
-- 
2.47.3


