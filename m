Return-Path: <netdev+bounces-176986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A74A6D276
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 00:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F79C3B0DE5
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5E1BD9C6;
	Sun, 23 Mar 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KXvnMhyZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99341A5B8F
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742771521; cv=none; b=uUKQg2bzYOxhPfP5a692IwU2cgVju8vcKmSb95pgIlWYDFW2fAmY609hZngC/NQvZiZ6y5jJB4WqbytTsQ3EMsjcecidX37LY5y6B/vb09nqivIfWL8+SH53ZIGXbNl+6lFSE6RHiTV6iUZx1SW/9FOFHddICLwaMiCqzFqPkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742771521; c=relaxed/simple;
	bh=fVzt/fzs+2frWU7zEo+I7iyoh8EOUuNp9IWlMKNMXKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZGQicXMmJlMnGaV1HXdomioO/4lxA41yPnci0JmYhgU5ArBgELJeiHcZzw4PZkquQJ4eL0q+j3b5gdcXLauLgIWbjdJ//1IPOAEj+WSfH0+tjnC0BtkzkmBS9JhIc4rF9KIlMzVnDrECNPaHXA1aT2i4V5JZ0agOhrnChwzeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KXvnMhyZ; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742771520; x=1774307520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jZ4JB8dmtJajZ4Ifox+f6UQi24FYx/G6OL730pwjETA=;
  b=KXvnMhyZo7jHZ4poGyrtCojLcgpm5+6MM0uMR5fCNVYh/Vy7Lm1KaUG4
   eWOBT5sjer9j2F0qksj3jIHDUnI0DvJ2z1RZy5RLvoIoCTpomMsPXZtEi
   pDfJKkPlB41sbACA7B9xK/oRXDU1Q1Rd7TqHriBqdK263qcv1m4PFRVYH
   k=;
X-IronPort-AV: E=Sophos;i="6.14,271,1736812800"; 
   d="scan'208";a="473649990"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:11:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:9426]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.36:2525] with esmtp (Farcaster)
 id 28eb06b3-28d7-4b91-a455-f7449a1abec2; Sun, 23 Mar 2025 23:11:48 +0000 (UTC)
X-Farcaster-Flow-ID: 28eb06b3-28d7-4b91-a455-f7449a1abec2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 23 Mar 2025 23:11:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.57) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 23 Mar 2025 23:11:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 3/3] selftest: net: Check wraparounds for sk->sk_rmem_alloc.
Date: Sun, 23 Mar 2025 16:09:52 -0700
Message-ID: <20250323231016.74813-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250323231016.74813-1-kuniyu@amazon.com>
References: <20250323231016.74813-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The test creates client and server sockets and sets INT_MAX to the
server's SO_RCVBUFFORCE.

Then, the client floods packets to the server until the UDP memory
usage reaches (INT_MAX + 1) >> PAGE_SHIFT.

Finally, both sockets are close()d, and the last assert makes sure
that the memory usage drops to 0.

If needed, we can extend the test later for other protocols.

Without patch 1:

  #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
  # so_rcvbuf.c:160:rmem_max:Expected pages (524800) <= *variant->max_pages (524288)
  # rmem_max: Test terminated by assertion
  #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
  not ok 1 so_rcvbuf.udp_ipv4.rmem_max

Without patch 2:

  #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
  # so_rcvbuf.c:167:rmem_max:max_pages: 524288
  # so_rcvbuf.c:175:rmem_max:Expected get_prot_pages(_metadata, variant) (524288) == 0 (0)
  # rmem_max: Test terminated by assertion
  #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
  not ok 1 so_rcvbuf.udp_ipv4.rmem_max

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   2 +-
 tools/testing/selftests/net/so_rcvbuf.c | 178 ++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 1 deletion(-)
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
index 000000000000..6e20bafce32e
--- /dev/null
+++ b/tools/testing/selftests/net/so_rcvbuf.c
@@ -0,0 +1,178 @@
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
+		if (i % 10000 == 0) {
+			int pages = get_prot_pages(_metadata, variant);
+
+			/* sk_rmem_alloc wrapped around too much ? */
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


