Return-Path: <netdev+bounces-304341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J7gODYJIR2p/VQAAu9opvQ
	(envelope-from <netdev+bounces-304341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:28:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F146FEB91
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:28:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=RHDEVOIB;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304341-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304341-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C4F830099AA
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FFC3596E1;
	Fri,  3 Jul 2026 05:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9A3451C1;
	Fri,  3 Jul 2026 05:28:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056510; cv=fail; b=SE1Ank60tmYVfrNsRXg6h1PkfxZNwaWo/3yRgsz4bEwMvDu9npwzLcg3j6GrtgCL7ujuSqMs82R2wx4LIYsen5VUjaJZZP6pYHgaV30wKQV2b9bF/mXlHHnTpoCIePfJN+fnbLh59BPlg3NWVxhwiH0ky28zBfjptq9T+WxoK8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056510; c=relaxed/simple;
	bh=YPO6lURBCbrl+d6+aNQKJFV3XNDh7KzQM3ObKnOiOjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNd2dxnrIH5ZquNR/ROkviGNuBBVONqUqbkUBpRPiyH81/5sPX3EslvQhiaqo2pFcUx0MAhbwnPCYVSg5xQV/KVNc8hVN+36BXnS+IpdMGsUNM7OK/mjSgIBwibpyr4+X6FBE6zRy7lPE0IWYr7K64Ab86jksRuyv5vSsW7Tthg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RHDEVOIB; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho7jd2hRYS3jtslPQYBNO7NHiUZoSYsCUN3y5tydAQgTIoD8ngyuuEgQ9WV7Cbm8iBjqzhKUmiSQZFnow+vM/s2VI34nwHaak/F6Ke6UJpDEkXMfMXYfc69q+rTZtpuNQDsNzMyZSK4ggWggnb+5gSImqVG2X4jl1F+Vyy91Y/nUobjVax1loribNfBvGrRVOc28zo1Vho1Ti/ibDyrSBSRyULFzSGXNEJiRWxH94bnciunYytblpec+Uk5i63cB5MZR0CvWXVzfu6+f8onO37wH7mh7HiHorn2nNUf3EYlAD9H9Gl4soUynzsDOm6h5Ib6wqecq1ZOaRtEznUDuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPO6lURBCbrl+d6+aNQKJFV3XNDh7KzQM3ObKnOiOjQ=;
 b=WtkLVBfn91de9d1Hed/WxMZ3tnsWS8Lq1vV5tTVBovWHud+UPiAmFpw10FQ4Udmq0hXRgUPuPVxnRsTu/Y4PS7GqsDws2niGM9vibWdw4sWXqI1q/KvMkzqfM2vZAjmGKZcJnrKFcpSFQ0jKehPPWECa1/9cucBOip2HIxwai1G7chQUSuJuYMsG+3aRO6EnDdYdRjyLISIzmni9Nt0uEUP6oE/AhaM++ZBf8WSPwo0fXWbeBkm5iy53P8xYHbFFyzV3MXxSjbdnINggQcu5SgqVZSoY13kY8CJcpkAsEL3OUfHRPPp8U1Rv7/CsdYlFn5+RLUoDIXaYYGZ+MSQOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPO6lURBCbrl+d6+aNQKJFV3XNDh7KzQM3ObKnOiOjQ=;
 b=RHDEVOIBu9MdtRMX/B4yi8pt9uVJSLMbVadMaPgsfYa2XozMg1E8WrNV4H5iVRXq0Zs/f5hrlaUc3giX53zyEnANY2wphftGKfq0mhP/WciaxwrGEhAl0RV/0760/04cA9fBskC8WxJlNBlpVijwjJM4IgDi+Khn292ZrU/80Rj9q+JMxp3OH45bN+SzY0E3tqbCrBg7K86eKkc3OXEq2Kv6bMVSiEiS8Mt/puy32eh+G8hF9CAnY78eiWekuAKa4t4CfQK5l7Evr2DP0Wz9xI3bDFMKyeaPrcCJw8nwwlzplmT+EkUJLbrML929HZyjVQLDA+j+64OOJhGPazLpIA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SAWPR03MB989645.namprd03.prod.outlook.com (2603:10b6:806:561::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:28:19 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 05:28:19 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
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
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Topic: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Index: AQHdCJS3eKbhTF393kOGxrO3eujj3LZZ1I0AgAFzzQA=
Date: Fri, 3 Jul 2026 05:28:19 +0000
Message-ID: <e873fdab-0866-4cd0-a0fc-73a4b8bdef00@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260702-heretic-fractal-jackdaw-70681b@quoll>
In-Reply-To: <20260702-heretic-fractal-jackdaw-70681b@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|SAWPR03MB989645:EE_
x-ms-office365-filtering-correlation-id: eb3222a3-3e06-4c1b-c791-08ded8c3e450
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|4143699003|11063799006|6133799003|56012099006|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 c8NOOjjUcpabL58rJVMApUwJag55D5Df96pNUG9HtwTxTSof4H4fMmh36+k+M8L+2c4mWreoTkYyf90oYPPT3z2+v8QaZaeAvgdhaITg0c+9Bqzhi1H91NgmFbaE6aVmoz+8Ig0XsgMytTpA6sAHH4/xymlXOe2mnB5xAl+nz0uS9mY8v2ZjSUPoINbZG9Gv7pPpYWVpqChZuTixNJDmFhUKjSDvC9nxc4R2tUWS6vG7/FStQZBzhRycoVNhSoIe4R3kFfN1tcM+35Kbm0Z98tGmw3i0WpR08wxq4p0TyTAlYXU8wyI4QK8mJhx8IQxj9A9JdgU1KSk4KHNDlsT2znttZgscAPx7y62GnQhoSLzF6HBZUQl8/XEzTbMZRkXCg5G5jXfspV3ZnlKTrr6Hsfq+xV+yQPZakHNlJNVAKBXBmVpOKuAossGL/ES8o3U3OaeN5VwiOo+ACh0/41WgOpnL9s9IDXA7QtHpdXwJ9GSXU0p4QLsjykHjCcdaD2EVnO5tZ/eduvaKs+kML3wPWUiwx6A6iYbeoR/E+/N8BZHiQfcTcR4at21B/8vioM0s3fLbxg4JQlFu29iObhuW5gyCwFZwYpwW4RDOjbSiF+PqYTXelIkmKDZjpLJevVRnjeEueD6b+IA13IPGuUh833kdo1X/1yHaQ5NBM8sleOy9IkeHyWKCWsRadCr6O++/yxhVq9+IGea6/vha8KAbkQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(4143699003)(11063799006)(6133799003)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnZSMXJnM1FwdThCbHdteDRUQ0o3eEwybmJOS0VtOGZiclZHdjVXSGZ6R21B?=
 =?utf-8?B?aXhZV1lHK3BIRTJHMk1GRmV1eWdHK21qZU1sODRyZWpCTWhxY0JEaEtaMS9j?=
 =?utf-8?B?ZkE0azVvelF6WDkwa1kzS2t0VlMzOFZ0QmpGK3hnWEFnMElPL21LaCtBNWtu?=
 =?utf-8?B?bGdrSCsxeWY0K0xEUHdyZFBOM0ZkV1cyRTBudTEwd0lEVzFIQ005T3ZGeDZE?=
 =?utf-8?B?cmdtM0NIL3lMbXJxdWQ3bVhWekZFeU5QYS9LMnB2SWZaRkZwc0hYK1AxV0tF?=
 =?utf-8?B?Vkcrd1RSdnhzNDFnbVNLS3ZzRDVZYlhKS0IxVkVuWXVUMDZaS1lJUVVSWG9O?=
 =?utf-8?B?QlpXc1U1bnJWV1VaM3ZiWmZkUE5ZakJuT05XQjJRYUtMdXZmSml6RFd3djNQ?=
 =?utf-8?B?NGg0ZW5mc3FLdDMzOGswZnpYMGRrU1g0UXF1Q2NlclRuVDh2UGZtUWdnUXZN?=
 =?utf-8?B?cFQvN2ZmZ2E2T1puNEg0Y0hvSFVyY3hZWFJKaUd0dkQ2RmxvSDQ2cnB5Z0pI?=
 =?utf-8?B?RXA2MEhPRmd0QkEwSkFQelIxYzVzcm4vRC8vVTdUbUhQbDZaRStmVCttOGlq?=
 =?utf-8?B?c3IvL094cVJaVm9FWmdGT0NvS2MzdEZRWFhIYVBxa0ljNzhVYWNFbnRqQWh2?=
 =?utf-8?B?MjhRUUlkdWZVVSthWmI0MDZ2OHRHQjZvRjBvMUU0V3YzMjN1NkN2bEVhWTly?=
 =?utf-8?B?TDgrNXJ4ZEJPcEJwVXpucm91cWxuNVlpNkNpM2hUNGVVZGFzL3Iza0Zkc2o3?=
 =?utf-8?B?V244N2NxaExuWUh6TzVvMjE0VXFENUFWUmpjUStHaXJaS2FsUmlwUzFMOGtp?=
 =?utf-8?B?SVRlNHlQSDNNczFDYVhvd1FIWmFqQlVtbVloUUQ2YzBVaVlrNFVaYWNETGJv?=
 =?utf-8?B?VjhlYzJzWVBXeE1SN3ZMOW43RGppSWpVemZxSDJsdEtsWEJUZVI1eWY3eXc3?=
 =?utf-8?B?bkdjMUdaVjlhQ0Q4T0RqWFRSS0NZL3ZmUXhBclltNGgxNGNuTzBVQ1RVNlBG?=
 =?utf-8?B?WW5uNmp0clVoZWZlczFlTjQvOGVicW1zTHQ2aFJYMmtRTkN1SThoQTFPTXRi?=
 =?utf-8?B?V0FvRDBhWlBvb1RHNnFCT3FVL1JIRWpncDF2dy9NcGgvRVlIeTQzZU9HOWZK?=
 =?utf-8?B?dzBlVENJRUFPQXFRWWpPZ2xIQzhvNFVPaUFESTdpSFJBOTJFeFNNcWlaQS81?=
 =?utf-8?B?cTFvSXE2aFg2djgrQjRwcHZLLzFjU2VrVUViZS9hUDQ4T2N6UlVRSHI1UCsw?=
 =?utf-8?B?elJGUGVmOXFuVXRYRkJFNEx3cHlYMXRxT3kwMlZib0ZPREdwTVk3S2N1eUpx?=
 =?utf-8?B?aXd4U0RnY0hGZ1NscHVCbXRoY1RJc2tCaG51NmcxL3RvWmhGL3czaTBycHdu?=
 =?utf-8?B?TWkvTm9oMkF4NDVxcDljb0QrZEgweFVWc00vdUd0dHlwSHhGQmozUjNaK1NJ?=
 =?utf-8?B?SmtsSjFaR1JjYmJVQVhpS2xDVFVVdTFkNVZ4YjlvNlJXek1seVRIUE04T1Bz?=
 =?utf-8?B?L2xpUTJadkxRTzlzUDgySy9OcnJzbUhtQk9UYm9IeUhxalFmY0pvNy9GTFVa?=
 =?utf-8?B?ZVpBaHN4bHVuNWNyTm4xdXhvNlpQVkRqenlWK0xOLzAxeUxrSXVVUjBpV1F6?=
 =?utf-8?B?cGtnelhBZ1RrMGlWQ2t6Wm1tclFkR1ZEZUZ5THRoQkRkSVhEQy9RbzFjbm5r?=
 =?utf-8?B?SGVvblZhaVg4S2VGdk9rVkR6bnZ3NFhSWmowVHNPdU5jV29hZzNyYXpsMU5k?=
 =?utf-8?B?dzlPSk15aW94ekdKZG15dFBhSWR2Unk1a1ZwQ01FcjJvaDBock41c3JpNlN4?=
 =?utf-8?B?OTFCd0VjR09ZRlF1SlBzbWswRXp1RnJzdm95SUdwajRSRjBtSjFrMzh6Yk9B?=
 =?utf-8?B?K2JSOUI2TUp3VnZsTkNOQXhJd290T1FONmlsWW1QcndYMmZvbDNLYWRsSG5i?=
 =?utf-8?B?WGVSMGo5NTg0VE9NajlHNDlqSDBNZktwYkI3T1FKdHVVRWhBSlU0TW13MmZm?=
 =?utf-8?B?dmdDS1JabHlPT3QzU203VlZEaFlEQnE5ZFp0VUN6S2Vqd0wwQmRabnFPQzds?=
 =?utf-8?B?RlBDZjBLRlVOeENhUGdJRzZDUGc3K0U2MDhianhjWmpTWlJ5Z2RCTlFrUnhq?=
 =?utf-8?B?cU9CWHZZd2J6djVuT29DL3Z6c1ZkTDUzVnVYbXNwN2hjaVNZdURRSVhZRDhM?=
 =?utf-8?B?cm1haTViQkN6aXVtWmZYOHNuVlJjTkZSSkN5TGFzanREcmcwQkhnVW5tZ0dw?=
 =?utf-8?B?S1pudkJ3Z1RGWlBCWEdFWlFFK1Rubit0ZWZsMldZb2N5ZXR3QmIvNk9XRXdy?=
 =?utf-8?B?QmxnSWdqaWNadWpSWGRERzlLWGVPRW5UVUNtVlhONyttMzBiMmxsSEJBTVpu?=
 =?utf-8?Q?Z0ZuPOPRogpwRTAcFsNhl90cY94EzSybBc+qJWIsuRTiR?=
x-ms-exchange-antispam-messagedata-1: P+shNfgak3Q8NtNvi3hGZqXef5sidj2lGho=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44D343ADE62C104BB061BF05C438A16E@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3222a3-3e06-4c1b-c791-08ded8c3e450
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 05:28:19.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRsEGDQKQzActe4/+4Qpzbfy7CQnuORD+YNk0UMDhfIarf8PVn1RelPP9LytIVCoOnfNITzHxykEruIdTm5vkbd0tqzPfKxs6dRx8xESLDa3XpWUq/VAGjKXcVj3vMAtnNpKQUxqoPKZG20cG0iW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989645
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304341-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7F146FEB91

T24gMi83LzIwMjYgMzoxNyBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gVHVl
LCBKdW4gMzAsIDIwMjYgYXQgMDY6MzE6MDdBTSAtMDcwMCwgbXVoYW1tYWQubmF6aW0uYW1pcnVs
Lm5hemxlLmFzbWFkZUBhbHRlcmEuY29tIHdyb3RlOg0KPj4gRnJvbTogTmF6aW0gQW1pcnVsIDxt
dWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20+DQo+Pg0KPj4gQWRk
IGRldmljZSB0cmVlIGZvciB0aGUgSW50ZWwgU29DRlBHQSBBZ2lsZXg1IFNvQ0RLIFRTTiBDb25m
aWcyIGJvYXJkDQo+PiB2YXJpYW50LiBUaGlzIGNvbmZpZ3VyYXRpb24gZW5hYmxlcyBnbWFjMSBh
cyBhIFRTTiBwb3J0IGFsb25nc2lkZQ0KPj4gdGhlIHN0YW5kYXJkIGdtYWMyIEV0aGVybmV0IHBv
cnQuDQo+Pg0KPj4gVGhlIFRTTiBwb3J0IChnbWFjMSkgdXNlcyBHTUlJIGludGVybmFsbHkgaW4g
dGhlIE1BQyBidXQgY29ubmVjdHMgdG8gYW4NCj4+IFJHTUlJIFBIWS4gVGhlIG1hYy1tb2RlIHBy
b3BlcnR5IGlzIHNldCB0byAiZ21paSIgdG8gcmVmbGVjdCB0aGUNCj4+IE1BQy1zaWRlIGludGVy
ZmFjZSwgd2hpbGUgcGh5LW1vZGUgaXMgc2V0IHRvICJyZ21paSIgZm9yIHRoZSBQSFktc2lkZQ0K
Pj4gaW50ZXJmYWNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE5hemltIEFtaXJ1bCA8bXVoYW1t
YWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4gLS0tDQo+PiAgIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvaW50ZWwvTWFrZWZpbGUgICAgICAgICAgICB8ICAgMyArLQ0KPj4g
ICAuLi4vaW50ZWwvc29jZnBnYV9hZ2lsZXg1X3NvY2RrX3Rzbl9jZmcyLmR0cyAgfCAxMzMgKysr
KysrKysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTM1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9k
dHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1X3NvY2RrX3Rzbl9jZmcyLmR0cw0KPj4NCj4+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL01ha2VmaWxlIGIvYXJjaC9hcm02NC9i
b290L2R0cy9pbnRlbC9NYWtlZmlsZQ0KPj4gaW5kZXggMjcwYzcwZmRmMDg0Li5mYzdiYTJjNjM4
NGIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL01ha2VmaWxlDQo+
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL01ha2VmaWxlDQo+PiBAQCAtNCwxMCAr
NCwxMSBAQCBkdGItJChDT05GSUdfQVJDSF9JTlRFTF9TT0NGUEdBKSArPSBzb2NmcGdhX2FnaWxl
eF9uNjAwMC5kdGIgXA0KPj4gICAJCQkJc29jZnBnYV9hZ2lsZXhfc29jZGtfZW1tYy5kdGIgXA0K
Pj4gICAJCQkJc29jZnBnYV9hZ2lsZXhfc29jZGtfbmFuZC5kdGIgXA0KPj4gICAJCQkJc29jZnBn
YV9hZ2lsZXgzX3NvY2RrLmR0YiBcDQo+PiAtCQkJCXNvY2ZwZ2FfYWdpbGV4NV9zb2Nkay5kdGIg
XA0KPj4gKwkJCXNvY2ZwZ2FfYWdpbGV4NV9zb2Nkay5kdGIgXA0KPiANCj4gV2h5IGFyZSB5b3Ug
bWFraW5nIHRoaXMgY2hhbmdlPw0KSGkgS3J6eXN6dG9mLA0KVGhhbmsgeW91IGZvciBjYXRjaGlu
ZyB0aGlzLiBJIGRpZCBub3QgaW50ZW5kIHRvIG1ha2UgdGhpcyBjaGFuZ2Ug4oCUIHRoZSANCmlu
ZGVudGF0aW9uIG9uIHRoZSBzb2NmcGdhX2FnaWxleDVfc29jZGsuZHRiIGxpbmUgd2FzIGFjY2lk
ZW50YWxseSANCm1vZGlmaWVkIGR1cmluZyBwYXRjaCBwcmVwYXJhdGlvbi4gSXQgc2hvdWxkIHJl
dGFpbiBpdHMgb3JpZ2luYWwgDQppbmRlbnRhdGlvbi4gSSB3aWxsIGZpeCB0aGlzIGluIHYyLg0K
PiANCj4+ICAgCQkJCXNvY2ZwZ2FfYWdpbGV4NV9zb2Nka18wMTNiLmR0YiBcDQo+PiAgIAkJCQlz
b2NmcGdhX2FnaWxleDVfc29jZGtfbW9kdWxhci5kdGIgXA0KPj4gICAJCQkJc29jZnBnYV9hZ2ls
ZXg1X3NvY2RrX25hbmQuZHRiIFwNCj4+ICsJCQkJc29jZnBnYV9hZ2lsZXg1X3NvY2RrX3Rzbl9j
ZmcyLmR0YiBcDQo+PiAgIAkJCQlzb2NmcGdhX2FnaWxleDcyX3NvY2RrLmR0YiBcDQo+PiAgIAkJ
CQlzb2NmcGdhX2FnaWxleDdtX3NvY2RrLmR0YiBcDQo+PiAgIAkJCQlzb2NmcGdhX241eF9zb2Nk
ay5kdGINCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQpCUiwNCk5hemlt
DQoNCg==

