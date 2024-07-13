Return-Path: <netdev+bounces-111270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231493075F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7E7282874
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFF1487CC;
	Sat, 13 Jul 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlsVmSCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F915ADA4;
	Sat, 13 Jul 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905400; cv=none; b=LLcgl60hCbAtKNCQY38vVoKf03qkvKCZw777nUtokiDJKk9jNDtYSyNIphYjpx/dYsTNjZScL/5X8Uy7vpRirf4jQt736qQX80mjfKXZrncR8wY0jhFG1ATePNZf4IrK1unnsXPk0BkZzFUD0yHB2+zeczYIsN0OD8VNgdpQuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905400; c=relaxed/simple;
	bh=1pmmyCh+UmKSjC53va/rzAu6Mb/ywX3Bip6/8i1eQv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRbFKwLm5AlJy+ieFsLZHLsEj+XAedeb8jcchUlDPBMu8flaURVgif86Yd78WFO/2HKOrCuMj0C5ACu2NOVY4ZLsibWrBGxfCheqDV8NFDq86JW27K/G31gIivFEj08goLbluxQP8fKFng3BctC01cTmUZJBaQyTPdeXmiobfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlsVmSCb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso3931846a12.2;
        Sat, 13 Jul 2024 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905395; x=1721510195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C/JT13TVjmse+TKk/nGezKHXQc6WWm9oDv12cA+Wc8=;
        b=NlsVmSCblcgq/zozocGYsjjXHOQDtqqmlEVbA8ZPm7kNLOiNWYRv7PsC0rC7W7RP3R
         uU0/ADU9BzF67i72VJ5kHIILKhpqSLw6pvhImZjMy461bOVlt534xV5suAoZxrf1u/vt
         hIEO/797+UeoPZjXmUsmGl0OIzUBGg5YmxSZT+pKU0jHPntOQaH7Dbo25bPZD3MHtAuR
         y43C/RSwcOrJJXEdF1qGRzOvEjFtf8a2HjlGWS9sFlgnqqzNqBkNXGnNeYG19C2428mZ
         QYnzeO6RYNJIAg1673hZoURQZWRFyEqnoA04GJD0woOGyDDmkPIXxeCgQBnSBIclKI+d
         ZwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905395; x=1721510195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C/JT13TVjmse+TKk/nGezKHXQc6WWm9oDv12cA+Wc8=;
        b=fx3K2ynaRJzFjVC4mOvYp/CYVZulzfuzzlHbVGbqnPdyn9jj5RFlYBdjRJNyC73fxV
         tiIoQ3r7VqDKJyNVlT9JvLleWV1xcknnIDoL6oQmmp1YgB9qblzcJmeRGZX/+cAnF0VQ
         czDRQvoJUiOg5K7fVCUReKvlBSU7EaUR5r5Wwz136BmdoSVP9PVZiKoNobvXy80aKYiZ
         rY94R5o37nHm/+Cw/zv3rYho+fUfBiRx6SgQqmiTYEAAFk8KqwVKN75BlQt/ZAKl5PFM
         5RRPbGCdx4T/TcYnXVqsWFDgbkHMmndGsWWUu1W8QYNikv2nIZzcw4sRtcHsChk2YuO9
         Ov6g==
X-Forwarded-Encrypted: i=1; AJvYcCX/3A+FkaVVuYvzJkWIsgS2UBflQbqSfW1ca5LbSpjgP4TDPKSGmxMSdqVW5pYnpwtXBHTbv5R9jMAFTM8p//vgCTuElpxhdBJ38o1Y
X-Gm-Message-State: AOJu0YyYC+FaGd6g+DNPga+FJcxdj4GEox6z6mtRQOwWExN3vLk6ZpOG
	PqeH1NgVYElpm30efAXEyM4oLK7jjztEcVddgqv8poHsJKXwY/RJt2L79w0W
