Return-Path: <netdev+bounces-282897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA4DDU5y82l52wEAu9opvQ
	(envelope-from <netdev+bounces-282897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:16:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A77054A48DA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968743068ECE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA743DA23;
	Thu, 30 Apr 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj9fxcls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608F2C159A
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561695; cv=none; b=kg7nf/ktFqd4KpIUyxBA1Kw6Y+lgh9raza8cXAMbB+MyEkv71mssttZ6Y1sWCcI8BrhbCL5XZ+bENLEqWY4mGmgY1E9Fbkjkw8ZPfSnxyid1nttc9JrjgP0iPflf6wN2btwmbwFWGH9n9s6TSr5DlJZe/jWqJEAie/GCe0yu+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561695; c=relaxed/simple;
	bh=4/PXjA5wui8riVIOeSTDKTzLDfB5K2L0rU+nCg+H4co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAYQalf+5nBMKHqgrL5dmxz83QBrupjEczShoc18S00BIwzB9Ot/Czb9DOKF7EmS75rSyzoNQ8rDkBZ4QhBXOqFH7DznXN6tuw88B6HoElStvnM101VtL7qZ1dIKCt1vbJ+1JBOH5e5UhYCICYc2Tt1WLu7Y603mHEv/ccE97Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj9fxcls; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50fc496c8baso7993821cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777561691; x=1778166491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjLCv7/Lm3Fd1vFVHO/bH+3GFNPBrRzS27c9E9pX0+I=;
        b=Hj9fxclsGD+xISFute/bPAgdCLVFcq+q6v0UHWT2yaRWXAwrux339P3LnTHZUW1Wnu
         W8CAoDHZIGmalBW8z/w98Y5EKf0xKU/MJ+wVEu4EQ1bCNp8aqU2O1jMAHoHXXldXeDOv
         ndog7KxiIvaMu5tIdcYi/DRlgXZpc4SMEwnquDqKboLRat7mjwtKpvfrDHhnZcyYUFMf
         gTG1YVSVut0hCbDlDgFDK6rqvDu6rW2Q5Ucvkxf+7xDfgcn2CExM0zbgAvZ3Ed8E/Lai
         5Nq8B6UfbhZ0Ec3FPyShxQNPgkC/yt6hbA47BenPa5ciPOMQ3KT5IOfSRzJBmhtZIy8G
         aI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561691; x=1778166491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjLCv7/Lm3Fd1vFVHO/bH+3GFNPBrRzS27c9E9pX0+I=;
        b=hkSvRkApsE9NQ0rMtJGWXf+d0L5h8epevKNfFhfY/m8ynm4uvbIrAkRqWABXlUlaQQ
         gfsg9mU/pGTDc0jHGJBG1VFAsIkV6Q3nHz2NXi2K2RKC3DRn2qP8Q3UNYALeWG8iEdOb
         KqFihKyepeDbBDTvQnfyspozACG6nAJiDmQUmbrALjMhbDjTzAyS3sgKW8YWWzuKwgQ9
         uXP39Bkvdb0/23E8dTYmymhB31m0uLEqKjLYct0U/7A+e0+hKKtbS8kh3bPeg6izfhSa
         DheOg04EO1Baq+mc1wpGcCrVJio09bklMbLSydhHmMzDL6Ukltcae6x3+Bvi1w/hifnZ
         2icg==
X-Forwarded-Encrypted: i=1; AFNElJ9mg1iKoEFYenEVECT9/UPEYSFl7JLHKxfIOGB0vnb5eUm1kCo+WzWKMONumyT3MeayNi9Qtws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBzVS8tZB6poS9FE75kOLBVrG2Zp6ZWFb1kWwGL0/GFiP4r4l
	l9r+poOozp3zmNeLZ8Eh+z1zOUAF9lyjUPZhW6rBW1/PRa3DliZApRN6
X-Gm-Gg: AeBDievGKCcjVUV5WFv4Cfse7t6bAwRmNjVy5fZ0UxyO4daHyIgo/Fvn8HJ9jtrYEsN
	B7VpXnJZ4peGZythPKBFuvS0yNUEKQBklH4XG3kdG5eIWIiJ/VOunVkFiHX3eyGvgPtywhtWAzE
	mas9a5czslXAsvchoQ+PN/l0cPPZxF6nfKU73WMqQ2rnjHJvBkENZnAPn4Akcx0fom/xkCiAU22
	yPCsuSRNbIk6xSSuvLNUwxsp2Klm8wsn5ZQ1A7BdyiTBWc/bkl7bCLkBkqzDNjmw8cCQYNHlBa2
	f3Kg42HTDes9pM37r8HJxjU4nd6BPwjCoY4k9IpQjkIpwtwwOk8atHb3J2g6/OH38ZiJLznwM1Y
	PO8k0jBTvPYNwJrecXSmszx2MqOYdsJQNc9b3Z+GM9Bfe6DjWT4Na+ayzZmAwvwgMzSSOrWx5Nr
	Do8ETbgRw7AlXXldlWteb6Ru0fQGzEBD54TAK4pfsaOYYl61zPSNBRHGjKytr9Ksmoifw=
X-Received: by 2002:a05:622a:250e:b0:50e:d316:fa35 with SMTP id d75a77b69052e-5102ada86c3mr45222281cf.36.1777561691282;
        Thu, 30 Apr 2026 08:08:11 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b397c38sm450731cf.7.2026.04.30.08.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:08:10 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: eth: fbnic: Add pma read and write access
Date: Thu, 30 Apr 2026 11:08:02 -0400
Message-ID: <20260430150802.3521-4-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
References: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A77054A48DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282897-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Document the MDIO interface topology with an ASCII diagram
showing the MAC, PCS (MMD 3), FEC, Separated PMA (MMD 8), and PMD
(MMD 1) blocks and their interconnects. The diagram illustrates how
4 lanes connect the MAC through PCS, FEC, and PMA, then narrow to
2 lanes at the PMD.

The c45 read and write routines are enhanced to support
read and write of the separated PMA for the fbnic.

Co-developed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2:
  - no changes
v1: https://lore.kernel.org/all/20260428172810.175077-5-mike.marciniszyn@gmail.com/

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 71 ++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 81794bd326e1..64b958df7774 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -805,6 +805,7 @@ enum {
 #define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */

 #define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
+#define FBNIC_RSFEC_CONTROL(n)	(0x10800 + 8 * (n))	/* 0x42000 + 32*n */

 /* We have 4 RSFEC engines present in our part, however we are only using 1.
  * As such only CCW(0) and NCCW(0) will never be non-zero and the other
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index a3a072597a2c..7a8727e8f6f2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -7,6 +7,25 @@
 #include "fbnic.h"
 #include "fbnic_netdev.h"

+/* fbnic MDIO Interface Layout
+ *
+ *        +-------------------+
+ *        |        MAC        |
+ *        +-------------------+
+ *            |   |   |   |  <-- 25GMII, 50GMII, or CGMII
+ *        +-------------------+
+ *  MMD 3 |        PCS        |
+ *        +-------------------+
+ *        |        FEC        |
+ *        +-------------------+
+ *  MMD 8 |  Separated PMA    |
+ *        +-------------------+
+ *              |       |     <-- PMD Service Interface
+ *        +-------------------+
+ *  MMD 1 |        PMD        |
+ *        +-------------------+
+ */
+
 #define DW_VENDOR		BIT(15)
 #define FBNIC_PCS_VENDOR	BIT(9)
 #define FBNIC_PCS_ZERO_MASK	(DW_VENDOR - FBNIC_PCS_VENDOR)
@@ -111,6 +130,32 @@ fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
 	return ret;
 }

+static int
+fbnic_mdio_read_pma(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	int ret = 0;
+
+	/* We will need access to both PMA instances to get config info */
+	if (addr >= 2)
+		return 0;
+
+	switch (regnum) {
+	case MDIO_PMA_RSFEC_CTRL ... MDIO_PMA_RSFEC_LANE_MAP:
+		ret = fbnic_rd32(fbd, FBNIC_RSFEC_CONTROL(addr) +
+				 regnum - MDIO_PMA_RSFEC_CTRL);
+		break;
+	default:
+		ret = fbnic_mdio_ids(MP_FBNIC_XPCS_PMA_100G_ID, regnum);
+		break;
+	}
+
+	dev_dbg(fbd->dev,
+		"SWMII PMA Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, ret);
+
+	return ret;
+}
+
 static int
 fbnic_mdio_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
 {
@@ -122,6 +167,9 @@ fbnic_mdio_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
 	if (devnum == MDIO_MMD_PCS)
 		return fbnic_mdio_read_pcs(fbd, addr, regnum);

+	if (devnum == MDIO_MMD_SEP_PMA1)
+		return fbnic_mdio_read_pma(fbd, addr, regnum);
+
 	return 0;
 }

@@ -155,6 +203,26 @@ fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
 	fbnic_wr32(fbd, FBNIC_PCS_PAGE(addr) + regnum, val);
 }

+static void
+fbnic_mdio_write_pma(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
+{
+	dev_dbg(fbd->dev,
+		"SWMII PMA Wr: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, val);
+
+	if (addr >= 2)
+		return;
+
+	switch (regnum) {
+	case MDIO_PMA_RSFEC_CTRL ... MDIO_PMA_RSFEC_LANE_MAP:
+		fbnic_wr32(fbd, FBNIC_RSFEC_CONTROL(addr) +
+				regnum - MDIO_PMA_RSFEC_CTRL, val);
+		break;
+	default:
+		break;
+	}
+}
+
 static int
 fbnic_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
 		     int regnum, u16 val)
@@ -167,6 +235,9 @@ fbnic_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
 	if (devnum == MDIO_MMD_PCS)
 		fbnic_mdio_write_pcs(fbd, addr, regnum, val);

+	if (devnum == MDIO_MMD_SEP_PMA1)
+		fbnic_mdio_write_pma(fbd, addr, regnum, val);
+
 	return 0;
 }

--
2.43.0


