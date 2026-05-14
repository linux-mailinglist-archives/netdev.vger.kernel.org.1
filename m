Return-Path: <netdev+bounces-287852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JHRKEaABWrjXgIAu9opvQ
	(envelope-from <netdev+bounces-287852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B153EFC2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 532ED301E5B3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94E3D890B;
	Thu, 14 May 2026 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CV+uY0GX"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A33C141A;
	Thu, 14 May 2026 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745379; cv=fail; b=IAxIN1ivAIlmFwfx+v7TAW1OMaijsWVnfsdbig7SG9fwjE7l1LK8iu26e7wIXTXW9Dbn/ENsvGVDV+lrhzl0qQvEiToXC15ZJeqLPeML+aCGu3n5aQNkSF/nyGJlVWT5l/tPZ1W2fT6vUWq3LsZVhoxXkHQxNdmPFY+hfigCLjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745379; c=relaxed/simple;
	bh=zYX3BGEBnmsSbYBj9vyWGX0Ub80Nkn7AmY/tGbDDPe0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGC1rLI1AW1XTdVv98ISn/TkKh/Yk9okRNLAkK1jb19Ex6W4DsMF+AlV8hUsfCepSYsgmUcgw3eGUT2+fOW66I2dkasmX55tvHxG61yxvfDX65HiWQgMh/Tb/737q814le7fsYq+8Vt53pWSu80SMucsthe+2RVtbwNuhZBQbOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CV+uY0GX; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgkz3KrijgjeydWHdBl8xFpVZ3y79bo6dBPB/4njmIvPsMvFlg7gQsDS8qpOd+6C1SKVaiacaWz3VvRCLf7b1N+ZTvL8RI6JwF9wSU8SAfY8ssHrHmZjqksRaET7Suq/3iv34fKAsh2VYB1zQNf8uVlb/pZwC7UuQF6sUx4n6RgWySHZmOuKCPDBG6+dd5znk8xwJm2aaVVCqn6dDMnHD+5OwjpE5Uz0WqXOX9lzeCDVGgQCu4EenIQlFYaCOYvsEEYeqmwdpaM5yoSJChIxRKp6MpWlmM1q0NiWygWIzb3OUHK98oXD59H02icvywDyxIV2fyo/qEGPW8NuujS6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Krl89dt8qzKrexr8K9CxsQo6Z/Gi0nQcpDBaZk0Jw7g=;
 b=muwtBEJVjoJi0+iBWjN86xvRa1hvZGwOxNtzDdkxcd1+Sffj8ug+/Cd6wsKGDNP4vbRvk6yfmWHu/+Fv7oYG0BzPhcV7dynqPeAb1QocY44V/9k8IyLk/BkUDhkzlWz0N0lSCbRFjlXSe5BqJOxgSGqYf5XfsPdMooldVr9jhS+INXbNOR4sOxZqJQImRLn7x2jTqIbhjJWydcWkdM0t+8M0TNEWvJll6n3rNk8UePqLQ4n+bZQjnm7r/eK2HaXSCVoWJs0VkxEm8V4htAGzuKcfSAqqhtMJmfkMTCZdhIKV1HQW739rprvb1M2W+RG3ofTLh8eaqsb1Z6xuJzIieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Krl89dt8qzKrexr8K9CxsQo6Z/Gi0nQcpDBaZk0Jw7g=;
 b=CV+uY0GXPkn5Pk5PyEjTajF4oQm6pXAkPx98LLzIAAiEDAg//UB/j7Mv2zwIst0TQc0WCU0f+IU6SUyOQCFIKv4A0j3K5oGGZdWynasn1RuMDjOcU/ndysXanb3ojmSwrrOD3gIz/fei+g39usjCe1XvkOg2lmHNi6Vgc0IpZ8A=
Received: from CH0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:610:b3::27)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 07:56:15 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::b1) by CH0PR03CA0052.outlook.office365.com
 (2603:10b6:610:b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 07:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 07:56:13 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 02:56:09 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 02:56:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 02:56:09 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64E7u94k1661183;
	Thu, 14 May 2026 02:56:09 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64E7u8h2005237;
	Thu, 14 May 2026 02:56:09 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
	<jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v2 0/2] Add ICSSG firmware stats related to HSR