X-Google-Smtp-Source: AGHT+IH+7nsj7q3h42FcDjA+Wa98AJJ4qy3cCjP7Vo+XR/vrbzzWHsCZ4MADJBhso2/I3hpTcIMBNQ==
X-Received: by 2002:aa7:d450:0:b0:57c:a7fe:d275 with SMTP id 4fb4d7f45d1cf-594bc7c8097mr8914782a12.32.1720905395192;
        Sat, 13 Jul 2024 14:16:35 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:34 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 02/12] net: dsa: vsc73xx: Add vlan filtering
Date: Sat, 13 Jul 2024 23:16:08 +0200
Message-Id: <20240713211620.1125910-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements VLAN filtering for the vsc73xx driver.

After starting VLAN filtering, the switch is reconfigured from QinQ to
a simple VLAN aware mode. This is required because VSC73XX chips do not
support inner VLAN tag filtering.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - fix kdoc
v3:
  - added kdoc descriptions of some functions
  - fixed typos
  - modified 'vsc73xx_vlan_commit_untagged' implementation
  - introduce 'vsc73xx_vlan_commit_settings'
  - removed unnescessary 'portinfo' value initialization
  - CPU_PORT is now addded to VLAN map
  - removed 'untagged_tag_8021q' from 'portinfo'
  - removed unnescessary 'port_setup' implementation
v2:
  - removed not needed INIT_LIST_HEAD
  - fix vsc73xx_vlan removing procedure
  - fix code spell
  - handle return codes from 'vsc73xx_vlan_commit*' functions
  - move 'vsc73xx_vlan_commit*' call from port_setup to port_enable to
    avoid unused port configuration
v1:
  - refactored pvid, untagged and vlan filter configuration
  - fix typo
  - simplification
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - set init value of 'ret' in 'vsc73xx_port_vlan_add'
v7:
  - rework pvid and untagged configuration routines
  - introduce portinfo structure which should make pvid/untagged
    procedures simpler
  - introduce 'vsc73xx_vlan_summary' structure
  - replace tagged/untagged count functions with 'vsc73xx_bridge_vlan_summary'
  - fix VSC73XX_VLANMASK configuration. It was copy from existing code.
  - stop configuring pvid/untagged registers whed pvid/untagged is
    disabled
v6:
  - resend only
v5:
  - fix possible leak in 'vsc73xx_port_vlan_add'
  - use proper variable in statement from 'vsc73xx_port_vlan_filtering'
  - change 'vlan_no' name to 'vid'
  - codding style improvements
  - comment improvements
  - handle return of 'vsc73xx_update_bits'
  - reduce I/O operations
  - use 'size_t' for counting variables
v4:
  - reworked most of conditional register configs
  - simplified port_vlan function
  - move vlan table clearing from port_setup to setup
  - pvid configuration simplified (now kernel take care about no of
    pvids per port)
  - port vlans are stored in list now
  - introduce implementation of all untagged vlans state
  - many minor changes
v3:
  - reworked all vlan commits
  - added storage variables for pvid and untagged vlans
  - move length extender settings to port setup
  - remove vlan table cleaning in wrong places
v2:
  - no changes done
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 532 ++++++++++++++++++++++++-
 drivers/net/dsa/vitesse-vsc73xx.h      |  37 ++
 2 files changed, 566 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ebeea259f019..906bbae22861 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -22,9 +22,11 @@
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/etherdevice.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
+#include <linux/dsa/8021q.h>
 #include <linux/random.h>
 #include <net/dsa.h>
 
@@ -62,6 +64,8 @@
 #define VSC73XX_CAT_DROP	0x6e
 #define VSC73XX_CAT_PR_MISC_L2	0x6f
 #define VSC73XX_CAT_PR_USR_PRIO	0x75
+#define VSC73XX_CAT_VLAN_MISC	0x79
+#define VSC73XX_CAT_PORT_VLAN	0x7a
 #define VSC73XX_Q_MISC_CONF	0xdf
 
 /* MAC_CFG register bits */
@@ -122,6 +126,17 @@
 #define VSC73XX_ADVPORTM_IO_LOOPBACK	BIT(1)
 #define VSC73XX_ADVPORTM_HOST_LOOPBACK	BIT(0)
 
