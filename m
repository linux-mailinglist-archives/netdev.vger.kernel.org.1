Return-Path: <netdev+bounces-171606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D0A4DC8B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB8416D4E4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D34200B8A;
	Tue,  4 Mar 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLCjpTiN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08911FFC65
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087644; cv=fail; b=njKDS3vBs1/5J1IJK4S6W4KJhsGuneySlijie8fSoMyJZeJga13od5M0zknLEDT214J9+U0TwqNkuRN/HZ6LSYDCZ4g8XLfnrVbkHNsxXLNkdmCan4twU4OgZtA8NGxOXE3dxvOkPP6v08O65PJD7fSIMaFyl39l9ZWWHVn/2vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087644; c=relaxed/simple;
	bh=RCncSJktfTo0Oj32C6iRSSPaZt+5knONfEW3ml1zM1s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GC8UQLHIZapAvzq3WKDPhRJL7LTcVhTdssLea7KZ8GbW1vuaWHb0LI18k5SoUbz7YvXZBMHW672h7uh211lJ5NvCBzitMhGTczXFcNYTLzHfnWogNsPVIlcR5One1HmjknVA4KqbYK9hPVP8drw+7trLQoHZhrXTtxD5ayKv9fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLCjpTiN; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QioOxx1zyT+c/x3CVwxS91j+iSiZ7HWNKeSBttKFM2g+RorzksWTEoEmYU61ZU+IqcSX76KHo++ki8yAwoBQz0T5VVToytkyqxgexFlGc95xaHfbmhqNkN8v9fPfkAIxffx1q8mkMxHHRW87/TMwFZChpcJVVz2w4uibj2qlqFUjy1+osvXLkvOXI1OiOnhBrJDXnlHi8/iOy+DctxrjH+Ya+chVF4t0+9PSGUlskpqA+VHWlKBdQmepXNPfS71FpEAHYg1uhLy3oNIW82qg5cDCxDhq327fHuQ/pRF9DVYk55VWxRTyl7nIi9Z7Qr3jtMZn8QxVjZHLBzabDFQA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCncSJktfTo0Oj32C6iRSSPaZt+5knONfEW3ml1zM1s=;
 b=fYyFjBKR0g/wr0V5ZONII+LXNsnalXRruddGHHiow8VFtHTjmUAUB9kryokALgaDSIKMir6FBWxtTYrHTlS3iIVGpZ+/t9F5vyxSnZhmi87rgf1xYgCAvgWPRVFBgsoUsOEym9F/v8w1Ki4c9JosL7JRanqBoZ1U1GqMmkIYfu9AUzXqBr8+ohSicGT1Q/GD/tpuOPMpzbkN4/E5QR4X3tuyNIzDKo09WYr8PJcPrasj44lx/S1Q2v6El+c0UXfyViJp/rChgJvOZp0scSLIX8OQJNzICcv2deSWoP2YkeCQgakcdO+5Su4jlFXPiZM4yRbdy6mhxlk+IPJ3XHF18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCncSJktfTo0Oj32C6iRSSPaZt+5knONfEW3ml1zM1s=;
 b=cLCjpTiNBRdjjX7S/qCcPhL3c5AVR+TmozPjZpWBtEMOCiDOzlAeJenE2HHVizv3BwYEExzQVp3ehQ7oU01IDqmtYyKCmIzqEaPc+hetRHFoxXfnUxvSQD9+wrlWWWfCHb1e+VcNAcye54nhvqgtzcF3OYcfaPXGTq4rK07LR0U/WtJptZ8v5b3IAJtdN8bRJ6JbjZNnAXNJmIiIGwFhAfQWUkVuJbNL05VUnt4EAJjXW+1Tu4gYrTiZR4sCV0ehBhjYUbCeNWHTptJEh9re1rgfJYwt35xV3/qU8+ZC7vtwJ6pz0xZ5ifN+XWe6JXRE/tntEbkx7/MTq+GIaRk0Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 11:27:20 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8511.017; Tue, 4 Mar 2025
 11:27:20 +0000
