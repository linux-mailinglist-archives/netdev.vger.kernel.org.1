Return-Path: <netdev+bounces-304621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hIWAMvXoR2rShQAAu9opvQ
	(envelope-from <netdev+bounces-304621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:53:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B007046D8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:53:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ZX/uVy0C";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304621-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304621-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39F4E30160D2
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED334305047;
	Fri,  3 Jul 2026 16:52:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785E30674D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:52:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097578; cv=none; b=PPg6PXzBXgaWeryTSW2VUDkp4VbNAnCBa/QIZmi5r0ZZo8sUR22qhxbg9GLamgTVI7WRoEMSXTboBzxBVRNZuv8IHMgUN6yRwyn80F0zlGoR8qJcCRi5Si+KVEDOBbqT1O7QNqhSKOVUfbbI1oK3XMaO/k+Eq2+cNWp8tKTsnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097578; c=relaxed/simple;
	bh=sCR7LCduQulp62y3Ouz854y7aYy0BrQ6pXog8+b4Jd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqWbweiN8LcYQE+MIA2Qa77u7WihPu63qkIcotVOBJ7gDYUVVmOZj3iDdEkExGO6CiN4h8SGNn+aTsoqGiZF/VZd1CRfDkivDcQynzWhe8Mi6lqjKyc4NtTBWmBdBkYvSCWXs4cYV4C/sisb+YXENzvyr7VXXUhh5TG+LpVEn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX/uVy0C; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-847968ca62fso690680b3a.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783097576; x=1783702376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHAz6u3wdG+hZ6Dsr9mcpDC869qiGMxaGeFpJqp6Z1Y=;
        b=ZX/uVy0CBnZVvjphDM7ZqVQwoNHcSoqHNEHL7FhiFdprN57GGsUxj4gOT1qV/N5Hc8
         0bz/1N6gFrx9DWcCaXqXtbWacwHbOgdB4gM+D7wBCnljfv2THDsYSyBdXsqoq0AriGmH
         a0Pduk0cz8XkapzobKkfhKqA5JZxu6KdL4TAdKUPrmUYzFrhmLKA8pgFvy61KPj89RPX
         r1pQ+NnEsGtqA26p9kvxH2db23woRm5RCh1CzIYw6n3jllsnayTehG7yB1fi6A0jqFSJ
         ZQWdHeEgzAQEUao/c8R3eDG+hGE2eYiVDuzUOdZ28dHoFmKWKl8aY6SQY8JLW2LNDN0N
         UfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097576; x=1783702376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KHAz6u3wdG+hZ6Dsr9mcpDC869qiGMxaGeFpJqp6Z1Y=;
        b=l8qV/xQp7x/qMakJB3D78qfEiifO4efGn64mkmL2qkaBAYLNTZ0hM+h9Tv44tizMBa
         26ySbEAzSjdZuI3cZ2YwTSxHXZ7aPD3ZC/Vltl+G/DAGca7kMuLHcmGAWoctVCloLWTi
         dMa7emJVR8vFHwEvJ+w75UpqK1IKUQBBDJTqrUHUpQDgRe7LXDRpJ6KcXAlyoYEUGuvA
         j/ZKV7w/80Pnu9RJyQwLrpQqemX4D0othwYl7rL/W/UYScBnCG0Iv+2HFo0awoN84LNt
         MdezA6LlNIlAo1h61ZZKSasTZMt3SgU6UQ1lP94V8WFvZjxMOT2zKK40WBTUBlp3L732
         sOMQ==
X-Gm-Message-State: AOJu0Yw7iep95ekWLNpOjAEhHo85iEQUk8YyqZm5KCnYrdZY40cs1kyp
	pJ5P9zEsLZ0P+ZWcelSANmGl0n/Y12KcqpSZpuay945+7q2/tY9vO8S4vr52tKW8
X-Gm-Gg: AfdE7clSEIZBbo+YN+DkLJf5DX55KeKz5fHCIUSfnM7GltGvO9BJusl6iLSP5wh9KAW
	0bDSo6AbCVeTsvLM2TXsYLRGug8X2NmVXf6x/a+uVRagmRqdK70lXcUx2QV8eaIkFSCGpey3fWv
	fut1oVjRk1/zz/WwtXhomQmSi8+UMkhxhRlUwSHiFEX2RAVnOc+cq8Ogmxguxr6yAEoRBuKfraS
	JusccphKiKucB2gHBIDPg3FQq6Nb27TEFDLU1U5Xj5Qgf03S52snzVdpzel2Cx/t+fpLutzi2uT
	fPa6r+1K0ZsotcUHNXkVMBln7Zr4tXfq6+qzEdF0NErAcUt1M3vopq76qZ8zsTsuUOkvv05tdFQ
	ITUaxYO5E+Di+Ru2UFJn5lmC1S3Mg+PVvyRrj0L745KU+KGcqWoQM6uJWWzVZMR6KBs8wWwcbMH
	0/epLZPg/2qBDZUlAwaFPBetjPcXibeZD3qYMH6NK3+czRoUZUrlKzJMagUzEdDg==
X-Received: by 2002:a05:6a00:800f:b0:847:85b6:1f53 with SMTP id d2e1a72fcca58-847f6f43567mr278909b3a.44.1783097576183;
        Fri, 03 Jul 2026 09:52:56 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b609b8sm98267b3a.5.2026.07.03.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:52:55 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/3] net: dsa: motorcomm: Split SMI module
