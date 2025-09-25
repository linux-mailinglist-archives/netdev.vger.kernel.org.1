Return-Path: <netdev+bounces-226205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA1B9E00E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BC12E74B8
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B752E7F2F;
	Thu, 25 Sep 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fa8Lar+6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648D2D73B6
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788104; cv=fail; b=ho+MiOWxTRoTIQCg/osbPnNfjoROA+kw//RUfUWCE53VbVCDHsrAuvx3U/EmVEWu4xJ/ZhQ4wrPvp9BAc94/rbqPD0G9enf4v9BMPzXD3oTtQ/GvnUVo+Bpu4kjJxLYMG6AQMzQiiH9HP9OZWyQ2yK0MxFydqEboTY6kftsnCm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788104; c=relaxed/simple;
	bh=p/4jqL5xZAUVyZDbApNcDllNRm4ejOE0S4usGxD+vvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kycYlBWKluK/VM/pEoZOCMrhdmsItDmrehWF7Nthe2AJ9AAw+BFf6LP05MqmOZNLDgxFiHJUAwUR1fml+V1zTHePbyqMiLQztQRwawH1y7PRdbsu5T/VvJA+4ytCLC5AhOBIFyGxg2KiuzAtWKZrRyIZvA9xRH5hONYC+nTNi9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fa8Lar+6; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUazJw9XpPtYVh95VVDSnkm3Nler3qwRGfaDelbqYn0gcP8j61TyE/ViVnPqENFGx9PpAbAJd9NVDKT7PQDAKmuIPMotL1nsCrS3Bl6DzeLuoTdcnyH2gQRRXCJKMWx3QhM7l6Ffn+JQaJSHFtmOBi69fZpmTo6qx7zsWFlbIHuSqa7TqWe+WWvaYQP3/wKbjin9EC429gyo7RouR7QMWrN5lQe2NWtMLaOoCPGL4hEec7HulU3Y+b6bShi97EIG09WS5dgSC+aJGh6OAymbx6hbKM6ts/aDjw6oK9I4Z1X22fyZdewDyKfXvH78i56GK9rWTk+Up72ecFEgMdq2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBh3LWG3rGKKp+DEC0Ny5GW/23XPmgB8ANB8hGsseBM=;
 b=vozU0+0kKrxRXqyeXig6T5ryvNvqXSpN1WYnl3xtTgFKNjQEhrGIyeIby9bUIp4sDjWht7JfU04pusa1xAnq2pZwYD/TWDfZIsH5YHNc9nG403dg6qlcHLE0KM+Bnc9iXrjhpp0gDUijVfBYHvPznqgTBMK01Ql1NootV9AV7MVSsnBkdcOrYt1BcIovELcudtVq7+ZuD0z3tk6qa2Z0HeUhBVWtHSdu5GAj5UcNo3Z1r8ChsX8lsGKiWrTd0FAwlaPwYAWeToJ/N61ZkAdQ8cb9QatvsX72PB8DTTL03T2KhtOBrJ2ffVAwdPulc95jRItbc5t0KdhGlcN9uymMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBh3LWG3rGKKp+DEC0Ny5GW/23XPmgB8ANB8hGsseBM=;
 b=fa8Lar+6WPwUM6yNJWds+PFdrtqT0soZwhO9fm6Dwt3P72vDwwIJGXMcEIVNT7qYbqbDxjULC7v+JWSH2uQGqbhpo3/E94PJUo+YGYBgohuivmPt8Yy8e8q2w9Nv+FlC1EB5KAQmo/ZkGWPKMXc2djvNnqrMNy2/C89Dfg5kC9YYbvEFT+IHT2hinh+HLUhokNK6N6/hgJ19mXm8U137a5/JoZeZB4/3K3uCZdmfq9hP5v9Q3eNEnCBMkql9jYv0R8rSmOP71gJL+mRLXC+Nk6sOUZdWLn0rW4/lMLqedRqsotinlzKqF8tKYLZp68+/XUKwlFm4Gz+xV1QARbQUvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 08:14:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:14:57 +0000
Date: Thu, 25 Sep 2025 11:14:52 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
Message-ID: <20250925081452.7u7hvvgac62xavk5@skbuf>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <20250922110717.7n743dmxrcrokf4k@skbuf>
 <20250922113452.07844cd2@kernel.org>
 <aNNxC7-b3hduosIh@pidgin.makrotopia.org>
 <b2257603-382c-4624-9192-2860208162c9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2257603-382c-4624-9192-2860208162c9@redhat.com>
