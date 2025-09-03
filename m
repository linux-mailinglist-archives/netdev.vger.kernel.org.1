Return-Path: <netdev+bounces-219673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED46B4295B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681C71BC1B25
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A52C2AA2;
	Wed,  3 Sep 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P7DQKmq5"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5E198A11;
	Wed,  3 Sep 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926115; cv=fail; b=MDCJC+GOHNmqDmfdhDukfF27P+eVXSaPAW+C4y/9ZRX745+5sH2V8sB5ClGEFOo+SuxL0l/jB/CKJbFCGsqv8lWjs8X4E16QUF3KQnTN+qrbJ4EdTDP2+C9ns8OVp2vo5gxVmeNfA7HJoPF0atZKMgxGCgkzAD1+umjChL4Hy/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926115; c=relaxed/simple;
	bh=6wD+42SvnGl0P0LJJNbkaGx+kuPFVH2l8R/lUYdmYu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3+BHKF9VDi9itZAzg5rhUX0HQ5PXdN816aF9K+dXpLWpaN8Wa+uKTbFyXt9eqNKe7m3ufXs2gWE8Yg+p5ku9bnlQdqKMZhp0PqYzOV2oVfzI6KzA9vWBpJ9e+7UDBRe+O08ppoKIax6ZchCZ/RHrj0JcAcEilS9VU4exC3K6Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P7DQKmq5; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tuo2v+XvoAvqZhWmAABbtitkI8aMpkBOEmgp+HPNd9FkFZGdkR0cBIcaEhtAbgrenBznQaFnjVf4QuQmNAA7vsNF8U2GhbhBLO6xnzPmYezgm2SxZl7IVwGL0XIETxfQn5USfStLmvYViMhDgNBkM4ILlMbVwdS/RqfHFOgZySHNVtcc6oG4/hKyxRa9wEo/7C5a8/xwIbXLhFXccTPU5d1akDMumz13qfP+4oDfBMzReL6pNaQrUdLVuG9eBcZ/VCGQ2hHjj4B+ROa7Ot8Mz1EMmZxwd7fRJnl/m4SB2ueiDJ9mImtJ6JI1Jsq3Pl+eYKEzauMmMsyS7gLA6iMb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EnGWYHkjdNl4wgt0sCF0q1MoKOQF9k4SgvEfCWF05s=;
 b=e2BamB4fVorsDJz1VLQZPYfZv2h4EIK+FTFdaoumdUTjyA53wXK5SvwrHn7k8VUs7ZtMGcJlHVUfY5pfp0PqdRMiW/afwdKRFWMDN+fqIUxaMLBGYGJdNc6INYUl1ISYIu7CVTi009eBVWc32SiLti5uAMaWRW0F7ucQZM/SnnkOl/Wx1huchaLArDqxgyS3iIUIWX4bmJTvPLkpZeR+jlRlcXgv5+dz1c6r+vaPWKdzhRlE+hZ6Vpwj91qxwQ9ikNiBharCHAo1OiiCnpK9uayAaYDUr9I6/4HBpI9zi2cXZZv6Rch00DpJjTNb4lySUCGKl9zhf+r2meiEsTCC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EnGWYHkjdNl4wgt0sCF0q1MoKOQF9k4SgvEfCWF05s=;
 b=P7DQKmq5c/qGG8laLJumNJy4lrzxmzfexgG6FA3a2rkck5gn1vbz7KlFhM5DSCr29cuikToyOY7LkVlYrGjjHfEkx9dWcynK+i2S0JXy1VryZ9E4TAUaJiydgChEUGVgiO32ULIQroQzQrunicou8oICyftFbNQowAcNt5//bsxWJ+hgH+8sOCdlb5GM1mXY8AhRKFy4m3udBfLT2nuiaVKhtwooP8N3snTbRUzeHSqrSIsNRSBFOJVT7GBIOfrs5APBkFoGSWPwVUnZaj0ee5IFidi+G62Qu/vTDU+vY7Hz+A3U7MG6h1t7IUEAkgzI0Ucc5ILHmsGjzhSQbPf1wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 19:01:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 19:01:48 +0000
