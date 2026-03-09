Return-Path: <netdev+bounces-265671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLYKN5MPr2kYNQIAu9opvQ
	(envelope-from <netdev+bounces-265671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:21:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC7C23E896
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91598302F68D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647AE2D8771;
	Mon,  9 Mar 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lNkflZ39"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AB2BE7C6;
	Mon,  9 Mar 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078567; cv=fail; b=SmTSe05Ka7NEHgmErdmMTB5UE1i725QwhTVtnRcJskecBush5O0RnxSy7efvAninBvWatCyqOwiHaUJmv8a5bRuFYH/GTE+puegPOzF3Q2qQ+ossfiiFqqRg91eBGuzFPMQLVRsU+Ybe9KPajSOekxtF7vUtPQIBjsI31byUl+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078567; c=relaxed/simple;
	bh=eH2al22MuZQ6U1NSDpFsIVm4JCw3Z3/QLaSSAeBjCA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RPTa1DLPe73ayRsbW7W+Ov13NiC1XWIGvv1meg3uKhYwDFY46JrGAsFh2UYeAoEiHU24ZEsbKZTKEZmRXx5Nh08WftE+o8awAdepevHDwo68kUtusFwzyuMi0vz8wMPrwRemBvOILb5HulFo8PF9cq2cI4TLCuiELr0FNHTpDeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lNkflZ39 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKx7MjV1krQEVyEI6nKgHcmXGdwGJ08klJoMBApFeJH1WiTAbth6Gp8Zumtpy0csJ3PPv02+xCb2hbes4V7YpXMNegLGixs3mtLNt+Q7hJsPA4H78J8f+aX9+THnuWu41tETHpv1pTfbdTtF+AVcq8jMWZYa0sO33nVn5O9/WhUFaa8G40UkS6/1FJl5VI0ld19fj3zVAQFJ1z6gbtXxWxZLsYwGI4WMkFfUm46YEw2XJyZc+zjVM6MMovqjVolrKQkd453PzmJzWLGjjQ/HWTEhSyEPVBg+UHRRWdm2ZUq6pPTSFBKf9oKxjhqMYwcEmZfifjmP5lvHYZhUWdUIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XISUieJCqq84QHSHHp00txrPomQt9oqSVjytNquM6A=;
 b=oJBqldyNaAmOHZJzuJM2AjOlP7ITln/i9lsh43IYWTUXU6KVdMrDpzVkKk6RUXDE9fKL57qx/8t40MVmxlJWN/Ds7z4wXr4TiG+0j3RJHk329IDKNsVykrdSf7dwbPZfrHlcyzlVgHzqLyf6oLKLfD7xGBgYrHflwQATI0LVhvJz4cwtK9FENfq6TBuhnJufO48JsSbqHjNmDhHfnVknOpVBGmbJH9vGgxIrM/B2awJ/YPS+2E79y4+/O/wsCRc8p9gfNhkRBjQzYS300HSoUgBZl/qXt5pBcQkLq5AgG/lQdpEgL2prRGwImnzP/0rflHS4TD9Hs/i9Ma3jH5sIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XISUieJCqq84QHSHHp00txrPomQt9oqSVjytNquM6A=;
 b=lNkflZ39cMdONkGXbVe4S1qSUwW2dkHzicnwssYYsvhdYkmBP9bh74Z5V2+zCQ9hMwobKyAJx933Nmp0X+LOXSJsgoyegQRcYu3zRGqCpkQ8f+tGUfIszYdXyeML3hhTT5UxdjXrkjMaCaDy+TgBCS73Zb8K4y03gKQZXBocRhruQkCCoUxTlIghCCXkcSfL/WB98gHF1sG8hFWqsDWZFaapFEaa905QzBxXl9f00EPVdmSCEXokWp3mfBKjrSutata5UJeBGQo8muwSyl3YI6iz+T4txQtDLzxiyL6oJ5mVySV3qhbRl60LxzjlNciwPDTAniLTTSElccGnZ/koFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Mon, 9 Mar 2026 17:49:18 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 17:49:18 +0000
Date: Mon, 9 Mar 2026 19:49:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next v4 10/14] net: bridge: mcast: track active
 state, bridge up/down
