Return-Path: <netdev+bounces-96936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A718C84B1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45D71C22922
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B38B35280;
	Fri, 17 May 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDBaXX62"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CC3A1AB;
	Fri, 17 May 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941396; cv=fail; b=lgNJtCF2FYOoMIouUGa5OiMsLg5ooFKSQu6ma8rkLdGHFLTecjy+V1Ih03i80T+L8DeVsv402RsjjiPCE5zXHS/o3nY8J6ZjGc+LSU8gvXwiImJqKkGa3R7hMtCwXbTo6WJKiwy4I56RiCUu4+DBVxjX+h8mgGTNGP8/OOr0PV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941396; c=relaxed/simple;
	bh=UUwT+yA6AG+t65iZUFDA3kycWLg9C+vVUPKjjxh8fhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HF5bRaTziakxyFzg5pikCVC8jWJF1Xg58RjtywDklzgOrYGPbEx8nDEk6/bcUtQ19fpDJWLSqXMuKqMGN4SWkrTDYubPNhzrLKSTDnbZbIg9hFUHM5mmAGDRVFCrx2DhBJKvhyCxkUHvsVaRpUD03ePPfACjxukk6OtWKz1ARRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WDBaXX62; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zonf2Kkd79oL6iB1gJ6uZlXDVtsMw8oS7UAhHTfBaNuvaXoXDiqwEDffI+0kjH/h61yd2RCmJWpI5jHE3UefHLryJgn4AwZY6467Uj9ElP3hJFNKh//0Rk8LrOHhXIW5WgsYPVCeo4IXxGPNvZKPOvQ5NrWLZPwnNhJpLWFPUMdMk5Ovk23DLErpY1WLC4RsNU4q9hLRmq1MGBryoQav1JzWtIAFYwW81OMO2eW/jihkWcpFwmt6pX8DuLUS9ZdmeNkd62aoXCTcXrpTMLMFfjmdgLmVyGL3y5d6SfCnEmb+fWleAE8kW3U38fZOUmnpGVDfMTM6sTvtIA7yirqYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjo/fUcg5KjlEdOh8m5tryC4RCNfN3lXO7kjC8cicO8=;
 b=mvVWOljdDQqYQEuzQ9RACRroSuGtHODNvgenYtNdIZnuZJ+gzaeM/kUMB+CzRc9m8kpdgBBsdhaKBNxLmSS4N1CrHrl+xUKbg9Tju7HdScSC8Crj9ZNAoit1mCnG3gvmovD3LogPv8whcIFFfdSjAaMmspjoW08F9A31dDwHA4qfwgRgS2ha3QoEW/7Mu9X9inkNwMkPNhjsTi8vMiYMlMYdd+9kDn4n0eyoUYt0qReI1oRfX+88tK8Dw5emzRHbEvw1cGjBVs4ycfdcrzOSJmAfU2ASkaKhT9qqacx5Mbgpd2Xl9wEBzQvnN2Gx5VrcpkboDKnkHt5WO6cArQuYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjo/fUcg5KjlEdOh8m5tryC4RCNfN3lXO7kjC8cicO8=;
 b=WDBaXX62itvOWKPLpc0fcNoff/DSHuvs5tnHaFNLjmesdTnBrDjfIFb7I/VBJ6JFzgYEpkXSBuh5PAt5gdKc4Jby1bCYC8iNUJt/zyikdUuX9DKq/tSgAdkjP7o2+T7dMR26XzaDajx6Vg543RrNLVKQkpCRSYG4d06Gnb+hLjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 17 May
 2024 10:23:11 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87%3]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 10:23:10 +0000
Date: Fri, 17 May 2024 13:23:07 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: lan966x: Remove ptp traps in case the ptp is
 not enabled.
