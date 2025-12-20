Return-Path: <netdev+bounces-245612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D5CD3751
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 22:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7655300E17F
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0F2F1FFE;
	Sat, 20 Dec 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dlXGKvzW"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635091F461D;
	Sat, 20 Dec 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766264899; cv=fail; b=Vb8eg/NgKDob/VdH0TA8oJw3nrgldeDsaaTUMtKrqQ6yI/A8nDUF42/w2LkMWqXlGttCMYllmKKepvi7BTOpcY4rNdlWx4k/djsKuZsWwpHd4qyHaK3BaaVaUZzCguZTpzmkEDbLMRhOuQoxXsk9g7M2ftrhGIA6XB/C+jgTUhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766264899; c=relaxed/simple;
	bh=6PEef+ia2ztwmWSGIujtn8UEBfDmZOgjog9vqtXkWBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XnmMP6A1dN02fN7ZFtU3hK+mTMJb9OyJaZVLxnl8aMndF9IX4g4JLswFqOIh26iyllubsrW917lj5w+Yz2cWwMs5jBWS1V3e/vnK+0o29nmsh3eNB8RdUakKLQC9eK92dzGglNSuXs/j+o81urQc/pJuMs29Vtut2Iqnsh8xbEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dlXGKvzW; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNf8wVwEXjw3N8KjJqWwzz6VxvUszeId2JwdIN4N/LkIQBGP9ugh8wzTg4JJjbs9VCYvKn13vBxbLwaSfO81cBvsbKsa73oPl9uLTr6eLuy3fv6EJJ2RJeNpIc6bmoc6+2WLWP3yP6EfV8IdspRsQmvKbCJFUW/TqqsKnS5pUwYN3zR10rnr9CdSKTzSirNwTfNXK6n8MEfeTkivMDPZ207IudomeHDRQOELZ2vtzeOIHJ4UcsSdSy3Gkquu1wyGT2Y+vyGBmzhO6gKsMiR3PQO4jZAYsrM+3zFiuxV4UhbU4t7edR9OnW+EtrwX/RfEEh4ikgqVxAbJAvH6rp8rXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7QpONV06NSrCF19O4EbhepDCaq7h8OL6fgB6YWdiu4=;
 b=cZdBUd2XPij9wKl0JPSokuHzI4Bkc13dDVe1+yhuxW17K0NdX5ysNB2QbpuiaeHG8TVexAbp/qZxVJRflWagGhV8jGpKwMBhmYGJdH5pdMZ+JYwg2s/j1Z6sBWaUCYgUcJz3mL6dUYN28uIauD0UI2ki1H1A1CMWVGhKuMgkGz3KmdVsZJa2xX8m05fRiH5V7kpaDyPCyZBHW/bnHRUz5WRNHFacQ8wAWg14sDuly7i5Zsu7YpBchwehNOV+ordUYenVcrqXJrdcaHI4Xpo8nEwh19UblKgftXlEvxWifoICCw5gLp0EchZXcNsnf9F8KU02TZ7mAyEvE+UseM2EVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7QpONV06NSrCF19O4EbhepDCaq7h8OL6fgB6YWdiu4=;
 b=dlXGKvzW0Oi4e3N1b7pk0s1LRI0QSf53VBgq2vESB0lsMVNyGb7ViGthz+2GAr5JIMNeVShPsLNeYDdULJWxtTgKcblAYK6+7ngi65Q/4GFJq1EdO7Mw+pKWWuQdwT1xVltcI2lrBuqouVY4LuADvC+Cat7cYbonqPrZh9ayZL/MENmInuRWQmD469JPvx1cUu/CCJC6Ai6Al0NXbQUS8X8CuVXilbe89hypVplx1BA+Sim4VefYD4KshAL5snuieFAMblMvmtIzosZ5OZG02UZNwONcz/qKP6ZL+N+E0AkFXHfl9WpS0IITLgg/SU6Wn45Sim/LhY8XHD5PVUblQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sat, 20 Dec
 2025 21:08:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 21:08:11 +0000
Date: Sat, 20 Dec 2025 23:08:08 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jerry Wu <w.7erry@foxmail.com>
Cc: christophe.jaillet@wanadoo.fr, UNGLinuxDriver@microchip.com,
	alexandre.belloni@bootlin.com, andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: mscc: ocelot: Fix crash when adding
 interface under a lag
Message-ID: <20251220210808.325isrbvmhjp3tlg@skbuf>
References: <df7cc79c-0f46-4346-a016-1b208346bdf5@wanadoo.fr>
 <tencent_EF65B9D0760ACECA83817F30AE262884DC0A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_EF65B9D0760ACECA83817F30AE262884DC0A@qq.com>
