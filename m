Return-Path: <netdev+bounces-118689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CBE95277C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B032C2836DE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5964A;
	Thu, 15 Aug 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SL2F4ASb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C236D
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684991; cv=fail; b=Ung/3nkWWEnW9t9avVDXPqGhO6w1uNY62nu15iFkKlh4meYZlievb5RXPbOYKjziITZaXCEkPZHCUWYRXs/ipu7+EkdGHC6OAZ8agtEQRLU7qQcyX07PpiQxPWl0WbrvzjDAl6YhMJ0G7n2vI+rSMZkArv4tl+UEUjSf4IDIKiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684991; c=relaxed/simple;
	bh=9GA74xxmSYZX6gHtOZSgxZZv/6bz5NhMNU92fRWVmWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EXdFpWQmAMrYjRfydtxRYoenHywSoiTOlkwH0yWpmgMD+V+4zZAleshcIkCAfqu/nU2jKpPbj2QGNA+fs7nIidsjx/TqqaYxmwkhqyheU0A5N0RI5DKc+ihQnP5PjOvp1JI+I1YWu9Gnhjna4HXjOHRXh04KsafH6ehmbWfdJs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SL2F4ASb; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEseOvxe0qnhppoduAps2gG2sZvgU0q/tZn6CqRvPtGkZo+aZ38vbDR+epo8YHlyWW3zLALOV9eraTIsqywiOS4LzxOFGTG6vHWsXwHjKhDA6v8KNczA6pjDEfeED01cVj2q6pSn+oXvzQHeI3iegDlbm9Uz7OArkpp5u0C799g/3W7M5NsDfpkg3oBrqxEfooMCB1UsY/JZpbXx4ggSJ/qClXoYyo7zWcxutEXKpar+57SL/ljbu91S1/F3FRr3rAJytA0dc68levtV3fJSrmUxUak40Xs/b70cvEz3bz3V518Omz7nQ74+faNlcNiP4KvROkzFC/rpbns361Cucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GA74xxmSYZX6gHtOZSgxZZv/6bz5NhMNU92fRWVmWE=;
 b=D7SAdAx4ACuIJqP71cMZLXUXGFEubn8n1b9+N80Dj/nsCitwJ3C9A1Yg+uniahFoKIKb4ORW5pa4T1LN/0TCUh2rLCBkWeHq7w65vWI2LtxnLrMk6YAk8N52dOZPGv3JC26vMJNqSGYD6OjNeJv247NOkP9NWHPH3GVP+NK6I5Yagx9dBk/VI1nlYZ+xTtEB+tA+777HXtw8UuK1rlPPVOR9kDw14Y/A4pQYE0ehh7WIdsooEthXlBFnSCe/9s3ug7THfOzZK2oSobhXuSppAD4Hf7wh3ez9uSPuO6T0qq6oy4RD+7QacbWAkn/6eN2QU6PJLFliq/et35X36dEO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GA74xxmSYZX6gHtOZSgxZZv/6bz5NhMNU92fRWVmWE=;
 b=SL2F4ASbBmNlxFLckeqLpYBNKjDt/NQ6WqvNzn7IqsIkHToqFow9KOF3kbTbVk31+OG9a+qM9gfXNJsA07R0EkZCn1O6lzraCVOWbKhsywH3T4Dk81p8V8aWx0OYne3W6bsk2jwr1+KBVJx6wDjozYcDDEQuPESysp1sOXtwxv5G3U1LXG7PMNF6GWd6Xo+5y6CIl4hQVlqa/sM7+CR+9rhCMXOgdGFkd26Kj0aBgG2OqxuSJdwTOaWewDCSEfL1+PLqZ4xOmJliJq9KwyxYtQSRSsEbqS0DHMmBrUxNwN3Q15SyK3AkPcP1/+asktd2ZVFYMqAMDQAuqoXvyOUspw==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 01:23:06 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 01:23:05 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman
	<gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and call
 it after deletion
Thread-Topic: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Thread-Index:
 AQHa5vUrWi/gseXBCEqaGlxcFyce2bIkZyIAgAAkNgCAAL0JgIAAxiQAgAASv4CAAXQrAA==
