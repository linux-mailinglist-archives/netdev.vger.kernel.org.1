Return-Path: <netdev+bounces-145485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7C9CFA93
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F50B35167
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BE19049A;
	Fri, 15 Nov 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l5LqMcMl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980918FC8C;
	Fri, 15 Nov 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709833; cv=fail; b=HgWoprhgZCEP422Raljy7DZuVWbY5g/XDV8iZU0owsWV6tbG01ah45zyAqTWxWIy/+UEXZKtIzR1TVF1VXAakj9Pqdscr+wjgYzdbd8eFb7ihpBIo6vODPhJRtIJNYm2gZ3Wk7J7kEnU0l7LzX98BcFr88dFaI/jJvFzCmsrpxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709833; c=relaxed/simple;
	bh=v3RLfKIjWqA4EhBTcN5uEvyr0ws4ymaCIKhnftVkCnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UI96YOtJ04d6Yl4C7sig2T9eCHcFzTieq4Ibk57Z1UT+8yp5iKQBBR6EgWIGaBT9aoT5oAQj5OoDeilWKwCxmI82PqjXC3FgoNIfpStDTP2AWOog+BuA+xbF8wbLQh9oA7M1dpdJnWaArX+w5sofAlLJuryj9JSRYSBgqBw3xTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l5LqMcMl; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWx6vC3K7cD3ushKn+jYCw1pqTyoX2mVxiW4XFotlN18ec+VG+LHj70lBtEk5zGfv5T+8nczOMs9pEHw4FFrIgrmcJRelbKnez9XQiDnPpBV1dvrc062csvsJInc6mBwwBd54wxyhQOMErFLVVA22m7ECH4q+dOiutPvSHFiPM7D5JB+sFL3+q1XlKc294n5wTU4inzHWyvGHs3lZMSaIybB0cnjcgFZcXNgxkAwe4Wy5MXmi2WVW4dh9p7yZy1UbdGM1PT5za5kybJfvqI1/68aBsPewudWXnJvDc+2wBmxQt6VWD/D6YJmFqJtgW6CFh54cHyGEqv2KAANu3HfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3RLfKIjWqA4EhBTcN5uEvyr0ws4ymaCIKhnftVkCnY=;
 b=OJ+aReQtwbcyn3F5iaB59xRXpzvDTptTeRXa9u38tMkwKyZ7GN56/2QnS+WGG2rtfdvP2IhO4HPtHUu/9edlSYCraeMLcA6IA4/a+TdpbCDaZDy+3Gb5uXwK+WS7v4jERw2hU/5gjmOG/Tj3ovUin/df65A0E99czW/zbOwmtfHMLcitHN6D5vvnH5+/Nx7IMTy7oTG6TTsfJgcxHZsikKWTKwYVFE80pyEKK2WuXc7JlZ+J6PDis6AGQvZncKC19uTRNR9ylQ7JusVZ5mtxseure4lM7kY5+R+7m/mcBayqdzUxCuiiw+jcC0pbLhSA9Wo2igdPLLLVAjh2BC+beQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3RLfKIjWqA4EhBTcN5uEvyr0ws4ymaCIKhnftVkCnY=;
 b=l5LqMcMlyLw+2LRLU0Jw7Fpc87PGhzmvLISyFm0Inu8TRIUSyhId5vzbX7AbRC92iMCAcrE0eM+MOQyIyeUUdOIEPU6JbczmaruP0d+qijKMbcFzrie9YeLaXsj83fQMcVIwTsM6ouHP7dq6KP8oq7BWoxF9PimujYfyx7Rh6UibK63G8MK2vL07NRiwvUd+GolZxRwh15eGMQLIsDq8w2idcRG579GWyqEWA/g+JZgsohiEQFuZUU9kCS0xhXeu6ekJe728KH9jbESHXHk7+AV3HfMcM58IvTRWoLzeJ1zDl8dtlwj6gG98kPvTU8E//iXhEhGiKaQFOQ7/fu0zNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB7135.eurprd04.prod.outlook.com (2603:10a6:800:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 22:30:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 22:30:24 +0000
Date: Sat, 16 Nov 2024 00:30:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next] net: phylink: improve phylink_sfp_config_phy()
 error message with empty supported
Message-ID: <20241115223021.6asyclq7bhbqxfjw@skbuf>
References: <20241114165348.2445021-1-vladimir.oltean@nxp.com>
 <54332f43-7811-426a-a756-61d63b54c725@lunn.ch>
 <ZzZCXMFRP5ulI1AD@shell.armlinux.org.uk>
 <20241115161401.2pfnbnsl2zv3euap@skbuf>
 <26b6ff38-68b2-4c9a-be20-99769cba07c4@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b6ff38-68b2-4c9a-be20-99769cba07c4@lunn.ch>