X-ClientProxiedBy: VIYP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: ca221431-a0d9-46d8-e0b8-08de400be243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aJZIohdqfDdj7t7buY3HLFWdTe7bpcSypinpGAW5VRemldzs97db2XzdAVPc?=
 =?us-ascii?Q?p7j8CBEA+gE9bTCPP3Mdg+Y7a0hqVf832e4A+P+BDMbaWAVP6wKxvGiBlWGJ?=
 =?us-ascii?Q?K9QAgE3eeTxLBtbnFYLpQkXzuKAtJZ4w1tp711IzEN+D3AyaTQrhEcZkiGED?=
 =?us-ascii?Q?9KuO9aeuFIlSgzjCGuh+0Mea9mjV5SnDGV2BFFr766QyUA3gCE4w5wDt/v1R?=
 =?us-ascii?Q?D2vUQ2/Rul7Ah5x65t2/GmIKcXYEv6LHJ8q+ve42J2O2x98iSOxVPTgncvHz?=
 =?us-ascii?Q?4B42fFZLyKMQWtion/de1IM5JlkUfrkczyp5Pys3gtjePWAWXaUbnaMOGQlJ?=
 =?us-ascii?Q?dEMoiaOKHc/cgKt5HKPNUi9gufrh30fnnEfCDxsCZpQmkzpjui7AIKqr7AEd?=
 =?us-ascii?Q?CchTSFGct/IpKT5EWuSWfskb4zFMbc+Dn53tTLzyy/vfli7N7jbXae42iMLl?=
 =?us-ascii?Q?S05JfRJE6bcfC2RLNzsciOAtsUkXcjHia8OpLAz8E/nGlCQITYoSxqtiKLoh?=
 =?us-ascii?Q?xsgYrI6dtQVG7gpv2X0gxeI3krIBPFoO7WabPMrGhta9hW+daOv+sim3868b?=
 =?us-ascii?Q?leT+H7veuGYefb1+uqacyXmqPO8zLWvQUutvxCy8pXOrSZDzzhTZybhlU3wq?=
 =?us-ascii?Q?hDCMyoT2ty1mnMUNGYlYl063IBqn0FaWXu2wq2SSlWJLBDugauscFr9N2A/3?=
 =?us-ascii?Q?6k7vY62OV73EcwH7p4/eyxhNvitNaw2HE5O6Wmomx3fYcU40Y9aGRMIp3bNR?=
 =?us-ascii?Q?1vcuvRCQkjeRqnvA0W8JyLLd0Uf2rxxqX6iTx9DCuKyKFx0c1RdtzoaRkp41?=
 =?us-ascii?Q?hCdfU8nFnyn1SVpsk8tzqv8XKhXBdPPFck581Uj8FcDHhdFizSnAfhDJ+UB4?=
 =?us-ascii?Q?RpK2CUdY/avNL4p36aDg1LrN/cXEwVhb61JlVNUWiWTK1t3xPbAulmaMOoaf?=
 =?us-ascii?Q?0eWmncjC6GFHn/b69bcW8sAfchyj8NI6hoKQKYYFoH1G/BBL4G0TiyLCluqv?=
 =?us-ascii?Q?vu9nbcW0U1bbUJzjIlB0zP4JjUOpRukoIlBIEZ5oBqXpqLDWy6XKliFpKqT/?=
 =?us-ascii?Q?hH6zlnFZ3N1a2xZYkM0MvnhmWS6xznXPdzVTZ3JfRI7LFxM5u3lu63eHqXuJ?=
 =?us-ascii?Q?pmdlRJTe28fStFKG4JZ4QQn5nmRr+GZZi6JaRs152r12o49zg0IOGDYeEPpB?=
 =?us-ascii?Q?6UdS3qVUHZH+M0LGNzDTKR/VCQDLaGRWlCrsc525Z6RcJsDLx21n7lXDj6U5?=
 =?us-ascii?Q?tYzYRTC9N5T81V7+/PQEDKkv1nN/6/MGq+3ls4ZRNnoBeuNlzHIOguMlhSdy?=
 =?us-ascii?Q?lq9y+yOsgCSyYzetESscHD7E9xg422W9M/Vre4jo1IAzFS3URVOWAeWf9bf/?=
 =?us-ascii?Q?uSUvzIi03+vDMbAK9beaTIPaVSm6RuUXyZT7DmMaJB2UiAwaAKURvxk1A2MM?=
 =?us-ascii?Q?cZAo6InifWXGXUBwDdoHW+xkjxgWSvoOxucGroohQa+pOAbgth7Vuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Y7rKyrydRCX8JG+UejazsvJzq/QkjkXECkEFOvtPN4wyy8pge85hYlNf2NJ?=
 =?us-ascii?Q?YnGc3NDdUkfeOShCEp001Xvkm8eFK5V7Sj+dAPE2H74T7augEOrk2DVgjFmF?=
 =?us-ascii?Q?4TLc3dIDOclVvAi2yGOHJIV3jgM3nI/NHG9RaXhv8/lUmw+59P/DChVj4x7x?=
 =?us-ascii?Q?XABHBiTO0lSD4wAaxe4ilRiRss3+a09k0CnbOaagQWPKk7u1qwIIrUVV06R8?=
 =?us-ascii?Q?w2GDPTVZJAzAGjoWsaurAgLuWHTffo+g2AIqQdOSiZ6cQQouF9M2twytT2qI?=
 =?us-ascii?Q?0eVxrw9ljhVvfk8IVusc7/clofXHLddDQZ5wvPC6TqRBkYP0WPE78N8znE7Q?=
 =?us-ascii?Q?lyFvR6umoRZqn4frfVQqqmAEwGp+gRUM4UvpJ8ZuSxD1ddGOhR5FCvtRRZcw?=
 =?us-ascii?Q?Qg/SMs2d5Vz9yjVV/kngN5BLznctCaYvO7GEocaaGQew31Jshcls9d/S7BwW?=
 =?us-ascii?Q?0Qmx92IX0v62BJ/ilTwzTWn2BZWZdHnSZ15eEkEnltf+fSa6X0x87NIaWHfG?=
 =?us-ascii?Q?nxxLvar3rZDcQ6Yhz+jWmtA26zyArTyfndvomnaMibdx5kSFdTwA86C0tQd3?=
 =?us-ascii?Q?R4D6jhzfLMWIl1oJNVHPd9uvJTj0mlad/U4kdb94yHjINeaBvgIaC4dtiXi+?=
 =?us-ascii?Q?cOwA51CNeBaUTCIlqHaieDcRWsjK9EaKG63laLHohSwTfTwomr7IDk/Ut663?=
 =?us-ascii?Q?HN7oOwtL+du+0u//MFgtGz9yPfJP3DfkjPZceKKUlnx//mdwF87NQQIyOCGC?=
 =?us-ascii?Q?RHc/ZSwXbIkOd6aKVmIeu2X+SuYqSsyhAxIpoG6nDA0SMQq3NRXbM5whm7yv?=
 =?us-ascii?Q?4z2DbZQG9qFciosyvlCfDrVDaLuVBEinAeMuWVFj72u7Cjkho9SpMn6UsN0w?=
 =?us-ascii?Q?iWyJZDscxHpedUOsj6FU7jlg1BgnMfcbCCRMlliy6Oiaix8ANhbGRoC3Grdx?=
 =?us-ascii?Q?48aQvqJhcPDGQAt+NANIZZwJ3cBfbZlw6ioi4NtriRdgOaNd3O9MC8L5VfDT?=
 =?us-ascii?Q?UJLMAVtk3KCMbhU15MXfBCVZvNX6RZ+1oCMZbAjFhRCQf8WS3tBz77lF8J6u?=
 =?us-ascii?Q?b1Aw/XkMPjnrzZDGRjnaC3oi5B5cnEaISgf3rsCCBuxxcFNjWF90om9BEcPR?=
 =?us-ascii?Q?R+yMNjgBaNWMCCDd+HiomlWonSmF6vjRZ5KMppoTIokl5R30ka1tOGlqp1Lt?=
 =?us-ascii?Q?5bpHIoqAmQz91mlDBn7Bg86MQ9yZbduQkyq+Taw/R3aSMHszjNm8H2Shs2lF?=
 =?us-ascii?Q?bf7MKqiipRjxDKJekcBWHons2oDIf4PMOkIwYKJUrO9A5iST/J/rtL4jlW9e?=
 =?us-ascii?Q?3trjQtNJfCfzw2SlbUg1TUwCE5u/qkvnDSbPF+sXWYEsf9TFQbSPfYxZpcpW?=
 =?us-ascii?Q?M/LHkYzL6ur1r5tiSQh4U+ZODY/UUdlLBxq0TGmiPfIoiF/9wVV+wyI+phTW?=
 =?us-ascii?Q?b/Hq0SRr6r9VobPn2UNidntQ0jGxVfoYbHTe4UpQnfw31Yxk6vEKrHBQdzuX?=
 =?us-ascii?Q?YoEi3aYFt+vvWOf/duVSpeJzTnWRuEZsEC4kO72Ol2QuDbc6H3+yf78trXzh?=
 =?us-ascii?Q?FRD6AD4r3W8DMF5o8Mmla6klGgYh6JK3rD6afLTEvUTLnscTOyS5lWjrFFhK?=
 =?us-ascii?Q?cfUs3vZCKeVM8d7ihZXUkBhGxuybGtm/6E2lHa1Cazy6VV5Xqnu+//Nl3cQL?=
 =?us-ascii?Q?NBZtK1xiiNEqp6gjSzNkkNffamIB8qZEcP9l4GcNNZJshhWqP5qn2/Vq13sK?=
 =?us-ascii?Q?sgfrsEkSAhyJ2kuPi9jGTEe2rqwgbADzkE2dxdcv7xTGPZkKtsoVbpmmXdsz?=
