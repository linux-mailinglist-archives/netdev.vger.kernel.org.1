Return-Path: <netdev+bounces-282943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPtnOpaE82kY4wEAu9opvQ
	(envelope-from <netdev+bounces-282943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:34:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F77A4A5C52
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E40F304651B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9D46AF08;
	Thu, 30 Apr 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3Nr22ev"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C6276041
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566427; cv=fail; b=g7GYnByOcubOkbGFJMkoVNquB915KS3vZ13AhCqIADtbCz2QFNFmeRFLCGdcLw5bX2DzxzsqPMYqeSX/P6nGBHrR+8NgAI/6bMxPcSqavxpts1ulfujCG4zI7IxSGbQshxFULqVaAdST4nkzJyxPJd/3bm64FsGWbVP00Qnkrjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566427; c=relaxed/simple;
	bh=6uzQPR+4F8yeGdgIvjQqnX01HEOpg2W2FfVX0pCe1DU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KxvmrxjsDu0wrTTVi/Uzwl8QyMzZBdShmarvIan5Qtn+3sllPJL+hzL/jY4wjP2rbzH9SyfcsRzKMvpkA7zY8uXyW0z02UFVHZiJ+UidwADowY0PPiIZB0s/LXpkc58YrlUbxQVkUCW3dOTvzwufb/hSextBu9HRPfbKTt+7u64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3Nr22ev; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fn0EZkdAz+dbEVMW895jdFJSMfbuw68bZEqPMUby+xg0AKz3+JQTOoYAwHMvDg936f+/ajzLqqE0dhpY1gqET1s/wZ2vsDZ1BAMSCUfIwRlc52mBnv8mtA02c0aYAgFfTR28iNBVIPrQn1xvXUuaasHP7k1p9681WgBpN3CZ7txqbz7+caBjmw/+S8NbDHFLLoSNOBAoPcSkU519sRcgFGOBmq/mMHu3Ys68vm02kDruuHRb/bngKWZtSGM/XZEv9UycWprA8Hw+lNjoEUu0+V7iRVLeX7OFjU81047i+QXQzmgCaz6iWXI1YlDFFWQaM1woHTt25c4kV1RaOiwcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AN5ozWlTbhTRHWibVDXVzUgyiG5g5ynTgA105D7Zik=;
 b=r1iqgqLMtC3/zE8Ueyn36wPrB8jiZlKPtXKt3HIojSpZKZjigi3jnVnSWVtsaEd1e0/Lf0QRD+0OGa2VaPRlkLbp2xi2k7kcvzPzJF8PV0z9Vg7E7U2/1wparjdrpSMzvwY8xx4ogNod/yr0dlZ/5LhbosoFCouJ0luJ8G2igEkq8zoaIlTp4vPgb2WP1uxE2ca3QYCiyszH3bOabFNAXPrhhLEb1+l7DZPEIB0fyiakzULiPKk4DLmcv+ZHKpb1GQnt/4zx91BdJs2c6iY1ESEnskzI/KEcG2RIVjaGKCxLyyEil8ALPFA266/hfCCPjBRZVsfTPbqj2HfpFoNGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AN5ozWlTbhTRHWibVDXVzUgyiG5g5ynTgA105D7Zik=;
 b=B3Nr22evHnKIH11u6F1wFEJ1tbDRNTyeVmwKDkpxDwk3RFAn098fdKFQU7QpV6heqp+s6lQcpTe9Wezho3CAcfGiSqw/zWxv8Z1Na9MmJEtj2oLm+okCbC/mEYZy7hsUDDrp8xbjmAdvHj6UzKPgUKVetZXzn8S10JLe4sK2lxiqp4rbentNLrDVgT+cE6AA3cfOYAiqsCQxy0E9QhrRoxgPQwkmLgBhxOAcDZ6VKh54GCjMWRCzfmQEIuIYWX0bnnFo0VOvaAQNGhwMcjCMTUhyz42SFcg/JkUyUMkHxOnbxh0qw2KY3EI971qAsw7LrIjYQpjLMQcmv0J7KufBVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 16:27:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 16:27:01 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	herbert@gondor.apana.org.au,
	linus.luessing@c0d3.blue,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2] bridge: mcast: Fix a false positive lockdep splat
