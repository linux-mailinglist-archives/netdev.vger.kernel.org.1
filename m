Return-Path: <netdev+bounces-248244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB7D05A0D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B932A3032886
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B531281F;
	Thu,  8 Jan 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f7hecKoS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C331AABF
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897376; cv=none; b=WdweEJJ1HU03LN5vlHUEhiE7KuFUOe4OYjMhSMzstPI6LTZMTwkxZU6ww+ahAHi7nXuUOueEWH92rW4WArUUK2C/KVIiRuSHJjZZ6Wo1QAXoHvMiJjA/O+NM+AEJMc6imCA48y9Cw4teijVtAUQbdjshgHnDpc7jT9UMqwg41P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897376; c=relaxed/simple;
	bh=zE649Te+zguNGBvzccddz/Vtc0M1XkVlVlMqurGKLmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1pxdJFUZQx8Ach360z17zqLL4DyAySpgs8nTLPPKqQLvuforzg9SR/54dHW0hiCQcU0uhfcPLrqQyOAH7/6YWuekNzmhSNBr7JqocvoKFoiYFaHiKQBIT62tdo8qoDhLoQCgBTI7PGjlaRzA/46MRI1J9JbXGjAEWY8GG8r0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f7hecKoS; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-3fff664b610so145983fac.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897374; x=1768502174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iU4MK5rHwbECPAWENKqYr53MSdOG7vBvHFQwnp4hfQ=;
        b=aHeD8oMrfej5/kK1X7Jkhp4tmSmsSD4J8M67ea3+DLg/KDKexkOsh2Uk/7MaOURzHv
         iii3hst0g+zFmQk27yvZ44dFnYa98yTFUAONp9JVL5quN/f6p/vWMlfq+8Y3QFXi6k54
         dGZoNgK9vblSl5zaH69ZnGvhSfp4DbCQyUaysNweys84KY+xrfm5in6N25MCi2z5BExz
         lmP8fVqZ3nw6kdmlMtLGwRNqONIt9mT6nn9YjOT6LbSiGLtERhPRfDpLlA5HtkwJFGCd
         trxXhBekcDepDbnDnhhAHgkAhMdh/WJRjkk9G/AbEaG+hte0IF1bT4vQBONqJ5E51K5W
         CO2A==
X-Gm-Message-State: AOJu0YxROEUb77swKU8WuJj6T2FTXKRaM2/NUNiWXwGm4SUPOj+K4Of8
	OZ4fNU1pC7I17uz4mp3t26QZ6qHrQ7bEJjtIEljorIYzn7CvPg20sDu9/wfQCulzdHLF78TGmZw
	aWcCWJ4Ab8btvB//U68wn+0/iW42n8yvEhRQxMIV788NGkUxh2NELxiNq5Q4L1LRybuWfOu6y2g
	0AXj349NpFmWVxA/HLbGwKwOwPdlYbg6Jl3pXIKly+Eu4bcdPM4fNym+6zarktp/X/EychdC5l7
	0yekVwMLBc=
X-Gm-Gg: AY/fxX4UnXJOH543Pl9JI84S39actsrwxVG0XdIlTaemraD21x6/rIE9NIBXiWi7vAZ
	u8yvUzh9E+jV9AywqLguWMdoRNENEOE5dzDehhVJCFQg4+RmPpClA0PZKGWu2U/kumarsWZD6lB
	fqrxeUS3K6JzYlwAPkw+59TwrSuDgRXm/io0LFP1db/MgRBoxAfGZbr1X+33MXQ/x+gnduTVFgr
	h+L946GA7utqyZTrgztcBtkilwK6IgbbQKa20srC4latEnxxSqLJTTJ9BIihQP3K44F7oUHtNCV
	JSRStkjuMrKwycdISp0qdNgBZRqvHdbWC5ePKp9cZb9eV4oA+3R2ivbIUz65wk9b74xS+Xq37Xc
	2yhfWehoYPSGVtT0sUl5y2wnlorX6iWgtMZnnyx8IABThmzlXipyZ0evZQcOH+0iEr7We54jj/p
	+xdAByvSgjd3goida1nUggY/Mgj7Qym0Ju+sE7aXH1Gv193a8=