X-MS-Exchange-AntiSpam-MessageData-1: XnPzSaLsCRNP5odkO5Dbc0d8Q71tY468B4k=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca221431-a0d9-46d8-e0b8-08de400be243
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:08:11.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NN10Gz9VLQSaesO/GORQfiXwKpESVbG7GpLDQ1+Ny+YyIubW+2cqoOZETr5Bi85NSUBriG/Zd2UVPxelbKEzMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

On Sat, Dec 20, 2025 at 08:36:14PM +0000, Jerry Wu wrote:
> Dear Linux Kernel communities,
> 
> On Sat, Dec 20, 2025 at 20:00 UTC Vladimir Oltean Wrote
> > The 4th item in maintainer-netdev.rst is "don't repost your patches
> > within one 24h period". This would have given me more than 4 minutes
> between your v2 and... v2 (?!) to leave extra comments.
> 
> > The area below "---" in the patch is discarded when applying the patch.
> > It is recommended that you use it for patch change information between
> > versions. You copied a bunch of new people in v2 which have no reference
> > to v1. Find your patches on https://lore.kernel.org/netdev/ and
> > https://lore.kernel.org/lkml/ and reference them, and explain the
> > changes you've made.
> 
> Thank you for your kind suggestion. I'll learn to leverage it in my future
> contribution. And I want to explain that the repeated patch was sent due
> to some network issues as I thought in first email failed. The latest
> patch is the correct one.

