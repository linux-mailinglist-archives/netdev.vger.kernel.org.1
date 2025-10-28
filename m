Return-Path: <netdev+bounces-233607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CEEC16415
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1064A34B494
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4734F472;
	Tue, 28 Oct 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGQOBvxY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1324291E
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673381; cv=none; b=AxSNsbYLROrpwPRUasmG14NOcPWk3ptnveM2tgHiTmA1nXGefLBYB774s5ySB0RhfLwB9npa/+CF1p2XXNakEGL1A0roL5SN76SBQZcM4q4D1wJJHU+ufRS7qL4SwBjBGh16rsQTm8XNxxxRpFuDPnwfH8grXlkyVwa3l23sPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673381; c=relaxed/simple;
	bh=sMkDe6QuWZJg6QPZquqAd7/AomdUD6bzML0q+sBe7bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMrVg4WlIwWAxmDcoaAOrH0VFHhAhKgL5oHJucrMExh94ziMYGLIaOnujpgcv9JDfoswz2K+TKLv56yrbQQma8O2WXvpPwbXJEjoCMfSoDBRby63P8lM6AcCal7XQkchiu8XfbtDuR2DfJulSh8KNh5q8Xu/Rr0CjRN+1Bu9tGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGQOBvxY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a2738daea2so5369324b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673378; x=1762278178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wUcQZk4DZbR7xSABHIWAnc7HQf0QktM3XmDK4PsaFA=;
        b=FGQOBvxYvU48N98+mcTfffb/wm/ukphYceP4s35xWvXZ74ETuydF7SCiCNZLUI1/8L
         yInsej8B5MYhN0z6RYaj0D+IqsQnSo6I7Rtr4jTwZdw5P1kTFk2IAua4zM5XUHL+2AZV
         P25n2xw6ibsNoSFCMFMkfwgpVjJswnfyL9K59FHJEE/BFZDX2QYgOvhyVxkBJnkPzSIs
         s0xW3Ra3tPWj+iit/OeWRiPHY0K6POkdMuV020AV/QHIrKIethA8EF5VEgxJ2Yw6zCXV
         DLffA+8hn1ZskqwOvEdZnOOQnCJ6cMFvJOKZqd/Pmmd/8F71E3F776FYBp/EVzcFtA51
         GNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673378; x=1762278178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wUcQZk4DZbR7xSABHIWAnc7HQf0QktM3XmDK4PsaFA=;
        b=N0krZHvb/AaT1xqjDyVJzQGZIn5/AjuOkJOaRmytjjb9pPrELjmTnvaFoCDEqKiTr3
         72BswF3TV1IHWly1CyEJ6dVmhjl+Vkzjf6JmAnFrLBaneUA33Xig5M5YMgYb3Dshaz1J
         0sGOKRarj9VAlanqYvxXbInR60XKmkhb9Q0KdQzqjFBn29ju4yRNl8lthE0l3HAOVagu
         RCKde7i/nJCJ6mxr8jrPXJWLNcGLKA1vhGUOpoSUiCzJQ8BGMK7r+f496qKUECLwmWtb
         EM/71mzR3KAQyWBL3tL8mtdYC+NZLoY0LjR524wFHZ7fGOzPNIyM4shd1YvDM0AkN7GY
         UNsQ==
X-Gm-Message-State: AOJu0YwyjcahRTAOx8K5pFgGS9LCSiDjIo9IS3yafd6Y2hn+FqY3cqgl
	UVNVjatXm5+zK0FvOD1LOIsepZ8PRxg8f/woOpr/kn7swQ8P+qE1/DA9G8UscKhQ
X-Gm-Gg: ASbGncvujJotF7JK6umc58B+ldEHq7QgA7Uqc6B5Hyw1gZzTsphnENPfZKmpL6VvFg0
	5JbwPelgbYOeIMJPr6zv5PY3nLQ/hHHeaE7FNogd6QTVdhrTCUJxXApDcjOclrrssUcvcLoUhRn
	Zb7/KNqJWU3U8X4/o0qQpZJhtuYMqbz71UoM0qyTSDQTxnbobNNgh8U6GNIVXaZrpGHSorNBZS5
	2+JH49Ec/YFI4FdfF0sDMO81nU81ZtF0+XugnvibOejDYYcfaSGo4FSMNdhwV+AVNwjvOoNadIX
	aljeM1z7LLtK3fomDdFa8DNYmW0ZijH9zT7PV9DpA9dbhOTjRKnK6iL24/ZuBsEU6KTqktA+xVu
	USlX3qaCcgHltHwukGyld0gIX89GK1WKgo//VSjmXTRigkRqxIMRQHvtW9rIwQmVW0FyLIVFbF1
	3YRXPMhwitcb1fi/8nOIW8zlixkNNXRJ5ZANRsDj56OfzB1FydgHHRteM8dULAOjrW03Y=
X-Google-Smtp-Source: AGHT+IFmoA4oUM0hYelxgK8TfKfROtqNw2wglYnqCeCLNgjKiJFLlA1p5RH5+ee4oIgzehf3QEOHoQ==
X-Received: by 2002:a05:6a20:9188:b0:2fd:a3b:933d with SMTP id adf61e73a8af0-3461ecf3596mr669372637.58.1761673378402;
        Tue, 28 Oct 2025 10:42:58 -0700 (PDT)
