Return-Path: <netdev+bounces-243410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9879C9F434
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36F623484B6
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF2229B36;
	Wed,  3 Dec 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="kT1C/PY9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F01EDA2B;
	Wed,  3 Dec 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771545; cv=fail; b=GxPyCHkQneXO1uN5z+NY+/5ip/Wuk57TsH3L/8KGCz4VmcbGYXvm80gYpvJsq9xhJN5Hvqb8sD/RywRFLaq4PfbN/aCYEVWwviK+v15Ico2u+CiLPy6x5i0MN2jijmoSx7wqf25npYToT4ek72y+dDgYB4wYImZhDmWz7vEeCkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771545; c=relaxed/simple;
	bh=EMoejZuyk+Yxi0jKsYtN+HFezfi5ZXhSLFGU+30/wm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M/Fy7rVbPFUlGPsaBmO5Ji44rPBUvGxvzTP+ZNkN4Tduvnpt6ynhQtw8EHur1pEBOrD6o0fqsrNUQx4084XRqnJHDfzGKPwBRJWxFhLxnwqBeSIcWXHiW9ReOTL1JNQ/TaVCalPkzd7sruu8YOHiW8ZfzJnkMUlXJo0W48KCgvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=kT1C/PY9; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC3mcl75FRtkccEB7EQpiarHwvDwIjh+OghKIOkOZA0sPJE840e7uSN7qYGJiCH9+ztNHZIEAcCbbrcescrChriPS0Xs/JZpoc5+GR15n8nlwAnivBSANRLONDdHjrgCzC/uUc6rRe5PADRO06VT5XUdL6azBirivq8yg54/RDICddXPagfYQSnJmvX11sFoDAQCBZgwAVxdMiiQS3H0p4YrJ8GvV59dMHNERd8QwcKhfPrJwH1vE3ogm0lnJ89/QN80Xepsl3WYS0uMPktyErkHLdz/R+R9XOW2lVrSSRek4huyPjeWaIZR566DHVWMW/f9Y7JunHTD9NHHKGPPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMoejZuyk+Yxi0jKsYtN+HFezfi5ZXhSLFGU+30/wm8=;
 b=pMZPOrAn2KhFSIMEg96P3qPnPvjyN2CxaarbwE3HI2dhDDu64SnJVRWJ188iahq1HAU8SdYtUpfQIGi+lXA0XaRRwCJ0of3wo+Xy8jkjd7IkIsPSaVr5/p53PIKVawiRRZw5c8Aq8CSml8ERNf7cu69Uk3gqOZ8cn5fMby20bxcNG/KieuJh5r004fc5fbk8sjVholtR1/l3LXq5tDg0epzFed6sWOq8IBpSWrchsShXizakbVbqE1hvjqZ7v4pvMUDlij/3lUIquy6SwhDWxyaD/tI1ub6RShOMRbz07RNU+OcF7iaGaBfvQd2q2jIW8gRk/fGx7GOvYyj71A1heQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMoejZuyk+Yxi0jKsYtN+HFezfi5ZXhSLFGU+30/wm8=;
 b=kT1C/PY9XDSrPF0cpiIjonci87ygMfzo9dC5zSNOmQRG6x0J4xdiD3mTAbs2IECmmSXlCnOlmBESuwC8WasdV0vHyxq/3KkruRyUpD2cbJ0KDKuyv981n3pLIN2tCUDFk9G0u2mv6v3z/MN7+7CiYeKn06RtZqB4+Dp4tzFmdAo=
