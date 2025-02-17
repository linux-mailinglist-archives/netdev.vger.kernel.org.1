Return-Path: <netdev+bounces-166991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6CEA383E1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E0F162F27
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63021B1B9;
	Mon, 17 Feb 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zvpKAYLF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687223C9;
	Mon, 17 Feb 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797544; cv=fail; b=QSCMj2U0TlMeGPpNiJI1EwEWgek+QJfuLom9zG/jbgYb8fkylyWJE0623YvCKyL2EcN2PHusUgt1R8F+rRUqwNvMx+OGB66z8ybV1ExNTcD1StBLbECRh6c9I9rYMePnG7wb1JK05apXKijPA1MBrXNpEmcktqtC+SluxN8pymk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797544; c=relaxed/simple;
	bh=5gW6vQCLf/NbbR3xiYsXSJzQWhqtEmyJjKfYzEjtAsc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F35ouz1iEPSXdBepHcerTzGMwaZEXTpG3ZcLKyVViSReSPwtgcb3fmmHIvAzhXklYuWSRUamhcq0HgsyDH7C3AF9bEnkHQQCgJ6PzlTHbIPFHxTIhkYkBmxcYTbcngzd1dJGh5iA27M85wbSCSHVcT4J4yl0tO7xtkTeKiOFF44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zvpKAYLF; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3V3cJ8gNHq6wF3lBGC/UF9sVAZfUcEJrQkoTdEMzOIuqf6gDDUzrqfZjklYz6HyQi6XUD0+5Z7cDMIePK14E4v6tJwjvhkSfW7/xTPX0/Kw8/rX+C9Asac/FpBOuuFpoDlyOTBMG39IDeEfNstLTeuxexRmtPTDz1DqXaNGfnYxgaOHmD7P/a5sUJYWUck8uNGR4+EbGRPuX725JKHVZuN3CXRyOU1Vy5S9JcWNT0BMNGktSQ3fSKNZ7zBIKV8LNf0WnqJ+eW58SJySanRg/+mP0pRlugVyUshZye/U8yeHQ12nIlvhJGxBY1q2Yd8G79hJ2/s0n5zcXcGO6CQ4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAFJ8vIprW0W2ecZrwHurtRFzW9RxQ4VFpEnG6Mwz1o=;
 b=l05/8x6esE1YIWZII4mNBi/o5kDTcfxviOoe1KgSPe2KDTTMyEOolfAgZuIVyN6D9v+0FK3TtM6URNz5huhSskBSr2TNE9wAPDs2TGDqKbtzc7EgufStZaQLVdkvy/F4quWOYX25cJwjGa9faQiDaYWxn4yfX8r4Rq2pXuVr6iODOjnRnNU3gHPPeGznPzHtVGwVUnIVgTBB3wQVvpL5cFBDsCCCf+Vvx7jlIN1yCyVwln2fyLRMNdytOtMrVJWLubm+TmFJWlcoz9lXx1vrLyWijlU/CUdvffUlBCmbeg52EVDJuq0ibSSREg3oSHEhRXtA7loE6ihHw1cKOjFpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAFJ8vIprW0W2ecZrwHurtRFzW9RxQ4VFpEnG6Mwz1o=;
 b=zvpKAYLFPmqTI42bjLuCBxPnncSpAYK8awvDBmfFRTsufIDIkHshf2qt0N4k0P5SdKr8m8EOcVu1Cjny7KL86IMoMApDg0m2GMN5Up/5LgK0Dh7kznc7QmGC5hTT9oaBJkI+UymkkdcGgqlrB38y1/fu/lgp9kHoFP/jWIKMvEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Mon, 17 Feb
 2025 13:05:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:05:39 +0000