Date: Thu, 15 Aug 2024 01:23:05 +0000
Message-ID: <e7ee528b3db5ba94937ca6c933f9060e32f79f3d.camel@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	 <20240805050357.2004888-2-tariqt@nvidia.com>
	 <20240812174834.4bcba98d@kernel.org>
	 <14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
	 <20240813071445.3e5f1cc9@kernel.org>
	 <ad64982c3e12c15e2c8c577473dfcb7095065d77.camel@nvidia.com>
	 <ZrwgRaDc1Vo0Jhcj@Laptop-X1>
In-Reply-To: <ZrwgRaDc1Vo0Jhcj@Laptop-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|CY5PR12MB6250:EE_
x-ms-office365-filtering-correlation-id: 4bdc7d17-6560-4659-7ded-08dcbcc8d0a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1hSZVFYeW5OdnpKWU5GVnZhbFo4OThyV2Ntcm9BZWlScU0wNGZBbVRNejhK?=
 =?utf-8?B?cVBnTGl4a1dsYlhRYzFjY0RJTWZKclF4WWl4V25mRzE4UERnQXR1WkE2dHhN?=
 =?utf-8?B?N3J5Um5YUW84a0I0alI1eWp2VlVNNFZLZHd2SXFUY1JsVko4L1FIVVlid2Zo?=
 =?utf-8?B?eUpiMEtpYXZDcUEzd0JBQ3BkYTlmMG01d05maXRxZjh3TzJLYXhOS3FUdGxH?=
 =?utf-8?B?QUh4RFhiWWhjTXpwSjJmbjZBSUVDUzhmVE5oaHduckYyQmt1eHMrTFcyRzhX?=
 =?utf-8?B?K29XWkVpT2lXWDVoMXVzM3JhcHB4cUtvQi8xa2pzTkwzdXBVLzljRThFVTQy?=
 =?utf-8?B?TkV4NjdWYkZFa0x4NzVEaWFRSjdiZzhZTFIyc21qUmpRUW5LS0FNaysySzdJ?=
 =?utf-8?B?NkIrUE53TE1yYnBwaWFjK0JTTXh3NmhFeFVvcTFGLyt3MEtZZHI0c1VsczVu?=
 =?utf-8?B?RmlVNGhPN21ENkszZjl2bnZmeEc0VVhWMlN1WmtRc1Z4OUErZjluZG8zMTdG?=
 =?utf-8?B?a0RxamZENXNNRW8raGVGNThYRUwwSmlRRHZGU0V3ZDNEL3Z6MllKZThxRG91?=
 =?utf-8?B?SUFmL2xTVGlDOFFKNDJDOFpOMFpaWTRzd1h2TTRkT3B6MFhOWVY4djRLR3N2?=
 =?utf-8?B?Wlg2OXAvUW9hcDc0aHNJeWlxZVZpTkVUOEx4alJ3UytaS3BiWVlWT1dmUTVH?=
 =?utf-8?B?TUpWdWJ5ZzZRd1lzMWlZd0krRks5ejlTSlZSVnV6WjF2QkRyUi9QQXlCUWM3?=
 =?utf-8?B?NzZvVWdqb2YxWEJBTHlFVHVueUFpZWdCTHR0MnFCc2NsUHhCdkF5WHR1c2dT?=
 =?utf-8?B?NjFZUVpmeEZDQXVLdTcxa1dvN2t4cHBuODVkSjB2VmRLUWdsenA4aFNGaXNJ?=
 =?utf-8?B?aVg0Y1c3WUpEVktBRGVjR1p6ZVRFR3lab3pVL29iYVJTVFZMUGZuSVoraHcx?=
 =?utf-8?B?ZFpEQUxiSzE2UWl2U1F0c2NtZzdBdkh1MU1FOXYwanVMM0dHVUZaakwrN0Zj?=
 =?utf-8?B?QVUrRWFQUmpKUE1KdVVhZlV4SXpYaTFpWGhRdVVsV0FNSCtBNS9CQmdHemhH?=
 =?utf-8?B?RVNxK0tpL0t1UFlYaE5nYjlzRWxycWdLbzN2RFhMc1RLRXpKSFRQVnVTajQw?=
 =?utf-8?B?VFIrVlEyUWs5dkluVU05amZodEdmSGhtckRUK3d6TUZjbGJNcThCT0tIc25m?=
 =?utf-8?B?S3ZIa3cyWVA5cXZ2WTYvZjJYRlRISlloL1hza09NQm5ValJhbFpPVzhYSnF1?=
 =?utf-8?B?TVpLZGpaS0s3ODhzTjYyaWR1aUtXN2pOZ3RaNlpqeGduMjZWVmJvei8zSFVF?=
 =?utf-8?B?ZGV0MDZLREtYUUJCRTRnTDRIb3FkSGhFdUtPaS80NitJTElHUWRrc0ozMEVz?=
 =?utf-8?B?MHUwc243dkFGT2hLNFJlSmk1ek92SjkrOGpZSUdGQm5TM1IzY25mVFJrYXZU?=
 =?utf-8?B?cjE4VEN0Yk5KekV0TWFIaE5hbEVQNmhMSytjUVVrMUVHc0V2UUhrcG9hRHdL?=
 =?utf-8?B?NTV0NHFUNzVldXJJTTNWR0g5TDZRNjMyYWI1RUdRaG4xdEsrTmRrUWszdXVh?=
 =?utf-8?B?aHFzSzdFVS9MN3Rhc2NVZHpTdXNzQlpnc3I5MWpoK0RtT0NSS1lPRlJJanRG?=
 =?utf-8?B?bmFsV2UvUjN2WFdLVFR1bWk3cnhqWFdoZWJxUmFKYlZuQmV0cE5hcFIvRUpF?=
 =?utf-8?B?dXRiUzVoaE9GQXhjOTN0S1YwRFkwKzdYU3IzTXVwSWc2bEk0QWprdEN1SVVD?=
 =?utf-8?B?WFYrWEt5RmlTc3phUnkrOUVCZlBRME1yVlhqOUNMR2JNNk0vU1lrWGdML1dI?=
 =?utf-8?B?UkFaYkl3MS8rSUJmakJLOUpPRVpCeExRSUxpTVlwb3pJVmEvcDF1OVY5Tndh?=
 =?utf-8?B?SW5QcERGQVlpSEZqWXRxRm1zTGZZRUlXOFBLUE5pMEQ3elE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWV4NVFLOU10SUQ3YnF5ZzJrWkRPU3BLUUxkTVZERk9lTlcvRDFyYUVqTW9o?=
 =?utf-8?B?eHhjdWpOakViZzJFeGZKd3F3MTEvSzVSUjJGMnNINmpvVE9iL3lTNmMxcWdY?=
 =?utf-8?B?Ny9qMXhBK0djY1h3RHBVZ0x4dTV0QmVtajlETThBUFFGN0k5VWdoOU0wc0Jm?=
 =?utf-8?B?QXdQbjROdlFGakZpUklEaDcwcWRDS3ViVnVZenNjcVZqU3hPWUt5d3F3dldq?=
 =?utf-8?B?alFoRFZsa3JBOGw3aHZBWWl0YkdlNlQ3ZXJsWmpKL0UvakFUU3RJVVVvb1ly?=
 =?utf-8?B?OVhjZUhtcEtQdE5PV0V0RkhPZFQzY25jeHFpZEdodnZWdTJwLy83R3ora2JX?=
 =?utf-8?B?N09pS2FmTzZ0d0xJWjA2M09OdnBlSmM2NFlNOWJldUV3VGhpZUkyTE13cmRp?=
 =?utf-8?B?N1RnMUtkTG84OGphdSt1N1NEN0s1WU8rcHE2eUtRQ3poK1RmVm5ZUEpHM1JW?=
 =?utf-8?B?YTkzKzVNS1VYa0ZlRnovd3U3aERUT01XaHJ5SWpnWVFjVDFpV0JBMDFKRUZ2?=
 =?utf-8?B?SUcwYzVvcisvZnhQM0dwb3RuNkhRbkNKS2V5RTIxRU1FTG82SjN0ZXhoZW1V?=
 =?utf-8?B?MkdPNUtsUzMzbXJLOGZIK0N3ZDZyaG9NcHRTY210enFvc1V2R3Q4L3B2ZE90?=
 =?utf-8?B?RDR5OUdTR0s4RWcxK2F0VG9Ba211OFFFSmdxcDYwRmU2cnZPNUdySjVneHo0?=
 =?utf-8?B?SzZNNzN1WTJtbU13NFBSRi9QY05md1o3bHV0eWJuWEZ5enQ4d05rRGk0OTFz?=
 =?utf-8?B?U094azFrS3RCZVVPandOV0dGOHNLUHZ5WjJ4T1NWcHlIWXRGUzEzcm9wZTZk?=
 =?utf-8?B?MjI4bjFIU1FiaktQNkc2MFgzV05JVWpFaWJhY2ZRRWx1S0tkeXhqZkNVNVQr?=
 =?utf-8?B?MXNEcGp1YjUwS3kwUGg0Tkw1OE9NdjBiWkl2QTF0Tm5ob01aK05XdStPa0xW?=
 =?utf-8?B?Tjh0MXdNNURnSGpHNkJ4Yk5JY0F0aG8rc2RlRE5YRXRKZEk0RmNXb1g1alRu?=
 =?utf-8?B?azJTS3ZoZFMrUzdKZUZJRFdNVHJrZkVTdFduZzhaS1FKOGtlU3E1UnZXalk1?=
 =?utf-8?B?NnpOemRZTU1zWk1MY1NiSE5mUEVrdGQrUWlHSzViTzFPUTZrS2k1SEVWU3dC?=
 =?utf-8?B?ZEdhMFpoejY2Q1VRRVhJemRDVVZjQ2xTditXbjRWbzliTVZwWnZzVC9VRzFo?=
 =?utf-8?B?NVFxRmltT0RmaWFDQTRRb3FJZThINnhScG5FUGdnbWluQ3hKVWxkSlhHZ0t6?=
 =?utf-8?B?Vyt4RHludzlZOWF1NEFTVXFTdGZtaU4rbTRaNkYxWklWM05iQ25KaVZWRWVm?=
 =?utf-8?B?Tk4zYkhIMy9PeTBib2crWDNnNHd2RWxta25ZOGVnM2pxaVRNdThDYVVKWHpv?=
 =?utf-8?B?SGtGdXREcmxvQ3pjMlkvUE9jVVNGdUlGN1BpQ2UyWmltZEIyelErSnFOUFE3?=
 =?utf-8?B?Ykltb1ErcWV4aGlRK1BQY2VvUTlBK1UwQlVGOSsyMW9Wbm5LRU44T1VXZTFI?=
 =?utf-8?B?YkIwYTRKZkE3emlZSU9VQ0dMM1orelJOQ2VmN09nTnM0anB2QnZrSStLYlNj?=
 =?utf-8?B?VElOSnBZNnJNOXgyQ3BHb2dISW01ZXJ4QllsWDNHendYRElUTDBUUG9FaHFD?=
 =?utf-8?B?NE5teG1lSmJEdnpldXVDdFg0OElJQ1pXZmFGYmUzOUVleDNDNDV0eUdTQjVX?=
 =?utf-8?B?ajhaMjI0K2NmTjdHWnAvRVNVZFFjdkdjSlh4eHdSN0Nib1lBTlUyOS80MGU4?=
 =?utf-8?B?S2NkaDRUL3c1WDBtb0tyQ09QSllaWjRKNDJKQ0RkWnZjcVVlYVNyRm90WlE5?=
 =?utf-8?B?eEVXeWVyOHU2SE5qQXR1ZGRJTEpLYTFrWDM3M1hLZVpWVXA4YjhQUnY2dVJh?=
 =?utf-8?B?S296bk9HTXBuTXFFUlJvNFFlNk5xRnNUWFdrS0dMWjF1dkZmRVZsUG1wb2Mx?=
 =?utf-8?B?VWY0VElEcWdHM25meEdlazZwdnNZV0s4WVVoOXVyR1RudmgxM1hjODRacmVy?=
 =?utf-8?B?MHlBUWl5M3AzcngyK1NSTzM0RVBENFNiU0g5NVhPWnoxNmxJWW16MnJXdmhN?=
 =?utf-8?B?aDBRTzBxRTB4cXFvb2xnSXVrRTZEY2NlZ3ZwVmwvREU4QVpDZENrR1kzeTRS?=
 =?utf-8?B?SFc4NHBEYW4wSEJMa29jMExZYW1oaVpmTGVSclA4KzNzZGVLcno3SHM5QWVL?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C4EF3036A072478A6C9B77E61257E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdc7d17-6560-4659-7ded-08dcbcc8d0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 01:23:05.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zK0gMSh0zSqofdFpoy/Po/6dvPFBzezyRapP9ISq/VUmQoUYN9O6moNAoc0cT2GA2oel/C2FJ0yd72fi9whODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

