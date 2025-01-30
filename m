Return-Path: <netdev+bounces-161614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E6A22B8C
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF9C188274C
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E8533987;
	Thu, 30 Jan 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="mdTWHpbS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2109.outbound.protection.outlook.com [40.107.247.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FB20328
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232403; cv=fail; b=uvz98MDwonxJReMizq9GFJG/PpK8eBLQGA9ruNPDJVdYyTkahbUnkpyPs8Fu262/HdW8gvBhjYI0yEpHn5dv3YDZUIoaoVPwXbHhjudYo9nJJYxAfq2FLEYLkPgBi1OrztvxaOS9o+WjrQK+gncm/dEd6sg58jYfi1RPZ2wJ1rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232403; c=relaxed/simple;
	bh=EN7pTnsYpdFG7mOdx6hXpxSCd2qcoETYcxzEDsk6VTI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pIDaWlq81zQTwf/rwL7Vib24QMNXQSJs6I0Mq1tHiGztZgfw7n3rmNqH2nF4BvlERivVlsZgpcWKegeDCgJCw3esP5/UHzCVQbzDlMEgHP5shojz9MhgqWf8RSGz6TqlstN13sPw0S4WTJNZWipdrgdATXHUPs4UqTU1sRcQRT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=mdTWHpbS; arc=fail smtp.client-ip=40.107.247.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX6NKekG+f5C2S4GpJpphhsOlrnFgWzdz+1xcbRpjpJ23sr0aBw0sQbc4b13krhNnOQ0qtA7GYOokW7ls4YfLc10Rvwf66NGEg7Aw/Hd+Srdp1XPO4GU9Zte5fB/YpUfP2CCv6JDtd2GusmKdpLcX6uJxmkRaeWdTz04EqyhsHbR4lsVfdqa6VdYxQ1V4RRuGui4a10Xas5dLyXjSjQmRVlN950XpcGbLmAMeWRYr7vQrMRfk3XXlZQTNiD/wDDGHIcgfXZNichEwWSMByGeliHlzAuQizU56kEfOktb+UVzVKl+uom193bF/5PX32rr/Am9hGpPg34rWAeGI1AMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6rV/lEMhH2E3aan/aZBk0uwgK0cnEXg4S/LvzdXols=;
 b=hF6A1sqhPK/45zwxT5D2laY5nxS5mWdNG/Rrzo3xNQxPxeerKuZeksunBs+LvsVxPeK8fu/XQFnMBxe3v91NFC+bwf723THHHB/g30OpuRksdaYfypil+P6RhCrxShkZq6r8X96A6n8FkbLSozylKEQbq+yfADTTAl/W+0r0CkWrY6Tu5dNMd2Ejo6X3ciutJdlTU1RwjN1hfjUACx/1vW+7znHo4ZRooxBN5iiuKoP2nRLI1uqCXEMo8aMVT3rDIi0AcRY0YI65MIq6Yf9Bjs3eZmHlks928X5W1C3f32lkLyWp9R5bfk675neLrmT4ciS9GUyU4lJAHAUJLxmQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6rV/lEMhH2E3aan/aZBk0uwgK0cnEXg4S/LvzdXols=;
 b=mdTWHpbSOEzeekyWVy8jg/LCMg5Ch1/guNKUlOMvqnh5SziXrY/+KzEMADW4z/0V3cUPRYu/BSjA58ABWE8k6ULYMYeeEzlC5pTWRV91fdBdmAIJmc7z25/ENgDjBwnqP5yoMo0ygEu23W1FA5ZGdUGzIUBOTS3LpPAQ0hI0qUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAWPR10MB7748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:369::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 10:19:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 10:19:56 +0000
