Return-Path: <netdev+bounces-172730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA556A55D10
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39AB7A6742
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B35148FE6;
	Fri,  7 Mar 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KiIy6gKa"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50729408;
	Fri,  7 Mar 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310579; cv=fail; b=cf3qFTuNL4JzM8OIKHEuaL4HQpNybo9aOjonB/DG5TB+z3bxoHXrYblSKEZfn8JWtlf4Ric/S+GWz2s9EMl6XQG1rm0fRggPUJZsnA1RdUgDFVVtl386I0VRLONk/1JYc/Sei2rtV8USsIcDPXkM8z7MH/AGlnuqmfy3kpQC9j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310579; c=relaxed/simple;
	bh=pJjBeHxzjFwWxgEBzpZIbQjekxtvStJTrJ6RL1kSpdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nH6DRnfxYouXTVjjEsoG1WJkyrL0UhxgSs9nsIvPGoObO2dj1La+N43yyglBn0wGYWfUHou0e3eEU1MrF8yXCIQQAhqGk4ApQ/ERmykCZJrPHK9XEOkgrRrhlYZlLW2hipSlybV0GiE8Twfhvz6kJ+DsvLhNypsApNdP2vTKAlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KiIy6gKa; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRRTVSHXC0783YgNF47E1biYxi1Dby/oBUgSRMMeImow/A9BwH9GY/G3fRz7Ri8/rpyBPx4Mht/jFMDVFvn8TP5GcB01qaEWvvFfjeNUXr0wz+D/9FxqoQ/yknAzdCDfyWjo4EoT0zvO7NntvggmBMRkNuMuZPMHYcq9FXjlfagSZySIfG/Mm+WDj1YHQdCAsYtpT5bPCZtFNY18Zp+E+Om5LKbxK4zTZjTxqMG18srbYSwVa2Iv87REg6MgpSTd1HTAgEOlNJC3m3lRiN6sYIAzyxONzTcfEq3AecS2uI/RItkKWcCtwgqreUvguMZbdkVcdFd+zWgYv79Iuml8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJjBeHxzjFwWxgEBzpZIbQjekxtvStJTrJ6RL1kSpdI=;
 b=HRkS0s7ejif0R33RBAMbIe2WZUk3TJhCFqZWDSKlu2OXlbH6USFDa5MuYq+2rmVwuPezIVtsQTsW4f3ddMMvNlWeKRKPJqNdtX5m59kIZ3TTSbw4UO5N5nfTSlwqpSg7HEozjkQwhJLPg7ZyH5kEXfqJE4+lQ7rAmsl1HozYm2cFi4hVOBPAlJx6vW15icycu6IWr8q7wo4LNRsQJYwsyVmbAh8hwQueJhWsv0vmBwvNedvOaUDqwgU+a2rLxMSt4B3Ui7weMDgSS4p3P3SdVmXiTPHespl3pMKsZc3LejAYlmK8YgAWC2IEITn325UgussRzuYMWTccCK3+qgBQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJjBeHxzjFwWxgEBzpZIbQjekxtvStJTrJ6RL1kSpdI=;
 b=KiIy6gKa410F9cSJFZ0/CB4ib3Wndp+CdiFHxjhSZbLPUcQwdlU11rqjbaRbqmjkfkCeENeWScUIlKIbPHUJn/Kf7AaPRCj5U1ZENZ48/AUQPYosKDI3yhKykyS6SITbIzdrp7aOavGw4vLA9+ukjwPDaA1YXLoEAi0uHQjeMHgmwR/NjGjKZCtbnqFvc/4BxcZAiRSnxorNZhvhBDmuVtR6UzzXHqTrZEifqyFSwhUrZglMF0iEucE9eUzwUuvLXMllLVfMgPpRdKYslBC8kLYWBSDc6Wt8cyYfcgOJOQCTGAxnakS3fxsfNhgc1yPbZ1BtEaAQj73UHFJkw0py2A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 01:22:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 01:22:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 net-next 04/13] net: enetc: add MAC filter for i.MX95
 ENETC PF
