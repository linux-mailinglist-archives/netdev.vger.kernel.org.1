Return-Path: <netdev+bounces-254662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJFeAh0ge2lPBgIAu9opvQ
	(envelope-from <netdev+bounces-254662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:53:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC99ADC90
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C19E3008331
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C195037F0E3;
	Thu, 29 Jan 2026 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPVJWnEl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35D37E308
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676814; cv=none; b=JYbka8X4WsQapVTz0suNgQQRM7dd9+REqyNGcr6QYioVPUxKjUKoeFAlOj/UTBdDWRk9QYqan8aSpSlUBPed1gw037orjhVO6BriqXrooGUxaTOedrDKcjbmCKQWMcmEYNs9r3QXmYyso67q+G2aQlrog2Eo0sFcYfgTVXIT37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676814; c=relaxed/simple;
	bh=XMvN8ZTq7GHPxlr3sFkJ1y/cVq+Y062nCOx1lnUG18k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7tUNFS9KRplTkU8mucbuVgImyQt/ortt8266PrAn4FTc06UWzRUHG7ZjgxxqdyD1fUaFexGq+OIdjKz3mYnI1x9vnyZ3fXkrQ5qwVBh4RBpTbXiSeP9fRjnPSvi5NEc92roFZo5fpgssDqmp7NOv/IeeiOzUmYjLduZi3ayqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPVJWnEl; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a1022dda33so4102435ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769676809; x=1770281609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poMxq/4p/orTNgWmytXg7LTqAfSrNEbsQxhTV3fiZ6Q=;
        b=PPVJWnElqAC0Mp7CEaBvbrSR13wCKgoHpgyBZ1ea/gmOxn15cR9hXhEgSxxqOKsfj2
         dM7Hp2IBVNdUkTgB9FYrowFTYJrU8CiV0GIANSbZLdEHPW0bU22uFEXlsq39NMp27aVn
         rm5wSCS2VzHAvn6/hnFqOKHVs94lhwmOqzz9HztOoYxmserbqa6lsLg0Mgkube/CobUN
         51M45+0lQ9J3Dq39WI0k8Yi/UsM8jjgaT87OCm5OfOpZ6jFY0XYKUazvhEysiV/hlQQM
         T1NhWlBlxHgWXrEKVuZsLGheM3/u1FlF/n/2pL3DVGoBa3jB++RAOofyF0h7A2pbnw+A
         W5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676809; x=1770281609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=poMxq/4p/orTNgWmytXg7LTqAfSrNEbsQxhTV3fiZ6Q=;
        b=DDT2047dcZlXlaIDEX9nQIdemANHEsCC8R/H9+8RDElW8Smob5Lg3zd6MkUB6HXrwP
         w3otcw3KxX9gbtIvuj1Sj9lkLtZAdv+82LTbsFM4ml4H0b1Pf3Dm28GowA6mXou0vL4e
         C1EqdbmwibQqNi/olvT/E+ISenvnvFWr2YX1Bombs5M+1nT1AzqaRIpxqrb3mRCnifyu
         cMmqXLgm7Y2uAeBDHyxjK3QtOsLuY0HSljgfLc9pBddCHEmDYuMOlaIpS03ua8OXm/aa
         6rHH8Sc4YlREXihn2mGJ+Tctc51F+BDyqVDa2UJ5VQd+JEdWrnurGiudCfF6cM/1Pvr7
         NiJQ==
X-Gm-Message-State: AOJu0YyQu+q8gZz67epNoqO5Q69f0wV9QzEpR6WG7oboIKopk/m0uqVW
	iEpc71jWbxL4h0Dqp4vqbk1Nub3xpHlxi/RIN2iEqJziuRARI9/rdCQqzb746He5xao=
X-Gm-Gg: AZuq6aKBR0uZxij80NMfx8XN3b9CPNxXkHhqhqfo/tnrbAoJrJx2YINlDqrcSJ8K3em
	y1sBhDwqTZ7Q8/d4B0CIzQgFCK4xf5viZQ8jAAN6ZTnP9Tc6HGhTNMra3e3Sui+smFHyv3KSKh7
	Yx0i3GihpZgUXadzDmnb7R9QU6xQ3fE+d+teKhkxxG8bqiRIeKF1rX6PhfjCK4mSNhqQwysztRk
	tZ1khIJ2WAy19e9kCDSz4C89locx0X0MrdsoW6Zqrn3+ain2YW/3JUKDQ4S9ATOdgtBFIQws7kg
	JFgBtnF3Mt+jeswtIf0SliB+YUtQK0I/41r3wWOGQmFLgrUkgTiex/segpMixjesdQgsSzq+mXI
	nD8CZ9EkO/Q0GcNEPNJ71Sp/fHOHyR+Xq1jEAPsDAmVeBx0Vtd5AtjqSyr5x2f3ChnxgMuxYX6C
	0EdFJHmq5djRoDpz5Pwygy7Tbgi2Hsrdw1ExA=
X-Received: by 2002:a17:903:4b08:b0:2a7:6114:4865 with SMTP id d9443c01a7336-2a870dfbf3emr76893405ad.61.1769676808616;
        Thu, 29 Jan 2026 00:53:28 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef50sm44651165ad.12.2026.01.29.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:53:28 -0800 (PST)
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
Subject: [RFC net-next 3/4] net: dsa: yt921x: Add port police support
Date: Thu, 29 Jan 2026 16:51:35 +0800
Message-ID: <20260129085139.2767649-4-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254662-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DC99ADC90
X-Rspamd-Action: no action

Enable rate meter ability and support limiting the rate of incoming
traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 255 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  56 +++++++++
 2 files changed, 310 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 6d03888b6743..f1465c4d9b1b 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -356,6 +356,14 @@ yt921x_longreg_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
 	return yt921x_longreg_write(priv, reg, vs, span);
 }
 
