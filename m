Return-Path: <netdev+bounces-254477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ChmBIqFemnx7AEAu9opvQ
	(envelope-from <netdev+bounces-254477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:54:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639F3A947C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17F030727C2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919033C1B2;
	Wed, 28 Jan 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVkFyuH/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5E338925
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637145; cv=none; b=aH07yotG9xOEdVN2C4RN3YqMxsikL4KxnTSMquKwukrEp+DOpgqZSEN/HQijLijEPOOTr/taOdQRoP06o8IQBu/ufQ8zj02UlRnwFPj66RtWRPM54KTVN3P++Z/pY5UQnntA7qbEP8n9qLVwWis2Ki6Zn+bF1DI6oeWDexnz5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637145; c=relaxed/simple;
	bh=oaKYUxuLnfKa0XbLlzcnsjYgUmDbWBbOM8jS1Hbn1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAEYTkAg15x6qna8yfNENWisCZuCvrDxgW4a5Nw5tL+pC3Le5aJ3yyF3KUYTLvkXbCGIhHX8myBr7021HG7sS1dOffWwftSRpBKmysq2CKBpFC7MSrC+QO6R8lDXVpkXAMLV99gfXRvys8EMVe32wlvXBwECn6d/pXdDZ9CXJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVkFyuH/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so1640155ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769637143; x=1770241943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMTrzu5hSLCA2plrTyP1x2jCu/VUChRHqXUHm8mbcHo=;
        b=MVkFyuH/zOaievfsNA32xi60ptuqBiptsSY2FXnaoNTLWJeNJU8vWwSpl+in/Qx05a
         id51BYW9ehSUM3E+6Ml9iuPuAMzxLmsEfHvPCf5zDeb2m7KDlAbe0D6ee7TCVajU9MRr
         S5bjG/mRRige4pN5hQd9nEd9dWaqnNuoquSewfjt7td4dLttQz3+LeJTw+LfRx2028Zx
         XTgCMvk187DNQXlOxsmSfbLRymNlA0Oji6H/MVFMbjkAm3VOMmvSa4t0+BoVPEJ1ln5C
         gtvdBSu+OhxLD8vnDx7WZ1vQRGKZe3UjdSYRjqm2nx6bE2liQ2eDWc04tf44LFHwLbmf
         fwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769637143; x=1770241943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMTrzu5hSLCA2plrTyP1x2jCu/VUChRHqXUHm8mbcHo=;
        b=Q7w1Ntd5qeNy8uIoPTHUiwE9XBrVdyXOe+Kaf54BeP8oixi6Xv5Y0nIU3Seegyyudi
         Nz8/RNuSOzJ2LBP4sY+4UWgc6imzig+BQZG5fdORuAR5ypM40pxyLqoOk+bs94OjwWbm
         x0E15sGwD9W9pvkTMXuvmJ9O4l1WbP8PirwlK1qf0Mxcc/XhefaumGWrtWFNWbb5T8MM
         wOofOGNn1QkcdnurmAplBARezLSwIh+KMgOtwF4YI+6HJ/flG/nPNf8vvHy4DNbQabiN
         jMr2czHcDCaddKvD+PIUmdQmEkqsPDif8eF0KelmosR9VzCFs4rpU7LZr8IJ5BNk+KMQ
         hZZg==
X-Gm-Message-State: AOJu0YznJhTXDt7+nAO65sRAUJ7XC3qHmqqRm7gg1KUIvtUaK4g4Cm83
	kxr+6SeLKobonDKhKVt6AUl90prIN4mqSz0U2sTKbnHcsWikdX5fGYBCmRWnmSqh
X-Gm-Gg: AZuq6aLvfspjt0cX1ll00HeCcp9C38N5eNSqUyvssVfgspWHS5+VVm2sYCBYAEZ5wyA
	VoO/ybSEr06USPCpQPH65+7xtyRKJabJCE6Qq10GBotCN76wo+gemQ6S4X5I56DNgwpwltXY3wu
	OIIVbSHWUW5uId0zGRXoIc6/1n0EIQD7J79LADrsz0Kc1IEz0S/XGMWG4LKGgIe4QXOibMKsF1o
	+LaeVujXmA3og/SL+VBq1vN3ZO4bmmSy59VI0Yt7/vcNpej7rFBlf+6/+GEvHzZWKNWC0kbZOe3
	0WCdTTtYkeXlnyyrWbtGvTluRQWBRWw4owJkBZsx4BT9SLdKkL0WUgMPk/POCTHxujeUBlcdfOP
	vNgRtimHexxdFYfK5fK9jktqQB3irAGvQqkXzU9oz/spbQvRFdxCfyr2rpk+q5rt8W/3jz7kFmp
	jNKqrKH3/sJCIPFsE114BBWpo5bmdgwdI8SCQ=
X-Received: by 2002:a17:902:d511:b0:2a0:8358:88f8 with SMTP id d9443c01a7336-2a870d721cdmr63618915ad.22.1769637143057;
        Wed, 28 Jan 2026 13:52:23 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4317sm31576155ad.85.2026.01.28.13.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:52:22 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/4] net: dsa: yt921x: Refactor yt921x_chip_setup()
Date: Thu, 29 Jan 2026 05:51:55 +0800
Message-ID: <20260128215202.2244266-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128215202.2244266-1-mmyangfl@gmail.com>
References: <20260128215202.2244266-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254477-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 639F3A947C
X-Rspamd-Action: no action

yt921x_chip_setup() is already pretty long, and is going to become
longer. Split it into parts.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ef9048b904ab..31ed21acb5df 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2902,7 +2902,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 	return 0;
 }
 
-static int yt921x_chip_setup(struct yt921x_priv *priv)
+static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
@@ -2920,16 +2920,6 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	/* Enable and clear MIB */
-	res = yt921x_reg_set_bits(priv, YT921X_FUNC, YT921X_FUNC_MIB);
-	if (res)
-		return res;
-
-	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
-	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
-	if (res)
-		return res;
-
 	/* Setup software switch */
 	ctrl = YT921X_CPU_COPY_TO_EXT_CPU;
 	res = yt921x_reg_write(priv, YT921X_CPU_COPY, ctrl);
@@ -2982,6 +2972,29 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	return 0;
+}
+
+static int yt921x_chip_setup(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	ctrl = YT921X_FUNC_MIB;
+	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_chip_setup_dsa(priv);
+	if (res)
+		return res;
+
+	/* Clear MIB */
+	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
+	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
+	if (res)
+		return res;
+
 	/* Miscellaneous */
 	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
 	if (res)
-- 
2.51.0


