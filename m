Return-Path: <netdev+bounces-217154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1010FB37961
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CE2366407
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692D30ACFF;
	Wed, 27 Aug 2025 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="zMAHNIbr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2112.outbound.protection.outlook.com [40.107.102.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F330ACFA;
	Wed, 27 Aug 2025 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270675; cv=fail; b=Lu2glCP9oXtpaMA29dfdFL8z/gT3WRqNdoB17FWufPxG86CVctCVXNr9W30oNGk6jQxi8qxN2YCv98u46YxTXH6QanFLr7M3EJXnq1rWnogLtN1QyCtyYi20W6xgWpF2sykpAJyXhN7JWLQCcwk4g5ilVkUADedvVowBK3Hdu/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270675; c=relaxed/simple;
	bh=Nw6bgoE6er2UnDEm7DH4D6axdUR9b0SQRmad5jUx4h8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0mixDZpWkXy8ye6VmUHNrA3OOxSa5Cl8yfD9jqnixWIVLp1pZCrQSFYJjW4JLaBI+6T+e3xIafuzBw0BLnIFG5irCvyTIRg/8LWo89EXIMoJ2A2stupKpurGbPYrzkcTCTTvkOIAEgdsvqCRNUdDi/tCmYJ7nEsGwJqiSY0Ib4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=zMAHNIbr reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.102.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORnB1AQlHyn7hIZJVppHXzCM0+lVlZ9mcjOqWsmSbkwQCtVRJylZRbIYKUbrw2jRQOvnQ3KUfgJkBd5dZH2xA48wj3VQNCmb3jNmQ+J2d97xT5hCrPezm78NvaC4BSyeK1r6UatU/6XzcJKAfjhjK3S4FtMBWRmZ7iqnoe9qCPKm6x2ASz9BhbHmSsp/HbgxWbmB+mT3KoOfhKhbpz7YQR0re8ye4msmX3zJq9AibpKR384V32Ms4rtjdM2UlV3EHjzxRV9E8y57Ew2FByHQJz+Cos/aJmSnZBPr5qE/4UBPW4mUr/1eeeDWAcX6N90IS8d2UYk86Od5sI6Wc6oUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FKnH/49ujBxC0VSCX8BKKzLlby8TU1RvNaKKIEkA00=;
 b=pxGU91C8K1qTUqB6vXSBuXFgybdYBX9qCnhGpDDs4/ZEn/HMk+cQkG2qd4GynAhA/g7b8PNYu+LBK0FlwX889bHDR89uJBoPPoNIBk+gvKh7HE/k1NT/KKijbMj3CIYpQ5NjfN7HiE5srvTG05LVTuUkncncvBtO4+yboBig6PhMu1NuhkhaI3CtsHpelg46cFLQFgT3RnF3n9cCjjgU6AHK6Ozvrbd9rXBHWLD+5WezmMMUf/2YW8ShZPYhpTNzGRtsnMwok8WMDq8I4edI4J0heuftpucEPM9YiO5LkS4xlbT1baAtDWcc6usrnwWFSp8g1hhNib0FIQCTxbfwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FKnH/49ujBxC0VSCX8BKKzLlby8TU1RvNaKKIEkA00=;
 b=zMAHNIbrGe2Lj1mC62yhpZf6nvyjn9yoD73lGB1BlH8LEJDFXNA6A9vMXDnox9RHmlpYDVt25jYdIHfelpCdIFUy9jNAOuOaqg7IC6Impeujuj1t40VNG3oBqIEVY8xBLHt5EZ30YLwciPBWjQThfub+UgY+00j4QlDj5n+9gso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL3PR01MB6868.prod.exchangelabs.com (2603:10b6:208:353::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.15; Wed, 27 Aug 2025 04:57:50 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 04:57:49 +0000
Message-ID: <496af428-841e-4296-9b53-0dd89d8be655@amperemail.onmicrosoft.com>
Date: Wed, 27 Aug 2025 00:57:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 0/1] MCTP Over PCC Transport
To: admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL3PR01MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e582dc3-7eed-4da8-2965-08dde526459c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDZBM2EreGpYRHEwUElZUjVIa2Y3MVNwb1JZVElkS21FS0s1MVNITXZTakJh?=
 =?utf-8?B?Q3YvZWR2RjF1K0xRZ0FUOC9yR2E1dlExN2ZPZzlGZ1Y0L3o5Q3g3bGNKWFAv?=
 =?utf-8?B?eTA0THJaMS9FbjVjNmlPWU0xNFdlS29LK3k1Sjdqb0Jxa2VlR3MyQ0lvOVFG?=
 =?utf-8?B?TzFibEdCRUNWYWl4RjlYdFpGa3VIdzltSytZNnB5QUxveVkzbHF0ZXEzckl2?=
 =?utf-8?B?cWhOcXYyK3MwTCtHeHNLMkl1aWJnSFBtNXN3REZTQk5NcWltSzZOckF0T0Rm?=
 =?utf-8?B?S2VJWlJwc1lIa3RIVlZxamVReE1DbTdaT2tiL2VROHBaYTVLbUlRZWhaZWMv?=
 =?utf-8?B?djArdUhnZU5uY0JINXFXWGY2YmlLdkdGblBjTzEzT0hXSnBFZTgzN3FaelVZ?=
 =?utf-8?B?OTZzVGtiaTd1Zk9MYW1Gd3lvZldOeElJc3IvNzJqOEJpQ05WMi9sTGlpbktO?=
 =?utf-8?B?TjJTeTh4THVCdkNWQVNudm9McTJ3S0dJeFlnOExGVWFhS2ZhcHpCSUlNeTVj?=
 =?utf-8?B?TmZLNmd5bWNFWDIwU3VmRjBpazdyMlJ4RHNNQmR4ckkycmFaRmZoY3hDa3l5?=
 =?utf-8?B?dlpJZ2pRR2RUY3RLZDVwd1Zia0ZYcG9tVTJldXI5cnUxK2E4NnRTa0pMZWsv?=
 =?utf-8?B?RE5uMGpQUHhHTlV5NzdSOXVjT1l2QUg2dDFRclNFRjJ0WlJjY1U2UVh0dG5H?=
 =?utf-8?B?ZGpJanNhRW1mSlRQeDBSdTFHT2dEZDlRZmhPNjdiSVNHYTRSVEcxYkEvOWV6?=
 =?utf-8?B?dTNoNkRxNHh6S3BTVEhzZXE3RS8wQ2NJb2hpc3hDd1I5Sll4Y0JEdWRoR1F3?=
 =?utf-8?B?aGFIeCtINTJoWFZzUDBDeVB1U21qSTBZYXM5RVBDeVczSGtqR0lKam1rNkVp?=
 =?utf-8?B?WmFDd2RSaG1UcjNVVStPcjBabjFaZTlsUmpubi9ETVJ4bmNPRmxIZSs4L3dn?=
 =?utf-8?B?aEhKaDBpSWVZZ2ZzaWZQczJraUVIMjl4a1hSWlp4RG8zRlhxOW94TG9iQzY1?=
 =?utf-8?B?bUQ5UlAzODE3ZUFQczlwMnVQREhCd3FKMzJ1bnJwaHd3VG1kTnUrZ08wa3ho?=
 =?utf-8?B?OE5lN1g2RkxpcTVFUEg0eUhTT0FxVk1zVXZ6czFDdUVmK1VzL1NNTnA2OUc0?=
 =?utf-8?B?TVp3YkR6RjFjQ0F2OFl0bitQQytLZ2J0aHpiV3N6aEc2Qm9PNEVybitBdG1H?=
 =?utf-8?B?L1ZMVlMxazdOWWtTTmVtUG9TaTd4SVRSTUxWZnRLZ1JEd1lwTnVsa1dLejVk?=
 =?utf-8?B?SitJRXBhbVRQNmtLSk9ETGVrTUxHdXEzRDlNb3g2MlJPNmlNQjM1c3RUcFQ2?=
 =?utf-8?B?U09sd0FxRmFBN3NyKzBHWkpxS1lpYkcydjdvZHBybE1WWDU2ZjdvTko4ak1C?=
 =?utf-8?B?eVZUb0Qyamo3NEcvckwvcno1UnR5SE5EQXJLRWhrQ25xVVZjdHVDdHl5MFN0?=
 =?utf-8?B?NkZIdURGUnFKemg0TDU4L0N2dVFTUklOSnVQOWVkRGdRMGFkd3pKUFJmV09y?=
 =?utf-8?B?TEljcEs4NmN1SEwzTE1BdENDNjVlNGx1TUxWVXBzOE9DakdzK01HV0JWL0Fn?=
 =?utf-8?B?VDBtNlk4WUUzNTdNQ2NyUmpDTlZ3OXpiays2c2t0Yk40cm5KMlFZQWhVbmxO?=
 =?utf-8?B?cnFVK2lMUHJlWGZ6UEFxN3h0RkFRTVYzMytJNUZkOHFHVE1ocndFL1ZNSW9w?=
 =?utf-8?B?SW1lcHpQc0Zad1NHUEJ1M1JXQ09WZ0NYTStFbnNZQnhmYWRWQXMrMVNlK0Fm?=
 =?utf-8?B?L3pkU3FweEFuaEtuU3NISzhDWDZUWEhNSjB6UlcrT2JOUzdaWHBqM3RrT2pJ?=
 =?utf-8?B?ZlFkR0lNQXZlUWd6TmY0d2I3U1ZSR3FhVnBvS2NuQkJwUWRueTk0MTJKc1B5?=
 =?utf-8?B?Z2s5SWxtbXRmTzR1eWlPM1VjSjFkRnFBRkdFUzRCbm5GU0xQa2diZmNXTDJR?=
 =?utf-8?Q?D+VePyTCLIM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVKZHJSK0tsbkR2Zk9DNDRlYkZWYW16QzFRd2VEcnp0SURiYlhJbHhOMUJP?=
 =?utf-8?B?a1NISE9pZnJWb0VwaXFSdmdBK2YvTERhb1I0MFpqZVJFNGRhR1pmMkF3c0RH?=
 =?utf-8?B?SlVLcUZML0t3WHJZMk1TdGRUeU1Cc3NXY1lYcjBMaFdZL05nb3lISXZqR0NS?=
 =?utf-8?B?MVBpakwzeXVuK3dURlVEZjZjMVRrQ3p1Ny9BWnBLL2FkWlJyMU9ZY2lRZjlz?=
 =?utf-8?B?SVNrRDV5U3lUeHZZWTFDQTVDUldxa3ArV2RLVEZuUnFTS0JEQjZJVkNuUmlW?=
 =?utf-8?B?TGJYMUtRUmd0RXpGWW0vVHVtWFdRN0FCemI4dFpzSzliYzQwS29yNWV3ZElZ?=
 =?utf-8?B?RVhxU2N3S2ZYRW10QzdsZ21rV2E0VjMwYUUxYXM1OXNYSlNYbmh6eCtsdUNo?=
 =?utf-8?B?Q0xDM0pEWkVPUkUzM01WcVk5UjQ4by92NW40UXVpY1Y5SGlNY0NkVVc0Uzk1?=
 =?utf-8?B?ZHpxRHd2a3YwMHk0NnFmbGJqRWs2dlBIaER2bUwzbFNpaXhCQ1k2bk9kR2g2?=
 =?utf-8?B?MFJ4TFNyMmpZQTl3RUhOcDR3Y1Fhb29yYmNrK2g5bVY1L3dtTFdyT3FnVmtk?=
 =?utf-8?B?YnhNMStaZkdkbm5IbEpGYnljSUZHelJoV202eW54cHdGT2lkbjlSZEZtN3A5?=
 =?utf-8?B?cSt0Njg2KzUvSlJwL2R1WlVrMEhYekJSU1M5ejBBU25xdFFubXFNQUd0TC9v?=
 =?utf-8?B?Zy9tRXBKWjQwNXJZODEwM3RJZmdrMFFHTURocEl1WkRNQVdxaU1UN0c5L2xy?=
 =?utf-8?B?bFk1L1k1K3lYRUFnRDVUanpFYnpGdzgvWlNqNGgrUlgrbHo4SjJBTHp2aVJY?=
 =?utf-8?B?UGdhZEVoL0Z5U1FRd3JLMHpNeVVuTkxZajZzWDlyK3dCOHJjd25aM0RqTlA5?=
 =?utf-8?B?V1pBL1RlUXZnYnVMaGFUSmVKcGtmWlRueXBpdVgxekVCSTNUTS9nMU1Kb2V3?=
 =?utf-8?B?VTFSMmNKZkc2M1MzeXhmemlET2ZjZmNwQ2JiZmhxQmVQaTFKM3UzdU9mK2kx?=
 =?utf-8?B?OXlKaG81UkZOOENVdEh0VkFHWDlVR0l3WXN1OGZPSkNuZVRpdHZLT2RxNjd6?=
 =?utf-8?B?ZWZqSlF0TTErRHZoaDlncU5tK084UEV1QWtnM1Z0V2tFVGhYK0xEZXVWQ3VT?=
 =?utf-8?B?VnhRMXFKcEZFYXQyRXRkVFdzSEV0a0lxZ3pleHBrdHRsVklUSmFGdHpoVFY3?=
 =?utf-8?B?Wk1pVGNpN1l5cXJCemdVOUNaa2FpclBNY3VqRy9MTFp3TFRMQzhnYzhzNnBL?=
 =?utf-8?B?V0tPY2F1bzl0SVBQTXJNZUI0eXNrRkJrOUpLNjZIYWMyS1k2MWdSeTVkVXdJ?=
 =?utf-8?B?enNUemNmZXAzNXp3aWt6K290MjZyNW9ONW45ZHlQTGZxS0d0dTFvOGdIYm1q?=
 =?utf-8?B?OWxRc1ZXZUdoLzFFQlV6SHQ5SVpMaWdvQUVabkNuaHB6emxmakhoYkhISTBY?=
 =?utf-8?B?VHpxRTR5ZjZnSXlMaWwzWGV4UjZ2RXpNZFkyOVUwMU8vYlhrV0l0eEdJdjc5?=
 =?utf-8?B?OW9KY2RDdnNzY2tHbDJXdm11UHVDSzVwSnFBdGRoSEU4cDg4WGdsc3lPTVQz?=
 =?utf-8?B?Tk1FVEFWRE1MbkxlTWhSZldxMUtPRnpCTW1wdnEzVGVjRHRKTHJYNkl6VG80?=
 =?utf-8?B?YnRyZ1BaTWF0Rm5yWFIrQVJ3OEc1SDRySHFnV2psTGdVeDFncnhWUGxDS1M4?=
 =?utf-8?B?S1F5UzZPVHUyZmJQaWlSZ2dsWlRTTFphV3Z2dlJNcHQxUnNYTjlYNUQ1SDNv?=
 =?utf-8?B?bHdKVUd5ZUt6MHI2YmM2RzEzMDRqOENybmZUYldmcWpZY1o5ZktMbkk1NGhQ?=
 =?utf-8?B?amI2SlNpTXdTL1NkUXZxWmIxajNYaU1iODRqLysrWE9XOWNzQUp3VTViK3A1?=
 =?utf-8?B?Yk80RE0xVWY4SkR4RkNoZytzNEY1eXVhMXMrTXM2OWYzWUxBd2xDTFFsVEhv?=
 =?utf-8?B?MCtPU0h2Wjd5WW5zeHdiMWMzNHc1YWlabW52V0pMTXVpdi9XOUZoZFQ2VDBX?=
 =?utf-8?B?NjhIcFZ6NFdWUjRHVitHN25nSG9YR3Z4Uk9WaW56RG1Oamd0ZlFpaUZKOXRW?=
 =?utf-8?B?OWFhK3BHMnNUa2h0dkNaa1hoSDZDTjBqaGdibzhqaFB2NXp0OVI0cUs2UFpo?=
 =?utf-8?B?emIzUHBaa1ppSHEyQ3Q3NThBbytONVRVMCt5SjRFLzA0SXZsMjV3UnNNNVYz?=
 =?utf-8?B?OW5vRHV4SWdmZ2F2K0tXNDJLcmRGdEF5bDNNeU5rTnBhMjlPcXF4c3QySE9U?=
 =?utf-8?Q?YE/KiGVSJFJAyVl7joM0K0k5GRPOd+0lbCaDtUjyx8=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e582dc3-7eed-4da8-2965-08dde526459c
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:57:49.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbrqPHLpHiQDncTGvUz6R47m7latJqI0ztQBw08p8nIzDv4/cvZd+zI9FmFm72bERP089DGay3xQ1CY1AwZdxbCS0qVL6hJ+c3fg+XiQ4xHof4DPaXKiUc4VpkTEfZrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6868