Ok, but the content of the two v2 patches is not identical. One compiles,
and the other doesn't. Any change to a patch should constitute a new
version.

> 
> The context link is
> https://lore.kernel.org/netdev/20251220180113.724txltmrkxzyaql@skbuf/T/

You should provide the link to your own code submission and not to a reply, i.e.
https://lore.kernel.org/lkml/tencent_9E2B81D645D04DFE191C86F128212F842B05@qq.com/
In this case, this is not just a pedantic comment, because you didn't
post v1 to netdev, so your patch is [not found] when searched from that
lore instance rather than from lkml.

> 
> > Because the "bond" variable is used only once, I had a review comment in
> > v1 to delete it, and leave the code with just this:
> 
> > bond_mask = ocelot_get_bond_mask(ocelot, ocelot_port->bond);
> 
> > You didn't leave any reason for disregarding this element of the feedback.
> 
> Sorry for the missing. I reserved the `bond` variable as near line 2355
> 
> >		for (port = lag; port < ocelot->num_phys_ports; port++) {
> >			struct ocelot_port *ocelot_port = ocelot->ports[port];
> >
> >			if (!ocelot_port)
> >				continue;
> >
> >			if (ocelot_port->bond == bond)
> >				visited |= BIT(port);
> >		}
> 
> I noticed that the bond variable would be used again so reserved it.
> Sorry again for any inconvenience caused. If there is any information
> needed or improper contribution practice from me please let me know as
> I also found some other issues, being preparing to continue reporting.

Ok, so the reason is that "bond" is not used just once as I thought. It
is used one more time here:

		/* Mark all ports in the same LAG as visited to avoid applying
		 * the same config again.
		 */
		for (port = lag; port < ocelot->num_phys_ports; port++) {
			struct ocelot_port *ocelot_port = ocelot->ports[port];

			if (!ocelot_port)
				continue;

			if (ocelot_port->bond == bond)
						 ~~~~
				visited |= BIT(port);
		}

In that case yes, please disregard this comment, we need the variable saved.

After the 24 hour cool-off period, can you please resend the proper variant
of v2 as a new v3 with the change log added? To avoid the situation where
the wrong patch is applied.

