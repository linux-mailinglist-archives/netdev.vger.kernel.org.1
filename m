Return-Path: <netdev+bounces-232648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A2C07A17
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 185AC4E6F13
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61478345CC1;
	Fri, 24 Oct 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWisu4NV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F63396E5
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329060; cv=none; b=OUP50scZBQhAmAb+Txxs8NAH0o5NP9JRBakXrngNsssoF2/DLbPsRgW71dIgrvxsej/ND5Dj/GJyuqbSdRmyACpm+8fnZ/dPgE1CBY+AU9pNXND2m0kh5SwAOgbie4ZOEgnK/Oa346Hiu+YxCJ5nn5DSHolSWEMVnS4DL3IwsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329060; c=relaxed/simple;
	bh=FD+uLET5TuaQ/SlLICNIujEOQLyze1Ha9Ev/0UmnsS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyIQuPP5NcJqsCh4NbNjONtZlKtmEukaSEvfeSkZz6trL2N1xZCJxL4lYkM9s0J680l4baGZg48ClHXopxcQbgQZ6B0rIkpYIYKl7CnMlzQW3iu0h8q8AYXdMBYlwxf69krd9v4aKlqt5WYbPCh3xm14Aznz6JdZS+blI8yNu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWisu4NV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78125ed4052so2705033b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329057; x=1761933857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jSNSoL6MN3rN9DlGA8YJd5PwyM+kEm6TobaAM50YPw=;
        b=lWisu4NVLvAR4ysCssUyFTMfq1sN3nuqrXDA1yK/jhHZMc3X931ihspjC3gmHWen3y
         EHH9evFGTvE3RZ1u6dK8BpMJWIhDLavrmHuzc+5t57hFuf37joplfgRsBWHw4QJ+KmWn
         QpHgikUcNVUCJPj20cBXjvJ1crOiK7zeVX6ZZXWBMV1k9EijW27I69hGP1t7jQr9rqt2
         v7AfTB9aZ24K2YUmMioFMoeraGwFVdgULMHygEaH+PyCDhV1yePAUxYE+1al49rlrq6k
         Xe8JvPBPavlBN7g3Fls9EUBlq53PJTr3wdLNjuL/ckAXaOxx+FK3NVJnAz517A7SbF53
         P0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329057; x=1761933857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jSNSoL6MN3rN9DlGA8YJd5PwyM+kEm6TobaAM50YPw=;
        b=MMzq00Lw8BaFD/nIIiRP8mr1h3/via6zjVd1EGtUjFJM9p1wqpNP2mc02t0luTyL2u
         SkkPDlMIKRKBscTR/epPwTMYJnlYLDyz6nYTs+hXA7kk0CWG8/hIlm2z7KiEGFYNDiF0
         nxazdU3HfU1Gvs8uZi6HZViWLabY/59o0A29THjKN/JANqmTm6K3lwKW/Xc16QBp8wEy
         fWZNmyzqdHzSOoccDitXb8gUtAxAXbXr1mqlyOxuwe3TscwPUOJvwphMWQdg4yDLO8oH
         0o5D+w4e0Ag/oqtxiLZ+QkcuEvaNksPnGccD4r0fAsSAjKA1JaJ281roIvtIPVsHACPW
         yFjw==
X-Gm-Message-State: AOJu0Yz0TDql1RZULnvtszSRxeYiheE+fGqjBmmX0xOhn8hNQ0aaIjze
	SFZ2QkvNy/1bDhgFmqopiqK5RcgNtNpLI+pPTD4bhYb2tnrafB/WLDE2
X-Gm-Gg: ASbGncvISztEHd3bY2V4fH9172S+/UGgya7SvXWWw9CkjDNdTH++02VVdQriUaiUwN6
	8XF3qZVtr3pkKqOAiiWR/I5yOjWiJgcxWPi8fJ8RTk0pCGScJOsapFhkLqTuN1ix4ER3X7QjDt8
	hh6oX0SS3k4jgGz5src4RZUue8YKugsrkcrWOm9aAmCzZq6stiTSuN+n2gLhI0OF41DM0SX56uu
	PhsbeP1BQ4cZGwjR+v03xEAwVFnKUpVCaCuZbB2rQsZwhth+KuntigoNhefb9S04Q0iaY0B/tcs
	Bcf+DFN20T3gSMmgu3bPUam4njnynRjms5NMF1AJY/N13hBaRiWreI2REUKQNsUpi3Qtp4Aih7U
	oQTwK9sx+dQonypbERyHe5bFwjqCJWKi1VFuyP943Mb36cSyHs5Ip4wrOF3QPZ4lMnnHemVI27P
	hJrB/fdogI/DTyKMhSV+wbrIcmBFo=