Apologies for misnumbering this. It is V26 not V25.  I can resend if 
that is appropriate.


On 8/27/25 00:48, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
>
> This series adds support for the Management Control Transport Protocol (MCTP)
> over the Platform Communication Channel (PCC) mechanism.
>
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>
> MCTP defines a communication model intended to
> facilitate communication between Management controllers
> and other management controllers, and between Management
> controllers and management devices
>
> PCC is a mechanism for communication between components within
> the  Platform.  It is a composed of shared memory regions,
> interrupt registers, and status registers.
>
> The MCTP over PCC driver makes use of two PCC channels. For
> sending messages, it uses a Type 3 channel, and for receiving
> messages it uses the paired Type 4 channel.  The device
> and corresponding channels are specified via ACPI.
>
> The first patch in the series implements a mechanism to allow the driver
> to indicate whether an ACK should be sent back to the caller
> after processing the interrupt.  This is an optional feature in
> the PCC code, but has been made explicitly required in another driver.
> The implementation here maintains the backwards compatibility of that
> driver.
>
> MCTP is a general purpose  protocol so  it would  be impossible to enumerate
> all the use cases, but some of the ones that are most topical are attestation
> and RAS support.  There are a handful of protocols built on top of MCTP, to
> include PLDM and SPDM, both specified by the DMTF.
>
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd
>
> SPDM entails various usages, including device identity collection, device
> authentication, measurement collection, and device secure session establishment.
>
> PLDM is more likely to be used  for hardware support: temperature, voltage, or
> fan sensor control.
>
> At least two companies have devices that can make use of the mechanism. One is
> Ampere Computing, my employer.
>
> The mechanism it uses is called Platform Communication Channels is part of the
> ACPI spec: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
>
> Since it is a socket interface, the system administrator also has  the ability
> to ignore an MCTP link that they do not want to enable.  This link would be visible
> to the end user, but would not be usable.
>
> If MCTP support is disabled in the Kernel, this driver would also be disabled.
>
> PCC is based on a shared buffer and a set of I/O mapped memory locations that the
> Spec calls registers.  This mechanism exists regardless of the existence of the
> driver. Thus, if the user has the ability to map these  physical location to
> virtual locations, they have the ability to drive the hardware.  Thus, there
> is a security aspect to this mechanism that extends beyond the responsibilities
> of the operating system.
>
> If the hardware does not expose the PCC in the ACPI table, this device will never
> be enabled.  Thus it is only an issue on hard that does support PCC.  In that case,
> it is up to the remote controller to sanitize communication; MCTP will be exposed
> as a socket interface, and userland can send any crafted packet it wants.  It would
> thus also be incumbent on the hardware manufacturer to allow the end user to disable
> MCTP over PCC communication if they did not want to expose it.
>
> Previous implementations of the pcc version of the mailbox protocol assumed the
> driver was directly managing the shared memory region.  This lead to duplicated
> code and missed steps of the PCC protocol. The first patch in this series makes
> it possible for mailbox/pcc to manage the writing of the buffer prior to sending
> messages.  It also fixes the notification of message transmission completion.
>
> Previous Version:
> https://lore.kernel.org/lkml/20250819205159.347561-1-admiyo@os.amperecomputing.com/
>
> Changes in V26:
> -  Remove the addition net-device spinlock and use the spinlock already present in skb lists
> -  Use temporary variables to check for success finding the skb in the lists
> -  Remove comment that is no longer relevant
>
> Changes in V25:
> - Use spin lock to control access to queues of sk_buffs
> - removed unused constants
> - added ndo_open and ndo_stop functions.  These two functions do
>    channel creation and cleanup, to remove packets from the mailbox.
>    They do queue cleanup as well.
> - No longer cleans up the channel from the device.
>
> Changes in V24:
> - Removed endianess for PCC header values
> - Kept Column width to under 80 chars
> - Typo in commit message
> - Prereqisite patch for PCC buffer management was merged late in 6.17.
>    See "mailbox/pcc: support mailbox management of the shared buffer"
>
> Changes in V23:
> - Trigger for direct management of shared buffer based on flag in pcc channel
> - Only initialize rx_alloc for inbox, not outbox.
> - Read value for requested IRQ flag out of channel's current_req
> - unqueue an sk_buff that failed to send
> - Move error handling for skb resize error inline instead of goto
>
> Changes in V22:
> - Direct management of the shared buffer in the mailbox layer.
> - Proper checking of command complete flag prior to writing to the buffer.
>
> Changes in V21:
> - Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
> - Check return code on call to send_data and drop packet if failed
> - use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
> - simplify check for ares->type != PCC_DWORD_TYPE
> - simply return result devm_add_action_or_reset
> - reduce initializer for  mctp_pcc_lookup_context context = {};
> - move initialization of mbox dev into mctp_pcc_initialize_mailbox
> - minor spacing changes
>
> Changes in V20:
> - corrected typo in RFC version
> - removed spurious space
> - tx spin lock only controls access to shared memory buffer
> - tx spin lock not eheld on error condition
> - tx returns OK if skb can't be expanded
>
> Changes in V19:
> - Rebased on changes to PCC mailbox handling
> - checks for cloned SKB prior to transmission
> - converted doulbe slash comments to C comments
>
> Changes in V18:
> - Added Acked-By
> - Fix minor spacing issue
>
> Changes in V17:
> - No new changes. Rebased on net-next post 6.13 release.
>
> Changes in V16:
> - do not duplicate cleanup after devm_add_action_or_reset calls
>
> Changes in V15:
> - corrected indentation formatting error
> - Corrected TABS issue in MAINTAINER entry
>
> Changes in V14:
> - Do not attempt to unregister a netdev that is never registered
> - Added MAINTAINER entry
>
> Changes in V13:
> - Explicitly Convert PCC header from little endian to machine native
>
> Changes in V12:
> - Explicitly use little endian conversion for PCC header signature
> - Builds clean with make C=1
>
> Changes in V11:
> - Explicitly use little endian types for PCC header
>
> Changes in V11:
> - Switch Big Endian data types to machine local for PCC header
> - use mctp specific function for registering netdev
>
> Changes in V10:
> - sync with net-next branch
> - use dstats helper functions
> - remove duplicate drop stat
> - remove more double spaces
>
> Changes in V9:
> - Prerequisite patch for PCC mailbox has been merged
> - Stats collection now use helper functions
> - many double spaces reduced to single
>
> Changes in V8:
> - change 0 to NULL for pointer check of shmem
> - add semi for static version of pcc_mbox_ioremap
> - convert pcc_mbox_ioremap function to static inline when client code is not being built
> - remove shmem comment from struct pcc_chan_info descriptor
> - copy rx_dropped in mctp_pcc_net_stats
> - removed trailing newline on error message
> - removed double space in dev_dbg string
> - use big endian for header members
> - Fix use full spec ID in description
> - Fix typo in file description
> - Form the complete outbound message in the sk_buff
>
> Changes in V7:
> - Removed the Hardware address as specification is not published.
> - Map the shared buffer in the mailbox and share the mapped region with the driver
> - Use the sk_buff memory to prepare the message before copying to shared region
>
> Changes in V6:
> - Removed patch for ACPICA code that has merged
> - Includes the hardware address in the network device
> - Converted all device resources to devm resources
> - Removed mctp_pcc_driver_remove function
> - uses acpi_driver_module for initialization
> - created helper structure for in and out mailboxes
> - Consolidated code for initializing mailboxes in the add_device function
> - Added specification references
> - Removed duplicate constant PCC_ACK_FLAG_MASK
> - Use the MCTP_SIGNATURE_LENGTH define
> - made naming of header structs consistent
> - use sizeof local variables for offset calculations
> - prefix structure name to avoid potential clash
> - removed unnecessary null initialization from acpi_device_id
>
> Changes in V5
> - Removed Owner field from ACPI module declaration
> - removed unused next field from struct mctp_pcc_ndev
> - Corrected logic reading  RX ACK flag.
> - Added comment for struct pcc_chan_info field shmem_base_addr
> - check against current mtu instead of max mtu for packet length\
> - removed unnecessary lookups of pnd->mdev.dev
>
> Changes in V4
> - Read flags out of shared buffer to trigger ACK for Type 4 RX
> - Remove list of netdevs and cleanup from devices only
> - tag PCCT protocol headers as little endian
> - Remove unused constants
>
> Changes in V3
> - removed unused header
> - removed spurious space
> - removed spurious semis after functiomns
> - removed null assignment for init
> - remove redundant set of device on skb
> - tabify constant declarations
> - added  rtnl_link_stats64 function
> - set MTU to minimum to start
> - clean up logic on driver removal
> - remove cast on void * assignment
> - call cleanup function directly
> - check received length before allocating skb
> - introduce symbolic constatn for ACK FLAG MASK
> - symbolic constant for PCC header flag.
> - Add namespace ID to PCC magic
> - replaced readls with copy from io of PCC header
> - replaced custom modules init and cleanup with ACPI version
>
> Changes in V2
>
> - All Variable Declarations are in reverse Xmass Tree Format
> - All Checkpatch Warnings Are Fixed
> - Removed Dead code
> - Added packet tx/rx stats
> - Removed network physical address.  This is still in
>    disucssion in the spec, and will be added once there
>    is consensus. The protocol can be used with out it.
>    This also lead to the removal of the Big Endian
>    conversions.
> - Avoided using non volatile pointers in copy to and from io space
> - Reorderd the patches to put the ACK check for the PCC Mailbox
>    as a pre-requisite.  The corresponding change for the MCTP
>    driver has been inlined in the main patch.
> - Replaced magic numbers with constants, fixed typos, and other
>    minor changes from code review.
>
> Adam Young (1):
>    mctp pcc: Implement MCTP over PCC Transport
>
>   MAINTAINERS                 |   5 +
>   drivers/net/mctp/Kconfig    |  13 ++
>   drivers/net/mctp/Makefile   |   1 +
>   drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 386 insertions(+)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>

