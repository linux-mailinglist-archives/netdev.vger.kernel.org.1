Return-Path: <netdev+bounces-199258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BB7ADF934
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8BB561E7D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C327E1B1;
	Wed, 18 Jun 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzbC+ViF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680727E062
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284466; cv=none; b=GTXxXs9VNMyhI9ueDn+JHYB8UbMWYmi6E1tyT80Xlzd0Lq9eC1oyzMr7MAd2kwVUT8V9+fAzMC/0kG+RJ3vTLBLmE/PF4db+JcLBjgXhjyvD7VnpVN6eAw4QoT7Oxd97oxUALUP53cvBIs9JSDMnvFGRZGFhyRf+jxZVWUdV21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284466; c=relaxed/simple;
	bh=UtzwZ6JQSJ9U1swtmMZyoyJoRvsN71+3fF5ueXjvUZQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbQlgbJs7nUQBwhVGFJIM2NogWFy24OF6l5W4A4wPRIP4WCUXqSYT3Vl6SeU8JO3PYYNmrIigFcnszQSTISvIpYK9X69t/mTGR3vMKnS6BZ2HqulTGrBNNq/7N7N//SU7zvj0OlDmDTX9IoglI1GunRkbvOm87e3QTrWWpq8DdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzbC+ViF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so1325595ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284464; x=1750889264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5X7h1ogZ7QqUxr18oBaEZoIoSHd5hynsRK9IwAtv/L4=;
        b=hzbC+ViFpzJOu1iGhGNqhP9IRatM3WUgvV7ilWCQBlwHr+kUZ/qfgCXPmUQawP6yJy
         VfLfNJwhmZFZGhgR51dlb9vir23d1BUtbq6S+T8rVxe9snJ7YuVXkFoPUsYsHjorSrNB
         gCcNd7tYhJ4bkMh9PUZNFFl6mNsbRe8dR05mC7aPmaqeH/ntD/4178nPngTody+0/DWA
         L+apfxoXPUbzUdt2U3y+T023rQO0WbiwQgXm/1lw4C78oA9awheTK0kyjvPG5MZFFjMi
         H0Gk9im5vcbsAqi1quZuDslWqih1Fo0QYzDJK/lO73YXIWHnRCGPOhcGUmiWwsBa5lcZ
         YNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284464; x=1750889264;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5X7h1ogZ7QqUxr18oBaEZoIoSHd5hynsRK9IwAtv/L4=;
        b=K22krfdNsEN3x7G90hKQAMc8w/NrmDsVjzhmghXmhTJJ2NXwbP0FPzDzte2/lt7a8r
         ZpWXUE6Kwj2H3lja/ni7pcRM21LZAFpsTmPOGhhayZLJq3uMdzkfu+UkTlIDJoe3SRDB
         z6NNkl8r73Qc5XIC1+XcXVgTAG+H0QVvAlK9ieIx5Ti8aoMiKMSqLFXxQoRNJH2z705N
         n9C9m77FZCRZff4Kit25alWTWS3PQjvnb08OWl1hWRpEV3eDE/x/3+Y1KLItVIgR75vi
         pXAcHXzrgVq7SJCpeuI0Ocx5Yjr5AMHz9DDiAYjMksnYmZWRj9rogdgxEexluTueKvOM
         rJxA==
X-Gm-Message-State: AOJu0YwGM/NtxhGABdv5Lv12nsPiy+BfgPThCxq/BuOuPbDxg972kM0f
	xqoNACFvRreGBt8nNPbq6y9ZGYQfKYSJOPnkAIMZRELW8p+l4bXd1j05
X-Gm-Gg: ASbGnctU/yAe1INeNv0VpKFYhizSHhXD+746qWWA4IIac7QLliuXjUen2UNeeWnyJ6I
	8AYJihYSMj+5XaGUa8KD9gZMdp9IdcMveMoRhOmOaorrHspwWImK+5cT+vf4Wc5QMaOK6sx+KAl
	O9yL5N93J6KRBMs0qCQMH0ZfXa0BCjhaiLvm9+bZA3G/lGbvFp8YxR9rv8vszh0rJ8rt1cuFErb
	hBix6IeMLRNWZyvYNEj7kuBAimEtoQ1B7sE5WVifFObo6cWqvRN8xqHV1zxDz2I1WIKOhh1VJZg
	/FBtNYHkbjyVv0j0TZmKneN2zQhcT9DDOq7g1MOpNYSV6IXSNnrghOXteJ9zS1V/vVaA4GeSXA8
	pkABi1XlN8rNpzA==
X-Google-Smtp-Source: AGHT+IHx7aO8wBXnyzILDVZGtENj1mjdRSOX6ka4sqaiEth1c889dUo3zwwgCRpUFNTNaq0aSB8QTg==
X-Received: by 2002:a17:902:ebc1:b0:234:8c64:7885 with SMTP id d9443c01a7336-2366b17dd03mr296250775ad.53.1750284463735;
        Wed, 18 Jun 2025 15:07:43 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.35.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a318802sm536958a91.35.2025.06.18.15.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:07:43 -0700 (PDT)
