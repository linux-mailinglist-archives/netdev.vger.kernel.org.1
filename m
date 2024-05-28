Return-Path: <netdev+bounces-98544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABA8D1BC5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FE5B24E82
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159016D9AA;
	Tue, 28 May 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qh+JHWng"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2013E3F6;
	Tue, 28 May 2024 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900936; cv=fail; b=av+Qqiv1iy+YzUqY5V0i5avFDJ+ep1/qgcedSaprDGUhLdAGrPYNYLuX9uRZhGYo0tVXI4l+oZOcs5Yn700zp4EWjM5TfeJ8LTfg+ZY6Ai4Fel4nCjlry0WsYeE5VYYojwvl8oKyLewS6SCId/OHzlQbpQkVA3CFVT4FjX6O79A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900936; c=relaxed/simple;
	bh=RcYaQHPvtNoVN3V1R9XIDJDFs4eyFg12zkCvw3auWPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDo5zVRkoZpRqEPTvIzt4kPVXu7vJ8Jzj41FxJS7jt0p2S1gTh6S29JKUpRdE12Q5ukDWV8gwSyORx0BSfmBKVWsQSpgvfzMC4nU85iLSJmM4q4N8q8tEKeMFqawFuQsJ5wuLLHpk9Hr54zBHBE+QzLAk60f4FIM2vLKvueXS0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qh+JHWng; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3Me5DCGpR9EnvYiU8/a0hB05rnPQxkhhgd6lLNx2Za7H/AMkaraOp/ETsvvh+Rkdh5wfAHezc2SqgOeE2Z2dGj3hMXQDj7A2SOhXlyT4mJ9NQFZJcCzdhaKJZ0m6t8UKqAUCNfOKB/pvNXjrUBb89Gc7KPHj6rYyFx1UlXdNdRR0PRu5Qp0+KoXpVV9bJ3RQI5pV9N+BBl8TV80THztuSUTn8oiMCmUvQqXdn4rXIAdm9cxL0iXJOcFtW3in1FN72t5protdoaN6deqSwBynugDJNIfw+T849KNG4aBSXxBKIetqw5mQt5ELUq4hebiJgQbvlUvQW9UPsdVh/6iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDJLx81cSaw4oYVx7MnBcmEoM1U6zfmJ8k4ko9orO0Q=;
 b=cjHJeLK1dRVlke4MQV530rdRZnzz5/5tym/ut4ketmXrQsVYoomBRuXpG3hJBOyO8E8HQblXjuP7VWKSQd4OvR+FzjvqiXPKwmEcj+cgqfzu5Aa9j5a//g5YHJnHvyJfHSv4bzLnal/yNCDAG/eE1qCpoFUWrmn2Rz/sY8vZl4l3px8/0HMH3sMuDRzIVuWX9WF2wCh0meR6qNCHU+1rGQ8VGmYKsuskG2w4g6/RSVeQk/H/scRW/0OdrGUgvMuS8/OVaCyQ7rUEsiliXhH6NPYMx9NCCVsRjGoPGgzgWB7A4L9SC88kk6DtiRaFsCETTFdZxjU0+0s+n4+0MojhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDJLx81cSaw4oYVx7MnBcmEoM1U6zfmJ8k4ko9orO0Q=;
 b=Qh+JHWngOH2lONQSo82gyQoYiMX9dfI/dPgmsQ4/Ab/Me8X5nLl3bQXalgEBHhMdBH5OgPqwkfV5QPChSFwvEzGdZ1QMhLCkOIYNj08fuGQtfS5XlgUNrtb9uN57ZwKb/ObnqQGPDZMk1lUAjn7h6AS6N6YOtAwyaBaL822bFZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AS8PR04MB7605.eurprd04.prod.outlook.com (2603:10a6:20b:292::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Tue, 28 May 2024 12:55:30 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 12:55:30 +0000
Date: Tue, 28 May 2024 15:55:26 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Message-ID: <20240528125526.qwskv756uya3zaqb@skbuf>
References: <20240527140145.tlkyayvvmsmnid32@skbuf>
 <20240528122610.21393-2-radoslaw.zielonek@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528122610.21393-2-radoslaw.zielonek@gmail.com>
X-ClientProxiedBy: VI1PR0202CA0034.eurprd02.prod.outlook.com
 (2603:10a6:803:14::47) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AS8PR04MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e102c56-8298-4546-fee9-08dc7f15743a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iECnHte9WfunYDZLzTe7CDNKZ6ZU6XIXPW5ZAf+7tMw3O0mD575F7/Fur91Z?=
 =?us-ascii?Q?dVt8ltXFIfSMDX2JXD3Tsu1fnjOV2y3Nc7+Ly2vpxYYHjwM2ENdtsu/RhXe8?=
 =?us-ascii?Q?thiSAW/kKQsGNp0I0NGEiR7ybM+QMt4+96tZiQPBGbDVcu09UQ2tIzATU5EV?=
 =?us-ascii?Q?O5jsgMH4MBgvYFu3ayY7pRC1kaFawUFiki965Q6G+n/gSCQnp718KpCg4ZiW?=
 =?us-ascii?Q?uozitzfQXSDbRZiUq1eLVDPaXbOAToeaezRXZQIcU34U3847oq8BBZiktjwL?=
 =?us-ascii?Q?vj21gDJEwYQhk/bdAJDk9JUaa+vfYlgsewKbQQEpGYKWYhIG/ucRhZ4dNH+3?=
 =?us-ascii?Q?NbTcO0RwOkJ6e2lmPjHQl+X6Co9Z+GGVt7MKF7LgjbqIXCaEcQ70dvhxCkE4?=
 =?us-ascii?Q?w3nAl706IGc6g8cxavN70L8uiN7SNExXK0Yc3EVTvJAYlb1UgSmK5RQtBUL+?=
 =?us-ascii?Q?ka1gxu7V0g8x/EHUYdAIDbD/6Qfnf5fvLrIavLqx1O4zNRnXxvQ+OPISY5hX?=
 =?us-ascii?Q?PZRRhvXlyLlpfWyTzwPC7Gtxb0sl6kV45eFANcsQSgOABVQH8ekGGB2Zm/IF?=
 =?us-ascii?Q?WTXIHdgllOop/EH6GBGwmfWFGDbKoY3+oz8cBAhMVnGx3fose5qEtDJ2ByeX?=
 =?us-ascii?Q?YXpqRBavfs/Di5kttNyn2Miw+nuMcPR+CBR6oXBEymJaa6hpFz9SnoI3d6X6?=
 =?us-ascii?Q?Zn59sRr4TJ2pldzqXfcr/OJnZRS/YIicwjMzUnDIELeWPVyrfkL/sqVXjjlJ?=
 =?us-ascii?Q?bVIb7YzZTaNGCyiIxSqrAWydAtozaPVAou+1A4UwXTPC/0S8n3bL5tGbG+ai?=
 =?us-ascii?Q?NUl45tWdJ6w4/WxphMS1cvG9IRj1T+58NcPsS92sc0DBO55zorYF3moTT6Xs?=
 =?us-ascii?Q?l089RmIYXLthtVfIgU7dS6GXWK6J+R4P7Naaxy6At1NMRVzod2skvKzZpsRg?=
 =?us-ascii?Q?2/qbz+yrffJjabNW6wKKwHzLrU+WBemRt8/b0DKxfsxp4tgT9WnH+htpVXSB?=
 =?us-ascii?Q?JC1z8eOma/FibYawdq9CeLC78Myib6xnStvdKZZypre+buuaElExOM+ApIo+?=
 =?us-ascii?Q?v3m6GoQKYcx8ABDIJ8IKKc7d2u6dyNGJMfMZEjK/I8loEogW8cakY5e32UuW?=
 =?us-ascii?Q?zKyppYn1HEWmnPUJspFfnCw/6c5WhmTjCY+wCjDt8klZL7aQMbac6EzJAlNu?=
 =?us-ascii?Q?IY6kX/edZGWs9ybs+vaGpRDDyNYVd2Xv5V0qYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LzT5mW3XVWPRJhQESAiv1nyXPo/cTpP+Koqg9A76WWkgZbPhzfGSKesyXPhX?=
 =?us-ascii?Q?Vk4gMliaJnLpfKxrP2SpSqv7ukHUp84ISx4K6HJVn76PLkJO9O0KMarE0aVI?=
 =?us-ascii?Q?T+F0fwlO1QUeQCEHpxmFLXmoHioVVwQkgVDC2LLbH+/w7HlVAsE9yR4+R7VB?=
 =?us-ascii?Q?p14tTABIaBAfiv+sZi/+uJhGGY7YfE44ee0STNrZr/0AN4Wqpc6l7Jg2ydQK?=
 =?us-ascii?Q?1VQKLBwYFTd2nY1UmSHXv6EoYWXDxAj5mq/NECcNWQ09ISc+Thp3rWrRJXzO?=
 =?us-ascii?Q?sOJznRbomwJriRL+WVtMolaGloJKZHLYItR5I+DT3fTX02lJt+0xa0bZ+nYj?=
 =?us-ascii?Q?YImWu+zkxDoiejKOjVpqY4JIYv/7Z56ieYudy46S7U7mVm5zUtk/9LJQDpxL?=
 =?us-ascii?Q?74kPDozHwJPJscvWohVK0o+cSKzKKRWzhidlLJNyNcghycFbITSyHYPgG97f?=
 =?us-ascii?Q?GLAo2KBlQyaX+RaudV6aZq+FpR4IkXiaFx8iKMekp1nwbLcx2IBRt/Twr1St?=
 =?us-ascii?Q?Owtm6aRvSDsSRnsCUlUmGG5ia87Iwwd95fnTGpaGiBZS8EkaG7QyYdaZ6dJ9?=
 =?us-ascii?Q?6JCWy94lmCsrleU+6o0dFa48XEJKuAqlzH3yqeZis+JE6E+TI0E4N9fDwBFx?=
 =?us-ascii?Q?lSP/P04TfBLzXwk74c0jQTy7ArsI0hkMFU/1myl/Htu785u1fwu8+ksnjttv?=
 =?us-ascii?Q?e9oRIApk0pWiCszV2RgI8wmDlzY16isRhHh/tDD6op5qyu7IWmUdG1F9Yo/T?=
 =?us-ascii?Q?KoZ5aExAJDUrQr1rYCFmQlEXYYnWn0KRFsTCDCev2eU5O5JO94HBzcq7H9gh?=
 =?us-ascii?Q?VOa1aJsfbTg+IipshWnQOFUS/ukfnOKJXogp0qboHqM2bQFQz8CnoAN4Wz5F?=
 =?us-ascii?Q?AHUvXcjujsXIA5qZkJN9KOJFVVKdZ50ebXjPjfez0frfArC6y+80hM5+HVpV?=
 =?us-ascii?Q?cBl/WL5WkRUir7uctEMgGR+7pTsTEyxYVcwDsqFMVcV67kiROAZtBGJDIOgi?=
 =?us-ascii?Q?73rceZRWSw56kOrrSKjiPEzbQlkcRfsd1iYsQsQ4CNshQzf+7Z4suuOEHrdL?=
 =?us-ascii?Q?VVRppBKP3i9FCIOf36FQ8J1Ida+2p2q64bz/3VnsoLHwNwIx70fUzCISG4cT?=
 =?us-ascii?Q?+4aqvkUYwZgy5NyUuSdlAs6CEKUC4Zz86f6Ny3U+3UfLdTwyDwjfi6X26Knp?=
 =?us-ascii?Q?P0VGVwTRJTFDtgW3F3ppczvo3DAcJay0hasgn8uZfkle++npuWKeelYVnkd3?=
 =?us-ascii?Q?LlTK3Y5uMC+PZZyrjsf4ddBCoLCz88XbNgu/3X2xUqA/BnvqkyCVhTIp/ao1?=
 =?us-ascii?Q?omKqIv5e2MXDjOkbVdSK8n2AvL44kDz1R/mEJvSGh8COkhv7WmeMgayU5JlW?=
 =?us-ascii?Q?89ujuxg6vMKpvGVZlyI65qirqHwekRfBxDkDnnbkEHGNrN32DxEgGO3eOxVy?=
 =?us-ascii?Q?4s2AaJGsz2GOd+ZMpDqVUIQiZLjITclqEY8Ojq097jJjpp/hpVPJ+tu+rfTP?=
 =?us-ascii?Q?ujDiUQjSEJ0AZtU4AlpkgJ8Eik4SRAT5w2KTN7hA5cJCV+edmlW99WgKS1CK?=
 =?us-ascii?Q?mP3r3YJvsgIrxHT7a5u4vlP8FdtJtrR7CuDCEiGPcy25IXFPTUNKyWtIAwki?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e102c56-8298-4546-fee9-08dc7f15743a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 12:55:30.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MHS25Ft2QVZF3OeeQdX5XYgMFaRYi3VhKF6mFeatEkoSZXPQa4OMzqktm6Vvha1XVb06xJJPUfwCx1BDleq5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7605

On Tue, May 28, 2024 at 02:25:58PM +0200, Radoslaw Zielonek wrote:
> Hello,
> 
> I'm working on similar taprio bug:
> 	https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723 

Could you please let me know if the patches I posted yesterday fix that?
https://lore.kernel.org/netdev/20240527153955.553333-1-vladimir.oltean@nxp.com/

> I think I know what is the root cause.
> 
> The function advance_sched()
> [https://elixir.bootlin.com/linux/v5.10.173/source/net/sched/sch_taprio.c#L696]
> runs repeatedly. It is executed using HRTimer.
> In every call to advance_sched(), end_time is calculated,
> and the timer is set so that the next execution will be at end_time.
> To achieve this, first, the expiration time is set using hrtimer_set_expires(),
> and second, HRTIMER_RESTART is returned.
> This means that the timer is re-enqueued with the adjusted expiration time.
> The issue is that end_time is set far before the current time (now),
> causing advance_sched() to execute immediately without a context switch.
> 
> __hrtimer_run_queues()
> [https://elixir.bootlin.com/linux/v5.10.173/source/kernel/time/hrtimer.c#L1615]
> is a function with a long loop.
> First, please note that now is calculated once and not updated within this function.
> We can see the statement basenow = now + base->offset,
> but this statement is outside the loop (and in my case, the offset is 0).
> The loop will terminate when the queue is empty or the next entry in the queue
> has an expiration time in the future.
> The issue here is that the queue can be updated within __run_timer().
> In my case, __run_timer() adds a new entry to the queue with advance_sched() function.
> Since the expiration time is before now, we need to execute advance_sched() again.
> The loop is very long because, in our case, the cycle is set to 3ns.

In plain English, the root cause is "the schedule is too tight for the
CPU to keep up with it". Although a schedule with a 3 ns cycle time is
not practically valid in itself, either. Vinicius proposed we should
just reject the cycles that are unrealistically small, using some
simplistic heuristic about the transmission time of a single small
packet. The problem is that the rejection mechanism was slightly broken.

> My idea is to create throttling mechanism.
> When advance_sched() sets the hrtimer expiration time to before the current time
> for X consecutive times, we can postpone the new advance_sched().
> You can see my PoC here: https://lore.kernel.org/all/00000000000089...@google.com/T/

The link is not valid. Can you repost it without the "..."?

> Could you take a look at it? What do you think?
> Is it acceptable, or is it too aggressive with too much impact on the TAPRIO scheduler?

