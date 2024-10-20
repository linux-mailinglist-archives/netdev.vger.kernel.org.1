Return-Path: <netdev+bounces-137323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDEB9A56CD
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66441F20FF0
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E419199230;
	Sun, 20 Oct 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG4G0Vse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E11990AE;
	Sun, 20 Oct 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729457820; cv=none; b=UJZ1/2AUtg/QxpDv0GfdBSzheWUoPeeRckgsB/cmF+m9PEqgD48pzDxC13+joD0AFAfHphjMDTfYEPPsyGFM/gdn5QU+KwYCmY/OGtAtkWUa+flXTjW8ZWWSm3N3vimS16jhyBJhNRQa/Kmw5FqviYU8Qd2N2E3OILuzvBRzYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729457820; c=relaxed/simple;
	bh=1P0mvejUHUh05yOmiNhx6KZdO0LKH7k4ejVE8CyoO68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZTwXW6zmkAw83bv/tFvJLsH+swwc62LJ7kxnC1fJ32aHMMV9ui0LN8d5626hVsziu8K9GOs+Ir9CkNVaLSs/xkEbaMbbiPvL/JtcJaozTi/XXSlxNeV9noPS7UgJ44Woihx2vFgNGnbt/Aor4Jj7hqk8jx1yk8fDahJKfrEsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG4G0Vse; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so524298866b.3;
        Sun, 20 Oct 2024 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729457815; x=1730062615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPIXr1KQ2BwKIpE8FpDOMVjF3+IVdXE9OSCBYHyQV0s=;
        b=MG4G0VselVNtv5vgnMisGXTqK7VPTlZ6Ih3+QoIYAOBEWySlBZ5lb9TkDWcol9opQc
         coi71BPrfM4k5VYHOsc9W91ZnJncWoseF+BryoeKJhH7KfTOviq4u3xjKXK3xowAKagZ
         +8mI8QkVdB0SZ//9C2PxCApxcl7QuKiU8QSs5V+ujK7MQZTwcM3332Q4A7Cfnet3J0eQ
         1xyQO6Vdn/2qwsKlDkhjMDLrl++1su0gGDEe4kfOC2yEWJPv9y32U4PM/Ch9BZ1TDNU2
         DLXBIGGkUL7pMRHi8Jsb2cRTdtF+B4F9zMbs61vT9efN4mGV3FnlR+6AOPOW7TAsND2r
         De7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729457815; x=1730062615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPIXr1KQ2BwKIpE8FpDOMVjF3+IVdXE9OSCBYHyQV0s=;
        b=uHdFNc+Zz2Ifk9OoeRLs8VjP+94TrAOlKHJz5Em1CBkUlqEJfEeRQs9+Rj6lY8+gx+
         BCJroZ1y6E5mci9Vqos9n4L63zFV4hwmax6twPeL/JVX2heu2+HB/wIM5UGjgd+Ul5lL
         8YZP2EqQXzQZ0y6woP6Gk9fvewi56vTeWejPyWMLlxYK62ORQlTHyWS3xywaBEQsGF4z
         kdoF2z6ji6SLsOZKysfBIyY1kiKEdhjmuTt2u8L+Jrj3tMNqbZ9F4Ey+7IVx+S1gOW+D
         TDqG4z37QeQcSOozqMj/5iHKrOSKKiBkGpK1WrnYpryWDvqNDTq15tpyv8YTBASJyHGk
         2nXw==
X-Forwarded-Encrypted: i=1; AJvYcCUlVhc65yIGi4Pw2r3II6Xry6N3ckVjfSsV8g0LcAPzB6nN7HAQ+oRHCUmB5RFCE5tbL6vHZD309nN2aIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQnMb4vdDUv28ijBTHdzhEnliiNHi1BiClwojYLr7MiVZIyYcz
	WWja2JhCdNAigvZ8tp3zz16yBMU2fjn/BUx3ixJ+c1oPYPUHNo4vHQRJZp22
X-Google-Smtp-Source: AGHT+IG0awhuIDMFItmD6QJkGqGK9F8mLp6gKZkB746KOUtol1a3tvtYlxGxtrp0XRPlXCs4E4rz7g==
X-Received: by 2002:a17:906:6a1e:b0:a9a:1115:486e with SMTP id a640c23a62f3a-a9a69c6a83emr1030634066b.45.1729457815273;
        Sun, 20 Oct 2024 13:56:55 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edc07sm125135966b.69.2024.10.20.13.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 13:56:54 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: dsa: vsc73xx: implement transmit via control interface
