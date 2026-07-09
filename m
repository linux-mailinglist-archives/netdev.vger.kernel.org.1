Return-Path: <netdev+bounces-306324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WSpoCsfXT2pEpAIAu9opvQ
	(envelope-from <netdev+bounces-306324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:17:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24003733C86
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:17:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=jCD8WYc8;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306324-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306324-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F48930095EB
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2F426696;
	Thu,  9 Jul 2026 17:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9323EA8A;
	Thu,  9 Jul 2026 17:17:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617451; cv=fail; b=tVmmlZWsQW9Wa0glwTMQ7b7F9mbyrtgPRVDVvHKd/8VN1dZ/loU4CyT8Y6NNz9qtFHYDQgoHmVn+Kr0VTD7/b0cEMTs3eVu4XZS098duKPNmKJuud/DBbfE7Yq2q8j5qOlocdwCPF7UF3mc2+A+DDG+eP50fY68t7u6YIYCnGZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617451; c=relaxed/simple;
	bh=NMJtsY7l20FIFYnUAqK6T9DuWbvj3EnBEwpuhDtq1Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6Uik6QC8kFTTwleeBRRshfa8TPpUznBdF5r160t8v6RqQP7MDj5MNExx82C1gwjj7y65Z71WMqUYINC2mB1qyRG5h0n6HMS/gUh851Nu6W5z9kQ6Kr8isV462XIoSW91R8tpNwkGnKtDAyAr/5IqjeOZbh2u2/0A59bwXcSDAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jCD8WYc8; arc=fail smtp.client-ip=52.101.57.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okcfvCB5NO3sGqBMhI57DVQp5BbqZ6U2VbOmKZ6JhDVsOC595aNUICW7bXcGfNXtgtpp6YC0gGzUafa4IHR+k+I87nauYhjBA1Z8Uex+Y7Cr7p0wlEgipfTJhth8L8imERbbDs1J92/MgKxN8OVqTln3Qw2A/GcHphOaMZL3A5pWISuVEQjAzuNYwWjhtyb6xVK55dGNXEzkkfs9C9sMTrJKlS895uLnHRYkX8FfACIGlUFqVcivVDK/qmUCnGn7xuF02kAlAfb9emJDItL1R6PEfRMasfTVT7uJyECFqC2GTsMS14HicO1q0SZU8RUdB0WQya7zM7Lar3Xrn1LZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km3dCtM1Lp+2uBxR6LlFz32Ywrz0cxVCrPqrPzAl83w=;
 b=vZD/MPKnGYxFsvq6sZj9HVyrqENcdpx7XhyoS07xFgDSEANPydSmx56rgvpuL9P3DDVt07Dns4YR8/0ROBuyuP8zLP3EHLuzYFPs7mENFMVru1bK9fSdDZyH3LqSasMZtKD2Vy0f84ihitZfbtvvtqV77QRo8AO8u0riIIyOmK764yDPUD12To7TvTYcVfUdStG8HBcL3tO6MUWbLMtR5bZOsELErVQlE3LCXXW+VuykRq74c7VGawEPsRTSGAjfDMNS5UChpv8RffChnatlDw+/Mb8lrumZ5xkWaL8UVrpnYNI0GKHE0fZhwe1UqHkCoAa2ueDxVxpsA7lwKg1xIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km3dCtM1Lp+2uBxR6LlFz32Ywrz0cxVCrPqrPzAl83w=;
 b=jCD8WYc8QVt/Nkc0u3dgISMqSwx/wv+c7R8AUe6+Bpt2APQxuLaGIqQGtZ3CfiF4Fym1nu0VyPVQuXoocxf3wtE4+NXEXzYLwnQfgwsvlMYpLw3L89QR1xFab153J42MC+WTXUHjIksaaJcd+P0WzvilCwNe0OMi4chs7EBhhxp4vhgGWcLddymdHnU2WqA09ReJfFIBH4kPKnXVL7QE4crR4kNVJAeEUnAfwIl4NI60KLAs+F7zWejJDiQDOiCTrSdpVJXusWejuxjjRbcoQISzYFx/IJF3OLTLKfQ4ZdBeU1/Tnt8mb29nPG/LRIP/OKEl0AELefIVOZ1DJuqOMQ==
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 17:17:21 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:17:18 +0000
Date: Thu, 9 Jul 2026 20:17:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next] net: ipv4: clear dev->ip_ptr before destroying
 inetdev
