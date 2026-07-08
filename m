Return-Path: <netdev+bounces-305671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MkT1H9gATmoZBgIAu9opvQ
	(envelope-from <netdev+bounces-305671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 09:48:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA88722D0E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 09:48:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RuX82840;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305671-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305671-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1273F300A119
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98EC3F4852;
	Wed,  8 Jul 2026 07:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE43B19D2;
	Wed,  8 Jul 2026 07:42:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496537; cv=fail; b=quyxeiTBMF/ykkH0KAIGNkygzOunYY6M1/u9APgYIxdDQv6hktz9xdHsDiekBxP5I3m/O+VAe18JYR2V/XyOKRIWTbkTIkkNt9SXvrlIFPVn6zXVuZYZ0roxadBtjWv1dbJpc9YnzVtFLbIHAEKIVWkUM9Dix9oNTLse23pk1aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496537; c=relaxed/simple;
	bh=rDY59pT4xJXXG13Is1TOVzoPwuCPzbSOjjtoS7qbvDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p2lalVbCYpLXP3jLMldZU+zJh72bh3NIchjL7cd+pUBbCvmwg1XBLtrpZx6sv5yjWDDiZdMkEFONxxJ+TlgmAn22/a+SUXBLk7GBP7uusncnmsI3s0Zngdumdl3Pt9eBEzSY8xjMCdf742cLdp3qQo/rIr895KmlfhWeJSlbW6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RuX82840; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzG567Ex5O0PGrtZi8JBunWsrJUidKVJCZQJgSYsfVzg3mSnp9Q7sVje53+2NlSD9HGn4U6bPPrT/2fk0Msg+9CYlUo3k3moI6hJzPTcu7Y09krBUJJyPcifoZBoI2kmtlVgaOa2MlBEyipF7T0bF74+5FTmBmbDHc1qWv3g74izyQSVp5wQYDRDXUUMQNai7jAB3OgK3mUQYsRxzPX/SQlQIViLc4Vnfw3j0Zsz2IQ8eAYiRIVu7FO+6n52CZ1j+ubqMwSe1Jpr3HyJj9xtUsor+QF9DeUTjd1eptVyKXkcN8Bzt8aKJIFFTVpqEKk3MOEKWxprqNJwv55yIqHZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9rl4bGCe4SvW80LEPaf4e0JcbUBYOaxpR0tp2ay/eE=;
 b=c4+7Sy3qUXY1TO/h/R9u/I9+avEAY62FbtwQc9HUiwIpOrt7b4UCjtEd24EmDBKzkC6bP/Y2VeBx9dxOwueZfHFXusAsNjbp7GyTAV5+yJeDKevNuvasFURTnjZH9Zlgyvnqz9FoEwE29hAXGbpymvnGQY7L1muTrm2Nqe2LHLxF207rUVkymX+fpVQTLkFzH4Tav/8obx8djRyvlKbtFk3wghXKCl20IWiI4eY1/15Gk9FUHIiMY7LKfslQexnzwfShmEA3WekPUAIZDdz/oLlH3py27NhAwcJEtY7R8+ok1JnrhNlMAOqPEhTb71HkCpr358qkHOYAbJy8Ya6wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9rl4bGCe4SvW80LEPaf4e0JcbUBYOaxpR0tp2ay/eE=;
 b=RuX82840tGXyZzSRft7ytDbRiTwHQj1U+u7ToX2i+QVzRAqhZqo/FL9d0RjxzLfgRf0aPcWCuz3HLElfuRHcK9TBDtgJeqGUY9jdSTjFacOmm3LLuJHNe0cjsTI3vdK8T+XP+mTy/wnvM+KMYxsIOl2XrfL9ThmjCtEBSyuAgmJO8T6HD+A0JlRB4QKQY5i0aFwjEqfvHpc03bD19zjZ+MqMv6cqfVRfyL2qSb+caLw/Miku2VJXgNhtl04YmOb30AwC/cYSLW7ITpuqGpE0ABgHt5uiLH6aJwf0JPJMq013Ouv/oy4UvCdtxUHpbaRVxbbnyEWnOOb+HPwV+fhKKA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:42:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 07:42:00 +0000
Date: Wed, 8 Jul 2026 10:41:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Andy Roulin <aroulin@nvidia.com>, David Yang <mmyangfl@gmail.com>,
	Kees Cook <kees@kernel.org>, Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net] vxlan: vnifilter: enforce exact length of
 GROUP/GROUP6 attributes
