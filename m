Return-Path: <netdev+bounces-28161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648877E6BA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3247F1C210F1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637A174F5;
	Wed, 16 Aug 2023 16:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A789174D9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:11 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10599E4C
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:10 -0700 (PDT)
Received: from kero.packetmixer.de (p200300fA272a67000bB2d6DCAf57d46e.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0189AFB5CC;
	Wed, 16 Aug 2023 18:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204004; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSto0Q4wf/OxzIwEeyKk+XUSuWvgF3+KU1wJs1NzNX8=;
	b=NLk7/iq/p1qDRzRVDRbQiC1DKcgsM0pJUfhyULTuEvqJhk5C6wtLsjCGhPvwloWIZe1XVm
	tCaTcJaQWe3+MZPPkLB7CbdNB2X5AxAOaUIo2NXewEBguFTqadgEOKlMybhngh6etSJr/8
	jJXzkx0HdvoANE/3lxP08mIJLknYmfmoFOL2ldyUaC2jp52jUAad8gxsi4lxiUkolE/USx
	T8Z9ceMPkFr7G8/L3JTXXxic4vGZe3r9lndl1sMFRxqJSsV5RUNFtGhub8LEvyrv+5ljpX
	woAolHSgI3pH6m63u7ek2iMNI96QC/7jo3rr12Eegg9dmhpYFvIK9TF/xQo4fA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 7/7] batman-adv: Drop per algo GW section class code
Date: Wed, 16 Aug 2023 18:40:00 +0200
Message-Id: <20230816164000.190884-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204004;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSto0Q4wf/OxzIwEeyKk+XUSuWvgF3+KU1wJs1NzNX8=;
	b=ubxi8uqAmNe3b5mW8zkgN3+eMLVlPbHZEEuClfVjdONe/v9rpC9DEmCb8tO432GNTvUWZI
	Ita1j8m9II5orIYbbDg4FpMia+DGgKbFpp+Eulu5zqVVP7zWHyupBCNJ6ISEYJFGm/I2iW
	+gsuBasD4spyHyyOBRCdzxHY1mmf3qAWR5A18qSpK+fHd77zkVbpDB79Nylvlvxjhs/JzC
	dC3/arTgtxQ3YeTg5JBOIWdjez7vzRHhBnU38v0mdNMan3SFwNW92XAMPu1T32aYPTpNxB
	b9xDuc3wqpP8CTx5ALFCzJYSwkIIzz+jnEiM9G+oVF6if+DC4F9xsRVbZU1Dww==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204004; a=rsa-sha256;
	cv=none;
	b=YZdLgFieiM1+6NWVt52dDoRhOtwfFENGJlg9/YaTvtX/EonSnlJiaVsQtM615M1QKOEN9ENPcGzQFgdKL7/IK9mKTSN8dkFFDajv0TNNSQAHOC8sbpQ94DGyGj0cVxThCONUEIVg6HiYBSWGxy83PcKbVSrziGTv+QkY9QU47VLLVMvvGvr9J+VwxRa/xFBYMTI7e+6j2HpQe85Vpbt3aUSYJZIWDsgFMGxmFJse/AsSYQTVf4UG1rkypr2PsAaNRaVlJSUcr/EFWqe2EOX13K62kXqp4DaRycHGez7P6MOkr7rPswagYJ9VG+mxi5X+9P17aOZ2imoVAZDPDeUMwg==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sven Eckelmann <sven@narfation.org>

This code was  only used in the past for the sysfs interface. But since
this was replace with netlink, it was never executed. The function pointer
was only checked to figure out whether the limit 255 (B.A.T.M.A.N. IV) or
2**32-1 (B.A.T.M.A.N. V) should be used as limit.

So instead of keeping the function pointer, just store the limits directly
in struct batadv_algo_gw_ops.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c     |  1 +
 net/batman-adv/bat_v.c          | 23 +---------
 net/batman-adv/gateway_common.c | 74 +--------------------------------
 net/batman-adv/gateway_common.h |  5 ---
 net/batman-adv/netlink.c        |  5 +--
 net/batman-adv/types.h          |  7 ++--
 6 files changed, 8 insertions(+), 107 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 828fb393ee94..74b49c35ddc1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2516,6 +2516,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	},
 	.gw = {
 		.init_sel_class = batadv_iv_init_sel_class,
+		.sel_class_max = BATADV_TQ_MAX_VALUE,
 		.get_best_gw_node = batadv_iv_gw_get_best_gw_node,
 		.is_eligible = batadv_iv_gw_is_eligible,
 		.dump = batadv_iv_gw_dump,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 54e41fc709c3..ac11f1f08db0 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
@@ -34,7 +35,6 @@
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
 #include "gateway_client.h"
-#include "gateway_common.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
@@ -512,25 +512,6 @@ static void batadv_v_init_sel_class(struct batadv_priv *bat_priv)
 	atomic_set(&bat_priv->gw.sel_class, 50);
 }
 
