Return-Path: <netdev+bounces-53129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52B8016AB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60007281EF8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165D619DF;
	Fri,  1 Dec 2023 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fu7SUfMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC54D67
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:40:06 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-423a9cb7e80so16038601cf.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470405; x=1702075205; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aaj1qrJH1AVlUTm3Egq0FBDvBiQ6ruZezO+w9jFo4/Y=;
        b=fu7SUfMAiu6sA6LAwniU3C/b4NvR4WYLtg/vkBZskwdE2PDROlhlTygIHX7jtUvZWv
         5oyJIAdTaNSCfzjakXTML7RFLy5Co8IwRddGrjAnznCSIPmJgMn1f+HHgPt3nMW4XB86
         NZ8X/19gWGUaUbzWAcOjpksetk593YzctM21I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470405; x=1702075205;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aaj1qrJH1AVlUTm3Egq0FBDvBiQ6ruZezO+w9jFo4/Y=;
        b=AvWq34aaNo0I/JCM181VKWLxrJPpMFvuAzpycijnOsql953hx/6Norpb4j2ZrKNgLU
         Fv8re3fD2owQJCdQizk/KE/gVNnIczp/VZAQemKmIXP5jVZEMbDUhChj4TmMq811GvdN
         y8r9iBRP2VytiwYR9s8Elu3ChjECTflYynHxzR4pDVpRPZ6pzYyINJ2l88/LE4chKR0B
         MMzIQ5gvpGDt1lCAUlWtP/qGog3M0KbKSl42CC73R55KCXgJ8ZpVn/SNOwbJhHbjh4OF
         A6qdgKzEWUbwhKN/2Q/qbKkpq1RRJGL0zoS2Z54CBwz1NsDlNIjbUSs8Zk3LGaDMHQNw
         LmZw==
X-Gm-Message-State: AOJu0YxDH5L3RQKKb362JNr5wBtgR/inqJzWrUvLdD1Q1cqYIKIMOftK
	OE9XydXYFXnkyKBBioCoT+yjKU+4bU3ZqKBw8xY=
X-Google-Smtp-Source: AGHT+IFOFWyfHP5O41xAJUjRIfKr2mu++ujd4+5PPut19Y3eeIrdprUEmlqmsu4b0EwVhAl8sWHMvA==
X-Received: by 2002:a05:622a:86:b0:423:8e8c:4d70 with SMTP id o6-20020a05622a008600b004238e8c4d70mr29330628qtw.67.1701470405079;
        Fri, 01 Dec 2023 14:40:05 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.40.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:40:04 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 12/15] bnxt_en: Support new firmware link parameters
Date: Fri,  1 Dec 2023 14:39:21 -0800
Message-Id: <20231201223924.26955-13-michael.chan@broadcom.com>
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
	boundary="0000000000002034e6060b7a73b9"

--0000000000002034e6060b7a73b9
Content-Transfer-Encoding: 8bit

Newer firmware supporting PAM4 112Gbps speeds use new parameters in
firmware message structures.  Detect the new firmware capability and
add basic logic to report and store these new fields.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 93 +++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 46 +++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++
 3 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3b0ced2a5f32..5f6c4644271c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2250,6 +2250,10 @@ static u16 bnxt_agg_ring_id_to_grp_idx(struct bnxt *bp, u16 ring_id)
 
 static u16 bnxt_get_force_speed(struct bnxt_link_info *link_info)
 {
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+
+	if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2)
+		return link_info->force_link_speed2;
 	if (link_info->req_signal_mode == BNXT_SIG_MODE_PAM4)
 		return link_info->force_pam4_link_speed;
 	return link_info->force_link_speed;
