Return-Path: <netdev+bounces-164447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F1A2DD4E
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 13:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC4164A24
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC31D90C5;
	Sun,  9 Feb 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQxFXttu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9191D7E41;
	Sun,  9 Feb 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739102961; cv=none; b=ER14h7dyT/Z4NIAM6rXvV2yQ+NKdNx5rgc7Unlwab9LQq6d3wPoUvN73VE9Wkn5aLVBg8KwQqzGGzCJ5sK7dqTB/6eGePup7Q/0yZOH1Xh72ZZPkIEDTn/cZo1EiCyNewpqpjyqtYMtcB2s7pX3uF8R25wDuzg5SonocTzlFTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739102961; c=relaxed/simple;
	bh=rvVWaQ3933ovo+AhnO53IS9md6uwvnhCRfjkB+Vwn6g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZiB7SRdg6n2opEwnNvHhVAkCmXxtdCGK3cqm/SZrmYt6eYlop0xjZMT0TpA6prcp8wrKftTzLM+W4hlUjl2p7uOFU93TZmIpABqnr+2iGSE4ITvrJXKksFNePK4+2QYLrKm0sVg20DgWLgpZbFzAL+g0cy2a+HFjzGzKrA6tRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQxFXttu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117DCC4CEDD;
	Sun,  9 Feb 2025 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739102960;
	bh=rvVWaQ3933ovo+AhnO53IS9md6uwvnhCRfjkB+Vwn6g=;
	h=From:Subject:Date:To:Cc:From;
	b=hQxFXttuoEO9bByp2FlBsoHxIXwBNJCwKw19TYGpdI1loXvds55aXpajC43iOm0a/
	 THqibkZt9NjVmhW9tW+v3s7xxSx1vNNFvHdUigQdX8w7wxNEUrQykyTCKN0wTmxfNi
	 ZNoP/QzHeOvp0lBB8zlmN2iWzS1huUF+gp5yLeG4J88ZoCrvoHUz+UvGF6+sqDAkNk
	 X8IT79SAgM35cJp0BKiRuS7KAO8HasInnzp4YrNRfPKi+KxG82qv2aKCs/hcVwXzcX
	 dJDA/8eMiaIj2pGj0zE1CpwN5Efj2q45wVLEC1DEJeXfZM4EZxbtNeHfZYnb5gcAsM
	 XHKBCmiDP8LhQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 00/16] Introduce flowtable hw offloading in
 airoha_eth driver
Date: Sun, 09 Feb 2025 13:08:53 +0100
Message-Id: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANWaqGcC/43NsQ6CMBDG8Vchna1pr0LFyfcwDld6hUZCTUtQQ
 3h3C5NOut3/ht83s0TRU2KnYmaRJp98GHKoXcGaDoeWuLe5GQgoBYiSo4+hQ06DLo+Suz48RjQ
 98eDyjZaTQimNMuqAlmXlHsn557ZwuebufBpDfG2Dk1y//9uT5IJbVUHjsNZGyPON4kD9PsSWr
 fgEn6D+DUIGFQKouqoBK/0FLsvyBvuMm+UgAQAA
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
Lorenzo Bianconi (16):
      net: airoha: Fix TSO support for header cloned skbs
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
 .../net/ethernet/{mediatek => airoha}/airoha_eth.c | 1284 +++++---------------
 drivers/net/ethernet/airoha/airoha_eth.h           |  626 ++++++++++
 drivers/net/ethernet/airoha/airoha_npu.c           |  501 ++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c           |  834 +++++++++++++
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |  175 +++
 drivers/net/ethernet/airoha/airoha_regs.h          |  798 ++++++++++++
 drivers/net/ethernet/mediatek/Kconfig              |    8 -
 drivers/net/ethernet/mediatek/Makefile             |    1 -
 16 files changed, 3344 insertions(+), 1008 deletions(-)
---
base-commit: acdefab0dcbc3833b5a734ab80d792bb778517a0
change-id: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


