Return-Path: <netdev+bounces-124117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65ED96822A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E1EB20C09
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C1D185952;
	Mon,  2 Sep 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tg+hQBFS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FAA2AE99
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266330; cv=fail; b=FgKUWrNNHKTtjOLVW0dQRvq4okW6KMzV0tU866xmXLb2ODltJVaT+Epx/kmXZG1sla7Ye8RjzQ1+b0Aj/Lvl6vdD1d/f3yljzYcFXFaDwjWxvBPGqC8QcnAwhx8por8H80LWxogb9amM/5MHHgYH9LH0IoMhJkvSXidD5ziWwRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266330; c=relaxed/simple;
	bh=faKlPQfdoPHEpCs1Apa99JeOwZMcPluKTvtmSbJLnZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kNeVwN+vOa2WdWa7dM8CnlgwYqmcL4PMpl3WT/qzbEmKP4MIMtiWcACRihLsCMbLM1sBkPkmpTx2PUNvPsTjLZp4PEFyLnORmjIPzO6EICEC5PemUBJ3VVIbBXm9DTHZuZZrsjYxFheOQP+H7lzGrI6Jya2uLJ4BiU/d4AYxqkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tg+hQBFS; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apYx69uBaLkE3qlPr661nRrTAa6aadc+RSInO6SBEcnUdEHFED0Of/dN1beF3EZiOWqEszNyf2IcANx2fgIuBMf0QWusH58MAKhqIHQqlMXTS4TkoRvIW8kFYXWR1sPQA8csWWvE24K7YyV3pHHAs+ixLRWksq7fselx/Q/BhuDnCrBhILF9OcmnjTbtASOgcXuCg5tgAfhLXyKbfaXCzgMLbIUbvdcOwFFXt9suNqWflo0kygV5q7lSUkGlbzeLmaDBX2wI1Us4QNEu0JzRREs9mDgmmEMtxZYLt4aqLgoSW4CtXvIaFXdnrNIb6etbjVSZFoj16DNHJcJN1lsJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qNz+Ta6DAyipuOWavhzQYCnYHBkO3Lf5ceViHVJHMc=;
 b=Z9+frsXef6RLNjOYd2xjFq1TFaAEudzR3xbsFbKUuJpGF6B34MZAdThB89I0GYTEXBUM4U5C2g5wLoF8GCG69ZW/CDBmNOsPfCv977vapddEWmfiQHrwzrt3MtrbVegEHfd4TwvyhbNgRCW87GuONUr2xQdTihctOdo7AD+A7TwS3zmYd3cTzEdJ/TMmKQiYpqnensB+IxUvU37yUvn2LR89CKwLqV6Hn+sX8NEYaFPdelCCgSpeJ7OHCDvIkB3GV8Cj3uiy8JPsUY9QMejA8XM2QhdaRIC8LFXZ2qx3PcQNBBRARxgovlR7uAZ3faD3YOJAmUxAd7Q9V6ty4T5jwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qNz+Ta6DAyipuOWavhzQYCnYHBkO3Lf5ceViHVJHMc=;
 b=tg+hQBFSGUOWZXHE4Od/h4wgLdE+EBc1kDNkhQ2EG4vbAu9aBpVh+7kvSMAcHwwAIXgiPnSHn9ZGOQMJ9zBw887MRgtdRyypUVBn0632aIyrbVQY3LEAZXPGEQ5AYTf3YfJ+ofBRxkvrF8ep63G6wda9AwKOnc7+1I8X4aUGtzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:38:44 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:38:43 +0000
