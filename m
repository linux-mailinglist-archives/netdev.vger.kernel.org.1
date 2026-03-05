Return-Path: <netdev+bounces-264456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMiIEkKdqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:12:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC452143D5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 585D8302DA85
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F13BE149;
	Thu,  5 Mar 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be5CMTAF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869393BED2C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723406; cv=none; b=k8OZ6BaAV2TB/834zqxHuRfsA1WXbzMkidBPEq5eB1bF+Mb47KHQLLct/IEVtie6Uzt1lJrzev7iJzN+fQDYYm85oSSE22RxWtiE0xzxmPKjZ0VJ5a2duvwfpnRy/83CjSB0e3cZ/KjG21/15i8Jw43JYENyAB1YIfLQNZxoLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723406; c=relaxed/simple;
	bh=PcQq9g6NfojfsPV8CHZBJ1Tkrtkx9yrgmjpx4/IuMPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSiRQm/8H6XWPalNSd6jM2wlbBrVFvZVli9394vftFGPoJcPU5joOTF5QJtQezYoKghtl7Emb2PX5eBTwRiR38hX8twmBVlAaLpQlpXFKV/ubN6kE4qPnthPPiZkVUN+v105Ms6LgoU0CmlPGZA2QD1cih1xAS57W1ePqB91jJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be5CMTAF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb7edbcde6so994650085a.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723402; x=1773328202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtF+Rx1AC6n6+KaazXzEFIVkqD/mdgTa08+v0sCjj2I=;
        b=Be5CMTAFyLsOeSk97RkMgKQTWbtVdbZaW/nU3BPRl+V5UjQxDpTDTvaOEaxFSqISjF
         6GURXswU23BqKNxb3H59TnsncPgjZ+EUCkgfkkZREuxbMy6BsbcyxBFsqcyw5PxfYnq8
         wxMRgwD2DPFyi+efPBMeokmjMcP08ITR3jAcPqDLQOoeptbhL6RXxdN9tHmcYKCaudcJ
         kZvRncXo14btnDOIukw69uDtNEWf8WgioaB/Wnj5/P7j66aPnVV2Ye3DSQZtDp51SekP
         36Ctu9JFb9PXrywMNi8J1EiyAEaJ8hWjT8QFD6KpToY36ypHh++J59jY1mmgjVtVNKsn
         aAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723402; x=1773328202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtF+Rx1AC6n6+KaazXzEFIVkqD/mdgTa08+v0sCjj2I=;
        b=GYw9ZgkHS66ewVDXxmnOsuXrXFIX0LD+dkSobEVm3M/cl/TKPWt8uAnrzAHjY0tWTq
         QbMnqULF85gEEZ7Mcrgg1JB+kBQFi+pXnyHEWkD8pMnGyYYk5Jaw31BSqbLK0LpwFK9v
         EMu7i68pro9CW3YHzUEcWyGLH9mxCvqDjOXWXyqGfghT0pU9iEwfmI7hsFsom3af0f9z
         u7xRgA01lI+Exy++nHK/1ly31Ih5uWPzgjLclUeTj8Lob0RsbPB0FsbD2CpBjs+b37JE
         PRe+WHz4WEohH9WSAg7HTFyH1HO+1ecYBszW2yMQkeruST8gHh/SSL1YaUePNaPRo0Gk
         lNcg==
X-Forwarded-Encrypted: i=1; AJvYcCXqJc/sErRe7TPggntt+LBHby6AlHd0mMGl2EDTz1bgSYt9D6hBJI1Xk+a3lTCKaj1U1nbd0gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoH+EwGR5PqaaZyUWMJFTyxwsWhvqdET0Y2AtQNO6372+jzEuM
	Zqw9+0GsWpDkZCECn6lJGLsflLXY31hA7EaJGRGV+oyTRUfH2Ry9Lwt3
