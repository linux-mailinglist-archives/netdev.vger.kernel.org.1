Return-Path: <netdev+bounces-117529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CF694E2D5
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 21:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681431F211F1
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597E1581E2;
	Sun, 11 Aug 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGbeszJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275914B95B;
	Sun, 11 Aug 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723406249; cv=none; b=sFZLyeiMjNhqdryWZHScmeRhOUaPN99uMWchjUD49ImickhVpc836Yop+V87YpaADOMgkeWep7Rt+9bHe4A9wcpJyH9uCcm1rdhFo+2iFuWcvgXAiq8ER2xGLK3mGMggrDyRZQQl7IPFWm1oHn9P9vO+Kwrfz1vmVnfRbt2kSTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723406249; c=relaxed/simple;
	bh=o34MXk9Ae0cxEHH5RTH7U6By+nTAU+RwokKL/MaH3s0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DpiN6vORnqTCAZadTNMC3n1lNdu0N6urt958rGgV3qjUi1PTn5o86JgjmxURittiSP8ET/P90duEBFK7D/mZcSyMJWp3eJCMiTPEmj4FQ6C9MeczUjTOQiBDXLdi7YNgu3B2jcfviX/qeOYgfmSjrj3wJObGjSftGnjJsSNl3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGbeszJ6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ef95ec938so3648779e87.3;
        Sun, 11 Aug 2024 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723406246; x=1724011046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+u/LkSsXMPd+naif3Saq+zqxF4qBn/RNIKVe/GBe0E=;
        b=HGbeszJ6BqjkTrUBGqQkJSorTSU5LpNpmytWQthU3eZLZgDTctW2MJqbh1Maf99m6v
         cyp2S+WB4eXoVhGrqNvwc4OnIbKNy0pU/E+6Jo4oVtqWfWV+yt07s8MB57U5DALt3cJS
         w9NGdioBdkqQG1FbXxc+2QeNsr4Hl/ZdjUW1CM5SM9Nlq32jBvd8JQjm6sr0YmYfUvNC
         FsgyvUCQoekEt4ju1vIcI4WmEZEtN+WL14c46ea9M27VqMuPtnKKcc1S0gvIQbzN7Zgd
         LDqwz0QBlI3jACux36jNUTnFZoFthYPsQmxnhncQsTh8cKR+/K1Hn04T0dcHzVAPG0Vx
         Ojdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723406246; x=1724011046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+u/LkSsXMPd+naif3Saq+zqxF4qBn/RNIKVe/GBe0E=;
        b=IMQb49ygKI6C+SvlcZf4g7ObMHBu4jR7ENrVNtyUgkKwKOkQk3B6SHd9EID8Jnvujj
         3J2FQtM+FxvS0DwlivC1sgntjL2gc2ulzpKtJkAMlHT7sJXJDIsOVWQG+TRAXOiLj0or
         MYpCGtvZzcXoJBKgqId02IKBIR3s9ZLjCzpToWuDFZXgqAuIqi2iZWoOS20cBvjVJcJ1
         8OA/2KDSNabWBx/Y9khgc+/Bo9id28lXxApaTU21iXWt47bBEvJJRHsCP5COeHisY3Y2
         Ie+GWeE8d1mXttCS6OVWRMHT8VzdvgSLpVSmJYVkD2IXDuYmZW9zPq9ngF1HnjexoHEH
         bdUA==
X-Forwarded-Encrypted: i=1; AJvYcCVBDobMGH81JNlKPyRgdcioPiXf5O+6vo03QFk21Kexf8VkFMGIaDmnWUDeNsWeHH6CrwiVFqmThf3WnnGfWh7d5p+YeDw4OG+oSw3C
X-Gm-Message-State: AOJu0YxT7btiFFFAZPopos/cnaSkzrUSJkL6Rc21NNiLrxOc2qfvKZmd
	0PJKsu0LWlfmb683DtsQ43scsrwHJfl5t21M4ZeNIiqAimxIARbPjYfcQAVR
X-Google-Smtp-Source: AGHT+IGmIB7GIfbX0M7SYL3M3JX7EzWm1pCVVEl3i0nDe7T5iMj7ZBIVLESEAlGFGRKRbSs8qQFxLw==
X-Received: by 2002:a05:6512:39cd:b0:52c:8a37:6cf4 with SMTP id 2adb3069b0e04-530ee9741e0mr5163529e87.14.1723406245349;
        Sun, 11 Aug 2024 12:57:25 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:95a:8e8a:ba04:86f8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f1b514sm550558e87.222.2024.08.11.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 12:57:24 -0700 (PDT)
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
Subject: [PATCH net-next] net: dsa: vsc73xx: implement FDB operations
Date: Sun, 11 Aug 2024 21:56:49 +0200
Message-Id: <20240811195649.2360966-1-paweldembicki@gmail.com>
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
exactly into row[hash]. The chip selects the row number by itself.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 302 +++++++++++++++++++++++++
 drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
 2 files changed, 304 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index a82b550a9e40..7da1641b8bab 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -46,6 +46,8 @@
 #define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
 
 #define CPU_PORT	6 /* CPU port */
