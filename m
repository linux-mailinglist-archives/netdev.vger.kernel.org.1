Return-Path: <netdev+bounces-212939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9007CB22963
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8DF565B78
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CA127FB3C;
	Tue, 12 Aug 2025 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q9BNqM2x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB3283FF8
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006315; cv=fail; b=AC8ke6hwDjYDpjNs/J2FSRnOIvWxNTufm3tEOoo7fbN7G1D0CxoBF4QK2cvJMatHwNFfNkK18C02/7djsxUdvrr1SYZOsWPFSXqnxS/85BbE2fEQ9cw/k0mu/ble62M3q1KaUq0XHUEs+ogIH23Jy6AoC6O2RQ0n1HMbJe/gox8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006315; c=relaxed/simple;
	bh=eUTm5uqsJWlAHNLlKA5CsjMML8Ghfsl1rUaNYols4BI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dpyx1moU8frH/Owsy3PWb/U6qLBaC//VdWIssIjkzzts9sUp5if5vRO2WwypLRM5N8+k/CtKMKmLfkGFOBnA3HOc/zfAjamwdkEkW3YAppkju1i98dB41uEOqyRxdoG1xZMVuAXKTVArMON0hxXuGWFHmnqz5OMDQjmAr7m0d40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q9BNqM2x; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlDvMLMbUBEv5ekm7sAs+O/P06N73V0VLvgeQLguF44qLc7Wz35DvdX//xNjZvylbrtYXue/PrecnAjTwJ0bpBJGAj+QCrr6B7HZGPMlEfOGEiTBfqVUrnXAfKctAwQKWIL9P+O5tNQFbmEdGfd4ogBOpaCeQC3ChcF1GUVPkX1z2yuzRgB3pJTo/jTF8qBxJQdpxtwKBED5hBoe7Bll9qnfy85LAIkEUdAZw12+tkTSCcoA8cKW45Z5PpN+8HhWwrlUUlTj/hKY+Ay6me8DENJIIc0leNf3/oG9VWWXPrzFvFc35agUP33RcpI1Lm6RGkkWVu3oatBnZcu5KVptfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUTm5uqsJWlAHNLlKA5CsjMML8Ghfsl1rUaNYols4BI=;
 b=bKkALEJ3GuuFMuB6dDr13A3QBIf2JvIsOPzzOy4lY+Yb3sLJKYR3M2kKyvhnPdPMhCF9KdS/Ponwd3dba5GgbJfuwJ0pnDFBsBGlPrDIHVcbhJlStO2RHNPa91LJcLaUiuPyWGo4b2VwvTsg/6zEIeN2JT69xWte+qbwwSsMB/1oqOZzJcZ42z+P3VyPnsauu6WWARU0qsm+f4FuGBFQDUwuJ/kSv8TuttGOfgONJ22UMEFa1pinWsoo5KPDEX8wt7oC/kn5xpeLtcAxzeLp9BvfFszoMuN7/TXBk+VjMqzFp/C4tt5W8ZXeOCs0Mv+qAVeO/8hj5/Lb1fUzune9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUTm5uqsJWlAHNLlKA5CsjMML8Ghfsl1rUaNYols4BI=;
 b=Q9BNqM2xNoAINHnWEJsLmy48s2nBC/RAyIo/f48+5twJMAnCF+MCbVyM91l1dE1hJeOw+9KcjhJSnf7COmZ3F02nlLnk4X9Eu09JtlQDvDCoT5rxX+mZW8BFWHt/gLX0geX6dJ3htk3Tnu8hvavDd5EFdrgkRdYuaphFWmeC3lxLdD1CUT5TDNvTHgYUBPwatHyVUHfMAWQGGC81q6WDBXnkX9Xozl+K2wmbS+oCsbfU6KoUeqSdRgva3PKbCwiT4BimDxOG7dcOQM86KH7o5JVkxA6AeT1okotTwxcFEGJoaUwPGNYjte8uccFBKDcpyL3vve7G7w7rlEo+20gskw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 13:45:09 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 13:45:09 +0000
From: Parav Pandit <parav@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next 2/2] devlink/port: Simplify return checks
Thread-Topic: [PATCH net-next 2/2] devlink/port: Simplify return checks
Thread-Index: AQHcCzyPHvjqE6MBfUC/ejXt7sctwbRe+3cAgAAMQBA=
Date: Tue, 12 Aug 2025 13:45:09 +0000
Message-ID:
 <CY8PR12MB7195C1ACF298C258BB37E759DC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250812035106.134529-1-parav@nvidia.com>
 <20250812035106.134529-3-parav@nvidia.com>
 <a3f91ab5-d9da-4ef8-aecc-8d1264b8bf6a@linux.dev>
