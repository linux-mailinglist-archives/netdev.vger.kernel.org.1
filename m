Return-Path: <netdev+bounces-275403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJbLNvVw0Wm+JgcAu9opvQ
	(envelope-from <netdev+bounces-275403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 22:13:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D639C621
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 324F43003D2B
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6133BBBA;
	Sat,  4 Apr 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8eAGki5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488E3019D6
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775333618; cv=none; b=F5N+VkJLpIqys6jZi5EH8DdGwDZkKKnn5ykiYWE5COorpBoVEWl8mdsGyDTgyqkTnKUmoCR3mctORLTpeClbU5b3dR4lRfLwPTDDjOzVzLiMxCoE+aamIlYOhGlJEoFzdv86xu13z1CatWECTLCteBSJy5cBXrLjUKUFjj8FCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775333618; c=relaxed/simple;
	bh=6IVkTjQ2D8zBMbDV+vErJ9JRCgC6abbJric/W+zRtIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNryCAXMdbyQWw7oor3+aBR8NtkT09BcmlqGYeCetsE12yMZF5QqKArspnoEw1H7wJPDvxEqIAp0a22IklRFstTwMxchhQFXHkUBQVd99JNnZBHL5M/jFgVh2nM63/9FDT0iTojGJfuEZa73/C5rfHHrxJlvFdB8LV3TLFv+TaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8eAGki5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so18270725e9.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775333615; x=1775938415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEYuEqxQ+TO3/jPNzXLnvJ7/Z/KsUW75My4aiFyt8Vc=;
        b=V8eAGki55jpJHVr0mIIPYqUGYm6zhlDT4r+2m8yoLovhhUGkQT+WfTGrexZ64WKHzB
         L70mpYrv/MUMepaTij90G8rArRS86VMO0w4eZ/Q92tDPrIV+S62MdLCJlHK/7IN0Tes+
         u900xyMYBZQInX+Jq+c0T7+8BHNbWXT9ZJbJrsd8Kj0CmAnfwriq0S9gmNH/6CEKJEvZ
         FqJZP++IE9rWxn+3nCr09mtOE0FTa4w1w046y7drnrg87wzAP+UDADOpkheWovPxKy3c
         FInmtCHr0LBK5rJCX6elBd1q/fc0jiHLLayZ8j9FL5O34yg1XU8ErqeJteUr4RJkGEwe
         hTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775333615; x=1775938415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEYuEqxQ+TO3/jPNzXLnvJ7/Z/KsUW75My4aiFyt8Vc=;
        b=V7HrIN9G1rx48qyIQt0O4jdiow4hNWC32ZAj6yNboU6DiEyht5qzE+YVGhC95N5ekl
         bMbPp7LrmKCX0uWIauwW6SRN16Ein5+/NoJGr+941XhdwDFNbEqKVZKdyucnnU/QxpHK
         977GqBLzo8Nbd52a2/xe11uPf7yHHnpOO109xlzWnOLtyLkMxcI8UpxsKTwX8MW71bOc
         cdCLZHqCJE6h3jTGMhci7tObvIAYYjJlLvrkL9ZKnb2OTOWNCFKs48qLrpCtPG0DkWze
         9hSlA2HZedv8q41UdHKrsCNTgeZYTzJ9mlZj75ME0/d3gTQ9bpPT9l1g/oNnQkgBgDgu
         eEtg==
X-Gm-Message-State: AOJu0YxXzreiczgxC4Vb6o+Ww5DDMWpSs0RRJlV8hwx2hUpnq9ucSB1m
	CfSUYxe2BGXK8a42GWT9u1y599Xk8mBztofTvTNmEp/DywQgCezHyN6X
X-Gm-Gg: AeBDievy55wrNkPHfLxjC0wpRDB6Sl4SalMnjRZWIw0+48Sit2Njt2OBnhUVv3gUc1m
	5Ozui8PflsEO/QJ5PLMxYlpJt2Uw8DD94swS+7q/LdvZi4jMm15ujsXqZQYDukEihOpABRcuiRX
	jrQPjgejc5Vitg2C9UJg+DO4/8wn/q7c4FMLI0I2IGxLpa9hLbVRC4c5xv6sZQsP2O/0uX+Kj13
	T9AmgQ9AWIZDifyNCmfsSGyMDx0FWb1WYJ5lYwPmbU2KBZKx2o5671378KrGV1UisYdRz3zROXH
	aiOE+bkGgoQkEYi113IK9HpeFjlLNXRCD7QLcujVaT4QbtYh8TlqUg58W999bkIOCYE1g65aQRk
	wSOZ6sIZF7CbBiyK4qofDZXR6aHKzNPp9cnu8OPDqDOA7+UXhXkvUCCbdy222FNdFIEAW5EK8CZ
	Ujta38wDQvFS09PZkz2Qlki3KqfaCcgH5OByM=
X-Received: by 2002:a05:600c:1d1c:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488997d1387mr109585605e9.27.1775333615312;
        Sat, 04 Apr 2026 13:13:35 -0700 (PDT)
Received: from rpi5.lan ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d58e5sm28179680f8f.23.2026.04.04.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 13:13:34 -0700 (PDT)
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [PATCH net-next v1] r8169: implement get_module functions for rtl8127atf
Date: Sat,  4 Apr 2026 21:13:32 +0100
Message-ID: <20260404201333.2849-1-fabio.baltieri@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275403-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[fabiobaltieri@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E5D639C621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement get_module_info and get_module_eeprom for supported devices,
right now that's the rtl8127atf.

This enables using ethtool to retrieve the transceiver identification
and diagnostic data.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---

Hi,

Realtek released a new out of tree driver for the rtl8127 and it
includes some code that exposes the I2C controller connected to the SFP
port.

This patch implements get_module_info and get_module_eeprom based on the
information found on that driver, it allows ethtool to fetch the SFP
module information, which is useful both to identify the module and to
track the health of fiber optic transceivers.

The logic for the SFF standard and i2c address selection is borrowed
directly from the aquantia/atlantic driver, I don't have a lot of stuff
to test it but I was able to trigger all code paths from a fiber optic
transceiver and an SFP cable I have available.

Demo:

# Fiber transceiver
$ sudo ethtool -m eth1
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Transceiver type                          : 10G Ethernet: 10G Base-SR
        Encoding                                  : 0x06 (64B/66B)
        BR Nominal                                : 10300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF)                              : 0km
        Length (OM2)                              : 80m
        Length (OM1)                              : 30m
        Length (Copper or Active cable)           : 0m
        Length (OM3)                              : 300m
        Laser wavelength                          : 850nm
        Vendor name                               : QSFPTEK
        Vendor OUI                                : 00:0a:0d
        Vendor PN                                 : QT-SFP+-SR
        Vendor rev                                : 
        Option values                             : 0x00 0x1a
        Option                                    : TX_DISABLE implemented
        BR margin max                             : 10%
        BR margin min                             : 88%
        Vendor SN                                 : QT8250805131
        Date code                                 : 250806
        Optical diagnostics support               : Yes
        Laser bias current                        : 5.880 mA
        Laser output power                        : 0.5431 mW / -2.65 dBm
        Receiver signal average optical power     : 0.6912 mW / -1.60 dBm
        Module temperature                        : 20.70 degrees C / 69.25 degrees F
        Module voltage                            : 3.3000 V
...

# DAC
$ sudo ethtool -m eth1
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
        Connector                                 : 0x21 (Copper pigtail)
        Transceiver codes                         : 0x00 0x00 0x00 0x00 0x00 0x04 0x00 0x00 0x00
        Transceiver type                          : Passive Cable
        Encoding                                  : 0x00 (unspecified)
        BR Nominal                                : 10300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF)                              : 0km
        Length (OM2)                              : 0m
        Length (OM1)                              : 0m
        Length (Copper or Active cable)           : 1m
        Length (OM3)                              : 0m
        Passive Cu cmplnce.                       : 0x01 (SFF-8431 appendix E [SFF-8472 rev10.4 only])
        Vendor name                               : OEM
        Vendor OUI                                : 00:40:20
        Vendor PN                                 : SFP-H10GB-CU1M
        Vendor rev                                : R
        Option values                             : 0x00 0x00
        BR margin max                             : 0%
        BR margin min                             : 0%
        Vendor SN                                 : CSC240415030053
        Date code                                 : 240508
