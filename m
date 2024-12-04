Return-Path: <netdev+bounces-149026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73DD9E3CE3
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61321620EA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A220899C;
	Wed,  4 Dec 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="daJTnd2i"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB21FC7D0
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322929; cv=fail; b=O3SMNQjoSR4ELDrgdcgXkRt9MLVGolFrI8liQnfSlQnR4C2m4fKKiIruQ04obEnmiAv5XfTkDKmULENHNwNxwcMgnAFiY7vh95K4JkHSuESYGEqAPVWZSdIV9ubtq2hmAT3J1dKLooC7IrhlruQErAev7NlEvsJnIKqkoBoBfi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322929; c=relaxed/simple;
	bh=cbAE3aLqGVuOsyLAqW0ALNAquVgKoK16IXp/B1AEgXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UVue42PSFFKSP6DAFz6JAGITR4jJ9T3kNuDXxeINnTpBisyBl9PMJZgU6u1gjv6Wx9fadkiY+OeX2Hp0d3UG7UPwC7WR+4tRaxKBngDW6ROP92C4EV3CpbLgD/nnCy1JUtruHSot4dWMT4BNMOAO3BCFpUDt39ieejhYX8ev368=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=daJTnd2i; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk+vDfjvfO6ltpsrCLZC22yja1OxOzXg3kP5kPI08taEb04U/prKYHB6wjFQFHszk/ASz7isinH0Qrybf7q3LBvWAtnwyuSoeJsgIgWFeO85uTkC0BzOzF3IOTj0KZJlS33ak1eREqczZovmEg45ezSXrxnkHM8SF9MeS4j81/gNNAZedM2S4C0j5CdHmc4ea3O2axWSjWMOTKkXd8qmZEgBpHgUKhtVSeJcXimJ2+d1vp/QYiXfV2urpRI628Wu+5WOGvdAYX1qwPkzb7YzE2HoBjeaQwxyTOZzBFeDFjA/KtmHOZTRBi6Zy+4mQi8EY6YWwjtSptNmSsayvmRBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc6SPQdgesBJAhx2RAwY3HtO1D2R2r8vFoRipd1j87U=;
 b=TYME6yeX8wHli0jH52yEWSqNIzPbeDG3kN4/RUBJESA2Efi/KaqK4ZFaAiyGXZAEx3VVWpDmCa4Ad3iHIgMT0z2gbzvEqz+6vIXwXwApWxrRPgEiTsu0NaiUi1m6Pc7rSTGYfb8lUm1BzItI7dmVYa+rrUt1CgL03CFDgB4R4vfVJEPPO9+lvd4QxnoCol6YydgkurWHvFI0ERtODOO0EPpeeBLkf1cBxP7y7KUwEBcFuPuUK8RvAnFaNh3BwHE5cqsCc4PJYcovgPkmL9jPMAZ7gA4lo9snuttUT3BaS2GRpAsVm7CQ00sVohsQzXjy0cldZVSV7u3563u+lPkoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc6SPQdgesBJAhx2RAwY3HtO1D2R2r8vFoRipd1j87U=;
 b=daJTnd2itwt/a+8b3lzxF0tP8aK2tfP2HgOjEsvxZTun93ygr87VBbjHw1Qms6Rt5DU0jP7BGLFB4aBFWQMjcUPjPkTiJV3K3ssNqxcWVA/D0yllkGudzvDqQymayLwqWWbmbOdzzKQWq/QsYE4k8C1rimCcW4aDdq1vDeCehgTGph6gmOwKXaMzhhRPfd7EfNbL+MJfYyXXC1zMogsLcm0zTG1NI9TdopPWx0JY6TAcrv4z4W7XoG0B0WYbvCPjAKMYr3CdrBAOvXizAMJIFUfD2fuxI7U9Q4xNB28+Cf9/9G87C1D+yeeloHIFIGaZiKoaw+E9lNlIMY+/zA07ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 4 Dec
 2024 14:35:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 14:35:24 +0000
Date: Wed, 4 Dec 2024 16:35:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
Message-ID: <20241204143521.z5hccxlz2vnyuwz5@skbuf>
References: <20241203170933.2449307-1-edumazet@google.com>
 <20241203170933.2449307-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203170933.2449307-1-edumazet@google.com>
 <20241203170933.2449307-1-edumazet@google.com>
