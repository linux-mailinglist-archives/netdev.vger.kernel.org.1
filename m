Return-Path: <netdev+bounces-114286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4529942067
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E451C21321
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431081AA3F1;
	Tue, 30 Jul 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HCUV76T4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B461AA3F5
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366919; cv=fail; b=tYCuQWRZMYVacLyMqQdwP7Cbp+Y8S/qEcvJNi+Fle1n9rtbxmkZ5ChX244nD1ZqpRniCYJ90dU5IFoY44w8kDYzwGXExf8/YLnzkM/pZ81/Zs0QrEDewQQ2VmOz3FGKXbOgGQroG3CdnwG4+dcAvOn0Ug4oItRbduL0UDOHeX80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366919; c=relaxed/simple;
	bh=JUr1qm0gbtDSITBeY0PoPIjcyc3O67CFtWlBt/AhbmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fT4/podR9VUyHA8JQPoUOO3hiS6QW0a5Z60Uf1xlw8WSukW3KU4iHo5ar9r/qlGulJjYODCMiGuFhDm4AFXS2gBxFxn9db+ePqFVRGuyjuqonEyYPv2psikyKu9NjiBTy7UoX3viMLsJVGSuMFAs/HzDUPhJvjuScvfTweecUwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HCUV76T4; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWE8ksdDThcwWoYXaY/azPQuXerx4H7WVjAIdGoU4Ls51M6cO0LzfD/LkRbf1an5ILCmPkBNl9rjYO2B0RRiIHPRgYB8v7pKUj06ZpyUALmCkVAayw2cklERDbm5xJhcwVbC7m83a0yMgREjOz9kNNsu5GaCkzdcJQozT9KzqQckN06Lm6EyhhIAIZbOuYM/XoZ7JRAIok6qoOWkggA+Bu9N6TZ+v7cD9C9tDCW56awYJXzVsxAfP5D0AJmO6W12JPSBXVxT8yiqPhHTCY646g4x3jwW9Vtb//i+1SkvQ9iE1MB6PCJ6E/50fq2fyENRMpqUygedxYh00DB98BCsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF+7kEyn+maFfvap+HATzD1lrrE3iVf8aZ5IFc5x/oA=;
 b=cx5SjzM89F45LTr/ZBOS+O2I+kgYLkciLlOCpp74AaaIhDhd+n8w2s5gjiPZbsthtYMVf38j9+vVai8ZWsSDlO3+xJwMYeg1UgX1OtwqBFLSj8JvzCzzu8WXLKU32YJz6OWmO4/V9Wx3JY4IQyNmR6YuvIIfdaKC6KjQS2g7VR82jklytwwCrrM0Hy8227e7x/IIP9p8jflo8ciU3ejWnkj9VUsu/OKae1VAyQNOwUolPRp3LJ9DdK51AiCrEClhoDEELVZzQMGQvpNWzO6IxJGzuzxFVPNoH4M4Dnj3p82O7AWCdNbzbqTkddLxSB0PfW5GJ3brrRjH7xep0JVBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF+7kEyn+maFfvap+HATzD1lrrE3iVf8aZ5IFc5x/oA=;
 b=HCUV76T467rCnqM95GmnM5QwgP4/+vdAMf+XqKnWjVuk1ZuWdpS5EGfxiEPGeboqhT1aXCeqmNzdRtICIKNDtZ2EIcFR8q9bUih/lH88lURfvaqdEoZyZakxpxw3TD17MR9s8/qZS+biQsL/fmRRLG0AOn7S0s2HcgL6ymDMMMY=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 19:15:13 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 19:15:13 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Simon Horman <horms@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>, Ariane Keller
	<ariane.keller@tik.ee.ethz.ch>, "Simek, Michal" <michal.simek@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Katakam, Harini"
	<harini.katakam@amd.com>
Subject: RE: net: xilinx: axienet: Query about checksum partial implementation
Thread-Topic: net: xilinx: axienet: Query about checksum partial
 implementation
