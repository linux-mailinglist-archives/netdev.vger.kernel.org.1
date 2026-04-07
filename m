Return-Path: <netdev+bounces-276074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FsPNesu1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E863B1BC9
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10F1830BCF7D
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB813D5222;
	Tue,  7 Apr 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfmu6t4p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92A2773EC
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578233; cv=none; b=Umd3YzoO0BKTzPumNjSj4BdqkVhiERzqNwaKnQ3cnwKXfconIw/F3ZLOX6fifp3uRoUjelSQ3EeD5e3Q6OvX6CtcSdJLXCdR1oGGDYwKHA0OSZL3g6g+sQ7Opzq/oTbqftGPIt30wcVI4si563mzZ7Iy+8JCuc0PovWApagR8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578233; c=relaxed/simple;
	bh=g2mfLVmLwZ+cJYfQtFfWR/Yr96oiHaXcdKw8NGPLMbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km6Q3uhpFNG3/M6hxMLEBGJozH2ePc/Cs57/2JcZqcm6PMl4xcHLKaTWvLgWvVvrosZqRHffTTF5Hwr4S0PYHv2/rkWt/8Iz1z5igGxlyznmNcC2P4Qev8gBdAkikpuM3wr3t4XNnyDUbWS4veQ/cBRNe2IXlorFhtaA7WhwOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfmu6t4p; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1842730a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578226; x=1776183026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYakr9JQEjE2FqaXKjcdVODvFiPPk2RzFGSKQlkcOZ4=;
        b=Xfmu6t4pjnmuNmDK4oweKsvDCRXDo2DpW26vFs6MDhiT2bkR7A8Gs7PDrDQmTaqfAc
         ZZzgByGld0rRlYVB39spjHAVk3RkRvUC8Pfwien11yobD6zb5gGUFQ97mE0iGyIzQaG5
         TpVbwObj0QoKwWwctvOogShh0tz6sOeKxabQ+y6PJfWmNCHR1EfpHfZIVzLqPsgzJOuA
         J0xsiVz1hCOQwCQjW0TBtdnsoPq++HcLWyZMHukoTcSMnyyLV4F3VpOXTZZT6+sK0Dx3
         WkFEAxGAkEzsaTfzSKfgJQW17SqOdd7wwtyAVh9zKTRBZqjfU6WZL2vQnB8zuAvAEo09
         eTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578226; x=1776183026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYakr9JQEjE2FqaXKjcdVODvFiPPk2RzFGSKQlkcOZ4=;
        b=jzG2JrjdTXk3EyhNJISAtJD+f1knDosoEJSMNj65tRu3ZEYexFIexLlOZj8IXhpUj9
         QlF1ybPwgCzmcBbLk8uveYXeaurSN4Orjk5OQDB6NRQsIxBBbwhUqctESGwcc5XORYEJ
         UsU5XdtJIs4sNDpi1uu337V7aG2YjlCiYe3mDvAEY+D/phuTeKJWwHyVCojh5QDtcp0R
         5xX0UTiHj97q3nPSqv+V+0SAojQL7zqVN4XPRS+kZWKADzxpp8owupgjfOv9BOu8ikLO
         RpSwVN/Yc1FxblJsX4aezq+1KZ5UScePT2ow7HKZJnVc+qKDqDg1P05kmOx2n++I5Hyl
         DPcg==
X-Gm-Message-State: AOJu0YwQnrizeUC8a1fjVBLd9RwTKeKbxT4vnDjRXpTzGOaWPTv1oHSR
	5wzGI9mo5l9gLrgq4F2r/F4Z5gXCPXR2lzsecqPoEbRCi6c1XmK0T8Zlx1w0eg==
