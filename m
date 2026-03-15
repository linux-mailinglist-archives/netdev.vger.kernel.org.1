Return-Path: <netdev+bounces-267967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HijEZAot2nzNAEAu9opvQ
	(envelope-from <netdev+bounces-267967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:45:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F89292AF7
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B9D330067B1
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383FA37B3F2;
	Sun, 15 Mar 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e46myE3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9C374E68
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611148; cv=none; b=IHVFNTo8+eOvA2RMKDl4HJ9TzArpEzNlTC2j8GI6S9mFWnMy/HJ+Q7x5vQ8524S2HZlpmvk2lkUgM1hV6B5sNvur3PqeOMbMgyYPLHVB0mC5nVGuRWmoDHOjKh3klY7Gg75rKQT8aWfyu1pcevvrXlfBmUFiR1qHyjIPo0pFCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611148; c=relaxed/simple;
	bh=aDq5/Ah0sdh1k75i3B0WqESBbxVClGyPzVCwYciSCos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JApQPNbtz37Z7Tjv+GdF8LCKVcmDEF1zsbapMy07BOzDdSLqWGEj9KNLVs8fMInoKZGHS0bKqLlpy33AZ9miICW+6x6xZebN1dxSXVFkZsFzgd3q3D8Op6OG4ohnczI0WwOlPJomtYNjZYsCkWRXF4m5a4bVhEHy5MyZhu58p6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e46myE3R; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73c990a96dso1407677a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773611146; x=1774215946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OTxU8esPzpyCl9gls//ZpDXaOoC5yMxz5Pjw0QxFzU=;
        b=e46myE3R2+4C1Ttg2vGQ9BwrrLBhgp/D95ZHi9KD3mG0hI7ZXeY7ss73tPEOxUI5ZH
         rqq/j0Y1zhZNYNrC7T3LMhoiFeyavf98ulcRWISC6XpKxUzslAojARf9tYqaoVzW7OiE
         IJ4dguQv8yq5jw5mN+03/7gs3j+jSxL3MZdWgLtbP0Cgn5rUgdXDXeWmyTHnZ+bw1HX0
         4lGJmuPiHSiyqZ16wk9xm7hNln62ofe/8DVupIZi8oVN/CenVtezTpzF6fQMarWprKRN
         OpCtYJt0lMF9sAS0BOz49jynSdxtdFbUJreFs4/ZE8O2p/Ka5glmFL+2rgOXhsFVYrGP
         7liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773611146; x=1774215946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OTxU8esPzpyCl9gls//ZpDXaOoC5yMxz5Pjw0QxFzU=;
        b=B/eRAFG4f7dnAPiOeRCPCQPQveqhdkVTvLHTIUSgMiVyUwZcwSrvKurjxdqgrYNein
         fS8oZKEOyF7JxJnjMx3PXL6CHhi5JO+Lcs72LwTQGJ4U/8f8BjOzhZlqvJ+8Lm58iEym
         2wYMOC/faR1o5867ssm/La0GeZcpo6ULBgCyQ2WYdFBSDLb+UpMclJaKTM/l7hZl1Ox/
         RYYHVR6lnK+AwMO1zhj/EsZZVnhIlL5QsD+7ZMsZ140MLG+3BHW6JXUkHGB2eM4z5ntM
         SRB21H8F0D0vlxUdNzhFPL95Hd2WhrEz3qsKjiPiqzuyPSCfKqDaziYcgmPXBNi1V47T
         pU5A==
X-Gm-Message-State: AOJu0YwsTlhJm7nl3QnOowEBghp1z0XdCPESmIzTJmTVHNGVXZPReXLL
	Z+bfGwqpJqRrsEf3QKB4oyN5yWtW6RV+ioD36lRHY3wFF4FLyA8QwzhuphnQ3A==
X-Gm-Gg: ATEYQzxstPfpSaIG4IkaaMmAMmijHf/TWw88GM4YdNsJf6hy7gJUnY5VTU/cPftNU3k
	sgs4I+dJt7V1BeJWYwSspd5LZfkpo/aJVMFKful1UIqmrtU3nHyaQNrqaFcz6D+oKag7rJXNmKO
	8eF1MnN80N8YNoaV0K6C4chd2fw6Mlio/mBCLELyJYPGf3gWcNKCs5hlciorQW4FKf4H9MDh++s
	s5kg6TsqD4rtqd13REWuu2q4mOWs0jBfRWu409zHCad4vb8N/k+5OE0+Qb6S5kyPt2BnzXpc23y
	EKTmb6hhf3ClPv0fRXMhRckgLP62NEglvRXhvRPHGs6uwPyz/e9buY9TXdEQ4Oor7NkyN8fRp6b
	Cj4bRBkaqoyXEqZPbZ536XMq+3X5twsaKh2ZOVEHnJ2HCn/sRk2KGFACcrsRya8BRnvFPIHZOu3
	M5CChjHNN5NIRASynaH4urzugv9FBGE7/E1AIg6ui4CnscsDRVyw9f0Hw=
X-Received: by 2002:a05:6a21:1f81:b0:398:9c2b:c93c with SMTP id adf61e73a8af0-398ecb28d26mr10410807637.28.1773611146107;
        Sun, 15 Mar 2026 14:45:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74029fa6eesm1687638a12.20.2026.03.15.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 14:45:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: microchip_rds_ptp: simplify allocation
Date: Sun, 15 Mar 2026 14:45:27 -0700
Message-ID: <20260315214527.4113-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267967-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D7F89292AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Remove memset as it's now allocated by kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/phy/microchip_rds_ptp.c | 10 ++--------
 drivers/net/phy/microchip_rds_ptp.h |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 2ad95d5c9d86..4e6ed11f9334 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -1246,7 +1246,8 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	struct mchp_rds_ptp_clock *clock;
 	int rc;

-	clock = devm_kzalloc(&phydev->mdio.dev, sizeof(*clock), GFP_KERNEL);
+	clock = devm_kzalloc(&phydev->mdio.dev,
+			struct_size(clock, pin_config, MCHP_RDS_PTP_N_PIN), GFP_KERNEL);
 	if (!clock)
 		return ERR_PTR(-ENOMEM);

@@ -1255,17 +1256,10 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->mmd		= mmd;

 	mutex_init(&clock->ptp_lock);
-	clock->pin_config = devm_kmalloc_array(&phydev->mdio.dev,
-					       MCHP_RDS_PTP_N_PIN,
-					       sizeof(*clock->pin_config),
-					       GFP_KERNEL);
-	if (!clock->pin_config)
-		return ERR_PTR(-ENOMEM);

 	for (int i = 0; i < MCHP_RDS_PTP_N_PIN; ++i) {
 		struct ptp_pin_desc *p = &clock->pin_config[i];

-		memset(p, 0, sizeof(*p));
 		snprintf(p->name, sizeof(p->name), "pin%d", i);
 		p->index = i;
 		p->func = PTP_PF_NONE;
diff --git a/drivers/net/phy/microchip_rds_ptp.h b/drivers/net/phy/microchip_rds_ptp.h
index 25af68337b94..f5c6ab585fff 100644
--- a/drivers/net/phy/microchip_rds_ptp.h
+++ b/drivers/net/phy/microchip_rds_ptp.h
@@ -199,7 +199,7 @@ struct mchp_rds_ptp_clock {
 	u8 mmd;
 	int mchp_rds_ptp_event;
 	int event_pin;
-	struct ptp_pin_desc *pin_config;
+	struct ptp_pin_desc pin_config[];
 };

 struct mchp_rds_ptp_rx_ts {
--
2.53.0


