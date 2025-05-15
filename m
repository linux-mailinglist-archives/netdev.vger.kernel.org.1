Return-Path: <netdev+bounces-190669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31755AB83A5
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2353B4E31ED
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8A296D23;
	Thu, 15 May 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfp1CkJH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657AF4ED;
	Thu, 15 May 2025 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304292; cv=fail; b=WGgyBaQJIYIOHv/TAmbHI1TqtzIesTxMV4mwKaQgVuHBDAS5KZA08fiEEbdEArGgDWVw0kAnhtuBzVoh2Vl4usitEg7/wN0RiyA5v5NFUhs3w3LQDNt5LiXMvbYiQTirtObV56MHMUJvWUT2F07hfJ+qO3c6sSYJx7AhDZXAciQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304292; c=relaxed/simple;
	bh=w8tZO9ulhbV/bRjMxkdGl20g0Ts/qxOgtwfbfM+jYPc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=M8ge2mCKLGAwVvjNQl4Abo+kni6U9JhnAacDqe86QQFyWHFb/3iu3AC5G1yzkiVF8kRGtc6km+mxNFL4PEJhDDRSpY3+SFbt5MSPT3zIoM3TRRRwptmV9irlw2rrhIXIA9pdWALRj/ONJj7HrND7fxrmuLeNNagXPzH4pPgqyJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfp1CkJH; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAH2R6/6ee1y2RCGlXAMvAeAKv0Iysm0hHF1XoMzL1eLqgAQ3R5mZQoRYZYkqHFeToLI5DU8EDY4eUPMcpACMnKCbMJRuf75jqsl6o1Xk7LJqiJRU2dIaQM+B9uimRj2ACTcUSeqySegXBZefQ+la4JwmhNyLY1q/RC8WE5DLw6yIomhiBnnnEfEvmnlRxLsP/uxIg7OGUVp4r93WERz1nBfEaHLxKV5kl0Sfqztrn/28O4ZJTso4gy3iSkEzsC5n28oOi44Mmirgs31VG8HrEfIe9rrSjGkApaCJC/iFGr4RIJU9pAoZPlD91ee8EzUK5kt1Bfrkmv8/Gms+xAyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr5EEybolo9GtV+8mkBRGsxDXOZuxzV30ItaL3THyBY=;
 b=vC2zxrUnSd6bj2nlPjz17QWs73OiactNKSsubeosywpOuEMLZvOcjbPz6Dt/eMiDQTOE4wT2yxQrlkW5wf1w2bcEdBnMSZbPJ/rB0YjxMSFFb7lBPwie/eFQOvmTCFjS2LO7Q5FmSHljyTVcdTuWNVSI59x19oBdTuAxUg0OUs6bmgJnOTBeWhedKrrpeeY6id0qHPbuCuawB/fii/Oa2SkPX3rQBLBzVaRL+L8zTaDbNL74eN92V7Sb+NIVptfjjIExZtTVX9aoR+iGnotb+zm8UXURUPRFjMGdXN8TLTi3ToKWBj0FGuaCWKS47tRgFz6YD+mvc+KT+Cd98rzcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr5EEybolo9GtV+8mkBRGsxDXOZuxzV30ItaL3THyBY=;
 b=sfp1CkJHZugoPSwY9ubMk4joH223JqnChMlWH3IrvVuKqTdzXcwwppsXcKSKX3BVaaiKxeeHus7/fGNncXirBjD1+inXfyqaejSN6roCpD2KI1NtrUMnlbRqxkqhMoPiQN0/NXwgHhkKouHRxDNU9+b/jQ8/erYnvoa4paw8qqWWhm2d2nHxOWyThniGSMAPmPh3QVrjGpYBTy89QTq7NdgdPxuXqLTlIvQtSK6j7bnMPFBfoKks7u0bzgds411ag706C6m/u+pbMA6i1f873MvDIsCUSI9obJhXxvLb6YzDp48bc1cLVAN3G49wdZ4khiQkHAFe+0Aq1HQOgz+9xg==
