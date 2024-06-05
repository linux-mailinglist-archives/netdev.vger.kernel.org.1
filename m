Return-Path: <netdev+bounces-101046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52FF8FD097
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3DC1F22021
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A23CC13C;
	Wed,  5 Jun 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPFTpgCk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA619D89F
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596928; cv=fail; b=TVZzStbV8yzbQ9RnKdpLm7ARelB0AiHJiq/gBY4Un9G29EQYe127G/T0oTii0lLgTneEwigDIknSFLY6vSCyD2uWiTDMrr4bkTTywaUYrevypM9Qjp7wyz8FVg09usiZOZc39/tR/0AKyyheytUNYsunUTgdFift3x+jbiVkeQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596928; c=relaxed/simple;
	bh=4OX4Iwhu29HVv5dEmOqR3fu0tmv61Eu3fiQhkuw6u9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pc0ATdWmqdnOS5Hij8lR/+Suv5iSEYjAj2eijDYqQCiez0w/xHXDXJbPFG5pKaKkeqC1H05pOIHn2JGicRjd4d9xUT4dyNkrlN6WL2RKeYcwcOZoB84euMYOnf9jtvS5T9CZCEXtEg+Pqk7MOGQDYV4TQxJyZ/FSRw3UvkHNs3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPFTpgCk reason="signature verification failed"; arc=fail smtp.client-ip=40.107.7.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv+e/kV1mm3K6sKoeg1cVjWlBWj/6QwmgqRhm4lXowxQ+yL0Fk6wXRNY3FhwoHeK2Y2LHGzDuHdMrWEBbzCEOWv7gPQfKDHVjhuijWMjmh9pG+HUq0FtGhHz1vnlkzmcAzWfjpjAZsOmpfjkIkAiSWsb+ARwtjyEG1Fa61/dsOmyxGcfCb1x5SQ3yx4xzTCn0N7SCwlR8BrZiVrhfUv3EV3YPnlZEE/F831qA6zojYnFDiI64TxNAw4z8eXBdNbktQ+4cpllo8Kl1pX/gBqpIsGooJ7HlY2EGYxxcbptRuX0sNLUSWAX2Vp4I+O7RgKYQ8vo+Nn6xf0qbdDkOcWecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPARhH12iOKhk57WIWVI0Et4T2wpGZyJFWztamAOfiU=;
 b=QzF7qE0VLaEHHlbkLdmkHvZBrb15MVk/ga0/ipU9Hg2uqm0TJQD/rx8CanVWNEhGLfy4FJGWa2Yp0X+TUusI3tOBeWDv+wh4U2rxr+jRzDcsv0ndyl0CvUMmd3vDU9q3a1/NPqt1MJ/tc10BVK4Gddn5U6ZOK9Pz7Eyx5/za+6tE7POEaY72OBuwTfuqC+AwN1l+r2affVn0WNB0BvtWZAXkSluM1tVyoc632FMmWvchpEA4OUUxfAqfxx7iz6003eXJmQQpW8mKnaFHFPflbLX7LdjthlpLAt5d7ZZnzTyit1Q77yaqPys7g4XffQeCQ3QGvhrqnX30JhhfmGMLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPARhH12iOKhk57WIWVI0Et4T2wpGZyJFWztamAOfiU=;
 b=mPFTpgCk37zyrCzVGPhiRvd+enFfj/IXAoJwEbPqsGRYlF6xOnTKwGuQEdVCtXGr15ET/mr2aIcKtqedo4oQZGSEBRTH1zS5eud0kxWWhLVWpXTRPhvWGt3UlirTZxwQEWQuFShxW1Qe/nn5p4jL4BWfOS1y6ectNsNsiG4HRkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 14:15:22 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:15:22 +0000
Date: Wed, 5 Jun 2024 17:15:17 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: dsa: deduplicate code adding /
 deleting the port address to fdb
Message-ID: <20240605141517.6rksxmkzgdi4bu32@skbuf>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605133329.6304-2-kabel@kernel.org>
 <20240605133329.6304-2-kabel@kernel.org>
