Return-Path: <netdev+bounces-130109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A789883C6
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A64B24FD9
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E00187334;
	Fri, 27 Sep 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WV11MdzI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482F18A92A;
	Fri, 27 Sep 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438445; cv=fail; b=i+VfQFRoQ4zvuRtxS4a2+JbyVYW81TwNiI7Kf/FXyjnKzKgygOHWB9tK0Y47RQGUGKUimf+Pvi4aB2DcAkEpuBLhiyPhH963pYU6HWIxgQ3cvNNGmaMBBvywtQ+iSzBLrPhs0/mc3IAhQT7PzGPG0pj9HSbxtyfvIht4zAcjjys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438445; c=relaxed/simple;
	bh=hU26tft9jpAglfNqsO5uyvNJn74pCh3AJaLk1iBCEb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CuTgt6OWtf7Qk1jUWxTgb/JAJyZ5gkuot7gQIbKLTp4nkQpIBLxgqE33uSuwdGbaZ4SC9wiIrKWS5oHj22n+/9YmdKGc8sgPDehkC6NVwc0g3n3mKQPt1qY3cID8C+zEk9EZpovfet8iCyxIoNaH/cnjLCE00CG694YcgkHa0+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WV11MdzI; arc=fail smtp.client-ip=40.107.105.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgjdZRo8hjekBNKq/n+twveo3PKc3WSSJ3/DiYaA1LCoF4Jk5na9QobXpO5vZ6LNXnjfMqm8e7oZHO2gqrSri31VuVXmzUABgf+PP24Za04YTNBjq0Lf8/rkEo8g/vYcgS7fJr80NTOu5HStEHW2o0hlbUFVAzn/7Pdl5cURfNWtYCgWZzQLScaKA377x8gUHJ09SzX/sMFw0/4Pn1VKO4Af5dDWp0M/EjBUvCZ0raHJ5ZwNbJU3ssVPxHmmGwYWf5EL222zLA+uioEeie1D2CkOQgIVqRbEnRs4mepxycYGNN58cLGJDQHKBAdHbRCgzZbDAC0MF0AIJos3CpxJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXNrh3WCMysiptBnGVp+/n6ab30LzsouVVxv963lwpk=;
 b=Pp+ohL+JVwSnNkvkVsSfNZIOo2sC4hP/KmLh3Ejq2fe0Yo1igQ8ocyFgIfX4C6VdekxhLqqvRvnW5m3JeErbZM/H4gcsn2tR1xHOwShGMK3tfkS3kCNlniXJWjcYn11hbqgXn5nGoDa6QbVmsjMmF2zJr93/bsZ2iC98PuqZVqmqcionM/1k65JxlmmQzmfW5E+eoOR8FBX+6fGhz1VVjnnIplLqLk2rCHcU9bx7gx/EqCRGpGmpPtA5mmXMGgV4JM7xwFehMOCpLKr6zIHqTi19KAJb0GSzVqNjhWrc5F8nkV/LJ7jaypV8ViBffNS0kdzv0Hc0bgv7R2tYZ1VjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXNrh3WCMysiptBnGVp+/n6ab30LzsouVVxv963lwpk=;
 b=WV11MdzIsmHxV+SMolOzdF8cnB2S2avKPOVzJVNZbRc+T1RoVVHnsWeUZjlq2CZGH+Yd+SCqKF+EUxFGY3Wno2Hmr6LOpdxLvXDycUp9EPPOZXMvUzOIRvwM2B23dxwAZ/dgoI+Rj9NRGMD4qWDdplsX9yXvL80x2b+zytXO3BSR3iIVCUujQTUa3Ek9v9WMoo2H0w77Pr+SobQjXnbPPbQFjeZ/fArRqfgSMUUM91B9+ouRG8sCOclmkRZXIsybOBNbyb+Sqt5T8Ttb4DySlDyaB+aue0lwmcaE7L8/EaByYbaEnUPSC54YayF55oJ84kfMYzxut8ZRDp2vwGAuXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 27 Sep
 2024 12:00:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 12:00:40 +0000
