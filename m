Return-Path: <netdev+bounces-189005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE6AAFD3C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EC39857AB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E82741A7;
	Thu,  8 May 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hsoe+bT1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2E272E6F;
	Thu,  8 May 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714749; cv=fail; b=QyopHEbmnSLLAUDMq+3AtTgZ7pQ40V4ugVJq9P/d+ZdTjqq9CKZ9AtQ8IC64aN0SV7UlD70/15bI2ECJO7rQ03/cBuddoyN5DBXVMfDyzX10bDeqRNZ18isQrx8LODKYSFy/JigPuWa03SLADyvX5nRxCRHVPYBcK9Fmd20pxeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714749; c=relaxed/simple;
	bh=lH1+Zo3NENOkmGKL5neFvkpa6ez0tX8aiypEOEvVRsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXWGN721PTYB3/hmEoCFtW7qFIDrVibVKZT8ehd3OkLYuS5rS60TECexMV78xlW+ObMRoq4R47gH7YibqV9ynMtH+Z9Mc7wLcZT3242LZsTUqImk/7lsXOBsnJui91JaVHyU8n22V4mTKbzJ/ezWCpQ8k/3TValqTqEMwU3Iyig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hsoe+bT1; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upJmWrQDGT4DbbLptdu0ncVa1bPKt9pTKm2z1dH2A3ochcyK1lwxc2v/DB1XIysgyDCJA5U1nC/hawwJ81hUGd8pRzSo/9M+MQG+DDz01nJDIZS/Q/GoyxxIw+f3DmlbapMarVQ9Ve/KU8IWCxJUvpkyNy+CKFaMhGxOyOO0mSHwB7okL5T+lwoJM5o73k7xGeDaq6WX/FW5hhNxy8/QNacQ9hmmQyQKe6m+Nfr/rvvqhdfx9IQFVc5Nxwmvv5vS80Fu8NyglF2PzmomwL8916HWAhD1hLU9xd1XE4/WHPOxXL+WQrS/HDiDg0N0Whk5ZWdif88sVAIoZozkHsQrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4fQosm+kgPFa7G2/MJ47QjW0PUfLrBfW60BDOA1/yw=;
 b=XZNLn+dVew7IGGpgzdJY99zxngUAKz28UuNfcqmHZuTgrLvRnxAIjriPGTR/r6/MpzAU4n+HH5bIFI4Uk22fzjmTwfAoC69ScOuyi6iUT6aKBsvMIe8CMqyjfk822RJdFN6nFEeA5xkszqQDjUVQ4STtxDPUXqC1auGRI9db0RNywiaf+MF2gzYmT4oLUC/tStvcsxbRQtHJlBTrJ3Mb0OOX48xQdia+WHKdmI8ebhujo6TePuTZEoPNGilBSvYv7bOIfgsT/RiFaR+005KkhZrzoOcXnHQ8SDtx6JFM9s6gLNkzn8yEoaJiR4NJeNczW1zmV0eQAREVXXdok/XU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4fQosm+kgPFa7G2/MJ47QjW0PUfLrBfW60BDOA1/yw=;
 b=hsoe+bT11X8yffaw2W4YGkuX7n8nP1mFSRmtKq3BB5pcKlhZR7Ipiu8Lze6g4T8pR1u6rAh+Bbacj0mWiSFG5+2gPna9gOj8SPiCayBWGjPTtjpAZehp6Xu1dLzMEwH0Y5D6SKiqsMpX9cze7MxfU2A53UUckICrnCod576eCw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 14:32:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 14:32:16 +0000
