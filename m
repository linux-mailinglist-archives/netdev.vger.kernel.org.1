Return-Path: <netdev+bounces-293503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPnAL8X0HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F37618F66
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EEA8302DF8C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122D233932;
	Mon,  1 Jun 2026 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhkX5nIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F62264D9
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282449; cv=none; b=guK3YTK5bk+t/SGT8gfsIbWFJ8+dPHvo8ALcE0IUoVbhb8NO7d+xXDUA0BlJN49Sj4eELwc+tXbY44hKVDxuIghTRzYlQkpKafrwTX9e0CJkVSfJjY1TczphDOKcULxYaTCcZmHOhG9X0mYqzabQFCgqreDV5QT25etT0ryELTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282449; c=relaxed/simple;
	bh=k8OKK4fbu9YVkj3A4wGFxTlh7Xe01TBfgymZLmak1Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWwZaFhMsbgsiMIMimAsnYKdVRYOsA0aEoZWyWqrulXJG0NVvCN0+l8PQCGs9gG4tvN9021abJ+84QkNHDqvKw7TlrvTp2hCzDhnt8zBNBTXHM4RQk6j9mVkENEM+NAJFGYQhtff9bu4JFnNcAluUsLDHAeOK8JxlxWKfz9vils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhkX5nIk; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66062a414fcso1221815d50.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282447; x=1780887247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=co8/ZyTeXjuKp2Gwd0X2SKDlHagxvK8nMqaKR+b05g8=;
        b=NhkX5nIkjVkYRNI4FiOJaC1gvTyhuS3Zn4kTEGnHws0Fi5QBFjS0d4sOCeVCZN7o3L
         fsAeOTjyZovA8hB2EIo972E8m80YR+qCcRi+VuGft/bcJpWAu2/NRiR0okbmzfhbFSvD
         JYrY9p9/bxgv3sZG7aWzh8wjPeb/pBn42J+LbOqCwVmS++98eGDe8RRh+bxmEjaxsOEk
         xNSaJbYFJ3EUpP7DllQk2/q4hxbDBgPnS8QzSvUnR0dCKE59tjMQ6IknTQPh5eiN76l7
         VYqSNMmnKdArbYqrRK17NR6vTstBAlftqNtrH0LAQTCUt54FtegZEaENJa49xFwmGaux
         yCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282447; x=1780887247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=co8/ZyTeXjuKp2Gwd0X2SKDlHagxvK8nMqaKR+b05g8=;
        b=fjxdKD48LS48gspttjIoYu6vEtvw7twzdNeGtjOcYvEehTVWJDxZQRUAcU7NCRGKJg
         tfv3ZqN456Yrhok/dZWCtAXLLHaEyOxwgqb0KGWahs+Qa7L9PWdXetGN7eSNaeeQnr5D
         AAeIUBFZQA7WBdYlEQuk0Erqu3Nm3gp8Eo9aptEYag54ckeYJmmX26o8pQ4fea4DZnUf
         1E/UR1No6KZv6H5RIQeIS+wCfRaNanJ8nWcyL3yPbpKyDpHGZoVznzXLi5F3ThPZbseo
         IzVFIfvazWvYjtWBApdlPs28g083qfbGnp0H3EAMWZDI6I8HS7FMBQDi4GedD+nIa3gW
         Bnxg==
X-Gm-Message-State: AOJu0Yx/f3gJqwTSX9cpGLcBgraYQWhRKMmeNhLidsNWdTRxwo8M5x27
	fP2U0PwDB2inyoPW3V06RVDWO/Fbshh6HKxgrLMhvIEvLZ1ZdeYBm57w
X-Gm-Gg: Acq92OF0fc5G1BQb5uDaIWH+h6yICHo3/bi97QUgmer6TngCe8hnxRNOMmjNxf4P0nU
	lxdupuFj62epp9mftM9By1pf3uyWC4rEkEjLmB/J6C/wf4Fy+Hw+WqaNytDrUwB6URGGszq3HO6
	OBgcAm2169Z+JOJS2TrUIkSSQ4dBwvIz1Xky1ukJuppcts+8KEHN7u9qgKXgx1E7DFQw2Jym8JN
	tFTdrAP9BLF1zCia0QVEGK4wcbfKZ6IL0VMDe7savr3vJahtntqXcAPvTfC8KprNVz13EX5e5lf
	61Z5zPFHIifTDgE1GzE7a+YIjJSb+alNRr/2an4iIRfk+V8aJoCPzO9Gu50EDs8n18sBVoR1f8l
	izb9dnlE32vGirCLOjARX/DS6lllmgJzx0hjz+Z8siMnTNiR7+W0jjqeoeTqqGv3+l4LRx5cXVY
	nDAh1wANPTnJc9T8Csedqped1dxeSD3sHnW9VH4J++PjMuFXEi/g==
X-Received: by 2002:a05:690e:400c:b0:660:933d:3057 with SMTP id 956f58d0204a3-660933d38d8mr599206d50.0.1780282446670;
        Sun, 31 May 2026 19:54:06 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:54:05 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 31 May 2026 23:53:20 -0300
Subject: [net-next PATCH v11 5/9] net: dsa: realtek: rtl8365mb: add table
 lookup interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260531-realtek_forward-v11-5-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293503-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 27F37618F66
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
 drivers/net/dsa/realtek/rtl8365mb_table.c | 214 ++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_table.h | 138 +++++++++++++++++++
 3 files changed, 353 insertions(+)

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
index 000000000000..f3c8749a2221
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_table.c
@@ -0,0 +1,214 @@
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
+#define   RTL8365MB_TABLE_CTRL_METHOD_MASK	GENMASK(6, 4)
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
index 000000000000..41280eb6f8b0
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_table.h
@@ -0,0 +1,138 @@
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
+/*
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
+/*
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
+/*
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
+/*
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
+ * The content of @data is used as input when writing to tables or when
+ * specifying the lookup key for L2 MAC searches, and as output for all
+ * successful read operations. It remains unchanged during write operations or
+ * failed read operations that return %-ENOENT. For other errors during read
+ * operations, it is undefined.
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
+ * On successful L2 operations, @addr is updated with the matched table address
+ * or allocated entry address. If no matching entry is found, or if an L2 write
+ * operation fails (e.g., due to a full table during addition or a missing entry
+ * during deletion), %-ENOENT is returned and @addr remains unchanged. It is the
+ * caller's responsibility to map the returned error to the appropriate
+ * semantic error.
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


