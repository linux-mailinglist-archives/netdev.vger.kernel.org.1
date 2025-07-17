Return-Path: <netdev+bounces-207688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC63B08336
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 05:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE024E1E0F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 03:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380521E520A;
	Thu, 17 Jul 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LkhoDhL6"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022119.outbound.protection.outlook.com [52.101.126.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8A1B4244;
	Thu, 17 Jul 2025 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721629; cv=fail; b=V6T/+l5agLubyuOCbi4oE0/qHejf1h8kCgv/CBAe4Hae1becdR4royy6zQSVdrQ/XUzAaa8p3k9cZLbq1FD1gF3MF7qNMeEguBxXDeFqzHvjb6zjoJfXeMQw3YDfaodMH8Aj0tLWA7KfeaCo6N6m/tqZy6FIJaaRTBjsjj4CdM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721629; c=relaxed/simple;
	bh=J4BtxJPSnYEbJevZUBmY0gdy/xrEr4ADi84uLibmpkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JE0q7svZEDpMPjNzGlMA4ygafOeYaN1S6jLeen0gEZKbXKikkoY8b+ic74EGNJvujuh+eD4T1pTjYspJFaCYnXnf0+P6W2athD37GozpOvi6QdlAnCwc9kceRN53J2D4tpunWOdJVHg1urZVaum/T31uqFm/+JbJDtDsOiNtw3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LkhoDhL6; arc=fail smtp.client-ip=52.101.126.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR580ivfpYAnqgHl2n6Wg7Ho/26t4Ls7WAtUbhGFVv/IehI03y3gISGQwEVuShtRDi6UmKKKNjPKWN7OIpZI2TqsVY+7QFh6TbpRi9XtvVKrNoIxuv8ePv1Cdotqcls0CqqNOU3hFHghZDTLltj2RcODGrTlG5n/p00ZvaglS38y5/jyKpsZ/z660HRd03xUk8zB1IW4tr96HsNRq2Y7oqaZRoo+l1/SoqXPNu8CVnVrlIPqdU4aGHZAfPYdnCO7MAzPa06+g728MDdeCAphmfGA7aviF9H6DcLKPuf2Xd2DKzDgZolDnMLZGoweBjwyNefu/WLd78sLR7Ee3t22Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4BtxJPSnYEbJevZUBmY0gdy/xrEr4ADi84uLibmpkU=;
 b=uKxEhSAfRv5/F+SopSay33PhBDtZbwQk+mZHSajl750KnmsiUfDZo/A3hj1CXvUrflW4UtBp+ieyYPh00GcsHh44PAkcMxPgI0X+7If0FZfCBXqaIq5RJj2aJUX9d/nMv+fn5nYAhon87LswZsjhX9FRYyCVBKl1liw0wL2jJsRrUUWAVXswltAEJ1dHEecE7K7LDttPLRl1HxvWLfwXge5W2mOD2m4G/OOUiNLO4dQ50OLD5xZ2gMvpJJY/g1TH4mOeWBRiHrIdwnvUs+NSldK4Rnzq44e9fT5cCGFX3cW3m/7OvUYAS4TFXHK6R6V8/LooV+1udY6cHWQ8LY/njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4BtxJPSnYEbJevZUBmY0gdy/xrEr4ADi84uLibmpkU=;
 b=LkhoDhL6uGZqNkJSye5WVx9u2bbGu0IPP09/SDUyoC9rKGSzMdj9iAfjuVpKeDXNwdoZR4NDIyoaNemfoehABWkBKGtMqAQnR62UgJGrY7D/cUrfEWcvCsSLsXY5VIRLpP4eoQOCbMsX7ddGu0PXNyeYB5GGZbyY5qP1xmDIOButm6pAie2CCRQ8G5En57bmlXt7XppgDdrkCgjcKMgX0QJmxutWDuVW0d8qGoCUorlCnKsRslr7go4tb2Ott4AkLRbQp06nmf+5j9I1wM8WLXvi5hDRWSScQFCnKWRZ2rYpJBfrbgor/NIep5IjNwgKSZgTX2YKmB7zG2F5r87rzA==
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com (2603:1096:101:ab::9)
 by SEZPR06MB6016.apcprd06.prod.outlook.com (2603:1096:101:f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 03:07:01 +0000
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71]) by SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71%4]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 03:07:01 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
CC: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Subject: RE: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Topic: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Index: AQHb9Igk7vn3xpIukEauwkU1/K0+nrQxUL6AgAACe7CAAQ2aAIAAWoUg
Date: Thu, 17 Jul 2025 03:07:01 +0000
Message-ID:
 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
