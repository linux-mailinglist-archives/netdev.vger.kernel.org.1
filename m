Return-Path: <netdev+bounces-279461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vsKJFfUF42koBgEAu9opvQ
	(envelope-from <netdev+bounces-279461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA941FE94
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F4CB300B9C6
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278933970F;
	Sat, 18 Apr 2026 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXyxskv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B27283FD4
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485854; cv=none; b=DlqwWV/UdV4yyTecJNpaWdmzyTDSWhMkCMGpcGJ5JndnK0sU/4Hsb4WuW00bXsQbbqE1ebc7e26mH7J2zme8BvE/KfnCm9sL3tzs37ZKm+2lLmXGtHvSkJgVREOryQSg1OZiK10l2hjy9ZhKR3e4S3R2g0XRc3H9f6w2QwbWrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485854; c=relaxed/simple;
	bh=6bHBWuib2VnJt0uYbQUXdG8PsUDJ1BfklOfjP2I7E7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEyLmR2FyuBms6aNgQKnvA7PtFacmvKDNetFiodGEYthPpr8NqMPR3uRIbjPOdt0o18TWg/Q4wwbKF0EJ+DyS73MeUq8MWhmYRdYGISkxCIsC9vnxmxwYJMQxFqwUUDHaHKPfRxPW89k91GfkatFq4N/PaRdPdmZYyljTlopZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXyxskv+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82748257f5fso1366490b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776485852; x=1777090652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l03ftqcBwNBANgewVYkjhRzUGysmTzfJ0cwZF6DkQQ8=;
        b=eXyxskv+84L8rRQpMBl+dpa0OL1pmqakzcyeXoDh5BKBWNF9vX68ivz5ajAQ6D0+OZ
         V3fgu2O46EXh/silO+/dcDXHARZz7nCV2l54KRv37H8JInee86UI0EvjItJmC5ELzuRa
         WweSlN+9DDZEAEIR9RYAlW5o679aQQHrjgnWoMXGJ+znbMEAOFC4tG2BsS+xkhHUrFup
         HXMfFDjdyz+7IF28hbw6QNwl0vFuANuoc5bI1VubhSRutezev0/bxqIvWkbbnSHYUUTu
         Yx5bwZ3WYvbxnBj/vwCPVYfS10mtAtDVsdwLwO8Y4WxiPPBWnDc9atMtI54I66mNADSk
         W0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776485852; x=1777090652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l03ftqcBwNBANgewVYkjhRzUGysmTzfJ0cwZF6DkQQ8=;
        b=AlOr+oW+ygLlxcUfffx9BsMQAgIv0EnrSF6nO/5tBzmIC2IAYtLDuyRBv9/XWV8cdB
         I+jdOxfUaPpDnvqVWcbS8IbCOpXF53F4kbbJvH27LFsq5ixJXAlQQuB/73ALde5Z5mgv
         eaEAjpfrGBqA9QHL/K1WNfoGerSwjbcn5neLAvbtdqeU7kVBUKnHWG6flW2x/Ctf7BUN
         1KHlWQ/FCMPvOivib5nIigp2eNy0YCoik4cykxUScl/qCT8KnIybhVK1gT2xUEhm/IKz
         TP3d/JMagO5PRh5K+2gxS9P/qqgjR1U/e3B/IR1wJxzO6kGXT0m2zmenqjEWzb+aFvwY
         NarA==
X-Gm-Message-State: AOJu0Yz6FwG5ceZ9b9AW3K6q2cZiNudEIgGpZOwHki+ujij+5df6WrW0
	yaOWceI/SewzQzWaFp+u+SPPuRwu3v9lmLKucbKGor/TB5sngCMUIfNpQCPeyhNZr3ra9Yt0
X-Gm-Gg: AeBDietEeN1MzS7RN8xKocW5yKXFhj2QfJlluajTHxqgVoTLRhetojWoB+E87q6Jypv
	cnyhGA5m5M4UhtCM1UALX3FyDFVmv/Ou4uIDT5YKi0j3kFJkHUjhAw9g7m0Yh5Er8JeVVUkIGOQ
	hd1Xappl15zxGMsAfIExEtWydw66rotGTLjIrzW8QwQ4doaz2baiNAa/D6zx50CwFXf5NyuKbbx
	rM2SUb0JrjKTzapy7GEEmcszHEwcIqb3mt05ER0nMABu+5jSALhACFiuqD9fkdSIyQihyWeIRnS
	EiUSA9rxF3BOF2wMv/GnM709DBNxD9oLyrZ4BZ/1frmaZxA68dPY0nDiIFOKGxyNvhH5TvSm7Xz
	JK2bhnXDeTF/Qp7VsNfqycv+m9i1QhiPN1k9eQ+O0MNBWV1DZKBsQbJWr4knQIdnMUwA2hHTJUI
	u62/IQBSit7jorBmX3OfeFgpjXvhAp6Q33GEfmhrNzpHjOE0XfHWSWNCg+7/++cg==
X-Received: by 2002:a05:6a00:27ab:b0:82f:6eca:563e with SMTP id d2e1a72fcca58-82f8b573171mr4381198b3a.34.1776485851324;
        Fri, 17 Apr 2026 21:17:31 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981992sm4356787b3a.7.2026.04.17.21.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:17:30 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tamird@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>
Subject: [PATCH net 2/2] selftests: net: add reuseport migration wakeup regression tests
Date: Sat, 18 Apr 2026 12:16:33 +0800
Message-ID: <20260418041633.691435-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418041633.691435-1-jt26wzz@gmail.com>
References: <20260418041633.691435-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-279461-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ev.events:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05AA941FE94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add selftests that reproduce missing wakeups on the target listener
after SO_REUSEPORT migration from inet_csk_listen_stop().

The epoll case connects while only the first listener is active so the
child lands on its accept queue, registers the second listener with
epoll, then closes the first listener to trigger migration. It verifies
that the target listener both accepts the migrated child and becomes
readable via epoll.

The blocking accept case starts a thread blocked in accept() on the
target listener, closes the first listener to trigger migration, and
verifies that the blocked accept() wakes and returns the migrated
child. Wait until the helper thread is actually asleep in accept()
before triggering migration so the test does not race waiter
registration.

Run the tests in a private network namespace and enable
net.ipv4.tcp_migrate_req=1 there so they can exercise the migration
path without relying on a sk_reuseport/migrate BPF program. Treat a
missing or unwritable tcp_migrate_req sysctl as SKIP. Run both
scenarios for IPv4 and IPv6.

These tests cover the bug fixed by the preceding patch.

Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 tools/testing/selftests/net/Makefile          |   3 +
 .../selftests/net/reuseport_migrate_accept.c  | 533 ++++++++++++++++++
 .../selftests/net/reuseport_migrate_epoll.c   | 353 ++++++++++++
 3 files changed, 889 insertions(+)
 create mode 100644 tools/testing/selftests/net/reuseport_migrate_accept.c
 create mode 100644 tools/testing/selftests/net/reuseport_migrate_epoll.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584..2f8b6c44d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -184,6 +184,8 @@ TEST_GEN_PROGS := \
 	reuseport_bpf_cpu \
 	reuseport_bpf_numa \
 	reuseport_dualstack \
+	reuseport_migrate_accept \
+	reuseport_migrate_epoll \
 	sk_bind_sendto_listen \
 	sk_connect_zero_addr \
 	sk_so_peek_off \
@@ -232,6 +234,7 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
+$(OUTPUT)/reuseport_migrate_accept: LDLIBS += -lpthread
 $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
 
 include bpf.mk
diff --git a/tools/testing/selftests/net/reuseport_migrate_accept.c b/tools/testing/selftests/net/reuseport_migrate_accept.c
new file mode 100644
index 000000000..a516843a0
--- /dev/null
+++ b/tools/testing/selftests/net/reuseport_migrate_accept.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <netinet/in.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdatomic.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+#define ACCEPT_BLOCK_TIMEOUT_MS 1000
+#define ACCEPT_CLEANUP_TIMEOUT_MS 1000
+#define ACCEPT_WAKE_TIMEOUT_MS 2000
+#define TCP_MIGRATE_REQ_PATH "/proc/sys/net/ipv4/tcp_migrate_req"
+
+struct reuseport_migrate_case {
+	const char *name;
+	int family;
+	const char *addr;
+};
+
+struct accept_result {
+	int listener_fd;
+	atomic_int started;
+	atomic_int tid;
+	int accepted_fd;
+	int err;
+};
+
+static const struct reuseport_migrate_case test_cases[] = {
+	{
+		.name = "ipv4 blocking accept wake after reuseport migration",
+		.family = AF_INET,
+		.addr = "127.0.0.1",
+	},
+	{
+		.name = "ipv6 blocking accept wake after reuseport migration",
+		.family = AF_INET6,
+		.addr = "::1",
+	},
+};
+
+static void close_fd(int *fd)
+{
+	if (*fd >= 0) {
+		close(*fd);
+		*fd = -1;
+	}
+}
+
+static bool unsupported_addr_err(int family, int err)
+{
+	return family == AF_INET6 &&
+		(err == EAFNOSUPPORT ||
+		 err == EPROTONOSUPPORT ||
+		 err == EADDRNOTAVAIL);
+}
+
+static int make_sockaddr(const struct reuseport_migrate_case *test_case,
+			 unsigned short port,
+			 struct sockaddr_storage *addr,
+			 socklen_t *addrlen)
+{
+	memset(addr, 0, sizeof(*addr));
+
+	if (test_case->family == AF_INET) {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *)addr;
+
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = htons(port);
+		if (inet_pton(AF_INET, test_case->addr, &addr4->sin_addr) != 1)
+			return -1;
+
+		*addrlen = sizeof(*addr4);
+		return 0;
+	}
+
+	if (test_case->family == AF_INET6) {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
+
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = htons(port);
+		if (inet_pton(AF_INET6, test_case->addr, &addr6->sin6_addr) != 1)
+			return -1;
+
+		*addrlen = sizeof(*addr6);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int create_reuseport_socket(const struct reuseport_migrate_case *test_case)
+{
+	int one = 1;
+	int fd;
+
+	fd = socket(test_case->family, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
+	if (fd < 0)
+		return -1;
+
+	if (test_case->family == AF_INET6 &&
+	    setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &one, sizeof(one))) {
+		close(fd);
+		return -1;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one))) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static int enable_tcp_migrate_req(void)
+{
+	int len;
+	int fd;
+
+	fd = open(TCP_MIGRATE_REQ_PATH, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		if (errno == ENOENT || errno == EACCES ||
+		    errno == EPERM || errno == EROFS)
+			return KSFT_SKIP;
+		return KSFT_FAIL;
+	}
+
+	len = write(fd, "1", 1);
+	if (len != 1) {
+		if (errno == EACCES || errno == EPERM || errno == EROFS) {
+			close(fd);
+			return KSFT_SKIP;
+		}
+
+		close(fd);
+		return KSFT_FAIL;
+	}
+
+	close(fd);
+	return KSFT_PASS;
+}
+
+static void setup_netns(void)
+{
+	int ret;
+
+	if (unshare(CLONE_NEWNET))
+		ksft_exit_skip("unshare(CLONE_NEWNET): %s\n", strerror(errno));
+
+	if (system("ip link set lo up"))
+		ksft_exit_skip("failed to bring up lo interface in netns\n");
+
+	ret = enable_tcp_migrate_req();
+	if (ret == KSFT_SKIP)
+		ksft_exit_skip("failed to enable tcp_migrate_req\n");
+	if (ret == KSFT_FAIL)
+		ksft_exit_fail_msg("failed to enable tcp_migrate_req\n");
+}
+
+static void noop_handler(int sig)
+{
+	(void)sig;
+}
+
+static void *accept_thread(void *arg)
+{
+	struct accept_result *result = arg;
+
+	atomic_store_explicit(&result->tid, (int)syscall(SYS_gettid),
+			      memory_order_release);
+	atomic_store_explicit(&result->started, 1, memory_order_release);
+	result->accepted_fd = accept4(result->listener_fd, NULL, NULL,
+				      SOCK_CLOEXEC);
+	if (result->accepted_fd < 0)
+		result->err = errno;
+
+	return NULL;
+}
+
+static int read_thread_state(int tid, char *state)
+{
+	char *close_paren;
+	char path[64];
+	char buf[256];
+	ssize_t len;
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/self/task/%d/stat", tid);
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	len = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (len < 0)
+		return -errno;
+	if (!len)
+		return -EINVAL;
+
+	buf[len] = '\0';
+	close_paren = strrchr(buf, ')');
+	if (!close_paren || close_paren[1] != ' ' || !close_paren[2])
+		return -EINVAL;
+
+	*state = close_paren[2];
+	return 0;
+}
+
+static int wait_for_accept_to_block(const struct reuseport_migrate_case *test_case,
+				    int tid)
+{
+	char state = '\0';
+	int ret;
+	int i;
+
+	/*
+	 * A started thread is not enough here: we need to know the waiter
+	 * has actually gone to sleep in accept() before closing listener_a,
+	 * otherwise migration can race ahead of waiter registration. Poll
+	 * /proc task state because the pthread APIs can tell us whether the
+	 * thread has exited, but not whether it is already blocked in the
+	 * target syscall.
+	 */
+	for (i = 0; i < ACCEPT_BLOCK_TIMEOUT_MS; i++) {
+		ret = read_thread_state(tid, &state);
+		if (!ret) {
+			if (state == 'S' || state == 'D')
+				return KSFT_PASS;
+			if (state == 'Z')
+				break;
+		} else if (ret == -ENOENT) {
+			break;
+		}
+
+		usleep(1000);
+	}
+
+	ksft_print_msg("%s: accept waiter never blocked before migration\n",
+		       test_case->name);
+	return KSFT_FAIL;
+}
+
+static int join_thread_with_timeout(pthread_t thread, int timeout_ms,
+				    bool *timed_out)
+{
+	struct timespec deadline;
+	int err;
+
+	*timed_out = false;
+
+	if (clock_gettime(CLOCK_REALTIME, &deadline))
+		return KSFT_FAIL;
+
+	deadline.tv_nsec += timeout_ms * 1000000LL;
+	deadline.tv_sec += deadline.tv_nsec / 1000000000LL;
+	deadline.tv_nsec %= 1000000000LL;
+
+	err = pthread_timedjoin_np(thread, NULL, &deadline);
+	if (!err)
+		return KSFT_PASS;
+
+	if (err != ETIMEDOUT)
+		return KSFT_FAIL;
+
+	*timed_out = true;
+	return KSFT_FAIL;
+}
+
+static int interrupt_accept_thread(pthread_t thread)
+{
+	int err;
+
+	err = pthread_kill(thread, SIGUSR1);
+	if (err && err != ESRCH)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int stop_accept_thread(pthread_t thread, bool *timed_out)
+{
+	if (interrupt_accept_thread(thread))
+		return KSFT_FAIL;
+
+	return join_thread_with_timeout(thread, ACCEPT_CLEANUP_TIMEOUT_MS,
+					timed_out);
+}
+
+static int run_test(const struct reuseport_migrate_case *test_case)
+{
+	struct accept_result result = {
+		.listener_fd = -1,
+		.started = 0,
+		.tid = -1,
+		.accepted_fd = -1,
+		.err = 0,
+	};
+	struct sockaddr_storage addr;
+	struct sigaction sa = {
+		.sa_handler = noop_handler,
+	};
+	bool thread_joined = false;
+	bool cleanup_timed_out;
+	int listener_a = -1;
+	int listener_b = -1;
+	int ret = KSFT_FAIL;
+	socklen_t addrlen;
+	pthread_t thread;
+	int client = -1;
+	bool timed_out;
+	int probe = -1;
+	int tid;
+
+	if (make_sockaddr(test_case, 0, &addr, &addrlen)) {
+		ksft_print_msg("%s: failed to build socket address\n",
+			       test_case->name);
+		goto out;
+	}
+
+	if (sigemptyset(&sa.sa_mask)) {
+		ksft_perror("sigemptyset");
+		goto out;
+	}
+
+	if (sigaction(SIGUSR1, &sa, NULL)) {
+		ksft_perror("sigaction(SIGUSR1)");
+		goto out;
+	}
+
+	listener_a = create_reuseport_socket(test_case);
+	if (listener_a < 0) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("socket(listener_a)");
+		goto out;
+	}
+
+	if (bind(listener_a, (struct sockaddr *)&addr, addrlen)) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("bind(listener_a)");
+		goto out;
+	}
+
+	if (listen(listener_a, 1)) {
+		ksft_perror("listen(listener_a)");
+		goto out;
+	}
+
+	addrlen = sizeof(addr);
+	if (getsockname(listener_a, (struct sockaddr *)&addr, &addrlen)) {
+		ksft_perror("getsockname(listener_a)");
+		goto out;
+	}
+
+	listener_b = create_reuseport_socket(test_case);
+	if (listener_b < 0) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("socket(listener_b)");
+		goto out;
+	}
+
+	if (bind(listener_b, (struct sockaddr *)&addr, addrlen)) {
+		ksft_perror("bind(listener_b)");
+		goto out;
+	}
+
+	client = socket(test_case->family, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
+	if (client < 0) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("socket(client)");
+		goto out;
+	}
+
+	/* Connect while only listener_a is listening, ensuring the
+	 * child lands in listener_a's accept queue deterministically.
+	 */
+	if (connect(client, (struct sockaddr *)&addr, addrlen)) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("connect(client)");
+		goto out;
+	}
+
+	if (listen(listener_b, 1)) {
+		ksft_perror("listen(listener_b)");
+		goto out;
+	}
+
+	result.listener_fd = listener_b;
+	if (pthread_create(&thread, NULL, accept_thread, &result)) {
+		ksft_perror("pthread_create");
+		goto out;
+	}
+
+	while (!atomic_load_explicit(&result.started, memory_order_acquire))
+		sched_yield();
+
+	tid = atomic_load_explicit(&result.tid, memory_order_acquire);
+	if (wait_for_accept_to_block(test_case, tid))
+		goto out_with_thread;
+
+	close_fd(&listener_a);
+
+	ret = join_thread_with_timeout(thread, ACCEPT_WAKE_TIMEOUT_MS, &timed_out);
+	if (ret == KSFT_PASS) {
+		thread_joined = true;
+		if (result.accepted_fd < 0) {
+			ksft_print_msg("%s: blocking accept() returned err=%d (%s)\n",
+				       test_case->name, result.err,
+				       strerror(result.err));
+			ret = KSFT_FAIL;
+		}
+
+		goto out_with_thread;
+	}
+
+	if (!timed_out) {
+		ksft_print_msg("%s: join_thread_with_timeout() failed\n",
+			       test_case->name);
+		goto out_with_thread;
+	}
+
+	if (stop_accept_thread(thread, &cleanup_timed_out) == KSFT_FAIL) {
+		ksft_print_msg("%s: failed to stop blocking accept waiter\n",
+			       test_case->name);
+		goto out_with_thread;
+	}
+	thread_joined = true;
+
+	if (result.accepted_fd >= 0) {
+		ksft_print_msg("%s: blocking accept() completed only in cleanup\n",
+			       test_case->name);
+		goto out_with_thread;
+	}
+
+	if (result.err != EINTR) {
+		ksft_print_msg("%s: blocking accept() returned err=%d (%s)\n",
+			       test_case->name, result.err,
+			       strerror(result.err));
+		goto out_with_thread;
+	}
+
+	probe = accept4(listener_b, NULL, NULL, SOCK_NONBLOCK | SOCK_CLOEXEC);
+	if (probe >= 0) {
+		ksft_print_msg("%s: accept queue was populated, but blocking accept() timed out\n",
+			       test_case->name);
+	} else if (errno == EAGAIN || errno == EWOULDBLOCK) {
+		ksft_print_msg("%s: target listener had no queued child after migration\n",
+			       test_case->name);
+	} else {
+		ksft_perror("accept4(listener_b)");
+	}
+
+out_with_thread:
+	close_fd(&probe);
+	if (!thread_joined) {
+		if (stop_accept_thread(thread, &cleanup_timed_out) == KSFT_FAIL) {
+			ksft_print_msg("%s: failed to stop blocking accept waiter\n",
+				       test_case->name);
+			ret = KSFT_FAIL;
+			goto out;
+		}
+
+		thread_joined = true;
+	}
+	if (thread_joined)
+		close_fd(&result.accepted_fd);
+
+out:
+	close_fd(&client);
+	close_fd(&listener_b);
+	close_fd(&listener_a);
+
+	return ret;
+}
+
+int main(void)
+{
+	int status = KSFT_PASS;
+	int ret;
+	int i;
+
+	setup_netns();
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(test_cases));
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		ret = run_test(&test_cases[i]);
+		ksft_test_result_code(ret, test_cases[i].name, NULL);
+
+		if (ret == KSFT_FAIL)
+			status = KSFT_FAIL;
+	}
+
+	if (status == KSFT_FAIL)
+		ksft_exit_fail();
+
+	ksft_finished();
+}
diff --git a/tools/testing/selftests/net/reuseport_migrate_epoll.c b/tools/testing/selftests/net/reuseport_migrate_epoll.c
new file mode 100644
index 000000000..9cbfb58c4
--- /dev/null
+++ b/tools/testing/selftests/net/reuseport_migrate_epoll.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <netinet/in.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+#define EPOLL_TIMEOUT_MS 500
+#define TCP_MIGRATE_REQ_PATH "/proc/sys/net/ipv4/tcp_migrate_req"
+
+struct reuseport_migrate_case {
+	const char *name;
+	int family;
+	const char *addr;
+};
+
+static const struct reuseport_migrate_case test_cases[] = {
+	{
+		.name = "ipv4 epoll wake after reuseport migration",
+		.family = AF_INET,
+		.addr = "127.0.0.1",
+	},
+	{
+		.name = "ipv6 epoll wake after reuseport migration",
+		.family = AF_INET6,
+		.addr = "::1",
+	},
+};
+
+static void close_fd(int *fd)
+{
+	if (*fd >= 0) {
+		close(*fd);
+		*fd = -1;
+	}
+}
+
+static bool unsupported_addr_err(int family, int err)
+{
+	return family == AF_INET6 &&
+		(err == EAFNOSUPPORT ||
+		 err == EPROTONOSUPPORT ||
+		 err == EADDRNOTAVAIL);
+}
+
+static int make_sockaddr(const struct reuseport_migrate_case *test_case,
+			 unsigned short port,
+			 struct sockaddr_storage *addr,
+			 socklen_t *addrlen)
+{
+	memset(addr, 0, sizeof(*addr));
+
+	if (test_case->family == AF_INET) {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *)addr;
+
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = htons(port);
+		if (inet_pton(AF_INET, test_case->addr, &addr4->sin_addr) != 1)
+			return -1;
+
+		*addrlen = sizeof(*addr4);
+		return 0;
+	}
+
+	if (test_case->family == AF_INET6) {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
+
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = htons(port);
+		if (inet_pton(AF_INET6, test_case->addr, &addr6->sin6_addr) != 1)
+			return -1;
+
+		*addrlen = sizeof(*addr6);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int create_reuseport_socket(const struct reuseport_migrate_case *test_case)
+{
+	int one = 1;
+	int fd;
+
+	fd = socket(test_case->family, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
+	if (fd < 0)
+		return -1;
+
+	if (test_case->family == AF_INET6 &&
+	    setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &one, sizeof(one))) {
+		close(fd);
+		return -1;
+	}
+
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one))) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static int set_nonblocking(int fd)
+{
+	int flags;
+
+	flags = fcntl(fd, F_GETFL);
+	if (flags < 0)
+		return -1;
+
+	return fcntl(fd, F_SETFL, flags | O_NONBLOCK);
+}
+
+static int enable_tcp_migrate_req(void)
+{
+	int len;
+	int fd;
+
+	fd = open(TCP_MIGRATE_REQ_PATH, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		if (errno == ENOENT || errno == EACCES ||
+		    errno == EPERM || errno == EROFS)
+			return KSFT_SKIP;
+		return KSFT_FAIL;
+	}
+
+	len = write(fd, "1", 1);
+	if (len != 1) {
+		if (errno == EACCES || errno == EPERM || errno == EROFS) {
+			close(fd);
+			return KSFT_SKIP;
+		}
+
+		close(fd);
+		return KSFT_FAIL;
+	}
+
+	close(fd);
+	return KSFT_PASS;
+}
+
+static void setup_netns(void)
+{
+	int ret;
+
+	if (unshare(CLONE_NEWNET))
+		ksft_exit_skip("unshare(CLONE_NEWNET): %s\n", strerror(errno));
+
+	if (system("ip link set lo up"))
+		ksft_exit_skip("failed to bring up lo interface in netns\n");
+
+	ret = enable_tcp_migrate_req();
+	if (ret == KSFT_SKIP)
+		ksft_exit_skip("failed to enable tcp_migrate_req\n");
+	if (ret == KSFT_FAIL)
+		ksft_exit_fail_msg("failed to enable tcp_migrate_req\n");
+}
+
+static int run_test(const struct reuseport_migrate_case *test_case)
+{
+	struct sockaddr_storage addr;
+	struct epoll_event ev = {
+		.events = EPOLLIN,
+	};
+	int listener_a = -1;
+	int listener_b = -1;
+	int ret = KSFT_FAIL;
+	socklen_t addrlen;
+	int accepted = -1;
+	int client = -1;
+	int epfd = -1;
+	int n;
+
+	if (make_sockaddr(test_case, 0, &addr, &addrlen)) {
+		ksft_print_msg("%s: failed to build socket address\n",
+			       test_case->name);
+		goto out;
+	}
+
+	listener_a = create_reuseport_socket(test_case);
+	if (listener_a < 0) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("socket(listener_a)");
+		goto out;
+	}
+
+	if (bind(listener_a, (struct sockaddr *)&addr, addrlen)) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("bind(listener_a)");
+		goto out;
+	}
+
+	if (listen(listener_a, 1)) {
+		ksft_perror("listen(listener_a)");
+		goto out;
+	}
+
+	addrlen = sizeof(addr);
+	if (getsockname(listener_a, (struct sockaddr *)&addr, &addrlen)) {
+		ksft_perror("getsockname(listener_a)");
+		goto out;
+	}
+
+	listener_b = create_reuseport_socket(test_case);
+	if (listener_b < 0) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("socket(listener_b)");
+		goto out;
+	}
+
+	if (bind(listener_b, (struct sockaddr *)&addr, addrlen)) {
+		ksft_perror("bind(listener_b)");
+		goto out;
+	}
+
+	client = socket(test_case->family, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
+	if (client < 0) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("socket(client)");
+		goto out;
+	}
+
+	/* Connect while only listener_a is listening, ensuring the
+	 * child lands in listener_a's accept queue deterministically.
+	 */
+	if (connect(client, (struct sockaddr *)&addr, addrlen)) {
+		if (unsupported_addr_err(test_case->family, errno)) {
+			ret = KSFT_SKIP;
+			goto out;
+		}
+
+		ksft_perror("connect(client)");
+		goto out;
+	}
+
+	if (listen(listener_b, 1)) {
+		ksft_perror("listen(listener_b)");
+		goto out;
+	}
+
+	if (set_nonblocking(listener_b)) {
+		ksft_perror("set_nonblocking(listener_b)");
+		goto out;
+	}
+
+	epfd = epoll_create1(EPOLL_CLOEXEC);
+	if (epfd < 0) {
+		ksft_perror("epoll_create1");
+		goto out;
+	}
+
+	ev.data.fd = listener_b;
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, listener_b, &ev)) {
+		ksft_perror("epoll_ctl(ADD listener_b)");
+		goto out;
+	}
+
+	close_fd(&listener_a);
+
+	n = epoll_wait(epfd, &ev, 1, EPOLL_TIMEOUT_MS);
+	if (n < 0) {
+		ksft_perror("epoll_wait");
+		goto out;
+	}
+
+	accepted = accept4(listener_b, NULL, NULL, SOCK_NONBLOCK | SOCK_CLOEXEC);
+	if (accepted < 0) {
+		if (errno == EAGAIN || errno == EWOULDBLOCK) {
+			ksft_print_msg("%s: target listener had no queued child after migration\n",
+				       test_case->name);
+			goto out;
+		}
+
+		ksft_perror("accept4(listener_b)");
+		goto out;
+	}
+
+	if (n != 1) {
+		ksft_print_msg("%s: accept queue was populated, but epoll_wait() timed out\n",
+			       test_case->name);
+		goto out;
+	}
+
+	if (ev.data.fd != listener_b || !(ev.events & EPOLLIN)) {
+		ksft_print_msg("%s: unexpected epoll event fd=%d events=%#x\n",
+			       test_case->name, ev.data.fd, ev.events);
+		goto out;
+	}
+
+	ret = KSFT_PASS;
+
+out:
+	close_fd(&accepted);
+	close_fd(&epfd);
+	close_fd(&client);
+	close_fd(&listener_b);
+	close_fd(&listener_a);
+
+	return ret;
+}
+
+int main(void)
+{
+	int status = KSFT_PASS;
+	int ret;
+	int i;
+
+	setup_netns();
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(test_cases));
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		ret = run_test(&test_cases[i]);
+		ksft_test_result_code(ret, test_cases[i].name, NULL);
+
+		if (ret == KSFT_FAIL)
+			status = KSFT_FAIL;
+	}
+
+	if (status == KSFT_FAIL)
+		ksft_exit_fail();
+
+	ksft_finished();
+}
-- 
2.43.0