Message-ID: <d8603413-d410-4cc9-ab3a-da9c6d868eca@kontron.de>
Date: Thu, 30 Jan 2025 11:19:55 +0100
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: KSZ9477 HSR Offloading
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <20250129235206.125142f4@wsk>
Content-Language: en-US, de-DE
In-Reply-To: <20250129235206.125142f4@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAWPR10MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 117e4dae-90e9-4538-ecf2-08dd4117a50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE15ekJoQXZnd2w2amV3dUx3RTFUaVp6bHhBZmxFVzljZFo2Q21VYldlRE40?=
 =?utf-8?B?TkR4K2JMdm5xQ2h3cUFKY1lheWhxR3dXNC9XUDVyZVBuanRqZ2R3eDNvYnVI?=
 =?utf-8?B?Z0RBWi9Pd2FEbFNhcFl2bDB3bmpaLzIyOHIzbU5JL0Z5SlExV3dNak4yVlBv?=
 =?utf-8?B?VTBBSzRYa2NnMzk3MUpQdzB5S3I3RThwNWhYbDZVZ01IVTZ2bE1XbmprcG45?=
 =?utf-8?B?SjBndjdCRGFzYjYzM1g4NUU3RUhwWGJQekJvTUFsZVMzV21rRnVYbnI1YlNj?=
 =?utf-8?B?MTJJWFNRSU8zTGxHRGF6Rkc5elRFa3A5eHMvOEZ6OHhkTm9NVmdHU1NHb1d0?=
 =?utf-8?B?b1dLdThXbzJaWnZNTXZQMkNmTWVKTVhYNG0xeHY2MHJPTllWcWlhWWRXMFpN?=
 =?utf-8?B?Q2xwbVI3VDh2Nk1iZWk3MEhESGhhUisvUGc4T0RKdkJkVkxBTDh2NVZ3RHpp?=
 =?utf-8?B?SlI1ZFg5ek5Zc0lseCtKaTN0MTJFaU1wdVVhRW1jcGJDMHNscWN4eWc4QlIv?=
 =?utf-8?B?SzRaWTdSSzBLbDg5RHp2RitlY3o0NUx0VUN4TmZBdWRid3BCTk45clQzYjBL?=
 =?utf-8?B?QTgzM0U2MTF5b3pScUVmWmQ2azkwdFY2dDloUm5pVGsrM0VOcHUwelNxaUtq?=
 =?utf-8?B?eU9QM0VSSXBZUlhrOWV4bkMvMzJSZ2kzK1FTUlM5SVZnKzRJR2pHZjdGQXVI?=
 =?utf-8?B?aXpLME41bjZ0dHZ4NU5Cd1BJTFVMOEFqZHowMW1LekNOOWNMcCt5bExieHU2?=
 =?utf-8?B?ZEFGRVV1T3VHN0xGbEx3MHZLdlQxZmpPelZSQmVYOGg2eFNEY20yTDgxN1I2?=
 =?utf-8?B?T3g3d1g0ZVIrTUhkZ1BYZmwvYmtzTE4vK2lMc25rbmd2SEhwUHQ1S0psREIw?=
 =?utf-8?B?d0lhS3VGeEsrQTFxNTlZQ0lUcUdvNitoRVd1MGJ0OGoveVFaOXJWNzAva1dM?=
 =?utf-8?B?VkZ4T05KMEY2NHg3YUpiSDR0dUthby9uY2Ixc3p0YzdkNmlwelR1L2dlT0Zs?=
 =?utf-8?B?ZmgzZHgrRlRYelEzeS9DcEdsSGRnajdqaktTUFI0L2J5cVZHVlNJN3YzQkVj?=
 =?utf-8?B?ejJlbVpvUGkreGNlWEQ2aVFCU0tYN291M0ZiblZQOFMxNERiZjZ6UmYxTHpo?=
 =?utf-8?B?TDZ2bmhSamxMMWlTSldoRHNXWkFEem5PaE9tRmRIMFh0bG1MZkJlOFEyZHI4?=
 =?utf-8?B?ZHlqQUNrZURydFNHVGZkZGkyY0hSdEw2NmM3NEd6L0ZIL1ZZNlhPUlhvWURw?=
 =?utf-8?B?aDVYUXVXd3hNWS81cERENjh3eGtwWWV0K2Zjb055cXNVeHQ4V3FmY01PckFq?=
 =?utf-8?B?Y3c4dytLSnh6WFlIWVh0UVlaNytueXoxMC85c1lYeFZib3hYU0F4YVJsN3lk?=
 =?utf-8?B?NWdleDRJZEJIRXBzN2IvMDR3Sm8xRkhKRkh4RGh0MkVHbmQ1cHovWUtYcnEr?=
 =?utf-8?B?M3pveEt6V0cxb3pBZEFOMk5LZ2lVQXZ4VkMrMmFjbnhKaWoycEVEdVNQcCtW?=
 =?utf-8?B?aktKajI5SmJYWk9Wb2NvSzl6Qkx0MjhZWnNLWHhLN0ZhM045QmFFMUxqa1ZP?=
 =?utf-8?B?dEFrdXhjWGhtaitodEJ6TkdlT3E4RjRhWEQ5M20rZzF6YTJTOTFRLzQ2bGxZ?=
 =?utf-8?B?RjRVWlp3dFpXbm10WmNBR2RYV1ZtOHRwSVhrUnArKzZ1TzExUFF5U3BQQVUz?=
 =?utf-8?B?RDVIeGxiTWl2ZkhZRHp0L3NQL01mSUp1TUN2UnE3Zk12UmJDSUJ5V1Z0Z05p?=
 =?utf-8?Q?PVY0dfsdODYqxRjatfIBF9xn64U45cLJdZWByh1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJwN2c4SVFza1hPZnpZYkx0S3FQTlU1bkZuQ0R4M3YyN2ZIbUJvN1Q5dG9j?=
 =?utf-8?B?ckpQUURsRmpKZU5lNDh0SzlEYmNYN2RIOWQ2bmliMVlDSE1YWnpkVTBJWTZv?=
 =?utf-8?B?NE9IVUtkTWNxaGtpOWkzTmdSYVdSZVpERjd2NzRoZjVXMUJTc2h3Z2pIMXRr?=
 =?utf-8?B?QmtCSjFKNWFmSERuU29oNHI0NXRKRVhGWVQyNGo2eUszZE1xYnpXeGxXeHMr?=
 =?utf-8?B?MmNqVWZRTkVJWitJOUNNS0hLcnA4K043ZWpDRVlLNThCL0pON1l2ZENKcVJz?=
 =?utf-8?B?b2sydC9TdEg2T2dscTNKcUtRd0R4dzE2aTNycWMyTkg4SFN1SmpzMWZ0WHcv?=
 =?utf-8?B?amg5VXVmSks1akRjbUJTaVRpbERxOXM4eTRRNmswRkNMa0RPSi85V1lKOVcw?=
 =?utf-8?B?YmNPYUcwN055NXJqTlg4SGNEZzJsSkQxRUVGeldKNG5nK1RoS2VIb1lObHRH?=
 =?utf-8?B?UVYxUHIzOGRReVo0K0hKRUtMNGFXT2t6c2tQR0RtRGV2U0FMdjJwaWczdzJI?=
 =?utf-8?B?SlJyeGNpSk5weHVoa3FOK2NhZy9GeFhwbURRME54dWx1bk4vUStlN3VTd1cy?=
 =?utf-8?B?a2prR3J5eStNS3ZWeVNPL1FiM29pbEQxRS9tbm9YSVowaW9jZUV5cCt4TDRu?=
 =?utf-8?B?ZnJ3eE5qZXdLMkhnUUMvcjJMRHB5Y0UrcVhuNHRsY3dnV3NmRk0xc3Z5bVh5?=
 =?utf-8?B?R3ltY04rQjNWQldDSTRaeGY1dGRtcGFKSlF2d080MUgvN1BUbUxlMmw5ZGFD?=
 =?utf-8?B?Y0FkZ29TNHRuZnpSSDh5M2dWTVNLaTE0QVhnVytNc2t6WDZnS0YwQWc1b1ls?=
 =?utf-8?B?cVMrVlZIcE81UXoyTkt3Vnp6L2Q5V2xwSTNudU90SHVHZG45aTNCdE5xeFRz?=
 =?utf-8?B?T1g5MDFXS1NtL1lvTjdxZzYvRzhpVnVEbWZnK0ZpTG9GUVlYazdLUFdmTWE3?=
 =?utf-8?B?ZDNoQVduTHg1cTdiSFZINit6Y1I4c3lPOWd4Q0VrZGI1eGdxSjYzcUo5ZEZk?=
 =?utf-8?B?cnc3QXdjOVM1UHhwMENGZFRtMUhBSXFRa1NocEdteU1UbTNQdkFOVGlsSUhI?=
 =?utf-8?B?Wld3UGYrb25Yd3dnV1dMQnJjdm04ZUZyUlk2SGplbUFBbjkvMGd5NjdnSDFH?=
 =?utf-8?B?TGN0a3NYci9iTlRmOVJEWlhQeSsxYXdQckFFaTVMTGVJR2gvOHdTa2VGUXlD?=
 =?utf-8?B?NEpvQldtWnFsQnBjVnZ1dXNpMlNkQTV5dS90RVp3QWdDbzA1eHg3NEdCZjNl?=
 =?utf-8?B?L2ZNMVE1aWlzTy9xZm51RHFnRUh2Y3VPeXgvbnJyUWRMcm1rTURVcDZRbHJI?=
 =?utf-8?B?bHhaeG8yY0diUldzN3hHYUdUdThtbThBdUZvaVpBQ0xIL1BZYVFOa0JpZzFL?=
 =?utf-8?B?TmpSdUNrSEErZTNVMkVmcVF5c3dEYnMwNnBnMmZSc1BZdlppc0l0QTlDYlg4?=
 =?utf-8?B?K01Zb2hmQnpXQ0piWEVQNFF3Z2hDbWlLNFliWVJMSU5WUGpSa2R1QUFqYXVr?=
 =?utf-8?B?eVZGZWIraW9nNUh6YXdGRWF3NFhDRU1BTGp2UzJGbGZjQm56anUzblVoTU9y?=
 =?utf-8?B?OVNXbVBiQ1k4WnB6b0R6UCtlK1dWdVRDVkEzdytrVUUxbDlhaTNxSlRTbG9W?=
 =?utf-8?B?djdSaWppUDU1TWNzSlkwV1B1RUJnZ3FoY3lFME13MEI1b0xMRXhLTUpPVEhs?=
 =?utf-8?B?ZkxEYVJTRFNSWHhYNERYNmdhbmJaUXA2aU1TU1VVSittQ0Fncm8zandsY1R0?=
 =?utf-8?B?QytreDVySTl6QTNUWDdWY3BBN0tybzZoaEtvU3ZZcVVSK3lISVRXSkNLOWlY?=
 =?utf-8?B?T0Z5em40RFYzczkwbGdJYjl1MWw0eE5EM0ZyQU5KNUhTdHJ4d2lvVjk5Ny9o?=
 =?utf-8?B?MzlRLzNUa01WWllvenBrVWQ4ZUUreUdXeEcyMFYrTEpsWFdKMGY5R3ZJMXEr?=
 =?utf-8?B?SE5rNjQ3SldNY2ZBNWtCTGRVZTV4bTFpSGhSQ0JRbEtiN3dLR2FrVlMyNFZO?=
 =?utf-8?B?VkhZZTZzUHNST2dEU01NdklQUXNnRWFoWndaWXZzSXBuRkJNNzRyejc5a0Np?=
 =?utf-8?B?RzNPQzc0UUFINk1xMlJHV1NuMDd3L0t0YjRrOHJjdmFWci8veWJyR1I0UFdZ?=
 =?utf-8?B?ajFhdnpDVnhmaUVaeXlpaXRsa2lTcVBiK3RxbFVDWldCbjF6SjFPMU1FbkpE?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 117e4dae-90e9-4538-ecf2-08dd4117a50b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 10:19:56.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGUpP3ZMu0xx8wJM/bTxFfBQcgXljiXtAakRgLVjgiUJXPYXZVbdEjif7f1QM6ni81NJ4SlGSVixAOLUflplMmP/UadAAyEZh7Xgtror76Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7748

