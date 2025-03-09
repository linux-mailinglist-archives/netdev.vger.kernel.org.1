Return-Path: <netdev+bounces-173280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F0A5844D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3BE3ACA54
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FA1DEFEA;
	Sun,  9 Mar 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I+PCb9od"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C099D1D47A2
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527006; cv=none; b=k2QpN5IIwbZtFbvQazJ+pe3GfYuZeXuDLU9j1cRVAgjbxmjCLr25khhwA7AWGv7XXRUvtZzreTVk5WN56vNxnxfq86ZZg9BNfoS6Nc+q8bmK6dOIzRvLtRBmZig5bzFHJDypdFUEjnokicnv7m7IaJMVlrr3H9BOFHu6plILP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527006; c=relaxed/simple;
	bh=fnMK/Ta7Z6dW4Bo0ev4kpeSTLsBbk/uNRa2jnNMBxsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4LO1c73iDYV7qaP9IV164vDzBl1cBDWtA7VEHO09a6XLX/7v6T3h9JuOwGIwreIwufwFoanjxp1nnZT/MgKN7gut9i8quQZgiuNq5LcxKz3p4x/sCr2ZcLY1wU4mIztbyOPDic9ms/DiVgBvd7Hy48E+I7pX4hM67aKAX6JTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I+PCb9od; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C858540633
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526992;
	bh=+WlniEeO1sxFM6/UgRu+OkcVvl4eFAZ3k4+mcLNjIi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=I+PCb9odWRj1VVSNBgqjzo5YJwiWPv4XZeHx3tD5mwDPNqeM9ZkYRkuV72468sQgj
	 K26qr59aYIbjr5SEuz9fO5al4sCjMtLv1EtJJVghoPVmQ/MAtid+mfpZSOZlP88T9y
	 ce3DlmRe4GG2tl2K8sR4A4w3VvYsnfyHyuNFgG4by7l/eI+aDEPSmDhKUvtCzo2AAb
	 iPRBPBrYoD8O2CM7fmTbLyQyA6GHY2AZDBelvtrM/tuGImrUwBMl0NcFprD9ln5kfQ
	 FnlBUmuxpv4wQHSI9ovjr/pPhrITwBAwvLCDNemX1xRz7//JIocA7hpQZpHmQhQj+I
	 ixHFt3PdXLZnw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so59426666b.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 06:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526986; x=1742131786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WlniEeO1sxFM6/UgRu+OkcVvl4eFAZ3k4+mcLNjIi4=;
        b=VkZQU9EldDGjD2caavHyJgFm8IKjaXmvW9bf6tPLMJXuG2JpLTXbfBOR1EiO1q+972
         SeCArmKkcq/Qh9Uq2lsa7NTZklfN2tpqagxO4zw9MVe6vJaoI9zgH4q4nKW8XVM0jiLY
         0AcbjMbq5EGIvJ55OMqs2caSq6ZiIptrDAxoyENDfqzZt0Fvb61EDpGbUB/52+dd9BA6
         V5m/ICBY0xS40PpxHGbC8UdiV5JnkxJLksYgxxmLEcDHKevYubWjQuwDKfglqfN3SzoC
         zWoUKgc0O5Nm/sZ4SbzHYiGCOrJ0b67L+QTbpMnPf757XAhLzNwso1cbaJrCwRcNyyzw
         cvJg==
X-Forwarded-Encrypted: i=1; AJvYcCXY4SHem0lr6SGu3rs/BrGCkufVpWcsfxbOkD51PEKjUjlAFK8Lfjk/woX8/+VYaWdvmwdWSfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdXYW9hgi5hrR/5zFIOz6GOpxJps+gMRptWwABlebNnNMbaDm
	EGqHVH1Yt2iCUQXjVj2WzaCwlNfShFkBzuirS07DY3SuhE3AVEJZqzfFSZluzLWs1h+3CA1zKOG
	SjZ9FWyeYk6Q3Z+7CP6eOlDV672uQN2X7PgqCT0qLLpnOhv5p8q4sDOkoD7RMHs8ITTIsNg==
