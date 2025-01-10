Return-Path: <netdev+bounces-157145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5C2A09026
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996D2168726
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9920C037;
	Fri, 10 Jan 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Tq41IVie"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0A20ADE9
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736511634; cv=fail; b=tNec7oFaxTv2lV93R296VTDFKCCjzdlx9csrRI+YmXAsQsSDcmPlg7dq5L2exBjh/KkDyGB6NPwiWgnGBepABLLbOJWDDYJRtJoTDGnTN2kJPlYJUjt+aBb3VLx3K8Ntv+yw0vOk5sl+Z7+8V45dXIcuKEWhmGOj+YG1VbSPRjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736511634; c=relaxed/simple;
	bh=IOsBxlRlwkvRDJad/XH9miSmhgcvofIxG6Rb1gYNGCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kpsSLsNE6K9BiqOfgU+D1hlx2rKMkecthJqPS5dE6UIHw/KNUjvvx7MatgoZWOoh69jyFxM4q3ih2BYq1GnAW1AGu91bKoFsOS9Aw9dvuUkc3dfYqlaMbzd/zfDM7Ewb5s0XFaA4Tl0TmWzZjJJCQ7DXcq+oYdFA2bZUuW84Z9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Tq41IVie; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxenLcwE7tRTA4ExMBZIA+nPVhcprl1NUvQo3ZR8Z9hA8kIO5PD1NXewIWNMr3yg1NXs/KFd2y10Rl6sDjEpSPbVWP4qofFYfjXXUr1Erkdlu2rVq5eDp9EffLrwN2tc7d2FLzWrueDUtoT/1yGcS5FKbCvy4fObXmbZtgiG877wtb07eXPj5bYZC+rwAMZhsUJx5oXtrZJaXpDEQyHm7IxkGLaiKBmEIA2efglCbNh/y6/+8beLrd/F9jhKNmSU4CQcoXpGXvbAk8J80EPRwuFfjolBD5baU43+cn4rrYHq6BixjvrysxBPGvAf8+T+ygrwXRZBXfoGHgYa1PQjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOsBxlRlwkvRDJad/XH9miSmhgcvofIxG6Rb1gYNGCI=;
 b=ZGugZauRJcuvzIyz1X6Bu0WSn7Dl/q5RT5G5ecJUTi6W2r79HPZGHQAjnA79qxC8dk90RVVXvRuwvDcpSwti3RJYqJBBReLwLKKHQHo86YMWUT66M3wmIcNYOyn5bjiMiZ2sIiRlNLcKNelre5cafAjjGcfUysVBkFa9czDkgjgsRbKx6WHkbr5XvjCvRu1v4QXKSmiSl738la6pkyba1pH9TFGvVL4pHp9k50VsyykMQ6JyTHHJMwMv6bNTTuhOihmXi+7iuZaMuptK9wAu7UeVp8ZacuGBcCS5Irid3SgHy2m7KGIraWJSr7ZDtfU37FY0CWsqs3rWygls5f//Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOsBxlRlwkvRDJad/XH9miSmhgcvofIxG6Rb1gYNGCI=;
 b=Tq41IVieDoNiayUa9efGsXPK0m+laoVS5KmJZxS98YIuCMxZFYJCRyNDiCRPkRFuHXVyUEoatEhGvzWV9J69qcB5miovtX+6/VnHC9yZxZFbVDOjD6MwNeOVlolvLWovGoaufMX4WFE+LJY1Ep8w7WtlHkLBNrzjaHWAfIxd2Gr8XQC1wXOfcSLtVCRUy7Pjsuj0oFzutXcqPLIevCXmv2d71x7ECoSOkmH4E/CGsHiYQw1/Qc4UWiBcE3koev8Da4mfTpyinQc5yWF8yjTOP1ejB4PQxTh1t6p/tspigrntUe08xeNEBYqjU21Z/eEUjy9BlItKqRv9Lx4kcwpSxw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM8PR10MB4036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 12:20:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%4]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 12:20:29 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "c-vankar@ti.com"
	<c-vankar@ti.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"jpanis@baylibre.com" <jpanis@baylibre.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rogerq@kernel.org" <rogerq@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW
 only if !DSA
