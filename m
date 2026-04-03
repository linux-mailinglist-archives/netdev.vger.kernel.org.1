Return-Path: <netdev+bounces-274923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DlFGPNuz2kTwQYAu9opvQ
	(envelope-from <netdev+bounces-274923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:40:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C45D391CC7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFC96303B049
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7A37D10E;
	Fri,  3 Apr 2026 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eZOduybr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293A21FF21
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201911; cv=none; b=kYnZ+H/plAR9PYkwbP5wSprDWUxCk2R6NIUjuaq5pOytcNSYUP89toKNz8kEwSBDPS64Ipwt7BeA21ymKJ5Oh++rLNJOzHVLr1qhOH6cwDg/1wO44CnmL2GyIxA9/UqEOkMQGql2h0vfDzQxS4SBfojh8VoTuXO934NVkB4K8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201911; c=relaxed/simple;
	bh=VrDAR49IVycPOe7piWEfXsLgfQfX9bhGR7zSuE3NSoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXVPXkkmIphoNCyNBidvp5jVxje6MUeDdh90oiXJLfK8fMUylR3wZ5lO4kLBh3GHnd7bCS6i2WOePx97Q1DNdly19//uorKH3VoJH5WJapLPTl+e23oj5I0NiJGs0f/NqLK6GxBBr8ZLyHorw5vPeR7AFx8tmvAsptj7R3sKyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eZOduybr; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso7676475ad.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201909; x=1775806709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2P7lgtvNOf8Os/zH65RPtJhaLvNMqNntscgZ8Xa5co=;
        b=ftUHw3Q/Fza0LDE8hKOmpA2kI41RmdmoyNg2MALPJJACVYw+pFHi3EFX+zKzd1Qx+l
         MNCJDJy9ty7h/lCA4TJQbNWOnLvDwq9071ZPcmV6S4Ho1iF++8Hhzl56jlXI0TJASuMl
         hFl3dy7uDFS9AJulJHApim2xsTPX+VGuRWuZqeOLXbWgGGPD7mx2C+DihHtiR0G3VhLZ
         ktECYttW7plEIMZ7UuGFCsW5NTzm5xFhrwUiNQxr9GPohHBEnEfrE8dLjKTzQA6NCqUu
         gJih44YmGUYIIba+XImSDaABvx0Mtdc8lbW/pppiQ3KvgogJqsg3n3glBM7tSRWV1uw6
         IOcg==
X-Gm-Message-State: AOJu0Yx9Jrt/R1NUSQxotRFo47PZW+/O6w3A+gBhv7o0Fm2chFpQqd3s
	VoZ6eLEAvBoclwAzDX0sSFrYMo/Qgxn6HHwDg22LdKkSIiSz1uN8s9QV4ihJ3HJC0bgMMlounLr
	P2PeXh3+IB+YDyPJoDwLFAcBif3VhQVIdgYrPrF/UdDIzy6/y951VnCYX5mPP0NUAXeh+uZSv0E
	NUL7M9piyZbpsMPpOp/z0vdELxbbU2tFQgqhk5Jbx4pucHSaV9ATE29esKxEoxH/4ldMjzZwqqJ
	Sbquv9teFHJA7FM9w==
X-Gm-Gg: AeBDievh+/iPAW8r42dRpAhIFJJfQLv5LpFLLBtwqb1Y1834pBZ93S4H0VBFoZRVQdJ
	geEQ46NaSQvMI/6WN6oZv13JgAJXGc6FPpLv0yHkAwueWAp/IPBKfHj8Z4BGr9/GRG3Xtq2U83a
	d6bfXirVMbZiAHQ8X83ErzKbN+alir9yOJYFMCJG1u6wjOdjcmGYn5uL05DX8OhgDSgBu49LJqD
	imCvy1oSCYLIv8/4bFzc+KsCFXw5RvX1gUT50OEBZ/C/5+zQ2sqRHkeBVx1JgxDN7H/Bik+s3G4
	sXZzsktKOtw3zz0ZO0FaexFQS5v/CINttXaUHuTR4LqIWuaCrBRWbHVi/puoZRPULUND4fjvxET
	Cel37o1U9B5O+tiLqOBDjLrpqypDy0hVROQEpR27fM+vjOwgZIWwRPKaDEe33jWW9OVUGxxV3zz
	TcNXB/foUxi/YPhqb85vGmPdd0NIWuFJytkG8PdIJHEilrhlznoXoB88fECS3RLEk=
X-Received: by 2002:a17:903:b45:b0:2b2:54c1:2067 with SMTP id d9443c01a7336-2b2816f3dd3mr23087225ad.21.1775201909095;
        Fri, 03 Apr 2026 00:38:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2748d8d48sm3800845ad.39.2026.04.03.00.38.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 00:38:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35449510446so1937867a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775201907; x=1775806707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2P7lgtvNOf8Os/zH65RPtJhaLvNMqNntscgZ8Xa5co=;
        b=eZOduybrP1jPwZPG/F6GQvFDnkGj5cRpAUvuagl24Cwm7SBPWP+DBHDpp11B5KN085
         pmT6LtVt8GaAd8EDi2BBpWPwU1JQWi4+5Q3hkeacP/MqyLg/lkrHEYD7ijY8FK4bZvJb
         Mh7nWtmzJitrrsQlmajJ54FbUFxDXZfLau5Xw=
X-Received: by 2002:a17:90b:48c6:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-35de697359emr1800813a91.18.1775201907342;
        Fri, 03 Apr 2026 00:38:27 -0700 (PDT)
X-Received: by 2002:a17:90b:48c6:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-35de697359emr1800796a91.18.1775201906882;
        Fri, 03 Apr 2026 00:38:26 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm13124901a91.10.2026.04.03.00.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:38:26 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v11 04/10] bng_en: implement ethtool pauseparam operations
