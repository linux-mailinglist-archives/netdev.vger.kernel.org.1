Return-Path: <netdev+bounces-202508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F08AEE19B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC50188FA3B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB5428DF31;
	Mon, 30 Jun 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="N6uRXteb"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022115.outbound.protection.outlook.com [40.107.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA628DB7D;
	Mon, 30 Jun 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295363; cv=fail; b=VR+n4yp9oWGOCrbTxnO12fdpVtcx6KLiANmjGOU8/jm+94/tr2wHukHl1k/ZJDUZS1AeRJjxrJW20SJXbP+JVz/d3qNwgwxylWawOwhCxWFBloBalDfDX6wuv9M7o9IFezkddh44JvE/3Aj6eMgKS60kV2kMBSF2u2ytHqzMQwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295363; c=relaxed/simple;
	bh=qNvR6bbULq0CYZs8GALDL6dDTsRjeTeRZTrTdleRPHw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ud77iYhYqTZxfFhlemDL2VRDIVbZxMGqkYXVUXCUWFDSArXYvEr9EZGDQF4BIVOJUamQGiRObOvPjk+WzU10E5hkakt6FffUSoF7Ah1vtWF9qkodWRHwe+9dBKlGpLEKr1CdIbaIPCArJoWX1vUVZJTCiq01v5Vzi9RYbRhfiVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=N6uRXteb; arc=fail smtp.client-ip=40.107.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6lOufwKzZTMduKFzxoY8PD+7UcT7mafN/gz/3B35qwUCFoSkLi+QnoMpT0vAozjkshzjT9jjgSMjRdCCdyWC88FkYq9bVyVIjjV/hRo8SVfkGEJVGlrLM346xgBLmglj69FtXf4XbCF+OPkEWEv5VWbRCyc0+nIWOuUbI+MvGBNLX9drIXzc6CuTmtLspRIVvGOajYIRmSS0ma4uI7GkOY0A2Zd5oyEx5HOeeZpS4PbOTtDeR9I0EraWfNqaF7IELbO7ih5Gh2K8/uAyZtlhiP+wy9Yk/Ic7ML8F4VOuNDcjPOeplfs9YeIZcE5aC5YVF8tWlSuBeudvKOb92N28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNvR6bbULq0CYZs8GALDL6dDTsRjeTeRZTrTdleRPHw=;
 b=g0dpCa8D1gLN/bbiJHwVl/bfcVtIYX7nqv/tLjE3EiTFCNMTmqsnt7tubbhDWOIpcseQ+hcVPHZvI0IAgnEbVfVpjRSGObATNkJ2qrnRlnX21y+9IRVWRQ7jr4bNOsTqjWnBtpKqCz+vNrjY8sZq6xflt+TRl/d4YBPrp6L/UrJaK6Az/O6EOV7earlbZqR3ZuNu4cFqbd974o7X0RimEaqEVvZoKoEMPwy+FQPzVSFGzVpBMAxNDzRLruMTAk9IxqRSYmn5Pi/0BYzH1BRllzzkx++19sVHdJCJb5rakx7pptTyARr58PDSxHvo9YBgQsJ6Xh8VPHbN0EwoEyw35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNvR6bbULq0CYZs8GALDL6dDTsRjeTeRZTrTdleRPHw=;
 b=N6uRXtebZKhW5HCs2N4tHFb4avlds290/06jqi/LkYWTo29sRYnSLkhxINo0QjDtGARY+7mI3P9ziPIDLiEAtT8igXa9TeU3nH9fQEXETMgxQ59u+j7+sr0oBHh1NJflWqsHngqzKUiabiK4eBK/f1JOTj+sDfQfCf1dOD90AYo=
Received: from FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::26)
 by FR6P281MB3553.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 14:55:54 +0000