@@ -2257,6 +2261,28 @@ static u16 bnxt_get_force_speed(struct bnxt_link_info *link_info)
 
 static void bnxt_set_force_speed(struct bnxt_link_info *link_info)
 {
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+
+	if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		link_info->req_link_speed = link_info->force_link_speed2;
+		link_info->req_signal_mode = BNXT_SIG_MODE_NRZ;
+		switch (link_info->req_link_speed) {
+		case BNXT_LINK_SPEED_50GB_PAM4:
+		case BNXT_LINK_SPEED_100GB_PAM4:
+		case BNXT_LINK_SPEED_200GB_PAM4:
+		case BNXT_LINK_SPEED_400GB_PAM4:
+			link_info->req_signal_mode = BNXT_SIG_MODE_PAM4;
+			break;
+		case BNXT_LINK_SPEED_100GB_PAM4_112:
+		case BNXT_LINK_SPEED_200GB_PAM4_112:
+		case BNXT_LINK_SPEED_400GB_PAM4_112:
+			link_info->req_signal_mode = BNXT_SIG_MODE_PAM4_112;
+			break;
+		default:
+			link_info->req_signal_mode = BNXT_SIG_MODE_NRZ;
+		}
+		return;
+	}
 	link_info->req_link_speed = link_info->force_link_speed;
 	link_info->req_signal_mode = BNXT_SIG_MODE_NRZ;
 	if (link_info->force_pam4_link_speed) {
@@ -2267,12 +2293,25 @@ static void bnxt_set_force_speed(struct bnxt_link_info *link_info)
 
 static void bnxt_set_auto_speed(struct bnxt_link_info *link_info)
 {
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+
+	if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		link_info->advertising = link_info->auto_link_speeds2;
+		return;
+	}
 	link_info->advertising = link_info->auto_link_speeds;
 	link_info->advertising_pam4 = link_info->auto_pam4_link_speeds;
 }
 
 static bool bnxt_force_speed_updated(struct bnxt_link_info *link_info)
 {
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+
+	if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		if (link_info->req_link_speed != link_info->force_link_speed2)
+			return true;
+		return false;
+	}
 	if (link_info->req_signal_mode == BNXT_SIG_MODE_NRZ &&
 	    link_info->req_link_speed != link_info->force_link_speed)
 		return true;
@@ -2284,6 +2323,13 @@ static bool bnxt_force_speed_updated(struct bnxt_link_info *link_info)
 
 static bool bnxt_auto_speed_updated(struct bnxt_link_info *link_info)
 {
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+
+	if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		if (link_info->advertising != link_info->auto_link_speeds2)
+			return true;
+		return false;
+	}
 	if (link_info->advertising != link_info->auto_link_speeds ||
 	    link_info->advertising_pam4 != link_info->auto_pam4_link_speeds)
 		return true;
@@ -10082,7 +10128,10 @@ void bnxt_report_link(struct bnxt *bp)
 				signal = "(NRZ) ";
 				break;
 			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4:
-				signal = "(PAM4) ";
+				signal = "(PAM4 56Gbps) ";
+				break;
+			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112:
+				signal = "(PAM4 112Gbps) ";
 				break;
 			default:
 				break;
@@ -10110,7 +10159,9 @@ static bool bnxt_phy_qcaps_no_speed(struct hwrm_port_phy_qcaps_output *resp)
 	if (!resp->supported_speeds_auto_mode &&
 	    !resp->supported_speeds_force_mode &&
 	    !resp->supported_pam4_speeds_auto_mode &&
-	    !resp->supported_pam4_speeds_force_mode)
+	    !resp->supported_pam4_speeds_force_mode &&
+	    !resp->supported_speeds2_auto_mode &&
+	    !resp->supported_speeds2_force_mode)
 		return true;
 	return false;
 }
@@ -10156,6 +10207,7 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
 			/* Phy re-enabled, reprobe the speeds */
 			link_info->support_auto_speeds = 0;
 			link_info->support_pam4_auto_speeds = 0;
+			link_info->support_auto_speeds2 = 0;
 		}
 	}
 	if (resp->supported_speeds_auto_mode)
@@ -10164,6 +10216,9 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
 	if (resp->supported_pam4_speeds_auto_mode)
 		link_info->support_pam4_auto_speeds =
 			le16_to_cpu(resp->supported_pam4_speeds_auto_mode);
