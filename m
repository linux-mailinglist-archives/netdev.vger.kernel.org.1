Return-Path: <netdev+bounces-214906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5EB2BBD8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F9D3B8F0E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8AF3115A3;
	Tue, 19 Aug 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7qaIdHe"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA825F984;
	Tue, 19 Aug 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592074; cv=fail; b=dteaX2BHLjzgK0GW8i8ap4+YxeHoFsrmy9kneM/gAasrzSO4atE+z3O/9hgwyPBuUqUgsipNCG6h7VmVhWnRHpG2EpZvW7wywEOUU6g/h6j0o1m9zKyypji7VC9rYdFq4Iii0lI5JTe3E0xkcpyjmL+d9vANdNUVhmAIjiTMfLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592074; c=relaxed/simple;
	bh=Ti4JJ+I37Jr88O22WS23KsvQKXCHAiNJO+LXJ2XzfUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qjGD4fnhuatwxgXtmMxCvQVwUFpLGMwIrcS5RgT3rkvr8F71QT0rk+yg9mMYw06MLQCzz8kQNVkzmItv912eF5EFehvr6YOmFOALA2nGeFmwmXRbLtOAOiXHyKX1vzOyX1CBdslUr+jZujL7/vhApiEcO8/EOpAIjcj+ngarlvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g7qaIdHe; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aifT3CMLvu7s5hfdaOOXFKC+a8KBdEcxHyeURJnLFI2elr3pNZZ3GUhfhlQRyljb1kKHUkzyr7TAViuC5PHDCe79jfW5hvqidHZ0srhw3uWE3DPP3vi7185oWDp4dnyk5nBFRBMFTo1ogvRF1tS4FJMwcoNyv1j0aejIJnmKkK0XtnXrDAeljLqztIRzXpQpIPSmrmkUhgrK3++d3fsAGrNLnpXC7qVchwGdBvXhhRTHwkOiLh0D0Da0WP4tZaf42AtRanucc2HyC9b3rPglBqJ8pqqib+10aOC96cTnBypz1rVx09BADtzTys3QLypqok6pRuDc28E8GXVIF1czUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSh3V0chXuJzUdGjfIOHkHVNywqWxbFCmifOd2AiRV4=;
 b=rdrlaA0L8XtPB6jky8/8kxfy3mj8I49AOuWgp8KEGJpEaTPkkLFdm6GJTIJZFsI9BztNtmPl0MUJUVs8DTOWPyXid28W+4wBQgKHpdLyWe5me2PzZLbI21JluuXnE6yEk7PgbEQea7NhuKyR99/KoqQVbTZTd9yVICy70jGSq3/JP22GFi9It+ry+Jo45yBFC3ZL1qo3DUFk7dBkEFFI93nL45r9xem6MND+dE32FoJd/oQnNQM5cO1OUk8wueZM06glR5E7aLWeYFxIWhdb6ErUInPvykMxEDuruFl7D5rbnZozzTCMWPK+mUkW+2c04tQderrNKKm1bYkJFNj4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSh3V0chXuJzUdGjfIOHkHVNywqWxbFCmifOd2AiRV4=;
 b=g7qaIdHejUM7F5kfgoAWGqm4vi6nDe9dAr8BB/rqCz3DXeIpNXIdyR/wp67BETOgiJbw5xQVVAPvDOshy37aSiy6xUNJMbxQDTsq9eAQQf+nF7dT90UAwD0U8YFYtsZH3hEd01PKQEdyAcI0f4Odux31Ry3dAzXLW8Xk04foDV5HwsozN5imPHTjaHExLsTsWstRSNLDvorstxMbksUy0DZbSgdhcHo81yA5kIjkQ9z9Lgn34kvU9Obd0cAF6fYiuWM8m5cpPBTqCbLFsDnNzZhzDClinbyP4+31BZEUbPGALXcM0aIzWjddt9cw3HWZ7ys14TuWPgsgVt2MnY+IUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 08:27:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 08:27:49 +0000