T24gV2VkLCAyMDI0LTA4LTE0IGF0IDExOjExICswODAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gV2VkLCBBdWcgMTQsIDIwMjQgYXQgMDI6MDM6NThBTSArMDAwMCwgSmlhbmJvIExpdSB3cm90
ZToNCj4gPiBPbiBUdWUsIDIwMjQtMDgtMTMgYXQgMDc6MTQgLTA3MDAsIEpha3ViIEtpY2luc2tp
IHdyb3RlOg0KPiA+ID4gT24gVHVlLCAxMyBBdWcgMjAyNCAwMjo1ODoxMiArMDAwMCBKaWFuYm8g
TGl1IHdyb3RlOg0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmN1X3JlYWRfbG9jaygpOw0K
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgYm9uZCA9IG5ldGRldl9wcml2KGJvbmRfZGV2KTsN
Cj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHNsYXZlID0gcmN1X2RlcmVmZXJlbmNlKGJvbmQt
PmN1cnJfYWN0aXZlX3NsYXZlKTsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJlYWxfZGV2
ID0gc2xhdmUgPyBzbGF2ZS0+ZGV2IDogTlVMTDsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oHJjdV9yZWFkX3VubG9jaygpO8KgIA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoYXQncyBob2xk
aW5nIG9udG8gcmVhbF9kZXYgb25jZSB5b3UgZHJvcCB0aGUgcmN1IGxvY2sNCj4gPiA+ID4gPiBo
ZXJlP8KgIA0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayBpdCBzaG91bGQgYmUgeGZybSBzdGF0
ZSAoYW5kIGJvbmQgZGV2aWNlKS4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIGV4cGxhaW4gaXQgaW4g
dGhlIGNvbW1pdCBtZXNzYWdlIGluIG1vcmUgY2VydGFpbiB0ZXJtcy4NCj4gPiANCj4gPiBTb3Jy
eSwgSSBkb24ndCB1bmRlcnN0YW5kLiBUaGUgcmVhbF9kZXYgaXMgc2F2ZWQgaW4geHMtDQo+ID4g
Pnhzby5yZWFsX2RldiwNCj4gPiBhbmQgYWxzbyBib25kJ3Mgc2xhdmUuIEl0J3Mgc3RyYWlnaHRm
b3J3YXJkLiBXaGF0IGVsc2UgZG8gSSBuZWVkIHRvDQo+ID4gZXhwbGFpbj8NCj4gDQo+IEkgdGhp
bmsgSmFrdWIgbWVhbnMgeW91IG5lZWQgdG8gbWFrZSBzdXJlIHRoZSByZWFsX2RldiBpcyBub3Qg
ZnJlZWQNCj4gZHVyaW5nDQo+IHhmcm1kZXZfb3BzLiBTZWUgYm9uZF9pcHNlY19hZGRfc2EoKS4g
WW91IHVubG9jayBpdCB0b28gZWFybHkgYW5kDQo+IGxhdGVyDQo+IHhmcm1kZXZfb3BzIGlzIG5v
dCBwcm90ZWN0ZWQuDQoNClRoaXMgUkNVIGxvY2sgaXMgdG8gcHJvdGVjdCB0aGUgcmVhZGluZyBv
ZiBjdXJyX2FjdGl2ZV9zbGF2ZSwgd2hpY2ggaXMNCnBvaW50aW5nIHRvIGEgYmlnIHN0dWN0IC0g
c2xhdmUgc3RydWN0LCBzbyB0aGVyZSBpcyBubyBlcnJvciB0byBnZXQNCnJlYWxfZGV2IGZyb20g
c2xhdmUtPmRldi4NCg0KVGhhbmtzIQ0KSmlhbmJvDQoNCg==

