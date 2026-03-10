Return-Path: <netdev+bounces-266186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIgxN5ousGlHgwIAu9opvQ
	(envelope-from <netdev+bounces-266186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:45:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1B25259F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D19DE3073477
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A02FD675;
	Tue, 10 Mar 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="avp4sTnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95532FD1B1
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153728; cv=none; b=O8boUnqMu13ftz0bQn2ZDtE83xVstFDT4fgg1cxxVUE9NWADwJoMZ2tD/g55ZHQzMtWbN5xLt6zuWVsx63DvJF2r2USO/fFQiyyeK6cp/dN63hjF6ytwMZjkZTQY5LvE7s6+7k1dLscI7zk1f2TWVrmmqauBBxmgQF6wvEq1hGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153728; c=relaxed/simple;
	bh=YPb9n5EavagjMOwiIS/HfhVaJCMP/jsQfRaYV0mtAE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCfpxgwH6nWxA2Y/eFIRQkMYDvpro9miB+9z47Lwr2v9AYXNIS32KsmMF1x/VvvkGN5fALnEjQR7j2TvK23tj/iKPX+C25sHxhe6t/9Ru15qmZpTDmJXKbX4gegFqkzYIiWetxZff9vOJgEY0uyDxk8USXvDDKPdgQJtE5MIXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=avp4sTnQ; arc=none smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-128e4d0cc48so218619c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153726; x=1773758526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdXbCzdkZX2AwIvcDJuSfRSk/9LbJo93uf1Mskb42JA=;
        b=kuHr2aYFds96XrYwnPWtpGvfqgYnIwdVXSfNO/LK8LMwTpQOhko2i8EDtSrORBXsIh
         Rniy1k9MQhdMRthe3Xro2kPQEd3PSPVwRxIB9cNiCZAz0PEx1GEIjrL12Ra7NamUrUmd
         tWS1Lrq4Ax1fJIGDLP8VVddBzR3LlulGaqza6zdFxp62T/Umr4bUY2s6pj5PFI0GoBYx
         vXe1lTYfnkMLsV4KO9v8c0WTROLT6wX9Fgfqw4PHFTdhfVraxCiaQvTcyRa8/WHJPuIz
         vNq0/6gzM8UPBcZKtl4QGR/B9GD+zRFKzRHfuylwYQiGsKCzJku/0aXuBemR8j489qvi
         +FgA==
X-Gm-Message-State: AOJu0YxcNllD6/JmRNYXnBXAlPX6xn+5Ldpu4zgEhiZL563ug3Ie+S5/
	rhj5JMSNWzwrl9Bz1kBd5ssg9boYngnSLovwcpLwGWYrMCN4VmpNGEQ8aN7YlMULhpI3bCIQ+gD
	AKJcF/pntD+D6mtp0vtIBOTIi3UJd12LB2omxH/RRSNhhYgPFSPIjTKK2nHfSNvNsmYOUw4jaiR
	n4SElsEhVDlBumdNDHHUvIXEFbmYsSUBw8CAP1nz1Nv3eW5WvxcsQoj0sqed0FhRghuUfvv0a9q
	WUQ3U6TEJLQBY127w==
X-Gm-Gg: ATEYQzyqPISHwn4E0x9RNr0XUsz2cnFgKO6aHWTvWSk9ei1wIgfel2+A3MtyjxQRrdr
	zKlAgR+b5BTsS/c0xT8G5wGj0uxFyhaPstJKkiZqd0gwxAq3Rh7jyfmqzd/eO9XKOETZw5ydCBM
	FrXcO0WsxjQ8luCxNGTdlvR85tvwEXjwOmCiMDb2g+B9FurMxMGKnmY48zJcxN7/ca0N/5BFJMj
	9IYG5FnLfqS+IDvZUpRN+2sRwUjF/jgLMnwQXxNv9Cka4uI6GbFDRaPKdQIlNpuUtsjP7HV2f+W
	5VHtCQp2PVLHvsRUApbv/3RiU/sZxmS9Snvlg1FP1nw7Vmc0yagRjZahLFfXF01zOpTo+aKc5Pc
	NPYFXHJmertw7lHODWaTlo+V4/po4lJoyX+I1xLd80Ocl7WyUIxVvigQ9QHxVTkCXn1wNfe+Bym
	4J1S4QuMQp46zu++GSCccl7Txdca4YKSuhc3uG6mskCGENyLRZ+SILzumSqrVAmHs=
X-Received: by 2002:a05:7022:ea27:b0:123:330b:3a0 with SMTP id a92af1059eb24-128c2ddc31cmr6640346c88.14.1773153725753;
        Tue, 10 Mar 2026 07:42:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-128c3ed481dsm1217833c88.4.2026.03.10.07.42.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:42:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62da7602a0so7832604a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773153724; x=1773758524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdXbCzdkZX2AwIvcDJuSfRSk/9LbJo93uf1Mskb42JA=;
        b=avp4sTnQG+ff5X3C5wdwzvnTadc87nAuT7qrUJq0lMWuNWggzIF1zz4AiGnwM7S9H3
         OtkkdEgv25Z4qZTgEsPNeap1uTpqvnuJQv/fSFXpwyRsXmKin13TBMar75qLHr2z8Ogx
         IsgJAT/m8JeTeNs5kW3XuikBXbUfNyHxLwI48=
X-Received: by 2002:a17:902:d48b:b0:2ae:3d7d:d903 with SMTP id d9443c01a7336-2ae824465e5mr155695425ad.18.1773153723878;
        Tue, 10 Mar 2026 07:42:03 -0700 (PDT)
X-Received: by 2002:a17:902:d48b:b0:2ae:3d7d:d903 with SMTP id d9443c01a7336-2ae824465e5mr155695135ad.18.1773153723437;
        Tue, 10 Mar 2026 07:42:03 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783cfsm157096515ad.56.2026.03.10.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:42:02 -0700 (PDT)
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
Subject: [PATCH net-next v6 04/10] bng_en: implement ethtool pauseparam operations
Date: Tue, 10 Mar 2026 20:10:38 +0530
Message-ID: <20260310144044.21672-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: A1A1B25259F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266186-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
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
2.47.3