+#define VSC73XX_NUM_FDB_RECORDS	2048
+#define VSC73XX_NUM_BUCKETS	4
 
 /* MAC Block registers */
 #define VSC73XX_MAC_CFG		0x00
@@ -197,6 +199,21 @@
 #define VSC73XX_SRCMASKS_MIRROR			BIT(26)
 #define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
 
+#define VSC73XX_MACHDATA_VID			GENMASK(27, 16)
+#define VSC73XX_MACHDATA_VID_SHIFT		16
+#define VSC73XX_MACHDATA_MAC0_SHIFT		8
+#define VSC73XX_MACHDATA_MAC1_SHIFT		0
+#define VSC73XX_MACLDATA_MAC2_SHIFT		24
+#define VSC73XX_MACLDATA_MAC3_SHIFT		16
+#define VSC73XX_MACLDATA_MAC4_SHIFT		8
+#define VSC73XX_MACLDATA_MAC5_SHIFT		0
+#define VSC73XX_MAC_BYTE_MASK			GENMASK(7, 0)
+
+#define VSC73XX_MACTINDX_SHADOW			BIT(13)
+#define VSC73XX_MACTINDX_BUCKET_MASK		GENMASK(12, 11)
+#define VSC73XX_MACTINDX_BUCKET_MASK_SHIFT	11
+#define VSC73XX_MACTINDX_INDEX_MASK		GENMASK(10, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -204,6 +221,7 @@
 #define VSC73XX_MACACCESS_VALID			BIT(10)
 #define VSC73XX_MACACCESS_LOCKED		BIT(9)
 #define VSC73XX_MACACCESS_DEST_IDX_MASK		GENMASK(8, 3)
+#define VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT	3
 #define VSC73XX_MACACCESS_CMD_MASK		GENMASK(2, 0)
 #define VSC73XX_MACACCESS_CMD_IDLE		0
 #define VSC73XX_MACACCESS_CMD_LEARN		1
@@ -329,6 +347,13 @@ struct vsc73xx_counter {
 	const char *name;
 };
 