Hi Lukasz,

On 29.01.25 11:52 PM, Lukasz Majewski wrote:
> Hi Frieder,
> 
>> On 29.01.25 2:58 PM, Lukasz Majewski wrote:
>>> Hi Frieder,
>>>   
>>>> Hi Lukasz,
>>>>
>>>> On 29.01.25 12:17 PM, Lukasz Majewski wrote:  
>>>>> Hi Frieder,
>>>>>     
>>>>>> On 29.01.25 8:24 AM, Frieder Schrempf wrote:    
>>>>>>> Hi Andrew,
>>>>>>>
>>>>>>> On 28.01.25 6:51 PM, Andrew Lunn wrote:      
>>>>>>>> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf
>>>>>>>> wrote:      
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I'm trying out HSR support on KSZ9477 with v6.12. My setup
>>>>>>>>> looks like this:
>>>>>>>>>
>>>>>>>>> +-------------+         +-------------+
>>>>>>>>> |             |         |             |
>>>>>>>>> |   Node A    |         |   Node D    |
>>>>>>>>> |             |         |             |
>>>>>>>>> |             |         |             |
>>>>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>>>>>> +--+-------+--+         +--+------+---+
>>>>>>>>>    |       |               |      |
>>>>>>>>>    |       +---------------+      |
>>>>>>>>>    |                              |
>>>>>>>>>    |       +---------------+      |
>>>>>>>>>    |       |               |      |
>>>>>>>>> +--+-------+--+         +--+------+---+
>>>>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>>>>>> |             |         |             |
>>>>>>>>> |             |         |             |
>>>>>>>>> |   Node B    |         |   Node C    |
>>>>>>>>> |             |         |             |
>>>>>>>>> +-------------+         +-------------+
>>>>>>>>>
>>>>>>>>> On each device the LAN1 and LAN2 are added as HSR slaves.
>>>>>>>>> Then I try to do ping tests between each of the HSR
>>>>>>>>> interfaces.
>>>>>>>>>
>>>>>>>>> The result is that I can reach the neighboring nodes just
>>>>>>>>> fine, but I can't reach the remote node that needs packages
>>>>>>>>> to be forwarded through the other nodes. For example I can't
>>>>>>>>> ping from node A to C.
>>>>>>>>>
>>>>>>>>> I've tried to disable HW offloading in the driver and then
>>>>>>>>> everything starts working.
>>>>>>>>>
>>>>>>>>> Is this a problem with HW offloading in the KSZ driver, or am
>>>>>>>>> I missing something essential?      
>>>>>
>>>>> Thanks for looking and testing such large scale setup.
>>>>>     
>>>>>>>>
>>>>>>>> How are IP addresses configured? I assume you have a bridge,
>>>>>>>> LAN1 and LAN2 are members of the bridge, and the IP address is
>>>>>>>> on the bridge interface?      
>>>>>>>
>>>>>>> I have a HSR interface on each node that covers LAN1 and LAN2 as
>>>>>>> slaves and the IP addresses are on those HSR interfaces. For
>>>>>>> node A:
>>>>>>>
>>>>>>> ip link add name hsr type hsr slave1 lan1 slave2 lan2
>>>>>>> supervision 45 version 1
>>>>>>> ip addr add 172.20.1.1/24 dev hsr
>>>>>>>
>>>>>>> The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24
>>>>>>> and 172.20.1.4/24 respectively.
>>>>>>>
>>>>>>> Then on node A, I'm doing:
>>>>>>>
>>>>>>> ping 172.20.1.2 # neighboring node B works
>>>>>>> ping 172.20.1.4 # neighboring node D works
>>>>>>> ping 172.20.1.3 # remote node C works only if I disable
>>>>>>> offloading      
>>>>>>
>>>>>> BTW, it's enough to disable the offloading of the forwarding for
>>>>>> HSR frames to make it work.
>>>>>>
>>>>>> --- a/drivers/net/dsa/microchip/ksz9477.c
>>>>>> +++ b/drivers/net/dsa/microchip/ksz9477.c
>>>>>> @@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct
>>>>>> ksz_device *dev, int port, u32 val)
>>>>>>   * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as
>>>>>> HSR frames
>>>>>>   * can be forwarded in the switch fabric between HSR ports.
>>>>>>   */
>>>>>> -#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
>>>>>> NETIF_F_HW_HSR_FWD)
>>>>>> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
>>>>>>
>>>>>>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
>>>>>> net_device *hsr)
>>>>>>  {
>>>>>> @@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch
>>>>>> *ds, int port, struct net_device *hsr)
>>>>>>         /* Program which port(s) shall support HSR */
>>>>>>         ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port),
>>>>>> BIT(port));
>>>>>>
>>>>>> -       /* Forward frames between HSR ports (i.e. bridge together
>>>>>> HSR ports) */
>>>>>> -       if (dev->hsr_ports) {
>>>>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>>>>>> -                       hsr_ports |= BIT(hsr_dp->index);
>>>>>> -
>>>>>> -               hsr_ports |= BIT(dsa_upstream_port(ds, port));
>>>>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>>>>>> -                       ksz9477_cfg_port_member(dev,
>>>>>> hsr_dp->index, hsr_ports);
>>>>>> -       }
>>>>>> -
>>>>>>         if (!dev->hsr_ports) {
>>>>>>                 /* Enable discarding of received HSR frames */
>>>>>>                 ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);    
>>>>>
>>>>> This means that KSZ9477 forwarding is dropping frames when HW
>>>>> acceleration is used (for non "neighbour" nodes).
>>>>>
>>>>> On my setup I only had 2 KSZ9477 devel boards.
>>>>>
>>>>> And as you wrote - the SW based one works, so extending
>>>>> https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selftests/net/hsr
>>>>>
>>>>> would not help in this case.    
>>>>
>>>> I see. With two boards you can't test the accelerated forwarding.
>>>> So how did you test the forwarding at all? Or are you telling me,
>>>> that this was added to the driver without prior testing (which
>>>> seems a bit bold and unusual)?  
>>>
>>> The packet forwarding is for generating two frames copies on two HSR
>>> coupled ports on a single KSZ9477:  
>>
>> Isn't that what duplication aka NETIF_F_HW_HSR_DUP is for?
> 
> As I mentioned - the NETIF_F_HW_HSR_DUP is to remove duplicated frames.
> 
> NETIF_F_HW_HSR_FWD is to in-hw generate frame copy for HSR port to be
> sent:
> https://elixir.bootlin.com/linux/v6.13/source/drivers/net/dsa/microchip/ksz9477.c#L1252

