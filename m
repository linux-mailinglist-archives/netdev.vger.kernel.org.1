Return-Path: <netdev+bounces-228772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894CBBD3D1D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2E440493A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756C730DD02;
	Mon, 13 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="uy+bNG2r"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6E30CD90;
	Mon, 13 Oct 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366922; cv=fail; b=g5uer3DUQG9JhnEQRB/NvC0DmXPmSjnaRqDZgfNR2E7FSOD5omarub7lJB/APlPnNTO/IIikk1Dp2ZQZH3VNdzTWFWE+k0bBZqBPdq0jYbuiUNDOaBkgmTSMMNedRp6iPtRgDnAi0DDOlzN16D/Pt+0VF3Gp/FYjR3D9aSdYBkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366922; c=relaxed/simple;
	bh=D0obHARhOJ+oap5VYxOOkZ/904KDeGZZX3O9pbzKQ1s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGsrr38MKiQaxb7Bamq/ikd2njpQbX5cUk8GQzRf0PKEpXH/QNuGXzDX77mSXLHFrUKruzIid932gEJYqCcuqRWunBvAwXMhBjeoUhzB+n0je8/08bJrHK5ZImVwcix77b2r3DQgbqajBulMfqP7rHcxFHk5YORgnXUuauAe5t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=uy+bNG2r; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeYvK0hoQdSd1R1KflXRfqG97EJritrge99+RoU3juBZL2MpUWnXtSuhvzERapw9rYySV+XY/E5awkcEY0jUmQxCedcBKLtJ1mmDkpuiiXs5YVB8TzdZFlnFpdQ96HtPvcmdxaIN6GRIYNdWDwPmEVg70pN3fo4EdNbBwqy3+B4NeaYwBU04TzYdBIhOCBw1G3MT0qtBOstB+2FHbByW6W7DGiWGbxgpK/Yasx1Umk2yBPQ8t6+DqSunTWWbUbhFgsAb2H1Qa0yOt8qk+UZCHV3Qx6EWmnRnevxj4vFQm2gHjJF7thtr9CtT34CE1umpOubOMTr4bXAW2jtySgrCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACDPU+R5yzriQ1Lc4G5s5uOzsdvQ3fMYzS5539Ciqms=;
 b=ogD7H6mfkHLPFQxkpZv3LEC1MMJcDRTlmT8S/tW5sdAjNIcHb6o5P7UfL0/h7mjlv5bbTJ5/llj5SZYAfT9jsAp4Y6lGI2iEavZROBzBoI+4mfh5FqYkU3y0sFTUKTJmhi1JYiP5xmNTfkfOnd8eLSLb3bAB2t38VzBi+rNa8xVW6xAwOBxRZZA+ep84q4fRyYQ8a6kh7paYlPw1f0X3kYhcN3O8VOb16yCgQ8nrUulXjvQG80Paxwxivzk+uPnSEBJzCh+1czRqnDytq2IvwU5OdKZnXW+SoDZuoUPjw1TdQHK7VOq64AOjHmvq/nevhh2f4z9/JiY+xFHUVewlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACDPU+R5yzriQ1Lc4G5s5uOzsdvQ3fMYzS5539Ciqms=;
 b=uy+bNG2rO3VgkgCdRSWLDyMFE65b2OgIo6lc8nWR/eq0pOeLGK91g6Vmn/Trko8xWyv++1VbPy8bgbNlkslyuD34eEiYR8YCNIVNZz3Bko3eb/iV8U4vA/7MT6/+JC+lP/1+cAf/hbO9S4bxAhfehkQkACwcaSN4KWXZ6b7Apts//Mn6ydZLvrjbTiBULYwmtKD+0W2XtW3DLqDshQ9G0KP9hxNEXdoLT9N4n/7WpGa/aUVbx77XnT69u/hlGOtxsNJH7F1mSbBv0dEg4cXFbU/22zFWtZydsr9y2ZBw9XTa8HIpxVkimeo0zm4aRCYU1ToW0ZpGxax8u2cs0Jgpfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BN9PR03MB6073.namprd03.prod.outlook.com (2603:10b6:408:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 14:48:35 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 14:48:35 +0000
