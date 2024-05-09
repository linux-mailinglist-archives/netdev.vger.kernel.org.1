Return-Path: <netdev+bounces-94914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FD8C1017
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B36A1C20C32
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B014B95C;
	Thu,  9 May 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8hjXaNz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D613B29F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259988; cv=fail; b=Tg54WNzg7Jn0rCxqBn4st45GIJuENq3kOMsLw6Bip1uWYzARNQPeIPr8wLVG3l/QhBOpsa5grybNsy8GFgMH/fniki9gck9POelMzNs0uRv4uKhniYfwSTYVEKGtwGlJlpjMskHdH6NaKrT27Xe2AgeTJk/xUQH/o4j4x7NDT5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259988; c=relaxed/simple;
	bh=dKif5WANHR9/ReWffV0z2a8siqIiBy01xPJdb8Zhvns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fqF42YsAV0J1TfxS1akR+bl5Gi0dGDdoHzYqsELr8mGK8jA5YNGipcGojp8OgiVBqgpMo4krXJuX2P6v4QAGnQLPqas42Av6+tL5R4oDZr8RChiUfVopED8e4FJGvNr29KE32P5gtDqe44i+oAYBKyIfTrdedXFFTjlXRiVkdHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8hjXaNz; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHVeYXWa4nyyL0QK7xUcUYcJhG6JsIIbI5CvVZbwmrGhUpPSIPY1KV2z6nVxkE8+jFTYZpKRjk4muXV9Le6SAM8VLx2jEIGgj3mw5qa7GPFKUZ0/OA9yKZ++VEB1G8Z8VudhjFSrbskQlkqEuLlXUwWd/woB4P+0qSfqfN0TukE531iu/J1PcEIo08jT3KvWR4nV7gLA+AH+dppiibwk/pSy8j1TTyH3Wb7rkhf8WCxgV9Z9VA0nPCwm7BSc1uZrFWsPy+agAIradJ2f6Zb9rxcE/ssoQ1M/7PxqQtxiN1wt6pcvCXt992PzgcpskBGkfSBI8CRBb5PetLf4DcUAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwoFwbLObslMCP9fEwl2Kq48BCkiV1tH63lzTWGZNvk=;
 b=aAQ750iMJzVe+n/nktdBNioehMNjH/f71Xqunwws1tQGplkb1d1t7vKiS5AuEnxiZ/o812hxjeswsql9Aq6DMG9l1pHx/jUalvAponbLXIRkhpxg1UC9TnU0jVo/fwDcdiQFjhrthmu4ZIP8crLb62RkENziPnHYeWxNkJpUeTZ6vEDdRkgE6PRB1QV2tll3lEnxzpWwY7F7gmIsv6ahRfMdDvOqeOllc4jg1K9DlMikgEICBNX7srD4RmgDUdg2VJVXp58DiMis3M5TnXN/p0XCKeWgLN6rn27aobfHNeJvq4+8slUubtGqQGGPOVdQUBEKBwhCz+9IJQUcFWCenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwoFwbLObslMCP9fEwl2Kq48BCkiV1tH63lzTWGZNvk=;
 b=V8hjXaNzZgmnuZKRi6P0DJJhqaBJrkCHDHweZi1Lv2Z9vQrm4ROnMKL4r/F2YXAiXFoLK1LzTubXEb9xUaV6Jv5o8WNjadoMXFwoOyjuhhLFU2FMwKkJ7SZRkCGrrFqH7k3ieu38geE6MyF/b3WDsJYWe/Ley0TMaoBP5XJqgcLUjOT3duf3PJOI8ebUqkNgYeprA28Ne79KzMO1wZp9pm0gklasVr4Md/nd0cFSgQYT+vRgF9H3LKw6haIWzHS8Y29hZSi6eclnCyjcJ6CH96VTWhSHVPqrVpkDkXBvledem/B3nnjPeOcKpF0QLUI0c+oqFOscmyOsSdQp4JKclA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 13:06:21 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb%5]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 13:06:21 +0000
