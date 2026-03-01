Return-Path: <netdev+bounces-262388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fk0OEEepGlkXgUAu9opvQ
	(envelope-from <netdev+bounces-262388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:08:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A701CF459
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B9A3036749
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1094E31714E;
	Sun,  1 Mar 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7IUnT3h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AF2F2607
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772363182; cv=none; b=mOe5MBkyTdCe2Z6kO66eurk0oL+UUke9DO7oMrkD4nm0oBYVf2mLl1FuEjpJCM0JbDeLahco9Cg3ieyP0m/9ic18Dhf4mjzn8WoDEgLC0hjaGLy03h/FzZy8jCKOjkOqrcTf+13BVtgm7DcYB/vn0CI6Ph+wQ2A22J7DkvaPC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772363182; c=relaxed/simple;
	bh=TIvE4y4LuRiV70aS2fW22mvfHHc91g0ORgv1VYahyZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKmrBhS6BNeVGXaJK3cqEkLzhXoDYXcqjTJM+QW84OT5nLxaxSexepxpuJOJ6Fcfj1kU6k9z5vsh6qav8U2vapVkQ62E68xK+JV8r9r579PI5NTt8LS6bWbgGwQGde2Wxno+15IE3dsrZzOBwnHaxTn1+tio49MYG/1H1ldldR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7IUnT3h; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3a8494c5so362384485a.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772363180; x=1772967980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd12nlrpOUc6ulbomkWhJgpuZGNyjxegNqIZtOfR/6E=;
        b=j7IUnT3hXVBby00l+/HbfABENPZifMURJKxbE83l8U6u/0aBqrbXslaq2EIWvXCNAC
         wwJD682f5oVurDurmg7BXGuQ9i8tY0aJGB4FX15rgci7qQlSWYWpwTTNWSih9+NIDoBD
         9s5/sXhgK9uivmlitpazjBMQS/v5o5UNJ74qdzkRxo6gKdsFMUH+cv378GcKLS/N0d6K
         njHzH1lMWel2TeEVI1cuhdHmw7BLD9VqnyMOally6mbEukFKawd8DsL4QHulMpVnA/KK
         loEIaN6gocndzKRWeIkktLB0/hwejmcHVmGqPv8A2x49llo9+Kvgyiw8Xj8pSiSrIMwM
         ENCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772363180; x=1772967980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rd12nlrpOUc6ulbomkWhJgpuZGNyjxegNqIZtOfR/6E=;
        b=Gkjf/EUKACiajJZHAQwwI82+9GbI18Dc/diNkLKZWmlHliSVoupxTN9VjZ11pCSnAA
         ZJx7BP1XCwBuHmYJg5rkRbiefeN2GdgTPv8xTUhrasw6u1AYn8DkH8igVUZTCfYw34fR
         dvCgCy+YR3R9Ry5KFZbRNU9gLfzIzj+a7BfUdQn4PCvrkbOosfIO7ALKrTOO9Si/bQ3G
         dKlwK4tTEZ2thcsjhPevP5PGQcf8lLXbM54/2Ro131vBK67YRxOkUKm2SG0c8M2LZTUD
         OCTLG6z5FsZKNZYT0FFjKAhfZkTQ07rHxCCh4jZFm/QM8AV+o4QoBJ+annP6mYep2Piw
         WT7g==
X-Forwarded-Encrypted: i=1; AJvYcCVrO7Jzb8JR4QFK9SL0CuUJXjGlnHFFe3cn4768po5M5dAkcg5rWU8iaFwb77Ev/E473nbji5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67vTwmdy6dt/52Ov091hEqwy+8ZQwwqMPAi0fiHcAWPg3W6O3
	ibtEneqL2orTQzriXr+wXyqz59pqC9GbTFCP37bX54PJWg9XVlvAKgov
X-Gm-Gg: ATEYQzw/m9HhJ3GfMXnHM5KwFBuuji7fyjZUpSu0DoRFeNA3U/KeLyElYyd4OK+H2fJ
	W/1j74hNUiuCNJLBpIXwTMLW+FOem+/4GG5XtvvCyydiPIU1o0rZTOa96Tk2v5WfUj7+dvfMk6k
	pee68X8qJAiCCVt7arLBDEoO8zmeXRznJLqnIob++ggK67f4h5t3udZ5SLLAgHrzb2YpwdrwPht
	cfEKYB+1I8El8qlKypm3jLG+1M3XJzVp+XD/pR7dcdfWJIyINpYOO3I2KvF+Omnymre1X/fwZxk
	ZfEXdtLbXhyHB/hM8fOc67hbZhKVx6PVcsV+JlC5TpjBVEpRJjE5gAVCgB9rE3Bt6mA5JYMDdHa
	aKnl7ySgU4jQwNyobHejlydtM226koC4WzYXjRP43S0qRWqcsh+lP4qMUPyBHTir9+P2ZBNzzVG
	+c0ISvr9QCC6ImQ9fQpv1cUxenMGSaopf+uCrgqM+keqf82MOmUq4aXoyf1ujsYQKi2aAK0MSRa
	vFRiQn/tAcfMMm4
X-Received: by 2002:a05:6214:d09:b0:899:efd1:9e15 with SMTP id 6a1803df08f44-899efd1a067mr34565596d6.49.1772363179520;
        Sun, 01 Mar 2026 03:06:19 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm83888876d6.15.2026.03.01.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 03:06:19 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2.2 4/5] eth fbnic: TLV support for use by MBX self test
Date: Sun,  1 Mar 2026 06:06:05 -0500
Message-ID: <20260301110606.3739-5-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301110606.3739-1-mike.marciniszyn@gmail.com>
References: <20260301110606.3739-1-mike.marciniszyn@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262388-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48A701CF459
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The TLV (Type-Value-Length) self uses a known set of data to create a
TLV message.  These routines support the MBX self test by creating
the test messages and parsing the response message coming back
from the firmware.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2 - place forward of struct fbnic_dev after include with a blank line

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