Date: Thu, 30 Apr 2026 19:26:04 +0300
Message-ID: <20260430162604.1043756-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 668d360c-c934-4400-1065-08dea6d54e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FYBXeoFph9tpJlKFfS5Dm0HLAJ91L8b+doJ61IX51AipImHHAzq/2nZPRJOX+3k7qjtFfKhPKEv2VRmUbssz4hMyAttdHfCqgzP6V7K3TsXi0VvG//3aBdbjTbwFaE+kdthvAlvqHDEwRTqEH1xqAPB4semobN/ohG9X2jk8uYf0HmerUnZbhF3rH9Uy1UncB1LidB5/eXUtHKVzbGhs1L+r6hFs91djIj6IgWe/mUN5u2ONah+BAKHARKKMkObOSPmyYJnnKjRqNPWmMPp2Nny05CQGc36+lPBh4/AKGKlRBRy7PSa4KWRFI6m5dSPVAca65MNOHB1LmGk/ZlH2qO2DeYv2Y1hKYC6zc4czzOIyChRNTJV8vVL9gjefSXmu8wkqvlP7EpIudiAIRo+NgNrambjP6LyI0uCrp7S7JbWjDAPMevPRBbNjBC++4cDnAmNGj4SXLvp/0xhiCJzYYYLNxvZe00k0DtIEkL1ybrwB2lAyII9ompUozh9j8xX0rR5LdscSG2rl3dFdCGNIHiFku12emOFU6QWluG0LsY5GwqddVuY32XGHllavUwcPZe6DJdJwyvSnsFVwO4pIEBsytX8FcaZNfS90VAuWc0KX9/i6ixr++ruk6iCOY4xtsdEy4owDvO8+dBa5ZdNtRMcPNBTbYDGjdzmdhJWwFWwnKJ/a7z/WKYfVCQVEXvqPR7imc2NSHw/Q7bJt9K7BgjRezXPK8GYh2jqEENX5z+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?or1XJ2ZSA7cQWFL9gTS2WVxaSMx7iSEXhDnMaKQR4jCAznTSUdvvIfUe1Ik3?=
 =?us-ascii?Q?dazUZ5VM7AB2ovNIBHTmAW+05FWf6sF/Dkbk/vAMZrLJjjfU9JtUMbShYwHP?=
 =?us-ascii?Q?amxBnf6egLWhTK3vQ1FlSqYzD+0rRt9vYDCT+99+A0/MbHPFwRYxHSepW8pH?=
 =?us-ascii?Q?GCoO0P2quUMiqF4qaSMB42uthRwMm0qzH/8zpJDWzUnX/USec7WxnrO5krin?=
 =?us-ascii?Q?gH41wrbHpkaKhV4E3Fqc04v1oYUXPQwARVpfwQwAYg8lEUH+UQN8pqcVRUIy?=
 =?us-ascii?Q?rBydImrcrz+pXlnNNL1wJ3+odwNNpAqikUo99bDEpvLrfViAFQQb728jS68o?=
 =?us-ascii?Q?pK0m5qTUNhCV7p7HBLXIz6dmNnXPU4WJnz4gtXLGHJ9X9/ewtE7mk9hCJCwy?=
 =?us-ascii?Q?nIvGqisPl54PCJj/KI3+WqSAbOI3BZclTx4KnLJW0tiG63Nkoe9ANtvebMfq?=
 =?us-ascii?Q?W5mNp+parL1aozqz2aYHPlobQlTZ3AN5ELf3Rmzkd6TINRvtdbpkzM1vQK0D?=
 =?us-ascii?Q?HwZN8lkvzTjOokH4JNu3ztVQs7oxVXYIHYjc9c1X8ITb20vi/UbJWHobVRBW?=
 =?us-ascii?Q?CxzcQcYevfv+Fy8VX73VlHilprVcrnnmEa6sWHBAf5jwoW922HAshMKsCFsv?=
 =?us-ascii?Q?+80gSuULQVgemsUxFQP4cdV3hcOKU4kzB9bU8cTvDWZdQDK+/H5O9s0E1SBy?=
 =?us-ascii?Q?UaTbHXVXbcbmbggpvv7L3bQ8cJXgfhFPeNKvpJ+NSoYG3fGjrjXewXK4QjMg?=
 =?us-ascii?Q?o0/WIuEmTeJLb8BBQN8IOn8iO71qIb7eMrEmlhURoVBYsZHAE1Rx3ZjW1uEj?=
 =?us-ascii?Q?ZogJxeoqUG4Yr0h0mh0ddpuzqK6T5JdUsEhikDY893HVdg4S/1O2I3F3bNOD?=
 =?us-ascii?Q?UfBnS2gD8N5dfwy0oFnDoOxZ4HYeymNXstMBWwRZKL8s/bDC7asvZv0L0Bxp?=
 =?us-ascii?Q?mo5zVXKE+ZaFzvwWOoCpBjWaNXjTCc86PoMJNutoTx5fkM2LeFG5qClMhhWs?=
 =?us-ascii?Q?WO+Bbju6jq9CM9DRVlBr0p2IdWIn3ejNB0o2JwnZxrtYiy+totIDSmDm6yyU?=
 =?us-ascii?Q?+DenUZJ8scduxM4TVEYfchhwUx34KHFc29acA5IuDhwOipAYW+xeY33hAIzi?=
 =?us-ascii?Q?Z3HRpAsGP2EMVj2ZT8n8wyduRyOvCc0rwS6DjBhHpPrZZMdiZcOfBSSGiLt6?=
 =?us-ascii?Q?OYP/6uDcLHSOprRUycul4xLfIXCl3BYyBXMLMTwr8nMbc0+paE+9LCGrLht5?=
 =?us-ascii?Q?0FP7/Oq7PnyunX3hOpC8giVeskNbMWrhW+0eTG9A4vxGqne1RXvZp1DDW9nm?=
 =?us-ascii?Q?WuSObJbBNfyZDNqLPcWa6PuXs+NfkLwSsflpjQK7cDgOhd1LPNynFhOy8Ytz?=
 =?us-ascii?Q?02nRH10yRJGkZ8HRYcRALxMQMBjdZ4ZrFi4kxHK3QZdejljF+sOeiIdq+DgM?=
 =?us-ascii?Q?RpZnFhMoPNxGts3hsOyL3DDnvqkf22a2SpPPE33CCIIAlcVQtxsi2GnyhAQ7?=
 =?us-ascii?Q?RSIgVcGYzGx+1CsUKERXiCn/qaYuS5ZN88XFRNSrT/wAnEHuqc3l3VfXWGSm?=
 =?us-ascii?Q?Sc7eTPUtPnb4SfYAncoUa1BwTblgJFVOdG0iymT7QqNeZyO4lFPggz63bixR?=
 =?us-ascii?Q?ieRnLU/ZNSWttY5A1Y0bD5dmbvfktBnE4lMY3BmJaXF//SPUsCApqzJxk08h?=
 =?us-ascii?Q?fQiH25GmPUscT7HwiU80pB5wN1stIehWHfu8pLMMt3lQUGxQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668d360c-c934-4400-1065-08dea6d54e72
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:27:00.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS98asW4Hrv7+yXfl9mmauQD+PSrWU4pKPQqeYm3+NeFF/D7/5XHdMypaOkfWFWdoGR8x9EboWkPfhtch1t4eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939
X-Rspamd-Queue-Id: 4F77A4A5C52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Connecting two bridges on the same system [1] can result in a lockdep
splat [2].