Received: from FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84a9:2a79:4c0d:e41a]) by FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84a9:2a79:4c0d:e41a%3]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 14:55:54 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH net-next v4 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHb6c8U2p8lLJQ8ykWgHL26TvuA0g==
Date: Mon, 30 Jun 2025 14:55:54 +0000
Message-ID: <c0c284b8-6438-4163-a627-bbf5f4bcc624@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF3DF8BD4D5:EE_|FR6P281MB3553:EE_
x-ms-office365-filtering-correlation-id: 224ad949-a71e-4432-1af5-08ddb7e636d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejFwRnM1SXZKaXc0Qk9YYmlVb01sOGtpTlZyUXdPN295RmZ5Y1E3QWVRdDRR?=
 =?utf-8?B?a2ZJVmJ0VTVqM2RRSm95V3pLek81WmdhUTBUQjduM1Y4OWZpRHkxQzdYWmNt?=
 =?utf-8?B?MUQxbXVOS0JDSVlzMEk2WGc5ejdWTlZESEtPUDRUSkJSSjl0Z3huQVVpWVAx?=
 =?utf-8?B?bUhCZDNCYnJPNnR4NTlVTmdaOWN6eFJ1TkFBcXhxdEF2K3VGZUE1OTk1Z1Uv?=
 =?utf-8?B?TXlnUnM1S1BFWUdsK0dDcVM3SFJBK2FBUi9WNjNWMHRlbm4yTHFPdVZzU1Bs?=
 =?utf-8?B?eWVPalpCaXZ2Z0IwTWhnSmFuNU9Mek0yMlh2SUExc3VJRzVuVEVudDlBL3dI?=
 =?utf-8?B?R1pDcGhWZ3pUekJrRHQ5YjBYZENsdEYwdEpRMTZWSmkyamhnK2tnNGwvM2tT?=
 =?utf-8?B?REZ0bUc5OXhWYnZMRGV2VW1saXdWQ2xpelNybTFuR3dxM2s5SWQzcmVSanlu?=
 =?utf-8?B?ZlZDZDlKS1NncGVWQjkya0k5MU04MExieW9pOXVEMVI3OFU2VTByVDA2M28y?=
 =?utf-8?B?NFpXZXZQdldkQnNpWENDUUZ0b0ZMOExGcm8rY1cxZUlpZzhRdlptYzJEVkpx?=
 =?utf-8?B?MW84blhlNTB2aGFkeURUQVpmYURnRHAzem05M3hYa05JT0dTUllyQmhWeVpy?=
 =?utf-8?B?K2xmYld6TllvOGRUaWRpU0pHYm9hLzhJclM4eC85NWdqV0RtMk1DUXliR0FY?=
 =?utf-8?B?cHpvZUlmWjU3VkMxaE9ySnJXZTBmcHg4T1Y1Z25DMnJKdkkyZ3NTR2xLb3hi?=
 =?utf-8?B?ZHFFbHFFRnFHRkt4RnBNRHVLYnJibE9NVW5ueGx4R3Nid0UwdEp5aU1nbG5K?=
 =?utf-8?B?NkNyZ3Y4M1l6bUF3WnhoSW1Od1RqMXZvWStvNHcvcjErZDN6ajE0YnBJYkwx?=
 =?utf-8?B?Z3JiRDBIR3ZsaitpY083aEIxcCtzQlI5MDc5dGcwcjNCSE5lZk4xRHBnWEVu?=
 =?utf-8?B?OXlBTURFQXg2dy9jd0J5VGxST3BlUnYxSFFEaFlXejRoOUxEb2diQ3ZISDF0?=
 =?utf-8?B?bmlKZDdjQ1hmd2lEM096WVN0OVplaXZQbU56ZDMwa0J1alByOHlYM2wyeU1x?=
 =?utf-8?B?YzVZUFlzbmdYZXMvVmRXSG85b2d3VXl4Z2NqVFNYM3VUYlVJRGptTHV4T25V?=
 =?utf-8?B?OVRSamRUUi83TzVRNWw0OTg4TjgwaUt0dUxEVllYRGdsMUlnbDJqV1E0VXly?=
 =?utf-8?B?eXZ5ZU4xWjZkRFVnRU9TNytQYXR1MkhWMVU5R1pTdjNVeWpWaXVmYVY0MHh5?=
 =?utf-8?B?c3IyTDhMZ2J1WlU3RnVVWmZXVkE3MW0zMjdiZVh3bUhFOFRGbzJlTGZXUG5X?=
 =?utf-8?B?VWNQMnRqMW41b1lpK0FZMXVxVU8yWXEzajVERVNxRTZneDQ1czlYUUo2eXAr?=
 =?utf-8?B?K0I2d29KM3RVT2gzSXlIT1kvWlRqY2ZSeTZoUEpoOFR1VktVbC9tZ3p4bExR?=
 =?utf-8?B?bkFBTmRvMHhseldHRFdUR0QwemU5V1daNHREak9FTXMyL1FVWWhTZXZtOG1J?=
 =?utf-8?B?MFJCblBTbnlNVUtSeDdEZmpWQm01b2p2NlRDMDFJN29kYmtVY0VSTGlLc2lK?=
 =?utf-8?B?TXZURjhOeDVTZERDRWtoOE1yWXBML0hIaldjWXZOY2FJY3ZjRmZqUzZGRGVk?=
 =?utf-8?B?RzRaOTNjeFZRd25EUUdhNEZVcGZVdkV0NGdHTE9LcmhvNFJtNExXaXR4RkRO?=
 =?utf-8?B?RmRaZVVJTytGZ2hydXlZV21vLyswenVSeDkrTDJvdkpIMnR4YjluNW9YM1dP?=
 =?utf-8?B?Ukl6azJET2IybHJqTWVPb1BOakRqU2FObkdxV1FRZEY1bmZmb2NwMmpRZDN4?=
 =?utf-8?B?QmJEVjhnMTNSNEVqRHBoQjFBaGRUOVp5UXgvNUpvdm5SL3g4RW9Rc3FIYXVo?=
 =?utf-8?B?NEc2ZWt2MFdrQnBWR2FpdkpUYkFFSkl6eWhsMFdITEYzY2FjMFhleFQ4N2Va?=
 =?utf-8?Q?SalNDQzU9uzdVUcP6ojODQNUnXHX+aIn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UElORFEyMEpOQkVocE51ODlja25ueWFsVDJ6MHBFZUptQkZNOUIydGM4dUR2?=
 =?utf-8?B?L0xveEIxWmNtU2prM2xvS255ejdVamd6RUlNRERiV1BpdU05U3JCazZNVUY2?=
 =?utf-8?B?aSt1VFlSTjdVa3duMEpkTmpyQUdoTFdhWUQ3clczcmZCTENwbllQK2NTcFkx?=
 =?utf-8?B?alFIVW1BU1llejhPTUVTWUN2L1V0a21wT296TzF1aWpDL3Q4OHVuWk83TGpW?=
 =?utf-8?B?VUlGNzhFbkhwaG5GMG94eGczQVNQWEl1SG5LYmZjYVFqaGM3dXN0b21heXVO?=
 =?utf-8?B?ci95YTlxQmdhL3BaK1lreEw5dVcrcVlVRHRtMEE5NnNnZVdXWC9iZ2NIZ0tL?=
 =?utf-8?B?RGk0bVFKazNsMi9zUnl3WXRJUkFYeG1KVDA5empmQlJaeXZLOGcwVVJ4eTZr?=
 =?utf-8?B?UkpZcHo3eFlpSE02aXJyYXNmV0JjVnlseW4waC9SVUtHSnBrbVl4bDB6YTc0?=
 =?utf-8?B?b1J5U1pxU1dXKzd1QXRYazNsWmdsR2Y3VnVZRUVNbWx1aWdHejFPMFRxTDNU?=
 =?utf-8?B?WnhWbU1NVGV0TnJ3QkZKaVZUOTQrTlVJRGptZEZCa2J0ZC94L1g1TVo4TG56?=
 =?utf-8?B?UHRxRUd3U3ZMOWIxNWduWkQzbTFQYWtETHUwZGIwUU5abHJzNFdzSGJZYjdD?=
 =?utf-8?B?b0ZrWGt0ek84eHVmc0Y2OHNFZmVMNlZOelFWV2RMU2RCUjJkODRHUkFNcDhN?=
 =?utf-8?B?TkNBTUl3TmJGazFueFBGVlBFeEUvanBiOUtyNzd5azArZDdUL01IQlBGS1Ey?=
 =?utf-8?B?ZGhsQUJkQ3I1bzRLWjZOUlZyZkVidzMzcWcwaXRxMWJBSDF2TWx1MHF6YkRO?=
 =?utf-8?B?UlVXd0FqbzV1Qm4xZ3YxUXRQenU0UWNJYktTRExuU3VKVUFLYkhJaWJ1WHV1?=
 =?utf-8?B?TGtWWVN3Y2tzRWZVeHZCc2Vja1ozZnMybFRKQStleDBmaU9PSjdMMDNDMHM5?=
 =?utf-8?B?WjdVN3BnMEJzMDY1dVBQZGl5RzREcDRXcnZidmFBTUJaRXU5Uldya2llNjEx?=
 =?utf-8?B?c0lFclJrRlRvTWxabTlUbUg4ZnNYRER3UnZDQ2JSQm5rdWhUbTljL011Z3hz?=
 =?utf-8?B?cEdzYXNSWmNrbTdkamY0WFVyTGdJQTNSOFNzeXJSQnhyc0xxeDJTSEw5SG01?=
 =?utf-8?B?NEJjdHFzdjZmeWo5eDdIcGE0RlRYNlRNNXVDbjZ0c21IdHhMOE45SlZxUldk?=
 =?utf-8?B?RGJkdExINEtYdDRLYTJBUnQ5V1BqUStKNGV6bVZSTU4rVnQ0aU9hZWlZVStr?=
 =?utf-8?B?TThnWnlXRS83c1phSm5ZaStFejZNMkN6a3lUNXJqRnJOQ0pmcW9NaWRpMy9y?=
 =?utf-8?B?ZmQ5TEU5WjdRcDVTS2FOOWVhZU80NlVIK0Zzb2Y1VWJEa2tUYnkwQWl2Nmp5?=
 =?utf-8?B?QU4vNHFNcEYrY0huQm8wUG5uTW1EUXF6aGxvaDlYYVZPOUFsQ3BKUkRFNXM5?=
 =?utf-8?B?OG9pUkdXWVM0RXRjNzlTdkZzYTVRWSt0ZUxRU2w2aURXaFIyVkU5NlQ4a1Y5?=
 =?utf-8?B?SVVvRS9PeGQyUTNhSXh6Q0ovV3FnaXMvbkNyeEVPaVJvNGxpaEJ2WXJHMXh1?=
 =?utf-8?B?QVE3d1JTc1grbDBYZGZYZjVWbHFYWnRqMXV6MFp2QW9lMU5HVWlxUDgrYVZv?=
 =?utf-8?B?OTBoenBDQ1JvSThFS2ZBck1FMVE0Wkl0UEJ2SC9idnJXT2dJc1B3SjNHemhY?=
 =?utf-8?B?dWNDWmJBLzUwdWhJRXp1Z0l1UHZPYXhRdFI5QXhqMk16YTdSb2ZOc1d1YnV1?=
 =?utf-8?B?WkFCUGFVeXZIa0hnWmZ5QklMWmFIQkJZakxOa0s5L1hGb250M0NvNDBEQjR6?=
 =?utf-8?B?c1FUdGV0dDZLU1pCTGlWY2JOaS8xM1V6U3VuWEpuU1BJYXBteEVneWt3WkM0?=
 =?utf-8?B?cTEwVmNkU0NtdkRnVnpobUMwSkFHekdBdHJGRTR5RlBuYmhTU2txNzRkQjlJ?=
 =?utf-8?B?SEVXVkhlWE5OT01TVkdOMzVucHlac3Z5cUk2ckxaZVE2WElnZ3VuazNJdEtp?=
 =?utf-8?B?UFJqL0FNcFNGbTFMTkQ0VUlORTBVeElyK1Q5Zm04b3lFSk52NHhhWGFacFFX?=
 =?utf-8?B?ajBJcHg1ang3aWFucGVsbHBsTHRxVVJxdHJwbURDR2FiRVRSeDZsUisyZHN2?=
 =?utf-8?Q?zLkDII0V/0wDwZnDakXoIvMIU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D98A5C374DA62348A1F13D3EBE7FF056@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ad949-a71e-4432-1af5-08ddb7e636d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 14:55:54.6459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qo/6Agz41PfdihwkgT0JGrDbKSWjFVeDBO1b/xZXkV9bYQsG31wQMMBq1v6ASX75YTma6gRG6PLbZXIti2mdUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3553

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNClRoZXNlIHBhdGNo
IHNlcmllcyBwcm92aWRlIHN1cHBvcnQgZm9yIFNreXdvcmtzIFNpMzQ3NCBJMkMgUG93ZXINClNv
dXJjaW5nIEVxdWlwbWVudCBjb250cm9sbGVyLg0KDQpCYXNlZCBvbiB0aGUgVFBTMjM4ODEgZHJp
dmVyIGNvZGUuDQoNClN1cHBvcnRlZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQotIGdldCBwb3J0IHN0
YXR1cywNCi0gZ2V0IHBvcnQgcG93ZXIsDQotIGdldCBwb3J0IHZvbHRhZ2UsDQotIGVuYWJsZS9k
aXNhYmxlIHBvcnQgcG93ZXINCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1
YmlrQGFkdHJhbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2NDoNCiAgLSBSZW1vdmUgcGFyc2lu
ZyBvZiBwc2UtcGlzIG5vZGU7IG5vdyByZWxpZXMgc29sZWx5IG9uIHRoZSBwY2Rldi0+cGlbeF0g
cHJvdmlkZWQgYnkgdGhlIGZyYW1ld29yay4NCiAgLSBTZXQgdGhlIERFVEVDVF9DTEFTU19FTkFC
TEUgcmVnaXN0ZXIsIGVuc3VyaW5nIHJlbGlhYmxlIFBJIHBvd2VyLXVwIHdpdGhvdXQgYXJ0aWZp
Y2lhbCBkZWxheXMuDQogIC0gSW50cm9kdWNlIGhlbHBlciBtYWNyb3MgZm9yIGJpdCBtYW5pcHVs
YXRpb24gbG9naWMuDQogIC0gQWRkIHNpMzQ3NF9nZXRfY2hhbm5lbHMoKSBhbmQgc2kzNDc0X2dl
dF9jaGFuX2NsaWVudCgpIGhlbHBlcnMgdG8gcmVkdWNlIHJlZHVuZGFudCBjb2RlLg0KICAtIEtj
b25maWc6IENsYXJpZnkgdGhhdCBvbmx5IDQtcGFpciBQU0UgY29uZmlndXJhdGlvbnMgYXJlIHN1
cHBvcnRlZC4NCiAgLSBGaXggc2Vjb25kIGNoYW5uZWwgdm9sdGFnZSByZWFkIGlmIHRoZSBmaXJz
dCBvbmUgaXMgaW5hY3RpdmUuDQogIC0gQXZvaWQgcmVhZGluZyBjdXJyZW50cyBhbmQgY29tcHV0
aW5nIHBvd2VyIHdoZW4gUEkgdm9sdGFnZSBpcyB6ZXJvLg0KICAtIExpbmsgdG8gdjM6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9mOTc1ZjIzZS04NGE3LTQ4ZTYtYTJiMi0xOGNlYjkx
NDg2NzVAYWR0cmFuLmNvbQ0KDQpDaGFuZ2VzIGluIHYzOg0KICAtIFVzZSBfc2NvcGVkIHZlcnNp
b24gb2YgZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZSgpLg0KICAtIFJlbW92ZSByZWR1bmRhbnQgcmV0
dXJuIHZhbHVlIGFzc2lnbm1lbnRzIGluIHNpMzQ3NF9nZXRfb2ZfY2hhbm5lbHMoKS4NCiAgLSBD
aGFuZ2UgZGV2X2luZm8oKSB0byBkZXZfZGJnKCkgb24gc3VjY2Vzc2Z1bCBwcm9iZS4NCiAgLSBS
ZW5hbWUgYWxsIGluc3RhbmNlcyBvZiAic2xhdmUiIHRvICJzZWNvbmRhcnkiLg0KICAtIFJlZ2lz
dGVyIGRldm0gY2xlYW51cCBhY3Rpb24gZm9yIGFuY2lsbGFyeSBpMmMsIHNpbXBsaWZ5aW5nIGNs
ZWFudXAgbG9naWMgaW4gc2kzNDc0X2kyY19wcm9iZSgpLg0KICAtIEFkZCBleHBsaWNpdCByZXR1
cm4gMCBvbiBzdWNjZXNzZnVsIHByb2JlLg0KICAtIERyb3AgdW5uZWNlc3NhcnkgLnJlbW92ZSBj
YWxsYmFjay4NCiAgLSBVcGRhdGUgY2hhbm5lbCBub2RlIGRlc2NyaXB0aW9uIGluIGRldmljZSB0
cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbi4NCiAgLSBSZW9yZGVyIHJlZyBhbmQgcmVnLW5hbWVz
IHByb3BlcnRpZXMgaW4gZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uLg0KICAtIFJl
bmFtZSBhbGwgInNsYXZlIiByZWZlcmVuY2VzIHRvICJzZWNvbmRhcnkiIGluIGRldmljZSB0cmVl
IGJpbmRpbmdzIGRvY3VtZW50YXRpb24uDQogIC0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbmV0ZGV2L2JmOWU1Yzc3LTUxMmQtNGVmYi1hZDFkLWYxNDEyMGM0ZTA2YkBhZHRy
YW4uY29tDQoNCkNoYW5nZXMgaW4gdjI6DQogIC0gSGFuZGxlIGJvdGggSUMgcXVhZHMgdmlhIHNp
bmdsZSBkcml2ZXIgaW5zdGFuY2UNCiAgLSBBZGQgYXJjaGl0ZWN0dXJlICYgdGVybWlub2xvZ3kg
ZGVzY3JpcHRpb24gY29tbWVudA0KICAtIENoYW5nZSBwaV9lbmFibGUsIHBpX2Rpc2FibGUsIHBp
X2dldF9hZG1pbl9zdGF0ZSB0byB1c2UgUE9SVF9NT0RFIHJlZ2lzdGVyDQogIC0gUmVuYW1lIHBv
d2VyIHBvcnRzIHRvICdwaScNCiAgLSBVc2UgaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YSgpIGZv
ciBzaW5nbGUgYnl0ZSByZWdpc3RlcnMNCiAgLSBDb2Rpbmcgc3R5bGUgaW1wcm92ZW1lbnRzDQog
IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L2E5MmJlNjAzLTdh
ZDQtNGRkMy1iMDgzLTU0ODY1OGE0NDQ4YUBhZHRyYW4uY29tDQoNCi0tLQ0KUGlvdHIgS3ViaWsg
KDIpOg0KICBkdC1iaW5kaW5nczogbmV0OiBwc2UtcGQ6IEFkZCBiaW5kaW5ncyBmb3IgU2kzNDc0
IFBTRSBjb250cm9sbGVyDQogIG5ldDogcHNlLXBkOiBBZGQgU2kzNDc0IFBTRSBjb250cm9sbGVy
IGRyaXZlcg0KDQogLi4uL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0LnlhbWwg
IHwgMTQ0ICsrKysrDQogZHJpdmVycy9uZXQvcHNlLXBkL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgIHwgIDExICsNCiBkcml2ZXJzL25ldC9wc2UtcGQvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYyAgICAgICAgICAgICAgICAg
ICB8IDU4NCArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDc0MCBpbnNlcnRp
b25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYw0KDQotLSANCjIuNDMuMA0KDQoNClBpb3RyIEt1
YmlrDQoNCnBpb3RyLmt1YmlrQGFkdHJhbi5jb20NCnd3dy5hZHRyYW4uY29tDQoNCg==

