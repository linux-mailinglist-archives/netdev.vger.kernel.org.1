Return-Path: <netdev+bounces-102071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A98901535
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B182B28183F
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121B71CD00;
	Sun,  9 Jun 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV/jvJ3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398521CA93;
	Sun,  9 Jun 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717923598; cv=none; b=E7ZB20HPsMqukeJ8DerZ3OAoDmPnsM+W02buGrDGP5x+pr8+zRUbvKADHRTBQOETdu5MQUjOq9R0egqTP5MpIWIlxydWZ+EgZNlEnCY+xWGJGWuCnL5SFqao7jDmGtQ0c7W5QgNIosCGPDDXV+IBAfSC5U+j34Q/8S0cbqtUB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717923598; c=relaxed/simple;
	bh=nUW19EGA3xO54BeE1knGb/2zGh2MMoX7BoimdVJB/h0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1IznOK8xWRAJxRYP+mKlJ9l0qfVQkjlrk7nwAozW/cpzNZ7trjREKbmbLZFRQY+sYsmqWkshHkqPQjbiqJa2xC4bBSHhkg0uFn6Ga7gaz0053cHEFgVjeuT5XzcsBrGehL4BlcungUJy+00gtM8nxUQkksa1OY+ccH44pHWSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV/jvJ3n; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6e57506bb2dso1116887a12.0;
        Sun, 09 Jun 2024 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717923595; x=1718528395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/pWqNS/u9ahkqK+oeNI1+gm1pKxYW6kk8vHELluENw=;
        b=hV/jvJ3n/l4ADoc0N9s9eLK6Xce1YVpjxSw5PAe9KZa1/WYzvvJos801Q0HqdrWKkI
         BX5+W5fQmmWgUSFitRiB37EvF997l9yYiIbPHkmdm2GT9js7wXCkRwPrA478q6rLT2Hv
         k/N5Wgyi0HQc/NQtxKwlw2iwYF41zD6yprzURd80PKtc/lkLxT8c2S5AbCwYGi4bo8A3
         LHdf3XRCK9MeBAfi944SY+k0NpuOQgf4dqKEPFo491Hd4lBi3Cf6HAy/epNccPQ3Qvb6
         DDagxYyfhfa5i36IUg9/fQHhQJ68sdAs3hX/jDv4yJHRybwKFXKTTsMdANJI0NfcRLS5
         BYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717923595; x=1718528395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/pWqNS/u9ahkqK+oeNI1+gm1pKxYW6kk8vHELluENw=;
        b=a2pn02qcOQ3rhK9vFxGHiE1aa0CmjXA8JrEa1iqEysYLqg3nmZ/e+eqmIekF8C6MmZ
         QZ0ZS6IHsQ7ewUp0WrFl0BqjL7+IzBunHYNmFyJWEWE1W33Ik+QWamkbTlJmHggtSGB3
         4L2NZ896+e7trO/Lu0pc//Ta5fFjDZbxzlNb/x77NN/aGqglIe1zFExXc8H7NeCpIXqi
         pO6RaBK1jy0m9iZix2OhWoZ/OS/8zHo78DF1UgKi5YKPZnDSNsldOgayz2zHRPUmmm0G
         fBYEfPVCaQwvclzN3co/CU11/uPCjV7rnKO2t7es++OKE42Ute+z+SjCYci6sdXucjrx
         EycA==
X-Forwarded-Encrypted: i=1; AJvYcCV0gid+IaMxXMIqQlZQMci1LLHXqEvUELgLu0YJQYQUfXIJm2KVZVsu0ywwseuAlrbNlOXiVDzMbt0IQNbs/sjt5LHZMJuppKkh0DeAcsXrDZQFZrHxADqXkWlI/NOkDg0R43VE
X-Gm-Message-State: AOJu0YywT/7pv6MxPuJJMMyazLKnj8XLMdMzoPvZWFGysJAA7hzcyBpQ
	RbF5uGFl+sMpK2Hg5twuU6SA53RuGYuMSNTIxEz6bGqm/F1TG3tC/EazJiWSyKw=
