Return-Path: <netdev+bounces-298071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hmgvKaGMKmrYsAMAu9opvQ
	(envelope-from <netdev+bounces-298071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:23:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F7D670D1C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:23:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="kgRG7M/j";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298071-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298071-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFB083008473
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E283C8738;
	Thu, 11 Jun 2026 10:23:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3773C0608
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:23:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173403; cv=fail; b=ZAIfV2PZXtDNbkF6h471/UZfwDG3wgLB0Eb7mYkAzFDv32a51gd0tTOvDZAVkll45eyQpzDslNDrIPQfgH6EFrzwAsEL9KLgQ2Ylyi4DRBd5oHHVKe5OeCpldJBKYrRkXAoberHb9kO+v6X+7zo6fl3R0roZBf20GqITbMGLC4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173403; c=relaxed/simple;
	bh=7BqmhQYH144jSSrJAC4Sc9/DzpCWITOiI5WS18v7iXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyiCl6CgrGh7tOVFcY7tcyyeFhmfPk6nzk05q8uFOH4kztb5IytqNyn6sgHAifTQMxsFaM7nYoXX7ArLCeSjM6FT6IxYXI/+9V9UHmw/0KxqyDRctbwRxWSnnTyhjawDACBwLLPxWPihXESzWz44rrmKCMAGmisFMb3BNBV0XKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgRG7M/j; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDUKxFpgj8Um0NQ8egeEDSOXyDw7cuBxAUJFE8S8Dg+Qc09qxf4pUf25p+rhqamXsBdg5Ah2aVaAY69EOrtSNAz/+HZIOlWtQ/8HiR/hlTG7InScc8fFaf77ZF5eNySWXnVVUTduDG8LarZc1tsKZhunETgXKsuUlTpHVnjH4z6rYOmdxl0JvFUCpCU0wUOpxljF7mJCs1vvignS7PYavqx8foxz+AAZTSrR12brNXsG59B8cE8XtbjpO1t7OfFvCWI8hhz3Vv38F4vPRphTFSOCR+Lx+r86MUmie3rEJF2EkcOe+xqM7O+NzjwrXIGWLDGZeEQH4W8/Cw2O14+3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NONN1+pZxhecAOWOzIQ/cFp/k4nkNUzZ+M5U4AeOdc=;
 b=B6+GZj1eUr/3vpf1GJf0wGZVodR4YzY7WFyBsQs/CViAtry62qKgzbXZ1sy0t9QYQcMiV27IwMuhx+hyrtU4w9JE2KU8UAFiDAu2+Buw1zjlzs+rD318D42+GeKrJZiSyNVwstLaJx+l/3bFuIfD9mt0dts0QK/zfSwmR0+U1DLCtXSrjhYIGYrJcvxpqtfiORHUjrdnnJje/fKoRoqlrUnel8Zm/YTAKMNV8/NJTRksCKP4sI8nomdQV/B3E4nRZ6ANAzmdtnEDod8xW57CsbV2d1wZUJM/fwXnlwSpJpgXiOcbjqP/w7gBd4WJO3NzI3LNf8lwwp1ED74mkKcSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NONN1+pZxhecAOWOzIQ/cFp/k4nkNUzZ+M5U4AeOdc=;
 b=kgRG7M/jzPAUScebVyCq6bvPGKcU6I75D/7btkqfsjrJIqhGKMx0pDBv+Tg4B0rxVR9wRnXv+RIRnrCZUDKGku6vLYsFVC2NRbmXRsABZXCxt0ThWqxiTRmBjZDt0R9uCG1IJdi9uAnPDHFLKbiYUI2+ETK8bgxl712tOn1T+nVewA9zJVr4khH2iQHO3SU3WoEzLhCpoOYzsb6gUC7yICn+qPIJE2LMyquPzgaDky4FB9Z3vqpmC98mvSOTKfAY5j+F4BQcK5uz385w9EIYAu8yUb058q8GHoBhoSAsIL/D6SARTg1KA/iFWexQ1PH9Lp+skeFw3OTdmd/qVEguFg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 10:23:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 10:23:12 +0000
Date: Thu, 11 Jun 2026 13:23:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com
Subject: Re: [PATCH net v2] ipv6: account for fraggap on the paged allocation
 path
Message-ID: <20260611102303.GA880341@shredder>
References: <aigx83czv+UJZA0d@DESKTOP-19IMU7U.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigx83czv+UJZA0d@DESKTOP-19IMU7U.localdomain>
X-ClientProxiedBy: FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b4b7e3-583b-4908-da34-08dec7a37106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VtXz6pfNTmyQz1Fu0NvYeppwTG7tXvW2z/tS1eooFGuD0x+GWZaXEpshq0qAsDukPLCbFxaDeyvUwCFzoDLd/j5FwjbiIMuE1grI5O4hr4wKZpHhOnKwaLERSimtlwZvmXZjOJ9DcicsoV8+KD/CDHW8wunMmDtRfwTbyEWD2+NFcF/uI7mStjtVNGfCyuKKQ6KL0ouU8PrRhIuActX0azv8OPJ6h1C/IyNMdLM5oWDZk+VZ/oOTggU103hEhk2LV1f1wDMpGcJtv/cRDxEtum9FG2K/5DU/0SO0I+NKqdpB9DvoL9QnEW+6gWvA4sXMUx8jB0OlnC/9DGxqn4IbZE9ei2jNp4bQjpHqnx2gNOzRDeJ/8r5jE+9R54uM0QG9FMzzXmjtaPDF86hajmqkwxRkYshC0vMWA3zX8F6CMXKOzgEcN0iROAPlYjoOt3saUQGPE0Cyu4a9n6Slp4RtXILqB2YJ5enhe+bpuFHlO2IX+2/+0UCxQbQhi/Vl+LE9Xg62ggPVVVxRWeFI1D7ufNVT192JmSiE2Spvw39Uc0QoCdXG66vATvveGkNS2z3CfZxAWjVbBcoJAl5GxZIYukvwGRw4uM5VHc4P5wy098S1Y///7yxa56O+J2vMj1BD7hShIy6YG8IEMinCA8LlD9EvkA69TVrHshh60SOnvlmWlnT9/JZ4ThpWEuo9cZbw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ygDQBCEU7JsusEWHE0IOzaO+nmmtqXjIgmpSaMI1S2+p2E4ZIAAjtm2bL4nD?=
 =?us-ascii?Q?Zm0ClCADdoLeVV+WUZ7yQdgpOvLh8C0SfKEQ+4e1uOptY9rWhFC58SruT+QS?=
 =?us-ascii?Q?5jEvBp3YSC9fJHaPssIAzbPPzs2BzjOh7B3RdH7449bHaBhn/Ifo/uHiOwyk?=
 =?us-ascii?Q?NL8nJjUHbivvh56nXkKWr3BWVoWYM9IJOnxhJSDoEk3ze52tBDxXN1Unn5af?=
 =?us-ascii?Q?KLy+cPsoNIiCnNNxX0vAIfvoOw6l0Ndr3uLB092W+J9pzXvJEyGPsF/0SfUU?=
 =?us-ascii?Q?7wO/WmCtV7bG/ne+e3j4it9pT436QayuXchsXxvWWWD+31KgQeNDt07sumes?=
 =?us-ascii?Q?ytJ93a5XwQ+d5wLTjv/L2xutQN9Ist3muP2N54iye51aBaTNmLFQ23VkGAl/?=
 =?us-ascii?Q?pd/v0hSfJY26xQEmfbZV3qr6ykmOKEBozQQoGPaxxgK//TIoYroV9GnRH6fA?=
 =?us-ascii?Q?s6yP4wDkKvdoJZRuKVKOR2jWBk30qR7c/GEFLSUE3Rwz9fZtv3QA5wqtyMdc?=
 =?us-ascii?Q?HDhyC9HOQabq371KUiCsYlepAw8qA7QtnO4NxWqSc9Vz6BhL5jgKYWPPAqbN?=
 =?us-ascii?Q?hnZpU3FDIQUpfYHVOL0Bwrgm7KagYwMPiloV5TAx/DfxeJUGDdGYAQQy8BCV?=
 =?us-ascii?Q?5Fg/L+HaGmzQYUDcgqITx88ZVy9FyPJPCKi1JTDF123gJZ9/0zlVQPpf+45q?=
 =?us-ascii?Q?0xIrhWpIDid/krCxNUYRU5Utnzgbv5T3xRfFIjQH92eNsT1xRJmf5X30W1CD?=
 =?us-ascii?Q?yEWLAl53JM565GwKlHNlnclbVC15w5dPOnUoJYuVgNymw4/xA7LEZvTD62TY?=
 =?us-ascii?Q?wNo1M79MhPFXGfVoJZFIMelTh21CX0NiugiNlqhmnm6n85m61yuLigArVeXz?=
 =?us-ascii?Q?idS9Ur1XogKpA6qOf8AUseBgbMksxFBUoC4GHvCKgRu91DJPJlhnhKuZyBsG?=
 =?us-ascii?Q?rKcWKGQz3f4MYIJo7JuhgMgKFoR8gGW4vLufa5LDHu0vEKgwQN+khqVxJ95z?=
 =?us-ascii?Q?FVpmydS3DrFx8WfoF37qK5YZvwHgZWrdQsBrkkCxJ5iUM7wPvS5HsFNsORXw?=
 =?us-ascii?Q?CmF17IyKYdXE7MCsEDGwHYFubMNDMl2gdSC5GMMZpq+kSQGIME6Oca5HRm3q?=
 =?us-ascii?Q?un0/awyhAV58YfRe76C99r7NaV7jq3QqE+O4zb2Y7U70BSJUuqEmSrj1vTw9?=
 =?us-ascii?Q?QsAsA7oFG8Z+GK3u4xDQcX1TIBvR5vUiEr9GWdoF+yPv9oYJ395YXbWwVft0?=
 =?us-ascii?Q?uuPl1xogBIzfe+4j4IkZ1AaP2CO4mtk9BxbOX1a7wXeie9ha4dxVWd96hxZt?=
 =?us-ascii?Q?/vyrlblNyPu2UIW9GnypYx0O4AT/+rBz702CFP9adKA1ou3r4XPBGgoU081H?=
 =?us-ascii?Q?EO3WyrmOleAsI5J6LntT0IK8NRw6tnG6fSOHBShavi3p9bsPbuePp4fapUEM?=
 =?us-ascii?Q?CsmzUMkjTTfkZz86nG/igsgYk9IiA0NYqCqpzuCLXkunuvR08ujwlVbmXYI3?=
 =?us-ascii?Q?5cgcjh3zh9gTPhs0LyxdHmCD/IBTsDQpW2CC6KLXNTQ4AB/Hljuqj+n44Nqu?=
 =?us-ascii?Q?F13XN4cKlYpMgXf1frT/Fx8TQW0/WFbdzP4VppE1kuCuxH+li3wFVsw76vzd?=
 =?us-ascii?Q?4un1ZnUJljVNjXxWFQ9693nnQ4o4a9IzaMaW+PfpHv1LIAJ6niTHRz2sdEVb?=
 =?us-ascii?Q?zARUamk5ofKUe+HzGqE6R4zGOiQW3hTks+Nkr2io3iG++/un?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b4b7e3-583b-4908-da34-08dec7a37106
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:23:12.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjfHlL63fm7lnUFelRuy0UYvUqAZUKDpI+MXDtERSP4sjj0bJvLYsL4bvjZWtB1flcp+XhmkNxuqDlssnJMumg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298071-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qw3rtyp0@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url,nvidia.com:from_mime,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2F7D670D1C

+ Pavel, David, Willem

On Wed, Jun 10, 2026 at 12:32:03AM +0900, Wongi Lee wrote:
> In __ip6_append_data(), when the paged-allocation branch is taken
> (MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
> computed as
> 
> 	alloclen = fragheaderlen + transhdrlen;
> 	pagedlen = datalen - transhdrlen;
> 
> datalen already includes fraggap (datalen = length + fraggap), but
> the fraggap bytes carried over from the previous skb are copied into
> the new skb's linear area at offset transhdrlen by the subsequent
> skb_copy_and_csum_bits(). The linear area is therefore undersized by
> fraggap bytes while pagedlen is overstated by the same amount, and
> the copy writes past skb->end into the trailing skb_shared_info.
> 
> An unprivileged user can trigger this via a UDPv6 socket using
> MSG_MORE together with MSG_SPLICE_PAGES.
> 
> The non-paged branch a few lines above sets
> alloclen = fraglen = datalen + fragheaderlen, which already accounts
> for fraggap because datalen does. Bring the paged branch in line by
> adding fraggap to alloclen and subtracting it from pagedlen.
> 
> Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")

I'm OK with this tag if we want to be defensive, but isn't the data
corruption only trigger-able since commit ce650a166335 ("udp6: Fix
__ip6_append_data()'s handling of MSG_SPLICE_PAGES") ?

AFAICT, before ce650a166335, a negative 'copy' would always result in
EINVAL being returned. I would at least mention this in the commit
message.

Speaking of a negative 'copy', I think Sashiko is correct [1] and the
comment regarding pagedlen>0 is now stale.

Finally, what about IPv4? It has the same code in commit 8eb77cc73977
("ipv4: avoid partial copy for zc").

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aigx83czv%2BUJZA0d%40DESKTOP-19IMU7U.localdomain

> Assisted-by: Xint
> Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
> Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
> ---
> v2:
> - Fix mail format.
> - v1: https://lore.kernel.org/netdev/aibiIYMAwUErTw5U@DESKTOP-19IMU7U.localdomain
> ---
>  net/ipv6/ip6_output.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index c14adcdd4396..265502caa44b 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1668,8 +1668,8 @@ static int __ip6_append_data(struct sock *sk,
>  				  !(rt->dst.dev->features & NETIF_F_SG)))
>  				alloclen = fraglen;
>  			else {
> -				alloclen = fragheaderlen + transhdrlen;
> -				pagedlen = datalen - transhdrlen;
> +				alloclen = fragheaderlen + transhdrlen + fraggap;
> +				pagedlen = datalen - transhdrlen - fraggap;
>  			}
>  			alloclen += alloc_extra;
>  
> -- 
> 2.34.1

