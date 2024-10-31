Return-Path: <netdev+bounces-140746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E289B7CD6
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBCC1F2207F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A741A08AB;
	Thu, 31 Oct 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdDIYEW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA819F47A
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384918; cv=none; b=ohRNJU/l3G2V++W+GX+JM3gZC1q43fOjyMecWasZpf1SoqZO0pWcesbiYoMYSpCFtzprEV6XmhQuPTA+X4pfTpOk+LnYpoGW6GWV4Q4INbHMR9iLXRNaqczkI9w6zG9NTRqOLP6p4K7ck04fguvBECgrNS7WwEdB9NHolERluW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384918; c=relaxed/simple;
	bh=CaYEF7X5I1GwZVHjJ3svy21SD6o+b4obPuUVTVBlPB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QDk/Xypl/DB3+J1LHqHYlubhUBuUMcgEGG9r/yBwBfboHLCoh1xFeSgiLBP6cCISPnmhmsoc/ra5LUYXsGI+IZAkxnudqTQ8lF+GxEeLsUDCarpxj37w38Is4l8mxJ1SS4M07+fDt7LQwHxbJB0eJVJZXJ8VOzAGZy1wAJFS1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdDIYEW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6A1C4CED3;
	Thu, 31 Oct 2024 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384917;
	bh=CaYEF7X5I1GwZVHjJ3svy21SD6o+b4obPuUVTVBlPB8=;
	h=From:Date:Subject:To:Cc:From;
	b=OdDIYEW5Q9ZFcC3DhB2TkUXh8M7gBaaMmyD6SSXalM5rdbslk3tn5R2NgJUBWCD+x
	 07FV/uL/IsERrmYXog4SEg3HTScus/Gtd3s/eFvQs4R5ug8b5Sc/3hUEN3usXDT3yj
	 6alDSnZxp1hGU7OQ4QtjfDAFFXfW96+pJFwHr9spiUqfkix7A2uwPieNdJI0BniWXZ
	 fWutmBAsH+6tNdN9lRYVDF7YcqdEfLsO74IDh/+Er5DkM8fRXwwTZlwEuETSrNRnPN
	 4dvgaZ9JoCeEP8Q0PUr/eV0GiGRsaVd0o4KK9oTW++3jpDl1jmBawFH1F1jUdPk5Cv
	 q9Q4ZrBpwkBug==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 31 Oct 2024 15:28:18 +0100
Subject: [PATCH net-next v2] net: dsa: mt7530: Add TBF qdisc offload
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-mt7530-tc-offload-v2-1-cb242ad954a0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAGUI2cC/32NQQrDIBBFrxJmXctolNCueo+ShcSZRJrGoiItw
 bvX5gBdfd6H//4OiaKnBNduh0jFJx+2BurUwbTYbSbhXWNQqLTEHsUzD6ZFnkRgXoN1Ag0p1Fp
 Lgwht94rE/n0472Pjxacc4ue4KPLX/rMVKaTggYjZcu8udHtQ3Gg9hzjDWGv9AiyW6Y2zAAAA
X-Change-ID: 20241030-mt7530-tc-offload-05e204441500
To: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce port_setup_tc callback in mt7530 dsa driver in order to enable
dsa ports rate shaping via hw Token Bucket Filter (TBF) for hw switched
traffic.

Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- remove device id limitation and allow tbf qdisc configuration on each mt7530
  compliant devices
- rename MT7530_ERLCR_P in MT753X_ERLCR_P and MT7530_GERLCR in
  MT753X_GERLCR
- Link to v1: https://lore.kernel.org/r/20241030-mt7530-tc-offload-v1-1-f7eeffaf3d9e@kernel.org
---
 drivers/net/dsa/mt7530.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mt7530.h | 12 ++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d84ee1b419a614dda5f440e6571cff5f4f27bf21..086b8b3d5b40f776815967492914bd46a04b6886 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -21,6 +21,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <net/dsa.h>
+#include <net/pkt_cls.h>
 
 #include "mt7530.h"
 
@@ -3146,6 +3147,53 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 	mt7530_rmw(priv, MT753X_MFC, MT7530_CPU_EN | MT7530_CPU_PORT_MASK, val);
 }
 
+static int mt753x_tc_setup_qdisc_tbf(struct dsa_switch *ds, int port,
+				     struct tc_tbf_qopt_offload *qopt)
+{
+	struct tc_tbf_qopt_offload_replace_params *p = &qopt->replace_params;
+	struct mt7530_priv *priv = ds->priv;
+	u32 rate = 0;
+
+	switch (qopt->command) {
+	case TC_TBF_REPLACE:
+		rate = div_u64(p->rate.rate_bytes_ps, 1000) << 3; /* kbps */
+		fallthrough;
+	case TC_TBF_DESTROY: {
+		u32 val, tick;
+
+		mt7530_rmw(priv, MT753X_GERLCR, EGR_BC_MASK,
+			   EGR_BC_CRC_IPG_PREAMBLE);
+
+		/* if rate is greater than 10Mbps tick is 1/32 ms,
+		 * 1ms otherwise
+		 */
+		tick = rate > 10000 ? 2 : 7;
+		val = FIELD_PREP(ERLCR_CIR_MASK, (rate >> 5)) |
+		      FIELD_PREP(ERLCR_EN_MASK, !!rate) |
+		      FIELD_PREP(ERLCR_EXP_MASK, tick) |
+		      ERLCR_TBF_MODE_MASK |
+		      FIELD_PREP(ERLCR_MANT_MASK, 0xf);
+		mt7530_write(priv, MT753X_ERLCR_P(port), val);
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int mt753x_setup_tc(struct dsa_switch *ds, int port,
+			   enum tc_setup_type type, void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_TBF:
+		return mt753x_tc_setup_qdisc_tbf(ds, port, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int mt7988_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
@@ -3193,6 +3241,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_mac_eee		= mt753x_get_mac_eee,
 	.set_mac_eee		= mt753x_set_mac_eee,
 	.conduit_state_change	= mt753x_conduit_state_change,
+	.port_setup_tc		= mt753x_setup_tc,
 };
 EXPORT_SYMBOL_GPL(mt7530_switch_ops);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 6ad33a9f6b1dff3a423baa668a8a2ca158f72b91..448200689f492dcb73ef056d7284090c1c662e67 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -248,6 +248,18 @@ enum mt7530_vlan_egress_attr {
 #define  AGE_UNIT_MAX			0xfff
 #define  AGE_UNIT(x)			(AGE_UNIT_MASK & (x))
 
+#define MT753X_ERLCR_P(x)		(0x1040 + ((x) * 0x100))
+#define  ERLCR_CIR_MASK			GENMASK(31, 16)
+#define  ERLCR_EN_MASK			BIT(15)
+#define  ERLCR_EXP_MASK			GENMASK(11, 8)
+#define  ERLCR_TBF_MODE_MASK		BIT(7)
+#define  ERLCR_MANT_MASK		GENMASK(6, 0)
+
+#define MT753X_GERLCR			0x10e0
+#define  EGR_BC_MASK			GENMASK(7, 0)
+#define  EGR_BC_CRC			0x4	/* crc */
+#define  EGR_BC_CRC_IPG_PREAMBLE	0x18	/* crc + ipg + preamble */
+
 /* Register for port STP state control */
 #define MT7530_SSP_P(x)			(0x2000 + ((x) * 0x100))
 #define  FID_PST(fid, state)		(((state) & 0x3) << ((fid) * 2))

---
base-commit: 157a4881225bd0af5444aab9510e7b6da28f2469
change-id: 20241030-mt7530-tc-offload-05e204441500

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


