Return-Path: <netdev+bounces-292006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJnNDRo3FmrrjAcAu9opvQ
	(envelope-from <netdev+bounces-292006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:13:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6D5DDE60
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D5313008537
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068FD275848;
	Wed, 27 May 2026 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys8ZyJbS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C8264FBD
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840622; cv=none; b=gPSXoN3gqsahNvnaFJFQJJ+EO/v9oQj+p3WCLSFp7K3vlUu4KGdDPaI6eGuMb5OZgJJOj9d3ZxwF2UYufUyH5Vlt1GLCIdVt/26WN8eA9StNErK5fAMw4qD0nMr/5tu66erh2mPEU19Fy+FFylXs63JF5jLBWVeZDbBcFzWGT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840622; c=relaxed/simple;
	bh=kkexjfuDEOhCFUCRgLGTgSVk9KgDIyMcTiVdHsCmqCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtGfwkEBvr72KfQAE+OXej4pAT0Ne7f2kGTgVbg8eFYVMjQWWJ7zeSdtlzIEz+4ntI+au8gNRivVR1xJ8tZKmA8Ija0VEqd9k6Yua0ck+6L6njWfGKBk7DV20VIf8P9BnUov3A/krdg+bjmSVUPWKkya42mab+AQY11TSOoKUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys8ZyJbS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-914bf8abeaeso359551585a.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779840603; x=1780445403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIiexEOWDq/OlniiyY/LCqW6TR00GCk+g5J6MGZnhD8=;
        b=Ys8ZyJbSEaUGil4Pc7VdqbUG0D1vPABCRrEM6/pU74CDKtGDjmfvTuT0J9S9T6sYu5
         gc7MKa+HiihpY/ddwdmu5bHJifIqeSdrlEM5+zIUyYDasKh226injhM2KQFbTNbMGGWv
         ETH4FkICWFNgNCYjdbdGsK1jyOZEFsgqqKI4a+j3d0UUVSs/zG/xHJETqsM4HpEM80WB
         AJY7e03ABdJzkcu0I/lUfQaIYoC7W+JhYHSNfZtW2dG4SjATwE8zOUGrgfzvs4nZaU+/
         zOkvroMRlbbOxoEsaqI0IXKmEoJyCQ0zNFZzWCUHT3x6/VU0AC/iZlQ6eAOsQIp6btTh
         38AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779840603; x=1780445403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIiexEOWDq/OlniiyY/LCqW6TR00GCk+g5J6MGZnhD8=;
        b=pSxU3YN/Oa+BRtfaGfWlZvR28vgY4DFYDEYjsAsAJsWzOKWydnGYqjGclV1L3YTK4M
         70+wrkSmUSdSHFArmZjo7VLYZh0Yk37rz5gPSHaNdi/2M+9e+3GBSKGydEOKsws8HUrB
         pE8JIs6jazWsuAOQhf7vZLI1ljElTt7wEZgDEs622JW4F3cAqyoiXCmIptKGOLEB7imc
         rUJ6RRn17zl0hY/CCH8seyQRA1QJJUSqVja9PQbRT7RmYSNchmqjeNVntLbMIS63IVLo
         TDb5tdNfNVB4LMZubRoDU7f9OxPcczDjKmdzLYmB50V+lamBn7APgReC+yT1KWUujHto
         CKaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/96BixXWJFKUnxjWds8anHYA074wWwF5h/zG+H1RiNzj9RlnnQJuLcuI4PI92tJbjzKMbIdRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIEEEYN9QgZhyVWZ0dR/lKbuQVR6g+M4m0XGmskgTXwjFnG1P
	cPQuUh3XRhUuNsUmK3MxsxmG2EVWVNaPme/tFdZK6bKtCyux/7xZLm7W
X-Gm-Gg: Acq92OGbT+tVHYCz/bSG+JtiZ+0xTAPZPDuSsaQ3RW5fB7s76IcXm5Bc6t2riMZ4WFN
	JDVKTNmaFEAsLntGriakQqC1vT5NA+QRXaEZUjkXn42Ask0XMmZELlIuQvWW7i5tTt40VrtqfQw
	vl86MOvthR+rVRUDvHgA7ZNFnFc90ZsRY+vFF68T2IMSOceqE2e5pRfT50ADB7ZnU3lCcLvnSuZ
	1w+Qj9y1VQGxwV2V+jKFAuYB1u7ds/cnyrBhzzkuRDSO2DU8Wyg2rC/QJcfyp/Yn/YCJac/8JHW
	4JVHgFeg+7qi43R+yGSt5h6bi8ZR89wmNGLtcmKGPF4mb75bCeM5eaYz06KD4TJWOARAEmzZ5/+
	LlD6/09Udxv34IGksMb/qsmgJNNfzm9HVw/WNLpK7m9oB4We0OEZGYT/d8vFMV6z/U6huDrVwyG
	Tb1ohWyzTu//I1Pg6pyNQZbnHQJAT4e4ctOKTgl3bgAjf3uGJfw6mG/I6CuKeVpDVVUaqKe9wir
	nm3wQ==
X-Received: by 2002:a05:620a:2242:10b0:914:babf:9f59 with SMTP id af79cd13be357-914babfc9a7mr1925958285a.34.1779840603239;
        Tue, 26 May 2026 17:10:03 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87fc449sm363803585a.35.2026.05.26.17.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 17:10:02 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/4] net: pcs: xpcs: Allow for multiple addr in creation