X-Gm-Gg: AeBDievAMHNUDsxViYZUf9yh9cYP3KFaBLtMk7pg1j88ARw6UC3d0Tzrh+HtFanaogy
	BOsKyHohRAiyurRcOok9BO4mtFpkswAWgdr0OrPxb7gIdvyTw5zgHc4jr7iAGsfAbcq5eN0FW5w
	d31PrdseG2I3LYX9ocSzHXjUvUEIZUWoTOSNbAwLBghalI4mdGog69tp95vo5taLO6YBZZaeK+U
	JNBPzzGe84khQTJfvxTQRDWlRmmnRDVmrwDHy9Q0rNS76/ZKpnX+vzHZBZZvcKZYSI5hNG16Zf5
	HBHHqZP/JYrMpZIhP6dz7V5Qkxe4Kbr+mnb0stvrwxUsRL+bOfz2ZZdQGA911C3vWRJ+M+eENRN
	5PefU4DUarjwpSKbetNO+LQ+jcfkhrUHBmRTVLCjvr3sSHdqGSHLUjXeOuG5Q6Jjig9l2v15px3
	XWFhGhSaRQmn3dR6gdOrulI0DfrO4JBBVJXNY74rYHdwa/u8g7
X-Received: by 2002:a05:6a20:430b:b0:39b:e789:7d10 with SMTP id adf61e73a8af0-39f2f20dfc7mr18092550637.57.1775578225497;
        Tue, 07 Apr 2026 09:10:25 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6372078sm15650238a12.0.2026.04.07.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:10:25 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/4] net: dsa: yt921x: Add port police support
