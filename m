Return-Path: <netdev+bounces-291332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG3kN9xXFGr+MgcAu9opvQ
	(envelope-from <netdev+bounces-291332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D745CB905
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FE0E3008D5F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D96F38657D;
	Mon, 25 May 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0sIO/y6"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D438642A;
	Mon, 25 May 2026 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717791; cv=fail; b=C0TwXt+aQ0bwgqHrP8AHG495LAa2KRC6ux3WB3Q0viyzyfNRvp07DXCcKVd73HsGECLTF8rWLydQoKUhyEedjZgeCnSQuV+WbAd7j620lV1tdlEYdSD2M6k0XhlOtckOLbTc86HneSsa9B2iZDLEYcQETbcEu+pj/R6mEFPtqrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717791; c=relaxed/simple;
	bh=OVImR6S3lOrKL2M2KgvY1mINiXOcIPzQKGCQCAfJh6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRQTwyvmrZOT6DosIdpXmfuyNVXT8CNuYPEN5H4Vea0KDrJXNy8mK3EEebVhO1hlPK/WQoQnaGyfzAD4h9IJNEcfGgP4lhAb1jUS7bmAYcFwyQgVSStZu+UEEf7M+bW5lMkDtoXEA46gPctpwNbgdrkuPhtRn+/as01TQwts3nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0sIO/y6; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVxh0wQjXNQsNMc5elpe1ZT87OtEifaYgviy2vDkw+eOrk3aKV/LbYlWMqovxDkfcZcL4PE0//XHATYeAY2gC5vSMoKQiJvvyrRIB38x1clWhC82bnfyCZoTnIt8K4v/oCU8KRskB/svk6I/AAVdHfDcFTt+a7h2c0EER/dgNHKSrkdgWtNjPwUTAj55JrLy+pEWWwvkMhP7kFal0vFs5fGOfjhnweYSJ8UlP6I9BMivxlgcizqIQHoFoO8qR2QHc3jnG7sVOCJoQ9Bm5D8LcSmgx7bEGlmWHZ9Gd2XiZib2GbOyarhiyn007GAkUURJy5oYeeHU2vOunjXbEik0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCRK6+bbQ8LjbR2PUF9IK/q3FLZcX3KIHt/Fok+eV50=;
 b=hZMUwExHWzdQIkpY+MPHYQvdiXzdmukCSXpOHKC0J+18ALY+wkUm4BMhuMgC3048DkFDxGtWNkEo7jmjVnzMiVaVYGu30KMRLdghBetqIjXr+QBiq4BrKI5rzILQgiNY7b9KUbTNycTgZpV1t19YW/C5bN8an2ZgLZmJU7zwtzkMHLisBIRi0UqVNPzUiyonpUa9V/5l9HC4RzXkoOXJad/Sw3+xn4JRskjK2CgM+gQU0AuYqP88y1KkvpeS6xgAcUwZORUH9ecrPcUj/PdxHZTEykfU8vW+xDkRdwPRM8m/dSe7ywS3BAPW2n1k4mfgiHzOzRk1YQjlPMcPeojN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCRK6+bbQ8LjbR2PUF9IK/q3FLZcX3KIHt/Fok+eV50=;
 b=g0sIO/y6cezDy0n0+EH3Sw+wBqZrU9jGI4KJdkk/GKKm5oNV3pRW+UAvmMqfMgXpdXCFwh3gZ+RLE9Zookvq+V2UluJb0zj7sEITcXjWV3h9Pu4Z5ucFWVM+Y6zBtgU6xflvDlzsyy5hi0T4mYlZziQjRTv6QaMasEdfFuuva8OTixE/CJSBPoBlyA4J46zWNTYHe7XjrF2bwQ3cBGCyRn5fF//IidP2n7/h3LIZA3cMa/XobTQYIMcyQWdLhooB5DLTYsom6h8SrYzpRyJ+EL5LbPzN4hZFU8BMyQ5+ZailbSXf2i77n5nMajliiur8NdRecXhRkpKRwwKekl2w5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:03:06 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:03:06 +0000
Date: Mon, 25 May 2026 17:02:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] ipv4: igmp: annotate data-races around
 im->users