Message-ID: <20240517102307.7we5psrgbf56mden@skbuf>
References: <20240514193500.577403-1-horatiu.vultur@microchip.com>
 <20240514222149.mhwtp3kduebb4zzs@skbuf>
 <20240516064855.ne6uf3xanns4hh2o@DEN-DL-M31836.microchip.com>
 <20240517100425.l5ddxbuyxbgx42ti@skbuf>
 <20240517101811.vsqcg7moapixlfpj@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517101811.vsqcg7moapixlfpj@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: VI1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:803:14::45) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: af451ed2-83ec-448a-a0e4-08dc765b5a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bXeMJi92PrP/nfw/xiqc2Z0ODSQMETFX2EQQ2MTxivqn0MLnrLemS1j9Vd5O?=
 =?us-ascii?Q?WDxCdZvDxgTPRYAHjjdJtcnfLWaMf5Yb9MIkEVZLTmAD/rZcTSMytYQzuvdO?=
 =?us-ascii?Q?siEI2fOJednNZce8Uc8O5zRAGDGNfKuV08TV/kFem3LsARhMlRWYKj4baYM1?=
 =?us-ascii?Q?lzOZY2vtz/zfS9CfQQt8qsdmv0Q+Fylpy9DOg+ij5jg36Aj1q6OpIxcpSSWr?=
 =?us-ascii?Q?8B++oknSoixUgoCiRmE7LEbkdr71VqndpDFMrQZV733PH1gyKmc5xKSyvtaY?=
 =?us-ascii?Q?nh8An6tch01iC5kExvfz1Z465XS8RnWXMHnwll4RBE53ECJntgFVUoOTM0NE?=
 =?us-ascii?Q?0hKgwkmbh3wwaoR8zMU9GwIJVl/TebhL14IfwPrWmHGTghOo/2wsontuRCsd?=
 =?us-ascii?Q?GdNaYFGFfHUTmfC9KGI4pQrT1nyT1uiyJHbkctT+RMq5yk8Px6JcG0BC5NCe?=
 =?us-ascii?Q?jUccQezVbkUERlGbkAHWpDngE55J8sZLtg1KVKpxuyjg0/HFvPoh1RvzcnTH?=
 =?us-ascii?Q?tfw5YtGXkTWVBQomBpbaUAhwMQvM0xpyvTvVNnvCGvdsWhMKwgu+XwVJsIYy?=
 =?us-ascii?Q?b9fkB8k9ci2VwH/jyQHAkdixgqS9W2xQ7g9CrPB5F8zJqGFTgHzpVHsROvKN?=
 =?us-ascii?Q?L0xjsf0S8zun5bFLj0e3sW7D+Iy3OGDqp5nV4pi1xw6X5gzpSWqrhRP1lMBS?=
 =?us-ascii?Q?3/k6f8AJzkdXj3VEekyDopum7r4DlTdnjscoho/eE/+231Vy9+b+f8BPf6gH?=
 =?us-ascii?Q?ugCmGhgWK6ie5GQKWU66+GGJETvULeis30b3JQUb29BE9hsQeEokzwdr4y0q?=
 =?us-ascii?Q?DW+CvuLDxTVxQGpyqsaK4aDOJTA4ZMyUx9XK+hK9YuHgzfibGgVBzCjAfVxp?=
 =?us-ascii?Q?9EUIadJs4lN2v9WOMDQMEmpFTeoZzjCChSndoWi5e9+c0vbk+dA1kd1F0woK?=
 =?us-ascii?Q?kEchj1Me8KAgkXMI16d12ZXtTuhIzQaeMmw8Ab8dwsrzdQeE0xmK/xs0uXkC?=
 =?us-ascii?Q?C1fKQVLSw6oeQSx5wJcYdihDp6qSk0RGwBoEexGEqiqJFQ5B7b+bQMGvJsEw?=
 =?us-ascii?Q?tV3GLSP4iT0hcT5Wu3Xc9xZ+rreJkR0w2G6vAuDGMBEcbotaBpzbmt7T1JrJ?=
 =?us-ascii?Q?iu28fj2srsEDoX5d6dIBW7mbrge97yfcI8kD30cROGmF8yOj0f9j3LDkvGi9?=
 =?us-ascii?Q?k8hFvir4AZjBcC+csX2wkISFq+W84/xmgL56X3b6O3j1YiZdD0XUzeMAbaef?=
 =?us-ascii?Q?OCXRBge3oGYVFcdMqUNlrPW8x8UcT0EnApRT1LPr/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IduCMwFrPAwbWHYy+3VxWdrlkG9ZfE7/Eqm0oFzuafFCFxwVVU6H2xgRtmAB?=
 =?us-ascii?Q?1l2e1+IebAeCJFVrOKVlUL3ychEQ9jm99gWGe+IFGclm5ku/cvt/4jHT4Mib?=
 =?us-ascii?Q?6O5Ex1pT+lQUKp140n8bMKUva+/yNfrSbnBYpozzSgzf3nD2sxqwfbUNIT5g?=
 =?us-ascii?Q?j89J7QW0alJ21s/bqJzz+Mg7U6khYOd7Ahmn2LXZk2nKB9JaMvYGUiIRD2+4?=
 =?us-ascii?Q?UochIVsPsn03HPDEVH57iTDMEtqQ2cWmCjo2WpqS2BX+haPcw3mo9KcNfN5B?=
 =?us-ascii?Q?5Wn0at1c0Xk9mN5Yw3R915LqvqcbLDChiMYCZR5vFQqhDZfCVBGGeDOdTHGO?=
 =?us-ascii?Q?1v7OJBzAjezCFatJJaKpxjGULbS0CialdC1QZzgb32+RxbFZt57xbDcTyENf?=
 =?us-ascii?Q?NLC809KtWTrvwPz19ozNZhtrq4N42pwsSTQ1OHs86auh7lgKXOqCV7qJsfJ0?=
 =?us-ascii?Q?b4knH0M2qgS0NqTqp9YnU0tlGN+pHCgL9T5D6IYHXJCT076RWs2MUatXIzXs?=
 =?us-ascii?Q?3xahXFNIkFFWSYT9gVPmqiYr2sHRvPN3DTc/Q/7pBFKV63ER6bYFWKE+Xvh3?=
 =?us-ascii?Q?HxNdMLarXvr/NrwMx3A9DFIqtxoQ816j6nh8y6eEYdrKarda1YkML7+r7NFn?=
 =?us-ascii?Q?DOnuF1HhTaZSsisJJip7CqvaRoGIua5NuifkKAepuo+sQe1kyz5/c1tNfu8+?=
 =?us-ascii?Q?AkewVQNjATfqkEyyFCjWlEWY1QjkI3BZeTJTO1I3dRiKgY0eHfC3726NfaEi?=
 =?us-ascii?Q?utm/SrNRVt6QQwGxOXJd/wgL8elkMGLpy0NXKObWEsuf50kN07meF4jQ2kRo?=
 =?us-ascii?Q?TrmsNHKzZIaBfnv79Sm1YAJYraluZZwgaM78MsTDJscE38pfM5KO32MUAUFg?=
 =?us-ascii?Q?Ik5gXtAkaiKyjQbT9HBZtb+moJ19bIck5xhomd73HlLnuHO5Hltj8qOLWvhZ?=
 =?us-ascii?Q?A30HpWaiCN/meAETQKcYyK3UbNcHDgko5ItEK8cP8XlDmBvavQjGiaq0Vujg?=
 =?us-ascii?Q?yU77/NWm2hQJ8WENfnwfFPa3CwOFvqMriB5QoBRRPiG1oNSAcOSAcJJWoqi3?=
 =?us-ascii?Q?iBbIeKR1zuFtfEnXKAgZTegA/Jd+ue9BqA0dq2BnWrvtP8PWiKNKh3cbFUE3?=
 =?us-ascii?Q?55t7/iJejWsOmguo8VgVDe9Ol/P+gL99s5KP9e70uTNb1BTGkMcjO8vABm1V?=
 =?us-ascii?Q?HdaU7mbJD6a9Le04U6wTwfpFFbD+Y0X5G+c3i0RSAf2ZGsT1/mHJvB4ioWaO?=
 =?us-ascii?Q?GASCJKaZKrkrtsf9PWkWXgpOXNxkQcw+OHN/4Rv6umcG2di8NEuWd5CT1a9F?=
 =?us-ascii?Q?BqVj8Tt9khoFCjZs0WTkAKodUlIkIua7xX4U4T4jLd8y5WSqvnK2daFHbDLk?=
 =?us-ascii?Q?KLAeyQqG/WwpwGqa9eQCjm79/MF+32/XFFDG3u/iIeQKsjcTqXi3kuluGQtc?=
 =?us-ascii?Q?A44RIJwNZFMhGWHhme3Jqg7MWAN/q7roXU1Zfx+hgBoXJSRjv1kgeMq6BDah?=
 =?us-ascii?Q?r1nEtOdpVwimbxvUayqAOBDPzgOEpic44QX1g26smCIHrwmmR1uBcQqTArr9?=
 =?us-ascii?Q?5ZQ61cN09XUs8mohB9YatHo1OR1wJcVCVJdPrd/aR8dWO/0BoFAPTmuNwqsS?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af451ed2-83ec-448a-a0e4-08dc765b5a22
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 10:23:10.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzxiOubDommI0lq05iKZrLTkHNUkeONi6wvtf7DfaW/L/pkRk3vfGOuR7JbXwwUIE/8m37l9/wEVpqC8cpYkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

