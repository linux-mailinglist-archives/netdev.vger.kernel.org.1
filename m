Return-Path: <netdev+bounces-106526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A67916A97
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61291C22D33
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F63A8CB;
	Tue, 25 Jun 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWF4ngTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5516C842
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326159; cv=none; b=aQ2UovOXdqtOaP7zvtEWJQOt9E2+1J2WkkucftGVRtbun4j0k81nJK36nu+BAvO8krXtqWxhplpBMD0wkXhsNfzqYH/aS1o67No+f458H0ysH3MKdH3XlQKcxR0g9LcVqOfbwjmT1G/xJWs9iouNRn52pIb2tFF5+P8eEjZZCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326159; c=relaxed/simple;
	bh=dHWTqP+igiphH+22Wf1IIBjT/D6VYpbte2aqO062r9Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b57x8kPEhN/9dZhiH0DZJPsIUiVUKZGv6HSYpLY/ixHFvyr5TytoT/6EXKw3xj0L5UM/iItIO07X0A4IlYGeSlkYZBHxL7ckkyMfJL0OXk1ShDTjYxvBUGh0HKeu79ppr4Xa9YkGR+UZKeBM0i56G/Zf61fsQJjNa3IEKHso0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWF4ngTd; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f39116e564so149715039f.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326157; x=1719930957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ggu5qvQyAjhJxkRHHOuohBQgfFDOTM/bRKEQI0Xs4c=;
        b=GWF4ngTdgv91vuZ6cnRntysMFFXGhg8ggqftqtTJykfn0o/aNuyLWGE8EbSMe+b0wE
         oUwH+jQpQkGrRlWQ4pTLl2JlaI5BYMsj68NaFFQWSpSjP72dBzBq4q4m1l/wvPXUZs/+
         Ra0oOKfQ3vq/SnnwPQ/HNWDhTvAbgJlbJjW+WksUP34r+77j/x68ztD01YKrvy17gWR1
         kYDrzq4/TmbPA6iHaYZUxUk4VIUbXWNhrGk3KWfl2fhG4Z39Ab6pSODxtIvWL6HQylV3
         b5Fn8TiPDtduJGi6f0tvBRvc67CpNpbVU9z8TWwtAK6eIuBg+kc7SH8Yu9RFY6BrOjXk
         HX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326157; x=1719930957;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ggu5qvQyAjhJxkRHHOuohBQgfFDOTM/bRKEQI0Xs4c=;
        b=PJW33BqndjoQxTOHA8mN5S2wgrvn7FdGQCDNCgNePC92nE7OudYV9uV/xj87af/zdd
         PvCgj1u9n+yr737Ppb7VTjeJ2s26PwHSgkjPuFGgnGfd2/iPYvy8cg7HpsNbsHzOqNs6
         uJLO/lXXtb1Wcb8MBcl9P+/1m7+KAcykkOZpepzI3JXJog8nipjiussBfWK6DJjVMHL0
         CXEmw1JUySiUB861Xn46df8H1q1E5Q8n+7EwQA/6lEHOWNA7CDqRw+rxKfCGdIzJeo2o
         KM3hAaNW8AQzRVyKjZ5Wez/2K7ftnonbi+fr+AEaPrJ0j4HoZMDGEa0Tq7cA3t20F7tW
         K+4Q==
X-Gm-Message-State: AOJu0YxoQUUJFXnTcfnLcDt/hvimskBc6wU3IJCrwh217uYCCHEodTMm
	XpWtHyqJqTMFdJqXEIRLEIlVrN45gmIKhcBVCeW/PLmxHoPWY+JL
X-Google-Smtp-Source: AGHT+IGuWoJ0M9N2pm54fr5UTEhJfvSS8+cEwO1hr8wiTQabAw7KpoW0KfJwOkxW5wUQYQMCGyCeLw==
X-Received: by 2002:a05:6602:1648:b0:7eb:8887:d6c3 with SMTP id ca18e2360f4ac-7f3a4dda0d6mr892264139f.11.1719326156570;
        Tue, 25 Jun 2024 07:35:56 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706a2981baesm342074b3a.180.2024.06.25.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:35:56 -0700 (PDT)
