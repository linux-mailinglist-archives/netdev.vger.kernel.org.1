Return-Path: <netdev+bounces-254661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLjKFUEge2lPBgIAu9opvQ
	(envelope-from <netdev+bounces-254661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:54:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D100CADCB3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A017302D0A1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EA37E2F4;
	Thu, 29 Jan 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAcVmVRE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CE37E2EF
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676809; cv=none; b=ILBaOj3amU/BNKYxU+4M0ecfdWppBrNzocJXgdblD/4UoTmcHBuRZNZzwqXhOZF3ZtLoHO1hH2sn4mQgekQQXBBlyUNHXreiyUep+jqIVU2wWRiULR9Oxd0UkNxODRpaZCkprNntFbUsJybWTowA/+m0wEPcJWZIIoaA9ZyPKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676809; c=relaxed/simple;
	bh=mHqbGJIkqoBZSnW2vPkOyMPzqzf9tX/A5IvVfY7jnfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olhPhDQPSEbf7YeWzt/G1KrpkqSVJeUgNM6G4R6G9XRX/ctI3AFmiJFIk2tUkLDVUtSOoJwbWflC09HvCrREma1dyOPyKDhwQfLFFaqLOEUSeBakzVQJg124xAgFYDJl2AABbPHttaeGsrvZo7zOeutBwIChbPS2/t7DI+h+/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAcVmVRE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c09bb78cso6773745ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769676805; x=1770281605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sORuOYB8nAnpTBlWyOyBnkB80Z24IiAB6EFkDsgeBkc=;
        b=QAcVmVRE+azYycK0e/cEQ2bQHEyG/8ax9QpuW09uC0DH6QPDQ4kDa54FdTsmkGPHFM
         SdF/SkksRpIKFklZQsEObNkyqywb54+gX/N/BK/HvMmjEm4FssDTo0CGsEWiCfLH/L8h
         IZ8SgDngK0qeuzqpIy/nU9ErmDdZNnsxEgH3r9FiHKRDzAf+ovTkfi32+0rip/dGrUvL
         caCojXFALA0O+X/38Bt1Zxt0dIYQ9uAmFmSQhMYh+XRZdNJrg4O7NsFPJ4fIQ2LJzDK1
         vQGUO4Xy81r3foQLOnHTH/hQCa6gZfbdtM0KmC0cT6Iym+x7KhX+yL0zJGJLhkLVVdAy
         CW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676805; x=1770281605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sORuOYB8nAnpTBlWyOyBnkB80Z24IiAB6EFkDsgeBkc=;
        b=FM+YkomF3Tlgwk0DNO4KJYdB9Bhc2CyBc4r3tP8mE9JKWttTfVggPn5gdtVBX1PpPy
         7TWBxeNLHSnUrXt2613+2rT3hNKo2sCQIIlPyakLzzzmlA7IXajoeQCQLJjuUP2ju+VC
         l0t4dqSszlk98D6C3wh6piq2uHxqj75agdQZBAb8XImGA6VnIkqj22usq1dcCZgUpZeg
         x2437ZvThtyI4G5mxxDWXtXAV8PLaoRlA4bX3jB3EYP5J4lOwsqp0iAqsgar6k79lqa3
         tN1LHG02cnVmBkuX0EYghKCN0C+1mw5n3qJQXF4g3ZbjHhVW9obNgbkwTyOLy4WZyraq
         k9Gg==
X-Gm-Message-State: AOJu0YxKRytnX2WGv7Q2KxM8B5rTb9i7ZOGbEEAf5HK+bevJ8N5VNZ7V
	QbvFvjuVuYe9MSxWKKmMTrB6nStrfoAB2BTDsTAl+vGXb8fwuZHtmhLXaiXwWUZx
X-Gm-Gg: AZuq6aL3zaykmnsZnXuWNPJlADzGlZ8LeQA0d8IXddg2/YlfzIRNQbYXQ3bvEBGkVCn
	Rvzc80BTFkpi6EMYTpiaKqjqTDUypDJw/TxsXISjHUlIOkbp2UPCPuOdFc2MFEyo4ZrzUg64JjV
	P/ijcZ63l8hyir6v476HqKOVV4qgg5Z7rBuKswFjgBCfdV/pfb3MaAf9scej7/kw2/vYRB7LrxF
	syHIr/m13aThf7Lh6ENtMVEs6afICrVpreS/302PFX1ruH26k23aUK59QO7YsfYtEPSQpr4mnbs
	J/I3hn+p2fjm1BZYoWNOMDsHjiXrVltdh1Q4RL/uDqXeU2h96cvAA9Kgp98xFH8MB9B3jaTa4ka
	yGDjXlsJ4jZCdWp524EmpFU5wZblO0MlITz+PDs4wyNep13VO+v4A6f9Zn812As5hr5fx3wO+AE
	xZp120WAqdUKzYLuaMSo87WjpQ9Dy9uTuyokk=
X-Received: by 2002:a17:903:1aa6:b0:2a0:acb8:9e80 with SMTP id d9443c01a7336-2a8bd53eab0mr24562525ad.29.1769676804834;
        Thu, 29 Jan 2026 00:53:24 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef50sm44651165ad.12.2026.01.29.00.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:53:24 -0800 (PST)
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
Subject: [RFC net-next 2/4] net: dsa: yt921x: Refactor long register helpers
Date: Thu, 29 Jan 2026 16:51:34 +0800
Message-ID: <20260129085139.2767649-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129085139.2767649-1-mmyangfl@gmail.com>
References: <20260129085139.2767649-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254661-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D100CADCB3
X-Rspamd-Action: no action

Dealing long registers with u64 is good, until you realize there are
longer registers that are 96 bits.

Use u32 arrays instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 152 +++++++++++++++++++++++++--------------
 drivers/net/dsa/yt921x.h |  37 +++++-----
 2 files changed, 116 insertions(+), 73 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 1b66b07f45b2..6d03888b6743 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -258,63 +258,102 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
-/* Some registers, like VLANn_CTRL, should always be written in 64-bit, even if
- * you are to write only the lower / upper 32 bits.
+/* Some registers, like VLANn_CTRL, should always be written in chunks, even if
+ * you only want to write parts of 32 bits.
  *
- * There is no such restriction for reading, but we still provide 64-bit read
- * wrappers so that we always handle u64 values.
+ * There is no such restriction for reading, but we still provide multi-chunk
+ * read wrappers so that we can handle them consistently.
  */
 
-static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+static int
+yt921x_longreg_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
+		    unsigned int span)
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
+	for (unsigned int i = 0; i < span; i++) {
+		res = yt921x_reg_read(priv, reg + 4 * i, &vals[i]);
+		if (res)
+			return res;
+	}
 
