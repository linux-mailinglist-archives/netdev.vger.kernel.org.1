Return-Path: <netdev+bounces-153604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF29B9F8D1F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7071B7A14EF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D51953A2;
	Fri, 20 Dec 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Wilw49NQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EF137C37
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679062; cv=fail; b=jXE7QEZTD6wWd2z2r0YxiQpdKcLXPesS01EOlk6v7KMqv7V6pzm1SU/qgO7ec9OO59bILmuHrn8m79gmmOd0SHGJTLcUydpLfcr/QTp3i+n51ZKPffI5KLNkxZ0WTLsCnrTXYGRj4Z+m52Uy866QL5kbfI40DgX1ltJGPKyQKCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679062; c=relaxed/simple;
	bh=wsnIbwl8b/EXHuQFZeJrcO576ba2Bjwjky6dOLOSwOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwkF2jCV2zwT5UPgogPOrh2A/9D9eTH4EOHbuxtrk3323J5Y8ihneKhK5CghZZVK417D7lIXkNwcgc/4PJCNQFANxMsxNsGFXKM+AqkPQfI5n7jeHxSUxLeTQAapMLR8PiPMOz03K5sO/YwhXcoZBXSZyfv8VJU/Wrf0DQuJooc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Wilw49NQ; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p60NtIwni5STMmVeh4SYVoZCsAGSChQ+KeysHfBI0GpKDDqOVih7QcHrCLrH1C7hc60tzY6UAh31CfyfNfjt6tPXtAR1zQR/kdrRYERMRYnzFc9AU129nHCS3ZLGREAyI6gkAUx5ZrwHgZFxJcgjbdQ3AN58aWseRd1EJYo+2bo3DjWhQFSob+riix2YVwmuvQM8LstH5TdLImpNl52502rpoIbqg0uYgwybUMpN/aXy8OoM2dSH+jLaLeLY967Hsb5kO/eVn7o+B3ytknB0ikBb0MPSx70CQBq+EAuo1k6+A56C0zAU0Z77b5HbgarJG4t8KHUi+XPhi3XheYaXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsnIbwl8b/EXHuQFZeJrcO576ba2Bjwjky6dOLOSwOs=;
 b=jAZSjelFs1Lh5gMJka2jKQ1IvnbwoALiTUMJYhABM4R53BXXDYQ66gvWgEfI+JxpNwFlbtAcVSqwpbo1pfSTg5D66kN/oA0y+DANytqAUDXeQXU0HFH47jo4ZorYPrL+p7fcThxkpH0E/5j+7+ZHDnoS33PrPKAwVhXi839oZkZxrGL2oYKpihL13f6Js2A82mKHpyHf9vqovCIy5r3+lUSsGRo1QBGG38fcceZtHe1nEJFvqhFh1MMPkQ+OfWs5fzpShazcL1w/Cya1cXh92T4K/CiEvXduTuUxSfezZqf7C/tZyiXsSNPSnpwtQZHlrvsiQLkk+SBbpgfr4ecqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsnIbwl8b/EXHuQFZeJrcO576ba2Bjwjky6dOLOSwOs=;
 b=Wilw49NQXeuCErZi5nNyeFWxWHM7hGrFuEcw66WEamMyT/Ilh3RJBEs/U894eCmXeSF/FBwdPJ69hAOFW03KuOy0JUiSO2HTi7yhHHiD+vb62ZXhC8tDAdRbbQMjk6SupZht0RIIG3Ytu9ucXFBg3p8XNp44AOOh7kI01a20NhsrDPX0uDviGeVe8X213ul0JEBVXPrYYizHrGqWwSANsViPs1jKz2XGfsXhrEN6GhkCqcjfF4SCt8MrY5df8LmahJybEAd+9R4XbINPLORKcDDmBK5sjc7zOM1GDNYnChjT0Yk11POfq7ER94Klo3FdbSf7UBl9IsxWcAnz+13fCw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA2PR10MB8679.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.8; Fri, 20 Dec
 2024 07:17:37 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8293.000; Fri, 20 Dec 2024
 07:17:37 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs on
 user ports
Thread-Topic: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Thread-Index: AQHbUjzGyeufL+QEMUu8gO9xw6AtrLLt12AAgAAR2ACAAAzggIAAw+sA
Date: Fri, 20 Dec 2024 07:17:37 +0000
Message-ID: <b708216ed804755678f01f62b286928763a1f645.camel@siemens.com>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
	 <20241219174626.6ga354quln36v4de@skbuf>
	 <eb62f85a050e47c3d8d9114b33f94f97822df06b.camel@siemens.com>
	 <20241219193623.vanwiab3k7hz5tb5@skbuf>
