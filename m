Return-Path: <netdev+bounces-265621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL8TCJXzrmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:21:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9265323CA0E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB62C317752F
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759AA3E0C69;
	Mon,  9 Mar 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gjsb/B8/"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7663E1200;
	Mon,  9 Mar 2026 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071904; cv=fail; b=RerT4tlfYXKd6g7aKmXl1GN9mM8XmnAT6gMnOnhxURg67KRKMCzt0f+QElAVdbsGVlPMFNw2BirQ7tIvoPnqOeLyoIxcD4pTXA672GKPUItopjHiMBPM9cjEdNizjMXuhYToyLWMDZSc1xY0mOy5avX76tHVJHVJTfFPETlonSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071904; c=relaxed/simple;
	bh=2JaR49qQm170H/vSlCCwOBpB017xxROKDVE6y3ElhRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YXyPDpath3hKUWkDM7EjpgsgPzAeN3LX9SQLdj0bzWArDoXy7kQbZjOs9UK40SqVCvlZm/TEFhkLBoT2j7wHDWK0Xn15xa3ndathi/zQjluDxvFa/PJaDSzskyZEIsrZljeOFSAfyPUvykzGSdbILAxCLsixrDtZe/E+dQdyk+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gjsb/B8/ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1Cz5TMi9IffMdme3G9dOky1S9DSxsBSNiOFeuXKttoavTV+oXxBlWwzxTyVNRrosOYWPzt2mLpH/PQD68KFp4Xf8q5Vx+vyCYFy32A8nxgKXDAv0pzpiYUIcY8Qgaz3S1sDElyZF1zJfdOTrpL8r3lCqA85FyErshv91MdZNCqiiURq3tY8QlH7ZloW1gE2SpgspCdGmOo3cKr+rwRte905ICKHLC0gfnnMK/BdjoKt68STKpTLAWF4tFshrlUQNHFPRAq9RrmbU+WTHHFMhxwmmj8S9T8s7AMKsUL/xFeKPpdcoVF7lMEohWwDnxVDIpwDwfTJ/6Seblh++o3SSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXrksaYTCGyM9hFWyuHPI2rolzKNfQK+RecSmSBRD4k=;
 b=leknPapvmfMWe5p15DcofYVDP43xLCDQjHp8jjIy40IxSZrjvbWyuLYq3oi5p4XRVAYbhEOD6tEaDCAbmUDPG8hJKRuxRmwvBsVbf4fAfV5EE/IVf1Q+vOzJx5AaqKqKkxiwIfqVZRIpSXls//aaD1VPUa2U+p2WE/gitsUa8TjYyv6cPMGWf0LZdx/m+0OeKwQq6dxUXoLpV8mg+wKQQFPeAIEqszc9OGM4CczC+MHBgRlFKE0qTAw7F4ZCy8SCrkYAVfHBpKmBuERONqf/nKoDgMXq0EZ0+NXRlNBlbyocs3pEBxxXZltIGrs/GW99n01BCvrHQ+5vzU/rUwIXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXrksaYTCGyM9hFWyuHPI2rolzKNfQK+RecSmSBRD4k=;
 b=Gjsb/B8/JtaE3uSUh59mQ0X89uU+Xkv4BZuwDWjNhWN9vwf5UxwU4L4aEJlKlnnIU6jVQs+XYrJu/qrR/HYv0QYqb/EuQ9pSgLqJrRc/Q7kT3Vaft18zBXgbHHXyFOVJ7h85rDTXCW1q84fE/R2lg6+hAF3egi1tKAbMmjzj40ZWfxv4rL3eH7T06Hruk3fuzoAlK3+2WsvQga/XYLaAuqHNvjk0OMqE5BrlD54qy69JgoxI/jBdHDSlc9Q57KGd/8BKD9VRjAFlmOJ5Sf91S2UAHM/3sYY21pQeiISfXL4e/XbrhCI1+h8EsRdG0AC6ws7mdXzinUyq2Tl12qgsNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Mon, 9 Mar
 2026 15:58:16 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 15:58:16 +0000
