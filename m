Return-Path: <netdev+bounces-119652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C39567E9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6981C219C3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2515FA66;
	Mon, 19 Aug 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTmVW/XW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97615F3EE;
	Mon, 19 Aug 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062417; cv=none; b=bdMi2HmbpRq8F/6f14u6IQMz9T7ql1U5KDHh3EaZciMOFYywEFkZkaVEwNx4N2fBQH8vwaCo5gpP/FpqolTEQfHpxOxSTTaPW6hw0PFnHDKlpljOYL+H697RTSKwYecEwnBqgjcRcAfMKytyYfepwTAO/eb19or1om0nffUxBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062417; c=relaxed/simple;
	bh=RkzYIGUU5bJySGGjGxuvyvAREgbhVMdcv6+RZR9/W/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDBp62/ZGrOABtPkS4Tg74pODMkI3FvxFHDyz8gZY5uFhwq8Ipu/1pj1QadKNvDT1zelyuoPJTmstlLp5VkigytaRfmMa/xvqOR0wNtsYXhx3pnaauGmAmzfbVzKevbJ4sycyo07FTRgptnUxmKFSTP5hc7KlbVj4zekUOtFvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTmVW/XW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so22530e87.0;
        Mon, 19 Aug 2024 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724062413; x=1724667213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37VBLD6AtZ7XziwZYJK3gfCo6k1sbxMLWhSaF5fGyIE=;
        b=iTmVW/XWEKRmZqfowY8cRPdEz4huUYGQ+B264NZk3hS37H0IwzDUTnXjkmxBFH2uA/
         2f4czOkVkkpntLNdDNECGDNo+cWlVvyqOPWeukeVkmzd8LyJKsKNGqzuHCKRWhvcq9N6
         hmtuIFjlgj4to5sYc18wao4AgwbknGa8qOqSfLX9hLjyHI4FRHlUKbV+wKvUAJRDZXvW
         xIB4snXiSL1bIdkVFdluowm9MwM3GeV93M6a9pa8clwuAo5asvPjhQzidH+1L+r6qrnL
         8ajmU0uOX31qPhAQ3zvjyKTzv5/Fzn6NBcA0O8VpriWiXZZJKreJpBBPhfPt6BtNmpBF
         klkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062413; x=1724667213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37VBLD6AtZ7XziwZYJK3gfCo6k1sbxMLWhSaF5fGyIE=;
        b=uuThlyFjacn2eSBe4lDEw8/KeVLAiRFAzEWbNDAMBx7jjY0KD9BuAnlVrvENlPxAQZ
         lS7xGSNPjrSrpsoUsFzE8klydR1l7VF7RkVvnTjpNXXYTM5YUeXm/dS5jiOhUh+mtzQp
         ++XMpQq71zSAJipd0R+VDsVG3axncHk7/vbOJz6bqJ6qneH8aWFRpQJdWMMGbwhDt4uo
         BGBWatX5Q1Hef9l7S0Vp1GOBKCZs5l3ogeNgcbe9mQB8ESFN+m/7EZ/jjUeOqkIdjhl4
         1efjEp8P48H0pZTqt1u8csTg8jHGPju3vzc4DJ9kC+1aYFGbp4yPSIvqER1chnMIDWB/
         JS7w==
X-Forwarded-Encrypted: i=1; AJvYcCVclZVWOHixj888En16hh4mtg8JjsfOKBdIJpPs6ljPymlXvqLT5l9zaKoJMDxp/MAYAb+vnraU@vger.kernel.org, AJvYcCXGbakaKd+u23qnoPjc4yqRQv/Lja8ZBX0mz1GwtcwD27lJCkSavk9pnrEMNb2cimtaM8bQBzRnFrvS8NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfvS9q1rMpVT7waFwTPu7I1MSjjALtz1WKzliE4w4og6D0sHZ
	4+POaKqUBmNRIJvZGf/kcy7oIXAndzAWheoCKh+elJrT9xGsCa7L
X-Google-Smtp-Source: AGHT+IFw9LOg0n/sgCPZQaEuvIgh+UKc+UMNfJOSnlW2WfMvbqWN0RlzEG3B0OZdM4lw/PSufF1Sbw==
X-Received: by 2002:a05:6512:1085:b0:530:dfab:9315 with SMTP id 2adb3069b0e04-5331c691e63mr8844302e87.10.1724062413228;
        Mon, 19 Aug 2024 03:13:33 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d5a7sm612749366b.217.2024.08.19.03.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:13:32 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8 change_tag_protocol support
