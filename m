Return-Path: <netdev+bounces-151027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72D9EC781
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4F016844B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E811D5ADD;
	Wed, 11 Dec 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NClAGj4z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB22451EB;
	Wed, 11 Dec 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906560; cv=fail; b=dvP6Jd9aU0mZVb+T94ZTTuX8/swRBTDZwJOENEWhc/xWns3kFhREjovL5i/d/j4WIitLyno6NDvuwhn10csNRt/jRTks4+febM18+no8EGBOhhLvhJSd+IqwvivovPUiLJg49kKPp2bzdPYnPU09ZBtwVnRrPF4Dh0+hTCNjnEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906560; c=relaxed/simple;
	bh=wCly5q9CWyII76+fGIYE0MRkbPVb2WbAozIFuu8OczI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yr/ToKWL5eGnQjOhCNdn6RjomvOUUltXBZqX/gCrUBmFAw2lCWibcxeLO5hKu6BHCG8lUXSPB+eb1RSp6U/n+SZO/tkaxQ13OQ+vlBACb3bpABn4zZDyD5/K01r1qE2RK9iG5NegUbkNRC+LW8l2SMEpNe5pAmgRkuDokTZ6oqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NClAGj4z; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwjhsc3PUoZ2cmgeKZV1bq029haavL/ZoYRoGEGLFmvDghvDIJh8/CazeT/+DU0pw9Fw20pb8jaPuN8LVID9F+urs/ONpv9KXIRIIchdkirCjnysnoCe0pkpFC61ePcUyYHO2yc6/gBnRih1SvXA3Wb0rSzybVsSW79sBSYw47/hz+0HyodWRKz/LCbUqeiK/Q9rF6fLtSFMcDxl4WcU92ZG1xuK9QOWaKG6mRCKH01dDoIuN9+PdXJers96X0Dh24nTXepuKvl/vFtRbmN8IL2cuu/dfwLYpKbcpYPRCgdvDrzSnJuAX3DMybtKooGyEQEr5z+j0PLE9aP1UuIstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCly5q9CWyII76+fGIYE0MRkbPVb2WbAozIFuu8OczI=;
 b=FEImvGYY+dMATebvxoCfq+nv6/ufSfXJyjZmj0FXcDLQmS0e0mR2GTlt8E3hdlb/n/fYwqg38lYiogDSZaxboN43quYk4X7JbGWeOZmL5MQacYbyEP69qVqptik3Aly0kMHJ9D+TYKJXtfZEwDQDyId4cI/HtJQgRuVNmkQgdvFW6KUoF0E9BBxc4tjdFsaSTVxbOXXBzF32e67dnCvgKZzp4VeucFVaKGMLLR2aI+DwO1EXTUYT1pY2IGkOyxfPdHIBoN3a1nmP/HD0qsBRKPLBBEZDVHDDAxaBO+RHPoLlCnxf4m3+H4yaSpMUBqv8Tax470i8Tnyq3U9mAoiEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCly5q9CWyII76+fGIYE0MRkbPVb2WbAozIFuu8OczI=;
 b=NClAGj4zg6sUGa3QZKcJf4VSWaY9L+qRSaDEoeflQVGkfGjLHs3R6Q4l2M3BN/mMzwAEsEw9ekFixPoCRbrXRwE3C0LJwr/gnVSVJrQKNVF6YZ7z7gM44GCkua0va5oQ9RDivTnPQYVxq9X28qoRxardWUOxYYLPIL4kzMWmnzY4hDH0P+UhTliBtqZFkJLRrwvNubIsUQVIWTEXWMUt2J8Q5PLSURq658VQQQFZPQrXfMCqbFjGFg6wAGsayKoUfayXLYxk1s8Q9cHhqQ1uSXV/UXY3D8L6OgVb4oeyMQTrIpczXdQhEwOHML7CJ22wQnGk+tkox9zrrp3PujtOgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 08:42:33 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:42:33 +0000
