Return-Path: <netdev+bounces-182513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD5A88FA9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404EB17C337
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8D1E3DFD;
	Mon, 14 Apr 2025 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HM7FJfdR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1776DDDC;
	Mon, 14 Apr 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671313; cv=fail; b=UIIH4zgItauxFgYfYRZhEWBDj5il341B7+Tl88W8rHC+AdA7pfJ45PXA/7U1DNwqSiGS0Rk7bdgsOfy+nuszfvrTdgy1Ztf0vkAaXrk43rdMo2b5YsagS3X9gsKFcsNYExG+nhwdDttbw1tGCBC2njb5SIyOuka9qu0p4tFGkAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671313; c=relaxed/simple;
	bh=5X4oxi9N/cWgqs9bek3r3aC8AXnwaicsB+t3qr6F9bo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ohdJeQZukrgsRWoN/eKrOyyQmCQ5PU5XwPIul7LGJ4srt5gmffi5Y/0eaXf1n67FteitITMGhmS8fFVQ/VYnDiTqP3ht/jK9XskcLO17GZfKaF1GVxpQWQe7T4qhFhWcyYWebGfJQRDL5kP1Jlxpehzs6d0KCzs6b5J7MLYM3L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HM7FJfdR; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv02eQcX1wROZrlqAEpQroz6ucVw7JE2D3e9GTAnYIjAYYMo1P73KGmBiHCDzxQUmvIZC4Idd7Cj7m3tBLEctyJQT6wIMOwIMBzBDOwXoyGM1dyjLiVoQpeA579JA5VEHfwEFW8r9Gp/y+h9LgjGLbn0J4rg10CccOGzRe+BlSdiLaCx5cADov9hWsHeDpn6IbrgfVbGtBBWHFEaW9zNAQUsnYCinfd6px0yEoP3RJ9CufitOiv5kaZwKeXm1mLFQjm/v6JGWzU5qr6I3Vt/8CTMlF7+HM8Q7AH6OFY3Z3ZJQAAtqDtF4G1AcisaEACBEiehadN22dsQomPgEFqXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei33/qAg2af3khyY2MuXL4urAK73UTy3CQiR31crrsk=;
 b=mUZno5WlOvZ1nwesUwAVTXxF4XgiA7ruSnZn2feWnhzqMjTX/sG/r3RjraU0+oJ7wLiSl79ZQ0tXpXrjg/13BTMgGP32HvDL88tqreLkd3UWwVtzbFUCtomqqOzCVGlVqKjOHNa128ECwxTglZcniBOXPe6Z2/mRsM7YiIF1fcgtTlbQYhzxrcsKlltn0A51ZZsTSPDENyc1oyjgSu/NZ7IEHD+3RQjDpBagFCbhu73hJV/gpDSws9EbhaU14R2wei728o9ZkpvsvneNodjSE3yvSTvSUrCecOHJRqw7kfXMYX3aKaivuaoPKrCL+GY1xqvd5vNvSSIzdej/f+QSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei33/qAg2af3khyY2MuXL4urAK73UTy3CQiR31crrsk=;
 b=HM7FJfdRiflsryS86rEo2puyua47SyegWFNxuOWCUbHN9bcGQCH21a2CNKlGb2LRfS5BH2VNYJxdgzgMO1iddmLclYYgE/ziL+cGvJBcqH+JkjJeo/a7UcFtBOolz/zODmC1qD/JlzbcKGPvu79hObhSiorrxMqP1Op8N401KV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Mon, 14 Apr 2025 22:55:09 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 22:55:08 +0000
