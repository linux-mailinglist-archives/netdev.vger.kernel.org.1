Return-Path: <netdev+bounces-182659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DABA898B3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F86C189E968
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B3288C9A;
	Tue, 15 Apr 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgJMxEdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B368288C83
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710827; cv=none; b=X3wd5+566QII41RDM830FyqbK6MiMZQD6AryragOdELORiPrA5NPmdCH98yVTRRsAyu1lBFy+T6CnU8ceg4qmbjIbYV4OUtkluaP4InQagPxcOqsAzKtrqdy7V1KJ+RwJHvl096qgdpsZ6/88/0DWMSuJCOV+OnCwgYBxCCg694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710827; c=relaxed/simple;
	bh=8tJRfp3LEvOrj/w4Jmt0bvPeGysq75baioQZV0edSh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ntzc/J7IBXLR+mpk0AkaC3LSAHgI3wWZEFtSwj/jUkuftb3/qiVQiarCTcodN1LLDgsScMBwNxPfVLEgjYtBP6HWQIOgCFzdndkYEb6Uv8r1Bus0D7mKOEa2SfxkQ+Ex4I5gCGsvaW94XjwzEywX372I66Zid3GmFqq+V3sTVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgJMxEdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9958C4CEE9;
	Tue, 15 Apr 2025 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744710827;
	bh=8tJRfp3LEvOrj/w4Jmt0bvPeGysq75baioQZV0edSh4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZgJMxEdoi44Au+1RUpogrKDlyWxohEl3tt0VlaRqz/CjWyZMA3xNG4wU8WIRO6UnW
	 fFXs7/KhRwV+Qn7tPB3+hfs3m1BL6GAYUKZ9/M5GANoJZ9I4O+lwE4ksdvs2ZprE4t
	 G8h0Dn0LtDima7E4NFlvMhzc4BlMGBDDs0HRNsJl1G3eT86VQxHE5FI7yq/6hN+L4L
	 YfSWMnAq9qmvUdY2/YJLgFyOIqKRHC+qHauDlJGI1OxyIOEvpdBex1m78lZiiXIonN
	 7d7kfgCA1jWvG+YzKSaVTSUcpb2OUqOWhugWNuefFB8Pc9/t82PLhaGz15lQvaLOgv
	 lJyIdROhzU+jg==
From: Niklas Cassel <cassel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Date: Tue, 15 Apr 2025 11:53:36 +0200
Message-ID: <20250415095335.506266-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=cassel@kernel.org; h=from:subject; bh=8tJRfp3LEvOrj/w4Jmt0bvPeGysq75baioQZV0edSh4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/6cxf6lWYZT3Zk/Oc9KWZJYpuDbqme41tJn77qcskq i9kYTqto5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNpfMXIcODE1y+rvvrJ/Nwk qs663evzrpuPq/s+vVjKnL7u4d87MpyMDC/k//cXLF3/vP98Cdfk7FfPr+of1k3mTTCWimFMXXD 4BTMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

For a PCI controller driver with a .shutdown() callback, we will see the
following warning:
[   12.020111] called from state HALTED
[   12.020459] WARNING: CPU: 7 PID: 229 at drivers/net/phy/phy.c:1630 phy_stop+0x134/0x1a0

This is because rtl8169_down() (which calls phy_stop()) is called twice
during shutdown.

First time:
[   23.827764] Call trace:
[   23.827765]  show_stack+0x20/0x40 (C)
[   23.827774]  dump_stack_lvl+0x60/0x80
[   23.827778]  dump_stack+0x18/0x24
[   23.827782]  rtl8169_down+0x30/0x2a0
[   23.827788]  rtl_shutdown+0xb0/0xc0
[   23.827792]  pci_device_shutdown+0x3c/0x88
[   23.827797]  device_shutdown+0x150/0x278
[   23.827802]  kernel_restart+0x4c/0xb8

Second time:
[   23.841468] Call trace:
[   23.841470]  show_stack+0x20/0x40 (C)
[   23.841478]  dump_stack_lvl+0x60/0x80
[   23.841483]  dump_stack+0x18/0x24
[   23.841486]  rtl8169_down+0x30/0x2a0
[   23.841492]  rtl8169_close+0x64/0x100
[   23.841496]  __dev_close_many+0xbc/0x1f0
[   23.841502]  dev_close_many+0x94/0x160
[   23.841505]  unregister_netdevice_many_notify+0x160/0x9d0
[   23.841510]  unregister_netdevice_queue+0xf0/0x100
[   23.841515]  unregister_netdev+0x2c/0x58
[   23.841519]  rtl_remove_one+0xa0/0xe0
[   23.841524]  pci_device_remove+0x4c/0xf8
[   23.841528]  device_remove+0x54/0x90
[   23.841534]  device_release_driver_internal+0x1d4/0x238
[   23.841539]  device_release_driver+0x20/0x38
[   23.841544]  pci_stop_bus_device+0x84/0xe0
[   23.841548]  pci_stop_bus_device+0x40/0xe0
[   23.841552]  pci_stop_root_bus+0x48/0x80
[   23.841555]  dw_pcie_host_deinit+0x34/0xe0
[   23.841559]  rockchip_pcie_shutdown+0x20/0x38
[   23.841565]  platform_shutdown+0x2c/0x48
[   23.841571]  device_shutdown+0x150/0x278
[   23.841575]  kernel_restart+0x4c/0xb8

Add a netif_device_present() guard around the rtl8169_down() call in
rtl8169_close(), to avoid rtl8169_down() from being called twice.

This matches how e.g. e1000e_close() has a netif_device_present() guard
around the e1000e_down() call.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4eebd9cb40a3..0300a06ae260 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4879,7 +4879,8 @@ static int rtl8169_close(struct net_device *dev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	netif_stop_queue(dev);
-	rtl8169_down(tp);
+	if (netif_device_present(tp->dev))
+		rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
 	free_irq(tp->irq, tp);
-- 
2.49.0


