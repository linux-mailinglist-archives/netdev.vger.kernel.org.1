Return-Path: <netdev+bounces-240771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7113C79BDC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2550A4EB592
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAE5CDF1;
	Fri, 21 Nov 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gAX+d/8G"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA2130AD04;
	Fri, 21 Nov 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732781; cv=fail; b=kkob9tugSUU+NkvK0SAVuFfB3UY037TkJTfIZoFhG+ZKdrVHJ3WCQ1pV4DL7A9E+DQq76Px76aqFF1CeUz3JdtsqDXnEgSn2I9C43DyUwbG58pOdlBIj8EN83aksXwtfdSX0T1MraV59RIpkfXgETcfjAcWuc6N5r1pwQolqYsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732781; c=relaxed/simple;
	bh=IKeqdIImPwFjd35ZbscSX2lUmq/DY4YotEFlXv3RRJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p055PIInmHVMzXuABtdhapyKID1xK8KecVtDRM5J3KmdOzhpaMOlnUOshpT5z3QUU+EXo3dThgZCAIaVtoC6zMdg2+kAGX+zJM3Sr3kNMG+8DkyJ11jBMmjyLN7ALELKXeJui3+nJn6m0o1qLNySsGHB52cJWBWHvTZ9cosh9xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gAX+d/8G; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT/Izd4ZsfxlJUSaZQEpynA4SELMBjW/J/KTKM86RStT2dbscd7MyQ5Kzc3Okl0wtLiYjVPPaHG0LWMKvdZjHoeYsHWE1FrjZ7oLYERJ/xEBuDK3IOnGOjRQwGgOP4EbKVr39ZEX2zXyl4kqa+R8fDxqUtLoEhZRi7llhUfJo0+Y2YBGQkyQvyUSqNqJC1c6t0t2rcLW7eL0rwP5mz7c5yyVLXpb9woXURLwyhMFodU7+yFTBGJZEJLYr8bKmSrzejsn3jD4V5OZ/uFywsGJLgaDbrLoiQ0X6/jOZku4PUdA1O5qakBM7kvABOnvXblece0ArOoGIIMUR1jJT9hoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCiFj0q5RX07X2vcrZUnEw4I2J0MZTS9xREZsa7Pi8o=;
 b=wN9oMzNtsJjERYXg7mck5bFOUkJCz9vrwp6D0+QFenJFuIy7U/sLa/oRGICAKcMcxpxvrrn9f1KqviclU7R4hDPHXHzTcEgzKVoe9e/xwB5kUc4g6aHVTlaJq7OvxCcbO02zd4vXHUNYQIBg5gdajuHYtmQvvoAsuS+2SLzEObPV95slDb41mLYxPSEYsGe7P3sYEiozFxM2ZVM6vLBVo1qUHKi1edVS3ogHb6BDFw6BuDz27wEsPirC5ZlOKkLYUCJ/v9MopZT5fjQRzTo3KslXajCHPmvWreSFtQ40cLQ1HVfXSlbTgunWj1D95x7wzPatINX/+OxbiLbXw8bCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCiFj0q5RX07X2vcrZUnEw4I2J0MZTS9xREZsa7Pi8o=;
 b=gAX+d/8GhLUvb2k/n+rJ0oqf7tEzgLczcuOWB+V91j0ikssRBgcM6m/DsUhyhx7eYNO8T9RhuEQC8C3r2vxvIFLQEs78voz6REDQB1Vtb7Hi8/Z3KaRdwY6NwLJtSOzG3Olro7ZxY3VgtBn3tmR5qzaau05+yXjvbG4LaJLzHa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:46:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 13:46:17 +0000
