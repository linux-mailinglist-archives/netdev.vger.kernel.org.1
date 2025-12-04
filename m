Return-Path: <netdev+bounces-243516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB2CCA2E56
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 10:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4028930198B8
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE904330D32;
	Thu,  4 Dec 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="jE8ljNYN"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE5284B26;
	Thu,  4 Dec 2025 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839008; cv=fail; b=m9mGVUcYUVtNSVSfLJUCmSPELpyGU02zFRG+EE8FYLI47g91W95I+Qcy/eMZ/QXWCjCAQ8K1IPyE7+9VjTdZJKUdD1d4loPsLcgjFfzbO9f1v7kIkF7g+Qyd7zI2/cYaDSzczAi+tLGy5kgHY2yWi8adeFslL+LBYmlsN3qegIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839008; c=relaxed/simple;
	bh=PNr8pfGjkfTp0MhkqHSeUyQB4brRa0Cx9tTWBWaqUuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=cVbpXpYoogfrIXab3ZuUmT7Ley0DJGA2z7BuV/zBXwHfi9xbZ6ZAqQ91PqWk2EpGLF7EppxdX+UeTFckGWNjfR4BygbzWJgFbjJAYoQi1HhMX/Z1CL3DvKDTGYJM1025BGxeN72gzZCAt87hoxPAC/C8/GnY2YZqd/PP8yK0LeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=jE8ljNYN; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8YH790uIMa/2uP5H9wkdoqUZCFR60P2ziqS61PuiKjcjM3io0VM7Pws5YFNbu7YHY/xju9xk+9RtsgJB7MglvJsU3x/cbCFQRhEb0kp122lrLInoX03Kx5i2RWrh3RkS7l6CW4FKYKrF+yav6kS6TjJyJwv78hiofMj2Sn7dsgVCwepENsMHidIJ7G5Zb0XOauXnigriOwMK5yfoXt/7OF3H5PMAg+Pchdnmn3FCX4m9mZ0AxODgrquh8b2x5GbKnWrCrliZJ970UR3eQ8DMbBTm7uFdCjA9Yni1dsFQ++8Pyr41T+5FXH8WDN3d371TFgs6ndTaE10RHdbGOLiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CYKzPkUFi6bCbRSOWUJ7f5n1kPCHgrzXk4wS0zSBT0=;
 b=gKTZlhi3qY7y/eSuqbPzRQe/3DkVmEr9jkCc/USxDdfnPqX9jo0n9WTIY26jPQzbMQeiXoX8ia3igdVjZDnZMPimAZQ+Mgimzy86TlEuGAo1+mwEm3F3R3McKGOA5qIJ0Qs/1jXDdJAFKfdY9uLDRDekDvOm+gWj7UQmBIbVKVcB/C2WmlisBlFpTWn11u+YarVvnblFI5daZKB+Uh5WLFPHGL/gVJDi7GL6TdeLFM8Ad33RVzTGVMZjV19KwEPs0m4jj+94nqNneDRAHafmant6AheHWOOvVeQ7U9sEBnSbr4uM/8sjKP0VWomMjuoNKQXW2FiCRyCIb9+kWUYLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CYKzPkUFi6bCbRSOWUJ7f5n1kPCHgrzXk4wS0zSBT0=;
 b=jE8ljNYNjO24vExi06GUfPMju3s+NIDFOk/Zzt5naqeyu55LQ1HIC/i1VNIqRMzYJTguvcyZj0eiwfQrhtD0DUYQCJj9QtmGcyMV9Uh6po5VjA1ellDWgQSQiqZpgLmcSyw2hYRd+jX0NlE6Re9dYPOxqF/hTPR8sU+GI3XNq2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB8PR10MB3749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 09:03:15 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 09:03:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,  Hauke Mehrtens <hauke@hauke-m.de>,
  Andrew Lunn <andrew@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Benny (Ying-Tsan) Weng"
 <yweng@maxlinear.com>
Subject: Re: [PATCH net-next] net: dsa: mxl-gsw1xx: fix SerDes RX polarity
In-Reply-To: <aTDJNvLR9evdCaDl@makrotopia.org> (Daniel Golle's message of
	"Wed, 3 Dec 2025 23:35:18 +0000")