Date: Fri,  3 Apr 2026 13:07:18 +0530
Message-ID: <20260403073724.194360-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274923-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C45D391CC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 63 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 45 +++++++++----
 2 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 6bb74a84ea03..424bf2d6721c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -46,6 +46,67 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
 }
 
+static void bnge_get_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *epause)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	if (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE) {
+		epause->autoneg = 0;
+		epause->rx_pause = 0;
+		epause->tx_pause = 0;
+		return;
+	}
+
+	epause->autoneg = !!(bn->eth_link_info.autoneg &
+			     BNGE_AUTONEG_FLOW_CTRL);
+	epause->rx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_RX);
+	epause->tx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_TX);
+}
+
+static int bnge_set_pauseparam(struct net_device *dev,
+			       struct ethtool_pauseparam *epause)
+{
+	struct bnge_ethtool_link_info old_elink_info, *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd) || (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+		return -EOPNOTSUPP;
+
+	elink_info = &bn->eth_link_info;
+	old_elink_info = *elink_info;
+
+	if (epause->autoneg) {
+		if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED))
+			return -EINVAL;
+
+		elink_info->autoneg |= BNGE_AUTONEG_FLOW_CTRL;
+	} else {
+		if (elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+			elink_info->force_link_chng = true;
+		elink_info->autoneg &= ~BNGE_AUTONEG_FLOW_CTRL;
+	}
+
+	elink_info->req_flow_ctrl = 0;
+	if (epause->rx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_RX;
+	if (epause->tx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_TX;
+
+	if (netif_running(dev)) {
+		rc = bnge_hwrm_set_pause(bn);
+		if (rc)
+			*elink_info = old_elink_info;
+	}
+
+	return rc;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -53,6 +114,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.get_drvinfo		= bnge_get_drvinfo,
 	.get_link		= bnge_get_link,
 	.nway_reset		= bnge_nway_reset,
+	.get_pauseparam		= bnge_get_pauseparam,
+	.set_pauseparam		= bnge_set_pauseparam,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index d8236a5daef2..7751bf07740f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -302,6 +302,8 @@ int bnge_update_phy_setting(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	bool update_pause = false;
 	bool update_link = false;
+	bool hw_pause_autoneg;
+	bool pause_autoneg;
 	int rc;
 
 	link_info = &bd->link_info;
@@ -313,24 +315,41 @@ int bnge_update_phy_setting(struct bnge_net *bn)
 		return rc;
 	}
 
-	if ((elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
-	    (link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) !=
-	    elink_info->req_flow_ctrl)
+	pause_autoneg = !!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL);
+	hw_pause_autoneg = !!(link_info->auto_pause_setting &
+			      PORT_PHY_QCFG_RESP_AUTO_PAUSE_AUTONEG_PAUSE);
+
+	/* Check if pause autonegotiation state has changed */
+	if (pause_autoneg != hw_pause_autoneg) {
 		update_pause = true;
-	if (!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
-	    link_info->force_pause_setting != elink_info->req_flow_ctrl)
+	} else if (pause_autoneg) {
+		/* If pause autoneg is enabled, check if the
+		 * requested RX/TX bits changed
+		 */
+		if ((link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) !=
+		    elink_info->req_flow_ctrl)
+			update_pause = true;
+	} else {
+		/* If pause autoneg is disabled, check if the
+		 * forced RX/TX bits changed
+		 */
+		if (link_info->force_pause_setting != elink_info->req_flow_ctrl)
+			update_pause = true;
+	}
+
+	/* Force update if link change is requested */
+	if (elink_info->force_link_chng)
 		update_pause = true;
+
+	/* Check if link speed or duplex settings have changed */
 	if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED)) {
-		if (BNGE_AUTO_MODE(link_info->auto_mode))
-			update_link = true;
-		if (bnge_force_speed_updated(bn))
-			update_link = true;
-		if (elink_info->req_duplex != link_info->duplex_setting)
+		if (BNGE_AUTO_MODE(link_info->auto_mode) ||
+		    bnge_force_speed_updated(bn) ||
+		    elink_info->req_duplex != link_info->duplex_setting)
 			update_link = true;
 	} else {
-		if (link_info->auto_mode == BNGE_LINK_AUTO_NONE)
-			update_link = true;
-		if (bnge_auto_speed_updated(bn))
+		if (link_info->auto_mode == BNGE_LINK_AUTO_NONE ||
+		    bnge_auto_speed_updated(bn))
 			update_link = true;
 	}
 
-- 
2.47.3


