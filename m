Return-Path: <netdev+bounces-124629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F096A424
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859BE1C23B61
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E8518B49C;
	Tue,  3 Sep 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GL4iwoxS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647554CB2B
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380466; cv=fail; b=L/V22fQylPJz6Y++6hDvXHfAeFX5tslw2KdL6VC08deiTUy6ATNgbRXYFvFuggXvL2URvNmRiU1yyDflyWKUJtD2rjWkXu8B2hwplfhL/W8s/+CQzgeMcCxGFRz7263VYJifyjsDx9nKWPo/tAovRMB636ar/nwXDRAOy7ytuZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380466; c=relaxed/simple;
	bh=shFFM9X1Y+P90/w+aGdTHQtbEjizMWPEl8IFuYywRBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLc7jjdBBjQC7Q1N7ayLMAXw+a+lImYj2zc5UGir+kApNBS1HfAhVDCs4b8YUSNvfFDkCFIOWK6PLkIWXkVoGvNw9FNY61d2VJoAKcvMmu5XhTtqJP2L2EhVM9+0AM2uxIBEZ5m2jxy0/H9pq3f5LrCKr53WaOn3rftRJiWh0dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GL4iwoxS; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux/1O2HU03P+/IaYv4BRUM8sE1Uyu4dW0CHzUgBDDyh0WUjyX5JH84jngD77JCJypcGuezppWaHhwHXdv6qGgwLZWESR2dv1kZ76MT8SENAbousoEcS5WoFq6DrBWyat/3w5Y5sMh4Y3piydW5EZ53nEM85W1v0cmJDyBF5bI0hSb0p248joBQNtUSNnBhh6MqdglcVdyCekpu+UfMZi6BI/BF3slJlIenoIopH+OJSp3KXSRbtzs4zBQ5usobuNpv/2zd+rrTmbqfompWPpvqMM8b9TN6s7d7PS41uEI7aNbYKmSMxHB2T3G4QhgrmKTT3KUz7zQxJEmBRj+B67Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39VuasMWWm+BH5N4VC5/cTyvYoGWJw6sPzrjRWkOBx0=;
 b=ElFJ0J3i4KukRh4OxfE2fMKsPCTD1w2ymTIHZg/3UdQ0LS4CrG+pFL3fdxaei4vCxLLutKWLX5FwNSNFMU62FSl08z5wxmgKiPBCKMlB1hmDSDwl085RtkjlkDCIfBg/MrZafC17dvNnkCGEMpvWEr3aIYwA/oBT0WrhHZwRx0GM3y+4rtvnvWrN/jbLVyIRLJlU4DszzbtpZNGJ7IZLVVURfF+Q5Jrln1uOzZLAP1z1I5scM7jeBHgw7VPfrRqQXpkrKOXf95Re9LCVruYYdWJuu5BHRY+VfPLowY9T1GLTkjWv9S59k75hOQnMlWP2Cg73+hPc9stTIT0TaJjayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39VuasMWWm+BH5N4VC5/cTyvYoGWJw6sPzrjRWkOBx0=;
 b=GL4iwoxSHQSJKVAOlDIJwuQzSakxlzv+C/VVKC3HkGrY0zPrfnkZ01vLVBOpp/1JQO9OCw5cC1Gqdln+10yVLiz2YhenrMt5UztyX2AYP+bPiXHyXwFtKC9E+lZywU69oYh0NWtjKJNai6WWJ3xjbAI4XaTgoG687A0udFNH8Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 16:20:59 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:20:59 +0000
