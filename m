Return-Path: <netdev+bounces-236610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6613DC3E5E3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 04:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0372D3AEB55
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811212F5A0D;
	Fri,  7 Nov 2025 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PzBoNcNY"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFD2EBB90
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486722; cv=fail; b=uqJ50n3sQfeJq18DWHZIXPGqUMn8mzJixbbT88nEAh01+Hsl2H2e3iYr3TqI+ug7/u+fLpS2Q2WhoHnY2A3x3ZWf2AD+Cn5/dNPeEjYXFZ4JJdTdKTtswaIB+dtYnDREEEYErxu5st5Z2gjZGQkUPjnsYpCe0m29FaMvwPrxIsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486722; c=relaxed/simple;
	bh=KPCZi2IIf7fNT1SNENZdErDlXTwBsSaRL7A/VzCtjIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6gwcDb3pNVwRgtj6/Xi35gP0/ZJuSc0YJgtkpYs2eFlHCQhGJ87J6KjemMCMolHW1YwFXITJpnJIT6S4IKjXjppY026ff1bJ8a/V8rFJdBZt78tyJI9yownpJzfxTC8Pl0pw6u2UBzU98QsZhU27PmDF3bBri2kM/sSUQ8fLDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PzBoNcNY; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqjZoZQhdwfHWlkYfGIBS3pRD/cyuuZo4O2X33efCvvSPIeb4uruDNJyWcBbBXLCnrlCGL2c7NHqWG9O55F9Kfkk9VB3oyMQcbkqvoXHwVSSZZocCMvcA6qJ1Ndv5YxNd/qaR4ZfWh2wA+ShQAbEb/QeNtsYtvz0clDAi/9SXG+id3O1ubYv8SThL5qKt4JCPCQvFAy4/rKjA9egyfRR08dVzkR/X3RL2EoMPHV2JerP2pinVIrBzfWDIkTg8yHmMRqTBQddWffr4TQfe47IpniKBHbmUrqfu70ChC6LVsmp/0GVXEqNRLA+YLGMLPCqqKZAdw6/W2I1iRwMfDJn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOjlCG49u7MNGQAfyKdoTtd+5tIFvL9zQoq41GwTW00=;
 b=o7ARy8AKKJJ9hT7cZZ1lBXt+9OgwuKQSLMnqqJZrs6n0BIP5Su410Sn+dbmPuEDXNlq9ZTbjuI9p3LvVO1rRQyPKrwZbPj6LrjdOJywglEWaJw15iuQ5MGvn+vmLCPPGTVMk2DrWxnr6DyAMpfwazu28FKcnhWD6aDfnug+WMpYF7yDr9uwPANSZMIv+ZDhb5o0mMFtZruJBgRFgBm8EBTV30iBVgdPmG8oxaOcDzYL1AlgNdcAm4xMfkF+bCjDzarZ7ld+3lx5Y8mChKDqlhyj3KRSXZUPy2LIgnKyIIMpacOOLX3Efle2Njm2XP5weiHnp6yqSlh/QA/CjFcXglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOjlCG49u7MNGQAfyKdoTtd+5tIFvL9zQoq41GwTW00=;
 b=PzBoNcNY/ymLq2rNKMnDm4LA35zW3xFJjJoja+i5dazm38WbOljsYQoaURWXv/APfPNa0bEmddwd54YDXZfVXVqo/6wbr9f7yNslaBbK81fDy0d0l70fv+k0FGFA7rZbw2/v7J96Z1/Lh1zntcqRntYj3JJcXRhpwd4PwQcyMFd4E14eVTFAPPp1fVZlp8r6veA0ZBZSL8hI7LElLyMbZFDr21ia1jmzK4xoaJikw9XdcLyu9QOYLMQODhzjWk8OiaSQ8PJ77CnR8B0mMB8xePayWb+P5+D8Orpuc4pvvaIE24+/elCqx2AjJM8QPvc+G0j4KRYtxCIL8Y5tbJAbSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 03:38:37 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 03:38:37 +0000
