Return-Path: <netdev+bounces-209597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEABB0FF45
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06C65676E9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B71F1302;
	Thu, 24 Jul 2025 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO6Wr8pn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD94C8F;
	Thu, 24 Jul 2025 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329199; cv=none; b=Z6+ZfuCOh5LnVy0WUvZ8Tw3N3fngXQYMIFfNVFont8IE2QbqfBzm6H8e6jWt09aS4luGSasZAEKYSa1dy6GBZNaTm3nX6tt5+H4xApyXleZwciNeiUomncUUHMqFL/kVLSs42DKpP53yJ8YvELC88z2pMDGo58qQYglyW133ReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329199; c=relaxed/simple;
	bh=40ID9LwmbZQvY4IVVC5AV9HRX2eh8Q1dMvyuSklnePA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E69YTEHMtAm7hlUOkjoCX7nxbWO9Y3kwQ6Tb1psZx/zBDzppRdfJ8x6Lx8RocGdIL1DZDjVKgkkVF6VzIfJHzf5ETZVOvy0y2O+PK8P/ADmAXig9PshkKJzboNLtvogA+mfa2N/87WZJF1u8CJaSieImQm2UjWzZsC8BjiW422E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO6Wr8pn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234bfe37cccso3784585ad.0;
        Wed, 23 Jul 2025 20:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329194; x=1753933994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7hrIaZ1qUp9h+Ub9vEBBV5UvaIFXQhNuBwpXW3Abrs=;
        b=iO6Wr8pnL4IR9lEGfFReNrknoJnFdGNRwwA0kKWTNhxT+kmFisn1CCpFJ05Z9zuucQ
         mzlIRJ+cuVnuzc9miinjO3ucbwQaEFkRutFVeDqu2xdbJmKFVy5kZXf2CcS2KKT/acF4
         8L9Rw1bjZJ9CDBstmPBf+Led9H5uejFoyFNpucT/XjOfDCzSyb37HnIOH0nVb+oxyQkG
         8C1MsiXEBAoIoscAN8Vzw9lTIm6MIHHM1xUA6O+NFoks9nEBvfqEQVdaa0ImVIT4j+fl
         MbarY61IAG4uZ7tF+5eJeOuut04HcQj5tuWK3Mg3eJoizLwTvNZgEDNzpuoBiwp+IM2v
         T89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329194; x=1753933994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7hrIaZ1qUp9h+Ub9vEBBV5UvaIFXQhNuBwpXW3Abrs=;
        b=eNVQWRt2e6/9MQOSKeq913E2PMi04xoQGgVdqYbCGhrpZs0f/JrtWzZgnpvLkq5zf+
         8QUE9vCPxkhPJwRhGdg+vr1s7TgzBEGPUCL3hDsMRgyaGTujH3hYfwtbUfeufg0KZ5v2
         bXAZkRsnOLwGcE/QUNIdtdFjFB09lVQo1Z2KskNgtre6y4D9rR0B9wmNeTZ1IwRgpieh
         baGQSsJ+HQMtSiJiYsAU1zxYtFE+Ns3Sbn+plb33LegCkrA9SOh8qli03ZrPYWAVUAyZ
         VtD9/AiYep1Rfe7mlTadUyvySYWOCWIOEfR2c8VRLr5ss4E3HskjgjGeGRCYpYD4okhi
         uNXg==
X-Forwarded-Encrypted: i=1; AJvYcCVAA5lpglUDo3wQBoaAZi6l0incXwbvcRNm9pfkxcGCcETpkYJfhSCrjU1R9plqMISvzL6paHYy68wPxnlV@vger.kernel.org, AJvYcCVrLBtm8m8K5shYxkB/Ia8TjEVddkU0YYThyvfBGllhlcmtKQJShx+egzEDHJJXDAEAHI4SH0K9@vger.kernel.org, AJvYcCWH8L6LIHxfCgwxfwvvaiD3hjM2w37FWc5OfzhJDtsrs4V2gPsgUCuqNFMBjpQPbvHwJC0leL4FOLUp@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMzKYeNTF2uwYItvavbC+u4WWVLUscj32EExSfGmCPFDViFju
	YuAVJ+s2Udi/Lk96qRH4Tv0UGYvjJO1DS6sGXNf96VQHrD+GagtNCDI4
X-Gm-Gg: ASbGncvN7Lq91Q+xt0KQ3rlUW2GPou4Nrng6fmBIP3hX6MMnHBzNoVNYX08bmUrGMEC
	2aU0INgjRQIInRjXGVQ4+6wUVs5Wna1Mm4MAa5mz7V4at4mFEoUs5F8cIo9nm1fhGHpuePtdwWD
	0YUFcCz1E55o+2TpjmFl+xqRc37wLOkkzyia84iUzCpt9D3MerIhwWZaYMpz8XyX3N5vzeBEdlh
	ZbNsNCYcNNqBWdBgNKhtUi0WZbEGaH5ubPpsN81big1WgEYOhxg3XSkZifKhTTEHqkpbRdDRY/G
	T14eWh49JZLyPBbAksaRYZISN9cLRvMuKgrWenijRi/fA55/hSdP04n04xZGxQ9R18LquaDr2rF
	fHnnTQZh4e7CRU8zdcrS4CT0e9SQxVGcut5DtE2EW6oJYIhQRhqU=
X-Google-Smtp-Source: AGHT+IF8jawENI+DTh90xkzOqLBWt/Uin9ZB7E6bcnbOXeHNaVSWe6pYEults0rysxEz2L68L272pA==
X-Received: by 2002:a17:903:2f50:b0:23d:ed91:6142 with SMTP id d9443c01a7336-23f9821d1c6mr77745195ad.42.1753329194511;
        Wed, 23 Jul 2025 20:53:14 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:14 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/7] net: dsa: b53: Add phy_enable(), phy_disable() methods
Date: Wed, 23 Jul 2025 20:52:40 -0700
Message-ID: <20250724035300.20497-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724035300.20497-1-kylehendrydev@gmail.com>
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add phy enable/disable to b53 ops to be called when
enabling/disabling ports.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 ++++++
 drivers/net/dsa/b53/b53_priv.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 46978757c972..77acc7b8abfb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -689,6 +689,9 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 
 	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 
+	if (dev->ops->phy_enable)
+		dev->ops->phy_enable(dev, port);
+
 	if (dev->ops->irq_enable)
 		ret = dev->ops->irq_enable(dev, port);
 	if (ret)
@@ -727,6 +730,9 @@ void b53_disable_port(struct dsa_switch *ds, int port)
 	reg |= PORT_CTRL_RX_DISABLE | PORT_CTRL_TX_DISABLE;
 	b53_write8(dev, B53_CTRL_PAGE, B53_PORT_CTRL(port), reg);
 
+	if (dev->ops->phy_disable)
+		dev->ops->phy_disable(dev, port);
+
 	if (dev->ops->irq_disable)
 		dev->ops->irq_disable(dev, port);
 }
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index b1b9e8882ba4..f1124f5e50da 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -45,6 +45,8 @@ struct b53_io_ops {
 	int (*phy_write16)(struct b53_device *dev, int addr, int reg, u16 value);
 	int (*irq_enable)(struct b53_device *dev, int port);
 	void (*irq_disable)(struct b53_device *dev, int port);
+	void (*phy_enable)(struct b53_device *dev, int port);
+	void (*phy_disable)(struct b53_device *dev, int port);
 	void (*phylink_get_caps)(struct b53_device *dev, int port,
 				 struct phylink_config *config);
 	struct phylink_pcs *(*phylink_mac_select_pcs)(struct b53_device *dev,
-- 
2.43.0


