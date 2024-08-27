Return-Path: <netdev+bounces-122311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C5960AA6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECC41F2394C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7361BBBDD;
	Tue, 27 Aug 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8agVJT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D919DF60;
	Tue, 27 Aug 2024 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762394; cv=none; b=HfqKFSv7QkLrgxl2x+9Y138qeR0QfZWrs0Ol6TCR8GY/PIKiAuWuJE+CfRg5WFDczvIx/QoxtkPhjZzRBXDK65ERmXkhFb3DbEVHFu6oC/2M3eZGil2otGwiEvljHKpqjgyY7UsnJQgM9YSD8s6dZz2XID0qhsTlke1362JCzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762394; c=relaxed/simple;
	bh=osO3txE578AzhhpdQLmuz9nB2hQqIwP8Zk85pkOtEt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PhauMXcFALowUcuXetnnAFfaEX2HR8i42u9WlxChmJ1Pz0ifCtnqIKnmAOwmWTnNrmervsL7nBDmEVuJbniCwTeJbaSrisiydf3fEcBBBjmBymZCBB4Vt3TqsI5xSD0CTEjUbswKIxW+33iRKObKEJFq0U/QCYPNNh2N9IXWo1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8agVJT9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86b46c4831so377703466b.1;
        Tue, 27 Aug 2024 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724762390; x=1725367190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+1rUy0h9XGzxV50jLJOj+BRVgcP30bwblWUQAW/qHM=;
        b=b8agVJT99YQ49A0clFhCqQtILn9une3OpmUE2NXT9ICh86ji2Xy6TDzHEyoICxNa4n
         OV6qKF1xjqyH7EADkLZdxyVgOBP/EU7IZis1S2WZQdhwpAsrzsDXWS81lZHK13k2lSvT
         FN2+gX4N7gRLtmiyRCx5c72B7UFOztIOvRIHkBKXM7WScZ36vt3zyrr++Br1bNScFd72
         AD/1D3V96lWSjfgYP9HdcC0yFUNTuMZZBmJRgPczhGwtUqz2bYxK7GbVaCulA1MBnXkU
         U8OfWKL/ONfmlb1q2FM+UsIWtJbVEq05fAvWxttv9Oqzm1mV9uIWTpMre0i7Bj3VlsIz
         6shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724762390; x=1725367190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+1rUy0h9XGzxV50jLJOj+BRVgcP30bwblWUQAW/qHM=;
        b=kq9CJXa54448ayO0q7j3cGu786gjHQ208QOtrpcFwzlBXDxadHNpftZg1H1exWIsOi
         mBiRaEdqW2/XZRxofCcY+6RF5xKfBO+NPwIUGpN6OqW43ZRylkArL4ZstQw1Y/frCZJH
         K6jfnES6KBZwGck8yTX38hQ3ONGxhzZx5qZVaB69MuwmR9lceHqxdbKCAqBGSzeeUsNc
         NPJklNJQ2bGR3n4QQ7Q+R9S8G1LkLSUNXhffrMtcAphvucTE05rw4DT9U/XJSAONZHjA
         R+w79R5mWnB+BvWqG+IMOzUAgUcbhGlY3d8arsWa3qrXCIdKDdby3Tce8bN1g3lTSvng
         BvYA==
X-Forwarded-Encrypted: i=1; AJvYcCX8fnh/muU1OHEqRDp0off5xvujabEF0CinqNZPNaKrWzxB7h6Qq5VrfnkgLhVru/lBvsHVDUuWoFlHsqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEwS6Ig1jc6PaI8hBGmXj83NDCotHNPIifpkffZqPTCdq44dn
	QkUl44ZePT0KgSdit+0l/QzYE240KcREDbA4uViZXbDk1mr4JcQMqBeytZHG
X-Google-Smtp-Source: AGHT+IHSFV24BatzNho6UCeaZ8oHipXTwOJ1tKe8xH2acHXxMwOSbNc/EYp6cQZ3bFVp372TvBp3Yw==
X-Received: by 2002:a17:907:7f1f:b0:a86:9041:a42a with SMTP id a640c23a62f3a-a86a54f1438mr873123766b.62.1724762389424;
        Tue, 27 Aug 2024 05:39:49 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:e480:142a:a86:9281])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54a0299sm104713666b.76.2024.08.27.05.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:39:48 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: dsa: vsc73xx: implement FDB operations