X-Google-Smtp-Source: AGHT+IEqqhg958lDuFGeAHS9RaqGf4P0XUAnU1shDFq0E+4EETe2pVFAR+Por5sTueLRIulvDD0XbA==
X-Received: by 2002:a05:6a00:3cd5:b0:783:cb49:c67b with SMTP id d2e1a72fcca58-7a220d2327emr39144304b3a.32.1761329057439;
        Fri, 24 Oct 2025 11:04:17 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a60464sm6585920b3a.15.2025.10.24.11.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:04:17 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH] net: ethernet: emulex: benet: fix adapter->fw_on_flash truncation warning
Date: Fri, 24 Oct 2025 23:33:42 +0530
Message-ID: <20251024180342.1908-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The benet driver copies both fw_ver (32 bytes) and fw_on_flash (32 bytes)
into ethtool_drvinfo->fw_version (32 bytes), leading to a potential
string truncation warning when built with W=1.

Store fw_on_flash in ethtool_drvinfo->erom_version instead, which some
drivers use to report secondary firmware information.

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 .../net/ethernet/emulex/benet/be_ethtool.c    | 96 ++++++++++---------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f9216326bdfe..0d154c7e2716 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -225,8 +225,16 @@ static void be_get_drvinfo(struct net_device *netdev,
 		strscpy(drvinfo->fw_version, adapter->fw_ver,
 			sizeof(drvinfo->fw_version));
 	else
-		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-			 "%s [%s]", adapter->fw_ver, adapter->fw_on_flash);
+	{
+		strscpy(drvinfo->fw_version, adapter->fw_ver,
+			sizeof(drvinfo->fw_version));
+
+		/* 
+		* Report fw_on_flash in ethtool's erom_version field.
+		*/
+		strscpy(drvinfo->erom_version, adapter->fw_on_flash,
+			sizeof(drvinfo->erom_version));
+	}
 
 	strscpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
@@ -241,7 +249,7 @@ static u32 lancer_cmd_get_file_len(struct be_adapter *adapter, u8 *file_name)
 	memset(&data_len_cmd, 0, sizeof(data_len_cmd));
 	/* data_offset and data_size should be 0 to get reg len */
 	lancer_cmd_read_object(adapter, &data_len_cmd, 0, 0, file_name,
-			       &data_read, &eof, &addn_status);
+				   &data_read, &eof, &addn_status);
 
 	return data_read;
 }
@@ -252,7 +260,7 @@ static int be_get_dump_len(struct be_adapter *adapter)
 
 	if (lancer_chip(adapter))
 		dump_size = lancer_cmd_get_file_len(adapter,
-						    LANCER_FW_DUMP_FILE);
+							LANCER_FW_DUMP_FILE);
 	else
 		dump_size = adapter->fat_dump_len;
 
@@ -301,13 +309,13 @@ static int lancer_cmd_read_file(struct be_adapter *adapter, u8 *file_name,
 }
 
 static int be_read_dump_data(struct be_adapter *adapter, u32 dump_len,
-			     void *buf)
+				 void *buf)
 {
 	int status = 0;
 
 	if (lancer_chip(adapter))
 		status = lancer_cmd_read_file(adapter, LANCER_FW_DUMP_FILE,
-					      dump_len, buf);
+						  dump_len, buf);
 	else
 		status = be_cmd_get_fat_dump(adapter, dump_len, buf);
 
@@ -635,8 +643,8 @@ static int be_get_link_ksettings(struct net_device *netdev,
 
 			supported =
 				convert_to_et_setting(adapter,
-						      auto_speeds |
-						      fixed_speeds);
+							  auto_speeds |
+							  fixed_speeds);
 			advertising =
 				convert_to_et_setting(adapter, auto_speeds);
 
@@ -683,9 +691,9 @@ static int be_get_link_ksettings(struct net_device *netdev,
 }
 
 static void be_get_ringparam(struct net_device *netdev,
-			     struct ethtool_ringparam *ring,
-			     struct kernel_ethtool_ringparam *kernel_ring,
-			     struct netlink_ext_ack *extack)
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *extack)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 
@@ -737,7 +745,7 @@ static int be_set_phys_id(struct net_device *netdev,
 						 &adapter->beacon_state);
 		if (status)
 			return be_cmd_status(status);