X-ClientProxiedBy: VI1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:50::27) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4077e4-e5a3-4075-8481-08dc8569eed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?6Z94Uas57+cBiDHUDhyK3us7gFSUy6AKbz2P80Is/mnzQrs2T3fG27PFlh?=
 =?iso-8859-1?Q?n4eKrDkdMtIQtlcFfbpu+SSN4zRaWlZjXxZjT1b6PIjDmp1lrR6B+20coT?=
 =?iso-8859-1?Q?5V5Db+8Zg8EIHVfi03AsmSzzEwpgsOi05OOWd4A4NG5+XFLiOaa24xlpD7?=
 =?iso-8859-1?Q?0j7ILERKsRhZGR0f6oSzl8pac8+cvPgSy6lTTy1JaFLK5M6PUX3Gax4pgE?=
 =?iso-8859-1?Q?PXt0z+8FzrUC1J/pofqAnw/wxAL6WH+9qwikAx11+hiwoZPmNmP+SjdUnB?=
 =?iso-8859-1?Q?arDL+K/eWuu8mxqewUU+dufeQ1zzxFY9jz9zkIIATzZP+orI2Jt6xQ6+Vo?=
 =?iso-8859-1?Q?FKRHGoAfE2YR4FSbG+wp/ONKHt01G4vOOYUYZIhWwvZmFnjbLVb9jK/MWr?=
 =?iso-8859-1?Q?Uo8va1IE/t1AsGIb8BJU6XPh71S68uMBYLVIRMAD6Vp5lGJu9OpeRHhbe/?=
 =?iso-8859-1?Q?75goKuyBnwX+pFjnclDZpJHSfVp+fuXVDT4h2fLKXWXfPbKIs/ngzMuTMZ?=
 =?iso-8859-1?Q?LEO0TNrMkofTGRPW6XXQ2H0CS6Jftj7ab9rqM5/othPFetjQ3EF6Jl5Axk?=
 =?iso-8859-1?Q?cvt/Ob3Dgg++4KG7P6xnSLnixFoVM025eRQO3kfUui8cTT7u2t/qQ++nRp?=
 =?iso-8859-1?Q?A+wvAiupn/quHfiZRS8w50naSlciTHiJiklG5W3pzfzsDxx7n5QWjLgfFn?=
 =?iso-8859-1?Q?bPanhCUY9hRBcN1FLoPgFpdesEDN6wE3ci2VC6ExSDoVeC9VJol+eQWWaW?=
 =?iso-8859-1?Q?yOj4tm1GBJp3fkawULxlBZ3s0B3yteG8V3SK99uCnwYi5kmOp2s1aJIfN7?=
 =?iso-8859-1?Q?kGUUSgeQZ8OT7GGWglNROdE+oODkymOsoTth/NuzDunzGdJ0jnWp6BJ0tF?=
 =?iso-8859-1?Q?WOKF5wVocTl6g+y1iu4JGpL/44NAoOrEl6GQVrmhB9LML3Bw0YRRsYPvUF?=
 =?iso-8859-1?Q?dhdQSLCC0KVEkIEx0bS/NFrC+2OgkZOA/ji71Sj5LxJtFPqs4IIUYTfhiD?=
 =?iso-8859-1?Q?eyfVHDhMCNq2/Rq98Vb5TquPvTyuLU2b7JsBhu5i8mFRHzO7E3BbLJtGoj?=
 =?iso-8859-1?Q?eQ1zxzwamL9BZTH2Yq0TLTSHKc0mEUZacuaSMgolKFdLE2afx/EbM6w9ZJ?=
 =?iso-8859-1?Q?2y4WSiqMJ3f6gJ06Mb02e7pVVRAjYK5GhSxgS6L47FSNUE2fgBotHbZtII?=
 =?iso-8859-1?Q?fnczCxWmcnr1Wr9+Wn8Suyx10GxRmO9P9Wm9gQWQNJsHyuv2VE6SjomI1O?=
 =?iso-8859-1?Q?99Ej0IbUv/HV3BIeMugfP7q7/6owxcY4GLs3UkqMZa2/w3O7pxa7igt6sh?=
 =?iso-8859-1?Q?vECfTwdYWvmxXA3MJrTktHeQsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?E9YsqSeb2ir7nJ1bQ9c68jCG6PNpcSusGC4K91OUYZAmtpA0dAM5AmettO?=
 =?iso-8859-1?Q?iVRg5ZvY9vOEZR6/n9CwAcoZq5/BmXh5GmHpUj1Q9lKYT6vtZgEHiwaiGd?=
 =?iso-8859-1?Q?3DoAdS1fhcEqSAunSzCAC0ZVY5O8zkrc1EoRleHLsJ1C9pnvjSw/h27tdW?=
 =?iso-8859-1?Q?bj7oUieqBHmMcI4EiujG6jXsNoc6jCTUuGja6rJAICNMXuUxAWOqebuaHG?=
 =?iso-8859-1?Q?Oy/SEycnWoEje8rxm/5zWTXfu8z2UchPY5jzE8HXEhzHsUG+3+8xmd0w7p?=
 =?iso-8859-1?Q?oshVaVNAqncEpoZvaHpSyddqx0F+TqtoAd88i6rA771WWX6wqIg86lh7UM?=
 =?iso-8859-1?Q?fCgUymMncKuDHwSEyERdxvvZ82hi1OCYH7yX4FFA86+FMCYGExH+kqXRJN?=
 =?iso-8859-1?Q?5d9aj0PbpxZIxRoqCOflYZrSVz9HGYlASh7xEq9GHoTA3ggpPBSghKsjaL?=
 =?iso-8859-1?Q?mfbtautVdkgkt+uL/bwW5GPCWVOZWtrwGngjcvhJ0mPSoy3B1QxkbyEryQ?=
 =?iso-8859-1?Q?nwgkFxXwJ+7XdMyuLsswvdPp65VV/xHMAM2cZTh8P68KisO417Td/N2s79?=
 =?iso-8859-1?Q?7zO3F7LoKrz/zRs4quMyqIQB4VgHmGdnu1Q2MNPIIRK+UU7f/IyBUwjDUp?=
 =?iso-8859-1?Q?oJKVt/kT4crof4zyeX+m4hroEmCrHhY54l6MGnz3DyvIFc3mTMn78vDVVp?=
 =?iso-8859-1?Q?z1FQ54RmgxcIkE/wmfAWCLeI5jAJJ29yLJKLZj4c/EJHFz5IBRxwtNkbjK?=
 =?iso-8859-1?Q?gMv3p/7wJ2od9tb9Ip4PKsLyZZJE14s8EeJlJpu+SqVn8LOk6KYv2nv4/J?=
 =?iso-8859-1?Q?cdm5r6HcEb8lIFwJWwzg2x/cc62+aqePhOf8J5FAH3bBoa4e0nLoZ7bsI3?=
 =?iso-8859-1?Q?x3jeNrfdAGsG8e/eU9DxlwYeP5NAcRWd5/oDr5VbFrqOxQ+DWgQkFKWAZa?=
 =?iso-8859-1?Q?Cft9O4WdR26Ih4izL4IxMCte4FAbEgnFLvzb8RznxhVdvubwpmlXFj0NUC?=
 =?iso-8859-1?Q?iCgS6CnKDJ4d/cJKc0IgDqdSG/Eq3l8nQEr+Qo0wnfYiXK2ETdnkLrKrV5?=
 =?iso-8859-1?Q?Oml/RJi5ysZQA5B9Hs5EMaPMAIdK3xeCCcv1eFOCjVmYTs8ySiFiN5pgUo?=
 =?iso-8859-1?Q?GJIKvQX+/Dsu1qjehrnV73k6VKRuZWU8IpmMO6hrVbBMJiyWNaETUoD6gq?=
 =?iso-8859-1?Q?VLm8/FhSZxclJevFUcpbdvnN0jyCcEYWFUFDyzpwqb1F4HGu7zUppux4wT?=
 =?iso-8859-1?Q?CuoZs9ljuVdO40XzaJx9i+kR2uneOtyduSWNf2TPR1pf7u52wJhh+Aoo4n?=
 =?iso-8859-1?Q?qnpY8y+put5jPt3aevhIt26iC+zy3/cmNTGShaSTkgtT7lg32lvlvZ0CEa?=
 =?iso-8859-1?Q?F8wXHdaPG2bxQV+qs3r1LpHqT2zGm2eiDk4YBXRajnn/sC9z/GOxaEUyrJ?=
 =?iso-8859-1?Q?PsyNDFXkBxR3oRxFBfJEk3IRuYsnriCY+6OvIqANY+C8XW2cDhSHkQiShX?=
 =?iso-8859-1?Q?B9ere7hgmPdCP+4vNcxusra1figD7FryLQFrSZetXyal+cy6tf82JR98P7?=
 =?iso-8859-1?Q?kNGFmg9yBwiyMBHgytH1kK6QOQcWknyvD1ZUPI8fh3+LAflgxqVXyLU7vU?=
 =?iso-8859-1?Q?Gibd3nmXxWCCR+OMM86dAgMOOJrs3cGkqNY64TaCaBH1f5MK6j30QCdw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4077e4-e5a3-4075-8481-08dc8569eed8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:15:22.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3m1Sgzy+pUaSKPTpGDE2H6yGfBpXnM6Pxq3ZDadDlo8mEdAqbT0kce+c13AjMaZOfgZlFcYw7s7tDjm3TdkvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

On Wed, Jun 05, 2024 at 03:33:28PM +0200, Marek Behún wrote:
> The sequence
>   if (dsa_switch_supports_uc_filtering(ds))
>     dsa_port_standalone_host_fdb_add(dp, addr, 0);
>   if (!ether_addr_equal(addr, conduit->dev_addr))
>     dev_uc_add(conduit, addr);
> is executed both in dsa_user_open() and dsa_user_set_mac_addr().
> 
> Its reverse is executed both in dsa_user_close() and
> dsa_user_set_mac_addr().
> 
> Refactor these sequences into new functions dsa_user_host_uc_install()
> and dsa_user_host_uc_uninstall().
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

