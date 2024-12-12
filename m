Return-Path: <netdev+bounces-151307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFEA9EDF8E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611C8188AA03
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A21204C36;
	Thu, 12 Dec 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="le6+GAsT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA32204C21
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985512; cv=fail; b=j34HtFw5JZjd+x/2RMNiai6wKPnP3Cc8V7FbnZfKT5M3b8Y++gbaSS9RT1lBk4r0RJBubIy86yUY7LAEA4ZMwmekKoKUr26K4Hzd5464aLX+U5+r+2vb8N/28QiP3KLHsScWnyYG2Qo6QB7ugGbBOojYp5kHCHcgIrpTGt0KkRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985512; c=relaxed/simple;
	bh=lBCis9IgmEcixTkGvMpJ5Y1FN0HeFXS/uLKG5dBuUNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fs8Kz/h9TabsiwKFmTbwL2NnvqpkaxztO6WeNxYV8LGKM7nb0w1Cev/6e7P+Z9oK/uXTKCTE9AiX52l+Zox5w0j6LF+1lNG0XJWW3kfet7YdQO804mbLvEUGifPO0cKb0MzPd6vtF2rsL2Oi6IG2YXbZrexDX8BtewHtbWjF0Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=le6+GAsT; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGNjGjIMeg5+Rfsr57VKAoux7oT9OkOmKmEENub6zayGdHqOGwBBpbw3mGhRk8ZIZHLAOihYCt+9+H7flmg1heQNngqBMRx56FJMQfTbUcyIAcnGHzTnzh/4ErYMgG+lKStK5OZjSRqje1psZaTl+ELb2B1z53klK9eobymA4X2VlubB1QtJPVwc0dZjrjAHMF+1+eJv5W2AWfsCN2seWn0OxHmrd5J/BCfVA/hkIGpLXy93AxSwvn4mo6v5WFHHXSDkFeQ/5HcZZaYq8vScqzdHp3l2iQTS/utURwa+h6GKr2IVl5D+GlIpswcYwYG6dMTq/XteoIjeiJDuiXdJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBCis9IgmEcixTkGvMpJ5Y1FN0HeFXS/uLKG5dBuUNM=;
 b=CPhG0SJjnHBm/DygWmrQisUjzemA3Fppb8sABjT51nMDSolSv28j4x1JO9+OKBFd2pL1nPtW1FQC70ZHB72f7pAK5Xn5Bdj4IZlBWBeQTqk6TfXwtEiSP8wzMumHsFiUgFbfigiZl/JRWcVRASDrPu6Iy+YTFV3JWtEuwEKESWwCNlgBe2aiOn6kBfBGVXt/Ds+7KLjhzoJSXUTbMtGicbL/uJEmasEXJQAdbs9a9nQctJnx0WCORqai9lPoose1mFvS2sH6+VlGIVvOLBi07E7ljIwSLmW8hxWO5Ah/wLmHKKR40tmq5g/kXOZ9IYJxmSj1IVyKK09YsN4AGqDguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBCis9IgmEcixTkGvMpJ5Y1FN0HeFXS/uLKG5dBuUNM=;
 b=le6+GAsT6A6gv4YtMn2R4HF98JYyhvWQPfdiiITv1VBDyuh2NpBEwUwczokehEzjdLt0lRDza3cU+JoNbgrdvbNnVLXY6SfmskEXjVm0Yq4o0i40WON7fWHvV8jI4pN3xFy+qMD4k9gmiL+xxVmF6Limz7pCAS0Kwbt6bMzs8cMpE3y0ApyRy1eYporzP72fdrVgDjI1KloUX+r9TF+2eMosJ2X+0cvhTp8BnHQRDPmO295TZ/Ki/ERG/M5rx2AOsbKSScIvjSV+3qT3R5ixayf+INSQVr24cpXGzlh0EC7unJ3GJd2BUUMai2++0ouRemsouKxeUfzuMzgHtawhOA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 06:38:27 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%2]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 06:38:26 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
