Return-Path: <netdev+bounces-271576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEOwAv3tw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:15:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A337A32694F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E613306F783
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8213DC4CD;
	Wed, 25 Mar 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uu1Cd1s9"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEB346E7D;
	Wed, 25 Mar 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447140; cv=fail; b=gyE8ndyGSGHj2revTFcRv4RN5WrlFlyhOVTwO5BD3FpXRVo+OoMQLDa7XMqxWPeYw97Hw0tHp9No/BedJk94KkYqPhNhNoCQcxxAw7nQaQBpOnAos8t75hv2+Qu3dq73oRjnVxI4Etf672IaaBESJCYxhyADMXQDsf+q/MHkt8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447140; c=relaxed/simple;
	bh=GGUTifTHK1H/IfrrEommyf0SvqW2eXvnbPgI/xV2GvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSeNCr0GIopyIh4j5zHZJ/9NMI4SHm0NKBXH1galtvipCP8jsrxOTmExpaOsXV21qt5WdDqDXrmHcKcUZjFHRj3yHWS+/DVlQ3KP8+32t0C9UKV8Hd84pHAU0czEsUL1lfAZepepqRXmqWdwdt6DaT24Q0XfTCJOvtoMO6176O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uu1Cd1s9; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD52TkYPPpdpZLYaL7FWxM0ToXvywK6kFdVIa0GoLyWi2qU+Nj0WfOVJpEIm/ROWiXKhWBfLP67Y0DKRdLwpe6CuYObly/AeAGsbm5K9XyfoIERxu+5YCVmdzN5tXTd7e5F6OofXdBlbzdSqI1+4lF6Y0TuKcQtpxZhCmiImSpstJda27qcHl1pWA8Rwcz5EMm7kQy01tPn63b3kUeFwVgE5tV89azqbbgIHPPb0BIC1sD5yi+hjqyVax5Xg/T7sjdSldIuiC7bvOJD1gfHqTZ4Jft4IR8fEUiujjNE56+ypcpZWx1mMVU9tVF3ZbNpWgm3yux8HchjHblzqppG0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S/tVCrffPbZhOhd+Yn60k7MtGHjmxK7JA8gM0e9LdM=;
 b=JgdUbp5VPMhKy6AG+C0P443OI+eZ8WUeDE3xw0PEtbxgzJEJwZnniGl/6sLyZB6IbnvXNJi4KEM+H5c4ancbICNcybMRwTpRsl4nV8wVGTUvSn2AOoVQzRAw34bb7/SHWBeOlLULH2yNwdJwN7JnB9KHx9Mc+JGJ80Wu1YgVCTDzG6L2WbCAi3BuF2NhTuFjnWR5va9YRYZKJwjsg+HMhF37wIe+Dj4VKv1n8W4IqUhjjT7YJIKrsi/6+qORqJZPO3NnBUQt15I65J+93TTuSVzLBMtlIAVrBDm0rnAdKYFnMERDFGFFmuq7EFBHwOgCDjh8ik+09wBAQoeTe7i0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S/tVCrffPbZhOhd+Yn60k7MtGHjmxK7JA8gM0e9LdM=;
 b=Uu1Cd1s9kWieyUEXqVWTx1cfv/+crbExS1qnuiC8nkTDmW0mapQA8cfrTu6GWvRd3dJUfNi5EbFApUpOES2zdJVnAWdKNoPVpNt5ouiNvyXGEfelQvscIXkurza/s7Ls1tsEv71f6lnjAoOJorJy6c0sCNoy7tPw9tzAxEtjZKC6BYPvTpjUk7GnG1bUcoTR+Z9SJNXVnKqIFCjLVyW4v6D8tNbOQzld5Vt0hS2SzP/ZMTE2mmv1jLLmzqWZ4TqKc8jd1mNnOaMq6AVwrzeoG5whnD8LlVd5Y1iPWYqjHL6wgvsI+q/Wl0Nvr/AtWXwzRONUR7zV2//qf4lwsPi1+g==
