Return-Path: <netdev+bounces-265589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLnYFhbnrmlzKAIAu9opvQ
	(envelope-from <netdev+bounces-265589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:28:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09923BA97
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD17E31B8932
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343C83DA7F4;
	Mon,  9 Mar 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H4asFpyc"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EBA3D9054;
	Mon,  9 Mar 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069640; cv=none; b=Mfq7eKI5cuayNgVd0me6uazLj3mL3TT3l0tsspr24U4INzPi2TucBPR6hSDiCrOWVZqiC3DbfT2o/mNtnsndsFSr6G3iFUZo7XjkfhhzAylLIf1zwphN1EyEbM1VcQ6ZgNATpYmgDxNdKu/xbDwwPFljLsAyf7NrFfKK7EdfRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069640; c=relaxed/simple;
	bh=502L+b8VhHD2hfOY+Vac3X+4b9aG5ol0a3NFHml8MFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d73MTLiJNd9F40e5rQZc5vDaN1+lUBrlOjDF64y8T4ASubpEWYUWP0v4mc3L+lR77DIXbD1xhK6NFoVJV8pMS+AAcO5BRQVV/F+qmSDNLQb+tvm8pT8rLYp0KDlzd2lWd+spilRqUza1Pf/bYvrF41EcAKJNzeQyoRtmRU0avok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=H4asFpyc; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=fyEvluQLxxf9rIozH/IQMufNdNJaWDqtGJ1Dq84TKXo=; b=H4asFpyc/Kml
	7quIJVCl7mjr8LPgrTjfdEJ4vdFB/6e2VHhUeANvysMCiX0/4mKIoF1IvWAeVG4/58kh0rx61EJg5
	O8a0/DkhCYyTJHdlL2LyDSbb2tV7wpsMGvwXoFfYHUpHytL1VD2Rp6x9jAAc1ih2vvaVwaNT5faTS
	D8bCKXH/wFqC/5pY3DkS+FlPGBJDgBuKVNGhXz4Rkx8bjid/zai5PeMigkTvPiV5KK64gtV2Fix6C
	BVmcl5x6LQkCi/8VHlCfYRzf6W2NYjkSFQheNUb/TRvYfOycNu54Lu6WTCyPfn/yY5zB31eFYrxhW
	mesDrlTuRCK6vwQ8a/zF9w==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vzcNV-006Tex-00;
	Mon, 09 Mar 2026 16:20:12 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 629FKJrT565245
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 9 Mar 2026 15:20:19 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 629FKJnr565244;
	Mon, 9 Mar 2026 15:20:19 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>,
        Ilya Maximets <imaximet@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@openvswitch.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net v4 2/5] selftests: net: run reuseport in an isolated netns
Date: Mon,  9 Mar 2026 15:20:10 +0000
Message-ID: <20260309152013.565216-3-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF09923BA97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265589-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The reuseport_* tests (bpf, bpf_cpu, bpf_numa, dualstack) currently use
a fixed port range. This can cause intermittent test failures when the
ports are already in use by other services:

  failed to bind receive socket: Address already in use

To avoid conflicts, run these tests in separate network namespaces using
unshare. Each test now has its own isolated network stack, preventing
port collisions with the host services.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/reuseport_bpf.c       | 11 +++++++++++
 tools/testing/selftests/net/reuseport_bpf_cpu.c   | 10 ++++++++++
 tools/testing/selftests/net/reuseport_bpf_numa.c  | 10 ++++++++++
 tools/testing/selftests/net/reuseport_dualstack.c | 11 +++++++++++
 4 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/selftests/net/reuseport_bpf.c
index b6634d6da3d6..12e48b97b862 100644
--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -23,6 +23,7 @@
 #include <sys/socket.h>
 #include <sys/resource.h>
 #include <unistd.h>
+#include <sched.h>
 
 #include "kselftest.h"
 
@@ -455,8 +456,18 @@ static __attribute__((destructor)) void main_dtor(void)
 	setrlimit(RLIMIT_MEMLOCK, &rlim_old);
 }
 
+static void setup_netns(void)
+{
+	if (unshare(CLONE_NEWNET))
+		error(1, errno, "failed to unshare netns");
+	if (system("ip link set lo up"))
+		error(1, 0, "failed to bring up lo interface in netns");
+}
+
 int main(void)
 {
+	setup_netns();
+
 	fprintf(stderr, "---- IPv4 UDP ----\n");
 	/* NOTE: UDP socket lookups traverse a different code path when there
 	 * are > 10 sockets in a group.  Run the bpf test through both paths.
diff --git a/tools/testing/selftests/net/reuseport_bpf_cpu.c b/tools/testing/selftests/net/reuseport_bpf_cpu.c
index 2d646174729f..ddfe92f6597a 100644
--- a/tools/testing/selftests/net/reuseport_bpf_cpu.c
+++ b/tools/testing/selftests/net/reuseport_bpf_cpu.c
@@ -228,10 +228,20 @@ static void test(int *rcv_fd, int len, int family, int proto)
 		close(rcv_fd[cpu]);
 }
 
+static void setup_netns(void)
+{
+	if (unshare(CLONE_NEWNET))
+		error(1, errno, "failed to unshare netns");
+	if (system("ip link set lo up"))
+		error(1, 0, "failed to bring up lo interface in netns");
+}
+
 int main(void)
 {
 	int *rcv_fd, cpus;
 
+	setup_netns();
+
 	cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	if (cpus <= 0)
 		error(1, errno, "failed counting cpus");
diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index 2ffd957ffb15..8ec52fc5ef41 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -230,10 +230,20 @@ static void test(int *rcv_fd, int len, int family, int proto)
 		close(rcv_fd[node]);
 }
 
+static void setup_netns(void)
+{
+	if (unshare(CLONE_NEWNET))
+		error(1, errno, "failed to unshare netns");
+	if (system("ip link set lo up"))
+		error(1, 0, "failed to bring up lo interface in netns");
+}
+
 int main(void)
 {
 	int *rcv_fd, nodes;
 
+	setup_netns();
+
 	if (numa_available() < 0)
 		ksft_exit_skip("no numa api support\n");
 
diff --git a/tools/testing/selftests/net/reuseport_dualstack.c b/tools/testing/selftests/net/reuseport_dualstack.c
index fb7a59ed759e..0eaf739d0c85 100644
--- a/tools/testing/selftests/net/reuseport_dualstack.c
+++ b/tools/testing/selftests/net/reuseport_dualstack.c
@@ -25,6 +25,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <unistd.h>
+#include <sched.h>
 
 static const int PORT = 8888;
 
@@ -156,10 +157,20 @@ static void test(int *rcv_fds, int count, int proto)
 	close(epfd);
 }
 
+static void setup_netns(void)
+{
+	if (unshare(CLONE_NEWNET))
+		error(1, errno, "failed to unshare netns");
+	if (system("ip link set lo up"))
+		error(1, 0, "failed to bring up lo interface in netns");
+}
+
 int main(void)
 {
 	int rcv_fds[32], i;
 
+	setup_netns();
+
 	fprintf(stderr, "---- UDP IPv4 created before IPv6 ----\n");
 	build_rcv_fd(AF_INET, SOCK_DGRAM, rcv_fds, 5);
 	build_rcv_fd(AF_INET6, SOCK_DGRAM, &(rcv_fds[5]), 5);
-- 
2.43.0


