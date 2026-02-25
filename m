Return-Path: <netdev+bounces-260814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNVSIq6+nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:19:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273B194C94
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00BDB3130FF8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042233806CF;
	Wed, 25 Feb 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5+2tLPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724F3815CD
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010564; cv=none; b=deVgaUeGjlSv3dx1PLHsONgsqzFXuDavKjb87wrMAXqiiW9p9PJKIyc3LRmD7i3CxlFt/KxarclSn+ifmdc4A5sjCB6ME3Ctr9Vi3AYEBfkmeSvuqipl8K3fcpuFtkGo99O8hwkP/yBMAyMqKcDX60niNsAKV+OMd7VZTibm7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010564; c=relaxed/simple;
	bh=+jCgabcwLfnvM5u/LFE8o8J84WCAB2vzOoMhCVM+q4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWAzRMKLhzCA14OMEMpVzIcMWj2dWpR7ABLkziEzSsqVqpgNn5XUG8+pZiwuPDoR/2ZIr7CtsAsAuE1P0Cz471Xn1Xbk/J8NpgAjoGj+PS3+b6kqSWUd3iF+hItQP5HB/EojIxA4wl3U5oeqEf5V8mBI2IhNF//copE/PyEHGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5+2tLPW; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-824a3509a12so3489966b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772010560; x=1772615360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbgwCmaRljMoOiGjhN128zSFDDQwZTkxtLXLYrgHnPM=;
        b=d5+2tLPWPaTGs+4MLKS9T4xs9u+gN62hZi63SAHsDU4Z4c0bjlQ2uxbv2soqh8DUoH
         fFb58SWAlulqJg+F9YkZLaLj5VcaBXCMOZrkATOc8oWiCZV6wqOxyjH+h4go6rcAn2LC
         htQs/uU2Nm04rBgdplYmOChxDLB18uQjKwYH6Ng2+Z+JRUeQhfqJbeetMOVVgRNVB9M+
         qBEjydq8i/kIEYymw0VJlcdWPbN7tcHTR+PdfcM7sI8QLvX2XWDF1ulqPoTzEizETP+8
         E0jlU/jWJNzSL3zqUUIKjSD9PbjrEgvERa48g5z+9vvM/g/ZjhMHlK693mzyIVIQf9fK
         oK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010560; x=1772615360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GbgwCmaRljMoOiGjhN128zSFDDQwZTkxtLXLYrgHnPM=;
        b=stHpqC/mXFHyk/Bse0Kev+aMrmi53HCb7xI7p9mdPELhJ2D1zipM6pfNeOkKiCgfky
         Mscd8IWai0yVx9SrcRXOdDdp4TiI8hcxVLsYm4TsjAFC6xFD5SNgYVSkQB4qVpbWgXUO
         BXA3MeTIDYNZAascghz5RLWPDe/xgJuY2ss1GAqxliX13YCeqpmLslwIe8ljUKuLgmk4
         +pp6mmzwE4bG8L0seFmGb6VTtHUsxOqiWs1u3ISchXAQUrg7Ou2pxz5tSlol2nmYzGw1
         vJbJRsLrP2rKbPFAxlXXE62Viow1fp9QueUMiJCOSQz7+nzAREp8BiXNps9k4V4MNg2+
         7HCg==
X-Gm-Message-State: AOJu0YwXzzais7gqDxJ5d0YtiaOU8s/rf2rlOALQyfhAgsqmH/oD9U3P
	7gEcFQloJ/Hv6D/LSOPulFmcNG+gqzjTR14mOYH8SP0reZAm65i+GZDI6QxYz8kdXEM=
X-Gm-Gg: ATEYQzyGutMEAs+95KjiEmyUiS/cqVxONF+tnpwrm143OSYLgUzc2rS4mHz3P8v/Ono
	j67M/QPXvlYUcKV40mRruxzUtUb8k7lrvevGmnkvrrc6ldwCoQxVTFhtDhtICYnLq6SwMIGxpOL
	HLuImj6ZpB+c8Hd55phXv8eyEU+7XRxTylBGs9dGMuGVgd3R7K436SNhL9ZaoIZ2YLbkEe50pM5
	eU1g69/P2zswzqPrLDbfsyV49kqjTjQ/UT+bd19dgTvAubZpI83KdJbps0ho/3HdGRtmyWfW98g
	KVzZcevTsm9DPNaHojZ5czXmvc84KH4I///8aHP6nSZpUpEXc32trkA8Wi5AlfIfOkKX/PvYjIk
	ed96IqtWuP+z7OOXjFpizX9MPPJZ/UAmcIIp77gg3wGx6+iPFQgFpUxMe8tfED2LQ9GACQkVUkh
	koTErYW+1LNWKwobsrS8NUUOH/Si7nPQOGyiv65mW0hGMn
