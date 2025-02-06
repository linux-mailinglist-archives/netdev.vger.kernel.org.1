Return-Path: <netdev+bounces-163471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D0A2A578
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F7F3A1484
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660022331F;
	Thu,  6 Feb 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vw9ADy7b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C232226196
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836208; cv=fail; b=WJfSh4SLpVn8+2tgHVkj1EADUHYCk63jPcgyJTK7ZLrNvz6+gMJgdvCQKMu0qnZp/+1YfsrGmj4hmovOVHNgJAmVXsR8LQdH/HYwj1rTdQ74GmjCePEBi/mAikUfiFXgD3lUUx0S/nvab6P7o9FETomOJKccVhNg7+0ul2U9mUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836208; c=relaxed/simple;
	bh=RGrW0YlPsM50jmIcSS8RULOMNV+etFbvNiFTkAYpxBI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LzEeY5xkP2A/QuOW+BBhHlO8DuxaQi4L6x5+y6rYnNK5v4y0JroaeF7P2h244oweR67iNz8/EqEGdsXXe6JPp+dwHGYMtxHJ6lt1XjMuU2MavR0wAAue7oOay9YioL6DkfG5Q1TzxPFZVN2aksCcDnsmEcbh2IBnbMEXcGUWtmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vw9ADy7b; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN62BbKUyYHlDQpDmKU7CbXGMS16VqtVJ/mwf8eA/ghtPDw2LXwt3QYVRCXeAbuh01l0pKqKiNN/4CdFSssLlO8wK1u8gPY8rgm0vYbaYAHSUDhHKJ9U0+gAKjvvko8hpL+prrlb0wgNm3u529Qn3jK8OOXEsq32kBeSJ9C+MyxB+97QSPV3xlhVFqEfJI9lnG6I/LVkAcQdCh7KH9c2C5yLMJFbdMWMbYFhbQPqzT2bwlBP85Wr1qan+j0NcS2jtiz+EPpqUKrP/iTb6W+fSErZIa7EzjhWbqL7ia/7H51zGgHloHuagp59zSBIBcaXR/XhFUjeO28ZjG/fqscsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGrW0YlPsM50jmIcSS8RULOMNV+etFbvNiFTkAYpxBI=;
 b=slZkneS0PrQ2W03R4HEx+Ddq72RtKnPVFh8nvKKZOC2ZgAWSf3FXbmGUYXAmKjNuNTaJrK9IV3ackCbuQ/GafhvonRCF8ypLpyPkHFk6Jg6RIy+FBk43gMoK28Dkq3HVzZvUqfw8UC/t+XvWIhBBKNXFFmaVxQIiLhsFLUyMBYenBzoOWUTZOlRGUiDB28J+BoBS5yHeZnCT+az/nNUISUZMgJ/FRbu55j4ZaKXyupM//wrh2/MlL5IQ8GhPD7eNDdxdKMOlhF5mNqwCPeOnci71JdYI+4QdRopVCA5Q+x3F0rBe9cu2JLu61l/9KuuBwWuDPcIY27dyLdQrlhMTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGrW0YlPsM50jmIcSS8RULOMNV+etFbvNiFTkAYpxBI=;
 b=Vw9ADy7baI7s3a19GwObAK9R++Ac6KnHvyhgQwgRyyc8ejO4da6uUWLw/BwFrgnP/ee8oGx6MQqkfENPvfP65KWZOH83ei6Mf2TFs1OFknWdon4Gm1wGL4o2e+yh5teP/m+M+DGyvzJGca9K+abnqoElTh2941Kof/FJN+MU7d35JYxC1sctq2Vs90wS+53M1V4XdkAbAv+v2A2SuTDailfjqF7yxjNIzibKEeUCujOTwOwosIxjPO+ONRF4JVx+cuXKoKQ24F9IWPzTnDRsDdL180SL+h/VKT4D9f3cLxrzKdmieeyRtkPzqYVFM8IAtsTtVQcjav6pv8CLfBYevw==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 6 Feb 2025 10:03:22 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 10:03:22 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: net-shapers and traffic classes (an update)