Thread-Topic: [PATCH v3 net-next 04/13] net: enetc: add MAC filter for i.MX95
 ENETC PF
Thread-Index: AQHbjNiUnJr64KQ/6U+S+BkcuzmRlLNmLr2AgAC2AjA=
Date: Fri, 7 Mar 2025 01:22:54 +0000
Message-ID:
 <PAXPR04MB8510638FA6F61973C620BEAE88D52@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
 <20250304072201.1332603-5-wei.fang@nxp.com>
 <03492277-b7e8-4cd1-b92e-699ee0d7dc85@redhat.com>
In-Reply-To: <03492277-b7e8-4cd1-b92e-699ee0d7dc85@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7420:EE_
x-ms-office365-filtering-correlation-id: 90eacbb5-a4b3-465f-88df-08dd5d169625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFI4dVZhSHdmY2daNEdsTDNsQ0FJSzN4M0RlVERsWU5KOEM4ZytoTzhlb1FZ?=
 =?utf-8?B?ZkVnTmMrS0RHTWdZYmRITEowS3RsR1pmSFFmY3B1WlVRS1ZSaEV0SGhVamk5?=
 =?utf-8?B?ZVpETXhIVmJVRnpYNG9yMW1hdm5WL0R4N2QveGlPQWU4SktvWnBOWkVMWFhq?=
 =?utf-8?B?NXpwTndZQ3Y3S3J2UVVhOTJXTWo0ZGVuMXJ4ekRCckxEcVU5RjUxeFdiSUZZ?=
 =?utf-8?B?ejFjZzBSN1VOeEFUN040RlNoemx2MlpYV1V4TTIrZjRNc3pHRHMvbFdCOVNB?=
 =?utf-8?B?NDNnekk2NmIzUWw4OXkyUUhTenJGVVBRcEdsVW9GRlpJSTZLVmY4OXY4YTZm?=
 =?utf-8?B?blp5cENpUWRLNDNvWUhzdjM5ajR4ZEJRcTBNeC92cFZPWm44SHVKM256UlU3?=
 =?utf-8?B?SDY3Y2tUdmlha3V4bERoSjdodlpOWFpHYy9qQ1pWWEk1ck05WWFHUW10cDJY?=
 =?utf-8?B?b3ppT0JWaW1iejB3c0M4ODkwMEFXdnFGMTJIckNYQ1BwdCtXL0lJdjY0MXY1?=
 =?utf-8?B?WlNrUkZiVFJBSnM5K3pDOWNrR0R1WlIwU1BHbEYxcjVXMkhyVTJhaDg2dEVQ?=
 =?utf-8?B?YzczLzNJR0ltdWltTGljSlJGNk9lbjQrWEZ2aE5mYzAxM1M0M1MzOU5nYVZ2?=
 =?utf-8?B?OWJqTzBwQUZyRmQ4dHhNbXNYdlR0WW0rcG8zR3hyRm1WMktMSHJibnV5WWMy?=
 =?utf-8?B?VklhQmM4UXBqV1V5NjJlTXN4eXNDRFdXTzdCemVGR3JLRXdsc1pXTEE0QVBk?=
 =?utf-8?B?VCsvaWlURkJvdDVoMCt1cFk1QU9PM0drbDBsU0g4VUVEWFBvYVB4MVVaeXlS?=
 =?utf-8?B?dG1rRHhyWThBQXBlOGJNTEtJMjQ0R0s1MCsyNUVIdTI3a002UStTN0tieEcz?=
 =?utf-8?B?VDdzQ2ZaZDdjMUFNclh4R2F3ZHozTDhkQVN4dThXQkJuODQ5VjZwcFRrTjlV?=
 =?utf-8?B?cXRXK29RYlVoUVd0MmFvckVKeU9tWSsxdjJkTG0xNWtVQWdvVVJ3Z0dZVXVx?=
 =?utf-8?B?SUZJZVVTMDBwWGZRUG8rR0k1L0ZuNHdCU2had2FVT0RLMVFtSDZrQ2RNNlhz?=
 =?utf-8?B?VE00bXdVOVJmSzR2cWVjc0JTeFp6ZWJjeFJ3a0R4c2Y1UTFMeXdTWDZuQkdO?=
 =?utf-8?B?eU9ncmdPSjNuN09RdjFVNGcvWTdKcGRoa0d2T0FtWVVRS25CRExwbzIra0Vw?=
 =?utf-8?B?SHpJNHFnaHNRSnFwcnBDTnJpbmE3a0xLUnN0bGlzM0dnZG5EWXZEVHNWblps?=
 =?utf-8?B?eng5dERmOStHeUNqZUVieE4reWJaVWxoMVd1dHNyNGRjbjM5K1VyY0N0MG1n?=
 =?utf-8?B?WFE3MG9VZUYyZHZ2NW16TXJXQVIrR3d3cXg5Zlo1eVA5WEtOSW1RM1dJREY3?=
 =?utf-8?B?eGg5RHlvRWtMWlI3S0QrVUxPK05RcG1DRWxJM3k4dXdQYmtkaVl5NkFpd0xj?=
 =?utf-8?B?elQ0YkQyb0Jpb2h3ZkFuaytic2VheFE2eXMrTFNUdE5QZDh1UnE0N2srUFZD?=
 =?utf-8?B?dkZCMWZWbk9LcTZsYmR5YjkxTWQ4a2dsM1ZzOEl6dk1HVlVTcmxnUERhWkNQ?=
 =?utf-8?B?THA1aUNGSk5wNytPWmp2YkpualhGNW1DQlZwR2poVVdaQkhOMHVpdW9mcmpT?=
 =?utf-8?B?enB4MXJtM3JuTGFmdS9KSDd4eG9TcmpjRGVRZG42VzRoSUc0SHNWMFArN2gr?=
 =?utf-8?B?b1kwMUgyMVl3eHFBL1ZhY2NEY1d1U2U0cUd3Z3NaQmVNeHFFYXNnRG5WR0N4?=
 =?utf-8?B?ajhVQlhuTjk4TVB1azA4MWNPblVtT1owcHV0bzVYcHJtY0VGSHlTQk52NUFD?=
 =?utf-8?B?MzVpL3lTb3FuOFAzZm9SRTgvZVVsU0ZxR1l0VXdCdTdrU1Z2aG84bnpyaVlH?=
 =?utf-8?B?dW1NYjhLOUE2MEFFUHVHc0M2UkxtK3dxQnJqdHRXT2RMNWlkYnNhYkc4dzMx?=
 =?utf-8?Q?7LK1rlzoAdOR1mnvtOYWYjsqiX3P3OkQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0k3b29lOFd1U1hDd0txNnVkdEhVWGttQno4bFZOS1RSVk9FYWN4aENzT2da?=
 =?utf-8?B?TGhwck5SclhNSmNQNG00Unh1MldOTitGOFVFaUN5N3RaNElkZlFLQ2U4RzVn?=
 =?utf-8?B?SHdpNGV1MW04UjV2NHdlR29OOS9OYkFIcHczUHRtNk94OUMrNU5BeVVGdFlo?=
 =?utf-8?B?ODZhaS9QY3F5cTl2OVFMMlUzYUxEQlNTWGFHaWNsaWkzOTNnTkVrTVJveTIv?=
 =?utf-8?B?QVIyRVQzZU5YMWw4dWVKRnZWSnhyK1FoKzRqazU5dG5nUytVSWFtMVBCM0VL?=
 =?utf-8?B?emVaVERmdnZLOHEzYXdhazVqRndSaDIxSGwvaEhPeGRKdW5jUFhxUVJTVjQv?=
 =?utf-8?B?WlRhbHhlSWVFd0swSFpndkRsdUZNRjU1cXBCUDZrL2xpdXlobDBtQi9tcEhV?=
 =?utf-8?B?VVVoZk5teGlpVXhKY0QrUGlMRWs0WnQxSU9tZktBYmlWb3FzRFhnYVBSUFJU?=
 =?utf-8?B?US9mWVlSZVJYUTdrRTFPRHlQZG5XRU1tVjI5cVM3T01kU09VMXFybHhSU01X?=
 =?utf-8?B?SlJlc1lzTU84R1ZhamtrNGpGVW13Zkc3SVdSZGNVeFRMVHhsbXhBZU8rbzNw?=
 =?utf-8?B?eCtTTkExZmRvaFgyUnJlLzhPMWRNY2hxQVgvbDlYQTJ6UHFVTURDaStNVmhy?=
 =?utf-8?B?eUtDaVdFT3NzMXlpaXY2Y2ozQU1SMnNUZkhSQzBwY3RRYk84TllManQ2cU96?=
 =?utf-8?B?YW83Q1dTczhPRWg2cmkzTVhhMFRqeXN4ejUyVVRJUG4wZmNXdDF5VUNySlVG?=
 =?utf-8?B?TkhWSXQydzlHckYyNXAzQnBWMTc1Sk56WXc2a3UvRm5DcUo4eS9RY1BxUi8v?=
 =?utf-8?B?VWJaU3lFeWpVRVk3M1dFS3lYcWFHZ3pEYzZ6ZnMzWE1EV0VicGxBVWFvMk5o?=
 =?utf-8?B?ZzdUdXd2Qm44UklGZ3Z0OHducWhhQVFKRUdHSXVCK3FzT3VHc3dTYzhLc3I5?=
 =?utf-8?B?QzhodVZpZ2JVTzR4NG83bU4vc2x5Z2JNSjA0Yk1iUEJPNXJPVE1IMWs5Qzln?=
 =?utf-8?B?bERNNXA0Y0k2Z3FoeGkvM3hwb3VuYnBtMVRoQnpQanMwRUpESDJLZ2hVYkEz?=
 =?utf-8?B?cUVtVEI5OUpEUkxFZ1RqaDBtc25yUmU3WGFKY1JNYTJYbFNEeEE4NHNLdHdt?=
 =?utf-8?B?Skx0ZlYrS2NRMHAyem50d3phNnZpM1o1WWUxcnRHOHp0OFBOWkxZUGVoT3Aw?=
 =?utf-8?B?VnFheDczRWZCM1dHQmY4bmZhNUE0RGlvdWxudlJrSm9FR3BXZlpnK0RHbGZW?=
 =?utf-8?B?NE9KZUc0cnd2STJDYmJRakRpb25uc2lkU1dJcStETDZtUy9XUVArYkU2b0NP?=
 =?utf-8?B?N2dmVXBaQWpXQ25ZaWZBdlAxVU9EaEhYVGZJRVJPa1VFeXEreTRpbUZnZ3NS?=
 =?utf-8?B?VjVYT0g5TW1PUVNLU0hpNUMrU3F3QXZjYXlaQjZRbTdKUkU0aVlBVUUzYVF5?=
 =?utf-8?B?WHI3Qmh4L0tpR2tyU29saFBmRlpwb1U4SGxvM0JhSVhiZ0dIWnFJdHVUT3Ir?=
 =?utf-8?B?dDU0MDdSZUUrT1pUMkMxb2xPV2dZYUVueVhnTFIyS2hjcFJFRHFHTEY5L1dF?=
 =?utf-8?B?WU5SWTExTDdEeStIL3QwMWJqR3RrS1ROM3dZSy93NVhEcks5Q2UwVm00Umsv?=
 =?utf-8?B?ZWJBMmFpRnBhRTFNTE1YVG9PV013blE5eG9FTTlnVGJxWTQwRy94Uk50aUx4?=
 =?utf-8?B?R3diaTdlWGsyR2MrSGE4RitVdktsSU50RGxQMFNaOVNRcW9sK0Z4ZDU0eSts?=
 =?utf-8?B?dzk2SHN1YU5Yc05VVktNQjdRblJ4QjRuL3RZRHNHaWozNW52eVc5WjNkRDJ4?=
 =?utf-8?B?TnFpbWhYMFNVbWZFcXp1eG9CWjdKY3ZNdGdUTm00NkVpbkRwWEtxbGlCa25I?=
 =?utf-8?B?YlM1Rzd5MGszdE93Y3B3bkdZeTRmN3UvK09FT3ZVL0VpaUg2Y2JERnVWejk3?=
 =?utf-8?B?TFlCTEtPUGdHUmxqcXhEVTNsSys0aWF3S1lZeExVYkNyNjZZcVBTZmNRTHhW?=
 =?utf-8?B?Rkl5UlNLR2VCRS9XMzkyM1RUVTY4TzdMTEhEdXhQVDNZSG52RjdjUVE3RGFp?=
 =?utf-8?B?QTQ2YXRqRlZGd3NzZHRJVEUwM1BwV3VDSXFscG5MV2NnYXB2bVh5L0pkWHF0?=
 =?utf-8?Q?pfKQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eacbb5-a4b3-465f-88df-08dd5d169625
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 01:22:54.5750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iu+AjWhYBur+9JvBjX6ZTEn1JJt9cP/0WsMwBZBRP3ji+4PFRs3mb7L6UEhOlJIBoBtKrML+J4YULnX0mJMSWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420

