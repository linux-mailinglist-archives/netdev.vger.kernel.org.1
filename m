Return-Path: <netdev+bounces-248908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D279D10F9D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DEA030C5C87
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CDA3382E3;
	Mon, 12 Jan 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JIAbrxU4"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D93328FB;
	Mon, 12 Jan 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204200; cv=none; b=hSQTQJEhEkOCh/cIm2GzEksO/VYSvg/qYWloAmwlyeCFqsaEXUjxu+Z2Gkb5VmeKcgQh4RBobpuktOVNafWsfPO9p0eCrcFWt16r+pZduViUfL2GxBbddR8x4K17H216tIyh1CtKew3aeosBAQPQCVrhKLWxUKkutjSn0musRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204200; c=relaxed/simple;
	bh=zr+cpbgW76FANEZrnWJXeRXNoWuIFdknjGQ1xqOZS24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beykj3gdIXw/jWW67Jam82XkPbuLP0cAuJbn+UmXv/I5FahgmAMHBWF2NcXIjbvyFA1XoeP08ffrGh8InICdpXKATWhnKotostcJ5AwybROC52xj+0D/wzZjllUZFPV4bxrqX7QSS43Ay5aA3L8rz12HcTLeK6IKbtG0Mmo7Yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JIAbrxU4; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bWEhCzx9xyA3ZWKQ2WgUGddIaO+7ZeRIEJqvOKFz16c=;
	b=JIAbrxU4VhK0/bSgwAdER2BnM99VVF5jH1LFaBmeTAwvSTIMcpyRmuOR9u3MZVtoa7go+2nrb
	wyFIaycRbViIHNWaeDkJPMxB70CtdWPqvsoxoNALgrGL6BTLph5TLmzBR1sWwNABmTdAb6bpr9b
	AdOao41X2u6sju7FrAtnUuE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dqPZg1Bp4zmV8R;
	Mon, 12 Jan 2026 15:46:19 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2273A40565;
	Mon, 12 Jan 2026 15:49:38 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Jan
 2026 15:49:37 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH v3 net 2/2] selftests: vlan: add test for turn on hw offload with reorder_hdr off
Date: Mon, 12 Jan 2026 15:59:39 +0800
Message-ID: <20260112075939.2509397-3-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260112075939.2509397-1-chenzhen126@huawei.com>
References: <20260112075939.2509397-1-chenzhen126@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500008.china.huawei.com (7.202.194.93)

If vlan dev was created with reorder_hdr off and hw offload both
off but up with hw offload on, it will trigger a skb_panic bug in
vlan_dev_hard_header().

Add a test to automatically catch re-occurrence of the issue.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chen Zhen <chenzhen126@huawei.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/vlan_hw_offload.sh  | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+)
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
index 000000000000..ac7140539d95
--- /dev/null
+++ b/tools/testing/selftests/net/vlan_hw_offload.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2329
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
+# turn on hw offload and set up vlan dev with reorder_hdr off
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