X-ClientProxiedBy: BE1P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: c02cb58b-3cf3-4df7-a5c8-08ddfc0b9bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?of8sr6Y68IGVH6WLLFDbpEs1yJ+guOiYOnSiZpUr+V+3G66fyQKhJUZfjQ4K?=
 =?us-ascii?Q?KhWDyhdZTvtE30fzZ9sZ5DfeDKF8DSJpSHZzat7qNBvj0UuzFDDbKe0k+yWV?=
 =?us-ascii?Q?9IbDu69ELYoU8HzGzT0lyaZqjgOc9u3tkNqvFcZglF+Gfj6ZIVBJ4ZozimwE?=
 =?us-ascii?Q?MWQxrKDI3JXsyluQDMB6EoN4s+b7cqbjtIyMd/1mc8r26pE7WgSAdU1dFpkh?=
 =?us-ascii?Q?8kmV52nkYEFecXqd2krcbY2jWZxRPBc41QT54yey3gmx2IV+hcWZSusCHU51?=
 =?us-ascii?Q?MuLOc9liR6TEhZi0Vvujdwzf192WjR4lW24Fa44G6dnWhD4I6+kVb0JuB984?=
 =?us-ascii?Q?xH+xw6y8xZbcyrTJLJAcX3RZiZVE+4g3r8bsTedP3j4hHbFTPyZEmKajwgbv?=
 =?us-ascii?Q?cbp2WfiPah1nMSOuSh/RgTs2e7x/IyB0Pz2J0ZARfRo1atNNUrObpOvjDpid?=
 =?us-ascii?Q?NAhbJkNTzsJDyNp56eopo9AqGH8VbgFfx8FrGfklgl/pCQyxfmoSRGbbwTaL?=
 =?us-ascii?Q?f/1ouKdgm+Er8V2IxGhKLBWIz8jMaGoolbQJiUObHFLpHaGG938gqB3eqGFm?=
 =?us-ascii?Q?ov2qDUXNaiE65yFaJOGzabTB5gBd2c50YK+MIDZCm55BB5OESghaGspN0480?=
 =?us-ascii?Q?iAALz+QUMwVQrvJS2cQLideUUDwikarvhrddCeFzdPjDVwDeJjwvMYXIRJ88?=
 =?us-ascii?Q?p5f73PKpEHfEv7p9vZeZGSAqHgDL3MI8J+4hn7PCAms/1EJRBaM82aF4r/nn?=
 =?us-ascii?Q?izsEjhsOWjpTWovQAjEO5/+n2502cDBw1VhNvasmZm2ZZKHCTCzpw8c4+1BN?=
 =?us-ascii?Q?0b80dmh3u0PGBQwvCE+hHtseuqyMogWRwwO08GoAaE4kC2+nRGI4+Qnwxrp1?=
 =?us-ascii?Q?xXqW7x225Uppe45bTueXXXIJ9gEOr6CnAFSu+Zeapz5tl7GArOZuVBkR+MXA?=
 =?us-ascii?Q?tp9yelWlZPT6llZLcsBBfIsm7piesTHdbTqi+F1wXxeH9rvyoPQ9jUyumy8m?=
 =?us-ascii?Q?/YBkqffbDgRA8F6x6e3IVHKDzXWCKF8WnA5a04OL6OJufVnVJORNdQ9b7+Gd?=
 =?us-ascii?Q?lGDy3VyTJ1gA55M6Ct4799QhVdqjAg286R88DDHLYcE2ONhb0y5dZuqJyRQF?=
 =?us-ascii?Q?m3g8cP1LTtJGPOtKSfiFIvKIFqibfg3Soxb+l7xRFW6x9s2MSyVLG5QcbSO7?=
 =?us-ascii?Q?VJ1AUimmP2TbXOHsb/casfosjc5/7VI5p3y0I5L5NeAq5Uh+bW1k+KmdW2Q2?=
 =?us-ascii?Q?u4Ki5jrY5Cxid47L/8wRiakdAkKRN3pGCWQdqu4rlid/yz8NZSnERbXUdnwb?=
 =?us-ascii?Q?CiGq3pxFktX72R0ZcFY0T7eJuv+ynCoiD9gxZ2csgHFXDKjM749Toh3mqPpp?=
 =?us-ascii?Q?nAjNn+wfQ6lRhCdpDogNH3WYLbKGAvic750zCvkg3nU5YIX287nKhYEnnwmt?=
 =?us-ascii?Q?GlCQtoQlCh0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxxiLh/7xeFE/3C+FMza4yC4+iCzuofC782uKUQpE3Ebn+NFEtJ3NxqzNvx3?=
 =?us-ascii?Q?aVCx8B0B5KkvAm8aTA85AzwI8POfH0S2m7kXl0btdBszjSHxFy8hQuDCTS0r?=
 =?us-ascii?Q?lL7t72jemo7Qo9AkbhLvNKb4gyDMqxNMuuMDY1pBvU1olyMjtMWwfN03OHm7?=
 =?us-ascii?Q?7xNdMMG//54n4zBSbSdt2cmO5sOExSTQiouGeyXPVeU9Cw4Zz1PweIeA6p+V?=
 =?us-ascii?Q?CYtRpyZ7xZO7mkuPk/U4qSd8Db6ZuVva5+HQ16a4Zya8g8GT++CJ2QBPpQ+J?=
 =?us-ascii?Q?Sg+GZl/DmYzp8hPpKcdqgUDUqtIKOuspGvrB1t3g2TxpmZOs0jJ6r48NF83q?=
 =?us-ascii?Q?haKL4cIQHYK/RSvPifB0fXsdgrPx8YO9edcsTkCv1u4L7WPpBwRsMadxRaGP?=
 =?us-ascii?Q?NDwbz3i0/gemRwpOpdBQsF+I4iOwq9+ToD4qOYxw8PkroY83PMaU9KY9MLp0?=
 =?us-ascii?Q?+h5gptKod1GamzZppivlmEU2+BEJlJlwOMKFr3xS35CIUaKSsCO5J8fVeyDf?=
 =?us-ascii?Q?4UrjoXz0mC5VrtXPQYlJHEULCAaNEjn84ojcoA0Pq9a8kO299j7G38wKiYpN?=
 =?us-ascii?Q?ud+JOWxzqtwuE1vagIY2lLboNvMg6ld3yXoXgaEaysMZOFjSkSJSQdTHuXeR?=
 =?us-ascii?Q?KnbI7H1RNSHdqs4G3BoonSLVN0x6WeS6n8ECwwjuZn635Mc86NQuISZRUL8h?=
 =?us-ascii?Q?0pY1eP7HZWFc3luFmNYAWjTXwoSYU3JnrVm5/tkErPyrF8yOk1jMqYJQ8O4J?=
 =?us-ascii?Q?BjSzCQanGP68zO9GYDGNC9m8Oo/upKfjo+/1yHaoAIulpdIkfN5PpUZlgK9h?=
 =?us-ascii?Q?etiUeh/fZOMn8nBoRvypsuJfjlgnOCMVVq1mYvGbBt+IdGwK+5XikNZUofPZ?=
 =?us-ascii?Q?nm8rB8eJRyjBOXj7sObW9oAB389VA6v4qZCgF8ld5YPEjDplp8GvcMa4LB4/?=
 =?us-ascii?Q?3oHd3iiLzEZfuBFmO71PGMRmCNGl2Jhmg0pWF3NNmOFtn175e5T/YgA6ZWSh?=
 =?us-ascii?Q?E7ad7mOk7o1QfHJhHNJ9EGmhU96rctX+40kKhDymVSvMEWzqytWZsLEH+3Zr?=
 =?us-ascii?Q?PrcGeKz3chSJbp/wxe5/0dQyMfLC93W1+8OhNPYrdNLIssM61p5c2b6qmUY7?=
 =?us-ascii?Q?JWQD6X6zmoStNuYJ1i1VBnriEZTpjYxnvNfMuBYEMwQuiPOKkqaBW9lvHvSy?=
 =?us-ascii?Q?Rjl2HakD/592kOsM6GoxrhpI52Vc+dExD/zMDSEC3+Ud+ht8xBOcVSyzE6/i?=
 =?us-ascii?Q?czxtx8Eol6FAKL8EoxopThqATQDJieozn/xlJ94e4oIqQrzLyr5oGBw1MA0t?=
 =?us-ascii?Q?/enjFWafve6vK7o6j82c+MJhDtgsOjDSeTovNwnv6tfRiTSc5FgCncINYbsD?=
 =?us-ascii?Q?KPgbaWMJUBWeQ7oToXsVyCvC63OaUavxgv+0RBX3TAsyj/qiJG+lbyC4w/aP?=
 =?us-ascii?Q?/6oZKcaWcu09hkdubDjvhu3cZ/rx//v4nw0G32mCWMV8f6lRbNIcbR6XWuTf?=
 =?us-ascii?Q?Gz2EoMEBVsn6J1ushdZBtTJMnGQcofS2wsrSk8hNzIj87ZUN6Br5a9JSk/pY?=
 =?us-ascii?Q?pcX6ntStbGAjOik7Hy27O0H5z9cy+kmiZsfcFAIluHOtAEirrrqTOmF9ljC0?=
 =?us-ascii?Q?nj8ajd1V4kXpRw1kKL6fIUfnFKNA3P480vMcbDyFisVsaZAgnQnQ0oa10JwD?=
 =?us-ascii?Q?DnLa1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02cb58b-3cf3-4df7-a5c8-08ddfc0b9bf5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:14:57.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUh30s3FjS2zfEW/xn5DURGu7hV+uErlf1kvmOfbyQloelRqVPtbjNZwwdkYkqKlBrf0/VjCs0j8A7rDjm7AIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647

