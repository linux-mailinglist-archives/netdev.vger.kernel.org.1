Return-Path: <netdev+bounces-233098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD5C0C37B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B0C189B1CB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C442E5B11;
	Mon, 27 Oct 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QXciROeI"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E0199FAB;
	Mon, 27 Oct 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552192; cv=fail; b=hzNrx61C9JQ8r/d592QojER3GMRrT6Lj2C0Rkx9HqVaIo29QKW/a+QGCKoZo1NSdMDZBYZP/UgSqJBWXxcqe35yCWV8Bu28rOm1cfnN24Ej9eUrxMhxTJihPly/x35pr0Sk+aZiPVwaw6ZTeoo2AsNEaP+BJFMryaTiMh1dut6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552192; c=relaxed/simple;
	bh=SvRNCdBrAEITq3WqlNwxaGdDFGFhmGiaA85qhy/U398=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R9X14kdVtwUIbTwAQ7lANUx+s5WE8PEYoxOSvX0+AswMzTS+6d26b4CwlRwT+Wbbe0o9K7O88JbmaIY3gurK3iuhtUkrMExfpYwghf23Io6FSRpJP7+2f9N68A8mJjBvvfEJk1IlAT2v0bhLfC5K5nfzlA8tkaquXXB+s0TfhTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QXciROeI; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww/UPojcQwk2WJXdVits/LM+Fx+eQltlyXMNXdFE8zDxBe9Pjh+wsJJSEDUlRX3GlRehgy7ukV+sJ9Mzr+wehvkX8EbXaIJ+mOSR5kIVTYHj+sQqMBv7aqYS4SA6ZHI7pV3R7KGovGnPUeA07rEGAlVkqo+HAet2gRFMB24GPCfhwhZgMUYd15oa4ZtP8ts+KjyHz07ntgRLrtoHLsOLJXjHUr44tvZBCJBPRNHMqUd4l03CFjWwCw6TuaD7mnBMZd3Ilznaf9vTC6BiZogqPZHYfiq9v/ZKIyomZbYJyWoSIB9iQixDolVE6F+vNqKY4PeQHb3mwfwGhjjxCWr0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvRNCdBrAEITq3WqlNwxaGdDFGFhmGiaA85qhy/U398=;
 b=qW9GSwb5DVfb837vsWneCW+LLDDEwWvdnfEiv+jvS81bQeTko4wkWhI79aiXmIyrv2oDz5STiGBhiCLD/7fMdWst477VmrHLC1FpRp/ECg6wLzdCgGgOUev10sTuVWYmQz3XVeND99zH4w5k4prqRB1tRFt38nZfc108DRXG4XX1BlznqYaKDiCNjKXgODZwzqDvBgTKKtYRq11n0Xeze9ct64MaBnAn20PnKoJS4R8Aew+px3FJv9+yC2eIJQL/dWZuNYel1o7tcBp3phZDN/vA49MxbWVMOCvsQs/66cT+pnEuejbugExScjOO8Dj6oWqFE5icSRin5lted1WgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvRNCdBrAEITq3WqlNwxaGdDFGFhmGiaA85qhy/U398=;
 b=QXciROeIpW3C+psaknVCyFR19uSM/DXg6PPmtR/5fVA16OfUPfjEO3rd/hd5URAgo00vYytIrMDB/fRNZjEs199D4QMtJpXDwkc7OpFK/jzI18Hpvg1H8xoQz77gqMcqXQrLY1H3ZxO9dqvBvddEDbH46JSaaWT8X4AEtUEMU6ZOEhGJalCxbLbz+ZBkQfeNSWM4wKv1jb2TLEFeLcVt8KGjUPSHGZ7jHtoBe0u5QlGWlV+OXmqOqUghX7CddODd3zKmEl488mhcjMzNLXO+SEJn/o9om5hmD3fvv6kclsTqdNylLdIcMZ92VV8XDaHvHlat1Nb9ZXAwmCBiqI2lgQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB7804.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:03:01 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:03:01 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 04/12] net: dsa: lantiq_gswip: set link
 parameters also for CPU port
Thread-Topic: [PATCH net-next v3 04/12] net: dsa: lantiq_gswip: set link
 parameters also for CPU port
