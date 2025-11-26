Return-Path: <netdev+bounces-241784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD0C88364
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961E93B2451
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CE30E855;
	Wed, 26 Nov 2025 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Dg/nxo+V"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C901448D5;
	Wed, 26 Nov 2025 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137253; cv=fail; b=acLm0KNmquIXbXaEYkDGlLk8xQMJT6ZtIAI0rm45CT0u2wTuQR07lrJJt55m/6JZddpaIuH7LObHOwpSg0dA/20Iw1HHBDNgpFZda+PQEBBe0TGseoDhxx1hcaQjFMJrQfx39EcODuVX7j2+/JX1umjD4jCI4dBNHK9dEf1aE0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137253; c=relaxed/simple;
	bh=Ml/+JSFheu1e7H7EdlUIyO4S68l6J8kFDqKfVnIoTgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vAObMyz5kPaTsdOYd3Vx17v2BpPZGBFrf5Hu8vHEDJnUB+pD+zwDmMl02lArE9lF5JEXdugJz8YnJ8OaX2pBSCV2cT5OrJciJ+FcotlzlpnoeiJkGQNXXx7Wo0COPfP2TU7bH+Ewj/ACMJ7oD1OiOIQmhWc1C72W61PVy5NIyGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Dg/nxo+V; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouzOJp7gEbA1GHVQbtnhvTBVX2Q3Tb/+onEG0H3yrMuqN+IUnJTAKFNQDjgcTgI9lM3dlDeJZGVjmaZAM3KX/mOeY84qecYmWUuOYwvcsrbPv+/5mJpEKCg5zD4ofdxQXFohAmhDdvGNgSuk3QC73mQFasKiRRZ5HflT7V0fraW4TKXswORfLL45mr/Pcgl54AV+R/1DWr8fTiIzpDk/e8cooG4CbRKMj4SBpA3D6p/7kZGkjj24qSiHVUiOMsQugKEHTvUk7Vb9rIzjLsB3jNBFusUgwJPynOMYIEU9MMOI8QJfBE+RgwyD8PHAr0ATIm7UA3SIoEGSiUsdH11qsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMoEjPt0f7m0GtkBOpXCzvnnB7e5UnEzqM8/1B1Vnpk=;
 b=t725U2wNP1CRAHazViZMSLLaODa9OfKuV61CcY2xQh8XLrRSWVcglDKzySYlpNZt08kMG74inNYUrcVDGUW12W8FOXov+0l3lvD1EY6wJjWYgBh4DjXPljpBM9H20IiznlpmOC0J4jn7YNsCqoT2W2YdmBALYYmKksRWXzZfDqco4rJ7TYl8ZkTwjbS2Rrf/yRrz+F36QROs8lFK+pSSpxitzzW2N6M5lcoAgSZ+7nSRoT494by9nNB9wNumwHG8mbanVVFRWsdHKeJ1CU/CtgQunX0N30ClQBor+/gR7hu5latCR7tKlgDMa/1gw+CdLixcSX2sd2sIm+q1AOJ/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMoEjPt0f7m0GtkBOpXCzvnnB7e5UnEzqM8/1B1Vnpk=;
 b=Dg/nxo+VOfwvAUH5qX5Yt4XPSvKSoIUOaQTKiD56iCT2EzEmwRd72rpDpDblEUhETThgRdZJ1Zg7BuhY39fLmrcyCJuHWwnfqC7lj/3KQTKjiwYYHbreqeRY7/hq0NDfjuV8iqMrrMKiBreCRn7LaxLQvUQYmyU3e6wUcanxkjI89pEJkWeGtQPk4JQn27WZ2onH2SY1oQZa3mBzA7NhfUXswQ7l96GiAPHa3/0RvLaKhip/AARTVoEQdzGqKDv6sYn0PgihmbeitjdUgVPXEy+oe1dmDLDqWR0jpMyWdzm2AH7cyrgUHYe4BtGL7zbCr9wedA5xt6nWaQpujfNwaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by IA3PR03MB8384.namprd03.prod.outlook.com (2603:10b6:208:543::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 06:07:28 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 06:07:28 +0000
Message-ID: <9cea0b90-4b71-45cc-9c8b-ffeae8b7db07@altera.com>
Date: Wed, 26 Nov 2025 11:37:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac: Disable flushing frames on
 Rx Buffer Unavailable
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
 <58ec46bb-5850-4dde-a1ea-d242f7d95409@bootlin.com>
 <bd6b9659-8721-43d0-be60-12af0342b500@bootlin.com>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <bd6b9659-8721-43d0-be60-12af0342b500@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::17) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|IA3PR03MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0a86ed-00ce-49b4-3bba-08de2cb21407
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFhRNFVHVnRyTjJ3WjRmN0RoRTR3V1NrMGVMU3ovUWIzUFI4VTd6cDJYUGcy?=
 =?utf-8?B?a2pPYnpScjJtYXZZbDhYYUd2MXdkNU15b2xjdFJ0Q3BUTUxFWUUyb2N3WURD?=
 =?utf-8?B?RWpPMXZBREJLYzMxMkJVakIwUmszZDA5U3RXZGRzVGJIOU0zek95RkdyY3Ey?=
 =?utf-8?B?VGUwam4vNXZwc0NjckcrcVowb0dPRGdUQmMzUG9YQVc5ZTZPRUZZNUFkMFRt?=
 =?utf-8?B?K0RMcndSNGsxbFUyb3JudlJtRUxHamVESXFUaWc4TWlYV0M0TTVXQ0pvMXkx?=
 =?utf-8?B?dHg0cUkxMkcwT1NGd0tvS1d2Y21mY2p5S082Rjg0bWRTY0F6N0lLcE55Qi9y?=
 =?utf-8?B?SHZuajdnV25MK2JNMXNGd2ZoQ0FObjFHQms1QVl6RmVZQXRMZGpJY3IxdnJZ?=
 =?utf-8?B?cTBBV1dUMjkyd05KbDgvODJuRHMxZmNhT0xJZy9FbXZNbFlNbm13S3FyQmla?=
 =?utf-8?B?aFBRVWV0RHFWMU9RTURDNllXOGxlWk9uWHV3bWxFZTNFaTgyZyt4MkZqVmRi?=
 =?utf-8?B?b1UrbTcrK2JSRXMxZ0I2WVpXaDB4REp3M1c0dGN2ZDVpT3pTWjRPVXVmUzBU?=
 =?utf-8?B?YTFQQk1hMEdOWnJXeG9KVWpGeWNwbVN3aXBzWGhpZVdwb2kwVmV4VDkxVW9J?=
 =?utf-8?B?cW5JMjRlTmMrWkdCYy9aczJIN3FnQWdveUxRN2FFWWJGbUlZZG03MHhDcEVS?=
 =?utf-8?B?SWFrcHhIRXlvSkJkaDdXV1l0dzZhVnV3OVJ0NnpiQlhCZE1WOVlkZ1RFTGt1?=
 =?utf-8?B?aTNlQ3dwQTlMdndVVWUrN29XMFNBMU9pR0k4bDdtSktVYmFOd2J1M0VmanNj?=
 =?utf-8?B?c1plcnN1MW5SZzRydFIxQ08zRFJxVGpVVzF4YjdlNmFvaEx3OFF4NTFGcUJI?=
 =?utf-8?B?K3pCOTQzdVpORlZFMlR4TGwwNnEwWlRGT1FKd1RYUGd2MGc3c2dodkZ3TzJG?=
 =?utf-8?B?RVBhd3pHMkI4L3RLTFI2Q1FKTzRtK0N2LzYrQWdqSkYycytVK1pMMWNlMlMx?=
 =?utf-8?B?d2dwdXQ1YzRqaTY2MnAyRnM4RW1IbU9CWldTWUEvRkNaREZkQUs4NmlaSjF1?=
 =?utf-8?B?YVNaWnpXeDZXTXk2TmM4NFhsdy9yOUw5TDdKbTNMWklhVkxKakU0TjVuMWNW?=
 =?utf-8?B?ZWRPdDBkdDBSUDBLRHBubEpqTEEvenRmUGJYU0QzUDNTUklqS3VTOWlwRWw4?=
 =?utf-8?B?UmlrYWpqMUxSTllLL1g5bzlCTjBkQStvQ2ZxYWN1a21pcWJzQS9ySUdEeWNl?=
 =?utf-8?B?dDZmZlRNTkI5bGV6MksxbG4wWm9pZTdVaE1heDdQUnFBR05FR3lsbG1hRTAv?=
 =?utf-8?B?UFo0bjhURWs3MkFFd0VIZ3EzTHROZGJqZmQvcWlvY2h3aEZxaS9TUGt4QmFS?=
 =?utf-8?B?eTZoa1EvWDF0NDZnTnZ3V1RjMnd5dm1LWUhmZW9uTVlSUkVLMlVaYTZKbTNZ?=
 =?utf-8?B?WTNlbmMxOEFuZm4vVjBydTFOWUFoNkJqWGF4eElwWkIrZm5NS2NMdXBkNlg3?=
 =?utf-8?B?R0N3OFVaL2hmbUZmS2wzbWVpQWk4NUdJQ05FZDdKbTk5VVllTzVINnQxNmNK?=
 =?utf-8?B?aGprQW1sV1I2YlpMN013dndXSWQxN2NyKzQ4cVlaeVd6VWRTckMwN2t1Vzkv?=
 =?utf-8?B?Nmh4NmNodmpMU3hZUHRkbXR1SnJPY1oybTlGREFVY1FieitMM252MUo1SVoy?=
 =?utf-8?B?WDNiSjJsQnV1Y2gwMnVNQWtUY3JLYk04ZUxHQ1NzTnA4WmVpOWViT0pDSE9B?=
 =?utf-8?B?OXNLckk4a3VmVWlKeW90MjlGT0ZoYXF1VVBLZ1Z1YUtZc3dlcFErb1lzVU9J?=
 =?utf-8?B?TlIyeGdWWURQL1o3enNnODZkZzVzWVdwSHlJelZLZE8wY3ZhV3hKd3hxZmts?=
 =?utf-8?B?RlRMVWEyeU1mQkFhWHlFUFlRTS9kdFdnSzREWUVVOCs2b3hHUWpZbUhnbnNM?=
 =?utf-8?Q?mDEp/FR2V2bnsMUYk3dK43A52DzQmmnm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VjYkE4bzMzMnJDS0trSkU1a2lwd1Q0MTBqVzdqVzN1bG5Xdmp2SURKOWU0?=
 =?utf-8?B?VVZhd3FUa2JDb3JhRmJkZk5tbFpFZHlOUEt0UGgzdVZ6TUluWlVLcFVsWkJ4?=
 =?utf-8?B?eTdnRWx3VWFtRnVKSFMwMTh4UGxOakRxdGo4ZkZBL2toaTIwTUVpa0ttY2hN?=
 =?utf-8?B?R3FTSFpqWVUrUFhJbENxa2l4ZzhURGFxdmF4a2c2Ky9JbjF2bWxJQjl6dGJz?=
 =?utf-8?B?OFRtdFVyd0xjdmF5RDlxYjJMWlNyWWZEQzRPOVpnNGZBT01ZM2NiNHZTeHlm?=
 =?utf-8?B?TWZpWWl5QnlScXFsUGZRV2VKR2E3SWlUSFlxSHVKSnRYMXphOUN1SXZLTHZk?=
 =?utf-8?B?WHBROTdiRFJWNWxseHBWdGdzUzU5Z2ZVYnB2SzBNVUFJMWkreUJwL0tlRjBs?=
 =?utf-8?B?MU1HemNTMGo4amtKbi9ldmJ4WnptaDVuMUJNbTUxcU1CL1E3MThSZkljWUFm?=
 =?utf-8?B?UjlFWGhkNEphaHJpOHJmWSs5WGRZN01MZ2Z6NEpwNlNtMFAyTUVWSDIrYW40?=
 =?utf-8?B?OHVsQ0R5ZU1wSzZpZVZxeXI1VnlLOVJJangyUnFnVGlSQXZtMVdBRXlzL1Q2?=
 =?utf-8?B?bHlWYnJpMUpnUEhWTUpNbWl6NGRQTUppQ1d5UkZDd3NqeW5FRW1Db09Ca2pn?=
 =?utf-8?B?b2hDbDRMRlZxOGs4RDJxU3RzYWVibmVyL1V1cmJQS29wWDNydTNPaXJDaDJj?=
 =?utf-8?B?ZTQzN1hvR29LWlJMeC9YT0FJcy8zeTRhUlROSm1WeE42cWYzd2lyYjYxSXc2?=
 =?utf-8?B?VCt6KzhCTmQyVmtseXNkZmoxRlR3VjBVMGZmY1BPNGV6eEpsV0ZMNWx3VEx3?=
 =?utf-8?B?ZklZMnE5d2pWbDI0TzUwdzVEbUU2Q05RVUtWZUlMaHlZUnMzT3J0V0lXNkh5?=
 =?utf-8?B?ZjJldysrTm9Walo5M1UrQ2p2OSt2R29ab1ZzakJnVVBkQVQybkkvR0pDdW9Z?=
 =?utf-8?B?c2d3VEp6TysvRWRPNWJPeVYxVjdHdDNOMkZXY3oyOTVqckNoaHBvMmRya3c5?=
 =?utf-8?B?RXArTTltdjBkMTBPZ3JFT3laejN6aXAyY3RmTjRROVFUTGUrbDQxdmlPZXRm?=
 =?utf-8?B?b2Q0WFdlbDZvYU1Ydkh5RHNlSFV5WkgySHZ2bGxsQ2xmV3B0dXFGL2o3dXRD?=
 =?utf-8?B?TjI5aUZ2Ky94MEFwTmhTMnNMNHJwK3hyNlZkUWpHSTZiWUlvbGhjdEhTanhE?=
 =?utf-8?B?bXBETnBHWTByTW5DS3B3cEVtQ2doM1BpK1I5aXd3TmJRbjF6SmhPSlM4aTNy?=
 =?utf-8?B?bGhxaVYvcEhNbWZ1M0pFZjBDVXJqSmhQenpya3ZvN0V5eUdiVzdISHhMQkdX?=
 =?utf-8?B?QlBrOHRYQ3Rza0RhanZSTDFhYy9Ba3RhQndxT3JRYWFkY2dYN2RiY3I1WThW?=
 =?utf-8?B?R3Q3Mm1Nc2Y0cEFCSmxHVTMwTGo2VGVzc0x0dlphNHIrVFp3S0o1S3ZuN3Ro?=
 =?utf-8?B?ZWtyZHBXTXRBaDVtNzF3eWgwL2ZqcVhMWGFpQXd3VTYwVERhLzl6Q2NXd21k?=
 =?utf-8?B?UEt3QlNVYjN3U3l5VWFBZnNQTDEydFB4cWN2dGdieXV3eEpHN2RuOUtKRDlV?=
 =?utf-8?B?bzNKYktzdnJWVXFLbnQvRHJQdktCQUkzeGhVTENEbVVPRXc1Q25wY2lyakNv?=
 =?utf-8?B?ZmdheWpLRWgvQlNvUTFqdXNCMytRUXhxWXpiMVBHT1JRaXozYkFLTUF3UjZK?=
 =?utf-8?B?TkxMdjJtL0JmY05GQVF4TE9ZMWk3dFBmQkxBU0RuNG5ET25XMWg2ZGlDSDdv?=
 =?utf-8?B?bytGN1cwbUdTTzNpQzk3OHpleUpSODhYM2JXYTl0SUJKZisvZlFsVG5qRGlp?=
 =?utf-8?B?eXByWWZseUliZUFuMi9mZWxhZjlrcEFYMTZDVzVPdHJKczFsSjlXWUYvTFN0?=
 =?utf-8?B?WUJ1RFIwbUxIRDEybk4xMVNLR1VMMWE4K0hBQTJGZklnVlMxUnBDbkpGdmxp?=
 =?utf-8?B?QjhnRHl0elp0R3F1ZWllbnkxb2t5NmhFcU5jWVcyV3VPK2t0ZjRmQ1NEbEta?=
 =?utf-8?B?QzlWYWVtbkFxVExjNldvcFVHWTUxWWYyckNqUEJadVZxYUF1RklQMzJLdFUy?=
 =?utf-8?B?U3VwTFVla3BZYTgzRUFxTVRJMm5Cek9MTXp5SWNoZExzTWlGcU0vUmR3WDZq?=
 =?utf-8?B?enBPMHBNQVFxcVJJZU81K2J2QXZ2QUEwaFhCakQ2eDlMNTlpTVV5eGtBKzhZ?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0a86ed-00ce-49b4-3bba-08de2cb21407
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 06:07:28.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhzetO9Tqdq3qYMwwxsxRzjOUiRKD0NWTGlG8AA6IknfFDgGsEX3cEGm2bdm98KTM7zYhW4Zn1OlET79iyA+9raoz+Q+TpsaC+G22hKGnNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8384

