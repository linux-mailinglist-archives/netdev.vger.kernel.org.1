Return-Path: <netdev+bounces-102699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F405E904553
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEF51C22CFE
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74544156C77;
	Tue, 11 Jun 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTbU5Wj0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7435156F2E;
	Tue, 11 Jun 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135493; cv=none; b=KrQy/KYzzE5RJcXuA5FiG4FTAdFoOivMvX8PvYcQefY6zU0tKoBtE/3i7PWfxHCV0iXmgoG2y5kHKVx8V2VhRpu5JX1zAsn77NwjdaSgUOLugeSjweNHQz09+BNiMuF4bHXhK67BRD9LtOxhwDNHC3QjBCbj5G7bjAPHAQt+JzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135493; c=relaxed/simple;
	bh=ZlQWRLWgOu2Qi85OCTxl2HybPMlfiOoh6DRNweGKCaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEgf8Ij2uEjlxTeve4BLKPZznZWW9bK72PeXXYC6CGxuNCtBiWICIgTApLmlJQBnI9oZRoFS6Jui4iybzQ0V2femm1Pya+QG9Z0v/1qg+yCg5SC9mHkSJB1ndkGJNwq47GDktp6dTDFXNlacqniIsbVKmFBT1RkTPS2mgE/t7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTbU5Wj0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so5370561a12.2;
        Tue, 11 Jun 2024 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135489; x=1718740289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EcKXTdU/rHpORXQYu7ZrEBF+RV8M26YBMM/XJd4Ec8=;
        b=LTbU5Wj0aIH9ZCEUGhhaLQM1ZpUv/v4BK4V0UpPxqrUcaqx9BfSb3ETiV88Eg9AGDq
         m0+AyjmNghsG/bzBOreAJmSz0mJ6QwKY3dyA0lJjWUqP1xISpo4Us05DcNNYHaatYAze
         iPOEOJRN1M93OJ6SSqeHm8ceNbkHi82PkhtLHBh84L+8k26FDqE95DqJvkyktrl9DXHQ
         bK62ydyB79V4iJxvhtx0IALwH9n0s7+i5Mk6zBTNnBxY9YKhpa2jBMXnj2hatuLmvfG1
         eOiVMQXVVJIuz3VDx0LHfC1D6kC+LLiuF+F3WSu/5ZKw0wxWbtRhhAMqfy9goEJ3+H6J
         xCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135489; x=1718740289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EcKXTdU/rHpORXQYu7ZrEBF+RV8M26YBMM/XJd4Ec8=;
        b=FuNR2WzeY2iCiC/pMmuu/eiyOcmRyWiBp7yneJqsED0N+1xSQPtTvjsmq3vKPgTrAx
         s0JkR+LaX7AezngIDirhu4dyZ3jjvRdF/p8BjyrGXbksAX0cFZ0ygh/MP/d88UL4orYJ
         h+3VoxWqRt0/EiiCOZ8vXRocubi2/Za547aVPkvkTCJyt8wt0q5BeeWGIuinVkx8HOlu
         RaHPFUiUm5N5kj/ojvXxVoKqLAzBzcm7oCB8/NjF34wEhzozhT8tn+nIbx9T3PNu9K0u
         uTbp7Emdpt0QCa32zjpqgyfdA+gXwA4/upky8L6VMF8Uke8iWgqOjP4UGvaqgYwWri5V
         isYA==
X-Forwarded-Encrypted: i=1; AJvYcCUu462hwP48nMtQuOHHmdqlmgRvTojawRib0socNrg7b7Sz7UgR05P08HFJIEE4d5rcl3QuIQpAY29D78BFu9mNNT11lq38MX9YjyS2
X-Gm-Message-State: AOJu0YxJ8P5+gjyQ7PzeEgRy1t6xirVJlzFm6ravUH5HK6+awV+hRGMv
	JDsxJcsGwWZjqeiYU9/AXdz3euyxu1oIaDL8q5oau3b6+KWUmZkLoRcIq+4ClM8=
X-Google-Smtp-Source: AGHT+IHnLoZG3nr9h1y2gqPTc1Aib48NLG6kGsDXEg3qeh9Eyft5qg1elJokHGGnaReTIxm3OyMKqQ==
X-Received: by 2002:a50:d48f:0:b0:57c:628a:1759 with SMTP id 4fb4d7f45d1cf-57c628a1ab5mr6315378a12.8.1718135489313;
        Tue, 11 Jun 2024 12:51:29 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:29 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/12] net: dsa: prepare 'dsa_tag_8021q_bridge_join' for standalone use
Date: Tue, 11 Jun 2024 21:50:02 +0200
Message-Id: <20240611195007.486919-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'dsa_tag_8021q_bridge_join' could be used as a generic implementation
of the 'ds->ops->port_bridge_join()' function. However, it is necessary
to synchronize their arguments.

This patch also moves the 'tx_fwd_offload' flag configuration line into
'dsa_tag_8021q_bridge_join' body. Currently, every (sja1105) driver sets
it, and the future vsc73xx implementation will also need it for
simplification.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v1:
  - introduce patch

 drivers/net/dsa/sja1105/sja1105_main.c | 5 ++---
 include/linux/dsa/8021q.h              | 3 ++-
 net/dsa/tag_8021q.c                    | 5 ++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 0c55a29d7dd3..c7282ce3d11c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2133,14 +2133,13 @@ static int sja1105_bridge_join(struct dsa_switch *ds, int port,
 	if (rc)
 		return rc;
 
-	rc = dsa_tag_8021q_bridge_join(ds, port, bridge);
+	rc = dsa_tag_8021q_bridge_join(ds, port, bridge, tx_fwd_offload,
+				       extack);
 	if (rc) {
 		sja1105_bridge_member(ds, port, bridge, false);
 		return rc;
 	}
 
-	*tx_fwd_offload = true;
-
 	return 0;
 }
 
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index 1dda2a13b832..d13aabdeb4b2 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -18,7 +18,8 @@ int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
 
 int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
-			      struct dsa_bridge bridge);
+			      struct dsa_bridge bridge, bool *tx_fwd_offload,
+			      struct netlink_ext_ack *extack);
 
 void dsa_tag_8021q_bridge_leave(struct dsa_switch *ds, int port,
 				struct dsa_bridge bridge);
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 454d36c84671..81ac14603fb0 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -286,7 +286,8 @@ int dsa_switch_tag_8021q_vlan_del(struct dsa_switch *ds,
  * be used for VLAN-unaware bridging.
  */
 int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
-			      struct dsa_bridge bridge)
+			      struct dsa_bridge bridge, bool *tx_fwd_offload,
+			      struct netlink_ext_ack *extack)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	u16 standalone_vid, bridge_vid;
@@ -304,6 +305,8 @@ int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
 
 	dsa_port_tag_8021q_vlan_del(dp, standalone_vid, false);
 
+	*tx_fwd_offload = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dsa_tag_8021q_bridge_join);
-- 
2.34.1


