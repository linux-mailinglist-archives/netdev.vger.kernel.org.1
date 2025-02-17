Return-Path: <netdev+bounces-166992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5EAA383EE
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2541724A0
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794B23C9;
	Mon, 17 Feb 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gCB5u3mL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9321C19C;
	Mon, 17 Feb 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797601; cv=fail; b=uCX3WjNmy/ztmKjoWMvi9SVeLPzX1dwybu9C7RVV2FZneTrYlrR5KmrMDW9Zy9DqcbynM6KLTql23xw8pYDV2ScKzyvTSDF3ZpB1RQL70O0L8Mfl2Wy4741EQrBHW5y2EHZ3FHQcxVsDnrmSCs9YMHBza2JAv8WTbptvX+DIBQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797601; c=relaxed/simple;
	bh=11EQOMqmYcDQj6UP7XlukTBBA9KrPdROJn98pWRXzmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r8gnMaFMc98WeiIoXPeQcSdTTIs7lSrdT8Cn4y52gmTMJkXrhX5M4gCBxiycuWfnRd++wF6DuS74T8JTK6mf0BQs/9xpWEBI2h/lyjZsdz2bdLtCRak/zVXa9zP7ICHbvQ5CsBq89Uf1xyBkLVV/+Aow4NJU5cCNHSzwzNlSCr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gCB5u3mL; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEqFMcqjL1ErBJJvc8EnWhs0ZG3IKdylRLDb4xSW29XqeYhZi1yzkHUtxg66f8jQOdq0EoNhVlY4eIMnBLE37INTz2FO3gWrdEXTaAWMJ/RBAJvsW2zfrGn0YXU4b4Zvrdv7+Kyl+cHZ/S6C3GhkKfv0OOTgZ/IfLspiRKNOGd+3eCzDgUQLlk5qzA2G40YiwWxpcZWE5U+OXavKRCyG51mGkUWR/JxV+jY3wd3sL8qFkQJqp9jvJjvxpNHSkiTGFuIPNIy9B5jADKQ3qFWjuCfQyE0h7v8dhg0rYSZFGiG3Z42Fo50L5OLolhSA2hixijP0JayFfkvuq+fpJP0wIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fstCZQQLx8P73ddRH9hprz9d1HzZU5eUa7AaTdKZdKU=;
 b=hdrf2KkB0k2JEmfdvuo5boAjH3mkta2eDe5F025/JY0nlYLsLqxEc6NKf3Xo+IJNKZGlWFexBr4BCok4T05K7mRSUmPjHUOisUi7HLewqXR1MWQHzx9eMBsp9EFRdc7HpZkHYynpqDh5qEv7DaOYdzofv15PLdKooaCmEdruAvFvpC0HB2kpTr5hcb40nJRiqPCTyyVMztzmdpohAug8kNtWlpn9opLsjGXsjPrAILohQkidhcXwPAaRsoPEEiQRyT8VY2SODRpfRn/YAfg4BCenJLg2ml9Gj9HPZPQQ2+aE6LKV7W76kVVolYlyqWiXjLX3YApcun4ZLH28XWMXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fstCZQQLx8P73ddRH9hprz9d1HzZU5eUa7AaTdKZdKU=;
 b=gCB5u3mLV/Y7/k2wxk+qZf2Q09HKMGKe0c1zSaXYEUuRewUeALu19pXECvmMOI4jrG1SoB3bF+X7QIbNDLOES49o1qxz4Fsm1BYLsM2Zmr/Ts85bO1IdsO/RDalEC49WJzw+5VXphk2A5ibfJgw9TtJZVVpKXpiTPbsu4SlG4BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Mon, 17 Feb
 2025 13:06:36 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:06:36 +0000