Message-ID: <20260709171709.GA1749979@shredder>
References: <20260707043039.101983-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707043039.101983-1-yuyanghuang@google.com>
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be72d9e-46da-4f6a-52f4-08deddddee0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PDyJKyTNAEmo9d8rjObRXuOvqNQdCQyWewI10u+iM6/DyGNw6MMTyiOqeFeibo7ErOpbSwZz3dHeJry1rxEPIquQlTJcsh9sDhCW0kU6Ouu1eQYA5d2/wArxq/P/AmyJEyo0AVvTB2pZtPb+0IwEMXsBlrY3bwZly2CCyP5NaLQVM9YgNy01dtn3E9L9sUw9KBOJkIy/2fmsh+VBjC8IyAH87pFsR8UvP9A6NJ3OOh9xdCrNoZygOBF5XnDta3R7trlLCtFthj4dyQXx0cLqH9CBOfPPyFHf/3o+9IgXzDf+YNnI9guKH7RfnoWkHSqa2+F0ALBLhPbecaKdLkC6PtXh28X92K9CUxa4AY1+9f1B+8A4H55Ee1S/xHzlyD3doiBxCy3unukZjCxyfxH02VTcefzXR0nJDWeEGt1AMVYmoH4DZa+jE5AX2DZioh/blwUerde1hJO89CMgVwot8BlM4MaqiRI8kbOtbP/VsP5FOE5R1J1OMbKLm3gCLnlihHTDO6meV/+gJtcFtFADb+YIB6o6AqHa1kfP593oDffGSkD2a7/1vb4+QW6Z/y4eqmlPCb42bJRBNMXwKRdlBdfRyWqvnTIl/fcz5rdhqpilOHKXaSU6G8l/4WUyH88jHMaHJuEaarYQfdvWK6YZXVqRr2asVrBAtx6VuXQbUwA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TxnXZvfJtFO9Ie25zcwAkBIy+I7Njo1Px98Aj7BYDEAxJQg5k8QlJm40kdn1?=
 =?us-ascii?Q?9/WC6UuhtsULi2U8numkfxh2/yd2igoLxbTtjFOmLT1YtoxeqFFhfpllkfSU?=
 =?us-ascii?Q?g8zNK96bWqD0Kfa8d/vp0HDkrB6umCqnz9i0LvIDpkNkoOPQvik1Nh4Xwsly?=
 =?us-ascii?Q?yj04g47L0Bs9OC7HH+HBQJNyZUs5pypvYJpLHdMkfBGhxnExggI05p0/KyYp?=
 =?us-ascii?Q?R5N/TBMkJBXe1X1z9qguMk3WhgHG395ljdcPTfveavlooMvB9mZiRX4UupKL?=
 =?us-ascii?Q?dnmloi3ctAcLFsS6V6uhVJ9XCE6AH+5JOL9gL8wiGYHy6l3eEyix46tQIFtt?=
 =?us-ascii?Q?tjXlx/ke0lGzxvqrEECpiJcCLfX0FXfluHAJtx8Qo+UllWQJ0X8UQ6oW01pF?=
 =?us-ascii?Q?5rFT2nNAAeBeff9ZrDroyGa79f9E5Foj8c4a/6rBd1XQl8TjMxWkDk4pYXRS?=
 =?us-ascii?Q?mGe81stxiWSSwzx3fLi6qhCHDiAoldawps0y5ODypOp5DAilx8GZisVJPQ43?=
 =?us-ascii?Q?/wYKUfa73vWmtsWqWnanAA5GEm9GnJWY80kRKQKdbD9uKLPtpOwiOoaeWo+e?=
 =?us-ascii?Q?Pf1sxcYsTFFJLInwJk9h2FkVs0jAwOkiJDK6q7wO8edm4UmRv9egrzBH9/vb?=
 =?us-ascii?Q?2RLlrbRqUGIJXYymBBm0z2kTx7+CGeqbWR57zVfI6wC44LOdP6sb035Nj/9N?=
 =?us-ascii?Q?3B+/AGr1E/Hxi1o7KHtUafpPp3zAdJ79vqQimRsT26yhL0gPFoeVYuzrTT+r?=
 =?us-ascii?Q?5Q17PxS2jiIKoSYmhiMQSf9ByjEOZe+6UrcLqNYylQFDLk4ZD+TyZwyjt7++?=
 =?us-ascii?Q?vlpcrTSYV7uF4FEIkB58/TIpdyTor6njE+JDucX+usvHz68gpVzWU6YQ7eT+?=
 =?us-ascii?Q?1+YeQNAgg2M7SeZBBF5H6OYQwqCWw5vEAIbyfYW+x4uSl3n3RNUwUNo0P9DF?=
 =?us-ascii?Q?OqTp8tWpPslS43uf924uw3L+uRO97fv+LUe0QPUBPw8B4gEp6LLOQpZfkuk+?=
 =?us-ascii?Q?KhmfogW7tFeiPpXUMcsqdFpN5NHgiwfyiYKvmj3xXVNiI8sAreEorr9CaCxK?=
 =?us-ascii?Q?SUmh93p4Gbmnfy/Kx1IWqKzhpnjkcFq8eNrydXKOHQ2sDLhVmcRnvHDQmYW+?=
 =?us-ascii?Q?3APIpK/WCBLkFesbJ05/Bh8/FuS1Q0sZ8moAP4mfytSqFRG/MpjsOfycUbIp?=
 =?us-ascii?Q?WrMGE4Hf41Rp+7UVFgJyeL1nit9hbKCu/nkAGxpSPD81YABPCttAtRrUTL25?=
 =?us-ascii?Q?ra8HApjLCkoXJuh+o/YPeLldyBprlmfWxLgbD4FhnY8WT63by2dimjE+Y6AK?=
 =?us-ascii?Q?lHWcG9HnOIXYFJEjiVG+dQJXi45pbzjazjmdOeZ6HInbpk/0vR/w3Cd95zlK?=
 =?us-ascii?Q?76QQIUhHB2KiAf7VBTs5kyPGFPPwPTimgBmw506tTb1OPjMsydu/FUyEmdep?=
 =?us-ascii?Q?uNMfJC6C8Du8jyvPfMV0xXBRdthu0rWAqRXyOEVh1gbbZ+aSszWnccNSJPB/?=
 =?us-ascii?Q?V/uW1MZ64dP/dfKRmOy/h0UprbKmSetN/KFLK3VGK/JC1YEN60dfOYxBXqtn?=
 =?us-ascii?Q?+V0IbEIFj2uCVOpdnlHf0CJSTd+C+0p0xlvLDGUBhea2ZiwkhFz3zcMxHWdz?=
 =?us-ascii?Q?FMFjzpIanGKymCa3m0IOqkNOAJFRumheZDkzt0pYHxb4Heh+7Z5kubzpPy/8?=
 =?us-ascii?Q?I7wwgf41WHye8uWJE+OQG505hhWOx1g7aJp1tYeJOVa1ulQSguUJvYj1MiXn?=
 =?us-ascii?Q?pGR3u2A+AQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be72d9e-46da-4f6a-52f4-08deddddee0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:17:18.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2U4jj0rdIBBRNp7+3t0qisikUbxH5QtvTKTf6yoi8vQcsn5bbdjSX08IWXVli4KBIUEo5P8K1+RMzGzKNr1kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:kuniyu@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24003733C86