X-Received: by 2002:a05:6a00:4f90:b0:81f:3c34:fa83 with SMTP id d2e1a72fcca58-826daaa6eb8mr15374576b3a.57.1772010559620;
        Wed, 25 Feb 2026 01:09:19 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ecb2dsm12883345b3a.60.2026.02.25.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:09:19 -0800 (PST)
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
Subject: [PATCH net-next 2/3] net: dsa: yt921x: Add port police support
Date: Wed, 25 Feb 2026 17:08:46 +0800
Message-ID: <20260225090853.2021140-3-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260814-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0273B194C94
X-Rspamd-Action: no action

Enable rate meter ability and support limiting the rate of incoming
traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 269 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  55 ++++++++
 2 files changed, 323 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index fedc72202d1e..6fa70cea0631 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -353,6 +353,14 @@ yt921x_longreg_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
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
@@ -1046,6 +1054,13 @@ yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
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
@@ -1077,6 +1092,218 @@ static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
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
+	/* Clamp rate and burst */
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
+				 "Consider burst at least %llu to match rate %llu\n",
+				 burst_sug, rate);
+
+		/* Select unit */
+		for (; meter.unit > 0; meter.unit--) {
+			if (rate > (rate_max >> 2) || burst > (burst_max >> 2))
+				break;
+			rate_max >>= 2;
+			burst_max >>= 2;
+		}
+	}
+
+	/* Calculate information rate and bucket size */
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
+		dev_err(dev, "Failed to %s port %d: %i\n", "delete policer on",
+			port, res);
+}
+
+static int
+yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
+			    const struct flow_action_police *policer)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u32 ctrls[YT921X_METER_CTRL_S];
+	struct yt921x_meter meter;
+	bool pkt_mode;
+	u64 burst;
+	u64 rate;
+	u32 ctrl;
+	int res;
+
+	/* mtu defaults to unlimited but we got 2040 here, don't know why */
+	if (policer->exceed.act_id != FLOW_ACTION_DROP ||
+	    policer->notexceed.act_id != FLOW_ACTION_ACCEPT ||
+	    policer->peakrate_bytes_ps || policer->avrate ||
+	    policer->overhead) {
+		dev_err(dev, "Unsupported options specified\n");
+		return -EOPNOTSUPP;
+	}
+
+	pkt_mode = !!policer->rate_pkt_ps;
+	rate = pkt_mode ? policer->rate_pkt_ps : policer->rate_bytes_ps;
+	burst = pkt_mode ? policer->burst_pkt : policer->burst;
+	meter = yt921x_meter_tfm(priv, port, priv->meter_slot_ns, rate, burst,
+				 pkt_mode ? YT921X_METER_PKT_MODE : 0,
+				 YT921X_METER_RATE_MAX, YT921X_METER_BURST_MAX,
+				 YT921X_METER_UNIT_MAX);
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
@@ -3046,6 +3273,7 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 	u32 chipid;
 	u32 major;
 	u32 mode;
+	u32 val;
 	int res;
 
 	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
@@ -3080,12 +3308,27 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
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
 
@@ -3208,6 +3451,23 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
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
@@ -3254,7 +3514,7 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	u32 ctrl;
 	int res;
 
-	ctrl = YT921X_FUNC_MIB;
+	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_METER;
 	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
 	if (res)
 		return res;
@@ -3263,6 +3523,10 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_chip_setup_tc(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_DCB)
 	res = yt921x_chip_setup_qos(priv);
 	if (res)
@@ -3354,6 +3618,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
index 361470582687..b033b942b394 100644
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
@@ -466,6 +472,43 @@ enum yt921x_app_selector {
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
+#define YT921X_METERn_STAT_EXCESS(x)	(0x221000 + 8 * (x))
+#define YT921X_METERn_STAT_COMMITTED(x)	(0x221004 + 8 * (x))
+#define  YT921X_METER_STAT_TOKEN_M		GENMASK(30, 15)
+#define  YT921X_METER_STAT_QUEUE_M		GENMASK(14, 0)
+
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
 #define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_EN	BIT(30)
@@ -509,6 +552,16 @@ enum yt921x_fdb_entry_status {
 
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
 
@@ -603,8 +656,10 @@ struct yt921x_priv {
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