Thread-Topic: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware
 CPSW only if !DSA
Thread-Index: AQHbY1LYc2/Ywrl+eE+iq6LL4sIQEbMP4rwAgAAB0ICAAAPaAIAAAPYAgAAEDwA=
Date: Fri, 10 Jan 2025 12:20:29 +0000
Message-ID: <e4712b67d084bfb830f236392f3cb76d6ffc9701.camel@siemens.com>
References: <20250110112725.415094-1-alexander.sverdlin@siemens.com>
	 <fgt5mqpmibxjbfd3ae46hxk3m2sowpbxs3ffurwxiqairvlj4d@7ns2gdwh3v7h>
	 <5864db3fdb5fea960b76a87d11527becf355650b.camel@siemens.com>
	 <tjc6uc74j3add7bzh7of32i5topeenzv64y3hudne2lioqwqzb@qlhi4gdfn6ww>
	 <92f332a16eb5bb011e47290ba60ebc4a8dbb3dc3.camel@siemens.com>
In-Reply-To: <92f332a16eb5bb011e47290ba60ebc4a8dbb3dc3.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM8PR10MB4036:EE_
x-ms-office365-filtering-correlation-id: 86bbec79-6ac6-482f-0d2e-08dd31712c0c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2U1amlWY01xNDkvbS9WdmhQRW4vZDhidCtiOVFRREtKOUM3RzJTQWJxZWk2?=
 =?utf-8?B?YWxqSldjSUFNK3FMZEw3ZUtscGVYaDNPbWZNSXZwbW91QUFXZzZvN3VoWnBS?=
 =?utf-8?B?aFU3MEVMQmZXKzBuLzVtOWNYVlRpQlBhdnF0SnVXczhKK3lUZkhiQm1yWkpH?=
 =?utf-8?B?NXcrZFdWcUdCV2RRUUlLMDZ2SU5qQ1diSUhRcWZnVlM0QU5iN2FWeStJZ05Q?=
 =?utf-8?B?a0E3Q1VKQ3d6YVpBTStpaE5KUytKVnlVV3UrdEZaNUhjUkFEbFcrMktWMUVS?=
 =?utf-8?B?aVBhdnlUK0hINnlRQVJJdGp1NTNCMVlxVFFiZWtXdXFJWUZzNW5zOG82UE4v?=
 =?utf-8?B?c0V4VUR4OVNwNmdYclR4VmpYamFaSTZQdjF3bWlCV3VMUTB3T05lR2IxaG5C?=
 =?utf-8?B?ak00eVZWemxTd0gzVjN2d21SV1p2QU5NMHZoOHltOFpnQXJMNWRVSDI1ejQz?=
 =?utf-8?B?cXpLUzVXR1ZZUVFteXR1QUE0enZ5cHd3NFo4ZFNFRGc3OFhnUGZNK3RPVGxo?=
 =?utf-8?B?YXlHaSt4VXIzeEN4YTd4eEZRVVB3U3N5eHI2Y2trYnhEOEFuSzE5NEYvZkY4?=
 =?utf-8?B?bmIybVdvckdwdDY1K1Z0REhraXBOVDhzaEpHVVZSMzgvNDlDTEpMSENPOHkv?=
 =?utf-8?B?QVVXYkNlaDd3ZGZra3lvb1hLNTllY0hRelBnSElMaFhZWkZaSlZVc1NZaXor?=
 =?utf-8?B?UUpvQzJpaks3WWNoV2NhL3V2czJPZlI0NE5rMkd5RnNLSFBTTGRSMUxhOUhP?=
 =?utf-8?B?dXB0MUxQbWozNVdJU0s2UHNWR0FvcGNudGpvVHMyNDNPcWRvNlJNaktLTU85?=
 =?utf-8?B?anhVemlrWHl2cjdnY1hXZ3ZoMHZneUk2ck1Rd2tRbnI5QmFHenBuZEo3dmNZ?=
 =?utf-8?B?KzMwZVV5aTUwbzBTSlBzV2lxRjk4ZzExVFdsM08xUzhZZ2lsTnB2Yld0YXFa?=
 =?utf-8?B?NndOalIvNG10cS95c3N4MDlNQmxlMTZBd0srb3ZlMTJYZDczS0FQdE43VENS?=
 =?utf-8?B?Wk5RSzlyOW9BV2srYU02YVRyWFNNZklYNmlGSlNPeGR4bFpHeHFQdUduSDEr?=
 =?utf-8?B?REgwL1V4NHlNejdkWDJLbWY5S2MyaUFqRUpHWEFvRFltVkFFckMyYlZlZTFR?=
 =?utf-8?B?STNwdUJ3VGExSi9qT0pWNEpGTnpqSmFUQzNhbWdtS0t6N29DOHpaOVdpcm5H?=
 =?utf-8?B?ZHp1TDVQNmxvdm82eEJDckVVb3FhQ0VVT3lvdDZZczIrRGFmNDZKN2JBU01p?=
 =?utf-8?B?YzJsQjRmdHZtVmtFWkFlZmN5VG1PRlQ0M0RibFJaOGpUOW5pbk9sdFpMSlhp?=
 =?utf-8?B?QjdWQkxoR2Q0RVFkMmhLeVpLU1AzV3dueXdaTWRvaG0rejAwUjFXZ0RXbnE0?=
 =?utf-8?B?Tm4wWkh0UUdRL3NnQWNjWjY3YkUrVmkybmFvVWh3dkc0T01CVDFWbkZuUnlv?=
 =?utf-8?B?TlJRdlo0NE1mc25wQU5lQUFjcjdCSlBKTTBjNm80OElqTlI3TjZxcFkwSW1V?=
 =?utf-8?B?NXY5TVY5QXFuVTBFZ3RFWHdVR1pUZHNBdENKeVBlbzM5cDFGTTF0aGFZRHd5?=
 =?utf-8?B?UHhXWDQ5OHZOb3QzSTE4RDdVVGdmOUV1SlllTDcvSStsdU5VOC9mODNHQVRa?=
 =?utf-8?B?RWs2OUNFV3FUd2xDd3M2R3RqOGdXcFc3REkzNGszdXZlcVRjblArY3NocTQx?=
 =?utf-8?B?ZTR6UVEzbmZIY1c0Q0V3ajY2V29rL2Q1UUtYVldzekNHVndadFlzWnJxbFls?=
 =?utf-8?B?V0ZZUmdSVi94Rk9tZXpzaEVQQ0h2c2tNVVR2V1FTZHo5amsvaXMyY0x1NWQ3?=
 =?utf-8?B?QU1LUzBmTW5id0tKb2hnby9RVFN6T1h6bkhud2pRQVptM2dnWE1JMUQ5V3g5?=
 =?utf-8?B?VVFIQVZ3L3V0Z3RUVk9NMHlmc004d0s1K0dGak93WFlCNVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW8vQ3lNcGhSbVZ2dXBHVm9IWjdjMUNRQzZUNnNYa3E5dGUvRnQxcTFRTHZR?=
 =?utf-8?B?eGZCTUJUMFhTeTBhVWxLZkNxK01OdENTRjNvWENKYkowb0hmaGczMVJSRG1l?=
 =?utf-8?B?STg1QnRVUXd2bHpmaHp0NE9xNHBQeUdRVFhrMWpYYm44Q3V5bXZoZzNkMlVy?=
 =?utf-8?B?ZzRVVG9OcFZ4cXNvcFdjOEtPakE2SFkwNi9VQk9TZ0FLaGZXVHpUYWFXMys5?=
 =?utf-8?B?N29wdjhYVFo0TUNGVGNJd2FJN1RrU0FkaHpETUxwUkN5U0hiT0VUT1JZQmJE?=
 =?utf-8?B?Q3VoRTFCVTc4SWFldE9XT2lRcDFGWTU4NTdMN1E2WE0rUTdjYlVxL2pBdVpZ?=
 =?utf-8?B?WnljeStBMTJjRGt6RktOK05mS0VqUkJyV3ZKQzNkaVNuRGVWd0I3Qm9HZ3lI?=
 =?utf-8?B?UnA1OGNqaUJMUDVxUzlxQ0JBKzNna2hFNUJMSkJFYWp0elB0UHdiM29VbHkv?=
 =?utf-8?B?RTVIc3VEczM0M1U4czdNVkJyRENSWnJFQzE4VnhlM1I0SlgrbFRlSnR4bGN0?=
 =?utf-8?B?eU1INk1zc09zNWVWM0hNYjdmamZkTTAvaE1tZXYxWWc0WWVPUFFOaWE2a0po?=
 =?utf-8?B?bXRSKzRjbjU2U0szZmtSemJXb05HZXFrZWk3VnV2dy9wT3kzSldBOE1QYmhB?=
 =?utf-8?B?OE5hTVZpRmxKU1pOVEUvc29aT01UK2FpRFg4bytQaWZFQS9odlJyQmdWSzZy?=
 =?utf-8?B?TnNwa3JXVWFpbFpmancrUjZQdFNXaGdLbFZHRFZQVkJHV2F1L1lKM2JtcFk3?=
 =?utf-8?B?ZzlSOTJpSEp0RTVRTmRCUC92TDB2MjA4ZjBCUUFCcW90citCTUMwRWNGN05P?=
 =?utf-8?B?WWdSWWQ2d2ExUDV3TVpPOHBabWFodlY5SkUyZFVST1FVdGRlcDhtMnBjSUR2?=
 =?utf-8?B?dnpYUnVrdllJa2tvL2JvYUJ6bG5UQXBoeEl2K3oyU0RMNi9XajJRbXZPZ2Ft?=
 =?utf-8?B?VTJldDBSOWVpM2k3eDQ0NXpjeG9vVm9WMUltM2lTNmZyMnpsQ083dlhJUnVY?=
 =?utf-8?B?MVlSczMrNHhLT2Jqd3crUms0YXVjMUJFVmJqYzN6VjhhMFNYRGRpZ1k2NXI2?=
 =?utf-8?B?bkh6N1A5a3V5MTJHVnRSbVBvSjdVOW5QRlE1Qks0V1JFenNZMXBNUWJmREh4?=
 =?utf-8?B?T1JqdUlJeVM3NHF1YmNVWmFMRi96QUZGR3F3SEFzTW1uSVlieTR3cTBybEI1?=
 =?utf-8?B?YVI2SENGRFpFUFlxR2Eyc2cxQ0QwRXNWOGdlaTJMVndLUVJ5T1NXN2VNTWdQ?=
 =?utf-8?B?Q0xRWlB1ZnNUUkFPR3A5U0FSRnYxR3hsYytQZTZ6ZjZ3Snd6NXAvMm1UcEVu?=
 =?utf-8?B?d0o3bElRWVltMWZGUFViR0J1UVMzY1VoMDBIa213QmozTTJrTW1ONHFDdE5R?=
 =?utf-8?B?NFhtM1lwUzR3TXc5VHVMMjZDWDM3UGtGb0J0ei81aWozWjY2Y1cvWDVkMWhx?=
 =?utf-8?B?empOeXBUdjRoTDlyZC85cVlBdGRkZERaL09PSFhFb3V0cXdUaGdsM1BIK2VM?=
 =?utf-8?B?c2FYQk5nb3hoRndPcG5yZUhFdCtoZWFWVW5VaytNbVBXSEx5TzBEaC9vNitn?=
 =?utf-8?B?UER0aUxWSUZtQ3Y5QTJQZ1J4dG9NYlBqbm14NyszcmJtYmR2anNJNGtyZDJl?=
 =?utf-8?B?K0pjVUdab2ZsSVFiWjREbTg2bk5zQ25kSSs3eTVRN0UzR2thNDA2amdrM2pG?=
 =?utf-8?B?VURvWEkrNE9XRXN2Q2VtN3k0cTBVbUZXc2QwT2hMaGxIUFZ1bURwZ1FRcUdN?=
 =?utf-8?B?OWtEUUxQU3krblRKNmYrbUlBMEpyVEUreDNaVGZMMFZzVFpEQTFzWksyalVG?=
 =?utf-8?B?L0hEUGE1L2xhRzhlMnh0anVWVEFVZFRTczVPeHh2d1E4Z3lXSGwwVWxYT2Ny?=
 =?utf-8?B?bHBKeDJadGl2VHBpWVJFQk1oRkI3OW9OUW9VZHFpZnZJT09OWHMzVkd0azc3?=
 =?utf-8?B?Wjl0bS9XeStLaG1ES1B4VUw5WUZRcHBRcWl5YTFEWmN1MHIzZzloa0lnYXpk?=
 =?utf-8?B?amI1WEFXS2ZjSUtJa3FxNW44ZWc1Qnc2dmp6blVadlpWRGx0ZGZCMVU4UjFF?=
 =?utf-8?B?VWNUZ2cva1BQRzNCOUhzeTJuSWpRWm9aN2c2M3hYckh3RG4vc3RYdGVvdWZ0?=
 =?utf-8?B?S050c1RnMFNtbFdYc2REMU5ydmFhUXB6L1g2dnNKazQxZkU4ZkJ5aWQzaUNv?=
 =?utf-8?Q?iN6P7csPKVLets2G23sxSTA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74DCE82F859955499111ABD8F8E31828@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bbec79-6ac6-482f-0d2e-08dd31712c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 12:20:29.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5eOC1OgUGH2vNypCJ/XVedHvULqC6y1Mmaj4xneRhhPspx/5LY5NFhPsjeNiUIc7cHkjMSMpTLYEySWzK6IBVOYt2PrRMqEvrobtesEkzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4036