Date: Sun, 20 Oct 2024 22:54:50 +0200
Message-Id: <20241020205452.2660042-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some types of packets can be forwarded only to and from the PI/SI
interface. For more information, see Chapter 2.7.1 (CPU Forwarding) in
the datasheet.

This patch implements the routines required for link-local transmission.
This kind of traffic can't be transferred through the RGMII interface in
vsc73xx.

It uses a method similar to the sja1005 driver, where the DSA tagger
checks if the packet is link-local and uses a special deferred transmit
route for that kind of packet.

The vsc73xx uses an "Internal Frame Header" (IFH) in communication via the
PI/SI interface. Every packet must be prefixed with an IFH. The hardware
fixes the checksums, so there's no need to calculate the FCS in the
driver.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 172 +++++++++++++++++++++++++
 drivers/net/dsa/vitesse-vsc73xx.h      |   1 +
 include/linux/dsa/vsc73xx.h            |  20 +++
 net/dsa/tag_vsc73xx_8021q.c            |  73 +++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 include/linux/dsa/vsc73xx.h

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index f18aa321053d..21ab3f214490 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -73,6 +73,9 @@
 #define VSC73XX_CAT_PR_USR_PRIO	0x75
 #define VSC73XX_CAT_VLAN_MISC	0x79
 #define VSC73XX_CAT_PORT_VLAN	0x7a
+#define VSC73XX_CPUTXDAT	0xc0
+#define VSC73XX_MISCFIFO	0xc4
+#define VSC73XX_MISCSTAT	0xc8
 #define VSC73XX_Q_MISC_CONF	0xdf
 
 /* MAC_CFG register bits */
@@ -166,6 +169,14 @@
 #define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
 #define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
 
+/* MISCFIFO Miscellaneous Control Register */
+#define VSC73XX_MISCFIFO_REWIND_CPU_TX	BIT(1)
+#define VSC73XX_MISCFIFO_CPU_TX		BIT(0)
+
+/* MISCSTAT Miscellaneous Status */
+#define VSC73XX_MISCSTAT_CPU_TX_DATA_PENDING	BIT(8)
+#define VSC73XX_MISCSTAT_CPU_TX_DATA_OVERFLOW	BIT(7)
+
 /* Frame analyzer block 2 registers */
 #define VSC73XX_STORMLIMIT	0x02
 #define VSC73XX_ADVLEARN	0x03
@@ -363,6 +374,9 @@
 #define VSC73XX_MDIO_POLL_SLEEP_US	5
 #define VSC73XX_POLL_TIMEOUT_US		10000
 