+/*  TXUPDCFG transmit modify setup bits */
+#define VSC73XX_TXUPDCFG_DSCP_REWR_MODE	GENMASK(20, 19)
+#define VSC73XX_TXUPDCFG_DSCP_REWR_ENA	BIT(18)
+#define VSC73XX_TXUPDCFG_TX_INT_TO_USRPRIO_ENA	BIT(17)
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID	GENMASK(15, 4)
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA	BIT(3)
+#define VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA	BIT(1)
+#define VSC73XX_TXUPDCFG_TX_INSERT_TAG	BIT(0)
+
+#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT	4
+
 /* CAT_DROP categorizer frame dropping register bits */
 #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA	BIT(6)
 #define VSC73XX_CAT_DROP_FWD_CTRL_ENA		BIT(4)
@@ -135,6 +150,15 @@
 #define VSC73XX_Q_MISC_CONF_EARLY_TX_512	(1 << 1)
 #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE	BIT(0)
 
+/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits */
+#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
+#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
+
+/* CAT_PORT_VLAN categorizer port VLAN */
+#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
+#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
+
 /* Frame analyzer block 2 registers */
 #define VSC73XX_STORMLIMIT	0x02
 #define VSC73XX_ADVLEARN	0x03
@@ -189,7 +213,8 @@
 #define VSC73XX_VLANACCESS_VLAN_MIRROR		BIT(29)
 #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK	BIT(28)
 #define VSC73XX_VLANACCESS_VLAN_PORT_MASK	GENMASK(9, 2)
-#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(2, 0)
+#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT	2
+#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(1, 0)
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE	0
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY	1
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY	2
@@ -347,6 +372,17 @@ static const struct vsc73xx_counter vsc73xx_tx_counters[] = {
 	{ 29, "TxQoSClass3" }, /* non-standard counter */
 };
 
+struct vsc73xx_vlan_summary {
+	size_t num_tagged;
+	size_t num_untagged;
+};
+
+enum vsc73xx_port_vlan_conf {
+	VSC73XX_VLAN_FILTER,
+	VSC73XX_VLAN_FILTER_UNTAG_ALL,
+	VSC73XX_VLAN_IGNORE,
+};
+
 int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 {
 	switch (block) {
@@ -564,6 +600,90 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_NONE;
 }
 
+static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 ||
+				((val & VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK) ==
+				VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE),
+				VSC73XX_POLL_SLEEP_US, VSC73XX_POLL_TIMEOUT_US,
+				false, vsc, VSC73XX_BLOCK_ANALYZER,
+				0, VSC73XX_VLANACCESS, &val);
+	if (ret)
+		return ret;
+	return err;
+}
+
+static int
+vsc73xx_read_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 *portmap)
+{
+	u32 val;
+	int ret;
+
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
+
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
+
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, &val);
+	*portmap = (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
+		   VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
+
+	return 0;
+}
+
+static int
+vsc73xx_write_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 portmap)
+{
+	int ret;
+
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
+
+	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
+	if (ret)
+		return ret;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
+			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
+			    VSC73XX_VLANACCESS_VLAN_PORT_MASK,
+			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
+			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
+			    (portmap << VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT));
+
+	return vsc73xx_wait_for_vlan_table_cmd(vsc);
+}
+
+static int
+vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
+{
+	u8 portmap;
+	int ret;
+
+	ret = vsc73xx_read_vlan_table_entry(vsc, vid, &portmap);
+	if (ret)
+		return ret;
+
+	if (set)
+		portmap |= BIT(port);
+	else
+		portmap &= ~BIT(port);
+
+	return vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
+}
+
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -598,7 +718,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 		      VSC73XX_MACACCESS,
 		      VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
 
-	/* Clear VLAN table */
+	/* Set VLAN table to default values */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 		      VSC73XX_VLANACCESS,
 		      VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
@@ -627,6 +747,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
+	/* Ingess VLAN reception mask (table 145) */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
+		      0xff);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -639,6 +762,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	udelay(4);
 