References: <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
	<ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
	<20251203094959.y7pkzo2wdhkajceg@skbuf>
	<aTDJNvLR9evdCaDl@makrotopia.org>
Date: Thu, 04 Dec 2025 10:03:12 +0100
Message-ID: <878qfivctr.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB8PR10MB3749:EE_
X-MS-Office365-Filtering-Correlation-Id: e185138a-e959-4940-c31a-08de3313f58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JkaYedeQthNvK0ZkKWOuCsh7EI1VjblU9lSvPwOBj+VeirMuVnEfqP9KzwJM?=
 =?us-ascii?Q?xLWlSuGAovWeOZiTCkoKSQPAMHXMD1tNdyLAKpemTpT7ekpW7I1f6Y5HIxJf?=
 =?us-ascii?Q?Fo6Mw60expk/o0MCq+DoBBrL+NYel1XIsuoYvGzhJTRgTtGEN+mSnAX1XOAM?=
 =?us-ascii?Q?evlaSbvWH0k8Kd3yuq1YxDHwfv7q0lxX0mDARowB/GiOVEHB/7+rpEDNJys8?=
 =?us-ascii?Q?hjtlD3osRVApqjBkc9zaYko6u5jIVZYcb12kkFPlKPLDdCz2QsPvx0SGFq18?=
 =?us-ascii?Q?Bb7um9tM8AlfSOq45Pn9qDOJu8KkpL4vmD2Cq9EdgL4UV/u8CECVt1jTqugn?=
 =?us-ascii?Q?Hp90L0VQc+akHhOVtBhox9Ud/0pIoYVxuea+A30xEmD3KTaQMytLc1QAKOk7?=
 =?us-ascii?Q?bu4xAqyxbKTOztU9p0CZNqNRBoMtxV0fx5ZMO20EuodjrwX3e105Nt2uASRY?=
 =?us-ascii?Q?KwXXPrc9as43EZ59MWVWD9VF8N3HdShyupsJeLESe73SWqqNQu5XIl1KO4n8?=
 =?us-ascii?Q?kbacom+NMEFUwDMG9naT9jMQOAxlwrY0qs3butAJ2VuCj1cYYufYNilfjV2n?=
 =?us-ascii?Q?IHocQmCpWz+Pzf+tj7ik+zvmd7TkVfLh1KJ8ndlcaOhL9RurO31YRKVQyMNY?=
 =?us-ascii?Q?Gp0sRQHZg8OtyaHhVQYWsg0/caGQEYaHS9ph6r8pO1RFq09Z3+i92q3+5wc1?=
 =?us-ascii?Q?RBYQS63Wfdhd/v0stoHl8ZwZR5mF8QFzDdEfbcvhryS1pxa2ZE71Fdioy0+c?=
 =?us-ascii?Q?rq0GpTwT0CsIyGE0linDUD207SrB5DDHrm3RO/kCyXn8B4ihqcxbmc/3NQZk?=
 =?us-ascii?Q?1uRgw8oWCbpzAIobucxWicmnoi1axJ12Tbbbl4xV7aT3XcM2ZYdgRTQXYHpL?=
 =?us-ascii?Q?KpOoIc9DImLw++aTX3bz9Tzrxddg9jlJgpGEfOmg3Pxrv6hz1oIunb26UljU?=
 =?us-ascii?Q?bAMJ+IsCHMExpacE1lXV4nqX9Jy42Vno1dw/1hCGX+YTv0MTq4lv19f2rdkB?=
 =?us-ascii?Q?H/lxGel8nwCCP/x0jqCVxeHcxvizt8G3pih7DTtApANPQPFNxrCqu9xg1uml?=
 =?us-ascii?Q?ZagfavTKmkieb73mXUL1fH36MR7+l4ucyUiPOrGiYNCnEqH9+pcetuv7ngZw?=
 =?us-ascii?Q?vxXGvbDm4A+hs82Y0C4+ccGlJt9/MiHod0xI93L7ZQn/b7lmUyoG2SGqPr4S?=
 =?us-ascii?Q?cMHYsviyW6i6kG5mBIWZmyaK8c5YpGQ3jgOPa498YUZQX5wq4xLPjXcEtrTP?=
 =?us-ascii?Q?hVqNEEZ5fwGJOECNFdPpH9TaZkzglzSa6zJy0TfVF19S1WVPvG2adWzXwZWo?=
 =?us-ascii?Q?e/QB1VMKHN8kLaW/HifWtr3rn/m5TUNTFpM3HPHaB3zC7Kr8H5SFVQ20aBEX?=
 =?us-ascii?Q?WjlC2pgPtxDa4svTWTggj5VEN82uxDwznXy1WGRRuHkgh7lQYbV8P+92ETeU?=
 =?us-ascii?Q?m0t1s0lfFJ8kTyyHJpDxFAc1sbfdaE4xXS5aathtZXft95QNFXdGgU1GTVyd?=
 =?us-ascii?Q?uqL+YiiptZBeqNZT2o1EHZlj4tK9Qpezx7ed?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YGKWsRJPtoGJD0cx4d8BpYFDikIccHhIxgvefbienI7U/rNNaPuF/b1b1x3U?=
 =?us-ascii?Q?RaSTAWJTwgGjb7TA9+RcT9vhWuEYsg42Bdk/WZWy9eC0BMOF3aixFG9UfeZX?=
 =?us-ascii?Q?T7yAtfMHObOYxZKULcqVOFRkNt9BIzBYxy7xpX5drAwxV5mHaUVPwB1VGqz1?=
 =?us-ascii?Q?u6BMSelKKcBjYgucsdU/VAX9/8gPJnjkIe/woXre+2pZnTbg6r2q3tTucCOn?=
 =?us-ascii?Q?rP4mjWbJFUEK1kphPBL/7q83FF+FGOe1SuNXZmfB3uzOKZxRkUSeFGsOjgSA?=
 =?us-ascii?Q?bgKaTOFzfwvymrvmIBSdwkYMk2CGdY3jriINfuKAiHKRhX5aI1K61PMQ4MRY?=
 =?us-ascii?Q?db5veqZ8vQPl+iWkQxMATM6jZUUSVIFqwfU/YGpYkS8Js9huo6zroGVEdo6/?=
 =?us-ascii?Q?TRU2E7RhqfChVBDf4qCQsbKl702asWHrqUjgr9+z3F7ng0s64+9PpLzHKvGq?=
 =?us-ascii?Q?EaH8F6/QQAgIPHVjWGE6r8HXnSjFt28cvPFC+lj021vs+pQhcF1mrzD/q/Wn?=
 =?us-ascii?Q?Upk9kb9+riUwoXazijD8WNCLloqv2iiJNjp0Gdt8sxp+z5qREY6mzuo7JPDN?=
 =?us-ascii?Q?txe8YTJ7GlSkGpOL6vwdrEKhQhkB86ZV8Fclf/1w3jjdYoIVE8jHqU/RK6bo?=
 =?us-ascii?Q?n5aMaeJ046QMauGz5Kw0cFR2TRjv/ya2SpmWHqN2KVz0NH/bi4A07OzxWOED?=
 =?us-ascii?Q?q5JzSHcTZM5+VjAt9Rcu7mbUdmAeWG+qY6/OHS+3LBD0Cp6S7zgOLUa/L9Xv?=
 =?us-ascii?Q?OdM6xIupL7szfA8HcSrSL057wOngSf92sIkeVNFWjtMJMPaus8Ua9VyQaip6?=
 =?us-ascii?Q?qL2woSfF3o3FqkYkKc09rRyB7T0FgTxNMUjvTRyI+6SLAzdMNQSQn1eNYouj?=
 =?us-ascii?Q?MdhhWNnuXxNdkyp0QFvr/YvH9RiltgpRuhfZ3I/sPHaTTxvGvy6cQIF9H82/?=
 =?us-ascii?Q?uhTyqD4qNWy4PFU2hTjCD6c8ht8lQewjZFaqyEwyOINNlF2wlYXpvxIYEjqE?=
 =?us-ascii?Q?OvmrBiSqG54nHjts8hFV0/faK9BPDGxgDk4hTivmOeLZxaE2RQ4p1HJqkDXx?=
 =?us-ascii?Q?ZK9COtbCBJD86u8oq/NAN2Bc4ID7yH3lztiVleWi1SS+ReeG4vTCbn5Udd5E?=
 =?us-ascii?Q?QJWGTl8RI8YKJ5TICly2abgKPQJ3bNkWr0Mhjb4EYDe/OJMMvwdOa9ry3idZ?=
 =?us-ascii?Q?TAQtqbfJTWZbBzHh7isC/6sdKEvuNgy6xAUazi9kOseL1BHq8H5L64W+pLik?=
 =?us-ascii?Q?mWIUuclscXnnc+Aw+IDyX/V/7z12YaBTlzx9pRoiBRvFeO3hWT/uOyOOCtiN?=
 =?us-ascii?Q?jdhsd6drYGsxxngesRjrYV/fEUmna9EM25XkHKy7i8awk1UpKgUkxAP585QV?=
 =?us-ascii?Q?h0jY14glCfnD10PeSTlVq2eT/EHzYlNTsv2HQPgrlAj2V81F/HVuEbDEZfxM?=
 =?us-ascii?Q?hmeCRPmSxOm9+176hphqE9s8XZPCmoNBMP8sFF8qyS4CP+S9FRLGW0puiwuw?=
 =?us-ascii?Q?KQ7xFaNk/dvOSaR+a6z6WoB/7EdWpMsJiyw/wKXYfcqfln/66ZVKrMWdbSZl?=
 =?us-ascii?Q?lzrFyP6D4H2JNhDVFNPbG1DiadVdGnA51Kz6Utd+Tbc7ENIQy7oreR5jv9pY?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e185138a-e959-4940-c31a-08de3313f58c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:03:15.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqQeK2vrYCZJ6FgQS41+pGa+CZmFu3MWniwWvIrXUGSQQKJCOyRanupbJ449y1e/nex9rWoBHJQyxXjre8PhmxrHm+jiaOR9+FVe9nyfjlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3749