X-Gm-Gg: ASbGncvtNATEIFQlKkC9P8UILFxj9S5RvWKLbSS4DWaFJhXmm2Ot/c8YwTkNd9LRwCX
	wxDdBzg461fo9evyd/1RmEhufMyeHne46WFBV0oAtelIFGXtZa7NfS/nNgoWNpgFXMKJl5rElwl
	HN3vBxtWiQX3r+PZImggSVC0rptyOOuBlBAawdj+dQnVj/q0C2OefLCXXUAM1YJw8NZWYKu/NYx
	NFXiq7YKyQCvHZygU8XcUflheLQuhhKeIIkWGPqoa9a0ycgbe9FMVgn54xjRVsbKMOqB/Po3Oiy
	sCCU7ob3+Gh8vZxth/qqScJe+eCoKNDWxbPY13vLP+0wzpvQq7m4Y6nErKTLLTZi3/ZscqgxkSw
	oxejUlQUhA8nxTmfXxw==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr1204986266b.5.1741526985916;
        Sun, 09 Mar 2025 06:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFa95jUlBdWGTjYgXwcr9ZUQLkTVCYf0hxOKWN8Duf76vORogdoI0XKHA/oyP746iZKMUFGA==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr1204982566b.5.1741526985467;
        Sun, 09 Mar 2025 06:29:45 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:45 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 4/4] tools/testing/selftests/cgroup: add test for SO_PEERCGROUPID
Date: Sun,  9 Mar 2025 14:28:15 +0100
Message-ID: <20250309132821.103046-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/cgroup/Makefile       |   2 +
 .../selftests/cgroup/test_so_peercgroupid.c   | 308 ++++++++++++++++++
 2 files changed, 310 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_so_peercgroupid.c

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 1b897152bab6..a932ff068081 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -16,6 +16,7 @@ TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_memcontrol
 TEST_GEN_PROGS += test_pids
+TEST_GEN_PROGS += test_so_peercgroupid
 TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
@@ -31,4 +32,5 @@ $(OUTPUT)/test_kill: cgroup_util.c
 $(OUTPUT)/test_kmem: cgroup_util.c
 $(OUTPUT)/test_memcontrol: cgroup_util.c
 $(OUTPUT)/test_pids: cgroup_util.c
+$(OUTPUT)/test_so_peercgroupid: cgroup_util.c
 $(OUTPUT)/test_zswap: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_so_peercgroupid.c b/tools/testing/selftests/cgroup/test_so_peercgroupid.c
