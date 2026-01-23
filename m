Return-Path: <netdev+bounces-252828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCSgG31jc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:03:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F375846
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99B53033209
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E933A712;
	Fri, 23 Jan 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxq4dokT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF02314B91
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169694; cv=none; b=fh46eZ+GpIPxcXKUzRd9HV76iCU+b+YLmhVcri1DS08rkgpRpre7LGU664eTbXZQM/vTnIUJhENZiVVu6mdCkVHxRfVylnn/M7MKNyJyqpilemhyRelGXgncBEHIlYujUITh58VJ+ohR8xmQFeXoIOGXWYGo+6vPHpmFZ2wGRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169694; c=relaxed/simple;
	bh=lfX/aQXgXu8N99a9UbOqMgD2maNs9TaUPsD2bCWDZ58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfgmxHANtI1+vHVMsfQXcveFDh9dTm2VgCSDmYEUqlwT6eH3XM3pEpX5Otb4WwLl1pbmTTk0jRrlqS7/JvF5dgJDeKMleMV/oRqM4m2xAuG/bwMXuXcWCexJ+wbZEhbKNN8e649RclCAG0sOKCBvlRQ/VYiJCIxQvSNpY3jGVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xxq4dokT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so24431335e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 04:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169691; x=1769774491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCpcCt671zec/WYYqXDWL85shhNDDHyWCrlnv8/D0oo=;
        b=Xxq4dokTUMTkkOJrrbo2gdebJv2Bew8zzzSwkczajjjoVG5MxytlBBYLwxX0aNN/4o
         USD5BF4qy1bvnwK+nsgvHe4mfbpQZQCkyNW2pKPx0UuMCiFjaSnQzyu/d0JV8+CrlKwa
         ttweS9pFUwXdg0UerAh+E2QD1jvQRARQuZ+Es9o+p8w5W42g4w1iJqStxbWLG7GP8f9Z
         D5p7XBREa01a1IvL/sfbogOMyAq5JS0eUnpAAvTQBwSl9SfiI0o8gt7HsHnif5PxS4EU
         NQ3ca2PdJ28WTHjXPfRmXyqYhv1kMDdi42KAzmG1up01FGZiyD0Y1N90hh/YzQ/hMtvY
         jkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169691; x=1769774491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QCpcCt671zec/WYYqXDWL85shhNDDHyWCrlnv8/D0oo=;
        b=o6Y+ZsEtkdVA4AdlnmtxCrRrKU5RnVFkFAoFQ85vq//8UvNV2eF746KWR2c/zoXT+T
         0cdM10BYaFcF30tiIzbECC2+1WJMFQeopid9pPdZP/NjAA3HyCawHxElteo6/BGXPTTd
         efO7P1f9h18kD4V323oy3evtp9Lg9DmyvfpAFIjsmvBSxbiIMFZe1i2mFejmcB3K17+H
         u5xPjVhNohGziCgew/9fa3/NhThs/sbhefaZ7nw8SCBrxtZEUfpbyaietDLdD0cfg9LP
         Sze5TVP69kcpZQSA+ASddy1nlTzHoReABERudxUZCqhd2V/K/XHxddP0EikVFkkGmFPp
         k4qA==
X-Forwarded-Encrypted: i=1; AJvYcCVXx602YA6CcpbBLo/K/1KrkC9PHxc5r1gvQCvWJUKlN9N8g1cgZ/tmxkDYLJfbHuzGUFs5vPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZPx44Y7r74gmbjokZTYx88i5Hb3wESI1qRj3w77sRDSeTKU+
	HOHW+zPGs34G9m/4ka/HwWCtAyg2bdIjMSRejCD9jbIFyEMIbQZlwxd1
X-Gm-Gg: AZuq6aKe4cuke6Ip8yIKSfU7kuW9JHeBANxHoKPPqglBc2JQkz4ezIPS3NS+nD062s8
	R62OeBsUq+E8KX/32Th22oexuSHcZg62g/qYIW+zHtpE1TxSGHlYxchuoT4H8StY20ABi2dLrWg
	RvbTAiUNcK2aHcW2NBE6h//hHGFGKUwH0Ni3knXpab4SMSMyDHv8nZD/9lt89PQHcj1+qa7e839
	UDQ/Bu/VTnccUk784If4TlIGMJIDidsxD27lWwuDDeGyEoyqd2LjpXUsxPXWWQmy10YflKF/mKy
	VoONlE2bRKRdJMiCdHT43lVRPprBn6FNQ5uttWos0+s9r0fnFj97QB/dXgieTgte6mlXHWPZChv
	gtmM3i0jZmJZqtJu3S6aH4jy2jWXUXFCAcEPRcxdOUwjBD9LxD5gd7U9NSfLWhtpNPDDomNHgdF
	VfdKT02Vy+SZsn/eF9RofVHk1UmPYkjYh7Rv00B0nd