Message-ID: <dabb07b3-4a8a-4d14-9dcd-78e928c1dc72@amd.com>
Date: Tue, 3 Sep 2024 09:20:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/15] ionic: Remove setting of RX software
 timestamp
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
References: <20240901112803.212753-1-gal@nvidia.com>
 <20240901112803.212753-7-gal@nvidia.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240901112803.212753-7-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c5f627-7d3b-4147-f1ca-08dccc346539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzNxTVZ3Q0FBYjNqVU1iU2NvQWcxOHFoK2dkRENNaVZTUUVySWRtUTJVaDd5?=
 =?utf-8?B?QUJiMTU0UVZHdWg0MXlMMWVuSWw4SnFlMGdkRC95UzBWRUVKR2pBNjFpTTNu?=
 =?utf-8?B?VXRpam9UOEpycWQxeGwrSGJreVdFdVI0TzdZZE5tOFA4SVhtOFExUU1pL0hx?=
 =?utf-8?B?TmlDeGxNZjVZb1JCWXloVXozWmN6d1B1c2Yza0ZaQ1BBK1c4eDIzVWhGNFBU?=
 =?utf-8?B?b2FZcVdSRFJvRjh0Uk1WMitqNVJhNFFXd0NrWkNiZ1J2aldUTVZ3b2JBUGNz?=
 =?utf-8?B?N0dvVmtmZkxmQUxJZGFjK3ovVEk5Q2VDWUlIZDFaYXYzWlZBemZVRDJaZFZ4?=
 =?utf-8?B?UUNEaG90VEpRUnBrSjU1em9aejF1UWNDNldMbE8vekpQOUdkMGRDZXV4dndx?=
 =?utf-8?B?UWp1MjBkbjlPRUxFR0NPc1RnbFBqOGZpazVlRkZUYmJodjBqdVFhTjFiWVNZ?=
 =?utf-8?B?WmZFTjNleHZReGg4aHFxUHN3eHBySmhXenRyckVFRGUybis5RVJuQzhjSjZj?=
 =?utf-8?B?dUFtMGRUb1ZFWTEwMkwzQUZxYU5yUkEzWHhXRUNLa3NhalNGaElqVlFLNUgy?=
 =?utf-8?B?MkRzcTB0U3VUcnpRdzRSbkZJL2xucFY0L04zYVRQRFpYNFozYWtYZWtrZ3Q2?=
 =?utf-8?B?VyszeTM3Q3NFOGp1SWpjYXNncForbWpxWG9yWWg5ZE9HbERIa0FYQTExT0pC?=
 =?utf-8?B?dllFZ05UV3puc05TcThNbksxQ0hZNC9td1dkb002d3Evd0l1T0d0MGpnZExT?=
 =?utf-8?B?R1Q1cnVoVnprVHZ5eGk1eTFxQ052OEIwazNWQTFEcmdBMmU4cVdlQlZ0Q295?=
 =?utf-8?B?YXVTZ2JLN0RGcWxmVGJ3RDRnbzFCQndvY2ovM3p1RnZGTUxtbXBFMUQrY2dH?=
 =?utf-8?B?MXdncmpkQUFSUDkzeGlSVUliK08yWElJSkhDUVE1R0cvZDYzY2ZrUDZDaEhY?=
 =?utf-8?B?TVZXd2RMOEMybFFxaDc4QXdsRTNpZm9Udm0wVFhSV2hYZElHcDZKMTBCclB5?=
 =?utf-8?B?MnZHM29Sd0d4ZTMzemdrMXozdjBxMkt0WnJLbkJSdlhPTG96K3RaK2N0Qld4?=
 =?utf-8?B?ZWd4TFUzdHhpeDZldFhNRVRBL2NjcGZKRU1uQkV6Wnd0NFFQUDRJaGN6QlpW?=
 =?utf-8?B?R2IyRVZTOXNUeVo3QnU5Z2REei9zWGZRM0pxcnFPRmRDRUpSRzduS05wM1ND?=
 =?utf-8?B?Vk9SMzRKajdzbVliOHM0b0ZqTklJTDBFcmFGZmxNeVMzM0J5OC9iUkpQeEZs?=
 =?utf-8?B?VExKclBLUWNFSzhLeXYyeXk0TEF5VXVNS25Tb094U3l6ODU0MjFZdmtPc1U2?=
 =?utf-8?B?NmJnUWpFTDdTWjdmNFlsVHNZRmlVZ21YcmQ4NVJSeUY5bXNiWlEyNkU4MFl6?=
 =?utf-8?B?WENSZ1ZsWUFDOGJIUy9rWk1kY21uSWNRU0JHK211NnBHOTUzcmNTemx1ci9i?=
 =?utf-8?B?N2VaWW14VUlmS29LWFdLYUxZc2h4K1hhdVBZWUlkK21GK0cyaW1XK0hyejBF?=
 =?utf-8?B?MXRUTUhsdjlCc1B2YTYyZFpsU29XSzJ4NHFTWHBSbFIvVUFNNkZ0NUIwZGds?=
 =?utf-8?B?ZXhnaFk2R1B2Y0JZSnhleStWNGlrNE91VlAzNndBckdWMHZETktISVliMGxr?=
 =?utf-8?B?NEVuQlJHV0xsaG1mOFlLVDd3dGFvM25GZ2NhaEVLdmJ0MC92S3hnNXBuTDN0?=
 =?utf-8?B?RjFmMitobXk5ancrRVNvMURqTStOTEgzWEhHeHBvYjFqVEpSZkNUdGRRRUhs?=
 =?utf-8?B?OUpLeGVxM01hRmRaMGh0eWRUQllac3lPdGJnQTFsVmR1NnllTFNWR1BGVklz?=
 =?utf-8?B?bUJJU2VMNnR0QVk2NUNZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3hBMGJpc254SUxLWU9EWXAyRFpqT2Yvd0dIdFFMdjg5REZoUVhCTWFRM0ZX?=
 =?utf-8?B?dWtFbFhuMzI1TWtwekNmSm1pcVk1aHVPUmowUkJ0ZHg0L2w0NTE4RDJINmhs?=
 =?utf-8?B?TGsrSDc1ejFmb2EvdTlPdmxVRjdzbUhUdjZ5d3p0bWk3b0hXd2N5UUR3Mngx?=
 =?utf-8?B?SCtiY0xZcXpFck14akg1Y1ZUNWV2UWxhemhlRTlKdGpJbUtUUU9DMkZSZ1d0?=
 =?utf-8?B?cFNwYkVQMS8zc0VKZnQ0SUcxV1NYTXNuVXFWQjlibzdxMEtnMkdBWU55bGJT?=
 =?utf-8?B?L0ZPY3FMd054RGFoaTIvdUFMcDMrMHlid0ozWktSVVRUa042V3hWY2Q4U0ll?=
 =?utf-8?B?Qi9zY2dmdm1pVjd1UDFCaEdWQlFyYVQzQmNkUWMwc1BQdmtoN3BMMTZRaDBr?=
 =?utf-8?B?Vk9hSmhHVDhrSFZObGxyUGFXMG1IWE5JNDFaQVMwTkpEb3NoUitXWWYweVN4?=
 =?utf-8?B?QjlDRWxPK2dzUTkrbE1KR0tBcnlUZDlobU50bFA1bXQ4UExoU2dDZHJFQlFP?=
 =?utf-8?B?ZDZtenNjWmFOb1RuWGFoTXJiUHQ1VzE5UkREMXpPeEcvMnZhSmtLd0tRVGZR?=
 =?utf-8?B?MWRDQVdRaCswaDZNNndTRUJqL2Y3aUdvOGVrSHlrc0dlTzkxRTdMWHk2MW5R?=
 =?utf-8?B?elAxQWNaRXlXNGlXOWFaRVE3ay84WDc4QnhsWkdEaDFEVXpEVmFsUVkxSmQw?=
 =?utf-8?B?UDg2aGlsWVZRempsV1lUREYxa2YwUmdvNUtTK2JqckhORlB2NG0xMk4xdzhs?=
 =?utf-8?B?bTVYMlYvR2dEMENydkQxa2xRb2UrcDJPV0wrbzNUVm41OHowTkcwVFgvOUh6?=
 =?utf-8?B?R094cHVHRm4wZkUwMlVMbUZNalo3OFcwSldyZ0lGeVpYVERkcS85SEpwQUJa?=
 =?utf-8?B?SHE1RHRrRU1HNmVBUlBoL2REa1RkSlZFTER4SDhjTDRmNmNPQ3BoTDlxK1lT?=
 =?utf-8?B?Z2ZDdzc5WmhoUUhDa2IyLzV0WFdQYW51eTNrV3dSdnBEY2dyYkRUenN3L1FO?=
 =?utf-8?B?aUdCNXNsN0ZoUnJIVitZbGRQZWZ0Um51VjVxQ00yTFErZTdFWTF6RngwMlZJ?=
 =?utf-8?B?bUtxOFB5Q1h5ckJ3QnlsTXBzVUxZczJCU2dabUZXQllucXZOZGlobllaZG5q?=
 =?utf-8?B?RUdlRkR3dnlUakxmNGllYXZ4Z283S09aNUJEQjIrenNrT1diMWR2WUNZb3k3?=
 =?utf-8?B?aXMwaHl3TFRUb0pHcHkvUVJtaFJuMXQrMU1UaktHRUJkNlNUbXhBQU90Zk90?=
 =?utf-8?B?UXN5UkpxRjBrMnpIMjFoMHRBbFBBcUp0UnYwRlBZTTdQbUdnRzNueUd6MnMy?=
 =?utf-8?B?MGcrb0hRQzY4cVZXdjZ5V0tRZXJieERkOGhBQUFocDRkMDNIRVEzQm02S2N2?=
 =?utf-8?B?SlFWclQ0aUtIMmFSWldlTE1UbS9USnRjMWxJUXJaT2VHd1RzWjk1cWI0MHFn?=
 =?utf-8?B?N3QvWHJDeENWSWozRDk4MHd3cXZiVm5jRExXTE9jNGZtWVQxWHVGbVc4eVVI?=
 =?utf-8?B?anR2VjBINmwyVWxlaHlndzdISVdiWjI1dEI5WU5zSnBOUnd4THNpbTNJSnl5?=
 =?utf-8?B?M1diR1YvUFpUcmpCZFdwQnV0bGRvS0w1UUlIWEZBU0VMT0VwUjBNLyt5TU9k?=
 =?utf-8?B?TWVReDYvRDhaTlVXWGVPK2dvYVhwcEtMZmhKWitFeWVMdjBUOVVUKzRZK2hi?=
 =?utf-8?B?N3RoNEN3dU01aFBWeTFSaEFWaE9Ba2hjeVplMHYwTVFET1JTTGd2c2MyT2Yv?=
 =?utf-8?B?ZmNMWDhxdmo0RXhxMGFsRWRoSGUrL3I4eVJTbjZrTk5NMEdPaFdiUExja2Zn?=
 =?utf-8?B?SjBzaXhjZXlUOFNzTGU2K0hMNXQvTFJaZmRmZTRsNzFFS0NvMExNaXNrTzlK?=
 =?utf-8?B?RzBNRUg1YXVLZUgxbmJOU3AvQ3BabWg2WjUzNzZoMFc1ck1LaGdxS1hyWnFP?=
 =?utf-8?B?UkErbnpYRnFOa0ZRMEU5ZDFJRWMwbVV0UkNkbVZESmZaWE1MaUUzSVNEZjBV?=
 =?utf-8?B?UFRqVmdlU1dHZEZJdFZtV1JlRmZHelhxZmU0WVlGK25hUFhKWEV2SWN1LzU1?=
 =?utf-8?B?dDh4d1VPOXNBMnM4RVZ2VFNGT3Z2dW14YnVxSVNyMEdkaUd1Vm15b0JDWnli?=
 =?utf-8?Q?ViMKs6iycqiUAccU+HFk5JcJ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c5f627-7d3b-4147-f1ca-08dccc346539
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:20:59.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPCaspetLSRHMVSqPD7MzW2z281D8O/R5wqHuwdCpL9U2shwO/H2Cm3BMUUEB6WNouE+oPx9fwb24AYPNx+N3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113



On 9/1/2024 4:27 AM, Gal Pressman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 4619fd74f3e3..dda22fa4448c 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -989,8 +989,6 @@ static int ionic_get_ts_info(struct net_device *netdev,
>          info->phc_index = ptp_clock_index(lif->phc->ptp);
> 
>          info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> -                               SOF_TIMESTAMPING_RX_SOFTWARE |
> -                               SOF_TIMESTAMPING_SOFTWARE |
>                                  SOF_TIMESTAMPING_TX_HARDWARE |
>                                  SOF_TIMESTAMPING_RX_HARDWARE |
>                                  SOF_TIMESTAMPING_RAW_HARDWARE;
> --
> 2.40.1
> 

Thanks!

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

