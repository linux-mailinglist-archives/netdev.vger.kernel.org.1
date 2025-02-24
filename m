Return-Path: <netdev+bounces-168974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6DA41D95
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6618316F047
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0CF25C6E3;
	Mon, 24 Feb 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3BxkkaQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A42594BD;
	Mon, 24 Feb 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396348; cv=none; b=B1YJqpIqEnKFRGsuDimhJP9gTtlFkLdBKXUs0w9N/ufVcZ6Dw7TT5AtDXPGb4UG9UYnlD9j4K29XV3j832o4Z557M1SRy+1sueXNRmJgY3SDBPDrWNc1S0XyujHkqQAWsHngFPM8DRcO4gyB1PpaH2wUSmM+afVr78f+sQA89ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396348; c=relaxed/simple;
	bh=YYs+Pvfo5ZWeVpJMW2X20pcW6EMEfOUnT1POB/FytJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OqKxXyo1cw443UblTbFXSxHGvejOD6eZsWTv5asW0G3z+0LA2vB3+geu+Ld/dwqi+tK50SaFuexikaj6ABWqBqxp/SZK/n9ot5hTcxx71VdoSEmKhCSmVmI6+TJ+kkBwFOCVYDqBZdlAfJMwkuvimcC2AB/0++U0eueOGLoVgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3BxkkaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401C9C4CED6;
	Mon, 24 Feb 2025 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396347;
	bh=YYs+Pvfo5ZWeVpJMW2X20pcW6EMEfOUnT1POB/FytJ4=;
	h=From:Subject:Date:To:Cc:From;
	b=Y3BxkkaQwGS8XAelxxVHJf9WDmzTa7eFUlgFTaTaUIMsZxgkJk3aTjq1L4Nn3FPpk
	 0XxhkjeET/+ie97dcEqdKrJPMlnCdJeVtoRRn4c+SfDrXTe/F6U9intm2Od/VOSyEr
	 N+FTx8JnhC90rbLViSqK8z4izMSy8CY3lM+8bDNrjyu0NWBqFxjQ7LqIsF9E5xJ5bQ
	 Z1Mf3NXVV/a1vbIlkm+FX+Mm/98r4onfXX/7XRFtKMhO4l3m6eOxaVmXpaLS2+ZMY5
	 a8IdzdIL9fDqqCTkDBGeM1ELFzqDnVm+oIttgvZF6Kd5+EVNufhuw/DtOTGXqyy//m
	 06gutHNmq4w0Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v7 00/15] Introduce flowtable hw offloading in
 airoha_eth driver
Date: Mon, 24 Feb 2025 12:25:20 +0100
Message-Id: <20250224-airoha-en7581-flowtable-offload-v7-0-b4a22ad8364e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBXvGcC/43QzW7DIAwH8FepOI8J7ABhp73HtIMJToNWhYpU2
 aYq7z7SU6Yc0pv/Pvz8cRcTl8STeDvdReE5TSmPNbiXk+gGGs8sU6xZgAKjQBlJqeSBJI/OtFr
 2l/x9o3BhmftaU5SMpHXAgA1FUZVr4T79PCZ8fNY8pOmWy+9j4KzX7vP2rKWSES10PXkXlH7/4
 jLy5TWXs1jxGbagOwahgkgA6K0Hsm4H4hb0xyCuGwayip0xxuIObDagxmOwqWCwviNto2ti2IF
 mCz5xsqkgtIG90l1waHag3YCgj0G7nmw8Uq/YN+3/Hy7L8ge0DZpsZAIAAA==
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
 upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
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
Changes in v7:
- Fix Coccicheck warnings
- Add missing request_module
- Introduce ops in airoha_npu struct
- Add missing wlan interrupt to airoha_npu binding
- Link to v6: https://lore.kernel.org/r/20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org

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
 .../devicetree/bindings/net/airoha,en7581-npu.yaml |   84 ++
 drivers/net/dsa/mt7530.c                           |    5 +
 drivers/net/dsa/mt7530.h                           |    4 +
 drivers/net/ethernet/Kconfig                       |    2 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/airoha/Kconfig                |   27 +
 drivers/net/ethernet/airoha/Makefile               |    9 +
 .../net/ethernet/{mediatek => airoha}/airoha_eth.c | 1275 +++++---------------
 drivers/net/ethernet/airoha/airoha_eth.h           |  553 +++++++++
 drivers/net/ethernet/airoha/airoha_npu.c           |  520 ++++++++
 drivers/net/ethernet/airoha/airoha_npu.h           |   34 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |  910 ++++++++++++++
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |  181 +++
 drivers/net/ethernet/airoha/airoha_regs.h          |  798 ++++++++++++
 drivers/net/ethernet/mediatek/Kconfig              |    8 -
 drivers/net/ethernet/mediatek/Makefile             |    1 -
 17 files changed, 3422 insertions(+), 1000 deletions(-)
---
base-commit: e13b6da7045f997e1a5a5efd61d40e63c4fc20e8
change-id: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