Hi Maxime,

On 11/25/2025 11:33 PM, Maxime Chevallier wrote:
> 
> 
> On 25/11/2025 18:15, Maxime Chevallier wrote:
>> Hi Rohan,
>>
>> On 25/11/2025 17:37, Rohan G Thomas via B4 Relay wrote:
>>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>
>>> In Store and Forward mode, flushing frames when the receive buffer is
>>> unavailable, can cause the MTL Rx FIFO to go out of sync. This results
>>> in buffering of a few frames in the FIFO without triggering Rx DMA
>>> from transferring the data to the system memory until another packet
>>> is received. Once the issue happens, for a ping request, the packet is
>>> forwarded to the system memory only after we receive another packet
>>> and hece we observe a latency equivalent to the ping interval.
>>>
>>> 64 bytes from 192.168.2.100: seq=1 ttl=64 time=1000.344 ms
>>>
>>> Also, we can observe constant gmacgrp_debug register value of
>>> 0x00000120, which indicates "Reading frame data".
>>>
>>> The issue is not reproducible after disabling frame flushing when Rx
>>> buffer is unavailable. But in that case, the Rx DMA enters a suspend
>>> state due to buffer unavailability. To resume operation, software
>>> must write to the receive_poll_demand register after adding new
>>> descriptors, which reactivates the Rx DMA.
>>>
>>> This issue is observed in the socfpga platforms which has dwmac1000 IP
>>> like Arria 10, Cyclone V and Agilex 7. Issue is reproducible after
>>> running iperf3 server at the DUT for UDP lower packet sizes.
>>>
>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>>
>> Should this be a fix ?
>>
>> Can you elaborate on how to reproduce this ? I've given this a try on
>> CycloneV and I can't see any difference in the ping results and iperf3
>> results.
>>
>>  From the DUT, I've tried :
>>   - iperf3 -c 192.168.X.X -u -b 0 -l 64
>>   - iperf3 -c 192.168.X.X -u -b 0 -l 64 -R
> 
> Ah ! my iperf3 peer wasn't sending packets hard enough. I switched to a
> more powerful LP and I can now see the huge latencies by doing :
> 
> 1 - ping the CycloneV from test machine :
> 
> PING 192.168.2.41 (192.168.2.41) 56(84) bytes of data.
> 64 bytes from 192.168.2.41: icmp_seq=1 ttl=64 time=0.387 ms
> 64 bytes from 192.168.2.41: icmp_seq=2 ttl=64 time=0.196 ms
> 64 bytes from 192.168.2.41: icmp_seq=3 ttl=64 time=0.193 ms
> 64 bytes from 192.168.2.41: icmp_seq=4 ttl=64 time=0.207 ms
> 
> 2 - on cycloneV, Run iperf3 -c 192.168.X.X -u -b 0 -l 64 -R
> 
> 3 - Re-ping :
> 
> PING 192.168.2.41 (192.168.2.41) 56(84) bytes of data.
> 64 bytes from 192.168.2.41: icmp_seq=1 ttl=64 time=1022 ms
> 64 bytes from 192.168.2.41: icmp_seq=2 ttl=64 time=1024 ms
> 64 bytes from 192.168.2.41: icmp_seq=3 ttl=64 time=1024 ms
> 
> 
> This behaviour disapears after your patch :)
> 
> Maxime
> 