Subject: RE: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Topic: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Index:
 AQHbHz7DQv+I+3IfGkOF2TEcLZxABLKPd+pQgAHPmYCACQ73QIAuaH6AgAJJKNCAAGFwgIABVcQggBTmQACAANtR8A==
Date: Thu, 12 Dec 2024 06:38:25 +0000
Message-ID:
 <DM6PR12MB4516F7998D67014D9835C5F5D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
 <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
 <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
 <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
In-Reply-To: <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH7PR12MB7427:EE_
x-ms-office365-filtering-correlation-id: b5137dc9-33fd-4d48-8a63-08dd1a779511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TS9sY21zQnlMczVQU1JRQkZKK2ZhbnZHOFlnMkxlVzdXSDNKeXZDL0NYS2pW?=
 =?utf-8?B?SGI5Z2gwK2hCOXpMSXRHVUxVSE1RM0kwR0pXcmhDQ3MxVDl5b3dYRHR1SXM3?=
 =?utf-8?B?bE11ZUFWZllDUGYxaTZOMEVmNmdvVmNoUyttelMzREFHbFVzWVpraEtDU0J5?=
 =?utf-8?B?eTBHb1M3Wk9qZk1wbnFmYnRrcXB6VmU2Y0lNSmw1K0hTSk5XcktibExKbHQ1?=
 =?utf-8?B?NmU4eEFBK3VjMFE1Z09JQitsbU9EOXRPdUZFcllGeVVGOGRvUjd4ajRqbSs5?=
 =?utf-8?B?TXJjaWZXM1NNM3ZyeWhlRlhIQTFKa1lWY0hZbklvUnY4ejZidm9WTHJ5MTZP?=
 =?utf-8?B?bjRmcEFyTXdpaXhSN3ZiMW9YODd5V3ZVVmhjS0p4S1hIYndxRy85K1NoTUdK?=
 =?utf-8?B?UU1jU3dFSS8rcE9zMWZhMVE4ZzBTTmVJbktVMy9wR0F5NHhOSFRCa0xRVU5o?=
 =?utf-8?B?b3Jhanh1VnowUzEzV1dGUmFKRXFNWjdqWmVtTmdGWDdTQUtxSWhPcjYzaWp3?=
 =?utf-8?B?TS8yb2o5a0F2a2JXNUIvQ2NnVXRWTjlFeEdNaUZqSEpZNjErNWdSM2dMa1Fx?=
 =?utf-8?B?Z1lZSzBCY3lPd1g1MFJ5S091ZWNTZ3ZyajkzUVdVdzh5ZkhrbHE2ZDBURWlE?=
 =?utf-8?B?V00zZENUV01SalZWYzhkdjE5VVllSGpQcm02UkVGeUYvTmZLek1qY1JqVHJ0?=
 =?utf-8?B?RnNwZ0I0eUl4SC8wNU4rVFZJcXBFUk1HSlJrWHpTMHhOUXpsSklUQnloeTV2?=
 =?utf-8?B?THYyYmFTdVRoZHVkS3llQmZwZ3FPdWJpRkp5d2xTQ1hPM1B4bmJ0aFR6b0c4?=
 =?utf-8?B?NFFSdmxVUWZ4VG45NFJTZitZanJmdGJRVTc2blgwVmxxd2NTM1BTOFJ0NlZC?=
 =?utf-8?B?VjVBR1U4cEZ6akF0TzdxaG4xcE9yR1JPOFZWWWFZWCtuc1F0VC8vaGh6RWpX?=
 =?utf-8?B?dnB0QkdtSHVNL1kxV2R4QWp0R0RWalZRMDI3V1p1MUIvakRwaG5jaHdCQ3kr?=
 =?utf-8?B?Zjg1bU94Yk1JUW9DSSttV2NyMElnazZJYUlyakhoM0tvVmc3VlB1T0VFNVFm?=
 =?utf-8?B?NENVMngvQnFHSzc2VkU4NDVzdVdOVE1VSFlmWHA1UTJBaWwybTBEVVB1RGJh?=
 =?utf-8?B?dnY2T0xpQXNsU2Z4cWNNaU56OXZnVjk4dmZMbS9oc3kzRE9aNGhGcHBJMFNj?=
 =?utf-8?B?MHBFZllOZzhNK21WMkFvTE9hR3BrWTdhbkp0VmxZVUF5aHZwWDJKYmdrTHRi?=
 =?utf-8?B?dXlnOFVsc2kvL3c3RGJmV0JSY01tWE0xRWh6Q2t4WlFzS3pHbjFZdXNTQTky?=
 =?utf-8?B?SHRIR0VheTVCckJzT2lka1lsTnJMc0FZTGJUNURHK2hYNHJSQTFudFNYQTNQ?=
 =?utf-8?B?ejYxNzNaYm8rN1dXRk1QNWJHeFkrZ2lhLzl2ZHdtdGpjNXc1RXlEZW9ScXFN?=
 =?utf-8?B?MnNyTEpGTUxhME1wUGRyd2JKQWtSTWE3d1kvN1JMOThHSi9XWFB4VWg0V2d6?=
 =?utf-8?B?UXA3d2NqMW1UVTZ3bU5XdkxTZi80RSt5RFQ3S1FmU1JXQ1lrTlBvcHptNWtP?=
 =?utf-8?B?MnF0SjljYnJnWk5DL0ZNTVQxV3RrMUEvU0JONE5UY2JqWnp6WDRNRGFUQVFO?=
 =?utf-8?B?ai9ielVSYUxIc2t3Qit1b0kwbVVIeGtkcnVFMlFVRXduT09nWTk3QkptM2li?=
 =?utf-8?B?T2pVTEtQdTN0V00vWTg2bUo0UXRaOFRWWitIWVZHaklPdVZNeDd2QjB0SjQw?=
 =?utf-8?B?VFREdm1DYkhiUG01OWoyVC9tTUVhdmtab3F4NE5tOElQOWtBckxpZHJ1UDk0?=
 =?utf-8?B?WWtBYkExM3VNZEZiSFp6VUFSTjNpUjVXNUEzcTJXUGc5eXhYNGVUV3dtQm5k?=
 =?utf-8?B?ZmJjM2FlZStaTlJuakNpUlA3dG5jcGtCWjBmbzFoTWhtZ2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVRwb2xIczBaWFY1T1lIRm1PMFdpbFJQTHZtTldQem45czh0QzltM3BGZ2FC?=
 =?utf-8?B?OGJwcE9mc29aN0tDOGErREFyaWpaTzFXUnJ4ZU9velJXSVB1RWRlL0VHcHFi?=
 =?utf-8?B?ejZXcFc1S0xHdHVFaGhwT0ptOU9SdGtUb05wSUViMitVTmlaL0pRdUJTNGhD?=
 =?utf-8?B?ZklpUTI0ZTBKMFdzc0doMTRFN1lEQ0N0cURxZ3NJOCtCUWpHa1JIQUxJZWlj?=
 =?utf-8?B?UWxaQTVOZmxMbmxuQnpoVjg0U2xWK080VFQ5ZUM4c0c1bGduUHVJa1psenNL?=
 =?utf-8?B?OGZZTTNDeC8reStxOGcxbFNaZlpOaCtNOXlQV1pqSjdOSmw2L3RoUmN3WjBH?=
 =?utf-8?B?M2RiMXVqOUYzbDQ3QVlHN1ZuOWhvWjl1WDRDTnJWT0U3OXhVUFB2M0tLT1JC?=
 =?utf-8?B?K3FyR1lndDlLd0RnVFRKWHZPV2xuaVMvNWdkMXBSUHpsem9CWjBWM1pmcjl1?=
 =?utf-8?B?OWx1Qm0rMUxHcXQ5eHp1Z1BrWVFGZktkWnR6am5kMEZqa3RMRGxzU3hlNi9q?=
 =?utf-8?B?ejZoMzRUT256cjhDdy80cjVqa2hBSStXTWlKMzM3bkFPY3FZZm5BOTAwWExH?=
 =?utf-8?B?enF1N1hMUWM2Ymg3WEpuRjdFTG5MUXNmajNYazJsWXVMMTRXalNmVTB2dUlk?=
 =?utf-8?B?Ry9Ed09yNzVsSGdwK3d3UnFNNGQxUEt2d01EbG50dDdYT2RPMjJmSTc5ck1V?=
 =?utf-8?B?cHhDdzZoeW02Z1ovY3JiL2RSRy83STNWaFhucC9kbjZwWnc5N1FlQVdsWmFK?=
 =?utf-8?B?WVh2VCt4eVg0cUhxdHNnNnI3ZU9nVjBXQWFTWloyd2piMkp1cW5CYVM1Zzll?=
 =?utf-8?B?RGlIUGtPdVlna0MvM2RXSDFTNUxJQUZnb3JISVZFV2VzYllUd21RL2J5OUtW?=
 =?utf-8?B?SFBHemhDZVBicldSZjVmZEtmQnNsTEtIUEdkU1ZTV2swTGJVcHkxZmw2TzVn?=
 =?utf-8?B?N3Faa3NucHViTmgvMndtcTRoS0FLUjlqNjNLakE1WVphamUyZ0pINGRUbUFz?=
 =?utf-8?B?b0J1ditCMFk3OWdrRTNUR0dXSmlWbDBHQnE5eU1UaHNmZmk3ZmlUMGdkTmQv?=
 =?utf-8?B?eG1mMHA0bFY5aUtQNThpdk5Bbk54d0wybVFFaGhKUUs5ZVdBSjVoU2hqUWx5?=
 =?utf-8?B?eE90RDkvcThEK2grR1dXQjZzVk1mMVRsY0RBVDFIcXM0VEx6amMxbzdVa0Vu?=
 =?utf-8?B?Y0VpbStuWEN2M2dyUllQN21kWkZFU2cwY0ljZUJzTm4yQjgrOUNpM01ucC9z?=
 =?utf-8?B?NU1yV2F5TjA5dFltaEtXUmI2K1JKMWJEZUZlWkFXY0FhK0hlMEI4emY4TjVw?=
 =?utf-8?B?emlpZVFLdGF2UEs5Q1UxZEkyNzQrdUFyMWNWRjJueFVYSy9YaUZJWGQ2TUpo?=
 =?utf-8?B?dTBZSlBMZHRlNnVkWU52TXBZYktmSDNScmxTcllieUFRdWZkQWRRbkdSUEl1?=
 =?utf-8?B?dGlrSmEycWd0RXlNOGx1YlZmNHdUWDk4ZExKVVBVTDJHQVJtckhjYVBmWWpY?=
 =?utf-8?B?endUUEl5SzF1R1A4ZnFXclhYVDlta1BLL085UHQvOWVkd2hXT3pDdE0rMVhV?=
 =?utf-8?B?cHNXYklFWlhwMjJPRkZNKzFiM1NnRnZzWk1OV05TcEhxcmJhR0piMDZpVU45?=
 =?utf-8?B?YUJGSTNlUGtnRDZrK2tsRGYrTmlqK3Z6NHBGSGNJQ1JITU9pUkw1bk9WV2gy?=
 =?utf-8?B?WVpzUi90S1liZVQxSnBrVVFSUlY0a3B4MDFaQ2dQQzgwTjdxTC81VTY4Q1ow?=
 =?utf-8?B?S0IwVzhuRzAwb2lhc3Vqa1ZGNUxib1pIUG5PM05jdXNqL2hoempnZzR6WTFG?=
 =?utf-8?B?QktDamFpa01VTDd1WThoNmtBRFVONXNRSnZRMUcvS1ZvYjEyRmhnc1pTSG93?=
 =?utf-8?B?dHdKOFhnR09kWE9sUStPTCtMUjhFR2J6QzN1alI0SzAyUk1RSUkrODEvbFgv?=
 =?utf-8?B?bUFLYVRKb25LNDV5djlFUkRkVzAxZ040NTR2N1pML3J5cmg5OTl0b0U4N2tR?=
 =?utf-8?B?QlE2WlUrcnAyTU5qR1FsbHBqRHlGcE9qSEVwRXVocFUyVk93VXdOTkRYbmNW?=
 =?utf-8?B?L29ZRlBmOHhGb3oxK1g4c0RRRWY0YU04L0dHSlE5eEI0eWJaNE9VK0g1M0s2?=
 =?utf-8?Q?fVxmopjDkBzFisMd+MS2f6WlH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5137dc9-33fd-4d48-8a63-08dd1a779511
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 06:38:26.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4fOtt7MjIAX74zPzkz4+dbMuLcZj+8q7Rtix6NutaD4EMipeSJEILAPo86Udp2oA/D9yqZnqsAIwFbnLgFT5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

