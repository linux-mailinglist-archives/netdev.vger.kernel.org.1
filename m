Return-Path: <netdev+bounces-119216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E0954CA2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8EA1F26875
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3CD1BCA14;
	Fri, 16 Aug 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ruzkTgt4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB714D703;
	Fri, 16 Aug 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819392; cv=fail; b=U0CK1yUhALLlnLptpqH/W1vtUs8PBXW3x8Ly1DlYANYOikKKBH5y0QbaHL94cD/l2ty7VGeICWg1B61LUCmRVRla3y+glsfRbn5IhquOWEPUhMYQ5hxWtRt7k+Nm15BKQmQ8Yg+4qz191qD/hJLhUzM5x2Y55NnVGh5MAPSeNUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819392; c=relaxed/simple;
	bh=FJGnClEP0iRoIgaF1hh2GQGTMIEidPME45JrAXFDaWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYiZ1RRkOJcfmnaAIqbdcXMaYfxuZkpFI+pQBfzzHH1upvIr6LhDxyzZ8tO3ZclsPlB6ZDDgVBpjvJ24drkigs2Wbl0n9XU00B5tWJZxcyBibU+4qNaPzolzVfFQ92BBBk2PghesNlBg9WExTCR6z6KSA6Lq0bCq5PkqJl5pSxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ruzkTgt4; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4t9uoz6fRdfgbWrL9QN5VrQAEpOq8GQmFUY4M83fXcwUIaOluLxPlUQpmbOo02OLeQ06+zR7PCSB1TrhAoODed5s9IpyQ4sOVpqNvOTaidZPPDeBaOyeC9tASvzdeNgTbL5CUWnZixvhky2djpYWCTNlSH2Ua5omFMQIRQYkt2+MOrKBuarAb5LdinshHMoCG0IOCMcgPXT/mKCnenxulFuJoyXr2PG5ls2FzJs5jmeFDSluNbsd+LZ7/WQAeVfT6SA73+FNQIrEQOr5kmbNKQrP8kwfT8RvVKi/5K4OW1zo+bnGIuwNYHOv3S/O9vqGQiSPEXEv3up/xr71QBuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cl8SlJ46Y4kxoa246lyrQfLMziDqadJpMbu3JC9GiMs=;
 b=kq9snb2PDpQ55cbuzymkrOAq01D+JLSdjcYMeiCcHJajjHejldZmW3aeYt5wDUhEul4dn+XCVkPXncptK72VfWCIrXn+LoxPgt2n8+FmCBIAzrRBl0rEJsjRcq5tXv5EEMi7crN/GmHu4NA9l47xhwzNgZeKfqIwYlgui946AwZWPCc+1tes6AuhKChJJeoIpSVde2y/DZA96lwPaePaZ4DWLedkigiSxBbBuZimnQqGLEKGygPrFA8NywYFlvx+1u7uViLCYutBn1zX9sTVXJXotoz/D9LmRmlD87lQ9XNABkLWo2NNJ4GYnTkEZZwxqK2KYUXYavRER0LaZ+fKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cl8SlJ46Y4kxoa246lyrQfLMziDqadJpMbu3JC9GiMs=;
 b=ruzkTgt4MIB/7siAd3We7jSH2IBBJa2g/bDowyWfvmhKFS8v/7DTjNScBdcsjovW/YdArkwryi5yvdnBeIx/kfBjMf1c8xRgfMZcLVt7lHKjacI98Bidl+B5zLSSuQAK3bk55yPOMeDXRXlDP23WIVkEkY4cuz4UvnRsWzZ5Mnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 14:43:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 14:43:07 +0000