In-Reply-To: <a3f91ab5-d9da-4ef8-aecc-8d1264b8bf6a@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA3PR12MB7976:EE_
x-ms-office365-filtering-correlation-id: cb37a188-2dcd-4bf3-63fe-08ddd9a6743a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDAxOVdUdlZoMlhaV2t2SHltT3g1aXhPMVMzSlFWbStITE9TOVBXUnROdWEv?=
 =?utf-8?B?V01yQkp5UU1BcHN3VldicUI1dWJ1bDY3V0xBL0IxN1g5OGlRbHprdlU0bkQ1?=
 =?utf-8?B?NHVMdGdmRndpODV4Nkd5L1JNZTZGTzRVZktVZWZDSk8zUFBwTFBtS0ZsNVV4?=
 =?utf-8?B?QmRpd2xRd0kxSVBKcDJ5clVTK1lCWGFkK1VGZXZ0WWx3bGZ1dmQvb3hWWEpr?=
 =?utf-8?B?c2Y3Nkt4RkQxUjBqS0VYaWYrWERvTHpUNzNMRitaYXhPTzI1bjNKSWNFN2JG?=
 =?utf-8?B?cU5XeEowd1FJTXdFQkp4dTJmUjBJWkNHMzFxNE1WT3pNNTRoNFpHTVU0c0hv?=
 =?utf-8?B?V3lwWmd3MUV0U3RxRlFsbmJXV3hVK0FYR21LVkFVQTJ4YzNHeVFSOFpKL0Zj?=
 =?utf-8?B?Uk1lQW1yRFlraEdZbFI2akJtakhYaUdpTWh1QWExUytxV0V0VmNUeVlYdkl4?=
 =?utf-8?B?NmdxazNkZktNb1BtTFhxSHU2T0duZG9CZnRLT1FkMmlYdTIrd09SbFhpZ1Z3?=
 =?utf-8?B?RU9IYkYwcEViMHVsNkRUS01uL1FkcnNhNE5MbjA5VEhFMjB4VjRLK3BUbjVH?=
 =?utf-8?B?RlZ2d1A3MU85b2lJREgrcnBLY3hKOHhFUVBCOHFpamZhNWN6czBqZ2dYTEk0?=
 =?utf-8?B?UWpFUFdRZmE5djRNOWdFd0krWDh4RFBGYmtBVjFtc01acHpVZlNFaG53aGpw?=
 =?utf-8?B?ZlQwWU92VDZqZ0lRbXpWMHlaRmRMRXBITW4wOU54aGNvM1RsN244clNlQXJw?=
 =?utf-8?B?NXJkL0JEK0MyVW05a3I0WUoySmlLL0Z3WE1DNDhkRkJoR1NkQWg0WGpQbnJI?=
 =?utf-8?B?L0lFQzJFRk91eU9nclF3WjZKbXhUbVVEUVRRcGVjTk9qeFRJbGVRVmhYTFNo?=
 =?utf-8?B?RWsvN0xDRVBUUVhsWU5QMTJ2MmRUMUFkWVJ2Skl4L2pIK3dFTnVwWFlNNVZq?=
 =?utf-8?B?bXZ5azVtK2NDMTYxWXZ5L3Bsc0k0TXFrZmlxUVhHeDJuTlRMakkrVzYyQjRV?=
 =?utf-8?B?OWNQYmRZZTlZVTZSeEI2T2R0RkRhakRBY1BKbWhWZE5ROWxJRDNzcGtaMllq?=
 =?utf-8?B?Rkh3UGV5UGpSTTAxWm5Yd3ljVWRjK00rL3VkdHpPYTdWeGROb01VVy8yalZT?=
 =?utf-8?B?R2ZOTVVha0dCZWNFZ3lidFhLM2pidVprTzR4Wm1YdWpwUFhOOUxSK2NzanJN?=
 =?utf-8?B?cjVhNnlHUEd0WlRPbUY5dGFzMXR5eUhub3BJdDBTalA4c2k2RTJmSVd0SXJY?=
 =?utf-8?B?a2RSM1JBZFpGLzFBcXBrYnNCWWl3Qml3RTI2M1BJRXp1c0h5eGh1WkI1d0Zy?=
 =?utf-8?B?TFcrZTg2TFhPOEpiUFQ0UURlZnAxeVp2T2c4NTRGUG0yRmdxL3VpMEN2YTNy?=
 =?utf-8?B?QWIvMkZnMVh6OHpwTENXajc0TnY4NUw3alFaR0htVjEvYTZkbkF0TDdJSmNK?=
 =?utf-8?B?bDFEVjZVYStqYXgvbGpFNHNPTHBtYkh4UzRPeEhScmdsdXE5SkU5UVhrV2F1?=
 =?utf-8?B?NHJ3THlqUjBBUXU4VkJsdTdPVkc4a1Q5OVQ1YWZMSXRaQURGSzNvRGtGYkxL?=
 =?utf-8?B?UFNpQjl4Qk9UOFRvWDRtV2NHeFoxWXltRGhEQndNSEppMXlTOC9yek8wSmFo?=
 =?utf-8?B?UUNVUHVoNGhVK1IxNmFBT1g5cjBJVUtBTzB1RXVSQTI1cm9VemRhV1YwdGxl?=
 =?utf-8?B?MGMxYkJzWFRWaDBtRE1nMTN2WFRwL3dkbWxyMFMwQ0NQdHJoNjdUTjZrRFRt?=
 =?utf-8?B?Z2l4bGZxK1RVRlZINkhkaEtYcTlHTU5EMVRHMHphZk92UlFRd2JwTHU2YUw5?=
 =?utf-8?B?OWQ5aW1jcFJqRFZSTGZ4aktJTjU4eXZTdXRRNWtJc0Mvekg1a1NWOFI0ckhU?=
 =?utf-8?B?eHI4cjQxREpJV0ZWaGlrbVIrektuOHUvdFN5N2JNSktLQlBuZWVpd2E1enBL?=
 =?utf-8?B?OGRvZE03WE9udlFlcWVHYzI2ck9qdTVhWWlLYi9GNVVXVmhwUW4yT2pjRFBM?=
 =?utf-8?B?MVpjYjN6bGZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDlrQUxHMXVFYmlnRHF0ZTF3LzNnZ09PbUU2VnpDLzJDSmN2bk5vbFRnVTBt?=
 =?utf-8?B?N1N1UkR1eU1LVmtLRk01aVJjdDZLeDZrRXIwUmJUbDNWQUxBTFhQSXhzUndD?=
 =?utf-8?B?WlVTcVVLVHVTNHRxcFlzM2JiZDFJN2JuQlBRQWdlRGVjSVU0VlNyRzBndnAv?=
 =?utf-8?B?cy9WSzI4NW5NNlgxdmYrN0p0Z2h1dFUwQVlIWnNRaU9vOWVUeks0T1VwTTVL?=
 =?utf-8?B?UXJ6aHVQMXR5R1pEcmtFWkpEQWpnNGt4RmpVdWRrMnd0cHpvQVlGejRWWml5?=
 =?utf-8?B?d3BSK3NUaEREUlcyOTU4T2dYaTc3QktrVzF5MTYrNUVBeVZtWmRDL2hKbzhS?=
 =?utf-8?B?TVRmUVd1V0FhWFhocVE2MmRzWHhaQys5WmtGUjhuNHJDY1padll2bWsrNHQ0?=
 =?utf-8?B?Q2Fib2podUNMQ3NybzdjTFVPSUJTWmtlaFFCeVNSRHNvb1RIUUdqS3A3bm9O?=
 =?utf-8?B?V0poMHJYdVkwUUJDaW53MHB5SGVUbDZ4c0kzczVkaFZySWp3YWF5M1NjOHp2?=
 =?utf-8?B?cEhEWE9MM2RaWU4rYmUzZjdJWS9OUnMwanY0ZTZoWUQraURWRHVuVE1HeUFD?=
 =?utf-8?B?TCtnYlBsVGtVdG9lME1XeGFKYVdTcE03NjdzTG9UNzJvdE0zZytLVnBVcU5K?=
 =?utf-8?B?dVU3SmpQN3BLSW9GTnVweUJYKzhkdUU4Z05BTGJvRjl5YXRUZzlBM2hJWmNu?=
 =?utf-8?B?YldJaE0zNDgyU0orQW9OVkRVZzFVaERVc0NjV2dGMHFLTTBsUWNnVXNMeTNC?=
 =?utf-8?B?SjAvMGhGWEJHTHg1YkNSM3NJTzUzZHlhdS82YjEvU1F4S3h2Tmh3alNnM0VM?=
 =?utf-8?B?MGdlNDVXenJEL2pTU21GQ0JiYTFFUHJMdkxZVzlBNGZNRVYxZnBGQ1lSdkFL?=
 =?utf-8?B?N2xYTkJnaVJDQllyVzl4eFNkUjBlMm40WGE5ajRGS3NjNmVsaVpiUHdOWTRY?=
 =?utf-8?B?a2xJdEtZRmlNRGhRL0xkNmxNVUpqWEt1UXM4Z255c3hiM3VWUloxenpHa0Ev?=
 =?utf-8?B?Vm9WNEkrTDR3YWVlUlQ4eFVML21PSWNwc0dnTSt6aHlka2VKYWtZeVgwdVVr?=
 =?utf-8?B?ZUxuUVY2M291WHdXQWM5SWl6RzJoOU5nVTlTQ1liYXppKzcvZS9SeGtMNFFY?=
 =?utf-8?B?SThJZzY2ZlFzY3lQZ2dlUlN4bXBBNHBmRGlVTXRNSmo5WXl2SFdwS2FrSUpE?=
 =?utf-8?B?NTZSRm5wRmRmQnBXcmRFUjVMZUM5OEcrMnJnOVc5TFdQcmc2dlZWWTdUbUw4?=
 =?utf-8?B?Ri91TmpzZFdKKzc4cWdaaVZ1SWZJelpGK1dRRGRzdVBLQWpneVM2VTVDVjBQ?=
 =?utf-8?B?L09ZSkhub0ZmQjk5amRmMjltSXY5b2RoRHM0cjFTbVAycEhMTURNU0hlNG83?=
 =?utf-8?B?ajJISFZzNUkyRWJ0K1BzektCQTEybytCNTZiZUhlcHpxaW1UL3BjMXpQMUE2?=
 =?utf-8?B?RTVRQkVoWEZzY3JuK3dIbDhzRHdPUFdzZ2xHWTFaYkMzL1lIcHMvUFB1c0xu?=
 =?utf-8?B?WC9IYTRtZ0EzaW1XSkRidUN6TllHT1V2SS9FSWxta0ZoTldGNHM0TW5pcE1a?=
 =?utf-8?B?Y3J2bTZBSXVwYnM1cTdnd29rVlBwZ2twb3U2Ti9sWUNoSkJRRUdFREdETTM1?=
 =?utf-8?B?NWo3dVFBZHQ2aWpBdFl6Rm9BNHZwOGwrY0FUdXhyOXRGcWVGR3F0Rms2UzdE?=
 =?utf-8?B?SEhwc3gvV2pQT1NBVDlLTUJCUGJtOTRaV0dCN3I3QkNnY2JGOFRCTEdyWnVU?=
 =?utf-8?B?SW1UdWwzYWYzQkxxNkxpYWhCQUxycXpFc2R2cVV1elBLQUVWazFPNnFyemdC?=
 =?utf-8?B?MkNJQmkvU2pQaDFpb3ZlUkphdzdtL0JwZnVWMlF2b3pTYlE3RXVXS2VMT1Jt?=
 =?utf-8?B?RFdJK0NXV3pWY25USGkwVEJJOWY5R1dnbjJHSnVMZWdtUDJVMm1qMjh3Nkpm?=
 =?utf-8?B?OS9rTk5VTHdCUFozR3ZSN0g2ZXh6TnlteEtJaG80cXljdEpTN0dsdVlUVWZN?=
 =?utf-8?B?QVBBZk9XZUxyZFVKbm83ZjlFNGF3a2liRlpUNUFjVStHcXBCZGloVWtBYnFL?=
 =?utf-8?B?NGhSajVoRGgzT1orcFpKU2h2TUxsaFZlbVJxeS9UcEtQZUIvaTNta3Q4ZFhC?=
 =?utf-8?Q?conk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb37a188-2dcd-4bf3-63fe-08ddd9a6743a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 13:45:09.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5x+R4Sxk+cV0nv+OSaWKbU2Qjt0coe2b8NHgxf0PvoHj1XE7ZQHjx+auQywG/lNc2qCQfG+hOh/eAmVK9UGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