Received: from SA1PR02CA0017.namprd02.prod.outlook.com (2603:10b6:806:2cf::23)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:58:54 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::44) by SA1PR02CA0017.outlook.office365.com
 (2603:10b6:806:2cf::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 13:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 13:58:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 06:58:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Mar 2026 06:58:40 -0700
Received: from moonraker.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 06:58:37 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
Date: Wed, 25 Mar 2026 13:58:10 +0000
Message-ID: <20260325135811.148480-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325135811.148480-1-jonathanh@nvidia.com>
References: <20260325135811.148480-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: 002d67d1-3a1f-42ca-16ee-08de8a76a66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8xeRrq2xmibG78dOegg/WpV8+Tg7jlYFK0c6vTtH7AfTx739+Qa5qWPj3tEsz1EvBslxRCWWDPjewBqekxeAS/zTrOiRvPtAfr2zFjQYagIIZGMIIBVBny8h0aNGdgTO5Ai0tTvBxL3BXZ0vR5owmo8b71uc03AyBYIVy2f+axvyeI0148xNaKVIAZNtNkAb4EN40lN+xYJqgCgulDzVBZcPfvLNW/OSqMkPJVmXUyPWPq0di0YP83LwHA+7qjUSSZ6uj1+WG9SXvT+V+gfs7Anw3Tq43YVErc53ry5SxUTkuCU627RETQif2PTshGqCt8uYEKfkNuHT8eHr09KKM/2KA8Vj02WMaRjFq0kFDL+r73q7zUjyivScRK9DO47xGQk1/MGkPd3/0/PgeGjWxgXkbX4YcVXnLS7rl29lwvmKnXD/e4/w3rJZvXyf0ej+/T8l9GABbLl+UempvTHeO4P2tuL+gL/9RLi9qGrMoE1MlsgVK8dbPHvKA55iVFfrHTP+jUTCZczmemIXQH7tPFWxFcerglemrCJ2iA1Lt8LGIEoVVzwgSsim1IRndw9dbHTxNGVh44HDDrFwHpxnwzzSuOIr8YvO4vUL1yFjZiuxySXem1AhoXo9qI4EsNCMH7aiQZHLd3F5b9K3VXWxvGs3LsAG6QNuow60pDgI3VNONbdOFGAx5nUS4EfkLmW0LqWH+2LZI8ohdYMDnPK7rq8IYdXQa2UUVtcX8VFyGBVixSxscLqVhcFUBosz09pIV1w214HG3LPGRBL9L/tq6g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CeRRzaziU9tAsQgEXwsJ8HLQKGluJz8HF0483ZLM3An5aKPkr1wN2CDBL8fQxTX9urj3+HqDm0Iac8+s/LmbWPCUOkj8uNfka6W2YfD7qE1kgY0wMC1u4G/GtkI9S3iIbmZZgySCTdYstUwht8VsoZKp0Q7dW+iKPF80DMu2R40CUwVNp79UcgOtCmSMhePORMQYtXMa7X2fA8ttWWcT+3nyYaI227e9Zd98F/kJzAZcANW4r6ZgCiiyoqveeKUuv42UhHrxSQTvzRaSPQ3V+HAnX8Y/ulxG3daj6Q3QVBuTq51jHEwA542LTymsULnvV6UFTjw4HK8GSuD/QsytYnRbHi+uX/Wz00U7FD6aEF67zA07BV3tkimLRk5GTK+hzh1u9ahTjHAuBw3+SLOMpKQW8/MwZhlKFAQIngNAzX1HMwyKi5W2nEVAowVngeEX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:58:53.4335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002d67d1-3a1f-42ca-16ee-08de8a76a66d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271576-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A337A32694F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PTP clock for the Tegra234 MGBE device is incorrectly named
'ptp-ref' and should be 'ptp_ref'. This is causing the following
warning to be observed on Tegra234 platforms that use this device:

 ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
 WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed

Although this constitutes an ABI breakage in the binding for this
device, PTP support has clearly never worked and so fix this now
so we can correct the device-tree for this device. Note that the
MGBE driver still supports the legacy 'ptp-ref' clock name and so
older/existing device-trees will still work, but given that this
is not the correct name, there is no point to advertise this in the
binding.

Fixes: 189c2e5c7669 ("dt-bindings: net: Add Tegra234 MGBE")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../devicetree/bindings/net/nvidia,tegra234-mgbe.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
index 2bd3efff2485..215f14d1897d 100644
--- a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
+++ b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
@@ -42,7 +42,7 @@ properties:
       - const: mgbe
       - const: mac
       - const: mac-divider
-      - const: ptp-ref
+      - const: ptp_ref
       - const: rx-input-m
       - const: rx-input
       - const: tx
@@ -133,7 +133,7 @@ examples:
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS_M>,
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS>,
                  <&bpmp TEGRA234_CLK_MGBE0_TX_PCS>;
-        clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+        clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
                       "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
                       "rx-pcs", "tx-pcs";
         resets = <&bpmp TEGRA234_RESET_MGBE0_MAC>,
-- 
2.43.0


