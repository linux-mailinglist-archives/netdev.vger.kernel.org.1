Return-Path: <netdev+bounces-238302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171EC5732F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEBD3ACE91
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18633ADAF;
	Thu, 13 Nov 2025 11:27:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5327B4E8;
	Thu, 13 Nov 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033256; cv=none; b=F3o0SxrCClXkGUMr2p9G20vf6i7HSfUq0ee5zS2EZa3uEV0Y+Bxwt4JTJQSzPJNDSzl2/GzL8iXNo2JmoP3vGspZV42jdslF9TuKRbYypoZulksEiVg2WsuZJCelexeIdRmFcRh4XLzlgiXydUAkdTr9Z4iwsjf9Eds3jtBIYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033256; c=relaxed/simple;
	bh=UrvlQ83EKK9oIfUzK6QTaUu2K8vkuGwtm07L3TzfAzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7wXGHwjIZQae9TgImoFzXeTIWKWKYGMmN8xz7xf7Q/PSyKuhdA0WYpd2+y6td1Id6zpHEyrzDhZBbpAiwSDSmR7nEBKYlWNNRlyw8rLH+ZbBRd7P6kW0OyiA0uba26sbMI5HWtYTQunApvTHiJ/l2V6ldbrnAdQpjhPJh7zkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: yahheH1SRiuOOQtMT8/IWA==
X-CSE-MsgGUID: Df5RvJB/RFamhu+4zrneHQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Nov 2025 20:27:27 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.175])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 084A2428B0E9;
	Thu, 13 Nov 2025 20:27:22 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: stmmac: Disable EEE RX clock stop when VLAN is enabled
Date: Thu, 13 Nov 2025 11:27:19 +0000
Message-ID: <20251113112721.70500-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a couple of VLAN issues observed on the Renesas RZ/V2H
EVK platform (stmmac + Microchip KSZ9131RNXI PHY):

- The first patch fixes a bug where VLAN ID 0 would not be properly removed
due to how vlan_del_hw_rx_fltr() matched entries in the VLAN filter table.

- The second patch addresses RX clock gating issues that occur during VLAN
creation and deletion when EEE is enabled with RX clock-stop active (the
default configuration). For example:

    # ip link add link end1 name end1.5 type vlan id 5
    15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    RTNETLINK answers: Device or resource busy

The stmmac hardware requires the receive clock to be running when writing
certain registers, including VLAN registers. However, by default the driver
enables Energy Efficient Ethernet (EEE) and allows the PHY to stop the
receive clock when the link is idle. As a result, the RX clock might be
stopped when attempting to access these registers, leading to timeouts.

A more comprehensive overview of receive clock related issues in the
stmmac driver can be found here:
https://lore.kernel.org/all/Z9ySeo61VYTClIJJ@shell.armlinux.org.uk/

Most of the issues were resolved by commit dd557266cf5fb ("net: stmmac:
block PHY RXC clock-stop"), which wraps register accesses with
phylink_rx_clk_stop_block()/unblock() calls. However, VLAN add/delete
operations are invoked with bottom halves disabled, where sleeping is
not permitted, so those helpers cannot be used.

To avoid these VLAN timeouts, the second patch disables the EEE RX
clock-stop feature when VLAN support is enabled. This ensures the receive
clock remains active, allowing VLAN operations to complete successfully.

Best regards,
Ovidiu

v2:
- Added comment mentioning that EEE RX clock stop is disabled to allow
  access to VLAN registers.
- Added "Reviewed-by" tag from Russell.

Ovidiu Panait (2):
  net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
  net: stmmac: Disable EEE RX clock stop when VLAN is enabled

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.51.0