+#define VSC73XX_IFH_MAGIC		0x52
+#define VSC73XX_IFH_SIZE		8
+
 struct vsc73xx_counter {
 	u8 counter;
 	const char *name;
@@ -375,6 +389,31 @@ struct vsc73xx_fdb {
 	bool valid;
 };
 
+/* Internal frame header structure */
+struct vsc73xx_ifh {
+	union {
+		u32 datah;
+		struct {
+		u32 wt:1, /* Frame was tagged but tag has removed from frame */
+		    : 1,
+		    frame_length:14, /* Frame Length including CRC */
+		    : 11,
+		    port:5; /* SRC port of switch */
+		};
+	};
+	union {
+		u32 datal;
+		struct {
+		u32 vid:16, /* VLAN ID */
+		    : 3,
+		    magic:9, /* IFH magic field */
+		    lpa:1, /* SMAC is subject of learning */
+		    : 1,
+		    priority:2; /* Switch categorizer assigned priority */
+		};
+	};
+};
+
 /* Counters are named according to the MIB standards where applicable.
  * Some counters are custom, non-standard. The standard counters are
  * named in accordance with RFC2819, RFC2021 and IEEE Std 802.3-2002 Annex
@@ -683,6 +722,133 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	return 0;
 }
 
+static int vsc73xx_tx_fifo_busy_check(struct vsc73xx *vsc, int port)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 ||
+				!(val & VSC73XX_MISCSTAT_CPU_TX_DATA_PENDING),
+				VSC73XX_POLL_SLEEP_US,
+				VSC73XX_POLL_TIMEOUT_US, false, vsc,
+				VSC73XX_BLOCK_MAC, port, VSC73XX_MISCSTAT,
+				&val);
+	if (ret)
+		return ret;
+	return err;
+}
+
+static int
+vsc73xx_write_tx_fifo(struct vsc73xx *vsc, int port, u32 data0, u32 data1)
+{
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CPUTXDAT, data0);
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CPUTXDAT, data1);
+
+	return vsc73xx_tx_fifo_busy_check(vsc, port);
+}
+
+static int
+vsc73xx_inject_frame(struct vsc73xx *vsc, int port, struct sk_buff *skb)
+{
+	struct vsc73xx_ifh *ifh;
+	u32 length, i, count;
+	u32 *buf;
+	int ret;
+
+	if (skb->len + VSC73XX_IFH_SIZE < 64)
+		length = 64;
+	else
+		length = skb->len + VSC73XX_IFH_SIZE;
+
+	count = DIV_ROUND_UP(length, 8);
+	buf = kzalloc(count * 8, GFP_KERNEL);
+	memset(buf, 0, sizeof(buf));
+
+	ifh = (struct vsc73xx_ifh *)buf;
+	ifh->frame_length = skb->len;
+	ifh->magic = VSC73XX_IFH_MAGIC;
+
+	skb_copy_and_csum_dev(skb, (u8 *)(buf + 2));
+
+	for (i = 0; i < count; i++) {
+		ret = vsc73xx_write_tx_fifo(vsc, port, buf[2 * i],
+					    buf[2 * i + 1]);
+		if (ret) {
+			/* Clear buffer after error */
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_MISCFIFO,
+					    VSC73XX_MISCFIFO_REWIND_CPU_TX,
+					    VSC73XX_MISCFIFO_REWIND_CPU_TX);
+			goto err;
+		}
+	}
+
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MISCFIFO,
+		      VSC73XX_MISCFIFO_CPU_TX);
+
+	skb_tx_timestamp(skb);
+
+	skb->dev->stats.tx_packets++;
+	skb->dev->stats.tx_bytes += skb->len;
+err:
+	kfree(buf);
+	return ret;
+}
+
+#define work_to_xmit_work(w) \
+		container_of((w), struct vsc73xx_deferred_xmit_work, work)
+
+static void vsc73xx_deferred_xmit(struct kthread_work *work)
+{
+	struct vsc73xx_deferred_xmit_work *xmit_work = work_to_xmit_work(work);
+	struct dsa_switch *ds = xmit_work->dp->ds;
+	struct sk_buff *skb = xmit_work->skb;
+	int port = xmit_work->dp->index;
+	struct vsc73xx *vsc = ds->priv;
+	int ret;
+
+	if (vsc73xx_tx_fifo_busy_check(vsc, port)) {
+		dev_err(vsc->dev, "port %d failed to inject skb\n",
+			port);
+
+		/* Clear buffer after error */
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_MISCFIFO,
+				    VSC73XX_MISCFIFO_REWIND_CPU_TX,
+				    VSC73XX_MISCFIFO_REWIND_CPU_TX);
+
+		kfree_skb(skb);
+		return;
+	}
+
+	ret = vsc73xx_inject_frame(vsc, port, skb);
+
+	if (ret) {
+		dev_err(vsc->dev, "port %d failed to inject skb\n",
+			port);
+		return;
+	}
+
+	consume_skb(skb);
+	kfree(xmit_work);
+}
+
+static int
+vsc73xx_connect_tag_protocol(struct dsa_switch *ds, enum dsa_tag_protocol proto)
+{
+	struct vsc73xx_8021q_tagger_data *tagger_data;
+
+	switch (proto) {
+	case DSA_TAG_PROTO_VSC73XX_8021Q:
+		tagger_data = ds->tagger_data;
+		tagger_data->xmit_work_fn = vsc73xx_deferred_xmit;
+		return 0;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+}
+
 static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -1026,6 +1192,11 @@ static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
 		      VSC73XX_CAT_DROP,
 		      VSC73XX_CAT_DROP_FWD_PAUSE_ENA);
 
+	/* Allow switch to recalculate CRC of CPU packets */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
+			    VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA,
+			    VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA);
+
 	/* Clear all counters */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC,
 		      port, VSC73XX_C_RX0, 0);
@@ -2217,6 +2388,7 @@ static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
+	.connect_tag_protocol = vsc73xx_connect_tag_protocol,
 	.setup = vsc73xx_setup,
 	.teardown = vsc73xx_teardown,
 	.phy_read = vsc73xx_phy_read,
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 3c30e143c14f..bf55a20f07f3 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -2,6 +2,7 @@
 #include <linux/device.h>
 #include <linux/etherdevice.h>
 #include <linux/gpio/driver.h>
