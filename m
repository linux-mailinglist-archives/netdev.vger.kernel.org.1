Return-Path: <netdev+bounces-215517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF4CB2EED5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC8694E45B9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B52E88B3;
	Thu, 21 Aug 2025 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kK9v3vz3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE12E7BCB
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759384; cv=fail; b=oNasP+18tqfGeiDRb8KCTGgzF5BgFYabH3gt3A72MqowQ0ygAMznYkwA5/TeOk2FS5ykCbn9LoYCS65Eigr19X5TVm/mFP8f7/spR6ddgC71IBUsEZdbqLrsUwyjRc17xs0Q3a20ricsasxXdIi+Y38PnJFYo4IwiwL7XcLolK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759384; c=relaxed/simple;
	bh=fK3ld+15QgtkIv9SDiMto8ZI3lwezIpseynNpENRXFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qKkFBVBoqEGg8fQFGRtLytE4mSMWoJftKeQvqmpHWP4QKl9CmCxE4OU2dUGoJ6ffs42xttK+wpjzALh+eIlfRkR8D/291SZkNgAD5ZHx68UtED8pIbT/AArNhorPKXRHFobvVLF4Rv4eDiB6q2DL1U0uidqJg8iqNPnriZtSqd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kK9v3vz3; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8WS+hbdq1B5Fh2NL7XARvzRaDtIxi5l7NmEQz6DrT0i8zYMiGP6f17YcwQjY/Y56n6YkflPDXQTEKsJjok/JGP5pojPjSav0IZq/nJGqVLy1LUxY+X7XOMHVisN+5Txfq4ge4FWOx2EDlp7CGVaBIdiojCEpDwtC1sGXjBK9YRodtHcArizR9ZzwBIcFuhdiRPDA5pYiol8AC0t+OTvf3kEGBZqILf9YRX6FJq1yXZ0agDII/BFX2mLU6wqr4QgGntYyDpQdFbYWH0tgbOLquVS0xUeQy5cLXz/RpHLIYIG2C9g3roU2EDPzGC7U5CrgRMP5eRYjLEdcNUOuBhyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM4hIff1JpS5fex4GWZaNKWpMOP7rL1g0yAwj9pKFxI=;
 b=wrQzkxd5BWEwCb+Qt3SPH29fA/KC0lMydS9Rvv3DM+ZDrkpeeTu4VBTVF4TLZglBNKfadrPtfal9DBa4TGzniD61Pn6aEB/L8lgjP3SMm+K8St0V7AjMQ3W8+5VnASwg8nPylAsvZtHHzhcQ/nc+4YfzkOv3Wwek+gYL3B4dUuAYVp5yV6OBWLi3Rn5ESWVDycvMvHlPYTRmNp9hamfaW+IIcY/SXIN/vAkFdQiHnuyApZbAKefhBNdKpUstufrvN/D4yXjr+49uqXDZase+08yvsUoQkO2vjITXkfLEysXXBvyg4Qiy28fd1IihFarqtNuzo/wbIk1+K/y/vAoxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM4hIff1JpS5fex4GWZaNKWpMOP7rL1g0yAwj9pKFxI=;
 b=kK9v3vz3JUSkwKqALK64Xeti/Hldb5UK6CHeXOCP/HVqq2bDXmFttiXPNLA3Aw8KPeyrZ4i7n8s3DW+u/LfUzahpwjU3tGvS27+ABHew+PKHBo3GH4uswcvMFMcWwLlIc/TDIxcqyCu2Z6MOseQSHYRLAg0bTuG13SVpgqklR4GvHJAy5NPGe6QtsU3kB5MVDnXwYNLp8eeccj04x9JQXVsHqAKwbpI5fXIXHErz43VjxYVl7sTqab67ASIib0c7oIcFYL7CH5jvMqYkzbwGCw6RoDtPtF9/CrDFYORpWI5Zb8JTafzVNVUcLcv/4qmo9kLiPHaXE4QStBMOqZ0PDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 06:56:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 06:56:18 +0000
