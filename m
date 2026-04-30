Return-Path: <netdev+bounces-282896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INJUGIpy82l52wEAu9opvQ
	(envelope-from <netdev+bounces-282896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:17:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55B4A4953
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9DBA301A692
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4792DB79E;
	Thu, 30 Apr 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8cKgCvk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D2351C14
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561693; cv=none; b=inSFGiJ/HlurFK8Or9dVsq3BpG/EjbU5sceLRp9yQ448alGEC1+KaWr8zVi76IvfE6I3Khdjbo0Tn4WIgsbCNxhysZHP7vgKxk40t0CjHD6LzBoeVNggyAmSVN9d2/hgpyuEUpz/gUS/K39MIvjLo6rqDlqgc2L15oi4NXD1YXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561693; c=relaxed/simple;
	bh=aHwhNUgUunEsuCx5PWSlpnspb7dCR3q1nJ8+AeBsZI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnaI1c/Zatx0+w3Ym0WXjmbz0whscrEdnu1LVcbK6HYGB7KYvkK2qOFfI/Mz4KFL1wTyVL+AqNj8k88CPfH6M4MhE1WmW4qR0/JEC/qNIbb8yM+FkyyPNeAykdJJ1wzCtyBnlGe3RtCzcGk3zobjbSRG7anXzwg/65iYNDY1te4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8cKgCvk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506251815a3so6967681cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777561689; x=1778166489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exOWp3uV0NKcyfspEwFa1OV17okj3o/cEeqBYuta5Ho=;
        b=J8cKgCvksINmscyqdaHwbmuPrlbVne9SWfhrySc1P5e0VBGBnyaUzHkHvBmxdGGJzz
         l52lCWhDHQVF1ZjshP3nSTBlTdw6zdowiD3xprQfGf4zxb+cVts/u0RRDqz4axZjwKZh
         zRh7RKTQ6LKXwCmfbtkp4xoKlXmG8L8ilNSSuGHkgPBiOVwsDTeXF9TfyZtMTz4q3KZd
         68s8rKeLOd5EVyJxUsXJbVBUQgLu+6lEvQQxTH8qdJs/eNviXp9mAUdltNJGc83hToVK
         cXlZNqW5O2Ubj4vlyeRJ6xfLXrY+IapLiZa/oUurgb3kyMc1RvVP9+OPIenX5B3PWstY
         86IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561689; x=1778166489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=exOWp3uV0NKcyfspEwFa1OV17okj3o/cEeqBYuta5Ho=;
        b=rjMHHGNU0jfeiNNUmX4ynea6IIhH0g8gS6oQrDLA0M0bhxK5rRPRYdrFmPJyf4XwkX
         2sI39ufEOsVQPWBlcExh8fcqk7RvFe8ZxMy1JUt0WdOVh5uRm57eADJmRWK/cxK9tD3L
         q2CuyGImmZxouNo62QzxWCImCJM76kbe2aNluaq9CnQu22q7f3phc1vCF8IdgRTP9DhR
         E2I68ZvbIVwaJ4GylKBPzaZGaIDNYvAFM0EYxC58DZnpKbZKyh4GlHnL0oAmhjQEX8JI
         LTIcKua3DiifbIFpBimqswKiznYW8akGtF3tspPDpbzFerZUgoMjXkbGzch0j5C6Dkx8
         8iGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OonDcrJ0BwtbuH3F/7PBEO1fnR7uD/Wp8sB/eVPNxSLSg15Z07MuJSR2F3OnJPQfN9HZ5wy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/wzUnIBaWNVh4YrjQbq5SGM+hKWy7kzW1gVdjKDdWjuUfpFF
	jfEAGqr7aNmomlS2RPsbFrkHmofKulJ1qTugqMuL1uuBu3CdfMaC6I/F
X-Gm-Gg: AeBDievI+/JZsT1TvkhqLkBcGPsu1PguDSPg9Ec0Iyink+UwLYl1u9o7GPJuG2D8UMD
	uaZWiX4G7tJy8wEXthYe0Ud5je6xFcJ0s5uJjzX5+ZUSy6g27/WcGdHifpfHLQMkhFqomjl7odB
	rlpC07JYr3K9E2xnpWcKFblBsSyTVTJII97nRupjRJwZ4K/NbucIHtZMLV690UEj4sBnzufF3f8
	Bn4W1OHlk+Oq4JzumJ4S5OyKMbJo19NFNxQn22PEmAJX7gwS6SaB9Hb7h/ziWuIKj7OjvF02rwi
	M0bIwyPQiMtFOA6vm8DwSv6wqko2FBg90pKGyNfMVJhiwDethEZGDBRNpULqdiORe9lHH14u+Dl
	hj44Y2VbV4eIfHN69+cF4vm+t4Nz+CaFJHbevPKynekaG05JudWUqhGJ/DcooA9UWOf1wKavzUo
	3edNbQ9TkpoJYCA+DP5KikrqmG9VOep8QjZRoMqftxX5rQfYnDEFAf9CnfaigZEoXTPasfCC164
	slUBQ==
X-Received: by 2002:ac8:5a0e:0:b0:510:1b61:d103 with SMTP id d75a77b69052e-5102adbeb71mr44488361cf.36.1777561689349;
        Thu, 30 Apr 2026 08:08:09 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b397c38sm450731cf.7.2026.04.30.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:08:07 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/3] net: eth: fbnic: Consolidate register reads for ids and devs
Date: Thu, 30 Apr 2026 11:08:01 -0400
Message-ID: <20260430150802.3521-3-mike.marciniszyn@gmail.com>
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
X-Rspamd-Queue-Id: 8A55B4A4953
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
	TAGGED_FROM(0.00)[bounces-282896-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Consolidate the register reads for boiler plate registers
to reduce LOC and cleanup pcs reads for DEVS1 to
fetch overrides for reserved bits that the hardware does not
return.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2:
  - Restore pcs register read for DEVS2
  - read pcs DEVS1 overrides and or into return
v1: https://lore.kernel.org/all/20260428172810.175077-4-mike.marciniszyn@gmail.com/

 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 64 ++++++++++++--------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index 709041f7fc43..a3a072597a2c 100644
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


