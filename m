Return-Path: <netdev+bounces-274577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNy9Jh59zmnBnwYAu9opvQ
	(envelope-from <netdev+bounces-274577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:28:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560538A82E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0CB030131A1
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE353DD510;
	Thu,  2 Apr 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2Y8H4n9"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C12DC782;
	Thu,  2 Apr 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139774; cv=fail; b=sv66GbB4c7w148WBjAqv2fHHp7KXvRrZhQ+lKsMD1pCEaeX6tXZBFf9qS19broed6ziOq55itrBbnWRUZ7mSuc3Pcozz5GtpA7EZNw/Z3/NchiP0rbAYGyBekxS+Is2xq3jk6ERJ4meVTPSmHG2jWhb21n0O9wNpAyU7QABQN1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139774; c=relaxed/simple;
	bh=es/3PLUd9lkbQI7ZedUnKmTdTLsJtscd63frcgb6HmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FcO7nvvjc1P8HyIfoZ4TElzenzB6k+ZyhAuvKIOSCZQBfUS2B4RDXQBLMZYIIctQCLNXk4SlmfJaVBlMsE1qCDoNSKwcHskCo+FWNNbkEjRL8RTQiKUcNBxOgJ4FRGCSkeKo5e8+z+FOd/EXTTz8uGCAEkUX1wgA+zxgtpBd1zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2Y8H4n9; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejJAzFf7Pu4jHq+M3obVGoEGLfaUlGxddn4EMnyWm8Q9XXgwKk7sZbtBbacRnQEjK+2xph531XkIbayNnfiLwAi7uUWW9Qf8xLCaBHcQu6g7/81oVBMYkmiwbYfL7oSekzvmM1RJC47fqPSef9J3S3wAcWfYwo/rzu5yIUQFNONh8D2F3r7WtrEu2zN/YhamSSU6akH3/3Wl5E6sVS72LKsbxCSLIMsRc40OY/JED6YzQTKEX74Jv9f1DlHopNeg3JLvAHYb1TF8s9JUP5KktLME6wIsHf7NjQ21CB+DgNfBrO+B7v0znBAW20w68yPSuwLC+E5KrKKeI6yomlCuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7lEzBzhE4QamQVQWXoI28p+tDfRzkHqhxmYVwkrIeY=;
 b=hr9AjLnURyRrYCHVpN0ubZOcmL+3llx4tzBVCZYGy3GARpPysfMBoVtpv3PNm1fc0m8/SVLYzEcXcU5jO+ZBCpG01Te1f8EMcJahJ7aOflQZkoUggUulsnZdb5bBflBxyFsKQDQLh5pNl5G8gwdqr0vmMhTv4ZnhzA/1fNgf8nxFCF8HnboSMB1IgThCvBAChUUNZsXoCOuaLVbIl7eo92vxHVcidgC0KN4+/dsEd/1L4KG2fk94VJOgsjK8EjrMHlVZa1I/wB+I/MabbxNn6gGzlLsq8KP16P0NPSadCTcTFyTcE42G/8U2sJ3sOQx/nooJ+zHujgO7ab5NumD3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7lEzBzhE4QamQVQWXoI28p+tDfRzkHqhxmYVwkrIeY=;
 b=a2Y8H4n9tgOQ2Hcv3IDu32LxF1+VLzMx4kHn9myLDS+6ouGk1OZK6gcYOL9srBVPmuNHbdbuf2WuZaW7e0GTHC0axdT2NpIudxmEu+BaJ6uiA2NLQNDCo7tsEVK9YLxh6/E6xTk0vFn7xWzqDg+1FVhYtSqmRKL7dmoWXlZpSj2T23FwG3jy02y8j6WUbjjf7nHxqciQvoZQrWbzi+qVue0bokE39+4k/S1A08iTD5yIeaLgqFfFxD6Zq+zUL2uB4EkbO5ZX3QvXWKyqp9jT1F5wuauhLCU6GQSuwI1llE1iO2kWCttomb1VBSkINcWLtQrCD0Na53yJodF6X802zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 14:22:49 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 14:22:49 +0000
Date: Thu, 2 Apr 2026 10:22:47 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN
 support
Message-ID: <ac57t2vsRl7YF8ET@yury>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com>
 <acyCmHh1IAykwycy@yury>
 <CAJq09z6fUhwnbZhFF2okU07z2uj5JPr5mAerpfSxhYDgRNZvwA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6fUhwnbZhFF2okU07z2uj5JPr5mAerpfSxhYDgRNZvwA@mail.gmail.com>
X-ClientProxiedBy: BN1PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:408:e3::23) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 1880e840-bb3c-4a00-3ca3-08de90c3513a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oerabNaJ8KxJ5EMd2r0lr//ULfCZQHQBQVpoK6MxL2ybA18kMFiw9pdbP1qjW1Ndm3pJ40voTIHwlWts+vgdeDVc2MkXVoAVhx92LDI8lKujJiii6R03q3h7zIcokna14xclB90xMsHDNPTN6QjNQplZSSkwbKFdYL+wWKcLR4NtbPO+JNYu9sY2xm4xV8YRhCrRnmZ89SmaXgwkQ/97/DE8oyxQSdRvxDeSx9eUrZslqXBTBmLdkUPSoByV/+zX995aYfKpApI82qQsnSeGHMIe1M+DLNbzY3nIA/MUpRUCYi2FfACcyO1BXfLdeWH5zEkdlafeY6VrRGM244QDSTRcK5vlKhSr3jXSfk/oi8BRKGzoKDa/96me8kHzBNcO0aJFmAfZUt9t1Ikz+PmuvoVIhvROD4E55Dr9V0iUPRr7vjUEQ3AFV08Dw8rt9ZA3UNk2sd9oT/DrUwugzijIcq2+CiSeo0Y3uDkoowqA4vJiasFv99ojVAhIMt9bAUmMJhzv1GdzF88OsF1y3aLewYVjV/iLz8qQM8dwqd9vM276aCjEk+LQAEJe/L4r1lregQvzw/qylBbdkJWO1/z1e56AlyW1QttQtR4dP7oztcgtn1BApc0fAwoykRh4fCBGLhl/MgJ6KDPsRa75UGo4ndHejCm3tGUkBGT0Ue+FKa44BS5jfVQxOPHBRAufUnjVD2FO2NC7eDNR9IzhM9fgKBHh5nIe1lZCEGo6ZlBfgSY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZtWwUrSHByYU01sc1U8dfPZlzHJpB0fCNg76XkTVryP4wLE1CwoQxMJ3ItU7?=
 =?us-ascii?Q?uqBP5Zah7OCvu/tPMfLbQUpvp1Hx18pCv3BcqVkqQBH+AVFQXcPUSudjNpmP?=
 =?us-ascii?Q?g7uOU4peQPfnNDH4afSPnPaYP8wIOyv9UwEo4NyWXYCrcrViAi9cvbqO5xxh?=
 =?us-ascii?Q?hL5dt61MWzqlzvwbhasRjV/AHH/5r9cnySe5NBPCa66mSVTkvfIb3nuAzz8V?=
 =?us-ascii?Q?OlMCfLHGK+ijxVjmITxBuep3j9eHMMBQOVGlz35nTkGLlNv35OP22WSxbNPM?=
 =?us-ascii?Q?tNWQFrhmrFmqL5NMoGdkgOfwa9mmpc9m+84zK7lBtqIwcHN3pOetpicmhR+L?=
 =?us-ascii?Q?dn8mbpdyQkqJ8RAh8bwKgm6/Q/IeNfuasY2LudY92apZUl25Y7oMc7JcvmO0?=
 =?us-ascii?Q?JOpCfMqbZ7a5H7cz7r5UsKyxC3hTvv9gTeDh8J55zkGIAiMgy34hf5oOEWwl?=
 =?us-ascii?Q?DrJklKuzkvzaZWfgxVlKV/xI5ViVV9mkHa9GcOwKDtOfIXhEmEf6LjeM+jNj?=
 =?us-ascii?Q?O4Tq7WzjThiE+jj0YdYbqYOhiv0Com7b/BOCfcpwJhru+4wAPxS7pPKtUVnF?=
 =?us-ascii?Q?pUyggzAnJMF1VIniORaIzH1QbeK51WsnsuFYCIwbW7ZMy+4qPpxEx78+gu/x?=
 =?us-ascii?Q?WLfvB3vBEiRWCZYv9pM4Zm+Wnpi/WgouLRUO6ybqbJ+J5+c9he43ZeID9wp0?=
 =?us-ascii?Q?nQ5IUv+32974oWTHDANN0N9ciboUhaDiquWUxvPd8YjPliNmyH2JvelnA6Np?=
 =?us-ascii?Q?yrvjgr8RLDv2sLPZZq9C00ORwXg3I2rYd2RK1IfF11QG07I5xePus9XheUD6?=
 =?us-ascii?Q?k1DHQic8o0D1KxP2etIolSw0eVRBmVQkjHnpP824RNrQbahldPDOyycFjpHs?=
 =?us-ascii?Q?p0Vsvqi778NEGZPOnMWrcHxv5zI+QIzFupziKanWehL/Q3CyFC/1pHaX6TWl?=
 =?us-ascii?Q?pxsqCiU693Id0lK6/XBQfxHUoZxc8mG6JWLqf2uTtx5UjC1KQ87CcMvDq16x?=
 =?us-ascii?Q?mXsSTqw0A9270AUzCzKlwmvSv803UHE3LkdujGFTkbfsXKKpIqrsU1RKTi1L?=
 =?us-ascii?Q?HAKuYFbIKzbbZOyRvA9schRoypXksaQ6nUxLzTHqbRrsT3Ou3wyQDcoKEXY+?=
 =?us-ascii?Q?OCAZ4mLYq6xsOLastk7jP84HcV7loG82mUhg2N5TRJFzmjswCMKkpEjiQqeS?=
 =?us-ascii?Q?gTZCSjBIalrbl8MiSBNjVqk7cohTyojpTAkMTJ0m9IXKNocZl8dbTKjNuzWi?=
 =?us-ascii?Q?U6TIGPVTcgpRH/PlrJTONfey6S8XhtVQY1kO+7RWR91le6R4wARgEhJ0CY1T?=
 =?us-ascii?Q?eVPIcKwuIJzXKlSP9+0ZoYNXdMcNty2/Jn2fnEm1yNbzJ74HwwENJN/RALok?=
 =?us-ascii?Q?D2HcdRq18nJh2fdHQJ37ZMBb1aEi4fz8cvNLcqIlSGA+c8A0cxjTI35rzZHQ?=
 =?us-ascii?Q?Fa5mh8vZa3Gzlt/GwwjSUPW6YNgqndPpGGNlC5ObT0sm4WvNqxqEPf/uMaQe?=
 =?us-ascii?Q?hgi8Z4OMuqPKAMJ2vFiDxlitt1vXoTt18ekc4CU9jgifEi2voK5rcnCQfkBg?=
 =?us-ascii?Q?EKktJk4ekfE3Sl16Cb1PylcJbgO6d7TJYR9eAobBO8VVjq24BvQBwPmFPo8i?=
 =?us-ascii?Q?ebt9dM4NX15mSQwJ0i7EVeTeZxtk0l0eU3FPlqxDbHYPqgE5lnnNAkGqVMP3?=
 =?us-ascii?Q?RToVVV7Wy+jQYyvO1iPM3i4SlKbWZGh6d6AOhkHeX8ysUFT1W6ka3pcSCzDI?=
 =?us-ascii?Q?wQV2dDPp0IDqZoLqVMTo62bjdICbD2CpKVDawq0fky400a4ARQ+t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1880e840-bb3c-4a00-3ca3-08de90c3513a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 14:22:49.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBANnS4WYlthWUqAy+D8OxbkhTl+S40xZ/Dfd9Wng6Ak/Oq7Ei+8LKj2LdwDcOZnOp10FFaHrWw2UdEQPi+huQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274577-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9560538A82E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 11:45:18PM -0300, Luiz Angelo Daros de Luca wrote:
