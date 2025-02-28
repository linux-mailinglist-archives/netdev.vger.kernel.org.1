Return-Path: <netdev+bounces-170654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E39A497D3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818F43BB822
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564B25F981;
	Fri, 28 Feb 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfeP8FLY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7491B4250;
	Fri, 28 Feb 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740069; cv=none; b=F/e+x5kyJHiGSfG2Dl00Pzm8iWEsa6iH8XvMaLyfAw6rTfYXn3Qz1MoTZdgcZMfOOnnxnWj9FUDCXPrXuyWJT10MC4PJL8uqrq0VCoXK/wqKWLC9AcPak8PSOtcCeu2t/LJzabPdvNXie0QGMDO9+fDxZxCz/talV1huGrVHn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740069; c=relaxed/simple;
	bh=D378USUaujIOtk3JUxmuhX8B+XhE/CL+/pfeMthqgwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UsYQCSSxk0l1UQcW3k7K64jVjk59p/r/4EIToDYck6n42yvgA4665iu7RGqBgzDxpf7wYVP7Wcl7I8iwBNdPMmil2eMt73bB3qNTWq9btXoN//hyfZ0ivwevLEWvryXDoCNY3OXy3whZrSgMJlGX+zeGejwi0C6mX1Pv4ZiVzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfeP8FLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7E9C4CED6;
	Fri, 28 Feb 2025 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740740068;
	bh=D378USUaujIOtk3JUxmuhX8B+XhE/CL+/pfeMthqgwk=;
	h=From:Subject:Date:To:Cc:From;
	b=hfeP8FLYk+uGh95AyYg6p7IDmqj2gw0NYL/h0yN6vOtfFGIVhx3r6vVR/ea07VsIs
	 i+vaF8ucj2/o/B9w7yCKjnfSd8YliktJyZwen/dMlI+M72KkKRkaBRt0BRbfAoAegi
	 9pqtKMOpFOt9NXon/4HC48K42i5QwfmArXtX5vujHF8UFrslfjSYzyuBGsBsJPeQC1
	 XctCWdacskBlHxuMChCsQTWzYDQK3nEf4hGck3kfmyX5F9ty6CWE9Q0qMF5FrwYbgW
	 jtUSEsOqvCktHTNBhWITvVkFywgCau6qSGw9tw28aICDUpiRTye8s0q/hahqJsdwqK
	 RwgsFMSdPI4xw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v8 00/15] Introduce flowtable hw offloading in
 airoha_eth driver
Date: Fri, 28 Feb 2025 11:54:08 +0100
Message-Id: <20250228-airoha-en7581-flowtable-offload-v8-0-01dc1653f46e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCVwWcC/43RTW7DIBAF4KtErEsFDD+mq96j6mIw4xg1MhGO3
 FaR716cFZUXzo7H4hvecGczlUQzezvdWaElzSlPNXQvJ9aPOJ2Jp1gzU0IZoYThmEoekdPkTCf
 5cMnfNwwX4nmoZ4ycAKUMEEBjZFW5FhrSz2PCx2fNY5pvufw+Bi5yu33eXiQXPIJV/YDeBSHfv
 6hMdHnN5cw2fFEt6I5BVUFApcBbr9C6HQgt6I9B2F4Y0ApyxhgLO1A3oIRjUFcwWN+jtNHpGHa
 gacEnKpsKqi6QF7IPDswOtA2o5DFot8rGAw6CvO72O3QtqI9Bt1XW9VcwdmA1/QPXdf0D9Faju
 LUCAAA=
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
Changes in v8:
- Remove unnecessary GFP_ZERO flag in dmam_alloc_coherent()
- Fix 802.1q offloading support
- Link to v7: https://lore.kernel.org/r/20250224-airoha-en7581-flowtable-offload-v7-0-b4a22ad8364e@kernel.org

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
 .../net/ethernet/{mediatek => airoha}/airoha_eth.c | 1277 +++++---------------
 drivers/net/ethernet/airoha/airoha_eth.h           |  551 +++++++++
 drivers/net/ethernet/airoha/airoha_npu.c           |  520 ++++++++
 drivers/net/ethernet/airoha/airoha_npu.h           |   34 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |  910 ++++++++++++++
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |  181 +++
 drivers/net/ethernet/airoha/airoha_regs.h          |  798 ++++++++++++
 drivers/net/ethernet/mediatek/Kconfig              |    8 -
 drivers/net/ethernet/mediatek/Makefile             |    1 -
 17 files changed, 3422 insertions(+), 1000 deletions(-)
---
base-commit: 56794b5862c5a9aefcf2b703257c6fb93f76573e
change-id: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


