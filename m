Return-Path: <netdev+bounces-300329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hyHPAUeTM2pVDgYAu9opvQ
	(envelope-from <netdev+bounces-300329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:42:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86369DE56
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kbeJorBh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300329-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300329-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E520301C3FD
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9318371D04;
	Thu, 18 Jun 2026 06:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE2370AC5
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 06:41:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764919; cv=none; b=KdtnBqr06VFT4xzg1ZTPVQcJTy31Ua9dSTXtnlYQQ7c0nxW33fOWIROGOGVJ/WO4YUIwn6P9Cn0WpUd9sAaMaEXTQVCqfK2uU9VZJo2vWo5cg6PjBpgeXwShNeDWpvEzWz8wKnn5LpibL0GXwHixj4IA9kBBtoLMBRxtY1pA1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764919; c=relaxed/simple;
	bh=WLF7/xznf2EvJR4gFlmVaoocRv93ZakQpL8lMrw/czI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P26S8b9RefJgzlHcNBkthv+s9JXycKpsMp0zaZgeCEqtDmKfqEjl3NfKHukngUoVNaenCIZABxWjSiXQqfnHtuNXe27aRBfxn10TG0ciPUn5dQ698X+vWHl40+384VQpYWAOS10gIuTdS4L5m4HHCowiXMkMtYf6tOT3CAW9dW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbeJorBh; arc=none smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso301336a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 23:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781764915; x=1782369715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq+UrIAjX4AZwds/jvySlMBzvhIQPTWIB6Jqv3g81b4=;
        b=kbeJorBhWqTcZnMni6xtcOgwwZ3RIbCNojJ98oyBZ5iB142tMeu0NAP2CCqcS5zVY0
         Wy3crzifAuqMo1nKEyIuTBVUGJyuV+zGlTbrRRmUI9GSXVxbs7leW2bUzbtDngN1R1Y6
         qgqetx3zMAH1u15TFajMakUnjLZV5/kJWCau6ahCsAunrWPdQBhyBK6CQWPG19JUyTS1
         ax2kFv6qxAtrahe0dbwVwVc08c8wb5BC52X0Yd+/7e5/MUk/gl6SzWJMMKCfXLoAHe0k
         9DuApTDZEN4NS/+Q2v0fDm1CMIKNRgathFiNJ29OwquSG3ABAbRnJK3QAooTFluSJuwR
         L+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781764915; x=1782369715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq+UrIAjX4AZwds/jvySlMBzvhIQPTWIB6Jqv3g81b4=;
        b=moezSqq8p6FIUdBgMB3T3ZtNfGFuo8wGUgmtTMvsOpO0ohGhSyGj8TTnb/BOYlKCRs
         gdS4To8aiCRzUbfIzZC2Wb3IHzPT3q6939cITHJEZytXdWEFQ2r2uLZCyGtqG/O21BsI
         GfQgwqTkhJtafDzKY1QHA8yDZFib/jnYHjGwLpy5F02IWtb2iIBzi+cWDZzBOBhOXyKt
         ATSX4Hvx9zoC0vt/9DNWBpylz5lvpkQZ+Add9VzrLBTrmFPd1fV25+FWOOlQmdCMtRpP
         saOcqf+tYNEGTtlybg3yKEtmPvKEkVMwJGw0de1mn/8iWWKRtcbHiwaqJD1LamZY/sVV
         L/ow==
X-Gm-Message-State: AOJu0YyjRhePUFQeXfbj7XqRHadsl7F5IxiQcCSXl1VJCmjbQnTN6NnU
	+dm1ZNMEFabAl5n/7ACo32SNCIi9GGlgUyfePOLSQ+0/2tKy6PHZC2Dy
X-Gm-Gg: AfdE7clfADqEWlZWFEA7g/HSNUdcZ20a7A/brBc2jnctVldZZeNaWvl5y9hJl41DCq0
	U88N7el6wYuepw78QArRnwQfvL7mu3h9mLnLsmPuQlV6nbuw0DkAkU3EVR0Mfuq7Hr730gbyh+n
	+kn59fiDHB/EiSraJ2YTYD7Grbd/5fGyFlhpCKjiTvr528a5CAnF7XxthfTd0Vw5OitDx1jcuyP
	OvFfxWwVEwkjAaEdpxzvxee/Yb2JT3mvA1LNZpbU+bJ1Mo+j/K8UBF5pGZ99MjJgbMHFKUcaaK2
	yU+iTbRXoGoL1K9yzPAlTnmgzmJMnF9WAG3ZvNCZTiTYgPjwary0S5esgCcfX+3wX2oYEYrIAY7
	CdLMUOhNhmzfzCz84khi1XHdKa6DlXx9iLZntqV+u8VW1AggJ/K+sgxSkoSUzfkpgsRExsUgYQ/
	o80SZCaSkUXKk=
X-Received: by 2002:a05:6a21:4d17:b0:3b7:9aa8:3be3 with SMTP id adf61e73a8af0-3ba4d0e7999mr1744739637.2.1781764915177;
        Wed, 17 Jun 2026 23:41:55 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d156sm16799602a12.13.2026.06.17.23.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 23:41:54 -0700 (PDT)
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
Subject: [PATCH net] net: stmmac: dwmac-spacemit: Fix wrong ctrl register definition
Date: Thu, 18 Jun 2026 14:41:43 +0800
Message-ID: <20260618064143.1102179-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300329-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B86369DE56

There register layout of the phy ctrl register has something wrong,
fix it to match the right layout

Fixes: 30f0ba420ed3 ("net: stmmac: Add glue layer for Spacemit K3 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-spacemit.c    | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
index 223754cc5c79..6feffaa3ef3a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
@@ -18,10 +18,12 @@
 #include "stmmac_platform.h"
 
 /* ctrl register bits */
-#define CTRL_PHY_INTF_RGMII		BIT(3)
-#define CTRL_PHY_INTF_MII		BIT(4)
-#define CTRL_WAKE_IRQ_EN		BIT(9)
-#define CTRL_PHY_IRQ_EN			BIT(12)
+#define CTRL_PHY_INTF_MODE		GENMASK(4, 3)
+#define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
+#define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
+#define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
+#define CTRL_PHY_IRQ_EN			BIT(9)
+#define CTRL_WAKE_IRQ_EN		BIT(12)
 
 /* dline register bits */
 #define RGMII_RX_DLINE_EN		BIT(0)
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


