Return-Path: <netdev+bounces-281811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFBXG06c8GmGVwEAu9opvQ
	(envelope-from <netdev+bounces-281811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:38:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF587483FC2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4ACD3266B99
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B53F65E5;
	Tue, 28 Apr 2026 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6w1i7Ea"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BA3FE375
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375605; cv=none; b=SrErzEv5F3EUxKoU8/A71F7gCR40kzvV0hM8IpOa0XZdOTkHpKOi8FlXSKv5SRugPOUGP4zS2VWYqCWZpZxseksAQ9aKFEdw4Q0ODeQuUDsRe7RsoN1i29VHr6k6xMo58O38kyk6GwI358g7krGSz8nyNa7tmPcZMw61lGivbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375605; c=relaxed/simple;
	bh=33BKGtv99YCHlFC84RXU206UHS5feYZDByPIWJfGB4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PH2jqV0I72grFlwEEAQafHCrlIcVYdtnCg/FDzjy1PsYJiYwUjtFFlDRLtASx7O3otlnqbGihwiKRfM5ZdZ+sCaZfbyuBmNH2nBfu7yomzi9gDusF8NJ15nVbKYVMkIHz1n9BrKDUyMmgL5g+mHxkqsePU5Car66DWE/Jr63ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6w1i7Ea; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f1f6103afso5237737b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777375603; x=1777980403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVudMn5DOWAnraSt8EcXAJqKne+FmaKhjEXBR4n3BFY=;
        b=g6w1i7EaCq3dnuWyzyqRURIn89868Z0iqqv9BN/K9x+Lr860QN30TRMk7TnfXOxD8a
         d6F2KMgVm5kx7onsp9NKwquyOAju48uikh0e3JSJeul7dxobHYSDdzvab/07YDJNA+cD
         9o/x/7RvMgnSfYhYoWA8i004934hgYtm13c1VywMzZsodshPgH+JctDzdlsGY5wy4x2w
         561qSQ9iML8qdfkTriMsUymxaiAqxcr/fxhhT+OxVWEnQeDT+8C5hkVMPRbY+HChrvDw
         EfedSjKN9NNeeKG7ytXhVv3q1L5QRBQwz6ZyA1b4g/yXkeYSFkrQcwBv+d/EKGJ4MsMq
         hWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375603; x=1777980403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVudMn5DOWAnraSt8EcXAJqKne+FmaKhjEXBR4n3BFY=;
        b=cpVkhwDXUVieK9n+lAOA50rZL809z/S4BtMQFVL/b3GA+eV+PhAGXa741l9IJNVWge
         2iHid9h055wOSU9b4hCntGh7tYeqlbMvejYF4RDmboMlLhH35yb+CfUwmSj/tqaVLnj0
         ar0hXqdNci1/Rkrynqqd3IwdetY3E6hR8ESyATtIa7TB/j8xLUfuGfabiQukRKrVz9tT
         e2A+6PfCLdKMoCg4wiDxA0Ersf2uQw1UYsKDfw5xnwdFSk9a+vbKqcm8+nQlF7p5z917
         iejFFGRoZSlnbZHGPOKVsJS4WRcyskfU5+r35UZrAnb2LsTixEhDjyvQEyoFOfStTPZL
         BNhg==
X-Gm-Message-State: AOJu0YwAL02p6N/JpYPyzmLY+dXU8U28/yiRvce2QOpgW/UHyRyu18s2
	lCQ/SIBSGNVudJaXNHl0qY90kyvQ3tYNp5YhAR4iUHcKdj8oMwqPz8ZaCJutWhzK
X-Gm-Gg: AeBDievVvpwPUyoFxankMqs094nZpwYadgN9/jcLvXnTPBr2CVShbthAoF2Q7IaeeI3
	QHXYCeXsIcNK4J6N8QMSxkOsgGnGX6NNwtIbouVmIsKFRyGykfI0fbYLUUHI73CtYsOKrJWrHV0
	FdbEeMkbUD6Ke/YIBDzTFYDhEXu3cXCfd1ZdrP8gwMSqR556DyDT52mHMqC/zG+VWfosOBkDE77
	dNZlqgTiNRKAQA6i2q1EATgdECP+Mil6fM8skyGjG3j5MyuwpKSC8UDEICmcV3e1G3us/puI9mI
	ct0ZWCk47p+MyElRS3TDKmBxoDzWXzq/ceskOddsMsddqLD0E63Rob2hntplUWVJEeFPgSRBV5P
	yEmh+gEarZpBeJWGlOOJYzmsmUI00gos4di+cfemZY2gU3vSRLWQdFn+9yV16dXvBK8aGWwwkwB
	HDHnshbcduvXyN8YLxEmfvpoq/RGmgs10qnY/CAZd9RjkirU+8/z147kyN19FGoXZeJ/n4e1o=
X-Received: by 2002:a05:6a00:3902:b0:82c:1cd0:2f5e with SMTP id d2e1a72fcca58-834ddc75743mr2956194b3a.44.1777375602851;
        Tue, 28 Apr 2026 04:26:42 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae36b4bsm2284327b3a.27.2026.04.28.04.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:26:42 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/3] net: dsa: yt921x: Refactor long register helpers
