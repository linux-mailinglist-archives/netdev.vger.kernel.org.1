Return-Path: <netdev+bounces-206474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44FB03387
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23B11893A9B
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADF41FAC34;
	Sun, 13 Jul 2025 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="mD83lXmK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE719D8AC;
	Sun, 13 Jul 2025 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752450651; cv=fail; b=JBFtJ4iogaMBKfrds01gExbEDYR/CnjFbipb3IhVZ1apm+B7WJcXhOPH3FBgvlkmBdHMxEw303JaU1B2k6WuDKdvPeFRl5AqejYmrNbAmGqLwarRqRoN02csDgkHyoj/cRFNi5mG+HcE8kecZ5ZrYc1jvyeFdKs919M5qZyNvoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752450651; c=relaxed/simple;
	bh=8bVOEC0R8nxRrWIIay7ATSVV6fQDUozaAqRnFct9AiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UbxYhN+VsJPQADOE+JdsZBYj/t3oSvTqLs/p73pBZmFloOCige8bx8jV3h3eQToDzLyVlZKDowtU4TwAEjRWYHECxuNQ0KUTGpG5N7+ed+3CGJ6rjzhwmVNu0kI24ikWCljCz68cVNB9//oHqAfXkDSj9Em1ycKE7bt+rxujqoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=mD83lXmK reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUUer34D4cprr4HVOGzkmykwXgTMTYRN+sRehyFq4y42jedDwnJvHVnUivPWaqsqsOEoJUDMB9EZ0XqPcxTWQeDQocnX1l6nBFGcg4D0hLWyaAqy8p7KR/gjbGzUgZPvBC+TtodIHwKnVfAgOCbvP/gCeCOwBVCFuLTlC7dpVSqkFVWhrg6LFjsSw1nFx5k+I07BdDqj5gCWQiDhdnXAf9GS7N2EGxsfoZtIJr1I/VhNZ9DOZHe5xUpkIFEABoRm/mwFdlSLfSoPVIP9yWNzpI/PmJlmT5/Zt7LhDH/ET0hhIwh4bugnlsObh8TCrWiwEQlOKNH1zE+KbfvfS6GeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbnbIjZi+hQBL80A9ApAyG2K4Fc4phheLcZtAg+tVJ8=;
 b=mAX76Hi9IEjB/SOmBX3O106syqJsxEEd+ff4GzughWJ+hpF8KVHYE5gB6+HUhupsQUt0CMXpjcrnzyLlJmryCsLllhdyr4veUmCVB7MJOg9ijeacB1c1tt7SVEDlt5XD+b20WtVePHhUkzGGAsTatCtFBqOMQPaSPI1l4VgP7IV4leGfzmi8XPgRnC2p90/yfe+ZPSI3bEEUQGMZsezDX6FfO4NByi9+CZmDrnEJaBHgaZiMXmU3BShhuaYrDPEN2KY9HABXeX1uGFdEG4I6QEN2o4WX0OTE8S0r3LNu+W0aX5xSC+DQNWHh0/g6M2yAa+croMB5higR7MdyDm9odA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbnbIjZi+hQBL80A9ApAyG2K4Fc4phheLcZtAg+tVJ8=;
 b=mD83lXmKomNfohAHlrxRMn5M7o85vwE0fk52lroxe2uC6Bzu9m1+s9tl3X+TQL5mLxG4HteCsPuhXhy68zwkZnyx6nrpuDJJ+sjy339/sHzOBS87zJhHxfa2tTONmGS/QbefTbZfD8X0TZ5aTIqbcUOkYBdg1pqAYXFQT0h1/Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BN0PR01MB7165.prod.exchangelabs.com (2603:10b6:408:154::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Sun, 13 Jul 2025 23:50:46 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8922.028; Sun, 13 Jul 2025
 23:50:45 +0000
Message-ID: <0fe71acb-b8b5-4d30-93b4-21aedf2152c8@amperemail.onmicrosoft.com>
Date: Sun, 13 Jul 2025 19:50:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 admiyo@os.amperecomputing.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Jeremy Kerr <jk@codeconstruct.com.au>, Eric Dumazet <edumazet@google.com>,
 Matt Johnston <matt@codeconstruct.com.au>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
 <497a60df-c97e-48b7-bf0f-decbee6ed732@huawei.com>
 <a9f67a55-3471-46b3-bd02-757b0796658a@amperemail.onmicrosoft.com>
 <807e5ea9-ed04-4203-b4a6-bf90952e7934@huawei.com>
 <9e3e0739-b859-4a62-954e-2b13f7d5dd85@amperemail.onmicrosoft.com>
 <c2034f07-5422-4ab1-952e-f7d74d0675a7@huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <c2034f07-5422-4ab1-952e-f7d74d0675a7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:208:134::29) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BN0PR01MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 47198643-efd5-4b72-15e3-08ddc26815da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkFxd1U3RVBEZ2hsN3k4Sm5HK0lFckFmQjlWR2VkeFliTktFQ2VnRm1xeVBR?=
 =?utf-8?B?RHZWeEVabU1tNzNRRmhobWdrYlU5TW5PQ3ZmUG5HUTNMeTdKNUJ4M3JyKzhV?=
 =?utf-8?B?em1BMzhOb2tqT1pNdkw5WXJVQXhkT3J1Ty9zdG9wQ3JndG03UUltbDF1OWdV?=
 =?utf-8?B?MTNFaXV6OHEzeWlhNmlOZkFOTFErTlFES2ZqdFRoRDZuZnh5eUZkVlVjM0Zk?=
 =?utf-8?B?S1FzcUFJdEFDdlJlUkpiT2lIWkVnUElaTjBOWUw4bGc0ejE3dGVjM0JxQ1hv?=
 =?utf-8?B?WDZ6U1Q2MnhWbjBQV1RWQS9xRmxjbjdLMmxDWGd2a0k3SXBydmNZcG5md1Vr?=
 =?utf-8?B?eHZMSlJxOGx4OXJVaWJyQW5KOU9iK1FuNzRXUEJaY1VyWWZZdEF0TThCN1hz?=
 =?utf-8?B?WUE1bkhTM2Rta1F1elZveDl6M3YzRGRKV1hYMzVrMGltaWRFaWVVdFJzT2Zk?=
 =?utf-8?B?MkRmNVFQVlRLS1dza0VpaFRPN2pRSlRpMlhaT0t2cURaZUhZYjMwR3I5ckE5?=
 =?utf-8?B?ekV4SERrWk5oSk4wYzVXbWtrOENmNXgvSkhVbi9NYVJGS2dOcGJqZytZSzEz?=
 =?utf-8?B?ZUEvYnFHdWF1cWpCRUlxOExoR3pNSGVHVzhSTUFIcTYyTkZJYlUvOFdvaFlm?=
 =?utf-8?B?U0E5RUtQTnBhZFdkOU1uY3NVWHlJMllLRWNUajViYjRkNllENVQ5cVdCVDdU?=
 =?utf-8?B?OXU4SU5MczJ1RDg3OHZxeU82dkhJc1p6M1FvcDdZaDFsU0cwZzQ0TVEvZ1Zr?=
 =?utf-8?B?UFlZeDVBeEE0WWkvcm42VFJ0eG14bXprZjYwM2l2RDg1SEc1OGpZQ25vVFJT?=
 =?utf-8?B?RTJuWFBjTlpnZE92SVA4aHV2UTh2UzVJdERaZW1lUXIzWlZMSUJLTi9KTTJH?=
 =?utf-8?B?M1liaHNEQWwrc0tlWjJiZjlEVW1xY3g4K1ZtaHEwQW5LUnFEZnFsdDgrM1Q0?=
 =?utf-8?B?cE92dm9PVmN2T0tIY2dHMkRiYVBER0VKeWlaWldFazlYbEpRRndPSTJjdUN0?=
 =?utf-8?B?cDk3dUNNZitBeVI5dFNOVU84TlUzM3hRZk9mbTJobVNpS2o0bnBFeU1tSFE0?=
 =?utf-8?B?ZW9YWmdnT0tQRVFyUHFYczJLUXA3Y0o1Ly9wR0RjRVd1b0VxRE11KzV5NGNX?=
 =?utf-8?B?cmliaDlEYXkxMGI0bUFhR2cvV1FwMjUzYldsUWtKMDZ0K1FmWFBVMVJrSzhT?=
 =?utf-8?B?MTlxdkc4RnV5aEgzNkFaNGk0Z2sxQXdxK0xHbEVpRmdHaENvbWl4QjBaYjFp?=
 =?utf-8?B?UFgvcTk5bjYrSFpaUFRHVXhJNnBSMGVMSE5yanU3Z2F5ZGYvZnNaaE40Wk9u?=
 =?utf-8?B?N2lNTUhmRStjaFg4bWt5cUZvL1AvMHZaVW9SY2dGbjRBa296R21wRWtxMTJ1?=
 =?utf-8?B?V3lrTTBlOVdkRXdHSGMyZ0p3b2hGRm8rRUtpcXVFOUEyL0UxUU5pTnJkUjV1?=
 =?utf-8?B?MWlFbnJFZEdRa2tBbWtiUmc5TlVRZFI3Vnd1YjV0MGcyc3V2dEtKZ3dYMng0?=
 =?utf-8?B?WWNCbnlsaFZZMTZibU9kUzFKT2VmMERDVWg2TXJiN0FRZ2ZHNUc4THVBQWJL?=
 =?utf-8?B?MitWdW1IYVhFTjhrU25MWHpuWnFCdHJ3OVRBYXNZRjdnSDdoNnliRmhSeDc4?=
 =?utf-8?B?VitBRkJtY0t2eGllUkFncVFBUG5QdElJK3p5WmorU29peCtZLzFMcEFra1Fz?=
 =?utf-8?B?RlJwc290cVN3cm1pcEl1YUhNa0NxQmNKc0RraDBNR0gzZEUwaXVpaCtSa25K?=
 =?utf-8?B?bC9qTnZrK25IV1pTVkxaM05zUzF6U05tMXN0c09Gb0toTVdtVHN3b3J5aWVO?=
 =?utf-8?B?Vkc2UFN4SmFHUlZROEhTMnpGZWVtTEY4ZjZqRzRNaTh5ZDFaTEN1VEJTV3hS?=
 =?utf-8?B?Q1JqNHlNSTBRNXF5UTJnVGc3TWw1bUN4aEFJS0pzVmFpcU9Ta2tXaFc0cTZt?=
 =?utf-8?Q?T+QYTrtLnAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVFDRVdhUmVjeW9OaDY1NGdqU0tpVVVEdkxHYkh2dEg1VzVWbWdnQ2RoYmtV?=
 =?utf-8?B?elB6NjVJZ2lDWVlsUGJFcllqWEVCOXJpalU4cjRncFZJd3FkdWVmVjFLK3dF?=
 =?utf-8?B?OXg5OUF4MmhZOUtRRFRWSTVSLy9mUU9LZWV1WC81TEFjVDJtazZOdE5jWTZ5?=
 =?utf-8?B?dTlEaUpScVpoay9lcmxPUjlJTVdxTVBvdlZja2tiUDYrbDJVZmthOFdxOHpX?=
 =?utf-8?B?S1FIaVZEL3IvenA5ajh1SEEwcW1zdlRCRWYybTUwVEZRVlIzVDE0M3BlcDls?=
 =?utf-8?B?SnREcmtYZG8yM0pMcHIrWGJuWmhiVjA0N2t3VUppM3hTMS9sejAvODh1NnNN?=
 =?utf-8?B?YXgvLzBiZ2orOUQrQ2QxR00wRWlZOEVnaXVqTy9MWmd1U0FVRm1veXNxZXcw?=
 =?utf-8?B?UUcwcFpXZzFuN2lWS3pSTWxLRG00VkU0MzMzTVJLS3hnVXFwR2dVaEtreFlo?=
 =?utf-8?B?QkRhYmVicktvSUd4ZmlPVWRsUGFTOGFnSlRtanM4MjdPVnY4eW04ZlJrbmd1?=
 =?utf-8?B?K2pnckt3NSt2bnVKS0ZZVFJLWEJac25iUldYOHBvS1N6S2lCZndVQlp6WUxX?=
 =?utf-8?B?WmhNN1NmRG14czRvSXI1N3hmSWJPbjB0L3ZSa3FVbk01OG9pV1pCTUNqS3Mv?=
 =?utf-8?B?SWlPSzFsTmpwTmRQVXpVZnA1QS9OcmdMSkV4K2E3Sis1NHNxeUlPYktGeitm?=
 =?utf-8?B?bHhNK2tPVlRnd3EwMExjRmdxWDBVOGhoWExQVllJYXg1RE15VGZZUVBJNDMv?=
 =?utf-8?B?YWtFekhBVU9TNlpJeFIxMTRkQUJINTl4S2xob0FjaEhFSGY2ekpKK0c3V2hJ?=
 =?utf-8?B?RjdIcWFJK0JERnlvRS91WDhzcU1DbExjL04xc2VKaVB0VEpzVVhLZGpTOVI4?=
 =?utf-8?B?aU13VVVIZGVhaThGWFRMVGsyaThSYlJtNGZWQ2Nxa2s4NFpMdExHbkpkWkhm?=
 =?utf-8?B?Tll4dzZoVUlUMkNWSmZGME5ldWFSRDNMbkJDYS9IQmx3Wlc5L1VEYklkcm9T?=
 =?utf-8?B?VlRONlc0TDBhVzdRaWozeGF5SWxTcGdNR0hHN2ZCWTJtc0RqQlhCSVVjenBJ?=
 =?utf-8?B?dnpydm8rM2IyU0RBN1JlYUQzU2hua1I4ZDhZUlUwUGcrOHd0RHFwbkpRdWs1?=
 =?utf-8?B?WlBob09tREdMNGtBWjRUV3REd0tnbWtzdEFQMkpaSGUwYk9yUENiMkNiZHcy?=
 =?utf-8?B?eHNkVTkwWEJaZUdEKyt6Q2p2ak1zV3M2N2grRHF3Q0ZvTHdBZTI4eVJPM3lP?=
 =?utf-8?B?WHFNYWNSd3JlMEVJT2R0NnZiQVFUa1VGQlVDdHFmVVF0MDFMVWx5WGM5TjRQ?=
 =?utf-8?B?b1FvNzBTSFR2c3N5Q2EyZGpkRHpXVkNvSithVXhhQXcrVzMxWkZlS1Roa2h4?=
 =?utf-8?B?VzJ6M2FQSTNhRzdDZDBXSnF1bjZ4WWQ3QjI2TkVQUXhsQnVjQzZoWUlkcGk1?=
 =?utf-8?B?d240UkRHcUtDZ0NvM0k2MGdLWWdqMWRkeVd5R3F2a0lrVkpXbXpYWUJteEtD?=
 =?utf-8?B?Z01lWTE3bldTcnphM2FPN1hOa3Bac3ovTC9BSkx1Zzg3aWh6STZEeGdWVHU2?=
 =?utf-8?B?OVlyZWdDczhzL1QwSmZNa3VuUVIva2lrckM1Z3lvbmRyZWtuWXIxQ2hOOEMy?=
 =?utf-8?B?Nmd5VnliT0hrMlNrZFB1bWhneHR5enBVQllUV0FCT05DYldsbGlTZXZ2cmxU?=
 =?utf-8?B?Y0FRekxBUURNa2M4NVpEb3BBVGtPLzFObm4vZTJwK2s3RUo5ajcvVFFGQ1RQ?=
 =?utf-8?B?eFVKQWdBWHpxNWZCMVpZYUp6Q3NvdUh0SFo4Tk5YbEUrRzVIbFROQkhXTWJ3?=
 =?utf-8?B?NFZvWGpQeSt6WXF1MlZ1WFBJVjRCUE5ocXhWVngwOUNDQUlxLzVKaDdQUkxv?=
 =?utf-8?B?OVk5bzc2cEJ5WS83citZT2UzTnlwTDVZdk5rUE0vbWJOeWo2L0VqRHBzNno2?=
 =?utf-8?B?Z0pjMXJvY0FJZXhldEU3bEx4ZmtrV0NCNnYxbWtBV0tubmxjbUZ1S1Rhakla?=
 =?utf-8?B?RUdYdDRuL1A4eE5iZjNMcGtxcUR4Rm9DU25jRjRzQlFKNVQ0M0ZlQUZkWGV3?=
 =?utf-8?B?OWFwRjcrQ21EbEJUa3pVZUJ5V3Zvams5Tit1dW9UbHpRWXJSMnBkVjNFTHNa?=
 =?utf-8?B?Z2NURmc0a1J0YSswMHhudVE2aDRQSDBPOWZ1aXRYRTRMUzhEemwwQXkrV3JT?=
 =?utf-8?B?aXNCaWhORW9lcXlZOFE5Wk1SQkVtRGdkUDJaZ2xOUmdYL0FKRnE4TGEzK255?=
 =?utf-8?Q?khuJTUva/NpR38cKmCb5TS9p3t4dW5UlAwnlGjOl5A=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47198643-efd5-4b72-15e3-08ddc26815da
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 23:50:45.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IlsyWp61uzz4GP3kDk/7QLaFizXGC4a+207ukTwEpD9A0yesQrwdOsUtQo4tK9YBSZ4oLPyt0eleQI0HsFCpf1jVgTIXAlUpB425uRP20uk9ysBViqGO8t5AFNwXUyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7165


On 6/3/25 08:03, lihuisong (C) wrote:
>>
>> Once the memcpy_toio completes, the driver will not look at the 
>> packet again.  if the Kernel did change it at this point, it would 
>> not affect the flow.  The send of the packet is checked vi rc 
>> returned from send_data, and it tags the packet as dropped. Is this 
>> not sufficient?
>>
> Yes, it is not enough.
> Once send_data() return success, platform can receive an interrupt，but 
> the processing of the platform has not ended.
> This processing includes handling data and then triggering an 
> interrupt to notify OS. 


This comment caused me to rethink how I was using the PCC mailbox API.  
I realized that it was not actually enforcing the PCC protocol, which 
you identified.  It lead me to rewrite a postion of the PCC Mailbox API, 
and that is in my next patch series.  I would appreciate it if you would 
take a look. I think it addresses this concern, but it might not be 
completely transparent to a reviewer.   I would greatly appreciate if 
you were to look at it and confirm it fixes the issue, or, if I have 
missed something, let me know what you see.