Message-ID: <7c196f69-4c1a-4277-add3-2dca3d953ca0@amd.com>
Date: Mon, 2 Sep 2024 14:08:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sunil Goutham <sgoutham@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Dimitris Michailidis <dmichail@fungible.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 847e1a91-e98c-41ca-4273-08dccb2aa706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVl6elJVSzJhb2xKYzRXa0JxdnpacEp5K0l2SWhVN2Jxak45OTJiT0FtT01h?=
 =?utf-8?B?ZHdlQ01CUHcxMnVsbWVEK2lyMFVsSmJ1aGQ2MHJSS3o3N2dsNXhnT25XWTcy?=
 =?utf-8?B?K0VYVlkwSkovcXVLbCs1Ym9TUzZSSzFWUkNaRnQyQ3FqRWhPV3BkUFdQS1pu?=
 =?utf-8?B?UXlDVmlQUXFmaDU3RUlENkNOYlJrUTY0SFdpd0hhZUdEVkxDdko1K2V5cDk4?=
 =?utf-8?B?VjJYbUpoY3BtbDJnUkY5M1lqQUVYRXFrdmUvVWZzWFZjeFQ5YjFGdlhEUTVI?=
 =?utf-8?B?a3B6WWM1YUM4aEZla21RVGNxWXVlK2lSUVFubUVVRklxUEpNK2FDY2Y1OEJ2?=
 =?utf-8?B?ZHlKUkErejVodmo2K2FmdWtMNm1BUVRWbDBITjhUMVNacHoyZmllcHlGMGdY?=
 =?utf-8?B?Y2FBMkJzQkdBdTJsU0JLTUlIUmwxU1l1ZzVaSVBHNDhhUEpGTWQzQ2tURTd2?=
 =?utf-8?B?Yy9iR3hPUWlVZHhkbzlhdEMwNTl2WXdhbWF0OWZaZk02OXpIdnd1bjdTVDgw?=
 =?utf-8?B?ZEp1eG9YMjdvbThJam15b01tS0dNTFZwemh0N2NWaXIrSzB3bHdZUHYwbUNp?=
 =?utf-8?B?TzlHZjFHY1hRS2hXNms3cXRCc1NmS29sRkZrL2R5Sk51RndsbDdCekM1ZmhN?=
 =?utf-8?B?ditaM1JoV29ZUlpJTnk4RkljTG5xaDhYWlhOTWxVU1ROWm1scG5aOXQ0K2lh?=
 =?utf-8?B?TGo5cThkckZqQnJ4ek5xWVJ5b2p0RmVQdThTR0kzK25ic2RvTEc4MU1MNVdj?=
 =?utf-8?B?U1A4T3ZQbWU2U1dua2pkNEdpSXdqajdmdkN1N0VRY2dkTFlVOUs1R0ljMVRa?=
 =?utf-8?B?a2ZITHNZaWg4V1h5U056RElSNktWVEZWSlRsL28zSGw5Q1ZTVzZNUXFSa3Fv?=
 =?utf-8?B?ZEV4d05Cc3NPTy8rWHFZcEhNQTd6elF5REJtamtPaGFlTk16N2EyMjdYVEVs?=
 =?utf-8?B?bURiUHU3dDRaWFhFZVRIMDB1NGRZeVFqSGgrM0hXVlFpK3dXK2J1TWxSYWxH?=
 =?utf-8?B?L01HRE10NUtXUGQ0eElpdlJEcjIyTHQwQjJ5d1hhVFBuSXlYUktUR3NmTC9k?=
 =?utf-8?B?MDhHNnFORVd4UjM4OWFiZi8rb3FCNFZYNGdFMCtvRDVBT2l1L3hjeDNEaG4y?=
 =?utf-8?B?K0E1WnNXRStDaDdrNDNQM0hkU3JDNm5GQ0R2Y3NUTWdDNS9SR2VTa0FyelI1?=
 =?utf-8?B?N21UNlk5eVJtcG1uQjg4R3RvUDV0MVNuei9IVDJadUNZdHlyRXJISGNjK1pk?=
 =?utf-8?B?UFl6RU11dGFodXg5VkpxZ295Nk5SZ1RkWkNNSmd0bDdrYjdaZDFsL3prTS9z?=
 =?utf-8?B?RitkbUlUR3RMeXhuR05DMldKdU5ZYlJvTHNjZHFneW1TajlFM01SWXhPY1E0?=
 =?utf-8?B?TitleVh0Uzh4c1hHUEsrY0lGSzBUNGtYNUpkY2RYa3htUkM3Rk9rWDM2b1BW?=
 =?utf-8?B?eTQrekFiSkc0MnRrS2FpUXA3TXJoeE4wYWN3eXFyTll5bmZyczVJa2hJOXVG?=
 =?utf-8?B?N2h0SGVrYUJWRXQyaWNjdVZUTkk0dXpSR1QwdlkrZFpyYWtjSEhraG1Rditz?=
 =?utf-8?B?dFl3NzREdVNjWnpHcHZvcDBFSGU3dlJrS2hIQ3hsRU9xNlVIS2hFcUs2UWRD?=
 =?utf-8?B?R2dnbWJFWC80ZG9vZVVkMDd1ZG1DRnYwYWVUTldCcnJQUkR2OVRNcG9CQmF5?=
 =?utf-8?B?Q2UwY1ZKSW01cnQ0eGlhOHhQZVErTzRqdmRXU1NUL3c5MnJ3Rkh0QktNRDZT?=
 =?utf-8?B?dURud2FwVWdQUWtOTzk1cGI1MVZneFRlaHJqZEFKY09SNExOcS8vYTBTS21I?=
 =?utf-8?B?ZjZGZmFsNXorQU1qS2hZdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU82a0FxYThlNzRkcytod3hNYnV4dEViamczTEZHNDVaRkROSmFER3BHQ1Yz?=
 =?utf-8?B?d1pkd09tc1dmYXcyMlIrZHE4YVN5azJ1bHgzOGJpbkpjQ1Yrem1zemRPMWNC?=
 =?utf-8?B?QVc1TzdoQ1VXNmZSUS9meXpxTWY5bUNzYlEzSGN5d3JxVzIvSEl2K3cvK3d5?=
 =?utf-8?B?bUpNZDNKeUJqWXIrZEVZM2s2YWpRWFZYdVpxR1NZbDNubXcyb29Icm5lMUVR?=
 =?utf-8?B?dm9nejVMQkVOYk0xK3E3MkRMcTBLNkdIc1JOUTNOMFhPNjlxNU53Y3BlRllY?=
 =?utf-8?B?NDdYWForb29uaTBvalJPdFpFMlpYd2xCVWJReWlKa09xbkxUUVUyY0hYK0I2?=
 =?utf-8?B?TmR6ZW9oMDJ2eFByZUtta3lZdnRMZ1IrRDh4Vi84eEpCcWdmUWJFaE53Z0I5?=
 =?utf-8?B?d2RUWVNDazc2dmtyQUhqbTVpMTZOSnRKSFVBTXdFQitTSmVNNE01WFY4OHZM?=
 =?utf-8?B?MllMZzF3bTF0aDJjU1FNQ2RwbVBYbzVGRlZ1YzE1N1VDaDc2eEt4RmQ5ZjFo?=
 =?utf-8?B?VEVqUjUxNGl1Z2dveHNvVWRJRTlBNjIrTUUxMGJCVm80U3BTRTBOOGMwMUxi?=
 =?utf-8?B?UkJTYzBSL1REendsRmZUWnBtNjQzcEdqSjZzNVBnVzBOVEVSeS9UeGl3NUk5?=
 =?utf-8?B?TnlRV3lGRTkvamh6YXhJT1ljL1d4WHE3OHJUbVdzZmdiYnN0cm5LOGhScE02?=
 =?utf-8?B?NDNhOWRZdkorTWpPemxQdkN1OGhSSFhCYmdRbHdwdmFaRmFGenZodEpacCtD?=
 =?utf-8?B?d2FiMjhHWXE0QmhQeVpCY2ozanZkWk9INjF1N05LamlaQjRHZXowSjhrY1hH?=
 =?utf-8?B?ZmZ6Zitibm5HUjhXSVVEQlRiTzdQc0FNQWExbldZcm5IZWVwSHlROTAyTFg1?=
 =?utf-8?B?L0VOdk5kdTBqdnRpTEFVYitxbnBXZ1dKb25wRWxGU2pSL3NtRWJXYW9yZEt0?=
 =?utf-8?B?ZW5HN0ZMY0lGcEM4c0ZEazhBQTQvTGtZS2tPZnUvYXNKU3RocDNnbEhnWGdM?=
 =?utf-8?B?bzh1L3ArdWk4ZE5vRjFScHFOdU5CZnpaZnFUbFVBVCt2RzdYT0ZyMXZBSEJB?=
 =?utf-8?B?SzIrWlVENnhTYXZianNFb2pUV1dOajlPRkRUbnpzamtLemZpd2dibFVWcjMx?=
 =?utf-8?B?ZGlIUTJUdmhiL2pZS0dRc2NxRnVtYlc0K3lzcWdHdUxVTEw4K1NDYUUvY1pW?=
 =?utf-8?B?ZUZWcFFpRWlRN0xyQ1lpZTlSR0oyVWJzaWVuMGtkakJ2alhBRXFlcDdQdmJr?=
 =?utf-8?B?ZDJpNUlsWDh2Z0tCZmNDNWJtcFdUciswMlVZcWs3RFJsMjAwTHVvaWJaT1NB?=
 =?utf-8?B?bS9IQ1FRYWtmSzU2eUx1cW4xa1BXb3I5Nm93M0tkaFNsRFl5eUNUMmNkbnZk?=
 =?utf-8?B?aUsrRDVnZXFkRHRFSXY4by9xUFkyZUtKdEJXM1NIeTVVcGNtc1VrN2xWUldp?=
 =?utf-8?B?VENrbDdXSlh2dzI0RElBNFZmTHpFQW5MeGNablZONkJJQ29sSS9BZDRNM0dp?=
 =?utf-8?B?WGJxV0RPb3JJZjhISG9BVTZrdnFnME1OWkpIUitTRWJsR1hxZmJ2anBDRjh5?=
 =?utf-8?B?OUNXNEZsYVRQb0ZOZmVJYVRQZko5Z01kbGV0cm1abXBOT0FTVEhWVncrbEd1?=
 =?utf-8?B?MDJSRXdORUtoNEJ2cWVyZW9nY0kydTVWMkJpVktPZnBCQ2dNQ3ljZWJtdWJP?=
 =?utf-8?B?dnpoWDBEVndTeTh0VDVTMzZhS3g5a2VRbVh4TXY1SElpYjllSHBIOE5yWTdQ?=
 =?utf-8?B?MDZENzBpQkU0dUpOYWFEb1BreFErN0wxcUpqSEtWODExdkFTb2VTK1hhU1pP?=
 =?utf-8?B?TnVrMjh6QVpVTVYrWUhoZ3FZOVI2dHBZeDhTMlhrb0VCUVpxeG5xZGpFZ0J3?=
 =?utf-8?B?SG5zT0FJcGNpUkU5SmpSZmF5QU1HeW9hSjdrZWtzb09naUE2cmluUitaRFAx?=
 =?utf-8?B?eVJGaUxOejBLeHI0eFZNbVEwN096K2RnVVNxTHJiZnAyUFNrNHlkQzdMUWdN?=
 =?utf-8?B?RWFjUnFVTDNZdCtIeDlQSzBBd1owTW8rdHkzYUU4UWgwaTgrUFlXcndEbTRn?=
 =?utf-8?B?YUoyZWd0NmhDM2FUK1dIekF6L1gwUWFzNDNtZ3BtNTI5Nnlvbjg4emZmbFBa?=
 =?utf-8?Q?8k+O7HiuNuuhztn11EhtQ8TyG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847e1a91-e98c-41ca-4273-08dccb2aa706
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:38:43.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg+byjd1VL2RZO0125fSVf4WIn6ldAxj+ZXdts3eTFfX+kFX7c+rWEWDlxZy/2VQxuBW0gsfaswajIKz3zIGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807