Thread-Index: AQHcRtJ7wehBEejXskyx9rf9skBV9bTVopOA
Date: Mon, 27 Oct 2025 08:03:00 +0000
Message-ID: <bb3692adfc83161007d82d899b45ad0ee8b6d0a2.camel@siemens.com>
References: <cover.1761521845.git.daniel@makrotopia.org>
	 <833c9a9a0cc8fca70e764f13035da4d1444a0805.1761521845.git.daniel@makrotopia.org>
In-Reply-To:
 <833c9a9a0cc8fca70e764f13035da4d1444a0805.1761521845.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB7804:EE_
x-ms-office365-filtering-correlation-id: 35e02823-999f-4366-c7e8-08de152f3fd3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHZBWnYzUGNwS05OUit3MnA5d0VtbkxrYlJJVWZONmV5MjB3MVYwaXQ4bm9i?=
 =?utf-8?B?Z0hpanBLWVNLeVhLMUpIaEQwVGlDN1pUUXlNU0c5eEp1QTZHNE0vck0rcDF5?=
 =?utf-8?B?NzdXSnR0cVBLdGIyZWdwUTh3UStVYVBDQzZzbnNiZTRpOHRqUVJPMkc1T0N0?=
 =?utf-8?B?UkFmN3VSSUM3Uk1BU3l5SjliTFZKY3VFTGN1cHpKK2NDUmNtaFlsMEhPbU9T?=
 =?utf-8?B?SFB6NGFSM00yWnRJNUx5Wi9pcWNXNDBtU1JsYnp3Q2R3SzR0eUViZXQ0WHIv?=
 =?utf-8?B?U3RlL0xNaUZBdlpoMnJoajcxYnRxTTl0OVBIZ3djWDRXeDVKZFdZaE9CdkFx?=
 =?utf-8?B?N0lYQWdxb2kveER3cnJ0c3Ivbm5qZG8zZFBhazYvM05GM2ZtQzB6QWhoUTQ5?=
 =?utf-8?B?UmRCZnAzR3JhQUhndG12cnZUY2l3M0RRV24rMmcvQkNpZ3plcFc3R2FDUTFz?=
 =?utf-8?B?UE4wR3JqcGhSNGFpUjRKeEhSc01NYThVT0tIdGxiZ2JuRVI4ajRHMkQwcm9n?=
 =?utf-8?B?cmRScm1aQ0dsM3phc2pySjExUmYvRG1uVjl0QVpNUGYrS05OL2JYNGFWMlRx?=
 =?utf-8?B?RGZ6REtYZGs5VFB3SVQ0akZySzluc2wxdU1YcWxKOVlleVBKSk1lc1RrWmkr?=
 =?utf-8?B?Q29WRytCMUhvUTJZclZQZDg4S2UyUk1TZDVRTVhTS0FXVGtkVXRjWVJTYWJS?=
 =?utf-8?B?SmRYSlJYNVIwVlZMZ04vSWNQLzkvRnBCN2o2dFN6aVhyTThId1hYQUJ6eTJk?=
 =?utf-8?B?dC9BZHZTK2I4Z3V5Y3pKVWNNZzdENVk1bW5QRElpQTVuSVhZNkNNYzQ4MzJw?=
 =?utf-8?B?Z0dlVGZIMnV1eitFeHdXVXhFekhrajZ1eXNZWWxvSEIxUGFZU0FqalRmckxG?=
 =?utf-8?B?aS9sNjVMUHBWRjB1dWNOdjVPL1NEUFdBTmxDem16MWh1MG9tWUhja3VCTDJo?=
 =?utf-8?B?bzJmZDNIUFdnYml6c3ZYZmY1M1htWFBFUnA0VnYxcTdqVzk2SGVSdWZWWW1p?=
 =?utf-8?B?LytqSTdENE53MndTaE02Sm1MWVdXWDRZVzNjZEhTMFFsQWVzR2FxSnpiR3B2?=
 =?utf-8?B?L1FrbytyZnliZGtFYUo0RzZKR0J4SFNhZldOSytnL0NvY0s0UDlxbE84ZkNa?=
 =?utf-8?B?MnNDbXN5UGdieXRvTGtCejRIK3pEd2ZFZm5qUjFHUFZncVBVcXpheGRiZjZM?=
 =?utf-8?B?TUhBbTV4UG5mSVVKWGprT2V5eFBHWFI0Zy9zYkdqM0gzNzhYR01adHA1cTVK?=
 =?utf-8?B?RlVCcWJBc0s2WFExN3lwSi9Pa0VhcGFOT05FdjhJWDl1MXlXNW9KeTRCaU9j?=
 =?utf-8?B?MW5vdGY5aHNBSmdHTFF5WkRqR3RLTXRZMGN1eVRickhIcTBNckpkMW1hT3la?=
 =?utf-8?B?bkNmaG5kZy9BQTNUb29hNWUrUUt2UVVRWjJ0VVBZd3E2VGE1SnlpUi8yc1Vy?=
 =?utf-8?B?ZWdjejZIZDdCN1l1ZUQ3TW14OHh5WjhuYTJYNkRpK1hQd0FqZ3liVFVqNzBV?=
 =?utf-8?B?RmRSRzR4M09KTFdqeXA2bTF1MEljWVhCdXQvcUJFaWxZeGEzSDUrY1cvYzc0?=
 =?utf-8?B?N3pST0tDQ3l0bTJPT2lDRkxYYVJaY3ZySXJ1RklSREFoR0JFTWltSTVTbUw3?=
 =?utf-8?B?K0I1ZjhpOFJDeWMweUxxTlowWVJHQnEya3QrNEJra09vYUZCQUc3VmZQbHRa?=
 =?utf-8?B?VkJ2dm1JazQzK1I0MnpjVXkrKzFtUXhjeWVwV3JEcjlkRWZpT29DTzVsMlRN?=
 =?utf-8?B?aGhnRDh4S1VFanZTcHIyaTdVc0RUSUNHZEJQR1l5d3NabjBsODZVSjBhQ1Yy?=
 =?utf-8?B?T3EwakQvWjBDeHlyL3dzWFlBMXpMQlR4bzFTNnJWczBlSkwvcFExdmp3K3Bt?=
 =?utf-8?B?NlNHSit1NlFZRURVV3hmZ2JoZ1BCbldGdjJxblZFQnAyQ2xQMlNXcnQ1TWQr?=
 =?utf-8?B?aDdROUt0dmVCcEFjNnVTMWhqY2h0bXppVEFiZEZRMElnYUFCT05jTGpqZita?=
 =?utf-8?B?QkpRdU9Uai9CNVlCOFd3eERVUUJkeGtFYUVGaU1qY0hxT0VLTndrZjduQThx?=
 =?utf-8?Q?U64W+L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0Z3SjFMTDhhNmxKdUwzNkhYTHhYVEtUNVFjNjI2c1BaS0JodkJycm9KVlc4?=
 =?utf-8?B?V0dWcW40TVNpQ0hER012N3NwSmgwQ295cHJ3THBoZi9vS05qbm55U2VkT05G?=
 =?utf-8?B?azc3MVNkaFpaVjl6SDVRZG51QWc0VmZXdjJCYzE3U3FQM1h2eHlPeGl1SlZk?=
 =?utf-8?B?TCtjd1hhNWZvWTBxVnE4b0o3TGs2OEhFaHlKODA1aGRqajhSaUtUY1krVHdr?=
 =?utf-8?B?cStzN1RFelRHOFNMU2M0V25Ob3RMdDFUMmxtR1g3OEM1Vm1qNjU3NkxnNFpy?=
 =?utf-8?B?TVVKOURDQy9OdEFwenUydWxrVllRT1FtNjFlemJzTHNKdXMxTXdsSE5BSkFF?=
 =?utf-8?B?d0V5RkJ3ejdDTThCSDhIVVhRUEF6bWpiZTdiMXBDS1ZnTm53SzJZazBOM045?=
 =?utf-8?B?VklPNDBVK3BlRVFkY0RhRnJYY084dHBWY3lwcjNQRkdwNVBCRHlkNXMwNWRL?=
 =?utf-8?B?aUNEbGlVQVlaOEp0S1lxbFNkRWNZaUtvQWZzOXhZRnNXMnY1ZW1jeFdERWUy?=
 =?utf-8?B?M1F2S2k4WG9jOThCcGpOS3Z6OHpuaDFXa1hpNm1uOTJUSGM2R2RuZkVpRFJp?=
 =?utf-8?B?dWJCVTB5Uy9kMU1BWCtKZ1JBSFJmTTgzWERRaDhmakY1U2ZsNXpqdjlJVHhm?=
 =?utf-8?B?Z1g5OVJPRXNtei80enBveUxTRXB5SVVkSXVFWlpPMHJQSmVJODJSNWc1T1BS?=
 =?utf-8?B?aVdoSTJjZXZINW9mbXIycElwdjNGbHllZmpTU0NRMlJhRFI5OHJCOUdHbTAw?=
 =?utf-8?B?RFJWdkVlbTNHYU0vWG4zc1ViOGN0SWFaemRyTjQ1QmxXdGRVVkQ3L0FxOXFB?=
 =?utf-8?B?cXNjbGV5QVZiUmlLMTRKVTgvWk9uaW9abDdSME1yTHZSaEt0VFhTaUlBMEx5?=
 =?utf-8?B?VWtpMkh6eVI2UWYzOE1kbmYyTVVGaEZteVZNRlBOSU9iZWw3MXQ3cG9RWFV2?=
 =?utf-8?B?WVh1bE5uV25FNitTQll2SFNCSU12YzVDZUZlZXQwRnhweUUzVWUxR1B0dHNm?=
 =?utf-8?B?ZHVoRjdaRVVDOWQzQzBZYmRidVVUR1RsNGNhODdFRDFZVzVtZTZxSGVVakRX?=
 =?utf-8?B?RndEdithRm1UaGkvZGJweGQ4OU5NZlZsUGU3RjkyaFByYXc0MmNjY2V3RDFI?=
 =?utf-8?B?TGpvbHBWOTJOaHhudEZIT2pjaS9uZnlKZ1NJeVRzQ3Y1WkFSQ1RNZkNVd3Fm?=
 =?utf-8?B?ZUdpZHZUQUplSnhkK2tlZUl6K09YQUFaNGxmcEVNOGdBeTFySnh6VTliTUtO?=
 =?utf-8?B?aHRNcnhpZ2h6R3hBYi9EdDVMNXE1eVU3ZkxqM0ZaajdnT055VlZDWWQ2aERn?=
 =?utf-8?B?MGVsTjNtNlJHRStXeVNYYmVBbURib3MraTM2Zy9VZ3Q5QzBTMEhnVUFkcnNK?=
 =?utf-8?B?ekhEaDIwSWhuRjZ0V0dKZXp1NHhlTEMzWU44cW1jcjlkS0N5dXhFWnZzbjQ1?=
 =?utf-8?B?dW1FMllUWTVRU3FXT3dYb0wrUWVRNXpqaE1XdmppL2gwaXd0RE5UZDBUUlEw?=
 =?utf-8?B?NTUyT3BtMnh4blJBc01NRGg2T01pRWNIN000SGxCd0Z4ekRBYXpra1NUd2lY?=
 =?utf-8?B?MW1wVGV3cjQ1QTV4bkN5SzBPcC9INFQyempHbytDL1NMdE9RKzJpWlRISjRs?=
 =?utf-8?B?bXVlRzF1NDdIQXpBdForNDFpcDBaVnBOQ3ZmaHVzcnA0WUNMN2locDlJODFE?=
 =?utf-8?B?Y3g2U3h2SnVlcFFwcTZMV2c0NDcxeDE2QlNyZ1ZHYkF5enFucG1CQmQrUEZx?=
 =?utf-8?B?RUpHOTNaZmU4Wkhzc1pFYWlrL0owYkNmeHlRZlZxSjNmcEVwRlMralhFR1Ew?=
 =?utf-8?B?SEpDVWxBclJ2NTc3RllxdVhUK29zcVJKZVBMZG9UTm9rS1FPZGxNSjdFVTk3?=
 =?utf-8?B?cVlMZWsxSnZZdVpOQ2pyZy8yamx5dW9ZMkUyM1Q0SW1hbjRtZ0NLbitQK3h6?=
 =?utf-8?B?RHFoanRMZXg1ZUZ1TG0wYnl3SmVERVV6RWVaMS8wbEQrdDFBMFdyMGM2OVhL?=
 =?utf-8?B?TVVQOTYvbTk5WVNnSUU5WFNtKzJBdDF4NHVtL0FFK3VnM3dRMXV3M3pyWC9K?=
 =?utf-8?B?SGxRMUkxcGhDUHF6Y3MrMkJaNUxJZzVERDd4TzVlVFV4TG1ZWlljQktzWkpJ?=
 =?utf-8?B?dGlIaEpEdWpxZWlONnpvWlFlK0R2NEM2NGMyZmtEOWN6ZlZjekFSUHc0TFY3?=
 =?utf-8?Q?ajUkBZytTCdP0iPZrm+z4Sw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11F264850A72D142B77B2CAB65A460A6@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e02823-999f-4366-c7e8-08de152f3fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 08:03:01.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUUy50rfAE2hpvzfWgLD+mTZPd7Q425MSQCJcvYG/WSOw4lBAKXmCFTWDffNGG9sX4OI/rnlWizQnP0+6EWhw2AFOnNghMhgZfr+Pff1GBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7804