-	*valp = ((u64)hi << 32) | lo;
 	return 0;
 }
 
-static int yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, u64 val)
+static int
+yt921x_longreg_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
+		     unsigned int span)
 {
 	int res;
 
-	res = yt921x_reg_write(priv, reg, (u32)val);
-	if (res)
-		return res;
-	return yt921x_reg_write(priv, reg + 4, (u32)(val >> 32));
+	for (unsigned int i = 0; i < span; i++) {
+		res = yt921x_reg_write(priv, reg + 4 * i, vals[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
 }
 
 static int
-yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, u64 mask, u64 val)
+yt921x_longreg_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			   const u32 *vals, unsigned int span)
 {
+	bool changed = false;
+	u32 vs[4];
 	int res;
-	u64 v;
-	u64 u;
 
-	res = yt921x_reg64_read(priv, reg, &v);
+	BUILD_BUG_ON(span > ARRAY_SIZE(vs));
+
+	res = yt921x_longreg_read(priv, reg, vs, span);
 	if (res)
 		return res;
 
-	u = v;
-	u &= ~mask;
-	u |= val;
-	if (u == v)
+	for (unsigned int i = 0; i < span; i++) {
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
 		return 0;
 
-	return yt921x_reg64_write(priv, reg, u);
+	return yt921x_longreg_write(priv, reg, vs, span);
 }
 
-static int yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, u64 mask)
+static int
+yt921x_longreg_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			  unsigned int span)
 {
-	return yt921x_reg64_update_bits(priv, reg, mask, 0);
+	bool changed = false;
+	u32 vs[4];
+	int res;
+
+	BUILD_BUG_ON(span > ARRAY_SIZE(vs));
+
+	res = yt921x_longreg_read(priv, reg, vs, span);
+	if (res)
+		return res;
+
+	for (unsigned int i = 0; i < span; i++) {
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
+	return yt921x_longreg_write(priv, reg, vs, span);
 }
 
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
@@ -1843,33 +1882,32 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 	return 0;
 }
 