X-ClientProxiedBy: VI1P195CA0084.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 2449268a-9709-4947-e8bd-08dd1470e337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ndpDhfce/yh4L0gjA7B0qDe3q+7KH0m9AOfRF/iwX+BQSpS0zFK/u7WUMj/w?=
 =?us-ascii?Q?T0+Zri/UiOBKrec2SFka4Iy+uBukmd8mgascJ8J6vrVlNRG3bYR9eEoTWqZ+?=
 =?us-ascii?Q?j1Kr+rLa0QDyh3IEd9uOCiX/PsnPZaFEAIAfFExh936mUNAlugYoikb3M126?=
 =?us-ascii?Q?NICCG9rLkx5CicviebmVsDYskSG30vzawGFmC7tmhbBMgC8AckQ5QKtCC9HL?=
 =?us-ascii?Q?YJiYrpmmT3HD0kpQT1vVCBENi7HAZN81VlsLzpEF3JaByMXsSXnMrkPd/emp?=
 =?us-ascii?Q?rdYB7NgzwTD1KQijfIdOL0ZpVnGUwnF6GeBOK67SyJ1DvYMwLPEugVLyTOkV?=
 =?us-ascii?Q?S75TfQRRh6hsfEOVFncII0SiHONjm5YFD561ugYf2X0EK2tx3/85HIQEzpyp?=
 =?us-ascii?Q?qLckx+v1xiBwf3sU5JjArc2PehdwX78R+oK+972rRqi+kUObEbIWE1dtJzCG?=
 =?us-ascii?Q?4kFp31dv/jP93Dsw1I+AqwHLXv/zge1A1f0PrZ9bJvVnJUK40QoIy9REq2np?=
 =?us-ascii?Q?HExGC9gYG5qFDrLMQJt7PW95SdaSPtQhEmtRmsAILkgIyxiKYUIa50oniEkR?=
 =?us-ascii?Q?ZR9gewFDnT22KnKKjHmHzUsZfZ9T8Dgml2dA3a37+DVTRUKmph/8yO12U+6l?=
 =?us-ascii?Q?cITi6tQEc6jv8OrOsYd2+9pyWxiVdAMJOfyYM5SmEPeORtlQ/+FVeyuL/6YE?=
 =?us-ascii?Q?hEXB0HR2oVi1pg/dxR+KXZh5pDBJ5hCebbZEhnckkLxxAJNJ+zQnufWb+aUs?=
 =?us-ascii?Q?N5Q3PGVWZLu13MX5+eaEkCAJuhAsBV3DlSR5IB5/uV3q2sZT12vRaTkHWY66?=
 =?us-ascii?Q?IRkQjtpZxTKFG8qx3dEcPvTiTM9agtdLEqhQkYKhUPKrryg3RW4r8W8g1nOd?=
 =?us-ascii?Q?Qa0MN/1uX9n1ry0hm232vWTa5PXNavquYB85CiINTXlq84Mvo8kRHHQGSqg3?=
 =?us-ascii?Q?j4LEDXVT7SZS4QiPLV3WXEo+p2pgRicUREOAjZ5L8b8p48A3Fja86xvNQUML?=
 =?us-ascii?Q?3xIaPeefYqmNO7b2vEHETeBSRMd1P1Ji9UMIDsJCtDNiFrDcTXurlzRNHs9/?=
 =?us-ascii?Q?mWjKS8m5ik5kOKxWp6y9mVn2ePrkss5g+uP8D6KhZLR8h4fi34V8b3GOO9uF?=
 =?us-ascii?Q?7hGxsfyxU4mXVytIyOfqTAH2xafAE0Gwj0BqoP5fEXR8E0QZ5s4dvy15JBJw?=
 =?us-ascii?Q?FwGq0lyqWsjbdel5zFDRoWFxOUe7Ea81PKcrFJ9+cVnIAgDcdPpVu5hFuN9d?=
 =?us-ascii?Q?x9oDAhT2lez2hI1QYOpufJ6zVkrgluqlAvKy6OYoLx1V/a3J09i3mnNJIR3G?=
 =?us-ascii?Q?zYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/gI2d0thC3kPi9W0RXiIcr/gfTxsyuXnKo6YTBf3gE7F0BK9GCM4nDXIePNj?=
 =?us-ascii?Q?S2+JxJkCKexiqpI5R8bzUNnCH9Y+aIqG9M6ACuHHDzWX+vTlHjKMy32QrAQ4?=
 =?us-ascii?Q?CraXSUToxeNoCoFuM4IbD4zotIN1eo0gKLkxTr32hztmYGkJsMElLX6S0hfM?=
 =?us-ascii?Q?lPqHqjjNzU56IcT7erkqwzu7tNoxA4Rbc6mqkJTk8amJ4j63GBGcsHxvJhJk?=
 =?us-ascii?Q?wljNti/JNJFRWzvoqyeTXvrtiEIwO2opWFMQ09Bv0ibNBHJGQ16tW0B7jOFJ?=
 =?us-ascii?Q?DW4fTr2prAV1m2TNf3dFY2DuoDiO1g1OjQ8VYhgkpAENO6+xaFYvpp0wrQ8c?=
 =?us-ascii?Q?A6vssNwhEkXbOjrPgwdEzitt309K9WjJGbeS++CdW/psNRX3NlSOWIrsmBYf?=
 =?us-ascii?Q?zzcxWVsRKh3iDLD4KCgYtzd6jC3IpefStwiOEoWdcgwoy4k42/JeMEaO/2sq?=
 =?us-ascii?Q?lSZ1MrgraTv8hthxjnszKU7XGjSWnTLfBD4WHlH37DRhWATpw2GYA3fV3C9r?=
 =?us-ascii?Q?Jmm6/8gozG9nOJqT0jf2lv1Amyx3LiglaxFey9GKIDK2O4lva1YOGGfAwsDr?=
 =?us-ascii?Q?1YqJdbKfRt9+UrFkGp4yajjaWCfda35gOI8y6hritguZVXq5swk/PsdBSx/j?=
 =?us-ascii?Q?A+84wscb7SjqfejX++wSbgo6I7K2NCaQ8GioIbaV++ej9E1dNU46UP1sLboV?=
 =?us-ascii?Q?z26vTIlalWIFGihkn8KGZBA8NDOIbaAnARJwo+vqEIfFZ9FtJyIt0lVtONR8?=
 =?us-ascii?Q?QGvxDMKS93H5Grd99ld9mcZzFT5K1FxvLtMnHdpoJe8DN2+6f0dH+qHTpeAo?=
 =?us-ascii?Q?vj3CQ3Dt6ROqSPVqhQztcwNOSfgxGWOur4Z1CcjEyuSN5z8M/1FYybIoHGKy?=
 =?us-ascii?Q?oMmf20ImF/tFKEjiRhlNFmYPwp2aj5j099etOCBDdxP6qtOtpHd2a9gSGbbe?=
 =?us-ascii?Q?LZFmQlg6cpAJxWryHeHMhLZQNIKW/IUuWYmXiQfl40AtjZAjCF95Hx0X8e5I?=
 =?us-ascii?Q?Hu3Q9P+3XsHfRSe42sQGXerHM3dzFdnHslfIsX4u29VJzvdasrTxqpXDETXK?=
 =?us-ascii?Q?poN3CuArft7RXrKtT/tlgFdM0NYpBSU+ISojma5JcfZSBr6p+0dlnmwe6ghj?=
 =?us-ascii?Q?ra/ZOLlTIxx5d3NGgzo34JIMw78TLss+DVYCaoss1BiM6RPXmFM0g5gYnp1x?=
 =?us-ascii?Q?GbOwS/Z+of608I3h+KVQkU1yckJifQ+EmBWR/VJR9k8oroQVTVG78jV6kf1B?=
 =?us-ascii?Q?slXYTooZfBIrzkIxHWTSfRpyNlKMIK7tXUmhKnpbn0mIyZCH3uKaISr7MW6G?=
 =?us-ascii?Q?2nYKH9BqTGGW9S3wNacysiKdEautIdU+kxkZBL91PRnWVSVfsXbvWxlYPpd0?=
 =?us-ascii?Q?vzPweJewnGnKpwbL0hZj+b87wZnAXiXCf+ZFVezNNsqRmFfPeGkAOHmaQMgC?=
 =?us-ascii?Q?3vniE6z1QvfoplENxuds+KdqWJxHDYVxtg2Oi3S3KrI69Ba3HVG/KUe25+j/?=
 =?us-ascii?Q?Jna4UNKX9hrhu2TR6jCLmxgyHqD6UK91ZE+UssNNh8b99EoIq/XTV5ii0wxN?=
 =?us-ascii?Q?ovxdYYi40Ui9dk96YCiYoaND7JepHhcPof36uXwQhv0Frsp7/PLerKQUftjb?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2449268a-9709-4947-e8bd-08dd1470e337
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:35:23.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfTCzGJg6jJRwhYIBNiusui+nO22s9wn/WwcxlFbOW/Eept2WoibrOuQ6kP80LoPH1DgZZHEvGxQafB+NAHsNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620

On Tue, Dec 03, 2024 at 05:09:33PM +0000, Eric Dumazet wrote:
> syzbot reported an UAF in default_operstate() [1]
> 
> Issue is a race between device and netns dismantles.
> 
> After calling __rtnl_unlock() from netdev_run_todo(),
> we can not assume the netns of each device is still alive.
> 
> Make sure the device is not in NETREG_UNREGISTERED state,
> and add an ASSERT_RTNL() before the call to
> __dev_get_by_index().
> 
> We might move this ASSERT_RTNL() in __dev_get_by_index()
> in the future.
> 
> Fixes: 8c55facecd7a ("net: linkwatch: only report IF_OPER_LOWERLAYERDOWN if iflink is actually down")
> Reported-by: syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/674f3a18.050a0220.48a03.0041.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

For now:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

