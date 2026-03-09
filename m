Return-Path: <netdev+bounces-265556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLsUFLXQrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:52:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2E23A130
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 102D430240A6
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2043BD622;
	Mon,  9 Mar 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nsQWXX//"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDC3BFE4F;
	Mon,  9 Mar 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063923; cv=fail; b=WLFv717l8uUJfCBImuhbBT9C9UTkhuSpoyGOpIsjQWDYavJiQruMoOtR4IobuCipmlvubPVAiLj2+YdzHj4Yg3Z4bHxz7ALm8hmtceNGkVerYuLAm+V6kHI9no5ihwZVYsjlZsWvl+abP5MXbn2CLTy97+lRsU/SREfEV4QlAJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063923; c=relaxed/simple;
	bh=p+oeo5oXwSN2vPNPkVATEANJvRZQ2X2owsWe0sz7eEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P0P2xFmDLewlpp3IXAjCe1y8kwBXd3eDN6Grklgma6wZqxKyxkIub7pXafrr6telGGdb7fz3uz8+0MNhVdfVO4TDOodMatClf7hwy2gWgoGrSqRl4W22JPFBX66YhC5D7gAwuySz+96np7ZFF6h3RxvSxjpXEZyCXr3hVA24Yhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nsQWXX// reason="signature verification failed"; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4+ee7q3CPNGT1HH1ttt15o284JO6yaZVJxMVc/LODpUXQUXy24OUf0eeUxpkLuCdEErqUbzQmjxLh0wowjopyPD6P4h+IwluzlSwtUsloF7j3fABGzu+nsXxZSvAW+1R1dBJ3iO0PAQg0+3DaUcfV0FkGeIMyUT0MuepbeI2c7O6EKH4cRHCX+NxfLobBrm58nyf01ZLemr7v5snXOTQEH6afCDw20S2+Gf7wwUYXkulwboY7DElpyoj/UmqRhS5DWrCU2vExQEzckASeSx1jAEAlZ2/70HeN0NvEZla7s2H9b/nkkmAtZDHjEeX9YRvxiXnkw3GA/tKUuDqG4QKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9daeR/8teE2EsATdeRgLiZ6ZE9lTs2Z5JrPFupRn0k=;
 b=jiT/Imca7JTQRTjM7TiG3zyQpkPdGdUdPCl1EZGzuuTBmlyxVZnHIozVfpHhjm9r9RfLNeyBzqFWtC/gGvvX+q3wFTDthR6R5Pnk3LFxeTbPUjonWw9O35EjklSk9rvF+KRSRVEVWK56g3ZSXMH6OFik4eAqDCXBm+vNiddHhAWa7V47HITVmGxqcB4FadsGkps7AEREkYck7ghyiP9DZqXOFS8x9ttVfPRkFCJlNHt//ojxbp9GJ4RQy2Re9N0fltCZAIyOS+LQschdc2pahmDdoTFlZb5FaDIgBcdesTgp7mEvSTQW6/vpNvTnSr5jvk3mexpJBbE/Nh8WA1VJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9daeR/8teE2EsATdeRgLiZ6ZE9lTs2Z5JrPFupRn0k=;
 b=nsQWXX//tb9JUUaWGrQO5uXRZskA0vNZPTSliQ4/34N5y0yPdFzcv1z5IIPRQZ3lg2/BT7j3Z+r1xf4c3RW+EgT4hR2rii/oB8yXXLl5oxAAh1MXtjep1LD9MSWYJiskDRPFfW6ioMNBVjxcU8wqLJ/uGRB/71XaKkDtb1A3ot29iB8NyI38FUgzDpfWZZat0so6SqbaEDaoE19e0jFVMX4GHnglGvL9CErWwp9Sz4wSFv3Kqh8cV0u/E0wF/DWTE12AT1nFJG3w+IrFATjMqgu3igVKjTePVUIn8kK+1CRBrk059BLFfVPbpOSuEC0Uetk3JrHGXwED6WP3200wEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 13:45:11 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 13:45:10 +0000
Date: Mon, 9 Mar 2026 15:44:58 +0200
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
Subject: Re: [PATCH net-next v4 08/14] net: bridge: mcast: track active
 state, if snooping is enabled