Message-ID: <ad65998a-e00b-4388-b450-ed64c76a6d25@amd.com>
Date: Fri, 21 Nov 2025 13:46:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
 <20251120180805.00001699@huawei.com>
 <c40d91b5-d251-47a3-8672-b9ea5c54eb2a@amd.com>
 <20251121120656.0000546c@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251121120656.0000546c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fd1ed2-2ff0-4a9e-283a-08de29045869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmJ5OTd4STFKaDFqR0N5d1g4blRUZ1RKUlZ3WjZpRDJOVWxwbnAxVEZpcDZw?=
 =?utf-8?B?UEcrWnhlMEEyMmFIOXlMdEpzcXZTQ2Y0MXUrN3J4MjNZRFlUVXNsS2lBZUho?=
 =?utf-8?B?K1lrMnpBNGlSMzdDbk82aVV3YitUci83ODhZTWpSdkNGK2Q2UmFaNFZUckU3?=
 =?utf-8?B?VFVWZTE1aTNsZ1RITmVhb0wyWXo4SDVKZm01UEUrK2pvQ1pRTFdVMEVhNjky?=
 =?utf-8?B?KzE1cU9uMWRLTkV5L2lrdEhuOTUwc2grblM2TTVWWUJiS0lRdmFneEg0SVFi?=
 =?utf-8?B?QzZLaXozbkUrMHlGa1VEbldHdHVhV0dVWnVxb2ZocVRYV1pCenp0QjI3bXkr?=
 =?utf-8?B?WS9nKzBuWS9INHJ1NDd2UytBOWp0U0VzVXR3VEhxcUpMc0lkNEJKd1BJVmNZ?=
 =?utf-8?B?QzhLcWVKdnIvejltYlBIczZJb21sSG85T0hCTDFPbmVCMEFCcU5YWU50c000?=
 =?utf-8?B?YVd0cnMxYXBWK0c4UklkOStlenhYT3BoNTFra3AvREtpbklleEtTSkViZmth?=
 =?utf-8?B?WVZJbnF5eStYRW5WSEpvY3N2bGpNZk5yQ0R3WWR2TGt1Qmt2dk1xVnRta1RW?=
 =?utf-8?B?UC9uQ1phSE1MT2VuRk5MUWxDbytRUTFJakhrY2tzcy9ESHRTdVRmMGt6c01s?=
 =?utf-8?B?b3dtSXMwM2ZBRUxZSW1abHZGM1ljZk5IbXR2WUN2L3hNZ01sd1FiQm9jRTd1?=
 =?utf-8?B?YXpRaW9zaEw2bEp5Zy85ak5OeDMwdGhxKzNHU1dsUkxDZnAweUtwOHpPVktK?=
 =?utf-8?B?MUNiV3ZPWmNZbVMwaUdYR21iaVZTeWxBdVBCM3ZLTHBUMG14ZE8ycTRxMlNn?=
 =?utf-8?B?cEx4MTQxckVYcDNETHlNdWJNRTl2MGxhN0pOQmdGTXlWd2MzZHNIbjh4YVZJ?=
 =?utf-8?B?WHB3OEVXWWpuYkFFR2F3dHN5REc3M1dVR2tIU0FOZW9GSGZlWktPQmxEVkdL?=
 =?utf-8?B?c2JjVmxJejkrSEdpY2dXQlowSmZPVUxHd2swaUpuN2lubGkrMzB5dGNCOXla?=
 =?utf-8?B?SlIxaGFiTnJzVHQyem1iOVFqRjFIcFpVTkR5dWtkTXRGQkNkTFBhSkFONTBP?=
 =?utf-8?B?MkprZlNUL1JEbm83S1BUa1NIa0tQZU1JNVRLK0V2M3BLVDRJQ25zOVY1WWJ0?=
 =?utf-8?B?eUZzb0E1b21BeWdFaVBvZ2s4c2ZUSnQ5K3FGWVZJdWNhUXhiYnlHK1ZqR3lU?=
 =?utf-8?B?U2VqS3FCUmMyOTRtUGQrWlBRdjNnM21NYTg3Y1JIN0JFQzBIY2RpdmJIUTJv?=
 =?utf-8?B?SjZhbVBEcDFBUjY1OUY3dHpFREVXcEZwU3VUNEsvOHZVeHIzZWNYY0NZTVZs?=
 =?utf-8?B?Nlppa2JLM05XaDBNUEpDeFo4RFRodnRXL1NMWU9BUHNwd3g0bElYeEtzYmhX?=
 =?utf-8?B?ajYvaUJMTFRZYnRJWGhoUXlqMnFaTi9yRms3RDdYa3duV3RkeWZDaGkyMTda?=
 =?utf-8?B?R1BrQ3hzSDcrWWdmbXd3cFZxU1NFMlllM25FU05FbXpOOW56bnF3L0NoQlcr?=
 =?utf-8?B?Q0J6eUJndy9rU3RVOEU0Ny83QVFmYWNPZ1BoVUZ2YTlmOFZnN2dYMW5UbEQz?=
 =?utf-8?B?SlBwU0c0TDRlL3ZLdmx0cnhzUHpIYXZHdGpJV2Nna2V2M3ZETmx0YWcwdFJt?=
 =?utf-8?B?QlE1a293aXVYUjJ4Rml2dFhkNTY5OHlRekVTSHVGb2pPMzV3YzBEN1daNUhm?=
 =?utf-8?B?YUhCRXd5NDRkR3FPemIrcXUyV1R0MWZmZ09ibWNXa2cwT3c4N3B2bEY2Z2V0?=
 =?utf-8?B?a2VreWFXYzRjZlAzVW1jdWRxTk5qOGJyTGpHeEpISFI3OGQvVUZOUFpKcGVj?=
 =?utf-8?B?SUlDZUQrWlNrMGliMHArTFBMNHZ3aGh4M0s2b2RkRDVJZUZsVmkvTHlxQ21w?=
 =?utf-8?B?UWxSN05rTitUdEtrblJ5UEp5RnEwZnlZMGV4UXpjSFFWNlFaRXhFOW9icExT?=
 =?utf-8?Q?fPGctjOhHLd78t5RcW6LwLZdtm5S7w2g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlCdDNha3Fjbm1UZXEyTTJWMXdZMkdseXZtL3JWM0hjOW90THUwNkxUclFS?=
 =?utf-8?B?STZFWUJiMjduYk5mMDBDY21YYitpZEJLcXoyRlRZT2Z0dUZKYVlYaWdxandm?=
 =?utf-8?B?OUxtbzlCbG1wTXJraTlmVE81b3pULzhEQ2FWSXlBNDJSZlU3NkRlaUVGZW1p?=
 =?utf-8?B?OGU5SHNyWXYwVHVRaDV4djdUVlIwMkxEd2tTdjhCeStNWW02Z3JWMjN4Sm8v?=
 =?utf-8?B?UG9rNWRReEhvd2VoSFdFMVRqSjN0YkFvb2lkTmFyV1hhb1NFRE1adFNiVHk1?=
 =?utf-8?B?bjdXbXB3Nkw5N0dIM2ZDZTRsY0RCRk45K2NPSkFmS095MzN5L1hPOEVSY1pC?=
 =?utf-8?B?YjZRclVQWFRQZ2JNb0xDS253MnNjR21nVmI1K3BMNm8rM1lRbkw2bHFGK2lV?=
 =?utf-8?B?dFJOM2RrUVBJOGNIeE0xUFk0L0JEK3B0YjIvL0hYbEN1d2NFT2F0MnBPeUVl?=
 =?utf-8?B?Z3VMWVpjK3g0eUFrMFhmWktrY3orcXBHUFZSS2JhMkc4RGNSRUlPcDJQYkdW?=
 =?utf-8?B?UFJ3NitpMzhXckpYVU9hMzZvMFBUd0NaV3ltdzF1WW4vbUIwVUV2UE9uU0s2?=
 =?utf-8?B?ckF3TUFoY2FTNDdLN0Y2cUxzbUhPM3I5YTJzT2xwVWxmdmFJSkp1R3VveGtN?=
 =?utf-8?B?SVZEcUthOUpkQWxWR09USEZnM0Vzb1YxWmlnbkx2N01wdWJRc0xJK2NtbHlW?=
 =?utf-8?B?aEhlZGhVL1Ayejk3QmZRZW9oak5BTGh2THBCMFBKQTQwQitYNGlWRkxmazVM?=
 =?utf-8?B?QUJRVk9VMWJsVmF4US9hNEU3VDhpcGIzWGVBZlFuMExseHNlb0R4a054OUxL?=
 =?utf-8?B?RitxcWZXeTBlMWZueVp4MVgvQlhkc3pDQ1RnMmlvRTNBYnpGUzVHaHhmSnQr?=
 =?utf-8?B?T1RRa1BLbTQwdURBeHJYSWkzUkZvK2NXeWhIU0poVEQwbWpHSmNpU0VVWURM?=
 =?utf-8?B?cnRlbTZwcVZHS2FJdXNkVjFITjFacGVXY2NmL0V2Q0Z6WHhsaEcrVVc3ZlVC?=
 =?utf-8?B?RGtGVlNsWVQ4TVN4WFJETnBvdGJ2eXNjN0ZUclZFM05aaXdNMmxUbktZbFRO?=
 =?utf-8?B?M1pJSkNhaEZOdEF4enFJYktWY1VEZmwzVUdKSHc0d2ltVHVPb0NKK1pyTkdD?=
 =?utf-8?B?TzA3ZUt5VmtKUkplRVdmWHk2eitYYytRYisraDdHUytSYXcyeHRXclBQMTVs?=
 =?utf-8?B?dEI5MEk4bGVWYXp2bFVBMkNablEzSURoZVZ5ZjNXdkZmZkUzbG9wQ1NjcWJ6?=
 =?utf-8?B?bExYaDEzTk1DSGgwTFFWbE1oV0NvQmhSL3R5RWZTT2p4SmI5RFZGbkxRZThX?=
 =?utf-8?B?YUhlT2NJb2c3UTFjWjd3bzdVenl0MzVnQlRBSzI1dm5oU1gzSUtpM1JmVEhu?=
 =?utf-8?B?WDBEWFB0NDE1RTkrZGo5NWRuUS9uNm9qVnVoMHBIMXcrSFBINU1lWEpYcjRU?=
 =?utf-8?B?bFRYekdOYzBiZEZkSGEwV2czTDJaU2VpeVYwWnBQZnBsTXBrMUZlbm9Wbk14?=
 =?utf-8?B?QWVReG9zeGFQalRVNmc2Vy9wMjFKNm9tY0FIZ1Z0SzI2cUE2NmE0aGM2TUFC?=
 =?utf-8?B?VDBubjVRRG5EN09ZTHZPU1VDam80cmVQcExxbGdTRXllNzNVTjA1V0ptMjBB?=
 =?utf-8?B?Z0d2bVVjNFFBRTZFSFNlVzlhcisxYXZZR21renNKWGtMOXBDOHpra2E3Z2Fh?=
 =?utf-8?B?WHNZOHBjWFc3cWtXa3MxSGNxNlI1UkVCSUpqNkRSeDh3bkhDMDNBL3RHWlEz?=
 =?utf-8?B?UVNPa1JFMHUwUGR2N1JyRU5XSkNqRjRqcVJtOU5VMWp5NHFRME5SU3Juckhj?=
 =?utf-8?B?RnFMdkFZUzVkTDl0VVJpRzd1bE5wMktPZnNKQ053RktYRHRxbFh2Qm92bEZt?=
 =?utf-8?B?VmNXdjRUL2d1aVM0aDM5SWI3N0ZJSUZIVW5xUFQzekpiVWcyTmxHY21jU0VB?=
 =?utf-8?B?YzJCdFJJYWpKQTFSbTVtaWVBY2dPSWkwK3pTdS9oLys1VG9VMUVMMGdSdEY0?=
 =?utf-8?B?YmpOempPSjNBQWdIRkhFTVlGUHpEV0dXWmVqVFdMRVJIcEdnRy96UFZCRVR2?=
 =?utf-8?B?NFViN3B0dGxuZmt2QndhdVRWQmhDNjhCUXk4QnAySDZLMVB4clRHanRSOGFS?=
 =?utf-8?Q?pNSuI2BMFo91qDWiyZTRjNy3A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fd1ed2-2ff0-4a9e-283a-08de29045869
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:46:17.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rh7iy4iYX1+kRaT0FUkykYhwcIL77a/eRXZgwKPMfBF7azLFHNBG+d54n/NAO6et7SHYWmkM+id5PtRtXVS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768


