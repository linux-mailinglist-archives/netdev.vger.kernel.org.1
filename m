Return-Path: <netdev+bounces-208138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA6BB0A2A3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988D8A83411
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3B2D94B4;
	Fri, 18 Jul 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XhYbWXF4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A6221F04;
	Fri, 18 Jul 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838744; cv=fail; b=O9AbT6WzVT8hriEJ4qlutrn9UgnJ+YUwb494ermJAKAsTuOS5H61or6tonP4KuutCVGLGkLEjdtNsAOi/6LEEKZM+nIlyrTqnFtG6mkmcOOLAlT2WumRpEKr8541gJqGfr7OEg39AohoVKonAhCDOb5SdPU92N8wvKRzL9vMUis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838744; c=relaxed/simple;
	bh=wizlfec4Q+rFdSiIDIKM4WEUrdmtlekJg2oZ+aWYBSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bs8Rz6t73IGOcqQyMuA08dspTpdLmdi2nokWBAPTopye5ZHLvcVPcBtSd72ZMv57yFeC2cWyYepAeClVEC8YyK2ekOSViQxtmP+rWZGyWUR3+IzgQcu9MMmJFYrlVmO9mI4CCXvoNk34aSs2p391/m4zWzV9dF+NBagsrH3jca4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XhYbWXF4; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DadR7Yw4Mzzm3nvz0hi0IAoc3JeKOSe7V/9DItouKnFyf0c6jgSlq0kUwD8ZrCj7UnVV5PNdgKxG2QEapyfYhy3FUpt0VgyhROsD0jcCQkCHsC0M3AcGi6amlxVdqArhcd38VlEg9JNcuKXIdg2PwU7UfVxuW1MB3WEXu1AmfeOUn4WqEsQisSbItJQU5elvyL+8VjDCHYyvCALAyAICahS4abj1gG6VyTtKEey8CQ1Gd3QO0RmoFPoycG8tPK+OOeXving8JICODQS2iOKrObgA2aoIMsu5ieFCEO0kLuYmNb4V9v6ujwdP/lzW5obHK7pjMIz9gJ8Pzvvl/3VRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YImI/g/ZSoXf6HNtrMNoX3JSUWhlidlSp8+GYuARRVA=;
 b=ENHBkRqCZyKcwdGFJzCv9WhegzV4C9Edw4RXSOCAZJTiZPxO2YMgx7e00FGIgWdHfGHBG3WYBFj8k8CaTDt9+yjuyd9Rgv+FGpAgJ6jNZCVS8KJZ4vZ979TNFiPFBzJYhkSsIMOdwqoQ/F/YPAlqbOGzjYqKkvdVGIjn4wkYAQ6SLhI74V46XOI71OnsXUBViKCBOE60lK0t2T22AM0tT+4jMib2EID5Kuy5AE2QOjZVUSPUJ1ZTiDhxuDoaLysV0moM9yFTmRGfU4QeG4aGHuglPPOOrOA9/0dayVOvgbysH1Tz0Vc6+oCP5pmdcOVraDKS/LSlXQFPE6sK3hbuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YImI/g/ZSoXf6HNtrMNoX3JSUWhlidlSp8+GYuARRVA=;
 b=XhYbWXF4khBBbMZtV8Nk6VcZYKo8idwRXLryCJRWh5UXOs5r+1eHmEzHeyOdXXagnZyamZgn4Rt30/CdgJV8BHqdRIfALUeBEISrxhoUxYzjLSf/4komrMMeFGGTYkoARbP5vdx1eD/yYQkMzw1IzPFOnU7hNrf4OI5fNe6mGHErLi77jMKjjQWURX0gG6O+hJrwzH6Ck8H81f9vt695Tqbv7R76VEXsDnMdlzAgHYUiJiP3BDZgb/QTfj22b4igeBF/ErSJTaChem107qxbWflGVt6IH9f85sf9eM7B541K+9oKwtGg0ubXUvAMrDrAg1PPL5fcTKVPC3LTb1lnrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BLAPR03MB5554.namprd03.prod.outlook.com (2603:10b6:208:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 11:38:59 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8943.025; Fri, 18 Jul 2025
 11:38:58 +0000
Message-ID: <f568bfdf-31af-4589-97c8-744a63a2f67c@altera.com>
Date: Fri, 18 Jul 2025 17:08:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
 <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
 <74770df8-007a-45de-b77e-6aa491bbb2ae@altera.com>
 <ae4b3iobvbdyyijkpqhh4xv32rnfql2nvzmlzvmfbluefecy7z@t5o42w4orpfi>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <ae4b3iobvbdyyijkpqhh4xv32rnfql2nvzmlzvmfbluefecy7z@t5o42w4orpfi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::13) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BLAPR03MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d1f3b7-143f-4a67-a092-08ddc5efaec4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFN1a3VIdXFiQ3pxMkFHNXBldEpYd3FtYXVPVDZTaW1NYVZBS01ZbHhmYzQv?=
 =?utf-8?B?SlZCMDVDdlM0SDZwajNHbHAvMllWeHhOLzBhNXJObHJyQU0rM3VoZVUvemEr?=
 =?utf-8?B?WE1TVmd3R2RjQmZHNmJ2dTdkeTZhOGJSUXpGNjJ1bTBVVmZCdWVRVHdvYlhI?=
 =?utf-8?B?MlNDcExrZzVSM0FpWWIzWUpueENlR1IyQ2tyYm4xMUdsNmFEMU8rM3JuWnZZ?=
 =?utf-8?B?eHVmQnZ1VmUyaElNQ0VqdkMwSjdtVUJqSlE3SWNzbzNFaExhemNDL1Z5T3F1?=
 =?utf-8?B?ZHJDMGUrZnZnaFFDVEdIbm1BY2NOdUNodEQvbDIwRUpTVGtUeVNJbTNZN0F3?=
 =?utf-8?B?T0ptV1lqWEw0RkI3QVY3SWRTL2pjY1libDgrd3gvY3NURXRXdE5hd0Q3eklI?=
 =?utf-8?B?QmE1M3VFL05SL21KM0Z4eTJHNVJ0WC93MnhsdzJXeWsweFI0Z2FNTHdSTlh5?=
 =?utf-8?B?SWZ0N1FLdE5POWxWTHpWOWE0QXE0eGdFRGV3OTVHUXAwempWdVRCYXVPMWpN?=
 =?utf-8?B?V1R3Tk5yNk1wamtNZVVVc0lXNk5qdjFVdHRtOTlMcWVUOW1maExneXB0eFlx?=
 =?utf-8?B?c1FPcWVGOGFibC9TSXJEWWNyY3VzcWE1SllZNThKbGQwSVIwMTNIN1dVc2Vl?=
 =?utf-8?B?WFkrdG8vRHRwcG1mUFU1R2dsclUvaXRTdUlnaXlET0t2Nzk4K2sxQzNNdEdy?=
 =?utf-8?B?d0dWVkxGUUlNOXNDL0NOYmhnNHdaUTJQeCs4Tk5RSlRVWnByL1UxZEkzRjhS?=
 =?utf-8?B?bXk5Wkc5VEdXME1hVkdDUEw3MUVMZXZhc1RWeGxxQzR5Ymk5OUNpcm5mNUUw?=
 =?utf-8?B?dVZJbjVaWndCM2NWYnh5QTRDQjh4Y2QxR1F4ZXVKS2x1dUVtb1FNTllNZkxN?=
 =?utf-8?B?MDZJMEZUSmpjNHgwNWVOQW9ab3Nsc1Z2dU93Z0N0a1dIaUdhL0NoWUhKdDVj?=
 =?utf-8?B?ZzNhRXNZdy8wcFpzNlZQYXpMTG9tNDk0WllPcGlkYTBuSzA0cjVNVWpaeGFt?=
 =?utf-8?B?cEtTZy9UbmZ0c3V1YnVpN09VNlduRHRrVW9DUnViQ0txb1M2ZjBKc3VRNit4?=
 =?utf-8?B?dC9GWVlnNS83YVlyV3NkR2ZBbk5SdG5scmJmOWpFdXoyaUtzczJFK2JpWGp3?=
 =?utf-8?B?aTNDTGNYMW85dExhVncrUFhhdmo2eHZWeGpQNG9XN0dzRDl4Q0FUbU5JbUFT?=
 =?utf-8?B?RysyZ1EyakYvSUdlV0pKa3NtZ0g5aENpRHpxTkg5SG9KUWtvQXFkeHdza1Nv?=
 =?utf-8?B?eDV5M2pSem8rSUdzR3FCTzcxMjgwWWlJUjJwWUY0bzZ2TnRIZ0FZaFlXN2ZT?=
 =?utf-8?B?cENicGlWNXVpY2M2VDFqOVA3NS9wVy9laTRDVVhzTXpqN05YU2lhZEZ2Qk85?=
 =?utf-8?B?am9OQjl1SVlnMWFVQi9rK2NTb2JtRTUxb3BKUERHQnpWR20wZXVzRmdUQVpF?=
 =?utf-8?B?Q2pteWpzeTRMKytSSFFBYldia1BucWJmTmNPaThZbTJnb3k3cGlldTg1ODMw?=
 =?utf-8?B?elgzNzdrRnU4UWpLV3p6aURqR3hYaWhEcDlndFJBckZpMnkrRGtQWWhsNDlM?=
 =?utf-8?B?cHpnZVZYbkYra0dDMWozZnd2ektRM0VJVzVOcnJYbWhSeVNSM3BIQWJsL2k1?=
 =?utf-8?B?aDhCcDVUS29OUkhtTlA5SEczQ1RydVdvNDhpMlZJK3BtRGc3eXlvNTNqdERR?=
 =?utf-8?B?V1ZSQldTdVZxVmF1cnBiNm9QMk9CakdyK3hLT21UQkVGSXJJMEJpblBvY2hw?=
 =?utf-8?B?OTZHQ0UvRHNlNkFoSC9iVE9DckRId1ZXSXhpNVF5WjhWYkRBcFlYZmFiLzl4?=
 =?utf-8?B?eHNvRWg3NGROZWovRnJsUnR1NkN6S1dXUjNGdU9UN2pqTUdvbDRJeHJhREFP?=
 =?utf-8?B?QVBUb2NERkx2eVVhcjNlQUNTdDY0VTBFU0J3V0ZlaHcyeDdFeHBjcXFnSCs1?=
 =?utf-8?Q?q+42rtYo8yU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sll6NXRBU0NwOWNwZWpoZ000RlZOcDdnUElPNzJaQXFRSExJRU0wcjRlT002?=
 =?utf-8?B?Y09nWnNhVXdkOTBtamh2MEk2TWFVN2ZyOGEvYWZJSjJHWS80V3lQRGlhS0RI?=
 =?utf-8?B?OENrUFhFVVBQY1ZqUDRINW5UYXA5L1NJaHhKNGtLUHcybUlSc25ucHZ1Ymdw?=
 =?utf-8?B?MnNhQ0t4eGlJSlV6eEF6N0Y2OFlXZ0hsSmUwSnJrQWpaQmxTbUl5aUdNeWYy?=
 =?utf-8?B?eldJa0NEc0lUelhFVGgwTGJQK2xHOThVSnFSeDI5eFJ5Vlp5ckRKVkp1T0lC?=
 =?utf-8?B?TFFIT1FWaVN4OEd2Y1hrZ3Bmb3VaT3libFNoQjNzRUVVNFl0WmRmSE8wUGZQ?=
 =?utf-8?B?emhIYkJjYXVkNVZkSGJ5OEtYWG1NVituSi82elBwd08vQzd0R1JLWjBocnBG?=
 =?utf-8?B?d3J5VnFlL00zN0tZaDYwZmZZMFJiTzNRclA2bVdvSkNjTEF5eDdGVTZVZTVq?=
 =?utf-8?B?cGdkYUxudXRkTm1QQWpqalpQTTdPVktwaWFiclhTd0FMSHgrZkpIQjNiemwz?=
 =?utf-8?B?ZjAzN1ZIam10TXFRQjVieTA5ZWJibFhNWTJMWXRrSkE1WFB6dU9MdXozZlh0?=
 =?utf-8?B?c1NmampqdDlyN2pzK1NXczlrYzdLN3g4b2thQTI1S0tHa2NkbFRRNzM1Rjdt?=
 =?utf-8?B?Ny9hYzlyYkhmb0cwOTU3aU1QVlgxOUtoRUpwSWVHMjF5RDlWazdQMC9hdjhO?=
 =?utf-8?B?UFlPYUpobG9hb0NtT3l3T09FMGVyLzc3dUtoT200VjJ6SmhKYlVnMTRKc2xC?=
 =?utf-8?B?OVNKU25uZFA2M1R1TFVTRVdaT1YwRGd2SWtKUUtGRnp0N1VyV3ZyMTY1VE9N?=
 =?utf-8?B?YXNrWWlTdWloQllvd3RFVnkzNFJEQXJpRHpCS0JXWGNFZGU0Q1EzazN4MWVo?=
 =?utf-8?B?T0VHYXA1NENUZDBMK2YrVnVoVituayt1VHpoUG0zazFoQkVycFd2bEJIb2dY?=
 =?utf-8?B?d2hjRVhyeVJoNCtUOWxoTnZPeHViRDlVS2p6b3NxekJHTndsL2Z6OUNOaGJq?=
 =?utf-8?B?cHZTQm1YWUZJQTd3Ymg5UXdRdGpDRkJuYmkrT0MrcHNPRjRHUkthUjRLQksv?=
 =?utf-8?B?TVd3cE5wWHVpcmJ0RWVpWnlSQm00a094dWZ4M3RiSEZIK20rMFIyQlF5R3Zq?=
 =?utf-8?B?TzJDaUdwd2w0VHp1SWtKbjVWZ1Zmc09jTTVMYUd0WDZ2ZHdjTmhJOXNudjMw?=
 =?utf-8?B?c1NOTEFjTS9VaVJwUy9GUU9XZVpsODJXYXdDeFFvZlFKTW1YZk1NeFR1ZENa?=
 =?utf-8?B?ZFB3NUxNYnhzK0p5M2hPcG5NMGgrVk4zSEt1RG1IYVd5VDhDbC9lZ2FRZUIy?=
 =?utf-8?B?Tkx0REFsempzeWdkZkVjbFQ1TmpDTEI3R3FIMjQ5eE5xT1hpNE1ZRUw5d0Qz?=
 =?utf-8?B?dWRzdmdUdEN4a2I5YTl4TkVtZUg4RFNNSHdqbmNGOWdnOXMvK3ZrSXVMS2xO?=
 =?utf-8?B?bDZ1TzVtWGdvblo4U3Roa2FUWENBMTRDcUYzRy9UdUdyUk1wdm5tdHg0azEv?=
 =?utf-8?B?RmJOTjB1VUhPYVIzdm1HdDZhaWJHWWVTMGJLL2hiSWx6OHlqeGZlNjJoMGYz?=
 =?utf-8?B?VHEvU1lPZEVRV3hpd3gvYUxHKzI1cFZ5VXBCSWRZOWVmbHlGTUNaQ2lDR0R5?=
 =?utf-8?B?R2JQT3QwTlduSDQvVUlQQjVxV1o3RW1GcDdBUW80ODlQcTk3WisrQnVwaWFs?=
 =?utf-8?B?eEVObWx4WnlubW90UzBWSlN6dm9sd1NwNllDb2tocTRSNmZQQklBcEdmNVR2?=
 =?utf-8?B?TnlFZ2xDblk1OUY0Z2FHWjUwNjN2dWZUamh4QlR0RHVVRDBZRm1nV3BKdnJq?=
 =?utf-8?B?d2k0VXd1d05vUVJlY1lKQ0t0NGhHUDVSNDR5VWtlQWVMaVVReUJueXVQdVlO?=
 =?utf-8?B?eG9aK1Nod1paRHAvd1QrMUNybzA4aFlPblcwa2xzRlNqcXNZSU5QME02UjJt?=
 =?utf-8?B?aUMrVzlwLzlFb2c5QlBlZElNUnJsMEFEdElmZktrTS9kcUdZT2p5WVY2Vm1x?=
 =?utf-8?B?N3pScWdGNUVXUkpOdTVjcExoMUd2dEpPeHNrQU5ueHhDWVdzNVdjSHUyTGxK?=
 =?utf-8?B?dVIyOTZWYjM3N3UzVmRWK012Ty9oK2Q1b1JkazFPN0FLQkRSMVowRFNKdTFC?=
 =?utf-8?B?empkSTZLOEozbi95cVArZHNFTEY2QStxVXYvaTNHdC9oK3RYcDRmRE1GMitz?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d1f3b7-143f-4a67-a092-08ddc5efaec4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:38:58.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr4gVd2AaUHIkGAvP8iwF5GT8ASfVWHNPuE29BROKyFQ60+Rs5EGYq8vXTsm+N9u0c0XlWhO47w6i4OAOGBEtYWHONGVQga5dY/0csFDylk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5554

