Return-Path: <netdev+bounces-237737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A70C4FCA0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0B004F88ED
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293FC364057;
	Tue, 11 Nov 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UeDV+va7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06952364030
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894785; cv=none; b=C/c8Uof5vDXWbTMCHbqr+B/Nb74ogEq95s3hoSKoiNQAfJYRE5F2Yj79sUXC4NUAbDuPMDBe7QgWYOPz+uHFOzJ/TQZAaqtFbKH0KwFjqUFUm/x+IL/jL2I0B32EmICIxnP1CHVU7/pLIbmtRQI1rNZtBQwrbUS4y6vyrtsXh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894785; c=relaxed/simple;
	bh=K2FSoGuvlJSKB87wcSn5V1wNVoLcL+oSCeK8Sjg4rys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG7T7PJvaIFpHE5MmxGKHr3RrdWOzDzu0IFE7RF10CYo3VJAXBCRT1lJUKQ9kfpifnuvxS1vZTWwmodF8c3roPWNmW7CsSRrPMBENxj7fz1j+OTz6OFv1pu0HqMqgUIfmQnnS0SsPL6rdooYnJgNxMC37QhH0gZHOUxeI+3M23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UeDV+va7; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5dbcc814b80so89161137.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894780; x=1763499580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rONH+mHxU+7n/URgcC6mVyOgTaF1ltIKNlpmdHCPnY=;
        b=U+rPBsCLZswVf6YHgv7wOO4B/8A5+PWocVHi9qYT5XvrFAM0L4jbq9TNMqNX+6AhOU
         75+uX+hZl2uaP1oQZwOQ7hHRMg6b2I9AUnBoINhfwiau6cMmDZL/cs3hT/03h7DQw0Fg
         xmG1yvHVDWeYxSbW7FVQ5r293IeyH8N0kBX4zoSQe4iAbbjQq58w/tNKII/gtPgiIgA2
         AbQbv36qWGy/jOE2N5GOA56kPqPdw4guOvsSKrkwA1bB/TOGnPQ6eIN2LpMrmbLiVxA9
         9yUoH1RkWE2198rg05waotdQwmwrZfkiQ3OGuutsvyoPF57+WgAZD6e8nVyBqvkEESAq
         xwIg==
X-Gm-Message-State: AOJu0Ywk5Z5uLRz82YcKIrEVc8EDu0buEbmvMHfev1DO2moAraPrd9CC
	kY9wtJb71ADqEX+Q7faWLIM7fS4vWWpQHYe3PoRyT0/Z/uFnQSrpp0nH9l8bQqPt+YInY5khtV/
	m5LpMrbF2aqb7SRqoiIAY/2P54eqfm6WaRfP70sY8+r18bNLRk7s9sUvTGDkY/InvOYHtr97O4R
	BhI7DSn7Bn9B9mjLmes55PnxY6rnkhpZ8E2xhWGujahrBUbUwOVxoypl27r3sWABW6SQDlzPmjT
	md0RHkdl9dMRwKwB8GP
X-Gm-Gg: ASbGncvs84heJqhi56Uli0Wx0enqVyN7jyafsDCMCNhbyWs1IKtmCr7hmWZwpBg26e7
	rzRoaRCM/zu5+92rfKSZzqYSWTdhrhzMojc9pxTU2P0WN2GE7QNMpd/ao/M9LufVJ4ywZp8vOje
	I/lD4xvnNzj/a+gwQvP8ZN5f2y8bqlc/VAqU2xsbA1tSa463c/OyB1w8qjoYWJc/U6TmibJk4FI
	PHki1zf8t3pC6IFccQwHxNPXvGqqIE/Q77nECDEtH7xbrgND65BPmeUbiL1HV0oNcX4d+p5FZKp
	owbz7iw2SP8tKe4tvvGKqb/a7WGr7KT7/x6Nn2gCNm8p1NIm/lQeWSeLSfXOZtYw6Pls0Qj0aUw
	QXP9y2oNbpu8kZ5mrHR97aSC5yo7I6YPUwJ8oUbYcwq5wv1DxZNNSfzgBgYMn7ny5+6RZX/Vu6s
	pnnNM9mc/FAQkXJ8AOWQ3to9cENvWc/K1/5o0tPjN9ugA=
