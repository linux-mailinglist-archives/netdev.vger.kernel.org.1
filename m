Return-Path: <netdev+bounces-283117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HY/MoZK9GlSAQIAu9opvQ
	(envelope-from <netdev+bounces-283117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7044AAADE
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AE5A3012E40
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212436E498;
	Fri,  1 May 2026 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RT+GJGqg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D6361675;
	Fri,  1 May 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617519; cv=none; b=UsvfcAtY9xg2KLvZkKJ3rPd8t/BFva/9xxt7Y0WoSMoukBAAk5wybE2qysf//3QdwSxc5cGKYlgNnhcDhDbLf8/TfrnYM/c0+Adoryx0hCbKp01PmBeeC+kWhQMKjV46KVpdlPytFm40HCdhwCSBD0ytMe1MZyr6opOsyjOygFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617519; c=relaxed/simple;
	bh=FXZ5bJqI4ovhpOunxxdyUT5gfRoy399BLyBsuo38664=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBzcmt3KzFDI3LhY9FgRFlMaM5LpfCfQF7DDbpmA59dM/845hNL5h0F0O5aRmiukp5RQ0usAKfvrRRrMqvp6C3NoAmGxJcY3Xr0Q059gt/YRkoKywJQ6e2WG2g+VqdYSk5ExsuuTeUlZzPKyzNeXfYc5AHG2veNzfkb2UM2nYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RT+GJGqg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617517; x=1809153517;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FXZ5bJqI4ovhpOunxxdyUT5gfRoy399BLyBsuo38664=;
  b=RT+GJGqgUhW6lLvAAShMYs52O+m6D5HxS9Jlo9G1F/ZjY2tsu4YAUAUL
   C2BZt2DqIQJmf9ypYmjdgi89b14lXWJTbQ7dKjKPAgV8sI8oOf3gxZVcJ
   yrrwIaX6IttAI0t96ANCPjvXuelioSP5wnORQL2CDbHZEVIB1yRHCrDui
   qY8V/Adhv4GaESTTC5QgZa/jVrN5+A0MeWPpUxF0G+hr6S5CCm1f3gmk9
   QLIf+HMgQ0p56y1SRYzsjvk1IGr49npWJb1Uzx8BVl3c+jjqoxTH4yQsy
   2i0mIgVouplcMp3gGF+5DR6bV8k4W7USQlXd8qLIMTAvp6xbsmJ4sNqI0
   A==;
X-CSE-ConnectionGUID: Q2L13DwMR/S+KtTjBcu5iQ==
X-CSE-MsgGUID: g7VXxXUpRtyQC/hx8TGH+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271902"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
X-CSE-ConnectionGUID: kFuwsrE2R7S+8bl4GaVb+g==
X-CSE-MsgGUID: S1haTBXrThKMXck60guAFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752858"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:18 -0700
Subject: [PATCH net-next 07/15] ixgbe: E610: add ACI dynamic debug
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-7-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=8880;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=M3A0TGxQzef9H8v9AL1pR11dIm6zNfcjlkNEFzkda/g=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXik/bWy2nzI332Mh4b3j4iR1noNXXr3fxHHMO1fxL
 vstDau8jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYi78rI0Mck5qS1OOeO68qL
 Bn1tgsfMQu9UsX9qvL3yueV2IQbuVob/1ercjPoWiiK5i0SaM5oVqiRML+/Vtz+lvmrb9Ule9YU
 8AA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 7E7044AAADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283117-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid]

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

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
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 112 ++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 665a9813e251..b686636beb93 100644
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
 
@@ -147,6 +230,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
 			raw_desc[i] = raw_desc[i];
 		}
+		ixgbe_aci_debug(hw, raw_desc, NULL, 0);
 	}
 
 	/* Read async Admin Command response */
@@ -155,14 +239,21 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
 			raw_desc[i] = raw_desc[i];
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
@@ -170,12 +261,16 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
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
 
@@ -183,10 +278,13 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
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
2.54.0.rc2.531.gaf818d63126a