...

# No module
$ sudo ethtool -m eth1
netlink error: Input/output error

Cheers,
Fabio


 drivers/net/ethernet/realtek/r8169_main.c | 177 ++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 58788d196c57..45ec0b5c1c21 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2411,6 +2411,181 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
+#define R8127_SDS_I2C_CON		0xe200
+#define R8127_SDS_I2C_TAR		0xe204
+#define R8127_SDS_I2C_DATA_CMD		0xe210
+#define R8127_SDS_I2C_FS_SCL_HCNT	0xe21c
+#define R8127_SDS_I2C_FS_SCL_LCNT	0xe220
+#define R8127_SDS_I2C_INTR_STAT		0xe22c
+#define R8127_SDS_I2C_EN		0xe26c
+#define R8127_SDS_I2C_STATUS		0xe270
+
+#define R8127_SDS_I2C_STATUS_ACTIVITY BIT(0)
+#define R8127_SDS_I2C_RX_FIFO_NOT_EMPTY BIT(3)
+#define R8127_SDS_I2C_STAT_TX_ABRT BIT(6)
+
+#define R8127_SDS_I2C_CMD_READ BIT(8)
+#define R8127_SDS_I2C_CMD_STOP BIT(9)
+#define R8127_SDS_I2C_CMD_RESTART BIT(10)
+
+#define SFF_8472_ID_ADDR 0x50
+#define SFF_8472_DIAGNOSTICS_ADDR 0x51
+
+#define SFF_8472_COMP_ADDR      0x5e
+#define SFF_8472_DOM_TYPE_ADDR  0x5c
+
+#define SFF_8472_ADDRESS_CHANGE_REQ_MASK 0x4
+
+static void r8127_sfp_sds_i2c_init(struct rtl8169_private *tp, u8 addr)
+{
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_EN, 0);
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_CON, 0x65);
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_TAR, addr);
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_FS_SCL_HCNT, 0x23a);
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_FS_SCL_LCNT, 0x23a);
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_EN, 1);
+}
+
+static void r8127_sfp_sds_i2c_disable(struct rtl8169_private *tp)
+{
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_EN, 0);
+}
+
+DECLARE_RTL_COND(r8127_sfp_sds_i2c_idle_cond)
+{
+	u16 val;
+
+	val = r8168_mac_ocp_read(tp, R8127_SDS_I2C_STATUS);
+
+	return val & R8127_SDS_I2C_STATUS_ACTIVITY;
+}
+
+DECLARE_RTL_COND(r8127_sfp_sds_i2c_rx_fifo_cond)
+{
+	u16 val;
+
+	val = r8168_mac_ocp_read(tp, R8127_SDS_I2C_STATUS);
+
+	return val & R8127_SDS_I2C_RX_FIFO_NOT_EMPTY;
+}
+
+static int r8127_sfp_sds_i2c_read(struct rtl8169_private *tp,
+				  u8 addr, u8 off, u8 *buf, u16 len)
+{
+	u16 intr_stat;
+	int ret = 0;
+
+	r8127_sfp_sds_i2c_init(tp, addr);
+
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_DATA_CMD, off);
+
+	if (!rtl_loop_wait_low(tp, &r8127_sfp_sds_i2c_idle_cond, 10, 100)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	intr_stat = r8168_mac_ocp_read(tp, R8127_SDS_I2C_INTR_STAT);
+	if (intr_stat & R8127_SDS_I2C_STAT_TX_ABRT) {
+		/* NACK */
+		ret = -EIO;
+		goto out;
+	}
+
+	for (int i = 0; i < len; i++) {
+		u16 data = R8127_SDS_I2C_CMD_READ;
+
+		if (i == len - 1)
+			data |= R8127_SDS_I2C_CMD_STOP;
+		if (i == 0)
+			data |= R8127_SDS_I2C_CMD_RESTART;
+
+		r8168_mac_ocp_write(tp, R8127_SDS_I2C_DATA_CMD, data);
+
+		if (!rtl_loop_wait_high(tp, &r8127_sfp_sds_i2c_rx_fifo_cond,
+					10, 1000)) {
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
+		buf[i] = r8168_mac_ocp_read(tp, R8127_SDS_I2C_DATA_CMD);
+	}
+
+out:
+	r8127_sfp_sds_i2c_disable(tp);
+
+	return ret;
+}
+
+static int rtl8169_get_module_info(struct net_device *ndev,
+				   struct ethtool_modinfo *modinfo)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+	u8 compliance_val, dom_type;
+	int ret;
+
+	if (!tp->sfp_mode)
+		return -EOPNOTSUPP;
+
+	ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_ID_ADDR,
+				     SFF_8472_COMP_ADDR, &compliance_val, 1);
+	if (ret)
+		return ret;
+
+	ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_ID_ADDR,
+				     SFF_8472_DOM_TYPE_ADDR, &dom_type, 1);
+	if (ret)
+		return ret;
+
+	if (dom_type & SFF_8472_ADDRESS_CHANGE_REQ_MASK || compliance_val == 0x00) {
+		modinfo->type = ETH_MODULE_SFF_8079;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
+	} else {
+		modinfo->type = ETH_MODULE_SFF_8472;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
+	}
+
+	return 0;
+}
+
+static int rtl8169_get_module_eeprom(struct net_device *ndev,
+				     struct ethtool_eeprom *ee, unsigned char *data)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+	unsigned int first, last, len;
+	int ret;
+
+	if (!tp->sfp_mode)
+		return -EOPNOTSUPP;
+
+	first = ee->offset;
+	last = ee->offset + ee->len;
+
+	if (first < ETH_MODULE_SFF_8079_LEN) {
+		len = min(last, ETH_MODULE_SFF_8079_LEN);
+		len -= first;
+
+		ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_ID_ADDR,
+					     first, data, len);
+		if (ret)
+			return ret;
+
+		first += len;
+		data += len;
+	}
+	if (first < ETH_MODULE_SFF_8472_LEN && last > ETH_MODULE_SFF_8079_LEN) {
+		len = min(last, ETH_MODULE_SFF_8472_LEN);
+		len -= first;
+		first -= ETH_MODULE_SFF_8079_LEN;
+
+		ret = r8127_sfp_sds_i2c_read(tp, SFF_8472_DIAGNOSTICS_ADDR,
+					     first, data, len);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -2437,6 +2612,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.set_pauseparam		= rtl8169_set_pauseparam,
 	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
+	.get_module_info	= rtl8169_get_module_info,
+	.get_module_eeprom	= rtl8169_get_module_eeprom,
 };
 
 static const struct rtl_chip_info *rtl8169_get_chip_version(u32 xid, bool gmii)
-- 
2.47.3