X-Gm-Gg: ATEYQzxGcrpDcVQLdxmzev+VsI9Pfxbl82ox1kNY0Mxrl/6XbffPyto7kHHcE3Tm8Z5
	5F1c4gjTW5Volfdm1+aBNPWv+VKi7uO4GgGciuSe+gK7NpyqkrbABMZrtu1Dq45879icQida3f3
	9i3kWa3eMFcy4Ekvic8A5a+g07Ygfp0Gwi/mF2joWtYsJr51d8qCP+yH4aym+xjj6zFLMp8woSR
	3RGghHJuDCCRRXKKEjZVMBfSB82p1U5H8Xp3CiIbEg/UmSdUKIp3GzktOH14WArSfbpQzGMcDee
	1ZzgC/9P5L7E4xJ/poE1NhGDIcr0floL1VqayxhZo4taxa0Pd0sdSoadamdhTV/FDtNRJuOhRWy
	e40FuJv0d+dtlbDcE+qBxNIddd7rURhhRdVgqOZCfMtpehoXU33CxdvB0mGRr5D7cgBfeOiiuLC
	uJHnlb2ei0Vr7BD5bcXy0xTjZF89RpCV65gdp4RLtoE7aSEc13mQ3ixojNzLBL8YM1OR1bUH7mx
	VKGbMUGjFLe8wOl
X-Received: by 2002:a05:620a:1726:b0:8c7:ad9:d0a2 with SMTP id af79cd13be357-8cd6af73a7fmr19002185a.22.1772723402074;
        Thu, 05 Mar 2026 07:10:02 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0bb6e27asm64183176d6.2.2026.03.05.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:10:01 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/5] eth fbnic: TLV support for use by MBX self test
Date: Thu,  5 Mar 2026 10:09:46 -0500
Message-ID: <20260305150947.16893-5-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BC452143D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264456-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The TLV (Type-Value-Length) self uses a known set of data to create a
TLV message.  These routines support the MBX self test by creating
the test messages and parsing the response message coming back
from the firmware.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2 - place forward of struct fbnic_dev after include with a blank line
v3 - no changes

 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c | 276 ++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h |  27 ++
 2 files changed, 303 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index 517ed8b2f1cb..c55d4f76a5fc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -551,6 +551,172 @@ int fbnic_tlv_parser_error(void *opaque, struct fbnic_tlv_msg **results)
 	return -EBADMSG;
 }
 