Subject: [net-next PATCH v2 05/15] eth: fbnic: Add message parsing for FW
 messages
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:35:55 -0700
Message-ID: 
 <171932615510.3072535.4681274984793714030.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add FW message formatting and parsing. The TLV format should
look very familiar to those familiar with netlink.
Since we don't have to deal with backward compatibility
we tweaked the format a little to make it easier to deal
with, and more appropriate for tightly coupled interfaces
like driver<>FW communication.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile    |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c |  529 +++++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h |  175 +++++++++
 3 files changed, 706 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index b8f4511440dc..0434ee0b3069 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_FBNIC) += fbnic.o
 fbnic-y := fbnic_devlink.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
-	   fbnic_pci.o
+	   fbnic_pci.o \
+	   fbnic_tlv.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
new file mode 100644
index 000000000000..c0028b4044ce
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/once.h>
+#include <linux/random.h>
+#include <linux/string.h>
+#include <uapi/linux/if_ether.h>
+
+#include "fbnic_tlv.h"
+
+/**
+ *  fbnic_tlv_msg_alloc - Allocate page and initialize FW message header
+ *  @msg_id: Identifier for new message we are starting
+ *
+ *  Return: pointer to start of message, or NULL on failure.
+ *
+ *  Allocates a page and initializes message header at start of page.
+ *  Initial message size is 1 DWORD which is just the header.
+ **/
+struct fbnic_tlv_msg *fbnic_tlv_msg_alloc(u16 msg_id)
+{
+	struct fbnic_tlv_hdr hdr = { 0 };
+	struct fbnic_tlv_msg *msg;
+
+	msg = (struct fbnic_tlv_msg *)__get_free_page(GFP_KERNEL);
+	if (!msg)
+		return NULL;
+
+	/* Start with zero filled header and then back fill with data */
+	hdr.type = msg_id;
+	hdr.is_msg = 1;
+	hdr.len = cpu_to_le16(1);
+
+	/* Copy header into start of message */
+	msg->hdr = hdr;
+
+	return msg;
+}
+
+/**
+ *  fbnic_tlv_attr_put_flag - Add flag value to message
+ *  @msg: Message header we are adding flag attribute to
+ *  @attr_id: ID of flag attribute we are adding to message
+ *
+ *  Return: -ENOSPC if there is no room for the attribute. Otherwise 0.
+ *
+ *  Adds a 1 DWORD flag attribute to the message. The presence of this
+ *  attribute can be used as a boolean value indicating true, otherwise the
+ *  value is considered false.
+ **/
+int fbnic_tlv_attr_put_flag(struct fbnic_tlv_msg *msg, const u16 attr_id)
+{
+	int attr_max_len = PAGE_SIZE - offset_in_page(msg) - sizeof(*msg);
+	struct fbnic_tlv_hdr hdr = { 0 };
+	struct fbnic_tlv_msg *attr;
+
+	attr_max_len -= le16_to_cpu(msg->hdr.len) * sizeof(u32);
+	if (attr_max_len < sizeof(*attr))
+		return -ENOSPC;
+
+	/* Get header pointer and bump attr to start of data */
+	attr = &msg[le16_to_cpu(msg->hdr.len)];
+
+	/* Record attribute type and size */
+	hdr.type = attr_id;
+	hdr.len = cpu_to_le16(sizeof(hdr));
+
+	attr->hdr = hdr;
+	le16_add_cpu(&msg->hdr.len,
+		     FBNIC_TLV_MSG_SIZE(le16_to_cpu(hdr.len)));
+
+	return 0;
+}
+
+/**
+ *  fbnic_tlv_attr_put_value - Add data to message
+ *  @msg: Message header we are adding flag attribute to
+ *  @attr_id: ID of flag attribute we are adding to message
+ *  @value: Pointer to data to be stored
+ *  @len: Size of data to be stored.
+ *
+ *  Return: -ENOSPC if there is no room for the attribute. Otherwise 0.
+ *
+ *  Adds header and copies data pointed to by value into the message. The
+ *  result is rounded up to the nearest DWORD for sizing so that the
+ *  headers remain aligned.
+ *
+ *  The assumption is that the value field is in a format where byte
+ *  ordering can be guaranteed such as a byte array or a little endian
+ *  format.
+ **/
+int fbnic_tlv_attr_put_value(struct fbnic_tlv_msg *msg, const u16 attr_id,
+			     const void *value, const int len)
+{
+	int attr_max_len = PAGE_SIZE - offset_in_page(msg) - sizeof(*msg);
+	struct fbnic_tlv_hdr hdr = { 0 };
+	struct fbnic_tlv_msg *attr;
+
+	attr_max_len -= le16_to_cpu(msg->hdr.len) * sizeof(u32);
+	if (attr_max_len < sizeof(*attr) + len)
+		return -ENOSPC;
+
+	/* Get header pointer and bump attr to start of data */
+	attr = &msg[le16_to_cpu(msg->hdr.len)];
+
+	/* Record attribute type and size */
+	hdr.type = attr_id;
+	hdr.len = cpu_to_le16(sizeof(hdr) + len);
+
+	/* Zero pad end of region to be written if we aren't aligned */
+	if (len % sizeof(hdr))
+		attr->value[len / sizeof(hdr)] = 0;
+
+	/* Copy data over */
+	memcpy(attr->value, value, len);
+
+	attr->hdr = hdr;
+	le16_add_cpu(&msg->hdr.len,
+		     FBNIC_TLV_MSG_SIZE(le16_to_cpu(hdr.len)));
+
+	return 0;
+}
+
+/**
+ *  __fbnic_tlv_attr_put_int - Add integer to message
+ *  @msg: Message header we are adding flag attribute to
+ *  @attr_id: ID of flag attribute we are adding to message
+ *  @value: Data to be stored
+ *  @len: Size of data to be stored, either 4 or 8 bytes.
+ *
+ *  Return: -ENOSPC if there is no room for the attribute. Otherwise 0.
+ *
+ *  Adds header and copies data pointed to by value into the message. Will
+ *  format the data as little endian.
+ **/
+int __fbnic_tlv_attr_put_int(struct fbnic_tlv_msg *msg, const u16 attr_id,
+			     s64 value, const int len)
+{
+	__le64 le64_value = cpu_to_le64(value);
+
+	return fbnic_tlv_attr_put_value(msg, attr_id, &le64_value, len);
+}
+
+/**
+ *  fbnic_tlv_attr_put_mac_addr - Add mac_addr to message
+ *  @msg: Message header we are adding flag attribute to
+ *  @attr_id: ID of flag attribute we are adding to message
+ *  @mac_addr: Byte pointer to MAC address to be stored
+ *
+ *  Return: -ENOSPC if there is no room for the attribute. Otherwise 0.
+ *
+ *  Adds header and copies data pointed to by mac_addr into the message. Will
+ *  copy the address raw so it will be in big endian with start of MAC
+ *  address at start of attribute.
+ **/
+int fbnic_tlv_attr_put_mac_addr(struct fbnic_tlv_msg *msg, const u16 attr_id,
+				const u8 *mac_addr)
+{
+	return fbnic_tlv_attr_put_value(msg, attr_id, mac_addr, ETH_ALEN);
+}
+
+/**
+ *  fbnic_tlv_attr_put_string - Add string to message
+ *  @msg: Message header we are adding flag attribute to
+ *  @attr_id: ID of flag attribute we are adding to message
+ *  @string: Byte pointer to null terminated string to be stored
+ *
+ *  Return: -ENOSPC if there is no room for the attribute. Otherwise 0.
+ *
+ *  Adds header and copies data pointed to by string into the message. Will
+ *  copy the address raw so it will be in byte order.
+ **/
+int fbnic_tlv_attr_put_string(struct fbnic_tlv_msg *msg, u16 attr_id,
+			      const char *string)
+{
+	int attr_max_len = PAGE_SIZE - sizeof(*msg);
+	int str_len = 1;
+
+	/* The max length will be message minus existing message and new
+	 * attribute header. Since the message is measured in DWORDs we have
+	 * to multiply the size by 4.
+	 *
+	 * The string length doesn't include the \0 so we have to add one to
+	 * the final value, so start with that as our initial value.
+	 *
+	 * We will verify if the string will fit in fbnic_tlv_attr_put_value()
+	 */
+	attr_max_len -= le16_to_cpu(msg->hdr.len) * sizeof(u32);
+	str_len += strnlen(string, attr_max_len);
+
+	return fbnic_tlv_attr_put_value(msg, attr_id, string, str_len);
+}
+
+/**
+ *  fbnic_tlv_attr_get_unsigned - Retrieve unsigned value from result
+ *  @attr: Attribute to retrieve data from
+ *
+ *  Return: unsigned 64b value containing integer value
+ **/
+u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr)
+{
+	__le64 le64_value = 0;
+
+	memcpy(&le64_value, &attr->value[0],
+	       le16_to_cpu(attr->hdr.len) - sizeof(*attr));
+
+	return le64_to_cpu(le64_value);
+}
+
+/**
+ *  fbnic_tlv_attr_get_signed - Retrieve signed value from result
+ *  @attr: Attribute to retrieve data from
+ *
+ *  Return: signed 64b value containing integer value
+ **/
+s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr)
+{
+	int shift = (8 + sizeof(*attr) - le16_to_cpu(attr->hdr.len)) * 8;
+	__le64 le64_value = 0;
+	s64 value;
+
+	/* Copy the value and adjust for byte ordering */
+	memcpy(&le64_value, &attr->value[0],
+	       le16_to_cpu(attr->hdr.len) - sizeof(*attr));
+	value = le64_to_cpu(le64_value);
+
+	/* Sign extend the return value by using a pair of shifts */
+	return (value << shift) >> shift;
+}
+
+/**
+ * fbnic_tlv_attr_get_string - Retrieve string value from result
+ * @attr: Attribute to retrieve data from
+ * @str: Pointer to an allocated string to store the data
+ * @max_size: The maximum size which can be in str
+ *
+ * Return: the size of the string read from firmware
+ **/
+size_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *str,
+				 size_t max_size)
+{
+	max_size = min_t(size_t, max_size,
+			 (le16_to_cpu(attr->hdr.len) * 4) - sizeof(*attr));
+	memcpy(str, &attr->value, max_size);
+
+	return max_size;
+}
+
+/**
+ *  fbnic_tlv_attr_nest_start - Add nested attribute header to message
+ *  @msg: Message header we are adding flag attribute to
+ *  @attr_id: ID of flag attribute we are adding to message
+ *
+ *  Return: NULL if there is no room for the attribute. Otherwise a pointer
+ *  to the new attribute header.
+ *
+ *  New header length is stored initially in DWORDs.
+ **/
+struct fbnic_tlv_msg *fbnic_tlv_attr_nest_start(struct fbnic_tlv_msg *msg,
+						u16 attr_id)
+{
+	int attr_max_len = PAGE_SIZE - offset_in_page(msg) - sizeof(*msg);
+	struct fbnic_tlv_msg *attr = &msg[le16_to_cpu(msg->hdr.len)];
+	struct fbnic_tlv_hdr hdr = { 0 };
+
+	/* Make sure we have space for at least the nest header plus one more */
+	attr_max_len -= le16_to_cpu(msg->hdr.len) * sizeof(u32);
+	if (attr_max_len < sizeof(*attr) * 2)
+		return NULL;
+
+	/* Record attribute type and size */
+	hdr.type = attr_id;
+
+	/* Add current message length to account for consumption within the
+	 * page and leave it as a multiple of DWORDs, we will shift to
+	 * bytes when we close it out.
+	 */
+	hdr.len = cpu_to_le16(1);
+
+	attr->hdr = hdr;
+
+	return attr;
+}
+
+/**
+ *  fbnic_tlv_attr_nest_stop - Close out nested attribute and add it to message
+ *  @msg: Message header we are adding flag attribute to
+ *
+ *  Closes out nested attribute, adds length to message, and then bumps
+ *  length from DWORDs to bytes to match other attributes.
+ **/
+void fbnic_tlv_attr_nest_stop(struct fbnic_tlv_msg *msg)
+{
+	struct fbnic_tlv_msg *attr = &msg[le16_to_cpu(msg->hdr.len)];
+	u16 len = le16_to_cpu(attr->hdr.len);
+
+	/* Add attribute to message if there is more than just a header */
+	if (len <= 1)
+		return;
+
+	le16_add_cpu(&msg->hdr.len, len);
+
+	/* Convert from DWORDs to bytes */
+	attr->hdr.len = cpu_to_le16(len * sizeof(u32));
+}
+
+static int
+fbnic_tlv_attr_validate(struct fbnic_tlv_msg *attr,
+			const struct fbnic_tlv_index *tlv_index)
+{
+	u16 len = le16_to_cpu(attr->hdr.len) - sizeof(*attr);
+	u16 attr_id = attr->hdr.type;
+	__le32 *value = &attr->value[0];
+
+	if (attr->hdr.is_msg)
+		return -EINVAL;
+
+	if (attr_id >= FBNIC_TLV_RESULTS_MAX)
+		return -EINVAL;
+
+	while (tlv_index->id != attr_id) {
+		if  (tlv_index->id == FBNIC_TLV_ATTR_ID_UNKNOWN) {
+			if (attr->hdr.cannot_ignore)
+				return -ENOENT;
+			return le16_to_cpu(attr->hdr.len);
+		}
+
+		tlv_index++;
+	}
+
+	if (offset_in_page(attr) + len > PAGE_SIZE - sizeof(*attr))
+		return -E2BIG;
+
+	switch (tlv_index->type) {
+	case FBNIC_TLV_STRING:
+		if (!len || len > tlv_index->len)
+			return -EINVAL;
+		if (((char *)value)[len - 1])
+			return -EINVAL;
+		break;
+	case FBNIC_TLV_FLAG:
+		if (len)
+			return -EINVAL;
+		break;
+	case FBNIC_TLV_UNSIGNED:
+	case FBNIC_TLV_SIGNED:
+		if (tlv_index->len > sizeof(__le64))
+			return -EINVAL;
+		fallthrough;
+	case FBNIC_TLV_BINARY:
+		if (!len || len > tlv_index->len)
+			return -EINVAL;
+		break;
+	case FBNIC_TLV_NESTED:
+	case FBNIC_TLV_ARRAY:
+		if (len % 4)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ *  fbnic_tlv_attr_parse_array - Parse array of attributes into results array
+ *  @attr: Start of attributes in the message
+ *  @len: Length of attributes in the message
+ *  @results: Array of pointers to store the results of parsing
+ *  @tlv_index: List of TLV attributes to be parsed from message
+ *  @tlv_attr_id: Specific ID that is repeated in array
+ *  @array_len: Number of results to store in results array
+ *
+ *  Return: zero on success, or negative value on error.
+ *
+ *  Will take a list of attributes and a parser definition and will capture
+ *  the results in the results array to have the data extracted later.
+ **/
+int fbnic_tlv_attr_parse_array(struct fbnic_tlv_msg *attr, int len,
+			       struct fbnic_tlv_msg **results,
+			       const struct fbnic_tlv_index *tlv_index,
+			       u16 tlv_attr_id, size_t array_len)
+{
+	int i = 0;
+
+	/* Initialize results table to NULL. */
+	memset(results, 0, array_len * sizeof(results[0]));
+
+	/* Nothing to parse if header was only thing there */
+	if (!len)
+		return 0;
+
+	/* Work through list of attributes, parsing them as necessary */
+	while (len > 0) {
+		u16 attr_id = attr->hdr.type;
+		u16 attr_len;
+		int err;
+
+		if (tlv_attr_id != attr_id)
+			return -EINVAL;
+
+		/* Stop parsing on full error */
+		err = fbnic_tlv_attr_validate(attr, tlv_index);
+		if (err < 0)
+			return err;
+
+		if (i >= array_len)
+			return -ENOSPC;
+
+		results[i++] = attr;
+
+		attr_len = FBNIC_TLV_MSG_SIZE(le16_to_cpu(attr->hdr.len));
+		len -= attr_len;
+		attr += attr_len;
+	}
+
+	return len == 0 ? 0 : -EINVAL;
+}
+
+/**
+ *  fbnic_tlv_attr_parse - Parse attributes into a list of attribute results
+ *  @attr: Start of attributes in the message
+ *  @len: Length of attributes in the message
+ *  @results: Array of pointers to store the results of parsing
+ *  @tlv_index: List of TLV attributes to be parsed from message
+ *
+ *  Return: zero on success, or negative value on error.
+ *
+ *  Will take a list of attributes and a parser definition and will capture
+ *  the results in the results array to have the data extracted later.
+ **/
+int fbnic_tlv_attr_parse(struct fbnic_tlv_msg *attr, int len,
+			 struct fbnic_tlv_msg **results,
+			 const struct fbnic_tlv_index *tlv_index)
+{
+	/* Initialize results table to NULL. */
+	memset(results, 0, sizeof(results[0]) * FBNIC_TLV_RESULTS_MAX);
+
+	/* Nothing to parse if header was only thing there */
+	if (!len)
+		return 0;
+
+	/* Work through list of attributes, parsing them as necessary */
+	while (len > 0) {
+		int err = fbnic_tlv_attr_validate(attr, tlv_index);
+		u16 attr_id = attr->hdr.type;
+		u16 attr_len;
+
+		/* Stop parsing on full error */
+		if (err < 0)
+			return err;
+
+		/* Ignore results for unsupported values */
+		if (!err) {
+			/* Do not overwrite existing entries */
+			if (results[attr_id])
+				return -EADDRINUSE;
+
+			results[attr_id] = attr;
+		}
+
+		attr_len = FBNIC_TLV_MSG_SIZE(le16_to_cpu(attr->hdr.len));
+		len -= attr_len;
+		attr += attr_len;
+	}
+
+	return len == 0 ? 0 : -EINVAL;
+}
+
+/**
+ *  fbnic_tlv_msg_parse - Parse message and process via predetermined functions
+ *  @opaque: Value passed to parser function to enable driver access
+ *  @msg: Message to be parsed.
+ *  @parser: TLV message parser definition.
+ *
+ *  Return: zero on success, or negative value on error.
+ *
+ *  Will take a message a number of message types via the attribute parsing
+ *  definitions and function provided for the parser array.
+ **/
+int fbnic_tlv_msg_parse(void *opaque, struct fbnic_tlv_msg *msg,
+			const struct fbnic_tlv_parser *parser)
+{
+	struct fbnic_tlv_msg *results[FBNIC_TLV_RESULTS_MAX];
+	u16 msg_id = msg->hdr.type;
+	int err;
+
+	if (!msg->hdr.is_msg)
+		return -EINVAL;
+
+	if (le16_to_cpu(msg->hdr.len) > PAGE_SIZE / sizeof(u32))
+		return -E2BIG;
+
+	while (parser->id != msg_id) {
+		if (parser->id == FBNIC_TLV_MSG_ID_UNKNOWN)
+			return -ENOENT;
+		parser++;
+	}
+
+	err = fbnic_tlv_attr_parse(&msg[1], le16_to_cpu(msg->hdr.len) - 1,
+				   results, parser->attr);
+	if (err)
+		return err;
+
+	return parser->func(opaque, results);
+}
+
+/**
+ *  fbnic_tlv_parser_error - called if message doesn't match known type
+ *  @opaque: (unused)
+ *  @results: (unused)
+ *
+ *  Return: -EBADMSG to indicate the message is an unsupported type
+ **/
+int fbnic_tlv_parser_error(void *opaque, struct fbnic_tlv_msg **results)
+{
+	return -EBADMSG;
+}
+
+void fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src)
+{
+	u8 *mac_addr;
+
+	mac_addr = fbnic_tlv_attr_get_value_ptr(src);
+	memcpy(dest, mac_addr, ETH_ALEN);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
new file mode 100644
index 000000000000..67300ab44353
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_TLV_H_
+#define _FBNIC_TLV_H_
+
+#include <asm/byteorder.h>
+#include <linux/bits.h>
+#include <linux/const.h>
+#include <linux/types.h>
+
+#define FBNIC_TLV_MSG_ALIGN(len)	ALIGN(len, sizeof(u32))
+#define FBNIC_TLV_MSG_SIZE(len)		\
+		(FBNIC_TLV_MSG_ALIGN(len) / sizeof(u32))
+
+/* TLV Header Format
+ *    3			  2		      1
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |		Length		   |M|I|RSV|	   Type / ID	   |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * The TLV header format described above will be used for transferring
+ * messages between the host and the firmware. To ensure byte ordering
+ * we have defined all fields as being little endian.
+ * Type/ID: Identifier for message and/or attribute
+ * RSV: Reserved field for future use, likely as additional flags
+ * I: cannot_ignore flag, identifies if unrecognized attribute can be ignored
+ * M: is_msg, indicates that this is the start of a new message
+ * Length: Total length of message in dwords including header
+ *		or
+ *	   Total length of attribute in bytes including header
+ */
+struct fbnic_tlv_hdr {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u16 type		: 12; /* 0 .. 11  Type / ID */
+	u16 rsvd		: 2;  /* 12 .. 13 Reserved for future use */
+	u16 cannot_ignore	: 1;  /* 14	  Attribute can be ignored */
+	u16 is_msg		: 1;  /* 15	  Header belongs to message */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u16 is_msg		: 1;  /* 15	  Header belongs to message */
+	u16 cannot_ignore	: 1;  /* 14	  Attribute can be ignored */
+	u16 rsvd		: 2;  /* 13 .. 12 Reserved for future use */
+	u16 type		: 12; /* 11 .. 0  Type / ID */
+#else
+#error "Missing defines from byteorder.h"
+#endif
+	__le16 len;		/* 16 .. 32	length including TLV header */
+};
+
+#define FBNIC_TLV_RESULTS_MAX		32
+
+struct fbnic_tlv_msg {
+	struct fbnic_tlv_hdr	hdr;
+	__le32			value[];
+};
+
+#define FBNIC_TLV_MSG_ID_UNKNOWN		USHRT_MAX
+
+enum fbnic_tlv_type {
+	FBNIC_TLV_STRING,
+	FBNIC_TLV_FLAG,
+	FBNIC_TLV_UNSIGNED,
+	FBNIC_TLV_SIGNED,
+	FBNIC_TLV_BINARY,
+	FBNIC_TLV_NESTED,
+	FBNIC_TLV_ARRAY,
+	__FBNIC_TLV_MAX_TYPE
+};
+
+/* TLV Index
+ * Defines the relationship between the attribute IDs and their types.
+ * For each entry in the index there will be a size and type associated
+ * with it so that we can use this to parse the data and verify it matches
+ * the expected layout.
+ */
+struct fbnic_tlv_index {
+	u16			id;
+	u16			len;
+	enum fbnic_tlv_type	type;
+};
+
+#define TLV_MAX_DATA			(PAGE_SIZE - 512)
+#define FBNIC_TLV_ATTR_ID_UNKNOWN	USHRT_MAX
+#define FBNIC_TLV_ATTR_STRING(id, len)	{ id, len, FBNIC_TLV_STRING }
+#define FBNIC_TLV_ATTR_FLAG(id)		{ id, 0, FBNIC_TLV_FLAG }
+#define FBNIC_TLV_ATTR_U32(id)		{ id, sizeof(u32), FBNIC_TLV_UNSIGNED }
+#define FBNIC_TLV_ATTR_U64(id)		{ id, sizeof(u64), FBNIC_TLV_UNSIGNED }
+#define FBNIC_TLV_ATTR_S32(id)		{ id, sizeof(s32), FBNIC_TLV_SIGNED }
+#define FBNIC_TLV_ATTR_S64(id)		{ id, sizeof(s64), FBNIC_TLV_SIGNED }
+#define FBNIC_TLV_ATTR_MAC_ADDR(id)	{ id, ETH_ALEN, FBNIC_TLV_BINARY }
+#define FBNIC_TLV_ATTR_NESTED(id)	{ id, 0, FBNIC_TLV_NESTED }
+#define FBNIC_TLV_ATTR_ARRAY(id)	{ id, 0, FBNIC_TLV_ARRAY }
+#define FBNIC_TLV_ATTR_RAW_DATA(id)	{ id, TLV_MAX_DATA, FBNIC_TLV_BINARY }
+#define FBNIC_TLV_ATTR_LAST		{ FBNIC_TLV_ATTR_ID_UNKNOWN, 0, 0 }
+
+struct fbnic_tlv_parser {
+	u16				id;
+	const struct fbnic_tlv_index	*attr;
+	int				(*func)(void *opaque,
+						struct fbnic_tlv_msg **results);
+};
+
+#define FBNIC_TLV_PARSER(id, attr, func) { FBNIC_TLV_MSG_ID_##id, attr, func }
+
+static inline void *
+fbnic_tlv_attr_get_value_ptr(struct fbnic_tlv_msg *attr)
+{
+	return (void *)&attr->value[0];
+}
+
+static inline bool fbnic_tlv_attr_get_bool(struct fbnic_tlv_msg *attr)
+{
+	return !!attr;
+}
+
+u64 fbnic_tlv_attr_get_unsigned(struct fbnic_tlv_msg *attr);
+s64 fbnic_tlv_attr_get_signed(struct fbnic_tlv_msg *attr);
+size_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *str,
+				 size_t max_size);
+
+#define get_unsigned_result(id, location) \
+do { \
+	struct fbnic_tlv_msg *result = results[id]; \
+	if (result) \
+		location = fbnic_tlv_attr_get_unsigned(result); \
+} while (0)
+
+#define get_signed_result(id, location) \
+do { \
+	struct fbnic_tlv_msg *result = results[id]; \
+	if (result) \
+		location = fbnic_tlv_attr_get_signed(result); \
+} while (0)
+
+#define get_string_result(id, size, str, max_size) \
+do { \
+	struct fbnic_tlv_msg *result = results[id]; \
+	if (result) \
+		size = fbnic_tlv_attr_get_string(result, str, max_size); \
+} while (0)
+
+#define get_bool(id) (!!(results[id]))
+
+struct fbnic_tlv_msg *fbnic_tlv_msg_alloc(u16 msg_id);
+int fbnic_tlv_attr_put_flag(struct fbnic_tlv_msg *msg, const u16 attr_id);
+int fbnic_tlv_attr_put_value(struct fbnic_tlv_msg *msg, const u16 attr_id,
+			     const void *value, const int len);
+int __fbnic_tlv_attr_put_int(struct fbnic_tlv_msg *msg, const u16 attr_id,
+			     s64 value, const int len);
+#define fbnic_tlv_attr_put_int(msg, attr_id, value) \
+	__fbnic_tlv_attr_put_int(msg, attr_id, value, \
+				 FBNIC_TLV_MSG_ALIGN(sizeof(value)))
+int fbnic_tlv_attr_put_mac_addr(struct fbnic_tlv_msg *msg, const u16 attr_id,
+				const u8 *mac_addr);
+int fbnic_tlv_attr_put_string(struct fbnic_tlv_msg *msg, u16 attr_id,
+			      const char *string);
+struct fbnic_tlv_msg *fbnic_tlv_attr_nest_start(struct fbnic_tlv_msg *msg,
+						u16 attr_id);
+void fbnic_tlv_attr_nest_stop(struct fbnic_tlv_msg *msg);
+void fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src);
+int fbnic_tlv_attr_parse_array(struct fbnic_tlv_msg *attr, int len,
+			       struct fbnic_tlv_msg **results,
+			       const struct fbnic_tlv_index *tlv_index,
+			       u16 tlv_attr_id, size_t array_len);
+int fbnic_tlv_attr_parse(struct fbnic_tlv_msg *attr, int len,
+			 struct fbnic_tlv_msg **results,
+			 const struct fbnic_tlv_index *tlv_index);
+int fbnic_tlv_msg_parse(void *opaque, struct fbnic_tlv_msg *msg,
+			const struct fbnic_tlv_parser *parser);
+int fbnic_tlv_parser_error(void *opaque, struct fbnic_tlv_msg **results);
+
+#define FBNIC_TLV_MSG_ERROR \
+	FBNIC_TLV_PARSER(UNKNOWN, NULL, fbnic_tlv_parser_error)
+#endif /* _FBNIC_TLV_H_ */



