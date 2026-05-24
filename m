Return-Path: <netdev+bounces-291189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d+bHHrYKE2rb6gYAu9opvQ
	(envelope-from <netdev+bounces-291189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:27:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D46E5C2AC0
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 787D830075F1
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221A3909AB;
	Sun, 24 May 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A+5UXn5N"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA56305678
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779632813; cv=fail; b=PXBdftr+V2p9QBVgb/amo8GtjeXS5INSOb/wmxFXPO/3SNX8WX+L6X3Mu8OkOta+pMh3aSr/JqQjng3Pbsop+wlLE9vZoo3X1uqQ6YsWPWDmJBF19teu3iJ5IvbFcxKzsVIFnMAM4EfkfQ7QBVWzqqV0VuoKSY1GGeVdxWCnIxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779632813; c=relaxed/simple;
	bh=L69ddPCJ5iCxHaDEvE1Vl+5lL6S7fXpbp3l0l6SxAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q9RMGG7mNfgUgP1GEMMn6VTiesTI6878PzGcLOZFjm8ZxivN3NS/+WWujC7WShbki5T9e+kSS+HZY05il28hxRvYiQeBSX72tLPTQR4PSEjyl984DKcfSWw8gSPeBHoyftodma2C8ln/meNLZbTpR1Tw+zkCJD6BB+5Yhe0nVpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A+5UXn5N; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erXtIav1X7XDN3sFZBxDWclmOCdYnKJMsl/BP+LC8bWKVjdwY3GoceE5Ta2bJYT8TsTkssYtqkvWwxBCL2v3S18MeLPvko480OO11T6iKtuE+w2/1HGIkNVXxZ5baTh6GoJOMAxXw1FhNuHsuoQRZDpEprkV/Oro/P3WOV0f2fDMpj/p8gGcltDvq2qt5YcPfs4UI22zckxdefdEjMlxZBParAFJF0Ssb6toAw4uY6LdBp6d/suEDQCoXvAU0UVUwxodVgwdv9MMS61iIfUqGrHjwXknErU1499RyzhH+FzWpFCnlGrTh/6aYN6vALvmzmll70hGxmpRiBURetDr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB/yamDXNC9TMxol6L8xiDupFRiDNBjFRG8PqBi4sfY=;
 b=nTz9aFLyrm40lAep2BnPjYgNS+dzMusohvQaLriPespgkK9OkV3YtGLRvQy7+6if39OEDTB90NGhMK95TTxFlugbF8EWIDvlKu5RQnlXQAIXoBB52WHsiY7UovEFQxUgf3W+ZIPwCebpXzyj3so5lRoV/N3aI+GtqkEuP9xsr8Ipwz1eMe58GXQSILYuRGcWqD/lOvajYi+YMxwisEpQYEO6tdBUIOBzB+KfuT6NWUCp4A2b9s497PYfGXSbUEVahsavRsJKsTq6FqyzRXlVMIy93tytt/mQBRUGM3k5VneNbBHyOFujsNDaF9KfGc9t9La+awdT6/d3cNlry9S/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB/yamDXNC9TMxol6L8xiDupFRiDNBjFRG8PqBi4sfY=;
 b=A+5UXn5NlWg01MdRyzZuhI0bWd7I5wN5TtkW8ZaF/66wpvachH38PzSsgJB2V4jHv0IWgSZabM/XM9ktWQXhKGEqCOC6atXEePZbCeZo29L2uX1SBcHto/A1qnpHKQFfcpY2/lVlZI3CGn/qUwpA59gQZezjsh7avnn3z34piR9LTTvVy08eKqlWsJv6CV4xU/KQl+AXM9uBczBLNFjZPGpL1ds2/AekT6tei8XyfIkJYUYqrWppz/G8giTxTyyHRwDLua5/UP/RVJKZBipWmO9zgb6tMWjpYHfRRAUw2cd4BQBE8Cu98IqnyjLH4sm5dOtH6QMLr8XK4L7pHDv7bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sun, 24 May
 2026 14:26:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 14:26:48 +0000
Date: Sun, 24 May 2026 17:26:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, dsahern@kernel.org,
	yoshfuji@linux-ipv6.org, nakam@linux-ipv6.org, davem@davemloft.net,
	yuantan098@gmail.com, bird@lzu.edu.cn, tr0jan@lzu.edu.cn,
	zcliangcn@gmail.com
Subject: Re: [PATCH net 1/1] ipv6: exthdrs: refresh nh after handling HAO
 option
Message-ID: <20260524142639.GA93154@shredder>
References: <cover.1779247873.git.zcliangcn@gmail.com>
 <7aba1debc2196189172499e5769802b026f8caf8.1779247873.git.zcliangcn@gmail.com>
 <ed9cf618-a5b6-4343-9f20-b51b3814acaa@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9cf618-a5b6-4343-9f20-b51b3814acaa@gmail.com>
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b79597-bfa9-4c9b-fb0c-08deb9a07da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|11063799006|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	svb8Ve9VIYDP5NOmVWZDZK4h4RSyHSzNUnwwSSYVgqxkQsjvaMxrsv9SEtnmq1pdjisdnySFo2BACnfpRJvXYNud7JOwaOFVzSxnKwyvAZlAaYPjHAfAhQe0d5MCqRmUDRfOO9Ub21OxlOfYz8kKXh3z+n8XeKEmstUfMR6T0NX0IL3AyT+P0fU4BQ700O6Eq5bhNV7Tcre3I1BJVf68cXRNYTq0tB4DO42gacdyTGnMV89i8IQeTYgXszQ18s4Vech+jHYl/A77plwl97h1+xnWk+abPlFKZiIW+ZFYpMoG8xD4ySI3xajqRiv+zJOd/tw0ej1i2h9HjnXoP0u+UnTe7B41lHC5N+/bE93EPeELasJnJTAklMpAdC3j8wYrBFkkE7P6Lgh3XqWnt6KS8rsuvGD5+u7HtiBcO33Uv2ObEijr/QZnSzlDlWm2XIPjw+AAlhCXv9KsoMft8MjdENqsyQShyp62MqsKYUpWtp39MuX5LlYJ59NkhfampvyB3y+w6Hc8RBr3Ot+MKiXMZ+QeLPndynBOWEMtCK2ysIJIZLPkWt98QpNC+Cho/af99iHzWVupYnSeFzDaEqmgOmPdCjzcwWCndYsOvshwIz6X3+7F+uO5UAZjwegWCkWTGjwdidRBtiEpJzQTWylXOsqdy8jHilKWT53rJK7RmK4poY6tcxx79p37KOHx48E/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(11063799006)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJwAYiyjt9IV1AU7yx+DWIAzWb1l5QYB58a5622RqwYg82kWziu607sBsijZ?=
 =?us-ascii?Q?K2XxLoRCCA7h1aiwsfMnA/1wBC0Rb9c8Oq9f5gdwrhtGGMsz+IcLq6byG4WG?=
 =?us-ascii?Q?luo7TwfiIr4Evvsj6w9QbTa+z+LOREKniXXOe5GktRobyoSE2vt2D0AKKkzs?=
 =?us-ascii?Q?KL8DdlIZYmlBStkqvamx2/d52S6WjyIkn9Yvk/2iIr7MugsBGbU1Na8r91Gx?=
 =?us-ascii?Q?eJ/lMxr9IZl1xOGtdkiNBCUr+yIr1OY+wuJrF3RAAcDMdgswDfIQq4YOoI41?=
 =?us-ascii?Q?d6sxRLSdyc3Buck8nHX5cabsuHXvhop5aYApWEZ0cZVPRDnaWf26upV+IZTx?=
 =?us-ascii?Q?mIc9ExYD86XteNRCBIbIQNdu/Qwbc9R3MsJ3OlOeI68suDEp1YE3T3aIqDeQ?=
 =?us-ascii?Q?vi9pIo+zF3XvTd0FRIEjQ+zccQ8EMMgoL1ZgUMH14Ok1JnBtSoZhXNfiaQG9?=
 =?us-ascii?Q?QTIO+Qk37lL5hcfHy+fueTU0VLa1xBwJVtAOE5pRFVqwOLBUSUtUuDNElJA4?=
 =?us-ascii?Q?SjZvnSrT24oS4jhjjFJDmM+eQVetM6f9xTPD6j9pnGx2rLU7CEVFGZ3u4obz?=
 =?us-ascii?Q?luckq5SuaNqMMLK21VWq3rQjBNVwTAffA9uWchSURnXH/LOuWj+CxpId8hif?=
 =?us-ascii?Q?jfs8N8l8T2FfyZ4DbdwEbDMoPB3lq7YlJo0iLLmIWiHLcnGMxe3Pt4PxQrH5?=
 =?us-ascii?Q?ChdLWlN20X9tRsutsriBN/SFyK14l/JzUqI9VvDe0BiuQAyHaomBpe5ns/QZ?=
 =?us-ascii?Q?8YaBXdZEI2x1NelxUjvE8+49WUKqpRGlzCE8Ce/JBjoGQ1+DZ8bi3cz9aTp3?=
 =?us-ascii?Q?7T4hYjZrwP8mBKEm8M3cjG8mOkan/7Ql8KQvnV7O/WTLe40gvhg9M67ynLXY?=
 =?us-ascii?Q?NACvC7CDkLEOAcqNs35gON9VyEE62WJLJw+1F6fWgvmHPzaq4GAB0vcVOahs?=
 =?us-ascii?Q?zSv6agCID9vYp8JPwEqALCdsMl7RYdZYURmK9e/RKCzczarXuBcdz6iFHkPr?=
 =?us-ascii?Q?ktOiUU3q3XCtminEBDDWuIl8uSSrE7nKEKZu8raFoPgBdXl24XZ5Q/vsJsNv?=
 =?us-ascii?Q?nycV9JlFqsDPnVsmHT0ytH/eZkyxWdr7SAbphxsqa4qFpv3gzO9TZRtKAcdl?=
 =?us-ascii?Q?2R3M6GDNckUfAYSFkZ2nTViWJMOUyQ2Oop9IX/ukHT9uezwlkSxsvPJXbZfl?=
 =?us-ascii?Q?mqe4Lu5JvDTonyd53iU6m9EcDcxw7dezfv7LiSL3fszO9f5umhc3uxTBpMAp?=
 =?us-ascii?Q?V9Z0XC8nO7KHHsURb+rBcPuwRLNyK2Qa7jNUBeIiGshMx97dVUuCy5V40XRD?=
 =?us-ascii?Q?ctpM7v/rrROWdh36r41+fUjoMMYKs8jxsz+hrZJ+DmLVgDk/ohdgOBpa8CAN?=
 =?us-ascii?Q?15R7WjslGWeo7B09f/uizv7xb1X+QfEHSQx9HPnuwatAsWELRo+50FqL6JLr?=
 =?us-ascii?Q?I3TAGDTG+7gQU4lwV/N2wLJL7qeH+k3h4bnmDTq5tTRu54xmz9ye2lTyLnXA?=
 =?us-ascii?Q?noz85frJQCR15aZquMih62Rdfzrz7DdD9q/PBRRi94WGFf0DmXtdj9oEHF2q?=
 =?us-ascii?Q?OKhU02+Mo+jeXJMjeqCxTR38cG30/rej6Abg4VQFgHJj/5Xu4BTcDfjVamUU?=
 =?us-ascii?Q?UQ7OnSF4hhnHEMPt9iNp8nUJqNlaadqIcs1RQP+IEIvB5e3x+uTwL8A/1SHZ?=
 =?us-ascii?Q?dbjpNw0S+ZmDcV9/6Bw+2N3UncnJNcd067XLA0uG2iHaBffI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b79597-bfa9-4c9b-fb0c-08deb9a07da8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 14:26:48.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4+88YQn5heic3zSPnv1dg/8EDx6hclipEOU7wM5fyejOgcelicU7/ePZU6wkJ5LBpW43gzHA2mU+m/uMFwGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291189-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,kernel.org,linux-ipv6.org,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0D46E5C2AC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 01:30:40PM +0200, Justin Iurman wrote:
> On 5/22/26 11:42, Ren Wei wrote:
> > From: Zhengchuan Liang <zcliangcn@gmail.com>
> > 
> > ip6_parse_tlv() caches skb_network_header(skb) in nh while walking
> > IPv6 TLVs.
> > 
> > ipv6_dest_hao() may call pskb_expand_head() for a cloned skb, which can
> > move the skb head and invalidate the cached network header pointer.
> > Refresh nh after ipv6_dest_hao() returns so any trailing padding or TLVs
> > are parsed from the current skb head.
> > 
> > This matches the existing pattern used in ip6_parse_tlv() after helpers
> > that can modify skb header storage.
> > 
> > Fixes: a831f5bbc89a ("[IPV6] MIP6: Add inbound interface of home address option.")
> > Cc: stable@kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> > Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> > Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > Assisted-by: Codex:gpt-5.4

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> > ---
> >   net/ipv6/exthdrs.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index 47c5502a34a2..751e07392aae 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -201,6 +201,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
> >   				case IPV6_TLV_HAO:
> >   					if (!ipv6_dest_hao(skb, off))
> >   						return false;
> > +
> > +					nh = skb_network_header(skb);
> >   					break;
> >   #endif
> >   				default:
> 
> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
> 
> Note that the same issue applies to IPV6_TLV_JUMBO (hopopts), I've sent a
> patch to fix it as well (see [1]). Which makes me wonder... at some point,
> we may refresh the nh pointer once by default, regardless of the option. The
> impact wouldn't be that huge, and it would avoid missing the above for
> similar (new) cases.

+1

Do you want to send such a patch to net-next once both patches are
present there?