DQoNCj4gRnJvbTogVmFkaW0gRmVkb3JlbmtvIDx2YWRpbS5mZWRvcmVua29AbGludXguZGV2Pg0K
PiBTZW50OiAxMiBBdWd1c3QgMjAyNSAwNjozMCBQTQ0KPiANCj4gT24gMTIvMDgvMjAyNSAwNDo1
MSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+IERyb3AgYWx3YXlzIHJldHVybmluZyAwIGZyb20g
dGhlIGhlbHBlciByb3V0aW5lIGFuZCBzaW1wbGlmeSBpdHMNCj4gPiBjYWxsZXJzLg0KPiANCj4g
DQo+IE9oLCBJIHNlZSwgeW91IHNwbGl0IGl0IGludG8gMiBwYXRjaGVzLCBidXQgSSdtIG5vdCBz
dXJlIGl0J3MgYWN0dWFsbHkgbmVlZGVkLA0KPiBiZWNhdXNlIHRoZSBmaXJzdCBwYXRjaCBkb2Vz
bid0IGxvb2sgbG9naWNhbCBvbiBpdHMgb3duLi4uDQoNCkkgY2FuIHNxdWFzaCB0aGUgdHdvIHBh
dGNoZXMgdG8gb25lLg0KVGhlIGdlbmVyYWwgZ3VpZGFuY2Ugd2FzIHRvIG5vdCBkbyBtdWx0aXBs
ZSBkaWZmZXJlbnQgdHlwZXMgb2YgY2hhbmdlcyBpbiBzaW5nbGUgcGF0Y2guDQpObyBzdHJvbmcg
cHJlZmVyZW5jZSB0byBtZS4NCg==

