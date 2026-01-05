Return-Path: <netdev+bounces-247209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D513CF5BF8
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C32E5300D41A
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965FA311979;
	Mon,  5 Jan 2026 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U8Dn9MGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4B1917FB
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650364; cv=none; b=e2NSH+v63i8CZAuqCkNmaD2Emqv7pbo3xTN3DfhICbQ2dAep9JnTnTW/JYmNPdb2FPzWLzNb4l1ypzmZYvyrJhmIMY7yPJvPrx2TO3ryyffIHGii+9mveNj0Vu4Y2naNujzvL97yPZ4SzodfEvVAy6tTGVnvAfEBXcviAu+xdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650364; c=relaxed/simple;
	bh=CDOnC1OWW0FvWRGARPBHKvL7mi1uL4Moucfag83zdj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Srqg/q/m3TdLFhl9+/ELIGomBGb+erFlJ5+gIRhNqqkjlCUfHYYsu8w3V6a4EePSyNJw90A3ZUstfHBJacpDOXGL05PONWAoDIihEbycm9otBO3dtH+442unGLNR0GPMZarsTLLWIny2FLV/rob5xETh3x5duEvUBV9NydxJtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U8Dn9MGk; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7904a401d5cso4727017b3.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650361; x=1768255161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwxrm5t2JRxA/KQ4fQjsDmCmqLlB3vPGAh9wEVcyDFw=;
        b=nGnYkPPUVG9YgHa2K34ixdVNZ5i8cwBSqC5flEXtxorHOSPNGwoXEii57TWcGzUSly
         CyKg+WDidLBMkZiF0DaoIOr5kWqW3/EbBABuVZ4u2YdN2OYOj09z/rNuZPrrQcMOfxVS
         xl+0zxUj7ANLKks5MFIReaya/pVDcgEAtHAQ9OpmYAHob1TzjnQBzEYk15RkeCdz11lO
         k4CN9xeITJbFbYDXnlQTxyWls119VhbsHXSV0KxyWt5aQ6S1Rr6Wt2IJKzSQ26lgnA9U
         vNH+/3i+VYibKZYXtW7o+O9iPYL6H91XT39mXQSqBpGlCxmcPRDTYhVJCtTHNQXgU9Qv
         g0cQ==
X-Gm-Message-State: AOJu0YwcC3hi4bCC+dokfj8dx66zqGnIveYzjTOaDv6UMxpg0xDu7Y6e
	C+yrzcbky4HQ+jUmjGHGDta2MJB8/wy+DjUQ1XPU9fLQhFRwpQjPuAUgLnrlOM8dXIrLKFbsYX4
	EIWezjNsVzRJlhTV6EKVvNr+uQIb3Biu2VdQC8p3hzzZOzDlwHjMYZF46cFu734GaRl09YSaMZJ
	XIPmOmaF5JjAMtixOosUkZZtVCNtYv+diAn9ZEBJnVsLC0MZYCRiToK9Ljy0eVxscOYLOfeE18n
	svRnShLLM0=
X-Gm-Gg: AY/fxX429Z4JO3G6UatfVCa94oAKUmvQpTKuQ5FHIwnnTmn+894okizMpMye5mdxzG4
	80hkoKFxMU/RGNbVBzln1C1DkD40pqtkyGtO+9B6MGhAac6+xsO28xs8UP567Pr/YJ9INdvx/jo
	u/F5IZdF+fYDQQjYDZ00cd+K8wZWNDvQdtCc509WhvDyRRnYqqUUEDGbcSFu4mrO0gorZ0vQL0m
	mhXK4KEIBZObvkEEyO4WFsIZBuz5EAuTjPUxQjSpX1/kahCjKx98gKcpgZsUccy25VhThOZrC0c
	+3ha1g+5Zu67HKNjrIXWXcf+bHTiczLReS3cVAMvIBlEvknOUm2ni5lOexOd8RO5aAFfLvEghH8
	hyRkGRpC7sNoB303bQcX5sxoFGNp/NQLSFc3IzJJ6wP2IDgSfsCn7JSbeUnR3AGB9bRCyvw9aqm
	SlVq2s1JtC+snBXvhVPXT+hdDLz/86OlAGr36ubSXFhg==
