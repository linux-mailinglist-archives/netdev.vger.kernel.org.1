Return-Path: <netdev+bounces-237504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB2C4CAC3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4753B4971
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1294F264627;
	Tue, 11 Nov 2025 09:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48803252917;
	Tue, 11 Nov 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853416; cv=none; b=IzQjfojixj8sD7VZ5sFyNx3i2UWXeIHZovSbuDyYNI1uCzr9ouhWiEURSBcSPjPC596eeidM8Mb7jUCO0O2fqJ0x27981cF/3ROWfitZDdcJpIjpF9ELvWEu3bzS/kww84RkgiVIH7rDGW8OHL7C0RrAy/bFdNy8NVaQsT0FWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853416; c=relaxed/simple;
	bh=KAfYm3XLNeiVq4W/jH9ysYyfoLUFLclK4gU9aXMBTUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxm9kGW5Z1WaKkDBkRdk68KBjl4HRqK9zx32RUQR393zJncgZXBOgioqdDizMSZ5kAzktBgWNZoh4sGFMOchiqsoylIbWnwTYgcVy/GWpNsYYveZRH7FNFLltgg+QFxTjb8scqBjpmZw/v/oIThedJg/yDjHzZ/1xlGnfUnfhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: E3I0E2d4TqSO7bwA5HLWIA==
X-CSE-MsgGUID: frTPyOc3SIakwotc26WU2g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Nov 2025 18:30:05 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.46])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7D2904172C38;
	Tue, 11 Nov 2025 18:30:01 +0900 (JST)
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
Subject: [PATCH net-next 0/2] net: stmmac: Disable EEE RX clock stop when VLAN is enabled
Date: Tue, 11 Nov 2025 09:29:58 +0000
Message-ID: <20251111093000.58094-1-ovidiu.panait.rb@renesas.com>
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

Ovidiu Panait (2):
  net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
  net: stmmac: Disable EEE RX clock stop when VLAN is enabled

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.51.0