Date: Thu, 14 May 2026 13:26:03 +0530
Message-ID: <20260514075605.850674-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SJ2PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9d83f9-41ac-481e-161b-08deb18e44ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DQjQQ/2J/OWZZkOezKcKeVZIw0mCCfYQTFMc15k22FbqRv/XaJHYhM1bDkZVhjo6syPJFaJSF2FYBybRQimZfldunsAK15cE0KW+gs3jRU7M/DDuMOG5ClJqBXJkM+SXJGp1T/XYnCWu2JWi7nJ7Ym7ijJmW4gOPC4++xp8OYSqAIje70JfRjn/IhaZkDVPiCAlbh9Ed7DVIcwNQTXCU13ZapkRpbSnMbqFh5QI2yRn5nw4ZUGYawe9jAWEnjHUycGbjDsN9M7VaX3r+KNxOGFxyyPRClb0GItTx6Rs/a8vEiwiKPLMspdSLYRJqokIVGcSqAwR1rB+qh6wz8J1S/yol69nKNFTzuidDuW6aW1ITTCEn+Ys3m9KnqfEh3UJ+SS5l09TB+adn/tbQYCMbf/TMGp14D9WUewO80bWJEn/iws1dQWG2SUHSJKByAIeirw5Ge3F+M+H55v7dgMSz/WrJjAUlY/fteMyV8fwBjpQFOZInqoYRMyw7+Lj8QZhB9QWAcf6y4tRuyAKCflQKf80BrgDMVwXCQxA2Ysc3LQG4rFMvnRe5QFHNe+1AyGoX79L3tMWUJKweuLNbTRR4BBkH2ry+Za1qT2WjRjubIC+HvGdxqu7rGCo1knIuWOozIYNfYL3O2QpFjETsyYoB2ynuqeAQADa+fOF43awN8r/ICmZ9zPVGkXj/pU+NVP4covEbIIYt34tX7AD0XCiHxJX2hhCQ28E0zDX4Se8KZEV4vs/1toh8WjcJr18cNHQh9fttPzjR9J/ONisMq21HApmX2SCIamHhBZ8lXl5GwX0=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vI3OHkv2C3K94i2mp/6lO9PExf/JGuUWG9NZAR8u/V+AEdrGs23xru7Zfyd+x1gIeubGnHLQvdoxN6EWbx1FYaEZz5cLzdmYusuHvinnLo49A/HyHGe7spx0QL0i7U2oanCWJ7EiSCeDcGBbwxJpJhenhNNy4hQNkbN9m9pDfDVms3GGPZBQaomoxcarIAhHbZOMGcrldWLyz07dgBhFRA5g0FzFMuWHrSg09pzjH+0lybpReAG1GBrqS8v6TsFSZg0rJe4mEXe8O0b7GDU/rHhwoH1ClhZ45pJmskKacLBfwJPMimbVMZkDIYzG4lX0fN6BnKNDY813VAclpSKLXx7E2JLRAUcVKDOA5q1ZTUGZd/mpl1zORx92BPmL14coVgXAiKn3XbT/rcAqyZ6HQpEfDtzlimpFphHFptQt3Cj5RNDBtR+EZHEUbY7OBodU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:56:13.2025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9d83f9-41ac-481e-161b-08deb18e44ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Rspamd-Queue-Id: 349B153EFC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287852-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

This series adds HSR and LRE firmware PA statistics to the TI ICSSG
ethtool stats interface, and places static_assert() guards next to the
stat descriptor arrays to catch count mismatches at build time.

Patch 1 adds static_assert() immediately after each of
icssg_all_miig_stats[] and icssg_all_pa_stats[] in icssg_stats.h,
verifying that ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS stay in
sync with the actual array sizes.

Patch 2 adds ten new firmware counters for HSR forwarding-path drops,
host-egress-path drops, and LRE duplicate-detection, updates
icssg_ndo_get_stats64() to fold the relevant counters into rx_errors
and rx_dropped, bumps ICSSG_NUM_PA_STATS to 42 (caught immediately by
the static_assert from patch 1 if the constant is ever left behind),
and documents all new entries in icssg_prueth.rst.

Changes in v2:
 - Drop the ARRAY_SIZE()-based macro approach from v1 (which caused
   binary bloat by pulling the static const arrays into every TU via
   icssg_prueth.h) as suggested by David Carlier <devnexen@gmail.com>
 - Add static_assert() next to each array in icssg_stats.h instead,
   keeping the numeric #defines and the original include graph. As
   suggested by David Carlier <devnexen@gmail.com>

v1 https://lore.kernel.org/all/20260512060627.3781329-1-danishanwar@ti.com/

MD Danish Anwar (2):
  net: ti: icssg: Add static_assert to guard stat array counts
  net: ti: icssg: Add HSR and LRE PA statistics

 .../device_drivers/ethernet/ti/icssg_prueth.rst    | 10 ++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  7 +++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h        | 14 ++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h   | 10 ++++++++++
 5 files changed, 40 insertions(+), 3 deletions(-)


base-commit: 18dc8e6d15d7a30888beec46a1e01ca0f98508fa
-- 
2.34.1