Message-ID: <20260309134458.GA1961298@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-9-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-9-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fb5f99-a93f-41a1-580f-08de7de2149d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	fGjR+2ozxJ27RtPQQ6hIJns4eTLceopAY+GBeimfUWDxmINZPQVG4rl+KrKir9z0B5JDfjGfdJm4YqVM381VUo5oAKt792OOYfdCrK78zLQrC3spxYSlFX6xZ/pfegtuAqm2TByIgsSMGQPaAyoTmGb2VnwofHDnRbgF9+zTGC0lwPrqHUxwQ13qcO3WVrX4skB9/i8GLJGw3iqpG/iSBRWdo2vjxdusLjXSD1P8PeXsQUhhU/6ih2TYsP0c4RkpxicM8JWaa0b64ouXpoMHUWq6cXxrTMC2vFA+tGcClfBqUHJtAIiYY4HETmQPCMfy/4kxN7VB3JFElvPUjgS8Zv10LVTgZ/DvI1H2ydg1nPl8b/B9GF+69fiNQ7Qh/Acj8h4ihe+EKF3tEj6fC2ydEJD849EW7IUJDzc0OfcGPjOsqpnJptfslIOPBOyLur0BDi8Hj+dbCh+aiV6RKVpAuDn9SGe/mgUmpQkeZeUL4mWoiAGxtYSlvGJRS/NYHljiVYqMks9H0ngmzNxjjYaTja435E7E71gtyozyiLPoGswmDm2RZ+sXx5SxuyoJe8ZRBFNHz5iEN14lbzXT1GVJQs4asy8kqI+rUyzqx0Gnc+QBt6xy09KnABYhNicVWKf94Lm1uQj4aug4Ig5JC52rKm2IYGhJFOswz7fJYVzIIQ9L8+oXXSKWqPcTu8VT9c5MoTOzGdKN07n23ljNX+qbpC1NNbqoOra9MToT1wRwnU0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?NSPgOiybjWosaWrjdFXsYjY2x0YBwOh5Mg8+O+gx3fmNiNNPSgmn70fIFG?=
 =?iso-8859-1?Q?bbc/AbJK37xqgcl6FkXjZbR19HbOhqheVkCSdiyzMtP3XpMVr67zViKZDM?=
 =?iso-8859-1?Q?0QcfKqsblvZOzCpk7rkS07f6cKG80+CFj+j0jR8Hu+BXlGPy9CSXUYMMzm?=
 =?iso-8859-1?Q?/2L23f4hbXhsWkq5chur4MEprMkpgIpQD2L7MfPJ4x7AUQO+YzsmnMY07d?=
 =?iso-8859-1?Q?ivyRAYENJzoEX/U0zHG2O0diBGngGwjqCQa/yVrPRZj7S233fqJ/jjwt/Z?=
 =?iso-8859-1?Q?kxFFTBEdWWxdizm1iC8jq28k47XbZsnH/oJOtNJvDA/YJ/ukXkfqMuA+hh?=
 =?iso-8859-1?Q?ysiciAwo3Yav2PJKSZ0ngyQLC/Q726rtcyg5t/bUnBnyaoLgmOz+cosXI/?=
 =?iso-8859-1?Q?kIPK2kpogNS5a3R1EVBqjh4Rg86qTA+muL2ulBJgK3Q1xol18E3+ylZ8Yj?=
 =?iso-8859-1?Q?ETWDrPcf5H7K1gyxv56wmN0CjRM5HNRZZMGm15fcXiY1nVy0RH2DeI/8l7?=
 =?iso-8859-1?Q?5rCLwBlHFwGH8yd+GX1MOIzGWGBzMwcTV50nXZX1NlXnvECmfZbl4W3V9m?=
 =?iso-8859-1?Q?8pakDb+0qXWy2FVaavPzRyK/CaXDI/JS6Fmn3NBo6PtVT9gq5BdS/Nx1Uv?=
 =?iso-8859-1?Q?zsKScR6iXRCS56LrTRs9DbpSymDnYviFzm43hsJBCFMidw7fLsSYL40bny?=
 =?iso-8859-1?Q?7O511uP0e9j4fDZHKtrH2/QhbkMJfx11jNJahJ4h5pPxLVKVF5KX52xH7M?=
 =?iso-8859-1?Q?CNTG7v6KKLGzMiPk+Ixr9+7g7F+6FOjpYBXG2LgC2QLNwBMoLAuagLq2Pk?=
 =?iso-8859-1?Q?+UxL4ku91oDRKSV7kjU8Z5XJLx0Y+mJ9THnAeGda/4+BlP+O621RkEpzix?=
 =?iso-8859-1?Q?cHMcWxqAo5/XDyrrbn+tkBATwTL0b4uLe9m3F0I0mEb7uMU59GSsPDLDF2?=
 =?iso-8859-1?Q?xwom73e35O1VlweeFarP4PSCM+KertIS2GT/gcdBstrWNgXipkGdtDfXO2?=
 =?iso-8859-1?Q?6iuwtwknB/rw+XroDnMVpXi41pEtaSIbAYlAFmI2EtO9Z3fE1F9rmTMf8W?=
 =?iso-8859-1?Q?L5HeCJ/IAidiFMYmVuZMUIfo9Qf3zT01Gyg2GZLP8ZfVbF47zW+im7Kfeg?=
 =?iso-8859-1?Q?YXz2cLXvebSApQ68Q/oWk0PrO2ahulFNJQ2SgJWWJGuJ1syhO8D1v1IRpg?=
 =?iso-8859-1?Q?N7Ugvq1242HJOTSMYfl1QA7+aJs/89Zb/OeADfPaUKyLm5/u3LJwaoSSnt?=
 =?iso-8859-1?Q?HbjXg/pJVtk0rCC0LFfbno2NvZqVUWIEM48lwgZnOMjRsYZ9/rAmqhTx+G?=
 =?iso-8859-1?Q?WOYaAK0POa2F026sYoioE6B6nTZFdTciEylDmmpkEWO/i6Eya3D08XH/Cr?=
 =?iso-8859-1?Q?m78sfwnNw+9izSBRwVVZjFRxzS2q8AbuR7p3IQTyG5MCkt2caQkwTQ6rkq?=
 =?iso-8859-1?Q?x1yDP2TfnkT8TsMAyHcOKAi+V+TVbv8JdJUW2mT8d7xZvdEOqsDZTGgtfE?=
 =?iso-8859-1?Q?zHxqS3V/GKqXOIPAoUDvYzhxFnIwo9Nn/qSeb1T7fqsalCC+F5h5C29FKx?=
 =?iso-8859-1?Q?c2mKIhJUNfU/b1azgzRDh3SjMJXtHivVWfjYIXeNTQTvhKR38vJdgao26J?=
 =?iso-8859-1?Q?b0gDdN+RUj1lUwU51EEQCm5LBTFvg9HRKbHFOjWbXzbZZTZ5053DupU5Hz?=
 =?iso-8859-1?Q?TyNiTWA51gCiv8DEVz68sYhwkXVVBzL/xDQjnA4IO79Ue+0NSbjVKvQlgC?=
 =?iso-8859-1?Q?Do9MmwtZOpCy6KZILT3MQSMTXqIrN/YvPDNQgdAvwWceAHfomcObCGnzVP?=
 =?iso-8859-1?Q?4bGBHaWTKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fb5f99-a93f-41a1-580f-08de7de2149d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:45:10.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktck1NHRIY4Tsi84bB+/p1Wdktfo1VN/L/wqTt1hB6mw3ULOEsDLE5m/TwrmRFgfO7b8WCv81cjOWqT49G4J/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
X-Rspamd-Queue-Id: E4F2E23A130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265556-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.369];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c0d3.blue:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:42AM +0100, Linus Lüssing wrote:
> To be able to use the upcoming SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE
> as a potential replacement for SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED
> also check and toggle the active state if multicast snooping is enabled
> or disabled. So that MC_ACTIVE not only checks the querier state, but
> also if multicast snooping is enabled in general.
> 
> No functional change for the fast/data path yet.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

