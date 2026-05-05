Return-Path: <netdev+bounces-284249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC7BGtuk+WnR+QIAu9opvQ
	(envelope-from <netdev+bounces-284249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A35CE4C86BE
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A6FB300CC22
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE53DEFFF;
	Tue,  5 May 2026 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BCfZCM2e"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5033932CC;
	Tue,  5 May 2026 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968344; cv=fail; b=lR9hNoSfYneyeMXi6z7UIuZ+gZCLEcQ/nEO2sZfoCb1zYJcSYQLPv6tno70eDY0lmBChjXjt4xFM946wWoV9B0UiIbTBjIm+Zr4txT3lpwNMdrbwjBcqxyrZX8is58X04sXlQIm71wwTnatdKyHxwNZlFEjlZMGUok+UlRnU6ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968344; c=relaxed/simple;
	bh=LqJszgLcrZok9a3R5JhkeiW0p0g5G1b+fJl7sgx1Z6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YC/Oc78vL+LpGISD+vgk2gi0YxtrGE/Ag5XaEeY0995A2PFruxcXv+bx1nnzwnj7lSCJntFNJ2RbBxN1l8iXipbPf1aROJ5HKuL0rvjbKpIXyJxwiuhwIejXH30+meNxUjWmnS6r8It4YQB79xSzagUD9sL/CdTnrWIzVvKz1Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BCfZCM2e; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZjcthNUrb8csxxnfNY/UJ4g9kozPzdjJ8Kl70Hw6NrYO9sMnYhoRMWTnPz3P1ZirplJOlG3N44w/NMmkfnnZggGPfu3BbV4NQIBzYiUq8lKHcG/JKKscEgPXfJDK8QvCDrVu9zV7AnWekDYD4Tc+29BBlAeAUW0mb5yFesRS1XH6Xi1rAWX5vTl41j4LAV+jF7NBUauipfFP1oHSdabUahi0B0brngzTPAoSadT2JolSYb/c0JOXEMWxzopemTCWkOHs+bciQPvHgm5xYe09r6KCjpsm2NQPHW7VdesD4/6871p6tmwvXNT6Lm86uGAwJKSt0btRSWvMpVidt0MVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqJszgLcrZok9a3R5JhkeiW0p0g5G1b+fJl7sgx1Z6Y=;
 b=Vq3prcfsoKFnPQqNZedwrt32inMklHIkrOKiMoOJaXbDCre+tQRR+x4oBnLKzjkCVuGrLQtDU0I9q4pEIjg0RqIQHgB3chQy5psdIfXs5FrWU3nAcq2jzJBLgTOyqMQX3bDdLXziG6jKi5X8+EO62ZaLxQSYpH0m8sJVHmxBgK2zaRkFQyM5m9v6noKED4U1D7eljMyMSTRVXcdftbus6iokJkbIrsVqQdY30iT6fRgrnhTVmnutGJ/QvgJG+/aQyTaZjeycgNg4H77+PK635cKKJ9o60ZN2WCAI7NXjCzgTK6O+QQ9TUUIDPUPgY/Et3nF8bm0vJir9PH4u8KN9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqJszgLcrZok9a3R5JhkeiW0p0g5G1b+fJl7sgx1Z6Y=;
 b=BCfZCM2eqc0+o0felhoa4vTDaMYitubzR5dGkTcE9ehuq5FOHT0U+iCkIqO8TCGbwefuXeCnRvlEZkJXtam/HBVzlgnvYIWnDF9iuxyc0gEwcqzIAsyzg9fj3LQLcoXUv2mV9/4kW52CxTgStf3oHObppRJ5/gTEqf5RRvPqW/r19K5A4BHdyylqlgtBlOCfiaigeN5ie5SKDryPtCqN6aQdrIzAkXPNfHJzstH+RCC1U/rSNG0hEh1vUsApKGNoU6xUI1mXXIUec4k9SWtHBTtRb36C0/TSnJuH6QwqzN2NvZx1cJHmZanwCrKy/q/cFL9KdG010BQEipeDD6fPMQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB5677.namprd03.prod.outlook.com (2603:10b6:a03:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:05:37 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:05:37 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: Use interrupt mode INTM=1 for per channel
 irq
Thread-Topic: [PATCH] net: stmmac: Use interrupt mode INTM=1 for per channel
 irq
Thread-Index: AQHc16DVbMtII7bGLU2OT72vi7FzJ7X4ViaAgAbGgYA=
Date: Tue, 5 May 2026 08:05:37 +0000
Message-ID: <0d9380ea-3818-434d-bc12-c6e05e4b2837@altera.com>
References:
 <20260429062428.18438-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260501003735.3120766-1-kuba@kernel.org>
In-Reply-To: <20260501003735.3120766-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB5677:EE_
x-ms-office365-filtering-correlation-id: 87665285-2d8d-4367-35e0-08deaa7d1781
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 VR3w6o8/X1+Ds3mE0UQIM0pt4RgOnOSxViTcALw/fgzy2xmvtTiGyzMVpLQZ9/aKKHTx7SWiXh0L/G8k0zb5k9rE+030YvfAZIm15irgiswmhpYxs/o2ybuy9IrcyQDTctYxa0GMn905q9p/Q2MnxBwiMZPU/pPQ0Oad0PpOOIVDdl1UWtCT9xG7UEJAHTiZjR+hjE+YCcvtljBm5QY8yQab6gE/xDPWZ7jx1ZEQAVW39MyiPOVo6+Bldj28DPsStQHQGLAkR3WDmCxOXpOesDE990NbIR8UuZ6Wbkl78ojKYpQYEloliMc5NDrYTOP5U+v24gvENhu5ykwaWbfpVLopp6bvzLI7DL+ZUo+eEQ+Cw/WebLC4zD5WBh54/dUtYGBKxDwl3j2h4/UfBK3QZ1BiDTl539lCcxQxy1WOfPbZWnQPoYVu8qQygfuxT8/iAPF2SNaFecLK6zdmrJhr42ocBE8JvfmFWKcIqrSDiP5RII+y0NJTkVyd+lGo7upY2ardCZfpbWKMyFuUOxuRy8IMqjWeeWn+OtFvuHqNAHNYDMBpkS1j+6TDnQoXjrOs0NxvBsir0JNbExUlXxJMnn42LQXN1ayfuKYLV14ix3wN28CTJm1whr5tpCdKkBlNvQ+R9WJEIZ7ofad8Y6dcfJUzzrJQRNqUCpd6CuWWRORCMttVlHE7w2cFS9O/W/YeC5PBZzBFSjz1OnxiMLzkmuX86mAOKXeh8Udawa9kQC5uYzw4vUtU7AEse/YAIEBk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjV1VTdubmx4SmVpcHN4aEhCZExub2h6eFIyNEF2ZVBkOUtCVy83Q05hRDhX?=
 =?utf-8?B?VHBFcEIzSmE2RUtFdkNSb2VXQkhJZ2RYT2VPVUtGL2w4M3NKcVNPTERrcWFJ?=
 =?utf-8?B?dmZ6b0NCclhsT2tCL01TODRXdTBESUtReS90b28zbGtMTFdHMlg0OFhsN0Fi?=
 =?utf-8?B?YmM4QS9YcWhTZVBJOTVabHVmeHJaWHNVNGcwWWUwM0FjK21uKzhaSSt4aDJx?=
 =?utf-8?B?TEFkVlExbDY2Umx6RFBLOHRWc3J6QnpheXloc2xDQ2t2a3FPR1JHQmZaL29Y?=
 =?utf-8?B?YWpGdG9uV0xaMVExNFNaMmkwSGxnQ3p5OFYrZm5wc3V6U2RmT1B0RTBFWVdF?=
 =?utf-8?B?OHlxR3dOS3NWcG03dGZiSE9xVGpDbnNzMmszTXF1MHI0RGdRMk5LajlmSzdI?=
 =?utf-8?B?cHRZcG9leWlQc0Q0ZjBkaW04ZGJYZlN3bHVpZXdKd2tRWEZOdCs5MEFDcHZQ?=
 =?utf-8?B?Z3JtTXBrNnJJd3d3bThPRXgxb2Vjc2VhZFZVb0JObkg0ZDVEZldKMUtDOXgv?=
 =?utf-8?B?NUl6Q1NBaTVOaUFGaDVuV3NEZFpaQnBYdDNHS1VMb0lETVRLTjhuYVp0MUtB?=
 =?utf-8?B?Q1pTVWhGaEhSVmhML1BMdzc5UGt3NEdpeHdyUlF2U0VWY1A3cFlSUURBanBT?=
 =?utf-8?B?dW9IVGhZUFZmVmdDMGJRc0pWUk1pcHRpYUxJakkvYTJrZEJycENIbTBDNmoz?=
 =?utf-8?B?dFc4YVZ3c0Z0VGVNd2w5TVRnd0RxNU1kcnF2ZTF5cFB2NCt5akFwM3NIaThw?=
 =?utf-8?B?ejFsMFo4ZVJBdERCQi92ZFJiWTFHMGdLRzkrVld5b0ZPSis1WlpqR0l0Yzhy?=
 =?utf-8?B?ZUN6UmI5aDBLNlhJL2JDVVVvSG1kdEVSQlIrSVdWMUdIVnpaWk1mT3JkSk93?=
 =?utf-8?B?T3o4aXN1TS9sSHllVHRlMC9zMXNoWXNNVE1VR0tqWUE4UHkxQW9acTVTNUU2?=
 =?utf-8?B?eGEzTE5NdmJ2K3pLNDlmN2hoUjl1UUJTcVpXR0ZtNDJuQjF4Y1IzZ3p0SWdx?=
 =?utf-8?B?N2VqRlhxL3dsRGJwVGxHTElhVHZGM3RWSXcxYTNpZzNHZ2kzU2VldWxUNjFk?=
 =?utf-8?B?QnpDQzVxM1FZRWRpc1czaUtYWjZqTElqT2J5SUdwQkhMZ1hmcHh6Vm9OTTFE?=
 =?utf-8?B?amZ6VkVvaWZVdGphcG4yUCt0ek5HWkFuSTluV1g0Y1hBdHE0YnhudkVPdTUw?=
 =?utf-8?B?N1JIR21YTnQwU3pqUWZ1WlZwdzZndDU4M0JLRzRxZVh3d2R2aGdBeGRibGxE?=
 =?utf-8?B?NnZyd1dsY0ZaMHNBOWdBbmhQTnJwMk4vY0s5ZVhMQnY3ZlA4WWhIRTRyNWF6?=
 =?utf-8?B?ZEErNGJsWnJXZThvM3RsMGhOd2RCTzk5NWNIR1BvVTZiRFl6eHd0M09iVXVa?=
 =?utf-8?B?SXMvWkFUUjlZbjZTT3ZpZU5vSWl1R2ZEZmE4b0l6OWV5R3JzbzZtQW1TM3pC?=
 =?utf-8?B?Z3VhQmpzUUc0dnBGa09xUUF4a3ZuM0dzMHBONytMWWMrcFpyTU5qS0Nobzg1?=
 =?utf-8?B?L0NWL2pYL21QMG5xMzNXdXVsenFINDFuRWdDQ3V3bU1zYUxydytXbmp2VzFh?=
 =?utf-8?B?TnhNVFRML1hoWlhFZ2RKbGcwV0ZhSUFWR0FiQjFmc0kyMEdzdmV3WDYwVmxP?=
 =?utf-8?B?YlNsR2JUemZmMndQNGlSaFJ5dTd1REZHR1ArYTgrQUU0V25IWDFhWS9Wck5J?=
 =?utf-8?B?ejRrWEV6WjZVR01sK3JZbWtPZzZ1cE9pMVFpNFMxVExsK1NoWjV3enVmQXVP?=
 =?utf-8?B?L3hjbjdoNXc0OXZtQ3VQMGdESUx2OHJEcWFieDV3VmR6clpTOFFMR3dieFp4?=
 =?utf-8?B?RjMyTU91Z2JoR1pZREYrL2YwNUJ4RG13YU12WEtjVStIOVJid3lJVCt4V0NU?=
 =?utf-8?B?b0QrdW1oc3B3enAxNm5iMm1PS3lNQWdCc3pZQ20yM0tYSmkrMklFZzR1NW0w?=
 =?utf-8?B?dmEzQ2FMMHlOVmNmMWFNZE1Cd1FMeWREaU5UcE1HNmd6UVRzQ1A3VVpWNXpH?=
 =?utf-8?B?ODAxSnV1TWtSc1dZR2kzSmZoT0xkSVNWR1F1dVZ4RWtWdnVPQWFyV1Z6Yi9M?=
 =?utf-8?B?cGJzL2dKM1cxb1pKbWxXa3Q4cS9sY2MrK1hZODZTa1IyTThFdHBBdUwxaG1n?=
 =?utf-8?B?S1VYZHlLU3JvUlZUdGR4UlhUbWg5djJ0T295Q3ZEZzc4Vmk4VDBNOHExTnZJ?=
 =?utf-8?B?YWJ5dVBrRWQ5d1RpQTdoenk1TEY1bVQxeTNid2ZvVk0zM1RMRXc5OHFXNHA3?=
 =?utf-8?B?OHNFM1BaT2V5azJTU2lVc3d1Z0RDRFJRb29jUW53K2NuM2NVQ0I0b09QU05y?=
 =?utf-8?B?N1hsMGRQNDc0T3NEeTBxVXJWR3VPb0VDT0h1TUFvU1N4VzRvUStNbUNWSkpo?=
 =?utf-8?Q?f3TWbRzeY3xrdXRvX7KJVQHHMbm/4rpbNsadPa+nMN/RH?=
x-ms-exchange-antispam-messagedata-1: 7gkNfE08D1GUaA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <59FD531B3B0E1B4F8F838D537DAF3260@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87665285-2d8d-4367-35e0-08deaa7d1781
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:05:37.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYm7SxSSql+QKcLgK1RX8aMzsBoPQB/P0dUIGETlta7g3Gln7Gv+PBu+RWNX5qzz7Md6r2jBEIHSkKZtWymfSKAehvCXEZmPyp01zShB4dAhI2NhiAIIKK7kzGBnepJ1VsZt8L+A5p7T7bn8iD8DcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5677
X-Rspamd-Queue-Id: A35CE4C86BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284249-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:dkim,altera.com:mid]

T24gMS81LzIwMjYgODozNyBhbSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IFRoaXMgaXMgYW4g
QUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4gc2VuZGluZyB0aGlz
DQo+IGVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSByZXZpZXcgdmFsaWQsIG9yIGF0IGxlYXN0
IHBsYXVzaWJsZS4NCj4gLS0tDQo+IG5ldDogc3RtbWFjOiBVc2UgaW50ZXJydXB0IG1vZGUgSU5U
TT0xIGZvciBwZXIgY2hhbm5lbCBpcnENCj4gDQo+IFRoaXMgY29tbWl0IGFkZHMgcHJvZ3JhbW1p
bmcgb2YgdGhlIFhHTUFDIERNQV9NT0RFLklOVE09MSBiaXQgb24geGdtYWMyDQo+IHRvIGRlbGl2
ZXIgcGVyLWNoYW5uZWwgVFgvUlggaW50ZXJydXB0cyB2aWEgc2hhcmVkIHBlcmlwaGVyYWwgaW50
ZXJydXB0cw0KPiAoU1BJKSwgbWlycm9yaW5nIHRoZSBhcHByb2FjaCBvZiB0aGUgZWFybGllciBN
U0ktb3JpZW50ZWQgY29tbWl0DQo+IDZjY2YxMmFlMTExZS4gTmV3IGZpZWxkcyBhcmUgYWRkZWQg
dG8gc3RtbWFjX2RtYV9jZmcgYW5kDQo+IHBsYXRfc3RtbWFjZW5ldF9kYXRhIHRvIGRyaXZlIHRo
ZSBuZXcgcGF0aC4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3Rt
aWNyby9zdG1tYWMvZHd4Z21hYzIuaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3Rt
bWFjL2R3eGdtYWMyLmgNCj4+IGluZGV4IDUxOTQzNzA1YTJiMC4uOTRjYmYyNGIzMTE4IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHd4Z21hYzIu
aA0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHd4Z21hYzIu
aA0KPj4gQEAgLTMyMCw2ICszMjAsOSBAQA0KPj4gICAvKiBETUEgUmVnaXN0ZXJzICovDQo+PiAg
ICNkZWZpbmUgWEdNQUNfRE1BX01PREUJCQkweDAwMDAzMDAwDQo+PiAgICNkZWZpbmUgWEdNQUNf
U1dSCQkJQklUKDApDQo+PiArI2RlZmluZSBETUFfTU9ERV9JTlRNX01BU0sJCUdFTk1BU0soMTMs
IDEyKQ0KPj4gKyNkZWZpbmUgRE1BX01PREVfSU5UTV9TSElGVAkJMTINCj4+ICsjZGVmaW5lIERN
QV9NT0RFX0lOVE1fTU9ERTEJCTB4MQ0KPiANCj4gU2hvdWxkIHRoZXNlIHRocmVlIG1hY3JvcyBj
YXJyeSB0aGUgWEdNQUNfIHByZWZpeCB1c2VkIGJ5IGV2ZXJ5IG90aGVyDQo+IHN5bWJvbCBpbiBk
d3hnbWFjMi5oIChYR01BQ19ETUFfTU9ERSwgWEdNQUNfU1dSLCBYR01BQ19ETUFfU1lTQlVTX01P
REUsDQo+IGFuZCBzbyBvbik/ICBUaGUgZHdtYWM0IHNpYmxpbmcgaGVhZGVyIGRlZmluZXMgYW5h
bG9nb3VzIHN5bWJvbHMgYXMNCj4gRE1BX0JVU19NT0RFX0lOVE1fTUFTSyAvIERNQV9CVVNfTU9E
RV9JTlRNX01PREUxLCBidXQgd2l0aGluIGR3eGdtYWMyLmgNCj4gdGhlIGVzdGFibGlzaGVkIGNv
bnZlbnRpb24gYXBwZWFycyB0byBiZSBYR01BQ18qLg0KPiANCj4gVGhlIHJlZmVyZW5jZWQgcHJl
Y2VkZW50IGNvbW1pdCA2Y2NmMTJhZTExMWUgdXNlcyBGSUVMRF9QUkVQKCkgLw0KPiB1MzJfcmVw
bGFjZV9iaXRzKCkgcmF0aGVyIHRoYW4gYSBoYW5kLXJvbGxlZCBTSElGVCBjb25zdGFudC4gIFdv
dWxkIGl0DQo+IGJlIGNsZWFuZXIgdG8gZHJvcCBETUFfTU9ERV9JTlRNX1NISUZUIGFuZCB1c2Ug
RklFTERfUFJFUCgpIGhlcmUgdG9vPw0KPiANCj4+ICAgI2RlZmluZSBYR01BQ19ETUFfU1lTQlVT
X01PREUJCTB4MDAwMDMwMDQNCj4+ICAgI2RlZmluZSBYR01BQ19XUl9PU1JfTE1UCQlHRU5NQVNL
KDI5LCAyNCkNCj4+ICAgI2RlZmluZSBYR01BQ19SRF9PU1JfTE1UCQlHRU5NQVNLKDIxLCAxNikN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd3hn
bWFjMl9kbWEuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3eGdtYWMy
X2RtYS5jDQo+PiBpbmRleCAwMzQzN2YxY2YzZGYuLjM3ODliNjJjZDJlMyAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3eGdtYWMyX2RtYS5jDQo+
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd3hnbWFjMl9kbWEu
Yw0KPj4gQEAgLTMxLDYgKzMxLDEzIEBAIHN0YXRpYyB2b2lkIGR3eGdtYWMyX2RtYV9pbml0KHZv
aWQgX19pb21lbSAqaW9hZGRyLA0KPj4gICAJCXZhbHVlIHw9IFhHTUFDX0VBTUU7DQo+PiAgIA0K
Pj4gICAJd3JpdGVsKHZhbHVlLCBpb2FkZHIgKyBYR01BQ19ETUFfU1lTQlVTX01PREUpOw0KPj4g
Kw0KPj4gKwlpZiAoZG1hX2NmZy0+bXVsdGlfaXJxX2VuKSB7DQo+PiArCQl2YWx1ZSA9IHJlYWRs
KGlvYWRkciArIFhHTUFDX0RNQV9NT0RFKTsNCj4+ICsJCXZhbHVlICY9IH5ETUFfTU9ERV9JTlRN
X01BU0s7DQo+PiArCQl2YWx1ZSB8PSAoRE1BX01PREVfSU5UTV9NT0RFMSA8PCBETUFfTU9ERV9J
TlRNX1NISUZUKTsNCj4+ICsJCXdyaXRlbCh2YWx1ZSwgaW9hZGRyICsgWEdNQUNfRE1BX01PREUp
Ow0KPj4gKwl9DQo+PiAgIH0NCj4gDQo+IElzIHRoaXMgbmV3IGJsb2NrIHJlYWNoYWJsZSBvbiBh
bnkgcGxhdGZvcm0/DQo+IA0KPiBBIHRyZWUtd2lkZSBzZWFyY2ggZm9yIG11bHRpX2lycV9lbiBy
ZXR1cm5zIG9ubHkgdGhyZWUgcmVmZXJlbmNlczogdGhpcw0KPiByZWFkIHNpdGUgYW5kIHRoZSB0
d28gc3RydWN0IGRlY2xhcmF0aW9ucyBhZGRlZCBiZWxvdy4gIE5vdGhpbmcgYXNzaWducw0KPiBk
bWFfY2ZnLT5tdWx0aV9pcnFfZW4gYW55d2hlcmUsIHNvIHRoZSBjb25kaXRpb24gYXBwZWFycyB0
byBhbHdheXMgYmUNCj4gZmFsc2UgYW5kIElOVE09MSB3b3VsZCBuZXZlciBiZSBwcm9ncmFtbWVk
Lg0KPiANCj4gRm9yIGNvbXBhcmlzb24sIHRoZSBhbmFsb2dvdXMgbXVsdGlfbXNpX2VuIGlzIHNl
dCB1cCBpbiBzdG1tYWNfbWFpbi5jOg0KPiANCj4gICAgICBwcml2LT5wbGF0LT5kbWFfY2ZnLT5t
dWx0aV9tc2lfZW4gPQ0KPiAgICAgICAgICAgICAgKHByaXYtPnBsYXQtPmZsYWdzICYgU1RNTUFD
X0ZMQUdfTVVMVElfTVNJX0VOKTsNCj4gDQo+IGFuZCBpcyBjb25zdW1lZCBmcm9tIGdsdWUgZHJp
dmVycyBzdWNoIGFzIGR3bWFjLWludGVsLmMsIGR3bWFjLWxvb25nc29uLmMsDQo+IGFuZCBkd21h
Yy1zMzIuYy4gIFNob3VsZCBhbiBlcXVpdmFsZW50IGFzc2lnbm1lbnQgYW5kIGEgY29ycmVzcG9u
ZGluZw0KPiBwbGF0IGZsYWcgKG9yIHRoZSBuZXcgcGxhdC0+bXVsdGlfaXJxX2VuIGZpZWxkKSBi
ZSB3aXJlZCB1cCBpbiB0aGlzDQo+IHBhdGNoIHNvIHRoZSBmZWF0dXJlIGFjdHVhbGx5IHRha2Vz
IGVmZmVjdD8NCj4gDQo+IFRoZSBjb21taXQgbWVzc2FnZSBhbHNvIHN0YXRlczoNCj4gDQo+ICAg
ICAgVGhlIFRYL1JYIE5PUk1BTCBpbnRlcnJ1cHQgY2hlY2sgaXMgZGVjb3VwbGVkIHNpbmNlIHRo
ZSBOSVMgYml0IGlzDQo+ICAgICAgbm90IGFzc2VydGVkIGZvciBUSS9SSSBldmVudHMgd2hlbiBJ
TlRNPTEuDQo+IA0KPiBidXQgdGhlIGRpZmYgdG91Y2hlcyBvbmx5IGR3eGdtYWMyX2RtYV9pbml0
KCkgYW5kIGRvZXMgbm90IG1vZGlmeQ0KPiBkd3hnbWFjMl9kbWFfaW50ZXJydXB0KCkgb3IgYW55
IG90aGVyIElTUi9pbnRlcnJ1cHQtc3RhdHVzIHBhdGguICBUaGUNCj4gZXhpc3RpbmcgZHd4Z21h
YzJfZG1hX2ludGVycnVwdCgpIGFscmVhZHkgdGVzdHMgWEdNQUNfUkkgYW5kDQo+IFhHTUFDX1RJ
IHwgWEdNQUNfVEJVIGluZGVwZW5kZW50bHkgb2YgWEdNQUNfTklTOg0KPiANCj4gICAgICBpZiAo
bGlrZWx5KGludHJfc3RhdHVzICYgWEdNQUNfUkkpKSB7DQo+ICAgICAgICAgICAgICAuLi4NCj4g
ICAgICB9DQo+ICAgICAgaWYgKGxpa2VseShpbnRyX3N0YXR1cyAmIChYR01BQ19USSB8IFhHTUFD
X1RCVSkpKSB7DQo+ICAgICAgICAgICAgICAuLi4NCj4gICAgICB9DQo+IA0KPiBJcyB0aGlzIHBh
cmFncmFwaCBjYXJyaWVkIG92ZXIgZnJvbSB0aGUgZWFybGllciBkd21hYzQgY29tbWl0DQo+IDZj
Y2YxMmFlMTExZSwgb3IgaXMgYSBjb21wYW5pb24gaHVuayBtaXNzaW5nIGZyb20gdGhpcyBwYXRj
aD8NCj4gDQo+PiAgIHN0YXRpYyB2b2lkIGR3eGdtYWMyX2RtYV9pbml0X2NoYW4oc3RydWN0IHN0
bW1hY19wcml2ICpwcml2LA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3RtbWFjLmgg
Yi9pbmNsdWRlL2xpbnV4L3N0bW1hYy5oDQo+PiBpbmRleCA0NDMwYjk2N2FiZGUuLjVkZWFhMWE3
OTdhNSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc3RtbWFjLmgNCj4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvc3RtbWFjLmgNCj4+IEBAIC0xMjIsNiArMTIyLDcgQEAgc3RydWN0IHN0bW1h
Y19kbWFfY2ZnIHsNCj4+ICAgCWJvb2wgZWFtZTsNCj4+ICAgCS8qIG11bHRpX21zaV9lbjogc3Rt
bWFjIGNvcmUgaW50ZXJuYWwgKi8NCj4+ICAgCWJvb2wgbXVsdGlfbXNpX2VuOw0KPj4gKwlib29s
IG11bHRpX2lycV9lbjsNCj4+ICAgCS8qIGF0ZHM6IHN0bW1hYyBjb3JlIGludGVybmFsICovDQo+
PiAgIAlib29sIGF0ZHM7DQo+PiAgIH07DQo+PiBAQCAtMzQ5LDYgKzM1MCwxMSBAQCBzdHJ1Y3Qg
cGxhdF9zdG1tYWNlbmV0X2RhdGEgew0KPj4gICAJdTggdmxhbl9mYWlsX3E7DQo+PiAgIAlib29s
IHByb3ZpZGVfYnVzX2luZm87DQo+PiAgIAlpbnQgaW50X3NuYXBzaG90X251bTsNCj4+ICsJaW50
IGV4dF9zbmFwc2hvdF9udW07DQo+PiArCWJvb2wgaW50X3NuYXBzaG90X2VuOw0KPj4gKwlib29s
IGV4dF9zbmFwc2hvdF9lbjsNCj4+ICsJYm9vbCBtdWx0aV9tc2lfZW47DQo+PiArCWJvb2wgbXVs
dGlfaXJxX2VuOw0KPj4gICAJaW50IG1zaV9tYWNfdmVjOw0KPj4gICAJaW50IG1zaV93b2xfdmVj
Ow0KPj4gICAJaW50IG1zaV9zZnR5X2NlX3ZlYzsNCj4gDQo+IEFyZSB0aGVzZSBmaXZlIG5ldyBw
bGF0X3N0bW1hY2VuZXRfZGF0YSBmaWVsZHMgdXNlZCBieSBhbnl0aGluZz8NCj4gDQo+IEEgdHJl
ZS13aWRlIHNlYXJjaCBmaW5kcyBubyByZWFkZXIgb3Igd3JpdGVyIGZvciBleHRfc25hcHNob3Rf
bnVtLA0KPiBpbnRfc25hcHNob3RfZW4sIGV4dF9zbmFwc2hvdF9lbiwgcGxhdC0+bXVsdGlfbXNp
X2VuLCBvcg0KPiBwbGF0LT5tdWx0aV9pcnFfZW4sIGFuZCB0aGV5IGFyZSBub3QgbWVudGlvbmVk
IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gVGhlIGNvbW1pdCBtZXNzYWdlIHNjb3BlIGlzIGxp
bWl0ZWQgdG8gZW5hYmxpbmcgSU5UTT0xIHBlci1jaGFubmVsIFNQSQ0KPiBJUlFzLCB3aGljaCB3
b3VsZCBvbmx5IHJlcXVpcmUgc3RtbWFjX2RtYV9jZmc6Om11bHRpX2lycV9lbi4NCj4gDQo+IFRo
ZSBzYW1lIGNvbmNlcHRzIGFscmVhZHkgYXBwZWFyIHRvIGJlIHJlcHJlc2VudGVkIHZpYSBwbGF0
LT5mbGFncyBiaXRzDQo+IChTVE1NQUNfRkxBR19NVUxUSV9NU0lfRU4sIFNUTU1BQ19GTEFHX0lO
VF9TTkFQU0hPVF9FTiwNCj4gU1RNTUFDX0ZMQUdfRVhUX1NOQVBTSE9UX0VOKSBhbmQgdGhlIGV4
aXN0aW5nIGludF9zbmFwc2hvdF9udW0gbWVtYmVyLg0KPiBDb3VsZCB0aGUgZm91ciB1bnJlbGF0
ZWQgZmllbGRzIGJlIGRyb3BwZWQgZnJvbSB0aGlzIHBhdGNoIGFuZCwgaWYNCj4gc3RpbGwgbmVl
ZGVkLCBiZSBpbnRyb2R1Y2VkIGluIGEgc2VwYXJhdGUgc2VyaWVzIHRoYXQgYWN0dWFsbHkgd2ly
ZXMNCj4gdGhlbSB1cD8gIEhhdmluZyBib3RoIGEgZmxhZ3MgYml0IGFuZCBhIGJvb2wgZm9yIHRo
ZSBzYW1lIGNvbmNlcHQNCj4gcmlza3MgZnV0dXJlIGRyaWZ0IGFib3V0IHdoaWNoIHJlcHJlc2Vu
dGF0aW9uIGlzIGF1dGhvcml0YXRpdmUuDQpBbGwgY29tbWVudHMgaGF2ZSBiZWVuIGFkZHJlc3Nl
ZCBhbmQgdXBkYXRlZCBpbiB2Mg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1
MDUwODAzMTEuMTc0MDUtMS1tdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVy
YS5jb20vDQoNCk5hemltDQoNCg==

