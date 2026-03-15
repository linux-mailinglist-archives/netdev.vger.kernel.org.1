Return-Path: <netdev+bounces-267912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP6nJyPAtmkWHwEAu9opvQ
	(envelope-from <netdev+bounces-267912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:20:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE29290FB2
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B703E302866B
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC3365A01;
	Sun, 15 Mar 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YukD/wfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20C366572
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584301; cv=none; b=m4eraIYhzGJoJyw9oxbxy+/AeFgE4KbjUfyKHKyfNC2oIjLniJNOxQ6+KdgwQKYb/vtqlMIaMpLXYb2oPUhmjv0qHi3FWqeDNwHUq0zbdBC9+nGxF7MbRzWnznJGoXK+zYn6mmRI7J9cAGFUOk0fOkWLff45OPwSmiOWl//kPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584301; c=relaxed/simple;
	bh=cwbyj1ooo9Qz7huYKrO/pQhap2OaZVcpI54mpWxp6Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNPuN1dXohAW7eItqbVQJmS6VLWyF9Hj4Hd8WTdsdzC0xWBA06LD3a0u35McaNPbQyfBP4n35Oqf6MxUnnVG1FGM1p9hCkmaeuMmYJ+ipX+pyFHeExWtmAwQ6VzeHHz7ygDtfPlITekX6h86s6NSktDkvOap4mmmeyI8S2T347U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YukD/wfO; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2b04e6a989eso3433455ad.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584298; x=1774189098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aN4rJh4Zci2AFuVsQwX5cXgl6r8zy06083cabZMtsqc=;
        b=ip745P3ZSFC7Mj1y9ZgfAu0x7OWdqij2OcImYyJDFYoiNSDPHIUeqb1+aQHfFxrwbx
         9o/Uytb879gHdDTiARy0ww3Wy5DWbSUHOrp0VUxm3DnMLQhOJRXZ1dkjAjzlUk/WseKF
         qyCxhSkccmuay4jS2j+m7usv1XIyMxj8X6mqdm8qrYCracOxlCnIZH+L6h+WIi+3ELLf
         xGTitb4WqsCLGBdSaBCzWDy1OajPomhJBpmLU/ktJqs3Ct2Tqy8y/vc80SRoL1YDDkLA
         044XipFnyivZMtTrjo+upeefMMLmeTxlIZeWIvocmaWj+DoWVejnUHf/J6nZyoIBWhhC
         0xzg==
X-Gm-Message-State: AOJu0YwfzNE360tCnC7XyCdXW66B+j4nSmAmgz/74fLgX8sA/iJl4MRm
	A/oBR61GkwzdQ/KnYRrjAstQfL4DJgZuBOYlDG8L8QCpRZvKyfnKXTti5sUU9qCG/8t8ONIv53u
	URlQVMloLn1Upqjs3G9s82ZHpFhVbBvq8hN62uZ67LahBUXB9K+DeC1y+KVCZDjMLuduloKoCSm
	TjAA5E2uJ6tjsuKOwmuWHv7HD4ASzqZo3+wJ29kwZjk9Vn98YqxaXRedwb1zZLHMNRiHVOSG33k
	5m7IKBl1Q==
X-Gm-Gg: ATEYQzyPyPoi726zziHICDFXdKWWir2K8gAtKvwVlBxFSYcPeyZIaIoPE4PqBCzqUxT
	Tmh2VzOY7hG0yMTVWrJS/ifRW+SjrIuTdb1Itgp/6pEUGTrc6Dm9aw93fQd1K1NuOauJ/BJ6OJ6
	eCPisqZ119BHtK4tedl9uGNFUuuc4DcecfYuZRLhF+Pklq3VfgXZqRCvrOZVmyVtD/5zdWPj9tP
	WM5yr+d7nliLzv8qq2DrBCR0k4Uaz6wKr0eiXXTRFLVjf/N4DwvoN8PLY7JTTNM/zqKL2bKLKMa
	dxe6LTwr4hJaPTmfLdwYkWCPU1ukvetSOc1TvNX45ojMa+iQtDEGsLgfvBkuGWMCoTMd1XOlLFI
	nYT3ceFPDfAQik2I6J+qD1uuj5QTdyfEoKxQ+lOHNNWW6Kq7uoJj8H+c6klroZjfq2npmB8V+ul
	CD8slFgK1LctsGRyRIOyprSjvJyibJzA+KseHkZYxWsZheHtYmZL8NYbk=
X-Received: by 2002:a17:903:2c06:b0:2ae:b807:da61 with SMTP id d9443c01a7336-2aecaaf6429mr91581935ad.35.1773584297900;
        Sun, 15 Mar 2026 07:18:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2aece804668sm9678975ad.41.2026.03.15.07.18.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2026 07:18:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b056b2f0cfso1651025ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773584296; x=1774189096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN4rJh4Zci2AFuVsQwX5cXgl6r8zy06083cabZMtsqc=;
        b=YukD/wfOw4wBlhcWAyKkIclpahQPZ0vKuDZcesShZlQK3AsQNEbw7XhldNfeFlY7f7
         A6ulGZmNgRVSkMRjgjc4zoJEHFsWm8LLKUvdml6X8aLEKZXRPGEcFZ41dQygt3hzAybn
         AvUOoTExjlRVn8ObTJGUOjM/OVshl70Qyi1lA=
X-Received: by 2002:a17:903:1ae7:b0:2ae:b991:a46f with SMTP id d9443c01a7336-2aecac7ed8cmr103694405ad.42.1773584296142;
        Sun, 15 Mar 2026 07:18:16 -0700 (PDT)
X-Received: by 2002:a17:903:1ae7:b0:2ae:b991:a46f with SMTP id d9443c01a7336-2aecac7ed8cmr103694185ad.42.1773584295707;
        Sun, 15 Mar 2026 07:18:15 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm76185395ad.17.2026.03.15.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:18:15 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v7 04/10] bng_en: implement ethtool pauseparam operations
Date: Sun, 15 Mar 2026 19:45:59 +0530
Message-ID: <20260315141605.410878-5-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260315141605.410878-1-vikas.gupta@broadcom.com>
References: <20260315141605.410878-1-vikas.gupta@broadcom.com>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267912-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4CE29290FB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index e4d3041db0af..01382ad784e3 100644
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
2.47.1