Thread-Topic: net-shapers and traffic classes (an update)
Thread-Index: AQHbeH5bB/mDMo/Z20Sam4HHQ4o2kQ==
Date: Thu, 6 Feb 2025 10:03:22 +0000
Message-ID: <67df1a562614b553dcab043f347a0d7c5393ff83.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CY8PR12MB7729:EE_
x-ms-office365-filtering-correlation-id: 9b756ff6-8fc5-464f-c473-08dd46957da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnJSYTBWL3R4MnZqZUpWWHlPU2g0Z3hUMStocTFxWGI0STZNcVlWeFRvOXkv?=
 =?utf-8?B?eUdTZ1g5dXFvaGV2enIyaXJZMU5mOXg1T2xobEVyV3hmVGJQNlNrT1BpZHIy?=
 =?utf-8?B?Qk9hdG51RGVRZWlvZmJKVEMvWVVPRzVjVDB4T0lMeVRmcUJtYmxQcG1FTkRD?=
 =?utf-8?B?VlhQM01PQlkrUjRLelRKMDhjOFh0ck0rNjNqLzI2SzEyUVg2TDhMM0tvZXN3?=
 =?utf-8?B?WXBVc2lscklqYnlpQXRjVmJRZkxzZ1J5QmJJY0lReTlqSy96R1VEaTJUYjVO?=
 =?utf-8?B?ckhZc0xHQ3NkOXdGUTRLT0NlQVVJeDM1VTdpS1NFaU1yVFZ4SitMK1FEZXVO?=
 =?utf-8?B?Smg1QkNONlRsL2tnakF6ZmJHOG1sUURRMzVUNFYxQkFmMVQ3ZUxPYUhyY1R0?=
 =?utf-8?B?eEZvbGF1cUNENm1RSXlwbzlNUWE1N21xalkrWnBQVUNJRU1jWkFiQ29GUGFk?=
 =?utf-8?B?dkpBNllucExya05YanhWVXZESVE1QXEzTzhBcXFOaDBOZlJ3NS9nRGF0M2tM?=
 =?utf-8?B?RVBsdWZtMWNPZFlKZE5FYVA4VXcvN3lOM3lKejBjNjlPUDI3Rmk3ZVhGMFJD?=
 =?utf-8?B?bkdEVnN6SDFRL3FrRjdGVW1Zd1N2WTdNakNSS1FDbVBuSER2TU5ReldhWnpW?=
 =?utf-8?B?VDFTVTlvR1lMUWtFWnBmZlYyVUo2YXpqRWRuNXB0M2FpMDdWNjNFamgyenZR?=
 =?utf-8?B?SDlYb2dqK1hZOWJ4d0MxWTJQM3VjZ1RHS2xaRXdTbEtsL2xXZEFXVTZYL0gz?=
 =?utf-8?B?MHBETm15UXN1bGl1T2ViVXpXekU2Q3NKYkFZUjhFODhCVUhGbHZhRmR1ZWw1?=
 =?utf-8?B?L1VtQnNiR2NmSHhGZ3N4VXY1WHRreHRqbENwNTNyTy9NcTJVVVpPMkZrOEUx?=
 =?utf-8?B?d3RwaFI2ZWc4dTNZNW5Bbi9zNlpGa1B5SHhwT3FmTkdnakhBU0VySngrS05v?=
 =?utf-8?B?VVlkcDVUKzdCTlMzbUNSZE9La01va1FDL1JObE5GYTdqZUJqeDJNbmdBYUlQ?=
 =?utf-8?B?U1RWYis3aFBrWmNVSlg3VWRRdU9jTlJFdHhvanp1eW9kUTFmaEgyU0VlTExO?=
 =?utf-8?B?UXh1TUZuMEhEZ1JUbVUxV2tzOUNNVFZlUE01MXZGSGRDNEhtQ01ocW1xSzVL?=
 =?utf-8?B?d2g1QlR4VzVkWklqTVN5T04zVHh2S1FIT2VJamhxOVBRRmhxOFFENjB2VFVY?=
 =?utf-8?B?S2NPcTY0SnFrR2VvUDViSjlpb3JDMERzVG1nL3M2UGdORlhwQkhXRzJqaDRX?=
 =?utf-8?B?VlFEOGtIMzkyNlpWd290VHdxeTFkeC85RU54KzFKOXJaN053VXNFZkljTytK?=
 =?utf-8?B?bzlYVSsrcmtaV1FQN21BTDE0djJ3bUJ2SmhuTjk1VHM3aUd3eDhyd25BRXRp?=
 =?utf-8?B?ajZGN1FURVlCczVKeWRib21nNldPZTNqQlBqUmMxeGhhV2ZMWTB3Y0lvUit0?=
 =?utf-8?B?UXkxSlFVVEg2RDMxbXhqWnJia2lWRGREWlNSSnVxaUY2U1lVbktOOEtSKyt1?=
 =?utf-8?B?MC9xQm5YK3FJRUkrVEk4Sm96cGZWNnoxVlpSTy9wTFJoZ1FRNm5FMnFjUDgy?=
 =?utf-8?B?SEZYNVNRRVpZZXpaVGFKeXFkNEQzQ0gzQTllQzRIVUQvMW14bDEyb2xRQS9M?=
 =?utf-8?B?YU9OTitLaERidlJxT2JCT2l4WDRoUWVxbFNBU1BESkM4bmRHeHBvNkh5Y0xQ?=
 =?utf-8?B?cVNscmUxR015akVNZUJoYXVDQlRTMnRDSHRMZHZlTmhCQUpxSThxMENjY0FB?=
 =?utf-8?B?ZktGZk9kVktNU3FHUHFndVZmSlJPZzhLNnJaV1VKU0x6cTZrQUFIelJCc0dk?=
 =?utf-8?B?ajRDL0lHL2ExZWR6Z0s4emFOTDA1NWVBVFRvb3AwRWg0eW82UERFQTUyR1ZP?=
 =?utf-8?B?cVNnRWhnbTJjajlrZE0xNnpyWW9yQkMrMWFkQ1Z1NmVWZkRnaDhEcXRDaXQ5?=
 =?utf-8?Q?OvgO0LfNQCYdkYXxOxyr/mo45sLRTfa4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGRvbVc3ZFF6SEFDeGR1RXltN0FyVjUxMGthM1NVMWE1a3BWcEF0MTZYU1FR?=
 =?utf-8?B?OVQ5dGZIeGJLMGJCNXgxM3pzNGwyQ2czdVhIWmZjUmxzL0d0YmtIL0xCYm9B?=
 =?utf-8?B?RlBXL3VXZGpYYmNxQkZEMnlMVDMyVm1kRWhtRjdGaWNIYjFtOHBVQWlJeERs?=
 =?utf-8?B?M3YySm5mMzlQQjl2UnZIZldiNllOb0syNi9XVFFtT3Z1QUVubUNkeGQwSWFp?=
 =?utf-8?B?WWNzbWdFbDRETCtyY3NxUHM2TjZyVnQzZld2a3RVd3haa2txdmY4MUhsdXZD?=
 =?utf-8?B?dEtGWFU5b0Ixd09Md1JyTDNMZUF4ZTNodE9Lb01TTkwrcXcvRDl1MDlPRVB2?=
 =?utf-8?B?cTRWSFVYOE5pTi9ldU52SjdyQ3RwU0hWYnpMMGNWNGY4VWtmNm5GVTlDMGlX?=
 =?utf-8?B?OGRZNU1TL1VWWDZma2FkalFQb3NranVDTWpNVkNQdlluSVlSTStJTFdGSmJY?=
 =?utf-8?B?NWl4TXdoWDBqVDkvL3Yvb2x1VFJGRU0zc1d1Y3J3SWhpUFlVYXNWVHhpbWN5?=
 =?utf-8?B?SkJGWGNHV05XeGxWUW1uYlg2azducS9VS2hPL2dIMUJMd1NTT3oxVnQwZno4?=
 =?utf-8?B?UDFBVUVPaWxGZDJRUVcrbjF4K3FpaVNQcnpZOGFtdjlpL1BXbExwWmhIc0Y5?=
 =?utf-8?B?OTVRN0tqd24wcDlFVXdkZXZsdUgwM080RVhQWExqaUhuVHh6RnhOSXZELzVP?=
 =?utf-8?B?Q0oweVNFMlJSb0p2T1JhejY4dFJodWN2OXhxVDNIVkR4N1FET1BZeXZ3Vm5y?=
 =?utf-8?B?RnFlbzU3OE9uUmt3aW81RGZCT2QyWlQzWVRzeGdBZER4U2Y2MVVDRFdRRHBD?=
 =?utf-8?B?dnFXbnQzd2tZUzkvZXY2WlMrbzdWZHN1YmZEK0JTclVnSStqZ29FQ3QrOC9a?=
 =?utf-8?B?Q3VFS0NpT0g0Vzh0eVNGL3dUMTQ1cmlMdkx2Vnhwa0hRQjZ3ZXJCT1hEYzYz?=
 =?utf-8?B?QmVCaTg0dWFrZmhTV0Jta2hFRXphMktEbXVmWUw3S0V1S2VuQnRYSUh1NHpK?=
 =?utf-8?B?TDFEMVRrTjFtanNFQm1JUUZIUnY4K2Z3MUF2dFdQMHpTNWt3OExrQXp5SU5O?=
 =?utf-8?B?Rm1DVkJvTXNZMkM4YkQ0ekJ5di9hcm01MXdETGZlNnBJTEtiNWMzZUlqZ1hm?=
 =?utf-8?B?KzlaQk9JR2t0UHVoZGVYOTZYdWtKMW9GK3lBZjhZZVZlME1qbWpaWlRlYU94?=
 =?utf-8?B?SnZ4L2NUektvM0xTYU5BOU1ubytHK3RyNjB1Vm9Vc2NsTW9hOGJZZkRZTDVZ?=
 =?utf-8?B?ZTFESXFKR2xsOXNZSzRLZW9iVXFUR0UrSDVMSFdLYlZVMmZ4WFNESG9UQWdq?=
 =?utf-8?B?bGJhSzZ0UFRyQ3dVc1RMZkZ3bTBSTEJleDhoalFYUS83MkMzSnRsekN2djRs?=
 =?utf-8?B?T29mUllqTE9QdmJ5UEQrS21IU1B2eDRvNTNURUs5WVhvVkh5NTl1cC9yV01H?=
 =?utf-8?B?ZW9nQU1uVGJkWlJreTgzNXY3YU02VUdZK05LN2U2SzlYZjc3V2liV2lBSHFp?=
 =?utf-8?B?Z2FpWW5oejB4ekl5OE04bDJkVUVjaHAzbjB6bXFsejUwVGNWb2luaUpYTmx4?=
 =?utf-8?B?VHFlVXZMSWQzVFBiNVZ3OFg5UDJhZld4LzdxQVpEZTJmNzFXaW4xU2hacGQw?=
 =?utf-8?B?dzdLam14QXFKTEFOaTR1VzVWSUFqOE5aTUx1dzRjZ1MvbThKTHdFMWNKeGFX?=
 =?utf-8?B?SGorbUZuMHlVbXlIUDl3WndoeXBHS1p4ZFR4T3BsL1ZWb21pQlNNaU9XZlhF?=
 =?utf-8?B?aUdwK0gvMU9yMlJ1UmdFaXFRSFk2K2tRUjUxa2tlUDNUaG14M3NXQzhnM3ZF?=
 =?utf-8?B?RmxtNWYvZVJ2OGZrNVlvVS9XZ3htVzBkSFQ5a3EyMXgycjNUclNuN0ZaWm0y?=
 =?utf-8?B?bFpiWUtlN0MwbkF4VVpNZy9hNVphWXpNdGhNR0s4Tmczamx1c2FEY3U4ejRn?=
 =?utf-8?B?bmVGK0RIRzlwQ3pVYmlrNStOM016Z0xWMDF0eStrZmlJYWU3UHFzeEhETG0w?=
 =?utf-8?B?c2E4eHhkU3ZwY0ROZkx5cExsYTdjU0lCOVc2QVk4YWx6bUhQcVp1S1dDV1Jt?=
 =?utf-8?B?OW1aR3JXaFlDMWgvelhza2svN2htYmNjZjIxeXRsckJvQ05RaEVYU0dwZk5t?=
 =?utf-8?Q?EAiDhK6sxaau87APsojRtfO+4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92C195436A39574997B08C650C2B8E5C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b756ff6-8fc5-464f-c473-08dd46957da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 10:03:22.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6p/6wvizGNd95aLRODg7Mbtyb5XpmNk2Ced8zHuY1OXiqxp30lian6Kde2apRQVJ6h57PFgBoQylVo7VDvGRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729