Date: Fri, 27 Sep 2024 15:00:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: Dipendra Khadka <kdipendra88@gmail.com>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <20240927120037.ji2wlqeagwohlb5d@skbuf>
References: <20240926160513.7252-1-kdipendra88@gmail.com>
 <20240927110236.GK4029621@kernel.org>
 <20240927112958.46unqo3adnxin2in@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927112958.46unqo3adnxin2in@skbuf>
X-ClientProxiedBy: BE0P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bba985b-de7a-4b9f-8325-08dcdeec01bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GxzEQH4rk3/tk7Npie9FdXqGiZNGRDdhrOHhsNG5vwp2KUn6bgKO9T3xW9uY?=
 =?us-ascii?Q?FFMoE46qDIFRenh6xcmUUJlMQd3cIfBN9RlkqUaeS1wJNsPFm0kEf4zOK0LH?=
 =?us-ascii?Q?e34TAmyjby6KZDOp7aNlbeDBRewNbPduF3KYf4P6sVUInENylJdE4ehif159?=
 =?us-ascii?Q?2osQdkERWDDy9x3C28U/WaHcvbNTPNhAESu0DReApX0LIOPLx7KD+2zVWFHP?=
 =?us-ascii?Q?OGq0Y7/BxBKpGTq6pOoxhKiitL6s/A5EUo+st00IiTOe9h99GVfOozaiw/R8?=
 =?us-ascii?Q?WY4ddA6uASqNAu6IbqMKAea/LEWGMYIApCTdTMHVTQjg9T77FP5AZuFpVC8E?=
 =?us-ascii?Q?rhuaEfVKbs22QZ42fgJ+FO2MfzNbOCaul59F0blYh9iryZ73QrFV79mokNx5?=
 =?us-ascii?Q?2VSBBZCmuf8z2xY2raDHlO1X3FPtgKJTZcEmrhDppWK693s6zAHbvHfS/qJx?=
 =?us-ascii?Q?W6Ol5xPNrkzlcMsSPQM18dM+MFUUdgWILYocYkEAD9KgVvcIE03jyhxDfwP6?=
 =?us-ascii?Q?tktpuftZZVlBCniEdSHNx4kISHoIog2v44fGbloyaU66rtBr9SjGE27r+pNQ?=
 =?us-ascii?Q?pRRwkHIe8U70TishD0ce0IAHAprxvFMSS5gxFYuKZU/7gC2fHn9WUVHuSGrD?=
 =?us-ascii?Q?jd+K9fld7HAOoXMqnO6eOYLrhu2CMbhmRWCvTfhEndG/4W2mDy5jsAHyAw0U?=
 =?us-ascii?Q?hh6Gk03dgiDez4u//pARUcri4gRFcPCDw6G6+ElIl5bPrJowKedx/IP99IOD?=
 =?us-ascii?Q?ksoRwufA26nk1ciUSzpTEfbjGLRa1ul0uGCrEdzVdS4iTppUkfB6V6rO966J?=
 =?us-ascii?Q?nnjntcc6aE++XCagiEJe3nAGxp/I0pgn7o6OrikYZUXWdmbVr5J8ex9BzjvE?=
 =?us-ascii?Q?uWpn7LGS1YNqoZHd/kt+6lFaZFb4GVj7UT5+I6s0GbO2rKrdlgTm4SjiuS8E?=
 =?us-ascii?Q?iBtAFUziRlHIoatYrioXWazG0DhF6qNJht0nBwWk2P3vpiP5rL6zbwU3N3rf?=
 =?us-ascii?Q?/7MdoCWVTc1Y9sKNx5kzaB8e0ZtsiDbpzxKMOQkZjxm5US3HpQAOVT+9Ow9h?=
 =?us-ascii?Q?xJ5fh41qFvq6guM7NSD8mfK4nKdt5PCNhPlHMWk2fLIDHSoapeSEWXoh39Of?=
 =?us-ascii?Q?Tydto4XbeMGB9nxGC2kd/zGGmQF8WoSFLzdvm8UBcv4Db+s9FBxwmUBiBcaL?=
 =?us-ascii?Q?+z80P/K8V6yp22VGC2XkEWrIFqtGpc9BNS8iQlBYQLSrkQXgod1VIzbh8CAc?=
 =?us-ascii?Q?4cjL/DdYeKlU5BotFHw/SRPfIwQp9KNOeUG+CnMBAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zbkku16pb2uPirAlvZhAsle/hv6eSCWcrrz+x0PjOr6y0RDMVWAMlh1LFjHV?=
 =?us-ascii?Q?2yNqoSeE+6eIihMuUuiZ6z0uPG8eUJVIvfD2chtiLOnb7wx9ZBKIptbToM+D?=
 =?us-ascii?Q?YxrQ0IB5MEG7hwi6ioGnh1XPq+cP8LabMQt6dm6JO5NQwCUFO5MKw39hwCUQ?=
 =?us-ascii?Q?I1k1XKBwlmtPWP9RqYuc3wLqKixHBQnWlAhhE7lPa/G9RGvv61aAlGaPUn1L?=
 =?us-ascii?Q?pO43LJE5ivO/CWbG+gzMelA8bxdELop7F9qWueoUqVcMqY0a4yEAyPMah/to?=
 =?us-ascii?Q?caXhyUFQ5+sujjC7v18RE1CNOhZHo2Yi7LkATRRw2zFVUxGPRvVUBvUWm3Qi?=
 =?us-ascii?Q?hRdkXceffE3UCtZGEbEofWfMGMVRjxKIAOu4XOFOZLqULcYwnVQKS8nCUkTk?=
 =?us-ascii?Q?ztA7id4snHuym94urJtRAkpC7Amw2aHCWjAiT8ySUhK22m/RP8GpZV8iPmOm?=
 =?us-ascii?Q?pxsbxGQkC+9bJqYnSDC8NZgdadViV4Y/3tc29MVZFKYcDDs/NNVvDGjualyP?=
 =?us-ascii?Q?U0zCVmHdksDI5TMVfkZDe9mAmw3qIeK2cIi857bH4A5nry5T2kAmAddk6paJ?=
 =?us-ascii?Q?UmqEkNnEyQQCfFyexSeio71IoMoRAeI7EYEdExUvJSuD0+1mkTwJO0tZa7Dk?=
 =?us-ascii?Q?zmtiU2UUr3t4EbkciAnoExRdYgZz2rNRBQpRFGQ/vsDo4vekajDuJhA1jPLE?=
 =?us-ascii?Q?iOsBCaH/5SYpHpJkXaAK4j7v39ZiJ+vYZaOqJBJdY9Jj16n3ntBNsOMTSnQT?=
 =?us-ascii?Q?cw9MjkuKOrSD9ZS8hMbCHHFtaC3XeRIhmEzvzX4gjpWU+eyHy/PrjyR1743T?=
 =?us-ascii?Q?SgdSiWwSJnJHyk+w+Yei+2jY9JVWUB6IwFCOMw9eF+qMcmJvIUw+ghBoZ+0s?=
 =?us-ascii?Q?fCkHUEulYIjaM9lLDXUz9D7oohfpOD68FABMJsPm0q6jTDJE2UXanWetTq5b?=
 =?us-ascii?Q?U3GqfbJy+Un0QkZhUChd0Tdi96VnSgTv4KwEjc7HL9085D9BlnpyFEx18DiV?=
 =?us-ascii?Q?rDli8qJYevbFBSDmlShchJJLLQh/IEf8vdyvx7wvw3FwVN06Lor2AVBydhsS?=
 =?us-ascii?Q?yIs/XKc3mZ7SaWiWNPIADVwPZCtt251uFeifhvYJeqGlOGMN4+pPFL2lKHhp?=
 =?us-ascii?Q?MAzMsMs7PMUuR6f3kCq6j/8hMLzzhNAYJM/YMmF6gE/W0scMnB+KNI+QXHY9?=
 =?us-ascii?Q?i7Fi9KTfHFv+9sTK+FWCqYtt+i1agABMphEscEok8EIH+JiMkxWc39ic1l/C?=
 =?us-ascii?Q?WCONaM4zyOjvz7fUoHGnGdRC2QVmUI3Sp/0ZFp5uqwee0gPFRRi9qJtYPiiT?=
 =?us-ascii?Q?hHb0u+2ujQEW7SQVFNbZqpgC9C5mWsKCWOZoTMuLtc1lpNlLx9bSK6p2GW8H?=
 =?us-ascii?Q?LlFHVRsZNbC4zbtcUG47EtmsDtiGh+r1JHy0yPOOdXDwoKcmYuvaR5LsPiMC?=
 =?us-ascii?Q?rdP0t+6FXPidLyapbnVbJJtKnJT1bajsIHcIMA4+cCtIJjtATgW6ZvbIPVzg?=
 =?us-ascii?Q?BE2BoeVT3A0w6Qya+hvHaC2eXDBsIeOQskIjCKigNrtid52EY3DVCjdhGcwK?=
 =?us-ascii?Q?QwBku1FB3ZzDme2N02O//adY318+0GxFn/bUbGY3GBzsn2rimLwjtnZR+sO5?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bba985b-de7a-4b9f-8325-08dcdeec01bb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:00:40.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqZhwh0DYGhoJdK4hoZdm1DRLO8QT6tOcxyQ5kEw3kudDNsK+euY9XDIpO/V7fb8dczgGnVpcc+81e7hmG0ooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774