Date: Wed, 11 Dec 2024 10:42:22 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
Message-ID: <Z1lQblzlqCZ-3lHM@shredder>
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
 <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a94a8b0-bd40-47e5-d873-08dd19bfc15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KShO0vAw4cvK5nkR+zuEC9XNUo96vIrbCxK1AgAID/SVe+oSVVizLNww1xuL?=
 =?us-ascii?Q?rV5B8ZNIANHevQ7QT3S0oSkodFsayaa35qJfeCpp5aRI70XetS13k1HzSjXR?=
 =?us-ascii?Q?TnTNRkEfsatpdtG76JfC2hFN9NaXWRmCnirvDWQf/qsMZu5nLFzTxwk2tXHd?=
 =?us-ascii?Q?ZY20nJciR5FHS2AkYg0Lb4ZzQrnZO/VgfG/KX/fCXwMsTAqX0J/4hD8wNEBm?=
 =?us-ascii?Q?I4ANx3l9lfFKssjPmCTfjfOxgVcRxdU5V5za/UexfqVMN7vUyXyK33idGIe+?=
 =?us-ascii?Q?WduRM3EDmlilMqoIgLGYM02Vdsg4l1EDlJ0/8CLfxUPletyvIGq0fjmmzD01?=
 =?us-ascii?Q?yfMkBXmMAFs3NMiTm1LsfExz3Ie5NXAs+qZTsILT/zLwFryUZE3cJZ8AR8b0?=
 =?us-ascii?Q?sc3MwE13xH5/hv3rxXrFrtsZMHpen2nNY270a99CEPswVBDkofeP2Py7uIoa?=
 =?us-ascii?Q?mpECudO4h4+4N+XgNv//dZWEVr+XL72nbHd/3PU6zjRF4HWetCBH9uTKdbKv?=
 =?us-ascii?Q?kojju8lEcbWnfibwnUsCk9GY4bb2BIMUdcuc2pb1dMMvdwXqYuEaS0u+IPMe?=
 =?us-ascii?Q?typVq1+P2MW+NtNZQPbezxA0TwGU52akCCOiez0ouSIVKMiI/zSK9JyPLvjp?=
 =?us-ascii?Q?fkPvg+wqc7PISN9PCChAxuBjvnF3AOFfpQMYQ27ogO1SrAE9x4CI3Goo11tK?=
 =?us-ascii?Q?SUlEI/8x4wYzE+Pxmfx6UieNBdvWMJf9xkBs2Xt1q/GBnfqepdeMzOPV5nmU?=
 =?us-ascii?Q?Gfe0pHjl3dHDBFqFI2tKI3ncd/1wsU8eG5s7HeMGS523HvnayG+B1Fox9jXW?=
 =?us-ascii?Q?JTCjKvcRwBBhgn1xNXDZY1p1muI9j9djMnVYVLfAxMtHkm2xDii1f13u9bS8?=
 =?us-ascii?Q?L1ZA9SS5SIhu97rQYnSkHEIM6sdWkS1q7j6aP9LzjJkTUF5wJLKhUEJERGCk?=
 =?us-ascii?Q?lHaQM+Z1BgrvXM8Wy4gpfAhYavyrcTc2TCfXNI2u4Is7q2XjD3/bOxLh4yh9?=
 =?us-ascii?Q?q/n2DzHKgMjPHs0BCBxXj/oajllD/bGJRraEN7h54+Sefdj7bgQRQXJbgLJa?=
 =?us-ascii?Q?sXKgPtafvoZzJVe+wu1xJCoUD+bLxA4AM/GVsp6stp549PJzLs6N1UFsYJ2b?=
 =?us-ascii?Q?wXUch236/Kq4WaIKO/3Kc/KnOpxInvGFdEINasvsPEQf54OgJBnkMSgu9l7m?=
 =?us-ascii?Q?TJ2t2mqYpDF95VclJzWBvqtw/MwGx+jtWeuVxDTg9k8uxtUBqUacaEUPLXQB?=
 =?us-ascii?Q?fe91dTx5g7zyoImhc2ZfhEitXuqv8o5wo4gpAS2HUH934xDaW0VKtCK+Rpjj?=
 =?us-ascii?Q?Cy6FVKRJxGOhVIpgp8rCwitxbp1WLIaP3YY94YU2XbPSTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5hqH8nkyc9qOKUNINajCLzqTB2z6/uoQRcAASXVTQbPJ7yVAG7/YU7YFN+AV?=
 =?us-ascii?Q?v5UMt+BQpwyVrt03vLeWADJOJtn4lk0S4/71npZ6St6q8Fs38fscFNDthKTI?=
 =?us-ascii?Q?0B93Wqrtplls2gZ7vc0r9TOPTKJS0uzT1e/8MXT5SEQOf3IlzfVWBWoZ4yFK?=
 =?us-ascii?Q?HznwpAK7zgVsr8EX6gMHah+JQ6E1Np4zyH7eXEvR3cW8ig7Z2/JrDaFYPXF/?=
 =?us-ascii?Q?WiVE7GCCZ5OO4msREGyg8whjXzo2QbVS653HiYdR8mPM+MuW5CFhhCQdcpRg?=
 =?us-ascii?Q?FRyYLa1s8g4lf0bH230SM+4CI8Q7H/DNBNIvcO7GoiiiaErZnXU6AqKC8qot?=
 =?us-ascii?Q?U4cnplLntmVSuiS58ZjoJXwC00l0SE57hDfsxazsJC02h/TtlBOqNRCoyDgn?=
 =?us-ascii?Q?7cudyBwnuaZcu7Su5G85f35oKnjthi/7lpxTINPIF+Dnl+kdPmKOuuaWWKfo?=
 =?us-ascii?Q?KsZl1cj2KfzsFPKplyc6MOqLNdB5gkjc+dcwUMU1yfpbhaJJ1ean3NMWZ9p/?=
 =?us-ascii?Q?vEOGL7UL5y8XdgjlZZCg6nBSQiqEsuUg7YNNJph3V9RI6onmCeEJ1pFKgpn5?=
 =?us-ascii?Q?R01sJaeLVBmWBwu2mXnOVUrKzjYu5C0Hw9k3bsYqIynzvKuZTuec290y8+m2?=
 =?us-ascii?Q?b2Um8HC5m60twwAnaWtvy9J66xK1/P/pRDAx+1ZbpgTMzN4nkHRPpR3sa0q3?=
 =?us-ascii?Q?oUT6DW/OsTtzqM0Eiv1j9TTOFsdDlkX2IlRwfedFN1LoHzNYMkPVP+mM/FTh?=
 =?us-ascii?Q?1XJo/8JOiOKkfFT5OzfooL29wiyvnlLXxOo6zDL8MAFNJb8KB1GzyQ5aZfOq?=
 =?us-ascii?Q?HRNZUCOu13QbQHmHndLBY+jWsGMfPWiUQFip5iiNlfpkipiM7xi583uOuUOX?=
 =?us-ascii?Q?CMtSWx/1EVdW+SP1QUutGp2D68I961fD7xQzQ1ZeNfCy7qTxoGxYyjowzboM?=
 =?us-ascii?Q?FW2apoD6eK2BJbbfa4Of3ho75hVLgGDO0Ho1fAZCZXLtmDqRqtySkdkH9/IF?=
 =?us-ascii?Q?cSN+PZ0fZxpewlvsNEQfSBemnNuTma42cPYZ98MVWY2VvAwSK10gsNESvNa9?=
 =?us-ascii?Q?f/NqNBamBpOOVhtwDDCzF4Us7/1X3Cgok6en/vXmukK7HCh6klfjPRI8ecNH?=
 =?us-ascii?Q?ATOpVe6LxJMQY6DSdrroSlr5emQTRfNyyy5awyiZycB3M7oIFXzvXayj02LC?=
 =?us-ascii?Q?FVU86WNtqbJnMzOm1Uc9wD/mzEuGqpcyXmOPilUjp+kc+0ajSmUdr9DOPi7x?=
 =?us-ascii?Q?Pd15ViDs3GQtnlb+7DHTem/bBk8w5+OFKO81oURVNvjAXHKukbgrT7dQwMnm?=
 =?us-ascii?Q?QO4QDZ5s6OiT/0ulvAM+64Sb4GDG/V0vLDtAoIvnmsj111KZIsI44MafKzyb?=
 =?us-ascii?Q?QOeA+7eUgMuBNlNnVtGWevzTh0GgvYcdwTrITCydjNd5kqlVpgeaSu4fkDSy?=
 =?us-ascii?Q?semixAvaMPesO4TJHvPz/0wN1vJC/qnagIhk+BCtINJ5ke/zMlcAGB5a992K?=
 =?us-ascii?Q?PtawEDYFdFQWN8ANP4UjYm5DRCCsXAavUu3EZRdbCrIgtVFqq/EUw4sZ9NyB?=
 =?us-ascii?Q?FU2knnV+PRj58FTqeVTyv0UaJN8XzGy0BljFkAtY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a94a8b0-bd40-47e5-d873-08dd19bfc15a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:42:33.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsb8dAiiSItmqLyPLe0oe51MfmxB0+9dDU+kemFNSUMoIq2pdkFPTuLmpsqinlxBXWmFtGcTmpencClGGQOTLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

On Tue, Dec 10, 2024 at 04:28:54PM +0100, Jonas Gorski wrote:
> Thanks for the pointer. Reading the discussion, it seems this was
> before the explicit BR_PORT_MAB option and locked learning support, so
> there was some ambiguity around whether learning on locked ports is
> desired or not, and this was needed(?) for the out-of-tree(?) MAB
> implementation.

There is a use case for learning on a locked port even without MAB. If
user space is granting access via dynamic FDB entires, then you need
learning enabled to refresh these entries.

> But now that we do have an explicit flag for MAB, maybe this should be
> revisited? Especially since with BR_PORT_MAB enabled, entries are
> supposed to be learned as locked. But link local learned entries are
> still learned unlocked. So no_linklocal_learn still needs to be
> enabled for +locked, +learning, +mab.

I mentioned this in the man page and added "no_linklocal_learn" to
iproute2, but looks like it is not enough. You can try reposting the
original patch (skip learning from link-local frames on a locked port)
with a Fixes tag and see how it goes. I think it is unfortunate to
change the behavior when there is already a dedicated knob for what you
want to achieve, but I suspect the change will not introduce regressions
so maybe people will find it acceptable.