Message-ID: <6e6dc5e2-5af2-48a7-a017-0ebaebe989e8@amd.com>
Date: Mon, 14 Apr 2025 15:55:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ionic: support ethtool
 get_module_eeprom_by_page
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, brett.creeley@amd.com
References: <20250411182140.63158-1-shannon.nelson@amd.com>
 <20250411182140.63158-3-shannon.nelson@amd.com>
 <ed497741-9fcc-44fc-850d-5c018f2ef90e@lunn.ch>
 <a32f6b8a-860b-4452-87f0-04e0d289d473@amd.com>
 <891f1b66-0b49-41ce-bb00-5345ef9afb5c@lunn.ch>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <891f1b66-0b49-41ce-bb00-5345ef9afb5c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a3b37a-44fa-4bf9-f03b-08dd7ba767a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1dIdEYxUS9NN21MU2syMjZ5aXF6YTNBM2dWcGNLMlh5UHM5bENnai9Ta29Q?=
 =?utf-8?B?T1BVaXhQWmdodjRpTktMOXZUTmppdkdvY0x6QUl6b3BpYkR1R2t2UW9rd0RU?=
 =?utf-8?B?ZWs0VDRPSTQwcFNjeXZPZDBJWUhHN25JeDRjWDErc2hMZFV3SWZ0VGFrbk1S?=
 =?utf-8?B?MVRYaXNNbmhrZm01YTBJN0hmRXRSaDVqVVFLcU9ZbXhWcGx3aTZXK21qTUlW?=
 =?utf-8?B?RDlMekpFTUErbjMxVlNlbm51elNwc3BoYm9zVko0YVN4T1Zscll2YWMySkxO?=
 =?utf-8?B?WFp5cU1UbU5QNUJZekhvcFppbC9rRVhMUVRvMWZhRUlWWUc4L1l3OFR4ZnA0?=
 =?utf-8?B?QjVMOVNlOFd4anM1dlJoTXNWbU9wVnRQbDJjVS92YURPZm5qN3dCK2NXVEpi?=
 =?utf-8?B?TXN0Rkp5V2t4U0U3dThjVVQyYVZSdi9PNzRPUmg2ejlNb0dONEFDVkRnSjFW?=
 =?utf-8?B?aURpaldNamluYkczTU5PN0xzdUZqemZOY3EvMmFoN2R1RnNvc0xEOTdsTVFD?=
 =?utf-8?B?MEg1TTRIUWY2RlI2OGNNdllKckZ1TzZkNG8xTDlQWmluSVE3d2tWc0YzZFM5?=
 =?utf-8?B?SEx2YVJaMVRoMlhJUVo4bFdwT3Qyd0owZnlHWFE5TTFhejBabkRHMzRRNkJs?=
 =?utf-8?B?czJEK212dFA4TUR1bVZWeHcvdnJRS0NJVmhJOWk5SGswVDc4SERGQW9mbERl?=
 =?utf-8?B?dzhsbDJCVWh1RlZMWTNwWFozdnZVMlpybTZvcnFkb1djVEE2eEROZlZTZFFt?=
 =?utf-8?B?aUNvb2drTDc5dWIrQkZPRGVnWFVlaW9wbUZzV0tqRGhnVnd2YW0vNjc2Wmlh?=
 =?utf-8?B?eitrcnBVU3RqN2g2ZXZpRjc4WFBpV3ZMbkFBL283UUJreUo2MUJZNXZSVG5N?=
 =?utf-8?B?SEZWdVZrZ1hURjMxcWVTckkybHFHZ1RHTVpYaWNZVU5NbWNxdjFXWFBSUGZH?=
 =?utf-8?B?QkRDUndHakJxM0dRTldUZzRhYzFFY1lwMjBvd2Z6L0hlVWZZVmdSeWwwK1VF?=
 =?utf-8?B?V2xXNFRMOGxPNG1wZGF0M2sxNWZTaS84YmpVc0FNVlR5N253L0JwZlhwZlFi?=
 =?utf-8?B?cjBsUEhsVldEMzQrcWZ0WVBVM0w0N0dOOUR1RisyRkR0Z2VkZExGVG5nempH?=
 =?utf-8?B?VGdoN1FvS3J4OHVKK1d2WEpXUWVoVEwrNWVDdUg5RkZLbnhrQUMxM2UrblhT?=
 =?utf-8?B?U0ErVWF5bFdWSGhvVnRwSTZHRkVkNGZqVVVZaWJXQ2p3T0RjcExqQ0RXSnIz?=
 =?utf-8?B?dkszbXNFWVdZbDVpaWFDQ1dHMmNnL3Y5VnBvZlIrTDBYbUFKRHZSREdRVXJE?=
 =?utf-8?B?dlJVMU5yTXdXK1NNQVVISXBGVjlGaE1uMVhHOXNPVmcvY0k0Qk1DUm8xRXpC?=
 =?utf-8?B?SlhsU3l6RmlsQVQybEhHWVJ4c3I4cFlSZVd6ZmlXQUlGclNneDB2T2JEYzdi?=
 =?utf-8?B?Z1VrR05vcEtMa2lJTVl0T0JFVHBncnhBTTF3MVZZZHpBVHdoQmw2TzZXRGxV?=
 =?utf-8?B?cHI5WkZUTUlhUFZUcFUxVHJmTlJKS085NjBuK21xblZKRDBxWHN3TnpDU3U0?=
 =?utf-8?B?eDkybUpnZEhPUlVQR1U0dWR5T2dTaG5wWDAwMy9xMkFMQjJwd3g4V3M0emd0?=
 =?utf-8?B?QWpsdXVUQWgxRDc5bjZFVUdkeSsxNmtic3RUeC9XRmNpTm5wRXlQd2NWTkVK?=
 =?utf-8?B?VW1TSFg2K1VHNWNBN3FoSjBPL3JCWkVkejFtYUpsbjE2TGVCS2l5UCtCS0VF?=
 =?utf-8?B?SllYYitIb2N0WHRBaUNEbHVoRnhYT2hyTGxjYVBKNE9LWFVCNWlSejk4QWli?=
 =?utf-8?B?UXdQUUIzRDNqZkt2U3lHOExmdFRQVTBrSEJjN0QzaVJVOFcrcHFlY3hPMnBS?=
 =?utf-8?B?d0FpVElLaVA3Qjd6cmlrV3VaS216N1ZYREhHT0xmblZMbDI4KzdZUkgyZHRL?=
 =?utf-8?Q?+VZoxRbb6fY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDVoQ3BpdHFOZE0wbXI1YVhBQ1IyTmJ3UWpZOUdVa1lBaWFVaEFNUVQza2Rq?=
 =?utf-8?B?M1lyNklRRzJSS3dzTzQyVnMvYU4xd1h0bzF4bGFpWmRxQzJTMGVQKzMzUVQ0?=
 =?utf-8?B?NGFrR1IwT0l5Q1p2dEZDNUZLSm1RekpzVEQvUkRJOGhlY3FDaUtOWXlUdWc3?=
 =?utf-8?B?dXVabDBTMHFROU1HTWVSTjV4Wm1LdFBhMjJTMnM2aHFkUEJvenNCQ1FLblZZ?=
 =?utf-8?B?TDRuWmxTME1xc3ViOEpWSWtJUzIxYkprNkh1Z3g5dG9zUUN0UitiUnZjT0Jo?=
 =?utf-8?B?YkZyZ3JzeE1icFZnVU9iTGJTOXdtNmtNeC9vM243ZnZhdjMyM05Fei92SS9q?=
 =?utf-8?B?SGg1eDBnODBaZG1nb1VpenRNOGlkSEh2UXdrN2o0dHJadUlaRjVaSTJTeEZG?=
 =?utf-8?B?NFBQaUdYb25uWThuUlltWWpTd1Fud2s5UVdySDZKMk03dGdUSVZLL3JNeVhU?=
 =?utf-8?B?QjNQMlR4VEsyOXkyNmJFaUdPT1BGMW56ODZLbDZwZXFpQTQ5NU5PQXdzSlB3?=
 =?utf-8?B?S2htbmN2aEh1cERBR2pqVHRZOE1jSXY0L0R0dFZieVJiK1g2Q3RGSk54SDlk?=
 =?utf-8?B?QS94OGdJMlpFOTljMEVjazREOGw2aEFQU0FxMks4MFRyMGNzQXF4SkZmS0xp?=
 =?utf-8?B?UTh0N0JvakdCZlBCaTNXcXdab21yUW0zRmd6WDRSOGlRTWUrTXN2L3R0Zmkx?=
 =?utf-8?B?UHE1U2RPdHIxamkrZko4YnVyYnl4WGhrV0psc3VVcTBPcjQxYk1UZ1RFOTBu?=
 =?utf-8?B?cDhVcFVzS0ZHRTNRRUxaUE0zd3M4ZEhPdG9JSk1sNUc0RU9KNEFFeUlIS2Nz?=
 =?utf-8?B?TkJOdEZUazZWemNaMkJwemRFdWhubXptWHVtcmdvQjJ4d2FZNGM1TFNJdzI3?=
 =?utf-8?B?cVlpN0Z3VXphUEtKdnNVS2x2Y3ZkelljTTF6MW1HS0JTMjRydkJaaUZMSk5Y?=
 =?utf-8?B?YVF0R3lZTWhZeE5iaHhCSFAwOS91QUNrTGN3eVU5dWtUeWJZdHBGMGsreU5z?=
 =?utf-8?B?RGdHaDVtWVE1RU42eDl2eTVGcElvS0N5YjV4QmY5SnJtTjlHVGF0VTVXN25Y?=
 =?utf-8?B?REF4ZHVmV2hrczlJZU5EVWRVbnlvUUd2M2pFNmNtcmNrSUtJL1BkVHpMdVA2?=
 =?utf-8?B?VTFyRDk5czRLOFppKzE1ekQ4cGMzMmZiU0VhdUJ1N1MrbEVCcjI2c3R6SytK?=
 =?utf-8?B?OTNscEtNTWxmTmF3ZnNtNU9EeDlSMEFHa1VZblVpSFZpTkZjb2tZczBtZW1r?=
 =?utf-8?B?UzlFMXU0cWs5dTk2Mk5PVjY4TXlNaG1wQkVSaXBQQm0vUjFSR2c0UWEwMDhh?=
 =?utf-8?B?dE1vZXlVTDFaVUpZeGxGS21wVXdUQ09ZRFRKYUtlYXZTZDUzNG9zemQ4eDQ0?=
 =?utf-8?B?d1JhUjZxYnhnRTFacmtPcG9FQ1VPK1ROWDZCZFVZTE5Lbi9ZMjZJN1U0NTdz?=
 =?utf-8?B?TDN3cDlEZ2ZjUjB1cEdKVm1STk04eWFIN0xkd1MzeUkzQkZ1RXZ5SVZOb2V3?=
 =?utf-8?B?V3BpTXNZNXJpZGZDOGJ5ZmpWMUhjZWF4TGRWM3VGUWxZOW1xSGFjakZZL0VP?=
 =?utf-8?B?SVQwaTRDOGluMG5ZY1FtNmloazlIYzFFSXVCQVlWa1ZXc0RwTUl2ZlhYVUZK?=
 =?utf-8?B?K0lJOEJlQmhqUEFvaXFZYTRVdTY4d0I5SmF1aDR0L3J5dE1uRmdwMHR1ODF1?=
 =?utf-8?B?bUxlaDgvTXdMdnA1VTkxQlQzZU8xMHY5aXFKQVdRL2xaSVBnN21YWm5qMXlB?=
 =?utf-8?B?b0dEbkdRbERNZUVDWTNETmUvYkFQaWJleTFTUmpjR3lpY0kxSHZjSVpmb0lS?=
 =?utf-8?B?NlZ6TTJpQ2tLMmJnRGcxaFVidDEvZlZpcTE4MDhEQzN3MTNjU3RCckJBSFpq?=
 =?utf-8?B?YVVIRU55ckZOaGV3WGZyNHl2VHZSTEFvSVRtYVd3SG5GQ2NqOWg2QSt3MHYr?=
 =?utf-8?B?cEpRc0lTaUNhYm1aTXlYWDBVTXVDOVJKeGRnR3ZIUDhLUWkwcDBwcUJCb3p0?=
 =?utf-8?B?VzhJb1BKazczQVV0Q3BSczAvc3hxL2ovSUVqc1NiNzR6WDFBemlGeXhsVmw1?=
 =?utf-8?B?T3lQWk55aHdpd2xsMmJjYVh6dlNxd2tZcGpUNm4yZ0s0Q21VMnNCaHFpdkww?=
 =?utf-8?Q?qbhvRKkFSB4o6Bnfp49s+XUg3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a3b37a-44fa-4bf9-f03b-08dd7ba767a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 22:55:08.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmTkicdXz8M80JtACQXAKkC4szF/iP5UvwV09eHZQpcXWPzBmpsVsZsUbowElMDtyi/nnWZN4EtPWxmltSrtfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332

