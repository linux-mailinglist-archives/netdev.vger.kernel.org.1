Return-Path: <netdev+bounces-101638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC008FFB56
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4F21F269A8
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892E40BF2;
	Fri,  7 Jun 2024 05:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E61C2BE
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738877; cv=none; b=RKDRD6ekVQIL4yH3T3ymVeGioVf2Uln79CwdfmK1iOKdWrq/t/ftEBXncsCD1a/Nb3nLvquo9oTTfhjVint7toxb2TeM80uLMgs9e/jneEtPg+Di+e2m5y75Rb4/NgiBLbgZxysx9vWI6tytFzlI//kpxFOC5fkFP40C0jstkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738877; c=relaxed/simple;
	bh=e4Z9kkPUYROsWK0i5A/Nu9wDlv7Qy1OWxZ9m9wE+dvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOgqVGhQbkNDaJtBQYwnoNrvfb9GKGD7pddBMaQRntiDjA1EPLiP9lciQzpjzPMy+/6kM6sAjuUUhpOaGl0T8ABi8Rl7BOT6lnAm2iRiCKSJuk5++DUaiN8SIWaeJuV0Hua/7W9Zbd8Vys6QPOoxtKeglf0DtYBnYu11Djvb45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id A444E7D12C;
	Fri,  7 Jun 2024 05:41:12 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v3 08/17] xfrm: iptfs: add new iptfs xfrm mode impl
Date: Fri,  7 Jun 2024 01:40:32 -0400
Message-ID: <20240607054041.2032352-9-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607054041.2032352-1-chopps@chopps.org>
References: <20240607054041.2032352-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.

This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
functionality. This functionality can be used to increase bandwidth
utilization through small packet aggregation, as well as help solve PMTU
issues through it's efficient use of fragmentation.

  Link: https://www.rfc-editor.org/rfc/rfc9347.txt

Multiple commits follow to build the functionality into xfrm_iptfs.c

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/Makefile     |   1 +
 net/xfrm/xfrm_iptfs.c | 226 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 net/xfrm/xfrm_iptfs.c

diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index 547cec77ba03..cd6520d4d777 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -20,5 +20,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
 obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
 obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
 obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
+obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
 obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
 obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