new file mode 100644
index 000000000000..2bf1f00a45c7
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_so_peercgroupid.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+#define _GNU_SOURCE
+#include <error.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <linux/socket.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/un.h>
+#include <sys/signal.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "../kselftest_harness.h"
+#include "cgroup_util.h"
+
+#define clean_errno() (errno == 0 ? "None" : strerror(errno))
+#define log_err(MSG, ...)                                                   \
+	fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", __FILE__, __LINE__, \
+		clean_errno(), ##__VA_ARGS__)
+
+#ifndef SO_PEERCGROUPID
+#define SO_PEERCGROUPID 83
+#endif
+
+static void child_die()
+{
+	exit(1);
+}
+
+struct sock_addr {
+	char sock_name[32];
+	struct sockaddr_un listen_addr;
+	socklen_t addrlen;
+};
+
+FIXTURE(so_peercgroupid)
+{
+	int server;
+	pid_t client_pid;
+	int sync_sk[2];
+	struct sock_addr server_addr;
+	struct sock_addr *client_addr;
+	char cgroup_root[PATH_MAX];
+	char *test_cgroup1;
+	char *test_cgroup2;
+};
+
+FIXTURE_VARIANT(so_peercgroupid)
+{
+	int type;
+	bool abstract;
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, stream_pathname)
+{
+	.type = SOCK_STREAM,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, stream_abstract)
+{
+	.type = SOCK_STREAM,
+	.abstract = 1,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, seqpacket_pathname)
+{
+	.type = SOCK_SEQPACKET,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, seqpacket_abstract)
+{
+	.type = SOCK_SEQPACKET,
+	.abstract = 1,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, dgram_pathname)
+{
+	.type = SOCK_DGRAM,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, dgram_abstract)
+{
+	.type = SOCK_DGRAM,
+	.abstract = 1,
+};
+
+FIXTURE_SETUP(so_peercgroupid)
+{
+	self->client_addr = mmap(NULL, sizeof(*self->client_addr), PROT_READ | PROT_WRITE,
+				 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, self->client_addr);
+
+	self->cgroup_root[0] = '\0';
+}
+
+FIXTURE_TEARDOWN(so_peercgroupid)
+{
+	close(self->server);
+
+	kill(self->client_pid, SIGKILL);
+	waitpid(self->client_pid, NULL, 0);
+
+	if (!variant->abstract) {
+		unlink(self->server_addr.sock_name);
+		unlink(self->client_addr->sock_name);
+	}
+
+	if (strlen(self->cgroup_root) > 0) {
+		cg_enter_current(self->cgroup_root);
+
+		if (self->test_cgroup1)
+			cg_destroy(self->test_cgroup1);
+		free(self->test_cgroup1);
+
+		if (self->test_cgroup2)
+			cg_destroy(self->test_cgroup2);
+		free(self->test_cgroup2);
+	}
+}
+
+static void fill_sockaddr(struct sock_addr *addr, bool abstract)
+{
+	char *sun_path_buf = (char *)&addr->listen_addr.sun_path;
+
+	addr->listen_addr.sun_family = AF_UNIX;
+	addr->addrlen = offsetof(struct sockaddr_un, sun_path);
+	snprintf(addr->sock_name, sizeof(addr->sock_name), "so_peercgroupid_%d", getpid());
+	addr->addrlen += strlen(addr->sock_name);
+	if (abstract) {
+		*sun_path_buf = '\0';
+		addr->addrlen++;
+		sun_path_buf++;
+	} else {
+		unlink(addr->sock_name);
+	}
+	memcpy(sun_path_buf, addr->sock_name, strlen(addr->sock_name));
+}
+
+static void client(FIXTURE_DATA(so_peercgroupid) *self,
+		   const FIXTURE_VARIANT(so_peercgroupid) *variant)
+{
+	int cfd, err;
+	socklen_t len;
+	uint64_t peer_cgroup_id = 0, test_cgroup1_id = 0, test_cgroup2_id = 0;
+	char state;
+
+	cfd = socket(AF_UNIX, variant->type, 0);
+	if (cfd < 0) {
+		log_err("socket");
+		child_die();
+	}
+
+	if (variant->type == SOCK_DGRAM) {
+		fill_sockaddr(self->client_addr, variant->abstract);
+
+		if (bind(cfd, (struct sockaddr *)&self->client_addr->listen_addr, self->client_addr->addrlen)) {
+			log_err("bind");
+			child_die();
+		}
+	}
+
+	/* negative testcase: no peer for socket yet */
+	len = sizeof(peer_cgroup_id);
+	err = getsockopt(cfd, SOL_SOCKET, SO_PEERCGROUPID, &peer_cgroup_id, &len);
+	if (!err || (errno != ENODATA)) {
+		log_err("getsockopt must fail with errno == ENODATA when socket has no peer");
+		child_die();
+	}
+
+	if (connect(cfd, (struct sockaddr *)&self->server_addr.listen_addr,
+		    self->server_addr.addrlen) != 0) {
+		log_err("connect");
+		child_die();
+	}
+
+	state = 'R';
+	write(self->sync_sk[1], &state, sizeof(state));
+
+	read(self->sync_sk[1], &test_cgroup1_id, sizeof(uint64_t));
+	read(self->sync_sk[1], &test_cgroup2_id, sizeof(uint64_t));
+
+	len = sizeof(peer_cgroup_id);
+	if (getsockopt(cfd, SOL_SOCKET, SO_PEERCGROUPID, &peer_cgroup_id, &len)) {
+		log_err("Failed to get SO_PEERCGROUPID");
+		child_die();
+	}
+
+	/*
+	 * There is a difference between connection-oriented sockets
+	 * and connectionless ones from the perspective of SO_PEERCGROUPID.
+	 *
+	 * sk->sk_cgrp_data is getting filled when we allocate struct sock (see call to cgroup_sk_alloc()).
+	 * For DGRAM socket, self->server socket is our peer and by the time when we allocate it,
+	 * parent process sits in a test_cgroup1. Then it changes cgroup to test_cgroup2, but it does not
+	 * affect anything.
+	 * For STREAM/SEQPACKET socket, self->server is not our peer, but that one we get from accept()
+	 * syscall. And by the time when we call accept(), parent process sits in test_cgroup2.
+	 *
+	 * Let's ensure that it works like that and if it get changed then we should detect it
+	 * as it's a clear UAPI change.
+	 */
+	if (variant->type == SOCK_DGRAM) {
+		/* cgroup id from SO_PEERCGROUPID should be equal to the test_cgroup1_id */
+		if (peer_cgroup_id != test_cgroup1_id) {
+			log_err("peer_cgroup_id != test_cgroup1_id: %" PRId64 " != %" PRId64, peer_cgroup_id, test_cgroup1_id);
+			child_die();
+		}
+	} else {
+		/* cgroup id from SO_PEERCGROUPID should be equal to the test_cgroup2_id */
+		if (peer_cgroup_id != test_cgroup2_id) {
+			log_err("peer_cgroup_id != test_cgroup2_id: %" PRId64 " != %" PRId64, peer_cgroup_id, test_cgroup2_id);
+			child_die();
+		}
+	}
+}
+
+TEST_F(so_peercgroupid, test)
+{
+	uint64_t test_cgroup1_id, test_cgroup2_id;
+	int err;
+	int pfd;
+	char state;
+	int child_status = 0;
+
+	if (cg_find_unified_root(self->cgroup_root, sizeof(self->cgroup_root), NULL))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	self->test_cgroup1 = cg_name(self->cgroup_root, "so_peercgroupid_cg1");
+	ASSERT_NE(NULL, self->test_cgroup1);
+
+	self->test_cgroup2 = cg_name(self->cgroup_root, "so_peercgroupid_cg2");
+	ASSERT_NE(NULL, self->test_cgroup2);
+
+	err = cg_create(self->test_cgroup1);
+	ASSERT_EQ(0, err);
+
+	err = cg_create(self->test_cgroup2);
+	ASSERT_EQ(0, err);
+
+	test_cgroup1_id = cg_get_id(self->test_cgroup1);
+	ASSERT_LT(0, test_cgroup1_id);
+
+	test_cgroup2_id = cg_get_id(self->test_cgroup2);
+	ASSERT_LT(0, test_cgroup2_id);
+
+	/* enter test_cgroup1 before allocating a socket */
+	err = cg_enter_current(self->test_cgroup1);
+	ASSERT_EQ(0, err);
+
+	self->server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_NE(-1, self->server);
+
+	/* enter test_cgroup2 after allocating a socket */
+	err = cg_enter_current(self->test_cgroup2);
+	ASSERT_EQ(0, err);
+
+	fill_sockaddr(&self->server_addr, variant->abstract);
+
+	err = bind(self->server, (struct sockaddr *)&self->server_addr.listen_addr, self->server_addr.addrlen);
+	ASSERT_EQ(0, err);
+
+	if (variant->type != SOCK_DGRAM) {
+		err = listen(self->server, 1);
+		ASSERT_EQ(0, err);
+	}
+
+	err = socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, self->sync_sk);
+	EXPECT_EQ(err, 0);
+
+	self->client_pid = fork();
+	ASSERT_NE(-1, self->client_pid);
+	if (self->client_pid == 0) {
+		close(self->server);
+		close(self->sync_sk[0]);
+		client(self, variant);
+		exit(0);
+	}
+	close(self->sync_sk[1]);
+
+	if (variant->type != SOCK_DGRAM) {
+		pfd = accept(self->server, NULL, NULL);
+		ASSERT_NE(-1, pfd);
+	} else {
+		pfd = self->server;
+	}
+
+	/* wait until the child arrives at checkpoint */
+	read(self->sync_sk[0], &state, sizeof(state));
+	ASSERT_EQ(state, 'R');
+
+	write(self->sync_sk[0], &test_cgroup1_id, sizeof(uint64_t));
+	write(self->sync_sk[0], &test_cgroup2_id, sizeof(uint64_t));
+
+	close(pfd);
+	waitpid(self->client_pid, &child_status, 0);
+	ASSERT_EQ(0, WIFEXITED(child_status) ? WEXITSTATUS(child_status) : 1);
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


