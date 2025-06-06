Return-Path: <netdev+bounces-195456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DFFAD0435
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B751895F29
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B71A262D;
	Fri,  6 Jun 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PcGhRXRm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2092.outbound.protection.outlook.com [40.92.20.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67588A927
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221095; cv=fail; b=ZRUk5Fut6C3OehRGD/kVKQJ1PKMqwkMAZR2SlBSHM2Q4JL3uO2gYsZi0bbOkIxbze9rtYguNXTOfNZjmVH/AyMEtuoxt9/ZlMmCofdR5Vr1Ci2QJDsYwsU0EJMtQHl681Ifn2N/Z/FtZtq+hDHlGvNYA/6U96cX6gw24paPqkQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221095; c=relaxed/simple;
	bh=KIT5asd4qpHeZDwOI1ne+aNUf7gtE/QbC6gKyVyvg9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JEGvTcz/+vHUtyIXHo6yOlQ06UZKFXTJCoYNa2/nAbVMa3pCLw1PPH0n3jtSXRWY3voRVp8KfW+s3zpPa6pXPPGiRbd/FEqH57yqt5aAJNbrK8/C3VcQ4/nnc+E+3KmZb378Rm7fZ/qRyrBmuJtKi1UvJK5c4nooc1+E+5RBjYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PcGhRXRm; arc=fail smtp.client-ip=40.92.20.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey0aAtn5sy+TnCtd9inr9IiM7BWvTKw09scCERnFeV8xTwzm0qPeLJ+WIwq3U2vRHJ14ZrIu3VIRA47fhE4oLTEda7CsSYw4djZ695FP9S5tFGXVk8mwG49r5x2rEOMfZdZhmyvPszkR9tQcTjTHdwJiYI8gSWA6d9z6Y999OF8aOFC7PV4bToW1Sg1PJVyyykO6aQQA2LXVWj1oQ0KftpoXOsyHyqy+q5RAEF9W5p38ksdBOBEsP06vof9Pb1ZwplMOi+a7xSPzv+ktpbO+v5CCpGUP6/jA6nnKgYpGiJMxZDoda6Aj3Onk4UP9sjuItcjT/m0nYTz3w2nJdmddsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuVOQhNHUij9rIn0q49Nz4SQrShcqQ1XcdY0nJkNbZk=;
 b=phcSy3s34Ss4agn9yBSZ2CXDPcSLxLJ6TseUUfY8i8PXh38X67uLwcxZWhGOxUENdBdSHX4m/g0D+Iqgx8N+4xTjRwQOCdy2ov3s3uRNDwAKyNpHpplX4Ce0aMGd7GWYgPjDGKN//cG+R3AekvNE8TZG2NuBMOSSCwQV0keqjlvQSwS65AI8jRh1D/NtfRcVNDtQ7/l6Omr1yw4sBCdadbXXf/k7OgWTEYU8e7Q1Jxe4U85/KVPcvpefrjPjf5MOqwbP+XKisdnQJIrVfNn6dHJZezxN6qi9me+MDYW9EU4yKy3g3htTuDUONLUy3EqlPE0JERWFIfx0dexR+6M0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuVOQhNHUij9rIn0q49Nz4SQrShcqQ1XcdY0nJkNbZk=;
 b=PcGhRXRm8/1azeNwdBCN5a6p/4GKnP5z+9xF/0/58bryAGNgRXGU/eg5r6TAzVgq/wHhGDyazOW0TFPYeXz7/Bj+6ePgpI5fXHIhyfuhLkSQ7qkld32JPoK7MovuqZxTupOeOVyb2q2sJQI9qxUBMUlsyl1kb3cJnkgmZe9zAm01WH269zXH307cpoeBC9K7Jg7CY8zXeGJnj5mcR14NaIgc/roZHcpY+qyJb9ksK2wC8pAYhV/p92eYtSB2DjZHkLCQq8UYvzLuwCuvhakIUqf2uniL04RMjggRBzCItF8VeZhe6UMVhuH9YKhsSVvzJTK7tXIAq7unqhgnWzzXPA==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by CH0PR19MB5265.namprd19.prod.outlook.com (2603:10b6:610:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 14:44:51 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 14:44:51 +0000
Date: Fri, 6 Jun 2025 09:44:48 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chris Morgan <macroalpha82@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID:
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
X-ClientProxiedBy: DM6PR02CA0128.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::30) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aEL-4PlqbgQQbL88@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|CH0PR19MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 49df20be-5dca-4032-4a69-08dda508b10f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799009|7092599006|461199028|19110799006|5072599009|15080799009|1602099012|440099028|4302099013|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FZ9XQ+GAwNa7KbkchkkECcRCGM5CcdVn7uTTdk08xELz0w9+jO+DGOdp1GcL?=
 =?us-ascii?Q?f4l4UBkgstKBm6FwlWaHCjqjymZfG72JulmVhBNGQOEDt3Dyln1za/4ZQ1oW?=
 =?us-ascii?Q?dMLj5+wO5CP0r8tv3npa2L2RD+s0581DJu7VWJ44o090Ao9cY0+4lgMPoJLF?=
 =?us-ascii?Q?0QQxdpYuocGaCFuIubHjrD+qjWlVBzQjQSj57VWwgrKwK/guTcbAyqjzM3+H?=
 =?us-ascii?Q?o9PM5OrJdkJdi9ciu/MgZ/X3sBqd8nIOEztA3NTS/7laKkWrxrtvPXq3aNE2?=
 =?us-ascii?Q?AmhDEIkrgDSIaYo7Mt7xdOVBYJu1ueRV6OGPLizSdoop7coavAYhsYUWPQcR?=
 =?us-ascii?Q?+DOrhNhG8mV1wV82AScLQMVt4EcQmEIV5jNj4q6khSNcB5i50fYtiG4PaFOx?=
 =?us-ascii?Q?BqsLBqUQFr/VkO4oeCsSF5+3z6Fq+UGInbFnVCJJWk4D5sFQFys/IHyhnuVt?=
 =?us-ascii?Q?Cr5ACdZ3SNhkAq4fchKWeYKgX2HGjodv2c1HZXtW58BiSGqbicfZ8lPuafsl?=
 =?us-ascii?Q?IWoFbJMSHO5nc+7tJ1TGGT+vLO8v1U/fGbs0uYQyzJ4/3UgUEfUEWKcdAJKL?=
 =?us-ascii?Q?tjv4/B/VVG2uJZloWhGA9/mFNt9slU5wtZ2r42zUqEMBC+rEjiPWluTwAthS?=
 =?us-ascii?Q?KcqaiSREWWl2uuCB7RO2u/QTgiFDgPoEKi2un60vzrwUzL8tvnInOKux68zb?=
 =?us-ascii?Q?JSiK8zx5jkhQkhRumCYoPQbM3NZtILq4YR4vMbuP19XkdbCFUwpxP6U3QZLE?=
 =?us-ascii?Q?Tei/ttzOsKVOYJIacZu8zLTqcBfA4g0vXPmyPDR9cP5RGc9GOSLFH65P1rKM?=
 =?us-ascii?Q?yVeAfWpfK8VpWQnjM2zrubW2ecp1mIaeYzwa4bzlTj93269u8TBYZxbIYTlq?=
 =?us-ascii?Q?poei6XGUVavYD2HxH92kqWkABQ7HUijw3JR/GAFbUkag2ysR653IwZKwEknu?=
 =?us-ascii?Q?M7k/Be4R67g6Uow0tFwLysCJsMJEhsHxs4zmmKKeNdSO65dBOhgYGBWCQheQ?=
 =?us-ascii?Q?OUlRAUujFcKYoBdGjooRy7Chr3dJ9vHBD8sIWlZSxT/cxEJenc8T5qDyV4e+?=
 =?us-ascii?Q?lbq+WHbIeTDRUb2u50bbJ9RbGBz1tLNJVQAwwd9LAgyV3w0UTe0y/vUy65B9?=
 =?us-ascii?Q?QP9PeiCYzY0pqztVgrh4xtvQVFHwfkj/0pQfL4L4LGcBXErdcXiFqPq0pcD1?=
 =?us-ascii?Q?ilFxZ5nBxUw5up73HguOl17ZyPlOQzk8cmKHRwAnlJWs+rgROQbVKnf7LvIC?=
 =?us-ascii?Q?ATbJP2jUBwUGOPqkXcEq?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?saoDcyixKm85n+JVWUb9y7KXalUu4Nzl3Ix/9tuCI3m4Zkp3F8edVAQa0puC?=
 =?us-ascii?Q?nAlyPNaoge2e4TFCqQi7ejmU9ltwKt7TgY1vBagLxk/e3O+024k/rVhVwDfu?=
 =?us-ascii?Q?+03lzrbiATvGa6X4Ss1XQ6HiYz+Vr+oinzWzXC6rE9kSFWoEm805czM33yLj?=
 =?us-ascii?Q?1Jzqin8A0Z/p4nkK9DUv1ZwtLlfHoa8Nv8LQycFP2+XibOKp4f9BYwnh21tG?=
 =?us-ascii?Q?M9xqlJfhJxJtxI7tSGiOhk+t9pg1WJpSlTpUCS75ZWyLv8b0K2VNpeWZIS4g?=
 =?us-ascii?Q?RJmjqPepfLIta49983QnyOIAtw2iQY43iuq1qWMlr6RjCFLBc8bWFO0DWnge?=
 =?us-ascii?Q?VEb38pm8S6NRNEcYsK4G1181pWgojgDnCtrpeMSYdzRkIxHS56UazCNDL0qP?=
 =?us-ascii?Q?IdOCv6zX4LoO45dN6tZ//BYbv8fNbIbOX5arv9eTJJp9OG20jzIS7UZZCaff?=
 =?us-ascii?Q?pV4DWFWx8599VewdwPFiOhos1Z7tW3B5vYRdGMh+jvJt2tLxAmtkof4/pOf6?=
 =?us-ascii?Q?XAGgYGSpo/FaPiqrzhXJuXBcvRydBMolU1/Owgt/iwNB0D96XZIPPer5BT77?=
 =?us-ascii?Q?3v679pKVZWpwTd9mLhOHq192y21pSRHzeAEwL8f+Wa+SEEejVH/THEycspxP?=
 =?us-ascii?Q?KDUuYGohcdYbJjKmhGE87OMmotU3x/Hq8Ioxp+Fr21tZVdJLJ/uUS6kbMBQQ?=
 =?us-ascii?Q?/M2XoHTI6dF2NGFxuHwUc1XEsHRFP2lKSG8YQFKrzk4LskBiv6s/yZUFKiwS?=
 =?us-ascii?Q?Dt+kZ2KtzsktlblV4qq2VHRK6h0/wCFFdIZzLrmFh5BC7imtKCEuvXrHw4BF?=
 =?us-ascii?Q?VfY7Ph/AN4IgfAkJP4i7QVRwNnE5et144GkiqCe7ACH8IavRGACIjU1NnzD0?=
 =?us-ascii?Q?YyHrSVFjIST9gnSzajWpk0Vjl/Z9QswczuhLykUdVSWGHeZgQwXazRpe5VuY?=
 =?us-ascii?Q?DxoAVcEwjNFVv4VtaIKBdLeUq174G4kJnX13PdTBWCPjZ+TPENcJGf54KVK1?=
 =?us-ascii?Q?9dE2sj8+BfmK2aqLPsgC/lUX4Hyjz0owMDvwro9/KucsavlH8R6zv9gktOxZ?=
 =?us-ascii?Q?EFuUCK/VdpPwpYGvd1C5VPNBYLOeYmZ6EMs7akYZ2qMmsDK74ZIzsumTTMzx?=
 =?us-ascii?Q?zCxa389tRg2ePBfyrTkl0MQU2YPRmzObV0r7ZpT3q3nGsHSRfSltPZQhInvH?=
 =?us-ascii?Q?aBDTYcS91P9IqRRLlSRU6qAIYWX2m9D8Mg2EfxAxM5r2WV0fQB3TLyXDOxCA?=
 =?us-ascii?Q?JjKMut1nbyUPdG5sgZ31IUcdA+hoI9/efRXi4DaZUpFUP9sxOBVEb2XZUcOt?=
 =?us-ascii?Q?DWU6uNU6iN9IDWBwDkWtWYbf?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 49df20be-5dca-4032-4a69-08dda508b10f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:44:51.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB5265

On Fri, Jun 06, 2025 at 02:53:46PM +0200, Andrew Lunn wrote:
> On Thu, Jun 05, 2025 at 09:22:03PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).
> > 
> > This device uses pins 2 and 7 for UART communication, so disable
> > TX_FAULT and LOS. Additionally as it is an embedded system in an
> > SFP+ form factor provide it enough time to fully boot before we
> > attempt to use it.
> > 
> > https://www.potrontec.com/index/index/list/cat_id/2.html#11-83
> > https://pon.wiki/xgs-pon/ont/potron-technology/x-onu-sfpp/
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> > 
> > Changes since V1:
> >  - Call sfp_fixup_ignore_tx_fault() and sfp_fixup_ignore_los() instead
> >    of setting the state_hw_mask.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> You are supposed to wait 24 hours before posting a new version. We are
> also in the merge window at the moment, so please post patches as RFC.

Sorry, I'll make sure to slow down the commits moving forward.

> 
> Russell asked the question, what does the SFP report about soft LOS in
> its EEPROM? Does it correctly indicate it supports soft LOS? Does it
> actually support soft LOS? Do we need to force on soft LOS? Maybe we
> need a helper sfp_fixup_force_soft_los()?

So I'm a bit out of my element here and not sure how to check that. I
bought this module and had a hell of a time getting it to work on my
Banana Pi R4 because of the UART triggering repeated tx faults. After
applying these updates I was able to get it to work, so I figured it
would be a courtesy to upstream these for others not to suffer. I was
going to get this upstreamed, then request OpenWRT backport the fix,
then move this device to replace my current router (which might be why
I am guilty of rushing, sorry again). That said, I'm not sure how to
check if the module supports soft LOS or not. I did a dump with
ethtool -m but didn't see any references to LOS. Is there a bit on the
EEPROM I can check?

Thank you,
Chris

> 
>     Andrew
> 
> ---
> pw-bot: cr

