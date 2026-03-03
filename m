Return-Path: <netdev+bounces-263359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JKUBc0lp2k3fAAAu9opvQ
	(envelope-from <netdev+bounces-263359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:17:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 178341F5248
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C569D302B644
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75023D5649;
	Tue,  3 Mar 2026 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdHeLzqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84001347535;
	Tue,  3 Mar 2026 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561760; cv=none; b=RpGuv4Hv5oXRom0KX0dW6pDKU2rDazXIuYTRDc1Mfr7R/QfeWhLX7pxDbKR1XRHS/OXpXgOSSGbo3yvuUbblsQt6RurUE6c/kEUvqgpuEggtdbjCBmhTOvYO9H/ETXaGGujoq1Qs+96s9lLAkm52cOrVd3mUMtOWiRPWQMleAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561760; c=relaxed/simple;
	bh=uUhxZ0J1Eu9/Ziu2SM/gMWoasgQd3w0iAby7RKC+bP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIKva7c9az4qeWSdLRrk7ULnBgnh1v1xp4sw3T+gYtbGM+7HD3MGqnud9Bnq5bhkk23J/QV9i37A6GNxZb/3bZFFjU8bzW4sStYJpbJMzOgYWBjbPCdEgWgJ9R4FZtidVII8dTVn6DHFwkwsBxolME1U7efwzPA7woZVzVYRTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdHeLzqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71047C116C6;
	Tue,  3 Mar 2026 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561760;
	bh=uUhxZ0J1Eu9/Ziu2SM/gMWoasgQd3w0iAby7RKC+bP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdHeLzqt2qcHm0AGZKHwfMzbYrzJfoO60OJwBhZHQX7GH5dlcYiTjczruaE6GRDTf
	 JMKJsZzuD24lBq51n66vv5E2hT9DI1Eu2Rp63+TZkckCYPx26ZX80p/JtngZWOusPm
	 eEtZF3E/4TFlJ1+i5p+RfjmmQsj+xQT1mzvVBSuUlQqgEwexFiqWEICJDDTRIoazvX
	 FLiYHVfaQvgEdyihPQN5O7/0WxZF9C8bWN+CAxLfuAtdZQdqE5EH4VAhutXykr8i6n
	 5/j/TfDA659CUyDUpeilUfiPtub61izZGEO0QbDm89qBpLJ1JMFcM/pz+W/V5rj/D3
	 s23h3kT/bErdQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 4/5] selftests: netdevsim: Add RSS indirection table resize test
Date: Tue,  3 Mar 2026 19:15:32 +0100
Message-ID: <20260303181535.2671734-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303181535.2671734-1-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 178341F5248
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263359-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ethtool-rss.sh:url,ethtool-common.sh:url]
X-Rspamd-Action: no action

Test fold/unfold of RSS indirection tables on channel changes
using netdevsim:

 - default table regenerates on channel change
 - periodic table folds on shrink and unfolds on grow
 - non-periodic table blocks channel reduction
 - non-default RSS context resizes on channel change
 - non-periodic non-default context blocks fold
 - table and channel count unchanged after failed reduction

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../drivers/net/netdevsim/ethtool-rss.sh      | 123 ++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-rss.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index 1a228c5430f5..d764d08dff1a 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS := \
 	ethtool-features.sh \
 	ethtool-fec.sh \
 	ethtool-pause.sh \
+	ethtool-rss.sh \
 	fib.sh \
 	fib_notifications.sh \
 	hw_stats_l3.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-rss.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-rss.sh
