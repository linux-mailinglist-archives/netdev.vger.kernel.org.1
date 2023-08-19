Return-Path: <netdev+bounces-29072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ECE7818FB
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB74281C4B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363F6AB1;
	Sat, 19 Aug 2023 10:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA463D0
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:40:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A729D30D5D
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692438471; x=1723974471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ynqb6SitFONfu8Bcdt21Op5zeHmxsOgPEjDDo2AmaMk=;
  b=JwV/+qUWET5CtB3azpNlArHgr9XKAlwtFoxN/c0YQewgIcMAwQiKK3oC
   JO4pyy9cbhdogaZDOY0FnjaPnZAMMUhqKSwZHcu7tsUkzleTW9bGdnabX
   42etOfTxk3Cc2U2xWu8LiQznPxOqvsLHh88kM1eyqz3dxaqUyq8NjBZJa
   XeBNk+vQa4c54cU2gDRkbUCJI17IAnwaxXnQP2/kya+TLDz/blbkAzTyx
   rqqJhLOTgj/6kzRse6MeA8AB2FytvvjO9fMuBd+hpDvunJJClOkxBtE0r
   6Qg7l4qIfTkGC6frRH8BZqrsNHKT9A7vrh7T/0fZzlpwVXQGddHOnkBID
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="353577267"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="353577267"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 02:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728878264"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="728878264"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2023 02:47:50 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 3/9] ethtool: Add missing ETHTOOL_LINK_MODE_ to forced speed map
Date: Sat, 19 Aug 2023 02:40:25 -0700
Message-Id: <20230819094025.15196-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The Ethtool forced speeds to Ethtool supported link modes map is missing
some Ethtool forced speeds and ETHTOOL_LINK_MODE_. Add the all speeds
and mapped link modes to provide a common implementation among drivers.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 include/linux/ethtool.h | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 245fd4a8d85b..519d6ec73d98 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1069,12 +1069,33 @@ struct ethtool_forced_speed_map {
 	.arr_size	= ARRAY_SIZE(ethtool_forced_speed_##value),	\
 }
 
+static const u32 ethtool_forced_speed_10[] __initconst = {
+	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
+	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_100[] __initconst = {
+	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_100baseFX_Half_BIT,
+	ETHTOOL_LINK_MODE_100baseFX_Full_BIT,
+};
+
 static const u32 ethtool_forced_speed_1000[] __initconst = {
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
 	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
 };
 
+static const u32 ethtool_forced_speed_2500[] __initconst = {
+	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_5000[] __initconst = {
+	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+};
+
 static const u32 ethtool_forced_speed_10000[] __initconst = {
 	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
@@ -1084,10 +1105,12 @@ static const u32 ethtool_forced_speed_10000[] __initconst = {
 	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseER_Full_BIT,
 };
 
 static const u32 ethtool_forced_speed_20000[] __initconst = {
 	ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_20000baseMLD2_Full_BIT,
 };
 
 static const u32 ethtool_forced_speed_25000[] __initconst = {
@@ -1107,6 +1130,18 @@ static const u32 ethtool_forced_speed_50000[] __initconst = {
 	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
 	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
 	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseDR_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_56000[] __initconst = {
+	ETHTOOL_LINK_MODE_56000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_56000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT,
 };
 
 static const u32 ethtool_forced_speed_100000[] __initconst = {
@@ -1114,6 +1149,51 @@ static const u32 ethtool_forced_speed_100000[] __initconst = {
 	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
 	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR_ER_FR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseDR_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_200000[] __initconst = {
+	ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseLR2_ER2_FR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseDR2_Full_BIT,
+	ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_400000[] __initconst = {
+	ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseKR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseSR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT,
+	ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT,
+};
+
+static const u32 ethtool_forced_speed_800000[] __initconst = {
+	ETHTOOL_LINK_MODE_800000baseCR8_Full_BIT,
+	ETHTOOL_LINK_MODE_800000baseKR8_Full_BIT,
+	ETHTOOL_LINK_MODE_800000baseDR8_Full_BIT,
+	ETHTOOL_LINK_MODE_800000baseDR8_2_Full_BIT,
+	ETHTOOL_LINK_MODE_800000baseSR8_Full_BIT,
+	ETHTOOL_LINK_MODE_800000baseVR8_Full_BIT,
 };
 
 /**
-- 
2.39.2