Message-ID: <c363242c-e2df-4440-a65d-1c36c383ded8@amd.com>
Date: Mon, 17 Feb 2025 13:05:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
 <67a50f7fbdfb_2d2c29447@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a50f7fbdfb_2d2c29447@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b756041-57a2-4057-fa56-08dd4f53c703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVpSR1piWUFKQk12WDRnMjJiTXQ3Z0s4TEZXYnV4SXFsY3VaNHM3TUxONEFt?=
 =?utf-8?B?NXlhdGpXdlFzT3I1Ym5QcDNEelRhS2JCMXMvSHU0dVNYRFYyVk1OaTJBTHJM?=
 =?utf-8?B?Tzl2dm95T2VoYlIvSktnenRFT2ZObUhKdU41QUxIVE1jNHVhSmdJbTZzSEow?=
 =?utf-8?B?a0pUVmlQQ3owMDZFWnlOQVY3M0c2YzhVSnRzaWF5N0c5K1NEVGNucm5xS3lW?=
 =?utf-8?B?dk9YMGIwV3FRbHNHRUt1djRRak1aV0F5TEJwY2h2c2JZNEhNbjZHWnZGbWhB?=
 =?utf-8?B?Q2RwMFBDRUJzYmZKbUhRbEIvcGFDcmNKeWZXcEIxeFFEeWx0TDhkdFk5RHpW?=
 =?utf-8?B?Q01FcUJodk1EYks0bnl3eGc4MFNFRzJGaUJUWE5Ba3ZVaENZc2xuWW5SWlFo?=
 =?utf-8?B?RXduQlZhSFpwUXBuVDVqK0FMLzM2ZHVnVXR3YjFBM3NOYkpRd1hrSFJIakhN?=
 =?utf-8?B?aTZuSU1lcXpEZFViRG13Sll3dlU3QjBpTSt2b2VkQVlDcEpydkdaRDM0azJT?=
 =?utf-8?B?dm1ISjVoTjZMWXVIUHc5bHJMZ3VoS1UzdUNqV24zblUwN09CYlRWYWlPNmxQ?=
 =?utf-8?B?dHRvMnFzd2VZS1FWVGRSOStOU0RNcHU1NVVTODdjUS9OVG9QYU9MRjRrME5G?=
 =?utf-8?B?QysxeU1UdndqUGtYQ09tUGJjeUxCSmJQMmgzSk1LR0FmN2ZLdVlianVNTlpE?=
 =?utf-8?B?Wm5ZQ1VpZGkwZ05mNEZBVng0dFZRVmYyZ2hzbDg3L2lHQ0FQR3BhTmJoU1ZB?=
 =?utf-8?B?ZnlvWkNiemcvc2NCU3pwa3F3c2M2dTBWTUZBMjZCZGFhRVVVdWhqOGJXN3R4?=
 =?utf-8?B?ME1ndWdVSU8xUmZYUktDbzIvM1RWcjRFVDJhOW55WVBtTEE1TlVodU9OT05F?=
 =?utf-8?B?ODRxcUdtczdPT0cxa0lnVk8vT2FJYXd6RUNtblVjS3ZPMVNqZmdOOGxoNkUy?=
 =?utf-8?B?dDdZTVFjdVdKdlZ6S3ozVEIwT3h1cXJpWjZjYlZlNWcwRFRZWFZqVUtIMHlR?=
 =?utf-8?B?REtuaVhScWZKRExiL0hjMENuc3JHNzRNeWxVbXpNZHFmam9rY1BoOFp3b3Iz?=
 =?utf-8?B?VlNVTEJUWlNBTzJZQzZkYk9MV2RVOGQ4Ty9PNUtsdUdLNEYwMml3ei93T3V3?=
 =?utf-8?B?cTJGM1dkakRxNFEyVFZlRXlTSjVDMW1VNmJCL2ZQQk5OMG1kSFlBa3ltYlJS?=
 =?utf-8?B?SWNXR2t3dUpCTXF0alQrYSs0RkltcCs0czVkdy9xdS8xL2ZwVHE2R1BXbVJ6?=
 =?utf-8?B?K25VM0dzV2RrQUNqZW9TcGYzdnBWVlNWMjYxUUVjeDF6cVFYcWR2ZE9ERE5H?=
 =?utf-8?B?anhoOG9zaW93VThKR3pNam9oNHpVRVJBM1dKTVYycnFiRHNMT0hFSVJmSFdq?=
 =?utf-8?B?SmxaaTFZY1FzM1htTjZCVktXRHpkTmdYNnpuYVErY3dWb3UydENYdEpPeU5R?=
 =?utf-8?B?UGFONHR4KzQ1RkMvNG1TNFBDdzNQTE8rcUlGQlNCeW9BekltQVVWNURkem1z?=
 =?utf-8?B?aHgxTEw0OWpoVTVUVG5LbmlMeWhPTUtLNU9lK3I5cEs3K0pZRE1QVWNQVVJU?=
 =?utf-8?B?ekNBa2RUWW1LK3pmV2hJWjdGb3VtaWplOTlzblRqVDN4aDJmaGlHaGdLaWlO?=
 =?utf-8?B?U2hoSzRhT3EwQ1B6Y0FReWYrVFJEOUFEbGxZeTVsRHVyVko5dWxkK0wxaThD?=
 =?utf-8?B?MlhhZ0F6ZHNqd3Z0KzZ5Z2NhYmdlZzdWaFhjV3VUK3MvcjZLWDJGd2tGZDRz?=
 =?utf-8?B?QlJoaDhQcnFlVExidHBvNWlMd1lYUTlDVUwyLy9COWpQL285UThjZUgxNTBH?=
 =?utf-8?B?QUREVExKdjRTOWdvc3hMU0tDL2I1d0VyTXBBeFQzbkNXSW00UXhUK1k5QTE5?=
 =?utf-8?Q?4jUcquFKa7nYL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amhSRi9zSmtqWjlDM0tZTVdIOUhhNHVrblZ1c1N3ZXYvQ213UlM1Wkw2dTFn?=
 =?utf-8?B?UjJKd0dpNTdwaklGYzVtMEFyblRsMVN6bHFYS2R5bDFUQzEvL0ZHL0h3NGxE?=
 =?utf-8?B?dWV1MmRxaHJac3JOc2xURzZSb2w4b1RmYTZwYTMyeXVrVWdTUXEramdDWEhW?=
 =?utf-8?B?ZVdqUFBJUnM1WnlsLzFsaSt5QXg0TEdicWxSdEhXUGZaTVpUSDgxb3JSbTd3?=
 =?utf-8?B?VjRVVXYybVhFYzV6MXAzMmdaWjJha3E2S1pnTGVtb282L0p6T2IvdXVZUFEw?=
 =?utf-8?B?REV4anFQSFdJUzZTWGkwZHIzclVwZXNuY3h6MGFjYXNlT2lHOFZ0ZFB5R3hp?=
 =?utf-8?B?WVgrcWFNY0JSNGhTNW13NG1UdFB6N1NEVmRMNmp5Y09UcGRWYkFNaEVZTU53?=
 =?utf-8?B?Zmw4dElrYzBlbkhoSW9kU25YUCtja0FRaDRNTXlxb04vQlQ5NWp3YmlOSTM2?=
 =?utf-8?B?K3Q5bFlZWi9wN1FoYXUvaDdvV0Z5NFZoRjkzTTByaC9UczYxNE90emxwZ0JD?=
 =?utf-8?B?MGw1bXFDdE5XckRweVFxSkRnRFU2cmJoSVlaemtDVUFnM01XQytJOHZWMnh0?=
 =?utf-8?B?QTdtNlNGdmI1NEJjeDRoK3R4K1BOOWJIVU1adWZ2VFQwM21Vc2tFYWFKZDdO?=
 =?utf-8?B?UU93ODVaU2FzK3N4RVlSdDhuTzlRMzJuLzdnMGdLTmpONW1obng3VlVjeXRZ?=
 =?utf-8?B?MnJGa0djKzRaTUhXYi9lSzVYOFJOM2szNHZEcUNrNytIZkpMR3plTnYxWTd3?=
 =?utf-8?B?dkFiYU1QcTNYMS9MMjNYeHlheDYvR2JnMjVTbVJucXhqdzUxbGxVWHg0ak9G?=
 =?utf-8?B?MkdLbVlrQXZ3aUNEbFpxVWFlYkZ5eG5pNFIvOThCTEVtSmNHejg0ZmxRUGtm?=
 =?utf-8?B?dlJsd1FuWmkyb0wwbjJqanVINlBSTDF1WVI1QUYxOWlSeDE4cTRSUURRa016?=
 =?utf-8?B?RDZkcHpCTjZrV2ZveWczdUliM29wM1M4QzUzM2oxSEhRUzJyM01NcWdhQklD?=
 =?utf-8?B?em5ERTIrdlJCakZDSk4zY01rSE45MWx1dG9tdWVvSWVpOXFqMC93dExnbU5t?=
 =?utf-8?B?OGpjWEhBZm1ma3l6Rm5zY1FpK3lmMkYxaWZYSGhqOXE4c0c0bWd6ZWwwSlNl?=
 =?utf-8?B?QXJyb09TMWFvdkhJaDAvVTB4aFl1Q3VubWE1RGEyTTlNZnhJWXFvSU1Eaklk?=
 =?utf-8?B?QUxGWE1uT0k2SkR5d2VhbXdaUmlIcENGWUR3L2ZPelJTNW1zcDhYYmNPa0kz?=
 =?utf-8?B?WUpKS0p3WS8wempXc1dFZUJRaE5PZzJuOUdjY29iVWh1UHM5MnZDRW94UUFv?=
 =?utf-8?B?amlXOHR3N2o5dVZUbzhSdUNDMXYxcWFMQVRyOGpwQ1prS0lkUkhDY3J1TXRX?=
 =?utf-8?B?VEVlVFp2OHNKT25vUkQ1cC9HL3NPZ041MFEvQVFtN3lISFhJMkp1L0dWa2ZE?=
 =?utf-8?B?VW1vZENWbDRaS09JbXJrVmNzWURJUmJCa3RNWnFFNjBhVmVCRUVYSVRNdGtN?=
 =?utf-8?B?cWZ4K3I5bjRpeW9OQ3k5dUl3NENTWkdwUlVXUHBQRVZqMktxOGJBV1FjQjln?=
 =?utf-8?B?ZHFaWCtIbWRteDFHeGJIYkpXdzdwUm1IMTdzV2dIWVdUNzVBNGxaU0VpZUd4?=
 =?utf-8?B?akR3Y2xuWVJRMHhMZnJkbFFRZE9FTUVjNy92b1BpSXkwS0RrQkx6WG9LVFdK?=
 =?utf-8?B?NENKQVAybFNzZVo2VFRsMzc2UjVqNjBpZEdNNUxPN0NnVjF0ZFpPdVFNbW13?=
 =?utf-8?B?ei9xcmRBV1lzd0xzaXRaSVp4QUYrc1hyUFZ1T1VlRXQ5U1ZrZ1pNR2JJOG5E?=
 =?utf-8?B?U3BGRDNrMlFuZllZZ04zY1lkUWc4UHJvVTQvTkNERHRCUTliVjdPY25IVE5t?=
 =?utf-8?B?KzFCcGRMOXl4NFhSY3VDajVnUUxGbzFIMm4wQU1ObzJkSDY5dy9FTE5WTTQ0?=
 =?utf-8?B?UFlLVFo4SkRDQ2RyNlIwRG1ydStRdUd3bU9zakRDN1ErYS92T01iOUVOczB3?=
 =?utf-8?B?cFl1MjJ3d1djQmxFcUFFRDBhSS9oMy9wR1BXZXUwZm5ra1FrMkp4N3hzUlFr?=
 =?utf-8?B?eUxtSllhMEthN2dMOWYrUVZXalJTUTVEUTBDN3lDNzlieWt2SWI1TEVpL2xx?=
 =?utf-8?Q?N1Qw6ILU7uEEgn4mQco7fWPE3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b756041-57a2-4057-fa56-08dd4f53c703
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:05:39.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBWLUci+t+q4AJrU7EZIdQtREaU/ciAQ/z3nZ+ztTkzMwlQHW/CTtFWQmWZZIcWVPYU0vtxQU9TLRr0DhwjxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031