Received: from BN0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:e8::10)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 15 May
 2025 10:18:03 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::fd) by BN0PR04CA0035.outlook.office365.com
 (2603:10b6:408:e8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Thu,
 15 May 2025 10:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 10:18:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 03:17:49 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 03:17:44 -0700
References: <20250514082900.239-1-vulab@iscas.ac.cn>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mlxsw: spectrum: Reset lossiness configuration when
 changing MTU
Date: Thu, 15 May 2025 12:04:36 +0200
In-Reply-To: <20250514082900.239-1-vulab@iscas.ac.cn>
Message-ID: <877c2iuqij.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf512d6-ba3f-4824-7957-08dd9399c71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fg4uczUjd5CDGhFz6h07WEtNAHVcKaoGrIsjAq3LTCu9JwLH2fh21Kaol2Yq?=
 =?us-ascii?Q?qEAXXV2V7Eidjie4lwIv4bw53jioSLFjRgQGB9536ufQ5GPR/k9Jj7oSU3VE?=
 =?us-ascii?Q?DGuAc1isbcblM3+uqTDJ/QNojiDODvR+XetjmtgL04o49Loc4Jm5esI6ZxrD?=
 =?us-ascii?Q?wj2q3wA5L3mH+fshwWW/zQCNO2YOMdXZIAU6eHMRMBqpAx9Ph8rvwE4PFEVq?=
 =?us-ascii?Q?vwV3q2ERKdlrP9Ur7Ws/O+XP93s+3UTDaEmWE8x5GaPgyhGPkMcBBeNGDJ4b?=
 =?us-ascii?Q?nzjyt9ef/vQFSxTe8fUAtWBx10dm/tFixgYBhJ2ySs5LEPl6gtQUDn7P1yFQ?=
 =?us-ascii?Q?gkC+zH0IaRFF4BRuMHW/svua9AKqTpXMz+iR/xtuvZCyXmSW1eY/fu7I1zMc?=
 =?us-ascii?Q?jp5rUqH+N5dbghTWTqbMIwNX0Ce9d0UqVbOzp0suPqkwQEE6yJXv55MKgUaY?=
 =?us-ascii?Q?56RZPWfF29EwpCUCdejcJCKEdaU36dcRfQYkSZqRfRzRSdDXahpAWwzPTWu/?=
 =?us-ascii?Q?X6xAiSTvZXr3SQKsYTkQ4Zf3oI8nzpKkOSxMtnin8vInEC8lhcbBepdUQ3Sd?=
 =?us-ascii?Q?1dna2j4qyNXFmaoMTkxXkauu47F1TrFpAu3eC4zMDnhsFo/f3GxHamZMloc1?=
 =?us-ascii?Q?eW1w2AWSEZTnU9cXDGQ3TyvWDHHXPOaTQPTGHEGuDhcLRfgHnSJjZI5+mPXn?=
 =?us-ascii?Q?6RabSzHoFzZUTYlOJFrPyEh5FdDK5zeyIs5pFQUTThRC8CYbEL/2i21IIlAo?=
 =?us-ascii?Q?EsEY6GL5RPcBj51fo63n+gFrIKv8Pd3GRXQ1yulscIujwLdTBYSV5JtZdZDE?=
 =?us-ascii?Q?qr4t2gnC58sLqtMeC3fbwW3cuy56mbxrCvudEuYecrhJCF6u/CR0xigrLmdI?=
 =?us-ascii?Q?AzNwMDYen7qdix9ifxARdvI+Iax0aA89zhSnE6Bj/JnFGRYQIIR60yZVaQo2?=
 =?us-ascii?Q?GhUUUtvHT2WskkISd3e8chIGx5RcVH3BIlBfVhJFXdJFgF0kjdca2SbPHp1O?=
 =?us-ascii?Q?NBCmDRXBYGgtcpBW3yCw4DvDvbF79tuIWPQhMrXj5ruBnRpBUEH5n3YI4+8G?=
 =?us-ascii?Q?UvqzmpqeBdmrD8cYXTCpYZObqqFwGuACnDokFzXNiywsE+ivs607lwE7KtBb?=
 =?us-ascii?Q?7cQMAFftasQYl8AA176tIa3Urn9LBKqGdrTSy6EtKc7H9OzyhztNJwUS0a+u?=
 =?us-ascii?Q?8D6Ymr3gtyj/vCxhkTEC+czN8/xl9J7b7OdnHNdwxDw+YTufNc2an1E4A24m?=
 =?us-ascii?Q?hOTMWbnyens/o8AWwuMY4LIDBGQ0n4QwD5QXJfZ+j27wU6xNiI9m7eavlYiZ?=
 =?us-ascii?Q?gBTpZkB2qdA1M0jSRF2lZEaygr3C7B7Ura542SioA07oyTRdpTl6NfGXgM5/?=
 =?us-ascii?Q?Drfmahdz8odj3RaLsXTSmBqBMhve4QwUTI1R3I4t+KXzhglMW/BEm661gUvG?=
 =?us-ascii?Q?lgCAZDHjHYyNpBrudVLGl0ZXw45mhBbcu9ELuxH+x04EtREKrnmGKMUU1KRW?=
 =?us-ascii?Q?P0eEKEDKDoJWGgvE2ccFzljNepqSJlGwWGmC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:18:03.4138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf512d6-ba3f-4824-7957-08dd9399c71a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733


Wentao Liang <vulab@iscas.ac.cn> writes:

> The function mlxsw_sp_port_change_mtu() reset the buffer sizes but does
> not reset the lossiness configuration of the buffers. This could lead to
> inconsistent lossiness settings. A proper implementation can be found
> in mlxsw_sp_port_headroom_ets_set().
>
> Add lossiness reset by calling mlxsw_sp_hdroom_bufs_reset_lossiness().

Thanks for the patch.

Can you explain a little bit more about what issues not resetting
lossiness leads to?

mlxsw_sp_hdroom_bufs_reset_lossiness() changes buffer lossiness based on
lossiness of individual priorities, and priority-to-buffer mapping. It
needs to be called when either of these changes, such as in
mlxsw_sp_port_headroom_ets_set(), or when lossiness of a priority
changes, such as in mlxsw_sp_dcbnl_ieee_setpfc().

Since neither changes here, I would think that the call is just a NOP.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> index 3f5e5d99251b..54aa1dca5076 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> @@ -797,6 +797,7 @@ static int mlxsw_sp_port_change_mtu(struct net_device *dev, int mtu)
>  
>  	hdroom = orig_hdroom;
>  	hdroom.mtu = mtu;
> +	mlxsw_sp_hdroom_bufs_reset_lossiness(&hdroom);
>  	mlxsw_sp_hdroom_bufs_reset_sizes(mlxsw_sp_port, &hdroom);
>  
>  	err = mlxsw_sp_hdroom_configure(mlxsw_sp_port, &hdroom);