Date: Tue, 27 Aug 2024 14:39:38 +0200
Message-Id: <20240827123938.582789-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces implementations of three functions:
.port_fdb_dump
.port_fdb_add
.port_fdb_del

The FDB database organization is the same as in other old Vitesse chips:
It has 2048 rows and 4 columns (buckets). The row index is calculated by
the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
exactly into row[hash]. The chip selects the bucket number by itself.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
Changes in v3:
  - refactor duplicated code
Changes in v2:
  - Use FIELD_PREP and macros in 'vsc73xx_calc_hash' funcion
  - improve commit message
  - consolidate row, entry, bucket terminology
  - check for error codes from vsc73xx_read() and vsc73xx_write()
  - check if cr return error
  - remove redundant comment
  - set fdb_isolation flag
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 355 +++++++++++++++++++++++++
 drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
 2 files changed, 357 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4d693c029c1f..1f2acd3dfcd2 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -46,6 +46,8 @@
 #define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
 
 #define CPU_PORT	6 /* CPU port */
+#define VSC73XX_NUM_FDB_ROWS	2048
+#define VSC73XX_NUM_BUCKETS	4
 
 /* MAC Block registers */
 #define VSC73XX_MAC_CFG		0x00
@@ -197,6 +199,40 @@
 #define VSC73XX_SRCMASKS_MIRROR			BIT(26)
 #define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
 
+#define VSC73XX_MACHDATA_VID			GENMASK(27, 16)
+#define VSC73XX_MACHDATA_MAC0			GENMASK(15, 8)
+#define VSC73XX_MACHDATA_MAC1			GENMASK(7, 0)
+#define VSC73XX_MACLDATA_MAC2			GENMASK(31, 24)
+#define VSC73XX_MACLDATA_MAC3			GENMASK(23, 16)
+#define VSC73XX_MACLDATA_MAC4			GENMASK(15, 8)
+#define VSC73XX_MACLDATA_MAC5			GENMASK(7, 0)
+
+#define VSC73XX_HASH0_VID_FROM_MASK		GENMASK(5, 0)
+#define VSC73XX_HASH0_MAC0_FROM_MASK		GENMASK(7, 4)
+#define VSC73XX_HASH1_MAC0_FROM_MASK		GENMASK(3, 0)
+#define VSC73XX_HASH1_MAC1_FROM_MASK		GENMASK(7, 1)
+#define VSC73XX_HASH2_MAC1_FROM_MASK		BIT(0)
+#define VSC73XX_HASH2_MAC2_FROM_MASK		GENMASK(7, 0)
+#define VSC73XX_HASH2_MAC3_FROM_MASK		GENMASK(7, 6)
+#define VSC73XX_HASH3_MAC3_FROM_MASK		GENMASK(5, 0)
+#define VSC73XX_HASH3_MAC4_FROM_MASK		GENMASK(7, 3)
+#define VSC73XX_HASH4_MAC4_FROM_MASK		GENMASK(2, 0)
+
+#define VSC73XX_HASH0_VID_TO_MASK		GENMASK(9, 4)
+#define VSC73XX_HASH0_MAC0_TO_MASK		GENMASK(3, 0)
+#define VSC73XX_HASH1_MAC0_TO_MASK		GENMASK(10, 7)
+#define VSC73XX_HASH1_MAC1_TO_MASK		GENMASK(6, 0)
+#define VSC73XX_HASH2_MAC1_TO_MASK		BIT(10)
+#define VSC73XX_HASH2_MAC2_TO_MASK		GENMASK(9, 2)
+#define VSC73XX_HASH2_MAC3_TO_MASK		GENMASK(1, 0)
+#define VSC73XX_HASH3_MAC3_TO_MASK		GENMASK(10, 5)
+#define VSC73XX_HASH3_MAC4_TO_MASK		GENMASK(4, 0)
+#define VSC73XX_HASH4_MAC4_TO_MASK		GENMASK(10, 8)
+
+#define VSC73XX_MACTINDX_SHADOW			BIT(13)
+#define VSC73XX_MACTINDX_BUCKET_MSK		GENMASK(12, 11)
+#define VSC73XX_MACTINDX_INDEX_MSK		GENMASK(10, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -332,6 +368,13 @@ struct vsc73xx_counter {
 	const char *name;
 };
 
