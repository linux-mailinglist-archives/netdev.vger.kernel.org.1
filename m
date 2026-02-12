Return-Path: <netdev+bounces-258426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDHINJuajWnU5AAAu9opvQ
	(envelope-from <netdev+bounces-258426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:17:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA612BCD3
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7511E30091D0
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852A72D3738;
	Thu, 12 Feb 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KK6DFseB"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F814A91;
	Thu, 12 Feb 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887829; cv=fail; b=XfRdiar3tZyAqGsDAEVreAdY3vHLbnbk/LOyiyx1ZNKU6skb/nam9nPESSZcwhdW17KWzTHBiEHTPDC7rAB7fRNQW5C12xK3SLIRy4F8HWvuBHePM0DehsuOxx5JOUNOhtMeRGxsF7MHjkBkP4M5Tbrbz0me4H6LpoB+wwk2w/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887829; c=relaxed/simple;
	bh=2DBTxfrO85l2uePMDtQJ8rQBXjtnETrgLpXy4BGTE/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ca7NDmVtCI5EMrN85SsJoMtmN5GaGz2Pg15bDmuooVg0HnsE9twEXsWpiNgbZC9XNtg2Alu7NLExXGj3VoU+mXaSrzF9Gz5unPWDC0nHEDLrH+usnPOuSFwdHJFgjt86WFDLKjM+OYlNVF6wPDXUJb6u6AoDtIiqXkuhHSmjnbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KK6DFseB; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0diXR8yRux38phFesSviZXzZ25fxigeakcAuEWsSH4+9NjuLROR3IRgyeP7EiqnPlB1YriOnURQvLUfmpMmj2Mu3UpwMTvV8SrI+3j/E+BvYUuvdEFXJ/RmuuLlu0zWfyR9TH2tTxkDwb3MloAYjHv3rPuNGJN6eR15BtTTB3H6/1nchIoVh3LyEm0XfcUdevakYhR3JdokJsotqrpTXHBoigNzCDZ9CKdEwntz8NOvqWdcHdjjpV8flgRSGqHC8Eiz2fem0bp5Jx/725rB0xJi/n/nq8HXGcMu01U+gWYjjk26htZhcfn7hq+M3bFBBTLJe3QhC4EvDrFmpyDahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT4Zcgq8BoDYV2yuDARz5f+d72tpi2KNErox7GNRxoY=;
 b=oI6mfRYHCB596RLolt6lFKts4MaeMUUZUWbuxfETH4jZ89ls/qUa2viHOeFL3MvieuQekdH00KAF/AtGX3Ag4ojZ/CN15A610KtNFNnQOS6HH87K+mYPYGuVlBZPMOj2f/ORc0XpG5ZJPFX9Gu7MykYcaI1Adn/jy9NITY8t4kTdIFGeaLr4xBP8gV9IqVsbtEqifCr9fO0YQWOFyobRsoYUrO1tnwv6sIMZohNpARwipgiTICTvMOz0iUzgbtMdlEEcLivGBHdBkC3mv10beJkZ434V+/9xnEbLmL4m577qdhWGeb/NSMCZTXBQh7T13qK1ZoJ8ET29D6myamz+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT4Zcgq8BoDYV2yuDARz5f+d72tpi2KNErox7GNRxoY=;
 b=KK6DFseBjZH+uCWd9j98fyUdPK+8u0dK5lnFZg9LZToKXWZAN1mHX/0Ro0Y9QWNwMqkCha6oWG2Py2GuKPncMLbvr7RqcdBlwBYGhpXUCCx7R3NFoA9J+euvORzZrwxL733xXY2mZlmmZtFI+yqwoIzB1spNKv9+lAldFDS/q1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 09:17:04 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 09:17:04 +0000
Message-ID: <28148dcf-3cdc-439b-900a-a3f672a28ad1@amd.com>
Date: Thu, 12 Feb 2026 09:16:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 08/22] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
 <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b622f3-242f-423d-a12a-08de6a177ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmJJOEovNlpTODBCWjBIcUFpTzE1ZjZsblRjWDljOStLR2NGZm1iZ0dqeDR6?=
 =?utf-8?B?bXhqZTBWZndrM09qNDNxTHRSMitER1V0S250MFpQOFpTNWFubTMvU2c3S2tT?=
 =?utf-8?B?TCtJcXRnR0MzUHdSVTVCTzhscFJ2RkFmaFhkY0tvbXhpSHFxVmtmMTJwMVNm?=
 =?utf-8?B?YURpR1ptUVdOc0xRYjNkZlpjOVNaOGdXL05rM0pXWm0weXRldlpsQUl0VkRi?=
 =?utf-8?B?b3N5QXpCNGhnT1hrZE1XTUZFYlZzcHZ0OEpyL085Z0UwOEpwampyeFlCbzhj?=
 =?utf-8?B?eUttcjRqemRkd2x0RTRTWmNWWW4zcGQ4K3B5L3NJc2pORmROdlRaN2haSVJx?=
 =?utf-8?B?VitublVJZ0ZlMno0citEY1VweUxlVWNKTHVTWGdZaE5sZXRpVnA5cmMwOHd3?=
 =?utf-8?B?dHExVE9PRUxOTXY1alhvY1NyeUV2bk81WDE3VEhmMDI0NktnalNtYVcvdTNl?=
 =?utf-8?B?WGErMFF1ZFl0cmIyWTg1NDV4bmFYMDFqZWJuOFJZUkRsQURKYldubjN2TTh5?=
 =?utf-8?B?TGkyelNWdUhVVnh3WFExZGNwVTh2VW1oZFhuOXdtWVZIbk5ITm5HNWxNMlFs?=
 =?utf-8?B?TU5WS1BWQ25DNlU2Vm9UK0dyQUlSdUd5QktPSGFKZVVybHp2K1d2VHVnSGlY?=
 =?utf-8?B?Q1lLcmhwRjZBQ2lQYm11MEF4elhFV1BwZmhrdEpVRTFsVDhnTzFIcGhLaDl4?=
 =?utf-8?B?eGREREpPZ3J1L0M5T2w5WVdENEM0Z09rdUxFUnNqS3NVeFFLSkVZWVFIQUFy?=
 =?utf-8?B?b3NxdXp4ZnNER0Rqc0t4S0E4ZW5WZWlxN0lKOHdhTW1LbE5HZFhMK2g2c01Q?=
 =?utf-8?B?T3NIaFdOc3ZmVUkvWHl5eG02aXJrVlh4SFBTTElrOGFUeWpnVGZGdDV6TXdK?=
 =?utf-8?B?a3VDWFBhVmdxdDd5b25JRkxaMVBoa2lnTTNISkhlVENOSzE2S3NLVXdGdW50?=
 =?utf-8?B?T20yMlBuQ1d5RnkwQlpWZXB0NzQzeDFSMGZETjhBajE1V3p1Mk5lV0lnZHla?=
 =?utf-8?B?ZndIY3JxQ0ZUd2tJbGtuSzV3T3V6d2tBaVNKeVRtaTlPazdlL3QwbkQzQmpU?=
 =?utf-8?B?UWhwZjFKUTUyWG81RUJhUXJZVXJ4OHp6MEFEOFVRajBSZ3YxNlpMWDg4RFov?=
 =?utf-8?B?UUVTaTdZdy9oTjByRGJaVGVRRjhoK1ZuYU9UUDBJalNycGViZzdFNlloNERt?=
 =?utf-8?B?b1FtM01aNXNLM3lKSStrTEJQNWV0SC96bG5Xd2I3aFN1d29JeTJReWt6WXN0?=
 =?utf-8?B?RUFVSkg3NDhpT0tEVjkrMnJ3ZUc4QVdwYUhlYnM1MVBuUVN2ZWVMc0hTOXVo?=
 =?utf-8?B?dG1ZSm9qc3Juek04ZGlwUGVUa0JhMTdFRzhLZU8vcHRXa3NSb0VmbDhKVllp?=
 =?utf-8?B?ajkrL1hZUnBTdHdudk1TUmE1VEJGa2dTL3c4VjhmVUV1R3FHcExUOG1sVEph?=
 =?utf-8?B?dG1oWFV0aFhMVWZRRU9sRkltY0kvZGR5TUFGdmhKWm1NSm5JRGlXQzd0ZWp2?=
 =?utf-8?B?MHNWMG5kMFFNdEhvTDBxKzJMdnYxczY0KzB4aHJaTlpIcGk2Mk5MSFkxdGZi?=
 =?utf-8?B?R0orSS9hV3Z6cDhGYVZTUzluS3lIbWw2eFpWWTBsQkIwU3ZyaDRCYTV0MWFa?=
 =?utf-8?B?K2hZdzFUcjNmaGkrSTlZR0R1amNlaHlBdkM5dmdzQ1dVRktYOXZQaFdNYTN4?=
 =?utf-8?B?Y1Q3ZFVTNTI3dlBIV0E5OWlNb0FGQURIOXVnaW5zVjVlSlJIQkFST2x3b0VQ?=
 =?utf-8?B?RklSVE5jNXo1emE3RHNnU3dEZFRxdGxjOTlMb0duVFowMFVEbzZIUHVzcUMv?=
 =?utf-8?B?blNNUm1RWmQvUUNwZnIxaUpxSnFKTmlaYkc0bzJQN0ppdUFGT09tSDBuVUhM?=
 =?utf-8?B?SWZLUExGcmNqYjFDVWM3eThTc3hLZjQ0eThzRnBsak9ic1lxbnVoU0RQbHM4?=
 =?utf-8?B?Sk5LUGxNeVkzb2dvVm9TSHJRQ2pXSko1QTZkTHNNb3ZZbDZWS3VzUzJabEVt?=
 =?utf-8?B?YUdkcXRDbFBGNGdFbmlNa3JRdnB4aHdWSUU2UGFyY1pkY0pkakpkWWtCUnBs?=
 =?utf-8?B?Y05wUDI1NERIMUNVcUZjZXliaS9GVWxZN1I5T2poaFpuS2VXZUVNRUxqNkNV?=
 =?utf-8?Q?ddO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGkwWG1SMmY1NGlZaXNmZWw4c05Bc09oUDUvVXJCamNwdWo0T0xucTVRYzIr?=
 =?utf-8?B?MjI0NTl2WEVSdW9UenB4eDUxeFVGTGh6UVJ3dUprUW93WUZ5WkNENSt1cCtB?=
 =?utf-8?B?NmlsemhLQmdLN1BTcnM3c0pBUEdzWEtzMlRPQ3Z1RmtJS2R3M1ZiR3JUZm4z?=
 =?utf-8?B?bm1hTjFya2U5a3lCL3l6WmhmZ2xVdkZWUS83WE1hWjVXdFdYNjY0Sm05SzVU?=
 =?utf-8?B?V3dINnIxSUZoUlRDZlJEQVdjK2R1amxjTWZFdGZUN0JKRElUOVZkSGdCSGNa?=
 =?utf-8?B?S1ZxQm9NSllNRW5Nd21hejJmbFFjTmZMSU1IblhoYnArQkt2YjBiU3RoMEVl?=
 =?utf-8?B?L3UrNmVBanFWLzFLUUJKVjFBRy9nNTltTlZJZExpemZES3AwaXp5cmkxMWsv?=
 =?utf-8?B?YllVSExMWGZsaVJWSEJkdUc1MVNHVzYzT0twbERBMjJHeEdtQ2dyNjJxT3c2?=
 =?utf-8?B?UkowK2dvdk1oS1ZYZlA1Z1NPTTArMmFRY09JMlhzUXozdFVmNzhlMjd2NjQr?=
 =?utf-8?B?OWcwSWNza2tOcXN2a09zaklGQUlmOWtyTldWVG1KUGtzVWpVbldxWWZYK2pN?=
 =?utf-8?B?WWhCZUIxZjg2cERDQ3dXSDU3Yy9nWjZtVWRlS0RTMUxhVktseHJFRDh1OXZ4?=
 =?utf-8?B?M3kvZ011ZXNUSUxIZ1BrVDgya3c5U2I4R1dad1loT1JDUmp6bkVGMEF1Rzg1?=
 =?utf-8?B?RUpMRkN5eWgwQlNxYUp3QVlBelozME15WDVFMWhlL09KWkg2czIxbnplT012?=
 =?utf-8?B?Nmw3TzlKWkphUFEwcDJTUmR5ZWxLV0IrczlqMGRvM256ZFBuOXFTcVYxbTM1?=
 =?utf-8?B?RVo4d1B0RUhyOXVZNXV6WFdiTFBNL3dTdkc2NHdhVHJPR3Q1M2ZUc1BTa1Mv?=
 =?utf-8?B?Nis1bGNnUGhJQXBCYkVHK2xvRmNaWnZWNWpOTWtWbWhXazRRTlVtTnpaOW5H?=
 =?utf-8?B?MWZvYmNmNlgwWlVJY1ovaEFXaWhHMGNocVZwZmd2WWl5ckY4UER5K0RQbjkz?=
 =?utf-8?B?ekpQbWp1dGhkQlhXbHpsUDByaGl1emhQdWpGU2cxMFI4ejBuNmU5ZlB3ZlRq?=
 =?utf-8?B?YjI2L0g2T3JQRlZyK0Y1SDZvOHlyditjemlOY3ZRbEhORE1GbGtTVVIzaklC?=
 =?utf-8?B?TWtjb1ViWCtiNWwzdmVYTHR3RGxnZjVIWmhKRytiSjBCVjBRaWtjcmJVVlQ3?=
 =?utf-8?B?L1lkNzljSHE3TUY1LzRpdXYzMjdERHB3eGZXZXVNV3dPaFdLYXY4SEFLUXJZ?=
 =?utf-8?B?M0V0TGJkZzVTVWZ5dTBuQkk2OU9iYWx5OGdNMGJ2RlBrRG0yMFNrWVZRT3Nl?=
 =?utf-8?B?VG5kZ1JDQzRXcHR0YjNkK2xONUl0bmFCakxNQnhSbzBwZVFZQU9nOVlKZVVB?=
 =?utf-8?B?bnJIbUhNdlNaWGEzRyszaVEvejh6d2g2M1VVcFNhajhoaVBTRTJZUHhsSVFH?=
 =?utf-8?B?ZWwzM3hLVHNJbVJSdGM3OWV6Vk5MTElneUFiQnVjMGVaa3RUZkFtdSt6bVJK?=
 =?utf-8?B?REVucmQzTXJVOS9wdzVQRVZxZzZFZGI3UFZGcGxOR3FWV3djYnJ0Ukc4cmZV?=
 =?utf-8?B?RnNGZmRjQ0d5RW1lMkFvcUhWOG9EUDluUkQxc09JaTMrWEw0dnZGUko3bG5R?=
 =?utf-8?B?Wkk4WmVEZlVEWmRCSDMwMU5oRmdBN0ZPM1QvNEVldTZZSnFNeVR1cUJBL3NE?=
 =?utf-8?B?aGViRUQyZ0hRVnJEcWJkYXQrV2ozY0IvVFhDNzY2eEhFR1dQVUNweXNhYy9z?=
 =?utf-8?B?dFh5MlpKeFBaVlNSSXprK3Z6clpRbEFlVWJtTkFWSUQ5WU92NE1QMDc5N1ZS?=
 =?utf-8?B?TkpaczlLOWttZVJIcVpoZEhyL1BoZDF6WDM1UUt3Q3NPQjI0VDllZGtCTXdN?=
 =?utf-8?B?WlVGZ1BOSW83eGRVSEF0SHJXTUkxNEhqMnpZanNsMUJIRjNCQ1ErSnZCNGdF?=
 =?utf-8?B?VkdZRkJmNnBlVGVmWDZrL09BMjhlblJlT2tUM3FWTXZIUmVlWk11QjJSbUVV?=
 =?utf-8?B?dVFlZmxBaE9vM0ZLME8xYURXeHRVOU8xOHFzRlJodXFiWExZd3M0NHMrMFhG?=
 =?utf-8?B?OVlBbmlmSDFIUkU3QUtSRVduMEkyWm93L1oxVldmQjBVbkU5enlYVTE0V3Ro?=
 =?utf-8?B?eXFwRFBrcUtGQmgwZFIzZGM0KzU0Ylp4OWhJU1RzU1ZORHFRN1I5ZXRuQjI0?=
 =?utf-8?B?V2pDRDR5dkc2QTJJdVl2V3VvT2R3RlBzZ0s0RGxvZEc3NC9seG9MOHRvL0lX?=
 =?utf-8?B?bFU2dG4zcHdrcDh1VnEwTFREcWRYMlJWS01FWEtoRTQ4UXpqeTRBZ2h3bTRX?=
 =?utf-8?B?THBqSGwzaWE5SWFoWHpIZWkrWkJBU1Yycy94MzZ4UGJSQllBT1R0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b622f3-242f-423d-a12a-08de6a177ca7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 09:17:04.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUlMIMZ/mrVsKQNqBP+6YQM2/4FiBbX+riLhtl0YMb1MEKOKDnL8Q0yIGXvqMk1C/ywVLTMP0VnSgzwqW9ji+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-258426-lists,netdev=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: E7BA612BCD3
