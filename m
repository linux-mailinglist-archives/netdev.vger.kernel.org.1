Return-Path: <netdev+bounces-304943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZjoKDdWCS2qjSgEAu9opvQ
	(envelope-from <netdev+bounces-304943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C370F239
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:26:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304943-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304943-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8753278E32
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C9E41DEC4;
	Mon,  6 Jul 2026 09:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0A41737F;
	Mon,  6 Jul 2026 09:36:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330576; cv=none; b=XitwKyOSs8uRyCqmENr417ftXuYgxUlcQPgk0T2ILeYk28a1nXHyVvUt4RxPaHc8PtpfQHamrk0WiHM0pDp2wMU/5cVWhFqt/2DFxvtnNTJiM38MYZr+ZPYAsgvYXqTYS2RJZTiZyP8FQJJmcQDmYHKwObo7w2DBYcZReuAE4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330576; c=relaxed/simple;
	bh=PYYRvH1dgOxxiEVlhMI1AbBTjbuhgaa8i1Hz7Vtb9t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3F0/GxgMnP5Skmn3PmIfyADIcoBgY6X6lD2VhatiTK+p92d92KzSvUClek+SLl02RGavsfytY8uP39Tl4r3Px/noFKRGQ5YGeZbCfew06H3yz/McPAV165vcLagpPR38ccwL3xa7dPtdF8pCvZh9co0jBfW/UR6FohV0FPFZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowAAnxs4Bd0tqi5nxBA--.35395S2;
	Mon, 06 Jul 2026 17:36:02 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Shahed Shaikh <shshaikh@marvell.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: qlcnic: validate unified ROM directory bounds
Date: Mon,  6 Jul 2026 17:36:01 +0800
Message-ID: <20260706093601.81535-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnxs4Bd0tqi5nxBA--.35395S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF43Xw47ZrWxXF15CFW5trb_yoWfCFWDpF
	98GFyxtr4YvF4aqw48Jw1vyFZxua9xtrWkKFyj93s3tFs7Grn29Fn8trWFkry8ArWDCr1r
	Aan0ga15Zr47Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shshaikh@marvell.com,m:pengpeng@iscas.ac.cn,m:manishc@marvell.com,m:GR-Linux-NIC-Dev@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 945C370F239

The unified ROM parser walks directory and data descriptor tables from the
firmware file. The existing checks compute table and data limits with
base + count * size or base + size before comparing with the firmware
size. Those calculations use fields from the firmware image and can wrap
before the comparison.

Add range helpers that validate tables and entries with division and
subtraction instead of overflowing additions. Pass the firmware size into
the directory lookup helper, validate each directory entry before reading
its type field, and validate bootloader, firmware and product-table
entries before their descriptor fields are used.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../net/ethernet/qlogic/qlcnic/qlcnic_init.c  | 135 +++++++++++-------
 1 file changed, 86 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
index 9192c5ad5a16..56620aed804b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
@@ -740,21 +740,55 @@ qlcnic_has_mn(struct qlcnic_adapter *adapter)
 	return 0;
 }
 
