Return-Path: <netdev+bounces-41109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A37C9CA1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 01:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE501C20A32
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 23:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE191549F;
	Sun, 15 Oct 2023 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CS9FN6Qp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607E15ACD
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:51:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8EC1
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 16:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697413869; x=1728949869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qL/cYv4cctG+wJhKC41Uc/pRaqcu6nKaDJsXKDlAAoQ=;
  b=CS9FN6QpLggWhGT7v9mtk5m0DcnHVjCSrmnVz73vysqZMs6rHZO4QTTc
   EYoVVbez6xihILP5z6ZER3hJjkV5VwfukQoSWjS2AyDfgenNln52OOHxT
   quZ5kK3zLy4j19NfbE12+iMIV4gcumEyP9XOYt+u+4Lpwi7K1QMh8OS+z
   cITfdanee5ogoclWz5qtrDMv/F51fXECQSFVEytOS6zXkDAwGMoQqZUBv
   5k2XMp8M3mYvCqFnMW0yW5xNh5fypUCuksRqqbq+Io+0WYcsXbSkqJ8sC
   JnIGyRCXRaFCl8X2YOXFtHInfGn6YONeL7mhV8wX/4fgGMSkdxUHfY7bD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="370496096"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="370496096"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 16:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929159779"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="929159779"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.144])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2023 16:51:08 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	vladimir.oltean@nxp.com,
	jdamato@fastly.com,
	pawel.chmielewski@intel.com,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	kuba@kernel.org,
	d-tatianin@yandex-team.ru,
	pabeni@redhat.com,
	davem@davemloft.net,
	jiri@resnulli.us,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 2/3] qede: Refactor qede_forced_speed_maps_init()
Date: Sun, 15 Oct 2023 19:43:03 -0400
Message-ID: <20231015234304.2633-3-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231015234304.2633-1-paul.greenwalt@intel.com>
References: <20231015234304.2633-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor qede_forced_speed_maps_init() to use commen implementation
ethtool_forced_speed_maps_init().

The qede driver was compile tested only.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 46 +++++--------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 95820cf1cd6c..b6b849a079ed 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -201,21 +201,6 @@ static const char qede_tests_str_arr[QEDE_ETHTOOL_TEST_MAX][ETH_GSTRING_LEN] = {
 
 /* Forced speed capabilities maps */
 
-struct qede_forced_speed_map {
-	u32		speed;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
-
-	const u32	*cap_arr;
-	u32		arr_size;
-};
-
-#define QEDE_FORCED_SPEED_MAP(value)					\
-{									\
-	.speed		= SPEED_##value,				\
-	.cap_arr	= qede_forced_speed_##value,			\
-	.arr_size	= ARRAY_SIZE(qede_forced_speed_##value),	\
-}
-
 static const u32 qede_forced_speed_1000[] __initconst = {
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
@@ -263,28 +248,21 @@ static const u32 qede_forced_speed_100000[] __initconst = {
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
 };
 
-static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
-	QEDE_FORCED_SPEED_MAP(1000),
-	QEDE_FORCED_SPEED_MAP(10000),
-	QEDE_FORCED_SPEED_MAP(20000),
-	QEDE_FORCED_SPEED_MAP(25000),
-	QEDE_FORCED_SPEED_MAP(40000),
-	QEDE_FORCED_SPEED_MAP(50000),
-	QEDE_FORCED_SPEED_MAP(100000),
+static struct ethtool_forced_speed_map
+qede_forced_speed_maps[] __ro_after_init = {
+	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 1000),
+	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 10000),
+	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 20000),
+	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 25000),
+	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 40000),
+	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 50000),
+	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 100000),
 };
 
 void __init qede_forced_speed_maps_init(void)
 {
-	struct qede_forced_speed_map *map;
-	u32 i;
-
-	for (i = 0; i < ARRAY_SIZE(qede_forced_speed_maps); i++) {
-		map = qede_forced_speed_maps + i;
-
-		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
-		map->cap_arr = NULL;
-		map->arr_size = 0;
-	}
+	ethtool_forced_speed_maps_init(qede_forced_speed_maps,
+				       ARRAY_SIZE(qede_forced_speed_maps));
 }
 
 /* Ethtool callbacks */
@@ -564,8 +542,8 @@ static int qede_set_link_ksettings(struct net_device *dev,
 				   const struct ethtool_link_ksettings *cmd)
 {
 	const struct ethtool_link_settings *base = &cmd->base;
+	const struct ethtool_forced_speed_map *map;
 	struct qede_dev *edev = netdev_priv(dev);
-	const struct qede_forced_speed_map *map;
 	struct qed_link_output current_link;
 	struct qed_link_params params;
 	u32 i;
-- 
2.40.0