On Thu, Sep 25, 2025 at 09:35:54AM +0200, Paolo Abeni wrote:
> On 9/24/25 6:18 AM, Daniel Golle wrote:
> > On Mon, Sep 22, 2025 at 11:34:52AM -0700, Jakub Kicinski wrote:
> >> On Mon, 22 Sep 2025 14:07:17 +0300 Vladimir Oltean wrote:
> >>> - I don't think your local_termination.sh exercises the bug fixed by
> >>>   patch "[1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br()
> >>>   call to port_setup()". The port has to be initially down before
> >>>   joining a bridge, and be brought up afterwards. This can be tested
> >>>   manually. In local_termination.sh, although bridge_create() runs
> >>>   "ip link set $h2 up" after "ip link set $h2 master br0", $h2 was
> >>>   already up due to "simple_if_init $h2".
> >>
> >> Waiting for more testing..
> > 
> > I've added printk statements to illustrate the function calls to
> > gswip_port_enable() and gswip_port_setup(), and tested both the current
> > 'net' without (before.txt) and with (after.txt) patch
> > "net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()"
> > applied. This makes it obvious that gswip_port_enable() calls
> > gswip_add_single_port_br() even though the port is at this point
> > already a member of another bridge.
> 
> Out of sheer ignorance is not clear to me why gswip_port_enable() is
> apparently invoked only once while gswip_port_setup() is apparently
> invoked for each dsa port.

