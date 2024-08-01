Return-Path: <netdev+bounces-114936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B306944B5C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA51C24951
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678021A255F;
	Thu,  1 Aug 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7h8uuWO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F21A0712;
	Thu,  1 Aug 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515522; cv=none; b=WHKLDGYUj/MgaB6o1+OPmTvXXunZcedkueCRZcf76zF8M5cmmGSU311TpbG3YCdkL1aXEsLZCCbKNITib74S98+6vinuskO38ZbW6bcq4T6BesDxRHhieVuqbFg5/esuE2Ve8OqUgB/W0Qyh/LazIR0bLKfhk/aXwAuJUxsCm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515522; c=relaxed/simple;
	bh=QtwI/SVnKK39mu5c44gcfyspxOqmSWTJf+GlORnTm/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGoMj9Jsn5Z+ix9A62WEQ6onbP4BsdbZOgUJQ93/TqW1yOWokfyQcojVkRRKAGJlKhg3SGFIs7GkR4LkJyohQExbFs3GyQpNEWd4j+NVjJdZLqBbuU1A/ZrOsPSc0XZyycWuzMFUQzKSuHiPv0L+wvBC64+7CVBRiFDfz7WBqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7h8uuWO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso3960467e87.3;
        Thu, 01 Aug 2024 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722515519; x=1723120319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhsJwOD0AmgzizHrQAX5p2iYi8nxQcGqZZOURMkeQdw=;
        b=b7h8uuWOpcrjtYom1gdo0ImGSGNzy/1dU3w/DcnZbC4/NwIxUob0XqbSxXmN21VliE
         81YGqZMe4qDv/Y4cSJkzJYI8s92sphBo6Mb0703GzNjanBu12GEQiqnnywnKzsmXR9uu
         YJCBqqPgE8Sjoc0IRZ5xskrwZGfSCoUB2lyXwrWi79LpskmQtk+gMqZUXPD2EUzzTHl5
         5aw0vPfczQYBK80FI0MrsWLpWtkFMHDvq0CZCVtDoKD41ILFeCx1ZkT2MIJFgs5quISZ
         WB8WrEBYjlwzInKcSY+Y5DCoUCgPqBVluVfFQ6KBZwuV9ZICc3wyNjMvCSLdPsG2ANiz
         HKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515519; x=1723120319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhsJwOD0AmgzizHrQAX5p2iYi8nxQcGqZZOURMkeQdw=;
        b=i+zwYDE/1QcxopoOzOKzthhI3fV1VQ7PqgmIhgHyZBSeax5CAa+QDj+UXFER+LD5gu
         r/xaDQ082a1CRaM3OQFTtrCgN+phbEzf+Ao7CvF5YiKYh1tIDnmNtHoxOzXffuiOEK6c
         4vVI6elVr8rpB0mTbP429jyjugfHj07b2CMvM//oyYs2Sqk0vWDcb7TvYMJnaqSpUpBd
         EjPsxIp6eKFYSNbjWXpNdqlO7TCzrvwzB6Ypr1DM8MsNiZBzb4cLlDMdc3mUcRLG6kVe
         iRlhJ+EbYcfTd16xvfLd1YEdve/vapEGZjKqB+TMyh+zJyxtXfNpo+ussFUxspcNnrLu
         j0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX1MK4EWQEDHwGZbboZZ5rBtrsfBlpPYPtcGzGAdpxzXAJAQkmvuBNovpaiv/j6dZQnhKVVDucoRtsFvYGbASwvF648v+lu
X-Gm-Message-State: AOJu0YzOZO2+mUaEjRmO8OWssXtp9GQRqx8OkMq+7RhyaxUuR9Kw+Z3u
	uOhNw/90dsKgVdUjnRLkcZRZGH67o5p6JDnMFT/pjUQbEMFDGKQvbf7MFXHEO8k=
