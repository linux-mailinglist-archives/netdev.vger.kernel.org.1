Return-Path: <netdev+bounces-30068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD96785DDA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7954B1C20CF6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F11F166;
	Wed, 23 Aug 2023 16:48:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98CC8E0
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:48:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF1F11F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692809326; x=1724345326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=reVwHBhI6Yvd6rQBqav2fy7Wq/RJB0iRDPyfIwVzA4w=;
  b=nYRyDyK0vS8JsWRubu8zq09NzrUKp2qMtz6k8CW/+2zYc8Vj8bAruyZc
   6EFbbtpsYvI/l/87ArqetR7LHkmYdrOODJRjpFRLwnEA3AMeBJ4hg5y5w
   3SXjSqVukCkCAbssjJNlgfuB0wCWppOKeRCT3sd/tAL04cgBoEw52Bk1V
   4jzyShVN3cNaOCh+ob9ZqjOBKTQRT4nkEOB6+ddqolWuTXmyp15LdU5D8
   ZyISWjHnk964GNlkMG6fXfnvc5s3O0Fm6HBjUSyx6gnEAG41PVtrC9iiF
   zfoS5251+shnpR+9DPabigUe4dDpsw6NqEeDmYXuf2YwuQw4FPHaTt9uV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438141119"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438141119"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802200528"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802200528"
Received: from spiccard-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.44.134])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:48:44 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS hash function
Date: Wed, 23 Aug 2023 10:48:29 -0600
Message-Id: <20230823164831.3284341-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823164831.3284341-1-ahmed.zaki@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
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

Symmetric RSS hash functions are beneficial in applications that monitor
both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
Getting all traffic of the same flow on the same RX queue results in
higher CPU cache efficiency.

Allow ethtool to support symmetric Toeplitz algorithm. A user can set the
RSS function of the netdevice via:
    # ethtool -X eth0 hfunc symmetric_toeplitz

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/ethtool.h | 4 +++-
 net/ethtool/common.c    | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..9a8e1fb7170d 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -60,10 +60,11 @@ enum {
 	ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function - Toeplitz */
 	ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
 	ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32 */
+	ETH_RSS_HASH_SYM_TOP_BIT, /* Configurable RSS hash function - Symmetric Toeplitz */
 
 	/*
 	 * Add your fresh new hash function bits above and remember to update
-	 * rss_hash_func_strings[] in ethtool.c
+	 * rss_hash_func_strings[] in ethtool/common.c
 	 */
 	ETH_RSS_HASH_FUNCS_COUNT
 };
@@ -108,6 +109,7 @@ enum ethtool_supported_ring_param {
 #define __ETH_RSS_HASH(name)	__ETH_RSS_HASH_BIT(ETH_RSS_HASH_##name##_BIT)
 
 #define ETH_RSS_HASH_TOP	__ETH_RSS_HASH(TOP)
+#define ETH_RSS_HASH_SYM_TOP	__ETH_RSS_HASH(SYM_TOP)
 #define ETH_RSS_HASH_XOR	__ETH_RSS_HASH(XOR)
 #define ETH_RSS_HASH_CRC32	__ETH_RSS_HASH(CRC32)
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index f5598c5f50de..a0e0c6b2980e 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -81,6 +81,7 @@ rss_hash_func_strings[ETH_RSS_HASH_FUNCS_COUNT][ETH_GSTRING_LEN] = {
 	[ETH_RSS_HASH_TOP_BIT] =	"toeplitz",
 	[ETH_RSS_HASH_XOR_BIT] =	"xor",
 	[ETH_RSS_HASH_CRC32_BIT] =	"crc32",
+	[ETH_RSS_HASH_SYM_TOP_BIT] =	"symmetric_toeplitz",
 };
 
 const char
-- 
2.39.2


