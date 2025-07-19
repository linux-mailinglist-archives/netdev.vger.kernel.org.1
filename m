Return-Path: <netdev+bounces-208358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04ACB0B1F4
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 23:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D448017D889
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 21:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC02222D4;
	Sat, 19 Jul 2025 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="VuOGEV40"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5221D59F
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752960488; cv=fail; b=b75nqN9R3aZiVElwbuvgt+mK6n+Eh9qN+/oYiVQzvERsOhY893UpzKqXd/9ByfcaZ+ImY3qnBvu5Vee/orD9Y4JP8I7RAxdz+NDc0RRWXlMuLebvkIkYgp1IhY77xsn5lEbH5dsSGSw+3rL9IIcLJf9Ppvr3Zp+nob3Kmuje7Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752960488; c=relaxed/simple;
	bh=xt0Bsx9DVh3dO9vTNK/ARV4tcuSSbG/3QZhtnwXrGp0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dk15+Y54QIrfqg0goLJJ1PS1XTcuEiLX9FuFjnwq1JALOWGYB3RDaNcdDjX6VkXQrJfaAskyHVktvqMpkJRKdmOIS5nTLt3aq4acbSFrMpKg0WWfMsiW414Z48hWkwUzPNYcTRxeN80K08gaZqS2rCbFiVCwTpcHUYR0rrE0nwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=VuOGEV40; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1752960485; x=1784496485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xt0Bsx9DVh3dO9vTNK/ARV4tcuSSbG/3QZhtnwXrGp0=;
  b=VuOGEV40p7Qr8vhj8cxRW6tt6ZdROfCwFafQPDtMf6zaZH5+QbHFbUIo
   kXIkRn1lbX7foQCaEUoSXPebaiDWeEDNp2yel2GT9QVuF2eB+YwFeBGwZ
   TLbcpHn4OZAOc15jTxFp18Zz8ybZ6Y1f/u24XxwXncZL4gXfBLK2oTNB+
   I=;
X-CSE-ConnectionGUID: WqrVddyHRU+yH+Rf3xcbLw==
X-CSE-MsgGUID: ECc/jZ2+RkqNs8MMOse6RA==
X-Talos-CUID: 9a23:0LtZt2028F8yLlV4sDpAILxfJdk/THHR3VfqHgypKSVTRuaFQlW05/Yx
X-Talos-MUID: 9a23:QbfY4wXCu/bOb53q/BLHj3ZgBp0r2ae3LltdtLAhoMTaDwUlbg==
Received: from mail-yt3can01on2137.outbound.protection.outlook.com (HELO CAN01-YT3-obe.outbound.protection.outlook.com) ([40.107.115.137])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 17:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKcokYX98fBSaH+bZ7K1MbJ68rMyTLEkepVFd9ns2kwnu+mmKqVgD5mPlspdsMJ21KkYFZjjpQ6Wh3dq0nK3JFkpha5NRX4onNnMg2SPOseJZS2JTPya58+uKhmLUcSGqO4zQ+sKC25WyAcO8sb0Yesj2rnMRYaLSJ6gFazuMDUVUNiAQ8KztxaXwxBWk3GLqTchfl1AP1wUitJI4nDPvVP8VH96y770lLaW9ThTsehuvEzpXv+KAeZhdM9THhdrF9gqo26nFCG1XeMu+rr7ZBX7yeuOmk8dfv3r0gwFu4AAh8QjYvAxmGd2I+I/dd5aN4rOh86HfTslbdc1Q106TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r12AZmBltpJY3dd0gc90JRcI3UgdZB1NuErN1FL9h4=;
 b=dvK3VAWB7+Cwq/RWbCMybUAnQjueAyUQ6nn8CHFB+02EhIql0FEm9qaWEtPdMZM3ThMxdHNB44Ygi31bGbi9ZyTEYSr+Ev4j71sUaBmybAWadF9Zvzftv/Z2SMVG94WpAKy7ERxEbIxdy4th1SSyrqFHZ9Tx5IfkQ3qaphIgdOKkyTKX9y61myEbuH1LsHkHkdZ5P7u0yT6sXhKMjHgnuZ2bXoTNyLSSsvJzVUz/YHos9CKRwQmJ+EUIhZ26dr+kFoHVxLPmW8l6EqX6qTyhIl7LT4yxFvx+deQNpDvTGB2rWzF/mX4DBiLykexrNc+aQunqOR+7v9ON9FuHdwzz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB5950.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:5a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sat, 19 Jul
 2025 21:27:56 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.8943.028; Sat, 19 Jul 2025
 21:27:55 +0000
