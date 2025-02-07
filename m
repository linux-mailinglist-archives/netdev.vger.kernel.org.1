Return-Path: <netdev+bounces-164074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA04A2C8B8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270DC188C129
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849EA18C910;
	Fri,  7 Feb 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCIZMgYT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC018BC20;
	Fri,  7 Feb 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945606; cv=none; b=Dc/sJxNjP7WDckntE8TUmW7Zs8KnjXR8d1qZXIoHNLJ/F5Fmn1diwlj/8u1ReKZRQjB4RXPqsxYMbsoupKou4LeFZUE/FoGc5U62+EYoZ2Z8rfgU/N+gMJyzj7lGnUaCIUoVVLJiZiHiNmNBU/765OrvbYEHJE0s3RR37MNtggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945606; c=relaxed/simple;
	bh=u+i95IR3MVOK1O+Tnb4juPc0WoJPr81JyopjZ2dKp/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N/pALjsynZ2NhfjWXp5Wh/ByZ+qTa7YFwnKo0WO9QU2suwFGboBKzRxBe+ryuWddnszvY0u5FB4inL4xi9Pin+zMhGrUXYh0L75X4Tc4+JJsUvXlmwyBYC+pJDMaZSqR3jOwMcbYNByNB9xZLT9ntC3WePJJjYrHpq7Zv1za0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCIZMgYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE8AC4CED1;
	Fri,  7 Feb 2025 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945605;
	bh=u+i95IR3MVOK1O+Tnb4juPc0WoJPr81JyopjZ2dKp/Q=;
	h=From:Subject:Date:To:Cc:From;
	b=GCIZMgYTQkqmivbMNyPjb1wStpCQeA8rKEqwbug0hMrRDg2I9XcmWSxjbQov4GffM
	 iG7RWsQDUZ+EFjoDaorFRmItUvlB0o6orqGjkiUEhbpg9js5j6hA2eZ8HhH7L3Arvy
	 FgHa9pD/kWPIc5m6tFbR+XXdda6RbHr3aJE657YbTv7F22OuujNmWOW9+SQmEGeWaY
	 I+BbFXFsioKC5DTmmyRFhxqh6cPSZhOCyanwcQHdA5/aESpfYWtuoq3vmkxFQ6dWT8
	 LnoOdk/LwG9lUtBaN/y5Up9fVOKh5ga2be98K25euO+4smAmFaL+b4bdR64voLHdjT
	 VKcKI4YWr7bcQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 00/15] Introduce flowtable hw offloading in
 airoha_eth driver
Date: Fri, 07 Feb 2025 17:26:15 +0100
Message-Id: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACc0pmcC/42NTQ6CMBBGr0K6dkx/RNSV9zAspnQKjaQlU4Iaw
 t2tnMDd977Fe6vIxIGyuFWrYFpCDikW0IdKdAPGniC4wkJLXUsta8DAaUCg2NQXBX5MrxntSJB
 82eiADCpljTUndKJYJiYf3nvh0RYeQp4Tf/bgon7v/+5FgQRnzrrzeG2sVPcncaTxmLgX7bZtX
 zMzGZPPAAAA
X-Change-ID: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.14.2

Introduce netfilter flowtable integration in airoha_eth driver to
offload 5-tuple flower rules learned by the PPE module if the user
accelerates them using a nft configuration similar to the one reported
below:

table inet filter {
	flowtable ft {
		hook ingress priority filter
		devices = { lan1, lan2, lan3, lan4, eth1 }
		flags offload;
	}
	chain forward {
		type filter hook forward priority filter; policy accept;
		meta l4proto { tcp, udp } flow add @ft
	}
}

Packet Processor Engine (PPE) module available on EN7581 SoC populates
the PPE table with 5-tuples flower rules learned from traffic forwarded
between the GDM ports connected to the Packet Switch Engine (PSE) module.
airoha_eth driver configures and collects data from the PPE module via a
Network Processor Unit (NPU) RISC-V module available on the EN7581 SoC.
Move airoha_eth driver in a dedicated folder
(drivers/net/ethernet/airoha).

---
Changes in v2:
- Add airoha-npu document binding
- Enable Rx SPTAG on MT7530 dsa switch for EN7581 SoC.
- Fix warnings in airoha_npu_run_firmware()
- Fix sparse warnings
- Link to v1: https://lore.kernel.org/r/20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org

---
Lorenzo Bianconi (15):
      net: airoha: Move airoha_eth driver in a dedicated folder
      net: airoha: Move definitions in airoha_eth.h
      net: airoha: Move reg/write utility routines in airoha_eth.h
      net: airoha: Move register definitions in airoha_regs.h
      net: airoha: Move DSA tag in DMA descriptor
      net: dsa: mt7530: Enable Rx sptag for EN7581 SoC
      net: airoha: Enable support for multiple net_devices
      net: airoha: Move REG_GDM_FWD_CFG() initialization in airoha_dev_init()
      net: airoha: Rename airoha_set_gdm_port_fwd_cfg() in airoha_set_vip_for_gdm_port()
      dt-bindings: arm: airoha: Add the NPU node for EN7581 SoC
      dt-bindings: net: airoha: Add airoha,npu phandle property
      net: airoha: Introduce PPE initialization via NPU
      net: airoha: Introduce flowtable offload support
      net: airoha: Add loopback support for GDM2
      net: airoha: Introduce PPE debugfs support

 .../devicetree/bindings/arm/airoha,en7581-npu.yaml |   71 ++
 .../devicetree/bindings/net/airoha,en7581-eth.yaml |   10 +
 drivers/net/dsa/mt7530.c                           |    5 +
 drivers/net/dsa/mt7530.h                           |    4 +
 drivers/net/ethernet/Kconfig                       |    2 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/airoha/Kconfig                |   23 +
 drivers/net/ethernet/airoha/Makefile               |    9 +
 .../net/ethernet/{mediatek => airoha}/airoha_eth.c | 1261 +++++---------------
 drivers/net/ethernet/airoha/airoha_eth.h           |  626 ++++++++++
 drivers/net/ethernet/airoha/airoha_npu.c           |  501 ++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c           |  823 +++++++++++++
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |  175 +++
 drivers/net/ethernet/airoha/airoha_regs.h          |  793 ++++++++++++
 drivers/net/ethernet/mediatek/Kconfig              |    8 -
 drivers/net/ethernet/mediatek/Makefile             |    1 -
 16 files changed, 3310 insertions(+), 1003 deletions(-)
---
base-commit: 26db4dbb747813b5946aff31485873f071a10332
change-id: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


