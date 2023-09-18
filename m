Return-Path: <netdev+bounces-34507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C567A46F0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08621C20FB9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4F1C6A3;
	Mon, 18 Sep 2023 10:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924B10F9;
	Mon, 18 Sep 2023 10:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F6CC433C8;
	Mon, 18 Sep 2023 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695032993;
	bh=g60gI4xhtjsT6YwgP3vmxbN65nqJ+g/9M7lfzuwDok8=;
	h=From:To:Cc:Subject:Date:From;
	b=QUC/PoqcQsEo9picGWT0JFvdo4BdCeaqcm8PI4spneVGRRSXZ3KSp0JiOqd5F0auQ
	 OP/e6YWg7nvOvHjcmKDROY4Lj+LcfJ1E85N+8mAQw1LCIqrW7yXQGJbU8pe49xrCxR
	 GAXbgd5haCQTTLr9o+8IEdfsHnL64DGfdLZ0Rudkjar6DZqJ8Wr9heXlp/I6k7Y3LL
	 WtBC8rmpcd9VN+fLnehdfBHRK03+Je2pKyTzRj6rzUcoFf8GDwDj0vKFsM6tKfu1Pv
	 tGwzTSXYrQjGUigmfn/Xp0nlWIyP54EISavWVH1ywuy12edR5p9FIYi+PfWacx4jWJ
	 uK2TCCH38zeBw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	horms@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 00/17] Add WED support for MT7988 chipset
Date: Mon, 18 Sep 2023 12:29:02 +0200
Message-ID: <cover.1695032290.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to MT7622 and MT7986, introduce Wireless Ethernet Dispatcher (WED)
support for MT7988 chipset in order to offload to the hw packet engine traffic
received from LAN/WAN device to WLAN nic (MT7996E).
Add WED RX support in order to offload traffic received by WLAN nic to the
wired interfaces (LAN/WAN).

Changes since v1:
- introduce mtk_wed_soc_data data structure to contain per-SoC definitions
- get rid of buf pointer in mtk_wed_hwrro_buffer_alloc()
- rebase on top of net-next

Lorenzo Bianconi (12):
  dt-bindings: soc: mediatek: mt7986-wo-ccif: add binding for MT7988 SoC
  dt-bindings: arm: mediatek: mt7622-wed: add WED binding for MT7988 SoC
  net: ethernet: mtk_wed: introduce versioning utility routines
  net: ethernet: mtk_wed: do not configure rx offload if not supported
  net: ethernet: mtk_wed: rename mtk_rxbm_desc in mtk_wed_bm_desc
  net: ethernet: mtk_wed: introduce mtk_wed_buf structure
  net: ethernet: mtk_wed: move mem_region array out of
    mtk_wed_mcu_load_firmware
  net: ethernet: mtk_wed: make memory region optional
  net: ethernet: mtk_wed: fix EXT_INT_STATUS_RX_FBUF definitions for
    MT7986 SoC
  net: ethernet: mtk_wed: add mtk_wed_soc_data structure
  net: ethernet: mtk_wed: refactor mtk_wed_check_wfdma_rx_fill routine
  net: ethernet: mtk_wed: debugfs: move wed_v2 specific regs out of regs
    array

Sujuan Chen (5):
  net: ethernet: mtk_wed: introduce WED support for MT7988
  net: ethernet: mtk_wed: introduce partial AMSDU offload support for
    MT7988
  net: ethernet: mtk_wed: introduce hw_rro support for MT7988
  net: ethernet: mtk_wed: debugfs: add WED 3.0 debugfs entries
  net: ethernet: mtk_wed: add wed 3.0 reset support

 .../arm/mediatek/mediatek,mt7622-wed.yaml     |    1 +
 .../soc/mediatek/mediatek,mt7986-wo-ccif.yaml |    1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |    1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |    2 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c       |    4 +-
 drivers/net/ethernet/mediatek/mtk_ppe.h       |   19 +-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |    6 +-
 drivers/net/ethernet/mediatek/mtk_wed.c       | 1400 ++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_wed.h       |   57 +
 .../net/ethernet/mediatek/mtk_wed_debugfs.c   |  400 ++++-
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c   |   95 +-
 drivers/net/ethernet/mediatek/mtk_wed_regs.h  |  369 ++++-
 drivers/net/ethernet/mediatek/mtk_wed_wo.h    |    3 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |    2 +-
 include/linux/netdevice.h                     |    1 +
 include/linux/soc/mediatek/mtk_wed.h          |   76 +-
 16 files changed, 2109 insertions(+), 328 deletions(-)

-- 
2.41.0


