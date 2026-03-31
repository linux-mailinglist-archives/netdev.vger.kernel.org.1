Return-Path: <netdev+bounces-273560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJVBLvSgy2kUJwYAu9opvQ
	(envelope-from <netdev+bounces-273560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:24:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FE367E05
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E43F3228FBC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D03E3D93;
	Tue, 31 Mar 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mcMVOstl"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D83EDAD4;
	Tue, 31 Mar 2026 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952069; cv=fail; b=B95wBim54rHT0tLcdbo5+jjsN++ce+q8l62Zb9Awe3opCahBQvyHcdZXJUrs9yHhBdi/ca3cWumT061aqjYPY84jFUhJwytFpLRAQ/tQoPrTnjES+wZiXw13x0mZxez/z3dIFt42TqQt7OwgPacDkoOzUz0iSNMPFq527DEi9As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952069; c=relaxed/simple;
	bh=xe9DZiRT3J1RncW+IFNUCewpaXpyMteS7xMOYXAX1o4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CV/8nVKgjQPbaWKXx8A9NRelNvdYIlPfy2FGG+lWAvE/WNGKpT2SPLSPRbEmvV1PnYpSytDa4Ix+bjVg3GcG3ncl/k61+D9ZCqXJYDSuLcdOxvSE/GBLINS6PsJ8F/l1svZBtALFSaTW/UAQwiywYz+r67/aq1PGF4ENSeB8zes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mcMVOstl; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBtaj8dRI+10UcGZyVhRFgtZJU7Gm/cEYlpzwSoQbFO7K6OFaL5lWQOlI5coeBK4vYZQCH8ZZKuXjj/5xE0OcOmFHxArT+l97Upska6O5HjUYhw3F0SDGEReRx9A2sysjB9Lef3CdXLiHkTQU1dv7JlV9koKdwC5AIRHkpIlHOPpMM39afWfgrBteuy7yK6ZvjHtGOV9eKg6t2TUF6/72LZCZY53adYltZdgdT31Q6whQO5JTG6OiSPb3ty/uDMsTnCKBtwBFLSaWHm8JdUWWfR5iqRWLItAUtHG9YISE4edyw+1WaOG2KZNca+1s1kFg6wbQjbhMFXsdnXHe6lTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iED0JzlCmwdnBpBXlbxQSqeh2mJWHRAma4fnENG9DKM=;
 b=P6EYNHLZpdbgtQ0etfvjTMkxdhxkgoFbRWE6cygkDXA58RXPVBTYZw5iAsK5BuoXb7IXplUYgLwjJJJBs+0TM4wRPoeluMb2RnFh9yrPqv7zqvpP6ouhrSXm7gS1Zxw5g41wXhwkJ+Th5ykSe0rTKvLn8EX0sET1h6Ln0ujztULR/dZ7wdyM1OsAjTTdRz77tvcht2gcDhVb/1oAj28fp+NkJj1KsHK3IwFuh52obaAQHznDKc2guJOY857HHVYpzxooDpLWKGi8iZ293pL739DKCoI7aFDy87y/CJlBnSVD34Zh+tK7ew5x1IkKUq6KoJxPIbsK8R0tCerwYjYVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iED0JzlCmwdnBpBXlbxQSqeh2mJWHRAma4fnENG9DKM=;
 b=mcMVOstlV2Hf42aENQSGQ74nkDjVaHh96jIzM5Ts+6iYw8CIWSOcoaaWqwImfeofJS6HBcPwrU8DR5GXEqmadqrlB28ELRJiw69djdoqbUARrfteB6+PLR4no/9+XB4h0XgzEdJbaX8plwaUP01BCyZlFcp+JKH89fhgPh9BBvxLVV3l/TC5HXwzFEpa81AMDZobkJ8PSrtRqsdC2mFcFqfwsvaeR5/+mUCL/x9zJhX3xI5qQu2S8pc3RqzsDnH2be1AlxwjhfS15hTRWZpmydpJHV+Ibk6Jl2Up2u8Wqe+fPJC7uqq61I4SwBdzRFGa3Cp0ZKxD/to3z5XTm9i4Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:14:23 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 10:14:23 +0000
Message-ID: <01f56e6f-5459-4a96-9042-8a003a340fab@nvidia.com>
Date: Tue, 31 Mar 2026 11:14:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] net: stmmac: Fix PTP ref clock for Tegra234
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260325135811.148480-1-jonathanh@nvidia.com>
 <20260325135811.148480-2-jonathanh@nvidia.com>
 <20260326-gigantic-tentacled-hornet-cbdb8d@quoll>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260326-gigantic-tentacled-hornet-cbdb8d@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0606.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::14) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: fea1f55d-f4bd-418e-677e-08de8f0e4801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MJMqi5oOusXILGWhIeNV7pznos66GA+mcXeUQW2JDM8pjsTGA3VMFSRT+hshH1/TY8BnCC1XLV6LUvg4LKL/FLtWKNDxsfQRxnG2jaeGbUuynuv7zLcYP6QrDFqyrBqcxINImdYdTL5qwhbuFORqet0T4vWGgDnWi9Si8AD1alc3AwYF4w2xYLpMxbXwlequQ9r9OPvkXC82LyCGcobR5GIzOJcMSXECLRTR/bfcWqYxgfuwTK6blr128UtOzY76EuZif0FqkqC6Bg4rUUGYGB03nA5UHp/OrpX7IiQ0/8nDYWhYNUJflYIPZ/0QTExKQXMvg4HNR8TJdOO71k9+kXTdhyp3hubcgyCZeVbHppuYh2zAr5D4KfzW8ODteDdcRIBo9LJeiV35obvSAAlWDep/uxegnawCcwXeGKHxIACfOGEsaKeVNtxiR3tZ/mbhVddkD2S4KyII971AZgFXkp66Xr/gm/+pQcXBhFm4HQs+CysiUdSTNOgOX9GVa82D3Vn9z5zYsQzjUQHOSala2VMEGuvpJ918iUPGg8sKekMHaVfgoYEONLeSXtHu5YCxgAxmdZxxxefn9P/gAplU7u6/6efiB4UVo9Nfm+id3aicNG2M1RnLrU4YV1i08mXGCuWcA2+A5+7fnvoAfSB6vSjLhY+MvpKtoFwAlkWWECbFsNttPHcRr1mejLKCTGWz4N7PjG+1KSe+WJGWBhEEVQ3FQ4ybAqrzpIW+ZqSaRME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVlHdjNnbitrbDJhYTM2eC8rRDkyUDZkaDhlckR2QnJqbW1nY0cvL2kveU1k?=
 =?utf-8?B?c0sraXAvb256QW5xVGpQN3VVdXdGTGZYLzJYc2Y1Zmh4TXcwRThMbHZSSEt0?=
 =?utf-8?B?RlBqaG1Jczc4cGZ3NW83a0pvL2d5bnd3SXMvWHc2OWgvekZxZTJDMDVYSHpP?=
 =?utf-8?B?Z3o3OGl3YnJVWEwvVzdNaUFIek1CWkpqT3dCQy9aV1lKekEzQXE5S3dwTXNj?=
 =?utf-8?B?STdyNzhYN2JGRzlmd2JjQldWTE9NY3ZzWWZGZWNYditOM05IcEhjNzFvd05k?=
 =?utf-8?B?QVZGWU5nQ0pKK2RGVWlOZGF1TitXczdQdGp0WW1udnFNRkJxOUJ0cjQ5bW1I?=
 =?utf-8?B?Y08xS3FNcFh3dDFsT3JIdkM3UXBUNS9QSnBsRytmMEROTTgwaW1ZS01jbG4v?=
 =?utf-8?B?M0Z1TWpBUXQ4b2g5NGhQSk1nbnFjcGxLQmpJdUtqeUZUcDVMQ2JtaHhTOWgx?=
 =?utf-8?B?VytTbkxRL25LZGE4Rzk0eC9naVdPdFZSdm5Kd3dXZjVpQW5OTmlUZDFuenVv?=
 =?utf-8?B?SlFkdmowamFEOWt2Zm8xazViVU42c0gybkdaNXg1WUR3R2V3ZFJ6ZGhZWG84?=
 =?utf-8?B?Uzd2S3VDZ0dNVnJhWmpLSVNMKzNTc2g4ajFEaW5GQlV6UXVlc0dibXNjejZE?=
 =?utf-8?B?YmdZQ1RQeTR0RllqRU9iYmI5RzBLMGFVbkRabEdMZENScVNDeHdESGxMcFc4?=
 =?utf-8?B?aHlzYmc4YUZ3NDNnbWVJR0tDU1pMYVV6dHFJU3dNMnUxeU9OeWI0dDB2andB?=
 =?utf-8?B?bDFxZnB0RksyUGJYdnlBck1UQUNPSldFVE4xd0dKczJRSUpmeUF6UTU5UXNF?=
 =?utf-8?B?c3FZUFAvMGNRT01NLzJSRmo5VGtlUnV1cmw0MC91a3d5U3luVHJ0RUEzK3R6?=
 =?utf-8?B?b2JNQm9WRTJGOEUyNFdFK2VmYWpESUJjM2NNaU5HbnpqaTVHdlMrWm9EZnEx?=
 =?utf-8?B?bzFyTGgwMDlpd0hrb0tUSElUSzU2U0tNREtBL0FvaDNkcEVsc2hsZzF2bFpz?=
 =?utf-8?B?UzZyakFxOXB3QXZ1VkxZSjBTSnhxSnk3cytRTTVQZThET0tLRi80dUZxQ2Rs?=
 =?utf-8?B?UkorUHp0SmsxVDF0dzhkd0duTVNPSjVzVC9JU01yeVJMVFhWV1ZKazhOK1Ux?=
 =?utf-8?B?bEJtUVh2S1JqWlROZW5TS0YxRFhMbHhXZlRsMWpYMzRDTnh3S2ZJR3hCMzBy?=
 =?utf-8?B?eHpLYmJLM2g3YWNVMXpHaGt1Q0poSHBQMUd4T0xiVVUxQTFtOGphWmxSWGtH?=
 =?utf-8?B?T0NnUUs4NTJsU1dmejF4ODJSaTlSRTd1ZUVyMlg1dlFrNHprZ1V2aTVtc0RO?=
 =?utf-8?B?d1l3blgvYml6alNQNjE2VnV0NkR6TVdzRWUxQTVNNHd5dVFVMDVzRWhIZSt0?=
 =?utf-8?B?QzhPaUdEQlVFOFl2eGhaK1UvWEMxa0IrbnYwTDEybTYzUndFTm00WTdTTjdr?=
 =?utf-8?B?anEwbElsSS9xWUdPUnQyYllIQitYZlhhbjJGNDJHOVljb2xwMm10ejNORDVE?=
 =?utf-8?B?dTRsakJjWE9GaUUvY1c0Z3ZJY1ZEVlZxMFNrSWNPMU9JRUlpMHpKbDFLbVg3?=
 =?utf-8?B?a1ViemNidm5adG10RklmUWxqU28rbE5vaU5YYURjU3czNWxDaTF4Rm1JRGFj?=
 =?utf-8?B?dkY5S0l6ekRuajI0TGg5d2duQkFjZFp0NzZKaFF2SnZSOVMzZm9OTGRrMHpD?=
 =?utf-8?B?alR0SDh4VzNPdXBBMG1rK3hER28rZVk5eU5rYXNNSVBoWFhydCtkazFUUmxX?=
 =?utf-8?B?eUdDdFR5M3F6akVVN2kvOC9vNlptdjg5UFRGKzFrYTFrdDhPbHo5YzdnMDdV?=
 =?utf-8?B?cUEyc204VC8yTGVKWWsyRHhnVHJ4eUhiOXVkMUJkY2FCQy80REl4TzA4K3NO?=
 =?utf-8?B?QkVKUXJVbjdFcFpoRmgrcm5kVGM2TnZGdUlEVU13aDlNZUNkL0VOU0hYY2dU?=
 =?utf-8?B?MVBqTHo3VGhZMjk1amJHRUY0cy9Sb0kwTU5FeStuVm55Qk9hQU1NUGRkRzgy?=
 =?utf-8?B?Q1EyRExoZTN1aTR3MFBBRTBlZ2JEbzhOMDNpMS9yNEhjTnNYWndiUWQ3eFZw?=
 =?utf-8?B?Z3RlTThXK2FMSFpsMGJjc2Nic28zamhkQUFKc010eEtENHNiNzJKc1N6Unk1?=
 =?utf-8?B?dE51QjhYS1VCMHVKMnptS3djellQQ1ZMNk1UTXI1dFgyNHBPWmhHd3hqSmY0?=
 =?utf-8?B?SGNpOHM5Yk9TcThzbVhoNENTRFg2NUZCdWhPUDdDcklRT2lPQjhKbUtBZGw2?=
 =?utf-8?B?YkMvbG9NUnJ0WUNyKzdMWGtHSFRpNFdtY1RXNnZsOHQyZjlsL2hKeXErNkJC?=
 =?utf-8?B?MWJ2dkpRWEpVNnc1MWNyWmFVbkxjdUF0VFFWR1pjZGNjZmtQYWZGUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea1f55d-f4bd-418e-677e-08de8f0e4801
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:14:23.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCjX2fFcPEBis1YoKPWRTnFy6Qwn6Xc6c3bgDZEGA/qil9ZcDE1fJcA6p7rfV5V5QPRXfSTIC8/BPi1UMknrmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273560-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 121FE367E05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 26/03/2026 08:32, Krzysztof Kozlowski wrote:

...

>> @@ -257,9 +258,23 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
>>   	if (!mgbe->clks)
>>   		return -ENOMEM;
>>   
>> -	for (i = 0; i <  ARRAY_SIZE(mgbe_clks); i++)
>> +	/*
>> +	 * Older device-trees use 'ptp-ref' rather than 'ptp_ref'.
>> +	 * Fall back to the legacy name when 'ptp_ref' is absent.
>> +	 */
>> +	use_legacy_ptp = of_property_match_string(pdev->dev.of_node,
>> +						  "clock-names", "ptp_ref") < 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(mgbe_clks); i++) {
>>   		mgbe->clks[i].id = mgbe_clks[i];
>>   
>> +		if (use_legacy_ptp && !strcmp(mgbe_clks[i], "ptp_ref")) {
> 
> Why index 0 is not valid? And why -EINVAL would be considered as legacy
> clock present?

Index 0 is valid. However, yes I guess that treating an -EINVAL from 
of_property_match_string() is not correct. I will switch the logic to be ...

  use_legacy_ptp = of_property_match_string(pdev->dev.of_node,
                                    "clock-names", "ptp-ref") >= 0;

Jon

-- 
nvpublic