+#define FBNIC_TLV_TEST_STRING_LEN	32
+
+struct fbnic_tlv_test {
+	u64	test_u64;
+	s64	test_s64;
+	u32	test_u32;
+	s32	test_s32;
+	u16	test_u16;
+	s16	test_s16;
+	u8	test_mac[ETH_ALEN];
+	u8	test_mac_array[4][ETH_ALEN];
+	u8	test_true;
+	u8	test_false;
+	char	test_string[FBNIC_TLV_TEST_STRING_LEN];
+};
+
+static struct fbnic_tlv_test test_struct;
+
+const struct fbnic_tlv_index fbnic_tlv_test_index[] = {
+	FBNIC_TLV_ATTR_U64(FBNIC_TLV_TEST_MSG_U64),
+	FBNIC_TLV_ATTR_S64(FBNIC_TLV_TEST_MSG_S64),
+	FBNIC_TLV_ATTR_U32(FBNIC_TLV_TEST_MSG_U32),
+	FBNIC_TLV_ATTR_S32(FBNIC_TLV_TEST_MSG_S32),
+	FBNIC_TLV_ATTR_U32(FBNIC_TLV_TEST_MSG_U16),
+	FBNIC_TLV_ATTR_S32(FBNIC_TLV_TEST_MSG_S16),
+	FBNIC_TLV_ATTR_MAC_ADDR(FBNIC_TLV_TEST_MSG_MAC_ADDR),
+	FBNIC_TLV_ATTR_FLAG(FBNIC_TLV_TEST_MSG_FLAG_TRUE),
+	FBNIC_TLV_ATTR_FLAG(FBNIC_TLV_TEST_MSG_FLAG_FALSE),
+	FBNIC_TLV_ATTR_STRING(FBNIC_TLV_TEST_MSG_STRING,
+			      FBNIC_TLV_TEST_STRING_LEN),
+	FBNIC_TLV_ATTR_ARRAY(FBNIC_TLV_TEST_MSG_ARRAY),
+	FBNIC_TLV_ATTR_NESTED(FBNIC_TLV_TEST_MSG_NESTED),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static void fbnic_tlv_test_struct_init(void)
+{
+	int i = FBNIC_TLV_TEST_STRING_LEN - 1;
+
+	/* Populate the struct with random data */
+	get_random_once(&test_struct,
+			offsetof(struct fbnic_tlv_test, test_string) + i);
+
+	/* Force true/false to their expected values */
+	test_struct.test_false = false;
+	test_struct.test_true = true;
+
+	/* Convert test_string to a true ASCII string */
+	test_struct.test_string[i] = '\0';
+	while (i--) {
+		/* Force characters into displayable range */
+		if (test_struct.test_string[i] < 64 ||
+		    test_struct.test_string[i] >= 96) {
+			test_struct.test_string[i] %= 32;
+			test_struct.test_string[i] += 64;
+		}
+	}
+}
+
+static int fbnic_tlv_test_attr_data(struct fbnic_tlv_msg *msg)
+{
+	struct fbnic_tlv_msg *array;
+	int err, i;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_TLV_TEST_MSG_U64,
+				     test_struct.test_u64);
+	if (err)
+		return err;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_TLV_TEST_MSG_S64,
+				     test_struct.test_s64);
+	if (err)
+		return err;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_TLV_TEST_MSG_U32,
+				     test_struct.test_u32);
+	if (err)
+		return err;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_TLV_TEST_MSG_S32,
+				     test_struct.test_s32);
+	if (err)
+		return err;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_TLV_TEST_MSG_U16,
+				     test_struct.test_u16);
+	if (err)
+		return err;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_TLV_TEST_MSG_S16,
+				     test_struct.test_s16);
+	if (err)
+		return err;
+
+	err = fbnic_tlv_attr_put_value(msg, FBNIC_TLV_TEST_MSG_MAC_ADDR,
+				       test_struct.test_mac, ETH_ALEN);
+	if (err)
+		return err;
+
+	/* Start MAC address array */
+	array = fbnic_tlv_attr_nest_start(msg, FBNIC_TLV_TEST_MSG_ARRAY);
+	if (!array)
+		return -ENOSPC;
+
+	for (i = 0; i < 4; i++) {
+		err = fbnic_tlv_attr_put_value(array,
+					       FBNIC_TLV_TEST_MSG_MAC_ADDR,
+					       test_struct.test_mac_array[i],
+					       ETH_ALEN);
+		if (err)
+			return err;
+	}
+
+	/* Close array */
+	fbnic_tlv_attr_nest_stop(msg);
+
+	err = fbnic_tlv_attr_put_flag(msg, FBNIC_TLV_TEST_MSG_FLAG_TRUE);
+	if (err)
+		return err;
+
+	return fbnic_tlv_attr_put_string(msg, FBNIC_TLV_TEST_MSG_STRING,
+					 test_struct.test_string);
+}
+
+/**
+ * fbnic_tlv_test_create - Allocate a test message and fill it w/ data
+ * @fbd: FBNIC device structure
+ *
+ * Return: NULL on failure to allocate or pointer to new TLV test message.
+ **/
+struct fbnic_tlv_msg *fbnic_tlv_test_create(struct fbnic_dev *fbd)
+{
+	struct fbnic_tlv_msg *msg, *nest;
+	int err;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_TEST);
+	if (!msg)
+		return NULL;
+
+	/* Randomize struct data */
+	fbnic_tlv_test_struct_init();
+
+	/* Add first level of data to message */
+	err = fbnic_tlv_test_attr_data(msg);
+	if (err)
+		goto free_message;
+
+	/* Start second level nested */
+	nest = fbnic_tlv_attr_nest_start(msg, FBNIC_TLV_TEST_MSG_NESTED);
+	if (!nest)
+		goto free_message;
+
+	/* Add nested data */
+	err = fbnic_tlv_test_attr_data(nest);
+	if (err)
+		goto free_message;
+
+	/* Close nest and report full message */
+	fbnic_tlv_attr_nest_stop(msg);
+
+	return msg;
+free_message:
+	free_page((unsigned long)msg);
+	return NULL;
+}
+
 void fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src)
 {
 	u8 *mac_addr;
@@ -558,3 +724,113 @@ void fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src)
 	mac_addr = fbnic_tlv_attr_get_value_ptr(src);
 	memcpy(dest, mac_addr, ETH_ALEN);
 }