On 8/29/2024 20:12, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
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
>  .../net/ethernet/cisco/enic/enic_ethtool.c    |  4 +---
>  drivers/net/ethernet/engleder/tsnep_ethtool.c |  4 ----
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
>  drivers/net/ethernet/freescale/fec_main.c     |  4 ----
>  .../net/ethernet/freescale/gianfar_ethtool.c  | 10 ++--------
>  .../ethernet/fungible/funeth/funeth_ethtool.c |  5 +----
>  .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  4 ----
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 ----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 --
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 +-------
>  drivers/net/ethernet/intel/igc/igc_ethtool.c  |  4 ----
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 ----
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  2 --
>  .../marvell/octeontx2/nic/otx2_ethtool.c      |  2 --
>  .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++++++
>  .../ethernet/mellanox/mlxsw/spectrum_ptp.h    | 20 -------------------
>  .../net/ethernet/microchip/lan743x_ethtool.c  |  4 ----
>  .../microchip/lan966x/lan966x_ethtool.c       | 11 ++++------
>  .../microchip/sparx5/sparx5_ethtool.c         | 11 ++++------
>  drivers/net/ethernet/mscc/ocelot_ptp.c        | 12 ++++-------
>  .../ethernet/pensando/ionic/ionic_ethtool.c   |  2 --
>  drivers/net/ethernet/qlogic/qede/qede_ptp.c   |  9 +--------
>  drivers/net/ethernet/renesas/ravb_main.c      |  4 ++--
>  drivers/net/ethernet/renesas/rswitch.c        |  2 --
>  drivers/net/ethernet/renesas/rtsn.c           |  2 --
>  drivers/net/ethernet/sfc/ethtool.c            |  5 -----
>  drivers/net/ethernet/sfc/siena/ethtool.c      |  5 -----
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  4 ++--
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c   |  2 --
>  drivers/net/ethernet/ti/cpsw_ethtool.c        |  7 +------
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  2 --
>  drivers/net/ethernet/ti/netcp_ethss.c         |  7 +------
>  drivers/net/ethernet/xscale/ixp4xx_eth.c      |  4 +---
>  drivers/ptp/ptp_ines.c                        |  4 ----
>  46 files changed, 47 insertions(+), 208 deletions(-)
> 

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com> # for
drivers/net/ethernet/amd/xgbe/

Thanks,
Shyam

