Return-Path: <netdev+bounces-300074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h80SBX1dMmpqzAUAu9opvQ
	(envelope-from <netdev+bounces-300074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:40:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D56979EF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300074-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300074-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C6C13037F5F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87446390C9F;
	Wed, 17 Jun 2026 08:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5F39021C;
	Wed, 17 Jun 2026 08:36:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685416; cv=none; b=GLCMWEGzUNtZHTrGqe6KOF1kplWSYX9pVZvzv3UycISZJlK49ON+iPgYhBWySjoh2rDjp1l2ArHGubRtyAWcuuCVIgoph22xpH/V/tzHAsfl1qLeSt9NP+GRAj4Ku7tWNfISuR4srpy5JpPIKsXswlqBZ3RjHcMinSzf70Oving=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685416; c=relaxed/simple;
	bh=nTfH5+ewCHXpM6rASxvnKpE4WBbTgXrDFVaFS4Xh3ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BfbaiNNboJJaMMB8qbi0+wPyc+E7qOnFdcWmM3/lfE9V3BKE8BcBProKMk8i7q6eA+QEyGdr4caMd0n0bQnizvQ5Yjm5frjyQoECHyRUe5x1ZQIQ7pwejgPHBVpO1pt4kjk12/yBfDmsuAwOAK/0q665FH16TSXcdlCbkZOMwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
X-QQ-mid: esmtpgz16t1781685345t69dc9a28
X-QQ-Originating-IP: +zgH81zP3sUFydcZh86q1DYttoySLfLhcH4eGAjs2pQ=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 16:35:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4930188264823947317
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net] net: rnpgbe: fix mailbox endianness handling
Date: Wed, 17 Jun 2026 16:35:31 +0800
Message-Id: <20260617083531.251119-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OBUGnm9pFasACxGGVIh3QUrSPCm25k2dTRP+xbiyc854j4HKSZTh1GJl
	v/XSBed0ZIdFSVj+LQ08jk94lw2fLKVNYqcZNiEauhDOeoRy3Nd43/I5vyYZPAf9CTz+kbR
	HmsshJo4oSoKO5fkKMMQrIJvPQ3aFkZzXSN3M8TqY5N1e/oA5LmP1Dqca/384MX5IUHM1aF
	yrVxkHCv9alZXCGZYTVsGtDIjJDUWHDa3m9rV4YmZHFOlbYP9gptqkSyj3OC1S6vVfFO83X
	WC9S3ZKAPk5giJLjv4ZU1eDpmWDLMgpnHvpgGfjYbdX2TFnIt3cIcbdQYYNzWN1rzJ6Osv5
	VME+5T1R2QoAVuDVxmvxaOXcq2EhtkPIz47Hvnvu+2VMxRjc6NjylVln0crsbc9LI25HF6s
	28xGQ7RLiZc5HAwghUtJO+2yYNFuChjzeAHlXQ5wRfnT5d1jrUo9DId5KWwPjJjl9mq7UV3
	4JJTmZ0bI5qK9CdTB3Dg/oBnBx/oAwaULIlnabP83nV63eRinIEpg9kQ5efq6H4LzJM5fc9
	qtImimt1isnTI2bOIMGyLSCIP8pxFC5VqumA53uE6JkJpIaMijVLGq0tqpt99v39mHYj+tc
	xuSJmq49hxdP45RldOHzZEAMGg5Ma+ZDLral6oM8m/W3Ctlg19t3cuZDlGBLVhIGr75kTSp
	VSa7Ddj6U7POEF4Ep4ZRJPT/x5KmuFbW1yXeFbN+J16O8BjfArHkv8m4iEfyFe5serw6OeM
	hQ5CH+d1WweJea2oczUW2aQsszB0XA7WgvVSg37c12u9FfHmox7OGdPD9dl7KKb1C93mebc
	JNnMJNR3gcfIb5jwUSQAyYTEn8G5wWSmVxSvsVrQRa9RSUTDXekkVuk/1TdYCF7jiKT+cde
	E0pOzi7AeGltsuS/jxlIAfwHir6o4oGY6UbvZ9sjzBc6QdTdHXVmHt3Hor8c1C2tngearDi
	DTYXLEII9b68BpzD0/r0PbZFseTcmovabr286ULW3J6u0S2WbPbtSxXKOIprm9lFCDRLKox
	BBs1C2GEbCFOpag//cEMx3fZO9takX7C2a25Q+EQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300074-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mucse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dong100@mucse.com,m:yaojun@mucse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mucse.com:email,mucse.com:mid,mucse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE7D56979EF

Mailbox data is exchanged through 32-bit MMIO accesses but the
mailbox payload is defined using little-endian FW structures with
__le16 and __le32 fields.