Message-ID: <20260309174909.GB2044263@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-11-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-11-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2bde4e-e065-40fe-9d63-08de7e042fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	T9ucUy6baPRsjZHixdCq6NdQ5vyfSqw1pacHQGdD2MaDqp72LeOSfavpfJvsXwN7l8LUOx6PdD2f5wd6hnPffG20qk58yZiJJq7SPRP/8wvryTezRKWb1FwIVKkWk8tIp/bGw3cLflql27gS0YZ4F5EWGV/hcR3qUQUhN+23r3PkgbudiAOztMg+PpF4hmSVJzDi3R2YiGFm8EIi2YvE8VKdGM9yUTjqlFVNPIVB6fSbP9Fc7deFj5am/4vLA9gQiOJOmgvqW+w6+zHcLLyU07mAi657Kc3T8aktifyraMzMQ5xas2OCeqzNmB3OUV5+k6eXrNIc9TdU1rAprASxN4dlg4NuJ9bibld74LpK+gJn6KuSVJf+3NjYFhHbnNZ3uMDWVzcORZpDAfB5gvIA862Ia4yOIKZ/V7utTivTbocAUEs86k4tx+hmuFbC4StNkiVW2nDQOJZ3WULxv1Wls1M200hFmVdiq6UqQenac04RZy4tA6wyQA9U0fWeCMtU/Je6k1l1V/yu56A7LOH/UNwvqIakg9FJ2U4WrN5U8+lJXHzi2wNnCv/5bLi3nvyMHI4PzuKol4CYLAwiW+J4bcn5EevjOY7NnUTGN7ZMjfT51Rx8aWacnbpEZFIxOzEXpPErh3iaWIB1BsjQTKdNkIhtrrebUqmzTRcJswQWs6VaHEQeh9dOwPTzn0YzabWEQIpTtqMo6pg8jiUWWoj8aKk8/1b5VREQWV8K/MytsJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?0rd2piHZbZ788/3BSvIDCWks/PRsEjun4fiOx0Yj6XEDZRvW5JBUseaxnn?=
 =?iso-8859-1?Q?rStSdBoAvBwRSmCCSCKrX3/P+3zm95HMEJJtFJhoO+w3Cftp0lQf6CjwHf?=
 =?iso-8859-1?Q?7+72vW4BHos76w0kIuqigrcLC3TSmzgNU5TQbmAp7kJhN9+Mjd0+NcTndf?=
 =?iso-8859-1?Q?94FNWkhCdxlqU2cXdDzD5GREWZB7JgNzgdB0jsprAsTfJuGe1bHs/Gogsm?=
 =?iso-8859-1?Q?3hF4qg0vTzZkJQmBFQZXjbeJWA0KBJVrCHFTsyF/F5ni/4uWo5FcU6Am2t?=
 =?iso-8859-1?Q?2Ns4fvhQ2FU+UKxEogf0AZh9jKkgvi+S5Rykl8dWeuQ+s5Y5+rAsfc5jmf?=
 =?iso-8859-1?Q?D7Y9P/mSBVrvh4YJFTK2DCVkgYKEoJhJCQBp38tQ4xxDq8QxI/eQi+sOyF?=
 =?iso-8859-1?Q?w0pbJECDWABzHhE9zPYqxdKrMkv9HN6uAOCyi104gB7ujzB99e9E3oz733?=
 =?iso-8859-1?Q?Zr5amD89k+rDWtKkyZVENh566Rj9mJAKmasz3huS4+DHd2YSnn+vF9hGvV?=
 =?iso-8859-1?Q?hr79vkhRk0kWrcnmhmiRF4IyUHMGi+V+h60RAMVGntw0JQJkcbCmoYhuvg?=
 =?iso-8859-1?Q?1gKWpoXz7DI7SrHPKWEZsXLABWNjm09EhjjA958bpVCJacHKX9lyom2Z+5?=
 =?iso-8859-1?Q?kxsDrrKi6eA1KnbyqyF0Rp+n+4XJ220pHIK64tJ0Y3M7Hzw1S7zpjtNXVL?=
 =?iso-8859-1?Q?jMNKTkvvyiIuJmr5nki5aEY4/UY+RaxJUm3hV1Kd4XjsHjcT2Gwg7ag/FR?=
 =?iso-8859-1?Q?Tr95GtObKIhZxTojgMTDqFbdy9p8G09wE8ocoHZ3+cj/W2AyjQZknG/9r2?=
 =?iso-8859-1?Q?hMAyHl5sb1cd7KLEG1p7lpCuFzsdI0CCScuBpLnSKQVdPJ+eZv8tE5mt4u?=
 =?iso-8859-1?Q?KO0Qwhr7sq7aonC/u35/D25M8VSsBSNwNTxFytTCb7o0RhGEqCW1veuoIS?=
 =?iso-8859-1?Q?pZsgVz33jPnUvVrNX6ywTAWGmPJHHmDG1RR6GJ3cCZaG2TJkD2PBELT1wJ?=
 =?iso-8859-1?Q?LF9ePJu3keExnA9W8fhQBCzYgQKyLdmDPPFVBqUggqljONaA1i3SVUk+3N?=
 =?iso-8859-1?Q?G8lGmgLswIuDfu34vr+m/zSm5vhv2R8/4ofzL4znJho0F5uHFhxQpJKTmM?=
 =?iso-8859-1?Q?ZAhOqgAMfK/usGYhwCo6h7JBP48goJDR4HmOUoMjx15Hb0hQjDLspkzLNL?=
 =?iso-8859-1?Q?pIy8peWCLkwkcyEjGhVyhFc5RD1u7z1UAJdzt4W3RZDKoZSeOgOqJkgjPH?=
 =?iso-8859-1?Q?bJk9ksA2KSpFlCfH7/BYphSr8CQjdisHLkwlPoSFkKE7+bR4/HOSRE01OC?=
 =?iso-8859-1?Q?wxkUTNBZewOuQm2FNJVXuOmQOT8AhxWxY/yvlviouAAKf+jb9iX28DV7BA?=
 =?iso-8859-1?Q?25z1vcpMAunMM7C4bAMxvIrOoY2/2pPTk1FbZ4/NNtHwW+HVPUfJ+rljP3?=
 =?iso-8859-1?Q?l8+C0i752oveTmC2B8ynuwLWh4+ZtOtHsdOwGITwgJnDgJK4zGqUC/g/vu?=
 =?iso-8859-1?Q?qzB57wPosGG+ttHeFxxwwcYerP1ht9hcalulkPY44+SRVqRKzQfiumBKD1?=
 =?iso-8859-1?Q?oXIjFqKyQDTkBqOO218SUT/pobSLmDbrEBf0lLGJZMwbckAs/DxrEuQn5S?=
 =?iso-8859-1?Q?9cMm4o0XOLED+2Xb4B44SW7Yt46cN4NRsc8NAGHdHEwCB8ly/Sn2qBXnRB?=
 =?iso-8859-1?Q?GnCy9wnH6VgnRiKk9tfZu5h5W+Cb6x0p6cskVuhYHuodBZdSy7I8ZGa4Qy?=
 =?iso-8859-1?Q?VSdm9Dus9XKi5AGO3MBgKEwhf2I4JoYSCv0dPI6SM3fKUBk6lATowqn21A?=
 =?iso-8859-1?Q?1MLN+4JzSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2bde4e-e065-40fe-9d63-08de7e042fdb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:49:18.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZmErKLuKKuv8mR2nToS09eatXqI1uc02bIXZSciApWZR+xbuF7W3l1clUurPzUn5kWnkfKf1aKQj5VvL8jAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
X-Rspamd-Queue-Id: 7EC7C23E896
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.953];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:44AM +0100, Linus Lüssing wrote:
> @@ -4431,6 +4437,9 @@ static void __br_multicast_open(struct net_bridge_mcast *brmctx)
>  #if IS_ENABLED(CONFIG_IPV6)
>  	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
>  #endif
> +
> +	/* bridge interface is up, maybe set multicast state to active */
> +	br_multicast_update_active(brmctx);
>  }
>  
>  static void br_multicast_open_locked(struct net_bridge *br)
> @@ -4478,6 +4487,9 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
>  	timer_shutdown(&brmctx->ip6_other_query.delay_timer);
>  	timer_shutdown(&brmctx->ip6_own_query.timer);
>  #endif
> +
> +	/* bridge interface is down, set multicast state to inactive */

Noticed this while reviewing patch #14: The comments about the interface
being up / down are inaccurate when __br_multicast_{open,stop}() are
called for a per-VLAN multicast context

