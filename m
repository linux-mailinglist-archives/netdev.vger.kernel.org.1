Return-Path: <netdev+bounces-178193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E205BA75764
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65031890D2B
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3971C84C3;
	Sat, 29 Mar 2025 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rMuPa+fj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A314D70E
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743271636; cv=none; b=H8WjxjyyC+UhqHJLdAuu5uHK8TPNq4yxzWbS6fffSyK83x+nanNeVSZGqySKM9UCx+WcoTzZb9pr7VdYqsxm7m6AXyV0nkQmVqM8B6vQUButrpwIkjqoyGYjK51B0CA22YhckUM563PZRoKhlAMqM6d8X473Ww+AzA3V01A8HUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743271636; c=relaxed/simple;
	bh=NXyhjubpjZ1Grew+8T+b9icbCRAzbgWTk1AssWF5X0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7FlV0zXMA5nuEEWckPhnPwey6Ps035gKpfUO+O60aVZDvNTNkWYnBPd+rLqjK6CYEI55tSZ1UyLYw3xvbzAe7wr6giaTG2Op8jQ9tlmw+y+pEjetMDXmRt4xHMo+77/RVMpzvdcAfHn0VzO2HEljgXWgFS2EKb1hlvaBwCuxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rMuPa+fj; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743271634; x=1774807634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQqBG6k59KuMbcPmputGo35fKli1X49YXmCVWCEoLLU=;
  b=rMuPa+fjADX0Twb6rJjyQ1Stety/Wl9bkXTcHQ1woCTkwhOCwxxvDX1A
   bJsT7ju1VpaeE6a74Xmx+RuCCHbbd6XEkcABlryBsja4cWyh652R4Ss+l
   wGnanjFOPxSAOud395sb8JtOrUbGgWa7SR+/TZ0q+N0jYPFmLQlkYSEma
   c=;
X-IronPort-AV: E=Sophos;i="6.14,286,1736812800"; 
   d="scan'208";a="731021567"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 18:07:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:57866]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.51:2525] with esmtp (Farcaster)
 id b430a357-abc9-44af-90ec-f801ac86e7a1; Sat, 29 Mar 2025 18:07:10 +0000 (UTC)
X-Farcaster-Flow-ID: b430a357-abc9-44af-90ec-f801ac86e7a1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 29 Mar 2025 18:07:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.57) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 29 Mar 2025 18:07:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Willem de
 Bruijn" <willemb@google.com>
Subject: [PATCH v4 net 3/3] selftest: net: Check wraparounds for sk->sk_rmem_alloc.
Date: Sat, 29 Mar 2025 11:05:13 -0700
Message-ID: <20250329180541.34968-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329180541.34968-1-kuniyu@amazon.com>
References: <20250329180541.34968-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The test creates client and server sockets and sets INT_MAX to the
server's SO_RCVBUFFORCE.

Then, the client floods packets to the server until the UDP memory
usage reaches (INT_MAX + 1) >> PAGE_SHIFT.

Finally, both sockets are close()d, and the last assert makes sure
that the memory usage drops to 0.

If needed, we can extend the test later for other protocols.

Without patch 1:

  # Starting 2 tests from 2 test cases.
  #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
  # so_rcvbuf.c:163:rmem_max:Expected pages (524800) <= *variant->max_pages (524288)
  # rmem_max: Test terminated by assertion
  #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
  not ok 1 so_rcvbuf.udp_ipv4.rmem_max