In-Reply-To:
 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5763:EE_|SEZPR06MB6016:EE_
x-ms-office365-filtering-correlation-id: 2ea3b4a2-1ca7-405f-c501-08ddc4df0025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|42112799006|376014|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CncrsLgqqOquXmfinzt2S0vx8pVChtSwJJ116De8Y6e2/U6v2HImAnUyHD?=
 =?iso-8859-1?Q?zrIXrw8KXLuAJXFGYG5CUuvop3Whn7j9BDRzr5NsWUnDRRkBw4UrwBef0s?=
 =?iso-8859-1?Q?uCU+EOWqnG7E4KGPw1SH6JbPxfam1gJKuL0JTAoUglxGnIaD8Y10EdKAs4?=
 =?iso-8859-1?Q?lkY0QYJSiVFPbQL3eg2UW43LHYAX4edU/wOyE4RWQllxCfiYZllDS0Kxyl?=
 =?iso-8859-1?Q?rxOnv57cKvKAHT8g28ZCwsaqG+ORM7gtxpzOkCa1GSxvKdeZQhMmlOqFtk?=
 =?iso-8859-1?Q?HjEX29p/AsfRgBSUcQdDfMsf9Ey+hJlwByLeYn29rXL2LaHbloqKMLwt5s?=
 =?iso-8859-1?Q?c1b0NwgDxAQ5LCQ2fC1IbuYzGNoFUAqXIbxY/a+znnc/QGGDNseQ8X4Rwc?=
 =?iso-8859-1?Q?UsOBeVPnPrk46wuwcUUv/Y6Y+JQYkhtxWneTDkUcFI+QiUk7/w9+mMpUM2?=
 =?iso-8859-1?Q?IiggJ2O9/8sdWwFxJB15nCm/qnku6c7dOW01zQCWmWzRMz0rjt3pioErXT?=
 =?iso-8859-1?Q?LejE9rhb58PuYnLodjZPbLw/g1H9r0E9uSWX42dHLO5kmiOzuxbhpqme+A?=
 =?iso-8859-1?Q?eqG7CQsKNix9XbQLJ5yuHHP1iCghP5RooQPVRd02s7PjDUp20nSPcOBGlH?=
 =?iso-8859-1?Q?otmbUkEco8QSskdt/Rl/T7jz7QErqMcusm4dhME4Tyz4SeELu5rA6dDd3C?=
 =?iso-8859-1?Q?8oWpyfae3ObqraLhTV7zcs10dG5ySfFnG9IRXJQo3j+pR7Vu20p8bfhY2b?=
 =?iso-8859-1?Q?EYSx60/zF+GW5apuOkHmGjHHYJ7SSYpfcKoJt51KAmF83bVJJHy1UQ0fdy?=
 =?iso-8859-1?Q?SZ3Avkyge3DVk698bV5DZCwzG6txN93qdHvdwbxHmFW9BXfuWhwahi3IUU?=
 =?iso-8859-1?Q?2hEi25hQGcuTJrvFHC5ULQOXINggXi1IinFMCF21VuKAf2ryfwfCHq4WXe?=
 =?iso-8859-1?Q?chOAW7b8y9m0cFyyNpq/isa5aixaesxK+jAqeRjekr9cGTdsGZxPO+xORn?=
 =?iso-8859-1?Q?lzQhl6QD+2Ouq6TZ1AQ/pmlpW720YpD8M1/a+5Qws/rBzovNFkoVx2X7g7?=
 =?iso-8859-1?Q?IxrdgcgLv2LAGQJy4Oqj15NjeZLC841dx3e7w98vuV18Q5wp+2JigSOpYH?=
 =?iso-8859-1?Q?1/qAcuDNlmvS8p+USuNcPhOfNgErNEls54LWl8TAJfW/gEUZymLnkoAi7m?=
 =?iso-8859-1?Q?E/Y/ZNtuVzND8GKdVGD3CBKTvYEDvVE885MRKzNqdK9Ew8zBBw1hzevxia?=
 =?iso-8859-1?Q?5mNFqTDU27CFgSgXtbTTzriTridFvDpYVqt92W1A9PSFeNpSo+czJD4nD1?=
 =?iso-8859-1?Q?GsAk3KQDU7x36u3BdrbLYvOEV2StQWBqE/UWMb/eA8WXWGLyWuC7Ddp90H?=
 =?iso-8859-1?Q?t8I6ER26SW9PS0hwwE2hwFRexvCjP2Ud63z/BGdI4Z3JkiVy5DuiI3Q0DL?=
 =?iso-8859-1?Q?J6+gj2+8zQLR632JNR0pQcM4489NBe9G1pjjRxQm1RpQ4mht3kWFhY522M?=
 =?iso-8859-1?Q?G7giiGKlWwOBb473UZPkxZ8BywQHBx42BZ1gTyyvxvQh3nXT+ZXrjC5tO+?=
 =?iso-8859-1?Q?/1f5s6c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5763.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fba+Hv0yVzsqk+yyBYlEEgPqTNVxeVPh5EknjYi5Rge93Cg2y6yHmFjiks?=
 =?iso-8859-1?Q?d9gkU5gLR6sNLv+xo2DOtXjxNt5QoFGZ8aWtA369U2e5/uG9GIp1jS09mZ?=
 =?iso-8859-1?Q?BisVpgWADlihbagRFbrfQP4SFLJzXqV/2Z98S2xyGjf8mv9yVrkXO8McRO?=
 =?iso-8859-1?Q?Kmxl3z1mfm6BNywDpQrrjEpcUR3Qc9nHwu2JYukzUZ170uTOLCxhlJIhG0?=
 =?iso-8859-1?Q?LUviiUlVRmJ4cnZrLT6mJRfUv7/18s4TKncA35+Z9eoy+ucsKxHJ6o/hqh?=
 =?iso-8859-1?Q?DIjC9tO2JiBnIXdo6+bJ4VnyVveh6QBfs7pvy5SEi8g7E1z/kcsGMJ/7s7?=
 =?iso-8859-1?Q?Cy0QcXXan0861Z1II7z3NfSsaX9eeKl2YupNXY7yZZN66DZrpTH4rT92dE?=
 =?iso-8859-1?Q?i0MJnDiJmqT278DCOq+6QTxJkkQ0YXq3xcbE3fkxas3XxHmFU7qz+k45Zt?=
 =?iso-8859-1?Q?h/guLzEFyqwe++2KoEAPOgn6T3orAM117mZgz7WiMdSu5xlIomT+D6G5yc?=
 =?iso-8859-1?Q?fQy9psBkCW5LMDhm0xXC3BRPlj9JulAtum/hG+SVbDfqcXV4afjou9WvI3?=
 =?iso-8859-1?Q?HN7jdx0XEKXj/51eD9D8plBszDuNLm5fS5F1lpRAYCfogMw0CBoxgEFvGS?=
 =?iso-8859-1?Q?8NUMkdyTPL1cWI7eOydYPNtkGLAFs3RpmhXx+eMfdWhEedIgNE+ZOsClBe?=
 =?iso-8859-1?Q?cN0gMgkMgDuMEbZqw6DYWwp1XnSiL6pSV+yBMix9Vz6CoXlAOWR1zTa4MN?=
 =?iso-8859-1?Q?ik6M31brJcn5KPEPAuPZQ1Kg3mw6+Hyj6/1I0eJ5T5SRK+beHFkeIWaJeA?=
 =?iso-8859-1?Q?dq8qODpSzDactL/Md8DZ58XALRUIIuidEdRzC2MZA55gItxTtGCj0Jfmi6?=
 =?iso-8859-1?Q?f20KLmcMeN9tjNsSa6HmhZiUdpJdYMMDeNhMf1FjC5RX1B9XgYoiWYFHU/?=
 =?iso-8859-1?Q?bLdvEdS4jfDeHNNCSXdkZWz0UH0JTsVt+PYHiZCl94AbrnFc4GRSGCF1lz?=
 =?iso-8859-1?Q?j3zRcxc0+A6H5BuKwfoRYt1cBz4h2Hmh2yqO4IAFuNDfB1T7Ro4irIxVWh?=
 =?iso-8859-1?Q?wdeGt2mGVt5mclMW+t0EiyGqnoIs7q6E+H5M0QT95mYgLemUunUgLFMb2D?=
 =?iso-8859-1?Q?XYdM7MyS7WXFx9/Fvfhu4un3vct3TMlqv3+fOGKXPGp9+n1eNfepW4UBbI?=
 =?iso-8859-1?Q?SgVXdWFAjUV4YjJThVdWCTLLAn2AMgwOv5liRc4Itcu/920J9HP4b7Tx/a?=
 =?iso-8859-1?Q?tUiWI/fRcXKawcyO7FbXcFzopFoOOQnSrn7s0KQO3OO5wTJJuwQsLcbfDG?=
 =?iso-8859-1?Q?c1e/EPiAb1mRZkOxensucW+G3yyrQmpNmCEexoXqPE/95c6HT7bwemlYAU?=
 =?iso-8859-1?Q?1e8AlfFpvUXpKR4NbN+GIYw8iwr2yBZB3ajtE0RMIRV3RKmrNOq/EHNnaW?=
 =?iso-8859-1?Q?sX6VNld8VNM/xy7UNyhi/hoOVxFjFNcooA0UK8y1xJjkDAaA7MJCzEObEn?=
 =?iso-8859-1?Q?19YeqW/IDWHM0ceaBEi4xlUxEeAvbyB1L9OIiY7Rbvo3e5eMDR4ES7O7qO?=
 =?iso-8859-1?Q?FnLK7Hrdt72pJMOjeO9l81FFq/3FKlQA4B0U0L9tIJHfqikw3nvsemBnyt?=
 =?iso-8859-1?Q?SR6sNzhy4pyw9K4VpiVcw/sidot/IaR7Uc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5763.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea3b4a2-1ca7-405f-c501-08ddc4df0025
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 03:07:01.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cj5YRI/Y4egg6FaA+QFAPpag0M2IcMp7UGZGKyPvanBjEUX8Wqq1hR8eQ3Cef1jEWfljS624Bx7+Bs01U9B8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6016

