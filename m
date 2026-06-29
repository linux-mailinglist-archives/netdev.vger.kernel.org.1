Return-Path: <netdev+bounces-302789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yfRdDD+6QmoXAQoAu9opvQ
	(envelope-from <netdev+bounces-302789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF336DE11F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:32:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YJbsL9Yq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302789-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302789-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DD07300603D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DFE396D03;
	Mon, 29 Jun 2026 18:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED61396D19
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:32:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757931; cv=none; b=OMVfsBzVnK7so02w3FNWGsyUGCG/+VDb4b9Des/MWsa516zd254SG6G4dzDW8+YlOylW64fjYzOKbJME53JdnpfaffQI70NvMeTuXVaO6NWGdx+XlsL9TulCaCUkGiXv+gkeAVdbxoGNYeFq67x3BUP5lD9qBqnTTo0SKmvxVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757931; c=relaxed/simple;
	bh=lzl6CopgmL/wacU6djUz9dSTaGt1UiF2z86MIOlj2r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7vZHZt4/9z6l1HRSHhpJQZtq9MSS1qOMaIX9xPNOM8YUOgUia8Ly1O4iVDXkymgNtqdU12PSlZORjkeh2TXG877LmCMVvcKzDNNoQp/HOCdFkEEzOgB2u5q0l45eOoH8U/F0ekTGxmNKoMUl5aO7jxR0DydQTXOl2n4QCrxGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJbsL9Yq; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c88d1d4543fso2065992a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757929; x=1783362729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDPnuRBLx2lH1ussGHVVzFNbp90l0rgIeZSRFamLoGs=;
        b=YJbsL9YqP9iyJJ/GRUY5cn+UoZ7eQh7G0QKbcV5OmMzRTw574Isg0rtuDWlkxlDw1W
         akLkJWnZirG3tRiSTjIyaa3OxFgcWAZKMIcFS8Siq1qxkuIMPZx3BhNQphb6HvFad67w
         6WOlqRIeyBJ/+veGpN0O7lQ0PCR0SJU7Zw+wlnVxR2yyAuy7VfpXFEkEK6AuPmNLj9uz
         orgZdJkV+ZxMENzhMsDES8qazN6fnj9Kbb+vPHkeezx7jkYfNdMPqQvJzs3eTb61JKZS
         liGxEh2n+mjLCBUCDOUm1yeIIxcv/W5HCQF12ooOem5SxgY5RjT9GzSNqVmWPU6aj8ra
         W7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757929; x=1783362729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDPnuRBLx2lH1ussGHVVzFNbp90l0rgIeZSRFamLoGs=;
        b=jEmeqLvYEtGN3LJ50EQ3H8D3dwmJ6v5g6y23gzdSTgh6GJ1OK/5NCrJa1bs0dCqY6w
         mH8hvUlWPLGHvJ8q1WKa+oShMfuuS4dms0xwnIeUSIpCjqJomei+/gdqvEUVCmk+ybsJ
         qLbMs5Td7H9Wg/tzn6K3J1whdz9pIEZIXjHzpDlX/vslHYZvWqzuGyqqpPhDw+dVRpDB
         hiSviHR3g8jdfw0QviJfNchcix6GKMiYdoj3cQlpRh5Ww8ZOVUoCKwd5SsLe2jtzSC1k
         h85J0YzHrJ82pi2uU//JwotzIddaky0er78a6MYZWu1NJe54ShwIFB0gpSIPFp5HAaBW
         3lJQ==
X-Gm-Message-State: AOJu0YxI2bKkHpXkFybYkoKaQdrHWhzj19AypR5idP/T6I9jbatUG584
	v/PhmVpvOgjkaT8/3ckcXafOPheua2f0IRVXc5ndLGfQs8VtDis94nEXGViaXAgy
X-Gm-Gg: AfdE7cnHmb9BMlJF3YoirxSYqDsBHLS2oG5mvuCvFMG1hA1Q99S/Gvw6AQ3O9oO1sry
	iWeuASGC0swtNYyhZIo5UORme6lZvndf1u9q5M+lIbEpgcgLQCbqK3ZID+aZYc1GJp3wVW+94x2
	IE2YkVD6iPT5UNIgM5t1c/Qox63B8B6lHnzos8ZNvd9Xn8nSJwpKuLla6N7JTve8Ic07AKwNRmj
	HRAynKoKbkk2uWiAJ6kedOJFR2ksbEB9p+UUcCZbZ50hxvVjEtUytyyFM3+DNvHatO7rgUiUuni
	wwl2iSvDu95aZBguJq/hvDBTsQ9LXKW4gY5xwaL/FJto6NZg0mjuWmO44Yesff0+dChmsZZltJX
	wSJIOneg34uw8EwCpxDB5WN/cSMbo33IuD1w63WbeutJaImcm/ysviqYftmw6fEewvaacLzF6Yt
	jshu6gsAfgQNagMWdrWAnHfGVG32td5l88hp9c+g==
X-Received: by 2002:a05:6a20:ac43:b0:3b5:6b5a:4f31 with SMTP id adf61e73a8af0-3bfc6e09debmr305614637.27.1782757929179;
        Mon, 29 Jun 2026 11:32:09 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95aa99sm224754a12.17.2026.06.29.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:32:08 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] net: dsa: motorcomm: Split SMI module
Date: Tue, 30 Jun 2026 02:31:33 +0800
Message-ID: <20260629183137.541341-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629183137.541341-1-mmyangfl@gmail.com>
References: <20260629183137.541341-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302789-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CF336DE11F

SMI operations are going to be used across different modules.

Signed-off-by: David Yang <mmyangfl@gmail.com>
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


