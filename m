Return-Path: <netdev+bounces-258978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMbTE5AklGnXAAIAu9opvQ
	(envelope-from <netdev+bounces-258978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:19:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F5149D8C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F18EE3002520
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF72367D5;
	Tue, 17 Feb 2026 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="Wnr+ew/G"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021135.outbound.protection.outlook.com [52.101.70.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18927707;
	Tue, 17 Feb 2026 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316363; cv=fail; b=L2LqKwVQsx1pH8dDawTyBEN3FHdFSjRHyofosEun1DyXg0QehST6Za1MG8jYypmGNu4V2Rl+I7/PUnLZwfyqWwK3fGAd501DdSl6yH4XKtjUkJEpr/a1jZ74fnUfJwZFQg/NCwBXyqJ4E2PojHE7hC1b1+JUmLRnmx/QArnBliA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316363; c=relaxed/simple;
	bh=cDgf6mT058Cfm3rQQwf28ATgs+QyXoHakjwBaoLlQgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FtjpG494683UZP1wgpkDjHSAi6dYU4/9clDhOkKySBNg8HQ0cuANqqFwU5FWmyDQYWzTyEQDuZmd8AuL+Thvr1K7lWf21YGx/5Y+tUQB3foBK+vsubsWfi+0JUrWDo0+5697fXs90lUcO+EUBF1PELsILljcPESF2p6nUghHLLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=Wnr+ew/G; arc=fail smtp.client-ip=52.101.70.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKHAG12+C8OzhOLWIQJ9ShYts8Eqd+AQT0hvDR4e2Bojmrm4yvYNusdGhaKxkqKT7mKk+iMHUpzLim8eLx4UeGiMhCpdaT7AyF+fvLzZR8P1qrKdqk+Tt8f82q4EBhiGwZi6vqdJbwctYyQmDLQzexfOu+VneFcPd9GBkW54uTDt5eUCAC5nwVwf1Wikc10TI+aGaBymkLsONgYPifs9kkjlafAQW6sbWGpa635kK+wIwp0nb+WGCK/ZHtGb+FoTASZvSXIuZsIy01mrpaChoPNqtcdQ3/PR66ZayiIjgoKAzsVmGve/nXHZDVY3uieXjRxjNfHAGc4jEwSNwkRJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDgf6mT058Cfm3rQQwf28ATgs+QyXoHakjwBaoLlQgk=;
 b=RsYcoiJyeXORuAmm81zVJsPJzIPCRT/yaJwCiadvk96H1g/5d5iUBhMVy1bNAkXMhcTdadtYTElvrLXr5ekiVnK5Q7nDpFqrZ/YW/bJqa+wZSN/1Y30HOBiiC8jEU+uyyM4cTc1RBwvvrcImC4cm/ai6YAoSTDnyATGAk+7MCwAgQ7I4HgboY7w+lVBpyIdlrA3wwgKRf2jBKvXG5fPHwyUWFQ9lcy9U7lFTFgFEc3/xhMepyRPM3/gxlmhkVRqDck+GPbb26B1wQ3gMCpUI2zwQZt51B+f8B/MrE9448yxqVFjhnvYL+kVNFx4EYMTd1CPDqmWg0QK0mODhg38YIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDgf6mT058Cfm3rQQwf28ATgs+QyXoHakjwBaoLlQgk=;
 b=Wnr+ew/GJB/MDBwy2Ztqir5HE6fXcskwaIrbHbhgQX9mFK6kCMJfiVLX9ZAeHSLecRjG4xSA/EqF7qMLKWbjNEZ0B5OFdS1wVMWgdekJfEq7HT08KbRD0Xv4LCJ72/QfalcqfQuHpyl11XzrS5j2nGLZ26+z/cv6UjvMvm0O21k=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by AM9P194MB1219.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 08:19:15 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 08:19:15 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Thread-Topic: [PATCH net-next] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Thread-Index: AQHcnOcKItkW6DRmz0WEcytv9y/A6rWEn70AgAC29wOAAAOQgIABLqGF
Date: Tue, 17 Feb 2026 08:19:15 +0000
Message-ID:
 <PR3P194MB1505A3EE2647C89838DAC173EA6DA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be>
 <179960d4-7963-41b6-8c1d-a09376fb0d60@lunn.ch>
 <PR3P194MB15057C0D7A6A99A912B18783EA6CA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
 <9cd71e84-3e2a-41a1-a6d0-875fd354d578@lunn.ch>
In-Reply-To: <9cd71e84-3e2a-41a1-a6d0-875fd354d578@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|AM9P194MB1219:EE_
x-ms-office365-filtering-correlation-id: b22d5c14-2ca4-4e6a-ff9b-08de6dfd3d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vISqXJPXKCfoqbYn4B4qbdRYwnL0u/pRvaYXvqn72YrOTLltisa/dGsRF8?=
 =?iso-8859-1?Q?8xm33J5xncvGHNDiMux3FqBE63AeuMrH6f85bvYJpbs0rAsKGPyWAvhXJ9?=
 =?iso-8859-1?Q?tXVAEtTjXU+1q4+QHNxQcpv5qpSwoJP11uEznC0zAtKy+aRlhQ1ArJA45G?=
 =?iso-8859-1?Q?NI2yXz3VpHGE315hBMQpOAhe1T1VC3X85I/Wep8/wagdxUxnRbdrR901pL?=
 =?iso-8859-1?Q?HvwbfIZaSSFroBYuju63NZoqJRzWcUL8410/lgkEqSH4IIxGtIJu5nWEdi?=
 =?iso-8859-1?Q?UbTuoBYDTZtwvh6gctrIcUTbUaPQZ5hd/TIXeluc3HWPbiF7PkxO6/ni5i?=
 =?iso-8859-1?Q?NhUiJEQrjw9nYs8vxbUMAneXk4YNyLJBX+pDVIGMZA0OZzcDGl7fwKNPXr?=
 =?iso-8859-1?Q?0AfPn3Er488zBVSTs7J0RIMtB1oaIYSat0tpt7zNbeBExuR+qzT6CKjjaL?=
 =?iso-8859-1?Q?th3GVCwNE+Xu2Eu9zL47pvUPUNj3olQKRHB8NYhlcqaRQh5wBrf/mPd+ep?=
 =?iso-8859-1?Q?MJOzQ7qGGA8XTx7mm7QRnTg1R0JNQvQKkBxVtDoFw7sdsPCw3S1YedgQjA?=
 =?iso-8859-1?Q?BGsTVGTZaZPf4OnoYVCzTvr6bsAitCV8VH/ORuj/AZTA0CN1TTV3S3tT08?=
 =?iso-8859-1?Q?pn2SLXlQ72fsOpPT6/eTpDuILvVH9HWIWWSRopePq2RfSmG6FfHKKwRvw1?=
 =?iso-8859-1?Q?nnQURwyl+y1lZQyf5mXv8vYVuYz8QIj3fRbHPgzV547/mEyc6pXAaiQ9Qx?=
 =?iso-8859-1?Q?0NCGthWeSoKnSiwe2XQGt8k5lPquQIPKoZt4UPap/SIiFOCTNdCZ26yTE/?=
 =?iso-8859-1?Q?hUpKUjlw1f75ysF/Sv5iMpYwQ0E+q0lM+yyC9qCGUEqABhumnA09w1+Fa0?=
 =?iso-8859-1?Q?tu/l45athPeC7pZ01HHnfH1CbtB0pb1+NwenBvL2aC7rpa7TQiwki6wEIf?=
 =?iso-8859-1?Q?Dj/JzEhelzYKO2Lhc34LExQI94VZweQlc9NGaJ3HlPrjY7gRlAchVA8BGp?=
 =?iso-8859-1?Q?EG9FO4UK1nGvcpNSa0Pkh6Br6/gXnE7U7l98voFoMrgtWEE+DQP91LvPlI?=
 =?iso-8859-1?Q?2j8/BtQpgAIIrsRKfdwIew5Ln7Csn9iMgbeUrEmk3IEygyVjY/Am4VuyYv?=
 =?iso-8859-1?Q?5an/ts7SIazlEMgUiESuLe5VEnidRsP71RdZFjAy2U6gsZd8QnG4en+mEY?=
 =?iso-8859-1?Q?oKuabemB+eqFX4VxTs1sBYjXJT88lF0CwV5q2KJ3xaQrooEJOsUt/SfWMG?=
 =?iso-8859-1?Q?bVBFF7NC/XPICZTsLoiWKx3bAJKqIOoBlLSdyh6pgvNz0jnibO2MaQl06w?=
 =?iso-8859-1?Q?FdfPmc2v8M2+xkOqHuEEYBG2Fd2N4lckbZ9fupwQaIW4exltSXyqpXxKpV?=
 =?iso-8859-1?Q?xbUtj2Em0eF1/uaAwgCOwfzd/8BmwJgGERE3pmvErKIxobPuwgPnpKmLrJ?=
 =?iso-8859-1?Q?8KNvVEJMEDiTtGK3jLpeYmW3eaH/BLM9vNDkOe+0F2tAMqqDjclwGxq8kR?=
 =?iso-8859-1?Q?YjEIrMDa+yFM1+mBheHHdeiftGhwUiza94FgNpXMGbtiTDpdzElhqwqVMU?=
 =?iso-8859-1?Q?MQDCs9fQgGoH42NFzzCeHnrsbAlQakXcQln2Agls0iJPTnjVKF/5Kuuf46?=
 =?iso-8859-1?Q?QbE2Fwwf7iDLLn3hABQ6SW33ktZmb6RJqZvyIRvS7QSzch9ekeEoqG7o16?=
 =?iso-8859-1?Q?LcNk42ErWyzCJd7wyIA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Wo7Q/jbKmStyzQ5t14U49mdkXwaKHGcZ+NVy0YPlyVWInqn5qi/iKPmxYM?=
 =?iso-8859-1?Q?DVZQoeV7iJKhjdFNIPopelbHXOdE0szOLvm1+bN5P2r+qknw5M3/onrClV?=
 =?iso-8859-1?Q?cwM7L4WRiKoqiIyo4NiF2NRgzv+OHnUXaCyspnhmUtZ6bxiua17ypk1Zh9?=
 =?iso-8859-1?Q?RgkGMu1CORDdBZJyugs8NPOQ51QYGGquOCRndM7l6oKOcAJNDOM2p/CUuN?=
 =?iso-8859-1?Q?XLLMkBPMtawlOLS2gpkDEFXM2fkhG6x8TMaIVGUgh4FJQTiETOB3C2INkZ?=
 =?iso-8859-1?Q?KSzdTHHhKGD4YucZvrutWuB4i0sHKZ12Rt4oF+VEyUZraRR33YyLlroAID?=
 =?iso-8859-1?Q?FFeWX19GDzxQATyU8qMUJRXkTc+thHl8aSq8+3WSKxwWXuohJmF57kptj7?=
 =?iso-8859-1?Q?hSTobuSZrUTazFqBPukHiLfiUzfau5HsSmIsG2vS0nev6En7+p/mWvFPkC?=
 =?iso-8859-1?Q?xNQouD/YaD1IXMmAYmoOdMOBJo2J4p0NjJWT5fjIYRGDnTKGug1ZU0VFLd?=
 =?iso-8859-1?Q?2FDofW/Hbq6tb6ryw0ks+aFIgCKsLZFoCBBD4SrhXUGvZ9Tv7crn68C4Zh?=
 =?iso-8859-1?Q?zbgAJ/YpCsZYTTe9GkFcLRwVSL08+I0IxCrX6p5PFipEzP3MpicITxkcXi?=
 =?iso-8859-1?Q?zmFoYFwiJrr/ZtgmKLeofq9FNNUXlGjyhIjL+ouI4Qx9QLw95TBrk8wfaw?=
 =?iso-8859-1?Q?bZIe6ZXHio1QfTdCFAfYNLpZp/rFWrMumdtZ46u9jWro3OOk6MlwSKkPS6?=
 =?iso-8859-1?Q?TOi5KbhR6q7Z6ordL10+iKXS8/31GM8L5eiARoUt62mwsqEOP52+rInLSq?=
 =?iso-8859-1?Q?wA+/L1SWsb4APL4HwAMyNWPabw6/q+BxuTOWf9o9WdgL1Vhjx4AglPhLG6?=
 =?iso-8859-1?Q?boBPtrgdSq7Dgv9F570bZiDFOOP8RfEi3Pn2LD9VreP6G1eLMfQEWWeUue?=
 =?iso-8859-1?Q?aDwzeHYyAeRif0f/TjpDBos1rshV07+jpMYHO+m4L1OVmx07GemHEK6PAl?=
 =?iso-8859-1?Q?1xNCucF4g1FLKD0CtOZ2RddHNVbKJfOr8bkyCKBoqrXvB8AXxQKSEC7Iej?=
 =?iso-8859-1?Q?RXMvtMeXbUsn3RkbgYO7Y6HdGWVBgt17/876iknx28QSLUjg7zk93m8S8h?=
 =?iso-8859-1?Q?cbeQqVNFCFp8ACY1Bc3FeZayW5KbI6nUwhufw/IQ5MRZugBScJs1DIHGgt?=
 =?iso-8859-1?Q?49XYDb6rRKkW93xbwpUprj3y3dBa+IyTNcCr6PrekJh39ZKS73ITaQ1aMw?=
 =?iso-8859-1?Q?HItZDp8k/Nlr20QiSwd4aVBkjTDU93Kz7Arr7mlolhSf4FVRmh7jeumJMW?=
 =?iso-8859-1?Q?sryx3EOq2a7ezauYB0kC2a6/xLdZ/bfrR2LcuHuL1idpbbKByva/zODPW9?=
 =?iso-8859-1?Q?dVr4mlN0EdvG15LcBdDjsX4vikshxUUepz+BxNXz1WGPDs/mnik8fDX8AK?=
 =?iso-8859-1?Q?BDwaEWKbWzLP2AxUD3g3LSREDre1japQcH1q0WekvCcVqnQDpTosUv1LFK?=
 =?iso-8859-1?Q?ar5FBASQ7PovgYh9+uajXwNDgd8JH9W7IRWY6PMEV/8HV5vfBBrMHRgbAs?=
 =?iso-8859-1?Q?T0I5NU9qkYS+Y96NJnJGCuYYJliK4h+sLrQ23CpjdfXBoYr1mwHm8k4I6J?=
 =?iso-8859-1?Q?RdcqopxC0441c3IDwo49LUkGTHdJ4jIt1P2C9XR7YZtWqyYvTt+KAybgam?=
 =?iso-8859-1?Q?9SA2Jbg/bDE0nesdzDhIaU/yXMBb7lPaamqQxwqpMUTs4OWK+D8im03Q8Z?=
 =?iso-8859-1?Q?Ogbtw87wxTQJgfwEj6P+snEjMARv18Os+vfqM4gPSm0JdX7ynzQTcIIoTk?=
 =?iso-8859-1?Q?RDosdaSYrTmVmtm3eRpbMcP7WPFardCfcCoQpTZ6dSOyOktw4JPguen3wb?=
 =?iso-8859-1?Q?0Z?=
x-ms-exchange-antispam-messagedata-1: Tcr84DAZmoSV4w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b22d5c14-2ca4-4e6a-ff9b-08de6dfd3d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 08:19:15.5610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FYmN/8+NuW3nOFi2wEoMOuYDqovd8Ljw7J7UpK1SvQVEzPSL1rXZDfxdcyjALizPFgWXX0Y8lGQ+bquny+irSqU+CCLS+y8q8bYMisQxjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P194MB1219
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258978-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[luminex.be:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,luminex.be:dkim]
X-Rspamd-Queue-Id: 6A8F5149D8C
X-Rspamd-Action: no action

>> The match registers (pages 0 and 1) are almost identical across all of t=
hese=0A=
>> families.=0A=
>> The only difference is the register at page 0 offset 0x01 is used on the=
 6393=0A=
>> and is reserved on all the others.=0A=
>=0A=
>So a helper to access that register would be=0A=
>mv88e6393_tcam_set_match() or similar.=0A=
=0A=
What i said earlier was wrong. The register at offset 0x01 is not a match=
=0A=
register, but a common register for all TCAM pages.=0A=
On the other families the TCAM operation register at offset 0x00 is used to=
=0A=
select the page number and TCAM entry index.=0A=
The 6393 has the TCAM extension register at offset 0x01 to also select bloc=
k=0A=
and port number. Eg. on the 6393 page2 block 0 is a different set of regist=
ers=0A=
than page 2 block 6.=0A=
=0A=
The current patch doesn't write the TCAM extension register because only=0A=
block 0 is used. I'll add this as it shouldn't assume that register contain=
s=0A=
the correct block and port values.=

