Return-Path: <netdev+bounces-62695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC282897E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161361F2469B
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D239FE7;
	Tue,  9 Jan 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIiIIieR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0E3987C
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704815754; x=1736351754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j+FfbNldsdXKfmLLTsfbXrR2j6FSXyUY9HQQw8FrL5E=;
  b=UIiIIieR8X5YtrWrUa7MTMIbRm5eugW4kwC9CHzAxadyzik85H5d8dGF
   ARsykt+S7fHhlgcnzYXoxFY0pZlMBH1ec4DJk8Ujn/IqYrGWCzTkjwId/
   2H+sBk8zw3JXaioRzh5X3njSh5AdT/oSPJ/fC+oQJ4lwcd/y7ll+LhzlC
   uToAqneROJHEv4gYoyGfjFkJKGWbDZ0hwRqvTMGCIQ8jiZJLxDkyHFQVl
   TUGCB1VeWq+7iy+uzyetZbwUSELSWgwRh/oK/hmwHxCE59aSmXnni7m2y
   AVZzmzw2BZ6PzJiLrGj6tQrRduTBJGlsq7KMV37eIXbJpk8qt9kyV5gbR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397097141"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="397097141"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 07:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781846219"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="781846219"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2024 07:55:48 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH ethtool-next] ethtool: add support for setting TCP data split
Date: Tue,  9 Jan 2024 16:55:30 +0100
Message-ID: <20240109155530.9661-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for controlling header split (aka TCP data split) feature,
backed by kernel commit 50d73710715d ("ethtool: add SET for
TCP_DATA_SPLIT ringparam"). Command format:

ethtool -G|--set-ring devname tcp-data-split [ auto|on|off ]

"auto" is defined solely by device's driver.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 ethtool.8.in    |  4 ++++
 ethtool.c       |  1 +
 netlink/rings.c | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index ef0c4bcabf37..dc7d4df4fcc1 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -202,6 +202,7 @@ ethtool \- query or control network driver and hardware settings
 .BN rx\-jumbo
 .BN tx
 .BN rx\-buf\-len
+.B3 tcp\-data\-split auto on off
 .BN cqe\-size
 .BN tx\-push
 .BN rx\-push
@@ -629,6 +630,9 @@ Changes the number of ring entries for the Tx ring.
 .BI rx\-buf\-len \ N
 Changes the size of a buffer in the Rx ring.
 .TP
+.BI tcp\-data\-split \ auto|on|off
+Specifies the state of TCP data split.
+.TP
 .BI cqe\-size \ N
 Changes the size of completion queue event.
 .TP
diff --git a/ethtool.c b/ethtool.c
index af51220b63cc..3ac15a7e54f6 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5748,6 +5748,7 @@ static const struct option args[] = {
 			  "		[ rx-jumbo N ]\n"
 			  "		[ tx N ]\n"
 			  "		[ rx-buf-len N ]\n"
+			  "		[ tcp-data-split auto|on|off ]\n"
 			  "		[ cqe-size N ]\n"
 			  "		[ tx-push on|off ]\n"
 			  "		[ rx-push on|off ]\n"
diff --git a/netlink/rings.c b/netlink/rings.c
index 51d28c2ab055..f9eb67a4bc28 100644
--- a/netlink/rings.c
+++ b/netlink/rings.c
@@ -116,6 +116,22 @@ int nl_gring(struct cmd_context *ctx)
 
 /* RINGS_SET */
 
+static const struct lookup_entry_u8 tcp_data_split_values[] = {
+	{
+		.arg		= "auto",
+		.val		= ETHTOOL_TCP_DATA_SPLIT_UNKNOWN,
+	},
+	{
+		.arg		= "off",
+		.val		= ETHTOOL_TCP_DATA_SPLIT_DISABLED,
+	},
+	{
+		.arg		= "on",
+		.val		= ETHTOOL_TCP_DATA_SPLIT_ENABLED,
+	},
+	{}
+};
+
 static const struct param_parser sring_params[] = {
 	{
 		.arg		= "rx",
@@ -153,6 +169,13 @@ static const struct param_parser sring_params[] = {
 		.handler        = nl_parse_direct_u32,
 		.min_argc       = 1,
 	},
+	{
+		.arg		= "tcp-data-split",
+		.type		= ETHTOOL_A_RINGS_TCP_DATA_SPLIT,
+		.handler	= nl_parse_lookup_u8,
+		.handler_data	= tcp_data_split_values,
+		.min_argc	= 1,
+	},
 	{
 		.arg            = "cqe-size",
 		.type           = ETHTOOL_A_RINGS_CQE_SIZE,
-- 
2.43.0


