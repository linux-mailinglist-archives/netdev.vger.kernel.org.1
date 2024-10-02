Return-Path: <netdev+bounces-131264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7E98DEA3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483C41C20BFD
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF1F1D0E2F;
	Wed,  2 Oct 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aml7iSbC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D971D0B87
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882088; cv=none; b=ts0QgsXy6e4xTLAzecYxTDhlWcmX+C+fB8StFpI8tDuid6EbzyN6ntAmiUBKzZn31Bl9+I8CK+Y7+eLhZAT4EX+7ddtt2u8dcJU7cEWsyl7Z7OdOH+i1mMap9fDRGHoaIeYSMih+Ob+JetiuI3EptFwY9PizUXiZ6JNQ4nmGjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882088; c=relaxed/simple;
	bh=nXoyA5NiT2twoYgdlEN0lKLLIl40A7qogCsv3T5bojc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLgMfx1GeQ+9n3u21ciy88ptw8/VBlCamrUCZuxi01m3VR2mo2ffRZeFT9C5OuHxPacTZOgdy3pGBEZitzJpRKcMpF6m7shY7OnuctBRFZ8cUvCH4GkciDNCjqkOdX3csC8i0wZ9aRKVlieVkEr/sSpQN2Px/nlNBNfxySDUTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aml7iSbC; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727882087; x=1759418087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSqAONFmkmf1dxF62PJAicMXnfeLEwQPUWty71FbROI=;
  b=aml7iSbCOnCKEpYwdf1x9sOaqr0j58OaykRE37ZU09nG2tVzxxJcEFBt
   SyvA9I46K8rQPe2AB+bpoxtmRIPXDySOKtuue2/+9Bbg4ZfEudqG9ypig
   ueBNQtwBlxFg6hJSOrJJSUg70hInHeMQ/lUUcA31X8dKeoi5MhQfTQrzF
   4=;
X-IronPort-AV: E=Sophos;i="6.11,172,1725321600"; 
   d="scan'208";a="133687407"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:14:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:11080]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.239:2525] with esmtp (Farcaster)
 id 2bd99264-49a4-4d3d-a17a-3d8351b90a96; Wed, 2 Oct 2024 15:14:30 +0000 (UTC)
X-Farcaster-Flow-ID: 2bd99264-49a4-4d3d-a17a-3d8351b90a96
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 15:14:30 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 15:14:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/4] rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.
Date: Wed, 2 Oct 2024 08:12:40 -0700
Message-ID: <20241002151240.49813-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241002151240.49813-1-kuniyu@amazon.com>
References: <20241002151240.49813-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The global and per-netns netdev notifier depend on RTNL, and its
dependency is not so clear due to nested calls.

Let's add a placeholder to place ASSERT_RTNL_NET() for each event.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/Makefile         |   1 +
 net/core/rtnl_net_debug.c | 131 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 net/core/rtnl_net_debug.c