Date: Mon, 9 Mar 2026 17:58:05 +0200
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
Message-ID: <20260309155805.GA2001794@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-11-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-11-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da8dd1a-6262-4c48-89ee-08de7df4acc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	27TeGW+Mpp33SRWGXiDQObemIJ0FRBYcC+fF0HneEgwEL87eFuLr+xM2glKvahoVy5IuGFnz9rfcZgOkfpZrE1SFWKavQ1rjUC3CtanCUJgve3rLzEUxWnkY7H68be42wsj37kY5R2o+2g97FJKO1FZJsF2QBj9hRcwflSwiDSbp94noNhfmBkcaJe3Vo5KoBK4M03k4kTsPMN14xZqUoy9CiXzMARht5zaOQGskULyB1jZuJASW7jf2PG7PjKEuArf3+gTyt9WFxFqdYRSW2/UkdES+QJL4DpDHr6k8x1snccybesiiIRUtZ2dOW8Uy31Zn/UbK0jFpR5gA3URT6EfpZ7gUgOQspHeYop8+hbY4fKFuIUAxzczE9DMTa5d6fkx1iOjokBn8A+3WuV9y0+RaVDI6de3x+8x+/pXPSQ+u70nuS+4gbW0LP2H5bGNjeOIVwKMbWa6N+A4JxKmLUI09B+N8TkvoBX2hPoYfN+jC18ruYkPVdr2THHkJPjH/FWkv2UlDqQLNs1HzJGY4inYHpoaI2sg3Ao/AiZUyYUcsczSYzhnOPrwwoIsQQrWsiwKQf1JiT0/UhUFvm3xh50tltzWiGqcc3j7qzmlS3hqkSbkWMFxs/EJnriBYBqCFwchvZ2bk72FXuUmiEG76hjBhbXg9I4l7j5zr3Oztc6T6WRIBbow0McnTZOgiJqqCmbJ8QAUWM8Lcl4zJTgIjy+hblgLFp7BL2fe5/y9NGFg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6amaqJvuQN0hMJpUzdXdObOr7ohdkf/zsx+icQJGkqMRZPAKWFYZvQSRQP?=
 =?iso-8859-1?Q?osAV/RUG1JPWGm1NBfHoarn0H4AjC8/o83IVHxp5m5WNiHHsGIP0nWPq6T?=
 =?iso-8859-1?Q?82jiO04uO/AegGbEBIcPXdF27pvsJFFHPPHilg5vemDcePpgHmQGjH7XtX?=
 =?iso-8859-1?Q?G8fdGUL5aVM7YakctATgO2WhMqatoX/gcFTJx+EHUvrGYEFFgZwXnTvC2A?=
 =?iso-8859-1?Q?N83o49QAqSN7l7MDDV8Wz9WPzON3Ws4tlWFefr68/CTpV4q5336AjiZK2C?=
 =?iso-8859-1?Q?BU9mTpDdjlDWCRjzPmAYSaVAGYAkLpMi4G5zMMTwW7nKMDuq9+qIzeX7mJ?=
 =?iso-8859-1?Q?CMOlHe3qhhS93+VWUs+0x5zj6+Oiqeic0K6zgD4nSAlRLKsiB0D76lbtSt?=
 =?iso-8859-1?Q?BCZi98ctaXWPRQR94PYcjn7sAM62ITzX7b3GhnyUbsANzymc9wAD1q07mA?=
 =?iso-8859-1?Q?rY+Bl3mTweEvcB/O+4F1sMeEnv1SjQcTRMH3+qcTlhyhaOn1Nk1bCov+kj?=
 =?iso-8859-1?Q?FT+faYmqai1blbqvX02tGgKgPvwLBNhcLLhHSker/3jiKZjsHaBX+NTpWy?=
 =?iso-8859-1?Q?Fw1KLW3lsvqZF49E28C1S43jY6eGx+ahgzsQpnrWwbu7WcPJ3OFvEFySBA?=
 =?iso-8859-1?Q?Js62JXWcsMlsnmtCkXpRsQ7pRVsQTg/metpLA4iXzKYDyZ1y8negrC5rat?=
 =?iso-8859-1?Q?FWZmEIB80/WEDp6qHKgGSB4jeDmO1Z3FCLNYaloRGEBbODMQagsrrh50RH?=
 =?iso-8859-1?Q?hNrKKR8zAMTd3XcHI3Dk3A28+OPJeakhYgpnmGabe2ogjBry6JFmIRqnn5?=
 =?iso-8859-1?Q?uFv53knBqdq5ubBw3l6GRUcNdXg5vID5wWQtEs6U6yzUWAAKf2zcm13CkL?=
 =?iso-8859-1?Q?bAPy6X4YCqGRflFtRivSEPMHeMDjCjEEcyHcFa+DrpxWO12L0HVwI1msMR?=
 =?iso-8859-1?Q?Rrz18rnPQc7GAnPCBvBa79498HVKRSgSKbmO7gDTmr/Au/RbDvAl08Xx3h?=
 =?iso-8859-1?Q?SCYaZ7ATMzOuzFY5QJcC5PKesRzWo7oY0Bk3HU3e5gz5ahKjiFpKVC+bGN?=
 =?iso-8859-1?Q?Ewhk7L7xIoSB2BmsRMOCg179JtoK8GnBeHMiau9UZPg9is7nFVNp4HmOCS?=
 =?iso-8859-1?Q?FtkgaeyBt6oBW3E5BX5/CmCpL4NU/uwUgZLBv6PxqXf8TDqDBp2Rpk7wH3?=
 =?iso-8859-1?Q?eK0noDI02Ym3z8P52PurnbJdGqTBdf4+hlFCI2EhcI5JdHea1M+1DM7Kxf?=
 =?iso-8859-1?Q?vHM5cADoCt5U5fx70zQXG1Ze9dwWSMIwCFWyHJQGzXXJHU3ZBWes8GSk4s?=
 =?iso-8859-1?Q?jrec6RfIHSfWVaTxj9AT9Y/Uf5wDMeEWNh5zxknCTp5fy/c1o5lzhyRpmK?=
 =?iso-8859-1?Q?19R51HXu9NTTUuCKYyhR4ODH+Z0Z/zQKmLRYgc6bEMWdilkjtx5A7n+2yY?=
 =?iso-8859-1?Q?V2h+gpJTRoSO9glbmq+SRBhpsRYhwVA+SIkTLXB+bdhbQfXrR0FND6ScI7?=
 =?iso-8859-1?Q?jUIqilCVGx8nYV/ELnhil8a3ntfGWwQO0Mt0WTn9GbezY7kND8iuZTSp4l?=
 =?iso-8859-1?Q?oD0h8a7UR7pmlzfiWB/HPMW/qzoZD0xNbApix0xAtwx4eblIT1Nli2jEch?=
 =?iso-8859-1?Q?f5LoHGAyenPU/XR+unMu05XKMRAD/zlX0kOP4381Iaf9oXumJq9+OTU/4f?=
 =?iso-8859-1?Q?0fPZO0TzVSGmZ9ozVC9q6gACMzBNbxXiRIw7Ig5070pQPyMtc177dTZRYL?=
 =?iso-8859-1?Q?8cDOMEagmd7BdMTNsDcY5iPITB9F6pS2sOopBEzRZ13ofq13Jhfo4EAftE?=
 =?iso-8859-1?Q?dEG5O54IwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da8dd1a-6262-4c48-89ee-08de7df4acc1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:58:16.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9Tl8DOfmxilS1BucJ5baoKAPvRCe/TfZPD3YHY5jFcb5BKxn4MUHvFTGYXhDD7LFV50frSYRyW8LzMa7Uy6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-Rspamd-Queue-Id: 9265323CA0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265621-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.339];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:44AM +0100, Linus Lüssing wrote:
