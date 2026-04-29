Return-Path: <netdev+bounces-282378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMFlC9398WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:47:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC864943F7
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9177D300678D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F63F54A4;
	Wed, 29 Apr 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vk2xSLRZ"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4003F1665
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466838; cv=fail; b=Gqz/vhruVxakYQnaF//056EvZ+Yicr/Xe+S9k6oWv4lcOVnpxXMGaY3qdU4z63QGxfSbMrG0+JKfDfAojMG1c8Xh0rV9l8+cqJguZ4QC3zUklcsBcrGZGEf4OPWch0tCuZ/kmMshR+z9JyJS2Jj6xM1pprS5f+5zG+zY/N89qZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466838; c=relaxed/simple;
	bh=QMvyOoI6QQXsIi+kZT76QvXBr0o4mD9MxdB7x2mXuJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnpGwDtKXGh7y+p48XQ5D+9cEq54sJi72in8tdiPNmKTNw+z4TtAIyetepvLaCdoONgS+Gr/MjBVbVZjruafW9EsytXMX+R+uYA3WpytVj0TrmWK3GiRKDVQJUNngViPe70LFNLOHSw2ZIkOr3vHmVFwMEKzhJYQrKHYOuSvdGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vk2xSLRZ; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VF2h6gCOR7LQqrU4XgNX7tpqWqwTdZ/VTxP23XWvSuVrYa3/Jj07xhkMNemJzyHw811d0gbDi4YoJSDxTSE73/josX3MrMZaQlce5MrNMVKKG0Pntoi4eh6wW0HgxC8fhdLfBP1z7PFpvEDhZS9jBB+kYiLjZVU5oqd8wd6gt6mFw4FUbG19MTFLFOTlQLePpdb2nhmB8mGxwDUVYvLP4OofVszETOivE8yZRqu6ZXH+a2yBMZ/YzBucnyLsgRzSOSB3/Vco6S3Z4VsrtUyr0mDiemMSr4FqeEvwgZ3wQy4AAzJV234Ts324HSF25fFX1LgbHJBk8LFxhGe9UxT38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13pm7Qhjk3E9Vdt/yds3+EerbNvqJDAuD3VIzz4Cpc4=;
 b=DuOH+tmG68mLfEygxidM94UrF0xSzCEd1Vo0fwHddqSog7nHJWv1FQ3phqlyeUrQxCumTxv/Zbq64VKw1ppnn+MhQnGxV7Hl9tIa+Jr4ItuqLqC8fJaiefaYYP7AQ1vwTObBKKOhcfiWfwpKyJVsgMGhJgLlt4Ara1o3QlfGEiJJM2oHGUsQnWChTfV2Kw3C5hoHoONdXtg8k9wkpsJY971nxTPWACoQJWHrATY/kLxFaNtlm1v3vxwJwIBV2e6d1x4gvYyW07D/pDZNZSN9puJoXiPqFIVA93wIK0CfO/MzYNQWFZ2sEG8rtXKkk2vn+8wFXIXe/SPJlDPpPu6f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13pm7Qhjk3E9Vdt/yds3+EerbNvqJDAuD3VIzz4Cpc4=;
 b=Vk2xSLRZ7+ogEfT4RX1WXOtdTmOOAYHntrt18gDUioXe1sM7pQ4BvS5AAE505sqqI3WePgVswxpZuOqWrXTsVbtjCSBherW0ZT5zj9e/JlTAK2PUPzDEJzbWT1B8YrCVscMGz6RszUg2t7GxK3h35NVJB7szngkfztvQm4/2SP8uCmwEB8nPgD3abIBSevN2KWLSmJ6m/0EScRi887cqQRdLHd7jQQZV+bQcbveovl5ezFYWxt9mI9w1OiXV75RkUtgwN/RRCdTF0OwVsJMyvTvIFL4oV0NI5IXWo61VoVjVj5KFEja2B1LVOt7ert/Bdp/x7kuQ9bmBrKOS7iBtBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:47:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:47:13 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/3] macvlan: Do not transfer operational state when protodown is enabled
