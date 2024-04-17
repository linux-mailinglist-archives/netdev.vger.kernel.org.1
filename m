Return-Path: <netdev+bounces-88908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E48A8FB7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10D1280DDA
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6B86634;
	Wed, 17 Apr 2024 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="eVeZ4WVV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2117.outbound.protection.outlook.com [40.107.236.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF42BAE2
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397960; cv=fail; b=dAUZ4eLRDb1mL0S9EgTPgJbeupoCsOhSkeYsGqfFUJaX1XlPWamJN3AAtDvnjZxKK0qGU+TfK2kewnB4apOIOqwPx4ONPiIGOqABRVRxt5RnlyurOQCWBPT7xxzukt7EpXe/1hxeWVB1yUjvWOklPORbxZxZaQwrgDF9F2tvzCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397960; c=relaxed/simple;
	bh=PGomePMGto3OwK4mDHpsntp+sB0SxlGUISUDV5wWzCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gc+MYWEBOJMzqIp446xqxAdAMvKPbpB7Hut4YL6EVIJLVOKYS/ZHmWNqUKfTdrB3yZeMHUyWdgpKqwJ2U16qOcus9r/370xNcnGNlSi3YC9Qb+Zj20v/eOooEjrYp6GxExymbTtkG3gZUseudAj027dbpovr/DD+oMWYZ/XVeV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=eVeZ4WVV; arc=fail smtp.client-ip=40.107.236.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDDPHSwAnxwWuXSx1BnyjM4oTsxa+T40BLyQgjSRuXNNPhfLFdVHLK9qJKfkB+6vJI/+O0k4wwh/JuG92F8VYvoy2/zaOE+WIIHtAhggqIpW+TaEiuIl+HBvsMsdu1/sJF9KZ3v78qkqZyaP201iWRSBY1Ourh28Wg600+2QMTQlZWRJ0U011Lbo4GDf/LjUlANxl9petGYXYQfAteLTS33DyOyoOX1GMABxWkGv0lL6uC9NmX0WuaKjkAoY5sLJPji4FkN1b5qcT+5mrI44PCzjNBnYjePUMNWQc8XqyZnNRpK46oiGDxAtY5BE+lX31Sadg7th0BNAYlztdL2PgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK8CFr+96GxmwaM/OnHzl8a8bLhsu+CMnXHbgo61EC4=;
 b=T2nLCs3jrCNtNXalWiABvCOj32bqKY0RWypcq/zwJXZwuTOo00N4i+jCIJspyfLcwWm2KYhvSgEd2Y0Nea/kPoJIOnakHnaK65XQ6eCzuVna93mlKwbms1h4RkGs+hWBNxpNKgVNr3B5q1cZDJXUsXCrkoIbz1r4xjcI0M8WAlkPZO98d/PlsQ5D/ZKbFOdR8A8bTLXG6rZDsDlqgNgunnJr9fLa+gqza5qaP+Lg3iu9UfG9qHc8lx4qADWWsbR/uiqi3m33PRtn1ZQ2xnIF3d5fgzeV6sh2ydUFKjJQb+BiYvDhHmbdxMf9HqOmVAHYLERYn+GHy/rmrikTXaG1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK8CFr+96GxmwaM/OnHzl8a8bLhsu+CMnXHbgo61EC4=;
 b=eVeZ4WVV3ZjYnknWcet8siGeqQMzyOSXsfgSFbUAJd+rzQ757Jj9ggClxCC6YMuXXFILsektUJR46SCT5xQA+HARaby8BgL17xviB3TTAgxI3fMzXI9zA7nSYTvhjDr9wdB7xBpc8OO8yvz1U1SZkZ1lgijdAnERZXXTnwvlk2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by CO1PR10MB4692.namprd10.prod.outlook.com (2603:10b6:303:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 23:52:33 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 23:52:33 +0000
Date: Wed, 17 Apr 2024 18:52:29 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Subject: Re: Beaglebone Ethernet Probe Failure In 6.8+
Message-ID: <ZiBgvRKbxrVSu6rR@euler>
References: <Zh/tyozk1n0cFv+l@euler>
 <53a70554-61e5-414a-96a0-e6edd3b6c077@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a70554-61e5-414a-96a0-e6edd3b6c077@lunn.ch>
X-ClientProxiedBy: MN2PR20CA0038.namprd20.prod.outlook.com
 (2603:10b6:208:235::7) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|CO1PR10MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b67e0c-1254-4b69-549a-08dc5f397325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rv6aa8zaveum+o/1/vaHXKvenDnP29ddFO2QgXgnC7ol6fGStHzZIRbDMUFog+jbV2L4nWV+kg19tzqURSuBkQ7KXR7YBdjpic3gVRn7SWXtJfLCKjh+38fA5bzNypHfSoeufhPfoSuHGeI5Pvn1gzlYa016Y3KxQ5eEJNHTa4sZlAitt4slqxKZT6julIswFOJgI6A6MeW5BC0aITQvQdXsv+GVgm6OoTQdsDUmzRZTHz9Vo+RLel2Ka3ipdDNuA2neGXIuurPBYD/OFeER12UeX2NbmKoS0Zvc86kZWhBzONGCf538nBj5yWiIk7V0jrNnChf/YR51wUQa3gD5lZxq8akcihvBbhpxg4yYHwlJBRUxt8f9op2dE1davRoK8SNny5YzN6XWAmk3Jok++NN5EGhWB8hUyHe3gsb6GLf1PgJrlOTQSKh9HtcHBbFCgx7wVmQZzqhGfKvoafDW3Tr6kUZn8j9b5YuEBC2NtPxhw3dOZMWqzrP9zLpZPPShgAJv6DrWscmnNCpaW3x22r3HiicT/D4dw4ojEg2SP+WY9FJRIWICu9vc6C2NFUbUiS4HcUdY2PB/ntOFljtKnuPMYIL5W8P0uPgTD07+dIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HEca34RFYcBrXdFtaD7fzm71wSkeyxZ6cWU5IZQHKF5mINFXczzZ8xVNnJFG?=
 =?us-ascii?Q?BeHWyPl2w1u0yc8W7AhSDLMoG5n/x7GC3DgieNi3GoWxXW6B0xqxLwY20HV7?=
 =?us-ascii?Q?Fhnq++SM4R9kxebKP+aBskYrOwPanO9+K/wdQN0C8XjWUF9XyDqYrlx2YOcv?=
 =?us-ascii?Q?5+KtPx120oPrWIwRjnVr0UcBtU206GEErwGaegSsBxBqKNkpzETKbQbHn19D?=
 =?us-ascii?Q?/2gqWLN6S5xw3G2xTobZhoY3OfHYWl8egymnKd8s3pxBL2E0iL7x82i5vlJq?=
 =?us-ascii?Q?8xI01xOLA5i2GeoxlEF7aihVHQfrhXVx/e3Nl05HQO0A4cczLrlP3uzj9zw6?=
 =?us-ascii?Q?6TZ60p1cqkUrp6OmsWhl7Dq9Pp1zwAEhBeUOH7eWSigzECukcZ7+WW1G5kh3?=
 =?us-ascii?Q?CPgIxSTjApuq7J9J4X7IOA+mROVrAM9axd8dJDZ3EV+MNlYlG6ziK5AEhz/x?=
 =?us-ascii?Q?Sn+T0bnYZFRf+KdTWwuGo0xHAOt/LF5Al7diP3iQ+StX9lcqdbUKVXLaSEDd?=
 =?us-ascii?Q?1XS0kVydsqVDTC3D0woWuLUsJOtfYC696l2WPryepBaBngPFSyvyo4MrgcBW?=
 =?us-ascii?Q?7ant3D4tCLfFinS3fYQgG7EcY99ZzFQm3yRCtOLc82JpBzkABnCfhXAoBAI+?=
 =?us-ascii?Q?5rjpEtzqg8aaYtmFcwaP0U9NOETGy+p5dqG6Xt7m3AI1iFLOyI5EpJQm2ESe?=
 =?us-ascii?Q?SQYIXI7xUeaBU2K/+fJExK7kahArxvBRDwWVowqvGzUsyp20A89feDb2kwnw?=
 =?us-ascii?Q?jILOmPvi+WPsrkd1ufKp2flILeP53hz/voz7yIJ8qe8PdfmpYdWYioFGC1W8?=
 =?us-ascii?Q?A8TrhHEpqgYI6ROcIWP5EG4Jk6Ckb4SoJ7uEDadhy4AorU+/c6452rhoSIf8?=
 =?us-ascii?Q?OGBGe2x2GNvHCrZZQqw9FUfIyYeF9lxRfgsZQKfRF9oLaX1ZMNoU5jDuIIrn?=
 =?us-ascii?Q?cacAjaWMfdhaQnurESEFRN8DbmiWDF6Wx5/iCQWnQqp1KOI+Pul9b7Z28NOc?=
 =?us-ascii?Q?g3abhZTkUK9xspaMypTRIoCC2jVMQWz6S1Npk2JIBv0mtvBn4SHJXzDpQx+X?=
 =?us-ascii?Q?OM0N84x2syBrDKGQYtZY8PJxuNCQFqnImXXKbqCf3cMamvu6D2JB3VaEqsSQ?=
 =?us-ascii?Q?hd5lAi7lH7AMQnIFTG0lxpu7q1PVVgVCyUHkLyCSOGdElpyy2MTTwmvQAH+7?=
 =?us-ascii?Q?ubZZ1lAPG/jmmZg4L0xhv5cr4Bdfrg6Uu1dLyt9xHJT8xW4PUPry1WKKkIGh?=
 =?us-ascii?Q?K0x9bBTGYG+knD8JxjJ7TsQcSsOCt+bVxp8I9H86LhnqeMz8WK75L1XsPAcU?=
 =?us-ascii?Q?x09SGQL+oV/o/DN3cjLQePM8LBpaw68pLLiTpP+8qPqGLf4fZ8LsCsfZvOwq?=
 =?us-ascii?Q?e2sEeGW/qs95BQdLGRj35kH1zp251BZLE006by9aR9GkUFkE8sARy1JhVdJO?=
 =?us-ascii?Q?xkEcXla6KeR1X5sUrtMUeYi5Tzzieqsd9O7nhzeHzyhFcceg5FP9EP8cBwz3?=
 =?us-ascii?Q?9aeC/7RiQq6rKOpgDFxTnb2p5DmRvQ6/2GSigFdTJoJmBVHgxwZSEEKHacrp?=
 =?us-ascii?Q?j6VcXSDLDANGHyNfr/6aQV6lKhf191rCytyBttpW4ZTt+RyAof0gjg/ljMsH?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b67e0c-1254-4b69-549a-08dc5f397325
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 23:52:33.3445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ7ipjDUDOI6niX0k//VAOq2LFqEPow4Yp3plPAKTBxtOcL5suivMlI/qdFyJTZhwp2+fnxaOELBIHM00QLd9PVvRF23Uuc3b3wYchyuUJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692

Hi Andrew,

On Wed, Apr 17, 2024 at 09:30:58PM +0200, Andrew Lunn wrote:
> On Wed, Apr 17, 2024 at 10:42:02AM -0500, Colin Foster wrote:
> > Hello,
> > 
> > I'm chasing down an issue in recent kernels. My setup is slightly
> > unconventional: a BBB with ETH0 as a CPU port to a DSA switch that is
> > controlled by SPI. I'll have hardware next week, but think it is worth
> > getting a discussion going.
> > 
> > The commit in question is commit df16c1c51d81 ("net: phy: mdio_device:
> > Reset device only when necessary"). This seems to cause a probe error of
> > the MDIO device. A dump_stack was added where the reset is skipped.
> > 
> > SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> 
> Can you confirm this EIO is this one:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/davinci_mdio.c#L440
> 
> It would be good to check the value of USERACCESS_ACK, and what the
> datasheet says about it.
> 
> The MDIO bus itself has no real way of telling if there is a device on
> the bus at a given address, and so if the devices actually transfers
> anything on a read. So if the resets are wrong, the device is still in
> reset, or coming out of reset but not yet ready, you should just read
> 0xffff. Returning EIO would indicate some other issue.

I'll look into this next week when I have hardware again.

> 
> > Because this failure happens much earlier than DSA, I suspect is isn't
> > isolated to me and my setup - but I'm not positive at the moment.
> > 
> > I suspect one of the following:
> > 
> > 1. There's an issue with my setup / configuration.
> > 
> > 2. This is an issue for every BBB device, but probe failures don't
> > actually break functionality.
> > 
> > 
> > Depending on which of those is the case, I'll either need to:
> > 
> > A. revert the patch because it is causing probe failures
> > 
> > B. determine why the probe is failing in the MDIO driver and try to fix
> > that
> > 
> > C. Introduce an API to force resets, regardless of the previous state,
> > and apply that to the failure cases.
> > 
> > 
> > I assume the path forward is option B... but if the issue is more
> > widespread, options A or C might be the correct path.
> 
> I would prefer B, at least lets try to understand the
> problem. Depending on what we find, we might need A, but lets decided
> that later.

Agreed.

> 
> > [    1.553623] SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> > [    1.553762] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
> > [    1.554978] cpsw-switch 4a100000.switch: initialized cpsw ale version 1.4
> > [    1.555011] cpsw-switch 4a100000.switch: ALE Table size 1024
> > [    1.555210] cpsw-switch 4a100000.switch: cpts: overflow check period 500 (jiffies)
> > [    1.555234] cpsw-switch 4a100000.switch: CPTS: ref_clk_freq:250000000 calc_mult:2147483648 calc_shift:29 error:0 nsec/sec
> > [    1.555343] cpsw-switch 4a100000.switch: Detected MACID = 24:76:25:76:35:37
> > [    1.558098] cpsw-switch 4a100000.switch: initialized (regs 0x4a100000, pool size 256) hw_ver:0019010C 1.12 (0)
> 
> So despite the -EIO, it finds the PHY, and the switch seems to probe
> O.K?

Yes. The issue I face is actually down the line when I enable the DSA
ports. I haven't diagnosed it yet, but a separate reset happens from
within phy_init_hw.

Here I've kept the dump_stack() from the patch, but removed the
return, so it is functional.

This is why it seems like it might be a bug that everyone is seeing, but
nobody is noticing... I hope to know more next week.

[    8.581463] EXT4-fs (mmcblk0p2): re-mounted 084255e0-9101-48d6-af17-9601fd9c5a1d r/w. Quota mode: disabled.
[   32.500235] cpsw-switch 4a100000.switch: starting ndev. mode: dual_mac
[   32.522610] CPU: 0 PID: 166 Comm: ip Not tainted 6.7.0-rc3-00667-gdf16c1c51d81-dirty #1408
[   32.530962] Hardware name: Generic AM33XX (Flattened Device Tree)
[   32.537090] Backtrace: 
[   32.539561]  dump_backtrace from show_stack+0x20/0x24
[   32.550363]  show_stack from dump_stack_lvl+0x60/0x78
[   32.555461]  dump_stack_lvl from dump_stack+0x18/0x1c
[   32.566238]  dump_stack from mdio_device_reset+0xc4/0x108
[   32.571685]  mdio_device_reset from phy_init_hw+0x20/0xb8
[   32.580713]  phy_init_hw from phy_attach_direct+0x148/0x340
[   32.589911]  phy_attach_direct from phy_connect_direct+0x2c/0x68
[   32.607416]  phy_connect_direct from of_phy_connect+0x54/0x7c
[   32.618889]  of_phy_connect from cpsw_ndo_open+0x30c/0x4e4
[   32.630096]  cpsw_ndo_open from __dev_open+0xfc/0x1b0
[   32.645608]  __dev_open from __dev_change_flags+0x198/0x218
[   32.656909]  __dev_change_flags from dev_change_flags+0x28/0x64
[   32.670656]  dev_change_flags from do_setlink+0x258/0xed4
[   32.681789]  do_setlink from rtnl_newlink+0x544/0x87c
[   32.697294]  rtnl_newlink from rtnetlink_rcv_msg+0x138/0x318
[   32.713408]  rtnetlink_rcv_msg from netlink_rcv_skb+0xc8/0x12c
[   32.729702]  netlink_rcv_skb from rtnetlink_rcv+0x20/0x24
[   32.740825]  rtnetlink_rcv from netlink_unicast+0x1b0/0x2a4
[   32.746435]  netlink_unicast from netlink_sendmsg+0x1a4/0x408
[   32.760001]  netlink_sendmsg from ____sys_sendmsg+0xb8/0x2c4
[   32.776110]  ____sys_sendmsg from ___sys_sendmsg+0x7c/0xb4
[   32.792046]  ___sys_sendmsg from sys_sendmsg+0x60/0xa8
[   32.803952]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
[   32.809212] Exception stack(0xe0c3dfa8 to 0xe0c3dff0)
[   32.814295] dfa0:                   00000002 0054ecc8 00000003 bec65790 00000000 00000000
[   32.822514] dfc0: 00000002 0054ecc8 b6f54880 00000128 00000000 00000001 bec65f32 bec65f35
[   32.830731] dfe0: 00000128 bec65748 b6e4e52f b6dcce06
[   32.835809]  r6:b6f54880 r5:0054ecc8 r4:00000002
[   32.979240] SMSC LAN8710/LAN8720 4a101000.mdio:00: attached PHY driver (mii_bus:phy_addr=4a101000.mdio:00, irq=POLL)
[   32.994721] 8021q: adding VLAN 0 to HW filter on device eth0
[   33.020751] ocelot-ext-switch ocelot-ext-switch.5.auto swp1: configuring for phy/internal link mode
[   33.055444] ocelot-ext-switch ocelot-ext-switch.5.auto swp2: configuring for phy/internal link mode
[   33.089784] ocelot-ext-switch ocelot-ext-switch.5.auto swp3: configuring for phy/internal link mode
[   33.124241] ocelot-ext-switch ocelot-ext-switch.5.auto swp4: configuring for phy/qsgmii link mode
[   33.161283] ocelot-ext-switch ocelot-ext-switch.5.auto swp5: configuring for phy/qsgmii link mode
[   33.198704] ocelot-ext-switch ocelot-ext-switch.5.auto swp6: configuring for phy/qsgmii link mode
[   33.235518] ocelot-ext-switch ocelot-ext-switch.5.auto swp7: configuring for phy/qsgmii link mode


Colin Foster

