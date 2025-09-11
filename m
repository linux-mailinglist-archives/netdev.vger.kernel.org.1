Return-Path: <netdev+bounces-222210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D700B5391B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1EFAA78F5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC53570CB;
	Thu, 11 Sep 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iFSx5K3E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7A35AAA0
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607788; cv=fail; b=rxkpYy3gDvCuUpBYDjyfcfNmF/gThijzxFebnMHhPMt9ctlXLAOdNyN1+t6reXoy8FSedQ7xBOTjCkR2i8OKziPdXmQUlbslbDML/9paEvN4FfaotrCJ3jf7yaC4hVZswyA6GjNl2dcuJHBUw8OwFDUH1vq3afCo0A/mFQU20fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607788; c=relaxed/simple;
	bh=+5Sd0WVuLv/6yesqYR3dvadRweGnUPMZWtwpueVB27g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N0A7fYCKEd9rs2Ot53PN4btYLDKtPWTm28NPBGmh7i6c6JNitD+OUd7lexyDY0N9g7JLpZTQjQ1akrvkuARucvdefDF3vzznq4jM/ZqyNhilShjyr33aP7H+dCwO1zVBOZiuIddHp5krHRjkz5QlztoxPST/uNRSfeJarxhlwtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iFSx5K3E; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyTczDbamuuVyPhtpmXqlGiRxZvuV5xt3DG5R4RJAzz42iaW7xwIxoto88qClB/syW6R08nMhoDThKmMTYkJzU9hKUUHwv8qSD7RiPSXtlD5PHy2K9yczmWc29m2otVPwmjDLd0L3bocN/jmDjpnGu87yG8PcPwqDgP6e9gSvpOa1OTUUTQwQrrg+kGeGCeQlhYr68icrTdQCTYTF8YD/KZu3vwpDHMWOS0whlsu4v1vDeN7MKKbE65LWFAVjLCEqSPyge/dvMR9sNHwWtPvmn8btQm9y4BZJq3lVwlCb3uzQSoDhho5ZjhkqGmVHB2/iw2BMR4MFkYpgh1FSRKWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goeaDIYUVfvRKicoFkJX8bDVRh3Q9DEgiKH4/F1IAr0=;
 b=dptVzZA+4zvs+5ryDKrekL1wSopF6LAB+ElxUCpr8UzG9OzURtnhFiQKSsPXT69Lq3dML826RfFN2VPGbmiEJzBHr1hFJfJzw7cD5ermcEl7HXlrRIoQJwaOhxBDJUEj32Uwh0/ftVNQg30GWGyWXJDXOevoOKEg9aErsJWqUpKLusIbR/HHKF75mugAZoZc/Kcu6zKyD1oRD48fuw6S7QpMk0y8oUlyvYPkxmFjq8YpdeOTsGHVVxPQCIWzwKQQt3RwhDaWX0SDS6ZAAjzqbp3JRil4n04cldET03gC58rHjJSGSjy6j57IYZbOeijRRuzszfQs7lsOlsRPLAF/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goeaDIYUVfvRKicoFkJX8bDVRh3Q9DEgiKH4/F1IAr0=;
 b=iFSx5K3EhFu+cdCTNPoIxKJqQdY4L6WPXVq74VIj7FUjOSb+xYOyojmrYF421PmOeiEfzU2PB9uiY5j7k2MdO07CP+Q6iv0k965ednvvKJ7ZXzIXZw/BGoah6EuZc2dNAN74HhoYBs3BT+3NZgMPJmAz7ynlY94D2iW4zkh5ehI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:23:01 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:23:01 +0000
Message-ID: <e6f5e027-db2a-40d0-a585-af1c8a0ed00d@amd.com>
Date: Thu, 11 Sep 2025 09:22:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: use int type for err in
 ionic_get_module_eeprom_by_page