Message-ID: <69fa34b5-9396-427b-b2ef-ce49b28dde8e@uwaterloo.ca>
Date: Sat, 19 Jul 2025 17:27:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com, joe@dama.to
Cc: netdev@vger.kernel.org
References: <20250718232052.1266188-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250718232052.1266188-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: b69e29f9-7f33-4e8a-648c-08ddc70b202e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGlDeWU0bFQvR2tsV041NStKU25XZ2RUZVhjbWdpTUlrSEFkZjUySWh0OVhh?=
 =?utf-8?B?K0dtY0xycGRFMTNHWTIyb0lJRWtZYWZFaXdtWG53MUxwTnJQNktlSitwZGho?=
 =?utf-8?B?ZkwxcE16Q2tQMmJ3emY2UnlUMW12S2xibWFsY0MxL2hZbGkxY3MxZ2RTYU1r?=
 =?utf-8?B?TksvbzMrOWsrWnlUSnJHb0Q2NC9yOU1oblk2UzJXWk9ZeXljaXpZcTlhZ0hs?=
 =?utf-8?B?WDRCcVcxdGV5WktUblVKU3U3dTI3VnM3WFlCTTFpblRuamZUNUJKeVVGcDgx?=
 =?utf-8?B?SkVya2FPZk9ZOWFrZEVRZWtHcEEyWHFqWXRGL3dYMndoZkZPaHhKYXJSY01j?=
 =?utf-8?B?K0krZ3hrS04veFpoOHdYL2FIS0JPZnFEZG4yVUdIYzhCRWZnQ3p4WXZTOHF3?=
 =?utf-8?B?RmJWT0xMd1M5YjAzbGU3NElLanJzYXcxWHhXdDVDMEwwVGlrM2RLODFJYU9n?=
 =?utf-8?B?eDlIOVQ2SkpVNmtWMjNmUVhmL0MwOGpEQjhaTEJSR0FmcGhFZHg5M240Y2hh?=
 =?utf-8?B?aTdKellGZzRrYUhMclc4Z1NBNnVCNjBYUytHb2EwK2FISU53MjJ5cE9SQlNC?=
 =?utf-8?B?TzA5MkQ5b2xnZVo3d0J6ck03L0RGOUZqaDc1cEtCVTJlZ3JDL2lQU3FMK3hl?=
 =?utf-8?B?ZVZJTjJGekg1NHNGM1JkdzN4NkdFUDArNUJldFBBN2NvQTd2anhEcjZOazVh?=
 =?utf-8?B?TkF5OGlrZGs4cW9lR3dOQk1wdU01YVU1bVkrdENyQ0xkNHNVZW0zRGwzUW1x?=
 =?utf-8?B?Nk9NQzZ4ajdVbEJWM2F0WDE3ZEdDdkhqQmpGUFdQZHcvc0Y3RlA3QWY1b3Jj?=
 =?utf-8?B?TVJvQkFsc3pBdEwxRjVkTFo3VVQ2NFlLcGVjVi8wTG5GczZDWEREcFBVN1VJ?=
 =?utf-8?B?eGxXbTFUMjFJTmNKS2VJK2FGTVZPRExIOEduMGtnUU9HM3phUk9RMDlteTNr?=
 =?utf-8?B?cStrRFV4enEzNHpxWU1RRHFhTDY5QXBQVVludzZIVVB2aDFsZWREMlgvaFFV?=
 =?utf-8?B?MitNTElrSmlISHQrZElpWGxyRmlLQTRFdnVieHpxTmNqRmxFZmNZQlUrclpC?=
 =?utf-8?B?NTVUc1FrdXhBQ1NUY1RveDJRNXdUMnovcW84a1pYY0c3akxNVGdqekNEYUp4?=
 =?utf-8?B?SndUVVRkUmlISmxEb1phQ3JLT291emJBUUNISDYzVmNLU1QvM2lPUWdCd1ZH?=
 =?utf-8?B?dDhPU2YvRTRqaFJGR2xYZi95RGsxZEorQktkQmJJNGRNSVZVczJqN3NXNEFL?=
 =?utf-8?B?d0VwNHZtWEx6VVovbU1ROEpnYXNqSlYyUFZ1bm10ZVRuYWYvdm8wTXk1SXRl?=
 =?utf-8?B?UXZIMWFrbTE1c2ZXY3VKak9LRXQwb3ZERm96Q04vbnZZd0NGZzdyS1Nzd3lE?=
 =?utf-8?B?NXI0Vi9nNG5rQUlnVk00WWFJeUdDT2VUQ2NNeFdiNGViZEVEMmh2cDdIN0dY?=
 =?utf-8?B?Z3E5UGh0QUdCK1orak54QVNMOW0zL1lmdHdMN0N3cThRdWtnQWFSWHFyY1JI?=
 =?utf-8?B?MWVSdmZQMSttRFNnOFczbTk4Yy9IWHdwL1ZxVmJLSitqUVV6U3pjd0RSM3JT?=
 =?utf-8?B?UjhqckpxOXJLSzNUK3RQUUxBSHJBRE9COEtZTG9zYmVYekFSUnVWRGtsbm42?=
 =?utf-8?B?aTFxQzUvNjh3eUNKa2tNMWNsVTF6K0ozQVQwcTVXVllLY3BiSWRweTdYSVdv?=
 =?utf-8?B?ckswTDFMNUQ5a1lUSk0rSHdyY3dTNVRmZHVYRDZRekUwbC9nRjZVL2dIU2Zp?=
 =?utf-8?B?REVGZ2pmUUhSWkUxZVNmVjhlTTJGRU5tbld4QXhUQzkxRDBwU3ZDOGhiei9O?=
 =?utf-8?B?bU15SHdiU1ZkMXhQajdZM3I0d1N5QU9JUmRXQVpBc0RrOGswcE4rTE5zWSt0?=
 =?utf-8?B?dzVDdzVhVnRueDFBVzNCcTRlQ0hra2hKamFFckdvUXoybVVMQVluWlpZMjFB?=
 =?utf-8?Q?TKwSfLKu0Pk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHpBak0rUnorelk4VXNNeVE3MHdCaGVXNnpTWkoxa0xHUjJPTFFNM0lzYlZ4?=
 =?utf-8?B?Rkl3bmVDNHRsQ1pSOGM5SEdXQ1kzdGVsYU1oQTZ1MHBwUEhMcWErTVBvd1Zx?=
 =?utf-8?B?ZWZBOUdxSmRLR0E0UkpwK1UvWmE4SXp2U2lZVnhvcWxTVWVJZnl4bjd2a0Nr?=
 =?utf-8?B?anpsTmdpUkk4MnBXd2JNNjd0RmFYYmJzTmE1dUZwWmdpTGFlTjlLYytJNXFo?=
 =?utf-8?B?ZU1kdkljM29mQkVIZVluRy9UMWlUc2hMVTFVMFo3RVBPS2NkcTB0V0NnM1JB?=
 =?utf-8?B?Y0JKTDhiaDNpOFE5YmVweGFGcXhLSDk2VlYyaEhWczhkQVNHeGcxelZKRE5k?=
 =?utf-8?B?WXR0bkxsWWhiOVpaQ25xakUwTURyckZJUk91ZnJHOHlLUThsSThweTZScGdt?=
 =?utf-8?B?Z1VRbEkzb2tlak93dk5SQXl4WGEwODV1UWY1R0RMOEhKVFhtRXczdFVNNzc4?=
 =?utf-8?B?R3ZXaUMzc2E3L3phUHI3M1d5cFAxbXZobU9XWktsanJDN3ROM3dMU2hWbUla?=
 =?utf-8?B?Mk5CRTNJT2JYQkhabERET1hwMzhnZVJrTVNwRzd0WHRpTlhRcWFSQ09yWDJ3?=
 =?utf-8?B?Ukkvemg3UDBjQnFGSDk3SWliL2NVSFBvcm5MSHdMTlJDY0ZOU3ZpcUtxZGpG?=
 =?utf-8?B?TVpDRk5EbXhUdXN4Uy9SVHdDTGdzQzRMZERXSE9qZmk2VDRUTGE2dDBwaGZw?=
 =?utf-8?B?dzlWVEJRYnN4U0NYR1laTVE5dWg1ZURmRHNPbExPWmZCKzh6Z2Rxb3gwaSs1?=
 =?utf-8?B?Nmp6VkZnSHlBejdzZGFIVC9lbFBYQkQwUG05VVV6WEsvZHA4ZktaR0FxUkVK?=
 =?utf-8?B?eGlySWttMG5LZk5WaGRUTG1JMVlKb3VEckc5OFVZVm5kUDJ5aHgrYkltanF0?=
 =?utf-8?B?cEpkY05CMCtZWXFLMEZnaVpvWlR3K09WN2JtQ2N2ZGxGV2JuWTZxRkw4Ukpu?=
 =?utf-8?B?TWhwcS9HQlE1RktBc3BBaVp3NExPNjZyaXFhdWMxVVVLWExOM2dqdmVObzlS?=
 =?utf-8?B?VGtGaEF4UVY3Nkg0YWZkZC9PODJZVm1LZWg2UjlSd1NPaE44NGdyNnNJbndN?=
 =?utf-8?B?S2lJOGJKZ1VyR2FIRGE1c2kwU2I5MDNJa2JKMTJpTjNUektuUEo4em5LUnkz?=
 =?utf-8?B?Q1duNjhOWTI1Z2ZsQUswQlY3WmpqTkhLakplY1ZQQ2p5S1F3enlCbEZoMVpu?=
 =?utf-8?B?QlRKME9FRjVZVlgrZzVUUjBCRjA2ODhLTElRMytTZ1ZGSS9lVk5sUlJCbEN3?=
 =?utf-8?B?d3BONXNzZkM4cVd1ZkMxdXEvWE1kdGI5MTBRajRVdHpDUFdYWUNDeGYvblBU?=
 =?utf-8?B?V0FKL0daLzY3Vk9aS0RUYkJxMGlpZkJ2dUtnUjEvSW1may9UK1Rhc0pSNDdt?=
 =?utf-8?B?TXdYMkhxeFRpaksyL2VoTGl6TmUxMTlmREI4Y2NNWUw2eUxoMlNDSzZzNEdP?=
 =?utf-8?B?Qkw2OTFCcVZpSEdWMlZ2OTREQStKdmQ2U3RaczFpenY2dDk5dGMrT1RPSXQr?=
 =?utf-8?B?YkFPamluRXNwUjRhd2FZclg3ZStRMys0b0lSVWIzYmhoTVhGcyt6anIxRlE1?=
 =?utf-8?B?UEVqalNzRDFIWlI4ZEpzZzUzZmE5MEhUU1BSN2RnbWZ3eHJNVGhHWWRNZGpz?=
 =?utf-8?B?TTBicmZDZC9ZdUNoY2dydWpxaHdGamplOEpnalAxNC9zNnlGM3RhVWI2OTI2?=
 =?utf-8?B?SWNsMCtMaVY3cTNSOVBuajgrRlU2UkpoeDBZeVkwRzIveWdPOEFRZ2VxTGRE?=
 =?utf-8?B?cHZZTmtkT1d6LzYxd2pmTUFsd1l5M0lqQ2UvN25JZUJCK1dDRjlMQ05MYnFo?=
 =?utf-8?B?Ly9PUE5GRFZrQm1WQUpKZFVPeHF1ZkpXcWZjaEpXbFdkZDhPMUNKcjVYRDYy?=
 =?utf-8?B?SlJaZ0hjTUlxam9DQmlzZGdXamlEUGhPV1EzUlp6NEZVNXBtQkorUjRKVURW?=
 =?utf-8?B?bkEwOENBamtGRUpIZ1BuZmQ5ekRocHJmS3ZDSEovZjdMSld3K3hHcm8xMjhH?=
 =?utf-8?B?aGVEK1g1eWtTeEdxWDhyck9UcXNVUlN2R3lzdktZa3BMU1NscjdSL09FVTA1?=
 =?utf-8?B?KzFZY0xSMzEvRmxiMko4eWFZS0N6aUdrQllFSnFlckNtQ3JTYWt2VGRNdWRU?=
 =?utf-8?Q?OF4+qnvnhBPusnMATZ5iovyD3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o1/iuym7uDms4cjhK5W5umklkJ4lqM3svIssbpeovwuiu0gwZieG1boAG4UFiivSSH//Rd+01W/WWcoEpDzaQN/dDzeUfZViSdTNHtqp7D8ms1YpLsmINZpJE3dBUTV0epptLiS2E91iIW3cq7MSoyqzwYnJkSMzu4/oadkLbhTBD9AC6lBgkqG1WX9wvT2EBBCqF4nVgN099rwG2Q2ehFPDtAcP9rdJ/RN/uBkD0xfvBFL23LlhZv3SfPULSkGj5YGzMGIjO1wnBQPgtdu92UCsGYh9X9PscUHAJRD7tvmvY0+k6gNbOgZghhpzBobheHj0de+cHKvDK4eve9KJlwaxmR4P0+3le7BpdfgEdaLm2rtQigmKGaS+LwmRXkjVKzKE4SP0+trr8kkyO6ykfSdmQBZRdZ4rIe2S+G6hpV1rxMz0qIYr2LPnwW0ZjumjuoKndUfspvZpKExqIDzSu8/FTpa3AMPenDyoG18fSzWgRz4GBXPzGDD6vXwiT9sMxk8wHnQas2QTfKtlJZwOeNA7SX7xzuSNoMfXB2Rg3PHfBop+3m5pEcalUyuj2MlJ+21z5ue6n18NxCm5sVwpLBZf3OqtaPS5baCWdiysymdKmvCokAoLghYLnXRkkCj3
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b69e29f9-7f33-4e8a-648c-08ddc70b202e
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 21:27:55.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JffLv2MfhJWVNZ6ikuwzeN+qLD+DVqrKKU+VzN/WS8hntA+Q5jzKvp0lQO3Pr0pWCEVJrSyWiNyoq1BboiRHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5950

