Return-Path: <netdev+bounces-197010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0EEAD754A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF65D172F0B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE9289E20;
	Thu, 12 Jun 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2Ek9DL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80927E7EC
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740925; cv=none; b=VhnhcvcJAHnMoqFl6EUwMTzpN8kH0ad6z4n6TFCqr4BQFwqFiQ2maJxfKBNSOzsHiqsY8dA3sSwFYig3vIRe9MHoEFLHD/hmnjmt0fQe6pyZaw8DcRTvHghKrkIpum1UuQ6C61pTX2VTiRjGR2Imuk6VmWV2Lxaq0dvseyInONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740925; c=relaxed/simple;
	bh=ktCxOxQuelWl4qy+lIfKOHir0nJBCypDQxesNYGN7BY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItA7IDcVVY0febiIHA4/1pNYFG+OUzxRXKmNbPJfrV6W0x/63Q6B7crZr5iQCyB7114c8fSYmXUO4M8qPijzWX5JmpgZJHVtaw43BefRn/wa75gMinYnvol4fl4hgZFQkV9nOji+WkjJCoi7d6LvBDgeBRR2cvvCNb4bsFJSA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2Ek9DL6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235d6de331fso12979205ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749740922; x=1750345722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2jiHHY8VuCogABBsthst/sGJPdK5CMHskHJ/otTQYQ=;
        b=B2Ek9DL6fk4sMJk79ml6mOz7emqOlxbBhnPu/nW2MtytMnWz+I07P/oFkK6VEcxJyc
         mgbcll29zFcMTZIBELvrnvI9d04K7uEH6ZaL/yoEf/e3ImYZwIIZ1o3s2dkT7QkIPgTK
         D0pDinNGYR8xPzBLjIMZCHkpW7emRsl0Rzwtvzic1G6OKRZNb9d0XF50BHlT7DDusTQb
         sZ8Rd9ivpKSmQRQoPUcBhKhsqNCcWZFvI2LePOIDOkK1064YEIN+mxVNfbP7J8xSgEmI
         Ai/BU2DT0JPgCOuXQAYXWb3U9OCUcDoxpEbYaCSsSQgECmup7fK1k5aow5UHnywnuCoB
         9Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740922; x=1750345722;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2jiHHY8VuCogABBsthst/sGJPdK5CMHskHJ/otTQYQ=;
        b=WnBHNrw5H+BY9o7/1im2NpPSKm+n+lX46tQeyXV1XycQ8H2QO/feUcublB7eGSgr+B
         HU93Q0hLarPuLuUEoewMyEd2AE22MFQTe5eJlwKQUE/dN5Bih5kIUVLX/zm1229el8UH
         pet6SYETAi+WQyHQz93mmwWY9WkWoEJ26laac3wjIh1A1Bs5nEe71q3xVD2t2kVhxlCC
         98WDYNsBHmo0jEVPTtuxU79DhmQS/G55aOMJlQ1yNUG3sMbQsQ0AROAyBR+77q1Owxd4
         8I8xIEXL8JlizFzx6WqsyihbF7MNF67eTBvP+uARNLIeaH/HofYBoAtX5hmHnA56YCeB
         2L4Q==
X-Gm-Message-State: AOJu0Yz/MKX6i5Aa0vqmIqtZKRmyP1K0IJUUW/hevZNvPmPy3zKBIDCD
	8CGApmi8jYzqVHzmXj9EoxXXtAxEKFVJJuCkW0w9rsAqr186en9HES1I
X-Gm-Gg: ASbGncuUZmOgLWyXgHLKgor0H+l7e8Cz4z9w0fEUwMRGRjd1ZxHFzd1g8z0H+70cKlT
	PRIH5WWKHWNalWX45xdWzbDzp6ZBG5GDIVokgWE3/58zNte77o9+dakJxUXvJqVv+F+KOLsjs+S
	/4ux2LJdnluCS5WS6ZAlyvI8O4MDM7419l4MBjxaFJnRUgycsfmP80YAL4GsP1/aTQtEcX5LdHY
	c4l3fiGGj41ktXvfz9mt10nPlRAVs1TQGhzqLvQVbv2uB5i5+D8wdQ2ta7MbDtsMi/e9BGwBBaA
	7zm/j0pyd7PHhZqLIgzsAMxYZXuFzRL7GK+V1ViqGILTHNKXAULyQ3yOtvsW0qBKpRr2ACALMMX
	5qdAk5cDvJY6FgVc=
X-Google-Smtp-Source: AGHT+IEdvf/3eNfCT4tabV4xDBKMXsx5AhOPNcr5mK50O486nlBAgpGyMHuBAtMvT0Yv/oNej3c4ug==
X-Received: by 2002:a17:902:cec9:b0:234:d679:72e9 with SMTP id d9443c01a7336-2364c8cd45dmr66053115ad.12.1749740922072;
        Thu, 12 Jun 2025 08:08:42 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd614092dsm1486740a12.23.2025.06.12.08.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:08:41 -0700 (PDT)