The report is a false positive. Multicast queries are built and
transmitted under the bridge multicast lock. When the outgoing port of
one bridge is configured on top of another bridge, the transmit path
re-enters bridge code and acquires the other bridge's multicast lock in
order to snoop the query. Both lock instances share a single lockdep
class, so lockdep flags the nested acquisition as an AA deadlock.

Giving each bridge its own lock class will not solve the problem: the
reverse topology would produce an ABBA splat with the same pair of
classes. It also consumes a lockdep key per bridge.

Instead, fix the problem by deferring the transmission of the queries to
a workqueue. Build the skb and update querier state under the lock as
before, then enqueue the skb on a per multicast context queue and
schedule the work.

Flush the work when the multicast context is de-initialized. At this
stage the work cannot be requeued. There is no need to take a reference
on skb->dev since the work cannot outlive the bridge or the bridge port.

Use the high priority workqueue to reduce the delay between the enqueue
time and the transmission time. With default settings (i.e., querier
interval - 255 seconds, query interval - 125 seconds) the extra delay
should not be a problem.

Avoid the unlikely case of the queue growing endlessly by limiting it to
1,000 skbs. Use this number for the simple reason that this is the
default Tx queue length.

[1]
ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1
ip link add name br0 up type bridge mcast_snooping 1 mcast_querier 1
ip link add link br0 name br0.10 up master br1 type vlan id 10

