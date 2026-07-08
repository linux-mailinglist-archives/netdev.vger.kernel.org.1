Return-Path: <netdev+bounces-305796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uyW+DIxFTmrpJwIAu9opvQ
	(envelope-from <netdev+bounces-305796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B083772662C
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ig4nqzF9;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305796-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305796-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A6573007B97
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7103C1080;
	Wed,  8 Jul 2026 12:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A7322B6D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:41:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514504; cv=fail; b=YbxPOgBNgjPaCtiQaaBy1IMu/pKatGPY3cCgJcTkjJArp0QR42SJmltL+1xNIqD8ykxpX9l2ln9d+EgsNNiZjj9AMA4pKqPwHg+ttYZJjdUD9igpDhSAuXBQlUMxJxGmHjOQsGr+KswvL+LsH8qPsoaSxdKFtwv/20hHlQTozeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514504; c=relaxed/simple;
	bh=DnOOYd/B3AKedNSQ1BK5Xt57lSoD24/n4Tv4mfszTrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBl098iVuCy6QshJ6yVckxC92sIyMyGb1wulbLaBSE9V7Yd5cxAkdQ/rhjdcK2xD5LLtzrkfuE8kYWd3CvwBQCHxQ44u4mIWp46ax6wqIDJrylPUyESbTaPcYSZmeJoPsts40SexoPKBMGwGW4qBNEypMH7r7JbX2RsxTupE1j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ig4nqzF9; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCMiKmYS2EbBf1gnhPHLpd6r9T3CuOjdtYKyOlIIAFFGOq80mhrlqHjTEq0rTViwBMZBU05d0pol9yscDzH4p+wM7jOuINFQUSMWJoVon4yBGNCsoRX6J27cHEBcF65jp1TXX4ZkBZF0+iKlxdJsb71IuimUOkTAiAERpZ8WFZWG33rjq8trNLwSU5VjqyZDEl708BJDt1Hk60QtU3sV78L8Lo94D5UcjNpijDftJ+S2c/AHo14VUGMtAiL88Eq73mOOuXc5zHORzlga/MKobiP1nEIhQmm/6JZTWdgGLRIL4nmIrhZitCaNI82RKBsa5ZTi6dHyhgBCbB8KikYtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSoa/XJxkA1cG5YOtA0omLlBSLiAfQVLYhiLxaXW06I=;
 b=zDtDzxQq6e1PoresObeSQNXIvnw3NIczeaadiXT+FWFMF9tMLizzIXn/Zjb6PHHEPUkIBQ4G5wegCFhHRYGZDx0tWiXQsz/Fwpq0aUCaTRrMOVwYJ5m8Zf/hQyMnQd2wF9y1cdvq5Wk8Dz0/NoQubu2+ZF+0V7Ig7RjiP/YGxzfNNUXFVrgdXebzJyqfP1evfnE6iZ8x1r5g18blNTnTbWKwKIYenQdfgP5i7pw6d2Yg44aYydSTu/SUlgOT3GwzfVn/RfyQjiW2rP9JcxHFcGsQE2Irk9k7oqi66wYuEWbr7Vm9Xrq9ZjzkDr7mYlD+pdXH+FcyMBnnsWyqOiCk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSoa/XJxkA1cG5YOtA0omLlBSLiAfQVLYhiLxaXW06I=;
 b=ig4nqzF9U+CxmSjrqlXD8WWSlw+TcS7ph2J1vMNWcVLWHsjvSHZqHWY2nCxnO8nZuDwI/dElGHfIvkpiwbeT048uDdDtKVv23lGU+fAz3t8AiIvLs+L+GYDtC5crX0NIuRYBJUGxwcpjXS9vd+IJC2E435SzIM98jwChwb8bAm7WYHda1sp60ehtkAcbrk89ncIoU4YCbq1MC7i/k+oz+YR9TlsnmdwZQMKfgVhWLgxujhbHq6sC4tMwe94l9fwm/4U5u95VIDCVjBMdH5PAEfVFji/fd0sfCpfd80zeYtQZ+3DPWGmb7uK1Z6drhrZwtfZY6AaFgG5RTCNnmd9RVQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:41:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 12:41:39 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/3] mlxsw: Convert to async version of ndo_set_rx_mode
