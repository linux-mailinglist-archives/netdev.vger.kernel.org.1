Return-Path: <netdev+bounces-163361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4CEA29FCE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED50E1628A0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5118CBEC;
	Thu,  6 Feb 2025 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="obr6vs/L"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC81A2D
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738817436; cv=fail; b=izOBe0X1kF7P0kYDCkXQvHwOoVXYGqoNQ7UKPvKmIuLzEgTdSx+FoCcuv5wPIAbGZDMnWBphG7DdGBS2VGjxSbc+XT4EKH0XrAvPQ5N/j0mw9TCV36z6jjlO+sMHGy7ZhZkeHgKwKAXcawXYHR8ZeBe4jQNJF8SjPpi/6XHyRc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738817436; c=relaxed/simple;
	bh=1NnmEZ70CgfK2xV3ER9ITu04jBl6ju66l6i7GNDspeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZU2mkwzz64YKtHDhgDORPVNZjplc4K3AyBdofMqdc3Goro56+gQwHg9m1nCgHT6yfRJ1lFFXGs+rY300Wfm5OZ+TXwXtyYDBViEVrgpJb+xhknr4WGYmWSvPoKvOG/yn5fczhsBtEQ/Bw71+VZpLHUxrVTVSQMQADuoA5I1qv84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=obr6vs/L; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1738817434; x=1770353434;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1NnmEZ70CgfK2xV3ER9ITu04jBl6ju66l6i7GNDspeI=;
  b=obr6vs/LCCBVy/vRjhEm0jcvqrtwqMOhqBptJlpi3k/X5cxsdr0OLT7p
   ZecJoCIYl0FRZGVSoOkRYqZwdF4CGXTa8rmyVRnu1t0EEep8mfyGko8Ue
   NrFCVIdO/p1sC/KxKH5O959FUJgzVvq0tvhqVm1jCS60AMeLsKZvrKI8J
   U=;
X-CSE-ConnectionGUID: Tob1uU3oRRu4tebtVrJFjQ==
X-CSE-MsgGUID: oKqO+I6iSReWYGTf+h7N0Q==
X-Talos-CUID: =?us-ascii?q?9a23=3ASgLybmj97lqhxsaAohoojblFqTJuTnrXlWrteEi?=
 =?us-ascii?q?CM3s1VLCfVWGK2o1mqp87?=
X-Talos-MUID: 9a23:N3thegUy5JEMjMXq/DjPnRYhFZlp2J6jN3EirZtFu5aibRUlbg==
Received: from mail-canadacentralazlp17012028.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.28])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 23:50:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3DIlUJTDIDBIVPB1hLSXHZRJZQ7n6x8FUiZ/dYNH1A9T1vglf1LOrqsAlKIq4SgfWoLuheXPHQccJ9xZzKWk/SXeXqyPWQliy8gWiGGTR/eb889dKg0EK9w6pavfHbL1LTgZ6iT1GwR1pqYoQwQdvl9HCgfKhwV/4lM7jU84LmJCwJJiV4AfFEfIPGC9o2CCR55wrwcr1VAJgLE5oAIUrboCiwx2OwS/bGBxrG/CtRz2Y11/0JWcOTl/bolGBUXAt2NsGereNiaAc/aUldHSy2Hq28okeiZLetQJ2vrM7+C+BuPdBVINx5dOgTbDomLl5wCShVu6Wjz3Zx54Vyq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hENtPlj+s4IvSwcxXoh5mwGfdRxdwIvF+goZk9fVYy0=;
 b=hNJY4ohYq2X8ZqXab+Mu7QNnyDYjo+Y0kGQhLPwQ8d4ovX021rHPT5pRz37WXxyVkNvTT/rDeHOaGiJUIZwOkMJmdq+UTaz2N31nA9J6hD3u+soTqIKPUYDp0JUP463VCjqaOiBJt8ArsyytXUG8uj8kcYWS8KsT2pXfQLDOmG9hyFcy+joZ7ltbdp8LAs7HFOBFCk7h6ctyMWOvpgSpbVgIfLLa9kOsuNqatzMrFcJlHTMiDAcO06m1NcyG89lETjD0TaAlSZ4CGWh9nNG3UQH4xSmbbwNQEPRchjgBgagMQRQRV36Y3yhH40u/IzzZ1zsKrCkjAnBlONvYv06BvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB5567.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 04:50:25 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 04:50:25 +0000
