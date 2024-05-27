Return-Path: <netdev+bounces-98194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156E8D02C4
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47421C20B3C
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CBF15F324;
	Mon, 27 May 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCKeMJKb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A115ECE7;
	Mon, 27 May 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818522; cv=fail; b=fGxumnz7T6A60+cAJ/Av6gTVEyvA5aa7UF60Vf/TfqBU03ljNdq+QRwNlLOabpvY0q2Nsnk2meXWc2oqBq+HY3R2L9nSzFZ2oWr4A9ZqVrTxpex+UIP/gqMiB0KTVc56ObilPF3ZnOI1gHQzcU27GI+ljnBXWC83wmyxrwxLvn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818522; c=relaxed/simple;
	bh=jaRC/h3FLzEIXDjfBjHAg78lSyswxwC7flMrVCw/KrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UX1Wfhhze2xs85NJUZmEJBNNXPGrCLHdRptdurbUOF7zkMrphU7XkRggPmZgPLx58vuhwy4z2jIm006a+vOZgFaFpApooKhIQuDDHzs505R3hXWGldfc5Hoq+3R+ZKkCGKBuc93XehTCVlpuRa1rCvzitIYWw6LWjrbpBawzAY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cCKeMJKb; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVGKsxcR6F632QE7sY31dgvninjR8KNecpy5GvQTuysZ8WTGxtwiE+DDRgo5i0qFqfjvG5jk6tJrZWm9cRsthwcb5so08UK+W3t4QztwR0LbV1ll2nWrCNreUOiSvDhPHwN9wWcqGczqD5szj5FZcNWzixPItEWrbcE4qwO335s4n93Sc7KgHMdMwhVY4xrVwBjDT6tEXkxSfeihH5D2A2x8tD+MtqxkxhA/EgC29wuUmzRnYH6iZjOpGZUF9SoSwZ/gUK3TaTUby5kSQvrk0rt3mYYaRj3hpAX/8K7n24pKhdxsCBuUxGcTCgIj/Ixl7nZ9m6/eOssJXFbtrMpJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaRC/h3FLzEIXDjfBjHAg78lSyswxwC7flMrVCw/KrE=;
 b=SZjprq44YV1N3ZV7IrBm2zXDHA4XOK3a1smdWG4QOyywBbmR/uI5vnwORaoRHQN4AFr8Kti2PxMr3F61msRmpnZxNSEqdB0WW15ju8fzvbzb5yN+K73Cp4wLF14T5zxg+sDltMpzeKmqkESHI1gLtyGTZZ23Isr2JXZt3DX5UGI1brKvCSEFCKezvUDsMygmpINDg/2tkKSN3bJfrVEbGm5KttNmh83Qh12esdIc8SWNRJ5LB7nBlSh6M4GYItOq484pPqPT2uuhUA1dRdDW93ngtlCGAENVTX35LDcS6yhMGRMBSPy/dSRsKit6ecVLswvaJSRkbEVxvEmEdyj/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaRC/h3FLzEIXDjfBjHAg78lSyswxwC7flMrVCw/KrE=;
 b=cCKeMJKbZEO5/ASdWKneLaqD5HmaprRENQtbx3RPkXXkYH4SHKX+8b6wOViqmyfvBd66iYMomsUEykSw+7OiU9hIEylbAqoQzqF1KhNmjqIBkmoStlg89JgsPhKzDR01kYuSLa9smNHdW7hWYTo4xC4aIqoyqz4R13f+/G1OFCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 14:01:49 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 14:01:49 +0000
Date: Mon, 27 May 2024 17:01:45 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>,
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Message-ID: <20240527140145.tlkyayvvmsmnid32@skbuf>
References: <0000000000007d66bc06196e7c66@google.com>
 <CANn89iLr-WC5vwMc8xxNfkdPJeC9FvHnB7SnS==MMtGa9iTSJA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLr-WC5vwMc8xxNfkdPJeC9FvHnB7SnS==MMtGa9iTSJA@mail.gmail.com>