Date: Tue, 28 Apr 2026 19:26:02 +0800
Message-ID: <20260428112606.1917230-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428112606.1917230-1-mmyangfl@gmail.com>
References: <20260428112606.1917230-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF587483FC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281811-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Dealing long registers with u64 is good, until you realize there are
longer 96-bit registers.

Refactor reg64 helpers to use u32 arrays instead of u64 values, in
preparation for 96-bit registers. We do not keep the separate u64
version for reg64 to avoid duplicated wrappers, although it looks better
when dealing with reg64 *only*.

Helpers for reg96 should be added when they are actually used to avoid
function unused warnings.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 162 +++++++++++++++++++++++++++------------
 drivers/net/dsa/yt921x.h |  36 ++++-----
 2 files changed, 129 insertions(+), 69 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 87139448bec3..0c07b903fd68 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -255,63 +255,122 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
-/* Some registers, like VLANn_CTRL, should always be written in 64-bit, even if
- * you are to write only the lower / upper 32 bits.
+/* Some multi-word registers, like VLANn_CTRL, should be treated as a single
+ * long register. More specifically, writes to parts of its words won't become
+ * visible, until the last word is written.
  *
- * There is no such restriction for reading, but we still provide 64-bit read
- * wrappers so that we always handle u64 values.
+ * Here we require full read and write operations over these registers to
+ * eliminate potential issues, although partial reads/writes are also possible.
  */
 
-static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+static int
+yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
+		 unsigned int num_regs)
 {
-	u32 lo;
-	u32 hi;
 	int res;
 
-	res = yt921x_reg_read(priv, reg, &lo);
-	if (res)
-		return res;
-	res = yt921x_reg_read(priv, reg + 4, &hi);
-	if (res)
-		return res;
+	for (unsigned int i = 0; i < num_regs; i++) {
+		res = yt921x_reg_read(priv, reg + 4 * i, &vals[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
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
 
-	*valp = ((u64)hi << 32) | lo;
 	return 0;
 }
 
-static int yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, u64 val)
+static int
+yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			const u32 *vals, unsigned int num_regs)
 {
+	bool changed = false;
+	u32 vs[4];
 	int res;
 
-	res = yt921x_reg_write(priv, reg, (u32)val);
+	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
 	if (res)
 		return res;
-	return yt921x_reg_write(priv, reg + 4, (u32)(val >> 32));
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
 }
 
 static int
-yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, u64 mask, u64 val)
+yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+		       unsigned int num_regs)
 {
+	bool changed = false;
+	u32 vs[4];
 	int res;
-	u64 v;
-	u64 u;
 
-	res = yt921x_reg64_read(priv, reg, &v);
+	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
 	if (res)
 		return res;
 
-	u = v;
-	u &= ~mask;
-	u |= val;
-	if (u == v)
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
 		return 0;
 
-	return yt921x_reg64_write(priv, reg, u);
+	return yt921x_regs_write(priv, reg, vs, num_regs);
+}
+
+static int
+yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
+{
+	return yt921x_regs_write(priv, reg, vals, 2);
 }
 
-static int yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, u64 mask)
+static int
+yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			 const u32 *vals)
 {
-	return yt921x_reg64_update_bits(priv, reg, mask, 0);
+	return yt921x_regs_update_bits(priv, reg, masks, vals, 2);
+}
+
+static int
+yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
+{
+	return yt921x_regs_clear_bits(priv, reg, masks, 2);
 }
 
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
@@ -1844,33 +1903,31 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 	return 0;
 }
 
-static int
-yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
+static int yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
 {
-	u64 mask64;
+	u32 masks[2];
 
-	mask64 = YT921X_VLAN_CTRL_PORTS(port) |
-		 YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+	masks[0] = YT921X_VLAN_CTRLa_PORTn(port);
+	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
 
-	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask64);
+	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), masks);
 }
 
 static int
 yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
 {
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[2];
+	u32 ctrls[2];
 
-	mask64 = YT921X_VLAN_CTRL_PORTn(port) |
-		 YT921X_VLAN_CTRL_PORTS(priv->cpu_ports_mask);
-	ctrl64 = mask64;
+	masks[0] = YT921X_VLAN_CTRLa_PORTn(port) |
+		   YT921X_VLAN_CTRLa_PORTS(priv->cpu_ports_mask);
+	ctrls[0] = masks[0];
 
-	mask64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
-	if (untagged)
-		ctrl64 |= YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
+	ctrls[1] = untagged ? masks[1] : 0;
 
 	return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
-					mask64, ctrl64);
+					masks, ctrls);
 }
 
 static int