Subject: [net-next PATCH v3 4/8] fbnic: Replace link_mode with AUI
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:07:42 -0700
Message-ID: 
 <175028446219.625704.8050098629750896117.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
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

The way we were using "link_mode" was really more to describe the interface
between the attachment unit interface(s) we were using on the device.
Specifically the AUI is describing the modulation and the number of lanes
we are using. So we can simplify this by replacing link_mode with aui.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |   25 +++++++++++------------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |   18 ++++++++---------
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    3 +--
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   10 +++++----
 4 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 56b429c96a7c..0528724011c1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -468,14 +468,14 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 		return false;
 
 	/* Define the expected lane mask for the status bits we need to check */
-	switch (fbn->link_mode) {
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
+	case FBNIC_AUI_LAUI2:
 		switch (fbn->fec) {
 		case FBNIC_FEC_OFF:
 			lane_mask = 0x63;
@@ -488,7 +488,7 @@ static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
 			break;
 		}
 		break;
-	case FBNIC_LINK_25R1:
+	case FBNIC_AUI_25GAUI:
 		lane_mask = 1;
 		break;
 	}
@@ -540,27 +540,26 @@ static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
 	return link;
 }
 
-static void
-fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *link_mode, u8 *fec)
+static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
 {
 	/* Retrieve default speed from FW */
 	switch (fbd->fw_cap.link_speed) {
 	case FBNIC_FW_LINK_SPEED_25R1:
-		*link_mode = FBNIC_LINK_25R1;
+		*aui = FBNIC_AUI_25GAUI;
 		break;
 	case FBNIC_FW_LINK_SPEED_50R2:
-		*link_mode = FBNIC_LINK_50R2;
+		*aui = FBNIC_AUI_LAUI2;
 		break;
 	case FBNIC_FW_LINK_SPEED_50R1:
-		*link_mode = FBNIC_LINK_50R1;
+		*aui = FBNIC_AUI_50GAUI1;
 		*fec = FBNIC_FEC_RS;
 		return;
 	case FBNIC_FW_LINK_SPEED_100R2:
-		*link_mode = FBNIC_LINK_100R2;
+		*aui = FBNIC_AUI_100GAUI2;
 		*fec = FBNIC_FEC_RS;
 		return;
 	default:
-		*link_mode = FBNIC_LINK_UNKONWN;
+		*aui = FBNIC_AUI_UNKNOWN;
 		return;
 	}
 
@@ -588,7 +587,7 @@ static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
 
 	/* Pull in settings from FW */
-	fbnic_mac_get_fw_settings(fbd, &fbn->link_mode, &fbn->fec);
+	fbnic_mac_get_fw_settings(fbd, &fbn->aui, &fbn->fec);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index f4e75530a939..151d785116cb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -27,21 +27,21 @@ enum {
 	FBNIC_FEC_BASER		= 2,
 };
 
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
-	FBNIC_LINK_UNKONWN	= 4,
+	FBNIC_AUI_25GAUI	= 0,	/* 25.7812GBd	25.78125 * 1 */
+	FBNIC_AUI_LAUI2		= 1,	/* 51.5625GBd	25.78128 * 2 */
+	FBNIC_AUI_50GAUI1	= 2,	/* 53.125GBd	53.125   * 1 */
+	FBNIC_AUI_100GAUI2	= 3,	/* 106.25GBd	53.125   * 2 */
+	FBNIC_AUI_UNKNOWN	= 4,
 };
 
-#define FBNIC_LINK_MODE_R2	(FBNIC_LINK_50R2)
-#define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
+#define FBNIC_AUI_MODE_R2	(FBNIC_AUI_LAUI2)
+#define FBNIC_AUI_MODE_PAM4	(FBNIC_AUI_50GAUI1)
 
 enum fbnic_sensor_id {
 	FBNIC_SENSOR_TEMP,		/* Temp in millidegrees Centigrade */
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
index cb375a3dafe8..edd8738c981a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -21,15 +21,15 @@ fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
 	struct fbnic_dev *fbd = fbn->fbd;
 
-	switch (fbn->link_mode) {
-	case FBNIC_LINK_25R1:
+	switch (fbn->aui) {
+	case FBNIC_AUI_25GAUI:
 		state->speed = SPEED_25000;
 		break;
-	case FBNIC_LINK_50R2:
-	case FBNIC_LINK_50R1:
+	case FBNIC_AUI_LAUI2:
+	case FBNIC_AUI_50GAUI1:
 		state->speed = SPEED_50000;
 		break;
-	case FBNIC_LINK_100R2:
+	case FBNIC_AUI_100GAUI2:
 		state->speed = SPEED_100000;
 		break;
 	default:



