Return-Path: <netdev+bounces-209313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F126B0F009
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F64B1662EC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D162BE637;
	Wed, 23 Jul 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQ8argJw"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF528A73C;
	Wed, 23 Jul 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267063; cv=fail; b=GPM2knuwllan1KtDf3MpDiM5vX0MvIv8gmf9Yl+BwkXb8nIT+IdfYwVNZUxAw9/3B/+ieKxg0KQhL9iO7F1i1JcJGDuoC9Egg/HQj3eRMZ3AKDeQxIYoW0Wp99FVqEm0rpIVSKakjpHS8s0JBV11D+gwLRboYxdRSSqcDdxBGTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267063; c=relaxed/simple;
	bh=uvk5gIrsEANieVGXDF7OzO4ByBJM+UKPZd6kr9oWOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D/jmcDdtQDfxE4XOCymPYWvdv8Fa7C2H3DuR1vHMW4Y58u82sxkb1FdRTr8t/6ypxuQZNkSszZYy9lZNyRJKiXjKScjawnOc7NJyq262ltCP7fZtbjR6AKaSC+FI3ZENY4xOpjP3QctoTYSxK7UYfm+AcHSbAbJjOMJoc5Ae6lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CQ8argJw; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i72pGqk/7PGyRD8DVm5ef8++zTjL1Nw50kynhMHkirMUCx76Tm/Y79w4Jfbh3aFY6nCMEzQsDcV9MeHMVR40uxumD+sjIs3A3N6QE7sR8WJZTLn35VUNf66thqa58viMWhweDHk7bzEANr8wnqzLvMUv1Z9rlAIKgJNmxxbTI04aEzIhqPkcU+KCNLLYMG/MQIneaiTqckEofonImNMBO5PqzJFU31UGBb5iThNqunbiMXReDLXpSVnVREMS50MFCHea85zBQsWhlfHr8w6NyJHHt0dMiPvTuFdEvpn1NOXh0wQ+UoNZFr8tTSqrOpmJuvddamUDzeLRoy+PsSkNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFiIoCYv50h6c9Z86tjX1BJjXv+bGXRNIYA8gaP+yOo=;
 b=E7apMIoCGvr7PgWnwM3bpk+YaoQjx0DJtOBBpLVQQUteHqamu/3Xe2CwlgMLNJcp5Kdc67dSG4Wd0MWKCg2TZV6JGZ2D1AcxlXcZf57tZ5v61gb6p0fOUCH3Pfg8uHY788xmsmE9VHsShRevF3CkyA0CSQ/VZQXswaeoSqTZcSgX9fqfNdUD1ZfcrmTfR+fUv7c4j398iRp+kseWfM54wIYijXtdZvvbz3OGjmEg1uyECaiy8lH8W23p6vW7xyAD9Wd9OizYo5Qpd6iIPw0ieBZh4Ige3cx1ay4LOrAh9JXz3EmXVcyfIAXYylpp84FpEWuOhkH1UdPGOKF3HHGtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFiIoCYv50h6c9Z86tjX1BJjXv+bGXRNIYA8gaP+yOo=;
 b=CQ8argJwU4z2mAFDDJJNdCxdRFdzfPEEf99psc5iMYzwxfkqGABa3a0j8K04xf+rM1Fe/yh/NWM6fX1PMfy5xw6D5XutcO3nhKhw3xOe4/hqJy9Ww+//KoJ38q2MEshnp9MxefrWf+3x4o6AerP6tiBxLGGlASURu5a9kqyJ518vTps2Y3hQQ55Lbbb7sa3Djx9W7RQaUrcCcMJ/BACQ0rE9L7rgOADzFKwvrsl6RN8QbVcBgiTobHmYuHXy1+laMTyXfulUacr7ggCkkCHNWMjPksFnKe1UjVTdF/ZYL5sB1JlyAWRJ6RReFMQO9Qz/s4ZERKIqeUPAKE/ZRl9eng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8453.eurprd04.prod.outlook.com (2603:10a6:20b:410::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 10:37:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 10:37:38 +0000