On 2025-07-18 19:20, Samiullah Khawaja wrote:

[snip]

> 
> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
> |---|---|---|---|---|
> | 12 Kpkt/s + 0us delay | | | | |
> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> | 32 Kpkt/s + 30us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> | 125 Kpkt/s + 6us delay | | | | |
> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> | 12 Kpkt/s + 78us delay | | | | |
> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> | 25 Kpkt/s + 38us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> 
>   ## Observations
> 
> - Here without application processing all the approaches give the same
>    latency within 1usecs range and NAPI threaded gives minimum latency.
> - With application processing the latency increases by 3-4usecs when
>    doing inline polling.
> - Using a dedicated core to drive napi polling keeps the latency same
>    even with application processing. This is observed both in userspace
>    and threaded napi (in kernel).
> - Using napi threaded polling in kernel gives lower latency by
>    1-1.5usecs as compared to userspace driven polling in separate core.
> - With application processing userspace will get the packet from recv
>    ring and spend some time doing application processing and then do napi
>    polling. While application processing is happening a dedicated core
>    doing napi polling can pull the packet of the NAPI RX queue and
>    populate the AF_XDP recv ring. This means that when the application
>    thread is done with application processing it has new packets ready to
>    recv and process in recv ring.
> - Napi threaded busy polling in the kernel with a dedicated core gives
>    the consistent P5-P99 latency.

Hi Samiullah.

I notice that you still present the experiments with application delay. 
I previously asked what these experiments represent, since it's highly 
unlikely that a latency-critical service would run at 100% load?

I also notice that you have not added any warning to the cover letter 
that explicitly spells out the trade-off between performance and efficiency.

However, most importantly, I am trying to rerun the experiments, but 
when running xsk_rr with threaded napi busy poll, networking locks up 
and the machine needs a hard reset to reboot. This is after applying 
your patches to commit c3886ccaadf8fdc2c91bfbdcdca36ccdc6ef8f70. I have 
tested with Intel E810-XXV-2 using the ice driver and Mellanox 
ConnectX-4 Lx using the mlx5 driver.

I am enclosing the various stack backtraces that I find in the logs.

Best,
Martin

**** ice ****