Date: Thu, 21 Aug 2025 09:56:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH net-next] ipv4: Convert ->flowi4_tos to dscp_t.
Message-ID: <aKbDCJWjMpUEOtXe@shredder>
References: <5af3062dabed0fb45506a38114082b5090e61a52.1755715298.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af3062dabed0fb45506a38114082b5090e61a52.1755715298.git.gnault@redhat.com>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7cbe5b-d61c-45ce-7d13-08dde07fd457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yLwyzfWhd3yBVqxWflOiZVb1Pfvifhr0axaft3qx5DeOdrDIS8JbqzuSElzH?=
 =?us-ascii?Q?NGnuJ9KBsYiBAFFaTWqmtbzfKxwq7fAm2jUMGXGjYyzGo84SeatxDk1z7xg/?=
 =?us-ascii?Q?abmCb2D+JLGpBodgq10jhguyRdcfR2jslISGAKKe6Vwf7k1Bzc0/HOwdTecL?=
 =?us-ascii?Q?ghUgCRiC/eV9LZg+HDUXmhoMXEjgvL8JaL+oy8qWMH8F5zB0+WRSJTnVvMJV?=
 =?us-ascii?Q?+8oraIPNWWlgQZb3zH3mlwQqywzC6bpIDTTL5v1ZSTeXif/8UWx5FJ/pAUss?=
 =?us-ascii?Q?5vVR5zNYW4EXR4RkB7bWgX9OSF6CKGzzlFWXP11tUEL6eTTx8ABcss1wrAac?=
 =?us-ascii?Q?LTmjiP7weKjcq8Kp3gOno44tad6Q9YR5CBX1nkyw9XsLwZ8IPhRd1nlXNCgN?=
 =?us-ascii?Q?KYPbAvlCMqsrK7+rpx7sj88aIfv5WP8Q6RjmoL+u2U1cCHWC6Knyyq9906jm?=
 =?us-ascii?Q?TO/kJKgrDas+VB9VG8F8xtfPLua5Gxe9Y8Mj7B3haV5f1A8HnvOKaD8sRScM?=
 =?us-ascii?Q?WV8bCM4tYGPgD7k3f5dbpVF2Io3naz+k37uNvZc+pPJUK0iVWSkBNtwpqjlc?=
 =?us-ascii?Q?WtvdetDyDQyPA88BtIKhCj5irj1uq5U5t9RW4UKLAjlS0BWFFMR4SHrt6Nr1?=
 =?us-ascii?Q?90YFiQ2pxy0bvAbEh/z56QWgk8qvO+mmZQw4eW3Y7pZJ2TG/BiKFeveQztSq?=
 =?us-ascii?Q?ZqxyJDNHmxANCT8CTk9IM67231aoXWs/3lBbXL2bDXRyDiGiekPGAWHKRiyx?=
 =?us-ascii?Q?SHr17ABGjndoh6j/fPxpgYXSZqt2zwbNmg1N4rEwneG90IVGTVkC/2w2ydlQ?=
 =?us-ascii?Q?jbJd2bm6Zn4xQj10K2zmwU/r9Q0yAFOXxXUgEJHM+siE8iHNiKADUTgYq6AH?=
 =?us-ascii?Q?mj0cTyE7ky42IO4B7Lp2p1FkvRyEcTlFFFn9hKT/66HezC0d6OR8OMF8Pexp?=
 =?us-ascii?Q?zXgw4kgdI2aKE1M600+5t12uyc0l2AFer5UzOHxcFMonop/dpO8dlxT8EwtU?=
 =?us-ascii?Q?AusawwR0NBrdq8tqfinhM3/z7SgW+67Qv/sYMYgfU/Q7sHwUILxav25KCA3Y?=
 =?us-ascii?Q?7XOEe15n/mstNSd+upqTayvYMsgcGZuUwhXCqAvkvEsD3wO+fOCB0eI4MMIF?=
 =?us-ascii?Q?QGAAlycUm9MvgdcLAroBX2uq03sbzd60kWsc8nB9jB7XHqI9HtXI6Xei1mlp?=
 =?us-ascii?Q?gWwQmGmNuGaYHnOspgMyFKGnRvt+dvi9pWnSTZqXdzR7ojC7IfzG+Oe/O0DB?=
 =?us-ascii?Q?auZBOrZNyBwWq++gzCCmZX0Bm0qeWtd6YmTX0hAJQtc8zkCw6hVPv7s3zfA1?=
 =?us-ascii?Q?ueXkbc+pviE6AA/r9RqUY9f+PFOA0jh1c0RvA3vZhT3qYHhVbMddsAG+4/qH?=
 =?us-ascii?Q?DccaEcwzSkUWSPfy10F+zt/CG8jHpoXkgxr8duTmZMTZi9FdZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDezQhavs+n3r9ekZYqN0OUfK2DZb79hEWF/CRHuB/IG8h2PPtF+pFiryAHa?=
 =?us-ascii?Q?QtNZv8B7XPDT8fDShqY41qBHFV+frWeUT8CLpShtFvcYHb5pkgf5LGtrz0Uq?=
 =?us-ascii?Q?oBQUSnLbPsjnZzDgLCm0YYrrFuh9z874LJyWMwjfA1/+vYVkCQSOkCL3a7y/?=
 =?us-ascii?Q?+CSgnljxj4r3Y7BddjSmcy5nktu7yph9VCiv8M0FjseIZsh3s4gjy1PZCZj6?=
 =?us-ascii?Q?0gKLqPWjNsHymTLcJzA5crOiW2JwEDbmF5OvKKOmMmsLy3wRbqKZFSALFrUD?=
 =?us-ascii?Q?66j3mn/EuwOjjI1ru9P+NzPraiPSt6gJvC6nYecwwBI499HdMoIX4SiQPP+q?=
 =?us-ascii?Q?YLj9JohTE+N9XaaE8PhsJtLBW6ULB2fHKY8Jz4cOFCsP2FU8JFN7Y+j9D9tF?=
 =?us-ascii?Q?TIZC6O8dPanAnwzEdPwfxk97qXwPCLiuUM//NwjVw9kh7LNAOdnhpdL2u5WJ?=
 =?us-ascii?Q?sZwEPv0eyGDFfIOlJp6rKUMQInYXm+HbtiCopm1MAmbSGHgibeXcDodwpG5U?=
 =?us-ascii?Q?rzgfcyPhZEwX5wBPuETY6zLyPbcAqzek9xxV32tIW50HXEKvp4XIw4CHenXk?=
 =?us-ascii?Q?SAj7SfeQEfatouKBaVMNQR1NBKRC9xYAAMkqw4gP65WCMBjhBohUFpjB3UKQ?=
 =?us-ascii?Q?AnVeTyJX3IxtkWbCNLBswxaIHUNui9sjpw3HydsaSwksdQ36o+/fZaGqNwNw?=
 =?us-ascii?Q?Msivr0ZtvdDvbT7Gp3ADNeJhFlbmP1H242dqXLFIiWIMkaBinv6f6wTkrIze?=
 =?us-ascii?Q?h6j8fFNKIqSgn0lVq3/cbFErS3l77ap/4JXlKL1Vy6izwPjFDbEQOyfH0zuB?=
 =?us-ascii?Q?61svAoAs1KHmMtuH/DR1J+QvuMWgoW18PCOoKZZfwfcq35JSSqqVnGz8CDl5?=
 =?us-ascii?Q?fkv6fMN5Ix0SjcxLn3o7IypoVWvn3FwPpmcps1qxbmSV9BZBVWnNa2Da0VDo?=
 =?us-ascii?Q?SPoiaWm+ZfuLdHVRHYbWcm0nWfOHwyYEb2iNsX5v9kgyu6Zj7T42j4vf6r3+?=
 =?us-ascii?Q?jpflIFz/aiivczAib3SjORa/+7BpE8Ht4AqLQ/MDg1Ud0Ot8rguyA/meAHyU?=
 =?us-ascii?Q?VYBVqF0ecYy2ZNOwJgboJtsrh20hoe8IICHDD/BsNcjhfwY29KwiWWOdg0WI?=
 =?us-ascii?Q?EE5UMqCJAwHz6FwYIjE1zJn48TWL7MQtk4d6XFmcqifuVuU1ye3OoVoOZ4ZJ?=
 =?us-ascii?Q?H7IBTCZYACZ8jqdhpd1r/WwiXHsdRfJeyCdSl7OszSL2ITKNRAKBnX9fnQyq?=
 =?us-ascii?Q?6DOa/l27ijE24Se0pYFPzxY4hp34txDWpcWE/a3PelDvqMEXAVJZSaXBYp6/?=
 =?us-ascii?Q?sQpLugCAJE52YxeKWxH5idve1x3+Fcub3IjmG/uwiZ4mg8S30P6AIyqbpbD3?=
 =?us-ascii?Q?7xUfXWl11608XHP2KU+Hu4DwGBGQ2+NaDSr213fajYj7WYA21fOPDoM+FnbJ?=
 =?us-ascii?Q?fe9M9qZq5oZN5toyrG/MA+S0+6Zh+3AWuVISYbHRut/aMb2mrd0aUdHL5Hxk?=
 =?us-ascii?Q?IpMq199kbvaqcUopb8Py5O9F4J7MdFbUdC5mRE5+8vr6Srap/RQxtk3y1uc/?=
 =?us-ascii?Q?jVqnTfUuDGP0K9OV56/50sJpkUcY/vMF4RR13E+s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7cbe5b-d61c-45ce-7d13-08dde07fd457
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:56:18.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo4IiQlM5Bt955AglBX8R8ErlLLrZ8WPHitlCDwS6qMATtFT6TBuDA1e7qX3SESeq/9DiG15vQ1OaCEfZ1Y3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