+	if (resp->supported_speeds2_auto_mode)
+		link_info->support_auto_speeds2 =
+			le16_to_cpu(resp->supported_speeds2_auto_mode);
 
 	bp->port_count = resp->port_cnt;
 
@@ -10181,9 +10236,19 @@ static bool bnxt_support_dropped(u16 advertising, u16 supported)
 
 static bool bnxt_support_speed_dropped(struct bnxt_link_info *link_info)
 {
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+
 	/* Check if any advertised speeds are no longer supported. The caller
 	 * holds the link_lock mutex, so we can modify link_info settings.
 	 */
+	if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+		if (bnxt_support_dropped(link_info->advertising,
+					 link_info->support_auto_speeds2)) {
+			link_info->advertising = link_info->support_auto_speeds2;
+			return true;
+		}
+		return false;
+	}
 	if (bnxt_support_dropped(link_info->advertising,
 				 link_info->support_auto_speeds)) {
 		link_info->advertising = link_info->support_auto_speeds;
@@ -10232,18 +10297,25 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 	link_info->lp_pause = resp->link_partner_adv_pause;
 	link_info->force_pause_setting = resp->force_pause;
 	link_info->duplex_setting = resp->duplex_cfg;
-	if (link_info->phy_link_status == BNXT_LINK_LINK)
+	if (link_info->phy_link_status == BNXT_LINK_LINK) {
 		link_info->link_speed = le16_to_cpu(resp->link_speed);
-	else
+		if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2)
+			link_info->active_lanes = resp->active_lanes;
+	} else {
 		link_info->link_speed = 0;
+		link_info->active_lanes = 0;
+	}
 	link_info->force_link_speed = le16_to_cpu(resp->force_link_speed);
 	link_info->force_pam4_link_speed =
 		le16_to_cpu(resp->force_pam4_link_speed);
+	link_info->force_link_speed2 = le16_to_cpu(resp->force_link_speeds2);
 	link_info->support_speeds = le16_to_cpu(resp->support_speeds);
 	link_info->support_pam4_speeds = le16_to_cpu(resp->support_pam4_speeds);
+	link_info->support_speeds2 = le16_to_cpu(resp->support_speeds2);
 	link_info->auto_link_speeds = le16_to_cpu(resp->auto_link_speed_mask);
 	link_info->auto_pam4_link_speeds =
 		le16_to_cpu(resp->auto_pam4_link_speed_mask);
+	link_info->auto_link_speeds2 = le16_to_cpu(resp->auto_link_speeds2);
 	link_info->lp_auto_link_speeds =
 		le16_to_cpu(resp->link_partner_adv_speeds);
 	link_info->lp_auto_pam4_link_speeds =
@@ -10382,7 +10454,11 @@ static void bnxt_hwrm_set_link_common(struct bnxt *bp, struct hwrm_port_phy_cfg_
 {
 	if (bp->link_info.autoneg & BNXT_AUTONEG_SPEED) {
 		req->auto_mode |= PORT_PHY_CFG_REQ_AUTO_MODE_SPEED_MASK;
-		if (bp->link_info.advertising) {
+		if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+			req->enables |=
+				cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEEDS2_MASK);
+			req->auto_link_speeds2_mask = cpu_to_le16(bp->link_info.advertising);
+		} else if (bp->link_info.advertising) {
 			req->enables |= cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEED_MASK);
 			req->auto_link_speed_mask = cpu_to_le16(bp->link_info.advertising);
 		}
@@ -10396,7 +10472,12 @@ static void bnxt_hwrm_set_link_common(struct bnxt *bp, struct hwrm_port_phy_cfg_
 		req->flags |= cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_RESTART_AUTONEG);
 	} else {
 		req->flags |= cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_FORCE);