Date: Wed, 3 Sep 2025 22:01:45 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <20250903190145.n7su27upz2avqcm5@skbuf>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
 <20250903184858.GF361157@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903184858.GF361157@horms.kernel.org>
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb309bc-c9e0-4857-e579-08ddeb1c5574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WgaEKo5IZ9dMwdBAT7RFyXiVz0c+oPqoF36AWHtz1id0geix8dLwM8kdlgKs?=
 =?us-ascii?Q?lr83Qobd3yTUm3q8wS4yNqnyact8Jf+wuyTLV6vRtS5Q9dV6dRE2PCrfYvxU?=
 =?us-ascii?Q?IPB0F6f8FOb9ut7rqcmEq0yVJNXKOna8Qh/jP3CGktQY/n0bvkHBHEjI7sx/?=
 =?us-ascii?Q?1pWFfcLxdjQJ/e6JkFcKMjAG5j4QEWnH7xdFMe2FBjsMDjWX/o/wYzRW2TNo?=
 =?us-ascii?Q?HHQIHiDa31Tq72UgDp8W5QPaPL9qy6LMs9nX95L+6BQmKl4pvY9EC5SDtKKn?=
 =?us-ascii?Q?N1YHCsf9nQILukPx7kovPAb4WCrLAMB6FK9VqbRahdBzwzTwQdd2nM7FxNLA?=
 =?us-ascii?Q?Q2YhJLGKUlpJlbPiQKa4Xnbfo+KgFTCjn17vQEVRGNGlpIODa4B6c0mDOSYH?=
 =?us-ascii?Q?V0UIUqMxvSI1EFLDDXDooCO5eCDyu/sdGnriUjlopnnVyFZORlHG++gekvSH?=
 =?us-ascii?Q?5m/NF5jCcJBAF4hi7uA2E60n6i9CXsN/FVXjc7i88dITIGrU96jvsiGWdNEI?=
 =?us-ascii?Q?f2Y+014Shy+WLVfOHDtW/8iChnZSle1X5buA8y83lr06qxwX5ecbUywKb9BA?=
 =?us-ascii?Q?iTbvQVXLEPAKFp3XQB/K0j2IixbjU9+edNwJHuLuEgfAUs8WR4oVDAhmkZlp?=
 =?us-ascii?Q?iwsVZTuGo4OT5tXt5N9l0B5T5H7wm2Uz94rDnf+8udgVGKFpWSp03usK2y7V?=
 =?us-ascii?Q?mfEy8is9eBt0EfdbP8x5Kzqhuc3gpvRuTD1T30FzrpSi4TOBNCiR/90loe77?=
 =?us-ascii?Q?Z+iCfRjm+HaUXPs3mh3m3In9w53d4jLbwpZuGiLGy+KUO3FFfGqqMykh0uk7?=
 =?us-ascii?Q?uMj2vG3SP+d68x27+2FvIt2l58VFYbyaPOGnNtXflFIuxnCbVEZ5UL9GSEcO?=
 =?us-ascii?Q?j5LEZbAXxXbXjnw+BE9eAEuX0V4GFjfLrwDNaFp6lEP1PXp+MwLa3JJu5pXT?=
 =?us-ascii?Q?z/Ip70m46L9/ABoPhTvhcmbTZ3J9gCMh6YDMvUWEROxk5tCIqAbrIasw6Wmz?=
 =?us-ascii?Q?cQCteLqu0NVCyzGzkzr1K/LyiTqIfAIdbILStw2MmweKqG+6+km9M2svJvlv?=
 =?us-ascii?Q?HjMULQw9PJvVNPd1PTuB67fnSGia9/POI2CHvkAoKTtiP5FhAnNFhPwl7tig?=
 =?us-ascii?Q?0WeP6+bjb3bTAkuxqLKbDIOxTIkILkGAA7Pshfq6ys0n1aD+R6muT1wnYW0k?=
 =?us-ascii?Q?1IKqiP3UzogKEHwe/EtpNiJPybUK7/zz82EFZ3MzkFHfsP7xYDhdqUKclNEt?=
 =?us-ascii?Q?Gyo2LTR/GB4CpNmXDDiOyu7U9y6MrGfo33Ng7Zn0EvdQoUE3z2Pw9smJ7cQ/?=
 =?us-ascii?Q?HXjwAKyKY/L8cBqk2oBOdh2/yBXo0vTL7K/MAV88QXEIK93YQiALNGGa6P0o?=
 =?us-ascii?Q?/HbOlO7LA8F/JGYo2IxFnyUYWSbTXiLnJ3aVzpJdipChwdK9Uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vM5eu+QlWvX/HbRQbeHAQwfOYBUy6NQ0WxUV7WtZ67j2PYaH4S/U+Bhrp9uJ?=
 =?us-ascii?Q?+KFPRij8Df58Ku7C30thDKxDRm7shLAcoKcUUCS1Ypvw9fGlQKP3J0MBILlF?=
 =?us-ascii?Q?ctE5Hf3itDzQWgyMuRJouGhGE4fVPPzA5wthF2jToGg2cP5YneepxMnKbWTk?=
 =?us-ascii?Q?NSYDpEfaRV+on4+nWsZMpODXzCaER8O4szcqlJsqFa8pE4KdY9Vvr2rjkJnn?=
 =?us-ascii?Q?9R2Ei3tJu6Kaow963FDawsYR1aFloWKfqeu9a/SJXxs4JFKpKjauWOwIZzuk?=
 =?us-ascii?Q?5uEwFsit1OkFot6u8tzsWFf8/uWquxwgBJ+ODhyTdNlGuZRVtLpVjuSBV/e/?=
 =?us-ascii?Q?1nfYXJ3pUznLowS3iSEmcJ+thyjAqg/3V0aE9FB6CBCNJyyZ8Pz3ylwSksMC?=
 =?us-ascii?Q?enAHxZ9Q5zhP8p+NRDBnkQfNG9LLW1LYdsBDuuAoV60JHf5UIYFMG6rBLRU8?=
 =?us-ascii?Q?/dmWatrjn9Tp9Y3RX6AWnHREuvdy/Z79x3v8qsj0eCPU1xZsgvL9XwOtDh4H?=
 =?us-ascii?Q?5Ww6SDvzQnJ6YIw1jxmyboT0cuxWT/MbQTDTBzT2htJfb3lcJFPGa9RTKxqm?=
 =?us-ascii?Q?b/widuF9iGljpuib3coFKf8LJdzgt0/dYeXu/ERUIkO1B7SMcMs6Fbt16uCh?=
 =?us-ascii?Q?2qtR8E7pvN2cpjM8N+RArF5ZGSP5tk+aFqu0Fb+Rlnxe7bdv6RPFsUkh5Bqk?=
 =?us-ascii?Q?kc8hClLDzVdayug6HZiIGlsZMReXphDU+/RB8aLmPtmtzzJ28BI6PFExj/fL?=
 =?us-ascii?Q?w/V79AgdQ6TmhoLrDjrf69MMoWU6kZ9BqT+j3OIjeZDn6Eopk9DD+8A+MwsB?=
 =?us-ascii?Q?AfxaZTLuAOq3n/G+NteLn2inKwYblQsphYNCa65zMOFWHxaVZD9WU7BI0k1k?=
 =?us-ascii?Q?DDiM7mvrTaKRVteTBzwzWDh+IB9Na4AHizvg53bwQ0zxuYp5YjywTpNUPyTI?=
 =?us-ascii?Q?wMZyo7kyl55UpuzHSRw6RMPPot1Tq+fzoSgc+9LfcNP4csm09lzKO5iGSFVs?=
 =?us-ascii?Q?rQ8NoRaR7DTisql/apK5lPJo6IjYwZlzTE9wZ8XO2H8ojLPx8SFUGwRaSRQc?=
 =?us-ascii?Q?F2K/XU1EziffkOO6Tje1kw3ScHjTjAGuIrrqSuTNO8cloqSQuEaKJ83Z8qdG?=
 =?us-ascii?Q?VUuP589FhMOQi0+Fr51RqjBGDYjtNaBewwmEAnDUhVCpfKtEs5/1GW1dft4K?=
 =?us-ascii?Q?IrMa7/hqWLfflnlvGQWVnSN5v4POtQeJkcp7c2hjRYmJU/nsCmLxlMF3LLo0?=
 =?us-ascii?Q?nZ0vl9mIrP0vs9Sj86fPeZPN3Swq3orMTP8XtLU0iU6Wo3AXfwNw/oWGQWLj?=
 =?us-ascii?Q?iI624FVA4AUuuxZPD+Msjv3fXiK6ISDNUmf0wCS7/fqmsdWC8aoQ4WCvoq8v?=
 =?us-ascii?Q?KSc7slkW4U/b64dxZS/pcLYVT4N1vzXShMsyGxLVTiDF5856HauOoWzYRxsp?=
 =?us-ascii?Q?K4MalH62xiqKPjG7aH87FCzeH7ZFQLfFPdN0TKCdWrlVso8sKpe3XqkLOHqn?=
 =?us-ascii?Q?g/58Rk3B9rTqE0o4v3tIZaBRkEfTxuOVg1D+JHIMVS3JkvzxFwr1ydIIgJ0J?=
 =?us-ascii?Q?VPL864FCnaAiyZtSW7K5Q1iFMVdFl+6rckBCtf6kNLhkmPUcIgMOcRZXl/Z7?=
 =?us-ascii?Q?lEKZQosBru/PZJHkjqxQKPb6KGJH7r2mOcDDPMSaLcTasqt2MzwOVxqx5liL?=
 =?us-ascii?Q?8kCKkg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb309bc-c9e0-4857-e579-08ddeb1c5574
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 19:01:48.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUqOIYc8no6Ep7hqn9zPhn5npyK86a0Fk5atGYXWE2LOpp6FO4O8cNBo4V2b9KT16hGoDxFmZ1PPeXosm937Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

