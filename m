Return-Path: <netdev+bounces-260813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFxcDsC9nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:15:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71175194BEE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F1BE3083E5F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7CB3806A5;
	Wed, 25 Feb 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwSZf5js"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E03806C0
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010558; cv=none; b=Gw5u1UsGvukvVLa12UF+xyubBENKTFkS7qbr9UCZOrqjsCs0gjwPDpAEaeIAFPSYzTWIuDfzYjvgwfo7ToDeMNDSPnvvcULaUlvx18jl4YO97SCO7IEs2b+Fy0BWoh16B9FFDwFD2NG2xi89KQoj0QBvcN/xjl8gUqZyHL9D0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010558; c=relaxed/simple;
	bh=fqtLYe2m9SEzrSPRkI/fuZ1NGAIPUYoJS5x4iZ+MOgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+uwQESaUDa0ewvmIoPokmR31JHUJBF5GYtt6IO7fMvGIDEZ7DhKLd6YNZ2jdhPg/xOQ+JaHrmiAJFGXrsOqgrPoy1VIO+iTYL5o4zfqKEjV4FCaJHJ/jYy+Y8LmOT+xnJ5IhfhoSh3Z4U+3z5nijDflAwq1IPkHDmOUnob1TOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwSZf5js; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8249aca0affso3443550b3a.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772010555; x=1772615355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSZYn9tMaew3WUGWi2rMLDQppu5ahpU4p+N1lyrbOAQ=;
        b=FwSZf5jsK589g500MaonBktGmePUXvbxtPaHaGZ5DjIrpX06Xirrszd+zhTPrCniGs
         1Ue35riohslV3rxUQl/DvPxkeBBDAfr/UPfzYE91ZWcVenTYRNO81lQEFIO3MD6HthlJ
         9NA4CtSkXZRPOM0xm9ygzG19DG26avEJ5XS3HSgprxLJWqHuNKpexuzYuu/utx3EO7a0
         cU6Nd2PViKTZNEBuWR69q6N2cbppBFHCM911GmWq+HBRrzHHgYqT4mytbbW5Qrycnd0d
         ObNf7doPmWSqCxb8ZUvbEWC7de5OhSums96Ljk7w47ANNsGJ1UpYfZHNeFAqYRFwVx3e
         KBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010555; x=1772615355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSZYn9tMaew3WUGWi2rMLDQppu5ahpU4p+N1lyrbOAQ=;
        b=aE7+/A1Zcoi0sPwL2tbStTrTZhnHuA3CYUba4VAfCuSViREddwDtjLlxMhtKtuiHU9
         DPddnAo3BxNqfh1IIrJkV2lTglUh0LUVQ+oTu63vERJjoNONW0DAWfBjwNw96ir/0gVk
         HmaKMAtJD58zAqeNk6xFNJL8nTOOO7QwQR78JOkFG3JOzYtgTN2OqeSUnchKhtth8CVt
         RA7DvZY3rY4XlsO+nStJiy5W2gbDXQRTtu2Tc52iVfss0cDOz9MZZHpM8Pg5ChxGyCdp
         5k9AMZuLlT4edf+GoPWIYb4kxcVM/M3FJ5/0uBFOc74vsirZNZ7L3SVO8PLPLynnlzTC
         kkbA==
X-Gm-Message-State: AOJu0Yy/eUOYyuSGIrPTP/pyrgy8S2xffA6PTqp1SjTZrQHJ2/6zLSIs
	jIVzo+N4+29oeDf+T1D5Zq1fOssAIWEbT4RcrHzrK4ut5I3w3pA1BaVEgGt5ZWLf
X-Gm-Gg: ATEYQzwFZHm67tXGYxxh94sQSUWmkChxuqlPb1cu9POHBls692YOCvh1gFHBpAedIbq
	6SUftec051GYiieSeN9lgHhPw+JD/vMyuZyJQVkKH7qXsI4wpHPqFqByBFR6Vt8hEjj+dJl4N2d
	8MCrozFCjA6nOkrcyPacYCNheEWKVaMkL4M2qF1n+bGsI8WiFvxjNPVD8UrA0IWJ3bL7fQdL/46
	al3OSfPOk6VCF7S7mky+jxFBxffizDwZVyf4KBkKb9dNCg/DXQ3atECEWV4wIS63ejy4zIWH4/z
	plGuwy5jEWV0nYvL/jCupXws5T8X5ADu6DtOgYDO0gij2TZTDtjwpBmlFvpDZB98BJh4kPQgGKY
	4GoZLccyyJzhMHNmuA60Vsn6+dBoyjYiRxtaQqpfVOq9qEPejFVE/pDQ1TYGPRmDjgoRpgb8Rx8
	X9w7Q8Hi+FFhITiU21l1ZEq+ZHjJNVUHdSKe0yrRVB0vx2
X-Received: by 2002:a05:6a00:4f83:b0:824:b1bb:f6b4 with SMTP id d2e1a72fcca58-82724acdc11mr2006066b3a.39.1772010554831;
        Wed, 25 Feb 2026 01:09:14 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ecb2dsm12883345b3a.60.2026.02.25.01.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:09:14 -0800 (PST)
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
Subject: [PATCH net-next 1/3] net: dsa: yt921x: Refactor long register helpers
Date: Wed, 25 Feb 2026 17:08:45 +0800
Message-ID: <20260225090853.2021140-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225090853.2021140-1-mmyangfl@gmail.com>
References: <20260225090853.2021140-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260813-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71175194BEE
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
index 98e8915dd6c2..fedc72202d1e 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -255,63 +255,102 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
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
@@ -1844,33 +1883,32 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
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
@@ -2331,8 +2369,8 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 			 const struct switchdev_vlan_msti *msti)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	u64 mask64;
-	u64 ctrl64;
+	u32 masks[YT921X_VLAN_CTRL_S];
+	u32 ctrls[YT921X_VLAN_CTRL_S];
 	int res;
 
 	if (!msti->vid)
@@ -2340,12 +2378,14 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
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
@@ -3096,8 +3136,8 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
+	u32 ctrls[YT921X_VLAN_CTRL_S];
 	unsigned long cpu_ports_mask;
-	u64 ctrl64;
 	u32 ctrl;
 	int port;
 	int res;
@@ -3158,8 +3198,10 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
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


