Return-Path: <netdev+bounces-268293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BViNwuCuGltfAEAu9opvQ
	(envelope-from <netdev+bounces-268293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:19:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D42A1657
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D58306BD20
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D735C1A6;
	Mon, 16 Mar 2026 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNmTDwLj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D91EFF8D;
	Mon, 16 Mar 2026 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699381; cv=none; b=KrvKPiS6hb2bobJ/extfBTloZv9KtZPbiRUBs+LxS1w4b1qTEL2gKMrJ3iPztvnOOCZE5M5Vh7fKaOc8lPgnYFnllSxRJaAfRBopjmpvKHxIFOkKZDzC8M3/DAcxkdE6uzaepb10K1b86O5YhW1HdJzyMtcBY2rFOVpE/E1DELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699381; c=relaxed/simple;
	bh=SQwem6jnwkP8NZ/9EuvRsGPGmzWiebBGQJLusYBcwVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmUqlZ2xTxf/8vev3ctm6/VvxdG0/ykssUHb7qYP5aufCQ8M89zclcozCUugm6GGnmD2Rf7ZQx8dAGADnlOT+DjAJ2w8jvE9YWBm7p7jZ0j3EqdMEG6lmlbpBk8XUemTdCzaS+Pi/MSbb5k6kRf+GdyrBUn3dIuu1dVKglFwl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNmTDwLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C6FC2BC9E;
	Mon, 16 Mar 2026 22:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773699380;
	bh=SQwem6jnwkP8NZ/9EuvRsGPGmzWiebBGQJLusYBcwVg=;
	h=From:To:Cc:Subject:Date:From;
	b=WNmTDwLjP4Oe0vjBOY2/D6PwH9i1r0roDAvKWznUTBN3/qNedQ0VvEzod1nxBBE8N
	 wVtXc/3gkLRfs9TV+Q8LM/4X9uMJKrdyjlp0c9QKT6Mcrgpz2DoOEnJXZ32iHyMar1
	 G71R8knOnms6g8uBSAVZalDpauwqjQJVdIOufxX5x0EYep+ygf6u4emQSoo8isQbai
	 GWjFXBMIWp5swuzsAdcJMaebO5G2fWr0pjcbyJrIkyScDsF8mPNEgZr1iA/fX4FBMV
	 SpUiMUaS2pWKYrB0dMsddSH0YDLk7yunAnSKugHRAO2TAOQ/KFP+LPZOgyVcrN749W
	 fFu3WYuCgfuAA==
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next] qed: Reimplement qed_mcast_bin_from_mac() using library functions
Date: Mon, 16 Mar 2026 15:14:53 -0700
Message-ID: <20260316221453.66078-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268293-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 328D42A1657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The calculation done by qed_calc_crc32c() is the standard
least-significant-bit-first CRC-32C except it uses
most-significant-bit-first order for the actual CRC variable.  That is
equivalent to bit-reflecting the input and output CRC.  Replace it with
equivalent calls to the corresponding library functions.

Tested with a simple userspace program which tested that the old and new
implementations of qed_mcast_bin_from_mac() produce the same outputs.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c | 53 +++++-------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 0f6905e33df6..2d873a596261 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -5,10 +5,11 @@
  */
 
 #include <linux/types.h>
 #include <asm/byteorder.h>
 #include <asm/param.h>
+#include <linux/crc32.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -37,11 +38,10 @@
 #include "qed_reg_addr.h"
 #include "qed_sp.h"
 #include "qed_sriov.h"
 
 #define QED_MAX_SGES_NUM 16
-#define CRC32_POLY 0x1edc6f41
 
 struct qed_l2_info {
 	u32 queues;
 	unsigned long **pp_qid_usage;
 
@@ -1410,54 +1410,23 @@ int qed_sp_eth_filter_ucast(struct qed_hwfn *p_hwfn,
 		   p_filter_cmd->vlan);
 
 	return 0;
 }
 
-/*******************************************************************************
- * Description:
- *         Calculates crc 32 on a buffer
- *         Note: crc32_length MUST be aligned to 8
- * Return:
- ******************************************************************************/
-static u32 qed_calc_crc32c(u8 *crc32_packet,
-			   u32 crc32_length, u32 crc32_seed, u8 complement)
-{
-	u32 byte = 0, bit = 0, crc32_result = crc32_seed;
-	u8 msb = 0, current_byte = 0;
-
-	if ((!crc32_packet) ||
-	    (crc32_length == 0) ||
-	    ((crc32_length % 8) != 0))
-		return crc32_result;
-	for (byte = 0; byte < crc32_length; byte++) {
-		current_byte = crc32_packet[byte];
-		for (bit = 0; bit < 8; bit++) {
-			msb = (u8)(crc32_result >> 31);
-			crc32_result = crc32_result << 1;
-			if (msb != (0x1 & (current_byte >> bit))) {
-				crc32_result = crc32_result ^ CRC32_POLY;
-				crc32_result |= 1; /*crc32_result[0] = 1;*/
-			}
-		}
-	}
-	return crc32_result;
-}
-
-static u32 qed_crc32c_le(u32 seed, u8 *mac, u32 len)
-{
-	u32 packet_buf[2] = { 0 };
-
-	memcpy((u8 *)(&packet_buf[0]), &mac[0], 6);
-	return qed_calc_crc32c((u8 *)packet_buf, 8, seed, 0);
-}
-
 u8 qed_mcast_bin_from_mac(u8 *mac)
 {
-	u32 crc = qed_crc32c_le(ETH_MULTICAST_BIN_FROM_MAC_SEED,
-				mac, ETH_ALEN);
+	u8 padded_mac[8] = {};
+	u32 crc;
 
-	return crc & 0xff;
+	memcpy(padded_mac, mac, ETH_ALEN);
+	/*
+	 * This uses the standard CRC-32C, but with the input and output CRCs
+	 * bit-reflected and the bit-reflected output CRC truncated to 8 bits.
+	 */
+	crc = crc32c(bitrev32(ETH_MULTICAST_BIN_FROM_MAC_SEED), padded_mac,
+		     sizeof(padded_mac));
+	return bitrev8(crc >> 24);
 }
 
 static int
 qed_sp_eth_filter_mcast(struct qed_hwfn *p_hwfn,
 			u16 opaque_fid,

base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
-- 
2.53.0