+
+/**
+ * fbnic_tlv_parser_test_attr - Function loading test attributes into structure
+ * @str: Test structure to load
+ * @results: Pointer to results array
+ *
+ * Copies attributes into structure. Any attribute that doesn't exist in the
+ * results array is not populated.
+ **/
+static void fbnic_tlv_parser_test_attr(struct fbnic_tlv_test *str,
+				       struct fbnic_tlv_msg **results)
+{
+	struct fbnic_tlv_msg *array_results[4];
+	struct fbnic_tlv_msg *attr;
+	char *string = NULL;
+	int i, err;
+
+	str->test_u64 = fta_get_uint(results, FBNIC_TLV_TEST_MSG_U64);
+	str->test_u32 = fta_get_uint(results, FBNIC_TLV_TEST_MSG_U32);
+	str->test_u16 = fta_get_uint(results, FBNIC_TLV_TEST_MSG_U16);
+
+	str->test_s64 = fta_get_sint(results, FBNIC_TLV_TEST_MSG_S64);
+	str->test_s32 = fta_get_sint(results, FBNIC_TLV_TEST_MSG_S32);
+	str->test_s16 = fta_get_sint(results, FBNIC_TLV_TEST_MSG_S16);
+
+	attr = results[FBNIC_TLV_TEST_MSG_MAC_ADDR];
+	if (attr)
+		fbnic_tlv_attr_addr_copy(str->test_mac, attr);
+
+	attr = results[FBNIC_TLV_TEST_MSG_ARRAY];
+	if (attr) {
+		int len = le16_to_cpu(attr->hdr.len) / sizeof(u32) - 1;
+
+		err = fbnic_tlv_attr_parse_array(&attr[1], len,
+						 array_results,
+						 fbnic_tlv_test_index,
+						 FBNIC_TLV_TEST_MSG_MAC_ADDR,
+						 4);
+		if (!err) {
+			for (i = 0; i < 4 && array_results[i]; i++)
+				fbnic_tlv_attr_addr_copy(str->test_mac_array[i],
+							 array_results[i]);
+		}
+	}
+
+	str->test_true = !!results[FBNIC_TLV_TEST_MSG_FLAG_TRUE];
+	str->test_false = !!results[FBNIC_TLV_TEST_MSG_FLAG_FALSE];
+
+	attr = results[FBNIC_TLV_TEST_MSG_STRING];
+	if (attr) {
+		string = fbnic_tlv_attr_get_value_ptr(attr);
+		strscpy(str->test_string, string, FBNIC_TLV_TEST_STRING_LEN);
+	}
+}
+
+static void fbnic_tlv_test_dump(struct fbnic_tlv_test *value, char *prefix)
+{
+	print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1,
+		       value, sizeof(*value), true);
+}
+
+/**
+ * fbnic_tlv_parser_test - Function for parsing and testing test message
+ * @opaque: Unused value
+ * @results: Results of parser output
+ *
+ * Return: negative value on error, or 0 on success.
+ *
+ * Parses attributes to structures and compares the structure to the
+ * expected test value that should have been used to populate the message.
+ *
+ * Used to verify message generation and parser are working correctly.
+ **/
+int fbnic_tlv_parser_test(void *opaque, struct fbnic_tlv_msg **results)
+{
+	struct fbnic_tlv_msg *nest_results[FBNIC_TLV_RESULTS_MAX] = { 0 };
+	struct fbnic_tlv_test result_struct;
+	struct fbnic_tlv_msg *attr;
+	int err;
+
+	memset(&result_struct, 0, sizeof(result_struct));
+	fbnic_tlv_parser_test_attr(&result_struct, results);
+
+	if (memcmp(&test_struct, &result_struct, sizeof(test_struct))) {
+		fbnic_tlv_test_dump(&result_struct, "fbnic: found - ");
+		fbnic_tlv_test_dump(&test_struct, "fbnic: expected - ");
+		return -EINVAL;
+	}
+
+	attr = results[FBNIC_TLV_TEST_MSG_NESTED];
+	if (!attr)
+		return -EINVAL;
+
+	err = fbnic_tlv_attr_parse(&attr[1],
+				   le16_to_cpu(attr->hdr.len) / sizeof(u32) - 1,
+				   nest_results, fbnic_tlv_test_index);
+	if (err)
+		return err;
+
+	memset(&result_struct, 0, sizeof(result_struct));
+	fbnic_tlv_parser_test_attr(&result_struct, nest_results);
+
+	if (memcmp(&test_struct, &result_struct, sizeof(test_struct))) {
+		fbnic_tlv_test_dump(&result_struct, "fbnic: found - ");
+		fbnic_tlv_test_dump(&test_struct, "fbnic: expected - ");
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
index 3508b46ebdd0..9c4e4759394a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
@@ -9,6 +9,8 @@
 #include <linux/const.h>
 #include <linux/types.h>
 
+struct fbnic_dev;
+
 #define FBNIC_TLV_MSG_ALIGN(len)	ALIGN(len, sizeof(u32))
 #define FBNIC_TLV_MSG_SIZE(len)		\
 		(FBNIC_TLV_MSG_ALIGN(len) / sizeof(u32))
@@ -153,6 +155,31 @@ int fbnic_tlv_parser_error(void *opaque, struct fbnic_tlv_msg **results);
 #define fta_get_str(_results, _id, _dst, _dstsize) \
 	fbnic_tlv_attr_get_string(_results[_id], _dst, _dstsize)
 
+#define FBNIC_TLV_MSG_ID_TEST	0
+
+enum fbnic_tlv_test_attr_id {
+	FBNIC_TLV_TEST_MSG_U64,
+	FBNIC_TLV_TEST_MSG_S64,
+	FBNIC_TLV_TEST_MSG_U32,
+	FBNIC_TLV_TEST_MSG_S32,
+	FBNIC_TLV_TEST_MSG_U16,
+	FBNIC_TLV_TEST_MSG_S16,
+	FBNIC_TLV_TEST_MSG_MAC_ADDR,
+	FBNIC_TLV_TEST_MSG_FLAG_TRUE,
+	FBNIC_TLV_TEST_MSG_FLAG_FALSE,
+	FBNIC_TLV_TEST_MSG_STRING,
+	FBNIC_TLV_TEST_MSG_NESTED,
+	FBNIC_TLV_TEST_MSG_ARRAY,
+	FBNIC_TLV_TEST_MSG_MAX
+};
+
+extern const struct fbnic_tlv_index fbnic_tlv_test_index[];
+struct fbnic_tlv_msg *fbnic_tlv_test_create(struct fbnic_dev *fbd);
+int fbnic_tlv_parser_test(void *opaque, struct fbnic_tlv_msg **results);
+
+#define FBNIC_TLV_MSG_TEST \
+	FBNIC_TLV_PARSER(TEST, fbnic_tlv_test_index, \
+			 fbnic_tlv_parser_test)
 #define FBNIC_TLV_MSG_ERROR \
 	FBNIC_TLV_PARSER(UNKNOWN, NULL, fbnic_tlv_parser_error)
 #endif /* _FBNIC_TLV_H_ */
-- 
2.43.0


