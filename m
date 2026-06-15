Return-Path: <netdev+bounces-299452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FOFDLF34L2ptKgUAu9opvQ
	(envelope-from <netdev+bounces-299452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1444368682D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QCqjzXEY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299452-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C162C3019188
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82F3EBF15;
	Mon, 15 Jun 2026 13:04:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81031E841
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:04:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528647; cv=none; b=CXL43AQBptf7nwCiFMfZKLL7gfXndy7SuYshQGTtuQqfPLQJtEFz5GBP4E5rI/FgMN02Y1m0ZDLsbt/qUoE9TtUidjwVdW/a3k22WZBaLDAtyT3fuNW6gfcWZuuerPPrbRrxTxvexswajAXD7KyOqJBz8/gxCMFaqPoUUSaPXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528647; c=relaxed/simple;
	bh=wx4TZ70q4G+vPDj3vFRGSAShYBAAzWX2yiej9RgDAdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIG29oaRpPc+ePobWmat22C0Zb3jnRjWp5qDjnNquX9K0gXzM0JXyrKSFocCWjnQPtZ3ETie2B/fk8Zi2YLuZZmdn3N7Pssdikrjlmwm2CG43SAFpfej4ozV4ryNrOyXPsS5kyJUN2O0LV3exZqgtSyW50/uSaxLZ/U30izT1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCqjzXEY; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c31212104cso13344335ad.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781528645; x=1782133445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oo2rU1Ud4xqPCmf4wCoRo8EWreh+bxfDybb3z0FYkjY=;
        b=QCqjzXEYJScYo3lSbPilI7jpYFEYzI7oEOrhAOF1gdyFuQXylaHAIkYPBgB7ZA+y+1
         trQ86ycL8SftLc7bKsVerrLniZ3hwBThKFzpn8vYcmK6gxTVB7Wnveki1VEPCgtrYxkN
         N2GFT+sl0OrRWj81O2DH1iTiXe7/rO8lY/pmCJQKlPQ6JYt4+xCSBP+alM66P/2aDCA5
         qj7t3bIt82wJWzGtPqkms6Z5QVjNnxoH5kU84EoLsXPxf8KAB2MdeVzr+DyQ9o5u3YWG
         sIKDfmkJtuksMAz6f6bHjuP9cTmORljZk9a0VvigS3U2J0RPjSG22XAf91D6AEyRAl92
         U9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781528645; x=1782133445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo2rU1Ud4xqPCmf4wCoRo8EWreh+bxfDybb3z0FYkjY=;
        b=Ava2ZqQ9Ku083tFJjTOc1/dNNhiPQlfZFpcjHJck1O0hr8MxA3Gabu6w+4HLY1jRSP
         67WezbAzTCuGvocePjNPENV5NWgKeNXWe4IPs+kjaX6qwdpJKGoZXcq4uVc5T6igb/uL
         rMeALGu7KwwLB2H8uip/UyjcW9AHpwSVS7lzEx6Y57qqUT90XHxwgnizridoqeFQ+7dU
         4VYpkrDuKzVJqKcD5KOzz0nAV4F+2zvN/TXwqnFN5ZOlvoE80sx948OMUcGchB1a/tL/
         8nABgoMOQeETqDUQLPaje/6n2QCGrtDJzo5tKDcMcnYtTvaKuEfFQr19HJ0ZQcv+m65z
         Ai+g==
X-Gm-Message-State: AOJu0YxZvhNr9rQGV7u8792mBzpXlYMCKP5R4WNyJVqAyMZoQv2P8xBK
	pQE6SqeRnLXOldcsOS5sxtmF/jx+P0WhLoaN5y3PXczAEhLickbiSBM4wh3XPUJF
X-Gm-Gg: Acq92OEyGU7DzL+byA75ZvfTpHNjn+CyxdXn+ucZbzDxHTjjd4jXsNNt1nqpsUP7GBf
	5FyrNayRTVPJfGWmSUwxObPVdSvQpmhZC5M0l+vd4D8jTkym3+WR9r+k3GIbYBqNRz4LvUjItUE
	NlTDPYYtDNbmLajZIIPMdrQ8CEBLunkvkOiRAgIk1gCKkNO8kePgWfbqXy8Xy1rf36VIevPQoVh
	9pp8dW9frngEifbpNVseDanqevJYBkYv5jMAZXodG8LADWVHY9akuiilKvm49pbx8r1DXyrcvfr
	S/wEUumOTEfcsDCQMXEWZM6j6IuA+Mm6FO5B4uShwEMZE5B0ONHDHog8Y5Jvnw5vgL9lDgD4o2i
	aVSjKtbyQ8tKIMV/pXJohzzQxRokeAvm2/YI4T05/DRoOXDab7xW+lh6IoPj40U7R1me0ghwSdu
	EuEP0ryTTpSak9Cj1sBnfA7IjVgeYlIdPisbZkFaZnv1Vqwugl
X-Received: by 2002:a17:902:ea06:b0:2c0:e5ee:f56c with SMTP id d9443c01a7336-2c664271b0amr116624625ad.20.1781528645187;
        Mon, 15 Jun 2026 06:04:05 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432f77479sm103828435ad.63.2026.06.15.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 06:04:04 -0700 (PDT)
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
Subject: [PATCH net-next v2] net: dsa: yt921x: Add limited ACL flow statistics support
Date: Mon, 15 Jun 2026 21:03:53 +0800
Message-ID: <20260615130356.1150110-1-mmyangfl@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299452-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RBL_SEM_FAIL(0.00)[172.234.253.10:server fail];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	ALIAS_RESOLVED(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[vger.kernel.org:server fail];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[vger.kernel.org:server fail]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1444368682D

The yt921x supports flow statistics, which might be used to implement
.cls_flower_stats(). However, the number of flow counter are limited,
and you must choose between byte mode or packet mode. As there is no
interface for statistics preference for now, we pick one on our own
initiative.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v1: https://lore.kernel.org/r/20260610202508.845328-1-mmyangfl@gmail.com
  - use a safe counter reader
  - use flow_stats_update()
  - do not use hardware counter if assisted by software
  - set extack on exhausted counter
 drivers/net/dsa/yt921x.c | 135 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  17 +++++
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 9929676a15e1..3dddedd0776a 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -266,6 +266,36 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
+/* Reliably read a 64bit counter */
+static int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+{
+	u32 old_lo;
+	int res;
+	u32 hi;
+	u32 lo;
+
+	res = yt921x_reg_read(priv, reg, &old_lo);
+	if (res)
+		return res;
+
+	for (int i = 0; i < 16; i++) {
+		res = yt921x_reg_read(priv, reg + 4, &hi);
+		if (res)
+			return res;
+		res = yt921x_reg_read(priv, reg, &lo);
+		if (res)
+			return res;
+
+		if (lo >= old_lo) {
+			*valp = ((u64)hi << 32) | lo;
+			return 0;
+		}
+		old_lo = lo;
+	}
+
+	return -ETIMEDOUT;
+}
+
 /* Some multi-word registers, like VLANn_CTRL, should be treated as a single
  * long register. More specifically, writes to parts of its words won't become
  * visible, until the last word is written.
@@ -2167,6 +2197,8 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
 	ruleext->r.tag = cls->cookie;
 	ruleext->r.type = TC_SETUP_CLSFLOWER;
+	/* Align with sja1105 */
+	ruleext->r.stat_pkt_mode = true;
 	return 0;
 }
 
@@ -2224,6 +2256,47 @@ yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
 	return UINT_MAX;
 }
 