SGkgRGFuaWVsLA0KDQpPbiBTdW4sIDIwMjUtMTAtMjYgYXQgMjM6NDQgKzAwMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gT24gc3RhbmRhbG9uZSBzd2l0Y2ggSUNzIHRoZSBsaW5rIHBhcmFtZXRl
cnMgb2YgdGhlIENQVSBwb3J0IG5lZWQgdG8NCj4gYmUgc2V0dXAganVzdCBsaWtlIHVzZXIgcG9y
dHMuIFRoZSBkZXN0aW5jdGlvbiBpbiB0aGUgZHJpdmVyIHRvIG5vdA0KPiBjYXJyeSBvdXQgbGlu
ayBwYXJhbWV0ZXIgc2V0dXAgZm9yIHRoZSBDUFUgcG9ydCBkb2VzIG1ha2Ugc2Vuc2UgZm9yDQo+
IGluLVNvQyBzd2l0Y2hlcyBvbiB3aGljaCB0aGUgQ1BVIHBvcnQgaXMgaW50ZXJuYWxseSBjb25u
ZWN0ZWQgdG8gdGhlDQo+IFNvQydzIEV0aGVybmV0IE1BQy4NCj4gU2V0IGxpbmsgcGFyYW1ldGVy
cyBhbHNvIGZvciB0aGUgQ1BVIHBvcnQgdW5sZXNzIGl0IGlzIGFuIGludGVybmFsDQo+IGludGVy
ZmFjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBHb2xsZSA8ZGFuaWVsQG1ha3JvdG9w
aWEub3JnPg0KDQp0aGFua3MgZm9yIHRoZSBwYXRjaCENCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRl
ciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KVGVzdGVkLWJ5OiBB
bGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KKHdp
dGggR1NXMTQ1KQ0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L2RzYS9sYW50aXEvbGFudGlxX2dz
d2lwX2NvbW1vbi5jIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9sYW50aXEv
bGFudGlxX2dzd2lwX2NvbW1vbi5jIGIvZHJpdmVycy9uZXQvZHNhL2xhbnRpcS9sYW50aXFfZ3N3
aXBfY29tbW9uLmMNCj4gaW5kZXggMDkyMTg3NjAzZGVhLi4wYWM4N2ViMjNiYjUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9sYW50aXEvbGFudGlxX2dzd2lwX2NvbW1vbi5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L2RzYS9sYW50aXEvbGFudGlxX2dzd2lwX2NvbW1vbi5jDQo+IEBAIC0x
NDU5LDcgKzE0NTksNyBAQCBzdGF0aWMgdm9pZCBnc3dpcF9waHlsaW5rX21hY19saW5rX3VwKHN0
cnVjdCBwaHlsaW5rX2NvbmZpZyAqY29uZmlnLA0KPiDCoAlzdHJ1Y3QgZ3N3aXBfcHJpdiAqcHJp
diA9IGRwLT5kcy0+cHJpdjsNCj4gwqAJaW50IHBvcnQgPSBkcC0+aW5kZXg7DQo+IMKgDQo+IC0J
aWYgKCFkc2FfcG9ydF9pc19jcHUoZHApKSB7DQo+ICsJaWYgKCFkc2FfcG9ydF9pc19jcHUoZHAp
IHx8IGludGVyZmFjZSAhPSBQSFlfSU5URVJGQUNFX01PREVfSU5URVJOQUwpIHsNCj4gwqAJCWdz
d2lwX3BvcnRfc2V0X2xpbmsocHJpdiwgcG9ydCwgdHJ1ZSk7DQo+IMKgCQlnc3dpcF9wb3J0X3Nl
dF9zcGVlZChwcml2LCBwb3J0LCBzcGVlZCwgaW50ZXJmYWNlKTsNCj4gwqAJCWdzd2lwX3BvcnRf
c2V0X2R1cGxleChwcml2LCBwb3J0LCBkdXBsZXgpOw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxp
bg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

