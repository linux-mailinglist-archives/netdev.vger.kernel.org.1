Return-Path: <netdev+bounces-242301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CB6C8E8A8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 061684EB320
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E32868A9;
	Thu, 27 Nov 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FQ381jcZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223C5695
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250947; cv=fail; b=kuNt2uLtLCMFQvshIuehuRjXeWuKBciNfYSYIPWnm1ifkWSbt+hpeP3k+xb1XvWRQqv5Th9PrROfLSVR+QlsZCtN6Ts1p+Ed0+wPPHRVvGENTFEYOcVcPduSfPlmfrtm7AqTT3dBhgALbfLnxIRoT4JQCdU+5k1jtzGtgoDu++8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250947; c=relaxed/simple;
	bh=QylXXFDKP8QWmBucuKTWoAHDWf4xFQ60TPcwniKLBZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YoHfttPFtqqPvLgKtyOA23euOvKZOiD+EcXw0a4QcvJzKbbsYcm0E0PsKrMVagk9Ao5B9vuE5oHtTZkvppy1/g/SJ/qmB9NUCRy5SOPOo3gr1ZVSSRKf3H3B4bcaxoM+nwsITUiTvlFv8DjZnjy3RsisEFZ+Zi1QoPJF64qnNio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FQ381jcZ; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX49ckt4KmHDtwfXniC10Kg1MXRgq0izUmuR1dRJSg46hYDm0H7MUCu5HbI11WZS2b5akOeolBeuE0gAlfoiURP2L2Cqt1EnfnetuIqWUvdbXR1+9O0xzzPQOze2RQ5xfuy5B0GEuoOnCqCEeXtDwURsjENYgFpG2/m7dtNsDp/qJrkNkVjdEjHtTFT+WqbKJcxmTeEGnHi1au810GqL8BXnrNCH+c7l5Eo+EapxX4CC5iJgVLbT6jLfmgqB7uHgs/e/j9tYSVmKG1C2Ap6uWfFGYc1m4klucp6eaaJX0jJ7CDmiF8nGVJZ9AXpenBaLQym6psc0OUjqL5VdTE9NVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2li4na9TXtRidw7uL2iPdtXHsrczI1oo/Qaf9qPvaTA=;
 b=FX/3PZXBswpX+zTfDMlyHaRIfhVNIxaI9+yBX0gHwo28beWI62Nxz+lMB6UsVnhz75nlbwd9oYV9wEq1tne/bdYEBrJ2v7Z0MQ4lJ4O6xOjBSiWFmtf1ssKyW2enMoAczOqzFFSpQj/kOA9Nd8nOojZuNQsKUxS2o3U+vj8vYu85Yq0CNkLyoeVVxXjOiFpBHaZFJ1RId3CsQbM0lLcs1/ITE0sZoOlAQDA801QDP3cYFHVIBQ8nDFGIR06Qbar6QGrwBiQUw+H7PT9DFDFdgBnrAVhXRTuBb2k4g0SD7qaQHtBR/QxZajotXBjKl/hgyqJ3r60gch+TssmkIMOi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2li4na9TXtRidw7uL2iPdtXHsrczI1oo/Qaf9qPvaTA=;
 b=FQ381jcZzGHItr3mBeGNdiEyNZRMujE0oqieuUQYWcoxRsIeQPvjErLKIV0apT/rUrFa/YSIukTO0+7Kfbw8VK8dvlbWYvL0G4L9zAz7FEE1mFuaoYdUBIYsF4g3axgT04juWNjQjNERVw/qfYP/rjCHwQ3KaOCTn5/JkwprwrmTkJKIlOo0PE5d5/SMb4KueQPx0EdKaoUIQ5lq0PRJGLIPOQQjcdb3+n40n8SVK3TTGXyZDcGnjZjY+WQvQo+1HLueaqQrklRru3L1U7bu41X+8/4qKWkMSr+Ib3KCk83E1VLXw7J12hp9Q/fhFxeCLJPFEgNdskLFNACqFiDt7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM8PR04MB7283.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 13:42:16 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 13:42:16 +0000
