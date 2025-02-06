Return-Path: <netdev+bounces-163714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB764A2B6D9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F523A76D0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A123AE65;
	Thu,  6 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXj+W3tI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993123AE89
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886021; cv=none; b=NfCpplc3IlmT/Mxc8c8vB9TPsw0IjUNn1ljj7JXPjMjnQvDe+my+Gt6pSAjgJqiXbi/TXvd37YJYhZmkRv8WaaKDnqMRo4L097iAoRp+7mL62j7SHIjcFABh+q+h925qqmpoxDFf5g1ZRKkQgCydbLCAUlC4k2tnXRV+FTFd88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886021; c=relaxed/simple;
	bh=gGHiYqqYVz2rY4P5/E5daKX5ZCJFlxlrxeCqfhyWFUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM0o/teUf/zSiNM08AmjbSLZHqCcHyPl+2HlF7n6Mrd+b9lwZatCMRUnHmg5aeg07RREf0t+dZv+2svjoCJUo+RcmR+EUAhHfgayfjnijp1uETGVcV+nGavSGlL8AtwsFhI9dk9dSB98AHcxj0Gt9AgqGhRcihiCza+qCuSjtU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXj+W3tI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB051C4CEE8;
	Thu,  6 Feb 2025 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886021;
	bh=gGHiYqqYVz2rY4P5/E5daKX5ZCJFlxlrxeCqfhyWFUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXj+W3tIg3Y1Va/qNPyUjzJQLSMOjEDqjOiuNsB3Y0GRoOrenQ2BT0P07raqtokSY
	 VUacz8do492TAyPziI62e46nwdUJCyR2ugY1YWN3gAiSSQpGwA/arvPMSJ/masuo5A
	 EAkP7sm/HsJb8n1hvGFvWGT6oKudqVleOKNKClsY7adQA6xNpNI3VihJdjxu2a2W9G
	 N9dbgTQyf4ECCq2a83QAgbkN6TJ2e3jPTASC43IjCJ/4HS1azMAqMMmryx4e8jGfkd
	 gI2v0JAAq8HuZUB6yb83me3fCaimAZ3EEh+cLm5/6G71K1RTNVnov05FxLbOLYp14K
	 R6cqA1Asv/R7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/7] eth: fbnic: add IP TCAM programming
Date: Thu,  6 Feb 2025 15:53:31 -0800
Message-ID: <20250206235334.1425329-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@fb.com>

IPv6 addresses are huge so the device has 4 TCAMs used for narrowing
them down to a smaller key before the main match / action engine.

Add the tables in which we'll keep the IP addresses used by
ethtool n-tuple rules. Add the code for programming them
into the device, and code for allocating and freeing entries.