+struct vsc73xx_fdb {
+	u16 vid;
+	u8 port;
+	u8 mac[6];
+	bool valid;
+};
+
 /* Counters are named according to the MIB standards where applicable.
  * Some counters are custom, non-standard. The standard counters are
  * named in accordance with RFC2819, RFC2021 and IEEE Std 802.3-2002 Annex
@@ -1829,6 +1854,278 @@ static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 		vsc73xx_refresh_fwd_map(ds, port, state);
 }
 
+static u16 vsc73xx_calc_hash(const unsigned char *addr, u16 vid)
+{
+	/* VID 5-0, MAC 47-44 */
+	u16 hash = ((vid & GENMASK(5, 0)) << 4) | (addr[0] >> 4);
+
+	/* MAC 43-33 */
+	hash ^= ((addr[0] & GENMASK(3, 0)) << 7) | (addr[1] >> 1);
+	/* MAC 32-22 */
+	hash ^= ((addr[1] & BIT(0)) << 10) | (addr[2] << 2) | (addr[3] >> 6);
+	/* MAC 21-11 */
+	hash ^= ((addr[3] & GENMASK(5, 0)) << 5) | (addr[4] >> 3);
+	/* MAC 10-0 */
+	hash ^= ((addr[4] & GENMASK(2, 0)) << 8) | addr[5];
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
+static int vsc73xx_port_read_mac_table_entry(struct vsc73xx *vsc, u16 index,
+					     struct vsc73xx_fdb *fdb)
+{
+	int ret, i;
+	u32 val;
+
+	if (!fdb)
+		return -EINVAL;
+	if (index >= VSC73XX_NUM_FDB_RECORDS)
+		return -EINVAL;
+
+	for (i = 0; i < VSC73XX_NUM_BUCKETS; i++) {
+		vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX,
+			      (i ? 0 : VSC73XX_MACTINDX_SHADOW) |
+			      i << VSC73XX_MACTINDX_BUCKET_MASK_SHIFT |
+			      index);
+		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+		if (ret)
+			return ret;
+
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_MACACCESS,
+				    VSC73XX_MACACCESS_CMD_MASK,
+				    VSC73XX_MACACCESS_CMD_READ_ENTRY);
+		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+		if (ret)
+			return ret;
+
+		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACACCESS,
+			     &val);
+		fdb[i].valid = val & VSC73XX_MACACCESS_VALID;
+		if (!fdb[i].valid)
+			continue;
+
+		fdb[i].port = (val & VSC73XX_MACACCESS_DEST_IDX_MASK) >>
+			      VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT;
+
+		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACHDATA,
+			     &val);
+		fdb[i].vid = (val & VSC73XX_MACHDATA_VID) >>
+			     VSC73XX_MACHDATA_VID_SHIFT;
+		fdb[i].mac[0] = (val >> VSC73XX_MACHDATA_MAC0_SHIFT) &
+				VSC73XX_MAC_BYTE_MASK;
+		fdb[i].mac[1] = (val >> VSC73XX_MACHDATA_MAC1_SHIFT) &
+				VSC73XX_MAC_BYTE_MASK;
+
+		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACLDATA,
+			     &val);
+		fdb[i].mac[2] = (val >> VSC73XX_MACLDATA_MAC2_SHIFT) &
+				VSC73XX_MAC_BYTE_MASK;
+		fdb[i].mac[3] = (val >> VSC73XX_MACLDATA_MAC3_SHIFT) &
+				VSC73XX_MAC_BYTE_MASK;
+		fdb[i].mac[4] = (val >> VSC73XX_MACLDATA_MAC4_SHIFT) &
+				VSC73XX_MAC_BYTE_MASK;
+		fdb[i].mac[5] = (val >> VSC73XX_MACLDATA_MAC5_SHIFT) &
+				VSC73XX_MAC_BYTE_MASK;
+	}
+
+	return ret;
+}
+
+static void
+vsc73xx_fdb_insert_mac(struct vsc73xx *vsc, const unsigned char *addr, u16 vid)
+{
+	u32 val;
+
+	val = (vid << VSC73XX_MACHDATA_VID_SHIFT) & VSC73XX_MACHDATA_VID;
+	val |= (addr[0] << VSC73XX_MACHDATA_MAC0_SHIFT);
+	val |= (addr[1] << VSC73XX_MACHDATA_MAC1_SHIFT);
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACHDATA, val);
+
+	val = (addr[2] << VSC73XX_MACLDATA_MAC2_SHIFT);
+	val |= (addr[3] << VSC73XX_MACLDATA_MAC3_SHIFT);
+	val |= (addr[4] << VSC73XX_MACLDATA_MAC4_SHIFT);
+	val |= (addr[5] << VSC73XX_MACLDATA_MAC5_SHIFT);
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACLDATA, val);
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
+	ret = vsc73xx_port_read_mac_table_entry(vsc, hash, fdb);
+	if (ret)
+		goto err;
+
+	for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
+		if (fdb[bucket].valid && fdb[bucket].port == port &&
+		    !memcmp(addr, fdb[bucket].mac, ETH_ALEN))
+			break;
+	}
+
+	if (bucket == VSC73XX_NUM_BUCKETS) {
+		/* Can't find MAC in MAC table */
+		ret = -ENODATA;
+		goto err;
+	}
+
+	vsc73xx_fdb_insert_mac(vsc, addr, vid);
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX, hash);
+
+	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+	if (ret)
+		goto err;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACACCESS,
+			    VSC73XX_MACACCESS_CMD_MASK,
+			    VSC73XX_MACACCESS_CMD_FORGET);
+	ret =  vsc73xx_port_wait_for_mac_table_cmd(vsc);
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
+	vsc73xx_port_read_mac_table_entry(vsc, hash, fdb);
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
+	vsc73xx_fdb_insert_mac(vsc, addr, vid);
+
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX, hash);
+	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+	if (ret)
+		goto err;
+
+	val = (port << VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT) &
+	      VSC73XX_MACACCESS_DEST_IDX_MASK;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_MACACCESS,
+			    VSC73XX_MACACCESS_VALID |
+			    VSC73XX_MACACCESS_CMD_MASK |
+			    VSC73XX_MACACCESS_DEST_IDX_MASK |
+			    VSC73XX_MACACCESS_LOCKED,
+			    VSC73XX_MACACCESS_VALID |
+			    VSC73XX_MACACCESS_CMD_LEARN |
+			    VSC73XX_MACACCESS_LOCKED | val);
+	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
+
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
+
+	mutex_lock(&vsc->fdb_lock);
+
+	for (i = 0; i < VSC73XX_NUM_FDB_RECORDS; i++) {
+		vsc73xx_port_read_mac_table_entry(vsc, i, fdb);
+
+		for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
+			if (!fdb[bucket].valid || fdb[bucket].port != port)
+				continue;
+
+			/* We need to hide dsa_8021q VLANs from the user */
+			if (vid_is_dsa_8021q(fdb[bucket].vid))
+				fdb[bucket].vid = 0;
+			cb(fdb[bucket].mac, fdb[bucket].vid, false, data);
+		}
+	}
+
+	mutex_unlock(&vsc->fdb_lock);
+	return 0;
+}
+
 static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 	.mac_config = vsc73xx_mac_config,
 	.mac_link_down = vsc73xx_mac_link_down,
@@ -1851,6 +2148,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_bridge_join = dsa_tag_8021q_bridge_join,
 	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
+	.port_fdb_add = vsc73xx_fdb_add,
+	.port_fdb_del = vsc73xx_fdb_del,
+	.port_fdb_dump = vsc73xx_port_fdb_dump,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
 	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
@@ -1981,6 +2281,8 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		return -ENODEV;
 	}
 
+	mutex_init(&vsc->fdb_lock);
+
 	eth_random_addr(vsc->addr);
 	dev_info(vsc->dev,
 		 "MAC for control frames: %02X:%02X:%02X:%02X:%02X:%02X\n",
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 3ca579acc798..a36ca607671e 100644
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
+	struct mutex			fdb_lock; /* protects fdb access */
 };
 
 /**
-- 
2.34.1


