Return-Path: <netdev+bounces-177709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64EA715BD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75633B240A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F41B87F2;
	Wed, 26 Mar 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JeVucoA9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9914B965
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988506; cv=fail; b=J9Xp/wC0SHYmfOQmrFiOrIhSTe+3CJpPXHobK+w2hJsN5EgllQILLgZ4M/NzBJxbVM4BuNys5aD0fkiokLzNbvpp6Tm6Zw0/k9JxYyJ8w4hiSlUOk9lPwcwbkOqzIYDdFQDbaZ2IVu2iEcB0hqGACoO3HKtbqsucAeaEBER6ZfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988506; c=relaxed/simple;
	bh=IBhYCH3y7cCyz2PZ39jPr7UCyqJBws8opPmt91s/BRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Ra+vaiBTpjbQkI72vqM0xZqRIWjsgewfn1yH+tZp5v8LXzNKnWBfh3RJommun4ofUzUiTQEfrAeWwtOhufFTXARc25SekQbt2gduFSGrRNYCo/BOjoX4NSvWb3mjhCUGjSKYewUaHDBAEJRkCqkkuAAGDJ+dRD0cM6xRMmMYNpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JeVucoA9; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5Gm27HsHkPSoCu/pRF1yPOvqX6cRs0SEmbAETKxgptHo9EBJgvcW2n8fmdxD5o70GLhb7NGrSpEz9ukGBfBpKGGy4v5OSMd3899Xp7rKy4ee2sFqlgcZNmZ4eE0VmwWRjlquNjsKVikOygP2CsfKpv7P8Pfj5t9grzkhGp60Pe28LU5EMcE74VRgcfQCInV9exin1aZYgRGOj9PmOngtYkhKDdAGuVkUkKbxGTr8WyZskeqvl5ZN9w1WlG2iaZxK13+AcZzxcDkgFUKJBpT7EMOvXLpghbMg0bzGRPmDb/9KkA85U7QWADukqSrMWVN+6qTr/7snRu3vSHV9pU4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBhYCH3y7cCyz2PZ39jPr7UCyqJBws8opPmt91s/BRY=;
 b=qpK8xK1bH1ywVLnz8QbyCUTK8LGnOj3fAty6v1yIbq6yCsSj6k8U2QL6DEutqSG2pbuPb21X6L97K4sZNi910bg9eC2+HByY0YDoHAvYr4kTpfZb8y9SkNsPS7x6+n66B6qYwAxOLr/dppQbYODqjc0ufE4Z/S+gTjxFB0K0cxMcu+DLCWJyKquFPwDeVgV3Dzb0e9P9dreUSdQ593EQl8A6St7ZDGj+ZiHIghI6dR6F2QDzedbWhPKwiu+FTYPvAr+JpDDjMnt1bbDvuGv/YBDUSp3IJm4WJfmBiP5WjylIlt1kK1+QIZPXdRe1JquoO7BlCdgmrpzTist3qQsvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBhYCH3y7cCyz2PZ39jPr7UCyqJBws8opPmt91s/BRY=;
 b=JeVucoA94UoxSlD8OMqIawPBbUxC0fUwrF3ruSXG33dToM1R+uM72XwAX4dmnap+uownF7pA5yP8QYtSVvHvFuXWD0dASdfA/cuJnFha2HKf5oYosArlx8JXJx/KHm4TUnJNI5uxaEoHQ0v94sxNcnryCZmYVZUTxbfY/pQtlIl0Si3AYVCRMCFb8HYgVnxmY1pfbdyU83g1FjDjww00kWA5m/JD0s69lDsUA3wx3z8kTxMyzcgVzR1IsZmEdHsWLQXULBrChMW2bbnYh4WRS+dESFzM3nEgoYJXY1hGJpA/W51jfHgA6Oxq0II9o9hnvIu9AtVgWi9bHJ5jQqZbIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 11:28:22 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 11:28:22 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <horms@kernel.org>, kuba@kernel.org
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
In-Reply-To: <20250304174510.GI3666230@kernel.org>
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
 <20250304174510.GI3666230@kernel.org>