-		return 1;       /* cycle on/off once per second */
+		return 1;		/* cycle on/off once per second */
 
 	case ETHTOOL_ID_ON:
 		status = be_cmd_set_beacon_state(adapter, adapter->hba_port_num,
@@ -764,7 +772,7 @@ static int be_set_dump(struct net_device *netdev, struct ethtool_dump *dump)
 	int status;
 
 	if (!lancer_chip(adapter) ||
-	    !check_privilege(adapter, MAX_PRIVILEGES))
+		!check_privilege(adapter, MAX_PRIVILEGES))
 		return -EOPNOTSUPP;
 
 	switch (dump->flag) {
@@ -873,7 +881,7 @@ static int be_test_ddr_dma(struct be_adapter *adapter)
 }
 
 static u64 be_loopback_test(struct be_adapter *adapter, u8 loopback_type,
-			    u64 *status)
+				u64 *status)
 {
 	int ret;
 
@@ -883,7 +891,7 @@ static u64 be_loopback_test(struct be_adapter *adapter, u8 loopback_type,
 		return ret;
 
 	*status = be_cmd_loopback_test(adapter, adapter->hba_port_num,
-				       loopback_type, 1500, 2, 0xabc);
+					   loopback_type, 1500, 2, 0xabc);
 
 	ret = be_cmd_set_loopback(adapter, adapter->hba_port_num,
 				  BE_NO_LOOPBACK, 1);
@@ -920,7 +928,7 @@ static void be_self_test(struct net_device *netdev, struct ethtool_test *test,
 
 		if (test->flags & ETH_TEST_FL_EXTERNAL_LB) {
 			if (be_loopback_test(adapter, BE_ONE_PORT_EXT_LOOPBACK,
-					     &data[2]) != 0)
+						 &data[2]) != 0)
 				test->flags |= ETH_TEST_FL_FAILED;
 			test->flags |= ETH_TEST_FL_EXTERNAL_LB_DONE;
 		}
@@ -999,10 +1007,10 @@ static int be_get_eeprom_len(struct net_device *netdev)
 	if (lancer_chip(adapter)) {
 		if (be_physfn(adapter))
 			return lancer_cmd_get_file_len(adapter,
-						       LANCER_VPD_PF_FILE);
+							   LANCER_VPD_PF_FILE);
 		else
 			return lancer_cmd_get_file_len(adapter,
-						       LANCER_VPD_VF_FILE);
+							   LANCER_VPD_VF_FILE);
 	} else {
 		return BE_READ_SEEPROM_LEN;
 	}
@@ -1022,10 +1030,10 @@ static int be_read_eeprom(struct net_device *netdev,
 	if (lancer_chip(adapter)) {
 		if (be_physfn(adapter))
 			return lancer_cmd_read_file(adapter, LANCER_VPD_PF_FILE,
-						    eeprom->len, data);
+							eeprom->len, data);
 		else
 			return lancer_cmd_read_file(adapter, LANCER_VPD_VF_FILE,
-						    eeprom->len, data);
+							eeprom->len, data);
 	}
 
 	eeprom->magic = BE_VENDOR_ID | (adapter->pdev->device<<16);
@@ -1074,7 +1082,7 @@ static void be_set_msg_level(struct net_device *netdev, u32 level)
 }
 
 static int be_get_rxfh_fields(struct net_device *netdev,
-			      struct ethtool_rxfh_fields *cmd)
+				  struct ethtool_rxfh_fields *cmd)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	u64 flow_type = cmd->flow_type;
@@ -1140,8 +1148,8 @@ static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 }
 
 static int be_set_rxfh_fields(struct net_device *netdev,
-			      const struct ethtool_rxfh_fields *cmd,
-			      struct netlink_ext_ack *extack)
+				  const struct ethtool_rxfh_fields *cmd,
+				  struct netlink_ext_ack *extack)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	u32 rss_flags = adapter->rss_info.rss_flags;
@@ -1154,7 +1162,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
 	}
 
 	if (cmd->data != L3_RSS_FLAGS &&
-	    cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))
+		cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))
 		return -EINVAL;
 
 	switch (cmd->flow_type) {
@@ -1174,7 +1182,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
 		break;
 	case UDP_V4_FLOW:
 		if ((cmd->data == (L3_RSS_FLAGS | L4_RSS_FLAGS)) &&
-		    BEx_chip(adapter))
+			BEx_chip(adapter))
 			return -EINVAL;
 
 		if (cmd->data == L3_RSS_FLAGS)
@@ -1185,7 +1193,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
 		break;
 	case UDP_V6_FLOW:
 		if ((cmd->data == (L3_RSS_FLAGS | L4_RSS_FLAGS)) &&
-		    BEx_chip(adapter))
+			BEx_chip(adapter))
 			return -EINVAL;
 
 		if (cmd->data == L3_RSS_FLAGS)
