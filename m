Return-Path: <netdev+bounces-189006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D2FAAFD26
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B5D1BC753D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E532741B3;
	Thu,  8 May 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ONzKC1n2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2D2741A2;
	Thu,  8 May 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714779; cv=fail; b=k7Pi/cXgfLZRsVSAylwnnTPOq0whVJnEjgkmlW5aMWPZEVdGtQTAaYDVxHCJFMBNZURrOzatUOgphsgtTf12LUVQ1axwC83xGaoV31biEAB6XsWsuxRwOoivNi/F7H9dmOAhjH2DQ+LtCdsqyQLFutwzqselMLxZVi/tt90hpRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714779; c=relaxed/simple;
	bh=irRNl/SZvUs5yaWLRgT6VEodBPxyKRq31N3Sh6cMNOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qWvcl0zbF9e4s2MTuKr8VY9CXCKdVPwJs9knzKJXt99SrIABxfgY2nU7rAzuCb8YI8KxRN2RUAQn7eMCNiq34W5ZZHolZTKGqv1cBfc0DqtuBVGcuTxF9BNqtAJkUHwXh35E3vUdcNFFOPBIdEt6NkSNCd4eT17SLfsbJd2MLPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ONzKC1n2; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K45rbk3VoAse7sEZVaNy/uJiN2OZiKqj6WZAe5+Sax5SDpMTalTMSiLJf8FPfT/MDJaNhtU8Co1AGY/FUlCdLmETAy3gnjEdxFVpolndlGlMgdWEbnNafQ9ILNAM8l+UXCjthAaXUCiciy5SWcrd77z+akl58eifATur8KA8LzUP62/GKAPF/qqotrNeRnSncHq8vyESUxgCBfYrZJlp0HVLeEKFt9hnNO6x6tCtmirsxG4i6aH3XEaa1653M7gokTzI3CvtZncxpQdQCTXE/71XEUJi9K151Ntph4xu8Bgv3nK3QK5MewLweArRBLFLlwyyLo9dSkni7YqmficAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDNqEyLyADAFLcs2wmfQX4/f3VfBHjJPQMFVvrndtHk=;
 b=RC+IhH8m6O9ULxgLtxuuqzw7rCwkMi6Uu/F31znpcXT5o9g8O2wQ8IEpemb9LPSaSXpKixDXfjxsSlTTucys9UCmLgKQN+OYwvX4LlxdbBd0W5KnrilYIztW9blmpyoIdgmmK2KzJEcUFg4QljoUVyrZQbQQEDcBuIIAdHiSDbHJQ1ek7+ayLXB8niOyYNkzRT97I4GlsQGs2BYl13xmWkdPKAn0XqcHuZ264/yyE8UJ0211WNajDj1tYDa+qp3n/ZMm5cbZf+p/L7TbraRrHauTxtNyCtMth8H6RJuIDbYY1jEYsytNh4JilsAscZRqKOVRWxDGgkvdiqU1qptBZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDNqEyLyADAFLcs2wmfQX4/f3VfBHjJPQMFVvrndtHk=;
 b=ONzKC1n2Qd/pj2SsktzauU719ws0zbMhhB4nts4jmmnGpAjIE/T/VM+f8YRtsiqpKcRIEpHCFmhsCI0kS6BbhFvKsJhYUB5ELKSSaiOTxF/UAkx9Yi1s7t46hL76v2FdzIHkPGMlxPFqZJKArRYaYdKygrUBv7dBKvZXntrky98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 14:32:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 14:32:52 +0000
