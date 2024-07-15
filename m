Return-Path: <netdev+bounces-111539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D119317D9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E09B21A7D
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BED53C;
	Mon, 15 Jul 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wx90gagL"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27CBE71
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058421; cv=fail; b=eQM9qyM/wVRliOAOjI4J7ARgvsXAzU5WAtKeb1Gp1hvWgufG1leRya+4GE9ALTULh98D09ynL44y9guqEekwEcwJhyN80FjU5T60dtUHsnTMvze0Ykzs5ArkSijBoJ0TWZokC83fqED8t3pHpfXP06PRlLePOxEbtpSjO8GtTQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058421; c=relaxed/simple;
	bh=N9qVHKyj3xi763OBxai3uJ8y95/0KHE5rbd3DT2HNVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CS+/pklOPqHtc6iuic+5UCkyiW77LieXLI6GyHGeowAFlC8R+0lCu2ycYkPABuyWOYyRU6yZudtQO6lFgLjtGOyLX/DluoZxY/qSkW80I2AAkR1UrKfrq9vEBRkxLQpfxdCXvN+UBCdpv+39jeH5519IfcKzyAF30VOpUAoul2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wx90gagL; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC6V8dIZ7Uh91EH0GhZrYHZ5KP3ql7Wr5S38caqo8osXukyqI36hXoQ1HZpwUxS73D7Y3T4YwxwPVtX1g/w8DB5sJhGWiki8mrWEKvY6FHHyU7Y6rFAMeYVOQbAJZNb7hyBoWPi6ZC+90OxU8nSdv+t9FPeFkTNNqt/1eNG6v8SIiVLmCdbx/6PKrpihNIiskSexxWPux/7wn0BuFc5odmioSjdUeVJZDhPZMD9wryMOV0lLzozzoDzi7W7fdKtdVnz+vgNukHMdXJLAFPYjlLLx0m3srKXkTGM8iM558tmtPCoymHpnQd6U0wFLSIT/ZKHOnBATivAPhi2VTADEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqkNpXnCtseO610YbNPcHHPPN/Aw+F2fxSPow6DfqSo=;
 b=MpWpARQi3AQoaJ8VMf0y2iFiTy5HzxqAS+QRjWJ2XgWXoT1bSLte6wEeYT1WKqdMOjvO6COVrfBKjJW82wRo4/bGhsDg9Exw3LyYfbT+LHjjZFvygjCMIHaku0M0JzUqWvsrq/okdLeqceppibljnEv3zPaMMqoLfISmkADlYtlF0uOMdngFrCuXXCEYRA1KHiePNI3w9mDnyZjk4hW23WFGABFcFs0ebITbPhpUZDinAVyDWt42L1wSnfStPUz6wF/zyoC9eHFA6gwbEmHB2WVc4hRq9qkenwHySfhgjk1wv1Bmmm1Gfx9ibNGdXGAOoYw5PwXMq+P5Sm6pO5VQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqkNpXnCtseO610YbNPcHHPPN/Aw+F2fxSPow6DfqSo=;
 b=Wx90gagLqYLSZCSr+0c5hSlXrtswq2dgW4B8YwCfmPUKh4DrIMccZYx7jhzXSP1IxvHODdCAPvYAx6pA0q64DKyh7FruX5cu0pbjtR4yX8Oid54rz0FIwYcfG0A9Pdehvy566kDkNfIqm++ovS7QVEkYcUS0UZblZeTpIH/gEiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AS8PR04MB8037.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 15:46:57 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Mon, 15 Jul 2024
 15:46:57 +0000
