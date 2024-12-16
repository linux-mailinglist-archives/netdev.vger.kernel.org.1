Return-Path: <netdev+bounces-152223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E929F31FB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525B5165FFC
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142220551E;
	Mon, 16 Dec 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ta54PktJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755F204C06;
	Mon, 16 Dec 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357127; cv=fail; b=EUPxYHQKHWu1/AoHaBurtzagiVK8lNUnR2Weew/J8Mg3QLgGvtx1DHnj5S9L4ffBrW4qhNV5quuiQsl6I8tCfUoQLp+WppVLt78NYff5Ufx5VOmv/Ze2GzjcAu7Ov/v+4PG0vQCyTSRn72VID/+/9vbXTi6qeJg5xD0SdxV1mQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357127; c=relaxed/simple;
	bh=pStO3NQDfrLlX0LDSYD3fQJhbPIPEul+lZv0bVwtYh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XRqEJ+uMXksIyK+h8er9tFFkgymaeX/Go7BSDKt2ZFkzmQd60xid3wp2UeSpqDeUMb0XWkj0jXtmxCSG7KiC8gU1bnh04S/nwhTK+NTe3jQ1HRHPpLkLiTk/E2iBOZWsYVr0J4QQGdTNJVpffzwIwjkbhP6bt/y4uH7QKIQj/vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ta54PktJ; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puSouXW8s9LNUSjs2LnpLXC7HCPCJNYeA4K9dwDETssECmpTQhMC6t0Q9+cvG964wQxKAGuOZJ11IcOZU3lNO+WE1BQMidrbM2rNfU6ZyRdc9i2K8x8ZOhGPGYbaTd+5/6gVbQw75Soxi0Z5sJwWjDwzB+Xg+/Xjos+Qyn32YrfHMj0HjqthkX6axvpjYCYSvPIfV+f5v4I2Enyq+RDqdlyHPqfhBi6CBlz3eUlZjNGAt8KDSg0hxqa+Y4qBepolZf6R418vSLziJl2b/qxyLCnVtHkIB4OKKL4HfeqRS0Kx9LitPrywDuC6+QR2o2V9ewU222IX8HcvYs64FIYd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW/gnbQxs7Tm/FxPhDU1EBIJx+y24vfPp8TRTg6oOFU=;
 b=hby6v3pTYDoOElnEfOnl6Y8qF4whAlyFr5SOfaqFe1VLYfKQSXgh7HK28VVIdRQkmMBolGRNVY0bARdO3Fk0ORpTmYxDibMWP9Q12phq1Eng5QnAfJXNjMXWMtesPizBUkw1gJMW6QeKD1kRb5EGROGGmF2JUCc39yCd1etwDFO4/EzBW598XTQP3cDSDptx9AYFYSfWogfj0EWll7VEuqG9MboQI8zxiO8TU9/IfZ5PA6CSvcHwjjPXHzbmWxOqPRBhS5vkb9UkayYiYriW5JWzBWH4Xu1V3p9TBdJl79QxRJP409n+q7xuozDSJIxku3Y1fyObW2umqBq1vz1yLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW/gnbQxs7Tm/FxPhDU1EBIJx+y24vfPp8TRTg6oOFU=;
 b=Ta54PktJeUY7z3TrWvl+2eYVFyJRjdVOBvFZXqFWi/ic+FHor6u+XYa+EYNgfETf+ibsSYk/ddEZE/6lzG+U4RY9ddc4d/Dj2hRgnTB5y7HnxgrNwBkApUj0MPUpxWm4nPLV+QIYYoZWZsA0zlOabGStosbdpQ8L1o3zCJs73f/8XLqrppbd3C2B+RPuauzlWNuUuu7xRC8jOd4te6Bdh4Ph4zbiotcbpsnansR+GNl1S33ktMxRccAqpm/XU1KDxt9I1JU7QEHpdXrC8xtenGcQJfiDL2fDw/3QDlL4mem1Xb7PhDgsz0qkrKZdjxInxva5YL6yWtc/OpQM2wIOqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8878.eurprd04.prod.outlook.com (2603:10a6:102:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 13:52:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:52:02 +0000
Date: Mon, 16 Dec 2024 15:51:59 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 0/2] net: dsa: felix: fix VLAN-unaware reception
Message-ID: <20241216135159.jetvdglhtl6mfk2r@skbuf>
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
 <20241215170921.5qlundy4jzutvze7@skbuf>
 <908ec18c-3d04-4cc9-a152-e41b17c5b315@digi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908ec18c-3d04-4cc9-a152-e41b17c5b315@digi.com>