T24gRnJpLCAyMDI1LTAxLTEwIGF0IDEzOjA1ICswMTAwLCBBbGV4YW5kZXIgU3ZlcmRsaW4gd3Jv
dGU6DQo+IE9uIEZyaSwgMjAyNS0wMS0xMCBhdCAxNzozMiArMDUzMCwgcy12YWRhcGFsbGlAdGku
Y29twqB3cm90ZToNCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
dGkvYW02NS1jcHN3LW51c3MuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1u
dXNzLmMNCj4gPiA+ID4gPiBpbmRleCA1NDY1YmY4NzI3MzQuLjU4Yzg0MGZiN2U3ZSAxMDA2NDQN
Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5j
DQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3Mu
Yw0KPiA+ID4gPiA+IEBAIC0zMiw2ICszMiw3IEBADQo+ID4gPiA+ID4gwqAgI2luY2x1ZGUgPGxp
bnV4L2RtYS90aS1jcHBpNS5oPg0KPiA+ID4gPiA+IMKgICNpbmNsdWRlIDxsaW51eC9kbWEvazMt
dWRtYS1nbHVlLmg+DQo+ID4gPiA+ID4gwqAgI2luY2x1ZGUgPG5ldC9wYWdlX3Bvb2wvaGVscGVy
cy5oPg0KPiA+ID4gPiA+ICsjaW5jbHVkZSA8bmV0L2RzYS5oPg0KPiA+ID4gPiA+IMKgICNpbmNs
dWRlIDxuZXQvc3dpdGNoZGV2Lmg+DQo+ID4gPiA+ID4gwqAgDQo+ID4gPiA+ID4gwqAgI2luY2x1
ZGUgImNwc3dfYWxlLmgiDQo+ID4gPiA+ID4gQEAgLTcyNCwxMyArNzI1LDIyIEBAIHN0YXRpYyBp
bnQgYW02NV9jcHN3X251c3NfY29tbW9uX29wZW4oc3RydWN0IGFtNjVfY3Bzd19jb21tb24gKmNv
bW1vbikNCj4gPiA+ID4gPiDCoMKgCXUzMiB2YWwsIHBvcnRfbWFzazsNCj4gPiA+ID4gPiDCoMKg
CXN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ID4gPiA+IMKgIA0KPiA+ID4gPiA+ICsJLyogQ29udHJv
bCByZWdpc3RlciAqLw0KPiA+ID4gPiA+ICsJdmFsID0gQU02NV9DUFNXX0NUTF9QMF9FTkFCTEUg
fCBBTTY1X0NQU1dfQ1RMX1AwX1RYX0NSQ19SRU1PVkUgfA0KPiA+ID4gPiA+ICsJwqDCoMKgwqDC
oCBBTTY1X0NQU1dfQ1RMX1ZMQU5fQVdBUkUgfCBBTTY1X0NQU1dfQ1RMX1AwX1JYX1BBRDsNCj4g
PiA+ID4gPiArCS8qIFZMQU4gYXdhcmUgQ1BTVyBtb2RlIGlzIGluY29tcGF0aWJsZSB3aXRoIHNv
bWUgRFNBIHRhZ2dpbmcgc2NoZW1lcy4NCj4gPiA+ID4gPiArCSAqIFRoZXJlZm9yZSBkaXNhYmxl
IFZMQU5fQVdBUkUgbW9kZSBpZiBhbnkgb2YgdGhlIHBvcnRzIGlzIGEgRFNBIFBvcnQuDQo+ID4g
PiA+ID4gKwkgKi8NCj4gPiA+ID4gPiArCWZvciAocG9ydF9pZHggPSAwOyBwb3J0X2lkeCA8IGNv
bW1vbi0+cG9ydF9udW07IHBvcnRfaWR4KyspDQo+ID4gPiA+ID4gKwkJaWYgKG5ldGRldl91c2Vz
X2RzYShjb21tb24tPnBvcnRzW3BvcnRfaWR4XS5uZGV2KSkgew0KPiA+ID4gPiA+ICsJCQl2YWwg
Jj0gfkFNNjVfQ1BTV19DVExfVkxBTl9BV0FSRTsNCj4gPiA+ID4gPiArCQkJYnJlYWs7DQo+ID4g
PiA+ID4gKwkJfQ0KPiA+ID4gPiA+ICsJd3JpdGVsKHZhbCwgY29tbW9uLT5jcHN3X2Jhc2UgKyBB
TTY1X0NQU1dfUkVHX0NUTCk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+IMKgwqAJaWYgKGNvbW1v
bi0+dXNhZ2VfY291bnQpDQo+ID4gPiA+ID4gwqDCoAkJcmV0dXJuIDA7DQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGUgY2hhbmdlcyBhYm92ZSBzaG91bGQgYmUgcHJlc2VudCBIRVJFLCBpLmUuIGJlbG93
IHRoZQ0KPiA+ID4gPiAiY29tbW9uLT51c2FnZV9jb3VudCIgY2hlY2ssIGFzIHdhcyB0aGUgY2Fz
ZSBlYXJsaWVyLg0KPiA+ID4gDQo+ID4gPiBJdCBoYXMgYmVlbiBtb3ZlZCBkZWxpYmVyYXRlbHks
IGNvbnNpZGVyIGZpcnN0IHBvcnQgaXMgYmVpbmcgYnJvdWdodCB1cA0KPiA+ID4gYW5kIG9ubHkg
dGhlbiB0aGUgc2Vjb25kIHBvcnQgaXMgYmVpbmcgYnJvdWdodCB1cCAoYXMgcGFydCBvZg0KPiA+
ID4gZHNhX2NvbmR1aXRfc2V0dXAoKSwgd2hpY2ggc2V0cyBkZXYtPmRzYV9wdHIgcmlnaHQgYmVm
b3JlIG9wZW5pbmcgdGhlDQo+ID4gPiBwb3J0KS4gQXMgdGhpcyBpc24ndCBSTVcgb3BlcmF0aW9u
IGFuZCBhY3R1YWxseSBoYXBwZW5zIHVuZGVyIFJUTkwgbG9jaywNCj4gPiA+IG1vdmluZyBpbiBm
cm9udCBvZiAiaWYiIGxvb2tzIHNhZmUgdG8gbWUuLi4gV2hhdCBkbyB5b3UgdGhpbms/DQo+ID4g
DQo+ID4gSSB1bmRlcnN0YW5kIHRoZSBpc3N1ZSBub3cuIERvZXMgdGhlIGZvbGxvd2luZyB3b3Jr
Pw0KPiA+IA0KPiA+IDEuIGFtNjVfY3Bzd19udXNzX2NvbW1vbl9vcGVuKCkgY2FuIGJlIGxlZnQg
YXMtaXMgaS5lLiBubyBjaGFuZ2VzIHRvIGJlDQo+ID4gbWFkZS4NCj4gPiAyLiBJbnRlcmZhY2Vz
IGJlaW5nIGJyb3VnaHQgdXAgd2lsbCBpbnZva2UgYW02NV9jcHN3X251c3NfbmRvX3NsYXZlX29w
ZW4oKQ0KPiA+IMKgwqAgd2hpY2ggdGhlbiBpbnZva2VzIGFtNjVfY3Bzd19udXNzX2NvbW1vbl9v
cGVuKCkuDQo+ID4gMy4gV2l0aGluIGFtNjVfY3Bzd19udXNzX25kb19zbGF2ZV9vcGVuKCksIGlt
bWVkaWF0ZWx5IGFmdGVyIHRoZSBjYWxsIHRvDQo+ID4gwqDCoCBhbTY1X2Nwc3dfbnVzc19jb21t
b25fb3BlbigpIHJldHVybnMsIGNsZWFyIEFNNjVfQ1BTV19DVExfVkxBTl9BV0FSRQ0KPiA+IMKg
wqAgYml0IHdpdGhpbiBBTTY1X0NQU1dfUkVHX0NUTCByZWdpc3RlciBpZiB0aGUgaW50ZXJmYWNl
IGlzIERTQS4NCj4gDQo+IFRoaXMgd291bGQgZmFpbCBpZiB0aGUgcG9ydCBpbnZvbHZlZCBpbnRv
IERTQSBzdG9yeSB3b3VsZCBiZSBvcGVuZWQgZmlyc3QNCj4gYW5kIHRoZSBvbmUgbm90IGludm9s
dmVkIGludG8gRFNBIGFmdGVyd2FyZHMsIHdvdWxkbid0IGl0Pw0KDQpPb3BzLCBteSBiYWQsIGl0
IHdvdWxkIHdvcmsgaW4gcHJpbmNpcGxlLg0KTGV0IG1lIHJld29yay4uLg0KDQo+ID4gVGhlIHBh
dGNoIHRoZW4gZWZmZWN0aXZlbHkgaXMgdGhlIERTQS5oIGluY2x1ZGUgcGx1cyB0aGUgZm9sbG93
aW5nIGRpZmY6DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+ID4gaW5kZXggNTQ2
NWJmODcyNzM0Li43ODE5YTU2NzRmOWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L3RpL2FtNjUtY3Bzdy1udXNzLmMNCj4gPiBAQCAtMTAxNCw2ICsxMDE0LDE1IEBAIHN0YXRpYyBp
bnQgYW02NV9jcHN3X251c3NfbmRvX3NsYXZlX29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYp
DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgY29tbW9uLT51c2FnZV9jb3VudCsrOw0KPiA+IA0K
PiA+ICvCoMKgwqDCoMKgwqAgLyogVkxBTiBhd2FyZSBDUFNXIG1vZGUgaXMgaW5jb21wYXRpYmxl
IHdpdGggc29tZSBEU0EgdGFnZ2luZyBzY2hlbWVzLg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFRo
ZXJlZm9yZSBkaXNhYmxlIFZMQU5fQVdBUkUgbW9kZSBpZiBhbnkgb2YgdGhlIHBvcnRzIGlzIGEg
RFNBIFBvcnQuDQo+ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAo
bmV0ZGV2X3VzZXNfZHNhKHBvcnQtPm5kZXYpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZWcgPSByZWFkbChjb21tb24tPmNwc3dfYmFzZSArIEFNNjVfQ1BTV19SRUdfQ1RM
KTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgJj0gfkFNNjVfQ1BTV19D
VExfVkxBTl9BV0FSRTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0ZWwo
cmVnLCBjb21tb24tPmNwc3dfYmFzZSArIEFNNjVfQ1BTV19SRUdfQ1RMKTsNCj4gPiArwqDCoMKg
wqDCoMKgIH0NCj4gPiArDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3
d3cuc2llbWVucy5jb20NCg==