Received: from VI0PR02MB10631.eurprd02.prod.outlook.com
 (2603:10a6:800:206::14) by AM7PR02MB6388.eurprd02.prod.outlook.com
 (2603:10a6:20b:1b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:18:59 +0000
Received: from VI0PR02MB10631.eurprd02.prod.outlook.com
 ([fe80::7f57:534c:1bc8:2ef0]) by VI0PR02MB10631.eurprd02.prod.outlook.com
 ([fe80::7f57:534c:1bc8:2ef0%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:18:58 +0000
From: Ivan Galkin <Ivan.Galkin@axis.com>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"michael@fossekall.de" <michael@fossekall.de>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "olek2@wp.pl" <olek2@wp.pl>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Thread-Topic: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Thread-Index: AQHcZDkpMh1hBoOYfEa+e69ycVqb47UP9xQA
Date: Wed, 3 Dec 2025 14:18:58 +0000
Message-ID: <43bfe44a0c10af86548d8080d0f83fdbf8070808.camel@axis.com>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
	 <20251130005843.234656-3-marek.vasut@mailbox.org>
	 <20251203094224.jelvaizfq7h6jzke@skbuf>
In-Reply-To: <20251203094224.jelvaizfq7h6jzke@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR02MB10631:EE_|AM7PR02MB6388:EE_
x-ms-office365-filtering-correlation-id: 8d30a90e-bd7c-4edb-9f8f-08de3276e67b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2NzQVUrMDk4S1IxVldZb1dSLzMrNDU1V0NOaEJxYmx2QnRXdVlSeDM3UWly?=
 =?utf-8?B?N1ZwNUdHQSt6a2ttM1VSMXpXbTNrSHF4V2ZRN2FrZldqUFNRbVZNYzRtQ3JK?=
 =?utf-8?B?UlJjRGtMSldGSjVnQnFUMEZ6RWJCcjVMV2hOckdjdEkrU3JmdHkvMURBdjlW?=
 =?utf-8?B?c0N4anJ6ZDJmbzlFVnpKRUtLN2dRTUR6S1VsNkpzanU5dEorQ3BhWDEyNjNr?=
 =?utf-8?B?YWNpakFBOVpkakNzcjhjZWp4VW14ZGpLaFlHSXdnOUhCU2JGTUtMdUhOZDdB?=
 =?utf-8?B?ekl1S1B6cHdMdnJGSDVxQ1htejRyMDd1VVh5cVhNb0tIeHlBZGRSVnFLejFs?=
 =?utf-8?B?SmpNWkFMM3VSeGx2cWdGUHIrQ0MxaDNQSGg2ODV5V3pJMTE0UDBCREFaMDB6?=
 =?utf-8?B?czV1RmFtUlJuSGUwdnpJMnI2RW5rOUFxQWpwQXliczlETUZKeDhqcy8xTUg1?=
 =?utf-8?B?ZFFwUGZwemNwR2FLZzJFVm5uWnNEMGdvamZSdk1xSGtrcjNrdHkrVGdOSi9t?=
 =?utf-8?B?OGRmVGFURGdodi9MeEtSNytFSVBwK29jLzVPNWdZZytqZVY5T1I1Tmt3anA1?=
 =?utf-8?B?OEx0UDhWRnluVXhVR0lZRUlXY2RBV2lacDRHR0dtYm9XejUrVjFoQ20zZDBP?=
 =?utf-8?B?bmYzTkpkU256eHA0MXNSU01odXJwMllmOWoxdmRsWEVEWnM4RGMvRXpOTmwr?=
 =?utf-8?B?NERRZ0JCcWtOM1pXVXRGNHZESm9Ja1BUKys4WXJjOFZoS2dZMGdXdk95TnhW?=
 =?utf-8?B?Ky9wUUUrN3Urdks4dU5BTDlYanVuL1FlTzBhWUFGYjBwQ29EOTd0cCtUeWxs?=
 =?utf-8?B?YTZnZEZNa1Rsa2hCaHQvQlFudzM3VUE4U0hMNlluK3NkbmVmOEllVDQ2SnRu?=
 =?utf-8?B?ZjRHMVEwSFY0ZS95U1JrTlpBcW9LZGZkcXVKc3ZCVTJaTlIzbG1pUmRLQStv?=
 =?utf-8?B?azI3dXEwQzJzWXZiVFUva0ZwMWRuMXVOQWJLclNTQ3huN01pVk45anpsUFBE?=
 =?utf-8?B?TnNzK0tzZWJLcXhGOHZZWWJXK0E4RlZ2a2lRTGhTTGpTK2ZjWkdwV3J4WTBD?=
 =?utf-8?B?eW5WcU5jSWVqak8rdlB6OE9Hdmkzejl4NVZ0NU1IeUNYU2ZNWDF1SzhuelBx?=
 =?utf-8?B?RTZlTUp4SktMRFY1MTcrT1JrTUJTQitocTRXb2pVUzF2VnRtSUNQSG9SUC81?=
 =?utf-8?B?UFdCSm1rbWZCQ2ZQU1VEdXp4dFRRNkhvbFFBVTNrV1dYQ1h5Yk1IRUhnTnZw?=
 =?utf-8?B?RTczRWcrOFA5d20rdENhRFAzRFNCWUlMbkNzd3ArMWpFR0dqTGNDbkwya3dj?=
 =?utf-8?B?Wi9Eb3J4WmFOQS8vZVJZeHRtcDRiZzRuYmtsNndLemM4L0xPdnpleGZlalRK?=
 =?utf-8?B?YStmWGtkc1JFdnlVcHZxQUV3ZnY1ZGxtdDNLNEN0cG9iOWhVSk1EWUJ3TFFV?=
 =?utf-8?B?aWkrTVRPMzAyTGtaTHB5SytKYkRvSHJrSlRjOVNRbmVNR1ZKMVIvY21Wa083?=
 =?utf-8?B?SXByTWVIem1WMjUxejBOVStEa3pxNmhtOTRxTk5QSjgzOUF3eitObUlOTjla?=
 =?utf-8?B?VHdKUzVpSS8xUHFuYUNpN2lWNWpaOGhLZDdQQTAzZnpOMkpEeXV6SllaYWtZ?=
 =?utf-8?B?MzdqcVZkMit3bjN3QnJQL3YzbUtEK0VITGJHamNxdTlmZ1FYRDcyVXB1VGRD?=
 =?utf-8?B?S3A4T2c2ZEVtRU9BaWZDQXQ5anpuVnlhcFJ4My95cm1ObE50NVVzMVBrTUZF?=
 =?utf-8?B?bzJmVFZqd2htQTlUMCtDOEh3UWh6YTZnUmJQRVVnN1lWYTF6UTd2UmdIMmdy?=
 =?utf-8?B?ZFFHWmhwM1ljVjFUd2RzOWZYY09rZXk3c2dkTnVEc3VDSUlXbXJkYTNVZU40?=
 =?utf-8?B?dFQxRTZ0OUl5bWI1TXR0TGZxQXhMbzUyZ285ektwcWhsc3MwTndHMEtqVGhn?=
 =?utf-8?B?WDd0SThuY0RqSld6SXRFRGVZdGxPNVJnaUFUOUhkbWt4NkxTZGVHRUtSTU1i?=
 =?utf-8?B?WThCTXhad2RVQWQ5NVhxd3hNSWxZUFpwTE82THNqRFI2ZzdlZ2szMnlKRlJr?=
 =?utf-8?Q?ihIYTB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10631.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDBvWCs4bXF6QndWYm5jb3pQMXZCdDdQVklkVFFFSzA3WnJOUkw4S2hLeFM3?=
 =?utf-8?B?Q3dRTFEyeXpjMUtDTk9VdnlJd21HekZJc0ozMWc0d3FLSWtTNVkzcmIyNFFO?=
 =?utf-8?B?djA1Vjc0QVJXS1RFMHlEQU03aGxabW9nVXNmVUN1OVVrQmszeWd3T3BiR2ZD?=
 =?utf-8?B?b2NJT3Z5MjIxUGRLNTlHRjRiR2d1bHh0Mzh6Z1JWKzhsRk95Y1lTbmFzRXNU?=
 =?utf-8?B?QTN5bndNdjlXTjdnRVE1NGtlRW9YUVhoYjdzaWZlM0lTa2lURjJPc0U1WkEv?=
 =?utf-8?B?bDVYTzkybDFxcG9nUTJ5aTZKN0tkN3pHR1lmbnpXL0s1aFl4aUFwWFBJNENH?=
 =?utf-8?B?VUsxS0dHRk1uem16aldTT0pXQnd1NklCNGd3MDlKOHMzOWZYOStrZkh2WWZp?=
 =?utf-8?B?UUFOWjA0ZHo4YlkyQ3JRMUR3SlNZRXFMcTBpYmVFZnBpbTBZK2ZXSFlMeThZ?=
 =?utf-8?B?TVN5c0JHZFpYSUlIemxOcGhTUG1QUUVjV1hHdGxjR1pZcXFZYVdXWTdvQXg5?=
 =?utf-8?B?NWlpZnhtMlQ2QzFaZjd5SHRjbExkSVcyR2N2eUMvY3I4RzhQdXVyUXlBTVNr?=
 =?utf-8?B?VlY2L1IwSFF4WEZaWkdpeWhWVzJucndKN2R6R0VXSkVnQk9XNFVZc3gzNjRj?=
 =?utf-8?B?SmlnRXdKWlBKU211SmY2WFZiTGl1ckRLb21NcmhDZnNtQlFSaHdJNTJzTE0z?=
 =?utf-8?B?Rjd0WXB3aXJLVUVLT212d3M5cmllbHNiQXRtUkVqa0I1Y0pSQmVtNTlNRVp1?=
 =?utf-8?B?MkptNXZPZWhBcUZ4L3V2U1g4Yk1HbDVDeTBXblFGTjFnV3JNejgxcDlTWUJx?=
 =?utf-8?B?QmpTU2ZWZVRqaFArMkZiQUVWanpETXpQZ2U2Tzd2MlZySmtkQ3VNemt3WW9l?=
 =?utf-8?B?UHFjcXpEKzRRc2hFRTJhNFBDQUNnVVRvOXhLWURHMHdraEdtalRQeUNWb3Mv?=
 =?utf-8?B?TGVpUU0rUkQwZDZZRjRDL2ZqMjBDRWRBTnBqRlByZi9NV2o2NS9va1oyS2d6?=
 =?utf-8?B?WDU2VEpRMExGTlVPMG9saVE0Q1hEMFFHd0dSMGNhREpHa2dwajRnWVNydmVa?=
 =?utf-8?B?TXpvL3diYkpVZXhUMjdUcHEvOGh3SThtRkUwWStreWYxbEFJNWtmOExVcjFo?=
 =?utf-8?B?dXhwT3RRMlh5VHkzUzU5RnBCVHVUc0tlRkl0d2J1ZHNzcC82UXNreGNQYlBH?=
 =?utf-8?B?VTZCZWp1dVlkRFU3QS9FWlpRa0UvNzdyVWw0TEJ5eDFVWnMraXE4NGp2UGsy?=
 =?utf-8?B?SzN2ZnJPa0I5aXVCcDNTUEdGOVVMb2FQY0R3bitmbHpraDdoUTZvdTJNQkha?=
 =?utf-8?B?Mjc3dHAyQVZJSDJXaGFINE5hM1l4dXovWmZxTW1PblEvTHM2RFVvb1c0MG9D?=
 =?utf-8?B?T0NCZkI1azRqby9wME8vUlhmV0xRZk45Zy9jN0xHU2hZcFFtWFZTQU1UNTNF?=
 =?utf-8?B?V0xLbUpLVm5RSFgzdlBPRzdFdTFFbnQweU84L2lkRGVxN2tPK3k4TVhsSDF0?=
 =?utf-8?B?S2R2eGpDTFBRUU04Z014eDNjWDVRQ3hZTUJpcmdLcE5DbGUrZEpyVlUxRUwy?=
 =?utf-8?B?akpab2ZLQXY1MDNoanhSd0pIS3hrRHltZC9DNTBPQ2hONmlMcG15dlhKaUg0?=
 =?utf-8?B?ekdNM25aZ1BhdTRnNGxyUGtINDVVRGFHeDc2Vnk4M0R2L3NVemU5OWNGUGZj?=
 =?utf-8?B?SlpYNjRSYUUxRy83bWJYYUxvcFBEOXlob29DQ0dsd1JqWUFwRVpFY1NPTldS?=
 =?utf-8?B?MDdWbnQ5U1JJZHo3MDNRaVQwMHRhc1h0RCtBYmdVbkFFRlJ2UWRCOGovVDlR?=
 =?utf-8?B?RFhib1JoVkpFbldlay9tMFFzdjNJcUNhUDJ4a2RwVEVOM3ZHMjZRV29TYVhu?=
 =?utf-8?B?SldRWGhHM1ZieUQxNmRBMmtFS1hHM1REMzZDZGExeEMzNHUwV3NUdHNCK1FK?=
 =?utf-8?B?QnNmVGVsenV3Y0VsK1pXSlk0cFZIL0ZSUDJ5MEswd2tISUhkOHpyczlGN3pi?=
 =?utf-8?B?Wm1pUVhKUU1QOCtCQnF0ODZMaFl3djh2WDEwTjZpU0d3K2tMeHhOa0lmeENj?=
 =?utf-8?B?SjZtRmRqQWtqNU1EbjNtR3pTUWtHenBUWEtuZTFIdkZrcG9TN2c1NlhEYUxS?=
 =?utf-8?Q?SnzglN3hoOYEIIFCGZCykwS05?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED267A77A216ED4CB3314648DBBB50AB@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10631.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30a90e-bd7c-4edb-9f8f-08de3276e67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 14:18:58.7237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqD1nc2zwIN1luo+U1H0PqpfHmEhvICMCsl6lMZDl0KEqaVtvKXuLqQu1VujuRCD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6388

T24gV2VkLCAyMDI1LTEyLTAzIGF0IDExOjQyICswMjAwLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6
Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB2bGFkaW1pci5vbHRlYW5AbnhwLmNv
bS4gTGVhcm4gd2h5Cj4gdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdCj4gCj4gT24gU3VuLCBOb3YgMzAsIDIwMjUgYXQg
MDE6NTg6MzRBTSArMDEwMCwgTWFyZWsgVmFzdXQgd3JvdGU6Cj4gPiBBZGQgc3VwcG9ydCBmb3Ig
c3ByZWFkIHNwZWN0cnVtIGNsb2NraW5nIChTU0MpIG9uIFJUTDgyMTFGKEQpKEkpLQo+ID4gQ0cs
Cj4gPiBSVEw4MjExRlMoSSkoLVZTKS1DRywgUlRMODIxMUZHKEkpKC1WUyktQ0cgUEhZcy4gVGhl
IGltcGxlbWVudGF0aW9uCj4gPiBmb2xsb3dzIEVNSSBpbXByb3ZlbWVudCBhcHBsaWNhdGlvbiBu
b3RlIFJldi4gMS4yIGZvciB0aGVzZSBQSFlzLgo+ID4gCj4gPiBUaGUgY3VycmVudCBpbXBsZW1l
bnRhdGlvbiBlbmFibGVzIFNTQyBmb3IgYm90aCBSWEMgYW5kIFNZU0NMSwo+ID4gY2xvY2sKPiA+
IHNpZ25hbHMuIEludHJvZHVjZSBuZXcgRFQgcHJvcGVydHkgJ3JlYWx0ZWssc3NjLWVuYWJsZScg
dG8gZW5hYmxlCj4gPiB0aGUKPiA+IFNTQyBtb2RlLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
YXJlayBWYXN1dCA8bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+Cj4gPiAtLS0KPiA+IENjOiAiRGF2
aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KPiA+IENjOiBBbGVrc2FuZGVyIEph
biBCYWprb3dza2kgPG9sZWsyQHdwLnBsPgo+ID4gQ2M6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVu
bi5jaD4KPiA+IENjOiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Cj4gPiBDYzog
RXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgo+ID4gQ2M6IEZsb3JpYW4gRmFpbmVs
bGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPgo+ID4gQ2M6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3
ZWl0MUBnbWFpbC5jb20+Cj4gPiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4K
PiA+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+Cj4gPiBDYzog
TWljaGFlbCBLbGVpbiA8bWljaGFlbEBmb3NzZWthbGwuZGU+Cj4gPiBDYzogUGFvbG8gQWJlbmkg
PHBhYmVuaUByZWRoYXQuY29tPgo+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
Cj4gPiBDYzogUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+Cj4gPiBDYzogVmxh
ZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4KPiA+IENjOiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZwo+ID4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKPiA+IC0tLQo+
ID4gwqBkcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYyB8IDQ3Cj4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9u
cygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRl
a19tYWluLmMKPiA+IGIvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMKPiA+
IGluZGV4IDY3ZWNmM2Q0YWYyYjEuLmIxYjQ4OTM2ZDY0MjIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2
ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYwo+ID4gKysrIGIvZHJpdmVycy9uZXQv
cGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMKPiA+IEBAIC03NCwxMSArNzQsMTcgQEAKPiA+IAo+
ID4gwqAjZGVmaW5lIFJUTDgyMTFGX1BIWUNSMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MTkKPiA+IMKgI2RlZmluZSBSVEw4
MjExRl9DTEtPVVRfRU7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJ
VCgwKQo+ID4gKyNkZWZpbmUgUlRMODIxMUZfU1lTQ0xLX1NTQ19FTsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEJJVCgzKQo+ID4gwqAjZGVmaW5lIFJUTDgyMTFGX1BIWUNSMl9QSFlf
RUVFX0VOQUJMRcKgwqDCoMKgwqDCoMKgwqAgQklUKDUpCj4gPiAKPiA+IMKgI2RlZmluZSBSVEw4
MjExRl9JTlNSX1BBR0XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4
YTQzCj4gPiDCoCNkZWZpbmUgUlRMODIxMUZfSU5TUsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MWQKPiA+IAo+ID4gKy8qIFJUTDgyMTFGIFNTQyBz
ZXR0aW5ncyAqLwo+ID4gKyNkZWZpbmUgUlRMODIxMUZfU1NDX1BBR0XCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjNDQKPiA+ICsjZGVmaW5lIFJUTDgyMTFGX1NT
Q19SWEPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEzCj4g
PiArI2RlZmluZSBSVEw4MjExRl9TU0NfU1lTQ0xLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMHgxNwo+ID4gKwo+ID4gwqAvKiBSVEw4MjExRiBMRUQgY29uZmlndXJhdGlv
biAqLwo+ID4gwqAjZGVmaW5lIFJUTDgyMTFGX0xFRENSX1BBR0XCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAweGQwNAo+ID4gwqAjZGVmaW5lIFJUTDgyMTFGX0xFRENSwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MTAKPiA+IEBA
IC0yMDMsNiArMjA5LDcgQEAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwo+ID4gwqBzdHJ1Y3QgcnRs
ODIxeF9wcml2IHsKPiA+IMKgwqDCoMKgwqDCoMKgIGJvb2wgZW5hYmxlX2FsZHBzOwo+ID4gwqDC
oMKgwqDCoMKgwqAgYm9vbCBkaXNhYmxlX2Nsa19vdXQ7Cj4gPiArwqDCoMKgwqDCoMKgIGJvb2wg
ZW5hYmxlX3NzYzsKPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjbGsgKmNsazsKPiA+IMKgwqDC
oMKgwqDCoMKgIC8qIHJ0bDgyMTFmICovCj4gPiDCoMKgwqDCoMKgwqDCoCB1MTYgaW5lcjsKPiA+
IEBAIC0yNjYsNiArMjczLDggQEAgc3RhdGljIGludCBydGw4MjF4X3Byb2JlKHN0cnVjdCBwaHlf
ZGV2aWNlCj4gPiAqcGh5ZGV2KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAicmVhbHRlayxhbGRwcy0KPiA+IGVuYWJsZSIpOwo+ID4gwqDCoMKgwqDCoMKg
wqAgcHJpdi0+ZGlzYWJsZV9jbGtfb3V0ID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKGRldi0+b2Zf
bm9kZSwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAKPiA+ICJyZWFsdGVrLGNsa291dC1kaXNhYmxlIik7Cj4gPiArwqDCoMKgwqDCoMKgIHByaXYt
PmVuYWJsZV9zc2MgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LT5vZl9ub2RlLAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInJlYWx0ZWssc3NjLQo+ID4gZW5h
YmxlIik7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIHBoeWRldi0+cHJpdiA9IHByaXY7Cj4gPiAK
PiA+IEBAIC03MDAsNiArNzA5LDM3IEBAIHN0YXRpYyBpbnQgcnRsODIxMWZfY29uZmlnX3BoeV9l
ZWUoc3RydWN0Cj4gPiBwaHlfZGV2aWNlICpwaHlkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSVEw4MjExRl9QSFlD
UjJfUEhZX0VFRV9FTkFCTEUsIDApOwo+ID4gwqB9Cj4gPiAKPiA+ICtzdGF0aWMgaW50IHJ0bDgy
MTFmX2NvbmZpZ19zc2Moc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikKPiA+ICt7Cj4gPiArwqDC
oMKgwqDCoMKgIHN0cnVjdCBydGw4MjF4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7Cj4gPiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwaHlkZXYtPm1kaW8uZGV2Owo+ID4g
K8KgwqDCoMKgwqDCoCBpbnQgcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCAvKiBUaGUgdmFs
dWUgaXMgcHJlc2VydmVkIGlmIHRoZSBkZXZpY2UgdHJlZSBwcm9wZXJ0eSBpcwo+ID4gYWJzZW50
ICovCj4gPiArwqDCoMKgwqDCoMKgIGlmICghcHJpdi0+ZW5hYmxlX3NzYykKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCAv
KiBSVEw4MjExRlZEIGhhcyBubyBQSFlDUjIgcmVnaXN0ZXIgKi8KPiA+ICvCoMKgwqDCoMKgwqAg
aWYgKHBoeWRldi0+ZHJ2LT5waHlfaWQgPT0gUlRMXzgyMTFGVkRfUEhZSUQpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiAKPiBJdmFuLCBkbyB5b3VyIGNvbnZl
cnNhdGlvbnMgd2l0aCBSZWFsdGVrIHN1cHBvcnQgc3VnZ2VzdCB0aGF0IHRoZSBWRkQKPiBQSFkg
dmFyaWFudCBhbHNvIHN1cHBvcnRzIHRoZSBzcHJlYWQgc3BlY3RydW0gY2xvY2sgYml0cyBjb25m
aWd1cmVkCj4gaGVyZQo+IGluIFJUTDgyMTFGX1BIWUNSMj8KCi0gUmVnYXJkaW5nIFJUTDgyMTFG
KEQpKEkpLVZELUNHCgpBcyBJIG1lbnRpb25lZCBiZWZvcmUsIHNheWluZyB0aGF0IFBIWUNSMiBk
b2Vzbid0IGV4aXN0IGlzIGluY29ycmVjdC4KSG93ZXZlciwgdGhlIFNTQyBzZXR0aW5ncyBoYXZl
IGluZGVlZCBiZWVuIG1vdmVkIGF3YXkgZnJvbSBQSFlDUjIgYXMKd2VsbC4KClRoZSBwcm9jZWR1
cmUgZm9yIGVuYWJsaW5nIG9mIFJYQyBTU0MgYW5kIENMS09VVCBTU0MgaXMgZGVzY3JpYmVkIGlu
CkVNSSBJbXByb3ZlbWVudCBBcHBsaWNhdGlvbiBOb3RlIHYxLjAgZm9yIFJUTDgyMTFGKEQpKEkp
LVZELUNHLgoKRW5hYmxlIFJYQyBTU0M6IFBhZ2UgMHgwZDE1LCByZWdpc3RlciAweDE2LCBCaXQg
MTMuCicxJyBlbmFibGVzIGRlZmF1bHQgTWFpbiBUb25lIERlZ3JhZGUgb3B0aW9uIChha2EgIm1p
ZGRsZSIpLgoKRW5hYmxlIENMS19PVVQgU1NDOiBUaGlzIGRlcGVuZHMgb24gdGhlIENMS09VVCBm
cmVxdWVuY3kgYW5kIHRoZSBNYWluClRvbmUgRGVncmFkZSBvcHRpb24uClRoZSBzZXF1ZW5jZSBp
cyBjb21wbGljYXRlZCBhbmQgaW52b2x2ZXMgc2V2ZXJhbCBwYWdlcyBhbmQgcmVnaXN0ZXJzLgpU
aGUgYXBwbGljYXRpb24gc3VnZ2VzdHMgc2V0dGluZyB0aG9zZSByZWdpc3RlcnMgdG8gcHJlZGVm
aW5lZCAxNi1iaXQKdmFsdWVzLCB3aGljaCBJIHN0cnVnZ2xlIHRvIGludGVycHJldC4KSSB3b3Vs
ZCByZWRpcmVjdCB5b3UgdG8gdGhlIGFwcGxpY2F0aW9uIG5vdGUgaW5zdGVhZC4gQWxsIEkgY2Fu
IHNheSBpcwp0aGF0IFBIWUNSMiAocGFnZSAweGE0MywgYWRkcmVzcyAweDE5KSBpcyBub3QgaW52
b2x2ZWQuCgotIFJlZ2FyZGluZyBvdGhlciBSVEw4MjExRiBQSFlzLgpJIGNvbXBhcmVkIGRhdGFz
aGVldHMgZm9yIFJUTDgyMTFGKEkpL1JUTDgyMTFGRChJKSBhbmQgUlRMODIxMUZTKEkpKC0KVlMp
LiBUaGV5IGJvdGggdXNlIHRoZSBmb2xsb3dpbmcgYml0czoKClBIWUNSMiAocGFnZSAweGE0Mywg
YWRkcmVzcyAweDE5KQpiaXQgMzogZW5hYmxlcyBTU0Mgb24gUlhDIGNsb2NrIG91dHB1dApiaXQg
NzogZW5hYmxlcyBTU0Mgb24gQ0xLT1VUIG91dHB1dCBjbG9jawoKQm90aCBTU0NzIGFyZSBjb250
cm9sbGVkIG92ZXIgUEhZQ1IyLCB3aGljaCwgYXMgZmFyIGFzIEkgY2FuIHNlZSwKY29udHJhZGlj
dHMgdGhpcyBwYXRjaC4KPiAK

