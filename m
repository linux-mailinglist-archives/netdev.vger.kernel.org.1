Return-Path: <netdev+bounces-260543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOrPAL+onWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:33:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D35187BF6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1FF6305A865
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDC39E6ED;
	Tue, 24 Feb 2026 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJUl8Z/m"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7E39E18E;
	Tue, 24 Feb 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939728; cv=fail; b=Q3VZNK6FmuSPrFg3GoFoeFYOOzEVKllXrggislVaOOfA8yER2a2aPHBsaGMjXpj9i1EU4OPih606fnuXywDdWVvANgnekHvdMF7ZNczRllumPfCmvyCYMkvR+D7oAKzrWQGn9/g6Vo4lnAPRTLX0b/ZavWAdB7axnNtRrIgmHTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939728; c=relaxed/simple;
	bh=3H41KOEVj2Ry/HQNxW/a/xNyFxoySs1FMslaAkXJRw4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ghi+h0zuAt4tpJen3gyNxvRCi04M9Ohj/Fokxo3Y2E+pkJWSe6wunSW+vgcw6MBuOJ1VCMvvh+RY/Td8bUseRjM+xHEjyCIHa2ik2IZefxTnphMgzE63RMmQbFfaCpubgtnIDpsPRFdXOkOJkAEDyVUYP6mw0Zy7mWebKzMc+9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJUl8Z/m; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/WGIa6D6+h/Nzb3JswWUtnS65x3j3Oq6/fMB2gIyagsFY3cv2d+QRISrQpLpqC6Jq3aDL2Zef25n3LEJPcq8aW9ZVFQxTMYAoXb/TvGYOSlNW+FL3TB4KAGpHTmpXA9v1Ahl/3BGWunYlOH2s+5i0Jg47ulBfwwjmvbu2V4AFLhRF8wg7D4Nn3oZluXEjOLPlVnpMCU8bAq1MN5K83ekTfGly77ZTGFVKtlkiFK/vGbo1JdxRhjCBa7iFSzENU7OyekbuQtD3rfcW/tWlUouuK9FhOkRd499OVWkSw8RyBaNAvf3RPSFY5P8Yn31uareBmHdAFiC8EyoBA4bAzbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVPM+8YpxPHkLbsliO8wNrSKN0UQCXvrMxSvTrE/Ix4=;
 b=b4JHqzRVnkSq3Xeb4mKthBuQYEnxwlzTxyfwO+QvBHzsvNO7JKFsrDpGCyiClZCYRid/v94FlDdYI4AaDohY0SmjXF9sMwgwLuTVSZQT3uDecxrPLBFy8np86Sx+zjYNVj4yLMMsua43ZpG0nBa1xXOlgzDRhDGzxzykjWDxnHTOYGEa4bounin0sw+SaBIJ9X+ksUYD5xqgC4wPXKRQ0SZz+9gKeq6sGvSFPTBBjiHfWc3G+EB0pP8KtKDwPY39mTU/+qm3V8B4tJRqroJJXv/2Ulax2RxlMh7QA98f2m36U4dTZwossv9taQy822wsNDZ626WCUrKfvkK3Enf5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVPM+8YpxPHkLbsliO8wNrSKN0UQCXvrMxSvTrE/Ix4=;
 b=iJUl8Z/mX6fJTQrtm9AMp48CM5qlTGSLqH7vu/4tXjMpH0D9jQIbJgUpz7E5A1oaskI+yRVI48b46xjMEoedVOdb0nbGn7m3MQLLG1im4chpHd9F12ND65VrwXkdfSdTKBXRVp+01KIj2Tswjr9CBkAj9/obR9F2Mnhf1cBJ++HaGfAJxy9gIYj07Kbsm5kSmyvNuQxfFrU4yaUamV+NZDvpDjcYupGpk4Bi8jvphuP1r3WtOSjAf/ebxNBfJtm6uVnupX3uOX07ZIpS12XXhYLlHf9EWTOQwSQkx/nzTHVf1Q8lTHXoE0DpRjmPCxM1m2Bz3PMpGT1iTQ0vTi8BAw==
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:28:43 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::4a) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:28:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 05:28:27 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 05:28:22 -0800
References: <20260223202633.4126087-1-kuba@kernel.org>
 <20260223202633.4126087-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <gal@nvidia.com>,
	<leitao@debian.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] selftests: net: py: avoid masking
 exceptions in bkg() failures
