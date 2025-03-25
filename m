Return-Path: <netdev+bounces-177589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF6A70AE1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F8F18863E7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F161B23A98D;
	Tue, 25 Mar 2025 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NuStru9f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8851FF1DF
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932802; cv=none; b=s3PU5CmzeN8hjrGP1oT3gf3HVJVnuem2LPnK9dHXNFS8xe5mJverEIiGdNlkXfZ8/yVR5I8gU3xXuwAoKul0bagTjucLHi8RjJeto32vKGHKF97tMIVOCqXbFs2H2M1yjeNxVHAdo6Exdu50kfR6XOX7Lf/BvZkCw/keifSIGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932802; c=relaxed/simple;
	bh=zZmDoGxJ18u9c2QB0oTFlRAWVVopIMcZWTN8qRpge58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgTon4x1TK4RUImEPpF4EjM/bqZLDllNA81GU/HELX0KwHMbHA6SN21gbmPS3vCFw9unQ6ohMbMkj+H4sdanYSnXNgZmLND0+6Fo0XoYI7ry+6VpKjU80pw1zgmPUmPgWBeUbAXu/wFPRg7xIpRhb8e8F1WCiE4Bkqqs9FSO5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NuStru9f; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742932800; x=1774468800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h6FPUWNoz3byHJh5AMHC1MRftkvoNwuENwx0JigtZH4=;
  b=NuStru9f4mGxfZupyXpsAaU6NfqUVtEY7XCMlE0zeI2Pi1GVJK9e54q+
   QgvsNDivHFjABOXLziBIr0lp+Sp7gWJmv0kDK7hSg3f0Ng8uo+4inVWFk
   HFF5wcGXyTQihbXgwkg9cpcrPUoFuZVTg/md6SPunAw+IVCjGUkEQsPf/
   0=;
X-IronPort-AV: E=Sophos;i="6.14,275,1736812800"; 
   d="scan'208";a="181831562"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 19:59:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:11123]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.87:2525] with esmtp (Farcaster)
 id 028ad082-25c1-4564-b4c9-f6978025b62f; Tue, 25 Mar 2025 19:59:58 +0000 (UTC)
X-Farcaster-Flow-ID: 028ad082-25c1-4564-b4c9-f6978025b62f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:59:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:59:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 3/3] selftest: net: Check wraparounds for sk->sk_rmem_alloc.
Date: Tue, 25 Mar 2025 12:58:15 -0700
Message-ID: <20250325195826.52385-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325195826.52385-1-kuniyu@amazon.com>
References: <20250325195826.52385-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
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
---
v2: Add some comments (Note with 1000 loops it didn't fail at ASSERT_LE)
---
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   2 +-
 tools/testing/selftests/net/so_rcvbuf.c | 181 ++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/so_rcvbuf.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 28a715a8ef2b..befbdfb26581 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -41,6 +41,7 @@ sk_so_peek_off
 socket
 so_incoming_cpu
 so_netns_cookie
+so_rcvbuf
 so_txtime
 stress_reuseport_listen
 tap
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8f32b4f01aee..d04428eaa819 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -83,7 +83,7 @@ TEST_GEN_PROGS += sk_bind_sendto_listen
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
index 000000000000..3b4d7ebe9ab0
--- /dev/null
+++ b/tools/testing/selftests/net/so_rcvbuf.c
@@ -0,0 +1,181 @@
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
+	char buf[16] = {};
+	int ret, i;
+
+	create_socketpair(_metadata, self, variant);
+
+	ret = setsockopt(self->server, SOL_SOCKET, SO_RCVBUFFORCE,
+			 &(int){INT_MAX}, sizeof(int));
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_EQ(get_prot_pages(_metadata, variant), 0);
+
+	for (i = 1; ; i++) {
+		ret = send(self->client, buf, sizeof(buf), 0);
+		ASSERT_EQ(ret, sizeof(buf));
+
+		/* Make sure we don't stop at pages == (INT_MAX >> PAGE_SHIFT)
+		 * if there is an overflow bug.
+		 */
+		if (i % 10000 == 0) {
+			int pages = get_prot_pages(_metadata, variant);
+
+			/* sk_rmem_alloc wrapped around by >PAGE_SIZE ? */
+			ASSERT_LE(pages, *variant->max_pages);
+
+			if (pages == *variant->max_pages)
+				break;
+		}
+	}
+
+	TH_LOG("max_pages: %d", get_prot_pages(_metadata, variant));
+
+	close(self->client);
+	close(self->server);
+
+	/* Give RCU a chance to call udp_destruct_common() */
+	sleep(5);
+
+	ASSERT_EQ(get_prot_pages(_metadata, variant), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.48.1


