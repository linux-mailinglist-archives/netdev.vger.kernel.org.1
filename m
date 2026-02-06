Return-Path: <netdev+bounces-257597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGayFDEMhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCBBFFDB3
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B725300614E
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85F2DE717;
	Fri,  6 Feb 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU0wY6hW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46F2DCF41
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392574; cv=none; b=kAEQ6o/ziLrV+5NF3W0Mw3p7lxxoPWS034rq/nac/+upS2DK4UCoF5d5/2nM7OP8Xoq4fDYNfuoSQWM6ij7wLoPuesy1MlOFc74HhNvXn5yyx9gHZRbjmSan5E/NRYm9V9tdhOqZ3LRz8ffGl73FGCBh0wWlH0rdZzUDxjMJn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392574; c=relaxed/simple;
	bh=nk6FBo5oHu46xrfexvRbcHaZ0aBYk3+ins4qA5pSGSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIaCA+XUsaAV0PlpoRs+0uf4MbVY+m2ZrDwxvxS0PzkwDeC7ejWrYqR9YN0+eG/OKRPy0ZDax05lKOCmZFnF0a9UQsZWq4BqNcL0VmKu4rh0tz1wDYkQsniOSzdeuMeM7o4tudOCN8wwfutbWcQBOnU6WmVyZIWR1Vf+U3At4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU0wY6hW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c70c6b2bcaso226535085a.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392573; x=1770997373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CrpLjsEJ97mU1tWann7pmgOTRqhJQHSEffGujRvSNk=;
        b=HU0wY6hWTxEEE0K9XCjtI/Rk365WjHwSEXj+oL1zebQJxhqUGPH4noh9H/CppEiDP1
         1PoGUlavq9qs2TqI9JQKdWm6u+pW3fhBggU2zJeM1V4OhvUYTWd41xK5B/gKnI48YkxF
         YRQNCLBUa8cDqeLNYjdmXoFURFy/52eQblmnlbFmIsFO5RpblMgk3KEXK5Bn+jLnUBTK
         78PjEZWwH59OO+3tQbHjEhynMOHHJJPluRPj0ylSQTRJKTZkB6O9yWtt5yZxhuiiz9k/
         JgEFHkNnCTVNW2VmnBYEoAaahsLH8FdW+RP0CUD7SSp7z6te+CMFgTcupQVD+IZXhRt0
         +fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392573; x=1770997373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4CrpLjsEJ97mU1tWann7pmgOTRqhJQHSEffGujRvSNk=;
        b=RxK/u/hS5eHNJnUc1/L1bgaIxgnA3RcsD42UjWCfbr46JdjhrizjPIT0Z+rQd8ToT4
         94nK5azw9hHA9YkUqL1ZwSVrf4uYXFCrXuEQZCcXmFAoSVVk2mWqyyy/h0BXNvJlZDy3
         YHnNVwO1+tQt2f/WxFtSbZaMzpdubtzCHR7xig5WVvQhBRXqqY7FC2QhjsD0KFGVLv76
         lExSltnh7qZthVIAv5QzT6WJvu6quZagHGyQq1VghshiGsGXr//pMMDYUc2JjbzmfDbq
         JjUvrM6sIQDdhIhGLwEcNTVXg+cY8Tm0LP+ybOZOhQOjKYtl58X9+H+KpQOJbGPFePrq
         INTg==
X-Gm-Message-State: AOJu0Yynp04dtNPN4RynJd+EVod0kJZbn7J7oI8FTBf1x5sebKRt8JOJ
	jywOVbjMnsWLA07qtR6zWawZLF4AitVw0Zf7QvHfMwA++iNRxj4HR7Db
X-Gm-Gg: AZuq6aK/YU3BEnwhFu9h9x4fm/Qa9jn0STAWDjbi3LRhszyKizVi5Ib959KZAhaXx84
	PCVwATMatGOpZRX7cg+rPBe4W4OVQvyClmwX/ZVaTsZrYbqsrBgu/m2Lqk8fjcMIkYwV1t5KsjO
	+97KGdhJpXYjMemBj6Op16PwVg63YdgmFd7n17Rbgjk/j61Rpy5R1wWVHQ430J4Rd9ODUne4Q/x
	QSTL0dv3BJhbFgIN0O2KEyDhNNSIP0YdYuImR4Qb9dYyWjd9ta2lb+iavrawqQ5L05Qk2xBzFI3
	8XnZGMYaofRKPPUd4diD0T6XQhY6Hzg6WznSySKIj0lP4zNAm13/E591Wf/TngseIcJR3+hHn5l
	JMuBEPezbBITraNfmXHb2hMIUjPD2l0ii1Fms2kTreDIgBPFW0K5BgYS4AD08jtfYIQ3/2THaR2
	m/bM+x+u9biLqz4UVem1IY0O3GUPkp6O/3vDvqIR2PLk1Q
X-Received: by 2002:a05:620a:462c:b0:8b2:598d:6e66 with SMTP id af79cd13be357-8caef30bf03mr378659585a.22.1770392573045;
        Fri, 06 Feb 2026 07:42:53 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9eea0c0sm181499185a.42.2026.02.06.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:42:52 -0800 (PST)
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
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 4/5] eth fbnic: TLV support for use by MBX self test
Date: Fri,  6 Feb 2026 10:42:44 -0500
Message-ID: <20260206154246.814-5-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206154246.814-1-mike.marciniszyn@gmail.com>
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257597-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FCBBFFDB3
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The TLV (Type-Value-Length) self uses a known set of data to create a
TLV message.  These routines support the MBX self test by creating
the test messages and parsing the response message coming back
from the firmware.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
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
index 3508b46ebdd0..ee663a03b2aa 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
@@ -8,6 +8,7 @@
 #include <linux/bits.h>
 #include <linux/const.h>
 #include <linux/types.h>
+struct fbnic_dev;

 #define FBNIC_TLV_MSG_ALIGN(len)	ALIGN(len, sizeof(u32))
 #define FBNIC_TLV_MSG_SIZE(len)		\
@@ -153,6 +154,31 @@ int fbnic_tlv_parser_error(void *opaque, struct fbnic_tlv_msg **results);
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


