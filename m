Return-Path: <netdev+bounces-108538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B29241B8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56A71C22314
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539601BA898;
	Tue,  2 Jul 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii8cYx13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2301BA892
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932440; cv=none; b=c7w0OobwQv5boXp5uU9l3YROexa7FlUSRSmmNUmnqeeU6PpACKbB/5Q5om6PM3EmfpgjHZ8Fu4W+o8YlDXiAG4z02dlcwh4Z9FJv3aUQqrE+Ddphfj0FZoVribR2PylK2z0spX3InT/qX83UTptLnxGK90uCSOGS9MgAAlTtMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932440; c=relaxed/simple;
	bh=w6tHHv3VSa8XE+YPevaL+lJiXkj+zYZTFzsUydUzz/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ih3CSV79KokSfRVDcslrgVXi9dIJyzJOmIPwSoRmae0C1GFQHcnIu+CBfqAR4oIpAqpY8vh03XiNtVX3KTBKakcPPK4sXzBsNqRYRcMwpXOgg1vD5qLL3Ec8gOZOWLkojgEKqBqZNXtCE9xg3R9AaI/UwvKftrbL5CGMqlHzZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii8cYx13; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2420184a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932437; x=1720537237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Dkj6gvjie2qEf8fXsos4UY5XhoBMQAkshlKR0jOH7w=;
        b=ii8cYx13misrOYAieK7xR18uUUoXLqopm2+JlTBUstmolW20brbsutP391xqvY4lwm
         5sSWcSGVUZnA8Hw0jf3g17YsF15VJjTZZAKa8yUDH1+UFgSNLLmdn3I9Wo/nu/n4lScT
         aqwUIQ6q8coTwhb3mIoLcttpLTBCCA2Sx3g6SyUTLXVHOy+jRYk/2uZwgQ3z8OswUmhX
         NvLBeTIn0Y9ksY5q3xyHHPWsTgm6EPlRUB/0JhXyeGbzOgMoUwm03ZRt8sDOL3cPfr12
         qxf2nQKi9yenXHN7kiPevfbe2rwk8F0EtMMrlmNfhpHSzR0otuN6Pb7Sd5Aom1vam+IH
         ffgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932437; x=1720537237;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Dkj6gvjie2qEf8fXsos4UY5XhoBMQAkshlKR0jOH7w=;
        b=AkcniMQgmLbLX9HedQvW5RYiOmnLhpbgZOvj00dC3oN/wSdcupnaC4YZNY7GXgXHBV
         0BppkeTeS8FoKFSBa17S9R9gPhd+mHpZR28bXstdIUTdXOH/Z/dNzyvq0u4Z3QFiYMv+
         f9LKwHzVKKb1j/fwDILHgviH/z2UDW6hYwN0OghXhp96U3whalJpjhLkS5q++mdhQPyh
         fjv9yO5596Fm3BEnQUfMiqrf5HhjXQ6nXYRg7aZGoH7wkhebm0tuPMRDPnwgBUAtmpTn
         OqqyWRl5WZXUM1+Msdkn9J/ZzDpejokkT+2mEpLDbmycfrxwKHnmnMDhGSd1lhkBK6jO
         GVfg==
X-Gm-Message-State: AOJu0YxtsELCoP9s7K8ru3M2HvhFm0PWscLS12scx8gXKlzD+Xp/sgk+
	FSsN/nnUBUDthX62FN+UQs1MEV+Cb8+ykoPuadQ4piv+UFYb9kaA
X-Google-Smtp-Source: AGHT+IGpKdZRP3Y55xyB24REMGBiiwDCZJ0IIH85Y5Ph3vVo+knNdc4B+Ntyi2jLQ29XPrZpjagbFQ==
X-Received: by 2002:a05:6a21:3a4b:b0:1be:c3dd:642a with SMTP id adf61e73a8af0-1bef6198cd7mr7686134637.37.1719932435790;
        Tue, 02 Jul 2024 08:00:35 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599cf1sm85420505ad.251.2024.07.02.08.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:00:35 -0700 (PDT)
Subject: [net-next PATCH v3 14/15] eth: fbnic: Add L2 address programming
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kernel-team@meta.com
Date: Tue, 02 Jul 2024 08:00:34 -0700
Message-ID: 
 <171993243434.3697648.5040079628098713465.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Program the Rx TCAM to control L2 forwarding. Since we are in full
control of the NIC we need to make sure we include BMC forwarding
in the rules. When host is not present BMC will program the TCAM
to get onto the network but once we take ownership it's up to
Linux driver to make sure BMC L2 addresses are handled correctly.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile        |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h         |   15 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |   14 +
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |  230 ++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c     |  338 +++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h     |  139 +++++++++
 9 files changed, 745 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index a487ac5c4ec5..9373b558fdc9 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -14,5 +14,6 @@ fbnic-y := fbnic_devlink.o \
 	   fbnic_netdev.o \
 	   fbnic_pci.o \
 	   fbnic_phylink.o \