Date: Wed, 26 Mar 2025 13:28:18 +0200
Message-ID: <253jz8cyqst.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0356.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dacf43-e927-4c47-45ac-08dd6c5950c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4bNidGElAB+vPratz0FFt1nVGP25MLCu9JaYsz9ftqQ+ZQQHl8XDI3FRP8m?=
 =?us-ascii?Q?p18NgNtxhSQGKZyYQecxsxwrBTHlbnZPQA3KF2yHeR1tSgUkEboK3p0vuEGK?=
 =?us-ascii?Q?5/iy6j3Mh3Ze51ytWgaSag95UdNGMK+j4Wtcz7OpMtNowDAnVHLJu1zmi7JV?=
 =?us-ascii?Q?fqVRKd8qEZ+GlBlD9HruY/N2vOaLNwO9V+M8vBOxNKghV35NW9aMwZExYAMG?=
 =?us-ascii?Q?q73ArIB2jMb6g1hTii6r7eBdQJZ9Wq2XfLRNcmF6Cc9kLN2daCo+/P+iduVi?=
 =?us-ascii?Q?MBAIT7HDzE65Oa6auvBi7Xt5n7hNwU2vdIYl1xjffrbsgJw2Wpxk9v6ZzlDp?=
 =?us-ascii?Q?mxyLi4+hHh5GClZKC/paRxsKnVFsYxN7ooR6rdlhh5Tjht1QbXM55N9ahANi?=
 =?us-ascii?Q?R4s6wiFJDY1epPNLihQfhkop4V1iTMiMiAtSC97QR13YjeaKWKB9/lUDfPPA?=
 =?us-ascii?Q?vjoZke9ybvjthwPvfkDR4jQXKOnIuxR+9tgua5AcrvTCK5CMqJlFmvGeN2pC?=
 =?us-ascii?Q?A0tiWyNEWlmffgHycRHsQPaxfNrjNTKjlKkl0ZjdGIwCSrZXzi3Dmg+qCyE2?=
 =?us-ascii?Q?DFyZSUFGlIMvv8fSpyARBUL1uCuqFQmc3DfanPAwruikk4YCCD493rwS1HGF?=
 =?us-ascii?Q?BPj7g89IHLPdqA0odfP0rGnMpVdfWSsSCL4LzCk7K4MQAxysBFAPoQDEeSya?=
 =?us-ascii?Q?q99LJ7RLD2u8Tj97T1qY/3Ye+AuW9AaAhFYCD1ap6yDg+5M3yTrN+ZSRMtB+?=
 =?us-ascii?Q?ur569mu1flD9cJ484i1lRwJ0s/s8skC8B3AQv0ggAET8Uw3flbwxpXd9qqxI?=
 =?us-ascii?Q?BhUhObK4IDc/GpboaIW1/AvV4svUEAs1JJCB0j+qISMTsq7Th6vnLHQb4wIq?=
 =?us-ascii?Q?VxeQ/NW6nwCYb0+ys94xtK9buFNiTPi6vK5+AnLnjraBxtK8LsXq5WgO2Y9M?=
 =?us-ascii?Q?pkl1Eb1DUZiwAXoIVv1eRFLYN02OStoTZleGOUmTczzC+q7azNlMbLscsVOh?=
 =?us-ascii?Q?ZwyyEAg0owNZd86IWmrZyoCXFgHjnG/7AmnAj+ky1XdFLuD9dITgEJe3K15k?=
 =?us-ascii?Q?mJmW4B93AzN6kSREY2xwKwbaHTrcd499jjTeUbLpzYDQjVpphmtvSD5iPx4c?=
 =?us-ascii?Q?ZiSF79nJYnd1jrmx5spYI371rY4NAlzQd/CTW6ndK3qAa3f5EN+xRxQvBmut?=
 =?us-ascii?Q?YRMjc9ABKEfCGpfANWBmkumWJDvx5g4B9S8gKaDRFC/Eb/A4rcZcW92+Wo7r?=
 =?us-ascii?Q?/6epxOrjSdjUOSlzpyh86BWoTfpjBEdei2MpeinBNH/+UK5V1sD8JYgCJXVP?=
 =?us-ascii?Q?XTiD4yhJIBxp1O7G4OWakEvcDR0YWExD2OvVqQiPJ95Mcww9jttRfULz+zfA?=
 =?us-ascii?Q?vv4gxMUBsAAH/9hMZu12Bl2yHOOd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPCak/3gdbnhWjxSXMks9eKgK/2PIl9NA9jqXna3bGZ3DgdfxR4Ab6M/AMoz?=
 =?us-ascii?Q?/Q2SS1s5ctq5CbmD8TryfW534uW7siJf3pP2Jurcdvf7HkLIvSIPAFBWtPuO?=
 =?us-ascii?Q?HuHSVU9eHtLW/Crdoo1rSwv9fL3mXgDGRQk15jULUqb1azgmEzO2ByVAf80w?=
 =?us-ascii?Q?TyzjCpBFFONYP2ry2RDbVPHoa0Xe4r+ObQTmjyZGkYJRVh6/Zt3c9tqC6rvu?=
 =?us-ascii?Q?lc2Qn65NtdeqdhHsk05qhKWXCTBvYEcvFx+IOrOYqRF7PkJCveM/EQrIrCIh?=
 =?us-ascii?Q?+TDePblnYDSjMWeoRObN1+mykl+C3bOxfuqFP5CcvF2ccY7lNPcfTYnVxHT1?=
 =?us-ascii?Q?UqjavyyYy04sAtQh6xBd1cUrBo+xusDFcvK1Ia6+CZqya6QsGAsE6MgwaPRD?=
 =?us-ascii?Q?60JKlxYt4HRJytzws7q6z8tkyEOtUP8LAvnF1rINClo/yHTInn2dyklBSyCu?=
 =?us-ascii?Q?/sHXUFKju9uroyLMpf6dcZE+A9btCn2aYDDP1vNi1M7p9EBDCy6PHkJ90Xdn?=
 =?us-ascii?Q?NurqWk+YV4I0uq99jMhlt91OLyStONWF0+7OeXt5KgU4w/8CdEy2R48Z7IrT?=
 =?us-ascii?Q?OEP+MV9akpm8t+eCVM/4/HghvA1Xo5W5ynmjfuZNB6CoXLwJsOvnx9AvpICD?=
 =?us-ascii?Q?jc622apZG5UwzmX+We35S4IWDFwFKQ8BYdXyzl0l7KuqWqEM0UCaxjNDSV1y?=
 =?us-ascii?Q?zmP0LGfASyZQ0EsFBMXgdSwsM+aP0GIOFfgooKdhRgSrxq6jDBq1f4bLXkKA?=
 =?us-ascii?Q?lw/6Y886aB0EWC+9d+JXPHfwmebMVoyFmPYKJ4ZynVs6vz0eY1Qw+9R0PAnT?=
 =?us-ascii?Q?hLoR5O5DplBXohaBXwze63glod2Mqo3m5Upg9U4FXEzZqfc652D8iXbINEp4?=
 =?us-ascii?Q?fZ/1e915JlBhKgZ7ZZvokZ56VQUM3BF1sY+PkV80MZoLmxWgcw51oKNgymax?=
 =?us-ascii?Q?I62NYT8d4glsDCnkiwunZH71TOvgZEsSbtQ4xtz1LyjCXqP72lPBSP1Uoxds?=
 =?us-ascii?Q?2HJHWOL1Esnzr8UshlInM+mllUV48jFVTc0gcRHdHIK9vBj0yM/DQLlnCFWO?=
 =?us-ascii?Q?sZ8cFTK+WFZ5OXGWFX92c6hPuzOBhInmvIjBxWuWubAPVg1IuKe9sIekuApN?=
 =?us-ascii?Q?5oj3OopM4maGAxMh6ivTDYsDtvh35dnT0A9wiUnEPkGJkNk7Sn419CsZ+dBL?=
 =?us-ascii?Q?I3dOrNtHx3KRJvw20L7dR0zYIe2deUMdaNTINp9fE63jWW85PMq1k7LfbaL4?=
 =?us-ascii?Q?E9zbFu6FbGmIjvtdmsd1eRwhrj2I/F1kAP47TwLHT+fzltG6Ql9NBXST/3PO?=
 =?us-ascii?Q?D9pqFH4W51Ykb12Vz2JWtb8oOULIZhPp5qjc015iszDJ4/URacXvsFz1g46P?=
 =?us-ascii?Q?ZJzPQw3+Kba6M7uRPX4RU/A8k73uyPHqKlqGLU/nYrRqNxzkEcmxUgqdkFH/?=
 =?us-ascii?Q?tQEFStVS3m00MEP7FCoEjDBV36aAEXKmjwgqKOuBboER95kIq4wAgHLwz6Bd?=
 =?us-ascii?Q?6klb1xXnq2ttCEUqw/vOR10L2bD8SQiS17tcqmOZVy0xoLKuu9OY68/0viJs?=
 =?us-ascii?Q?GTao90tfAoNd7vqbu3rYx+7J52+D5UiXy3Rya/P2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dacf43-e927-4c47-45ac-08dd6c5950c9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 11:28:22.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1b1RLEN9Z8PcvR8PJWGG85xsKmB5qlyj47SMr5DiiPXI1lCpJq0xoPugPdMR9y1Wa8jwDazELoXtKXz20Xocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

Hi,

> ... and this one need (at least) to be updated for the following commit
> which is now present in net-next:
>
> bf08fd32cc55 ("net/mlx5e: Avoid a hundred -Wflex-array-member-not-at-end warnings")

We have fixed this issue and will be resending once the merge window reopens.

Jakub, do you want us to change anything before the next version?

Thanks

