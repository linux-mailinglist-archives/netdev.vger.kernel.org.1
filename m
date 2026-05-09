Return-Path: <netdev+bounces-286128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM+FDEP5/mng0gAAu9opvQ
	(envelope-from <netdev+bounces-286128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:07:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D21764FEE72
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 352AB300E68B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7753932C9;
	Sat,  9 May 2026 09:06:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B1382373;
	Sat,  9 May 2026 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317613; cv=none; b=YSWJklMn5y4hKmEnJsdmUNtRsIaFpDrfBE4Ag0Qwr73y7VnDYD2Lz4ePHUGI4hVc+Eriz0cWpKGUIRImgKreIlwIkxO2c0VxeJSlldso+kWOUetb4tw+Z69KbKWtAX4ObyYdwgmu5rMC5/du3HSqipm+Yd0iPCGjYOmPEWFNdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317613; c=relaxed/simple;
	bh=OnKjnFJS3xtL4DQULvLjNr0RzpBywTnIzjHK88BtHck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5aTApDuKHG3e0/Us3JtR+5slRVXfz53X73mAJBRmm+hOAtmars666JBz/WpIsc1f5azZyyksbevT+O223MfGKa91utUyTk767yNUXVR6rAzoxt30btir5jPB47hPPAxCAZF5hYTdJiC7WaB5Ube13bUj3tneSh4tJiyIfwiRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DB8B20232C;
	Sat,  9 May 2026 11:06:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 886CA203A24;
	Sat,  9 May 2026 11:06:47 +0200 (CEST)
Received: from lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com [10.52.8.159])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BE8018002D1;
	Sat,  9 May 2026 17:06:45 +0800 (+08)
From: Minghuan Lian <minghuan.lian@nxp.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Minghuan Lian <minghuan.lian@nxp.com>
Subject: [PATCH net-next 3/4] net: dsa: hms: Add NXP i.MX RT1180 NETC switch driver
Date: Sat,  9 May 2026 18:06:31 +0900
Message-ID: <20260509090632.2959553-4-minghuan.lian@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509090632.2959553-1-minghuan.lian@nxp.com>
References: <20260509090632.2959553-1-minghuan.lian@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: D21764FEE72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286128-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.349];
	FROM_NEQ_ENVFROM(0.00)[minghuan.lian@nxp.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,param.id:url,cmd.link:url]
X-Rspamd-Action: no action

Add a DSA driver for the NXP i.MX RT1180 NETC Ethernet switch when it is
managed by firmware running on the RT1180 and controlled by Linux through
the Heterogeneous Multi-SoC (HMS) command interface over SPI.

The driver registers the RT1180 switch with DSA, configures the CPU port
and user ports, and provides the basic switch operations needed for data
path bring-up: phylink integration, MTU configuration and tag_8021q
setup.

The SPI transport implements the HMS command header format used to
exchange configuration commands with the switch firmware.

Signed-off-by: Minghuan Lian <minghuan.lian@nxp.com>
---
 MAINTAINERS                      |   9 +
 drivers/net/dsa/Kconfig          |   2 +
 drivers/net/dsa/Makefile         |   1 +
 drivers/net/dsa/hms/Kconfig      |  14 +
 drivers/net/dsa/hms/Makefile     |   8 +
 drivers/net/dsa/hms/hms_config.c | 253 +++++++++
 drivers/net/dsa/hms/hms_config.h | 259 +++++++++
 drivers/net/dsa/hms/hms_main.c   | 934 +++++++++++++++++++++++++++++++
 drivers/net/dsa/hms/hms_spi.c    | 116 ++++
 drivers/net/dsa/hms/hms_switch.h |  67 +++
 10 files changed, 1663 insertions(+)
 create mode 100644 drivers/net/dsa/hms/Kconfig
 create mode 100644 drivers/net/dsa/hms/Makefile
 create mode 100644 drivers/net/dsa/hms/hms_config.c
 create mode 100644 drivers/net/dsa/hms/hms_config.h
 create mode 100644 drivers/net/dsa/hms/hms_main.c
 create mode 100644 drivers/net/dsa/hms/hms_spi.c
 create mode 100644 drivers/net/dsa/hms/hms_switch.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbbbde6b907a..6e66366576a09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19336,6 +19336,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/fsl,sgtl5000.yaml
 F:	sound/soc/codecs/sgtl5000*
 
+NXP HMS DSA SWITCH DRIVER
+M:	Minghuan Lian <minghuan.lian@nxp.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/nxp,imxrt1180-netc-switch.yaml
+F:	drivers/net/dsa/hms/
+F:	include/linux/dsa/tag_hms.h
+F:	net/dsa/tag_hms.c
+
 NXP SJA1105 ETHERNET SWITCH DRIVER
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 39fb8ead16b5f..ce116b7db9ec4 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -26,6 +26,8 @@ config NET_DSA_LOOP
 
 source "drivers/net/dsa/hirschmann/Kconfig"
 
+source "drivers/net/dsa/hms/Kconfig"
+
 source "drivers/net/dsa/lantiq/Kconfig"
 
 config NET_DSA_MT7530
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index f5a463b87ec25..239bad66deddc 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 obj-y				+= b53/
 obj-y				+= hirschmann/
+obj-y				+= hms/
 obj-y				+= lantiq/
 obj-y				+= microchip/
 obj-y				+= mv88e6xxx/
