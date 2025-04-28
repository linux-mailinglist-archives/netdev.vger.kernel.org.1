Return-Path: <netdev+bounces-186519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B67EA9F803
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4300218908B3
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC062294A1B;
	Mon, 28 Apr 2025 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="rIXwJBbU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37326FA53
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863526; cv=fail; b=AsAly071O+uy4tMylD5aEQ4PlDadU3OURj64j+IM8jhtxf4C9p49i+/TGMCyv1Qs1gA/9U19FwtlTLzJrbxDTXByxol4TQ+caSVBhUbgIeQw7DYlv3KkK/AmzNyx191Gq9vgvuxCvMI9Ae/JjvUBRhWmkxunOiZxI+ic9PEGYoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863526; c=relaxed/simple;
	bh=UTyiYcOn16lmwFugmBqqiwDU/tPWMXwxUBQFHacv5ZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CwYrAeaCq8rvfEG9jSAf6F2fl8tOE4a5tUU0hDdIDURtBk5UOH1pf8qbf3y3izGf6doa+Wd295uS4hF2+j4r3OeJXayKN+kdnmFpbnn/90lFvdR6p6iXkhEtTfE2D8vWqL42e7kt5gFn9VXxzFPb9ZuV/NKWTTd+oYiDgymE1dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=rIXwJBbU; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1745863525; x=1777399525;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UTyiYcOn16lmwFugmBqqiwDU/tPWMXwxUBQFHacv5ZM=;
  b=rIXwJBbUxEM4sgoSWJDnIsTiL2PSEj5MgiZ6na2ApT7/mfWn5yHXl5gf
   mecnygwVyO/+EVB39n3Jk1Up5Vah6xxbWPxWZqN94PCwBe4g8C0Xk/e+T
   n/1ZUAFsJBsZfMs4G+/nYH3l00vZTZ8SBck9LFfncMh8Fk7jiu37KTA53
   8=;
X-CSE-ConnectionGUID: VZbFogpHQae8bm/3y5E9IQ==
X-CSE-MsgGUID: O+amxWtmQoCwuq4w4GU+cQ==
X-Talos-CUID: =?us-ascii?q?9a23=3Ao+2nIGhD5e7IrzbGipeURPR1SDJuTE/X4nDfO2+?=
 =?us-ascii?q?BAGs5QrjSEk7N1fJFqp87?=
X-Talos-MUID: 9a23:CeEmPQqOeVx3zC+MkD8ezxYhPcJ43LirMUcmjogf59bYGhEzMA7I2Q==
Received: from mail-canadacentralazlp17012025.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.25])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 14:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFmgm0f/hafgiL35AxxEsSxdhT4CBAqSEvkic8X9vasPryff0PBGVWHj6DKAIHQX1H1ZcG2lydWv9YnzIv/YZGFvx6rCnWvzP2EBteQwv/zfBm/x+rWOAOtTnu/B0XUSVMVrnzktzKs3vQN4TSh/Uc6NVRvreMoULscJ5l+JJXdej9qUEVaeHSWoPn+xn55wuMuzGJBbEBg8VO1yth4kUEPeUlBHfde/HfAXVrapJQ47S2bpXQbsz0ml4e6prpsgAVzwWsFqLaivK1BfsSk2gdHzf9eGU2h7AfNa3RL/jrZX4gd9NIHnFDd4PBgltTHufM/yIy4z4bMIHVjH1eMIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkNv4r9e5HTxygNHV2XM4P9wE9AolbaiHzH+JiRbRAA=;
 b=pJfLbS+pREDZlew74Rl/25SkGT0mXh60vJ6aSod4SlPFuXma0m27nU6NGsiy/PhAm8IrWCOnLUHc4d5h02/JpHhUIDaYt7IpktDXY5HYY79MaH4bIpIvlqger7upry9k0pNQnWz0yAZpDil2IHlzEpv/LYt7O4U3rTdzNPk/j6h9dfTUZYKcl2pEriQ5YGZL00pRgBPCiNaTgHO4kQdOqkF5qsSudJp7DFKA+b2mF7grxT+cW+a8+MULlpL/WhWUDluvRPcDSvAwSMhUlhGxVTNp65qYdrR2dxjF+AjI2DSapyjLMWLZWV2GEecBbeoDcdoV5RVMO7omG1sUMpEgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB8568.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 18:05:18 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:05:18 +0000
