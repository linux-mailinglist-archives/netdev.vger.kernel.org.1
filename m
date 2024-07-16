Return-Path: <netdev+bounces-111703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB793223C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343E3280A91
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED28317B419;
	Tue, 16 Jul 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nB1v5qCB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4244206A;
	Tue, 16 Jul 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119859; cv=fail; b=OJxBlpx6ciPrBrCPYRUUv1MItdFZYHJKEeG4rK8n1ZI5xmEIeMrNjX2Ku9wqa536Akw2PniawFOFYbPAasfHD0fHWjJbpMd/MGW7PMSx6FxdOrQ8Yd8fm5BCrXkXWHMGD8d53z/APVdTV5rYf40GBIJbc+Smw3F6nCKC2hmh8ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119859; c=relaxed/simple;
	bh=Jg6Zrmv4GJOCAx3A0I5ocFFp31aaSmOEj2qQcRHIgmA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rLNR41ASvtKJj4K6qXwfmZIgNTm7yAIr5+FF9OAD/o+Oq/NjOMNnLPp4NUD037unsLFOQmZxZKGANkfJ3XOhESjfI3MMU91wiO+KsLBFQirVVRTsBCdHC5TL3SbA8x1A+MF+ELfIXqhr14TPSUi0Vvlbq2RaZNT3EXtvzl4JIbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nB1v5qCB; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6lOvWCCVrLT3ZoL1uPbdGjnqjmbk5oJnKDmnCZdc/eEz7FH+kRGjspSWWiKf4mzOfctcu1pGbGTMAUVYGBFB+JI2eRQiu6iwP+Y9Rum4aCCAJA9WPLKI7Z9QyH49N0mQst9mQ1PUkaVfQnGMmZZv7xaJRhtOlJCniG4hUx0zWPf+BKELSjfYXB2/XNKq284smko/hH6AtXdylwurII6JMvxcp1wHTRchac/pEemmerjfHiiuq4rLE+6tTAK0qb9NN/WUY6cltRxJGbnMVJBwj0jGIWzaZuwVYhBB7olfX9717iZ5bY6ImqTe7QDTcR4pVrXaEkPtX6a2uEB4sKFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPz+7ZSMil65FY4Pea2a1s1pqrjx5D9ihw4O9o0KGds=;
 b=d/FTm+1ItAUyU1H4KFV19e+0no7uDK1TvYrw1Wx5F8dSWxIT2iTTP0MIgMfQaKhilINWJ1JCULEf8W3ZN07ghz2WodELogP1H3M7kEsmZksSQi+zKCbxoMpSsp1vQrCoCNL5EkkWGx/n5cGvl4/nP97Akl47HfXhnwg3mpDF1CDyAPlYKHgPiQBx9hqoR5McQ2Y4g0iEhYlndbIENeyReoHwqyOtTWtetXKFgLwL3+yn7OnQhl1xZ6OeohPq/IciADjcQoPTqsz6cUCZa702eli3R68pkNocIjrh/ZsyAMfEvXiYHOXwI/5wDHgVjVtHuqXfgeb3u02vYF+U9nfoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPz+7ZSMil65FY4Pea2a1s1pqrjx5D9ihw4O9o0KGds=;
 b=nB1v5qCBZKttCnXsE5CHUCEK29Cy8+tGW1gESYNEZs78H5NttSU3lms1EECxB9bVBpcDx46GhDJ7i5/nDljDzozMYrO03HG0EZXxuP97fss22LLdMGsCYOtQBZW9k91MPiFv98Rs2LqGxJtcurQDNCp6GuvZ6S2ZAbZkaV01B4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 08:50:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 08:50:55 +0000