@@ -1211,7 +1219,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
 }
 
 static void be_get_channels(struct net_device *netdev,
-			    struct ethtool_channels *ch)
+				struct ethtool_channels *ch)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	u16 num_rx_irqs = max_t(u16, adapter->num_rss_qs, 1);
@@ -1237,14 +1245,14 @@ static int be_set_channels(struct net_device  *netdev,
 	 * combined and either RX-only or TX-only channels.
 	 */
 	if (ch->other_count || !ch->combined_count ||
-	    (ch->rx_count && ch->tx_count))
+		(ch->rx_count && ch->tx_count))
 		return -EINVAL;
 
 	if (ch->combined_count > be_max_qp_irqs(adapter) ||
-	    (ch->rx_count &&
-	     (ch->rx_count + ch->combined_count) > be_max_rx_irqs(adapter)) ||
-	    (ch->tx_count &&
-	     (ch->tx_count + ch->combined_count) > be_max_tx_irqs(adapter)))
+		(ch->rx_count &&
+		 (ch->rx_count + ch->combined_count) > be_max_rx_irqs(adapter)) ||
+		(ch->tx_count &&
+		 (ch->tx_count + ch->combined_count) > be_max_tx_irqs(adapter)))
 		return -EINVAL;
 
 	adapter->cfg_num_rx_irqs = ch->combined_count + ch->rx_count;
@@ -1265,7 +1273,7 @@ static u32 be_get_rxfh_key_size(struct net_device *netdev)
 }
 
 static int be_get_rxfh(struct net_device *netdev,
-		       struct ethtool_rxfh_param *rxfh)
+			   struct ethtool_rxfh_param *rxfh)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	int i;
@@ -1285,8 +1293,8 @@ static int be_get_rxfh(struct net_device *netdev,
 }
 
 static int be_set_rxfh(struct net_device *netdev,
-		       struct ethtool_rxfh_param *rxfh,
-		       struct netlink_ext_ack *extack)
+			   struct ethtool_rxfh_param *rxfh,
+			   struct netlink_ext_ack *extack)
 {
 	int rc = 0, i, j;
 	struct be_adapter *adapter = netdev_priv(netdev);
@@ -1295,7 +1303,7 @@ static int be_set_rxfh(struct net_device *netdev,
 
 	/* We do not allow change in unsupported parameters */
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	    rxfh->hfunc != ETH_RSS_HASH_TOP)
+		rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
 	if (rxfh->indir) {
@@ -1309,27 +1317,27 @@ static int be_set_rxfh(struct net_device *netdev,
 		}
 	} else {
 		memcpy(rsstable, adapter->rss_info.rsstable,
-		       RSS_INDIR_TABLE_LEN);
+			   RSS_INDIR_TABLE_LEN);
 	}
 
 	if (!hkey)
-		hkey =  adapter->rss_info.rss_hkey;
+		hkey =	adapter->rss_info.rss_hkey;
 
 	rc = be_cmd_rss_config(adapter, rsstable,
-			       adapter->rss_info.rss_flags,
-			       RSS_INDIR_TABLE_LEN, hkey);
+				   adapter->rss_info.rss_flags,
+				   RSS_INDIR_TABLE_LEN, hkey);
 	if (rc) {
 		adapter->rss_info.rss_flags = RSS_ENABLE_NONE;
 		return -EIO;
 	}
 	memcpy(adapter->rss_info.rss_hkey, hkey, RSS_HASH_KEY_LEN);
 	memcpy(adapter->rss_info.rsstable, rsstable,
-	       RSS_INDIR_TABLE_LEN);
+		   RSS_INDIR_TABLE_LEN);
 	return 0;
 }
 
 static int be_get_module_info(struct net_device *netdev,
-			      struct ethtool_modinfo *modinfo)
+				  struct ethtool_modinfo *modinfo)
 {
 	struct be_adapter *adapter = netdev_priv(netdev);
 	u8 page_data[PAGE_DATA_LEN];
@@ -1417,8 +1425,8 @@ static int be_set_priv_flags(struct net_device *netdev, u32 flags)
 
 const struct ethtool_ops be_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_USE_ADAPTIVE |
-				     ETHTOOL_COALESCE_USECS_LOW_HIGH,
+					 ETHTOOL_COALESCE_USE_ADAPTIVE |
+					 ETHTOOL_COALESCE_USECS_LOW_HIGH,
 	.get_drvinfo = be_get_drvinfo,
 	.get_wol = be_get_wol,
 	.set_wol = be_set_wol,
-- 
2.51.1