Ok, so you are using a different definition for the "forwarding". What
puzzles me is the explanation for the HSR feature flags here [1]. They
seem to suggest the following, which differs from your explanation:

Forwarding (aka NETIF_F_HW_HSR_FWD):

"Forwarding involves automatically forwarding between redundant ports in
an HSR."

This sounds more like the "forwarding" of a HSR frame within the Ring,
between two HSR ports, that I was thinking of.

Duplication (aka NETIF_F_HW_HSR_DUP):

"Duplication involves the switch automatically sending a single frame
from the CPU port to both redundant ports."

This is contradictory to what you wrote above and sounds more
reasonable. This is what you instead call forwarding above.

Are you mixing things up, here? Am I completely on the wrong track? I'm
just trying to understand the basics here.

>>
>>>
>>> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ApplicationNotes/ApplicationNotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf
>>>
>>> The KSZ9477 chip also supports RX packet duplication removal, but
>>> cannot guarantee 100% success (so as a fallback it is done in SW).
>>>
>>> The infrastructure from:
>>> https://elixir.bootlin.com/linux/v6.13/source/tools/testing/selftests/net/hsr/hsr_redbox.sh#L50
>>>
>>> is enough to test HW accelerated forwarding (of KSZ9477) from NS1
>>> and NS2.  
>>
>> I'm not really sure if I get it. In this setup NS1 and NS2 are
>> connected via HSR link (two physical links). On one side packets are
>> sent duplicated on both physical ports. On the receiving side the
>> duplication is removed and one packet is forwarded to the CPU.
>>
>> Where is forwarding involved here? 
> 
> In-HW forwarding is when KSZ9477 duplicates frame to be send on second
> HSR aware port.
> 
> (only 2 of them can be coupled to have in-hw support for duplication
> and forwarding. Creating more hsr "interfaces" would just use SW).
> 
>> Isn't forwarding only for cases
>> with one intermediate node between the sending and receiving node?
> 
> This kind of "forwarding" is done in software in the hsr driver.

