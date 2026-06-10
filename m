Return-Path: <netdev+bounces-297835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IeLIHLTIKWoXdQMAu9opvQ
	(envelope-from <netdev+bounces-297835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE42F66CC80
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:27:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ef3TgI3I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297835-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297835-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E568C31409B4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544337D10C;
	Wed, 10 Jun 2026 20:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B247D921
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 20:26:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123187; cv=none; b=YkmhGnOrfU5hMkLH/ulAcxz0kv7RGiPWKeOpGfa70aMVZtR8fvyfJwbyRNHgQFoaaJCj0RSFefwGlrVvlM1ZT81nv0dOLeVeyCe5nGB9S36T8npFGhDPs4mv2WjjYw6oiySzUErs5XsYbXt3iMrTsdayHiroPTjO0Rlts6ynxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123187; c=relaxed/simple;
	bh=QmD01g2zflQj5xOEhdldYgX49cHQ+Jueyl2jKhidRV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1O05Z5a/0idG0MGvPG+TGnjWkJqKRU0/mu68vXrR2qZdrj/o/43pV5BqU/m4Id89yXsSZzwlQJif4bZWQD5bPGLUI40bxzx+tfw4hf0CNXE+Jrkr/k/H48Sk7t9MG1e3NH2DLEg9k6J8bw+FnRFgfaO/qNhRniHwLcADuXwsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef3TgI3I; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so51768175ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781123183; x=1781727983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLJkMnHOGm8b5wMRcq5jC/SYuU+KHKbJfoRRO9fW7T8=;
        b=ef3TgI3IfbkOLRWKM9Bmj5eKy/yflicNsYEzmhZ+o65IVQrrK6P+kGT0Iu/B3ry8xo
         SF8fIJqMYTlvmDld8zQS7qskBGoXth9hGVbxPOoeLjWGoSk9atuy2wUtIT1rZ6SngMCf
         PaqbKY3QQ8rdNkI8nwmww8yhOENmyjv/kjno7sqN89efuaYp6AuSX+DJpjX6hYGc17Xu
         VkQz2iFR3Rl8jmFjragrU6IHOkne4ySc7fUMqFV4EqaNJbqnPOs+W/96w4FcieBo1LJ0
         qYZJcoHr0dgF1zHJyKb5rOlyzR5Db5V5tsl/4RP7xYv9YSp0uHTq2a1BB38Gdzv9mEds
         eWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123183; x=1781727983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLJkMnHOGm8b5wMRcq5jC/SYuU+KHKbJfoRRO9fW7T8=;
        b=HR3A77oi3WnonFHaOKfvO0yJBiFhOftpqUD0Umr3Hfql2Oq1HbI8O7ORB+wHgvbUc/
         Q/rTAcemTRbSGjKd+vZmT9saP+yTVf0+LZBuwJladW9a9sQ5jy88avSIsXNghK7q4Cbd
         6V4rmb6eX8YsN+znkPMxfWU9jNbEdBv7Rf2hYQEXjwFZVgyi2DgL1NX7DljtsID6/KCd
         FeqshIJ6+PTANDjUh3ZyIDFRUhfS2xUIzHEtiappyspc1TNhl5YnQpjnEpHK17rFNfGO
         LzbsJn7LPZRswu+8wDHQrftcM9ClhrHUAxjJn9ikT9oFYp1kf/yyBEK8EOgmHVpyAmEJ
         b7XQ==
X-Gm-Message-State: AOJu0YxA/XcOg161Hb8jW3PUdmKdWHYLJXKSTIvvbvTA8RU8mAsaMNG+
	p64hsSmsT2GG/cNUFji4Hd1McJEHBKCH9u14q7NadrNa8SSBEvUqM5GxxBlZ2UnNNfo=
X-Gm-Gg: Acq92OE6QyOdt2Hav+QJPvwg1X+tv/wdyQXiOtHH+Rp2H1B9Ga71j5pk49M03ws4ikI
	cemHeyEGT8GVojvHY21E+27IlsUTr/C4oqlaYW3E/NmgT0LIDaLk6lNiNpbYBzCPzXjsEnZNG3+
	UIg5VUPd7WBf52JNhVMACBNBvdXIvDDbc4PVciZt5bFMdeNjLt9JF6oiajGquxb6jjzXJrMeTXv
	O1k0PfWowNnKnZZ4vQEVKjp779zvp2HOYSAsvIRpWxq3aKjC8jc4F88zRLX1m4/i6EBxgmfFM+r
	0GKirZmlA7VbnVKPXu+rHOGA+1KLUn6D+1B+TJrYJkvWW4m6sQBQwWztcfpzJCBTiXoIzl1Ayal
	GN26nmMD35bpY1ukawVttbVPbgz51aTeYCUWOhtn2qaAYxCTi9DRVYKG3VFCH0F/uyauQq0WApd
	6hok4B6NSnf3EehRLdv8PdVljn/TkHNmGoWNjgbggV9oPR2rd4FzP20Ida38li
X-Received: by 2002:a17:902:c942:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2c1e79e2aa7mr311088325ad.1.1781123182787;
        Wed, 10 Jun 2026 13:26:22 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f84335sm254754925ad.19.2026.06.10.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:26:22 -0700 (PDT)
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
Subject: [PATCH net-next] net: dsa: yt921x: Add limited ACL flow statistics support
Date: Thu, 11 Jun 2026 04:25:05 +0800
Message-ID: <20260610202508.845328-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297835-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE42F66CC80

The yt921x supports flow statistics, which might be used to implement
.cls_flower_stats(). However, the number of flow counter are limited,
and you must choose between byte mode or packet mode. As there is no
interface for statistics preference for now, we pick one on our own
initiative.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 87 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h | 13 ++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 9929676a15e1..a553c966916a 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -373,6 +373,11 @@ yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
 	return yt921x_regs_write(priv, reg, vs, num_regs);
 }
 
