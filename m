Return-Path: <netdev+bounces-97837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09D8CD704
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42438283A8F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF42F9CC;
	Thu, 23 May 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUL+Dz7A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775114A84
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477986; cv=fail; b=sEzZWGrJIyR9Mcf4me+Yk2tas1CytmWJjxuvWQfahRJa32IMc1YPq55WC47/e3ZC0iSwNBDsdFgy0kEm2ZaO2kH1xe6oQBm4k5whHewmK93X+OCWKyzTUnhqMhlqIpeiMtBdar/0BrwAx7o6caODDDVOn3mkYmo07osEM4ixvFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477986; c=relaxed/simple;
	bh=tyTSMD9Tn0EUsGTArSix253eNf9wTolg2jTlqc8/QzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQVcGmIWbpxPLGw8eF1/HMFq4lskVkt2pbcIV/SSFGXAiTSeDE/jlQF1OcFlESJUZB4fN/TM5bpn4Q3+y3YujTMBgl9WNYSOhdWxPOGx2CWZIwaoWT4SQAFFcCgEJDPAlrAJmO1PJ/zMvS39XpdPQ7z4m/hS7iKoL6QUsHbpc98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUL+Dz7A; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFau8p2fRSP0pC0p745gdqy1uDlL9XQ18W45ji5EJQQrpIdCkA98dWL3RM9qdHryLjtG59L6eFxORmFO9R4F6kQH1IuNb6K5pkcWKPzIn/PZy8LEZfjrIYli8sgisqqXO5r4T0oy7BnDoluZbS6Amv7UDWiBWDGCYBHeksMfdH6S/zYL57jPCPvEAnHi1c+fK4d7ndWM5uJh8aVRoR/GzxKHdY045vVVSL3nJ1qjLlnZgbvYCr6E353aRTdwjMc3kqN0/uIMU/LRoC7tPLaAOyG7a9v/aXY78fGZ16NXIAheTf3MRm9W/wuIWh52RZolrI6jBTYJ6zQbHwSCdGQMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyTSMD9Tn0EUsGTArSix253eNf9wTolg2jTlqc8/QzI=;
 b=J/LYYZIbKFrgY0JX2xVwXl4IlO4VbkSqs7XulwcTMOBz0l52VcPD1l3mPmVBBP+a5fAVrSApsT08LLiFzeFiu8hb8cMxd6M0ujW5lSor+8lGSuFdp6CFrRnzaJEJ3Rh5C8VDHZm4AGdOpg418qYHkxqJ2e5D3CKt3S56km7Luns4UIvuQBjEqeupL1FSTObjWUeNjJ5wTT6BndNFmdJKwHApIK6L6aN71hRpteCSofRDVjcKhTOTXqcrXswbrHOZoB2VAxiAom3FH6YEsTpLaIZNTDwOXow0mK0plUDse9jeN1YBGUf7rIy7NaqdcXkUG+92bxpWUUqbXqPhYX2lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyTSMD9Tn0EUsGTArSix253eNf9wTolg2jTlqc8/QzI=;
 b=YUL+Dz7AKg8I2w29ZmNvzZeorCUl522i9ikLMUnT+m5SawdJql9ynfM3aD0ZeVQl0mgkj0i7BvD4eZHTRuUmKjvqw9BO6vZ4PucrdOMIIT0UxUyNhJqN6jVHOslGOtqyTjXTTB2pdKoOu0Hzmi+n0jl1bJao8bNIJJ2wqfeATjoA+YSWRkph+Ya9fJdUL3I/5kQufgqJaEERQDV6p/sDrleNJRskHmomwg02MViDTsv/FESBr/KyyHPnyBKGkTw9VXVOdBXm+tS0ydbOn730xGOeSrMBDJX81EnRb771Gf2g8Wq5yvOI7GwjaGShybymIioE/Ff9c4a8Mv2e3v6Heg==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 15:26:22 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%6]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 15:26:22 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Topic: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Index:
 AQHapRztf+XVv59L3kGimcbRJBg/jrGU9qgAgAFhhICAABVtAIAJgugAgAMbzACAARmhgIAASUoAgAADfACAADMPgIAAWyIA