Date: Thu, 27 Nov 2025 15:42:12 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next 02/15] net: dsa: tag_brcm: use the
 dsa_xmit_port_mask() helper
Message-ID: <20251127134212.wh7d7djiv23lyv2e@skbuf>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
 <20251127120902.292555-3-vladimir.oltean@nxp.com>
 <CAOiHx=miR4JAbnYeRJwcHowgBUmvCn4X19syCxuwk8N7=xAXRQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=miR4JAbnYeRJwcHowgBUmvCn4X19syCxuwk8N7=xAXRQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR06CA0184.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::41) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM8PR04MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: b6448cf4-8c35-42df-cbb5-08de2dbac6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pwyupqm+sS9rnZxTdd6dekm47qbt3SDDtaYKkbfYySNY5WpB4mgbpnSXHZkN?=
 =?us-ascii?Q?3nI5X5uiVTVH9vf0Ea1SGr8kJOg7iYPdFs1cSrDLE1+84Rrx6KZr2aCfJvyO?=
 =?us-ascii?Q?oDpQtR93+Hufo82m2BTDfP6MmGw686oO7v+OMEXwxFyQV9RSa0m/nbxw6M+R?=
 =?us-ascii?Q?MBN1LR21T+rvOwpYbyTzhrtqYbpVqsWkUC+QIhXg4S4A0mImkLnenfH5OFG7?=
 =?us-ascii?Q?QYpnyQHH8tvUtuxD2tbhKC11k2P1sxaprfzLE1hD4m3a2k3txBWoVOICKVf6?=
 =?us-ascii?Q?iOM8ZcVkc1rfa6tukRGofzUMoZaFsva+aIiyhVW9cx/tDpLEDzSYnzFbbAQc?=
 =?us-ascii?Q?tpFpYoWFAj7s4mGv2nLSUCbov6xe+BN7/WyJCwS+kAqEyDfQshqWItgSYR1X?=
 =?us-ascii?Q?8G3HS2msBcM7m0o5e6wQvFNQwJtG8gzIl0QnxonO4TUcRnkqG9QlEVV5i4Rb?=
 =?us-ascii?Q?+y6QcaMgQErPZ4M2/ozSm1qVoifAv2PPdOXpp/nKAXbkXTxsj+47JVAdO4Z0?=
 =?us-ascii?Q?2RLuzfK734LBbR7ZdK7s5Enq++9QINZiAQdnO+SWCIeC7j9gKV8W8Hiwh8SO?=
 =?us-ascii?Q?1NbB9HQ796C/kVDkPidsc10BJ7kEK3eUdTlTv6K0rXvyM0g9OUuYX/8a0V44?=
 =?us-ascii?Q?bH0q+TzK8CMY5aj1odynRDMd+XXF9qWGUfu9PDCrDmUYrXcp4qOfngL2++3d?=
 =?us-ascii?Q?y7RrICwMoGTP+b97DlKK/x2JqWWMNwJFCMDcrjvnPZkVIvIUKmycO080jrZw?=
 =?us-ascii?Q?LC6CrS03y+hIP/GT8zUGd0WMjTasZfu9Lu1SEzdNsGEogD51RDkfhzu4U1th?=
 =?us-ascii?Q?kDW7VJGVnfX78Usxa+vXHy/y54C5Vu6UXyoeN8eR3MZlrMGm2+4kB+GfZLwa?=
 =?us-ascii?Q?Fu/Y3HnW5ebwH+HyuTogsmD68osfTteE2Q43o8AdKK54M/EZI+Q1ZLuGoeup?=
 =?us-ascii?Q?PQrsaC+pfQfCWl/3F5Eg6MrZuQAc8MogpQn3VsRtKA3XHFGjRuLO5ig9X67H?=
 =?us-ascii?Q?Df3PrThv7knI8zwmESdtdbbnt/WkNuW1RhjYmYB+NmTOyp7wfjJuoM4oRhmR?=
 =?us-ascii?Q?PTUUCdUnnBhsYTyIo1h/A30ZFf4S3XDluq7/KyxTq/eTwIUAJJSXCh2+Ohga?=
 =?us-ascii?Q?rP5u4OldFufXmCONjiZF1lfD1Wy1NWG1vuxSgfNVe9MF88OOJEZq/Am/T6Xk?=
 =?us-ascii?Q?g8eLVCJumzje2K7oWsXZ3p+BCdTgXJIvOCxhA8zFbY7Q5gzrieRgY840/yb/?=
 =?us-ascii?Q?kH2e5X45uGsyopQCvVkj70pmD8247mE9kR+jRscO68BxFZQkOVc/WzGjyJ2b?=
 =?us-ascii?Q?80vWHIn//+QD60GT0L6ztRvjIXEkiSM++NBNhRXlj1X8Xb1kNMiwUdIfClaZ?=
 =?us-ascii?Q?b0abMi5OrlbvyIZsO70LaoM7vrpE4rkHlTP0gEFVdQO8v1K/Ys10HcYyrCRH?=
 =?us-ascii?Q?wz0uuXyYYgrg6A7wAT6c3HiJFQUqd8wh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7W6on8sueSbGpDZ0BJ66dVLxlQjsFMdYkein6az78Xz81nzDFDWZggmYrVU?=
 =?us-ascii?Q?OCx1/4U6vR/LaUNFAFoZGUZEt+wwkX1hop4wBRoQ+Vxc26GIjDxKcOwlvTpv?=
 =?us-ascii?Q?sBQoiKJk5sajZHoDR2DR6iYMm9/BMr/vQQ22ZBBax1DiAcMJoVyvPI25JrpG?=
 =?us-ascii?Q?93lKRki0/Ta/QaMp5rjKu7HF4F98/QivowHIL2hu+fJp96DRCPVjtcYkwWNA?=
 =?us-ascii?Q?dqcCuApPpO1p4IgAytWuIHPpKJkYsuSPGqDxWT3EigbBaAMk0raceS2s3wOj?=
 =?us-ascii?Q?a/lkYSuCCAdKGDlMLAqMkJMzjMkKshvoeezgoAFphDWlrzY1JS5ZLWvLJ9uz?=
 =?us-ascii?Q?OJsMRyN+6cVzasaSwl1n4VOzIy5NAwzrp3DfqsL7nLiPkKS8xQSU2R8HhYka?=
 =?us-ascii?Q?hlbXq5bwd07pKyJNNDhHgrJ3rNwbkVKMhBBpVZ4R5aYj0amqh4J/h2081/qR?=
 =?us-ascii?Q?g1NVHB2JRrOR5VUZxM84mk2S4qtnGC5BVia+LO1FEY4o1JPsvhds+d5EaMHi?=
 =?us-ascii?Q?5PzhuP9PqWhiBvdxlBMEdarKqI5mFCX7rjJpFrOKt03mAk33muJHhnV8hF+h?=
 =?us-ascii?Q?2aF1RdCEEm3CoZx6Q5fF7Z7CiGDeJtCH9SG2cBHu5xa4QufhLKnXlje+h24Y?=
 =?us-ascii?Q?veBUA7kGsPqeYS6yyL+njzf/qpDR7Dy6Fn9Pk1WU6O4oPqWRtPaW9K9+qwxD?=
 =?us-ascii?Q?JIIChjKE6stSCnm475opYIUPxwcBkD/rsCYHMqhLocsM8qCBQ73NNx8wXNbo?=
 =?us-ascii?Q?kejyyEH/xqU7hd1/+YnIk5UAqcPegbGdqR7cv/YWjzJNlKk/mblZeCAm53Kh?=
 =?us-ascii?Q?v5XmMSwMvzt9sFWcbzGJhp1IkMwsPStkJu6H5AZgv4gA5lvgmQs/kW6egt+0?=
 =?us-ascii?Q?7OOoKxvICSY/NJ6hd8xWU+7pvvI9wiCt+hZYI0cqJDlDZLYhOQUOl2je6v0/?=
 =?us-ascii?Q?QwHCkuWUPlnI89WjHHRqXHa36YaBjk2awHqAK3IyMZQrpnb4fXTpkxM2qnOs?=
 =?us-ascii?Q?sV6UIbEJqxpihR97bwIzhqx2CFV4CHEDxdZ6hxCThVXant1oQxyKmcEnFeU3?=
 =?us-ascii?Q?C4pVDhGNj/iBEfyFV1v9rHwr7xG/UeU4yL+yK0HB+9xi4Px2zJY1UtE89tH9?=
 =?us-ascii?Q?TwM9e1A5RQknzA6j1lT6yKEiD4Ryc0As5LuXZ8vj8mKRLIGRjbxbWoHc+xWg?=
 =?us-ascii?Q?aiUPWVGu/Lia1kp4g9L8uAKorc2icH4H4JgJdZPIgSWz0PVyExZ6MN8ktNoM?=
 =?us-ascii?Q?d4yCJyOhknPT/xEqH2MNS4114TbMy59dQ5rqKZDWbE7kizhInzdQ7zyc/QiM?=
 =?us-ascii?Q?f+U9F/z0JdQfPO1I8BiRctZ+Gd5CyDvXXRkYFpdP2leLFBOBDYZrGLy6j1T6?=
 =?us-ascii?Q?Lk8nudKNFGe+SIRSukewYJ7xv6hxyvcg+pgDCKbC3HKcntRXdYrZHFAYP6Jb?=
 =?us-ascii?Q?np3MW2QyLPKia9hv42oKllIOeAV1Q0C7/xnu+YVA+AvxCbIkdpENIEGWKqE9?=
 =?us-ascii?Q?stFV9RLxVGUlPEmQTxrynz2ai2CAjWGPk4578qA7f7FrMBbEEkLd1LkUzk+P?=
 =?us-ascii?Q?CnhF2XOJWr8+1yy9/0XeSPYacQmwVksh+iAeRkES8qrjeAyTeRycbnXpWEdj?=
 =?us-ascii?Q?MGjUoFTQ33g+5tuxA4320h8AYAsPus+tzgUUb3ds71OyGRpk01HxhQwDHCQy?=
 =?us-ascii?Q?ORZ+og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6448cf4-8c35-42df-cbb5-08de2dbac6a8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 13:42:16.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lIl41T9ykTY93n+AMEACxNXlaDoAoDUCU8q2JP7IdhJGLPi/pN+6lRo5E0odKAcaytxD27opU+1Dvcu3iXg+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7283

