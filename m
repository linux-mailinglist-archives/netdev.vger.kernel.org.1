Return-Path: <netdev+bounces-159692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD5FA166D5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 08:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E843A1854
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C716189520;
	Mon, 20 Jan 2025 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="gqg4t7jE"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD6188A3B;
	Mon, 20 Jan 2025 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737356410; cv=fail; b=Y8f8oZNCglusu14wMjpVEHZcqMgdrfqWO4QsasY8Loj+NPai+5jWULwyQOOY8C3NRwh9Kth23pZzplr0qLsuJ3sh/7G0FOEUVAtA9B03Kbis61buLzXEmXBptJzoTZkONVha+Osye1/OihpfUCRgKkzvc/SztkXIUV69ey7QKNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737356410; c=relaxed/simple;
	bh=UnfK/4+Z2e/eD3cT7ENU2d/f6IDImEgfx6YwBH4mNZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kHEg/k/qx56eM+c7Ptlf+QmYnoVIKWt8kWJppkcAh240iVnmv5zrH6W6281WfOoLYN3N1Y3eX+0Za7R6ki649RRRCHm1qs3uxOBfdhGuqxUhxxxmBZz27g9faFcrKo8EY/GaJOKdeEv/kQQTfF450ibThGdNfHADDBPEWuos+go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=gqg4t7jE; arc=fail smtp.client-ip=40.107.255.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXkCNS9lcuUVfOWn9ZWPvOM/2X7kdT6Hlu84Z8sNN12pdsDlHEWM6HMdnOy1kEkd8uMdXOEz4ho6wz9nxT1YC03jRJeLrbOt7gvgb+bsCR1mcWNOaRP/j6SlgBxKSy8e7g8d24ZnDHtOlSYcEaaESOIIeQrifGDXiJENZnTzRJxXJ+EdrZTL4DMkNn9y5ZU+lE41LFa2Oji+r82J6a7jjpRGl87YPBifao7/kRQ53RQ1eWmqzlmRBiOhWmsqjOp3CaW6o1YC26IKd5zBXCIKVMuahqn4uVKNcgHD7ENQQb01Ehuqu0gwq6CBTCjAXR4HiL8X3Z+y1wMbhen0TeI8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnfK/4+Z2e/eD3cT7ENU2d/f6IDImEgfx6YwBH4mNZg=;
 b=w3QN6rRj3SU9lA43BVnmYlrnaguixPz/L8luNzHg6XnrPFwDD0jLc+cUz0o9h9jOzsF6IYKKm2cHNQhj8+Mg1fabyLY/3srqEgvqjXfpUzt1fc36K+2Vy/4ajjldnU7YMvUem2xpjTiaEsCR4z8+bZwWKR4qyOu72pJ3A3IzbN8jHwkvDJgjOjCsf1CAnd5gzf6v2qo99E5AExcnVX/cmpZquivqemkyW/cliHlKWY42LOe9jI0+kmb4FK4wW8MwXwxrStdP7tuR5F6ngf0HPdlU3ducBEpnmVM3CIj5DOylWs+FmxYPo64Mi18PXz9iPuCyqt5iMPhRByjl16Uxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnfK/4+Z2e/eD3cT7ENU2d/f6IDImEgfx6YwBH4mNZg=;
 b=gqg4t7jE5+vav+Qp6niEdaTOn5FWwJVGd4wVYQwcMih6POEzHDf8BneCo+ZpHdK/fYeojkwgEQPDipq2Xu4sDyp3BRUWA9KrksN50pJbpeTBtPw8JNBoTXDMAiY90L0cjPXr+q4QzMLy8tJjx3oj6sQG1oDCRj7DmD1IzMyJ+gS5+LaYbET4t1lErFks680LvBvkASGea5uZXeBfuG05cGO41s0V1tA8o+Zf+A1ngZL4hfgIMOVFAvKP74ZOk3ZBD56VY+QTsYjarmrLxr97xgvd/9R9V0+/LPWqkS7dEqKJEEIG4uaU9yBj9NoQ4eyiLwx37fbMOcvskVLG6Rz/qA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB5229.apcprd06.prod.outlook.com (2603:1096:101:88::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Mon, 20 Jan
 2025 06:59:59 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.8377.004; Mon, 20 Jan 2025
 06:59:59 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Ninad Palsule <ninad@linux.ibm.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
	<eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject:
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0Dogpl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIHYyIDA1?=
 =?big5?Q?/10]_ARM:_dts:_aspeed:_system1:_Add_RGMII_support?=
