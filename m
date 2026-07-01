Return-Path: <netdev+bounces-303455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Coz9KTaIRGrkwQoAu9opvQ
	(envelope-from <netdev+bounces-303455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815466E9729
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:23:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303455-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303455-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 716B6304A5C6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93561367B9C;
	Wed,  1 Jul 2026 03:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275718A6DB;
	Wed,  1 Jul 2026 03:23:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876204; cv=none; b=oZDA+yOJpSfwqEWIVdztbt9Exv30OAPzRmtej1Oxy5zurEyJE958crigxsdn3GQRNszcDs0sE+Mb4mN6rBzoMt7BzHQ11ThMGe78lJWjbstYzU25Kdq2/dCnkcHjCwCKMM4ftLK5QYFXtlLlVL3tbuzYvOjiUtxzuIRQul3+tDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876204; c=relaxed/simple;
	bh=YIkx412ukGsyeiknlUOomFtNz2m0t+vnqRbytvzoFPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1ZbAPz5A/U6u9U/dx3u2Y0GgmW2ZPe3MamD8Qm2thZSqFu9J9LYj769ookdrfrNQkjDBfV14WjIy/cv+kMadwQAWrItZo5KVOYmMnhqeLNd8QFwab47tNeQDmaIE/A+J/PMHx7nKG49pBMo2zzu4MidT6pf2Ej7Jok+C3s8rwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
X-QQ-mid: zesmtpgz3t1782876140ta2974457
X-QQ-Originating-IP: dBp8lPY2HLwO54EdkuxlPVmcPsCwPxHUjz0qHxzTfy8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 11:22:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1755292500882742056
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
Subject: [PATCH net-next v2 1/1] net: rnpgbe: fix mailbox endianness and remove pointer casts
Date: Wed,  1 Jul 2026 11:22:08 +0800
Message-Id: <20260701032208.1843156-2-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701032208.1843156-1-dong100@mucse.com>
References: <20260701032208.1843156-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N0KzlZmgpbsAQlQH2INcXfJq7bFgWrjYhirHEpqXYHEyeMXIKfThyHrq
	IuVjifsC80UHVha/fi3yBapADFKO7zQEFjgQ0ukoZx9uyHbMLKBMaC5jwfw20LDQGM8NZxn
	OeB94/09bnKmmUtYYnXqqXY240z52VpZKZ5T7fRVQPlRCO5JRVO9DqORlb1fGihMmW4WiQS
	GX2Awe/pdIoBkana68JlCOXbF5d97I9Da0i9jQzFEDbC09Pnkh+S0NyClhqQGnK4PXMoWpt
	qSblG5yobV1ISRMFX6KhJOkMiTnehSfmXUTmj/yTomIWKqCckV3iuoFjQgFgvzHMWguF3pp
	JimBwh7lBz4wHI0Q1qzjg+3or/1ay54VVXIvZUBPfi5D+lzS2hkyK9j8S2zkv1J+xpJGzjF
	xcw+ZM2gE2GlymXfywbAYIRvDxnPWIAqdQGlYCf8Bt+c/taJC2A19dC9dxXeuDS+CTQ+pVK
	6svVCA4Nx9oJrKVwsh+CG4vEQjQWzZ6On+haLLrasMJv1uLaczLpS00SF/NRtgGy0iSnkB/
	yalAuC4ril3IBDivX/gJgFIAwzK5ydMjTrw6QyDfdwpXy1gYc2o/HbfSWdSAIcI/TgPSTZX
	O2hUwUnB7doHGfhPmWJGa6sEULM0ZFsS7DLikZpm3BSSNrn5GN9FXrvcq5AaN+jZkxI4whW
	Maxwm24LMvymdHQ0cs2Li8Rgq6yPsitns5mICTHowQeKNrHe3Y3V6ArXRh49ypJWC5S9yZ2
	bReU9XxmWlnECBc9/7TjBdtNxQJPZ0LriwnZgvOXE1LimMbT+qfnVJ3osaIbQTPnv2qi5f3
	ojXeMoLsO58BajFmv2hEua5nvy7X1X84a84azGGqh4702BbNzLONVZSfBGARc6YHA0dkDi9
	D8GNOTPWkyD8EOk//LCUzn2NJYS9xg7XkzZDxzIqTioB9tL12O1ApR5MjMRk8iAMahiKrDw
	xp/6hjXRzQkYwQb8ad2n4Nhp7bVM086rWtJJCNmC7X4jjW2Yp94Q2PnR8e6dynNAPU5lp2v
	IfDULBKAffsT/orjkzd2Ye1ejnAQpUPBIfBgXzQ71tQHfEynpNDN2dyAvWepA56S2L2Fb1S
	KS+bj4YzZQp
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303455-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 815466E9729

The rnpgbe mailbox exchanges data through 32-bit MMIO registers in
little-endian wire format. The original code had two problems:

  1. FW structs (with __le16/__le32 fields) were cast to (u32 *)
     before reaching the mailbox transport, hiding the endian
     annotations from sparse.

  2. No cpu_to_le32()/le32_to_cpu() conversion was done between
     CPU-endian MMIO values and the little-endian payload, causing
     data corruption on big-endian systems.

Fix by adding the missing byte-order conversions in the transport
layer and introducing union wrappers (mbx_fw_cmd_req_u,
mbx_fw_cmd_reply_u) that overlay each FW struct with a __le32
dwords[] array. Callers fill named fields using cpu_to_le16/32(),
then pass dwords[] to the transport, which now takes explicit
__le32 * instead of u32 *. This eliminates all pointer casts on
the mailbox data path and lets sparse verify the conversions.

Fixes: 4543534c3ef5 ("net: rnpgbe: Add basic mbx ops support")
Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 26 ++++--
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  5 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 82 ++++++++++---------
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 14 ++++
 4 files changed, 80 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index de5e29230b3c..c46408698263 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -166,18 +166,23 @@ static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
  *
  * Return: 0 on success, negative errno on failure
  **/
-static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+static int mucse_read_mbx_pf(struct mucse_hw *hw, __le32 *msg, u16 size)
 {
-	const int size_in_words = size / sizeof(u32);
+	const int size_in_words = size / sizeof(__le32);
 	struct mucse_mbx_info *mbx = &hw->mbx;
+	int off = MUCSE_MBX_FWPF_SHM;
 	int err;
 
 	err = mucse_obtain_mbx_lock_pf(hw);
 	if (err)
 		return err;
 
+	/* memcpy_fromio() is unsuitable: the mailbox uses 32-bit MMIO
+	 * registers, not byte-addressable RAM. readl() guarantees
+	 * the required 32-bit access width.
+	 */
 	for (int i = 0; i < size_in_words; i++)
-		msg[i] = mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);
+		msg[i] = cpu_to_le32(mbx_data_rd32(mbx, off + 4 * i));
 	/* Hw needs write data_reg at last */
 	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
 	/* flush reqs as we have read this request data */
@@ -236,7 +241,7 @@ static int mucse_poll_for_msg(struct mucse_hw *hw)
  * Return: 0 if it successfully received a message notification and
  * copied it into the receive buffer, negative errno on failure
  **/
-int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size)
 {
 	int err;
 
@@ -290,9 +295,9 @@ static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
  * Return: 0 if it successfully copied message into the buffer,
  * negative errno on failure
  **/
-static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+static int mucse_write_mbx_pf(struct mucse_hw *hw, const __le32 *msg, u16 size)
 {
-	const int size_in_words = size / sizeof(u32);
+	const int size_in_words = size / sizeof(__le32);
 	struct mucse_mbx_info *mbx = &hw->mbx;
 	int err;
 
@@ -300,8 +305,12 @@ static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
 	if (err)
 		return err;
 
+	/* memcpy_toio() would decompose into arbitrary-width accesses;
+	 * the mailbox requires 32-bit MMIO writes via writel().
+	 */
 	for (int i = 0; i < size_in_words; i++)
-		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4, msg[i]);
+		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4,
+			      le32_to_cpu(msg[i]));
 
 	/* flush acks as we are overwriting the message buffer */
 	hw->mbx.fw_ack = mucse_mbx_get_fwack(mbx);