X-Received: by 2002:a05:600c:a08e:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4804c9b4afcmr43459265e9.20.1769169688437;
        Fri, 23 Jan 2026 04:01:28 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4804d603ac9sm21575135e9.4.2026.01.23.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:01:28 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 2/3] net: phy: as21xxx: add support for DBG command
Date: Fri, 23 Jan 2026 13:00:30 +0100
Message-ID: <20260123120117.10883-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123120117.10883-1-ansuelsmth@gmail.com>
References: <20260123120117.10883-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252828-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D60F375846
X-Rspamd-Action: no action

Rework the msg send logic to support sending DBG command.

These DBG command use a special way to send and receive data and use
data in u8 size and are used to tweak advanced (and later introduced)
feature of the PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 190 +++++++++++++++++++++++++++++++-------
 1 file changed, 155 insertions(+), 35 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index a5344abde91a..2098fa6a2f63 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -59,6 +59,10 @@
 #define IPC_CMD_SYS_CPU			0x2  /* SYS_CPU */
 #define IPC_CMD_BULK_DATA		0xa  /* Pass bulk data in ipc registers. */
 #define IPC_CMD_BULK_WRITE		0xc  /* Write bulk data to memory */
+#define IPC_CMD_DBG			0x16
+#define IPC_CMD_POLL			0x17
+#define IPC_CMD_WRITE_BUF		0x18
+#define IPC_CMD_READ_BUF		0x19
 #define IPC_CMD_CFG_PARAM		0x1a /* Write config parameters to memory */
 #define IPC_CMD_NG_TESTMODE		0x1b /* Set NG test mode and tone */
 #define IPC_CMD_TEMP_MON		0x15 /* Temperature monitoring function */
@@ -115,6 +119,12 @@
 /* Sub command of CMD_TEMP_MON */
 #define IPC_CMD_TEMP_MON_GET		0x4
 
+/* Sub command of CMD_DBG */
+#define IPC_DBG_DPC			0x8b
+
+#define IPC_DATA_DBG_SEC		GENMASK(15, 8)
+#define IPC_DATA_DBG_CMD		GENMASK(7, 0)
+
 #define AS21XXX_MDIO_AN_C22		0xffe0
 
 #define PHY_ID_AS21XXX			0x75009410
@@ -451,18 +461,9 @@ static int aeon_ipc_send_cmd(struct phy_device *phydev,
 	return 0;
 }
 
-/* If data is NULL, return 0 or negative error.
- * If data not NULL, return number of Bytes received from IPC or
- * a negative error.
- */
-static int aeon_ipc_send_msg(struct phy_device *phydev,
-			     u16 opcode, u16 *data, unsigned int data_len,
-			     u16 *ret_data)
+static int aeon_ipc_set_msg_data(struct phy_device *phydev, u16 *data,
+				 unsigned int data_len)
 {
-	struct as21xxx_priv *priv = phydev->priv;
-	unsigned int ret_size;
-	u16 cmd, ret_sts;
-	int ret;
 	int i;
 
 	/* IPC have a max of 8 register to transfer data,
@@ -475,46 +476,69 @@ static int aeon_ipc_send_msg(struct phy_device *phydev,
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i),
 			      data[i]);
 
-	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
-	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
-
-	mutex_lock(&priv->ipc_lock);
-
-	ret = aeon_ipc_send_cmd(phydev, priv, cmd, &ret_sts);
-	if (ret) {
-		phydev_err(phydev, "failed to send ipc msg for %x: %d\n",
-			   opcode, ret);
-		goto out;
-	}
-
-	if (!data)
-		goto out;
+	return 0;
+}
 
-	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR) {
-		ret = -EINVAL;
-		goto out;
-	}
+static int
+aeon_ipc_get_msg_ret_data(struct phy_device *phydev, u16 ret_sts,
+			  u16 *ret_data) __must_hold(&priv->ipc_lock)
+{
+	unsigned int ret_size;
+	int ret;
+	int i;
 
 	/* Prevent IPC from stack smashing the kernel.
 	 * We can't trust IPC to return a good value and we always
 	 * preallocate space for 16 Bytes.
 	 */
 	ret_size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
-	if (ret_size > AEON_IPC_DATA_MAX) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (ret_size > AEON_IPC_DATA_MAX)
+		return -EINVAL;
 
 	/* Read data from IPC data register for ret_size value from IPC */
 	for (i = 0; i < DIV_ROUND_UP(ret_size, sizeof(u16)); i++) {
 		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		ret_data[i] = ret;
 	}
 
-	ret = ret_size;
+	return ret_size;
+}
+
+/* If data is NULL, return 0 or negative error.
+ * If data not NULL, return number of Bytes received from IPC or
+ * a negative error.
+ */
+static int aeon_ipc_send_msg(struct phy_device *phydev,
+			     u16 opcode, u16 *data, unsigned int data_len,
+			     u16 *ret_data)
+{
+	struct as21xxx_priv *priv = phydev->priv;
+	u16 cmd, ret_sts;
+	int ret;
+
+	ret = aeon_ipc_set_msg_data(phydev, data, data_len);
+	if (ret)
+		return ret;
+
+	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
+	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
+
+	mutex_lock(&priv->ipc_lock);
+
+	ret = aeon_ipc_send_cmd(phydev, priv, cmd, &ret_sts);
+	if (ret) {
+		phydev_err(phydev, "failed to send ipc msg for %x: %d\n",
+			   opcode, ret);
+		goto out;
+	}
+
+	if (!data)
+		goto out;
+
+	ret = aeon_ipc_get_msg_ret_data(phydev, ret_sts, ret_data);
 
 out:
 	mutex_unlock(&priv->ipc_lock);
@@ -604,6 +628,102 @@ static int aeon_ipc_get_fw_version(struct phy_device *phydev)
 	return 0;
 }
 