+static void u32a_update_u64(u32 *arr, u64 mask, u64 val)
+{
+	arr[0] &= ~((u32)mask);
+	arr[1] &= ~((u32)(mask >> 32));
+	arr[0] |= (u32)val;
+	arr[1] |= (u32)(val >> 32);
+}
+
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 {
 	struct yt921x_reg_mdio *mdio = context;
@@ -1047,6 +1055,13 @@ yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
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
@@ -1078,6 +1093,204 @@ static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
 	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
 }
 
+/* v * 2^e */
+#define ldexpi(v, e) ({ \
+	__auto_type _v = (v); \
+	__auto_type _e = (e); \
+	_e >= 0 ? _v << _e : _v >> -_e; \
+})
+
+/* slot (ns) * rate (/s) / 10^9 (ns/s) = 2^C * token * 4^unit */
+#define rate2token(rate, unit, slot_ns, C) \
+	((u32)(ldexpi((slot_ns) * (rate), \
+		      -(2 * (unit) + (C) + YT921X_TOKEN_RATE_C)) / 1000000000))
+#define token2rate(token, unit, slot_ns, C) \
+	(ldexpi(1000000000 * (u64)(token), \
+		2 * (unit) + (C) + YT921X_TOKEN_RATE_C) / (slot_ns))
+
+/* burst = 2^C * token * 4^unit */
+#define burst2token(burst, unit, C) ((u32)ldexpi((burst), -(2 * (unit) + (C))))
+#define token2burst(token, unit, C) ldexpi((u64)(token), 2 * (unit) + (C))
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
+static struct yt921x_meter
+yt921x_meter_tfm(struct yt921x_priv *priv, int port, unsigned int slot_ns,
+		 u64 rate, u64 burst, unsigned int flags,
+		 u32 cir_max, u32 cbs_max, int unit_max)
+{
+	const int C = flags & YT921X_METER_PKT_MODE ? YT921X_TOKEN_PKT_C :
+		      YT921X_TOKEN_BYTE_C;
+	struct device *dev = to_device(priv);
+	struct yt921x_meter meter;
+	bool distorted;
+	u64 burst_est;
+	u64 burst_max;
+	u64 rate_max;
+
+	meter.unit = unit_max;
+	rate_max = token2rate(cir_max, meter.unit, slot_ns, C);
+	burst_max = token2burst(cbs_max, meter.unit, C);
+
+	/* clamp rate and burst */
+	if (rate > rate_max || burst > burst_max) {
+		dev_warn(dev,
+			 "rate %llu, burst %llu too high, max is %llu, %llu, clamping...\n",
+			 rate, burst, rate_max, burst_max);
+
+		if (rate > rate_max)
+			rate = rate_max;
+		if (burst > burst_max)
+			burst = burst_max;
+
+		burst_est = slot_ns * rate / 1000000000;
+	} else {
+		u64 burst_sug;
+
+		burst_est = slot_ns * rate / 1000000000;
+		burst_sug = burst_est;
+		if (flags & YT921X_METER_PKT_MODE)
+			burst_sug++;
+		else
+			burst_sug += ETH_HLEN + yt921x_mtu_fetch(priv, port) +
+				     ETH_FCS_LEN;
+		if (burst_sug > burst)
+			dev_warn(dev,
+				 "Consider using burst at least %llu to match rate %llu\n",
+				 burst_sug, rate);
+
+		/* select unit */
+		for (; meter.unit > 0; meter.unit--) {
+			if (rate > (rate_max >> 2) || burst > (burst_max >> 2))
+				break;
+			rate_max >>= 2;
+			burst_max >>= 2;
+		}
+	}
+
+	/* calculate information rate and bucket size */
+	distorted = false;
+	meter.cir = rate2token(rate, meter.unit, slot_ns, C);
+	if (!meter.cir) {
+		distorted = true;
+		meter.cir = 1;
+	} else if (meter.cir > cir_max) {
+		WARN_ON(1);
+		meter.cir = cir_max;
+	}
+	meter.cbs = burst2token(burst, meter.unit, C);
+	if (!meter.cbs) {
+		distorted = true;
+		meter.cbs = 1;
+	} else if (meter.cbs > cbs_max) {
+		WARN_ON(1);
+		meter.cbs = cbs_max;
+	}
+	if (distorted)
+		dev_warn(dev,
+			 "Have to increase rate %llu, burst %llu to %llu, %llu\n",
+			 rate, burst,
+			 token2rate(meter.cir, meter.unit, slot_ns, C),
+			 token2burst(meter.cbs, meter.unit, C));
+
+	/* cut ebs */
+	meter.ebs = 0;
+	if (!(flags & YT921X_METER_SINGLE_BUCKET)) {
+		/* we don't have a chance to adjust rate when MTU is changed */
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
+	return meter;
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
+		print_port_err(dev, port, res, "delete policer on");
+}
+
+static int
+yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
+			    struct dsa_mall_policer_tc_entry *policer)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 ctrls[YT921X_METER_CTRL_S];
+	struct yt921x_meter meter;
+	u64 burst;
+	u64 rate;
+	u32 ctrl;
+	int res;
+
+	rate = policer->rate_bytes_per_sec;
+	burst = policer->burst;
+	meter = yt921x_meter_tfm(priv, port, priv->meter_slot_ns, rate, burst,
+				 0, YT921X_METER_RATE_MAX,
+				 YT921X_METER_BURST_MAX, YT921X_METER_UNIT_MAX);
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
+	u32a_update_u64(&ctrls[0], YT921X_METER_CTRLab_EBS_M,
+			YT921X_METER_CTRLab_EBS(meter.ebs));
+	u32a_update_u64(&ctrls[1], YT921X_METER_CTRLbc_CBS_M,
+			YT921X_METER_CTRLbc_CBS(meter.cbs));
+	res = yt921x_longreg_write(priv,
+				   YT921X_METERn_CTRL(port + YT921X_METER_NUM),
+				   ctrls, YT921X_METER_CTRL_S);
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -3040,6 +3253,7 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 	u32 chipid;
 	u32 major;
 	u32 mode;