Thread-Index: AQHa31RWNVyPcLaZxUKKKrNDfY3b6rIPp2fw
Date: Tue, 30 Jul 2024 19:15:13 +0000
Message-ID:
 <MN0PR12MB59534F7030FB73002F1223F4B7B02@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240726120700.GA1694627@kernel.org>
In-Reply-To: <20240726120700.GA1694627@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SJ2PR12MB9243:EE_
x-ms-office365-filtering-correlation-id: a222fa80-6096-4cd4-d35d-08dcb0cbf06d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?829rq0CqGksn88YbMtdzhBU4woVOKSPCOAcBPVVMZFg//Rbr+17hyYvYfZP7?=
 =?us-ascii?Q?PvI+h9ulCkJtghtyfTjlUQCYkl1JZteBXx8+gyKolacC4JMrLZkXoqIy6SBi?=
 =?us-ascii?Q?CJYVDHUPDLZgZC8ioSzsZkg4BecyQHDLSikeVTkjMClqSiKzJJgdcIQSqTYg?=
 =?us-ascii?Q?ST/sgW5wfeIJOJ7TNBeD6J2HBCM3O10FBEELWAnFiIt6RytWBM66azF7Njrj?=
 =?us-ascii?Q?Hql9CUrwCfjFtng8XjJJ8g44VyLNbxmNIr5k0aMtj2Ik+I4OU3lwLNhLiUGs?=
 =?us-ascii?Q?mQvPAlicNQexBfIRMFP9L0VKf/nIyZCu6YzTQzej9DimYvSkKWARF5zGA6bF?=
 =?us-ascii?Q?SM6uYGnj6AuCJYxJLk3aELF9oWE7Dpi7bd4aLA/m41kDXXzifam4H5ksALaA?=
 =?us-ascii?Q?0RssahY5KC8fHn/B4pPHyihXcAG5ppgRq6K1JgR+Z28nROeQsuPPnc/wc2Vy?=
 =?us-ascii?Q?auMnk4UOIHmAIePHb0AXpdWo78qixLlUHdr4Jn0ifvyPnp/jmv1jITlwtGlM?=
 =?us-ascii?Q?OA43l4FlriPkGFG8IPx11PjZg72lbEi8a2kcePzPIdDn/nFH0ghOK0fOW3YO?=
 =?us-ascii?Q?ETi2wkO7B0B+7PYA//xLufzXA2FadOCXJEOJE2ypOeGPVzbePXvcbOmeCVDE?=
 =?us-ascii?Q?4p11xX2oiqDLQSNavR4ahILqdo/ir01TS7tiH3vLyGVFZf9ngqojh8xFKiYO?=
 =?us-ascii?Q?73mdt4j54U63GGPsMf1+iHDwbVEBnhyQjrmwGNSvSXWAyl3IX3/NbiziMTnt?=
 =?us-ascii?Q?c26WIWbWWdc4bpmmO+FKM8ivoH1s/B8uyfpkC56WAUcx/L1IaplhXjbKt7ir?=
 =?us-ascii?Q?z9G+MR1MJtF5xayQiXcRkmw26HYCVbgKJ03mSXZtb9CMJfSgg2Crl9YA8kuS?=
 =?us-ascii?Q?tBk04ZEiUNcs1y8vXuUaw/FFR0qCcC2+Fjn6W4vcJkhmg7Znhmpx7mb5+TpQ?=
 =?us-ascii?Q?lD5/l5rD+87fNyR/XR+lTsDzLErXli+VCRJI8/eh5i9drlDt/n4PxzcKczoM?=
 =?us-ascii?Q?d/qOoAWvmn07IHV2rZlLzSGV7pY/pGUmKylU9Xb70XBeS09VaSoV770dfKWr?=
 =?us-ascii?Q?yGghRhwLDyBFUYZwlZfGkLzic745gHKcQvVcaT0/e3pmm87EEZBkP5yErOhU?=
 =?us-ascii?Q?w3N1FyuGCHVmjKWvU1YX6yFrRU17A65BrYukWYQeCO2p3SAIqTeYc/813+Ly?=
 =?us-ascii?Q?JdnBKFQfDVu6TNYs/Dtmnf9OZQelbJ29mRNi3Bay9gg0eE9ekV7jkxvATdOo?=
 =?us-ascii?Q?I2GTQfavA9K8MfCxS4jzM+KG0CjkLj/gBmtQ6yVmP51z3KR2NiyVuiFSu12x?=
 =?us-ascii?Q?H+qcHxoa/HFjW4NmE9brpPqVxv/CrPAqfpJQ2TXvRCDNLwXN99fIhkv+SYAa?=
 =?us-ascii?Q?LO5J5UQ2EJ2jHJWPnNo756OsKUwjksygDfehcab9RYaKxkkr8Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NNF6x2PXOrm75KsEhayD3viVDlxlMODKTnR+86T7Ut4HS1fzqLkot4HvF9zJ?=
 =?us-ascii?Q?Sq2ynjfmXWDm3z2Gxi9Ae+XIaMVxir4U9VJDQfhtAlPVdUEXw7cNLCxQgmvI?=
 =?us-ascii?Q?3WdFbrLr/OcjVivjoahkpF51wOg4CnCZ1pVf2eXm1NudRL/UNm3vjGo9Po/L?=
 =?us-ascii?Q?fg3Yb2ILWoY6X71AMqnEzaV15lUoxKGVzn73PstR1XZsxMlZK0c0BXvVkZ18?=
 =?us-ascii?Q?GK9XbAzQ1/9kUUBNE+YZAUOzO6a0OIxvTzjZOA2VXiaLCwQnac5fU4wdgX9N?=
 =?us-ascii?Q?2Vd2QwpvzorrOnJQzpQyRx9kWYIkbqlCoYJg8Lr5lo+2iOKXzaCfy7Vxgx8q?=
 =?us-ascii?Q?CQxMB5bxr4qyKOrrdXCnRyqmuNuEHipKgRJzMsOZ/9Fi3fkdhDdxfa8IImno?=
 =?us-ascii?Q?YPQ82u7OZoRupKXODvs5J4eJjgZhojDSX8jzOOGP1WCU4ZUvSGLABTmA2/x9?=
 =?us-ascii?Q?xy9HopdBL1ykln+k/3S+C8jAAPU+lT/sstysOYh3NtStiVJ0bD+b1OUvUTTI?=
 =?us-ascii?Q?MvGmPWsa65SW7YD0n/2qsszn6j8XFuhLSd1vD5fGaBjAHcrPCCXgIOy848SI?=
 =?us-ascii?Q?vSuXmmEaaMLYo05pHZcebKVtzMWey9OA6F9QxaqJrHEFDrSSvbsacuG2n9oj?=
 =?us-ascii?Q?scR/fdEd8vW++kA989oI1WVyfvaFB7atxc1dh203NTPEHOZl+xkmSR+aYfT+?=
 =?us-ascii?Q?i3emlWAgLURR3wMtZbO5P2PO8MXfPUCsYp6Z1SJUYnnruT1FTQ5nRBB6asw7?=
 =?us-ascii?Q?PsGkKlOPgW18fQa4yIjTcBuv5UrDCI+wDf072R5SgLtLHlqqH6bfhuFWQUlt?=
 =?us-ascii?Q?kLyZ37KnJaqQYRRQ72spIYAprQy6N12n2HWv3BZ0l4u+lUVPjjJ5cUdndTDi?=
 =?us-ascii?Q?pnQtEcJmblKI+5nSdcPUkuCMaCke/OfnzboJxnzxfd2e3SE4sfsIw36E7vXo?=
 =?us-ascii?Q?7q48kwzsmT+VyYbO0yxeruzvXjPlRU7zHhm/5OSi8fos4RTVNKXZDZDL2nPo?=
 =?us-ascii?Q?mwj/d9LbnWln4JUyuAM5+pfWqaIold5Tcgg08fb2w06iMF4oKbBvrpaJBGGg?=
 =?us-ascii?Q?iOD68tvF5YCve2rGXMJIt5B1Zf7KPVZ6qQZnbnZGbO3pZLSDveBw9BrC3m/9?=
 =?us-ascii?Q?P2OzWJF+QXQtct4sDL/lq23HsdmnaF7grXMYcejQqQi8LXv2YErEyOKOjEiq?=
 =?us-ascii?Q?m0NB2VQa7t5QgJB5jn/qIGiAjX7654DGSpw2hTV+ePiCW8gIyA8j8FFe0pA1?=
 =?us-ascii?Q?ux12EmxXw5BpOyKF4BbBYiFLzmnsrI++0i0edRG0IgdcErGOoMNSYH/ypDJJ?=
 =?us-ascii?Q?wjp+C/H1ztYECj3M43Rp+YRztFHM6SXe3n/kHm+7SjInKZ8ad928pavgX74M?=
 =?us-ascii?Q?G/yizkX5Vx/WFwgg+faN1TABxiK/8Z6vbvsR+o0UhXSag2UZliwZpiuofT5C?=
 =?us-ascii?Q?Jt1P0qZte3HZTB5bX1itOItnYLofZy7hoP0b8fGFiZE5SlQSpRZFeg26bU5X?=
 =?us-ascii?Q?GRwCiBN0zpuL7JtC3zDlKCi2b6pa6hOE3L+0UXQEDeafNXldhF94e1z7gSvr?=
 =?us-ascii?Q?flHmESiHveu5AtmmFEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a222fa80-6096-4cd4-d35d-08dcb0cbf06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 19:15:13.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIf0Bsj/hFwYJf76YpFcwokI688Ki/ft2MTxvBk6Xgdog6IoezqvPPJe4/3kg4Ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, July 26, 2024 5:37 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>; Ariane Keller
