Return-Path: <netdev+bounces-249855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC997D1FA3A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BEDD3003486
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCA318EE9;
	Wed, 14 Jan 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gdGGI5Oi"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CB3168F2
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403532; cv=fail; b=l4hgaGOmsGok62TJfjxSOM5mOLWBwS7gM3CwUFNqP589r1uJtpUTHy3veKCCA3aio4p2HY0hu0Fx+rvcAHJifHC0XsUUk+CF+AZ/iO/0+pXGbfrfG5VXEMdtU5TFAkVcEzHr9jI2hHhX64fM+BgF+dl+0ciE/VeD0cAoOt/IK+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403532; c=relaxed/simple;
	bh=B0Nn6qfJoiRvC4T26kCsqGzefspDonBKzgk3R7m2kLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J959yGP1n/T1QOId2UNkP7t1AFfHoGEtQpdWlH+pwtKJMHa0SciqSYQ1UJH5MtU/XIP0AT8VGQj4gc3u14iSTIpGdGflyD6YVl+SushvBlzS3awFtK5LbW+Zz1+kUd+d5Pzc0nkfjOB3pI9RFUC6ecA8g3orSp9JziiMsZ6Aq/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gdGGI5Oi; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naIw/rgcq53nApr/o5TqMSTp2wXn9ECK4IcjxnITfOkAQU7PgjGoSGQsgQIWJOxXARHcEBjvgHkHjttlddZHovVheJu7qWn2BfbAnjM/+yXnd14eE/r/oNPF/UgkCWSEEmdZ6i0gLqi/5R4PNtUXDAZ0IcTBfSahnnq5mZqUvX/lcHuwznWN/+yyQyc3jai4XVi0grZ70qY+QukBdCLhXgcIWj0dhCCqdY0bXTw1FXHVYfW0LaUvNVclBis6indqeYr3svu8kFz2ED9Dz5EDDzJtaetimX8pwjrQBXRILTsPdA/wG1iAbJGUPMjgDPC9+Un/WKNBBwJEHHp+rurhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohZ7zCPqu6UbvkaYLFIc3AYkgGY3NeGLpX+3y+kVyO8=;
 b=wqjpCSuhPQk5v18XI0yIi2phsSORt7lL9MR1KriSm8MR1+UHCJUjnDxExq2TI3jf3mCvn8ixkSukdR6jaLZaqcMFcBAO5CvTxdRNV9ekyAdsTfWMkH0a6jsowmTJ6MVvPS6k/0qfWGhyXHn4FktUYaMCTiOGK5xgPuWM2qQ+vXaeWYJwhGPoBcjZ54t4MEKBDPcqjpeSyUF8q3qYzLIej2LqG2Ko3fDimVwTZq7ZeuYwyey0C62XUMhZrN+yK22wpHwVJmeuJXHsxkBW12SSJ/daWXOwAp8TijYShXgimprQ/1Qd+SzkINO4VAcQccYhiLrhE6t/9FmPfxTVUb3H/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohZ7zCPqu6UbvkaYLFIc3AYkgGY3NeGLpX+3y+kVyO8=;
 b=gdGGI5OiovBlyYQnYujANuUQgQRJGqr10lYu4A2cDCyynf/JtbZjDCV+6i59rOCL647Q0eCKIL8g9ujrb4ud2PFmPGe9WvFDSnosUVevKcp2JzmTl9TN32bJyXOKskfH/fiETNukoMddsWheVbmHCUSCYFmBIWG/CtxF+Qw1wc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 15:12:07 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:12:07 +0000
Message-ID: <7ab70f51-9dc6-444b-b3c1-c6f0a661ab69@amd.com>
Date: Wed, 14 Jan 2026 20:42:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: avoid misleading per-packet error log
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com,
 Shyam-sundar.S-k@amd.com