On Fri, May 17, 2024 at 12:18:11PM +0200, Horatiu Vultur wrote:
> The 05/17/2024 13:04, Vladimir Oltean wrote:
> > 
> > On Thu, May 16, 2024 at 08:48:55AM +0200, Horatiu Vultur wrote:
> > > > Alternatively, the -EOPNOTSUPP check could be moved before programming
> > > > the traps in the first place.
> > >
> > > Thanks for the review.
> > > Actually I don't think this alternative will work. In case of PHY
> > > timestamping, we would still like to add those rules regardless if
> > > ptp is enabled on lan966x.
> > >
> > > >
> > > > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > >
> > > --
> > > /Horatiu
> > 
> > I don't understand why this would not have worked?
> > 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index b12d3b8a64fd..1439a36e8394 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -474,14 +474,14 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
> >             cfg->source != HWTSTAMP_SOURCE_PHYLIB)
> >                 return -EOPNOTSUPP;
> > 
> > +       if (cfg->source == HWTSTAMP_SOURCE_NETDEV && !port->lan966x->ptp)
> > +               return -EOPNOTSUPP;
> > +
> 
> This should also work.
> Initially I thought you wanted to have only the check for
> port->lan966x->ptp here. And that is why I said it would not work.

Ok. I see the patch was marked as "changes requested". I think the
second alternative would be better anyway, because a requested
configuration which cannot be supported will be rejected outright,
rather than doing some stuff, figuring out it cannot be done, then
undoing what was done. Would you mind sending a v2 like this?

