Return-Path: <netdev+bounces-112977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D988A93C14E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A3B1C21CBB
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E011741FE;
	Thu, 25 Jul 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OZcPT8ET"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7A199389;
	Thu, 25 Jul 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908788; cv=fail; b=sY7uFAYG6ZeJWddrx2YYj4zHgZgPKYpLHTCDKnNyIG6zQ1DRZ7JYXa2yvzHzzMdutYlwisPm9GMAI6Ll0HD8iLB97aXTb/sfcgkul3Gpl13lv/TQzKvdumRsqZJE/i8Q++Gc2FKknmK2j1ccq7maccleBd/DdK3BXW4nQcPmD5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908788; c=relaxed/simple;
	bh=BMvvD/TQQAD31xkIjwLBafQBj/1j2YMhk5qArd63g8Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=affFXB3BqYSL9fabL4t/JVIJyuB4zJ8Zturk6pt9r5a8ZwY197lvzJBCD7yzNGdBjEgTOCZFrH9R3XgXlgzDC4GDA0MsuyVhcJcSyBMWpo1bQEkaLt6tsLT6s3/9aTYWB4sRruFmRtetZjoOudCNvc/HZyHlqqguuQ5g99K4MQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OZcPT8ET; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dcxjk6V1chlkAxLYPrVRgRydGeKBIF073uLlVAX8i51XQIcj4Ths0UY+4/v+ZZZB0Ivac4B14u++ThXqQffMW17fTxdbi4NVAFt/D7A1YmTw77AbpzQyCVbKLiGGcV7Ia7RMTkuccw9a2PnTZiEGepH5akof9naAVyPVJxA0rbrPhMCqyCxZHtdWZua33xPinSD4C6HeyjZRJFp6QL5bmIlAIBIMWj/j7eJtdjlbR+d/6FlbI4R/ONE0khGIcA2AeQP6Od1InGV6z0mPlvIrlRXODCyT9P6FL96fx61qssMR/1RET7or6Jni7/k0uEODxfAP6Cs/0Np/91vz2XXevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QOaWMfpGGipSpoAkTTZvnklpD8HcTCs8yu5cJSojRk=;
 b=rFiAKRpzqwmtg8PKOiDM+zaIn+rEE52YSnvNnr2mnzmbmzYjASDMfmnMhaeq7FifUzHlv+5TmmZe5uZ88jPCzhsvcFK1VBrTOe3BsnXK3tGnMKhIQtC+A8QkI3UliEbNseW+fhmnvVo3VYNorigJsvnhNzWfpug7QVxJMIx8OZIw25DZZFTAnLUoJ+YZ0pWMPGi4ZNsSrmuZqt1DGr/AyMB1XwQfAJNwZ9LRXCgrIhd+ormBOzUWv1zLag9lpVhAq4cwYLeOWJHKgSPnlUqNYIyNtEFKE0wFS3ltOp+BhoqU9i6Uhrzfp0SIE9FkKuR7VddlrEkPUz8n5IcAdu1ZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QOaWMfpGGipSpoAkTTZvnklpD8HcTCs8yu5cJSojRk=;
 b=OZcPT8ETu4ZzN9xESFBKKZrCxFQTN1yqTPLCFWOVMD4kuyXYStNmi7+pfhXo93L5tYbmbxkOr4cy4OTtJmTNz2vkRAK+yyrIv09SEkieWi3m9+H+dlC1mKKMEl5TSklBvl0RzLUjdk2V7js0B4WpOs/QOm7uqBLsaumJqEAntzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 11:59:42 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Thu, 25 Jul 2024
 11:59:42 +0000
