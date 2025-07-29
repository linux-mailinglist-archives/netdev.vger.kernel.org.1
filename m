Return-Path: <netdev+bounces-210828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50AB15025
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602FF18A11E6
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA0293B4F;
	Tue, 29 Jul 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+bQpCxD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFEB207E1D
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802869; cv=fail; b=t/OxdZBz97ZUoIxt9oL/jmJGm6S7/tpTUCULem+izxsAyaulorOUOfaSWVsre9MMqJ7pLQvnoztByvCjzNf59jWmJrBDY85RxfJX+NsiLZ2/O9iWFPkK900FU4IUM4PiUw2xekXsuQfa77cPxlY6ezh0ueRkiQ9g4OkDqfiEYTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802869; c=relaxed/simple;
	bh=BW+djps8bwxH9WPc1h55Iip6EFaWmecqj54/qKpHObY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Auz+4jU5i3AfV1sIUCCY5Q13JFsu3zpv0urxEVGwvwl3Cm8rhlEEF+sRt/AEs7eUkVVm6UCIBftCJ0SPwFdDwHR8oWbpJwxk8ODFBR8m1fjt9vZ1eMnwBmERXE0HHfb6Br+42L4ToYCM+cPi/8VmpSq+sHI2l5pqm0W9J6z8TaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+bQpCxD; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDuidWtdYexIHi/Hb9AxDsbj/dnzkXJ/LnxkjPc0eqNa4zpLmxy2gepUU9uN0+DlvYmml4p6+bo7K8J9m2egmi4jfP7/gfcYE5f+iSp9Ez2a3hwnmC3B1wkvRfcSPx5iojVdff6sUH0F/F1qRYcvjbZN8261It9ZsGfXxrFYSryF4efL0qKDcvw18WTvrL0Qf/13u8565uiHusoNxYO7EwRFw9cMlGUW3zCFh+IbwRUK2TPZjwpCI42O4q3D8jpZxf+/1NuVL6dg7OC4sKEnFVGz3MknT295VYsYFqXZ5BnnR3FyX0Vy+jSWQfVQPJpFcxiDnuyCrv8lRrDogdRiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW+djps8bwxH9WPc1h55Iip6EFaWmecqj54/qKpHObY=;
 b=CFQc0HeDRmBmyKODSNVCZq/AGoXyZ4p/QO/3flsfRlgj3/v4HA1yJP6bH7iPZeBbRE3IrVYOL96jFxxFVbknBqa83kPhZX7FmIpbyHPPBboQXoo8TZ5bdrzvcoze5XSDHYsIe1LX6b30YLhxFepFN4n3chRlH4GPsfRgKPkKrpm7oxzun2U4vUoWT500RJfcMTQ6RXQf7oZ46A2/IbUq+CxeJalzQz60BNfN5UEA0L6uPFpw4PeG1EwSUumF3eFxuKrUxVbZJBIUH0Sr0IZHHYnxr5wk3uWjqo48pO7weOjokhfpkiZDvKwykquPCDbkwBFpMjENbXwMzvhwj4QU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW+djps8bwxH9WPc1h55Iip6EFaWmecqj54/qKpHObY=;
 b=D+bQpCxDaFXh4kOudEihGCUPXuC681dJroqWPCPzHfkjb/Hm/unDWf1j1vjd4VfxREcPjjEfCg3HmJbrESkjwyR6klp5qrk9xJ+z0XYNxhD5Mz9RSKyq54DCdFEBn1B+tC+JaPs0dAMSlN9jHG82rpWoZ+kC8OCcwU9f6wembOZmQw5mIPOu+nIGVtflZY6Gh82JbTpo8JnNawkJWqKWaja/pqFvsFVOuuucLp4Ijox1zTEl9Kops8AZPyWP/0BXS5bZQ9bFp5VnF/ODtWJ48OONKWysUakd9h2gaQF+sagAE3TZ78qCKZkqPrVFVSg5nl/LDwFeRGcvNP7lZlnWfw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB8353.namprd12.prod.outlook.com
 (2603:10b6:610:12c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:27:42 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d31c:9027:c5d8:22b4]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d31c:9027:c5d8:22b4%7]) with mapi id 15.20.8943.029; Tue, 29 Jul 2025
 15:27:39 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sd@queasysnail.net"
	<sd@queasysnail.net>
