Return-Path: <netdev+bounces-123487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1F9650B5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1B31F21405
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD29A1BA88A;
	Thu, 29 Aug 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="syfu93TB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868D1B86E4
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963032; cv=fail; b=WxGaevUluPj+IAmEshyiVX6ZfP3w29BsfSyN+C9jxbVX8S1gi0iD2wTZj8qHIT9DArZYlm70kObtl2yCxtpSW6hVoAT5dMSYrdTpZdFB0b1VYppTYp2xoY3QtK5zmowGCRP96XDPEYBPJcWyGRwv6UM+eb4SK1RotRIx3rhdVLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963032; c=relaxed/simple;
	bh=vX0rZbHJ06rULon4udcxlxynfjVRJMKX7x0mu1yXvTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jog5diixeWLpY3Zjg9M8XcZ97X6zFsit1bcom+ZvHqlVf/MHvF9YjJVPtl5DyfgvHm/QXF39NB4HzWJklDmLYnUqwxERqR+GK79AXiQFIIKpn9nGUXivKnbo4RbINpwD13ZlJV2vxf5jGtC+xWjTzw3qeLIIghBbwCgsImCEFIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=syfu93TB; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9Yi9sjx4qEoCP4VAxfcyyfgSC7FFK1ku/7T47ex0Z1yNmbmBEODONFjIhKOQ+v1BrfABWm/aLSf20hRa/fY56oAG+pCJTd1woUceBhubPIoGwWLsWvk5Di/1ilo3mo4EeM6emkeVw2zsfRAJdF9F4AyLCkUlC+Wq31CMvSKOguykVwtuvdINuXaiyDKkuNgF9D1X9H9br8LhKJbd98DOtSnDXZ1nGbp9IUX0rnPNm1C7wATsItXZ8rSoPqII7DedRtFOuHRQdpDReL27VYCZOqfkzhtTQFg1sxNccgGCy8i4hnSVsZMM1lXwBk4+JYD1nuNeVT0EnHWAihMkgpwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0E+URX/qOMNsh9Qp630/STSrRcllVOuIRLiA5DmbSI=;
 b=IPjHshnt/E+E1g2EoyJOTZJ5zpClweMhvvouwoER+bRLZvMs1rppnaWhAFKAP32tc9z8V7aVBdgjbr1nKK4zENNI3dmpEBf8lDISlnyTQYX7YX7gU9PUr/VCtpc73PDTX5jawHOHjggNoTHg0pefWvPfbFHEmVeomAwC/3UxjbDtGnE3wTxzs6g1ouglYXXZFF4T8Tyviup2EwHcBQXEeMwbTO2tARI7l4i1r27j1MKfyBePQoH0TOD6vWzSMLZgZSFC286jwA5nckoI0Ach2TTT824XJL+S0sLsR3oG/gTGYmBFucGEUGbnMgpp0jtuNWzC8qf04UKojv0WgdZuEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0E+URX/qOMNsh9Qp630/STSrRcllVOuIRLiA5DmbSI=;
 b=syfu93TBLDph/zZKzkdLZtt5dxFU+BbGHWrzn4B6EBA5oMak/1Nlv/xCD0qPSGAsPDjg/tIAl+5y7m4/9SZ1Z4lla1pmIkRR9tkt+ktpjHJJw/GxUbGxYtXXxD3Ynz8HXFyEuGcVou2d3P1qe4EJs3AD7981UJfZS06h4ibVI/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 20:23:44 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 20:23:44 +0000