Message-ID: <53a199ba-8f17-4c38-8061-bf7c4f145fa1@amd.com>
Date: Thu, 8 May 2025 15:32:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/22] cxl/region: factor out interleave ways setup
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Zhi Wang <zhiw@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-17-alejandro.lucero-palau@amd.com>
 <aBwGARkkDa1DmTkQ@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBwGARkkDa1DmTkQ@aschofie-mobl2.lan>
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
X-MS-Office365-Filtering-Correlation-Id: a2760f1c-a6b1-48cd-1cad-08dd8e3d21a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3lITHlSSTM4ekFxL2NCM0xpVUd1Qys2aFQwUXl0d2RLakg0dWZnaWw4VkdS?=
 =?utf-8?B?RUs0ZUtNa3JlOER3Skx6VjlSZmQ0ZkRqOXVRUnQ5OVBLUUVvdk01alhWdzJh?=
 =?utf-8?B?ZWE1VFFpRUYwNUs2RUtYbnE0OE90bHVHT0tJbFYyU1VQb3JiVjFQTmJyM3VP?=
 =?utf-8?B?U1k3NFJqenhoT0htME90bXRGeS9mek1YazMrazRBaTR1WW5NaWpxaFd1U2tS?=
 =?utf-8?B?MXdKZjJpdElNNEtCY3dKY2hIcDhiTlNQS3FNNHVOVVBGaDdIVEVPTGJyZEQ2?=
 =?utf-8?B?dnllSGZBVHdPZlpGSjdSMElJelBRTmVoanZISEVqZHJaUzFaT3QwNTM5UW9N?=
 =?utf-8?B?bUhkT1BUTXB5Q0oxY3RLbTBLNFpOV2lMSDE3ZU9tR0FUY0hLenZrb2NlYTdJ?=
 =?utf-8?B?WFNqS2R2VjZhaStFcUYyeDVya09UQktucVJDblFDWTQwYkRqdEhRZU52UVZK?=
 =?utf-8?B?VVB5MlRjZjI5d1ZxQisxcVBOaDhTdnpvYlVySlZtQkdhZmVGb1pXcnRYK3dD?=
 =?utf-8?B?OGFHcGlTRTE0VXhlVjEvb0RSTHR4eklYUVNSbVBCck9QNVM1UnIzQjVvS2pD?=
 =?utf-8?B?K0U3ZU0rclhqSlNrSkRSQlNWOGdnVE82KzRIWmtLd1hjYTRrMHlhbUJKQWpv?=
 =?utf-8?B?VFM2bnlocWZCa1ZYZUZzUHBPdTluRFVGUUV4bkJlclIvT29DZ3hnQk1HSnE0?=
 =?utf-8?B?QVU1M1BDWnRKYnIwRmtld3F1cDVPOHNJby82OHI4R3pXT3ZLMDgwSzE0aUti?=
 =?utf-8?B?SVdBbjM0cUV5MzZ0VktUTXJjTUt3U0RRbk1zNFY4WG1RM2J5MWNMVmdKb3c0?=
 =?utf-8?B?bThlcEE0Y0JhRENIWVVNTTVsYXNwUi9YNmxWdk5qcTNHYjFIWWswL0ozM0ZW?=
 =?utf-8?B?d1BxaEx0cjRZWW9jNS9kdzVITkdVS0FnSTdBbGJvaS9BdEZ0TnZkOFFiNzRB?=
 =?utf-8?B?Q0FPbFg0bEpXMjkwbmxvSjhKTHZHUi9VQjIrdFQzdnFsN25pUU1sZ3h4b3dr?=
 =?utf-8?B?WlN3ZkNqVTAyemtlYmxJaU9uZVdaTkR3eCswUURlckJUU3oxVHBQcjhFQUtn?=
 =?utf-8?B?WWtkNWxBdk1VeERoZm5UK3liQWh6UHcyRG9SZnF2aXV2ai9kVEdKMGFjbmhI?=
 =?utf-8?B?REk3N051c08xTEh3Mi9LOHBqRVREUFZET2lhMnFuOVZzRFEwSkEzL2F4UnNz?=
 =?utf-8?B?VHN2WHJlYXgwSEM4ZVdMZUczeDZielZzaXppMXRLQnZJUW1ETW1TMW9QV1U2?=
 =?utf-8?B?RjJZTjhVWnlQSFp2OSs5M1dNNldpY1RNNm1JRkx6QVNyS3dOaDFRcXd6WXNt?=
 =?utf-8?B?NW1LZm1XTVZQbmsyM2psdFNpMWp1a1VCWG5CY1JnU3VGaWl3VVgxZTRyN0N3?=
 =?utf-8?B?dnc2T2RBajlDZ0hLZWVvSEFSNDFQZ0ZteXZOeHdUaVY5aFpnTWE5TTNiUVNS?=
 =?utf-8?B?eGJVTEprNzNGY1hqUXNOY2RmNXV6QW5VOWl6OHBtc3dDM3pRRnFrVGltU1c4?=
 =?utf-8?B?M1BNZVZLdEdkK0YwYU5UemMydUhCQUEvRXlFOFN5WmpRSEdMWjFoN2hWSENh?=
 =?utf-8?B?TjQrU1NIbEowMlRESDQ2by9PeFhreTlONy82QmdTOVJNT0pzcXZ6eUJZRkd2?=
 =?utf-8?B?dVZSRUFVU3hvVDdEbW1yWkMvWktZTGM0UlN6MVg4T2xBQ1JJa1NBSmJSMzhm?=
 =?utf-8?B?cXBva05TUFhmQVpBN0hkZldrRDJnNGNRUGRNTzlNNDNKbk1pZ3Y1OExhV1Vj?=
 =?utf-8?B?ak0ySC9hbkxZTkUyZW5rV1BvKzFITlRXQURlK05OZGtjaVNobHBOZnIyZHNG?=
 =?utf-8?B?NnNPamQwTDRoMGV3T0hBdEJvVERBNVFaL2VmR05PTi8wRWUwalVZQlJXcW5n?=
 =?utf-8?B?Rm1LNWRLRzdGMzE3Y2h4aWp3bDlabHVCdmZUTlNJUG9KRzMwZHA0bFkvRDI0?=
 =?utf-8?Q?qjquHBk1Ghg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1FMTW9xNDUrVloxTjdPNWtRZlFzNWdFQUxxREJlMjBvOGtjMElXQzdjVFF3?=
 =?utf-8?B?QWlXcU9HdXJnUWVzSU9EbWc2R0FwWFdIVzBkSUtxOFp6VWR3NFJVZThuYUVY?=
 =?utf-8?B?bXZlV3UrZnRQdnd1L2hheVJDLy9RRkc2OTNNMG9tMm04L2dyK1A5YVhyNXRZ?=
 =?utf-8?B?WDFpc3ZhZzF3b1ZCVDFwUkljWjVpN1BvVGdPSXBtNTNQaC8zczBLS3lCSUNv?=
 =?utf-8?B?Nk1YVDREcnJsS01Ob01zcjROcXlxbGdkN3RDd2V5OTd5b3BORURSUmpKaVNy?=
 =?utf-8?B?MkpGUnlkQnB2MlBIOS9ZRjdPaGJ0V1k2RnNKZ0RDdy9TbytkSVhka2JwMG5O?=
 =?utf-8?B?NjRyZWRlamJodGVqSFk5d1U4RkNYRjVqMDhyZzVmb1MzVHZMcU9GV2IzbXBu?=
 =?utf-8?B?OEFkcHhsUDUxdk55MjVIYmVtWWU2V1JhVWhoSGZHOUVlSmZQSll4WnlYQVRu?=
 =?utf-8?B?bXJHYU9LY29RNkVOL3NHQWdCaGZEM24rajlCZHQ0cVJrVVg3UHU2R0tHckdP?=
 =?utf-8?B?WEYyOUFxdWUxZWtqaDF5ZUt1NWxGWTRHR0RPZDA1QXovV1JCaWxZSTROanF3?=
 =?utf-8?B?aUUyMlRWRGptbnpZZkwxWHFTdXQ5M3cxSmJXNDVpZGQ2MCswK3B2V0doT0cw?=
 =?utf-8?B?MjNtVnBZblpYMjlDaGl1YnlDZVB5L1U3dWw0ZmtvM1JKYlJHcGVnYWc3K2xq?=
 =?utf-8?B?bG14U0ZLcUsyTFNXQWdSMXNRRGZYY1A4MWtiWXdBdzZmR3BucC9HSllyVVZD?=
 =?utf-8?B?YzZiQi9ZcHJvTCtrRW13YTRra2x3SFNmbGJtdVVXOXN6QlpjVk9XYjJLR3Vq?=
 =?utf-8?B?WncxejR3Y3RYZm5ma1VXMUgxdTNiOS9hbGRudkE4OU5wRkZyZ0gvT0hNNnA3?=
 =?utf-8?B?MTNTa0tiMVJWc3hvS1BSVjExWTk2MlBBR3BWOElKTDJzNDgxcHhVUTdOVnkz?=
 =?utf-8?B?bWtYTHQ2bmhYd2VUMmFvcDdjbUtyd25MMHgrR1g1TG5LenFrTU9ob3EveWc5?=
 =?utf-8?B?VjR5RjBqVHBOOVZrZHJmUUhCUXVmYjhoM3F5Rm13UEc0UmJIcUFDVDFwcHJh?=
 =?utf-8?B?ZFhQUDlPTGEyZFNLSEVFT3VRWkVNRjZ2QUt5eWJBemtVZlVJK3pLY21OMkNF?=
 =?utf-8?B?TmxyeHNYWTI1MllXR2cwNjMrcmJMVVlaQ3JpdTVwd2FnZ2o2NlNUZGY4S0xS?=
 =?utf-8?B?QVVrZGMwTmZnRFI3WkFlNnN3TjZlMVk4bkxCSCtRbzhkWE0rd0lSd3djamNr?=
 =?utf-8?B?Q080aElnc3RWNHR1R2lFTStjL0xPZWZqVGNDcTlidEVoNXd4V2prQWNZTDhy?=
 =?utf-8?B?d2Rxb1Eza3ZCOHNQRlBacG5qc2F4MXNWOTV0clBkT0pvdUJnRnNjZjJ3c1Vx?=
 =?utf-8?B?a0lOZkllaHdEeWJ3bEhkS0szaXh5SWJ3R3hVSXgrL0Uyd3VFbmc5SWJGM0ky?=
 =?utf-8?B?bnFBWUdqam1OdW4yNVl3RUhGV0lwNXRmTkhNY1JldEdvdzBLZ3R5TmpMR3RV?=
 =?utf-8?B?QVVXN1JYbTdwMmMxNHB0L2dIMHpDaW1lTzJZdXEyblJ1b3pZUnU4cUtramNC?=
 =?utf-8?B?Q1p3N2RXR2puUysxWnV0VmIraGNKd243UVNMSkdSbHVTUHBUNitjcklGSlVG?=
 =?utf-8?B?SU1mV1hVMEVJOEhmdWFZUjFkcE93NmZaMURuaGxyak14Zlc4MURjOXdVWEZT?=
 =?utf-8?B?WlZtZm44U3YxdU5zT1RaR1RST3EvOWN5dzNJeENuanMzdGIvNlFLaGlXeHVa?=
 =?utf-8?B?Z3VvSkRiRmdDQ0s0SU9zLzhWOEVFaEdZUjl5RUYwNURXcDliVUZVYU5sZ3Ar?=
 =?utf-8?B?eW9xUXM1MGJDbm1DTHdZOUVpY0JpQTdKQnA4Z1FsUS9EZ0FoTWUzdUdmT1py?=
 =?utf-8?B?clRVUytVbHpRNHUyMVA2clJJSFl1SUV5a2paZkVSb0RrN2pVN1ZyT1JVYUNm?=
 =?utf-8?B?ODh2TkdMbUhwTWhzNjZWOUpCL21XTC9Iak93c1JKRjlybTM0Qnl5Y3FRRFNw?=
 =?utf-8?B?QmU1b25xYnFOM1hmUkhSbzdKc3NXbXJ4ZjhxalJKbTgxeEpsN2RadEpWZXNB?=
 =?utf-8?B?Tno2TThyYmU1WXl4SzNFYVpKTmErTlFpZ1ZJL2oybi9yY2ViMjVUelJQYUhZ?=
 =?utf-8?Q?0r3E2f45Pq4Lzk64sisp/LqVy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2760f1c-a6b1-48cd-1cad-08dd8e3d21a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:32:16.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqDorNIvTMv+aIFxBInFtWWQP4OLk0NAcBBIiauB+A/0vRtkDyugxDDHbO/Cj3SMz3whRJm+B9e9k9zgxWuRvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548