Date: Wed,  8 Apr 2026 00:05:55 +0800
Message-ID: <20260407160559.1747616-4-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276074-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61E863B1BC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable rate meter ability and support limiting the rate of incoming
traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 276 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  54 ++++++++
 2 files changed, 329 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index de6aa5835616..e77bd4a34e10 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -262,6 +262,14 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
  * wrapper so that we can handle them consistently.
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
@@ -372,6 +380,12 @@ yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
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
@@ -1065,6 +1079,13 @@ yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
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
@@ -1096,6 +1117,219 @@ static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
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
+struct yt921x_meter {
+	u32 cir;
+	u32 cbs;
+	u32 ebs;
+	int unit;
+};
+
+#define YT921X_METER_PKT_MODE		BIT(0)
+#define YT921X_METER_SINGLE_BUCKET	BIT(1)
+
+static int
+yt921x_meter_tfm(struct yt921x_priv *priv, int port, unsigned int slot_ns,
+		 u64 rate, u64 burst, unsigned int flags,
+		 u32 cir_max, u32 cbs_max, int unit_max,
+		 struct yt921x_meter *meterp)
+{
+	const int C = flags & YT921X_METER_PKT_MODE ? YT921X_TOKEN_PKT_C :
+		      YT921X_TOKEN_BYTE_C;
+	struct device *dev = to_device(priv);
+	struct yt921x_meter meter;
+	u64 burst_est;
+	u64 burst_sug;
+	u64 burst_max;
+	u64 rate_max;
+
+	meter.unit = unit_max;
+	rate_max = token2rate(cir_max, slot_ns, meter.unit, C);
+	burst_max = token2burst(cbs_max, meter.unit, C);
+
+	/* Check for unusual values */
+	if (rate > rate_max || burst > burst_max)
+		return -ERANGE;
+
+	/* Check for matching burst */
+	burst_est = div_u64(slot_ns * rate, 1000000000);
+	burst_sug = burst_est;
+	if (flags & YT921X_METER_PKT_MODE)
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
+	for (; meter.unit > 0; meter.unit--) {
+		if (rate > (rate_max >> 2) || burst > (burst_max >> 2))
+			break;
+		rate_max >>= 2;
+		burst_max >>= 2;
+	}
+
+	/* Calculate information rate and bucket size */
+	meter.cir = rate2token(rate, slot_ns, meter.unit, C);
+	if (!meter.cir)
+		meter.cir = 1;
+	else if (WARN_ON(meter.cir > cir_max))
+		meter.cir = cir_max;
+	meter.cbs = burst2token(burst, meter.unit, C);
+	if (!meter.cbs)
+		meter.cbs = 1;
+	else if (WARN_ON(meter.cbs > cbs_max))
+		meter.cbs = cbs_max;
+
+	/* Cut EBS */
+	meter.ebs = 0;
+	if (!(flags & YT921X_METER_SINGLE_BUCKET)) {
+		/* We don't have a chance to adjust rate when MTU is changed */
+		if (flags & YT921X_METER_PKT_MODE)
+			burst_est++;
+		else
+			burst_est += YT921X_FRAME_SIZE_MAX;
+
+		if (burst_est < burst) {
+			u32 pbs = meter.cbs;
+
+			meter.cbs = burst2token(burst_est, meter.unit, C);
+			if (!meter.cbs) {
+				meter.cbs = 1;
+			} else if (meter.cbs > cbs_max) {
+				WARN_ON(1);
+				meter.cbs = cbs_max;
+			}
+
+			if (pbs > meter.cbs)
+				meter.ebs = pbs - meter.cbs;
+		}
+	}
+
+	dev_dbg(dev,
+		"slot %u ns, rate %llu, burst %llu -> unit %d, cir %u, cbs %u, ebs %u\n",
+		slot_ns, rate, burst,
+		meter.unit, meter.cir, meter.cbs, meter.ebs);
+
+	*meterp = meter;
+	return 0;
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
+			    const struct flow_action_police *policer,
+			    struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_meter meter;
+	bool pkt_mode;
+	u32 ctrls[3];
+	u64 burst;
+	u64 rate;
+	u32 ctrl;
+	int res;
+
+	/* mtu defaults to unlimited but we got 2040 here, don't know why */
+	if (policer->peakrate_bytes_ps || policer->avrate || policer->overhead) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "peakrate / avrate / overhead not supported");
+		return -EOPNOTSUPP;
+	}
+	if (policer->exceed.act_id != FLOW_ACTION_DROP ||
+	    policer->notexceed.act_id != FLOW_ACTION_ACCEPT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "conform-exceed other than drop-ok not supported");
+		return -EOPNOTSUPP;
+	}
+
+	pkt_mode = !!policer->rate_pkt_ps;
+	rate = pkt_mode ? policer->rate_pkt_ps : policer->rate_bytes_ps;
+	burst = pkt_mode ? policer->burst_pkt : policer->burst;
+	res = yt921x_meter_tfm(priv, port, priv->meter_slot_ns, rate, burst,
+			       pkt_mode ? YT921X_METER_PKT_MODE : 0,
+			       YT921X_METER_CIR_MAX, YT921X_METER_CBS_MAX,
+			       YT921X_METER_UNIT_MAX, &meter);
+	if (res) {
+		NL_SET_ERR_MSG_MOD(extack, "Unexpected tremendous rate");
+		return res;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	ctrl = YT921X_PORT_METER_ID(port) | YT921X_PORT_METER_EN;
+	res = yt921x_reg_write(priv, YT921X_PORTn_METER(port), ctrl);
+	if (res)
+		goto end;
+
+	ctrls[0] = 0;
+	ctrls[1] = YT921X_METER_CTRLb_CIR(meter.cir);
+	ctrls[2] = YT921X_METER_CTRLc_UNIT(meter.unit) |
+		   YT921X_METER_CTRLc_DROP_R |
+		   YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN |
+		   YT921X_METER_CTRLc_METER_EN;
+	update_ctrls_unaligned(&ctrls[0], &ctrls[1],
+			       YT921X_METER_CTRLab_EBS_M,
+			       YT921X_METER_CTRLab_EBS(meter.ebs));
+	update_ctrls_unaligned(&ctrls[1], &ctrls[2],
+			       YT921X_METER_CTRLbc_CBS_M,
+			       YT921X_METER_CTRLbc_CBS(meter.cbs));
+	res = yt921x_reg96_write(priv,
+				 YT921X_METERn_CTRL(port + YT921X_METER_NUM),
+				 ctrls);
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -3051,6 +3285,7 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 	u32 chipid;
 	u32 major;
 	u32 mode;
+	u32 val;
 	int res;
 
 	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
@@ -3085,12 +3320,27 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
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
 
@@ -3212,6 +3462,23 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
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
@@ -3258,7 +3525,7 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	u32 ctrl;
 	int res;
 
-	ctrl = YT921X_FUNC_MIB;
+	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_METER;
 	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
 	if (res)
 		return res;
@@ -3267,6 +3534,10 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_chip_setup_tc(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_DCB)
 	res = yt921x_chip_setup_qos(priv);
 	if (res)
@@ -3358,6 +3629,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
index 4989d87c2492..a640672d1f1e 100644
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
+/* for VLAN only, not including port meters */
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
+	u8 cycle_ns;
 
 	/* protect the access to the switch registers */
 	struct mutex reg_lock;
-- 
2.53.0