new file mode 100755
index 000000000000..1c1876f888ba
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-rss.sh
@@ -0,0 +1,123 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Test RSS indirection table resize on channel count changes.
+# Exercises ethtool_rxfh_indir_resize() and
+# ethtool_rxfh_contexts_resize_all() via netdevsim.
+
+source ethtool-common.sh
+
+# Create device with 8 queues
+NSIM_NETDEV=$(make_netdev 1 8)
+
+set -o pipefail
+
+# --- Test 1: Default table regenerates on channel change ---
+s=$(ethtool --json -x $NSIM_NETDEV | jq '.[0]["rss-indirection-table"] | length')
+check $? "$s" "128" # roundup_pow_of_two(8) * 16 = 128
+
+ethtool -L $NSIM_NETDEV combined 2
+s=$(ethtool --json -x $NSIM_NETDEV | jq '.[0]["rss-indirection-table"] | length')
+check $? "$s" "32" # roundup_pow_of_two(2) * 16 = 32
+
+ethtool -L $NSIM_NETDEV combined 8
+
+# --- Test 2: Periodic context 0 table folds on channel reduction ---
+ethtool -X $NSIM_NETDEV equal 2
+s=$(ethtool --json -x $NSIM_NETDEV | jq '[.[0]["rss-indirection-table"][]] | max')
+check $? "$s" "1"
+
+ethtool -L $NSIM_NETDEV combined 2
+s=$(ethtool --json -x $NSIM_NETDEV | jq '.[0]["rss-indirection-table"] | length')
+check $? "$s" "32"
+s=$(ethtool --json -x $NSIM_NETDEV | jq '[.[0]["rss-indirection-table"][]] | max')
+check $? "$s" "1"
+
+# Grow back — should unfold
+ethtool -L $NSIM_NETDEV combined 8
+s=$(ethtool --json -x $NSIM_NETDEV | jq '.[0]["rss-indirection-table"] | length')
+check $? "$s" "128"
+s=$(ethtool --json -x $NSIM_NETDEV | jq '[.[0]["rss-indirection-table"][]] | max')
+check $? "$s" "1"
+
+ethtool -X $NSIM_NETDEV default
+
+# --- Test 3: Non-periodic context 0 table blocks fold ---
+ethtool -X $NSIM_NETDEV equal 8
+
+ethtool -L $NSIM_NETDEV combined 2 2>/dev/null
+if [ $? -ne 0 ]; then
+    ((num_passes++))
+else
+    echo "Expected channel reduction to fail with non-periodic table"
+    ((num_errors++))
+fi
+
+ethtool -X $NSIM_NETDEV default
+
+# --- Test 4: Non-default context resizes on channel change ---
+ctx_id=$(ethtool -X $NSIM_NETDEV context new equal 2 2>/dev/null | awk '{print $NF}')
+if [ -z "$ctx_id" ]; then
+    echo "SKIP: context creation failed"
+else
+    s=$(ethtool --json -x $NSIM_NETDEV context $ctx_id | jq '.[0]["rss-indirection-table"] | length')
+    check $? "$s" "128"
+
+    ethtool -L $NSIM_NETDEV combined 2
+    s=$(ethtool --json -x $NSIM_NETDEV context $ctx_id | jq '.[0]["rss-indirection-table"] | length')
+    check $? "$s" "32"
+    s=$(ethtool --json -x $NSIM_NETDEV context $ctx_id | jq '[.[0]["rss-indirection-table"][]] | max')
+    check $? "$s" "1"
+
+    # Grow back
+    ethtool -L $NSIM_NETDEV combined 8
+    s=$(ethtool --json -x $NSIM_NETDEV context $ctx_id | jq '.[0]["rss-indirection-table"] | length')
+    check $? "$s" "128"
+    s=$(ethtool --json -x $NSIM_NETDEV context $ctx_id | jq '[.[0]["rss-indirection-table"][]] | max')
+    check $? "$s" "1"
+
+    ethtool -X $NSIM_NETDEV context $ctx_id delete
+fi
+
+# --- Test 5: Non-periodic non-default context blocks fold ---
+ctx_id=$(ethtool -X $NSIM_NETDEV context new equal 8 2>/dev/null | awk '{print $NF}')
+if [ -z "$ctx_id" ]; then
+    echo "SKIP: context creation failed"
+else
+    ethtool -L $NSIM_NETDEV combined 2 2>/dev/null
+    if [ $? -ne 0 ]; then
+        ((num_passes++))
+    else
+        echo "Expected channel reduction to fail with non-periodic context"
+        ((num_errors++))
+    fi
+
+    ethtool -X $NSIM_NETDEV context $ctx_id delete
+fi
+
+# --- Test 6: Table unchanged after failed channel reduction ---
+ethtool -X $NSIM_NETDEV equal 8
+s_before=$(ethtool --json -x $NSIM_NETDEV | jq '.[0]["rss-indirection-table"]')
+
+ethtool -L $NSIM_NETDEV combined 2 2>/dev/null
+s_after=$(ethtool --json -x $NSIM_NETDEV | jq '.[0]["rss-indirection-table"]')
+check $? "$s_after" "$s_before"
+
+ethtool -X $NSIM_NETDEV default
+
+# --- Test 7: Channel count unchanged after failed reduction ---
+ethtool -X $NSIM_NETDEV equal 8
+ethtool -L $NSIM_NETDEV combined 2 2>/dev/null
+s=$(ethtool --json -l $NSIM_NETDEV | jq '.[0]["combined-count"]')
+check $? "$s" "8"
+
+ethtool -X $NSIM_NETDEV default
+
+# --- Results ---
+if [ $num_errors -eq 0 ]; then
+    echo "PASSED all $((num_passes)) checks"
+    exit 0
+else
+    echo "FAILED $num_errors/$((num_errors+num_passes)) checks"
+    exit 1
+fi
-- 
2.53.0