+static int aeon_ipc_poll(struct phy_device *phydev)
+{
+	struct as21xxx_priv *priv = phydev->priv;
+	u16 ret_sts;
+	u16 cmd;
+	int ret;
+
+	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, 0) |
+	      FIELD_PREP(AEON_IPC_CMD_OPCODE, IPC_CMD_POLL);
+
+	mutex_lock(&priv->ipc_lock);
+
+	ret = aeon_ipc_send_cmd(phydev, phydev->priv, cmd, &ret_sts);
+	if (ret)
+		phydev_err(phydev, "Invalid IPC status on IPC poll: %x\n",
+			   ret_sts);
+
+	mutex_unlock(&priv->ipc_lock);
+
+	return ret;
+}
+
+static int aeon_ipc_dbg_cmd(struct phy_device *phydev, u16 dbg_sec,
+			    u16 dbg_cmd, u16 msg_size)
+{
+	u16 data[3];
+
+	data[0] = FIELD_PREP(IPC_DATA_DBG_SEC, dbg_sec) |
+		  FIELD_PREP(IPC_DATA_DBG_CMD, dbg_cmd);
+	data[1] = msg_size;
+
+	return aeon_ipc_send_msg(phydev, IPC_CMD_DBG, data,
+				 sizeof(data), NULL);
+}
+
+static int aeon_ipc_dbg_read_buf(struct phy_device *phydev, u16 *buf)
+{
+	struct as21xxx_priv *priv = phydev->priv;
+	u16 cmd, ret_sts;
+	int ret;
+
+	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, 0) |
+	      FIELD_PREP(AEON_IPC_CMD_OPCODE, IPC_CMD_READ_BUF);
+
+	mutex_lock(&priv->ipc_lock);
+
+	ret = aeon_ipc_send_cmd(phydev, phydev->priv, cmd, &ret_sts);
+	if (ret)
+		goto out;
+
+	ret = aeon_ipc_get_msg_ret_data(phydev, ret_sts, buf);
+
+out:
+	mutex_unlock(&priv->ipc_lock);
+
+	return ret;
+}
+
+static int aeon_ipc_dbg_write_buf(struct phy_device *phydev, u8 *data,
+				  u8 data_len)
+{
+	u16 msg_data[AEON_IPC_DATA_NUM_REGISTERS];
+	struct as21xxx_priv *priv = phydev->priv;
+	u16 cmd, ret_sts;
+	int ret;
+	int i;
+
+	/* Make sure we don't try to write more data than supported */
+	if (data_len * 2 > AEON_IPC_DATA_MAX)
+		return -EINVAL;
+
+	/* Pack u8 DBG data in u16 buffer */
+	for (i = 0; i < data_len; i += 2) {
+		msg_data[i] = data[i];
+		msg_data[i] |= data[i + 1] << 8;
+	}
+
+	ret = aeon_ipc_set_msg_data(phydev, msg_data, data_len * 2);
+	if (ret)
+		return ret;
+
+	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
+	      FIELD_PREP(AEON_IPC_CMD_OPCODE, IPC_CMD_WRITE_BUF);
+
+	mutex_lock(&priv->ipc_lock);
+
+	ret = aeon_ipc_send_cmd(phydev, priv, cmd, &ret_sts);
+	if (ret)
+		phydev_err(phydev, "failed to send IPC msg for %x: %d\n",
+			   IPC_CMD_WRITE_BUF, ret);
+
+	mutex_unlock(&priv->ipc_lock);
+
+	return ret;
+}
+
 static int aeon_dpc_ra_enable(struct phy_device *phydev)
 {
 	u16 data[2];
-- 
2.51.0