diff --git a/drivers/net/dsa/hms/Kconfig b/drivers/net/dsa/hms/Kconfig
new file mode 100644
index 0000000000000..4f209b4c64131
--- /dev/null
+++ b/drivers/net/dsa/hms/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_HMS_SWITCH
+	tristate "NXP HMS DSA switch driver"
+	depends on NET_DSA
+	depends on SPI
+	select NET_DSA_TAG_HMS
+	select NET_DSA_TAG_8021Q
+	help
+	  This enables support for the NXP i.MX RT1180 NETC Ethernet
+	  switch managed through the Heterogeneous Multi-SoC (HMS)
+	  interface over SPI.
+
+	  Say Y or M if your system uses an i.MX RT1180 as a companion
+	  switch controller and exposes its switch ports through DSA.
diff --git a/drivers/net/dsa/hms/Makefile b/drivers/net/dsa/hms/Makefile
new file mode 100644
index 0000000000000..acf6a8f2d953b
--- /dev/null
+++ b/drivers/net/dsa/hms/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NET_DSA_HMS_SWITCH) += hms.o
+
+hms-objs := \
+	hms_spi.o \
+	hms_config.o \
+	hms_main.o
diff --git a/drivers/net/dsa/hms/hms_config.c b/drivers/net/dsa/hms/hms_config.c
new file mode 100644
index 0000000000000..daddb4db3d294
--- /dev/null
+++ b/drivers/net/dsa/hms/hms_config.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP HMS (Heterogeneous Multi-SoC) DSA Switch Configuration
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/slab.h>
+#include "hms_switch.h"
+
+int hms_get_devinfo(struct hms_private *priv, struct hms_config *config)
+{
+	struct hms_cmd_sysinfo sysinfo;
+	int rc;
+
+	rc = hms_xfer_get_cmd(priv, HMS_CMD_SYS_INFO_GET, 0,
+			      &sysinfo, sizeof(sysinfo));
+	if (rc)
+		return rc;
+
+	config->device_id = sysinfo.device_id;
+	config->vendor_id = sysinfo.vendor_id;
+	config->version_major = sysinfo.version_major;
+	config->version_minor = sysinfo.version_minor;
+	config->version_revision = sysinfo.version_revision;
+	config->cpu_port = sysinfo.cpu_port;
+
+	return 0;
+}
+
+int hms_port_mtu_set(struct hms_private *priv, int port, int mtu)
+{
+	struct hms_cmd_port_mtu cmd;
+
+	cmd.port = port;
+	cmd.mtu = mtu;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_PORT_MTU_SET,
+				&cmd, sizeof(cmd));
+}
+
+int hms_port_mtu_get(struct hms_private *priv, int port, int *mtu)
+{
+	struct hms_cmd_port_mtu cmd;
+	int rc;
+
+	rc = hms_xfer_get_cmd(priv, HMS_CMD_PORT_MTU_GET, port,
+			      &cmd, sizeof(cmd));
+	if (rc)
+		return rc;
+
+	*mtu = cmd.mtu;
+
+	return 0;
+}
+
+int hms_port_phylink_mode_set(struct hms_private *priv,
+			      struct hms_mac_config *mac)
+{
+	struct hms_cmd_port_phylink_mode cmd;
+
+	cmd.port = mac->port;
+	cmd.duplex = mac->duplex;
+	cmd.speed = mac->speed;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_PORT_PHYLINK_MODE_SET,
+				&cmd, sizeof(cmd));
+}
+
+int hms_port_phylink_status_get(struct hms_private *priv,
+				struct hms_mac_config *mac)
+{
+	struct hms_cmd_port_phylink_status status;
+	int rc;
+
+	rc = hms_xfer_get_cmd(priv, HMS_CMD_PORT_PHYLINK_STATUS_GET, mac->port,
+			      &status, sizeof(status));
+	if (rc)
+		return rc;
+
+	mac->link = status.link;
+	mac->speed = status.speed;
+	mac->duplex = status.duplex;
+
+	return 0;
+}
+
+int hms_port_pvid_set(struct hms_private *priv, int port, u16 pvid)
+{
+	struct hms_cmd_port_pvid cmd;
+
+	cmd.port = port;
+	cmd.pvid = pvid;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_PORT_PVID_SET,
+				&cmd, sizeof(cmd));
+}
+
+int hms_port_link_set(struct hms_private *priv, int port, bool up)
+{
+	struct hms_cmd_port_link cmd;
+
+	cmd.port = port;
+	cmd.link = up;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_PORT_LINK_SET,
+				&cmd, sizeof(cmd));
+}
+
+int hms_port_dropuntag_set(struct hms_private *priv, int port, bool drop)
+{
+	struct hms_cmd_port_dropuntag cmd;
+
+	cmd.port = port;
+	cmd.drop = drop;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_PORT_DROPUNTAG_SET,
+				&cmd, sizeof(cmd));
+}
+
+int hms_port_dsa_add(struct hms_private *priv, int cpu_port,
+		     int user_port, const unsigned char *mac_addr)
+{
+	struct hms_cmd_port_dsa_add cmd;
+
+	cmd.cpu_port = cpu_port;
+	cmd.user_port = user_port;
+	memcpy(cmd.mac_addr, mac_addr, ETH_ALEN);
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_PORT_DSA_ADD,
+				&cmd, sizeof(cmd));
+}
+
+int hms_port_dsa_del(struct hms_private *priv, int user_port)
+{
+	struct hms_cmd_port_dsa_del cmd;
+
+	cmd.user_port = user_port;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_PORT_DSA_DEL,
+				&cmd, sizeof(cmd));
+}
+
+int hms_vlan_entry_add(struct hms_private *priv,
+		       u16 vid, int port, bool untagged)
+{
+	struct hms_cmd_vlan cmd;
+
+	cmd.vid = vid;
+	cmd.port = port;
+	cmd.untagged = untagged;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_VLAN_ADD,
+				&cmd, sizeof(cmd));
+}
+
+int hms_vlan_entry_del(struct hms_private *priv, u16 vid, int port)
+{
+	struct hms_cmd_vlan cmd;
+
+	cmd.vid = vid;
+	cmd.port = port;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_VLAN_DEL,
+				&cmd, sizeof(cmd));
+}
+
+int hms_vlan_entry_read(struct hms_private *priv,
+			struct hms_vlan_entry *vlan,
+			u32 entry_id, u32 *next_id)
+{
+	struct hms_cmd_vlan_dump resp;
+	int rc;
+
+	rc = hms_xfer_get_cmd(priv, HMS_CMD_VLAN_DUMP, entry_id,
+			      &resp, sizeof(resp));
+	if (rc)
+		return rc;
+
+	vlan->vid = resp.vid;
+	vlan->port_map = resp.port_map;
+	*next_id = resp.resume_entry_id;
+
+	return 0;
+}
+
+int hms_fdb_entry_add(struct hms_private *priv,
+		      const unsigned char *mac_addr,
+		      u16 vid, int port)
+{
+	struct hms_cmd_fdb cmd;
+
+	memcpy(cmd.mac_addr, mac_addr, ETH_ALEN);
+	cmd.vid = vid;
+	cmd.port = port;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_FDB_ADD,
+				&cmd, sizeof(cmd));
+}
+
+int hms_fdb_entry_del(struct hms_private *priv,
+		      const unsigned char *mac_addr,
+		      u16 vid, int port)
+{
+	struct hms_cmd_fdb cmd;
+
+	memcpy(cmd.mac_addr, mac_addr, ETH_ALEN);
+	cmd.vid = vid;
+	cmd.port = port;
+
+	return hms_xfer_set_cmd(priv, HMS_CMD_FDB_DEL,
+				&cmd, sizeof(cmd));
+}
+
+int hms_fdb_entry_get(struct hms_private *priv, struct hms_fdb_entry *fdb,
+		      u32 entry_id, u32 *next_id)
+{
+	struct hms_cmd_fdb_dump resp;
+	int rc;
+
+	rc = hms_xfer_get_cmd(priv, HMS_CMD_FDB_DUMP, entry_id,
+			      &resp, sizeof(resp));
+	if (rc)
+		return rc;
+
+	memcpy(fdb->mac_addr, resp.mac_addr, ETH_ALEN);
+	fdb->vid = resp.vid;
+	fdb->port_map = resp.port_map;
+	fdb->dynamic = resp.dynamic;
+	*next_id = resp.resume_entry_id;
+
+	return 0;
+}
+
+int hms_config_setup(struct hms_config *config)
+{
+	config->vlan_max_count = 256;
+	config->vlan = kcalloc(config->vlan_max_count,
+			       sizeof(struct hms_vlan_entry),
+			       GFP_KERNEL);
+	if (!config->vlan)
+		return -ENOMEM;
+
+	config->vlan_count = 0;
+
+	return 0;
+}
+
+void hms_config_free(struct hms_config *config)
+{
+	kfree(config->vlan);
+	config->vlan = NULL;
+}
diff --git a/drivers/net/dsa/hms/hms_config.h b/drivers/net/dsa/hms/hms_config.h
new file mode 100644
index 0000000000000..a54adefe794d6
--- /dev/null
+++ b/drivers/net/dsa/hms/hms_config.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NXP HMS (Heterogeneous Multi-SoC) DSA Switch Configuration
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef _HMS_CONFIG_H
+#define _HMS_CONFIG_H
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define HMS_RT1180_DEVICE_ID		0xe001
+#define HMS_NUM_PORTS			5
+#define HMS_MAX_NUM_PORTS		HMS_NUM_PORTS
+#define HMS_NUM_TC			8
+
+#define HMS_ETHTOOL_STATS_NUM_MAX	120
+
+#define HMS_SPI_WORD_BITS		8
+#define HMS_SPI_MSG_WORD_BYTES		4
+#define HMS_SPI_MSG_HEADER_SIZE		20
+#define HMS_SPI_MSG_PARAM_SIZE		16
+#define HMS_SPI_MSG_MAXLEN		4096
+#define HMS_SPI_MSG_RESPONSE_TIME	1000 /* us */
+
+#define HMS_CMD_DIR_SHIFT		31
+#define HMS_CMD_LEN_SHIFT		16
+
+enum hms_spi_rw_mode {
+	SPI_READ = 0,
+	SPI_WRITE = 1,
+};
+
+struct hms_cmd_hdr {
+	u32 cmd;
+	u8 param[HMS_SPI_MSG_PARAM_SIZE];
+};
+
+/* Command */
+enum hms_cmd {
+	/* Port related commands */
+	HMS_CMD_SYS_INFO_GET = 0x1,
+	HMS_CMD_PORT_DSA_ADD,
+	HMS_CMD_PORT_DSA_DEL,
+	HMS_CMD_PORT_MTU_SET,
+	HMS_CMD_PORT_MTU_GET,
+	HMS_CMD_PORT_PHYLINK_MODE_SET,
+	HMS_CMD_PORT_PHYLINK_STATUS_GET,
+	HMS_CMD_PORT_ETHTOOL_STATS_GET,
+	HMS_CMD_PORT_PVID_SET,
+	HMS_CMD_PORT_LINK_SET,
+	HMS_CMD_PORT_DROPUNTAG_SET,
+
+	/* FDB/VLAN commands */
+	HMS_CMD_FDB_ADD = 0x1000,
+	HMS_CMD_FDB_DEL,
+	HMS_CMD_FDB_DUMP,
+	HMS_CMD_VLAN_ADD,
+	HMS_CMD_VLAN_DEL,
+	HMS_CMD_VLAN_DUMP,
+
+	HMS_CMD_MAX_NUM,
+};
+
+struct hms_cmd_sysinfo {
+	u16 device_id;
+	u16 vendor_id;
+	u8  version_major;
+	u8  version_minor;
+	u8  version_revision;
+	u8  cpu_port;
+};
+
+/* command data for HMS_CMD_PORT_DSA_ADD */
+struct hms_cmd_port_dsa_add {
+	u8 cpu_port;
+	u8 user_port;
+	u8 mac_addr[ETH_ALEN];
+};
+
+/* command data for HMS_CMD_PORT_DSA_DEL */
+struct hms_cmd_port_dsa_del {
+	u8 user_port;
+	u8 reserved[3];
+};
+
+/* command data for HMS_CMD_PORT_MTU_SET */
+struct hms_cmd_port_mtu {
+	u8 port;
+	u8 reserved;
+	u16 mtu;
+};
+
+/* command data for HMS_CMD_PORT_PHYLINK_MODE_SET */
+struct hms_cmd_port_phylink_mode {
+	u8 port;
+	bool duplex;
+	u16 speed;
+};
+
+/* command data for HMS_CMD_PORT_PVID_SET */
+struct hms_cmd_port_pvid {
+	u8 port;
+	u8 reserved;
+	u16 pvid;
+};
+
+/* command data for hms_cmd_port_link */
+struct hms_cmd_port_link {
+	u8 port;
+	bool link;
+	u8 reserved[2];
+};
+
+/* command data for hms_cmd_port_dropuntag */
+struct hms_cmd_port_dropuntag {
+	u8 port;
+	u8 reserved;
+	u16 drop;
+};
+
+/* command data for HMS_CMD_FDB_ADD */
+struct hms_cmd_fdb {
+	u8 mac_addr[ETH_ALEN];
+	u16 vid;
+	u8 port;
+	u8 reserved[3];
+};
+
+/* command data for HMS_CMD_VLAN_ADD */
+struct hms_cmd_vlan {
+	u16 vid;
+	u8 port;
+	bool untagged;
+};
+
+/* data returned for HMS_CMD_PORT_PHYLINK_STATUS_GET */
+struct hms_cmd_port_phylink_status {
+	u8 port;
+	bool link;
+	u16 speed;
+	bool duplex;
+	u8 reserved[3];
+};
+
+/* command param */
+struct hms_cmd_read_param {
+	u32 id;
+};
+
+/* data returned for HMS_CMD_FDB_DUMP */
+struct hms_cmd_fdb_dump {
+	u8 mac_addr[ETH_ALEN];
+	u16 vid;
+	u32 port_map;
+	bool dynamic;
+	u8 reserved[3];
+	u32 resume_entry_id;
+};
+
+/* data returned for HMS_CMD_VLAN_DUMP */
+struct hms_cmd_vlan_dump {
+	u16 vid;
+	bool untagged;
+	u8 reserved;
+	u32 port_map;
+	u32 resume_entry_id;
+};
+
+struct hms_cmd_port_ethtool_stats {
+	u64 values[HMS_ETHTOOL_STATS_NUM_MAX];
+};
+
+struct hms_mac_config {
+	u8 port;
+	u16 speed;
+	u16 vlanid;
+	bool link;
+	bool egress;
+	bool ingress;
+	bool duplex;
+	bool drptag;
+	bool drpuntag;
+	bool retag;
+};
+
+struct hms_fdb_entry {
+	u8 mac_addr[ETH_ALEN];
+	u16 vid;
+	u32 port_map;
+	bool dynamic;
+};
+
+struct hms_vlan_entry {
+	u16 vid;
+	u16 port;
+	u32 port_map;
+	u32 tag_ports;
+	u32 entry_id;
+};
+
+struct hms_config {
+	u16 device_id;
+	u16 vendor_id;
+	u8  version_major;
+	u8  version_minor;
+	u8  version_revision;
+	u8  cpu_port_mode;
+	u16 tpid;
+	u16 tpid2;
+	struct hms_mac_config mac[HMS_MAX_NUM_PORTS];
+	int cpu_port;
+	int vlan_count;
+	int vlan_max_count;
+	struct hms_vlan_entry *vlan;
+};
+
+struct hms_private;
+
+int hms_get_devinfo(struct hms_private *priv, struct hms_config *config);
+
+int hms_port_phylink_mode_set(struct hms_private *priv,
+			      struct hms_mac_config *mac);
+int hms_port_phylink_status_get(struct hms_private *priv,
+				struct hms_mac_config *mac);
+int hms_port_pvid_set(struct hms_private *priv, int port, u16 pvid);
+int hms_port_link_set(struct hms_private *priv, int port, bool up);
+int hms_port_dropuntag_set(struct hms_private *priv, int port, bool drop);
+
+int hms_port_mtu_set(struct hms_private *priv, int port, int mtu);
+int hms_port_mtu_get(struct hms_private *priv, int port, int *mtu);
+
+int hms_port_dsa_add(struct hms_private *priv, int cpu_port,
+		     int user_port, const unsigned char *mac_addr);
+int hms_port_dsa_del(struct hms_private *priv, int user_port);
+
+int hms_fdb_entry_add(struct hms_private *priv,
+		      const unsigned char *mac_addr,
+		      u16 vid, int port);
+int hms_fdb_entry_del(struct hms_private *priv,
+		      const unsigned char *mac_addr,
+		      u16 vid, int port);
+int hms_fdb_entry_get(struct hms_private *priv,
+		      struct hms_fdb_entry *fdb,
+		      u32 entry_id, u32 *next_id);
+
+int hms_vlan_entry_add(struct hms_private *priv,
+		       u16 vid, int port, bool untagged);
+int hms_vlan_entry_del(struct hms_private *priv, u16 vid, int port);
+int hms_vlan_entry_read(struct hms_private *priv,
+			struct hms_vlan_entry *vlan,
+			u32 entry_id, u32 *next_id);
+
+int hms_config_setup(struct hms_config *config);
+void hms_config_free(struct hms_config *config);
+
+#endif /* _HMS_CONFIG_H */
diff --git a/drivers/net/dsa/hms/hms_main.c b/drivers/net/dsa/hms/hms_main.c
new file mode 100644
index 0000000000000..b7f7c3a7d3667
--- /dev/null
+++ b/drivers/net/dsa/hms/hms_main.c
@@ -0,0 +1,934 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP HMS (Heterogeneous Multi-SoC) DSA Switch Driver
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/spi/spi.h>
+#include <linux/errno.h>
+#include <linux/phylink.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/of_mdio.h>
+#include <linux/of_device.h>
+#include <linux/netdev_features.h>
+#include <linux/netdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/dsa/tag_hms.h>
+#include "hms_switch.h"
+
+int hms_is_vlan_configured(struct hms_private *priv, u16 vid)
+{
+	struct hms_vlan_entry *vlan;
+	int count, i;
+
+	vlan = priv->config.vlan;
+	count = priv->config.vlan_count;
+
+	for (i = 0; i < count; i++) {
+		if (vlan[i].vid == vid)
+			return i;
+	}
+
+	/* Return an invalid entry index if not found */
+	return -1;
+}
+
+static bool vid_is_hms_dsa_8021q(struct dsa_switch *ds, u16 vid)
+{
+	int port;
+	struct dsa_port *dp;
+	unsigned int bridge_num;
+	u16 standalone_vid, bridge_vid;
+
+	for (port = 0; port < ds->num_ports; port++) {
+		dp = dsa_to_port(ds, port);
+		standalone_vid = dsa_tag_8021q_standalone_vid(dp);
+
+		if (vid == standalone_vid)
+			return true;
+
+		if (dp->bridge) {
+			bridge_num = dsa_port_bridge_num_get(dp);
+			bridge_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+
+			if (vid == bridge_vid)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int hms_drop_untagged(struct dsa_switch *ds, int port, bool drop)
+{
+	struct hms_private *priv = ds->priv;
+	struct hms_mac_config *mac;
+
+	mac = &priv->config.mac[port];
+	if (mac->drpuntag == drop)
+		return 0;
+
+	mac->drpuntag = drop;
+
+	return hms_port_dropuntag_set(priv, port, drop);
+}
+
+static int hms_pvid_apply(struct hms_private *priv, int port, u16 pvid)
+{
+	struct hms_mac_config *mac;
+
+	mac = &priv->config.mac[port];
+	if (mac->vlanid == pvid)
+		return 0;
+
+	mac->vlanid = pvid;
+
+	return hms_port_pvid_set(priv, port, pvid);
+}
+
+static int hms_commit_pvid(struct dsa_switch *ds, int port)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct net_device *br = dsa_port_bridge_dev_get(dp);
+	struct hms_private *priv = ds->priv;
+	bool drop_untagged = false;
+	int rc;
+	u16 pvid;
+
+	if (br && br_vlan_enabled(br))
+		pvid = priv->bridge_pvid[port];
+	else
+		pvid = priv->tag_8021q_pvid[port];
+
+	rc = hms_pvid_apply(priv, port, pvid);
+	if (rc)
+		return rc;
+
+	/*
+	 * Only force dropping of untagged packets when the port is under a
+	 * VLAN-aware bridge. When the tag_8021q pvid is used, we are
+	 * deliberately removing the RX VLAN from the port's VMEMB_PORT list,
+	 * to prevent DSA tag spoofing from the link partner. Untagged packets
+	 * are the only ones that should be received with tag_8021q, so
+	 * definitely don't drop them.
+	 */
+	if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
+		drop_untagged = true;
+
+	return hms_drop_untagged(ds, port, drop_untagged);
+}
+
+static int hms_fdb_add(struct dsa_switch *ds, int port,
+		       const unsigned char *addr, u16 vid,
+		       struct dsa_db db)
+{
+	struct hms_private *priv = ds->priv;
+	int rc;
+
+	if (!vid) {
+		switch (db.type) {
+		case DSA_DB_PORT:
+			vid = dsa_tag_8021q_standalone_vid(db.dp);
+			break;
+		case DSA_DB_BRIDGE:
+			vid = dsa_tag_8021q_bridge_vid(db.bridge.num);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/* Allow enough time between consecutive calls for adding FDB entry */
+	usleep_range(HMS_SPI_MSG_RESPONSE_TIME,
+		     HMS_SPI_MSG_RESPONSE_TIME * 10);
+
+	mutex_lock(&priv->fdb_lock);
+	rc = hms_fdb_entry_add(priv, addr, vid, port);
+	mutex_unlock(&priv->fdb_lock);
+
+	return rc;
+}
+
+static int hms_fdb_del(struct dsa_switch *ds, int port,
+		       const unsigned char *addr, u16 vid,
+		       struct dsa_db db)
+{
+	struct hms_private *priv = ds->priv;
+	int rc;
+
+	if (!vid) {
+		switch (db.type) {
+		case DSA_DB_PORT:
+			vid = dsa_tag_8021q_standalone_vid(db.dp);
+			break;
+		case DSA_DB_BRIDGE:
+			vid = dsa_tag_8021q_bridge_vid(db.bridge.num);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	mutex_lock(&priv->fdb_lock);
+	rc = hms_fdb_entry_del(priv, addr, vid, port);
+	mutex_unlock(&priv->fdb_lock);
+
+	return rc;
+}
+
+static int hms_fdb_dump(struct dsa_switch *ds, int port,
+			dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct hms_private *priv = ds->priv;
+	struct device *dev = ds->dev;
+	u32 entry_id = 0, next_id = 0;
+	int rc;
+
+	while (1) {
+		struct hms_fdb_entry fdb = {0};
+
+		rc = hms_fdb_entry_get(priv, &fdb, entry_id, &next_id);
+		/* No fdb entry at i, not an issue */
+		if (rc) {
+			dev_err(dev, "Failed to dump FDB: %d\n", rc);
+			return rc;
+		}
+
+		if (next_id == 0) /* This entry is empty */
+			return 0;
+
+		/*
+		 * FDB dump callback is per port. This means we have to
+		 * disregard a valid entry if it's not for this port, even if
+		 * only to revisit it later. This is inefficient because the
+		 * 1024-sized FDB table needs to be traversed 4 times through
+		 * SPI during a 'bridge fdb show' command.
+		 */
+		if (fdb.port_map & BIT(port)) {
+			/* Need to hide the dsa_8021q VLANs from the user. */
+			if (vid_is_hms_dsa_8021q(ds, fdb.vid))
+				fdb.vid = 0;
+
+			rc = cb(fdb.mac_addr, fdb.vid, fdb.dynamic, data);
+			if (rc)
+				return rc;
+		}
+
+		entry_id = next_id;
+
+		if (entry_id == 0 || entry_id == 0xffffffff)
+			break;
+	}
+
+	return 0;
+}
+
+static int hms_mdb_add(struct dsa_switch *ds, int port,
+		       const struct switchdev_obj_port_mdb *mdb,
+		       struct dsa_db db)
+{
+	return hms_fdb_add(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int hms_mdb_del(struct dsa_switch *ds, int port,
+		       const struct switchdev_obj_port_mdb *mdb,
+		       struct dsa_db db)
+{
+	return hms_fdb_del(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int hms_parse_ports_node(struct hms_private *priv,
+				struct device_node *ports_node)
+{
+	struct device *dev = &priv->spidev->dev;
+	struct device_node *child;
+
+	for_each_available_child_of_node(ports_node, child) {
+		struct device_node *phy_node;
+		phy_interface_t phy_mode;
+		u32 index;
+		int err;
+
+		/* Get switch port number from DT */
+		if (of_property_read_u32(child, "reg", &index) < 0) {
+			dev_err(dev, "Port number not defined in device tree\n");
+			of_node_put(child);
+			return -ENODEV;
+		}
+
+		/* Get PHY mode from DT */
+		err = of_get_phy_mode(child, &phy_mode);
+		if (err) {
+			dev_err(dev, "Failed to read phy-mode or phy-interface-type %d\n",
+				index);
+			of_node_put(child);
+			return -ENODEV;
+		}
+
+		phy_node = of_parse_phandle(child, "phy-handle", 0);
+		if (!phy_node) {
+			if (!of_phy_is_fixed_link(child)) {
+				dev_err(dev, "phy-handle or fixed-link properties missing!\n");
+				of_node_put(child);
+				return -ENODEV;
+			}
+			/* phy-handle is missing, but fixed-link isn't.
+			 * So it's a fixed link. Default to PHY role.
+			 */
+			priv->fixed_link[index] = true;
+		} else {
+			of_node_put(phy_node);
+		}
+
+		priv->phy_mode[index] = phy_mode;
+	}
+
+	return 0;
+}
+
+static int hms_parse_dt(struct hms_private *priv)
+{
+	struct device *dev = &priv->spidev->dev;
+	struct device_node *switch_node = dev->of_node;
+	struct device_node *ports_node;
+	int rc;
+
+	ports_node = of_get_child_by_name(switch_node, "ports");
+	if (!ports_node)
+		ports_node = of_get_child_by_name(switch_node, "ethernet-ports");
+	if (!ports_node) {
+		dev_err(dev, "Incorrect bindings: absent \"ports\" node\n");
+		return -ENODEV;
+	}
+
+	rc = hms_parse_ports_node(priv, ports_node);
+	of_node_put(ports_node);
+
+	return rc;
+}
+
+static void hms_mac_link_down(struct phylink_config *config,
+			      unsigned int mode,
+			      phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct hms_private *priv = dp->ds->priv;
+	struct hms_mac_config *mac;
+	int port = dp->index;
+
+	mac = &priv->config.mac[port];
+
+	mac->egress = false;
+
+	hms_port_link_set(priv, port, false);
+}
+
+static void hms_mac_link_up(struct phylink_config *config,
+			    struct phy_device *phydev,
+			    unsigned int mode,
+			    phy_interface_t interface,
+			    int speed, int duplex,
+			    bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct hms_private *priv = dp->ds->priv;
+	struct hms_mac_config *mac;
+	int port = dp->index;
+
+	mac = &priv->config.mac[port];
+
+	mac->speed = speed;
+	mac->egress = true;
+
+	hms_port_phylink_mode_set(priv, mac);
+	hms_port_link_set(priv, port, true);
+}
+
+static void hms_mac_config(struct phylink_config *config,
+			   unsigned int mode,
+			   const struct phylink_link_state *state)
+{
+}
+
+static struct phylink_pcs *hms_mac_select_pcs(struct phylink_config *config,
+					      phy_interface_t iface)
+{
+	/* not supported, return NULL */
+	return NULL;
+}
+
+static void hms_phylink_get_caps(struct dsa_switch *ds, int port,
+				 struct phylink_config *config)
+{
+	struct hms_private *priv = ds->priv;
+	phy_interface_t phy_mode;
+
+	phy_mode = priv->phy_mode[port];
+	__set_bit(phy_mode, config->supported_interfaces);
+
+	/*
+	 * The MAC does not support pause frames, and also doesn't
+	 * support half-duplex traffic modes.
+	 */
+	config->mac_capabilities = MAC_10FD | MAC_100FD | MAC_1000FD;
+}
+
+static int hms_bridge_member(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge, bool member)
+{
+	int rc;
+
+	rc = hms_commit_pvid(ds, port);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int hms_bridge_join(struct dsa_switch *ds, int port,
+			   struct dsa_bridge bridge,
+			   bool *tx_fwd_offload,
+			   struct netlink_ext_ack *extack)
+{
+	int rc;
+
+	rc = hms_bridge_member(ds, port, bridge, true);
+	if (rc)
+		return rc;
+
+	rc = dsa_tag_8021q_bridge_join(ds, port, bridge, tx_fwd_offload, extack);
+	if (rc) {
+		hms_bridge_member(ds, port, bridge, false);
+		return rc;
+	}
+
+	*tx_fwd_offload = true;
+
+	return 0;
+}
+
+static void hms_bridge_leave(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge)
+{
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+	hms_bridge_member(ds, port, bridge, false);
+}
+
+static enum dsa_tag_protocol
+hms_get_tag_protocol(struct dsa_switch *ds, int port,
+		     enum dsa_tag_protocol mp)
+{
+	struct hms_private *priv = ds->priv;
+
+	return priv->info->tag_proto;
+}
+
+int hms_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
+		       struct netlink_ext_ack *extack)
+{
+	struct hms_private *priv = ds->priv;
+	struct hms_config *config = &priv->config;
+	int rc;
+
+	if (enabled) {
+		/* Enable VLAN filtering. */
+		config->tpid  = ETH_P_8021Q;
+		config->tpid2 = ETH_P_8021AD;
+	} else {
+		/* Disable VLAN filtering. */
+		config->tpid  = HMS_META_ETYPE;
+		config->tpid2 = HMS_META_ETYPE;
+	}
+
+	for (port = 0; port < ds->num_ports; port++) {
+		if (dsa_is_unused_port(ds, port))
+			continue;
+
+		rc = hms_commit_pvid(ds, port);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int hms_bridge_vlan_add(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct netlink_ext_ack *extack)
+{
+	struct hms_private *priv = ds->priv;
+	u16 flags = vlan->flags;
+	bool untagged = false;
+	int rc;
+
+	/* Be sure to deny the configuration done by tag_8021q. */
+	if (vid_is_hms_dsa_8021q(ds, vlan->vid)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "VLAN ID 3072-3076 & 3088 reserved for dsa_8021q operation");
+		return -EBUSY;
+	}
+
+	/* Always install bridge VLANs as egress-tagged on CPU and DSA ports */
+	if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
+		flags = 0;
+
+	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		untagged = true;
+
+	rc = hms_vlan_entry_add(priv, vlan->vid, port, untagged);
+	if (rc)
+		return rc;
+
+	if (vlan->flags & BRIDGE_VLAN_INFO_PVID)
+		priv->bridge_pvid[port] = vlan->vid;
+
+	/* Allow enough time between adding VLAN entry and setting PVID */
+	usleep_range(HMS_SPI_MSG_RESPONSE_TIME,
+		     HMS_SPI_MSG_RESPONSE_TIME * 10);
+
+	return hms_commit_pvid(ds, port);
+}
+
+static int hms_bridge_vlan_del(struct dsa_switch *ds, int port,
+			       const struct switchdev_obj_port_vlan *vlan)
+{
+	struct hms_private *priv = ds->priv;
+	int rc;
+
+	rc = hms_vlan_entry_del(priv, vlan->vid, port);
+	if (rc)
+		return rc;
+
+	/*
+	 * In case the pvid was deleted, make sure that untagged packets will
+	 * be dropped.
+	 */
+	return hms_commit_pvid(ds, port);
+}
+
+static int hms_8021q_vlan_add(struct dsa_switch *ds, int port,
+			      u16 vid, u16 flags)
+{
+	struct hms_private *priv = ds->priv;
+	int rc;
+
+	rc = hms_vlan_entry_add(priv, vid, port, false);
+	if (rc)
+		return rc;
+
+	if (flags & BRIDGE_VLAN_INFO_PVID)
+		priv->tag_8021q_pvid[port] = vid;
+
+	/* Allow enough time between adding VLAN entry and setting PVID */
+	usleep_range(HMS_SPI_MSG_RESPONSE_TIME,
+		     HMS_SPI_MSG_RESPONSE_TIME * 10);
+
+	return hms_commit_pvid(ds, port);
+}
+
+static int hms_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
+{
+	struct hms_private *priv = ds->priv;
+
+	return hms_vlan_entry_del(priv, vid, port);
+}
+
+static int hms_prechangeupper(struct dsa_switch *ds, int port,
+			      struct netdev_notifier_changeupper_info *info)
+{
+	struct netlink_ext_ack *extack = info->info.extack;
+	struct net_device *upper = info->upper_dev;
+	struct dsa_switch_tree *dst = ds->dst;
+	struct dsa_port *dp;
+
+	if (is_vlan_dev(upper)) {
+		NL_SET_ERR_MSG_MOD(extack, "8021q uppers are not supported");
+		return -EBUSY;
+	}
+
+	if (netif_is_bridge_master(upper)) {
+		list_for_each_entry(dp, &dst->ports, list) {
+			struct net_device *br = dsa_port_bridge_dev_get(dp);
+
+			if (br && br != upper && br_vlan_enabled(br)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Only one VLAN-aware bridge is supported");
+				return -EBUSY;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int hms_connect_tag_protocol(struct dsa_switch *ds,
+				    enum dsa_tag_protocol proto)
+{
+	struct hms_private *priv = ds->priv;
+
+	if (proto != priv->info->tag_proto)
+		return -EPROTONOSUPPORT;
+
+	return 0;
+}
+
+static int hms_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+{
+	struct hms_private *priv = ds->priv;
+	int maxlen = new_mtu + ETH_HLEN + ETH_FCS_LEN;
+
+	if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
+		maxlen += VLAN_HLEN;
+
+	return hms_port_mtu_set(priv, port, maxlen);
+}
+
+static int hms_get_max_mtu(struct dsa_switch *ds, int port)
+{
+	return 2000 - VLAN_ETH_HLEN - ETH_FCS_LEN;
+}
+
+static int hms_mac_init(struct hms_private *priv)
+{
+	struct hms_mac_config *mac;
+	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *dp;
+
+	mac = priv->config.mac;
+
+	dsa_switch_for_each_port(dp, ds) {
+		mac[dp->index].port = dp->index;
+		mac[dp->index].speed = 1000;
+		mac[dp->index].vlanid = 1;
+		mac[dp->index].drpuntag = false;
+		mac[dp->index].retag = false;
+
+		if (dsa_port_is_dsa(dp))
+			dp->learning = true;
+
+		/* Disallow untagged packets from being received on the
+		 * CPU and DSA ports.
+		 */
+		if (dsa_port_is_cpu(dp) || dsa_port_is_dsa(dp))
+			mac[dp->index].drpuntag = true;
+	}
+
+	return 0;
+}
+
+static int hms_dsa_init(struct hms_private *priv)
+{
+	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *dp, *cpu_dp = NULL;
+	const u8 *mac;
+	int port;
+
+	for (port = 0; port < ds->num_ports; port++) {
+		if (dsa_is_cpu_port(ds, port)) {
+			cpu_dp = dsa_to_port(ds, port);
+			break;
+		}
+	}
+
+	if (!cpu_dp) {
+		dev_err(ds->dev, "Failed to find cpu port\n");
+		return -ENODEV;
+	}
+
+	if (!is_zero_ether_addr(cpu_dp->mac))
+		mac = cpu_dp->mac;
+	else
+		mac = cpu_dp->user->dev_addr;
+
+	pr_info("HMS DSA: cpu port:%d master:%s\n",
+		cpu_dp->index, cpu_dp->user->name);
+
+	for (port = 0; port < ds->num_ports; port++) {
+		dp = dsa_to_port(ds, port);
+
+		if (dsa_port_is_unused(dp))
+			continue;
+		if (dsa_port_is_cpu(dp))
+			continue;
+
+		pr_info("HMS DSA: add switch port:%d\n", port);
+
+		hms_port_dsa_add(priv, cpu_dp->index, port, mac);
+	}
+
+	return 0;
+}
+
+static int hms_setup(struct dsa_switch *ds)
+{
+	struct hms_private *priv = ds->priv;
+	int port;
+	int rc;
+
+	rc = hms_config_setup(&priv->config);
+	if (rc < 0) {
+		dev_err(ds->dev, "Failed to setup config: %d\n", rc);
+		return rc;
+	}
+
+	hms_mac_init(priv);
+	hms_dsa_init(priv);
+
+	for (port = 0; port < ds->num_ports; port++) {
+		priv->tag_8021q_pvid[port] = HMS_DEFAULT_VLAN;
+		priv->bridge_pvid[port] = HMS_DEFAULT_VLAN;
+	}
+
+	rtnl_lock();
+	rc = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
+	rtnl_unlock();
+	if (rc)
+		goto out_config_free;
+
+	/*
+	 * On hms, VLAN filtering per se is always enabled in hardware.
+	 * The only thing we can do to disable it is lie about what the 802.1Q
+	 * EtherType is.
+	 * So it will still try to apply VLAN filtering, but all ingress
+	 * traffic (except frames received with EtherType of ETH_P_HMS_META)
+	 * will be internally tagged with a distorted VLAN header where the
+	 * TPID is ETH_P_HMS_META, and the VLAN ID is the port pvid.
+	 */
+	ds->vlan_filtering_is_global = true;
+	ds->untag_bridge_pvid = true;
+	ds->fdb_isolation = true;
+	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
+	ds->max_num_bridges = 7;
+
+	/* Advertise the 8 egress queues */
+	ds->num_tx_queues = HMS_NUM_TC;
+
+	ds->mtu_enforcement_ingress = true;
+	ds->assisted_learning_on_cpu_port = true;
+
+	return 0;
+
+out_config_free:
+	hms_config_free(&priv->config);
+
+	return rc;
+}
+
+static void hms_teardown(struct dsa_switch *ds)
+{
+	struct hms_private *priv = ds->priv;
+
+	rtnl_lock();
+	dsa_tag_8021q_unregister(ds);
+	rtnl_unlock();
+
+	hms_config_free(&priv->config);
+}
+
+static const struct phylink_mac_ops hms_phylink_mac_ops = {
+	.mac_select_pcs		= hms_mac_select_pcs,
+	.mac_config		= hms_mac_config,
+	.mac_link_down		= hms_mac_link_down,
+	.mac_link_up		= hms_mac_link_up,
+};
+
+static const struct dsa_switch_ops hms_switch_ops = {
+	.get_tag_protocol	= hms_get_tag_protocol,
+	.connect_tag_protocol	= hms_connect_tag_protocol,
+	.setup			= hms_setup,
+	.teardown		= hms_teardown,
+	.port_change_mtu	= hms_change_mtu,
+	.port_max_mtu		= hms_get_max_mtu,
+	.phylink_get_caps	= hms_phylink_get_caps,
+
+	.port_fdb_dump		= hms_fdb_dump,
+	.port_fdb_add		= hms_fdb_add,
+	.port_fdb_del		= hms_fdb_del,
+	.port_mdb_add		= hms_mdb_add,
+	.port_mdb_del		= hms_mdb_del,
+	.port_bridge_join	= hms_bridge_join,
+	.port_bridge_leave	= hms_bridge_leave,
+	.port_vlan_filtering	= hms_vlan_filtering,
+	.port_vlan_add		= hms_bridge_vlan_add,
+	.port_vlan_del		= hms_bridge_vlan_del,
+
+	.tag_8021q_vlan_add	= hms_8021q_vlan_add,
+	.tag_8021q_vlan_del	= hms_8021q_vlan_del,
+	.port_prechangeupper	= hms_prechangeupper,
+};
+
+static const struct of_device_id hms_dt_ids[];
+static int hms_check_device_id(struct hms_private *priv)
+{
+	struct device *dev = &priv->spidev->dev;
+	struct hms_config *config = &priv->config;
+	int rc;
+
+	rc = hms_get_devinfo(priv, config);
+	if (rc < 0)
+		return rc;
+
+	if (config->device_id != priv->info->device_id) {
+		dev_err(dev, "Device tree specifies device ID 0x%x, but found 0x%x please fix it!\n",
+			priv->info->device_id, config->device_id);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int hms_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct hms_private *priv;
+	struct dsa_switch *ds;
+	size_t max_xfer, max_msg;
+	int rc;
+
+	if (!dev->of_node) {
+		dev_err(dev, "No DTS bindings for hms driver\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(struct hms_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->spi_lock);
+	mutex_init(&priv->fdb_lock);
+
+	/*
+	 * Populate our driver private structure (priv) based on
+	 * the device tree node that was probed (spi)
+	 */
+	priv->spidev = spi;
+	spi_set_drvdata(spi, priv);
+
+	/* Configure the SPI bus */
+	spi->bits_per_word = HMS_SPI_WORD_BITS;
+	rc = spi_setup(spi);
+	if (rc < 0) {
+		dev_err(dev, "Could not init SPI\n");
+		return rc;
+	}
+
+	max_xfer = spi_max_transfer_size(spi);
+	max_msg = spi_max_message_size(spi);
+
+	/*
+	 * We need to send at least one 64-bit word of SPI payload per message
+	 * in order to be able to make useful progress.
+	 */
+	if (max_msg < HMS_SPI_MSG_HEADER_SIZE + 8) {
+		dev_err(dev, "SPI master cannot send large enough buffers, aborting\n");
+		return -EINVAL;
+	}
+
+	priv->max_xfer_len = HMS_SPI_MSG_MAXLEN;
+	if (priv->max_xfer_len > max_xfer)
+		priv->max_xfer_len = max_xfer;
+	if (priv->max_xfer_len > max_msg - HMS_SPI_MSG_HEADER_SIZE)
+		priv->max_xfer_len = max_msg - HMS_SPI_MSG_HEADER_SIZE;
+
+	priv->info = of_device_get_match_data(dev);
+
+	/* Detect hardware device */
+	rc = hms_check_device_id(priv);
+	if (rc < 0) {
+		dev_err(dev, "Device ID check failed: %d\n", rc);
+		return rc;
+	}
+
+	dev_info(dev, "Probed switch chip:%s ID:0x%x firmware:%d.%d.%d\n",
+		 priv->info->name,
+		 priv->config.device_id,
+		 priv->config.version_major,
+		 priv->config.version_minor,
+		 priv->config.version_revision);
+
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
+
+	ds->dev = dev;
+	ds->num_ports = priv->info->num_ports;
+	ds->ops = &hms_switch_ops;
+	ds->phylink_mac_ops = &hms_phylink_mac_ops;
+	ds->priv = priv;
+	priv->ds = ds;
+
+	rc = hms_parse_dt(priv);
+	if (rc < 0) {
+		dev_err(ds->dev, "Failed to parse DT: %d\n", rc);
+		return rc;
+	}
+
+	return dsa_register_switch(priv->ds);
+}
+
+static void hms_remove(struct spi_device *spi)
+{
+	struct hms_private *priv = spi_get_drvdata(spi);
+
+	if (!priv)
+		return;
+
+	dsa_unregister_switch(priv->ds);
+}
+
+static void hms_shutdown(struct spi_device *spi)
+{
+	struct hms_private *priv = spi_get_drvdata(spi);
+
+	if (!priv)
+		return;
+
+	dsa_switch_shutdown(priv->ds);
+
+	spi_set_drvdata(spi, NULL);
+}
+
+const struct hms_info hms_info = {
+	.device_id		= HMS_RT1180_DEVICE_ID,
+	.tag_proto		= DSA_TAG_PROTO_HMS_VALUE,
+	.num_ports		= HMS_NUM_PORTS,
+	.name			= "hms",
+};
+
+static const struct of_device_id hms_dt_ids[] = {
+	{ .compatible = "nxp,imxrt1180-netc-switch-spi", .data = &hms_info},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, hms_dt_ids);
+
+static const struct spi_device_id hms_spi_ids[] = {
+	{ "imxrt1180-hms" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, hms_spi_ids);
+
+static struct spi_driver hms_driver = {
+	.driver = {
+		.name  = "hms-spi",
+		.of_match_table = of_match_ptr(hms_dt_ids),
+	},
+	.id_table = hms_spi_ids,
+	.probe  = hms_probe,
+	.remove = hms_remove,
+	.shutdown = hms_shutdown,
+};
+
+module_spi_driver(hms_driver);
+
+MODULE_AUTHOR("Minghuan Lian <minghuan.lian@nxp.com>");
+MODULE_DESCRIPTION("HMS DSA Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/hms/hms_spi.c b/drivers/net/dsa/hms/hms_spi.c
new file mode 100644
index 0000000000000..22e4393554738
--- /dev/null
+++ b/drivers/net/dsa/hms/hms_spi.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP HMS (Heterogeneous Multi-SoC) DSA Switch SPI Transport Layer
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/spi/spi.h>
+#include "hms_switch.h"
+
+int hms_xfer_cmd(struct hms_private *priv,
+		 enum hms_spi_rw_mode rw, enum hms_cmd cmd,
+		 void *param, size_t param_len,
+		 void *resp, size_t resp_len,
+		 struct ptp_system_timestamp *ptp_sts)
+{
+	struct hms_cmd_hdr hdr = {0};
+	struct spi_device *spi = priv->spidev;
+	struct spi_transfer hdr_xfer, resp_xfer;
+	int rc;
+
+	if (!IS_ALIGNED(resp_len, HMS_SPI_MSG_WORD_BYTES)) {
+		dev_err(&spi->dev, "hms cmd %d data size should be a multiple of 4: %zu\n",
+			cmd, resp_len);
+		return -EINVAL;
+	}
+
+	if (resp_len > priv->max_xfer_len) {
+		dev_err(&spi->dev, "hms cmd %d data size is too large\n",
+			cmd);
+		return -EINVAL;
+	}
+
+	if (param_len > HMS_SPI_MSG_PARAM_SIZE) {
+		dev_err(&spi->dev, "hms cmd %d param size is too large\n",
+			cmd);
+		return -EINVAL;
+	}
+
+	hdr.cmd = (rw << HMS_CMD_DIR_SHIFT) |
+		  ((resp_len / HMS_SPI_MSG_WORD_BYTES) << HMS_CMD_LEN_SHIFT) |
+		  cmd;
+	if (param)
+		memcpy(hdr.param, param, param_len);
+
+	memset(&hdr_xfer, 0, sizeof(hdr_xfer));
+	hdr_xfer.tx_buf = &hdr;
+	hdr_xfer.len = HMS_SPI_MSG_HEADER_SIZE;
+	hdr_xfer.ptp_sts_word_pre = hdr_xfer.len - 1;
+	hdr_xfer.ptp_sts_word_post = hdr_xfer.len - 1;
+	hdr_xfer.ptp_sts = ptp_sts;
+
+	mutex_lock(&priv->spi_lock);
+
+	rc = spi_sync_transfer(spi, &hdr_xfer, 1);
+	if (rc < 0) {
+		dev_err(&spi->dev, "hms cmd %d SPI transfer failed: %d\n",
+			cmd, rc);
+		mutex_unlock(&priv->spi_lock);
+		return rc;
+	}
+
+	usleep_range(HMS_SPI_MSG_RESPONSE_TIME,
+		     HMS_SPI_MSG_RESPONSE_TIME + 100);
+
+	if (!resp) {
+		mutex_unlock(&priv->spi_lock);
+		return 0;
+	}
+
+	/* Populate the transfer's data buffer */
+	memset(&resp_xfer, 0, sizeof(resp_xfer));
+	if (rw == SPI_READ)
+		resp_xfer.rx_buf = resp;
+	else
+		resp_xfer.tx_buf = resp;
+	resp_xfer.len = resp_len;
+
+	resp_xfer.ptp_sts_word_pre = resp_xfer.len - 1;
+	resp_xfer.ptp_sts_word_post = resp_xfer.len - 1;
+	resp_xfer.ptp_sts = ptp_sts;
+
+	rc = spi_sync_transfer(spi, &resp_xfer, 1);
+
+	mutex_unlock(&priv->spi_lock);
+
+	if (rc < 0) {
+		dev_err(&spi->dev, "hms cmd %d SPI transfer failed: %d\n",
+			cmd, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+int hms_xfer_set_cmd(struct hms_private *priv,
+		     enum hms_cmd cmd,
+		     void *param, size_t param_len)
+{
+	return hms_xfer_cmd(priv, SPI_WRITE, cmd,
+			    param, param_len,
+			    NULL, 0, NULL);
+}
+
+int hms_xfer_get_cmd(struct hms_private *priv,
+		     enum hms_cmd cmd, u32 id,
+		     void *resp, size_t resp_len)
+{
+	struct hms_cmd_read_param param;
+
+	param.id = id;
+
+	return hms_xfer_cmd(priv, SPI_READ, cmd,
+			    &param, sizeof(param),
+			    resp, resp_len, NULL);
+}
diff --git a/drivers/net/dsa/hms/hms_switch.h b/drivers/net/dsa/hms/hms_switch.h
new file mode 100644
index 0000000000000..8f9e3035374b1
--- /dev/null
+++ b/drivers/net/dsa/hms/hms_switch.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NXP HMS (Heterogeneous Multi-SoC) DSA Switch Driver
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef _HMS_SWITCH_H
+#define _HMS_SWITCH_H
+
+#include <linux/dsa/8021q.h>
+#include <linux/dsa/tag_hms.h>
+#include <linux/mutex.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
+#include <net/dsa.h>
+
+#include "hms_config.h"
+
+#define HMS_DEFAULT_VLAN	1
+
+struct hms_private;
+
+struct hms_info {
+	const char *name;
+	int device_id;
+	int num_ports;
+	enum dsa_tag_protocol tag_proto;
+};
+
+struct hms_private {
+	const struct hms_info *info;
+	struct hms_config config;
+	phy_interface_t phy_mode[HMS_MAX_NUM_PORTS];
+	bool fixed_link[HMS_MAX_NUM_PORTS];
+
+	size_t max_xfer_len;
+	struct spi_device *spidev;
+	struct dsa_switch *ds;
+	u16 bridge_pvid[HMS_MAX_NUM_PORTS];
+	u16 tag_8021q_pvid[HMS_MAX_NUM_PORTS];
+
+	/* Protects SPI command transactions */
+	struct mutex spi_lock;
+	/* Serializes accesses to the FDB */
+	struct mutex fdb_lock;
+};
+
+int hms_is_vlan_configured(struct hms_private *priv, u16 vid);
+
+int hms_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
+		       struct netlink_ext_ack *extack);
+
+/* From hms_spi.c */
+int hms_xfer_cmd(struct hms_private *priv,
+		 enum hms_spi_rw_mode rw, enum hms_cmd cmd,
+		 void *param, size_t param_len,
+		 void *resp, size_t resp_len,
+		 struct ptp_system_timestamp *ptp_sts);
+int hms_xfer_set_cmd(struct hms_private *priv,
+		     enum hms_cmd cmd,
+		     void *param, size_t param_len);
+int hms_xfer_get_cmd(struct hms_private *priv,
+		     enum hms_cmd cmd, u32 id,
+		     void *resp, size_t resp_len);
+
+#endif /* _HMS_SWITCH_H */
-- 
2.43.0