Date: Mon, 15 Jul 2024 18:46:53 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240715154653.kcqcazsndp4nrqqh@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
 <IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240715115807.uc5nbc53rmthdbpu@skbuf>
 <20240715061137.3df01bf2@kernel.org>
 <20240715132253.jd7u3ompexonweoe@skbuf>
 <20240715063931.16bbe350@kernel.org>
 <20240715150543.wvqdfwzes4ptvd4m@skbuf>
 <20240715082600.770c1a89@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715082600.770c1a89@kernel.org>
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
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AS8PR04MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 857977bf-f15d-429f-e229-08dca4e55b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69xWiSX609TJvm1/2nE7I6mfLGa1AXZr50SNALXMbZjRbTzNdyNoTUrlbz3s?=
 =?us-ascii?Q?EVgpznonE8NTG0q4Vsn+PMquksi3FFQd0GjeyiO8KEaHTknh9LNmgw5BXSWH?=
 =?us-ascii?Q?zp1ZziCRXy5VpWqSc2CpOz12WL2KZh1qduDJ0iuB5yRzTz+O4694S7M7W6el?=
 =?us-ascii?Q?xQ5cVXBKdHJa+UUgwnt7opVd96UlaZijQ3fiwOydjrjzigOjxHqPQmvAUY/p?=
 =?us-ascii?Q?j+Xp3OKkFl3besWf9hJqBoI4ey85aScKUaNdfRsOtzHd7cQQpJPv+q5fD8oz?=
 =?us-ascii?Q?bG4Pf8cTnOq66hTDklfd7ElFUh4ldEsuBPbSiM3XDjD/4WrgLYQNn1q+J4Gv?=
 =?us-ascii?Q?SG5bDrzDvWUVGhUXGlnaLj7vpeKuyOJfzqVPLyEsNOxYAl5gTb8SmV6wDd52?=
 =?us-ascii?Q?q/YB4SRwj28RoM4b0bH5m+hwa7hYwHS13QurfmhaK9KRhoUn8Kv+/981uzeg?=
 =?us-ascii?Q?MPNB75cPkbUu35vsbMN+vOCq8GwTlq+iLYKx0ImmsIwWX9botjLo91OHeVx/?=
 =?us-ascii?Q?OMn6/E/b+o5L1WkJhO6o17REvMb+li5nMbuuK169M7nrrN0TXwnxs52eUfC1?=
 =?us-ascii?Q?azykcSvITDgHzIUqztJLNLQ40HL6kAkRn7M4Zxzf+FXuw3IIhxXexSc5/DnE?=
 =?us-ascii?Q?N+dKIwjvL5RIxvxzIEI9v18CQIsoJOzdlHtL2ZQZ7mzRBrAvqyeDzk2E8D12?=
 =?us-ascii?Q?nQxZyinQgHPTYdMORKFQG+5ms1jZgoiXkA7O0L1lB3A95KEi4CYLKW9Lj3wb?=
 =?us-ascii?Q?Zeterp3XTDeTwBFWrnTfL4DJV5ATZQJwAurYCh58H/7hsHjVHWSvIMeTySIG?=
 =?us-ascii?Q?93Ji4L9qaat4stl49CChjARc1iTWM6UxcopY8kXuWAZnUltBWvT4EgGX63OW?=
 =?us-ascii?Q?AjzHHXJO83ytJhWTyT3cHPIjYxmXIgCPIyxwl+Q1PWeaP/SVgKoSvBFksOIQ?=
 =?us-ascii?Q?CXotxWSgBPdbXOxMEMzAPQ+4bJB2DkYWrmU0pcjRtLO85A2fhq1RkSR8sjgV?=
 =?us-ascii?Q?3T6tgnhpSz+flwi5+rDihb6ME2jfzj7Srytzg5TXbnvaSTFifc5f7VZ316Sg?=
 =?us-ascii?Q?3qHh6JIfTHlfnqzLeviiZM46lJRI7z+0JV6uWfylhMXut+ASITPY7Es1kZx0?=
 =?us-ascii?Q?leMB2WhG9pzRvADNsQnTsKeDw7MMhtzOjsd9ulBogKwPoITbuiRem/95IMgp?=
 =?us-ascii?Q?08Wyz0ndgOf8Znt+y2RR5W3QOMsllQJc9M7N4BRvo9vbB96N+DvFRmCkmFvB?=
 =?us-ascii?Q?cTzXppMpecF2L7sbyP1rsiEYbJhts1YoezFRukVxqM1O7XcOnYKHBNze7YCQ?=
 =?us-ascii?Q?Z2780hoDSCp/rc/0aVBaLvbKjwPiT/l4L/fmlQG0JqaHCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWlB62jBOYpvh134tlx4ykVEtiyTpLft+kMkBa5vTXSViIZ5HWvNGL5bEEDI?=
 =?us-ascii?Q?7dynswTKx8YzhhPzc3A3TmyBwUaiIK+/mE3YQ3EBdrZMbWTmwDznjoc4z5pD?=
 =?us-ascii?Q?GEpjVLVtRTv3ghJkpCBqWfuIs28y/MBIXmrSrENdXtOKXkZnvIoQZXAfVopS?=
 =?us-ascii?Q?jAdrUxNR8xOVdq8fj2EkRkAToW5tLflA0gOYOrcsGlV4CLH742GzjlG05KjQ?=
 =?us-ascii?Q?Lry0+6UDuqxg/KQdIvRod5iJAfvntpwz81v8oZ91TaaxSJh93x5OH/ISd79e?=
 =?us-ascii?Q?bhn3qSxCKpDNv6XxSzymuQUmKCEal1sUyoUUmLvKMlOynt/hFpVhBirJZis8?=
 =?us-ascii?Q?v0UT1fJtcApFUM0SzKfAF9rdtdV1178r5DPQVsuUWRwt5fICOhns2ZHRD6eB?=
 =?us-ascii?Q?NjdfS7uLejR1YhUkpkONxujO75lFs80iKP3qCzY9g9OgI5CEuUfm3hFApuuw?=
 =?us-ascii?Q?y4ev2krZQwhZGu8JAhHfAo56fZ0Fyv6r9Q7e6leJ3QQJVruq/bCe+zT46YmG?=
 =?us-ascii?Q?vWhQO5AzoZV2ntAS3aJej3H8QA2nkduvLlq+rSfMVvdXwt5FqBLVK0c27nhZ?=
 =?us-ascii?Q?VJn6FVaMl90UJPXoAzNUxOUkMLaLKW1Or/w4DtkO8nVDgVdp0wLMVIZu1JiN?=
 =?us-ascii?Q?+WODPY8Vvgbw6ZzInTImfgUqI50Cjo4GJYcPw2zwBjEz5A8Cfl3PgJbIZI0S?=
 =?us-ascii?Q?8hRVQ3jXDZnCRuKTYYvUtawOl0ewfeKBWPCbQz1yu7s5DrgKYn+/eNy5y2TT?=
 =?us-ascii?Q?P77yXrSBU4ljb1kupK/j+bpyDB7bFWTzHI/A3jVtuBFWEBukTDxEoZQxLQE2?=
 =?us-ascii?Q?+q1Vl+6k/YqYgPT7ebHcJWhGqR5XTANQ8/cQq/+4PzZY8B3r29q+GJrDICY5?=
 =?us-ascii?Q?e0nv9x0GG+HJ3Dul7fHLvT4v7l1IVdyx9SVgRr3IHL2QNzFwfIU2yAS9pnWL?=
 =?us-ascii?Q?t1RNQBqwyUaeLBEcMFAD4WPk/gw2j2PO1tMQo168TVRHkdurfpW6FY2nb0Es?=
 =?us-ascii?Q?8tgsUXHoGUQWkFitJg6n1Ca+/RfSKf4e76HWSp6J2JwyXkjmXWVnpbIpVTmV?=
 =?us-ascii?Q?bAm9M5rXlAcVVBp5tuulirVXI2PF+3ZVxf0TjKll1hkOwjR8zIQnTfTJ5+ui?=
 =?us-ascii?Q?RolbrfEVzUhrbXyqPPfBE+ZAxLTD9jgu7oG4+7PPM6fWLCijY7KzFsBwKS7O?=
 =?us-ascii?Q?c3b+qZbZQXTN1SfEXbTVmnHwNOoSwLxQW0LMzb+eBM2iHmKHEpzk9Ej1K1Im?=
 =?us-ascii?Q?MQknRDtSAullK0QqEzWbtHBtw9Y+QqquytgJl7OfiY/4bsbjGbhTT2Nrf9mi?=
 =?us-ascii?Q?z4X2dnCkBRjfUYt/iumGdvtaCyzt9RlkpHC5VlU6VXUSBG1fYAVTBMmX+cDh?=
 =?us-ascii?Q?8hNHB7yJdPd5i/01JBki4UI4BMq9yHPs//COP4t84sW0sBrSvktUEkZFmDjF?=
 =?us-ascii?Q?sU2Ds9RVQMiLJrXiAVAjRhhcrvPu5Aqt+D2wcKMbiRwKSCdB2EMHlr1mo0Ys?=
 =?us-ascii?Q?fRVJTrRy7EDoJcptfa6jrvr4Bt25V0f1TFq1lNbMgf+lAM8gFVht8AZwCsTo?=
 =?us-ascii?Q?Io4hMHSBtXgz6dfiCzDKLgiupjJKD6137tlt0j8l1LuWUd0u+yrOgtrAFhKG?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857977bf-f15d-429f-e229-08dca4e55b7e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 15:46:57.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPjIblDUIOQuw1Wd7jLr8K3f2gmOOQjZPwifKdA9On8Id5fIBIyZ2boXCXiJpKhzxktKGWaFwbQlNP4SONgDVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8037