> @@ -4478,6 +4487,9 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
>  	timer_shutdown(&brmctx->ip6_other_query.delay_timer);
>  	timer_shutdown(&brmctx->ip6_own_query.timer);
>  #endif
> +
> +	/* bridge interface is down, set multicast state to inactive */
> +	br_multicast_update_active(brmctx);
>  }

This suffers from the same problem that I already mentioned.
__br_multicast_stop() is only called for VLANs that were added on the
bridge. For the rest it does not update the active state. You can
reproduce with [1].

[1]
#!/bin/bash

for ns in ns0 ns1; do
	ip netns del $ns &> /dev/null
	ip netns add $ns
	ip -n $ns link set dev lo up
done

ip -n ns0 link add name veth0 type veth peer name veth1 netns ns1

ip -n ns0 link add name br0 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1
ip -n ns1 link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1

ip -n ns0 link set dev veth0 up master br0
ip -n ns1 link set dev veth1 up master br1

bridge -n ns0 vlan add vid 10 dev veth0 master
bridge -n ns1 vlan add vid 10 dev veth1 master

sleep 5

bridge -n ns0 vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 100 mcast_querier 1
bridge -n ns1 vlan global set vid 10 dev br1 mcast_snooping 1 mcast_query_response_interval 100 mcast_querier 0

sleep 5

bridge -n ns1 -j -p vlan global show dev br1 vid 10 | jq '.[]["vlans"][]["mcast_active_v4"]'

ip -n ns1 link set dev br1 down
sleep 5
bridge -n ns1 -j -p vlan global show dev br1 vid 10 | jq '.[]["vlans"][]["mcast_active_v4"]'

