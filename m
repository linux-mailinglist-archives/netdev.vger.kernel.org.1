Return-Path: <netdev+bounces-207012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9FB05341
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D48A17FC4B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1EEC2;
	Tue, 15 Jul 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTteNufc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80F18CC13
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564642; cv=fail; b=PTTYv374K8+CJyFNDJetZujRcXljDVcOMC5XMDwdFL9GVESW3wlr2XFtI8urN3gan/b1ZjOQtMG58ibc+DqyepOCGVD7Rc9B0xdia5w+K1pZULePy3jki4gze/FyVb4YxCLk1bAX+VLV92fcjtL+Ds/kR8lDj9CpEbcM/D4p4mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564642; c=relaxed/simple;
	bh=Q1CphYm7RNYSWp7m47u8X5xTk711WwrN/axHLRjq76I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzELjJ0WmbBvi7yaptTyBJ/IDxevOE7+bSM01NGS82pMCf4U3f04XGBiQ6wKBG7daCINonJJ7K7AbppS8tMsQjAxlb6E3kghrRuSxKEORkxi5tqZnFeRySToSvt1pLOVHJdyOmrIJ0xGV3gw1VqgTv5i7/XRoQrN55pxPJe7G+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTteNufc; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LckfqZkuecY/o4O71BVVAOj0iBKMxWbQZWR7V8bgoFSglCivxjuYYhbK0L9RXOKnRd5RRl+oItvHwdsSKoxXseHtXW5LtbYapOjQaRYoi0GBuVsrqV7XDbU/X0OpSwL8X/ZyI0kBCoKo6N0JDMxjFq8PTR85loucZhP/j5E5W0PbL8WmZgMPNC2xgrkG90OM5G0RDXIQ7IhAvAVbzQvF/bVqFuBgyOhiTfif2yZA8rNhD791Slgoycp/Q7polaEdLh/1PgOe2X2mev7lLT0KjjPxe19CWiv36lPfTKvvuD93Azs+bFpX9+rbO00p5GYz+dJho/gAPCHMNaI6X2r6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50fybneKZ1Deu1XeruYNbFqFMx6Akx+YCWKuzS3FCHM=;
 b=RwW02zgNtHZI5LVyXV04bd8mJAQW1bmGG2rfxId8GwkqVdOMeSNrMDwD75xgrm6XQ5okotycfJRrDWQj195qeYG+b5iiRqjke8IbGc8lSa9fHD0w3822wSTuLkftcCEZmhFVQA9RuzLlVxWm35Mvo1meF0n6cC9+vqBqpUxl9+eGmojM+VXdORd69QyN0a0Gzu5fPKyNNZvNW4d6ZjwA75sfH7yNpkMo1k/OYKsAxI7M2cLbciQ0Jxj1yNX1mTiU+fs9IqPWswU3Rc3aAmYuV5HfluTnO3nXBpioMf0R8wFNioHn5KBPWGh41Z4Ht3PY5fMXKPcfY1GsJULYlI/kQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50fybneKZ1Deu1XeruYNbFqFMx6Akx+YCWKuzS3FCHM=;
 b=MTteNufcpVhu66NJmll34jljM376I7W+9dv2yNQ2VBEGr22v5QSYLz85QewVSz1jyJz3JgUbl7KLMs6/IXYuLCZqYGXnXehayb+0fn2a0+PvSU6a6Yjr00nVm96XPC5liQ6nV9OFWM6u8x6ev+NQp7HU1pLvsc+zH2D2AWZ8kk8ecLHyo/RTijQ5ghmvpaQM3JMWqjacoSRyLuETE7OmOTu3ConbgGtbeA14ZBNCnARtbTIPZqmpmLowSkSACJJAo3fTj7lwFLMcIawtYAJQdS5XYJlHPzMged/z9k/JvnDDkRtT0fWwvT12Z0x58N/Y7V6LD4jD3EMUE7SPdfRKTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 07:30:37 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 07:30:37 +0000
