Return-Path: <netdev+bounces-285254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MFJNJ9x/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B14E72FA
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13A763021AC0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA913B7B75;
	Thu,  7 May 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z5XIwOlx"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2803A9DA5
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151607; cv=fail; b=sSO93gVZEa+y3J5avpd+LsXQAW2pfmUFTFjAOqxSdfZGHpFPbq/PUsWFbucIZZ6pPxTbU4b398790T1sRwXN69PTYHl72gm2fUoX/ZrKYT9QH+SWcGDIPK1zwalFMXzGTCh348eQ1CCBlo8fZxHnVFv6H8gKO0pcJZGUT2MvBuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151607; c=relaxed/simple;
	bh=jjV6gZaq5SvvxYG+RW16KtIcsS3aSEKMWgjtMDbsPnU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mY4QicxUutE7NYV/VcYpScB2DUsJ1iNneFP41fyOJ7Ov7MFFaXsCk+gOMso8iL0GUZpEHMb9+9jeQaJFnKJlmDsYtztIUw2BL8/m+h8JNYnirOwMG5WJUn8LgBuofKV1tnPhueBDH+r50RQxrFJC+vMlYOTzqgtJSzknGI3uE7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z5XIwOlx; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwxrsiAFzWJEU8FuAlC/J9zhd/gCe12idzxQc7AUYM7DWUlzcF+HvXOHk9X1zKiufN7fk/iH+8ndN4M8lMUDds40IDmNeSZh0r0hFpw07HK0uWMzmjnymMHc6YWxl8CHPbTZ3stbfUYW/OSklTeWGuADbxPn8BWuWOwP1xInHlDSF7I9tZLhgbC0GaCI4XqsD59740EauhZ2vgVVKWB4Um0zlEERaKRXG1BtEr4LCbW6+Evu0CkqiuI/2yepI/J4AMFLzfOzOg/0/IS5b9p5V6nLFgz7YH++waK0MolJi+47dHiCgT7IUbauvNlb6TqpdZcm02Kej/dFlFnS0szhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEurFSoj3enI1Zd6Ow8V1aEH4mBhiYMgKkC9B5+T0Ho=;
 b=X8wI2vTchsccx/cMuaga7hEG+fU8iP65smbGx6IfRe1TRzyZ1KEMgf1FQWF/q6UVFRkhB5lZsodUqrfqww6/w1pGlpMt9br4g3o2Q2RBYBvbLyHgB9SJ6IyI9jmO/8KIN2B0c2IYtRkmWt8WoON6V7wxQzchtsikPHZUTOiwEpeVi6QZKfrzX2W5apu04lKwS0vSxDClqnGkzqpDn9JfDqIIcce29juyFGSeRsZGox4g9EmAYpSZ4xJj784/lO9LowZmYSfq+PrGxCQgenZDlLyrsORcgGlzcRPQDS4cxp/8BlOY+ArZKlVqfYQbCFuKZUrpkiVMoenl03Qx5XdsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEurFSoj3enI1Zd6Ow8V1aEH4mBhiYMgKkC9B5+T0Ho=;
 b=Z5XIwOlxKDBT/7KrW/jyGyG3zJ/R2zsJaotq2Sq4gTxtvczfnjese4bQqBMe/XxWaBJr6c+hT49PO5O25oMxspopPDBHQAKEx6EKi2FPkm6KtByVz1x2B84fv/FSxreFILH3MTp9vynoLHe8K7J2Hsb4OijKiMF4EzzghkJtDrsUpffIxL0knAS8nQa0gg9O/SPqOZPojaI09/Kil0LzrdDhgsjyK+xH5FAtyFfuuIyfc6ciMKbZ52Bh7WBHdeaT1I2RZZ5fCXcT1bg8i199NKGC4t0Pn7IaqGm7lqWYUYEXmBaEiMmewDmvWmM01UpA8djzrWT+bXMJKDO6/cF+EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 10:59:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 10:59:56 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 0/4] net: Fix protodown with macvlan