> <ariane.keller@tik.ee.ethz.ch>; Simek, Michal <michal.simek@amd.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: net: xilinx: axienet: Query about checksum partial implementatio=
n
>=20
> Hi Radhey, all,
>=20
> I am wondering if you could shed some light on the following checksum
> partial handling in the axienet_rx_poll():
>=20
>                         /* if we're doing Rx csum offload, set it up */
>                         if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
> 				...
>                         } else if ((lp->features & XAE_FEATURE_PARTIAL_RX=
_CSUM) !=3D 0
> &&
>                                    skb->protocol =3D=3D htons(ETH_P_IP) &=
&
>                                    skb->len > 64) {
>                                 skb->csum =3D be32_to_cpu(cur_p->app3 & 0=
xFFFF);
>                                 ...
>                         }
>=20
> In particluar the "skb->csum =3D" line.
>=20
> The type of cur_p->app3 is u32, and 0xFFFF is also host byte order.
> So far so good. But after the bitwise operation it is treated as a big-en=
dian
> value by passing it to be32_to_cpu.
>=20
> Perhaps I am missing something obvious, but my question is how does that
> work?
>=20
> * Was it only tested on big endian sysgtems where be32_to_cpu() is a no-o=
p
>=20
> * Was it only tested on little endian systems where be32_to_cpu()
>   is a byteswap and somehow that works (how?).
>=20
> * Is the code unecessised because the XAE_FEATURE_FULL_RX_CSUM branch
> is
>   always taken?
>=20
>   A grep of dts files shows up arch/microblaze/boot/dts/system.dts which
>   sets sets xlnx,rxcsum to 0, which corresponds to XAE_NO_CSUM_OFFLOAD.

+ Harini

Yes, IIRC default AXI Ethernet IP RX checksum is set to "No checksum offloa=
d"
so, it is default case and being set in most designs. Have added Harini to =
this
thread to confirm on partial checksum verification results.

Assuming partial implementation is functional then likely DMA IP updates
application field in big endian format and that is the reason we have this
be32 to CPU conversion in place. will dig a bit more and get back on it.

>=20
> * Something else
>=20
> Flagged by Sparse
>=20
> The in quesoitn code seems to have been introduced by 8a3b7a252dca
> ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
>=20


