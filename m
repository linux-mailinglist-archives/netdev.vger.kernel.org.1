Return-Path: <netdev+bounces-129277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CE97EA05
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD62281A1A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D0195803;
	Mon, 23 Sep 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQRRuw3L"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9426AC3;
	Mon, 23 Sep 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088126; cv=fail; b=pGzCLUcGc79XjRtmrNPdVVm0PL75PhnYrCC5LMCOUdQl8et8Y/gC9fhOk+gRI6Jo2r1JjBpz7poJwY6BCse8Hx1A6M6oEWq2wKx/Xngr25d2fq+pto65ljd8WnCTsnm9hJWlrnO/oztb2QraGbejM6Hc4zCPfblPcwxa5T/6Lv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088126; c=relaxed/simple;
	bh=0f64HM8+p/InUZe9Uo8nSaHqIvgL5Z0eE7CDOlUNnQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbXr2gcuQc+WTa88xflSxBOtQQ9rdBzdlzhCwKkTDYrB4ZClHd8OozK2Ic6KetZDzUxbF0qeyuKmbu6pO8MUK/qGBGs5+vvUOQYI+Ki8odpx9L0woLZwp8K7DB0jLT+iQbw3MJkciSP+W5OQAAcmf+Q02J+WJnT56i+jbxZe0uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQRRuw3L; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXOBi6zxfLalrtf6r6y1xVk9tYqp5PgGF4GIA8XpEmv2AOoH2F6YnskLbu0TwLCipg816NomLjCBa7jK3jI+UG1WaPjh7ZsU7QNIk1U+SFqSCQIlsSxZKeU02B2E9O65/PjVLI4YxwOHnVbPSNwuum5FMI/2Z9pveXv2ldAZHguJEsa/0XcnZj56kUcSZM36vLHa4lQ38HqbmwQ5FySzLAImTwq6au0JZmXIKOmFQ9WlpCJHLcynj51f8z5WG8yzDUumgDS/+bNGLd4WjCL1KqS4/iAXCRwfPE65sdnr4WTFeBOxIskLwKp98ZLitxkWJ69dFfxJTPS9p3fqOuHK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f64HM8+p/InUZe9Uo8nSaHqIvgL5Z0eE7CDOlUNnQw=;
 b=A2nDofk3Vjvm+qj3wMigKUnQ8485zfuBa2Q9tctDZh9hgYAlg6KEA7vcp/dQON3pk3dGtM7/pgIXlbTr6ksh1zetxtsfcXT5hnWFCAEd4WwyY1Mb80n5TBO0I8f7Ox3GNwZblBBqLUcnb/+X5LADv8iyhgVDBu8M/fsg2dn0ONpsh8NQZWt64YoMefBhDPlMWe5WjMCchMxPQSCOFnya6t05rQZNBZJgjHkzpAzRwfBZtVah0O9as2LJGuHN1yqA6C5HujsAaF4VzQ0patla94tlvV4XldY8sFV7irYpKNNjqO0JIwBj/C7KJgMqQrDjRes1rS4REouA3UsQjtqI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f64HM8+p/InUZe9Uo8nSaHqIvgL5Z0eE7CDOlUNnQw=;
 b=fQRRuw3Lk82nylDT9zOF2dT0tj7sENrE+Fk1BDxDj1fm7GHptj68L0ie9fGaLVzrjZDqMZcZjXNJpvZ1CveibVDbto5ydB2Qq0rgTMwREvzc5mq7lq8LqozCxsPzVWSCVX0vC77aTml1CbUBQsKvtszpHS9QcoeXYBN7q5yaWg0uoCovR74d/99TuHoFSUmtJHNyny4kTZMrs1UfzTX2/13AXsXvJowPFx3fYzLXGaAaCLL0aQ8GfTIFL/XP4zsUqUBelwddyaq3AsUw2UC18KT4oRntd84i3oox9Jqwk7ElsZooiKsYdbJWGqHgOwepxe9YcpStmuQtM83kGP/hKw==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 23 Sep
 2024 10:42:00 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%7]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 10:42:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: =?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Frank Li <Frank.Li@freescale.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/2] net: fec: Restart PPS after link state change
