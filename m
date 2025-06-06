Return-Path: <netdev+bounces-195394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACF7ACFFEF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529F63AA554
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC52857E2;
	Fri,  6 Jun 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="Xe4WDA/N"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022081.outbound.protection.outlook.com [52.101.126.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC01E47AD;
	Fri,  6 Jun 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204077; cv=fail; b=XM5OqRASJ0gDmXhOxcYlHJlWD9tRbxnMGlM7Txri43QpS4uReaotojsjiKx69rJo/iaGwIhUKU50VG/Ko7Ugu1DtBV8L9/8fizFP0go9O0zuc//p4P2oTrOZkp/MBB29VRX7hg2eok3g+7AgoovSkgG9wIMvk0bTBCwLyrrieQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204077; c=relaxed/simple;
	bh=lJhdvA2wGEZBekHI5Abk6bnseD6lkzX1ynCr+A66mQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=To8ZNydqZug5KyfLk8z88SjNfhOHIfU8NyN/L6AH0xfBcNc6IlfssKfJw+jmtxelGHm3fUnspSKkcP/a45xVkgy6byRiO8c+fZVTSdsfChw+MMogDAZ7Nnnj22rgfOIyoS+7/j6A33xLH7gsgBsSKjZEaSw3fdv5jw70QEMgr7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=Xe4WDA/N; arc=fail smtp.client-ip=52.101.126.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0sFuv36HdPZ3dkM6dALJon1j6OPcpzOES/3iWV3i7P35FGMeW2ypD4S7A8RCFqBIfbWdTGQdPI8WpFRUPULMQQ51g6093K6JKDm80jV9BJMTKKc7KR2gAVn91HafOZmqDX7oMYoZyBxodXga7tddny3HYpq8+Gcb6F/mEXx29M6H0VcYemPHcJoGPMOO4sgA4IBLr9RS+WxB8ilo3U5Aob3/mWtL/sUmSnrvOrhwXCNvEIiAm7ub1iud8ttMbeHH1TJpL8cE0VQpcqPno9AaQlfHJf/618BVJI79aaMu/Ou4dVVGQZ2G9UJWVsjLqEcVR3uBSkBnnxIpZd6HKpbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5VkthyIBrvsULez1SzppZ3IHx9AbISlhDI5aoLPBs4=;
 b=WDAoBqEOE6bWFXF/gNJjJ419e9O6TYe9318dLHdVSAeSmXpNHassZKI3s5COAizlEWAz89Zx7A3fTuHLFNEOpC3QWc9C1mINsUIZ13vmaj3ltVmGv2teSPFMsHyH4RBzqYHVEqXQG7oNwVUh8e0tnbW6VX1ElXCqhYVSlXEBy5K1u1YIT7O0smgWQktvoARGRU4moy/Xm/q14tODne11C4XfAlXLvF1tEMILYKRrJob1zBkBOOjPyzXsqBZNhncBwn5zxpVtYG0nJFeZdd0aJns5NdDGY0LLQx6ok6+O9RbM7vypb0mj3Gh/gs1221C6bVoDnivBS5bPSSI9iI8eHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5VkthyIBrvsULez1SzppZ3IHx9AbISlhDI5aoLPBs4=;
 b=Xe4WDA/NSe9NuWJnPn2U8Qvk0vUyruwboVlHWyktNphP3vSjHfbWKszv7Bvq7eqqcJuL7D2ZyvWZRoSm+XFmUYzZtKHzBOAkhXzkqA3xlxxwdR4mHPVxjPfym3HIbT6gr3YIxoRYnQHIoR2t3QGrmhYm2l8qP7ixMDuKJ8hSRes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYSPR02MB7321.apcprd02.prod.outlook.com (2603:1096:400:46a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 10:01:08 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 10:01:07 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: kuba@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	horms@kernel.org,
	johannes@sipsolutions.net,
	korneld@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rafael.wang@fibocom.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com
Subject: Re: [net-next v1] net: wwan: t7xx: Parameterize data plane RX BAT and FAG count
Date: Fri,  6 Jun 2025 18:00:50 +0800
Message-Id: <20250605071240.7133d1a5@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605071240.7133d1a5@kernel.org>
References: <20250514104728.10869-1-jinjian.song@fibocom.com> <20250515180858.2568d930@kernel.org> <20250516084320.66998caf@kernel.org> <20250520122141.025616c9@kernel.org>
Precedence: bulk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYSPR02MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 48427f90-6ee8-4e4a-da48-08dda4e10e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|4022899009|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdzY82Qv0DOH8x1TQefXIHGuEjGoabnP4OaZmjZZn6KjT6j4HDnNLnb/MuHj?=
 =?us-ascii?Q?y6gRdhzsYUQd1tFvafc2DabT0cLX12e0TSuRf8TQszINDY6c5zh6FvxE/FwQ?=
 =?us-ascii?Q?mB8s+xAHGGiqsXlvfDrK92TbDk23r39ESVWfYBzswHc4o3frZpXxr/rbB9oX?=
 =?us-ascii?Q?7FkVlwnTwezO16n6pHJUA7/kZIxZ0oGQCruJcryLmvg+qMB3Lhg70pFZczcv?=
 =?us-ascii?Q?0lhbO3oph8XFdZI58j8DtItGbTRTT61hKrp1xClwiDUFY0g537zE05cX8wSz?=
 =?us-ascii?Q?1QlUTtKflfsibW7ofYiijkwmr81y1CNr5wG3KfI1/WbD2BHg+BWayR5WB3AQ?=
 =?us-ascii?Q?ixEo56JvaloMI+OM9NbutAQHUDgkVtltsO3/CDc1mdp7Y1xAGAOUBqT703VU?=
 =?us-ascii?Q?m5bi47Z7NhPKuUvVMsbG+6rJ3L2/RzuHWsN/b9VtYYCB49mHvVUEeDEs9EsM?=
 =?us-ascii?Q?ku5BXjxNm5fS/o0XQ/ZZZ8dOdYDZJYnNUYNCR5XNudnjKXF3HAMkCSZJV6Jq?=
 =?us-ascii?Q?1utTu+5qEuf9DibUOMHB3cxvC5ej6CT6XuPANptchYzNue22YeB640DT53CK?=
 =?us-ascii?Q?7+OEka+qNJbOp8FJQvvvmsZglhRYJoiCCigK8ReIsybUNemL2PJp5y8ZtV1n?=
 =?us-ascii?Q?6AAUbUXorug/OKfjAtXQrBUES7inJ4Uxb81FBiJnioK7acGSESIgVmsIzsTn?=
 =?us-ascii?Q?gVuZJSSueC81ryE+CHB6FxeEmqGDI0Y2HYaimwwMDDsoLAQX7uvCj7bTHapf?=
 =?us-ascii?Q?9MEdzxknE7nQ6I+i3895f0nKkm8lXTOEoO4bT8setR4WDNxsiMTXz90OMWcF?=
 =?us-ascii?Q?m10vgF/o5+Jhi18tVRqXrr9sV2wV7Fv24sMs+M45kEPP6bUKUSQcWbWo31nC?=
 =?us-ascii?Q?hUSaOM2Xy71jma10ojP7OP+oLQbOQnUi4lFtwI3DC8X+q+NAwFidh/H+M1nd?=
 =?us-ascii?Q?/hIPEJacoR3+xXEHKy3/Th7yZCa/5FExz6+YQKAvdOscfVovSultXZmdi0eL?=
 =?us-ascii?Q?3ZRCNSVIbG/Wp0PqES7nsEgaJHV9TNdo25juJWH2Kuukwr2U7VjiWFxDLT5o?=
 =?us-ascii?Q?oq0JjsBjS/TRGXYQlUzvxj8qxVsq6KvepcVJ0nyHBVo+d65yAOrWTRtaRXs+?=
 =?us-ascii?Q?LKNCKe3vUmpMk/G5pW99GqeGmIEwuU47WCLEsNxV8UyfVNWadBdpBa2R6k/g?=
 =?us-ascii?Q?l05ywbm4uZH5eV4/ZyZx248n1K/wyTzb/7PXFdoYydjmRG7JRjqqMbn3DjJ/?=
 =?us-ascii?Q?DMCARbIUoOQ7SLEeIwodkZisgxcKDgIjzmmwKw1Tf+nNIMN81SjRDnXw9AMf?=
 =?us-ascii?Q?5+pOOKBWdMIrSF/YFe8nZfDV+raH59ZNqAYbvMBqZky/r9kWr01h7f6yk+7a?=
 =?us-ascii?Q?BO86OCgrjAfsHUmgTAdJIrktPmzGMb3dFI0gaS0kgA8ceFPdceLy0Bot72Xb?=
 =?us-ascii?Q?2bN0UN2O9i7uGuNDT0T7NGzYhCY36xzENS2gwfM907LI59oWA5WQug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGXmFVjQB6JpiPLQXgARI36F8ivVaFwYVOZRPKBJSBxN3WbMS3R4h8l/USQF?=
 =?us-ascii?Q?mkW+DMsQ42BawgBowHA6SlUevs138XbDRkGFdvUmimMVH1TIQ5Si04C110pB?=
 =?us-ascii?Q?vmMPnKjXpcvG2eFAoQwoYngmZOS+dZYaeFf2hX4rkgF2VQkkghONHOaIRIM2?=
 =?us-ascii?Q?jbNOSYh0y06DfL8l/dRhaq13/DBVftKCGZqoq0pexbeO6DKe+FMo8lBFgE6e?=
 =?us-ascii?Q?zIR3XY6rM5CpQWCq/QZR57HypeR4k/2aB5BqeQnLhlnQTBc4ha8yLcH5ZRPI?=
 =?us-ascii?Q?YOxj4soG91Vurg3HO/Td58UISpH35wN5BlAUFATSo5IJYHpf+r0Di5eBKx7R?=
 =?us-ascii?Q?YlggG2gECgc8IOHL6GV3O5IQWFjfd0/38QhhtWsa37VNgYsULL3dqP7zAgO7?=
 =?us-ascii?Q?a7tijrZgztGhHq+veCIZUoeSuYuw8s7O9/f1e7Q/BhRDM2uPeaFzHl5tA9WU?=
 =?us-ascii?Q?So1d9/HJES+rB4j/023vUnhJe4AWs3viXBH8lfAn0DjFQn8cJODs/Ddmc2aR?=
 =?us-ascii?Q?GZSuPRNWoCjJcKr7W7pdZEbBuAN76vjH31Di/f4ciCqMT3edM9sZom1dOM/I?=
 =?us-ascii?Q?KMfw5IoLoYnFs9eiwdJNddv37KRZ2TEVxqIcfz86275bgkvxSRQx7SNsQnED?=
 =?us-ascii?Q?DDmHeIgLkWPLuJB4qX7Rh8e9iN8c/wjgXRqI+9xGw+S2PfXiw6O2+66K7eia?=
 =?us-ascii?Q?CBgpS5rMH0ICANKKXBPqKMdM1iyKRwIpVrElk/cNbG5QOvC9oRdkFCIaofvd?=
 =?us-ascii?Q?XVgIs9B3msPMNbhGqV1MtObBLm68RAEXYk3pYSldzzV4sTl1kwqjxpFhqPMt?=
 =?us-ascii?Q?FpfoWA2pmqy3DH8798IZ17C/u+J2rogYmDObBHDayyobvRLsNDzMMs+/LLGS?=
 =?us-ascii?Q?HcIEhj3F9Zf9LdKrH64r3NucM2kaXOanddi8Jwrw9EV25ldOwGHgdoe4TxYj?=
 =?us-ascii?Q?JuQYxAspsk3EoHkcSvfiAdWvKtjq/bbx7sbDHAvEqrsliEiae+c5Owe50Ojb?=
 =?us-ascii?Q?fYtm8CyGuytVPh1RddkJM6k20vh6ejx1/EVv5TCc8HnpYmG24fIRhbM076TS?=
 =?us-ascii?Q?H9ADe3Ooope4TgDxxhtuy0lQAvm91WoFpiP1YJFqlzgD5DmeE8k/y+CXc9D3?=
 =?us-ascii?Q?+qR63tjYl9A3aLHSYpn/xKtQlFxcZhT8rkBVbcr5jzR0Dm7R9CC0VYAF/y3w?=
 =?us-ascii?Q?6ZoSj+t3uRVZeKpbw5HMH2yT7HFSlx1JabUU/n5t90MnNzhmlZTKXxMz6mmZ?=
 =?us-ascii?Q?StjdpDsrfpfFlkXLiTG1FcoxppD9v5sxTq/gL/3kNWXOoiY6moYedn0hAxtu?=
 =?us-ascii?Q?y0MStqek3AJtNFMDhY+RQNN2mMbw1W0qoOrXY/xkrVBh7psBe2hqrR/6pQG/?=
 =?us-ascii?Q?W+xFpC0wMJeL67EU1yaYsztdYL7uxNvFSL2Pxnp8yteb0bw2JG1J1vsmw0BO?=
 =?us-ascii?Q?BQH0bmJr0Sc05BB3iNRNjbUXPg8CL6F+QJPqMyqPSL0ln45Gq+81XmQstTKJ?=
 =?us-ascii?Q?IcFdivMxCnKJbvPD3vkFNMuC31m4LnXNOw0ElIX1BNSP1KvH6wzvS8FLtgFO?=
 =?us-ascii?Q?yVzPb0CAimEapzp10gYOgj+PEnH/pz49FE5trc48dABw6BsgwfRN9McilhrJ?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48427f90-6ee8-4e4a-da48-08dda4e10e53
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 10:01:07.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dfl5Rtpq1KKiZxCWbz0E/oDuOPHyQcOJabcue24b1Pg3M8+rdKxGVxa4cbBMlznaqbQf3tNLoT3GNFq+c2gwEwaKpZqMduCx5mNoljTiFmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7321

From: Jakub Kicinski <kuba@kernel.org>

>On Wed,  4 Jun 2025 17:17:22 +0800 Jinjian Song wrote:
>> The parameters are used by data plane to request RX DMA buffers for the entrire lifetime of
>> the driver, so it's best to determine them at the driver load time. Adjusting them after the
>> driver has been probed could introduce complex issues (e.g., the DMA buffers may already be
>> in use for communication when the parameters are changed. While devlink appears to support
>> parameter configuration via driver reload and runtime adjustment, both of these occur after
>> the driver has been probed, which doesn't seem very friendly to the overall logic.
>
>no.
>

Hi Jakub,

Could we configue this parameter of mtk_t7xx through Kconfig?

Thanks.

Jinjian,
Best Regards.