On Wed, Dec 03 2025, Daniel Golle <daniel@makrotopia.org> wrote:

> On Wed, Dec 03, 2025 at 11:49:59AM +0200, Vladimir Oltean wrote:
>> On Tue, Dec 02, 2025 at 09:57:21AM +0000, Daniel Golle wrote:
>> > According to MaxLinear engineer Benny Weng the RX lane of the SerDes
>> > port of the GSW1xx switches is inverted in hardware, and the
>> > SGMII_PHY_RX0_CFG2_INVERT bit is set by default in order to compensate
>> > for that. Hence also set the SGMII_PHY_RX0_CFG2_INVERT bit by default in
>> > gsw1xx_pcs_reset().
>> > 
>> > Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
>> > Reported-by: Rasmus Villemoes <ravi@prevas.dk>
>> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> > ---
>> 
>> This shouldn't impact the generic device tree property work, since as
>> stated there, there won't be any generically imposed default polarity if
>> the device tree property is missing.
>> 
>> We can perhaps use this thread to continue a philosophical debate on how
>> should the device tree deal with this situation of internally inverted
>> polarities (what does PHY_POL_NORMAL mean: the observable behaviour at
>> the external pins, or the hardware IP configuration?). I have more or
>> less the same debate going on with the XPCS polarity as set by
>> nxp_sja1105_sgmii_pma_config().
>
> In this case it is really just a bug in the datasheet, because the
> switch does set the GSW1XX_SGMII_PHY_RX0_CFG2_INVERT bit by default
> after reset, which results in RX polarity to be as expected (ie.
> negative and positive pins as labeled).

Well, that "by default" actually depends. When the switch is strapped
PS_NOWAIT=0, the observed reset value of the register is simply 0, and
the host must do all the configuration, including setting that bit.

I suppose that's also the "hardware" reset value, but then in
PS_NOWAIT=1 mode, the ROM/bootloader code inside the switch sets the
register to 0x053a, which is then from the host's POV effectively the
reset value.

I suppose it ended up like this because they realized they'd
accidentally done the swapping in hardware, but then they could sort-of
fix up that by changing the ROM code, but neglected to update the data
sheet or publish an errata. The data sheet claims a reset value of
0x0532, and doesn't say a word about that hardware quirk.

Aside: Can somebody explain why the data sheet would talk about
"incoming data on rx0_data[19:0]" - how and where does the number 20
come into the picture?

Rasmus

