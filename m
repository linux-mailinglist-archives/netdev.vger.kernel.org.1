Return-Path: <netdev+bounces-218709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C7B3E002
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12603A5F92
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BC130BB82;
	Mon,  1 Sep 2025 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LcIB+A29"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C963043DA;
	Mon,  1 Sep 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722124; cv=fail; b=ZhYNIDP95WcI31F/OspfTjtW82mELLpMcPCba1Pf0lekqrjh1CgcC/3wDfrwq7Nxt1gu28VocWX1iaAZKZVndeBpm6paSOAkZMIIFYCR1linCPYTDG8mo/Goiav+jcomIwN24XI6uV+bX1rduZHYNwkoiwXufGEp3H2m3E7/miA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722124; c=relaxed/simple;
	bh=mqQjfobeuXX/Bhgc7V3/u1hmYoEG8p+UsyXBJLMMY28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IAA8V+E/0WUxPoGIIA9xCsVmC9Ce0AB7OaZ3wFTTDBfs3webGuunBZ/lX+S4gQqtkcG8f7b5eU0mdTtdJj03ZnNVPOJaRTASsizoo2eRc1vLFy2jvy0LAszEcYsyADKanHYMC+NiMceDfhrIrhN8gI+KMmYs7E3vyfbkbvvodu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LcIB+A29; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H94c/oQn4Rja3BnsxtjXYeSK1fL+sWmlOl9XiSinpoDQuVBqqeApuWh7p+z3mia25Elll1viKWi6zBmXU0F0S0rGd2MK2OwRnBzgJojUo7STvIs6Qll3JyJQMKtURVcAxnt1PVUK+F7GNwSlfTiMIpp84OX7ZEZvR/Wmd7rQAb7YqntFoNiSor11aIfsu9qisb266XdzLRiKDBzuka0MiEupYPcZM8A0cvcyK8qv6dm6vx8Djo3mViJVMQBzdEx8A1sLHi6aOMuvBlSx+PbP5IJQ7da+y3To4+G9/sHd3w2RIRIf91VjQcvuQ/er6cYRi80ZOyclpGeXZ26tOQIGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLe9ZsONmq7nkvZAo2vne4rRYP8jgYgJJmL38zGaDnY=;
 b=RwNoN+jRN/eaB9hkHmd5f/0WILzonj2fwjkRxKUt+SRH9lQbHEFcXJzbtAJdtBkB7kyJEmZFQt6yJlAxAk/qJaTOhkuPWlwCxWSKARiUFFaoDT3SklRc2RH3/xho/3gf+982bpT8j/SsVD4cdmp1kLVCndzv5D6DvPN854B+xQE/3w+S5yrx/EFbxqeCFEOd6LVfm6fzWbEBDxc3VTlNB+7P+/vMurYFmLJIJl3K0oK7YVQhTBS0hpgW5R2TgtFwGHepJS0V1BAUhD1yO7FwteVHdD3YPH7LNXgwV5gEQjsny9gzgvyJHJddiSSUZWUw8CE6/6siMcpH7j+HmS3LRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLe9ZsONmq7nkvZAo2vne4rRYP8jgYgJJmL38zGaDnY=;
 b=LcIB+A29QIs+pZiJ9f1qjZQF0UmTYcw5r9AqDlzOKH0p3ebhRP8OdbOBVdg2VU8El1kUhqPLlaKSYc/2BrbNFfmeAhjzWZc4G16zAfatRmr13dsM5V03tAo8LXG/BhQibnX/fRatb6u9+yiZOu2GRXFkarpzcgUXA7hO2d5U8YtvSCSoAP4DwPaBDl1SO2zaldAq7IJqv5fsb0JJhI2Z+gpO+d/nisAx4LQvqS9BJ9ya2hsSxZumYGJ3kt02w1ZdkRSGtFwxDJNwHLC9IsW+YYGg+yDt9NK8F70DpgRnWmG7bHLOHnJ6KF2Eji/iW0gdS9k62V2iQEgEF07jw+yAiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 10:21:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 10:21:59 +0000