Date: Thu,  7 May 2026 13:59:02 +0300
Message-ID: <20260507105906.891817-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5deac0cb-1b19-478f-7e1a-08deac27c60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Xs+eOXOKXG8dszNNpZ4UFcgqiFGj7LPS4nGmrawUeoCexTqDvMTVNjt/u/pVGVpHhz370AZmTXmd2+B+XDLZksYBjPFq1ZTwTYsRkMyuHEi6mrCOaaXoojURrZ8sw44yKTiaoTCe2ob8mhQXsHJj99I3TF7wP+U3xwzUPrEQOYKj2+BW4arCHjhgbnW3NnW+fkIfyKQs8W5R5DEV4w7UB1VQ+wbutcNEwL0LdVa11CNTG3SNc5alg66PGu45u8Xm5YbCSeFntnsFQJAWSxgMLqxDX/ocKoMp9hmfox6lK9joyRnnVMWJyaS4Ttkq7jh5L4mxO5VeO73G1kEv99bbjbv0BmyfmnRjEh2vsuqShRW/Mif2v+Z/1VhUC1qwvXexybetOWGNEdkmne5Sph5R43DNQi7BgdfSH2Rn9bJw74lBNKdRHssTuI5rZRj+M1pZLgAcBs7jU0F5LGdAMXIT6QhkKn/Q3wLMUPz10VRqvar1RJjtraBnMItN66YbDo/g+mAdvUPKkTswcKc+8U4kEOgnVHahQqXHMZO7Xc82giKUMphi7uqPIBRs/BZFqtZfYQ3wXFokAdbHpF4XoZlMo7i9OhyevXqI7fNqnr/zkp7rENoTXLV3snnrfrBRumWSeEeZ4HBA1kYCIjHLbSlXt+RKjJwKGfvDAGe9mUD19jc/qWKuiog9iiHaqotOl2c7CxjR/k5QM0l2WhZQKUo6JQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IJijfvaBATQQ3frtR49kwwgumdZPcHxDOUm/Ejfxq8qQqNFt0k7A6PKMlra4?=
 =?us-ascii?Q?NJIYnyK+nwHdxny048xX2TD9zfttHXEei3xRMjlsW5VaTG9P/0vWaW7VOLMg?=
 =?us-ascii?Q?WPgEWyOcGySEjjoe4dyguFEMcZBHxswPPp09/VhRFMyu/BjIKSvgkqJJf/PN?=
 =?us-ascii?Q?qVp5ZdbGExJ1WAsMFIdE2wiSWkhqBD5n+Eq55s+d7ExVvWFnMkqpYNUjv5qG?=
 =?us-ascii?Q?Mj9iCQ02y4dXypricY6WX8+jkY+L1QnWbtCytUxUpK6dKH0FWAvsxN+Wgb65?=
 =?us-ascii?Q?crs8HEKfB57tTylAgagpQCa1Y7WxrYTXFes4Hc71vqc5/0ZIYvoV6Ez/16es?=
 =?us-ascii?Q?VG51tzCgIArNxBayRvnPk5tz06tipLWCY4kOVHF9LY4WTKywP2ElU1KYE6p1?=
 =?us-ascii?Q?NWzq0Jmi859Rhevs+T17wta8zhuVfegZIhLy8qGHo2SQV9GCA5KhZLkmyL8t?=
 =?us-ascii?Q?L4uu6B64iilDmCO9/dBhDw1xhF1tbj0AuV1PTplSFD9zUyiOo46DqckyjQbA?=
 =?us-ascii?Q?NSNe7gN1CpteNDjZ5OVGG8wB/SMFfYyW7I2Qe2QbYfO4n1hyOiYWGZGgMIt8?=
 =?us-ascii?Q?5cECiCBkBDReO/ybohDKlUixHakADVtGxs+4EJzKgkwT4I431Ji4rEGASJj+?=
 =?us-ascii?Q?q0pLKKDI0lXYphBBiPKUB0QnTDMF3h76+slxYsjX9xHylWlAoRHBCfsr9r8d?=
 =?us-ascii?Q?vFBciaAlAg6q/FGzgAuMCN4bjP3T1RtRhLu/pVZdLAR2ZZOgwxM19oXanOyA?=
 =?us-ascii?Q?OsgsZum3Owg0yhofXHKmzUkjX4NzS2dRxiJ1bA0CWX7Ksm6ZbpXQzqbD5Ywz?=
 =?us-ascii?Q?nk+w0ODL7/nDgr/TBwpbLh8SqpRY4ZyemnSIShkKYuk9EiIUKyEqtzIqBoEW?=
 =?us-ascii?Q?xdM0fgiNwON3aBvt09gxEcP4sYp1uUe1dWaKDdbu0/dFK3CevPe2qDcNWnFl?=
 =?us-ascii?Q?iPAiY5e17JIpe+YpCPkY3tgQE1VYsYmtHIo93Qbe9wlD1CtRnvm1a22WHJ83?=
 =?us-ascii?Q?L9RrGbuc6qZiz0cNQpCHKvd4s6cLGcid5h/n09qXPdLewHZhaJSnvhzDG2GJ?=
 =?us-ascii?Q?SFuDCGbejk0QQfdFBAPQdYZ8CTzwaRHewMWh0PdJW1AIYH8VEd7pHwym2V7M?=
 =?us-ascii?Q?CWcz4LrstuWJxWyTuZFYnv3tY8w1PFC+nvk3HCGj6C4pxG3X1TlI1gaZXAUl?=
 =?us-ascii?Q?4NcY0fVoKZNshEQ4fUcGJ2dXuZf6tZSCoHqxvMXhlnDhU9C0F/Lqa6FbzOQk?=
 =?us-ascii?Q?PnpakmmecmxMVAqYsQStMu4EEfB4MdqveNtmJgXumPIuC0c0POWJy53cWqcB?=
 =?us-ascii?Q?R2CuNYwrc+ZV28fCjrvoI31lv95uV0brpvcZcDzIv/DcyABGyPFfDHBb/kIP?=
 =?us-ascii?Q?+XXK4WCOgx7mR5oqlWwlZgrk1UfGpNU8YFWQ6+CVQXtEMZGMIhniUwbgesjN?=
 =?us-ascii?Q?F409ImDI7LtUhREL0FONsJqaZ6k8RjDMHMqOtVFBaXttjkKyHIIb03WgexXe?=
 =?us-ascii?Q?D1KnC90eLZRYzV6VYLnFgLwXnqELGtGBGsOzcTtsubTHrRRTEfh8+znz46Ad?=
 =?us-ascii?Q?uGHOpARUA3XPYIrADqogFCsPcodS5h3li1i1X8l5bEntu53B2B5NEahad2tQ?=
 =?us-ascii?Q?shPOeRFjCOlJoxoG1p1JJVnqm9K0snXF9s9HP89KqxGTx3zbU29qXmUekLXX?=
 =?us-ascii?Q?XuChQ16UrY6gmFbYsFl5MQAQKTk373WnxHIW2V/bHx+lb2GE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deac0cb-1b19-478f-7e1a-08deac27c60e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:59:56.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bV3ymWVdpAH1ztFJoEwphj7pDbBbPKrDOPjSvwUartz4gOFF6kSWi2ENbcm+hNl+v+fmLhPxxPs8/+vzNDH5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Rspamd-Queue-Id: 795B14E72FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285254-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Action: no action

