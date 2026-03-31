Return-Path: <netdev+bounces-273779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPpIHbVSzGndSQYAu9opvQ
	(envelope-from <netdev+bounces-273779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:03:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0C4372944
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B3DF30BB54C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BAF466B58;
	Tue, 31 Mar 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQYK4Gmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C3346766
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998048; cv=none; b=A+S+FiQdNaZ2YxbXty0iPXSVkHlE2DsqrhRHJEO6Ffkdp5BrrtG34i/8aco38GgmcGRqZo6RQiwCIkHke55Oba6yO3xREnDF9Fc1g7uy1NmtAFKOV1WPGdouZrebzPEPE6YMoqFtDrq/aGwwlsA0MmbFGxAThsEKHNRuK3OJeyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998048; c=relaxed/simple;
	bh=zS+mNc9c+Neu61UQzalBRkHFbhe85rZ871tygwe+gVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siXrVzdquttpl0/mRZoqqquE3ZM4xGiStDEWslqxTgaqdgStzqdxzBnocSvJR6j3wuIlHVuu+KeDKfKkRKaE952Qjg7no72UFH+EVlupHWXhW6Ei9FmNcagLOrkR9r+Nmk0U4S/ATgu6mo+pnpGj8o4DgPJds1hzZH6BXI/fVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQYK4Gmh; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56b8804f37cso2758635e0c.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998045; x=1775602845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGLY/T0HFLxBmugFFgKJly1nixAlzC5XR0iq2QbIvpM=;
        b=UQYK4Gmhse+l/scA9mcNIyH1m41+I+vRcUXo6MSyyhYxD3F7O134HLDXhlYUkONSSJ
         J3nNOII+ExKKnoqGRnU46PfiaTe5SZ5RC8uBSgdjKGCxlVaSAUM/Y/ksx5MRhM/iPcdn
         XqIWtB9N9KQQd1h1O4O7v5Cs5j0zdWo1BJJduvbxmYMu21ue7Fd06TOedAYvIwUQeZcw
         /bfArglF9VkdWYWaFyYhITXyfdkyvEnrf0Ep/5dVh4f4D0+nNgEy+UUs2gty1OYFk+vK
         iuPW3bSRyDVP6aCKh7cUxnporbMICjc334bK6h4iXwzV0IATVwH99zlZVRyrzptr5NRJ
         y2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998045; x=1775602845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LGLY/T0HFLxBmugFFgKJly1nixAlzC5XR0iq2QbIvpM=;
        b=O05bifp6xQlv9fad4HO1a01DaOLpydmA3HZLu37/LQIO4Z2EsBqp1oMjI+nxVmPY6Y
         cHsfOPe+Sw83abF7wtzU4mg4OTlRRoZv46Y2x3jaP0v9WkVNhsb1pyY6GoaFVJ9MA36f
         avEs+0f1wJ/hNRVHOyUGphvJREnuGB9ANtFgT10rRWeEV+vjGwGDpDWL0M2D4ZsIVeDM
         KTMVVVayJlMulygQEAgcsRtXcAUnBAZKC1OtypbjjiVNtdJCYkccmVfaPk9ZX7nZNtRN
         n5Oj1mhrinbc3Emc9QwuQLPI/Ht1rONistXbcUqsE/3jMGdGPISpK43XrIlvtGWw4i1K
         p4Sg==
X-Gm-Message-State: AOJu0YxVsRoptWiTIAG0pd39Du+33QRTGbl73N9mwXXEEkKn1koYiFmx
	bT7NX+Y26InsVzTO6jeRMuEjqzPHxLjasx3fXosuf567/vLANAHCha3l
X-Gm-Gg: ATEYQzzRNSseBNV5+XLyD9Gsooo0Wfhlz81LP9LUJMkQAkqRCB+IIE9qf4EhvSlotQK
	LzVOyQWcc7jRF9M0n8rBrQGwmH/4VewAQgxKxA0zu2ZOM0bHy4BuI2tSGMvjqRrv6QYt5J1owZ/
	TiNZE6+I/HNN17+6dc69O0TpXvIQkjKB/Jlcp03+A2ZGDsfZ6GSqZlqqvXb2++HsoXg25UjYQOV
	UHCSeILV6KFp3/1kOKOU7ADKS1kXG/GpKjtN+xbjyMFymHGSEDwRirudv/VykE9qlQyRk0YgZDG
	PgR5nUru2gxmS2DNeSFeK+SV6LaffivIXZXvwlmIZJe7wRvhXqtSDDrCIHrRdyboJFwd1KhIbjR
	CRj97gqbwN60/WsZXHtuu+Wvj5qDlk3VavXZ73x7TdoH2ZnkLyq79EIRllLjUDAK2jKP6590BOL
	0X8kygtzMNaBdtD9BKXmNAOpDyPf1dxLEaQqQR0gdJoSvWOfg0
X-Received: by 2002:a05:6122:3b83:b0:56b:9083:4331 with SMTP id 71dfb90a1353d-56d8a97849bmr675853e0c.12.1774998044562;
        Tue, 31 Mar 2026 16:00:44 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:43 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:06 -0300
Subject: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 0B0C4372944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Realtek RTL8365MB switches (a.k.a. RTL8367C family) use two different
structures for VLANs:

- VLAN4K: A full table with 4096 entries defining port membership and
  tagging.
- VLANMC: A smaller table with 32 entries used primarily for PVID
  assignment.

In this hardware, a port's PVID must point to an index in the VLANMC
table rather than a VID directly. Since the VLANMC table is limited to
32 entries, the driver implements a dynamic allocation scheme to
maximize resource usage:

- VLAN4K is treated by the driver as the source of truth for membership.
- A VLANMC entry is only allocated when a port is configured to use a
  specific VID as its PVID.
- VLANMC entries are deleted when no longer needed as a PVID by any port.

Although VLANMC has a members field, the switch only checks membership
in the VLAN4K table. However, when a corresponding VLAN entry also exists
in VLANMC, this driver keeps both membership configurations in sync.

VLANMC index 0, although a valid entry, is reserved in this driver as a
neutral PVID value for ports not using a specific PVID.

In the subsequent RTL8367D switch family, VLANMC table was
removed and PVID assignment was delegated to a dedicated set of
registers.

All ports start isolated, forwarding exclusively to CPU ports, and
with VLAN transparent, ignoring VLAN membership. Once a member in a
bridge, the port isolation is expanded to include the bridge members.
When that bridge enables VLAN filtering, the VLAN transparent feature is
disabled, letting the switch filter based on VLAN setup.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 256 ++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 805 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |  30 ++
 4 files changed, 1092 insertions(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 99654c4c5a3d..b7fc4e852fd8 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -18,3 +18,4 @@ endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
 rtl8365mb-objs := rtl8365mb_main.o \
 		  rtl8365mb_table.o \
+		  rtl8365mb_vlan.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 530ff5503543..c604bd744d38 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -104,6 +104,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
+#include "rtl8365mb_vlan.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -292,6 +293,67 @@
 #define   RTL8365MB_MSTI_CTRL_PORT_STATE_MASK(_physport) \
 		(0x3 << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET((_physport)))
 
+/* Miscellaneous port configuration register, incl. VLAN egress mode */
+#define RTL8365MB_PORT_MISC_CFG_REG_BASE			0x000E
+#define RTL8365MB_PORT_MISC_CFG_REG(_p) \
+		(RTL8365MB_PORT_MISC_CFG_REG_BASE + ((_p) << 5))
+#define   RTL8365MB_PORT_MISC_CFG_SMALL_TAG_IPG_MASK		0x8000
+#define   RTL8365MB_PORT_MISC_CFG_TX_ITFSP_MODE_MASK		0x4000
+#define   RTL8365MB_PORT_MISC_CFG_FLOWCTRL_INDEP_MASK		0x2000
+#define   RTL8365MB_PORT_MISC_CFG_DOT1Q_REMARK_ENABLE_MASK	0x1000
+#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_FLOWCTRL_MASK	0x0800
+#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_IFG_MASK		0x0400
+#define   RTL8365MB_PORT_MISC_CFG_RX_SPC_MASK			0x0200
+#define   RTL8365MB_PORT_MISC_CFG_CRC_SKIP_MASK			0x0100
+#define   RTL8365MB_PORT_MISC_CFG_PKTGEN_TX_FIRST_MASK		0x0080
+#define   RTL8365MB_PORT_MISC_CFG_MAC_LOOPBACK_MASK		0x0040
+/* See &rtl8365mb_vlan_egress_mode */
+#define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		0x0030
+#define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	0x000F
+
+/**
+ * enum rtl8365mb_vlan_egress_mode - port VLAN engress mode
+ * @RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL: follow untag mask in VLAN4k table entry
+ * @RTL8365MB_VLAN_EGRESS_MODE_KEEP: the VLAN tag format of egressed packets
+ * will remain the same as their ingressed format, but the priority and VID
+ * fields may be altered
+ * @RTL8365MB_VLAN_EGRESS_MODE_PRI_TAG: always egress with priority tag
+ * @RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP: the VLAN tag format of egressed
+ * packets will remain the same as their ingressed format, and neither the
+ * priority nor VID fields can be altered
+ */
+enum rtl8365mb_vlan_egress_mode {
+	RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL = 0,
+	RTL8365MB_VLAN_EGRESS_MODE_KEEP = 1,
+	RTL8365MB_VLAN_EGRESS_MODE_PRI_TAG = 2,
+	RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP = 3,
+};
+
+/* VLAN control register */
+#define RTL8365MB_VLAN_CTRL_REG			0x07A8
+#define   RTL8365MB_VLAN_CTRL_EN_MASK		0x0001
+
+/* VLAN ingress filter register */
+#define RTL8365MB_VLAN_INGRESS_REG				0x07A9
+#define   RTL8365MB_VLAN_INGRESS_MASK				GENMASK(10, 0)
+#define   RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_OFFSET(_p)	(_p)
+#define   RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(_p)	BIT(_p)
+
+/* VLAN "transparent" setting registers */
+#define RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG_BASE	0x09D0
+#define RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(_p) \
+		(RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG_BASE + (_p))
+
+/* Frame type filtering registers */
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE	0x07aa
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
+		(RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE + ((port) >> 3))
+/* required as FIELD_PREP cannot use non-constant masks */
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port) \
+		(0x3 << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port))
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port) \
+		(((port) & 0x7) << 1)
+
 /* MIB counter value registers */
 #define RTL8365MB_MIB_COUNTER_BASE	0x1000
 #define RTL8365MB_MIB_COUNTER_REG(_x)	(RTL8365MB_MIB_COUNTER_BASE + (_x))