Thread-Topic:
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBB?=
 =?big5?Q?RM:_dts:_aspeed:_system1:_Add_RGMII_support?=
Thread-Index:
 AQHbYX4ZqwUnoFUOykuCVX4SkD1z27MNKUAAgABN4QCAAApFgIAAvO3AgAAxcoCAABHnAIAAB/+AgAEsnXCAAFgBAIAENTRQgACHsgCAAAOEgIACXbCwgAAFSQCAAAD+YIAArYUAgAdtdVA=
Date: Mon, 20 Jan 2025 06:59:59 +0000
Message-ID:
 <SEYPR06MB51347BB3F94A09B89BD313269DE72@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
 <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
 <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e5178acd-0b6f-4580-9892-0cca48b6898a@lunn.ch>
 <SEYPR06MB513402FD4735C602C5531F499D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <f28736b5-f4e4-488e-8c9b-55afc7316c5e@lunn.ch>
In-Reply-To: <f28736b5-f4e4-488e-8c9b-55afc7316c5e@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB5229:EE_
x-ms-office365-filtering-correlation-id: 8ae2e6a9-2629-4aaa-42e9-08dd39200dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?M3BYQ0dtU0FJOTBxbnFiQ0ljMUZwTnUzUmNqOUQ0WVc1Q25mVXlKb2FaOTBONzZz?=
 =?big5?B?NGQydmg2OHgxTEFXK0I3cERkaUVVUlAxakZJWFJGanVWTUt6aXBSZitvVHFsOGE5?=
 =?big5?B?enF4OEZWb2RxUkFUa2xvbnZjbmdWMFovak1RUVRnWk5PSjJ0R2MybEJOSG9HMEhh?=
 =?big5?B?RlIrVm8zSzc2dkVRZUtidmpUYTAzODFKRW5XOE1wdGRJNDlOZmM4b3VrcnBycG96?=
 =?big5?B?dm1yWUJpR0hjTERaMElVdGhGWWREY0Y2OFZsckFuNW5LcWx2VUpyNVV2Qk1wOTRL?=
 =?big5?B?WFJCNG54bDltUjBzOEFmWjhtL1lPWTNQQmhUREhIa1U2WHdCb0N6YlZzNDNUUlFl?=
 =?big5?B?aFpSeCtVWEpFQmhZaW1RdW84M3UwRFhUU2EwTUVRTkFDanNOQkI4VlQ4TkNDcnVq?=
 =?big5?B?MmRYaGVhNjRWRlBGYXBYMlRxVGFjbS9Wb0pjTy9yYTlKV1JUeXJSd2ZKVlFVNTNo?=
 =?big5?B?NnJBMGx3SUpFVHg1MDFLVTdwRDY4eEVSMHprVE5KWmUrTE9xY04wSkFkZ0dFTWxM?=
 =?big5?B?dEVuNFVzNFdIMlYraXNwZkpCS1UwbS9ybGdkVzh4TjBBV1VHdTV1UFVFSGNnMTcr?=
 =?big5?B?VUtVVUNPOGc3bnhsTTlFUjlNenFnMHZxQ2YxMDNITkVBLzJQdlZQRlRYbnhZVU9C?=
 =?big5?B?c2w0K0dGUUs5dDBoaHJtakxYT2hpRUd2UStTMElrU0RzV1N6RE0zOUhIR1BNdEwy?=
 =?big5?B?M2FkRXZVc29teWd3UFIvZldJOEFCMTdpdUtkR040djNKd2orNkhsZXc4NjBVVVln?=
 =?big5?B?enZFY1VuVm5aSGhERTQ5MUhJdG5zcGFaUmtjeFN2UzVFM2xMRFo0U2NMQndXMGhU?=
 =?big5?B?N01pN2poMHFMdHJTdEJibTB6MUM1NmxjVi9BT0owR2Nhb0xhUEdBOE1xUElPK1N0?=
 =?big5?B?a2k0enlpK2UvUUlGeStueDFvY2lxSVNYZFUwdFVhOW1mVVlDMGxNTnhLMi9DaXlW?=
 =?big5?B?RGNFSVdRYUV4a2t6UTBrNlJVam5aekY3VEJrTEIyTlJuYlBhVERVU3BDTDZWZWp4?=
 =?big5?B?dWo0YS9ibG5xYUR2V2FhNElJUGJuMWJjbm1ORk9kSllRMURydkpqanVXQnZ2L3Mv?=
 =?big5?B?R1NycEE1N0hIVGJnNm94SGVUZkZyejZMUXB1Q0htb1Q2cUZJamhkSlAvK0NpU0pM?=
 =?big5?B?NXhEZDJmU3lZb3oySmdEZUZ3a1hPM3BJZDYvLzRpcHcvbWs4TVArNndCMm1ncXF3?=
 =?big5?B?Qm12REhTQjJJeFRqYXZIcENQZE9GWEJ2Y041QmNLUUlPcXhieTdCVVR5M3NLZWZK?=
 =?big5?B?M045RVV5ZkdqNW0wZ0NxN09XZE4yQzRENXl3MlJWQk9XUTFIZHNDZldKQ1lDcDVJ?=
 =?big5?B?MVM5dTBBd01rcEkxeEoreHh0Q2V0ck13dEt0K2pqbjJlMUIxRWVjMzVLdUxETjNE?=
 =?big5?B?eHJuR3EwZXZSbHg5SmJKMkhSSHk4NmFlRlh1a2x1VlB3NlBOUnJqNWRlNDd0TDkv?=
 =?big5?B?VG1GeEdkSDNMV1lja0QzVnJ4V01nK2trYVlXVHJEWURQUjhWaFdnb3lhbEwzN3JZ?=
 =?big5?B?ZmdvSjF0RTVkN0JGUy9uOE9Ud3RKR1dOdkNQZDRJeng0RjJ1UzlxU0ZuQW5mY0VK?=
 =?big5?B?TzZVQmhhQ2Q5ZDlod090VUkvM3R2Tk5NR1pmSThwdC82RnpaSHpNWGZISCtHSXNX?=
 =?big5?B?Wk5qa3lmWFVEY0tOTUxHbHh2YkJUTWNFTDJiRGcrdVdCRDU5eDV3RGhwY25zMHdt?=
 =?big5?B?dmJwaUI3VGV2R0NKb2d2ZkV0OTNmeStFUkttVjZWOVBLODluWXY0enRKZ3RLSFRG?=
 =?big5?B?RERFc3dNdzZuSFpjWkJIbWVlSEU2VjJXWGRTU0wrWVY1TmtHUlVmZWh0Z1ZIOWEz?=
 =?big5?Q?cHQam6RkgvG4ltgPVRxCjhXP+3efH8Jp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?eHJIWTZYYmtXWHVTZ1gwcWMxNnA1Wm9nV0MrWTRkTFhUVElZTkF6Q3VXVkVFM3Az?=
 =?big5?B?S1dWZ1Bnais0NHpvcjZ1UWNxNmpPamtPcDVmeTgyZFFzdjZqT0ZMM2tQaXIwcndE?=
 =?big5?B?S3RVQ21XWnA4Tk5NeTFGS0hpS1p4SHkrUUtRMERWQTBoZkRjemtJeG5UaU5vZ08w?=
 =?big5?B?Zy9RQjM1MEY4SkxQbStWd2trVGYyZHZZdk96VVl1MWRCdE5DdXY4TFpxTU9nQ00x?=
 =?big5?B?Q0tpZnp0Z0FUSmVwQTNLMitINnJ1VnU1NlBleWwycmREcUgyOTF0dUhtbUlpVEZs?=
 =?big5?B?ZnBHaEZtYkJqZ0xSdFovQ1FmbnorejZJbjVYSU80TktzSGl1elZuVlpDZ3Q1ZTdq?=
 =?big5?B?OXdqTnpxbzA2aW1jdnM4dUhSa0RIUi90RmErZTNObS9kWkFGZVBLaVNmUzBxN29O?=
 =?big5?B?VWoyR1NKc3RIQjZYT0JJQkFSTHEvRzVrYy81eTNtSHhVcEMvTGRKNXlIWVlLdjdV?=
 =?big5?B?aS9hYWQwMXgybDdzclMwMXZPQzh2bGJVZllEbFRCL1hhdWlhQTgzMWlwQ1loTVdI?=
 =?big5?B?cGZMZDZmV1RQb0t1R3llS3pZRmtPM2RZcFViQ21zcmpIT2gvRDNlZzBPVHBHNzZJ?=
 =?big5?B?OTIzVXYrd2hJSXZXaVNJSnpmeHhDbEJtN0U2V1ZQUDZXTC8zMlVFNVYzTGYwSDBz?=
 =?big5?B?UW54K2pJU2dSVEZIdUhXZVQrOU53VTZtUkF3cWRMaGtmaURSbmRSUnNXM2RUd0lw?=
 =?big5?B?WGlKc3U1RjZvM0psclFKUGlLVWhTbEg2MVlhUlo3YXRlenhHbmpvVW9ndjNwSFRQ?=
 =?big5?B?cGJKMFBnQkdrdHZxNVpkd1E4dTYrcWpPSUg2cnNUMUZScGFJM21kSkMzMFdONE1M?=
 =?big5?B?YzU0RVF4b3k2cGZFNDdjV0NaNGhmZzFJbW4xaFNRQlZFU3cvczNtRWthOGtvTzJs?=
 =?big5?B?V0J4YWhLVENlWkdvS0FqWUovQzFnNW1wcVF2VW9iZUoxWklpU29EenZEQTg4Y2s2?=
 =?big5?B?bWJ2Um1XRTAvUDFsYW1BMWtJcFJmMUFGWkwzSVl0U2ZUbUR1UGxiN3crZ3I2MUtl?=
 =?big5?B?ZmhVck9hT3lwMTNsbzJGTnk0TWlKdnoxV0YyTXU3LzJ4dG9UNy82QnFRbm9ORDlI?=
 =?big5?B?VWpRakd2dGIrenhSQ3pBcENkN0Jlb0FDdTNHMnQ0a1F0SDdaSmdZTVdzQklIRUNK?=
 =?big5?B?Qld3ZU02NFdCUWxrVUFqZXRnQ2ZjM0MyV09KazFKSm9UWGlSZU41eXZibWpCbzFB?=
 =?big5?B?YzliRFFsSUh5cis0eW9CTk1mbFhHb0l1Wm55TlNoS3VnS1MvejVpVEdPbVIwdits?=
 =?big5?B?V2h0N0hqVXFIRWxHOUFrNmJPaFp0L3dpL1R4bXB3Rm1mNWlWS3ZPSnJRNWlOL0lN?=
 =?big5?B?NkxSQmZkdkl0Rm1GZzZrcXNZOHFaZU16T2ZPaHZnUUhEL2hycmoxSVV1YzVtRm1B?=
 =?big5?B?bkxpclE5VDNqSk5OaENsdTNnaUQwZHdWcm43OXpRU3FEckt5b2I1b3Z1cDJrdmxN?=
 =?big5?B?TFA4MFJVY1NzbFZYSnc4Y3ZkdVJiSVpORitjKzRTenBWbzBlZDF6Nm9PSFpXREQ4?=
 =?big5?B?ZFJpRmpmNDhVVytYK0hidVd4TnNmME9IQmptckRXRlRmOWFlR0xvbXBUL2J6Rzlz?=
 =?big5?B?eldoL09heGdsZ2tnYzdzc0VOejBJREo5bXJuMWxlMGhDU2EwYU9WOGdBWmFMaHhv?=
 =?big5?B?TDV1MmtnMUx2dnpwck9kUFIyUDAza2J0bmZiNE1OU3VwQi9SbzZoWS9uMzQ0WlZE?=
 =?big5?B?Z1dVSnI1aHFIeFYvMWs3ckF2TzZ0eS9lKzZXZDRaTGYvdHlWQXZ2d2Z5dUJGRkx1?=
 =?big5?B?UGJQYlFYZjFJUFFsUElzSjRmOGd4NnZza2g0dEJnckNBK1VpUVU5Y2VPSkpjSE5Z?=
 =?big5?B?TEliS1REZFJLNGR0RGxtUHdxNUYycmdTYXdVRTdPYzF6VlVmem1ySjN3WHZ3b3lZ?=
 =?big5?B?a2lvc3Vyb2FrdG5TZGtmSVgydlVET25Oakh0VEFxYmxUUUc3dzE0VXpoNk1pSkk2?=
 =?big5?B?bDk3R0VDVnFUM2tvd0UvSjJaL1p4T2NGYWRXTHZwQmV3dno4UlRZUGEvSXBqem1R?=
 =?big5?Q?ggxotnJhX5sAtCB4?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae2e6a9-2629-4aaa-42e9-08dd39200dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 06:59:59.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuwVMqLIMxOKRZhF/ws+v3sPnJ3rjkqzolvMp87XbCm8UV0qDqsT58veGmXMMUZSdpRQSYGMtrVtR5XjYTyluXPs/1z2OK8qRJyEhYBpmdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5229

