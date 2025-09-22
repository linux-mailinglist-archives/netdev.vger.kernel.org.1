Return-Path: <netdev+bounces-225238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091FB904D4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4C317E6F4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07C27F72C;
	Mon, 22 Sep 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UcVKysb4"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30EB23D7E0
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539248; cv=fail; b=LOZm1m6EDX0FxYpnZ9M/vknuXwDXngM6X5WJP4iQrPvJLnYONpZVjJknPmvwn6/K4tiG1NlTni2vmNdTneKN7sygfQvw2H8+eQB3Y0rqzX3dt1CmYDSBG07QOEM8NWZGfmKW5UHdUgSHuFULmRhhfhsPfyoZhrq9RyCPaW3wkTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539248; c=relaxed/simple;
	bh=3Rs+xTMMNNitrHuo0k1t+LZE/rZtBAc88vX42Ya37c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9mTuYu39jmkOwFckgUV8T4WpnU5BQmTPjjFQRVjLu1bq2FSuubnfsOOygEN+Ww2MwDdvFLcBrxdlzq/dxGzebVTYsf0KleKL8mX8N9orQve0WlcmLuU3sNuAwbw9nWf0hQm/qumCr98sid9+DezJ/7q4KsWayfpOd6Zc9I83WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UcVKysb4; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idmqmNIkJ70rfsa6Fwi65WzUCz6GEKssGuF/wHkbp9+45UKjlM8sqid27ikxDKmgZfm05Ae0sUUXGVy4GJYVfLFGxumXVFtTKU96Sox/RACYt5ekhqwmf3vTened34xoojzfCpGWUm+Fhxm/5gcEGC3WUDU+8lA3tuBAbshDO6BsAgoG5+UhE3+0FaEOlvZ0SF0HQLrgZX3KZuc3vyEvTGBo7qxXPKFenos7Ibs9df52svQWqtdcq48qQ+SdmIPx7kHEDMWaLTPza+L7i+0OCA8HwoN66TV7sBVhKF17NNkce66Rh8KnFLlR1ShdpuURyidvU8iHXnMNcVxlBWHBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5usA83acj8gVPB8Inw3SDBNV9hrg68rhHJSOn87ViOo=;
 b=EUZMYi4RsiMNcHxuxeL3br/2fucswPVGqTVTaKmX3hlJvXsTL+THItwfo9KN5QjiuJzb2iOe57YWLUBDknKt+ErEw0p6hzu2oc3Q1OLGqdQ0lXECybVg8t+rZwz/2KGdLayW2gbbbFst6kiguGHf7huQn3JhhGKp7V1xKpGis2Wo4unzaovZ4yA35Y+5YHl0xUX9/z5C4ng0vC6ySdXt/udSw82xfhGirsEkS+UGV5IF9rF4INqpt8MVccdo2VXWGdaAqHIAERs9dMhnHSRFVkUUDGVWo9MX7ym6rlmJUAAZ5uQqw83ZEYHu7GIZUmlmRSVbcZqvM+53LphzOt8G+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5usA83acj8gVPB8Inw3SDBNV9hrg68rhHJSOn87ViOo=;
 b=UcVKysb4dZhhN5qguA3Qr+INjqfBSt8e4ApF5WgK5TV4bKE/9kZ6rlXflgC7opjYzH3Q1AUweLxK6lXA6GvOValqwnDR4thbEIr0RAH5AQ95XMda7+6ng8NJ+jB+UoH0PNfo4MO8RpZrE9bsnT3uEDuAL+rBLyRX/gpS/9txK5xP3904jPJ9mHVC5Ni75bOrgUNsFJqaWzvbl+WiC2fe6j99W6zUo7B0wDhP5kR9p8SqV5BQvWcl7csYq6k8ubA8SEs7N2Ip/RRkMUsY5Ws+lYLMoeqpzRzxTynqd4b0StBROXvSQEUfGtlCoqpgTSTaG0Kd7eTAmvoYpzqzegy52A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB9054.eurprd04.prod.outlook.com (2603:10a6:150:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 11:07:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 11:07:20 +0000
Date: Mon, 22 Sep 2025 14:07:17 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
Message-ID: <20250922110717.7n743dmxrcrokf4k@skbuf>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
X-ClientProxiedBy: BEXP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::14)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 195093e1-c5af-4347-d422-08ddf9c832db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWe9tdfVonKdSZyVrX0PcFp+zH1nN4b0XUL2SrgKeiVn4SybrIJsalQIkQuM?=
 =?us-ascii?Q?S+iZm/MUBLYFye9Bs/DDbUDVNhH4j1iJJzWmoxR/5zVv76RF+n8LJuCYE6aw?=
 =?us-ascii?Q?+wx7Dq3ylG8mDTIELaHzrHIy1qFP6eHjCL+aW9s9E+2utnur0e7qwf2E9RFK?=
 =?us-ascii?Q?KdDnUvogOAz7DLbzGQyNXvRDfhkE5FXN5BwTCUmFviFvTuiPBTGRKkDbfInU?=
 =?us-ascii?Q?BDiLT4xD1msyfW6xcQ4UYvLcGnskQBTmAodvg+jP7mgxHXbDw+D9jpL9rNxq?=
 =?us-ascii?Q?gPIO/cU/IEDXiDe1+SUQthWO+259m2ADViaUKZ/c4tL+4yLhCGRutNsbNPNZ?=
 =?us-ascii?Q?P7EB9bROFIH5zLTvbeQFT3YHqRNwlHq1XNU7daLQC/7eYXX0XlUHqVJAxir5?=
 =?us-ascii?Q?C52OerwkabhBo4ogEnhPSCDG0v1cegVfIuJXCcZqKQlw2a3eCc+93nkPdac7?=
 =?us-ascii?Q?+jDLf0XKK+bIuY24qVgOHlum/ov361mjCcNdZWaPcjOwqgWCu78pdBMtPuuO?=
 =?us-ascii?Q?E8DvPsZtV6Jt4jn49Xg/IGasXJKbX1fu9y/Z8opHVPuCjdnvkdb9PrUcdgz2?=
 =?us-ascii?Q?fheiAcC4LcQ6jI7mSR1d6+yTqkedZP0KIsBm5SEwFBroy5N7RlFjUKPBxnXX?=
 =?us-ascii?Q?N6Cvp293yM7sSVxQ2hWc20CzmnkjdPl066dR1W7thNfhd0aTjDUSIh3uH2SC?=
 =?us-ascii?Q?5o4cSsadwNLg+Oha6gY1o78bYDJ7IgbwPle9fXnGMsDx5I8OuS16SWyGgDL+?=
 =?us-ascii?Q?XqAaOlIPXl2SJnfAv2DsICbl+0Yoctm7hyoRYrOlIb9HV/Gx8BdxUy5zs2JP?=
 =?us-ascii?Q?GzDI0D9gn0hTS+nlRbsoaDoYh2Z6yfblQXAEcpl242MY21ImtwOJdY3nap2b?=
 =?us-ascii?Q?zLCa7nIAROwCU4ZWionr1rFzTJIBG4W04hgHrOGQP+G9UzTd7rAByYCFW01J?=
 =?us-ascii?Q?52L8spXmrTN//lkz5e5oW1JO5lDBF44uUQstQTlGjaZ5e9PcuBZO6gP0Zjoi?=
 =?us-ascii?Q?6OZbU+/0kbA8L25wQe3NKGF1ke2TiU4UymPMMExIJL6lBTQBO5wONLtfMSAv?=
 =?us-ascii?Q?CeWernvPmKk8divY5/V/ipRAzbLfIZwFmOVbZRHxYhjfevTVM15xa/unmMfw?=
 =?us-ascii?Q?jhU7xuiVyhxYBPnvveEUbFlWGbhH4VEzfv8jF8m/NFtF6xZnqiYZ9mbqzNVb?=
 =?us-ascii?Q?x5AANqgaTLR9iA47yEar0JO9RmI2h8GyxSHMF1zewvI1HbUJZqqRADslXLVv?=
 =?us-ascii?Q?hhu5tfa3MAuZ3U320qkc7CKkGZ608Jy4kJiiWhEWr+YRkihwWuWjP65zLSvR?=
 =?us-ascii?Q?2ZvkdkDrStPawuK5L6Uq12Fum8lC5TLXxBMwaJPHTByTcALYpyX28BswNNdy?=
 =?us-ascii?Q?oc8Cm7Zg6Z5fFcwGggSIPToD+cH6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z094gDbGELTgXf5TtSKuvlvfw/DEMQnnvENDH2kbq3/lymYZEsUqzGHgEyCB?=
 =?us-ascii?Q?55RS+0CNNCM7Dm9ihIzh9M7ZXgJ3WqC9Eajj0XeY4dQB2AKfT8oP5qAaXXzZ?=
 =?us-ascii?Q?BmotXhGCorHREhveb7S6UJs6r7Pv3WXD2qo3JGe2HvzopP02XwajJRbjiCsM?=
 =?us-ascii?Q?prgQziEp1MUFfeZYiZrDAi+nj/lGlhq62YU2WYWwERbcDTUGy1lADDoneTMK?=
 =?us-ascii?Q?pxz/y8VvizxN9Xpj9e3EXeXqwrVot1jZ/BiOQxkrlhVWuMLmU8EI50SsBW1x?=
 =?us-ascii?Q?5T6NUDiMZDAytN0+DF7M6CcktmUHpmxLdqPvkTuAcZu6pbvVIjpz3oMz9we8?=
 =?us-ascii?Q?Vji6dm2dcIaiQaygRhUh9jlFO/slkSmwcrFfs+O/dRFS8JIg2oe8Vg1Y35tc?=
 =?us-ascii?Q?tXhzZJKrI6qOkHUX3vAP//aKkYKN1z43vsYnIGZqDwSyhZtwNdxuhDKc/dHp?=
 =?us-ascii?Q?HoZ1siUrVSHtIPv7gyxo6A9PQPMtY0wh3Al9FMM3ql/2Lrgbauqnx33tC9nl?=
 =?us-ascii?Q?n5vx+26gFgOr1F7Ur5ftoLF32OYfdIA3PcrgtOjXc52X3IHG4lqo5A3oFPE1?=
 =?us-ascii?Q?phHlO22jf8hvlC+PBVXEisXmAuKkjfXtq1XfIP1Miisa6kz7NNyG+jLSV/UC?=
 =?us-ascii?Q?uD54W0lurCdrpEuu1Wm2U1EJtbW0v9kLl4P7lCLcoGfs4mv2l+ysXq0/KD/7?=
 =?us-ascii?Q?z6zEE6cZljHVTYMH3rD5MZxZl0LgVuxbcy058ot/Ha9JTdCDuiHNPkmwV70e?=
 =?us-ascii?Q?UeKn8EQAWUNaMT1Tc8NR9zORWbfUX2gqO2cVDGYpu1krpgOvF1hhRMC/SAIZ?=
 =?us-ascii?Q?gF04EX11ZMzPxfFDDRozmifSQUbTJQh7y264EhNKbDeZ7fIfUSROrwu6MbWE?=
 =?us-ascii?Q?D+bwucXKjVIiLJUJCEcsXfzZ32sGS/D7NMynZWmuvn2b1ZXRnbuLRlwahIq5?=
 =?us-ascii?Q?MX5tz7WakjXK7o+PjH69LAQSoBItQRmVI5yMGwuT+i70RwISQcFpbG6u9OdC?=
 =?us-ascii?Q?kXeGGGOaDAk5lo9KdEH6LF3N64GEw+erU45FK7OHopnKVEpTFpFxwyRJ69yl?=
 =?us-ascii?Q?WxdkO+ykNnCAD5KCqLP4QCmhPtrasOpOgyFXwon97ZmujSHhr9Eo1Qdp2g4v?=
 =?us-ascii?Q?Y1AEc1o9+xQFUj35Jeu/pkrNJU/bAiv4zwecIiyH8Gl/1MQf3VHZMxxcZKZG?=
 =?us-ascii?Q?b4NFfQsMwW8f6+4Eq+7WnSD0PyIhBJJVUpwQFViqiNS7Kv+eMrK4N8FfbdcI?=
 =?us-ascii?Q?6arF/YB4c+UwL+ZprGjPxo8NE9xcvClijaXpv7wDuIQG7Lwi8IEJZlZELNW1?=
 =?us-ascii?Q?suYQdT8g/SPep7z2h7rXASFZZb4QGO0SXwmfxgWWuUTKwQyPYm4pg9JC2+DD?=
 =?us-ascii?Q?lqh+vqrRrKr68oudtL+gvD+d5lLrhhN/nvogia4ZSbkpyvNAkMjKXUeovWe6?=
 =?us-ascii?Q?xxNnaZIxlGeneOcj7uPbAuJa3qvZNOgjlyYmq8rjalH0wZnQPJKfL7Dt05x/?=
 =?us-ascii?Q?GsV+0XgAvChAmyMrQKcCu2B0BDlYbGctkBtmzpAAMaPjKREC3DmD6I7s1Fsn?=
 =?us-ascii?Q?vjZoC1A72knYH5vAa60XFIOdDoF0uVOZwVSEXWn4ibbRm1Y1OyOshmagoeLy?=
 =?us-ascii?Q?tQJMIkiEIuQZRqhmMtsxIBXSfX+Z5yFYqcoOqGosjSjt5eEVpC93r6kEYpzg?=
 =?us-ascii?Q?ZHRy0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195093e1-c5af-4347-d422-08ddf9c832db
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:07:20.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhRFOBozC9ZuuQPHnlhOcWMWNYSOYI4evAE96yzF0m8y+YXMNdfKM0yFKT320Z9f+b7Xohjv3JqLc1Pb1Xdl6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9054

