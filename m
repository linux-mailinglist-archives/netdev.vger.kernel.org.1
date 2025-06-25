Return-Path: <netdev+bounces-201130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929DCAE82B3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204D43BC8CD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3F25F7AD;
	Wed, 25 Jun 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rhLR0TbQ"
X-Original-To: netdev@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2138.outbound.protection.outlook.com [40.107.115.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23ED2620C8;
	Wed, 25 Jun 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854360; cv=fail; b=uR/uvkO6L0iS1VtgpTaPSo6b3hfG57TRYA6mOrsH/w6asCmJUGekZqnbrQfNVQ+ihDuzezhldcmANL5ztzsdLOSs9kZkuYI2rJLH9PZQiO3ARIDC/xACmh5Tiy+Rjl1Ue7/O3NgdbAKCMir3bAQfVYs6pFkUkScSw1G6L/uhxuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854360; c=relaxed/simple;
	bh=Xf35um4bcGBig5x6+oFlhAv6t6z9ojAxweUML6Lt/fw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BFO6jP2KYbmaotBJgOywb5IZY6N/efcAiog8MWFRWxXkfEtXPS5o59tDIqF9V2pgx0zhUTt0VddYzAv4npNkWhXZhqLnCJvW4JD9sL9nKxc8XmgvOZKKlHN2ZiJxaS4Hr0yS5WuNMWa7N7GarY1gX65v9UxVrvgTrGWO8A5ns+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rhLR0TbQ; arc=fail smtp.client-ip=40.107.115.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah+Y/ADeirdlch4HH1jpK9XOEdf/enmfhqNZWX5ZRXGdji+JUSic06nSDte80HXKN6ED8rbf+CWjaiAke6tMb9LO5YWFLvf57k3XDq2jyNOTkWWoAlYKd0Fa8UI2P6EbIZKSpB0HABqyB7MInmFBxNRe8NNpHactSBcURANOtmA6IUET8xz93Xdzne/Y4arYAMrMnTD1sTDbCIdNWTPgIiqsQ5D2D7QhZ9s4D5inK5TWGfUtr+Z/0t8LlEeRbGhExdXjziCOY/3Z9pBeoX+UfMOtvbehPoLzzJOWWnjek1ka3UI7si6b1v0tH2o0r/y24LgAGJNwacHW4TlE+FH2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/er+L+fMBdU2QptoNSjFHF0du9aC5FTK0edxlRK6Es=;
 b=ULTx6AYSBmxFDgZM/cNJOVVXaWK+NW1d43Es+/vl/G6TqdYmFPEvpAq/GUgqyuVt1Zn8YvXISQ9FoBabbf/AJSD0UlkpItmUVyE3AT7BwYx9JBEfBuFPQOKSzET9fuSinOzqjfgfi4I+s+H81czRjt3zH0d1dd3Wh/rBBQsa5pselsHTiU1Q4/BnlR/kYqpzDn0iCz0edHVCUpEMmqWg0JhEYCvWlKi9YIjC7cpi0e56mky3x92yfAT2U9orO7d9tBWxMFGsHEIFmomsPHaj3zY6GKmSc5vCDR2OxRv2zF58P7JldHR0dcbYF9MfC8WCvKCNOKlAHJWo+E0+oDRxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/er+L+fMBdU2QptoNSjFHF0du9aC5FTK0edxlRK6Es=;
 b=rhLR0TbQa5Wc0I+o73K4cOXbQgIY6DBjlwk2tVVDJLRAAM2jnq4ijPEA2z8Dc5phiNqlrib/6kL7DcoRt6v1v708AO6i4GytvaHlVzNBSaZG7y1348Y3mCKSxoHNf6R4FwHdMSeWZyMTylYU3uLHblEqEqhl0RoSVhPDTKE2Q5qzvMu27U0D+vADtMuQNowB+Fn6YEaelH9jCRxzHh1rdrh8cp0cSybhqRfJY38zMbcIzD6lWexJdKiCD69PmQ8vwdotQa0WLI+57XpUcqs6nEM/6Utw9wMXWccRy5MuH9dWB/JS+Gj6K4MOGFGvjUuO8chtaG+bH7zc0WrThGjwdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6608.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 12:25:53 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:25:53 +0000
Message-ID: <d9c75e7c-48e2-4398-a830-9d41e7a74cc3@efficios.com>
Date: Wed, 25 Jun 2025 08:25:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce simple hazard pointers for lockdep
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250625031101.12555-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: f46b5741-0c46-404f-f735-08ddb3e36d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnFrNm5GTFhVdUtGcmppNmdGc2VmNGMydEE2c1g4SkZNdEgwZ3BCaWRMOWFv?=
 =?utf-8?B?aVN3TkxCWGR1QTM1YllFY0R3Mm5JaHNsUTE3Z2hLeXNDYzdGZkFBNUpLSWxh?=
 =?utf-8?B?TGE3K20zNkFsR1p1T1NkZVdwckdJTEthN3Voais2ZmR1T0JMSEFOSWVXU0NV?=
 =?utf-8?B?dDNSQWtrYm5icSsxMEZRMHZzcEZuV1BEMzkvbFV6cHduSlV0MWJyc1ZYa0Jv?=
 =?utf-8?B?dEVwdVc2ek9KNVB6cUcrSEZuTnhNRlVsS2ltL0pyYThOR1d6d29LdHdvYWJT?=
 =?utf-8?B?cHEwYi93eldVUTYxUXVsdEcvWFZkZmtRWWU2anB5ZnhybUpJNjh6YWhVcHVH?=
 =?utf-8?B?RWoxVWc5RGsyK3FERXZ4dVZrWWp1aUdLMk04U3VFSG1saEVMZHdmWlZJb2Ni?=
 =?utf-8?B?dHBvZHJZN0dRL0VzNVdWNXc2Qy9rZ0tKSVZtSk4yWUN1MVNLNlRPR0pIYnlL?=
 =?utf-8?B?WGp1S1d1NERhOUYwRDdHRDdSbmgyUVhuNGtUUHVES0ZJSWQ1Q2Y5a2hQa1B0?=
 =?utf-8?B?eXc2TzRoS0FaOGJTQUo0aytCYm1UUUZvVUhucWtjdnlCUzk0dUQ5OWhFT29u?=
 =?utf-8?B?Zm5ybllYRUpsYXNpM05NRGpEWWJKWk9oUWoxS2oyMG5FVXVndXEvYmcxeU1k?=
 =?utf-8?B?V2FKdGRGS2hnaElUMUo2anFNTGYvT3hBZ3JaYk1oV2Nka05DcVhKY2tuUjgw?=
 =?utf-8?B?YnNSenRuVGgzZ0liQ0ZBVTFYZ0piMnZQOU5uR1M2Vkpvekg1Z0d1YTkvQVdO?=
 =?utf-8?B?eXNHbHNnSWJzWEozQVpxWkJMd2Q5ckFaZ0hMbGxia0RkVUtpQ2REMDF5VVJk?=
 =?utf-8?B?MVp1WVllZmM0ejlhM2pGdWxqdlk0bWtRNnFuMnFTWGErM21PR1liazJxbUwx?=
 =?utf-8?B?eXY2ZmM1MEhmL3l3aDYyODVxQU81TXcvZlJMdllxdUlmV0tZaW8zY3BoOGU3?=
 =?utf-8?B?ZDVXNkZ6SVRnWUFHNFVSY0FpWU9taklIK3pJdnp6Wk9jRnVuOEFFMVgrSFVo?=
 =?utf-8?B?eCtQbktmYjBlQjJGbk5DWFBsN1M3TWtod3dtT2RuUXd1cVJqQXcyeTNDU29k?=
 =?utf-8?B?UlFjQlF2cnJMVUxBQ2t5Mk1FQllNVkdMR3prbEM5OS9HbkhoOVY4TzdrTHpt?=
 =?utf-8?B?NHYrY3FrYk1rWGJNVGh3S2RmcVdCREt1ZzNBdTZwUU9Zam5SU21pZzE5ZVow?=
 =?utf-8?B?MUxsODl4bHYySVZnZjFkMjc0emh5R3BWRC8zQU5qV0haNHpQVDA0NjdpcXJt?=
 =?utf-8?B?OXY2RVg2ODA5ak90VTI2ME5ZcENnT0wwMmdRZkJyU0lFd3hjekhnQ2QyamxF?=
 =?utf-8?B?STVTT3BmMzg2ZGZLVXdlcnB5dWx3SDdFRnBTTkRZL0tZNFZtK2p1cnVOMGhR?=
 =?utf-8?B?alEwNml5MS8yeSt0VTFqTlpXQURXaTRQZks1OUVBdlNtbHJNckF5UkQwVjNN?=
 =?utf-8?B?WFNWR29MZnh0OWI5Zi9UU1dtYndhYnJla0UwbHRwMnBMeEUvQ3NFN3NmQkdF?=
 =?utf-8?B?N1lQWTVNSDRwM3ZBekI1dFdLbnhqY3JaVGxVRENlY0YxMERNa3pKeUVkQlpI?=
 =?utf-8?B?SCtxUUpTZ3c4aE82TndrUjhoV2FpQWdPOEI4amN4cU5mczRCZTVkQVFiazVW?=
 =?utf-8?B?enpVbUh0U1NrTnNvbVJDQnVaQ2tPQjJvUVdieTY3NDZteEs0ZDVBWEs0ZXV4?=
 =?utf-8?B?NG85UVNtRHZJK0tkdTBDZi9Yenp2Vkd2T05rMzlTUFRQYXBRQXVyQWFMNTMv?=
 =?utf-8?B?OXlJRnN5RVA0T1EyOWcwVEdkM1RmRmlCOXJiWVZqVFBHZzhpQlVjbTh6Sm85?=
 =?utf-8?Q?nExUehrD2eRBc06KJeiwG284yxZtSCc884Q5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGIxOUlIZHdRbUd5R1NaTVhzMDhCQUpsZTZ5T2ROOWJydkhEeVRicTJXaEZI?=
 =?utf-8?B?N3NGZ1RXZ05FZDRTVGxmb3Rxa0N2M1BMUzdNaHhlYjFWM1dzUmdGb05JeE83?=
 =?utf-8?B?cFVOZXVUSGErLzA3UzB2YS9iaExJKzRTRVA1ampMNUlqOUNUNlZscEtXTGpU?=
 =?utf-8?B?WFpmZkVNdG90NVp0a2dZL3NjY0xiRG4waTJuUlB6LzZST2NKak9xVEtrdXFr?=
 =?utf-8?B?WkdsTFA4WWJ5ejVuamRKS2VxMDVydUkrdlRQbXE0RGV2cDdPTkNabU5hYlov?=
 =?utf-8?B?SUh2ODlFYjlyM08yYnNMenBwMXg2UFZoZTZSTHJ4eHcyODVjekY1VTg1aXZL?=
 =?utf-8?B?clRWNisrZERxZ2t1QnBFZ1ozTy9hR0tLK0J4NnVWVXNHR2FNVFpHazFYczFv?=
 =?utf-8?B?bXpvaVppTU1jS3dvV1FsQ1pHdWJiRUVkY3IxRzRtUDRPU2pGR09BWTlWY3h4?=
 =?utf-8?B?anpHdFZaNzNYU0xCd3c4SHcxb0ZRQmpPS0QvRldUY0ZoMDRUSDZEU3RrRHRN?=
 =?utf-8?B?SzF6bmFDVUhXSmVOQmtIdFp4OWN5Rk9maHozcG54eUkxV3lBZFJPZ3NuVjRX?=
 =?utf-8?B?YXBJVGhQbVRUUGpKLzJUMi8zdEkzTktGUk8zMDc3cC9uTVc1UW5ZVStsNkZJ?=
 =?utf-8?B?U25ZL3BFVTk5bC9aTkszVE1LTkllSGZ6S0E1RWdSTG9sdmNBZmJXb1czdEFN?=
 =?utf-8?B?SUVjbVM5YXJFcjk5ajA0VzBqc2dnZTl6N0MzM0tOQmhrOW5MYkhFeGpwMGJV?=
 =?utf-8?B?eW1ML3ZMQ2o0VFdsNnc1aGhwVU0reEEzeHBsUFc3OGxHbHlTeE5kY3ZKTjI3?=
 =?utf-8?B?MlcydWczZmpNV0V6S2RpUkM4L21Pa0VqNzN4VHlhcjVtR1kxVHZCSlgrUnJw?=
 =?utf-8?B?MWZ3VWd4ZTBuclRyWUtzZ0c4ZEZQdVoxUUlKWHBVNklZVWJPM1hRTUlwOVZI?=
 =?utf-8?B?NGQwc0FsQWtPSzFVUnp0M3ZWRjJqdjZCMmYyV0Y0MVRrSEZmUG9uUXNLWFUv?=
 =?utf-8?B?SzJHY2p0Ynlhd0M0cURkbW1VbnpGbnE1cllhL3hYUzBmZlU5TXN6UGF6NCtw?=
 =?utf-8?B?d2szTEtCMEpKY1c3Rk5FQjZ3aG5IWkJpUldLMlQzb0UzK3RtZ2QvZGFNb3F6?=
 =?utf-8?B?aDZ5ZDk1QUV0RTh0MzFscnA1UGpwK29mREI5Y3JEMUplSkxFajN0M2ZaRFJq?=
 =?utf-8?B?UWJ5dHU0SGQ2dGhzMFhYY0gvV0NuZENkN2tmRTNnTGlMeEgvdG5PVmF5eG5J?=
 =?utf-8?B?TTJDUWRCazRnMG43WURzOVV0ajRCeXhKeGY1Z0o0RUk3TFo2N1BLU2VpaTZu?=
 =?utf-8?B?UFB2U0JNbENKeFp5KzFpT0ZlZjhlU1Q5TVJvbEI2alJhYkhaeXI5bDdic3Ra?=
 =?utf-8?B?UFIreGROYURya3pQUkhSNjNhMHdCRndyOW93QXpLcWJDY1l6V1JMTHh6T21C?=
 =?utf-8?B?VStzQlMvMmJiZEdPM3h2UlEzSXM1WS9oOEpqMkVEQzA1WVBRV2FLNWFyUnE2?=
 =?utf-8?B?czhMRnpjd1o1bWk0OTBKY3JvVGwveDFQTVcyeVg1YXQxalNLdXZkcUwvNWZV?=
 =?utf-8?B?MXU2ZThJdXhxNWt4MTJtR2ptb3hnSXNmbXozNmx0dFFNTnptQ2dGNWU3R1g3?=
 =?utf-8?B?UEdia0VHOXdwazBRanZnTjl2T2c4Y3J4UytEalRacm4rSDQ1MzNXRmNQUlRy?=
 =?utf-8?B?L2FrUnVOdXJ5U05EZ0d2Q1NDL25oWDZ1c292QXljeG95cWFYcGw1TTF1elZD?=
 =?utf-8?B?NnJ4MXB2a01IWnk5VEhya3JtU0hVZ1B3MGxOaC9FRkxCMjJsT2pMOEpiZHVu?=
 =?utf-8?B?VVV1YVliUjgva0pDWkdWTkxGaTd2ZnEwVXBJUTkwNS9CdkFkUHdNSFh0ZGoy?=
 =?utf-8?B?cU93VGtnOFhTNTlTdVdhMXdZVFdodDl3dkpwaXYvUXJvV0ZhU2hSS0JiNXh4?=
 =?utf-8?B?YVB0akhXOFdzS0JJZTNWSXpvMFJ0eWFSUVFvWVVFT0N0WFY0TjM2WHBjSmFQ?=
 =?utf-8?B?YitnQ00wL2t0c1FpRThQdXZBZnBLSzM0aWR4eEk3OEVLeTRodUFDaEdybDNH?=
 =?utf-8?B?S3R4YVdpZnVQVm1BeGgvcmJkUjdLdVFOblRMVnRESWc3NlVLN01YZmg4YUZz?=
 =?utf-8?B?S2lPakZaY1B0dHBXR1NrbFJMUlVZaU5NRVFSOFpiRlFURitFejE3TkpPVDZU?=
 =?utf-8?B?YXdPYllNV3JFTmRjWG9tZDJDMm8rNklaa01sNElBVjN1QVdzZ1p0WGphcHFK?=
 =?utf-8?Q?gwiX5OZ8l67ZbxWHU4HRPfC8/sigCoqdYAmdpXrpyQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46b5741-0c46-404f-f735-08ddb3e36d89
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:25:53.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDZcU1ob8H5Anqug0x5eqR9GFcS7b5QpjdoKHAWpNlffjaxpt3trJrxFsQbE+UDOxiJNT/RqncKGvqeYwOMedTOgNoO1DmxbvKJUnRlB+Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6608

On 2025-06-24 23:10, Boqun Feng wrote:
> Hi,
> 
> This is the official first version of simple hazard pointers following
> the RFC:
> 
> 	https://lore.kernel.org/lkml/20250414060055.341516-1-boqun.feng@gmail.com/
> 
> I rebase it onto v6.16-rc3 and hope to get more feedback this time.
> 
> Thanks a lot for Breno Leitao to try the RFC out and share the numbers.
> 
> I did an extra comparison this time, between the shazptr solution and
> the synchronize_rcu_expedited() solution. In my test, during a 100 times
> "tc qdisc replace" run:
> 
> * IPI rate with the shazptr solution: ~14 per second per core.
> * IPI rate with synchronize_rcu_expedited(): ~140 per second per core.
> 
> (IPI results were from the 'CAL' line in /proc/interrupt)
> 
> This shows that while both solutions have the similar speedup, shazptr
> solution avoids the introduce of high IPI rate compared to
> synchronize_rcu_expedited().
> 
> Feedback is welcome and please let know if there is any concern or
> suggestion. Thanks!

Hi Boqun,

What is unclear to me is what is the delta wrt:

https://lore.kernel.org/lkml/20241008135034.1982519-4-mathieu.desnoyers@efficios.com/

and whether this helper against compiler optimizations would still be needed here:

https://lore.kernel.org/lkml/20241008135034.1982519-2-mathieu.desnoyers@efficios.com/

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
> --------------------------------------
> Please find the old performance below:
> 
> On my system (a 96-cpu VMs), the results of:
> 
> 	time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> 
> are (with lockdep enabled):
> 
> 	(without the patchset)
> 	real    0m1.039s
> 	user    0m0.001s
> 	sys     0m0.069s
> 
> 	(with the patchset)
> 	real    0m0.053s
> 	user    0m0.000s
> 	sys     0m0.051s
> 
> i.e. almost 20x speed-up.
> 
> Other comparisons between RCU and shazptr, the rcuscale results (using
> default configuration from
> tools/testing/selftests/rcutorture/bin/kvm.sh):
> 
> RCU:
> 
> 	Average grace-period duration: 7470.02 microseconds
> 	Minimum grace-period duration: 3981.6
> 	50th percentile grace-period duration: 6002.73
> 	90th percentile grace-period duration: 7008.93
> 	99th percentile grace-period duration: 10015
> 	Maximum grace-period duration: 142228
> 
> shazptr:
> 
> 	Average grace-period duration: 0.845825 microseconds
> 	Minimum grace-period duration: 0.199
> 	50th percentile grace-period duration: 0.585
> 	90th percentile grace-period duration: 1.656
> 	99th percentile grace-period duration: 3.872
> 	Maximum grace-period duration: 3049.05
> 
> shazptr (skip_synchronize_self_scan=1, i.e. always let scan kthread to
> wakeup):
> 
> 	Average grace-period duration: 467.861 microseconds
> 	Minimum grace-period duration: 92.913
> 	50th percentile grace-period duration: 440.691
> 	90th percentile grace-period duration: 460.623
> 	99th percentile grace-period duration: 650.068
> 	Maximum grace-period duration: 5775.46
> 
> shazptr_wildcard (i.e. readers always use SHAZPTR_WILDCARD):
> 
> 	Average grace-period duration: 599.569 microseconds
> 	Minimum grace-period duration: 1.432
> 	50th percentile grace-period duration: 582.631
> 	90th percentile grace-period duration: 781.704
> 	99th percentile grace-period duration: 1160.26
> 	Maximum grace-period duration: 6727.53
> 
> shazptr_wildcard (skip_synchronize_self_scan=1):
> 
> 	Average grace-period duration: 460.466 microseconds
> 	Minimum grace-period duration: 303.546
> 	50th percentile grace-period duration: 424.334
> 	90th percentile grace-period duration: 482.637
> 	99th percentile grace-period duration: 600.214
> 	Maximum grace-period duration: 4126.94
> 
> Boqun Feng (8):
>    Introduce simple hazard pointers
>    shazptr: Add refscale test
>    shazptr: Add refscale test for wildcard
>    shazptr: Avoid synchronize_shaptr() busy waiting
>    shazptr: Allow skip self scan in synchronize_shaptr()
>    rcuscale: Allow rcu_scale_ops::get_gp_seq to be NULL
>    rcuscale: Add tests for simple hazard pointers
>    locking/lockdep: Use shazptr to protect the key hashlist
> 
>   include/linux/shazptr.h  |  73 +++++++++
>   kernel/locking/Makefile  |   2 +-
>   kernel/locking/lockdep.c |  11 +-
>   kernel/locking/shazptr.c | 318 +++++++++++++++++++++++++++++++++++++++
>   kernel/rcu/rcuscale.c    |  60 +++++++-
>   kernel/rcu/refscale.c    |  77 ++++++++++
>   6 files changed, 534 insertions(+), 7 deletions(-)
>   create mode 100644 include/linux/shazptr.h
>   create mode 100644 kernel/locking/shazptr.c
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

