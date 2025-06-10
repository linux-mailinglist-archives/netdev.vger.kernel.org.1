Return-Path: <netdev+bounces-196152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48BAD3BB3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE05163A12
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7AE221281;
	Tue, 10 Jun 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMdljjqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6C2192F2
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567092; cv=none; b=ua4+w0Zsh2o0f2Y+Mw3SWuxT+04dwE+s+FnYB+pEGUbbHrYL/741OnPUT9TaqQ/tsXL3NaPu3LJmt902Ekrpi8XNkiqYHhchS+z8Mhe3tT/0hE2KqZ8AVJ2VKvQjccsQr4UUW1g3/apqxbRGYpbEAutmz0W/u/kjJk2iLI/iOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567092; c=relaxed/simple;
	bh=CBGq/fJ3fj95Gu8NJVAfrX0+VezLk1BwluT6V7yRZiM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0UyW6PBvgQocgNNdmbxbDD6M8ESTfWdMpPLGgaEHHpNIiXBmxb1GhCW6QTNiSiX1wkDRO/nxcJHKfBsh5fE77gBwoZ/hX1rthhv4R0wf8uXZvQqsjCMVxdvdw5VBx4n1NCebzNcwY0B9loJZ1dwGmzj/8YmnzM3yEpiLOkLTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMdljjqa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso4309707b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567090; x=1750171890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z+OD3X7LFJ3QUE1Xs+2oLk/zLK3u9wcMd9KWXxMyEH4=;
        b=aMdljjqanxZ+ZHMZ8Va1h729629gvWb3Tj1cycypoyH7tQrcnGEztYg3V321xGV+pK
         cr5QLtXH0sooWk0xX+aepBzXV422K2JbUnAubgWLEGRJK1DhYcwbO+2hZdXk0+oTXvtn
         Wy1I7lvqeMH76o+vyYvDwazzVrWi1jNZe6yAUNXZPnJI1IWQT75sA2LwXESszcn5FoJf
         Ry0d2zT4u6neUn+RbdnxR4k9AokXLIWkRkToprZTXx6urrDzrisyMuEOoEvCef4MAn30
         ydGci7h+n//PZaNAn/gPGKqqRuqsLJe89o07WQbh6/8fHbyiwR4iV/8AyAWVGRkgKY8G
         PNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567090; x=1750171890;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+OD3X7LFJ3QUE1Xs+2oLk/zLK3u9wcMd9KWXxMyEH4=;
        b=Bo3TLuupDpbFocHL+tPfL+WwQNKwPUIkTY9Guj4sSXFuoXBnB7/5mQxJvh7IMrB61b
         OooPJtaSSdYwfc5RUU8IbjXxx0R32WtDXGXg7ypt9keIAqLofd2q9/N7MIi4MKDgaJUi
         Hb3i1tXDd+f5ndgipgaw7FW7j6gTVtURInfdCG8nDdsCjPQdtP1R3oATTKIX2W3xDU2g
         jG8cUCZzbFOvpGHqlBmGkMahpT36hrskMnXa+CqNKvRLEJYyfcozeYyAblyzyAIlPzx9
         yY9jvZiCZnsC01ZaTuAvMqtpTTIrAev6v1cgk2opzsvuygbequS+NoM+SyvfhcU8QRMk
         /QLw==
X-Gm-Message-State: AOJu0Yxg+u2p5APOEtnH18KFB4j/wiQlx94/V8/rC1P6CbHNKwrt4jN+
	LlYL2dHpEGypdghwDROQcMj/HAJ9s93+itG9kmyPmBMYrw0GemYmkrpkHjGbLQ==
X-Gm-Gg: ASbGncvQ2XeGeCHCk5IThra2xSGMoiikHh+iv2HHIWg7tSEQdyuHtwK2sxPqvjT2cS3
	uAn2y7dy8WJyiu4dDkxfLvg0B5ZLZZBeVi8Bt+VeMyKwRfSpage0d4LgKraMFicekalpKc57/QI
	EJYq8NhL0q6ZXFxkvKOY7THcGcoHXiSXuzrD2d7z8k3l+kPwjmDuprzQxwLiWVbPwPXeh4As+xX
	m6qKry0s/AxbqYOuI+yz/rfCv3i7PvI5fpbWcZGk5jDAanW8AsYEHFZwUiKq5JwZKD5ubBXTf3m
	Pc6f7zEcPpMtI5KDRS9z8nxnqYWbFllT9aN5tECCJCYKeWKQkOr+eLrKCQhuUxQpwf/pmFjEN2/
	rl2vsgx+IlNKW1w==
X-Google-Smtp-Source: AGHT+IFp7I9gpFd80QNHqugldqcr20zV+cUnND4Q9fjb3fyPNKvQjU/Hk5yDesvIqXKMnCYYfFaLAg==
X-Received: by 2002:a05:6a00:2d23:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-74827ff8888mr23428698b3a.6.1749567089573;
        Tue, 10 Jun 2025 07:51:29 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083a9bsm7521053b3a.77.2025.06.10.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:51:29 -0700 (PDT)
Subject: [net-next PATCH 3/6] fbnic: Replace 'link_mode' with 'aui'
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Date: Tue, 10 Jun 2025 07:51:28 -0700
Message-ID: 
 <174956708824.2686723.3456558312805136408.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   89 +++++++++--------------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |   20 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    2 -
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    3 -
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   17 ++--
 6 files changed, 58 insertions(+), 81 deletions(-)

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
index 10e108c1fcd0..19159885b28e 100644
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
@@ -540,53 +540,39 @@ static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
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
 
@@ -596,9 +582,6 @@ static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
 
-	/* Pull in settings from FW */
-	fbnic_pcs_get_fw_settings(fbd);
-
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