X-ClientProxiedBy: BE1P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a80acd-9dca-450c-a96c-08dd1dd8d199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0BC7qGlgUu1ArfiMOplYbrVUqsiLFD4AtTjWtB9Dj+HAv58BjsFlAu+stVIa?=
 =?us-ascii?Q?XOFiVo1phWUUH5ubSODBZzNyYaUHAS2NqjhLaWLtHleb3RZJ2apmgyPkGvtk?=
 =?us-ascii?Q?3OK5V8zyqviG1QLEiEHIrGGaFDRk22Y27nsAx2qFX/U/Vp0kNITQEQGeevcM?=
 =?us-ascii?Q?4eEizrQB+wkFTb4W5AiFLPRxecapv48n7Ts6RxZNAK4QY9ZpjudWK7Q0NRKV?=
 =?us-ascii?Q?65LBweQhDDqnHPWI5PZpptgR0nzoOuc52ijy69vFLxXojUaJRq3OLwZRbaWG?=
 =?us-ascii?Q?RzXfDrwqLoWgi1PporTkczYCkAf6cM4vCqoHN7ld23rc+CcoE8Jfd6URFBXb?=
 =?us-ascii?Q?9sqlzfAwZhIfE2Lyzt9XO7lOAjBnq3MUfPDmMrhFcBsUt9L+7HFGFZfN6ulg?=
 =?us-ascii?Q?FegOlvNe+VUNvGZ5MuaGTirDY/zL4yIXp2s3HEaY0j6W7C9ijiK+TEKbUXl6?=
 =?us-ascii?Q?/xLjI5JOg91/AppE999tBIBcqrMAWlRRWOhwo903HHNlmkoLF6gtWMUEO4IC?=
 =?us-ascii?Q?G6MXn3PL2tDrWLquwVUjNTg7ks1XZjUsZMyzYUy8TULnR+Aq/lsgzNRncArH?=
 =?us-ascii?Q?GKbak9PKALity+fLZT/WPOMZ5QjWiypNc8ii1+gGst8pKSLz+Iw6SkWL0Xvm?=
 =?us-ascii?Q?KmEBzWKWTzEMl33sKgqiP9WCB6vvOHiGcgqQtQzycMwFBcFDD63loyh62t4z?=
 =?us-ascii?Q?XycIAkT2BhqsEs5du2+sx9a6ancRwgxbDtmVJCfWxMA0sfXSdZJp58Jokx8b?=
 =?us-ascii?Q?MznsMcWq8UgFfmBTk5371wCNokAm37IfM83VKbGaQ+19dP4KFcZSmhuxU97K?=
 =?us-ascii?Q?eY0+tDSKfWb5GMkpX+TJz/ff+G+qz2HJEqUNjuda97jHj4en/eXYS230f+Fb?=
 =?us-ascii?Q?TgsZriM1HZ/I6vv85cTjn2g27IZweo3E+lj8mXpap/Lg5DxPihpUvxawOZiM?=
 =?us-ascii?Q?ANFBKqtV2l69kpw06YYHCHbrUyjtkPlHcVIZxaKlxMaue8sX3Lw0naPKpdXT?=
 =?us-ascii?Q?WJCUmtXmA7wyWSXYZEaUafHbFdoihB5KxW3Y1YxVHha4iWJP0I1nhyrI4a+0?=
 =?us-ascii?Q?r4NcqOaq+OT/0PM1Vz3mu8T5xUcnGigtfezEAMXUTkJ+qn57YqQ2iJYCvv/Y?=
 =?us-ascii?Q?05pXpCEkah48w/A4nEFDH6qiTlm5m4A2dlBeoWjdCHIOwi2lzuq88Y4CftNU?=
 =?us-ascii?Q?tuhnyNRPMpBzmoPvqku319nqyALK8Hkor/sCXbKza4Iio5Ukw+osQJNxcv/V?=
 =?us-ascii?Q?uesbp73nZnghVhWmkhXT81vlFVSlCaqiwD56xp+He8BCiMuiZhxw9N6yt2RK?=
 =?us-ascii?Q?+/AcrTBWXAkUcgPK7o9cc22BwO0rW0G+yIhGblEiqrFukkRsH1PvSl8XS3uy?=
 =?us-ascii?Q?XTExcR9w2A7HmqK6ycJCp+8Skivm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WELDmYH8+5a58Qc4K/yNHcEB6Id0H1BqA3+Ralx57vBkJDAd+X9yuS5GjJCI?=
 =?us-ascii?Q?cx5rY08BnZBJYhI1ROAk4ERAQBBZWHTP89BRLbczN4R3AEpPfkUoi0gRMB3f?=
 =?us-ascii?Q?HETe7Y3xRTa0CAvIGFyBA3LDd5XexKEqgwWebo9gAsvMeh5Rn+XfikJWG626?=
 =?us-ascii?Q?aQ0D0DQBIVOAmXMbcETQu3PYF1+LhtU5rIDzi2YqQcMcibBM63CEej64PrTn?=
 =?us-ascii?Q?G1Y+XjyIST5P6eV2QGkuUgDCv9mjDmYxgtEwxTR/GOS2qSLhbJSf8KI3aBcM?=
 =?us-ascii?Q?lpJQLBMq/wjp/0ZtGEiDZ8xVWOhNsxO5YCeDhqqHcp9wRMZ+J0hLI9TAUtQJ?=
 =?us-ascii?Q?CFBW0Cylg31AiBedI9ssaF4cQppw1vW3+UlbAb598Fd4qtxoa6CWOmFqrsrQ?=
 =?us-ascii?Q?KaIetUoeHqkuF6BvO/pIEFb5bmbGV4zuBSHYIEi86xv0ALM1+2nzYTlGaPLI?=
 =?us-ascii?Q?x1v20kvn/jmkMe5G/bQuU0lc+TCUHODA/D0NZ+lTTQF1G9Jp5ZyblYc1K0lg?=
 =?us-ascii?Q?V2k9dnA76CHe+rOH60+oZShJbGuGb2XvBCJogiRZO/4EjfcGUq8uhY12rzaj?=
 =?us-ascii?Q?sTI45kwUdPcI2MQiXeDGTZzleQNoaCs+ZAJ9okq36ehPbI/kbzSRQisGjS84?=
 =?us-ascii?Q?Ks3fvHMIZFq6gjsYTROVgKsQ+lHTal1ednv4/Fa8/baSIUTcW4ljUKP6Ffrg?=
 =?us-ascii?Q?MYJWdS/5HdvWM7S9J2PIl6xOWisryXKISu+OdZLTnBgdpK2vwc/ZQru9luKk?=
 =?us-ascii?Q?ExUnvUZumz8kSM9A2IUWOLFdBgYbUFkwFrf+YaxDQIpzeShuc5j8eLmgTe9N?=
 =?us-ascii?Q?g/xyhLNJjePt5gs1QIkjJlXMzxJXevGiXqbDrSwbqIftuy/dbA33piHKIgEV?=
 =?us-ascii?Q?KsRANYgifKIphwpKyQNSsP5UeRik/cC/2TNuTGALu4G9h8ffTAL/sixJuPW3?=
 =?us-ascii?Q?w64g203wHemXaBeoEU4hDrKVsvwViu8DCKAouWOqqYI8TNbLa6je9I+jMDFP?=
 =?us-ascii?Q?gcBdrA4ztawPitAY7yiZA0FYd/05DFdYhzExjRhayVRDZhgD/L1tcksaXGbH?=
 =?us-ascii?Q?mOyzrdrs0IY1E31Yk7DcTik8nq01706fiB7EqzdRo9ckcn25CAo5eDcE1wRS?=
 =?us-ascii?Q?CepVbQf+fo00Hb4pYx5/EmA8UgyEKmYYd8MCIZ86bdqUjs/3orycmoEfH4rx?=
 =?us-ascii?Q?StvGe0AiYXuDgo6nLpuCRgWYsQWTqRn02RtRW6jKeAwQCHbU/xlsE/K8VoOg?=
 =?us-ascii?Q?N6Hr4bG14g7cglMxnCZ2RgLe3im0B7mYRksZbeivtGHL900H0HeKKv7pwyLR?=
 =?us-ascii?Q?ed8JEXKZm/6st/350hVx78bQfnyS6HsSv7x7yw6WBfE/lKuo10WbPNA2RHZj?=
 =?us-ascii?Q?vacnmplDYCJsfNDpK3soFEhxRyo7QCVog2i9PugJDmOqLK6yUyBeS2Ucu/3/?=
 =?us-ascii?Q?8CQFAMj6vKva/PUU5P5ApqtqUe//kVt+3bmjPPY2wP/j14gDlN9lw64OOXQf?=
 =?us-ascii?Q?N5nVTOY3OJnbNZKq38iS/1n/TArniUI7YMkdUWm4zbSWNURY+qSg20al7djH?=
 =?us-ascii?Q?OfVysqHJo2aBvlrudrqYv3xkvgOJUfCT2Txc0rVOG26wo/1hLqb6l/Dry/pf?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a80acd-9dca-450c-a96c-08dd1dd8d199
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:52:02.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bx7lkB/2FKKjd6kDmHKKTxsEU8071R/sLbMhGy5j6KVmje1ahmY+sxWh9eZGuFaHFE02Hq7zzVl8aXE1rSVhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8878

