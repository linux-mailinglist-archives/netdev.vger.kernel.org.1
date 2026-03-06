Return-Path: <netdev+bounces-264596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP55OIQaqmkqLQEAu9opvQ
	(envelope-from <netdev+bounces-264596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:06:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA56219AE0
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11B583130912
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917F1D5141;
	Fri,  6 Mar 2026 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QTuGlxsr"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983A1D5AD4;
	Fri,  6 Mar 2026 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755323; cv=none; b=HDBQgi/OTSydrh5oWOesBnj6ndssCdznO1xRmbKL0O8TDV2ZaWbC3PE70rB/nIxAYhjLoaK8xFryUZ+6FJGYG02fZ5Ub961WDJgFC1J/pS/obXKu9quwGQ0gtPFiCYbH6VC+9KyqqD2A2pzLDziBo7iMGAoTClojCgexTNU41yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755323; c=relaxed/simple;
	bh=fhTfgUIcQ3y4hKSQw3oyq2gN1XbWjUDB8bmqXhAWjqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dlv7G1hfH1LFgon/4+vX2J+ghXs+uUfGZkVl70I+tPnhL2sdOHNRTGu6OhtsLOIKsB7Md51x/6SNfdh6s/ZKNcDGGGNDGeBmeeSKu0vKXZjJalcxrg4rsDxmCUTIYg5w6nFwnxs9uyKk2BTkMNqTsud7LQAvFNSVLXThpPc9Mrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=QTuGlxsr; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=mINb8Y4urQ3Ce2/gZIEe5yET0uG5j4QIGs1pRxm5EHU=; b=QTuGlxsrnyWl
	a6AZVwKRMaNpjlrvV7beX3+TQbjdUHs3GyGEqDHDMZ5jzHSVERz7DmG6cDAU2AMImGy5mWNt+aERd
	LCEmbwg1O4EGxR3OS0DmyxO07U8mOOx1VyH6dLdxFUMkagNXD3MP5bNBahwWj3uDpZVkR8FG9sxCH
	ImibPGsYk4pA+x1Th0dqb1N07ng7H+Bwzr50t2xzMDBP+LSK6Mn2hXiHwKEGR/nDlMkGXZgJtwbHl
	BWtzrKx4MgLioXa9jQKWTkWbDIYElzYYCxDHutrpD1knICsorQ/gcX1CoTQdR1v9KWJmZv3afUit+
	61qbO2uFAlrz/5//2IEPUQ==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vyIbt-006GPD-0u;
	Fri, 06 Mar 2026 01:01:36 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 62601cNp519107
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Mar 2026 00:01:38 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 62601cNI519106;
	Fri, 6 Mar 2026 00:01:38 GMT
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
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net v3 5/6] selftests: net: run pmtu.sh in netns to avoid host firewall interference
Date: Fri,  6 Mar 2026 00:01:26 +0000
Message-ID: <20260306000127.519064-6-aleksey.oladko@virtuozzo.com>
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
X-Rspamd-Queue-Id: 8EA56219AE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264596-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pmtu.sh:url,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pmtu-test.sh:url]
X-Rspamd-Action: no action

From: Konstantin Khorenko <khorenko@virtuozzo.com>

The pmtu.sh kselftest sets up a multi-namespace test topology where the
host network itself is part of the test setup. Test packets originating
from the created namespace are expected to reach test interface created
in the host. When firewall rules are present on the host, this traffic
may be blocked, causing the test to fail.

Run the test in an isolated network namespace to avoid interference
from host firewall rules.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/Makefile     | 3 ++-
 tools/testing/selftests/net/pmtu-test.sh | 4 ++--
 tools/testing/selftests/net/pmtu.sh      | 4 ++++
 3 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/pmtu.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b9eeeffa5fd2..363cd1e2cf8e 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -63,7 +63,7 @@ TEST_PROGS := \
 	netns-name.sh \
 	netns-sysctl.sh \
 	nl_netdev.py \
-	pmtu-test.sh \
+	pmtu.sh \
 	psock_snd.sh \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
@@ -194,6 +194,7 @@ TEST_FILES := \
 	fcnal-test.sh \
 	in_netns.sh \
 	lib.sh \
+	pmtu-test.sh \
 	settings \
 # end of TEST_FILES
 
diff --git a/tools/testing/selftests/net/pmtu-test.sh b/tools/testing/selftests/net/pmtu-test.sh
index a3323c21f001..2ba6bc0252f0 100755
--- a/tools/testing/selftests/net/pmtu-test.sh
+++ b/tools/testing/selftests/net/pmtu-test.sh
@@ -976,7 +976,7 @@ setup_ovs_bridge() {
 	run_cmd ip link set ovs_br0 up
 
 	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
-	run_cmd ${ns_c} ip link set veth_A-C netns 1
+	run_cmd ${ns_c} ip link set veth_A-C netns $$
 
 	run_cmd         ip link set veth_A-C up
 	run_cmd ${ns_c} ip link set veth_C-A up
@@ -985,7 +985,7 @@ setup_ovs_bridge() {
 	setup_ovs_add_if veth_A-C
 
 	# Move veth_A-R1 to init
-	run_cmd ${ns_a} ip link set veth_A-R1 netns 1
+	run_cmd ${ns_a} ip link set veth_A-R1 netns $$
 	run_cmd ip addr add ${prefix4}.${a_r1}.1/${veth4_mask} dev veth_A-R1
 	run_cmd ip addr add ${prefix6}:${a_r1}::1/${veth6_mask} dev veth_A-R1
 	run_cmd ip link set veth_A-R1 up
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
new file mode 100755
index 000000000000..1805fa44a2de
--- /dev/null
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+./in_netns.sh ./pmtu-test.sh "$@"
-- 
2.43.0