+	u32 val;
 	int res;
 
 	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
@@ -3074,12 +3288,27 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
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
 
@@ -3202,6 +3431,23 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
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
@@ -3248,7 +3494,7 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	u32 ctrl;
 	int res;
 
-	ctrl = YT921X_FUNC_MIB;
+	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_METER;
 	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
 	if (res)
 		return res;
@@ -3257,6 +3503,10 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_chip_setup_tc(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_DCB)
 	res = yt921x_chip_setup_qos(priv);
 	if (res)
@@ -3348,6 +3598,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
index 361470582687..129073ed3a4b 100644
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
@@ -466,6 +472,44 @@ enum yt921x_app_selector {
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
+#define  YT921X_METER_CTRL_S			3
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
+
+#define YT921X_METERn_STAT_EXCESS(x)	(0x221000 + 8 * (x))
+#define YT921X_METERn_STAT_COMMITTED(x)	(0x221004 + 8 * (x))
+#define  YT921X_METER_STAT_TOKEN_M		GENMASK(30, 15)
+#define  YT921X_METER_STAT_QUEUE_M		GENMASK(14, 0)
+
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
 #define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_EN	BIT(30)
@@ -509,6 +553,16 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_MSTI_NUM		16
 
+#define YT921X_TOKEN_BYTE_C	1	/* 1 token = 2^1 byte */
+#define YT921X_TOKEN_PKT_C	-6	/* 1 token = 2^-6 packets */
+#define YT921X_TOKEN_RATE_C	-15
+/* for VLAN only, not including port meters */
+#define YT921X_METER_NUM	64
+#define YT921X_METER_SLOT_MIN	80
+#define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_METER_BURST_MAX	((1 << 16) - 1)
+#define YT921X_METER_RATE_MAX	((1 << 18) - 1)
+
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
 
@@ -603,8 +657,10 @@ struct yt921x_priv {
 	struct dsa_switch ds;
 
 	const struct yt921x_info *info;
+	unsigned int meter_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
+	u8 cycle_ns;
 
 	/* protect the access to the switch registers */
 	struct mutex reg_lock;
-- 
2.51.0