Date: Tue, 24 Feb 2026 14:28:01 +0100
In-Reply-To: <20260223202633.4126087-2-kuba@kernel.org>
Message-ID: <877bs2gtjl.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: da4752c4-fa6e-4128-e36d-08de73a8a195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j240lZkMSoJzwgpV6L4LBNonxFswn3KkfBj+fR600TESR84XUPvQm40KwPqn?=
 =?us-ascii?Q?R/JDxqYlgg7EDEdqjuZWPX8xkOE7/nAgYPUGYA03jXrw5sKqm0aoSZsCOauL?=
 =?us-ascii?Q?z9wEq5UjYeLo65ySoIM9gS4TAvXI3s8/u9dYKfr71B3kjorCcdxA9UfINTGI?=
 =?us-ascii?Q?Y0tH0YXInf/cjVEsPwgXGBdGo7NYg1Jp1Zfaq9QBBOPDCLKw9JRQM4+PypFC?=
 =?us-ascii?Q?YDRHM4BkeK1LM3Nl93O5ATF0yQwxytSNNd38tw9ng1UAWH1MRvBx2lVH8c3s?=
 =?us-ascii?Q?eaDmefxuPKzpgWQW5d7d8wbxUu5+pHUfKcRJ2dsG7GqUFNvTGCamDJSnkx4o?=
 =?us-ascii?Q?f2qaWU0lwrypwLurqu5gpaES37H7od1wFlacjMwDoF0/y9FqY48MX5oVRj+p?=
 =?us-ascii?Q?lCViI3bbFZgUb4Grgng8S/r7+fkbpD+E+WoQgwR1gojV2H1F+Ar89796i6Ks?=
 =?us-ascii?Q?jGrSvayqoYp9zcFGFqhUwCJ8eQf+3D39TQPIPYMC+p2vNmPi7fxhpvbpezR0?=
 =?us-ascii?Q?UHV6nAbhK8ipuibTVWUnccM8gmRiQrrnj6E35ZtcDNaPX52xLInJzIwQRzH2?=
 =?us-ascii?Q?R07yLodsc+gBt9QgAtU8sMKh6YvXpYt9yCu293ykswd0ML7vDV82xSRu9loL?=
 =?us-ascii?Q?Tp5oDex3Ie5GBXFYRkwNmBLKxJlBSrobdNMtsFn2GK4IksK2N3lBuMmKgek8?=
 =?us-ascii?Q?VP5nbi08/PVqI6wfzOFmoXjlShfFrnliwe6kD2P5LmCyrpzenJpzDmJQjw9T?=
 =?us-ascii?Q?XGpVYbdZsQ2dQoXynv+MF2vlRkBvgb2RWlH++N7Gb+2Ak6HkY/XIjtciF9IU?=
 =?us-ascii?Q?uaKJIimj798NNIBbCra3+WTHj0SCcvASHf7AEg1cUMoOdAWC+o91wuYkAVSS?=
 =?us-ascii?Q?UdV/U446bLEJtq6M+JasebeFJA3GIjDPWewUP2DsoE9mhvu/2gEFPgjAS5bF?=
 =?us-ascii?Q?MGpN1bSSxr/fegq9+8aDu2DWkF4Eh+jBmkehbt0jmhGl8eRub4JcqUDCCk8i?=
 =?us-ascii?Q?DU7CxvgMuzTTLsAV5JAP6WWshWCO134Qrsou1ileUbdwAjevNtWRnbOmVb83?=
 =?us-ascii?Q?UAFQyqT0Gfxf4b9lYiIXVINNsqCcagJCsGYzH56OBm27vGoSzvaqqCZsnwyK?=
 =?us-ascii?Q?HvAbJttavK+P5vXUQ8XYSCDKjys+OqeQCISBvDXh2jnGeSqkwnq73cnrS1kQ?=
 =?us-ascii?Q?gZo0rbhRoreRb1Ye2LRiKdeCE6s2sEe6gzbFeoEgcfBUQlw8OeyIrJWS9EGq?=
 =?us-ascii?Q?9rz9MVMYkMSrepG69CN0q0HEAlyjS0C6Tnx6slC3ob3Dpy8+BwBKDdDIyWDy?=
 =?us-ascii?Q?jevCcpY/P7i0n7+Uc0/hK/egg9P/K2kugDyUbJckE6h6/JcZk/mWgcz4nxng?=
 =?us-ascii?Q?Up4rmPNbuWCbzw9Ybw5hMZOhzMp9218yQ2i7CIpCIUAYbt7Py2kLU4CaCqBm?=
 =?us-ascii?Q?6ULZYtAznIGjdAjNj1kkAEyalHrzimL0Wg9u70Z2WM1z3xDUuawAzxRAuVpP?=
 =?us-ascii?Q?la8vNd0nm/3tSNnBAemvBpD9NycfIoSeZtiNxU04Tlw4u97xya1oioHQZEcm?=
 =?us-ascii?Q?InXyHaxaQlmVKSw+pwrpvoYa8BqrUfjs3ppAGV78jZjP/D9h9bMv0M8A1HN/?=
 =?us-ascii?Q?pE4jquKVfy5bhcySZGNnkQjQZJwSCjojaEOaCu3YPP+IvOKZTroqveJdJbPi?=
 =?us-ascii?Q?vNp22A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2oUSJqtJQVwgbcju6Xd6BADA9QXqVgmJWrBbdpkG/slnxn5ahqnkEJTvdlD4SBAUTqUYE+Szowmcizl5mkbyA6xP+vFiO+zj0feiHuuQ4iIQzRpHLY792huuw8UL9ecNVvyg7BxZvm7yrnnCurLpRufRJZiJpum62zL9l//Aj4hkuy5aTqzsvuK5NIkaGuub0ZH6iIdaPEnGzAcPbW+xmCsHIw1mSAgvm2MBgTqyLhidddDqS8NIOzYBkIt+ceZWfPUZ4ECz0TTd8ajZAE2RCbbN8Yg8oiU9HKUkZUshirDaEJdGZ4JtHMP/P1ATnOBJotFcBpOWpBmhIOc0DGI+LAvXgXO2MWKuS3ptv2cymugJLZ4oD2Wfd6mCibF21hsX5Pm6Q0gt/e5fHrqSBV6e4G9YGkhjLu8BDTlK4//+SluLsj/O4liyrJGDsOaO8zTj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:28:43.3920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4752c4-fa6e-4128-e36d-08de73a8a195
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260543-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 92D35187BF6
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> bkg() failures are currently quite hard to debug and spot.
> Often we have code along the lines of:
>
>   with bkg("./cmd_rx_something -p PORT"):
>        wait_port_listen(PORT)
>        cmd("./cmd_tx_something", host=remote)
>
> When wait_port_listen() fails we don't get to see the exit status
> of bkg(). Even tho very often it's a failure in the bkg() command
> that's actually to blame. Try not to interfere with the bkg()
> command error checking.
>
> With:
>
>    with bkg("false", exit_wait=True):
>         time.sleep(0.01)  # let the 'false' cmd run
>         raise Exception("bla")
>
> Before:
>
>   .. stack trace ..
>   # Exception| Exception: bla
>
> After:
>
>   .. stack trace ..
>   # Exception| Exception: bla
>   # Exception|
>   # Exception| During handling of the above exception, another exception occurred:
>   .. stack trace ..
>   # Exception| lib.py.utils.CmdExitFailure: Command failed: false
>   # Exception| STDOUT: b''
>   # Exception| STDERR: b''
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