Date: Wed, 29 Apr 2026 15:46:23 +0300
Message-ID: <20260429124624.835335-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429124624.835335-1-idosch@nvidia.com>
References: <20260429124624.835335-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfe7492-ff64-4b2b-9f9c-08dea5ed6fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ObxKlK2+dF/GaHvc8JXcFQJYSTvP4IPcUAOFB1UxHOf4zVm4pnTWT3qA1GHIb1m0z1a/vAsQMMhM/5Q3WMATCfog87JiISHZ3CoVEPglAiDtHva3c0P0FDYPTpcas5RpPtfymAI94UniqSsz5WHyhzYrr3TzjKx4C0kjYQfh7gOd5FDRuFIUjAHO0dTssGxEF/ycfEXVekVVhtBsJn/b+9IE31ovFc5wMTqMRY19oJaZyJ0Tbaavj5IEwWJdQ6cJ/lmcR+dFnnC5UEKib/ybG0PHUocyQJpjvBEyd59cQKLZAILy+6DHCpT/FTh/cfNhfGBUgNj+PwR18JWeR39EFWJONfKGJyugWj0HrPoMcuRA68cO9yznVh9hd7+aUMAiuxRcCRVNxG9IJPXFxrKKJV8w6LxmzlGFanl74LHLLaAVhCv3jPvSDt/c4w268H6TK2eU1zefFjn3nnqFHx8gn3ckg0uQ2DwWM74VDANhWsfrdiSl66Lmq9wExwT1XV8rBBN/ebPupGb0/3RaE5LQhI4hAQQPWlP+9RPtZetsClVz3WlVyt+Z21IlcNQW7fIDCxag29rqB6usSXdD8G8MdYv7WacETs3fPvzahXZx8hFEWdKjlrRpuO/lIq5JYugw+U5p/eyK5BG8aYPe4UCcbk8whs2AvurZlViS6ovVnL1QM5JVx9vZx6mmB3/CGI2Kbu34LdSon8bLoYPaUM6aWboWAcsVA4WpHoUZQnq0T8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FxivRfAS6283cmg6eS75TKy6VkoLXC4/NADVvJzQFSTwQZcCuBfHWU5ERsw/?=
 =?us-ascii?Q?8x+/ppTbBLAfcdLPmBxRxSsHQvT4s7TWSkmHLBrEqVKZLn+VTuaHuGQytCVR?=
 =?us-ascii?Q?mOzfirUFjPwwOI7+QpP6Qe1sPLY1cm47/EAHiC88R1vBvnJQ9akqeJlvhm6P?=
 =?us-ascii?Q?CCj7rfxfZjNHaYAuSixJDBFM/dsG8UjCVprZTodVAQM9WdemZIOW7szEt0RR?=
 =?us-ascii?Q?UmUZeQbU5YFQ9rCjGMuDxbfPfUipBO6t9aINzsmwvWnzfZq30Ug19rtQy8SO?=
 =?us-ascii?Q?19GuceZz3TXRq6r+2pt8i19bZ1o8FcdyDdMB8+lIaIA4kKRaYn09+jSG1mtP?=
 =?us-ascii?Q?sXFF6eXBNVLCELrUoC8eWAXiNzH0ufL29CqheLAyi3kziI5bdVdWa30XaL9v?=
 =?us-ascii?Q?8vmqLXE1ve4kbGSOX0MwW2WzM7zCxsRXHzD4TXg0gMA9DHaJnYr1KSGlit2d?=
 =?us-ascii?Q?wyAhPch6/cb1B9srAHpLRk+DXQHVuj4Df5dTGVfAVDythTPQAg4o+uQinnAE?=
 =?us-ascii?Q?eYblb6En1KQDb7T9/1xmGweXKp9AJay1M7OuNgNeWR+df7nx1EFnCS6iY/go?=
 =?us-ascii?Q?Y4whPDiB5u6LNFZgeE9o1LJwFmPVcVXpNf4n+1mbwcqeG7tKVtGNdTkoahZ2?=
 =?us-ascii?Q?BnR3aJdKKoUewRKS8JqfImfM5ncnew7GOnUVqIfU+ekiUU0im+x6gRBjxHmo?=
 =?us-ascii?Q?TMafTHq1lyo0E8fhP7JVKgbhhObjSaHTapVW0UhJ5h57N47ZABz1Yb0xyTlb?=
 =?us-ascii?Q?NbKGmHi57HKYphYcoMqlXiEYHdVTwXZluwiqnxCjHGpRkXude1kbJMGV7eG2?=
 =?us-ascii?Q?ujuldtgkLTykiprsZBgHYurmM6LY+DqZUW5fz97pc/GfYuYVaNp1TzfodOGO?=
 =?us-ascii?Q?x2m7bPwPhXrR0L7vqg8QydCCjNwnUtfvz/8NgSr5gapK9GuIBN68KnpNG6tA?=
 =?us-ascii?Q?zerLQ6W6VK75VDTZUqQbcJDkZ4WDWWpWmQtX9Ot7CxuWNMfjWAuVlwt55732?=
 =?us-ascii?Q?IO9H5oZwTIVraRC9TBwdH0TIme6ecATzZfOyqjwQOxgOcV2ji90FbtJiDEQR?=
 =?us-ascii?Q?dRSuVQlW3+BCOR8pbNBvkj70S3NmdZwKl1vAj+1YIFhj8SYIbexsDAALmImm?=
 =?us-ascii?Q?XtMtke9UvmWPGuQnXXMVeDPgn3yKppl0VmdVnEnbaz5McD5S4PQB9zQO/hBz?=
 =?us-ascii?Q?XOi5lWDo/6Yz7wv+4+nxN0TQPvHdspXOnuc1zZssD776/hTmgSlhUTYK8BAN?=
 =?us-ascii?Q?ex7IJUaIA+zVOdBFOJoMe4wx/Zg8JFbxtg8xN5d6rQ/dwhfAa7LJJGsuIz0U?=
 =?us-ascii?Q?UlhePACLddiw1aZSXPdi03I6rBnvVhduWQh5+PG1TAi4MiYKqT6G9KMYpqA8?=
 =?us-ascii?Q?a8DkJxDpjTPppWRBQqJQ2Qg0LtF+DmjEKoA9nDccqFdtaF68laWrRR0auIsQ?=
 =?us-ascii?Q?sFcYNhb9qW++O/zkmyyoizrD1h9ZGwx9zWkoUfu/KRkBRljnoIu3Z7q/d5+Y?=
 =?us-ascii?Q?ik7m26xXwKA325S3SbI6P9rJ7nm05uZk2ZpJAa5dvTOpQ24FozEUkYUbjmX1?=
 =?us-ascii?Q?AIQJlzHdEkjbvuM/gXFz2mcK32Vg6W9f9fafXM+wE+BmG6EfvW1TQuo6Zhzk?=
 =?us-ascii?Q?DKZpXBWMd7q5aOrqIINStLHNox7YXa12xnFFTGd8jK+TEMOr4dGpZfxTZCsI?=
 =?us-ascii?Q?tl85rR/oHCbJGTPEvYyt5DDIv3VKdS48H3deBgmZ2vtejRiI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfe7492-ff64-4b2b-9f9c-08dea5ed6fe8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:47:13.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkJ14IbBVlcT1K41tyEGUuzNqKcNGEGGjh7yFe3xgqyBUlLX3ltxElLivuPnyBUNJOye+nRT+AcVjqcmFkNHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