@@ -360,7 +369,8 @@ static int mucse_poll_for_ack(struct mucse_hw *hw)
  * Return: 0 if it successfully copied message into the buffer and
  * received an ack to that message within delay * timeout_cnt period
  **/
-int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, const __le32 *msg,
+				 u16 size)
 {
 	int err;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index e6fcc8d1d3ca..75b88b18b04d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -14,7 +14,8 @@
 #define MUCSE_MBX_REQ             BIT(0) /* Request a req to mailbox */
 #define MUCSE_MBX_PFU             BIT(3) /* PF owns the mailbox buffer */
 
-int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw,
+				 const __le32 *msg, u16 size);
 void mucse_init_mbx_params_pf(struct mucse_hw *hw);
-int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size);
 #endif /* _RNPGBE_MBX_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 8c8bd5e8e1db..5ba74997beac 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -20,32 +20,32 @@
  * Return: 0 on success, negative errno on failure
  **/
 static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
-				       struct mbx_fw_cmd_req *req,
-				       struct mbx_fw_cmd_reply *reply)
+				       union mbx_fw_cmd_req_u *req,
+				       union mbx_fw_cmd_reply_u *reply)
 {
-	int len = le16_to_cpu(req->datalen);
+	int len = le16_to_cpu(req->r.datalen);
 	int retry_cnt = 3;
 	int err;
 
 	mutex_lock(&hw->mbx.lock);
-	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)req, len);
+	err = mucse_write_and_wait_ack_mbx(hw, req->dwords, len);
 	if (err)
 		goto out;
 	do {
-		err = mucse_poll_and_read_mbx(hw, (u32 *)reply,
-					      sizeof(*reply));
+		err = mucse_poll_and_read_mbx(hw, reply->dwords,
+					      sizeof(reply->r));
 		if (err)
 			goto out;
 		/* mucse_write_and_wait_ack_mbx return 0 means fw has
 		 * received request, wait for the expect opcode
 		 * reply with 'retry_cnt' times.
 		 */
-	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
+	} while (--retry_cnt >= 0 && reply->r.opcode != req->r.opcode);
 out:
 	mutex_unlock(&hw->mbx.lock);
 	if (!err && retry_cnt < 0)
 		return -ETIMEDOUT;