On Mon, Jul 15, 2024 at 08:26:00AM -0700, Jakub Kicinski wrote:
> The information about rings can be computed based on channels as
> currently used by drivers.
(...)
> 
> They can provide a different number? Which number is the user
> supposed to trust? Out of the 4 APIs we have? Or the NIC has
> a different ring count depending on the API?

To stay on point on GRXRINGS vs GCHANNELS, "man ethtool" does say
"A channel is an IRQ and the set of queues that can trigger that IRQ."
Doesn't sound either (a) identical or (b) that you can recover the # of
rings from the # of channels, unless you make an assumption about how
they are distributed to IRQs...

> > > I could be wrong, but that's what I meant by "historic coincidence".  
> > 
> > And the fact that ethtool --show-rxfh uses GCHANNELS when the kernel is
> > compiled with CONFIG_ETHTOOL_NETLINK support, but GRXRINGS when it isn't,
> > helps de-blur the lines how?
> 
> IDK what you mean, given the slice of my message you're responding to.

Not connected to that particular sentence, it's just a comment about the
lack of consistency implied by your proposal, placed at the end of your
quoted email.

> > I can't avoid the feeling that introducing GCHANNELS into the mix is
> > what is revisionist :( I hope I'm not missing something.
> 
> You are missing the fact that other parts of the stack use different
> APIs. Why does RXFH need its own way of reading queue count if we have
> channels and rx queue count in rtnl?

Maybe if introduced today, it wouldn't have to, but the more relevant
question for my situation here is "why change it?"

I only expressed my dislike of a netlink/no netlink inconsistency
because your question was seemingly addressed to me. Luckily I am not
the one who needs to make that decision and I will gladly test out any
patch that fixes the regression.