Message-ID: <abf398ec-ef1f-43aa-a209-c008085bc206@amd.com>
Date: Thu, 8 May 2025 15:32:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 21/22] cxl: add function for obtaining region range
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Zhi Wang <zhiw@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-22-alejandro.lucero-palau@amd.com>
 <aBwH3UjxOpJel_xh@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBwH3UjxOpJel_xh@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0262.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce63086-62df-45db-6bbb-08dd8e3d3719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2JVSWdiRmZERml0bHNJNVhmUno4TmpEdTlVREEzcjRvSUkzZlBqNDdHWWdT?=
 =?utf-8?B?UTdFc2F2YW1pMjZ3Zi9GRVQ1RW1hQ3NWdjArNk42SUlVMzRVYWVOajcvVk5B?=
 =?utf-8?B?NXlMNGhVRllvcnJPU1VjUkw1bEQxR3VHdk05WnpwRWpRU2ZqdnJKWm5lSXdk?=
 =?utf-8?B?cDN6L1ZxVnFvL25OdVJua1h4dzljcUoyS2VaOHBNMnhXM2ZySGZ2QXE4ZXRr?=
 =?utf-8?B?UDc0U0YzVWhQbTdzVGJ0d2NSYzU4S04wKzZXTjJnTmRIZ3lPTVBVREJZdVlu?=
 =?utf-8?B?akloaDUxdXJPRGJ1bkNOUTNQRWQ3SjdEcXllMURQSmpKWndQdlh1Qi9kVHVO?=
 =?utf-8?B?VUpDVWtncFZBWVA2YmVDN3hUNS9meWR0S3orNWhGMHg5bkZ3WXdKVmgxbXMv?=
 =?utf-8?B?MnUzRXJCbCtETlBjSnI0bkN5amlKalBJbkJXazEydkd3RXY1WXhYblI1T0dB?=
 =?utf-8?B?Z1M5ZHJBWEFHTHFvb01Zb0lqemRBcDJhMDR5U25OUHZ4Q0Y4bVVhbys0c1gw?=
 =?utf-8?B?NWovVldhTTZKdWRuV2dGZjB4RFBaYlZxL2E5Zit5blU1eHNydTEyb3ZoOXB4?=
 =?utf-8?B?blVPNCs4QjNkZnp3SzhvSUZRd3pUODNEd3lVQkhwUmF3UFByaUs5bVNQdWZR?=
 =?utf-8?B?QkQwUmJ0RGN6Q2pDM2VveVAwQ1p3blU4OXVvdDRDTVJON0dXU1dmaHBkcjVq?=
 =?utf-8?B?TjFHc244YlJjMDgvNi9IbUloQkZ0NDVNM2hyUTVVbk9SVXZ0b0VlWThrb2JU?=
 =?utf-8?B?Y2tkWitmaEI3VmVEVjhqNXN1QnVaWGdkZDNYM2xmNXByRlNRNmZLLzdzUzdV?=
 =?utf-8?B?dEJYbkJKK21IVGtYZFREaUI3TlVTd1NRZXVtZW5wY0RTRDRlblRjemcrTDFi?=
 =?utf-8?B?cHc5Y1dMUXo5a1BkRkJ0QmlUbXQxRHY0bFpIVnpIL0hjbzJqeDNIYmdxYTBT?=
 =?utf-8?B?dzRJRUpEY3NSUkl4RGVVc3JBU1liSURBTHZRelRHYXJHUFhzOEVNUk50RFJM?=
 =?utf-8?B?SXE5R0QwY01raUNscllMTnlUSUtlWU1ZVitscTVYcWVpczdvZitENzBReVdF?=
 =?utf-8?B?L3VBV1RoNlpGc1BpTjN1ZG44WlRVNnZJYlBvb0xtY0lSTThnNFJMby95bXZs?=
 =?utf-8?B?WUEvWFpoczU4T2Z3S0h5Q2d3c1JrZ0dlY2xBTzhzTXB4TnZUVHNjaWsrOXVl?=
 =?utf-8?B?NXhJNnI4ek1aMFdGZU84eXkwR1ZMWlZjYXVacjBWSXJ2U1pGVEJPUzlxK3ha?=
 =?utf-8?B?a2tobjhsVUExR2pFdHlHbWxyalBPUUlQSW03amZIQ3BCcCtrTkpOeVVhb2c1?=
 =?utf-8?B?QmNURmM5bGR0bzU2S3dpMm83Z2cxQThPNjUydkVlMCs4blhaU08yV1ZBRXM0?=
 =?utf-8?B?Z3ZxQzB5ODFyUHhXaENwemwyeUVEeWpGdFZUdEIyaDVMYUFqTm4xQjJlNXdG?=
 =?utf-8?B?K0lSNVMrOExScGV6VkRPbU9OT1crc21jOHR6c1hpQlJoY3VjSXVvRTN5UVJ0?=
 =?utf-8?B?UFhsbUNZbnFmaTlaSjl4cDVBQVg3T1hiMFcxd2RaNzJHc0ZKSUwrc0FXUDZx?=
 =?utf-8?B?QmppNlFiYnF0T2VRbkhpR0lzcFUxazBuZnU3NVRMaldlTmFaN2p1SEFvSXg0?=
 =?utf-8?B?QUN3SDBPMDZVRHV6dm90Q1didU1VZVIxWFVvS3NLRktSYWFpSmh4ZWtPREVt?=
 =?utf-8?B?blh4ZmR0aXpZMW9YTlQ3ck5rZm9HV3BpNkkrSzcweWJLLzYyR09YREs3SnhS?=
 =?utf-8?B?MTRYK21DVitxWUMrM3hJeDRBelNNTVVzd0ZVTUlNVldOVmdEV3V0dnNFTnA1?=
 =?utf-8?B?dkpmd1VibVhmZEM5OWFqZGlCNVZTRmFac1d1RGl4VnJnZTZwbExaUmE4ZFgr?=
 =?utf-8?B?NkNkdHgzUWRuNXMyaGNJY0hMY0dsS09oK0ViZ3d0QlJhbm9IMjNqVjR4V3VL?=
 =?utf-8?Q?1qB2lwWc8N0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHVnUk9ocEthT2JTRlFFM2dJazRiTjVVT1ZLVUg2TnZHSlpJK09TckIyT3hC?=
 =?utf-8?B?NGs1ZU1EbTdHL2oyY3RkSzdMQTEwTXNPZUpxTS8wWE5kaExwTUdCNThqN1dN?=
 =?utf-8?B?VGtJeHJJN1Q4anAydTFTaHlja2VraW5LYysyVmNqYVVDeUJkMTBIUUQyNVpm?=
 =?utf-8?B?T2c3d0pEOHBJUEk3MkZFYWNwaU9mbmdoVmlLOW80SHNhTmRpbGV2MWJ2RjZu?=
 =?utf-8?B?dTZYNEZ2TVlLODBHdlkrczFLVUJCZG5xclpCWGJzWXlmSnFFcUNESkJRTDBC?=
 =?utf-8?B?N2pFVXVmL3c1VVRFMTQ1Qng0N0RTN2pnblhxOGtFSytqRWEyTGFjSm41NEtW?=
 =?utf-8?B?WTZoWklPL0FvakdiSTEyQUlMOUgyQW1IQ1NIeEo3anZiczJmeitld0c0LytZ?=
 =?utf-8?B?eVJmc3ZsaUIvSWNMQ0daNnMwWXF4RFd4NFBEWURteWZUcHZJWGM3em43Z21W?=
 =?utf-8?B?WndMWk1VVkw0N0hFNnF2dVMwdm9nKzBQZTR0a3JSSHVYMUZkRXVuWWtZYmx0?=
 =?utf-8?B?YzM2YkV6YUNjZjY2U2tSQW5qYmR3SDN3dmd4RFBhSndKSmdmM2pjL3psV2xF?=
 =?utf-8?B?Mk9rOGRiT1VudThzNzZMbEQyWHZvR2hEc0hhem4zcWRZdU5GTFcrMm9hRE9v?=
 =?utf-8?B?RVNCazNqRmpBMDZ2eXZhQXB3RlV4SkdUby9TOWsyZi9GbklpY1BDdGtSbUF3?=
 =?utf-8?B?WDJza0tnSHh4WWFpMzliR0RGekdCTUNCVjUwbW03WVY0TnFBOHA2ZEFtSmR3?=
 =?utf-8?B?OVl3dmhxTTdTYXNjdXByL1JyaDcwWVhTZk9hQTg2Z1AvTlRhRnp4ZlJ5Z3pw?=
 =?utf-8?B?SGx6Ty9IZmd6ajExS2xYUVBFYTFRTUNXeWVXR3VZakZiSG1XNzBIa0l6emhw?=
 =?utf-8?B?WHlGMTJjY21oRWtHc3BVditXdDcwVW01bGhDeHRSSStwSWpaSzZNMW01QmZo?=
 =?utf-8?B?Y0sxa0IrYWVicWdPVFZTbGFSV2dBM2oyMlRWNm1CRU5FLzh1dkpDWG4zeHNr?=
 =?utf-8?B?cVh3Z0V3cG9LbUkvMFhFSjZXN3JxeW01Uld5bHhjUXZvc0pWajRVMlVVbW5D?=
 =?utf-8?B?K0NCRXJOaHhGVnp1SVVhQmZvV0ZyYnlsTEVZdmJUbkJ1ZEQ2SEZkY2lFY3Bn?=
 =?utf-8?B?K2pSTWRWeGo3TTdVSXJoMTZuZmErSTlmYXBPVGlNTVgyUnFXZDQvZFQ0cjQ4?=
 =?utf-8?B?V20xS1pFYU5abGxpTE0zTmhKeDIyaGU5azF0MHZqTEpkcU5TanVOakcvZExK?=
 =?utf-8?B?NXRNck1WQUd4bWcycG5RVmlaQUppbVp3YVBUcHArcVBHaUFaV0tQMDVlOTlW?=
 =?utf-8?B?czUzRUpKTWs1RzhHMXFWWU5VbllNT1EzNDUrT1hTMmlxbld6TGxxK0YrS1Fo?=
 =?utf-8?B?WUdJbHA5N1lhTnpXbFRYbjhyOUNmckYzUXRwRmRQSkxGR1MrVnprd3JkdGNY?=
 =?utf-8?B?V3hoU28zRElnSUozVnVDYyswNjlpb0VidXVoQkF4Ti9BeVEwUXVlTDMwVDg0?=
 =?utf-8?B?U0twL3BxQjFnWkVJWVJxcXl1RFhqM3NENU14Rk0wckdmSE13MVlQMWFiV0xP?=
 =?utf-8?B?a091VnBZWlhIWlJHeDNLbjIvSzZUTzB5ZUVjLzBZNDZqclp2VXNXUTFpaWp0?=
 =?utf-8?B?MmR4S05BeWZxQTA3M2JPR08rNnJjQzcySnlqUmMvaVpXei9CenJXWkVBVS9o?=
 =?utf-8?B?ZnVkczIzbVE5Nmc2TXdzN0U2dVIyTW9GMWZqdE9FZ0NFaG13WlRsYmttOEND?=
 =?utf-8?B?L2p4SlAzMkJnL3N4Rm11Uzh5cHRGUU0wYzNkVjZ5dmhHRzZ5S3J6UEw2Yzla?=
 =?utf-8?B?TTYxUzRBSzlQeHRJRjdHZlFvZUJSRjRYY3ZYd29oSUhxeTlJM3NDdGplcU5Y?=
 =?utf-8?B?VGRXVzN1aFJWZmxKSzAxa2RMRHg4WVlDQ1VMRTRDc3htZ0dBbDdHMENYbCto?=
 =?utf-8?B?OFJHQnBFb3pzM1I4eldwOHlOWFpDbmRxYXBkWUwzeDJaRFY1NGZFYktFaFBG?=
 =?utf-8?B?bmM4VGVUS3RPT2QzOXd4VFVmSEJrejI2cWIwZ3E0ZVlYbFFQNGYyT3RQT3pP?=
 =?utf-8?B?VWhZWmlJeDRYMnZld0RxbVQ2SGpxOERKQ1Q1SU9VSno2ZmNXdWRyVW9ya3RW?=
 =?utf-8?Q?hYv/e+RsviMcVE3UagTAu72Mn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce63086-62df-45db-6bbb-08dd8e3d3719
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:32:52.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmfxJT70ht7qCb8DaBr4jgXFv0+1gzN1ueHYD4DYovgC5fm4p+y9OzUoPuI72lu0J4JX4veFeXlQttcmh8mDEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548


On 5/8/25 02:24, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:24PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A CXL region struct contains the physical address to work with.
>>
>> Add a function for getting the cxl region range to be used for mapping
>> such memory range.
> Worth adding that it is being exported for use by a Type 2 driver.


Sure. I'll do so.

Thanks


>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 15 +++++++++++++++
>>   include/cxl/cxl.h         |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index cec168a26efb..253ec4e384a6 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2717,6 +2717,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
>> +{
>> +	if (WARN_ON_ONCE(!region))
>> +		return -ENODEV;
>> +
>> +	if (!region->params.res)
>> +		return -ENOSPC;
>> +
>> +	range->start = region->params.res->start;
>> +	range->end = region->params.res->end;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
>> +
>>   static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>>   {
>>   	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 5d30d775966b..2adc21e8ad44 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -271,4 +271,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   				     bool no_dax);
>>   
>>   int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>> +struct range;
>> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>>   #endif /* __CXL_CXL_H__ */
>> -- 
>> 2.34.1
>>
>>