+struct vsc73xx_fdb {
+	u16 vid;
+	u8 port;
+	u8 mac[ETH_ALEN];
+	bool valid;
+};
+
 /* Counters are named according to the MIB standards where applicable.
  * Some counters are custom, non-standard. The standard counters are
  * named in accordance with RFC2819, RFC2021 and IEEE Std 802.3-2002 Annex
@@ -804,6 +847,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	ds->untag_bridge_pvid = true;
 	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+	ds->fdb_isolation = true;
 
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
@@ -1854,6 +1898,312 @@ static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 		vsc73xx_refresh_fwd_map(ds, port, state);
 }
 
+static u16 vsc73xx_calc_hash(const unsigned char *addr, u16 vid)
+{
+	/* VID 5-0, MAC 47-44 */
+	u16 hash = FIELD_PREP(VSC73XX_HASH0_VID_TO_MASK,
+			      FIELD_GET(VSC73XX_HASH0_VID_FROM_MASK, vid)) |
+		   FIELD_PREP(VSC73XX_HASH0_MAC0_TO_MASK,
+			      FIELD_GET(VSC73XX_HASH0_MAC0_FROM_MASK, addr[0]));
+	/* MAC 43-33 */
+	hash ^= FIELD_PREP(VSC73XX_HASH1_MAC0_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH1_MAC0_FROM_MASK, addr[0])) |
+		FIELD_PREP(VSC73XX_HASH1_MAC1_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH1_MAC1_FROM_MASK, addr[1]));
+	/* MAC 32-22 */
+	hash ^= FIELD_PREP(VSC73XX_HASH2_MAC1_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH2_MAC1_FROM_MASK, addr[1])) |
+		FIELD_PREP(VSC73XX_HASH2_MAC2_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH2_MAC2_FROM_MASK, addr[2])) |
+		FIELD_PREP(VSC73XX_HASH2_MAC3_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH2_MAC3_FROM_MASK, addr[3]));
+	/* MAC 21-11 */
+	hash ^= FIELD_PREP(VSC73XX_HASH3_MAC3_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH3_MAC3_FROM_MASK, addr[3])) |
+		FIELD_PREP(VSC73XX_HASH3_MAC4_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH3_MAC4_FROM_MASK, addr[4]));
+	/* MAC 10-0 */
+	hash ^= FIELD_PREP(VSC73XX_HASH4_MAC4_TO_MASK,
+			   FIELD_GET(VSC73XX_HASH4_MAC4_FROM_MASK, addr[4])) |
+		addr[5];
+
+	return hash;
+}
+
+static int
+vsc73xx_port_wait_for_mac_table_cmd(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 ||
+				((val & VSC73XX_MACACCESS_CMD_MASK) ==
+				 VSC73XX_MACACCESS_CMD_IDLE),
+				VSC73XX_POLL_SLEEP_US, VSC73XX_POLL_TIMEOUT_US,
+				false, vsc, VSC73XX_BLOCK_ANALYZER,
+				0, VSC73XX_MACACCESS, &val);
+	if (ret)
+		return ret;
+	return err;
+}
+
+static int vsc73xx_port_read_mac_table_row(struct vsc73xx *vsc, u16 index,
+					   struct vsc73xx_fdb *fdb)
+{
+	int ret, i;
+	u32 val;
+
+	if (!fdb)
+		return -EINVAL;
+	if (index >= VSC73XX_NUM_FDB_ROWS)
+		return -EINVAL;
+
+	for (i = 0; i < VSC73XX_NUM_BUCKETS; i++) {
+		ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_MACTINDX,
+				    (i ? 0 : VSC73XX_MACTINDX_SHADOW) |
+				    FIELD_PREP(VSC73XX_MACTINDX_BUCKET_MSK, i) |
+				    index);
+		if (ret)
+			return ret;
+
+		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+		if (ret)
+			return ret;
+
+		ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					  VSC73XX_MACACCESS,
+					  VSC73XX_MACACCESS_CMD_MASK,
+					  VSC73XX_MACACCESS_CMD_READ_ENTRY);
+		if (ret)
+			return ret;
+
+		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+		if (ret)
+			return ret;
+
+		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				   VSC73XX_MACACCESS, &val);
+		if (ret)
+			return ret;
+
+		fdb[i].valid = FIELD_GET(VSC73XX_MACACCESS_VALID, val);
+		if (!fdb[i].valid)
+			continue;
+
+		fdb[i].port = FIELD_GET(VSC73XX_MACACCESS_DEST_IDX_MASK, val);
+
+		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				   VSC73XX_MACHDATA, &val);
+		if (ret)
+			return ret;
+
+		fdb[i].vid = FIELD_GET(VSC73XX_MACHDATA_VID, val);
+		fdb[i].mac[0] = FIELD_GET(VSC73XX_MACHDATA_MAC0, val);
+		fdb[i].mac[1] = FIELD_GET(VSC73XX_MACHDATA_MAC1, val);
+
+		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				   VSC73XX_MACLDATA, &val);
+		if (ret)
+			return ret;
+
+		fdb[i].mac[2] = FIELD_GET(VSC73XX_MACLDATA_MAC2, val);
+		fdb[i].mac[3] = FIELD_GET(VSC73XX_MACLDATA_MAC3, val);
+		fdb[i].mac[4] = FIELD_GET(VSC73XX_MACLDATA_MAC4, val);
+		fdb[i].mac[5] = FIELD_GET(VSC73XX_MACLDATA_MAC5, val);
+	}
+
+	return ret;
+}
+
+static int
+vsc73xx_fdb_operation(struct vsc73xx *vsc, const unsigned char *addr, u16 vid,
+		      u16 hash, u16 cmd_mask, u16 cmd_val)
+{
+	int ret;
+	u32 val;
+
+	val = FIELD_PREP(VSC73XX_MACHDATA_VID, vid) |
+	      FIELD_PREP(VSC73XX_MACHDATA_MAC0, addr[0]) |
+	      FIELD_PREP(VSC73XX_MACHDATA_MAC1, addr[1]);
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACHDATA,
+			    val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(VSC73XX_MACLDATA_MAC2, addr[2]) |
+	      FIELD_PREP(VSC73XX_MACLDATA_MAC3, addr[3]) |
+	      FIELD_PREP(VSC73XX_MACLDATA_MAC4, addr[4]) |
+	      FIELD_PREP(VSC73XX_MACLDATA_MAC5, addr[5]);
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACLDATA,
+			    val);
+	if (ret)
+		return ret;
+
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX,
+			    hash);
+	if (ret)
+		return ret;
+
+	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+	if (ret)
+		return ret;
+
+	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				  VSC73XX_MACACCESS, cmd_mask, cmd_val);
+	if (ret)
+		return ret;
+
+	return vsc73xx_port_wait_for_mac_table_cmd(vsc);
+}
+
+static int vsc73xx_fdb_del_entry(struct vsc73xx *vsc, int port,
+				 const unsigned char *addr, u16 vid)
+{
+	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
+	u16 hash = vsc73xx_calc_hash(addr, vid);
+	int bucket, ret;
+
+	mutex_lock(&vsc->fdb_lock);
+
+	ret = vsc73xx_port_read_mac_table_row(vsc, hash, fdb);
+	if (ret)
+		goto err;
+
+	for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
+		if (fdb[bucket].valid && fdb[bucket].port == port &&
+		    ether_addr_equal(addr, fdb[bucket].mac))
+			break;
+	}
+
+	if (bucket == VSC73XX_NUM_BUCKETS) {
+		/* Can't find MAC in MAC table */
+		ret = -ENODATA;
+		goto err;
+	}
+
+	ret = vsc73xx_fdb_operation(vsc, addr, vid, hash,
+				    VSC73XX_MACACCESS_CMD_MASK,
+				    VSC73XX_MACACCESS_CMD_FORGET);
+err:
+	mutex_unlock(&vsc->fdb_lock);
+	return ret;
+}
+
+static int vsc73xx_fdb_add_entry(struct vsc73xx *vsc, int port,
+				 const unsigned char *addr, u16 vid)
+{
+	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
+	u16 hash = vsc73xx_calc_hash(addr, vid);
+	int bucket, ret;
+	u32 val;
+
+	mutex_lock(&vsc->fdb_lock);
+
+	ret = vsc73xx_port_read_mac_table_row(vsc, hash, fdb);
+	if (ret)
+		goto err;
+
+	for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
+		if (!fdb[bucket].valid)
+			break;
+	}
+
+	if (bucket == VSC73XX_NUM_BUCKETS) {
+		/* Bucket is full */
+		ret = -EOVERFLOW;
+		goto err;
+	}
+
+	val = VSC73XX_MACACCESS_VALID | VSC73XX_MACACCESS_LOCKED |
+	      FIELD_PREP(VSC73XX_MACACCESS_DEST_IDX_MASK, port) |
+	      VSC73XX_MACACCESS_CMD_LEARN;
+	ret = vsc73xx_fdb_operation(vsc, addr, vid, hash,
+				    VSC73XX_MACACCESS_VALID |
+				    VSC73XX_MACACCESS_LOCKED |
+				    VSC73XX_MACACCESS_DEST_IDX_MASK |
+				    VSC73XX_MACACCESS_CMD_MASK, val);
+err:
+	mutex_unlock(&vsc->fdb_lock);
+	return ret;
+}
+
+static int vsc73xx_fdb_add(struct dsa_switch *ds, int port,
+			   const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct vsc73xx *vsc = ds->priv;
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
+	return vsc73xx_fdb_add_entry(vsc, port, addr, vid);
+}
+
+static int vsc73xx_fdb_del(struct dsa_switch *ds, int port,
+			   const unsigned char *addr, u16 vid, struct dsa_db db)
+{
+	struct vsc73xx *vsc = ds->priv;
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
+	return vsc73xx_fdb_del_entry(vsc, port, addr, vid);
+}
+
+static int vsc73xx_port_fdb_dump(struct dsa_switch *ds,
+				 int port, dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
+	struct vsc73xx *vsc = ds->priv;
+	u16 i, bucket;
+	int err = 0;
+
+	mutex_lock(&vsc->fdb_lock);
+
+	for (i = 0; i < VSC73XX_NUM_FDB_ROWS; i++) {
+		err = vsc73xx_port_read_mac_table_row(vsc, i, fdb);
+		if (err)
+			goto unlock;
+
+		for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
+			if (!fdb[bucket].valid || fdb[bucket].port != port)
+				continue;
+
+			/* We need to hide dsa_8021q VLANs from the user */
+			if (vid_is_dsa_8021q(fdb[bucket].vid))
+				fdb[bucket].vid = 0;
+
+			err = cb(fdb[bucket].mac, fdb[bucket].vid, false, data);
+			if (err)
+				goto unlock;
+		}
+	}
+unlock:
+	mutex_unlock(&vsc->fdb_lock);
+	return err;
+}
+
 static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 	.mac_config = vsc73xx_mac_config,
 	.mac_link_down = vsc73xx_mac_link_down,
@@ -1876,6 +2226,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_bridge_join = dsa_tag_8021q_bridge_join,
 	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
+	.port_fdb_add = vsc73xx_fdb_add,
+	.port_fdb_del = vsc73xx_fdb_del,
+	.port_fdb_dump = vsc73xx_port_fdb_dump,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
 	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
@@ -2006,6 +2359,8 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		return -ENODEV;
 	}
 
+	mutex_init(&vsc->fdb_lock);
+
 	eth_random_addr(vsc->addr);
 	dev_info(vsc->dev,
 		 "MAC for control frames: %02X:%02X:%02X:%02X:%02X:%02X\n",
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 3ca579acc798..3c30e143c14f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -45,6 +45,7 @@ struct vsc73xx_portinfo {
  * @vlans: List of configured vlans. Contains port mask and untagged status of
  *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
  *	vlans.
+ * @fdb_lock: Mutex protects fdb access
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -57,6 +58,7 @@ struct vsc73xx {
 	void				*priv;
 	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
 	struct list_head		vlans;
+	struct mutex			fdb_lock;
 };
 
 /**
-- 
2.34.1