Date: Mon, 1 Sep 2025 13:21:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Miaoqian Lin <linmq006@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Pasternak <vadimp@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core_env: Fix stack info leak in
 mlxsw_env_linecard_modules_power_mode_apply
Message-ID: <aLVzvAJCjwpWPMU8@shredder>
References: <20250830081123.31033-1-linmq006@gmail.com>
 <aLQps4-Fq21R7N4c@shredder>
 <87plcav86o.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plcav86o.fsf@nvidia.com>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: acb781df-c539-4d06-9334-08dde9416261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8hSMvGn8qcWALTw1F+qkQdozOHtDq+Tbqb8B+S485mjXDToqsxgyIBfiI/o/?=
 =?us-ascii?Q?J8kazIENJ+8kNjIr64gLSkHRPVp354DRvjEVbOUTiDtY84Z+a80GH5SZOlyb?=
 =?us-ascii?Q?4NpDsCqmX0ZC5IQtYEDLUX3K0HTL3KeNMJ8s2kdnXx4aDsYvfHhxpQHheilM?=
 =?us-ascii?Q?ap3f6i0BxggGfjBQojIoJqkBCQ1LBOF36I0unR36H6jts5yuvv8k/BuMgrSc?=
 =?us-ascii?Q?ZN6bVVCvyDq/BJcKPTdLMugtYRDfDm2og4ApvWoHavQmmvxEfHst2emO4AXW?=
 =?us-ascii?Q?O5ShMf7xA6biIZ3DsPg7OGlBYpWszgtFo2bDH1jU3A3bJIeLFjwFaK/BJBsf?=
 =?us-ascii?Q?2aYABAq9CvVBD+1FPxc1jYdYNDMNaeYLiojpYtGLtmlIIWXSuWUVwjsXHY9U?=
 =?us-ascii?Q?lgrvbfaWcQHFBdvDHTtBqj3I/63lDPHjEozmCs/VDtNHRBbpDeBIUAOBrU+Q?=
 =?us-ascii?Q?zhQbJ/2bCdDvG9lPhyh/mku7WCAcdTFHr8RDwnwxSFEC86QF6YXdirZtoAfd?=
 =?us-ascii?Q?07j+R8XOuLbBVDirVbRiWNGSMy5vztlq14331mZv4QzMsM5GGcRaZBKVZF2/?=
 =?us-ascii?Q?xQHgD6semQ4kIl+5tDnVczFFF2C1FC/MS7AXxR3UErVGNGhk+V/FLA/eKkCU?=
 =?us-ascii?Q?48q/lguvfKGerhpIYFI3xreDOChbEID8tDYN8pHvqjcSAHLpd/ybrVxVE2hC?=
 =?us-ascii?Q?FbayOrEAubv3gqK/bmT3bJBfs7y1L2fz66J2cwPmq6H39aZMhLLZbhYATWNN?=
 =?us-ascii?Q?OezeFHgNGcC5P3oRXBiwVA/ROtMxnMTqVNczWC3+WWKWmVY6moud4DoDyAjH?=
 =?us-ascii?Q?D7vrhLUFRDjTSZCwx65XWq1LBLqZjw/WTuawF7npedGdWXTUY2YeLyVzlVqq?=
 =?us-ascii?Q?2gi3h4OJzXFBc8Xhe6DSz+X18pTE6qzrHFI6xRgZZeuHOx9cBZKMtUrkyN9+?=
 =?us-ascii?Q?ShSpZwGqiZMFlt0/KcrI07PX/VdPhVOcYswl1SVfO0KjKGMasrTktTbDOu+D?=
 =?us-ascii?Q?3Gs5IAoRX9KJCbMQoujbE6WjE2wJ4qo8c3Nj9YVjolCmFgq1Td2QVaSw9Qt0?=
 =?us-ascii?Q?U4NmIEzKNI1pGTGznCP5LXfruro6SQar304g8PWnTPns8Ssy1Q6LeUuPvJPg?=
 =?us-ascii?Q?pwsulwSCcpIQOtQTaiV6PMeLzRQCdtXA8OZBijfiPCJrSxlSZpmw0z3q6j09?=
 =?us-ascii?Q?ag06heVe9LBWAUVz07xVC1kwXTI3O2gEwhPX3/zTxGoeEwfkyYT//jGibSOU?=
 =?us-ascii?Q?W6HFpH/3DWPkWRm+bihuuhmgriQ6JUtoUwbaTymDhkHoWHh4I4Fv1pzpdE64?=
 =?us-ascii?Q?3FSJ5WRNbPPgBGVmkS9JCL3ZFCwTcMSySuSNtKl7Svzc0g1EvYh5a4MfvuO0?=
 =?us-ascii?Q?lScDtnxE9vCOt7vnnVcYsW+8d6i+WJRgeubnUBhv+BTo+NW8xebdlUZNfbWO?=
 =?us-ascii?Q?CABIGoYNgpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6qsOHp9NbPDCpIkilaUTpXpssQxbTObB2H/mD7H6vAcjrXYo47ZM/HCvNdbG?=
 =?us-ascii?Q?sNQBKUww0t65RqcF5lgwALtCoCaLoW8IMlH8XQaHwsvRsW/EG1VO9B1TEe7k?=
 =?us-ascii?Q?eXThJm7Fb9crqRS08qlc9ZS810X3W4SkMEokQkTS1/XCGCZKon5GTZ/TmVXP?=
 =?us-ascii?Q?IwBx5VRtyx5VyBV01u3cM+s9ARTaOw3TnEHDgIjiixl1rKsN3TcbzBhS+YUu?=
 =?us-ascii?Q?7cVb/GJhKdCy0yj4OhUIy4QCnsIjj2nnEDblHG1QPNXUKPGBoVaMsjX5CBay?=
 =?us-ascii?Q?/gHofGBMK4eCFrULCvhmddG2lOwNRIpxXq1LLFj18PRFrYO5JZitFKCeXdAi?=
 =?us-ascii?Q?upiQhpuEbD4A1fiQ7hHMIICAiMkh+9iX3p+fUiE93No3+McuvFUboeATH5fy?=
 =?us-ascii?Q?po17w2qAFt3r0YCMYjralMxQYwDrqtWfMMqtsIPhVY+LzA9LO8yXNf7r+vjn?=
 =?us-ascii?Q?AnX4arGDlg9Teo4TDFNJfVRZrhGYNANdSTTzBF8eyeNVS4Xerx8OlK5YT3k6?=
 =?us-ascii?Q?CbVRy+nJF40D/XF8hETkt+iLj2lhb0vzRGPjicn7xX8jO9tRpoc6zKx6cRzN?=
 =?us-ascii?Q?rr4jNTgyybTKrrYxXfkPLg4E1HKhJFKC6pXMiZ+fAjngG5LktyiTyBrWwQ8R?=
 =?us-ascii?Q?zq7HX6pixVoWDEhWkhc7t+Fiwm8pbnlN2D3d+yDEvvrxVeAcKJjoG5cXxoEc?=
 =?us-ascii?Q?OVupIHE0UnCiSetHtO+pPH0CFcH1YGcw53kok/dhsI1tIRyzz5aF22VTLP9p?=
 =?us-ascii?Q?ts1qIh3r1fANJSiVxTRyDihz+seUQLcpWBk5tcUm1OzH9IHO/s5DCfDynYYm?=
 =?us-ascii?Q?RS0YbclfYRFoO36lsqSnFiUMjER2YwdX+FvydyNyS6rWGVVbC90Lp7I+1hjl?=
 =?us-ascii?Q?xkKwahY49lvJbM0U7JRmWxqEFK0YsxJPDYzXkDob3/a4Er0AlYJV4P8yrdvR?=
 =?us-ascii?Q?1DsUqiMokvK6jHjSs/0tjlWwQLhz2crw/hMkLSZmrI2qQzdd/Qv1NegBgNtd?=
 =?us-ascii?Q?OpJSxOy+EEtk7VQnskehp9YiSUt1Du1+qHv7knk+yftIdB/DRw+JxrqPvBKF?=
 =?us-ascii?Q?diz/BpxkdCfxlW5nkkvdhvS389X7WkDllsu8YHtTiXatWkXJJw8wRlysVr3f?=
 =?us-ascii?Q?3AEIaZEy5FJL4D3VvpOLF/zZGaCOG2+oCczH7jsJ+oqn8RzFU+5cqVlNA03h?=
 =?us-ascii?Q?EAFTD8nZ4x2TQHJh1ed0BompRDQueuQvX6sm7ITWmJvJYVbIsuK2+7o5/Za0?=
 =?us-ascii?Q?IQ78JJLn7K6O61mRfRRUkafADmooLq7rxrHbGKCqoajCfDiwX6c8bG5xU6MU?=
 =?us-ascii?Q?t5FLkD0rRxcLEKBxTYX8c5+WG4KzTvJclHNLoGUhU8h1SobBsYBwMUQlwaHa?=
 =?us-ascii?Q?yqSqzUYVTaJayTCAu5FIDvB0UwDqfAFs0GZ3+iW2t9E4rgcvzLU1XFFosRB4?=
 =?us-ascii?Q?DKRh/w9MM5gmiBntN+VTAma4rKWRJmMFD4+cDNiQ6DoHovd3l76At5ipIxXr?=
 =?us-ascii?Q?IKUfBpb7q5VjQvo0uAdbCseaFI0zV7XNf9gCRB9FnOmZ0Sy4oqGRaxLMsU0q?=
 =?us-ascii?Q?ggqe4fVnOIAEfLji/fGJNCELviP9/MBxv5xAG/tB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb781df-c539-4d06-9334-08dde9416261
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:21:59.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8INHzn/waRftdKtqBtTVmIboEGeqXoZJS+ZxhK5bQV4Fh5fm3m2JiVp4/plYcAwuF1S3UDK+hkxfRCk/o+ETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