Date: Wed, 23 Jul 2025 13:37:34 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"n.zhandarovich@fintech.ru" <n.zhandarovich@fintech.ru>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"Arvid.Brodin@xdin.com" <Arvid.Brodin@xdin.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"lukma@denx.de" <lukma@denx.de>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next] net: hsr: create an API to get hsr port type
Message-ID: <20250723103734.64ydzav3fsw3lgxc@skbuf>
References: <20250723100605.23860-1-xiaoliang.yang_1@nxp.com>
 <20250723100608.apixcv3ix5rn7ydz@skbuf>
 <DB9PR04MB9259A60ECD5FFAA71A0509A2F05FA@DB9PR04MB9259.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB9259A60ECD5FFAA71A0509A2F05FA@DB9PR04MB9259.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR07CA0306.eurprd07.prod.outlook.com
 (2603:10a6:800:130::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 315bc0af-28eb-408e-7d5d-08ddc9d4f186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QkD+hAYDaymRxtTXpucLQJ/q04rjkoeJx64RiQz5q6cTrlDwi5lBhItoDUvX?=
 =?us-ascii?Q?ALaLuNU6n+MmXa/S+yNfnO7krc7k/iH5tXxue35lBz5Y3pFwsJRX0ksQffpI?=
 =?us-ascii?Q?itqD+F7YzL2kyCGe79MjHdT+C1Omm5CyHI7Bfdx8IMID4KzGQTGSr/x1YbJk?=
 =?us-ascii?Q?0k5a4GwVkNGVdsuVDdNzCQfYU/N6qVhXf2jr1l8ctsR0B3WIaxJfkSbcXHtE?=
 =?us-ascii?Q?tX2bCVXeZmOZh1yurR+ALiLasLPe3NnzMs5TR6/itRRdOiz6t5EL7LbwVSLC?=
 =?us-ascii?Q?tHZnmTvmy4PHRgkvknVwXmI3/izvjKkDCTjC8kknBzgYXCNazQUO7//oxjXE?=
 =?us-ascii?Q?2ppmIKwh71N0zRGiY22W6/i0w5EIdiTfZWxHdwAKFFNLcGhUnV5ae3Unu0RL?=
 =?us-ascii?Q?QypkJ7c7LxJuBsJxZ6Pb5NQxTc2Lm9MuDdSUyxKmBYaZT3u4O6ipG6GzAlec?=
 =?us-ascii?Q?a6TKOAly10mS+PRghBvyH7jP+ruEZ7DSPx5RKUcPhcYYHmDJJR1+T41i5EJk?=
 =?us-ascii?Q?hTpLha3LfJLK3IgvuAZGpDFCaW9iee9QIdYciGjDWEFn4gHBkxSUoGqIgAaR?=
 =?us-ascii?Q?rIudUgirgSGUkPElUHC/WIPgw1I6O6wokjVACys9oG7FQnB/kOPpb9Dok+kK?=
 =?us-ascii?Q?vX5txnDk5EjW+Lpfr5tt84/UAVed0HML816ip4k4HhXi8cYrQpB7oKE2LHWy?=
 =?us-ascii?Q?bXz9if5Fu2UHBKOmSBeJsg3TUJHSJ0cqBVrt7zkcjrW+LrPgYD4H2wJl0H81?=
 =?us-ascii?Q?iPPdxmnr1OFdNuequkUIpK6U7M3avcz3hMjJvkn76VLumHGJ84HWLE6jbX5W?=
 =?us-ascii?Q?Ln1SW6ktKZavfBPaLnDpTZ8u7XDEGfgRelNLPN21MP5sVtMknoPl/0rCkCdS?=
 =?us-ascii?Q?cNJNtoVzGZi+XdArqy09R1L/CoxTFG97UwxKbwNlV5aOjHIBHrfybaZs+EJO?=
 =?us-ascii?Q?7I1FXnfK8lRQsZ6PulL7C/DZBtG8+dsCAHFlLy1nH0F2revMKgpdeShi1MDE?=
 =?us-ascii?Q?xjEe+1GqIaMcUOIFnh5py4P66O+nIF5/GszFkVh5I0pFa4GWwOgJI8mOD+tv?=
 =?us-ascii?Q?3GEBxjllcAPSK9/FMh2XnMf9WHWIW7rWov4FDCbA8E+dbHFYKEF8dIWE8eAX?=
 =?us-ascii?Q?OPkabmxHcrcNeW5gQi3TbiHOgxaQz2L/zDXjYL+j5E3GzNc375HSwwABweeF?=
 =?us-ascii?Q?bpRYaqb2e2GldeF46So1nAEUV8LK5SA2anxj4Rvg0Qh6c7pKIJpVXqvUjvZC?=
 =?us-ascii?Q?dllCYQOTN/f96HPSYZZySsJSU6zYD9JxJtk7CeLizRQYDVyRjpPNfMahxQCp?=
 =?us-ascii?Q?nkrgwT0A39y1LxZ4r/sndAVc86ajckkjSpWa3nhIMXyTJLhSN9NSQH7bhgeQ?=
 =?us-ascii?Q?9aSGLkfppxfh8g7b5QxNG7uvVCcsCalbh76mUmmTuKV67BDn8BKjx/JHk9EF?=
 =?us-ascii?Q?f40aZLaK7j0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rm6rFFwPkAWr9FbFgPirDG5xqTOIX+Ky63ezugH76BQDE03cv1s2Iox8uGWM?=
 =?us-ascii?Q?f9U8GoiQitt3v9qNMzS5aRtioeHsQm6oaxl0nm6bwQw6MGD8x9c0jY+2OllM?=
 =?us-ascii?Q?BLYPx/o5YYA6ONL8fbnFpIpZrEvVN8GnDLg29CAMEf7Rqk7XO7M3ZiaE1RK7?=
 =?us-ascii?Q?uCxU7jtc7mYBoMZ7Zv8tDTvy9C/aX0LY+TKwURofCvM5IUZEYgGSXPeifngF?=
 =?us-ascii?Q?DDkuG6155H5clmRk4lgIJ5A1qQNeqr5Vvq5sdSTMdzLMO8fL/ioQ5JYrIQz4?=
 =?us-ascii?Q?uBacuCrS1n09yQCF8utGkcgjlnWEA3WpHSB040DDwKyH1Z9DWR8cLQ5jJ5L4?=
 =?us-ascii?Q?PRKIQtZwcpzmyLfTSHSFegqZusoFmTQ/PI2KnX6czXGs2/hsL41hLsThWrJy?=
 =?us-ascii?Q?HgrH2KDdqiKimTYfKZGffL2KH5JUE7I5ElzDAtNohifa60QCEmU9K2sibj5g?=
 =?us-ascii?Q?XqSyDhB+8IfH409/k9vzjToGQx2G48B0kWcPTjRbG/NPdLAa1HvtX2NBD22F?=
 =?us-ascii?Q?6eneK8Pql1miKDjOHX1v6em6zr8qQTc//xHFFlTj9buE489UMMgFKDwONV2Q?=
 =?us-ascii?Q?Tf2LDBXf1PJDTNOPgUSZkfTSvq5k4MeYcf2ZGWoywSd62X/Qxyh4QRL3cId8?=
 =?us-ascii?Q?76oN98u+aMyR2wytSn0wMf102COIJuNMseQPIXYNVCv6W/ftYljAAR1NmT1P?=
 =?us-ascii?Q?EYyvPgOmY4edhkarctQydufiTWZRRC4lHsDgn6CSwQXW0Qsl8xi1dInAMcvC?=
 =?us-ascii?Q?byVkocjSSC+mF+92oR668GBuwz1RkZweyzhhVpSl/UwDhERAdrUjQNEttb04?=
 =?us-ascii?Q?Mwsi+AtHG0ztY14jWEcdxFEPU+vbaeOYMJlgSVxkLhLjP8wlv70AJP67PphF?=
 =?us-ascii?Q?WfwaU3xQFf6CiKG1dR15dHa4x/KfBEXEP/vOvEwSiTZo3eXo0IgEKo/VwTSI?=
 =?us-ascii?Q?sYdm6EmhrsFJkhDV+4+PmwXZHMyMr6c22Tik9qtj5GI6VRjrbqLjugUAMTnx?=
 =?us-ascii?Q?TSNf4T+1W3YJtFGmmcDMSGbGCRwHOQ6VN6bVCWJkFaWYfnuSXWpDHgRusscx?=
 =?us-ascii?Q?mYZ6dU/008zJqUcXv4MRQ0LZVtyNLosIjs8Kg5RBsVeawvo9N4yeO6GOwHIH?=
 =?us-ascii?Q?kaz9I1fUaMMxbgAghU4MgTthbbDHQkCT6cJp7Nr7jFlqHjpFDYzDH6KKJ1pG?=
 =?us-ascii?Q?Ph0p/xdrZKOi3BdIKCLxzZ41yH0yuTZS9HDvdux5/jmPlVqoLuV1Iout6V06?=
 =?us-ascii?Q?7NU2NqApdtLzLi7BcNaAQ9WVQX1VklBszKC7+VnJCyhpLxoTSKnAOv1psVVp?=
 =?us-ascii?Q?nDCZVql85FTAB9r4/CTDOJsKz4wL4T0MwxmoBpqgxYiiY4yLn6ElnK13beTU?=
 =?us-ascii?Q?I+V8227aJl3WxQmXgKPSaaO3KI1dHMljNVbUzMgzXEFQ/Ht+N6GpOIgVGJt7?=
 =?us-ascii?Q?m7ho8HjKKZpnJLzMI544TG5zIGAQW5fT+ix+R96Rpc34ScS3FISOm22lIQio?=
 =?us-ascii?Q?gkefQPdGwC7cCjd9KaUz0+axtjh1iEve4heFUHv+SmbmWAUJFZKaci1hJpKS?=
 =?us-ascii?Q?+8EkeqKjThdRQa5W1IfsoP3yxMFksmigYLAKxT9ygJY65H3tPtNs+0XVtzWi?=
 =?us-ascii?Q?BI5AT+5JugTSBbnbcyXoHKJClbxKzV6IllwL0SRJiOoOed20kxdc9yr8GoK8?=
 =?us-ascii?Q?rToWgg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315bc0af-28eb-408e-7d5d-08ddc9d4f186
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:37:38.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dGbRsBPilhtIteTB0s4Pfun78QH7re2YqtFtdazX1M8WSow6M33/9DKCG8bVZ9j6kJk4jG0UlXzfP1Rbj3npQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8453

On Wed, Jul 23, 2025 at 01:29:09PM +0300, Xiaoliang Yang wrote:
> 
> 
> > -----Original Message-----
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Sent: Wednesday, July 23, 2025 6:06 PM
> > To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> > Cc: davem@davemloft.net; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; kuba@kernel.org; n.zhandarovich@fintech.ru;
> > edumazet@google.com; pabeni@redhat.com; wojciech.drewek@intel.com;
> > Arvid.Brodin@xdin.com; horms@kernel.org; lukma@denx.de; m-
> > karicheri2@ti.com
> > Subject: Re: [PATCH net-next] net: hsr: create an API to get hsr port type
> > 
> > Hi Xiaoliang,
> > 
> > On Wed, Jul 23, 2025 at 06:06:05PM +0800, Xiaoliang Yang wrote:
> > > If a switch device has HSR hardware ability and HSR configuration
> > > offload to hardware. The device driver needs to get the HSR port type
> > > when joining the port to HSR. Different port types require different
> > > settings for the hardware, like HSR_PT_SLAVE_A, HSR_PT_SLAVE_B, and
> > > HSR_PT_INTERLINK. Create the API hsr_get_port_type() and export it.
> > >
> > > When the hsr_get_port_type() is called in the device driver, if the
> > > port can be found in the HSR port list, the HSR port type can be obtained.
> > > Therefore, before calling the device driver, we need to first add the
> > > hsr_port to the HSR port list.
> > >
> > > Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> > > ---
> > 
> > An API with no callers will never be accepted. You need to post the user together
> > with this change, for the maintainers to have the full picture and see whether it is
> > the best way to solve the problem.
> 
> Thanks Vladimir, I want to use the API in dsa netc driver. The driver
> has not been upstream now. I see the HSR implemented on some devices
> only act as DANH. If the device act as RedBox, we don't know which
> port is interlink, which is slave_A or slave_B. I will re-send it as
> RFC patch, anyone can discuss how to handle this issue.
> 
> Regards,
> Xiaoliang

It's not of much use if you still repost an API with no users with an
RFC tag.

I could equally propose populating struct netdev_notifier_changeupper_info :: upper_info
with the information you need (port type). Currently HSR calls netdev_upper_dev_link(),
which sets this argument to NULL.

But without seeing actual code which makes use of this, it is impossible
to know which one is preferable. So please don't send an empty RFC.

