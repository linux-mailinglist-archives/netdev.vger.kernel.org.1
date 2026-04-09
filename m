Return-Path: <netdev+bounces-277078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAxhIAze12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:12:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C63CDF8F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AED90300253F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF73E1D1B;
	Thu,  9 Apr 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXRWYkJn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6493E1207
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754752; cv=none; b=bZRG2mX2AyAL5WeRK9QjggmD5prQVjXxv//EkbBOIhqGbQjf/B8wosdzv5/cd4b7m7riKI/rJ3SxIleOaiuFr2mtTycFw07+wFoXeEyqwkA46xoH9W5okhMWT0ntQiDOzmsgx6uZkdCz008xhs0cH8YTwqc7FFxUJoO5G7uHtIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754752; c=relaxed/simple;
	bh=dXW3jIJkAafjnaie9T4TwffI/RxoM5p7H3bF7n50mDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2tU0ZHCkaqw2fiiHCbkPQ0GoB8/aGTpK+8ixHxFOUuamVfSynFVmG+8WqgHoJ1y8+V0lRjl89c4fH8GatzWlaomTEf8kBQvFI7mJHMGkDbY6la4KEwtlIN5jBJUjOTfwRf0n2/sToauSVAN3Dx0EYtxjqJs3gYj1k5ioN4lSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXRWYkJn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so571019a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775754750; x=1776359550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0PerIpgKG32JFRNFK9DSuHMidXArqX6Q005ECyvyPQ=;
        b=ZXRWYkJnyKrWnBfP0R0528A58hP3Qyv5N6bVRuO2tSDtfdCea62jI3vVnWS1eiQUxw
         19kZKmElTPFToKPkryhDBmqla+arHhsA3JtnTKjOKJTKTnhrRwL9G0l0qkhwwGbURjlF
         EsmTwgAAmeWG2kSRvIQR0SigCa1BQrkc63o69fi19tgch/nGWDDUwvQ0GXjb6kUTuU9g
         Bq/eJ9NiD/DPJu8UX9T80QrLR5cY+qIM0sDiaAwNtYslWtqFWosTBdxOt0kqAYzbp4dh
         Sm+ZolZfYu71p80Ac0ymr+2c34t1cu25xoDWUrvWRywPKqORDXtO4EEYv++OexB5L+Rz
         6MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754750; x=1776359550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0PerIpgKG32JFRNFK9DSuHMidXArqX6Q005ECyvyPQ=;
        b=F1WwAneFtlggmTV4QxW9GVnU/AEsZrfpdg2IFTapuRMyD5dSy9X2OHgOHSQPhSPVBI
         lanzmGCut0v2nnawDtoOTpXFTdb+5R5a8viq0F+aDnTGkSwP6AWYE2T5gHK1qTl9r+cO
         QPZ2Iy0itw/5jVBoVioi3C/lU1kcAU39MmiODopS+tsfpfQBngNbrL0RH1fOkjaHzvfo
         I9lOpvFl1seq8xeCl4P4xsR8FJpXj4qEqj6B9ASH7Zn4BtZ8O8wpwTTu2SI2bA2+YTRR
         S0AuFxMCSEDISTUaSvwTd5/3s05j7vPBooer2P53/bR3yhT1TjwwbwC3c1GjNw16f3y5
         CjIQ==
X-Gm-Message-State: AOJu0YwIHRottOpfvP89838IEYF4eKafjO3szcTkTk1aAyKvjeW28v3/
	d0ksXY1JSbE7jXZg1wQd5LHncsGHD5qWzSf3/SAfMGS8jjnkRAoVy8HDxoi+Cgpn