Date: Sat,  4 Jul 2026 00:51:46 +0800
Message-ID: <20260703165241.542195-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703165241.542195-1-mmyangfl@gmail.com>
References: <20260703165241.542195-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304621-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31B007046D8

SMI operations are going to be used across different modules.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 207 +----------------------------
 drivers/net/dsa/motorcomm/smi.c    | 157 ++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h    |  88 ++++++++++++
 4 files changed, 247 insertions(+), 206 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index afd03be9fa35..6cea5313a444 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: ISC
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
+yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index f070732845eb..6dee25b6754a 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -13,7 +13,6 @@
 #include <linux/if_bridge.h>
 #include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
-#include <linux/iopoll.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -27,6 +26,7 @@
 #include <net/pkt_cls.h>
 
 #include "chip.h"
+#include "smi.h"
 
 struct yt921x_mib_desc {
 	unsigned int size;
@@ -155,9 +155,6 @@ static const struct yt921x_info yt921x_infos[] = {
 
 #define YT921X_VID_UNWARE	4095
 
-#define YT921X_POLL_SLEEP_US	10000
-#define YT921X_POLL_TIMEOUT_US	100000
-
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
  *
  * Until we can read MIBs from stats64 call directly (i.e. sleep
@@ -196,208 +193,6 @@ static u32 ethaddr_lo2_to_u32(const unsigned char *addr)
 	return (addr[4] << 8) | addr[5];
 }
 
-static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
-{
-	WARN_ON(!mutex_is_locked(&priv->reg_lock));
-
-	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
-}
-
-static int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
-{
-	WARN_ON(!mutex_is_locked(&priv->reg_lock));
-
-	return priv->reg_ops->write(priv->reg_ctx, reg, val);
-}
-
-static int
-yt921x_reg_wait(struct yt921x_priv *priv, u32 reg, u32 mask, u32 *valp)
-{
-	u32 val;
-	int res;
-	int ret;
-
-	ret = read_poll_timeout(yt921x_reg_read, res,
-				res || (val & mask) == *valp,
-				YT921X_POLL_SLEEP_US, YT921X_POLL_TIMEOUT_US,
-				false, priv, reg, &val);
-	if (ret)
-		return ret;
-	if (res)
-		return res;
-
-	*valp = val;
-	return 0;
-}
-
-static int
-yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
-{
-	int res;
-	u32 v;
-	u32 u;
-
-	res = yt921x_reg_read(priv, reg, &v);
-	if (res)
-		return res;
-
-	u = v;
-	u &= ~mask;
-	u |= val;
-	if (u == v)
-		return 0;
-
-	return yt921x_reg_write(priv, reg, u);
-}
-
-static int yt921x_reg_set_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
-{
-	return yt921x_reg_update_bits(priv, reg, 0, mask);
-}
-
-static int yt921x_reg_clear_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
-{
-	return yt921x_reg_update_bits(priv, reg, mask, 0);
-}
-
-static int
-yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
-{
-	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
-}
-
-/* Some multi-word registers, like VLANn_CTRL, should be treated as a single
- * long register. More specifically, writes to parts of its words won't become
- * visible, until the last word is written.
- *
- * Here we require full read and write operations over these registers to
- * eliminate potential issues, although partial reads/writes are also possible.
- */
-
-static void update_ctrls_unaligned(u32 *lo, u32 *hi, u64 mask, u64 val)
-{
-	*lo &= ~lower_32_bits(mask);
-	*hi &= ~upper_32_bits(mask);
-	*lo |= lower_32_bits(val);
-	*hi |= upper_32_bits(val);
-}
-
-static int
-yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
-		 unsigned int num_regs)
-{
-	int res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		res = yt921x_reg_read(priv, reg + 4 * i, &vals[i]);
-		if (res)
-			return res;
-	}
-
-	return 0;
-}
-
-static int
-yt921x_regs_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
-		  unsigned int num_regs)
-{
-	int res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		res = yt921x_reg_write(priv, reg + 4 * i, vals[i]);
-		if (res)
-			return res;
-	}
-
-	return 0;
-}
-
-static int
-yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
-			const u32 *vals, unsigned int num_regs)
-{
-	bool changed = false;
-	u32 vs[4];
-	int res;
-
-	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
-
-	res = yt921x_regs_read(priv, reg, vs, num_regs);
-	if (res)
-		return res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		u32 u = vs[i];
-
-		u &= ~masks[i];
-		u |= vals[i];
-		if (u != vs[i])
-			changed = true;
-
-		vs[i] = u;
-	}
-
-	if (!changed)
-		return 0;
-
-	return yt921x_regs_write(priv, reg, vs, num_regs);
-}
-
-static int
-yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
-		       unsigned int num_regs)
-{
-	bool changed = false;
-	u32 vs[4];
-	int res;
-
-	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
-
-	res = yt921x_regs_read(priv, reg, vs, num_regs);
-	if (res)
-		return res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		u32 u = vs[i];
-
-		u &= ~masks[i];
-		if (u != vs[i])
-			changed = true;
-
-		vs[i] = u;
-	}
-
-	if (!changed)
-		return 0;
-
-	return yt921x_regs_write(priv, reg, vs, num_regs);
-}
-
-static int
-yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
-{
-	return yt921x_regs_write(priv, reg, vals, 2);
-}
-
-static int
-yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
-			 const u32 *vals)
-{
-	return yt921x_regs_update_bits(priv, reg, masks, vals, 2);
-}
-
-static int
-yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
-{
-	return yt921x_regs_clear_bits(priv, reg, masks, 2);
-}
-
-static int
-yt921x_reg96_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
-{
-	return yt921x_regs_write(priv, reg, vals, 3);
-}
-
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 {
 	struct yt921x_reg_mdio *mdio = context;
diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
new file mode 100644
index 000000000000..9054896e4cd1
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/smi.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include <linux/iopoll.h>
+
+#include "chip.h"
+#include "smi.h"
+
+#define YT921X_POLL_SLEEP_US	10000
+#define YT921X_POLL_TIMEOUT_US	100000
+
+int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
+{
+	lockdep_assert_held_once(&priv->reg_lock);
+
+	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
+}
+
+int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
+{
+	lockdep_assert_held_once(&priv->reg_lock);
+
+	return priv->reg_ops->write(priv->reg_ctx, reg, val);
+}
+
+int yt921x_reg_wait(struct yt921x_priv *priv, u32 reg, u32 mask, u32 *valp)
+{
+	u32 val;
+	int res;
+	int ret;
+
+	ret = read_poll_timeout(yt921x_reg_read, res,
+				res || (val & mask) == *valp,
+				YT921X_POLL_SLEEP_US, YT921X_POLL_TIMEOUT_US,
+				false, priv, reg, &val);
+	if (ret)
+		return ret;
+	if (res)
+		return res;
+
+	*valp = val;
+	return 0;
+}
+
+int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
+{
+	int res;
+	u32 v;
+	u32 u;
+
+	res = yt921x_reg_read(priv, reg, &v);
+	if (res)
+		return res;
+
+	u = v;
+	u &= ~mask;
+	u |= val;
+	if (u == v)
+		return 0;
+
+	return yt921x_reg_write(priv, reg, u);
+}
+
+int
+yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
+		 unsigned int num_regs)
+{
+	int res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		res = yt921x_reg_read(priv, reg + 4 * i, &vals[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+int
+yt921x_regs_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
+		  unsigned int num_regs)
+{
+	int res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		res = yt921x_reg_write(priv, reg + 4 * i, vals[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+int
+yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			const u32 *vals, unsigned int num_regs)
+{
+	bool changed = false;
+	u32 vs[4];
+	int res;
+
+	if (WARN_ON_ONCE(num_regs > ARRAY_SIZE(vs)))
+		return -EINVAL;
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
+	if (res)
+		return res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		u32 u = vs[i];
+
+		u &= ~masks[i];
+		u |= vals[i];
+		if (u != vs[i])
+			changed = true;
+
+		vs[i] = u;
+	}
+
+	if (!changed)
+		return 0;
+
+	return yt921x_regs_write(priv, reg, vs, num_regs);
+}
+
+int
+yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+		       unsigned int num_regs)
+{
+	bool changed = false;
+	u32 vs[4];
+	int res;
+
+	if (WARN_ON_ONCE(num_regs > ARRAY_SIZE(vs)))
+		return -EINVAL;
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
+	if (res)
+		return res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		u32 u = vs[i];
+
+		u &= ~masks[i];
+		if (u != vs[i])
+			changed = true;
+
+		vs[i] = u;
+	}
+
+	if (!changed)
+		return 0;
+
+	return yt921x_regs_write(priv, reg, vs, num_regs);
+}
diff --git a/drivers/net/dsa/motorcomm/smi.h b/drivers/net/dsa/motorcomm/smi.h
new file mode 100644
index 000000000000..2e956065eb90
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/smi.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_SMI_H
+#define _YT_SMI_H
+
+#include <linux/types.h>
+#include <linux/wordpart.h>
+
+struct yt921x_priv;
+
+int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp);
+int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val);
+int yt921x_reg_wait(struct yt921x_priv *priv, u32 reg, u32 mask, u32 *valp);
+int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask,
+			   u32 val);
+
+static inline int
+yt921x_reg_set_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
+{
+	return yt921x_reg_update_bits(priv, reg, 0, mask);
+}
+
+static inline int
+yt921x_reg_clear_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
+{
+	return yt921x_reg_update_bits(priv, reg, mask, 0);
+}
+
+static inline int
+yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
+{
+	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
+}
+
+/* Some multi-word registers, like VLANn_CTRL, should be treated as a single
+ * long register. More specifically, writes to parts of its words won't become
+ * visible, until the last word is written.
+ *
+ * Here we require full read and write operations over these registers to
+ * eliminate potential issues, although partial reads/writes are also possible.
+ */
+
+static inline void update_ctrls_unaligned(u32 *lo, u32 *hi, u64 mask, u64 val)
+{
+	*lo &= ~lower_32_bits(mask);
+	*hi &= ~upper_32_bits(mask);
+	*lo |= lower_32_bits(val);
+	*hi |= upper_32_bits(val);
+}
+
+int yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
+		     unsigned int num_regs);
+int yt921x_regs_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
+		      unsigned int num_regs);
+int yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			    const u32 *vals, unsigned int num_regs);
+int yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			   unsigned int num_regs);
+
+static inline int
+yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
+{
+	return yt921x_regs_write(priv, reg, vals, 2);
+}
+
+static inline int
+yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			 const u32 *vals)
+{
+	return yt921x_regs_update_bits(priv, reg, masks, vals, 2);
+}
+
+static inline int
+yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
+{
+	return yt921x_regs_clear_bits(priv, reg, masks, 2);
+}
+
+static inline int
+yt921x_reg96_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
+{
+	return yt921x_regs_write(priv, reg, vals, 3);
+}
+
+#endif
-- 
2.53.0