new file mode 100644
index 000000000000..310ac01314a5
--- /dev/null
+++ b/net/xfrm/xfrm_iptfs.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/* xfrm_iptfs: IPTFS encapsulation support
+ *
+ * April 21 2022, Christian Hopps <chopps@labn.net>
+ *
+ * Copyright (c) 2022, LabN Consulting, L.L.C.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/icmpv6.h>
+#include <net/gro.h>
+#include <net/icmp.h>
+#include <net/ip6_route.h>
+#include <net/inet_ecn.h>
+#include <net/xfrm.h>
+
+#include <crypto/aead.h>
+
+#include "xfrm_inout.h"
+
+struct xfrm_iptfs_config {
+	u32 pkt_size;			/* outer_packet_size or 0 */
+};
+
+struct xfrm_iptfs_data {
+	struct xfrm_iptfs_config cfg;
+
+	/* Ingress User Input */
+	struct xfrm_state *x;		/* owning state */
+	u32 payload_mtu;		/* max payload size */
+};
+
+/* ========================== */
+/* State Management Functions */
+/* ========================== */
+
+/**
+ * iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
+ * @x: xfrm state.
+ * @outer_mtu: the outer mtu
+ */
+static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
+{
+	struct crypto_aead *aead;
+	u32 blksize;
+
+	aead = x->data;
+	blksize = ALIGN(crypto_aead_blocksize(aead), 4);
+	return ((outer_mtu - x->props.header_len - crypto_aead_authsize(aead)) &
+		~(blksize - 1)) - 2;
+}
+
+/**
+ * iptfs_user_init() - initialize the SA with IPTFS options from netlink.
+ * @net: the net data
+ * @x: xfrm state
+ * @attrs: netlink attributes
+ * @extack: extack return data
+ */
+static int iptfs_user_init(struct net *net, struct xfrm_state *x,
+			   struct nlattr **attrs,
+			   struct netlink_ext_ack *extack)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct xfrm_iptfs_config *xc;
+
+	xc = &xtfs->cfg;
+
+	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
+		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
+		if (!xc->pkt_size) {
+			xtfs->payload_mtu = 0;
+		} else if (xc->pkt_size > x->props.header_len) {
+			xtfs->payload_mtu = xc->pkt_size - x->props.header_len;
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Packet size must be 0 or greater than IPTFS/ESP header length");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static unsigned int iptfs_sa_len(const struct xfrm_state *x)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct xfrm_iptfs_config *xc = &xtfs->cfg;
+	unsigned int l = 0;
+
+	if (x->dir == XFRM_SA_DIR_IN) {
+		l += nla_total_size(sizeof(u32)); /* drop time usec */
+		l += nla_total_size(sizeof(u16)); /* reorder window */
+	} else {
+		l += nla_total_size(sizeof(u32)); /* init delay usec */
+		l += nla_total_size(sizeof(u32)); /* max queue size */
+		l += nla_total_size(sizeof(xc->pkt_size));
+	}
+
+	return l;
+}
+
+static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct xfrm_iptfs_config *xc = &xtfs->cfg;
+	int ret;
+
+	if (x->dir == XFRM_SA_DIR_IN) {
+		ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, 0);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW, 0);
+	} else {
+		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, 0);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, 0);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
+	}
+
+	return ret;
+}
+
+static int __iptfs_init_state(struct xfrm_state *x,
+			      struct xfrm_iptfs_data *xtfs)
+{
+	/* Modify type (esp) adjustment values */
+
+	if (x->props.family == AF_INET)
+		x->props.header_len += sizeof(struct iphdr) + sizeof(struct ip_iptfs_hdr);
+	else if (x->props.family == AF_INET6)
+		x->props.header_len += sizeof(struct ipv6hdr) + sizeof(struct ip_iptfs_hdr);
+	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
+
+	/* Always have a module reference if x->mode_data is set */
+	if (!try_module_get(x->mode_cbs->owner))
+		return -EINVAL;
+
+	x->mode_data = xtfs;
+	xtfs->x = x;
+
+	return 0;
+}
+
+static int iptfs_clone(struct xfrm_state *x, struct xfrm_state *orig)
+{
+	struct xfrm_iptfs_data *xtfs;
+	int err;
+
+	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
+	if (!xtfs)
+		return -ENOMEM;
+
+	err = __iptfs_init_state(x, xtfs);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int iptfs_create_state(struct xfrm_state *x)
+{
+	struct xfrm_iptfs_data *xtfs;
+	int err;
+
+	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
+	if (!xtfs)
+		return -ENOMEM;
+
+	err = __iptfs_init_state(x, xtfs);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void iptfs_delete_state(struct xfrm_state *x)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+
+	if (!xtfs)
+		return;
+
+	kfree_sensitive(xtfs);
+
+	module_put(x->mode_cbs->owner);
+}
+
+static const struct xfrm_mode_cbs iptfs_mode_cbs = {
+	.owner = THIS_MODULE,
+	.create_state = iptfs_create_state,
+	.delete_state = iptfs_delete_state,
+	.user_init = iptfs_user_init,
+	.copy_to_user = iptfs_copy_to_user,
+	.sa_len = iptfs_sa_len,
+	.clone = iptfs_clone,
+	.get_inner_mtu = iptfs_get_inner_mtu,
+};
+
+static int __init xfrm_iptfs_init(void)
+{
+	int err;
+
+	pr_info("xfrm_iptfs: IPsec IP-TFS tunnel mode module\n");
+
+	err = xfrm_register_mode_cbs(XFRM_MODE_IPTFS, &iptfs_mode_cbs);
+	if (err < 0)
+		pr_info("%s: can't register IP-TFS\n", __func__);
+
+	return err;
+}
+
+static void __exit xfrm_iptfs_fini(void)
+{
+	xfrm_unregister_mode_cbs(XFRM_MODE_IPTFS);
+}
+
+module_init(xfrm_iptfs_init);
+module_exit(xfrm_iptfs_fini);
+MODULE_LICENSE("GPL");
-- 
2.45.2