Subject: [net-next PATCH v2 3/6] fbnic: Replace 'link_mode' with 'aui'
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Thu, 12 Jun 2025 08:08:40 -0700
Message-ID: 
 <174974092054.3327565.9587401305919779622.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The way we were using "link_mode" really was more to describe the
interface between the attachment unit interface(s) we were using on the
device. Specifically the AUI is describing the modulation and the number of
lanes we are using. So we can simplify this by replacing link_mode with
aui.

In addition this change makes it so that the enum we use for the FW values
represents actual link modes that will be normally advertised by a link
partner. The general idea is to look at using this to populate
lp_advertising in the future so that we don't have to force the value and
can instead default to autoneg allowing the user to change it should they
want to force the link down or are doing some sort of manufacturing test
with a loopback plug.

Lastly we make the transition from fw_settings to aui/fec a one time thing
during phylink_init. The general idea is when we start phylink we should no
longer update the setting based on the FW and instead only allow the user
to provide the settings.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      |    8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   90 ++++++++++-------------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |   20 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    2 -
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    3 -
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   17 ++--
 6 files changed, 61 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 08bc4b918de7..08bf87c5ddf6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -155,10 +155,10 @@ enum {
 };
 
 enum {
-	FBNIC_FW_LINK_SPEED_25R1		= 1,
-	FBNIC_FW_LINK_SPEED_50R2		= 2,
-	FBNIC_FW_LINK_SPEED_50R1		= 3,
-	FBNIC_FW_LINK_SPEED_100R2		= 4,
+	FBNIC_FW_LINK_MODE_25CR			= 1,
+	FBNIC_FW_LINK_MODE_50CR2		= 2,
+	FBNIC_FW_LINK_MODE_50CR			= 3,
+	FBNIC_FW_LINK_MODE_100CR2		= 4,
 };
 
 enum {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 10e108c1fcd0..0219675d0a71 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -468,15 +468,15 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 		return false;
 
 	/* Define the expected lane mask for the status bits we need to check */
-	switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
-	case FBNIC_LINK_100R2:
+	switch (fbn->aui) {
+	case FBNIC_AUI_100GAUI2:
 		lane_mask = 0xf;
 		break;
-	case FBNIC_LINK_50R1:
+	case FBNIC_AUI_50GAUI1:
 		lane_mask = 3;
 		break;
-	case FBNIC_LINK_50R2:
-		switch (fbn->fec & FBNIC_FEC_MODE_MASK) {
+	case FBNIC_AUI_LAUI2:
+		switch (fbn->fec) {
 		case FBNIC_FEC_OFF:
 			lane_mask = 0x63;
 			break;
@@ -488,7 +488,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 			break;
 		}
 		break;
-	case FBNIC_LINK_25R1:
+	case FBNIC_AUI_25GAUI:
 		lane_mask = 1;
 		break;
 	}
@@ -540,64 +540,52 @@ static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
 	return link;
 }
 
-static void fbnic_pcs_get_fw_settings(struct fbnic_dev *fbd)
+static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
 {
-	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
-	u8 link_mode = fbn->link_mode;
-	u8 fec = fbn->fec;
-
-	/* Update FEC first to reflect FW current mode */
-	if (fbn->fec & FBNIC_FEC_AUTO) {
-		switch (fbd->fw_cap.link_fec) {
-		case FBNIC_FW_LINK_FEC_NONE:
-			fec = FBNIC_FEC_OFF;
-			break;
-		case FBNIC_FW_LINK_FEC_RS:
-			fec = FBNIC_FEC_RS;
-			break;
-		case FBNIC_FW_LINK_FEC_BASER:
-			fec = FBNIC_FEC_BASER;
-			break;
-		default:
-			return;
-		}
-
-		fbn->fec = fec;
+	/* Retrieve default speed from FW */
+	switch (fbd->fw_cap.link_speed) {
+	case FBNIC_FW_LINK_MODE_25CR:
+		*aui = FBNIC_AUI_25GAUI;
+		break;
+	case FBNIC_FW_LINK_MODE_50CR2:
+	default:
+		*aui = FBNIC_AUI_LAUI2;
+		break;
+	case FBNIC_FW_LINK_MODE_50CR:
+		*aui = FBNIC_AUI_50GAUI1;
+		*fec = FBNIC_FEC_RS;
+		return;
+	case FBNIC_FW_LINK_MODE_100CR2:
+		*aui = FBNIC_AUI_100GAUI2;
+		*fec = FBNIC_FEC_RS;
+		return;
 	}
 
-	/* Do nothing if AUTO mode is not engaged */
-	if (fbn->link_mode & FBNIC_LINK_AUTO) {
-		switch (fbd->fw_cap.link_speed) {
-		case FBNIC_FW_LINK_SPEED_25R1:
-			link_mode = FBNIC_LINK_25R1;
-			break;
-		case FBNIC_FW_LINK_SPEED_50R2:
-			link_mode = FBNIC_LINK_50R2;
-			break;
-		case FBNIC_FW_LINK_SPEED_50R1:
-			link_mode = FBNIC_LINK_50R1;
-			fec = FBNIC_FEC_RS;
-			break;
-		case FBNIC_FW_LINK_SPEED_100R2:
-			link_mode = FBNIC_LINK_100R2;
-			fec = FBNIC_FEC_RS;
-			break;
-		default:
-			return;
-		}
-
-		fbn->link_mode = link_mode;
+	/* Update FEC first to reflect FW current mode */
+	switch (fbd->fw_cap.link_fec) {
+	case FBNIC_FW_LINK_FEC_NONE:
+		*fec = FBNIC_FEC_OFF;
+		break;
+	case FBNIC_FW_LINK_FEC_RS:
+	default:
+		*fec = FBNIC_FEC_RS;
+		break;
+	case FBNIC_FW_LINK_FEC_BASER:
+		*fec = FBNIC_FEC_BASER;
+		break;
 	}
 }
 
 static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
 {
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
 	/* Mask and clear the PCS interrupt, will be enabled by link handler */
 	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
 
 	/* Pull in settings from FW */
-	fbnic_pcs_get_fw_settings(fbd);
+	fbnic_mac_get_fw_settings(fbd, &fbn->aui, &fbn->fec);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 05a591653e09..f228b12144be 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -30,22 +30,22 @@ enum {
 
 #define FBNIC_FEC_MODE_MASK	(FBNIC_FEC_AUTO - 1)
 
-/* Treat the link modes as a set of modulation/lanes bitmask:
+/* Treat the AUI modes as a modulation/lanes bitmask:
  * Bit 0: Lane Count, 0 = R1, 1 = R2
  * Bit 1: Modulation, 0 = NRZ, 1 = PAM4
- * Bit 2: Retrieve link mode from FW
+ * Bit 2: Unknown Modulation/Lane Configuration
  */
 enum {
-	FBNIC_LINK_25R1		= 0,
-	FBNIC_LINK_50R2		= 1,
-	FBNIC_LINK_50R1		= 2,
-	FBNIC_LINK_100R2	= 3,
-	FBNIC_LINK_AUTO		= 4,
+	FBNIC_AUI_25GAUI	= 0,	/* 25.7812GBd	25.78125 * 1 */
+	FBNIC_AUI_LAUI2		= 1,	/* 51.5625GBd	25.78128 * 2 */
+	FBNIC_AUI_50GAUI1	= 2,	/* 53.125GBd	53.125   * 1 */
+	FBNIC_AUI_100GAUI2	= 3,	/* 106.25GBd	53.125   * 2 */
+	FBNIC_AUI_UNKNOWN	= 4,
 };
 
-#define FBNIC_LINK_MODE_R2	(FBNIC_LINK_50R2)
-#define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
-#define FBNIC_LINK_MODE_MASK	(FBNIC_LINK_AUTO - 1)
+#define FBNIC_AUI_MODE_R2	(FBNIC_AUI_LAUI2)
+#define FBNIC_AUI_MODE_PAM4	(FBNIC_AUI_50GAUI1)
+#define FBNIC_AUI_MODE_MASK	(FBNIC_AUI_UNKNOWN - 1)
 
 enum fbnic_sensor_id {
 	FBNIC_SENSOR_TEMP,		/* Temp in millidegrees Centigrade */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index aa812c63d5af..7bd7812d9c06 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -736,8 +736,6 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	 */
 	netdev->ethtool->wol_enabled = true;
 
-	fbn->fec = FBNIC_FEC_AUTO | FBNIC_FEC_RS;
-	fbn->link_mode = FBNIC_LINK_AUTO | FBNIC_LINK_50R2;
 	netif_carrier_off(netdev);
 
 	netif_tx_stop_all_queues(netdev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 561837e80ec8..c30c060b72e0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -42,9 +42,8 @@ struct fbnic_net {
 	struct phylink_config phylink_config;
 	struct phylink_pcs phylink_pcs;
 
-	/* TBD: Remove these when phylink supports FEC and lane config */
+	u8 aui;
 	u8 fec;
-	u8 link_mode;
 
 	/* Cached top bits of the HW time counter for 40b -> 64b conversion */
 	u32 time_high;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 860b02b22c15..edd8738c981a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -21,23 +21,20 @@ fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
 	struct fbnic_dev *fbd = fbn->fbd;
 
-	/* For now we use hard-coded defaults and FW config to determine
-	 * the current values. In future patches we will add support for
-	 * reconfiguring these values and changing link settings.
-	 */
-	switch (fbd->fw_cap.link_speed) {
-	case FBNIC_FW_LINK_SPEED_25R1:
+	switch (fbn->aui) {
+	case FBNIC_AUI_25GAUI:
 		state->speed = SPEED_25000;
 		break;
-	case FBNIC_FW_LINK_SPEED_50R2:
+	case FBNIC_AUI_LAUI2:
+	case FBNIC_AUI_50GAUI1:
 		state->speed = SPEED_50000;
 		break;
-	case FBNIC_FW_LINK_SPEED_100R2:
+	case FBNIC_AUI_100GAUI2:
 		state->speed = SPEED_100000;
 		break;
 	default:
-		state->speed = SPEED_UNKNOWN;
-		break;
+		state->link = 0;
+		return;
 	}
 
 	state->duplex = DUPLEX_FULL;



