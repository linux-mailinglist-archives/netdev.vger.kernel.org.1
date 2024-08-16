Return-Path: <netdev+bounces-119122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D72954235
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361301C2374D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4304584A50;
	Fri, 16 Aug 2024 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuDslFP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568383A14;
	Fri, 16 Aug 2024 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791592; cv=none; b=fPDsX+sCv11B+UJih6JE69dcK1MU0hZWkENgswEXL7Yt5nqRlRJvREKAEqhrkNkp/dRtl2tF0/OJMAtpU87kP0qYMdGs5bsN3shFLsTTh9yurisFgbbcLlTY2PkYAEP30Uw8f2YxUbgeybLK1C/8Ix2g3yjzVHzJbrl9QB1JoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791592; c=relaxed/simple;
	bh=aTYR+JUVs+cEg8fmvT4dPigLWGYk1EidgLaqah9Pnh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TU+J0kYkiV8NG+l0ZvcQEHeyGOso2ZfUV76Az7dYbHaAM/TeKcELv9J/FxcfUiEZdatUhEWfS0mGuR0cgiZ8adtlw9japIvICfFC8jDp7B70VkYWJLR04CcXaC88XZr1QFPsiAaZrQGdj+zO6ScRQ04L8sba6AViR4vjOnWPAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuDslFP9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so218877666b.1;
        Thu, 15 Aug 2024 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723791588; x=1724396388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrSZfU0OMtg2pLkGJtjlMeqjtIsOmu9nnuwhZZLpauY=;
        b=UuDslFP96eOxqDBx9HqvVVW9pa3pXTz4H9I/OUiMq/yDT5q/bPlT4gxIi1NNy1Nf/1
         grTNSY13dl9WOW9mkqmjhtNtzziQLoiRn79pMh2/KwbBpDy+4frAnKnF9qwsgwFVTV/A
         SP8rT29EF29oP32tSb+WcBKHMX2upjvEXw4jieJ/f/QVzDucYhZs5+++eAjJ2evn3zcA
         nTUhBp+LET5bFw7XQUExbV+6aR4mvzzZXdH/oVRFA1lfGBoZLnFs/ChyEdye1C81YlI/
         IXtM5mCjARuirMvdXTz4938wgh+ZiR4ktZxOqgaAWYBix5IjgBdPWgW1Ky3UoUF0mZsi
         SLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723791588; x=1724396388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrSZfU0OMtg2pLkGJtjlMeqjtIsOmu9nnuwhZZLpauY=;
        b=wu3zvqF9u8k3/PMmdS/53LB7MhfVRb6lImB2TtpoSWNzDdrBQp9L2G3wuyWev9YRX4
         hXcyvenZ72hPBr2E1wZKiRMXI2iDLM95CbUok2xyRmX/ETNwsjIh9Cf3Dbbw+uR+988b
         /D1frRu41WQJdzD5xEQinidHg4aqJzvZJYSrRKaoNPNi2wzp7ecG5SkThFc5Ec1Lttzx
         5eLQPLNIB7e3rGe0YH4FnEgyeMnQXozeP1aFLRlTaYh0Xc3Cb39/OEQwN9cXbxPMAFEn
         MaHxiwL3pvJkLVwnHtj/O2wAIj39uUkDskgKbKLG2eJIPhexP/AuH6DWoW6bVlu8/9MZ
         phcA==
X-Forwarded-Encrypted: i=1; AJvYcCWkvglZ89az0pUN7bDYE0gGPNc9BD688AVw53z9DDhumCDM3Z8YvX9AQToH2PMS5DpbFAqyl21EttBg2aQ0xjaX/DC4CpH1PFBYl1fNBCTOiNv8++yvLj+Y2A75CMkN4HkEHfBk7it6JuzTxYqDf0Fwyzc9AZ1ZVBkO92so8kfY0g==
X-Gm-Message-State: AOJu0YzVG/tV/6FfswesEf9tErwLklBdaBPtawr+5NLgZahQvaU8MxmZ
	kxQOmzRPOrCUhN/B+SzdApuSaj6ght8Vr5CvhO3RB/yOX9WW5rjh
X-Google-Smtp-Source: AGHT+IHjVBPVXwHBbYDxn/YsT+mCQ+8OMZ4Mv31vCZLDmP89hU9ANv2vEvnDmwvDq50EeWC8dV+iVg==
X-Received: by 2002:a17:907:7b8e:b0:a7d:e8f6:224f with SMTP id a640c23a62f3a-a839292f53dmr133525566b.20.1723791588178;
        Thu, 15 Aug 2024 23:59:48 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396b7b3sm209148666b.194.2024.08.15.23.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:59:47 -0700 (PDT)
From: vtpieter@gmail.com
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] net: dsa: microchip: add KSZ8 change_tag_protocol support
Date: Fri, 16 Aug 2024 08:59:20 +0200
Message-ID: <20240816065924.1094942-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add support for changing the KSZ8 switches tag protocol. In fact
these devices can only enable or disable the tail tag, so there's
really only three supported protocols:
- DSA_TAG_PROTO_KSZ8795 for KSZ87xx
- DSA_TAG_PROTO_KSZ9893 for KSZ88x3
- DSA_TAG_PROTO_NONE

