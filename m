Return-Path: <netdev+bounces-283859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qINYIUGn+GlexgIAu9opvQ
	(envelope-from <netdev+bounces-283859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:03:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F14BE6DE
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B84A303A97A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FB43DEAD8;
	Mon,  4 May 2026 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt6IIFhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAC3DE440
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903111; cv=none; b=bybZw0AvdpWULzrvjyueHfj/Xv/Ov3FmJ+T7IustzkxbuHKyl18WFPGs1MuR6odrco9DMc5Xqjc47pWMHmGsf+qGnyRCZw4vzD46sBgnaV1ZekzlwmjvTa0gaQY9I06CjJ4XgWyM1Mz+R0TRKvhVqv2rOvHBQiTxRWt+Ks78sa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903111; c=relaxed/simple;
	bh=3pFnDC0mCujMX012oSF4vMSTWQu20p02Xga6M+J1OmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZoCONnHFX/Pi3OWe5+MgpjEHKdvLwQyeKQdSE5nt6G9EB7KM7KdML+YEiQMPt29adrk+ak89XcGDUVno8nAC1H81HdL4bPEhvaNUvsg2sZCChQryIBq03I7DXiK7VvrJL3r5kSGHPNyp8n/iNBQH8kkrKyDT3VkavyU24QSTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt6IIFhT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ea8563c693so466399185a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903103; x=1778507903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+t4PaXqbMYHZCpeonJmlbU+PizLvuoOJyIOEFPFoGA=;
        b=lt6IIFhTWtXLNE8HTU5KXAyZWSL5B9AlMwOpmurBBLGzMxJkBgvBvK3AvoHLEqKyWU
         wRwKjj1VnQA5itlaE3hRtoaiekNOGOoxwQIvLxYk7ueCW/0LIgmlVC4P7JZJ4gN2Duag
         uSpZ3GtWYI/QyEkB0XkCcPK+DxeSxrj+lj2xWJjC31j/CbJ9aP+XOyeoKnZlPeL/Nw5L
         sJH6Yw5nNvh9aY34yfawkuWWYGQNp24qIqpxgdWICYO8JqHC2bVHlTIposBc+6cZOTvP
         Z8kWDSi/1CMoeAmZ+GhXt9iZum92CFuPRDCfkTvoNstmhc0JiyPF33F1YuymdYGZJRLb
         r/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903103; x=1778507903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L+t4PaXqbMYHZCpeonJmlbU+PizLvuoOJyIOEFPFoGA=;
        b=pjMD9QohW9SgP5TzYlIOkzO7uHBKqboe4qBQ5+MZFRoX4Yz42iycSkDzxRP/iWhWM4
         UxOm8s9zs9Kofec52N+xL7CV5UJ0jTfd26c4P9k58GbGmzy43yXZ1EsIrOO4ReY3BYtB
         UHgF74xqE4e5lM2fr/wDneK7eyASOuArF4t8BnHjRMkuUhdsqR4J+Bi13pg/vVNJbz7b
         sTRB4S17iKR5B/ofzlkXkE9xiAmpQFvzxWSaeKRzWjQT/dRWU3znvT5VAPBJuo3abQkC
         1eWpCyHUG2OSFCJjKIn/i2WWLbNnPPU1QhVvcz4X328/rewjJdcSd/91lKlMebRzA8oL
         JP3g==
X-Forwarded-Encrypted: i=1; AFNElJ+/9hCVyjMGbqD62r2lNVrfVogzuVGuTd9oMLZqidixXpCx08n6jPw62SDpSi/fOlkHH3/ax5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzf608TPozFnmCMy9Q78cvM07wCqcb352lXX44DMPpxHCy6enn
	8jqYHhG3Bxg0G3EIU2IAMgW/PYHsQTXoSibvo2kU7+AtoYD9P8jhg9gG
X-Gm-Gg: AeBDiesBckcWksEL1M78LaTTsfB3y5Yqsyu37e/nME7A90G0BqBzrMyYe4RBc4t9LDT
	AbVj7pqkyAAkgyqL2ac76mXnN8utVA/vM7cIDpHf4xQ3mTiSRaveUgZfQUdi7Nf4SxL/BIx+rT3
	QQGypJWRxNMkRN3vfNhLjdOez2AhqM+Ypc76zZsPaX+rZjk8kbXkz0DCdAek3EDWWl5usXDGkzA
	W/l1LDyjhDC7Qp6b1YAn+FpDcULRqY+GpdiPCXf4DImXA7au7xG3IEm1CEZHfzJXSIxizzhMZAS
	sHgPsnsBqTMZAxk89nKJyIB3PMdVUrjNTHchHPFDdLcF40HvDt465GmWHciHD52OHAY1JYcK02f
	vzCE6YzD4YCOrIKVC4trYJgRe/j59NuUd0jh5c1pXmip1mANQasX91rsolFUj7Ehd94jQZB1cCm
	+8/7jOdpcBKPRaWUEdwjprUVu1O1PL5L9Rde7QnEaDEmJDQSurJGYSfKvdu+ettw4Iuvg=
X-Received: by 2002:a05:620a:4706:b0:8f8:8860:fb8b with SMTP id af79cd13be357-8fd18633adfmr1527413985a.52.1777903103463;
        Mon, 04 May 2026 06:58:23 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm1062878585a.35.2026.05.04.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:58:22 -0700 (PDT)
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
Subject: [PATCH net-next v3 4/4] net: eth: fbnic: Add pma read and write access
Date: Mon,  4 May 2026 09:58:15 -0400
Message-ID: <20260504135815.44226-5-mike.marciniszyn@gmail.com>
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
X-Rspamd-Queue-Id: 8C9F14BE6DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283859-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
v2: https://lore.kernel.org/all/20260430150802.3521-4-mike.marciniszyn@gmail.com/
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
index d794f5d8d84f..fe3a4ce88413 100644
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