Message-ID: <3a4b353b-0ead-0e76-3340-93595044fdb5@amd.com>
Date: Fri, 16 Aug 2024 15:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/15] cxl: fix use of resource_contains
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com, targupta@nvidia.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-6-alejandro.lucero-palau@amd.com>
 <20240809121410.0000061d.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240809121410.0000061d.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d002dd-7cb5-4aa7-b8bf-08dcbe01be43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGYvUTc1NXpVYlRUenA2TUZNRnNMZXlCZmZlV1AzYXZPVm9yUmNSOFFWcnNY?=
 =?utf-8?B?ckpzVXh4MVBTN1AzTDhSTDFGVUErYjVicW1hVTV2eENCeHh6TkRyWGNNMDd6?=
 =?utf-8?B?Z2tTUmc0SlhVOEZSYkJ1YmRhaThpOHFnQ3RhMURnczNtRjFtTk5PYndNdDNI?=
 =?utf-8?B?U3E1V0F4OWtNNmgwSHdWZHFDamViS1lCcHQvT0cwZWlvSDdhcVNVU1BsRHUv?=
 =?utf-8?B?UGd6REhoVnpaenpaOGpmcWZ6a1ROR2dVK2xrLzQrSzY4djVJUG1HT2tJK0VF?=
 =?utf-8?B?Mkt0YmM0OE5RQTBFWjhHMVVMaXU2UkNhYXdSWnpZQTRwN3daS2Npc2J0UjZS?=
 =?utf-8?B?ejYvclFybjlnK2FDQjkvOGxjSEorUkVBOThOZ01jd0VQbHRZRndBQ0xFQkwx?=
 =?utf-8?B?VGE2a1lwOVl3MEQrM2ZXekxldUFCSy9PU1F5ZEdGd0ZjM1NJS01RYVlOb2p4?=
 =?utf-8?B?TThlazRmUkFXaUY5UU0vdURFWmp2S3ZxL1h1NjJaZ1A5Um13UlBHc2ZoWU5q?=
 =?utf-8?B?eDl4WXNZWkU5MTBzeCtYRlVidUdvaE1Ram9pYWhCMHA2NEtPZHhwQjRJN0lP?=
 =?utf-8?B?bFVzR3poTE5nZEZLODZTemQ2UDdoZlhrczJsbTBySnBxZE16T0g4T1hCcUpR?=
 =?utf-8?B?Rk1RYk5Vb2taNUI2WFAxbWFKQnBRNytPMVFHT21ENTdiWG5FNU05TmJyN1Nl?=
 =?utf-8?B?WGpFTnlqVlhnR2JTNU9hKzV4cUsvdXRYdVB5T25aTS9PdndvWlN5bSt1TTdH?=
 =?utf-8?B?VUJuZ3ZWV3QyOXY2eTR5YlpqbTRWZnQ3SFpJbU82WmZpRXZkcG1GRnhoQWU1?=
 =?utf-8?B?emJrWm5BaWFiSFF1bFBVSituUDJrYmZONGwraTNaMTZjTkt2TG1OMlRRMFo4?=
 =?utf-8?B?YVc1Wk00OUNsTytxN1RUV1crVE5BSGw2S2RTY0N3QThIR3lSTkQ2cDBjYjgv?=
 =?utf-8?B?ZEFxcEJMc05qSzZMV3pBNGRNN0ttZktGS3VkVFdRTHp3ZUJFTW4vQ0JqeDBN?=
 =?utf-8?B?YWpRZjkrNEhkclBYQUlYMDdPVWVKRXBoRkdyZlcwY09HZ3ltcmRyVURDbHp1?=
 =?utf-8?B?WXBHZmFrNjhJYkFKNVZaT1JoMWs3blJQWHE1OE9wUzBGSERSdEJMZkxpRDNB?=
 =?utf-8?B?ODRlMDhOYkNtRlBvMThTMkx0OEtGSzFjSnp2L1FVTXhqR2NCUjN2NE43eFEx?=
 =?utf-8?B?TGltQ3AycHVaZjBENklNOWlTaXc0NzFKK2ZzNTJtYjZ0RlpmYmpYdlBPWjBQ?=
 =?utf-8?B?cVJuSWppdytwSXRiT2NzU0dQb0x4VFQ4WkhEcE1JZnBtV1dmQVhTd2xSb2FJ?=
 =?utf-8?B?dmhrdFpzaHZXKzRDSUhLZndURGlpenhGbFRQV2p1UWMrcEUxRlE4anVHNWVk?=
 =?utf-8?B?WDFtRkdQb3gvRHBvOHFsOUU1dThvOUxGYXpiaHZrZXh2Zi92b2N6QzJDMTJW?=
 =?utf-8?B?RXkrVFo3YkZuMGhDamQ2NEEwd1NxUzVlbUtTTW0wREhCZGxCTDZjSllmMXRx?=
 =?utf-8?B?MTRVbEdWN0tvU1F3T3JySzcwZkkvNC9LT2NVakFLWHgyeEM1S3V4Myt2b29D?=
 =?utf-8?B?TFI4WlBObGdZZ3Z6QkJHSmNTbmdZa0dxd0RtOXNFY0xlOG95dkhiNXhCTGZ2?=
 =?utf-8?B?c3ZTcnppWnFvZU5Pcnl0T3VEZTB6K0d0cXdmTjNoMFBpOGNtTHFBakhGU3BF?=
 =?utf-8?B?MG05SlJQRzhUVlBId2tUdHd1UzR2ZGJlNTBndzh2b2lUYlp2d0tkMHZSWi8w?=
 =?utf-8?B?WWRTeFFJUGRpeUEzdURMWGNJUzN4ZVcxYWttT2JmSGdkZWJkd3l1MFduSTZ3?=
 =?utf-8?B?bndxVkh4cFI3YUY3bWVFQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXQyK0JoR2pKYmNyVW9tYTdFZUZFMjhFbXNRYmpncjFRemFEWWp5SlVzWlB1?=
 =?utf-8?B?MGkrSVlSMnZod0JhL1hYRStKUU1JWm1mN3dnaFNZL1FHbUwvbzhrbnNGalYy?=
 =?utf-8?B?UnNxcWk1WCszMVZ5SEN1SnhoTnhLOHpIdE5ycTBtRElLUVFUMzZhTjFRYkY2?=
 =?utf-8?B?ZDNuZGVjZFFBQ0ZOUUtlc2F6Y09oMVJKbXpZdFY4M0hUVnBVVEhIcHgyMmlv?=
 =?utf-8?B?WVlHL1lmQ2xIRHY4WmRKTU5XZlRiaGlLeVNrVVk2ZGYxM1hqTDdHSFBiMmNW?=
 =?utf-8?B?SFhBdGhQa3FtbWJMRXNqcmpVQngzNW5hc21CZlM3dDVQY0FXZlppNzRXMzR3?=
 =?utf-8?B?NkFiRVU3Wks2MkJoekx0VDFWbEJOK3I0YnB5M2lnZ2xKSmNNVG9xQlZRb2pT?=
 =?utf-8?B?Vm9TUW5Ea1NYUWcyb0NUOXhSN2kxUnJDTEl0cVVPMGRVam12NkUzeGVxRTVT?=
 =?utf-8?B?Zkl2UVVWMVdVOU1xZGR6c244T0lFQlpnNHlIK1pvSTkvWG5GR2l4eVI1Q3g5?=
 =?utf-8?B?cVFrYXdIMWNsc3VKWFJWcURuMDUxUWNkd1hHdUtwT3hoRVkzMDBlZmJaTjEx?=
 =?utf-8?B?U0JzVnp6U3pjZGVmYnBYQ0RzcCs2cFBlakJPekxXZ1cwVGNpSGVkckF0WUl0?=
 =?utf-8?B?dHFlbDVXQW5XWXFyQ2xQaFpJdEJaZ1ZGZ0ZWTHhNS2dXRmQ3VkI2ZDV1eU1Y?=
 =?utf-8?B?UXVEbEhzS08wZVQzUFJiemxTQjhYb0FLbmdmM0JhNU1vR3djS2dNaVlTUWNV?=
 =?utf-8?B?d1F6RDBYempxYmIrUEF4bjhpQy9ZOEFwRGJtNm95Qnl5V3lNQ0Nvc3BEdE5h?=
 =?utf-8?B?SHlWTWVsNkd2dmt2cFpwTFpadEJFTVd0NkI1WlJ6Y3Z2K2lsbzRLQ1AvUTc0?=
 =?utf-8?B?Y0o3OWZXQUEranQzdUZ4MkpGMGpJekZMN01BTzN2aklrclNwdno3aVRrcVRj?=
 =?utf-8?B?VUplTUt3S0UyclhQQXN5d0lJNFowRE0zT1NBTEE1dUFsUUdidXVhbnlqL1BZ?=
 =?utf-8?B?NlBWb2o4bFlvYTJ0a2hUYmZXM1Avb3V3QjhCYnpUZW8valo5OVV4cmVqeTZE?=
 =?utf-8?B?TXNHcFJHUUtnd3NXMDcwakV0eUx4NXk3c0dBUVJOYm81UVRJLzhkNCtaM2RX?=
 =?utf-8?B?VDFOc1FLUVdwWEFhOFlTNjNMUkpQQlFXeldHbW9VMHoySXVldXdhSjgzRXlN?=
 =?utf-8?B?SGdDQWxoL2htWm1pdE9CWXlTK2ZTN1NDVGJtbXRITWNIQ2x1dm9EclcwMnVv?=
 =?utf-8?B?WkxUamtLRkpBcFM2SjIzTVFwM2hnTjQ0UFVKQUJuNmdXMHN3SjlHUlV5L3FE?=
 =?utf-8?B?ZkF4REZwM1BPb21hTzVnaHFHcHl1RFJ2OUpSM0JGeEZTWnBPeFlHYUh4dmdo?=
 =?utf-8?B?dnpTQWdxVnVWMG9Bc1VuNzY0WElHRDN6Z3JHNE5hTi9DajhqNEN6UFlLZC90?=
 =?utf-8?B?RE1hanBxdlRCWXBZK3pTWEZpcjBzWTNJTDNKMW42Ynl1cHZ0RnlyQkRLUjBi?=
 =?utf-8?B?TFpqOUdYV1d6cFhsb3pBaEVDMVZXTERoR3JMTjRtUUgvcmFpYlRBUEhwRUhP?=
 =?utf-8?B?SDRwMzZKZFltQUhvaFJyaTNjY0EyWkV0SlpUVStNK3pBL3BDcVdpQVg2c0x0?=
 =?utf-8?B?R0I5Wm9RZ24vY3kyR0g3TG9XcmpmRDRnc2l3YkF0d2tjR29wejI4K0VCSjla?=
 =?utf-8?B?N3lkYlpJcisvNm9mMHpNTVJOdVhPbU1kODRBcE9rYVBpejUyL29rMUh3QjRB?=
 =?utf-8?B?UjlUbXRRamk3R25BNGFUZk8xKzNJWGNyT0o3bkpBWmYyTzMrSkwvdGVQbit6?=
 =?utf-8?B?MlhmcC9WL3FGdzM3cEVaMS84T010dTAvTWNaSmpvYjdRRHdzdENRVDM0UTIw?=
 =?utf-8?B?QUlkNjRma091SjV1ZVNEbWRjRlUrVnJpQ1pKbWprdjlsM1kwekZRcDVUWXZL?=
 =?utf-8?B?b0RxbjNJMFZUbjE5dkQ4UVA3VlNVYStMbFZWQkxBU1l4Zm1BNkF4cUE1enAy?=
 =?utf-8?B?M0s5aE1zdXc5Q3g2aFFyNFUwcmQvU25sclU3QlhUNXdvTlVCYi9TVWluSUwv?=
 =?utf-8?B?RldCTSt6cTc1c3VndEFPWGxMRHpPSDdRL2RnNzdSRVR6ckIwN2hTeENtYS95?=
 =?utf-8?Q?km9RTXyLS0rGFY6RCBvw6k0V8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d002dd-7cb5-4aa7-b8bf-08dcbe01be43
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:43:07.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcqhw5/DG5954KVacL9FPPPVHRTEAbwNr1Igkw1nM/u92bRtxYf+F0XGH04HfDCMw8ApQqD+VvY+C/fe9pzqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218


