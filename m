Return-Path: <netdev+bounces-267825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFXNBoWptWmw3AAAu9opvQ
	(envelope-from <netdev+bounces-267825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:31:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A694228E799
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E939303B97B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9452E3368B5;
	Sat, 14 Mar 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anuh+vZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC922B8B6
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512980; cv=none; b=KhHzBpkFVp0wAcHdyb/BKx/0jnptTrod2ALxXqclBH0ZXkYSEPvxSx3/eVsUKrxO41gG399vUI5hXfrkErY7fHpF8VTOWzKHulwzZxC3bYxHOZ+J4Di9woog4dr11mCeDA+wna9lzhZR0RnERp9JMeeJPJBWKh85wMRozzjF30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512980; c=relaxed/simple;
	bh=U3vvmkXelI8LTz8QU0K42inS4TOguEVJt/CLkeFByIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0KZQJLSylCFsrmnPkZvUh2H/+gKTDF0Gms7ZFfvb33l+pWaIWDU0JFNuNHicTDUtTu14XFjQ4LicjGqlXljRkBMlTSd2e0P54g+AvYhwCKdT0AQL2296lhjW5x2zk/LFXk0Uvn5u8Gm1MoVBnb7wzd5IeQJ4JFsTI+8mjj1jGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anuh+vZ5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1377381a12.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512979; x=1774117779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uJuhFREF46e+3OIYgkRDThTE1W9t/zG8t/Q5Vop1iU=;
        b=anuh+vZ5uzPU1sQInuK1t48Un7PhYhCzvpHWZj9A2u50KnpzOg00hwXaj15+EB5OiS
         OCKeXixRh1k7lgkliojup1kFRiFd3lkMXLgJIzip/mrV404pHctA3fbngJeBvteyWNIn
         zhLAAkbBDAgBJJQZtNJC816mwZwA7WUpHYY7BusUsx63tlXJBxACLY1B+A4JiVeSZsZo
         5DN6W6VMGdCAge4Pv4js+6oaVqUfgUkPf7PtbRj5T1cK7/hGEPqD+uSjXrlzS4hwl78g
         qySxAG3nAQW2bAB+mf0pqDP3nwyfKQMb4kdiFQWxoQaqjsmV61GnFpP15sBQHemNd1Sb
         k96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512979; x=1774117779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uJuhFREF46e+3OIYgkRDThTE1W9t/zG8t/Q5Vop1iU=;
        b=CIOd5ZI0+KxtvGZGDVWbpulh6I7gVrti7QduLsjtVqQOj698lptn5K+z5fhFfB5Al8
         zSBI9Mni4TksaTzC5ge+6kOGIWEfyV57VdTKBq32K3fSTI2W1i/riAqOQCLKCAAzq8xo
         vf7Jg5Sv8t6C/mnsN/wGhBSnPINHzLHE4npaRTMoQonmcPN2d1V2K3i/ksG7fg8q/YRU
         X51DpJUNOIwqk2rPnRfcdhByG4+PYTNGLfoCdA7nMs6ZMj0tPfN3naYxrVDAHqBXxU+X
         sM36PfNaADOmh0uQgd2A+NWY4RQWREwxp3w5w59HxJ1e9vXokKRj7euD9LLnnYBkoEQR
         0DZw==
X-Forwarded-Encrypted: i=1; AJvYcCWEF9FOskeGzmvfFytfxWctDEh/Q+VPTzrS1fctTb124zHd4U59RA1TFWEmi3pYANP84gseqHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVRNEkksR1GyXv8OoRj1DHqcTWCnQFR0z5rQCdpFmTw7xbuVf
	qCR/JbPhqIus8WjllaqdSeDs5wrO0+MQg21ZSG7tG+/WEADijIDW2EGq
X-Gm-Gg: ATEYQzwntGeAOk5SelHaHWH9cmVF+LG7QWKz0TQJBDZvt7cTPk1Lh0zvIZrkB8ECHeq
	aQ31ksAKlWWOw+txyR6wGHLidDqwQVXW5wQk96VfpjvI7LJvd8LYn5DypLsXX0M0JEdZESQWi8v
	FJLw+8jtHxWl7KYIUCjK5zZPD4ErWYLKCR1rZ4SEzlEsedbqta5XvIm7UodRIFGDizrZvXso7Tn
	8lpeRPRi511g1+vBNVaF9+O1IIhwkOmUgAgTUtJJeMReUJtfAx1oQjXsQJmCnCvlNV9zhtDreHy
	qEuS5l1YdB3e8Fr1P8dxr0Oa2Zeq4uhdE7S+ndG056BtlLxZKRk5hwySOIBjRKyBMPJbv5gMUlg
	CQjkEzJqWwEmBa906VixHf4QLmUSPlCHCpnegtdSHAorePT9WhfWGTCyuWxa/orfFbCqbMHp5xf
	TYJQ8f1ZUaPRDUobY2E3i2iQSdNHgPUZCiZms9cTrzvhRPeOfucC8EQ66lzarMO2r+8wFIH98bN
	etdgA==
X-Received: by 2002:a17:902:f70a:b0:2ae:5044:8dd4 with SMTP id d9443c01a7336-2aeca960929mr72806085ad.19.1773512978654;
        Sat, 14 Mar 2026 11:29:38 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:38 -0700 (PDT)
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
Subject: [PATCH net-next v9 6/7] vmxnet3: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:08 +0530
Message-ID: <20260314182809.362808-7-viswanathiyyappan@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267825-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A694228E799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_set_rx_mode_async callback and update
the driver to use the snapshot/commit model for RX mode update.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 
Call paths involving netif_set_rx_mode in vmxnet3

netif_set_rx_mode
`-- vmxnet3_activate_dev
    |-- vmxnet3_open (ndo_open, takes lock)
    |-- vmxnet3_change_mtu (ndo_change_mtu, takes lock)
    |-- vmxnet3_reset_work (takes lock)
    |-- vmxnet3_resume (lock added)
    |-- vmxnet3_set_ringparam (ethtool callback, takes lock)
    `-- vmxnet3_xdp_set
        `-- vmxnet3_xdp (ndo_bpf, takes lock)

 drivers/net/vmxnet3/vmxnet3_drv.c | 46 +++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 40522afc0532..350e44286c00 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2775,18 +2775,18 @@ static u8 *
 vmxnet3_copy_mc(struct net_device *netdev)
 {
 	u8 *buf = NULL;
-	u32 sz = netdev_mc_count(netdev) * ETH_ALEN;
+	u32 sz = netif_rx_mode_mc_count(netdev) * ETH_ALEN;
+	char *ha_addr;
+	int ni;
 
 	/* struct Vmxnet3_RxFilterConf.mfTableLen is u16. */
 	if (sz <= 0xffff) {
 		/* We may be called with BH disabled */
 		buf = kmalloc(sz, GFP_ATOMIC);
 		if (buf) {
-			struct netdev_hw_addr *ha;
 			int i = 0;
-
-			netdev_for_each_mc_addr(ha, netdev)
-				memcpy(buf + i++ * ETH_ALEN, ha->addr,
+			netif_rx_mode_for_each_mc_addr(ha_addr, netdev, ni)
+				memcpy(buf + i++ * ETH_ALEN, ha_addr,
 				       ETH_ALEN);
 		}
 	}
@@ -2796,8 +2796,23 @@ vmxnet3_copy_mc(struct net_device *netdev)
 
 static void
 vmxnet3_set_mc(struct net_device *netdev)
+{
+	bool allmulti = !!(netdev->flags & IFF_ALLMULTI);
+	bool promisc = !!(netdev->flags & IFF_PROMISC);
+	bool broadcast = !!(netdev->flags & IFF_BROADCAST);
+
+	netif_set_rx_mode_flag(netdev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_set_rx_mode_flag(netdev, NETIF_RX_MODE_MC_SKIP, allmulti);
+
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+	netif_set_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST, broadcast);
+}
+
+static void vmxnet3_set_mc_async(struct net_device *netdev)
 {
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
+	int mc_count = netif_rx_mode_mc_count(netdev);
 	unsigned long flags;
 	struct Vmxnet3_RxFilterConf *rxConf =
 					&adapter->shared->devRead.rxFilterConf;
@@ -2806,7 +2821,7 @@ vmxnet3_set_mc(struct net_device *netdev)
 	bool new_table_pa_valid = false;
 	u32 new_mode = VMXNET3_RXM_UCAST;
 
-	if (netdev->flags & IFF_PROMISC) {
+	if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		u32 *vfTable = adapter->shared->devRead.rxFilterConf.vfTable;
 		memset(vfTable, 0, VMXNET3_VFT_SIZE * sizeof(*vfTable));
 
@@ -2815,16 +2830,16 @@ vmxnet3_set_mc(struct net_device *netdev)
 		vmxnet3_restore_vlan(adapter);
 	}
 
-	if (netdev->flags & IFF_BROADCAST)
+	if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST))
 		new_mode |= VMXNET3_RXM_BCAST;
 
-	if (netdev->flags & IFF_ALLMULTI)
+	if (netif_get_rx_mode_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI))
 		new_mode |= VMXNET3_RXM_ALL_MULTI;
 	else
-		if (!netdev_mc_empty(netdev)) {
+		if (mc_count) {
 			new_table = vmxnet3_copy_mc(netdev);
 			if (new_table) {
-				size_t sz = netdev_mc_count(netdev) * ETH_ALEN;
+				size_t sz = mc_count * ETH_ALEN;
 
 				rxConf->mfTableLen = cpu_to_le16(sz);
 				new_table_pa = dma_map_single(
@@ -3213,7 +3228,7 @@ vmxnet3_activate_dev(struct vmxnet3_adapter *adapter)
 	}
 
 	/* Apply the rx filter settins last. */
-	vmxnet3_set_mc(adapter->netdev);
+	netif_set_rx_mode(adapter->netdev);
 
 	/*
 	 * Check link state when first activating device. It will start the
@@ -3977,6 +3992,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 		.ndo_get_stats64 = vmxnet3_get_stats64,
 		.ndo_tx_timeout = vmxnet3_tx_timeout,
 		.ndo_set_rx_mode = vmxnet3_set_mc,
+		.ndo_set_rx_mode_async = vmxnet3_set_mc_async,
 		.ndo_vlan_rx_add_vid = vmxnet3_vlan_rx_add_vid,
 		.ndo_vlan_rx_kill_vid = vmxnet3_vlan_rx_kill_vid,
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -4400,6 +4416,7 @@ static void vmxnet3_shutdown_device(struct pci_dev *pdev)
 	vmxnet3_disable_all_intrs(adapter);
 
 	clear_bit(VMXNET3_STATE_BIT_RESETTING, &adapter->state);
+	netif_disable_async_ops(netdev);
 }
 
 
@@ -4518,6 +4535,7 @@ vmxnet3_suspend(struct device *device)
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, pci_choose_state(pdev, PMSG_SUSPEND));
 
+	netif_disable_async_ops(netdev);
 	return 0;
 }
 
@@ -4531,6 +4549,8 @@ vmxnet3_resume(struct device *device)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 
+	netif_enable_async_ops(netdev);
+
 	if (!netif_running(netdev))
 		return 0;
 
@@ -4559,7 +4579,11 @@ vmxnet3_resume(struct device *device)
 	vmxnet3_rq_cleanup_all(adapter);
 
 	vmxnet3_reset_dev(adapter);
+
+	rtnl_lock();
 	err = vmxnet3_activate_dev(adapter);
+	rtnl_unlock();
+
 	if (err != 0) {
 		netdev_err(netdev,
 			   "failed to re-activate on resume, error: %d", err);
-- 
2.47.3