Date: Wed,  8 Jul 2026 15:39:31 +0300
Message-ID: <20260708123933.1303291-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708123933.1303291-1-idosch@nvidia.com>
References: <20260708123933.1303291-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 6160eb42-4ed4-4bed-ded3-08dedcee415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	hT0VaT/F8YZykL45WSkWVMRl1Pa63FPmK48S3wy3M85vpiNFYsCMVhuVXKt3fGoWyv56kTMkXIp6P5g0XxT4RQzhUPUva1nnPWtFc8keOLbJLZTAi7TYeRU+stg7vMHX7tGeNvGjoe3DGNylerPpkpG6i57nse62vceXDaV18T54o50JcbsiVL22NQEQoRWXxIAlj8GrXBfou/v5PvAPHr+0ewcrxHXTEXK4UdmD7zTeIpxYxnFIHKBWF9TRLVuWX5wwS06NpUM36bqzWXRpTLCo1Xkl3MjmkSTn1u/8bEi1I3x+uvTL19OYImtj/uxSLCo8OsfXzIWD1Vuv4QNl0qOx4of1S6BfIwpAnTUt8LJujtVcpLtJACM/nAHZB54Vjdx+85KuRVgtlrXOmvl4OCI9UUimX77B+dWRz97x5947WhvZrmuA4RtyCl2Do52bu4M2stFQyP3T5nsX58tEM+UwvGKJTrQG9uJVRRWdpDUgTxu3bvZoALS6Dn9yikT/mea6LpMNnO5eymMwAhXPHPOBA0/Xvcc85o/Ec2ne3/MxhLBivLwDYNHMR0WpR9PrOow+WpyzAvbkP4QB0dq8Cakp6+j2pX49+j4hEs1R660vJy9kVyoGxhqTQFhE4lieCmUo2rOATugKUoEyE1rIfX/+Gsm8s6NAc78x6Q88mpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b3HXdtBywCIRpcNRxGEONTFLMB0K0Hbzjpq1FFlh1dVHOE/SfaZ7YbtzGm24?=
 =?us-ascii?Q?6g4BcmGBif4dRpDjcTS52/MWi3m6HVtzCFZtBUxIVkOcuqJ8+Ux0KO2pZfP1?=
 =?us-ascii?Q?P4O+BtNzTFYx8zVzYUbjr9s2j6wLroRF+aQcQB2ikIjThPKp/dil89leBdxB?=
 =?us-ascii?Q?dvXHKPkLWHuB7XU8ibnrZaSOYtEibsS5gfQxKY4uq1yLDNlaLUUQN5JeJ21W?=
 =?us-ascii?Q?x4FP2EA9MG5JOCGHuouJbyXCYx0sScr0MmC9YijEWWMgiNjQ4Z5g+w5bUhR8?=
 =?us-ascii?Q?cJLRX/YRTtGiJ5YrL59EoOhmexJq/abYeqF2ivCfqEcejPRhrIq8iJFv2aWz?=
 =?us-ascii?Q?PdySPFza1AXPnBUlylGdvGY8ZcjghAmdCImU2JH1xoItGXbhMVWEIWzqmK+C?=
 =?us-ascii?Q?JwjzCE293fHy3/f0ItrWzvxJJrQe/EUA2BXF8SZmW2Nx2wyKo1PPPffrgfVd?=
 =?us-ascii?Q?GQg+neZeJVnuRA8c/fuJhS/LEECSIzB87a/wSS3lPuuQqz2QXaXKe5NDq0Oj?=
 =?us-ascii?Q?h4wivs9fRdXWq+5s22BFKEHUTLqCrFOiGENlIMVqU9AjSBU6xMo/D1oWZ5eM?=
 =?us-ascii?Q?iAlZLXyNpJ0i6P9WZMKj9O11uUAqiVNu3c/LGGwoVKX6ZEDCIMNk7MAtQloF?=
 =?us-ascii?Q?RfpqLX4RXK+HsbHf3p1tUrLXElrS6sHEdVjmPgMELaiBQdNMeUsWQ5qaovqn?=
 =?us-ascii?Q?koJmyQFcYFfYILS6Co4iZvF3gruJ7T9KcRX1H1BFsOfapF4/vVTIrvMyxnWX?=
 =?us-ascii?Q?BNoOOw08uMpwPrH1tBTPlLESFloqtXebDXShby4D7V9VQliKuZU6VUu8HYHS?=
 =?us-ascii?Q?ezdjPoYWkN2QS+UV9o/PEoLFBcv/HWhmCPn0hQaRNh2JVebqfzLMy3BntvJC?=
 =?us-ascii?Q?8feUx41GVHv2GfRn/HUjlz8Wqbjk4LkCiUlS+hyDnqOr1HxeU1X/FIjnvSM3?=
 =?us-ascii?Q?YFLs1R/mGG4qr43izAmxRE7ZRbkxjLa5zqCxSxy7QLoQgJSoiUQaeitN7M1V?=
 =?us-ascii?Q?ZC6fevSnw1EKO8xktmYXxecp6EYjKPWlg0TyNy+ZMx9Es8iNnXiBNo1DKA9y?=
 =?us-ascii?Q?akVcAficTKD501fO/HZUME1REubDjO4Sc2ux6ChMdEcKRe5/B5OhAg+obo0g?=
 =?us-ascii?Q?8/uOkNahdfhTL7kxeWeVJ3dWytt1G5MvCESPciSXqZO9j4Nr65rQkJnCBEjT?=
 =?us-ascii?Q?6oGHs1/WBuzWOpK44koPNPacKHOOUIaW8R0OZgTSMcomzNlSWzZeWwvX/A00?=
 =?us-ascii?Q?S8ffIMi19WMUs5eapRbjK+0/6hUBqUXZrIfXz6IM+Tj+/gASBdOiqrIQ0+om?=
 =?us-ascii?Q?AB8+DGpOmwF6tlTTpvbo0E5CLo11pD6W9iaZV8XevEOXGotCJAUQ9q2dDJuM?=
 =?us-ascii?Q?qcsQY5h06b1HS2Mn5qxwDZYypjLEJTyRaM5K+pm4TkIODrea4cOpk8xTpoG0?=
 =?us-ascii?Q?JIkrweBTwtLCtgx44YS6f6Hmgu1vdDTwt9adiM348W4FmUJ51tPCT4NdY7vE?=
 =?us-ascii?Q?5RnGBDTMFfv17gvDzesKxu0+7UCRzAQZqg4Zw+ziU6gysZVtnhDkNHOLpbK3?=
 =?us-ascii?Q?bIaMP9/NrKGz7smoAB16j+i9yL5KIkwAjcoHfV15iCm2eMfqtsqvAxSaX5iq?=
 =?us-ascii?Q?i6BCE00ixq3alSGRP1BboJWKUCmw7h+OyMzmjqcmp4gK2I5iUXPWaHrSWGWZ?=
 =?us-ascii?Q?EH4ArxJgiSYf+xx6qsQhCHJqQ7k9D+2K0DDbZUdX5xwy20AY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6160eb42-4ed4-4bed-ded3-08dedcee415f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:41:39.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OzV43cmB39TTmaP0xdF+jV1JwSFSDvJdf1U93uD+OBdLKYgH0Z7YGLMBGcvITHwamqyNOU/BDtn5VVVF2Cv0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:idosch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305796-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B083772662C