Message-ID: <20260525140257.GB215190@shredder>
References: <20260522093906.39764-1-sigefriedhyy@gmail.com>
 <20260524135938.GA86099@shredder>
 <CA+7S2vJc7F__vWiprT9bT__+CUwSN_=jssAiu=GiLZG-Ho662Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7S2vJc7F__vWiprT9bT__+CUwSN_=jssAiu=GiLZG-Ho662Q@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: f93564f9-8e8b-4e95-ad02-08deba66583f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	E/2UqgRrGNattrYSC+HwIoDG/QylWgenjeHv6OuDK13O5tpJUDusaJfsRzmnymHlc3+l0pPSTbc497XTeRnEVzc1zSdfcjYtBkHQjUnZJoTE2Jqenc8eXiOW51IV9r17C6GjqiSnQPRQXbhjlHrZe8Z0QQWo9bRDWNO+VixTZBrjozA7kWkrLjuts8EWq2Rn+Xhqv85eZvJMEdgTZdH8/qAp4g6634gW7LBPMpmAUsNcmEoHStKjUCaHBL8v02TauHAoMSP871/Pm5P0Xu/IkUp7VNTp/DQa4Me0C01eLNylr//cU0eJM4Csb8lkkzXrwpq4ySIkDkk94Zvky0O/wZFGhL2Li0sTzb8HmY7Xv4Tx467rdJMdHS8zO5Y9Yf3XbHoydUJWwMzOC4iZBE4uBdzVHnuyOMLozkpE1fViGdZwvYZQNiA2/erGJDY1KqGw82btfHLvQhCQ4lqesVRiNqP+9WBpMENU6YMJPCBTrry3bA5X7s3SGI4xn5abBJN85jTnx3Wu23fQkly5p7rw4bRepa77QaIaIryxBnSO15yF7RAGhuCJj3j6pVv5W+QJhw4GYTWHVyAcMuajFzbNoC+C62dJ7oqJTHFH+C0RBUmps5IekMmrKEafrAvgmsaxpcUEgjrcdbaLp1cNkqesH5thVx7tRA5eR0OK687IBtdGIyS/q23yo9opX8k65gE0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2p3oAcMd69QuCoNVMEC588cx+sU782kt6t5KVp1s16n/LI74rMlpJfkEEelC?=
 =?us-ascii?Q?XQpXBjIvXfnGgKNZTVLj9JKMHxtfT/igR3iTu3nTMOqXyihuumO1uPlsH8W2?=
 =?us-ascii?Q?VYo21Nw5Tqp8DeC/8J3I15t7xEGgLerR5UX6dAIt/IIAFd//lFrqQzd5//vn?=
 =?us-ascii?Q?0PVPtaWTadI8d9bhLc102Q0Kku7xxUKMVINS3+uSG8UZiBFvwp6AxeUAhGK+?=
 =?us-ascii?Q?AStLdCkpQzn47zcbySYzbc54DNjKjKCFRh9xWClzCuTlH6rZH3tFW3GANTCh?=
 =?us-ascii?Q?VCQQvaAvKaQVm4SzS9KpvdP9i4+sOJutuAbDjkpIBJZ7AFy9G4v1CsYqWGw+?=
 =?us-ascii?Q?nmYp381VSVfTjbK+kx1R90WiaOpyKCfRXR8lsP6u597BhANxD3w42Hd5rMCw?=
 =?us-ascii?Q?jnolA1qugRzIjOwTLKipr6WaSpsBwjxsmt+pH7LGVSc+dH6H0xB1lGxfQTrN?=
 =?us-ascii?Q?6VLUVlIxc9iHgQjAR8NqQidETUVa98Vvt05nBTZlWxSDLw28+n+J8d2U45/t?=
 =?us-ascii?Q?ITPD07Do6z0npPHrGe7tdqUpnOJt7zfNtKh5v51ViSPmemq/wMmGszdF5Pzu?=
 =?us-ascii?Q?CCT73vFTL6ZK0ruspTnpqaJp8zet/9AI5VpIdM/otNRo7ChDhYbqRbiVZzid?=
 =?us-ascii?Q?I1YPstjbXCnb2PwyO5kMTjeFZHRFLqRlaobqUHMgIa7bPJOj2Bl55JN12Goi?=
 =?us-ascii?Q?j8+iWuuGn03tXQ7Z5zuS7kVjYtnSBBdkpctIgHJspgeKLMhBgggnd2gHjEh5?=
 =?us-ascii?Q?UHs8iFNfy9iv9dNUFvjPU9hKay9E3IEHVCDrGTF848FTqDgH3eookjGRWzuJ?=
 =?us-ascii?Q?sygR3/Xl+fKR3pQmJTDlhk1O2sxJ2NNngUzvdoEuQMcbSrUBux9CHVOFCPgg?=
 =?us-ascii?Q?BCj/2f6CnOCRDG+WjcjmYEU24eUt39RbYTcMk9vfhr/V+Bkv/4TQBXFw1JqT?=
 =?us-ascii?Q?BOdrHLCXHANqRDKrCNliMbjZzcvT5qJkssTUMHPPCVnMGmjPKwKAv1/N1hq1?=
 =?us-ascii?Q?spHIJIGvrbGeDYjY1VuOmv3wE76FgwFOv29LhDRfAFR1O2gum59Zp/SEuORI?=
 =?us-ascii?Q?1FTTpN7z2OCkMcmVBsHTEeCCkbwxBooulabpbbuRwsXKR2YXVahy3Eifswqd?=
 =?us-ascii?Q?f/f2/V+eKuhFp18z99DdQorPXktlHfOrz5BAuYw7GS4xwP9qH4bVPYKgKbgr?=
 =?us-ascii?Q?ux69rZ7kva93JRpV6erBPvfBLHRwGpVDgeXgMBtS69rUdEFJ3k/YPxkHKxZE?=
 =?us-ascii?Q?1SLHQvjHM8GgORtac3ClY4p2FF95nYRpz77W6GyAOkxGhxySQQ+0C9fgLrv6?=
 =?us-ascii?Q?sLjh69vhO1cUnOYGgHacWZ55EkbwknitPHlAk4xOzn/iPlsqXh26Y1Jf/4j3?=
 =?us-ascii?Q?/Ub2/MTMC+96zkVzJqn866pb6kC9uoNpj2L1kOK/iXRT+c1OoXTtGGMh8ac3?=
 =?us-ascii?Q?uri9uirpXqKh88uKv/IqbquIAAZXTiNNsomWK3YZESvPqJ7QHJ1f6K+J+JxA?=
 =?us-ascii?Q?nhJqj7tmZc0gRREudXcsAJylL+i/XLnGXwrqvsE1jN+brWWtbgHwxsCmt4Br?=
 =?us-ascii?Q?WxTw42ScZn1TrUn2OKvqbKbppCnDoASzAvg2crJLer0vZmX6eqWbU+Dly2oC?=
 =?us-ascii?Q?1m6Wg0h5Jo0pGwoRaOazzMQ2Se3+pZ6yCTkrzL1ANGs3lNZtQArh5AF71VC2?=
 =?us-ascii?Q?n9D8nE4KtjJvihXwFXfhgoH25nVsQOQyUN99iphC757iK9bo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93564f9-8e8b-4e95-ad02-08deba66583f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:03:06.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDki0vFbp5mccHWbX1hYl+0pvmCAt3fs1pa7lx8GC5ipax8qqLuxyXC/jmkx2UQ+OkXqfIb05Y5u40/Xkw0mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 86D745CB905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 11:05:43PM +0900, Yuyang Huang wrote:
> >This one isn't necessary since the object was just allocated and not yet
> >published
> 
> Thanks for the comment. I did consider not modifying it when writing
> the patch, but decided to keep it for consistency, it makes the code
> easier to reason about later. If you feel strongly about removing it,
> I'm happy to send a v3.

I don't think it's worth another version. Personally I wouldn't add
WRITE_ONCE() where it's not necessary.

P.S. Please don't top post.