On 11/21/25 12:06, Jonathan Cameron wrote:
> On Thu, 20 Nov 2025 18:27:50 +0000
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 11/20/25 18:08, Jonathan Cameron wrote:
>>> On Wed, 19 Nov 2025 19:22:14 +0000
>>> alejandro.lucero-palau@amd.com wrote:
>>>   
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> In preparation for always-synchronous memdev attach, refactor memdev
>>>> allocation and fix release bug in devm_cxl_add_memdev() when error after
>>>> a successful allocation.
>>>>
>>>> The diff is busy as this moves cxl_memdev_alloc() down below the definition
>>>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>>>> preclude needing to export more symbols from the cxl_core.
>>>>
>>>> Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")
>>>>   
>>> No line break here. Fixes is part of the tag block and some tools
>>> get grumpy if that isn't contiguous.  That includes a bot that runs
>>> on linux-next.
>>>   
>> OK
>>
>>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> This SOB chain is wrong.  What was Dan's role in this?  As first SOB with no
>>> Co-developed tag he would normally also be the author (From above)
>>
>> The original patch is Dan's work. I did change it.
>>
>>
>>   From the previous revision I asked what I should do and if adding my
>> Signed-off to Dan's one would be enough. Dave's answer was a yes.
>>
>> Someone, likely I, misunderstood something in that exchange.
>>
>>
>> I


Oh, the amend for patch 1 and 2 after the refactoring!


Silly me. I will do so.


Thank you


>>   did add my Signed-off to the patches 1 to 4 along with Dan's ones,
>> what I think it was suggested by Dave as well in another review.
>>
>>
>> Please, tell me what should I do here.
> Change the author to Dan.  IIRC
>
> git commit --amend --author="Dan Williams <dan.j.williams@intel.com>"
>
> should do that for you
>
> Then author and first SoB will be Dan and you will be noting you 'handled'
> the patch. Feel free to add a comment # Changed XYZ
> to your SoB - or if appropriate a co-developed-by for yourself.
>
>
>>
>> Thank you
>>
>>
>>> I'm out of time for today so will leave review for another time. Just flagging
>>> that without these tag chains being correct Dave can't pick this up even
>>> if everything else is good.
>>>   
>>