Message-ID: <b12ccd7f-dc4b-42c8-822c-7646885fb2aa@nvidia.com>
Date: Tue, 15 Jul 2025 10:30:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/11] ethtool: rss: support setting hkey via
 Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250714222729.743282-1-kuba@kernel.org>
 <20250714222729.743282-7-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714222729.743282-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ac4d76-400d-49cd-4251-08ddc3717df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3V6S1plT0ltWHB6U3BBRkF1MHYxaEVPSjExN0ZldEZmTHBwR1hKOS9mNnps?=
 =?utf-8?B?ZU82UlphYXBwc3VYa3dlRTM4Y1BhSXFweWZKQzhkZVVaOTJEQzRhcTRWRU5H?=
 =?utf-8?B?Tm1XUi9NVTdVdWdtY2JSckFDbFdtWWxNaW1OVFQvdkI0Nk51MVpCcVFqTWpL?=
 =?utf-8?B?SW9nZGxOUkw4RUhKRTBIaW5MZ0hHcmZoY29lMFNIQlZncS80UElCdFI2VDI2?=
 =?utf-8?B?Nmk4UGpvR2IxMHB2NUdDVnk5TmZNNW9wcEdzaGhkUUNGZmJlUUFWNEl6VHBC?=
 =?utf-8?B?OEVDVGtGTEUvS09MKy9VUDdTbHppblZONEpBRkNpUFIyRUhPOStBZUtRV1Jn?=
 =?utf-8?B?K3pha0g2RFNmT0lQSVlOclhPWkovaXJMM1YyOW14aFh5ZkFKcUJCK2EySjhH?=
 =?utf-8?B?d1kzK2M2VFl1SkNtMFh1RlRvZitIcERZQTBLeGEvMGt2Skp2YUhrZEE1Nkcz?=
 =?utf-8?B?bCtZajMvUUVwd3cwTDRUd2R5ZGREOWVRSXNHWnpERUxYYVR4N3c2UkZUeW5J?=
 =?utf-8?B?T3AyYkgyTHl3R09UM08renZGZUtoOFJFeUtvV3dQRXVEV09NT1VyV0l3OVBn?=
 =?utf-8?B?U3JSSzNsQXp4NEpPcllyMUlxSVA2Q0hQV1crbkhwM1o0eE5hem4yMlIxT3l3?=
 =?utf-8?B?ZnJSNVFFZThlbEV1d1lzRE1yQU5FZlB6VGg2Vm10ZnZ4M1N5MHJkVzB0YWdu?=
 =?utf-8?B?cmdKZG02cFFiMEZaODdDMTJsS09jMlNtRzJHMFlIZkl2VHRwT3JIK3lXZTFJ?=
 =?utf-8?B?aHFpOGxkbmtXRXFZSFJSZlRmV0FtbzN0SFVNanNaLzRPRnY2U1l0aStyQmJ0?=
 =?utf-8?B?M0xRbnRnNDhNcXpveHlDL3AzQUxSRVpUak5hTGtuMlZjNTFhaTR6S04ydjRO?=
 =?utf-8?B?dHQzYkZNNUk1bnJtWmR3ckMxem16YVVCS2hFWVozb0dSMWtYUDFSTzMxaFdh?=
 =?utf-8?B?ZFFQSGRyeEQrb2hKQWpiTFFHTUZhNHQ1KzVrc2lCRE94bkdNTjBIODNHcVp2?=
 =?utf-8?B?SDVCMTJ3dGVBYm5uWHRvcitvZG56MTFtOEh0aTVCYlRScE9ybDE0bGhGajFS?=
 =?utf-8?B?bjhkSmgrUzNDT0NtVDQ0bGdQMnZqQ2RjMmhFcmYyZHkrTlZRcUlkWXFIREpn?=
 =?utf-8?B?enhMai9VQ2kyNlRJbGNpQUJPaFArYzhKMDVoVUxEYTRCSWpVK1hnaDBES0hS?=
 =?utf-8?B?bU80M016WTRBY01tT0JDSGN5cVdVUUEyWjlEQTNMcGZzZEZMNzlVNnBxQkdI?=
 =?utf-8?B?dnlMb3VLd2FDVHQ3dGJienBrMTJjOXNYbjc2WGtPaDNIdy9hRTltOTd6ZjMz?=
 =?utf-8?B?a3VDak9QVHEzQVRudnZxa0Z1bnBnY0JjcXhhOHpPdU85RFdPWDJrekVjS0kz?=
 =?utf-8?B?cVFuUEhxS3pOZE9tMWdvZlp5QjU3UkQzYVllU3JCQVNxMzAwZWJVRGFGQzZx?=
 =?utf-8?B?QWc2eTVRTXphelI1Yk9OVlB3ek5Ud0JPRmo5cFRmN3ExckVrMWFycFFrU0dS?=
 =?utf-8?B?Y2ZvZTE3WnNseWhBeU50UWVWUEpES1E5Rzd4OFhxSksrenNKWVFhc3R1dG01?=
 =?utf-8?B?WFhDY2FEN2k1LzZQeU1EbWhRbVJmand3a2p1S2RUVGUrZzJHYUgxbENRRnZ1?=
 =?utf-8?B?U3pqQmFMNUFzS2d2UkJ5RllaZ2U4Yll6WXBFaVZLU3dodVBWajNGTGFVaDJP?=
 =?utf-8?B?emxSNTVwRHFNWEtGSUZJclRCZU5hOTZ2VUh6WS9WN2JuUVJuU0U4Mm1HdHgr?=
 =?utf-8?B?S1hhanNXbi9FajBQYXU5VHZhdGx2MDRDelhEQnErN2pCRFF5TUJzdk42bWVR?=
 =?utf-8?B?anZUZUZ2LytBNXd0TTI3V29iTzVoVm52bUhrdVhzTjZNUFFQRmdaTkJ4dXVp?=
 =?utf-8?B?cE9lZG1uam5vMTcyNWQ2UmZacldHOGJ2V3JXOTRVWW9STHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnhZOERzbHlYQSt1QUczMHZYZlRUMnZ5S1djSUdGSEVJWnlkd0c1N1lWU1Ru?=
 =?utf-8?B?YjBraGV1NklQK1hiZ2hsMVJvUXYzMVZyU1NWYXJ5d1RBK2hkVW5ESlRjVk4y?=
 =?utf-8?B?RXJGdkRtWk9COGFMUGRldWFkcDMwS2lKS0R6Rk1HWGYwVG1pSXUwSjRmSlNX?=
 =?utf-8?B?dUkxZGMzQ1VMbG1TVjRSbTNTaUZUMHQvNEtFQTZ0ejNEM3ZOY1VPOVEzQm85?=
 =?utf-8?B?c0Z1WStmRFQ2Mkx2N0xhZk9OTkcwZTFsOXR4ODhwV2tuOW9YWXhyNDdYandm?=
 =?utf-8?B?NFZ0akd2T3J3RW02QmlXQXR3OEZoZnU2QTdMazNaeTB4S25rMUtMYTZBM1dz?=
 =?utf-8?B?bDZBbi8zMXd2c2lheFo0R01scDJhMWw1MHRFUlRqZzJLb2FXSTFCUjc3NXB6?=
 =?utf-8?B?RUxnMjFuNXFrL2tHb3RQbXQvVSs3Nk0wTDFzOFZidGkzdDVBQy9EMFhrNHdX?=
 =?utf-8?B?ZUxXRnZDMlRDQWVOcmhqY1d2ckM2SWt6ckRJVGszUGE0VlA4TmNoUnZnVm1v?=
 =?utf-8?B?ZExxOU5vR2F4cWh3Ym90QVNxendMNjVucEErdXg2WjlhWkcva0FqQ3ZkekNF?=
 =?utf-8?B?ekk0aDNFNnV1OU5Qb0ZPZEQ4Y0RZcGxrcXBKaVRFYkt2ekM1akxoaTd0L0JQ?=
 =?utf-8?B?Q0dHb3JzcGQ3Q0JBUjE1QmlmaW5hbDhqM2ZyUzhmbTFoWitGejFON1lZYjUz?=
 =?utf-8?B?b05yTjdpM0FjVVZaODJKV3RpTE1hazZna0xEb01Ka0t5Y0JxVGZubmJsY1ZI?=
 =?utf-8?B?ZTVRRlZDb3g0MmFKejE2bS9Qa294b3R0ZFM0RW5STVBpZlpVbHliV0FoVU5D?=
 =?utf-8?B?a0Z3WHFoRmNFMk9yTkJnNTcvRnRpM28xUXFqQnJJbzRFaFJUdENPMFlmcUFI?=
 =?utf-8?B?UWJpTm9HcDUyTzQ3RHZxcnl2WCtjaHdWWnhoMmtRRm45eDR4ZVhpTE5wSVFL?=
 =?utf-8?B?QWJPeThiZHo4TlF3UUxQOHJyNzRjQzRxUGNFUWdiU3hLSkxNdlJmcGFlRndS?=
 =?utf-8?B?azlCZGNMRmtDNDR4QUREdEt4enNjbU1zQWtqY2tFNXdVN2krK3VsYklxRUNJ?=
 =?utf-8?B?a2V2ZUwrNmo2YWwvQ1d2dFpCQWxNMTVya0NWUnJGTmM2cW1VVGgzSE5RbFlY?=
 =?utf-8?B?MnRKeDViVit1VXlJVEZEY01NMXhoVlZVMEhYM3l6NUtLQkF0c2UyNU40ZStG?=
 =?utf-8?B?SnRXQys0MXRvSExHOG5oSlplUXowN2RRNUhEaTFLNFgxS0hiZklOOEhseXBr?=
 =?utf-8?B?UXg5V21MUW1FMmNqM1lZdXhJUHkyZzhGMUgzY0hYWktxV2U3YUtPNDlNRzNV?=
 =?utf-8?B?L0VHbGFuczBDc1dxU2JlcXRraEZKZUl3STlZQjVqa0tBemVxWDNnWnlUMUlD?=
 =?utf-8?B?R3A3bEtsOUxiU3pLS3M5SFVCVnFEOUVXaXdZRzNtK0xJblpSU2V2cHg5S2lM?=
 =?utf-8?B?eGRoYXdGVmo0YWNxRm1TeW5aWmdKZjFuNGVGamFqQVRPNVZ6QkFSQ241VzY2?=
 =?utf-8?B?ZDQ0aVlTY0RLa3BBakZUM1JqUkxCL3V5Z053SG5WRXBHWFQvME9LMTBFd21j?=
 =?utf-8?B?SGJwNW9nUlRVUm1QVlNaaEMyTW9Bai83cURpUEtlTzkwVlhIaXQza1FjVURV?=
 =?utf-8?B?RXY2WEFHZzJ3S093TDM0bEs3ODZRNDBwTzgwdndqaUZjWGtuc2FmNmhVdUpm?=
 =?utf-8?B?YUFhK2krcjVzOEVjOXpUS3lMTlZVcHpweXNrR1JzQnQyOU52Yy8xdVJRcTA1?=
 =?utf-8?B?UDJvMG0wbE1IdGFwMURSd1ZmSVh1Z200MVkvUVZka1VRNHJNZW93QmxUN3dx?=
 =?utf-8?B?aXFmT0NwU2xGeGFJcnFFc20vRml0UUlhRFQvYUQ0WHNDQTRoY0lwU3Y4REpl?=
 =?utf-8?B?LzBkaFlycGdtcElVWEYyZVNia1pjZVA4N1lOSU1nOTFzS1lPcFFiY1RHZTJR?=
 =?utf-8?B?TXFaak42NWM2L0liSk9kcElRdG1tT04rRUMwS0lqSUJiYTBObGUxWG5aM3hL?=
 =?utf-8?B?RmIvTmJka2tIVlg5N2ptSGtvanBjZ3RKVW1lV3VTN0JONFJINjhQbVJma1NH?=
 =?utf-8?B?cm96VHRlYUY2bmlOQ0N5RGtsNFVaeDVNcHEvelJsZmVyQXBnTDdZQnc0R1kz?=
 =?utf-8?Q?Q/gCvyMnhtYvpNULjDAiFLiZR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ac4d76-400d-49cd-4251-08ddc3717df8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:30:37.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD2qs8j56XyHNeDF+qMz2HCevFTrN5ICBxw/30cqxQKEcyldIelZHxedwgxYRQUQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320

On 15/07/2025 1:27, Jakub Kicinski wrote:
> Support setting RSS hashing key via ethtool Netlink.
> Use the Netlink policy to make sure user doesn't pass
> an empty key, "resetting" the key is not a thing.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