On Fri, Sep 27, 2024 at 02:29:58PM +0300, Vladimir Oltean wrote:
> > > +	dp = dsa_port_from_netdev(slave_dev);
> > > +	if (IS_ERR(dp))
> > > +		return PTR_ERR(dp);
> 
> I don't see an explanation anywhere as for why dsa_port_from_netdev()
> could ever return a pointer-encoded error here? hmm? Did you follow the
> call path and found a problem?

To make my point even clearer. As the code goes:

bool dsa_user_dev_check(const struct net_device *dev)
{
	// This dereferences "dev" without a NULL pointer check.
	// If the kernel did not crash, it means that "dev" is not null.
	return dev->netdev_ops == &dsa_user_netdev_ops;
}

static int bcm_sysport_netdevice_event(struct notifier_block *nb,
				       unsigned long event, void *ptr)
{
	...
	switch (event) {
	case NETDEV_CHANGEUPPER:
		...
		if (!dsa_user_dev_check(info->upper_dev))
			return NOTIFY_DONE;

		// we know here that dsa_user_dev_check() is true, and
		// no one changes dev->netdev_ops at runtime, to suspect
		// it could become false after it just returned true.
		// Even if it did, we are under rtnl_lock(), and whoever
		// did that better also acquired rtnl_lock(). Thus,
		// there is enough guarantee that this also remains true
		// below.
		if (info->linking)
			ret = bcm_sysport_map_queues(dev, info->upper_dev);
		else
			ret = bcm_sysport_unmap_queues(dev, info->upper_dev);
	}
	...
}

struct dsa_port *dsa_port_from_netdev(struct net_device *netdev)
{
	if (!netdev || !dsa_user_dev_check(netdev))
		return ERR_PTR(-ENODEV);

	return dsa_user_to_port(netdev);
}

static int bcm_sysport_map_queues(struct net_device *dev,
				  struct net_device *slave_dev)
{
	struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
	...
}

So, if both conditions for dsa_port_from_netdev() to return ERR_PTR(-ENODEV)
can only be false, why would we add an error check? Is it to appease a
static analysis tool which doesn't analyze things very far? Or is there
an actual problem?

And why does this have a Fixes: tag and the expectation to be included
as a bug fix to stable kernels?

And why is the author of the blamed patch even CCed only at v5?!