Message-ID: <5fa8c9b8-527c-4392-9c9f-4e1e93ab5326@uwaterloo.ca>
Date: Mon, 28 Apr 2025 14:05:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
 <aA-9aEokobuckLtV@LQ3V64L9R2>
 <680fc1f210fdf_246a60294b2@willemb.c.googlers.com.notmuch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <680fc1f210fdf_246a60294b2@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::25) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0c7720-a47a-43d8-3f80-08dd867f3c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnJHVXlUc2ZrcytZRi83dENIcE1Qa3hXQXhkT05PS3ZaR291RytjZnBTckE5?=
 =?utf-8?B?R3ZYTWhJVElwaFhqYy9uTWlSd0RMVXFwWk91bHV1bmJMUXVWckkzc2hFSHhF?=
 =?utf-8?B?MXRtcWQxVGgxWldQVVBFaEd2NUs3RDlMbEpyRTY5TFNkeUdFSkJ6RzFVdG5D?=
 =?utf-8?B?ZlIzdmRPNWE2bGs5eXV3OW9QNUhGRXJKT0VDcm1SZjZnU2ZyUXBySnFNL3VR?=
 =?utf-8?B?bW0xWENxaFpMYTZoL2pCRC9sK2xwUTdCNjZpNzhwbmNSeDN3T3JuZHdvZFlP?=
 =?utf-8?B?b2lqbUhsL0dqMWE4NkNybXRHTDMyTEtlbDZtVVV0L1dwRjNXT1BmTURsalJa?=
 =?utf-8?B?cXpOY1VOMXZLdldJbzBzUlBmZElZQ3RYbng4dVNUc09wTk1uSTlsb1dUT2l3?=
 =?utf-8?B?VHZuYlJhMmplSFp0Rzd3V1A3cytnUFp0QTJndGh3RnI3N2UrZkdPV1JObVRm?=
 =?utf-8?B?K1NlQnpIU1BrV0tFTEVqdTdmUzNhaXJmdFJFeFU5WC9kY0JZdktuK1M0R25q?=
 =?utf-8?B?NkFEUURjbEg4UDM0Q05JaGhjdlFPRkd6Y0ZESkYvUlVsK3R3NEtsZ3dLcVFX?=
 =?utf-8?B?RmxRc3M2dzlpdnNRVkpHczBCUkJLeGo4UjVpYnRGWG1scXp3SUZVcEsxLzBE?=
 =?utf-8?B?ZitRcjFOMTJyWjlSOXptcDlVcFBwR2ZEU0ZWY0lEdFI1bnZ3MjlUYVdwcER3?=
 =?utf-8?B?TDlPbW44bnRDcmw2bFBpcy9EZ2pVV25WeitzZzRQWnVxZzlCQ3dBaENveXZv?=
 =?utf-8?B?TU5aUzNuSWxyaktveG9URHhIYTNoaHRBUDdJUklYZzFpempnSFZScjhId09B?=
 =?utf-8?B?UW1GMW5aa3FMM3lMVGdHbzUyZS8xYklmMW90eUdtZThrczhCbXhaazZQK0sy?=
 =?utf-8?B?WTVKVHpNMGtzRkdvbXd0alpyc3dYWFY5VGtDSis1R1A0QVowbzJmSnQ1OUpu?=
 =?utf-8?B?WEJsa1lLM0dYM1BWaXg0dU0rZUUrRUlHTkNhZ0ZTeEMxVHovams1c3QrQ0pY?=
 =?utf-8?B?SCtCQTRybHYvbFplbzEyWXRXNSt6UjZDNDc1aUtSazg3eDFSaGdpV3I2RzZu?=
 =?utf-8?B?emxNQWdzYmJuaCtPbWZweDZnS01PcXBMOUpnblRPdEVTWnlkSmkzb2lFRkZW?=
 =?utf-8?B?Vkh6MzNYazU4SEt5MzVYeXU3bUlqNGxTTjJKaG5Bdi9BSGE4c0dxZFJ1V2pr?=
 =?utf-8?B?Mml1dmpTV051NlBtdkpyM24rYXBuODhzRnFnWHg4TDZRS1B2cHg2NE5lVnlC?=
 =?utf-8?B?RFZpeld0SHB0a2dFeGVXa2xhcHY1cGF2WEFTcnpXSlhKb1JNMUIvUU5UOVJ6?=
 =?utf-8?B?WlJJbVIzOVVKTFJxSk5VK0lJaG1Nd1hlQysxUXpEZHJmT1hBQ1MwVmV0Qzl5?=
 =?utf-8?B?UWh1OERuVi9KbllCSDN6b01TZFNPYjJXQ1dQRXFFdWZQbFlPajhhWXQrbmlC?=
 =?utf-8?B?S0s2R29Xcm9VRjUvVGZ0NHJER1FRdEhkWXNKSlphYVF0OEFqcFZKd0xucjB2?=
 =?utf-8?B?eVhNMEdjRWJZZWtSaGp6WlhydjYxbm9QZW4zNGdjQ2RsaytiUk1sVzNrWmQ2?=
 =?utf-8?B?Ym12YmZYUzYrbGdpU0MvTytLb0JmNmg0OHI1NjdBbzd6NzM3SmFqZG83bTQv?=
 =?utf-8?B?S2lXUEU4Nlp4eS9PK0ZEc01lWmpEVUZlbVFBcDVHNlJ1enNxMFRnbE5aWUl5?=
 =?utf-8?B?TjFsYVJWZnpYR0oyRHhXaFE2cUdmdEUvVFdxdkI1bXlZOTFYOTlIL3YyWERI?=
 =?utf-8?B?M3lTd3F6NEdUT3daWmlzTS9abGRPVFdGSkFoZVlpTVUreWRpQkkxbEx1QTVm?=
 =?utf-8?B?b0xwMkNHV3RENndTUmZSWldJQTA2dDV0cWQ2ZXB3VEJVSXNNa1pMV2ZFdWhp?=
 =?utf-8?B?WTBVakVEdjVJa0hqWndiR1dTQWs1QmhlNzlhaTlTTmpTMGc3NlQ0b21yTVZ0?=
 =?utf-8?Q?J9z6jMUQUu4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEoraiswMnBKaTRxaVBxbFBjZnc5TmZSL0g0dmduS2s0Tytob3FhNzhodmk5?=
 =?utf-8?B?ZWtCd2JodFNsZ3MxYmVxMXBkaEpqcE0zd2JvNWlxT2M2SkdLNzZLTnZwL3BO?=
 =?utf-8?B?dURQMDZOSFQ3MW1pa2ovd0k0aUpIWkNLZko3bUw2SHdRaC9wYmZzQ2c3RzhR?=
 =?utf-8?B?akowZjJIcUtlbmM2TzhFNTBUSzViQTBCYitMRk9tWjd6KzB0TjNxVlZaV09j?=
 =?utf-8?B?V05uR1pzVCtWUk1hQm9Ua29pZlp6SVdYYTRZOC9idFpITVdyaUYzYVUySUpO?=
 =?utf-8?B?eFd3dzUwbU5iY05Ea09uK1N3bWR1aDVVN2tuUDI4NTFOQ1JBZFgva1BtUDFa?=
 =?utf-8?B?NlJNdnZZVjVTRnl5VCtVa3RJVkJRY1JyVGdGSEJMMkc0SERmam1Ebjg3Vm1U?=
 =?utf-8?B?V3F0dFptN1g3MHpqdEsxdTNrdXhvY2d0dHhHMkxKeVJzcWNKRU5KblU3LzZP?=
 =?utf-8?B?QTRLU3l3N0tPbEhTdHJPbStrUk55Tlp2aWNFa0phMW02R3RSdFY3ZDdqMm5N?=
 =?utf-8?B?QloyQzZGSmVsNGNldWFDNjZUaG5wbitwM25FVk90R3RyQXhRSWsrUkhxRm9O?=
 =?utf-8?B?cnhDc2c3WnBTY0VkWUE3eEJSUnJSVzc4alJ0OVBLNVl4U2tEczVDOUVVWCtv?=
 =?utf-8?B?ZDdFRU9HTFRtUHVvSXFQc1BYZDlyM2JxWGUyZzJERmQwUjVYT2RKS0ZPemxS?=
 =?utf-8?B?Q0Z3UmNVdDJXYWRHWE9XZUg3VUNBbVhaSElJbHBhbzlGZ295TGh0TDB1SXpi?=
 =?utf-8?B?QnVxdktyT1RhelorZmUzd2RMMXJ1M2owbEZFa285cC9NUjU0emR5Vjl0YmEz?=
 =?utf-8?B?SDUxMzJYdE5ZZXkxNWtVQk4xYkd2N04yU0FxYkxORlpWQ3grcUVOT1pucjZK?=
 =?utf-8?B?d3hYRy9XUFZSTnlSWVdpVnhXSVVBMVRBS0tKSmYxQnJQdEpHOUdZVE1zZlFx?=
 =?utf-8?B?Z3hYN0lnTWNLTVVITVZzaXpVcEZadDhHTTc1eVYxLzQ1NUExRWxxT0V6OW1n?=
 =?utf-8?B?bU8yNjUxVkEyRHMzeHBiUE5qSHNKU1VRVHRZaE1idHJFeXpuR3NzKzBzSUpV?=
 =?utf-8?B?UndYSXUwbEFuVDM5OVRZOElyTTgxRDBGbGJvTXZFdzFMZXZVVTFBd0hvcEw2?=
 =?utf-8?B?V09MZ1RaREFpR0RkaE5iTVZIYUJMMVRybW0ydHkzV3pVd1RqdFRaN0Z3aVBQ?=
 =?utf-8?B?STUrUkx2QVc5RWdtTW80eDdVVVJZWXdoeTBGbEl4bHlEV280RThsL2hoSW1Q?=
 =?utf-8?B?em8xRjlSVkpubTF1Nm5HOE1laGxvVitIZlZhNlNJY2luUW5uQnJ0QkFOM3My?=
 =?utf-8?B?aktxRkw2NElneTJSazJmWk81eGNOOHFES1Mwa2srQnZzN3Bub0xZVTMyZUg1?=
 =?utf-8?B?d3hrRm0yL2YzOGYzSStjSXRKMXNpQWZEM1JsZ3N6Kzd1aGh2cUd5ZEM2VTRZ?=
 =?utf-8?B?Q1hxYlM3aFhOYmZ1UzBRdklVVzU0bFE3aVlyMnIzT3oxb0cyWk0zV3ZlNHR6?=
 =?utf-8?B?UjVJc0NlcWVJWitnNlRkd3RQYTFUYzdPUUNFNzM0d1NpdkplSjdZL0lFaDAy?=
 =?utf-8?B?YmJ1NlovMnVHaWFZdFlaZ0NRZTFCYmxPUjI4a2h2aU1ES0dmNnlaYi9uNjhz?=
 =?utf-8?B?Q0ZxQTJiSkRUWk9EdFQyMGlnNjU3eWExcW80alM3eGorYmdOams3TWc3dTlS?=
 =?utf-8?B?bk42eXBvZWh3NWcwZHBpS1hGUzBWTTB5VWx2RFIyeWJzSVYwazFqd1BlWFE2?=
 =?utf-8?B?d284VENmZXhlbW5NL09lb2E1OEc3QUhQZGx0ajdnenFVOUVGY3VJRERxZC9v?=
 =?utf-8?B?Wm1PVis0RkpqV01pbFhFUVMyQURtY2lxcTF5NkdUT0NvTGpSdjczdDM0bFps?=
 =?utf-8?B?SzdqRkp4QmJoMEZRbWFBK0NEd1hXME40OHQzVUhNT05laGZJMklwakJuUHVa?=
 =?utf-8?B?dGpkdzVKRTdFRWFwRUlVbHcyTFZUTTdZcEt6cjY1QWdkUWRtakhudjd6d2Vu?=
 =?utf-8?B?ajBhT2pxdm5COWpaMUdVUW9MTVFoSlU0SUJrMklQd3pkL0FsbkFPbTJIbVN6?=
 =?utf-8?B?OXcxb0ZZYkt0V1RhbFdiSzY1TGFRUHR4dk1SdTVJRE9OQVVtREZhWExsNkJL?=
 =?utf-8?Q?e8SdNiE9UT7GCK+ePOEn0hOSY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FyhdpF0TRMNl1tSgoa+hXEJnqqVCwuAk/Bx4F3BXfjJpq2/QdqpsQp1rRwIVOKV6qkvBNDHLRQMjz6DGKVRsPfvW3GDIoqUgUdWswfqYWGx0FTzc+pPjfgizgtq4tmiO2f372wqWsobEWsJ1hJ72cIW0c/R9jTMwNbA7eY6OaublXGya/XL6caTO4ay5FfwOGjbyc1jD9P+v7PrHyeE4dvBwixnNZZb8NchT61mnNKwhllZgviGI6eSAK+eN4KjAemOQBVlmeJEzRApzFU5Jb3zeD35Dhe9gjgMCof2zK/cfgtpPshamoNvkwmuY6ywE+BC/s2pwujGCE8UGjUgRVg7AuRIZpji+7yu/isTEcqkOJ6PlVL5ZTGjbEBCKSGirrXWa67fhUSoktVPh1XmVNTa+QiDx5biyC5i57Xz4mKnV38YBHGdbchKpR08DWTccOUMUUGBSL/MhPAktW7jx9egNTRIAW0z4lrMXfKDYp6BEfb/FOYNzE3mAuZPYSDpyYnET+bx7QQPfIyw73cUQjuDevNDTKxiWxdtSk4ZPz6nrBLX55inu71wp/UCZP+JRGJuONGAzeCWYlIA8TG/B4/OUPwcKCyyRv1qrsRbTMWpK2JC7EOayTuI4QPa/R5lY
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0c7720-a47a-43d8-3f80-08dd867f3c09
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:05:18.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMzpKlQcr3NWN4JV0SKLvbm+OcYVZmGziwcGsytrWmXao9b/FxE5c8vnugI3ip8LkuVC+m9aO+0sc4l5Ab38DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8568

On 2025-04-28 13:59, Willem de Bruijn wrote:
> Joe Damato wrote:
>> On Mon, Apr 28, 2025 at 12:52:11PM -0400, Willem de Bruijn wrote:
>>> Martin Karsten wrote:
>>>> On 2025-04-24 16:02, Samiullah Khawaja wrote:

[snip]
>>> Users of such advanced environments can be expected to be well
>>> familiar with the cost of polling. The cost/benefit can be debated
>>> and benchmarked for individual applications. But there clearly are
>>> active uses for polling, so I think it should be an operating system
>>> facility.
>>
>> You mention users of advanced environments, but I think it's
>> important to consider the average user who is not necessarily a
>> kernel programmer.
>>
>> Will that user understand that not all apps support this? Or will
>> they think that they can simply run a few YNL commands burning CPUs at
>> 100% for apps that don't even support this thinking they are making
>> their networking faster?
> 
> Busy polling can already be configured through sysfs.

That's not the same. The existing busy-poll mechanism still needs an 
application thread. This thing will just go off and spin, whether 
there's an application or not.