Commit c5b9b518adab ("mlxsw: spectrum: Add set_rx_mode ndo stub") added
a stub for ndo_set_rx_mode to prevent dev_ifsioc() from returning an
error for the SIOCADDMULTI and SIOCDELMULTI cases.

Since then dev_ifsioc() was taught to also accept ndo_set_rx_mode_async
and commit 3cbd22938877 ("net: warn ops-locked drivers still using
ndo_set_rx_mode") modified register_netdevice() to warn when registering
an ops-locked net device that still uses ndo_set_rx_mode instead of
ndo_set_rx_mode_async.

In preparation for converting the driver to be ops-locked, convert the
ndo_set_rx_mode stub to a ndo_set_rx_mode_async stub.

Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 82569162d2e5..3ee1272dcf0e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -663,8 +663,11 @@ static netdev_tx_t mlxsw_sp_port_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static void mlxsw_sp_set_rx_mode(struct net_device *dev)
+static int mlxsw_sp_set_rx_mode_async(struct net_device *dev,
+				      struct netdev_hw_addr_list *uc,
+				      struct netdev_hw_addr_list *mc)
 {
+	return 0;
 }
 
 static int mlxsw_sp_port_set_mac_address(struct net_device *dev, void *p)
@@ -1191,7 +1194,7 @@ static const struct net_device_ops mlxsw_sp_port_netdev_ops = {
 	.ndo_stop		= mlxsw_sp_port_stop,
 	.ndo_start_xmit		= mlxsw_sp_port_xmit,
 	.ndo_setup_tc           = mlxsw_sp_setup_tc,
-	.ndo_set_rx_mode	= mlxsw_sp_set_rx_mode,
+	.ndo_set_rx_mode_async	= mlxsw_sp_set_rx_mode_async,
 	.ndo_set_mac_address	= mlxsw_sp_port_set_mac_address,
 	.ndo_change_mtu		= mlxsw_sp_port_change_mtu,
 	.ndo_get_stats64	= mlxsw_sp_port_get_stats64,
-- 
2.54.0


