Return-Path: <netdev+bounces-32468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B523797B5D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B59D2816EA
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731F13FF5;
	Thu,  7 Sep 2023 18:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B20134DD
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:15:06 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA011710;
	Thu,  7 Sep 2023 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694110495; x=1725646495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0TnSY7Dj57kDvwS7MSema5/mPzlAoA5MTHNSNEab8U8=;
  b=XPOdpMtBCI+ubajZ7i8BuwLCennOttM0P23YAC2PyoKYxpQOdvlMgHlk
   gw7vb9XwTZ+6ISczpAeWM2blISohk3eJaVgeJ5WEF7MmaFFDG67iDEN1I
   3aiRGrJN0oXDTG2MGeO0YNxQdBmwrcMDDeJj4hXFi3zvVXRsdX/1P6wlG
   d0NrHetQqkCwHxO0cV7BkW9QmsT3zR9p8Rm5ieAibONw3C0LbpgP92bW4
   4JKpRJvGYjWE/bQBymOoGMLCqLUd0BWMeD7MQnG/M7l4WFLcT2/ief7mY
   cvo/o6adhCkmXUiUGgvp+tD30BWmKTHrc0aD+/D0Tmah6ujSKCjHneZBP
   A==;
X-CSE-ConnectionGUID: D0ayf4mnRCeKEpW5OwqQLA==
X-CSE-MsgGUID: WcRlAeYdS+aCrUDu6oTEyQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="3553050"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2023 07:04:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 7 Sep 2023 07:04:07 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 7 Sep 2023 07:04:03 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>, <piergiorgio.beruto@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
	<Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net v2] ethtool: plca: fix plca enable data type while parsing the value
Date: Fri, 8 Sep 2023 19:33:46 +0530
Message-ID: <20230908140346.40680-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
value from the attribute, nla_get_u32() is used in the plca_update_sint()
function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
with some garbage value instead of 0 or 1 and always enables plca even
though plca is disabled through ethtool application. This bug has been
fixed by parsing the values based on the attributes type in the policy.

Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 net/ethtool/plca.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index b238a1afe9ae..b1e2e3b5027f 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -21,16 +21,6 @@ struct plca_reply_data {
 #define PLCA_REPDATA(__reply_base) \
 	container_of(__reply_base, struct plca_reply_data, base)
 
-static void plca_update_sint(int *dst, const struct nlattr *attr,
-			     bool *mod)
-{
-	if (!attr)
-		return;
-
-	*dst = nla_get_u32(attr);
-	*mod = true;
-}
-
 // PLCA get configuration message ------------------------------------------- //
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
@@ -38,6 +28,29 @@ const struct nla_policy ethnl_plca_get_cfg_policy[] = {
 		NLA_POLICY_NESTED(ethnl_header_policy),
 };
 
+static void plca_update_sint(int *dst, struct nlattr **tb, u32 attrid,
+			     bool *mod)
+{
+	const struct nlattr *attr = tb[attrid];
+
+	if (!attr ||
+	    WARN_ON_ONCE(attrid >= ARRAY_SIZE(ethnl_plca_set_cfg_policy)))
+		return;
+
+	switch (ethnl_plca_set_cfg_policy[attrid].type) {
+	case NLA_U8:
+		*dst = nla_get_u8(attr);
+		break;
+	case NLA_U32:
+		*dst = nla_get_u32(attr);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	*mod = true;
+}
+
 static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 				     struct ethnl_reply_data *reply_base,
 				     const struct genl_info *info)
@@ -144,13 +157,13 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
-	plca_update_sint(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED], &mod);
-	plca_update_sint(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID], &mod);
-	plca_update_sint(&plca_cfg.node_cnt, tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
-	plca_update_sint(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR], &mod);
-	plca_update_sint(&plca_cfg.burst_cnt, tb[ETHTOOL_A_PLCA_BURST_CNT],
+	plca_update_sint(&plca_cfg.enabled, tb, ETHTOOL_A_PLCA_ENABLED, &mod);
+	plca_update_sint(&plca_cfg.node_id, tb, ETHTOOL_A_PLCA_NODE_ID, &mod);
+	plca_update_sint(&plca_cfg.node_cnt, tb, ETHTOOL_A_PLCA_NODE_CNT, &mod);
+	plca_update_sint(&plca_cfg.to_tmr, tb, ETHTOOL_A_PLCA_TO_TMR, &mod);
+	plca_update_sint(&plca_cfg.burst_cnt, tb, ETHTOOL_A_PLCA_BURST_CNT,
 			 &mod);
-	plca_update_sint(&plca_cfg.burst_tmr, tb[ETHTOOL_A_PLCA_BURST_TMR],
+	plca_update_sint(&plca_cfg.burst_tmr, tb, ETHTOOL_A_PLCA_BURST_TMR,
 			 &mod);
 	if (!mod)
 		return 0;
-- 
2.34.1