Received: from debian.domain.name ([223.181.113.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bde68sm11086746a12.1.2025.10.28.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:42:57 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC/RFT PATCH net-next v3 2/2] net: ethernet: Implement ndo_write_rx_config callback for the 8139cp driver
Date: Tue, 28 Oct 2025 23:12:22 +0530
Message-ID: <20251028174222.1739954-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ndo_write_rx_config for the 8139cp driver

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/ethernet/realtek/8139cp.c | 78 ++++++++++++++++-----------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..ae3dca4f9b73 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -319,6 +319,11 @@ struct cp_extra_stats {
 	unsigned long		rx_frags;
 };
 
+struct cp_rx_config {
+	int rx_mode;
+	u32 mc_filter[2];	/* Multicast hash filter */
+};
+
 struct cp_private {
 	void			__iomem *regs;
 	struct net_device	*dev;
@@ -328,7 +333,7 @@ struct cp_private {
 	struct napi_struct	napi;
 
 	struct pci_dev		*pdev;
-	u32			rx_config;
+	struct cp_rx_config	*rx_config;
 	u16			cpcmd;
 
 	struct cp_extra_stats	cp_stats;
@@ -372,7 +377,6 @@ struct cp_private {
 	} while (0)
 
 
-static void __cp_set_rx_mode (struct net_device *dev);
 static void cp_tx (struct cp_private *cp);
 static void cp_clean_rings (struct cp_private *cp);
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -882,55 +886,53 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
 	goto out_unlock;
 }
 
+static void cp_write_rx_config(struct net_device *dev)
+{
+	struct cp_private *cp = netdev_priv(dev);
+	struct cp_rx_config snapshot;
+
+	read_snapshot(&snapshot, struct cp_private);
+
+	/* We can safely update without stopping the chip. */
+	cpw32_f(RxConfig, snapshot.rx_mode);
+
+	cpw32_f(MAR0 + 0, snapshot.mc_filter[0]);
+	cpw32_f(MAR0 + 4, snapshot.mc_filter[1]);
+}
+
 /* Set or clear the multicast filter for this adaptor.
    This routine is not state sensitive and need not be SMP locked. */
 
-static void __cp_set_rx_mode (struct net_device *dev)
+static void cp_set_rx_mode (struct net_device *dev)
 {
-	struct cp_private *cp = netdev_priv(dev);
-	u32 mc_filter[2];	/* Multicast hash filter */
-	int rx_mode;
+	struct cp_rx_config new_config;
 
 	/* Note: do not reorder, GCC is clever about common statements. */
 	if (dev->flags & IFF_PROMISC) {
 		/* Unconditionally log net taps. */
-		rx_mode =
+		new_config.rx_mode =
 		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
 		    AcceptAllPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0xffffffff;
 	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
 		   (dev->flags & IFF_ALLMULTI)) {
 		/* Too many to filter perfectly -- accept all multicasts. */
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		new_config.rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0xffffffff;
 	} else {
 		struct netdev_hw_addr *ha;
-		rx_mode = AcceptBroadcast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0;
+		new_config.rx_mode = AcceptBroadcast | AcceptMyPhys;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0;
 		netdev_for_each_mc_addr(ha, dev) {
 			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
 
-			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
-			rx_mode |= AcceptMulticast;
+			new_config.mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
+			new_config.rx_mode |= AcceptMulticast;
 		}
 	}
 
-	/* We can safely update without stopping the chip. */
-	cp->rx_config = cp_rx_config | rx_mode;
-	cpw32_f(RxConfig, cp->rx_config);
-
-	cpw32_f (MAR0 + 0, mc_filter[0]);
-	cpw32_f (MAR0 + 4, mc_filter[1]);
-}
-
-static void cp_set_rx_mode (struct net_device *dev)
-{
-	unsigned long flags;
-	struct cp_private *cp = netdev_priv(dev);
-
-	spin_lock_irqsave (&cp->lock, flags);
-	__cp_set_rx_mode(dev);
-	spin_unlock_irqrestore (&cp->lock, flags);
+	new_config.rx_mode = cp_rx_config | new_config.rx_mode;
+	update_snapshot(&new_config, struct cp_private);
 }
 
 static void __cp_get_stats(struct cp_private *cp)
@@ -1040,7 +1042,7 @@ static void cp_init_hw (struct cp_private *cp)
 	cp_start_hw(cp);
 	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
 
-	__cp_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, true);
 	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
@@ -1188,6 +1190,12 @@ static int cp_open (struct net_device *dev)
 	if (rc)
 		return rc;
 
+	cp->rx_config = kmalloc(sizeof(*cp->rx_config), GFP_KERNEL);
+	if (!cp->rx_config) {
+		rc = -ENOMEM;
+		goto err_out_rx_config;
+	}
+
 	napi_enable(&cp->napi);
 
 	cp_init_hw(cp);
@@ -1207,6 +1215,9 @@ static int cp_open (struct net_device *dev)
 err_out_hw:
 	napi_disable(&cp->napi);
 	cp_stop_hw(cp);
+	kfree(cp->rx_config);
+
+err_out_rx_config:
 	cp_free_rings(cp);
 	return rc;
 }
@@ -1227,6 +1238,8 @@ static int cp_close (struct net_device *dev)
 
 	cp_stop_hw(cp);
 
+	kfree(cp->rx_config);
+
 	spin_unlock_irqrestore(&cp->lock, flags);
 
 	free_irq(cp->pdev->irq, dev);
@@ -1262,7 +1275,7 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	cp_clean_rings(cp);
 	cp_init_rings(cp);
 	cp_start_hw(cp);
-	__cp_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, false);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
 
 	netif_wake_queue(dev);
@@ -1870,6 +1883,7 @@ static const struct net_device_ops cp_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address 	= cp_set_mac_address,
 	.ndo_set_rx_mode	= cp_set_rx_mode,
+	.ndo_write_rx_config    = cp_write_rx_config,
 	.ndo_get_stats		= cp_get_stats,
 	.ndo_eth_ioctl		= cp_ioctl,
 	.ndo_start_xmit		= cp_start_xmit,
-- 
2.34.1