X-ClientProxiedBy: VI1P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: f811ded5-3989-4add-74b3-08dd05c5193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RyhRwRfbCDL1Sv5yoN5Q7F31fgZBAfox8CyzwswwzSsohT50Z03i9SIa7PjA?=
 =?us-ascii?Q?smyPqHA3amr2Rg85RIlTUG6787oZ36qH0FxTCulb+buoNUfnH5Ng4yWPVuu2?=
 =?us-ascii?Q?s33wNBs5HeMarvCvhpj0Lb/xitSyCptZIk1GHeY2guWT5Ps8qB48BfIWVFbJ?=
 =?us-ascii?Q?huDrbvdmey9cdLmRdzVTjabVcpMBt0iTkq0G1Nt2RzmPwIhTucTKFpoUJbfK?=
 =?us-ascii?Q?F4yK1Qn5Aowgm+kDheMNkkXnb2jEKhZ9r/VaeOJ2cUL3sv4q8g5jSMnvJTOX?=
 =?us-ascii?Q?X1aPHUrW0IkSi4MzBDo0GD+eeeR5mTeuyp2dZm4++M7QC7jwUrVdRwCsqla/?=
 =?us-ascii?Q?Y6l3btHhUltEBraqCAuGXaM9CocRUm6K+gyJRtSz6Lp1WhL9D7bNd0HJixSB?=
 =?us-ascii?Q?L6CSZ093guJAf8YPR27wR0LCuXlaGswlBxLodLh26cdE5VhbkPUGDi2FUvew?=
 =?us-ascii?Q?BQ1jXf/8XtqfDCjDAvV0KOd+5Gje8z/nXxJZplkPxRU/P0VCBpuoua5Gb09P?=
 =?us-ascii?Q?8ZwAqj5wSjNMOuIh3J1Hd1u+smYvEWN0Mabfn0Lr/fgApnmB2Jl5B/YTEHUJ?=
 =?us-ascii?Q?HVjnartURTu94ARDcBUDtjjtNmuhbSNPGJe7gaFrK0U49/2PH0dOyyNlnUnx?=
 =?us-ascii?Q?3GLa+6TFaUhp8smWUylUkCcbDA6c2jM9y87of1snl3oMvVBB5JBi5eTcFf5P?=
 =?us-ascii?Q?5K1X+KrIFo4T0VKZHZDXN7Qwq1PxR+6Kiam8DM9pbz8MVfGXlCBZDY5sqof6?=
 =?us-ascii?Q?vx1RG3ghV5ZEcvNOF5Fbb+9sARqBdQRTxqW+vSA52FBZO6NK/be/H0PX5EIp?=
 =?us-ascii?Q?+KGA+kP/zJrcuEZMlhkC4l7XbKbWCaov8gnX59q8EwPmHDF/O3zE0GYNx+xE?=
 =?us-ascii?Q?Q3n7CGFAPg7r1GEjfaU+G6itfSB1M46I3NpcvUQ5CU2z0mkMaBk1/dgWzLBo?=
 =?us-ascii?Q?DviKs+4h/DiYLT4c3hGm+PJOUdJCa0eObYZJEXRsRDwPx1truZ0id22KIcFq?=
 =?us-ascii?Q?ZZXk8VSdDgm+JpT2JgTZ8mYJQ5obprpTdLrDeBm1T7myTvqRRltuWzBoBJF6?=
 =?us-ascii?Q?jtjdyCmTV9z7wHvcWJ2Ta/3Ye8/5BJECVd2ogqlVTcb8sXC9IZ8ITNpAzNCJ?=
 =?us-ascii?Q?0/zLK3NhiY7c1Rl1+mXHtvwNZuOmxCn3dMOsl+51ezRekBsd4oSoTX0HiSUN?=
 =?us-ascii?Q?UYQ28I4cjK2JNvrDTBL0/9IH+vIkZJOOZ7VdqNwTAqsYP7X6cJuoNsWV7E0o?=
 =?us-ascii?Q?CAl+QdVxM7i0hCedLnQ+hTXyFsGCPqDnaIpxxYKfl7J/qTCxUC04UKheljNh?=
 =?us-ascii?Q?L11PagsZi/myS5zxGdHkKgmr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qrGHLari1rDA0nVDc/Juo9kFbKhb0X5Mb/X+9onvs3VFzjJo632weotegiMt?=
 =?us-ascii?Q?6JanWnrZHyGOEVOqUfVT3deYEICRAxjYboVXXGUEh7xGLGv2OeK3eI4o6pkm?=
 =?us-ascii?Q?TSEwdKpL2IGgFE83o5lNfspikTSlzrpQkYQt0GaxqFKJaSV8WDaDvpCrRmZd?=
 =?us-ascii?Q?EWmP7OkjdGxm+B+0OmxGFW62BKL0GDqZFi2q91EDHssi64EXrMJUabLpLfWu?=
 =?us-ascii?Q?rmQTkDIrlyal7o4H5C/XOc6+rhhrYkUm/kpM0HYVg/E8Qi1Tp8IFZ5iwHap3?=
 =?us-ascii?Q?gwZr4E1Mpj9ZSIl0HvBtRHaXMjMa5b/hY3Y62/qUQMeLnXr6/I4QUqX0lp/F?=
 =?us-ascii?Q?Y9EdvFAajBgVCzK6rLy2aetbPAJJxNbbFjq/m3iacSqRymcm1o/qAdAQA3Sh?=
 =?us-ascii?Q?Sxom3HT3FC67g+iNaf6k2d9nw5uHAif/i7QHsKYjTlLwyXzZyGvPJguwmLzj?=
 =?us-ascii?Q?BT6Wpa03GT8rBymS5Ng+pyYoTiiZaIJt2Yr5nYugxa6U3dtorVaHR5bPaZYc?=
 =?us-ascii?Q?IASOcBEAcwFub1p8Gu1Y+yZz0c9joxF+2klYxggBYFN4Kfa5Wsyh7ZMnoMp+?=
 =?us-ascii?Q?EiJFUNHe3KEuTOQU6LvmVPVPPR1tfRwrhYoHDLSsRUOUqSiVfWL825SLFVVf?=
 =?us-ascii?Q?gnRUwP3SqsLvPurFlNmPDjMIPPckvg65vr7Q3Gem9+bT3gwXsXI54udTRR6d?=
 =?us-ascii?Q?YlBQmqzChOpqsMh5FXV6FZxyegmgaCn5LbCXLuSc83whxIffp4sWI+4LOQXN?=
 =?us-ascii?Q?xS5Ie2Srp70wUeWNMd9ElFqYztYgi0n3Bh/GjomNH9Jw2w9DDb4HKZCFk+QH?=
 =?us-ascii?Q?KDPXJ6L/u1mntgUiahzm2oVyAEZC6ZwzAcxGYl+CMXE+suWG40qTfPB1KPjv?=
 =?us-ascii?Q?eVfCg3D+ZwX47/AN46xymjjetRjGxGtjynhTq5kRVFpaInaJi1n0Mni0oLzS?=
 =?us-ascii?Q?e4qJXU+NdqjvkjDbpA4b67OVUrBbjD+WUo3sL4ZPjmSa01qyzuidD/9+uIrO?=
 =?us-ascii?Q?bnamD4YZMifffTj1g2yJEUGB0NgtfnWc3s1dgIP50HSKkU0EihxDs8sLrOdi?=
 =?us-ascii?Q?B6SOmubveke13Kzib3NqsENsJl9qIb12/9VJA6vM5f1uUBtnVZS14K3WaRt6?=
 =?us-ascii?Q?Luk+m99GOngHdmoa3qT4Gi1nwKhOkAxSyaAQkSxYtZx94Eg1d9VEBH/DAYmv?=
 =?us-ascii?Q?olRTvPOAtbVRuefpkxIFXrFmbtnlFvD573RYgwc+akYVZrBHyjRKzjSdWlj1?=
 =?us-ascii?Q?ITvo+vIz0PdsWPQdo7uQZ1QLeXduw67veMJ9d+CTrfBPMYlt1bOAXIZaV/ID?=
 =?us-ascii?Q?zZnt+xgIMAugEaFAJL6fDrmBbjmx3U7uZh7QXzL49VGB3OnuFG+kcHaDcUQJ?=
 =?us-ascii?Q?1OgZNHmiF19dOiJBlxBcd6KiYal6ZyTEsSBc/znVME4TbsPpBcXkIzUjJJIo?=
 =?us-ascii?Q?ur+UPDZvjq85WLzegf/05SaLHVD4wcH4YRhna/ZeES1fk1h/TaPjAWXKVwQR?=
 =?us-ascii?Q?pBfHrHy+4KO4yf/GmpD8bmUFlPdaHyE7SFxu+4FCFpkzbBJD9J7DnQ/XE0od?=
 =?us-ascii?Q?T7JcQF7uzbmMph5Z2bdSF+gQpA4F4tRh96RUfBW6atF6u9j7XXxSmfI+QrdI?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f811ded5-3989-4add-74b3-08dd05c5193f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 22:30:24.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mv9/1p81tkmfeRPkXFPLxZnpwg7FyjM0aFX6YOOVeyr5PtoqHoT6l4PWyagGjbOcyBd9cOHA0MFah8hsChW8uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7135

On Fri, Nov 15, 2024 at 06:51:00PM +0100, Andrew Lunn wrote:
> We want some Makefile support for extracting the MODULE_DEVICE_TABLE()
> for modules which are not enabled, and some way to create a
> modules.disabled.alias which module loading can look at and issue a
> warning.

Sadly, for me, automatically extracting MODULE_DEVICE_TABLE() from files
which are not compiled in C is science fiction.

Also, I need to sleep on the idea that creating an association between
device and missing driver might be useful kernel-wide. I'm not prepared
to handle the possibility where we make that happen, but it gets push
back and dropped.

