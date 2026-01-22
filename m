Return-Path: <netdev+bounces-252443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIBDL11WcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:54:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1E6A6E4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A76A73071EED
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF42652A2;
	Thu, 22 Jan 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/7fgtO8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3A3EBF3E
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099217; cv=none; b=P/zsmlOd8ouLr284uBRw000EZ+agZODiUxq+JwC+x/lESYbRqt+NNP0S8cNXfEkpoQg/1dRp1aD4USb+Jc8i70qhRfIjjnWIpPewu0pA5OVqhYgkOxtkhraDAsyg0qezrugDxGzwGEQ74pZnfUbYTuAuwhlilS8gJtUlY68NNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099217; c=relaxed/simple;
	bh=oBO3ITxFMX8v/YIdID1ueiMqoXkXoALFvhh4gQNVedQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXoKGouf7o7M/tE8X4tdc3pL0QbYuBq3tL4oUKC672tqwdCrGzTgtbQChl4AkYB3FZwy8+CSsV2icwYJpf22IqaDnWLFfC1toFy78HZ5JL7JlfCyiowr/be4XNJdZ011SIP2szHUgEHRCjS28eh7JQ7kDjiZJeDrACPPp23XO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/7fgtO8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769099214; x=1800635214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oBO3ITxFMX8v/YIdID1ueiMqoXkXoALFvhh4gQNVedQ=;
  b=U/7fgtO8Gv/MUolbX7xoVAFjGwtZpzwRuipNj1ApV3A/26Hh1U0uh6pW
   elKN67ifW+AKGGQ5zrGNg+QKu2KTKOKORtkgcOtqiVKRwfWd8I8tL0ZMf
   f9EmFjaF8/9UXM6y5Q5XbLRwt12fBOWZk18JkUBiQifR0tnKUP8PN4S6R
   ZC7GvWjcPAyI7Sk3ZqnHMjw4wZw1CdNhMSQ/suCnELo7TpiHHSaeE2cA1
   IEIlt9ZcRKc3iSFTSaFVYlZnI5F/dMXH7GFN1Nk5/VTMAMU0dlosNvlc1
   AIXbib+WsjtegUwKS4qQ6x2EEHeeLCa5eO6xa7AcP/iy9xN71RLtT3LL0
   g==;
X-CSE-ConnectionGUID: VkCQolaYS2KMq9FKXT67Vg==
X-CSE-MsgGUID: W/voLcsqTyKG5b+i7Hc+kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81459342"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81459342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:26:49 -0800
X-CSE-ConnectionGUID: 9WJPWAF2TauRhnEHtvJOvw==
X-CSE-MsgGUID: XAwBhaZwTWCnwoJSkBcEMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211225326"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2026 08:26:48 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 2/2] ixgbe: e610: add ACI dynamic debug
Date: Thu, 22 Jan 2026 17:47:45 +0100
Message-ID: <20260122164745.112682-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252443-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 60F1E6A6E4
X-Rspamd-Action: no action

Enable dynamic debug (dyndbg) of Admin Command Interface (ACI) for e610
adapter. Utilizes the standard dynamic debug interface. For example to
enable dyndbg at driver load:

insmod ixgbe.ko dyndbg='+p'

ACI debug output for e610 adapter is immediately printed into a kernel
log (dmesg). Example output:

ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0701, flags 0x3003, datalen 0x0060, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x8194E044 0x00600000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0: Buffer:
ixgbe 0000:01:00.0 eth0: 00000000: 01 00 17 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000010: 1d 00 00 00 0b d5 1e 15 5e 4b 90 63 aa 0b 21 31
ixgbe 0000:01:00.0 eth0: 00000020: 69 eb cd ab dc f8 8a fd f4 53 e2 dc 54 e0 81 fa
ixgbe 0000:01:00.0 eth0: 00000030: 12 dc 41 82 01 00 00 00 24 20 08 26 53 08 00 00
ixgbe 0000:01:00.0 eth0: 00000040: 08 00 14 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ixgbe 0000:01:00.0 eth0: CQ CMD: opcode 0x0009, flags 0x2003, datalen 0x0000, retval 0x0000
ixgbe 0000:01:00.0 eth0:       cookie (h,l) 0x00000000 0x00000000
ixgbe 0000:01:00.0 eth0:       param (0,1)  0x00000001 0x00000000
ixgbe 0000:01:00.0 eth0:       addr (h,l)   0x00000000 0x00000000

Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 112 ++++++++++++++++--
 1 file changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index f494e90..bccd51e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -9,6 +9,78 @@
 #include "ixgbe_mbx.h"
 #include "ixgbe_phy.h"
 
