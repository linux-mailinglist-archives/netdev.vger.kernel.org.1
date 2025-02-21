Return-Path: <netdev+bounces-168479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7DA3F20C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5743BC55A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BC4205506;
	Fri, 21 Feb 2025 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYxoHRM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C072A204F96;
	Fri, 21 Feb 2025 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133706; cv=none; b=OfThjbw5K8YSY/Ag4Uuq0ov3JgDNe0pde275ZVDrl0YMf3a8dtBqwL4coRp1vRnf+xLXY9IjBNisLueterv+j3JupeVTHNXzKMBmOAeXo9ttKDaA8G/P4mDkh5AJz1T4+jKAzJErNuCSkw46xYDY0WNqajwXBDftMkzTnp+ZzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133706; c=relaxed/simple;
	bh=dgz2bscn7Q435uj93TaWTTlxPqFHS/re+kAwHmwmttM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qtCd6gvzwh0FYsOSQ9LgOvnEFebJp5xmlyRPO7vHWVE95FoDlxPOmzsX2oHchGGqZ1C/YA5Aj0MvOQfMKChvbg2kbszDTMwUEV/W4QVV3FtF8FgKJEp/WJEYOmlk0lCbY/qS7rXoGO1YMBJDbfhPoMUHCFcBgsfaAyKEleRK8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYxoHRM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C897DC4CEE6;
	Fri, 21 Feb 2025 10:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133706;
	bh=dgz2bscn7Q435uj93TaWTTlxPqFHS/re+kAwHmwmttM=;
	h=From:Subject:Date:To:Cc:From;
	b=pYxoHRM4oZ9SMGDMBFz8ha62sZfU116zEwUEDf5+MlnHGWBzkgdyCWFw5TY9Ul52c
	 OQPPjRhk/uwb2elRzhtT6y3U+y5x4m2RRX2RFb02WsPy41ML2dSh2IgoUmNgET5vGt
	 W5fFGSdm/HpmJ+WfCa1ICZGErGy3uqh3TDRgCKNmzLuEKwPgVoEhcvUPZta+Z9iq1K
	 Yyt3ZZ7IrGnEkD1XqlTb9Iy06tPQJ3caDobZPdRoUbjkUb1ZzD3EpJsH0SkpSMMqY8
	 6C9vjoCEBEkRNb0EEmUKEEtEnulvlkt+5rd8NwyjCsX+H45WPidhVGXDINCok1oOUe
	 TolQxLTikmbjg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v6 00/15] Introduce flowtable hw offloading in
 airoha_eth driver
Date: Fri, 21 Feb 2025 11:28:01 +0100
Message-Id: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFVuGcC/43PwW7DIAwG4FepOI8J7ABlp73HtIMJToMWhYpU2
 aYq7z7SU6Yc0pt/H77fvouJS+JJvJ3uovCcppTHGuzLSbQ9jReWKdYsQIFRoIykVHJPkkdnzlp
 2Q/6+URhY5q7OFCUjaR0wYENRVOVauEs/j4aPz5r7NN1y+X0UznrdPm/PWioZ0ULbkXdB6fcvL
 iMPr7lcxIrPsAXdMQgVRAJAbz2QdTsQt6A/BnG9MJBV7IwxFndgswE1HoNNBYP1LWkbXRPDDjR
 b8ImXTQXhHNgr3QaH5h+4LMsfz3RBFxMCAAA=
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
 upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Changes in v6:
- Fix Smatch errors.
- Remove unnecessary GFP_DMA allocating NPU buffers
- Remove wrong dma coherent mask
- Rely on skb_cow_head() instead of skb_ensure_writable() in
  airoha_get_dsa_tag()
- Unregister net_device before deallocating metadata_dst
- Link to v5: https://lore.kernel.org/r/20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org

Changes in v5:
- Fix uninitialized variable in airoha_ppe_setup_tc_block_cb()
- Rebase on top of net-next
- Link to v4: https://lore.kernel.org/r/20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org

Changes in v4:
- Add dedicated driver for the Airoha NPU module
- Move airoha npu binding in net
- Link to v3: https://lore.kernel.org/r/20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org

Changes in v3:
- Fix TSO support for header cloned skbs
- Do not use skb_pull_rcsum() in airoha_get_dsa_tag()
- Fix head lean computation after running airoha_get_dsa_tag() in
  airoha_dev_xmit()
- Link to v2: https://lore.kernel.org/r/20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org

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
      dt-bindings: net: airoha: Add the NPU node for EN7581 SoC
      dt-bindings: net: airoha: Add airoha,npu phandle property
      net: airoha: Introduce Airoha NPU support
      net: airoha: Introduce flowtable offload support
      net: airoha: Add loopback support for GDM2
      net: airoha: Introduce PPE debugfs support

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |   10 +
 .../devicetree/bindings/net/airoha,en7581-npu.yaml |   72 ++
 drivers/net/dsa/mt7530.c                           |    5 +
 drivers/net/dsa/mt7530.h                           |    4 +
 drivers/net/ethernet/Kconfig                       |    2 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/airoha/Kconfig                |   27 +
 drivers/net/ethernet/airoha/Makefile               |    9 +
 .../net/ethernet/{mediatek => airoha}/airoha_eth.c | 1275 +++++---------------
 drivers/net/ethernet/airoha/airoha_eth.h           |  553 +++++++++
 drivers/net/ethernet/airoha/airoha_npu.c           |  519 ++++++++
 drivers/net/ethernet/airoha/airoha_npu.h           |   29 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |  898 ++++++++++++++
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |  181 +++
 drivers/net/ethernet/airoha/airoha_regs.h          |  798 ++++++++++++
 drivers/net/ethernet/mediatek/Kconfig              |    8 -
 drivers/net/ethernet/mediatek/Makefile             |    1 -
 17 files changed, 3392 insertions(+), 1000 deletions(-)
---
base-commit: bb3bb6c92e5719c0f5d7adb9d34db7e76705ac33
change-id: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


