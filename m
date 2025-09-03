Return-Path: <netdev+bounces-219610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0FB4248D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454757A7918
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BCE313E2D;
	Wed,  3 Sep 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dByLNV0z"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093531352A;
	Wed,  3 Sep 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912306; cv=fail; b=jnad3DbaWJ10I+GXaAw+bHYRP9qfeFLrxahu1ePgKzRA6QMSTz5O+/7rqZSvIAERyMELskNcU2X7/P4fE/YwO2mYIME7bxzeI96IN/WL8wLFXXNmmfQ1SujRSlHpq60HJRElQZC9siPClp2fRysKatuPfNMZbsm/AEZ2ye3M8A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912306; c=relaxed/simple;
	bh=CdjgetdbkN6ZrM0BSoFROclXeh3WpDuaamjIZ3xVJ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GjWSU/AwnS9mIZ/oGB+BQVlagh1hW/CyoIWgZcXI9P3RMT7H99bicE7ppK2Zde1aEtLHT6rwqf4UcE/zYusprJVorL7tmYgOK5H7CuTTeobwAZtikCVpWlYi2euP9Mdbns3+vMaMU3cqsauFEaZFGlag/2TmvbAM4MFSSfAP8QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dByLNV0z; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r53gu5BBiaAFC4FRSR1wfjv0ZbrIIwwUl3D0wNY7sZRjzhpFLhpJhCg6zDfRF1bW6kGufdveRSXJ29fuOgbGQfyGtAGp7z+bx4enDwPxLEKLTBh0kb0JLNmQYxMPBk2CjN1x3EFQPe2PS4Xn4gizT2n/X9FbHj6yp6EYbMnUGQpZbN5PC0nkp2uyW+caTJzbKTbe8blAD87FYLk5DcGt1qRgg5gyZGlIqe+a29zTVYr2SDDCEuOWz72v7wk8pDtugdmoOU4zyd8b5vFkEbGdYLU5Fao9lOhzVO0ikrg2cM72GyRk8uoQDWOClzceWzaqsU3GXwo0iBoAdvyqY0AzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ/NpowmKmipTobrfFg45QxlQpQtJW63Rp2tnJCTJBs=;
 b=uL3pXPs3cKCq15ywCvgNUyvL0T41EQJso30/vEkPpSImr+os9AEqvQ3/b1GMgtD5wH92zZjo3Hk+wDyBG1zpu/FD3k42MAaCEYpglEsox9tFbmzBQgQz6SyR+zPgQxd4Yfm4e0m4qzlAIXVa1SKh1tR8NLp5mEjwJlgLb03nQ6a2bCmuc9vMppSnGxoYjqeJn+FytQaDUuKFciXKRwaui+1hOwKUQDn5p6fp+fWWKsmTWJD7EwBn4iqn9807GJOrpGbEz6gGcG0EsmMbqhjMU08qS3nSqKPj9Ssm8sABLfisHDGK2oOXsVgKmbHs19QBJDF72VFgSulUl0UJx2YbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ/NpowmKmipTobrfFg45QxlQpQtJW63Rp2tnJCTJBs=;
 b=dByLNV0zLlBIXt9ep1pe/7UjDcwJUI26u9BHHdQwb08i1aNhmCnH4KNjxSXs62/Fw5fU84sNooxuZGAJh8+hEWvuFJbZAxCXaiirtmy9aK9qLMVfJbe0M/Aj1377Op3ECNl/u/egiEGLDGvhugS+9DHIRIQeGrKE9Qfyh2YwzaPELVnuuYI1GH8SQ0ReT30vcaW9Ig2VwHXVm+bfzAEdcgaDcVy87e1u/H6uOuY1HiFYD5iz8L2+xWJKfeHGl9UmsJwqZJQl9ocOkf3iwIbPfuotjg9qBk8zIvUd2eSyM5SU4pdFnvEdJf2PU1IH24EV9EoDgEAV7M7I4lrCKPsDjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 15:11:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:11:41 +0000
Date: Wed, 3 Sep 2025 18:11:38 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com, yangbo.lu@nxp.com,
	christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 0/3] ptp: add pulse signal loopback support for
 debugging
Message-ID: <20250903151138.malmfj53hew7caze@skbuf>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
 <aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