Message-ID: <4e7a20a8-5911-4233-b93a-d03693019272@altera.com>
Date: Mon, 13 Oct 2025 20:18:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
 <20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
 <20250917154920.7925a20d@kernel.org> <20250917155412.7b2af4f1@kernel.org>
 <a914f668-95b2-4e6d-bd04-01932fe0fe48@altera.com>
 <20250924160535.12c14ae9@kernel.org>
 <157d21fc-4745-4fa3-b7b1-b9f33e2e926e@altera.com>
 <20250925185230.62b4e2a5@kernel.org>
 <1e82455f-5668-41fd-bebb-0a0f7139cc3f@altera.com>
Content-Language: en-US
In-Reply-To: <1e82455f-5668-41fd-bebb-0a0f7139cc3f@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::7) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BN9PR03MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: f13f1f5a-6515-45c7-6521-08de0a679640
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y29MUHdQSDdKektRQ2RPY3BaWHNGb0ZUTWt2LzZGUzZlaDdUbG5lemd2cFZY?=
 =?utf-8?B?WlFuTWRVTjhFaWdhSmNodjN6MUNyQmZmQWZQcHpyUEZtWUwyUC94dFArdUJG?=
 =?utf-8?B?bmN3SkcrV3ZrVmpMOU8yUFJoOTdEV3E5NDROS05yb0JGcGNXeWZ6STRYRXhC?=
 =?utf-8?B?WVFtaXJGQWV5TjNlR09mcVNvK0JCNmFsaklDRUpiK1JVU1h3d1dPam5lWlBx?=
 =?utf-8?B?cWR0bnNrUm9keGVTT3ZvMDB1RU1RWms1UGFML1ArSVhEVGNnMU1kQW1pcU5M?=
 =?utf-8?B?OW4vaDB0RjRvRTZpVmtGTkZTaWVCdjFWaUM4NGhaTHhlSU1xbGlaVXVkNGZ6?=
 =?utf-8?B?dElWakIyOUIvMWJ6ZjNSclZCK3B4M3hiekM4QU9wZnYxZG55cDdwbWs1M3NB?=
 =?utf-8?B?SWJsUmlhaENDUndrYWNuWTRnQU4ySTRYRzZiQ2s1QWlSYjJEbThIcDdXZG1Q?=
 =?utf-8?B?aFROVlNNV1B6cWNzaUF1dFc3UlRJUUVaWHVGRXNGeENLUklINUd2eVM0eCsw?=
 =?utf-8?B?bThoMG9Lc0p0LzRObVlOanNORDVlSzFLdE9HVnpoWU10NHZRSTNaRzdFczFI?=
 =?utf-8?B?L2U3NTA1VmZIcXErYXpmUDhTZG9UT2FQMWxKcmxkY2pCZit2R0RrWUVQc1Fv?=
 =?utf-8?B?YW9rTGhJczhLSWg2eGFYWTJPNVl4cU5ITC83YXFFbC8vcUV3ZDRlZ2loMlV1?=
 =?utf-8?B?bHpmc2ExQ1ZKZjhWeVZGVjhLVFY0ZXF6Q3E5WGE4THJkV3RCMnZ5c3NZSnMz?=
 =?utf-8?B?N1grRmEwTGI4NkZHRUw4T0MzNk5RMWVlUzI2Q3BGMkV5dHhSVDdpaC8yVE1v?=
 =?utf-8?B?ZXA2UVZoenN4MTJKSE9hUGlIZ1JEeXNxOVBjbFJrTStHZjdWMmVjZ3ZmcE1P?=
 =?utf-8?B?ZEdjTGl5OFdoWXFmeFVLMjJSV1NGQ2Q3TXhyZTZER3BmVFlEc1cyendtN0pY?=
 =?utf-8?B?WHkyNkQvaDE1d21xeW1yd1dXejJZOFlkcTZIU2xLZStteGV5YkkvWnp5RFlG?=
 =?utf-8?B?QlJHQm91aFM5TEcvS3FMeHdNdWh5UEx0VUVrbEJzd3lzQ1FhY1Uyc0swTkVY?=
 =?utf-8?B?V1IwcDRJVkhaZDJIMFhWaHdpL0xwMzQyR1pGQW5Sd0RQbis1S2JFNkJtdVFJ?=
 =?utf-8?B?TlcwempRakxHeHNBSklMbytPMnFnM0pyOVE3YitJbC82dnY3UHI4ZDIyZExD?=
 =?utf-8?B?NGNHK29FQ0piT2gySHpCNUJ6Ti9wSzBHMTJEb3VMWS91eXVXZlZVUnpvNmRm?=
 =?utf-8?B?cEVTMWxRZXkwQ0s2em43NTZSY3NVSHlZanM0YjRqVlc1eUxlck5lc1JRd0oy?=
 =?utf-8?B?OWFYT1hua3V6WEVIUzVYMXlLbmtwWU1nbER6SlVueTJET3NONTNnVlQrUmlS?=
 =?utf-8?B?ZGJYYlNZay9Bck5QZ1YvejJxTG5hZkpzMnQ4aythdEZwaitlaEJZTkVCOG1h?=
 =?utf-8?B?YVFxbVNEeDE3MWtjZDZad0h2UHJnWjViMDFMbW9HQWhNUGUrNVRkL3dzTWln?=
 =?utf-8?B?RnRDZUkrR2hNYjNJRzZBU3JVdWRoMmlhZFE3bEF5Ylhsb1RiOUg1dlNROXFq?=
 =?utf-8?B?RzZKWG5qSWZTYkFTRjJOa0s4U2grcjErVkhpRlVsb01IRmtSM3FVa1h3SXNn?=
 =?utf-8?B?ZkNZZms4QjVCY010Q2dnN3lEN2NGcyt0eDFISENaNHpkSHdubWRISVZEcnU5?=
 =?utf-8?B?L0lMcHJRNVI0Yi9BbHhCYStPSUNPZnpCTmk5K2t4bURTbC9rSit0bVoyN2Jj?=
 =?utf-8?B?QVU0V2cxSThLUHM0YkI4UE40cFlaRytvWnkyZWdNeEh0RHk4L0RZZ1JTMjZO?=
 =?utf-8?B?SGxPcHJHOXliMFU0YURONTNtR3E3UEUzOW5SKy82QjhVd3pFYnZBY05LdVk3?=
 =?utf-8?B?K3crNnZLQ2pnWFpqSUJoZXMra25IcEdsVlJFODFXS1JVNGltSmV0VWJXWmlB?=
 =?utf-8?Q?jaOeo4Z6YbbJiRnvgknKqRwJMwO4oQT4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejBZNWl4eXM5SEpYbHp4VmRuRHBXVTQvdVUycCt0SXhTTzc3UWtsRytkbmx1?=
 =?utf-8?B?QWxVVG9qMU05RDVuUXluRnR1UEdIajNpWHp2Wk5QTUtVRll5SHNOUDdLeTBh?=
 =?utf-8?B?RXpsUkdlbW9PUlpDQnd4MGFmM0VJQmZqQ3RXVU00TUdTZ0hHVlh2Z0JVOWd3?=
 =?utf-8?B?Zy9OMzJwRVVGei9WMmlJNjVJeEJ0YzN1cXFKTGpMTWNjMUU5d0tTamtPYU5G?=
 =?utf-8?B?cjBuR1ZWNDZ4STN0WnR4cDZ1R3FHMXZOdmQ0UE5UMzlNTExnMER4dFBCZlcr?=
 =?utf-8?B?ckI5OTNEMFdZNlhyWENyZHI5YzUveXB2RjB6bFFXYlBnd3ZuK1E1Nk1NVDdm?=
 =?utf-8?B?U3pkWHdOcWNRS3FsWWRXQlR3eFpWR0hINWhxb21Pa3d0OXJ5NzJMSWJiN0ds?=
 =?utf-8?B?SThOSnhrU1dFV2lPdzRSZVFhTlRLcTFFb1dzbS95TzY3d2thVFY5K2trNnVN?=
 =?utf-8?B?UkVqWnZabmROdFBNdnZUQXpiVGJPeFpaUmhDWUdZbnZXTzZ1TVJXamlCekJ5?=
 =?utf-8?B?d004UE5FQWUxb1FqL29RTG5yNGNnNy9rZlNFWjFnRTFCY0ZLbVBzV25nUW1w?=
 =?utf-8?B?WnBiU0dSSi9ZR3htaE5DTFluM2g0a0o4MTlaaUM1R2xPRC9JV3RHQnR1MFNB?=
 =?utf-8?B?UmtHNTUzN3JkSXFOM0E5SkplanE1dWppVE51ZTdieXJuVndvNldvK2NhSXJP?=
 =?utf-8?B?Mys3TUZQNGVzeURWc0NjMzRVeXgyK3hHcFphWE5WS25rcEpmZkdZMVkyQ3V6?=
 =?utf-8?B?eDR0UnpzUUdkSE1XN1Y2UmFXRHd1Tmh3UWdNQ3ljMjg4amh3Sm1rcG5CUVBw?=
 =?utf-8?B?SUlDR1V3eWh3bjFDTTR1N3ZudlNtUTh4NWJHOHVWUndlcFg3M0RFN1V6K25T?=
 =?utf-8?B?RHBPc0ZTTGpiY2M1MHdDMVNBVFZnTkplUzE2S0NxMElpS2hwZ01KUDM0YXNp?=
 =?utf-8?B?dlVKMVpyQnQwK3pVQlcvN2o1OUYvc3JRSE5yL3ZsNlFRV0pKRVJ0eVlXRHhh?=
 =?utf-8?B?WW1pZlB5VWh6QVAyaFZuYTRLaHBUS3hNRU5UN2h2VUVQRnZpd0pWVVFuRW01?=
 =?utf-8?B?ZFBlcnl2b3lpN255NG94aWdXaVd2VGJzTVFGK21KN0phTDJiaDZWNzR3TGlW?=
 =?utf-8?B?bDMvUThUSkE0aWlDdlA2bW4rbS9EM1FJOWJjbGVxSytRMUJoUTQzUFBpZ3g4?=
 =?utf-8?B?RlNXV2J5TWs5czRIM1pYN0s1OG8xM25hMm1nYWlSTVdKbVp1TG9tbmRZcStH?=
 =?utf-8?B?YWJJYjY3U1BrbkVZQUNudVlub3BxcXhvTlJ2dGV3d0NUOW5HaTA1YTd6Njhp?=
 =?utf-8?B?Qm9WVWtpb2FPZkQzcUtsTS9pZ0VJSCtrL3JEdWsvWDJUSWJ4dk9tVSs0c0U1?=
 =?utf-8?B?cDZyaXBUaS9VZjMwYUl6SHNpeWFLNGs3b0d4MXJWMVpTTGFlY0F6R0JadDRx?=
 =?utf-8?B?eW1PMW9NejN5SEdZTDNwWkxxUVVpUzNhL1dTVjRIZlB1YUtJMDUvZjBuanp3?=
 =?utf-8?B?VC9haFQyM0ltNGhpQ1hUZWVVMm1TWjN3QVpoUitURWhmdk8xbXBKUHVCdlNC?=
 =?utf-8?B?T0h0RitlRXFTSVpIRGNnTjBrZDBaR0dCS3BZdkF3VktiMnY5OFlGUHVZdisw?=
 =?utf-8?B?djBlVi8waE9RODgrWmRaam5CRHNudWh2VlFrUEdtcU9qZEg2WkR2STdSTUZZ?=
 =?utf-8?B?WndoTEEwcWVnU1JnL2gzNm0xUFNSUUd3SnhLeEF0by9sRnpxTUI4WGppZTJj?=
 =?utf-8?B?bWtiMGMzVWtuaDM3Z2VwVWVIS2FhYjdsY0FyUElQZ3VucHFiUlhmYWNseTV0?=
 =?utf-8?B?TWpxbG5OL1NUWTJDaENBS3VLNjIxNGd3c1B5MURZK2E5QUNlbTU1ZmhwdTYw?=
 =?utf-8?B?RTlEbUhnNjV4eUZPREFmTmRweDFjZWEzSlN3WkRvM25MYXYvaDFQWUFFQXdM?=
 =?utf-8?B?aFpXcUc2Z1QvVExDMEVtUlYwR083enJGeHNXaXBSczRoVGJsaE1tYmZEOWxT?=
 =?utf-8?B?dGROMk1oTEJ4dEJsVGVSQzAwc2x6enlxWDI0czNZNFAwWUtLNDNwSG81Rmty?=
 =?utf-8?B?YmkyVWUwVHoyUTJ3aWk1cWlISGpuYk43OE51S1NNSkJBNStyVlRML1pINDJL?=
 =?utf-8?B?TzhWOVA2eU5YZE1ONUs2WDBkSWxrdDljZkRmN1pWRTEzZ1h3d0dCakVzek9R?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13f1f5a-6515-45c7-6521-08de0a679640
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:48:35.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss7gFUN/9Qj17+YqzP0PuBF20UXauw9w7+BXOJUf+4IL/xK4iMlLAYWCwXIe5V8YAbNabqOyxRJBFLij8I7Kyf8nYyCU6a/Ulm/dwIgyuRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6073

