Return-Path: <netdev+bounces-285025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NT7Fyun+2lXewMAu9opvQ
	(envelope-from <netdev+bounces-285025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF90A4E03C9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF6F301370B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086693AE71C;
	Wed,  6 May 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftDki4vY"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27531714F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100006; cv=fail; b=fRPSzrp7PunDVKzKjvZevOJTAAt2SJB9jVwpCMoqE4nktDgB4oIWJ9CSgQKiUcApb9LavYocU6hL+d1DkzRpjixHu9r2GjXADAmrb/PiI2lOF7XU3CyjhSGqsYArejSUteaACEDlSZkqwkn+AaTJO2UTAGQgAYxHztMJrLwMx6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100006; c=relaxed/simple;
	bh=SHURpKi4cjk8GVChKo05u3qzfpsRRa0mxKAydPxmwVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NnppWFCmeuCQrE2ndVp6es3AXD4J5+Sfs9d1r9R8t+A1uLK4XgFsBzhWeh5UZhWUrnjzcYwHHhbofqBwIso5cu0jB63zZQ3IGp+y2swjMvn5v2B1Gmnr7WOXm8asHAnuh+9hXOWCrza440wHdkXvFz/gqDxMS5y5tuFUSEsx+bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftDki4vY; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChKb8ArRYkdnqqILSic2RbVfuD5Wk7QG25xVWDltyxhSsdUupn0Nt1FgrJemW72EHqi9ihi6V+x6r4Nznn05jD9RUwHU/IJ+SqOu3OR2g8OVnK6XHvnx4ojqhgKOY1hFtAouAw8IKfacnTPo+1a+vpl84GVs5sgkbWOEpL2N712+gR9UHOspjQZzLnNjM149mgFqtNElaZwgxi5zXlcoUJyaBEWiCfN+SN7f7TQsZBTlBywZWxcMBATL3MplntcJKqV/3kRbg7SNOZF2F1xGPZ8DlsTJw7ul0/Nxq4QG9GIOD3tzZLkg0kFFf7YaDhyvVP6M4FuvDJz2JZsqFciOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtnD2tdL5KQcoW2ADImy7pBlHyL72/cVWItuBZl1VwE=;
 b=XYjRa/DhEvxhXl+uHopi9hN2vA8+hhF6laZa1kz6GmWzFgIbvXTQmdjc7lVSw5yB943+aaa/qzP2nBrIozDjmxQiEg8vhL0sYWu7EsABpANrLVZbDTsKWSgYWtE6i3ItHwgKbdMesB4tvVEzuJnVsIH+JPrkq89ePszJQnu6XplzPU8NFx1e4kcfK2Iiz9r54P47BC5Aai+D/QPyRF7K3jAvc94nUZB7LuvuLgSeoWs3xy+kBemLmGZiyd6qbdOGxl99RnV9Pu+b5r4CY6E05hMh/rOmbLLCuqXhfVV0nNwG454eOtwzYwxNOv5HsXlJCi8oiHAydFWBmL9yQ7Y4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtnD2tdL5KQcoW2ADImy7pBlHyL72/cVWItuBZl1VwE=;
 b=ftDki4vYcamkIlMifKSTx4gIlVpnaKZo0iUuSLAPmXBumOtkxCNB3IENpyLIBO8r4GGf6qZtaefMSWhSapugd7Ik5iqjMkegilePUvwzkgQv8T12VlSaqGOAN4NzBXhzGeRgRsviAN+pLR0BVX+xOjbymU0HPmoIvIelwAKuXjQpIcDeDg/0FTFmF2ndMQ+PhDVFODZRb00duob3xDYjFIpW7EAG+pnhn/5DBrJbxhTf5uoKQTrbYEmzfclY9bnRRbmDbjWFVkebcmeaH1PUStfyeMmeow4SpDU8+l20buAzinHaD5dxjqSIXCAp5wGiszQqAdcNogP3b2vYHWso4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 20:40:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:40:01 +0000
Date: Wed, 6 May 2026 23:39:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 0/3] net: Fix protodown with macvlan
Message-ID: <20260506203949.GA805568@shredder>
References: <20260505081656.463158-1-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505081656.463158-1-idosch@nvidia.com>
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f4abdb-a489-4b58-e271-08deabafa539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JvUgzL64uaqITnjEJhQHqOuFArFYgh00hCHKDUN+sj/MkcjMzyFT49uF6HwWRwVfgo0GsDkZltJM7VLcqKBJZfJ3P2Uk0BFp/0AQckY1LQA+DRRye0M5M1WwTpJ2bg0NHoCCeBuRKsKigBjMB+r3rYOsD2SzyIzheCxE6eI+2pjJs0yUkN0G1v7R9gb0Auf/VneZemok9iqZoniq7IqXdmqRTgG+GAN/9ZP/EbrZknd9MeGfr9xD9NJ4XV5Q98bR7QkkXIB3wBPjuLLOrSEzvNpb6Z5SlX3/kSLy9xy+SHJ+5BXdI+/h6RXC8eoyrYYlkFWH0IJoFpSWP3o1EjDDu8l43ZTRBgz53nHad6YhFLXG0VpIaWsrCs8CxAuJk4aIzxx4isfbSBcRGTFTaTir+NsSfzNzUpjy/zvGyFvBk7FN97znbl4G1ifox8Jp7RmOFKnrHrCAK73SWdJt3//OH5T5Jqfr0cVDu73ecbmVuiDpZChtNVsTOQR5S0hahvTMyRLNyCdYtRRWoZVxjjya+Z4iljA/X/7XHgHAQytQjF0PYu1sIOBvQRNwAHI84UL79U1Vv7YHViEiB5dBO4m2JEX50PXXqWw68NhXjXBISiCL+jQzIzj1IA1FtPdhttSVhoG6mDAasl86ctFm/W4B++GNtljfpcP4A2XMGaT6ZejgJ2X+oM2Wpv5OI0CC28tR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UqllebiLgeg5OwLacWsRoPUCxbBE9dIcA+sLRpKr1O0gGwNoDb1kZPJrXfEO?=
 =?us-ascii?Q?EfJp/TvbvtAoqG7cUIEaLZqxwGbDni/wzwjpx713s6iTAlah3k2uaQ5D6O0G?=
 =?us-ascii?Q?puqI/GKxtqmZUJ68wDzsv116stj0f8b8ksLBAAvd0gwXGpfV+CherngvMOrg?=
 =?us-ascii?Q?jC52uQncM/tHOqvhbG7Fzhk5LG22RoQiGv7mglEivefZCJqsSTd7+gm1DacN?=
 =?us-ascii?Q?5o0/bKiOyDOUhWmbXE2nLaz8ZlPkhIc0v76//qL2OX4/7/AgU+fCEsrHqFMB?=
 =?us-ascii?Q?H7qto9a3Kq4PtTlyuD68pHPO8uuNlW4w6dKj3sVasej6MmPxem65ajIn68ZS?=
 =?us-ascii?Q?BTUbH8iaq+AWleofJPvXsIcLqLy01bXJuR9otU1TyftLTit/XnINWeWfEZWL?=
 =?us-ascii?Q?hGZOAhg7bIG2hpm2bFsL4C4rtrX7U/KFuIoPnIqdHVgQC0iEu7ymy3S+qDK7?=
 =?us-ascii?Q?H4PQZy1/TCD98nhJCHjxkd+EksMMcr2OFPoEBUfoHnlmSPLgylLW/b5B2qTD?=
 =?us-ascii?Q?K3UYGhgOn2kjSCp/IfbqyNIp9OHocQV3qVkl8NoyAN4kYhEgUigSkV5rBAMn?=
 =?us-ascii?Q?P0uHi6ZyRfmVx35yL85i4JU7Sz0HdTVxL6tGdYnaD1sy3xpQaGSY0mrKkYMG?=
 =?us-ascii?Q?BnYftCj5QVoNHXK1fAebW6SGS+aQhfW4SGszbWu2ULArQz/IvRbCaKEclnJB?=
 =?us-ascii?Q?cn2zQsPG+Psal/WMYiHUji1BrHpNB/1XuwQ6fbmNFcAzHVc11qCjVWxf4787?=
 =?us-ascii?Q?ZhWN9m6S0n6hK7PCf8G37ha6wmcmBAwf0MFtp0N7Gpa2Tn3AFRLYBmhaOpKm?=
 =?us-ascii?Q?KNfYWGFT5RO2TcVEO3TvWcFzX3DAKZ6tXuhNTDSYBTqAXNUwIHu3E7nyjI+G?=
 =?us-ascii?Q?QLvTKKIW5O6NZQfP75fb+msIMd7DETC5Iu6QoD8F/SMSw9HP3+yLO+trroXe?=
 =?us-ascii?Q?gBPfDVZdVCIYf+x95l9PedB60EsydMk0osBGIrBHG09aqxGtkyhmV/+wRYG+?=
 =?us-ascii?Q?WHan5JggljXsH80XI58ida9Jv0a1Jc5ORkN1Yw6ayBqYgxO/Ip1FN4IGC/3d?=
 =?us-ascii?Q?t6HL/T6YxSfjto0chxieN0tWVv2CwMRHCCltqCygDyNyiTOz18nUiFHDJxr/?=
 =?us-ascii?Q?oXONxd/OnV8wIrU9fOtrZp2nQLYn/zhAwfQPTK16d3y5rdmJhOSLI6q3Z326?=
 =?us-ascii?Q?Ay0cpPrsOv7/2k2OHWj/SXiK+nDtiSY1GMDKyp9RSBy/Xd3wBQRLG1CPIHmh?=
 =?us-ascii?Q?N6DGdrNqsifKYAozCTlfgclD9BYW3ZhUFQzZJGpZwK+DzlaHEOx+xRkolM1k?=
 =?us-ascii?Q?rZtFrzp2A6kkz55uoPHsGDOP6x1H6xuaYXPwHcXufXEdiaRWhGuisxvQ3ytg?=
 =?us-ascii?Q?CU2pWVrADGR57mAdX7dxuvaHyEMfn5tZC207MKjH4lYL/vJDlHibpcLuyNLD?=
 =?us-ascii?Q?vNULN5YX6XmD3e2sf0j6EnmcYTdszwTdYesycFgak8AsJ4xp4NL65AU4jSMI?=
 =?us-ascii?Q?5qW9+4lqGWJSaYapcJ1qeuBf+fKj1z3xkhQrBCmzSInkMii+4Vp9rwzhw0Be?=
 =?us-ascii?Q?tNDnyF88C2YV3+pati+g7NjS9cqmVj7zTV799LfWh51Rxaf30dKcierOQ8It?=
 =?us-ascii?Q?+ffMZcqialYjAe1stxOsp6qJOpE6yws0eGTZgY3h9VAgKZxYpu6LDPJG9M/y?=
 =?us-ascii?Q?iFKoIUB2161SLSrCM8Y6Ju71Amd2e9b3SeymEZEqOWMrch64xA+1NqLbCsmE?=
 =?us-ascii?Q?dpotbKWqDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f4abdb-a489-4b58-e271-08deabafa539
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:40:01.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QHprRtbliquDxaRa0SErPWA+tB8h/KeYzzbpFi6b9chMB1bTEhu9KzFCuxVdQ3q7rwAeZh2sEUpSae65bL28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
X-Rspamd-Queue-Id: CF90A4E03C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285025-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]