On Wed, Sep 03, 2025 at 07:48:58PM +0100, Simon Horman wrote:
> On Wed, Sep 03, 2025 at 06:23:47PM +0300, Vladimir Oltean wrote:
> > @@ -1582,8 +1584,11 @@ static void phylink_resolve(struct work_struct *w)
> >  	struct phylink_link_state link_state;
> >  	bool mac_config = false;
> >  	bool retrigger = false;
> > +	struct phy_device *phy;
> >  	bool cur_link_state;
> >  
> > +	mutex_lock(&pl->phy_lock);
> > +	phy = pl->phydev;
> 
> Hi Vladimir,
> 
> I guess this is an artifact of the development of this patchset.
> Whatever the case, phy is set but otherwise unused in this function.
> 
> This makes CI lightup like a Christmas tree.
> And it's a bit too early in the year for that.

Thanks for letting me know. It's an artifact of moving patch 1 in front
of 2, and I'll address this for the next revision.

I downgraded to a slower computer for kernel compilation, and even
though I did compile patch by patch this submission, I had to stop
building with W=1 C=1 for some unrelated bisect and I forgot to turn
them back on.

I don't have a great solution to this, except I'll try next time to set
up a separate 'git worktree' for noisy stuff like bisection, and try to
keep the net-next environment separate and always with build warnings
and debug options enabled.