[2]
WARNING: possible recursive locking detected
7.0.0-virtme-gb50c64a58a90 #1 Not tainted
[...]
ip/339 is trying to acquire lock:
ffff888104f0b480 (&br->multicast_lock){+.-.}-{3:3}, at: br_ip6_multicast_query (net/bridge/br_multicast.c:3584)

but task is already holding lock:
ffff888104f03480 (&br->multicast_lock){+.-.}-{3:3}, at: br_multicast_port_query_expired (net/bridge/br_multicast.c:1904)

[...]

Call Trace:
[...]
br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
br_multicast_ipv6_rcv (net/bridge/br_multicast.c:3988)
br_dev_xmit (net/bridge/br_device.c:98 (discriminator 1))
dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
__dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:131 (discriminator 1))
dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
__dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
br_dev_queue_push_xmit (net/bridge/br_forward.c:60)
__br_multicast_send_query (net/bridge/br_multicast.c:1811 (discriminator 1))
br_multicast_send_query (net/bridge/br_multicast.c:1889)
br_multicast_port_query_expired (./include/linux/spinlock.h:390 net/bridge/br_multicast.c:1914)
call_timer_fn (./arch/x86/include/asm/jump_label.h:37 ./include/trace/events/timer.h:127 kernel/time/timer.c:1749)
[...]

Fixes: eb1d16414339 ("bridge: Add core IGMP snooping support")
Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@google.com/
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
v2:
  - Limit the queue to 1,000 skbs.
  - Edit the trace to avoid checkpatch errors.
v1: https://lore.kernel.org/netdev/20260426133435.207006-1-idosch@nvidia.com/
---
 net/bridge/br_multicast.c | 47 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h   |  4 ++++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 881d866d687a..e9f5fe01ff95 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1776,6 +1776,30 @@ static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 #endif
 }
 
+static void br_multicast_port_query_queue_work(struct work_struct *work)
+{
+	struct net_bridge_mcast_port *pmctx;
+	struct sk_buff *skb;
+
+	pmctx = container_of(work, struct net_bridge_mcast_port,
+			     query_queue_work);
+	while ((skb = skb_dequeue(&pmctx->query_queue)))
+		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, dev_net(skb->dev),
+			NULL, skb, NULL, skb->dev, br_dev_queue_push_xmit);
+}
+
+static void br_multicast_query_queue_work(struct work_struct *work)
+{
+	struct net_bridge_mcast *brmctx;
+	struct sk_buff *skb;
+
+	brmctx = container_of(work, struct net_bridge_mcast, query_queue_work);
+	while ((skb = skb_dequeue(&brmctx->query_queue)))
+		netif_rx(skb);
+}
+
+#define BR_MULTICAST_QUERY_QUEUE_LEN_MAX	1000
+
 static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 				      struct net_bridge_mcast_port *pmctx,
 				      struct net_bridge_port_group *pg,
