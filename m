Return-Path: <netdev+bounces-123985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47B9672C7
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165941C2123B
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884BA14EC64;
	Sat, 31 Aug 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXkRQTZf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049D14D449
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725124774; cv=fail; b=pbsgrWb0MJTlD81JY2NTg0g/ho81juzo4UKXRpgTwMJkt0PYLZ5QBlQLjgCIfDb9m/mNlsswaY28R9Md0PGpypdpYr/94zeMA/4qdOluuugfgh4mmmqe1lOS1Ejn/j5zczsUXn620vhn9MDil9PXkp0HHinVpYyYV24Jbz8wTyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725124774; c=relaxed/simple;
	bh=2p7zVCkRxx5wPtgYIJeCCQfXIm45UIvSZrkRJ3utrgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mr6M+JbjOWcvxCJOoI0ILHOHPhAdXSBfdE1RX86PKwdjYuveO1QMds6z6JuwzDyDByuh4ILXt5+ICozX55VfWXVY+MqHcudz3P8F0Uo5E8uMSpoPQH1BPB1gk+mdM+jgH8AitADBpRNk1f35LN4AMTMi2PXVpsqdDpxAaxIxBsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXkRQTZf; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZ/k+pb6voet6CfT8s4SKxRwwUj9RH17TRWdGv40EfOKQW+dUHPYKBSDmEm6L7lYRGvLZAmBsPUO1VH8gi2nXpZDVb1MsiSLrK6julcU/8deyn63TjmeZhYejilutjn9VuTghWXaVvKKYOSb7eWN/DYw3sTeg17gslru9XDza2GSZP/PZ4N2soVsK/5c5sP+ntYrW8w8mcQrHLU3sim9a1emjbi+FWWUUpeR2+thyjHD/gQzDLUb9dPNYD/zsVYThY/Pw8PsnEAQxLZBXAJI+KbCx5eXOtpdJQG2KCEEHPDez3TC/UKYnzStOTaogOoVhK/wzrBcuVBel5AI/Qrs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am5XY4/T07DnwcfRA3yl9OY344V1QNZtGIXloJ0DVhQ=;
 b=og86AChIcATtqWCxXVY4Jriy6gQZfcaxRL7MR1ESI4wnPxjMwylomFd4S2+M5y9zfw/cPfaMS3no2LnJS29bAb8ep8B6WKzCoUBjP4BtegQZQ7aPN+h7VITjH39PFk6yxuG+czKlS0FyQzpCZC+a5m+k6DEhUPMEHsFg4KVvNzxG1GRWRJBvhnn2cY9FZ0WjXWYtAesDRdYklTq/6RLfFzkxmqj04Jj0M6Mwz1OfPTIoLb9svBGE6A9Hgp2i2NqCYoQzARG5o4UVGFcRAAXtouO5wNzFsMDbQcCruZf7soWsEhSc7ASJKcpHp0IjMpVy7THfReQwbdkWMGWQUQdF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am5XY4/T07DnwcfRA3yl9OY344V1QNZtGIXloJ0DVhQ=;
 b=FXkRQTZfSjUbJGrEySIT6HpD4q/fWXw7ArzgSo4hWGHBzMeVFoYQ04XZoa5CpFWcUh/9W+32GUdTXuqCnQYGmqOlhq7QGYcrzqSXIMscRtuV+Au/2YB5OKIZ6Itbm0nycJZ6tjOi3WnayRdqW6y1lbgfhZkgLORKeWsSzC4JFi+anA8H/2EV3b1w298BiQaK/CcYLF4EnCSJINJa05lON2O4cjS4NnJ9IwS3fcJGwPy+piXBpsIdicQArwz4WGI1RMgKpYnkVytc1YV1D2kXWgMvZr1bGq/6wbUQ7INDNMb1HKnjBhK72BhpSlNfjm5c19s/EWfreEASDuj0jI48oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Sat, 31 Aug
 2024 17:19:28 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%5]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 17:19:28 +0000
