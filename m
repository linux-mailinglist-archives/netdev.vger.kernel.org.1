Return-Path: <netdev+bounces-288719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK7mJcmjCWrGiwQAu9opvQ
	(envelope-from <netdev+bounces-288719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:17:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA7560AE2
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C685C30087B2
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4434D926;
	Sun, 17 May 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckzkOUFk"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64526ED33;
	Sun, 17 May 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016642; cv=fail; b=A0NB/A1+7xBRdnHg9LmuXh+chddQGDeREbL+QdN4xae5TMKcpGQp2J+B4Frclihy/mQFMpQD3rFTTPw2h6v71HaMELZP87v6zzuZfoW5fYbpPpK7LMW6zt2CagwchgCV7XwvcMDSWupegtivEugFVunZd58ow47KOD/w/f3NOCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016642; c=relaxed/simple;
	bh=Hc0c3XuMHrTkpN4BMeMLSknqwq6h3HvHyplkkaFGtLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c8aX3BUL6Jm/LsMPEHINu+ROv4YrvIOEHo5gISIO2Yg75ColFcDWF0X4c0DnOA2I73XsPhx+8iUxX7hN5PBTc5K//+vvJ/lh/AbtfweUETEa6xYOYrEYK8t+8wka/a0mZjwhtJr5Vuc39hVD4Ucnc0QWfQbmnAXhymx9ttBC3EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckzkOUFk; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcwmFvF1Fu2e78sHvzv8D506UQEtWVPgR92NBEXLIRfP5dMOuTiFZfqJ2H0AeESC51Kr4GL08AKZcTxaJhZKOn+J7g2avlyAerPhgRxKniYbGK2IWGVbJn9Rxff/c8ZlsSB9r1ikKvUkMJNC52LWFGHf3FBiX7tGiLiNVTMJQIuJS1sesY1tNAfqFUeRMPrmmc+NyClWHTZvG3qVKg99km/qHlA7afcfu1kfegjg+LQIZg8GQQpu89TMy4QctKFLlVpMnjhLCtv+Npc5xRI4tnVDuPQpDTSFloinklOG2Ume9qFba9jWCbElMUCNY4qBg0lSQWJpSJuWOnORcyBMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEOl/jY11bAmdUxkW0DYE6r05dAm2ArzIRYjjfj52zY=;
 b=E3dfL5SuF6ZFNKyI90rI/U8L4Nw6AE1Zjxg0Kj5mSlJCJS/rwDIdY5v9GDGlJTYxkesQ25HTezKWAyYSSIvmtgOiZDBmFQCCMilAiYe6bEkHoOed5acFiLSb7B0QQtodnVzGuo0eA9qLNUSC012HAk5zCY0R23KP4fnlgDB7fOWhwKWTL0ejiFq3H1nMH8pKiFRb8d7YtvXRhYl62cDAUDeO/sTUzcAFSY/Ev0G1Ko9JgkdFno3WcC7qvT2ltLiyWovCpZawC8wZB6+/9C5YRBVDi5cjfTHjQcvh3o59QRmzOOLuONQQMJJEQvWXwxouTnQv34ZGcGY0giTjox08UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEOl/jY11bAmdUxkW0DYE6r05dAm2ArzIRYjjfj52zY=;
 b=ckzkOUFk4SNg+xYSLOt5pCSxgbw0qkHK3NH9n3RwmLvvgV+TnH0OMz/Ag+wuHkmCeacQlXcGtMHAKZlHcBGckUBPts2nYvud4eAkHuKXIM+PzShSrv1BM+p7lxdeMOUZuM/iKSBKcw0ijlEQrKtuxgn9VgVBYUI6rfRLx5fH+4Xa5+2XgZotPfXIcgomGtB5zTQVg0ryzz+saTO9A1RCBCOcWBm/G776iY4OFmf0GECWAo+VGTJ9b2kBUe4G2iKTBbjhegnZYmTN6iEqX4Lil+Sbj3xdXG+8GtGueDIexwSuuOe6Dea8B0FL5QWQhG327GQXkgHUM3PDbIxnUwHwMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 11:17:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 11:17:13 +0000
Date: Sun, 17 May 2026 14:17:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 1/2] ipmr: Replace use of system_unbound_wq
 with system_dfl_wq
