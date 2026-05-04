Return-Path: <netdev+bounces-283858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI4qOEOm+GnQxQIAu9opvQ
	(envelope-from <netdev+bounces-283858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:59:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0E4BE427
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5970E30182E1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A93DE44E;
	Mon,  4 May 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W55+T4x1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD93DE45F
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903104; cv=none; b=rgTGfk7YzcfhgVQX/ehn9/TyECRTATe2H451NN4PfJ87QTkOFM5O2MXuyiARNeV5zMUVBABa7pSj/VE36fOVdwUcT6NMS9f1iBbOxCTGUooNlmlSfYBtHAaWLlwsctnr8LXChzYZ/0N3qLvtJCPl88iHK4h/NUE0ikzOBgQaag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903104; c=relaxed/simple;
	bh=5MH+eiieYN8/gZNZRVkYIpI14qODtezNFPLW5Q9sLK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLgeCydajAcqHEGw6My9CvgTfGzFC3Yi/Dll2icWYp1UaEicaoE36dIuWGKlUja+fhQ/GA18juISxf22XD1ce/OxFK9BOimW337jn0Ti1+OhD3vQu7Aw9eZHFGc/Va8l9vpk9zmJ5SC3uLjqTCzPPONVLG7yR7asu2u2hCtSoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W55+T4x1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8dbbc6c16b2so531304785a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903102; x=1778507902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhxLbT8/zsSgwq5f8w11BHu+0+FsfNH5LorDR212ejI=;
        b=W55+T4x164nVgHVpBJOHAHkGM5RIwYarNMo4i9/RpEsPwfYhAwRxzf2zs/n6OVeWl3
         6Fjg4Cd60LQvE4yk6bl8goW333hvkmedNzd5NZ3cmFeHIUX2jMKLv4itpUni1U8O84SS
         BWj6/kM1c0m7VxmxQ6FXB0FZlGV+L/1n5w2wWlm1rdW8JeOIbcMqy1q/nnUJ2jq1wjKM
         16rZMXgHOShwuNohTNYdZEnwWdBCIhwGf2Xtyb87JHoGXs+OByqVsUn5Yg80dg8Mvu61
         mdRwAM5iU0tkfQEIKzFeq+Emoc8e0v2X1rKHQ5Wz/ch4mDavZD/7alaOtn9g0vaiZYNn
         3hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903102; x=1778507902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhxLbT8/zsSgwq5f8w11BHu+0+FsfNH5LorDR212ejI=;
        b=Mdxjy/KSBJb285//c0/NGwpBncK+XeXqHyjcIPSKiWz2+MGY9/cAOxjrlfNczzojwp
         BGFU7IJREKMdRV4uYtLaabjigFvqYlMw/+Jb75TwP+1lYID8V58Tbrm3r2XID62988CA
         dFLnpQnm/5oR+DqCHz1M21CKBB+DL23iyOUVaKuYWYDcrVikPoERRFj5pUvgckvL3gKy
         9A5ilY1kHL/8/oUa6/skNsYRkJ5t9WzRtmQRuREsA0FGI4xaSsPh1yW5O8mlerhgVURB
         bKEjD+zPHs9TJqRQK77UqbSsma5tJyJxW/WjbEPTN/jqP09saWMS775ey4bgL/AqHu9x
         pyVw==
X-Forwarded-Encrypted: i=1; AFNElJ8c26JNiHgePNP5lEEQO2sOBayR2CfD1AtxwNeAKbeZZA4YePVcwvfOymNTHQ8V3x8LMDBZIR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRrXTqYWGUmxHUO6xM8WuDqLe9QqGUyDcD0accMYXZ2TEhs/f
	IfSyMCuVhgLgdwO6jgUJ4RuxYEs2THUlyYiQ1b+x3nmEY8v023Ph4BUN
X-Gm-Gg: AeBDievOuuBBO3MVpK6sZkaIHjpmdOfQQZeqeGVe56vdT4c84QAWBP3yUN3au2I+fA9
	WnjOn8pAlZiBSZAtVp2YeVTQ6cZk9roHJagMccl4U/iL0qh4tj3079NPIOm/RCFkBI4z636UqPq
	/IBpdncNswZhcTETc60Z/81EX61gxbU3K8tli4/7yLLGGOfzpZ/3j4X4SmWWGKSDPr8jjrv9MB/
	OxFT7J6+jaz2XYBcRFW03iKutpGJWTH+GbEiXoPsYfPK2hXKIKVMRdHCJpBw2Amy7L/hl6cznLw
	DTGmeHUxaxUE7NkYVegbdjOgWMSsIrtgI1pUyqz2KJKTLq760amDFaWcK+t+fpb5S2i5TERd0CB
	YYDD7kgxK/HeaMnBLE1s9xSdIycEZx9l6ZmmJgsYHfg8QenbB9dJ9iWhNTA8zCIpj/4Q1c/shFU
	Chno/dgMcYjSehkqd5zCZeo2gPVg+ULb/rOvMz8vukW1nBAdBqOpEEVfO7ZCU3rgHJPdE=
X-Received: by 2002:a05:620a:7113:b0:8ee:3715:212b with SMTP id af79cd13be357-8fabb1f5b74mr2183987885a.29.1777903101870;
        Mon, 04 May 2026 06:58:21 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm1062878585a.35.2026.05.04.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:58:21 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/4] net: eth: fbnic: Consolidate register reads for ids and devs