X-Google-Smtp-Source: AGHT+IFy+oio3PBu9zUszsHmAOR8iXhQ5FGKTSHWDnj1GQke0pmZd0Xze2SzHEGQnCJBBS2iGsQ1dg==
X-Received: by 2002:a05:6512:b93:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-530b6218752mr2237096e87.52.1722515518030;
        Thu, 01 Aug 2024 05:31:58 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23125sm896146266b.1.2024.08.01.05.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:31:57 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next 2/2] net: dsa: microchip: implement microchip,no-tag-protocol flag
Date: Thu,  1 Aug 2024 14:31:43 +0200
Message-ID: <20240801123143.622037-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801123143.622037-1-vtpieter@gmail.com>
References: <20240801123143.622037-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Implement microchip,no-tag-protocol flag to allow disabling the
switch' tagging protocol. For cases where the CPU MAC does not support
MTU size > 1500 such as the Zynq GEM.

This code was tested with a KSZ8794 chip.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz8795.c      |  2 +-
 drivers/net/dsa/microchip/ksz9477.c      |  2 +-
 drivers/net/dsa/microchip/ksz_common.c   | 11 ++++++++---
 drivers/net/dsa/microchip/ksz_common.h   |  1 +
 drivers/net/dsa/microchip/lan937x_main.c |  2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index d27b9c36d73f..0442341d6d0f 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1604,7 +1604,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	masks = dev->info->masks;
 	regs = dev->info->regs;
 
-	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
+	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], !dev->no_tag_proto);
 
 	ksz8_port_setup(dev, dev->cpu_port, true);
 
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 425e20daf1e9..a3c68751f258 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1195,7 +1195,7 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	/* enable tag tail for host port */
 	if (cpu_port)
 		ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_TAIL_TAG_ENABLE,
-			     true);
+			     !dev->no_tag_proto);
 
 	ksz9477_port_queue_split(dev, port);
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b074b4bb0629..fbbf26e940bc 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2882,9 +2882,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	struct ksz_device *dev = ds->priv;
 	enum dsa_tag_protocol proto = DSA_TAG_PROTO_NONE;
 
-	if (dev->chip_id == KSZ8795_CHIP_ID ||
-	    dev->chip_id == KSZ8794_CHIP_ID ||
-	    dev->chip_id == KSZ8765_CHIP_ID)
+	if (ksz_is_ksz87xx(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
 	if (dev->chip_id == KSZ8830_CHIP_ID ||
@@ -2903,6 +2901,9 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	if (is_lan937x(dev))
 		proto = DSA_TAG_PROTO_LAN937X;
 
+	if (dev->no_tag_proto)
+		proto = DSA_TAG_PROTO_NONE;
+
 	return proto;
 }
 
@@ -2912,6 +2913,8 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 	struct ksz_tagger_data *tagger_data;
 
 	switch (proto) {
+	case DSA_TAG_PROTO_NONE:
+		return 0;
 	case DSA_TAG_PROTO_KSZ8795:
 		return 0;
 	case DSA_TAG_PROTO_KSZ9893:
@@ -4459,6 +4462,8 @@ int ksz_switch_register(struct ksz_device *dev)
 
 		dev->wakeup_source = of_property_read_bool(dev->dev->of_node,
 							   "wakeup-source");
+		dev->no_tag_proto = of_property_read_bool(dev->dev->of_node,
+							  "microchip,no-tag-protocol");
 	}
 
 	ret = dsa_register_switch(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..19cc0dd0ac03 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -174,6 +174,7 @@ struct ksz_device {
 	bool synclko_125;
 	bool synclko_disable;
 	bool wakeup_source;
+	bool no_tag_proto;
 
 	struct vlan_table *vlan_cache;
 
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 824d9309a3d3..a9345da31ef5 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -182,7 +182,7 @@ void lan937x_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	/* enable tag tail for host port */
 	if (cpu_port)
 		lan937x_port_cfg(dev, port, REG_PORT_CTRL_0,
-				 PORT_TAIL_TAG_ENABLE, true);
+				 PORT_TAIL_TAG_ENABLE, !dev->no_tag_proto);
 
 	/* Enable the Port Queue split */
 	ksz9477_port_queue_split(dev, port);
-- 
2.43.0