+#define IXGBE_ACI_DEBUG_ROW_SIZE	16
+#define IXGBE_ACI_DEBUG_GROUP_SIZE	1
+#define IXGBE_NETDEV_PREFIX_BUF_SIZE	64
+
+/**
+ * ixgbe_hex_debug_dump - dump a blob of data in "hex ASCII" format
+ * @hw: hardware structure address
+ * @buf: data blob to dump
+ * @buf_size: number of bytes in the @buf
+ *
+ * Dump a blob of data into a kernel log. The blob is printed in lines
+ * consisting of 16 or 32 bytes decorated with PCI device string. Each byte is
+ * printed in a "hex ASCII" format.
+ * Example output:
+ * ixgbe 0000:01:00.1 eth14: 00000000: 01 00 17 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * ixgbe 0000:01:00.1 eth14: 00000010: 1d 00 00 00 0b d5 1e 15 5e 4b 90 63 aa 0b 21 31
+ * ixgbe 0000:01:00.1 eth14: 00000020: 69 eb cd ab dc f8 8a fd f4 53 e2 dc 54 e0 81 fa
+ */
+static void ixgbe_hex_debug_dump(struct ixgbe_hw *hw, void *buf,
+				 size_t buf_size)
+{
+	char netdev_info[IXGBE_NETDEV_PREFIX_BUF_SIZE];
+	struct ixgbe_adapter *adapter = hw->back;
+	struct pci_dev *pdev = adapter->pdev;
+
+	snprintf(netdev_info, IXGBE_NETDEV_PREFIX_BUF_SIZE,
+		 "%s %s %s: ", ixgbe_driver_name, pci_name(pdev),
+		 netdev_name(adapter->netdev));
+	print_hex_dump_debug(netdev_info, DUMP_PREFIX_OFFSET,
+			     IXGBE_ACI_DEBUG_ROW_SIZE,
+			     IXGBE_ACI_DEBUG_GROUP_SIZE,
+			     buf, buf_size, false);
+}
+
+/**
+ * ixgbe_aci_debug - dump the ACI content
+ * @hw: pointer to the hardware structure
+ * @desc: pointer to control queue descriptor
+ * @buf: pointer to command buffer
+ * @buf_len: max length of buf
+ *
+ * Dump individual ACI commands and its descriptor details.
+ */
+static void ixgbe_aci_debug(struct ixgbe_hw *hw, void *desc, void *buf,
+			    u16 buf_len)
+{
+	struct libie_aq_desc *aq_desc = desc;
+	u16 datalen, flags;
+
+	datalen = le16_to_cpu(aq_desc->datalen);
+	flags = le16_to_cpu(aq_desc->flags);
+
+	hw_dbg(hw, "CQ CMD: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
+	       le16_to_cpu(aq_desc->opcode), flags, datalen,
+	       le16_to_cpu(aq_desc->retval));
+	hw_dbg(hw, "\tcookie (h,l) 0x%08X 0x%08X\n",
+	       le32_to_cpu(aq_desc->cookie_high),
+	       le32_to_cpu(aq_desc->cookie_low));
+	hw_dbg(hw, "\tparam (0,1)  0x%08X 0x%08X\n",
+	       le32_to_cpu(aq_desc->params.generic.param0),
+	       le32_to_cpu(aq_desc->params.generic.param1));
+	hw_dbg(hw, "\taddr (h,l)   0x%08X 0x%08X\n",
+	       le32_to_cpu(aq_desc->params.generic.addr_high),
+	       le32_to_cpu(aq_desc->params.generic.addr_low));
+
+	if (buf && datalen && (flags & (LIBIE_AQ_FLAG_DD | LIBIE_AQ_FLAG_CMP |
+	    LIBIE_AQ_FLAG_RD))) {
+		hw_dbg(hw, "Buffer:\n");
+		ixgbe_hex_debug_dump(hw, buf, min(buf_len, datalen));
+	}
+}
+
 /**
  * ixgbe_should_retry_aci_send_cmd_execute - decide if ACI command should
  * be resent
@@ -69,26 +141,33 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	/* It's necessary to check if mechanism is enabled */
 	hicr = IXGBE_READ_REG(hw, IXGBE_PF_HICR);
 