X-Google-Smtp-Source: AGHT+IEv3nQdguYvOoE+eY5JAHlkjhiUOeRc33YcCEIh22x6VxXothyeCZRommdKPPrc6jKmVSZZirtO9R1w
X-Received: by 2002:a05:690c:3803:b0:78f:f362:ec4a with SMTP id 00721157ae682-790a8aec440mr9142547b3.38.1767650360816;
        Mon, 05 Jan 2026 13:59:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa583b83sm104417b3.8.2026.01.05.13.59.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:59:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed79dd4a47so7268211cf.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767650360; x=1768255160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iwxrm5t2JRxA/KQ4fQjsDmCmqLlB3vPGAh9wEVcyDFw=;
        b=U8Dn9MGkb2yvOVyVPsV8vnyTgguFkBgIJMut+eIScBhFMzboNYsPkNUenrSigOXa2y
         pw87vkN7vX8IE7gJnde9pT+RTfwP+c4me8OWgta79asqMXvj5wKkKgvup2BiwLUd0q8S
         5zgepPqbZ0VglHvWbT8O8eOxZ0ZH7QuwFSc/I=
X-Received: by 2002:a05:622a:8c5:b0:4f1:b93e:d4d8 with SMTP id d75a77b69052e-4ffa7804999mr14139191cf.71.1767650359747;
        Mon, 05 Jan 2026 13:59:19 -0800 (PST)
X-Received: by 2002:a05:622a:8c5:b0:4f1:b93e:d4d8 with SMTP id d75a77b69052e-4ffa7804999mr14139021cf.71.1767650359373;
        Mon, 05 Jan 2026 13:59:19 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm1882051cf.3.2026.01.05.13.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:59:18 -0800 (PST)
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
Subject: [PATCH net-next 6/6] bnxt_en: Implement ethtool_ops -> get_link_ext_state()
Date: Mon,  5 Jan 2026 13:58:33 -0800
Message-ID: <20260105215833.46125-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260105215833.46125-1-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
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
available.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 27 ++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 +++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9efdc382ebd7..6104c23f1c55 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11906,6 +11906,28 @@ static char *bnxt_report_fec(struct bnxt_link_info *link_info)
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
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_TX_LASER_DISABLED)
+		return "(TX laser disabled)";
+	return "";
+};
+
 void bnxt_report_link(struct bnxt *bp)
 {
 	if (BNXT_LINK_IS_UP(bp)) {
@@ -11963,8 +11985,10 @@ void bnxt_report_link(struct bnxt *bp)
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
 
@@ -12164,6 +12188,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
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
index a5ed6dd42bfc..0c9a29bbfa41 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3432,6 +3432,26 @@ static u32 bnxt_get_link(struct net_device *dev)
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
+	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_CABLE_REMOVED) {
+		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_NO_CABLE;
+		return 0;
+	} else if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_MODULE_FAULT) {
+		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_MODULE;
+		return 0;
+	}
+	return -ENODATA;
+}
+
 int bnxt_hwrm_nvm_get_dev_info(struct bnxt *bp,
 			       struct hwrm_nvm_get_dev_info_output *nvm_dev_info)
 {
@@ -5711,6 +5731,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_eeprom             = bnxt_get_eeprom,
 	.set_eeprom		= bnxt_set_eeprom,
 	.get_link		= bnxt_get_link,
+	.get_link_ext_state	= bnxt_get_link_ext_state,
 	.get_link_ext_stats	= bnxt_get_link_ext_stats,
 	.get_eee		= bnxt_get_eee,
 	.set_eee		= bnxt_set_eee,
-- 
2.51.0


