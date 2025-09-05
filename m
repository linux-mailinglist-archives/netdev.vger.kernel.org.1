Return-Path: <netdev+bounces-220414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E4B45F71
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2B41CC11B7
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787CF309EF6;
	Fri,  5 Sep 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="54U6DUFz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77007271476;
	Fri,  5 Sep 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091484; cv=fail; b=ZVkuhnb0/64fJjwRcKX/dIXw4PHW7hiK568sJmqAwO5Cp7uzMVIcn1k3CKNrfUJmLc92zv0kuJx9JoD4t0LF+KEvyLKHUHzjNhaQ5KpEn8I1grCCnY6rWJXiqEVkl83jdTlyqJ1DarVvsonYlOpvmDi6kwKD+QPZquI+1roXr18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091484; c=relaxed/simple;
	bh=IYjgt16nUuN7W3pu5qzsxKgjj0HjHQXI7T/UKEhgx4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Emvg0C05eUVRU50hHACcEB1xqaIP39vyKmZHd/MiNhsDxPXLEuFHa78iZYQYsDlMzUnXnwqVxw66Vc2koMcVBWFvlYVm4g8YJyzZjVlFHwE/PfGRoFPFHYKvz3f7PslmgPCs3J7j1qDLGyuBfFf6Nk/IajcLOdhHIh83U2uGsLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=54U6DUFz reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.223.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4sMBQHQc5i1XTJeSJRnR3ZQgVtSv6D1+WI1BCPbWLiQPLJwDqR+zjvgcZb6ZBCIKJzMnOtukg26chmYzwADlpo3xKmb4FvjI592YjvhU4CwgPA5z8NOgJsheIY/aim2q30FGDSYK6rXiVNV3RFOKY7AF0GCA+KG8aq/iQtgsvW6ptQeiRLI7bABDly2dHl+EEKzhMMZU2Hgu1387c1RkSRdlaHS+WHxHjHZ3EiXAIodB+W52ezgTgiILU0Rk5jqbpo1Kb1BLc55wCZSbyPZwEAU2gH+DTmmDhSb4Fwi1YPCOsqZmPUDJZKW/CpNIudeMwnwKn4Fe33Vjqv9xOAf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbgvToigl9Pjc5/N7WlPkF6bv23WrCK7ZZg6adoevcA=;
 b=BzZ1WzEq2O0Jx/ocpcbClgrfXk4o5PYl8/Ch/IVzSELYQXc7fOK8SH33xX9/nBlOCm8m4+aYn1iBCg5O2hOmnLFYzAlvg/GH5qTFzyQIaYZguct8bcGt0nade/TrGBB7uHVclE11mChEyO0WqE9eKPBR1j10rsOAyNHpwhQ/NuQmDbLchu6+VULOye0yGGXsHDS8AxT0B3X1TvotegvNbtZGm9cxXfu0Ze4j5W0cOMw4H8uBzz1pP0zqVrusc50nGoAnMDqa2zhDyaKWmf1ujc4E0y8Mx1j41+rZ2T1+Pvje38P3eolvFAJkEFfFilxjsI4W931pZIvKjg17G5j9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbgvToigl9Pjc5/N7WlPkF6bv23WrCK7ZZg6adoevcA=;
 b=54U6DUFzOP9ZiSDA51E+c1tt+zlWTRC/6fuKOmIlsDcZAft2/aMu8tOO9q1fN3lWvkqqYqVySS09ULm3M3lmY7n4UQkkFb6PzMLT0s8+N17nAm7OOa0SGojOtyEWL1ciy0A+rAUsKNENOyb1p4EaFV7vLq2oyIdB2NvMINiJZIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL4PR01MB9367.prod.exchangelabs.com (2603:10b6:208:58f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.14; Fri, 5 Sep 2025 16:57:59 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 16:57:59 +0000
Message-ID: <b7808a42-aa11-45d5-8c8b-b8ec4fd81b1f@amperemail.onmicrosoft.com>
Date: Fri, 5 Sep 2025 12:57:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: admiyo@os.amperecomputing.com, Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
 <2456ece8-0490-4d57-b882-6d4646edc86d@amperemail.onmicrosoft.com>
 <20250905-speedy-giga-puma-1fede6@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250905-speedy-giga-puma-1fede6@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:36e::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL4PR01MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: 3449989e-11b9-402f-2507-08ddec9d5e49
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXA4c2t1WWtVTTVTU3U4dFJXTmN2NjMwaE43OUJQVnZGc0V1clo2aEdocDdZ?=
 =?utf-8?B?WHY5T2R4aU1ObGxVV0R5NEpsZUVic3ZIV3haM2kxckRCSFl5cnVOK0JMTnlu?=
 =?utf-8?B?eEYwZHZMUzdqZXppZk03NXpDVEl1bW5VQnp0TnBRdE81dC9VUUt5UE1zdDl0?=
 =?utf-8?B?NmozY3RzRCtIcGN0UnNmZGFUeUp2c1MzRTBYRnM4NkpCcVZXOXYvZHNCdUwr?=
 =?utf-8?B?SmJaODhYb0h3VGpRTDdWcHFqdjVCSHRCdllvR1BWejV1N0ZzbGlwVnJxL000?=
 =?utf-8?B?RVEzYldidVRWc1pONGc2LzBlVnNzYi9rMjdNaHBLTkkzMFZSVzNtZ3I2OVlt?=
 =?utf-8?B?RHNSN3ZBUXRid0tVcVZpS1MwY25JSDc0TVBZdVc3UUxldnV1MEdrNXFNMlBs?=
 =?utf-8?B?UysxYnNSdER4SFl5Q2o2VlI2MmxsK25nZE4zUHBZQzhSOUtnSEF5bjdYS1RG?=
 =?utf-8?B?MExsaWZINTFid00xT3FkdjgrK2cwSW5VVkdHZ3NWczh4LzllS1dHcytPUU50?=
 =?utf-8?B?d1RORlRCZWEweFVHak0zNlN0QnMvRklOWkRtSi9SM2RJZUlQQ09PTmllQkJ2?=
 =?utf-8?B?M2ZlVDlJNEcydU1DSUNVeENMM0xMVUpJalNOTExuVTEydTk4ZG8yc0wrWHJZ?=
 =?utf-8?B?U2RXM1VOS3M1MSsrTE96TWYvSFVvNW10dDlidFJvZU1tYTZYNWRCak14RUZv?=
 =?utf-8?B?SDE0T3ZvaC9GU1NDOURPWHBRVjlVdTBMWjMycXlTcVhSeVNXQjh2dld0cDdq?=
 =?utf-8?B?Y1pZMFROTllIZzFGYzhnVzVpeU04TG1ydXBQRlhTemtWMEFORE9IZFY2VVEv?=
 =?utf-8?B?SFdpMDNQYVFiTEhXV1plNVBOVkNhVmRyRWtyZjNHMExza3N3eWNiMHpEUWla?=
 =?utf-8?B?TlUvM25QRkkwVDE4ajMrNHRZdmxYZDd3a2JiUm1tSDBTTitRcDRWK2l5Uk9W?=
 =?utf-8?B?dXBnb3JOZGwveXFpM0txM2tLTk42M0hzL3Q5Nlk2czRsZjhKSXdWazZWZmFO?=
 =?utf-8?B?L1l1L0JPSVh2RlljbUtoeXN3M1U3UUo4RVBhV3pnd2w3c3RBNWRkNGFoSGQw?=
 =?utf-8?B?V2tGVytzMHhFdVdES0puQjlRL0JwUHMvVDBiMUNjcEVaRjlPMkpZc3BkRGhG?=
 =?utf-8?B?d05KWXA5TGRpUE5rc2FkSVRRaHF1bFRvS2lYam1DZ09SNjBVYWE3aURyRkJo?=
 =?utf-8?B?dllvYU52U2ExamY5TlV4RENnVjV0NmRwVm9VcXViVC82RDNxNmRCMWE5MWNs?=
 =?utf-8?B?bjRuRGRhTldUK1hpYnRoSThUUTB1bHJNS09LTlhBSUNUb3JidlBSeEFUYVRD?=
 =?utf-8?B?dUFFZ0ttRCtZRlMxTHN2RDhOa0VPVVowMXJkMVFjRWdDYTNCc1V0QWlnMGw3?=
 =?utf-8?B?aElCUTBpSVc1dzNCZGtzUDJWRU1oREthRXJTVFA5S3h5UDJsdnJ4Tm0xYThG?=
 =?utf-8?B?M0IxQkw5Umwxa3hWVGd0dGJqY0dmejV2ZTlwWnZlOEFlMk5GWE15Z2dTM25L?=
 =?utf-8?B?YkYyMW1MNWF3WldHbkszQWtDQmszaDVKR1RaeHkvRHVCa25tdWY3L2tOM2xP?=
 =?utf-8?B?SmcwcEFlUitNRlYrdjJRZFZjaHhwektHbXhpem5YRWRVWXEzOThHVGJ5dDc5?=
 =?utf-8?B?eWtUQUdJVFNjV1I0OW94S2dkbGFtS0pGdG5JcGRKSFA2cC8wd0tnN1k3TURE?=
 =?utf-8?B?Vksrc01Yc2pUay9NOUpkQ3oxUDAyc1NUWWlaeUN2NDZYcTBycjFxbWxVYWJL?=
 =?utf-8?B?c2YzaEZOZWF5YlN5NG5uYXdZbXpIQkRlbm8zL09KMjB3ckV2ejJhdmpSUzZD?=
 =?utf-8?B?bWNZZzEvS0EySGVnOE9IbEg4YnZXdkxlNjFudUNEZWFYYUlDR0tFRWhIU2hU?=
 =?utf-8?B?V1ZsZ0NQOTVTMjJzeU9mOVpNMEM0UnBsWkdWdDY1QWYxdGRzVFlZanRTQXJG?=
 =?utf-8?Q?ATR9HlA8pBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1VsdEJjcUlxS09JZDNQTEZCekpuNVM1ank3Y2hhMjJRaFU4d1NiVnMvcWdI?=
 =?utf-8?B?eStYWHJFRUJJcGpJbUt0dVZEZGJMbUFFNHRKdzJYTFY1Sysrc2VKMXd5dlJS?=
 =?utf-8?B?cVpjMkpnWXZUZVR1a1c2cmwyZTNWaFR2eVBUYndER01CSHpHNUpXWnJkMG9J?=
 =?utf-8?B?dDJuTysyanZNQ00xUzlKVithcDdIc1A0TUZ3UWRYR3RXajIrNDhQejl4NDlQ?=
 =?utf-8?B?MTZSUndmb2hueFRNcWs3eFFOSjhXWjhoelM0cFJwZTFNZEgzMTVHMkUveHNi?=
 =?utf-8?B?eTh1VktWclJreW0xUU1lS0kwdmM2VG12NHdOYm9BT3p4eXlaS1NDQmxsSU0v?=
 =?utf-8?B?ekxtVlVzS054SmV6eGhtOXp6bzNQUWd4bDhIWkxsb2NiNi9hdUJnNExsTXB6?=
 =?utf-8?B?Q1R6N1U4M1ZQT3NSYzA4OFVRQ1dYNXBibnY4Uk5ld0pNL3RXeDVZYzFHSits?=
 =?utf-8?B?MVhiZ1A1M0xnWDdMMXRUNzdISlVHdy8yQzVRTmVEbWpjblFuWi9BKzV4VkZi?=
 =?utf-8?B?dkVabThCbkNvNHJOMGtzSXlPaXFjSUJkdXBvZXdTcUg3TXlBbEJLa3dTeUxF?=
 =?utf-8?B?WHJxaS9yYldMa2hLU29xRkh1aE1VdFQraEN2YVkyc0Z4cDJQZ0l2aGgwMm1l?=
 =?utf-8?B?Mm9WSm1sQWh0dmY1ZzdQQTFWV2NYSGNVWXpFRzAyZnh2amhqbzk2M29xSFdT?=
 =?utf-8?B?M1FENDRlQWE2OUNmR29yaWo3YWtJcGRmZW00c2pXck4ybmRIbWpsK1FmRWVu?=
 =?utf-8?B?M1FkUTR0ckczWFZjTmVUUnVBNkd1b3FabUNQTjFkMURtSXUxYUpaUDkvUzhH?=
 =?utf-8?B?OVAzNDFwMk5lckxCNE9WMEt4TE52a1V4OGVkUlh3SDhvdVJMRUMxRHJmVXRK?=
 =?utf-8?B?L25HSkY3Zld1UWJreTZGSU01YlA0UkJHK1RqQ0dzQVo4RC9YdjE2cG5vRUkv?=
 =?utf-8?B?cW5LRVlmaDhNQWI2MWVJUThEK1N0d3pPam1IQWdFK1NPNlpMdVkxQXdtaWhh?=
 =?utf-8?B?LzdoeWVtRjlHeVZ6aFQ4aU1XSDN5QWFpVHNtaTNOeTR4ekZOTTlOU0ozNzFj?=
 =?utf-8?B?VUUwRXJlRC9QL0t4Z1ZmZldWNWlxK0Y5OG8zNGY2YUJOTjB0bjFOTVNGNXpy?=
 =?utf-8?B?QkRzZ1pGYjlLN1hCSXd2dkdqaVdQclVza09lU09uSjdzeGxUSzhaM3BGTW8y?=
 =?utf-8?B?SVdKTFNJWElBdUt5b293VG52MXBnaENObDYyMXg4ZHNxSzFSU2tVbHhMaldn?=
 =?utf-8?B?UlBzMUJCWVlhQmRTUzAzMnVUZ3NEb2cydGRHc3dFNUlwK2xUZ0I2VGtMNjRr?=
 =?utf-8?B?TG03QkNiRUc2M3JOWUFDY0RIMlFGcThXcHU5aGR5dFNDdHJuTU5uZmhZNkZ2?=
 =?utf-8?B?eVZLdkpPdzFXQm1qaVhhaVF6YWRsSm8vdzRwQVlPTlkwUGhEZW9yaUNYQlhS?=
 =?utf-8?B?a3kyaXhCL3U4bm9FeTNPZzNaN25MY2dFRkxQVFFQZFR5dGYzWkxWQ2ZJSDZZ?=
 =?utf-8?B?eTlLY2lDWU5lb3FRdWtvWVgzYzZNbE9wVjVFWE04RW5HNlBrSXo1elZMcHI2?=
 =?utf-8?B?aVByUEgwYjRkRllYdFpoT2plMWJEYnl2b2JvMkNBeGRRY2YwUlNhcDZITmFU?=
 =?utf-8?B?ZXcrbE9iT2hMUUdKWmF0d25nZzd2Mnp4UXRhbTFFSkhzWm9wY2dOa00xa0R5?=
 =?utf-8?B?QU5ROTVLRWUyS1hqSTNXZ0poS2szMFhkZFplN0pwbk5zRUVJSmJoZ3JGOGoz?=
 =?utf-8?B?S0RTUW05YXVYRkwvcS9OQ2NuVmlSRUpjVUowQmFWY3RaWmQzWDgzd1UzYThi?=
 =?utf-8?B?d3ExOUQvNTcyajVYMWM5THZ1ckxJdG0rYkw0Q283OFhtcjNIOUZaaDVUakdT?=
 =?utf-8?B?SG5RRkJXZ0p0L0hHaDdKREJTZTJrSG1jQW94Zy9xWkxmbm5zTlpweXNmWm1S?=
 =?utf-8?B?bGhTWTN1Tm9wc2QxU1dGdThWcndXT1Q2UGp6N0s4NXhRSk10MkNGZVJXblNs?=
 =?utf-8?B?UERTK0U1RkMrK3pCcExDeWduaXdveURpNkVZK0F1VEFQQ0pJVVhFbXpBZXQv?=
 =?utf-8?B?WWlONEFuSUVXNmRWQUQ1amM1cExpL1hyUXhSVWtsazJsY0lNMUcxeUdVWk5L?=
 =?utf-8?B?UjE2NGk1NFBlbkp0Ty95d0hvQzUwYTU5VXdFaWtHSkFhR0dtVHpyQW5TVmR4?=
 =?utf-8?B?QVhJSXJubFArOGg3bjZQV0F2S3RwUmUrSksvM0JBNFRYWWd1M3pPYTNuZ2JG?=
 =?utf-8?Q?dGvAXCA22zvCWq+jlmHInwPAoYUjJcDk4fl8NhdkLk=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3449989e-11b9-402f-2507-08ddec9d5e49
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 16:57:59.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Tv4PZ9WI4g62P7aZSm7QaL0pfklxm9gWTKiaoRbL5ulCaEkoXRilEx6vAmEVGxwaj+9mRMQgP5XEwEIR9il4EJYy+ZSPMvITAEC+3VXgkjMJ13JN7HUmsQEYaH41dFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR01MB9367



On 9/5/25 10:37, Sudeep Holla wrote:
> On Thu, Sep 04, 2025 at 01:06:09PM -0400, Adam Young wrote:
>> Answers inline.
>>
>> On 9/4/25 07:00, Sudeep Holla wrote:
> [...]
>
>>> Who will change this value as it is fixed to false always.
>>> That makes the whole pcc_write_to_buffer() reduntant. It must go away.
>>> Also why can't you use tx_prepare callback here. I don't like these changes
>>> at all as I find these redundant. Sorry for not reviewing it in time.
>>> I was totally confused with your versioning and didn't spot the mailbox/pcc
>>> changes in between and assumed it is just MCTP net driver changes. My mistake.
>> This was a case of leaving the default as is to not-break the existing
>> mailbox clients.
>>
>> The maibox client can over ride it in its driver setup.
>>
> What if driver changes in the middle of an ongoing transaction ? That
> doesn't sound like a good idea to me.
It would not be a good idea.  This should be setup only.  Is there a 
cleaner way to pass an initialization value like this in the mailbox API?
>
> You didn't respond as why tx_prepare callback can be used to do exactly
> same thing ?

Note that write_to_buffer checks pcc_chan_reg_read(&pchan->cmd_complete, &val);  This flag comes from struct pcc_chan_info which is defined in the pcc.c, not in a header.  Thus it is not accessible outside of the mailbox driver.  This needs to be done before data is written into the buffer, or there is a chance the far side is still reading it.  Checking it before send_data leads to a race condition.

>
>>>> +	void *(*rx_alloc)(struct mbox_client *cl,  int size);
>>> Why this can't be in rx_callback ?
>> Because that is too late.
>>
>> The problem is that the client needs  to allocate the memory that the
>> message comes in in order to hand it off.
>>
>> In the case of a network device, the rx_alloc code is going to return the
>> memory are of a struct sk_buff. The Mailbox does not know how to allocate
>> this. If the driver just kmallocs memory for the return message, we would
>> have a re-copy of the message.
>>
> I still don't understand the requirement. The PCC users has access to shmem
> and can do what they want in rx_callback, so I don't see any reason for
> this API.

I was not around for the discussion where it was decided to diverge from 
the mailbox abstraction, and provide direct access to the buffer.  I 
assume it was due to the desire not to copy into temporary-allocated 
memory.  However, the pcc mailbox driver should be handling the access 
into and out of the buffer, and not each individual driver.  Looking at 
most of them, there is very little type 4 usage where you are getting 
significant amounts of data back in the buffer, most of them are using 
rx for notification only, not transfer of data into the buffer.  Every 
single driver that will need to copy data from the shmem into a kernel 
memory buffer will have to do the exact same logic, and you can see it 
is non-trivial and worth getting right in the mailbox driver.


>
>> This is really a mailbox-api level issue, but I was trying to limit the
>> scope of my changes as much as possible.
>>
> Please explain the issue. Sorry if I have missed, pointer are enough if
> already present in some mail thread.

I don't think it is in any mail-thread: I expected the conversation to 
happen once I submitted this patch.  I did attempt to clarify my 
reasoning as much as possible in the commit message.  But the patch got 
merged with no discussion, and without a maintainer ACK.

The issue is that the mailbox driver is generic, and the actual use of 
it (MCTP-PCC in my case) is bound to other kernel subsystems, that need 
to manage memory in various ways.  The mailbox driver should handle the 
protocol (PCC) but not the memory management.

Thus, the rights solution would be to provide this callback function at 
the mailbox API level, much like the tx_prepare functions.  However, 
doing that would only change where he pcc mailbox driver finds the 
function, and not the logic.  Thus, I limited the change to only the PCC 
subsystem:  I did not want to have to sell this to the entire mailbox 
community without some prior art to point to.


>
>> The PCC mailbox code really does not match the abstractions of the mailbox
>> in general.  The idea that copying into and out of the buffer is done by
>> each individual driver leads to a lot of duplicated code.  With this change,
>> most of the other drivers could now be re-written to let the mailbox manage
>> the copying, while letting the mailbox client specify only how to allocate
>> the message buffers.
>>
> Yes that's because each user have their own requirement. You can do what
> you want in rx_callback.

Each driver needs to do the same thing: reading the header from 
iomemory, checking the length, allocating a buffer, and then reading the 
whole message from iomemory and setting the flag that says the buffer 
read is complete.  This is a way to get that logic right once, and  
reuse for any PCC driver that receives data in the buffer.


>
>> Much of this change  was driven by the fact that the PCC mailbox does not
>> properly check the flags before allowing writes to the rx channel, and that
>> code is not exposed to the driver.  Thus, it was impossible to write
>> everything in the rx callback regardless. This work was based on Huisong's
>> comments on version 21 of the patch series.
>>
> Pointers please, sorry again. But I really don't like the merged code and
> looking for ways to clean it up as well as address the requirement if it
> is not available esp. if we have to revert this change.

In retrospect, this patch made two changes, one which was completely 
required (access to the flag before writing to the buffer) and one which 
is a don't-repeat-yourself implementation.

If needs be, I can work around the changes to the RX  path. But I cannot 
work around the changes  in the TX path: it will lead to a race condition.

Making the RX change makes both paths equivalent, and will lead to 
cleaner PCC clients in the future.

And I can imagine your shock in seeing this patch post-merge.  I did 
send email out to you directly, but I realize now it must have gotten 
lost in the noise.  I really wish we had this discussion prior to 
merge.  However, I hope you will consider not reverting it.  I wrote it 
to be backwards compatible with existing mailbox clients, and to only 
take the new path upon explicit enabling.  I am more than happy to 
consider better ways to enable the features.