Message-ID: <20260708074149.GA1168140@shredder>
References: <20260704222254.914567-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704222254.914567-1-xmei5@asu.edu>
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6fdc56-3186-49cc-ed3a-08dedcc46547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	47nNhiz3Mz0uhn5x/G9ZqgajVLTIzlCi9HcU6G1Uf57BPoVqtkg5Di1L+8kxvtu85/aVaS+gng9B3JOQmXSUR7aLbIIFPZvBtO8yqzipkMjLv5cIP8crqF+8cDmxvD0Uwy5A1mFgES3dvZP7y2A/qoZP9qSYmmcw8sSRZG8CVG5Tfg31ITX1dg54AgyeCiV1pmlICDI1vQHP/8t7Q3zWZ3k//8rUrZhBkqX7kJPJMo4L3yJS9W/xEKHopK3QE5mhixkLpvQUd/0B8eC374CzMjU5ToAJsDIARPkZjDFYvJFQ3+Sf4ZTQ/uMyarcB6CX+kxa9kNVNHwDLC9dSQi7x3jJLfISNNnHVnjdoqi5RzlvyhGSF+VGLtcSiAUYKSZUHvQnGCJTEkiDBWphQFIRDT5/zkCKsJ6xTiRJAWBDLoiQklZ2/KdM2YxsWPFNch9Ogg65F1fX1UV82JTjYZFHU1S3tR3POkhl/cQZcjftg2EN8yDGSJhiUJ5SlJMEuk6cIB2J2YK5Wh7W6/7ZPQKD4j+wIGwbegmqKCqxYRGmjH4ha2Ez83Ofq0z4115esatQ+4lNNyMvYj77UIoBV3IEDCLVXeLnmzvsf8gNQfXKIgp6Ig/kjat1nqNTXb9DI3rHfbV5pBxAaZBHUV4Ca/TFvzA/AL/kN8yCMAi6lyptPjKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QvFrDdN6GWl4V/bkqCs0dQFdgcUosg5rtF9xMEFsx5QK3TwOwNA3PUnu/CF9?=
 =?us-ascii?Q?ou7hPWo4zj32aN42SDZjD4ECHYbwqDjtPlgLI1a+yU2AMcVoPjx49YDpMDnU?=
 =?us-ascii?Q?wHxjcNbsaxqwzPF/olklK4b966HQeKKqoncPimTfrDgdM2xy7ARfy/yOWFhf?=
 =?us-ascii?Q?9tPdC/Xb9oo8/m3E9j+F9jjxaXvkWjlg16CIKRS9HLW9OQO155nquuvzyJkY?=
 =?us-ascii?Q?j5991q7g86NeSG9WU4VaXe0//pxwyvYz6SW2zN5h9qTSIdLrWbGG+atZNIrP?=
 =?us-ascii?Q?iD5gckfr/lunDCwZbG7J9PlLW12crIS+8+NBSHMHmuB2tX0Q1o+jvBhEI6hN?=
 =?us-ascii?Q?vuNlDcBObpT8cJRJlSeWC9pC8Ih4T8tO90/AxmrWxEOxvhpZgnlHdTmpUv8/?=
 =?us-ascii?Q?xH4olXPyL+brIH1/eeksNh0vzcHtjGJPccIE+X/3Kp9ba7dQp+KJaCXnQRur?=
 =?us-ascii?Q?oh7dX70t+d2shFZrstZLFmmH0pPUTTlDCZc/FSKdVD//ZQFBIOK7JxdfwQzu?=
 =?us-ascii?Q?BbjHdQzS4ijmx9bJwdLHYkpch6X44aS9CY2TNW0XkbK7WYY9FiX1gAyAQYID?=
 =?us-ascii?Q?hJpt2g2/Exmt1WIs6Dih1uBOxuZwmNsYv4kbB3q2ThUWwhGKd+56KUGpNl3G?=
 =?us-ascii?Q?MuRCG83btNOVAkEtxkT+3Hk6gp5gKZYxdtwwULOiMc4cm62nE8O4OP2I/WqL?=
 =?us-ascii?Q?Vp1M9+eU+GsWulj2dKZqHY3Spwn9Xlyn6Mxx0gaar1aoAymLO8B9fpeZk+tg?=
 =?us-ascii?Q?9M2cRshiRhtr98trljvZrX8EeLEHYdfib0oznEPSxB0PBaHbLvGsT+l5CwiZ?=
 =?us-ascii?Q?UWuBYO3l2ukslJeUghlJ3b4D07pgm1LyTmpSrQ38Ei7FUU8+0i3MAc3y9Lxz?=
 =?us-ascii?Q?08Fq2D68j57giJ1JNZY91aIIB+dD7jiTYixcf1sJoq9jVUiZ7JwUV/WA3grn?=
 =?us-ascii?Q?DcrRyvzPMY3L9Z9iqv9ptU/+V516JIjv8d1pxjEJEIM+EWaE/16BbYMaXLHe?=
 =?us-ascii?Q?EqfYQtR0udlWyQ6qNsEnfLFU9XDhnh1rrKNDbwCtrTDpCrfSIsgAXG3g8KKB?=
 =?us-ascii?Q?qGaXE0yvf+CsKOjViKYiag/fFDIokpRQRBjicO/KGGGyFyAq1L2XB4aVmvdM?=
 =?us-ascii?Q?Aps+awPLIExeRdRNvM5So89KhpG3PfndZuDdiinfTSL71t612BHmwRXrBjBs?=
 =?us-ascii?Q?aE+9CnkgiVW+sTAQCjvCFVeUwvBQLYaBRN6TnIiLPwL7niefB7g0PvKId5lK?=
 =?us-ascii?Q?qCBgM8VYM1D2ojaNb3NK/GtL/UmMq+aOaNcuqvWchZSg1jTC9AmKkWzNTJL2?=
 =?us-ascii?Q?DE8MUTNuDxzXum6MvL132R/CKs2B5udmcoNulkTqkOH59vOS+jZPuJeBJLUL?=
 =?us-ascii?Q?LWlIhPP9xib2leek6PHi/Qo5AVSAIf3OO2DiphpDuGJgIMbwbJRFLTpY5gha?=
 =?us-ascii?Q?Gtb879rcd5aGMo7fTBea2AOL+Gd6GWDxpqMx+KxQBeWilaEUqWLrR8XBCL3s?=
 =?us-ascii?Q?cltp5Holwjk7aQUkaARU+BoULIqQvDhl7cADq+mgezjgTurVwePkyW2vCtZF?=
 =?us-ascii?Q?QNcC33YDeY2SUA6d6uEwvR0KBa8GUaSHXz9wLwn5IVY9JR3gUNYE9JRV87Dm?=
 =?us-ascii?Q?2TZYqyT/siahC9SpY2tXc34YdcH4YVI/P59K0iAqAXV+pKe5DzNLTDUmAbBK?=
 =?us-ascii?Q?z3R2uw1SpuRrr+FtgP9wpUEXTN60uCWlDw3EvlBAIpGR9K5N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6fdc56-3186-49cc-ed3a-08dedcc46547
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:42:00.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOfe1JOzs0G4w3zcgxVmL4A3F7o+/vm0slvDwy9mCfRD10a/GXHCDOFpDpeTXAarFMW5Za8Uooa7I3G5nrWFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305671-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:roopa@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:petrm@nvidia.com,m:aroulin@nvidia.com,m:mmyangfl@gmail.com,m:kees@kernel.org,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,asu.edu:email,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBA88722D0E

On Sat, Jul 04, 2026 at 03:22:54PM -0700, Xiang Mei wrote:
> The VXLAN VNI filter entry policy declares the GROUP/GROUP6 address
> attributes as NLA_BINARY with only a maximum length, so validate_nla()
> accepts a payload shorter than the address. The GROUP consumer reads it
> with nla_get_in_addr(), an unconditional 4-byte load, so a short
> attribute over-reads up to 3 bytes of uninitialised slab data, which are
> stored into remote_ip and echoed back via RTM_GETTUNNEL, disclosing
> kernel memory.
> 
> Switch both entries to NLA_POLICY_EXACT_LEN() so the validator rejects
> any GROUP/GROUP6 that is not exactly 4 / 16 bytes; a valid address is
> always sent at full width.
> 
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