X-Google-Smtp-Source: AGHT+IFQzQO+LECOYMbX26EEtAL3TYvaoXeRDggAg8/1BR1DJnwO78cmsrvr+LjxDhkwA4V9vMWkKMZ/HmjO
X-Received: by 2002:a05:6102:26d0:b0:5db:d22f:b9f5 with SMTP id ada2fe7eead31-5de07e05db7mr150410137.21.1762894779843;
        Tue, 11 Nov 2025 12:59:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-93737cc350fsm104890241.6.2025.11.11.12.59.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b8f8e1f1044so208720a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894778; x=1763499578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rONH+mHxU+7n/URgcC6mVyOgTaF1ltIKNlpmdHCPnY=;
        b=UeDV+va7VlOxHpJ7j0j3690yYZbACNAfRg+uB+fhDgMbeMsPrMQtYNXz381PR3805y
         PdMYJ7TV1Yl9fM8fLvP2zVlR170sBacEjLHtOJ5L547rWHeQtGogHjdHun/f9FwRWuUu
         OdNiS16buwVVsk7JEGp87VtmquuUR4fRbTsY0=
X-Received: by 2002:a05:6a20:7f98:b0:334:8ac9:bc5 with SMTP id adf61e73a8af0-3590ae3447emr777862637.36.1762894778380;
        Tue, 11 Nov 2025 12:59:38 -0800 (PST)
X-Received: by 2002:a05:6a20:7f98:b0:334:8ac9:bc5 with SMTP id adf61e73a8af0-3590ae3447emr777831637.36.1762894777896;
        Tue, 11 Nov 2025 12:59:37 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:37 -0800 (PST)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next 09/12] bng_en: Add ethtool link settings and capabilities support
Date: Wed, 12 Nov 2025 02:27:59 +0530
Message-ID: <20251111205829.97579-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Adds ethtool ops to query and configure link speed, duplex, autoneg,
report link status, and advertise lane support.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   2 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  25 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 818 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |   6 +
 4 files changed, 851 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 56cc97ca492..33b42408b1d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -224,6 +224,8 @@ struct bnge_dev {
 #define BNGE_PHY_FL_NO_FCS		PORT_PHY_QCAPS_RESP_FLAGS_NO_FCS
 #define BNGE_PHY_FL_SPEEDS2		\
 	(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
+#define BNGE_PHY_FL_NO_PAUSE		\
+	(PORT_PHY_QCAPS_RESP_FLAGS2_PAUSE_UNSUPPORTED << 8)
 
 	u32                     msg_enable;
 };
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 569371c1b4f..b985799051b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -11,6 +11,26 @@
 
 #include "bnge.h"
 #include "bnge_ethtool.h"
+#include "bnge_hwrm_lib.h"
+
+static int bnge_nway_reset(struct net_device *dev)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd))
+		return -EOPNOTSUPP;
+
+	if (!(bn->eth_link_info.autoneg & BNGE_AUTONEG_SPEED))
+		return -EINVAL;
+
+	if (netif_running(dev))
+		rc = bnge_hwrm_set_link_setting(bn, true);
+
+	return rc;
+}
+
 
 static void bnge_get_drvinfo(struct net_device *dev,
 			     struct ethtool_drvinfo *info)
@@ -24,7 +44,12 @@ static void bnge_get_drvinfo(struct net_device *dev,
 }
 
 static const struct ethtool_ops bnge_ethtool_ops = {
+	.cap_link_lanes_supported	= 1,
+	.get_link_ksettings	= bnge_get_link_ksettings,
+	.set_link_ksettings	= bnge_set_link_ksettings,
 	.get_drvinfo		= bnge_get_drvinfo,
+	.get_link		= bnge_get_link,
+	.nway_reset		= bnge_nway_reset,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index b4a5ed00db2..8e18b247650 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -7,6 +7,63 @@
 #include "bnge_link.h"
 #include "bnge_hwrm_lib.h"
 
+enum bnge_media_type {
+	BNGE_MEDIA_UNKNOWN = 0,
+	BNGE_MEDIA_TP,
+	BNGE_MEDIA_CR,
+	BNGE_MEDIA_SR,
+	BNGE_MEDIA_LR_ER_FR,
+	BNGE_MEDIA_KR,
+	BNGE_MEDIA_KX,
+	BNGE_MEDIA_X,
+	__BNGE_MEDIA_END,
+};
+
+static const enum bnge_media_type bnge_phy_types[] = {
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASECR] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR4] =  BNGE_MEDIA_KR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASELR] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASESR] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR2] = BNGE_MEDIA_KR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKX] = BNGE_MEDIA_KX,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR] = BNGE_MEDIA_KR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASET] = BNGE_MEDIA_TP,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASETE] = BNGE_MEDIA_TP,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR4] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR4] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR10] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR4] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR4] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASECR] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASESR] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASELR] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASEER] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR2] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR2] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR2] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR2] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER2] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR8] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR8] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR8] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER8] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASECR4] = BNGE_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASESR4] = BNGE_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASELR4] = BNGE_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_400G_BASEER4] = BNGE_MEDIA_LR_ER_FR,
+};
+
 u32 bnge_fw_to_ethtool_speed(u16 fw_link_speed)
 {
 	switch (fw_link_speed) {
@@ -469,3 +526,764 @@ void bnge_report_link(struct bnge_dev *bd)
 		netdev_err(bd->netdev, "NIC Link is Down\n");
 	}
 }
