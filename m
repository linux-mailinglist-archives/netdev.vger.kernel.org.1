Return-Path: <netdev+bounces-53131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010318016AE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9551F210A3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150434EB3B;
	Fri,  1 Dec 2023 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NwE6Y0Ft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D952D54
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:40:09 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-423dccefb68so31494201cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470408; x=1702075208; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOYk4fkGrDBENn1GOG5KQeQwyEmzzvV5BVXavJ5SDWo=;
        b=NwE6Y0FtnLV+HuXq25dltjQCsOydnBlTKSUQOolmVvhd8zcSABVl3qNTJD1GS7i+GD
         Po8OgRo+7WuXxVXSh9gXLZ2zj0DEATNGeLDaWRL4To2YYvWtdYE6MgbUOWaKq2yYgviF
         c1/rzWdMDkP1y9HxvO5bYW3rE8515C4qxTOs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470408; x=1702075208;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOYk4fkGrDBENn1GOG5KQeQwyEmzzvV5BVXavJ5SDWo=;
        b=vtYKeii8tcFFPR5WpIojGbeBwC3xZK3cr7t7ORiHD0WfWFCz9D2/EfdbmFIZqNYloT
         aBpsCEaN9W8LP1lXx2AiO2ogkEIq8PDgjc3Myu03v3ecO/6Rq0xjX0vZ7p3u2MqAw5JZ
         3VXcUvRA6PrCJOdzOsNcpQUjfjGtdSAynU4Ttt0qTYYhZSq/OJkeDWr2F2c4gboW8smM
         8VfXAMZNA6qdgSWAECuYklLE8EXIwGwwXTgIrK8sUXbV5xCFcdExrzWVF2yKi8U49yqT
         F9E3fkovjX5VB5j+36VtR5pj4EuuM2cm8ffaB8bjH/+4LsZ9Dg4gEqDOvwxt6K4Zk3lM
         Z5Sg==
X-Gm-Message-State: AOJu0YwqEi3YM5f4XkoRczAoDDDJnqKT/W5p6XGbRIKLfw+Nt5g8F6rs
	0YidKS1gqbNAXyxtUwn7fHCaBQ==
X-Google-Smtp-Source: AGHT+IEgCSRd8qHWmsm1IeVqYug1BjcmikN3Ym6z3BHDf+lgiaRWxCo/iPdMbcUpNOtnZH15rKFcew==
X-Received: by 2002:a05:622a:514:b0:423:7255:3c7e with SMTP id l20-20020a05622a051400b0042372553c7emr416887qtx.17.1701470408446;
        Fri, 01 Dec 2023 14:40:08 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.40.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:40:07 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH net-next 14/15] bnxt_en: Report the new ethtool link modes in the new firmware interface
Date: Fri,  1 Dec 2023 14:39:23 -0800
Message-Id: <20231201223924.26955-15-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000050c11a060b7a7321"

--00000000000050c11a060b7a7321
Content-Transfer-Encoding: 8bit

Add new look up entries to convert the new supported speeds, advertised
speeds, etc to ethtool link modes.

Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 171 ++++++++++++++++--
 1 file changed, 151 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 0a7dd48f1da8..bb9cab821587 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1577,6 +1577,22 @@ static const enum bnxt_media_type bnxt_phy_types[] = {
 	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR2] = BNXT_MEDIA_SR,
 	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR2] = BNXT_MEDIA_LR_ER_FR,
 	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER2] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR2] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR2] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR2] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER2] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR8] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR8] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR8] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER8] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR4] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR4] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR4] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4] = BNXT_MEDIA_LR_ER_FR,
 };
 
 static enum bnxt_media_type
@@ -1604,6 +1620,7 @@ enum bnxt_link_speed_indices {
 	BNXT_LINK_SPEED_50GB_IDX,
 	BNXT_LINK_SPEED_100GB_IDX,
 	BNXT_LINK_SPEED_200GB_IDX,
+	BNXT_LINK_SPEED_400GB_IDX,
 	__BNXT_LINK_SPEED_END
 };
 
@@ -1615,9 +1632,21 @@ static enum bnxt_link_speed_indices bnxt_fw_speed_idx(u16 speed)
 	case BNXT_LINK_SPEED_10GB: return BNXT_LINK_SPEED_10GB_IDX;
 	case BNXT_LINK_SPEED_25GB: return BNXT_LINK_SPEED_25GB_IDX;
 	case BNXT_LINK_SPEED_40GB: return BNXT_LINK_SPEED_40GB_IDX;
