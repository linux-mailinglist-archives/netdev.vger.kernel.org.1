Return-Path: <netdev+bounces-211924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3CBB1C8B6
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 17:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC017A247B
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DB290BAB;
	Wed,  6 Aug 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="R9eguSZf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2098.outbound.protection.outlook.com [40.107.101.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A128D85F;
	Wed,  6 Aug 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494133; cv=fail; b=pnXuDZ2W8fSJjdN3HMHZOA7LOaS0K7FDfxikzphcyAIvhjcqUPPyCiLc9G7E/aM+oy+w0GwmjYG4tuKeEX+qxFB0nM79W7E4oxWdrGfjCdiV3x/V14+dVyhN/KV57hqCzwzx2CGbBJP1dtA5tBgfeFl0uZR8UpEZo+PYAH75QXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494133; c=relaxed/simple;
	bh=f7bSik/BaiPdFoyjwE41c0mx9pFM5jnHX4n+XTWOcEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gvSNztNSmkbYBN8mBqnVU9RzI+01Du00wyPnLOS8Qxxw0izuFf76j5htfZGkdbtWkhSIKt5nAGeJqnORMX1OvUbru3808I6p2TaUSj6rM102ALWE5A+7Mp5/zhsn/aknK+azk44Ma1++BO9A1RynZ/0yk0W734ZL0Hl3lD1vlDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=R9eguSZf reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.101.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJxs70X9SrUJpALElDsDjvJlwZWhGFB8B9zjlaChYlR+6FG5xvC67EEjxExKZafatkxW/TCKzQW8z5AyaU+5/c9358XQvWt8kcZsCyfUUYpPq486keAKIbcMJTMuCDQDVF8QPIPe5L3IE7XGKTQ2NlFdpcgq50boGBsITeLL4ui/noVDrn+FRm8RKeRH3KbHgdYcwnVJQl1hiK96R4wYFwUj/ssnofG9yXjgbRjMpj43rlZEw+VpamC8SHXSeT3RDC0XwG2zyVie891hFUJay8cymkNCtNTIAj/N98QkCGzeHOiJG/mKI3SufBiYUxtSPyYubfS6H/pkFkT7uK3h8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du8Ztiy44gufez5FgswwTYj8jbgRESNBtTsd7Y4QcD8=;
 b=BLzTHZuFWx4afOgvuZwOLfkQbNeIjMKorwKsp0ERVqvp8k3oA5MoL8BV57snjJux//mhgQnSjcJaHx0SNnzPz0rP+j7dlb2n34dyhruqr34ym8E6zVs6yun2GrK0MyL8ZTdSCh5jGEWs2aJRd0DADCAXozZglG5H127BnGefyAAd00BUiZg7zvdW2OLdcLcgjHYjYYB55dy+RnA0gBVYxecd+U89aKh/YE1bU1bjNw7xZ2krnuxbPKLe8GTEf87hn+rkhFyL0+RWHNZ4ylBmdaEqY6jo4LOWWfSVI/Yxs5RMsrHqQbXGx+rw1HYHx2eql0kQMmXXHyKuDPlmzgbabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du8Ztiy44gufez5FgswwTYj8jbgRESNBtTsd7Y4QcD8=;
 b=R9eguSZfVYKDqPAwHtGVXe3MvhE300TWTwKPJiDCud178RrXOjteUSWag0cEdFSdOdflRDM0yERMkSswCOLrNmbp+HN/ZUhIW3KDfZ7MDWvvJQ8NE5CiKYe6L2RHp/MXO9Rjhqc8V9QCXB3IvR4TlrtEX1LUEvKKoDhdHfVb7jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 IA1PR01MB9114.prod.exchangelabs.com (2603:10b6:208:595::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Wed, 6 Aug 2025 15:28:48 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:28:48 +0000
Message-ID: <7927740b-3cbe-4002-b30b-a1f7e8aa814c@amperemail.onmicrosoft.com>
Date: Wed, 6 Aug 2025 11:28:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <bb544194-d8af-4086-b569-4a4b4befd6ad@amperemail.onmicrosoft.com>
 <d8ac05a9-9229-49a4-b7f2-8d92060ccc63@amperemail.onmicrosoft.com>
 <CABb+yY3VUpfM4PKQbvcv5eHnsEbDOY0aRjcXPTf0bsr322WGng@mail.gmail.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <CABb+yY3VUpfM4PKQbvcv5eHnsEbDOY0aRjcXPTf0bsr322WGng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:208:a8::14) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|IA1PR01MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: e055b356-c620-4062-5481-08ddd4fdf043
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHlYdENqL1NFeXZxV1dQUmRrU1VBN29EbVREb2x1WjJpM1hiWDU3cTdXNElm?=
 =?utf-8?B?THVia1lzMWZDWDlOeEw4Skx5UjkzVWJyNnVxU0dZWVZOcE1aNkttaDRyMmhL?=
 =?utf-8?B?TlJLN3hJZ1hIa2pVMUQ2Y1huQ040MlRpbjh1WG1RbnhuR015N1FEeFV4VWVm?=
 =?utf-8?B?RmhHMmxBdzNCRkQramcrN0JYY0ZLRmJHZFFhODM1c01ENWNPRm5uejhZYVN2?=
 =?utf-8?B?V2FRNExkekVYaFp6V0NRWFBYRnIzRlE3N1V0MDFyNzRQVTl3RHhWNkNVRTJa?=
 =?utf-8?B?S3hwa3FVVXZ3RVIwT3loVFZuMHBsVTFOb1RCWTFXeFZ5S0MyWU5TdkhQdUFS?=
 =?utf-8?B?Wnp0S3RRR2ZLSGFiYWtYYjZRV09VMTA1UTZrRWVZWGp5Z1QrSHdTZ0NxQm1k?=
 =?utf-8?B?cEtOdk9nbUFXSzIzTHNFY0VOWlJZMUVqcmowUE1RVnlrRG81aXpaQVBnSGdO?=
 =?utf-8?B?UlVnU0FYNkQ5alY1WkpFNHMyL3NOa0w2YWE0UDB4RXZlemtMMUp3T2VNdjlY?=
 =?utf-8?B?bmdaLy9ONUVSSTdPU216cmN1dTdoWk9BUTZuVVhsRFZXcm9JcGxCbGtiN2l2?=
 =?utf-8?B?YlRZanc2VGJ2aTQza1NNcnROb2QzVkozdXlyUTkyemtvWEVqTmczVUU0ejFU?=
 =?utf-8?B?TkM0YytrMmt3RzdQMEVIcVZ2TzFIWXVESENxZ1JUM3NKN0JkNjkwemJOekRY?=
 =?utf-8?B?bUREUGFqNWRVT1JPOWt6aWU2ZWU5dytoVDBGTk9ORk9sTHVCaW9CUEJFb0Ji?=
 =?utf-8?B?d3FRQ2Z6RGdvMTlSVWFWNzJldUxIYXlUK1MxNkxCRTB0ZXdDQWFCT3NLV1pa?=
 =?utf-8?B?SmpJdkZ5QWtkWjNhVGVzcVBiWjh2RXovbEhuQm5EdkNVTVZpQ0xrUjhBM3Jt?=
 =?utf-8?B?MVNwQnRjZG1pMGdvcjNWaCtMR2RSTzJDUHhsMmR1NHVUc3pNU2pWWWZIbHVW?=
 =?utf-8?B?cVp6c0ZYL0IzNVlWMjhNRCt2aE9Fakk5ZUtzZG5QaEhmTjkvdnVoWWVBaU5p?=
 =?utf-8?B?dUpqMCs4MHBiK0pHOUJIcFhsbElFVG9yZkFKRm5tRGMwQ29xSndOQTZnekVm?=
 =?utf-8?B?dTR4WUFPVnhRQjRLNG1NMjBOTm5GV3JEeG1KN1ZIWUVpVXRmUHB3ZzRJb0E5?=
 =?utf-8?B?Q0t6eS8wc0ZCQmN5R3NMaW5SdDFpTm9FSmxnN1pJMkJBbkk0V1o1TDY4anh2?=
 =?utf-8?B?MmZDaVpKMHlVUkhRRDM0NUc1REVQT0lHYWFqaXJ0eGN6cVdYajYxQ0QwaCsy?=
 =?utf-8?B?ZXIxNkFBbkVGRGphR2tkNDh4bG5SUmI5NmZITkJINVNFdWRzb2FVUUpSZ0Iz?=
 =?utf-8?B?KzFTU1RSakU3TWxBdGRCZXhNMzB0VzhZaHZyS1dHMll5MUxGVFVma1RzSVhV?=
 =?utf-8?B?VWtmRWk4NFNKNUlGdWxxU3hIQnV4MVNEeW1wMm1VQWN6eURER3VCdG5LWGhD?=
 =?utf-8?B?aDZ0RE4wZytTUlBKcHVMcGVsczRacnBsRTNRRTV1Vi82b3cyTTE0MkFKL25n?=
 =?utf-8?B?dlF0UExTYWt0bWVoQ0JyNVE4eFZuRXV0NnZQdmJlb0RzTWNZZnBDQzY2Vzhn?=
 =?utf-8?B?SzUzc0U2bTRsN2tiK09jODE5U2VFd1VpWjNubkEvN0R2Z28wdE1BY0xFbzFq?=
 =?utf-8?B?ZWpOcmZXbTNqZ3pkR0RsYmJYcDNNcUEyQmhVY2U1Q0plT25sM1ZhbHpIQStk?=
 =?utf-8?B?Q3JsYXZVcm12OHJTTTRvU3RaaVk5bUtOcit5c1lsUlQzakdoMzB5NnNBTkN3?=
 =?utf-8?B?dzVPSWZMMTJreThJZGt5OXVJSndFT2pGZUYxM2UwS3ZDUXRsNkJ4bzB1d2xE?=
 =?utf-8?B?LzA2Wm5GTzA5UWpFOUE4VWpFa0FQVFNLeVBYZXlYR2QwdUVpYXdrM2ZkNlln?=
 =?utf-8?B?N2JyT1dacjVaVlgyNEZsUnJSOG5JTWhNVTV6RE9YY3J4YWdRWmtwWlVKVzhW?=
 =?utf-8?Q?lqaAtBOYSXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTFIRGV3TnMxZmdYaEFabk5WYW53Y0dvOUM3R1B5YTNPVW9Sa1JRdjVXbi9w?=
 =?utf-8?B?ZU8rYXhVR0FSU2dJaEVSeGlQSGRtVktudW5LZVFxOC9pUm4wclhDYkJNTWFV?=
 =?utf-8?B?ejFSRHNOM3drTVFOWnFMeTlTOFVUZWJsMHZVREowNVhONDQ2bVZ1cUI3bzVx?=
 =?utf-8?B?bnhBTWRDdzIwQ0FBeXY2NWNMZS95cXQ5QU5DME1GRkdkMEJVZ3cwQUhvU2ho?=
 =?utf-8?B?Y3JRS0JHSFlLc0dwS1JBS1BjNXFyK20xNUw2OHgwWUZWdEhIOE9hMHMzRmJB?=
 =?utf-8?B?RCtxVUpuTHFXNEpVc1NXbUVLVjI2aSt6R0w5V2hlbnIwRU5xTDZHQURSVG10?=
 =?utf-8?B?M09zQVNGdUxGY2V3TTRFalYzZkZkWVF6UHVDbm93bHhpRjNJUzhQQVIyZGFr?=
 =?utf-8?B?dmxncEYyMW9sS3dHdFJmMkhjZXl5ZFRJeWRqc0dQdzVTUkVTZjZCd0RteGhB?=
 =?utf-8?B?R0duVS9sY3N4MWhrY3JaR1JOdkd2YW1pS0VKU3JXb0RhV1cyb0FYSW1WTTNw?=
 =?utf-8?B?cU16OFd6eWhJVlB4Zy80ZENGTVN1eDJ6Z0hwYVZCb3ZhMEE4OU1UcWFzakRq?=
 =?utf-8?B?ZlVQTjVPR1Q2TERoUFBGVWdST2JNWWZTNmZnYnpLUnVYVUhJZEhlOXJLbm9F?=
 =?utf-8?B?RUFxODQ1azVieGdqYmZrZW5ZYmhranNPRyt4VXNERmNXUjE0eU1ZMTFrQjls?=
 =?utf-8?B?K2tMVTFiL0NBRy9lZ0t2TTFrbkNCNW1lUDZmaU54R3k3Z2tSSkhHT09DY2M2?=
 =?utf-8?B?enUzcGttRWpLZWgxWWFrVnN3VWhoYU9XZjQyTW5JZWgwMnlkdDJTTEVFa2t0?=
 =?utf-8?B?bDIvUUg2ODJXUXMwVUc0UlYvMUYxb0M3d1NFTnIyZnFpRFVmM1EvdFFQTFVo?=
 =?utf-8?B?ZDcrMmVTd3B5OUVKRVUxTytreGNZZUhmaElvVHZHdTVtclljWm9aMTlydUZ3?=
 =?utf-8?B?WHRFdVlvMUtPeC9Tb2V5VzhjYWdsSFBOL0UzcS9sSWhlMFdIZFJkbXZFdlJU?=
 =?utf-8?B?bGFXSFFBRVV5NVVsTW1CcUNncnVVNHY0WDhqaW10TWNRZWFRYVErYjJickRi?=
 =?utf-8?B?S1ZOWnlKUUgzWHFDTDhPNG4ralRFNHhnQ1phdWNDb21POThGV3I5VU1IaWt5?=
 =?utf-8?B?RzR0MnYweXVIV29xS28yTWdxUzFINWlYUGRqV0oxclpLSmVVK0VxZEpOUjJW?=
 =?utf-8?B?ZWhCWitPSExhZDNicXZ0TkcvcVpTUTdiTFhuaGVYSnRsZW5Nb3hJNTlyeEdo?=
 =?utf-8?B?dUlOaGNQcFlLMW1hU0VBZWlVVkZuSGcrTmxqcUxNK24zeTN2eXBabTUzM0J6?=
 =?utf-8?B?bVYyTUUrSnkwUWFxUExVdTc2Nk8vYngzUk1sQWpvRFVHVVloM0pFaUlmTmVn?=
 =?utf-8?B?U2NIc1Vzb1FJY0xkenhlUFhEaGh2OUZhbGZxSllvdk5rZmVGYjFWYzFsVy8r?=
 =?utf-8?B?WWMvYy9hQlNPNG5TbE9aV0FJOVpybmFGYVJFTFJLSzhlbFRKaVZhRFdyZFkr?=
 =?utf-8?B?S0JRZ0hIZmpsMU9YK2RNcmRrOGxPWWpnV2NSTHpKbS85alVxQko5ZFVJRHNW?=
 =?utf-8?B?cHFueXczRlZaeGNuZDBXdW9MWURuZXJvK05DNGlqQmtzRzY5cm56U1R4OG5y?=
 =?utf-8?B?OXZLWUdsd2JpYUh0M2ZRTVIwMGNUanFaVnNNaDdNdG4rbktlSDc2Y3hBbmdR?=
 =?utf-8?B?RlcyL0YxS1RGSVQ4S0FIUmlQN0VKWStNOG95cVpnOCtHR2JPK2hoaDBZWWwy?=
 =?utf-8?B?VFl3aFRvbDR2ZWRySkdra3dhSS9wdW9HQ2lUTGZkM1dPOXN3Z1ZUdEF3RVg2?=
 =?utf-8?B?eWhEM3FsVGorN3BhcmVBa1ZPZGp1YklQaGYzVXhMOWxSTks1b0tnQm9tT2o3?=
 =?utf-8?B?ODR6VWdNYm56TFJzUUowRzNhYldUSHJaMkQvbkhhcWxnWEJQU1phcERXU09N?=
 =?utf-8?B?b0FVaTlHSnFaZmpYcmoySXp1Y2lMUmM1eEd6OXZyTlBIZUFzczRsZU02Rkor?=
 =?utf-8?B?a1JGTkNCaXVXM1pGaEJ6alJnY2VFWmtPK2NSMW1OSzJuNkxSblBCR0hXaXdR?=
 =?utf-8?B?b0hHVDlzYnVJUGtjTVNtcDlJcW1UdldNaVR3Q3RVSktmS0NyeXp6WGhJYVdM?=
 =?utf-8?B?ejJCbUlQaVhFOXgrNW5CMkR2VHhBZTVDUDl4WDAydTNzNnVrQWx2clhEUDlI?=
 =?utf-8?B?Q1piRUtkQ09BanhLclF5VTlZQlAyZHpTaGtNY1VsL3ZHWkNrRlBFVmE4QkNq?=
 =?utf-8?Q?S9Nmz3/9+7GE7bEN3Y/lR93/Bit7oXZyNp5K8xWBHA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e055b356-c620-4062-5481-08ddd4fdf043
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:28:48.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umNZKWbvn9sDDdSQEJFl9Ku3qUhuCHCEWofkDfdlGzbTvafEuN+RFluTD2iHp5HtIJwzyZ+9n06J2uYQcZrQFicQXXnyKSymIKMOo8+dI9Mevsbj7MnGHIpotb8bvrc0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR01MB9114



On 7/31/25 16:42, Jassi Brar wrote:
>
>
> On Thu, Jul 31, 2025, 3:35 PM Adam Young 
> <admiyo@amperemail.onmicrosoft.com> wrote:
>
>     Is there some reason that this patch is not showing up in the
>     maintainers queues for review?
>
>
> From your last reply to yourself it seems like you were to make some 
> changes.
> And there wasn't any acked by ( though that can be overridden by 
> enough public exposure)


Thanks, Jassi,

I just know that with the last set of changes on the Mailbox 
implementation there was a bit of back and forth, and I expected the 
same with this one.  I am not making any significant changes to that 
layer, just nits.


