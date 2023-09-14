Return-Path: <netdev+bounces-33853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64967A0791
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90328281944
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BBB28E2F;
	Thu, 14 Sep 2023 14:39:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51D28E21;
	Thu, 14 Sep 2023 14:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4F3C433C8;
	Thu, 14 Sep 2023 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702346;
	bh=Eo35jmyvF3teBS2RGYOdKRoExXrZoahSKETo7c9s0XU=;
	h=From:To:Cc:Subject:Date:From;
	b=fvRjuEPtg5WtYxpIO6oD5uS+wCRr8IQmLUBgcsG1vN0okkGNIga5YHnHUU7Ferebz
	 C8YrECMnA46LludxbR7ulMaTmzbOCZAHAld7xY/YhbS5h1/rkC8Fo5YAysIW6Iv5YZ
	 5hBNwkLD0LpmWFza3eOkqBVbWXyxAax7xOIYvF1NxTT3esjGXQBkG7Kbd425tcEvCF
	 ptiz1JG7wubsM/uh8KOzLy6Z7hyJplJAx2ijKBNJErgcgVvqYBej7ZUhR1bt+Fk1un
	 AjPYtgsuCL7ND0cyRsYMYzVL+trYp3cGinpoaM4r2ISrJQIVJdKjYPh5jObABueH/r
	 YwEv0ftR2v/7w==
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
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 00/15] Add WED support for MT7988 chipset
Date: Thu, 14 Sep 2023 16:38:05 +0200
Message-ID: <cover.1694701767.git.lorenzo@kernel.org>
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

Lorenzo Bianconi (11):
  dt-bindings: soc: mediatek: mt7986-wo-ccif: add binding for MT7988 SoC
  dt-bindings: arm: mediatek: mt7622-wed: add WED binding for MT7988 SoC
  net: ethernet: mtk_wed: introduce versioning utility routines
  net: ethernet: mtk_wed: introduce mtk_wed_wdma_get_desc_size utility
    routine
  net: ethernet: mtk_wed: do not configure rx offload if not supported
  net: ethernet: mtk_wed: rename mtk_rxbm_desc in mtk_wed_bm_desc
  net: ethernet: mtk_wed: introduce mtk_wed_buf structure
  net: ethernet: mtk_wed: move mem_region array out of
    mtk_wed_mcu_load_firmware
  net: ethernet: mtk_wed: make memory region optional
  net: ethernet: mtk_wed: refactor mtk_wed_check_wfdma_rx_fill routine
  net: ethernet: mtk_wed: debugfs: move wed_v2 specific regs out of regs
    array

Sujuan Chen (4):
  net: ethernet: mtk_wed: introduce WED support for MT7988
  net: ethernet: mtk_wed: introduce partial AMSDU offload support for
    MT7988
  net: ethernet: mtk_wed: introduce hw_rro support for MT7988
  net: ethernet: mtk_wed: debugfs: add WED 3.0 debugfs entries

 .../arm/mediatek/mediatek,mt7622-wed.yaml     |    1 +
 .../soc/mediatek/mediatek,mt7986-wo-ccif.yaml |    1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |    1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |    2 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c       |    4 +-
 drivers/net/ethernet/mediatek/mtk_ppe.h       |   19 +-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |    6 +-
 drivers/net/ethernet/mediatek/mtk_wed.c       | 1081 +++++++++++++----
 drivers/net/ethernet/mediatek/mtk_wed.h       |   45 +
 .../net/ethernet/mediatek/mtk_wed_debugfs.c   |  400 +++++-
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c   |   95 +-
 drivers/net/ethernet/mediatek/mtk_wed_regs.h  |  304 ++++-
 drivers/net/ethernet/mediatek/mtk_wed_wo.h    |    3 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |    2 +-
 include/linux/netdevice.h                     |    1 +
 include/linux/soc/mediatek/mtk_wed.h          |   76 +-
 16 files changed, 1748 insertions(+), 293 deletions(-)

-- 
2.41.0