+static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u32 *vals)
+{
+	return yt921x_regs_read(priv, reg, vals, 2);
+}
+
 static int
 yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
 {
@@ -2224,6 +2229,40 @@ yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
 	return UINT_MAX;
 }
 
+static int
+yt921x_acl_stat(struct yt921x_priv *priv, enum tc_setup_type type,
+		unsigned long tag, u64 *statp)
+{
+	const struct yt921x_acl_rule *aclrule;
+	const struct yt921x_acl_blk *aclblk;
+	unsigned int statid;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	u32 vals[2];
+	int res;
+
+	entid = yt921x_acl_find(priv, type, tag);
+	if (entid == UINT_MAX)
+		return -ENOENT;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	if (!(aclrule->action[0] & YT921X_ACL_ACTa_FLOWSTAT_EN))
+		return -EOPNOTSUPP;
+
+	statid = FIELD_GET(YT921X_ACL_ACTa_FLOWSTAT_ID_M, aclrule->action[0]);
+	res = yt921x_reg64_read(priv, YT921X_FLOWSTATn_STAT(statid), vals);
+	if (res)
+		return res;
+
+	*statp = ((u64)vals[1] << 32) | vals[0];
+	return 0;
+}
+
 static int
 yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
 {
@@ -2336,6 +2375,10 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
 				    aclrule->action[0]),
 			  priv->meters_map);
+	if (aclrule->action[0] & YT921X_ACL_ACTa_FLOWSTAT_EN)
+		clear_bit(FIELD_GET(YT921X_ACL_ACTa_FLOWSTAT_ID_M,
+				    aclrule->action[0]),
+			  priv->flowstats_map);
 	priv->acl_masks[blkid] &= ~aclrule->mask;
 	kvfree(aclrule);
 	if (!priv->acl_masks[blkid]) {
@@ -2355,11 +2398,13 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	struct yt921x_acl_blk *aclblk;
 	bool use_trap = false;
 	unsigned int meterid;
+	unsigned int statid;
 	unsigned long mask;
 	unsigned int binid;
 	unsigned int blkid;
 	unsigned int entid;
 	unsigned int o;
+	u32 ctrl;
 	int res;
 
 	/* Allocate resources */
@@ -2386,6 +2431,22 @@ yt921x_acl_add(struct yt921x_priv *priv,
 		}
 	}
 
+	statid = find_first_zero_bit(priv->flowstats_map, YT921X_FLOWSTAT_NUM);
+	if (statid < YT921X_FLOWSTAT_NUM) {
+		u32 zeros[2] = {};
+
+		ctrl = YT921X_FLOWSTAT_CTRL_EN | YT921X_FLOWSTAT_CTRL_TYPE_FLOW;
+		res = yt921x_reg_write(priv, YT921X_FLOWSTATn_CTRL(statid),
+				       ctrl);
+		if (res)
+			return res;
+
+		res = yt921x_reg64_write(priv, YT921X_FLOWSTATn_STAT(statid),
+					 zeros);
+		if (res)
+			return res;
+	}
+
 	/* Prepare acl block ctrlblk */
 	blkid = entid / YT921X_ACL_ENT_PER_BLK;
 	binid = entid % YT921X_ACL_ENT_PER_BLK;
