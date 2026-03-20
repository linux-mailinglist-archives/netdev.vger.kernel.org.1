Return-Path: <netdev+bounces-269809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEM1ObH1vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:22:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6242D6894
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32F543012B4A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95035B626;
	Fri, 20 Mar 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l6KY6N+1"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248C35C1AD
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991338; cv=none; b=GR8i4UyiN9GkCUlUrArin4mLb00uOMcmjAImIhwBEetCfTOyaZkzAGAiCBatF5Vy+Qph4vqo98SRBciLLKLVyZCmPUg+kkhvbCZ8uzFwUjr3dj+lZZ16E1OyK5M7q0PlNH1fBZPD4p3f/rI75bipIZkmSmlKKUyImjdMWSAcieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991338; c=relaxed/simple;
	bh=7e11Rzezl2KDjcTyl1P9NIZgWk2RomPzHy1FDC7uNv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNAjZy/wRaEBkvu0HE0EV7xux6STqdO9LIMGdIN2oH3b4mA5UeSDfBVLZJjFbPlTzSuKG6hu7uvPJ+FSRUUX66gDdYX02yvjpYhfTEgwj5/Nt+kKbcywp06aWjb66+l4YM4PpEJfyavVsIDpAzeIAiGp2oWx55JJ8zabuHA4qIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l6KY6N+1; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773991335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuM6ZDfBtwkarCW76CZ0oiAYb2DsFaCVZvlmDq14wkk=;
	b=l6KY6N+1HdNRwdQu6L3pDItnls13HfjoZtSImh1Mi+QbCijSQQPnOsmZEpxmGoiy4a6RbW
	Ak0znyySyP5mL9q35NAzSu1VKNf1t2VZgqPRwFRRvyXz41QVqFfQV3rwkxHbLGbq1xlApG
	MQSJbASqvkMdWyXwH1u9w7enV7zeCSU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/2] selftests: team: add non-Ethernet header_ops reproducer
Date: Fri, 20 Mar 2026 15:21:27 +0800
Message-ID: <20260320072139.134249-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260320072139.134249-1-jiayuan.chen@linux.dev>
References: <20260320072139.134249-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269809-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.658];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,non_ether_header_ops.sh:url,shopee.com:email,syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C6242D6894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a team selftest that sets up:
  g0 (gre) -> b0 (bond) -> t0 (team)

and triggers IPv6 traffic on t0. This reproduces the non-Ethernet
header_ops confusion scenario and protects against regressions in stacked
team/bond/gre configurations.

Using this script, the panic reported by syzkaller can be reproduced [1].

After the fix:

  # ./non_ether_header_ops.sh
  PASS: non-Ethernet header_ops stacking did not crash

[1] https://syzkaller.appspot.com/bug?extid=3d8bc31c45e11450f24c

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../selftests/drivers/net/team/Makefile       |  1 +
 .../testing/selftests/drivers/net/team/config |  2 +
 .../drivers/net/team/non_ether_header_ops.sh  | 41 +++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/team/non_ether_header_ops.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 45a3e7ad3dcb..02d6f51d5a06 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -3,6 +3,7 @@
 
 TEST_PROGS := \
 	dev_addr_lists.sh \
+	non_ether_header_ops.sh \
 	options.sh \
 	propagation.sh \
 	refleak.sh \
diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
index 558e1d0cf565..5d36a22ef080 100644
--- a/tools/testing/selftests/drivers/net/team/config
+++ b/tools/testing/selftests/drivers/net/team/config
@@ -1,7 +1,9 @@
+CONFIG_BONDING=y
 CONFIG_DUMMY=y
 CONFIG_IPV6=y
 CONFIG_MACVLAN=y
 CONFIG_NETDEVSIM=m
+CONFIG_NET_IPGRE=y
 CONFIG_NET_TEAM=y
 CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
 CONFIG_NET_TEAM_MODE_LOADBALANCE=y
diff --git a/tools/testing/selftests/drivers/net/team/non_ether_header_ops.sh b/tools/testing/selftests/drivers/net/team/non_ether_header_ops.sh
new file mode 100755
index 000000000000..948a43576bdc
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/non_ether_header_ops.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2154
+#
+# Reproduce the non-Ethernet header_ops confusion scenario with:
+#   g0 (gre) -> b0 (bond) -> t0 (team)
+#
+# Before the fix, direct header_ops inheritance in this stack could call
+# callbacks with the wrong net_device context and crash.
+
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/lib.sh
+
+trap cleanup_all_ns EXIT
+
+setup_ns ns1
+
+ip -n "$ns1" link add d0 type dummy
+ip -n "$ns1" addr add 10.10.10.1/24 dev d0
+ip -n "$ns1" link set d0 up
+
+ip -n "$ns1" link add g0 type gre local 10.10.10.1
+ip -n "$ns1" link add b0 type bond mode active-backup
+ip -n "$ns1" link add t0 type team
+
+ip -n "$ns1" link set g0 master b0
+ip -n "$ns1" link set b0 master t0
+
+ip -n "$ns1" link set g0 up
+ip -n "$ns1" link set b0 up
+ip -n "$ns1" link set t0 up
+
+# IPv6 address assignment triggers MLD join reports that call
+# dev_hard_header() on t0, exercising the inherited header_ops path.
+ip -n "$ns1" -6 addr add 2001:db8:1::1/64 dev t0 nodad
+for i in $(seq 1 20); do
+	ip netns exec "$ns1" ping -6 -I t0 ff02::1 -c1 -W1 &>/dev/null || true
+done
+
+echo "PASS: non-Ethernet header_ops stacking did not crash"
+exit "$EXIT_STATUS"
-- 
2.43.0