+	/* Clear VLAN table */
+	for (i = 0; i < VLAN_N_VID; i++)
+		vsc73xx_write_vlan_table_entry(vsc, i, 0);
+
+	INIT_LIST_HEAD(&vsc->vlans);
+
 	return 0;
 }
 
@@ -825,6 +954,12 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
 	val |= VSC73XX_MAC_CFG_SEED_LOAD;
 	val |= VSC73XX_MAC_CFG_WEXC_DIS;
+
+	/* Those bits are responsible for MTU only. Kernel takes care about MTU,
+	 * let's enable +8 bytes frame length unconditionally.
+	 */
+	val |= VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VLAN_DBLAWR;
+
 	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG, val);
 
 	/* Flow control for the PHY facing ports:
@@ -853,6 +988,257 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
 }
 
+static bool vsc73xx_tag_8021q_active(struct dsa_port *dp)
+{
+	return !dsa_port_is_vlan_filtering(dp);
+}
+
+static struct vsc73xx_bridge_vlan *
+vsc73xx_bridge_vlan_find(struct vsc73xx *vsc, u16 vid)
+{
+	struct vsc73xx_bridge_vlan *vlan;
+
+	list_for_each_entry(vlan, &vsc->vlans, list)
+		if (vlan->vid == vid)
+			return vlan;
+
+	return NULL;
+}
+
+static void
+vsc73xx_bridge_vlan_remove_port(struct vsc73xx_bridge_vlan *vsc73xx_vlan,
+				int port)
+{
+	vsc73xx_vlan->portmask &= ~BIT(port);
+
+	if (vsc73xx_vlan->portmask)
+		return;
+
+	list_del(&vsc73xx_vlan->list);
+	kfree(vsc73xx_vlan);
+}
+
+static void vsc73xx_bridge_vlan_summary(struct vsc73xx *vsc, int port,
+					struct vsc73xx_vlan_summary *summary,
+					u16 ignored_vid)
+{
+	size_t num_tagged = 0, num_untagged = 0;
+	struct vsc73xx_bridge_vlan *vlan;
+
+	list_for_each_entry(vlan, &vsc->vlans, list) {
+		if (!(vlan->portmask & BIT(port)) || vlan->vid == ignored_vid)
+			continue;
+
+		if (vlan->untagged & BIT(port))
+			num_untagged++;
+		else
+			num_tagged++;
+	}
+
+	summary->num_untagged = num_untagged;
+	summary->num_tagged = num_tagged;
+}
+
+static u16 vsc73xx_find_first_vlan_untagged(struct vsc73xx *vsc, int port)
+{
+	struct vsc73xx_bridge_vlan *vlan;
+
+	list_for_each_entry(vlan, &vsc->vlans, list)
+		if ((vlan->portmask & BIT(port)) &&
+		    (vlan->untagged & BIT(port)))
+			return vlan->vid;
+
+	return VLAN_N_VID;
+}
+
+static int vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
+				 enum vsc73xx_port_vlan_conf port_vlan_conf)
+{
+	u32 val = 0;
+	int ret;
+
+	if (port_vlan_conf == VSC73XX_VLAN_IGNORE)
+		val = VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
+		      VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA;
+
+	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				  VSC73XX_CAT_VLAN_MISC,
+				  VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
+				  VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val);
+	if (ret)
+		return ret;
+
+	val = (port_vlan_conf == VSC73XX_VLAN_FILTER) ?
+	      VSC73XX_TXUPDCFG_TX_INSERT_TAG : 0;
+
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				   VSC73XX_TXUPDCFG,
+				   VSC73XX_TXUPDCFG_TX_INSERT_TAG, val);
+}
+
+/**
+ * vsc73xx_vlan_commit_conf - Update VLAN configuration of a port
+ * @vsc: Switch private data structure
+ * @port: Port index on which to operate
+ *
+ * Update the VLAN behavior of a port to make sure that when it is under
+ * a VLAN filtering bridge, the port is either filtering with tag
+ * preservation, or filtering with all VLANs egress-untagged. Otherwise,
+ * the port ignores VLAN tags from packets and applies the port-based
+ * VID.
+ *
+ * Must be called when changes are made to:
+ * - the bridge VLAN filtering state of the port
+ * - the number or attributes of VLANs from the bridge VLAN table,
+ *   while the port is currently VLAN-aware
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int vsc73xx_vlan_commit_conf(struct vsc73xx *vsc, int port)
+{
+	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
+	struct dsa_port *dp = dsa_to_port(vsc->ds, port);
+
+	if (port == CPU_PORT) {
+		port_vlan_conf = VSC73XX_VLAN_FILTER;
+	} else if (dsa_port_is_vlan_filtering(dp)) {
+		struct vsc73xx_vlan_summary summary;
+
+		port_vlan_conf = VSC73XX_VLAN_FILTER;
+
+		vsc73xx_bridge_vlan_summary(vsc, port, &summary, VLAN_N_VID);
+		if (summary.num_tagged == 0)
+			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
+	}
+
+	return vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
+}
+
+static int
+vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, bool set)
+{
+	u32 val = 0;
+
+	if (set)
+		val = VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
+		      ((vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT) &
+		       VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
+
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				   VSC73XX_TXUPDCFG,
+				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA |
+				   VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, val);
+}
+
+/**
+ * vsc73xx_vlan_commit_untagged - Update native VLAN of a port
+ * @vsc: Switch private data structure
+ * @port: Port index on which to operate
+ *
+ * Update the native VLAN of a port (the one VLAN which is transmitted
+ * as egress-tagged on a trunk port) when port is in VLAN filtering mode and
+ * only one untagged vid is configured.
+ * In other cases no need to configure it because switch can untag all vlans on
+ * the port.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int vsc73xx_vlan_commit_untagged(struct vsc73xx *vsc, int port)
+{
+	struct dsa_port *dp = dsa_to_port(vsc->ds, port);
+	struct vsc73xx_vlan_summary summary;
+	u16 vid = 0;
+	bool valid;
+
+	if (!dsa_port_is_vlan_filtering(dp))
+		/* Port is configured to untag all vlans in that case.
+		 * No need to commit untagged config change.
+		 */
+		return 0;
+
+	vsc73xx_bridge_vlan_summary(vsc, port, &summary, VLAN_N_VID);
+
+	if (summary.num_untagged > 1)
+		/* Port must untag all vlans in that case.
+		 * No need to commit untagged config change.
+		 */
+		return 0;
+
+	valid = (summary.num_untagged == 1);
+	if (valid)
+		vid = vsc73xx_find_first_vlan_untagged(vsc, port);
+
+	return vsc73xx_vlan_change_untagged(vsc, port, vid, valid);
+}
+
+static int
+vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid, bool set)
+{
+	u32 val = 0;
+	int ret;
+
+	val = set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
+
+	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				  VSC73XX_CAT_DROP,
+				  VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
+	if (!set || ret)
+		return ret;
+
+	return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				   VSC73XX_CAT_PORT_VLAN,
+				   VSC73XX_CAT_PORT_VLAN_VLAN_VID,
+				   vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
+}
+
+/**
+ * vsc73xx_vlan_commit_pvid - Update port-based default VLAN of a port
+ * @vsc: Switch private data structure
+ * @port: Port index on which to operate
+ *
+ * Update the PVID of a port so that it follows either the bridge PVID
+ * configuration, when the bridge is currently VLAN-aware, or the PVID
+ * from tag_8021q, when the port is standalone or under a VLAN-unaware
+ * bridge. A port with no PVID drops all untagged and VID 0 tagged
+ * traffic.
+ *
+ * Must be called when changes are made to:
+ * - the bridge VLAN filtering state of the port
+ * - the number or attributes of VLANs from the bridge VLAN table,
+ *   while the port is currently VLAN-aware
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int vsc73xx_vlan_commit_pvid(struct vsc73xx *vsc, int port)
+{
+	struct vsc73xx_portinfo *portinfo = &vsc->portinfo[port];
+	bool valid = portinfo->pvid_tag_8021q_configured;
+	struct dsa_port *dp = dsa_to_port(vsc->ds, port);
+	u16 vid = portinfo->pvid_tag_8021q;
+
+	if (dsa_port_is_vlan_filtering(dp)) {
+		vid = portinfo->pvid_vlan_filtering;
+		valid = portinfo->pvid_vlan_filtering_configured;
+	}
+
+	return vsc73xx_vlan_change_pvid(vsc, port, vid, valid);
+}
+
+static int vsc73xx_vlan_commit_settings(struct vsc73xx *vsc, int port)
+{
+	int ret;
+
+	ret = vsc73xx_vlan_commit_untagged(vsc, port);
+	if (ret)
+		return ret;
+
+	ret = vsc73xx_vlan_commit_pvid(vsc, port);
+	if (ret)
+		return ret;
+
+	return vsc73xx_vlan_commit_conf(vsc, port);
+}
+
 static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
 			       struct phy_device *phy)
 {
@@ -861,7 +1247,7 @@ static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
 	dev_info(vsc->dev, "enable port %d\n", port);
 	vsc73xx_init_port(vsc, port);
 
-	return 0;
+	return vsc73xx_vlan_commit_settings(vsc, port);
 }
 
 static void vsc73xx_port_disable(struct dsa_switch *ds, int port)
@@ -1032,6 +1418,143 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static int
+vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
+			    bool vlan_filtering, struct netlink_ext_ack *extack)
+{
+	struct vsc73xx *vsc = ds->priv;
+
+	/* The commit to hardware processed below is required because vsc73xx
+	 * is using tag_8021q. When vlan_filtering is disabled, tag_8021q uses
+	 * pvid/untagged vlans for port recognition. The values configured for
+	 * vlans and pvid/untagged states are stored in portinfo structure.
+	 * When vlan_filtering is enabled, we need to restore pvid/untagged from
+	 * portinfo structure. Analogous routine is processed when
+	 * vlan_filtering is disabled, but values used for tag_8021q are
+	 * restored.
+	 */
+
+	return vsc73xx_vlan_commit_settings(vsc, port);
+}
+
+static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
+	struct vsc73xx_vlan_summary summary;
+	struct vsc73xx_portinfo *portinfo;
+	struct vsc73xx *vsc = ds->priv;
+	bool commit_to_hardware;
+	int ret = 0;
+
+	/* Be sure to deny alterations to the configuration done by tag_8021q.
+	 */
+	if (vid_is_dsa_8021q(vlan->vid)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Range 3072-4095 reserved for dsa_8021q operation");
+		return -EBUSY;
+	}
+
+	/* The processed vlan->vid is excluded from the search because the VLAN
+	 * can be re-added with a different set of flags, so it's easiest to
+	 * ignore its old flags from the VLAN database software copy.
+	 */
+	vsc73xx_bridge_vlan_summary(vsc, port, &summary, vlan->vid);
+
+	/* VSC73XX allows only three untagged states: none, one or all */
+	if ((untagged && summary.num_tagged > 0 && summary.num_untagged > 0) ||
+	    (!untagged && summary.num_untagged > 1)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Port can have only none, one or all untagged vlan");
+		return -EBUSY;
+	}
+
+	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
+
+	if (!vsc73xx_vlan) {
+		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
+		if (!vsc73xx_vlan)
+			return -ENOMEM;
+
+		vsc73xx_vlan->vid = vlan->vid;
+
+		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
+	}
+
+	vsc73xx_vlan->portmask |= BIT(port);
+
+	/* CPU port must be always tagged because source port identification is
+	 * based on tag_8021q.
+	 */
+	if (port == CPU_PORT)
+		goto update_vlan_table;
+
+	if (untagged)
+		vsc73xx_vlan->untagged |= BIT(port);
+	else
+		vsc73xx_vlan->untagged &= ~BIT(port);
+
+	portinfo = &vsc->portinfo[port];
+
+	if (pvid) {
+		portinfo->pvid_vlan_filtering_configured = true;
+		portinfo->pvid_vlan_filtering = vlan->vid;
+	} else if (portinfo->pvid_vlan_filtering_configured &&
+		   portinfo->pvid_vlan_filtering == vlan->vid) {
+		portinfo->pvid_vlan_filtering_configured = false;
+	}
+
+	commit_to_hardware = !vsc73xx_tag_8021q_active(dp);
+	if (commit_to_hardware) {
+		ret = vsc73xx_vlan_commit_settings(vsc, port);
+		if (ret)
+			goto err;
+	}
+
+update_vlan_table:
+	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);
+	if (!ret)
+		return 0;
+err:
+	vsc73xx_bridge_vlan_remove_port(vsc73xx_vlan, port);
+	return ret;
+}
+
+static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
+	struct vsc73xx_portinfo *portinfo;
+	struct vsc73xx *vsc = ds->priv;
+	bool commit_to_hardware;
+	int ret;
+
+	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, false);
+	if (ret)
+		return ret;
+
+	portinfo = &vsc->portinfo[port];
+
+	if (portinfo->pvid_vlan_filtering_configured &&
+	    portinfo->pvid_vlan_filtering == vlan->vid)
+		portinfo->pvid_vlan_filtering_configured = false;
+
+	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
+
+	if (vsc73xx_vlan)
+		vsc73xx_bridge_vlan_remove_port(vsc73xx_vlan, port);
+
+	commit_to_hardware = !vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
+	if (commit_to_hardware)
+		return vsc73xx_vlan_commit_settings(vsc, port);
+
+	return 0;
+}
+
 static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 {
 	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
@@ -1131,6 +1654,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
+	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
+	.port_vlan_add = vsc73xx_port_vlan_add,
+	.port_vlan_del = vsc73xx_port_vlan_del,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 2997f7e108b1..3ca579acc798 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -14,6 +14,22 @@
  */
 #define VSC73XX_MAX_NUM_PORTS	8
 
+/**
+ * struct vsc73xx_portinfo - port data structure: contains storage data
+ * @pvid_vlan_filtering: pvid vlan number used in vlan filtering mode
+ * @pvid_tag_8021q: pvid vlan number used in tag_8021q mode
+ * @pvid_vlan_filtering_configured: informs if port has configured pvid in vlan
+ *	filtering mode
+ * @pvid_tag_8021q_configured: imforms if port have configured pvid in tag_8021q
+ *	mode
+ */
+struct vsc73xx_portinfo {
+	u16		pvid_vlan_filtering;
+	u16		pvid_tag_8021q;
+	bool		pvid_vlan_filtering_configured;
+	bool		pvid_tag_8021q_configured;
+};
+
 /**
  * struct vsc73xx - VSC73xx state container: main data structure
  * @dev: The device pointer
@@ -25,6 +41,10 @@
  * @addr: MAC address used in flow control frames
  * @ops: Structure with hardware-dependent operations
  * @priv: Pointer to the configuration interface structure
+ * @portinfo: Storage table portinfo structructures
+ * @vlans: List of configured vlans. Contains port mask and untagged status of
+ *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
+ *	vlans.
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -35,6 +55,8 @@ struct vsc73xx {
 	u8				addr[ETH_ALEN];
 	const struct vsc73xx_ops	*ops;
 	void				*priv;
+	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
+	struct list_head		vlans;
 };
 
 /**
@@ -49,6 +71,21 @@ struct vsc73xx_ops {
 		     u32 val);
 };
 
+/**
+ * struct vsc73xx_bridge_vlan - VSC73xx driver structure which keeps vlan
+ *	database copy
+ * @vid: VLAN number
+ * @portmask: each bit represents one port
+ * @untagged: each bit represents one port configured with @vid untagged
+ * @list: list structure
+ */
+struct vsc73xx_bridge_vlan {
+	u16 vid;
+	u8 portmask;
+	u8 untagged;
+	struct list_head list;
+};
+
 int vsc73xx_is_addr_valid(u8 block, u8 subblock);
 int vsc73xx_probe(struct vsc73xx *vsc);
 void vsc73xx_remove(struct vsc73xx *vsc);
-- 
2.34.1