Thread-Topic: [PATCH net 1/2] net: fec: Restart PPS after link state change
Thread-Index: AQHbDZprbOxurIZHyU+KAlHBX3N3VbJlLWPg
Date: Mon, 23 Sep 2024 10:41:59 +0000
Message-ID:
 <AM9PR04MB8505DB0E7FEEF2783DD6FB9E886F2@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20240923092347.2867309-1-csokas.bence@prolan.hu>
In-Reply-To: <20240923092347.2867309-1-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|PAXPR04MB9154:EE_
x-ms-office365-filtering-correlation-id: 16cc044e-7ef3-4b2c-e4ab-08dcdbbc5a92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWRqcXR6dUFVU0FEN1lSVzRraTVReC9jM2NxOGdXa1JmTGZHeis0emt0TXYx?=
 =?utf-8?B?VFVUa25iMjBNbERVdER1K1BRQzFlSGFTVDhBdE5tZ2J6OU5DaGJMSTlmdkxV?=
 =?utf-8?B?a1RWdHk1VTY2c2lTTXVkTG1FWlJMdksvanpFR3RBM0tMT3AyNGZuejhIQmJl?=
 =?utf-8?B?R3B0T3VQcDFpanRLMHp0T3dTbXBvR1BWY3ZYU0ZGckk1WC91My80VklTT21v?=
 =?utf-8?B?cUpzWHg5T1VLN1pyenpMTFlGMmsrSnZtWXEwZGpvVHBPaFJGdUcwbjRGQk5q?=
 =?utf-8?B?a0NSeWRIRUZtODBXdnJZVFYyTDdPL1RvYlVIYXpOUThnbDBwdDJlV3IrYTJr?=
 =?utf-8?B?cjdPc3VwUnZBaGNFRURuM2kvbjVPWUZvUytzeFJ6SXU4QmhrWVVnZDdtamQv?=
 =?utf-8?B?SzB0dkFBcHN1RFV6Z3lGRnZIUEc3UVR1eXRCS0pGQm4vZzJSNTJVa3M3NEVx?=
 =?utf-8?B?SzNSWGVVQnBkZ00yYi80MjA0bGZUUFFQakZkdm5MN2grSEIxVzlVT0VyQWpv?=
 =?utf-8?B?VXhEWW0rMVp2dmpaZ2J5T2x6bDlNSHJBZ0xQNmQ2aURHOG5vbFRXaG53Q1hH?=
 =?utf-8?B?RG11OCtEVk1UdGJIQVJheWpCQllYWGN4S0tCWnpTb1draFZuS2UxYkFucEI1?=
 =?utf-8?B?UXFTeEx0aVl4WTBuL0pyQ0t5RjdIUWVXbDllZnRUSW9iYVRrbnJ1Q3d4bCtR?=
 =?utf-8?B?bnJxaEFTRExodGE3UTlobU5pcDliZCs5TXBLQ0hMdnhUUUF1dDRPbUxrTXdh?=
 =?utf-8?B?Z1RJVUdYR1A4QU9aT1JmRldXTW1mdXljL25WeU1QK0ZZMm96WDlianJKTVNL?=
 =?utf-8?B?VnlxLzg3MThJelhZU2pXOGZ3M0FqYmpPVGdueUxTWjlRZCtUc1RtR1hNeC9a?=
 =?utf-8?B?blpFbkY1YnNLS2Ywd0JmbFBWUVRuR0lWcVg3eTYrVlVlc0JHZHBjUnNKdm1L?=
 =?utf-8?B?WlRxUUdtR01jM2Urb1JyZlJORzFzZlN0dTMrTXlrWTFHdHlnWEs0TVlPR0h3?=
 =?utf-8?B?OEx6T3hzMEQ2ZmczYTJkbmJveG55NkhOam5IV05jZ1hzbWJUK0h0UFdBRXdo?=
 =?utf-8?B?YUlZRjRIZ0drK0pkcnpzZElWSVJGZ3MwbTdERG81VHdlSnY2L0tCb0plUnJo?=
 =?utf-8?B?dDRraFI2VnlHNWJhMnpmNWwrNEsvVjZ5eEE5K0FoaE5sSVFYWkJra2Rta2Fa?=
 =?utf-8?B?Wi9PS3o2VDJ4Zm5EOENIMUJLczZRbjBvdTBMaEd6Uk90RXdHNHdKZzVpaXk0?=
 =?utf-8?B?S0NTQWJmNU1peTdmZkFjRnlGclZVeEMvSVNoYXNYaVV5TlFhYXNTeFo0LzdE?=
 =?utf-8?B?ZHNPYStkRStMVDlFNWp2L3Q0TklCMExxUVdnSVhyV2tIbXpGS28vNVZ3Kzdk?=
 =?utf-8?B?Q3BhQ2V3bWsvR2ZUbndtbzNRcVRKdnRIa2lMQm4xR1hRcWhqSkQrcGQ0TnJq?=
 =?utf-8?B?em1UYU5DVU1uaEx2ZWliSURaaXA3ZlNyOU1Day8rb2NyVS9ZZGZZdStkUE9X?=
 =?utf-8?B?U3dmTDJDWHpBdklPOU51NnRGUWNTNzQ5UTZWemNUUm1lMExBR0I4U1p5T3RU?=
 =?utf-8?B?bXZ2Y00zN2ZuZjEwYXNnWDJaU1BXT1pnQW1teHpKOEo5VklhYjVYTHpZRXpi?=
 =?utf-8?B?WW1rWktMaUFZbG9WTmVkQ2tLV25OWnNxY0RMcTRhQ29wMHhKeW9JSXhOQ2dI?=
 =?utf-8?B?azJNbG5aZi9EdGtaME9JRzhLOG9vSzZBNUIyNG5SQkZWckNxcFhwNVE5NU8r?=
 =?utf-8?B?bzEwcktQWUxpYWhqV2kvRENWT2c3VGVEaE1sRjZIOUE1cnUwTUtNUzZPaDZk?=
 =?utf-8?B?d2NueU5SMmgrdVFKemVLd1Bjd3RRdGI0ZlRyRGl3MWo4UzdiMFFLT1c3N0xW?=
 =?utf-8?B?TExqMjkxYnhaVTdWRUI1eWJENGd1VzBuVHJkNlgzaENkOWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWJyZjM5MmhJc3VGUFZPRkJGd2JhOEVHVkFxK0dlazNadkJjcndncm1kdmdU?=
 =?utf-8?B?dGV3LzZTRWsyL1hZWHQ2TTErRG5lMTAzcFZuSkJ0RWNZRjh2UFhyZ2tYM01T?=
 =?utf-8?B?M3h4bGRpbjlOWktqcmRCaWZiV1pqZVFmTTJmbitkUmJXTXo4OXBiMVlUZlB1?=
 =?utf-8?B?Z3hocXNsRUEyTDJoaWFCVy9oTGkyMU5KbHl2cjJLaEtuOTlINUlHSFgvUUI5?=
 =?utf-8?B?YzJFRFlOYkFDSTZCOHZCdFp5c21QdWJTR2F3ZE5EK09UVElGclpQMmZ2WDRU?=
 =?utf-8?B?SFN5VTlPSysvNUZQMXRDVlBBYk1TTWdDYkgzVXErK2hzYnVudXFHMFRWUnB0?=
 =?utf-8?B?U2szWkxWSTM5Tkc1aDdMbmJ4SFBwdVQ1cFNwWDZNZDA2Tnd3VXY3K1JxSHRy?=
 =?utf-8?B?NnVsUUNkZ0N5Qm1mbExnZlk2TldhUnpTWEZzYnl0TmlrcmNyWXRCUDRRUXkv?=
 =?utf-8?B?L1FXMkZvV2k0WGVjaEl6QnloeU93RTd3OXZBOFlMRUtPL3Vwc08rTWloWHdl?=
 =?utf-8?B?U3RobXZQOGp6Y3Fsb1RDVGNnNTJzVytuZ0pTQlIxS2NqbWR5WGJuQ0ZFK0gz?=
 =?utf-8?B?cmhIVUpmME9NQnl3YXVtaDFjeVhibVF1bGNuMmwzSDFaOHZWeFhSYnNxaDQx?=
 =?utf-8?B?YlFrRXVDUDlTZkdPbUQzVFFEV2VzdG1RbWZwT000V0toZ2JYT1dTUVVjQkdq?=
 =?utf-8?B?Y2ZJOXl5RXBLMnp1U21DbnBtaGQrdG5JK1NXUkFMQTc2THM2TDNhVGxHeG5u?=
 =?utf-8?B?U0d5R0trbkdZbXVOUEliZ0FWWktSNkJrWU5xd2NZYkZmRVo4UndsNWRiMEJ0?=
 =?utf-8?B?TjBQclJVcGtrK2ErRU91UmxIbmdKTmZPcVFOZE1mNGNvVENSR0RDT1p4MklC?=
 =?utf-8?B?MThjS01kamhIN3VLYWkrcU9Nd1hCN1MwTXV6TWFqTmhMOXJBNHRERkdvNWsw?=
 =?utf-8?B?K2JJNm1TMC9xb1dqcURUZDc1Zk5GZkhYalFUVGl5QWtUZHJ1eFNaYUJPZHZx?=
 =?utf-8?B?N20wV3k0emhiOVIzc3M2SSt1T29UeExoN05vRnBQU1A1dkpnN2N0OG54cjBN?=
 =?utf-8?B?OXRubGh2cURkMzNlMjh0d1VoQXVBdFQycVBzYnlYOHB4RHVuNzMzYnlURnNm?=
 =?utf-8?B?SUZ6SHZzV2lUd1dHREhqSmViRjQ3NWVkV09FcFZ5bmdBWVhoV1JoNXZuQlFC?=
 =?utf-8?B?U3VRLytjaGxRY3lqdnpMamMvT1VPWGhsZDlKTy8vRitRUWd4bDM3QWcwTW9Q?=
 =?utf-8?B?c3ZHNUJ0czl1Z3NJT0dVQkh6M0psb0ZnY3RDZnc1TEFxN1ZPYkdhUzdOVFl1?=
 =?utf-8?B?SWorRTNxQWFFRnNka21KcVQvWGtZLzFQb3FVNE8yR1g1OGJxVjg4NFpBNFhv?=
 =?utf-8?B?RTVURWN0NFcvOSs2RGl3QytaYllBSnkvWUZpbVhnZnEwTGc1aGZFa1VveFp2?=
 =?utf-8?B?UERhcWtrcjNSOEkrL21tb3hobEhMY29HUkZldEdhazJLbDlMOEVIcnZ5cHZK?=
 =?utf-8?B?QWYwSWgwK1M1cUhNRGFIa2ZLWFIxTld5ZHlFb2VjQ3dKK0x1aUl1OGp2THdP?=
 =?utf-8?B?UEJTMzJ3d3dmdEhzL2NHV0VzYjZtOTFYb3BxNjdjSGYxV3YwUnZVaEx6NHd1?=
 =?utf-8?B?M25GL0J0aEtNTndheUt2U0txNDRlZDJDMEFSZ0VTNHpWTm9LU1pKRFJqekEz?=
 =?utf-8?B?dSs5OFNPb1Z6RWNFQno1L1grcUgvMFFabnl2aFlLTXRzL3RudnhJdnRnR254?=
 =?utf-8?B?M1JmWVhKY3dMS0poeEJYSkQ2dVFDYit6OHJDZEwzcjI0d0RKUVpEeWxMOWx0?=
 =?utf-8?B?aEdlNWlGTzQ4R29BWndqMkp2OXkyWXM2NEl3Zkp0cXlqZXJOUnA5bmRIeGE1?=
 =?utf-8?B?ejMrOUZiOFNWUDAxNnBuN2kzVUFseXRsQ2tZc25xNW8raDhkVzA2VE02amVr?=
 =?utf-8?B?bFkrbkhzMERiL3FqeUprMFdtR2VyYkN3RzMzOUNsMzJIUW5mUUtacUhTdmlJ?=
 =?utf-8?B?aU51Z3ZIK0RtWUp4V0N2N3RkUjIwYll0T2hFTXAwL3ZlKzVHVTNBVXlVeDlV?=
 =?utf-8?B?eWloUnRBRDUvNndzSWYrb2pLTUUxUTExZ0M0dEMzbVRiOWVKcXFUWStCRlEz?=
 =?utf-8?Q?swbs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cc044e-7ef3-4b2c-e4ab-08dcdbbc5a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 10:41:59.9502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQG2KAWfnZeGFLoeN8q0lYKXJ68SguYCGDUVSeXh4TiMlKAah4PmIJEa/y6nrdkPAEKue2ZF8uTtf4yng5uGEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDc8Oza8OhcywgQmVuY2UgPGNz