SGVsbG8sDQoNCkluIERlY2VtYmVyIHRoZXJlIHdhcyBzb21lIGRpc2N1c3Npb24gb24gYSBwYXRj
aCBzZXJpZXMgWzFdIHJlZ2FyZGluZw0Kc3VwcG9ydGluZyB0cmFmZmljIGNsYXNzZXMgaW4gbmV0
LXNoYXBlcnMsIHdoZXRoZXIgaXQncyBwb3NzaWJsZSBhbmQNCmhvdy4gU2luY2UgdGhlbiwgYSBm
ZXcgb2YgdXMgZnJvbSB0aGUgbWx4NSB0ZWFtIGhhdmUgYmVlbiBtZWV0aW5nIHdpdGgNClBhb2xv
IEFiZW5pIGFuZCBTaW1vbiBIb3JtYW4gdG8gdHJ5IHRvIGZpZ3VyZSB0aGluZ3Mgb3V0LCBhbmQg
SSB3YW50ZWQNCnRvIGdpdmUgYW4gb3ZlcnZpZXcgb2Ygd2hlcmUgdGhpbmdzIGFyZS4NCg0KbmV0
LXNoYXBlcnMgWzJdIGlzIGEgcmVjZW50bHkgaW50cm9kdWNlZCBBUEkgdG8gc2hhcGUgdHJhZmZp
YyBvbiBhDQpuZXRkZXZpY2Ugb3IgaXRzIHF1ZXVlcy4gIEl0IGhhcyBhIGhpZXJhcmNoeSBvZiBs
ZXZlbHMgaXQgY2FuIGNvbmZpZ3VyZQ0Kc2hhcGVycyBvbi4gT25lIGFzc3VtcHRpb24gaXMgdGhh
dCB0aGUgaGllcmFyY2h5IGlzIGEgdHJlZSBhbmQgbm90IGENCmdyYXBoLg0KDQpkZXZsaW5rIHJh
dGUgaGFzIGFuIEFQSSBmb3Igc2hhcGluZyB0cmFmZmljIGZvciBhIFZGIG9yIGEgZ3JvdXAgb2Yg
VkZzDQpbMl0uIFRoZSByZWNlbnQgcHJvcG9zYWwgWzFdIGV4dGVuZHMgaXQgd2l0aCBzdXBwb3J0
IGZvciB0cmFmZmljIGNsYXNzDQpzaGFwaW5nLCB3aXRoIGFuIGV4YW1wbGUgaW1wbGVtZW50YXRp
b24gZm9yIG1seDUuDQoNClRoZSBxdWVzdGlvbiBpcyB3aGV0aGVyIG5ldC1zaGFwZXJzIHNob3Vs
ZCBtb2RlbCB0cmFmZmljIGNsYXNzZXMgYW5kIGJlDQphYmxlIHRvIGFmZmVjdCB0aGVtLg0KDQpJ
biB0aGUgc2VyaWVzIG9mIG1lZXRpbmdzIHdlIGhhZCwgd2UgdHJpZWQgdG8gdW5kZXJzdGFuZCBo
b3cgbWx4NSBpcw0KY29uZmlndXJlZCB0byBkbyB0cmFmZmljIHNoYXBpbmcgYW5kIGhvdyB0aGF0
IGNhbiBiZSBleHRyYXBvbGF0ZWQgaW50bw0KYSBnZW5lcmljIHdheSB0byBkbyBpdCBpbiBuZXQt
c2hhcGVycyB0aGF0IGNvdWxkIGFwcGx5IHRvIG90aGVyDQpkcml2ZXJzLg0KDQpTbyBmYXIsIHdl
IGtub3cgdGhhdCB0aGVyZSBpcyBhIDE6MSBtYXBwaW5nIGJldHdlZW4gdHhxcyBhbmQgdGhlDQp0
cmFmZmljIGNsYXNzIHRoZXkgc2VydmljZS4gVGhlcmUgYXJlIGEgdmFyaWV0eSBvZiBtZWNoYW5p
c21zIHRvDQpjb25maWd1cmU6DQoxLiBUaGUgVEMgZm9yIGEgcXVldWU6IG1xcHJpbywgSFRCLCBp
bmZpbmliYW5kIHVzZXIgcXVldWUgcGFpcnMsIGV0Yy4NCjIuIHF1ZXVlIG1hcHBpbmcgZm9yIGFu
IHNrYiBpbiBuZG9fc2VsZWN0X3F1ZXVlOiBWTEFOIHRhZ3MsIERDQlggKyBJUA0KVE9TLCBza2Ig
cHJpby4NCkJ1dCBpbiB0aGUgZW5kLCB0aGUgc2tiIGlzIGFzc2lnbmVkIGEgcXVldWUgYW5kIHRo
ZXJlZm9yZSBhIHRyYWZmaWMNCmNsYXNzLg0KDQpBbm90aGVyIHF1ZXN0aW9uIGlzIHdobyBjYW4g
c2V0IHRoZSBsaW1pdCBmb3IgYSBUQy4gSW4gZGV2bGluayByYXRlLA0KdGhpcyBsaW1pdCBpcyBz
ZXQgZnJvbSBvdXRzaWRlIHRoZSBuZXRkZXZpY2UgYmVpbmcgYWZmZWN0ZWQgKCJ0aGUgb3RoZXIN
CnNpZGUgb2YgdGhlIHdpcmUiKSwgbW9zdGx5IGZyb20gdGhlIGh5cGVydmlzb3IuIFRoZSBWTSBz
ZW5kaW5nIHRyYWZmaWMNCm91dCBvbiBhIFZGIGhhcyBubyBzYXkgYWJvdXQgdGhlIGxpbWl0Lg0K
DQpUaGVyZSBhcmUgc29tZSBvcGVuIHF1ZXN0aW9ucyBsZWZ0Og0KLSBXaGF0IGhhcHBlbnMgaWYg
dGhlIG51bWJlciBvZiBxdWV1ZSBjaGFuZ2VzIHdoaWxlIFRDIGlzIGNvbmZpZ3VyZWQsDQpob3cg
d291bGQgbmV0LXNoYXBlcnMgYW5kIHRyYWZmaWMgYmVoYXZlPw0KLSBXaGF0IGFib3V0IHNvbWUg
bW9yZSBvYnNjdXJlIG1lY2hhbmlzbXMgaW4gbWx4NSB0aGF0IG1heWJlIGRvbid0IHJlbHkNCm9u
IHRoZSAxOjEgbWFwcGluZyBiZXR3ZWVuIHR4cTp0Yz8gVGhlIEhXIGNhbiBpbnNwZWN0IG91dGdv
aW5nIHBhY2tldHMNCmFuZCBjYW4gYmUgY29uZmlndXJlZCB0byBhc3NpZ24gdGhlbSBUQ3MgYW5k
IHNjaGVkdWxlIHRoZW0gYWNjb3JkaW5nbHkuDQpUaGlzIGlzIG9uIHRoZSBtbHg1IHRlYW0gdG8g
cHJvcGVybHkgdW5kZXJzdGFuZCBhbmQgY29tbXVuaWNhdGUuDQoNCkJ1dCB0aGlzIGlzIHdoZXJl
IHdlJ3JlIGF0Lg0KQmFzZWQgb24gdGhlIGRpc2N1c3Npb25zIHNvIGZhciwgSSBiZWxpZXZlIGl0
IHNob3VsZCBiZSBwb3NzaWJsZSB0bw0KbW9kZWwgdGhpcyBpbiBuZXQtc2hhcGVycyB3aGVuIFRD
cyBhcHBlYXIgYXMgZGlzam9pbnQgc3Vic2V0cyBvZiBuZXRkZXYNCnF1ZXVlcy4NCkdpdmVuIHRo
aXMsIHdlIHdpbGwgcHJvY2VlZCB3aXRoIHRoZSBFVFMgc3VibWlzc2lvbiwgY29udGludWUgbWVl
dGluZw0Kd2l0aCBQYW9sbyBhbmQgU2ltb24gdG8gaXJvbiBvdXQgbmV0LXNoYXBlcnMgVEMgZGV0
YWlscyBhbmQgdXNlIHRoaXMNCnRocmVhZCBmb3IgcHVibGljIGRpc2N1c3Npb25zLg0KDQpDb3Nt
aW4uDQoNClsxXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjQxMjA0MjIwOTMx
LjI1NDk2NC0xLXRhcmlxdEBudmlkaWEuY29tLw0KWzJdDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9uZXRkZXYvY292ZXIuMTcyODQ2MDE4Ni5naXQucGFiZW5pQHJlZGhhdC5jb20vDQo=