Hi Jeremy,

>> > Do we really need an abstraction for MCTP VDM drivers? How many are
>> > you expecting? Can you point us to a client of the VDM abstraction?
>> >
>> > There is some value in keeping consistency for the MCTP lladdr
>> > formats across PCIe transports, but I'm not convinced we need a
>> > whole abstraction layer for this.
>> >
>> We plan to follow existing upstream MCTP transports-such as I=B2C, I=B3C=
,
>> and USB-by abstracting the hardware-specific details into a common
>> interface and focus on the transport binding protocol in this patch.
>> This driver has been tested by our AST2600 and AST2700 MCTP driver.
>
>Is that one driver (for both 2600 and 2700) or two?
>
It's written in one file to reuse common functions, but the behavior is sli=
ghtly different depending on the hardware.

>I'm still not convinced you need an abstraction layer specifically for VDM
>transports, especially as you're forcing a specific driver model with the =
deferral
>of TX to a separate thread.
>
We followed the same implementation pattern as mctp-i2c and mctp-i3c, both =
of which also abstract the hardware layer via the existing i2c/i3c device i=
nterface and use a kernel thread for TX data.=20
That said, I believe it's reasonable to remove the kernel thread and instea=
d send the packet directly downward after we remove the route table part.
Could you kindly help to share your thoughts on which approach might be pre=
ferable?