b2thcy5iZW5jZUBwcm9sYW4uaHU+DQo+IFNlbnQ6IDIwMjTlubQ55pyIMjPml6UgMTc6MjQNCj4g
VG86IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEZyYW5rIExpDQo+IDxG
cmFuay5MaUBmcmVlc2NhbGUuY29tPjsgaW14QGxpc3RzLmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQ3PDs2vD
oXMsIEJlbmNlIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1PjsgV2VpIEZhbmcgPHdlaS5mYW5nQG54
cC5jb20+Ow0KPiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2Fu
Zw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29n
bGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5p
IDxwYWJlbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQNCj4gQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5A
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDEvMl0gbmV0OiBmZWM6IFJlc3RhcnQg
UFBTIGFmdGVyIGxpbmsgc3RhdGUgY2hhbmdlDQo+IA0KPiBPbiBsaW5rIHN0YXRlIGNoYW5nZSwg
dGhlIGNvbnRyb2xsZXIgZ2V0cyByZXNldCwNCj4gY2F1c2luZyBQUFMgdG8gZHJvcCBvdXQuIFJl
LWVuYWJsZSBQUFMgaWYgaXQgd2FzDQo+IGVuYWJsZWQgYmVmb3JlIHRoZSBjb250cm9sbGVyIHJl
c2V0Lg0KPiANCj4gRml4ZXM6IDY2MDViNzMwYzA2MSAoIkZFQzogQWRkIHRpbWUgc3RhbXBpbmcg
Y29kZSBhbmQgYSBQVFAgaGFyZHdhcmUNCj4gY2xvY2siKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDc8Oz
a8OhcywgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oICAgICAgfCAgMSArDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYyB8ICA3ICsrKysrKy0NCj4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMgIHwgMTIgKysrKysrKysrKysrDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gaW5kZXggYTE5Y2IyYTc4NmZkLi5hZmEw
YmZiOTc0ZTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWMuaA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gQEAg
LTY5NSw2ICs2OTUsNyBAQCBzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSB7DQo+ICB9Ow0KPiANCj4g
IHZvaWQgZmVjX3B0cF9pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIGludCBpcnFf
aWR4KTsNCj4gK3ZvaWQgZmVjX3B0cF9yZXN0b3JlX3N0YXRlKHN0cnVjdCBmZWNfZW5ldF9wcml2
YXRlICpmZXApOw0KPiAgdm9pZCBmZWNfcHRwX3N0b3Aoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldik7DQo+ICB2b2lkIGZlY19wdHBfc3RhcnRfY3ljbGVjb3VudGVyKHN0cnVjdCBuZXRfZGV2
aWNlICpuZGV2KTsNCj4gIGludCBmZWNfcHRwX3NldChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwg
c3RydWN0IGtlcm5lbF9od3RzdGFtcF9jb25maWcNCj4gKmNvbmZpZywNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXggYWNiYjYyN2Q1MWJmLi42
YzZkYmRhMjZmMDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNf
bWFpbi5jDQo+IEBAIC0xMjQ0LDggKzEyNDQsMTAgQEAgZmVjX3Jlc3RhcnQoc3RydWN0IG5ldF9k
ZXZpY2UgKm5kZXYpDQo+ICAJd3JpdGVsKGVjbnRsLCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0K
PiAgCWZlY19lbmV0X2FjdGl2ZV9yeHJpbmcobmRldik7DQo+IA0KPiAtCWlmIChmZXAtPmJ1ZmRl
c2NfZXgpDQo+ICsJaWYgKGZlcC0+YnVmZGVzY19leCkgew0KPiAgCQlmZWNfcHRwX3N0YXJ0X2N5
Y2xlY291bnRlcihuZGV2KTsNCj4gKwkJZmVjX3B0cF9yZXN0b3JlX3N0YXRlKGZlcCk7DQo+ICsJ
fQ0KPiANCj4gIAkvKiBFbmFibGUgaW50ZXJydXB0cyB3ZSB3aXNoIHRvIHNlcnZpY2UgKi8NCj4g
IAlpZiAoZmVwLT5saW5rKQ0KPiBAQCAtMTM2Niw2ICsxMzY4LDkgQEAgZmVjX3N0b3Aoc3RydWN0
IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAJCXZhbCA9IHJlYWRsKGZlcC0+aHdwICsgRkVDX0VDTlRS
TCk7DQo+ICAJCXZhbCB8PSBGRUNfRUNSX0VOMTU4ODsNCj4gIAkJd3JpdGVsKHZhbCwgZmVwLT5o
d3AgKyBGRUNfRUNOVFJMKTsNCj4gKw0KPiArCQlmZWNfcHRwX3N0YXJ0X2N5Y2xlY291bnRlcihu
ZGV2KTsNCj4gKwkJZmVjX3B0cF9yZXN0b3JlX3N0YXRlKGZlcCk7DQo+ICAJfQ0KPiAgfQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMN
Cj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+IGluZGV4IDRj
ZmZkYTM2M2ExNC4uNTRkYzNkMDUwM2IyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mZWNfcHRwLmMNCj4gQEAgLTc2NCw2ICs3NjQsMTggQEAgdm9pZCBmZWNfcHRwX2lu
aXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgaW50DQo+IGlycV9pZHgpDQo+ICAJc2No
ZWR1bGVfZGVsYXllZF93b3JrKCZmZXAtPnRpbWVfa2VlcCwgSFopOw0KPiAgfQ0KPiANCj4gKy8q
IFJlc3RvcmUgUFRQIGZ1bmN0aW9uYWxpdHkgYWZ0ZXIgYSByZXNldCAqLw0KPiArdm9pZCBmZWNf
cHRwX3Jlc3RvcmVfc3RhdGUoc3RydWN0IGZlY19lbmV0X3ByaXZhdGUgKmZlcCkNCj4gK3sNCj4g
KwkvKiBSZXN0YXJ0IFBQUyBpZiBuZWVkZWQgKi8NCj4gKwlpZiAoZmVwLT5wcHNfZW5hYmxlKSB7
DQo+ICsJCS8qIFJlc2V0IHR1cm5lZCBpdCBvZmYsIHNvIGFkanVzdCBvdXIgc3RhdHVzIGZsYWcg
Ki8NCj4gKwkJZmVwLT5wcHNfZW5hYmxlID0gMDsNCg0KZmVwLT5wcHNfZW5hYmxlIGlzIHByb3Rl
Y3RlZCBieSBmZXAtPnRtcmVnX2xvY2ssIHNlZQ0KZmVjX3B0cF9lbmFibGVfcHBzKCksIEknbSBh
ZnJhaWQgZG9pbmcgdGhpcyB3aWxsIGxlYWQgdG8gcG90ZW50aWFsIGxvY2sNCmV2YXNpb24gaXNz
dWUuIFNvIGl0IGlzIGJldHRlciB0byBhZGQgbG9jayBwcm90ZWN0aW9uIHRvIGF2b2lkIHdhcm5p
bmcNCmZyb20gdGhlIENvdmVyaXR5IHRvb2wuDQoNCj4gKwkJLyogUmUtZW5hYmxlIFBQUyAqLw0K
PiArCQlmZWNfcHRwX2VuYWJsZV9wcHMoZmVwLCAxKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHZv
aWQgZmVjX3B0cF9zdG9wKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJ
c3RydWN0IG5ldF9kZXZpY2UgKm5kZXYgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4g
LS0NCj4gMi4zNC4xDQo+IA0KDQo=

