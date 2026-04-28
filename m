Return-Path: <netdev+bounces-282026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHIfDnXu8GkvbQEAu9opvQ
	(envelope-from <netdev+bounces-282026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:29:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B5489F91
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA36D301ED3A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6C844D014;
	Tue, 28 Apr 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSOumaoM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1F449EDF
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397298; cv=none; b=ouJS6T+zwO4aXrQem2Sgtrbau8ZcDEGfRioKkZN4ggKwVez6ouD0vHVO2mYClFMu4mTHlmkXdIZbfo8StGfliC5/NjqduN3GT0ipWZERXCxwW/EysleI90SrRmM9QdjNKyyNBNoJBLI7i4k5EjrUvmIcpxLUQB+N8H1StTAhhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397298; c=relaxed/simple;
	bh=+CyEbZZ0T9f0WYppfuB5lFGjTJt8P8WMHioJ2jEjgBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+2kOgorSKwKnaI0HmOfPXiPQF5USVTdc2GcQnXGT+n/bi1U555Wh21JH9ItRx4qLq4vNbjfic8wOwBM7BoE2lGrZP/RIZ/ieqYb/7p+EDnypKafBPrkxLw16eCsowK+bIo+EovGz9Cli78wUBKHRbIfsjCJI2vFSBpUCfdrSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSOumaoM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b3e37e0d45so9603236d6.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397296; x=1778002096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkQzcxzDANJLoet+F0tc+63Pw984K+qaOeKMroPLmww=;
        b=OSOumaoMeOzJ0sIY8ymohMejfjrmSU4+XSY5+4AeD+9BaT1sBPiq4mmK9h1fZYlZU2
         fi1OtemraHwoB/kW64UbFVCT8tvBMfr/SmGCmVfhTqfRQ/jVtMRTo07mGM64yRVfkwTH
         8yO4Bsm8FRWF6L/nIiSBEFFMrkdvmbWFShgz0TSidyLZe7kkKDZztdEz7H77ywgelQMW
         zdf+WL76+/YMIKAHqYAppX90fymy9chMckDTBcXf+1iaUB0od51nOtxkL9o6cwaM72C+
         0Kkkt/apjYNu+dqChEwydkfAz17Kj2bbgfA6zrID5mwuqjAGsDmIEhZT1juty21QAAml
         PcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397296; x=1778002096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkQzcxzDANJLoet+F0tc+63Pw984K+qaOeKMroPLmww=;
        b=ErYmiFHZMCAdTZFxPphst1qA6b5NO6Ek2yWfHIFSary/sv+oG8tJl59VDxg7QSIxuV
         sW4cfWYahetqLzt7gnVMve1JXLPBx6QiVmHofU9o08RtdMkYHQS3NBEyF26nd1/OnbfJ
         yR2y35btUra5imUOntRv2wiTsCfbYOH8AZDcyl0LR5KmEUXH4kcMrSQAIFxnlA/ykfzj
         AcxyJD4F7BjQe9CBMC0xDzU3z123nqe3gIAmo64Yhl8LcCTlmuHEcnTe5zwjT9FM0cq4
         5qiT2ivyV+XFzczpR+bUvAX9ReljFRweBNwRIIub+J4nIg2nOt0KMhamVAbX2faCfOo2
         i09g==
X-Forwarded-Encrypted: i=1; AFNElJ9VsZ5pdNN3FdSLFHYJ/GUWbRSHhSC2vIQ4u2CZKEhEnIBhbJ2t35F4VgKMnAs7WG2zXViTmfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQeRxJvuYtIly5YFybkBQ93lnZRU5rRRwIfGbpilQmq8ltHETy
	0HoKRGhf/opwwtioJgckIOdPzQd4tqAbBvnZWdQ7Bv6/EG0zcYrw+ZSm
X-Gm-Gg: AeBDiesATnmI9oEdupT2wZed1ovkY6vwQXQqjxyr4CeMZDdnhKMK/eXhgaNN8oXC0b/
	yT6yI8spX3u8WTefUKOwLBZRv1WEyAvHARqPziGbCYqKQtfnVncbyHztE8S8CoLNqduBQw/OHsW
	gn76QgKXXrqrSdnhDrEwzkuNHKipMatZXKYTiX6FJCZPl81f42/wiJPr+Q7tC78CtV71nFJWhM8
	ucd5aUhk2Ny4cXD2BrL+iiKI/6SVgvYMtoX8NAIKvha4gIRPJDZP8AdRIkhQQpX1bg5BmHF3+7s
	oH7UbTG1nWhQAVtfD+Dw+dh374t0hbyttJptYPO6qQMlHUp1cN70gw7y+9Tjns/xOcW1hwHwGY/
	3F3KwBcmk4j0hz9xQxIY75p9OstLxSVJexTAyYAQWzPGqt+qyLY2YJLVuEKlryoR6h7xxsVsT4B
	1O9zMNHFtg6RRdwqZqy03DV6OjBwEyPvH38q39e9dg2NxIlP+AndLeAWck0E6lsFPntOw=
X-Received: by 2002:a05:6214:21af:b0:8ac:a57e:ec1f with SMTP id 6a1803df08f44-8b3e307a772mr65078446d6.29.1777397295547;
        Tue, 28 Apr 2026 10:28:15 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e299d76asm26253676d6.48.2026.04.28.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:28:15 -0700 (PDT)
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
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: eth: fbnic: Consolidate register reads for ids and devs
Date: Tue, 28 Apr 2026 13:28:09 -0400
Message-ID: <20260428172810.175077-4-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD1B5489F91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com];
	TAGGED_FROM(0.00)[bounces-282026-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Consolidate the register reads for boiler plate registers
to reduce LOC.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 56 ++++++++++++--------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index d6a124889f52..18c12508a0c4 100644
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
 
@@ -75,18 +84,19 @@ fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
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
+	case MDIO_DEVS1 ... MDIO_DEVS2:
+		ret = fbnic_mdio_ids(DW_XPCS_ID, regnum);
+		break;
+	default:
+		/* Swap vendor page bit for FBNIC PCS vendor page bit */
+		if (regnum & DW_VENDOR)
+			offset ^= DW_VENDOR | FBNIC_PCS_VENDOR;
 
-	ret = fbnic_rd32(fbd, FBNIC_PCS_PAGE(addr) + (regnum ^ offset));
+		ret = fbnic_rd32(fbd, FBNIC_PCS_PAGE(addr) + (regnum ^ offset));
+		break;
+	}
 
 	dev_dbg(fbd->dev,
 		"SWMII PCS Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
-- 
2.43.0


