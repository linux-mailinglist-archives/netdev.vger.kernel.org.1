Return-Path: <netdev+bounces-122859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64109962D64
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A6228301E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96331A38CE;
	Wed, 28 Aug 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="PiV6ojEC"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023138.outbound.protection.outlook.com [52.101.67.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9EB34CC4
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861665; cv=fail; b=boRjeXrRU2hlQKvkWb1847uIcNiP4f9NAgkPQ4Qjk/Ay2+uvvwrwoZT1ztPLzVr983TBUr7tIkf+eTWkWygqrDDeDE4537y2Xv9U3USnbbxTR+b2vUyCFHkIPVrP4mozVv8Vlu4Y8t+ipvhvemHWVuOfGZvezVgSaG2Qk8BN4F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861665; c=relaxed/simple;
	bh=fCMI/5lS8YQaKo0NYA1+BN5GUh5Q2UUfimCZaUp5ceo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jpG7bj+DxbpPFltqgYYji2Tdaw/H+emziBpp4SwkPL3BDPQmNskcADV0NzyaL03/is93ET3mGQzm2Q2d0YfAepgxCqjF+LtarWHklNbwT8eBAkxhdhkIxxRgrMJ4uCBVgLV6lRjKYBE76vJtoM52o+4MMERLqEssZKkgeKDmNxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=PiV6ojEC; arc=fail smtp.client-ip=52.101.67.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIL44LxCrS9YyzwRovqqcfPipRIyKaKs/qjPWs3HLZdYdMTdJ/qI9Y84lUAPYKySUyLfjebDPOfRBCgqaaXmUELFh7Xkhm0YBiX8Sd1a+o5XuJPhG2noN489OVDDoEcyfzIJsqVPA1CjAYSmJHXHvY6Kl0jK8QXBe+WN498iVv1S4FzKHb+Pa4Koyc+68GqllCfOMoOrnv7aOY9Iv+vrDTEEiTVdjAsAmSJoqPDLtfkchnfETfvVgg6okeG6G14HMspXcai1x6r3W+mlq96KpGddK0ivLpBnzVb6BwUsofWgXHMnRWQnTDCppLC98YwrvITUaxsu115fpbOFng4EoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCMI/5lS8YQaKo0NYA1+BN5GUh5Q2UUfimCZaUp5ceo=;
 b=C4fqzMNvlGB1BvA01uh9cGzuZKMse4xIimO9U3967dfXn5srCpB9PuE0dG6yi1vHdVV2J1d6b5B0EWZrsqaMwz0Gvsr8klHc22wVomOV9EwH/dUFAS181qck428kLGyiJArK0ZOa0fnz21lLgjmlxdsAGbY6DpqN0q9A8WIUeLayZSEPau79nwwbQImHWVnUGFnNDfeyE4F0EMq/1hK3xFu6v7w+iuVtsFkWb7iVUHRz6KwgGowNWgbhj1DxDvWTpOrUi/5BpFDkfkTCZCEDLhoY7Zj3MyileH7J7fkSknVTba6DNjxv2SYAo8EdsexEcKh6X6rd5LGEQU5ZSpufzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCMI/5lS8YQaKo0NYA1+BN5GUh5Q2UUfimCZaUp5ceo=;
 b=PiV6ojEC2CzCkZgS2Iup6POu9rFkNZDpnzb/pFOhfc4vDcGDGiS4LJ0jyyNazz3webg6oEwfXN5qUrAisKCX/h8Bk09PDwWdGAzHXpJ0r3QriN0OA2I9n+jpv1pBWj4S0O5gEPLpcdjEnoRvlQMYYWPN+6tkFxZhHFVKEa3DhgA=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by VI0PR03MB10252.eurprd03.prod.outlook.com (2603:10a6:800:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 16:14:20 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 16:14:20 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Hongbo Li <lihongbo22@huawei.com>
CC: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: realtek: make use of
 dev_err_cast_probe()
Thread-Topic: [PATCH net-next] net: dsa: realtek: make use of
 dev_err_cast_probe()
Thread-Index: AQHa+UM9rEVtIMMNo0ibucyDQSf4ibI82CWA
Date: Wed, 28 Aug 2024 16:14:20 +0000
Message-ID: <kluyezsiuntl635hlc2lgnbxytmhirt6ej5txcoleaakdw27nm@zami2pb2bmn5>
References: <20240828121805.3696631-1-lihongbo22@huawei.com>
In-Reply-To: <20240828121805.3696631-1-lihongbo22@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|VI0PR03MB10252:EE_
x-ms-office365-filtering-correlation-id: 8cc12266-978a-4de1-ee6e-08dcc77c7939
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkpNaGxwOHlqa3g5cUhlN0ZKdnp2S1RxNXcxcEhrT3RCSEpZTGl6K3hSTzNH?=
 =?utf-8?B?QUVvcUVRYi9KRUdYWFptRUhQay9yZDBzUGh4bGtGMm8rdHkrUjRMMXc5R2x4?=
 =?utf-8?B?cHBZMjkvYkJyOUwxTEtpbzhsZmc2Y2lqUmovazAvQkt2bDlZeFR4a0c1aDcx?=
 =?utf-8?B?NHdJOEFwZVU5c1NTSGJmUGFaNVRGaTZqSHFXVWk2b2x3bkxNbFhTeWpQaXlR?=
 =?utf-8?B?dU5CQWM1VGVKRzZ1ZjhPYnhJbFBWMnJmVFE2aFlGQ1BQZ1dudGczbzBXR1NP?=
 =?utf-8?B?SkkzMU1KOUMxY0VLdktpSmpGKzU4Umk5RHJ1NSt0SWwyUjllWHZwQTVNbGll?=
 =?utf-8?B?WWZCcHhkYXdiY0tCMWppNStKUUJBdTZWWEtqd3BsdDFsT2w1U25Yb25sQ0Nt?=
 =?utf-8?B?M1JRc0dtRVUvVTlMNDJTZHg4ZkJhbjVXU3U0STgyWWxZd1o1UVhrc3kraWxw?=
 =?utf-8?B?VGREbW1ucHFDTDJ5M3hISThiZy9hVHdiellYbk02T202UFR0MEpZY2FHbjBI?=
 =?utf-8?B?WDl1WWlhaFlUYmRyUXAzODBJbm8yMjlEczZWYzBtVmptOEo4SCt3eTBpeDBC?=
 =?utf-8?B?VmdYUzFaQUNIcDBPZitKSTcvN1Fhbjljbi9hdXh4UVQ0eVJjamhjZTlyMmVX?=
 =?utf-8?B?Umd3WVdEMXJTZGRzZTl2OEoyNjE5RkRHazRMSC9yOGRBanpIeXpMcy9yM2wx?=
 =?utf-8?B?TmJvZWcveEZkQ3ZCY1cvYWN5QVkrb1BvKzhzZmpVdDJDeEFwRVFWamNIdGtI?=
 =?utf-8?B?eTNGU0Q3bHUzOFVGaUwvSVJ5RVdmTW1vQk52bHJsRi80TTRvTmFTaTlCQk1R?=
 =?utf-8?B?aGdYTHBYQThCS0x1TGErZzVSbE1xcCtCY1JHeWtJU0xXdTk1ZHBtcEY5b2d0?=
 =?utf-8?B?TWIvQ1hYQ015ZjZsc2d2anBuWEk2YVZkbTduUDF5cUlHb3RWdWhBS2o3UEdw?=
 =?utf-8?B?aGY3Wis0UGQxNmU5aUhtNjd4cUJFWVdyMUlBQUgyaE0vM1ZiSy83bk1MSVFs?=
 =?utf-8?B?WUhpZ1NwSUJKUDU1empSSncrZUdmRHN2TGlQRHBzU091bit6U2pxOHRwYkZB?=
 =?utf-8?B?WkZtM2pNK3FuUEMyZXN1VnVldjN3WVcvOWt6V3J0S3BlYTlMUTlOM2V6akh3?=
 =?utf-8?B?RVMxbkNHUUxRSU14SUtSa1V6aHB6bUxvUVYvdzdmRlljcE1sRXYvOVZKdjBO?=
 =?utf-8?B?dlU1azRUWjAzTUhkMnkwd1IrdC9UQTNRdnMyVi84dk9qQ1FrNW8zTWRMRC9q?=
 =?utf-8?B?MUxYUlhtaWU2UldEVVFhaDI1VHNwK05yUHdxS0RHVmNvTWRSai9XL0ZhcU5B?=
 =?utf-8?B?OGNvSlB4SEdiemlES202N0RSSnR3RUhFWnErSm1uUDJzYytoQVZjTGVhMFhs?=
 =?utf-8?B?WXR0ZnAySGtEdUQzU3BYQUozQXRybXVTOFJiTXdaWXlUSDkreHJMTG9GcmNx?=
 =?utf-8?B?eHN1UUN2Tzl1bUhJdGR6U2FwWHkvcWo5VzEwMnUzMFVWTzUzaER0UjduNDVD?=
 =?utf-8?B?WnZ2eFAxUEkvcVVOdnpwYnFWVUIyZW9TZnpjcjhwZkxJcnZuM1MyaDJnZlNw?=
 =?utf-8?B?RG9vV0Nha1BLZ2s4RzI4NGVueWxoMHN1WXRXc0tpckNHY0ZETHczUnJvZGFm?=
 =?utf-8?B?dEs1NkNDVmJ2djFLbk9KSG9vSm9XdHZZNGU0bFcvK1M5bDc4dytmSlFmNUZO?=
 =?utf-8?B?RWNzb2U0UXU1NXJ0dnlTTTZ4L0txazFWQzNTOG03aUIzUDJTckg3WjJiY0RK?=
 =?utf-8?B?RVpPQWJhdk15ZTZPM0NjWitld1RTMDZqclg0aUdtWVMvUHIwRDlCd2krT3Qw?=
 =?utf-8?B?TkFRSHBHQ0Uyc054amxtODV3RXgvZXJjcGJVb3E4M2I5TTRJZThTaWVKbzdZ?=
 =?utf-8?B?dk9NVHNsMnBibFFCa1M0WHVNT2JHODBXaUlZN2JFU01JclE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2xvM3Z5UU1tYVFiYmVwUVlhV3ZwdTk2TzBLUTIwOGhDTmpkbFdTcVZSYzd4?=
 =?utf-8?B?aWJ4cHBuSG5WSUxyK1RSNFBQNVgwbkhHWkNGMHZTaEdudXF1NVFlelJBOWFl?=
 =?utf-8?B?LzBjT3lHOVBQSnhxT2pTYk82azF5elBOeXJwUjM2MjZGdEJjczVTeXE0bFh0?=
 =?utf-8?B?Y2RjZlZ5ZldZWjd6TUszSlg3NlY5eEQvK2dFSDlDdEJTcWVaL3VFU1BHWUhv?=
 =?utf-8?B?NHhHL21wMmVweTBad1VnZEJPWWI4cTNZKzNyd0tqVnIvK0MwOE1sTVB2RTN1?=
 =?utf-8?B?NFRsemVCNFVvV1VabUtZVGk3VVVvaTBaanF0amRRZDFHUTJEMmQzSlFJK2Rk?=
 =?utf-8?B?LzFQTzRta3RidDIxTVoxeUh4bU9WcDBabFNxaTRoaEhzUlJVQ0lSbGFqUDZj?=
 =?utf-8?B?QTYxc3g3ZzlpMWxqdHB6WG1PVlRtbHM0RXZUSDJ2YVh3QXJNU0RKVGFZV1pZ?=
 =?utf-8?B?M2FMdjQwTDlJSWdwSFpwekdQNmV3dlI2SXNhMmF2ekp6ejk2K2RPZ05TSlky?=
 =?utf-8?B?c21JOWgvT2EyUjFLVldOS2k3b0g4cE5lVFVBZnI5enkxYzl0SXNUblozdVJT?=
 =?utf-8?B?aGxTcWNpajhHejhPdEIrOEY3NFlZNXYzbGVHU1dGaytzNVkyTDZhSit4YWtB?=
 =?utf-8?B?VllSYU9wOVRWTTZYM2t1M0N5eDczSnNtamJqSHhHeGFhSVNmeUlLdDYrcWJG?=
 =?utf-8?B?b1ZzNXUvNVZvKzdBeWVGSk9vbUJaU3ExQnR4cTc2VUp4dmVka1pnWm00Mk0x?=
 =?utf-8?B?WlVLL1M0aDliQ0VJSmJidmE0YUdxOUdGL25wSE5La05BN0tXVnRhRHpNcFk4?=
 =?utf-8?B?cDhHUFh5cnFueUQyYllnSmJFTk4vbk9NdE53YkxUb0lDdnhkR204bzhVMmpI?=
 =?utf-8?B?OU1IWkg2YytpbTNyTjkxSUdJOTZ5MWpKQ2FxMk55UXZhV1lRWDA0VU13bzg2?=
 =?utf-8?B?RTFQaDJzNGM1R3lQN0owTGxCRm5KcHFmTkJGZTBic2JNenhjZ0JYQVlQclRF?=
 =?utf-8?B?clFXYytxU2dyTy9oeVdHUDNnZlg3b0RoVERPNUpwSjdqa0N5cXNqbTZnMFpV?=
 =?utf-8?B?bC83T0ZBSUU3SFZINmFJR3J0YUpNZVlHSWxURnZMQXYyTWV3UU5WMEJrL1E4?=
 =?utf-8?B?S3dralRmbVhLNWxCTXhyMjhEWmJ1NldzaFF2cjV5cEJsTk8ySXpPZEdrcDR0?=
 =?utf-8?B?TFZhTnBLNkd2ek8xQmdaYVM3UnVHeFFXS25uY00rRE9EOC9tL1ZHM3NUV3ov?=
 =?utf-8?B?UTNQSjFNSmRMYzVCQ1ZCUDJCbmhEZndsc2k0MHhPa2JHaU9WRDFvRzhhQmpN?=
 =?utf-8?B?VHdXTlFneUdnbmlFdGtaK1NHaVZna3YzRTl4UFNMeGFkT3hJMmhha1NJeDJF?=
 =?utf-8?B?T0RSQm96cU5sWXZKdkRNcnlaMXdUWlRWdEp3Vzk0a0t1d3lFdEt6SmZyVDNM?=
 =?utf-8?B?cmczRHpSMHJxS1FtbG1pUHY3QWorNWtpUjNzb3NLQklBWUFZaFVRSlZQanJv?=
 =?utf-8?B?YjRsS0dHMVJERi9BK21nRURaMENINEw5aUxTZUxRVlZZSENzZG5WcmY3ZlVL?=
 =?utf-8?B?MEthL0lhYTJReGRIYU04Mm52YnBMekY3dCtrWnVsWmNHcGZkUjdoczZxRTBJ?=
 =?utf-8?B?Q1Y2YU9TWkpvamtPOHRhdTRBNTZWcm5GNjRPOVhWaEE4Mm5pUEV1UmlCNHQ2?=
 =?utf-8?B?ZTFpaXZ0QzFqcGd3dnBCeGo5RGtwd0htbW94Zno2cndKUTNkMGkzWEVBMkRV?=
 =?utf-8?B?cnl4ZEQ4TUYrSGJDVUZnYXpkTm0wTllxaE50ZjR4V05Fdm1PWVN4OGlzQ2w0?=
 =?utf-8?B?bytxSzByam1od1JFYzV5ZzUrd2oyb3ZhblMvMFI4bUhXUXZZSmZXM3lQcWln?=
 =?utf-8?B?cTl6U2FoWVZrWm5sTHBEK3k2ZUJoRHBNSVhXV2I2Z1RTaFVVVGlwRlNkeXJy?=
 =?utf-8?B?c2Q3WTd5RlpGOEduV1FIOXBDSEdXSVBWcXZZand6L2FoMG9HSy9RVkdxbzg3?=
 =?utf-8?B?QmhHOC90R21CL0lLNDdZZGt1WGhGajAwV2hRUlNpQUtkT2IwNGNKeTVwYjM3?=
 =?utf-8?B?aDhSUHk1QmhUL1Jnckw4NEdJNjVjQk1kRHdxZGE2TFFQZFk3UXVTSlk5enk5?=
 =?utf-8?Q?o21qmmnnRIKjMjGGbI5/2rEbA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA37B788BB61A1469473BA2207C1EE18@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc12266-978a-4de1-ee6e-08dcc77c7939
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 16:14:20.2977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BfjqAAPyWPPN3myBzzLyRlVildbJuOhDJNPTllqgi1xzIMvNZdrC4as3dQ8KC223KIoLeot2hdNPYWpVXtR+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10252

T24gV2VkLCBBdWcgMjgsIDIwMjQgYXQgMDg6MTg6MDVQTSBHTVQsIEhvbmdibyBMaSB3cm90ZToN
Cj4gVXNpbmcgZGV2X2Vycl9jYXN0X3Byb2JlKCkgdG8gc2ltcGxpZnkgdGhlIGNvZGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBIb25nYm8gTGkgPGxpaG9uZ2JvMjJAaHVhd2VpLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4M3h4LmMgfCA4ICsrKy0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzeHguYyBiL2RyaXZlcnMvbmV0
L2RzYS9yZWFsdGVrL3J0bDgzeHguYw0KPiBpbmRleCAzNTcwOWExNzU2YWUuLjNjNTAxOGQ1ZTFm
OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcnRsODN4eC5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzeHguYw0KPiBAQCAtMTg1LDExICsxODUs
OSBAQCBydGw4M3h4X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gDQo+ICAgICAgICAgLyog
VE9ETzogaWYgcG93ZXIgaXMgc29mdHdhcmUgY29udHJvbGxlZCwgc2V0IHVwIGFueSByZWd1bGF0
b3JzIGhlcmUgKi8NCj4gICAgICAgICBwcml2LT5yZXNldF9jdGwgPSBkZXZtX3Jlc2V0X2NvbnRy
b2xfZ2V0X29wdGlvbmFsKGRldiwgTlVMTCk7DQo+IC0gICAgICAgaWYgKElTX0VSUihwcml2LT5y
ZXNldF9jdGwpKSB7DQo+IC0gICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKHByaXYtPnJlc2V0
X2N0bCk7DQo+IC0gICAgICAgICAgICAgICBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVk
IHRvIGdldCByZXNldCBjb250cm9sXG4iKTsNCj4gLSAgICAgICAgICAgICAgIHJldHVybiBFUlJf
Q0FTVChwcml2LT5yZXNldF9jdGwpOw0KPiAtICAgICAgIH0NCj4gKyAgICAgICBpZiAoSVNfRVJS
KHByaXYtPnJlc2V0X2N0bCkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9jYXN0
X3Byb2JlKGRldiwgcHJpdi0+cmVzZXRfY3RsLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiZmFpbGVkIHRvIGdldCByZXNldCBjb250cm9sXG4iKTsNCg0KVGhl
IGNoYW5nZSBpcyBmaW5lLCBidXQgbWF5YmUgaXQgd291bGQgYmUgbmljZSB0byBmaXggdXAgdGhl
IG90aGVyIHR3bw0Kc2ltaWxhciBjYXNlcyBhcyB3ZWxsPyBUaGUgZXJyb3JzIHdvdWxkIGJlIHN0
cmluZ2lmaWVkIGJ1dCB0aGF0J3MgT0suDQoNCiAgIDE1OSAgICAgICAgICByYy5sb2NrX2FyZyA9
IHByaXY7DQogICAxNjAgICAgICAgICAgcHJpdi0+bWFwID0gZGV2bV9yZWdtYXBfaW5pdChkZXYs
IE5VTEwsIHByaXYsICZyYyk7DQogICAxNjEgICAgICAgICAgaWYgKElTX0VSUihwcml2LT5tYXAp
KSB7DQogICAxNjIgICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKHByaXYtPm1hcCk7DQog
ICAxNjMgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInJlZ21hcCBpbml0IGZhaWxlZDog
JWRcbiIsIHJldCk7DQogICAxNjQgICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUihyZXQp
Ow0KICAgMTY1ICAgICAgICAgIH0NCiAgIDE2NiAgDQogICAxNjcgICAgICAgICAgcmMuZGlzYWJs
ZV9sb2NraW5nID0gdHJ1ZTsNCiAgIDE2OCAgICAgICAgICBwcml2LT5tYXBfbm9sb2NrID0gZGV2
bV9yZWdtYXBfaW5pdChkZXYsIE5VTEwsIHByaXYsICZyYyk7DQogICAxNjkgICAgICAgICAgaWYg
KElTX0VSUihwcml2LT5tYXBfbm9sb2NrKSkgew0KICAgMTcwICAgICAgICAgICAgICAgICAgcmV0
ID0gUFRSX0VSUihwcml2LT5tYXBfbm9sb2NrKTsNCiAgIDE3MSAgICAgICAgICAgICAgICAgIGRl
dl9lcnIoZGV2LCAicmVnbWFwIGluaXQgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCiAgIDE3MiAgICAg
ICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKHJldCk7DQogICAxNzMgICAgICAgICAgfQ0KDQpU
aGVuIHlvdSBjYW4gcmVtb3ZlIHRoZSByZXQgdmFyaWFibGUgYWx0b2dldGhlci4NCg0KRWl0aGVy
IHdheSwNCg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5k
az4=

