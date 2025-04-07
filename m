Return-Path: <netdev+bounces-180000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B8DA7F0DC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C627A5095
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C977226888;
	Mon,  7 Apr 2025 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UU7GHAO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCC22154E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067960; cv=none; b=t4iCFjdowUFmdAgDMghqScEHoshpF3moPVEpwKc+wpb0ih/e9ngT+gkuedP6HF0flWyZNl46i5EqyRrYv+8AGRduG5FB/snmuJvlBIUc53bAvLpVm6BUq4IzQIzcX2cRZUIgW2OjicSH+KfsZ9mfDS1GVUy1nsdTAHyVRXxkgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067960; c=relaxed/simple;
	bh=ifbm0yXlb9HuqRe29ynhJxYtsiGbC0T+E+/V0efrkFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHK1X/I64a6NbkBjuicm78uHnycwlJAA6ztyfnKldo0gs4bfdy8CoCpErzN2FC0jMg4eDkYw4U2Xzi7gJJH1s/bUVEC7iI1fVhOsTxdt+xF1TXgcI17vRub5uCaB2+SyVoFLXfuv/HbLhUcDPeQi9vhjtaAb4tGhZDUiNc8nx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UU7GHAO3; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744067958; x=1775603958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPXBa9uCzAsjZnLtjTtpPlCKQo+qs80Aaw4SwxDBCcw=;
  b=UU7GHAO3e705DnAEvSQHwjEry/jwECA0DV+xC3yVTMop+hK+L3jwT7Sm
   IepY2bYHgehBMF351OlYHo6tfITMAOrBLlrHPlVWRVffg7Zp9KOQEcsrl
   p9l05IEabzeqxpu2o39WbksBnxJWcURZ0ntDN59hI/ldNfEALVBIcGUxO
   c=;
X-IronPort-AV: E=Sophos;i="6.15,196,1739836800"; 
   d="scan'208";a="81636438"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 23:19:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:17657]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 9cd8d852-4d5f-46ce-9ced-8074932576b2; Mon, 7 Apr 2025 23:19:14 +0000 (UTC)
X-Farcaster-Flow-ID: 9cd8d852-4d5f-46ce-9ced-8074932576b2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 23:19:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 23:19:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Neal
 Cardwell" <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
	"Pablo Neira Ayuso" <pablo@netfilter.org>, Jozsef Kadlecsik
	<kadlec@netfilter.org>, Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/4] selftest: net: Remove DCCP bits.
Date: Mon, 7 Apr 2025 16:17:48 -0700
Message-ID: <20250407231823.95927-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407231823.95927-1-kuniyu@amazon.com>
References: <20250407231823.95927-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove DCCP.

Let's remove DCCP bits from selftest.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/config            |  1 -
 .../selftests/net/reuseport_addr_any.c        | 36 +------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 130d532b7e67..3cfef5153823 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -33,7 +33,6 @@ CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_SIT=y
-CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES=m
diff --git a/tools/testing/selftests/net/reuseport_addr_any.c b/tools/testing/selftests/net/reuseport_addr_any.c
index b8475cb29be7..1c43401a1c80 100644
--- a/tools/testing/selftests/net/reuseport_addr_any.c
+++ b/tools/testing/selftests/net/reuseport_addr_any.c
@@ -9,7 +9,6 @@
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
-#include <linux/dccp.h>
 #include <linux/in.h>
 #include <linux/unistd.h>
 #include <stdbool.h>
@@ -21,10 +20,6 @@
 #include <sys/socket.h>
 #include <unistd.h>
 
-#ifndef SOL_DCCP
-#define SOL_DCCP 269
-#endif
-
 static const char *IP4_ADDR = "127.0.0.1";
 static const char *IP6_ADDR = "::1";
 static const char *IP4_MAPPED6 = "::ffff:127.0.0.1";
@@ -86,15 +81,6 @@ static void build_rcv_fd(int family, int proto, int *rcv_fds, int count,
 
 		if (proto == SOCK_STREAM && listen(rcv_fds[i], 10))
 			error(1, errno, "tcp: failed to listen on receive port");
-		else if (proto == SOCK_DCCP) {
-			if (setsockopt(rcv_fds[i], SOL_DCCP,
-					DCCP_SOCKOPT_SERVICE,
-					&(int) {htonl(42)}, sizeof(int)))
-				error(1, errno, "failed to setsockopt");
-
-			if (listen(rcv_fds[i], 10))
-				error(1, errno, "dccp: failed to listen on receive port");
-		}
 	}
 }
 
@@ -148,11 +134,6 @@ static int connect_and_send(int family, int proto)
 	if (fd < 0)
 		error(1, errno, "failed to create send socket");
 
-	if (proto == SOCK_DCCP &&
-		setsockopt(fd, SOL_DCCP, DCCP_SOCKOPT_SERVICE,
-				&(int){htonl(42)}, sizeof(int)))
-		error(1, errno, "failed to setsockopt");
-
 	if (bind(fd, saddr, sz))
 		error(1, errno, "failed to bind send socket");
 
@@ -175,7 +156,7 @@ static int receive_once(int epfd, int proto)
 	if (i < 0)
 		error(1, errno, "epoll_wait failed");
 
-	if (proto == SOCK_STREAM || proto == SOCK_DCCP) {
+	if (proto == SOCK_STREAM) {
 		fd = accept(ev.data.fd, NULL, NULL);
 		if (fd < 0)
 			error(1, errno, "failed to accept");
@@ -243,20 +224,6 @@ static void run_one_test(int fam_send, int fam_rcv, int proto,
 
 static void test_proto(int proto, const char *proto_str)
 {
-	if (proto == SOCK_DCCP) {
-		int test_fd;
-
-		test_fd = socket(AF_INET, proto, 0);
-		if (test_fd < 0) {
-			if (errno == ESOCKTNOSUPPORT) {
-				fprintf(stderr, "DCCP not supported: skipping DCCP tests\n");
-				return;
-			} else
-				error(1, errno, "failed to create a DCCP socket");
-		}
-		close(test_fd);
-	}
-
 	fprintf(stderr, "%s IPv4 ... ", proto_str);
 	run_one_test(AF_INET, AF_INET, proto, IP4_ADDR);
 
@@ -271,7 +238,6 @@ int main(void)
 {
 	test_proto(SOCK_DGRAM, "UDP");
 	test_proto(SOCK_STREAM, "TCP");
-	test_proto(SOCK_DCCP, "DCCP");
 
 	fprintf(stderr, "SUCCESS\n");
 	return 0;
-- 
2.48.1