Message-ID: <20260517111703.GA161551@shredder>
References: <20260515135143.259669-1-marco.crivellari@suse.com>
 <20260515135143.259669-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515135143.259669-2-marco.crivellari@suse.com>
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: a149d9ca-65a8-453c-5d0a-08deb405d887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9Y3hsve+dEC+JPQR8kY6oLnII9QukN81OkrY9dtUQ3AcWNNXUgqp5iboP7zjZXj54TgCFXEYAvWcs5dUZYgkQh42OxlPD8nyh3bsVNVJUpOcaIuvTZlWPHD3FWyuz9Pyf/AWWN0bvqZGEuxN/IEDBhQoBhZrzryLXnhLko26N4S4sNdQUelOktleLZnzlc893b2NFLtbegsuNZFFhoBk+S4aee8NqfCNYmCaUdGZKEvOX2JgWN56Bg91FJVk8NMHd2+St7y4AsW3xVwaQgANNnDog1OKQ2dEX1aUsoHXo0H/ujn6xJU9aAH9EGxKPSbfXnw4D/A86F3FSTJRpm6uOX5/Cl6Ob4ttgTjknNN9UMViPZdSf+7dnj6JVX+yFcRtCqV3JdwsLW3NUiaP6CqN407T7XF43/qgysy6BrsGaUWXc70vRFz0qlEFFIekWAOOdYiERwYwsIABKQY6u8vzfAz5hVviE2ah4Mv89Ef5p5DvOKbvWtvbUlsyh99DrjvXHxZgYyrB/jaOkwhoWyVd1BdItVlGhIi9aj2yqh97rzdKo0QiS9YWisZXadBME1HcwG/VTTlR66g5PSvvxXKmb2QrqOslUHmvxMbui15+4YyGbvXCRahM0zorIAE8hsTJOWXLB4UTUcTt32HVTSNFms6FmZnc6qfex8Soezb8bDsCRVGpdBEANRzbp4L7TnMCML2ZaU+pVDsF02XHA3zF5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6wQMau3opZL9LJJCENL1G8lneuqnX/P5Vd5uYxYxCY8bpUV12/lDh7K3b9o?=
 =?us-ascii?Q?JGAyQXxOiUr44pNhICM3RwerrAci+yeXxvCXgJ/zr3ApnUyhvhj9mrOrD9YO?=
 =?us-ascii?Q?E+cvbemTVUBhDjShMIYtOngMIi7XNMN+GMp/J5jhPmIlafHXbZwMB+ILqNv3?=
 =?us-ascii?Q?66ZRCK4Vei9VuOOoCxeQNlTihn488bJ+eTQPo2WD6RVdghPm+H5JfEQipXkG?=
 =?us-ascii?Q?6Jn+Z5sepHiqLfLUHGb4VpST9Md9Ue3Hl60zLLyaz/uYxY1S1w/z5ODTLfN4?=
 =?us-ascii?Q?OQZoQXJ6APZ3IFjX+eyf+oET+vtZWfm1X7/L4V9MNSt05lixdBYnuCI0xQ6o?=
 =?us-ascii?Q?FeyT1y6PYgaUtf6odJmrI2eu6USdPsa8AYVpgKgq4iik3/AfTqCh3Wrn6EPH?=
 =?us-ascii?Q?Y8IXNsC4ciq+Ee4GpaiDnTa9Rdo2vgY0AC5iY8yGEAZtrXIyTiC040xf2Y3z?=
 =?us-ascii?Q?u2X8SJdnrz46sVTz/DD3X4xB9X0aRvyj5irmERtZSIeq0l+rPjetB5n+9YkH?=
 =?us-ascii?Q?tvo2hXpqqv8CUJ4j1MQXZJe2jfAsVypbgPRDg4TEP1iiD2yuz5g5q86OwMnJ?=
 =?us-ascii?Q?6hOam5IfAgPaQwDmINAF4L1HmDHQ8UMUG6LzozUhvj82kaEOukp8ZAIHz9XO?=
 =?us-ascii?Q?BqnJWHm2y8umzUcCLpx6pK7HqPDZJwxz/QzvVuJPLB40MRjn9fHWmC8kUeU7?=
 =?us-ascii?Q?gwmtJw1n3MNeN8AKNLTc/aaAP5QmpzU3q1n5X60d6uqkwHUgvXu3jI47jpaO?=
 =?us-ascii?Q?xglO4BGXY01prT0NAACafHqevIKAehnRjZOJN2A8QBnGpIGYqwUzrYJrtXEw?=
 =?us-ascii?Q?zE0QtMYaT3EyCB7whOPi64lDg8heDd4EHSlhLER2gqjIWg543gAx8e/hf0DP?=
 =?us-ascii?Q?hjD3qieWnvsyqcu18xupXwbQxeTUy+O4iARQn+IXBGrt+Nr8ZO+2JjUnLeq6?=
 =?us-ascii?Q?VQRzq6rvUUwigZh5FMGJjS6d3i2r6DtStFo1OBaz0Ioz8pEgis9Z+HyUIRAA?=
 =?us-ascii?Q?zgVMnEaXwscsDJhwkwRh7oBkLcLMzzbTWwpVp/3o1RT0yymRE/nysdX1wEVs?=
 =?us-ascii?Q?4p8OzQ/zTGpOwZa8rTeMNNq2rltvbaW+FlVAVNQTt4Cwdw1o2eLev8Bf/INR?=
 =?us-ascii?Q?zEAolP2NJ4APueoddGp1z3wp6S+1skmOxkYmzsXBKSVrkhscX7e6RnECt/Cy?=
 =?us-ascii?Q?mjGfgPgndMLGyzyw+YfrvHef5SGzEMnQBaRSjFyXCb6YVzvpVaOBdZ/jFRqD?=
 =?us-ascii?Q?Yo9+MNQUu/ABciw9YuTIBfoIP6ilGOzOdhnLtJqnY+H4vvHh6nniAgDaIPc/?=
 =?us-ascii?Q?1SsbzmHSXJNLWFlR/gi8IaD/VHqi0FUHjpCMYe4/6vkMX8M+LN/QMtwrHgdr?=
 =?us-ascii?Q?WueGGuQfJxs5svSXJRbgRkzy8wIlEz/Y8H91t3yqrOMC7HUIGH1SaPrcPkZv?=
 =?us-ascii?Q?tSnpmH7f6hR6uEn/AWDZZMQD230pBn7tObdndQ/1izwYJ9WIL55FDpYYmzVB?=
 =?us-ascii?Q?MV/7OoH8dszu8jtTi/GB5B44iuJY7EFyJmfVLvutWpD0hL38vzr8rgfPEAnD?=
 =?us-ascii?Q?n3fO3SVNLCn5NJwEGTMwOKo+MYy70rDJY1FThR/wo4V/Q4nr0QWG1m/u0vVI?=
 =?us-ascii?Q?bxW6NZRARZd53sqLBNkYXVP+SDwp+SWanKu98C+SLakqppnlyFpXewosWg2B?=
 =?us-ascii?Q?cmStxkCFe+cP70Unb2UtFXnQ2uNDF6wbxdJo5zn8AAZlCGJq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a149d9ca-65a8-453c-5d0a-08deb405d887
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 11:17:13.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP8paYs4yUki4QHX0iKGG57dckIqPdGNA1oYbHr7HD9z6FFNI2ON7XDyC+zgFYeAQd1HTP/HBeDnmZOOyq6qVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
X-Rspamd-Queue-Id: 1ADA7560AE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288719-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:51:36PM +0200, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> Before that to happen, workqueue users must be converted to the better named
> new workqueues with no intended behaviour changes:
> 
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