Jul 19 16:51:31 husky07 kernel: INFO: task systemd-network:542 blocked 
for more than 122 seconds.
Jul 19 16:51:31 husky07 kernel:       Tainted: G          I E 
6.16.0-rc5-test #1
Jul 19 16:51:31 husky07 kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 19 16:51:31 husky07 kernel: task:systemd-network state:D stack:0 
pid:542   tgid:542   ppid:1      task_flags:0x400100 flags:0x00004006
Jul 19 16:51:31 husky07 kernel: Call Trace:
Jul 19 16:51:31 husky07 kernel:  <TASK>
Jul 19 16:51:31 husky07 kernel:  __schedule+0x49b/0x1530
Jul 19 16:51:31 husky07 kernel:  schedule+0x27/0xf0
Jul 19 16:51:31 husky07 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  __mutex_lock.constprop.0+0x4c9/0x870
Jul 19 16:51:31 husky07 kernel:  ? __nla_validate_parse+0x5a/0xe30
Jul 19 16:51:31 husky07 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 19 16:51:31 husky07 kernel:  mutex_lock+0x3b/0x50
Jul 19 16:51:31 husky07 kernel:  rtnl_lock+0x15/0x20
Jul 19 16:51:31 husky07 kernel:  inet_rtm_newaddr+0x101/0x540
Jul 19 16:51:31 husky07 kernel:  ? __pfx_inet_rtm_newaddr+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv_msg+0x37e/0x450
Jul 19 16:51:31 husky07 kernel:  ? shmem_undo_range+0x283/0x850
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  netlink_rcv_skb+0x5c/0x110
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  netlink_unicast+0x282/0x3d0
Jul 19 16:51:31 husky07 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:51:31 husky07 kernel:  __sys_sendto+0x23d/0x250
Jul 19 16:51:31 husky07 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:51:31 husky07 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:51:31 husky07 kernel:  do_syscall_64+0x80/0x990
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? do_syscall_64+0x1be/0x990
Jul 19 16:51:31 husky07 kernel:  ? kmem_cache_free+0x43a/0x470
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:51:31 husky07 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:51:31 husky07 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? do_syscall_64+0x1be/0x990
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? do_syscall_64+0x1be/0x990
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:51:31 husky07 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:51:31 husky07 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? do_syscall_64+0x1be/0x990
Jul 19 16:51:31 husky07 kernel:  ? do_syscall_64+0x1be/0x990
Jul 19 16:51:31 husky07 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:51:31 husky07 kernel: RIP: 0033:0x7018b7b2c0a7
Jul 19 16:51:31 husky07 kernel: RSP: 002b:00007ffd470844a8 EFLAGS: 
00000202 ORIG_RAX: 000000000000002c
Jul 19 16:51:31 husky07 kernel: RAX: ffffffffffffffda RBX: 
000062ff08206d00 RCX: 00007018b7b2c0a7
Jul 19 16:51:31 husky07 kernel: RDX: 0000000000000044 RSI: 
000062ff08235ae0 RDI: 0000000000000003
Jul 19 16:51:31 husky07 kernel: RBP: 00007ffd47084540 R08: 
00007ffd470844b0 R09: 0000000000000080
Jul 19 16:51:31 husky07 kernel: R10: 0000000000000000 R11: 
0000000000000202 R12: 000062ff0823a0a0
Jul 19 16:51:31 husky07 kernel: R13: 000062ff082105b8 R14: 
0000000000000000 R15: 000062ff08210570
Jul 19 16:51:31 husky07 kernel:  </TASK>
Jul 19 16:51:31 husky07 kernel: INFO: task systemd-network:542 is 
blocked on a mutex likely owned by task xsk_rr:5912.
Jul 19 16:51:31 husky07 kernel: task:xsk_rr          state:D stack:0 
pid:5912  tgid:5912  ppid:5911   task_flags:0x400100 flags:0x00004006
Jul 19 16:51:31 husky07 kernel: Call Trace:
Jul 19 16:51:31 husky07 kernel:  <TASK>
Jul 19 16:51:31 husky07 kernel:  __schedule+0x49b/0x1530
Jul 19 16:51:31 husky07 kernel:  ? _raw_spin_unlock_irqrestore+0x21/0x60
Jul 19 16:51:31 husky07 kernel:  schedule+0x27/0xf0
Jul 19 16:51:31 husky07 kernel:  schedule_timeout+0x85/0x110
Jul 19 16:51:31 husky07 kernel:  ? __pfx_process_timeout+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  msleep+0x34/0x60
Jul 19 16:51:31 husky07 kernel:  napi_stop_kthread+0x78/0x80
Jul 19 16:51:31 husky07 kernel:  napi_set_threaded+0x33/0xc0
Jul 19 16:51:31 husky07 kernel:  napi_enable_locked+0xb5/0x250
Jul 19 16:51:31 husky07 kernel:  napi_enable+0x25/0x50
Jul 19 16:51:31 husky07 kernel:  ice_up_complete+0x91/0x260 [ice]
Jul 19 16:51:31 husky07 kernel:  ice_xdp+0x388/0x5d0 [ice]
Jul 19 16:51:31 husky07 kernel:  ? __pfx_ice_xdp+0x10/0x10 [ice]
Jul 19 16:51:31 husky07 kernel:  dev_xdp_install+0x157/0x320
Jul 19 16:51:31 husky07 kernel:  dev_xdp_attach+0x23f/0x9d0
Jul 19 16:51:31 husky07 kernel:  ? __bpf_prog_get+0x1f/0xf0
Jul 19 16:51:31 husky07 kernel:  dev_change_xdp_fd+0x164/0x210
Jul 19 16:51:31 husky07 kernel:  do_setlink.isra.0+0x110a/0x12c0
Jul 19 16:51:31 husky07 kernel:  ? get_page_from_freelist+0x167f/0x1bd0
Jul 19 16:51:31 husky07 kernel:  ? __nla_validate_parse+0x5a/0xe30
Jul 19 16:51:31 husky07 kernel:  ? ns_capable+0x2a/0x60
Jul 19 16:51:31 husky07 kernel:  rtnl_setlink+0x289/0x600
Jul 19 16:51:31 husky07 kernel:  ? security_capable+0x7c/0x1e0
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnl_setlink+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv_msg+0x37e/0x450
Jul 19 16:51:31 husky07 kernel:  ? kvfree+0x31/0x40
Jul 19 16:51:31 husky07 kernel:  ? map_update_elem+0x203/0x330
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  netlink_rcv_skb+0x5c/0x110
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  netlink_unicast+0x282/0x3d0
Jul 19 16:51:31 husky07 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:51:31 husky07 kernel:  __sys_sendto+0x23d/0x250
Jul 19 16:51:31 husky07 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:51:31 husky07 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:51:31 husky07 kernel:  do_syscall_64+0x80/0x990
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:51:31 husky07 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:51:31 husky07 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit_to_user_mode+0x167/0x270
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit+0x43/0x50
Jul 19 16:51:31 husky07 kernel:  ? exc_page_fault+0x90/0x1b0
Jul 19 16:51:31 husky07 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:51:31 husky07 kernel: RIP: 0033:0x73175152bead
Jul 19 16:51:31 husky07 kernel: RSP: 002b:00007ffd54363fa8 EFLAGS: 
00000246 ORIG_RAX: 000000000000002c
Jul 19 16:51:31 husky07 kernel: RAX: ffffffffffffffda RBX: 
0000000000000004 RCX: 000073175152bead
Jul 19 16:51:31 husky07 kernel: RDX: 0000000000000034 RSI: 
00007ffd54364030 RDI: 0000000000000008
Jul 19 16:51:31 husky07 kernel: RBP: 00007ffd54364000 R08: 
0000000000000000 R09: 0000000000000000
Jul 19 16:51:31 husky07 kernel: R10: 0000000000000000 R11: 
0000000000000246 R12: 0000000000000019
Jul 19 16:51:31 husky07 kernel: R13: 0000000000000000 R14: 
000063c753f8cd78 R15: 000073175187c000
Jul 19 16:51:31 husky07 kernel:  </TASK>
Jul 19 16:51:31 husky07 kernel: INFO: task kworker/u50:3:3472 blocked 
for more than 122 seconds.
Jul 19 16:51:31 husky07 kernel:       Tainted: G          I E 
6.16.0-rc5-test #1
Jul 19 16:51:31 husky07 kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 19 16:51:31 husky07 kernel: task:kworker/u50:3   state:D stack:0 
pid:3472  tgid:3472  ppid:2      task_flags:0x4208060 flags:0x00004000
Jul 19 16:51:31 husky07 kernel: Workqueue: events_unbound linkwatch_event
Jul 19 16:51:31 husky07 kernel: Call Trace:
Jul 19 16:51:31 husky07 kernel:  <TASK>
Jul 19 16:51:31 husky07 kernel:  __schedule+0x49b/0x1530
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:51:31 husky07 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_cpu+0x10/0x1e0
Jul 19 16:51:31 husky07 kernel:  schedule+0x27/0xf0
Jul 19 16:51:31 husky07 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  __mutex_lock.constprop.0+0x4c9/0x870
Jul 19 16:51:31 husky07 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 19 16:51:31 husky07 kernel:  mutex_lock+0x3b/0x50
Jul 19 16:51:31 husky07 kernel:  rtnl_lock+0x15/0x20
Jul 19 16:51:31 husky07 kernel:  linkwatch_event+0x12/0x40
Jul 19 16:51:31 husky07 kernel:  process_one_work+0x191/0x3e0
Jul 19 16:51:31 husky07 kernel:  worker_thread+0x2e3/0x420
Jul 19 16:51:31 husky07 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  kthread+0x10d/0x230
Jul 19 16:51:31 husky07 kernel:  ? __pfx_kthread+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  ret_from_fork+0x1d7/0x210
Jul 19 16:51:31 husky07 kernel:  ? __pfx_kthread+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 19 16:51:31 husky07 kernel:  </TASK>
Jul 19 16:51:31 husky07 kernel: INFO: task kworker/u50:3:3472 is blocked 
on a mutex likely owned by task xsk_rr:5912.
Jul 19 16:51:31 husky07 kernel: task:xsk_rr          state:D stack:0 
pid:5912  tgid:5912  ppid:5911   task_flags:0x400100 flags:0x00004006
Jul 19 16:51:31 husky07 kernel: Call Trace:
Jul 19 16:51:31 husky07 kernel:  <TASK>
Jul 19 16:51:31 husky07 kernel:  __schedule+0x49b/0x1530
Jul 19 16:51:31 husky07 kernel:  ? _raw_spin_unlock_irqrestore+0x21/0x60
Jul 19 16:51:31 husky07 kernel:  schedule+0x27/0xf0
Jul 19 16:51:31 husky07 kernel:  schedule_timeout+0x85/0x110
Jul 19 16:51:31 husky07 kernel:  ? __pfx_process_timeout+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  msleep+0x34/0x60
Jul 19 16:51:31 husky07 kernel:  napi_stop_kthread+0x78/0x80
Jul 19 16:51:31 husky07 kernel:  napi_set_threaded+0x33/0xc0
Jul 19 16:51:31 husky07 kernel:  napi_enable_locked+0xb5/0x250
Jul 19 16:51:31 husky07 kernel:  napi_enable+0x25/0x50
Jul 19 16:51:31 husky07 kernel:  ice_up_complete+0x91/0x260 [ice]
Jul 19 16:51:31 husky07 kernel:  ice_xdp+0x388/0x5d0 [ice]
Jul 19 16:51:31 husky07 kernel:  ? __pfx_ice_xdp+0x10/0x10 [ice]
Jul 19 16:51:31 husky07 kernel:  dev_xdp_install+0x157/0x320
Jul 19 16:51:31 husky07 kernel:  dev_xdp_attach+0x23f/0x9d0
Jul 19 16:51:31 husky07 kernel:  ? __bpf_prog_get+0x1f/0xf0
Jul 19 16:51:31 husky07 kernel:  dev_change_xdp_fd+0x164/0x210
Jul 19 16:51:31 husky07 kernel:  do_setlink.isra.0+0x110a/0x12c0
Jul 19 16:51:31 husky07 kernel:  ? get_page_from_freelist+0x167f/0x1bd0
Jul 19 16:51:31 husky07 kernel:  ? __nla_validate_parse+0x5a/0xe30
Jul 19 16:51:31 husky07 kernel:  ? ns_capable+0x2a/0x60
Jul 19 16:51:31 husky07 kernel:  rtnl_setlink+0x289/0x600
Jul 19 16:51:31 husky07 kernel:  ? security_capable+0x7c/0x1e0
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnl_setlink+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv_msg+0x37e/0x450
Jul 19 16:51:31 husky07 kernel:  ? kvfree+0x31/0x40
Jul 19 16:51:31 husky07 kernel:  ? map_update_elem+0x203/0x330
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  netlink_rcv_skb+0x5c/0x110
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  netlink_unicast+0x282/0x3d0
Jul 19 16:51:31 husky07 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:51:31 husky07 kernel:  __sys_sendto+0x23d/0x250
Jul 19 16:51:31 husky07 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:51:31 husky07 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:51:31 husky07 kernel:  do_syscall_64+0x80/0x990
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:51:31 husky07 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:51:31 husky07 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit_to_user_mode+0x167/0x270
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit+0x43/0x50
Jul 19 16:51:31 husky07 kernel:  ? exc_page_fault+0x90/0x1b0
Jul 19 16:51:31 husky07 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:51:31 husky07 kernel: RIP: 0033:0x73175152bead
Jul 19 16:51:31 husky07 kernel: RSP: 002b:00007ffd54363fa8 EFLAGS: 
00000246 ORIG_RAX: 000000000000002c
Jul 19 16:51:31 husky07 kernel: RAX: ffffffffffffffda RBX: 
0000000000000004 RCX: 000073175152bead
Jul 19 16:51:31 husky07 kernel: RDX: 0000000000000034 RSI: 
00007ffd54364030 RDI: 0000000000000008
Jul 19 16:51:31 husky07 kernel: RBP: 00007ffd54364000 R08: 
0000000000000000 R09: 0000000000000000
Jul 19 16:51:31 husky07 kernel: R10: 0000000000000000 R11: 
0000000000000246 R12: 0000000000000019
Jul 19 16:51:31 husky07 kernel: R13: 0000000000000000 R14: 
000063c753f8cd78 R15: 000073175187c000
Jul 19 16:51:31 husky07 kernel:  </TASK>
Jul 19 16:51:31 husky07 kernel: INFO: task sudo:5918 blocked for more 
than 122 seconds.
Jul 19 16:51:31 husky07 kernel:       Tainted: G          I E 
6.16.0-rc5-test #1
Jul 19 16:51:31 husky07 kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 19 16:51:31 husky07 kernel: task:sudo            state:D stack:0 
pid:5918  tgid:5918  ppid:5856   task_flags:0x400100 flags:0x00004006
Jul 19 16:51:31 husky07 kernel: Call Trace:
Jul 19 16:51:31 husky07 kernel:  <TASK>
Jul 19 16:51:31 husky07 kernel:  __schedule+0x49b/0x1530
Jul 19 16:51:31 husky07 kernel:  ? xa_load+0x6d/0xa0
Jul 19 16:51:31 husky07 kernel:  schedule+0x27/0xf0
Jul 19 16:51:31 husky07 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  __mutex_lock.constprop.0+0x4c9/0x870
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 19 16:51:31 husky07 kernel:  mutex_lock+0x3b/0x50
Jul 19 16:51:31 husky07 kernel:  rtnl_dumpit+0x83/0xc0
Jul 19 16:51:31 husky07 kernel:  netlink_dump+0x197/0x3c0
Jul 19 16:51:31 husky07 kernel:  ? obj_cgroup_charge_account+0x139/0x370
Jul 19 16:51:31 husky07 kernel:  __netlink_dump_start+0x204/0x340
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv_msg+0x2d6/0x450
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnl_dumpit+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  netlink_rcv_skb+0x5c/0x110
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  netlink_unicast+0x282/0x3d0
Jul 19 16:51:31 husky07 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:51:31 husky07 kernel:  __sys_sendto+0x23d/0x250
Jul 19 16:51:31 husky07 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:51:31 husky07 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:51:31 husky07 kernel:  do_syscall_64+0x80/0x990
Jul 19 16:51:31 husky07 kernel:  ? walk_system_ram_range+0xa8/0x110
Jul 19 16:51:31 husky07 kernel:  ? __pfx_pagerange_is_ram_callback+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  ? ___pte_offset_map+0x1c/0x1b0
Jul 19 16:51:31 husky07 kernel:  ? __pte_offset_map_lock+0xa2/0x120
Jul 19 16:51:31 husky07 kernel:  ? __get_locked_pte+0x3f/0x90
Jul 19 16:51:31 husky07 kernel:  ? insert_pfn+0xbb/0x220
Jul 19 16:51:31 husky07 kernel:  ? vmf_insert_pfn_prot+0x99/0x100
Jul 19 16:51:31 husky07 kernel:  ? vmf_insert_pfn+0x12/0x20
Jul 19 16:51:31 husky07 kernel:  ? vvar_fault+0xa1/0x110
Jul 19 16:51:31 husky07 kernel:  ? special_mapping_fault+0x21/0xd0
Jul 19 16:51:31 husky07 kernel:  ? __do_fault+0x3d/0x190
Jul 19 16:51:31 husky07 kernel:  ? do_fault+0x2d5/0x570
Jul 19 16:51:31 husky07 kernel:  ? __handle_mm_fault+0x838/0x1070
Jul 19 16:51:31 husky07 kernel:  ? security_task_setrlimit+0xa3/0x1b0
Jul 19 16:51:31 husky07 kernel:  ? do_prlimit+0x144/0x230
Jul 19 16:51:31 husky07 kernel:  ? count_memcg_events+0x180/0x200
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:51:31 husky07 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:51:31 husky07 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit_to_user_mode+0x167/0x270
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit+0x43/0x50
Jul 19 16:51:31 husky07 kernel:  ? exc_page_fault+0x90/0x1b0
Jul 19 16:51:31 husky07 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:51:31 husky07 kernel: RIP: 0033:0x7cb59032c0a7
Jul 19 16:51:31 husky07 kernel: RSP: 002b:00007ffcf07c2808 EFLAGS: 
00000202 ORIG_RAX: 000000000000002c
Jul 19 16:51:31 husky07 kernel: RAX: ffffffffffffffda RBX: 
00007ffcf07c2850 RCX: 00007cb59032c0a7
Jul 19 16:51:31 husky07 kernel: RDX: 0000000000000014 RSI: 
00007ffcf07c2890 RDI: 0000000000000003
Jul 19 16:51:31 husky07 kernel: RBP: 00007ffcf07c28e0 R08: 
00007ffcf07c2850 R09: 000000000000000c
Jul 19 16:51:31 husky07 kernel: R10: 0000000000000000 R11: 
0000000000000202 R12: 00007ffcf07c2980
Jul 19 16:51:31 husky07 kernel: R13: 00007ffcf07c2890 R14: 
00007ffcf07c29b0 R15: 00007ffcf07c2e58
Jul 19 16:51:31 husky07 kernel:  </TASK>
Jul 19 16:51:31 husky07 kernel: INFO: task sudo:5918 is blocked on a 
mutex likely owned by task xsk_rr:5912.
Jul 19 16:51:31 husky07 kernel: task:xsk_rr          state:D stack:0 
pid:5912  tgid:5912  ppid:5911   task_flags:0x400100 flags:0x00004006
Jul 19 16:51:31 husky07 kernel: Call Trace:
Jul 19 16:51:31 husky07 kernel:  <TASK>
Jul 19 16:51:31 husky07 kernel:  __schedule+0x49b/0x1530
Jul 19 16:51:31 husky07 kernel:  ? _raw_spin_unlock_irqrestore+0x21/0x60
Jul 19 16:51:31 husky07 kernel:  schedule+0x27/0xf0
Jul 19 16:51:31 husky07 kernel:  schedule_timeout+0x85/0x110
Jul 19 16:51:31 husky07 kernel:  ? __pfx_process_timeout+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  msleep+0x34/0x60
Jul 19 16:51:31 husky07 kernel:  napi_stop_kthread+0x78/0x80
Jul 19 16:51:31 husky07 kernel:  napi_set_threaded+0x33/0xc0
Jul 19 16:51:31 husky07 kernel:  napi_enable_locked+0xb5/0x250
Jul 19 16:51:31 husky07 kernel:  napi_enable+0x25/0x50
Jul 19 16:51:31 husky07 kernel:  ice_up_complete+0x91/0x260 [ice]
Jul 19 16:51:31 husky07 kernel:  ice_xdp+0x388/0x5d0 [ice]
Jul 19 16:51:31 husky07 kernel:  ? __pfx_ice_xdp+0x10/0x10 [ice]
Jul 19 16:51:31 husky07 kernel:  dev_xdp_install+0x157/0x320
Jul 19 16:51:31 husky07 kernel:  dev_xdp_attach+0x23f/0x9d0
Jul 19 16:51:31 husky07 kernel:  ? __bpf_prog_get+0x1f/0xf0
Jul 19 16:51:31 husky07 kernel:  dev_change_xdp_fd+0x164/0x210
Jul 19 16:51:31 husky07 kernel:  do_setlink.isra.0+0x110a/0x12c0
Jul 19 16:51:31 husky07 kernel:  ? get_page_from_freelist+0x167f/0x1bd0
Jul 19 16:51:31 husky07 kernel:  ? __nla_validate_parse+0x5a/0xe30
Jul 19 16:51:31 husky07 kernel:  ? ns_capable+0x2a/0x60
Jul 19 16:51:31 husky07 kernel:  rtnl_setlink+0x289/0x600
Jul 19 16:51:31 husky07 kernel:  ? security_capable+0x7c/0x1e0
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnl_setlink+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv_msg+0x37e/0x450
Jul 19 16:51:31 husky07 kernel:  ? kvfree+0x31/0x40
Jul 19 16:51:31 husky07 kernel:  ? map_update_elem+0x203/0x330
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:51:31 husky07 kernel:  netlink_rcv_skb+0x5c/0x110
Jul 19 16:51:31 husky07 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:51:31 husky07 kernel:  netlink_unicast+0x282/0x3d0
Jul 19 16:51:31 husky07 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:51:31 husky07 kernel:  __sys_sendto+0x23d/0x250
Jul 19 16:51:31 husky07 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:51:31 husky07 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:51:31 husky07 kernel:  do_syscall_64+0x80/0x990
Jul 19 16:51:31 husky07 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:51:31 husky07 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:51:31 husky07 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:51:31 husky07 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:51:31 husky07 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit_to_user_mode+0x167/0x270
Jul 19 16:51:31 husky07 kernel:  ? irqentry_exit+0x43/0x50
Jul 19 16:51:31 husky07 kernel:  ? exc_page_fault+0x90/0x1b0
Jul 19 16:51:31 husky07 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:51:31 husky07 kernel: RIP: 0033:0x73175152bead
Jul 19 16:51:31 husky07 kernel: RSP: 002b:00007ffd54363fa8 EFLAGS: 
00000246 ORIG_RAX: 000000000000002c
Jul 19 16:51:31 husky07 kernel: RAX: ffffffffffffffda RBX: 
0000000000000004 RCX: 000073175152bead
Jul 19 16:51:31 husky07 kernel: RDX: 0000000000000034 RSI: 
00007ffd54364030 RDI: 0000000000000008
Jul 19 16:51:31 husky07 kernel: RBP: 00007ffd54364000 R08: 
0000000000000000 R09: 0000000000000000
Jul 19 16:51:31 husky07 kernel: R10: 0000000000000000 R11: 
0000000000000246 R12: 0000000000000019
Jul 19 16:51:31 husky07 kernel: R13: 0000000000000000 R14: 
000063c753f8cd78 R15: 000073175187c000
Jul 19 16:51:31 husky07 kernel:  </TASK>

