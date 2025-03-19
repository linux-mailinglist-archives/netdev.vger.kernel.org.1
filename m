Return-Path: <netdev+bounces-176070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A17A6898B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AD017976C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C719253F0A;
	Wed, 19 Mar 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErHZQB2S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EY3FibrA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5920DD4B
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380012; cv=none; b=TXCa7QBGVLWQJ5oKTUPBRjvfEGwuJUjVFoTtt448bEC4fLslm8O4GpfEYjwO4J2rkG6QALF0luMu0rWBXkxSq2WqNoWzATpdywv9/A/lKFOUR5FO16tdFOEjgOQV4U8M2LPPytiHc2LnZW6ty3jOTsH7F0ZS7tqRt6YAIROmCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380012; c=relaxed/simple;
	bh=1vqoQlywhZPsl+VmtbqoH2X1ya01NGSNUs3Vu/zAUY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhpgfqL6Al+kItiecJARJbcOWTVQyNjhy2GTOdHZWKLcyWr03XanHFKbsM65qMfcY3+FsUjNuu74z5yiG7MwZidyH2+HvHlvN54MT5/wdp7PZFwvyjtUciQWEQTLGSxROc3jO+eGgtd3oykwTOsvqMeoEMpWhFKP3MXH96AVFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErHZQB2S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EY3FibrA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742380008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwnxYQpo55bl7av0RxzWWNuI7xN+6Fs6sOckb0gHB3I=;
	b=ErHZQB2SEiqfJ92WptqrUYH3vxfhf5m+UmHoXXrG/3OjZzB85w2lY6GtwrIpsmXiamSRQN
	XytqTdaL+XD1ojeTAsPpQRUKP+roDehmto3kwc6D9TZoQME0wW7AjzKh8OCToiWLM1LR/u
	DiMmn3afgdA51sohe55Qdv/0hea1o7C8atqAHbhGHbvG0oOk+JY7R/Kv1xkq6Dm6wJLzH6
	168zJgrE5kqJuT5Bg/NqQNjrqOqd5qkZaA02axvocqDg/egWnCEZVvFb88KqVbI4nE1Qk2
	E3Bxvj66WAvroGvzTrrLh7xK0cxBFPP3OkvGDl++b+/lpEFvNYouF4cz4YZRwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742380008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwnxYQpo55bl7av0RxzWWNuI7xN+6Fs6sOckb0gHB3I=;
	b=EY3FibrAixlzfIA6nhLYqz5hUikXtw61bqSPgI/lcUAe55BkatKocJ9nzxTW7hC8lyGs2L
	W399qQQ0fpQ+r3Bw==
Date: Wed, 19 Mar 2025 11:26:40 +0100
Subject: [PATCH iwl-next v3 2/4] igb: Link queues to NAPI instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-igb_irq-v3-2-b9ee902143dd@linutronix.de>
References: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
In-Reply-To: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5680; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=1vqoQlywhZPsl+VmtbqoH2X1ya01NGSNUs3Vu/zAUY8=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBn2pvlZPCzeUkFIZ4RYoE5JYwg+twe2mrh1qYnS
 uo2XCRfXHGJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ9qb5QAKCRDBk9HyqkZz
 ggRSD/965rznYfw6mk+jxpYQg+kW8kGRWK99axdGBWTxKryYIhree7PDyl+Nf0NanMC+4IlrQlV
 soima/gmWUqS9wvjANGBnIlZxBXZpoThNU3dGyvOtVKqVpAFH12jtbzs+YAcj+shDmrk6s12bqa
 s3sveIfSzLsjr1sAT+dFvhXSlMmc2wXc/VAqi3pIST4cUA68SdLGQUdVIdWOk9ega5kaHBg7bE/
 sMQgzCPQbUXuLR6NX8TclAmScCLJu5qpWfE75HYTOgpQloP3o482LdcTSuKoMAPQcBJc3i6Fory
 zXWTK1MLYpEvdledWqr8dhe68v2hP1c5yUcw4XTPprvf7ePsvh78RmVKFh7POqla/fB3vQq96DY
 0fq9b3YSDbk82zD7HPXkazlayPG0ocHQ8m7LVY4sWj0gKo6eKQ4ygnzGgcupHd+uRuS/JmLxSaV
 RR54UjHLuo6iBmLsdXZ6aDshx2doMl03OG1PFFcJB9oWLIHEephQldckuy5xVt2b6rw1Ir98icX
 YGsWaLD+hPXH3bOMUJk1rWp/l6pd7OsTEOUVmSUDW6wt6/JdGHDjFeuNvR0ukL9kCbHjrOd1ysB
 qBm0iI2QeJ5u8zEhLNsihNzbbn6tqoIpd0NBvHOLAhdw6p8MbWzez9UF5JzqouYC6BzNx3ozHqO
 J8qO2A8Z7xmP5ug==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Link queues to NAPI instances via netdev-genl API. This is required to use
XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy polling
support") for details.

This also allows users to query the info with netlink:

|$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
|                               --dump queue-get --json='{"ifindex": 2}'
|[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
| {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
| {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
| {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
| {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
| {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
| {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
| {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]

Add rtnl locking to PCI error handlers, because netif_queue_set_napi()
requires the lock held.

While at __igb_open() use RCT coding style.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb.h      |  2 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 43 +++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 02f340280d20a6f7e32bbd3dfcbb9c1c7b4c6662..79eca385a751bfdafdf384928b6cc1b350b22560 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -722,6 +722,8 @@ enum igb_boards {
 
 extern char igb_driver_name[];
 
+void igb_set_queue_napi(struct igb_adapter *adapter, int q_idx,
+			struct napi_struct *napi);
 int igb_xmit_xdp_ring(struct igb_adapter *adapter,
 		      struct igb_ring *ring,
 		      struct xdp_frame *xdpf);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4128d19cc08f62f95682069bb5ed9b8bbbf10cb..6870803a42455aa1d31f39beb027cf282064388f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2099,6 +2099,22 @@ static void igb_check_swap_media(struct igb_adapter *adapter)
 	wr32(E1000_CTRL_EXT, ctrl_ext);
 }
 
+void igb_set_queue_napi(struct igb_adapter *adapter, int vector,
+			struct napi_struct *napi)
+{
+	struct igb_q_vector *q_vector = adapter->q_vector[vector];
+
+	if (q_vector->rx.ring)
+		netif_queue_set_napi(adapter->netdev,
+				     q_vector->rx.ring->queue_index,
+				     NETDEV_QUEUE_TYPE_RX, napi);
+
+	if (q_vector->tx.ring)
+		netif_queue_set_napi(adapter->netdev,
+				     q_vector->tx.ring->queue_index,
+				     NETDEV_QUEUE_TYPE_TX, napi);
+}
+
 /**
  *  igb_up - Open the interface and prepare it to handle traffic
  *  @adapter: board private structure
@@ -2106,6 +2122,7 @@ static void igb_check_swap_media(struct igb_adapter *adapter)
 int igb_up(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int i;
 
 	/* hardware has been reset, we need to reload some things */
@@ -2113,8 +2130,11 @@ int igb_up(struct igb_adapter *adapter)
 
 	clear_bit(__IGB_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&(adapter->q_vector[i]->napi));
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		igb_set_queue_napi(adapter, i, napi);
+	}
 
 	if (adapter->flags & IGB_FLAG_HAS_MSIX)
 		igb_configure_msix(adapter);
@@ -2184,6 +2204,7 @@ void igb_down(struct igb_adapter *adapter)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
 			napi_synchronize(&adapter->q_vector[i]->napi);
+			igb_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
@@ -4116,8 +4137,9 @@ static int igb_sw_init(struct igb_adapter *adapter)
 static int __igb_open(struct net_device *netdev, bool resuming)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
-	struct e1000_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
+	struct e1000_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int err;
 	int i;
 
@@ -4169,8 +4191,11 @@ static int __igb_open(struct net_device *netdev, bool resuming)
 	/* From here on the code is the same as igb_up() */
 	clear_bit(__IGB_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&(adapter->q_vector[i]->napi));
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		igb_set_queue_napi(adapter, i, napi);
+	}
 
 	/* Clear any pending interrupts. */
 	rd32(E1000_TSICR);
@@ -9677,8 +9702,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
 
+	rtnl_lock();
 	if (netif_running(netdev))
 		igb_down(adapter);
+	rtnl_unlock();
+
 	pci_disable_device(pdev);
 
 	/* Request a slot reset. */
@@ -9737,16 +9765,21 @@ static void igb_io_resume(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	rtnl_lock();
 	if (netif_running(netdev)) {
 		if (!test_bit(__IGB_DOWN, &adapter->state)) {
 			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
+			rtnl_unlock();
 			return;
 		}
+
 		if (igb_up(adapter)) {
 			dev_err(&pdev->dev, "igb_up failed after reset\n");
+			rtnl_unlock();
 			return;
 		}
 	}
+	rtnl_unlock();
 
 	netif_device_attach(netdev);
 

-- 
2.39.5