Message-ID: <799c897d-facf-e6d1-6c13-ccbc09630389@amd.com>
Date: Tue, 16 Jul 2024 09:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <72858182-c0e6-4c05-a11b-fc137f8f1edb@lunn.ch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <72858182-c0e6-4c05-a11b-fc137f8f1edb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: a70a123a-704b-4a8a-f9bc-08dca5746749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djFNUXlRVS9mZWN4WlpLTm9DVjU0M0JjdERYTHpJd2UxWHkrM1R3b3dKSlRv?=
 =?utf-8?B?QlJZZTdaM0VqWWk2aEVVL1hiK0ozNWZkZGE5UC9VUDRIMkFWTlQrcnkwNGIr?=
 =?utf-8?B?OXZmYzR3clYwMnpQL2YrbStaMDNKTzJWNU8vS2RtUG1GSkRZREdXNFhKUlg3?=
 =?utf-8?B?T01wVnNxMTVXREVPYzFIaitWQkNsRHQ5L3hlZnEvTk05VlNCdTBMVFhUeEht?=
 =?utf-8?B?dEpHVWRONVBva2h2em5MQTVIMGhvdFhkQVA1cXdQQ1l6YXN5OXFwZHg0RjBV?=
 =?utf-8?B?eUtkVU5NNnZXNTVwS3lYb3JXSTJsL3dXWUlTeEM2RjNwMlpSTGo5NUZBRHdG?=
 =?utf-8?B?Q0NQUHFlVXY0NGpTMnpIK0VWdGdLZU1PU3E4V0JhanA5cTJpNDNQWXZ3V0tO?=
 =?utf-8?B?aTFtaXRDbTN5b0lxNm1oTFEzalYvZWY3STRGbmhQY0dLVXJVcHh4WUkrcVh3?=
 =?utf-8?B?eGJNYzkrRVNKRTVOZytVczZUaUNGYVQ0UnJueXNJNjBuYlN5Q2U4d014d29P?=
 =?utf-8?B?V2VHSVhFZVd2amk5L1IvaEErN3huN1JPM05SS0FreFUvTE5Rd1E1d3NNSStk?=
 =?utf-8?B?UUpVVGlyVjk0M2t4WEwwYThkajBSWHlmS0RtY1FERytROTRIQTlsVHFmditY?=
 =?utf-8?B?SUt2cmdIeVA0OFBIcjl4SkRwNVVOUk9iS0dMUWcrd3JOaFU2ekh2dFU5VVJH?=
 =?utf-8?B?K3dSTjdEVGlNU0syVzYxd2t5dEFObUhXZkorR3A5eFJUdEhtU1hpWFJNZFc2?=
 =?utf-8?B?L0JiM2J0b3UxVkFuU0t6M29oeGtWTFM0LzBGdSs5WEk4NDdGdjlXZnJFOE1M?=
 =?utf-8?B?MnlwV3g1OGk2Z0lEREk3NWNwaGxHZ0xoMXd2WWF0NTNVY3laMHM4TkRYUTYr?=
 =?utf-8?B?YW4xbDVRVkRpRnlzUUdMWjRjbW9QUWliYkpkUW9mSmlyOTJMVnU2NnRQY1Vy?=
 =?utf-8?B?dUQ0VDJVdmtOMnFkU0NIcnUrMW1tSy94L05kYisrcGpZWUFFRHprdGhxK0d5?=
 =?utf-8?B?WU5ocDl4QzZJNkhEUmN3SlVSbDNoZ0FFNFhpVzJBY2xHWFZCcHFiMkt3RDlQ?=
 =?utf-8?B?U2dVUk42M1N0Vmp5V0NYQmFPUzlVZFhtTTNCc0lGOVhvWXRidnZGaGxZb1J2?=
 =?utf-8?B?dTA2REJKRFFHanVYeUpycGFwL0h4T2dybmttQW1nYjZSWWJ0M0MvNHlGcmEw?=
 =?utf-8?B?ZDRScVJDOVpZWW84aWtMdU5NWmZUQlJOQmtub3lxVHhpUHVGUTk2VGxJbWRn?=
 =?utf-8?B?aElwaWcwMElWMFFnNG01TEh1MWVDVkVzaXBkemlSZlZhTEVxRmlmeUpaUHNi?=
 =?utf-8?B?YmVHaG9rTEhOcy9CVnFseTZJbG9mRFdkN2ltM08rSWloZDIrM21QQnJLMHZi?=
 =?utf-8?B?SE1wSlpqTlREZisvSmppaG9nYkZ5dFIxbWxicGQ4bDJGb2czUjBuaUUrcnFC?=
 =?utf-8?B?MVhublFtTGV5WW5EWTE5TXhyUkRMQk90RjlwS2crN1ZBcHZvYXdyQldlWGU1?=
 =?utf-8?B?T0RSMEpiOTN1TW1mTXFMNW4xdmRUNEVrMHB1aktYOVp0Ynh0d1cxaXNWR052?=
 =?utf-8?B?ZmhGMDZHalpGSlhqM3g4RTFYY1I4d3NCSlRZQzFwUjVrSW9qdy9pSU5wSlNN?=
 =?utf-8?B?d3JuMEl2U0MrZlBSd215QUEzS2ZaSGp5MzNHOGhGK29yK1F3eC8wMXBtYnEx?=
 =?utf-8?B?aG9wMjdvTFBmR3p2WWtBcWFXYnd0UG53OEVDYnJrbFBkb3JhL253QnJrNWdW?=
 =?utf-8?B?Yi9nbThteFZlZUhlVjJPczRHLzM1bC90RWJOMFJBUDRVOHM5L2R2VDQ2ZEQr?=
 =?utf-8?B?bldVS0xOdFkyclAxb0NGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjJxS1FJOWdCQ2xRajNkVmFoWGFHL0xpS0NWZnZuYlR5SnFYUy9vNWZnSzl4?=
 =?utf-8?B?TnJXTnNqck9ueXEvQzZNM0xsd2Vua2lCMEtUTHhZeitvYUVibVZmaHMwRTd0?=
 =?utf-8?B?Qm9Gcm5Gc0lGMWhFcytPK1RaUHRUOVRocS9uUDlqVW8xSGN4RS9FYzhTV2Ew?=
 =?utf-8?B?WnRyR0JxRitiZ3dLMG03Wk15ckNLNTU0ZWg4a0ZPMlBWM0JNWnVyS05HSWl3?=
 =?utf-8?B?TmdWRDNrRnNpZWIzQU9oS2RSTnVDNTRyc2xQWFdzQ2VYd1lDbEhDMlhGdkxP?=
 =?utf-8?B?cytGZ0dLYVl3RmtKUVZ0L2Jrd08xazBydnB3YmJMWGUwNmVCak5aL1laYVdM?=
 =?utf-8?B?TElKMFdKN2Z4NnhNWVpRa2xIMCtibUx0TXljZ3FjaGNiQlFmclJKeWdyaTZU?=
 =?utf-8?B?cGlPMnZyYU81QmJmdHhIeFFjNVZRSlBLU2NWQXdxUlBqU3ZJREtYcDFZcFVW?=
 =?utf-8?B?RmtDNHYxVXlleE9YNEZUaUdRcXRtTHYyU2xCa3ZERUI2eUpzUS9OUHE3K2I1?=
 =?utf-8?B?dnJlRnVSaFNaQnpBNU40ZEZNaTUyNDVJRlEwR2pWbUpHNzBEeHJQMHFEQU9n?=
 =?utf-8?B?UVlaRitCcTJ0WVl6THFBd2dWOUR4UHNSa01Qb21vRGFES1lGZWJ3MGdGU2o4?=
 =?utf-8?B?TnFIL1NiaGxmT1VBZW56Y2VUZVhhdVFPTHNJS1RadkIxVG9HWkQrS2lTTGpa?=
 =?utf-8?B?TmJ3OE1UdGxoSUl2Q2ZSNEx0aVdCLzlvN0RlRzVNT3plMEw0SnhpNWlyWFBC?=
 =?utf-8?B?ODl6REkvUHQ1cks5SkdvOUhURHgxeHhMWnJBUmxFdHhnbEVYdVJLdHlJV2lI?=
 =?utf-8?B?eXEwenpMbFlvMnlUMmJHK2Q1ZjAremhFT2JySTdKMUlQTjdCK3JEOThVWW5t?=
 =?utf-8?B?R3ViMVVkUzJVakxnaFAzTzZxaTZlaDk3dkZHWnBZVDVjV0Q2Y3hmV3FjZFU1?=
 =?utf-8?B?S3Q3N0VMZFFNMjFjMjNYc3hwSFUvYWt2OEVEald5SnhDbnZES3hkaXZwcXc1?=
 =?utf-8?B?SFc4VTlCYjhjMkVRK0FJaXJ5TjBNenBSZGVtbHorRkxjcEVSZ3dHMGdZUEtN?=
 =?utf-8?B?VUk1UVNQc3VCWS9CMnhuWDM0cFBjbTR1alRBVVFlVWk2aGVWMXJtdVc4Q3Iy?=
 =?utf-8?B?NUc0YXpYQmRmWkZ2WUt1VnJIcllNWENMYU01SXUzU3AxbzVzNE16REQ4VWF2?=
 =?utf-8?B?dUxQdnZFL1N3aC9CcmJlZzlzNktpUUs5MGZmM05tMHBQeGZCZ3ZjaXk4S2Rp?=
 =?utf-8?B?ZkxyVDQ5RThWLy85MkdRZUFiRDcvRGNHUTl4aUFZK2VTWVJKNUFvVjlBSWNj?=
 =?utf-8?B?T05jUVFFR1hPcFZidE9xWUtXNWtQTWM4T2FGeHdHL1hNZlRCWGx0K2prVUxY?=
 =?utf-8?B?SzhOcE02N1k0QzRtWTNKeHMxMTU4R3NBK2FqNG5hRzhISGVjeFlVcklTcVVB?=
 =?utf-8?B?T3NVNHQ4SnhqdWRNek83SXBHa3hjcFNZMGtlTVYyUVVGeHo1RUt2bGR2YUo4?=
 =?utf-8?B?Q25FZDl6Slhrc3ZCL0plTWo4b1pBLzBZbzRoUlYzdFY4MCtUVkdycldPQmZt?=
 =?utf-8?B?RG84ckhlN3pZTkdlSW95VFcyU0hTSnoydzZtL0l5emRxcXc4WkdjYUJTVVlM?=
 =?utf-8?B?amxKMjFRcTBwTmhsNXhPWHhYNElGd0ZaWE1NNzZ2SHZHUUhpUzdvdFB3KzNw?=
 =?utf-8?B?S1FGQnlPS1FBM3Awb1dsWWk3TTlxTUp2UTZ0VEp4bWxOODhrUlV5VzRaclpD?=
 =?utf-8?B?VGdlczkwWldZMmtTVFcwL2VEMmVHZzE0MkJrRk9laVpmWmNKSXgyQXR1RzUy?=
 =?utf-8?B?TTV5UXVzUjdvQlpvdXllNCt4ZC9FVjZXSmFrTWY5RVV2Y3l5M3lGSjkxNEZ6?=
 =?utf-8?B?TmhGN0ZlTGZLcWJhTE1OVVFxM1FjT2xkUllKU3BTTE01Kzh4V2c4MnlZYkFL?=
 =?utf-8?B?bUF0RmtnUkpFS2VJSXpTUjYzZktIN3NsZzhpWWJsc1ptVTRiOG5YYkVGVEpK?=
 =?utf-8?B?TjNsU2MxYlNMZ3IzNTN2dHRRaUFNSGplZWhiZDhPTDdsV3p4T1dCck9KS3Yz?=
 =?utf-8?B?WGtrYUQ5ZlpzKzVsTDh4KytEbkhPL3M5YW5IZ1NzR3pQOFdZUkhSSk9ocm5a?=
 =?utf-8?Q?LPsQBxE8tq2Crj/YzAHHZkB87?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70a123a-704b-4a8a-f9bc-08dca5746749
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:50:54.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7qW6jCOVQZ5nk/Pc/7ngnId29SCfPPmymbfYLh4xHTJqWurjOGejjA1yVZzMSOJ2hI0WHETkrCd5g/Y7h5r9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740


On 7/15/24 19:48, Andrew Lunn wrote:
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#include <linux/cdev.h>
> That is generally a red flag that something not good is about to be
> found. But it does not appear to be used in this patch....
>
>         Andrew
>

I have no explanation about how it ended up there. I suspect it comes 
from V1 --> V2 transition. cxlmem.h includes it and V1 was moving that 
file to include/linux.


Anyway, I'll get rid of it.

Thanks