X-Gm-Gg: AeBDietSgr6Atlhs6u++ltPqVE6zjQ8ZTdRPBAe9vpL3KtK6PldFBfPFBofKHmAZU35
	1nthaEjEeH5ueaMmIEtMHmrWiRErZF3K7pPDjWdeFuhDt/PTX3BT1szNCe3wtkgKlapDbdTb47u
	dt3sVskR82j2+gjOvGiaUJ+pISPwgUGHwREr3BAklvlgaNgPxZbilF/Z8wM3ShYXjEFgcOVMhyK
	Nipdclm4Otv8vRqhaQuAz/T5EbGcuW1nxxlqUII5dKFh3vt7YvYb48eAeuI8Ox25XxI7QD9rppT
	LW2TZPXNdHpqQRU+TwCO9h3VKvOaXxRXPtSuNbfrizSCyYx8O/LPAFw0fcGFsR5QK0wdMEUSTrK
	5wrwttgRn/c9Z9v1o8NxY++D6GE6vVq1JxilnRJLsfXJL331EDrAVsLqPoQn9iKzpZ3pYIUZ2Jc
	bAQzMe1ywkkad2E0D9gNlvxBIqDl8RXmorlzBBkg3sxaS3dVak
X-Received: by 2002:a17:903:a8f:b0:2b2:5637:1480 with SMTP id d9443c01a7336-2b2818850fdmr262690915ad.40.1775754750227;
        Thu, 09 Apr 2026 10:12:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08d1bsm752395ad.54.2026.04.09.10.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:12:29 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/4] net: dsa: yt921x: Add port police support
Date: Fri, 10 Apr 2026 01:12:03 +0800
Message-ID: <20260409171209.2575583-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409171209.2575583-1-mmyangfl@gmail.com>
References: <20260409171209.2575583-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277078-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B22C63CDF8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable rate meter ability and support limiting the rate of incoming
traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 325 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  54 +++++++
 2 files changed, 378 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 0c07b903fd68..f0ebbcd2151c 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -263,6 +263,14 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
  * eliminate potential issues, although partial reads/writes are also possible.
  */
 
+static void update_ctrls_unaligned(u32 *lo, u32 *hi, u64 mask, u64 val)
+{
+	*lo &= ~lower_32_bits(mask);
+	*hi &= ~upper_32_bits(mask);
+	*lo |= lower_32_bits(val);
+	*hi |= upper_32_bits(val);
+}
+
 static int
 yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
 		 unsigned int num_regs)
@@ -373,6 +381,12 @@ yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
 	return yt921x_regs_clear_bits(priv, reg, masks, 2);
 }
 
+static int
+yt921x_reg96_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
+{
+	return yt921x_regs_write(priv, reg, vals, 3);
+}
+
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 {
 	struct yt921x_reg_mdio *mdio = context;
@@ -1066,6 +1080,13 @@ yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 	return res;
 }
 
+static int yt921x_mtu_fetch(struct yt921x_priv *priv, int port)
+{
+	struct dsa_port *dp = dsa_to_port(&priv->ds, port);
+
+	return dp->user ? READ_ONCE(dp->user->mtu) : ETH_DATA_LEN;
+}
+
 static int
 yt921x_dsa_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
@@ -1097,6 +1118,268 @@ static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
 	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
 }
 
