Return-Path: <netdev+bounces-264594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBJ7HZUZqmkqLQEAu9opvQ
	(envelope-from <netdev+bounces-264594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:02:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C6219A4F
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9309A303C5B9
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A221D3F2;
	Fri,  6 Mar 2026 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tEfZet3u"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7D2253A1;
	Fri,  6 Mar 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755317; cv=none; b=o7Io5jtrZe1VUOOy9N5SNe/jII2UFKO0a53MYgcfupwFb0P5suApLY87V3pd9RbpFulwuEVtpWpKH2ZgRj8fruQORAP7tvwPJO68Pm3IvMrkY3kR0h2pz9s6GAwJaSLyVQ7Nli6wFnW8gLHKAxcmyMLOpc4umh85zpPbEevLZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755317; c=relaxed/simple;
	bh=HhABws9VtrB1n3AbbwLetzTMyAAfLcDTo08zkvKQMQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3NWdExoJ1We5b6Hrq6xAW36ss6yfhLzWdau8QQDI07D4JXwkV8943FxxcV+kyIhh+Vu20j3iF8TS9V4RIWR175h+aUmW+Xco158Nfj4ED+4XmNRnqqheST/BfS3QQC+nXnVaxhhruiy1EjVtoNwnQNoTsEECn67xaEkqmycq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=tEfZet3u; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=korn0yTDSXFwIp6ed9M6g4Gy/Z6W4bLaSV37nGpGjqo=; b=tEfZet3uFCcg
	EzIyvsae5Ob3E+N/UZfSG1YCL+tnx6zLQ2oZdSFk1otP8bi0MTgi/TWi1qUWTcEUxLqzwGlmJBrmE
	qQMKn6E1kQeJFS5qE7o5cXQh4a1+a897VPawu5JpENW5SQpkrn33RYXTZEDx3s08luNoYY59Vf10a
	eGL7jPkFSs71fmjEjYvlXHCCiwLMr+V9/rP7NzuvzoLcNuAHhiVTExI4vGMkvBa+icfgmdlEKPyaT
	BPnXZnkJLwEFRY0Dgi5+Rd8fVhPHHFQ/spVcRtXJPTTxdDfNFJQ8AABdW6jUzIyy1Z37fa6DyLUe5
	Jd7iDhkKZjMOrsISy76CmA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vyIbq-006Fp8-1w;
	Fri, 06 Mar 2026 01:01:33 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 62601Zpv519099
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Mar 2026 00:01:35 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 62601ZAa519098;
	Fri, 6 Mar 2026 00:01:35 GMT
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
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH net v3 3/6] selftests: net: run reuseport tests in netns to avoid port conflicts
Date: Fri,  6 Mar 2026 00:01:24 +0000
Message-ID: <20260306000127.519064-4-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
References: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E45C6219A4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264594-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Konstantin Khorenko <khorenko@virtuozzo.com>

Some net kselftests use fixed ports which overlap with process-exporter
service already running on the host. When such a conflict happens,
the test fail with:

  failed to bind receive socket: Address already in use

Instead of changing port numbers, run the affected tests in isolated
network namespace to avoid conflicts with running daemons.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 tools/testing/selftests/net/Makefile               | 12 ++++++++----
 tools/testing/selftests/net/reuseport_bpf.sh       |  4 ++++
 tools/testing/selftests/net/reuseport_bpf_cpu.sh   |  4 ++++
 tools/testing/selftests/net/reuseport_bpf_numa.sh  |  4 ++++
 tools/testing/selftests/net/reuseport_dualstack.sh |  4 ++++
 5 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/net/reuseport_bpf.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf_cpu.sh
 create mode 100755 tools/testing/selftests/net/reuseport_bpf_numa.sh
 create mode 100755 tools/testing/selftests/net/reuseport_dualstack.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 605c54c0e8a3..8935967ad448 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -67,6 +67,10 @@ TEST_PROGS := \
 	psock_snd.sh \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
+	reuseport_bpf.sh \
+	reuseport_bpf_cpu.sh \
+	reuseport_bpf_numa.sh \
+	reuseport_dualstack.sh \
 	route_hint.sh \
 	route_localnet.sh \
 	rps_default_mask.sh \
@@ -145,6 +149,10 @@ TEST_GEN_FILES := \
 	psock_tpacket \
 	reuseaddr_ports_exhausted \
 	reuseport_addr_any \
+	reuseport_bpf \
+	reuseport_bpf_cpu \
+	reuseport_bpf_numa \
+	reuseport_dualstack \
 	rxtimestamp \
 	sctp_hello \
 	skf_net_off \
@@ -173,10 +181,6 @@ TEST_GEN_PROGS := \
 	ipv6_fragmentation \
 	proc_net_pktgen \
 	reuseaddr_conflict \
-	reuseport_bpf \
-	reuseport_bpf_cpu \
-	reuseport_bpf_numa \
-	reuseport_dualstack \
 	sk_bind_sendto_listen \
 	sk_connect_zero_addr \
 	sk_so_peek_off \
diff --git a/tools/testing/selftests/net/reuseport_bpf.sh b/tools/testing/selftests/net/reuseport_bpf.sh
new file mode 100755
index 000000000000..75014a5462a1
--- /dev/null
+++ b/tools/testing/selftests/net/reuseport_bpf.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+./in_netns.sh ./reuseport_bpf
diff --git a/tools/testing/selftests/net/reuseport_bpf_cpu.sh b/tools/testing/selftests/net/reuseport_bpf_cpu.sh
new file mode 100755
index 000000000000..243dc5bee014
--- /dev/null
+++ b/tools/testing/selftests/net/reuseport_bpf_cpu.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+./in_netns.sh ./reuseport_bpf_cpu
diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.sh b/tools/testing/selftests/net/reuseport_bpf_numa.sh
new file mode 100755
index 000000000000..eccab95a3202
--- /dev/null
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+./in_netns.sh ./reuseport_bpf_numa
diff --git a/tools/testing/selftests/net/reuseport_dualstack.sh b/tools/testing/selftests/net/reuseport_dualstack.sh
new file mode 100755
index 000000000000..82cc8e345a83
--- /dev/null
+++ b/tools/testing/selftests/net/reuseport_dualstack.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+./in_netns.sh ./reuseport_dualstack
-- 
2.43.0