Message-ID: <8c025155-7bbc-40a9-a4cd-9670d35193af@nvidia.com>
Date: Thu, 9 May 2024 06:06:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: cache the __dev_alloc_name()
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: jiri@nvidia.com, bodong@nvidia.com, kuba@kernel.org
References: <20240506203207.1307971-1-witu@nvidia.com>
 <03c25d8e994e4388cb8bfd726ba738eea3c4dcdf.camel@redhat.com>
 <103033d0-f6e2-49ee-a8e2-ba23c6e9a6a1@nvidia.com>
 <6891de8fbc542340d157634ff1fe6701443995a5.camel@redhat.com>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <6891de8fbc542340d157634ff1fe6701443995a5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 87234f51-6af7-469c-4822-08dc7028d245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWNDeXZCZC9SSDZpcTdUWUNWaG5TUmdPNXNINDFDeWNHOTUzY1NMZVQ2cHFo?=
 =?utf-8?B?Z2h3SkRTYWRLSDQ3N2M1NElLcGJWWDZpRGd4Qy9HdFVrbUwvT0JXUEZXTnVZ?=
 =?utf-8?B?ZWRwRklaTFZKazFEUlU5WmFteHg3T3phcXZCbmJIRWpJUWg5ek5sV1hSZzQ5?=
 =?utf-8?B?WWZNZlcvVFJrRWtORTBCZlpFQUY0SVlJYUZKRy9mMUpqOTJCQnNzdFBIV0Rj?=
 =?utf-8?B?S0VXN2Z3SGYySzdmKzIyczJoMjdMTGZJakd3TEZFNFBTSGd6U2NjdmFlbHRR?=
 =?utf-8?B?dlhJci9sMUpXUnMrS3dWYXYrOU5TQVIzK0ZKV2RHR29NSThvWGJ4TjJ3N2Ny?=
 =?utf-8?B?c2hnQlNic1huWEp4bU1ZQTFWUWQzQUxwQ2dqaFN6R20vZlNIcVZEdTVpUlQr?=
 =?utf-8?B?eFlwbGsvcThZUFZPOXNjN0tkUUZxQ1JQcWVreE9pczQzd1dZcGxOWHJ5dkxq?=
 =?utf-8?B?eHAzcldSVEZBc29wT05IVW1jVklNb0prQk5yWjJZbU41aWF5dlpNVkdVRlRt?=
 =?utf-8?B?V1VIZkpaakluS2FrNTVxOXBEcGZhS1Z0SW1nUVRLejJmYmMyU1NXV2xuaHpo?=
 =?utf-8?B?NUhubC94S3ZqUEJEVVByNHdGMVJTSkpaeEFGelRCa0cvV0RWRE90ZHNLRFN1?=
 =?utf-8?B?T0dTZHdEZVVnZmxWREEzY21WVzFudDVYcDc3dlY0cnBDa2dEbjFBMFcvcTJB?=
 =?utf-8?B?cFl2ZXBEUGJxMm00eGw3ekpHVG9reVBMdFdPdTlBcVFXUzRkVTBEOHRFMGZo?=
 =?utf-8?B?NXo5ak10SlpmN1JtWUdxYVBvTW1PdUZhNjI3dU9IZ3JMbTNaM1EvTU5sNFNz?=
 =?utf-8?B?MGxUL2dPWWV0djd0Q2M2ZlgvdzNGU0ozZDhuMmFwMlVMVzY1TjFPVDI3T0hv?=
 =?utf-8?B?RjlkeGFSRXJKeHpyQUdwTXdrSEFmQW00U01rOU11YlJDOUJTYUtzUkhacGdj?=
 =?utf-8?B?ODgyemhabzA2N1ZCeG9ZdHhhTGFQaW9tVzBGS0lEc0FQL0F2V3RZbm9jNFhV?=
 =?utf-8?B?aXlEUVRRUmZYYjdQV0kySjhxK0JkTFhaTzZhVjY1Z0dUbk5VakxqNm5rWU94?=
 =?utf-8?B?OFJOZW03T21TWnJ1cE1YamRCMkhzTlk2TVB4aGx2dEgwVEQxa2dEUHFOOGND?=
 =?utf-8?B?VWlGZkVYeitCUC9NdmdEZnRFWFVmWXltWVVZY2ZlNStoM1BCckdPMUhaWU5O?=
 =?utf-8?B?amlFTDRMb3BxTWJPNzRZN2hBdVc3ZWZjWXMyN3hhSEw3UjRaZmx4YzZWdVB5?=
 =?utf-8?B?amNDZE02KzVQbTNQZkRYSnhHUE5MVDA4SS9vaEFZMEh6K0FrTEdMaXFFaGc2?=
 =?utf-8?B?dElRNThWZXZXdkNVMmJjQVFmK3Q4OVNVcmZwY1A5WFhad28xM0xCcmlYaEY2?=
 =?utf-8?B?ZUF6b3VGdjZhM3FDSDFCWXhmS0FXSVpwSHJzMHVhc2NBcmhFQWpOcDhQWUJO?=
 =?utf-8?B?Q3A1eXZBWnFkMmFHemcwWEdTTU5jSk11RVEzWFovRk5IR2twMXNpTjAzNGlO?=
 =?utf-8?B?eHVqcy9ya2FYZzYyemE4dDNtemk3V2RLeGYxSUZXNjBRckZyWHZoa1BiemY2?=
 =?utf-8?B?cTgyVkhiWTNtQjhHa1Mwb1h3NGVmYnFYOXpibS9HZ1lZYU1idFVpcE5lTEVJ?=
 =?utf-8?B?K1hnbmVUTVlFVE9VcUZSdFpKWWpHRWlvVTVjajQ2cG15OTNJcHNOWVVLaUwv?=
 =?utf-8?B?d0ludVg3MHpsTXdNc3RMUzRIZWdDeFNrbi9VOU1MVGV1VERWUU4wdmlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEh1L3JZQ2ZJVFEyTm9Lc05xUjRHMS9UY1ZocUw2b2hhaHpPaXVXd3JTRHU5?=
 =?utf-8?B?MU5wdHpBbmh2aW9ZaEFoVzZpbnJCUTJXYTF5S05nNzYvQ2FOVDBWODk5U2Zp?=
 =?utf-8?B?UEFzR1FPMldQdGl6dGRMeXRRQy9xbHh5OVVQb2xMbDg5L0VGR3RKalZPTVZR?=
 =?utf-8?B?QVZSWnZKTlRtNlEvTld4RmU1NkxJOUxSYkduWEVqWWJCbG1oU2hyamQ5U3JE?=
 =?utf-8?B?dFllVTN1LzdJRWUzRWdVbzd6dTcvOHJRZzI0ajM3Mmx5NElXS2NwL1VSUGgr?=
 =?utf-8?B?VDhnZk5BMTRFL2dveG1XQWlvUWY3NjRua2ZMcm4zdnFzdFNaNnBXK1kwT01Y?=
 =?utf-8?B?WUhSKytVOGo4SXZvaUQrTWc4THpyNFhBRCtxS2VFSzVydDFqdFlONnBCTEdO?=
 =?utf-8?B?VEJGT0FENXhnUHAyR2NkRThoZ2w0dUh1K3pBYjNWeVA1cFFOU3VJeHREbVkz?=
 =?utf-8?B?TzdzbDlnaUVBN0s4Tlp0TjdWeTluQkNSWFBKYUkybit4RzdsK2pEM3NCZGZi?=
 =?utf-8?B?VjZMbVRJMTJNWEVUZXkvWnFMbGRJRlR0TFZsazJLaDdNQkZPOTFtSFRVT09v?=
 =?utf-8?B?VmpyWVh4SDh0QWpmMEdpZFdDbXFEWFptMUY1OFVEN1R6Q0l3UzljdXFMVVJr?=
 =?utf-8?B?dWFMZHgzRE9xNGYyMkQxV3hFb0lOcStqTEtxdzlaRnhEbUtvWTBBaUt5b2wv?=
 =?utf-8?B?SGhwOGQ4TFZLOW9tMHhxL0x6QXE1OC82NUlFS3ZBM2dSd2tOYkRJZzdqNitL?=
 =?utf-8?B?Yjl6MlhzMjNSK0JjbEQzeDUvc2NVQjBTRFJLb2hmSVpMcHVmZW02SzVuRmFz?=
 =?utf-8?B?K2hqNGtHS3pJRzZsb2F5VkhVb2NtSWNKN1A3YXFsT0hKRGNxaXFTNmIza3lF?=
 =?utf-8?B?Z0JDSHZYQUZ4NU1TeXYrSlVQellVTitsM3VjNVZiQmtTWXVLakswMHlLK0Er?=
 =?utf-8?B?TEVsbERCblorSUNKeThaR01Jb1F3OCtZbnhuTkdPMGlGS3VOQnU0aEZBU1lS?=
 =?utf-8?B?YnFNY3NONXQyY2tjMDl1VmlKYVhnUnp3dE1NazVvU3JiTDNTYkRTczRCU3Yv?=
 =?utf-8?B?aTlIdkthVG0xV2RDL1BRTk5BQjVPdiszRkE5SXYvTXJDZCt1NkZpOHNjRGds?=
 =?utf-8?B?QXgzeDFCbEY1K2VJeVdraHlmZ0Q5VndtU3dqRnVvR24yTmFQakZSdTRVNldP?=
 =?utf-8?B?NlBXZUJjVm5vSC82ZlEyU0JHNUJlWEN4bDFvaWp5cGo3S3lGZWtMZ3ZHNmFC?=
 =?utf-8?B?ZHJCYnE5ZjZFYSt4NndocjBTYTlJSjdqcDd2ZDJ6Y0JOWVlNdUxBdlpweHBN?=
 =?utf-8?B?TS9NVzJzaVpSdmxZSER5QWJWZlVUL1A1QitCbGdaTW9YSE9tR3krTWVpWkg3?=
 =?utf-8?B?MnFocllUTEd3bXUzWmhRL015WElzbTNKNDFZMkZNVDN0eU5DRFRxeSt4Smt0?=
 =?utf-8?B?bG9zeEdaL2JJWE01NzgxOUR3RTc1TWZOTktqdEduTFZJS2xhdCtqdW4rbXd1?=
 =?utf-8?B?Z3FLZFJnMGJBeWVyRWxmRVZlQ1VYTFJXN1BEWEQ3SE5ZcVplY2NVVWEzT1M3?=
 =?utf-8?B?SnpzaktIZmphUXlkM1duOGZQOEhqZlE3Wm0walpOUEdtUTIwY2l3V2RXVmxN?=
 =?utf-8?B?dEQyQm9Fc3ZEd1B4ZnNvV3FnQWpsbHFhSzNzemxSRVkwLzdpcmNlRWdtK3cw?=
 =?utf-8?B?Um1nSlZ6UTJiVExSbWlzRS9zR3hXMklwbEZYUzNGOVFuVVB6ajIvb0Uwa2xn?=
 =?utf-8?B?Z3pRS0FzNVhXdjJFcVQ5MlFGbWxyUG9EN0tNd3lOdkhEWHl5LzRiRFIvVWxR?=
 =?utf-8?B?aHUwY3ZrdkltTWR0R0NyK2o0RmNHVU5qK0tuYTNhVmpiU0J3MEUrbGJaUng2?=
 =?utf-8?B?RkpWZE12L245WWdBZlg0dVZlZXJJdzNMQ09BT0RlSnV1WjlWWnNSTUdmeUdW?=
 =?utf-8?B?VXVtT295OG13cHVod3hnd0NKUFlhL1hGN2Vic1NrL0RyRllNZUZDT3Z1MWVs?=
 =?utf-8?B?NVM4am5nOTdiVTdVRzQrZDREV1BUbzJmQk5yeDBEdEI3ZUtFK0FRK2pEMEJq?=
 =?utf-8?B?RWE2aGc3TjVuQitLeGxLUzdjejJVclUwOTY2U1FETDR1eFZkb2E2cFNNc2pL?=
 =?utf-8?Q?yatwGBj+nzsgaWMdwWRp+9xUU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87234f51-6af7-469c-4822-08dc7028d245
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 13:06:21.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A21QECeafX+kVoTl2ClVOkuFSnXLyZ+5yQdCEBTaQLAzdwRgyksBCt8IPATM/RJS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429