+static int
+yt921x_acl_stat(struct yt921x_priv *priv, enum tc_setup_type type,
+		unsigned long tag, struct flow_stats *stats)
+{
+	struct yt921x_acl_rule *aclrule;
+	const struct yt921x_acl_blk *aclblk;
+	unsigned int statid;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	u64 diff;
+	u64 stat;
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
+	res = yt921x_counter_read(priv, YT921X_FLOWSTATn_STAT(statid), &stat);
+	if (res)
+		return res;
+
+	diff = stat - aclrule->laststat;
+	if (diff)
+		aclrule->lastused = jiffies;
+	aclrule->laststat = stat;
+	flow_stats_update(stats, aclrule->stat_pkt_mode ? 0 : diff,
+			  !aclrule->stat_pkt_mode ? 0 : diff, 0,
+			  aclrule->lastused, FLOW_ACTION_HW_STATS_IMMEDIATE);
+	return 0;
+}
+
 static int
 yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
 {
@@ -2336,6 +2409,10 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
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
@@ -2353,13 +2430,15 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	unsigned int entscnt = hweight8(ruleext->r.mask);
 	struct yt921x_acl_rule *aclrule;
 	struct yt921x_acl_blk *aclblk;
-	bool use_trap = false;
 	unsigned int meterid;
+	unsigned int statid;
 	unsigned long mask;
 	unsigned int binid;
 	unsigned int blkid;
 	unsigned int entid;
 	unsigned int o;
+	bool use_trap;
+	u32 ctrl;
 	int res;
 
 	/* Allocate resources */
@@ -2367,6 +2446,10 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	if (entid == UINT_MAX)
 		return -EOPNOTSUPP;
 
+	use_trap = (ruleext->r.action[2] & YT921X_ACL_ACTc_FWD_EN) &&
+		   (FIELD_GET(YT921X_ACL_ACTc_FWD_M,
+			      ruleext->r.action[2]) == YT921X_ACL_ACTc_FWD_TRAP);
+
 	if (!(ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN)) {
 		meterid = YT921X_METER_NUM;
 	} else {
@@ -2386,6 +2469,35 @@ yt921x_acl_add(struct yt921x_priv *priv,
 		}
 	}
 
+	if (ruleext->r.sw_assisted && use_trap) {
+		statid = YT921X_FLOWSTAT_NUM;
+	} else {
+		statid = find_first_zero_bit(priv->flowstats_map,
+					     YT921X_FLOWSTAT_NUM);
+		if (statid >= YT921X_FLOWSTAT_NUM) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "No more flowstats available");
+		} else {
+			u32 zeros[2] = {};
+
+			ctrl = YT921X_FLOWSTAT_CTRL_TYPE_FLOW |
+			       YT921X_FLOWSTAT_CTRL_EN;
+			if (ruleext->r.stat_pkt_mode)
+				ctrl |= YT921X_FLOWSTAT_CTRL_PKT_MODE;
+			res = yt921x_reg_write(priv,
+					       YT921X_FLOWSTATn_CTRL(statid),
+					       ctrl);
+			if (res)
+				return res;
+
+			res = yt921x_reg64_write(priv,
+						 YT921X_FLOWSTATn_STAT(statid),
+						 zeros);
+			if (res)
+				return res;
+		}
+	}
+
 	/* Prepare acl block ctrlblk */
 	blkid = entid / YT921X_ACL_ENT_PER_BLK;
 	binid = entid % YT921X_ACL_ENT_PER_BLK;