On Thu, Nov 27, 2025 at 02:29:27PM +0100, Jonas Gorski wrote:
> > @@ -119,10 +120,9 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
> >         brcm_tag[0] = (1 << BRCM_OPCODE_SHIFT) |
> >                        ((queue & BRCM_IG_TC_MASK) << BRCM_IG_TC_SHIFT);
> >         brcm_tag[1] = 0;
> > -       brcm_tag[2] = 0;
> > -       if (dp->index == 8)
> > -               brcm_tag[2] = BRCM_IG_DSTMAP2_MASK;
> > -       brcm_tag[3] = (1 << dp->index) & BRCM_IG_DSTMAP1_MASK;
> > +       port_mask = dsa_xmit_port_mask(skb, dev);
> > +       brcm_tag[2] = (port_mask >> 8) & BRCM_IG_DSTMAP2_MASK;
> > +       brcm_tag[3] = port_mask & BRCM_IG_DSTMAP1_MASK;
> 
> Since this is a consecutive bitmask (actually [22:0]), I wonder if doing
> 
> put_unaligned_be16(port_mask, &brcm_tag[2]);
> 
> would be a bit more readable.
> 
> Or even more correct put_unaligned_be24(port_mask, &brcm_tag[1]), but
> we don't support any switches with that many ports.

I don't think there's a technical requirement for unaligned access here.
We have to use unaligned access for tail tags, but this here is handling
EtherType and/or prepended headers, which are both aligned to a boundary
of 2 due to NET_IP_ALIGN AFAIK.

Anyway, with the replacement of u8 by u8 -> u16 by u16 access I do agree
it would be a good idea, as long as u16 is used throughout (not just in
order not to split the bit mask). Alternatively if there are more than
16 ports, there's pack() which tolerates bit fields crossing any
alignment boundary (but still performs u8 by u8 access).

But I don't feel like changing the access pattern of the tagger is in
the scope of this change set.

