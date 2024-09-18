Return-Path: <netdev+bounces-128814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C897BCA8
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 15:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A242B20EE4
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD490189F42;
	Wed, 18 Sep 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dorQ/CAF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4C189B8D
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664401; cv=fail; b=t1WnXL1y/TDL15/xk2c+ttMTF6BOTRsLrO1wjv2Cdf2rw09Ytv/HNZNCQUx/ECA91WSbowpn0QQ6FXUJJyTDmf28ZE5y7046Wfv9PKk2xuZfO/rj9FPhekaaP7mKvTeWdCpNpSUJSOePe7DisgIhVvUHngke9u23gjXJqWfJBV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664401; c=relaxed/simple;
	bh=3I6z188pQL6PSRPnCnguKHNjI5fogGbay3SevWSs8yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lPY0X8+LcJdy+UY1ZCYSTgm5zVbQSq/BBZCYEs2I6LD2DEpYqG0Vdt57nV/j0tIU+URK00Sa4+kIN7/kyvIDA5kWkrURNzEw6B4ldceiCUhHu+GsiFIHS/7tQPQLk1YRITQ8FtKWjNvGXDRHvDnQgTGtXQdFPQ099WQJKJx8xnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dorQ/CAF; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlVFsr1ucQi/b5bhqPr0KJNrg3HZA3BSewQ9Nr7Q5aHQxUrlxzu2t4eTNwPmpLg8/dS8yyl55q8V9ctJdsQNJqlldrmN8a+sAb8HfDVE1WmiPEm+6EyMp0LId99r0fDCi1HqyNp2BFgE6ClDQrS3nZlm5zzZemalOOXTs470SW7QJ86fU519+cEkyE6c3tJZN0t4+Va8fkSYDlcu9uPMLPURGf7QsOTzKAqLb4HMFOOxpzNnBfb1kijWSsEVd2FRGzmBzbqiavkKxisxouM5yj9kRil/7YAKlZSeZe9s2eRCiijZMtWCW0aPusOjRLjIcMa/MqXWl+BGSN+SQi8opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RoGS0Hj91TVwvQudc7Tj4M5tjkq1B7/qQj7MhUzSjY=;
 b=Vag2b4oxra14GLeTqnpMOHGWBaJB/Ga8yDAXF5jplu+pCEZSg1gTELNRxWg+NtWSfJm7LdVjFwpEHOZbcvZq7y3hcLc+8aI3aVdP9WqpYcTdhhZdRc1vvqEi0J7fgVl4HZMZPcrN7QNang6mAqq5BhIw+BGX7VuqXQCFUBFltiuZhyJ5STvDXm3ZgsHM7FMd5AYTLfOeq9aCMcW94vwHdqKcooSMMyvHQQRTezuuiNeA9wlp53p1S31N5m1VdU/g0r5D6TAWXkOXoEP8dTEjykwxeIJN99Q+E6/c2nBLlVTC9bMVmHH3yRKNW9O68PO10uvKDAdrPhMAWtu+EAFfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RoGS0Hj91TVwvQudc7Tj4M5tjkq1B7/qQj7MhUzSjY=;
 b=dorQ/CAF4wX41HGUvVoc1Q6JhssAi3YOsQ3zFo5r/d3wQXYiu/oSW9kqbZ0Rs/kWQJFDyZGf8QcZlRrzi7kdV1dxvilfliv3l+6BgYuznC0y28LWyrdJnLVTLvfzzM9ZIfqazRevpRNdycEIesv0aHGZqScTjNl6FAvebe3pD6Y3c61/Pg820ZX5h72nl9RRNUUw0bT9JEqwjuXF6Rk5PrjBoVr9PsZGTyzyEMqXYUnnVc3oBIGICZKFeYcByi/4q9E6EgCqZXrJWQrpLKM+RDQmHjUIwB+TccD7ip+CkaDyuyq3v7PrtgZojkWVXDtOJPbKTJi4ATV/C3RaU/Gyng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8132.eurprd04.prod.outlook.com (2603:10a6:20b:3eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 12:59:56 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 12:59:56 +0000
Date: Wed, 18 Sep 2024 15:59:53 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Saravana Kannan <saravanak@google.com>, netdev@vger.kernel.org
Subject: Re: Component API not right for DSA?
Message-ID: <20240918125953.l64f5r5qq4pomvnb@skbuf>
References: <20240918111008.uzvzkcjg7wfj5foa@skbuf>
 <bde4e00e-4f07-4684-9126-247fc84cf165@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde4e00e-4f07-4684-9126-247fc84cf165@lunn.ch>
X-ClientProxiedBy: BEXP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::22)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 329b2c70-82a8-49dc-12ac-08dcd7e1cb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6fi2gNNORs2Ofkcg8FQkUYs36TYRexsViknBooYniItOtw/jkTrHK518Zzrg?=
 =?us-ascii?Q?1w1Y1a7zVrjZaitVce/EHmnUv857rH6uhXvuDq5yCQrFGiKjzbZEl6W2ZKUH?=
 =?us-ascii?Q?tbBWdGV0gi/n1HWI13VgB86VW4APQ9V+SxL2KJ5BuHZ1l8VvUQNGlziUNbM9?=
 =?us-ascii?Q?DU+u1h5ClBeHUfdKLGyo75EfHPzw+bQuyTFzxfDPPBdjD4NxItG2TdGtN0lH?=
 =?us-ascii?Q?nFBbRQkbONuHVy7H8OU7D81i0bf/veh1GF5B0C7I7G/Qs9qwHQHlCeFjRf9b?=
 =?us-ascii?Q?1/93WrZqEW7TRIREhMCwqikNuPmD03PzsmTovh0nqOCEuguW0yQ+fojqNyJk?=
 =?us-ascii?Q?BHeJcmOQ4Z5VU5sKIO0fda2aU3uKFqPiZk+eY492LPMqTDNpbtkF75oArOIY?=
 =?us-ascii?Q?os8LrFsHHhZ9TV69da7VzTvRhm3JbKvMb4y9ysYybyJjduv/yIZFeTXhh/rn?=
 =?us-ascii?Q?A8C36sWlZuahxdA3COSlJecxIxsC6QQrXghq6Ib4cK5/6KdVFZ6zGlMeXcJm?=
 =?us-ascii?Q?UHBRmDc7a67p+GbigOq9XAnwnWSbckwsv79tDerhtF/qw0BYR6R1S4Tp65Aw?=
 =?us-ascii?Q?I94FWsZx94LTx63XRXHxeZWo3Le35M1aTFAI1ZVgFGTWOjju0haUzApZZV04?=
 =?us-ascii?Q?QNcU/pCR6CVpXOyv3dsQAUSGvMrgPWwwg1WUv/1er6pIreI66At/suRo4VLq?=
 =?us-ascii?Q?dzobwsW1tk/sAsmcvLHSKpcROn+Jk3wt5H7QGPemC21+sl25SYppteDzuPs+?=
 =?us-ascii?Q?NhGWh3fE4pqDCyiR5bfYZsMZFC4QDtGOQ4QJ0Do9tKwuGtW/JvquwbeK7uvC?=
 =?us-ascii?Q?yORKEh9vr4l8LwMcUQHXsH54RIa7I0l3D0cvVxKZzi0xLcmnsWWl2rzZpJfd?=
 =?us-ascii?Q?d1oqHBgJHhtalMUwrZOjihwdi8EEykKjiCTxFGkccQTQp7Xkb8t9zxtBqg3P?=
 =?us-ascii?Q?fiRvaaJaKlmXFH0fqzzvYU5VY+mymrUSBd+aE4seQLUM6Wtj16GHLuX0H2c8?=
 =?us-ascii?Q?9RB+3N7sdg7NzxJ6GTdhYnljYB9CeIzvBEJkaFroX7yaW2oB5jrKeNbl7cfb?=
 =?us-ascii?Q?ms8FWnJgSeFZI9He5GXfhrShpvWG9LlR3lsjP0Cm2nYuuJ1iEq42NxvvIBJ9?=
 =?us-ascii?Q?z8ZuLsRX77U2VnS3FgQFXFM1gaHfO1fNg5MD1Y4IaO5LDzUR6ifEsroiu/rX?=
 =?us-ascii?Q?ncQHLr603K/RcOOOgJRsdwsPCr6PM80G+D+B79e9mcSAdBHqczkJGX06NN6x?=
 =?us-ascii?Q?EmDu+UVB64oxtEosX2XNEe4/RAQSfnR0VYaVtedaAFPwcaUxuxA8XlzmCAbU?=
 =?us-ascii?Q?jTsegTdPGeVUaXSn7L2IlNTnVf8fXIUwPohuAeDpGTmeJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GZonevanW8yqMXGnIKubGPPfQWvYJ3ZHs8Vwh0hL4DkUwLFxDh+345POFHU3?=
 =?us-ascii?Q?DN98iL4zzXq+9dCUDcUPPnErVQLp9bMknxu1hnIzKuNHKX3LnavaVUnCD9TA?=
 =?us-ascii?Q?0SdDm6jsKFOk2jPN71EfhlBVITJB1HI4bVJHQ7wDFVw+n7u2FLzol2pAQVq0?=
 =?us-ascii?Q?Qbdv4Dee701EO4Ci2d2oyFkX+4ic9z8fM93b/9OoekTrvYpCzg6CLTK4lDOr?=
 =?us-ascii?Q?mYEf4P2jlUPNVROa4Ta1GKy+lSFBqAN/JvJX2UD1o9+PWHtNTKRCd03+OvFL?=
 =?us-ascii?Q?1FBfIRZwvZqL54pb1TJoBAd92BpEWzyt7r4oJzlM6oz1IlI8TacCO+uJe93P?=
 =?us-ascii?Q?d0QP/9Pul8w52LsjHyYTYQesqh0BQ/XoFHybDtQyptw1tfcaac2rEidAET14?=
 =?us-ascii?Q?v0tqhGqLyvT2mnqWrDtrTQpAOHE3YdpforgYjQ5Kb8hVbmt11wsDccUESSPX?=
 =?us-ascii?Q?muVaZ01RQ3K3I8gV3TL+YN5kCtq9bLX1mwzsZsTpSUAs7nzs8rlo+xqylkQK?=
 =?us-ascii?Q?gGtPNzww7XROAJ9QDzCuP2CgAZpi7QsROpkxlkAVe/jPETjQAZMEXh07lJoG?=
 =?us-ascii?Q?0O8uTYCf+E/eCPZmuBozbExSL+VQKjnQVf0o+SZj792WZoJ9VkxSnQxXkGsd?=
 =?us-ascii?Q?ebV1YMy1aeu76Ni2rUBLClSargCBwGM4jZ6bTJJzHqtUiao1kjcJRjJ3/xf7?=
 =?us-ascii?Q?EJL9yczEryLVD1yM+bmKoIRJhFZf7niUINBEX7UBS58nSt0thDKUNe8vOKKp?=
 =?us-ascii?Q?zoRKuq77+9owyYvCt5oac69gzRpBcLcrrHz/H3oss8SAimsOtMRs/AaXprw4?=
 =?us-ascii?Q?3QlHbMv0DCCoOKewC2qCFmtuAySRzkzp5whMAllY+oNW3m5qwoHhuARwgLiD?=
 =?us-ascii?Q?kL6sP++o1bcGk75S2//tpTWJnJ6V1PtyQtLo7MGtO7b4lGnzsSk7B1G5RDmR?=
 =?us-ascii?Q?sJm+JoDYPINnKpgyigEg7GEm2cU+/zAF4Fd9hfNJTvkDJjujvXU4+zQYP37N?=
 =?us-ascii?Q?VRlznru+3H12Wx21Ab4zRpwRyWSajfGtkG9Kp2O75GmTvzYJLNKAZAn082MG?=
 =?us-ascii?Q?1x+iPn0YEQlJ4iZueUqlMwXF3BiN//dlmZF49qo0zqL8ofC/qD+ISl/r0/7G?=
 =?us-ascii?Q?Xe8UOAu01R3+0tmpX+UGP1JMTeqHkfk5OKr9J29WYwyVk4Vdbi6aydacEtKU?=
 =?us-ascii?Q?s0h2vYkhYMaeHvK8nMsLJyZa8f5O23UXI1FiYVjg6OKiGZzkXwgLvOTb4iZH?=
 =?us-ascii?Q?KgCU838r+OqaE9Y1uXMvTXFqJkcPVGlUo4A5aaf2B1jg09jo7TF2ZtanB8Ys?=
 =?us-ascii?Q?t5NuxO7iYJE1rNZlBA5nsjFw9/fl0zPVUidxBgHC0VjnH2OnpItTE6947Hmx?=
 =?us-ascii?Q?WV/1IZ3Fa4yw5EgCAiySDXfKA4eX19gnBrXdAyEuiiJgf4zeAwfG+7fOR+I6?=
 =?us-ascii?Q?1AqUtRWqJaj1QKZzqYP4izFJSOSkXKxPb545SD/GIl8Hmkf7JnMvKvi8yjd/?=
 =?us-ascii?Q?dHB5RmZZ0pjZaw/4j+jkcbyVagAXhIYn/0O8JT4mqPIs7yVbIDA8N1hUW7dK?=
 =?us-ascii?Q?pwgOoxD4GfgoDUfykG7OrHMcl9M5dF1vnyiLwGP94c4va3+phq1UMD82HaWu?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329b2c70-82a8-49dc-12ac-08dcd7e1cb4a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 12:59:56.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6c6YbnsjNwD0UEZ84Y8aYHEJLXuj7UkbnYp36gZcUdJg+8cfdtwZTz4QfF8AdkSFk7Fk+4BGv0UVHK5Gx3bKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8132