-		if (bp->link_info.req_signal_mode == BNXT_SIG_MODE_PAM4) {
+		if (bp->phy_flags & BNXT_PHY_FL_SPEEDS2) {
+			req->force_link_speeds2 = cpu_to_le16(bp->link_info.req_link_speed);
+			req->enables |= cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_FORCE_LINK_SPEEDS2);
+			netif_info(bp, link, bp->dev, "Forcing FW speed2: %d\n",
+				   (u32)bp->link_info.req_link_speed);
+		} else if (bp->link_info.req_signal_mode == BNXT_SIG_MODE_PAM4) {
 			req->force_pam4_link_speed = cpu_to_le16(bp->link_info.req_link_speed);
 			req->enables |= cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_FORCE_PAM4_LINK_SPEED);
 		} else {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 57694eb7feeb..d8c2b0790117 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1360,6 +1360,7 @@ struct bnxt_link_info {
 #define BNXT_LINK_STATE_DOWN	1
 #define BNXT_LINK_STATE_UP	2
 #define BNXT_LINK_IS_UP(bp)	((bp)->link_info.link_state == BNXT_LINK_STATE_UP)
+	u8			active_lanes;
 	u8			duplex;
 #define BNXT_LINK_DUPLEX_HALF	PORT_PHY_QCFG_RESP_DUPLEX_STATE_HALF
 #define BNXT_LINK_DUPLEX_FULL	PORT_PHY_QCFG_RESP_DUPLEX_STATE_FULL
@@ -1394,8 +1395,11 @@ struct bnxt_link_info {
 #define BNXT_LINK_SPEED_50GB	PORT_PHY_QCFG_RESP_LINK_SPEED_50GB
 #define BNXT_LINK_SPEED_100GB	PORT_PHY_QCFG_RESP_LINK_SPEED_100GB
 #define BNXT_LINK_SPEED_200GB	PORT_PHY_QCFG_RESP_LINK_SPEED_200GB
+#define BNXT_LINK_SPEED_400GB	PORT_PHY_QCFG_RESP_LINK_SPEED_400GB
 	u16			support_speeds;
 	u16			support_pam4_speeds;
+	u16			support_speeds2;
+
 	u16			auto_link_speeds;	/* fw adv setting */
 #define BNXT_LINK_SPEED_MSK_100MB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_100MB
 #define BNXT_LINK_SPEED_MSK_1GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_1GB
@@ -1411,12 +1415,52 @@ struct bnxt_link_info {
 #define BNXT_LINK_PAM4_SPEED_MSK_50GB PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_50G
 #define BNXT_LINK_PAM4_SPEED_MSK_100GB PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_100G
 #define BNXT_LINK_PAM4_SPEED_MSK_200GB PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_200G
+	u16			auto_link_speeds2;
+#define BNXT_LINK_SPEEDS2_MSK_1GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_1GB
+#define BNXT_LINK_SPEEDS2_MSK_10GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_10GB
+#define BNXT_LINK_SPEEDS2_MSK_25GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_25GB
+#define BNXT_LINK_SPEEDS2_MSK_40GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_40GB
+#define BNXT_LINK_SPEEDS2_MSK_50GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB
+#define BNXT_LINK_SPEEDS2_MSK_100GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB
+#define BNXT_LINK_SPEEDS2_MSK_50GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB_PAM4_56
+#define BNXT_LINK_SPEEDS2_MSK_100GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_56
+#define BNXT_LINK_SPEEDS2_MSK_200GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_56
+#define BNXT_LINK_SPEEDS2_MSK_400GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_56
+#define BNXT_LINK_SPEEDS2_MSK_100GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_112
+#define BNXT_LINK_SPEEDS2_MSK_200GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_112
+#define BNXT_LINK_SPEEDS2_MSK_400GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_112
+
 	u16			support_auto_speeds;
 	u16			support_pam4_auto_speeds;
+	u16			support_auto_speeds2;
+
 	u16			lp_auto_link_speeds;
 	u16			lp_auto_pam4_link_speeds;
 	u16			force_link_speed;
 	u16			force_pam4_link_speed;
+	u16			force_link_speed2;
+#define BNXT_LINK_SPEED_50GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_50GB_PAM4_56
+#define BNXT_LINK_SPEED_100GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_56
+#define BNXT_LINK_SPEED_200GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_56
+#define BNXT_LINK_SPEED_400GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_56
+#define BNXT_LINK_SPEED_100GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_112
+#define BNXT_LINK_SPEED_200GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_112
+#define BNXT_LINK_SPEED_400GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112
+
 	u32			preemphasis;
 	u8			module_status;
 	u8			active_fec_sig_mode;
@@ -1447,6 +1491,7 @@ struct bnxt_link_info {
 	u8			req_signal_mode;
 #define BNXT_SIG_MODE_NRZ	PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ
 #define BNXT_SIG_MODE_PAM4	PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4
+#define BNXT_SIG_MODE_PAM4_112	PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112
 #define BNXT_SIG_MODE_MAX	(PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST + 1)
 	u8			req_duplex;
 	u8			req_flow_ctrl;
@@ -2337,6 +2382,7 @@ struct bnxt {
 #define BNXT_PHY_FL_NO_PAUSE		(PORT_PHY_QCAPS_RESP_FLAGS2_PAUSE_UNSUPPORTED << 8)
 #define BNXT_PHY_FL_NO_PFC		(PORT_PHY_QCAPS_RESP_FLAGS2_PFC_UNSUPPORTED << 8)
 #define BNXT_PHY_FL_BANK_SEL		(PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED << 8)
+#define BNXT_PHY_FL_SPEEDS2		(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
 
 	u8			num_tests;
 	struct bnxt_test_info	*test_info;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index a9b6141337d4..7bc0bddbb126 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2020,11 +2020,20 @@ u32 bnxt_fw_to_ethtool_speed(u16 fw_link_speed)
 	case BNXT_LINK_SPEED_40GB:
 		return SPEED_40000;
 	case BNXT_LINK_SPEED_50GB:
+	case BNXT_LINK_SPEED_50GB_PAM4:
 		return SPEED_50000;
 	case BNXT_LINK_SPEED_100GB:
+	case BNXT_LINK_SPEED_100GB_PAM4:
+	case BNXT_LINK_SPEED_100GB_PAM4_112:
 		return SPEED_100000;
 	case BNXT_LINK_SPEED_200GB:
+	case BNXT_LINK_SPEED_200GB_PAM4:
+	case BNXT_LINK_SPEED_200GB_PAM4_112:
 		return SPEED_200000;
+	case BNXT_LINK_SPEED_400GB:
+	case BNXT_LINK_SPEED_400GB_PAM4:
+	case BNXT_LINK_SPEED_400GB_PAM4_112:
+		return SPEED_400000;
 	default:
 		return SPEED_UNKNOWN;
 	}
@@ -2040,6 +2049,7 @@ static void bnxt_get_default_speeds(struct ethtool_link_ksettings *lk_ksettings,
 		base->duplex = DUPLEX_HALF;
 		if (link_info->duplex & BNXT_LINK_DUPLEX_FULL)
 			base->duplex = DUPLEX_FULL;
+		lk_ksettings->lanes = link_info->active_lanes;
 	} else if (!link_info->autoneg) {
 		base->speed = bnxt_fw_to_ethtool_speed(link_info->req_link_speed);
 		base->duplex = DUPLEX_HALF;
-- 
2.30.1


--0000000000002034e6060b7a73b9
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAhgtzbcMhsgct0FRWvzg4lUgxTymWBo
Pvp7ZatrStpzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyNDAwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBbRqLUcFPLS+NDU7gEhszQ8JH45kHXxThwvNF8nVqt+TIuVebR
bBxXROhwJKBWYHMATUdyHcE3Kds+PBJkfe3bq424ZFQ3v47tS7D5e2vd/e+KzVV6WZsOO5zopW42
gYgw5hGmODJtZfrmoqJeMAW4hJztdpCDdU2vuqcnuYe2lGsYprJvpvdopDUwFpshQ5ixYCmFKn4f
SvXKmVoAY+Rvzp/bHSaXUk+NQ1vOztCm/46+c3NiNNQg3x345omooJqqVFTufXMb+G5EhrJ+BEkV
/vEFFDTouPj1L9ZfJjjyFs9k3Da+TsFKMEkRKR9nZGhGMeiU+AeNUOmsmT73vGvR
--0000000000002034e6060b7a73b9--