-static int
-yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
+static int yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid)
 {
-	u64 mask64;
+	u32 masks[YT921X_VLAN_CTRL_S];
 
-	mask64 = YT921X_VLAN_CTRL_PORTS(port) |
-		 YT921X_VLAN_CTRL_UNTAG_PORTn(port);
+	masks[0] = YT921X_VLAN_CTRLa_PORTn(port);
+	masks[1] = YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
 
-	return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask64);
+	return yt921x_longreg_clear_bits(priv, YT921X_VLANn_CTRL(vid), masks,
+					 YT921X_VLAN_CTRL_S);
 }
 
 static int
 yt921x_vlan_add(struct yt921x_priv *priv, int port, u16 vid, bool untagged)
 {
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[YT921X_VLAN_CTRL_S];
+	u32 ctrls[YT921X_VLAN_CTRL_S];
 
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
 
-	return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
-					mask64, ctrl64);
+	return yt921x_longreg_update_bits(priv, YT921X_VLANn_CTRL(vid),
+					  masks, ctrls, YT921X_VLAN_CTRL_S);
 }
 
 static int
@@ -2329,8 +2367,8 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 			 const struct switchdev_vlan_msti *msti)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[YT921X_VLAN_CTRL_S];
+	u32 ctrls[YT921X_VLAN_CTRL_S];
 	int res;
 
 	if (!msti->vid)
@@ -2338,12 +2376,14 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 	if (!msti->msti || msti->msti >= YT921X_MSTI_NUM)
 		return -EINVAL;
 
-	mask64 = YT921X_VLAN_CTRL_STP_ID_M;
-	ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
+	masks[0] = 0;
+	ctrls[0] = 0;
+	masks[1] = YT921X_VLAN_CTRLb_STP_ID_M;
+	ctrls[1] = YT921X_VLAN_CTRLb_STP_ID(msti->msti);
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
-				       mask64, ctrl64);
+	res = yt921x_longreg_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
+					 masks, ctrls, YT921X_VLAN_CTRL_S);
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
@@ -3090,8 +3130,8 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
+	u32 ctrls[YT921X_VLAN_CTRL_S];
 	unsigned long cpu_ports_mask;
-	u64 ctrl64;
 	u32 ctrl;
 	int port;
 	int res;
@@ -3152,8 +3192,10 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	/* Tagged VID 0 should be treated as untagged, which confuses the
 	 * hardware a lot
 	 */
-	ctrl64 = YT921X_VLAN_CTRL_LEARN_DIS | YT921X_VLAN_CTRL_PORTS_M;
-	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrl64);
+	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
+	ctrls[1] = 0;
+	res = yt921x_longreg_write(priv, YT921X_VLANn_CTRL(0), ctrls,
+				   YT921X_VLAN_CTRL_S);
 	if (res)
 		return res;
 
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3f129b8d403f..361470582687 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -429,24 +429,25 @@ enum yt921x_app_selector {
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
+#define  YT921X_VLAN_CTRL_S			2
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
2.51.0


