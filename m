Return-Path: <netdev+bounces-291439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHGiBcOnFGrJPAcAu9opvQ
	(envelope-from <netdev+bounces-291439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D05CE201
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EC6B302DF65
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD03D380FF5;
	Mon, 25 May 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKSHqW1c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885D390C9E
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738514; cv=none; b=i2ABm4WzQzKOYp+xibAWtw76H0GVOGQY5YgW/e8rUov+6ipiWb28UdiCX7ZOGt32ZkFT5nRaKzgnRIXZL8GuwDTNpOe9wgc58gb5juDqP+uCfSWsPMsJ0rSQLuWWEzywOJLXBIJWdCVRQxoFQSTwV4VoYPx/vBnxFn0B/PVQ3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738514; c=relaxed/simple;
	bh=PSGCU2UYEeg4oXifn/jaI62tJGuUoZ9/xIQtUdVBbBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIgNLjdDui5nntquBrEZfnUyTPf6NtxO2iT1g9kd5trLpXALoQD69C8b/TMkbTQaxyYVlw+KYqHCMfvrVawd8+L0igAEDx+sbbCo7FJkDUV7z1R9APrmFDc02mbiUqwxYg5S+BJv0dc2i6va6J/tD0mt9Gm5LoNzx84x2hWIF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKSHqW1c; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6312bdd281eso9087195137.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738511; x=1780343311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAI9SLk7emEWuq1aurvMjpBMDuISbK43tgeQlNFK5sE=;
        b=sKSHqW1cbGjpq/s8m7Hop/4MLdUZRf9yRPVhZi62teJYVxaK6qBTDPboYAAv5eUhKD
         mhl+rNiBEYPKvtd1OBE5MMgMfqEQnoYB1uxqhPbBQRPuu66bC0eDe0lm7wOUVksYpctZ
         L4kkCj85Gr+uhkjQVdqWZHjl4WXgJUSem3AuGAyqYN4RXJ3shOcJAyVUj0eLBUW+rGFj
         KByUYBS99jJ/t9Zu4MonbfQblzyXEINiAo7a+SKxcDEjGQiIXqKbXq81afz8oVoIQQBh
         +gBb5GbpDVJeqdjvHsAcDBbizcgNvjnxBcRPO/pkYmQ/tmfdojLsTVVpGhc4lvzmDstl
         MZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738511; x=1780343311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mAI9SLk7emEWuq1aurvMjpBMDuISbK43tgeQlNFK5sE=;
        b=lwU6m1Xh/9XaXAsgU46bTO4Yr/I8ilcTfATh0GFDApyzvyW7YFaSdqRtU0UAHabain
         0AqB60aZJ4TAKysnAD9EzhxtsIK6dGWBsub5Us16/v8hzZMTsvbLXOCminnKjnho9pQo
         ePhIkzsJxjACWKjnFk9xm37F49kNRp38+7mtAJwbrzdzh2PGr8V1CDMucalS8tXfvBu9
         8fULhFGq1LK29npAx/NiKdJKJZVjIxRwHEdqFfRZDeHBxFLNpoYpIYSjtMulCiGqianI
         2JTDE/iYl2fmviErfQ6MfXrIIehm5IYQqb+RvaKUMgit9ouDhrzIa40Hh3+Yv75IHo2Z
         Vc2g==
X-Gm-Message-State: AOJu0Yxull69+gL5ZHGZOSPAJYUOTHP8L+6WedXW6ecWskYbHaLdI77B
	Z73Wge5nMDV0QCocOHYox+8U3VgiG7AwDsct3LE2p56Wmn1f5nEbzRyb
X-Gm-Gg: Acq92OFQqpblwBETKfAih3hE2EKae+Bv7V46V5xQjTBLg16NpLCQN6Qaa+DfvyajEQ7
	/3btbTYpUGMdFMNUVaLOhQDyMPKDWk7jWq1YY9s+D6eeCaqnAe7j4tp80Vo/tNUBD+35v4/kQpM
	LOeRrY+V1V4I7w+M0mJm0abtkhZCjXzWmucYKtVfcIx1YSmVyVZRfDXrXv4+l0tsS8N9wgqQH6Z
	qAKLdDVl6lrH1ixxfeNE01vjYDFeg2ceU9bEkraryE2B7WZDQINPmk5lFIvtkWzDqTjcLUAMkQk
	d+TDzDBZ8wu/EZFnPrhHsUGZh9rO+sndgmCRWZMvCsvZChzs7CJK+0gjTCELPhGowtyLXzSS0hX
	YDSYe3sddyQiIAZljn12BUEEj35KytWOKxww32ZiJBG4C9rQ0iqPBTvwWt4SPKS0M14Z71qiW6k
	TbYRN2dKoXeHSGt/Nqo2lbfasA0gsDysJxvRB6LklRFFwSCrb2
X-Received: by 2002:a05:6102:1453:10b0:633:9ac8:6bfd with SMTP id ada2fe7eead31-673bf88569amr6501872137.4.1779738511157;
        Mon, 25 May 2026 12:48:31 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm11092456241.10.2026.05.25.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:48:30 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 25 May 2026 16:48:00 -0300
Subject: [net-next PATCH v8 4/8] net: dsa: realtek: rtl8365mb: add table
 lookup interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260525-realtek_forward-v8-4-5eb80a4675be@gmail.com>
References: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
In-Reply-To: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291439-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 878D05CE201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Add a generic table lookup interface to centralize access to
the RTL8365MB internal tables.

This interface abstracts the low-level table access logic and
will be used by subsequent commits to implement FDB and VLAN
operations.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile          |   1 +
 drivers/net/dsa/realtek/rtl8365mb_table.c | 220 ++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_table.h | 134 ++++++++++++++++++
 3 files changed, 355 insertions(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 3f986e04912f..99654c4c5a3d 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -17,3 +17,4 @@ rtl8366-objs 				+= rtl8366rb-leds.o
 endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
 rtl8365mb-objs := rtl8365mb_main.o \
+		  rtl8365mb_table.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb_table.c b/drivers/net/dsa/realtek/rtl8365mb_table.c
new file mode 100644
index 000000000000..2c679346e0c9
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_table.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Look-up table query interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ */
+
+#include "rtl8365mb_table.h"
+#include <linux/regmap.h>
+
+/* Table access control register */
+#define RTL8365MB_TABLE_CTRL_REG		0x0500
+/* Should be one of rtl8365mb_table enum members */
+#define   RTL8365MB_TABLE_CTRL_TABLE_MASK	GENMASK(2, 0)
+/* Should be one of rtl8365mb_table_op enum members */
+#define   RTL8365MB_TABLE_CTRL_OP_MASK		GENMASK(3, 3)
+/* Should be one of rtl8365mb_table_l2_method enum members */
+#define   RTL8365MB_TABLE_CTRL_METHOD_MASK	GENMASK(7, 4)
+/* NOTE: PORT_MASK is only 4 bit, which suggests that port-based
+ * look-up of the L2 table only works for physical port addresses
+ * 0~4. It could be that the Realtek driver is out-of-date and
+ * actually the mask is something like 0xFF00, but this is
+ * unconfirmed.
+ */
+#define   RTL8365MB_TABLE_CTRL_PORT_MASK	GENMASK(11, 8)
+
+/* Table access address register */
+#define RTL8365MB_TABLE_ACCESS_ADDR_REG		0x0501
+#define   RTL8365MB_TABLE_ADDR_MASK		GENMASK(12, 0)
+
+/* Table status register */
+#define RTL8365MB_TABLE_STATUS_REG			0x0502
+#define   RTL8365MB_TABLE_STATUS_ADDRESS_MASK		GENMASK(10, 0)
+/* set for L3, unset for L2  */
+#define   RTL8365MB_TABLE_STATUS_ADDR_TYPE_MASK		GENMASK(11, 11)
+#define   RTL8365MB_TABLE_STATUS_HIT_STATUS_MASK	GENMASK(12, 12)
+#define   RTL8365MB_TABLE_STATUS_BUSY_FLAG_MASK		GENMASK(13, 13)
+#define   RTL8365MB_TABLE_STATUS_ADDRESS_EXT_MASK	GENMASK(14, 14)
+
+/* Table read/write registers */
+#define RTL8365MB_TABLE_WRITE_BASE			0x0510
+#define RTL8365MB_TABLE_WRITE_REG(_x) \
+		(RTL8365MB_TABLE_WRITE_BASE + (_x))
+#define RTL8365MB_TABLE_READ_BASE			0x0520
+#define RTL8365MB_TABLE_READ_REG(_x) \
+		(RTL8365MB_TABLE_READ_BASE + (_x))
+#define RTL8365MB_TABLE_10TH_DATA_MASK			GENMASK(3, 0)
+#define RTL8365MB_TABLE_WRITE_10TH_REG \
+		RTL8365MB_TABLE_WRITE_REG(RTL8365MB_TABLE_ENTRY_MAX_SIZE - 1)
+
+static int rtl8365mb_table_poll_busy(struct realtek_priv *priv)
+{
+	u32 val;
+
+	return regmap_read_poll_timeout(priv->map_nolock,
+			RTL8365MB_TABLE_STATUS_REG, val,
+			!FIELD_GET(RTL8365MB_TABLE_STATUS_BUSY_FLAG_MASK, val),
+			10, 10000);
+}
+
+int rtl8365mb_table_query(struct realtek_priv *priv,
+			  enum rtl8365mb_table table,
+			  enum rtl8365mb_table_op op, u16 *addr,
+			  enum rtl8365mb_table_l2_method method,
+			  u16 port, u16 *data, size_t size)
+{
+	bool addr_as_input = true;
+	bool write_data = false;
+	int ret = 0;
+	u32 cmd;
+	u32 val;
+	u32 hit;
+
+	/* Prepare target table and operation (read or write) */
+	cmd = 0;
+	cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_TABLE_MASK, table);
+	cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_OP_MASK, op);
+	if (op == RTL8365MB_TABLE_OP_READ && table == RTL8365MB_TABLE_L2) {
+		cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_METHOD_MASK, method);
+		switch (method) {
+		case RTL8365MB_TABLE_L2_METHOD_MAC:
+			/*
+			 * Method MAC requires as input the same L2 table format
+			 * you'll get as result. However, it might only use mac
+			 * address and FID/VID fields.
+			 */
+			write_data = true;
+
+			/* METHOD_MAC does not use addr as input, but may return
+			 * the matched index.
+			 */
+			addr_as_input = false;
+
+			break;
+		case RTL8365MB_TABLE_L2_METHOD_ADDR:
+		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT:
+		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC:
+		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC:
+			break;
+		case RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT:
+			cmd |= FIELD_PREP(RTL8365MB_TABLE_CTRL_PORT_MASK, port);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else if (op == RTL8365MB_TABLE_OP_WRITE) {
+		write_data = true;
+
+		/* Writing to L2 does not use addr as input, as the table index
+		 * is derived from key fields.
+		 */
+		if (table == RTL8365MB_TABLE_L2)
+			addr_as_input = false;
+	}
+
+	/* To prevent concurrent access to the look-up tables, take the regmap
+	 * lock manually and access via the map_nolock regmap.
+	 */
+	mutex_lock(&priv->map_lock);
+
+	/* Protect from a busy table access (i.e. previous access timeouts) */
+	ret = rtl8365mb_table_poll_busy(priv);
+	if (ret)
+		goto out;
+
+	/* Write entry data if writing to the table (or L2_METHOD_MAC) */
+	if (write_data) {
+		/* bulk write data up to 9th word */
+		ret = regmap_bulk_write(priv->map_nolock,
+					RTL8365MB_TABLE_WRITE_BASE,
+					data,
+					min_t(size_t, size,
+					      RTL8365MB_TABLE_ENTRY_MAX_SIZE -
+						      1));
+		if (ret)
+			goto out;
+
+		/* 10th register uses only 4 least significant bits */
+		if (size == RTL8365MB_TABLE_ENTRY_MAX_SIZE) {
+			val = FIELD_PREP(RTL8365MB_TABLE_10TH_DATA_MASK,
+					 data[size - 1]);
+			ret = regmap_update_bits(priv->map_nolock,
+						 RTL8365MB_TABLE_WRITE_10TH_REG,
+						 RTL8365MB_TABLE_10TH_DATA_MASK,
+						 val);
+		}
+
+		if (ret)
+			goto out;
+	}
+
+	/* Write address (if needed) */
+	if (addr_as_input) {
+		ret = regmap_write(priv->map_nolock,
+				   RTL8365MB_TABLE_ACCESS_ADDR_REG,
+				   FIELD_PREP(RTL8365MB_TABLE_ADDR_MASK,
+					      *addr));
+		if (ret)
+			goto out;
+	}
+
+	/* Execute */
+	ret = regmap_write(priv->map_nolock, RTL8365MB_TABLE_CTRL_REG, cmd);
+	if (ret)
+		goto out;
+
+	/* Poll for completion */
+	ret = rtl8365mb_table_poll_busy(priv);
+	if (ret)
+		goto out;
+
+	/* For both reads and writes to the L2 table, check status */
+	if (table == RTL8365MB_TABLE_L2) {
+		ret = regmap_read(priv->map_nolock, RTL8365MB_TABLE_STATUS_REG,
+				  &val);
+		if (ret)
+			goto out;
+
+		/* Did the query find an entry? */
+		hit = FIELD_GET(RTL8365MB_TABLE_STATUS_HIT_STATUS_MASK, val);
+		if (!hit) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		/* If so, extract the address */
+		*addr = 0;
+		*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDRESS_MASK, val);
+		*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDRESS_EXT_MASK, val)
+			 << 11;
+		/* only set if it is a L3 address */
+		*addr |= FIELD_GET(RTL8365MB_TABLE_STATUS_ADDR_TYPE_MASK, val)
+			 << 12;
+	}
+
+	/* Finally, get the table entry if we were reading */
+	if (op == RTL8365MB_TABLE_OP_READ) {
+		ret = regmap_bulk_read(priv->map_nolock,
+				       RTL8365MB_TABLE_READ_BASE,
+				       data, size);
+		if (ret)
+			goto out;
+
+		/* For the biggest table entries, the uppermost table
+		 * entry register has space for only one nibble. Mask
+		 * out the remainder bits. Empirically I saw nothing
+		 * wrong with omitting this mask, but it may prevent
+		 * unwanted behaviour. FYI.
+		 */
+		if (size == RTL8365MB_TABLE_ENTRY_MAX_SIZE) {
+			val = FIELD_GET(RTL8365MB_TABLE_10TH_DATA_MASK,
+					data[size - 1]);
+			data[size - 1] = val;
+		}
+	}
+
+out:
+	mutex_unlock(&priv->map_lock);
+
+	return ret;
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_table.h b/drivers/net/dsa/realtek/rtl8365mb_table.h
new file mode 100644
index 000000000000..236d91cb59c8
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_table.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Look-up table query interface for the rtl8365mb switch family
+ *
+ * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ */
+
+#ifndef _REALTEK_RTL8365MB_TABLE_H
+#define _REALTEK_RTL8365MB_TABLE_H
+
+#include <linux/if_ether.h>
+#include <linux/types.h>
+
+#include "realtek.h"
+
+#define RTL8365MB_TABLE_ENTRY_MAX_SIZE			10
+
+/**
+ * enum rtl8365mb_table - available switch tables
+ * @RTL8365MB_TABLE_ACL_RULE: ACL rules
+ * @RTL8365MB_TABLE_ACL_ACTION: ACL actions
+ * @RTL8365MB_TABLE_CVLAN: VLAN4k configurations
+ * @RTL8365MB_TABLE_L2: filtering database (2K hash table)
+ * @RTL8365MB_TABLE_IGMP_GROUP: IGMP group database (readonly)
+ *
+ * NOTE: Don't change the enum values. They must concur with the field
+ * described by @RTL8365MB_TABLE_CTRL_TABLE_MASK.
+ */
+enum rtl8365mb_table {
+	RTL8365MB_TABLE_ACL_RULE = 1,
+	RTL8365MB_TABLE_ACL_ACTION = 2,
+	RTL8365MB_TABLE_CVLAN = 3,
+	RTL8365MB_TABLE_L2 = 4,
+	RTL8365MB_TABLE_IGMP_GROUP = 5,
+};
+
+/**
+ * enum rtl8365mb_table_op - table query operation
+ * @RTL8365MB_TABLE_OP_READ: read an entry from the target table
+ * @RTL8365MB_TABLE_OP_WRITE: write an entry to the target table
+ *
+ * NOTE: Don't change the enum values. They must concur with the field
+ * described by @RTL8365MB_TABLE_CTRL_OP_MASK.
+ */
+enum rtl8365mb_table_op {
+	RTL8365MB_TABLE_OP_READ = 0,
+	RTL8365MB_TABLE_OP_WRITE = 1,
+};
+
+/**
+ * enum rtl8365mb_table_l2_method - look-up method for read queries of L2 table
+ * @RTL8365MB_TABLE_L2_METHOD_MAC: look-up by source MAC address and FID (or
+ *   VID)
+ * @RTL8365MB_TABLE_L2_METHOD_ADDR: look-up by entry address
+ * @RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT: look-up next entry starting from the
+ *   supplied address
+ * @RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC: same as ADDR_NEXT but search only
+ *   unicast addresses
+ * @RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC: same as ADDR_NEXT but search only
+ *   multicast addresses
+ * @RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT: same as ADDR_NEXT_UC but
+ *   search only entries with matching source port
+ *
+ * NOTE: Don't change the enum values. They must concur with the field
+ * described by @RTL8365MB_TABLE_CTRL_METHOD_MASK
+ */
+enum rtl8365mb_table_l2_method {
+	RTL8365MB_TABLE_L2_METHOD_MAC = 0,
+	RTL8365MB_TABLE_L2_METHOD_ADDR = 1,
+	RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT = 2,
+	RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC = 3,
+	RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC = 4,
+	/*
+	 * RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC_L3 = 5,
+	 * RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_MC_L2L3 = 6,
+	 */
+	RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT = 7,
+};
+
+/**
+ * rtl8365mb_table_query() - read from or write to a switch table
+ * @priv: driver context
+ * @table: target table, see &enum rtl8365mb_table
+ * @op: read or write operation, see &enum rtl8365mb_table_op
+ * @addr: table address. For indexed tables, this selects the entry to access.
+ *        For L2 read queries, it is ignored as input for MAC-based lookup
+ *        methods and used as input for address-based lookup methods. On
+ *        successful L2 queries, it is updated with the matched entry address.
+ * @method: L2 table lookup method, see &enum rtl8365mb_table_l2_method.
+ *	    Ignored for non-L2 tables.
+ * @port: for L2 read queries using method
+ *        %RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT, restrict the search
+ *        to entries associated with this source port. Ignored otherwise.
+ * @data: data buffer used to read from or write to the table. For L2 MAC
+ *        lookups, this buffer provides the lookup key and receives the
+ *        matched entry contents on success.
+ * @size: size of @data in 16-bit words. The caller must ensure that @size
+ *        matches the target table's entry size and does not exceed
+ *        RTL8365MB_TABLE_ENTRY_MAX_SIZE.
+ *
+ * This function provides unified access to the internal tables of the switch.
+ * All tables except the L2 table are simple indexed tables, where @addr
+ * selects the entry and @op determines whether the access is a read or a
+ * write operation.
+ *
+ * The L2 table is a hash table and supports multiple lookup methods. For
+ * %RTL8365MB_TABLE_L2_METHOD_MAC, an entry is searched based on the MAC
+ * address and FID/VID fields provided in @data, using the same format as
+ * an L2 table entry. Address-based methods either read a specific entry
+ * (%RTL8365MB_TABLE_L2_METHOD_ADDR) or iterate over valid entries starting
+ * from @addr (%RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT and variants). When using
+ * %RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT, only entries associated with
+ * the specified @port are considered.
+ *
+ * On successful L2 lookups, @addr is updated with the matched table address
+ * and @data contains the corresponding table entry. If no matching entry
+ * is found, -ENOENT is returned. On failed L2 writes, -ENOSPC is returned.
+ *
+ * The contents of @data are used as input when writing to tables or when
+ * specifying the lookup key for L2 MAC searches, and as output for all
+ * successful read operations. If an error occurs, the contents of @addr
+ * and @data are undefined.
+ *
+ * @size must match the size of the target table entry, expressed in 16-bit
+ * words.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int rtl8365mb_table_query(struct realtek_priv *priv,
+			  enum rtl8365mb_table table,
+			  enum rtl8365mb_table_op op, u16 *addr,
+			  enum rtl8365mb_table_l2_method method,
+			  u16 port, u16 *data, size_t size);
+
+#endif /* _REALTEK_RTL8365MB_TABLE_H */

-- 
2.54.0