Hi Serge,

Thanks for the detailed response.

On 7/17/2025 10:52 PM, Serge Semin wrote:
>>> DW XGMAC IP-core of v2.x and older don't support 10/100Mbps modes
>>> neither in the XGMII nor in the GMII interfaces. That's why I dropped
>>> the 10/100Mbps link capabilities retaining 1G, 2.5G and 10G speeds
>>> only (the only speeds supported for DW XGMAC 1.20a/2.11a Tx in the
>>> MAC_Tx_Configuration.SS register field). Although I should have
>>> dropped the MAC_5000FD too since it has been supported since v3.0
>>> IP-core version. My bad.(
>>>
>>> Starting from DW XGMAC v3.00a IP-core the list of the supported speeds
>>> has been extended to: 10/100Mbps (MII), 1G/2.5G (GMII), 2.5G/5G/10G
>>> (XGMII). Thus the more appropriate fix here should take into account
>>> the IP-core version. Like this:
>>> 	if (dma_cap->mbps_1000 && MAC_Version.SNPSVER >= 0x30)
>>> 		dma_cap->mbps_10_100 = 1;
>>>   > Then you can use the mbps_1000 and mbps_10_100 flags to set the proper
>>> MAC-capabilities to hw->link.caps in the dwxgmac2_setup() method. I
>>> would have added the XGMII 2.5G/5G MAC-capabilities setting up to the
>>> dwxgmac2_setup() method too for the v3.x IP-cores and newer.
>>>
>>
>> Agreed. Will do in the next version.
>>
>> Will ensure that mbps_10_100 is set only if SNPSVER >= 0x30 and will
>> also conditionally enable 2.5G/5G MAC capabilities for IP versions
>> v3.00a and above.
>>
>> In the stmmac_dvr_probe() the setup() callback is invoked before
>> hw_cap_support is populated. Given that, do you think it is sufficient
>> to add these checks into the dwxgmac2_update_caps() instead?
> 
> Arrgh, I was looking at my local repo with a refactored hwif initialization
> procedure which, amongst other things, implies the HW-features detection
> performed in the setup methods.(
> So in case of the vanilla STMMAC driver AFAICS there are three options
> here:
> 
> 1. Repeat what I did in my local repo and move the HW-features
> detection procedure (calling the *_get_hw_feature() functions) to the
> *_setup() methods. After that change you can use the retrieved
> dma_cap-data to init the MAC capabilities exactly in sync to the
> detected HW-features. But that must be thoroughly thought through
> since there are Sun8i and Loongson MACs which provide their own HWIF
> setup() methods (by means of plat_stmmacenet_data::setup()). So the
> respective *_get_hw_feature() functions might need to be called in
> these methods too (at least in the Loongson MACs setup() method).
> 
> 2. Define new dwxgmac3_setup() method and thus a new entry in
> stmmac_hw[]. Then dwxgmac2_setup() could be left with only 1G, 2.5G
> and 10G MAC-capabilities declared, meanwhile dwxgmac3_setup() would
> add all the DW XGMAC v3.00a MAC-capabilities. In this case you'd need
> the dwxgmac2_update_caps() method defined anyway in order to filter
> out the MAC-capabilities based on the
> dma_features::{mbps_1000,mbps_10_100,half_duplex} flags state.
> 
> 3. As you suggest indeed declare all the possible DW XGMAC
> MAC-capabilities in the dwxgmac2_setup() method and then filter them
> out in dwxgmac2_update_caps() based on the
> dma_features::{mbps_1000,mbps_10_100,half_duplex} flags state and
> IP-core version.
> 
> The later option seems the least code-invasive but implements a more
> complex logic with declaring all the possible MAC-capabilities and
> then filtering them out. Option two still implies filtering the
> MAC-capabilities out but only from those specific for the particular
> IP-core version. Finally option one is more complex to implement
> implying the HWIF procedure refactoring with higher risks to break
> things, but after it's done the setup() methods will turn to a more
> useful procedures which could be used not only for the more exact
> MAC-capabilities initialization but also for other
> data/fields/callbacks setting up.
> 
> It's up to you and the maintainers to decide which solution would be
> more appropriate.
> 
> -Serge(y)
> 

Unless there are concerns, I'll proceed with option 3 for now, as it’s
the least invasive and aligns well with the current driver structure.
I’ll declare all possible DW XGMAC MAC-capabilities in dwxgmac2_setup()
and then filter them appropriately in dwxgmac2_update_caps() based on
the dma_features flags and IP-core version.

Let me know if any concerns with this approach.

Best Regards,
Rohan