On 4/14/2025 3:18 PM, Andrew Lunn wrote:
> 
>>>> +static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
>>>> +                                        const struct ethtool_module_eeprom *page_data,
>>>> +                                        struct netlink_ext_ack *extack)
> 
>>>> +     switch (page_data->page) {
>>>> +     case 0:
>>>> +             src = &idev->port_info->status.xcvr.sprom[page_data->offset];
>>>> +             break;
>>>> +     case 1:
>>>> +             src = &idev->port_info->sprom_page1[page_data->offset - 128];
>>>> +             break;
>>>> +     case 2:
>>>> +             src = &idev->port_info->sprom_page2[page_data->offset - 128];
>>>> +             break;
>>>> +     default:
>>>> +             return -EINVAL;
>>>
>>> It is a valid page, your firmware just does not support it. EOPNOSUPP.
>>
>> I can see the argument for this, but EINVAL seems to me to match the
>> out-of-bounds case from ionic_get_module_eprom(), as well as what other
>> drivers are reporting for an unsupported address.  It seems to me that
>> passing EOPNOSUPP back to the user is telling them that they can't get
>> eeprom data at all, not that they asked for the wrong page.
> 
> I would disagree with at. Look at the ethtool usage:
> 
> ethtool -m|--dump-module-eeprom|--module-info devname [raw on|off]
>            [hex on|off] [offset N] [length N] [page N] [bank N] [i2c N]
> 
> You can ask for any page. The only validation that can be done is,
> does the page number fit within the page selection register. And that
> is a u8. So any value < 256 is valid for page.  Some pages are
> currently defined, some pages are reserved, and pages 128-255 are for
> vendor specific functions.
> 
> The limitation here is your firmware, you don't support what the
> specification allows. So EOPNOTSUPP for a page you don't supports
> would give an indication of this.
> 
> ethtool's pretty print should handle -EOPNOTSUPP. It knows some netdev
> have limits, and don't give full access to the module data. I would
> not be too surprised to find ethtool actually interprets EINVAL for a
> valid page to be fatal, but i've not checked. EOPNOTSUPP should just
> stop it pretty printing that section of the module.
> 
>          Andrew

I still think that EINVAL is the right answer because we are complaining 
about an argument value, not an operation, but sure, EOPNOTSUPP is fine. 
  I'll update the patchset in a day or two.

sln