On Tue, May 05, 2026 at 11:16:52AM +0300, Ido Schimmel wrote:
> When protodown is enabled on a macvlan, two bugs cause the macvlan to
> incorrectly report an UP operational state:
> 
> 1. Toggling the lower device's carrier while protodown is enabled on the
> macvlan causes the macvlan to inherit the UP operational state,
> effectively bypassing the protodown mechanism.
> 
> 2. Toggling protodown on and then off on the macvlan while the lower
> device has no carrier causes the macvlan to report UP instead of
> LOWERLAYERDOWN, since netif_change_proto_down() unconditionally turns
> the carrier on.
> 
> Patch #1 solves the first problem by making
> netif_stacked_transfer_operstate() return early when protodown is on.
> 
> Patch #2 solves the second problem by calling
> netif_stacked_transfer_operstate() instead of netif_carrier_on() when
> protodown is disabled on a net device that has a linked net device.
> 
> Patch #3 adds a selftest covering both bugs and the basic protodown
> functionality.
> 
> Targeting at net-next since these are not regressions (i.e., never
> worked).
> 
> Note that while these changes are in the core, they should only affect
> macvlan as protodown is only supported by macvlan and vxlan and only the
> former has a linked net device.
> 
> v2:
> - Move protodown handling away from drivers to the core (Jakub).
> - Add a new test case for vxlan.
> v1: https://lore.kernel.org/netdev/20260429124624.835335-1-idosch@nvidia.com/

