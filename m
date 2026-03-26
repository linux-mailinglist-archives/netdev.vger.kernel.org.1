Return-Path: <netdev+bounces-271919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHmoFyXqxGkz5AQAu9opvQ
	(envelope-from <netdev+bounces-271919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:11:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16E330ECE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C19B73068D80
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D1134AAF7;
	Thu, 26 Mar 2026 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ikQZrabZ"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010051.outbound.protection.outlook.com [52.101.229.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F233342C;
	Thu, 26 Mar 2026 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512463; cv=fail; b=I+7svFCDA1HXOVfrdEwHjnA8Zj2eo+J0nIz2UgWjpg7PpMiaQWkg6tSburdAsvAR5qaL2wMB3cdde8LK+ztY8YQbeTxj6njxMCiDNmgDFSDk/Yhdftasci9Ecq7CCMMmkTO1b/+nmh03iIiiqmpPOWkMSTKf0N3kDFw0d25tq1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512463; c=relaxed/simple;
	bh=cvqnp3SAdU+6li9uD3Y8m1l2/ghSG8ZKB/pr5v0iCRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mtZIDKNQZfelQRGDAsC9jsyFiUXCO2eO2GWSnpAfDQE9vIYEk3JLsX5V+Y8H/h7SsUmDrmIjAjNwXJQvEWb2wmsKoBhgqho0vB48OqUiaxy6UZNoK2es6ZV85FzhDRjuY0UxmOws4WPvWNdido0kh8ump8JdK1efgOollFhR5vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ikQZrabZ; arc=fail smtp.client-ip=52.101.229.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgtqTtWy3fIRKYCFuQselsZnImoFRA7VWvPczPElG39nf9eeOZ+kTUh6AAIOKapAJ4eKYnUV2l2JguQz2lCTtheW3Xya+cOrvxxp1dvJIwnraPriYjn9iOY9aS2mF9JzpcOCnCbhdmUNA/Tjpg5xtTwPflldoBEx0fb0h+RTyuM2u56/1ffuTMLgitYF9vMBKFWBiXlg/dw8I4lDTidCfqgD4aVKNTJodvYBf266S7cKyzBuloQvOwnOIRMscPCyXjjVoigfS8oxaL6kv9dWFKTxRas6Xg5uyQu3o9dGYr6asErc7IpEb4m/OcO5/3uCpZK7xEtA1uHVPDYy+VGckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvqnp3SAdU+6li9uD3Y8m1l2/ghSG8ZKB/pr5v0iCRI=;
 b=lF4mHC6hBCAHBZiQJLVv1AbjBANQhs0S97ndEn40L6qtQlVzaXSw1ZrVY+Il03nU+YWAYJo6gewZKRzte13GC/bHQa5NlnOh/H7Y263XPz2VmPpKzaqowfMkU2svYUnUvCHEME/SD7yRSweEBQy0LkXB0Q7kI2bwl7JMA9C6zKPdyV+5IgQe1GCyHnQfTrmo/+gQgKIEef/rYH2Wy2fjIyNGnjLV+7gBC7qmcnE2l82ED2OKwdKlh3OG4QRLPx4dOly+Zt/wHnaUy0Wjwirzh0VUrK28hhgK4ljXkvL3Ugd4XmVT3VLRikKtAgWqPQoTI0iEPL5QtM3CkKDj3b7L/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvqnp3SAdU+6li9uD3Y8m1l2/ghSG8ZKB/pr5v0iCRI=;
 b=ikQZrabZZSKmxYuUre1WlwTp6v6zLTiyNeb8IJufSOhnJcjX/QR+bqGTze+Rs766bweoRkryY84ZkpA6ekv7xdGyuXpHypP2IRR/QBkrrTrCcmAuyQ+LMNjy81Pm+UnKGcifM0y/4Dvy+EiJ41N+LpMC28o3sj1rJsyDh015tAY=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by TY4P301MB1954.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:389::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:07:37 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:07:33 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Michal Piekos
	<michal.piekos@mmpsystems.pl>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Thread-Topic: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Thread-Index: AQHcuPUBPuJr+fwUwEyxnX/LFVXhRLXAeDEAgAADDtA=
Date: Thu, 26 Mar 2026 08:07:33 +0000
Message-ID:
 <TY7P301MB198407F8C0280B991334304ED356A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
 <abb1c779-b306-42f8-b2b1-aa56bfcebe1b@bootlin.com>
In-Reply-To: <abb1c779-b306-42f8-b2b1-aa56bfcebe1b@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|TY4P301MB1954:EE_
x-ms-office365-filtering-correlation-id: b488d52f-727e-4483-b000-08de8b0ebc19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 OLzN65O/RxOA0DZqYZLoAJyyphFoqvP0GtD587zZKKqrs+rlYa/QPC0QC5C4S7n+/rz425OSmeqb9ZboAYS5onGwxDpOTJZK9zLhUeF3yn+3LGjvrIg112ivG3PUVG8jmCuR1iBGgscWzhbv29MCL0fp6B80yZj4jOYDN0XoaXWG5HGcst4/afldg0tzQGY/SZqPoek8YbmFutJ8cIM+l9mLiZ0C/+xd48YMa6DBxgrT5RpgxRzXH3wtewGZQI2U73lNpSShHQGtOghmzLGp+EohfTnRNwPfXBapCUBRRx2jjfarW+wo0dNJURXPTZsZqz/L/momBYK7fuvEdh8Ux5fFtOoV0yzu9e+f65xDYO8cVeCX4hneFkItTgLjflqE7t/Y4oBESxwv149ZIgxOL/78q9eAon1k1a1xH/1teqofIVmkq9EOPy4ev58oZnuVJPRugm5kJNGRS3hWW5U1MezVKekNpfBvkpMHw03zqzaSa7ytAjUi4P+Jw+AAgmfEQrDwVbZwn1BjzsLQrJQj/cMQ/2wfXfC1nGnQ5Lfzf5B9uNDFiWUhCekinQA8Cm0So4EddR2agYrgdvSchafRML+K7btJ9HrFgP+QmFlRJ0lFZZreeMlsa7AuHvfig6Aq3G3HsQhHRg55nCMT6+SJ1ypj7ZDBt+w9YLCPvaLTesj1bR2QUGF09fgJ5cLtTNa2/Sg8CzpXGSxntTORMrx2dLCex6lSILTbd9uwv7sPbzEj0P8jR0id6Qq712e3aptvbnIyvhJlDh1QmX+RR/HUEzGXWOvI6T9KQZcq77hIx0k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1diM1RVTWlGTEtRcVNYZlpKQTVnSlpMOGZtWjhiNXZrT3NQR2xrdFJsSnB6?=
 =?utf-8?B?MkgrelFmQVlheTBuREdiZnVpVklsQzdtWWordWwxZFJHa3FxQ1NvNWJTY2Vk?=
 =?utf-8?B?eXVhQWxMZlJHQ3dEZnQ5M01kcXhOcW92ME1qR0tlUUpkTWkyVk9Pd0J6VThm?=
 =?utf-8?B?V2JCZUxTeUVIRDRtL3pmdWtaVklFWnpjYzVSY01MR0RScXExcW5Mby9pbVVW?=
 =?utf-8?B?NWhDbXFER3B5ampyVFlJbzZnb0UvN3FuajhHbUp2VzJBUlF0UE5VYnlBbDJD?=
 =?utf-8?B?cGJXQWF0MGdpSUQ3Q0FVMXRwUFNzRVJPdkJ0RVJLdzZxZmtidC90VHpDajM2?=
 =?utf-8?B?aHo5MlM0d0s0R1ArdndWK2NnR0xja2l0RytwQk5sdmlTSktQRzAyZmdLN0hI?=
 =?utf-8?B?ck1HNUh6czVodXNTdm1hZ3RZa2hXZmZqaTVkNXBHL1J3VU9VY1F1OVAwLzh0?=
 =?utf-8?B?VEFYaUlwL3ZjWVhER1E5cCtlbGJrZ0x2L09XakJDMGYxcnA2QitRbUpMZHI4?=
 =?utf-8?B?dEtYMGs2bnRpKzkwMnBROUNST2tXYkVYaCs5N3BxWmlwU2RySXg2RTJaUytz?=
 =?utf-8?B?MnFOT1AxSEhsclpqS1l1VEhsQ1RqemlRd2JWandiYVZCTCtHcDV3V3JpV0xu?=
 =?utf-8?B?VnVOczduTXoxL0lMbFNHYjQ0UVVkTHhFSzVIYmRHTGlkZisrQ2tyUTdNRStL?=
 =?utf-8?B?YnNlVDFPR0JwYk04N3JoSGhqYmRqakVHUnF5QWNYVEJIVXpnbnYrdncvc0JS?=
 =?utf-8?B?anl0ejE1eDN3aDUyZThDRFFzSk92ZlZRUHZreHRod05HSjVROGJ0RXI1Vldj?=
 =?utf-8?B?MTlydFhLWUorUkFqMDk2ZVpCb0lNSWpraXhPSzBGSlpNVWR2M2VMeklJN1Zj?=
 =?utf-8?B?VXNqRFNKczZtYWp6SzcvNUdFazNWalZDYS9NZlk0b29XcWlxSlVuVUdCV1Q3?=
 =?utf-8?B?OWM4eGgxNlJCWkNJcHpXeHNRNmlPcjhqQ0ZBWE5FcnFnSTRTMU00a09TWUtU?=
 =?utf-8?B?QjNGN29YZElaK1lvY0pLWUNEcWNxUDZ5bkYxbkljeW5EWHFYRi9tc3BTcGhk?=
 =?utf-8?B?OGdRNitOVkl6OC8rbnM2Nlg2Z0N0MS9ja0xYdlBGN3orNGNISnptMXZyT3FG?=
 =?utf-8?B?OU03Q0ZwNlZiY2pmTnpvb1hvbmlaZ0lVWW5Sa0F0L3A0Sld0aXlJY3dCUnd4?=
 =?utf-8?B?RUhQT3VscXFQb3VjREU4OWxFRUFUeXhEdENTb1FXOHZVNktKODFtcHE5RlZH?=
 =?utf-8?B?emhrR2V2dm55dld6cHgyWTc2S0xMdm1nNEFhV0ZUaU9TeGFLUGpQYmpBUSti?=
 =?utf-8?B?OUZRYnUzVHpCcjE5ZWJRbS9CRE00UkpTM3FDUnV2UndkRVNtMVJmUWZ2WGRM?=
 =?utf-8?B?ZCtrQ1U4S1hzTzVPdjhWOHNLM0pmUlIzbklFMDlFcDdBWWpTVGFOV3d1NlYr?=
 =?utf-8?B?RWxQTGxIK0xKNWVjcjhsQU9xMjBxR28vZ3ZOb2QzTWhqK01MQVdzdGx3WTYx?=
 =?utf-8?B?UDZOaUZRWHk2ZGtyUHJSNEhGT2hkenI5RkE5N0o0aXY4LzV1WEw1SzEvL0Vr?=
 =?utf-8?B?VzNUbkd4bDZXcUV0SEdKREZPRCsyTGNjNHlpUm1oRlpBblBBVHlwY3pMREFO?=
 =?utf-8?B?cGpWM0MrdUJSbG16UlhrNEowN3YwQ2xRa2tITDRkaWMza2VEbzg5L2tOR094?=
 =?utf-8?B?WGdYLzFmdzBhZGNZYVhHZzhLanVWaXB3VTBocWNrNTJZYnVBS2lSSVlDNkRt?=
 =?utf-8?B?L3BkOGlGMStzUlVUQUJpQWRWa1ZzN0tFSmR2NSszYldyRVVLNm1ZMEpwK2hC?=
 =?utf-8?B?bmpESitQQndzTFg5WnBkbk02MlB4YXdmNHBVY3pKVW5SM21CcDJJUVduS3hM?=
 =?utf-8?B?QndNZkxmRVdMbC9xMzVDLzRNeDJpMjR5d1VPeExsdzA1SXFlOWpqQng5aXpj?=
 =?utf-8?B?N2hHNlNqMmwvMzZzT0Q0SzRjVUZYbTAvQTFHd1hFZkIxUTJCeVJ3bkRMZk15?=
 =?utf-8?B?WGxhblR4eUJsU3FzNEhSVkZaUUkyL25QU29USnQ0M3ZnUnRnanBlRWFMVGpE?=
 =?utf-8?B?RVVlSkpzM0tnbWNjTDllR1M2YmcyUHpJaTJhbmNnVEJscTlwb3BxdFRkb2Y5?=
 =?utf-8?B?d29KYkl1Um1pZFVrdTFma1gwUWNwdjNUME9ndS9NTDlNNERqWTlUR2QvaENp?=
 =?utf-8?B?aFRUbm1yZVpQZEFIeVBVbXhVVDkwSitTK0pKZzZrb2h3eER4dVBTdjB2eEhL?=
 =?utf-8?B?S2RrL3VReE1LWEphOTdCdDlUM3hnNjlkMTBUWUlvRTNNVCs1c0dleVFsSU9m?=
 =?utf-8?B?eVZ3K3BkM0s3dW84ZXREMGhZZXBFZW52L2N3a01TT0pMbCt0cUs4blRVZ1FP?=
 =?utf-8?Q?0P6vJ9Xricfaxjmo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b488d52f-727e-4483-b000-08de8b0ebc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 08:07:33.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYAxdY51zlIlorSfpU87CPkO7bjXUWcKcLPj+496MOGsnRbnpQtiNkg70B/vJAUJdZzTZ7BJUc65pU/BzlJkqSC0PiAgOvt2kb6/zLtX0CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P301MB1954
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271919-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,mmpsystems.pl,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mmpsystems.pl:email,renesas.com:dkim]
X-Rspamd-Queue-Id: 0C16E330ECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGksDQoNCj4gDQo+IEhpLA0KPiANCj4gT24gMjEvMDMvMjAyNiAwNjozOCwgTWljaGFsIFBpZWtv
cyB3cm90ZToNCj4gPiBzdG1tYWNfdmxhbl9yZXN0b3JlKCkgdW5jb25kaXRpb25hbGx5IGNhbGxz
IHN0bW1hY192bGFuX3VwZGF0ZSgpIHdoZW4NCj4gPiBORVRJRl9GX1ZMQU5fRkVBVFVSRVMgaXMg
c2V0LiBPbiBwbGF0Zm9ybXMgd2hlcmUgcHJpdi0+aHctPnZsYW4gKG9yDQo+ID4gLT51cGRhdGVf
dmxhbl9oYXNoKSBpcyBub3QgcHJvdmlkZWQsIHN0bW1hY191cGRhdGVfdmxhbl9oYXNoKCkgcmV0
dXJucw0KPiA+IC1FSU5WQUwgdmlhIHN0bW1hY19kb192b2lkX2NhbGxiYWNrKCksIHJlc3VsdGlu
ZyBpbiBhIHNwdXJpb3VzDQo+ID4gIkZhaWxlZCB0byByZXN0b3JlIFZMQU5zIiBlcnJvciBldmVu
IHdoZW4gbm8gVkxBTiBmaWx0ZXJpbmcgaXMgaW4gdXNlLg0KPiA+DQo+ID4gQ2hlY2sgcHJlc2Vu
Y2Ugb2YgVkxBTiBIVyBGSUxURVIgZmxhZ3MgYmVmb3JlIHN0bW1hY192bGFuX3VwZGF0ZSgpLg0K
PiA+DQo+ID4gVGVzdGVkIG9uIE9yYW5nZSBQaSBaZXJvIDMuDQo+ID4NCj4gPiBGaXhlczogYmQ3
YWQ1MTI1M2E3ICgibmV0OiBzdG1tYWM6IEZpeCBWTEFOIEhXIHN0YXRlIHJlc3RvcmUiKQ0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBQaWVrb3MgPG1pY2hhbC5waWVrb3NAbW1wc3lzdGVtcy5w
bD4NCj4gPiAtLS0NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIGEgbm9pc3kgIkZhaWxlZCB0byByZXN0
b3JlIFZMQU5zIiBtZXNzYWdlIG9uIHBsYXRmb3Jtcw0KPiA+IHdoZXJlIHN0bW1hYyBWTEFOIGhh
c2ggb3BzIGFyZSBub3QgaW1wbGVtZW50ZWQuDQo+ID4gc3RtbWFjX3ZsYW5fcmVzdG9yZSgpIGNh
bGxzIHN0bW1hY192bGFuX3VwZGF0ZSgpIHdpdGhvdXQgY2hlY2tpbmcgZm9yDQo+ID4gVkxBTiBo
YXNoIG9wcyBwcmVzZW5jZSB3aGljaCByZXN1bHRzIGluIC1FSU5WQUwuDQo+IA0KPiBJJ3ZlIGJl
ZW4gc2VlaW5nIHRoZSBzYW1lIG1lc3NhZ2Ugb24gc29jZnBnYS4gTXkgdHdvIGNlbnRzIG9uIHRo
YXQgaXMNCj4gdGhhdCB0aGlzIGVycm9yIG1lc3NhZ2VzIGRvZXNuJ3QgYnJpbmcgYW55dGhpbmcg
dG8gdGhlIHRhYmxlIGFueXdheXMuDQo+IA0KPiBBcyBSdXNzZWxsIGV4cGxhaW5zLCBpdCdzIGVp
dGhlciB0cmlnZ2VyZWQgd2hlbiB0aGUgdmxhbiBvcCBpc24ndA0KPiBpbXBsZW1lbnRlZCAodGhl
IHN0bW1hYyBjYWxsYmFjayBtYWNybyBzdHVmZiB0dXJucyB0aGF0IGludG8gYSAtRUlOVkFMKSwN
Cj4gb3Igd2hlbiBzb21lIGNhcGFiaWxpdGllcyBhcmVudCBwcmVzZW50LiBBbGwgaW4gYWxsLCBp
dCdzIGFsd2F5cyBzdHVmZg0KPiB0aGF0IHVzZXJzIGNhbid0IHJlYWxseSBkbyBhbnl0aGluZyBh
Ym91dCwgYXMgaXQncyBIVyBsaW1pdGF0aW9ucywgSQ0KPiB0aGluayB3ZSBjYW4gc2ltcGx5IGRp
c2NhcmQgdGhpcyBtZXNzYWdlLg0KPiANCj4gQWxzbywgbm90aGluZyBhY3R1YWxseSBjaGVja3Mg
d2hhdCBzdG1tYWNfdmxhbl9yZXN0b3JlKCkgcmV0dXJucywgc28gd2UNCj4gbWlnaHQgYXMgd2Vs
bCByZXR1cm4gdm9pZCA/DQo+IA0KDQpJIHRoaW5rIHRoaXMgaXMgdGhlIGJlc3Qgc29sdXRpb24g
dW50aWwgdGhlIFZMQU4gY2FwYWJpbGl0aWVzIGhhbmRsaW5nIGlzDQpjbGVhbmVkIHVwLg0KDQpN
aWNoYWwsIHBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd2lsbCBiZSBoYW5kbGluZyB0aGlzIGlu
IHYzIG9yIEkgc2hvdWxkDQpzZW5kIGEgZml4IGZvciBpdC4NCg0KVGhhbmtzLA0KT3ZpZGl1DQoN
Cj4gTWF4aW1lDQo+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBSZXBsYWNl
IGNoZWNrIGZvciBoYXNoIG9wcyB3aXRoIGNoZWNrIGZvciBIVyBGSUxURVIgZmxhZ3MNCj4gPiAt
IExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjAzMTQtdmxhbi1yZXN0
b3JlLWVycm9yLXYxLQ0KPiAxLTRmYzZjM2UyMTE1ZkBtbXBzeXN0ZW1zLnBsDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMgfCAz
ICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1t
YWMvc3RtbWFjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFj
L3N0bW1hY19tYWluLmMNCj4gPiBpbmRleCA2ODI3Yzk5YmRlOGMuLmNmYzBjZTljZWM5YyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNf
bWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3Rt
bWFjX21haW4uYw0KPiA+IEBAIC02ODYzLDcgKzY4NjMsOCBAQCBzdGF0aWMgaW50IHN0bW1hY192
bGFuX3Jlc3RvcmUoc3RydWN0IHN0bW1hY19wcml2DQo+ICpwcml2KQ0KPiA+ICB7DQo+ID4gIAlp
bnQgcmV0Ow0KPiA+DQo+ID4gLQlpZiAoIShwcml2LT5kZXYtPmZlYXR1cmVzICYgTkVUSUZfRl9W
TEFOX0ZFQVRVUkVTKSkNCj4gPiArCWlmICghKHByaXYtPmRldi0+ZmVhdHVyZXMgJg0KPiA+ICsJ
ICAgICAgKE5FVElGX0ZfSFdfVkxBTl9DVEFHX0ZJTFRFUiB8IE5FVElGX0ZfSFdfVkxBTl9TVEFH
X0ZJTFRFUikpKQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+DQo+ID4gIAlpZiAocHJpdi0+aHctPm51
bV92bGFuKQ0KPiA+DQo+ID4gLS0tDQo+ID4gYmFzZS1jb21taXQ6IDQyYmRkYWIwNTYzZmU2Nzg4
MmIyNzIyNjIwYTY2ZGQ5OGM4ZGJmMzMNCj4gPiBjaGFuZ2UtaWQ6IDIwMjYwMzE0LXZsYW4tcmVz
dG9yZS1lcnJvci1mOGIzYTFjN2Y1MGENCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCg0K

