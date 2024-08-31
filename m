Return-Path: <netdev+bounces-123975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45A9670EC
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 12:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08571F224B7
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D971176AA5;
	Sat, 31 Aug 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b="GysKLc4c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492D19BB7
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725100441; cv=fail; b=Mk3sDbZtygrJ0FfImImWK++4lGxbw/mAtlsbEksPHyt0P2VOb15SRZgipElKGeYoXW2BiG5MMJ3WbpB9AwSsZTUKqt0Gd81xemrE8kyIWFD7mOFfGr1oBiLru0/caJpPAglB2NoTMOmrZUwPe15S8vvTyxvCKbcnEe3ZnTXFhiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725100441; c=relaxed/simple;
	bh=TUFRhT2nGCm8zfcdx+4th3SHt45J4kHY2TZ4BO5JHI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n9kaLsvm6Kstvstfd/yvsGL27bckPBrrkpPHsho0c6Fl5w13yzxHEeLyfJSjSplQPBvgVCmrSj6ChBXD0QFW14XhlmOL60C5waeO+b/Hn6yF4jF4HDpD1Q4A02kkBx0rMWkVuAlczNGVBQFRSaXjXSSrTE4RzEG+znnDrTez8Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b=GysKLc4c; arc=fail smtp.client-ip=40.107.237.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1umD8jax6afSztggna1taJ9yiglNXxTRbSk8xbOljlEFBO4sC4olLlQQaNVghlfObYrnzepzEOwEwg+ToQRAxS6q5eLSGAp/n0q3VVvDZm1EGhDC8+mPiioGLalZ1Lr9/YVeip+aHtedJPzzXjgoli4d+0/y17szxWSnYPphdCQS6tCjKLxSAvly+uiDyYtJNK9omq6y7cXZgp8tqjYyVUQ7stBH6l+8oAOWc4b9obpsQSWNJxKCDA6YqCHEHj5CPiBMy29w24ClQcwhNQay1usf/BemlaYsMv1Iep1Gc6wQ/QUmVsLBNx0HB2soxt88/KJWHuzPp66izN5JaRjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Js/MFiX9AJhM7yds8wOWSalZ0du8YRW8HQI0ng9fDZU=;
 b=FpkTqw+ixbvNcf4oxEWWTqrrDtLB4i800fOBomoKWL53N04QqNsnk8tj4tC5pSmjkySS9dkoo//XDy5OKLxo0MKUUdXegNmaFMiDZVjVZHoWYf1UITJD5q6LblyIVE6Wor9EnspHgVH6NzjYnoXhlZ72JLnRJGR6nUBWPkPNRvEJ26LaYpae+JvXwT64urLrEzAfD4dAHfcS0hrJT6YKcK43exeeJf2igtpH2Vh5kO40vEWVmEnX/dNjbWmS3h9Q/uUbb/Nb1Op5mLw8lMTv5Nunh+ivDs0lyZp/y7nLQcwimuz6883jSco2GLUQWF09ty/0taR6HYovuYH/MqyPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js/MFiX9AJhM7yds8wOWSalZ0du8YRW8HQI0ng9fDZU=;
 b=GysKLc4c+ZnYiGyT+5743QX29OinHAPeXoMkU563sTPjqLbGvFQcNaoYs9d0UgwbpJUkS+vNKGTQJwvfdAHpmWON8xSn7dxsfKFZTsQLr2+c1wEBYboBNDafrPUZZCHcoU9saSxAclf4jK3QaG5ZDC0nKSWcwaOComAT+GEEynI=
Received: from IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sat, 31 Aug
 2024 10:33:55 +0000