-static ssize_t batadv_v_store_sel_class(struct batadv_priv *bat_priv,
-					char *buff, size_t count)
-{
-	u32 old_class, class;
-
-	if (!batadv_parse_throughput(bat_priv->soft_iface, buff,
-				     "B.A.T.M.A.N. V GW selection class",
-				     &class))
-		return -EINVAL;
-
-	old_class = atomic_read(&bat_priv->gw.sel_class);
-	atomic_set(&bat_priv->gw.sel_class, class);
-
-	if (old_class != class)
-		batadv_gw_reselect(bat_priv);
-
-	return count;
-}
-
 /**
  * batadv_v_gw_throughput_get() - retrieve the GW-bandwidth for a given GW
  * @gw_node: the GW to retrieve the metric for
@@ -818,7 +799,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	},
 	.gw = {
 		.init_sel_class = batadv_v_init_sel_class,
-		.store_sel_class = batadv_v_store_sel_class,
+		.sel_class_max = U32_MAX,
 		.get_best_gw_node = batadv_v_gw_get_best_gw_node,
 		.is_eligible = batadv_v_gw_is_eligible,
 		.dump = batadv_v_gw_dump,
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index d9632607f92b..2dd36ef03c84 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -9,86 +9,14 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
-#include <linux/kstrtox.h>
-#include <linux/limits.h>
-#include <linux/math64.h>
-#include <linux/netdevice.h>
 #include <linux/stddef.h>
-#include <linux/string.h>
+#include <linux/types.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "gateway_client.h"
-#include "log.h"
 #include "tvlv.h"
 
-/**
- * batadv_parse_throughput() - parse supplied string buffer to extract
- *  throughput information
- * @net_dev: the soft interface net device
- * @buff: string buffer to parse
- * @description: text shown when throughput string cannot be parsed
- * @throughput: pointer holding the returned throughput information
- *
- * Return: false on parse error and true otherwise.
- */
-bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
-			     const char *description, u32 *throughput)
-{
-	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
-	u64 lthroughput;
-	char *tmp_ptr;
-	int ret;
-
-	if (strlen(buff) > 4) {
-		tmp_ptr = buff + strlen(buff) - 4;
-
-		if (strncasecmp(tmp_ptr, "mbit", 4) == 0)
-			bw_unit_type = BATADV_BW_UNIT_MBIT;
-
-		if (strncasecmp(tmp_ptr, "kbit", 4) == 0 ||
-		    bw_unit_type == BATADV_BW_UNIT_MBIT)
-			*tmp_ptr = '\0';
-	}
-
-	ret = kstrtou64(buff, 10, &lthroughput);
-	if (ret) {
-		batadv_err(net_dev,
-			   "Invalid throughput speed for %s: %s\n",
-			   description, buff);
-		return false;
-	}
-
-	switch (bw_unit_type) {
-	case BATADV_BW_UNIT_MBIT:
-		/* prevent overflow */
-		if (U64_MAX / 10 < lthroughput) {
-			batadv_err(net_dev,
-				   "Throughput speed for %s too large: %s\n",
-				   description, buff);
-			return false;
-		}
-
-		lthroughput *= 10;
-		break;
-	case BATADV_BW_UNIT_KBIT:
-	default:
-		lthroughput = div_u64(lthroughput, 100);
-		break;
-	}
-
-	if (lthroughput > U32_MAX) {
-		batadv_err(net_dev,
-			   "Throughput speed for %s too large: %s\n",
-			   description, buff);
-		return false;
-	}
-
-	*throughput = lthroughput;
-
-	return true;
-}
-
 /**
  * batadv_gw_tvlv_container_update() - update the gw tvlv container after
  *  gateway setting change
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index cb2e72d7ab14..5d097d6a1dd9 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -9,9 +9,6 @@
 
 #include "main.h"
 
-#include <linux/netdevice.h>
-#include <linux/types.h>
-
 /**
  * enum batadv_bandwidth_units - bandwidth unit types
  */
@@ -30,7 +27,5 @@ enum batadv_bandwidth_units {
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv);
 void batadv_gw_init(struct batadv_priv *bat_priv);
 void batadv_gw_free(struct batadv_priv *bat_priv);
-bool batadv_parse_throughput(struct net_device *net_dev, char *buff,
-			     const char *description, u32 *throughput);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index b6c512ce6704..d37872b34281 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -548,15 +548,12 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		 * algorithm in use implements the GW API
 		 */
 
-		u32 sel_class_max = 0xffffffffu;
+		u32 sel_class_max = bat_priv->algo_ops->gw.sel_class_max;
 		u32 sel_class;
 
 		attr = info->attrs[BATADV_ATTR_GW_SEL_CLASS];
 		sel_class = nla_get_u32(attr);
 
-		if (!bat_priv->algo_ops->gw.store_sel_class)
-			sel_class_max = BATADV_TQ_MAX_VALUE;
-
 		if (sel_class >= 1 && sel_class <= sel_class_max) {
 			atomic_set(&bat_priv->gw.sel_class, sel_class);
 			batadv_gw_reselect(bat_priv);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ca9449ec9836..54c2b8fa48cc 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2191,11 +2191,10 @@ struct batadv_algo_gw_ops {
 	void (*init_sel_class)(struct batadv_priv *bat_priv);
 
 	/**
-	 * @store_sel_class: parse and stores a new GW selection class
-	 *  (optional)
+	 * @sel_class_max: maximum allowed GW selection class
 	 */
-	ssize_t (*store_sel_class)(struct batadv_priv *bat_priv, char *buff,
-				   size_t count);
+	u32 sel_class_max;
+
 	/**
 	 * @get_best_gw_node: select the best GW from the list of available
 	 *  nodes (optional)
-- 
2.39.2