-	if (!err && reply->error_code)
+	if (!err && reply->r.error_code)
 		return -EIO;
 
 	return err;
@@ -61,17 +61,19 @@ static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
  **/
 static int mucse_mbx_get_info(struct mucse_hw *hw)
 {
-	struct mbx_fw_cmd_req req = {
-		.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
-		.opcode  = cpu_to_le16(GET_HW_INFO),
+	union mbx_fw_cmd_req_u req = {
+		.r = {
+			.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
+			.opcode  = cpu_to_le16(GET_HW_INFO),
+		},
 	};
-	struct mbx_fw_cmd_reply reply = {};
+	union mbx_fw_cmd_reply_u reply = {};
 	int err;
 
 	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
 	if (!err)
 		hw->pfvfnum = FIELD_GET(GENMASK_U16(7, 0),
-					le16_to_cpu(reply.hw_info.pfnum));
+					le16_to_cpu(reply.r.hw_info.pfnum));
 
 	return err;
 }
@@ -111,21 +113,23 @@ int mucse_mbx_sync_fw(struct mucse_hw *hw)
  **/
 int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup)
 {
-	struct mbx_fw_cmd_req req = {
-		.datalen = cpu_to_le16(sizeof(req.powerup) +
-				       MUCSE_MBX_REQ_HDR_LEN),
-		.opcode  = cpu_to_le16(POWER_UP),
-		.powerup = {
-			/* fw needs this to reply correct cmd */
-			.version = cpu_to_le32(GENMASK_U32(31, 0)),
-			.status  = cpu_to_le32(is_powerup ? 1 : 0),
+	union mbx_fw_cmd_req_u req = {
+		.r = {
+			.datalen = cpu_to_le16(sizeof(req.r.powerup) +
+					       MUCSE_MBX_REQ_HDR_LEN),
+			.opcode  = cpu_to_le16(POWER_UP),
+			.powerup = {
+				/* fw needs this to reply correct cmd */
+				.version = cpu_to_le32(GENMASK_U32(31, 0)),
+				.status  = cpu_to_le32(is_powerup ? 1 : 0),
+			},
 		},
 	};
 	int len, err;
 
-	len = le16_to_cpu(req.datalen);
+	len = le16_to_cpu(req.r.datalen);
 	mutex_lock(&hw->mbx.lock);
-	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)&req, len);
+	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
 	mutex_unlock(&hw->mbx.lock);
 
 	return err;
@@ -142,11 +146,13 @@ int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup)
  **/
 int mucse_mbx_reset_hw(struct mucse_hw *hw)
 {
-	struct mbx_fw_cmd_req req = {
-		.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
-		.opcode  = cpu_to_le16(RESET_HW),
+	union mbx_fw_cmd_req_u req = {
+		.r = {
+			.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
+			.opcode  = cpu_to_le16(RESET_HW),
+		},
 	};
-	struct mbx_fw_cmd_reply reply = {};
+	union mbx_fw_cmd_reply_u reply = {};
 
 	return mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
 }
@@ -166,24 +172,26 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			  u8 *mac_addr,
 			  int port)
 {
-	struct mbx_fw_cmd_req req = {
-		.datalen      = cpu_to_le16(sizeof(req.get_mac_addr) +
-					    MUCSE_MBX_REQ_HDR_LEN),
-		.opcode       = cpu_to_le16(GET_MAC_ADDRESS),
-		.get_mac_addr = {
-			.port_mask = cpu_to_le32(BIT(port)),
-			.pfvf_num  = cpu_to_le32(pfvfnum),
+	union mbx_fw_cmd_req_u req = {
+		.r = {
+			.datalen      = cpu_to_le16(sizeof(req.r.get_mac_addr) +
+						    MUCSE_MBX_REQ_HDR_LEN),
+			.opcode       = cpu_to_le16(GET_MAC_ADDRESS),
+			.get_mac_addr = {
+				.port_mask = cpu_to_le32(BIT(port)),
+				.pfvf_num  = cpu_to_le32(pfvfnum),
+			},
 		},
 	};
-	struct mbx_fw_cmd_reply reply = {};
+	union mbx_fw_cmd_reply_u reply = {};
 	int err;
 
 	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
 	if (err)
 		return err;
 
-	if (le32_to_cpu(reply.mac_addr.ports) & BIT(port))
-		memcpy(mac_addr, reply.mac_addr.addrs[port].mac, ETH_ALEN);
+	if (le32_to_cpu(reply.r.mac_addr.ports) & BIT(port))
+		memcpy(mac_addr, reply.r.mac_addr.addrs[port].mac, ETH_ALEN);
 	else
 		return -ENODATA;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index fb24fc12b613..fe996aeffc4d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -80,6 +80,20 @@ struct mbx_fw_cmd_reply {
 	};
 } __packed;
 
+/* Union wrappers to expose struct as __le32 dword array for mailbox
+ * transport, eliminating the need for pointer casts.  The __packed
+ * structs have no padding, so dwords[] overlays the fields exactly.
+ */
+union mbx_fw_cmd_req_u {
+	struct mbx_fw_cmd_req r;
+	__le32 dwords[sizeof(struct mbx_fw_cmd_req) / sizeof(__le32)];
+};
+
+union mbx_fw_cmd_reply_u {
+	struct mbx_fw_cmd_reply r;
+	__le32 dwords[sizeof(struct mbx_fw_cmd_reply) / sizeof(__le32)];
+};
+
 int mucse_mbx_sync_fw(struct mucse_hw *hw);
 int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup);
 int mucse_mbx_reset_hw(struct mucse_hw *hw);
-- 
2.25.1