The mailbox read/write helpers previously operated on raw u32
buffers without performing endian conversion. On big-endian
systems this causes mailbox payload fields to be byte-swapped in
memory, resulting in corrupted FW command and reply structures.

Convert mailbox data between CPU-endian MMIO values and the
little-endian mailbox wire format using cpu_to_le32() on reads and
le32_to_cpu() on writes.

Also switch the helper interfaces to use void */const void * since
the mailbox transport layer operates on opaque payload buffers
rather than native-endian u32 arrays.

Fixes: 4543534c3ef5 ("net: rnpgbe: Add basic mbx ops support")
Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c   | 16 ++++++++++------
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h   |  5 +++--
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c    |  7 +++----
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index de5e29230b3c..0fccfc49ffc7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -166,10 +166,12 @@ static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
  *
  * Return: 0 on success, negative errno on failure
  **/
-static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+static int mucse_read_mbx_pf(struct mucse_hw *hw, void *msg, u16 size)
 {
 	const int size_in_words = size / sizeof(u32);
 	struct mucse_mbx_info *mbx = &hw->mbx;
+	int off = MUCSE_MBX_FWPF_SHM;
+	__le32 *msg_le32 = msg;
 	int err;
 
 	err = mucse_obtain_mbx_lock_pf(hw);
@@ -177,7 +179,7 @@ static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
 		return err;
 
 	for (int i = 0; i < size_in_words; i++)
-		msg[i] = mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);
+		msg_le32[i] = cpu_to_le32(mbx_data_rd32(mbx, off + 4 * i));
 	/* Hw needs write data_reg at last */
 	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
 	/* flush reqs as we have read this request data */
@@ -236,7 +238,7 @@ static int mucse_poll_for_msg(struct mucse_hw *hw)
  * Return: 0 if it successfully received a message notification and
  * copied it into the receive buffer, negative errno on failure
  **/
-int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, void *msg, u16 size)
 {
 	int err;
 
@@ -290,10 +292,11 @@ static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
  * Return: 0 if it successfully copied message into the buffer,
  * negative errno on failure
  **/
-static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+static int mucse_write_mbx_pf(struct mucse_hw *hw, const void *msg, u16 size)
 {
 	const int size_in_words = size / sizeof(u32);
 	struct mucse_mbx_info *mbx = &hw->mbx;
+	const __le32 *msg_le32 = msg;
 	int err;
 
 	err = mucse_obtain_mbx_lock_pf(hw);
@@ -301,7 +304,8 @@ static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
 		return err;
 
 	for (int i = 0; i < size_in_words; i++)
-		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4, msg[i]);
+		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4,
+			      le32_to_cpu(msg_le32[i]));
 
 	/* flush acks as we are overwriting the message buffer */
 	hw->mbx.fw_ack = mucse_mbx_get_fwack(mbx);
@@ -360,7 +364,7 @@ static int mucse_poll_for_ack(struct mucse_hw *hw)
  * Return: 0 if it successfully copied message into the buffer and
  * received an ack to that message within delay * timeout_cnt period
  **/
-int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, const void *msg, u16 size)
 {
 	int err;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index e6fcc8d1d3ca..25bfc97c24c0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -14,7 +14,8 @@
 #define MUCSE_MBX_REQ             BIT(0) /* Request a req to mailbox */
 #define MUCSE_MBX_PFU             BIT(3) /* PF owns the mailbox buffer */
 
-int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw,
+				 const void *msg, u16 size);
 void mucse_init_mbx_params_pf(struct mucse_hw *hw);
-int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, void *msg, u16 size);
 #endif /* _RNPGBE_MBX_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 8c8bd5e8e1db..2ac97915a098 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -28,12 +28,11 @@ static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
 	int err;
 
 	mutex_lock(&hw->mbx.lock);
-	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)req, len);
+	err = mucse_write_and_wait_ack_mbx(hw, req, len);
 	if (err)
 		goto out;
 	do {
-		err = mucse_poll_and_read_mbx(hw, (u32 *)reply,
-					      sizeof(*reply));
+		err = mucse_poll_and_read_mbx(hw, reply, sizeof(*reply));
 		if (err)
 			goto out;
 		/* mucse_write_and_wait_ack_mbx return 0 means fw has
@@ -125,7 +124,7 @@ int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup)
 
 	len = le16_to_cpu(req.datalen);
 	mutex_lock(&hw->mbx.lock);
-	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)&req, len);
+	err = mucse_write_and_wait_ack_mbx(hw, &req, len);
 	mutex_unlock(&hw->mbx.lock);
 
 	return err;
-- 
2.25.1