X-Google-Smtp-Source: AGHT+IEI9kRXr1suV4pE3NprZ4CoN8wyS6LC7SJ3RhSIDWAssP5sDEavsZHw0UiQmhhha2LSfypdZg==
X-Received: by 2002:a05:6300:8088:b0:1b0:812:ab3e with SMTP id adf61e73a8af0-1b2f9c64118mr6698217637.38.1717923595328;
        Sun, 09 Jun 2024 01:59:55 -0700 (PDT)
Received: from richard-1-2.. (223-137-2-26.emome-ip.hinet.net. [223.137.2.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c304fe9622sm251515a91.18.2024.06.09.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 01:59:54 -0700 (PDT)
From: Richard chien <m8809301@gmail.com>
X-Google-Original-From: Richard chien <richard.chien@hpe.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard chien <richard.chien@hpe.com>
Subject: [PATCH] ixgbe: Add support for firmware update
Date: Sun,  9 Jun 2024 16:57:35 +0800
Message-Id: <20240609085735.6253-1-richard.chien@hpe.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for firmware update to the in-tree ixgbe driver and it is actually a port
from the out-of-tree ixgbe driver. In-band firmware update is one of the essential system maintenance
tasks. To simplify this task, the Intel online firmware update utility provides a common interface
that works across different Intel NICs running the igb/ixgbe/i40e drivers. Unfortunately, the in-tree
igb and ixgbe drivers are unable to support this firmware update utility, causing problems for
enterprise users who do not or cannot use out-of-distro drivers due to security and various other
reasons (e.g. commercial Linux distros do not provide technical support for out-of-distro drivers).
As a result, getting this feature into the in-tree ixgbe driver is highly desirable.

Signed-off-by: Richard chien <richard.chien@hpe.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 360 +++++++++++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  11 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  37 ++
 3 files changed, 317 insertions(+), 91 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6e6e6f184..3ce5c662a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -993,114 +993,292 @@ static void ixgbe_get_regs(struct net_device *netdev,
 
 static int ixgbe_get_eeprom_len(struct net_device *netdev)
 {
-	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	return adapter->hw.eeprom.word_size * 2;
+        struct ixgbe_adapter *adapter = netdev_priv(netdev);
+
+        return pci_resource_len(adapter->pdev, 0);
+}
+
+static u8 ixgbe_nvmupd_get_module(u32 val)
+{
+        return (u8)(val & IXGBE_NVMUPD_MOD_PNT_MASK);
+}
+
+static int ixgbe_nvmupd_validate_offset(struct ixgbe_adapter *adapter,
+                                        u32 offset)
+{
+        struct net_device *netdev = adapter->netdev;
+
+        switch (offset) {
+        case IXGBE_STATUS:
+        case IXGBE_ESDP:
+        case IXGBE_MSCA:
+        case IXGBE_MSRWD:
+        case IXGBE_EEC_8259X:
+        case IXGBE_FLA_8259X:
+        case IXGBE_FLOP:
+        case IXGBE_SWSM_8259X:
+        case IXGBE_FWSM_8259X:
+        case IXGBE_FACTPS_8259X:
+        case IXGBE_GSSR:
+        case IXGBE_HICR:
+        case IXGBE_FWSTS:
+                return 0;
+        default:
+                if ((offset >= IXGBE_MAVTV(0) && offset <= IXGBE_MAVTV(7)) ||
+                    (offset >= IXGBE_RAL(0) && offset <= IXGBE_RAH(15)))
+                        return 0;
+        }
+
+        switch (adapter->hw.mac.type) {
+        case ixgbe_mac_82599EB:
+                switch (offset) {
+                case IXGBE_AUTOC:
+                case IXGBE_EERD:
+                case IXGBE_BARCTRL:
+                        return 0;
+                default:
+                        if (offset >= 0x00020000 &&
+                            offset <= ixgbe_get_eeprom_len(netdev))
+                                return 0;
+                }
+                break;
+        case ixgbe_mac_X540:
+                switch (offset) {
+                case IXGBE_EERD:
+                case IXGBE_EEWR:
+                case IXGBE_SRAMREL:
+                case IXGBE_BARCTRL:
+                        return 0;
+                default:
+                        if ((offset >= 0x00020000 &&
+                             offset <= ixgbe_get_eeprom_len(netdev)))
+                                return 0;
+                }
+                break;
+        case ixgbe_mac_X550:
+                switch (offset) {
+                case IXGBE_EEWR:
+                case IXGBE_SRAMREL:
+                case IXGBE_PHYCTL_82599:
+                case IXGBE_FWRESETCNT:
+                        return 0;
+                default:
+                        if (offset >= IXGBE_FLEX_MNG_PTR(0) &&
+                            offset <= IXGBE_FLEX_MNG_PTR(447))
+                                return 0;
+                }
+                break;
+        case ixgbe_mac_X550EM_x:
+                switch (offset) {
+                case IXGBE_PHYCTL_82599:
+                case IXGBE_NW_MNG_IF_SEL:
+                case IXGBE_FWRESETCNT:
+                case IXGBE_I2CCTL_X550:
+                        return 0;
+                default:
+                        if ((offset >= IXGBE_FLEX_MNG_PTR(0) &&
+                             offset <= IXGBE_FLEX_MNG_PTR(447)) ||
+                            (offset >= IXGBE_FUSES0_GROUP(0) &&
+                             offset <= IXGBE_FUSES0_GROUP(7)))
+                                return 0;
+                }
+                break;
+        case ixgbe_mac_x550em_a:
+                switch (offset) {
+                case IXGBE_PHYCTL_82599:
+                case IXGBE_NW_MNG_IF_SEL:
+                case IXGBE_FWRESETCNT:
+                case IXGBE_I2CCTL_X550:
+                case IXGBE_FLA_X550EM_a:
+                case IXGBE_SWSM_X550EM_a:
+                case IXGBE_FWSM_X550EM_a:
+                case IXGBE_SWFW_SYNC_X550EM_a:
+                case IXGBE_FACTPS_X550EM_a:
+                case IXGBE_EEC_X550EM_a:
+                        return 0;
+                default:
+                        if (offset >= IXGBE_FLEX_MNG_PTR(0) &&
+                            offset <= IXGBE_FLEX_MNG_PTR(447))
+                                return 0;
+                }
+        default:
+                break;
+        }
+
+        return -ENOTTY;
+}
+
+static int ixgbe_nvmupd_command(struct ixgbe_hw *hw,
+                                struct ixgbe_nvm_access *nvm,
+                                u8 *bytes)
+{
+        u32 command;
+        int ret_val = 0;
+        u8 module;
+
+        command = nvm->command;
+        module = ixgbe_nvmupd_get_module(nvm->config);
+
+        switch (command) {
+        case IXGBE_NVMUPD_CMD_REG_READ:
+                switch (module) {
+                case IXGBE_NVMUPD_EXEC_FEATURES:
+                        if (nvm->data_size == hw->nvmupd_features.size)
+                                memcpy(bytes, &hw->nvmupd_features,
+                                       hw->nvmupd_features.size);
+                        else
+                                ret_val = -ENOMEM;
+                break;
+                default:
+                        if (ixgbe_nvmupd_validate_offset(hw->back, nvm->offset))
+                                return -ENOTTY;
+
+                        if (nvm->data_size == 1)
+                                *((u8 *)bytes) = IXGBE_R8_Q(hw, nvm->offset);
+                        else
+                                *((u32 *)bytes) = IXGBE_R32_Q(hw, nvm->offset);
+                break;
+                }
+        break;
+        case IXGBE_NVMUPD_CMD_REG_WRITE:
+                if (ixgbe_nvmupd_validate_offset(hw->back, nvm->offset))
+                        return -ENOTTY;
+
+                IXGBE_WRITE_REG(hw, nvm->offset, *((u32 *)bytes));
+        break;
+        }
+
+        return ret_val;
 }
 
 static int ixgbe_get_eeprom(struct net_device *netdev,
-			    struct ethtool_eeprom *eeprom, u8 *bytes)
+                            struct ethtool_eeprom *eeprom, u8 *bytes)
 {
-	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	struct ixgbe_hw *hw = &adapter->hw;
-	u16 *eeprom_buff;
-	int first_word, last_word, eeprom_len;
-	int ret_val = 0;
-	u16 i;
+        struct ixgbe_adapter *adapter = netdev_priv(netdev);
+        struct ixgbe_hw *hw = &adapter->hw;
+        u16 *eeprom_buff;
+        int first_word, last_word, eeprom_len;
+        struct ixgbe_nvm_access *nvm;
+        u32 magic;
+        int ret_val = 0;
+        u16 i;
 
-	if (eeprom->len == 0)
-		return -EINVAL;
-
-	eeprom->magic = hw->vendor_id | (hw->device_id << 16);
-
-	first_word = eeprom->offset >> 1;
-	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
-	eeprom_len = last_word - first_word + 1;
-
-	eeprom_buff = kmalloc_array(eeprom_len, sizeof(u16), GFP_KERNEL);
-	if (!eeprom_buff)
-		return -ENOMEM;
+        //WARN("ixgbe_get_eeprom() invoked, bytes=%u\n", bytes);
 
-	ret_val = hw->eeprom.ops.read_buffer(hw, first_word, eeprom_len,
-					     eeprom_buff);
+        if (eeprom->len == 0)
+                return -EINVAL;
 
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < eeprom_len; i++)
-		le16_to_cpus(&eeprom_buff[i]);
+        magic = hw->vendor_id | (hw->device_id << 16);
+        if (eeprom->magic && eeprom->magic != magic) {
+                nvm = (struct ixgbe_nvm_access *)eeprom;
+                ret_val = ixgbe_nvmupd_command(hw, nvm, bytes);
+                return ret_val;
+        }
 
-	memcpy(bytes, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
-	kfree(eeprom_buff);
+        /* normal ethtool get_eeprom support */
+        eeprom->magic = hw->vendor_id | (hw->device_id << 16);
 
-	return ret_val;
-}
+        first_word = eeprom->offset >> 1;
+        last_word = (eeprom->offset + eeprom->len - 1) >> 1;
+        eeprom_len = last_word - first_word + 1;
 
-static int ixgbe_set_eeprom(struct net_device *netdev,
-			    struct ethtool_eeprom *eeprom, u8 *bytes)
-{
-	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	struct ixgbe_hw *hw = &adapter->hw;
-	u16 *eeprom_buff;
-	void *ptr;
-	int max_len, first_word, last_word, ret_val = 0;
-	u16 i;
+        eeprom_buff = kmalloc(sizeof(u16) * eeprom_len, GFP_KERNEL);
+        if (!eeprom_buff)
+                return -ENOMEM;
 
-	if (eeprom->len == 0)
-		return -EINVAL;
+        ret_val = hw->eeprom.ops.read_buffer(hw, first_word, eeprom_len,
+                                           eeprom_buff);
 
-	if (eeprom->magic != (hw->vendor_id | (hw->device_id << 16)))
-		return -EINVAL;
+        /* Device's eeprom is always little-endian, word addressable */
+        for (i = 0; i < eeprom_len; i++)
+                le16_to_cpus(&eeprom_buff[i]);
 
-	max_len = hw->eeprom.word_size * 2;
+        memcpy(bytes, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
+        kfree(eeprom_buff);
 
-	first_word = eeprom->offset >> 1;
-	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
-	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
-	if (!eeprom_buff)
-		return -ENOMEM;
-
-	ptr = eeprom_buff;
-
-	if (eeprom->offset & 1) {
-		/*
-		 * need read/modify/write of first changed EEPROM word
-		 * only the second byte of the word is being modified
-		 */
-		ret_val = hw->eeprom.ops.read(hw, first_word, &eeprom_buff[0]);
-		if (ret_val)
-			goto err;
-
-		ptr++;
-	}
-	if ((eeprom->offset + eeprom->len) & 1) {
-		/*
-		 * need read/modify/write of last changed EEPROM word
-		 * only the first byte of the word is being modified
-		 */
-		ret_val = hw->eeprom.ops.read(hw, last_word,
-					  &eeprom_buff[last_word - first_word]);
-		if (ret_val)
-			goto err;
-	}
-
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < last_word - first_word + 1; i++)
-		le16_to_cpus(&eeprom_buff[i]);
-
-	memcpy(ptr, bytes, eeprom->len);
-
-	for (i = 0; i < last_word - first_word + 1; i++)
-		cpu_to_le16s(&eeprom_buff[i]);
-
-	ret_val = hw->eeprom.ops.write_buffer(hw, first_word,
-					      last_word - first_word + 1,
-					      eeprom_buff);
+        return ret_val;
+}
 
-	/* Update the checksum */
-	if (ret_val == 0)
-		hw->eeprom.ops.update_checksum(hw);
+static int ixgbe_set_eeprom(struct net_device *netdev,
+                            struct ethtool_eeprom *eeprom, u8 *bytes)
+{
+        struct ixgbe_adapter *adapter = netdev_priv(netdev);
+        struct ixgbe_hw *hw = &adapter->hw;
+        int max_len, first_word, last_word, ret_val = 0;
+        struct ixgbe_nvm_access *nvm;
+        u32 magic;
+        u16 *eeprom_buff, i;
+        void *ptr;
+
+        //WARN("ixgbe_set_eeprom() invoked, bytes=%u\n", bytes);
+
+        if (eeprom->len == 0) 
+                return -EINVAL;
+
+        magic = hw->vendor_id | (hw->device_id << 16);
+        if (eeprom->magic && eeprom->magic != magic) {
+                nvm = (struct ixgbe_nvm_access *)eeprom;
+                ret_val = ixgbe_nvmupd_command(hw, nvm, bytes);
+                return ret_val;
+        }
+
+        /* normal ethtool set_eeprom support */
+
+        if (eeprom->magic != (hw->vendor_id | (hw->device_id << 16)))
+                return -EINVAL;
+
+        max_len = hw->eeprom.word_size * 2;
+
+        first_word = eeprom->offset >> 1;
+        last_word = (eeprom->offset + eeprom->len - 1) >> 1;
+        eeprom_buff = kmalloc(max_len, GFP_KERNEL);
+        if (!eeprom_buff)
+                return -ENOMEM;
+
+        ptr = eeprom_buff;
+
+        if (eeprom->offset & 1) {
+                /*
+                 * need read/modify/write of first changed EEPROM word
+                 * only the second byte of the word is being modified
+                 */
+                ret_val = hw->eeprom.ops.read(hw, first_word, &eeprom_buff[0]);
+                if (ret_val)
+                        goto err;
+
+                ptr++;
+        }
+        if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
+                /*
+                 * need read/modify/write of last changed EEPROM word
+                 * only the first byte of the word is being modified
+                 */
+                ret_val = hw->eeprom.ops.read(hw, last_word,
+                                          &eeprom_buff[last_word - first_word]);
+                if (ret_val)
+                        goto err;
+        }
+
+        /* Device's eeprom is always little-endian, word addressable */
+        for (i = 0; i < last_word - first_word + 1; i++)
+                le16_to_cpus(&eeprom_buff[i]);
+
+        memcpy(ptr, bytes, eeprom->len);
+
+        for (i = 0; i < last_word - first_word + 1; i++)
+                cpu_to_le16s(&eeprom_buff[i]);
+
+        ret_val = hw->eeprom.ops.write_buffer(hw, first_word,
+                                            last_word - first_word + 1,
+                                            eeprom_buff);
+
+        /* Update the checksum */
+        if (ret_val == 0)
+                hw->eeprom.ops.update_checksum(hw);
 
 err:
-	kfree(eeprom_buff);
-	return ret_val;
+        kfree(eeprom_buff);
+        return ret_val;
 }
 
 static void ixgbe_get_drvinfo(struct net_device *netdev,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 094653e81..ac2405105 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6519,6 +6519,17 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	if (nr_cpu_ids > IXGBE_MAX_XDP_QS)
 		static_branch_enable(&ixgbe_xdp_locking_key);
 
+        /* NVM Update features structure initialization */
+        hw->nvmupd_features.major = IXGBE_NVMUPD_FEATURES_API_VER_MAJOR;
+        hw->nvmupd_features.minor = IXGBE_NVMUPD_FEATURES_API_VER_MINOR;
+        hw->nvmupd_features.size = sizeof(hw->nvmupd_features);
+        memset(hw->nvmupd_features.features, 0x0,
+               IXGBE_NVMUPD_FEATURES_API_FEATURES_ARRAY_LEN *
+               sizeof(*hw->nvmupd_features.features));
+
+        hw->nvmupd_features.features[0] =
+                IXGBE_NVMUPD_FEATURE_REGISTER_ACCESS_SUPPORT;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 346e3d911..5c71e67d2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -129,6 +129,8 @@
 #define IXGBE_GRC_X550EM_x	IXGBE_GRC_8259X
 #define IXGBE_GRC_X550EM_a	0x15F64
 #define IXGBE_GRC(_hw)		IXGBE_BY_MAC((_hw), GRC)
+#define IXGBE_SRAMREL           0x10210
+#define IXGBE_FWRESETCNT        0x15F40
 
 /* General Receive Control */
 #define IXGBE_GRC_MNG  0x00000001 /* Manageability Enable */
@@ -936,6 +938,7 @@ struct ixgbe_nvm_version {
 #define IXGBE_SWSR      0x15F10
 #define IXGBE_HFDR      0x15FE8
 #define IXGBE_FLEX_MNG  0x15800 /* 0x15800 - 0x15EFC */
+#define IXGBE_FLEX_MNG_PTR(_i)  (IXGBE_FLEX_MNG + ((_i) * 4))
 
 #define IXGBE_HICR_EN              0x01  /* Enable bit - RO */
 /* Driver sets this bit when done to put command in RAM */
@@ -3390,6 +3393,38 @@ struct ixgbe_hw_stats {
 	u64 o2bspc;
 };
 
+/* NVM Update commands */
+#define IXGBE_NVMUPD_CMD_REG_READ	0x0000000B
+#define IXGBE_NVMUPD_CMD_REG_WRITE	0x0000000C 
+
+#define IXGBE_R32_Q(h, r) ixgbe_read_reg(h, r)
+#define IXGBE_R8_Q(h, r) readb(READ_ONCE(h->hw_addr) + r)
+
+/* NVM Update features API */
+#define IXGBE_NVMUPD_FEATURES_API_VER_MAJOR             0
+#define IXGBE_NVMUPD_FEATURES_API_VER_MINOR             0
+#define IXGBE_NVMUPD_FEATURES_API_FEATURES_ARRAY_LEN    12
+#define IXGBE_NVMUPD_EXEC_FEATURES                      0xe
+#define IXGBE_NVMUPD_FEATURE_FLAT_NVM_SUPPORT           BIT(0)
+#define IXGBE_NVMUPD_FEATURE_REGISTER_ACCESS_SUPPORT    BIT(1)
+
+#define IXGBE_NVMUPD_MOD_PNT_MASK                       0xFF
+
+struct ixgbe_nvm_access {
+        u32 command;
+        u32 config; 
+        u32 offset;     /* in bytes */
+        u32 data_size;  /* in bytes */
+        u8 data[1];
+};
+
+struct ixgbe_nvm_features {
+        u8 major;
+        u8 minor;
+        u16 size;
+        u8 features[IXGBE_NVMUPD_FEATURES_API_FEATURES_ARRAY_LEN];
+}; 
+
 /* forward declaration */
 struct ixgbe_hw;
 
@@ -3654,6 +3689,8 @@ struct ixgbe_hw {
 	bool				allow_unsupported_sfp;
 	bool				wol_enabled;
 	bool				need_crosstalk_fix;
+       /* NVM Update features */
+        struct ixgbe_nvm_features nvmupd_features;
 };
 
 struct ixgbe_info {
-- 
2.40.1