Message-ID: <067da3de-3c2f-45e5-a598-cafa62e1f0a8@nvidia.com>
Date: Sat, 31 Aug 2024 20:19:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
To: Richard Cochran <richardcochran@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
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
 Imre Kaloz <kaloz@openwrt.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
 <ZtI2xWNRuloF2RDF@hoboy.vegasvil.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <ZtI2xWNRuloF2RDF@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc86bfe-d326-4ecc-3f89-08dcc9e11177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG9NSGZOT2orZUVReWxQa05aWjk3TXdtTmZEVE1oWEdsUjUzQXlVVHBtVXdE?=
 =?utf-8?B?WTdmVlB3Um5Lc0Y3T0hRaUMwVjJxVUloaTVxVUg1cUpmSmozT1p4VUpJWmVj?=
 =?utf-8?B?NFhMQk9wZXJGb0ZJRzBjVlJ0ZWRncEhpWjRENmpaOG01MmNzL1Q5eUJyRG44?=
 =?utf-8?B?Q0IzVmdrNEFZU2NYQXA5SnI1T0hrUjFqaGJ3NWtCZWNleGQrc2Z5VnJIdXQw?=
 =?utf-8?B?ejcxOUlHRXF1UXpSMkluQzZ0cStJYWE2SG14Rnp6dFROeHNoOWFsU0JWbFg2?=
 =?utf-8?B?UytDSjYvTitZbFNLY1h2Y0UxQXQvYUtOeW45b0hIT2tUaWtSclFvSm1CdjVJ?=
 =?utf-8?B?aXUrNDZUSnRMRFVDTnU0ZFg4dHBvY3Z3RmZHQ0oyZXN5K0I3MlZGd2lZQVAy?=
 =?utf-8?B?UGVjQ0ZKMk8rM0VKcXVGMHJOcytNa2J0NG1sZXdOVC9lTnVPT0wzMWJxUWhK?=
 =?utf-8?B?djMweCtSbVBzZU9qeVZVelpubWtVclBWREpVamhRc3Rkby90TkxYMlFXK1Zy?=
 =?utf-8?B?M1FCNDh3cWl4clBaTlRvaWZjUWtRMm5ZU1BkZHF1bUM5ZU5maUlFVzVDQWhx?=
 =?utf-8?B?RFVtbDR0WHpQdEJFSmJFYzB0NDhrUkY2eVY5czY2aVlTWjJ0ME9ud2ZCSHph?=
 =?utf-8?B?dEp5T1Mrc2xhL1J2blR6NmUzN0owQm13dC84ZTBrbCtzMlEzMnNZYWtHYzRI?=
 =?utf-8?B?MkhnUzFzajJ1ZWd4Yis3TnZwRy9kS0tua290RnFWcWxiTFo0YVJEc01VTDdn?=
 =?utf-8?B?emcxaktnYWlxc0I3UGVvNFpFWndLdnQ5MnBtVUpSWTY4dmdrRHZLRmZwakhB?=
 =?utf-8?B?QStPZXhCR01UNytjQ3AxVmRuK0o0aC81N0VzeDhWMmpSajl2dytQYTZudHBv?=
 =?utf-8?B?RXgwSzBoWGFMK0s5TWY4T2ZpdnV3UkY4VGRLUmI3TlNIdUk5azV3cjNJaVYw?=
 =?utf-8?B?RCs2bGttdjRVcHAyUDRGOHBLaVc0UmlhU3ZKN3lURjRkMVNwRytvMzR0RDEr?=
 =?utf-8?B?OW5Bc2xlTi9KZFpNTmhlMXpjbHFaWm5qclIveDBZdmlqTUNxN2ZWTHZDUjht?=
 =?utf-8?B?UnVrMENLb2g0dXpJNUVWQm1hWGNlRmRzejNWNCtROGlNR0ppVkp4TUJSNW9M?=
 =?utf-8?B?NHdJRlRQb2VTdkVlYUhDaTlLNFp6UmNubFRSd09DaHRDT05aeGgvdTc1ZEFJ?=
 =?utf-8?B?NXZsQkpwejdFMWd5MEIwRHZHS20rSjlyQmpTcTA2L2JUb2VhOENzMUMrNnZx?=
 =?utf-8?B?azNCSDFNSmhrSFZqSmk0WTNOOVRqaHp5M2doaXJBVmtHQkpKMmM5VzZrOTN3?=
 =?utf-8?B?Q0NJbjg1ZlBOUTlrdGtmWDd4YTN6Zm5QdEI2UzFCUndHcG1lZzJLNG5LNkg4?=
 =?utf-8?B?YlIyV3FXMm41emNMWGdFRGRKd25XbGMwYWVEM0NBeW1JUUQ0YzI3L2xXRXFm?=
 =?utf-8?B?Vk1FeVlScEdDYUVnYnhXR1IwQndyMmlsQnJoWkxEUDVjZ3Y5bDlmY3F5cWwv?=
 =?utf-8?B?cVJtaTZkS29HUXVDTmtOVU9SeSsrSmNVcng4bzhseVFuVW1oUktFZEhXZVZp?=
 =?utf-8?B?dlEwLzZwSWlMZlZhK0ZpZEhIbTZSVVcyVytGNU1FR3FvWi9qcGhDUXluMnAx?=
 =?utf-8?B?WlRFbzFGUU1RUmdFdGFwMVJteDRsUE4rTFFOdFJ3YnFZMDZvTE1GZnhPTWFL?=
 =?utf-8?B?MVFxdWx4Qkk2ak9WYXRxQjI4Y1kwaUlLNHUvVkIvcnlhaEJSZ28xM1dxcTBU?=
 =?utf-8?B?NzZSVThiYjV1VkJWQnY2UGtGK0RUTUc4SElJWGh3b01UQjMxSksyUUNtS0hY?=
 =?utf-8?B?Umhzemxxak5aV3pWOHpwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVlYVVZqN0Mvb3ZMK2dxQTZGbzUxYXk2anB6TkdRejZ3Z2NlL2ROQXIwTnBr?=
 =?utf-8?B?WkxWMm96L2d3RE1CaGQydWtNUkYzVXErY1EwMGZLKy9PT1BHb1doZDBoaXdz?=
 =?utf-8?B?Y1pMdjVLZzcrbkVxWXlPMXJhOEtUR3poNDM0T3JDYzZjRGZLSVVlZDlXbzZX?=
 =?utf-8?B?T3BudFVCeSsxS2NMWFVmZmE1U0x5QW91N3pWWklJbUlYZytPTTd0bzRhMjRQ?=
 =?utf-8?B?NHdwb1JacWhxRmZzR3dBVnBQQlkvUXRiVEw1a21kSnB3dkNscEUxY0NMNXh3?=
 =?utf-8?B?ZXJUNW44bW9KckJFeE80Ynp2ZHNxN0Y2M21KRWFlZXU0TUdIU3d1RjNoUU9B?=
 =?utf-8?B?d2lrNWJiMEs0SVVHdmE3NVoyenYwWHl2eUtYTE1KanJ4SzNBNDdMeUpTOWZ3?=
 =?utf-8?B?ZVpJQWhwVmVuek1aUjVSeElqRC9OVW9VL2lqZGwyMjltdHhsUWpFeXFmc2Fz?=
 =?utf-8?B?dURNb0YwNXBYdlRMK0oyM2RQUThjYmNobDJOdVAxZ2dtNGJRYVQzK1NaN21P?=
 =?utf-8?B?RFZjY2VPQ1Y3U0FSV1FQOHJNbHJUaEcyVXlTN3N3UUNNVUlFcTZWR3M1aDVo?=
 =?utf-8?B?ZHJoZlRWU1JGallHZVZWTEJxVXZMU2t4emRoSkM1NDFpclNNUUNlUnNRN3NV?=
 =?utf-8?B?VFFHQXBNTDN3RW41dlNHN0FBVStaV1dMN1pRWDZkY3JIeVNld2JlbWJoTlNY?=
 =?utf-8?B?Q1NBdldJRzNSMGNJU1NQT3lHT1IxUWRtN1FIQVBTeTFPTmJxZ1VyY3BtdGFJ?=
 =?utf-8?B?WVFpQVY4UzFxOUYxVGQ2ZTUvdThiTjFWbXFxTVQ0M0tFOUk1NmlxbkJVeVlH?=
 =?utf-8?B?UVhTS0VyZ0tseWJUSG5IV3dpczNWVWhaMk11TlZieGJFSW5jWFBrOVBOSTZw?=
 =?utf-8?B?MzhublF3dnJtcUxrMndUbktObnJGd3k1WnE5Q3FWYXVPeDJyak1wWWJ5b1NX?=
 =?utf-8?B?WUtVNVlENGs2SU12NzA2UW5TaTRHaTliN1N4SmR6SU82YUNmTFhiOGZsUFFD?=
 =?utf-8?B?RkwxWnRwTDhsWURhSVVJRkVBRjVyR0YrWmVlemdmeGhsRkJlQis4SjdnaDQ3?=
 =?utf-8?B?OVp4Y21DaFRxREF1bTNPMkVuSTdwaFpvQk1ZTmJHdGFDSU5Kdlp4cmVaa2ZF?=
 =?utf-8?B?RDFla09nd3F1TGM1bklUcU1kdkFXNU14bHRMUWJzZExRc0Y1bWxxQnZpT1BL?=
 =?utf-8?B?VHl4TVU1MmJ3aHRMeXNvSjhzeDBHdVlnVGZ5eU0vOGcvZ2x0R0F0RVhvR2FC?=
 =?utf-8?B?SThYMkNUOEdHdUpKcWk2UkZVM2czUHI4VHRqYnFhcnNKc2V0RzQyelFFUUpH?=
 =?utf-8?B?dzg1dGhseGJkeW0xM2lVbTU0ZHlwOW94VTVuOFF6OFBxUGxIRDZBUENreFBo?=
 =?utf-8?B?ZFVZSFlCdHcvU1JzOUs3WkJHNGN4aGlnbnJsOUswK01Gb2p3SlE4dDFlSTdr?=
 =?utf-8?B?ZUlGMERwRGdaRlJWZ3VvbU8yOWRMSUdwL1k1TnM0bStxdEI1YVhTcUEvelRC?=
 =?utf-8?B?ZlQzWTk5Y21vVk0vbzcyRkExM3IwMG9XeTM5YkFPR1dZaXVMdGZuSzh2K1FS?=
 =?utf-8?B?czBmSHZrVEdwVjJ6T3ErTTVrUmVHY2xjczlxUEpnVUEzVXJJcWRFdVBHOWMx?=
 =?utf-8?B?N3F3bDFZMWhFYWI1cGFMOURQZ1RDd0VOUXpxTXo3WUx6dUFPajVRVXBKSU14?=
 =?utf-8?B?Z3Q2aUJsd0VYbjcwOEUzRk84dmhoclNkUXoweUJ1WEhDcjJ1elFDc0hvbjhO?=
 =?utf-8?B?aWh1RGhaWTdsaXdZa3hONlh0WFZrNEdJbkExMzJmQkFXdDB4S1RkcmYvcTZy?=
 =?utf-8?B?YVFqNmxnMTJkaWRhVnpoTWpPNHB2ZTdnc040V0tKVithZlR6T1M1MjBHazM3?=
 =?utf-8?B?MVNqNGhROVhGQnZia21POHRRM09rWi9GOTBHZHg5R0lFZlRiUmNtV1A3VDhQ?=
 =?utf-8?B?WnJWWXNCSDFOLytPdVNtd05aemgwOWJmaDYxenNvSWdrbjdjMjN5Vjdpb1o2?=
 =?utf-8?B?ZDczMXVyMXJpenhrYkQvS0M3di94MjA2eVQ0b3JaZVhoRVpBeS9UdzZydE5B?=
 =?utf-8?B?ejBQWjZ5SW5pUUNtQzZTSjhTNG1hOXVacjVhbnJWYklQRFZIaVFIRkJ1MUc2?=
 =?utf-8?Q?wxjlT+ySYY/eeU1z/FTFDCaNg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc86bfe-d326-4ecc-3f89-08dcc9e11177
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 17:19:28.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwCLONI8rLy427EaPaT6/heCUhw5bpddZdUlsmGXjxhERP7+DjpDGamxYn6JhN4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107

On 31/08/2024 0:16, Richard Cochran wrote:
> On Thu, Aug 29, 2024 at 05:42:53PM +0300, Gal Pressman wrote:
> 
>>  drivers/net/bonding/bond_main.c               |  3 ---
>>  drivers/net/can/dev/dev.c                     |  3 ---
>>  drivers/net/can/peak_canfd/peak_canfd.c       |  3 ---
> 
> ...
> 
>>  drivers/net/ethernet/ti/netcp_ethss.c         |  7 +------
>>  drivers/net/ethernet/xscale/ixp4xx_eth.c      |  4 +---
>>  drivers/ptp/ptp_ines.c                        |  4 ----
>>  46 files changed, 47 insertions(+), 208 deletions(-)
> 
> This needs to be broken out into one patch per driver.
> That way, one can easily track the Acks.

I would, but it's not allowed to post series with more than 15 patches.

