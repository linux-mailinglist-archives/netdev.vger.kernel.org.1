Return-Path: <netdev+bounces-214905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83807B2BBCF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCC95E53B0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE1311960;
	Tue, 19 Aug 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RC/dIeAw"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012035.outbound.protection.outlook.com [52.101.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D13115AF;
	Tue, 19 Aug 2025 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591955; cv=fail; b=oPQrJZPF9xX91NsjBSa4tfbyxJmVAj9o6HukktRnFQ3E8iug7On5OMycrkPBNI28WSnfA/E1H9eSz9lPswzFQxeZm23HJBjpeK94tfw1C3/rlpVWYJX3joFPasjLmCJ1A50HN2746HEqBhptmOytVFWIxjLEnyCMGcrElj1z9C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591955; c=relaxed/simple;
	bh=ZZ0jHuabPS2fxTCyQFytTaQfEaeLEQBShQ2WE42277o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JOeM1vHOiZdPJ/iqglWcO01F9+H7F/C8CNEIOlBTr3ON7cc19WC11pEHTSSJzd2xYBDzKGi+Tgfo1M6N/HHRTEJVhLPuOrszJBkmKp6Dz1wnieH20vhdOuNvTlbG+Wkol/hKSrITvBiRhex0Kn1W8ri3N8RzUqnqX9BHHhkEgkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RC/dIeAw; arc=fail smtp.client-ip=52.101.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhVhjG7Ps+vyvFWKurXKXp+XtZ7CUMlPgXOnu1hgsdTetFt4evUqWwP5ujAYXCQkfWcUdmM0KOcJmmKo6Qwd6So8xGs1RPB/X0ZIUo+yUxq1RKB/Xi32iuyJen3MgTIzrQ2j5WFpKt1Uh5PMyx4GM0lFaem9vvFOL1/SIMpZHkTF1I/nwgjhS2OxlZGk7ndNkEfbgPNA0plLC5zpfbGEb/Oa+8Iff/vgJq6IiUe3tpAePqqwW+to3atvE4jKIwWeBI4JXmT1UWwV6IkM+M9y/pUJVH7dbrgrFS289CTPJcgUMOYFoANo9EFGrS9B9Rf907PzYQ+Fuk9prbvZD4U8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8q9mebcKJ0OcGI5y9JnvOriAEH2NGUvTI5saAPSovo=;
 b=G6mH8xpq5mqLyIGXarnZ/RGT5ywGuBSJtpQ7TaLCmpHues5CMLNX935Mr/I/1ez3e0yewKuW/dgwin++9OdfjbOc067yA5S8/mLvFbhqiwMoSM2es5vQyB+aiK7dkWggvXcluoSvoBmF8dcyikYgvyjDn2W6dbt/gVFsUW0MdjeNHZDkGlIc9bs15vswGHgV92kgjG//o7kbUKEZA4Hs1wpy5+Nl3iQck3JiNkZvEfDFzDC/y6HZ1IM/VlZDYQwO/1AueNo1BnVGW7BWeuqdm7f4MX0jBmVJQ4ItC2mBhvKtbPB9jB4MVd+to+tOiCPmz+xuZcnIJSIL4AFBBC3JoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8q9mebcKJ0OcGI5y9JnvOriAEH2NGUvTI5saAPSovo=;
 b=RC/dIeAwBSZw6COaeOq4h9g2wegmVIdC87CcBpe6PwsBNrspgiAhjpLNJowhClpzThvyL2DfWn/qxcuyAd9lf0zBweaIkPBC/rQA8nMidipsiRx9svQeueJVOOa1ZOgT4uhAYDHHo8vgfJF42Kjhphi74uCwGfrHfVyLvSNfw+B9QMdDfzLgS3IDjPvQN8jbA/ez0JQ5vKUa1C/hNxqXfulmhOcH1uAILoE3e+X50J1oBdPEr8dYGJSNpyapX5K4dK055LN4cetOOhWz+JXylBHkziwNVFqGcYMBUqgeUxe9jYYd/Lvr21ZWpTkQEKusUvI4SlcSA7PdMl1PzYor5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7988.eurprd04.prod.outlook.com (2603:10a6:20b:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 08:25:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 08:25:50 +0000
Date: Tue, 19 Aug 2025 11:25:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	rmk+kernel@armlinux.org.uk, rosenp@gmail.com,
	christophe.jaillet@wanadoo.fr, viro@zeniv.linux.org.uk,
	quentin.schulz@bootlin.com, atenart@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250819082546.7455mixbmqccsv5p@skbuf>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
 <20250818135658.exs5mrtuio7rm3bf@DEN-DL-M31836.microchip.com>
 <20250818141306.qlytyq3cjryhqkas@skbuf>
 <20250818141925.l7rvjns26gda3bp7@DEN-DL-M31836.microchip.com>
 <20250818143732.q5eymo65iywz44ci@skbuf>
 <20250819064011.zv3ybgvjx6cqkyhc@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819064011.zv3ybgvjx6cqkyhc@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: VE1PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8c2510-9c27-4965-5550-08dddefa0160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1NeY3uqAXLdMXtlg+5XGLTYOtH1qOpbNGqNpejhu0T2rm/qfCfW4AaHrM32?=
 =?us-ascii?Q?1vB9l5ZKkURVcMoZGbarm0fyE5Q3AIaSlm2QnlsJ9TrVODmPC0x1UBcfAmvd?=
 =?us-ascii?Q?SrNJvew74gz46zLIMbVR8lTQ1523M2y0e8XyyqVEF35XnjOzEoLvsLkrSD9+?=
 =?us-ascii?Q?JMmAlnfGAALdj2FY4WmJZqzvZFKMu4MqfE9wgB+9M1c0O79MnjXgw6Wrcoc7?=
 =?us-ascii?Q?GCn1ONH3YEg3oL96cSS5hVrEBf+dmWjrRaSrSebCHL2wwhezsrgtiJ/uIxKl?=
 =?us-ascii?Q?twSWriO/bqJfArBCo2uFBpfVR0KD/e4s03Ql259gOi6BgoS3mVVINZScMMBt?=
 =?us-ascii?Q?EYd5ku3q6eC56isJp0GCybVwYaEAuzXa836cGD/3HSkpnLr6B1qwoLcPkVd9?=
 =?us-ascii?Q?cI0TNaTOqrjjv0sGKXuuoUQ0WYvMkGlluPPwqlXkOgU3t6fq5nW99/MlOMsI?=
 =?us-ascii?Q?0oz4iigqI1TDvqa2qssORPN8wJOeOgz4VOdJJ7jT6Nb8Qr8oNgE/6c2Jp3gQ?=
 =?us-ascii?Q?8fXqhqL9IJPOZvQ6Hl0fhsNx3uS3TgCZyKFsyAts/V4LiGfcuocJUfGWGWZT?=
 =?us-ascii?Q?QMC/Ki2rT/THX4fpFFuygx/x5ne73nnFmCRqr9Vdn2VkkGsHQY/QGo4ZGcze?=
 =?us-ascii?Q?3oI+yIPIZ5q9L5Gd7NMT6SuemxpBtGbri6vNgzlGvKVfxpVkqTqxPEHD14bP?=
 =?us-ascii?Q?vsU6i0BXdOQ3IkY8xujuj7zluno5KFG3dZpTM0qLXgEDWj16I5AWxYNZB8Df?=
 =?us-ascii?Q?qyQvaTMAc3g2hJz9lYCae38yetE+v4gEmVEiu+8w4fxgEJKwwMth4KZctzD6?=
 =?us-ascii?Q?7vmie+Jopc+gOiGlhxg0tUy/foRzrnc3LFK7usu6v9xOX1N1PlGtI8T7M+gD?=
 =?us-ascii?Q?pYbbjtvgs+miX3s/AR1J5nKO5V2G6V8pOL8by4NuEUNByiHpDdBC7JQ41G/X?=
 =?us-ascii?Q?Is7lLXR2BU+5OvOc+tOhiQKlpYkXY8L7Dply1b15FnVmyb+U1LHnZTwsnneR?=
 =?us-ascii?Q?MB8eOn86FEpjZq5vS+9BIpvUX70+07zuAFufjHcYrBoXqw4s8A85jLb9og+h?=
 =?us-ascii?Q?KOaJRRnZBDAkkyN/yjybOuYFSMuuQ97to09ij7BT/JzN/9aMzsoBXmKK+I1S?=
 =?us-ascii?Q?PYSPOYi+hGeceAMOcALURTxE+H12SfkqzthppO7WbtqG4atPFUlIpEIFNqne?=
 =?us-ascii?Q?BYZVRd1KUzgypvBnoJG0ygPC7NRjl7tbeNUslhXYBCmeO4ko0RDEtVNyRKC2?=
 =?us-ascii?Q?g1IKjFXjWRIKLOvRwtTiIg3NGxtKmn/XdH0h8KYEsWL9JhVi52xlGb28PXl2?=
 =?us-ascii?Q?/Eqt2LSMzLnt+vPwqakNGTJRcZzgSt4gQ3MSuJuxK/CU99BgnxBg5PrzVzpG?=
 =?us-ascii?Q?9ubIVuCxqPGyaiDctAcf6LqLqWFnhCFa4w8NKVHIKp2u2iq6Dul22Ln03kQK?=
 =?us-ascii?Q?N3c0vd/6zUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mUEEbi0IT2JMM1c7KIIURXxyxYs7UAzMqMbuhc2sqIWW6aH4SVZKrArp2380?=
 =?us-ascii?Q?RqVy+F0O1TV8QeUtA6euvSEfMD6NmuiuHKEj5/OJGm6CcP0EI2vxDHkgIj1k?=
 =?us-ascii?Q?w7dzkP8clj6V9dIp6OFYkE6B7paPC96EySSaINeoHwG1IFR/IPMO+Xm5ikfF?=
 =?us-ascii?Q?vrK5Z72YJcjBkVGu/hgchU2ugAgVM3mvd+8VR6omxJIYBToQggP1QIhLre6w?=
 =?us-ascii?Q?PSmk07PEPy6rnmdHWro6ACq4YfgSbAAYfptKd0sjIWbrqGuqpqogmoGNHDYs?=
 =?us-ascii?Q?PW40CbFrHe2AU1d2O7HndcjlYo3gitvf9bXPzZGzL+xXhJ6dW2zQODLSH9Xp?=
 =?us-ascii?Q?DT0pD+9Cy55rFwfKUJPOfx+xCheR2r+chqlOG6Y9SI9Ln5Lgjk7srwOJcUpl?=
 =?us-ascii?Q?LdTWAvMc9Zes8uhj/2ok8ung13eHnsKkx0YAtO5V1jvYHXcmABeS8x6H0mYO?=
 =?us-ascii?Q?oeBx93Y9IVpnE4uhZtfJqYosXVqcoRgtwNXkgXg0JfKBAcd9j9AUEc8e804K?=
 =?us-ascii?Q?q+XQUGpQNebRCEEa75Jz1NUR/MBu4tGHOHoS0fuVK2avSSOXIAosnnHbQ/eC?=
 =?us-ascii?Q?DzDL3JxSAgGOmfOQ5TtpTBOpRRfCI5OphEEEyFdU9Ebs+JEny+UX68B3VdTR?=
 =?us-ascii?Q?aFNjNAxXylFBOqSNYFxQ3FUbibr2SDOmXSWU/5QCrjcMZSXvM4KtTefQ6vC8?=
 =?us-ascii?Q?FIzsbQVe2AXEcZCFkWHWhUQ/lLfDyjmhNTMRZfswCaDm4tG3iOjgqkZB4zgw?=
 =?us-ascii?Q?4dX0RknzwrDzbMHizcm5T2aUe2uoLbPFugUQaoU9WNOBrivbLJR3r6zx9T61?=
 =?us-ascii?Q?FJIs7wOJ9yCaXVT5fkYxyG5rV2V/R0Ox6BDo+9+aOHeccVN3rWVXfKrGf8sL?=
 =?us-ascii?Q?DWwzcpFGigGTUSgMlAmucALr3/HZ6knEGmRaBR2unzwne1DIFmTu0pLc48Sf?=
 =?us-ascii?Q?uC1qLklzyaPKZiGGiYV4DwvPdB6N6pY3WZeQ6b++mWAulXJSXI6e5S1vhxfV?=
 =?us-ascii?Q?RqaBsjgJyfNNkSzxPJkrT++Z30IjwjCmQ+5+XV2qlIGsmagRNG0AswFewfXa?=
 =?us-ascii?Q?iXcNp/BkejleULVWSRP7blkx18OEMS2V5kz/JmfyqJvThugkALkTCqoz3TwY?=
 =?us-ascii?Q?mmqRkB5mdS8ICJr0e/HTM+zPyoMxQs1ddgtG5271HlzHX4WZ504cApuxmdnH?=
 =?us-ascii?Q?8vJ5q+jlC2mdk1pkjz9tJN9hUNI7lSKAWSPiY1/NHxDjQDoBdm3R+Qvha89u?=
 =?us-ascii?Q?Q/wuW2Kwa4s4UZ8eLNtwxfwT4qsJ998/Aj9PqsgHbCDVYr0NjXZUi+d8Z3Da?=
 =?us-ascii?Q?OhgPPSxR5YPIyI/p7FXsSn9T4UU1Nex9UpvxJ3+cC1dbqMbRDEvb5i17YRkf?=
 =?us-ascii?Q?dmZLUEjyIPelWzckGQTgBUZwn6zryQzfVpnhilU0vZ75/5Jqqoh5aUIGNxtS?=
 =?us-ascii?Q?TmpSk1oee3G3aXhZ1qLw+i0IQARn2P/eB1FZ9tVcgmMijNoKa+nsYGhcQ6qc?=
 =?us-ascii?Q?V3dt7oFhRcRWHrtsffP0meOnNfvR3UXqOsX7LnAhJvIniDlbYb1ynjCfr50n?=
 =?us-ascii?Q?hqDTgdrKJUnDqbZUTLUMySVv9Hy3Qxn9lkeXfEVvgMeyMzPjrtPOpVxEbGhH?=
 =?us-ascii?Q?10tjhHJmsDb6NijUSQb6qYzxa/s/lM9LplRDR8D0ukJ4OeZ3jco3eos/4Nzp?=
 =?us-ascii?Q?KjYcnQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8c2510-9c27-4965-5550-08dddefa0160
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:25:50.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEwo20JIts4ugYbcsR80pjDM4e+D2YbE6ExOjFJVptpJXC91nf/4ZYXaA7HwlvY+OZN1XE4OniBv5LDuO8ZQqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7988

On Tue, Aug 19, 2025 at 08:40:11AM +0200, Horatiu Vultur wrote:
> The 08/18/2025 17:37, Vladimir Oltean wrote:
> > 
> > On Mon, Aug 18, 2025 at 04:19:25PM +0200, Horatiu Vultur wrote:
> > > Nothing prevents me for looking at this issue. I just need to alocate
> > > some time for this.
> > >
> > > > The two problems are introduced by the same commit, and fixes will be
> > > > backported to all the same stable kernels. I don't exactly understand
> > > > why you'd add some code to the PHY's remove() method, but not enough in
> > > > order for it to work.
> > >
> > > Yes, I understand that but the fix for ptp_clock_unregister will fix a
> > > different issue that this patch is trying to fix. That is the reason why
> > > I prefer not to add that fix now, just to make things more clear.
> > 
> > Not sure "clear" for whom. One of the rules from Documentation/process/stable-kernel-rules.rst
> > is "It must be obviously correct and tested.", which to me makes it confusing
> > why you wouldn't fix that issue first (within the same patch set), and then
> > test this patch during unbind/bind to confirm that it achieves what it intends.
> 
> I have tested the patch by inserting and removing the kernel module. And
> I have check that remove function was called and see that it tries to
> flush the queue.

Ok, it's great that you tested it.

> > I think the current state of the art is that unbinding a PHY that the
> > MAC hasn't connected to will work, whereas unbinding a connected PHY,
> > where the state machine is running, will crash the kernel. To be
> > perfectly clear, the request is just for the case that is supposed to
> > work given current phylib implementation, aka with the MAC unconnected
> > (put administratively down or also unbound, depending on whether it
> > connects to the PHY at probe time or ndo_open() time).
> > 
> > I don't see where the reluctance comes from - is it that there are going
> > to be 2 patches instead of 1? My reluctance as a reviewer comes from the
> > fact that I'm analyzing the change in the larger context and not seeing
> > how the remove() method you introduced makes any practical difference.
> > Not sure what I'm supposed to say.
> 
> I don't have anything against it, like I said before I thought those are
> 2 different issues. But if you think otherwise I can add a new patch in
> this series, no problem.
> 
> Why do you say that the function remove() doesn't make any practical
> difference?

I had thought that the rx_skbs_list can still be queued to, through the
dangling ops that are left behind in /sys/class/ptp/ when the PHY driver
is removed. But it looks like this isn't the case, and the issues are
indeed unrelated.

