Return-Path: <netdev+bounces-211812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF91B1BC31
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D18185A69
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742C29616A;
	Tue,  5 Aug 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I85WRRYd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B090292B2B
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430755; cv=none; b=WmRDk9QIq8m07E8RMucxCGY5egjI1kRFfqYRKEzHTabSzuU//+cewS/CvBZfXxqrFgpMmZRzAHAxDRLbmo5PVnQhEtHOOjYMfsKq3V2AmusSgSm/9u85QugeF88R+j/vGYO12+hgu9dyCBDmtHxQkC4SWAnz6opYVq3nH8UK2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430755; c=relaxed/simple;
	bh=7dnrdtbKyGFiaqYBltiWE9wtIcqVKUp1hODCsFQQrJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwu37IqV+Ptc7xmWf6LI9PSXIG4TUQ3Jt5ZmLJ086qKC3d4kV0pzrT7tKN6eZzd8/HhJry/JeMkdacKH2UhbkB3p5myvG8M39f0mtvkTXPaYBPHi245IRAoHdbpasOpy+3snpm87j3/+Hl4p8Dj3ze3A2pftkWDHuzsN9yJmoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I85WRRYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754430752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qmrCLyyu9Yze1ajg0xQIFq16CNCCNzVShP1QbmOTYI=;
	b=I85WRRYddpI9pk3k9Pqh2Q1FbhyCPkAAkfHZ+GZZg5Oic4fcFn3293tpPfhQyGtm5HGV1G
	DiGAU0bP2nF2PeaWfwvVl/bT3FmCtWXzVRVPfR2U8eXlWMxCOQOT0InRrbxCyaEXmmQuat
	IOyZMWZd9lY62OaU7Q269kwp0KjDNYc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-fg8bPuD6NwacrVQh--J9Ng-1; Tue,
 05 Aug 2025 17:52:29 -0400
X-MC-Unique: fg8bPuD6NwacrVQh--J9Ng-1
X-Mimecast-MFC-AGG-ID: fg8bPuD6NwacrVQh--J9Ng_1754430748
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E883D1955F04;
	Tue,  5 Aug 2025 21:52:27 +0000 (UTC)
Received: from lima-lima (unknown [10.22.80.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73CC63000199;
	Tue,  5 Aug 2025 21:52:26 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: netdev@vger.kernel.org
Cc: dechen@redhat.com,
	dchen27@ncsu.edu,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com
Subject: [PATCH net-next 3/3] selftests: netdevsim: Add test for ethtool stats
Date: Tue,  5 Aug 2025 17:33:56 -0400
Message-ID: <20250805213356.3348348-4-dechen@redhat.com>
In-Reply-To: <20250805213356.3348348-3-dechen@redhat.com>
References: <20250805213356.3348348-1-dechen@redhat.com>
 <20250805213356.3348348-2-dechen@redhat.com>
 <20250805213356.3348348-3-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a test that verifies ethtool correctly exposes driver-specific
stats.

Signed-off-by: Dennis Chen <dechen@redhat.com>
---
 .../selftests/drivers/net/netdevsim/Makefile  |  1 +
 .../drivers/net/netdevsim/ethtool-common.sh   | 13 +++++++
 .../drivers/net/netdevsim/ethtool-stats.sh    | 36 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-stats.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index 07b7c46d3311..67055a403e74 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS = devlink.sh \
 	ethtool-fec.sh \
 	ethtool-pause.sh \
 	ethtool-ring.sh \
+	ethtool-stats.sh \
 	fib.sh \
 	fib_notifications.sh \
 	hw_stats_l3.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
index 80160579e0cc..556ff74f443d 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
@@ -42,6 +42,19 @@ function check {
     ((num_passes++))
 }
 
+function check_code {
+    local code=$1
+    local msg=$2
+
+    if ((err)); then
+    echo -e $msg
+    ((num_errors++))
+    return
+    fi
+
+    ((num_passes++))
+}
+
 function make_netdev {
     # Make a netdevsim
     old_netdevs=$(ls /sys/class/net)
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-stats.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-stats.sh
new file mode 100755
index 000000000000..281bc24ddcd2
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-stats.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source ethtool-common.sh
+
+set -o pipefail
+
+NSIM_NETDEV=$(make_netdev)
+MOCK_STATS_DFS=$NSIM_DEV_DFS/ethtool/mock_stats/enabled
+
+echo y > $MOCK_STATS_DFS
+
+stat=$(ethtool -S $NSIM_NETDEV | grep "hw_out_of_buffer" | awk '{print $2}')
+((stat == 0))
+check_code $? "ethtool stats show > 0 packets immediately after enabling"
+
+sleep 2.5
+
+stat=$(ethtool -S $NSIM_NETDEV | grep "hw_out_of_buffer" | awk '{print $2}')
+((stat >= 20))
+check_code $? "ethtool stats show < 20 packets after 2.5s passed"
+
+echo n > $MOCK_STATS_DFS
+echo y > $MOCK_STATS_DFS
+
+stat=$(ethtool -S $NSIM_NETDEV | grep "hw_out_of_buffer" | awk '{print $2}')
+((stat == 0))
+check_code $? "ethtool stats show > 0 packets after disabling and re-enabling"
+
+if [ $num_errors -eq 0 ]; then
+    echo "PASSED all $((num_passes)) checks"
+    exit 0
+else
+    echo "FAILED $num_errors/$((num_errors+num_passes)) checks"
+    exit 1
+fi
-- 
2.50.1