In-Reply-To: <20241219193623.vanwiab3k7hz5tb5@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA2PR10MB8679:EE_
x-ms-office365-filtering-correlation-id: 7252076c-8c14-40cd-82bb-08dd20c661ce
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzdrK3NkUngzM2dVVDI4Tjd0a3lGNURPMThYRVMwN25vM3JQaFVoeXFPNmVW?=
 =?utf-8?B?T3lmaThTTW53cEh1OGh2RDFNMkNMUTJJajRZTkpQNitHS1JodjQ3c1pRWWtG?=
 =?utf-8?B?ZzYyT3ZZaWNaQ0tvQ3hzQlZnSE11U2crRVF5WnNLaHVHazBXbFJZalRPNmNH?=
 =?utf-8?B?N1V4T0x6VFpFMmVOaHc0SXIzM1NsZkxKaXVxcW9PQWtJaytsNk5ic21ZelhD?=
 =?utf-8?B?aVA5N2dDL1R2UDRmMk5YanYrRDVRbkRudmNnSU90ZVJ3enBta3NSbTVmb2RN?=
 =?utf-8?B?ai9vd1FoRkVpcTlxN3EySnpOenUwQ3JDUjJkRy8xa0RMeXRRTXBhMkEzZURk?=
 =?utf-8?B?ZitqaXJGUjV5bHNCUkgvWXVVOXJsWFNETW1yL1hUNzBHbUZIampIalFvYm1P?=
 =?utf-8?B?N3c5Rzk5c0ErWkFiQlY3SmZZRWNXWHp3aWRkSmVrR1QyR1BSZW1IY0lRaCtU?=
 =?utf-8?B?WlE5OE4xcXlqZW5pRmZaQUpwZ3VBc0U0czFJMjhxbjlpZEJMQmtDNTgrWjFW?=
 =?utf-8?B?TXdoQURQcDFtQzNDaTlUZU05Y1M4MjhNZUhxcUQ3ZURYR1dveHBQTFh4WjRM?=
 =?utf-8?B?VjhjU2k3NHBvR1FIblhQaE5kSkpCOHFlTWVtWHJ4WnZTVjJRVWt2VXlNMmFQ?=
 =?utf-8?B?dTVCR3hacDUrMit5RUJHVVJqOWVQT1BZeGsxMEhLalprNzBIbzZSMkVBVzZE?=
 =?utf-8?B?elFUTXZEblZ1d1AxMk5YeEJQWjRIUGRCRzFwdldJWWtKL2hQN2FyRklieXNE?=
 =?utf-8?B?eXhqd2tuMUZjTGJLL2FITUprSTJ6TnRvVXZoT1gwK0doYkVyd25pR25HbW5t?=
 =?utf-8?B?V2tobjQwZGRzR2gvUzhpODlRZ1JCY003ODM0R2QzcjhkZGZNcEhsSWs5OG9x?=
 =?utf-8?B?TVZXbEYwTTZLUHY4UndrSTdMQ3EvMkJMSDc3SE5iZ0pxcGIwODBIZVhOTnk1?=
 =?utf-8?B?UmFqQ2htL2VsS2YydTdoRnh2b0F3eHhTeHUwT3V4NVZTZWd0Rkd0SUsxbXdV?=
 =?utf-8?B?cVVrSnQ5V3J2RXVUbi9kUlpmSDF5TDFpcFY3R1REUE40Y0dVQ0pGd3VqaEta?=
 =?utf-8?B?Uy9QdXQyby9NV0JieUhZdEMvYmwxSTUvUXZOdDUxRUlpZ2loaDZvVWJsVHMr?=
 =?utf-8?B?emI4eHgvMjJxaUlrNUpWQjdQakRid1pRYlZyS0Z4WllPSUxlRk8ramlhTmFJ?=
 =?utf-8?B?WndXZUV1bkZEbWtjc2YxUlpKdlVKVWFBaldMT0M1a2VJLy91OWVZdHJkZVZt?=
 =?utf-8?B?STh0R0xPem1DL3RyN1ZKMm8yZzRHeGc1VzJaUFNINnhyMnNrMU1ReDIwQmFy?=
 =?utf-8?B?R0F6SHlLWjNleFFobjZlRExYQnEvcUdMUXordk9rNmw1QTNha09KZjE2aXg2?=
 =?utf-8?B?aStpN1dIMEdQcDVyU1JyTVNOQzZtMUlJOU1CNEZJV0E2RU1FMVZqUzNRdjdm?=
 =?utf-8?B?S090bTJ0T1l6SGRJZThWbk1qaVJUOVhnUDB6WW1MY0ROeVZmWnA1Kyt3YUxi?=
 =?utf-8?B?MTJHRUtPbVliN2xlWFAzQjhMVEVpclpEdmd1RDJjSzVmbzNaRVRMazFNcVUx?=
 =?utf-8?B?UFNHRkM3aVpkN1p0N0N2K2plVDBXUTNOd0haMHZRVGk5bzdRTjlKYWc4dm9k?=
 =?utf-8?B?TnA4NzYvQ1hkUGNhU1FFTjErNjE2ZzNRdFlPV2pRWDZNZGRhWnV4b0lmdE13?=
 =?utf-8?B?cFcyOWtPRFhBVlFxZEV2dmVCTXhDdlFVN3VlVWpsdnV6bUJ6NFZSQXZZUzFS?=
 =?utf-8?B?bzBFVWNjcDEwSEtZcGtRaUwrVWJQLzlXV0tkMDd6Sy9FbEVYV2FkdXdIcXJp?=
 =?utf-8?B?QzVvVGIvSXFaU3QrZGdRTHRFSjhSYkxrbzdvZEtYWjhLcnJVaFpqd2NEc1lu?=
 =?utf-8?B?aXcvcWNLNE8wemRrZzhPRy9GenJLYUVNT3pLWDk3VmhrWVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkhkUFR6eTdxVlhFNHdxNDg0T3BiT1czVnV2TFM3aTFtckdzdzZ4N2V3a3Rm?=
 =?utf-8?B?RkhtZUVjaytIVFRUdXVxby9IakVpbGMzM3hIUW5CQkVJeUw4WnR5enpabTk2?=
 =?utf-8?B?b0Rkcm83MlF4YnpvMkxYMDFFOWI3Zjd5NkhYSU01YS9PQVNpaTNFcm1FenJh?=
 =?utf-8?B?QjlEb0dyVWZmWnVKN2JjR1RYUHhRSWhnUVVjUzZjcGx3UzRsL2xLLzZCNmIy?=
 =?utf-8?B?ejBGOXlXdlA2U0w5d1hSWTZZMllKUENoakxSb09mQmlkcllGSU5URlk4MkRm?=
 =?utf-8?B?dlVmL1VFK1NQLzh1dWs4a0Nsc1c2WEpIdmQvSGJEYjNXQmZVeklBR2NDTHFB?=
 =?utf-8?B?aWExVWthTjRzSzR5Yi9ZaDNDUm1xWkhuOUdiVnc0bjhHWlRnMHhFcGFleVFy?=
 =?utf-8?B?YlBwUm9PT3FIN3JmOVhLaW5wWC9iZnlmeEF3WEk2ZW5FcFpwQS95NUhvbG5a?=
 =?utf-8?B?eUF0UVRacHA3NnhmMndqNDNzbThtenVySlAwdFdTSUJOalBxK3ZLQUNZU1dT?=
 =?utf-8?B?dDl0NUtEdDV5dlJYd2Z6M016SFp2MFJFSFBwcktOMng2WGtvOTdBTDBIcW9h?=
 =?utf-8?B?YTJQdnFuREkvcDVnNlNZN05PRUpzY0paVjZGQ3FxSk83K2ZXUWF4KzdYVnVX?=
 =?utf-8?B?WHIrbDk2QWk1Ym9NU0xsU3htUWhrOWxLeDlxbGlkWno1MlJVZHl5R3BWL2gr?=
 =?utf-8?B?RnZYOGEwbWRTSHZBQ1Q5d09MTlA0U2Rhc3k4T1AzVDd2eXU2VGk4ZUJIK29i?=
 =?utf-8?B?dFBNWmVWQmd6WEIyc0FsVmQ3eXZSOWJwaWQzQmtOd1BiK3VlQUFEbHZ2WlBj?=
 =?utf-8?B?L0lQekZIWWZtZ2xreWNENjV1NzRIdkU3cWpDZjRmMm9NOXFPRC8rdFlZc3Zn?=
 =?utf-8?B?WkhNNTVlUVM5U1diVHVNL3UzQmllRWhwcXNJdTExdjRSUnVsdnhBMm1jSzhq?=
 =?utf-8?B?dGFBaStrVzltUXhCVzlHNy9udytSaUNSRGR0T3Q4c2xOSlRrOVB0VWZqL1hD?=
 =?utf-8?B?WjVqSytVUExFL2UwczNOYmxZREVMQldTQzk3ZzB4VmtlejB6OVBaRFhuMVZl?=
 =?utf-8?B?WkxWQWF3bUFoMWZDdHRGbjNnWi9NWlN2TTlUWnVmZU4wVlZiL3ZGb2dIZU1i?=
 =?utf-8?B?dzcyT3NyNm1ISWV2MkhIWHhwUTBJNzkwb0RjZnJwR0hBQ3N1SzJMUE8xOHZa?=
 =?utf-8?B?Y3JQSXVnMEx6U2p2cEtManlkcHJGWHRkOElrbXFDUDlvNHVTQ2IrLzU3Yjhp?=
 =?utf-8?B?cktGeTNnMHpGQ2lScG14MDBneW0xWGtyUkc2TEZSb3JRYlI2RlNKc2pWSEEy?=
 =?utf-8?B?Tlh4TFZVaUx1cnh3bG1kdnk4cEtMSTlxSlBibUpuQ0ZqTFhlUDF5c2Q0YitF?=
 =?utf-8?B?d1RTUHZQQTVxcFVaL0pLL3pneUkydjBBNTkveURoaFlLTU4rQzJCM0p2L1F4?=
 =?utf-8?B?SDF6eHFSZTZNd3k5OTJkYkxXSEZFUk5rMWdDWGpBdW05YlJjMHhTQ0RmaWwv?=
 =?utf-8?B?TlplQVlxZlIrTmJ0a3NYcWIvNUltaFZTMXRKTlcxL1FUUnBxWklrWDRHZEh6?=
 =?utf-8?B?eHp1L0Z4d29pSWxFc1FUM2pOTGEzS1cvZGJScGxPTFhLSG9rN3FzR0RuVWdo?=
 =?utf-8?B?bEQwaTVTM3ZKcUZVY1ZIWDNWczI2QzRMRFNkUHhETkZnejA0cjZ4NlZWYmNF?=
 =?utf-8?B?azlDK3picVNQVC9ZSXo0RTUyUGZYV3RvQVl1RndINlhOa0wvWkVFVnFDUC9y?=
 =?utf-8?B?QU1HVkhTQzEzcHRndGhTUzN3cjNuS2xoRHhLbnVTR2VJaCtaMmdKb3Zad005?=
 =?utf-8?B?MUIwZENCYmpOdGpwTjlBTWdtZlhoQ2dMWmZncHNraU11dU5sNVhFc3Y3ODFO?=
 =?utf-8?B?ajVPdnlsWE44M2d5cHpRRlVxdnRUUk15UGRtRXNMcU9DcndsZGJlUUp6MjQz?=
 =?utf-8?B?cTF6Y0wzdFZBYkV1ZkF4RE43cXFCdlNuSUh0Y0ZnYVlJTk5rdG43OWN1SWZh?=
 =?utf-8?B?SSt4dzZkQ2tkc0hhTEh3eWNvWUNXSk42RTBxZFE5MjY0WU1scFJJNmtnK0xJ?=
 =?utf-8?B?VXU2YSttNGNoL0paN243WXFtLy9IQnAxaUx4dkd5SEwzaFh4c2dOYVcvQmI3?=
 =?utf-8?B?QzBEdGl0M2g1RzE4OXdJdm5yblhoNnlLU1pSQ2crbys3b3plaGlpM1VJTkx0?=
 =?utf-8?Q?VOQko4HEMbLj0OIHV0C9LT4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32150B48D0E31240AAF0E97B7FA13A91@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7252076c-8c14-40cd-82bb-08dd20c661ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 07:17:37.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvxG1VXPzRzoTg8nc3vPoXqHw2D/+k7AwlX09GzywnwXdtB5hHpzNMTeGj4Ye75CLn53GQCxY9/kAskULLp82/+FRxJVMuMYiV3594aNzNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8679