On 5/8/25 02:16, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:19PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for kernel driven region creation, factor out a common
> Please define "kernel driven region creation".
>
> Also, please keep repeating that these changes are introduced for Type 2
> support and note whether there is any functional change to existing region
> creation path.


Ok. I'll do so.

Thanks


>
>> helper from the user-sysfs region setup for interleave ways.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
>>   1 file changed, 27 insertions(+), 19 deletions(-)
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 6371284283b0..095e52237516 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -464,22 +464,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>>   
>>   static const struct attribute_group *get_cxl_region_target_group(void);
>>   
>> -static ssize_t interleave_ways_store(struct device *dev,
>> -				     struct device_attribute *attr,
>> -				     const char *buf, size_t len)
>> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>>   {
>> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> -	struct cxl_region *cxlr = to_cxl_region(dev);
>>   	struct cxl_region_params *p = &cxlr->params;
>> -	unsigned int val, save;
>> -	int rc;
>> +	int save, rc;
>>   	u8 iw;
>>   
>> -	rc = kstrtouint(buf, 0, &val);
>> -	if (rc)
>> -		return rc;
>> -
>>   	rc = ways_to_eiw(val, &iw);
>>   	if (rc)
>>   		return rc;
>> @@ -494,20 +486,36 @@ static ssize_t interleave_ways_store(struct device *dev,
>>   		return -EINVAL;
>>   	}
>>   
>> -	rc = down_write_killable(&cxl_region_rwsem);
>> -	if (rc)
>> -		return rc;
>> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> -		rc = -EBUSY;
>> -		goto out;
>> -	}
>> +	lockdep_assert_held_write(&cxl_region_rwsem);
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>> +		return -EBUSY;
>>   
>>   	save = p->interleave_ways;
>>   	p->interleave_ways = val;
>>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>>   	if (rc)
>>   		p->interleave_ways = save;
>> -out:
>> +
>> +	return rc;
>> +}
>> +
>> +static ssize_t interleave_ways_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = down_write_killable(&cxl_region_rwsem);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = set_interleave_ways(cxlr, val);
>>   	up_write(&cxl_region_rwsem);
>>   	if (rc)
>>   		return rc;
>> -- 
>> 2.34.1
>>
>>