-	if (!(hicr & IXGBE_PF_HICR_EN))
+	if (!(hicr & IXGBE_PF_HICR_EN)) {
+		hw_dbg(hw, "CSR mechanism is not enabled\n");
 		return -EIO;
+	}
 
 	if (hicr & IXGBE_PF_HICR_C) {
 		hw->aci.last_status = LIBIE_AQ_RC_EBUSY;
+		hw_dbg(hw, "CSR mechanism is busy\n");
 		return -EBUSY;
 	}
 
 	opcode = le16_to_cpu(desc->opcode);
 
-	if (buf_size > IXGBE_ACI_MAX_BUFFER_SIZE)
+	if (buf_size > IXGBE_ACI_MAX_BUFFER_SIZE) {
+		hw_dbg(hw, "buf_size is too big\n");
 		return -EINVAL;
+	}
 
 	if (buf)
 		desc->flags |= cpu_to_le16(LIBIE_AQ_FLAG_BUF);
 
 	if (desc->flags & cpu_to_le16(LIBIE_AQ_FLAG_BUF)) {
 		if ((buf && !buf_size) ||
-		    (!buf && buf_size))
+		    (!buf && buf_size)) {
+			hw_dbg(hw, "error: invalid argument buf or buf_size\n");
 			return -EINVAL;
+		}
 		if (buf && buf_size)
 			valid_buf = true;
 	}
@@ -106,8 +185,12 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 		if (desc->flags & cpu_to_le16(LIBIE_AQ_FLAG_RD)) {
 			for (i = 0; i < buf_size / 4; i++)
 				IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), ((u32 *)buf)[i]);
-			if (buf_tail_size)
+			ixgbe_aci_debug(hw, desc, buf, buf_size);
+			if (buf_tail_size) {
 				IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), buf_tail);
+				ixgbe_aci_debug(hw, desc, &buf_tail,
+						buf_tail_size);
+			}
 		}
 	}
 
@@ -148,6 +231,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
 			raw_desc[i] = cpu_to_le32(raw_desc[i]);
 		}
+		ixgbe_aci_debug(hw, raw_desc, NULL, 0);
 	}
 
 	/* Read async Admin Command response */
@@ -156,14 +240,21 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
 			raw_desc[i] = cpu_to_le32(raw_desc[i]);
 		}
+		ixgbe_aci_debug(hw, raw_desc, NULL, 0);
 	}
 
 	/* Handle timeout and invalid state of HICR register */
-	if (hicr & IXGBE_PF_HICR_C)
+	if (hicr & IXGBE_PF_HICR_C) {
+		hw_dbg(hw, "error: Admin Command 0x%X command timeout\n",
+		       le16_to_cpu(desc->opcode));
 		return -ETIME;
+	}
 
-	if (!(hicr & IXGBE_PF_HICR_SV) && !(hicr & IXGBE_PF_HICR_EV))
+	if (!(hicr & IXGBE_PF_HICR_SV) && !(hicr & IXGBE_PF_HICR_EV)) {
+		hw_dbg(hw, "error: Admin Command 0x%X invalid state of HICR register\n",
+		       le16_to_cpu(desc->opcode));
 		return -EIO;
+	}
 
 	/* For every command other than 0x0014 treat opcode mismatch
 	 * as an error. Response to 0x0014 command read from HIDA_2
@@ -171,12 +262,16 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	 * different opcode than the command.
 	 */
 	if (desc->opcode != cpu_to_le16(opcode) &&
-	    opcode != ixgbe_aci_opc_get_fw_event)
+	    opcode != ixgbe_aci_opc_get_fw_event) {
+		hw_dbg(hw, "error: Admin Command failed, bad opcode returned\n");
 		return -EIO;
+	}
 
 	if (desc->retval) {
 		hw->aci.last_status = (enum libie_aq_err)
 			le16_to_cpu(desc->retval);
+		hw_dbg(hw, "error: Admin Command failed with error %x\n",
+		       le16_to_cpu(desc->retval));
 		return -EIO;
 	}
 
@@ -184,10 +279,13 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if (valid_buf) {
 		for (i = 0; i < buf_size / 4; i++)
 			((u32 *)buf)[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
+		ixgbe_aci_debug(hw, raw_desc, buf, buf_size);
 		if (buf_tail_size) {
 			buf_tail = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
 			memcpy(buf + buf_size - buf_tail_size, &buf_tail,
 			       buf_tail_size);
+			ixgbe_aci_debug(hw, raw_desc, &buf_tail,
+					buf_tail_size);
 		}
 	}
 
-- 
2.47.1