X-Rspamd-Queue-Id: EFC864943F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282378-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dummy1:email]

The protodown functionality allows user space to keep a macvlan down by
turning off its carrier:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>

Different applications can set different protodown reasons, which
prevents an application from bringing up a macvlan as long as others
want it down:

 # ip link set dev macvlan1 protodown_reason 1 on
 # ip link set dev macvlan1 protodown_reason 2 on
 # ip link set dev macvlan1 protodown off
 Error: Cannot clear protodown, active reasons.
 # ip link set dev macvlan1 protodown_reason 2 off
 # ip link set dev macvlan1 protodown off
 Error: Cannot clear protodown, active reasons.
 # ip link set dev macvlan1 protodown_reason 1 off
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Unfortunately, this mechanism is not very useful when the macvlan can be
brought up by toggling the carrier of its lower device:

 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier off
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Obviously, this is not the intended behavior and it is unlikely to be
relied on by anyone. In fact, it is a problem for applications like FRR
that use protodown with macvlan on top of a bridge as part of Virtual
Router Redundancy Protocol (VRRP).

Solve this by not transferring the operational state from the lower
device to the macvlan if protodown is enabled on the macvlan. Note that
READ_ONCE() is not needed as RTNL is held. Also note that vxlan (the
other driver that supports protodown) does not suffer from this problem.

Output with the patch:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier off
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/macvlan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 61effa295c49..50c0bc8a38db 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1822,9 +1822,12 @@ static int macvlan_device_event(struct notifier_block *unused,
 	case NETDEV_UP:
 	case NETDEV_DOWN:
 	case NETDEV_CHANGE:
-		list_for_each_entry(vlan, &port->vlans, list)
+		list_for_each_entry(vlan, &port->vlans, list) {
+			if (vlan->dev->proto_down)
+				continue;
 			netif_stacked_transfer_operstate(vlan->lowerdev,
 							 vlan->dev);
+		}
 		break;
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(vlan, &port->vlans, list) {
-- 
2.53.0


