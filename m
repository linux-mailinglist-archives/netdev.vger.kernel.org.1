Return-Path: <netdev+bounces-195965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6035AD2EA0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AAA1715AB
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA327FD50;
	Tue, 10 Jun 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4BfnQUd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0027FB35
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540396; cv=fail; b=fuMJE5enIL2CqNenzeg+F//triahQuwreC9BQpT2H9xDNuiGCVoLcPqv7bVpNiHmn/M4qlb2Cb+qMm35wRetXE2K6gPf/sAssLP8OdbclJYfmmkpwBgVKaEXP4RzDMPqA/OFd6j+lcT7JFzB/qfgleHMolZvXDu9PwSdwvZUTCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540396; c=relaxed/simple;
	bh=gwGfdFflQ8QsXPS5I95i/FSHxK+WXGajxpgZuGYjNYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P33rh05YZQ8PcmOdtaPnNjUEZttmQ0AZSg/VLVHRhnBvq7JCQraovyAmUd7SnNFHWTiyxWTdZq7tjfWDa9jU0IGe90MSK9qkkF6xughjBSUiOpcoYMw6zAE6oCw4PfujeIjHBtwkcjcUL6Z7QZFzr+Rhji8m7lcdv/LRNKGJqYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b4BfnQUd; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVK7xKJWErNm+q5vX/UZyMFjKD919Bgj5wtk+ozJ6+ZBG9ouFp5Tb9yBsbOJyVLNZyWSBO4p+AV2HlOjvL4P4vc7wn40qwU6ztwE+56U8sKd++SOt0Zhdrhvs0apu76sbfV7dqQTwcoqaG4qXQ4Mc8Na6jf3xRbIuzQ/ltZijje++XBZ8muW1rd/5h2zw3hVMhU5grtL5oGn9ygOBZDpaZ+qB1t8RTqWanAhSNtIP+sYAeMHHSMEI4dCsBqPcuOQ2mlYBzRUPuvS/juS9zrBhlwKP7WNDqy+iPaxcSx3807PhbQC3kfPkHo2cdZYHTj2mTHysmrVl+/1BoMeMALGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHjRdmoPEyg/wtA95/hydZBqJaIyNyE60NBYd75u/20=;
 b=EF95o794yIQasKmUjBdogTOD4ql3H1oQ3mAlemXPcn4VGLXbt+WGZvn5KoeHIdULL8hDD45gJqRoef3DWmN3b1YDvHWgMBSnMGUUe38iEaaEa/eUjfX4XpbTExiqPR4tts1NUVlhc/sI8pbybZAqOMlHE4aI6e51jdMCWhIYH4NZd5uXTvIb50IRDZ3FHQHV46SZ/LbNo7b7d+z1J0xnzMSRjt3HXI+YLlnP3o+pOfPql81ZIcFE0NRkPhHqiaqyRbqdOZi95I5jbhlFZzdF5K2/Uuy5TlFCA2DUDmVdPDBrUP8aLUcAFYX3r2Ejrj12uxwlAD8toULLBMQz+akNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHjRdmoPEyg/wtA95/hydZBqJaIyNyE60NBYd75u/20=;
 b=b4BfnQUdFnbac+WXkZo/7KerIKSs1jLDHpv+pSbonttwn3YKv6gIkkmQli7uKJQs6HkMxhF9f+IVe7yzu5YMI1rvO8JHMd7QmA0Oine/c1Tv+AGBecmJyvDMj234T1jX1FUyI5OgKuNXjZm9OUEhrFW1f6vOcoTMlsCtPLmxMH7cJMW/8siCACEW/EgOcl/7OmnG+RQSxiP1IuN9rBDnftHNemXrSv9CqX/ObomRfaApYqOvMEH1178+WhW3NkPVhru9apMlDntRv+aQVGBI5P/lTPf3PugbTLuVGxdDNZvCMrLALnsCtf7ewQKcoZu6KUKWQ5tVEE3u+Z4v6q8DlQ==
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 10 Jun
 2025 07:26:31 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::c4) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 10 Jun 2025 07:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 07:26:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 00:26:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 10 Jun 2025 00:26:13 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 00:26:10 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Alex Lazar <alazar@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/2] net: vlan: Use IS_ENABLED() helper for CONFIG_VLAN_8021Q guard