**** mlx5 ****

Jul 19 16:52:28 tilly02 kernel: INFO: task kworker/u129:1:255 blocked 
for more than 122 seconds.
Jul 19 16:52:28 tilly02 kernel:       Tainted: G          I E 
6.16.0-rc5-test #1
Jul 19 16:52:28 tilly02 kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 19 16:52:28 tilly02 kernel: task:kworker/u129:1  state:D stack:0 
pid:255   tgid:255   ppid:2      task_flags:0x4208060 flags:0x00004000
Jul 19 16:52:28 tilly02 kernel: Workqueue: events_unbound linkwatch_event
Jul 19 16:52:28 tilly02 kernel: Call Trace:
Jul 19 16:52:28 tilly02 kernel:  <TASK>
Jul 19 16:52:28 tilly02 kernel:  __schedule+0x493/0x1630
Jul 19 16:52:28 tilly02 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:52:28 tilly02 kernel:  ? sched_clock_cpu+0x10/0x1e0
Jul 19 16:52:28 tilly02 kernel:  schedule+0x27/0xf0
Jul 19 16:52:28 tilly02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 19 16:52:28 tilly02 kernel:  __mutex_lock.constprop.0+0x4c9/0x870
Jul 19 16:52:28 tilly02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 19 16:52:28 tilly02 kernel:  mutex_lock+0x3b/0x50
Jul 19 16:52:28 tilly02 kernel:  rtnl_lock+0x15/0x20
Jul 19 16:52:28 tilly02 kernel:  linkwatch_event+0x12/0x40
Jul 19 16:52:28 tilly02 kernel:  process_one_work+0x18e/0x3e0
Jul 19 16:52:28 tilly02 kernel:  worker_thread+0x2e3/0x420
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  kthread+0x10a/0x230
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  ret_from_fork+0x1d4/0x210
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 19 16:52:28 tilly02 kernel:  </TASK>
Jul 19 16:52:28 tilly02 kernel: INFO: task kworker/u129:1:255 is blocked 
on a mutex likely owned by task xsk_rr:1612.
Jul 19 16:52:28 tilly02 kernel: task:xsk_rr          state:D stack:0 
pid:1612  tgid:1612  ppid:1611   task_flags:0x400100 flags:0x00004002
Jul 19 16:52:28 tilly02 kernel: Call Trace:
Jul 19 16:52:28 tilly02 kernel:  <TASK>
Jul 19 16:52:28 tilly02 kernel:  __schedule+0x493/0x1630
Jul 19 16:52:28 tilly02 kernel:  schedule+0x27/0xf0
Jul 19 16:52:28 tilly02 kernel:  schedule_timeout+0x85/0x110
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_process_timeout+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  msleep+0x34/0x60
Jul 19 16:52:28 tilly02 kernel:  napi_stop_kthread+0x78/0x80
Jul 19 16:52:28 tilly02 kernel:  napi_set_threaded+0x33/0xc0
Jul 19 16:52:28 tilly02 kernel:  napi_enable_locked+0xb5/0x250
Jul 19 16:52:28 tilly02 kernel: 
mlx5e_activate_priv_channels+0x1bc/0x490 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_switch_priv_channels+0xeb/0x150 
[mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_safe_switch_params+0xef/0x140 
[mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_xdp_set+0xd0/0x220 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_mlx5e_xdp+0x10/0x10 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_xdp+0x47/0x60 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  dev_xdp_install+0x154/0x320
Jul 19 16:52:28 tilly02 kernel:  dev_xdp_attach+0x23f/0x9d0
Jul 19 16:52:28 tilly02 kernel:  ? __bpf_prog_get+0x1f/0xf0
Jul 19 16:52:28 tilly02 kernel:  dev_change_xdp_fd+0x164/0x210
Jul 19 16:52:28 tilly02 kernel:  do_setlink.isra.0+0x110a/0x12c0
Jul 19 16:52:28 tilly02 kernel:  ? __call_rcu_common+0x233/0x730
Jul 19 16:52:28 tilly02 kernel:  ? __rmqueue_pcplist+0x86e/0xed0
Jul 19 16:52:28 tilly02 kernel:  ? __nla_validate_parse+0x5a/0xe30
Jul 19 16:52:28 tilly02 kernel:  ? ns_capable+0x2a/0x60
Jul 19 16:52:28 tilly02 kernel:  rtnl_setlink+0x289/0x600
Jul 19 16:52:28 tilly02 kernel:  ? __memcg_slab_post_alloc_hook+0x1b0/0x3e0
Jul 19 16:52:28 tilly02 kernel:  ? security_capable+0x77/0x1c0
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnl_setlink+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  rtnetlink_rcv_msg+0x37b/0x450
Jul 19 16:52:28 tilly02 kernel:  ? bpf_map_kzalloc+0xd1/0x110
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  netlink_rcv_skb+0x59/0x110
Jul 19 16:52:28 tilly02 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:52:28 tilly02 kernel:  netlink_unicast+0x27f/0x3d0
Jul 19 16:52:28 tilly02 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:52:28 tilly02 kernel:  __sys_sendto+0x23a/0x250
Jul 19 16:52:28 tilly02 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:52:28 tilly02 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:52:28 tilly02 kernel:  do_syscall_64+0x80/0x9a0
Jul 19 16:52:28 tilly02 kernel:  ? vmf_insert_pfn_prot+0x99/0x100
Jul 19 16:52:28 tilly02 kernel:  ? vmf_insert_pfn+0x12/0x20
Jul 19 16:52:28 tilly02 kernel:  ? vvar_fault+0xa1/0x110
Jul 19 16:52:28 tilly02 kernel:  ? special_mapping_fault+0x1e/0xd0
Jul 19 16:52:28 tilly02 kernel:  ? __do_fault+0x3a/0x190
Jul 19 16:52:28 tilly02 kernel:  ? do_fault+0x2d5/0x570
Jul 19 16:52:28 tilly02 kernel:  ? __handle_mm_fault+0x838/0x1070
Jul 19 16:52:28 tilly02 kernel:  ? count_memcg_events+0x180/0x200
Jul 19 16:52:28 tilly02 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:52:28 tilly02 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:52:28 tilly02 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:52:28 tilly02 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:52:28 tilly02 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:52:28 tilly02 kernel:  ? irqentry_exit_to_user_mode+0x167/0x270
Jul 19 16:52:28 tilly02 kernel:  ? irqentry_exit+0x43/0x50
Jul 19 16:52:28 tilly02 kernel:  ? exc_page_fault+0x90/0x1b0
Jul 19 16:52:28 tilly02 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:52:28 tilly02 kernel: RIP: 0033:0x7e1395f2bead
Jul 19 16:52:28 tilly02 kernel: RSP: 002b:00007ffd2ac39398 EFLAGS: 
00000246 ORIG_RAX: 000000000000002c
Jul 19 16:52:28 tilly02 kernel: RAX: ffffffffffffffda RBX: 
0000000000000004 RCX: 00007e1395f2bead
Jul 19 16:52:28 tilly02 kernel: RDX: 0000000000000034 RSI: 
00007ffd2ac39420 RDI: 0000000000000008
Jul 19 16:52:28 tilly02 kernel: RBP: 00007ffd2ac393f0 R08: 
0000000000000000 R09: 0000000000000000
Jul 19 16:52:28 tilly02 kernel: R10: 0000000000000000 R11: 
0000000000000246 R12: 0000000000000019
Jul 19 16:52:28 tilly02 kernel: R13: 0000000000000000 R14: 
00006305503a1d78 R15: 00007e1396267000
Jul 19 16:52:28 tilly02 kernel:  </TASK>
Jul 19 16:52:28 tilly02 kernel: INFO: task sudo:1619 blocked for more 
than 122 seconds.
Jul 19 16:52:28 tilly02 kernel:       Tainted: G          I E 
6.16.0-rc5-test #1
Jul 19 16:52:28 tilly02 kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 19 16:52:28 tilly02 kernel: task:sudo            state:D stack:0 
pid:1619  tgid:1619  ppid:1544   task_flags:0x400100 flags:0x00004002
Jul 19 16:52:28 tilly02 kernel: Call Trace:
Jul 19 16:52:28 tilly02 kernel:  <TASK>
Jul 19 16:52:28 tilly02 kernel:  __schedule+0x493/0x1630
Jul 19 16:52:28 tilly02 kernel:  ? obj_cgroup_charge_account+0x139/0x370
Jul 19 16:52:28 tilly02 kernel:  schedule+0x27/0xf0
Jul 19 16:52:28 tilly02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 19 16:52:28 tilly02 kernel:  __mutex_lock.constprop.0+0x4c9/0x870
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 19 16:52:28 tilly02 kernel:  mutex_lock+0x3b/0x50
Jul 19 16:52:28 tilly02 kernel:  rtnl_dumpit+0x83/0xc0
Jul 19 16:52:28 tilly02 kernel:  netlink_dump+0x194/0x3c0
Jul 19 16:52:28 tilly02 kernel:  __netlink_dump_start+0x204/0x340
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  rtnetlink_rcv_msg+0x2d6/0x450
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnl_dumpit+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  netlink_rcv_skb+0x59/0x110
Jul 19 16:52:28 tilly02 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:52:28 tilly02 kernel:  netlink_unicast+0x27f/0x3d0
Jul 19 16:52:28 tilly02 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:52:28 tilly02 kernel:  __sys_sendto+0x23a/0x250
Jul 19 16:52:28 tilly02 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:52:28 tilly02 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:52:28 tilly02 kernel:  do_syscall_64+0x80/0x9a0
Jul 19 16:52:28 tilly02 kernel:  ? __pte_offset_map_lock+0xa2/0x120
Jul 19 16:52:28 tilly02 kernel:  ? __get_locked_pte+0x3f/0x90
Jul 19 16:52:28 tilly02 kernel:  ? insert_pfn+0xbb/0x220
Jul 19 16:52:28 tilly02 kernel:  ? vmf_insert_pfn_prot+0x99/0x100
Jul 19 16:52:28 tilly02 kernel:  ? vmf_insert_pfn+0x12/0x20
Jul 19 16:52:28 tilly02 kernel:  ? vvar_fault+0xa1/0x110
Jul 19 16:52:28 tilly02 kernel:  ? special_mapping_fault+0x1e/0xd0
Jul 19 16:52:28 tilly02 kernel:  ? __do_fault+0x3a/0x190
Jul 19 16:52:28 tilly02 kernel:  ? do_fault+0x2d5/0x570
Jul 19 16:52:28 tilly02 kernel:  ? __handle_mm_fault+0x838/0x1070
Jul 19 16:52:28 tilly02 kernel:  ? __do_sys_prlimit64+0x244/0x2e0
Jul 19 16:52:28 tilly02 kernel:  ? count_memcg_events+0x180/0x200
Jul 19 16:52:28 tilly02 kernel:  ? handle_mm_fault+0xbc/0x300
Jul 19 16:52:28 tilly02 kernel:  ? __ct_user_enter+0x2d/0x100
Jul 19 16:52:28 tilly02 kernel:  ? irqentry_exit_to_user_mode+0x167/0x270
Jul 19 16:52:28 tilly02 kernel:  ? irqentry_exit+0x43/0x50
Jul 19 16:52:28 tilly02 kernel:  ? exc_page_fault+0x90/0x1b0
Jul 19 16:52:28 tilly02 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:52:28 tilly02 kernel: RIP: 0033:0x75041712c0a7
Jul 19 16:52:28 tilly02 kernel: RSP: 002b:00007ffc92399938 EFLAGS: 
00000202 ORIG_RAX: 000000000000002c
Jul 19 16:52:28 tilly02 kernel: RAX: ffffffffffffffda RBX: 
00007ffc92399980 RCX: 000075041712c0a7
Jul 19 16:52:28 tilly02 kernel: RDX: 0000000000000014 RSI: 
00007ffc923999c0 RDI: 0000000000000003
Jul 19 16:52:28 tilly02 kernel: RBP: 00007ffc92399a10 R08: 
00007ffc92399980 R09: 000000000000000c
Jul 19 16:52:28 tilly02 kernel: R10: 0000000000000000 R11: 
0000000000000202 R12: 00007ffc92399ab0
Jul 19 16:52:28 tilly02 kernel: R13: 00007ffc923999c0 R14: 
00007ffc92399ae0 R15: 00007ffc92399f88
Jul 19 16:52:28 tilly02 kernel:  </TASK>
Jul 19 16:52:28 tilly02 kernel: INFO: task sudo:1619 is blocked on a 
mutex likely owned by task xsk_rr:1612.
Jul 19 16:52:28 tilly02 kernel: task:xsk_rr          state:D stack:0 
pid:1612  tgid:1612  ppid:1611   task_flags:0x400100 flags:0x00004002
Jul 19 16:52:28 tilly02 kernel: Call Trace:
Jul 19 16:52:28 tilly02 kernel:  <TASK>
Jul 19 16:52:28 tilly02 kernel:  __schedule+0x493/0x1630
Jul 19 16:52:28 tilly02 kernel:  schedule+0x27/0xf0
Jul 19 16:52:28 tilly02 kernel:  schedule_timeout+0x85/0x110
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_process_timeout+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  msleep+0x34/0x60
Jul 19 16:52:28 tilly02 kernel:  napi_stop_kthread+0x78/0x80
Jul 19 16:52:28 tilly02 kernel:  napi_set_threaded+0x33/0xc0
Jul 19 16:52:28 tilly02 kernel:  napi_enable_locked+0xb5/0x250
Jul 19 16:52:28 tilly02 kernel: 
mlx5e_activate_priv_channels+0x1bc/0x490 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_switch_priv_channels+0xeb/0x150 
[mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_safe_switch_params+0xef/0x140 
[mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_xdp_set+0xd0/0x220 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_mlx5e_xdp+0x10/0x10 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  mlx5e_xdp+0x47/0x60 [mlx5_core]
Jul 19 16:52:28 tilly02 kernel:  dev_xdp_install+0x154/0x320
Jul 19 16:52:28 tilly02 kernel:  dev_xdp_attach+0x23f/0x9d0
Jul 19 16:52:28 tilly02 kernel:  ? __bpf_prog_get+0x1f/0xf0
Jul 19 16:52:28 tilly02 kernel:  dev_change_xdp_fd+0x164/0x210
Jul 19 16:52:28 tilly02 kernel:  do_setlink.isra.0+0x110a/0x12c0
Jul 19 16:52:28 tilly02 kernel:  ? __call_rcu_common+0x233/0x730
Jul 19 16:52:28 tilly02 kernel:  ? __rmqueue_pcplist+0x86e/0xed0
Jul 19 16:52:28 tilly02 kernel:  ? __nla_validate_parse+0x5a/0xe30
Jul 19 16:52:28 tilly02 kernel:  ? ns_capable+0x2a/0x60
Jul 19 16:52:28 tilly02 kernel:  rtnl_setlink+0x289/0x600
Jul 19 16:52:28 tilly02 kernel:  ? __memcg_slab_post_alloc_hook+0x1b0/0x3e0
Jul 19 16:52:28 tilly02 kernel:  ? security_capable+0x77/0x1c0
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnl_setlink+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  rtnetlink_rcv_msg+0x37b/0x450
Jul 19 16:52:28 tilly02 kernel:  ? bpf_map_kzalloc+0xd1/0x110
Jul 19 16:52:28 tilly02 kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Jul 19 16:52:28 tilly02 kernel:  netlink_rcv_skb+0x59/0x110
Jul 19 16:52:28 tilly02 kernel:  rtnetlink_rcv+0x15/0x30
Jul 19 16:52:28 tilly02 kernel:  netlink_unicast+0x27f/0x3d0
Jul 19 16:52:28 tilly02 kernel:  netlink_sendmsg+0x214/0x470
Jul 19 16:52:28 tilly02 kernel:  __sys_sendto+0x23a/0x250
Jul 19 16:52:28 tilly02 kernel:  __x64_sys_sendto+0x24/0x40
Jul 19 16:52:28 tilly02 kernel:  x64_sys_call+0x1c32/0x2660
Jul 19 16:52:28 tilly02 kernel:  do_syscall_64+0x80/0x9a0
Jul 19 16:52:28 tilly02 kernel:  ? vmf_insert_pfn_prot+0x99/0x100
Jul 19 16:52:28 tilly02 kernel:  ? vmf_insert_pfn+0x12/0x20
Jul 19 16:52:28 tilly02 kernel:  ? vvar_fault+0xa1/0x110
Jul 19 16:52:28 tilly02 kernel:  ? special_mapping_fault+0x1e/0xd0
Jul 19 16:52:28 tilly02 kernel:  ? __do_fault+0x3a/0x190
Jul 19 16:52:28 tilly02 kernel:  ? do_fault+0x2d5/0x570
Jul 19 16:52:28 tilly02 kernel:  ? __handle_mm_fault+0x838/0x1070
Jul 19 16:52:28 tilly02 kernel:  ? count_memcg_events+0x180/0x200
Jul 19 16:52:28 tilly02 kernel:  ? sched_clock_noinstr+0x9/0x10
Jul 19 16:52:28 tilly02 kernel:  ? sched_clock+0x10/0x30
Jul 19 16:52:28 tilly02 kernel:  ? get_vtime_delta+0x14/0xc0
Jul 19 16:52:28 tilly02 kernel:  ? ct_kernel_exit.isra.0+0x84/0xb0
Jul 19 16:52:28 tilly02 kernel:  ? __ct_user_enter+0x72/0x100
Jul 19 16:52:28 tilly02 kernel:  ? irqentry_exit_to_user_mode+0x167/0x270
Jul 19 16:52:28 tilly02 kernel:  ? irqentry_exit+0x43/0x50
Jul 19 16:52:28 tilly02 kernel:  ? exc_page_fault+0x90/0x1b0
Jul 19 16:52:28 tilly02 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jul 19 16:52:28 tilly02 kernel: RIP: 0033:0x7e1395f2bead
Jul 19 16:52:28 tilly02 kernel: RSP: 002b:00007ffd2ac39398 EFLAGS: 
00000246 ORIG_RAX: 000000000000002c
Jul 19 16:52:28 tilly02 kernel: RAX: ffffffffffffffda RBX: 
0000000000000004 RCX: 00007e1395f2bead
Jul 19 16:52:28 tilly02 kernel: RDX: 0000000000000034 RSI: 
00007ffd2ac39420 RDI: 0000000000000008
Jul 19 16:52:28 tilly02 kernel: RBP: 00007ffd2ac393f0 R08: 
0000000000000000 R09: 0000000000000000
Jul 19 16:52:28 tilly02 kernel: R10: 0000000000000000 R11: 
0000000000000246 R12: 0000000000000019
Jul 19 16:52:28 tilly02 kernel: R13: 0000000000000000 R14: 
00006305503a1d78 R15: 00007e1396267000
Jul 19 16:52:28 tilly02 kernel:  </TASK>

> Following histogram is generated to measure the time spent in recvfrom
> while using inline thread with SO_BUSYPOLL. The histogram is generated
> using the following bpftrace command. In this experiment there are 32K
> packets per second and the application processing delay is 30usecs. This
> is to measure whether there is significant time spent pulling packets
> from the descriptor queue that it will affect the overall latency if
> done inline.
> 
> ```
> bpftrace -e '
>          kprobe:xsk_recvmsg {
>                  @start[tid] = nsecs;
>          }
>          kretprobe:xsk_recvmsg {
>                  if (@start[tid]) {
>                          $sample = (nsecs - @start[tid]);
>                          @xsk_recvfrom_hist = hist($sample);
>                          delete(@start[tid]);
>                  }
>          }
>          END { clear(@start);}'
> ```
> 
> Here in case of inline busypolling around 35 percent of calls are taking
> 1-2usecs and around 50 percent are taking 0.5-2usecs.
> 
> @xsk_recvfrom_hist:
> [128, 256)         24073 |@@@@@@@@@@@@@@@@@@@@@@                              |
> [256, 512)         55633 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [512, 1K)          20974 |@@@@@@@@@@@@@@@@@@@                                 |
> [1K, 2K)           34234 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     |
> [2K, 4K)            3266 |@@@                                                 |
> [4K, 8K)              19 |                                                    |
> 
> v6:
>   - Moved threaded in struct netdevice up to fill the cacheline hole.
>   - Changed dev_set_threaded to dev_set_threaded_hint and removed the
>     second argument that was always set to true by all the drivers.
>     Exported only dev_set_threaded_hint and made dev_set_threaded core
>     only function. This change is done in a separate commit.
>   - Updated documentation comment for threaded in struct netdevice.
>   - gro_flush_helper renamed to gro_flush_normal and moved to gro.h. Also
>     used it in kernel/bpf/cpumap.c
>   - Updated documentation to explicitly state that the NAPI threaded busy
>     polling would keep the CPU core busy at 100% usage.
>   - Updated documentation and commit messages.
> 
> v5:
>   - Updated experiment data with 'SO_PREFER_BUSY_POLL' usage as
>     suggested.
>   - Sent 'Add support to set napi threaded for individual napi'
>     separately. This series depends on top of that patch.
>     https://lore.kernel.org/netdev/20250423201413.1564527-1-skhawaja@google.com/
>   - Added a separate patch to use enum for napi threaded state. Updated
>     the nl_netdev python test.
>   - Using "write all" semantics when napi settings set at device level.
>     This aligns with already existing behaviour for other settings.
>   - Fix comments to make them kdoc compatible.
>   - Updated Documentation/networking/net_cachelines/net_device.rst
>   - Updated the missed gro_flush modification in napi_complete_done
> 
> v4:
>   - Using AF_XDP based benchmark for experiments.
>   - Re-enable dev level napi threaded busypoll after soft reset.
> 
> v3:
>   - Fixed calls to dev_set_threaded in drivers
> 
> v2:
>   - Add documentation in napi.rst.
>   - Provide experiment data and usecase details.
>   - Update busy_poller selftest to include napi threaded poll testcase.
>   - Define threaded mode enum in netlink interface.
>   - Included NAPI threaded state in napi config to save/restore.
> 
> Samiullah Khawaja (5):
>    net: Create separate gro_flush_normal function
>    net: Use dev_set_threaded_hint instead of dev_set_threaded in drivers
>    net: define an enum for the napi threaded state
>    Extend napi threaded polling to allow kthread based busy polling
>    selftests: Add napi threaded busy poll test in `busy_poller`
> 
>   Documentation/ABI/testing/sysfs-class-net     |  3 +-
>   Documentation/netlink/specs/netdev.yaml       | 14 ++-
>   Documentation/networking/napi.rst             | 63 +++++++++++-
>   .../networking/net_cachelines/net_device.rst  |  2 +-
>   .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
>   drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
>   drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
>   drivers/net/wireguard/device.c                |  2 +-
>   drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
>   drivers/net/wireless/mediatek/mt76/debugfs.c  |  2 +-
>   include/linux/netdevice.h                     | 18 +++-
>   include/net/gro.h                             |  6 ++
>   include/uapi/linux/netdev.h                   |  6 ++
>   kernel/bpf/cpumap.c                           |  3 +-
>   net/core/dev.c                                | 97 +++++++++++++++----
>   net/core/dev.h                                | 16 ++-
>   net/core/net-sysfs.c                          |  2 +-
>   net/core/netdev-genl-gen.c                    |  2 +-
>   net/core/netdev-genl.c                        |  2 +-
>   tools/include/uapi/linux/netdev.h             |  6 ++
>   tools/testing/selftests/net/busy_poll_test.sh | 25 ++++-
>   tools/testing/selftests/net/busy_poller.c     | 14 ++-
>   tools/testing/selftests/net/nl_netdev.py      | 36 +++----
>   23 files changed, 257 insertions(+), 70 deletions(-)
> 
> 
> base-commit: c3886ccaadf8fdc2c91bfbdcdca36ccdc6ef8f70