On 8/9/24 10:14, Zhi Wang wrote:
> On Mon, 15 Jul 2024 18:28:25 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> For a resource defined with size zero, resource contains will also
>> return true.
>>
>> Add resource size check before using it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 3df10517a327..4af9225d4b59 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct
>> cxl_endpoint_decoder *cxled, cxled->dpa_res = res;
>>   	cxled->skip = skipped;
>>   
>> -	if (resource_contains(&cxlds->pmem_res, res))
>> +	if ((resource_size(&cxlds->pmem_res)) &&
>> (resource_contains(&cxlds->pmem_res, res))) {
>> +		printk("%s: resource_contains CXL_DECODER_PMEM\n",
>> __func__); cxled->mode = CXL_DECODER_PMEM;
>> -	else if (resource_contains(&cxlds->ram_res, res))
>> +	} else if ((resource_size(&cxlds->ram_res)) &&
>> (resource_contains(&cxlds->ram_res, res))) {
>> +		printk("%s: resource_contains CXL_DECODER_RAM\n",
>> __func__); cxled->mode = CXL_DECODER_RAM;
>> +	}
>>   	else {
>>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not
>> supported\n", port->id, cxled->cxld.id, cxled->dpa_res);
> Also, please clean up your printks before sending them to stable.


Sure.

Thanks!