>Even if this abstraction layer is a valid approach, it would not be merged=
 until
>you also have an in-kernel user of it.
>
We have an MCTP controller driver (mentioned above, which we used for testi=
ng this driver) that utilizes this abstraction for transmission, which we'r=
e planning to upstream in the future.
REF Link: https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/d=
rivers/soc/aspeed/aspeed-mctp.c




Since the PCIe VDM driver is implemented as an abstraction layer, our curre=
nt plan is to submit it separately as we believe the review process for eac=
h driver can proceed independently.
Would you recommend submitting both drivers together in the same patch seri=
es for review, or is it preferable to keep them separate?=20

>> > > TX path uses a dedicated kernel thread and ptr_ring: skbs queued
>> > > by the MCTP stack are enqueued on the ring and processed in-thread
>context.
>> >
>> > Is this somehow more suitable than the existing netdev queues?
>> >
>> Our current implementation has two operations that take time: 1)
>> Configure the PCIe VDM routing type as DSP0238 requested if we are
>> sending certain ctrl message command codes like Discovery Notify
>> request or Endpoint Discovery response. 2) Update the BDF/EID routing
>> table.
>
>More on this below, but: you don't need to handle either of those in a tra=
nsport
>driver.
>
>> > > +struct mctp_pcie_vdm_route_info {
>> > > +=A0=A0=A0=A0=A0=A0 u8 eid;
>> > > +=A0=A0=A0=A0=A0=A0 u8 dirty;
>> > > +=A0=A0=A0=A0=A0=A0 u16 bdf_addr;
>> > > +=A0=A0=A0=A0=A0=A0 struct hlist_node hnode;
>> > > +};
>> >
>> > Why are you keeping your own routing table in the transport driver?
>> > We already have the route and neighbour tables in the MCTP core code.
>> >
>> > Your assumption that you can intercept MCTP control messages to keep
>> > a separate routing table will not work.
>> >
>> We maintain a routing table in the transport driver to record the
>> mapping between BDFs and EIDs, as the BDF is only present in the PCIe
>> VDM header of received Endpoint Discovery Responses. This information
>> is not forwarded to the MCTP core in the MCTP payload. We update the
>> table with this mapping before forwarding the MCTP message to the
>> core.
>
>There is already support for this in the MCTP core - the neighbour table
>maintains mappings between EID and link-layer addresses. In the case of a =
PCIe
>VDM transport, those link-layer addresses contain the bdf data.
>
>The transport driver only needs to be involved in packet transmit and rece=
ive.
>Your bdf data is provided to the driver through the
>header_ops->create() op.
>
>Any management of the neighbour table is performed by userspace, which has
>visibility of the link-layer addresses of incoming skbs - assuming your dr=
ivers are
>properly setting the cb->haddr data on receive.
>
Agreed, we'll remove the table.

>This has already been established through the existing transports that con=
sume
>lladdr data (i2c and i3c). You should not be handling the lladdr-to-EID ma=
pping
>*at all* in the transport driver.
>
>> Additionally, if the MCTP Bus Owner operates in Endpoint (EP) role on
>> the PCIe bus, it cannot obtain the physical addresses of other devices
>> from the PCIe bus.
>
>Sure it can, there are mechanisms for discovery. However, that's entirely
>handled by userspace, which can update the existing neighbour table.
>
>> Agreed. In our implement, we always fill in the "Route By ID" type
>> when core asks us to create the header, since we don't know the
>> correct type to fill at that time.=A0 And later we update the Route type
>> based on the ctrl message code when doing TX. I think it would be nice
>> if we can have a uniformed address format to get the actual Route type
>> by passed-in lladdr when creating the header.
>
>OK, so we'd include the routing type in the lladdr data then.
>
Could you share if there's any preliminary prototype or idea for the format=
 of the lladdr that core plans to implement, particularly regarding how the=
 route type should be encoded or parsed?

For example, should we expect the first byte of the daddr parameter in the =
create_hdr op to indicate the route type?

>Cheers,
>
>
>Jeremy

