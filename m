Return-Path: <netdev+bounces-261534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEuFMKCToGl+kwQAu9opvQ
	(envelope-from <netdev+bounces-261534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:40:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD91ADD6C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A8AD309439F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6895425CC3;
	Thu, 26 Feb 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uz8RFV+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38342668C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130157; cv=none; b=lNkdaXKUdxuby8N6ZxsSPVQXyeBkK6d1cdL37V+gDtD+84upVJAUgNk89HoOENmdThpgS9pxZDa0OqTjM9U/mUHb8+VlHE0n5/z+8HKlEY6MSl5p4oqAhmItfoJ61jhubMLVzBeYG8g1wrxJzmCKi6/dENDaZmEVedw4f4fdOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130157; c=relaxed/simple;
	bh=RI2O/lNGf1FHG8lBBdNR6Rg/0jZYOOT3Qiqv5EhsqVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBZyXfdPFkT+7efMfejQX7jKwHZm42QNI5UeqFPNJLvKlj028hh/k1AmLBnxLz+yRCr7vWhjcOM5ObVnsIUyCLEtKoTAIw9EXXypzJcBu4U/X/N8SMcGR7HNr+djFK6A3GAVRxfuLxG4yvwZKUEsUU6hwcOaVc6n05bGU843Z/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uz8RFV+v; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-827270d50d4so1258830b3a.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130155; x=1772734955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBT6MFXOtTSgU5rguyWXBbF7aVNVj3aF2y1eOVL320U=;
        b=sV/oXPWqpCmvQaupZy1H0JKHOcKF1mn4xs3YsPTHJjQDqci7De/W7KUI/5IA5KZ14L
         OWB2CE15iORALPoEI4YpnluEJ7HvGFgEVDweCGk8CTabSoNX+RrXRUF0wkEEJ0L2RFlr
         xxeQ2m1r6CgVYs/iM8PE8FGhBoPkSmbVKxQ28pqESS9ml0HJIz5cfDWgj3LplVLoTZta
         ulAdQ/OfiZYhekE31pmllkme9B/Ev02d095nByd23s+LqAe8D1eNWw9sRLqkSuZrLv1a
         4CCwYaJrxIjW0An1HACLIweJzJVFeNOPW5+hsGeA+dQW2qVrj2p52wlG8zC10xKVp/v3
         NSDQ==
X-Gm-Message-State: AOJu0Yx+FF2eu2WbmcMwoBQE9p9ZsPckXRTGBFSygJ6VUg+nDxG+1y0d
	L7wnVGkqiCj7c9dOxH0/8tcvxKHX7LiUAL1sgUcuvqJfzGUQa+3t6LLTlY+tn0efVEkRYbgnxTQ
	OWzanTGqRxzXiCchG6Po+xJ9Zm3nIvXAqoQk2ZVeghwW1YJvCUUTzmvNctvb6oUD+0tHgyFzX8r
	e4mHleTz54Kh0YrHBmbQ12LysZMqnUtFt0ssRQWrSGsE5j7P/tIa2nlc5yH7gSImneWot/FKT1e
	3XVjAt8oPM6OS+HcQ==
X-Gm-Gg: ATEYQzwqh6RwVIQiCkdyb47aaLiUcli7dra3j8V4+H53R1wcRtRMBuSKXkGDmNFDJrF
	WhqLrvyaKaBhn7TkQM388NHvbD4TijDA24pWvmLHsoCGwqUkPC9yu4gzLH1tFcepURCQEcmNHNS
	cdgvpHFW1YyOqp6C5ls84cqxaRtzKg0frdU+EukPx8vwnCBI8EUXIotEwqKgwBouIl+iGo0FSFi
	u9tM8ndPnf37KHgKjqkTLKSJZ5q4J/FV2hd+E1/xPaQlWlICmXKF6shZek/W2g3fmHw4yHrnZWQ
	vAK9fT8pomaDauaRPM64B4I61sQd1xMfT7VUXoieM5+hIBAL0j4TcFNRmgjM1NbRmHwXgRZlSDI
	20aZQfF+pmtoDYbQug01+VKrAQaPSAvN9VadjAGZsUckTOIwQ3+zFx2A5h2CkCrH/ohCTn+Zbiw
	p0Z+fa2Abmp9Qa/VBiMpFD0M/+8Znm6w/10i6CE4SM5d5Eg6hy/cR4KfKIR9NjdWSMGg==
X-Received: by 2002:a05:6a00:9506:b0:7f7:5d81:172b with SMTP id d2e1a72fcca58-8274d9f43d8mr22809b3a.42.1772130155376;
        Thu, 26 Feb 2026 10:22:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82739f88d68sm348995b3a.8.2026.02.26.10.22.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:22:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae04f58b19so50641585ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772130154; x=1772734954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBT6MFXOtTSgU5rguyWXBbF7aVNVj3aF2y1eOVL320U=;
        b=Uz8RFV+vneg0RGA4o8gmT8bAq0475v5E7eDZ+Y031SvE4PH7Zny9ljfmtIRGvrnale
         44eT91PVhTdQFla18tvi4bXvaprSfY9WRhmQ/0CKIa00aOu7uN9cUoSmVy8fDPIIxukj
         lSnf2op1G6K+k85395wx3FCl5L0+HFOO1Yom8=
X-Received: by 2002:a17:902:ea0a:b0:2ad:ad60:73e3 with SMTP id d9443c01a7336-2ae035cb3ecmr36010465ad.53.1772130153617;
        Thu, 26 Feb 2026 10:22:33 -0800 (PST)
X-Received: by 2002:a17:902:ea0a:b0:2ad:ad60:73e3 with SMTP id d9443c01a7336-2ae035cb3ecmr36010185ad.53.1772130153142;
        Thu, 26 Feb 2026 10:22:33 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm35941565ad.53.2026.02.26.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:22:32 -0800 (PST)
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
Subject: [PATCH net-next v2 4/8] bng_en: implement ethtool pauseparam operations
Date: Thu, 26 Feb 2026 23:51:29 +0530
Message-ID: <20260226182133.1566714-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261534-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AFBD91ADD6C
X-Rspamd-Action: no action

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index e4d3041db0a..01382ad784e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -42,6 +42,62 @@ static void bnge_get_drvinfo(struct net_device *dev,
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
+	struct bnge_ethtool_link_info *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	if (!BNGE_PHY_CFG_ABLE(bd) || (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+		return -EOPNOTSUPP;
+
+	elink_info = &bn->eth_link_info;
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
+	if (netif_running(dev))
+		return bnge_hwrm_set_pause(bn);
+
+	return 0;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -49,6 +105,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.get_drvinfo		= bnge_get_drvinfo,
 	.get_link		= bnge_get_link,
 	.nway_reset		= bnge_nway_reset,
+	.get_pauseparam		= bnge_get_pauseparam,
+	.set_pauseparam		= bnge_set_pauseparam,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
-- 
2.47.3