On Tue, Jul 07, 2026 at 01:30:39PM +0900, Yuyang Huang wrote:
> To prevent RCU readers from accessing a partially destroyed in_device,
> clear dev->ip_ptr early in inetdev_destroy() before freeing the
> multicast list and individual IP addresses. This aligns the IPv4 teardown
> sequence with the IPv6 implementation.
> 
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

I believe that sashiko-gemini [1] is right and you need to teach
prestera to ignore NETDEV_DOWN notifications in the inetaddr chain when
a RIF doesn't exist. Something like [2].

Regarding ieee80211_ifa_changed(), the net device is being tore down, so
failing to update the firmware ARP filter probably doesn't matter, but
you can do something like [3] to avoid it completely.

So, three patches where the last one aligns IPv4 with IPv6. Please check
if other listeners need to be adjusted (mlxsw is OK).

Thanks

[1] https://sashiko.dev/#/patchset/20260707043039.101983-1-yuyanghuang%40google.com

[2]
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/drivers/net/ethernet/marvell/prestera/prestera_router.c
index b036b173a308..0c4f462baa6e 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
@@ -1302,10 +1302,8 @@ static int __prestera_inetaddr_port_event(struct net_device *port_dev,
 		dev_hold(port_dev);
 		break;
 	case NETDEV_DOWN:
-		if (!re) {
-			NL_SET_ERR_MSG_MOD(extack, "Can't find RIF");
-			return -EEXIST;
-		}
+		if (!re)
+			return 0;
 		prestera_rif_entry_destroy(port->sw, re);
 		dev_put(port_dev);
 		break;

[3]
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 90d295cc364f..0e7a60dd1d8d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -588,9 +588,7 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return NOTIFY_DONE;
 
-	idev = __in_dev_get_rtnl(sdata->dev);
-	if (!idev)
-		return NOTIFY_DONE;
+	idev = ifa->ifa_dev;
 
 	ifmgd = &sdata->u.mgd;

