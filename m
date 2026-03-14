Return-Path: <netdev+bounces-267823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHjILlaptWmw3AAAu9opvQ
	(envelope-from <netdev+bounces-267823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A828E77B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D71D3014911
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D6337689;
	Sat, 14 Mar 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brohx7Mc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594A3368B5
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512960; cv=none; b=JNbAjCNnTL31yyxPZZhxrjiAnTJks+inJZtkNDSTfu+5D+RF8bASfXlPRNbhREeUcgREzqTnKZgoBlnPhTAhoQcY0rCujivwDtmhE7bXP7YO3Iz9rZoKcH/LS+kbESNR/ojRJWf6urwZ4203K5mMN6VFaIGXlDcPP5VzBZ99MAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512960; c=relaxed/simple;
	bh=dO/o0JMUv+1ZIvwhmT7hMk44yXS9kH2XOnxXr/908xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFsxp9FiPlTPR7iLI6ozzlxImH6G61P0wdqhyLr1EItu84Dd47jRwNT/qMJ4zwsvyz0IdecLUVrXN6yKH3jQQBWl9XuISRMboBI+9KiHrZtqdQdklztMNElw3TxvIR4v/kQKdD2/6rTONzoihcS6hmTEBqmg34vThv+qoCsycrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brohx7Mc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0484a6de4so1743225ad.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512959; x=1774117759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcUZRx+vC9EsPoreW0zaJm9GJsT/ODmp1Tzy9ZQGo5g=;
        b=Brohx7MccDU9TKHJVQ6jwhEuxgT8IHS2grEmygbD8Ziv+P/TywAabAjIuwFIia/uNc
         JXTvXCBON1LZnDjJwx5VkV/xdwM9uYJB61HWlievtZYpKYMFfFs0OQVKGuF+zgo4yuGp
         WlWsmr/5trnflvUnkvhKNq1Ahj6zEQBOUaJP1z/NXtWgBmrjQxpPgZ6NBPKbC4123uy+
         wSbraUDANqQG2lZD05rARHJHVyHXWet+sV29TqvE0hFJA+0WVzvigvLpv4SOmcPr1YwH
         tpul6OJXGBqZ5eNoRMYMTTb+oRfiNWXBgIawDf0SGHRa4Y/iQ/Zb18toxKJp82a8xQVU
         aUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512959; x=1774117759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcUZRx+vC9EsPoreW0zaJm9GJsT/ODmp1Tzy9ZQGo5g=;
        b=KVWuOPfbyZOGX/RtJ+zwmlJ5iq5+YSFrsH1MdCVZ+XPNX+OTjugr+dL2Wf241zeo5l
         1EolpGqrF0U98RQBIMemIzKTRb8rOX3vzpiPw5PYgwgoffvVxYKKAIOytO7WxQnowMgY
         n7mYpc9bF8MtPAduGJC9CFPVDchJb0ZGJL2UIqzf2u0jr8AqLRZR2urRhogl4TFMzACi
         hxW4upQSVuPFQFR+q6bBaTXL/LpGtAJP08EQaOeLZve5y21C6HFjZltSj884SSxJes74
         ri6aH1sq8wIWBYm5AuZUDtCudBS7WH0DuGYZe5Gt2k/bN4VrestgT6kT8va7yGJxJbIm
         oQYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaEWqltmCEn27qa6a2PJcI/1qBQ44J5f0HU4n0AOp1vYfMdcP2Non9+LATQwk6wAIkfohulpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxao0f50eiy/hSdXxIlnpN2k/R4DIBIsSKnTLTryYJW5RAKmf0U
	woeTvhs1zGYU9Dxo+n0GrzoxKOxr26KLGOS0fFqmoIBwb2U5v4WRbWUM
X-Gm-Gg: ATEYQzywi4AeRs+ANz3PxTmaMXijAaMvnFh1GKoMXJQt70mN4rlMUsOhSZn+W+AHLL+
	+171OF5t7iKJl4p7PrxZ9WRpEbN7e7fQT1wjCXauDyyHPSU7bYNUioB7wV/Zpx8vTd58sPs4qQG
	LTYFrMPPAW1Pc0iTnphK7iNRB8iJDFrgRCx3V6lbK1mDBWde8pB0ItwsnMruMH5gnMEBXxLlL3Q
	uKq5rVQHRC+BTzmT75SvP2DSE2t2yAbAq3uVqLkos1P03SC76K6ciQhv19Q1TYYj4NJ6fe9GK6d
	9CpvcXbnzrMSf9IP4k+tTaOr7rVsGZuF0lOA+WVQ5eHol5Nn+93pteBRQ6Nk9MaLOlWwre4iIlT
	5x1o6VWRxPNmebD9y7CvEuVKjGJaIVpyr/n5rgtmB57a34FRgx4HIF3AaTJYRcQGcjRHJ0mlmq/
	9Vx1qmOIL48jsb3AYPlmj1RhuidiVDo8LV2sSNn2K6YD8TP8fTytkF7aXrFnTrJp2Q9sRQC4Toz
	okBphUaqpTw0trL
X-Received: by 2002:a17:903:2283:b0:2ae:c5b2:6a41 with SMTP id d9443c01a7336-2aecac84adamr78848905ad.52.1773512958550;
        Sat, 14 Mar 2026 11:29:18 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:17 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: stfomichev@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	mst@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v9 4/7] e1000: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:06 +0530