On 2/6/25 19:37, Dan Williams wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for Type2 support, change memdev creation making
>> type based on argument.
>>
>> Integrate initialization of dvsec and serial fields in the related
>> cxl_dev_state within same function creating the memdev.
>>
>> Move the code from mbox file to memdev file.
>>
>> Add new header files with type2 required definitions for memdev
>> state creation.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c   | 20 --------------------
>>   drivers/cxl/core/memdev.c | 23 +++++++++++++++++++++++
>>   drivers/cxl/cxlmem.h      | 18 +++---------------
>>   drivers/cxl/cxlpci.h      | 17 +----------------
>>   drivers/cxl/pci.c         | 16 +++++++++-------
>>   include/cxl/cxl.h         | 26 ++++++++++++++++++++++++++
>>   include/cxl/pci.h         | 23 +++++++++++++++++++++++
>>   7 files changed, 85 insertions(+), 58 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 4d22bb731177..96155b8af535 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1435,26 +1435,6 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> -{
>> -	struct cxl_memdev_state *mds;
>> -
>> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> -	if (!mds) {
>> -		dev_err(dev, "No memory available\n");
>> -		return ERR_PTR(-ENOMEM);
>> -	}
>> -
>> -	mutex_init(&mds->event.log_lock);
>> -	mds->cxlds.dev = dev;
>> -	mds->cxlds.reg_map.host = dev;
>> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>> -
>> -	return mds;
>> -}
>> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
>> -
>>   void __init cxl_mbox_init(void)
>>   {
>>   	struct dentry *mbox_debugfs;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 63c6c681125d..456d505f1bc8 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -632,6 +632,29 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec, enum cxl_devtype type)
>> +{
>> +	struct cxl_memdev_state *mds;
>> +
>> +	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +	if (!mds) {
>> +		dev_err(dev, "No memory available\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	mutex_init(&mds->event.log_lock);
>> +	mds->cxlds.dev = dev;
>> +	mds->cxlds.reg_map.host = dev;
>> +	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> +	mds->cxlds.cxl_dvsec = dvsec;
>> +	mds->cxlds.serial = serial;
>> +	mds->cxlds.type = type;
>> +
>> +	return mds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> I was envisioning that accelerators only consider 'struct cxl_dev_state'
> and that 'struct cxl_memdev_state' is exclusively for
> CXL_DEVTYPE_CLASSMEM memory expander use case.


That was the original idea and what I have followed since the RFC, but
since the patchset has gone through some assumptions which turned wrong,
I seized the "revolution" for changing this as well.


A type2 is a memdev, and what makes it different is the exposure, so I
can not see why an accel driver, at least a Type2, should not use a
cxl_memdev_state struct. This simplifies the type2 support and after
all, a Type2 could require the exact same things like a type3, like
mbox, perf, poison, ... .


> Something roughly like
> the below. Note, this borrows from the fwctl_alloc_device() example
> which captures the spirit of registering a core object wrapped by an end
> driver provided structure).
>
> #define cxl_dev_state_create(parent, serial, dvsec, type, drv_struct, member)  \
>          ({                                                                     \
>                  static_assert(__same_type(struct cxl_dev_state,                \
>                                            ((drv_struct *)NULL)->member));      \
>                  static_assert(offsetof(drv_struct, member) == 0);              \
>                  (drv_struct *)_cxl_dev_state_create(parent, serial, dvsec,     \
>                                                      type, sizeof(drv_struct)); \
>          })


If you prefer the accel driver keeping a struct embedding the core cxl
object, that is fine. I can not see a reason for not doing it, although
I can not see a reason either for imposing this.


> struct cxl_memdev_state *cxl_memdev_state_create(parent, serial, dvsec)
> {
>          struct cxl_memdev_state *mds = cxl_dev_state_create(
>                  parent, serial, dvsec, CXL_DEVTYPE_CLASSMEM,
>                  struct cxl_memdev_state, cxlds);
>
>          if (IS_ERR(mds))
>                  return mds;
>          
>          mutex_init(&mds->event.log_lock);
>          mds->cxlds.dev = dev;
>          mds->cxlds.reg_map.host = dev;
>          mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>          mds->cxlds.cxl_dvsec = dvsec;
>          mds->cxlds.serial = serial;
>          mds->cxlds.type = type;
>
>          return mds;
> }
>
> If an accelerator wants to share infrastructure that is currently housed
> in 'struct cxl_memdev_state', then that functionality should first move
> to 'struct cxl_dev_state'.


If you see the full patchset, you will realize the accel driver does not
use the cxl objects except for doing further initialization with them.
In other words, we keep the idea of avoiding the accel driver
manipulating those structs freely, and having an API for accel drivers.
Using cxl_memdev_struct now implies to change some core functions for
using that struct as the argument what should not be a problem.


We will need to think about this when type2 cache support comes, which
will mean type1 support as well. But it is hard to think about what will
be required then, because it is not clear yet how we should implement
that support. So for the impending need of having Type2 support for
CXL.mem, I really think this is all what we need by now.