X-ClientProxiedBy: VI1P195CA0058.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::47) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: da1f7ab8-9ab3-46ae-82af-08dc7e558d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzlDXEVoLcyUOGYuGVeJX14xJiXXTL/OYvyVoMvgqqNwghIFG7Dvko67208t?=
 =?us-ascii?Q?VpfOnWIICjrt0QWL3sqBApZDgARfgO5g4MVSQaJzaqmlhkpQ8fJL7SJafGNN?=
 =?us-ascii?Q?0Cxa2yDZ/8MRtI8O+sDueJvNMlUKuF4AZN3qYszu95pfIQg1wPlIHTV1BAzG?=
 =?us-ascii?Q?4NcRTDgajHAr7cqm6ES0qGCLXj1ZIKle9I4yNmbcL8nioiProS06NqLUvj2T?=
 =?us-ascii?Q?lWl6z+/OcLZi0HFaYHCvwlOXAd/mKc0aGiAIikU1YURYRvxwQ3lNzsAolGUv?=
 =?us-ascii?Q?LcLbj14ralxxMuww93+z9/TaNnPGTnLrCNS0lefM/0zWiddrK1EsFsgimx/v?=
 =?us-ascii?Q?KvGNK5eEVWwsFEtUJe27qZqL1xjC4P+YZ/7UHWXvaRbGYY0edSgumO4GMuZG?=
 =?us-ascii?Q?kcAPFslWHcnTFMlQia0SX25amhtFKh46oVzX86H+6uDtMyfSZGFjiuCbloLF?=
 =?us-ascii?Q?OlRPZJAJVwwoJwkM9IZ76osNCehz0a9NJGNTVbdizeKmOT7kaVpj7eOd0Alv?=
 =?us-ascii?Q?8RTMXbP2+L7fLS3iMq/nsvi5Pm3myIyxomJOSkWvf5UnfwDJgmAhjyI3jt6e?=
 =?us-ascii?Q?SVVkMBv57dSSFbKCGgIUbMIBHgd/eCss/SAclcr6Daz4xOoaj5O2mEGGcDoU?=
 =?us-ascii?Q?TXW692Uu6KUfUJYxVM0zCnrCo4wsP8ma4IJsPQHO1s6cY2bjmg6ACh5M3PD8?=
 =?us-ascii?Q?ZxL6LVUlb7eWX4E+xXjzja/777aKoJ45mJDEusUToIDKDO9IsJavShzHr09Q?=
 =?us-ascii?Q?hZf9V7yh8gmpoqczWpoDc1sMnJeOlywlZDXnxG4jAoiosSFuxa7nX9rNMHGx?=
 =?us-ascii?Q?IHtl+0XRL8DOAv5wML17I6G11AaehOS7JfqMmZ+5wGLpfqENj9K8AjvD3Ayo?=
 =?us-ascii?Q?m0+pYof6JPnmLAWrmBqf1RahQSUWYXbDHn+fFIULrUpsSePmgSofx7+7rAqo?=
 =?us-ascii?Q?fmxBx4xsQkjx8gx4x4IdPTNKRY5U1XdgnHAeaztG5B2rjnh44g/P92fGdXP0?=
 =?us-ascii?Q?i23X+ZWNV0V/++/21fzZKMH0DKTjMXS7va1UsR89peM2TYdDZkHalpsAb413?=
 =?us-ascii?Q?OzphnMP16d8bwrbyEFr3xZOz+LCnMq9VWRb+4lIG/s+hvNheY65WVIyG91d4?=
 =?us-ascii?Q?qajayW+n69e2NOCtxZS2JbHqwQcVyYPc4+Eza0SFv5GlfkMoIIZv4nOSUTc9?=
 =?us-ascii?Q?OlE9eYxRL9/PEwt0+GbtWhLmTLsAuDWH+w30z57874q6sVMFbXUDfoozuG+j?=
 =?us-ascii?Q?sTd9W7hhaNSZnVlOPcIcyZM2/1l73781FPBde6sQKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4dACZNDdAIGtEyVvwmIFUzlxvFIMAJ0fzQEbHhfM45uT+cEj/rz4VqdO9dlA?=
 =?us-ascii?Q?D/PCyzD23u3dImi/tciDqciK/sr8eHOZnMZ7qkui80O2KrL8qdkj4tmc46Kd?=
 =?us-ascii?Q?J73qj3DXUZXn+UtAsBenF6GoVp0pXpoNLB5s/gWkMl+BW5jabHmxHb3aTGie?=
 =?us-ascii?Q?eActp7U4FA578QRITSFZ9I1lUzQihsSEqiuA3fUvmrFluhjWGGtUueuC6gJ5?=
 =?us-ascii?Q?9Ku+k8UC4kjDLTYM/XZGBkHC1XyEYN1ZSgPXkbRqU9f/7he7ATHGor3P9daq?=
 =?us-ascii?Q?ZzIttwnGeg0FgQlPhvtUHkqSRUgXVlPycepoOiCrEWWEWe/U7MPWDiuHAiAX?=
 =?us-ascii?Q?SKYQehA9OuyRd2FW2MhDNo7n+wOLoRsPmL0Oc+reUbm/C3zjS3FigsFiQ6dc?=
 =?us-ascii?Q?YDFWErcfoPWRwezbrueIjlsRiM3QYUtvj31/O/9FwFkX39NYXPwy4KWm60eF?=
 =?us-ascii?Q?fsEP6nAKPqkwRqzX8hkIzdEdk242iISLFU28Hwz6qksC5uEen7iw0f5VPk6E?=
 =?us-ascii?Q?u8Jsoh1Pbhbd4K5V1ZOxlbhPyOR5M3wqQyaBkmxTY9sDvGjdUdR+Pw1UU2iu?=
 =?us-ascii?Q?e4gO6cxqRdt5X/YQknTwUDEuvKYV2lGnD7w6bNmL4FntKmCqqb6mORGO6NSK?=
 =?us-ascii?Q?55JuqAidzEc6zn3pJfMfo9uYPu6Bv1syW8j6P2ftRiHN1rtu0Mc0NkMf0eVX?=
 =?us-ascii?Q?1Tb3QeptBY0YwbB6uVYfjoZIGvkeNJm35IFMTjU0G0vKvPrKFvTU9kK9V4BI?=
 =?us-ascii?Q?hti4gqnc8323+KWzWH1ZhC2dXQfc81+QyaPXhvpSWhsNnp8TsU6tmfvflkhW?=
 =?us-ascii?Q?ovtL9ztQdtcsEakEEKwKq10N8BKMx7N76kEKLcE/pNDRjdMzLbY1dkvzu815?=
 =?us-ascii?Q?V2vIxsHkjnfNyImPhU74/e/fG9vafGZSCDtWfeEC+VRdH+ENgIUyiof+G0yH?=
 =?us-ascii?Q?lJa3eQEExjuv/HDPqsHWn2Bw5NXT85xgMDL4DRwJhC+SDwxubifGZZ0qUZZL?=
 =?us-ascii?Q?IAEppshJJTd+Lb1hex8/pO+pJG1B1euNwzZ1eYSsvUejNTmTJfG904Xb8/RT?=
 =?us-ascii?Q?cPkSJG8s2m67hYpFuhiOklbN4m3dYXYfsyV105ZXh/KPBPVdXOoZPCLsYFRI?=
 =?us-ascii?Q?bP70Kclq13v7yEVp/KmSlZ8jYUdIvbsry4Iq6M4GVhCDajUK0l+0xPeiCtVg?=
 =?us-ascii?Q?Fi2tXBJj9w5kDS/PtrMMvB7ClFNAoGe/3CdK87JlBmV+dpXnZmdndiiGkv42?=
 =?us-ascii?Q?efoWlFHGxmwxvYIT3rdki1+3mf7M2GwBpoZl4YGrebQV/4T5lB24WcmRaWQG?=
 =?us-ascii?Q?LrHk61wFeXuaLpfh5GPZ7vo+2FFvdz1cK/bdzTG1BFojTbve5yhZPp0S0KCZ?=
 =?us-ascii?Q?dOsjAWImhv4DAb0oShUK6/6ImQv+W7eHLsIxbKhk/9Hi/V6yPm5OJ4afngbI?=
 =?us-ascii?Q?pApheNubzCohXgznnKyA0ovQJVWblwZ3nULPpGY4pg0GoeZbHmpU5WKtPck5?=
 =?us-ascii?Q?MROUJlumfH7t5cC0jelB6Zewa2rTOYkHpKkeckuZP8r8lYPQ05qkVfQXYe7+?=
 =?us-ascii?Q?RpMOiu9MiS8evdrvwLv7V9mX5l1pobd89PKQGzxBOjCekNfha5/wCWvgXllq?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1f7ab8-9ab3-46ae-82af-08dc7e558d8a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 14:01:49.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66D4l7fPkCH+01p42djgiiHXJe/m0Nxu5DJ8c37Ad0l+/0M6E8Y9h0wxZXUZ+yN51mm9V0xNV3UYv6LJG4gIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

On Mon, May 27, 2024 at 02:43:19PM +0200, Eric Dumazet wrote:
> This is another manifestation of a long standing taprio bug.

Thanks for the heads up. I will send some patches after some testing.

