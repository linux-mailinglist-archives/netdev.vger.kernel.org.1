Return-Path: <netdev+bounces-276073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHdtE3Eu1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:18:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1B03B1B22
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66EAB30221DF
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F03D16E4;
	Tue,  7 Apr 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWMpYr33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AB3C457A
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578230; cv=none; b=d38ZlS6vgVR/rrm1773qsv+ELD+cUtZj+c7VfhmbUV22O2E/N9BBo1V/mbxptlaoCE02KuK/qUBXZnoqqbc41moNs743f7mcHnRqT2HXK0PP/slZV0+6WAajesiBC+Ui4W+bjiWWU5sO4zMbzOiPfukuAa/ZgZQoMuHA5czGQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578230; c=relaxed/simple;
	bh=00JYzBQ/fGB6OBkHYf37XI57wrah6rPGE2MFkhMCV6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMSRRbvGy+mfTzqBB49HovEzxnEnEtFKN2ac80LZ5J0EtKI8unJ1B7FpEXmB4Jy+cZWPrj/4y2zqsbrEgWx5VS2WBN2DU/vk7MI9xlzjNlc6p7UzwaQsOpWYDtyXr7Fq8tpiTcwIMVAnFu3nZvDVU6PUvVJUIF7t/WWEhNzF52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWMpYr33; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c648bc907ebso3642285a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578223; x=1776183023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osFjjLnInsmXNvjP78Zxgysf1bF9rd2bISOLOklUimE=;
        b=UWMpYr33km5xfoc2r6Ng+oinqqFMKeGpi6GX/sCkN07ARxUsF6DzlZosNKvcSrChRq
         NLfOhpCJGS1Pj77cyCMWeXCXARYTMBMn1RixTh8jJc3slzq5wBkPuBWrPsRalMg/XzqU
         cVTsU47P5PABgaeNlqpvNkiiJyQ1MwHlx51BNphjoJOdIzE1h/4tFRltOvgOLsahnLIG
         U+1+mMYqMA6rkX8Z7EmCTafaVdxh6LBTypITcGyCb9BAVij0tPEh5sodgBK+a1+bSHR0
         uSQNeZR0+PrfSGFr0Xa0zyKIC7f/fvkGUua1Dpe2yxnnxrj+AsvE1l5sIyjA3UEUZ91L
         UueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578223; x=1776183023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osFjjLnInsmXNvjP78Zxgysf1bF9rd2bISOLOklUimE=;
        b=E3bDjfRN3UsBNRF1ag9M0Arbqfqfp4s2olectCLfjz5ICVzoG2oN+MQ5d/deAM+alA
         jWXXZrzvtYk46n49fdibKkz3KRQXLu6AccCMJUqJfRT9tICcK/kHJftksXCix6uDTFYJ
         MstNrSRPdbTVd6pwoB2yGBawXrbcIVKPO8KDIMM7FisTZrFLOcWpy6WWTNZAMoiIyjgt
         pEmy8Nphh3XVlV6kltpimi2NyINJFxnMl2d8g2X9uZl2OPF4e83tV5rYfxN0vMEJEY7p
         5M5WrOZeJXMu5DGIcyekXE50WSftuCfhtw4LREiges3W9OBeq7sIE/V/GZZCSla/UI8H
         pmkA==
X-Gm-Message-State: AOJu0YwwgAMD3wmlTtQn/bjtSIkj6TSOXiER/9DfpL27CzXtSr9xL7NB
	bJ5OUPvn53Jm1EMBH2FrlhNp4Sx/tifTpO2oqYHi8jsn6/k9EBW3JuqskukGSg==
X-Gm-Gg: AeBDieu0Bn97DpoJkxD5A3J1BvzYz+DtW7vtnMdHmeWFecaHyX12hSgSm2JD8tUE8w3
	HiwtASgkzRKctl6crjKlO8Pu2ZridlyZMfvQJiYQ3IWSkeORxZ3m1mQmZPAQb93qnYs2Wh3WaDA
	RqqBoMo68aG1AuqKypR0oFRMtUq6Nq+oDdUKf5BHDaC8+MtFBHChaSDsmYprHh45Np4BDOwo5rO
	EEj8mVosUTjWl+BEc5XZ6PUzQCCZVz/LxDIxmhtvjjSF+FkDZbqbwL2XnCBfhDNr8jht3aq6oGL
	zdLioJ/cMYrOQ0AH0XI6SyoQjh+rSV46/g1GdBPIZVDmYXFXAOmTt8ocLw8uRKpscsAx+/Ht6pj
	N3KQUinuG4iBiMkYdJibsL0Pka/MSxCbJxUHd1PZizqDnSDe+oHt333cf9NYUsPvxg/GCQ+vCHW
	zXAr5hoZYB+zek4cL5FSl6+riNqDk8WL14ypSdrlUmbHlNLQCr
X-Received: by 2002:a05:6a20:7354:b0:39b:e321:784f with SMTP id adf61e73a8af0-39f2f05041dmr18842777637.40.1775578222608;
        Tue, 07 Apr 2026 09:10:22 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6372078sm15650238a12.0.2026.04.07.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:10:22 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/4] net: dsa: yt921x: Refactor long register helpers
Date: Wed,  8 Apr 2026 00:05:54 +0800
Message-ID: <20260407160559.1747616-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407160559.1747616-1-mmyangfl@gmail.com>
References: <20260407160559.1747616-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276073-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED1B03B1B22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dealing long registers with u64 is good, until you realize there are
longer 96-bit registers.

Refactor reg64 helpers with u32 arrays, so they are aligned with further
reg96 helpers. We do not keep the u64 implement to avoid duplicated
wrappers, although it looks better when we deal with reg64 *only*.

Helpers for reg96 should be added when they are actually used to avoid
function unused warnings.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 161 ++++++++++++++++++++++++++-------------
 drivers/net/dsa/yt921x.h |  36 ++++-----
 2 files changed, 128 insertions(+), 69 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 87139448bec3..de6aa5835616 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -255,63 +255,121 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
-/* Some registers, like VLANn_CTRL, should always be written in 64-bit, even if
- * you are to write only the lower / upper 32 bits.
+/* Some registers, like VLANn_CTRL, should always be written whole, even if you
+ * only want to write parts of 32 bits.
  *
- * There is no such restriction for reading, but we still provide 64-bit read
- * wrappers so that we always handle u64 values.
+ * There is no such restriction for reading, but we still provide the read
+ * wrapper so that we can handle them consistently.
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
@@ -1844,33 +1902,31 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
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
@@ -2318,8 +2374,8 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 			 const struct switchdev_vlan_msti *msti)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[2];
+	u32 ctrls[2];
 	int res;
 
 	if (!msti->vid)
@@ -2327,12 +2383,14 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
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
@@ -3084,7 +3142,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
-	u64 ctrl64;
+	u32 ctrls[2];
 	u32 ctrl;
 	int port;
 	int res;
@@ -3145,8 +3203,9 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
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


