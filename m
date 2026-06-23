Return-Path: <netdev+bounces-301290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PYqpMSs6OmpO4QcAu9opvQ
	(envelope-from <netdev+bounces-301290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:47:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 416606B4F70
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:47:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f0h8NfJi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301290-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0053066C64
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53A83C5DC5;
	Tue, 23 Jun 2026 07:47:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E33C6A43
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:47:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200822; cv=none; b=oWPIXIKVsH4n2kMwhysIN1IvGhOuiTfejUa3YjiUEX1IcVb3GQRQ/rJy5GX4z7Ya4T0Ers/ywNe/UTHhDnOjQxC5qh0pAA54zd7zmT5W7N4Cq1QEwhotyyYr9ztDAIF2ugZpUq0/x2rfi5w63ntFU/EF8z44EFMNNe8xFiLDtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200822; c=relaxed/simple;
	bh=iw7EtxLgSRuUovF7Ujv0rAtm9UNbY51PtU1f9KhFbPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTqgUWMjl2C1zZ9zbVdezqMW7hqkYfnGAuetsaHyOCTeYJ23W5AOeW/5UX03qqKcSmkdjYU2F8EYJEbLFKkS2ahFi350Aonj/E/sHIAim7XYsm9f8gNz0VXMroIouVMyCril4GX7E9fY5z+Y0kAsnaGE9TXDgmLjU6bGWbrW4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0h8NfJi; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8453a67659fso2895191b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782200821; x=1782805621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1Fyw9fJmtAP3F6H/X4okbn9VnSF0X5lGAx5UXg/ZEY=;
        b=f0h8NfJiKenjn1E68TCZlAurZqRxmKSMzv82GrtDFD8/jtU3ZCCD1TZ8Fq9DCZ+3xF
         ZO6NizBbpwArJzPuMA9t2dHtAKxPMBi5PJn5r9ot/nhj40/aV1vLWsXKRxy75J4sZnPg
         qY/i111ChYr2535XA2n5yZJX+IMN5W2aQQdHnPuvd5FK9wvjsNYad4rsT9yzU+W4phVm
         sTHH3VWQ9XwxWyD3guW1kRMudMQo3QImCZE1lupQKRiGjXIDqPetrrRKblzcVR6Ah1sw
         NCPPT4D4e4a5cpk5aHerv/HxUSgCY2gweocPGrIZLpeD5DozBpwoQM7M1vOg+TpXu3V8
         ynwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200821; x=1782805621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1Fyw9fJmtAP3F6H/X4okbn9VnSF0X5lGAx5UXg/ZEY=;
        b=dTKssY76qGvcrAZoiX9N0DzpFsciZpHiQzS7xTfqhaw0HZ5+/IWSgs5BXTF4kOc5+8
         nqMl5BbvRjNLdBFeUROU3eaAd/gqdikp303zo/AFna9uPGQSr/Liiw4OmxdngrrSGD5A
         E7O16Cze2Yg/S+BAwCMbcbvRuBpLJUVtXzwO0My7hERY1hpYcS4T3XcoGVSvFfAoN95E
         1RZ9YOKKT3HbZxX3uOGF8zUbUDcpsqXzr//nSSwrJT6pM1FdNcyL1GKKl5Uiu+1RPhRe
         yc4caxbr8Mh7n2QQCRufTZzgEbUbTNEvGEvsvHCHjycpql/qyh4107t0Ug59PB12kWhn
         GHRg==
X-Gm-Message-State: AOJu0Yy08fzdJY/yE5tVkuQVfYwl1uj2f6zc1zmXk9OOdr4Z2LUxfz29
	Bm2vUukYD/hHF86K9Ps25dFA03LquGY6aGqkdU269aV4ibcqOCUvD0hw
X-Gm-Gg: AfdE7cmZCJo7Yb59RmIPPm06kuSrUuYuwBLjYCKsR2dMwbmcvKYqMacKEJcL6UPJnC4
	ECqfkucIxmoT1X80FCCAOo5TfCCso8Lfg3z1BxsO87g0gTUHHOw9g/YI+gkeKWPm32st36AWUa1
	o4kLs3bY/6acaFe4xSbp+JmsKYzlAnMqh5Q6d/Q5vr/BLj/fVxMauo7lw8W6aw9nrLzoYEPH7co
	iLVQ/9B6FvGSDY/HlUhjbmEhC0ljCl9MDuRrixVO0j8MGMeYlnzS5GWT3bohNAmatIJMBhNDQ2o
	wv8DwF/54l9z2WNQCkgOMe4SIyMJE3nT/U83QagI7p8iiS+fWLgtNKssw/pW+WjzCYBlP1Ue9Nu
	aAtqdK2w5bRy0oC1bwkbi3/624nG9n067Yn2CSoboW+7aQUnHy4+LTNg1XmqkOauARYAne4sKib
	lFJ+n+uoDV7n4=
X-Received: by 2002:a05:6a00:22ca:b0:842:74e3:48b5 with SMTP id d2e1a72fcca58-84597067827mr1756226b3a.13.1782200820845;
        Tue, 23 Jun 2026 00:47:00 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e76a0bsm11039417b3a.36.2026.06.23.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:47:00 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yixun Lan <dlan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net v2 1/2] net: stmmac: dwmac-spacemit: Fix wrong phy interface definition
Date: Tue, 23 Jun 2026 15:46:34 +0800
Message-ID: <20260623074637.503864-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623074637.503864-1-inochiama@gmail.com>
References: <20260623074637.503864-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301290-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:inochiama@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dlan@kernel.org,m:rmk+kernel@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:dlan@gentoo.org,m:looong.bin@gmail.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,m:looongbin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,armlinux.org.uk];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,gentoo.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 416606B4F70

The current MII interface register definition from the vendor is wrong,
use the right number for the macro. Also, correct the interface mask
in spacemit_set_phy_intf_sel() so it can update the register with the
right number

Fixes: 30f0ba420ed3 ("net: stmmac: Add glue layer for Spacemit K3 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
index 223754cc5c79..3bfb6d49be6c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
@@ -18,8 +18,10 @@
 #include "stmmac_platform.h"
 
 /* ctrl register bits */
-#define CTRL_PHY_INTF_RGMII		BIT(3)
-#define CTRL_PHY_INTF_MII		BIT(4)
+#define CTRL_PHY_INTF_MODE		GENMASK(4, 3)
+#define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
+#define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
+#define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
 #define CTRL_WAKE_IRQ_EN		BIT(9)
 #define CTRL_PHY_IRQ_EN			BIT(12)
 
@@ -118,7 +120,7 @@ static void spacemit_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
 
 static int spacemit_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
 {
-	unsigned int mask = CTRL_PHY_INTF_MII | CTRL_PHY_INTF_RGMII;
+	unsigned int mask = CTRL_PHY_INTF_MODE;
 	struct spacmit_dwmac *dwmac = bsp_priv;
 	unsigned int val = 0;
 
@@ -128,6 +130,7 @@ static int spacemit_set_phy_intf_sel(void *bsp_priv, u8 phy_intf_sel)
 		break;
 
 	case PHY_INTF_SEL_RMII:
+		val = CTRL_PHY_INTF_RMII;
 		break;
 
 	case PHY_INTF_SEL_RGMII:
-- 
2.54.0


