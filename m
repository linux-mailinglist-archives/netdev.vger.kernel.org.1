Return-Path: <netdev+bounces-201065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9412AAE7F0F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C4C7B4C47
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92029E0EC;
	Wed, 25 Jun 2025 10:22:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EE29B23B
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846946; cv=none; b=PaK3FrbpEX2JNF2RODZt9LKNAwtEZARLpFWAeGinLCVjfGSK4uKiy21dRiFc6BGXALC1Q0wdX7v6gkFDGkPanp7X5kHIhTnO67P2fNuHY8GMAeIfKWJ9+ALHfdsW8MZRQnYYq8CauaCWLmMRmrYdToZEfVFs5c1EDGdpa8ueJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846946; c=relaxed/simple;
	bh=7hqcaz84SluVy67hFSf74JyGlTNdCH9W4vQKnsHS12s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHUicem77X5tocG/GhA2DgCfyrhpHGksB/crxu4rtRlpdiptPwJlWVe4tuMyeSkyCJuybTYGLz2oCPKTG2nFUVGzd/s5EDMm7w9JP4XhEoZZ/EY9suocRD+dXQlTooVTXZfT8Mn2Vn2m/Vue5NMAeclu/EHAN78CJWi6eelIYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846887t3cb666ba
X-QQ-Originating-IP: jtRMwdQwEPKQHIBvJ8iex9apMMHR03M1Gc2NyzXGZo4=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3029809876196297638
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 11/12] net: ngbevf: init interrupts and request irqs
Date: Wed, 25 Jun 2025 18:20:57 +0800
Message-Id: <20250625102058.19898-12-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250625102058.19898-1-mengyuanlou@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NqPPq/RgI0fMoBzevOIGovIIbN5rRtayhRSmzbaDifkTu2HgiJQL1RZZ
	jg3xzwxoSCjJiw5IjXaexisxnNa/+o/uTNKgHp7kjNwA3o930bsvxIDKCCG1EsofDllD6Zs
	OQBh9M+kR6oUwWpF4obU4nDIH6dpBp83sSom/HZbayV4Z3Fq5R3lEVoE2vt34YXbRpI8orB
	/021nQLT9l/G8I1OoWcLJ7XjP3zXyCMDe7LGw4eVPScqt9BmrU2ZXbcx5GJ+1EdLXpc9ilB
	G6kFkcd85aZzK/VNEM0pNNWVLjDFysMLw1sU0f/YdwsJtLDrTPDHcsGFFfRx5llkIaV5QfG
	EW7aRGKesqvstTT7TiXuo1tiK3Gl4Yfe7dbofuSwMXYYovahTZoeCLe3EM2C6a3qXGYd6cK
	lKg0QBgc6lm3D9/8VIqcjVa/C/hgqnBuv2ajjX1rgbpldB9xyEIEuU3pLu7L7cyZ8h47SH7
	i5XAlpT1sXNg8GfOShmB1BdcKBTLJJlDlGSSkNWm/zPh7fggEU7+1HMAJaC9aEHFAwidsOe
	ZK+joRp6bV+0SYLNf1CjyPiRloc8jdM1hQowo9oVmgZ5KQKwIuC/IpHHwqgf1OwxwFWocED
	5RIzbkOjcBv7A6JVsvxgFSUlJ8ozUPgTOO9OEX82Lq5dxJ3+HzrDoTH7KPU/Z3RsSoufawK
	Jm+V++e4dPtK+SZ8+ibQ6P3gUKe3f3HhbVWeODuUOIffgr40AARe6JZjQZu8IOJwN4JHsOj
	EM4C7/ibJap4AcdlOljxBJdZlztHET6AjjqrpziKbVmw3JQ9um9qVwdBa/HM27B690OHklO
	wULYfm24PhvCddcyVF+zBfTFo0zwjOl2pA5kuaiRIKLAqhz/geSSpa4qP/yDjettY954bq+
	4B4I9aGOU/CAJ8v9Qe2HnSjU4jayq0LPM5f0YTge8ESlX7aP2m8IOvRBymA4QzWTeZj58xZ
	ezWl/Z9/lpT2f1i5XQjdLA5OWP1BVSebM8PE36bKZnkuzTLmLMZtbXfGqE4+xWoFD244YfW
	fn1Ppejrc2W6sYkQHTXuL1KYbaSCokGxF+ceqqGKBtaIbAw6hNcnlfQc0nW3wSXmPkyV2dj
	v7TmwV7t+dkdjMExlUvXlgW1o1ol5dml1/Q9P4PwfedWUqbO6Y0Ub3RdbkxpoHOJ1N3MH2V
	WhT6
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


