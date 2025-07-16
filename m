Return-Path: <netdev+bounces-207303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90FB06A37
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20A31A600D8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC31A23B5;
	Wed, 16 Jul 2025 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="naZ8PxKC"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997610F1
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624097; cv=none; b=WDUDf01WIa2wIAsWeFnl2S5PBWTbmkWT93UP3Img5S7iAVIj0G+BCuGJb62TYFxb2p4gA/q/wzyKCL7kZeQONZyGtRxD56/+6w8yMwBJeprTdX+XjZw223vYX8GZiDQDXL9tHX01X4Ybo14b0T+o/vRggYWpJCuR2Xc4a4woM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624097; c=relaxed/simple;
	bh=ptCTmsUmw+ZgmwvdsK7zWBp6fQ3EHDqqTzKOdIFWImA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1iIowP43RYiFAI5QShh65e7xGitsq/3SwGOEKPX/mkIyuJdnaHsDCKY4lSODAf3dAU+krn20Z46BOqKZHDd++3pQw5H32KTaPpkTDwT5MfRLtTAivJ8pfY3D9XiwEAeakfdokehkpXVU1GY7GzIJwUs2O9lkWToZshpsjgfvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=naZ8PxKC; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752624093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRuFXoOx7ugRu+xZOn9KsE5pqVIii62tEGweLLSB5Os=;
	b=naZ8PxKCh+sRYCLRMgsA1O5bc1h3AEmUMvXomw4BnYQE0xmjLIGBYLSwyRDLZgXMjx0YgP
	7p7FimTn7tm3+6oqPO8LoXgGIsHl847LvEoUrnIeH8/mbL+mXh8MhS+6XXJCJ/XuTizSIY
	vZtQMxotcOGussgvOl+f6bSErOdx2xc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
Date: Tue, 15 Jul 2025 20:01:07 -0400
Message-Id: <20250716000110.2267189-2-sean.anderson@linux.dev>
In-Reply-To: <20250716000110.2267189-1-sean.anderson@linux.dev>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Support creating auxiliary devices with the id included as part of the
name. This allows for hexadecimal ids, which may be more appropriate for
auxiliary devices created as children of memory-mapped devices. If an
auxiliary device's id is set to AUXILIARY_DEVID_NONE, the name must
be of the form "name.id".

With this patch, dmesg logs from an auxiliary device might look something
like

[    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
[   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
[   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
[   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
[   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx

this is especially useful when compared to what might happen if there is
an error before userspace has the chance to assign a name to the netdev:

[    4.947215] xilinx_emac.mac xilinx_emac.mac.1 (unnamed net_device) (uninitialized): incorrect link mode  for in-band status

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Add example log output to commit message

 drivers/base/auxiliary.c      | 6 +++++-
 include/linux/auxiliary_bus.h | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index dba7c8e13a53..64a0d5e2eb83 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -331,7 +331,11 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
 		return -EINVAL;
 	}
 
-	ret = dev_set_name(dev, "%s.%s.%d", modname, auxdev->name, auxdev->id);
+	if (auxdev->id == AUXILIARY_DEVID_NONE)
+		ret = dev_set_name(dev, "%s.%s", modname, auxdev->name);
+	else
+		ret = dev_set_name(dev, "%s.%s.%d", modname, auxdev->name,
+				   auxdev->id);
 	if (ret) {
 		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
 		return ret;
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 4086afd0cc6b..76904cf2c3dd 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -51,6 +51,8 @@
  * unregisters the auxiliary device.
  */
 
+#define AUXILIARY_DEVID_NONE	(-1)
+
 /**
  * struct auxiliary_device - auxiliary device object.
  * @dev: Device,
@@ -269,7 +271,7 @@ struct auxiliary_device *__devm_auxiliary_device_create(struct device *dev,
 
 #define devm_auxiliary_device_create(dev, devname, platform_data)     \
 	__devm_auxiliary_device_create(dev, KBUILD_MODNAME, devname,  \
-				       platform_data, 0)
+				       platform_data, AUXILIARY_DEVID_NONE)
 
 /**
  * module_auxiliary_driver() - Helper macro for registering an auxiliary driver
-- 
2.35.1.1320.gc452695387.dirty