+	   fbnic_rpc.o \
 	   fbnic_tlv.o \
 	   fbnic_txrx.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index b4d7013b3f05..85b550da9296 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -12,6 +12,7 @@
 #include "fbnic_csr.h"
 #include "fbnic_fw.h"
 #include "fbnic_mac.h"
+#include "fbnic_rpc.h"
 
 struct fbnic_dev {
 	struct device *dev;
@@ -39,6 +40,10 @@ struct fbnic_dev {
 	u32 mps;
 	u32 readrq;
 
+	/* Local copy of the devices TCAM */
+	struct fbnic_mac_addr mac_addr[FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES];
+	u8 mac_addr_boundary;
+
 	/* Tri-state value indicating state of link.
 	 *  0 - Up
 	 *  1 - Down
@@ -104,6 +109,16 @@ void fbnic_fw_wr32(struct fbnic_dev *fbd, u32 reg, u32 val);
 #define fw_wr32(_f, _r, _v)	fbnic_fw_wr32(_f, _r, _v)
 #define fw_wrfl(_f)		fbnic_fw_rd32(_f, FBNIC_FW_ZERO_REG)
 
+static inline bool fbnic_bmc_present(struct fbnic_dev *fbd)
+{
+	return fbd->fw_cap.bmc_present;
+}
+
+static inline void fbnic_bmc_set_present(struct fbnic_dev *fbd, bool present)
+{
+	fbd->fw_cap.bmc_present = present;
+}
+
 static inline bool fbnic_init_failure(struct fbnic_dev *fbd)
 {
 	return !fbd->netdev;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 405c294af0df..50259c60bf65 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -537,8 +537,22 @@ enum {
 #define FBNIC_RPC_RMI_CONFIG_FCS_PRESENT	CSR_BIT(8)
 #define FBNIC_RPC_RMI_CONFIG_ENABLE		CSR_BIT(12)
 #define FBNIC_RPC_RMI_CONFIG_MTU		CSR_GENMASK(31, 16)
+#define FBNIC_RPC_TCAM_MACDA_VALIDATE	0x0852d		/* 0x214b4 */
 #define FBNIC_CSR_END_RPC		0x0856b	/* CSR section delimiter */
 
+/* RPC RAM Registers */
+
+#define FBNIC_CSR_START_RPC_RAM		0x08800	/* CSR section delimiter */
+#define FBNIC_RPC_ACT_TBL_NUM_ENTRIES		64
+
+/* TCAM Tables */
+#define FBNIC_RPC_TCAM_VALIDATE			CSR_BIT(31)
+#define FBNIC_RPC_TCAM_MACDA(m, n) \
+	(0x08b80 + 0x20 * (n) + (m))		/* 0x022e00 + 128*n + 4*m */
+#define FBNIC_RPC_TCAM_MACDA_VALUE		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_MACDA_MASK		CSR_GENMASK(31, 16)
+#define FBNIC_CSR_END_RPC_RAM		0x08f1f	/* CSR section delimiter */
+
 /* Fab Registers */
 #define FBNIC_CSR_START_FAB		0x0C000 /* CSR section delimiter */
 #define FBNIC_FAB_AXI4_AR_SPACER_2_CFG		0x0C005		/* 0x30014 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 1441610f5843..e87049dfd223 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -68,6 +68,8 @@ struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev)
 	fbd->mps = pcie_get_mps(pdev);
 	fbd->readrq = pcie_get_readrq(pdev);
 
+	fbd->mac_addr_boundary = FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY;
+
 	return fbd;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 0eac82b17c0f..6e06554cf5a7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -48,6 +48,8 @@ int __fbnic_open(struct fbnic_net *fbn)
 	err = fbnic_mac_enable(fbd);
 	if (err)
 		goto release_ownership;
+	/* Pull the BMC config and initialize the RPC */
+	fbnic_bmc_rpc_init(fbd);
 
 	return 0;
 release_ownership:
@@ -86,12 +88,240 @@ static int fbnic_stop(struct net_device *netdev)
 	return 0;
 }
 
+static int fbnic_uc_sync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_mac_addr *avail_addr;
+
+	if (WARN_ON(!is_valid_ether_addr(addr)))
+		return -EADDRNOTAVAIL;
+
+	avail_addr = __fbnic_uc_sync(fbn->fbd, addr);
+	if (!avail_addr)
+		return -ENOSPC;
+
+	/* Add type flag indicating this address is in use by the host */
+	set_bit(FBNIC_MAC_ADDR_T_UNICAST, avail_addr->act_tcam);
+
+	return 0;
+}
+
+static int fbnic_uc_unsync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+	int i, ret;
+
+	/* Scan from middle of list to bottom, filling bottom up.
+	 * Skip the first entry which is reserved for dev_addr and
+	 * leave the last entry to use for promiscuous filtering.
+	 */
+	for (i = fbd->mac_addr_boundary, ret = -ENOENT;
+	     i < FBNIC_RPC_TCAM_MACDA_HOST_ADDR_IDX && ret; i++) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		if (!ether_addr_equal(mac_addr->value.addr8, addr))
+			continue;
+
+		ret = __fbnic_uc_unsync(mac_addr);
+	}
+
+	return ret;
+}
+
+static int fbnic_mc_sync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_mac_addr *avail_addr;
+
+	if (WARN_ON(!is_multicast_ether_addr(addr)))
+		return -EADDRNOTAVAIL;
+
+	avail_addr = __fbnic_mc_sync(fbn->fbd, addr);
+	if (!avail_addr)
+		return -ENOSPC;
+
+	/* Add type flag indicating this address is in use by the host */
+	set_bit(FBNIC_MAC_ADDR_T_MULTICAST, avail_addr->act_tcam);
+
+	return 0;
+}
+
+static int fbnic_mc_unsync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+	int i, ret;
+
+	/* Scan from middle of list to top, filling top down.
+	 * Skip over the address reserved for the BMC MAC and
+	 * exclude index 0 as that belongs to the broadcast address
+	 */
+	for (i = fbd->mac_addr_boundary, ret = -ENOENT;
+	     --i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX && ret;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		if (!ether_addr_equal(mac_addr->value.addr8, addr))
+			continue;
+
+		ret = __fbnic_mc_unsync(mac_addr);
+	}
+
+	return ret;
+}
+
+void __fbnic_set_rx_mode(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	bool uc_promisc = false, mc_promisc = false;
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_mac_addr *mac_addr;
+	int err;
+
+	/* Populate host address from dev_addr */
+	mac_addr = &fbd->mac_addr[FBNIC_RPC_TCAM_MACDA_HOST_ADDR_IDX];
+	if (!ether_addr_equal(mac_addr->value.addr8, netdev->dev_addr) ||
+	    mac_addr->state != FBNIC_TCAM_S_VALID) {
+		ether_addr_copy(mac_addr->value.addr8, netdev->dev_addr);
+		mac_addr->state = FBNIC_TCAM_S_UPDATE;
+		set_bit(FBNIC_MAC_ADDR_T_UNICAST, mac_addr->act_tcam);
+	}
+
+	/* Populate broadcast address if broadcast is enabled */
+	mac_addr = &fbd->mac_addr[FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX];
+	if (netdev->flags & IFF_BROADCAST) {
+		if (!is_broadcast_ether_addr(mac_addr->value.addr8) ||
+		    mac_addr->state != FBNIC_TCAM_S_VALID) {
+			eth_broadcast_addr(mac_addr->value.addr8);
+			mac_addr->state = FBNIC_TCAM_S_ADD;
+		}
+		set_bit(FBNIC_MAC_ADDR_T_BROADCAST, mac_addr->act_tcam);
+	} else if (mac_addr->state == FBNIC_TCAM_S_VALID) {
+		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_BROADCAST);
+	}
+
+	/* Synchronize unicast and multicast address lists */
+	err = __dev_uc_sync(netdev, fbnic_uc_sync, fbnic_uc_unsync);
+	if (err == -ENOSPC)
+		uc_promisc = true;
+	err = __dev_mc_sync(netdev, fbnic_mc_sync, fbnic_mc_unsync);
+	if (err == -ENOSPC)
+		mc_promisc = true;
+
+	uc_promisc |= !!(netdev->flags & IFF_PROMISC);
+	mc_promisc |= !!(netdev->flags & IFF_ALLMULTI) || uc_promisc;
+
+	/* Populate last TCAM entry with promiscuous entry and 0/1 bit mask */
+	mac_addr = &fbd->mac_addr[FBNIC_RPC_TCAM_MACDA_PROMISC_IDX];
+	if (uc_promisc) {
+		if (!is_zero_ether_addr(mac_addr->value.addr8) ||
+		    mac_addr->state != FBNIC_TCAM_S_VALID) {
+			eth_zero_addr(mac_addr->value.addr8);
+			eth_broadcast_addr(mac_addr->mask.addr8);
+			clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
+				  mac_addr->act_tcam);
+			set_bit(FBNIC_MAC_ADDR_T_PROMISC,
+				mac_addr->act_tcam);
+			mac_addr->state = FBNIC_TCAM_S_ADD;
+		}
+	} else if (mc_promisc &&
+		   (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi)) {
+		/* We have to add a special handler for multicast as the
+		 * BMC may have an all-multi rule already in place. As such
+		 * adding a rule ourselves won't do any good so we will have
+		 * to modify the rules for the ALL MULTI below if the BMC
+		 * already has the rule in place.
+		 */
+		if (!is_multicast_ether_addr(mac_addr->value.addr8) ||
+		    mac_addr->state != FBNIC_TCAM_S_VALID) {
+			eth_zero_addr(mac_addr->value.addr8);
+			eth_broadcast_addr(mac_addr->mask.addr8);
+			mac_addr->value.addr8[0] ^= 1;
+			mac_addr->mask.addr8[0] ^= 1;
+			set_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
+				mac_addr->act_tcam);
+			clear_bit(FBNIC_MAC_ADDR_T_PROMISC,
+				  mac_addr->act_tcam);
+			mac_addr->state = FBNIC_TCAM_S_ADD;
+		}
+	} else if (mac_addr->state == FBNIC_TCAM_S_VALID) {
+		if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam)) {
+			clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
+				  mac_addr->act_tcam);
+			clear_bit(FBNIC_MAC_ADDR_T_PROMISC,
+				  mac_addr->act_tcam);
+		} else {
+			mac_addr->state = FBNIC_TCAM_S_DELETE;
+		}
+	}
+
+	/* Add rules for BMC all multicast if it is enabled */
+	fbnic_bmc_rpc_all_multi_config(fbd, mc_promisc);
+
+	/* Sift out any unshared BMC rules and place them in BMC only section */
+	fbnic_sift_macda(fbd);
+
+	/* Write updates to hardware */
+	fbnic_write_macda(fbd);
+}
+
+static void fbnic_set_rx_mode(struct net_device *netdev)
+{
+	/* No need to update the hardware if we are not running */
+	if (netif_running(netdev))
+		__fbnic_set_rx_mode(netdev);
+}
+
+static int fbnic_set_mac(struct net_device *netdev, void *p)
+{
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(netdev, addr->sa_data);
+
+	fbnic_set_rx_mode(netdev);
+
+	return 0;
+}
+
+void fbnic_clear_rx_mode(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state != FBNIC_TCAM_S_VALID)
+			continue;
+
+		bitmap_clear(mac_addr->act_tcam,
+			     FBNIC_MAC_ADDR_T_HOST_START,
+			     FBNIC_MAC_ADDR_T_HOST_LEN);
+
+		if (bitmap_empty(mac_addr->act_tcam,
+				 FBNIC_RPC_TCAM_ACT_NUM_ENTRIES))
+			mac_addr->state = FBNIC_TCAM_S_DELETE;
+	}
+
+	/* Write updates to hardware */
+	fbnic_write_macda(fbd);
+
+	__dev_uc_unsync(netdev, NULL);
+	__dev_mc_unsync(netdev, NULL);
+}
+
 static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_open		= fbnic_open,
 	.ndo_stop		= fbnic_stop,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_start_xmit		= fbnic_xmit_frame,
 	.ndo_features_check	= fbnic_features_check,