> > > +     vlan4k->vid = vid;
> > > +     vlan4k->member =
> > > +             FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]) |
> > > +             (FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2])
> > > +              << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));
> >
> > This FIELD_GET() << FIELD_WIDTH() resembles FIELD_PREP(), except that
> > you skip some checks. Is that intentional?
> 
> While it resembles FIELD_PREP(), the usage of FIELD_GET() <<
> FIELD_WIDTH() is intentional and semantically distinct from
> FIELD_PREP(). While FIELD_PREP() prepares a raw value to be written up
> into a register mask, we are performing a read/unpack operation here:
> extracting bits from hardware registers to populate the driver's
> internal logical structure.
> 
> Using FIELD_PREP() for this would require defining a 'fake' software
> mask (e.g., GENMASK(10, 8)) that does not correspond to any physical
> register, which would be more confusing to future maintainers than the
> current explicit reassembly.

Not sure. You can add a nice comment on top of those GENMASKS(),
explaining what actually is happening there. Long term it always
better to avoid opencoded shifts. It's proven by decades of coding.

All that FIELD() machinery is aimed to avoid shifts and other
opencoded bit manipulations, because they are proven to be a constant
source of errors. And now you use that FIELD_WIDTH() exactly for that.

The alternative would look like:

 lo = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]);
 hi = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]);
 vlan4k->member = FIELD_PREP(RTL8365MB_CVLAN_ENTRY_MBR_MASK_LO, lo) |
                  FIELD_PREP(RTL8365MB_CVLAN_ENTRY_MBR_EXT_MASK_HI, hi);

I'm not going to teach you how to wright your driver, but you see -
it's 4 lines vs 4 lines, and no opencoded bit ops. And I'm pretty sure
you'll find plenty examples in the kernel where people construct
registers from pieces this way.

Thanks,
Yury

> The 11-bit member field is split across two non-contiguous 16-bit
> words in the CVLAN entry:
> - data[0] (D0): Contains the primary bits [7:0] via
> RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK.
> - data[2] (D2): Contains the extension bits [10:8] via
> RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK.
> 
> This split layout suggests the hardware was originally designed for 8
> ports and later expanded to 11, placing the extra bits in the
> previously unused space in data[2].
> Even if we concatenate them into a single 48-bit value, a single
> bitfield macro would not handle the non-contiguous mask.