+/* v * 2^e */
+static u64 ldexpu64(u64 v, int e)
+{
+	return e >= 0 ? v << e : v >> -e;
+}
+
+/* slot (ns) * rate (/s) / 10^9 (ns/s) = 2^C * token * 4^unit */
+static u32 rate2token(u64 rate, unsigned int slot_ns, int unit, int C)
+{
+	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
+
+	return div_u64(ldexpu64(slot_ns * rate, -e), 1000000000);
+}
+
+static u64 token2rate(u32 token, unsigned int slot_ns, int unit, int C)
+{
+	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
+
+	return div_u64(ldexpu64(mul_u32_u32(1000000000, token), e), slot_ns);
+}
+
+/* burst = 2^C * token * 4^unit */
+static u32 burst2token(u64 burst, int unit, int C)
+{
+	return ldexpu64(burst, -(2 * unit + C));
+}
+
+static u64 token2burst(u32 token, int unit, int C)
+{
+	return ldexpu64(token, 2 * unit + C);
+}
+
+struct yt921x_marker {
+	u32 cir;
+	u32 cbs;
+	u32 ebs;
+	int unit;
+	bool pkt_mode;
+};
+
+#define YT921X_MARKER_PKT_MODE		BIT(0)
+#define YT921X_MARKER_SINGLE_BUCKET	BIT(1)
+
+static int
+yt921x_marker_tfm(struct yt921x_marker *marker, u64 rate, u64 burst,
+		  unsigned int flags, unsigned int slot_ns, u32 cir_max,
+		  u32 cbs_max, int unit_max, struct yt921x_priv *priv, int port,
+		  struct netlink_ext_ack *extack)
+{
+	const int C = flags & YT921X_MARKER_PKT_MODE ? YT921X_TOKEN_PKT_C :
+		      YT921X_TOKEN_BYTE_C;
+	struct device *dev = to_device(priv);
+	struct yt921x_marker m;
+	u64 burst_est;
+	u64 burst_sug;
+	u64 burst_max;
+	u64 rate_max;
+
+	m.unit = unit_max;
+	rate_max = token2rate(cir_max, slot_ns, m.unit, C);
+	burst_max = token2burst(cbs_max, m.unit, C);
+
+	/* Check for unusual values */
+	if (rate > rate_max || burst > burst_max) {
+		NL_SET_ERR_MSG_MOD(extack, "Unexpected tremendous rate");
+		return -ERANGE;
+	}
+
+	/* Check for matching burst */
+	burst_est = div_u64(slot_ns * rate, 1000000000);
+	burst_sug = burst_est;
+	if (flags & YT921X_MARKER_PKT_MODE)
+		burst_sug++;
+	else
+		burst_sug += ETH_HLEN + yt921x_mtu_fetch(priv, port) +
+			     ETH_FCS_LEN;
+	if (burst_sug > burst)
+		dev_warn(dev,
+			 "Consider burst at least %llu to match rate %llu\n",
+			 burst_sug, rate);
+
+	/* Select unit */
+	for (; m.unit > 0; m.unit--) {
+		if (rate > (rate_max >> 2) || burst > (burst_max >> 2))
+			break;
+		rate_max >>= 2;
+		burst_max >>= 2;
+	}
+
+	/* Calculate information rate and bucket size */
+	m.cir = rate2token(rate, slot_ns, m.unit, C);
+	if (!m.cir)
+		m.cir = 1;
+	else if (WARN_ON(m.cir > cir_max))
+		m.cir = cir_max;
+	m.cbs = burst2token(burst, m.unit, C);
+	if (!m.cbs)
+		m.cbs = 1;
+	else if (WARN_ON(m.cbs > cbs_max))
+		m.cbs = cbs_max;
+
+	/* Cut EBS */
+	m.ebs = 0;
+	if (!(flags & YT921X_MARKER_SINGLE_BUCKET)) {
+		/* We don't have a chance to adjust rate when MTU is changed */
+		if (flags & YT921X_MARKER_PKT_MODE)
+			burst_est++;
+		else
+			burst_est += YT921X_FRAME_SIZE_MAX;
+
+		if (burst_est < burst) {
+			u32 pbs = m.cbs;
+
+			m.cbs = burst2token(burst_est, m.unit, C);
+			if (!m.cbs) {
+				m.cbs = 1;
+			} else if (m.cbs > cbs_max) {
+				WARN_ON(1);
+				m.cbs = cbs_max;
+			}
+
+			if (pbs > m.cbs)
+				m.ebs = pbs - m.cbs;
+		}
+	}
+
+	dev_dbg(dev,
+		"slot %u ns, rate %llu, burst %llu -> unit %d, cir %u, cbs %u, ebs %u\n",
+		slot_ns, rate, burst, m.unit, m.cir, m.cbs, m.ebs);
+
+	m.pkt_mode = flags & YT921X_MARKER_PKT_MODE;
+	*marker = m;
+	return 0;
+}
+
+static int
+yt921x_marker_tfm_police(struct yt921x_marker *marker,
+			 const struct flow_action_police *police,
+			 unsigned int flags, struct yt921x_priv *priv, int port,
+			 struct netlink_ext_ack *extack)
+{
+	bool pkt_mode = !!police->rate_pkt_ps;
+	u64 burst;
+	u64 rate;
+
+	rate = pkt_mode ? police->rate_pkt_ps : police->rate_bytes_ps;
+	burst = pkt_mode ? police->burst_pkt : police->burst;
+	if (pkt_mode)
+		flags |= YT921X_MARKER_PKT_MODE;
+
+	return yt921x_marker_tfm(marker, rate, burst, flags,
+				 priv->meter_slot_ns, YT921X_METER_CIR_MAX,
+				 YT921X_METER_CBS_MAX, YT921X_METER_UNIT_MAX,
+				 priv, port, extack);
+}
+
+static int
+yt921x_police_validate(const struct flow_action_police *police,
+		       const struct flow_action *action,
+		       const struct flow_action_entry *act,
+		       struct netlink_ext_ack *extack)
+{
+	if (police->exceed.act_id != FLOW_ACTION_DROP) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when exceed action is not drop");
+		return -EOPNOTSUPP;
+	}
+
+	if (police->notexceed.act_id != FLOW_ACTION_PIPE &&
+	    police->notexceed.act_id != FLOW_ACTION_ACCEPT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when conform action is not pipe or ok");
+		return -EOPNOTSUPP;
+	}
+
+	if (police->notexceed.act_id == FLOW_ACTION_ACCEPT && action && act &&
+	    !flow_action_is_last_entry(action, act)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when conform action is ok, but action is not last");
+		return -EOPNOTSUPP;
+	}
+
+	/* mtu defaults to unlimited but we got 2040 here, don't know why */
+	if (police->peakrate_bytes_ps || police->avrate || police->overhead) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload not supported when peakrate/avrate/overhead is configured");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_meter_config(struct yt921x_priv *priv, unsigned int id,
+		    const struct yt921x_marker *marker)
+{
+	u32 ctrls[3];
+
+	ctrls[0] = 0;
+	ctrls[1] = YT921X_METER_CTRLb_CIR(marker->cir);
+	ctrls[2] = YT921X_METER_CTRLc_UNIT(marker->unit) |
+		   YT921X_METER_CTRLc_DROP_R |
+		   YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN |
+		   YT921X_METER_CTRLc_METER_EN;
+	if (marker->pkt_mode)
+		ctrls[2] |= YT921X_METER_CTRLc_PKT_MODE;
+	update_ctrls_unaligned(&ctrls[0], &ctrls[1],
+			       YT921X_METER_CTRLab_EBS_M,
+			       YT921X_METER_CTRLab_EBS(marker->ebs));
+	update_ctrls_unaligned(&ctrls[1], &ctrls[2],
+			       YT921X_METER_CTRLbc_CBS_M,
+			       YT921X_METER_CTRLbc_CBS(marker->cbs));
+
+	return yt921x_reg96_write(priv, YT921X_METERn_CTRL(id), ctrls);
+}
+
+static void yt921x_dsa_port_policer_del(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_PORTn_METER(port), 0);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "delete policer on",
+			port, res);
+}
+
+static int
+yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
+			    const struct flow_action_police *police,
+			    struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_marker marker;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_police_validate(police, NULL, NULL, extack);
+	if (res)
+		return res;
+
+	res = yt921x_marker_tfm_police(&marker, police, 0, priv, port, extack);
+	if (res)
+		return res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_meter_config(priv, port + YT921X_METER_NUM, &marker);
+	if (res)
+		goto end;
+
+	ctrl = YT921X_PORT_METER_ID(port) | YT921X_PORT_METER_EN;
+	res = yt921x_reg_write(priv, YT921X_PORTn_METER(port), ctrl);
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -3052,6 +3335,7 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 	u32 chipid;
 	u32 major;
 	u32 mode;
