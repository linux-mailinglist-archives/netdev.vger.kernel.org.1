Return-Path: <netdev+bounces-86635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6736F89FAA9
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985B71C22C17
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB0C174EE4;
	Wed, 10 Apr 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXvDDzZY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2106.outbound.protection.outlook.com [40.107.20.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A3174EE9
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760609; cv=fail; b=ResKRO3oM6qFlcY/jJFGUAqyC9WA5sfqYDVHHpml6oMAG2erPjuoY3LoS30pRLJX+CdvdJ63zf7kLvr4SbYXC6kTgZp1x4zkHXsRpzB3PZVDLiR60C/LKAr1YFkrSGfUZpEKZBEboZ+gwO4AvMt13mIEpQMHdKI6GmJLbIb1myY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760609; c=relaxed/simple;
	bh=AxLZuWef6Oe70M7MFDjIQDPsiaimZCHbnLsOUDOxWII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCs34hhUtSireeSttQh10247UoqOwr5vbiQ1Hb+FpDa7npZVHyv818Y/W0fcy4F6jpIWXekx4TyQTDtzEARPZoHb0BnfE4oeTygJv8KJjjVAg3vO1ld8uRo5PaHrFbfCNFozGMoBoViRtVmyeKVV972FS5za2MMuR9WiqVTtp3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bXvDDzZY; arc=fail smtp.client-ip=40.107.20.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWjesSGpAW/68zAnGh8MLgCkSaG4Camc27aZXSRGuT9YUKa6FUJL1aWv2rPs3LCRyH1uoAt1q4fk3VjRs8+10prsJdqgNCtGyrnsPfq9N24rdsuuIQv8aVCvAp7/+qnW6Gh8ksxIR2fqCt4Hs5Z+RJUe0PUDioDeLrud39/DR94ruTUsc6xqyg5P267lLXNTVLXTrdgUxFR7n2LgdPG00K1m2l2rZxQOOTl3lohPl814mYL8Kx4HkYFoXfPXqy4uhJoeNrIRUW604e0B0I8w4uiZtN6hEMGTeNkcbUnk/n1760H1tBhliLY/7buf9fEPAcV3v55sRk5uVQEfhx7I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3anfRQz+ehCHg9Pie7Va+U/A2bkl77FXm2H/W8sbzM=;
 b=dGT0ovfMVx7sx5Mb664IYzxnZ5lLz889wPu+rbW6Gm83XtJeWfvKSobh9brQfaJeJRWmxMlqT3mEtjYJa2oqYMNi1UkW+0i2ayoTnSDfHOgZxpnmhnzsWWsllbVT2Yx8sCvwSHgMqfy3RaT6zrpCWCBYc0RLufHlNEvxvf9MpcbMLnZHT/+A2/E9pqzpeNtSCPicrjlAY/BggV1fHi4wwGTymaJkg2te5/iK36MKd4N8FhJCSOAki5VdacI06ylEwn5zvTfU5PpbFxunzFb3MEpK++/FR2z7ioEMMbayWWlqZsse/y21JshWMvCReCTHPpIeWBOV84VAo2XToXpYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3anfRQz+ehCHg9Pie7Va+U/A2bkl77FXm2H/W8sbzM=;
 b=bXvDDzZYAWBX4zr02dcCU0eZSzUeO6Yw9uf1cEFmRoRv/sRnpFnRrhjQ6Cn9gU6PoH4KbiA5EfaJhmFm/aYJWMJichRhrjT8fFyV1fwaBCQcfokmyrz2hd03+kEjRXmKgEPfZlWMHQs0B/Y5jzUtQN8IBULjLfnBI95pipM/ID4=
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Wed, 10 Apr
 2024 14:50:03 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 14:50:03 +0000
Date: Wed, 10 Apr 2024 17:49:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next] tcp: tweak tcp_sock_write_txrx size assertion
Message-ID: <20240410144959.i6forc4wqufwfqpr@skbuf>
References: <20240409140914.4105429-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140914.4105429-1-edumazet@google.com>
X-ClientProxiedBy: AS4P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::16) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB9255:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XGK9R6eRmDj0IUMfrILKRaU/k1TNipMHriygM/1l6eT1S7aUAm6V2tWiKVigPGr8fxak3nAccCjNYHbXmk4TomcEPpvKuHpvfaunbbu4TcnRt72VGOf8oiR+lk8mbRLcrNijELcrfB6G0Q+j6E1QNWdFgaEsx2nRBCook8Qpha0FHCidOFFZSgf1LqDtRLRYNLjYEJgtZHfThOt6ESbtUYdqG5i8nzkb1KNtWuZXsh0outk4+xP5LLRvR0lNqOaqSYhPM2dvAZBK0iZD8DDeso6M2cCHS9X/wm9QvMjXnSObRBnbtYW1ToLWNC68MJWqVQFaS+2pHk/NQo8NRZh8lRTsCxvutjottAfIOkMoN/TckAaTY6cGSlynj7V5ayXju7Zh/2+YNLviG3Nh/yZ6koP8ZKM6ex+0oXKs/QrOwdV94vcPfopSOPwHvDc8oHn/ZS9KC1VYNBT+KltvtVOTEa28UdQovdkbxuCd21rcZA0TCyGF1x0DPxA6hd9bwGMVBIYVG/OClchzanRpoD+WHc2s2CZqrkILPDLM66BaYLugm4MKpL5GzxeZglDQwZuxTWub4BWxzL/EkJE/sNz9nV32IwiJ1Jl4tmcQr4QbjzdV6JKT/3iPhz3/O/kvWmlTHBRUY5A38cY+TQhW53PvuRe9nNiWMri+ARcAfV2T2rg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvrYfBJXiRy9jSS7USIbmO6efgfw5eUd9M+03cSI8jet8dHOn9BhhQTf1HuN?=
 =?us-ascii?Q?ryvnRhFAYdcW4p/hYBrmukAAVASKIc7Ors2bheWpBhkBqaiSOs0M9DdJj7D8?=
 =?us-ascii?Q?FUuPizYuGUpQBjBCpr54gYg5pPTDfeGUnhEd/vHWrMLc1dr4mzTCmAi4SdeW?=
 =?us-ascii?Q?ta2lk+5eN3umRSfeg4cNunEn9Jh8mtJn91z3Rbv+LznI6aegwVCsCuVcb5Ym?=
 =?us-ascii?Q?fMccQFMhfy66aFbRyaxxzu9Epbq6URzad8zqx6aP3GTMdK2b7HaMo0w3+M9n?=
 =?us-ascii?Q?eukNirUlXY7NhcucXanrmj59KbQefDrgeZul5uOpbyHOao36OOMuYKTt4Uhr?=
 =?us-ascii?Q?wJkUb00HzVsLinaPjAFyTnGSAI1lbpi5L85WDAJxqYAgIj9TYDNeZAV1gipk?=
 =?us-ascii?Q?HHrqmSzabhnu6z7yRgH+FvEqWbJ6Wfrl0DlbtTsdeyxkNoliynEOR/QZ1n9f?=
 =?us-ascii?Q?kS1Va4PhLG+/60Ehb2g6s3L2hIXTJh27uJOC4S3BEEHmZkld1eXA+6eFXrpc?=
 =?us-ascii?Q?df+AUkkJVIwu2s1VPz2yJIbeKBLEmH9Qdf8y63AMDzECSyU3WR+pL1zQDKCv?=
 =?us-ascii?Q?okMU4Xkot0n1wjovOY3uksM3vLFNmsIUu7D/PRhu8dG8A7oLwa0mhoD/2lWx?=
 =?us-ascii?Q?Tb5IOj/dOTi/aYBEJv9kR0IPpZczREaKHscsPJ+VqLllXLa1ixPYXnyUVHT3?=
 =?us-ascii?Q?Vqi7zATXP7tjMnFlcGzNqDZVzf34n+DLTm8L+PRdhRKVLtuR9mcjuYSqhyQW?=
 =?us-ascii?Q?+o1ZQpE89AelufqOHIm8n6Zt6d4Gyd7jxGSsnf4wT26rYdtkGLVEkOt5j3mA?=
 =?us-ascii?Q?Qjlm2grwfTnowhWLl7FnS19jn+i3bB70Qjoyhrv8/1zMFc7XS1prLw2jtSsF?=
 =?us-ascii?Q?bQfi68h8cKbZxf5z7Lb83vNAQzSid5HIfGYbsWGO4FWTAWognwJ8/YyM+gWf?=
 =?us-ascii?Q?i+Jzin09BvuHow57HLv42MPJqDW59KyWz9jnhchDdoG7/rWB6mPrmRV15fkV?=
 =?us-ascii?Q?NNpI8MLu7WzjcHhnWOQg76dujE/IPZrLPJaxvM1zXjQnBx6CxTk1akBXewog?=
 =?us-ascii?Q?DsodJxIyEz434xvv1XOLPD8Lol0iCKuqk2jFAMScC904Zx3ghvjnVKg3+7W3?=
 =?us-ascii?Q?INPIcyxeR7Wfvs3VTIHmKOvkW4glcTbTYToOjkCJjZsPWPjaF6h6d0COuF1B?=
 =?us-ascii?Q?7qTJbrmov4O/R4z2QfE9HiOcaNvOQLxSFLklWK8+VMCPKAeF5WbupGwotGdo?=
 =?us-ascii?Q?tkEM76xqdUZDmQW0mWmlVVs2NAJxRBoOUry4twgSr2U+BeTlJVZTht9gqtb8?=
 =?us-ascii?Q?G5VsdVi1Kh/QiegzFL3E91CMGHUz0m/CZVLpSAgzeg/zqUZlx/iwGoLNQWtc?=
 =?us-ascii?Q?PWgHmkrg3r+QAj0FUu5Hne3aNyySLPSynhPk0mFWNCDGFnj37+Y+Qb2CGKZa?=
 =?us-ascii?Q?SyeCbholCj+KA2aBdzyxhWAQiUHQok4kE4VW4sm1vAgrk7GWEFA21yorcham?=
 =?us-ascii?Q?1wgcrBqP+quAbJEL0kAeLfkWPw9GXLOMnBbEW84BifT0gCPaJLWFp89kY323?=
 =?us-ascii?Q?RGwvBqkuXCVrCZEBG9tDyivh7tBpGwPau7bSUBgac/6d1WVxw0AF+bsWHR2U?=
 =?us-ascii?Q?3Ce8X1rsqzIlbtBTgKvZa4U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ab54b5-5014-450f-6313-08dc596d8119
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 14:50:03.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yucW/z+JroSALMtaVEhuCQmZWiikmgkFPUuF+RweD04QHK+wLWsV7Y3I2rWZKoV6vQeWbufl5IkHlXFhCEKNbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9255

On Tue, Apr 09, 2024 at 02:09:14PM +0000, Eric Dumazet wrote:
> I forgot 32bit arches might have 64bit alignment for u64
> fields.
> 
> tcp_sock_write_txrx group does not contain pointers,
> but two u64 fields. It is possible that on 32bit kernel,
> a 32bit hole is before tp->tcp_clock_cache.
> 
> I will try to remember a group can be bigger on 32bit
> kernels in the future.
> 
> With help from Vladimir Oltean.
> 
> Fixes: d2c3a7eb1afa ("tcp: more struct tcp_sock adjustments")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404082207.HCEdQhUO-lkp@intel.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