X-Rspamd-Action: no action


On 2/11/26 22:11, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type2 device configured by the BIOS can already have its HDM
>> committed. Add a cxl_get_committed_decoder() function for cheking
>> so after memdev creation. A CXL region should have been created
>> during memdev initialization, therefore a Type2 driver can ask for
>> such a region for working with the HPA. If the HDM is not committed,
>> a Type2 driver will create the region after obtaining proper HPA
>> and DPA space.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  3 +++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 6e516c69b2d2..a172ce4e9b19 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == port->hdm_end;
> Is this the way you're supposed to check if a decoder is committed? The doc comment for @hdm_end in
> struct cxl_port says it's just the last allocated decoder. If allocated decoders are always committed then
> I'm fine with this, otherwise I think you'd want to a register read or something to find the commit state.


Hi Ben,


Yes, I think you are right. This works in my tests and it is safe 
because I check the region does exist before using it. But the error 
inside sfc should then not be fatal for cxl sfc initialization and 
fallback to the other cxl initialization possibility.


If I add the check  for the decoder state, I guess I can keep the 
function names. If I rely on the region being there, I should change 
them. I will think about it.


This also brings the question of what is more than one hdm present. This 
is not needed in my use case and likely this is also true for other 
coming Type2 devices, but it does also require further thinking.


Thank you!


>> +}
>> +
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct device *cxled_dev;
>> +
>> +	if (!endpoint)
>> +		return NULL;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
>> +				      find_committed_endpoint_decoder);
>> +
>> +	if (!cxled_dev)
>> +		return NULL;
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +	*cxlr = cxled->cxld.region;
>> +
>> +	put_device(cxled_dev);
>> +	return cxled;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
>> +
>>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>   {
>>   	u16 eig;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 6f8d365067af..928276dba952 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -249,4 +249,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>>   				       const struct cxl_memdev_attach *attach);
>> +struct cxl_region;
>> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>> +						       struct cxl_region **cxlr);
>>   #endif /* __CXL_CXL_H__ */