On Mon, Sep 01, 2025 at 11:10:19AM +0200, Petr Machata wrote:
> 
> Ido Schimmel <idosch@nvidia.com> writes:
> 
> > On Sat, Aug 30, 2025 at 04:11:22PM +0800, Miaoqian Lin wrote:
> >> The extack was declared on the stack without initialization.
> >> If mlxsw_env_set_module_power_mode_apply() fails to set extack,
> >> accessing extack._msg could leak information.
> >
> > Unless I'm missing something, I don't see a case where
> > mlxsw_env_set_module_power_mode_apply() returns an error without setting
> > extack. IOW, I don't see how this info leak can happen with existing
> > code.
> 
> Yeah, I agree it all looks initialized.
> 
> The patch still makes sense to me, it will make the code less prone to
> footguns in the future. The expectation with extack is that it's
> optional, though functions that take the argument typically also take
> care to set it (or propagate further). But here it is mandatory to
> initialize it, or else things break. With the patch we'd get a
> "(null)\n" instead of garbage. Not great, but better.

Can be solved with this diff:

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 294e758f1067..8908520f39d9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -1332,7 +1332,7 @@ mlxsw_env_linecard_modules_power_mode_apply(struct mlxsw_core *mlxsw_core,
 	for (i = 0; i < env->line_cards[slot_index]->module_count; i++) {
 		enum ethtool_module_power_mode_policy policy;
 		struct mlxsw_env_module_info *module_info;
-		struct netlink_ext_ack extack;
+		struct netlink_ext_ack extack = {};
 		int err;
 
 		module_info = &env->line_cards[slot_index]->module_info[i];
@@ -1340,7 +1340,7 @@ mlxsw_env_linecard_modules_power_mode_apply(struct mlxsw_core *mlxsw_core,
 		err = mlxsw_env_set_module_power_mode_apply(mlxsw_core,
 							    slot_index, i,
 							    policy, &extack);
-		if (err)
+		if (err && extack._msg)
 			dev_err(env->bus_info->dev, "%s\n", extack._msg);
 	}
 }