+	.ndo_set_mac_address	= fbnic_set_mac,
+	.ndo_set_rx_mode	= fbnic_set_rx_mode,
 };
 
 void fbnic_reset_queues(struct fbnic_net *fbn,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 51287f1a149a..e754cc23f029 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -50,5 +50,8 @@ void fbnic_netdev_unregister(struct net_device *netdev);
 void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx);
 
+void __fbnic_set_rx_mode(struct net_device *netdev);
+void fbnic_clear_rx_mode(struct net_device *netdev);
+
 int fbnic_phylink_init(struct net_device *netdev);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 6942b606c706..83e00e986b80 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -133,6 +133,8 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	fbnic_fill(fbn);
 
+	__fbnic_set_rx_mode(fbn->netdev);
+
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
 	netif_tx_start_all_queues(fbn->netdev);
@@ -148,6 +150,7 @@ static void fbnic_down_noidle(struct fbnic_net *fbn)
 	fbnic_napi_disable(fbn);
 	netif_tx_disable(fbn->netdev);
 
+	fbnic_clear_rx_mode(fbn->netdev);
 	fbnic_disable(fbn);
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
new file mode 100644
index 000000000000..d77a22a6e1f7
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/etherdevice.h>
+
+#include "fbnic.h"
+#include "fbnic_netdev.h"
+#include "fbnic_rpc.h"
+
+static int fbnic_read_macda_entry(struct fbnic_dev *fbd, unsigned int idx,
+				  struct fbnic_mac_addr *mac_addr)
+{
+	__be16 *mask, *value;
+	int i;
+
+	mask = &mac_addr->mask.addr16[FBNIC_RPC_TCAM_MACDA_WORD_LEN - 1];
+	value = &mac_addr->value.addr16[FBNIC_RPC_TCAM_MACDA_WORD_LEN - 1];
+
+	for (i = 0; i < FBNIC_RPC_TCAM_MACDA_WORD_LEN; i++) {
+		u32 macda = rd32(fbd, FBNIC_RPC_TCAM_MACDA(idx, i));
+
+		*mask-- = htons(FIELD_GET(FBNIC_RPC_TCAM_MACDA_MASK, macda));
+		*value-- = htons(FIELD_GET(FBNIC_RPC_TCAM_MACDA_VALUE, macda));
+	}
+
+	return (rd32(fbd, FBNIC_RPC_TCAM_MACDA(idx, i)) &
+		FBNIC_RPC_TCAM_VALIDATE) ? 0 : -EINVAL;
+}
+
+void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
+				    bool enable_host)
+{
+	struct fbnic_mac_addr *mac_addr;
+
+	/* We need to add the all multicast filter at the end of the
+	 * multicast address list. This way if there are any that are
+	 * shared between the host and the BMC they can be directed to
+	 * both. Otherwise the remainder just get sent directly to the
+	 * BMC.
+	 */
+	mac_addr = &fbd->mac_addr[fbd->mac_addr_boundary - 1];
+	if (fbnic_bmc_present(fbd) && fbd->fw_cap.all_multi) {
+		if (mac_addr->state != FBNIC_TCAM_S_VALID) {
+			eth_zero_addr(mac_addr->value.addr8);
+			eth_broadcast_addr(mac_addr->mask.addr8);
+			mac_addr->value.addr8[0] ^= 1;
+			mac_addr->mask.addr8[0] ^= 1;
+			set_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
+			mac_addr->state = FBNIC_TCAM_S_ADD;
+		}
+		if (enable_host)
+			set_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
+				mac_addr->act_tcam);
+		else
+			clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
+				  mac_addr->act_tcam);
+	} else if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam) &&
+		   !is_zero_ether_addr(mac_addr->mask.addr8) &&
+		   mac_addr->state == FBNIC_TCAM_S_VALID) {
+		clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI, mac_addr->act_tcam);
+		clear_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
+		mac_addr->state = FBNIC_TCAM_S_DELETE;
+	}
+}
+
+void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
+{
+	int i = FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX;
+	struct fbnic_mac_addr *mac_addr;
+	u32 macda_validate;
+
+	/* Verify that RPC is already enabled, if not abort */
+	macda_validate = rd32(fbd, FBNIC_RPC_TCAM_MACDA_VALIDATE);
+	if (!(macda_validate & (1u << i)))
+		return;
+
+	/* Read BMC MACDA entry and validate it */
+	mac_addr = &fbd->mac_addr[i];
+	if (fbnic_read_macda_entry(fbd, i, mac_addr))
+		return;
+
+	/* If BMC MAC addr is valid then record it and flag it as valid */
+	if (!is_valid_ether_addr(mac_addr->value.addr8))
+		return;
+
+	set_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
+	mac_addr->state = FBNIC_TCAM_S_VALID;
+
+	/* Record the BMC Multicast addresses */
+	for (i++; i < FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX; i++) {
+		if (!(macda_validate & (1u << i)))
+			continue;
+
+		mac_addr = &fbd->mac_addr[i];
+		if (fbnic_read_macda_entry(fbd, i, mac_addr))
+			continue;
+
+		if (is_broadcast_ether_addr(mac_addr->value.addr8)) {
+			mac_addr->state = FBNIC_TCAM_S_DELETE;
+			continue;
+		}
+
+		if (!is_multicast_ether_addr(mac_addr->value.addr8))
+			continue;
+
+		set_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
+		mac_addr->state = FBNIC_TCAM_S_VALID;
+	}
+
+	/* Validate Broadcast is also present, record it and tag it */
+	if (macda_validate & (1u << i)) {
+		mac_addr = &fbd->mac_addr[i];
+		eth_broadcast_addr(mac_addr->value.addr8);
+		set_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
+		mac_addr->state = FBNIC_TCAM_S_ADD;
+	}
+
+	/* Record the shared BMC Multicast addresses */
+	for (i++; i <= FBNIC_RPC_TCAM_MACDA_PROMISC_IDX; i++) {
+		if (!(macda_validate & (1u << i)))
+			continue;
+
+		mac_addr = &fbd->mac_addr[i];
+		if (fbnic_read_macda_entry(fbd, i, mac_addr))
+			continue;
+
+		if (!is_multicast_ether_addr(mac_addr->value.addr8))
+			continue;
+
+		/* It isn't an exact match filter it must be an all-multi */
+		if (!is_zero_ether_addr(mac_addr->mask.addr8)) {
+			fbd->fw_cap.all_multi = 1;
+
+			/* If it isn't in the correct spot don't record it */
+			if (i != fbd->mac_addr_boundary - 1)
+				continue;
+		}
+
+		set_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
+		mac_addr->state = FBNIC_TCAM_S_VALID;
+	}
+
+	fbnic_bmc_rpc_all_multi_config(fbd, false);
+
+	fbnic_bmc_set_present(fbd, true);
+}
+
+struct fbnic_mac_addr *__fbnic_uc_sync(struct fbnic_dev *fbd,
+				       const unsigned char *addr)
+{
+	struct fbnic_mac_addr *avail_addr = NULL;
+	unsigned int i;
+
+	/* Scan from middle of list to bottom, filling bottom up.
+	 * Skip the first entry which is reserved for dev_addr and
+	 * leave the last entry to use for promiscuous filtering.
+	 */
+	for (i = fbd->mac_addr_boundary - 1;
+	     i < FBNIC_RPC_TCAM_MACDA_HOST_ADDR_IDX; i++) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED) {
+			avail_addr = mac_addr;
+		} else if (ether_addr_equal(mac_addr->value.addr8, addr)) {
+			avail_addr = mac_addr;
+			break;
+		}
+	}
+
+	if (avail_addr && avail_addr->state == FBNIC_TCAM_S_DISABLED) {
+		ether_addr_copy(avail_addr->value.addr8, addr);
+		eth_zero_addr(avail_addr->mask.addr8);
+		avail_addr->state = FBNIC_TCAM_S_ADD;
+	}
+
+	return avail_addr;
+}
+
+struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
+				       const unsigned char *addr)
+{
+	struct fbnic_mac_addr *avail_addr = NULL;
+	unsigned int i;
+
+	/* Scan from middle of list to top, filling top down.
+	 * Skip over the address reserved for the BMC MAC and
+	 * exclude index 0 as that belongs to the broadcast address
+	 */
+	for (i = fbd->mac_addr_boundary;
+	     --i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED) {
+			avail_addr = mac_addr;
+		} else if (ether_addr_equal(mac_addr->value.addr8, addr)) {
+			avail_addr = mac_addr;
+			break;
+		}
+	}
+
+	/* Scan the BMC addresses to see if it may have already
+	 * reserved the address.
+	 */
+	while (--i) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		if (!is_zero_ether_addr(mac_addr->mask.addr8))
+			continue;
+
+		/* Only move on if we find a match */
+		if (!ether_addr_equal(mac_addr->value.addr8, addr))
+			continue;
+
+		/* We need to pull this address to the shared area */
+		if (avail_addr) {
+			memcpy(avail_addr, mac_addr, sizeof(*mac_addr));
+			mac_addr->state = FBNIC_TCAM_S_DELETE;
+			avail_addr->state = FBNIC_TCAM_S_ADD;
+		}
+
+		break;
+	}
+
+	if (avail_addr && avail_addr->state == FBNIC_TCAM_S_DISABLED) {
+		ether_addr_copy(avail_addr->value.addr8, addr);
+		eth_zero_addr(avail_addr->mask.addr8);
+		avail_addr->state = FBNIC_TCAM_S_ADD;
+	}
+
+	return avail_addr;
+}
+
+int __fbnic_xc_unsync(struct fbnic_mac_addr *mac_addr, unsigned int tcam_idx)
+{
+	if (!test_and_clear_bit(tcam_idx, mac_addr->act_tcam))
+		return -ENOENT;
+
+	if (bitmap_empty(mac_addr->act_tcam, FBNIC_RPC_TCAM_ACT_NUM_ENTRIES))
+		mac_addr->state = FBNIC_TCAM_S_DELETE;
+
+	return 0;
+}
+
+void fbnic_sift_macda(struct fbnic_dev *fbd)
+{
+	int dest, src;
+
+	/* Move BMC only addresses back into BMC region */
+	for (dest = FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX,
+	     src = FBNIC_RPC_TCAM_MACDA_MULTICAST_IDX;
+	     ++dest < FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX &&
+	     src < fbd->mac_addr_boundary;) {
+		struct fbnic_mac_addr *dest_addr = &fbd->mac_addr[dest];
+
+		if (dest_addr->state != FBNIC_TCAM_S_DISABLED)
+			continue;
+
+		while (src < fbd->mac_addr_boundary) {
+			struct fbnic_mac_addr *src_addr = &fbd->mac_addr[src++];
+
+			/* Verify BMC bit is set */
+			if (!test_bit(FBNIC_MAC_ADDR_T_BMC, src_addr->act_tcam))
+				continue;
+
+			/* Verify filter isn't already disabled */
+			if (src_addr->state == FBNIC_TCAM_S_DISABLED ||
+			    src_addr->state == FBNIC_TCAM_S_DELETE)
+				continue;
+
+			/* Verify only BMC bit is set */
+			if (bitmap_weight(src_addr->act_tcam,
+					  FBNIC_RPC_TCAM_ACT_NUM_ENTRIES) != 1)
+				continue;
+
+			/* Verify we are not moving wildcard address */
+			if (!is_zero_ether_addr(src_addr->mask.addr8))
+				continue;
+
+			memcpy(dest_addr, src_addr, sizeof(*src_addr));
+			src_addr->state = FBNIC_TCAM_S_DELETE;
+			dest_addr->state = FBNIC_TCAM_S_ADD;
+		}
+	}
+}
+
+static void fbnic_clear_macda_entry(struct fbnic_dev *fbd, unsigned int idx)
+{
+	int i;
+
+	/* Invalidate entry and clear addr state info */
+	for (i = 0; i <= FBNIC_RPC_TCAM_MACDA_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_MACDA(idx, i), 0);
+}
+
+static void fbnic_write_macda_entry(struct fbnic_dev *fbd, unsigned int idx,
+				    struct fbnic_mac_addr *mac_addr)
+{
+	__be16 *mask, *value;
+	int i;
+
+	mask = &mac_addr->mask.addr16[FBNIC_RPC_TCAM_MACDA_WORD_LEN - 1];
+	value = &mac_addr->value.addr16[FBNIC_RPC_TCAM_MACDA_WORD_LEN - 1];
+
+	for (i = 0; i < FBNIC_RPC_TCAM_MACDA_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_MACDA(idx, i),
+		     FIELD_PREP(FBNIC_RPC_TCAM_MACDA_MASK, ntohs(*mask--)) |
+		     FIELD_PREP(FBNIC_RPC_TCAM_MACDA_VALUE, ntohs(*value--)));
+
+	wrfl(fbd);
+
+	wr32(fbd, FBNIC_RPC_TCAM_MACDA(idx, i), FBNIC_RPC_TCAM_VALIDATE);
+}
+
+void fbnic_write_macda(struct fbnic_dev *fbd)
+{
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		/* Check if update flag is set else exit. */
+		if (!(mac_addr->state & FBNIC_TCAM_S_UPDATE))
+			continue;
+
+		/* Clear by writing 0s. */
+		if (mac_addr->state == FBNIC_TCAM_S_DELETE) {
+			/* Invalidate entry and clear addr state info */
+			fbnic_clear_macda_entry(fbd, idx);
+			memset(mac_addr, 0, sizeof(*mac_addr));
+
+			continue;
+		}
+
+		fbnic_write_macda_entry(fbd, idx, mac_addr);
+
+		mac_addr->state = FBNIC_TCAM_S_VALID;
+	}
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
new file mode 100644
index 000000000000..1b59b10ba677
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_RPC_H_
+#define _FBNIC_RPC_H_
+
+#include <uapi/linux/in6.h>
+#include <linux/bitfield.h>
+
+/*  The TCAM state definitions follow an expected ordering.
+ *  They start out disabled, then move through the following states:
+ *  Disabled  0	-> Add	      2
+ *  Add	      2	-> Valid      1
+ *
+ *  Valid     1	-> Add/Update 2
+ *  Add	      2	-> Valid      1
+ *
+ *  Valid     1	-> Delete     3
+ *  Delete    3	-> Disabled   0
+ */
+enum {
+	FBNIC_TCAM_S_DISABLED	= 0,
+	FBNIC_TCAM_S_VALID	= 1,
+	FBNIC_TCAM_S_ADD	= 2,
+	FBNIC_TCAM_S_UPDATE	= FBNIC_TCAM_S_ADD,
+	FBNIC_TCAM_S_DELETE	= 3,
+};
+
+/* 32 MAC Destination Address TCAM Entries
+ * 4 registers DA[1:0], DA[3:2], DA[5:4], Validate
+ */
+#define FBNIC_RPC_TCAM_MACDA_WORD_LEN		3
+#define FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES	32
+
+#define FBNIC_RPC_TCAM_ACT_WORD_LEN		11
+#define FBNIC_RPC_TCAM_ACT_NUM_ENTRIES		64
+
+struct fbnic_mac_addr {
+	union {
+		unsigned char addr8[ETH_ALEN];
+		__be16 addr16[FBNIC_RPC_TCAM_MACDA_WORD_LEN];
+	} mask, value;
+	unsigned char state;
+	DECLARE_BITMAP(act_tcam, FBNIC_RPC_TCAM_ACT_NUM_ENTRIES);
+};
+
+struct fbnic_act_tcam {
+	struct {
+		u16 tcam[FBNIC_RPC_TCAM_ACT_WORD_LEN];
+	} mask, value;
+	unsigned char state;
+	u16 rss_en_mask;
+	u32 dest;
+};
+
+enum {
+	FBNIC_RSS_EN_HOST_ETHER,
+	FBNIC_RSS_EN_XCAST_ETHER,
+#define FBNIC_RSS_EN_NUM_UNICAST FBNIC_RSS_EN_XCAST_ETHER
+	FBNIC_RSS_EN_NUM_ENTRIES
+};
+
+/* Reserve the first 2 entries for the use by the BMC so that we can
+ * avoid allowing rules to get in the way of BMC unicast traffic.
+ */
+#define FBNIC_RPC_ACT_TBL_BMC_OFFSET		0
+#define FBNIC_RPC_ACT_TBL_BMC_ALL_MULTI_OFFSET	1
+
+/* We reserve the last 14 entries for RSS rules on the host. The BMC
+ * unicast rule will need to be populated above these and is expected to
+ * use MACDA TCAM entry 23 to store the BMC MAC address.
+ */
+#define FBNIC_RPC_ACT_TBL_RSS_OFFSET \
+	(FBNIC_RPC_ACT_TBL_NUM_ENTRIES - FBNIC_RSS_EN_NUM_ENTRIES)
+
+/* Flags used to identify the owner for this MAC filter. Note that any
+ * flags set for Broadcast thru Promisc indicate that the rule belongs
+ * to the RSS filters for the host.
+ */
+enum {
+	FBNIC_MAC_ADDR_T_BMC            = 0,
+	FBNIC_MAC_ADDR_T_BROADCAST	= FBNIC_RPC_ACT_TBL_RSS_OFFSET,
+#define FBNIC_MAC_ADDR_T_HOST_START	FBNIC_MAC_ADDR_T_BROADCAST
+	FBNIC_MAC_ADDR_T_MULTICAST,
+	FBNIC_MAC_ADDR_T_UNICAST,
+	FBNIC_MAC_ADDR_T_ALLMULTI,	/* BROADCAST ... MULTICAST*/
+	FBNIC_MAC_ADDR_T_PROMISC,	/* BROADCAST ... UNICAST */
+	FBNIC_MAC_ADDR_T_HOST_LAST
+};
+
+#define FBNIC_MAC_ADDR_T_HOST_LEN \
+	(FBNIC_MAC_ADDR_T_HOST_LAST - FBNIC_MAC_ADDR_T_HOST_START)
+
+#define FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX	CSR_GENMASK(9, 5)
+#define FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID	CSR_BIT(10)
+
+/* TCAM 0 - 3 reserved for BMC MAC addresses */
+#define FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX	0
+/* TCAM 4 reserved for broadcast MAC address */
+#define FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX	4
+/* TCAMs 5 - 30 will be used for multicast and unicast addresses. The
+ * boundary between the two can be variable it is currently set to 24
+ * on which the unicast addresses start. The general idea is that we will
+ * always go top-down with unicast, and bottom-up with multicast so that
+ * there should be free-space in the middle between the two.
+ *
+ * The entry at MADCA_DEFAULT_BOUNDARY is a special case as it can be used
+ * for the ALL MULTI address if the list is full, or the BMC has requested
+ * it.
+ */
+#define FBNIC_RPC_TCAM_MACDA_MULTICAST_IDX	5
+#define FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY	24
+#define FBNIC_RPC_TCAM_MACDA_HOST_ADDR_IDX	30
+/* Reserved for use to record Multicast promisc, or Promiscuous */
+#define FBNIC_RPC_TCAM_MACDA_PROMISC_IDX	31
+
+struct fbnic_dev;
+
+void fbnic_bmc_rpc_init(struct fbnic_dev *fbd);
+void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd, bool enable_host);
+
+int __fbnic_xc_unsync(struct fbnic_mac_addr *mac_addr, unsigned int tcam_idx);
+struct fbnic_mac_addr *__fbnic_uc_sync(struct fbnic_dev *fbd,
+				       const unsigned char *addr);
+struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
+				       const unsigned char *addr);
+void fbnic_sift_macda(struct fbnic_dev *fbd);
+void fbnic_write_macda(struct fbnic_dev *fbd);
+
+static inline int __fbnic_uc_unsync(struct fbnic_mac_addr *mac_addr)
+{
+	return __fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_UNICAST);
+}
+
+static inline int __fbnic_mc_unsync(struct fbnic_mac_addr *mac_addr)
+{
+	return __fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_MULTICAST);
+}
+#endif /* _FBNIC_RPC_H_ */