Message-ID: <7543262b-7500-46aa-92ae-ecbd8d2ddca5@amd.com>
Date: Thu, 29 Aug 2024 13:23:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
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
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b50430-5831-469d-fab5-08dcc8687a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjBsWXNlak9aS2FCdTZiOWNiQjN1WE9LaHQxQUo3d25SUXNidk5Gc24xaGs5?=
 =?utf-8?B?U0d6MGJEbS9NM2NMbmtSd1pKNWkyWmRqaVV6b0tTQlMzV2xvTDRxR0E0M0sy?=
 =?utf-8?B?UUpVelJEQ3B6NC9hbkQ1WFlVaW03cmlRcXVjc2lmOEMvVjlocFp5c3ZJVkJu?=
 =?utf-8?B?NmdwWS9udkdWOW83MVNxclplU1hQNmhnVVkyV0plQWFJTEVSaklCcHUrR0Ju?=
 =?utf-8?B?clA0RjBBSy82bjhOajFiTnFZSXBCR2Y4OTVLSXZGaWdlc3VOa3dmV1BCdjds?=
 =?utf-8?B?VS9MTmFmWENUTSt4N2RnWWtnSDdjM0tPSWhNT0hlaDVIQlE0QmcxMGdodHB0?=
 =?utf-8?B?OG0zL2dOcUdNZ2lwK0xBMk1waWlVajdnUmJRQjJWZldLaUUvWUQvMHRkejFM?=
 =?utf-8?B?MWRsMkQ5NndpdnJMNnowR1ZrMnRSMUNYZ2FRY3lOVUFnOXhLQm5PeUpEWW9E?=
 =?utf-8?B?ZkM0YXl3OC9MeHorNEY5TmxyclgxMXkvdktXQzdwWUd2L3NSWkZyTUkyWmx6?=
 =?utf-8?B?VThlak1XWkFMNDNYNk11MnZvM2x3MXdRYi9kMEdMMWNwVHlRNFgrMkw2eXZC?=
 =?utf-8?B?YzcrR2NENTJ5Qm1KZFo1MjNIZUoxb0hjcXZZU2VTRjd0U091M3ppU2tKc0Zh?=
 =?utf-8?B?LzJseFhPa05yUGlkbFBYclltMTVvZEd4bVdnejFKT1hYS0xxd254d0RQd2x6?=
 =?utf-8?B?RW52YUtoK3pnRXJ4UWNoL3ZnY3VXSng4a0hTS2ZuSE56cUUwUEJQV3VFZmhn?=
 =?utf-8?B?T3J4VVMyai9XdG8xTUxkd3BjaHhOQ3BGNTBUbWZWMlFTT1NmU2w1R2FRR1Vo?=
 =?utf-8?B?V1FqRmFIYWE4MmFPdVVnMHFXWnFuYVdUMGVjNktaZmVjNEhaUXpVNTJsSmE5?=
 =?utf-8?B?M1pYNzd3d2t4NHl4ZzA2WUdoTURSajZBNVFqTFFRTy9ZUnZwUlZXWmgzTW5v?=
 =?utf-8?B?V09sd2l6WkphV0haL3kwTks4NUxwVFoxWStVUmdpeVlqWklxbXh0cHJCVGZR?=
 =?utf-8?B?a0xjcGVzODVGemVINTRLMFlFQkVTRiszVFpCc3FHOWRZb29ucXpZQmR6U2lq?=
 =?utf-8?B?SkIwVkVvcksrS1RFOHg1YkJ6eVhuU2lxUXh0cXRza3BhZjNxYmV6L29xT0o5?=
 =?utf-8?B?dE1VYlduNWMyb01mNk43Wm4ySCtWZjdiMHBwWjkrUU45ZVB5NjRvSjVqMXFx?=
 =?utf-8?B?YS9wRUkyZ0ZDQzFOQ2QwWkpUa2t4ZjBqWCs3MStTNGtzaytWYzduanVYcE02?=
 =?utf-8?B?U1JVZFZ1ZGZFS2N3Qzh5MFEyRjNYSFZzUDVWMkFNckQ0NFI1bldieng1RW5u?=
 =?utf-8?B?eVl1MEZhenJjeUY4NW5oSUlFckdIdXRHT2IwTnlEa0Z3a1NXVUpXUmJuSWxJ?=
 =?utf-8?B?OTJmOVQxaHVPektMUGNCS1haU0ZPNllvQUtKZFhjMXlCeE9FZllQeHhZZjFy?=
 =?utf-8?B?dXBLOWNYdytiOXVHSnpNanhXT1FDUjVocDJONTNpclBlbjdYN09TdFl6Vmxz?=
 =?utf-8?B?eDJZK3R4WWV3RnVsc1pUMlhUczlrWlhPcHcrSURhbWJXV2luMDNRcUYrZ29F?=
 =?utf-8?B?U2w5dWtOMTQ4RW11RGVaZjVBUE5GWTRwd0t6T1RpU2svbTZnK2tHcnQ5RWhz?=
 =?utf-8?B?cGdMQVJpUUNCdnFyR0JGazVTd3d1MXlTTmFSdms4YjNTOWtOazVxc1ZHdFBm?=
 =?utf-8?B?YXc4T2h0VTdJUjB6ZDd6UDNNTnJYd1hUWVBQaDEvMExHcXNhM29ZSVZKem5s?=
 =?utf-8?B?dVBPTlExTTMxdHRTSE5QTHRtSmREbFFQSkh1c1pGVzFSRzl6SHFrZmFBY2pI?=
 =?utf-8?B?NWswV0RzTnZZM2kzTWpXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YktsQkt1VFNISGcrRkV2ZnQwRVp5MWRyR2lYNzM5VlpxTjNncDV1QkViRmE5?=
 =?utf-8?B?N3lPdzNkSGEySzFHVHI4L25Dc3dmQlRZQlFPZjFmMFNUYzhMNXdWbWljTUhv?=
 =?utf-8?B?aFZrcjFKR09ST1BXVDBrK0NpT08rTUROcll5a2xkTTZtZ0tTUGRyR3ZyR1Rh?=
 =?utf-8?B?WXE2dzFBN0x2TGthR0hUb1dPb1BCZmRrQnhWMzBXY2VjTDM2aTNYaTNyemxr?=
 =?utf-8?B?MEpVdFF2NTFHcDM2bVYzQ3hWZExOUzhib0pPV0hZMXJRVkl1dWpycGhzVTFw?=
 =?utf-8?B?YnptbHJSYTYxeXRaODZ2OFN3VUp3SVpvcHZDeGYzNk81SElqWjh3Zi8rZE05?=
 =?utf-8?B?cVZwSU5sTGxQQTFKZEg1WGpDL1Q4Rk1CZy9VY1ZQQ0NmdFlWbzhCT2EzSFVu?=
 =?utf-8?B?TGx2ckM5TXlJTTFRUkpUNTlCMVJqdW5BZTAvMmdCT25FbmtNUURySEZESkpY?=
 =?utf-8?B?MERHY3d3WnpmQmlEOEJjRzBRdUxESUkyVENHT001RGQ5UE40aTJPRU12UW05?=
 =?utf-8?B?OGFBSGh5MTh3YkkrTUx0UUd0TmRvb2hPRGt3QTh5R3VrUHpFYzV4WDhsZlBV?=
 =?utf-8?B?akdacDNNRmFMWkZiVEhXRVM3eFRjZGV5NUd1aVVlMWhYd2JJMlo4bm45WUZB?=
 =?utf-8?B?WHlLejE3TDFoUnRydVVEaUJscGJKTEdUeDNQSXE1SUdURjBxdWdmUVpGNGpZ?=
 =?utf-8?B?RDAySnZCcWRzOG1GRy9JS3NVUHlmdGUrRkxpekhRUk9iTmZabkZUeEJSRFl4?=
 =?utf-8?B?d0hIMzhqQUVDTFZ2WklveXAxR2JKSlFOdVNTUTVpdGtRU3NxV2NUNlRYZUVw?=
 =?utf-8?B?VEh4QXhIOERnUzg1Vko0cXRiQmZjVWE0UHA5UVVpbHFUNnArUUh2SlBkd2JF?=
 =?utf-8?B?T002eGxNckpxNEEzV3BtbTlHK0ZuZEVxWTJrRTFxeVF0bVo5bkV6dHhzb0FS?=
 =?utf-8?B?V1FvRkNZMWFFYUI3RmlvUENBNGxvRFdpS09LYUc4MU9mdDVSSnAyWElJR2Ez?=
 =?utf-8?B?dlNMMnNGMWRISlphcVd3NVdpa0VuMjRvWkdQUWo1dzFqRzVOT1d2bnhJTlRS?=
 =?utf-8?B?alc1Z1MwMzB6NHA5d1l5eVB2L0lrKzRqYzRodlYzUUliVnhjY0tSMGMxVTBN?=
 =?utf-8?B?ZjU0WDlHdEFwNWFsR3k0WGMvYVFyU0RhOGxCZjFHSlFac2M4OEFPTXR4bWow?=
 =?utf-8?B?TXFHMU9OQVFGWkxaRFdNVjUyNUMxbnZGb0doT0dLcEpmUWMzQzhURlUxYXNS?=
 =?utf-8?B?dFJwc29mM0cyaTJpVHZoMjdPQ1lwNnpkQWJHamFoYy9uYmNmdGs2Mlh0ZVB2?=
 =?utf-8?B?bWNlZUR0bFBQTlRqdkFFNHIyR1Q0d1hFeHQyN2Ivc2sxOS8wZm42NnBBVHU0?=
 =?utf-8?B?UWcyRTQrdjRxQ3VJMWhzR3ZPUFhNOFpZRmozdEJIcndQNkoyanBiZUx1Z3lZ?=
 =?utf-8?B?UUdGcHJvVkVPZUcxalJkRVFjYzd6NkxBWGVjMm9CUnFqU0oxY1Vha1UwWGpD?=
 =?utf-8?B?VkdlZHFET0FyS3gvZ0hvTFoycmVpZVJYaHFtMDdUd2VZbWxoU2pHWnN6NC8w?=
 =?utf-8?B?UkZLTU8wQ0JBQ2dzWVlscXRrMjBvRFErR3RuRXhNbnRYN3F6UVM2dXErakJl?=
 =?utf-8?B?Zy96S2MzNUFkbVNKZXRPYXpFRmlyODdib1g5eWRwNE5SR3pVUkRWVmM4cm5U?=
 =?utf-8?B?RnJEOU1QZmp1VTlDL2p2UGRlNXpEcTlmbk9yMGxjOGRZWGs0Nkc3dFFwRnZu?=
 =?utf-8?B?bndjdXhkTTFMcVJtcUpaOC9uT004bE1TUmFlc0hmUHlIV0o4RDBaNWpTUDcz?=
 =?utf-8?B?a3ZmQi9DNk5Fd0ZERCtHUkZpZ1daaktCa0pEUWRFaGxoNFdoelNZZm0ya1g2?=
 =?utf-8?B?K2RQOVlaMFRKM0JBdzlNMC9DNFNxdHk5b082OExhMU9DVi9kODh2SzB2Rml4?=
 =?utf-8?B?NDYzTHR3ckZCVVhZZzM2L0ZpTitoVU1sRjRMcHE2d0N4K0c2MlVhWEhRTzRs?=
 =?utf-8?B?aExXNWpxcUE3SkNCNjFEN0FoWWFyZVJhMEd2UmVOc3hkeXpDaXVuREZUek5E?=
 =?utf-8?B?NGd4LzBTS3BPWmVEMi84UHhpMWxTNllWYVRUbWlEc2Z2SElmMHM3K09JMWFQ?=
 =?utf-8?Q?iCmahB5NEXwGRf0t4DuNO3eVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b50430-5831-469d-fab5-08dcc8687a81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 20:23:43.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eVLUhvbtEJgnxpMRJQwsK1vA/fbysWp3mBCmqDtFweMkWDmYMaPN0zciLhEM25rW8sdQy/9DlDVhm83xgDmvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418

On 8/29/2024 7:42 AM, Gal Pressman wrote:
> 
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---

for drivers/net/ethernet/pensando/ionic

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

