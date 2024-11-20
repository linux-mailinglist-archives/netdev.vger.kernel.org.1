Return-Path: <netdev+bounces-146506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353EB9D3CB5
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0DEB2380E
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644C1A2C0E;
	Wed, 20 Nov 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="evCKboC8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162119E804;
	Wed, 20 Nov 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110363; cv=fail; b=ddRAHaSZMeNr9igSSx4R3eoInuFwj7Xu+LuEInvX4aLDGP1BPo2CW4JiZz62FVIEXnh/Gu//Z9FCM4NUJrZtf5Nukq08PqottfBNfj2eOE9jvvkuhY79BCvXGCxPSXbjdON/LFFqjLHDKVZsPExalCKlSSuYVe9JzmalaLd9J2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110363; c=relaxed/simple;
	bh=SnVF4QzOjDqf3OmBq5dmTT+a2ADoIjOCN/QURveZEJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvfQPWIiddUs5bSbPvWu7rrgi36Y7CDPu/dgPHyBpo6fCZc5/gttu/YvEFDtr/Sv4PFeGnYuHnUgEwErsTtGbGroteqSRStA+PwJU3Mx73GsZ/tXsSvOzYEbCigM3+3vT4PHPCbQoBTQGNuSSB/frURDIrbOdOQxQpJJuPxbgYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=evCKboC8; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9mws1M6xjZLYYKfaTEScbCJo/9ojwuU8Xp6fQdiFPWj+wJJ0ItnibfXkDsf/LEGsdLUEfaQAkj6SxDY1694IF64OYAeOTAN6Fz+4yHuZdqyAcbq3b1UCGveII2ZVNtUUlaID2Lc/LBfQujB11T4F2IFODXVU9lYnf1tKU+juBYxJ7dC4va/NdhL2IgaykAs0w88y+UoUKat9R+lJaxZNUqa4kxLodPBkqeAauktvg2HI+g47Qok0azm8OlugnezOBOWi39ZTZnDW/GyK/66kicS7IWflOB6xSZ74P3zBCZQXssyvJ8KPGssdl3srFW7LktTQDntMCxUk+vM7HtneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh5+XKtAw43n1ELnd/IJcIDeA7mo2M12mT6Zl3t8utk=;
 b=f33qYGa2NvcQu7Bxx4vre/blSyMRvm41Pp6lZfWlMuy+KGFp9790p+raIMcncgiS7khVUnkLpsYJBvXFkHO8pVXED94mskAkN8VJN2pCW95+1pE2VCxsmendRrKxnl9P+kMYUN9ooVXmFqS9+JzPLoyTq198HgOSvOqP3NY0yqm5iu7WFKvK2YIyJ2h5IOlkDY3CFMKhq+hX15HpWOyensYlfz8Pf14XBQm7+gJyJvYWeS/greEkFJ+DrJiOw++0I3hM0giLr5gemq/GqGFh9//miR6rjddPdDfwIP8miDO1YLQuIQmhJCidmHZ0Q8AjusSHbpJ1wwRuaXg3y/zAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh5+XKtAw43n1ELnd/IJcIDeA7mo2M12mT6Zl3t8utk=;
 b=evCKboC8LKxBPXJ4eU7LTBf77jCbqJeTHbjjmpHdGU1JY9mPlA9PrbPG5LrkmFmSUHeEE4gLbpxyzcEK8qaX5pb481YfIdsD7ugTvukKzY18UEtsUsLIHWRuHSVFa2JtipZQJWH9dlXn22RLUt/V6ChMMbB7nq+7xvoU0+xcseE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:45:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:45:59 +0000