Date: Mon, 19 Aug 2024 12:12:35 +0200
Message-ID: <20240819101238.1570176-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819101238.1570176-1-vtpieter@gmail.com>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
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

In addition, shorten certain dev->chip_id checks by using the existing
ksz_is_ksz87xx instead.

Link: https://www.kernel.org/doc/html/latest/networking/dsa/dsa.html [1]
Link: https://lpc.events/event/11/contributions/949/attachments/823/1555/paper.pdf [2]
Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz8.h       |  2 ++
 drivers/net/dsa/microchip/ksz8795.c    | 27 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.c | 24 +++++++++++++++++------
 drivers/net/dsa/microchip/ksz_common.h |  2 ++
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index e1c79ff97123..14c7912b854e 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -57,6 +57,8 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
 int ksz8_pme_write8(struct ksz_device *dev, u32 reg, u8 value);
 int ksz8_pme_pread8(struct ksz_device *dev, int port, int offset, u8 *data);
 int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 data);
+int ksz8_change_tag_protocol(struct ksz_device *dev,
+			     enum dsa_tag_protocol proto);
 void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      struct phy_device *phydev, unsigned int mode,
 			      phy_interface_t interface, int speed, int duplex,
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index a01079297a8c..41d163e88f03 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -194,6 +194,33 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ksz8_change_tag_protocol - Change tag protocol
+ * @dev: The device structure.
+ * @proto: The requested protocol.
+ *
+ * This function allows changing the tag protocol. In fact the ksz8
+ * devices can only enable or disable the tail tag.
+ *
+ * Return: 0 on success, -EPROTONOSUPPORT in case protocol not supported.
+ */
+int ksz8_change_tag_protocol(struct ksz_device *dev,
+			     enum dsa_tag_protocol proto)
+{
+	const u32 *masks = dev->info->masks;
+	const u16 *regs = dev->info->regs;
+
+	if ((proto == DSA_TAG_PROTO_KSZ8795 && ksz_is_ksz87xx(dev)) ||
+	    (proto == DSA_TAG_PROTO_KSZ9893 && ksz_is_ksz88x3(dev)))
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
index cd3991792b69..e5194660ed99 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -310,6 +310,7 @@ static const struct ksz_dev_ops ksz88x3_dev_ops = {
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
 	.pme_pwrite8 = ksz8_pme_pwrite8,
+	.change_tag_protocol = ksz8_change_tag_protocol,
 };
 
 static const struct ksz_dev_ops ksz87xx_dev_ops = {
@@ -345,6 +346,7 @@ static const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
 	.pme_pwrite8 = ksz8_pme_pwrite8,
+	.change_tag_protocol = ksz8_change_tag_protocol,
 };
 
 static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
@@ -2937,9 +2939,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	struct ksz_device *dev = ds->priv;
 	enum dsa_tag_protocol proto = DSA_TAG_PROTO_NONE;
 
-	if (dev->chip_id == KSZ8795_CHIP_ID ||
-	    dev->chip_id == KSZ8794_CHIP_ID ||
-	    dev->chip_id == KSZ8765_CHIP_ID)
+	if (ksz_is_ksz87xx(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
 	if (dev->chip_id == KSZ8830_CHIP_ID ||
@@ -2961,12 +2961,25 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
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
@@ -4208,6 +4221,7 @@ static int ksz_hsr_leave(struct dsa_switch *ds, int port,
 
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
+	.change_tag_protocol    = ksz_change_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
@@ -4443,9 +4457,7 @@ static int ksz9477_drive_strength_write(struct ksz_device *dev,
 		dev_warn(dev->dev, "%s is not supported by this chip variant\n",
 			 props[KSZ_DRIVER_STRENGTH_IO].name);
 
-	if (dev->chip_id == KSZ8795_CHIP_ID ||
-	    dev->chip_id == KSZ8794_CHIP_ID ||
-	    dev->chip_id == KSZ8765_CHIP_ID)
+	if (ksz_is_ksz87xx(dev))
 		reg = KSZ8795_REG_SW_CTRL_20;
 	else
 		reg = KSZ9477_REG_SW_IO_STRENGTH;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 8094d90d6ca4..e1178063e6e4 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -363,6 +363,8 @@ struct ksz_dev_ops {
 			  u8 *data);
 	int (*pme_pwrite8)(struct ksz_device *dev, int port, int offset,
 			   u8 data);
+	int (*change_tag_protocol)(struct ksz_device *dev,
+				   enum dsa_tag_protocol proto);
 	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
 	void (*phylink_mac_link_up)(struct ksz_device *dev, int port,
-- 
2.43.0


