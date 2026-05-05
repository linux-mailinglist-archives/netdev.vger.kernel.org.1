Return-Path: <netdev+bounces-284183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LQDFJ9c+Wl28AIAu9opvQ
	(envelope-from <netdev+bounces-284183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF684C614D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B641B301B17B
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4B35AC27;
	Tue,  5 May 2026 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="te6/aJdk"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968148CFC;
	Tue,  5 May 2026 02:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777949849; cv=fail; b=ZBABXgCX1NlyNSTxpH4z3ypa8oKVObBN9k2ippKWdR3RGaSw5kt2NeeZBFeCieCH50N2qoA5PkRrsaJxWC/eaT5G6sKMzAOTs4u539BvA3X5FtbGnD1NLHNa7SgBsvU3ihkOCdNvHoodr6CZ/SGvmzXAXxNAjlQjAKVqBQe+SMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777949849; c=relaxed/simple;
	bh=S15fTuiCxiaNcdiWgjx0cLjvJVP8PB5gFGf6jj26jcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IVIgQdYtDv7Mb9AnzkNvmVzOepvpnFMt/Lh/kBb5yk58mIzBWqW2gvUdVyKzmTofGzM1SbIzLqcwLuqoutWwFPjCv7xNDViqT5fViaaJYLVqvx3A4xi6JXqYWXBA/3PEm4gUpfHRB3jncM7QjcZo1ADIdBke/0PEk5oaOl60Ds0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=te6/aJdk; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ0hvcdhhIMGu7aq35QAnhoS1t3L4+73xnwXeMKuwMqNGUFUN+fbhzfv9PjDLYLWqM11oIb0Zn4UPT9cf8MNkH27gbJ7BUJeYmrF8K4BKFgeuOOA7qkHZzdYsR9W8ZaEXBDqXIBRRzcefYpD0s1z+NsZc1xrawcV+Yn3hkR9Vakpzv4UWc5AY+SZrh5lc238cZWwrJmfrXY9cRM2uhbqBF2lEvTNmWy4TIfluAxp5D0oSl3bXG7Oyjz7LO/S7yRJsUxoFhBzdBdz5X3zUu4iO2vWSmEUym+cWoQdqFMooUGuWF8qoOydW51XgTl+IrfbxegLRxNRCr5WkyZ+LAPbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S15fTuiCxiaNcdiWgjx0cLjvJVP8PB5gFGf6jj26jcE=;
 b=cZUDpPNDpgtKRSBqk6R0zozDb7RV0DiY3uS7rqP2HVO53OD+tX3Pq1lmEaOMZ/sgi5jp6bSIYVAFC8TZoRGvQUsv0BaR0k5Fjg/xyHz2rH23o8MYwAflr14E7f2bsY7ov1amdAtGpGBE1rHz3ICKfQwGfeG1LDFmCnH4GTR81w7lDOMDxLydqzmjjmbxhEf7d0ESOteB0fVlIiZM6z5TpkT53OjtaLDq8/1uiSRFvvLitq7HEnNcc0AjKDRQQr75+M7vuJnRpr379/f0i2VpnrzzwQG6w0M6QRkA62W21364745xAkf9fUUADbnFf7lZZjkjoz8pOAs7zNcjryFL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S15fTuiCxiaNcdiWgjx0cLjvJVP8PB5gFGf6jj26jcE=;
 b=te6/aJdkrBxPgKdDPonB4hNLs2KA2500Bi8fZ+gKhcwOif3YESCsjpEiZUpp1nLXYjd1H0kNaBGp1IBXytzXgHG4HW6SDu8LEIkdPMm2oVDJEA1gNEbtMlxolya1xM7wEkrDuyiSdmz9JCr4j33TlLsFoAJq3KI2qUQSUTqyGpFgl5tTzUkzRJQIosfEyivF9Dlv3mTmJnpTrZl/jmfEUURDgKCCW0yLCsQPsAtw08yruCGzEHpZDtVI/vf9UmnK7m6LTjEXKSa385JePu+vdfEIXaC6Qcu/KxC4ZEulud5Viow9cZje6/iSaV4bIFD9OOzYwAuLYGrU3wwPmtYy9A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BY5PR03MB5252.namprd03.prod.outlook.com (2603:10b6:a03:224::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 02:57:25 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 02:57:25 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: Add support for TX/RX channel interrupt
Thread-Topic: [PATCH] net: stmmac: Add support for TX/RX channel interrupt
Thread-Index: AQHc16mjeO0rYWAjmU+nZfBdtraTSLX4F3YAgAavAgA=
Date: Tue, 5 May 2026 02:57:25 +0000
Message-ID: <5d2b7cfb-a4db-45c0-b92b-fe16b9d5df40@altera.com>
References:
 <20260429072728.13638-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <42b173da-5c0b-4d72-9247-49ebec5e95e5@lunn.ch>
In-Reply-To: <42b173da-5c0b-4d72-9247-49ebec5e95e5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|BY5PR03MB5252:EE_
x-ms-office365-filtering-correlation-id: ccabb35e-534d-43d7-84b9-08deaa520944
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|55112099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 C7hr2uAEeElkGcbkupwFKSMWTMp+pDAVRDXMYz7qFp7XnlhILj+UC2rgRJ69GJTWmeC6uLIbcePM2Q3jv7AFRRTdyI0t4uFjLB8M5JsjzauW1MoFbzJ8PKKzP8nNEBOudTAMxPyM5l8Jz/NcliuaYftHyRVFTTgQyh7xyQnkTRvLnplwV2wYXiQaC7eMWG5hFxKpsrOmEqqhYXAa7SJQ3cE+zwJJiFqE24H122pFZ2c7slmk0EMW6r87CmiTX52p5w6DV3Yr+xx7uC762iGQA10IZA6qHIWRHptbtMcM2HmtUJedqr9HOn5b17dVTBkp7SkQVW38Nd2JWWe0/CdkBM4+uSUkB1OBvbwyBUnZB5NOKpp+WtsI1JNI/sc8KQ15yKYqQmTDFj92OpF2M7P10tKyCrI+5Rmjno2b7HDn+ydLJiPs7b2W6zhhsGjNjxEC1bSN6EcXYyPoeGLx8iWLKQu8W4/FN6iyFKCAQ7yyWIabYIINAuqtLhLr/h6mtdgNkVTWtGYYV+zwG8US7Ti9jnMNKjP6YjWZwsVOphgq6GR1JsIkYn1k3l4isNMDm5mGCKWFwhDGy4zS3mC6V4is0+TXefwR5O85P83RL7j+l7lGJ6FUn00iVloL2VDC9Lf51evJbY0189+DIrx/6Vgrw/5ZZGPzIC0WVJuDEf+k2XwH8Hh5rO8w6s7rztNXdpQvGDvYKWxsLhQlMRhNkxo86k5ouNNpXnxxHAQe0DRp8UFAW5lA4HRlqdGa3T5zdMWf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2FudENaQTgzUEtibkRKd0ZnSW5OMUhpQUQ3dmtndWQ5R2t0OFE0NlVNOHdq?=
 =?utf-8?B?OFh1U1JWS21lM21XbG5CZFI2WDUrQ3o5bVhwejFzdzJEYlJLTkJqWkxlKzIy?=
 =?utf-8?B?dzNlWXJ4SHVUWGdwMGJVdUV6T05tSW5tUFNna0Q3U2txY0d1dWFNWi80NnNL?=
 =?utf-8?B?ZkJSOGtZcjhvSFhhcExkeVl0NkNhbmQ5TUdha0JaZ2gvZUx2NS82bzRLVmVm?=
 =?utf-8?B?QVluVC96MXBZNnhxUWE1VFlFeGlRQ01xS3VKM25SeHpFcXJVQU5ZMVZVQ3pk?=
 =?utf-8?B?eGY4VVJTNWVTbFRUWnRVeUlQNm40cUtubUZLU2x0dGFoM3ZQUGIza0NKWGs3?=
 =?utf-8?B?NG9VMDFzVDdZU3ZsejAvREo1N1FDWEZtZkVjVFBwZThJVWF3QkRhZEN2RGM4?=
 =?utf-8?B?cXZac013Y2w3NU1nUnpwSkM2cXRQdGtTNkVTUkdEbzhXUjk2c2JmeDkzbkZZ?=
 =?utf-8?B?aTFhY21zNDNQSSsrVzlHKzdWWlYxdTQwQlV3THdpY0lEN2MvUHdRQkJvV1Nj?=
 =?utf-8?B?cVhUVmVFRHRIbEVITkF4T2xwakltT2w3d3RnUHR5ME5Qb2xFSGpJelFCZmIx?=
 =?utf-8?B?M0ZzeHVmUFF2bWlteXdHMGRPRXZaLy83dzdER3BwUnFmK0gyZXdmN2dNRVlT?=
 =?utf-8?B?ZHVtcDlrWk00RnlRNlRUN09zaG1ZdFZoSVp1RUVSZXpnNGw3L0VieGQ0U1JZ?=
 =?utf-8?B?bnkvRW10c0xUam01N3FlTEJKbS9GREJIU2JENjZaZWFEQkl5dEZPYmkwMzRu?=
 =?utf-8?B?VHpzaDRIUmttaDZSNmYwTnMxeE9Nc0ZhWU9Yb2M4NVU4V2pxZlorbXQ4TG1K?=
 =?utf-8?B?V3VvWjVtcnlFZTRGM0hNNlZySml1bjFJa01SbldSZmI0ejRCZmtFSGN2QTJN?=
 =?utf-8?B?MTgwNGdnNW56UXNrVmhSbzFoYzZMK3VlNDhiUlAyTEJoTWR6VFZweHk5MzF2?=
 =?utf-8?B?SDl2WTRFM25vYlZYeGxicGtsWmsrZzkwVDJHb1RkTGJoNE1xVjhEclVHVVl4?=
 =?utf-8?B?QUhqelBUWWtVVzEwb2FHWUtUa09qRWxmemV6TVZIUGQ1azBERnNsMWg5Y1Az?=
 =?utf-8?B?bUFhcWxHVXJRN3k1Q1Z0ZFNtNVFmajZkUjg0Yy91ZCtRdVpacmIvZHAva0U4?=
 =?utf-8?B?VWN3M25ZWmJTTUY5UmxXOUQ1Ulh2OXlESHllU2l1REd4eWV5YldodGJMT1dm?=
 =?utf-8?B?eisva0UyYXJaTWc1UENVMWh1eEpZYzVLalpjM2ZUV3g3b1NiQW5YNklXMmRJ?=
 =?utf-8?B?cmxXc3NNTTRQUnlsbE1YUzAzTlhCNmJ0Y3FWQVZYYU5wM3VwMTh0ZTVGbGNN?=
 =?utf-8?B?QzJidkNnRzZic1duTklBV0FYb1cxeEd3LzEwb2Z3clZKNmNWUHo4eWx0TzhX?=
 =?utf-8?B?R2N0Wkh5RURtLzAva2hiR2pCV2FlL005Wm1YclJJQVJiTVIzMWJRbi93N1lD?=
 =?utf-8?B?Y0c1TWtacnZiMGkzN2MrVGxjZ0lWaUU2cXRJRFpjVTNyTEttZy9SNHZVRUZp?=
 =?utf-8?B?bzJhUkgwendyKzd2SW5Namk5WXJ5ejh3YUprYTFWUWhYL0l1NjBLbkpXSnVH?=
 =?utf-8?B?a09YZEdKRXZRbWRzcEQvVmVXQ045MWxPemwzWCtOOWIybUZvUXd0RTRIRlg1?=
 =?utf-8?B?Q2lQYU9rdFVJNlBsMWJycDZPc3l2WSttNUozemNja2xOeVFUVG9oMWxzZlVD?=
 =?utf-8?B?UUZkdzRkUVBxSXgwVTl5MTZxYWtrdC8zOVQwbjkxeGZsOEVWdkRvUnQzQWs1?=
 =?utf-8?B?bUV5VnRVem5BV2d3OTJsL0cyY09KUmx4b0VUUXUrSWlWNnFIdmhWRnZUeTBz?=
 =?utf-8?B?ckg5czBUVG8zWnNwcmJPZ3dNZDYyUFN0L04ydlpxUWNLaXdqeU5PTmJuQi9t?=
 =?utf-8?B?cU5qaVIyYXVEUDBsTmFwYU1HNG9DZmRWSlVuekx0ZEVKR3FTV3pEVFRoRkt4?=
 =?utf-8?B?K1BleVNUT2VVOFFLY0hIKysrUWxOaVJSNm81M3lsRzhMcWE5bHo2dnJGQkRT?=
 =?utf-8?B?emlMZGU1bXdhU2lpK3Y4NDFhcnV4NG5ZWXc2K3NMdHFQVStyQmtUNW90RGor?=
 =?utf-8?B?d2hseVl5VitNcDBKMzVzYmFDMzlubmlUdWNiK2w4MXQrTVRHdjJNTmNvUUNw?=
 =?utf-8?B?OEwzdlJwTmo1TlZUT0hVb3RETnUrQTZjSE1zUElxU0hXSXdmRzdpQkdkVmdM?=
 =?utf-8?B?RzY1MDJHS3Qva3haa0RHU0ZZbjBzZzdVU1lTQzB6UC8yVlY1Vm1MNGpXYkJo?=
 =?utf-8?B?Mlo2Y0hjOGxCNC9Ld1k3RVIvclgrbk1TZjlKQXFzcWhvb3dTaG12Q1lRTGVw?=
 =?utf-8?B?VTh2c2RMMjRPdllqeThjVmdBOUJUclZuNmlzOE91UmdHNEtHMzQwSVBpS1lD?=
 =?utf-8?Q?rVokvDHX4O8GXN1fUfnjSrLe+F71G9yfiYg48eElQj+hK?=
x-ms-exchange-antispam-messagedata-1: DJk8MWRFkBd9ow==
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB410F40C7C0604DA65B4CAD494C8F9E@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ccabb35e-534d-43d7-84b9-08deaa520944
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 02:57:25.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jld937zfbNZtFkyoyLOOXTJySGe5TQ0Uyr5YRFR80JptoyNFM8RmSC5z6RmkYVzIaNFQ7BtuFK2eRM8kUrPKC2u+9psu7LlGHOwGgCtLKwynEq5sZ3LdQF096RsWVnhWpacMyAnNsnzTd8fik5cUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5252
X-Rspamd-Queue-Id: 5CF684C614D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284183-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[altera.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	FORGED_SENDER_MAILLIST(0.00)[]

T24gMS81LzIwMjYgNDo1MyBhbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gYW5kcmV3QGx1bm4uY2guIExlYXJuIHdoeSB0aGlzIGlzIGltcG9y
dGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0K
PiANCj4+ICsgICAgIC8qIEZvciBSWCBDaGFubmVsICovDQo+PiArICAgICBmb3IgKGkgPSAwOyBp
IDwgTVRMX01BWF9SWF9RVUVVRVM7IGkrKykgew0KPj4gKyAgICAgICAgICAgICBzbnByaW50Zihp
cnFfbmFtZSwgc2l6ZW9mKGlycV9uYW1lKSwgImRtYV9yeCVpIiwgaSk7DQo+PiArICAgICAgICAg
ICAgIGlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsIGlycV9uYW1l
KTsNCj4+ICsgICAgICAgICAgICAgaWYgKGlycSA9PSAtRVBST0JFX0RFRkVSKQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiBpcnE7DQo+PiArICAgICAgICAgICAgIGVsc2UgaWYgKGly
cSA8IDApDQo+PiArICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IA0KPiBJdCB3b3VsZCBi
ZSBnb29kIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiByZWFsIGVycm9ycywgYW5kIGl0IG5vdA0K
PiBiZWluZyBhdmFpbGFibGUuIEkgdGhpbmsgLUVOT1hJTyBpcyByZXR1cm5lZCB3aGVuIGl0IGRv
ZXMgbm90DQo+IGV4aXN0LiBBbnl0aGluZyBlbHNlIGlzIGEgcmVhbCBlcnJvcj8NCj4gDQo+ICAg
ICAgICAgIEFuZHJldw0KY29tbWVudCBoYXZlIGJlZW4gYWRkcmVzc2VkIGFuZCB1cGRhdGVkIGlu
IHYyDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDUwNTAyNDQ1OS4yMjQ2My0x
LW11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbS8NCg0KTmF6aW0N
Cg==

