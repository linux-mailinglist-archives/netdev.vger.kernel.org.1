Return-Path: <netdev+bounces-268651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKqTOghwuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D22ACC90
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8193081B28
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62824343D8F;
	Tue, 17 Mar 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6Mc+jdN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9066376BEF
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760199; cv=none; b=KZIb/g7GJdi+OAx2paE7DNUZiXczQCfsAE3uVT3RcHIk36D0yk7ffH9zxDac7q2++iZqOAS0bxxLM1gHuvV4H9Z+wCzYWVi+uivLl79gBh9ygyBSKgBVZMXl9C2TGtkbZ0RShfN2zSbHILCLeMb8svPiSFnfPG8yC1BCQvuETYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760199; c=relaxed/simple;
	bh=Fq4+KYcL+UFd5S26Y73OKCYQdfW8k4MUq9aDQJOPRos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ResadDkBf5oZGYb6t9FwWW6EJEKQoaSzas2LAzhg8xZfspG7o/YoP4Vd2JcjOh9Nsqy+uMpeiLs4aWDkNLqqwM5f5hKG2klS8BTvEKm0bmZcxfmEHA77xFZSxixRLkK/JnDd0BWouhVDZJdACsOoDl1s0wEuDKC4z01g65kOsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6Mc+jdN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urZT80kmbBf/sRUEoGpuGzXVffnk/j4HfuNsSj3tdCI=;
	b=a6Mc+jdNjVceKV5noTQAoNgOTL8gicp49pi/TGdDLxoLBnYYAZ9I3rbukBBmEU5DKnn3O/
	vpnfhS8I+HehT60MFqOUNOQdW9zB/g4H/CGzF1UoX2wlEOQelNqRQT+OrrjTdLOX3TB4p8
	Ixp61a5tohqzmkn81YKqvfFTZocIJXU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-6W5SlNiJO-S2eWt8R73Svg-1; Tue,
 17 Mar 2026 11:09:53 -0400
X-MC-Unique: 6W5SlNiJO-S2eWt8R73Svg-1
X-Mimecast-MFC-AGG-ID: 6W5SlNiJO-S2eWt8R73Svg_1773760189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B9F719560B8;
	Tue, 17 Mar 2026 15:09:49 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04E4819540C4;
	Tue, 17 Mar 2026 15:09:45 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/3] netdevsim: move TC offload code to a dedicated file
Date: Tue, 17 Mar 2026 16:06:08 +0100
Message-ID: <b7881fd53f8a5d8eff4eae8121576c3cd60c2ed7.1773759815.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773759815.git.dcaratti@redhat.com>
References: <cover.1773759815.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268651-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: AC1D22ACC90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This commit has no functional change.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 drivers/net/netdevsim/Makefile    |  2 +-
 drivers/net/netdevsim/netdev.c    | 51 ---------------------------
 drivers/net/netdevsim/netdevsim.h |  3 ++
 drivers/net/netdevsim/tc.c        | 57 +++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 52 deletions(-)
 create mode 100644 drivers/net/netdevsim/tc.c

diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
index 14a553e000ec..87718204fb4d 100644
--- a/drivers/net/netdevsim/Makefile
+++ b/drivers/net/netdevsim/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_NETDEVSIM) += netdevsim.o
 
 netdevsim-objs := \
-	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o
+	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o tc.o
 
 ifeq ($(CONFIG_BPF_SYSCALL),y)
 netdevsim-objs += \
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c62..1dc2f8c0695d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -199,12 +199,6 @@ static int nsim_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static int
-nsim_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
-{
-	return nsim_bpf_setup_tc_block_cb(type, type_data, cb_priv);
-}
-
 static int nsim_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
 {
 	struct netdevsim *ns = netdev_priv(dev);
@@ -335,51 +329,6 @@ static int nsim_set_vf_link_state(struct net_device *dev, int vf, int state)
 	return 0;
 }
 
-static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
-{
-	stats->window_drops = 0;
-	stats->tx_overruns = 0;
-}
-
-static int nsim_setup_tc_taprio(struct net_device *dev,
-				struct tc_taprio_qopt_offload *offload)
-{
-	int err = 0;
-
-	switch (offload->cmd) {
-	case TAPRIO_CMD_REPLACE:
-	case TAPRIO_CMD_DESTROY:
-		break;
-	case TAPRIO_CMD_STATS:
-		nsim_taprio_stats(&offload->stats);
-		break;
-	default:
-		err = -EOPNOTSUPP;
-	}
-
-	return err;
-}
-
-static LIST_HEAD(nsim_block_cb_list);
-
-static int
-nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
-{
-	struct netdevsim *ns = netdev_priv(dev);
-
-	switch (type) {
-	case TC_SETUP_QDISC_TAPRIO:
-		return nsim_setup_tc_taprio(dev, type_data);
-	case TC_SETUP_BLOCK:
-		return flow_block_cb_setup_simple(type_data,
-						  &nsim_block_cb_list,
-						  nsim_setup_tc_block_cb,
-						  ns, ns, true);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 static int
 nsim_set_features(struct net_device *dev, netdev_features_t features)
 {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..c904e14f6b3f 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -455,6 +455,9 @@ static inline void
 nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext) {}
 #endif
 
+int nsim_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		  void *type_data);
+
 struct nsim_bus_dev {
 	struct device dev;
 	struct list_head list;
diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
new file mode 100644
index 000000000000..8a1960f5f99e
--- /dev/null
+++ b/drivers/net/netdevsim/tc.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+#include "netdevsim.h"
+
+static int
+nsim_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
+{
+	return nsim_bpf_setup_tc_block_cb(type, type_data, cb_priv);
+}
+
+static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
+{
+	stats->window_drops = 0;
+	stats->tx_overruns = 0;
+}
+
+static int nsim_setup_tc_taprio(struct net_device *dev,
+				struct tc_taprio_qopt_offload *offload)
+{
+	int err = 0;
+
+	switch (offload->cmd) {
+	case TAPRIO_CMD_REPLACE:
+	case TAPRIO_CMD_DESTROY:
+		break;
+	case TAPRIO_CMD_STATS:
+		nsim_taprio_stats(&offload->stats);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+static LIST_HEAD(nsim_block_cb_list);
+
+int
+nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return nsim_setup_tc_taprio(dev, type_data);
+	case TC_SETUP_BLOCK:
+		return flow_block_cb_setup_simple(type_data,
+						  &nsim_block_cb_list,
+						  nsim_setup_tc_block_cb,
+						  ns, ns, true);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
-- 
2.52.0