On Thu, Aug 21, 2025 at 01:32:03AM +0200, Guillaume Nault wrote:
> Convert the ->flowic_tos field of struct flowi_common from __u8 to
> dscp_t, rename it ->flowic_dscp and propagate these changes to struct
> flowi and struct flowi4.
> 
> We've had several bugs in the past where ECN bits could interfere with
> IPv4 routing, because these bits were not properly cleared when setting
> ->flowi4_tos. These bugs should be fixed now and the dscp_t type has
> been introduced to ensure that variables carrying DSCP values don't
> accidentally have any ECN bits set. Several variables and structure
> fields have been converted to dscp_t already, but the main IPv4 routing
> structure, struct flowi4, is still using a __u8. To avoid any future
> regression, this patch converts it to dscp_t.
> 
> There are many users to convert at once. Fortunately, around half of
> ->flowi4_tos users already have a dscp_t value at hand, which they
> currently convert to __u8 using inet_dscp_to_dsfield(). For all of
> these users, we just need to drop that conversion.
> 
> But, although we try to do the __u8 <-> dscp_t conversions at the
> boundaries of the network or of user space, some places still store
> TOS/DSCP variables as __u8 in core networking code. Some structure
> fields, like struct ip_tunnel_key::tos could be converted to dscp_t,
> but that would require a lot of work, so this is left for later. Other
> places can't be converted, for example because the data structure is
> part of UAPI or because the same variable or field is also used for
> handling ECN in other parts of the code. In all of these cases where we
> don't have a dscp_t variable at hand, we need to use
> inet_dsfield_to_dscp() when interacting with ->flowi4_dscp.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks! One nit below

[...]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index da391e2b0788..c75f95c60af3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2373,7 +2373,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
>  		struct flowi4 fl4 = {
>  			.flowi4_flags = FLOWI_FLAG_ANYSRC,
>  			.flowi4_mark  = skb->mark,
> -			.flowi4_tos   = inet_dscp_to_dsfield(ip4h_dscp(ip4h)),
> +			.flowi4_dscp   = ip4h_dscp(ip4h),

Nit: alignment is off

>  			.flowi4_oif   = dev->ifindex,
>  			.flowi4_proto = ip4h->protocol,
>  			.daddr	      = ip4h->daddr,