+#include <linux/dsa/vsc73xx.h>
 
 /* The VSC7395 switch chips have 5+1 ports which means 5 ordinary ports and
  * a sixth CPU port facing the processor with an RGMII interface. These ports
diff --git a/include/linux/dsa/vsc73xx.h b/include/linux/dsa/vsc73xx.h
new file mode 100644
index 000000000000..901eeb1da120
--- /dev/null
+++ b/include/linux/dsa/vsc73xx.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024, Pawel Dembicki <paweldembicki@gmail.com>
+ */
+
+/* Included by drivers/net/dsa/vitesse-vsc73xx.h and net/dsa/tag_vsc73xx_8021q.c */
+
+#ifndef _NET_DSA_VSC73XX_H
+#define _NET_DSA_VSC73XX_H
+
+struct vsc73xx_deferred_xmit_work {
+	struct dsa_port *dp;
+	struct sk_buff *skb;
+	struct kthread_work work;
+};
+
+struct vsc73xx_8021q_tagger_data {
+	void (*xmit_work_fn)(struct kthread_work *work);
+};
+
+#endif /* _NET_DSA_VSC73XX_H */
diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
index af121a9aff7f..d1d7a860a76e 100644
--- a/net/dsa/tag_vsc73xx_8021q.c
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -2,20 +2,61 @@
 /* Copyright (C) 2024 Pawel Dembicki <paweldembicki@gmail.com>
  */
 #include <linux/dsa/8021q.h>
+#include <linux/dsa/vsc73xx.h>
 
 #include "tag.h"
 #include "tag_8021q.h"
 
 #define VSC73XX_8021Q_NAME "vsc73xx-8021q"
 
+struct vsc73xx_8021q_tagger_private {
+	struct vsc73xx_8021q_tagger_data data; /* Must be first */
+	struct kthread_worker *xmit_worker;
+};
+
+static struct sk_buff *vsc73xx_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
+{
+	struct vsc73xx_8021q_tagger_private *priv = dp->ds->tagger_data;
+	struct vsc73xx_8021q_tagger_data *data = &priv->data;
+	void (*xmit_work_fn)(struct kthread_work *work);
+	struct vsc73xx_deferred_xmit_work *xmit_work;
+	struct kthread_worker *xmit_worker;
+
+	xmit_work_fn = data->xmit_work_fn;
+	xmit_worker = priv->xmit_worker;
+
+	if (!xmit_work_fn || !xmit_worker)
+		return NULL;
+
+	xmit_work = kzalloc(sizeof(*xmit_work), GFP_ATOMIC);
+	if (!xmit_work)
+		return NULL;
+
+	/* Calls vsc73xx_port_deferred_xmit in vitesse-vsc73xx-core.c */
+	kthread_init_work(&xmit_work->work, xmit_work_fn);
+	/* Increase refcount so the kfree_skb in dsa_slave_xmit
+	 * won't really free the packet.
+	 */
+	xmit_work->dp = dp;
+	xmit_work->skb = skb_get(skb);
+
+	kthread_queue_work(xmit_worker, &xmit_work->work);
+
+	return NULL;
+}
+
 static struct sk_buff *
 vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct dsa_port *dp = dsa_user_to_port(netdev);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
+	struct ethhdr *hdr = eth_hdr(skb);
 	u8 pcp;
 
+	if (is_link_local_ether_addr(hdr->h_dest))
+		return vsc73xx_defer_xmit(dp, skb);
+
 	if (skb->offload_fwd_mark) {
 		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
 		struct net_device *br = dsa_port_bridge_dev_get(dp);
@@ -52,11 +93,43 @@ vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
 	return skb;
 }
 
+static void vsc73xx_disconnect(struct dsa_switch *ds)
+{
+	struct vsc73xx_8021q_tagger_private *priv = ds->tagger_data;
+
+	kthread_destroy_worker(priv->xmit_worker);
+	kfree(priv);
+	ds->tagger_data = NULL;
+}
+
+static int vsc73xx_connect(struct dsa_switch *ds)
+{
+	struct vsc73xx_8021q_tagger_private *priv;
+	int err;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->xmit_worker = kthread_create_worker(0, "vsc73xx_xmit");
+	if (IS_ERR(priv->xmit_worker)) {
+		err = PTR_ERR(priv->xmit_worker);
+		kfree(priv);
+		return err;
+	}
+
+	ds->tagger_data = priv;
+
+	return 0;
+}
+
 static const struct dsa_device_ops vsc73xx_8021q_netdev_ops = {
 	.name			= VSC73XX_8021Q_NAME,
 	.proto			= DSA_TAG_PROTO_VSC73XX_8021Q,
 	.xmit			= vsc73xx_xmit,
 	.rcv			= vsc73xx_rcv,
+	.connect		= vsc73xx_connect,
+	.disconnect		= vsc73xx_disconnect,
 	.needed_headroom	= VLAN_HLEN,
 	.promisc_on_conduit	= true,
 };
-- 
2.34.1


