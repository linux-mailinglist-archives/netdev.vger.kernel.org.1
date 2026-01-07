Return-Path: <netdev+bounces-247569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0805CFBD4D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031E53045F59
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8045125C802;
	Wed,  7 Jan 2026 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Hc/2sNQK"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464634A33;
	Wed,  7 Jan 2026 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756256; cv=none; b=TqkPQm635j+OsG/NZEJ50Ruy4hTavIMWg5Mf19X5iz4KxiiC+vklfciVbgj9fd7LBtqBYjmMux0D7fh7z5Dd3WfopgPiFmGBmby8Oa/S/8/H9EKXpMKj7d5XsBjf4g0ajn4ZzGuDI/b3Lcfzpnj9nV36qkzcCKLUFROU3RP1qU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756256; c=relaxed/simple;
	bh=qYSFavTx4Bunh22tcP38Pe6RPOXmFIoFPHIv/OaWowo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1Nyn25EMjJZFJ9iIsSuXil0XRTlSvAOSQJFVW3fCxS9P1FS3st2BoB7F7EgZB7vXuNNc7CZa5vZYDFR3VkfrZHrl/500DjuGVW90D1lkMXRiSuOExAZD7riewmqcrlj/hK2kMjMDhmGHEP+OSZM1O80JcCv5ZgwmQMJ7ItmFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Hc/2sNQK; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i0wbDJ8EbrfVs8rGUwHoNmMg18inRgZDVrriqEaVpUE=;
	b=Hc/2sNQKB8vRvEYmgkARrbslVtd8ySf7X5qApQZ+uvkHq+xmNzAIksz6GSFNC+X4Hl8Hl3TCJ
	ON+oCcnOT6qHIhgveX6ukftOIY/OwB5dn4YicBz71wIUOa1TYnURRyUXWpqxiPKLu/4zAy0f6AE
	4BcnzHqesIN6/lEWm4TQOH0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dmCwp4R6Vz1K96g;
	Wed,  7 Jan 2026 11:20:58 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id C9FDA40565;
	Wed,  7 Jan 2026 11:24:11 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Jan
 2026 11:24:10 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH v2 net 2/2] selftests: vlan: add test for turn on hw offload with reorder_hdr off
Date: Wed, 7 Jan 2026 11:34:23 +0800
Message-ID: <20260107033423.1885071-3-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260107033423.1885071-1-chenzhen126@huawei.com>
References: <20260107033423.1885071-1-chenzhen126@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500008.china.huawei.com (7.202.194.93)

If vlan dev was created with reorder_hdr off and hw offload both
off but up with hw offload on, it will trigger a skb_panic bug in
vlan_dev_hard_header().

Add a test to automatically catch re-occurrence of the issue.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chen Zhen <chenzhen126@huawei.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/vlan_hw_offload.sh  | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100755 tools/testing/selftests/net/vlan_hw_offload.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..8b50448a01cd 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -113,6 +113,7 @@ TEST_PROGS := \
 	veth.sh \
 	vlan_bridge_binding.sh \
 	vlan_hw_filter.sh \
+	vlan_hw_offload.sh \
 	vrf-xfrm-tests.sh \
 	vrf_route_leaking.sh \
 	vrf_strict_mode_test.sh \
diff --git a/tools/testing/selftests/net/vlan_hw_offload.sh b/tools/testing/selftests/net/vlan_hw_offload.sh
new file mode 100755
index 000000000000..5c49cc2525f2
--- /dev/null
+++ b/tools/testing/selftests/net/vlan_hw_offload.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+setup() {
+	ip link add veth0 type veth peer name veth1
+	ip link set veth0 up
+	ip link set veth1 up
+}
+
+cleanup() {
+	ip link delete veth0 2>/dev/null
+}
+
+#turn on hw offload and set up vlan dev with reorder_hdr off
+test_vlan_hw_offload_toggle_crash() {
+	ethtool -K veth0 tx-vlan-hw-insert off
+	ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
+	ethtool -K veth0 tx-vlan-hw-insert on
+
+	# set up vlan dev and it will trigger ndisc
+	ip link set veth0.10 up
+	ip -6 route show dev veth0.10
+}
+
+trap cleanup EXIT
+
+setup
+test_vlan_hw_offload_toggle_crash
+
+exit 0
-- 
2.33.0