Message-ID: <6eeb6128-cf12-4997-a820-54c56eb93656@uwaterloo.ca>
Date: Wed, 5 Feb 2025 23:50:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
 <b2c7d2dc-595f-4cae-ab00-61b89243fc9e@uwaterloo.ca>
 <CAAywjhS69zRTBM7ZLNR08kL+anYuffppzU5ZuNORxKGQgo7_TA@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhS69zRTBM7ZLNR08kL+anYuffppzU5ZuNORxKGQgo7_TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:610:b0::10) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f95f818-5f15-4392-c5c8-08dd4669c55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzl1WEEzTkIvRG1FNkZSUHpWS1hkVDl5TmZUcHpYbFhMUE03eDlzYUNveEZs?=
 =?utf-8?B?clRJSEpuZ1d3aCtHdk14Z3ZSRVpzektVTE4waXB4R0JhendvZlVpbGJEYUNj?=
 =?utf-8?B?NXgzdGwxRHpFR2hhUzFIMDFkR05meTFBS2FYNk9aQy84dkthcXRiaFJTMUc0?=
 =?utf-8?B?dnFONEJOcXpTNWE5ZVk3WGNlaHVGdUdOZmFSWUhSekNNY3JVdy9KaVNmR0hu?=
 =?utf-8?B?enVJZHhXN3g5WXNCaThwNGdRKzhIUFVYRVVnaWtDaUQ3SHZRSVJhbnBrZ1g0?=
 =?utf-8?B?L1Z3Szd0bzhLbzJOUXBnbGRIeXhlZXhya3BJN3lYcEJHOFV6NjBqaDNDWWxG?=
 =?utf-8?B?NXFkTFlCbllvamRqaTA1K1NJZStOSi9Dd1dSTHRzRDh6Nm5LWW9EVGhDQVEy?=
 =?utf-8?B?a2dPTEVYUEVLeVRiZzNGUkNSRkI4VUxZVmZFbit6ZzFsWk1JdVZmdktVZjM2?=
 =?utf-8?B?eGdPcC90VkltSGhvU1dxTytTY28xZGhzMDN0S0F4Z0ZrQTBFYWdOWXdGQlQx?=
 =?utf-8?B?Wk1YN3RySkUwL1hxTFl1NDBBQ3RVcTB1ZkxZM1dhcy9UdW1PQ09yUVJWUmpa?=
 =?utf-8?B?bjVzYjBpNjhsdGFqUW9TTlo4c0g1ZnNYZzJrc3BOWWtxVTNqWnQxOGVsRTBT?=
 =?utf-8?B?NmRGNGVLU1d3aFZXQkc2bjhRSUo5ZXVBWE5MNjlQbjBWWHYxei9MREFxbzJs?=
 =?utf-8?B?bFVXcTNEckZVRnNETS9USlErcmpzcDFrb2VHN1pVMEFNRi9rQjY2ZnpCdDdy?=
 =?utf-8?B?RjR2R05zRDVZbDhQS2R5R3IxV2w5U2x1RExBbnRXTGRab3N2M3ZIYWZSWEZZ?=
 =?utf-8?B?dElCLzNVYk1PemtvVmxYbHBWaTdGWUovbzlCdklGaUhmTHFMVGRVWDhYZXpX?=
 =?utf-8?B?UElxWEhKUERZdGRIb1Mva3NyaGszQkovS05HY1pRVkJTMnJoVk9pdHB4dnFm?=
 =?utf-8?B?TDljR3NTYTZKQTNJOEgyMkpDRCtvVnpISTdvaEpxVjRsSzlwL3B6N2htWlpz?=
 =?utf-8?B?WFhEYVhqYXE0My9nS3Q3eVJndFYxTGc0aWdzamRjWEplNmkwQmI2WllLcnB3?=
 =?utf-8?B?YTNCSDJqMzlVSFBkQ0NYNXhjaGljZ3dHbDhmNFNlb2dHZHo0enVGY3NlNk1w?=
 =?utf-8?B?c2lqYWp2VHVnRmRJUnNsYmIvWjE1WHpKcWk0RXovKzFnNWUzWDR0Q1NMVHUx?=
 =?utf-8?B?YURDY3ZRZmg4V3NPZ2x2cGV4bWdlNUFlcVdaRUJSdlJpUlR5ZUNsWG1XVTV0?=
 =?utf-8?B?VWNHSDBwSGtvVFd3ZXVhRmxxMkwvdUtmamhCejVUQnA0QS92YXV0YkROS3BQ?=
 =?utf-8?B?b3JrZ0d0TVBXR1pYR1JaZkkveWZCMWZpbFRIT21hcGNXcnVhR200OGwrZUc0?=
 =?utf-8?B?amNmVVQxc2Mybzhoc1l0SmZsV05YNkFjSDdvemdOV2h0L1VNT3ErU2xTN0ZD?=
 =?utf-8?B?YkN2MFYzK3VyNXdlV1c0aUhQSnV4OXQ4cUxkSmw1ZnFPNzVRd3orNGtPOTU1?=
 =?utf-8?B?ajNUYmY3VG4wR2ZPa3ZIYWhtYzZ3N2pWWmh4eUdRWnVNaHFkeDN3MUJrTkJN?=
 =?utf-8?B?YU0zRzJHNGcwNjEzcEorSXdzNlZXMm9mNDFFRTFMYUdaTk54bFVROTAvMnR5?=
 =?utf-8?B?bkg4UFVjRWJ0NEFYbmd1YVlLdUk2eXUyMXE0T3N3MERDYktaOGxOUG54bDh4?=
 =?utf-8?B?ZytseU00bmY5ZnFrbldGSzJ1UlhPdGN5dmtzUmlvL0xEakxsQjR4OEpuU3kv?=
 =?utf-8?B?Wmx5NTFNY05LSFFuZVp4cW5zeHp2elFzV0UxKzk5UVlCU0lYT096MW4yWGhq?=
 =?utf-8?B?YXo0aHdneXpubDBlMTBQZ0VOZkpHUko0M1VOTGVIMFJMSzk0NGZOQ2hoZ2E3?=
 =?utf-8?Q?8Pwtv7tGV72tR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGJ0a3U4Q1lvQzN2UVpZamdqZUhKdXJjaURMNVA4OXZxSnZZRmpRNG05eXJr?=
 =?utf-8?B?dm5TNWdlS3JOKzdva2hDNFgwUFhFTy9zTGs3ZCtrM1Q1aUZEeWFGVlFVVlhL?=
 =?utf-8?B?Ry9LTlpoWmVYMHRUOEVIK1ZNZHJlbjVOT0xnb1k0c0JINTFHT3lyQjBtNTBh?=
 =?utf-8?B?S0tPN2k0RXE5OW1qclJCK3g5YUQ4eWFFYUVTLzk5VytPaFFTbnRkWSsvRnEr?=
 =?utf-8?B?ZHhJNjdNQzJCckpzSXVxS0ZYT21laEdBVEFGdzlYTkJTWThvNUN3elRDODRN?=
 =?utf-8?B?OEg5VnNmMkQ3cC92M2hyeGtua3dYYldLZ1BPY1lQRkN6Mjd1emtLRXplRU5j?=
 =?utf-8?B?YW5GR3lFcXJ0VEpJSU9zVktPTHhiQmZZcDd4bXFZekxTOGp5d3Arcit4dlA5?=
 =?utf-8?B?b09MaDUxbjNRL1dmN2FKSEpNRTdCOUR5S2xzZHZPYnZ0UTJJd1FkVEdWdW1U?=
 =?utf-8?B?dFo3LzJremUwbTBPMEhEa3ZCV1VaeFFvdmVlM3A1bmtCYmladDdiVUx0NDFw?=
 =?utf-8?B?RCtVN3lBWmFneHdiMFNNbkYxeUtTSTBPeS9zQTZTSjYrZVVOMkducTEyWko3?=
 =?utf-8?B?YjA4aURkRDdqRWFwbWdpMXdFVzA5bWtWWm1ZeFZ4NElPOWx2b3ErNWZFQURo?=
 =?utf-8?B?YmhSRThWUGZoZ2VhVHRvM29SYW9KU2VFTWtTQWFRT0Mvb0ZEbXBwRGdWNTQ4?=
 =?utf-8?B?ZE5iMEhiMWptaCsvbVFqaFo0TE1vRzd5SDlSanBma2dIS2RERnBGaTVzVEUz?=
 =?utf-8?B?Nmdxd3M3NE5nY25VMlhUVEhHWWtJakZDaGhUdnNTQXQvZVJKSmx4cmI5aHN0?=
 =?utf-8?B?d2NwN0MxTVErVk1hWDRIUEZBYm5oMGE3bHFvZVV4dThEMWxTMFBnVjhqVmVS?=
 =?utf-8?B?OVN4azM2cG52aGg1eERYaUFTYVNuNisvTkQxL1hqdnowbVRXcnkybC82UGJ6?=
 =?utf-8?B?Q2IxOU9PMS9zRWJFNWRqd0UyUSs3YXZYbXV4ZjNBeWd0NzVwNnJtd2JyQ1J2?=
 =?utf-8?B?MEYyemJiMXMyMjlhL2YrSkFEeFZwMWQ3VXM3S09YY05wc1JVVGkvaHJad1VC?=
 =?utf-8?B?SnJEWnI1bHFCaUdxbWtESG9TZWtqb2NGYzdyaXQwYnFjK3hyZkFpMDkxdW4z?=
 =?utf-8?B?dWJqVzRRT2J0Uzc3V0VibnNGeWNMb0VtSDFKdWNRMlUxSk5JUmFHbEhFVU1P?=
 =?utf-8?B?d2ozM1FWNDBialhvcXYxSTI2WDg1U09HQUF4b0lwNlNGcmFYYUlVOGZ4MFIx?=
 =?utf-8?B?UmRpQmpIOTE2cEVLK2NzTk9sczhIY1k4ZVRwbGJDVkRacExUVkwvaXpBUDVl?=
 =?utf-8?B?SjdGSWtUUUcrMis4YjdQNkJDWk5vSXBQdytmdVBZMVhYbXdJTTU2bkMvYlpy?=
 =?utf-8?B?ZmM0TGpwUXV3aDB1THZEdEpIVmJNMlVDYkpDYXdqWFdSK3lZejNiSkN2ZllB?=
 =?utf-8?B?M2VrY002QzB5Sk9MaVFVZnJrNWpUdTZPVXMyTnFEUVVvWjFwcWZWTyttekdG?=
 =?utf-8?B?azZseGFCOS9nOHlpNXlyajEyb2pQUXBabE1GcHRjbC9MTVdIMExvNnVhRW41?=
 =?utf-8?B?aiszZ0NlWnc4L3RRTXVNLzdFakpYMVpOMktRTkVKaGgyRWhiTXh4ZGtSeWdC?=
 =?utf-8?B?TWJNVWQycDZyUVJrcWxKRTIyK3RxY0JzNXk5U1VxdWN6NEJ6RVlRNXF3Nmhp?=
 =?utf-8?B?SkZUMWt4dVJ2WnBYdTRYT1JJaWlRS01YbG1lUXZxY1VjOUFsUkUyZ255OWRt?=
 =?utf-8?B?TTc0NjVKUkQwT3k0YStlY3h0d3hRMm05bGd3K1lDNWp6dlVOZ29JY3l1MnVr?=
 =?utf-8?B?QjU2dUR2SW5FekoraituelM5cEttU1lIRnh3VzdXb25XY2taNDJHU0xrZ3dk?=
 =?utf-8?B?TWxYUTMrcUp6bmJBNk8rcWgxRGZuMmlhUUVSU1pwTGRFMUpKR2dtTVRqeW56?=
 =?utf-8?B?SDJrYnptUE1aL0ZMN0JFOGFQNEZTSXlORmFpMWoyUjRPU2c0bXIyTUtld3E0?=
 =?utf-8?B?U0tXenBiQXdKVUlPV0YzbzczYjhHbFF2eHVzWWN0d2Z2MFJwQnZ6aUpBRlpI?=
 =?utf-8?B?UlpYV2dJR056SGZJcmJwZEIxSE5nQnNWMk10Ly92dG1UdVVjR1JZNmJReEJB?=
 =?utf-8?Q?BqRAOapsHifzslGV/NPMrEWSG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NKsyMoq0cIwxlV+4AAyNqSKkQD6hAaVQNPuksiTy/uy3UX6FI5zoBaRtXHOz7fa9evWlNrTHob/EVjwjNJQd2I2QqI29zywrlUZq/ghFACrmrTrBut6zUN7nJy1oz0UQsTmvpdVjuLjscxkSG+SEcD7TtvMvJo2jbK6o7Jm93hQfiw4DfJImRDKkLx5mitztTIp1lz4ysC/WBKtropzAjNZCbUjggUDqKBJWdnf5Ag8+/fAzUQ2YBsizLyj6ZQV0gkk4v0RmMqGhpVT5Flsp9yfTYMw2uEDPw5T36v0MKQWw8krPzkaOKnz9swkQ1uD5GKDHya80q+toO7OfhVCpzWDvq7yQjySiveraV7fQQzzXs5aOLQ3rzc2dBrPfw0lAFSwHaKbcbZl1Nq6Qveldq+O86lL6dDG/jlbfCJqsjhnGzWGdTsa2YN6e01DGLrOYxZo9j7U1Rr3F5KLQxtHGeB8+iFuPxCUPXw6F8v/lT8UU8lr91J8OpM8LSVVFp0cha5yUAQO+xQ2iysXiIdrureklwcGos1mP3S3f69sy8XdFrmnkvoSjs5NaKrcBjAqZy7XG/CBQ70sw926hGnwNMkPE0RTy4FT8JK3INndoebpBHW7hqzwyu1RHNV8WZc3A
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f95f818-5f15-4392-c5c8-08dd4669c55e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 04:50:25.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I0Z7vOERzmU6x7wWLMIX5Bc6v6C8kNV1UBNw0eYv650a2Ru97lVABz8qdMDUTaWk0/MzpXSS4s4J2hFWwlZvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5567