A bit of copy / paste here as we need to support IPv4 and
IPv6 in the same tables, and there is four of them.
But it makes the code easier to match up with the device.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h     |   6 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h |  26 ++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c | 354 ++++++++++++++++++++
 4 files changed, 389 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 14751f16e125..37f81db1fc30 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -60,6 +60,12 @@ struct fbnic_dev {
 	u8 mac_addr_boundary;
 	u8 tce_tcam_last;
 
+	/* IP TCAM */
+	struct fbnic_ip_addr ip_src[FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES];
+	struct fbnic_ip_addr ip_dst[FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES];
+	struct fbnic_ip_addr ipo_src[FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES];
+	struct fbnic_ip_addr ipo_dst[FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES];
+
 	/* Number of TCQs/RCQs available on hardware */
 	u16 max_num_queues;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 02bb81b3c506..d5e9b11ed2f8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -677,6 +677,9 @@ enum {
 
 #define FBNIC_RPC_TCAM_OUTER_IPSRC(m, n)\
 	(0x08c00 + 0x08 * (n) + (m))		/* 0x023000 + 32*n + 4*m */
+#define FBNIC_RPC_TCAM_IP_ADDR_VALUE		CSR_GENMASK(15, 0)
+#define FBNIC_RPC_TCAM_IP_ADDR_MASK		CSR_GENMASK(31, 16)
+
 #define FBNIC_RPC_TCAM_OUTER_IPDST(m, n)\
 	(0x08c48 + 0x08 * (n) + (m))		/* 0x023120 + 32*n + 4*m */
 #define FBNIC_RPC_TCAM_IPSRC(m, n)\
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
index 0d8285fa5b45..b3515f2f5f92 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -7,6 +7,8 @@
 #include <uapi/linux/in6.h>
 #include <linux/bitfield.h>
 
+struct in_addr;
+
 /*  The TCAM state definitions follow an expected ordering.
  *  They start out disabled, then move through the following states:
  *  Disabled  0	-> Add	      2
@@ -32,6 +34,12 @@ enum {
 #define FBNIC_RPC_TCAM_MACDA_WORD_LEN		3
 #define FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES	32
 
+/* 8 IPSRC and IPDST TCAM Entries each
+ * 8 registers, Validate each
+ */
+#define FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN		8
+#define FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES	8
+
 #define FBNIC_RPC_TCAM_ACT_WORD_LEN		11
 #define FBNIC_RPC_TCAM_ACT_NUM_ENTRIES		64
 
@@ -47,6 +55,13 @@ struct fbnic_mac_addr {
 	DECLARE_BITMAP(act_tcam, FBNIC_RPC_TCAM_ACT_NUM_ENTRIES);
 };
 
+struct fbnic_ip_addr {
+	struct in6_addr mask, value;
+	unsigned char version;
+	unsigned char state;
+	DECLARE_BITMAP(act_tcam, FBNIC_RPC_TCAM_ACT_NUM_ENTRIES);
+};
+
 struct fbnic_act_tcam {
 	struct {
 		u16 tcam[FBNIC_RPC_TCAM_ACT_WORD_LEN];
@@ -177,6 +192,17 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
 void fbnic_sift_macda(struct fbnic_dev *fbd);
 void fbnic_write_macda(struct fbnic_dev *fbd);
 
+struct fbnic_ip_addr *__fbnic_ip4_sync(struct fbnic_dev *fbd,
+				       struct fbnic_ip_addr *ip_addr,
+				       const struct in_addr *addr,
+				       const struct in_addr *mask);
+struct fbnic_ip_addr *__fbnic_ip6_sync(struct fbnic_dev *fbd,
+				       struct fbnic_ip_addr *ip_addr,
+				       const struct in6_addr *addr,
+				       const struct in6_addr *mask);
+int __fbnic_ip_unsync(struct fbnic_ip_addr *ip_addr, unsigned int tcam_idx);
+void fbnic_write_ip_addr(struct fbnic_dev *fbd);
+
 static inline int __fbnic_uc_unsync(struct fbnic_mac_addr *mac_addr)
 {
 	return __fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_UNICAST);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index c25bd300b902..be06f43e51e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -3,6 +3,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <net/ipv6.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
@@ -698,6 +699,359 @@ void fbnic_write_tce_tcam(struct fbnic_dev *fbd)
 		__fbnic_write_tce_tcam(fbd);
 }
 
+struct fbnic_ip_addr *__fbnic_ip4_sync(struct fbnic_dev *fbd,
+				       struct fbnic_ip_addr *ip_addr,
+				       const struct in_addr *addr,
+				       const struct in_addr *mask)
+{
+	struct fbnic_ip_addr *avail_addr = NULL;
+	unsigned int i;
+
+	/* Scan from top of list to bottom, filling bottom up. */
+	for (i = 0; i < FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES; i++, ip_addr++) {
+		struct in6_addr *m = &ip_addr->mask;
+
+		if (ip_addr->state == FBNIC_TCAM_S_DISABLED) {
+			avail_addr = ip_addr;
+			continue;
+		}
+
+		if (ip_addr->version != 4)
+			continue;
+
+		/* Drop avail_addr if mask is a subset of our current mask,
+		 * This prevents us from inserting a longer prefix behind a
+		 * shorter one.
+		 *
+		 * The mask is stored inverted value so as an example:
+		 * m	ffff ffff ffff ffff ffff ffff ffff 0000 0000
+		 * mask 0000 0000 0000 0000 0000 0000 0000 ffff ffff
+		 *
+		 * "m" and "mask" represent typical IPv4 mask stored in
+		 * the TCAM and those provided by the stack. The code below
+		 * should return a non-zero result if there is a 0 stored
+		 * anywhere in "m" where "mask" has a 0.
+		 */
+		if (~m->s6_addr32[3] & ~mask->s_addr) {
+			avail_addr = NULL;
+			continue;
+		}
+
+		/* Check to see if the mask actually contains fewer bits than
+		 * our new mask "m". The XOR below should only result in 0 if
+		 * "m" is masking a bit that we are looking for in our new
+		 * "mask", we eliminated the 0^0 case with the check above.
+		 *
+		 * If it contains fewer bits we need to stop here, otherwise
+		 * we might be adding an unreachable rule.
+		 */
+		if (~(m->s6_addr32[3] ^ mask->s_addr))
+			break;
+
+		if (ip_addr->value.s6_addr32[3] == addr->s_addr) {
+			avail_addr = ip_addr;
+			break;
+		}
+	}
+
+	if (avail_addr && avail_addr->state == FBNIC_TCAM_S_DISABLED) {
+		ipv6_addr_set(&avail_addr->value, 0, 0, 0, addr->s_addr);
+		ipv6_addr_set(&avail_addr->mask, htonl(~0), htonl(~0),
+			      htonl(~0), ~mask->s_addr);
+		avail_addr->version = 4;
+
+		avail_addr->state = FBNIC_TCAM_S_ADD;
+	}
+
+	return avail_addr;
+}
+
+struct fbnic_ip_addr *__fbnic_ip6_sync(struct fbnic_dev *fbd,
+				       struct fbnic_ip_addr *ip_addr,
+				       const struct in6_addr *addr,
+				       const struct in6_addr *mask)
+{
+	struct fbnic_ip_addr *avail_addr = NULL;
+	unsigned int i;
+
+	ip_addr = &ip_addr[FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES - 1];
+
+	/* Scan from bottom of list to top, filling top down. */
+	for (i = FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES; i--; ip_addr--) {
+		struct in6_addr *m = &ip_addr->mask;
+
+		if (ip_addr->state == FBNIC_TCAM_S_DISABLED) {
+			avail_addr = ip_addr;
+			continue;
+		}
+
+		if (ip_addr->version != 6)
+			continue;
+
+		/* Drop avail_addr if mask is a superset of our current mask.
+		 * This prevents us from inserting a longer prefix behind a
+		 * shorter one.
+		 *
+		 * The mask is stored inverted value so as an example:
+		 * m	0000 0000 0000 0000 0000 0000 0000 0000 0000
+		 * mask ffff ffff ffff ffff ffff ffff ffff ffff ffff
+		 *
+		 * "m" and "mask" represent typical IPv6 mask stored in
+		 * the TCAM and those provided by the stack. The code below
+		 * should return a non-zero result which will cause us
+		 * to drop the avail_addr value that might be cached
+		 * to prevent us from dropping a v6 address behind it.
+		 */
+		if ((m->s6_addr32[0] & mask->s6_addr32[0]) |
+		    (m->s6_addr32[1] & mask->s6_addr32[1]) |
+		    (m->s6_addr32[2] & mask->s6_addr32[2]) |
+		    (m->s6_addr32[3] & mask->s6_addr32[3])) {
+			avail_addr = NULL;
+			continue;
+		}
+
+		/* The previous test eliminated any overlap between the
+		 * two values so now we need to check for gaps.
+		 *
+		 * If the mask is equal to our current mask then it should
+		 * result with m ^ mask = ffff ffff, if however the value
+		 * stored in m is bigger then we should see a 0 appear
+		 * somewhere in the mask.
+		 */
+		if (~(m->s6_addr32[0] ^ mask->s6_addr32[0]) |
+		    ~(m->s6_addr32[1] ^ mask->s6_addr32[1]) |
+		    ~(m->s6_addr32[2] ^ mask->s6_addr32[2]) |
+		    ~(m->s6_addr32[3] ^ mask->s6_addr32[3]))
+			break;
+
+		if (ipv6_addr_cmp(&ip_addr->value, addr))
+			continue;
+
+		avail_addr = ip_addr;
+		break;
+	}
+
+	if (avail_addr && avail_addr->state == FBNIC_TCAM_S_DISABLED) {
+		memcpy(&avail_addr->value, addr, sizeof(*addr));
+		ipv6_addr_set(&avail_addr->mask,
+			      ~mask->s6_addr32[0], ~mask->s6_addr32[1],
+			      ~mask->s6_addr32[2], ~mask->s6_addr32[3]);
+		avail_addr->version = 6;
+
+		avail_addr->state = FBNIC_TCAM_S_ADD;
+	}
+
+	return avail_addr;
+}
+
+int __fbnic_ip_unsync(struct fbnic_ip_addr *ip_addr, unsigned int tcam_idx)
+{
+	if (!test_and_clear_bit(tcam_idx, ip_addr->act_tcam))
+		return -ENOENT;
+
+	if (bitmap_empty(ip_addr->act_tcam, FBNIC_RPC_TCAM_ACT_NUM_ENTRIES))
+		ip_addr->state = FBNIC_TCAM_S_DELETE;
+
+	return 0;
+}
+
+static void fbnic_clear_ip_src_entry(struct fbnic_dev *fbd, unsigned int idx)
+{
+	int i;
+
+	/* Invalidate entry and clear addr state info */
+	for (i = 0; i <= FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_IPSRC(idx, i), 0);
+}
+
+static void fbnic_clear_ip_dst_entry(struct fbnic_dev *fbd, unsigned int idx)
+{
+	int i;
+
+	/* Invalidate entry and clear addr state info */
+	for (i = 0; i <= FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_IPDST(idx, i), 0);
+}
+
+static void fbnic_clear_ip_outer_src_entry(struct fbnic_dev *fbd,
+					   unsigned int idx)
+{
+	int i;
+
+	/* Invalidate entry and clear addr state info */
+	for (i = 0; i <= FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_OUTER_IPSRC(idx, i), 0);
+}
+
+static void fbnic_clear_ip_outer_dst_entry(struct fbnic_dev *fbd,
+					   unsigned int idx)
+{
+	int i;
+
+	/* Invalidate entry and clear addr state info */
+	for (i = 0; i <= FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_OUTER_IPDST(idx, i), 0);
+}
+
+static void fbnic_write_ip_src_entry(struct fbnic_dev *fbd, unsigned int idx,
+				     struct fbnic_ip_addr *ip_addr)
+{
+	__be16 *mask, *value;
+	int i;
+
+	mask = &ip_addr->mask.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+	value = &ip_addr->value.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+
+	for (i = 0; i < FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_IPSRC(idx, i),
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_MASK, ntohs(*mask--)) |
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_VALUE, ntohs(*value--)));
+	wrfl(fbd);
+
+	/* Bit 129 is used to flag for v4/v6 */
+	wr32(fbd, FBNIC_RPC_TCAM_IPSRC(idx, i),
+	     (ip_addr->version == 6) | FBNIC_RPC_TCAM_VALIDATE);
+}
+
+static void fbnic_write_ip_dst_entry(struct fbnic_dev *fbd, unsigned int idx,
+				     struct fbnic_ip_addr *ip_addr)
+{
+	__be16 *mask, *value;
+	int i;
+
+	mask = &ip_addr->mask.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+	value = &ip_addr->value.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+
+	for (i = 0; i < FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_IPDST(idx, i),
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_MASK, ntohs(*mask--)) |
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_VALUE, ntohs(*value--)));
+	wrfl(fbd);
+
+	/* Bit 129 is used to flag for v4/v6 */
+	wr32(fbd, FBNIC_RPC_TCAM_IPDST(idx, i),
+	     (ip_addr->version == 6) | FBNIC_RPC_TCAM_VALIDATE);
+}
+
+static void fbnic_write_ip_outer_src_entry(struct fbnic_dev *fbd,
+					   unsigned int idx,
+					   struct fbnic_ip_addr *ip_addr)
+{
+	__be16 *mask, *value;
+	int i;
+
+	mask = &ip_addr->mask.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+	value = &ip_addr->value.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+
+	for (i = 0; i < FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_OUTER_IPSRC(idx, i),
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_MASK, ntohs(*mask--)) |
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_VALUE, ntohs(*value--)));
+	wrfl(fbd);
+
+	wr32(fbd, FBNIC_RPC_TCAM_OUTER_IPSRC(idx, i), FBNIC_RPC_TCAM_VALIDATE);
+}
+
+static void fbnic_write_ip_outer_dst_entry(struct fbnic_dev *fbd,
+					   unsigned int idx,
+					   struct fbnic_ip_addr *ip_addr)
+{
+	__be16 *mask, *value;
+	int i;
+
+	mask = &ip_addr->mask.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+	value = &ip_addr->value.s6_addr16[FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN - 1];
+
+	for (i = 0; i < FBNIC_RPC_TCAM_IP_ADDR_WORD_LEN; i++)
+		wr32(fbd, FBNIC_RPC_TCAM_OUTER_IPDST(idx, i),
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_MASK, ntohs(*mask--)) |
+		     FIELD_PREP(FBNIC_RPC_TCAM_IP_ADDR_VALUE, ntohs(*value--)));
+	wrfl(fbd);
+
+	wr32(fbd, FBNIC_RPC_TCAM_OUTER_IPDST(idx, i), FBNIC_RPC_TCAM_VALIDATE);
+}
+
+void fbnic_write_ip_addr(struct fbnic_dev *fbd)
+{
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->ip_src); idx--;) {
+		struct fbnic_ip_addr *ip_addr = &fbd->ip_src[idx];
+
+		/* Check if update flag is set else skip. */
+		if (!(ip_addr->state & FBNIC_TCAM_S_UPDATE))
+			continue;
+
+		/* Clear by writing 0s. */
+		if (ip_addr->state == FBNIC_TCAM_S_DELETE) {
+			/* Invalidate entry and clear addr state info */
+			fbnic_clear_ip_src_entry(fbd, idx);
+			memset(ip_addr, 0, sizeof(*ip_addr));
+
+			continue;
+		}
+
+		fbnic_write_ip_src_entry(fbd, idx, ip_addr);
+
+		ip_addr->state = FBNIC_TCAM_S_VALID;
+	}
+
+	/* Repeat process for other IP TCAMs */
+	for (idx = ARRAY_SIZE(fbd->ip_dst); idx--;) {
+		struct fbnic_ip_addr *ip_addr = &fbd->ip_dst[idx];
+
+		if (!(ip_addr->state & FBNIC_TCAM_S_UPDATE))
+			continue;
+
+		if (ip_addr->state == FBNIC_TCAM_S_DELETE) {
+			fbnic_clear_ip_dst_entry(fbd, idx);
+			memset(ip_addr, 0, sizeof(*ip_addr));
+
+			continue;
+		}
+
+		fbnic_write_ip_dst_entry(fbd, idx, ip_addr);
+
+		ip_addr->state = FBNIC_TCAM_S_VALID;
+	}
+
+	for (idx = ARRAY_SIZE(fbd->ipo_src); idx--;) {
+		struct fbnic_ip_addr *ip_addr = &fbd->ipo_src[idx];
+
+		if (!(ip_addr->state & FBNIC_TCAM_S_UPDATE))
+			continue;
+
+		if (ip_addr->state == FBNIC_TCAM_S_DELETE) {
+			fbnic_clear_ip_outer_src_entry(fbd, idx);
+			memset(ip_addr, 0, sizeof(*ip_addr));
+
+			continue;
+		}
+
+		fbnic_write_ip_outer_src_entry(fbd, idx, ip_addr);
+
+		ip_addr->state = FBNIC_TCAM_S_VALID;
+	}
+
+	for (idx = ARRAY_SIZE(fbd->ipo_dst); idx--;) {
+		struct fbnic_ip_addr *ip_addr = &fbd->ipo_dst[idx];
+
+		if (!(ip_addr->state & FBNIC_TCAM_S_UPDATE))
+			continue;
+
+		if (ip_addr->state == FBNIC_TCAM_S_DELETE) {
+			fbnic_clear_ip_outer_dst_entry(fbd, idx);
+			memset(ip_addr, 0, sizeof(*ip_addr));
+
+			continue;
+		}
+
+		fbnic_write_ip_outer_dst_entry(fbd, idx, ip_addr);
+
+		ip_addr->state = FBNIC_TCAM_S_VALID;
+	}
+}
+
 void fbnic_clear_rules(struct fbnic_dev *fbd)
 {
 	u32 dest = FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
-- 
2.48.1


