Return-Path: <netdev+bounces-206609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE31B03B74
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3E23A2890
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B14F242D62;
	Mon, 14 Jul 2025 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzRjH1pn"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012036.outbound.protection.outlook.com [52.101.71.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73317286A1;
	Mon, 14 Jul 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486993; cv=fail; b=mSrZbX5vDpxGm+jhc/9KufcW6fl5C/kqJa41su5a2uK4PPYYjhe96kxjV1D8vtrylmIo1BfVxp9xswLlMS0001haFhnxFP/rv342nl60HX9ypjXU4WotUmhgxa7aFQpLc1HTEKkNLLaWzLKGNsxjhYyJFtFYBe86e9hTCLNk7wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486993; c=relaxed/simple;
	bh=mF/335JBWAXvDt7512m012hsGdLNFQJTzCr9lgmZVvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dK06EBubYDpOtBq05Hwzd6pCDC78a2QQynGY0DfwyA9uwmfjawjY3w6CIC/nNrOUdshZGCtBV/+IhYtP6xtmjIJxfTWxmQP9VNy6g1ydIDL45PJvHA21prgpummwxXkXT/UlmXmGIQtaCyVDfFRfwTAPxrCDduyfr0DE1PBD3uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzRjH1pn; arc=fail smtp.client-ip=52.101.71.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD1f7nrq1/SFGBCjaiyDG6zQOEce4k67VSjQ3wsz7tCT2MJ3VY+QHkSRHzo6v1DbYjpm5hMqhsoELmDfQyH37urR0ADFWFD1wQB99lKuDgof4BT9q487yIEoEpKWTgo5F9CgQ3/KKQSFhttl421ppRDt7+RC9mNpkWbjK+/DKYw7YMkTT+19ABlroyTfi7jofKJqNLoB1Pd9qDgWr0hXj9xKfnCHiWY3LORM32aBsfn5MxkLI89eufheJj3088kzBl4bYPMIUOSfwZeAkIF8KdahGka6CrkFFHAcl0C9TyF/cc1G2bWjrNzbViW3Liee2lHLk26crVG3CQVNNQXCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF/335JBWAXvDt7512m012hsGdLNFQJTzCr9lgmZVvU=;
 b=G1A2WVMbbYWaIkabvjCQ5m6YIyWnbj9tls9k0IZMiH8tJX6RyUqUxapnYxqIFtK0obfvLYNNLLBSbEtfVl+k/HvGcQfGwdWG/Oe9qdf2qoYAkpzu4rVgsEnro3kd3qdYetHoo8e2q4lWVwTgLZWK5m0T463ODZGinxokF0oSKfdkTch/qs/pzhm1Bz137IoV5yCZARZt5ZeRPo+4DcvUrqqdpvtlAOfrRecvq2Zaz9Lem8WiUsVJeZb4STsP2d0ykP7mWJzZf860Nnw8w4EfVBA7Fbt++paNPV7QYmaRRmE1GmWMLhrxIAG3sISpb9AdWzcsV9J6876E7/niLnA4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF/335JBWAXvDt7512m012hsGdLNFQJTzCr9lgmZVvU=;
 b=jzRjH1pnSVnOz7fI+mRQtMFpHWfisw+ydDVe6qMO46wQ0MFk3/xLlntcc/kY/WOyn1e6r2FlMw5vW5yv5tjTMNjQVQ+W8uJ+UKOaa/slR7NvFHE6bqaUeU/4F3TRWRBdCMqFLZZ+Ssa6/N/FUSW8rgaQhblf5IvH3e2ZbGhziccXAHmednPDe0fEN1qVdBIgXLZkMfPUcxRrhBQ4L1geIAnCBHq73AhR6+lmxGfuovjBgs10C6SpVHHcy+oKiZpMqZzCNSOSVX2KFjJ3Lqx3VQhgfp4pDWtlkHrqHPIyU6FrDCYh4GwFPvw6JfyvSb2WlM8AirssAXH7jmFEQFQToQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 09:56:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:56:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index:
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQA==
Date: Mon, 14 Jul 2025 09:56:27 +0000
Message-ID:
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
In-Reply-To: <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB9510:EE_
x-ms-office365-filtering-correlation-id: fcd31cb3-8b0f-4168-c0fe-08ddc2bcb384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjlCVW9nenFnV0RQdnluZ0FsakJrejVCRzNtL2MzZ2tid21Uc0doWis1dkxI?=
 =?utf-8?B?UUNvSXpBd3VnREQ4Unk1aElqZFFpREF4ckRicmgwSStSTnV5UXlIanAraXZz?=
 =?utf-8?B?VkYxSzZHWmZNeDU1YTl6MG83VjFZTE0xbk5JQ1RUZVNaUEl1dWE0TkgxM0RP?=
 =?utf-8?B?RUJBNmswTHJUekRJR29wOFlVekQ3WEluV3ZQNjFnc0NyTUowazZMd0xIN1I1?=
 =?utf-8?B?NFdkOTdMSlAxamc1TUV2bEE4MzAxMldLRTExOVhmSVllQnh0djh4cExoREMy?=
 =?utf-8?B?QktQWE5zcGdXVkFabHJTWjdVQ2d3WE15cmtOUFUwU05FL29EUTRxcXQwL1p3?=
 =?utf-8?B?N0N2NEpCbmQ4ajkyWHZjbDVYQ1hibDd3emFNenY0MnMrdVQzUFZBN1Nvdm5y?=
 =?utf-8?B?RDRTTzNNQXRSMk5ZdGpFOWF5K2lySVA1VU5vTzFQY0RSa2RlVTFBWFBlNXly?=
 =?utf-8?B?SmMwTkxFSXVNQ1RmOEZPWHBDZ2FIa1FGK2tobEFWUWV0am1TeWV3bHBtZWFu?=
 =?utf-8?B?QkxjdUUzRWgwdkl5bnJFQ3FZNUZ1QTlXYS8xb0hvZlBOOFhUb20yeC9FOVAw?=
 =?utf-8?B?Sm1UeVVFRm94V2ZsRTl4T1g3QXM1K1VzV0FwbDkwKzlGZ3A5M0FDVmlNVjh6?=
 =?utf-8?B?OVpNWk8yTlZUeWtaSk5Kb2dMR3dIWVF3VC80c2hqTnJtSlkyNkc2SGI4N1Zq?=
 =?utf-8?B?bGFXL2VOZnBZQmlwWjRKR0ZvaVhIUTUrQmZLLzczUHFTOWNpVysvWVhENG9s?=
 =?utf-8?B?TUM5MU5ZYjB2MmxWcEduVm82RjB5eHJwZGlJZ3RvSklteUNDMkZYZU1nYWp2?=
 =?utf-8?B?ajhPb3BkWDIzRFBPdmdmT1lCZkVQQkRKcE1LQlJVMTdGbTNOZG9GbTc1cFFP?=
 =?utf-8?B?TG9uM0ZXOXVjRjJMbnd4TUdRWm5ENVVFSThMLzNCaFpWdHdnVGovc2dyRGg3?=
 =?utf-8?B?MHpZb2FqS0J6TVd6NUcvSlFiRzJlMWFIQkVJYUlvWU5oMGpaSHVJQUpQTEpM?=
 =?utf-8?B?K1lUVzNqSjR6S1ljVUs4RTFrVVUyVXVpdlRSZ0VhMmFjYVdyTkdzenQ0Tmtj?=
 =?utf-8?B?UVVTalY0SS9qbmV4L2I3dCtNYW0rVGNwUEdiLytSMit1VUJDQlhkMXgyZ0hj?=
 =?utf-8?B?eE1sSHptRW1WSE51Z1pGdit6UkNrNTVyYmdLb242N1YyZ25DQVM2cFdlNE5p?=
 =?utf-8?B?SjFZSG82Uk5uakVDZXdtOFFWMXZLbU5FMmxjTDhFU2dGa3U1S1NraHVUb2wv?=
 =?utf-8?B?V28rK1prbVpTS1NRa0JQeGRHR0VJVSttYTlRK2Vnbzh0Mkc4aFVCaXZWT1Ex?=
 =?utf-8?B?VURFM2ZSSjZVZ0xxOEZRUEdhWFpIR2xTTU9ocmF4bXA2SjNBZzVnV1dBWmZv?=
 =?utf-8?B?SzZ4QWsyMXVhR1p5bnRKNjhJT0lQL1RKRWhxVFBaUXNoMXQ3d0x2ZkpORWRw?=
 =?utf-8?B?UmdlOXRKTlV3UWtyWXNHZFlTY0lLTEVRNWxaTytNUklWQTR5ZzNQa3BUT1Ir?=
 =?utf-8?B?V0U3YTdUelRZTEFkSDgvSEs3dHZaR1ZhbUREeHduVG14OFdoQnVxMW01K0JS?=
 =?utf-8?B?NklzVFliaytnK3ZWOE91Ni9xZEhlMEdiK2NoUUFIc2dITmp0aWJvd1ZJS2Vy?=
 =?utf-8?B?U2hkYWJ1blpGWlBiZEs5Z3B5V2xxWlM2T3FqTXg2MlhmcWNaVDJnT2hYOTYw?=
 =?utf-8?B?MWw2VlFDaGR2ZjJRYWpHb3JZSGJlbjVwdkZFNS93QmMydTB5S0pnN3hpY2Na?=
 =?utf-8?B?WEtET01QWFJpRXRnVnA1R2hPVnNaaW52WTY4R0p1MnhqVS82b010VCtBUU5l?=
 =?utf-8?B?Rk9Fd0wxK0lnZW1nQVR1OVM3NVprVFBVNXJlQlZBbVVpcHpzQzcwUXY2V3ZP?=
 =?utf-8?B?OENYTW11dGZNVUp6WFFCOWI3WXhrSXovV3p2UzZWWkVYMGJ6SUFxZjJZbDN0?=
 =?utf-8?B?MlBBQXRNMm5kdVorSTVoRklXQXNoUG82TSt6UU9SM0Q5V29wUGd0TEY1L01u?=
 =?utf-8?B?QTEvV3FMRUVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S09qZDVKRTh2cU5OaUVBek54YXBnZW1lVktJeTVhSTYvaFRaZ3Y0RElVWlZW?=
 =?utf-8?B?bWtmNDNHeXlKaWlaR0UzSm9HaUFyNlU1V0FtUEV1OG5xWUhrNzVieklNbVNj?=
 =?utf-8?B?b0lhUGFjOHdVbzYzRmZDMmp1OWQybGZxL1RtcSswSW1QcGdQV2YwcjlJb3RL?=
 =?utf-8?B?YjVPQk1uK2t0UzZ1UmVRdjExNit5RjZ2K1Q2MmZMQkVmWUIwdy83NmF0S3Zt?=
 =?utf-8?B?cmIwTlRydTRlNzVPTWhxTXBZMHA3SXlCOVlJbDNXTEtEVWhCQ3FvTUN6RFpV?=
 =?utf-8?B?MmsySFJablJHSVBXNFR5ODRPMTFRbWE1Z0ZHd2ZyYWpjd1JlV3o1ZmZXckpD?=
 =?utf-8?B?ZE9NWklrL0hnTHQ3UVJMVW9NekxqTzBoNG1McE1sOFZGaVRwR1ZUeEpySmdF?=
 =?utf-8?B?KzdWT3o0aHFRQjBjczlBenF5bGdYZkUrNnlGcTV0QlZPS2JiczlxUDJiNWRj?=
 =?utf-8?B?emQxVnF3L2JDUGtuWTJ1WWZGQXFSMzQrQldOa1FSSmhYMnQ2QW9rMGhGM3d5?=
 =?utf-8?B?WkVUVlN4bHFIdUhKWVNzUUpEOUVBa3JaRlRQNDlmNlhpeHhxQ1N2emJEMzhv?=
 =?utf-8?B?U2VaQ0MyNXJYSHRKOVZzY1FiVEI0WEw0eTJPYU9zeEI5elcweE02UXRvVSsz?=
 =?utf-8?B?VUdYNnVheGZoSEd5Smd4YW92aXlnUDBvdkVkVEpkNWxxOGNuOU9oR3JFK1Zl?=
 =?utf-8?B?MGVmaWFWcUdXUmZnNUEvRjRiWEdpQ09Fc1ZzNjhudjlxb2puNEFrYm9mTE82?=
 =?utf-8?B?UWwzZ0VLZzFWYUNVT1JhbVdkMzRZL2RVMWRjQkFyV285WktiSXNHR3ExSlBk?=
 =?utf-8?B?MHFybmc0eDJCVDNiY25HSDRDSVMzbEZ1K21ISHZ1dlVYSDJhVVhjZmFYZGdD?=
 =?utf-8?B?VmpwU1pSTGVNL2FSS0RqRlNRQnFnZ3MwVEZpMTdjb1h5cTJvOUxkMys3ZGdU?=
 =?utf-8?B?cVlHaExXTWFGclNhcG1mVDdOamc1OXJqN3BGbnZZRzlWUjBYcDlZN1JpRGdw?=
 =?utf-8?B?eE5JVkJrWWgwVGxRRXZSNHMxL0RvMnlzWEV2ZitSUzJXelZaalhmbXVvTDQz?=
 =?utf-8?B?QVo4RXA3TlRWYjRFVkxCR3FZck04MFpkazhvcElTdEV1ckhjdjBxYTByTEc4?=
 =?utf-8?B?M1FZcEp1T1J3TGVtMXhkV1JGMEhGRXB4S0RpYStET0gydDJVenNYSHovRHNX?=
 =?utf-8?B?bWdJd2ppcFRzbERtWHl2ZkFSTlRPbmdScjBQcmsvdDJzNzd3OGxweEtSZ21p?=
 =?utf-8?B?YWtNS0E4K3krNTBQelh1Z2RrcUpHbm5BUEVzMDduY29Cais5dU1tdzk1a3R1?=
 =?utf-8?B?OFcxeDA0VHhJaDBmT01QeGJnRy92WDk4ZnNJOXJGeU41TEtTV2duZTVSczAz?=
 =?utf-8?B?WXZ3SjNhSGNxbzNaaVE2RVJkZWVxTkFuZldSTHBJWEZtNVNrQWFTM0daZDNV?=
 =?utf-8?B?K2pwcUYzbDJST3MvZnFIZmtGU1lVdUJQMVRlZ25uWkVCeU1DM0tqemhuUkI5?=
 =?utf-8?B?Ri9oUXE3SGhUbis3eHM0TzY5bVo4dFVwQXdtTTg1NjllaGFuemtqVVFkSldw?=
 =?utf-8?B?SHM5TTZ2VFp5aERheGRWblFVd05ZUStJck1ueU1yY1ZRTnl6eXphd3hQNVdp?=
 =?utf-8?B?ajQwcDMxTVV0VkVoeEZjcWpTK1dqdkFtVCtWYk41N1RoT0RDYktWOGp6blRj?=
 =?utf-8?B?aDRWUElWUG1jejh3VGJia2JSQ2FtYm1vVWVSMTZRbzdrbG5tdzIzQnVsc282?=
 =?utf-8?B?TFRvc0VMOHdGcVZQZm5EMEFoaXpZU1crTURLZ2pxbHQrRXQ3MDAyNmpPeDI5?=
 =?utf-8?B?L1hSMmRIRU1jRThVbTdTcktQQnplRGIreUZkZXVWd3pWclZ6V3lUbm0rekRX?=
 =?utf-8?B?aG9SV0drVjdWWEgzU0cwWUc5ZjRrRXlmdzRaV1pHU1VqeCttNDF4VHloRklN?=
 =?utf-8?B?QjQ4eVo4TFhRSTZoWVJydVBmdHhwM1prenBZM1c2bGc5Q1BTNWJHUkRmb0NJ?=
 =?utf-8?B?VEExRUxiZml4L2htZEZHWit4MlJ0djRCMGpjRHh3QzNKOU45UUh6eUkya09T?=
 =?utf-8?B?aU9GQlExMWxkVWtwQU9jdFhvM3JRcDU5ZU41K003QUV1Qk14WTZsUk9xOVlY?=
 =?utf-8?Q?zrQs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd31cb3-8b0f-4168-c0fe-08ddc2bcb384
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 09:56:27.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clAmUmXWSaozbapBNFbuUzVhJ+CLb/X/EF5xjrIlSJWCAEcKp+v1DDICuXbLtQ4E2tiSzzaG9mi1RiV23emBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