X-ClientProxiedBy: VI1PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:802:2::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: ada65c1b-41d0-4c81-51ed-08ddeafc3022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6Mx9T0s9GeOsHQb3lGMOZrr56cmd5bdnGgQvHHD9WWSJiwIRYcUYwZsB0fq?=
 =?us-ascii?Q?CgByvu5vXsLEURp9fWCFGjiHtxSvIaw4fP2wlSPx+9S3EV6U36OR238whmuY?=
 =?us-ascii?Q?UM9GzSMJ5vKzMO0lHLfyF3I29MuFhUcuBfoem2HFfW9PqMcmHEaIqfguAFEd?=
 =?us-ascii?Q?XG6YXNc1Z6hj8Ud0PB/7gr/6M5TGaM1fUMOVN/JPifbGBEsz6bjqLetsVCv/?=
 =?us-ascii?Q?cS9ucWkK5s8zOjdpYqv8pOw2MCLC5q5DAAtwOb3mdoAjhtjScsD4FlxR3BCj?=
 =?us-ascii?Q?0KhTROjHhE6xdbqMJTmnKSJQ51pifVDatYIyAed/IMQMUyFbwlrl/xZ6ua4T?=
 =?us-ascii?Q?OURJI9hmR2N1G2HMa4jKcLVNwezM7R4M7ewlTqmagPpdV6ljLBDcLK8OthSu?=
 =?us-ascii?Q?6y8MnuZcY+d4WUtq3kwy+IU9/TAyHHA54Rp37t1FSkicnH78CqFj/1McH8Zw?=
 =?us-ascii?Q?StoH5k76M0cfxQTiVQn/46QUT26pTq3EqXLnrycPQgzLUfTJ888+iBeiOIRi?=
 =?us-ascii?Q?RFykqhyV0ost+Wg/Gx1b7Vb5QoE7ziMDy40FTHCjqJNV5d457RpCjsP8rZCV?=
 =?us-ascii?Q?hF/Dntvb2lBV3i3EqXgyKFgP5v17oS+QK8dFXGZaWW/H6BlyOvr9FC6dULSs?=
 =?us-ascii?Q?TEjYO6Is6TnJxQNR7xJhk5AgDaLulEI6afEboY2T01HYVdHnUxKKJaG3hZvM?=
 =?us-ascii?Q?Qjs9YUSY3v7DIAYwgOgXyonNYvbSvXQCgAwH2+rNCAg9gI4RlpjkmiywIbks?=
 =?us-ascii?Q?H6BUuA3nQ+fpynzK3Vo/JNqUFNckNOuqFwgY8KsMednTdyDYgAlXSTjKCLfB?=
 =?us-ascii?Q?iSsRYJnTJhuvZogOXKw6eGLCaGezPe5HJbEeiOtQaSJu1GdOie4jDJpWLVyK?=
 =?us-ascii?Q?StdQ82gq/0QqTwbPOMMT3daGV79F2kmfaEj5ROsg0ztgmGxw4+dCpzI/6BPs?=
 =?us-ascii?Q?LX269+UKl0OTjfaIyEWe13IiUGbyUpSnXcHLpG1w5xsymUpLG1p2L2oIc20N?=
 =?us-ascii?Q?a0lJ2B/Mw1XSM+Je8qubVjPJloj4k3DocfEX7fLgX+0528ocASZaBW7cR5T+?=
 =?us-ascii?Q?OhPlS6o/jvfZUBPAw+f1UYMKdLxoB1NvDNpcfY/89KikbXxttv9xWKBFZeMJ?=
 =?us-ascii?Q?vHDqrPEptJBDp5o4ALQZguuJqE8bJjSLP0EPskYTeYAM2WbCWbbho5AM3hji?=
 =?us-ascii?Q?PPb6KAhdTK2veQihcDaO+UaHXOSA3NwqHOhLHcmf5Ly95cNhaXBUaERqtpsO?=
 =?us-ascii?Q?TOhUL1C108EeokBCS1M8zk7/cbs1767gq/409PHkjMky4lQZdCrWb/qdy1BJ?=
 =?us-ascii?Q?KE2P21FHlnCR19ldw2RwFoMjPGyYrDcOdBG+OFqb6ZlCSaSL3lb+n7z3frfH?=
 =?us-ascii?Q?kwaKoiA/EDfWihizGkqL/rXr8nZSa4qEAebZU7TRAkfrxNam9b+mosRU2r6Y?=
 =?us-ascii?Q?zKKO1YeUKPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DjUQIGr4yr62bTpMyDYbyNRxV94L79wlT7FFAd/e6GGj13mFgSVvRJzfh0du?=
 =?us-ascii?Q?Gn15+qpSydaxVsqVjDqJXRlW6Q1g11tLZ08QkYyV2C/eHrhbNRZ9vWR+72im?=
 =?us-ascii?Q?8UrH0Ciay4sSdj1olCsULJLqsihJcF4UdneS1RtovZZmU9Ugafj7pfP5ccCD?=
 =?us-ascii?Q?o8mDg7zNg67IZP3jG8kt5TLrtteYzXp3RDZ5CvmTMFRbXW45NkLVCKoPIlZH?=
 =?us-ascii?Q?FCTSpRO+9lSlqBeB5HvWCxhpoUfZ9zVsfYTgFwMC79HdG4I/SqmLmFZVpmLu?=
 =?us-ascii?Q?VxiGsGJYdfPGOybbuVZ2TnfJc0GuhQ85l4MJ6qT+uo9z6Eycq2ZmkC4iQKZq?=
 =?us-ascii?Q?c2H2/bAWBVYIKIGw16PzniUTTLsIZQeDmqcr1HeA0UNWMKta8CXNIN4pjCe5?=
 =?us-ascii?Q?zyWDgc0SRDq4wxJW9616ppb3G9NQVZcoFs9+w35UCVcd3K0urnh9vsKkIfyV?=
 =?us-ascii?Q?W2WG4PSrU6Z4km/E4/SHFSGZtC3w8azSf4ztUnVAhGWT6KqmHUWvwR5VwNdu?=
 =?us-ascii?Q?FgvHFQOV2R8lcrvGGZ8CpxlpNKUCYd2v3EqT5ASdgOJn2kE4SP9PF7EcdyLj?=
 =?us-ascii?Q?cmm7MsVa8OJrkLOoy29t4UWSuwme4Flr6NYRj0LdOCLMT84+ggP0S+jcuSXo?=
 =?us-ascii?Q?z2i42mwJecZN7C2GXz4TCo5t2My7f+DZMS1RS/LR23oUwmCeXSPcNB5orsJJ?=
 =?us-ascii?Q?7wKf4/oO7z6Z0AtWXU6daFykxHBb9uomdYOM09+yJvNVQZ8QBnX1LHa6MGm7?=
 =?us-ascii?Q?yjy8v3ABuE77wbGxhuzE4HKuhhRIALLpNEufa6aacXBQer7qGQVgcO2jpmRQ?=
 =?us-ascii?Q?LrkAkAnT0oVUvlG/w9LM+4KphuCx/uPA1/CZiRyqJBlaGF2EHHGahazlaF+T?=
 =?us-ascii?Q?lExt9nMKoDGbQaSZaq25NPKvNKZMG9xoGsxm/ll0Gzy14IVktovyGrdOmrNX?=
 =?us-ascii?Q?GRmr0gU2SZ25Lr1oYmcQJ1ot5U5F9nn/km19OLeUWRYOwWBAxIkdzeeZJFhS?=
 =?us-ascii?Q?igslPnqoJm+l5gEHMZX+80cW5yjecGMippHH+5H5cU9KbnAuCQIdleiXhUwQ?=
 =?us-ascii?Q?2iKiJ1spGL4oKkX8VY1n6tVOOM2CQVP3l99y2HZrbvvDFd14nnn9OBjlKKtP?=
 =?us-ascii?Q?EUHBLYpngq2zUJjhXVAQ06qeMXeGaDcpIIkoEgeK8SFUyoJ6nfmABavMgL2b?=
 =?us-ascii?Q?FRMG/wxIz3ffANUa1h2qCm86lXpA8u5RjGjTXmUwYWKeJbWoghaEZoGpvxyY?=
 =?us-ascii?Q?cr2rn3tQh/o6y9Uo/iyxHjhckYsdskJFgloMWyIuQLQONojuq3Qbr26q6RCT?=
 =?us-ascii?Q?omr8l4Lq3NHESjQ4nouHdacYPVTaps+kIzUZH+d4QC7VhkGC6edckIAoaeHu?=
 =?us-ascii?Q?h0haa3/vHtMw8jo5uiq3rrTlgnqtI/OFg89flWIWBjE89+mXWMMLtAmqhADI?=
 =?us-ascii?Q?hzfL8q2mHNwXgcIluyG/aJo0FAkjmrWGea3OjwW++p5XT/EOIjlayNLwM+pg?=
 =?us-ascii?Q?asdddA4r8N2cFS61wWehG4z7SdWtctxlGcH043MY3ydgRX1qM5q2M2LTI75q?=
 =?us-ascii?Q?RGR4ByoF7U5CZJ/+0DGRFg3crpOvRHMuhwEq/tjpMieKSxAmDp/qfGYr08jo?=
 =?us-ascii?Q?eTEA5UKzwuXviLGMR4M9NrOxQqmsMBigBrz/wa4WbAke/QyBm82F6vH00zPQ?=
 =?us-ascii?Q?rggDAw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada65c1b-41d0-4c81-51ed-08ddeafc3022
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:11:41.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpZ8cfbCKiAU5NB96MKj8Zoz87b2CMASlcvVWIgvUgXnaPOFHEFd9EHDGlBuDYESbYhqBXhSpR8sBCHfcHJnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

On Wed, Sep 03, 2025 at 06:41:30AM -0700, Richard Cochran wrote:
> On Wed, Sep 03, 2025 at 04:37:46PM +0800, Wei Fang wrote:
> > Some PTP devices support looping back the periodic pulse signal for
> > debugging,
> 
> What kinds of debugs can be resolved by this loopback feature?

The commit message of patch 2/3 shows that you can record extts events
for the periodic output signal emitted by the device, without this
signal ever being required to be routed in any particular way on the PCB,
through the SoC's pins.

So you can make sure that the pulse intervals and their phase alignment
are correct from the perspective of the emitting PHC's time base.

Or you can use it as a built-in extts event generator when you have no
external equipment which does that, as I did a few years ago to validate
the extts functionality on ptp_qoriq.

> It seems pointless to me...

Well, it's pointless in the same sense that a mirror is pointless.

