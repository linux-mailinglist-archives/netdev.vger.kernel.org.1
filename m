Return-Path: <netdev+bounces-205270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F2AFDFAD
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBA84E79FA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840726B2B3;
	Wed,  9 Jul 2025 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="E6DnpN4C"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023080.outbound.protection.outlook.com [52.101.127.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAF26A1B8;
	Wed,  9 Jul 2025 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040341; cv=fail; b=bpUjN6OBPfQkm9SmPVNJXd2/uPQTcrP/8/hmQehhXvq9y3wVwkATCVoWrKOCdpbGe/2NAxGn9QnZu+/GZQsvmRezyQjIEkqAk9EdRfcEJ315k+j/E5iCLJNivzPTnb7Qpo91rVzT4n80OfKuF14jm9Q3BLBPZG/ZLFJRhfaoVfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040341; c=relaxed/simple;
	bh=nSlp1RWUstG4DvNHu/IWL4ECxPKNefnqVzVWfcq5gIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVUizCqIcWL6Q3QRbBBhgEoMj2h90eDRc8P1PvY+8QT9pRdWF+vKD9oygLcdqYplVkVsdyV26VJWA9RfJ22Fscj+yDMm5A5chGp2GySc/vjGYVJumnktHLoPtknN1E/YFRvQFxruF3WJHxK8WuFXdPNYygp6wTF7ELzUh0rjxpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=E6DnpN4C; arc=fail smtp.client-ip=52.101.127.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9jlYPVxjQoXeHRGIqGF9SMZltkLCurCL7jhxro+TK+9AFUQ/GCdvWlx7tn4kwTvOqLJbAdHapmcRnBRi9gqbhTmYia5wKXfRwe9sqKBZJNuwAXuKzK83v81etTSSjMSdP4wO5AIcfpyzlP6zl2bwqfV9irqcYNNxx2QrobXfHxysHn7q/7l/oxVocoMkcal1hE/FGALe79esGLdAlrLk0BoXyO1SylNly/nT49ezmvp0/1Xe+AUMnsVYBFqAvIJWsbUmOTVQPTI2E8FjdZPfWe7zvZI4xK106IYf3qDNQghp3X9vO/MnYShwCLi+XMleYvJHeWdagwskLKrmVWt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSlp1RWUstG4DvNHu/IWL4ECxPKNefnqVzVWfcq5gIk=;
 b=UWiRQoD6Oy1IbLS0Ay4vDatkJwDutEVYskpgKN/9vT00GAfvs8srZlziiHtaCW9WkIYsLPCsQvB2l73J8yqPRZ/vU2YviRCXCiFVbUw45qDGr6K4xLpzt/B7QmdJZ3gVifaLh2kM0yeyy9k+ds6cwO84bQDhFcl2znkA7zJ1gcanSvMpVhK6lCAi+jnD/e4UbK6f+H0pxImyicHw5RNjeHHQ1WGLDEunyib1k0jGyTN7uzwK0bbXOjTICfK/wUMFxBO2i4+xnMKHMBymhICYix3fQcjxKW+Qp64a1as3YEl9LEffVKDaH6TpwWqfBhOb6lMVwcVqHEQVcq8BOLBgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSlp1RWUstG4DvNHu/IWL4ECxPKNefnqVzVWfcq5gIk=;
 b=E6DnpN4Ce0GGezUoa7RX5mZtDpJMFGVc2XwbLn4/rlTwXp+TYCD37YkB4+24WtMFYUh/P+fHJgeVxUpv1OVjBgFLdRH5taTCvA7GQJ+OrPtxRjsZ3u7tBYkJcMLFCGajTmAHhWDtUhKdm5AajiRocU0Go5VveMNXlLINfID/Eg3L16mTNA7l9b0Jjzm7uzw5S8r0JkwAJf5NgT8ppjYs8epKGVSr5fOwbowFVJd4gCvimElQaDgOhYkJIQ6VPNo3KCoV4+YpFsJ/gKe8FG4TcsxEALVkZyaefm2q7MDe9wYwWc8Lmpmrw1NcuYb3jkJ9mF1n9lLjuuXaX7ontH6REA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PUZPR06MB5585.apcprd06.prod.outlook.com (2603:1096:301:e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 05:52:13 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8880.030; Wed, 9 Jul 2025
 05:52:13 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "horms@kernel.org"
	<horms@kernel.org>, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgdjMgMS80XSBkdC1iaW5kaW5nczogbmV0OiBm?=
 =?utf-8?Q?tgmac100:_Add_resets_property?=
Thread-Topic: [net-next v3 1/4] dt-bindings: net: ftgmac100: Add resets
 property
Thread-Index: AQHb79VYxPPwK2BAv0q9ZSrtr3u7p7Qn2iUAgAFwN8A=
Date: Wed, 9 Jul 2025 05:52:12 +0000
Message-ID:
 <SEYPR06MB51349252F19C2742CA1E369C9D49A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
 <20250708065544.201896-2-jacky_chou@aspeedtech.com>
 <20250708-termite-of-legal-imagination-826a9d@krzk-bin>
In-Reply-To: <20250708-termite-of-legal-imagination-826a9d@krzk-bin>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PUZPR06MB5585:EE_
x-ms-office365-filtering-correlation-id: 47865810-f424-44fb-df93-08ddbeacc07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3FMeTRDNU1ZU2hiSjlyV0hxVmJLeWtiY1NEaWtOTXFjc0djeFczUVlXZUta?=
 =?utf-8?B?NEwybGFSKzFqb0FjZjdJUVNQMHB6MjBpcXdFc2hva3JWTlRIaGpjK3hFTkw1?=
 =?utf-8?B?aVB1dmtGbU9RY3ExQkN2S1hJcm16bUtyMGtJMFJacVg2YnRKTjQwQWlTRXNT?=
 =?utf-8?B?OTJ2dmJnR213eGp4L2FScHMvTGIzRmU1RUwxTDZxckhFOHNIMmkxTFlUSnpL?=
 =?utf-8?B?SzMxNzlHR0tQaE10WGFpSTVxdnVKZzBOM084NWFxc2Z3Y0lMMEM1Uzd5bm9p?=
 =?utf-8?B?MHBNQlBjcHFWMW02b2VDbUhvSlgxblhxWWZ5L1I2c0pWSXlxQVFEeFFvUmJF?=
 =?utf-8?B?RHJGT29LczRubmM4QXNxVEd4SDgvSGhVQUc0ZU1nc3NUZ04zYWhTOU5uejQ5?=
 =?utf-8?B?QncvU3lnc0QyUmxObnFpTTFSV2R4ZG9la3dDTFV4enRMbGQvR3Rqb0Ntbksv?=
 =?utf-8?B?K3FFYWE4c2JOYURhakl0dVd6TFI0aG0wSEpwS2VLeDh0cWs0eDNjREZvQjRQ?=
 =?utf-8?B?TVVhZXMzSmVLd3pKL1ptb3RpdnpZSHlHSzR5U0kyQklqc005OWlUaGJWMkxv?=
 =?utf-8?B?ZllrcklwUnFxSExXbUNuaXp5Y04reVV6Wm1jUk8zNU9SbHVpRE54c3R1TG5h?=
 =?utf-8?B?dldBTFlzNHhEN3pSQm0rbG5qN0F0YkFrZGpDQm0zbEVkMjhEbE0rWFd1QzIy?=
 =?utf-8?B?OEg0NzJRZnFIUkErTlUwMVZ1bGErWklyUmwrb1JUU2dCdytiQjdrK2FrZHMy?=
 =?utf-8?B?MEdKUVVBWUpna2U4bkNHV0ttNkwzUlNQODRsaitLai9JQ3JYQktKLzd6YTZW?=
 =?utf-8?B?UWRBNDFGSFdMUkpvWUxZL1dvYTBDVE9pSkl1M2ozejI4Y1IybkUxdFVid3Zu?=
 =?utf-8?B?NmwxU1F6VmNlQy9rSXJHNTZqOWd4RzFtYTNFRmpLN083VGp1VzREY3ArSTd6?=
 =?utf-8?B?M2dMaUtnU2V2ZEs3aWVtaDV5Um85MHZsZ0dRR2RZMFZLRWZMQTJ2ZXJ0ZVcz?=
 =?utf-8?B?ZVZ5OHZJeUlEUzdTd0ozVUExZDFtNFlhN052WXBaTXdacFdtTUZKOUNjaXZq?=
 =?utf-8?B?L1FOeGtUVE11Y0lhUXgxUWQ3VjF3Y04zbVdQVUM1SXREeVVYWkF2TzV4ZWdN?=
 =?utf-8?B?djJKNG9tT0dUbWVYa2pnT0FZM3lZNFdFNFVneUlXWGEwa0NHQVgwdlN0cUdu?=
 =?utf-8?B?NjBZcVJ4Q1k5V2EvdUZxdTJQdEpNcjZrU295M0k4aEVIZGxnSmN0Z0hIK1BB?=
 =?utf-8?B?TXlOYytTV00xa3lJRG5kRHdvUDQ2UDIrK2tjc0V5WUhzZjFUTjFoa3V6aEhu?=
 =?utf-8?B?aDZWN2dpdHZaRHd6R204c3R6ZXpUaUNWSmdKL0ZYNXo0eVV3THZGMTl4OXVk?=
 =?utf-8?B?OU91M3VXMWYyazNoRTJkcXVKLzFneE5hRVJveENwenpvR3hGbDVyY3p4WGdj?=
 =?utf-8?B?aEVYanA5QjJicCtkZmtsOWRROUhTNEZ0M1d5cVVFdHZ5dUdkSnRUdjgrWFB1?=
 =?utf-8?B?b0VGZFNSVWd4ckR4VjhoeTVHZGk0Rno5SXR2RGpHWENpLytlOHM5TFVRKzB0?=
 =?utf-8?B?VG5XcXhmVS9TSDB0dHZGL29ZTlBwbGdJK2Z6TDRMY0Z1TlNQM0I5YjgvbHV2?=
 =?utf-8?B?YWtlMUdVczNGSENzTUQ5QW00QzNvL05DaUJqTm8zVWcrMXl1aUJySUFUdXBP?=
 =?utf-8?B?a283cVJLRWdmdzdxYllJS1EreTBDdTg5bFhXbFllOEhISnBVdEVlY0E4SStW?=
 =?utf-8?B?cncwblBVcXg1Z2lqb0Y1c2crN2ZXOXJvSzNSY3pHblVVQ1h3NUxKSlRON3Zy?=
 =?utf-8?B?R2o2MTVFd0wvUEdXVGFKanNhbGpTL1J6SXJBTE9qL3VSdThaaU5GQll4QVBE?=
 =?utf-8?B?ejVyR0tqL25pYTNmL042SXhpSW4vRkFXR01hZnpTTXQ3MWN1blo3M0JaZjlU?=
 =?utf-8?Q?jDjvUqVudII=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0FQamgrazZUTnFXTUUrQW8yYnp6TWppc2c2NEVIb252TVBMb3BFWDNGWE1N?=
 =?utf-8?B?THpYcFRlVVpGbGFyM08rTTh4aUZFazZqeDdvcmFkSjRWc2IzU253Z2hISTlG?=
 =?utf-8?B?ZzB2TWI3MmZ4Z1Y0bXJObWY5a1FwWkIrcTdGQitwSkc1YWJlL2k1YzcxeCtv?=
 =?utf-8?B?VlVTb1ZOeEsrK2E1VCs3Z2Vqd05JekZPYzNQZXRra3lKVndRUVRrdnB1dnFx?=
 =?utf-8?B?eDVVcTZxR016T1hmazlSTk4rSlVTV1hIbHpuY1NKTXVITEZtQ0FQZXFWRWY2?=
 =?utf-8?B?WERKOFJsVEQzMzRnV0N5d2xIS0JvU1RnYVdQOXkwRUZDZ3o0ZTZvOU9tNE1Z?=
 =?utf-8?B?eU4xUjREQURreVlIWEQvaWZIeGhrMnhrRXhDclg3QWJkcVF5NXZpRXkxblYx?=
 =?utf-8?B?Mjg4NjRXQUEyUmhwaEZIaDZSdDd2TGRYSlRhaUVHdmxoR3kwUEJIOVQwS1M4?=
 =?utf-8?B?QzM1NkMyRjdYcFBOUkwwRU9NZHZZSzA1NXVreVpDeHFSb1BISWhBei8vb3Bo?=
 =?utf-8?B?UG9pUUx3d1Z0dmFmUEg4aThYZjRsbDkrdW5IaTZhYVhncHYrRi8vSVRlczhu?=
 =?utf-8?B?THRCZTBINTI1ZjRGZWdRUC95TWkzd21hdXNKdzhuU0xYRlNzSHd0clkzR0tE?=
 =?utf-8?B?TllQSG9Scm13R2FGck94dEtKMEd5RWxsaTVjemZYSVVwSU0xTzQxSHdXWDNw?=
 =?utf-8?B?MWVVbXZxajN2UUZKN1FidGxBUUtPelU1cnd6ek5LeFlyenMzbGRPVnBJSWtw?=
 =?utf-8?B?U3ZtV0tvUE5nbEduemNEZHRQOHpEODY1RnN0K3A3NVZQVk5Vcm9TVi9SVE9H?=
 =?utf-8?B?V0NRWU9zcEF2Y2pOY0tURmE5OFlVQS9xK2hIOVBXUnMrQUw3SVk4TFN1R0Fn?=
 =?utf-8?B?cC9FUFY2Y014WEJpNWlXbDRTcCtQOEdUaitvdDF0WFZya1UvMWJwTXhoNUxR?=
 =?utf-8?B?VUVwL0lHZVp3MW54UXN0UEVEVTEyWkJNYmxqMzlxT1IzbFlWeE93M2N0ZzhI?=
 =?utf-8?B?T1VENE90emVzMkhEKzhmNS85QmtFNjR4ZmZUQk8veXN4N0c3VVlyTFU3STJI?=
 =?utf-8?B?RkxvZlZ4MThPR3NPcEplSS9pci9LUFdKaGxjMUtndFVTSFlkWjcrVFZXbEdW?=
 =?utf-8?B?Q0FoV0lDME9yVWhWTkw3eFhUczVYZUhHdmdLNDVyU2tiZlBTbXJzRWNYRXVP?=
 =?utf-8?B?QUFFMDUybzJ3Wk84ei84SEJIWHBIQTdaWWFWUzZnQVlmbG83Z2dmaVZ3L1FZ?=
 =?utf-8?B?M3JOK3BlZGlSUGN0cGpaV2U5NWszZUFjTm1NVDNhR3JQNXNlZ2tpMHNrWDFy?=
 =?utf-8?B?a0ZBd3hvQzhWVjBLTWFZMW9ScWR3NzhNdDFnK1V3TGJsbG4rTnZqM09TaENj?=
 =?utf-8?B?alZSSmx0Nzd3RW41QUcySUorREZZd2U0NS9uWURQYTVuOGpVd0ZYUnNoNDdi?=
 =?utf-8?B?YW5hWW45eDFpOXNCSWJnNDN1N01EcTgwcXNQL2pwcXZHMEIrMWJKTzdua016?=
 =?utf-8?B?UVBHNW1uVGRoR3pMWUxrSTNjMkM3SFFLeGRkMlZFemFrRXdmM1VydmVSRDYr?=
 =?utf-8?B?QzA2cTVOTzF2QVhZV2pHbytQSHFBV3NaWDdFZ1ZJTmFEclB1Z08vem5xVDRD?=
 =?utf-8?B?YnE3L3NlVGVhc3FsUG5WaGw5Ym1EOFY2UUpLUVYvcEszYXZoVHVNUUhBM1do?=
 =?utf-8?B?amhrZDJVU1pqZmE4Q3VqVkIvbHZHOU5JTC9lNzgzOTg4ZGhoYjRsUGhwSEx2?=
 =?utf-8?B?SHZYaEV4d0dSSUVqNmU1eEc1cVYvNmR6cnFiYnZXK0ZRdSs1RW5LU050ME9i?=
 =?utf-8?B?b0dWdmh1STFDZVFlYSt4Vlg0eUpwWkQ2Wk5yV0dadDlCTnhwQlQ3UTBXZHJs?=
 =?utf-8?B?RHpnOXNYWFdXZi82THEvZkJRYXdzL0ZXNXkxQm4vWjVReDIwMXlTRmhxMUlQ?=
 =?utf-8?B?VzZpc09KRnFaOG03a1Y2ckJ0Y0p4ZDFMQi9KZnV5UFNBUHA5MVcwZWFGVmdl?=
 =?utf-8?B?RjVJcGlhK1Z0c2JTNkFsQTZCaU94dm5zU2RXMkM3eGpDVWpiY2RtbWNNWXB1?=
 =?utf-8?B?OGFtdFJjMWk0OVZTR0ZaMjMzb1U4TjIrbzVlRzBEYnpCREVhdlRlOEg3Tit1?=
 =?utf-8?B?RGdXdmM0cDV1SytiZVVHeXJzMlFhTVRYbytrcWRKTHVJSEFNYzFkSXI1Yi9G?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47865810-f424-44fb-df93-08ddbeacc07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 05:52:12.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/IF5/ZRNpxkBVUTq/OkgYTDMN5uSepdQrP2fHsdAnY8FgIMwlC33KlfytrL15jxXD3dYrhrHMUBblWKEYgjudevyQJG83MP890yVUUPT3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5585

SGkgS3J6eXN6dG9mDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IEFkZCBvcHRp
b25hbCByZXNldHMgcHJvcGVydHkgZm9yIEFzcGVlZCBTb0NzIHRvIHJlc2V0IHRoZSBNQUMgYW5k
DQo+IA0KPiBzL0FzcGVlZCBTb0NzL0FzcGVlZCBBU1QyNjAwIFNvQ3MvDQo+IA0KPiA+IFJHTUlJ
L1JNSUkuDQo+IA0KPiAuLi4gYmVjYXVzZSA/IEl0IHdhcyBtaXNzaW5nPyBJbmNvbXBsZXRlPyBZ
b3UgY2hhbmdlZCBoYXJkd2FyZT8NCj4gDQo+IE1ha2UgdGhlIGNvbW1pdHMgdXNlZnVsLCBleHBs
YWluIFdIWSB5b3UgYXJlIGRvaW5nLCBub3QgcmVwZWF0aW5nIFdIQVQNCj4geW91IGFyZSBkb2lu
Zy4gV2hhdCBpcyBvYnZpb3VzIGZyb20gdGhlIGRpZmYuIFlvdSBhbHJlYWR5IGdvdCB0aGlzIGZl
ZWRiYWNrIHdpdGgNCj4gb3RoZXIgcGF0Y2hlcy4NCj4gDQoNCkFncmVlZC4NCkdvdCBpdC4gSSB3
aWxsIGFkZCBtb3JlIGNvbW1pdCBtZXNzYWdlIHRvIGRlc2NyaWJlIHdoeSB3ZSBkbyB0aGF0IGFu
ZA0Kd2hhdCB3ZSBkby4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFja3kgQ2hvdSA8amFj
a3lfY2hvdUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL25ldC9m
YXJhZGF5LGZ0Z21hYzEwMC55YW1sICAgICAgIHwgMjMNCj4gKysrKysrKysrKysrKysrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4gaW5kZXggNTVkNmE4
Mzc5MDI1Li5hMmU3ZDQzOTA3NGEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1s
DQo+ID4gQEAgLTYsOSArNiw2IEBAICRzY2hlbWE6DQo+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+DQo+ID4gIHRpdGxlOiBGYXJhZGF5IFRlY2hub2xv
Z3kgRlRHTUFDMTAwIGdpZ2FiaXQgZXRoZXJuZXQgY29udHJvbGxlcg0KPiA+DQo+ID4gLWFsbE9m
Og0KPiA+IC0gIC0gJHJlZjogZXRoZXJuZXQtY29udHJvbGxlci55YW1sIw0KPiA+IC0NCj4gPiAg
bWFpbnRhaW5lcnM6DQo+ID4gICAgLSBQby1ZdSBDaHVhbmcgPHJhdGJlcnRAZmFyYWRheS10ZWNo
LmNvbT4NCj4gPg0KPiA+IEBAIC0zNSw2ICszMiwxMSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAg
ICAtIGRlc2NyaXB0aW9uOiBNQUMgSVAgY2xvY2sNCj4gPiAgICAgICAgLSBkZXNjcmlwdGlvbjog
Uk1JSSBSQ0xLIGdhdGUgZm9yIEFTVDI1MDAvMjYwMA0KPiA+DQo+ID4gKyAgcmVzZXRzOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBPcHRp
b25hbCByZXNldCBjb250cm9sIGZvciB0aGUgTUFDIGNvbnRyb2xsZXINCj4gDQo+IERyb3AgZGVz
Y3JpcHRpb24sIHJlZHVuZGFudCBhbmQgb2J2aW91cyBmb3JtIHRoZSBzY2hlbWEuIEl0IGNhbm5v
dCBiZSBhIHJlc2V0DQo+IGZvciBhbnl0aGluZyBlbHNlIHRoYW4gTUFDIGNvbnRyb2xsZXIsIGJl
Y2F1c2UgdGhpcyBpcyB0aGUgTUFDIGNvbnRyb2xsZXIuIEl0DQo+IGNhbm5vdCBiZSAibm9uIG9w
dGlvbmFsIiBiZWNhdXNlIHNjaGVtYSBzYXlzIGl0IGlzIG9wdGlvbmFsLg0KPiANCj4gV3JpdGUg
Y29uY2lzZSBhbmQgVVNFRlVMIGRlc2NyaXB0aW9ucy9jb21taXQgbWVzc2FnZXMsIG5vdCBqdXN0
IHNvbWV0aGluZw0KPiB0byBzYXRpc2Z5IGxpbmUvcGF0Y2ggY291bnQuDQoNCkFncmVlZC4NCkkg
d2lsbCBhZGp1c3QgdGhpcyBwYXJ0IHRvIG1lZXQgc2NoZW1hLg0KDQpUaGFua3MsDQpKYWNreQ0K
DQo=