@@ -1196,6 +1258,183 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
 			   val << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET(port));
 }
 
+static int rtl8365mb_port_set_transparent(struct realtek_priv *priv,
+					  int igr_port, int egr_port,
+					  bool enable)
+{
+	dev_dbg(priv->dev, "%s transparent VLAN from %d to %d\n",
+		enable ? "Enable" : "Disable", igr_port, egr_port);
+
+	/* "Transparent" between the two ports means that packets forwarded by
+	 * igr_port and egressed on egr_port will not be filtered by the usual
+	 * VLAN membership settings.
+	 */
+	return regmap_update_bits(priv->map,
+			RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(egr_port),
+			BIT(igr_port), enable ? BIT(igr_port) : 0);
+}
+
+static int rtl8365mb_port_set_ingress_filtering(struct realtek_priv *priv,
+						int port, bool enable)
+{
+	/* Ingress filtering enabled: Discard VLAN-tagged frames if the port is
+	 * not a member of the VLAN with which the packet is associated.
+	 * Untagged packets will also be discarded unless the port has a PVID
+	 * programmed. Priority-tagged frames are treated as untagged frames.
+	 *
+	 * Ingress filtering disabled: Accept all tagged and untagged frames.
+	 */
+	return regmap_update_bits(priv->map, RTL8365MB_VLAN_INGRESS_REG,
+			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port),
+			enable ?
+			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port) :
+			0);
+}
+
+static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
+					 bool vlan_filtering,
+					 struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	int ret;
+
+	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
+		vlan_filtering ? "enable" : "disable");
+
+	/* (En|dis)able incoming packets filter, i.e. ignore VLAN membership */
+	dsa_switch_for_each_available_port(dp, ds) {
+		/* after considering port isolation, if not filtering
+		 * allow forwarding from port to dp->index ignoring
+		 * VLAN membership.
+		 */
+		ret = rtl8365mb_port_set_transparent(priv, port, dp->index,
+						     !vlan_filtering);
+		if (ret)
+			return ret;
+	}
+
+	/* If the port is not in the member set, the frame will be dropped */
+	return rtl8365mb_port_set_ingress_filtering(priv, port,
+						    vlan_filtering);
+}
+
+static int rtl8365mb_port_vlan_add(struct dsa_switch *ds, int port,
+				   const struct switchdev_obj_port_vlan *vlan,
+				   struct netlink_ext_ack *extack)
+{
+	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	struct realtek_priv *priv = ds->priv;
+	int ret;
+
+	dev_dbg(priv->dev, "add VLAN %d on port %d, %s, %s\n",
+		vlan->vid, port, untagged ? "untagged" : "tagged",
+		pvid ? "PVID" : "no PVID");
+	/* add port to vlan4k. It knows nothing about PVID */
+	ret = rtl8365mb_vlan_4k_port_add(ds, port, vlan, extack);
+	if (ret)
+		return ret;
+
+	/* VlanMC knows nothing about untagged but it is required for PVID */
+	ret = rtl8365mb_vlan_mc_port_add(ds, port, vlan, extack);
+	if (ret)
+		goto undo_vlan_4k;
+
+	/* Set PVID if needed */
+	if (pvid) {
+		ret = rtl8365mb_vlan_pvid_port_add(ds, port, vlan, extack);
+		if (ret)
+			goto undo_vlan_mc;
+	}
+
+	return 0;
+
+undo_vlan_mc:
+	(void)rtl8365mb_vlan_mc_port_del(ds, port, vlan);
+
+undo_vlan_4k:
+	(void)rtl8365mb_vlan_4k_port_del(ds, port, vlan);
+	return ret;
+}
+
+static int rtl8365mb_port_vlan_del(struct dsa_switch *ds, int port,
+				   const struct switchdev_obj_port_vlan *vlan)
+{
+	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	struct realtek_priv *priv = ds->priv;
+	int ret1, ret2, ret3;
+
+	dev_dbg(priv->dev, "del VLAN %d on port %d, %s, %s\n",
+		vlan->vid, port, untagged ? "untagged" : "tagged",
+		pvid ? "PVID" : "no PVID");
+
+	ret1 = rtl8365mb_vlan_pvid_port_del(ds, port, vlan);
+	ret2 = rtl8365mb_vlan_mc_port_del(ds, port, vlan);
+	ret3 = rtl8365mb_vlan_4k_port_del(ds, port, vlan);
+
+	return ret1 ?: ret2 ?: ret3;
+}
+
+static int
+rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
+				    enum rtl8365mb_vlan_egress_mode mode)
+{
+	u32 val;
+
+	val = FIELD_PREP(RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, mode);
+	return regmap_update_bits(priv->map,
+			RTL8365MB_PORT_MISC_CFG_REG(port),
+			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
+}
+
+/* VLAN support is always enabled in the switch.
+ *
+ * All ports starts with vlan-unaware state, letting non-bridge port forward
+ * to CPU.
+ *
+ */
+static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
+{
+	struct realtek_priv *priv = ds->priv;
+	enum rtl8365mb_vlan_egress_mode mode;
+	struct dsa_port *dp;
+	int ret;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		/* Disable vlan-filtering for all ports */
+		ret = rtl8365mb_port_vlan_filtering(ds, dp->index, false, NULL);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to disable vlan filtering on port %d\n",
+				dp->index);
+			return ret;
+		}
+
+		/* The switch default is RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP,
+		 * that forwards the packet as it was received. However,
+		 * different untag settings will require the switch to update
+		 * the tag.
+		 */
+		mode = RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL;
+		ret = rtl8365mb_port_set_vlan_egress_mode(priv, dp->index,
+							  mode);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to set port %d egress mode\n",
+				dp->index);
+			return ret;
+		}
+	}
+
+	/* VLAN is always enabled. */
+	ret = regmap_update_bits(priv->map, RTL8365MB_VLAN_CTRL_REG,
+				 RTL8365MB_VLAN_CTRL_EN_MASK,
+				 FIELD_PREP(RTL8365MB_VLAN_CTRL_EN_MASK, 1));
+	return ret;
+}
+
 static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 				       bool enable)
 {
@@ -2014,6 +2253,20 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	/* vlan config will only be effective for ports with vlan filtering */
+	ds->configure_vlan_while_not_filtering = true;
+	/* Set up VLAN */
+	ret = rtl8365mb_vlan_setup(ds);
+	if (ret)
+		goto out_teardown_irq;
+
+	/* Set maximum packet length to 1536 bytes */
+	ret = regmap_update_bits(priv->map, RTL8365MB_CFG0_MAX_LEN_REG,
+				 RTL8365MB_CFG0_MAX_LEN_MASK,
+				 FIELD_PREP(RTL8365MB_CFG0_MAX_LEN_MASK, 1536));
+	if (ret)
+		goto out_teardown_irq;
+
 	ret = rtl83xx_setup_user_mdio(ds);
 	if (ret) {
 		dev_err(priv->dev, "could not set up MDIO bus\n");
@@ -2124,6 +2377,9 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
+	.port_vlan_add = rtl8365mb_port_vlan_add,
+	.port_vlan_del = rtl8365mb_port_vlan_del,
+	.port_vlan_filtering = rtl8365mb_port_vlan_filtering,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
 	.get_sset_count = rtl8365mb_get_sset_count,
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
new file mode 100644
index 000000000000..1ac36c06dcf7
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0
+/* VLAN configuration interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ *
+ * VLAN configuration takes place in two separate domains of the switch: the
+ * VLAN4k table and the VLAN membership configuration (MC) database. While the
+ * VLAN4k table is exhaustive and can be fully populated with 4096 VLAN
+ * configurations, the same does not hold for the VLAN membership configuration
+ * database, which is limited to 32 entries.
+ *
+ * The switch will normally only use the VLAN4k table when making forwarding
+ * decisions. The VLAN membership configuration database is a vestigial ASIC
+ * design and is only used for a few specific features in the rtl8365mb
+ * family. This means that the limit of 32 entries should not hinder us in
+ * programming a huge number of VLANs into the switch.
+ *
+ * One necessary use of the VLAN membership configuration database is for the
+ * programming of a port-based VLAN ID (PVID). The PVID is programmed on a
+ * per-port basis via register field, which refers to a specific VLAN membership
+ * configuration via an index 0~31. In order to maintain coherent behaviour on a
+ * port with a PVID, it is necessary to keep the VLAN configuration synchronized
+ * between the VLAN4k table and the VLAN membership configuration database.
+ *
+ * Since VLAN membership configs are a scarce resource, it will only be used
+ * when strictly needed (i.e. a VLAN with members using PVID). Otherwise, the
+ * VLAN4k will be enough.
+ *
+ * With some exceptions, the entries in both the VLAN4k table and the VLAN
+ * membership configuration database offer the same configuration options. The
+ * differences are as follows:
+ *
+ * 1. VLAN4k entries can specify whether to use Independent or Shared VLAN
+ *    Learning (IVL or SVL respectively). VLAN membership config entries
+ *    cannot. This underscores the fact that VLAN membership configs are not
+ *    involved in the learning process of the ASIC.
+ *
+ * 2. VLAN membership config entries use an "enhanced VLAN ID" (efid), which has
+ *    a range 0~8191 compared with the standard 0~4095 range of the VLAN4k
+ *    table. This underscores the fact that VLAN membership configs can be used
+ *    to group ports on a layer beyond the standard VLAN configuration, which
+ *    may be useful for ACL rules which specify alternative forwarding
+ *    decisions.
+ *
+ * VLANMC index 0 is reserved as a neutral PVID, used for vlan-unaware ports.
+ *
+ */
+
+#include "rtl8365mb_vlan.h"
+#include "rtl8365mb_table.h"
+#include <linux/if_bridge.h>
+#include <linux/regmap.h>
+
+/* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
+#define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
+#define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
+#define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
+#define RTL8365MB_CVLAN_ENTRY_D1_FID_MASK		GENMASK(3, 0)
+#define RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK		GENMASK(4, 4)
+#define RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK		GENMASK(7, 5)
+#define RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK		GENMASK(8, 8)
+#define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
+#define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
+/* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
+#define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
+/* extends RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK */
+#define RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK		GENMASK(5, 3)
+/* extends RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK */
+#define RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK	GENMASK(6, 6)
+
+/* VLAN member configuration registers 0~31, u16[3] */
+#define RTL8365MB_VLAN_MC_BASE				0x0728
+#define RTL8365MB_VLAN_MC_ENTRY_SIZE			4 /* 64-bit */
+#define RTL8365MB_VLAN_MC_REG(index) \
+		(RTL8365MB_VLAN_MC_BASE + \
+		 (RTL8365MB_VLAN_MC_ENTRY_SIZE * (index)))
+#define   RTL8365MB_VLAN_MC_D0_MBR_MASK			GENMASK(10, 0)
+#define   RTL8365MB_VLAN_MC_D1_FID_MASK			GENMASK(3, 0)
+
+#define   RTL8365MB_VLAN_MC_D2_VBPEN_MASK		GENMASK(0, 0)
+#define   RTL8365MB_VLAN_MC_D2_VBPRI_MASK		GENMASK(3, 1)
+#define   RTL8365MB_VLAN_MC_D2_ENVLANPOL_MASK		GENMASK(4, 4)
+#define   RTL8365MB_VLAN_MC_D2_METERIDX_MASK		GENMASK(10, 5)
+#define   RTL8365MB_VLAN_MC_D3_EVID_MASK		GENMASK(12, 0)
+
+/* Some limits for VLAN4k/VLAN membership config entries */
+#define RTL8365MB_PRIORITYMAX	7
+#define RTL8365MB_FIDMAX	15
+#define RTL8365MB_METERMAX	63
+#define RTL8365MB_VLAN_MCMAX	31
+
+/* RTL8367S supports 4k vlans (vid<=4095) and 32 enhanced vlans
+ * for VIDs up to 8191
+ */
+#define RTL8365MB_MAX_4K_VID	0x0FFF /* 4095 */
+#define RTL8365MB_MAX_MC_VID	0x1FFF /* 8191 */
+
+ /* Port-based VID registers 0~5 - each one holds an MC index for two ports */
+#define RTL8365MB_VLAN_PVID_CTRL_BASE			0x0700
+#define RTL8365MB_VLAN_PVID_CTRL_REG(_p) \
+		(RTL8365MB_VLAN_PVID_CTRL_BASE + ((_p) >> 1))
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT0_MCIDX_MASK	0x001F
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT1_MCIDX_MASK	0x1F00
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p) \
+		(((_p) & 1) << 3)
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(_p) \
+		(0x1F << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p))
+
+/* Frame type filtering registers */
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE	0x07aa
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
+		(RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE + ((port) >> 3))
+/* required as FIELD_PREP cannot use non-constant masks */
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port) \
+		(0x3 << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port))
+#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port) \
+		(((port) & 0x7) << 1)
+
+/**
+ * struct rtl8365mb_vlan4k - VLAN4k table entry
+ * @vid: VLAN ID (0~4095)
+ * @member: port mask of ports in this VLAN
+ * @untag: port mask of ports which untag on egress
+ * @fid: filter ID - only used with SVL (unused)
+ * @priority: priority classification (unused)
+ * @priority_en: enable priority (unused)
+ * @policing_en: enable policing (unused)
+ * @ivl_en: enable IVL instead of default SVL
+ * @meteridx: metering index (unused)
+ *
+ * This structure is used to get/set entries in the VLAN4k table. The
+ * VLAN4k table dictates the VLAN configuration for the switch for the
+ * vast majority of features.
+ */
+struct rtl8365mb_vlan4k {
+	u16 vid;
+	u16 member;
+	u16 untag;
+	u8 fid : 4;
+	u8 priority : 3;
+	u8 priority_en : 1;
+	u8 policing_en : 1;
+	u8 ivl_en : 1;
+	u8 meteridx : 6;
+};
+
+/**
+ * struct rtl8365mb_vlanmc - VLAN membership config
+ * @evid: Enhanced VLAN ID (0~8191)
+ * @member: port mask of ports in this VLAN
+ * @fid: filter ID - only used with SVL (unused)
+ * @priority: priority classification (unused)
+ * @priority_en: enable priority (unused)
+ * @policing_en: enable policing (unused)
+ * @meteridx: metering index (unused)
+ *
+ * This structure is used to get/set entries in the VLAN membership
+ * configuration database. This feature is largely vestigial, but
+ * still needed for at least the following features:
+ *   - PVID configuration
+ *   - ACL configuration
+ *   - selection of VLAN by the CPU tag when VSEL=1, although the switch
+ *     can also select VLAN based on the VLAN tag if VSEL=0
+ *
+ * This is a low-level structure and it is recommended to interface with
+ * the VLAN membership config database via &struct rtl8365mb_vlanmc_entry.
+ */
+struct rtl8365mb_vlanmc {
+	u16 evid;
+	u16 member;
+	u8 fid : 4;
+	u8 priority : 3;
+	u8 priority_en : 1;
+	u8 policing_en : 1;
+	u8 meteridx : 6;
+};
+
+enum rtl8365mb_frame_ingress {
+	RTL8365MB_FRAME_TYPE_ANY_FRAME = 0,
+	RTL8365MB_FRAME_TYPE_TAGGED_ONLY,
+	RTL8365MB_FRAME_TYPE_UNTAGGED_ONLY,
+};
+
+static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
+				  struct rtl8365mb_vlan4k *vlan4k)
+{
+	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE];
+	int ret;
+
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
+				    RTL8365MB_TABLE_OP_READ, &vid, 0, 0,
+				    data, ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	/* Unpack table entry */
+	memset(vlan4k, 0, sizeof(*vlan4k));
+	vlan4k->vid = vid;
+	vlan4k->member =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]) |
+		(FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2])
+		 << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));
+	vlan4k->untag =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, data[0]) |
+		(FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, data[2])
+		 << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK));
+	vlan4k->fid = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, data[1]);
+	vlan4k->priority_en =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK, data[1]);
+	vlan4k->priority =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK, data[1]);
+	vlan4k->policing_en =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK, data[1]);
+	vlan4k->meteridx =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, data[1]) |
+		(FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, data[2])
+		 << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK));
+	vlan4k->ivl_en =
+		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK, data[1]);
+
+	return 0;
+}
+
+static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
+				   const struct rtl8365mb_vlan4k *vlan4k)
+{
+	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
+	u16 val;
+	u16 vid;
+
+	if (vlan4k->fid > RTL8365MB_FIDMAX ||
+	    vlan4k->priority > RTL8365MB_PRIORITYMAX ||
+	    vlan4k->meteridx > RTL8365MB_METERMAX)
+		return -EINVAL;
+
+	/* Pack table entry value */
+	data[0] |=
+		FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, vlan4k->member);
+	data[0] |=
+		FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, vlan4k->untag);
+
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, vlan4k->fid);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK,
+			      vlan4k->priority_en);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK,
+			      vlan4k->priority);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK,
+			      vlan4k->policing_en);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK,
+			      vlan4k->meteridx);
+	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK,
+			      vlan4k->ivl_en);
+
+	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK,
+			      vlan4k->member >>
+			      FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));
+	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK,
+			      vlan4k->untag >>
+			      FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK));
+	val = FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK,
+			 vlan4k->meteridx >>
+			 FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK));
+	data[2] |= val;
+
+	vid = vlan4k->vid;
+	return rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
+				     RTL8365MB_TABLE_OP_WRITE, &vid, 0, 0,
+				     data, ARRAY_SIZE(data));
+}
+
+#define RTL_VLAN_ERR(msg)						\
+	do {								\
+		const char *__msg = (msg);				\
+									\
+		if (extack)						\
+			NL_SET_ERR_MSG_FMT_MOD(extack, "%s", __msg);	\
+		dev_err(priv->dev, "%s", __msg);			\
+	} while (0)
+
+static int
+rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
+			   const struct switchdev_obj_port_vlan *vlan,
+			   struct netlink_ext_ack *extack,
+			       bool include)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlan4k vlan4k = {0};
+	int ret;
+
+	dev_dbg(priv->dev, "%s VLAN %d 4K on port %d\n",
+		include ? "add" : "del",
+		vlan->vid, port);
+
+	if (vlan->vid > RTL8365MB_MAX_4K_VID) {
+		RTL_VLAN_ERR("VLAN ID greater than "
+			     __stringify(RTL8365MB_MAX_4K_VID));
+		return -EINVAL;
+	}
+
+	ret = rtl8365mb_vlan_4k_read(priv, vlan->vid, &vlan4k);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read VLAN 4k table");
+		return ret;
+	}
+
+	if (include)
+		vlan4k.member |= BIT(port);
+	else
+		vlan4k.member &= ~BIT(port);
+
+	if (include && (vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED))
+		vlan4k.untag |= BIT(port);
+	else
+		vlan4k.untag &= ~BIT(port);
+	vlan4k.ivl_en = true; /* always use Independent VLAN Learning */
+
+	ret = rtl8365mb_vlan_4k_write(priv, &vlan4k);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to write VLAN 4k table");
+		return ret;
+	}
+
+	return 0;
+}
+
+int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack)
+{
+	return rtl8365mb_vlan_4k_port_set(ds, port, vlan, extack, true);
+}
+
+int rtl8365mb_vlan_4k_port_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan)
+{
+	return rtl8365mb_vlan_4k_port_set(ds, port, vlan, NULL, false);
+}
+
+/**
+ * rtl8365mb_vlan_mc_find() - find VLANMC index by VID or the first free index
+ *
+ * @priv: realtek_priv pointer
+ * @vid: VLAN ID
+ * @index: found index
+ * @first_free: found free index
+ *
+ * If a VLAN MC entry using @vid was found, @index will return the matched index
+ * and @first_free is undefined. If not found, @index will return 0 and
+ * @first_free will return the first found free index in VLAN MC or 0 if the
+ * table is full.
+ *
+ * Although 0 is a valid VLAN MC index, it is reserved for ports without PVID,
+ * including standalone, non-member ports.
+ *
+ * Both @index and @first_free will be in the * 1..@RTL8365MB_VLAN_MCMAX range.
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ *
+ */
+static int rtl8365mb_vlan_mc_find(struct realtek_priv *priv, u16 vid,
+				  u8 *index, u8 *first_free)
+{
+	u32 vlan_entry_d3;
+	u8 vlanmc_idx;
+	u16 evid;
+	int ret;
+
+	if (!index)
+		return -EINVAL;
+	if (!first_free)
+		return -EINVAL;
+	if (!vid)
+		return -EINVAL;
+
+	*index = 0;
+	*first_free = 0;
+
+	/* look for existing entry or an empty one */
+	/* vlanmc index 0 is reserved as a neutral PVID value.
+	 * Non-PVID ports can still reach the CPU via VLAN
+	 * transparent mode.
+	 **/
+	for (vlanmc_idx = 1; vlanmc_idx <= RTL8365MB_VLAN_MCMAX; vlanmc_idx++) {
+		/* just read the 4th word, where the evid is */
+		ret = regmap_read(priv->map,
+				  RTL8365MB_VLAN_MC_REG(vlanmc_idx) + 3,
+				  &vlan_entry_d3);
+		if (ret)
+			return ret;
+
+		evid = FIELD_GET(RTL8365MB_VLAN_MC_D3_EVID_MASK, vlan_entry_d3);
+
+		if (evid == vid) {
+			*index = vlanmc_idx;
+			return 0;
+		}
+
+		if (evid == 0x0 && *first_free < 1)
+			*first_free = vlanmc_idx;
+	}
+	return 0;
+}
+
+static int rtl8365mb_vlan_port_set_pvid(struct realtek_priv *priv,
+					int port, u16 vlanmc_idx)
+{
+	int ret;
+	u32 val;
+
+	val = vlanmc_idx << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(port);
+	ret = regmap_update_bits(priv->map,
+				 RTL8365MB_VLAN_PVID_CTRL_REG(port),
+				 RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(port),
+				 val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv,
+					int port, u8 *vlanmc_idx)
+{
+	u32 data;
+	int ret;
+
+	ret = regmap_read(priv->map, RTL8365MB_VLAN_PVID_CTRL_REG(port), &data);
+	if (ret)
+		return ret;
+
+	*vlanmc_idx = (data & RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(port))
+		      >> RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(port);
+
+	return 0;
+}
+
+/**
+ * rtl8365mb_vlan_mc_pvid_members() - Get a bitmap of vlan PVID members
+ *
+ * @ds: DSA switch
+ * @vlanmc_idx: the index of a VLAN in VLAN MC table
+ * @members: the returned bitmap of members that have PVID status
+ *
+ * This function iterates over DSA ports and creates a bitmap representation of
+ * those ports that have PVID pointing to this VLAN (identified by its table
+ * index and not VID). If you need to get the table index from VID, see
+ * rtl8365mb_vlan_mc_find()
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ **/
+static int rtl8365mb_vlan_mc_pvid_members(struct dsa_switch *ds,
+					  u8 vlanmc_idx, u16 *members)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u8 _vlanmc_idx;
+	int ret;
+
+	if (!members)
+		return -EINVAL;
+
+	*members = 0;
+
+	dsa_switch_for_each_port(dp, ds) {
+		ret = rtl8365mb_vlan_port_get_pvid(priv, dp->index,
+						   &_vlanmc_idx);
+		if (ret)
+			return ret;
+
+		if (_vlanmc_idx == vlanmc_idx)
+			*members |= BIT(dp->index);
+	}
+
+	return 0;
+}
+
+static int
+rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
+				    int port,
+				    enum rtl8365mb_frame_ingress accepted_frame)
+{
+	/* Even if ACCEPT_FRAME_TYPE_ANY, the switch will still check if the
+	 * port is a member of vlan PVID
+	 */
+	accepted_frame = accepted_frame
+			 << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port);
+
+	return regmap_update_bits(priv->map,
+				  RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port),
+				  RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port),
+				  accepted_frame);
+}
+
+static int rtl8365mb_vlan_mc_read(struct realtek_priv *priv, u32 index,
+				  struct rtl8365mb_vlanmc *vlanmc)
+{
+	u16 data[RTL8365MB_VLAN_MC_ENTRY_SIZE];
+	int ret;
+
+	if (index > RTL8365MB_VLAN_MCMAX)
+		return -EINVAL;
+
+	ret = regmap_bulk_read(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
+			       RTL8365MB_VLAN_MC_ENTRY_SIZE);
+	if (ret)
+		return ret;
+
+	vlanmc->member = FIELD_GET(RTL8365MB_VLAN_MC_D0_MBR_MASK, data[0]);
+	vlanmc->fid = FIELD_GET(RTL8365MB_VLAN_MC_D1_FID_MASK, data[1]);
+	vlanmc->priority = FIELD_GET(RTL8365MB_VLAN_MC_D2_VBPRI_MASK, data[2]);
+	vlanmc->evid = FIELD_GET(RTL8365MB_VLAN_MC_D3_EVID_MASK, data[3]);
+
+	return 0;
+}
+
+int rtl8365mb_vlan_pvid_port_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack)
+{
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	enum rtl8365mb_frame_ingress accepted_frame;
+	struct realtek_priv *priv = ds->priv;
+	u8 _unused_first_free_idx;
+	u8 vlanmc_idx;
+	int ret;
+
+	if (!pvid)
+		return 0;
+
+	/* look for existing entry */
+	ret = rtl8365mb_vlan_mc_find(priv, vlan->vid, &vlanmc_idx,
+				     &_unused_first_free_idx);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to find a VLAN MC table index");
+		return ret;
+	}
+
+	if (!vlanmc_idx) {
+		RTL_VLAN_ERR("VLAN should already exist in VLAN MC");
+		return ret;
+	}
+
+	ret = rtl8365mb_vlan_port_set_pvid(priv, port, vlanmc_idx);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port PVID");
+		return ret;
+	}
+
+	/* Changing accept frame is what enables PVID (if not enabled before) */
+	accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;
+	ret = rtl8365mb_vlan_port_set_framefilter(priv, port, accepted_frame);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port frame filter");
+		return ret;
+	}
+
+	return 0;
+}
+
+int rtl8365mb_vlan_pvid_port_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	enum rtl8365mb_frame_ingress accepted_frame;
+	struct netlink_ext_ack *extack = NULL;
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlanmc vlanmc = {0};
+	u8 vlanmc_idx;
+	int ret;
+
+	ret = rtl8365mb_vlan_port_get_pvid(priv, port, &vlanmc_idx);
+	if (ret)
+		return ret;
+
+	/* Port is not using PVID. Nothing to remove. */
+	if (!vlanmc_idx)
+		return 0;
+
+	ret = rtl8365mb_vlan_mc_read(priv, vlanmc_idx, &vlanmc);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read VLAN MC table");
+		return ret;
+	}
+
+	/* We are leaving a non PVID vlan, Nothing to remove. */
+	if (vlanmc.evid != vlan->vid)
+		return 0;
+
+	/* Changing accept frame is what really removes PVID */
+	accepted_frame = RTL8365MB_FRAME_TYPE_TAGGED_ONLY;
+	ret = rtl8365mb_vlan_port_set_framefilter(priv, port, accepted_frame);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port frame filter");
+		return ret;
+	}
+
+	ret = rtl8365mb_vlan_port_set_pvid(priv, port, 0);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to set port PVID to 0");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8365mb_vlan_mc_write(struct realtek_priv *priv, u32 index,
+				   const struct rtl8365mb_vlanmc *vlanmc)
+{
+	u16 data[4] = { 0 };
+	int ret;
+
+	if (index > RTL8365MB_VLAN_MCMAX ||
+	    vlanmc->fid > RTL8365MB_FIDMAX ||
+	    vlanmc->priority > RTL8365MB_PRIORITYMAX ||
+	    vlanmc->meteridx > RTL8365MB_METERMAX)
+		return -EINVAL;
+
+	data[0] |= FIELD_PREP(RTL8365MB_VLAN_MC_D0_MBR_MASK, vlanmc->member);
+	data[1] |= FIELD_PREP(RTL8365MB_VLAN_MC_D1_FID_MASK, vlanmc->fid);
+	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_METERIDX_MASK,
+			      vlanmc->meteridx);
+	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_ENVLANPOL_MASK,
+			      vlanmc->policing_en);
+	data[2] |=
+		FIELD_PREP(RTL8365MB_VLAN_MC_D2_VBPRI_MASK, vlanmc->priority);
+	data[2] |= FIELD_PREP(RTL8365MB_VLAN_MC_D2_VBPEN_MASK,
+			      vlanmc->priority_en);
+	data[3] |= FIELD_PREP(RTL8365MB_VLAN_MC_D3_EVID_MASK, vlanmc->evid);
+
+	ret = regmap_bulk_write(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
+				RTL8365MB_VLAN_MC_ENTRY_SIZE);
+
+	return ret;
+}
+
+static int rtl8365mb_vlan_mc_erase(struct realtek_priv *priv, u32 index)
+{
+	u16 data[4] = { 0 };
+	int ret;
+
+	if (index > RTL8365MB_VLAN_MCMAX)
+		return -EINVAL;
+
+	ret = regmap_bulk_write(priv->map, RTL8365MB_VLAN_MC_REG(index), &data,
+				RTL8365MB_VLAN_MC_ENTRY_SIZE);
+
+	return ret;
+}
+
+/** rtl8365mb_vlanmc_port_set() - include or exclude a port from vlanMC
+ * @ds: dsa switch
+ * @port: the port number
+ * @vlan: the vlan to include/exclude @port
+ * @extack: optional extack to return errors
+ * @include: whether to include or exclude @port
+ *
+ * This function is used to include/exclude ports to the vlanMC table.
+ *
+ * VlanMC stands for VLAN membership config and it is used exclusively for
+ * PVID. If @vlan members are not using PVID, this function will either
+ * remove or not create a new vlanMC entry.
+ *
+ * vlanMC members are kept in sync with vlan4k, although the switch only
+ * checks membership in vlan4k table.
+ *
+ * Port PVID and accepted frame type are updated as well.
+ *
+ * Return: Returns 0 on success, a negative error on failure.
+ *
+ */
+static
+int rtl8365mb_vlan_mc_port_set(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack,
+			       bool include)
+{
+	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb_vlan4k vlan4k = {0};
+	struct rtl8365mb_vlanmc vlanmc = {0};
+	u16 pvid_members = 0;
+	u8 first_unused = 0;
+	u8 vlanmc_idx = 0;
+	int ret;
+
+	dev_dbg(priv->dev, "%s VLAN %d MC on port %d\n",
+		include ? "add" : "del",
+		vlan->vid, port);
+
+	if (vlan->vid > RTL8365MB_MAX_MC_VID) {
+		RTL_VLAN_ERR("VLAN ID greater than "
+			     __stringify(RTL8365MB_MAX_MC_VID));
+		return -EINVAL;
+	}
+
+	/* look for existing entry or an empty slot */
+	ret = rtl8365mb_vlan_mc_find(priv, vlan->vid, &vlanmc_idx,
+				     &first_unused);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to find a VLAN MC table index");
+		return ret;
+	}
+
+	if (vlanmc_idx) {
+		ret = rtl8365mb_vlan_mc_read(priv, vlanmc_idx, &vlanmc);
+		if (ret) {
+			RTL_VLAN_ERR("Failed to read VLAN MC table");
+			return ret;
+		}
+	} else if (include) {
+		/* for now, vlan_mc is only required for PVID. Defer allocation
+		 * until at least one port uses PVID.
+		 */
+		if (!pvid) {
+			dev_dbg(priv->dev,
+				"Not creating VlanMC for vlan %d until a port uses PVID (%d does not)\n",
+				vlan->vid, port);
+			return 0;
+		}
+
+		if (!first_unused) {
+			RTL_VLAN_ERR("All VLAN MC entries ("
+				     __stringify(RTL8365MB_VLAN_MCMAX + 1)
+				     ") are in use.");
+			return -E2BIG;
+		}
+
+		/* Retrieve vlan4k members as we might have deferred VlanMC
+		 * before.
+		 */
+		if (vlan->vid <= RTL8365MB_MAX_4K_VID) {
+			ret = rtl8365mb_vlan_4k_read(priv, vlan->vid, &vlan4k);
+			if (ret) {
+				RTL_VLAN_ERR("Failed to read VLAN 4k table");
+				return ret;
+			}
+		}
+
+		vlanmc_idx = first_unused;
+		vlanmc.evid = vlan->vid;
+
+		/* for new vlan_mc, sync current vlan4k members,
+		 * although only vlan4k members matter.
+		 */
+		vlanmc.member |= vlan4k.member;
+	} else /* excluding and VLANMC not found */ {
+		return 0;
+	}
+
+	ret = rtl8365mb_vlan_mc_pvid_members(ds, vlanmc_idx,
+					     &pvid_members);
+	if (ret) {
+		RTL_VLAN_ERR("Failed to read VLANMC PVID members");
+		return ret;
+	}
+	dev_dbg(priv->dev,
+		"VLAN %d (idx: %d) PVID curr members: %08x\n",
+		vlan->vid, vlanmc_idx, pvid_members);
+
+	/* here we either have an existing VLANMC (with PVID members) or the
+	 * added port is using this VLAN as PVID
+	 */
+	if (include) {
+		vlanmc.member |= BIT(port);
+		if (pvid)
+			pvid_members |= BIT(port);
+	} else {
+		vlanmc.member &= ~BIT(port);
+		pvid_members &= ~BIT(port);
+	}
+
+	/* just like we don't need to create a VLAN_MC when there is no port
+	 * using it as PVID, we can erase it when there is no more port using
+	 * it as PVID.
+	 */
+	if (!pvid_members) {
+		dev_dbg(priv->dev,
+			"Clearing VlanMC index %d previously used by VID %d\n",
+			vlanmc_idx, vlan->vid);
+		ret = rtl8365mb_vlan_mc_erase(priv, vlanmc_idx);
+	} else {
+		dev_dbg(priv->dev,
+			"Saving VlanMC index %d with VID %d\n",
+			vlanmc_idx, vlan->vid);
+		ret = rtl8365mb_vlan_mc_write(priv, vlanmc_idx, &vlanmc);
+	}
+	if (ret) {
+		RTL_VLAN_ERR("Failed to write vlan MC entry");
+		return ret;
+	}
+
+	return 0;
+}
+
+int rtl8365mb_vlan_mc_port_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack)
+{
+	return rtl8365mb_vlan_mc_port_set(ds, port, vlan, extack, true);
+}
+
+int rtl8365mb_vlan_mc_port_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan)
+{
+	return rtl8365mb_vlan_mc_port_set(ds, port, vlan, NULL, false);
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
new file mode 100644
index 000000000000..bd0cf4c804c8
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* VLAN configuration interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ *
+ */
+
+#ifndef _REALTEK_RTL8365MB_VLAN_H
+#define _REALTEK_RTL8365MB_VLAN_H
+
+#include <linux/types.h>
+
+#include "realtek.h"
+
+int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack);
+int rtl8365mb_vlan_4k_port_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan);
+int rtl8365mb_vlan_mc_port_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack);
+int rtl8365mb_vlan_mc_port_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan);
+int rtl8365mb_vlan_pvid_port_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack);
+int rtl8365mb_vlan_pvid_port_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan);
+#endif /* _REALTEK_RTL8365MB_VLAN_H */

-- 
2.53.0