To: Alok Tiwari <alok.a.tiwari@oracle.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20250911042351.3833648-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250911042351.3833648-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e3c394-66dc-44e0-99f8-08ddf14f7a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0xsRWRTSlVBc2p5NFhwRTk1NEVzdUp6UFJDcnBZUVQybHBkMTMrbFRkWVdm?=
 =?utf-8?B?N0xQVGNjWktxWStLTk9mZlJUZHdKWUdhSys3QTl2Sm9RSjMzNlNTMWtKMjVl?=
 =?utf-8?B?RUxwRWwyMmp6R1YxR2RGQlRPR3ZDQ1J2L05OTk1iak1ZenRtVHJGRnZoOVM0?=
 =?utf-8?B?WWtYbXJDYk4wemtXWXlIUmtJZ2NvSTQvM3ZzZ1FkajB2RUFoTnp4UGFhU1hq?=
 =?utf-8?B?NlhFVnQ5c1hRNlMyUDZoUmNPM1Y5VHVPaDB6NkorQUJ0VnF2djdqZ2tIbzJD?=
 =?utf-8?B?emVENGliMVEwRllyQXpXVDA1Q253SFY1S3pUUGxLb1hzOFFISk1PSEZhRzk4?=
 =?utf-8?B?SzZMc3dzYXdiVi9hNmhMQmZrRThucytWWFRSemtPVUdQcFFNUGswRWhtYm50?=
 =?utf-8?B?bDZuZXRLWXBVQ2czQVNTN2trczFIRkZHUGlDTDRTYnNtS3RRUjZuLzl1c2hW?=
 =?utf-8?B?b1Bud2FEcCs1UHFBc3QrRmJ4UkJldE8ra0ZZZXJ1UGh1cWtDakZRNlZpYUdP?=
 =?utf-8?B?blVJbDNsbEZYQ3VxdUlsaCs1R2JCNVZRTHNEMWFnVFRqVmY5RlZHMjNlYmlG?=
 =?utf-8?B?Rlp1OVdxbXE2VjdVQXJPYnoreS9QOTNZWjRJVjRqTTJxVXpka0hvR1ovQUdl?=
 =?utf-8?B?S3hRQ0N0UGNaalVvNHFNaTNwaEd6K05BcVJaUUtjWXhiNmZCYU81TlBZa0pq?=
 =?utf-8?B?OTN0ZysvcDUzWS9xN3cvZEdydlVyaFZucXA1cDR2VzhzSzlzTCtXRy95aFBM?=
 =?utf-8?B?Y3JHb05CcFd4dGFlUzVwY1I2SzF2djNZT1RkbStER3AwN0NRTVpIYm0vL1A4?=
 =?utf-8?B?d25BTGJ0UndSb0c3emhKWnU5K1lVdDF3UXhsbzFJQTI4U3VFenlHajYxQ0ZG?=
 =?utf-8?B?Ky9rR3hwL2hlUWwzaUJGRmNOU3ZvOFU2V3dib3JZaDN3bHpKQzROcTJPcUp0?=
 =?utf-8?B?NXYwQVdWMkphbm5OZEZHOWtKTEdXOEpLNzZnRW9RRDNlZENJTVdwMzVLcjBI?=
 =?utf-8?B?ZHBTeUM0eXN2UnA0SktDdHpTNFFlNDBZVGJ2MUF0SjBOSXB5blZNZ0hucGpa?=
 =?utf-8?B?Vk5XY3duaEh1N2ExVTMxeUdjMFYxSDZRdHZ2WGM3eEI5Y2tIQm1jdmN3Z2hv?=
 =?utf-8?B?ZXFkZ1FoTlhORlEzY2JRdlBkQy9TbUJ1Zk8yTWZpUFVuaHJaZVI1blJrM29o?=
 =?utf-8?B?VGxNMm5FbWlwaGZVVEkyMllGV1AzaUZYVUhHTmw4SFNTaGpTVmVaZzdGTENq?=
 =?utf-8?B?cWd6bnZUa3N3cFBiL0h2Uk85aWZaZ0pMSFd1Q1hjTllWV284QmZpWDdBQkFP?=
 =?utf-8?B?Mjdtc05paDJpVU5YWWNQYXVVNHdpUzN1N3dHSnlvcGNpalZiKzdjQUxDdFJs?=
 =?utf-8?B?enhQL05ySnVBSzMxRFFnVEc1aHF2YXphOFV6K1h5R1YzU21aSUQzNWRiYm4v?=
 =?utf-8?B?a2RVcjVrb25ncTlaSEtzS2llREVYeTZqSmsrYTI3TzVzTmdxMi9LdjBUS1Jh?=
 =?utf-8?B?ME50WEtGRVNycEU2Tyt1M2dXcmhXcWtWQUx5OXJUandKdmpGTzBNOWhGdTd6?=
 =?utf-8?B?Z1dDMGNUU2hxakZKdmFlbFg3Y1pXQ0M0UXVrRVFUV1hYa3JDSEtLb0dkUVVp?=
 =?utf-8?B?djVMNjRmYU5JemppclgwQkxCQXB0RXRxc0h4Q2dPckFJbEh4Q2pHOTRDSFRV?=
 =?utf-8?B?bjYvSmhKY0w1a3ZpcmJlMHNrZ1hQaXIrMmFnc3k2QzJuQmJ1WWs2Tk1mY2xW?=
 =?utf-8?B?czNEQWZXZW9YZ0dYRnp1ZmtkWm90N2xFTzN0bGo0YVpFTTJ1L1crVzZXakdz?=
 =?utf-8?B?Yi9LTFF5bWI0aFBaeXVwZFpjTW1ZN1BlOHA3aUczTmFzM3ZzeDdYQUpQZnkr?=
 =?utf-8?B?NUVjT0YrKzNCcHpoNGkwakQ1b3F1Zlg2TTY5Y29EZjNseU04a2c2RXkvT1o2?=
 =?utf-8?B?aFFuSSs5NXAwMXdlMWUrWkFvZXIveHRXdkRON2ZuM1NPNzdRNWFycEVzWUtz?=
 =?utf-8?B?MWhFcnNnaWZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0R1Wk1rNG13V2NwWHQxZjhvb0xxRVlQczBoNFlNSHZYeFloYm1ud1JoVmpm?=
 =?utf-8?B?YXBvQ3lCckh1YUh1STRqdklFTjlhUXFTOStkVVpqdHV2c2dvUFlQdVBtQ2Zj?=
 =?utf-8?B?VkV1VkNZR3owM0hPVEhJNUhDRi9lYUdadStNaE0rUWovU3JFZ0VqcWdZV2NY?=
 =?utf-8?B?ZTBQOVpGM2NoaWdXRUNKeXNTSklIaVlaV2E3QW56UVlGNHhuU2NUQWdWMm1J?=
 =?utf-8?B?SitwOUJQd1NXb21lcnk0QlVwWmxUQWtYNXNObFk3eThjaEtmazFnV3NFSmVP?=
 =?utf-8?B?M1NyQ0w0a3BWTVBxUFVnUTJ4Q0JBZXB3VHVsMlczbTFyazVyRW9hYTh5SXRP?=
 =?utf-8?B?QVg0N21naGNZbGJDTTNQclRCSzdxandOOWI5Wmtid0pFQ0cwbWMwUWFQM1RE?=
 =?utf-8?B?QnpBT2NGTEVPQ0N2RTB5UXlIellhQU92dU1IOWxwL2ZMbHVYL3UwUmRQYzVC?=
 =?utf-8?B?a0tncnI2MUdqZHZndnJWbGs5UFQ2UCs1QTlTRjFNVGFOTFpvdmhZU1p2S3oy?=
 =?utf-8?B?bDRXYU9CVGhnMGY5Nzh0MGRVbWV3WStNcFd3dVBOaHFlS2w3UndyemI3Q0pp?=
 =?utf-8?B?cGhpNVg3YWlxVTZ2V0t3eUxZWXczS2ZDOXNDT3NRRk9aNFhDZlhSTnZlMWtl?=
 =?utf-8?B?UEFHejFUYXNlL05PcGNFS3pNOVdmNHF1Q3JZYzgvSGZ6KzhOYUltWlRsYjl5?=
 =?utf-8?B?VDNkb2VFck53QVZBS08rWGFGaHN3NG9jTWRMbTdjZWVIQXhFcUtIeWIrem9z?=
 =?utf-8?B?VnlySVRsby9GVzdncU1TSkh5THRoOGpTMERrYzZyYU1aUjVYd1I1cVVkQXRV?=
 =?utf-8?B?eDdWd0JZYiszNHdGTitETlFMNUlickhQU3E5YTBKckhoSTJwc0J0N1pjVmtq?=
 =?utf-8?B?ZmxYZkFnKzRTNWZUdW9iT1RLcGdaa2M4WjBIWDZQT21vZ0RVYzdOVjlQYWx2?=
 =?utf-8?B?TGJxM05pOTE4Ykh0VTRiR2ordW5XbnRib0Z4WVJINWs3MUJaODJqZjJVc3Ex?=
 =?utf-8?B?OGJlOWxYYUljM1lwK2UyMFBSc0xTeW11MXZPOWNsL2ZRTzBwQjVMYThHekN5?=
 =?utf-8?B?WG1DWmsyRGRIRDZUM2lWWVZqR2pwcytQQWxveEMrd3VzdElrSEY0bjdUWHEv?=
 =?utf-8?B?MGR1V2VINEZhMy9TOHVvR0YzN0VETTU0aTh2WGQ3ZlFtSTZYT2pTb2V6dlZ5?=
 =?utf-8?B?Mmd2NW5ud1NSMnB5dElHZE1GZGpKKytwYlhFTUdXeXlIRXlWTXN0NUUvSGdN?=
 =?utf-8?B?M3Z1TGxDRUVoVmNZQVdzMk95MUprMW5GWE9FazhzODhUaThlOFdKT3I2SVVr?=
 =?utf-8?B?bXBqajk3RlhFQ3dwQkY2OWVIT1lzckZQRGNwcXZyNS9WeVhOWHI2WTVNcnJi?=
 =?utf-8?B?Nm55cVBHbDFwbWE4TTR5RkJYLzBWSkR4ZUdJZzVGNktxNGRtRU1aTG1KaS8y?=
 =?utf-8?B?d1FrMTlNbHQvSUR4ODlrTGhRSm96R242dytTVVY5bGE1Wm1zRE1mMndSOHp5?=
 =?utf-8?B?U2hUNjBuaktQd1YrM1huVUlvL1RYTktESFJvV3lGcG1ieW5aZHJLdG1hS05C?=
 =?utf-8?B?eXAwQ3pPL0VZUUozY0JBWU5NNHpIT2hJNkxhOCtML0VsV3VzbGhMRC9laWxE?=
 =?utf-8?B?d3FORm9ZdnEyY0JwL2JjMXJwWWFNTzRBMmlwZG0zZjRRdi9veXkrb0YxeWhO?=
 =?utf-8?B?ZHBGQkRLMFBHNCtpSTVGdXV1RUZoNXdLYmZ2UnlKUUtac3ZqN2xRYkp4aUlk?=
 =?utf-8?B?bFNrMmtNTTkzV1Z0aWtKSnRZR2FTME90b3JsS1laWnlmakRNRU9rRU8rRkxu?=
 =?utf-8?B?MWhxU3JnbWUrVmNWWC96bCtBNTArMHN3WCtQaDU5cFpzQXYvYmYrbFFCYTEr?=
 =?utf-8?B?azJiMlpWOXpZMk5LMkFYQlpzamt2TURaSkpoK2l4VExiR1VuMmE5bW9DZTNa?=
 =?utf-8?B?KzdNQjB2bEVzNUlmKzliMDlWYWFXalVpb3VjUkkzd1l2dndPVXNGV0NvZ0l3?=
 =?utf-8?B?a3dpZW42dlVZZVphZzFINE5HTUtFdmd6UThHeWxvdHZmUy9ValBtQzZPZCtq?=
 =?utf-8?B?ZTVEZGtTU21qM0FpcTYwVkdOYzYzOFhCSWdxTmVCQlBXOVkwTm1QSjBpZ2RB?=
 =?utf-8?Q?rgq/MDJxbOFHUS0f+LesM3WXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e3c394-66dc-44e0-99f8-08ddf14f7a26
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:23:01.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7CmfKRtwgu9BL2QUm3jNa0Cw4xm575xz90+h3OQWRKOFDnZLC+OV5OtPPhTROGp5HDI7NWbhMCu7bNKhoj2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143



On 9/10/2025 9:23 PM, Alok Tiwari wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The variable 'err' is declared as u32, but it is used to store
> negative error codes such as -EINVAL.
> 
> Changing the type of 'err' to int ensures proper representation of
> negative error codes and aligns with standard kernel error handling
> conventions.
> 
> Fixes: c51ab838f532 ("ionic: extend the QSFP module sprom for more pages")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 92f30ff2d631..c3f9835446e2 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -978,7 +978,7 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
>   {
>          struct ionic_lif *lif = netdev_priv(netdev);
>          struct ionic_dev *idev = &lif->ionic->idev;
> -       u32 err = -EINVAL;
> +       int err = -EINVAL;

Thanks for catching this.

Minor nit, we don't need to initialize err because it's set before being 
used.

Thanks,

Brett

>          u8 *src;
> 
>          if (!page_data->length)
> --
> 2.50.1
> 