-static
-struct uni_table_desc *qlcnic_get_table_desc(const u8 *unirom, int section)
+#define QLCNIC_UNI_DIR_TYPE_OFF		8
+#define QLCNIC_UNI_DIR_ENTRY_MIN_SIZE \
+	((QLCNIC_UNI_DIR_TYPE_OFF + 1) * sizeof(__le32))
+#define QLCNIC_UNI_PRODUCT_ENTRY_MIN_SIZE \
+	((QLCNIC_UNI_FIRMWARE_IDX_OFF + 1) * sizeof(__le32))
+
+static bool qlcnic_rom_range_valid(size_t fw_size, u32 offset, u32 len)
+{
+	return offset <= fw_size && len <= fw_size - offset;
+}
+
+static bool qlcnic_rom_table_valid(size_t size, u32 off, u32 n, u32 esz)
+{
+	if (off > size)
+		return false;
+	if (!esz)
+		return n == 0;
+
+	return n <= (size - off) / esz;
+}
+
+static bool qlcnic_rom_entry_valid(size_t size, u32 off, u32 esz, u32 idx)
+{
+	if (!esz || off > size)
+		return false;
+
+	return idx < (size - off) / esz;
+}
+
+static struct uni_table_desc *qlcnic_get_table_desc(const u8 *unirom,
+						    size_t fw_size, int section)
 {
-	u32 i, entries;
 	struct uni_table_desc *directory = (struct uni_table_desc *) &unirom[0];
-	entries = le32_to_cpu(directory->num_entries);
+	u32 entries = le32_to_cpu(directory->num_entries);
+	u32 entry_size = le32_to_cpu(directory->entry_size);
+	u32 findex = le32_to_cpu(directory->findex);
+	u32 i;
 
-	for (i = 0; i < entries; i++) {
+	if (entry_size < QLCNIC_UNI_DIR_ENTRY_MIN_SIZE ||
+	    !qlcnic_rom_table_valid(fw_size, findex, entries, entry_size))
+		return NULL;
 
-		u32 offs = le32_to_cpu(directory->findex) +
-			   i * le32_to_cpu(directory->entry_size);
-		u32 tab_type = le32_to_cpu(*((__le32 *)&unirom[offs] + 8));
+	for (i = 0; i < entries; i++) {
+		size_t offs = findex + (size_t)i * entry_size;
+		u32 tab_type = le32_to_cpu(*((__le32 *)&unirom[offs] +
+						QLCNIC_UNI_DIR_TYPE_OFF));
 
 		if (tab_type == section)
-			return (struct uni_table_desc *) &unirom[offs];
+			return (struct uni_table_desc *)&unirom[offs];
 	}
 
 	return NULL;
@@ -766,19 +800,18 @@ static int
 qlcnic_validate_header(struct qlcnic_adapter *adapter)
 {
 	const u8 *unirom = adapter->fw->data;
-	struct uni_table_desc *directory = (struct uni_table_desc *) &unirom[0];
-	u32 entries, entry_size, tab_size, fw_file_size;
-
-	fw_file_size = adapter->fw->size;
+	struct uni_table_desc *directory = (struct uni_table_desc *)&unirom[0];
+	u32 fw_file_size = adapter->fw->size;
+	u32 entries, entry_size, findex;
 
 	if (fw_file_size < FILEHEADER_SIZE)
 		return -EINVAL;
 
 	entries = le32_to_cpu(directory->num_entries);
 	entry_size = le32_to_cpu(directory->entry_size);
-	tab_size = le32_to_cpu(directory->findex) + (entries * entry_size);
+	findex = le32_to_cpu(directory->findex);
 
-	if (fw_file_size < tab_size)
+	if (!qlcnic_rom_table_valid(fw_file_size, findex, entries, entry_size))
 		return -EINVAL;
 
 	return 0;
@@ -789,31 +822,33 @@ qlcnic_validate_bootld(struct qlcnic_adapter *adapter)
 {
 	struct uni_table_desc *tab_desc;
 	struct uni_data_desc *descr;
-	u32 offs, tab_size, data_size, idx;
 	const u8 *unirom = adapter->fw->data;
+	size_t offs;
+	u32 data_len, data_off, entry_size, findex, idx;
 	__le32 temp;
 
 	temp = *((__le32 *)&unirom[adapter->file_prd_off] +
 		 QLCNIC_UNI_BOOTLD_IDX_OFF);
 	idx = le32_to_cpu(temp);
-	tab_desc = qlcnic_get_table_desc(unirom, QLCNIC_UNI_DIR_SECT_BOOTLD);
+	tab_desc = qlcnic_get_table_desc(unirom, adapter->fw->size,
+					 QLCNIC_UNI_DIR_SECT_BOOTLD);
 
 	if (!tab_desc)
 		return -EINVAL;
 
-	tab_size = le32_to_cpu(tab_desc->findex) +
-		   le32_to_cpu(tab_desc->entry_size) * (idx + 1);
-
-	if (adapter->fw->size < tab_size)
+	entry_size = le32_to_cpu(tab_desc->entry_size);
+	findex = le32_to_cpu(tab_desc->findex);
+	if (entry_size < sizeof(*descr) ||
+	    !qlcnic_rom_entry_valid(adapter->fw->size, findex, entry_size,
+				     idx))
 		return -EINVAL;
 
-	offs = le32_to_cpu(tab_desc->findex) +
-	       le32_to_cpu(tab_desc->entry_size) * idx;
+	offs = findex + (size_t)entry_size * idx;
 	descr = (struct uni_data_desc *)&unirom[offs];
+	data_off = le32_to_cpu(descr->findex);
+	data_len = le32_to_cpu(descr->size);
 
-	data_size = le32_to_cpu(descr->findex) + le32_to_cpu(descr->size);
-
-	if (adapter->fw->size < data_size)
+	if (!qlcnic_rom_range_valid(adapter->fw->size, data_off, data_len))
 		return -EINVAL;
 
 	return 0;
@@ -825,29 +860,31 @@ qlcnic_validate_fw(struct qlcnic_adapter *adapter)
 	struct uni_table_desc *tab_desc;
 	struct uni_data_desc *descr;
 	const u8 *unirom = adapter->fw->data;
-	u32 offs, tab_size, data_size, idx;
+	size_t offs;
+	u32 data_len, data_off, entry_size, findex, idx;
 	__le32 temp;
 
 	temp = *((__le32 *)&unirom[adapter->file_prd_off] +
 		 QLCNIC_UNI_FIRMWARE_IDX_OFF);
 	idx = le32_to_cpu(temp);
-	tab_desc = qlcnic_get_table_desc(unirom, QLCNIC_UNI_DIR_SECT_FW);
+	tab_desc = qlcnic_get_table_desc(unirom, adapter->fw->size,
+					 QLCNIC_UNI_DIR_SECT_FW);
 
 	if (!tab_desc)
 		return -EINVAL;
 
-	tab_size = le32_to_cpu(tab_desc->findex) +
-		   le32_to_cpu(tab_desc->entry_size) * (idx + 1);
-
-	if (adapter->fw->size < tab_size)
+	entry_size = le32_to_cpu(tab_desc->entry_size);
+	findex = le32_to_cpu(tab_desc->findex);
+	if (entry_size < sizeof(*descr) ||
+	    !qlcnic_rom_entry_valid(adapter->fw->size, findex, entry_size,
+				     idx))
 		return -EINVAL;
 
-	offs = le32_to_cpu(tab_desc->findex) +
-	       le32_to_cpu(tab_desc->entry_size) * idx;
+	offs = findex + (size_t)entry_size * idx;
 	descr = (struct uni_data_desc *)&unirom[offs];
-	data_size = le32_to_cpu(descr->findex) + le32_to_cpu(descr->size);
-
-	if (adapter->fw->size < data_size)
+	data_off = le32_to_cpu(descr->findex);
+	data_len = le32_to_cpu(descr->size);
+	if (!qlcnic_rom_range_valid(adapter->fw->size, data_off, data_len))
 		return -EINVAL;
 
 	return 0;
@@ -859,30 +896,30 @@ qlcnic_validate_product_offs(struct qlcnic_adapter *adapter)
 	struct uni_table_desc *ptab_descr;
 	const u8 *unirom = adapter->fw->data;
 	int mn_present = qlcnic_has_mn(adapter);
-	u32 entries, entry_size, tab_size, i;
+	u32 entries, entry_size, findex, i;
+	u32 section = QLCNIC_UNI_DIR_SECT_PRODUCT_TBL;
 	__le32 temp;
 
-	ptab_descr = qlcnic_get_table_desc(unirom,
-				QLCNIC_UNI_DIR_SECT_PRODUCT_TBL);
+	ptab_descr = qlcnic_get_table_desc(unirom, adapter->fw->size, section);
 	if (!ptab_descr)
 		return -EINVAL;
 
 	entries = le32_to_cpu(ptab_descr->num_entries);
 	entry_size = le32_to_cpu(ptab_descr->entry_size);
-	tab_size = le32_to_cpu(ptab_descr->findex) + (entries * entry_size);
-
-	if (adapter->fw->size < tab_size)
+	findex = le32_to_cpu(ptab_descr->findex);
+	if (entry_size < QLCNIC_UNI_PRODUCT_ENTRY_MIN_SIZE ||
+	    !qlcnic_rom_table_valid(adapter->fw->size, findex, entries,
+				     entry_size))
 		return -EINVAL;
 
 nomn:
 	for (i = 0; i < entries; i++) {
-
-		u32 flags, file_chiprev, offs;
+		size_t offs;
+		u32 flags, file_chiprev;
 		u8 chiprev = adapter->ahw->revision_id;
 		u32 flagbit;
 
-		offs = le32_to_cpu(ptab_descr->findex) +
-		       i * le32_to_cpu(ptab_descr->entry_size);
+		offs = findex + (size_t)i * entry_size;
 		temp = *((__le32 *)&unirom[offs] + QLCNIC_UNI_FLAGS_OFF);
 		flags = le32_to_cpu(temp);
 		temp = *((__le32 *)&unirom[offs] + QLCNIC_UNI_CHIP_REV_OFF);
@@ -891,7 +928,7 @@ qlcnic_validate_product_offs(struct qlcnic_adapter *adapter)
 		flagbit = mn_present ? 1 : 2;
 
 		if ((chiprev == file_chiprev) &&
-					((1ULL << flagbit) & flags)) {
+		    ((1ULL << flagbit) & flags)) {
 			adapter->file_prd_off = offs;
 			return 0;
 		}
@@ -945,7 +982,7 @@ struct uni_data_desc *qlcnic_get_data_desc(struct qlcnic_adapter *adapter,
 	temp = *((__le32 *)&unirom[adapter->file_prd_off] + idx_offset);
 	idx = le32_to_cpu(temp);
 
-	tab_desc = qlcnic_get_table_desc(unirom, section);
+	tab_desc = qlcnic_get_table_desc(unirom, adapter->fw->size, section);
 
 	if (tab_desc == NULL)
 		return NULL;
-- 
2.43.0