@@ -2426,6 +2538,9 @@ yt921x_acl_add(struct yt921x_priv *priv,
 		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
 	else
 		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
+	if (statid < YT921X_FLOWSTAT_NUM)
+		aclrule->action[0] |= YT921X_ACL_ACTa_FLOWSTAT_EN |
+				      YT921X_ACL_ACTa_FLOWSTAT_ID(statid);
 
 	/* Write rules */
 	aclblk->rules[binid] = aclrule;
@@ -2438,6 +2553,8 @@ yt921x_acl_add(struct yt921x_priv *priv,
 
 	if (meterid < YT921X_METER_NUM)
 		set_bit(meterid, priv->meters_map);
+	if (statid < YT921X_FLOWSTAT_NUM)
+		set_bit(statid, priv->flowstats_map);
 	priv->acl_masks[blkid] |= aclrule->mask;
 	return 0;
 
@@ -2449,6 +2566,21 @@ yt921x_acl_add(struct yt921x_priv *priv,
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
+			      &cls->stats);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int
 yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 			  struct flow_cls_offload *cls, bool ingress)
@@ -4817,6 +4949,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_policer_add	= yt921x_dsa_port_policer_add,
 	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* acl */
+	.cls_flower_stats	= yt921x_dsa_cls_flower_stats,
 	.cls_flower_del		= yt921x_dsa_cls_flower_del,
 	.cls_flower_add		= yt921x_dsa_cls_flower_add,
 	/* hsr */
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 555046526669..0851102d8b35 100644
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
 
@@ -920,6 +932,10 @@ struct yt921x_acl_rule {
 	u32 action[3];
 	bool sw_assisted;
 
+	bool stat_pkt_mode;
+	u64 laststat;
+	u64 lastused;
+
 	u8 mask;
 	struct yt921x_acl_entry entries[YT921X_ACL_ENT_PER_BLK];
 };
@@ -969,6 +985,7 @@ struct yt921x_priv {
 	u16 eee_ports_mask;
 
 	DECLARE_BITMAP(meters_map, YT921X_METER_NUM);
+	DECLARE_BITMAP(flowstats_map, YT921X_FLOWSTAT_NUM);
 
 	u8 acl_masks[YT921X_ACL_BLK_NUM];
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
-- 
2.53.0