SGkgRGFuaWVsLA0KDQpVbmZvcnR1bmF0ZWx5LCBJIGhhZCBzb21lIGFzc2lnbm1lbnRzIHRoYXQg
cHJldmVudGVkIG1lIGZyb20gcHJvZ3Jlc3NpbmcuDQpDYW4gaXQgd2FpdCBhbm90aGVyIDIgd2Vl
a3MgYW5kIGlsbCB0cnkgdG8gcHVzaCBpdCBhcyBtdWNoIGFzIHBvc3NpYmxlPyBJIGFtIG5vdCBz
dXJlIGhvdyB0byBsZXQgeW91IGluIHRoZSBjb2RlIHJpZ2h0IG5vdy4NCg0KV2lsbCBpdCBoZWxw
IHRoYXQgaWxsIHNlbmQgeW91IHNvbWUgb2YgdGhlIGltcGxlbWVudGVkIGNvZGUgcGVyc29uYWxs
eT8NCg0KVGhhbmtzLCBhbmQgc29ycnkgZm9yIHRoZSBkZWxheS4NCkRhbmllbGxlDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFphaGthIDxkYW5pZWwuemFo
a2FAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDExIERlY2VtYmVyIDIwMjQgMTk6MjgN
Cj4gVG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IENjOiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgSWRv
IFNjaGltbWVsDQo+IDxpZG9zY2hAbnZpZGlhLmNvbT47IG1rdWJlY2VrQHN1c2UuY3oNCj4gU3Vi
amVjdDogUmU6IFtSRkMgZXRodG9vbF0gZXRodG9vbDogbW9jayBKU09OIG91dHB1dCBmb3IgLS1t
b2R1bGUtaW5mbw0KPiANCj4gDQo+IE9uIDExLzI4LzI0IDU6MjAgQU0sIERhbmllbGxlIFJhdHNv
biB3cm90ZToNCj4gPj4+IEkgYmVsaWV2ZSBJIHdpbGwgc2VuZCBhIHZlcnNpb24gYWJvdXQgdHdv
IHdlZWtzIGZyb20gbm93Lg0KPiANCj4gDQo+IElzIHRoaXMgdGltZSBmcmFtZSBzdGlsbCBsb29r
aW5nIGdvb2Q/IElmIHlvdSBwdXNoIHlvdXIgd29yayBpbiBwcm9ncmVzcyBwYXRjaGVzDQo+IHRv
IGEgcHVibGljIGdpdCByZXBvc2l0b3J5LCBJIGNhbiB0ZXN0IG9uIG15IG1hY2hpbmVzLCBvciB3
cml0ZSBzb21lIGNvZGUgdG8NCj4gaGVscCBmaW5pc2ggdGhlIGltcGxlbWVudGF0aW9uLiBJIGhh
dmUgYSBuZWVkIGZvciB0aGlzIGZlYXR1cmUsIHNvIEkgd291bGQgbGlrZSB0bw0KPiBoZWxwIGdl
dCBwYXRjaGVzIG91dCBmb3IgcmV2aWV3Lg0KDQo=

