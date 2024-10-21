Return-Path: <netdev+bounces-137503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DD9A6B60
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711811F22A14
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2DB1FBCB1;
	Mon, 21 Oct 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qb7UkSuK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2B8479;
	Mon, 21 Oct 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519217; cv=none; b=B7PTvPvhRRMl87UGAyJOLU+ryqIDOoQxllRF1XRTBryXr1MhbartCAY4GEcSvfXVaecZaA3wDvPq/5tlAmLNlGjbaOZwmJ/OSaNNkVnd/Q3ET1bBsAXlhYl+9rrMqvgRNcC+e7d6Wavn4xAoDmgoh0LqEldRt5EM5B8Avvu9l/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519217; c=relaxed/simple;
	bh=pYol46mg6UJQJyh2+og/qVGN4XnTuv+gs2R8oiilP8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pqZnP+4nyROlioFlGoELdthqgxL2LSwU7EkErhjbucqxBDSNyxw4s4vIeKqsCnfOFb+FLrDhSrZ0omUM13vEyW2hCsBfRhiBRHruErv9V1QPxKY6zPYb9D3S7OcGOk6/cSughoE8oKYsgapezrWJsSE1NGQwhsROhfF7s1m6Iz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qb7UkSuK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519215; x=1761055215;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pYol46mg6UJQJyh2+og/qVGN4XnTuv+gs2R8oiilP8s=;
  b=qb7UkSuKUWrL6vvmgCBU6zK10Kty/VfQEKTFrtIR86qx+fjrv69cxou7
   tzyMoeRNIGYP5TETtfHuGimducXX+th92KvkJvhLwjDwc2mJoJ67zxLFL
   yLpknEBlAQ92ir7Y0Eg+shLDy5VG9MagEL6Gw7/zGo1wiNakjmghSt042
   pZdmHNmmBqHh/lDeE1I+zm82aKg5D3O55gDrLdTpVzXSEdXuCb2yUB1nQ
   yqtZBA0M6FMh2vSozEIBJnu/u2AyqKILgCmEYBrjRTtdCyaIGDooYfn7I
   Ckl8KA0tB63mtRB9R8tNsXJeFihiq1qw4jHErjhDdEI0UgVgwcdRTEKxj
   Q==;
X-CSE-ConnectionGUID: wjlJ/ymcRaqntxTcHXMHhA==
X-CSE-MsgGUID: rM5Y68L1RCeQ54dZq/WYaQ==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="33285733"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 07:00:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:51 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:48 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:51 +0200
Subject: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add compatible strings for the twelve lan969x SKU's (Stock Keeping Unit)
that we support, and verify that the devicetree target is supported by
the chip target.

Each SKU supports different bandwidths and features (see [1] for
details). We want to be able to run a SKU with a lower bandwidth and/or
feature set, than what is supported by the actual chip. In order to
accomplish this we:

    - add new field sparx5->target_dt that reflects the target from the
      devicetree (compatible string).

    - compare the devicetree target with the actual chip target. If the
      bandwidth and features provided by the devicetree target is
      supported by the chip, we approve - otherwise reject.

    - set the core clock and features based on the devicetree target

[1] https://www.microchip.com/en-us/product/lan9698

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 194 ++++++++++++++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
 3 files changed, 193 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index 3435ca86dd70..8fe302415563 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -19,3 +19,4 @@ sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
+ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/lan969x
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 5c986c373b3e..edbe639d98c5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -24,6 +24,8 @@
 #include <linux/types.h>
 #include <linux/reset.h>
 
+#include "lan969x.h" /* lan969x_desc */
+
 #include "sparx5_main_regs.h"
 #include "sparx5_main.h"
 #include "sparx5_port.h"
@@ -227,6 +229,168 @@ bool is_sparx5(struct sparx5 *sparx5)
 	}
 }
 