@@ -2318,8 +2375,8 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 			 const struct switchdev_vlan_msti *msti)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[2];
+	u32 ctrls[2];
 	int res;
 
 	if (!msti->vid)
@@ -2327,12 +2384,14 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 	if (!msti->msti || msti->msti >= YT921X_MSTI_NUM)
 		return -EINVAL;
 
-	mask64 = YT921X_VLAN_CTRL_STP_ID_M;
-	ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
+	masks[0] = 0;
+	ctrls[0] = 0;
+	masks[1] = YT921X_VLAN_CTRLb_STP_ID_M;
+	ctrls[1] = YT921X_VLAN_CTRLb_STP_ID(msti->msti);
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
-				       mask64, ctrl64);
+				       masks, ctrls);
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
@@ -3084,7 +3143,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
-	u64 ctrl64;
+	u32 ctrls[2];
 	u32 ctrl;
 	int port;
 	int res;
@@ -3145,8 +3204,9 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	/* Tagged VID 0 should be treated as untagged, which confuses the
 	 * hardware a lot
 	 */
-	ctrl64 = YT921X_VLAN_CTRL_LEARN_DIS | YT921X_VLAN_CTRL_PORTS_M;
-	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrl64);
+	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
+	ctrls[1] = 0;
+	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrls);
 	if (res)
 		return res;
 
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3f129b8d403f..4989d87c2492 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -429,24 +429,24 @@ enum yt921x_app_selector {
 #define  YT921X_FDB_HW_FLUSH_ON_LINKDOWN	BIT(0)
 
 #define YT921X_VLANn_CTRL(vlan)		(0x188000 + 8 * (vlan))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK_ULL(50, 40)
-#define   YT921X_VLAN_CTRL_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRL_UNTAG_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT_ULL((port) + 40)
-#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK_ULL(39, 36)
-#define   YT921X_VLAN_CTRL_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
-#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT_ULL(35)
-#define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
-#define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
-#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
-#define  YT921X_VLAN_CTRL_PRIO_EN		BIT_ULL(21)
-#define  YT921X_VLAN_CTRL_PRIO_M		GENMASK_ULL(20, 18)
-#define   YT921X_VLAN_CTRL_PRIO(x)			FIELD_PREP(YT921X_VLAN_CTRL_PRIO_M, (x))
-#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
-#define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
-#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT_ULL(6)
-#define  YT921X_VLAN_CTRL_METER_EN		BIT_ULL(5)
-#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK_ULL(4, 0)
+#define  YT921X_VLAN_CTRLb_UNTAG_PORTS_M	GENMASK(18, 8)
+#define   YT921X_VLAN_CTRLb_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRLb_UNTAG_PORTS_M, (x))
+#define  YT921X_VLAN_CTRLb_UNTAG_PORTn(port)	BIT((port) + 8)
+#define  YT921X_VLAN_CTRLb_STP_ID_M		GENMASK(7, 4)
+#define   YT921X_VLAN_CTRLb_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRLb_STP_ID_M, (x))
+#define  YT921X_VLAN_CTRLb_SVLAN_EN		BIT(3)
+#define  YT921X_VLAN_CTRLab_FID_M		GENMASK_ULL(34, 23)
+#define   YT921X_VLAN_CTRLab_FID(x)			FIELD_PREP(YT921X_VLAN_CTRLab_FID_M, (x))
+#define  YT921X_VLAN_CTRLa_LEARN_DIS		BIT(22)
+#define  YT921X_VLAN_CTRLa_PRIO_EN		BIT(21)
+#define  YT921X_VLAN_CTRLa_PRIO_M		GENMASK(20, 18)
+#define   YT921X_VLAN_CTRLa_PRIO(x)			FIELD_PREP(YT921X_VLAN_CTRLa_PRIO_M, (x))
+#define  YT921X_VLAN_CTRLa_PORTS_M		GENMASK(17, 7)
+#define   YT921X_VLAN_CTRLa_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRLa_PORTS_M, (x))
+#define  YT921X_VLAN_CTRLa_PORTn(port)		BIT((port) + 7)
+#define  YT921X_VLAN_CTRLa_BYPASS_1X_AC		BIT(6)
+#define  YT921X_VLAN_CTRLa_METER_EN		BIT(5)
+#define  YT921X_VLAN_CTRLa_METER_ID_M		GENMASK(4, 0)
 
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
-- 
2.53.0