+	u32 val;
 	int res;
 
 	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
@@ -3086,12 +3370,27 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 		return -ENODEV;
 	}
 
+	res = yt921x_reg_read(priv, YT921X_SYS_CLK, &val);
+	if (res)
+		return res;
+	switch (FIELD_GET(YT921X_SYS_CLK_SEL_M, val)) {
+	case 0:
+		priv->cycle_ns = info->major == YT9215_MAJOR ? 8 : 6;
+		break;
+	case YT921X_SYS_CLK_143M:
+		priv->cycle_ns = 7;
+		break;
+	default:
+		priv->cycle_ns = 8;
+	}
+
 	/* Print chipid here since we are interested in lower 16 bits */
 	dev_info(dev,
 		 "Motorcomm %s ethernet switch, chipid: 0x%x, chipmode: 0x%x 0x%x\n",
 		 info->name, chipid, mode, extmode);
 
 	priv->info = info;
+
 	return 0;
 }
 
@@ -3213,6 +3512,23 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	return 0;
 }
 
+static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
+{
+	unsigned int op_ns;
+	u32 ctrl;
+	int res;
+
+	op_ns = 8 * priv->cycle_ns;
+
+	ctrl = max(priv->meter_slot_ns / op_ns, YT921X_METER_SLOT_MIN);
+	res = yt921x_reg_write(priv, YT921X_METER_SLOT, ctrl);
+	if (res)
+		return res;
+	priv->meter_slot_ns = ctrl * op_ns;
+
+	return 0;
+}
+
 static int __maybe_unused yt921x_chip_setup_qos(struct yt921x_priv *priv)
 {
 	u32 ctrl;
@@ -3259,7 +3575,7 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	u32 ctrl;
 	int res;
 
-	ctrl = YT921X_FUNC_MIB;
+	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_METER;
 	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
 	if (res)
 		return res;
@@ -3268,6 +3584,10 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_chip_setup_tc(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_DCB)
 	res = yt921x_chip_setup_qos(priv);
 	if (res)
@@ -3359,6 +3679,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mtu */
 	.port_change_mtu	= yt921x_dsa_port_change_mtu,
 	.port_max_mtu		= yt921x_dsa_port_max_mtu,
+	/* rate */
+	.port_policer_del	= yt921x_dsa_port_policer_del,
+	.port_policer_add	= yt921x_dsa_port_policer_add,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 4989d87c2492..01cc2298be94 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -23,6 +23,7 @@
 #define  YT921X_RST_HW				BIT(31)
 #define  YT921X_RST_SW				BIT(1)
 #define YT921X_FUNC			0x80004
+#define  YT921X_FUNC_METER			BIT(4)
 #define  YT921X_FUNC_MIB			BIT(1)
 #define YT921X_CHIP_ID			0x80008
 #define  YT921X_CHIP_ID_MAJOR			GENMASK(31, 16)
@@ -239,6 +240,11 @@
 #define  YT921X_EDATA_DATA_STATUS_M		GENMASK(3, 0)
 #define   YT921X_EDATA_DATA_STATUS(x)			FIELD_PREP(YT921X_EDATA_DATA_STATUS_M, (x))
 #define   YT921X_EDATA_DATA_IDLE			YT921X_EDATA_DATA_STATUS(3)
+#define YT921X_SYS_CLK			0xe0040
+#define  YT921X_SYS_CLK_SEL_M			GENMASK(1, 0)  /* unknown: 167M */
+#define   YT9215_SYS_CLK_125M				0
+#define   YT9218_SYS_CLK_167M				0
+#define   YT921X_SYS_CLK_143M				1
 
 #define YT921X_EXT_MBUS_OP		0x6a000
 #define YT921X_INT_MBUS_OP		0xf0000
@@ -465,6 +471,42 @@ enum yt921x_app_selector {
 #define  YT921X_LAG_HASH_MAC_DA			BIT(1)
 #define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
 
+#define YT921X_PORTn_RATE(port)		(0x220000 + 4 * (port))
+#define  YT921X_PORT_RATE_GAP_VALUE		GENMASK(4, 0)	/* default 20 */
+#define YT921X_METER_SLOT		0x220104
+#define  YT921X_METER_SLOT_SLOT_M		GENMASK(11, 0)
+#define YT921X_PORTn_METER(port)	(0x220108 + 4 * (port))
+#define  YT921X_PORT_METER_EN			BIT(4)
+#define  YT921X_PORT_METER_ID_M			GENMASK(3, 0)
+#define   YT921X_PORT_METER_ID(x)			FIELD_PREP(YT921X_PORT_METER_ID_M, (x))
+#define YT921X_METERn_CTRL(x)		(0x220800 + 0x10 * (x))
+#define  YT921X_METER_CTRLc_METER_EN		BIT(14)
+#define  YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN	BIT(13)	/* RFC4115: yellow use unused green bw */
+#define  YT921X_METER_CTRLc_DROP_M		GENMASK(12, 11)
+#define   YT921X_METER_CTRLc_DROP(x)			FIELD_PREP(YT921X_METER_CTRLc_DROP_M, (x))
+#define   YT921X_METER_CTRLc_DROP_GYR			YT921X_METER_CTRLc_DROP(0)
+#define   YT921X_METER_CTRLc_DROP_YR			YT921X_METER_CTRLc_DROP(1)
+#define   YT921X_METER_CTRLc_DROP_R			YT921X_METER_CTRLc_DROP(2)
+#define   YT921X_METER_CTRLc_DROP_NONE			YT921X_METER_CTRLc_DROP(3)
+#define  YT921X_METER_CTRLc_COLOR_BLIND		BIT(10)
+#define  YT921X_METER_CTRLc_UNIT_M		GENMASK(9, 7)
+#define   YT921X_METER_CTRLc_UNIT(x)			FIELD_PREP(YT921X_METER_CTRLc_UNIT_M, (x))
+#define  YT921X_METER_CTRLc_BYTE_MODE_INCLUDE_GAP	BIT(6)	/* +GAP_VALUE bytes each packet */
+#define  YT921X_METER_CTRLc_PKT_MODE		BIT(5)	/* 0: byte rate mode */
+#define  YT921X_METER_CTRLc_RFC2698		BIT(4)	/* 0: RFC4115 */
+#define  YT921X_METER_CTRLbc_CBS_M		GENMASK_ULL(35, 20)
+#define   YT921X_METER_CTRLbc_CBS(x)			FIELD_PREP(YT921X_METER_CTRLbc_CBS_M, (x))
+#define  YT921X_METER_CTRLb_CIR_M		GENMASK(19, 2)
+#define   YT921X_METER_CTRLb_CIR(x)			FIELD_PREP(YT921X_METER_CTRLb_CIR_M, (x))
+#define  YT921X_METER_CTRLab_EBS_M		GENMASK_ULL(33, 18)
+#define   YT921X_METER_CTRLab_EBS(x)			FIELD_PREP(YT921X_METER_CTRLab_EBS_M, (x))
+#define  YT921X_METER_CTRLa_EIR_M		GENMASK(17, 0)
+#define   YT921X_METER_CTRLa_EIR(x)			FIELD_PREP(YT921X_METER_CTRLa_EIR_M, (x))
+#define YT921X_METERn_STAT_EXCESS(x)	(0x221000 + 8 * (x))
+#define YT921X_METERn_STAT_COMMITTED(x)	(0x221004 + 8 * (x))
+#define  YT921X_METER_STAT_TOKEN_M		GENMASK(30, 15)
+#define  YT921X_METER_STAT_QUEUE_M		GENMASK(14, 0)
+
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
 #define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_EN	BIT(30)
@@ -508,6 +550,16 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_MSTI_NUM		16
 
+#define YT921X_TOKEN_BYTE_C	1	/* 1 token = 2^1 byte */
+#define YT921X_TOKEN_PKT_C	-6	/* 1 token = 2^-6 packets */
+#define YT921X_TOKEN_RATE_C	-15
+/* Custom meters only, not including dedicated port meters (11) */
+#define YT921X_METER_NUM	64
+#define YT921X_METER_SLOT_MIN	80
+#define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_METER_CIR_MAX	((1 << 18) - 1)
+#define YT921X_METER_CBS_MAX	((1 << 16) - 1)
+
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
 
@@ -602,8 +654,10 @@ struct yt921x_priv {
 	struct dsa_switch ds;
 
 	const struct yt921x_info *info;
+	unsigned int meter_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
+	unsigned char cycle_ns;
 
 	/* protect the access to the switch registers */
 	struct mutex reg_lock;
-- 
2.53.0