SGkgVmxhZGltaXIhDQoNCk9uIFRodSwgMjAyNC0xMi0xOSBhdCAyMTozNiArMDIwMCwgVmxhZGlt
aXIgT2x0ZWFuIHdyb3RlOg0KPiBPbiBUaHUsIERlYyAxOSwgMjAyNCBhdCAwNjo1MDoxOFBNICsw
MDAwLCBTdmVyZGxpbiwgQWxleGFuZGVyIHdyb3RlOg0KPiA+IFRoZXJlIGFyZSBzdGlsbCBzd2l0
Y2ggZHJpdmVycyBpbiB0cmVlLCB3aGljaCBvbmx5IGltcGxlbWVudCAucGh5X3JlYWQvLnBoeV93
cml0ZQ0KPiA+IGNhbGxiYWNrcyAod2hpY2ggbWVhbnMsIHRoZXkgcmVseSBvbiAudXNlcl9taWlf
YnVzID8pLCBldmVuIGdpZ2FiaXQtY2FwYWJsZSwNCj4gPiBzdWNoIGFzIHZzYzczeHgsIHJ0bDgz
NjVtYiwgcnRsODM2NnJiLi4uIEJ1dCBJJ20gYWN0dWFsbHkgaW50ZXJlc3RlZCBpbiBhbg0KPiA+
IG91dCBvZiB0cmVlIGRyaXZlciBmb3IgYSBuZXcgZ2VuZXJhdGlvbiBvZiBsYW50aXFfZ3N3IGhh
cmR3YXJlLCB1bmRlcg0KPiA+IE1heGxpbmVhciBicmFuY2gsIHdoaWNoIGlzIHBsYW5uZWQgdG8g
YmUgc3VibWl0dGVkIHVwc3RyZWFtIGF0IHNvbWUgcG9pbnQuDQo+ID4gDQo+ID4gVGhlIHJlbGV2
YW50IHF1ZXN0aW9uIGlzIHRoZW4sIGlzIGl0IGFjY2VwdGFibGUgQVBJICgucGh5X3JlYWQvLnBo
eV93cml0ZSksDQo+ID4gb3IgYW55IG5ldyBnaWdhYml0LWNhcGFibGUgZHJpdmVyIG11c3QgdXNl
IHNvbWUgZm9ybSBvZiBtZGlvYnVzX3JlZ2lzdGVyDQo+ID4gdG8gcG9wdWxhdGUgdGhlIE1ESU8g
YnVzIGV4cGxpY2l0bHkgaXRzZWxmPw0KPiANCj4gU2VlIHRoZSBkb2N1bWVudGF0aW9uIHBhdGNo
ZXMgd2hpY2ggSSBuZXZlciBtYW5hZ2VkIHRvIGZpbmlzaCBmb3IgZ2VuZXJhbA0KPiBmdXR1cmUg
ZGlyZWN0aW9uczoNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRl
dmJwZi9wYXRjaC8yMDIzMTIwODE5MzUxOC4yMDE4MTE0LTQtdmxhZGltaXIub2x0ZWFuQG54cC5j
b20vDQo+IA0KPiBOb3QgZXhwbGljaXRseSBoYXZpbmcgYSBwaHktaGFuZGxlIHNob3VsZCBiZSBz
ZWVuIGEgbGVnYWN5IGZlYXR1cmUsDQo+IHdoaWNoIHdlIGFyZSBmb3JjZWQgdG8ga2VlcCBmb3Ig
Y29tcGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5nIGRyaXZlcnMuDQoNClRoYW5rcyBmb3IgdGhlIHJl
ZmVyZW5jZXMhDQoNCkkndmUgY29tcGxpdGVseSBtaXNzZWQgdGhlIHN0b3J5IG9mDQpmZTczMjRi
OTMyMjIgKCJuZXQ6IGRzYTogT0Ytd2FyZSBzbGF2ZV9taWlfYnVzIikNCnZzIGFlOTRkYzI1ZmQ3
Mw0KKCJuZXQ6IGRzYTogcmVtb3ZlIE9GLWJhc2VkIE1ESU8gYnVzIHJlZ2lzdHJhdGlvbiBmcm9t
IERTQSBjb3JlIikuDQoNCkJ1dCBJJ20gc3RpbGwgaGF2aW5nIGhhcmQgdGltZSB0byBnZXQgdGhl
IG1vdGl2YXRpb24gYmVoaW5kIHJlbW92aW5nDQoyIGZ1bmN0aW9uIGNhbGxzIGZyb20gdGhlIERT
QSBjb3JlIGFuZCBmb3JjaW5nIGFsbCBpbmRpdmlkdWFsIERTQSBkcml2ZXJzDQp0byBoYXZlIHRo
aXMgdmVyeSBzYW1lIGJvaWxlcnBsYXRlLi4uDQoNCkJ1dCB3ZWxsLCBpZiBhbGwgdGhlIERTQSBt
YWludGFpbmVycyBhcmUgc28gY29tbWl0dGVkIHRvIGl0LCB0aGlzIGFuc3dlcnMNCm15IG9yaWdp
bmFsIHF1ZXN0aW9uLi4uIFBsZWFzZSBpZ25vcmUgdGhlIHBhdGNoIQ0KDQotLSANCkFsZXhhbmRl
ciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