Hi Daniel,

On Sat, Sep 20, 2025 at 02:07:25AM +0100, Daniel Golle wrote:
> Hi Vladimir,
> Hi Jakub,
> 
> sorry for the late reply.
> I got both patches in my testing tree for long time and can confirm that
> both are fixing real issues.
> 
> On Fri, Sep 19, 2025 at 04:50:08PM -0700, Jakub Kicinski wrote:
> > On Thu, 18 Sep 2025 10:21:40 +0300 Vladimir Oltean wrote:
> > > This is a small set of fixes which I believe should be backported for
> > > the lantiq_gswip driver. Daniel Golle asked me to submit them here:
> > > https://lore.kernel.org/netdev/aLiDfrXUbw1O5Vdi@pidgin.makrotopia.org/
> > > 
> > > As mentioned there, a merge conflict with net-next is expected, due to
> > > the movement of the driver to the 'drivers/net/dsa/lantiq' folder there.
> > > Good luck :-/
> > > 
> > > Patch 2/2 fixes an old regression and is the minimal fix for that, as
> > > discussed here:
> > > https://lore.kernel.org/netdev/aJfNMLNoi1VOsPrN@pidgin.makrotopia.org/
> > > 
> > > Patch 1/2 was identified by me through static analysis, and I consider
> > > it to be a serious deficiency. It needs a test tag.
> > 
> > Daniel, can we count on your for that?
> 
> I have now built the 'net' tree with only the two patches on top, and run
> local_termination.sh for basic testing before and after. I've attached the
> results of both test runs, before and after applying both patches.
> Consider the whole series
> 
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> 
> I hope we can proceed with the other important fixes Vladimir has pulled
> out of his slieve[1], however, I agree that not all of them should go via
> the 'net' tree, and I suppose (speaking for all of OpenWrt, which is the
> main user when it comes to devices with Lantiq SoC containing those
> switches) that going via net-next is fine -- we can still backport
> individual commits, or even all of them, and apply them on OpenWrt's
> current Linux 6.12 kernel sources.
> 
> [1]: https://github.com/vladimiroltean/linux/commits/lantiq-gswip/

Thank you for testing.

I have two comments to make:

- I don't think your local_termination.sh exercises the bug fixed by
  patch "[1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br()
  call to port_setup()". The port has to be initially down before
  joining a bridge, and be brought up afterwards. This can be tested
  manually. In local_termination.sh, although bridge_create() runs
  "ip link set $h2 up" after "ip link set $h2 master br0", $h2 was
  already up due to "simple_if_init $h2".

- If the vast majority of users make use of this driver through OpenWrt,
  and if backporting to the required trees is done by OpenWrt and the
  fixes' presence in linux-stable is not useful, I can offer to resend
  this set plus the remaining patches all together through the net-next
  tree, and avoid complications such as merge conflicts.