Message-ID: <20260314182809.362808-5-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD9A828E77B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_set_rx_mode_async callback and update
the driver to use the snapshot/commit model for RX mode update.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---

Call paths involving netif_set_rx_mode in e1000

netif_set_rx_mode
|-- __e1000_shutdown (lock added)
|
`-- e1000_configure
    |-- e1000_open (ndo_open, takes lock)
    |
    `-- e1000_up
        |-- e1000_reinit_locked
        |   |-- e1000_set_features (ndo_set_features, takes lock)
        |   |-- e1000_reset_task (ethtool callback, takes lock)
        |   |-- e1000_mii_ioctl
        |   |   `-- e1000_ioctl (ndo_do_ioctl, takes lock)
        |   `-- e1000_nway_reset (ethtool callback, takes lock)
        |
        |-- e1000_change_mtu (ndo_change_mtu, takes lock)
        |-- e1000_resume (lock added)
        |-- e1000_io_resume (lock added)
        |
        |-- e1000_set_link_ksettings (ethtool callback, takes lock)
        |-- e1000_set_pauseparam (ethtool callback, takes lock)
        `-- e1000_set_ringparam (ethtool callback, takes lock)

 drivers/net/ethernet/intel/e1000/e1000_main.c | 77 ++++++++++++++-----
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 9b09eb144b81..ec25b41c63b7 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -99,6 +99,7 @@ static void e1000_clean_tx_ring(struct e1000_adapter *adapter,
 static void e1000_clean_rx_ring(struct e1000_adapter *adapter,
 				struct e1000_rx_ring *rx_ring);
 static void e1000_set_rx_mode(struct net_device *netdev);
+static void e1000_set_rx_mode_async(struct net_device *netdev);
 static void e1000_update_phy_info_task(struct work_struct *work);
 static void e1000_watchdog(struct work_struct *work);
 static void e1000_82547_tx_fifo_stall_task(struct work_struct *work);
@@ -359,7 +360,7 @@ static void e1000_configure(struct e1000_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	e1000_set_rx_mode(netdev);
+	netif_set_rx_mode(netdev);
 
 	e1000_restore_vlan(adapter);
 	e1000_init_manageability(adapter);
@@ -823,6 +824,7 @@ static const struct net_device_ops e1000_netdev_ops = {
 	.ndo_stop		= e1000_close,
 	.ndo_start_xmit		= e1000_xmit_frame,
 	.ndo_set_rx_mode	= e1000_set_rx_mode,
+	.ndo_set_rx_mode_async	= e1000_set_rx_mode_async,
 	.ndo_set_mac_address	= e1000_set_mac,
 	.ndo_tx_timeout		= e1000_tx_timeout,
 	.ndo_change_mtu		= e1000_change_mtu,
@@ -2223,23 +2225,44 @@ static int e1000_set_mac(struct net_device *netdev, void *p)
 }
 
 /**
- * e1000_set_rx_mode - Secondary Unicast, Multicast and Promiscuous mode set
+ * e1000_set_rx_mode - Secondary Unicast, Multicast and Promiscuous mode
+ * config.
  * @netdev: network interface device structure
  *
  * The set_rx_mode entry point is called whenever the unicast or multicast
  * address lists or the network interface flags are updated. This routine is
- * responsible for configuring the hardware for proper unicast, multicast,
- * promiscuous mode, and all-multi behavior.
+ * responsible for preparing the rx mode config and scheduling the rx_mode
+ * work which invokes the set_rx_mode_async callback.
  **/
 static void e1000_set_rx_mode(struct net_device *netdev)
+{
+	bool allmulti = !!(netdev->flags & IFF_ALLMULTI);
+	bool promisc = !!(netdev->flags & IFF_PROMISC);
+
+	netif_set_rx_mode_flag(netdev, NETIF_RX_MODE_UC_SKIP, promisc);
+
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+}
+
+/**
+ * e1000_set_rx_mode_async - Secondary Unicast, Multicast and Promiscuous mode
+ * confirm.
+ * @netdev: network interface device structure
+ *
+ * The set_rx_mode_async callback is responsible for actually updating the
+ * hardware. This routine is responsible for configuring the hardware for
+ * proper unicast, multicast, promiscuous mode, and all-multi behavior.
+ **/
+static void e1000_set_rx_mode_async(struct net_device *netdev)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	struct netdev_hw_addr *ha;
 	bool use_uc = false;
+	char *ha_addr;
 	u32 rctl;
 	u32 hash_value;
-	int i, rar_entries = E1000_RAR_ENTRIES;
+	int i, rar_entries = E1000_RAR_ENTRIES, ni;
 	int mta_reg_count = E1000_NUM_MTA_REGISTERS;
 	u32 *mcarray = kcalloc(mta_reg_count, sizeof(u32), GFP_ATOMIC);
 
@@ -2250,11 +2273,11 @@ static void e1000_set_rx_mode(struct net_device *netdev)
 
 	rctl = er32(RCTL);
 
-	if (netdev->flags & IFF_PROMISC) {
+	if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		rctl |= (E1000_RCTL_UPE | E1000_RCTL_MPE);
 		rctl &= ~E1000_RCTL_VFE;
 	} else {
-		if (netdev->flags & IFF_ALLMULTI)
+		if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI))
 			rctl |= E1000_RCTL_MPE;
 		else
 			rctl &= ~E1000_RCTL_MPE;
@@ -2263,9 +2286,9 @@ static void e1000_set_rx_mode(struct net_device *netdev)
 			rctl |= E1000_RCTL_VFE;
 	}
 
-	if (netdev_uc_count(netdev) > rar_entries - 1) {
+	if (netif_rx_mode_uc_count(netdev) > rar_entries - 1) {
 		rctl |= E1000_RCTL_UPE;
-	} else if (!(netdev->flags & IFF_PROMISC)) {
+	} else if (!netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		rctl &= ~E1000_RCTL_UPE;
 		use_uc = true;
 	}
@@ -2286,23 +2309,23 @@ static void e1000_set_rx_mode(struct net_device *netdev)
 	 */
 	i = 1;
 	if (use_uc)
-		netdev_for_each_uc_addr(ha, netdev) {
+		netif_rx_mode_for_each_uc_addr(ha_addr, netdev, ni) {
 			if (i == rar_entries)
 				break;
-			e1000_rar_set(hw, ha->addr, i++);
+			e1000_rar_set(hw, ha_addr, i++);
 		}
 
-	netdev_for_each_mc_addr(ha, netdev) {
+	netif_rx_mode_for_each_mc_addr(ha_addr, netdev, ni) {
 		if (i == rar_entries) {
 			/* load any remaining addresses into the hash table */
 			u32 hash_reg, hash_bit, mta;
-			hash_value = e1000_hash_mc_addr(hw, ha->addr);
+			hash_value = e1000_hash_mc_addr(hw, ha_addr);
 			hash_reg = (hash_value >> 5) & 0x7F;
 			hash_bit = hash_value & 0x1F;
 			mta = (1 << hash_bit);
 			mcarray[hash_reg] |= mta;
 		} else {
-			e1000_rar_set(hw, ha->addr, i++);
+			e1000_rar_set(hw, ha_addr, i++);
 		}
 	}
 
@@ -5092,7 +5115,10 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 
 	if (wufc) {
 		e1000_setup_rctl(adapter);
-		e1000_set_rx_mode(netdev);
+
+		rtnl_lock();
+		netif_set_rx_mode(netdev);
+		rtnl_unlock();
 
 		rctl = er32(RCTL);
 
@@ -5150,11 +5176,13 @@ static int e1000_suspend(struct device *dev)
 {
 	int retval;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct net_device *netdev = pci_get_drvdata(pdev);
 	bool wake;
 
 	retval = __e1000_shutdown(pdev, &wake);
 	device_set_wakeup_enable(dev, wake);
 
+	netif_disable_async_ops(netdev);
 	return retval;
 }
 
@@ -5166,6 +5194,8 @@ static int e1000_resume(struct device *dev)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 err;
 
+	netif_enable_async_ops(netdev);
+
 	if (adapter->need_ioport)
 		err = pci_enable_device(pdev);
 	else
@@ -5195,8 +5225,11 @@ static int e1000_resume(struct device *dev)
 
 	e1000_init_manageability(adapter);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
+		rtnl_lock();
 		e1000_up(adapter);
+		rtnl_unlock();
+	}
 
 	netif_device_attach(netdev);
 
@@ -5205,6 +5238,7 @@ static int e1000_resume(struct device *dev)
 
 static void e1000_shutdown(struct pci_dev *pdev)
 {
+	struct net_device *netdev = pci_get_drvdata(pdev);
 	bool wake;
 
 	__e1000_shutdown(pdev, &wake);
@@ -5213,6 +5247,8 @@ static void e1000_shutdown(struct pci_dev *pdev)
 		pci_wake_from_d3(pdev, wake);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
+
+	netif_disable_async_ops(netdev);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -5312,11 +5348,16 @@ static void e1000_io_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
+	int rc;
 
 	e1000_init_manageability(adapter);
 
 	if (netif_running(netdev)) {
-		if (e1000_up(adapter)) {
+		rtnl_lock();
+		rc = e1000_up(adapter);
+		rtnl_unlock();
+
+		if (rc) {
 			pr_info("can't bring device back up after reset\n");
 			return;
 		}
-- 
2.47.3