@@ -2426,6 +2487,9 @@ yt921x_acl_add(struct yt921x_priv *priv,
 		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
 	else
 		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
+	if (statid < YT921X_FLOWSTAT_NUM)
+		aclrule->action[0] |= YT921X_ACL_ACTa_FLOWSTAT_EN |
+				      YT921X_ACL_ACTa_FLOWSTAT_ID(statid);
 
 	/* Write rules */
 	aclblk->rules[binid] = aclrule;
@@ -2438,6 +2502,8 @@ yt921x_acl_add(struct yt921x_priv *priv,
 
 	if (meterid < YT921X_METER_NUM)
 		set_bit(meterid, priv->meters_map);
+	if (statid < YT921X_FLOWSTAT_NUM)
+		set_bit(statid, priv->flowstats_map);
 	priv->acl_masks[blkid] |= aclrule->mask;
 	return 0;
 
@@ -2449,6 +2515,26 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	return res;
 }
 
+static int
+yt921x_dsa_cls_flower_stats(struct dsa_switch *ds, int port,
+			    struct flow_cls_offload *cls, bool ingress)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_stat(priv, TC_SETUP_CLSFLOWER, cls->cookie,
+			      &cls->stats.bytes);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+
+	cls->stats.used_hw_stats = FLOW_ACTION_HW_STATS_IMMEDIATE;
+	cls->stats.used_hw_stats_valid = true;
+	return 0;
+}
+
 static int
 yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 			  struct flow_cls_offload *cls, bool ingress)
@@ -4817,6 +4903,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_policer_add	= yt921x_dsa_port_policer_add,
 	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* acl */
+	.cls_flower_stats	= yt921x_dsa_cls_flower_stats,
 	.cls_flower_del		= yt921x_dsa_cls_flower_del,
 	.cls_flower_add		= yt921x_dsa_cls_flower_add,
 	/* hsr */
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 555046526669..5952900f1794 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -759,6 +759,16 @@ enum yt921x_l4_type {
 #define  YT921X_METER_CTRLa_EIR_M		GENMASK(17, 0)
 #define   YT921X_METER_CTRLa_EIR(x)			FIELD_PREP(YT921X_METER_CTRLa_EIR_M, (x))
 #define YT921X_METERn_STAT(x)		(0x221000 + 8 * (x))
+#define YT921X_FLOWSTATn_STAT(x)	(0x221400 + 8 * (x))
+#define YT921X_FLOWSTATn_CTRL(x)	(0x221c00 + 4 * (x))
+#define  YT921X_FLOWSTAT_CTRL_EN		BIT(3)
+#define  YT921X_FLOWSTAT_CTRL_PKT_MODE		BIT(2)	/* 0: byte mode */
+#define  YT921X_FLOWSTAT_CTRL_TYPE_M		GENMASK(1, 0)
+#define   YT921X_FLOWSTAT_CTRL_TYPE(x)			FIELD_PREP(YT921X_FLOWSTAT_CTRL_TYPE_M, (x))
+#define   YT921X_FLOWSTAT_CTRL_TYPE_FLOW		YT921X_FLOWSTAT_CTRL_TYPE(0)
+#define   YT921X_FLOWSTAT_CTRL_TYPE_CPU_CODE		YT921X_FLOWSTAT_CTRL_TYPE(1)
+#define   YT921X_FLOWSTAT_CTRL_TYPE_DROP_CODE		YT921X_FLOWSTAT_CTRL_TYPE(2)
+#define   YT921X_FLOWSTAT_CTRL_TYPE_PORT		YT921X_FLOWSTAT_CTRL_TYPE(3)
 
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
@@ -830,6 +840,8 @@ enum yt921x_fdb_entry_status {
 #define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
 #define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)
 
+#define YT921X_FLOWSTAT_NUM	64
+
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
 
@@ -969,6 +981,7 @@ struct yt921x_priv {
 	u16 eee_ports_mask;
 
 	DECLARE_BITMAP(meters_map, YT921X_METER_NUM);
+	DECLARE_BITMAP(flowstats_map, YT921X_FLOWSTAT_NUM);
 
 	u8 acl_masks[YT921X_ACL_BLK_NUM];
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
-- 
2.53.0