But according to the official explanation of the flags [1] this kind of
forwarding is exactly what NETIF_F_HW_HSR_FWD seems to be about.

> 
>>
>>>   
>>>>
>>>> Anyway, do you have any suggestions for debugging this?
>>>> Unfortunately I know almost nothing about this topic. But I can
>>>> offer to test on my setup, at least for now. I don't know how long
>>>> I will still have access to the hardware.  
>>>
>>> For some reason only frames to neighbours are delivered.
>>>
>>> So those are removed at some point (either in KSZ9477 HW or in HSR
>>> driver itself).
>>>
>>> Do you have some dumps from tshark/wireshark to share?
>>>   
>>>>
>>>> If we can't find a proper solution in the long run, I will probably
>>>> send a patch to disable the accelerated forwarding to at least make
>>>> HSR work by default.  
>>>
>>> As I've noted above - the HW accelerated forwarding is in the
>>> KSZ9477 chip.  
>>
>> Yeah, but if the HW accelerated forwarding doesn't work
> 
> The "forwarding" in KSZ9477 IC works OK, as frames are duplicated (i.e.
> forwarded) to both HSR coupled ports.

No, I don't think duplication and forwarding refer to the same thing
here. At least it doesn't make sense for me.

> The problem is with dropping frames travelling in connected KSZ9477
> devices.

I'm not really sure.

> 
>> it would be
>> better to use no acceleration and have it work in SW at least by
>> default, right?
> 
> IMHO, it would be best to fix the code.

Agreed.

>>
>>>
>>> The code which you uncomment, is following what I've understood from
>>> the standard (and maybe the bug is somewhere there).  
>>
>> Ok, thanks for explaining. I will see if I can find some time to
>> gather some more information on the problem.
> 
> That would be very helpful. Thanks in advance for it.
One more information I just found out: I can leave ksz9477_hsr_join()
untouched and only remove the feature flags from
KSZ9477_SUPPORTED_HSR_FEATURES to make things work.

Broken:

#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
NETIF_F_HW_HSR_FWD)

Works:

#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)

Works:

#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_FWD)

Works:

#define KSZ9477_SUPPORTED_HSR_FEATURES (0)

Thanks
Frieder

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=dcf0cd1cc58b8e88793ad6531db9b3a47324ca09