On Mon, Dec 16, 2024 at 11:10:05AM +0100, Robert Hodaszi wrote:
> On Sunday, 15.12.2024 at 18:09 +0100, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > 
> > Give me an example traffic pattern, Linux configuration and corruption,
> > please. I spent a lot of time trying to make sure I am not introducing
> > regressions, and I have no idea what you are seeing that is wrong.
> > Please don't try to make assumptions, just let me see what you see.
> 
> The config I'm using:
>  - Using the 2.5Gbps as CPU port in 'ocelot-8021q' mode, Linux interface name is 'eth0'
>  - Using 2 downstream ports as external Ethernet ports: 'eth1' and 'eth2'
>  - 'eth1' port of the device is directly connected with my PC (Ethernet interface #1, 192.168.1.1)
>  - 'eth2' port of the device is directly connected with my PC (Ethernet interface #2, 192.168.2.1)
> 
> DTS:
> 
>   &mscc_felix_port0 {
>     label = "eth1";
>     managed = "in-band-status";
>     phy-handle = <&qsgmii_phy0>;
>     phy-mode = "qsgmii";
>     status = "okay";
>   };
> 
>   &mscc_felix_port1 {
>     label = "eth2";
>     managed = "in-band-status";
>     phy-handle = <&qsgmii_phy1>;
>     phy-mode = "qsgmii";
>     status = "okay";
>   };
> 
>   &mscc_felix_port4 {
>     ethernet = <&enetc_port2>;
>     status = "okay";
>     dsa-tag-protocol = "ocelot-8021q";
>   };
> 
> LS1028 unit's Linux config:
> 
>   # Static IP to 'eth1'
>   $ ifconfig eth1 192.168.1.2 up
> 
>   # Create a VLAN-unaware bridge, and add 'eth2' to that
>   $ brctl addbr br0
>   $ brctl addif br0 eth2
> 
>   # Set static IP to the bridge
>   $ ifconfig br0 192.168.2.2 up
>   $ ifconfig eth2 up
> 
> Now at this point:
> 
>   1. I can ping perfectly fine the eth1 interface from my PC ("ping 192.168.1.2"), and vice-versa
>   2. Pinging 'br0' from my PC is not working ("ping 192.168.2.2"). I can see the ARP requests, but there are not ARP replies at all.
> 
> If I enable VLAN-filtering on 'br0', it starts working:
> 
>   $ echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> 
> 
> So basically:
> 
>   1. Raw interface -> working
>   2. VLAN-aware bridge -> working
>   3. VLAN-unaware bridge -> NOT working
> 
> I traced what is happening. When VLAN-filtering is not enabled on the bridge, LS1028's switch is configured with 'push_inner_tag = OCELOT_NO_ES0_TAG'. But ds->untag_vlan_aware_bridge_pvid is always set to true at switch setup, in felix_tag_8021q_setup(). That makes dsa_switch_rcv() call dsa_software_vlan_untag() for each packets.
> 
> 
> Now in dsa_software_vlan_untag(), if the port is not part of the bridge (case #1), it returns with the skb early. That's OK.
> 
> 
>   static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
>   {
>     struct dsa_port *dp = dsa_user_to_port(skb->dev);
>     struct net_device *br = dsa_port_bridge_dev_get(dp);
>     u16 vid;
> 
>     /* software untagging for standalone ports not yet necessary */
>     if (!br)
>       return skb;
> 
> 
> But if port is part of a bridge, no matter "push_inner_tag" is set as OCELOT_ES0_TAG or OCELOT_NO_ES0_TAG, it always untags it:
> 
>     /* Move VLAN tag from data to hwaccel */
>     if (!skb_vlan_tag_present(skb)) {
>       skb = skb_vlan_untag(skb);
>       if (!skb)
>         return NULL;
>     }
> 
> As the "untag_vlan_aware_bridge_pvid" is a switch-specific thing, not port-specific, I cannot change it to false/true depending on the port is added to a VLAN-unaware/aware bridge, as the other port may be added to another bridge (eth1 -> VLAN-aware (tags enabled), eth2 -> VLAN-unaware (tags disabled)).
> 
> Also, in the past this code part looked like this:
> 
>     /* Move VLAN tag from data to hwaccel */
>     if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
>       skb = skb_vlan_untag(skb);
>       if (!skb)
>         return NULL;
>     }
> 
> So we had a protocol check. This wouldn't work 100% neither, because what if a VLAN packet arrives from the outer world into a VLAN-unaware bridge? I assume, that shouldn't be untagged, still, it would do that.
> 
> 
> I'm not that happy with my patch though, as I had to add another flag for each ports. But that seems to be the "cleanest" solution. That's why as marked it as RFC.
> 
> Thanks,
> Robert

The memory is starting to come back :-|

Ok, so the good news is that you aren't seeing things, I can reproduce
with tools/testing/selftests/drivers/net/dsa/local_termination.sh.

Another good thing is that the fix is easier than your posted attempt.
You've correctly identified the previous VLAN stripping logic, and that
is what we should go forward with. I don't agree with your analysis that
it wouldn't work, because if you look at the implementation of
skb_vlan_untag(), it strips the VLAN header from the skb head, but still
keeps it in the hwaccel area, so packets are still VLAN-tagged.

This does not have a functional impact upon reception, it is just done
to have unified handling later on in the function:
skb_vlan_tag_present() and skb_vlan_tag_get_id(). This side effect is
also mentioned as a comment on dsa_software_vlan_untag().

The stripping itself will only take place in dsa_software_untag_vlan_unaware_bridge()
if the switch driver sets dp->ds->untag_bridge_pvid. The felix driver
does not set this.

What is not so good is that I'm seriously starting to doubt my sanity.
You'd think that I ran the selftests that I had posted together with the
patch introducing the bug, but somehow they fail :-| And not only that,
but thoughts about this problem itself have since passed through my head,
and I failed to correctly identify where the problem applies and where
it does not. I'm sorry for that.

I've just posted a fix to this bug, which I would like you to double-check
and respond with review and test tags, or let me know if it doesn't work.
https://lore.kernel.org/netdev/20241216135059.1258266-1-vladimir.oltean@nxp.com/
I posted it myself because I don't expect you to have the full context
(it's a bug that I introduced), and with yours there are still a lot of
unanswered "why"s, as well as not the simplest solution.

