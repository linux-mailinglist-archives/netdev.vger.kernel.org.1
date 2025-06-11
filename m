Return-Path: <netdev+bounces-196460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20261AD4E90
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D533A72E6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E523D2B1;
	Wed, 11 Jun 2025 08:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEC23F40C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631031; cv=none; b=euBs6m5fSVX9rorSAOVaJYEaw/plvDaTzeI/OJaOIejuHcU0pu7VH38sf6zbTW5OulrJMfDvcYT5ag8CwTbiQ6gjS4Scde1JdkkLCPwc63WTa9giZ5MO5LjjcTWbjmKu9+y44vw45EEqLVUixXrqxlz0HTRj1jcJsWK8VRsX4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631031; c=relaxed/simple;
	bh=7hqcaz84SluVy67hFSf74JyGlTNdCH9W4vQKnsHS12s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lghCJygRC/CV33cxzFHC3ospXKzGqWv2tEzcvPvNmrtiTg4rZVTroLJlxhvOt1610pSX3XavSXAaG+yBToErU8CC/LxpNnbNb5cjXdPhpZA0L4uPm+SHXxzN6+LBBtgZQMsHHCU42O5mRTbntPHhhgjTmiRaxD8tfzGmJfayVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630990t49778b83
X-QQ-Originating-IP: 6ti8GF4OkOnscoYkUDg5G4Dumb2GWHRdBIjB1Rr3j+w=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11512189052116220591
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 11/12] net: ngbevf: init interrupts and request irqs
Date: Wed, 11 Jun 2025 16:35:58 +0800
Message-Id: <20250611083559.14175-12-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MdEqvkd2kWCgQ8830PRXGmQV8OyC36KgbHZI/YHPIjeKHsQQIXXtkO0I
	F37L0wq3PGmIrGaWyZqjS0Tc/rqDO/SeXC6Mgb4IDXRQEKv0e3wbqtO2fJlZVqF44ZOJjlh
	oU850F6eU6xLc1H6fQAa97k8AWtk6++3opYQTget3YLHvvVYpOmBJ+YJ6qmJwzPpVuieP+5
	uKOAu3aL3qIrpvmHK9F1e70gtlvNtpS+EjmifkEgAQ7SJ/db/DnM8gM8G/Zf8shYeyr/B59
	jOrnCYdEg/cClsrwbldewVfalI54BPu2w7iAlJ6XDYQfMcVMRZc/hA9MRrbHBrd9Om00QEB
	6nLYOhlyOK9lXC9KTI5lBkNusSwhn6njE49E2/KSb85xPNhzXhNMvvAsmzA0qxh+PaMmTIj
	lfvVMcnOO+6MfNQxSDIGd0GZiM4TngX+Aw/Uh6RG+BeyQFc6dzXiwh0iquAOtrXP6qKTdJW
	6+m7xigmHKaZpnlhVxgxa+oAnhay1myu2/StM1zE9GYtfXIPxSuUGZNLiNuZkPLn/woKK3n
	gs/FBEZu3w6ig7WPv5R8Am9ib3LevHoTz7ZuEfvS1bR7Opj/QBeHaqGSNPb/CyI2fqdjxSc
	034IaAHevyM9CHqwjVALEc+af8Qc0NHIISkhpwaetldIgFR4D7DvMKicdZp1pQ/f1BtMCm+
	fJeIOLGov8QgceWqq2rJadNtrvg8j0Ty15sbtZ/ijTjBPiVJg/aLlmfAv53TqnfOPvxJcvh
	lQ0IUame0N4HnN66N7zwJpkmMDIaNZpHDXPR8Zrk3NY5Ghjv0eqhalR16SWM2fLGNKFoNaW
	nPjyBVTuhbwsIog7i3QA8SoU93Adlu3NKyzcRPNSjhQWuhK4GN8CYgxeyTdh6z5ahLW8MFg
	6qTAq9EwucE+oomVj7ny/Un0u/B532owcuTBfYbTXh45DAs2c3+/RSBNuzCn5tmC4w6KqgZ
	I7aJeGYgxNHLAkAm+yvMH+v41To3rpAK216DkruvrwL1pg6wGUYcM0B9BHTyemceW2XeZTM
	6cObQyHll1QtPGXXGLYzrpkRU+HvkK9fZhO7tkfZn2ywpQ6LoeAXNkDwrm1ItnRBWuS0+Ww
	Nz6C4KD2JR4Xf4ljRH34jetC8wnvWVc6ganJHKiD33K8BYB2XME8FQ=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add specific parameters for irq alloc, then use
wx_init_interrupt_scheme to initialize interrupt
allocation in probe.
Add .ndo_start_xmit support and start all queues.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c  | 18 ++++++++++++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h  |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index 4eea682f024b..a629b645d3a1 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -10,6 +10,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_lib.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
@@ -43,10 +44,18 @@ static const struct pci_device_id ngbevf_pci_tbl[] = {
 static const struct net_device_ops ngbevf_netdev_ops = {
 	.ndo_open               = wxvf_open,
 	.ndo_stop               = wxvf_close,
+	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac_vf,
 };
 
+static void ngbevf_set_num_queues(struct wx *wx)
+{
+	/* Start with base case */
+	wx->num_rx_queues = 1;
+	wx->num_tx_queues = 1;
+}
+
 static int ngbevf_sw_init(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
@@ -65,6 +74,7 @@ static int ngbevf_sw_init(struct wx *wx)
 
 	/* Initialize the device type */
 	wx->mac.type = wx_mac_em;
+	wx->mac.max_msix_vectors = NGBEVF_MAX_MSIX_VECTORS;
 	/* lock to protect mailbox accesses */
 	spin_lock_init(&wx->mbx.mbx_lock);
 
@@ -98,6 +108,7 @@ static int ngbevf_sw_init(struct wx *wx)
 	/* set default work limits */
 	wx->tx_work_limit = NGBEVF_DEFAULT_TX_WORK;
 	wx->rx_work_limit = NGBEVF_DEFAULT_RX_WORK;
+	wx->set_num_queues = ngbevf_set_num_queues;
 
 	return 0;
 err_reset_hw:
@@ -186,15 +197,22 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
+	err = wx_init_interrupt_scheme(wx);
+	if (err)
+		goto err_free_sw_init;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	netif_tx_stop_all_queues(netdev);
 
 	return 0;
 
 err_register:
+	wx_clear_interrupt_scheme(wx);
+err_free_sw_init:
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
index dc29349304f1..67e761089e99 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
@@ -18,6 +18,7 @@
 #define NGBEVF_DEV_ID_EM_WX1860A1               0x011a
 #define NGBEVF_DEV_ID_EM_WX1860AL1              0x011b
 
+#define NGBEVF_MAX_MSIX_VECTORS               1
 #define NGBEVF_MAX_RX_QUEUES                  1
 #define NGBEVF_MAX_TX_QUEUES                  1
 #define NGBEVF_DEFAULT_TXD                    128
-- 
2.30.1