When disabled, this can be used as a workaround for the 'Common
pitfalls using DSA setups' [1] to use the conduit network interface as
a regular one, admittedly forgoing most DSA functionality and using
the device as an unmanaged switch whilst allowing control
operations (ethtool, PHY management, WoL). Implementing the new
software-defined DSA tagging protocol tag_8021q [2] for these devices
seems overkill for this use case at the time being.

Link: Documentation/networking/dsa/dsa.rst [1]
Link: https://lpc.events/event/11/contributions/949/attachments/823/1555/paper.pdf [2]
Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 .../devicetree/bindings/net/dsa/dsa-port.yaml |  1 +
 drivers/net/dsa/microchip/ksz8.h              |  2 ++
 drivers/net/dsa/microchip/ksz8795.c           | 28 +++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.c        | 19 +++++++++++--
 drivers/net/dsa/microchip/ksz_common.h        |  2 ++
 5 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
index 480120469953..ded8019b6ba6 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
@@ -53,6 +53,7 @@ properties:
     enum:
       - dsa
       - edsa
+      - none
       - ocelot
       - ocelot-8021q
       - rtl8_4
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index ae43077e76c3..802cb9d657bb 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -54,6 +54,8 @@ int ksz8_reset_switch(struct ksz_device *dev);
 int ksz8_switch_init(struct ksz_device *dev);
 void ksz8_switch_exit(struct ksz_device *dev);
 int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
+int ksz8_change_tag_protocol(struct ksz_device *dev,
+			     enum dsa_tag_protocol proto);
 void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      struct phy_device *phydev, unsigned int mode,
 			      phy_interface_t interface, int speed, int duplex,
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index d27b9c36d73f..0704d5404c5b 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -127,6 +127,34 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ksz8_change_tag_protocol - Change tag protocol
+ * @dev: The device structure.
+ * @proto: The requested protocol.
+ *
+ * This function allows changing the tag protocol. In fact the ksz8
+ * devices can only enable or disable the tail tag, so there's really
+ * only 2 supported protocols.
+ *
+ * Return: 0 on success, -EPROTONOSUPPORT in case protocol not supported.
+ */
+int ksz8_change_tag_protocol(struct ksz_device *dev,
+			     enum dsa_tag_protocol proto)
+{
+	const u32 *masks = dev->info->masks;
+	const u16 *regs = dev->info->regs;
+
+	if ( (proto == DSA_TAG_PROTO_KSZ8795 && ksz_is_ksz87xx(dev)) ||
+	     (proto == DSA_TAG_PROTO_KSZ9893 && ksz_is_ksz88x3(dev)) )
+		ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
+	else if (proto == DSA_TAG_PROTO_NONE)
+		ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], false);
+	else
+		return -EPROTONOSUPPORT;
+
+	return 0;
+}
+
 static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 {
 	u8 mask_4q, mask_2q;
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1491099528be..a87f43908a9a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -307,6 +307,7 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
 	.init = ksz8_switch_init,
 	.exit = ksz8_switch_exit,
 	.change_mtu = ksz8_change_mtu,
+	.change_tag_protocol = ksz8_change_tag_protocol,
 };
 
 static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
@@ -2893,9 +2894,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	struct ksz_device *dev = ds->priv;
 	enum dsa_tag_protocol proto = DSA_TAG_PROTO_NONE;
 
-	if (dev->chip_id == KSZ8795_CHIP_ID ||
-	    dev->chip_id == KSZ8794_CHIP_ID ||
-	    dev->chip_id == KSZ8765_CHIP_ID)
+	if (ksz_is_ksz87xx(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
 	if (dev->chip_id == KSZ8830_CHIP_ID ||
@@ -2917,12 +2916,25 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	return proto;
 }
 
+static int ksz_change_tag_protocol(struct dsa_switch *ds,
+				   enum dsa_tag_protocol proto)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dev->dev_ops->change_tag_protocol)
+		return dev->dev_ops->change_tag_protocol(dev, proto);
+	else
+		return -EPROTONOSUPPORT;
+}
+
 static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 				    enum dsa_tag_protocol proto)
 {
 	struct ksz_tagger_data *tagger_data;
 
 	switch (proto) {
+	case DSA_TAG_PROTO_NONE:
+		return 0;
 	case DSA_TAG_PROTO_KSZ8795:
 		return 0;
 	case DSA_TAG_PROTO_KSZ9893:
@@ -3974,6 +3986,7 @@ static int ksz_hsr_leave(struct dsa_switch *ds, int port,
 
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
+	.change_tag_protocol    = ksz_change_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..badae22f4613 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -354,6 +354,8 @@ struct ksz_dev_ops {
 	void (*get_caps)(struct ksz_device *dev, int port,
 			 struct phylink_config *config);
 	int (*change_mtu)(struct ksz_device *dev, int port, int mtu);
+	int (*change_tag_protocol)(struct ksz_device *dev,
+				   enum dsa_tag_protocol proto);
 	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
 	void (*phylink_mac_link_up)(struct ksz_device *dev, int port,

base-commit: dd1bf9f9df156b43e5122f90d97ac3f59a1a5621
-- 
2.43.0