On Wed, Sep 18, 2024 at 02:48:26PM +0200, Andrew Lunn wrote:
> > 2. I honestly don't think that the workaround to wait until the routing
> >    table is complete is in the best interest of DSA. The larger context
> >    here is that one can imagine DSA trees operating in a "degraded state"
> >    where not all switches are present. For example, if there is a chain
> >    of 3 switches and the last switch is missing, nothing prevents the
> >    first 2 from doing their normal job. There is actually a customer who
> >    wants to take down a switch for regular maintainance, while keeping
> >    the rest of the system operational.
> 
> Do you plan to use hotplug for this? The user interfaces disappear
> when the switch is removed? The kernel will then try to clean up all
> state for those interfaces, removing them from bridges and bonds etc?
> 
> It will be interesting to see what happens if something in userspace
> is keeping a reference on the interfaces, so they cannot be destroyed,
> and then the switch is probed again, and we have a name clash. I've
> seen USB interfaces not fully disappear when i had a flaky USB hub
> causing disconnects.
> 
> I wounder what configuration exists which is transparent to
> Linux. Hotplugging interfaces won't deal with this.  The routing table
> is one, it is a DSA concept. You will need to change the internal API,
> be able to tell a switch the topology has changed, it needs to reload
> its routing table. But i don't think that is hard.
> 
> 	Andrew

Nope, it won't be so complicated - removal of switches would be
initiated by user space (in turn, by the user). For this use case, it is
known ahead of time by a few seconds that a switch is going to disappear,
so regular driver unbinding should be fine. Later attempts to rebind the
driver to the device should fail as long as it is physically inaccessible.

Side note - there is another related request to take down a PHY of a
single port for maintainance, with the same simplifying assumption that
it is known ahead of time by a few seconds when this is needed, and with
the same requirement that the rest of the switch ports must go on. I was
planning to handle that in a similar way: user space puts the net_device
down, and it cannot be put back up until the PHY is accessible again.
I need to submit some more changes to DSA for that to work (phylink_of_phy_connect()
done at ndo_open() time), but that was much easier compared to adapting
the outcome of dsa_routing_port(), and thus drivers, to dynamic changes
to the rtable.