+/* Set the devicetree target based on the compatible string */
+static int sparx5_set_target_dt(struct sparx5 *sparx5)
+{
+	struct device_node *node = sparx5->pdev->dev.of_node;
+
+	if (is_sparx5(sparx5))
+		/* For Sparx5 the devicetree target is always the chip target */
+		sparx5->target_dt = sparx5->target_ct;
+	else if (of_device_is_compatible(node, "microchip,lan9691-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9691VAO;
+	else if (of_device_is_compatible(node, "microchip,lan9692-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9692VAO;
+	else if (of_device_is_compatible(node, "microchip,lan9693-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9693VAO;
+	else if (of_device_is_compatible(node, "microchip,lan9694-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9694;
+	else if (of_device_is_compatible(node, "microchip,lan9695-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9694TSN;
+	else if (of_device_is_compatible(node, "microchip,lan9696-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9696;
+	else if (of_device_is_compatible(node, "microchip,lan9697-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9696TSN;
+	else if (of_device_is_compatible(node, "microchip,lan9698-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9698;
+	else if (of_device_is_compatible(node, "microchip,lan9699-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9698TSN;
+	else if (of_device_is_compatible(node, "microchip,lan969a-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9694RED;
+	else if (of_device_is_compatible(node, "microchip,lan969b-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9696RED;
+	else if (of_device_is_compatible(node, "microchip,lan969c-switch"))
+		sparx5->target_dt = SPX5_TARGET_CT_LAN9698RED;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Compare the devicetree target with the chip target.
+ * Make sure the chip target supports the features and bandwidth requested
+ * from the devicetree target.
+ */
+static int sparx5_verify_target(struct sparx5 *sparx5)
+{
+	switch (sparx5->target_dt) {
+	case SPX5_TARGET_CT_7546:
+	case SPX5_TARGET_CT_7549:
+	case SPX5_TARGET_CT_7552:
+	case SPX5_TARGET_CT_7556:
+	case SPX5_TARGET_CT_7558:
+	case SPX5_TARGET_CT_7546TSN:
+	case SPX5_TARGET_CT_7549TSN:
+	case SPX5_TARGET_CT_7552TSN:
+	case SPX5_TARGET_CT_7556TSN:
+	case SPX5_TARGET_CT_7558TSN:
+		return 0;
+	case SPX5_TARGET_CT_LAN9698RED:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9696RED:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9696RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9694RED:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9694RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9698TSN:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9696TSN:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9696TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9694TSN:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9694TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9694RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9693VAO:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9693VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9692VAO:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9692VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9693VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9691VAO:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9691VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9692VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9693VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9694TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9694RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9698:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9698 ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9693VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9696:
+		if (sparx5->target_ct == SPX5_TARGET_CT_LAN9696 ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698 ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9692VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9693VAO ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698RED ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9696TSN ||
+		    sparx5->target_ct == SPX5_TARGET_CT_LAN9698TSN)
+			return 0;
+		break;
+
+	case SPX5_TARGET_CT_LAN9694:
+		return 0;
+
+	default:
+		pr_err("Unknown target: %x", sparx5->target_dt);
+		return -EINVAL;
+	}
+
+	pr_err("Chip target: %x does not support the target: %x",
+	       sparx5->target_ct, sparx5->target_dt);
+
+	return -EINVAL;
+}
+
 static int sparx5_create_targets(struct sparx5 *sparx5)
 {
 	const struct sparx5_main_io_resource *iomap = sparx5->data->iomap;
@@ -441,7 +605,7 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 	 * If 'VTSS_CORE_CLOCK_DEFAULT' then the highest supported
 	 * freq. is used
 	 */
-	switch (sparx5->target_ct) {
+	switch (sparx5->target_dt) {
 	case SPX5_TARGET_CT_7546:
 		if (sparx5->coreclock == SPX5_CORE_CLOCK_DEFAULT)
 			freq = SPX5_CORE_CLOCK_250MHZ;
@@ -491,7 +655,7 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 		break;
 	default:
 		dev_err(sparx5->dev, "Target (%#04x) not supported\n",
-			sparx5->target_ct);
+			sparx5->target_dt);
 		return -ENODEV;
 	}
 
@@ -512,7 +676,7 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 		default:
 			dev_err(sparx5->dev,
 				"%d coreclock not supported on (%#04x)\n",
-				sparx5->coreclock, sparx5->target_ct);
+				sparx5->coreclock, sparx5->target_dt);
 			return -EINVAL;
 		}
 
@@ -914,6 +1078,16 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5->target_ct = (enum spx5_target_chiptype)
 		GCB_CHIP_ID_PART_ID_GET(sparx5->chip_id);
 
+	/* Set the devicetree target based on the compatible string. */
+	err = sparx5_set_target_dt(sparx5);
+	if (err)
+		goto cleanup_config;
+
+	/* Verify that the chip target supports the devicetree target */
+	err = sparx5_verify_target(sparx5);
+	if (err)
+		goto cleanup_config;
+
 	/* Initialize Switchcore and internal RAMs */
 	err = sparx5_init_switchcore(sparx5);
 	if (err) {
@@ -1051,6 +1225,20 @@ static const struct sparx5_match_data sparx5_desc = {
 
 static const struct of_device_id mchp_sparx5_match[] = {
 	{ .compatible = "microchip,sparx5-switch", .data = &sparx5_desc },
+#ifdef CONFIG_LAN969X_SWITCH
+	{ .compatible = "microchip,lan9691-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9692-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9693-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9694-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9695-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9696-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9697-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9698-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan9699-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan969a-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan969b-switch", .data = &lan969x_desc },
+	{ .compatible = "microchip,lan969c-switch", .data = &lan969x_desc },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mchp_sparx5_match);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 1828e2a7d610..8a2b74d0bd35 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -337,6 +337,7 @@ struct sparx5 {
 	struct device *dev;
 	u32 chip_id;
 	enum spx5_target_chiptype target_ct;
+	enum spx5_target_chiptype target_dt; /* target from devicetree */
 	void __iomem *regs[NUM_TARGETS];
 	int port_count;
 	struct mutex lock; /* MAC reg lock */

-- 
2.34.1