-	case BNXT_LINK_SPEED_50GB: return BNXT_LINK_SPEED_50GB_IDX;
-	case BNXT_LINK_SPEED_100GB: return BNXT_LINK_SPEED_100GB_IDX;
-	case BNXT_LINK_SPEED_200GB: return BNXT_LINK_SPEED_200GB_IDX;
+	case BNXT_LINK_SPEED_50GB:
+	case BNXT_LINK_SPEED_50GB_PAM4:
+		return BNXT_LINK_SPEED_50GB_IDX;
+	case BNXT_LINK_SPEED_100GB:
+	case BNXT_LINK_SPEED_100GB_PAM4:
+	case BNXT_LINK_SPEED_100GB_PAM4_112:
+		return BNXT_LINK_SPEED_100GB_IDX;
+	case BNXT_LINK_SPEED_200GB:
+	case BNXT_LINK_SPEED_200GB_PAM4:
+	case BNXT_LINK_SPEED_200GB_PAM4_112:
+		return BNXT_LINK_SPEED_200GB_IDX;
+	case BNXT_LINK_SPEED_400GB:
+	case BNXT_LINK_SPEED_400GB_PAM4:
+	case BNXT_LINK_SPEED_400GB_PAM4_112:
+		return BNXT_LINK_SPEED_400GB_IDX;
 	default: return BNXT_LINK_SPEED_UNKNOWN;
 	}
 }
@@ -1690,6 +1719,12 @@ bnxt_link_modes[__BNXT_LINK_SPEED_END][BNXT_SIG_MODE_MAX][__BNXT_MEDIA_END] = {
 			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
 			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
 		},
+		[BNXT_SIG_MODE_PAM4_112] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_100000baseCR_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_100000baseLR_ER_FR_Full_BIT,
+		},
 	},
 	[BNXT_LINK_SPEED_200GB_IDX] = {
 		[BNXT_SIG_MODE_PAM4] = {
@@ -1698,6 +1733,26 @@ bnxt_link_modes[__BNXT_LINK_SPEED_END][BNXT_SIG_MODE_MAX][__BNXT_MEDIA_END] = {
 			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
 			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
 		},
+		[BNXT_SIG_MODE_PAM4_112] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_200000baseLR2_ER2_FR2_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_400GB_IDX] = {
+		[BNXT_SIG_MODE_PAM4] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
+		},
+		[BNXT_SIG_MODE_PAM4_112] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_400000baseKR4_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_400000baseSR4_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
+		},
 	},
 };
 
@@ -1762,7 +1817,8 @@ static void bnxt_get_ethtool_modes(struct bnxt_link_info *link_info,
 				 lk_ksettings->link_modes.supported);
 	}
 
-	if (link_info->support_auto_speeds || link_info->support_pam4_auto_speeds)
+	if (link_info->support_auto_speeds || link_info->support_auto_speeds2 ||
+	    link_info->support_pam4_auto_speeds)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				 lk_ksettings->link_modes.supported);
 
