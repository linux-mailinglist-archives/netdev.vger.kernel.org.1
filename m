Return-Path: <netdev+bounces-171327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57634A4C895
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8041518875D0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30A923E326;
	Mon,  3 Mar 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IVJnIxhc"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013077.outbound.protection.outlook.com [52.103.74.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C423C8D4;
	Mon,  3 Mar 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019872; cv=fail; b=QI0PaqPC3kipzsmrTB3iZj9NtNuD7gDVySbKssTmtd5olz810O9g6mHxsZogZxz+3iQDmbza1mSCjSU+L+NVeC0syfpXxoZJGJsz0FHhWdxaaXeij9t/g0IfJkqy5Lf83DFYJRProydssxX+WUycLR9j/V5v0uTMxPc9IYfWD50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019872; c=relaxed/simple;
	bh=ZzMuHtft7RFIPWd0SGwfSwlIr4jft1YI7Gdwfq947T8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BlM1mmh+0H1Yvg30/m/nYZDS7MhBf/XBtjICDd3cYW1chrvl24Aw5/h/rYGD0q098Y8iZlp1gGmxU8dBJRKRQKIkvbooxB34ZTVPKWxzUkf+3bV0jSN6ICMsMvfVRqrytZNCedMDdAFSdf7+/GagqjJcGb4+xLGavhYUo0LUTt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IVJnIxhc; arc=fail smtp.client-ip=52.103.74.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWX6nZHLW4qgHZ8BEOa8Gbd4a4aBlTIMA5+uls2pJINHMC1A7BvTgCKwRUir08ms0UDi7JJ5DKgGW7oAh7oMhF82ACieCP8/NdmJXMzlzysRVPKD5YkeDO5MBZRleHHPsuKz+oOya9JqfWc2LkeUzXL3N2cFOMoS+naq9oyLYf/tayXCFINMG4NkWO58k+BpuVA9qx0QZEOn0YzIbGXdt8q1nww1ulLuvQKd481XQvk+TYlGfUeiNaTgPFcUO6Dsw/Y7gEnw+aH2TXU2swmQH/+zNJvInOIutYyzK6OcUJkgY1WJ6eU9ydBSKcl1R2F/+iMeeqJO0Onu+b9s2nzIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHHHAjBwBPOW5apZJ+ZViucjtSoJjqLL33d6UMPlwOc=;
 b=d+Lk1cQ3ZQL6sERKT8ZZPjTctO4G8WNhsGV3f8DEPEKT9w5HRu9G9AW0elQjJwanCp2QbPeZhseXuuTYTVTxwi+1NIfOaOo4SUaZXqz53Xz6/dgj9htRuYmf+QpTfoUgQSGazm5V2bF/8fwU35EHtfUKIGTV+14FO4W3yQxkJ3nNgZQDm7klVgYJozvetOPYqTas39inMvV4mQleR/KcsfdrLpWVsmHdx0NRrIcXqynfNiYhMqd5tFi1mLddLw6imqfgtLy9157yfr1p5AUZH6FGB6y+CmU9b8sN8c2tLJ1kXXcZ0I9w6XhO9habvgBtxeAVGyPf1tZv0mFEDK5Hvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHHHAjBwBPOW5apZJ+ZViucjtSoJjqLL33d6UMPlwOc=;
 b=IVJnIxhcckYvkNv4bDy5ocNqHy3Nje/FkXiNJH2SBvzPdVVQUouK0jZh5GLEpmA1zAp1DuCgmk/sZF/2OL7j+vTWoWp/q0/3Zw/hw6MObS98n+ZAPb4KGDbl2WR0/7rH2qd3Z1S/u103KNFo6G1WYo+KJpSgnnE6oe43D+S2qsYBgwgxYeBcg9T4mXvLBHIbH0J4CYfCTdsRABnQ3ASm2xF5I905iXSJz3DUDhXUShMJhuTRH488JurnOgeIPNUCl8Uy4ORfjSaxhjKJHI7aKd8yXcjFuooSkNt94mqH0quDw75sg0XOBPifoyHMlJFZWv8yKfPP1ZwctRWbe8ajNw==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYZPR01MB5040.apcprd01.prod.exchangelabs.com
 (2603:1096:400:258::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 16:37:46 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:37:46 +0000
Message-ID:
 <TYZPR01MB5556C13F2BE2042DDE466C95C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Tue, 4 Mar 2025 00:37:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: qca8k: add internal-PHY-to-PHY
 CPU link example
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rmk+kernel@armlinux.org.uk,
 javier.carrasco.cruz@gmail.com, john@phrozen.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <ae329902-c940-4fd3-a857-c6689fa35680@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <ae329902-c940-4fd3-a857-c6689fa35680@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To TYZPR01MB5556.apcprd01.prod.exchangelabs.com (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <b308e295-1801-4b00-b468-613a02440962@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYZPR01MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ff7dce-2074-4666-7139-08dd5a71ba18
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|461199028|5072599009|6090799003|8060799006|10035399004|440099028|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1JFaGJXMkxVU3dPSmlSNEtUM3hFSmhRM29jVmVzUkhSRllDc25hMHIzcWFz?=
 =?utf-8?B?M1l1cE1UR0ZJL1FXNFdGVC9Hc2kvNTRlejEwTW14YlJJK1hGclF2OUtiWUdJ?=
 =?utf-8?B?S0dzTUpDSWhoVm1MaUV2NmNvZUF2Vjl4SStoSnAzQWFvbjFGdzZFLzFwWHpk?=
 =?utf-8?B?NG9YVWcwTS9VVGF6NEMzWGRnc1BpWjNOTjVrWE1DdzRHenNXdGZQQS9QRUNu?=
 =?utf-8?B?cmpic1hYSWpsS1ovckxqZUUxemp4S0swSUhham4wRzNJeUVvemNnUlJieG5o?=
 =?utf-8?B?Ris2RXNsazV3aEIxYlFRNVVka0pNZjlDajNXWDNwZlZGK1NRWnZPZ3A3cGJK?=
 =?utf-8?B?UytWOE1LU0xTYzhkdXRGZjdrcS9IWDBFSXdpeG9VWmZaeWdVNjBsZWNXZ1A1?=
 =?utf-8?B?L08wUlhxSUlEaW5WL1ZoK3JKNHlPZUNYOFR1dW5BbkZ6YktTQVJFWFQ3YXVV?=
 =?utf-8?B?UXNOK1NYVXV4S3pKVXUzcTY1S2g3TTg1OVNxWEVKM21FdVBNWUdSdXpoUS9k?=
 =?utf-8?B?eHNHVFZYbDV3aWNIZ1Iva2VubEhLamhhRGcyQzEvOXlxQlBOSVZGcFdKVHBh?=
 =?utf-8?B?cnI3U29jQzlXTWI5QzIxNVhLbnh5VUhlNEVMU3BNcGVwLzh5OG5hNGxoUlMr?=
 =?utf-8?B?NFFicHo1ZVRVYkY2enh5YU9sc1dpTWdtalo1MzBPL25jZzUrSlVCcU5FZHdx?=
 =?utf-8?B?SXByVW0vVitaeU9wdzRuTXdHNktIUThnZCszLzFadExYNmdUUlNJdmxUM2Mz?=
 =?utf-8?B?MFVVcmZsall2NGhiYXFrR24vLyttbnM0WUQzV2hBZytJbFgvcmdZcjZPV21t?=
 =?utf-8?B?a1c5YTRsNjV6bzVIODNzT01haVdvdmhYRHVhdnM3MUVoUlNqejJLMFQ5aWNn?=
 =?utf-8?B?cmRtY0h0S2VlK0RNNnp2NXQyaXlINDJtaG5FOHlKckdPaDJ1S0lPVXdMOFlT?=
 =?utf-8?B?djJXN2J2R0R0Q1JkYUhwdXp6SUlnMENLWUNxbTRRNG5Pc09kaWFvK2dnaUlP?=
 =?utf-8?B?WDdiUUNRUGtJTVozZ28zRlNnSUQ3dmNSeUV0Y0NESHFtNTloZXpaOXdhWlk4?=
 =?utf-8?B?MVBaYStCSk5JOHBIaE5CbEZJZGNIdXNHSjB3NmNLZnJWM0JSczBxYWNNeUVw?=
 =?utf-8?B?cFZXbC9BY21zWVRrVHBRTXdnTkc1L2swQlZWZzV4OFhtYWQzTE94TWtOQU0r?=
 =?utf-8?B?QlBteHI0MzVIUW1vdzlLK0Jkay9BN2xWcXJ0OTgzTDBLWVA5Qk9pNUl0b3FT?=
 =?utf-8?B?eDBzeHNIdFdKRDA4dlYxU29QWFhNMzNaQjZvdG1QdS9HU2RkVXpXa20vbENi?=
 =?utf-8?B?SW5HS3FZTzdFeENoK0FGclVmTFFaOFRhQ1BRWGRjUi9xaStYQ3ZRNTkwT1k5?=
 =?utf-8?B?SVdNaGdDaXY2cXVyZzdUUEpjd3I4a3dzUDFGNnlDTzZuMzd2T3dabkpnU1Jl?=
 =?utf-8?B?aEhZb3UzVG9KR1hCa3h2N0JiSlJzZUVYeGtoMXQxblBtaEFSZEhPYy95eits?=
 =?utf-8?B?OEFtaVQ5UEQ1T2J3RzFnVnJ1akJyQ01Kc1htSUJYNjFvcXFLbElkeTlLaGZn?=
 =?utf-8?B?QW8vV0c1M3QyYmtRclI0ZWhvc3RMVXgxczc3VHJBT0NBejBrMTRPczdxN09L?=
 =?utf-8?Q?Ty1kcr/eLCZ1pvYnkvUpugYHSKD4EdGYdIjwlFvyKqbk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFMyelNNUTE5OFUvcWlIUVVCYzBOTGhiWnpKM2NRc0ZXdGRvME5UYzdwK0ZP?=
 =?utf-8?B?akhtZjVYUkVSd21ZbnlUNHBBQm41a2gvNU1PdVBMbU0wbGt0dnMvbTZITFZt?=
 =?utf-8?B?RmVRWmVteVlYNVN0RG5pS3ZSL09zT1ZXTGhPYmYrQitONDZVT2xnNEVnMUdL?=
 =?utf-8?B?THZyYzZjNmlNdzlhZzJ6QVlYdWV6Z3BiYkNCL0s5cDY5dEhPTC9wMHVxRmpj?=
 =?utf-8?B?NzZSMmdxSWdqSGVzR1lMcEhEKzFsSGo2N3VwcE56WDVaUWd6ZDlqbWxEdDNh?=
 =?utf-8?B?WUEzQTRrTnd4eVUyazZPS0NEYjFGNGpqMTFLQzhVK1EzMElkNDhURHpQSXQ1?=
 =?utf-8?B?dFJYNFQvWE1ENVE5VWwxaVdwTitrN3lqTEppdFhwQkxGM0pubE9hcWRaOUtU?=
 =?utf-8?B?MEM3aXUxVWRWclRZU3ZxL3NRVW82KzN3bVU2RUIrR1Vrb0dML05kSzVFQnUx?=
 =?utf-8?B?S2FYR2FJUG9qdVlUNGE3dENNWXJ4ZFZpakh6L3FhZkpSUVJkYlU0QVhlN3ho?=
 =?utf-8?B?bTIyRHExdHlxQjVNQ1dVRURnWmVTZzRiRGthVXk2R2p4Wmw5RkVHSVloem9q?=
 =?utf-8?B?aTNZMFFLMkVzUkgvMXpsdWYwWHorR2ZUUWhkYnVZUG9IbXRXM0hYdzdoa1d5?=
 =?utf-8?B?aTdtZVlEbHJ2S2l5aUVmbzBOVElFY2crSXhKU1RvRVJuUTNPZkFHeTM0TGli?=
 =?utf-8?B?N3l6SG5WUlZ6aFNZeFA5cC9JTUc0UlFoRXRrUjgzU0tDN1hMUjRrWldaWVFG?=
 =?utf-8?B?MHdlMEM0MGNSOWcvUVB1aHJnTEIzN1J6V2tkNnZOcmtuY3A1OEJ0cVQ1Rko5?=
 =?utf-8?B?Uk9KNEZIUXJRNUo3WnR3TnIxUHFuZEFXdTVxYUdNam01eTNZenNwdCtiUUhr?=
 =?utf-8?B?WXN4YmZVMiswRjdoSTBDRW9LZlpTMzBUSWxIMkVKSmZsSTVYeTE1MlprZnRE?=
 =?utf-8?B?eTRlazZlS3ZNOWtFZ0ZBdEhSbnFVSFpRSDBHeElKSCt5N0hKMDNTRmFueDZq?=
 =?utf-8?B?Z1pyL3pIOWNjTmYrYndITS81dExDQUhkcExRQnk0Uk1Na3pBRHVQQmJ5bmVX?=
 =?utf-8?B?QWFtYS9Ja1VwVm9IeE5iQWo2VEQ5b0ZMbFRKbm9jSk1IaXFrOE1lblozc25s?=
 =?utf-8?B?Wi9IQm9GTHVUZ3h2MUs4c1AyME5BdkhUU3JMME5qVmpZRS8xK1dMZFIrZVBO?=
 =?utf-8?B?cnRRZU53eFZoMi9MVDh0S3VibUhYN1RWVkNCSDdHUXh1bTliWnlMQkJ5Y1VU?=
 =?utf-8?B?MkdVbWJPS2pTc2xBVWtPUjFIS0pwamV5WEZncG5rMVNFc0ptdjJZK2RWamM2?=
 =?utf-8?B?d0FVeGFSRFUrWnhSbzFRdXdGRzdUSGo1cHBrUkRUK1Y1VGNwc3NOSWFaVThQ?=
 =?utf-8?B?WDg5M3BzYlZONGh1dXVISHNoUDFOWDFBZ2tqMnhsanNyRE1oQ0N4RytRRjhi?=
 =?utf-8?B?Y1plZU93U0FvV1VKQnlXeVVHbW81WTE5Z2p5UjVaL2xXNVZDYlhYUHRuWFJ0?=
 =?utf-8?B?ei9MQTdtR3M3T0xyanZiN3ZWR2RyVGlOMS94NCs3blYrUTM2RGQ5alRjbkJI?=
 =?utf-8?B?MEozY1pVT1pINWJXbkF4QURCNnNnbnhNUWo2bjlhVXpIZm5idXJHUy9BU0Ir?=
 =?utf-8?Q?PE0jsf+a/778zX4Qc46HuAfyzZHCKF6WgXsmZlqEek+0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ff7dce-2074-4666-7139-08dd5a71ba18
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:37:45.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5040

在 2025/3/4 0:15, Andrew Lunn 写道:
> ...
> 
> The previous patch still causes it to look at port 0 and then port 6
> first. Only if they are not CPU ports will it look at other ports. So
> this example does not work, port 6 will be the CPU port, even with the
> properties you added.

Sorry, I forget that the following patch is still penging:
https://lore.kernel.org/all/20230620063747.19175-1-ansuelsmth@gmail.com/

With this path, we can have multi CPU link.

> When you fix this, i also think it would be good to extend:
> 
>> +                    /* PHY-to-PHY CPU link */
> 
> with the work internal.
> 
> This also seems an odd architecture to me. If this is SoC internal,
> why not do a MAC to MAC link? What benefit do you get from having the
> PHYs?

This patches are for IPQ50xx platform which has only one a SGMII/SGMII+ 
link and a MDI link.

It has 2 common designs:
  1. SGMII+ is used to connect a 2.5G PHY, which make qca8337 only be 
able to be connected through the MDI link.
  2. Both SGMII and MDI links are used to connect the qca8337, so we can 
get 2G link which is beneficial in NAT mode (total 2G bidirectional).

> 
> 
>      Andrew
> 
> ---
> pw-bot: cr