PiBPbiAxNC8wNy8yMDI1IDExOjExLCBXZWkgRmFuZyB3cm90ZToNCj4gPj4+Pj4gKyAgbnhwLHBw
cy1jaGFubmVsOg0KPiA+Pj4+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmlu
aXRpb25zL3VpbnQ4DQo+ID4+Pj4+ICsgICAgZGVmYXVsdDogMA0KPiA+Pj4+PiArICAgIGRlc2Ny
aXB0aW9uOg0KPiA+Pj4+PiArICAgICAgU3BlY2lmaWVzIHRvIHdoaWNoIGZpeGVkIGludGVydmFs
IHBlcmlvZCBwdWxzZSBnZW5lcmF0b3IgaXMNCj4gPj4+Pj4gKyAgICAgIHVzZWQgdG8gZ2VuZXJh
dGUgUFBTIHNpZ25hbC4NCj4gPj4+Pj4gKyAgICBlbnVtOiBbMCwgMSwgMl0NCj4gPj4+Pg0KPiA+
Pj4+IENlbGwgcGhhbmRsZSB0ZWxscyB0aGF0LiBEcm9wIHByb3BlcnR5Lg0KPiA+Pj4NCj4gPj4+
IFNvcnJ5LCBJIGRvIG5vdCB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4sIGNvdWxkIHlvdSBleHBs
YWluIGl0IGluIG1vcmUNCj4gPj4+IGRldGFpbD8NCj4gPj4NCj4gPj4gVXNlIHBoYW5kbGUgY2Vs
bHMgZm9yIHRoYXQgLSBsb29rIGF0IG90aGVyIFBUUCBiaW5kaW5ncy4NCj4gPg0KPiA+IFNvcnJ5
LCBJIGRpZCBub3QgZmluZCBhIHJlZmVyZW5jZSBpbiBvdGhlciBQVFAgYmluZGluZ3MuIElmIEkg
dW5kZXJzdGFuZA0KPiA+IGNvcnJlY3RseSwgeW91IG1lYW4gSSBzaG91bGQgYWRkIGEgc3BlY2lm
aWMgY2VsbHMgcHJvcGVydHkgdG8gdGhpcyBkb2MNCj4gPiBhcyBmb2xsb3dzLCBjb3JyZWN0Pw0K
PiA+DQo+ID4gIiNueHAscHBzLWNoYW5uZWwtY2VsbHMiOg0KPiA+ICAgICBkZXNjcmlwdGlvbjog
fA0KPiA+ICAgICAgIFNwZWNpZmllcyB0byB3aGljaCBmaXhlZCBpbnRlcnZhbCBwZXJpb2QgcHVs
c2UgZ2VuZXJhdG9yIGlzDQo+ID4gICAgICAgdXNlZCB0byBnZW5lcmF0ZSBQUFMgc2lnbmFsLg0K
PiA+ICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4g
PiAgICAgY29uc3Q6IDENCj4gPg0KPiANCj4gDQo+IE5vLiBJcyB0aGlzIGEgdGltZXN0YW1wZXIg
ZGV2aWNlPyBZb3UgcmVhbGx5IGRpZCBub3QgZmluZCBhIFRYVCBkb2N1bWVudA0KPiBkZXNjcmli
aW5nIHRoaXMsIGluIHRoZSBzYW1lIGRpcmVjdG9yeT8gV2VsbCwgbWF5YmUgaXQgaXMgbm90IGEN
Cj4gdGltZXN0YW1wZXIgZGV2aWNlLCBob3cgZG8gSSBrbm93LCB5b3VyIGRlc2NyaXB0aW9uIHNo
b3VsZCBiZSBjbGVhciBoZXJlLg0KDQpJIHRob3VnaHQgSSBzaG91bGQgZmluZCB0aGUgcmVmZXJl
bmNlIGZyb20gWUFNTCBkb2NzLiBTbyBJIGRpZCBub3QgbG9vayBhdA0KdGhlIFRYVCBkb2NzLg0K
DQo+IA0KPiBIb3cgZG9lcyB0aGUgb3RoZXIgY29uc3VtZXIgLSBldGhlcm5ldCAtIHJlZmVyZW5j
ZSB0aGlzIG9uZSBoZXJlPyBQYXN0ZQ0KPiBjb21wbGV0ZSBEVFMgb2YgdGhpcyBhbmQgdXNlcnMs
IG90aGVyd2lzZSBpdCBpcyBqdXN0IHBpbmctcG9uZw0KPiBkaXNjdXNzaW9uIHdoZXJlIHlvdSBw
dXQganVzdCBhIGxpdHRsZSBlZmZvcnQgdG8gYm91bmNlIGJhY2sgbXkgcXVlc3Rpb24uDQoNCkJl
bG93IGlzIHRoZSBEVFMgbm9kZSBvZiBlbmV0YyAoZXRoZXJuZXQgZGV2aWNlKSBhbmQgdGltZXIg
bm9kZS4NCg0KZW5ldGNfcG9ydDA6IGV0aGVybmV0QDAsMCB7DQoJY29tcGF0aWJsZSA9ICJwY2kx
MTMxLGUxMDEiOw0KCXJlZyA9IDwweDAwMDAwMCAwIDAgMCAwPjsNCglwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KCXBpbmN0cmwtMCA9IDwmcGluY3RybF9lbmV0YzA+Ow0KCXBoeS1oYW5kbGUg
PSA8JmV0aHBoeTA+Ow0KCXBoeS1tb2RlID0gInJnbWlpLWlkIjsNCglzdGF0dXMgPSAib2theSI7
DQp9Ow0KDQpuZXRjX3RpbWVyOiBldGhlcm5ldEAxOCwwIHsNCgljb21wYXRpYmxlID0gInBjaTEx
MzEsZWUwMiI7DQoJcmVnID0gPDB4MDBjMDAwIDAgMCAwIDA+Ow0KCWNsb2NrcyA9IDwmbmV0Y19z
eXN0ZW0zMzNtPjsNCgljbG9jay1uYW1lcyA9ICJzeXN0ZW0iOw0KfTsNCg0KQ3VycmVudGx5LCB0
aGUgZW5ldGMgZHJpdmVyIHVzZXMgdGhlIFBDSWUgZGV2aWNlIG51bWJlciBhbmQgZnVuY3Rpb24g
bnVtYmVyDQpvZiB0aGUgVGltZXIgdG8gb2J0YWluIHRoZSBUaW1lciBkZXZpY2UsIHNvIHRoZXJl
IGlzIG5vIHJlbGF0ZWQgYmluZGluZyBpbiBEVFMuDQpJbiB0aGUgZnV0dXJlLCB3ZSBwbGFuIHRv
IGFkZCBwaGFuZGxlIHRvIHRoZSBlbmV0YyBkb2N1bWVudCB0byBiaW5kIGVuZXRjDQphbmQgVGlt
ZXIsIGJlY2F1c2UgdGhlcmUgd2lsbCBiZSBtdWx0aXBsZSBUaW1lciBpbnN0YW5jZXMgb24gc3Vi
c2VxdWVudA0KcGxhdGZvcm1zLg0KDQpCdXQgd2hhdCBJIHdhbnQgdG8gc2F5IGlzIHRoYXQgIm54
cCxwcHMtY2hhbm5lbCIgaXMgdXNlZCB0byBzcGVjaWZ5IHdoaWNoDQpjaGFubmVsL3BpbiB0aGUg
TkVUQyBUaW1lciBkZXZpY2UgdXNlcyB0byBvdXRwdXQgdGhlIFB1bHNlIFBlciBTZWNvbmQNCihQ
UFMpIHNpZ25hbC4gVGhpcyBmdW5jdGlvbiBpcyBpbmRlcGVuZGVudCBvZiBlbmV0YyAoRXRoZXJu
ZXQgZGV2aWNlKSwgc28gaXQNCml0IGlzIG5vdCB1c2VkIGJ5IGVuZXRjLg0KDQo=

