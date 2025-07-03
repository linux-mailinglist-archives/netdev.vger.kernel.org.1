Return-Path: <netdev+bounces-203715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161ACAF6DEE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B4D1C80847
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597E2D3A74;
	Thu,  3 Jul 2025 08:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDDD2D3A63;
	Thu,  3 Jul 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533085; cv=none; b=PZpejuTxz6DIyJ5cH09340DUA2UygrFAVxjIIBdYMZ7xNT2g7It5YuEhQgSHqwxMWqDESMfl7ZJqG4AchATTz5jTymofSTABaB79Gt3l1WgHYLyanfZ9BfKrNSgfmNhcSdh9G1UPZeGRpaCaCIYagRHrEIER2zcpHsvHTTdOF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533085; c=relaxed/simple;
	bh=bQyWiZYdYm5aXqkw3t73tYwoLPNz7/6/IJf5Lxr78zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ob6ltXcH/4JazrCfPK6+w/FQxxqJC6Q6v3IZOhR9jNcP23+5BEnFtSIMdfEOsl/avxV+3B2faPQEqxBPVko/gc2lQc5ipZB4j1R2XIJm6El3Iho0DneAYu2x8lSXCh/oJltfwvck8U+rcL6sTakRU7R5rb8FR0GchhEQd3towQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app2 (Coremail) with SMTP id TQJkCgBX9pT1RWZoWl2oAA--.28545S2;
	Thu, 03 Jul 2025 16:57:28 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	jszhang@kernel.org,
	jan.petrous@oss.nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	inochiama@gmail.com,
	boon.khai.ng@altera.com,
	dfustini@tenstorrent.com,
	0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: [PATCH v3 0/2]  Add driver support for Eswin eic7700 SoC ethernet controller
Date: Thu,  3 Jul 2025 16:57:24 +0800
Message-Id: <20250703085724.1960-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBX9pT1RWZoWl2oAA--.28545S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1rGr1fKFy3tw4fZFW3trb_yoW8Cr18pa
	yDCFy5Gw1ktryxJan3Jw10kFySqan7tr1a9r1Iq3WfXayqya90vw4avF4FkF9rArWDXF1a
	qFW3urn8CFn8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRBOJnUUUUU=
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

This patch depends on the vendor prefix patch:
https://lore.kernel.org/all/20250616112316.3833343-4-pinkesh.vaghela@einfochips.com/

Updates:

  Changes in v3:
  - Updated eswin,eic7700-eth.yaml
    - Add descriptions of snps,write-questions, snps,read-questions,
      snps,burst-map attributes
    - Remove the description of reg
    - Delete snps,axi-config
  - Updated dwmac-eic7700.c
    - Simplify drivers and remove unnecessary API and DTS attribute configurations
    - Increase the mapping from tx/rx_delay_ps to private dly
  - Link to v2: https://lore.kernel.org/all/aDad+8YHEFdOIs38@mev-dev.igk.intel.com/

  Changes in v2:
  - Updated eswin,eic7700-eth.yaml
    - Add snps,dwmac in binding file
    - Chang the names of reset-names and phy-mode
  - Updated dwmac-eic7700.c
    - Remove the code related to PHY LED configuration from the MAC driver
    - Adjust the code format and driver interfaces, such as replacing kzalloc
      with devm_kzalloc, etc.
    - Use phylib instead of the GPIO API in the driver to implement the PHY
      reset function
  - Link to v1: https://lore.kernel.org/all/20250516010849.784-1-weishangjuan@eswincomputing.com/

Shangjuan Wei (2):
  dt-bindings: ethernet: eswin: Document for EIC7700 SoC
  ethernet: eswin: Add eic7700 ethernet driver

 .../bindings/net/eswin,eic7700-eth.yaml       | 175 ++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 257 ++++++++++++++++++
 4 files changed, 444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

-- 
2.17.1