Message-ID: <c4da5f36-ad30-44a4-bb1e-6f51ebbea588@amd.com>
Date: Mon, 17 Feb 2025 13:06:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
 <Z61tsoz3_MGrjvjG@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z61tsoz3_MGrjvjG@aschofie-mobl2.lan>
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
X-MS-Office365-Filtering-Correlation-Id: becade25-8637-42f9-1f62-08dd4f53e8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aS90YllMMi9mY2JhYXhhYnNudTdXd0N1TnZ2Q3FmMmlUaW5uVzIxTVp6WVFT?=
 =?utf-8?B?Q216L0pKWnlMbEh4eFRXYmI2eHlsTXJBbExMYkJCWnd2ZkJMUGRUU2dzRnJW?=
 =?utf-8?B?Zm1tUnNMY2oyRk5vN09PV3FGUWJsY0haeFFYOUs0SmVYV2MzK2JCWnJPRzUw?=
 =?utf-8?B?K0ljMmQrUzhObEQzbGpxdE04S1RYd1QxeHhxT2xUUTNyUnJCYXF5WVRNd2lF?=
 =?utf-8?B?MnV1ZXJva1hMYUNsTk5nb3RMc2NFTW5qUjRmMXhRdGNiRW1qZ3pyTUpyRHdV?=
 =?utf-8?B?Sm5XT0F0cHlBcG1QL3htMm8rZ3R3YXpadzl1YzNFZ214eUxsenBHYmdpUHRn?=
 =?utf-8?B?QUI2MVJpWjdLT0s0QWZhamVPaW94N2JRcXRRNjV5V2ltSGE5KzJWUmhqUDY0?=
 =?utf-8?B?dnlFa2RnUU1CQjBtSElFL2NTalVIR0gwQy9XVHNFZjBSTHJrSXRvL2h3MXdm?=
 =?utf-8?B?SHJhcnlaaVBqNkxlei83ZWFHcm1aczlGdmNvVlY4THdhc1UzVFhkYS8wSVVs?=
 =?utf-8?B?RFdpZEhSeFJ1VVlpV1Q4b1JWVGRQdHo5Z3AreHNjemNKejRWbkphZk1RVmRN?=
 =?utf-8?B?QXNxWm1oU05Wd29mclhuOXE0R0gvc29heTU0QUNTN2dmUnpsR241dHlKcm52?=
 =?utf-8?B?WmdqWmUwaDhFNEw3Sm9LbnUrNjljZ3A0WHNzOFoyUnBYTzFqaExuUGlkM1FS?=
 =?utf-8?B?RThnaHMrTHVMVDBycEVtYllsZzBxdlZodXFMd0JQdmdadXlHbzVRRUUyMWJE?=
 =?utf-8?B?YUVKSFk0QS9hYU1lVVd6YkQxVTkzU3JIYlZvSUpsQk41TmREWUhocjNPR3Ju?=
 =?utf-8?B?cHowNDBZclBZSDJMYmJLd3R5d3YrNHR5UXhndmVHS1VZc29OMEEvUWpBaWFr?=
 =?utf-8?B?eGtId1FZMzNVK1V3K25tL1daMTRHVEdIaXU3Vy9YQU1zWDI3ellDNEI5aTMy?=
 =?utf-8?B?QnBzNVVzSXFXWWNsVi84bFlEeVpsVUhTUlZuMzVPYUtzaEIxQ0N4QUN2T0lr?=
 =?utf-8?B?ekZqTHZNVFZXZWVHR2xFSjQ5SjVIdDArR2tiNkNiellJZFRVUVkwaTUzckhW?=
 =?utf-8?B?Y1J1QjJPQllsRkxYMDd4OEFoSjU2dzJBNGRoc2VZNXVmL2dROGZZUWlSemhP?=
 =?utf-8?B?K0w2bzJ3Qk9IYUU0VUtCTDhEak45c0o1cDVpQ25zUmtzeDBUVk1HUWlPOHg4?=
 =?utf-8?B?WHJ2Y09ZZ0Vra21WQ2N4WCtWc0FxdjBBUG9JT3VwODEyUFh6Q0QwM1hVdHlx?=
 =?utf-8?B?VUExMW9RL3AwUTZ4VmFDOFE0MUdxOFpqS2wzMkJsVTFzMUVvWFlGczYrTTVt?=
 =?utf-8?B?ZkdrK2FRMGVsQkhWVW9JK1RZZUpjTkFUMDlQa3NWM1lRYlZjY09OYmRyZEVU?=
 =?utf-8?B?RVpscFhXV3NNcXJ5MDBRdTlZdDJyc2lWOWxuSm9aS0NQeVlIQ3lKTGY1WjEr?=
 =?utf-8?B?bWg2MWZqVlVoT0RqOXRQYVhESzFHSGZJa0ozRE5HRTRlNkxTcVV4a1ZqbzZS?=
 =?utf-8?B?eStFUk5sekIza2g5ZGJybzhENXdzRmZ5NFVFUGM3aW5mem5tV1hTTWVXdGhI?=
 =?utf-8?B?SC9yYStBdjZEYWZkdjRLTXpZZXdIUnFOV0YwU3hFSlhVOExuMHFrckJCZXd3?=
 =?utf-8?B?MW9zU1ZtZHppbExuRkZCVlYrOGNjbDNPNGpDMDdOQzR3ZStJYXdEcDlTZUxz?=
 =?utf-8?B?SE1XVFlINlFLdExqRFQrSVdsdzg2aEpyb3c2WXkvN1M4L25zYktWODlTdU1K?=
 =?utf-8?B?M2x2V29iNk1xOFVmUzhRK3NmTzhNMzhJV0c4ZVVXVUtWd05FWUNaS0N6VWdr?=
 =?utf-8?B?UkE4Q2xVS3hFeWd1YVhNREFZS0RKTDVSM2F1RFpYUVBTZmdDbmJKSUw3bkVI?=
 =?utf-8?Q?HKH50oBfy6NC2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2htUDNmN0xHZlhHRUtlaTJGWklUTTdYemJtMkl6SkJUN3huSnQxMm1jdXU4?=
 =?utf-8?B?UGlEMmZwc3U0RGo1cWhrbklzSGp3WGNETERDSTNWNjlBN3FuUTh4UGQ5L1M3?=
 =?utf-8?B?VTBHL1l3ampwU3dSdE0yVFlWS2JsT1VwRFRPV2hnNEk1WHU2N3dtdG1mUG1L?=
 =?utf-8?B?YkphZEh4dGQ2RUZrME9sVlFqV3hwZVJ1T1VBUitIZGRMVEFFazN3eTVsb096?=
 =?utf-8?B?cEhFVXNwWWlpQVdpWlFkUTEzc2lJM1ByN29Yb0pqZmZjaU80WldGdkNIQVVo?=
 =?utf-8?B?MHQ4dkNReXl6UTRWNmVVeVVqK3AxeHB4OE82UFRaR0Y0WEhURHJsNjlnMllY?=
 =?utf-8?B?VFZuQkVOblhnSldtbjBpc1FYWUNsczYzRnN5T3lQQzF3Uk5GdElTVlIvTEl3?=
 =?utf-8?B?ZmpJY25HalRuNVh6K0hBSlRaRU5zL0xuL1pKVWE1YVpGU3B3WVBoT1NScFQ0?=
 =?utf-8?B?SjVDMFNXLzhNN3lKbnU3Y0VkdmZkQjZjMkZKWmtIY0YzdFk3UzArODcxdkht?=
 =?utf-8?B?bzE2UTRkcWVBTmVTWGgvZWYrNWlTZFVxamhMdm1iUWJOalVZQUZFR1U3TUx2?=
 =?utf-8?B?bmxIRERSRFd6YmxsRHB2V1YwOVd0b1paL25OaFhxQ1UrMWl5TnU0Sm5OQXJD?=
 =?utf-8?B?eUxCYnpQRXhBSGNBQjY4ZlVOOXdXbmpvRlJrK1J0VlFUbmF5cDVSVUh0TzA5?=
 =?utf-8?B?U1JVZmZMVi9hMVVVck9EK2J1bVFCQVBoU0hpTCtKSWpaWDZ6bEZ1M0ZwbmNO?=
 =?utf-8?B?K0gyM3ZtUjU3SGNjTld4MUlEU21ERHhJWGpVKy9nc05VUDZ5NmlTb0dpVFRH?=
 =?utf-8?B?TGlEUzRwY3B3RURkbE9PT3FxcWl3Y2c2R1pleHlKb0ZoUEFhRjQzT3hmNmlG?=
 =?utf-8?B?Wllod2VBM2k2dEl0RGc5NWZsajJJMDNCc3prcUoxYmw2VWJTN1NFZFd6Nnls?=
 =?utf-8?B?YTNyZTFzKzhMQ3BaVXlLVXhXN3VwK1gwNlFFR0xDNnVNZmFoZC9JWTgyQy8v?=
 =?utf-8?B?U09hNEk1RDA0TXNqWDU1ZjBoT1ViaTFHczZWcmxkMVVhTVgzNjQwS1RSMExN?=
 =?utf-8?B?cVVBc3FsbjRtUHE1bFhGRFFBMHN2bVVHVjJHMm5CNVk3bzVqVktQTW8zbkV4?=
 =?utf-8?B?M05kMWtzdGhqYlNUaE0rUC83VjBOMEtjaDBkWFRxaHNMMUZMb0lZSUkwTFhC?=
 =?utf-8?B?ZERMamIvNG9mWWU5MlVWZ1VPd3lqYjVzVXRCRzlBK09qS3BxQjNtOXc4L0ZD?=
 =?utf-8?B?ejRJQlRJaGJUSDJnYnVncmVQOXlvQkIxRERrSnUrSEl5VVpiUHpLOTc4bFZG?=
 =?utf-8?B?Zkl0eEQrLzd2L216bHQrYmVPa1VjZGNXWXF0aVhSYWUyVlNpTm1xQXhQM2pF?=
 =?utf-8?B?aVAvSE5CbkxOSXpkK3FkWDlUTzdSUGZxbHJjTEZvOWkyR1FiTGpYN2wweWdU?=
 =?utf-8?B?R2I4MVh1TVVuUWZGYjdXN0pJcE5tWUgzMGxGVXY3d2J3WE15RGdkNU1SZnRK?=
 =?utf-8?B?Y2NaeDZORTFEbjI3Y3gwYXhrbDd4S2tEdFlmUUVlN1g2ajlmbFhWMHhpZEkr?=
 =?utf-8?B?WHhHdWZqWnUyYUpZekdrVE9uNkZNSThhNXFTSXJ0Y1BOZ0Zrd3NpZzMyQmtk?=
 =?utf-8?B?WTc3UFBIdjNhbVJUYTJTQlVTWWdVT3p0cGhVNE9RN1BoQXEvUTVVTnFTcUN2?=
 =?utf-8?B?T3hUbWZDdjlQV1IzdUpINm1ieXlnTHBsU3VEZFhVaHRQaWRKQWluQm5vS1N4?=
 =?utf-8?B?MkVpaXN2S1YxOHd3aE42RVZwN09sdTYwWFpSeWhmS1g4eGZ3M3IyVXJjbEFJ?=
 =?utf-8?B?N3lkSUdrTU9vK3NXeERQSlcxN0EwN0F5d1ZqZXRpeExDY25kR1lRN2N3VC9I?=
 =?utf-8?B?NFd5cTkzUG16bUhFcFJMeDhocGFKYnVqczJFaWZWOTdUaE5PVzYwREVNKzJ6?=
 =?utf-8?B?dG42UGxtSXFLd0JVL3pqTE5ydEJrOFV3WnM4cjhUNXBJa1dqenBrMUhDNzR5?=
 =?utf-8?B?WjVrc3liR2ZkYVpPdUVhem84dHEwa0FiSitCSUtKeXFkZDdFTXZkQVE5RXBy?=
 =?utf-8?B?RGc4cmV0QmRvRm1yUFFKM0twUmVwTERuRlhzTzRaK3NaRmNUYmpDNmdJWWJi?=
 =?utf-8?Q?XqBtWeoKXuU/2SV7qBBdqduur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becade25-8637-42f9-1f62-08dd4f53e8d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:06:36.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfuikXanOS8Slsv7zDrOxi+8iMtaQV4Yxq4GngtnlVbr+ZLyXFRPv/BY7cSwpVFm9ShrET4T9VehG+oN7+3MUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031


On 2/13/25 03:57, Alison Schofield wrote:
> On Wed, Feb 05, 2025 at 03:19:25PM +0000, alucerop@amd.com wrote:
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
> I know you are only the 'mover' of the above code, but can
> you drop the dev_err message. OOM messages from the core are
> typically enough.
>

Sure. I'll do so.