Date: Tue, 26 May 2026 20:09:56 -0400
Message-ID: <20260527000958.81108-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
References: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292006-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,trustnetic.com,net-swift.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: A8F6D5DDE60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The DW channel 10g-100g IP builds the PCS out of multiple addr
mdio addresses.

Add xpcs_create_mdiodevs() and xpcs_create_pcs_mdiodevs calls so that a
driver using the above part can tell xpcs the addr values in one call.

xpcs_create_data(), xpcs_create(), and xpcs_free_data() are extended
to accept a variable number of mdio devices.  Existing singleton
interfaces are re-cast as a having an array pointing to a single
mdio device.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - New to series
  - use new call to xpcs_create_pcs_mdiodevs() in fbnic
  - Add xpcs_mdev_write_ch()
  - Add doc comments for xpcs_create_mdiodevs()

v2.2:
  - New to series

 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |   4 +-
 drivers/net/pcs/pcs-xpcs.c                    | 103 +++++++++++++++---
 drivers/net/pcs/pcs-xpcs.h                    |   1 +
 include/linux/pcs/pcs-xpcs.h                  |   5 +-
 4 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 09c5225111be..88fc78d55c7a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -200,9 +200,11 @@ int fbnic_phylink_create(struct net_device *netdev)
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct phylink_pcs *pcs;
 	struct phylink *phylink;
+	/* See fbnic_mdio.c addr usage */
+	int addrs[] = { 0, 1 };
 	int err;
 
-	pcs = xpcs_create_pcs_mdiodev(fbd->mdio_bus, 0);
+	pcs = xpcs_create_pcs_mdiodevs(fbd->mdio_bus, addrs, ARRAY_SIZE(addrs));
 	if (IS_ERR(pcs)) {
 		err = PTR_ERR(pcs);
 		dev_err(fbd->dev, "Failed to create PCS device: %d\n", err);
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3c11c9552b60..d59ba99c3764 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -214,9 +214,15 @@ int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg)
 	return mdiodev_c45_read(xpcs->mdiodev[0], dev, reg);
 }
 
+static int
+xpcs_mdev_write_ch(struct dw_xpcs *xpcs, int ch, int dev, u32 reg, u16 val)
+{
+	return mdiodev_c45_write(xpcs->mdiodev[ch], dev, reg, val);
+}
+
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
 {
-	return mdiodev_c45_write(xpcs->mdiodev[0], dev, reg, val);
+	return xpcs_mdev_write_ch(xpcs, 0, dev, reg, val);
 }
 
 int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)
@@ -1524,16 +1530,21 @@ static int xpcs_identify(struct dw_xpcs *xpcs)
 	return -ENODEV;
 }
 
-static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
+static struct dw_xpcs *
+xpcs_create_data(struct mdio_device **mdiodev, int channels)
 {
 	struct dw_xpcs *xpcs;
+	int i;
 
 	xpcs = kzalloc_obj(*xpcs);
 	if (!xpcs)
 		return ERR_PTR(-ENOMEM);
 
-	mdio_device_get(mdiodev);
-	xpcs->mdiodev[0] = mdiodev;
+	xpcs->channels = channels;
+	for (i = 0; i < channels; i++) {
+		mdio_device_get(mdiodev[i]);
+		xpcs->mdiodev[i] = mdiodev[i];
+	}
 	xpcs->pcs.ops = &xpcs_phylink_ops;
 	xpcs->pcs.poll = true;
 
@@ -1542,7 +1553,10 @@ static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 
 static void xpcs_free_data(struct dw_xpcs *xpcs)
 {
-	mdio_device_put(xpcs->mdiodev[0]);
+	int i;
+
+	for (i = 0; i < xpcs->channels; i++)
+		mdio_device_put(xpcs->mdiodev[i]);
 	kfree(xpcs);
 }
 
@@ -1591,12 +1605,12 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 	return xpcs_identify(xpcs);
 }
 