Hi Jakub,

On 9/26/2025 10:17 PM, G Thomas, Rohan wrote:
> Hi Jakub,
> 
> On 9/26/2025 7:22 AM, Jakub Kicinski wrote:
>> On Thu, 25 Sep 2025 16:33:21 +0530 G Thomas, Rohan wrote:
>>> While testing 802.1AD with XGMAC hardware using a simple ping test, I
>>> observed an unexpected behavior: the hardware appears to insert an
>>> additional 802.1Q CTAG with VLAN ID 0. Despite this, the ping test
>>> functions correctly.
>>>
>>> Here’s a snapshot from the pcap captured at the remote end. Outer VLAN
>>> tag used is 100 and inner VLAN tag used is 200.
>>>
>>> Frame 1: 110 bytes on wire (880 bits), 110 bytes captured (880 bits)
>>> Ethernet II, Src: <src> (<src>), Dst: <dst> (<dst>)
>>> IEEE 802.1ad, ID: 100
>>> 802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 0(unexpected)
>>> 802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 200
>>> Internet Protocol Version 4, Src: 192.168.4.10, Dst: 192.168.4.11
>>> Internet Control Message Protocol
>>
>> And the packet arrives at the driver with only the .1Q ID 200 pushed?
>>
> 
> Yes, the packet arrives the driver with only 802.1Q ID.
> 
> [  210.192912] stmmaceth 10830000.ethernet eth0: >>> frame to be 
> transmitted:
> [  210.192917] len = 46 byte, buf addr: 0x0000000067c78222
> [  210.192923] 00000000: xx xx xx xx xx xx xx xx xx xx xx xx 81 00 00 c8
> [  210.192928] 00000010: 08 06 00 01 08 00 06 04 00 02 46 9b 06 1b 5b b6
> [  210.192931] 00000020: c0 a8 04 0a c8 a3 62 0e d7 04 c0 a8 04 0b
>> Indeed, that looks like a problem with the driver+HW interaction.
>> IDK what the right terminology is but IIRC VLAN 0 is not a real VLAN,
>> just an ID reserved for frames that don't have a VLAN ID but want to
>> use the priority field. Which explains why it "works", receiver just
>> ignores that tag. But it's definitely not correct because switches
>> on the network will no see the real C-TAG after the S-TAG is stripped.
> 
> Yes, we are trying to figure out the right configuration for the driver
> so that the right tag is inserted by the driver for double and single
> VLANs. Based on the register configuration options for MAC_VLAN_Incl and
> MAC_Inner_VLAN_Incl registers and descriptor configuration options
> available, the hardware may not support simultaneous offloading of STAG
> for 802.1AD double-tagged packets and CTAG for 802.1Q single-tagged
> packets. If that is the case disable STAG insertion offloading may be
> the right approach.
> 
> Best Regards,
> Rohan

I’ve aligned internally with Boon Khai and conducted further validation
across various configurations of the MAC_VLAN_Incl register and Tx
descriptors. Based on our analysis, it appears that the hardware appears
to not support simultaneous offloading of both S-TAG for double VLAN
(802.1AD) packets and C-TAG for single VLAN (802.1Q) packets.

As per the XGMAC databook: CSVL bit of MAC_VLAN_Incl register controls
the VLAN type of the tag inserted in 13th and 14th bytes and CSVL bit of
MAC_Inner_VLAN_Incl register controls the VLAN type of the tag inserted
in 17th and 18th bytes of the packet.

Currently driver is configured to insert only STAG for MAC_VLAN_Incl
register while the MAC_Inner_VLAN_Incl register is not configured.
However Tx descriptors are configured for both Outer and Inner tag for
802.1AD packets.

Current configuration used in the driver is ambiguous and not documented
in the databook. So we think it is more accurate to disable
NETIF_F_HW_VLAN_STAG_TX for DWMAC IPs. Please let us know if anyone has
concerns with this approach or if we might be missing some info.

Best Regards,
Rohan