Message-ID: <3e8b9c3e-f533-8eab-d560-0afe68108e10@amd.com>
Date: Thu, 25 Jul 2024 12:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
 <73311003-6b8e-4140-935a-55bd63a723e6@intel.com>
 <f40312b1-8ac7-973b-5519-ee185eec8560@amd.com>
 <85432fe0-b9be-4892-89b6-3e986838c5d2@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <85432fe0-b9be-4892-89b6-3e986838c5d2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b25c23-82e7-4b3c-b139-08dcaca144ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTRrdjVWOGk1UjQrR2hUZWVGR2toWlZrajNlOEJ1bTVuN0tBRFdYWjRodDNW?=
 =?utf-8?B?ZEo4UUh5U1RNaWM3ZmMxSzdRSTJlQ3JIVXNrYlpjUTc4QjFEOFJhYm9XOWFi?=
 =?utf-8?B?bWhMRU56SW5iR2xUR2lpSStIOEIzUUxhMlhHWkcrb3BwR2hOWllDYjN1YWxY?=
 =?utf-8?B?NUlSZTBoWUtpSkgzcHlIdXBQZDlweGN0UlErNk9ZeG5mTno4WEVOQkRNWFll?=
 =?utf-8?B?VXhWZVQ5amJldDB2SlB5K0pGTnRUR2M5YXZnZnh1aDI5aytSMGo3WnJYSmRU?=
 =?utf-8?B?WkZQSnBSTFlGNWc4MVdLWVNOUHhzWm5oUjB3Qkpwai85T3BycnFYR2FqbU1l?=
 =?utf-8?B?SGFsVWxQdXpFRXp5dlFUTjZubXk4TVBlbWdEVFFCcGJLcW1RRndvaW56ZUZG?=
 =?utf-8?B?bG1DL3ZXRjUwRGlHckFuenM4YytqVDQxcG0zR1U4MnlvbzdUN2VlaEJCRm1Z?=
 =?utf-8?B?UFJrd2NNeU9CZkczemRUa2JGTXFIeStKSTQ0T0Jwb29mWnl5OFNSTFp1RzB0?=
 =?utf-8?B?eTc2aUNhcUV0REhNcjBPWFNGMWdvbUhSaEhzWE5ENWN3b0gwa3RyRXdrR0tY?=
 =?utf-8?B?VWVDUzZ0NjFMUmQzRmk0Y2ZZZGlIbUhLZ01Ic2hCWURScnIrRjdwYkRUUThw?=
 =?utf-8?B?YVF0MHBwMUxlYWpudEhOamVUTytsTnVDUi9HL0NHSjUwS0NLaDZtL3FWbGlQ?=
 =?utf-8?B?MU1JSWlTQnR0S1ZJNnF4SnVlUExOZ3FQNmF0cGJtSW5UTE5XenpSNzZ4eFdD?=
 =?utf-8?B?ZHBmSjdPa2wyT3NmNEtpcFZEa3ZKSFh2T0hBSzdGcjBNTmFKeVpXODg5OE53?=
 =?utf-8?B?RzBBVTFXZ1pTNVpOV2pVTk9VY3JIV2s2REkwRm5YdDZXQlpmL2NOYzV4cmNl?=
 =?utf-8?B?QzR4bU9iTU4vRit6QnluTFplMzR3d3ZLakM1dWdqWjVMS0o1dlAxUE1qcFdj?=
 =?utf-8?B?SW4rQzhlSGhiZ0c1U0xGZjM4b21VV2ppSTNpZDg0dFVtUEZqdVNtbFJ0bWQw?=
 =?utf-8?B?MVA2bDE2T080dzlsc0dWcjFkRmhFQVhEUmdqZHpXTjVEU1lDdmxjZ0h2OTRF?=
 =?utf-8?B?dnBhQWZqbVBEcS9odVFQdWZUaHRpN2YyOWtwRVhuMTN4cWFiN3BQVkxFU2xF?=
 =?utf-8?B?N3VyamJVMzRtYVhrNFZ3bnlrRXAySFZ1YWZkdkZ6N1hpNzBUcW9mRkJmeXpa?=
 =?utf-8?B?MkdBTEJ3K1hzUVZ5M3NnNW9ZNHc1SStJbVFsZklocFMzL0huMnhkeFRqc0Nt?=
 =?utf-8?B?WjhNS01Eb2diOHI0NG15WlNVcng1b3NBYnpjb3FTOVZseUkvRUtISnQvNkc0?=
 =?utf-8?B?ZzErSGE5b3FBMTZrZWEwVE1ObDhmeWtlREdpemUzdFY2QzB5S01Za1dlMURi?=
 =?utf-8?B?NDZvYXpPcGZHWGtQRlFEek4xS2YvdHlKamZXbEo0Z0s5Ky83SFdSVUIxTWNs?=
 =?utf-8?B?dkxsWlJxaUltQndpNmN0MkpBbUxnM1FxMHJHOS9XR0lZOUh5ejhiNzk1bEdy?=
 =?utf-8?B?YjdGOGxSckVFN3JrVjhDeHRzU3FrQTVpY3JsMllVcUlmNVlPUnd0bElwRnJi?=
 =?utf-8?B?WEthMzhaRUNhb1VZK1NUS3JDaUVBdUFLL0NhaGFVVTZIaHpOdm5zMzhBZjB6?=
 =?utf-8?B?N0EyKzhCb25tbUpBaTdYL2FiMzFTb0VvZFM0Q0RVS3hSSHB6N1hmZ0tGRFcv?=
 =?utf-8?B?UndQMm15OWFjblFjYkRPNVlHaGFnc2VpU0lIbVRRTWRHRTU4VjgwbnVzemNN?=
 =?utf-8?B?STlNdFE0ZG15aVJHdkpzUHVqZE5PVDlpSmk0ZXFmanNNUEFwN3FWRHpJRE5S?=
 =?utf-8?B?bDRvZlFWM3ViVys5WEovdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1l3TE1UQVJReW9ucEg5SEl5dDJnZ2ZDT1Y3K0tPb2ZnQnA0Z2p6ZnBzSmMw?=
 =?utf-8?B?S3BOdElRM0JLTDg4WmV3STNGV0U5akFINjEySWRRU1VZZGIxcGRzOEdpWEVl?=
 =?utf-8?B?dlpWc29NbEFCVERoQURueXhQQnBLRTFTKzU3RHhrSVlQWVJ4c0tSd0ZhL0g0?=
 =?utf-8?B?K3FKbFdLL1B6aWNpbEVxaXpNYm0wSWpNbXJOTW13aW9xYjBPOE8rNmo1S2Nw?=
 =?utf-8?B?OW5SQWxKdWJVUm5sV3hBODhQK0NBT21DalhFSUM4T1pvbnB0SWoxSHFxcU5M?=
 =?utf-8?B?UnhTckZwUnRTUnJTclBmLzY2SVQ2eHcxQ0FNRWxSRzRaSE1NMjdWYXVDVXlS?=
 =?utf-8?B?OEVici9mVDZMdHAwSGdHRW41WGc5UUVsWDU3c21JaDRNNUtPWUt1dnJ6eXpQ?=
 =?utf-8?B?QkpCVk5sallPVHpqL1VyWTNwSFpicW94TVpnUFhkYWVlZjNWUXNwajIwWHZu?=
 =?utf-8?B?V1FCaS9nWDc3RnVUVGdaRHZOcElSNklBRFBURDZ1LytLSWFGcncvVzNWOUJz?=
 =?utf-8?B?UFQvakttZkoyQzUyQ0pZZGhoYnJVckhrV2tQOFA2UklwRmlYNElUT3VaVGgy?=
 =?utf-8?B?ajBaMTJSYlhDZEJFbXE5YTJHZFlkLzBFV2oxR0gveXRwbnZvMWp1Vi9iSkEw?=
 =?utf-8?B?d3NrTG9VTVFvdzQ0ZW96b1dHQ1I5ckRNempjSUM5d2NpWG1aNDBZcmtMQ29O?=
 =?utf-8?B?VWFiYi94VGIwdkJMaGE1anhrY1YrallYT0c1ZWNaZlVkeEVzMm41ZkRGQ0dv?=
 =?utf-8?B?dGFHeVBGbTZQd0VPOTZhYVJUNGVKdjA5eEt3TFRuV1RvNFZhVnZtT1NLQ3JO?=
 =?utf-8?B?UW5JblhSTDdtbEJsMVF5blRBV09wazI5WmpzKzFDSEYrQnVtcnIzdjBPbnQ2?=
 =?utf-8?B?UUtLUHcyRWdQQU1nYzRLMUZoNTZhaStkWm43ang4ZWVaMS8vcUVyalppWWU1?=
 =?utf-8?B?OEpqV1ltVmNpNFZaNlVPeUZQOS96MEduZlJnRlFJZ1JVRERRdk4yZ1hhRnJD?=
 =?utf-8?B?cHVWVHhja3VFcEVJT001eGp5UU5EZWh5NDhKUTU5YzEzdU41cmc4OGl3aEpG?=
 =?utf-8?B?RmdabUdQUlEzRUtScTFJOGFQN0hJNk4wc3pGdFMwSXY2dTVmdjRrd1lCQ3A3?=
 =?utf-8?B?cUVKOTZMVktPcFBRcnlpdWlGWkxVNExiZjYwQzFsTU52SzMvdnpGUGNsUmlP?=
 =?utf-8?B?TnExemV6SnJUdXNUQVJxKzBhZnVKTzh2elVteVcxMkdKVlJjeUVmZlZrMzdl?=
 =?utf-8?B?YmlDVHJKSUxnZlhYUXczVXpaeW50bkJhMnUvRHMvdk0rRkxNdjRzWGRvdkNV?=
 =?utf-8?B?SnczNzhQOGlEZ09ucThiSWtyT0pKcnFSZ3BCNzlHZ0o5QUQ1eXprRGpxNjR0?=
 =?utf-8?B?Smpjd2xDQThJVXpPbXJiNDhOWHB4cVpid0pONHpYY1k4RzhyaWNmcW94Z2tq?=
 =?utf-8?B?UXVzcFQrZ1VhYmJaU2FrbjRrVmN4YUk5bXdxWUg3akZKaWVOZWJ3cnJNVktN?=
 =?utf-8?B?YzRmTTRMMy9PMDBuRmwyQU5jWENlKzNaYkJkRHAwWHlHVjY2NEJkV3hTYkNL?=
 =?utf-8?B?ZTJoUTlLVHhjVWZIWkh3R1ViMjRvRTdKSmthVlZrWElac0hNTUc2MkZ2QXhN?=
 =?utf-8?B?OXBPRmFHYVJsOEkrZ2JKd1B0aGlDZUx3RWZhdmg1WUtQbEZWcHlZUUtubWFN?=
 =?utf-8?B?c0E1Lzh5MHkxcTViTjdaQmtxbEcraFE2YlhsR28xMXR4ZlZiVWFEMmQ4QWhX?=
 =?utf-8?B?MXVvU3VIQklySHdlM1ROR3IzN2pEQnJrTjVQNnpqQnBadkxEeW5lS3RhOTdj?=
 =?utf-8?B?S042OURoWlpnaVFyZ3pWekxRdDJTVWRvRkVIRzBlZ0FJRHBxa25CQ2haa04w?=
 =?utf-8?B?RkIvbXFXYlhYamtzNnhJczdLcDhUN0NDUjAyVi9jNDJKMWVCNTRkT2toeHJC?=
 =?utf-8?B?L1g0TElueDJraVVYTlVDSlJrczRqTC9hTUcrc3ZMd2ZuNnVFaFlDZ2VCdTNN?=
 =?utf-8?B?UHpBbW02WEtCUGs2cDNGeXh4VlU3cC9BTTZJcFFLM2M1cWx2bkdjblA3a0dD?=
 =?utf-8?B?SnZKSzNLZ3dnRDFETmZnWVozWEZUNS9uMGdSTlgyT0U2N2gzcy9mYVVlbGR1?=
 =?utf-8?Q?iZK2HvgxVsKywcRGeb2oODLIb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b25c23-82e7-4b3c-b139-08dcaca144ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:59:42.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqZBySw7yy3rXqzDX71jpTWs61fnxPuR+WHgD8V6gkARP7cwdvjB+Q2PTw4H0/uNKVVBDQEuDZ6HrSnd+NxkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690