On 2025-02-05 23:43, Samiullah Khawaja wrote:
> On Wed, Feb 5, 2025 at 5:15 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-02-05 17:06, Joe Damato wrote:
>>> On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
>>>> On Tue, Feb 4, 2025 at 5:32 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>>
>>>>> On 2025-02-04 19:10, Samiullah Khawaja wrote:
>>
>> [snip]
>>
>>>>> Note that I don't dismiss the approach out of hand. I just think it's
>>>>> important to properly understand the purported performance improvements.
>>>> I think the performance improvements are apparent with the data I
>>>> provided, I purposefully used more sockets to show the real
>>>> differences in tail latency with this revision.
>>>
>>> Respectfully, I don't agree that the improvements are "apparent." I
>>> think my comments and Martin's comments both suggest that the cover
>>> letter does not make the improvements apparent.
>>>
>>>> Also one thing that you are probably missing here is that the change
>>>> here also has an API aspect, that is it allows a user to drive napi
>>>> independent of the user API or protocol being used.
>>>
>>> I'm not missing that part; I'll let Martin speak for himself but I
>>> suspect he also follows that part.
>>
>> Yes, the API aspect is quite interesting. In fact, Joe has given you
>> pointers how to split this patch into multiple incremental steps, the
>> first of which should be uncontroversial.
>>
>> I also just read your subsequent response to Joe. He has captured the
>> relevant concerns very well and I don't understand why you refuse to
>> document your complete experiment setup for transparency and
>> reproducibility. This shouldn't be hard.
> I think I have provided all the setup details and pointers to
> components. I appreciate that you want to reproduce the results and If
> you really really want to set it up then start by setting up onload on
> your platform. I cannot provide a generic installer script for onload
> that _claims_ to set it up on an arbitrary platform (with arbitrary
> NIC and environment). If it works on your platform (on top of AF_XDP)
> then from that point you can certainly build neper and run it using
> the command I shared.

This is not what I have asked. Installing onload and neper is a given. 
At least, I need the irq routing and potential thread affinity settings 
at the server. Providing a full experiment script would be appreciated, 
but at least the server configuration needs to be specified.

Thanks,
Martin