Date: Thu, 23 May 2024 15:26:22 +0000
Message-ID: <405dc0bc3c4217575f89142df2dabc6749795149.camel@nvidia.com>
References: <20240513100246.85173-1-jianbol@nvidia.com>
	 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
	 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
	 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
	 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
	 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
	 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
	 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
	 <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
	 <Zk8TqcngSL8aqNGI@gauss3.secunet.de>
In-Reply-To: <Zk8TqcngSL8aqNGI@gauss3.secunet.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|SJ1PR12MB6025:EE_
x-ms-office365-filtering-correlation-id: 81e2c0bb-a8c0-45f4-b4bb-08dc7b3cb398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFZmSzRCQno2eXYwOW9WWDJzcEMxMVBxNlFzeGI3RXNYUWw0THZJbTZWeUpy?=
 =?utf-8?B?WFhIdWNmNmhXaGlndmRSYUh3b1kycGx3Um9kUFp4RkNRQTRaVnNqQ3B3ZFBv?=
 =?utf-8?B?d3RzZU05Rk9vekk2MjVUWk1aWXJZNFlwRWs5NUdtRFB0NHoydVNBOWJlczVY?=
 =?utf-8?B?T01GaktVV1BLV2FNcFpvRTE2QTJkSWpkTkMvWjNHSUQvR3JqUklDM0JZU2dh?=
 =?utf-8?B?YTcxWlI4czZiVUZqbnVpTys0Y3JRTDNZd1FNZGl1QlJQU3VyT1dDR095cUI5?=
 =?utf-8?B?YzVxVFpZS0N1VHREcW5ITnVSN2xhLy9hL3BuTHQ0cUFoY1MwQ2FLUWx5U05Y?=
 =?utf-8?B?Ump0VGVXTkpZRVpDM0Jtc2Rha0FmTFJOaDZKK0ZUWmRJektzSG9NSW5zNWY5?=
 =?utf-8?B?UE1RUzF1M3ROLzZNbURCb0FpampCQ25GQk5SUEFGNTVLUi9BcG9Ha1pQOWtm?=
 =?utf-8?B?bXNYM2Rzb25YODgzM0hWeVdsT01sUjZ3RGZZUE80T2p3d05JODRoUDNNZEhn?=
 =?utf-8?B?ZTBoZGtFRnJIMGVJMVVQK1dJQkZDVkVaNkN5dTlSMmNyd3JyR3JBVWF1UXFW?=
 =?utf-8?B?UmJ1aE1xdHNDNkxxeWcvdkpIWU9yZTQ2cTlpZ09MY2tUQ3VyaFVTaDlvdlVm?=
 =?utf-8?B?NUREaDJ6d2poZ3lCSjhCMHpGMllSb0JHUmMwekxiUW5yQ2lKLzI2TzB1YWlY?=
 =?utf-8?B?c1F0YXdiQUc3QUtLMCs2ajcyQTEvbWpaTkUxVE5DeEtLNU1JRWJ6WHpNbFEx?=
 =?utf-8?B?NG54R0JwMStIUzljRXhsWElJU2NZQmJDVngyVVZjV0tEVGVhOVRnbmN3Lzk3?=
 =?utf-8?B?OThjRGFYcWpRNmRuY2pOU1Y3a1M2cFlPS2VDQVo3SnR2WUlTa3FLUzYrSzdv?=
 =?utf-8?B?WnpWdGUwOHdtclI0ZWRFMlJYd1Fra0JpK0sxeFI2Qnc3cXNzNkV3SEk2RWpY?=
 =?utf-8?B?YlVlN0dtYnRvdXdLZDFUekpwYklkVXJpQjh4cE8vbXJNeGw0UnE2dHJCSUQ0?=
 =?utf-8?B?a1JEeFB5ZnliRXlFK2grM3UxUG04NTJKY0hxcUNCQS9aTXF6VFNCbTh5dXBI?=
 =?utf-8?B?bG1VbjZhRHpneUFKYXhPTVlweGN1UkRDL1RlcjR3NjBDRmh6c1NUMWxWUnZ2?=
 =?utf-8?B?MDlUTWxTQlAvUXJkWEFpaHF0RlpmVnVUYml3ajRaa3lwOGpsM0dNTklyNXFS?=
 =?utf-8?B?MGlTNzk2bDM2aGdXdmNMMmVZVnRTT1RzbFhkU3Q3Y0p4aVM3WG1kY1VFQzFk?=
 =?utf-8?B?RXpnNmFralI4R1hLQzlsRXdlQklHZFNBS2xqUDZHeGFBRnBicXNOTmZndjk2?=
 =?utf-8?B?Y1orU3lYaUtYZEF0MEU5ZUJsZ2pybXNhWFZwdm1TNHBTazM4SUxYZE5WK3ho?=
 =?utf-8?B?bDhqc0NmSUR6R0VOQXNxZ3pWZklkQ1YvUnpvOU9TcjFkS1ZiM3l1R1d5SUZw?=
 =?utf-8?B?aUpTSUU2ZENhak1qbjFrc0p4YnpGaEdjOFprRjdmckRSR1hVZUlYVzZsRHRH?=
 =?utf-8?B?WHRUckxpclh0aVk2aHB4NWwwU3BLYTBmY0pHVnJFWTFOQlJnM0ptQ1FNVlFO?=
 =?utf-8?B?YnlPWWM3NVpHOEFvUDNVQW1TTHpBQWhwL2p6S3R4L2VWYytLZm5MVjQ2N2Ny?=
 =?utf-8?B?c2tJQVRBaU5XcUE5S3BaL1BlOWxwS3FUcnBKVllPb0kwNVovb3ltcHNHalVM?=
 =?utf-8?B?cm5iWjJKZEFZN2VSdVZPN1pYUDc2UHZrRUIzY1E3Z0JLZENyTVR4RzdhQ2c5?=
 =?utf-8?B?NEdINDJZd09reFNTdk1YczRLZ0FXVThOclVSVUhhUzFSWm4xZGsrMlBkREp0?=
 =?utf-8?B?Vi9VTTh1ei85aCttazBXZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnU0SlpxZkd6QVY2eVZsWDdQOG1oMUNtUWpsOGtSaVpWcXhJak93UGlxTjMy?=
 =?utf-8?B?Z3NLZERSYkwyVFBmQ2tTN2pmdWlkdFNGa1pna0poV3UxN1E0VXMwS2hUaVNM?=
 =?utf-8?B?RVhHVGRQSmJCekRRUThUSWlWc3l1SmRENjZDVUo5cnN6UFJGcHFDSFAxOVNo?=
 =?utf-8?B?YWpIVCtWWG1UaFpmdTc4K215aE9iSU05cHhtaFBLZEdrUlZHMzlPVTl3bXR6?=
 =?utf-8?B?R0VnaGdQeTZlalNNMzByYW1HaktkWExxOEJQeEh3K2wzZnQyNFQxWTRFZCt2?=
 =?utf-8?B?MW1wWTFiTUtLbXh5dlNjd0xoLytjbk9XUlcwR0drRjljVDY2Mmpya2VkSXV6?=
 =?utf-8?B?cUFJclBBTjcvVE5lcnZJc05BVDZKdmVRSTI0Yk1DUDU2WjVaUHZ3Y2FnMXUz?=
 =?utf-8?B?bnFhUmR5RHRiS05nWU1MeFFBVm83d0FUN3doWVlXcTJKcEt5N09ZdXlZMU80?=
 =?utf-8?B?RmxZSlNtQzFBcytYZTkyTWpUR2h0VkszckxlMXVwWG5lOEpzeDdFL1Yzcmox?=
 =?utf-8?B?UEt3Mjh2eEZCUEFiWHlQbi9BRXhWaWxSbUN6R0RFR0tEaWNNdnlUUFlFR09k?=
 =?utf-8?B?VExaSHR6dGNHM3BLQVFPNU1DdW1laHJqNVVRVFU5b2VLeVBwT0RLU0JkQWMz?=
 =?utf-8?B?T1E5dVRRKzNocnlycjZqTWJhYktScjQzamlkVlREN0oyNjJWbnVHUis1KzBT?=
 =?utf-8?B?NmQvNGZHcmNEdStsNG1XemhuV0gycGtDbXZrczNwL3dRNG9ndzcxSEZiSkFp?=
 =?utf-8?B?Y0owVmxOZDBSOURmMGF2L3BtYk5hOWpFMllhb2lQem5kRndWMnVkVWlzbFln?=
 =?utf-8?B?a1dlTzJ6Z1JHaGFzRkJVZ3FHVXAwcVZ6ekIycmdsMnB6YnF0SkFIS2NTL0sw?=
 =?utf-8?B?dGlVSHg2YWVtNVdLZ2tHQWtDcFhNclF2aW81VzhWODRjMmpaVXBiQ2N5akhX?=
 =?utf-8?B?Mk5aRjM2WlNJSVNXRUhnSmhMUnJGbVhmV0JkUXpaRm9mSmcwMXQzTUN1dVNn?=
 =?utf-8?B?ZWJoaGNqNUR1dzNRRFFncTg4QWkydXM2cGRGc1lqeHhCYXRDRHhkTXRlMGJs?=
 =?utf-8?B?bEttZVhvdE54cG1UM1NkRTJ2MjU3dmovSFNBa2t3ejlqc1VyNE1YNGU4ZmU4?=
 =?utf-8?B?Rm9YOHJPQy9xWm5pVzFKazRiaHVhZW1JV0xwTElWaUJMNEZXODFoeFJBZUlq?=
 =?utf-8?B?VksrN0JlYjduOUtQay9YaGZZR3M2M2htSlp1dlVuZmtSS3V4RElCWlFuUzRM?=
 =?utf-8?B?VElPaE4yWVo5eTVEV1Yxc240em0wcVpRVjcrcVEyTlN6eTFFYzZrK1RGNVV6?=
 =?utf-8?B?c1I2QVlzaFU4SmFnN2ZpaVNZdy84ODVUL1YxY2kvSlh1cDhtWkVWTDkzMXBw?=
 =?utf-8?B?WHJiSlVGcFBuYWsrcXgrWllaOXYyVGUwVlBUa0F4ZDlObGIveEd0NUFicTBZ?=
 =?utf-8?B?RTdqNkdrd25uTXh1aEJQL2YvWU1ScmNMNjQzaGNYbk1OZm9mNGVFSXNXcWRE?=
 =?utf-8?B?NkJPR0kvM3EwRTNXaHZxTGRMdkFoSzhNcmdzb3Rnang2K1JUOWdiS3ZzaDJK?=
 =?utf-8?B?YU1lODVuNUJseGI4YmdrWExFQ1ByNWlTeTdnUXZGenBJREJLb3htRm80Q0FP?=
 =?utf-8?B?TFQ1Wm9lczB6QmpacHc4a2hEZXk2RDNBZ0JMMVdIWmZlUWdwd3V6aHBzdzhs?=
 =?utf-8?B?WkliT1dUZkZXbndaeEZnOS8vTG5qM2tVN1pQd09weUlDTzV0eGxIb2V0dDE0?=
 =?utf-8?B?RmZuM3B5R291am8xOUladDd2SVdYM0xIbW1Zc3hTZDZlYVdEVWVJc0ZJSG5z?=
 =?utf-8?B?dGFQM0JGRi9VUnZvY1prVVlYL1Rha1Vza3hDZ3RncHdHVG8wdVc0OVhjUUY5?=
 =?utf-8?B?QythcjFyQU80dis1blprZnhxdXR5Z2hHQTUvcVpwenlTcmtMbGN6TC9XQ0Qv?=
 =?utf-8?B?RjVMM0dnNCsvaVVqZEV5ZW5DYjc5cUt6d21vZk5xMENKcFpWTFVWelhXWlRH?=
 =?utf-8?B?QS9NWURNQ0oyQ25sN0Z1R3R2NEhSWG9tTHVxMnFBajE2eW8xUHNuWEpjSXdu?=
 =?utf-8?B?WkRGdk9FSVZRTmZOUDlHOXlDUXlIM09BdlVCYlNOMUhiNytEVVZZOG1zNnhY?=
 =?utf-8?Q?/Mx/l0Vwx7umvDSv+99aodiSg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5870B4773C50B44BB8029963A003447@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e2c0bb-a8c0-45f4-b4bb-08dc7b3cb398
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 15:26:22.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIiUR68Gvp7BFaTdzXCUlDAbVrg5S1pFI3UbwxNUAMrbbMsBmx3UUfq+jJ3YriEMS49LcsK9vYZ3V/rSwac4SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDEyOjAwICswMjAwLCBTdGVmZmVuIEtsYXNzZXJ0IHdyb3Rl
Og0KPiBPbiBUaHUsIE1heSAyMywgMjAyNCBhdCAwNjo1NzoyNUFNICswMDAwLCBKaWFuYm8gTGl1
IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNC0wNS0yMyBhdCAwODo0NCArMDIwMCwgU3RlZmZlbiBL
bGFzc2VydCB3cm90ZToNCj4gPiA+IE9uIFRodSwgTWF5IDIzLCAyMDI0IGF0IDAyOjIyOjM4QU0g
KzAwMDAsIEppYW5ibyBMaXUgd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgMjAyNC0wNS0yMiBhdCAx
MTozNCArMDIwMCwgU3RlZmZlbiBLbGFzc2VydCB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBNYXliZSB3ZSBzaG91bGQgZGlyZWN0bHkgcmVtb3ZlIHRoZSBkZXZpY2UgZnJvbSB0aGUNCj4g
PiA+ID4gPiB4ZnJtX3N0YXRlDQo+ID4gPiA+ID4gd2hlbiB0aGUgZGVjaWNlIGdvZXMgZG93biwg
dGhpcyBzaG91bGQgY2F0Y2ggYWxsIHRoZSBjYXNlcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJ
IHRoaW5rIGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXMgKHVudGVzdGVkKSBwYXRjaDoNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L3hmcm0veGZybV9zdGF0ZS5jIGIvbmV0
L3hmcm0veGZybV9zdGF0ZS5jDQo+ID4gPiA+ID4gaW5kZXggMGMzMDY0NzNhNzlkLi5iYTQwMjI3
NWFiNTcgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvbmV0L3hmcm0veGZybV9zdGF0ZS5jDQo+ID4g
PiA+ID4gKysrIGIvbmV0L3hmcm0veGZybV9zdGF0ZS5jDQo+ID4gPiA+ID4gQEAgLTg2Nyw3ICs4
NjcsMTEgQEAgaW50IHhmcm1fZGV2X3N0YXRlX2ZsdXNoKHN0cnVjdCBuZXQNCj4gPiA+ID4gPiAq
bmV0LA0KPiA+ID4gPiA+IHN0cnVjdA0KPiA+ID4gPiA+IG5ldF9kZXZpY2UgKmRldiwgYm9vbCB0
YXNrX3ZhbGkNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGZybV9zdGF0ZV9ob2xkKHgpOw0KPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzcGluX3VubG9ja19iaCgmbmV0LQ0KPiA+ID4gPiA+ID4geGZybS54ZnJtX3N0YXRl
X2xvY2spOw0KPiA+ID4gPiA+IMKgDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0geGZybV9zdGF0ZV9k
ZWxldGUoeCk7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrX2JoKCZ4LT5sb2NrKTsNCj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBlcnIgPSBfX3hmcm1fc3RhdGVfZGVsZXRlKHgpOw0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHhmcm1fZGV2X3N0YXRlX2ZyZWUoeCk7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2tfYmgo
JngtPmxvY2spOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGZybV9hdWRpdF9zdGF0
ZV9kZWxldGUoeCwNCj4gPiA+ID4gPiBlcnIgPyAwDQo+ID4gPiA+ID4gOg0KPiA+ID4gPiA+IDEs
DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHRhc2tfDQo+ID4gPiA+ID4gdmFsaWQpDQo+ID4gPiA+ID4gOw0KPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB4ZnJtX3N0YXRlX3B1dCh4KTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgc2Vj
cGF0aCBpcyBzdGlsbCBhdHRhY2hlZCB0byBhbGwgc2ticywgYnV0IHRoZSBoYW5nIG9uDQo+ID4g
PiA+ID4gZGV2aWNlDQo+ID4gPiA+ID4gdW5yZWdpc3RlciBzaG91bGQgZ28gYXdheS4NCj4gPiA+
ID4gDQo+ID4gPiA+IEl0IGRpZG4ndCBmaXggdGhlIGlzc3VlLg0KPiA+ID4gDQo+ID4gPiBEbyB5
b3UgaGF2ZSBhIGJhY2t0cmFjZSBvZiB0aGUgcmVmX3RyYWNrZXI/DQo+ID4gPiANCj4gPiA+IElz
IHRoYXQgd2l0aCBwYWNrZXQgb2ZmbG9hZD8NCj4gPiA+IA0KPiA+IA0KPiA+IFllcy4gQW5kIGl0
J3MgdGhlIHNhbWUgdHJhY2UgSSBwb3N0ZWQgYmVmb3JlLg0KPiA+IA0KPiA+IMKgcmVmX3RyYWNr
ZXI6IGV0aCVkQDAwMDAwMDAwNzQyMTQyNGIgaGFzIDEvMSB1c2VycyBhdA0KPiA+IMKgwqDCoMKg
wqAgeGZybV9kZXZfc3RhdGVfYWRkKzB4ZTUvMHg0ZDANCj4gDQo+IEhtLCBpbnRlcmVzdGluZy4N
Cj4gDQo+IENhbiB5b3UgY2hlY2sgaWYgeGZybV9kZXZfc3RhdGVfZnJlZSgpIGlzIHRyaWdnZXJl
ZCBpbiB0aGF0IGNvZGVwYXRoDQo+IGFuZCBpZiBpdCBhY3R1YWxseSByZW1vdmVzIHRoZSBkZXZp
Y2UgZnJvbSB0aGUgc3RhdGVzPw0KPiANCg0KeGZybV9kZXZfc3RhdGVfZnJlZSBpcyBub3QgdHJp
Z2dlcmVkLiBJIHRoaW5rIGl0J3MgYmVjYXVzZSBJIGRpZCAiaXAgeA0KcyBkZWxhbGwiIGJlZm9y
ZSB1bnJlZ2lzdGVyIG5ldGRldi4NCg0KQmVzaWRlcywgYXMgaXQncyBwb3NzaWJsZSB0byBzbGVl
cCBpbiBkZXYncyB4ZG9fZGV2X3N0YXRlX2ZyZWUsIHRoZXJlDQppcyBhICJzY2hlZHVsaW5nIHdo
aWxlIGF0b21pYyIgaXNzdWUgdG8gY2FsbCB4ZnJtX2Rldl9zdGF0ZV9mcmVlIGluDQpzcGluX2xv
Y2suDQoNCg0K

