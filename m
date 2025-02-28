Return-Path: <netdev+bounces-170834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC39A4A2A2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 20:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9DD3B95E5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67011C4A0E;
	Fri, 28 Feb 2025 19:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB41AB52D;
	Fri, 28 Feb 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770663; cv=none; b=WrR7jmHmOqJKseQbH5KUt1T0LJ29Ua2OJrkbGR4rED9h3KGWrT0QSa/81bcG18u5qF9jgSIo87TpL/4uQqaaVqiU/wrbvCrLYFE40kBfy7Vyas+g98CC0078U7D/wna9l5XRPV35MwuSONCx2cB8jcVWoKFoe3nHvi2VqRoCDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770663; c=relaxed/simple;
	bh=hlxJkFt3B7jKC0Jlq73fTEG4U/Hqnex+bvw08Pu1sPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQpgFCbxHJw4ndAq9XTdS78K4g4KtVGkCRUjlaXfKR5iXj7FFH4SOx7pmiILngOl24icTgX1B1p+1hnUv0pAmyqD8oL/0mnvc1zr2UZjPk2q24RdoDheYj2irDS8z6GbrTi+1aS5YlgQuNL+/gLDZdiso/1EKP2uK3r0Xqfd0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1to5y3-0001QO-WC; Fri, 28 Feb 2025 19:24:16 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Su Hui <suhui@nfschina.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] eth: fbnic: Replace firmware field macros
Date: Fri, 28 Feb 2025 11:15:28 -0800
Message-ID: <20250228191935.3953712-4-lee@trager.us>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250228191935.3953712-1-lee@trager.us>
References: <20250228191935.3953712-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the firmware field macros with new macros which follow typical
kernel standards. No variables are required to be predefined for use and
results are now returned. These macros are prefixed with fta or fbnic
TLV attribute.

Signed-off-by: Lee Trager <lee@trager.us>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 101 ++++++++++----------
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c |  16 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h |  35 ++-----
 3 files changed, 70 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 76a225f01718..88db3dacb940 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -494,16 +494,13 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],

 static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 {
-	u32 active_slot = 0, all_multi = 0;
+	u32 all_multi = 0, version = 0;
 	struct fbnic_dev *fbd = opaque;
-	u32 speed = 0, fec = 0;
-	size_t commit_size = 0;
 	bool bmc_present;
 	int err;

-	get_unsigned_result(FBNIC_FW_CAP_RESP_VERSION,
-			    fbd->fw_cap.running.mgmt.version);
-
+	version = fta_get_uint(results, FBNIC_FW_CAP_RESP_VERSION);
+	fbd->fw_cap.running.mgmt.version = version;
 	if (!fbd->fw_cap.running.mgmt.version)
 		return -EINVAL;

@@ -524,43 +521,41 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 		return -EINVAL;
 	}