@@ -1785,6 +1809,7 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 				      u8 sflag,
 				      bool *need_rexmit)
 {
+	struct sk_buff_head *queue;
 	bool over_lmqt = !!sflag;
 	struct sk_buff *skb;
 	u8 igmp_type;
@@ -1793,7 +1818,12 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	    !br_multicast_ctx_matches_vlan_snooping(brmctx))
 		return;
 
+	queue = pmctx ? &pmctx->query_queue : &brmctx->query_queue;
+
 again_under_lmqt:
+	if (skb_queue_len_lockless(queue) >= BR_MULTICAST_QUERY_QUEUE_LEN_MAX)
+		return;
+
 	skb = br_multicast_alloc_query(brmctx, pmctx, pg, ip_dst, group,
 				       with_srcs, over_lmqt, sflag, &igmp_type,
 				       need_rexmit);
@@ -1804,9 +1834,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 		skb->dev = pmctx->port->dev;
 		br_multicast_count(brmctx->br, pmctx->port, skb, igmp_type,
 				   BR_MCAST_DIR_TX);
-		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
-			dev_net(pmctx->port->dev), NULL, skb, NULL, skb->dev,
-			br_dev_queue_push_xmit);
+		skb_queue_tail(queue, skb);
+		queue_work(system_highpri_wq, &pmctx->query_queue_work);
 
 		if (over_lmqt && with_srcs && sflag) {
 			over_lmqt = false;
@@ -1816,7 +1845,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 		br_multicast_select_own_querier(brmctx, group, skb);
 		br_multicast_count(brmctx->br, NULL, skb, igmp_type,
 				   BR_MCAST_DIR_RX);
-		netif_rx(skb);
+		skb_queue_tail(queue, skb);
+		queue_work(system_highpri_wq, &brmctx->query_queue_work);
 	}
 }
 
@@ -1999,6 +2029,10 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 	pmctx->port = port;
 	pmctx->vlan = vlan;
 	pmctx->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
+
+	skb_queue_head_init(&pmctx->query_queue);
+	INIT_WORK(&pmctx->query_queue_work, br_multicast_port_query_queue_work);
+
 	timer_setup(&pmctx->ip4_mc_router_timer,
 		    br_ip4_multicast_router_expired, 0);
 	timer_setup(&pmctx->ip4_own_query.timer,
@@ -2038,6 +2072,7 @@ void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 	del |= br_ip4_multicast_rport_del(pmctx);
 	br_multicast_rport_del_notify(pmctx, del);
 	spin_unlock_bh(&br->multicast_lock);
+	flush_work(&pmctx->query_queue_work);
 }
 
 int br_multicast_add_port(struct net_bridge_port *port)
@@ -4111,6 +4146,9 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
+	skb_queue_head_init(&brmctx->query_queue);
+	INIT_WORK(&brmctx->query_queue_work, br_multicast_query_queue_work);
+
 	timer_setup(&brmctx->ip4_mc_router_timer,
 		    br_ip4_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.timer,
@@ -4134,6 +4172,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 void br_multicast_ctx_deinit(struct net_bridge_mcast *brmctx)
 {
 	__br_multicast_stop(brmctx);
+	flush_work(&brmctx->query_queue_work);
 }
 
 void br_multicast_init(struct net_bridge *br)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bed1b1d9b282..31e317a3529c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -131,6 +131,8 @@ struct net_bridge_mcast_port {
 	unsigned char			multicast_router;
 	u32				mdb_n_entries;
 	u32				mdb_max_entries;
+	struct sk_buff_head             query_queue;
+	struct work_struct              query_queue_work;
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
@@ -167,6 +169,8 @@ struct net_bridge_mcast {
 	struct bridge_mcast_own_query	ip6_own_query;
 	struct bridge_mcast_querier	ip6_querier;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
+	struct sk_buff_head             query_queue;
+	struct work_struct              query_queue_work;
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
-- 
2.53.0