References: <20260110170422.3996690-1-Raju.Rangoju@amd.com>
 <20260112192812.5b0aad55@kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20260112192812.5b0aad55@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 328a82c2-2dda-4a00-193c-08de537f47d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTVoNGpwbDVUOThvNTJIQnJVQVJWUituOXNzWHVFd1VYRGVIUkVxcEVzaVNn?=
 =?utf-8?B?RElJT01xZ1pWZS80QXdSSlZWTDIxaEl5RlM3ekdjVjdtUjJKd2Rxc2JsVWpB?=
 =?utf-8?B?N05OcDVlL0phbWwwLytyWTJiVG1NaEQ1dTJWUFIrZ3Uwc3VBa2xNZ0Ira25S?=
 =?utf-8?B?bzAramtzQjJSQjZXOGN2bkxUTjlqRjJzUVFicHNYekp0Vkt1TzhObWkvZ1FV?=
 =?utf-8?B?S0YwZDJzM1VMOCtqTDhVbmVQNC8vSXVNR21HRWd1Q1ZWdUgwczROY3lWemtI?=
 =?utf-8?B?SlVMTVZSRzJMUGREeU5QelpZRHFlc0dCNSsxME44Zzg3QWcrTEZJbzlWRHUx?=
 =?utf-8?B?WGRvRHNjcWFwUzUxUlZsdGZuS05qUXNmb285ME9YbUZIMTYyTjl3dmp2Z0Er?=
 =?utf-8?B?cDJSTFZPeUJlU3BaSzNURXh4bFVCRzRzSml6MlA2Qll2SmtwRERkT2UxTnkr?=
 =?utf-8?B?bUdOVXQwSkdPV2Q3ZEpCTlJ1V29TYXhoKzYxeHpqZ0NNOWREY2h3alJndjRh?=
 =?utf-8?B?VTJwVUdKR3p4U0hBUVNPZnNxK2JFbUpXRTgwQ205UDR4dFd5TGxqVkZyeU9t?=
 =?utf-8?B?VTk5UmFOeFZHOTAraGllbE40RjRaNEFuMUJUS0xlYU9DZU93SkdGYVRNNkEw?=
 =?utf-8?B?Q0J5MUJQQzZxTW5JeTRrc0w1QkxIdHFDZm53b0RVQktGejNKRjRmYURrT0tE?=
 =?utf-8?B?eEJ6MnNPQ3pwRHd6R0V3dlpvNzRDYk9FbkoyQVhOZmJtYXBGM0t5ekNDSTl1?=
 =?utf-8?B?Q241aFplY0FoR20rQklVejY3SzR4S2VSb0RJWC92QWRqQWQ2Z3pPcVArMko4?=
 =?utf-8?B?eGpYeVpxMW9abTlqUVUzZHZCNTFsVW1wUit5ZGEzQWRmV2szQUxXZzg0TW53?=
 =?utf-8?B?VExZaHhnNFZKQVNvQ2dqOHdmM25wemZUWVNQYzRsQ2ZWbERDcWpzZWRJUlMz?=
 =?utf-8?B?TTdIbUtUQjRlUXhqd2lKNXlqL0ZjdjNmdmRkZ1cva2E4eVJMVG1pNE0vcGR2?=
 =?utf-8?B?Q3Irbm9yMkNGWU1xUDlHZkxqd2RIL0sxY0tRdUhHYWpYR0VocW9uZC9tYVVz?=
 =?utf-8?B?eXQ1bTYvWmt3Z3FCbi9Ielh4bEVZNXJERHJYK2l2ZVdqbU1Jc0JDK2hUcG5M?=
 =?utf-8?B?MG5FWTQ4bHk5bWhBaFFIdVh3bmRNaExFU0thKzJHVVZXVDh0aGZ3ZlQ4eHB0?=
 =?utf-8?B?M0liS0NYeW9XYVR3SGdaVnQ5WjRtVWJIWTc1L1RMSXU5VDFPTDlmZ1NqbVRw?=
 =?utf-8?B?M3lpUXVIZlNkdHhEQWZpZUlxMkE3Z1U2REdZckRjeWpDTW5DdjQvVVZ3MHhO?=
 =?utf-8?B?dW8xcG1wQnJkQ1kxZmZhQjZ3eUdJT25ZRjE2MkI3Nkt0dTVMcEJSZ3VwempL?=
 =?utf-8?B?bDRjRzdXOVhaN2F0d3JNUVhXdS96dkVVY3l0bXdTNHhQQmhmbkJYSzFHOUs4?=
 =?utf-8?B?M05UcHZOVDQwdmc3VzhQWTc0NHVaMHdZUUk4SnlPV2l1WTJXQWpjL1MyRHNG?=
 =?utf-8?B?bC9CYzE1bTVGck5nNm5BcS9pdFFyRmN6YnRlQUU2MVVWeDNQWk9JdHFkWDFQ?=
 =?utf-8?B?b3QzY2UrWXNFTWx2ZCtLRWR3ajR3eTJFdDAwSkpiQk0rcmljdVVIbHZCM2FU?=
 =?utf-8?B?TjRDTVdVa1diNE9qaDd0NzVpVFlhYXFVRW9Cd1Z0MTFycm52aFcyNVMwWHps?=
 =?utf-8?B?VUd0Zms3REJzZlN5OG9VSVljZDFPdVZjUENiYUQyV0hvOGRHc2NwazMxRDVQ?=
 =?utf-8?B?YW53YzU4OFdCQVVSekdtVENWV01uWUNJSG13Wkh0OG1sRGx4T2VYZDE5S0FQ?=
 =?utf-8?B?cVVsTFNEWkpDRE5acjFBS0lkWjNpVjR1N1RNbEQyOEsxVWxXMi9Eb3EvY1dy?=
 =?utf-8?B?N3BvaXoyQkk0bW12TkRWNjZsMWtJaUNNN21yT0RlMGdBcU5ZREx6S2xMNjc5?=
 =?utf-8?B?Y0djQmQ3VmMyRy9wMVB3UlY1T2hIYVZIUzJzZFB6M25vcStxaGxDUUhrRUdh?=
 =?utf-8?B?dlJwZ0plSHFwQ0tSNENyMCswUFArQ29Wb0FOdUU0OFZZbDJLRW9VSGViZFk0?=
 =?utf-8?B?MHBZbHl0ODluTThYaFNXRWUveno3OCtLTTF5MjdtdDY1WjB2L2dsS2g0MjNq?=
 =?utf-8?Q?v4Qo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtWL3ZyMDVNbWs1eUx2b3paWFk3S2YrY3Z5eXcvZ3IzL2NJenhyZ2tCa0Ju?=
 =?utf-8?B?eG9EeEkwK1RIRnExNCtPc2djdTdzREFNbnMzRExLQjRCTkwyQUFNUkQ5cmxZ?=
 =?utf-8?B?MTQ5RXQwRk5SVFJ1SEhZbTF1dGVjeEg1V1M4WjZNTG96N0NBMkdBZFh1cEpR?=
 =?utf-8?B?b1BPOC9zeFQ3S2N4ejhJUFkzbE5xSXVqSjVHc2E0SGx0QXVsY2lya0pkaHJN?=
 =?utf-8?B?amFOSm4xbEdQSHgwcXZrcEQzMHFzYVkzdmZlcHcwSUJPbEs1ejFsRXR4VFBX?=
 =?utf-8?B?ajBhMUh1dXFLV25NcENBWmpkTXFubzBiWlVnamoxT01USGZLOGdmM1NZQWcz?=
 =?utf-8?B?ZHcvSi9hdnFUSE9RUzFYRU9wanhQRUNaemFCYi9KWVRSK3FJSmlYYytWSTA4?=
 =?utf-8?B?dVpBcmRyV2ZSMXVuZ015S1g4RXhmYVp5aHR6WENMalJaR2lJbm1jRDBhVFh6?=
 =?utf-8?B?WEdnWnU2bEtFYytTVjVNdU1NSlR5TE11dktlREtZeTB4WUJTa3FlTU4wTlVR?=
 =?utf-8?B?cWFNREl2bHFkMFFLQVloaGRrQmdJRTcvSUNaNi9jRWlwZ0JMR0RkVjM5UlpN?=
 =?utf-8?B?Mm81VzRSbkV0eG1zaDgwNnVBTU8xdzJLaGVmaXluczNLai9oU1J2aFhUaEpZ?=
 =?utf-8?B?L3lVa0VRTWQ2eEdycy9pZDl5ZW9BOG1FeWNJMWpMb3VxLzFtcUpTTTZOR2x5?=
 =?utf-8?B?eHBmeldPSmpXb3Z3RXh5QWUvT2JzQjVBdFgwNkNHMnAvNUoyc244RENSd2pD?=
 =?utf-8?B?eUd1SkhCNEFqZ0IybG8wNXlsRW8wdSt2Yk0xSWdhMjk4c3RvcE1uNTVlR2Rr?=
 =?utf-8?B?YkkxVXU2UGRxNWZFdzkydnVudVZpZnBHNW9HNWhqelJmVDdQNDV6Q1JvQlNr?=
 =?utf-8?B?MnNJSDBzaWNQb0IySFdRVkNKcklaKzJUQjQ0T1RMa29xeGdmeEVSNEVtcXpv?=
 =?utf-8?B?RUp5OStTMjZWTWpUallJaU4wcjIxUE51VkdMNFYzaFpsZWd3OEhEaVRNWFBR?=
 =?utf-8?B?c2xIeEdrbWtFNDNJYWx3aVE3YmNxNUVUZVo2SHdERkpPY05XNHZhb0c0QU00?=
 =?utf-8?B?N0R2UStzQzFOdHZ5cmdQVTR2Sk9Yb2NrYTIwcGhGdHVyamxwcmptdC91bE92?=
 =?utf-8?B?MzhMK1BRRW5LeDN3Z01xY2l6L3FRM3NHR1FEV1NHK2hBaHEwUnpmZkJ6eitH?=
 =?utf-8?B?NUhHRkkxbDNIaHdjNWZHYmpTSUl1U0FiWVpXR25NRC81R3UrdG51RnlpTThC?=
 =?utf-8?B?SWNNdFdNam9CTGRjS1VwcjJoM2dFWGZaYnVxMXZackhwWThuRDNsMjVyTElS?=
 =?utf-8?B?VFd5SzVmbGhVTlhpOTN1bnc4RzRSa2VkSHlVdnFyUklPdklmMWN1K0dqVG83?=
 =?utf-8?B?M3lrQ2xTdERWbWpYRlBDS3BUN2pIZkowS2xtd1Q0MXAyVlFveXU0OU5uZDEr?=
 =?utf-8?B?YWtuVGQ4cFZzMlR4ODNVMVVCTFJKSDRNWi9RenBGQXozdm5ldDRnSFVWcUp1?=
 =?utf-8?B?WERtWmJocTR1SWR1TThDTzkrZktrVm1IWU5lVjJVS2R2a2x2bVQ3SzVYYVlM?=
 =?utf-8?B?dVRnS2liMlpVc091RXV5ZFpZQ1FtV3cyeWNPRlBNdTJnYkU3Szk5Q1VRU2Vv?=
 =?utf-8?B?UlFaTVI2RFdjL25zQ2s2VTdlNDlZbWhMTjQ4Zzh6bmJ6VzNLR2JHcUhGaGN0?=
 =?utf-8?B?L1RrS3F6eDMrLzdRcW11SGE1Q1ZOdFo0VGc2bTUyb0hBT2ozbzFZQlIvbER0?=
 =?utf-8?B?REFyK0ZlalhWd3c3RWFPQWczbGZhQ0Z0ZjlGZlhHb25YM3hVZXh5SWdEakpJ?=
 =?utf-8?B?MHgrOGNiTlpOb1d4V1NVTy9hakFsRHVqaE56U056aHZ1SW9IbWdTakVJd05a?=
 =?utf-8?B?ZlJjdzEwczhMNUVSUDY2ZUw1ajJQUVJGN1hvRnJFNGxyb0FoVXJqSFM3ckQx?=
 =?utf-8?B?MDJXbUlsWmdVRVFUZ3hLUCtzL0gySXQvelU5NGdDeG0yTXZlTEF5dFZUQlMx?=
 =?utf-8?B?d0ZmakpmeEhPcDNtTTJhQ29WTzdGcjdVRGROdFQ0MVhLMHRrMllyTzZiVitM?=
 =?utf-8?B?bWdmNE02d0MwNnQyNWxDV2RqZ1FLMVpwU0M2cVJUWkt1ZWNyYjZaTkdaRUVL?=
 =?utf-8?B?MWFoaC9BQVRESGlQNmhFcmdQY3laRjNoN2VoUEEvdGxLdm9yUnFoS01MU0p3?=
 =?utf-8?B?NElTMGRHUzZzWTRtejh6VFhIS1BkQ1FRNmVhUHUwdVRFeTdMY1BvUENIdC9X?=
 =?utf-8?B?SGY3TlhTTkVKMCthWDZscHJkYWhnSys3MkZzZ1U0YjdPR2F5WURZalNYaVF4?=
 =?utf-8?B?OHFpQ2Jhb1JxRGZmV0F5cktYajREOVRJTWliSGpNM2V1cFVHanpVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328a82c2-2dda-4a00-193c-08de537f47d0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:12:06.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPZtkTDObD+I/fJp3EqFRZQEFK5Q3R8RxK3GSOT+vBQ8VYPjfson+5r6udeBf36Qh+QCo4Ycj8IjF3otU/e4vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5



On 1/13/2026 8:58 AM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sat, 10 Jan 2026 22:34:22 +0530 Raju Rangoju wrote:
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>> index 0d19b09497a0..c8797a338542 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>> @@ -75,6 +75,8 @@ static const struct xgbe_stats xgbe_gstring_stats[] = {
>>        XGMAC_MMC_STAT("rx_pause_frames", rxpauseframes),
>>        XGMAC_EXT_STAT("rx_split_header_packets", rx_split_header_packets),
>>        XGMAC_EXT_STAT("rx_buffer_unavailable", rx_buffer_unavailable),
>> +     XGMAC_EXT_STAT("rx_buffer_overflow", rx_buffer_overflow),
> 
> "rx_buffer_overflow" sounds like something that should be categorized
> to one of the struct rtnl_link_stats64 stats. See the kdoc in if_link.h
> 
>> +     XGMAC_EXT_STAT("rx_pkt_errors", rx_pkt_errors),
> 
> Are these counted to standard rx_errors somewhere?

Yes, I believe this and the above stats are counted as part of standard 
rtnl_link_stats64. Thanks for reviewing this Jakub.

I'll respin v2 fixing these.

> --
> pw-bot: cr


