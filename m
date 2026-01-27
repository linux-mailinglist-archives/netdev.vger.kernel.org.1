Return-Path: <netdev+bounces-254027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JvOH5hBeWmAwAEAu9opvQ
	(envelope-from <netdev+bounces-254027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8FC9B3BB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FDF73013D6C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA852882CD;
	Tue, 27 Jan 2026 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ez+mCiHM"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256D21CC44;
	Tue, 27 Jan 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554325; cv=none; b=Cbui/rOuG8sqAhYBMIan5uBLZHEGJY87+rBkG0bkgtN5XYloG0Q6/G8wNidexzL9ATRb3/fZdK0jYc6ER+/agmZyxWwFSaytKs7TnqSp274zIgoT/iGUSPULshIKTNkYNRp43y6zF8PyGVf7WO3MAPEpSGqifb5V4wozqzCXdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554325; c=relaxed/simple;
	bh=7kWkj0+C7q8BgmM4Lz/XKazPnhAuaZXkRlwEeSr8NLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPLxyzz9nlDqiYX1xeGi15XwdZO/UAnT+ONbmbIrdM9dboQvGaOqwHZJL4V8IUp7BpKLtLe/FH8XlsZ8LM1XHEZ+chyFgosC+a8/tGfpjB0JXp79IMcHtRgbAsBVXOOf1taqsTsEbsSa6gwYiTDT23CpCcOTEewBlsybywW9dZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Ez+mCiHM; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=DuabfVWgE3sqzQgQxtkjFsuzMq6NqsoO509biuXoWWo=; b=Ez+mCiHMYZHS
	UXlieF/aRKWISraKmfHJcm4Z8hzuVuiQ6btOKRzvdGLs5On6/LMNF5V/CCialzvO6nA8HsN9LeLLB
	6hcxXLw4YMbLinIAMfqrkVDMuQP6q22MC938joO6HKIQ0aVmgBldvKVDfwFCozevZVfoWUrhjWfE7
	my9XSPzHdsi9l3eRKw5I0QiqYn2N2GCvQbHGzuTIQ7VE6Qb45tmGMuJKYAEd2vRTibzixn2w2nIjs
	SxIL6Em6Ok1l/ddzoDWHxLF3kbSgBrZ3cqdczwhzP/FTbBTYLwdDzSBIwUii/XNFMABuF+GW4BkLd
	5Wk4C5kuPnXVRa1fvsHm9g==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vkru3-0080TL-1D;
	Tue, 27 Jan 2026 23:51:49 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60RMpwpF304395
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 22:51:58 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60RMpw06304394;
	Tue, 27 Jan 2026 22:51:58 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 3/5] selftests: net: run reuseport tests in netns to avoid port conflicts
Date: Tue, 27 Jan 2026 22:51:32 +0000
Message-ID: <20260127225134.304362-4-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
References: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254027-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,reuseport_bpf_cpu.sh:url,reuseport_dualstack.sh:url]
X-Rspamd-Queue-Id: CB8FC9B3BB
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
index b66ba04f19d9..ce65763e74ef 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -64,6 +64,10 @@ TEST_PROGS := \
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
@@ -142,6 +146,10 @@ TEST_GEN_FILES := \
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
@@ -169,10 +177,6 @@ TEST_GEN_PROGS := \
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