CC: Leon Romanovsky <leonro@nvidia.com>, "razor@blackwall.org"
	<razor@blackwall.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check from
 validate_xmit_xfrm"
Thread-Topic: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check
 from validate_xmit_xfrm"
Thread-Index: AQHb/9LUQIxbYYOolEihGsgvsHVMy7RJOvaA
Date: Tue, 29 Jul 2025 15:27:39 +0000
Message-ID: <6d307bb5f84cdc4bb2cbd24b27dc00969eabe86e.camel@nvidia.com>
References: <cover.1753631391.git.sd@queasysnail.net>
	 <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
In-Reply-To:
 <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB8353:EE_
x-ms-office365-filtering-correlation-id: 62da63a1-6d3c-47b5-6b64-08ddceb4745a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHdOV2pWYUo3NEc1OHJkTHFrdlJ1M1FEN3U2eHhoS3RkVVBXaDNKc3JOSWFB?=
 =?utf-8?B?NTlvT2NKRVRnUHpjYmFhanlYdzhpTEtjMG9idnZaS1dORFJNbmk4VEhXaTVy?=
 =?utf-8?B?V0xnMllZMEo2VkNNMHlkMXhsbitySkhNcjVnTVJvdCt3cGJ2RVI5V2FtNEFo?=
 =?utf-8?B?VGtoY1R1K3UxOG02QytJdHBnNEtNa1dKUzN2T2tqbElCRTErYjBRRHdheG5K?=
 =?utf-8?B?dkhCNVFWdG1QSzZGYzdxa0QzWGp4Q0JlenpEVmExaHpkNlMrcUlnWWsxcVRU?=
 =?utf-8?B?b0d3ZG1pelJRSXNYVVJXR3NIeFI5UFZDZHlGWWZWZWw5R2R0d2tkQnVhS2lq?=
 =?utf-8?B?UWtZV0FYeHY4S3FsODRhQXczN085cmczQWJOUHdGbmZOWGZqU2tqNmM4OWwz?=
 =?utf-8?B?TVhTRExsK0p0M0FDaEZSNWt5ajZ6ZFF0N25nYmw5YVpIN3hubFhpY1h1S0dN?=
 =?utf-8?B?MHBsbnFaZGZqTzBlZmh3Wk1ieThjSDVsMnUvb1dqTUdUdTJ6K0RFYnFCcEJy?=
 =?utf-8?B?bjBsanZNMHRrZ2N5NUIrU29vaTVRWTc3bitXcTNiN2kyRjBjNnhyR2hZZkZq?=
 =?utf-8?B?QTNzWS9iSmt3eGk1a1R3MGNpZ3N0cXdEcGRWcm9xbGdndDZRNm5hQkZRc0xm?=
 =?utf-8?B?aUcxZzc2Rnd1UlpYTkJTcXZVNDBjUzhkZnJtaXFrQ3NTV3paWmEyOWd1MllJ?=
 =?utf-8?B?dHVGRUE3REdmVEhSU0k2YjJSbHc2anQvVnZDWEJPWklaMnBMRkpJYXljTlJi?=
 =?utf-8?B?aXhrUTYvUm1tU21tcnU3SXhoeHRuWFRudG9pbFRsaTdoSjNoUVNTUjZKWlpM?=
 =?utf-8?B?STJ4SVNIbVI2RTF0c1ViK01NejhlWE5QWCsxRUVwWTdNL1FvV085NGJpUXAz?=
 =?utf-8?B?MGJMS05hWWVoR1JoNUI0OHdTcTNsYWpYUWlsZklkdUZyb25ZM0s5ckJWbmJj?=
 =?utf-8?B?UUpycGZsVkY2TE42bEY0NHBEU1ZCVjZwM1p4Y3dIUmxyWEozcHEyMmZHL0VY?=
 =?utf-8?B?NnVDUmpuUVlrUnVSTFFJR3VFU05xOWQ3b29CTC9BQ1FKY1llcWxreVZLaGZX?=
 =?utf-8?B?RnE2cmt3dUdDWnV2a01kMnc1S2R4eW1Dd214V1YycllBdEwwL3J1ektlQUly?=
 =?utf-8?B?clVpRTM1c3hHMkxTSFpMVU5QWGVQNkFKVkREVGVtM3JBMlc3UGtnM09rcERT?=
 =?utf-8?B?WklOUWk1REVKM1FCS0h2anZ2VStvSEdLTzFJcGw2cFY2ZHFicXhKelRodVJI?=
 =?utf-8?B?RVAzV0dvOFNDWkZMNFNQaitjZ2pqUUJPVUxLZlFodzlLMTZMMW8wU200QnFF?=
 =?utf-8?B?emJuVENMdnVEYzN6dmYxK1lqcjA0c2p1ZmJkQVJuaWNreUV0akorTEE5OUNv?=
 =?utf-8?B?dTRoWGZ4MXVkdlF6UHRDcXB0ZHRQczF0UkJuWDQxOHpzT1d3Z1FkK3VGVy80?=
 =?utf-8?B?b2EyZGgyUURYbEpSZ0U1VUZGSHpTUStWR0NOcDJaL0tiR1pPN3JNOGN2SXFs?=
 =?utf-8?B?WTh0SWw1cFZ2L0FIMGxsYzBkMlRrNnFoWVlTNzFJOHpoZi8rWmgyR0dxTjZq?=
 =?utf-8?B?MExxMzMrL3NsVUs3WFFPK2srSWtLTFVoZTlZOFloTHdxS2kzRVhNcUJpWUdN?=
 =?utf-8?B?NEZhTmg5RXAyT1RDVmMyZHlZUFZZaHVTbTVHZDRRYjBRY1M3ajdXa2VZeFRF?=
 =?utf-8?B?akNxMmZES29razZlbmhHaWMzUW91b01xNlY4UVc3ZmlZbWdBQm5LcDF2SWIv?=
 =?utf-8?B?YW85WDdRaks2NE91clg0OTVNUWlnV1l1U3owZ3VZUitQWjZObTNGcDZ4RVcx?=
 =?utf-8?B?OGNWU1R2ZmlMSkpEajFoUmdMSllYM3lNTGhFSnFKZFB2YVlqMzBqb011NlFp?=
 =?utf-8?B?aEtHQlJmQkRndzVlM0Q0RlBlMWQwcU9OaDZBNmZqbGRhYVBKN20wQzkzb1Ir?=
 =?utf-8?B?VTNkL1NORUJUQ3BmR20yMXpvWUI2QkpBMEFBaVJlSFRxS2g0RzhtOE1TeGFV?=
 =?utf-8?B?M0tpUTZ0azd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TERRaHBsOE9hcGhFcm1kbU5mVk1jVGtzbTlKYm9BWW0raVdPZVVVQ0RGMDBF?=
 =?utf-8?B?djhmd21HWTJxdC8xb090QXlELzN2a2FzYjF5ZTY2Q2x0M2NYNXlMUDltWEFu?=
 =?utf-8?B?MllBNE9XK0JtejlWTFBJZGFCL1Eya2oxQTRIa2NSOU9sNi93Qyt4MldIelFl?=
 =?utf-8?B?czhUcFNmRCtscmFIQStwVVg0MjQzNk96N2s4cndJWWNwamZTaDIweE1kSE1i?=
 =?utf-8?B?WnlETHZZTzdOMTRqaC85UXE3NHVvSVVWS2twd1V3WEpqNmhCUnUzQ2prY0JJ?=
 =?utf-8?B?eTVhbUV6Z1kxMTVaeEpCRUZCb3JOdkVCVEpvclZHdEVmQjFucDRnVEQxNXlh?=
 =?utf-8?B?dGFtVlpIKzlVdWNVMk1QQkdUNS9xbU8rMmhKVTd2S0htQ25jZjlJTmdxQmo5?=
 =?utf-8?B?S2J5NENydUJuOEMvejBkZGoyZHZiaEVCYjFBKzUxV0Zla1cvdG92S0d1OEZv?=
 =?utf-8?B?QVVUV3lKMTRKaC8xOVVjaDJ6QkJ4YXdYUTNIdWZad1pjcEVxbDRCV2NXZnVP?=
 =?utf-8?B?Z2V2RXF1V0tyTDFaMGtLejFsRFZLcFF6ZnNDYy9TcERvNDRPZG9ublR1Q2pL?=
 =?utf-8?B?aG1ndTZKYXI4dTdNY1I5VnNBZHM1Z21iaTZmc1l4TSs1eXRSVXkyMU94V0p0?=
 =?utf-8?B?aHJ2NEU4M0pMK1JRY2pwSzVDdThQUnJlNXBUREVPZ2s2NDREK1ZCZUNyaVg5?=
 =?utf-8?B?NnB6QzVkaU82RlFXOFdCZ2hhb3I2cFljQmptd20rY2NaUzAwS3FReHFQeVZR?=
 =?utf-8?B?RmZFNk1iS0VjakxSS0pJUHdMNmNxdjNTWVZORjdWU2RpUG55cTNKSHpDOWFH?=
 =?utf-8?B?SjRlUHhhWkh6ei9CcHpPemRQNGhOUG1ocFp3T1BRbmhTbEtlZ2xvakQwRGp5?=
 =?utf-8?B?MGNFUkZFcGhFd3A3Qjh6aCtxRHVEMVA5VEsxN3N4MGxVeWtmb0VaMytzYllM?=
 =?utf-8?B?TzN4cUQxRDcvT3QyRFh1T1VCbi9kY1pKYjFTZzNnSFhVSjZOV3QrdUo3ckRo?=
 =?utf-8?B?dWE5SFBneE5OdDVNNGlITUIwcHBvclY3K2MrOG9OaGdGOXIwRU1vUW1hM0NP?=
 =?utf-8?B?SXFnbkk5NlYwakdvRGpDdUg0NFdmSDBPNGRkM3V6Sm13REp6OVZsVFBlQnBZ?=
 =?utf-8?B?VUVEbTZQbXR0UW4yM2R2ekYyMC9nOE5oQXJXNTI2VlBxZmhFVDZCSFdjTU1B?=
 =?utf-8?B?RXFrbldiR3h3WHhrUXJrM3BtSFFaL1F5TWlBQTB6QU91WG5IQmFaNGsrWm0x?=
 =?utf-8?B?V09tZk91TDVXVlFEbmxjaHVYaGsrSkd1WmJPMnV5UlgxMmcvd2h1T0pnRmds?=
 =?utf-8?B?T1VvTzR0Mng3VEV6WlhjcVdyOVFKNjFNMWZUbjNmUXlZZmpXR0ZwV0xkdFIy?=
 =?utf-8?B?djhiOVRRa0orblFzT0hBeldPdVI5Vnpmd29pdHFWcGVMNXV5NWJOcnBjdk0r?=
 =?utf-8?B?bGE3cXc2eE9iNmthOVZQSm4renh5NUljYzNEUDRxeUFtREJTZndqNk5COTRl?=
 =?utf-8?B?d3JyZ1hRMEllTHpiNk54bFhseXc3Q3Z1ZW92OTBWekZGcVNUdXhVcnhWdkxI?=
 =?utf-8?B?SDhUZEt0cEQxOUlZSDRVQk1sUUNJeFZOUFd0dk5LbFBCUDZSZGZ2WVBsY1pl?=
 =?utf-8?B?WWZCM0Z0bzBOeEY3dG9obzluTVl3bFlYTk45YkJFd0c2eVl4Z0t1VXB3Z2x6?=
 =?utf-8?B?ejNPM1dDcWc5dHNXVjJZV1JNL1ZEdUlGL0FQQmhtQm1SYm1YajBpQkpOQndG?=
 =?utf-8?B?QXFMYkswMUhacHI1WmMzNnRaRXYwN0w1eDRzZWJJVWl0QXJSV0E5VWhrUi9a?=
 =?utf-8?B?cmovTmVtRDNJclQ2d3Jrb2MrelpkVEx0QnExb3hRRDAzL2w4OEtBb2pNc00w?=
 =?utf-8?B?S1dZeGZWWlZnWldhcU1kSTJHYVlQL3FHL2JzZTIvaWtwYUdER3NnNy9OM0Fq?=
 =?utf-8?B?SGNkbXhMVE5NdnBBc3dCNStEU3Y1RENjVkM2ajl4a2FPM3hqVmRaczNFbVdB?=
 =?utf-8?B?SHNXUDF2bHJ3a3BZK0w3QWhJY1BLc3pRUmIwWnFCekltTGh6ZWxtWEdGUkZ0?=
 =?utf-8?B?VGE2VlNqZE4rVTljYzdBUzFkNlhCbnlETVdaaDlkaFlwZjVIanVGeU1aZTZj?=
 =?utf-8?Q?eMV4XK1MLhezP3sBh0etN+4tm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05B385673DEF304D9C905DD32F8269FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62da63a1-6d3c-47b5-6b64-08ddceb4745a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 15:27:39.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osBaiZbXElDlklMibisx1AfCKaNx40DaH3WrlhaqOAvtk5utUe6WvNy3atbzZinlYN9cBBGDf2Bcf+NP9QZwtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