X-Google-Smtp-Source: AGHT+IELa96aZMEKtUUMsUkfaX7tvXpeyqvqYV6SgBzBKMkecwL1qpeQkhAe7zD9sr0apugVDbvzWzp90i0P
X-Received: by 2002:a05:6870:9627:b0:3f6:1f08:edeb with SMTP id 586e51a60fabf-3ffc0c0637bmr3445292fac.48.1767897373834;
        Thu, 08 Jan 2026 10:36:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa50f6dc7sm995663fac.18.2026.01.08.10.36.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:36:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0995fa85so104794931cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767897373; x=1768502173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iU4MK5rHwbECPAWENKqYr53MSdOG7vBvHFQwnp4hfQ=;
        b=f7hecKoSXHU1jcOzJVn1N80tScB5OJqm0Kq4C73WOyTUthmq9n+58G1LP/AxBuLyz7
         XQ52TPxr7UUCFCaRAVwbHjHENNHK2Zd6dm2xKoqqUCL4EMTLJhf6kh7l9vY6onCyn/oL
         BUrFZ7Y3NXyC4Ugg/Gw+MCqHtFV6maT7FRGqQ=
X-Received: by 2002:a05:622a:4d0c:b0:4f4:d928:54c6 with SMTP id d75a77b69052e-4ffb484a748mr123636361cf.5.1767897372762;
        Thu, 08 Jan 2026 10:36:12 -0800 (PST)
X-Received: by 2002:a05:622a:4d0c:b0:4f4:d928:54c6 with SMTP id d75a77b69052e-4ffb484a748mr123635951cf.5.1767897372366;
        Thu, 08 Jan 2026 10:36:12 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c2897sm15973721cf.32.2026.01.08.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:36:11 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 6/6] bnxt_en: Implement ethtool_ops -> get_link_ext_state()
Date: Thu,  8 Jan 2026 10:35:21 -0800
Message-ID: <20260108183521.215610-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260108183521.215610-1-michael.chan@broadcom.com>
References: <20260108183521.215610-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Map the link_down_reason from the FW to the ethtool link_ext_state
when it is available.  Also log it to the link down dmesg when it is
available.  Add 2 new link_ext_state enums to the UAPI:

ETHTOOL_LINK_EXT_STATE_OTP_SPEED_VIOLATION
ETHTOOL_LINK_EXT_STATE_BMC_REQUEST_DOWN

to cover OTP (one-time-programmable) speed restrictions and
BMC (Baseboard management controller) forcing the link down.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Add new UAPIs, remove spurious semi-colon, remove an invalid
TX_LASER_DISABLE reason. 

v1: https://lore.kernel.org/netdev/20260105215833.46125-7-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 ++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 35 +++++++++++++++++++
 include/uapi/linux/ethtool.h                  |  2 ++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9efdc382ebd7..239bc771b71c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11906,6 +11906,26 @@ static char *bnxt_report_fec(struct bnxt_link_info *link_info)
 	}
 }
 
+static char *bnxt_link_down_reason(struct bnxt_link_info *link_info)
+{
+	u8 reason = link_info->link_down_reason;
+
+	/* Multiple bits can be set, we report 1 bit only in order of
+	 * priority.
+	 */
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF)
+		return "(Remote fault)";
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_OTP_SPEED_VIOLATION)
+		return "(OTP Speed limit violation)";
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_CABLE_REMOVED)
+		return "(Cable removed)";
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_MODULE_FAULT)
+		return "(Module fault)";
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_BMC_REQUEST)
+		return "(BMC request down)";
+	return "";
+}
+
 void bnxt_report_link(struct bnxt *bp)
 {
 	if (BNXT_LINK_IS_UP(bp)) {
@@ -11963,8 +11983,10 @@ void bnxt_report_link(struct bnxt *bp)
 				    (fec & BNXT_FEC_AUTONEG) ? "on" : "off",
 				    bnxt_report_fec(&bp->link_info));
 	} else {
+		char *str = bnxt_link_down_reason(&bp->link_info);
+
 		netif_carrier_off(bp->dev);
-		netdev_err(bp->dev, "NIC Link is Down\n");
+		netdev_err(bp->dev, "NIC Link is Down %s\n", str);
 	}
 }
 
