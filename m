Return-Path: <netdev+bounces-243339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E067C9D5AE
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 00:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 002A64E4A4F
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 23:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1E2FD7B1;
	Tue,  2 Dec 2025 23:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28602D949A;
	Tue,  2 Dec 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718699; cv=none; b=LhBCaxK9fWLsRVqx9f62ib957iIVKPrsbCuyroArZTpS/WX8Z0CLAYIyDlsFkBXZSAkLDY8t5tDd1ajbKWSpt7FdvSbamhzQd86MSk07VtbHtgLhUajTLQBJsOFH0/0J038UkwwT7wavnYUWK0++FvhCVxQJ0ptR1HPH0TEtZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718699; c=relaxed/simple;
	bh=TiImCWJphjlJJBgY8hl5O8ynxx0TM5ydyZ2YZOxojrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4g8LljXHEZN5aBKHldobdEWCe9FrTRQRt7fNXJIaNGahuB7DCn4fpzld3nCHIfURY+ZN3Ujnka+t6kMVWTpXzlTBysgth2BIAjaayioipVE+4qtO4TyaAkZLUbzkhbn37p9seUHiIMOArQrWqac0CWN4i04wBRMvg1qHY01oiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vQZwe-0000000071i-1I7C;
	Tue, 02 Dec 2025 23:38:08 +0000
Date: Tue, 2 Dec 2025 23:38:05 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
References: <cover.1764717476.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1764717476.git.daniel@makrotopia.org>

Add very basic DSA driver for MaxLinear's MxL862xx switches.

In contrast to previous MaxLinear switches the MxL862xx has a built-in
processor that runs a sophisticated firmware based on Zephyr RTOS.
Interaction between the host and the switch hence is organized using a
software API of that firmware rather than accessing hardware registers
directly.

Add descriptions of the most basic firmware API calls to access the
built-in MDIO bus hosting the 2.5GE PHYs, basic port control as well as
setting up the CPU port.

Implement a very basic DSA driver using that API which is sufficient to
get packets flowing between the user ports and the CPU port.

The firmware offers all features one would expect from a modern switch
hardware, they will be added one by one in follow-up patch series.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS                              |   1 +
 drivers/net/dsa/Kconfig                  |   2 +
 drivers/net/dsa/Makefile                 |   1 +
 drivers/net/dsa/mxl862xx/Kconfig         |  12 +
 drivers/net/dsa/mxl862xx/Makefile        |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-api.h  | 104 +++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |  28 ++
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 204 +++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      | 360 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h      |  27 ++
 11 files changed, 745 insertions(+)
 create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
 create mode 100644 drivers/net/dsa/mxl862xx/Makefile
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a5ca0f08938fd..2ccca4828952d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15418,6 +15418,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
+F:	drivers/net/dsa/mxl862xx/
 F:	net/dsa/tag_mxl862xx.c
 
 MCAN DEVICE DRIVER
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 7eb301fd987d1..18f6e8b7f4cb2 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -74,6 +74,8 @@ source "drivers/net/dsa/microchip/Kconfig"
 
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
 
+source "drivers/net/dsa/mxl862xx/Kconfig"
+
 source "drivers/net/dsa/ocelot/Kconfig"
 
 source "drivers/net/dsa/qca/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 16de4ba3fa388..f5a463b87ec25 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -20,6 +20,7 @@ obj-y				+= hirschmann/
 obj-y				+= lantiq/
 obj-y				+= microchip/
 obj-y				+= mv88e6xxx/
+obj-y				+= mxl862xx/
 obj-y				+= ocelot/
 obj-y				+= qca/
 obj-y				+= realtek/
diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
new file mode 100644
index 0000000000000..5c538dfc2763e
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_MXL862
+	tristate "MaxLinear MxL862xx"
+	depends on NET_DSA
+	select MAXLINEAR_GPHY
+	select NET_DSA_TAG_MXL862
+	help
+	  This enables support for the MaxLinear MxL862xx switch family.
+	  These switches got two 10GE SerDes interfaces, one typically
+	  used as CPU port.
+	   MxL86282 Eight 2.5 Gigabit PHYs
+	   MxL86252 Five 2.5 Gigabit PHYs
\ No newline at end of file
diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx/Makefile
new file mode 100644
index 0000000000000..d23dd3cd511d4
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_MXL862) += mxl862xx_dsa.o
+mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-api.h b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
new file mode 100644
index 0000000000000..8efe7c535fa5a
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-api.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/**
+ * struct mdio_relay_data - relayed access to the switch internal MDIO bus
+ * @data: data to be read or written
+ * @phy: PHY index
+ * @mmd: MMD device
+ * @reg: register rndex
+ */
+struct mdio_relay_data {
+	__le16 data;
+	u8 phy;
+	u8 mmd;
+	__le16 reg;
+} __packed;
+
+/* Register access parameter to directly modify internal registers */
+struct mxl862xx_register_mod {
+	__le16 addr;
+	__le16 data;
+	__le16 mask;
+} __packed;
+
+/**
+ * struct mxl862xx_ss_sp_tag
+ * @pid: port ID (1~16)
+ * @mask: bit value 1 to indicate valid field
+ *	0 - rx
+ *	1 - tx
+ *	2 - rx_pen
+ *	3 - tx_pen
+ * @rx: RX special tag mode
+ *	0 - packet does NOT have special tag and special tag is NOT inserted
+ *	1 - packet does NOT have special tag and special tag is inserted
+ *	2 - packet has special tag and special tag is NOT inserted
+ * @tx: TX special tag mode
+ *	0 - packet does NOT have special tag and special tag is NOT removed
+ *	1 - packet has special tag and special tag is replaced
+ *	2 - packet has special tag and special tag is NOT removed
+ *	3 - packet has special tag and special tag is removed
+ * @rx_pen: RX special tag info over preamble
+ *	0 - special tag info inserted from byte 2 to 7 are all 0
+ *	1 - special tag byte 5 is 16, other bytes from 2 to 7 are 0
+ *	2 - special tag byte 5 is from preamble field, others are 0
+ *	3 - special tag byte 2 to 7 are from preabmle field
+ * @tx_pen: TX special tag info over preamble
+ *	0 - disabled
+ *	1 - enabled
+ */
+struct mxl862xx_ss_sp_tag {
+	u8 pid;
+	u8 mask;
+	u8 rx;
+	u8 tx;
+	u8 rx_pen;
+	u8 tx_pen;
+} __packed;
+
+/**
+ * enum mxl862xx_logical_port_mode - Logical port mode
+ * @MXL862XX_LOGICAL_PORT_8BIT_WLAN: WLAN with 8-bit station ID
+ * @MXL862XX_LOGICAL_PORT_9BIT_WLAN: WLAN with 9-bit station ID
+ * @MXL862XX_LOGICAL_PORT_GPON: GPON OMCI context
+ * @MXL862XX_LOGICAL_PORT_EPON: EPON context
+ * @MXL862XX_LOGICAL_PORT_GINT: G.INT context
+ * @MXL862XX_LOGICAL_PORT_OTHER: Others
+ */
+enum mxl862xx_logical_port_mode {
+	MXL862XX_LOGICAL_PORT_8BIT_WLAN = 0,
+	MXL862XX_LOGICAL_PORT_9BIT_WLAN,
+	MXL862XX_LOGICAL_PORT_GPON,
+	MXL862XX_LOGICAL_PORT_EPON,
+	MXL862XX_LOGICAL_PORT_GINT,
+	MXL862XX_LOGICAL_PORT_OTHER = 0xFF,
+};
+
+/**
+ * struct mxl862xx_ctp_port_assignment - CTP Port Assignment/association with logical port
+ * @logical_port_id: Logical Port Id. The valid range is hardware dependent
+ * @first_ctp_port_id: First CTP Port ID mapped to above logical port ID
+ * @number_of_ctp_port: Total number of CTP Ports mapped above logical port ID
+ * @mode: See &enum mxl862xx_logical_port_mode
+ * @bridge_port_id: Bridge ID (FID)
+ */
+struct mxl862xx_ctp_port_assignment {
+	u8 logical_port_id;
+	__le16 first_ctp_port_id;
+	__le16 number_of_ctp_port;
+	enum mxl862xx_logical_port_mode mode;
+	__le16 bridge_port_id;
+} __packed;
+
+/**
+ * struct mxl862xx_sys_fw_image_version - VLAN counter mapping configuration
+ * @iv_major: firmware major version
+ * @iv_minor: firmware minor version
+ * @iv_revision: firmware revision
+ * @iv_build_num: firmware build number
+ */
+struct mxl862xx_sys_fw_image_version {
+	u8 iv_major;
+	u8 iv_minor;
+	__le16 iv_revision;
+	__le32 iv_build_num;
+} __packed;
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
new file mode 100644
index 0000000000000..db6a4c3f54f22
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define MXL862XX_MMD_DEV 30
+#define MXL862XX_MMD_REG_CTRL 0
+#define MXL862XX_MMD_REG_LEN_RET 1
+#define MXL862XX_MMD_REG_DATA_FIRST 2
+#define MXL862XX_MMD_REG_DATA_LAST 95
+#define MXL862XX_MMD_REG_DATA_MAX_SIZE \
+	(MXL862XX_MMD_REG_DATA_LAST - MXL862XX_MMD_REG_DATA_FIRST + 1)
+
+#define MXL862XX_COMMON_MAGIC 0x100
+#define MXL862XX_CTP_MAGIC 0x500
+#define MXL862XX_SS_MAGIC 0x1600
+#define GPY_GPY2XX_MAGIC 0x1800
+#define SYS_MISC_MAGIC 0x1900
+
+#define MXL862XX_COMMON_REGISTERMOD (MXL862XX_COMMON_MAGIC + 0x11)
+
+#define MXL862XX_CTP_PORTASSIGNMENTSET (MXL862XX_CTP_MAGIC + 0x3)
+
+#define MXL862XX_SS_SPTAG_SET (MXL862XX_SS_MAGIC + 0x02)
+
+#define INT_GPHY_READ (GPY_GPY2XX_MAGIC + 0x01)
+#define INT_GPHY_WRITE (GPY_GPY2XX_MAGIC + 0x02)
+
+#define SYS_MISC_FW_VERSION (SYS_MISC_MAGIC + 0x02)
+
+#define MMD_API_MAXIMUM_ID 0x7FFF
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
new file mode 100644
index 0000000000000..7c407329f8184
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Based upon the Maxlinear SDK driver
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (C) 2025 John Crispin <john@phrozen.org>
+ * Copyright (C) 2024 MaxLinear Inc.
+ */
+
+#include <linux/bits.h>
+#include <net/dsa.h>
+#include "mxl862xx.h"
+#include "mxl862xx-host.h"
+
+#define CTRL_BUSY_MASK BIT(15)
+#define CTRL_CMD_MASK (BIT(15) - 1)
+
+#define MAX_BUSY_LOOP 1000 /* roughly 10ms */
+
+#define MXL862XX_MMD_DEV 30
+#define MXL862XX_MMD_REG_CTRL 0
+#define MXL862XX_MMD_REG_LEN_RET 1
+#define MXL862XX_MMD_REG_DATA_FIRST 2
+#define MXL862XX_MMD_REG_DATA_LAST 95
+#define MXL862XX_MMD_REG_DATA_MAX_SIZE \
+		(MXL862XX_MMD_REG_DATA_LAST - MXL862XX_MMD_REG_DATA_FIRST + 1)
+
+#define MMD_API_SET_DATA_0 (0x0 + 0x2)
+#define MMD_API_GET_DATA_0 (0x0 + 0x5)
+#define MMD_API_RST_DATA (0x0 + 0x8)
+
+static int mxl862xx_busy_wait(struct mxl862xx_priv *dev)
+{
+	int ret, i;
+
+	for (i = 0; i < MAX_BUSY_LOOP; i++) {
+		ret = __mdiobus_c45_read(dev->bus, dev->sw_addr,
+					 MXL862XX_MMD_DEV,
+					 MXL862XX_MMD_REG_CTRL);
+		if (ret < 0)
+			return ret;
+
+		if (ret & CTRL_BUSY_MASK)
+			usleep_range(10, 15);
+		else
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int mxl862xx_set_data(struct mxl862xx_priv *dev, u16 words)
+{
+	int ret;
+	u16 cmd;
+
+	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
+				  MXL862XX_MMD_REG_LEN_RET,
+				  MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
+	if (ret < 0)
+		return ret;
+
+	cmd = words / MXL862XX_MMD_REG_DATA_MAX_SIZE - 1;
+	if (!(cmd < 2))
+		return -EINVAL;
+
+	cmd += MMD_API_SET_DATA_0;
+	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
+				  MXL862XX_MMD_REG_CTRL, cmd | CTRL_BUSY_MASK);
+	if (ret < 0)
+		return ret;
+
+	return mxl862xx_busy_wait(dev);
+}
+
+static int mxl862xx_get_data(struct mxl862xx_priv *dev, u16 words)
+{
+	int ret;
+	u16 cmd;
+
+	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
+				  MXL862XX_MMD_REG_LEN_RET,
+				  MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
+	if (ret < 0)
+		return ret;
+
+	cmd = words / MXL862XX_MMD_REG_DATA_MAX_SIZE;
+	if (!(cmd > 0 && cmd < 3))
+		return -EINVAL;
+
+	cmd += MMD_API_GET_DATA_0;
+	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
+				  MXL862XX_MMD_REG_CTRL, cmd | CTRL_BUSY_MASK);
+	if (ret < 0)
+		return ret;
+
+	return mxl862xx_busy_wait(dev);
+}
+
+static int mxl862xx_send_cmd(struct mxl862xx_priv *dev, u16 cmd, u16 size,
+			     s16 *presult)
+{
+	int ret;
+
+	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
+				  MXL862XX_MMD_REG_LEN_RET, size);
+	if (ret)
+		return ret;
+
+	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
+				  MXL862XX_MMD_REG_CTRL, cmd | CTRL_BUSY_MASK);
+	if (ret)
+		return ret;
+
+	ret = mxl862xx_busy_wait(dev);
+	if (ret)
+		return ret;
+
+	ret = __mdiobus_c45_read(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
+				 MXL862XX_MMD_REG_LEN_RET);
+	if (ret < 0)
+		return ret;
+
+	*presult = ret;
+	return 0;
+}
+
+int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
+		      u16 size, bool read)
+{
+	u16 *data = _data;
+	s16 result = 0;
+	u16 max, i;
+	int ret;
+
+	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
+
+	max = (size + 1) / 2;
+
+	ret = mxl862xx_busy_wait(priv);
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < max; i++) {
+		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
+
+		if (i && off == 0) {
+			/* Send command to set data when every
+			 * MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs are written.
+			 */
+			ret = mxl862xx_set_data(priv, i);
+			if (ret < 0)
+				goto out;
+		}
+
+		__mdiobus_c45_write(priv->bus, priv->sw_addr,
+				    MXL862XX_MMD_DEV,
+				    MXL862XX_MMD_REG_DATA_FIRST + off,
+				    le16_to_cpu(data[i]));
+	}
+
+	ret = mxl862xx_send_cmd(priv, cmd, size, &result);
+	if (ret < 0)
+		goto out;
+
+	if (result < 0) {
+		ret = result;
+		goto out;
+	}
+
+	for (i = 0; i < max && read; i++) {
+		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
+
+		if (i && off == 0) {
+			/* Send command to fetch next batch of data
+			 * when every MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs
+			 * are read.
+			 */
+			ret = mxl862xx_get_data(priv, i);
+			if (ret < 0)
+				goto out;
+		}
+
+		ret = __mdiobus_c45_read(priv->bus, priv->sw_addr,
+					 MXL862XX_MMD_DEV,
+					 MXL862XX_MMD_REG_DATA_FIRST + off);
+		if (ret < 0)
+			goto out;
+
+		if ((i * 2 + 1) == size) {
+			/* Special handling for last BYTE
+			 * if it's not WORD aligned.
+			 */
+			*(uint8_t *)&data[i] = ret & 0xFF;
+		} else {
+			data[i] = cpu_to_le16((u16)ret);
+		}
+	}
+	ret = result;
+
+out:
+	mutex_unlock(&priv->bus->mdio_lock);
+	return ret;
+}
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
new file mode 100644
index 0000000000000..0a05fe3c7e6bf
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size, bool read);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
new file mode 100644
index 0000000000000..0446455c36bb6
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for MaxLinear MxL862xx switch family
+ *
+ * Copyright (C) 2024 MaxLinear Inc.
+ * Copyright (C) 2025 John Crispin <john@phrozen.org>
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/of_device.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/phylink.h>
+#include <net/dsa.h>
+
+#include "mxl862xx.h"
+#include "mxl862xx-api.h"
+#include "mxl862xx-cmd.h"
+#include "mxl862xx-host.h"
+
+#define MXL862XX_API_WRITE(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false)
+#define MXL862XX_API_READ(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true)
+
+#define DSA_MXL_PORT(port) ((port) + 1)
+
+#define MXL862XX_SDMA_PCTRLP(p) (0xBC0 + ((p) * 0x6))
+#define MXL862XX_SDMA_PCTRL_EN BIT(0)
+
+#define MXL862XX_FDMA_PCTRLP(p) (0xA80 + ((p) * 0x6))
+#define MXL862XX_FDMA_PCTRL_EN BIT(0)
+
+/* PHY access via firmware relay */
+static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
+				 int devadd, int reg)
+{
+	struct mdio_relay_data param = {
+		.phy = port,
+		.mmd = devadd,
+		.reg = reg & 0xffff,
+	};
+	int ret;
+
+	ret = MXL862XX_API_READ(priv, INT_GPHY_READ, param);
+	if (ret)
+		return ret;
+
+	return param.data;
+}
+
+static int mxl862xx_phy_write_mmd(struct mxl862xx_priv *priv, int port,
+				  int devadd, int reg, u16 data)
+{
+	struct mdio_relay_data param = {
+		.phy = port,
+		.mmd = devadd,
+		.reg = reg,
+		.data = data,
+	};
+
+	return MXL862XX_API_WRITE(priv, INT_GPHY_WRITE, param);
+}
+
+static int mxl862xx_phy_read(struct dsa_switch *ds, int port, int reg)
+{
+	return mxl862xx_phy_read_mmd(ds->priv, port, 0, reg);
+}
+
+static int mxl862xx_phy_write(struct dsa_switch *ds, int port, int reg, u16 data)
+{
+	return mxl862xx_phy_write_mmd(ds->priv, port, 0, reg, data);
+}
+
+/* Configure CPU tagging */
+static int mxl862xx_configure_tag_proto(struct dsa_switch *ds, int port,
+					bool enable)
+{
+	struct mxl862xx_ss_sp_tag tag = {
+		.pid = DSA_MXL_PORT(port),
+		.mask = BIT(0) | BIT(1),
+		.rx = enable ? 2 : 1,
+		.tx = enable ? 2 : 3,
+	};
+	struct mxl862xx_ctp_port_assignment assign = {
+		.number_of_ctp_port = enable ? (32 - DSA_MXL_PORT(port)) : 1,
+		.logical_port_id = DSA_MXL_PORT(port),
+		.first_ctp_port_id = DSA_MXL_PORT(port),
+		.mode = MXL862XX_LOGICAL_PORT_GPON,
+	};
+	int ret;
+
+	ret = MXL862XX_API_WRITE(ds->priv, MXL862XX_SS_SPTAG_SET, tag);
+	if (ret)
+		return ret;
+
+	return MXL862XX_API_WRITE(ds->priv, MXL862XX_CTP_PORTASSIGNMENTSET, assign);
+}
+
+/* Port enable/disable */
+static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
+{
+	struct mxl862xx_register_mod sdma = {
+		.addr = MXL862XX_SDMA_PCTRLP(DSA_MXL_PORT(port)),
+		.data = enable ? MXL862XX_SDMA_PCTRL_EN : 0,
+		.mask = MXL862XX_SDMA_PCTRL_EN,
+	};
+	struct mxl862xx_register_mod fdma = {
+		.addr = MXL862XX_FDMA_PCTRLP(DSA_MXL_PORT(port)),
+		.data = enable ? MXL862XX_FDMA_PCTRL_EN : 0,
+		.mask = MXL862XX_FDMA_PCTRL_EN,
+	};
+	int ret;
+
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
+	ret = MXL862XX_API_WRITE(ds->priv, MXL862XX_COMMON_REGISTERMOD, sdma);
+	if (ret)
+		return ret;
+
+	return MXL862XX_API_WRITE(ds->priv, MXL862XX_COMMON_REGISTERMOD, fdma);
+}
+
+static int mxl862xx_port_enable(struct dsa_switch *ds, int port,
+				struct phy_device *phydev)
+{
+	return mxl862xx_port_state(ds, port, true);
+}
+
+static void mxl862xx_port_disable(struct dsa_switch *ds, int port)
+{
+	mxl862xx_port_state(ds, port, false);
+}
+
+/* MDIO bus for PHYs */
+static int mxl862xx_phy_read_mii_bus(struct mii_bus *bus, int port, int regnum)
+{
+	return mxl862xx_phy_read_mmd(bus->priv, port, 0, regnum);
+}
+
+static int mxl862xx_phy_write_mii_bus(struct mii_bus *bus, int port,
+				      int regnum, u16 val)
+{
+	return mxl862xx_phy_write_mmd(bus->priv, port, 0, regnum, val);
+}
+
+static int mxl862xx_phy_read_c45_mii_bus(struct mii_bus *bus, int port,
+					 int devadd, int regnum)
+{
+	return mxl862xx_phy_read_mmd(bus->priv, port, devadd, regnum);
+}
+
+static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int port,
+					  int devadd, int regnum, u16 val)
+{
+	return mxl862xx_phy_write_mmd(bus->priv, port, devadd, regnum, val);
+}
+
+static int mxl862xx_setup_mdio(struct dsa_switch *ds)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct device *dev = ds->dev;
+	struct device_node *mdio_np;
+	struct mii_bus *bus;
+	static int idx;
+	int ret;
+
+	bus = devm_mdiobus_alloc(dev);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->priv = priv;
+	ds->user_mii_bus = bus;
+	bus->name = KBUILD_MODNAME "-mii";
+	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
+	bus->read_c45 = mxl862xx_phy_read_c45_mii_bus;
+	bus->write_c45 = mxl862xx_phy_write_c45_mii_bus;
+	bus->read = mxl862xx_phy_read_mii_bus;
+	bus->write = mxl862xx_phy_write_mii_bus;
+	bus->parent = dev;
+	bus->phy_mask = ~ds->phys_mii_mask;
+
+	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
+	if (!mdio_np)
+		return -ENODEV;
+
+	ret = devm_of_mdiobus_register(dev, bus, mdio_np);
+	of_node_put(mdio_np);
+
+	return ret;
+}
+
+/* Reset switch via MMD write */
+static int mxl862xx_mmd_write(struct dsa_switch *ds, int reg, u16 data)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	int ret;
+
+	mutex_lock(&priv->bus->mdio_lock);
+	ret = __mdiobus_c45_write(priv->bus, priv->sw_addr, MXL862XX_MMD_DEV,
+				  reg, data);
+	mutex_unlock(&priv->bus->mdio_lock);
+
+	return ret;
+}
+
+/* Phylink integration */
+static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
+				      struct phylink_config *config)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
+				   MAC_100 | MAC_1000 | MAC_2500FD;
+
+	if (port < priv->hw_info->phy_ports)
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+	else
+		__set_bit(PHY_INTERFACE_MODE_NA,
+			  config->supported_interfaces);
+}
+
+/* Tag protocol */
+static enum dsa_tag_protocol mxl862xx_get_tag_protocol(struct dsa_switch *ds,
+						       int port,
+						       enum dsa_tag_protocol m)
+{
+	return DSA_TAG_PROTO_MXL862;
+}
+
+/* Setup */
+static int mxl862xx_setup(struct dsa_switch *ds)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	int ret, i;
+
+	for (i = 0; i < ds->num_ports; i++) {
+		if (dsa_is_cpu_port(ds, i)) {
+			priv->cpu_port = i;
+			break;
+		}
+	}
+
+	ret = mxl862xx_setup_mdio(ds);
+	if (ret)
+		return ret;
+
+	/* Software reset */
+	ret = mxl862xx_mmd_write(ds, 1, 0);
+	if (ret)
+		return ret;
+
+	ret = mxl862xx_mmd_write(ds, 0, 0x9907);
+	if (ret)
+		return ret;
+
+	usleep_range(4000000, 6000000);
+
+	return mxl862xx_configure_tag_proto(ds, priv->cpu_port, true);
+}
+
+static const struct dsa_switch_ops mxl862xx_switch_ops = {
+	.get_tag_protocol = mxl862xx_get_tag_protocol,
+	.phylink_get_caps = mxl862xx_phylink_get_caps,
+	.phy_read = mxl862xx_phy_read,
+	.phy_write = mxl862xx_phy_write,
+	.port_disable = mxl862xx_port_disable,
+	.port_enable = mxl862xx_port_enable,
+	.setup = mxl862xx_setup,
+};
+
+/* Probe/remove */
+static int mxl862xx_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct mxl862xx_priv *priv;
+	struct dsa_switch *ds;
+	struct mxl862xx_sys_fw_image_version fw;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->bus = mdiodev->bus;
+	priv->sw_addr = mdiodev->addr;
+	priv->hw_info = of_device_get_match_data(dev);
+	if (!priv->hw_info)
+		return -EINVAL;
+
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
+
+	priv->ds = ds;
+	ds->dev = dev;
+	ds->priv = priv;
+	ds->ops = &mxl862xx_switch_ops;
+	ds->num_ports = priv->hw_info->max_ports;
+
+	dev_set_drvdata(dev, ds);
+
+	ret = dsa_register_switch(ds);
+	if (ret)
+		return ret;
+
+	ret = MXL862XX_API_READ(priv, SYS_MISC_FW_VERSION, fw);
+	if (!ret)
+		dev_info(dev, "Firmware version %d.%d.%d.%d\n",
+			 fw.iv_major, fw.iv_minor,
+			 fw.iv_revision, fw.iv_build_num);
+
+	return 0;
+}
+
+static void mxl862xx_remove(struct mdio_device *mdiodev)
+{
+	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
+
+	dsa_unregister_switch(ds);
+}
+
+static const struct mxl862xx_hw_info mxl86282_data = {
+	.max_ports = MXL862XX_MAX_PORT_NUM,
+	.phy_ports = MXL86282_PHY_PORT_NUM,
+	.ext_ports = MXL86282_EXT_PORT_NUM,
+};
+
+static const struct mxl862xx_hw_info mxl86252_data = {
+	.max_ports = MXL862XX_MAX_PORT_NUM,
+	.phy_ports = MXL86252_PHY_PORT_NUM,
+	.ext_ports = MXL86252_EXT_PORT_NUM,
+};
+
+static const struct of_device_id mxl862xx_of_match[] = {
+	{ .compatible = "maxlinear,mxl86282", .data = &mxl86282_data },
+	{ .compatible = "maxlinear,mxl86252", .data = &mxl86252_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mxl862xx_of_match);
+
+static struct mdio_driver mxl862xx_driver = {
+	.probe  = mxl862xx_probe,
+	.remove = mxl862xx_remove,
+	.mdiodrv.driver = {
+		.name = "mxl862xx",
+		.of_match_table = mxl862xx_of_match,
+	},
+};
+
+mdio_module_driver(mxl862xx_driver);
+
+MODULE_DESCRIPTION("Minimal driver for MaxLinear MxL862xx switch family");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mxl862xx");
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
new file mode 100644
index 0000000000000..3ecde075212e2
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define MXL862XX_MAX_PHY_PORT_NUM	8
+#define MXL862XX_MAX_EXT_PORT_NUM	7
+#define MXL862XX_MAX_PORT_NUM		(MXL862XX_MAX_PHY_PORT_NUM + \
+					 MXL862XX_MAX_EXT_PORT_NUM)
+
+#define MXL86252_PHY_PORT_NUM		5
+#define MXL86282_PHY_PORT_NUM		8
+
+#define MXL86252_EXT_PORT_NUM		2
+#define MXL86282_EXT_PORT_NUM		2
+
+struct mxl862xx_hw_info {
+	u8 max_ports;
+	u8 phy_ports;
+	u8 ext_ports;
+};
+
+struct mxl862xx_priv {
+	struct dsa_switch *ds;
+	struct mii_bus *bus;
+	struct device *dev;
+	int sw_addr;
+	const struct mxl862xx_hw_info *hw_info;
+	u8 cpu_port;
+};
-- 
2.52.0