Date: Mon,  4 May 2026 09:58:14 -0400
Message-ID: <20260504135815.44226-4-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82D0E4BE427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283858-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Consolidate the register reads for boiler plate registers
to reduce LOC and cleanup pcs reads for DEVS1 to
fetch overrides for reserved bits that the hardware does not
return.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - no changes
v2: https://lore.kernel.org/all/20260430150802.3521-3-mike.marciniszyn@gmail.com/
  - Restore pcs register read for DEVS2
  - read pcs DEVS1 overrides and or into return
v1: https://lore.kernel.org/all/20260428172810.175077-4-mike.marciniszyn@gmail.com/

 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 64 ++++++++++++--------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index d6a124889f52..d794f5d8d84f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -11,6 +11,26 @@
 #define FBNIC_PCS_VENDOR	BIT(9)
 #define FBNIC_PCS_ZERO_MASK	(DW_VENDOR - FBNIC_PCS_VENDOR)
 
+static int
+fbnic_mdio_ids(int id, int regnum)
+{
+	/* return correct IDs */
+	switch (regnum) {
+	case MDIO_DEVID1:
+		return id >> 16;
+	case MDIO_DEVID2:
+		return id & 0xffff;
+	case MDIO_DEVS1:
+		return MDIO_DEVS_SEP_PMA1 | MDIO_DEVS_PMAPMD | MDIO_DEVS_PCS;
+	case MDIO_DEVS2:
+		return 0;
+	case MDIO_STAT2:
+		return MDIO_STAT2_DEVPRST_VAL;
+	}
+
+	return 0;
+}
+
 static int
 fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
 {
@@ -29,18 +49,6 @@ fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
 	}
 
 	switch (regnum) {
-	case MDIO_DEVID1:
-		ret = MP_FBNIC_XPCS_PMA_100G_ID >> 16;
-		break;
-	case MDIO_DEVID2:
-		ret = MP_FBNIC_XPCS_PMA_100G_ID & 0xffff;
-		break;
-	case MDIO_DEVS1:
-		ret = MDIO_DEVS_PMAPMD | MDIO_DEVS_PCS;
-		break;
-	case MDIO_STAT2:
-		ret = MDIO_STAT2_DEVPRST_VAL;
-		break;
 	case MDIO_PMA_RXDET:
 		/* If training isn't complete default to 0 */
 		if (fbd->pmd_state != FBNIC_PMD_SEND_DATA)
@@ -51,6 +59,7 @@ fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
 		       (MDIO_PMD_RXDET_1 / FBNIC_AUI_MODE_R2));
 		break;
 	default:
+		ret = fbnic_mdio_ids(MP_FBNIC_XPCS_PMA_100G_ID, regnum);
 		break;
 	}
 
@@ -64,7 +73,7 @@ fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
 static int
 fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
 {
-	int ret, offset = 0;
+	int ret, offset = 0, overrides = 0;
 
 	/* We will need access to both PCS instances to get config info */
 	if (addr >= 2)
@@ -75,18 +84,25 @@ fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
 		return 0;
 
 	/* Intercept and return correct ID for PCS */
-	if (regnum == MDIO_DEVID1)
-		return DW_XPCS_ID >> 16;
-	if (regnum == MDIO_DEVID2)
-		return DW_XPCS_ID & 0xffff;
-	if (regnum == MDIO_DEVS1)
-		return MDIO_DEVS_PMAPMD | MDIO_DEVS_PCS;
-
-	/* Swap vendor page bit for FBNIC PCS vendor page bit */
-	if (regnum & DW_VENDOR)
-		offset ^= DW_VENDOR | FBNIC_PCS_VENDOR;
+	switch (regnum) {
+	case MDIO_DEVID1 ... MDIO_DEVID2:
+		ret = fbnic_mdio_ids(DW_XPCS_ID, regnum);
+		break;
+	case MDIO_DEVS1:
+		/* DW IP returns MDIO_DEVS_SEP_PMA1, MDIO_DEVS_PMAPMD,
+		 * and MDIO_DEVS_PCS as 0
+		 */
+		overrides = fbnic_mdio_ids(DW_XPCS_ID, regnum);
+		fallthrough;
+	default:
+		/* Swap vendor page bit for FBNIC PCS vendor page bit */
+		if (regnum & DW_VENDOR)
+			offset ^= DW_VENDOR | FBNIC_PCS_VENDOR;
 
-	ret = fbnic_rd32(fbd, FBNIC_PCS_PAGE(addr) + (regnum ^ offset));
+		ret = fbnic_rd32(fbd, FBNIC_PCS_PAGE(addr) + (regnum ^ offset));
+		ret |= overrides;
+		break;
+	}
 
 	dev_dbg(fbd->dev,
 		"SWMII PCS Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
-- 
2.43.0