On 5/9/24 12:46 AM, Paolo Abeni wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 2024-05-07 at 11:55 -0700, William Tu wrote:
>> On 5/7/24 12:26 AM, Paolo Abeni wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, 2024-05-06 at 20:32 +0000, William Tu wrote:
>>>> When a system has around 1000 netdevs, adding the 1001st device becomes
>>>> very slow. The devlink command to create an SF
>>>>     $ devlink port add pci/0000:03:00.0 flavour pcisf \
>>>>       pfnum 0 sfnum 1001
>>>> takes around 5 seconds, and Linux perf and flamegraph show 19% of time
>>>> spent on __dev_alloc_name() [1].
>>>>
>>>> The reason is that devlink first requests for next available "eth%d".
>>>> And __dev_alloc_name will scan all existing netdev to match on "ethN",
>>>> set N to a 'inuse' bitmap, and find/return next available number,
>>>> in our case eth0.
>>>>
>>>> And later on based on udev rule, we renamed it from eth0 to
>>>> "en3f0pf0sf1001" and with altname below
>>>>     14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>>>>         altname enp3s0f0npf0sf1001
>>>>
>>>> So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
>>>> devices + 1k altnames, the __dev_alloc_name spends lots of time goint
>>>> through all existing netdev and try to build the 'inuse' bitmap of
>>>> pattern 'eth%d'. And the bitmap barely has any bit set, and it rescanes
>>>> every time.
>>>>
>>>> I want to see if it makes sense to save/cache the result, or is there
>>>> any way to not go through the 'eth%d' pattern search. The RFC patch
>>>> adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It saves
>>>> pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
>>>> scanning all existing netdevs.
>>> An alternative heuristic that should be cheap and possibly reasonable
>>> could be optimistically check for <name>0..<name><very small int>
>>> availability, possibly restricting such attempt at scenarios where the
>>> total number of hashed netdevice names is somewhat high.
>>>
>>> WDYT?
>>>
>>> Cheers,
>>>
>>> Paolo
>> Hi Paolo,
>>
>> Thanks for your suggestion!
>> I'm not clear with that idea.
>>
>> The current code has to do a full scan of all netdevs in a list, and the
>> name list is not sorted / ordered. So to get to know, ex: eth0 .. eth10,
>> we still need to do a full scan, find netdev with prefix "eth", and get
>> net available bit 11 (10+1).
>> And in another use case where users doesn't install UDEV rule to rename,
>> the system can actually create eth998, eth999, eth1000....
>>
>> What if we create prefix map (maybe using xarray)
>> idx   entry=(prefix, bitmap)
>> --------------------
>> 0      eth, 1111000000...
>> 1      veth, 1000000...
>> 2      can, 11100000...
>> 3      firewire, 00000...
>>
>> but then we need to unset the bit when device is removed.
>> William
> Sorry for the late reply. I mean something alike the following
> (completely untested!!!):
> ---
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d2ce91a334c1..0d428825f88a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1109,6 +1109,12 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
>          if (!p || p[1] != 'd' || strchr(p + 2, '%'))
>                  return -EINVAL;
>
> +       for (i = 0; i < 4; ++i) {
> +               snprintf(buf, IFNAMSIZ, name, i);
> +               if (!__dev_get_by_name(net, buf))
> +                       goto found;
> +       }
> +
>          /* Use one page as a bit array of possible slots */
>          inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
>          if (!inuse)
> @@ -1144,6 +1150,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
>          if (i == max_netdevices)
>                  return -ENFILE;
>
> +found:
>          /* 'res' and 'name' could overlap, use 'buf' as an intermediate buffer */
>          strscpy(buf, name, IFNAMSIZ);
>          snprintf(res, IFNAMSIZ, buf, i);
>
> ---
> plus eventually some additional check to use such heuristic only if the
> total number of devices is significantly high. That would need some
> additional book-keeping, not added here.
>
> Cheers,
>
> Paolo
Hi Paolo,
Thanks, now I understand the idea.
Will give it a try.
William
>


