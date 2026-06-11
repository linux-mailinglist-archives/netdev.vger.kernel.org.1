Return-Path: <netdev+bounces-298109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SDYbGNynKmrnuQMAu9opvQ
	(envelope-from <netdev+bounces-298109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:19:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5520D671C20
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:19:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gIItUZdK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298109-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298109-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA8CD3007B34
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF33BCD34;
	Thu, 11 Jun 2026 12:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE33B583C;
	Thu, 11 Jun 2026 12:19:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180370; cv=fail; b=fglbSduF6vA2ToFabFrKMkgTsGQny/0IJwaI/3YITvGe2lF/L2+X2gWXEsQQ/BLw/AUUO/ywvYPd/gy1piLlorRdKrQV6PIl17xP/WcSdeqXjkbTBAbJwqSan/epR61l/L6rfdSWjQvp/PiEVj2ksTdWYbyVGGxFjBuPhIATcvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180370; c=relaxed/simple;
	bh=xoxBVGpvxwpg4iCKaoUqj5fWOguyLFGXc6sqMoTkPGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f5e4YXF7Iy49zoMDmvSZa04AbM7f8EE0PK81lSbPnBk9/HduzHXTtuQ0E5W/GJg9u2klqXYJQstu4kcL5m8dmsYd57Sug/f8xrkw7bPp9ARzJOtw0bHxX4gFDRHNXgB+eIJUrjros888a6G7Cp3AgPCpgy/rAWpMgIpRY/cOlrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gIItUZdK; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCdZuuIQ0QWvziaPMg0BltOan3EVB6Q/KdDPabRqOCN8RG7tzevfPGLeXXn9CY1FqGD4gpy/XBYdIbFQA4XO8A8UtuYcUP8O30CMJrPg75arnG/ur7dIYpd4H0daJ5jiPnMLKf2kGt88P5rFCj9YromMqWajHG9ilRNKbJfttFzoZMkywQFQODtZwrMm8rVCzHIk66OpX3lDWaJNMOdZo+B7Fhpgc00NSJsosB2FjIDyjR4PLThXqzxSaX/6CIKZLuv9N52Udrra26Fm7Ww9nsb/fq3+GLkmgRSJOnaDrIcG3EJhP+FofvW4DQh9SewOGyiG57OF7+GyouE0ezCpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCMgQOyM+0eifpu1sMXVk7Snkk2Szzx5I+BG9SIdTeE=;
 b=VVNc2Mrnd+QCBcXmnQd9NEtedOk0HK6pTsj5NUWOxjJjAKTPhIz93ql06DLOJY90a+ToqpVGDHycln+KT2luLnNSFpWpW+tD0O/67ot9kbhQ+TNeg7uPWdGLVpgLH1KjsmHEeoBKsJJlo/GZ4Nvcjit+08K3ZonRLG2OXzUIcNkG2H7KOS9m577p+akNADZvS1h3TICaEUq3GvoMwrj3O3Z43mLXauOY8u0+kRTRp9vN5Gff2AbERQkEjzI1vMW0TTfBjj6keFihi1bMXTU+xoTX1688mKPGRaUsZ1I/QTrNcptHkD7A5s6CzDEJpaKz4alAcTGd7PQG0ZdohIg2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCMgQOyM+0eifpu1sMXVk7Snkk2Szzx5I+BG9SIdTeE=;
 b=gIItUZdK6CSSZ5bguFYqw8hJNMxg5zmQxbYa0nra+3zWuVGc2m11H9VWh94xG8Tx06xFnhC+htX7ggPat1vxlrvgFkdaaS6TVsFyGSupdHwa7KQYdRXg/g7gvIWnU9XfzXeSIm2+F20JoRu6QaUxbuouRXWy4E7zKf2e8B3XJUew1pO0A/lPUl73fi0Lc5a4ZnpdLyaQeiCgbnSX5xoFsKsnkb94s7FE1C/uOOQ149nQqAtrfrR9ipukpu8ityyLoO/RSEtH0eb1ET7pYT+Sa/VfmUYMc6bXGfuHtSV1YrG4P6TwzjYoNje+oar2OqQpjwKAWsefK61qpjB9mm6NTg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 12:19:25 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 12:19:25 +0000
Date: Thu, 11 Jun 2026 15:19:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Patrice Brissette <patrice.brissette@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>,
	Mrinmoy Ghosh <mrinmoy_g@hotmail.com>, razor@blackwall.org
Subject: Re: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb
Message-ID: <20260611121916.GA913575@shredder>
References: <CACWwMkvCAdjDPEraGhBdH67tkK=3p=aygZ2JYCRPkOzjVghFpw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACWwMkvCAdjDPEraGhBdH67tkK=3p=aygZ2JYCRPkOzjVghFpw@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cba971-0f40-4d75-5e44-08dec7b3ad59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NRO6Oa08+Ru1p2PB++soyQCwTnsqW8mJhf/EpNcTpUrVz35C4pIYZHOWicDlhCXbHWy3FT7re4vM/izSbkGoeQ8Q4b4zMHVRUaKSjRl/S80QeMa9rq1zwg9AHTo8PiT/gUjSJWhdemNyfbAjwTVIbFxsn1o2DG8Lr92P3Rr1aqFArsgnayrbTp8k8s9bCwG/amUasXsMGHfbwWlHhjpguR2zgy0rccsmQQnbRnWgheRWfLW7fBCp/X1zW4NT2+uRYM5ooap9qKB9PQv1QNjEkGgQVpldwPVxCXG8h+T2eA30tOns2I7I9N47N2nuFt4KQrhM/T/GCtFzFRB5u4I+E3vAW3KPBxc/vjdjIxk8G4o5h7FoGOLO3hI+RA2+bDTUJn6GHNVf/JoQXAZFZMJB3ydkBj/BwUye1PIOMo529KXvaAmrvmtqBdg/NI0r6/eSTeo3W2oTf9v71X3xGycLpEtXxnx8VqTQh+mNNsVpiXLUibvdMY/R+Q5x9K3/DqAzmdoR0rZS4W3HOzxYx/9NBqEJ/IcgfRjHPjM4K/vUmsevm4N1YwzY/1HVNHf0z3Xnq8cjP4i5vd7YMLDWi6KC0DGRK7+3U50Yo4ZAjE9cQNLdB2Xa8fojIu+wRXIxTeEKEY8G9dKBKGqV6R76JAJoAPEiXlcvZlxsJ2l4hnopaD47kf5dNJz45mnoQBeoHt2DfSpy+KYuxZO6FAdi7vgflw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?saJPVEgb72ht541S4Eq+V6yrpTg/c/y65TNmX9/IkU9M1Vpaa6F/n17NJqR1?=
 =?us-ascii?Q?RbuR9cWwEdWGLjGpyyKPV3s7T5rOtUglF/VxhveS9BdIapMRFgSc7bvLKrRT?=
 =?us-ascii?Q?N1x2uo1+kpCmc0Y7F1OoSYBWqiwcWZRfgtplatIbpuU3F3sogdIyKlnPtBaR?=
 =?us-ascii?Q?d3UZkkiR67pGMC63z3JQ52MQ82LoGtZIcCgZ+KTW/QvEjsvmSPX6LYAD3td6?=
 =?us-ascii?Q?YHxfY9MRje/j8qdzPmwTPomoz5YLe1D4hItAXZziHjfvx+ubQsqXoUFljczG?=
 =?us-ascii?Q?lph5wbITe+BHwb9MvzsHQ7dkgy5LBvgAtouHyb24EhQfZ6ZfEzJbaCfw2n8f?=
 =?us-ascii?Q?Yz4DnsvHbuozMt+3Lc99e5Yfo9hyNXd61BTPs6dG2kEYAqPSAD+v9O5sqEae?=
 =?us-ascii?Q?+hpcPaSUf6VzsNaVAOUzXySXdmzqxqYsDHUBDZt+h0IGTZLuLUhwe+L33QSy?=
 =?us-ascii?Q?7vu9UniaCJHoyoLvKQCqq6ikymEcecxsT3ugO+ggzPKX9TdHYhc04S4B3RMB?=
 =?us-ascii?Q?s+xHOKxEKHlGuigQrk9q+OL+0AWCgJ6hL1+4T35raOxPJxWbpUAYBcEh082k?=
 =?us-ascii?Q?Z0RlsZPv+toj5EOvqPamQXoae2+XOf8i18NROWSkb5/YWIFkcN6UNPlx5ysw?=
 =?us-ascii?Q?RrvZsAWkvQEp9EYYt3XacCtdTU49tDdWvD4difj0H1KmhMkuNtmckz4bORUG?=
 =?us-ascii?Q?FQvSNgp+4GEKAFFlo1QOoOf3g/8v0csGUHZACjLiEfxbMXi0K1PH2yNiaYGv?=
 =?us-ascii?Q?GHq5Z7r5eu+3sPIoituXUoVnSK/ZQq5pBgqs4hAULN/5X8GrjEWcZuJom7Hi?=
 =?us-ascii?Q?frpA5ou9aPd5MdZsKZ8/JQyDQLZ9OhMMpOAXZlgpTxmGZct0laXnEgVj31Lk?=
 =?us-ascii?Q?H1jvSuzOL7puPo70QHkR/tDtDhUtaERoytKPSS/ixEG9eyP3tkHleE7qfMvO?=
 =?us-ascii?Q?t0c1p3gPtx0SswdqAYwlpwHreS6/i1WO8C8eFSi5Lj931CMKNeSMFztWndIl?=
 =?us-ascii?Q?jusQ2IsG0E/PQZ1dONslDqHUFDFj8/0T/X/cEtcyhBV7Qxhsqz9hTIw9bnLM?=
 =?us-ascii?Q?gCnOigYfAEdnZ1HC+r7bYn3oyXoZWAb9AOFRRP16gt9vrTiUckN6cxkFSC8w?=
 =?us-ascii?Q?2zb6at5pGS2CC4E5viUxFzs3YNRz6QGdUsEJHCt8WwbZve8AHA2fnI2tYpIs?=
 =?us-ascii?Q?48Dx+5eSrbWNDCM9E3sNACyHr+lAZ3C10jDdfdvEnGNg6dAnx+ah1OYbf+nm?=
 =?us-ascii?Q?q/tODWmmcbStMV4f37dUcwqhQRpudzMpYnqO4xWi0zKAoFBkhz+OrkUBwv4h?=
 =?us-ascii?Q?UrSZsaQOBrqm5C/azxyjIHrWjU8lheBPBjuO3PgqZNy1UREv2cRQFuVCaBEU?=
 =?us-ascii?Q?v4IDwg/4HeIeHxwVelJcNIGSCBUOChke5MgKWt7tRpSz5gvdIj+P/9EUGQs5?=
 =?us-ascii?Q?mmZ/7Y0qTnEiiqedq/XVaq1eCmhRAopZLK/Uvn32E5QJEjqv/YquSjLOliwi?=
 =?us-ascii?Q?wTBoyhIOWyT+QCR5rHI5lSxWOIsiYthmhEkmvSTyQwL/MZEYxAY7RGJQVW87?=
 =?us-ascii?Q?TnWZhAvw9KcxczR5+FWx9WO3TOX+6Tjpvaq2F/tQRdWXlK/5jDjOVZ7WgwyC?=
 =?us-ascii?Q?K1NRGjyGMqYp6KQdiUf1Luytp1Y9jAXKGUJgPcT+8RtOo4ukLplTDa4FX9Wf?=
 =?us-ascii?Q?oLvlnmgv0x4OfusLb9ELz5nMNkc9YQj2QGWEoBnIXltLANGm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cba971-0f40-4d75-5e44-08dec7b3ad59
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:19:25.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ietDbdo0hXZhzmqIllOPssOwCX95KZAioMJNKm0uI9lPZQcTPUoMv5OUGGgfzuoi9naNbKAnm2OxauOruCLRzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298109-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:patrice.brissette@gmail.com,m:idosch@idosch.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bridge@lists.linux-foundation.org,m:mrinmoy_g@hotmail.com,m:razor@blackwall.org,m:patricebrissette@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[idosch.org,vger.kernel.org,lists.linux-foundation.org,hotmail.com,blackwall.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5520D671C20

On Tue, Jun 09, 2026 at 06:55:10PM -0400, Patrice Brissette wrote:
> I'm following up on the status of this patch series. This feature is
> critical for our EVPN Multihoming deployments, and the corresponding
> FRRouting work is currently blocked pending support for this
> functionality.
> 
> Has there been any progress on this effort, or has someone else picked
> it up?

No. Assumption was that the author will follow up on the feedback.

> What are the next steps?

Before I answer this, I have some questions / comments below.

> 
> For reference, the proposed work includes:
> 
> Adding support for a protocol field to bridge and VXLAN FDB entries.
> 
> Allowing the protocol field to identify the source of an FDB update,
> for example:
> 
> Zebra for control-plane-originated entries
> 
> HW for data-plane-learned entries (e.g., ASIC-learned MACs)

Note that entries installed by the kernel (as opposed to user space)
will always be programmed with RTPROT_KERNEL, regardless of the data
path in which they were learned (software / hardware).

> 
> Extending iproute2 to support configuration and display of this new field.
> 
> The primary use case is EVPN Multihoming with ARP/ND synchronization
> for hosts that are multihomed to a set of routers. In this
> environment, the same MAC address may be learned locally by hardware
> when the host is directly attached, or installed by the control plane
> when the entry is synchronized through BGP, as commonly occurs in
> all-active scenarios.
> 
> The protocol field allows FRRouting to distinguish
> control-plane-installed entries from hardware-learned entries,
> enabling correct MAC mobility handling, ES peer synchronization, and
> proper processing of MAC ownership changes.

Can't this be achieved by using "activity_notify"?

See:

https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e041178ba6bc2af0a1148145ee303c9db79fb4cb
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=5e88777a382480d0b1f7eafb6d0fb680ec7a40bb

When an FDB entry is learned on an ES, install it with "activity_notify
norefresh":

es1# bridge fdb replace 00:aa:bb:cc:dd:ee dev bond1 master static activity_notify norefresh
es1# # bridge -d fdb get 00:aa:bb:cc:dd:ee br br1
00:aa:bb:cc:dd:ee dev bond1 activity_notify master br1 static

It will transition to "inactive" after the aging time elapsed:

es1# bridge -d fdb get 00:aa:bb:cc:dd:ee br br1
00:aa:bb:cc:dd:ee dev bond1 activity_notify inactive master br1 static

And install it as "activity_notify inactive" when synchronizing it to
other ES peers:

es2# bridge fdb add 00:aa:bb:cc:dd:ee dev bond1 master static activity_notify inactive
es2# bridge -d fdb get 00:aa:bb:cc:dd:ee br br1
00:aa:bb:cc:dd:ee dev bond1 activity_notify inactive master br1 static

Then entry will become active if later it is refreshed / learned by the
data path:

es2# bridge -d fdb get 00:aa:bb:cc:dd:ee br br1
00:aa:bb:cc:dd:ee dev bond1 activity_notify master br1 static

