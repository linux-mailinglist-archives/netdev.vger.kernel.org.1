Return-Path: <netdev+bounces-251648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNwtFc8NcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:20:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B797C4DB3F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C07205AE177
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072AB413239;
	Tue, 20 Jan 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nrGk7IGG"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A083F23C2;
	Tue, 20 Jan 2026 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950380; cv=none; b=ch2DmtDUph3hpi/cTv9ZOZ1T38LGmiVeJ9z86wT1Is91pKvzaWNs3l8ubS24djp4UD/DozvL1DmTXmM7tkkKS/ww+QHkCCpjhgnqucw20yi9t92U6Vj7FUQYQgI/2n4QmJOUvbYv3+XJDvSdfYFfMECMzdidUkICvQJaM+s9sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950380; c=relaxed/simple;
	bh=kG0DFN6CxRYRGm89iojhHsVoORMw2BVOr7qSQCqG7mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmWURyBXVlV61l53/B+XbqUKFBAz3uxkR+xstXNyiBPrhh/D2l1w9jsNPzb+MqnNcgHCr9xwQUADpeGE9CqEO1mKDPeCwVhebuHQjXdXq05ksZ2+l0LS9iki2/p7MSnjMEtstHarPw9zNz/HrO60vNUgnRdewgbimf344gtO0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=nrGk7IGG; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=5kp5amFk0WvUViKQl4hXNv+X4iisrwrDGiUpdJQxW90=; b=nrGk7IGGleis
	4bpmhRyyDcYR4Y6CTF0rhSs6a4ISu1M6AsO+aPyd/NSeoql+FYmPVr0aGwVfUUkqTHMC8fu8/vYre
	+kCvchEGLOXH2G5YeSYOEV1xLLN6aurpUWamOOCXqK1TZXiYQ9mOAaEB9tl3gevcsDUtioGmseioZ
	m+KupjRYXitwdN7a5K9KD73bnf8xgOhJymQiGSBeJls3dHGp61kjk2y0xzBbx+/+DEXC616/pKedd
	GYMOMJqh2jYb52YVpyOr5Ekq876hWF4HQDpYE0eZaBhxVsxCthfrMLRmMIE34OlJl91GBmJy9NyKB
	2V27GOqycwsLNfUhFIFDSA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKnA-00Fnsx-18;
	Wed, 21 Jan 2026 00:06:04 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN6DxV328462
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:06:13 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN6Dke328461;
	Tue, 20 Jan 2026 23:06:13 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 3/5] selftests: net: run reuseport tests in netns to avoid port conflicts
Date: Tue, 20 Jan 2026 23:05:56 +0000
Message-ID: <20260120230558.328423-4-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
References: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TAGGED_FROM(0.00)[bounces-251648-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[virtuozzo.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,reuseport_bpf_cpu.sh:url,reuseport_bpf_numa.sh:url,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,reuseport_dualstack.sh:url,reuseport_bpf.sh:url]
X-Rspamd-Queue-Id: B797C4DB3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index b66ba04f19d9..a160e0d816d9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -64,6 +64,10 @@ TEST_PROGS := \
 	psock_snd.sh \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
+	reuseport_bpf.sh \
+	reuseport_bpf_cpu.sh \
+	reuseport_bpf_numa.sh \
+	reuseport_dualstack.sh
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