T24gTW9uLCAyMDI1LTA3LTI4IGF0IDE3OjE3ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZDUzZGRhMjkxYmJkOTkzYTI5Yjg0ZDM1OGQyODIwNzZl
M2QwMTUwNi4NCj4gDQo+IFRoaXMgY2hhbmdlIGNhdXNlcyB0cmFmZmljIHVzaW5nIEdTTyB3aXRo
IFNXIGNyeXB0byBydW5uaW5nIHRocm91Z2ggYQ0KPiBOSUMgY2FwYWJsZSBvZiBIVyBvZmZsb2Fk
IHRvIG5vIGxvbmdlciBnZXQgc2VnbWVudGVkIGR1cmluZw0KPiB2YWxpZGF0ZV94bWl0X3hmcm0u
DQo+IA0KPiBGaXhlczogZDUzZGRhMjkxYmJkICgieGZybTogUmVtb3ZlIHVubmVlZGVkIGRldmlj
ZSBjaGVjayBmcm9tDQo+IHZhbGlkYXRlX3htaXRfeGZybSIpDQo+IA0KDQpUaGFua3MgZm9yIHRo
ZSBmaXgsIGJ1dCBJJ20gY3VyaW91cyBhYm91dCBkZXRhaWxzLg0KDQpJbiB0aGF0IGNvbW1pdCwg
SSB0cmllZCB0byBtYXAgYWxsIG9mIHRoZSBwb3NzaWJsZSBjb2RlIHBhdGhzLiBDYW4geW91DQpw
bGVhc2UgZXhwbGFpbiB3aGF0IGNvZGUgcGF0aHMgSSBtaXNzZWQgdGhhdCBuZWVkIHJlYWxfZGV2
IGdpdmVuIHRoYXQNCm9ubHkgYm9uZGluZyBzaG91bGQgdXNlIGl0IG5vdz8NCg0KVGhhbmtzLA0K
Q29zbWluLg0K