Message-ID: <0ac86e50-b252-4d7d-b905-06fb928e7f70@nvidia.com>
Date: Thu, 6 Nov 2025 21:38:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/12] virtio_net: Query and set flow filter
 caps
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251103225514.2185-1-danielj@nvidia.com>
 <20251103225514.2185-6-danielj@nvidia.com>
 <aQtdA1YGpePiepXV@horms.kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <aQtdA1YGpePiepXV@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::15) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfed0fd-25f9-489f-92c5-08de1daf229a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXNGV3pBWXRsNEZYUWdLNzVrSVBXcHZUZk14amtzNTg5eVFuWjF2NDQ3eTY0?=
 =?utf-8?B?TDJqQ1BzUUVqc1hQM1FpSERnRHh4a2J0amh4a3VaRWlVNnk2WlVQYnhDb0l4?=
 =?utf-8?B?Q1h3dkd5YVBLVU1OaWdIWElER0tHQWdLRnlSTXR6L0RzNzlBTVkxMElOS3Z2?=
 =?utf-8?B?WkxaYUxmbmwzcWlXK1lrZm9kdnBYUGpmaE96Q0dWVmtyV1FFdEM4SUtaaFBM?=
 =?utf-8?B?YzRlKzBvSVJVYWJHS2FqOE1aaVZuUytoQmhrbVpGTTlHSDZrVG1jL3ZOZU52?=
 =?utf-8?B?c1RLVHRacWpraUhsWHRqNDFpUjc1V3doZjUwSm5Xd0ZDRTJJdkRaR05mYjR0?=
 =?utf-8?B?bFlNZGNwUjBZWk9GOGZwbFpRL0ZKOU1NQnBBdFRMUUp3cWFoQXFSamVHQWIx?=
 =?utf-8?B?NzRERG9LcTlKZldvWUM2S1ZmMjZNYWxpSUJnV09WeE5xQjZnVnkraW1JL3V4?=
 =?utf-8?B?cVQxU0VuRXZ1ODM2cUJVeTI3MzFMb01HSTZhZkJOTXNrVmlacW5taVdWNHNS?=
 =?utf-8?B?MFdLamIxeGhuOXQrWGJyVHJ3dlJzNnRDSnRXT0o3ZVVuekVsK0RzYU5zaFNL?=
 =?utf-8?B?blN1ZFVxL1lPR3NNeHlIOHk1d0tJV01nTjZ0Z0lPSUVsai9HQzUwb0ZYcXZj?=
 =?utf-8?B?dWg4SmJjZm52TnZZZWhRUExnaFpEcWd0RHFmVUNXblhGRXFOcUh1am4yNEJ1?=
 =?utf-8?B?cjlCc1JremYzdThpNHFBeVdaUUxhMVdhMjRVMzhBeW5ESVZpcUhZWXYxb3lB?=
 =?utf-8?B?bEpPRkVkbnJ5VDYwSE0wemoxVFBOUDVmVUFmRFczbjlOb2FLRTJTTHpEdDFm?=
 =?utf-8?B?Rk1sbWVab2txMm1tUFJZeXdyWjBxVXZiMHh5alNOVWdEaWtJM0hRa2cvcitC?=
 =?utf-8?B?KzRUWHBSd2s3c3ZHdE5jenhjUmtKU2wzNDRJTmVqV2M3eWkyRzlXdlRidG1E?=
 =?utf-8?B?NFpqa3Awb2dRZktGbkRNZVhzY3R0N3NvWE5MYjYyQUxQdjVpa3d3ems3aGZt?=
 =?utf-8?B?dEZ3N3g3UFk3UkxrU2x6MkFla2lpODZWSHQwQ2I2QTFTVlM4OE9GcVNKaWh6?=
 =?utf-8?B?Z2Q2Z0hERnJmRGR0V09YV0gxbVdDVS9rYTd2K0ZXeEpiNS9UZWRHeEsyYnpE?=
 =?utf-8?B?aWdFay9IcmlpK3FxWml6bHMzK2xLM21udVArYlQvUFBkR3cvV3B4aGNCTmc3?=
 =?utf-8?B?cDBQTm10eXJCcGIveFdzOTlMMjF1N1FKOFlob01PcUw1LzV5U2NMdjViYnpn?=
 =?utf-8?B?dFNueTNjcEhncm1QNTRucDFpa2tBcmlVU2w0UXE4Q3BTeW1iNC8rVzB1dWR3?=
 =?utf-8?B?UlExQ1VTVVNUemVYS2VvZ2F6WWxPbkRvU0YzcjJ3aml5dWE4TDNpRXZEQ2w0?=
 =?utf-8?B?MkJMSGpWZUhFdTRVcFVPc3VMeUYxVnRmYzVxNFpwdUVydU5vQmlIbTRIM0Vr?=
 =?utf-8?B?Q0tidlZYbEg3RlZGUjd1RUdBUDlMYTRRRDJvWUJia3I3SldXUHRFSTUvZ2hS?=
 =?utf-8?B?QjlETUMwM2VSVW8zUlJZWUkxeHkyVWI5R1h3RnM4alpXcWhVTFQ4ZWV0a0tm?=
 =?utf-8?B?RkJ5OGFYTDdFN3VlaXkxQzNkYVU3emZuM29RWkRRMEdkL1FmQ0JpZzk1THkw?=
 =?utf-8?B?di9tM3VxczNObTRjcVF6TzJ1LzlxQ1dQek9MeEVLQzFzWnNkQzNTVE9IdnBa?=
 =?utf-8?B?T1FLT01VSUJHdFI5dWFWTkE3bU1QNWlIMld2Q1AxVXJsRFhxN05KcVMzVTR0?=
 =?utf-8?B?VVp0OHlzWk4rT1FyTlVHTVdGQVFVQXJWYnNTWGtIL3pEV1VJQTY2UGprU1pa?=
 =?utf-8?B?ZmZLdUN1bEk0RlcwQ1VuN0hpQWdkbnY1ZXgvRW5CVjFXTDFEajdiWkZaRk5z?=
 =?utf-8?B?eXkyNzNCc0Z4bXBjUHhQekkwdzcxRGlDZWYzYXZrRmxhaVhYWFhNUU1WcnRq?=
 =?utf-8?Q?PypnzqVR9e1L5vZKbmBDge6ef72fOmjT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGhhR3hUcm1aU004RzVCTnVYT0pTeXcxK1VzcFFJb3kva0pXandRaWRsQkNv?=
 =?utf-8?B?UytQemxaTE4zeklyTVdkNlFPVWUva2dNNVduN2h3UENldUlCREZvclZ5c2RN?=
 =?utf-8?B?WnMxZzBnSklGWENPYXhiTnpBWnVYbUZubnVLQ083bHdrUjl3YUFrTy9xMUVt?=
 =?utf-8?B?YWhwY0UrRFhjVnQwVjNKMlN3eU5taktJM3hRRWpaRTFQSmtYNTMwbjd0VWJK?=
 =?utf-8?B?dkZ5NTl2eTFMNUxWTTU0TEpGVGpsNGdmSndZK1BFbVg4bVRlT1VMU1J4QUph?=
 =?utf-8?B?TFZsZ3lIMWpxQWkrZjlUcTlKVk1oTGprc2EzZGNBMEtQb1FNS2NoU1NscEY1?=
 =?utf-8?B?eldHV0dUYVN4YlFGZDl6aFpXMURqMFhyd1V6dkpKVSs3eDc5ZnQ2MEUwVTBT?=
 =?utf-8?B?TkV1UVBXbmpwTWZrcGRTZHVWK1phbGtESmJDOTU1TTZieUxqZEM4TkhKNVl6?=
 =?utf-8?B?blRlSlF5S3luSDZYREFKMnY2RW9hV2dJcUZvMUFnV2tOS2VRMHBuRmUxYnRW?=
 =?utf-8?B?c0dkV1FaWU5od0gwUjJFbHducmlWT2RGSFZlNHE4WC9ESVkzVnBGQ3ZaT0RD?=
 =?utf-8?B?MGYyVmVpRG4vSXlKYnoxRmJ2MjNqUzVIVVlnNkVvcjNVcnpKam9qTFpZYWR5?=
 =?utf-8?B?Q21jS2trcHdmc005TmtFSnJBaUpaOWw2QUNxRmlKYWRTYld5TXB0b3hFZVl0?=
 =?utf-8?B?NzdvTlZaWDEySjBPSTNsejV5dEladWtRWU80SHg2RXk2NCszaGx3ZzMxa0NP?=
 =?utf-8?B?K21wLzgzN2FOVnZtckl4dUR0emxOTlFHMndiNUxIcTVOaTJJR091Kzl6bVlt?=
 =?utf-8?B?Y3BYbDF2bEVyOGtiVzcrdXpvU0JOVDMxMTM0c09UNWZXZ2tNWXhpSW5UaFBR?=
 =?utf-8?B?UlhSKzFWNUkzSzdBNzY3YkhERlFuTWZJaG0yeDk4Tzl4M3ltbytWaGNJVkN0?=
 =?utf-8?B?b0lGTi9yQmt0SHYrb0tzWktIRWRsUlZUUUlVK01LUXo2U3lHeWJ3MFpLcFR0?=
 =?utf-8?B?dUFrMW1iWmdqV2RnTmlaNEtOZ3MxUGd1aG1tM2huZUhwQ292N3NHSzdSMlNp?=
 =?utf-8?B?VncwdGU2dGgrQWdaV3B0SlgzWTB3bXpCQlhmZlJxdVJOd1VaaGJoRHFWbHZv?=
 =?utf-8?B?bzRrQkdxQUZ4eFpIaGphdyt3UDlrTll0TWhncGFhblN0NjJ2WDg4eGd3QnBE?=
 =?utf-8?B?czkyUzBES3RNM3IzWENFTFhjT010ZFFVbWQ4MmtNOWNtNXlua3l4V1J4MjBB?=
 =?utf-8?B?V0hkenJJODNhb3dQUUcwVXNOdXdOWWFkVFZnRGVGVGxvZEc4L0htSnV2aFBZ?=
 =?utf-8?B?aEM5RDRwb1k3alYrSlBOaXN5RVBVWVZXMVdCSlVoZE9NYjZwdVBIejlJNG5r?=
 =?utf-8?B?VkxFN0dTZUdJekdQSVkvRWlhcGlQYkpsN0l2WElsSEZtNXNJdUlJN3FURWto?=
 =?utf-8?B?VWJ5S2FrTEFlVkZmZm92YmVZQU1EVW95ZWZmdWM1SkVZRlYrNW5UR0gzUjBK?=
 =?utf-8?B?R2xLY2NrWHhwMmd4MzRWOHd5cldFa0lNbXNhUW5OeURsNXZqWm5VZG93UDE5?=
 =?utf-8?B?RFR0cEdtQWdZNklHbXc3bC9tVXdkRWhoWG04clBPQkQwR0pOR2NpY0FXVS9v?=
 =?utf-8?B?eStJMEJ4MVljV2Jzcks4TlhaVlNGRGtxRHJIays2M0Z5Vzk5djJwdHpjQlMy?=
 =?utf-8?B?RXFUK2dTOFdBVXlLSHI2KzNLaUVmaVoxMGcrRmJyV016NmlINHBDZCt6QWt5?=
 =?utf-8?B?VUJtTGhIaHdLSkxIRHZKQ1dVUUJFa1BOQVFQeVRtV2VkTHFJOVN0VGhDNnds?=
 =?utf-8?B?TTd5MER6U0dSc24vc2ZqSS9xYTRTMnJLYnZLcVpMSkE0MUpYQTl0VzFITVVE?=
 =?utf-8?B?ZTRNL3JKaHNhZ01xeUFZZGh3aExrZEY4UUZ4cytPY0EzREk0a211UWdkL2FE?=
 =?utf-8?B?aGpnRlhISklrNjREMTZUSTBZU2VZM0M0VXRoaURrT09OTytmODUzeHA5U1pp?=
 =?utf-8?B?SE1Ja1RtS0xvdkNFZUNtZG1zMEVuY2ROMWpZU0tTSGxXTU0rWklFZWh4V1FL?=
 =?utf-8?B?QlNqQXdBNVBWNndXUmUwT3IwWElLdkJrS2dQcDU2UHFKYnJPOG1KRUg1SHFT?=
 =?utf-8?Q?Pywifu117WvYRV5pwp8JEB2Oq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfed0fd-25f9-489f-92c5-08de1daf229a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 03:38:37.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/KtOJc7LIFghm9FGJhyrc5fQO6OZWKnTNKzU1nuyIohC1vwQu5sj4QeFZD04OlLXSqJXRbsVRr0yJqh0zwL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962

On 11/5/25 8:19 AM, Simon Horman wrote:
> On Mon, Nov 03, 2025 at 04:55:07PM -0600, Daniel Jurgens wrote:
> 
> ...
> 
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> 
> ...
> 
>> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>> +{
>> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>> +			      sizeof(struct virtio_net_ff_selector) *

>> +
>> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
>> +	if (!ff->ff_caps)
> 
> Hi Daniel,
> 
> I think that err needs to be set to a negative error value here...
> 
>> +		goto err_cap_list;
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +

>> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
>> +					VIRTIO_NET_FF_ACTION_MAX,
>> +					GFP_KERNEL);
>> +	if (!ff->ff_actions)
> 
> ... and here.
> 
> Flagged by Smatch.
> 
>> +		goto err_ff_mask;

Thanks Simon, missed that when I changed it to return a value. I'll spin
a v9.