Message-ID: <78cfa71b-5501-b79d-477c-c3a67340d60a@amd.com>
Date: Wed, 20 Nov 2024 13:45:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
 <20241119215042.0000617b@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241119215042.0000617b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::28) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9b9994-8422-4154-6c2d-08dd0969aa8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXY2Q2NzbExwY3pBZXAzbWx3UzI0REZQU0tsY3hWeEpXQlBiQVFqaEgwQjhU?=
 =?utf-8?B?L1paRHU1WE5xbWs0Yy9VQ3pGS1ZCYkVRWm5LNzBHY0NUREkyZDN5cG5FSm5x?=
 =?utf-8?B?d2hNRGtqZnNiclFCd2dyQVBrK1ZhOFhwODlScjdoZHo2cDBQUE5yVExkUVI4?=
 =?utf-8?B?bmV3cUhTeFJXVHJnQlVrWWYwQ1M3Tm9ReWlRWElSMTB5OWFGa1NhZWU5RU4x?=
 =?utf-8?B?VlljSndMYm1TaVB3VDVTc2t3MHNpZlczVFBOdG51eC9HZlFtRHBDdDZZUjho?=
 =?utf-8?B?czFQdC9WRjRyaVFNVXFFa09ISVBxS1FvZlV3K0tVWmVYcGlkUW41Q2crbzli?=
 =?utf-8?B?RXNoZjhzd015d1RQVnVMcHY4RzdGRkpaNzZEQzN6Um9sMjVFRm10Tk9taGR4?=
 =?utf-8?B?dWFheWl6bE1PVXVtbGhmT3llWW1iUHVFUFZiVmNVdzZ3ajhMWW9mTjJJUmpi?=
 =?utf-8?B?MW9LbmMxT2tUZnZQVHFmS1BYanNEamJoWkd1cC82RFlzWmhUMXpLbGV2Vk85?=
 =?utf-8?B?R2Q0NHpOVFo5V1VjN2M3dFAyOEhTbDdJQU9LQ05oZGEvS0crbDdCYWhHeVVx?=
 =?utf-8?B?ekw5VkV5b08va0x4cGpadmpsdE9sQjMxcnoxV21QVUk0NEJ5bkF6Zmp0UDlw?=
 =?utf-8?B?eEUwdE5ONjZGRE0vUlF4ZmxPS0NzQk0zRVhHQzdsdlBBNk1aSitPQXNXMjJS?=
 =?utf-8?B?NG9WQ2lMQWtLZ0xGV050Vm5JNHk2NnRGUUF6bDFWNm54M2hZaytPSFRlSjAz?=
 =?utf-8?B?OUZDbE5XMmNOSGFwQVRGYTVPRTA0WnlHdHR4MjBxdWlHZUpqQXlpeGtPdFRn?=
 =?utf-8?B?SnNEQ0o0N3MybEIwaTg5ditBZHNhTm9pdWh1OVdVVTZTMk5tZFhXSFJXWUV0?=
 =?utf-8?B?bzh6cFFHaC9vRmhFYkd0czQxMnpmYmhHRlVTZ1VibHRwM0NQVFBraXRuRlkw?=
 =?utf-8?B?dVc1TTgrSXVkV054RVlPRTVaQ2JUdmZEdWhqUWswTmNEYlhNcGFiU3ZRTHJw?=
 =?utf-8?B?Z2g2OEtiUUJ1ZTB0K2ZOUWtacVlhQ3B0OVdUU1p3ZHhFdk9Pa0F4QXJRdjBq?=
 =?utf-8?B?MU5nMHluSjNGdTR6cUZQSjl5Z2xOU240T0ZNSTIxV3R4aVNhODJqdXFzb1Ny?=
 =?utf-8?B?MXU2cmYvZUk5eUljV1VVSnJLeEhoVXhlMlBiNzFlN3VNRnEvdUI5cFd3TlJC?=
 =?utf-8?B?cTNiY0JRNDNkVU9oZ3J5NU54YXp1cGN5eXEvY2JWdDRXZGdqWlkrTkVwc2pQ?=
 =?utf-8?B?eXBhUkQ0Sy93enhXSjlSNzVEK1VtRm9Ga3l6ZldrTFhpQ1BOblZoV3Blcklo?=
 =?utf-8?B?blFqdi9FRG9KQnRiMVpyN2tma1ZkY1BrVjYxdFpXVStHSHZqanA0Uk1tSnA3?=
 =?utf-8?B?bU44L0pHYUMxenpXTHdvZkwzQS9ydUZNUGtjckdqOGNiZzErOWpJTW4vSVln?=
 =?utf-8?B?MUU5aTVUWVZ5eWV6bUYyV2hUYllwczlQd2phUU9jR3lOSjcxeks0enBBWWxO?=
 =?utf-8?B?TWxmaHRScE9IR1NRZmNHbFRBZElFTVlRb1lsNFVGYmc0ckFYdDBQRVp4UkZz?=
 =?utf-8?B?OHlteU03Wi9SVFZxZWFFRjNWYnNaenlETnNFeFBIS3lVSTBFOGJnUW91YWYy?=
 =?utf-8?B?dGx3UlIxM3BjWWltbjYwc2QrVmpOeWlHeXUvbkxhZjhod2NWUDZoMWpEckdW?=
 =?utf-8?B?M0pLalZHNTI4bzB2ZDNudStHMTlhTWxDNjR0aDRZOWsvaGlEMWJHSFg0VFA2?=
 =?utf-8?Q?OTNoFj1loAmD0kN56GFDezIl0vVV9gVajShc7/G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDF6MG16elBPR1YxMWk4SGNvMHA4SngrZ3I0bTFJQ2hBWnNxektiMzZjbXFT?=
 =?utf-8?B?SXlJVHhpSDRqSWNGaUwxUDhjVzlSc0FZczVTenhNSGJYeExOTThwUmtGaEVI?=
 =?utf-8?B?UWl6YXpyM2ZJV1VabC9YZTJOMWY5VEJxcE1TMzY4ZEhyMHExOTNjcWZHZlZt?=
 =?utf-8?B?aFM3cHdLZ3p6VmVSYmhxYlRId3E4ekk1ZTFlUGt0cll2NFo2Mm5mWWtGd3lR?=
 =?utf-8?B?TTZ3OWthaFF3OU9XenBSaFR0amorL2xTS2FoK011VmxUMlJZZ05HYW5YbGlM?=
 =?utf-8?B?QXJQakpWU2ZuczJSTmFZVkZ4bWJFbm5FSmhKeTVISTBiZlF2bHdBcWp6d0Nn?=
 =?utf-8?B?OGhDaWRNelZGZTFtajZrZi9IZlFWUnA3ZXhGWXhLL0tueEhuamJGbXdnOWFs?=
 =?utf-8?B?cEZzVlhVK1h3OURsZWRTczZieFMrcmxmakZUVTJtWFoybUpOTDBkNHpLbnZI?=
 =?utf-8?B?WnZOTVc4ODRNMkJmWGhxd3dlMCt5WDFwaWVheWZleXk5eXhXdFZ0ZWkvOUpE?=
 =?utf-8?B?aXZJRDh6TTlGT1hiV01TS1FlQ1NNOFlQem9hZ25MSW9ONDJyRG5TUFNSMm9x?=
 =?utf-8?B?Y3I2dkZ4RDBKWmEvVGVvSWN4STdaUDl2cXJ4QXA0UGpMTHVkSnFBSld5ZW11?=
 =?utf-8?B?OGJiV2lxQzRWVGFUY01QL3E0NS9xWndGM1NLT1ppL0lsQm9GUHlBSUZrZ2gr?=
 =?utf-8?B?SXFHTEp6QllaRCtBOWZtbHdjelQ4WHdybTd5Y0lLOVZub05WRkhaU1ZQOHl5?=
 =?utf-8?B?QmVhS2hPdldwbU9QS25SbXlrVGdmSHB6UW9rNmFodXIzWFdnL3Z6SStXVjN1?=
 =?utf-8?B?bDVQbDFLZUVqZlN1eWF4UG42L0tKczVpaFhoUzZMUTA1WllQVmtoMkdQMjV4?=
 =?utf-8?B?bmdKTmdxdmRsQUhQSDBOTGNHaGlxTGpUQjNjcExtQVVlVXFMcnVtV1lMbThW?=
 =?utf-8?B?cUhQczEvN2dwWUtvT3Vac1VwR2EvdUJteXkvS1RYZGNVTERTQXNPRk93dW9m?=
 =?utf-8?B?aVJXalpSU2pIb2JKOElxTk1lOWE2SjBlclpMN0lnMnRwRnp6YUllNk4rNnRG?=
 =?utf-8?B?TlNSTWQxbFRMZk1KQnRHVUpSV3p5SGtwcjFjc3FiU3lNMWJEd2lPMmxRQVRv?=
 =?utf-8?B?ZENDWFJieG9aWkh4S0dvWGFhK0htNW1lZ0dpV1BYbXdLRWNpMEVUdkllZ0N4?=
 =?utf-8?B?L0JmMEdubGQ1MVNVZHpYbWxTNkxuQTR4ZVN5SWVkOWh4WGYxbVlwQ3JteTVy?=
 =?utf-8?B?MTlEdWlWMW4yTDU4S3hqOEwyS0dhbFpjWWxrY2htSzgydEw3S0pwN3cvYVZR?=
 =?utf-8?B?aFROVGdJcVZTTlRGTmJyOGt1RUVtNjhXeGJ3djk1cjFzcDdXdWlZbFpCRXcx?=
 =?utf-8?B?SU5Jc2pjK05mZEVwSFBTZ2Zqb3ZadnBLMnlOZ0tURm5SRUFwdm00Z0c2azRq?=
 =?utf-8?B?RHQ3aWxEZ1pWYU9mOEd4cnhCenpHWFJGR0VqbmE0Z2pmQTBUSDhGK3NyaXNr?=
 =?utf-8?B?c3p1MlJzSjhpandBWVpld0ZqcVV0M1RSNExyWGdXK2xSZWNkYnZxT3A0THk4?=
 =?utf-8?B?Qm9aUitBRG9XeERtTHZGUmV0S240VHNMbXl1TFVzMStvaHRzSDUwcDBWYVhI?=
 =?utf-8?B?bENzcFVIVCt0VzVMczFMQTliNkdaNm5xbW9pK1FkVEZ1bnpQTzEzS3RVNlFt?=
 =?utf-8?B?VnlGUTBhYzQvOGJ3aVRHZU80ZldpcWlBRVNZbi9tN3J5NFRzYWlPT0JFVHpX?=
 =?utf-8?B?VWdIR0piR2lQUDAwTWRBNVNjYmliWExoRnZVOG5NOTVIaXV2UTM3UHRPazNL?=
 =?utf-8?B?WFk0NnpXVTlMenVlZzFpY0FQOWdkc21BNEtNU3JCVmNHUzREMy9oUHJnSzBm?=
 =?utf-8?B?M0xiU0tJZFJYMFRhZjQ3VHlZY01ZSnV2TzEyNFo3WnM2ZUxxVlRhNmhpQ2M0?=
 =?utf-8?B?dUtLV0JpQU9OSXRjKzVHd0tvMTdvTWVwaDRYcHB1aFVmRmd2MTBWd2UvQWpM?=
 =?utf-8?B?eTNqRFhWSnBVcWhNbExkQkRZdWRseHFSc1FPd0RBZ3FFTXZTRXdFdmhOV3Jw?=
 =?utf-8?B?c25manEzb3VORElHQUViZ0hGalRBaGpkQkd1KzBWQ3owTUNnQVg0MXdUd2dj?=
 =?utf-8?Q?fEaO73Yv/U2fO0H/0mPtpv0No?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9b9994-8422-4154-6c2d-08dd0969aa8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:45:59.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjht1Ozyq5qGRCy0hQ7LGc4fIhsg5pRXeR+A2HR8JIm4NggcvGk2lMkb9DbLqfubyeF1l0Yf+MJs488HEGFjag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022


On 11/19/24 19:50, Zhi Wang wrote:
> On Mon, 18 Nov 2024 16:44:17 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> For a resource defined with size zero, resource_contains returns
>> always true.
>>
>> Add resource size check before using it.
>>
> Does this trigger a bug? Looks like this should be with a Fixes: tag?


It seems it does not until the new code for type2 support.


> Z.
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 223c273c0cd1..c58d6b8f9b58 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct
>> cxl_endpoint_decoder *cxled, cxled->dpa_res = res;
>>   	cxled->skip = skipped;
>>   
>> -	if (resource_contains(&cxlds->pmem_res, res))
>> +	if (resource_size(&cxlds->pmem_res) &&
>> +	    resource_contains(&cxlds->pmem_res, res)) {
>>   		cxled->mode = CXL_DECODER_PMEM;
>> -	else if (resource_contains(&cxlds->ram_res, res))
>> +	} else if (resource_size(&cxlds->ram_res) &&
>> +		   resource_contains(&cxlds->ram_res, res)) {
>>   		cxled->mode = CXL_DECODER_RAM;
>> +	}
>>   	else {
>>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not
>> supported\n", port->id, cxled->cxld.id, cxled->dpa_res);