I thought about this again and since protodown is only about carrier, I
think it's best to avoid netif_stacked_transfer_operstate(). Instead,
make netif_carrier_on() a NOP when protodown is turned on and when
protodown is turned off, only turn on the carrier if the linked net
device (assuming it exists) also has a carrier.

IOW, I will make these changes for v3:

diff --git a/net/core/dev.c b/net/core/dev.c
index 46f8a2efd982..0c272f6e9aaa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10169,10 +10169,8 @@ int netif_change_proto_down(struct net_device *dev, bool proto_down)
 	WRITE_ONCE(dev->proto_down, proto_down);
 	if (proto_down)
 		netif_carrier_off(dev);
-	else if (dev == iflink_dev)
+	else if (dev == iflink_dev || netif_carrier_ok(iflink_dev))
 		netif_carrier_on(dev);
-	else
-		netif_stacked_transfer_operstate(iflink_dev, dev);
 	return 0;
 }
 
@@ -11134,9 +11132,6 @@ EXPORT_SYMBOL(netdev_change_features);
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev)
 {
-	if (dev->proto_down)
-		return;
-
 	if (rootdev->operstate == IF_OPER_DORMANT)
 		netif_dormant_on(dev);
 	else
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a93321db8fd7..05c250c483f0 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -609,6 +609,9 @@ static void netdev_watchdog_down(struct net_device *dev)
  */
 void netif_carrier_on(struct net_device *dev)
 {
+	if (READ_ONCE(dev->proto_down))
+		return;
+
 	if (test_and_clear_bit(__LINK_STATE_NOCARRIER, &dev->state)) {
 		if (dev->reg_state == NETREG_UNINITIALIZED)
 			return;