Date: Tue, 10 Jun 2025 10:26:11 +0300
Message-ID: <20250610072611.1647593-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250610072611.1647593-1-gal@nvidia.com>
References: <20250610072611.1647593-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e64b73d-1f32-4c97-1cb7-08dda7f01ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk1zYVQzV0tjbThuT1Y5K21yNXdvY29YY2dOVmtXL3BtR20xNjMyZGU4WHF3?=
 =?utf-8?B?YTk5N2FZZVVtRGpVbERRdmJwcFRnZ3FjOXdRQkdRdVk0Q0JUa1hmOGpuL2N0?=
 =?utf-8?B?OVdFMFJLcnlaNk1JK1prM1gzMVlHVnRTL09IVjcvOEFFaXROWGFNOUFBMlRl?=
 =?utf-8?B?VzhsOVltLzRibjdIQjgyY0tjaDY0MXVkazVucERmWjM0RkEvTlFQTUs3K0s4?=
 =?utf-8?B?N2VuV0FtL0JQUkdsS1J3dDF6ekRBc09PdnJVNzJSVzEwbGgzeXhxVTFmSDJr?=
 =?utf-8?B?TjZaS2xPYlZDVytkbTVwNHBYYmlQUHZxYkhYY1FuOEJFR2NoUHU5RTR4Q3ZH?=
 =?utf-8?B?ZGsxL1RVTWpoOWxxRnQ4bytBdzdUTWF5OTI5ejc2b0NxaTBGVnhjTytWMDJD?=
 =?utf-8?B?VjlKRHZsc2dXRzlvdkVRRDA3N01ieTkzeFllQy9TRHJsYTRDTW1OZ29ZK21V?=
 =?utf-8?B?QlptTGtkNVQrT3ZNVk5xQmFnb1ZueXdoZ3NONHlhR0RrVUxTbnlVQk9UbnRE?=
 =?utf-8?B?VG10UExhZjJGUGZrS1RpV0N0U2F1cEwxL1NaQnQ5Ry9iaDRGd3RBYkZsbnpD?=
 =?utf-8?B?L0VVSTNIUXlsbXU5T0c4bWJZM2YvT0lqNmhqKzJFbGM4VFRqZXBWUnlGeExD?=
 =?utf-8?B?OEx3Q0Zxd1pJS3RBMk5yNDBZdGR1a1J6VGg4bkNacUNveTFjR3p4bmJpMVdX?=
 =?utf-8?B?cUtndGU1dlVpOW5GRG55R1hTTFFnY0k0UFZNbUtuVHl1RzJWcDhjSld1enpO?=
 =?utf-8?B?djZTb2RXMTE1VVppUW80NTVwdExpeElqWVllOWlpaEFMUzJhODdFZzYwaHpj?=
 =?utf-8?B?c2tDekxJQ0UwdG5nSzZWMmhZMVBVazNsOVNLTUwxUE0wNE5wQWwyd3Vla0k0?=
 =?utf-8?B?VHlyY1crakJsMWpEK1A3bk5Mam5lY0UydlZ6SlVtWm03YW1lc2g4VnQ2YXgw?=
 =?utf-8?B?VExnbG9vWDlQbEh6ZUtBMzZnSC9nWDNoNTJ5UUdBWkVGY3EvQ00vaTkzYWh1?=
 =?utf-8?B?bGlJMFJzWnB3eXMwaEE0ZENJbHV3NnVYcFhtTVhrOFJoajFWVVg3RXg3Z09F?=
 =?utf-8?B?L2JVTjVVQmMxWElzQkFraVY1WnY1VVpmeW8wTktJOGpwejI3akVEVlRsOURQ?=
 =?utf-8?B?bEZHSU9mNjErczVRNzlUTHd0ZXBWOFJDUlNpMTVwa3p6anByUUJQN3lMdUY4?=
 =?utf-8?B?U3ptNFY5TkQ1N0F6TlZaaTlwMkl6WDhwcWI2ZE1Zd0VheFpkcDVQdUtRUTVi?=
 =?utf-8?B?WndDSDVIZ3BNWTl6MlVzQldyNHlESFJ1dElZSzY3a1JIaGVGSXN4WXhSbTRG?=
 =?utf-8?B?T3hTZkFKSkxQU1lhUW1NRDRVeEFDa1JLaTAyV25tSElORTNtZVVnQXhsNFor?=
 =?utf-8?B?MFNkWVBUNnFLaGZiOFZIZHpoMUwzMVF6SXo0T3crSjEvVmtuOEQ5VFFQa0NR?=
 =?utf-8?B?bWlKeUczd0E3bFNmcmxTNEEyTTM2Uk1qbHF1U2RoSW5UY3hkUHVaQTBwa3A3?=
 =?utf-8?B?aWc1NGVBRElkRWlBSEQ0RlAyVVJhdG1WbktVVkhmRnhSbXZQclArRmNkT1Bp?=
 =?utf-8?B?akl0ZnIxMnExVW5FdUszMlhEQm95V05QNjBDeE1PRzdvWHBqRjNmbnBEV2VP?=
 =?utf-8?B?dFZldTZ1eCtZRHhUMmVDZ0RiQXZKbURXT1NBTDJJeDhUWHQ3ZjlOTU5nbXRI?=
 =?utf-8?B?YjFEVk0zWlNlK2xHUGVYRmUyeXk2OWNwcGc3YlN1STRjN3cvNWNVRHp6eTY1?=
 =?utf-8?B?eENvTEk0empvWGhJRkpiTUpxSTFKVXNVTVpOV3JjaXZHZzUranBtcWJKNk5B?=
 =?utf-8?B?dXZjck9Lbkh1UVYrQjdEUlJaQzRnWVRYMVlIYStsV3hVaWw0akp2UFRkYWE5?=
 =?utf-8?B?bEh6Unh5RDF6TGpYRm5NNGVBam4vNm9NNWp3MUhYSENVYXBEWVVCQ3JtUmdm?=
 =?utf-8?B?aW5VUlNiZjRUOTBsZ2xBRGgxQThueXgySS9uQWpPZGN6Vk4wNXpUeHlwVUZ6?=
 =?utf-8?B?OS9QOFNRLzJvUGFkYjJhREJTR2FaQmxtM0xrQ0Y3blZmNWZlTmVVUlduZlZD?=
 =?utf-8?Q?sUBgeY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:26:30.8960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e64b73d-1f32-4c97-1cb7-08dda7f01ef6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087

The header currently tests the VLAN core with an explicit pair of 'if
defined' checks:
    #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)

Instead, use IS_ENABLED() which is the kernel way to test whether an
option is configured as builtin/module.

This is purely cosmetic – no functional changes.

Reviewed-by: Alex Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/linux/if_vlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 9135cbe6ae92..981fa37be0bf 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -136,7 +136,7 @@ struct vlan_pcpu_stats {
 	u32			tx_dropped;
 };
 
-#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
 
 extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
 					       __be16 vlan_proto, u16 vlan_id);
-- 
2.40.1