PiBPbiAzLzQvMjUgODoyMSBBTSwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gK3N0YXRpYyB2b2lkIGVu
ZXRjX21hY19saXN0X2RlbF9tYXRjaGVkX2VudHJpZXMoc3RydWN0IGVuZXRjX3BmICpwZiwgdTE2
DQo+IHNpX2JpdCwNCj4gPiArCQkJCQkgICAgICAgc3RydWN0IGVuZXRjX21hY19hZGRyICptYWMs
DQo+ID4gKwkJCQkJICAgICAgIGludCBtYWNfY250KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZW5l
dGNfbWFjX2xpc3RfZW50cnkgKmVudHJ5Ow0KPiA+ICsJaW50IGk7DQo+ID4gKw0KPiA+ICsJZm9y
IChpID0gMDsgaSA8IG1hY19jbnQ7IGkrKykgew0KPiA+ICsJCWVudHJ5ID0gZW5ldGNfbWFjX2xp
c3RfbG9va3VwX2VudHJ5KHBmLCBtYWNbaV0uYWRkcik7DQo+ID4gKwkJaWYgKGVudHJ5KSB7DQo+
ID4gKwkJCWVudHJ5LT5zaV9iaXRtYXAgJj0gfnNpX2JpdDsNCj4gPiArCQkJaWYgKCFlbnRyeS0+
c2lfYml0bWFwKSB7DQo+IA0KPiANCj4gTWlub3Igbml0OiBoZXJlIGFuZCBlbHNld2hlcmUgeW91
IGNvdWxkIHJlZHVjZSB0aGUgbGV2ZWwgb2YgaW5kZW50YXRpb24NCj4gcmVzdHJ1Y3RvcmluZyB0
aGUgY29kZSBhczoNCg0KT2theSwgSSB3aWxsIGltcHJvdmUgaXQsIHRoYW5rcy4NCj4gDQo+IAkJ
aWYgKCFlbnRyeSkNCj4gCQkJY29udGludWU7DQo+IA0KPiAJCWVudHJ5LT5zaV9iaXRtYXAgJj0g
fnNpX2JpdDsNCj4gCQlpZiAoZW50cnktPnNpX2JpdG1hcCkNCj4gCQkJY29udGludWU7DQo+IC9Q
DQoNCg==