-	get_string_result(FBNIC_FW_CAP_RESP_VERSION_COMMIT_STR, commit_size,
-			  fbd->fw_cap.running.mgmt.commit,
-			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
-	if (!commit_size)
+	if (fta_get_str(results, FBNIC_FW_CAP_RESP_VERSION_COMMIT_STR,
+			fbd->fw_cap.running.mgmt.commit,
+			FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE) <= 0)
 		dev_warn(fbd->dev, "Firmware did not send mgmt commit!\n");

-	get_unsigned_result(FBNIC_FW_CAP_RESP_STORED_VERSION,
-			    fbd->fw_cap.stored.mgmt.version);
-	get_string_result(FBNIC_FW_CAP_RESP_STORED_COMMIT_STR, commit_size,
-			  fbd->fw_cap.stored.mgmt.commit,
-			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
-
-	get_unsigned_result(FBNIC_FW_CAP_RESP_CMRT_VERSION,
-			    fbd->fw_cap.running.bootloader.version);
-	get_string_result(FBNIC_FW_CAP_RESP_CMRT_COMMIT_STR, commit_size,
-			  fbd->fw_cap.running.bootloader.commit,
-			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
-
-	get_unsigned_result(FBNIC_FW_CAP_RESP_STORED_CMRT_VERSION,
-			    fbd->fw_cap.stored.bootloader.version);
-	get_string_result(FBNIC_FW_CAP_RESP_STORED_CMRT_COMMIT_STR, commit_size,
-			  fbd->fw_cap.stored.bootloader.commit,
-			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
-
-	get_unsigned_result(FBNIC_FW_CAP_RESP_UEFI_VERSION,
-			    fbd->fw_cap.stored.undi.version);
-	get_string_result(FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR, commit_size,
-			  fbd->fw_cap.stored.undi.commit,
-			  FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
-
-	get_unsigned_result(FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT, active_slot);
-	fbd->fw_cap.active_slot = active_slot;
-
-	get_unsigned_result(FBNIC_FW_CAP_RESP_FW_LINK_SPEED, speed);
-	get_unsigned_result(FBNIC_FW_CAP_RESP_FW_LINK_FEC, fec);
-	fbd->fw_cap.link_speed = speed;
-	fbd->fw_cap.link_fec = fec;
+	version = fta_get_uint(results, FBNIC_FW_CAP_RESP_STORED_VERSION);
+	fbd->fw_cap.stored.mgmt.version = version;
+	fta_get_str(results, FBNIC_FW_CAP_RESP_STORED_COMMIT_STR,
+		    fbd->fw_cap.stored.mgmt.commit,
+		    FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	version = fta_get_uint(results, FBNIC_FW_CAP_RESP_CMRT_VERSION);
+	fbd->fw_cap.running.bootloader.version = version;
+	fta_get_str(results, FBNIC_FW_CAP_RESP_CMRT_COMMIT_STR,
+		    fbd->fw_cap.running.bootloader.commit,
+		    FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	version = fta_get_uint(results, FBNIC_FW_CAP_RESP_STORED_CMRT_VERSION);
+	fbd->fw_cap.stored.bootloader.version = version;
+	fta_get_str(results, FBNIC_FW_CAP_RESP_STORED_CMRT_COMMIT_STR,
+		    fbd->fw_cap.stored.bootloader.commit,
+		    FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	version = fta_get_uint(results, FBNIC_FW_CAP_RESP_UEFI_VERSION);
+	fbd->fw_cap.stored.undi.version = version;
+	fta_get_str(results, FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR,
+		    fbd->fw_cap.stored.undi.commit,
+		    FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE);
+
+	fbd->fw_cap.active_slot =
+		fta_get_uint(results, FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT);
+	fbd->fw_cap.link_speed =
+		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_SPEED);
+	fbd->fw_cap.link_fec =
+		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_FEC);

 	bmc_present = !!results[FBNIC_FW_CAP_RESP_BMC_PRESENT];
 	if (bmc_present) {
@@ -575,7 +570,8 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 		if (err)
 			return err;

-		get_unsigned_result(FBNIC_FW_CAP_RESP_BMC_ALL_MULTI, all_multi);
+		all_multi =
+			fta_get_uint(results, FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
 	} else {
 		memset(fbd->fw_cap.bmc_mac_addr, 0,
 		       sizeof(fbd->fw_cap.bmc_mac_addr));
@@ -754,32 +750,31 @@ static int fbnic_fw_parse_tsene_read_resp(void *opaque,
 {
 	struct fbnic_fw_completion *cmpl_data;
 	struct fbnic_dev *fbd = opaque;
+	s32 err_resp;
 	int err = 0;

 	/* Verify we have a completion pointer to provide with data */
 	cmpl_data = fbnic_fw_get_cmpl_by_type(fbd,
 					      FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
 	if (!cmpl_data)
-		return -EINVAL;
+		return -ENOSPC;

-	if (results[FBNIC_FW_TSENE_ERROR]) {
-		err = fbnic_tlv_attr_get_unsigned(results[FBNIC_FW_TSENE_ERROR]);
-		if (err)
-			goto exit_complete;
-	}
+	err_resp = fta_get_sint(results, FBNIC_FW_TSENE_ERROR);
+	if (err_resp)
+		goto msg_err;

 	if (!results[FBNIC_FW_TSENE_THERM] || !results[FBNIC_FW_TSENE_VOLT]) {
 		err = -EINVAL;
-		goto exit_complete;
+		goto msg_err;
 	}

 	cmpl_data->u.tsene.millidegrees =
-		fbnic_tlv_attr_get_signed(results[FBNIC_FW_TSENE_THERM]);
+		fta_get_sint(results, FBNIC_FW_TSENE_THERM);
 	cmpl_data->u.tsene.millivolts =
-		fbnic_tlv_attr_get_signed(results[FBNIC_FW_TSENE_VOLT]);
+		fta_get_sint(results, FBNIC_FW_TSENE_VOLT);

-exit_complete:
-	cmpl_data->result = err;
+msg_err:
+	cmpl_data->result = err_resp ? : err;
 	complete(&cmpl_data->done);
 	fbnic_fw_put_cmpl(cmpl_data);

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index 400fb6c80053..d558d176e0df 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -196,13 +196,17 @@ int fbnic_tlv_attr_put_string(struct fbnic_tlv_msg *msg, u16 attr_id,
 /**
  * fbnic_tlv_attr_get_unsigned - Retrieve unsigned value from result
  * @attr: Attribute to retrieve data from
+ * @def: The default value if attr is NULL
  *
  * Return: unsigned 64b value containing integer value
  **/
-u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr)
+u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr, u64 def)
 {
 	__le64 le64_value = 0;

+	if (!attr)
+		return def;
+
 	memcpy(&le64_value, &attr->value[0],
 	       le16_to_cpu(attr->hdr.len) - sizeof(*attr));

@@ -212,15 +216,21 @@ u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr)
 /**
  * fbnic_tlv_attr_get_signed - Retrieve signed value from result
  * @attr: Attribute to retrieve data from
+ * @def: The default value if attr is NULL
  *
  * Return: signed 64b value containing integer value
  **/
-s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr)
+s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr, s64 def)
 {
-	int shift = (8 + sizeof(*attr) - le16_to_cpu(attr->hdr.len)) * 8;
 	__le64 le64_value = 0;
+	int shift;
 	s64 value;

+	if (!attr)
+		return def;
+
+	shift = (8 + sizeof(*attr) - le16_to_cpu(attr->hdr.len)) * 8;
+
 	/* Copy the value and adjust for byte ordering */
 	memcpy(&le64_value, &attr->value[0],
 	       le16_to_cpu(attr->hdr.len) - sizeof(*attr));
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
index b29ed2649585..c34bf87eeec9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
@@ -114,34 +114,10 @@ static inline bool fbnic_tlv_attr_get_bool(struct fbnic_tlv_msg *attr)
 	return !!attr;
 }

-u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr);
-s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr);
+u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr, u64 def);
+s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr, s64 def);
 ssize_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *dst,
 				  size_t dstsize);
-
-#define get_unsigned_result(id, location) \
-do { \
-	struct fbnic_tlv_msg *result = results[id]; \
-	if (result) \
-		location = fbnic_tlv_attr_get_unsigned(result); \
-} while (0)
-
-#define get_signed_result(id, location) \
-do { \
-	struct fbnic_tlv_msg *result = results[id]; \
-	if (result) \
-		location = fbnic_tlv_attr_get_signed(result); \
-} while (0)
-
-#define get_string_result(id, size, str, max_size) \
-do { \
-	struct fbnic_tlv_msg *result = results[id]; \
-	if (result) \
-		size = fbnic_tlv_attr_get_string(result, str, max_size); \
-} while (0)
-
-#define get_bool(id) (!!(results[id]))
-
 struct fbnic_tlv_msg *fbnic_tlv_msg_alloc(u16 msg_id);
 int fbnic_tlv_attr_put_flag(struct fbnic_tlv_msg *msg, const u16 attr_id);
 int fbnic_tlv_attr_put_value(struct fbnic_tlv_msg *msg, const u16 attr_id,
@@ -170,6 +146,13 @@ int fbnic_tlv_msg_parse(void *opaque, struct fbnic_tlv_msg *msg,
 			const struct fbnic_tlv_parser *parser);
 int fbnic_tlv_parser_error(void *opaque, struct fbnic_tlv_msg **results);

+#define fta_get_uint(_results, _id) \
+	fbnic_tlv_attr_get_unsigned(_results[_id], 0)
+#define fta_get_sint(_results, _id) \
+	fbnic_tlv_attr_get_signed(_results[_id], 0)
+#define fta_get_str(_results, _id, _dst, _dstsize) \
+	fbnic_tlv_attr_get_string(_results[_id], _dst, _dstsize)
+
 #define FBNIC_TLV_MSG_ERROR \
 	FBNIC_TLV_PARSER(UNKNOWN, NULL, fbnic_tlv_parser_error)
 #endif /* _FBNIC_TLV_H_ */
--
2.43.5