Date: Tue, 19 Aug 2025 11:27:46 +0300
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
Message-ID: <20250819082746.m3ergnluhr2wqr2p@skbuf>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 312a5747-f35d-4f2a-68d8-08dddefa486d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|19092799006|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RuCoz9ZOnYD9pdZqqLIv3A7y3ZZDM0MY9OvYxXlGONPX930YT2qqOO1Fc9ZP?=
 =?us-ascii?Q?MvKLUcN/UdtsUV9eOwrSZTWWZbHkb5U97irePQKqT23HvqfeLJrVJSvrnK12?=
 =?us-ascii?Q?Uc9kR/FhIjM4Ih2Sh+PHj1o17OX6d+pXNH04pcoWTy6Is6W6uTzKXCVYUZgP?=
 =?us-ascii?Q?NDdhmeRxPdv3Ekb+HffAhGAbG9cvguEQLYNezQkUrJn4jtsqyeR2bEM0eqeY?=
 =?us-ascii?Q?iOdydVzbktn0SpJF8uaBrLZcPEdp7eWgLMfSk7Wu5lXly+8I8jG8yR8Rrv0k?=
 =?us-ascii?Q?i9mgDdkHv0gAfxmwt8hYf8S4oISyTHHLQt6zO6+stB9fBN6aAPHAknFOpqr6?=
 =?us-ascii?Q?5KkvxYyRkl+NhcqCVuyes6FAZliyfyLLr+zosn/PC0iZedm+mlAkHN2sZUKw?=
 =?us-ascii?Q?CiTtrs6GvQs9dOwTTBu9bcinm/VWuasbiJvVzK0afhYTBO4PwF1hODcwtG7f?=
 =?us-ascii?Q?Oqevjmf1vP2RGjdqfhQKx0RSkw4XdFCe/qHlcqxUhoh7FvBtezdWYjt+X0t7?=
 =?us-ascii?Q?xHHRst/KacD1Ys4zSwCoolii+MNDy2YV6mGEyMSsSj0bdsRLm4A1seE/sEgS?=
 =?us-ascii?Q?vXNeUDk4aES2dcbvJgo/FPixCvwrS09lNMv5coHMyLHFOseCjzr7LQh/atiZ?=
 =?us-ascii?Q?LhTSJj0rYuSvNfJ39gzFyMvG9a7BD+btYo/aOhMS8GCSWgtxNjmO7H4qwMUp?=
 =?us-ascii?Q?GQfMo8VJ0TQCCLylVn/G6PEzsQytsUCRXpyxUyC8CVaaI4O3AYdrVgB2IJR8?=
 =?us-ascii?Q?p9d5bT7y5Wq2P5zjyc+1KbpEw/Okp3U+h6g+FTRVo8p74BFtPt1RWlPsM570?=
 =?us-ascii?Q?0wvY+3vWRix3XuRbY8KrwV73V4BN+A0YHA74W57DcXQF6015hn+7x0BfoZ1I?=
 =?us-ascii?Q?5Fl4zov/1LAsb5yqtuyp3HsAEbqFSlsNLbRqjwJXEj048xNvlwya4jTnxwat?=
 =?us-ascii?Q?kDL1jPuwfA9qWWCodfwSA021qYMvjeFYEkvaZSMuDA92Hi1J6uw1YgywOjhb?=
 =?us-ascii?Q?sC38+x6LWe5J76o4olgSq3mtfS/TYhDhMoS5RaOZbE+6iJNUKOdVMpusDDiu?=
 =?us-ascii?Q?/NqBZmL8ILagpNVepEDeUoBngJxQkXZArANf8rN/fb1kw4j6l1Gy4HxAUseD?=
 =?us-ascii?Q?FEXzi/jnLkL09yDMzdhMKIIqz/Mq4nz0VJAZVKMZrlDLYOvvYptFuKGSjd+q?=
 =?us-ascii?Q?T9SNaPx+ya3VHoBXXaLlUdLgHTRCcaZJFpblRD4XgWdi3WDjxBhjudBl16TB?=
 =?us-ascii?Q?8AlhOORrvFQVSzF92jo1q8IXYXhnK+oPGRsSsEQNmyoSz3jracCnInSW3T8x?=
 =?us-ascii?Q?Ye4+OhNx7UvAuToclrFtxkqQiq3VJUExahwcLZHUuwCcSmnBmFsIdbjcjND+?=
 =?us-ascii?Q?ABRCNsTtZTpO8/S7FbtfZzEWyXSniN3hFj8T2ain4dJimCi7kz6TupQ7xyxA?=
 =?us-ascii?Q?hVoP9wrIcqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(19092799006)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OtjJGpmwg4hEdE+Cc60dASX/4NeEjD84N0kkc9uiEpDF9Bk/fxOBTCkjXlm7?=
 =?us-ascii?Q?k1kew1zppb6L3djLpu9LiR74QGUidCuFPMs7kS1L9vrw43/2EWZb74jPPpbu?=
 =?us-ascii?Q?VhslxWYZtQTqKDE/BddF2OVMqDQgONvD6p10EUhc5wTg3lhBOny7BgyA6bPz?=
 =?us-ascii?Q?SfWbCepkJmXhMeJFaY2JW+1g12abXRXd9Mkte3ynYj7mh/bX+Xv4YME5chdD?=
 =?us-ascii?Q?PlJwq0uc95T+OvKIi0fIclXFlTWe86HU6dJU1jr63t+Bbp1Z9AmthNAtf6Ir?=
 =?us-ascii?Q?yIcsawjlEl3vGqJmnA0UWl3ClNlv0Idi4kTNLIcX0AR6HtZcw7k0OlWTG9hJ?=
 =?us-ascii?Q?NIl8s87puxQ2gAWEhXnvMf6r4jJorEC9eNfG7vCtjrtgAXWb72WiRgWOYXLY?=
 =?us-ascii?Q?lULokZSSR6EX51xpSn2dyHB1h2wEg02PUfJ37QXupAQjAN684ou40stero6B?=
 =?us-ascii?Q?0k9I91kpZbAd5FTlXoPWNO0HlPj+GZRtmJPY9fk0Uy3xJYxRrOg0XXeNJPxi?=
 =?us-ascii?Q?3a0TEc2TW7hBC0bppwN9QRDw9xMvtWu5ImMgpcto8gc5OLQSQV2pq2fzkg7I?=
 =?us-ascii?Q?U4ggtv0YGDaofSO19aAdLCbY7y6fetWMkkYB6+DjAh1GqzuFuPgs/HKxmtgE?=
 =?us-ascii?Q?By86EdB15dDFHJVDbP0wRrJAN4qpiCO7e93LV2K9u+Mi7To8Z6q+vBRrZH7/?=
 =?us-ascii?Q?WMolZC8vjcju12UoAboY0T6kaaRw8n7pjW5tc5iK2uKxo5IoLe6VoD+HO6Af?=
 =?us-ascii?Q?OsA+dLcizfd+z5Bo99L4JglmgR5MwycpXybO5bhOggx2C7n7c+MZ8mzfeV66?=
 =?us-ascii?Q?09pAaw6mVQDWr3D7bB0/k0N9y8HXsQ6J0Km9f6phm59MK4Hbkk2uQdK5x38i?=
 =?us-ascii?Q?bwxtthTfWvBKm0tIfR5JvFkpctGSlzqQMh3oJrsHA//BKVdxmSKIRd+OhuSi?=
 =?us-ascii?Q?NVtMsUTbsdK9klHXhCiaFTKvDwVZPjIPO6M+jgk8iSoqt51IOenSqphVAL+v?=
 =?us-ascii?Q?WKGVCksgJAz2TiQ4IfqMfiEPH1ooZZbGV9HfacRYmB8Dt5zSsdmljmqnbV7o?=
 =?us-ascii?Q?oVWCVVhNlsnGi/Rn4l6VNQzrpmsshNFYVcTK5PXhe8h2J3kujfTvBgo8L95s?=
 =?us-ascii?Q?rY/Sxfj3pBcuil7QJ/cIGg8T+H+wI73Ao72QqxuJMp5bM2TgPDW4gVDfPMxP?=
 =?us-ascii?Q?VkUzM9rLt/6Kh6U3vWLLcE3YJ5a7b5M3bGumgwyJ+afmVghfaAm5k9mEUlaC?=
 =?us-ascii?Q?weWDE40p8gSiE9IEcS4lI5c57zAnB4mu4eRfqGwuL9TQyFlZq05MwE92DacC?=
 =?us-ascii?Q?U85UsBwLSqUN4beKvTIQuahxJFEJujmWT8zDZdpxSmkHZIc6qL/5LnTGAu2Q?=
 =?us-ascii?Q?Bfb4yR5hvoviEhxVRGbOGh6AHFH5q5e35s7kY/9aPEckeGHPmqxOHo4sz3uu?=
 =?us-ascii?Q?1Ho2fXsvKNZ08M4wzLUZOBwfn4N+FttXSWZOhoIPNH3Vfuf2nB/FJQpQW9yf?=
 =?us-ascii?Q?bQrVSrrSWdNqVRuEnHUTSyuRkNZo59hP6YacIhk3dAjbdmsSfd/Ri2ZqTXE8?=
 =?us-ascii?Q?skOfDxnZ1ECmSheHl/L/ddmOeIBUviO7MsYIAU8Ybymdyk88iMx0Zel3elrk?=
 =?us-ascii?Q?Hj7MiI6JxkyAE/2ylwpSWzedM3JQ6ZoXC6ykfB+AWVHY2WzBH8tbp63XIWIe?=
 =?us-ascii?Q?wT/RVA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312a5747-f35d-4f2a-68d8-08dddefa486d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:27:49.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JjkgJFlr19WrJFv5zhY4wd16xvo/gzWf/0WrhN3FUvFsDcXJ8cOQyr+ivp875N6NE3wYw/7Y+ZkKf8PK16+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124

On Mon, Aug 18, 2025 at 10:10:29AM +0200, Horatiu Vultur wrote:
> There was a problem when we received frames and the frames were
> timestamped. The driver is configured to store the nanosecond part of
> the timestmap in the ptp reserved bits and it would take the second part
> by reading the LTC. The problem is that when reading the LTC we are in
> atomic context and to read the second part will go over mdio bus which
> might sleep, so we get an error.
> The fix consists in actually put all the frames in a queue and start the
> aux work and in that work to read the LTC and then calculate the full
> received time.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

I think the patch is in "Changes Requested" in patchwork because of me,
so I'll try this, see if it helps:

pw-bot: under-review

