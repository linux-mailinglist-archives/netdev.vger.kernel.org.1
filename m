Return-Path: <netdev+bounces-201195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DF4AE865F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746EC4A2DC0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC007266B41;
	Wed, 25 Jun 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cTHBNInf"
X-Original-To: netdev@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2128.outbound.protection.outlook.com [40.107.116.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BBE266573;
	Wed, 25 Jun 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861534; cv=fail; b=XG5JuB7bpY/UVQVGRsk6Zgg8Narr785oLgwRkaAuDVUTdL7Ual+zWxmG8q4R4wZmep2OU6Z0YvludybIypyLvsfNPcmx0NbTUYiN4Mu2uySRbUNlAoXg+Yp16YEUJcruxNn8XAsCZB42BcNFUXZYnFt90hV2P231X5J/0qtQuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861534; c=relaxed/simple;
	bh=UVJeHEANmJhiShEEcRqcHg9V54kkTkXTBvHbv6pY/kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HWmTXpqPVQ20ov+1EdKyzVpTqGa1+h/2CCzl3LfY3il76Y9TN4mcy7aC+JkWr8bc/H+tI6YEgzEBciJLwgZv1ITqsPJbtMBXEukHO2LeSBypTUZJoCKEieqUuTdR83K7iyypkaN9UI5AG5olduQgAZT2OVlHH+x4SjOyjysBCFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cTHBNInf; arc=fail smtp.client-ip=40.107.116.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgtwgxHkS74BpOM8TG62YzKJdgFteo1WnHLwhpKXqWw9s58HZTIBA148fAxoI2yAqcHXMFk9XoN2qmkMSYSL8cLSaqxVYBNxWM7hMqCB8cPn1dEQsiCMmCGCjdIcyR8q6LDQNCjJHbpRXAdCYWc65dZesMPbm4BZtmbyqEiAmUH7VsfYVHIC2+S5/D6dQvacCWMtpdNxToKzh6PqQuX08JkedSXR3D1JnELBrvQyEsHHSWqr4t/xXMgO9E+3ZvKzUSmYBPFMQVJXf3wmhFsJvQ32sMCLYBOzsydhj9iZVY/7An4hmmDdr8Rwz1TWUxpmkjAeKsk3kjfC/XJjUG47zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKVQlz4+BfabLbnRmgR69K+4N5v3Di5dQLnwTvKv9Ns=;
 b=RQtFxXxxV9i2ixiOu1Axc+MMxJ4yjZz5CuFJORY+g+dSs/ZoN50bQ+KqL+lDQc/ykLqkNQI7zRkiClz7+RnZZBPs8p1tqnSGHrphKIO1NGX7RRKpjlA0QIjSqP+WaHBr8X/EGAF2IH6Okq7z1wHb+OJuIWnwp0uDP8w76O2tFax/k8wSZvo1AVdwhI02ObzWm0l12mSId6E0mjuC+aqUm3EpuRH14aKnDwP6siuXG056vxIXspV1bMpArY8V8mFTnr3iXJ6yPQURZZ6PoFjtXRuzHiR9BCQeb1qB6V++osQ34CJY8tysmvrwcYek7bclbAOnbfsqs0wLDImncAznNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKVQlz4+BfabLbnRmgR69K+4N5v3Di5dQLnwTvKv9Ns=;
 b=cTHBNInfQCEs8dnXQUWHFaOfi8XUFU9BxGlBHEIrHWL9lqktrUktB9I62LjY4DA6lSZQIJkKafPI9CR00gJeEPeOoe+mF37wOQzCFur3QmGS8P924TZtLsFfpjUh4YwvjH3rWh4ulcV/xWbuMosmPXbZg84AD9NrtoLAR/qRof4V9p4IxfKMCr4lO8xdNQA+JVKAZ7VFEr5f5r7qjix/gG64KbKPymJsHu8e3qV+HnCBnA+sLllaLrwIrCp1bJp25IvDHsMya7DwTVF76raZAwvJmlGNFvK/pTHNgcPpO4sNwxs9hRgrBN7GQQAGCHQgoZvdEz7nKC89ag9KIw3apA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8208.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.19; Wed, 25 Jun
 2025 14:25:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:25:26 +0000
Message-ID: <3e2a80e6-b3c5-44dd-b290-1d140cc427ff@efficios.com>
Date: Wed, 25 Jun 2025 10:25:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] Introduce simple hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, lkmm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Breno Leitao <leitao@debian.org>, aeh@meta.com, netdev@vger.kernel.org,
 edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
 Erik Lundgren <elundgren@meta.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-2-boqun.feng@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250625031101.12555-2-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: d5694c70-1091-4045-bf51-08ddb3f420ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkFLSXJuZGZsbjBsQkRJZ20veDY3OWQ1L1hjV3BSWHhEMUY5UHJ4R2JoRlRM?=
 =?utf-8?B?QnpEYXZvQTFJbHVmdzRqQ0Jpb0pseXkya1M5SFZsY3NZaUpBcmpBUGQxVUNS?=
 =?utf-8?B?VHZ4S1FmNlI2TCtBNkxIeXV0R2QwU1ZDSHp4TVZyTDc2dGtyRVlMbzRRYWFR?=
 =?utf-8?B?WEZKNlN4TVBIZFVrMmJFMHBkc0hPYjBJM3BoMFRKcWxRakw3eGxtREFBY3dL?=
 =?utf-8?B?S3RhWXFlMUtQQzlFOE1iT0NKUDVtYXJCeEtLdVJBUzFpMmxFZGhEREV3bW81?=
 =?utf-8?B?Z2NwZVFHNTQ1ODl1U3JSQWVSLzFybDFDYUFMeVM4TDhsYnhlVXhkb3dxQ3ZH?=
 =?utf-8?B?VHlud08wM1RYMk41TGh3bzZ3WWZxeWg2ajYzaDlPL1RCV0p2RjRYZm5BMDhr?=
 =?utf-8?B?c0JSeGRGejdGc0Y3UThidzB2QmZYblVjU3JBSDRLcXdZMWFzQk12elVjWHQr?=
 =?utf-8?B?MEZhTUVnUGpIWDMzT0dnVjIrTk5PbTNwY21YandQcjRrRTNWVjBJNUg4OExF?=
 =?utf-8?B?WHQ0RUFrbkdGNXpvY0xCcWJYZFp1eS9yK2QxY0tienI3VTVPNHhYZ2dvOTMw?=
 =?utf-8?B?YWxuK3ByVTYxYVJQMDk3Z1AvL3poWG1yS01CTUJackhjSisrcW9zdTRTWnU4?=
 =?utf-8?B?bFBGOThGMnVESmNUc1dJTUNhS1FLQi9zL2g5dWE0Znc0ZE1PZGRtN0JxS1c5?=
 =?utf-8?B?bVIxNEkyR3BpYXcxMFNqSFB6VnZqN2ZDUStnczU3UHIySzV1MnVWS1NOUThI?=
 =?utf-8?B?cVhEZ2hrSjY3Y084THFLaG1zeGZGZC9OU2RqbWFJQ1JvNGhmanZhbVVxdlhk?=
 =?utf-8?B?a1AzNzhqZnZQSStDbERjMVRobFpNMmpFTS9WZC9XUVNJUzJ1WkVqZ21YYWF6?=
 =?utf-8?B?VkJhRzZuWno5ZVlBMW5ndTRMR0E5VEovRVBRQjNvcCtlbUU1WDVwMjJHSlBB?=
 =?utf-8?B?NmVMOUFXR0J0QUhNY0VZU3AyRWZaczBxNFlmRmlXRThKZEhpSytIRkVGTGRV?=
 =?utf-8?B?aXIyMmNSNmRYSXVMOW94QWhCbloxNldQMTNnMjUwMmJQZHVxOFNManZFRGN6?=
 =?utf-8?B?VEoxV3hkajF5OWJBN3B2VGNhM3ZGeXA5enFMNUg4ZTRLUnF3d0kzOHJ1NndU?=
 =?utf-8?B?ZlcyZVFIejlWd2ZKeXpxWVErK1ZxVEdxb3RlUnBnOHFzWmNGOWNmeTlkbk1Q?=
 =?utf-8?B?MWxJRXU0TjNRb1NDZjUzSVY0L2xYOHQvVTNtQmwvNFplblNwRGxVNnBLd25t?=
 =?utf-8?B?MWdlTGEwaEJDS0VtOCsyVHNmSlF6cUhaZHAycTlNd0lISlo5eGU4MU90UGh3?=
 =?utf-8?B?cy9YK25uL3NqdkwvZXgzZ1JLdTVvNUJJVklFZFM5TGxtbnZGcWhqblBONFVN?=
 =?utf-8?B?QnRoUW0zemFPS3ZiL25zYWVJTFdsUCtLcVAwUHBCaEdHb3FER3pBTXcvNGtz?=
 =?utf-8?B?ZG9JRUdBWk5pSFBHNjRwTGQ5ZUh3eDBaOE9JT0UxNGJUTVFxZ3BDOUNzejdw?=
 =?utf-8?B?QWRrSVZoQ1RWWVcvS2tDaXFNbk1NWkpTbkRiUDBOdWFQUFozTWF6RUljOU1q?=
 =?utf-8?B?Y1hrRGRONVB1ODBVM29YUjF6MlRUVThkdnJyZGJIdUdoNmdjalAySHFYSWxE?=
 =?utf-8?B?ZnNJSkR6WHlVNXppbTQwdzE0dGlRS2xDRHB0L04wZE93M3ZiQTUveXhpNktK?=
 =?utf-8?B?TWduc0J6UUdZMGVydnNXL095WU0wMWVycmJKUUZ4SnEwTC9tSjlGWWFFaFh6?=
 =?utf-8?B?WHY5OHlablJrRkJwSEFGeHBuc2llcGdMOEtwUTlVdEhZU2RhTzNIODROaER6?=
 =?utf-8?Q?pOnFfzgXSlMNWA2FNlAeuTXCHqsREzWHePmJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkRVY0laTWdzWk1MUFlIcXd3VzBqVW1qTzA2UnBVOHpxOVllQXZoMGdBUjNO?=
 =?utf-8?B?UUhtWkdWMDQ2Qmg5eU44Z2hCVFZIMS92dFQyQ25WaGJJeENPSzJ2Z2pTSG80?=
 =?utf-8?B?K2x3cDM1QktkRkRld0x6YWthakZCOGVuWDZ3Si8zalJtR1I5NXoxUlVwR1Jl?=
 =?utf-8?B?ZFV2VjR2VlJNL1VXdk81cHdVa0FNNlVkaTJlWGliRnJtWW5jVW52bHBBOWZD?=
 =?utf-8?B?L0J2em02VXJpNTRrWkJ2YnlJanF0K0NCQ2psR2lZOWFsL3oveUk3L3NxNndh?=
 =?utf-8?B?QUhaek5JWUtiaHN2cE93MjVETUFVTzhrYlEwRG4waTJmbjNMWGJoUERYUkdC?=
 =?utf-8?B?Ulc5ZnR1c0RMWnJ5T1lWei9UWEkycnRQSWJxU2VzRWVvUjlUZ1picDdROG1F?=
 =?utf-8?B?L2dvS01aME1Uem1vWnZjQVBIMytWeWNQUWRteTE5cDRaaklTM2hJcUF3b1Ro?=
 =?utf-8?B?QTBSN3NJTHJ4K0xta3VubzBWb1I5dUV1YkRwV20xQUNWVjhhMUFlVDBaaCt2?=
 =?utf-8?B?MXppSllPTC9OaXlHZ0JkV1lydE5UZCtmU3hnbUpzZDIzR1VjeUlEN0REMGU0?=
 =?utf-8?B?TUNOUWJjY3hIKzVBWUd3cngvSE9nYjNDa0VQSU9OVVFKRUgyVk5odkdoZFph?=
 =?utf-8?B?VnZzTitYK0tYQjQvWkZzTHlra3IzekhtRVdFbS9MSDN0c2tGWnZmQWRyRklN?=
 =?utf-8?B?MU1BQ0EvcHhoMFJNejRHeThDc25IdWxhTC9VTVF4dnNsYlJkQVlZc1VBSVNV?=
 =?utf-8?B?YnBNbFZuVHBpbWNEd1VRbmRqb29yNWczaGZMdXpPM0RrTW4zWlRBSHIxeEJO?=
 =?utf-8?B?TkE1ZXMwQWloWmZpOTladkVKWlF3THBhaHpDc2tNNDRQUHVKRXhuRFlkQVZZ?=
 =?utf-8?B?RGlpelBKdE00S0R2bml6bjlrckV6WFU1VGZZVVF0S3E1ZzZuS1p6MW9naktp?=
 =?utf-8?B?ZTAvcXI0S2FCVGc2blkybzRwSVhJMDFtVFdxVk5na2RsSFhkSHdZYnJmeTE0?=
 =?utf-8?B?MVBTdHEwNHcwbUcybW1zc2VJcDBQTy94MkZxb3UxTDJmdWx6UHIrQnV1aWIy?=
 =?utf-8?B?SmhqakNmS0hYRTBRbHB5TWRDT1NpR2tUVkdUcXplT0J3Vi8xeE1PUVlTUDR4?=
 =?utf-8?B?TzJpckI2STQ0ZnJFeXlmVDBEYzgxMlNibmlOMjJYWHZqM1BIM0hLcjlyTGdU?=
 =?utf-8?B?dTczQzl4QTBOWUp6RDZSN3JGVkJ2TFhGMHBoMTVWbjc2SEhRUE9oOUFLVXND?=
 =?utf-8?B?V2hQMlBRWCtqZ1F1Z3JOTERReFZ6OHREYzA3RC95aWZTNHJHbHNKTE9SRWxw?=
 =?utf-8?B?Z29JYUxQby8yTWpTdmtVMUVkOFNqWmVKME1heWxTeUt6MG8rcFRXeTdTb1RF?=
 =?utf-8?B?K2pxenU5RHlVMGRKNWlGbWdsSVFDMDRvdEZRSzZ1V1F3UkRiblU0RnZJbk95?=
 =?utf-8?B?T0xIYll2WSttZEl2VGptd2I4Q2xGc2JtVHRmMFdsRFVjVUFreWUyeDhTUTlD?=
 =?utf-8?B?WnhtNERMaGZLR3RHMTI1SnVtRElibXBUUWU4N1h4Q3pmK2pTKzRvUWQ2TWdJ?=
 =?utf-8?B?dDlSNzM2QzhDN1BPYjhMakxvVUJ3NVpKb2xOMHlsMlVtd2xMSXIrL09qaVpa?=
 =?utf-8?B?ZTMwMm5KdVpoWFlHdmN1a1FOaTJRUDR2R1N4Y3JmWnVHbU5GMWx6OXhHU2Yx?=
 =?utf-8?B?blR4TWV6N1huRkNaTTIxRFozaXZxM3NIaXJXN1EwekloVk10UFRoSy9xY0c0?=
 =?utf-8?B?Z016azF3ZkQxamFlNlVVSE41U0taSTUxbEhsK3ZzQ2VsbzlJbUoyNW1iTnQ3?=
 =?utf-8?B?Q0lTa1lzTk1zZktYcjc0S2laZjZlQ1FQNVNHeXFwWlprM0lrRk1FbFFHdldt?=
 =?utf-8?B?ZEdUSEd1SXNlTXJiR3JWOExPT1dlakNmWFVwN1NHUTBPL21ZZGtqeFdaK0Ny?=
 =?utf-8?B?Zk04OWVSd01jRjJsU3lGMk5QRlloMnRaMUNjS0dOUDUvRFF1V1RFZHhGWTIv?=
 =?utf-8?B?aUJodmJoUlpXNFAwUmNpSjhINEhpQ0hQS2tXaW9BWTJ4aDNJUEZKUXltdVhz?=
 =?utf-8?B?SGY5a1lMazJ1VDNPM3Bra0kxdVYzTzJyYm44U2R2czNLc0FRcXVyMVk0NHZ6?=
 =?utf-8?B?dHhTWlNNMVNJZlR1aGZ3MmptY25PWXNzSjgrSklsSG9pTUl3czN3WlE0aWM2?=
 =?utf-8?B?YkxVeVBWZGdzNHdnV2dDOUNsQkoyajVUU0NNVTVDWXJpdld0MWViSzBpai9s?=
 =?utf-8?Q?vOHHbiqNkDrcvFWIzQo9D+JQThpxXjx1JMdQRsQ2Go=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5694c70-1091-4045-bf51-08ddb3f420ad
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:25:26.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UgCeYVFu+5MZfImnr0WNJF39lzXxjKvcrW8nlrHMyjOxxPv0FsXLlJk41rJLnDXTzneL1fkbnF9KfoMcjPbgGUHXxu0KYbri8iSIlB8StY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8208

On 2025-06-24 23:10, Boqun Feng wrote:
[...]
> +
> +static inline void shazptr_clear(struct shazptr_guard guard)
> +{
> +	/* Only clear the slot when the outermost guard is released */
> +	if (likely(!guard.use_wildcard))
> +		smp_store_release(guard.slot, NULL); /* Pair with ACQUIRE at synchronize_shazptr() */

How is the wildcard ever cleared ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