Received: from IA1PR12MB6113.namprd12.prod.outlook.com
 ([fe80::65cb:f536:1808:2faf]) by IA1PR12MB6113.namprd12.prod.outlook.com
 ([fe80::65cb:f536:1808:2faf%6]) with mapi id 15.20.7875.016; Sat, 31 Aug 2024
 10:33:55 +0000
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jay Vosburgh
	<jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Shyam
 Sundar S K <Shyam-sundar.S-k@amd.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Sunil Goutham <sgoutham@marvell.com>, Christian
 Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, Yisen
 Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie
 Shao <shaojijie@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas
	<marcin.s.wojtas@gmail.com>, Russell King <linux@armlinux.org.uk>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, Bryan Whitehead <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?iso-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@ragnatech.se>, Edward
 Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>, Imre
 Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: RE: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
Thread-Topic: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Thread-Index: AQHa+iHpTOOst0zspEu2Bu8mvBxZTLJBLTtg
Date: Sat, 31 Aug 2024 10:33:55 +0000
Message-ID:
 <IA1PR12MB6113E1D2165FB9F87F8DA06DCE902@IA1PR12MB6113.namprd12.prod.outlook.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-vipre-scanned: 1A59A65A01AB6F1A59A7A7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6113:EE_|CY5PR12MB6083:EE_
