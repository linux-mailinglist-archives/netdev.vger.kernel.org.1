Return-Path: <netdev+bounces-164120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76324A2CA73
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7A188D426
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B4199E84;
	Fri,  7 Feb 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="AyLDY2TZ"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010048.outbound.protection.outlook.com [52.101.228.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED9199948
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950203; cv=fail; b=g3qa7jZUoPrwBIecM+1iROP/wJKzPt07S3poBQTIz5lvp/ZVXve4PMbhNChtzZofJGYNlWmW9CmwSRm+kJoYYXe278vycqaJ4G1PnlAKq4rOdYRGVlTe7HUPHUo65Owjidi7qoM4hzIptBQSlc5fpcA8q1Ev9+rr9lH9JLkL+LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950203; c=relaxed/simple;
	bh=HV5J1mkS7RFVsMTx3d1j9RzhfoSqjT1XKRfKtgbfO9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kA6Qvo4It4pJte1Ue+nKNx7PXHdSdG8YOCdMVhx/Z3dFMa4w0x3qhntNUDT+FdXTfin0RvKtrrw9qh994JODaTjVtPLNg3NIl7Kj44/mRYqpeI9rxtGVoS6iYsdZgKue1pEb3Fq3e7wMC3/6eL+0IEEfwjyPbjjQ1AOWWYscXdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=AyLDY2TZ; arc=fail smtp.client-ip=52.101.228.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP9VXPJCVTShjboIrZyT2N9ASDZIIMUeM7WbsY07gpvFuNqFTHyAd6qnryAWU6OxotXes565i7TnEtYjOQxUBD/AyUUNPYTXSe7AHYBQGQmY+gL9KtB30zdUFK2D0QssAO417506BgzIQ+milLyev2VYMdjwkokhlgrlgQwqxlgSdkOtwR3q9f9YUZIgDF+QyyHJBOo7FbsXfgcOwxRAA14lOkZV4tNHBiGPLK3b/yiZGtp46HJZWFiLPTklaS2/rBpR1168QfB7jXWk6foQrYmaAs+fCP2DSQ5KckuQGczOHa5RJ53gK6n/28YLNKrm4a8FgoKs8zniOnuvUE37Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV5J1mkS7RFVsMTx3d1j9RzhfoSqjT1XKRfKtgbfO9g=;
 b=cYEOJ+j5IkWsiCoPQs5VNEw/FFDT2HnwDBYt/u08R0hZjuBLcK368nYjH3wTqyTSpT/3jTPqWIlzFg7WY6dB4IWhFCWM+KveCW4tV0qPlRnAG+2aH0oqIUeWfUX9ImFo9OZoDsoDyGLVYjdSKqnHMz135gYi0knvryJRc/bRkKysGEi9XjKrupfyviirtGrtRiSv2EKfAzr5q98I968bmWgJhLL4cInwLKoNq2KG7GxH3fbr+DlqszRSd2Z1R2eLkyMjC9I+xuWInxgUwGOC3LeqAkBM5dyvG4hhMkncFXiLLYEfrncP/7fKeuPo3vR8vS8mrscFT/U7Ax05WOuT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV5J1mkS7RFVsMTx3d1j9RzhfoSqjT1XKRfKtgbfO9g=;
 b=AyLDY2TZBWJAECDq/DbU0SejhMDI8REEiLAASQgfHMzBjHRZXQV0eiSNbNTPuENyfMze2DewLzknLsumqfp+03956TKOdS9eTxB1JJSBBBBa48DNigxQOFROhh1iMh0ye1MqnB06HC5Dqutq6WCyKC6Zygh/CERZFTRlkVzP+fI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSYPR01MB5479.jpnprd01.prod.outlook.com (2603:1096:604:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 17:43:16 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 17:43:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-actions@lists.infradead.org"
	<linux-actions@lists.infradead.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, biju.das.au <biju.das.au@gmail.com>
Subject: RE: [PATCH] net: ethernet: actions: Use
 of_get_available_child_by_name()
Thread-Topic: [PATCH] net: ethernet: actions: Use
 of_get_available_child_by_name()
Thread-Index: AQHbdMztfdJnKN+rHk+g1K6pJhdyerM8JPsAgAAAT8A=
Date: Fri, 7 Feb 2025 17:43:15 +0000
Message-ID:
 <TY3PR01MB1134690C1C6D05E953B28904C86F12@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250201171530.54612-1-biju.das.jz@bp.renesas.com>
 <20250207173952.lpeazjyxnhfuhwb3@thinkpad>
In-Reply-To: <20250207173952.lpeazjyxnhfuhwb3@thinkpad>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSYPR01MB5479:EE_
x-ms-office365-filtering-correlation-id: 74735ec5-ec52-4841-0d43-08dd479ee6c9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1JLUFVjYUZ5Mnh1bFdoS01ncnZ2QTkzWTBxcmljZUNraUdZTjMrVWhjMVJO?=
 =?utf-8?B?dWtieHhZd2ZidUEyRVVJM1ZKd0dxMjVITGJlK3FQdVlQd043QWRYU1NEOUtU?=
 =?utf-8?B?K2dyYnB4L01rTis5MU5FQ1ZZWWVzMEVER2o0WUJIY1hURmFRNWtENFBGWHJs?=
 =?utf-8?B?LzYwUXV4bHl1OTVYOWRJOUN2MGJ6cHY5ZlV3T1R4dzlmbCs2S3QyRDdXSWdG?=
 =?utf-8?B?aTdQVDg5K0lSOWlYbWtpUHhacnVnS2M4U0FDanVrNDA2NjM3bjJ3N3licGY1?=
 =?utf-8?B?NkxzZDkwcUxQUVZrOWpvUlVua1FqQlZ1V1Ivc1BmaDYyUU9UZXZNTVVuTktk?=
 =?utf-8?B?eE1kTmhIWWtidXhrVkg0THV6SUZmdGZteGtvN0JvUnlVdjd6Uzk0L1BZSEJ0?=
 =?utf-8?B?bmdjUk4ydXluMTdXd0xqMGV3YzVsaVJabGZsUWFGTjRPMEtPMm0zay9TOUZW?=
 =?utf-8?B?U0Z5aTZQUnprQWdwSFFSbHNnNmcwaUwyaWJCT2VGRXh2UzBZclpJZ2NVSGVZ?=
 =?utf-8?B?NFUrdEg4MGp5MjAxYzhCaU1GUjFKV1NxeEUyY2gwU2F3S1hMWXFtdzVxdm42?=
 =?utf-8?B?WGhJZ3ZuN1pETHBCc0YrbHdwc0Z6TFBwbVBlS3VOSHNFcVlEV1ZlTDdLK0xD?=
 =?utf-8?B?djRvL3BOOGYyeHdnS2p5LzdZeFRITmN4T1lxVFhLeCswbXV6b3lhekJLVW5V?=
 =?utf-8?B?VkZnakIvTmc2eTFxWmcweCtxY1NaZmFyUjlMZDdkVS9saVk4UkIyRmc2RVhB?=
 =?utf-8?B?VWFQZEZkVnNPcHNscExsVGI5TUFsWlF3bUxrZnRmZ0F2d3Jtd1pUVnFUUE14?=
 =?utf-8?B?bzhyVjJ6WGdnbHh6Y3F6SHp3NEVjSlFNTWdwU2VNb3BzREcyNUhhazlwVFQx?=
 =?utf-8?B?TDZENE9tYzRQNStrWThzOGpqSE0rUXZrNHZjN3BnKytZV2QwWGpvWTNYNzU5?=
 =?utf-8?B?OEdUK0xnRzZLc2NWWVNHQ0pmMDhYcDRWMFEzK2tHa3hSRlB1UVN2WVBxSmVV?=
 =?utf-8?B?Y3hlR1BHT2tzSXFWd012eGI5Tk5zYldtOWpDZ2IzN3BUc0lhOFdzNUMyREl0?=
 =?utf-8?B?U0tTMHlJSTZpVEtzaXhUSnk3WlFoMmZUbjBqaGZnOGJQYUNHK2xSNzRzSkd6?=
 =?utf-8?B?cklJK1d2d1Eya1NzNklEaG15eG9EOVFlcGtnZ1prOVpIalpCSmV2d3hLVHR3?=
 =?utf-8?B?NTRUcnBuQUpveEw5M3hEMlBIZzcva0Fjbm9lNE93eVFKb1NmMDd2ZGpCWFlM?=
 =?utf-8?B?cjYrUWFRYVdoK0VuS1A5REU4M1JuU082VG1MUUsrT2k0ZFp3bFFFcVdkdW9q?=
 =?utf-8?B?S2QzS1lxWDBlb1dvU0REdHhNbGJKMENrVzY4SDVPK1g2aFZ0blV1bnE0UXpO?=
 =?utf-8?B?ZDgyd3JzQlFuT1k2MFpQblVNZ1NSRTRvNkNrREtKbGtMQndjUlZQdGg5eHpE?=
 =?utf-8?B?VjhvYmp6T0VQRzRuSDJsVXdEdDBKTnVjdlJkL3NqY3ZqUk1xMmZlNkJITEZx?=
 =?utf-8?B?MkNHWUMwcUhIWExJQmgwWGJYQkRuWld6Z0NIM1YxYVJqTUxtaFViY29mbEdZ?=
 =?utf-8?B?UmJYbHgzbW9BZmxEQ1U4WTdJWXhzazFSMC9iTldPWkdFLzBLL1JETnhmQkZ4?=
 =?utf-8?B?SXc5b1YrbS9sUVVQUlEwTGxsV3pHaWtHeEZjQUJEMU1hN1lna1RzdDJ6MWkr?=
 =?utf-8?B?dVd2RllkZnlKejBrWGhMak8yQkxiSDZCWFdZdU5iaS8rU2d3M2E4aE8rWTZu?=
 =?utf-8?B?VnRJRDFSZVJNbjlJQXRSUkdGYk1OWGc2d01ldU9pQ3dZUnphZFpFSHFuL2Z5?=
 =?utf-8?B?RnFwUVFxWm5rU0R3Y2R1QVBaWUphRWgwYmFMdEVQU2N0UkUzUVJOcWtlOU9s?=
 =?utf-8?B?d3VEK0tMd0hoQ3JYSjNCOGxlWWFDQU1zWlg3bjZ5UWFXSzVWUVJlMUNrc3pu?=
 =?utf-8?Q?yDt2DZrQTezqGnaImjEn/KLfr2tc1nsD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eC9qc0xPbFgxZnhXVkhKK0dtazdNSEN1dDJMYkd0UTgzdjYzOXhvaFpSQmNG?=
 =?utf-8?B?WEFGUnM4cEs1MWVVUU8zd1B2emQvRUVCODVoQVRlMVQwUEpGWDJGdG1OYkRY?=
 =?utf-8?B?RVlKRXFSRTdOWVFKV3ExcElyeWZUYzExc3FpbXlOZCtscnVVMlZuYklPeUFl?=
 =?utf-8?B?YzBYK0VhNjN1bi81V0dORFpKekJwRmh5TFlOeVVlVTBnNjBSWWdmYUgvaU1V?=
 =?utf-8?B?bFdLc2xTUklROFNndk5ubEVBdUl0b25IK1JLYllkbUdkMkE2TW41OHRhZ2N5?=
 =?utf-8?B?aTFpa3lheUMvOVU5VCt5c09Cbkh4bnpCQWZtZzFHbWd4TkEwQ2dTZ1hMNmF5?=
 =?utf-8?B?Ujk4Y0VWYVVBcnoza2YrbmNBN2JsVTBvMnQ0NS8rSFBaU0thY2t1K0o1cXRi?=
 =?utf-8?B?WFRFVURVMGg0Zkc1azl6TzNuSW9WYzVlSDBlOFhSTGtqSW95WXdaMlVrR0o5?=
 =?utf-8?B?eXRlS3U4UXR3TFpSY3lDVHZ1TGphdG53MHR2WEdhRTVTdi9pajlIZmRCTmJU?=
 =?utf-8?B?VGVlL2lNRFpwRkFsSFpBbHZhSUttemdpSjJTUlpmQzdGWVJuN1BrZ1pHLzhq?=
 =?utf-8?B?TW80QXVYZ1kxS0FTUWROSFR2YW1KVEd4VHgvVHQ5VHQ2TUJ3WndyNjRIMmwz?=
 =?utf-8?B?YTdxY1hXYkljUDlrYUs5MzBJRlYwSHFEOFBOQkdhYWNGWTFNc3BwSTRQZ21N?=
 =?utf-8?B?cEJLUnRMdXQ1Tk5LWkIwU2plbFE0SEFjV242S2lWUERVNzlJa1ViNWpxOVlX?=
 =?utf-8?B?b2dCdy93bDlXSEhIeUlWV0hFa21Gd3Q2OUdwK2J2L0FwY1Q2RGl2YUJwa01Y?=
 =?utf-8?B?S2lITTRTS0dHTzcvaXQ3akhPc2hiVlF1NUNtQTFPcERLUnNLcVh5ajhqUlQ2?=
 =?utf-8?B?ZTIyZFpmUHZJa1pia1hKWFVESFVJdHBPV2NrQ01nenJ1aUl3VmtneE5ma0hi?=
 =?utf-8?B?Y09yaG1kb3hBVWF3cFBIUUZHckoyS2Q2SHNhMnhLTXlLemNBT1dCcWRTSmNl?=
 =?utf-8?B?N2hPaUdBTzNzZVZuYVNzQVBoVVFORmZocitWMWtFOXJmWElWcGk3ZXRGcEpq?=
 =?utf-8?B?SlBpUTdXblNOM0N3Qk9IalJ6b0ZrRTFocGdsRndHWnc1N2M4eks5L1RuS1pJ?=
 =?utf-8?B?bExBbURpZGpNR3BaeUZ3elczcHNnT1VuUW9zb0lZaTMwd0Q3VUttMFFxZFFN?=
 =?utf-8?B?WEk3UjBGckIrKzR3cnN3YXJScGNqbzFPUlo4VTRnWlVRa3FtT2RXeUQ1SU85?=
 =?utf-8?B?SWRZWkhacURCWVZ5czhISkhZMVRjaC9EZU1lSVVnaUozaUpKRlE5K2hpVFFt?=
 =?utf-8?B?cmV2TGZFMXJmSDlWRmM5ZnRwSmkvRCtPWkRyWWsxMHBrQVUrV3Z5Zlcwdm5a?=
 =?utf-8?B?RmpBMndRcVZqSnlsaUticG9DY0R6Z3l3VDA2TnVLYysrUG9hejFrYTFBMitK?=
 =?utf-8?B?d0VrVkVvbjdDOTBFbHRLcUdVYVBsenF1Mk1GWm9GZk1Vc1hnZlFHRmh3U2lJ?=
 =?utf-8?B?SWNtaGdUYjMzRjZuaGNvdFhSc1RiY0JGczN6d25EVGF4bTh5OVJLSUlST3Zl?=
 =?utf-8?B?RHExS3Z1OVppRC9FVjRxQlBJL0ZiTlRUZWJYT2x4bkYzRm9ENzdwN2dQWmRm?=
 =?utf-8?B?VWhxckEzZk0rUFBsZzNEeENpcnVraU1SczRFNjBlazR6S1BhcktaMHJxdy9v?=
 =?utf-8?B?b0x1V0QwQXVvTDJTZFhVS1RKWDJsdmYxT1hxZ2Q2a1FHMWtzclZ4OThnd0ZN?=
 =?utf-8?B?aUxHTlJKZEkyb25JeVZ2b0hvZ1haRlZSWE9wOEs1aU1MU3FLZEtUeTN4RURG?=
 =?utf-8?B?ZlAxSVlOUlpBa2dxSi8xZjRVUytIM09RU3hGV3lFdkpFeTF0Z1dFSm9KTjJv?=
 =?utf-8?B?ZE9VdngxMW9TMVQrSHcyOHBvOWJ0QWpxd051amVIYVgzc0VWek1pZ2gxSENs?=
 =?utf-8?B?OTNHdHF3Q3NvUmFrdEFlT3gzeG9IeHhITnI0eVg4dVVERW5raStmSUtCcUwy?=
 =?utf-8?B?YkkrTy9lalFka2pNMnliZmhzbWVpNWpsNmVVZFF1VWxyeWhzMkFpWDdtQmJR?=
 =?utf-8?B?TVNRZEJvWmFPRWdsZ0RTZjVOcmpXRXdvSnMwbUJJVjRWVDdPUU52Q3VtdktC?=
 =?utf-8?B?WS9VNENJdUwyWW5tQjVzbHJ1OUc0NERuWnIwbElsRmFKYWNOZmc1NExNMHd5?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74735ec5-ec52-4841-0d43-08dd479ee6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 17:43:15.8422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2ftjcKyopLC6255BHOc/wcMDYCjhjpF3sMNCbOwch4dZmSVZDX+tryBrs+EszOgQXbwd37JD1RA8Q5OYKs/G/Czqw7Gzqy+4mbQdFXFdyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5479

SGkgTWFuaXZhbm5hbiBTYWRoYXNpdmFtLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxp
bmFyby5vcmc+DQo+IFNlbnQ6IDA3IEZlYnJ1YXJ5IDIwMjUgMTc6NDANCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gbmV0OiBldGhlcm5ldDogYWN0aW9uczogVXNlIG9mX2dldF9hdmFpbGFibGVfY2hp
bGRfYnlfbmFtZSgpDQo+IA0KPiBPbiBTYXQsIEZlYiAwMSwgMjAyNSBhdCAwNToxNToxOFBNICsw
MDAwLCBCaWp1IERhcyB3cm90ZToNCj4gPiBVc2UgdGhlIGhlbHBlciBvZl9nZXRfYXZhaWxhYmxl
X2NoaWxkX2J5X25hbWUoKSB0byBzaW1wbGlmeQ0KPiA+IG93bF9lbWFjX21kaW9faW5pdCgpLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMu
Y29tPg0KPiANCj4gQWNrZWQtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5z
YWRoYXNpdmFtQGxpbmFyby5vcmc+DQoNClYyIHZlcnNpb24gWzFdIGRyb3BwaW5nIHVzYWdlIG9m
IF9mcmVlIGluIG5ldCBpcyBwb3N0ZWQgYW5kIGlzIGFwcGxpZWQgaW4gbmV0LW5leHQNCg0KWzFd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9u
ZXQtbmV4dC5naXQvY29tbWl0Lz9pZD03NmM4MmViMDQzMzJiMDQ0N2I3MjZhNGE3OTRlOTA2NjY5
OTY0MDA4DQoNCkNoZWVycywNCkJpanUNCg0KDQoNCj4gDQo+IC0gTWFuaQ0KPiANCj4gPiAtLS0N
Cj4gPiBUaGlzIHBhdGNoIGlzIG9ubHkgY29tcGlsZSB0ZXN0ZWQgYW5kIGRlcGVuZCB1cG9uWzFd
IFsxXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDIwMTA5MzEyNi43MzIy
LTEtYmlqdS5kYXMuanpAYnAucmVuZXMNCj4gPiBhcy5jb20vDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2FjdGlvbnMvb3dsLWVtYWMuYyB8IDIxICsrKysrLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hY3Rpb25zL293
bC1lbWFjLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FjdGlvbnMvb3dsLWVtYWMuYw0K
PiA+IGluZGV4IDExNWY0OGIzMzQyYy4uMzQ1N2NlMDQxMzM1IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2FjdGlvbnMvb3dsLWVtYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2FjdGlvbnMvb3dsLWVtYWMuYw0KPiA+IEBAIC0xMzIzLDIyICsxMzIzLDE1
IEBAIHN0YXRpYyBpbnQgb3dsX2VtYWNfbWRpb19pbml0KHN0cnVjdCBuZXRfZGV2aWNlICpuZXRk
ZXYpDQo+ID4gIAlzdHJ1Y3Qgb3dsX2VtYWNfcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2KG5ldGRl
dik7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBvd2xfZW1hY19nZXRfZGV2KHByaXYpOw0K
PiA+ICAJc3RydWN0IGRldmljZV9ub2RlICptZGlvX25vZGU7DQo+ID4gLQlpbnQgcmV0Ow0KPiA+
ICsJc3RydWN0IGRldmljZV9ub2RlICptZGlvX25vZGUgX2ZyZWUoZGV2aWNlX25vZGUpID0NCj4g
PiArCQlvZl9nZXRfYXZhaWxhYmxlX2NoaWxkX2J5X25hbWUoZGV2LT5vZl9ub2RlLCAibWRpbyIp
Ow0KPiA+DQo+ID4gLQltZGlvX25vZGUgPSBvZl9nZXRfY2hpbGRfYnlfbmFtZShkZXYtPm9mX25v
ZGUsICJtZGlvIik7DQo+ID4gIAlpZiAoIW1kaW9fbm9kZSkNCj4gPiAgCQlyZXR1cm4gLUVOT0RF
VjsNCj4gPg0KPiA+IC0JaWYgKCFvZl9kZXZpY2VfaXNfYXZhaWxhYmxlKG1kaW9fbm9kZSkpIHsN
Cj4gPiAtCQlyZXQgPSAtRU5PREVWOw0KPiA+IC0JCWdvdG8gZXJyX3B1dF9ub2RlOw0KPiA+IC0J
fQ0KPiA+IC0NCj4gPiAgCXByaXYtPm1paSA9IGRldm1fbWRpb2J1c19hbGxvYyhkZXYpOw0KPiA+
IC0JaWYgKCFwcml2LT5taWkpIHsNCj4gPiAtCQlyZXQgPSAtRU5PTUVNOw0KPiA+IC0JCWdvdG8g
ZXJyX3B1dF9ub2RlOw0KPiA+IC0JfQ0KPiA+ICsJaWYgKCFwcml2LT5taWkpDQo+ID4gKwkJcmV0
dXJuIC1FTk9NRU07DQo+ID4NCj4gPiAgCXNucHJpbnRmKHByaXYtPm1paS0+aWQsIE1JSV9CVVNf
SURfU0laRSwgIiVzIiwgZGV2X25hbWUoZGV2KSk7DQo+ID4gIAlwcml2LT5taWktPm5hbWUgPSAi
b3dsLWVtYWMtbWRpbyI7DQo+ID4gQEAgLTEzNDgsMTEgKzEzNDEsNyBAQCBzdGF0aWMgaW50IG93
bF9lbWFjX21kaW9faW5pdChzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPiA+ICAJcHJpdi0+
bWlpLT5waHlfbWFzayA9IH4wOyAvKiBNYXNrIG91dCBhbGwgUEhZcyBmcm9tIGF1dG8gcHJvYmlu
Zy4gKi8NCj4gPiAgCXByaXYtPm1paS0+cHJpdiA9IHByaXY7DQo+ID4NCj4gPiAtCXJldCA9IGRl
dm1fb2ZfbWRpb2J1c19yZWdpc3RlcihkZXYsIHByaXYtPm1paSwgbWRpb19ub2RlKTsNCj4gPiAt
DQo+ID4gLWVycl9wdXRfbm9kZToNCj4gPiAtCW9mX25vZGVfcHV0KG1kaW9fbm9kZSk7DQo+ID4g
LQlyZXR1cm4gcmV0Ow0KPiA+ICsJcmV0dXJuIGRldm1fb2ZfbWRpb2J1c19yZWdpc3RlcihkZXYs
IHByaXYtPm1paSwgbWRpb19ub2RlKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgb3ds
X2VtYWNfcGh5X2luaXQoc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldikNCj4gPiAtLQ0KPiA+IDIu
NDMuMA0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k
4K6+4K6a4K6/4K614K6u4K+NDQo=