diff --git a/net/core/Makefile b/net/core/Makefile
index c3ebbaf9c81e..5a72a87ee0f1 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
+obj-$(CONFIG_DEBUG_NET_SMALL_RTNL) += rtnl_net_debug.o
diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
new file mode 100644
index 000000000000..e90a32242e22
--- /dev/null
+++ b/net/core/rtnl_net_debug.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/notifier.h>
+#include <linux/rtnetlink.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+
+static int rtnl_net_debug_event(struct notifier_block *nb,
+				unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct net *net = dev_net(dev);
+	enum netdev_cmd cmd = event;
+
+	/* Keep enum and don't add default to trigger -Werror=switch */
+	switch (cmd) {
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_REBOOT:
+	case NETDEV_CHANGE:
+	case NETDEV_REGISTER:
+	case NETDEV_UNREGISTER:
+	case NETDEV_CHANGEMTU:
+	case NETDEV_CHANGEADDR:
+	case NETDEV_PRE_CHANGEADDR:
+	case NETDEV_GOING_DOWN:
+	case NETDEV_CHANGENAME:
+	case NETDEV_FEAT_CHANGE:
+	case NETDEV_BONDING_FAILOVER:
+	case NETDEV_PRE_UP:
+	case NETDEV_PRE_TYPE_CHANGE:
+	case NETDEV_POST_TYPE_CHANGE:
+	case NETDEV_POST_INIT:
+	case NETDEV_PRE_UNINIT:
+	case NETDEV_RELEASE:
+	case NETDEV_NOTIFY_PEERS:
+	case NETDEV_JOIN:
+	case NETDEV_CHANGEUPPER:
+	case NETDEV_RESEND_IGMP:
+	case NETDEV_PRECHANGEMTU:
+	case NETDEV_CHANGEINFODATA:
+	case NETDEV_BONDING_INFO:
+	case NETDEV_PRECHANGEUPPER:
+	case NETDEV_CHANGELOWERSTATE:
+	case NETDEV_UDP_TUNNEL_PUSH_INFO:
+	case NETDEV_UDP_TUNNEL_DROP_INFO:
+	case NETDEV_CHANGE_TX_QUEUE_LEN:
+	case NETDEV_CVLAN_FILTER_PUSH_INFO:
+	case NETDEV_CVLAN_FILTER_DROP_INFO:
+	case NETDEV_SVLAN_FILTER_PUSH_INFO:
+	case NETDEV_SVLAN_FILTER_DROP_INFO:
+	case NETDEV_OFFLOAD_XSTATS_ENABLE:
+	case NETDEV_OFFLOAD_XSTATS_DISABLE:
+	case NETDEV_OFFLOAD_XSTATS_REPORT_USED:
+	case NETDEV_OFFLOAD_XSTATS_REPORT_DELTA:
+	case NETDEV_XDP_FEAT_CHANGE:
+		ASSERT_RTNL();
+		break;
+
+	/* Once an event fully supports RTNL_NET, move it here
+	 * and remove "if (0)" below.
+	 *
+	 * case NETDEV_XXX:
+	 *	ASSERT_RTNL_NET(net);
+	 *	break;
+	 */
+	}
+
+	/* Just to avoid unused-variable error for dev and net. */
+	if (0)
+		ASSERT_RTNL_NET(net);
+
+	return NOTIFY_DONE;
+}
+
+static int rtnl_net_debug_net_id;
+
+static int __net_init rtnl_net_debug_net_init(struct net *net)
+{
+	struct notifier_block *nb;
+
+	nb = net_generic(net, rtnl_net_debug_net_id);
+	nb->notifier_call = rtnl_net_debug_event;
+
+	return register_netdevice_notifier_net(net, nb);
+}
+
+static void __net_exit rtnl_net_debug_net_exit(struct net *net)
+{
+	struct notifier_block *nb;
+
+	nb = net_generic(net, rtnl_net_debug_net_id);
+	unregister_netdevice_notifier_net(net, nb);
+}
+
+static struct pernet_operations rtnl_net_debug_net_ops __net_initdata = {
+	.init = rtnl_net_debug_net_init,
+	.exit = rtnl_net_debug_net_exit,
+	.id = &rtnl_net_debug_net_id,
+	.size = sizeof(struct notifier_block),
+};
+
+static struct notifier_block rtnl_net_debug_block = {
+	.notifier_call = rtnl_net_debug_event,
+};
+
+static int __init rtnl_net_debug_init(void)
+{
+	int ret;
+
+	ret = register_pernet_device(&rtnl_net_debug_net_ops);
+	if (ret)
+		return ret;
+
+	ret = register_netdevice_notifier(&rtnl_net_debug_block);
+	if (ret)
+		unregister_pernet_subsys(&rtnl_net_debug_net_ops);
+
+	return ret;
+}
+
+static void __exit rtnl_net_debug_exit(void)
+{
+	unregister_netdevice_notifier(&rtnl_net_debug_block);
+	unregister_pernet_device(&rtnl_net_debug_net_ops);
+}
+
+subsys_initcall(rtnl_net_debug_init);
-- 
2.30.2