When protodown is enabled on a macvlan, two bugs cause the macvlan to
incorrectly gain carrier:

1. Toggling the lower device's carrier while protodown is enabled on the
macvlan causes the macvlan to gain carrier, effectively bypassing the
protodown mechanism.

2. Toggling protodown on and then off on the macvlan while the lower
device has no carrier causes the macvlan to gain carrier, since
netif_change_proto_down() unconditionally turns the carrier on.

Patch #1 is a preparation.

Patch #2 solves the first problem by making netif_carrier_on() return
early when protodown is on.

Patch #3 solves the second problem by only calling netif_carrier_on()
when protodown is turned off if there is no linked net device or if the
linked net device has a carrier.

Patch #4 adds a selftest covering both bugs and the basic protodown
functionality.

Targeting at net-next since these are not regressions (i.e., never
worked).

Note that while these changes are in the core, they should only affect
macvlan as protodown is only supported by macvlan and vxlan and only the
former has a linked net device.

v3:
- Keep protodown restricted to carrier state and avoid changing /
  calling netif_stacked_transfer_operstate().
v2: https://lore.kernel.org/netdev/20260505081656.463158-1-idosch@nvidia.com/
- Move protodown handling away from drivers to the core (Jakub).
- Add a new test case for vxlan.
v1: https://lore.kernel.org/netdev/20260429124624.835335-1-idosch@nvidia.com/

Ido Schimmel (4):
  net: Set dev->proto_down before changing carrier state
  net: Do not turn on carrier when protodown is on
  net: Do not unconditionally turn on carrier when turning off protodown
  selftests: net: Add protodown tests

 net/core/dev.c                           |  23 ++-
 net/sched/sch_generic.c                  |   3 +
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/protodown.sh | 182 +++++++++++++++++++++++
 4 files changed, 207 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/protodown.sh

-- 
2.54.0


