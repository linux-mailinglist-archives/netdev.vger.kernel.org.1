Return-Path: <netdev+bounces-246190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B336CE5690
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B362B3009FA1
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CB2741C9;
	Sun, 28 Dec 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EjAKuzEZ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948EBDDC5;
	Sun, 28 Dec 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766950726; cv=fail; b=nCd8E2k/VlT1R1ws2OBpMm4nawoX4XZNiymMwOPZ7KzEYEW3I2kTd5jOatCDgeUW0tZkY0Mrb/SIOaqO3D06LSjJ/7J9XwcEksKTmaXZE9kd7/Yf2ZOZBQalD+YOJHlG1zZMPmlEhpYEcEwltt06/kbXGGZrOExlCPUDw6nD+iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766950726; c=relaxed/simple;
	bh=4m97F55t8D/WLip5qefUBWiuVPNyWX6Rp2DS893YcIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YJ7Q7L8HdoqISQcXihS2FW6J1foctGLtPLKSRz943aZuixtc3+dJteO9aJTs8Rq729iKtHrZF+w1qw+Jmo4Jh8VXdLjLNrL3utQrrYPsZPbVpXf6IB0CnZCWe2dNhCcQpbhu0byPPFCILlTtzrF6JI1EX7w0uwH6EgYtNKKnwjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EjAKuzEZ; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqxVdy8T4s89mS61rt+7aMQy4GORkfrALEXOGO+cljqg7KwDWYprlLYt0QlXWD98Ne+JbvhRUxcPxXrFRcuu+i6alGiJZBROw1fuWNJWQZljlSTivM/QfOOqzjGw9ebM0RacHZqagYoNGOGRjYwAwAa8svrhBef+SBQs5hL4G4qULzsGSx7DQzaVM0o218+/VxtWeGwQ+iMxvOWS551hPwY9dt2s6RGkD0oqFURsM+f8BKllxJu80Nz5vSnlf/Vg7SnLFD+SVl0MDufyzXMOJlEGJv5sCymCoeOMSnK2gRcN2Lsb7ROZi+mSXO4nmb6/QPyHxemVaL5828f52T+hMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt2sS2+UrDTMPwFTqLxgI5cgC+wSC1jr7wYckYGSWbQ=;
 b=b1sT4bsm2CYlHNhTtZm7dzxJcpjS46znrqijobVjc/rWANBGAdqquEM3e5Uw2FnGlciKOYbRYUDxndF1CGsPW739XUpomGOV2CLyiaHB1d8tjnV+SJ3Xdr15ofH5/AQdLBqeQjEeGtUw8k7Yn1qPM4bVkYSmzJRH4uMhSWz0qte8TqZSUWggN/CtqEOJ9IQJ4+xy+HFVdl2pKrKZU+VRWxQRmxc+8InHMmIz2Rdw6iiTtVD2OHn781+9o/6r6JXi/Q63svOPJGy8ydXHYgmhohZ9j6uLkVZH99TEseXI6AMrkvr99DGDV/Y48G2gFBvaUGc9i3kIH9+d3NRSwERmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt2sS2+UrDTMPwFTqLxgI5cgC+wSC1jr7wYckYGSWbQ=;
 b=EjAKuzEZvE9ZgnVGWuKsIwNTCzOSbBWxOTWky7h5278HZYelj2BQFomb5nTydaB1V6a9x3N5Wbay1mkqVTd9Pech/CZvglXXKqenpwszy/g/VPIOZvOG6nsoIjYqp5V9tho+dsulWJFUp7hMre0bzBBQ/RXLWhSg53mt4NXPhhm3wpkmFECW8hoBURWN3rRDlJJjAEy7YDeQD/YNx+v5ijHl1DYMWnUj58ssEx+BbPj+/PKHS9a1bwmXQ/aSBOuQ+1yUStTJMsAUyfUHm9CSZGXHzl2ZdcjKH4LLA7Qor+PDS04szJJ9cBOVqiyu2X1qiFNe0Lk0q0JwOsYB3qbwFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB11335.eurprd04.prod.outlook.com (2603:10a6:102:4f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sun, 28 Dec
 2025 19:38:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9456.008; Sun, 28 Dec 2025
 19:38:41 +0000
Date: Sun, 28 Dec 2025 21:38:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net] net: enetc: do not print error log if addr is 0
Message-ID: <20251228193838.pevckwqcqooyd7ir@skbuf>
References: <20251222022628.4016403-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222022628.4016403-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB11335:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cdf535-7750-432b-dbdc-08de4648b461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MVKkM1jJIPijBZIdaMo+Wia8Lp79NnSuZJuqsT8Ilnr5tpysn0wfALoOy9sb?=
 =?us-ascii?Q?I6QqGFrhXFMYclp1ZBCeleTlANvg3eBGaH9+o97afDxvqSlKo2ZtEbcRM9nN?=
 =?us-ascii?Q?WJgwWsKOcNL/c0x21l/zl+yY+xfUHN0p9GREa1/R4+Z5AqLcVjgOaRZwYFBi?=
 =?us-ascii?Q?8F0c3eF5AuG/Hqt5ypA7kNSxIyBlsJZovWS2mmVBJoyCoNZFiZDXVuZgZiuI?=
 =?us-ascii?Q?dz6eRpdrdB3eBSsB+fUPpQ3L686mj6pF33LA+BYiEtESc8bnnAfW3B/4NqRe?=
 =?us-ascii?Q?3GX31BgRYOGB4JgMVd51XDoJZO5WsOxC+RX7Z7m3THQpHrOLIgHQfK77o7Bf?=
 =?us-ascii?Q?VuMSn4ptc5bAHgrauYRVkuEzLNJyfF/8tuObqqdrysydmEGlg//EuowvwUNJ?=
 =?us-ascii?Q?KQWu7TjpiF10zMG9ZdvB2zYS8kJiqbl5e7WteB4HZ6DYjwpb8DX7M+S7eiZG?=
 =?us-ascii?Q?TP7nfiFmcjT1XmGEY+4IiB9fgx/0vxnElKitWn20SSxUNI/tz1rhmTBhsqWo?=
 =?us-ascii?Q?Ebtnt06+sbFUdr9EUC2KCKCP20XYXeReA6LIdol5KFP8dozJluuuu8zLDvtg?=
 =?us-ascii?Q?SfjBGLMoBBvLv6mn8GxRXUJWFAZcSC9lWMLKYs8Ura+jHim+ZOXw6L+rxM0i?=
 =?us-ascii?Q?MiBanoLhfJERN9mV+i3WOPCuW6UzmDvaneVePOTR+bb1zmayh+QktxYIWfmn?=
 =?us-ascii?Q?XCbQ02ysmKmd1rB1RsaZlVpqysOR8BSR5ffmXCzcl6Z0ZLQAJhjbs+22zfqs?=
 =?us-ascii?Q?Du9mbD4eH+oot474IXNgqD5jIv9HnDfKuSJfM1rmXb+0EohNypE0P9wL8JIY?=
 =?us-ascii?Q?pE6O9g/CxxQ9iSYQhcfF6S/pHR1zA4/3GBglPKmPFJXAa/yEjszpfiBPrqlr?=
 =?us-ascii?Q?Z5OPhzmAnltypCbHfggijhcPwzJFV02NWa/NKjrR4/SvJHfAS1DtYn6+awJH?=
 =?us-ascii?Q?fwDmtAybH2HI5p8ocsjW2wSj9mzXghkXLBky7EPX7GDgWffoxZwmbzo/rYL/?=
 =?us-ascii?Q?OE/dcmQGTNYPC3WdLq9/KLmpdh58C+YB3Bo+l3p8xQ2kaueLBz93Io2xE9RY?=
 =?us-ascii?Q?I3QoYGe2rNoWX3g6ujoh0+EtfmoauibJw5+m1/8D/rr1ANibIa0J4MTVMq7Q?=
 =?us-ascii?Q?P3KThjqPiF+Ay3mGRiLX+yomq/Wnexj2C35ZjUrMJx+PcwEotya6kf4qY72T?=
 =?us-ascii?Q?aiaYbGq7KaqaGkUpnNXQ6SyEllJe19mqLgs3/xheeHLc9lYMn3WzISwxDs0t?=
 =?us-ascii?Q?tWGOE0kN1SKl1Adrs1fG7hUTTN72UGgz64FzTDEPsoTXU2Y7a9z3tM9veR5K?=
 =?us-ascii?Q?eQIvUwJSUnDoT/gw1oMd0mu8lMrflW1WcwxyWokEYYhpmFsFV2W4aXfv1sKG?=
 =?us-ascii?Q?zoxp+zsXXZZl0VEn/jNPzfqAb7kErDZQ/fPUq6UdPLPuj66nRNQxq9xoIR2X?=
 =?us-ascii?Q?CBQf0tQE1uyZ7KdKyRqBQBV4zWa/OfFlDe6hlwbAOLsRqKdQHg+wnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmWkaxToTQ8I3IF5TYCy0Aekf4M0wtxKfshPz4w2XxA1mg+lenXjwrhfUoMD?=
 =?us-ascii?Q?hqNLO6K0R/qmqgRwAn2zteGGkRJK1sSAGZRVv10hRNJXiIl2MNOTGHlz7a1q?=
 =?us-ascii?Q?nL5DrQSiJQWU47yq44L6Dh10nK00hgabkIq9nwDPcKQ5OxtEOvHanZ2DFjrS?=
 =?us-ascii?Q?KvzwNeoeUUZLCl8/jsOyAZTrb7ruBW1Gr3btF/2dCYvXuocpJ/cR7C6cViE/?=
 =?us-ascii?Q?TUWaaFn2y4ERuN03zdKE5PUC2AvUwXkAzhW4HEXPQYt8pMBNCtsfJMVCSkWB?=
 =?us-ascii?Q?06xPN3XKODisa15kkhH4PFfOtpcy0IGVtpDaUTfslr42t1xKSrwyvUKckMev?=
 =?us-ascii?Q?ld97JWuOE1SoSqxrYi0TwWv1K24ecX/VHBOKLmZXBOEgzAppjyU8djnrMNUv?=
 =?us-ascii?Q?8ce31hFrJ4zvS1FEZo4aaCW4ydwrkRgZnSKxTW46SJiscYJJukBE+pnRbWVS?=
 =?us-ascii?Q?QXn/20e3or8YExXj16E5WNYSJuEr4DX8EIINAWw1RkVCRWqiA3NCofr6jyGJ?=
 =?us-ascii?Q?QzzBMFbE8CvH4xgcazOe1tkRC+WBUDrsBB7EPGD7yXLyEL3VeeYQLIZASZy+?=
 =?us-ascii?Q?hojDLv8suF3YonrFIWjqTrHnZJlc0hcONH5oxE2Sj8q1z2azKDZ0fHCRzsSj?=
 =?us-ascii?Q?xtNVkRRIg4WrE9dLFH0eKO3n1BtEbXOg0PNSbPo2595tXo9m7GIA4+YbA0xC?=
 =?us-ascii?Q?5RJqDwfvSEu6Q1ChjoCkFx6ALyCKpIZrqxx5WjocT82Z5ICayDgVGSBD/VJ1?=
 =?us-ascii?Q?l5005Wxh5Rb8vtCgDX1kvJtThuOZ33QQiWFlKFRtocT628f0tlIrFIcWVbqW?=
 =?us-ascii?Q?EcQIpToWGBHdeWiA5lf3fi0AHXWr7oLC+0c9+5UqXI91pzbNWl2GfjUXPpS9?=
 =?us-ascii?Q?oY7l2e6utUwTBb/nsRgac5ITsX12NGc3OaRtPrunhno0/Wtb5+zM0MsgjfvR?=
 =?us-ascii?Q?XHN28lO7IdRvGqjiZAf4xa8HngWI8tsGjvlQHBgNyU/eb/S6xwk68dXhGAMd?=
 =?us-ascii?Q?tHswdKyDov6CZgOYK7NlsS7mx2CyBouToffBkEYSGJB3dpb7pzPhuJdVBFzD?=
 =?us-ascii?Q?33mqJxfsbEpxREjG16vUmMVJzKVTqHG0QAtwLOFi5GhF960oLEH/nlCZL4G3?=
 =?us-ascii?Q?EK0G7FMhWnouQpyC1G78n6thKh0HdOFFSKhm9nUTqZgVg2GGPiB6u1L1wkrc?=
 =?us-ascii?Q?h4RwwxBUHFfsRQ0DE9sZ9N3ILUcTD8BwLomQ/fB3W2HrLYlmFIM5CY0ymNGl?=
 =?us-ascii?Q?93be2019hjKsaI0IBt2n3SdTc5jhbm+2BOMXiEBY1lCszlra/n2JtK6QCmfY?=
 =?us-ascii?Q?Ha25RxtpeMlWPv6tDGir3KFyp5ww8SKCAyY2WxmHZC7BKwyCY4L6yoxC7tqH?=
 =?us-ascii?Q?YrzoPPYf0v5QNANGSDHJQ0D7Zget7OEwL6KkbvBYR+p3+u6tZsHVaV4uRKOY?=
 =?us-ascii?Q?O/f99pKpqhoU2YjGdyTFl8raadMU4QZtGslXjdq8WQDElbNBzDddbXH01W/n?=
 =?us-ascii?Q?tiSMHHiQ6n+q6Fxoc7VF5LQOWCAsaCycxYTaNsjFIM1YJl91/rm0sA6CzFRM?=
 =?us-ascii?Q?cNxGu7gKy1AGWA7LIEx552tlaamEUzHDQBT6q+gWrfPH/Xca5GjY00sXWN96?=
 =?us-ascii?Q?4v6dD1QwORiNL3Qk+H3HZWlqSbJwx9BHyuvgOEsANlLc5LHe4UZQpmwvZ68N?=
 =?us-ascii?Q?itqVRwwzythrkJPJRA/MNr7nL4U0zsPSiwWo8CYFAZQxFqlTyKP2yV5SBvUM?=
 =?us-ascii?Q?OXLGJOaP30xmrWpoqbo2AkFr47yvBiCp3vU8iwzTGFzFoq8kIdgt98pTZVQc?=
X-MS-Exchange-AntiSpam-MessageData-1: SG9utPvFuVBlkg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cdf535-7750-432b-dbdc-08de4648b461
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2025 19:38:41.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SppfI9Js3YiwSjfZlFGZ17Mxf09nRAKkFr7Stllri4krrtMMhnF3gSfGSNHzjqOB5WrqL/R0+JMQ9t1754fTYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11335

On Mon, Dec 22, 2025 at 10:26:28AM +0800, Wei Fang wrote:
> A value of 0 for addr indicates that the IEB_LBCR register does not
> need to be configured, as its default value is 0. However, the driver
> will print an error log if addr is 0, so this issue needs to be fixed.
> 
> Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.MX94 ENETC")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> Separate tests for "if (addr < 0)" and a later "if (!addr)".
> v1: https://lore.kernel.org/imx/20251219082922.3883800-1-wei.fang@nxp.com/
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