On 7/25/24 06:51, Li, Ming4 wrote:
> On 7/24/2024 4:24 PM, Alejandro Lucero Palau wrote:
>> On 7/16/24 07:06, Li, Ming4 wrote:
>>> On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>>
>>> Could use scope-based resource management  __free() here to drop below put_device(&root_port->dev);
>>>
>>> e.g. struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(endpoint);
>>>
>> I need to admit not familiar yet with scope-based macros, but I think these are different things. The scope of the pointer is inside this function, but the data referenced is likely to persist.
>>
>>
>>   get_device, inside find_cxl_root, is needed to avoid the device-related data disappearing while referenced by the code inside this function, and at the time of put_device, the data will be freed if ref counter reaches 0. Am I missing something?
>>
> Yes, get_device() is to avoid the device-related data disappearing, __free(put_cxl_root) will help to release the reference of cxl_root->port.dev when cxl_get_hpa_freespace() finished, so that you don't need a put_device(&root_port->dev) in the function.
>
> I think that your case is similar to this patch
>
> https://lore.kernel.org/all/170449247353.3779673.5963704495491343135.stgit@djiang5-mobl3/
>

OK. It makes sense. I was blinded assuming it was just about freeing 
memory, but the function to call for cleaning up can do other things as 
well.

I will use it in next version.

Thanks


