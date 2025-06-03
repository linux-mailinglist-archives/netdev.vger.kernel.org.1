Return-Path: <netdev+bounces-194838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CD3ACCE66
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9C189610E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2B23BCE2;
	Tue,  3 Jun 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDMsNvsP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CD22539F;
	Tue,  3 Jun 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983752; cv=none; b=D79t6aPddyu+J8/CWLCuFHMqcuv2/byEOR10L2L5Hqhdv/rHs2oTUgWbFadgP7BoctQ7L+C46BB45qHJ9Ndm+qupYtCFyfOEfhl5ihyOEmCfIvX8PotE+zJtMKNNWHeU/fOSsckKw+VT0J+Z/ZUjocGYKjEAIk0EnyYi0JUV9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983752; c=relaxed/simple;
	bh=R9PLylbzZUPbUe0c6KxGPPdXB8z4mSNhSyKwVyQ3f4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Szp8if30bnH9tMoAVsXz6ghvBD9+7hjhlZHg+Cc3frx2bZAGmROBdj5pOxAvZAuVZYaY/x6GACQZC6C8rOzuply0NTTDtvy9jbMTAoMtR6iKHR8DKJFlnQp4JpCK7BdPdR0qLxsg59+8uBA7eA/ieXl7/sYA7akj+HNARq1Pwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDMsNvsP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36e090102so3547060f8f.2;
        Tue, 03 Jun 2025 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983749; x=1749588549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyjQbUGLzhevUUG6mqEZwljpIOzcn4r41+/GD9oU9Ms=;
        b=KDMsNvsPk92UurnpoWzTPNBQminy5Xyzw/wpd0zFJlmY1mSdgk7UuylF5UvtlKVIkT
         gZ7GitqhGA3eS1143NI0kYgTt8AzswOh9uKzPp88EYDrIZqsKj/HSMNUgumX5NH4sPN4
         hxu8tGqVDGNrpGN+blLgCmEVGTnkkHyR5RDUU1KbDXkhDCgpECOsR1ZEuHuVp9KZOb1f
         PfesIZDWsCYdBdojK6LmKt3QU4e8+08k0yctB4muOBTeBmFtwN5gkFrRDLpp6Je9DZIf
         ZpDJ0NjEcQ9vBZA+Sg5WrDIs4Vv5cmSw5zvG535pzYsRag/4ELFQDI/CP7mycIQ/jq3V
         dppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983749; x=1749588549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyjQbUGLzhevUUG6mqEZwljpIOzcn4r41+/GD9oU9Ms=;
        b=dnkfWmuL8So5n9xXoGpmUcUbl+4+BpJNvbuNFRi5QaxC+PdhSYAUr+42ysbqZKXC/2
         voVaTGP8dlOThHQhcgySNj6kRRMQ/HLxDnhIsaGcG8AWd/NUHEzOBEhyHgcY2CT0VOnM
         KC4rUByHSH+FduE7Txgne429mE5i5yuVda/Eg3a4FPu/m9VZbYennt2H8Nw5YfhWCiSC
         ESX7dvLnFPYjLfChUZPirx1FhIph4+OZbO4d77VSp5L5r1TWzmob1zKTz+zhhLafwhil
         8H9pztDNA22MCE2fbHKVgORl4VtfUIWmD7xsaOUTvTmoEVVzDoyNEEXxiaQO+eo7YN01
         k+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV7dvbc0iFlpyMk9v2FaE182TuiuvPUOjuj8ehaKaFMlTzKQmvH1I8o0MgMAS6v2ABScFfdq2qGKrBDhoM=@vger.kernel.org, AJvYcCXMlS5QlEB3mJZZvtvFaGudzsfgVJqaWLSiZel0Aq/LtG1WdIZEIj6sni29lSPQ1Qpzq8vSnuCA@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoQjb7cSFIs5kpQyS2mE4vZZkFduk7j/cDSg/akamL9ve9+RI
	Nm94aovTjawv8WdHnG3+QrdEnN8G/vomIqC8yyQRtwa2dA6sV3pD5qyFQ2CRDA==
X-Gm-Gg: ASbGncvnEq7taagf9q9hT0lDTh84fBo0WTm48tqRb9zZPevET2NNfg3lFamMmW02Wz2
	U5LG8iF/tspxT1VgT8IZurO2bIpEQTDx4Qe5MgsfaAYyzLTm6EMDlxtiEB9cZqTJZ2GdzTXXg5b
	J7KuY4FIT2FYu1m4eqH1TCgAUHDs688ACn8j3Im/kbHqvDzIZJbwh3ebIBd6BuWvFCPtxaiut/o
	kfDHBBtitP9k43MaS5YDrfLjcFUiZ5DOhzBxy01ePfa3CZfFqQz9Nu2kjg5o9f1+xWDZ0fABqF/
	ph1OZ3i7ts3iQQKf+mmmhmPtzDWDXkWkZu+mpWJ6dqEnw9/hAWOizjVo8u4ZEhFcHdN4Pfu7wJq
	H1PCIxK63VrYSUpMlKIYDMZjEIKkHg04+pNYG22BQyY1kE+b0eKKN
X-Google-Smtp-Source: AGHT+IFxbgmPgPy8L1rNEmifwRytupcobckAzCPFGEe3JDSyLkdSwcMYVhhle3hat9C4q0vsawS76Q==
X-Received: by 2002:a05:6000:2dca:b0:3a4:e672:deef with SMTP id ffacd0b85a97d-3a51dc316bamr74245f8f.36.1748983748670;
        Tue, 03 Jun 2025 13:49:08 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:08 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 04/10] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
Date: Tue,  3 Jun 2025 22:48:52 +0200
Message-Id: <20250603204858.72402-5-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FWD_EN.

Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 18 +++++++++++-------
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

 v2: add changes proposed by Jonas:
  - Change b53_set_forwarding function flow.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 1e47ef9f6fb88..f1e82a0e84ea9 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -365,14 +365,18 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
 		mgmt |= B53_MII_DUMB_FWDG_EN;
 		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
-	}
 
-	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
-	 * frames should be flooded or not.
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+		/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
+		 * frames should be flooded or not.
+		 */
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	} else {
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_IP_MCAST_25;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	}
 }
 
 static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 1f15332fb2a7c..896684d7f5947 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -106,6 +106,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
+#define  B53_IP_MCAST_25		BIT(0)
 #define  B53_IPMC_FWD_EN		BIT(1)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
-- 
2.39.5