Without patch 2:

  #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
  # so_rcvbuf.c:170:rmem_max:max_pages: 524288
  # so_rcvbuf.c:178:rmem_max:Expected get_prot_pages(_metadata, variant) (524288) == 0 (0)
  # rmem_max: Test terminated by assertion
  #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
  not ok 1 so_rcvbuf.udp_ipv4.rmem_max

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v4: Wait RCU for at most 30 sec
v3: Rebase to the latest net.git
v2: Add some comments (Note with 1000 loops it didn't fail at ASSERT_LE)
---
 tools/testing/selftests/net/.gitignore  |   3 +-
 tools/testing/selftests/net/Makefile    |   2 +-
 tools/testing/selftests/net/so_rcvbuf.c | 188 ++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_rcvbuf.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 679542f565a4..972fb07730d2 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -42,8 +42,9 @@ sk_so_peek_off
 socket
 so_incoming_cpu
 so_netns_cookie
-so_txtime
 so_rcv_listener
+so_rcvbuf
+so_txtime
 stress_reuseport_listen
 tap
 tcp_fastopen_backup_key
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6d718b478ed8..393ffa1c417b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -87,7 +87,7 @@ TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
 TEST_GEN_PROGS += sk_so_peek_off
 TEST_PROGS += test_ingress_egress_chaining.sh
-TEST_GEN_PROGS += so_incoming_cpu
+TEST_GEN_PROGS += so_incoming_cpu so_rcvbuf
 TEST_PROGS += sctp_vrf.sh
 TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += ip_local_port_range
diff --git a/tools/testing/selftests/net/so_rcvbuf.c b/tools/testing/selftests/net/so_rcvbuf.c
new file mode 100644
index 000000000000..1a593033e47b
--- /dev/null
+++ b/tools/testing/selftests/net/so_rcvbuf.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#include <limits.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+static int udp_max_pages;
+
+static int udp_parse_pages(struct __test_metadata *_metadata,
+			   char *line, int *pages)
+{
+	int ret, unused;
+
+	if (strncmp(line, "UDP:", 4))
+		return -1;
+
+	ret = sscanf(line + 4, " inuse %d mem %d", &unused, pages);
+	ASSERT_EQ(2, ret);
+
+	return 0;
+}
+
+FIXTURE(so_rcvbuf)
+{
+	union {
+		struct sockaddr addr;
+		struct sockaddr_in addr4;
+		struct sockaddr_in6 addr6;
+	};
+	socklen_t addrlen;
+	int server;
+	int client;
+};
+
+FIXTURE_VARIANT(so_rcvbuf)
+{
+	int family;
+	int type;
+	int protocol;
+	int *max_pages;
+	int (*parse_pages)(struct __test_metadata *_metadata,
+			   char *line, int *pages);
+};
+
+FIXTURE_VARIANT_ADD(so_rcvbuf, udp_ipv4)
+{
+	.family = AF_INET,
+	.type = SOCK_DGRAM,
+	.protocol = 0,
+	.max_pages = &udp_max_pages,
+	.parse_pages = udp_parse_pages,
+};
+
+FIXTURE_VARIANT_ADD(so_rcvbuf, udp_ipv6)
+{
+	.family = AF_INET6,
+	.type = SOCK_DGRAM,
+	.protocol = 0,
+	.max_pages = &udp_max_pages,
+	.parse_pages = udp_parse_pages,
+};
+
+static int get_page_shift(void)
+{
+	int page_size = getpagesize();
+	int page_shift = 0;
+
+	while (page_size > 1) {
+		page_size >>= 1;
+		page_shift++;
+	}
+
+	return page_shift;
+}
+
+FIXTURE_SETUP(so_rcvbuf)
+{
+	self->addr.sa_family = variant->family;
+
+	if (variant->family == AF_INET)
+		self->addrlen = sizeof(struct sockaddr_in);
+	else
+		self->addrlen = sizeof(struct sockaddr_in6);
+
+	udp_max_pages = (INT_MAX + 1L) >> get_page_shift();
+}
+
+FIXTURE_TEARDOWN(so_rcvbuf)
+{
+}
+
+static void create_socketpair(struct __test_metadata *_metadata,
+			      FIXTURE_DATA(so_rcvbuf) *self,
+			      const FIXTURE_VARIANT(so_rcvbuf) *variant)
+{
+	int ret;
+
+	self->server = socket(variant->family, variant->type, variant->protocol);
+	ASSERT_NE(self->server, -1);
+
+	self->client = socket(variant->family, variant->type, variant->protocol);
+	ASSERT_NE(self->client, -1);
+
+	ret = bind(self->server, &self->addr, self->addrlen);
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockname(self->server, &self->addr, &self->addrlen);
+	ASSERT_EQ(ret, 0);
+
+	ret = connect(self->client, &self->addr, self->addrlen);
+	ASSERT_EQ(ret, 0);
+}
+
+static int get_prot_pages(struct __test_metadata *_metadata,
+			  const FIXTURE_VARIANT(so_rcvbuf) *variant)
+{
+	char *line = NULL;
+	size_t unused;
+	int pages = 0;
+	FILE *f;
+
+	f = fopen("/proc/net/sockstat", "r");
+	ASSERT_NE(NULL, f);
+
+	while (getline(&line, &unused, f) != -1)
+		if (!variant->parse_pages(_metadata, line, &pages))
+			break;
+
+	free(line);
+	fclose(f);
+
+	return pages;
+}
+
+TEST_F(so_rcvbuf, rmem_max)
+{
+	int ret, i, pages;
+	char buf[16] = {};
+
+	create_socketpair(_metadata, self, variant);
+
+	ret = setsockopt(self->server, SOL_SOCKET, SO_RCVBUFFORCE,
+			 &(int){INT_MAX}, sizeof(int));
+	ASSERT_EQ(ret, 0);
+
+	pages = get_prot_pages(_metadata, variant);
+	ASSERT_EQ(pages, 0);
+
+	for (i = 1; ; i++) {
+		ret = send(self->client, buf, sizeof(buf), 0);
+		ASSERT_EQ(ret, sizeof(buf));
+
+		/* Make sure we don't stop at pages == (INT_MAX >> PAGE_SHIFT)
+		 * in case ASSERT_LE() should fail.
+		 */
+		if (i % 10000 == 0) {
+			pages = get_prot_pages(_metadata, variant);
+
+			/* sk_rmem_alloc wrapped around by >PAGE_SIZE ? */
+			ASSERT_LE(pages, *variant->max_pages);
+
+			if (pages == *variant->max_pages)
+				break;
+		}
+	}
+
+	TH_LOG("max_pages: %d", pages);
+
+	close(self->client);
+	close(self->server);
+
+	/* Give RCU a chance to call udp_destruct_common() */
+	for (i = 0; i < 30; i++) {
+		sleep(1);
+
+		pages = get_prot_pages(_metadata, variant);
+		if (!pages)
+			break;
+	}
+
+	ASSERT_EQ(pages, 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.48.1