Message-ID: <49eec305-10c9-46f8-9a4d-c2b48660764c@nvidia.com>
Date: Tue, 4 Mar 2025 13:27:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
From: Gal Pressman <gal@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>,
 ecree.xilinx@gmail.com
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
 <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
 <20250226182717.0bead94b@kernel.org>
 <f5bf9ab4-bc65-45fe-804d-9c84d8b7bf1f@nvidia.com>
 <20250303141717.67f6d417@kernel.org>
 <a548dd08-48f0-404e-8481-3fa5fb3090a4@nvidia.com>
Content-Language: en-US
In-Reply-To: <a548dd08-48f0-404e-8481-3fa5fb3090a4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::22) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a890ddc-4c10-4757-0b33-08dd5b0f8693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2lnRXdiVmR4b0NEL1NlZzE2SFlNS3cwci9CWXhtRDF4b04vdjQ1Q00wZGg2?=
 =?utf-8?B?MDlaNW5qKzk0RU1QT3hmdUVwTXVYYmVVUnc5T29ueVUrLzlyR1N6MmozUDdN?=
 =?utf-8?B?dE1OUDZUb1IwT2ZDQnQvOWdhRHY5bXFlc2NULzExU1V0aHBYSURaVTdTRG5E?=
 =?utf-8?B?NmtXVGdUQ1UwMHR0eHJPeFdndVErRUE1SHpGdVVDRlBNVmt6SUNEZUhWbnVY?=
 =?utf-8?B?WnJXcU9oak1EYmkzVUJFRUdtbnNncnExNjNsN3pqanlEWXI1dmdXbjFhays4?=
 =?utf-8?B?cSs5TTQySEkxbG8yRUJ4eVZTYk1lNmZpMnZKMGZoWGpQUk8vNk5tU0hMUThi?=
 =?utf-8?B?QXpIZFFMSnFnallBU2ErZFNHNTREU21jUGtHQTZzbXhnZGErcGFWa2NEZ2FZ?=
 =?utf-8?B?MUsvYlZENjNQL2tqQXJqYWxnaG9nR1Y1WVVrUkx0V0swZmtycDVYTDcwSVJU?=
 =?utf-8?B?ZHF0ajM0QUNyZ0RSdjFHZm11emRUVmMrd0dpY3EzWDlleWNNcUhZdEIzOFUz?=
 =?utf-8?B?NDU4L0RFczZhOUh3bzZoRThXWmhjckRtRzFRRGlJWmRnckJHUE9mNWpHSUMz?=
 =?utf-8?B?eDVVTWYxNTFONTBOcWdnaGpTMEc0TCtvYjUrelBKOUNrTWJiNXZUeTNYemdT?=
 =?utf-8?B?NG9vN3NNSmxRWXE3UEI1R0dMcGhzaG04TUh3TS9RSEZEV3dLSDI1UkZXNFBH?=
 =?utf-8?B?RVp5Um96cm5vSWU1dVcycUlKSUVOdDNyYTRnUlZnZ3ZtSXpNK1poZjNadXp5?=
 =?utf-8?B?Q2c2Z1dmbU9QSUR6a21mbFNEUnlFaURIVGdRK0laWXpQS3RHaGZidzNHUEJl?=
 =?utf-8?B?Qis5Vm1QOEpZbExQdmlONStyc1lXUGQ1TGRaYm9keWZDZ0ltZXF3N3lwTkE0?=
 =?utf-8?B?dlpzcW5CQlJ0aVpibXNvVXZldm5kbDRnUXV2L2xBR0FDNzFxSkEzaVdPVW9l?=
 =?utf-8?B?UkpiV3N3NVdGWksvbVp3U0JNMGViTXE2YVk3c0FIaEdtZzhIVEVDM0JGOUxq?=
 =?utf-8?B?cmgzOHczZWE5K0EzamhPTkFNWGdtRWFmd2NjM2FoVmp0bEVNVVpZamFsWjhw?=
 =?utf-8?B?WlEyVjBpSmhXNEZtYjhBOGU2VkVEaWFDcGg0RmtvdzdqUENyU2ROcmR3NWlY?=
 =?utf-8?B?WEdneVJpWlRUTzkvSHhOandqQjVmakJBN3hDM0laYWhOMmI0SXlkKytsZG0y?=
 =?utf-8?B?aFdXUXIxQVladzc3Z25sV0ROeC9WTkxBMy9mcVRESEJSUzdlblBSUGZNMmY4?=
 =?utf-8?B?RkJMbUV2c0RUb0ROQ0hHQnhHWHNqSmcvK29tdUVRbUtZa0Qyc1hCbWU5cEV4?=
 =?utf-8?B?MjQwRVBoclBidkNBY2JHYkxDMEpFV0ptVzBCNEtzbDRBYTBBYzAwSlNRR04w?=
 =?utf-8?B?RkZHcmJLTmJVT1AxclpHeFlqRDA0d0ZTMXI4M1NKOU9vS1ZyQVJscTdIRHI1?=
 =?utf-8?B?dDN0YjFtVHpiOUUwbDRpRTdKbitSbTdaeTBOcmlUSXRuK1NBZUcvbXRDeGVQ?=
 =?utf-8?B?VHM4MVlrWkRpaERhVWVTTURlWkE1TDhLVXFvREVlM3UxeHc2V3NDZFZNRkxr?=
 =?utf-8?B?R1ViZTZHUGliOGkrT202OGtEVDJqNzlQeDlMaU1KWWp5eGRNQ0lxU2ptM3RF?=
 =?utf-8?B?c0RnWDZEa25Ua3krVEZaRFMrYzVjNjB2RmhybHZkcFIrdEVsWXdCd1dSYTdS?=
 =?utf-8?B?cWt6WEhjVVhtWkcrenl1VTBnZXhiTFA5RVJERm1MSzIzanlIbGNuK1ZZcHRS?=
 =?utf-8?B?aWc0WGZGaUt5cHhIaWl3THVnTXhBVVdEVXdhK1hwM2Z4bXBIck1qRTN1OXUx?=
 =?utf-8?B?bXErRlhmUFJON08zdlZNT1hEcUU3aXdxQ3RsRXo4cWtsUW4zZFZmRGRYTjFY?=
 =?utf-8?Q?K8EO5N45V2gDR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTVTQ3dHdVRHdzJEakVOcmdHVWl3ZHRrd0RJUkNBL25IcVoxc1Rwd3h2Z0NG?=
 =?utf-8?B?bkY5MnMyb1VtOGdOKzJ4dmJ0QnIyMDVMdjY5QnZyMTNCK0hyY3Nmc0s0YVR4?=
 =?utf-8?B?bncwcks2QTNTOENCRmY1TnN5VWJiSUFqbzZCNkgxdWFwQnY0SHlubnZpcTFH?=
 =?utf-8?B?RDFleXBnNjNFak5RRmlOcU1SeEFCV0NEN1hzQktzUHpIRUQ2b1hNNkQ4eHJD?=
 =?utf-8?B?bnNKWkcyZ2JxQ1VLQkVHQkNwL2JMOExLamdwT3JlOXI0SjNwMFpuWURkME9u?=
 =?utf-8?B?bEpGNXFSWnVyalpzMWs3SitFbUw4cjFlUEk1bWdHSXdDVG82QW01MHcwcnho?=
 =?utf-8?B?Y2JkeXpSbW5RRml4VjBpZkZJSnJpcDdEYTBYam9qL1JrajZRWHpjZldLUjhP?=
 =?utf-8?B?YTVkcXVmWXpiRlFOSTR5K1hrK2lSeHZSaDhCbkhtZis5WkhUc0h6UEh2dXg2?=
 =?utf-8?B?SzVtU0pTcll4cVlNbFdlRndjaUc1c3VOM285dEZBWnphQUF4cHNmeDlSSW4z?=
 =?utf-8?B?SVBFSTVBODFZbTV5SUxJbFNoNVVwdEFERHUzZEZ6QSsyZVh0bnpWUlRKT0lL?=
 =?utf-8?B?aDh0ZmtQc0xENy9PYWxodDYxTUFoblFHMzAzMVFxeXgwQllYNDRkcnE4VjJs?=
 =?utf-8?B?VHpjM2g4UGNXRjlIOTFDYlUxL0VJLy96UGZUODVYb3c1elNoMEFySWpBdkx1?=
 =?utf-8?B?a3ROQnYxSE94VmtubmVCcG5XVzc1WVJ4eWQwUmJ6TnQ4Q3hqRlowZzdNenR4?=
 =?utf-8?B?VWZFOWFLTXJTYzdIcjBvRnFmRkhhZUlpaDlLclorT1JndHE0b0FMMWNXZGVX?=
 =?utf-8?B?RTdUUFdjOW1BRGhIZUFsVDNMWG9UZ0VqVkRLSjVtSEZmd1hMcUJTc2NtWUVC?=
 =?utf-8?B?VUhaMEx2bFhrcTNaTWxoaDVRVzVGWXJJSGc3akVCMXNBVmtzOGdoQkxQVGU4?=
 =?utf-8?B?R0ptL3FpeFdzaFBLUXlnK3JBY1ozamp0SVJpOCtwRVFoY0cxT3RTOEtpV0dN?=
 =?utf-8?B?N2pGSjFCeVlISkFYOGozQzIxcWtNRkVFdHJQbHQyTnlJTlZYZDA0OWVub2Jx?=
 =?utf-8?B?WWpoK2tEWXVWNDRzUldWZnEzMlJqNTNpUWpoZzdvT1VjRmUyWXNTMDJHMkhz?=
 =?utf-8?B?RFFVbnFSQXFwc0c5YVFkV29VblJyaFJVRXVqKzNwbnBJOFIwZTliWlZCMUFD?=
 =?utf-8?B?cHA5VGMwZWxLNU0xQkhTZW5rTVVpUFlBQVVPdWhSSWFaS0JyTFNhKzg2T1RR?=
 =?utf-8?B?RlNTVFAwMVZFWmpLV2w4L3lmajB0T0ZSMmRpeWY2bnJXZjBPWFJGUWVJNEVW?=
 =?utf-8?B?VVpKUnJ2Y1YxcHJ2WUxMOFlTSE5BenNQd1EzaWxOdlNRZ21XaUJtS3B3Z3Bm?=
 =?utf-8?B?SWQ1bGZ0QkpMb05IaEpZb3RQSUNTem1JQmxYYmlhSjVWelZvRXJzbkZUcG9z?=
 =?utf-8?B?cXgvbGlBNW9EYjlnZVUveHFaNFNJa29URzBTdGN6R0tmL1hQZldaRGpsUjhP?=
 =?utf-8?B?VFVMb0Q5bDVCWGxXR2N5TmE3RGluTDNCR1E2VnBkZUdTRzV4VWNKTkxqOFJQ?=
 =?utf-8?B?QndacmZoLzlVMmFkdHNBTS9mVElQWWdLZWx1VXdqNFJYcTJ3Mnc3ZVRlSVU3?=
 =?utf-8?B?RzNBYWUxT3FZNW1HNzd5eXNieVljNW16NlVYQ3ZRNlRoUUdPeG1UYlNFMTVH?=
 =?utf-8?B?b0E0eFNPL1Bwb2ZZamZab3BqUk5uWXhhNDY5Ujk3ZHFLRnlINERYRFd0SnZP?=
 =?utf-8?B?Y3NnVnJwa1QyMTdwSDQ5Q3Q5dUdXSzROdG9pa0diS2lGU3I1Nzg5NnlxbDNN?=
 =?utf-8?B?bmZpMnlGRGpuZFBucFE5MW5WUysveXZYMnVuSWpQVzhQcGt0NUgxUloxRXZQ?=
 =?utf-8?B?dVBRU1VvNzRzRXVONWhDUUtuWmxmcnduMVlkQm1QS254WEtlb1Z4Z29zRXRJ?=
 =?utf-8?B?OEFLb0ZZejhuZXJ6WGtGZENLbHJEcEIzclJZVkt1UmJmSGtaN1daNXNLNDQv?=
 =?utf-8?B?TVhXclFTendaenIzc2t6S1dIbDEzRVc4QmkwK000VlJsRng4eG9rQU9YWEtR?=
 =?utf-8?B?WEV0d3FwK1RWUlAyNm81MWhibVNnV1phL2FSN0dvUFhzenVHaTA1eE1rcGtT?=
 =?utf-8?Q?qs9FfwzlkjdQtNvnC4eL4IlWn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a890ddc-4c10-4757-0b33-08dd5b0f8693
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:27:20.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /y34UUXADtpAz8kyJbMBOhCF9mouQMroYK9JVKa+3+xhvrA5GeT8FUbyoXdTeWg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

On 04/03/2025 13:09, Gal Pressman wrote:
> This is a bug fix targeted for net; the test should be submitted as
> net-next material

* Not accurate, targeted to net-next as the bug is still not in net.

