Return-Path: <netdev+bounces-163186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FD8A298B8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D033A9968
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B601FCFCB;
	Wed,  5 Feb 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKr7Bwoh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409901FCCE1;
	Wed,  5 Feb 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779723; cv=none; b=NL5mkNLWxMevKi+nsDnGiEOTIlWwHBhaybkBh/qrJw+NXOQFDyRe3RYwfzAdxOi/Hqx+Eit7xXq6eAr/48NOMyd36lrpFkga7Ofnm4p64s7cnrH4fXBojWag+UmhqsC2VjglZoumfhebFr2RBHBaLJ7W76ExVzIISryh6ch7n7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779723; c=relaxed/simple;
	bh=SqMKmdlV8li1b5GqGJ7nzzQ4TW5jigeCPr1xbGk1wJA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r8+NroDpjR7RVfDwtypiddHt+VaVzhufMLhJvBHQOrcZ3w31EZRlnZI0QHuXoswuLHte2xfc8zb7Z1BZ78JeqpIjhTt1PYRsjBliK0pUN4//VfUeGQ8oHf3Etv1vHT15QFLHEztJGws8bUjmc/x6Y+kTks1PA+5MefLhh9HVafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKr7Bwoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366EDC4CED1;
	Wed,  5 Feb 2025 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779722;
	bh=SqMKmdlV8li1b5GqGJ7nzzQ4TW5jigeCPr1xbGk1wJA=;
	h=From:Subject:Date:To:Cc:From;
	b=AKr7Bwohk7fQ2NjKiLGD4FDOIFn52qFzErjfd4iCCrBiIX2QR5DBLQwuOnPVi8hdd
	 uUq1kTBY0k+Nm6KxBoUVngwzzzcc6vS625mPd8ZUHYZje51sVBLTYC2QFtPLKqWpt4
	 kqxCh2RhTAgzySGmSBwUQSM61FXnik9dt7m6o1Ka3hvOuklQ9oQyTjgNrdYGUjsCKD
	 lSGFiXgqPog17icF6a5f4PEz7TRYHWMwkMxKEWc1QJSHo4Q4YXgnucojc49H3iqqBt
	 woK4BO3ejsCMkLrivCiesSqYUddLy9b5z794MqM/cHDlwS3q/MVYZxButCV/9/4w4d
	 fltVqqII4Xkdw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 00/13] Introduce flowtable hw offloading in
 airoha_eth driver
Date: Wed, 05 Feb 2025 19:21:19 +0100
Message-Id: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+so2cC/x2NywqDMBAAf0X27EIehpb+SvGwaTZ1QRJJihaC/
 27wNnOZaVC5CFd4DQ0K71Ilpy56HOCzUPoySugORhmnjHJIUvJCyOnhnhrjmo8f+ZUxx84UkC1
 p7a23EwXola1wlP99eM/neQHYrpJ4cQAAAA==
X-Change-ID: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
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
Lorenzo Bianconi (13):
      net: airoha: Move airoha_eth driver in a dedicated folder
      net: airoha: Move definitions in airoha_eth.h
      net: airoha: Move reg/write utility routines in airoha_eth.h
      net: airoha: Move register definitions in airoha_regs.h
      net: airoha: Move DSA tag in DMA descriptor
      net: airoha: Enable support for multiple net_devices
      net: airoha: Move REG_GDM_FWD_CFG() initialization in airoha_dev_init()
      net: airoha: Rename airoha_set_gdm_port_fwd_cfg() in airoha_set_vip_for_gdm_port()
      dt-bindings: net: airoha: Add airoha,npu phandle property
      net: airoha: Introduce PPE initialization via NPU
      net: airoha: Introduce flowtable offload support
      net: airoha: Add loopback support for GDM2
      net: airoha: Introduce PPE debugfs support

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |    8 +
 drivers/net/ethernet/Kconfig                       |    2 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/airoha/Kconfig                |   23 +
 drivers/net/ethernet/airoha/Makefile               |    9 +
 .../net/ethernet/{mediatek => airoha}/airoha_eth.c | 1263 +++++---------------
 drivers/net/ethernet/airoha/airoha_eth.h           |  625 ++++++++++
 drivers/net/ethernet/airoha/airoha_npu.c           |  500 ++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c           |  812 +++++++++++++
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |  175 +++
 drivers/net/ethernet/airoha/airoha_regs.h          |  793 ++++++++++++
 drivers/net/ethernet/mediatek/Kconfig              |    8 -
 drivers/net/ethernet/mediatek/Makefile             |    1 -
 13 files changed, 3217 insertions(+), 1003 deletions(-)
---
base-commit: 135c3c86a7cef4ba3d368da15b16c275b74582d3
change-id: 20250205-airoha-en7581-flowtable-offload-e3a11b3b34ad

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