@@ -12164,6 +12186,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 	link_info->phy_addr = resp->eee_config_phy_addr &
 			      PORT_PHY_QCFG_RESP_PHY_ADDR_MASK;
 	link_info->module_status = resp->module_status;
+	link_info->link_down_reason = resp->link_down_reason;
 
 	if (bp->phy_flags & BNXT_PHY_FL_EEE_CAP) {
 		struct ethtool_keee *eee = &bp->eee;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 476c5684a1eb..aff781f167d4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1555,6 +1555,7 @@ struct bnxt_link_info {
 #define BNXT_LINK_STATE_DOWN	1
 #define BNXT_LINK_STATE_UP	2
 #define BNXT_LINK_IS_UP(bp)	((bp)->link_info.link_state == BNXT_LINK_STATE_UP)
+	u8			link_down_reason;
 	u8			active_lanes;
 	u8			duplex;
 #define BNXT_LINK_DUPLEX_HALF	PORT_PHY_QCFG_RESP_DUPLEX_STATE_HALF
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 4dfae7b61c76..6b15fedbb16f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3432,6 +3432,40 @@ static u32 bnxt_get_link(struct net_device *dev)
 	return BNXT_LINK_IS_UP(bp);
 }
 
+static int bnxt_get_link_ext_state(struct net_device *dev,
+				   struct ethtool_link_ext_state_info *info)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	u8 reason;
+
+	if (BNXT_LINK_IS_UP(bp))
+		return -ENODATA;
+
+	reason = bp->link_info.link_down_reason;
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF) {
+		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_LINK_TRAINING_FAILURE;
+		info->link_training = ETHTOOL_LINK_EXT_SUBSTATE_LT_REMOTE_FAULT;
+		return 0;
+	}
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_CABLE_REMOVED) {
+		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_NO_CABLE;
+		return 0;
+	}
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_OTP_SPEED_VIOLATION) {
+		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_OTP_SPEED_VIOLATION;
+		return 0;
+	}
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_MODULE_FAULT) {
+		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_MODULE;
+		return 0;
+	}
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_BMC_REQUEST) {
+		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_BMC_REQUEST_DOWN;
+		return 0;
+	}
+	return -ENODATA;
+}
+
 int bnxt_hwrm_nvm_get_dev_info(struct bnxt *bp,
 			       struct hwrm_nvm_get_dev_info_output *nvm_dev_info)
 {
@@ -5711,6 +5745,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_eeprom             = bnxt_get_eeprom,
 	.set_eeprom		= bnxt_set_eeprom,
 	.get_link		= bnxt_get_link,
+	.get_link_ext_state	= bnxt_get_link_ext_state,
 	.get_link_ext_stats	= bnxt_get_link_ext_stats,
 	.get_eee		= bnxt_get_eee,
 	.set_eee		= bnxt_set_eee,
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index eb7ff2602fbb..5daa8f225b67 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -603,6 +603,8 @@ enum ethtool_link_ext_state {
 	ETHTOOL_LINK_EXT_STATE_POWER_BUDGET_EXCEEDED,
 	ETHTOOL_LINK_EXT_STATE_OVERHEAT,
 	ETHTOOL_LINK_EXT_STATE_MODULE,
+	ETHTOOL_LINK_EXT_STATE_OTP_SPEED_VIOLATION,
+	ETHTOOL_LINK_EXT_STATE_BMC_REQUEST_DOWN,
 };
 
 /* More information in addition to ETHTOOL_LINK_EXT_STATE_AUTONEG. */
-- 
2.51.0