Thanks for testing the patch.

Yes, this is the scenario adressed with the patch. By default driver
configures for SF_DMA_MODE and issue is reproducible when we stress the
mac with Rx Buffer Unavailable scenarios repeatedly.

> 
>>   - iperf3 -c 192.168.X.X
>>   - iperf3 -c 192.168.X.X -R
>>
>> I'm reading the same results with and without the patch
>>
>> I've done ping tests as well, the latency seems to be the same with and
>> without this patch, at around 0.193ms RTT.
>>
>> I'm not familiar with the SF_DMA_MODE though, any thing special to do to
>> enter that mode ?
>>
>> Thanks,
>>
>> Maxime
>>
>>> ---
>>>   drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 5 +++--
>>>   drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     | 1 +
>>>   drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     | 5 +++++
>>>   drivers/net/ethernet/stmicro/stmmac/hwif.h          | 3 +++
>>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 2 ++
>>>   5 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>> index 6d9b8fac3c6d0fd76733ab4a1a8cce2420fa40b4..5877fec9f6c30ed18cdcf5398816e444e0bd0091 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>> @@ -135,10 +135,10 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>>   
>>>   	if (mode == SF_DMA_MODE) {
>>>   		pr_debug("GMAC: enable RX store and forward mode\n");
>>> -		csr6 |= DMA_CONTROL_RSF;
>>> +		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
>>>   	} else {
>>>   		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
>>> -		csr6 &= ~DMA_CONTROL_RSF;
>>> +		csr6 &= ~(DMA_CONTROL_RSF | DMA_CONTROL_DFF);
>>>   		csr6 &= DMA_CONTROL_TC_RX_MASK;
>>>   		if (mode <= 32)
>>>   			csr6 |= DMA_CONTROL_RTC_32;
>>> @@ -262,6 +262,7 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
>>>   	.dma_rx_mode = dwmac1000_dma_operation_mode_rx,
>>>   	.dma_tx_mode = dwmac1000_dma_operation_mode_tx,
>>>   	.enable_dma_transmission = dwmac_enable_dma_transmission,
>>> +	.enable_dma_reception = dwmac_enable_dma_reception,
>>>   	.enable_dma_irq = dwmac_enable_dma_irq,
>>>   	.disable_dma_irq = dwmac_disable_dma_irq,
>>>   	.start_tx = dwmac_dma_start_tx,
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>> index d1c149f7a3dd9e472b237101666e11878707f0f2..054ecb20ce3f68bce5da3efaf36acf33e430d3f0 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>> @@ -169,6 +169,7 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
>>>   #define NUM_DWMAC4_DMA_REGS	27
>>>   
>>>   void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
>>> +void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan);
>>>   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>   			  u32 chan, bool rx, bool tx);
>>>   void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>> index 467f1a05747ecf0be5b9f3392cd3d2049d676c21..97a803d68e3a2f120beaa7c3254748cf404236df 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>> @@ -33,6 +33,11 @@ void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>>>   	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
>>>   }
>>>   
>>> +void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan)
>>> +{
>>> +	writel(1, ioaddr + DMA_CHAN_RCV_POLL_DEMAND(chan));
>>> +}
>>> +
>>>   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>   			  u32 chan, bool rx, bool tx)
>>>   {
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>>> index f257ce4b6c66e0bbd3180d54ac7f5be934153a6b..df6e8a567b1f646f83effbb38d8e53441a6f6150 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>>> @@ -201,6 +201,7 @@ struct stmmac_dma_ops {
>>>   	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>>>   				  void __iomem *ioaddr);
>>>   	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
>>> +	void (*enable_dma_reception)(void __iomem *ioaddr, u32 chan);
>>>   	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>   			       u32 chan, bool rx, bool tx);
>>>   	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>> @@ -261,6 +262,8 @@ struct stmmac_dma_ops {
>>>   	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
>>>   #define stmmac_enable_dma_transmission(__priv, __args...) \
>>>   	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
>>> +#define stmmac_enable_dma_reception(__priv, __args...) \
>>> +	stmmac_do_void_callback(__priv, dma, enable_dma_reception, __args)
>>>   #define stmmac_enable_dma_irq(__priv, __args...) \
>>>   	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
>>>   #define stmmac_disable_dma_irq(__priv, __args...) \
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 6cacedb2c9b3fefdd4c9ec8ba98d389443d21ebd..1ecca60baf74286da7f156b4c3c835b3cbabf1ba 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -4973,6 +4973,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>>>   	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
>>>   			    (rx_q->dirty_rx * sizeof(struct dma_desc));
>>>   	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
>>> +	/* Wake up Rx DMA from the suspend state if required */
>>> +	stmmac_enable_dma_reception(priv, priv->ioaddr, queue);
>>>   }
>>>   
>>>   static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
>>>
>>> ---
>>> base-commit: e3daf0e7fe9758613bec324fd606ed9caa187f74
>>> change-id: 20251125-a10_ext_fix-5951805b9906
>>>
>>> Best regards,
>>
>>
> 

Best Regards,
Rohan