@@ -1798,6 +1854,30 @@ static const u16 bnxt_pam4_speed_masks[] = {
 	[BNXT_LINK_SPEED_50GB_IDX] = BNXT_LINK_PAM4_SPEED_MSK_50GB,
 	[BNXT_LINK_SPEED_100GB_IDX] = BNXT_LINK_PAM4_SPEED_MSK_100GB,
 	[BNXT_LINK_SPEED_200GB_IDX] = BNXT_LINK_PAM4_SPEED_MSK_200GB,
+	[__BNXT_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
+};
+
+static const u16 bnxt_nrz_speeds2_masks[] = {
+	[BNXT_LINK_SPEED_1GB_IDX] = BNXT_LINK_SPEEDS2_MSK_1GB,
+	[BNXT_LINK_SPEED_10GB_IDX] = BNXT_LINK_SPEEDS2_MSK_10GB,
+	[BNXT_LINK_SPEED_25GB_IDX] = BNXT_LINK_SPEEDS2_MSK_25GB,
+	[BNXT_LINK_SPEED_40GB_IDX] = BNXT_LINK_SPEEDS2_MSK_40GB,
+	[BNXT_LINK_SPEED_50GB_IDX] = BNXT_LINK_SPEEDS2_MSK_50GB,
+	[BNXT_LINK_SPEED_100GB_IDX] = BNXT_LINK_SPEEDS2_MSK_100GB,
+	[__BNXT_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
+};
+
+static const u16 bnxt_pam4_speeds2_masks[] = {
+	[BNXT_LINK_SPEED_50GB_IDX] = BNXT_LINK_SPEEDS2_MSK_50GB_PAM4,
+	[BNXT_LINK_SPEED_100GB_IDX] = BNXT_LINK_SPEEDS2_MSK_100GB_PAM4,
+	[BNXT_LINK_SPEED_200GB_IDX] = BNXT_LINK_SPEEDS2_MSK_200GB_PAM4,
+	[BNXT_LINK_SPEED_400GB_IDX] = BNXT_LINK_SPEEDS2_MSK_400GB_PAM4,
+};
+
+static const u16 bnxt_pam4_112_speeds2_masks[] = {
+	[BNXT_LINK_SPEED_100GB_IDX] = BNXT_LINK_SPEEDS2_MSK_100GB_PAM4_112,
+	[BNXT_LINK_SPEED_200GB_IDX] = BNXT_LINK_SPEEDS2_MSK_200GB_PAM4_112,
+	[BNXT_LINK_SPEED_400GB_IDX] = BNXT_LINK_SPEEDS2_MSK_400GB_PAM4_112,
 };
 
 static enum bnxt_link_speed_indices
@@ -1808,12 +1888,26 @@ bnxt_encoding_speed_idx(u8 sig_mode, u16 phy_flags, u16 speed_msk)
 
 	switch (sig_mode) {
 	case BNXT_SIG_MODE_NRZ:
-		speeds = bnxt_nrz_speed_masks;
-		len = ARRAY_SIZE(bnxt_nrz_speed_masks);
+		if (phy_flags & BNXT_PHY_FL_SPEEDS2) {
+			speeds = bnxt_nrz_speeds2_masks;
+			len = ARRAY_SIZE(bnxt_nrz_speeds2_masks);
+		} else {
+			speeds = bnxt_nrz_speed_masks;
+			len = ARRAY_SIZE(bnxt_nrz_speed_masks);
+		}
 		break;
 	case BNXT_SIG_MODE_PAM4:
-		speeds = bnxt_pam4_speed_masks;
-		len = ARRAY_SIZE(bnxt_pam4_speed_masks);
+		if (phy_flags & BNXT_PHY_FL_SPEEDS2) {
+			speeds = bnxt_pam4_speeds2_masks;
+			len = ARRAY_SIZE(bnxt_pam4_speeds2_masks);
+		} else {
+			speeds = bnxt_pam4_speed_masks;
+			len = ARRAY_SIZE(bnxt_pam4_speed_masks);
+		}
+		break;
+	case BNXT_SIG_MODE_PAM4_112:
+		speeds = bnxt_pam4_112_speeds2_masks;
+		len = ARRAY_SIZE(bnxt_pam4_112_speeds2_masks);
 		break;
 	default:
 		return BNXT_LINK_SPEED_UNKNOWN;
@@ -1872,14 +1966,23 @@ bnxt_get_all_ethtool_support_speeds(struct bnxt_link_info *link_info,
 				    struct ethtool_link_ksettings *lk_ksettings)
 {
 	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+	u16 sp_nrz, sp_pam4, sp_pam4_112 = 0;
 	u16 phy_flags = bp->phy_flags;
 
-	bnxt_get_ethtool_speeds(link_info->support_speeds, media,
-				BNXT_SIG_MODE_NRZ, phy_flags,
+	if (phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		sp_nrz = link_info->support_speeds2;
+		sp_pam4 = link_info->support_speeds2;
+		sp_pam4_112 = link_info->support_speeds2;
+	} else {
+		sp_nrz = link_info->support_speeds;
+		sp_pam4 = link_info->support_pam4_speeds;
+	}
+	bnxt_get_ethtool_speeds(sp_nrz, media, BNXT_SIG_MODE_NRZ, phy_flags,
 				lk_ksettings->link_modes.supported);
-	bnxt_get_ethtool_speeds(link_info->support_pam4_speeds, media,
-				BNXT_SIG_MODE_PAM4, phy_flags,
+	bnxt_get_ethtool_speeds(sp_pam4, media, BNXT_SIG_MODE_PAM4, phy_flags,
 				lk_ksettings->link_modes.supported);
+	bnxt_get_ethtool_speeds(sp_pam4_112, media, BNXT_SIG_MODE_PAM4_112,
+				phy_flags, lk_ksettings->link_modes.supported);
 }
 
 static void
@@ -1888,14 +1991,22 @@ bnxt_get_all_ethtool_adv_speeds(struct bnxt_link_info *link_info,
 				struct ethtool_link_ksettings *lk_ksettings)
 {
 	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+	u16 sp_nrz, sp_pam4, sp_pam4_112 = 0;
 	u16 phy_flags = bp->phy_flags;
 
-	bnxt_get_ethtool_speeds(link_info->advertising, media,
-				BNXT_SIG_MODE_NRZ, phy_flags,
+	sp_nrz = link_info->advertising;
+	if (phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		sp_pam4 = link_info->advertising;
+		sp_pam4_112 = link_info->advertising;
+	} else {
+		sp_pam4 = link_info->advertising_pam4;
+	}
+	bnxt_get_ethtool_speeds(sp_nrz, media, BNXT_SIG_MODE_NRZ, phy_flags,
 				lk_ksettings->link_modes.advertising);
-	bnxt_get_ethtool_speeds(link_info->advertising_pam4, media,
-				BNXT_SIG_MODE_PAM4, phy_flags,
+	bnxt_get_ethtool_speeds(sp_pam4, media, BNXT_SIG_MODE_PAM4, phy_flags,
 				lk_ksettings->link_modes.advertising);
+	bnxt_get_ethtool_speeds(sp_pam4_112, media, BNXT_SIG_MODE_PAM4_112,
+				phy_flags, lk_ksettings->link_modes.advertising);
 }
 
 static void
@@ -1940,22 +2051,42 @@ static void bnxt_update_speed(u32 *delta, bool installed_media, u16 *speeds,
 static void bnxt_set_ethtool_speeds(struct bnxt_link_info *link_info,
 				    const unsigned long *et_mask)
 {
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+	u16 const *sp_msks, *sp_pam4_msks, *sp_pam4_112_msks;
 	enum bnxt_media_type media = bnxt_get_media(link_info);
+	u16 *adv, *adv_pam4, *adv_pam4_112 = NULL;
+	u32 delta_pam4_112 = 0;
 	u32 delta_pam4 = 0;
 	u32 delta_nrz = 0;
 	int i, m;
 
+	adv = &link_info->advertising;
+	if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		adv_pam4 = &link_info->advertising;
+		adv_pam4_112 = &link_info->advertising;
+		sp_msks = bnxt_nrz_speeds2_masks;
+		sp_pam4_msks = bnxt_pam4_speeds2_masks;
+		sp_pam4_112_msks = bnxt_pam4_112_speeds2_masks;
+	} else {
+		adv_pam4 = &link_info->advertising_pam4;
+		sp_msks = bnxt_nrz_speed_masks;
+		sp_pam4_msks = bnxt_pam4_speed_masks;
+	}
 	for (i = 1; i < __BNXT_LINK_SPEED_END; i++) {
 		/* accept any legal media from user */
 		for (m = 1; m < __BNXT_MEDIA_END; m++) {
 			bnxt_update_speed(&delta_nrz, m == media,
-					  &link_info->advertising,
-					  bnxt_nrz_speed_masks[i], et_mask,
+					  adv, sp_msks[i], et_mask,
 					  bnxt_link_modes[i][BNXT_SIG_MODE_NRZ][m]);
 			bnxt_update_speed(&delta_pam4, m == media,
-					  &link_info->advertising_pam4,
-					  bnxt_pam4_speed_masks[i], et_mask,
+					  adv_pam4, sp_pam4_msks[i], et_mask,
 					  bnxt_link_modes[i][BNXT_SIG_MODE_PAM4][m]);
+			if (!adv_pam4_112)
+				continue;
+
+			bnxt_update_speed(&delta_pam4_112, m == media,
+					  adv_pam4_112, sp_pam4_112_msks[i], et_mask,
+					  bnxt_link_modes[i][BNXT_SIG_MODE_PAM4_112][m]);
 		}
 	}
 }
-- 
2.30.1


--00000000000050c11a060b7a7321
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE34NhlP3VvNSOaxfMzcX1KCzel83eJl
EpQFWWTqqLWWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyNDAwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAnQlo6VKMMX7ekuKcDwJK/R3+UXM15dmAaBPtQhR1ngxPFHJHC
wwbumC80G0JbXhZaDcCxGI9XbT99Ampjtgv2d7p8FIlRhT7Bxmcytiqt1FAlRe1/I2W4Hs0TSMpG
KbhGfg3f7m208PdfspNzzZF3TDl3C5DSLO4jhlZJ2Uerk4sVzFJICw2ojeESxpizFhbrXi4qyVG6
eVaDDrzPiFZUh029m8qq3Wa/4foJAjanO4JzJBIUkQbvBjzNMN3+y1ATFmg2uFZ4zJ7KDopYD95c
GgDA3Fxv5Jbt5B2vwwYVSs7yjaIa6/D7RIx3HvJdkMMRT4mgKxWYbtpMRY5+MWA0
--00000000000050c11a060b7a7321--