+
+static void bnge_get_ethtool_modes(struct bnge_net *bn,
+				   struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE)) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.supported);
+	}
+
+	if (link_info->support_auto_speeds || link_info->support_auto_speeds2 ||
+	    link_info->support_pam4_auto_speeds)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 lk_ksettings->link_modes.supported);
+
+	if (~elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+		return;
+
+	if (link_info->auto_pause_setting & BNGE_LINK_PAUSE_RX)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (hweight8(link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) == 1)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (link_info->lp_pause & BNGE_LINK_PAUSE_RX)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.lp_advertising);
+	if (hweight8(link_info->lp_pause & BNGE_LINK_PAUSE_BOTH) == 1)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.lp_advertising);
+}
+
+u32 bnge_get_link(struct net_device *dev)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	/* TODO: handle MF, VF, driver close case */
+	return BNGE_LINK_IS_UP(bn->bd);
+}
+
+static enum bnge_media_type
+bnge_get_media(struct bnge_link_info *link_info)
+{
+	switch (link_info->media_type) {
+	case PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP:
+		return BNGE_MEDIA_TP;
+	case PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC:
+		return BNGE_MEDIA_CR;
+	default:
+		if (link_info->phy_type < ARRAY_SIZE(bnge_phy_types))
+			return bnge_phy_types[link_info->phy_type];
+		return BNGE_MEDIA_UNKNOWN;
+	}
+}
+
+enum bnge_link_speed_indices {
+	BNGE_LINK_SPEED_UNKNOWN = 0,
+	BNGE_LINK_SPEED_50GB_IDX,
+	BNGE_LINK_SPEED_100GB_IDX,
+	BNGE_LINK_SPEED_200GB_IDX,
+	BNGE_LINK_SPEED_400GB_IDX,
+	BNGE_LINK_SPEED_800GB_IDX,
+	__BNGE_LINK_SPEED_END
+};
+
+static enum bnge_link_speed_indices bnge_fw_speed_idx(u16 speed)
+{
+	switch (speed) {
+	case BNGE_LINK_SPEED_50GB:
+	case BNGE_LINK_SPEED_50GB_PAM4:
+		return BNGE_LINK_SPEED_50GB_IDX;
+	case BNGE_LINK_SPEED_100GB:
+	case BNGE_LINK_SPEED_100GB_PAM4:
+	case BNGE_LINK_SPEED_100GB_PAM4_112:
+		return BNGE_LINK_SPEED_100GB_IDX;
+	case BNGE_LINK_SPEED_200GB:
+	case BNGE_LINK_SPEED_200GB_PAM4:
+	case BNGE_LINK_SPEED_200GB_PAM4_112:
+		return BNGE_LINK_SPEED_200GB_IDX;
+	case BNGE_LINK_SPEED_400GB:
+	case BNGE_LINK_SPEED_400GB_PAM4:
+	case BNGE_LINK_SPEED_400GB_PAM4_112:
+		return BNGE_LINK_SPEED_400GB_IDX;
+	case BNGE_LINK_SPEED_800GB:
+	case BNGE_LINK_SPEED_800GB_PAM4_112:
+		return BNGE_LINK_SPEED_800GB_IDX;
+	default: return BNGE_LINK_SPEED_UNKNOWN;
+	}
+}
+
+static const enum ethtool_link_mode_bit_indices
+bnge_link_modes[__BNGE_LINK_SPEED_END][BNGE_SIG_MODE_MAX][__BNGE_MEDIA_END] = {
+	[BNGE_LINK_SPEED_50GB_IDX] = {
+		[BNGE_SIG_MODE_PAM4] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+		},
+	},
+	[BNGE_LINK_SPEED_100GB_IDX] = {
+		[BNGE_SIG_MODE_NRZ] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+		},
+		[BNGE_SIG_MODE_PAM4] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+		},
+		[BNGE_SIG_MODE_PAM4_112] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_100000baseCR_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_100000baseLR_ER_FR_Full_BIT,
+		},
+	},
+	[BNGE_LINK_SPEED_200GB_IDX] = {
+		[BNGE_SIG_MODE_PAM4] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
+		},
+		[BNGE_SIG_MODE_PAM4_112] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_200000baseLR2_ER2_FR2_Full_BIT,
+		},
+	},
+	[BNGE_LINK_SPEED_400GB_IDX] = {
+		[BNGE_SIG_MODE_PAM4] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
+		},
+		[BNGE_SIG_MODE_PAM4_112] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_400000baseKR4_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_400000baseSR4_Full_BIT,
+			[BNGE_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
+		},
+	},
+	[BNGE_LINK_SPEED_800GB_IDX] = {
+		[BNGE_SIG_MODE_PAM4_112] = {
+			[BNGE_MEDIA_CR] = ETHTOOL_LINK_MODE_800000baseCR8_Full_BIT,
+			[BNGE_MEDIA_KR] = ETHTOOL_LINK_MODE_800000baseKR8_Full_BIT,
+			[BNGE_MEDIA_SR] = ETHTOOL_LINK_MODE_800000baseSR8_Full_BIT,
+		},
+	},
+};
+
+#define BNGE_LINK_MODE_UNKNOWN -1
+
+static enum ethtool_link_mode_bit_indices
+bnge_get_link_mode(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bd->link_info;
+	enum ethtool_link_mode_bit_indices link_mode;
+	enum bnge_link_speed_indices speed;
+	enum bnge_media_type media;
+	u8 sig_mode;
+
+	if (link_info->phy_link_status != BNGE_LINK_LINK)
+		return BNGE_LINK_MODE_UNKNOWN;
+
+	media = bnge_get_media(link_info);
+	if (BNGE_AUTO_MODE(link_info->auto_mode)) {
+		speed = bnge_fw_speed_idx(link_info->link_speed);
+		sig_mode = link_info->active_fec_sig_mode &
+			PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK;
+	} else {
+		speed = bnge_fw_speed_idx(elink_info->req_link_speed);
+		sig_mode = elink_info->req_signal_mode;
+	}
+	if (sig_mode >= BNGE_SIG_MODE_MAX)
+		return BNGE_LINK_MODE_UNKNOWN;
+
+	/* Note ETHTOOL_LINK_MODE_10baseT_Half_BIT == 0 is a legal Linux
+	 * link mode, but since no such devices exist, the zeroes in the
+	 * map can be conveniently used to represent unknown link modes.
+	 */
+	link_mode = bnge_link_modes[speed][sig_mode][media];
+	if (!link_mode)
+		return BNGE_LINK_MODE_UNKNOWN;
+
+	switch (link_mode) {
+	case ETHTOOL_LINK_MODE_100baseT_Full_BIT:
+		if (~link_info->duplex & BNGE_LINK_DUPLEX_FULL)
+			link_mode = ETHTOOL_LINK_MODE_100baseT_Half_BIT;
+		break;
+	case ETHTOOL_LINK_MODE_1000baseT_Full_BIT:
+		if (~link_info->duplex & BNGE_LINK_DUPLEX_FULL)
+			link_mode = ETHTOOL_LINK_MODE_1000baseT_Half_BIT;
+		break;
+	default:
+		break;
+	}
+
+	return link_mode;
+}
+
+static const u16 bnge_nrz_speed_masks[] = {
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEED_MSK_100GB,
+	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
+};
+
+static const u16 bnge_pam4_speed_masks[] = {
+	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_50GB,
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_100GB,
+	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_200GB,
+	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
+};
+
+static const u16 bnge_nrz_speeds2_masks[] = {
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB,
+	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
+};
+
+static const u16 bnge_pam4_speeds2_masks[] = {
+	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_SPEEDS2_MSK_50GB_PAM4,
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4,
+	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4,
+	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4,
+};
+
+static const u16 bnge_pam4_112_speeds2_masks[] = {
+	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112,
+	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112,
+	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112,
+	[BNGE_LINK_SPEED_800GB_IDX] = BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112,
+};
+
+static enum bnge_link_speed_indices
+bnge_encoding_speed_idx(u8 sig_mode, u16 phy_flags, u16 speed_msk)
+{
+	const u16 *speeds;
+	int idx, len;
+
+	switch (sig_mode) {
+	case BNGE_SIG_MODE_NRZ:
+		if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+			speeds = bnge_nrz_speeds2_masks;
+			len = ARRAY_SIZE(bnge_nrz_speeds2_masks);
+		} else {
+			speeds = bnge_nrz_speed_masks;
+			len = ARRAY_SIZE(bnge_nrz_speed_masks);
+		}
+		break;
+	case BNGE_SIG_MODE_PAM4:
+		if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+			speeds = bnge_pam4_speeds2_masks;
+			len = ARRAY_SIZE(bnge_pam4_speeds2_masks);
+		} else {
+			speeds = bnge_pam4_speed_masks;
+			len = ARRAY_SIZE(bnge_pam4_speed_masks);
+		}
+		break;
+	case BNGE_SIG_MODE_PAM4_112:
+		speeds = bnge_pam4_112_speeds2_masks;
+		len = ARRAY_SIZE(bnge_pam4_112_speeds2_masks);
+		break;
+	default:
+		return BNGE_LINK_SPEED_UNKNOWN;
+	}
+
+	for (idx = 0; idx < len; idx++) {
+		if (speeds[idx] == speed_msk)
+			return idx;
+	}
+
+	return BNGE_LINK_SPEED_UNKNOWN;
+}
+
+#define BNGE_FW_SPEED_MSK_BITS 16
+
+static void
+__bnge_get_ethtool_speeds(unsigned long fw_mask, enum bnge_media_type media,
+			  u8 sig_mode, u16 phy_flags, unsigned long *et_mask)
+{
+	enum ethtool_link_mode_bit_indices link_mode;
+	enum bnge_link_speed_indices speed;
+	u8 bit;
+
+	for_each_set_bit(bit, &fw_mask, BNGE_FW_SPEED_MSK_BITS) {
+		speed = bnge_encoding_speed_idx(sig_mode, phy_flags, 1 << bit);
+		if (!speed)
+			continue;
+
+		link_mode = bnge_link_modes[speed][sig_mode][media];
+		if (!link_mode)
+			continue;
+
+		linkmode_set_bit(link_mode, et_mask);
+	}
+}
+
+static void
+bnge_get_ethtool_speeds(unsigned long fw_mask, enum bnge_media_type media,
+			u8 sig_mode, u16 phy_flags, unsigned long *et_mask)
+{
+	if (media) {
+		__bnge_get_ethtool_speeds(fw_mask, media, sig_mode, phy_flags,
+					  et_mask);
+		return;
+	}
+
+	/* list speeds for all media if unknown */
+	for (media = 1; media < __BNGE_MEDIA_END; media++)
+		__bnge_get_ethtool_speeds(fw_mask, media, sig_mode, phy_flags,
+					  et_mask);
+}
+
+static void
+bnge_get_all_ethtool_support_speeds(struct bnge_dev *bd,
+				    enum bnge_media_type media,
+				    struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_link_info *link_info = &bd->link_info;
+	u16 sp_nrz, sp_pam4, sp_pam4_112 = 0;
+	u16 phy_flags = bd->phy_flags;
+
+	if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		sp_nrz = link_info->support_speeds2;
+		sp_pam4 = link_info->support_speeds2;
+		sp_pam4_112 = link_info->support_speeds2;
+	} else {
+		sp_nrz = link_info->support_speeds;
+		sp_pam4 = link_info->support_pam4_speeds;
+	}
+	bnge_get_ethtool_speeds(sp_nrz, media, BNGE_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.supported);
+	bnge_get_ethtool_speeds(sp_pam4, media, BNGE_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.supported);
+	bnge_get_ethtool_speeds(sp_pam4_112, media, BNGE_SIG_MODE_PAM4_112,
+				phy_flags, lk_ksettings->link_modes.supported);
+}
+
+static void
+bnge_get_all_ethtool_adv_speeds(struct bnge_net *bn,
+				enum bnge_media_type media,
+				struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	u16 sp_nrz, sp_pam4, sp_pam4_112 = 0;
+	u16 phy_flags = bd->phy_flags;
+
+	sp_nrz = elink_info->advertising;
+	if (phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		sp_pam4 = elink_info->advertising;
+		sp_pam4_112 = elink_info->advertising;
+	} else {
+		sp_pam4 = elink_info->advertising_pam4;
+	}
+	bnge_get_ethtool_speeds(sp_nrz, media, BNGE_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.advertising);
+	bnge_get_ethtool_speeds(sp_pam4, media, BNGE_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.advertising);
+	bnge_get_ethtool_speeds(sp_pam4_112, media, BNGE_SIG_MODE_PAM4_112,
+				phy_flags, lk_ksettings->link_modes.advertising);
+}
+
+static void
+bnge_get_all_ethtool_lp_speeds(struct bnge_dev *bd,
+			       enum bnge_media_type media,
+			       struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_link_info *link_info = &bd->link_info;
+	u16 phy_flags = bd->phy_flags;
+
+	bnge_get_ethtool_speeds(link_info->lp_auto_link_speeds, media,
+				BNGE_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.lp_advertising);
+	bnge_get_ethtool_speeds(link_info->lp_auto_pam4_link_speeds, media,
+				BNGE_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.lp_advertising);
+}
+
+static void bnge_update_speed(u32 *delta, bool installed_media, u16 *speeds,
+			      u16 speed_msk, const unsigned long *et_mask,
+			      enum ethtool_link_mode_bit_indices mode)
+{
+	bool mode_desired = linkmode_test_bit(mode, et_mask);
+
+	if (!mode)
+		return;
+
+	/* enabled speeds for installed media should override */
+	if (installed_media && mode_desired) {
+		*speeds |= speed_msk;
+		*delta |= speed_msk;
+		return;
+	}
+
+	/* many to one mapping, only allow one change per fw_speed bit */
+	if (!(*delta & speed_msk) && (mode_desired == !(*speeds & speed_msk))) {
+		*speeds ^= speed_msk;
+		*delta |= speed_msk;
+	}
+}
+
+static void bnge_set_ethtool_speeds(struct bnge_net *bn,
+				    const unsigned long *et_mask)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	u16 const *sp_msks, *sp_pam4_msks, *sp_pam4_112_msks;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+	enum bnge_media_type media = bnge_get_media(link_info);
+	u16 *adv, *adv_pam4, *adv_pam4_112 = NULL;
+	u32 delta_pam4_112 = 0;
+	u32 delta_pam4 = 0;
+	u32 delta_nrz = 0;
+	int i, m;
+
+	adv = &elink_info->advertising;
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		adv_pam4 = &elink_info->advertising;
+		adv_pam4_112 = &elink_info->advertising;
+		sp_msks = bnge_nrz_speeds2_masks;
+		sp_pam4_msks = bnge_pam4_speeds2_masks;
+		sp_pam4_112_msks = bnge_pam4_112_speeds2_masks;
+	} else {
+		adv_pam4 = &elink_info->advertising_pam4;
+		sp_msks = bnge_nrz_speed_masks;
+		sp_pam4_msks = bnge_pam4_speed_masks;
+	}
+	for (i = 1; i < __BNGE_LINK_SPEED_END; i++) {
+		/* accept any legal media from user */
+		for (m = 1; m < __BNGE_MEDIA_END; m++) {
+			bnge_update_speed(&delta_nrz, m == media,
+					  adv, sp_msks[i], et_mask,
+					  bnge_link_modes[i][BNGE_SIG_MODE_NRZ][m]);
+			bnge_update_speed(&delta_pam4, m == media,
+					  adv_pam4, sp_pam4_msks[i], et_mask,
+					  bnge_link_modes[i][BNGE_SIG_MODE_PAM4][m]);
+			if (!adv_pam4_112)
+				continue;
+
+			bnge_update_speed(&delta_pam4_112, m == media,
+					  adv_pam4_112, sp_pam4_112_msks[i], et_mask,
+					  bnge_link_modes[i][BNGE_SIG_MODE_PAM4_112][m]);
+		}
+	}
+}
+
+static void
+bnge_fw_to_ethtool_advertised_fec(struct bnge_link_info *link_info,
+				  struct ethtool_link_ksettings *lk_ksettings)
+{
+	u16 fec_cfg = link_info->fec_cfg;
+
+	if ((fec_cfg & BNGE_FEC_NONE) || !(fec_cfg & BNGE_FEC_AUTONEG)) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT,
+				 lk_ksettings->link_modes.advertising);
+		return;
+	}
+	if (fec_cfg & BNGE_FEC_ENC_BASE_R)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_BASER_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (fec_cfg & BNGE_FEC_ENC_RS)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_RS_BIT,
+				 lk_ksettings->link_modes.advertising);
+	if (fec_cfg & BNGE_FEC_ENC_LLRS)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_LLRS_BIT,
+				 lk_ksettings->link_modes.advertising);
+}
+
+static void
+bnge_fw_to_ethtool_support_fec(struct bnge_link_info *link_info,
+			       struct ethtool_link_ksettings *lk_ksettings)
+{
+	u16 fec_cfg = link_info->fec_cfg;
+
+	if (fec_cfg & BNGE_FEC_NONE) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT,
+				 lk_ksettings->link_modes.supported);
+		return;
+	}
+	if (fec_cfg & BNGE_FEC_ENC_BASE_R_CAP)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_BASER_BIT,
+				 lk_ksettings->link_modes.supported);
+	if (fec_cfg & BNGE_FEC_ENC_RS_CAP)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_RS_BIT,
+				 lk_ksettings->link_modes.supported);
+	if (fec_cfg & BNGE_FEC_ENC_LLRS_CAP)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_LLRS_BIT,
+				 lk_ksettings->link_modes.supported);
+}
+
+static void bnge_get_default_speeds(struct bnge_net *bn,
+				    struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct ethtool_link_settings *base = &lk_ksettings->base;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	if (link_info->link_state == BNGE_LINK_STATE_UP) {
+		base->speed = bnge_fw_to_ethtool_speed(link_info->link_speed);
+		base->duplex = DUPLEX_HALF;
+		if (link_info->duplex & BNGE_LINK_DUPLEX_FULL)
+			base->duplex = DUPLEX_FULL;
+		lk_ksettings->lanes = link_info->active_lanes;
+	} else if (!elink_info->autoneg) {
+		base->speed = bnge_fw_to_ethtool_speed(elink_info->req_link_speed);
+		base->duplex = DUPLEX_HALF;
+		if (elink_info->req_duplex == BNGE_LINK_DUPLEX_FULL)
+			base->duplex = DUPLEX_FULL;
+	}
+}
+
+int bnge_get_link_ksettings(struct net_device *dev,
+			    struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct ethtool_link_settings *base = &lk_ksettings->base;
+	enum ethtool_link_mode_bit_indices link_mode;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	enum bnge_media_type media;
+
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, lp_advertising);
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, advertising);
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, supported);
+	base->duplex = DUPLEX_UNKNOWN;
+	base->speed = SPEED_UNKNOWN;
+	link_info = &bd->link_info;
+
+	mutex_lock(&bd->link_lock);
+	bnge_get_ethtool_modes(bn, lk_ksettings);
+	media = bnge_get_media(link_info);
+	bnge_get_all_ethtool_support_speeds(bd, media, lk_ksettings);
+	bnge_fw_to_ethtool_support_fec(link_info, lk_ksettings);
+	link_mode = bnge_get_link_mode(bn);
+	if (link_mode != BNGE_LINK_MODE_UNKNOWN)
+		ethtool_params_from_link_mode(lk_ksettings, link_mode);
+	else
+		bnge_get_default_speeds(bn, lk_ksettings);
+
+	if (bn->eth_link_info.autoneg) {
+		bnge_fw_to_ethtool_advertised_fec(link_info, lk_ksettings);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 lk_ksettings->link_modes.advertising);
+		base->autoneg = AUTONEG_ENABLE;
+		bnge_get_all_ethtool_adv_speeds(bn, media, lk_ksettings);
+		if (link_info->phy_link_status == BNGE_LINK_LINK)
+			bnge_get_all_ethtool_lp_speeds(bd, media, lk_ksettings);
+	} else {
+		base->autoneg = AUTONEG_DISABLE;
+	}
+
+	base->port = PORT_NONE;
+	if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP) {
+		base->port = PORT_TP;
+		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+				 lk_ksettings->link_modes.advertising);
+	} else {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 lk_ksettings->link_modes.advertising);
+
+		if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC)
+			base->port = PORT_DA;
+		else
+			base->port = PORT_FIBRE;
+	}
+	base->phy_address = link_info->phy_addr;
+	mutex_unlock(&bd->link_lock);
+
+	return 0;
+}
+
+static int
+bnge_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bd->link_info;
+	u16 support_pam4_spds = link_info->support_pam4_speeds;
+	u16 support_spds2 = link_info->support_speeds2;
+	u16 support_spds = link_info->support_speeds;
+	u8 sig_mode = BNGE_SIG_MODE_NRZ;
+	u32 lanes_needed = 1;
+	u16 fw_speed = 0;
+
+	switch (ethtool_speed) {
+	case SPEED_50000:
+		if (((support_spds & BNGE_LINK_SPEED_MSK_50GB) ||
+		     (support_spds2 & BNGE_LINK_SPEEDS2_MSK_50GB)) &&
+		    lanes != 1) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_50GB;
+			lanes_needed = 2;
+		} else if (support_pam4_spds & BNGE_LINK_PAM4_SPEED_MSK_50GB) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_50GB;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		} else if (support_spds2 & BNGE_LINK_SPEEDS2_MSK_50GB_PAM4) {
+			fw_speed = BNGE_LINK_SPEED_50GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+		}
+		break;
+	case SPEED_100000:
+		if (((support_spds & BNGE_LINK_SPEED_MSK_100GB) ||
+		     (support_spds2 & BNGE_LINK_SPEEDS2_MSK_100GB)) &&
+		    lanes != 2 && lanes != 1) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100GB;
+			lanes_needed = 4;
+		} else if (support_pam4_spds & BNGE_LINK_PAM4_SPEED_MSK_100GB) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_100GB;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+			lanes_needed = 2;
+		} else if ((support_spds2 & BNGE_LINK_SPEEDS2_MSK_100GB_PAM4) &&
+			   lanes != 1) {
+			fw_speed = BNGE_LINK_SPEED_100GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+			lanes_needed = 2;
+		} else if (support_spds2 & BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112) {
+			fw_speed = BNGE_LINK_SPEED_100GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+		}
+		break;
+	case SPEED_200000:
+		if (support_pam4_spds & BNGE_LINK_PAM4_SPEED_MSK_200GB) {
+			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_200GB;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+			lanes_needed = 4;
+		} else if ((support_spds2 & BNGE_LINK_SPEEDS2_MSK_200GB_PAM4) &&
+			   lanes != 2) {
+			fw_speed = BNGE_LINK_SPEED_200GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+			lanes_needed = 4;
+		} else if (support_spds2 & BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112) {
+			fw_speed = BNGE_LINK_SPEED_200GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+			lanes_needed = 2;
+		}
+		break;
+	case SPEED_400000:
+		if ((support_spds2 & BNGE_LINK_SPEEDS2_MSK_400GB_PAM4) &&
+		    lanes != 4) {
+			fw_speed = BNGE_LINK_SPEED_400GB_PAM4;
+			sig_mode = BNGE_SIG_MODE_PAM4;
+			lanes_needed = 8;
+		} else if (support_spds2 & BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112) {
+			fw_speed = BNGE_LINK_SPEED_400GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+			lanes_needed = 4;
+		}
+		break;
+	case SPEED_800000:
+		if (support_spds2 & BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112) {
+			fw_speed = BNGE_LINK_SPEED_800GB_PAM4_112;
+			sig_mode = BNGE_SIG_MODE_PAM4_112;
+			lanes_needed = 8;
+		}
+	}
+
+	if (!fw_speed) {
+		netdev_err(dev, "unsupported speed!\n");
+		return -EINVAL;
+	}
+
+	if (lanes && lanes != lanes_needed) {
+		netdev_err(dev, "unsupported number of lanes for speed\n");
+		return -EINVAL;
+	}
+
+	if (elink_info->req_link_speed == fw_speed &&
+	    elink_info->req_signal_mode == sig_mode &&
+	    elink_info->autoneg == 0)
+		return -EALREADY;
+
+	elink_info->req_link_speed = fw_speed;
+	elink_info->req_signal_mode = sig_mode;
+	elink_info->req_duplex = BNGE_LINK_DUPLEX_FULL;
+	elink_info->autoneg = 0;
+	elink_info->advertising = 0;
+	elink_info->advertising_pam4 = 0;
+
+	return 0;
+}
+
+int bnge_set_link_ksettings(struct net_device *dev,
+			    const struct ethtool_link_ksettings *lk_ksettings)
+{
+	const struct ethtool_link_settings *base = &lk_ksettings->base;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info = &bd->link_info;
+	bool set_pause = false;
+	u32 speed, lanes = 0;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&bd->link_lock);
+	if (base->autoneg == AUTONEG_ENABLE) {
+		bnge_set_ethtool_speeds(bn,
+					lk_ksettings->link_modes.advertising);
+		elink_info->autoneg |= BNGE_AUTONEG_SPEED;
+		if (!elink_info->advertising && !elink_info->advertising_pam4) {
+			elink_info->advertising = link_info->support_auto_speeds;
+			elink_info->advertising_pam4 =
+				link_info->support_pam4_auto_speeds;
+		}
+		/* any change to autoneg will cause link change, therefore the
+		 * driver should put back the original pause setting in autoneg
+		 */
+		if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+			set_pause = true;
+	} else {
+		u8 phy_type = link_info->phy_type;
+
+		if (phy_type == PORT_PHY_QCFG_RESP_PHY_TYPE_BASET  ||
+		    phy_type == PORT_PHY_QCFG_RESP_PHY_TYPE_BASETE ||
+		    link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP) {
+			netdev_err(dev, "10GBase-T devices must autoneg\n");
+			rc = -EINVAL;
+			goto set_setting_exit;
+		}
+		if (base->duplex == DUPLEX_HALF) {
+			netdev_err(dev, "HALF DUPLEX is not supported!\n");
+			rc = -EINVAL;
+			goto set_setting_exit;
+		}
+		speed = base->speed;
+		lanes = lk_ksettings->lanes;
+		rc = bnge_force_link_speed(dev, speed, lanes);
+		if (rc) {
+			if (rc == -EALREADY)
+				rc = 0;
+			goto set_setting_exit;
+		}
+	}
+
+	if (netif_running(dev))
+		rc = bnge_hwrm_set_link_setting(bn, set_pause);
+
+set_setting_exit:
+	mutex_unlock(&bd->link_lock);
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
index 65da27c510b..995ca731879 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -182,4 +182,10 @@ void bnge_init_ethtool_link_settings(struct bnge_net *bn);
 u32 bnge_fw_to_ethtool_speed(u16 fw_link_speed);
 int bnge_probe_phy(struct bnge_net *bd, bool fw_dflt);
 bool bnge_phy_qcaps_no_speed(struct hwrm_port_phy_qcaps_output *resp);
+int bnge_set_link_ksettings(struct net_device *dev,
+			    const struct ethtool_link_ksettings *lk_ksettings);
+int bnge_get_link_ksettings(struct net_device *dev,
+			    struct ethtool_link_ksettings *lk_ksettings);
+u32 bnge_get_link(struct net_device *dev);
+u16 bnge_get_force_speed(struct bnge_link_info *link_info);
 #endif /* _BNGE_LINK_H_ */
-- 
2.47.3


