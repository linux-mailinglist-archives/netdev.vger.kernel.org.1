Return-Path: <netdev+bounces-156609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5EA07224
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7664118886BF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10ED217F41;
	Thu,  9 Jan 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yUPCQ4Qe"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAA21660B
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416143; cv=none; b=LJCsTAghR0Pero+7TnnNpBUMR3MMQZ46qB20OJCSReplrWnlGmGPATAKOdt0bpoLiDGyDDWpxuVaaN9gbfnx7Ly1pbTUS7NfXihvwA8eoKlxvStAhebwBxB0Y9XwgdSvjF51vEpJJccPen3r8neRrPrC+CVk7qR5pcAbvwK1KhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416143; c=relaxed/simple;
	bh=pCEC/HPEGRzQmMXSabveXivQE1m2lBibgdi30ms1znE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwrA39ee3czD+jY9eCjk+HhuP7DJUlURYRMuny7rFCdrF5WyOWW7jBMS++fxpuwC0+RxOQNfZ2mtLn05uHp8uqnzJ1umDZrGoZFEqxMlK22KxFieXqoFMOxDBoctsBkIbQL8Yar54/L3RuO3LBJkK+jFgjnpIRb5g9XmVtv1Qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yUPCQ4Qe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 492432087C;
	Thu,  9 Jan 2025 10:48:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-DHrr7LpFKy; Thu,  9 Jan 2025 10:48:58 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 544552006C;
	Thu,  9 Jan 2025 10:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 544552006C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736416137;
	bh=n85Ng68u4vzYYsh9/x+scc73/kdorqcppFA5LeHTy0Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=yUPCQ4QeyZt8Zop9KjweGSMnvgMIARjD8VQupZoiE3l9qHn9EzLGZNwLB33eKhO6Q
	 YV+p84jeYd5duDYWND3qaqXvWiZNlam7CNfDYR94nB5USftfj8h8vUJbvSqlhEfgMU
	 y5LkrEzubClGuuv3HD1rAtwchGfObxnJ8ly59IKicNxdhC5jrnL2DemhPxdvXj5fdL
	 yVW+U0LPa/x6n6vU4GQXufLSZOuK6KUy3hlWBev29pl6ifokKOLOd3vJ6bpkJi7d6d
	 q91zssvuz4/TrpkHADJ6Lzci0fQb9Ov10xd/wUqCLIFEqMe0vSSkUlt62uCiyY6GM3
	 Cy9tO4dWQ4kLw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:48:57 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:48:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9403E3183F5B; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/17] xfrm: iptfs: add new iptfs xfrm mode impl
Date: Thu, 9 Jan 2025 10:43:10 +0100
Message-ID: <20250109094321.2268124-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109094321.2268124-1-steffen.klassert@secunet.com>
References: <20250109094321.2268124-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Christian Hopps <chopps@labn.net>

Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.

This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
functionality. This functionality can be used to increase bandwidth
utilization through small packet aggregation, as well as help solve PMTU
issues through it's efficient use of fragmentation.

  Link: https://www.rfc-editor.org/rfc/rfc9347.txt

Multiple commits follow to build the functionality into xfrm_iptfs.c

Signed-off-by: Christian Hopps <chopps@labn.net>
Tested-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/Makefile     |   1 +
 net/xfrm/xfrm_iptfs.c | 216 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+)
 create mode 100644 net/xfrm/xfrm_iptfs.c

diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index 512e0b2f8514..5a1787587cb3 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -21,5 +21,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
 obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
 obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
 obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
+obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
 obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
 obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
new file mode 100644
index 000000000000..e7cb8734fc0f
--- /dev/null
+++ b/net/xfrm/xfrm_iptfs.c
@@ -0,0 +1,216 @@
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
+/**
+ * struct xfrm_iptfs_config - configuration for the IPTFS tunnel.
+ * @pkt_size: size of the outer IP packet. 0 to use interface and MTU discovery,
+ *	otherwise the user specified value.
+ */
+struct xfrm_iptfs_config {
+	u32 pkt_size;	    /* outer_packet_size or 0 */
+};
+
+/**
+ * struct xfrm_iptfs_data - mode specific xfrm state.
+ * @cfg: IPTFS tunnel config.
+ * @x: owning SA (xfrm_state).
+ * @payload_mtu: max payload size.
+ */
+struct xfrm_iptfs_data {
+	struct xfrm_iptfs_config cfg;
+
+	/* Ingress User Input */
+	struct xfrm_state *x;	    /* owning state */
+	u32 payload_mtu;	    /* max payload size */
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
+ *
+ * Return: 0 on success or a negative error code on failure
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
+	if (x->dir == XFRM_SA_DIR_OUT)
+		l += nla_total_size(sizeof(xc->pkt_size));
+
+	return l;
+}
+
+static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct xfrm_iptfs_config *xc = &xtfs->cfg;
+	int ret = 0;
+
+	if (x->dir == XFRM_SA_DIR_OUT)
+		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
+
+	return ret;
+}
+
+static void __iptfs_init_state(struct xfrm_state *x,
+			       struct xfrm_iptfs_data *xtfs)
+{
+	/* Modify type (esp) adjustment values */
+
+	if (x->props.family == AF_INET)
+		x->props.header_len += sizeof(struct iphdr) + sizeof(struct ip_iptfs_hdr);
+	else if (x->props.family == AF_INET6)
+		x->props.header_len += sizeof(struct ipv6hdr) + sizeof(struct ip_iptfs_hdr);
+	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
+
+	/* Always keep a module reference when x->mode_data is set */
+	__module_get(x->mode_cbs->owner);
+
+	x->mode_data = xtfs;
+	xtfs->x = x;
+}
+
+static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
+{
+	struct xfrm_iptfs_data *xtfs;
+
+	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
+	if (!xtfs)
+		return -ENOMEM;
+
+	x->mode_data = xtfs;
+	xtfs->x = x;
+
+	return 0;
+}
+
+static int iptfs_init_state(struct xfrm_state *x)
+{
+	struct xfrm_iptfs_data *xtfs;
+
+	if (x->mode_data) {
+		/* We have arrived here from xfrm_state_clone() */
+		xtfs = x->mode_data;
+	} else {
+		xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
+		if (!xtfs)
+			return -ENOMEM;
+	}
+
+	__iptfs_init_state(x, xtfs);
+
+	return 0;
+}
+
+static void iptfs_destroy_state(struct xfrm_state *x)
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
+	.init_state = iptfs_init_state,
+	.clone_state = iptfs_clone_state,
+	.destroy_state = iptfs_destroy_state,
+	.user_init = iptfs_user_init,
+	.copy_to_user = iptfs_copy_to_user,
+	.sa_len = iptfs_sa_len,
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
+MODULE_DESCRIPTION("IP-TFS support for xfrm ipsec tunnels");
-- 
2.34.1