x-ms-office365-filtering-correlation-id: e0eb4427-8262-4ef5-1e42-08dcc9a86a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SO66Qh5/BeNLEcq+fb+2ZdF0Hge68+Sidkh3+lun+OU0x+jvA7f/mt5gT6?=
 =?iso-8859-1?Q?R/Cgp/yT2C5OviPCgJi4As8fr+TfzH6fLZSpwyO9op0yOH5u0kyQ0TdV+V?=
 =?iso-8859-1?Q?oZfuCcw0bTn1YAjRAJvkN8mJFXR0VRllTe0dI1hBuiI7HYsLw/2tWWqS3F?=
 =?iso-8859-1?Q?Zut0+irN94Q3OvEO5tqa3k6j5ky6QJAiRcK3Eod8x4rVFZBBrqDDlf34am?=
 =?iso-8859-1?Q?vyi01x8x5kaHtpnCs3qx/YQdXSk404X6zfpoHDzpCea/Hlami5lGC65jHH?=
 =?iso-8859-1?Q?5QhZqOvsry1sys5ERiQmUjEsK0PFP4S5qkRbBcsXjMw2nAQG1BLkBevKTP?=
 =?iso-8859-1?Q?NJhRJPDffOHntY2ccDKRXZvG/5gHp8BZUf3AsbtvJxbBuZR5t5q34Hwwem?=
 =?iso-8859-1?Q?eNKWjnfGsBZLJsGuvS2v4sFa6TCys4oWpFoef+PtSzz4pvp1djpd9A5X5a?=
 =?iso-8859-1?Q?8y5x6cYJ7L6hU2dBLt7kyJVy51Ygo4JSyH0HuLaZqyiCIMvNjkWaHzSAwb?=
 =?iso-8859-1?Q?+W23ErYaVUqK2nzGqmL++hr+xNcNLKo4lDg4SWtcSj2Fw7O1P+BJXvK/If?=
 =?iso-8859-1?Q?o44IzUYNnJmtHF+2RcVz/nyeLbEXiQaBw37bSS4vCcXG9t/KqyYZlUJNBj?=
 =?iso-8859-1?Q?rgVW1ygHMTwi8/PceSG0B+3owsCLoI5YdzxaIwZAFQvhPwcUQUUNWVtNKE?=
 =?iso-8859-1?Q?QlWLwunob0kNwvH34XVHJBWOPQefZIRscr42PG8dQ/EpdTM/1vpuOP+Tpo?=
 =?iso-8859-1?Q?43b0t5MaRxs/kfHwqS9dfA/gQpyzZY4EGGuue4BP7ZuRbq+kW547wXLKuH?=
 =?iso-8859-1?Q?jarql4bygLI2TknhoarE/8dOGjEijKLmTx1/SVQ+KL4/x31TByj7t8LVOM?=
 =?iso-8859-1?Q?dWpOY22jz9kvcJk4tHS1IQfGzWv0wEF2G/lZKkdG55mGEP+mB6DasfktmY?=
 =?iso-8859-1?Q?pRs9ASVJ3bRpD1zXs8iOuGaCbzpDKcBqW4iODDi4lld4NpoZ4HbtPyF+Wt?=
 =?iso-8859-1?Q?Azi/rhu41QYfqJHrCiTj8Vf+8s+xaLKp5wxiaHn/zOUa8Vn9X4XxGrZmds?=
 =?iso-8859-1?Q?9v8d+macCAig9OnwZJc6bOk3aU8FYyqN49N4B2dj3eBUVALGZKe4oJIoLI?=
 =?iso-8859-1?Q?nwghPNyDyzECRIlEvPFvubYLrk5qL0QTuiA6DDvdDTwqTlE5xDqwNHrxRw?=
 =?iso-8859-1?Q?Pa+gN7A4v4JjePstQwW1UHv4fXl9L+jUxlJNZ50HuHIGnRNw2SZdT6Tdm6?=
 =?iso-8859-1?Q?GZy24BpgDeadpw9JdpaHG9X8f4hE+5WsfickKSMI9PIEWapc9moVJ5bt+p?=
 =?iso-8859-1?Q?cPmbEPh/Sv2zega1S8bBQ3taNZsut2UVeKpLHsUPyWB+UCJcypYH8eVA5N?=
 =?iso-8859-1?Q?GcjLKnko2nB2/17+htGClIFY6mEoXX3HQDOHsg8hZQ5baVGIuDaOa8jAfu?=
 =?iso-8859-1?Q?C6ONOHU7Zlz/1VKuHcRAcRcujMfcrKlF+HJ+jg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2x+u6buyWGTxEkE0PmCvvkK/1+EqF+8MCeMTkceXQb5nhd6nK3/lofc0/T?=
 =?iso-8859-1?Q?3JpZYW5DYUSL5oI4wXfnNbIzdK0KhxlPcKI2ErY58CE4vI3681MbmbANep?=
 =?iso-8859-1?Q?MnjtkS87jBf+60SeV23kTHWHTPp78KMO+QaC5q3MBvtNsKWc9B07/+WkCX?=
 =?iso-8859-1?Q?KedTVG9s1pPTCWbaBsfM25jSjUZH5bTI216M9HZXBOLacEzEwAy2Y2V7gG?=
 =?iso-8859-1?Q?dFJBnjywGvxU8WdKxdxf35CHdVjz92xWCCW14mcl4BhKiYutn0a6xiTK3v?=
 =?iso-8859-1?Q?eK74wDrnYRszn0lF0aqoO9M9KY8NKPoUU+2twEOdpJ+/+iXo3yqw88Oa44?=
 =?iso-8859-1?Q?uYVlyLl0GwSUVSCSpolopW96tp75J0OiqLZeUx2mx39xxH1+oEMEHYVTMC?=
 =?iso-8859-1?Q?piFfLdlpy//rgfHmT2TEdVrlbpL+ua6PV3LBtYP8nzuoVb+Y/e+bdxwUeI?=
 =?iso-8859-1?Q?9mdN8yDV6aqzXpPIdNDlcG4st7APVs5CKS7W3dUlqt+PX4HKWLpBJnvo8r?=
 =?iso-8859-1?Q?kjOwGc1HsaJG6/OJlnj5OPc7A5ytWYhKI1dqO/QpBxTV9wjH88WRh7/PXI?=
 =?iso-8859-1?Q?ggmeRneew8P/2UuL8Tmej186Guc1F2o1BPGQdCrh8Ld0bAbURRHu9GNK9l?=
 =?iso-8859-1?Q?N9bks1R5GwxXdBKJboj0/mC4AhfpZ2EiXDU6KYk9A6duSxk2lhbUAt3j1u?=
 =?iso-8859-1?Q?Pcus0MpJ9emDTKLPI1f6OR9ELW3vGuUolpB+UUAwVWWDN0KkE92setxW1U?=
 =?iso-8859-1?Q?BdzaYGYTAfS/4HS0jT61Q3obZ3pIkO89gL6LOPv1rQpL1ooeUPAPkF3u37?=
 =?iso-8859-1?Q?B4LJvV0ib4VOx7jW1/ePXjOPgMBkY+n1RwX5PORyrAh6NfowVdwhcGuvhU?=
 =?iso-8859-1?Q?s/83/MGI5opj74/wjs9jgW6ePU51bK8zykWRP2ApYMrYDD8bHxQJ3XCCQv?=
 =?iso-8859-1?Q?SBwwga8fgTIkKsduxMRkl4/Xk3AA3ikg6aVqqf8HjD1728X/2OZmQJiYEu?=
 =?iso-8859-1?Q?XorE1Ea6tTpym2zYrQc24zGoGqeiVbmYRA27EPXL9IeQG93vyBhYixN2mJ?=
 =?iso-8859-1?Q?jkkRBnfPkr+JeSo/n82+afIlRR6WtETbaH0QR3zNdJlQSJcKZIA9DvR1A6?=
 =?iso-8859-1?Q?S9ykp4TatNaFwAYrWBG/CSkaoNqY23WKvm6d6AN+fWfzSWC8W9TSLmoNWT?=
 =?iso-8859-1?Q?Qk4RG566Ro56/72ZwXeFSY3sYPGUQr+c+l+QUjJbDyBls1dacnprFhIajW?=
 =?iso-8859-1?Q?0woIRygxlnpKcaCfZNniBMhPTTVoXOPsr0t2UatP/ellFblAWcSIt2+Juf?=
 =?iso-8859-1?Q?xrlD8UeohpeyNdhQ7v0NTuA5WV+5NJBwoz16YR8IVm9aMnEsTWH/oZ5DfH?=
 =?iso-8859-1?Q?OA97labNVcsGinqvWZ038Xke8zd9xLvu81S2yCx+lnqdBtDfnLZ++pqNZt?=
 =?iso-8859-1?Q?tb9VOl50D3uNGR0CFfdBsZb+enA80pvwLhZlES241G9P4A3vTu2K3shjwo?=
 =?iso-8859-1?Q?p2MsXnoQFHHtJ69yMb6n8ZqNhMJ+MXpFTyg3PHwA2+pO7ByfvAFOjO73QX?=
 =?iso-8859-1?Q?F5hJtqEiTZ8YmmsyVWNLww5rx27y6KpK4CqASe+F3/NqJkHbacuxRYO73a?=
 =?iso-8859-1?Q?9AFjWw3W4CK3xrkyfKd8LYT3zeBOmc1f8O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0eb4427-8262-4ef5-1e42-08dcc9a86a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2024 10:33:55.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOaDHps579QrpaSsF0Aesvz8Pd1L0A/+Oqih9ar9M1GTQ5J9LMTa85TWIcLkZUL4lyRyYwB4WEe7AfC1Q9+a9woaTVIJiKOZ9M+OxVjinI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083

On Thursday, August 08/29/24, 2024 at 20:12:53 +0530, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
>=20
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c               |  3 ---
>  drivers/net/can/dev/dev.c                     |  3 ---
>  drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  3 ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  4 ----
>  .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 ----
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +----
>  drivers/net/ethernet/broadcom/tg3.c           |  6 +-----
>  drivers/net/ethernet/cadence/macb_main.c      |  5 ++---
>  .../ethernet/cavium/liquidio/lio_ethtool.c    | 16 +++++++--------
>  .../ethernet/cavium/thunder/nicvf_ethtool.c   |  2 --
>  .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 11 +++-------

for cxgb4 changes
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>