All ports have to be set up during probing, but only the ports in use
(in the "after" log, these are the CPU port and one user port) need to
be enabled. The user port has a netdev, so it is enabled on ndo_open().
The CPU port doesn't have a netdev, it is always enabled.

> > I'm ready to do more testing or spray for printk over it, just let me
> > know.
> > 
> >>
> >>> - If the vast majority of users make use of this driver through OpenWrt,
> >>>   and if backporting to the required trees is done by OpenWrt and the
> >>>   fixes' presence in linux-stable is not useful, I can offer to resend
> >>>   this set plus the remaining patches all together through the net-next
> >>>   tree, and avoid complications such as merge conflicts.
> >>
> >> FWIW I don't even see a real conflict when merging this. git seems to
> >> be figuring things out on its own.
> > 
> > My concern here was the upcoming merge of the 'net' tree with the
> > 'net-next' tree which now already contains the splitting of the driver
> > into .h and .c file, and moved both into a dedicated folder.
> > This may result in needing (trivial) manual intervention.
> 
> AFAICT, when Jakub wrote 'merging this' he referred exactly to the 'net'
> -> 'net-next' merge.
> 
> > It would be great if all of Vladimir's patches can be merged without
> > a long delay, so more patches adding support for newer hardware can
> > be added during the next merge window. Especially the conversion of
> > the open-coded register access functions to be replaced by regmap_*
> > calls should only be committed after Vladimir's fixes.
> 
> This should not be a problem. Even moving these patches to net-next,
> they could be applied before the upcoming net-next PR (if Vladimir
> repost them soon enough). Even in the worst case scenario - targeting
> net-next and missing this PR - there should not be any delay for
> follow-up patches, as such patches will likely have to wait for the
> merge window closure anyway.
> 
> Given the above, that we are very close to 6.17, and the fixed here is
> quite old, I suggest moving this series to net-next - unless someone
> comes with a good reasoning to do otherwise. @Vladimr, could you please
> re-post for net-next?

So since I got my testing results which I'm now satisfied with, they
don't actually need reposting. If you can pick them up for the "net"
pull request and they're merged back into "net-next" later today, it
should be even better than reposting them for "net-next" - which may
require some avoidable rework such as dropping the "Fixes" tags.

I can repost them to "net-next" as well, along with more patches that
are waiting for these to be merged, but this isn't my preferred route
today, as it no longer seems to be the simplest path.