SGkgQW5kcmV3DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+DQo+ID4gWWVzLiBJ
IGhhdmUgcmVhZCB0aGVzZSBtYWlscy4NCj4gPg0KPiA+IEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBt
ZWFuLg0KPiA+ICJyZ21paSI6IGRlbGF5IG9uIFBDQiwgbm90IE1BQyBvciBQSFkuDQo+ID4gInJn
bWlpLWlkIjogZGVsYXkgb24gTUFDIG9yIFBIWSwgbm90IFBDQi4NCj4gPg0KPiA+IGZ0Z21hYzEw
MCBkcml2ZXIgZ2V0cyBwaHkgZHJpdmVyIGhhbmRsZSBmcm9tIG9mX3BoeV9nZXRfYW5kX2Nvbm5l
Y3QoKSwNCj4gPiBpdCB3aWxsIHBhc3MgdGhlIHBoeS1tb2RlIHRvIHBoeSBkcml2ZXIgZnJvbSB0
aGUgbm9kZSBvZiBtYWMgZHRzLg0KPiA+IFRoZXJlZm9yZSwgSSB1c2UgInJnbWlpLWlkIiBhbmQg
dGhlIHBoeSB3aWxsIGVuYWJsZSB0eC9yeCBpbnRlcm5hbCBkZWxheS4NCj4gPiBJZiBJIHVzZSAi
cmdtaWktaWQiIGFuZCBjb25maWd1cmUgdGhlIFJHTUlJIGRlbGF5IGluIGZ0Z21hYzEwMCBkcml2
ZXIsDQo+ID4gSSBjYW5ub3QgcGFzcyB0aGUgcGh5LW1vZGUgdG8gcGh5IGRyaXZlci4NCj4gDQo+
IFF1b3RpbmcgbXlzZWxmLCB5ZXQgYWdhaW46DQo+IA0KPiA+ID4gTUFDIGNhbiBhcHBseSB0aGUg
ZGVsYXlzLCBidXQgaXQgbXVzdCBtYXNrIHRoZSBwaHktbW9kZSBpdCBwYXNzZXMgdG8gdGhlDQo+
IFBIWS4NCj4gDQo+IElmIHlvdSBkZWNpZGUgdGhlIE1BQyBkb2VzIHRoZSBSWCBjbG9jayBkZWxh
eSwgaXQgbmVlZHMgdG8gbWFzayB0aGF0IGZyb20gdGhlDQo+IHBoeS1tb2RlLCBvdGhlcndpc2Ug
dGhlIFBIWSB3aWxsIGFsc28gZG8gaXQuIElmIHlvdSBkZWNpZGUgdGhlIE1BQyBkb2VzIHRoZSBU
WA0KPiBjbG9jayBkZWxheSwgaXRzIG5lZWRzIHRvIG1hc2sgdGhhdCBmcm9tIHRoZSBwaHktbW9k
ZS4NCg0KV2UgbmVlZCB0byBjb25maXJtIHRoZSBNQUMgYW5kIFJHTUlJIGRlc2lnbiBpbiBBU1Qy
NjAwLA0KQW5kIHdlIHdpbGwgcmVwbGFuIHRoZSBwaHktbW9kZSBjb25maWd1cmF0aW9uIGluIGZ0
Z21hYzEwMCBkcml2ZXIgYW5kIGRldmljZSB0cmVlLg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=

