Return-Path: <netdev+bounces-303437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F3LwKW53RGoxvQoAu9opvQ
	(envelope-from <netdev+bounces-303437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99A66E932B
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:11:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=Nfx2Prco;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303437-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303437-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A11A3013C60
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533B33557F3;
	Wed,  1 Jul 2026 02:09:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824D23370F;
	Wed,  1 Jul 2026 02:09:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871774; cv=fail; b=P2AP1GUM7FLgdOocsoaW+O+Zf+RzbgZNOvCbXh1PEn2d31IhEmdxa8YcSqO6GMuWsycc9B270yNNVrQoUlPKyG2eHP8O/Xzh3+eTv5yAkpchl4qfJN5fq2/oouuRAv3qIsfVo3n8WrotTj8N383S1hetKmcqCFUudeUbVzk5O1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871774; c=relaxed/simple;
	bh=20GEOoWVXtFwTGkXU2zWhkLooH2/6u+j4KTV7HVvqXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDsWUqCoKamP5yLEcLCpELbK/x3YuKgPVpmNPaFKqHupKO7YkJQC3SF5ZLH/M4gRlRr0XOfdTERUB8FyysdNaUeFg+hsZeYBUdnJJKpAfVy3Bb0VSz/oDqCikEXsoNHLS1Mqk3vpUbue0ahsmLP/SWgJ3VAkt2CVURK2WAkT7ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Nfx2Prco; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am5VGGcyRdtNUDOk4oKZ24/X0Hh08pImwa+33kGFFOAXCv3X2SHx9yeIoHdB7ILHR7Mau81SKylvW2irOAF1dQFI7IP1pLOOOBqqDnSJzEqeN9gXOFcprNjQSNw8yvftuW8krVfb1AjpIkVj/8HaYp/cF5JGn7pGkoJR5k8HVMCr+Fk7EU6oNy9fYyJhWtsc7CSsMu1NojUsn+psIeqN3j0nSn1nRcDvYtDrcb/L1+IaXWNZenMM9R7j4iBrMt1SQKBG+Z95WkahycVlLT8QeZ2Enn6G/JWAJpCOJOEx3i0UN6W42ONjz408m/Vmdb/l0SLMcU/YyV/VB0jDeOtNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20GEOoWVXtFwTGkXU2zWhkLooH2/6u+j4KTV7HVvqXc=;
 b=ETLDxIfxZPVUci7eRjWiDuJYzJKjRnQouDGwHez+WiD66Tv1SEDhN7hhDRU0BKfFsptfDfzXuv8bnxcBGAXc2kE5MNLKz4qPMmN/AcYgsgyjYVUn/PtO9GpZGgdbot1iBOrkxRg+w3SOsIZbdyp8sAnOtkx+R7e9winoIuw+m7lg6Ae0PgUxJdRU+7MifGyrvhxl2IQ0AlH4gPtG5Hvpc8/5f+62pcEMqYb2Dsm9rOPWErFsANAo71I9jjYAesxCHcWT3cfiShJr4HCEj4SOdMq0vgXFPcuXkQPSar9OYbZkEJWXM0dvsb4LApbjYG64JZci+PGBWTeNDN94Nzib6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20GEOoWVXtFwTGkXU2zWhkLooH2/6u+j4KTV7HVvqXc=;
 b=Nfx2Prco5RuWL+SbIjQmkCvpfndQ5pHdKiezFZC5SlWrVgawoyx9fXquAZPsxDcm5XUmOTFZhr57ryeKyVhDD7lK4zIco0PpHtQEJS0t7XdfD+RUo1F3PSnpZ6QQa+fQs56TDPjtMoHGe4CzSpj+QBH5kt6a3l6Y7yTOZScmbv7gT913S4VgiYRY3CT3adJR/9lBn4o0yly9nt8xTkTWxgqxzeGHmXkwdtDgHrIL8I7E4K1tkUVIbx2HLAZgrdZUcBVYBXTf6xizFP329zbFV4crSLS9eZ3T3bthWS5dkEOu0jwyxbK5/n/0897obJzqKgZ+E6SS6vJ+n3qH5uPZ9g==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH3PR03MB7436.namprd03.prod.outlook.com (2603:10b6:610:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 02:09:28 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 02:09:28 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "dinguyen@kernel.org"
	<dinguyen@kernel.org>
CC: "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts/net: stmmac: Add Agilex5 SoCDK TSN Config2
 board support
Thread-Topic: [PATCH 0/3] arm64: dts/net: stmmac: Add Agilex5 SoCDK TSN
 Config2 board support
Thread-Index: AQHdCJS2cYVZ644zC0qC6sMkDkZ86rZXHmkAgADNt4A=
Date: Wed, 1 Jul 2026 02:09:28 +0000
Message-ID: <5a14a8cc-028a-4053-9c56-b4e8f275366a@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <563ac947-0c5d-47ee-aedc-66baf4d32648@bootlin.com>
In-Reply-To: <563ac947-0c5d-47ee-aedc-66baf4d32648@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|CH3PR03MB7436:EE_
x-ms-office365-filtering-correlation-id: 87d67438-89df-43ff-1378-08ded715c7f2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|38070700021|3023799007|55112099003|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 JDtDehAKmHWMOBfobSwH6MhS+n2asVcVcEl9xB121Sbpg+PnLup972mFztt0ppzkqcfxAGVYTKVCNqFuJ68dbUwrI334Y18d35/6V5SDR5BNRogAQUibMENJ4xjk3OqV2XPz48DIrJLnKwx8fBR2C9686wnDkGYy2XvQvNasIzYQppCuiQIXq7KQKCB/nBGQu8GCq1QF30o3N4nrzl2/1k9rox7L2Eei6ig1T0PMO2cr4udqmVFQgX8x0uJGQrLH4ldjpRmJLlUdUJPOWcBH6QE03Hg/xR0T9e1/mXgLVfyXzV4IhBv1NQM3DyPRbaed9g0hMxkFN/GrkPQcH6amM48v3TAhLHAQxYO3E9wKdI2MDVooHHp3QI2w8WxsSACTtdNjr4yL9uatg7J28mmnFgkzKLGZ04lFjem3/l5A/MfQ3rmwA94Emw/sgNwafrJDQVcazDor2D0K9+wC9ILY7XhIh7O/yaFUB5a76Ofdc5IsAr3n2i02cmda64DEF9NYSocvOQT39OJu1/HtOB+58M0pnzbS5Tio6alYxokGnsvsc1ujZWl9B5iBqSi4eP8Pg+oJ0CbrU+JpHGnhU6uIwS3DD3VZ97xYothFh5SUKSqVab31c3vEkRfJpX7vQHb1D6EgWQsR0TgKtnC/Sq/58y167tb1u+ev/BS8Q0VOTXCeI0OQQJc12aoR+Gpi3CIjf8EjcUoOdCMt7IQ0VFS/2kDa+D4g0pYwFIUTYCmeWR8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(38070700021)(3023799007)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU5CSjFFNXFzQ3FBSGZjMzYxMHlZaE9ZcUptdERWSjI0TzJrTGJoN0tjRjYy?=
 =?utf-8?B?MHk2QTlxNllPQldjQ0xTN1plaUlPRzBobGgrYW12c1VPVWRiV0MwVDNnUjdI?=
 =?utf-8?B?TzFwY3ZjeFhtbll3bG5YOVJVNjZVZTcwZC9jM3ZCTWwxRWdRRFNPQ082WWtM?=
 =?utf-8?B?MXhxTHg1c25pU1ZYS2RlcHlNdnV5WnZHM1FmR2h3dy9rWnVDRWd0c3paVEox?=
 =?utf-8?B?T0NMVkFMcmFwNzJXRTBBZGt1UksrRk1WN1JHeXVXcGR4c0hLQUNKUURHVHFD?=
 =?utf-8?B?SGlXN21YcytNZ3QwWFdibnNVQXJRQmtucEMyTGdtN2o4dytMWWlTMEJ1d2FM?=
 =?utf-8?B?V0M3MGovaFB6QkhrZlRjWXZOVDh6Wi93V3h1WlVwbTFLei9heUNaQ3JuOXFI?=
 =?utf-8?B?cVB1MTlJNW5mQVZQSjhQZ3dvTHE4aVVVUmdDWjlMbHlUdnU5UGRjOFQzODkv?=
 =?utf-8?B?YXVQU2lHSkNCZTlrd2s5blp0NVNPN1g0cnZXM1VMMXpjSWEvY0ZEZFlkLzhI?=
 =?utf-8?B?VStBUGFxdW9iN3Qzb2I0R1V5ZjBtNTFIK1FCd1dlNXJJSCtOUW1MczYyYUpX?=
 =?utf-8?B?bUJqTUVaTW9uY1VEZ1ZPNFdVMHhqcnNLak1rSjh3N3JQZW95N056R0x0dVlG?=
 =?utf-8?B?eVFNTnd3V2h4d0hrb1ZLMTByV2UwL2xTRGFvSFZuMHlibWlMZ3hFYkxZdzF0?=
 =?utf-8?B?N2NPUHJZbGMwNFZPTmdENzhUeFd6dnVmKzIyTUpzeXNTRGNkZm5ic3BzL1Qz?=
 =?utf-8?B?S2ZWRWd3bXFFOTFWSGdheit2ME41T0ZPdW4vbC9hdlE5a29NOEpIZmphbUhP?=
 =?utf-8?B?SnRUbnljTkJHVWhZWVk4c0hHWjZCVTNwN3ZhNWRISjBGV1VqSU1nSnc5aEtq?=
 =?utf-8?B?RHlQamhBOFZxd3JuYmxBSUFCTjdhcGNZNGlEOWVVYVQwV0plZGtBMVkvbGpE?=
 =?utf-8?B?SlJUVjNRZU4yVWlpajcyTTJsemdkeWhtYWNrVVB1VHYzTkNFNzlaa0F5dTRF?=
 =?utf-8?B?WWE2cm05Q2tuendQaW9RNEdERWlYSnhEQ3hRNUk4YlRtNTNUSXdYTmlmMWwy?=
 =?utf-8?B?KzRjbTJ1NlYxeWF4dStnaEFNWnFYdmw0TzZXSFF0eVE1ZEZJM2FnYWRnT0xm?=
 =?utf-8?B?dmxEMitDSXo0WUdhU2oxWjh2dk9KNlZXN2NXaHhITDV5dWpjalBncE9PQXBY?=
 =?utf-8?B?bVl2MGk4Q2FvSW5pSm1nTkI0dlB1eDB4cXBuUmpybFFzNHdMbTEyQ004bkli?=
 =?utf-8?B?cE80SE1jdHNsV2NSM0dIRUQzenVBTEpjbXpBQnA1UTFKQlJnR0E5V0NrZW5M?=
 =?utf-8?B?UGVyOFVEL1lMS1JYUzN5V3gveGtQdkYxKzNYWWJVYWZLbTFCb0N6Yld4ZzRK?=
 =?utf-8?B?ZTdnZitPeHhBWFlyTWJzZWpnOUZZOUFhazlYdjE1QktvdGFsSEhHWmpXNlhC?=
 =?utf-8?B?SmNSWDgzazFvenpOU2FwZE1WQk1NUTlWVndyKzhtT0NHeDBjaUhVWjl5VnRF?=
 =?utf-8?B?U281Y3VUTHJsV1VuVWhOd242dHd3VFNNcEFrQ3l6dFdWWDEva21IbFlhRE92?=
 =?utf-8?B?Ny9ieW1JVnNFblBNM0ttY3hzYjNxN1p6MmtIa1RaZUJFdWJFcHRKYUNMYnBC?=
 =?utf-8?B?b2lLTE1taTg0OWVlTTNEOU1ldGJQUmpXcWx4M3Jxdk5GQm1BdmRXaXNvSkJk?=
 =?utf-8?B?ZnFJWVlnTS9WeVJLUzVZWFMyRy9tZyt1MDZtdjF6QWJ3SVhQMUY5U2xJdkNX?=
 =?utf-8?B?TlAzbXRjTXF4KzNEMWtqMy9VTXU3dVJLZlFnTG9RNVdwNWhpNlZxc0JWZHRv?=
 =?utf-8?B?MXUzTlN3bC9nUUJURmxrdWFPTytITWVwM0NlWkhjL0FpZ1dORUJWL2ozNUdX?=
 =?utf-8?B?Ry9qQzZVYjAzVG1vWWVqZTBiWTd5d25RdGRiTXA5S3JidzFhOUJRNzhQTHFL?=
 =?utf-8?B?WFpnYXJ6U0NVZWxUNGNYWHRZQzJSNmFwTmJCZHFTdFY3MXU4K0NTcExlVkVy?=
 =?utf-8?B?Q2I1YVl2OTIvVkJXWWdUbXh6NWc2cG03bFFLbVNKK0tRazNkNHZTVE1NditS?=
 =?utf-8?B?RTNUcmQvdWl4bW1nTGtnNEplVlJ5UXF2NFhEenJpOCtCclhzdXBEdVI0ZUdZ?=
 =?utf-8?B?R21ndlFTdjd3bmxzQ2RYQm04TGtlYVFGNVlLV2lpNHVoN2tQWDV6NzRtUXUw?=
 =?utf-8?B?b0VDYlFja3BtQ05XSVN5UXV0d2lTbGJnY1VwYmI1YUNRMlA5cUFDcm1BZW94?=
 =?utf-8?B?c3VKZUp5UDRHMFdqSi9hWU5EZmFPcHBsemJnYmdQU0ovS29TL2VrUURhZ1pE?=
 =?utf-8?B?MWhxYUMyekpIdEdwRERkYlhzQzJHMkcxRS9tU25NZVhwU2d1YjYzUldTM3BN?=
 =?utf-8?Q?8DpfSjZ/cKF/LKgB+HsiLx1iT9Zxbsg1Fk+cKRUTPoY8+?=
x-ms-exchange-antispam-messagedata-1: YBQe2VxzPmj4vU8WI3eBI+S2CXOHmHH0jMA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3792D060F9E274DB9F13160AA0D0F64@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d67438-89df-43ff-1378-08ded715c7f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 02:09:28.1524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3V4fP3obYrI2NXHBoHdlS+fCE84vSlz9o9Hqt0Ytvr1EBoSVcAANy4yCljakk+AnXROqpNmbJcoYQH1KDa7K0jTMJCbdwfTNmnzuRXIh6PGgeFokymzD9GJMJVppNmSDu+Z/qhhl+5SijHraQ50Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303437-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:dinguyen@kernel.org,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A99A66E932B

T24gMzAvNi8yMDI2IDk6NTMgcG0sIE1heGltZSBDaGV2YWxsaWVyIHdyb3RlOg0KPiBIaSwNCj4g
DQo+IE9uIDYvMzAvMjYgMTU6MzEsIG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5hc21hZGVA
YWx0ZXJhLmNvbSB3cm90ZToNCj4+IEZyb206IE5hemltIEFtaXJ1bCA8bXVoYW1tYWQubmF6aW0u
YW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4NCj4+IFRoZSBJbnRlbCBTb0NGUEdB
IEFnaWxleDUgU29DREsgVFNOIENvbmZpZzIgYm9hcmQgdXNlcyBhIGR1YWwtcG9ydA0KPj4gRXRo
ZXJuZXQgc2V0dXAgd2hlcmUgZ21hYzEgKFRTTiBwb3J0KSBvcGVyYXRlcyB3aXRoIGRpZmZlcmVu
dCBNQUMtc2lkZQ0KPj4gYW5kIFBIWS1zaWRlIGludGVyZmFjZSBtb2RlczogR01JSSBpbnRlcm5h
bGx5IGluIHRoZSBNQUMsIGFuZCBSR01JSQ0KPj4gdG93YXJkcyB0aGUgUEhZLg0KPiANCj4gVGhl
cmUncyB0aGUgc2FtZSBiZWhhdmlvdXIgb24gR2VuNSwgZS5nLiBDeWNsb25lViB3aGVyZSB3ZSBo
YXZlIHRoZQ0KPiAiRU1BQyBzcGxpdHRlciIuIEJhc2VkIG9uIHdldGhlciBvciBub3Qgd2UgaGF2
ZSB0aGF0IHNwbGl0dGVyIGluIERULA0KPiB3ZSBvdmVycmlkZSB0aGUgSU5URl9TRUwgYml0cyB0
byBzZXQgR01JSSBhcyB0aGUgTUFDIG91dHB1dCwgdGhlIHNwbGl0dGVyDQo+IGNvbnZlcnRpbmcg
dGhhdCB0byBSR01JSS9TR01JSS4NCj4gDQo+IElzIHRoZXJlIHNvbWV0aGluZyBzaW1pbGFyIG9u
IHRoaXMgQWdpbGVYNSB2ZXJzaW9uIGJ5IGFueSBjaGFuY2UsIGZvcg0KPiB3aGljaCB3ZSBjb3Vs
ZCByZXVzZSB0aGUgbG9naWMgPw0KPiANCj4gSSBrbm93IHRoYXQgb24gQ3ljbG9uZVYgeW91IGFs
c28gbmVlZCB0byBhZGp1c3QgdGhhdCBHTUlJIC0+IFJHTUlJL1NHTUlJDQo+IHNwbGl0dGVyIHdo
ZW5ldmVyIHRoZSBzcGVlZCBjaGFuZ2VzLCBpcyB0aGF0IGRpZmZlcmVudCBvbiBhZ2lsZVg1ID8g
aGF2ZQ0KPiB5b3UgdGVzdGVkIDEwLzEwME1icHMgPw0KPiANCj4gVGhhbmtzLA0KPiANCj4gTWF4
aW1lDQpIaSBNYXhpbWUsDQoNClllcywgd2UgaGF2ZSB0ZXN0ZWQgYWxsIHRocmVlIHNwZWVkcy4N
Cg0KMTBNYnBzOiBMaW5rIFVwIC0gMTBNYnBzL0Z1bGwsIHRocm91Z2hwdXQgfjkuMzUgTWJpdHMv
c2VjIDEwME1icHM6IExpbmsgDQpVcCAtIDEwME1icHMvRnVsbCwgdGhyb3VnaHB1dCB+OTQgTWJp
dHMvc2VjIDEwMDBNYnBzOiBMaW5rIFVwIC0gDQoxR2Jwcy9GdWxsLCB0aHJvdWdocHV0IH45MzAg
TWJpdHMvc2VjDQoNCkJSLA0KTmF6aW0NCg==