-static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
+static struct dw_xpcs *xpcs_create(struct mdio_device **mdiodev, int channels)
 {
 	struct dw_xpcs *xpcs;
 	int ret;
 
-	xpcs = xpcs_create_data(mdiodev);
+	xpcs = xpcs_create_data(mdiodev, channels);
 	if (IS_ERR(xpcs))
 		return xpcs;
 
@@ -1628,24 +1642,34 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 }
 
 /**
- * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
+ * xpcs_create_mdiodevs() - create a DW xPCS instance with multiple @addrs
  * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
- * @addr: device MDIO-bus ID
+ * @addrs: an array of int
+ * @channels: the number of addrs items or channels
  *
- * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
+ * Return: a pointer to the DW XPCS handle if successful, -EINVAL if the
+ * addrs is NULL or channels is out of bounds, otherwise -ENODEV if
  * the PCS device couldn't be found on the bus and other negative errno related
  * to the data allocation and MDIO-bus communications.
  */
-struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
+struct dw_xpcs *
+xpcs_create_mdiodevs(struct mii_bus *bus, const int *addrs, int channels)
 {
-	struct mdio_device *mdiodev;
+	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS], *rval;
 	struct dw_xpcs *xpcs;
+	int i;
+
+	if (!addrs || channels <= 0 || channels > DW_XPCS_MAX_CHANNELS)
+		return ERR_PTR(-EINVAL);
 
-	mdiodev = mdio_device_create(bus, addr);
-	if (IS_ERR(mdiodev))
-		return ERR_CAST(mdiodev);
+	for (i = 0; i < channels; i++) {
+		rval = mdio_device_create(bus, addrs[i]);
+		if (IS_ERR(rval))
+			goto out_nomem;
+		mdiodev[i] = rval;
+	}
 
-	xpcs = xpcs_create(mdiodev);
+	xpcs = xpcs_create(mdiodev, channels);
 
 	/* xpcs_create() has taken a refcount on the mdiodev if it was
 	 * successful. If xpcs_create() fails, this will free the mdio
@@ -1653,9 +1677,52 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
 	 * anymore, and putting it here will allow mdio_device_put() in
 	 * xpcs_destroy() to automatically free the mdio device.
 	 */
-	mdio_device_put(mdiodev);
+	for (i = 0; i < channels; i++)
+		mdio_device_put(mdiodev[i]);
 
 	return xpcs;
+out_nomem:
+	while (i--)
+		mdio_device_free(mdiodev[i]);
+	return ERR_CAST(rval);
+}
+EXPORT_SYMBOL_GPL(xpcs_create_mdiodevs);
+
+/**
+ * xpcs_create_pcs_mdiodevs() - create a DW xPCS instance with multiple @addrs
+ * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
+ * @addrs: an array of int
+ * @channels: the number of addrs items or channels
+ *
+ * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
+ * the PCS device couldn't be found on the bus and other negative errno related
+ * to the data allocation and MDIO-bus communications.
+ */
+struct phylink_pcs *
+xpcs_create_pcs_mdiodevs(struct mii_bus *bus, const int *addrs, int channels)
+{
+	struct dw_xpcs *xpcs;
+
+	xpcs = xpcs_create_mdiodevs(bus, addrs, channels);
+	if (IS_ERR(xpcs))
+		return ERR_CAST(xpcs);
+
+	return &xpcs->pcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_pcs_mdiodevs);
+
+/**
+ * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
+ * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
+ * @addr: device MDIO-bus ID
+ *
+ * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
+ * the PCS device couldn't be found on the bus and other negative errno related
+ * to the data allocation and MDIO-bus communications.
+ */
+struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
+{
+	return xpcs_create_mdiodevs(bus, &addr, 1);
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
@@ -1693,7 +1760,7 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode)
 	if (!mdiodev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	xpcs = xpcs_create(mdiodev);
+	xpcs = xpcs_create(&mdiodev, 1);
 
 	/* xpcs_create() has taken a refcount on the mdiodev if it was
 	 * successful. If xpcs_create() fails, this will free the mdio
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 5c804cfd47d3..36f4906e689a 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -114,6 +114,7 @@ struct dw_xpcs {
 	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS];
 	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
 	struct phylink_pcs pcs;
+	int channels;
 	phy_interface_t interface;
 	bool need_reset;
 	u8 eee_mult_fact;
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 36073f7b6bb4..6afa8a2aac69 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -53,10 +53,13 @@ struct dw_xpcs;
 struct phylink_pcs *xpcs_to_phylink_pcs(struct dw_xpcs *xpcs);
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
 void xpcs_config_eee_mult_fact(struct dw_xpcs *xpcs, u8 mult_fact);
+struct dw_xpcs *
+xpcs_create_mdiodevs(struct mii_bus *bus, const int *addrs, int channels);
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr);
 struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy(struct dw_xpcs *xpcs);
-
+struct phylink_pcs *
+xpcs_create_pcs_mdiodevs(struct mii_bus *bus, const int *addrs, int channels);
 struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr);
 void xpcs_destroy_pcs(struct phylink_pcs *pcs);
 
-- 
2.43.0


