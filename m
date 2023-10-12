Return-Path: <netdev+bounces-40267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DAB7C6752
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2282829A9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F83199B2;
	Thu, 12 Oct 2023 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pEXxw/pv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB7FC16;
	Thu, 12 Oct 2023 08:00:40 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7C2CC;
	Thu, 12 Oct 2023 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697097636; x=1728633636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Llh/lnkSAp58X6xL4PsI82prPrdE86rvb844sXbMTkc=;
  b=pEXxw/pvygXyCn6uJfO5NTi9uSH5uyVPKxhjrntEaVbqCfUgLe5p69TW
   1gm4eMeABoCyEj9x8P9SWfGp9FwGmHE3VMGKTFpMRAnAvHcAMn/dm5poW
   pHOd5pas7wduGiOuNliEosY1RuSoZTT7Qor3WU1VkMS8YT8C15TGJKeZ/
   AklBsu9ueqGisfP+obnRX1qh4Fma7Fn1AlFk8+zR4E1FkGtaTvVozlNhX
   VAFznTFNnt/OfHpC4lt/dqV3nMfy0NLmIIm7lEI1h63gkjm+LycRTb027
   RgjWmhudW8J89SNmXLWZEnhe0WyD0ybpmnQkJev80C6CORIHRsZSOKdS5
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,218,1694728800"; 
   d="scan'208";a="33422564"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2023 10:00:34 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id CD8BE280084;
	Thu, 12 Oct 2023 10:00:33 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: imx-thermal: Add #thermal-sensor-cells property
Date: Thu, 12 Oct 2023 10:00:31 +0200
Message-Id: <20231012080033.2715241-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
References: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This property is defined in thermal-sensor.yaml. Reference this file and
constraint '#thermal-sensor-cells' to 0 for imx-thermal.
Fixes the warning:
arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: tempmon:
 '#thermal-sensor-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
 From schema: Documentation/devicetree/bindings/thermal/imx-thermal.yaml

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index 3aecea77869f0..808d987bd8d1a 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -60,6 +60,9 @@ properties:
   clocks:
     maxItems: 1
 
+  "#thermal-sensor-cells":
+    const: 0
+
 required:
   - compatible
   - interrupts
@@ -67,6 +70,9 @@ required:
   - nvmem-cells
   - nvmem-cell-names
 
+allOf:
+  - $ref: thermal-sensor.yaml#
+
 additionalProperties: false
 
 examples:
@@ -104,5 +110,6 @@ examples:
              nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
              nvmem-cell-names = "calib", "temp_grade";
              clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+             #thermal-sensor-cells = <0>;
         };
     };
-- 
2.34.1


