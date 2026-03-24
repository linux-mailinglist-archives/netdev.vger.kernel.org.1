Return-Path: <netdev+bounces-271018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIZoBAmCwmlneQQAu9opvQ
	(envelope-from <netdev+bounces-271018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:22:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E43081E2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15D83158A03
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3FD3E6381;
	Tue, 24 Mar 2026 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K6YL35+r"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0F1E515;
	Tue, 24 Mar 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354628; cv=fail; b=jT/rSGXbmNJ4YYXD9zZnzp2FnNlmnFXjUajtXQAEEPjpJKMC2uttRGqLuTAnYt60DjfCb2xYKoQF6pCsmCESjGpsHInb/2xL0Y68rwLQFY4KMWQn0DibY9nrpRS9D7/j0mm1HllYvOOEebTrD5dqkWjmg+A8J/1eUe236fvy49s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354628; c=relaxed/simple;
	bh=jxtWR9f6hdyefQRpienZe4QFjdbDB5ibC/agtuQNTdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwPka7eiQejSc906VERc8FZoSh1+xN7wfpvDHZEkhRkFweaisi4EJH3yc0FuBWAjMhTo8dtziSsr1Bzntqszl/gDAcF8Vou/sVf/nlRB3263q4MBm50ornvJvh4osHHoNj8uvp2Nlavj79/9DfQrRXCVJWA4KTJIk/Yew+QWb74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K6YL35+r; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVDy72dIAzJbt17HHjPbhHA21yS6uXjBI4Rle+pu0Rcyz0Ma8bCpn/Cbab0aZCyMllzpx6PILafLWsjPo5OJiRsKic2ZIrBAdX0V84jRY2LNesEpvddm0ebJ+RL1cRRatvgBeQe5zNObxXKHGvRJqiYGasZBYRg3z2qcIN8eT142iWHkRBFegrS3nE0L4U6lRY0sBzdQKwCIC9WRpljYxAydN9WitD3q69DcqHS3OJMpLtqKCwauKT85tGPEMyuPVOotL8TE4M6/P2S1HQi6CDOvN3YdWHEjJWgXQwxTImq/D98Z4/VCfm7nUR8dYqk2NDljx7Ks5j6cMqFNMLZ6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B09szyn05ZWGYHNvjkuoz42mz22RJA6Eswt3D6WuHMo=;
 b=pZp8rdJIFj8rgQqpyiQ91tGxxuDh0vlKAwCSWEI9CvZ58etRHOCpvdhIU8CdaMNzoZId4PHl5e28pckmTQJxNhybBz1EchWFmLwC7QGsumCsmGst+qz4bTgnqhMUGntcPun9KvQ3oTMs1CeFI76l0qwO92WAXmQCUFt/h7rhk/P+eP0S1EtpJAshqsGYFBDmopu3J2Ch62ZEoi78SM5K0x4sR4dXPIUgWbZnB8JVmunpw+whAXHC32AG2DNjP8xLDryJEHEfjHtGIU+r5qQKkZ95tUzE/MlPi7b5Bs0UlvM0BY2zvhrm78AsVQKmbKA3kuN9gwIiR3hd5txa5gAjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B09szyn05ZWGYHNvjkuoz42mz22RJA6Eswt3D6WuHMo=;
 b=K6YL35+rj5CHfnlhirphDOWEHuotThRanQwahaW7Rc2uOaXbnvC3TYXQmF3cbT3beOXPEOioTa++zBV8+rL0VdNg2Jv18fga3/CXp1wlwqZIvdeExeePJmREJMe9+pk7yR/4Xs5dfHjY9X6PH8YdybRYQ4jHd1MNE4QrfeAyN2elV3MNrhQNBRW1QkzYZp388OAHZSGOAkKjLKr2PDf3PM5/vexLLgVoajWPY40yKMnfTqGO0RVgIsRI3vxQbNAUQTumQmBobel+mV32O5TT5fnpICeZX/oIn+KJjmVwXhS870hOyTAI+aydcPosRaqNhqe+fv224DPXDQMo8zGnbw==
Received: from CH0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:610:11a::26)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:17:01 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::79) by CH0PR03CA0347.outlook.office365.com
 (2603:10b6:610:11a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:17:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:16:44 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 05:16:41 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
Date: Tue, 24 Mar 2026 12:16:30 +0000
Message-ID: <20260324121631.771628-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324121631.771628-1-jonathanh@nvidia.com>
References: <20260324121631.771628-1-jonathanh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 726ac189-3a23-4f0b-4c62-08de899f4063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O+DEjqSGzkH2HlxJ2QVdPIx+MXDp48vVzD3KAtkzH5Gpf8PrANBEOOkYXrZz5BMIn0/R069DOgMK7Eteqgayv55gpR8SwTsFgJh3OnfpYGVolhqi1wDAD77+W3J5N7Eli26t5hDInWZ6cYvm14hiiW+i6Lc21Xy08T7BtNBvs8keTWNMD9t7GcYS5hSaCEXy3hmO4ohSjk65XrPaGe/qW5SJ7YupC56CJo7kyqMpKQf2561MHkHgC+M4CEt/SxgZxWm4i95d0OXFkEq7uHfUA5JPPoNiuRBXxGWFH/eTdJjqT7D9XDwO1DlKIiDsRvoNvV9u+qyQ6gUuNgMooAmkEjCOHmoUeVjRse0vbG3NudsR2E5fcLytQzXX0hToUtu2HRaZHDto9M/XxpK+KIgSkhyfeDMx9FeFjaSUwvr0GwS6x+1RwdHFZ4C/S+FulHInV9ybUbZOfnbOlpcJ51hnkve8o4dYn85inxp2zsIAcjhQTwFy4arTguSyNtKrEwNoBj/ml/4ykBVtovqzkK4bBiG6WEJsJK/ayJa+Tz5rQrhZp7MFFY/X6ep/6uhBCMidxmjIdHQ4cBxQmFe3X92t520fZmB5xe+016xcxlGYfBs3R2sCYTePcocavOYtwsyd6MM1GPK3uWb4cdZNKX9MmdC47xyldDLB766trEarKnyXrponiRTREiH+yLdftYaKcKeHLSdPJult3tY1EE1XcsMDn20fY9uVn+Y8E8Rf834tYFhoAvVWvsAlCl53O0M4beDmr8CauKjyH47R99TCIg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8d1ZEmZVZJfai0jZdZjD/ypdiID8C8H7601GegbKDqsYldDz4lEFHc3EqD3k8P7AwWaePWsXuHHeEigHDmarQCme5yWlsEfHNm1z0L3K8VfEHZ4Tk8EiHnOxccUc6RkHwCXbHqE/5Dcjf68tJ4AvtfGKZA8+Q9A4pEGMUtsDCwz7HdoFFvLHaGK/mOlXx1XZwCPogJIZV7GEMBVjPjiG0O9btU3vLAeT3rNKXDTNFcRsNaELzjysNdC2oAe/HAmAD26k9RoFPWpPySBlx5CTMTa0DJ+NCOhPeNOWxam2mPFaCGvUH5Ao4b7cnazGvFntduSYNr1d6pQb1xkeQdkGiJuoDdtqfcylyeK+dK54/KgbIEaFceUbXkJUP3xl1V3zWUBFBzv738gV/rmi2PgUMk+JmzV1IPrUAZGIu29iKWFlMJa1j6R59uAUGW6WDvXU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:17:00.4811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726ac189-3a23-4f0b-4c62-08de899f4063
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
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
	TAGGED_FROM(0.00)[bounces-271018-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AC8E43081E2
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
 Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
index 2bd3efff2485..e77043d3143a 100644
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
-- 
2.43.0


