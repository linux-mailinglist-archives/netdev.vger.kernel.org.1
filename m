Return-Path: <netdev+bounces-289401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NHLHrdGDGp/cwUAu9opvQ
	(envelope-from <netdev+bounces-289401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:17:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4E57D5AA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD6BE330EB36
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCB93F7A99;
	Tue, 19 May 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="BVnBcL27"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D53932E9;
	Tue, 19 May 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187285; cv=fail; b=AYqIx0eL9NwXwKxtpVHKJwyY/c+nK7qP2IJclse+jB4qzDEj7LUMAv3vOZMEMtv0tsEUCMisJdc9+i7MMNvMv698ZEqJxBrGKz0jlXmFbwRWwvIy4E8R0HL7cMObiB6OgFvxMKLSMwFIz+A+N4lysYQjJfYM3+jUIpssz9KdHaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187285; c=relaxed/simple;
	bh=d3IAdFvEyYZg5k9glfWZdYWlrQnJenBPMn5hrjc0uA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rEhcvDWCOjG4xvpk/z/OR0Zp7w3WZH1siJwHw/bL3A+TwCaMXiIgp3q8QHlOzWHlsTHm3NaUfry2IZ9LDR6Q/dAU5ED4kCmyxm6C8Dd06WePKt1lWjcDPW+PCCjlJl45Lx5CM5+WfQs/XzVUobrdl1zqrRKIcCcQNiFaCgjbEcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=BVnBcL27; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J2of8Q2824050;
	Tue, 19 May 2026 11:40:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=gFuBBDLP///7wjGUJCOw3a
	56vCNdijjQkauI9LVRixM=; b=BVnBcL27phoBMukjvevMQMUVDorMnB+s8RCHNs
	yy4d0DErJYSxydlasICRVyHFqcWGxp3nmzXCiwfwdVa3dya6no/K2SQyZmdA8gCP
	Q1UeWEJF1aj9q3/zhHkI159PibVyROOvtC1cQDMwTZrwzuKeSguADjj7bImJ8bcF
	49uxsHMH711bxfI7+3NIa9/LbEQW0RKsKI9OpSeMe30wk0+lts2qQtenFB61enrH
	Dxy7l5F3eX68UerIs56Ji83CIWNZJJ6Pg1Gj0vxwQn+2xaNM4sfCBgFr6N+Ja6Zf
	3EOC5ooYiti4ylVjpMoY1rhUvKEM0L3IjGJ2kLXB4hU4P6iw==
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4e6gy9gc4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:40:12 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
	by prod-mail-ppoint7.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAbATA011877;
	Tue, 19 May 2026 06:40:11 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4e6kwwgfnr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 06:40:11 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:40:10 -0700
Received: from DS2PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 05:40:10 -0500
Received: from SA1PR17MB4708.namprd17.prod.outlook.com (2603:10b6:806:19b::16)
 by SN7PR17MB6481.namprd17.prod.outlook.com (2603:10b6:806:32d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 10:40:07 +0000
Received: from SA1PR17MB4708.namprd17.prod.outlook.com
 ([fe80::9fa:d156:893e:6287]) by SA1PR17MB4708.namprd17.prod.outlook.com
 ([fe80::9fa:d156:893e:6287%5]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 10:40:06 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "willemb@google.com" <willemb@google.com>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Glasgall, Anna" <aglasgal@akamai.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "memxor@gmail.com"
	<memxor@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>,
        "clm@meta.com" <clm@meta.com>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v6 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Thread-Topic: [PATCH v6 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Thread-Index: AQHc269P0pBj6PkTkUq64GFX4wg1krX9s8aAgBeMhIA=
Date: Tue, 19 May 2026 10:40:06 +0000
Message-ID: <4C02515B-9842-41C4-8221-FF7807FEF788@akamai.com>
References: <20260504101759.3319427-3-nhudson@akamai.com>
 <2f7f312ca0ffaa0a9bf0ca5e33b83dc035a9df051f557edf68378f23921c087d@mail.kernel.org>
In-Reply-To: <2f7f312ca0ffaa0a9bf0ca5e33b83dc035a9df051f557edf68378f23921c087d@mail.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR17MB4708:EE_|SN7PR17MB6481:EE_
x-ms-office365-filtering-correlation-id: 46273537-2413-4b29-93fe-08deb592fe11
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|7416014|6049299003|376014|366016|18002099003|38070700021|3023799003|4133799003|4143699003|56012099003|22082099003|4053099003|4013099003;
x-microsoft-antispam-message-info: JMQ+4R9dHsdSsCzbhxRLj6pcTH9QkdeaNv0UP3w9tEqhBQwqXMJig6nHEBIRTfYaRe6+mhymUOHtzXQ3/nwXumw8lpQ/Zyz7Zdlk3w1h05m14BW9ZKv2sMSS3qWAD8fRcd7nap2zs2FO2chNE0JsoPi9F2nrmZJN7TIqvm4nm5sKzs1THF+FxKqRDYAGW0KnQVzhGM7ixoW9007MFWGBxXPElLvh0OMkVLqhqadyK4k4MqdRC+WYQR1Ig4GT6k6fyx4yM2V3O5wUbcvt2jMMT2euQNOASoKlD/8DrW3FPVKHzfkpPb3oUshMfBvvfhXmL2Kdn/ADfn9g7tVe6gbXgIYLZ+Bs9cIUCtRn7+wRumRyDliapNmk/TkwqUxLoFb0dx/la+G+uAq70wVtEfw+0ms1aEZtLTe1JhilTa0YTgIyCH39tzR3opVIKjztu44Eq0Coykm5xxOT7qBk7dihRXpRuC4beum2P9r9sNE7XJopAlUwNHZhOHM5FHyf9mzjyQuIiGn3GDnEU247zqZWsOr3ob9rcAcb8+Ss05h5BpHZnq2nCWTbzs03bHpwqXgNnVJS3XgwLRRgOmgoZ40rm+wptT8eW6dTIXLcINegLUphwmmqkEw6mvlDiB3c2FzPmAzxhIPbHYkuF/LYgVj+pn3fPQf/vpMFG1THvVvfzqO3o/LkKfc2NkaRUtAqgjWP8K7vIXlD1nEdzVIh6o++mhRzxoMDEUaQ2zD1jRNxZHgqeIHhmL8x3JYF2Gb9h4sL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR17MB4708.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(6049299003)(376014)(366016)(18002099003)(38070700021)(3023799003)(4133799003)(4143699003)(56012099003)(22082099003)(4053099003)(4013099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFJVZllQRkJSSGhqUWlmb0hpNVF2b0hoQnNxUE45dmppWlYzQ1daTTBoZGVk?=
 =?utf-8?B?Z05vMVZkVWE5WWZ3ZjUzaXpMZE1KZWxqRHoxQTJqVVFYcmNJMFBrbVBPUVI0?=
 =?utf-8?B?Q3c5OXhWbEZpd0hFZTY4d0JnbWhoTjc2cmJkK1hoUVRPd2NUZ2dYL3QwTFQv?=
 =?utf-8?B?ZHVYNTRuNUR0UEw5NmxGTGNYc2pqNkNlWkNMSnhKcG1YSEpNb0JnazJUeDZn?=
 =?utf-8?B?azZDdkFoOEswRWpndmgxcnUxVmVQeElmWGRzZUFBRHo0a1VrNmU4dVVBV1pC?=
 =?utf-8?B?V0c2K3c0QW5qKzFISWF5QzlteGhacmpkWjdGUmxWOE1oNHNEOFUweFBWV0dI?=
 =?utf-8?B?OTRjRGpqcXVWM0hZbzBhVVZTVVV5bzRPTjh3MEsvOFJoYTRpMS9HSWJvM2di?=
 =?utf-8?B?Zm5Jd2hSVTg1dDIxRGlYOFV4NGt0VVFPMHlNRjc3eEo0RTRBRHpDSlcwaDNG?=
 =?utf-8?B?cGI5NHJWZkNHaXE4TFNIWGFrM1lleEQ4YWRlcGtpVjFleDFQYWt0cUhxWmlr?=
 =?utf-8?B?bC8wWjZybjZ2NzhMdlV0cHA3V2dTNlc5OW5BTWxUbkFlaTZQTFVHNHNZVzkr?=
 =?utf-8?B?SjdYejVQd3dNR0RFZVNVUks5cXR3cG94ZmVza1FxWVpOUFIweGlvNlJFY1Nz?=
 =?utf-8?B?ZitpVGl0d1pTQnlaMUtjOWsvdi9VekhCTisvUmNFdWc3Zm93emFWVDcvSEow?=
 =?utf-8?B?aGZEQVE5M1lZLzJsNjNyZWZFYTRJRW1TUjdPYkQ4Q0ViZlFEczJqQnlYYVZm?=
 =?utf-8?B?VTVlVEE5ckVUbXBYTmFUU0JhNVBuWDhDcWVYamJWeXZUUVJvWUk5bDhjWGxl?=
 =?utf-8?B?RS82MGcweFAzcHBEN3FKUEJmdmhnR2xuWjhXaC9aVHNFL1JodlhFcjNBQ3lp?=
 =?utf-8?B?SmV0djB6OTN2ei9VMXBMdVFjTXZoa1R4ME90ZnZEc3htZWhoSFJQd0FCY0Vv?=
 =?utf-8?B?WnlSNlRmMGR1bGpOaGVRV09nb3Zac0NHeXM1UmtLNjAyOXl4NWgyT2U0RjNP?=
 =?utf-8?B?eis3ZTNyaGw5Y0FJaHNLaFhXa2RMM0xrU0NGdmZGbmFnaVVWREp5Y0dvZllx?=
 =?utf-8?B?T2pMbFkyOVhlTkhwdm5RM3JBTkJ2MmVvLzhOMlJXaXArVmtOTXpIRVFkcm9J?=
 =?utf-8?B?VE8ySFFaVHVkeVBkMndhM0RNRXJtc01FdXlDQlUwZmlvMCsyQlJucEhVbHU2?=
 =?utf-8?B?cCs2dEl3cHpFdHVPZFhCUFB0L3pITFI2ZTJFRWR4RjFLamFQNVUwV1orUk5U?=
 =?utf-8?B?c2NhcGNscldxdFJScFdOdjZnemMwMlhDM0NoYzZYMGtvd2phTURwSXFPYzdU?=
 =?utf-8?B?YzBiUTkrQkxZbTQweG8xU05SbUYyckFob1hDY1RUZXJTSEhJd3pRZGMxOXdF?=
 =?utf-8?B?WFpXemdjTlNPVW93RnhjbGp2bXFlOFhBYTFVaDlUWk9sdy9kcXBOdlZOY3hC?=
 =?utf-8?B?a05OQVM4WXprbHJlSzdXYWpoQ2ZVdjNpOWo1ZEVUTHRIdnk3bjZUWklMTDd2?=
 =?utf-8?B?VTBaWWxnVGJqZ0ZQZjNQWnlYTEp1ejVlU1pGcUp2WnNrdjgwZnIwMWF1TGZa?=
 =?utf-8?B?ZlcyLy9uVFZCOW9lditRNDd4NGhZcXgzd0JjWmxpMVZqVTR0NDYxSHFTQkY1?=
 =?utf-8?B?MjYvNllSZE0xOXYrbnR5V29oRXN5eWlHdkxVbkVPdXJiUWI2ZTNBNzZGb3BP?=
 =?utf-8?B?WEFTaHphRlRqbDV5Yml0d0N6ZVdGY1Uvcmtla2Z0UyttUmtGc2IzY1gzSlY1?=
 =?utf-8?B?Z05GWDQ5Wjd2VjBpYi9pWHpiSy8vZjV0YzAyamdQenpsUk81Rk9XbzdTZUVP?=
 =?utf-8?B?RzJVcFRKeXJvNk0wNTNyb3dsWlRwMVZOYnBvYUdDanB6Y0FXS3FtQUgyVjN5?=
 =?utf-8?B?U01YOWMyYVMwaEoweFNKR1h0NG0rSCsrTGg5NEdlK0VpN1EzdlU3cVZQZVVo?=
 =?utf-8?B?VzVZVzZGb1E2OUg0Qi9qZUFYYnUyTVd5RHZ3TTJYb0RGMkVHT002NVBic3g1?=
 =?utf-8?B?QzFnS1hwa1JBUStpRTZwZEErblhQL3Z1Rk5MNEtHTWdDTEIxbi9zenorWUtv?=
 =?utf-8?B?dmJvVDBBaVU0ZzJRaytJT1BBRC81RUlUYWNDOUVTZzRYYmQ1YW93YnJIQzlK?=
 =?utf-8?B?UnhIVjBIMGZaVHRueVdqdXdBaUY0Y2pJQkxBN2o0cXJpOWtpalZaQkl0SlNI?=
 =?utf-8?B?ajZmSXp0WFZJcEN5Y29KTVJoR1MzenJOWTd2SkFqMVppa1hRQ1haNE5kMzhS?=
 =?utf-8?B?OUdhVTk5ZU9OS3dNVTc4SXNYeEMyMmw4a0FOKzJQTFM3Wlo3TnhLbzVTRzFn?=
 =?utf-8?B?ZWxsN0xleDM5OXA3QlRzeVhOYTZFUSthOVh5ME94blI2Zzg1Qkp2Z2xDZEdy?=
 =?utf-8?Q?mbwYzWC9UYAvWkyYJ0Q+oIajC/6ko7vAsFPHZnb7EnBCh?=
x-ms-exchange-antispam-messagedata-1: VhBJZZRZ69M49g==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moZBehF2E8w9jpZUz8TOlOdoiCN5skChxjDfOtfh25+50OlOfDVtwu3gVt1QToVz7y7XOjZ8OP/H7nPna+d0nHx3t6aatQE7ovHrsoQWyBO6xN72dZttjDBwpJ3puLGiqJ5L8ZsSR0xnCZo6XPIAE9W44xNGYN5hIvjyB8Tzcv7KfPlcK6MpgtFRM3TrIbuB6Hliyi9dfsIHWK/JesbgbJ+2U+H+Zn6G4PEuMmW6B0pdFYQmgIdhY+O5FCI6r36ONtkEhbuqEOhavUTYyqji1I0/uv1Zatf1oX+6bzNC9gT4MfxFjgv8CWuu66xNwFYIOBx6u3PYEVl56RMLpmSUlQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXH9CAdr6dvdhs8MAJX1y+kuS6up9j2XOl44hjiDOhM=;
 b=lDxId5hQLfptlIK+peiCOSehMU5Sfq+AwEjEODgFOfWWLyDPEE4NA0Mk670zR+8lZ0egxgJLIPTjHcK2YrV+KdTEn0iBFvYYtIZnHow42rodmfI1qoP8RUrukUqlMbig3RK+466ygSLVeyGlgvhJ1tBdMkZrku0QybmmkiZlZSOZ2vfRlmSI2nF3RWO5OtICJt2avmWytkaqX+HjTENZOgKD5ccwuBq9cQo8Pdsg0bmDF/0Ul3IvghQAPOYqbMKqezGJxObGtziA1XbHGULEEWWAj4uWloVn6BhPt4pm+lBfFKVU521CId0euGz/zxXEGyQU9hNoLAInkyCTwjfzUg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: lff7vQhqxr5cWvS5Rc64nmBRTZCshj3Y/qybAjfcrPfSnDmRuKn74qzny5Vvlq1NI2qcxg1VVGh+54PfQVP9bcxlJFRujESFQgFTPLrF061oTvCnDARDRwsQrLcAz+/WegUo650WinsNnNbkh1mxM1Y0NxcNh3ouLG3D4K6Zg1jEu91i3VNUnfSqdbY7qhtINDWiVXMnoGNSibBgWxvl/H/ZwmfszMF3qKqtEZSA9QWfZ3yKQW9lWZmzoUVBnHzi9tsNX9sTUjUJq13nOPOSbMPxrzKgXWbdnDsRPkH7aSgYsKV6NSZY3xZGoYBx5Y9gqDSPEom8KwrGbDzqruLO3g==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA1PR17MB4708.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 46273537-2413-4b29-93fe-08deb592fe11
x-ms-exchange-crosstenant-originalarrivaltime: 19 May 2026 10:40:06.5049 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: f1xM1EufS5GcwrZ+wlA8j8s1LSABN4o+NZUTaA1ogIa8w12S/uxIKZxYSs6ltwtv2iuazj2j4hm6o/kN9TFM3g==
x-ms-exchange-transport-crosstenantheadersstamped: SN7PR17MB6481
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_40102A48-D8C4-4A49-935A-DB7FFF0CFE07";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605190105
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a0c3e0d cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=VcQvXEo1OZcA_IiPcy3B:22
 a=VwQbUJbxAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=dMqrx2N7_LUmwit4YioA:9
 a=QEXdDO2ut3YA:10 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10
 a=30ssDGKg3p0A:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: FFZjBivbN83WF0ETUcF7K8ZyackC6tjt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNSBTYWx0ZWRfX3EnWKTDKhkpP
 x5jsw1WXgyAdpatr8ytAtG4A5OvyQbj3zcGk9Ef13lMNVKYdSlSsAHYHnFrD4RqPwoSPitDYqZ6
 +ltB2TQJaCNyybgt+LrEesaiiH9WBqOpYeKpUYmFSDFH7n70MXjEafIVr47MtAivxtgbx8BZc17
 SPAvsv0UCfVEWRLxnq+5fa/JH8H/flGcWBGzMNe+YH/+vKY6GrT9UloYQ0z6NL1og+CabeVCuD2
 xdvIiTdtpFgX3LishSTXjocrm/mNSlk5y6KxDRTFxqA+vZM3rqC5VqwKxF2a9vD7HbSPeAMbqNY
 dPSF9uq11Ocen5ipIo7WaaXoA9GsYkoFXzk/vXcNIIBZ3Z7zB8k+xgoADJRIqLO1j6e1EUCpcv1
 /vOYdLAjI4f9I1TBFi4/AU/EF7/vYGjIGC8plxGMH1l7c9gmrtGZtnWVqPe6CBEgW3JlFDM4Dft
 M5F7a08oyXos0671N6A==
X-Proofpoint-ORIG-GUID: FFZjBivbN83WF0ETUcF7K8ZyackC6tjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190105
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=apr2026.eng];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289401-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,urldefense.com:url,akamai.com:mid,akamai.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,linux.dev,akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,redhat.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EAB4E57D5AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_40102A48-D8C4-4A49-935A-DB7FFF0CFE07
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 4, 2026, at 12:03=E2=80=AFPM, bot+bpf-ci@kernel.org wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3484,15 +3484,20 @@ #define BPF_F_ADJ_ROOM_ENCAP_L3_MASK	=
(BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 | \
>> #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | =
\
>> 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>>=20
>> -#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
>> -					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | =
\
>> +#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | =
\
>> 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>> 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>> 					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>> 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
>> -					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | =
\
>> -					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>> +
>> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>>=20
>> +#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
>> +					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
>> +					 BPF_F_ADJ_ROOM_DECAP_MASK | \
>> +					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)
>> +
>> static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 =
len_diff,
>> 			    u64 flags)
>> {
>=20
> [ ... ]
>=20
>> @@ -3614,8 +3619,8 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> 	bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
>> 	int ret;
>>=20
>> -	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
>> -			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
>> +	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
>> +			       BPF_F_ADJ_ROOM_FIXED_GSO |
>> 			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>> 		return -EINVAL;
>>=20
>> @@ -3627,6 +3632,9 @@ static int bpf_skb_net_shrink(struct sk_buff =
*skb, u32 off, u32 len_diff,
>> 	if (decap) {
>> 		/* Match skb->protocol to new outer l3 protocol */
>> 		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>=20
> Martin KaFai Lau raised a concern in v5 about whether non-GSO packets
> properly handle decapsulation state clearing when =
bpf_skb_adjust_room()
> is used to decapsulate them. He noted this has been asked multiple
> times by AI review bots but has been ignored.
>=20
> The concern is that BPF programs can call bpf_skb_adjust_room() to
> decapsulate non-GSO packets, but if skb->encapsulation remains set =
after
> tunnel headers are stripped, downstream network stack components could
> misinterpret the packet as still being encapsulated.
>=20
> Martin noted that bpf_skb_net_grow() sets encapsulation regardless of
> skb_is_gso. Looking at the v6 patch series, the code that handles
> decapsulation state still only operates inside the skb_is_gso() block.
>=20
> Should the decapsulation state clearing logic handle non-GSO packets =
as
> well?

It is in v6 patch 5/6.


>=20
> Lore reference: =
https://urldefense.com/v3/__https://lore.kernel.org/bpf/2026427201356.-eYM=
.martin.lau@linux.dev/__;!!GjvTz_vk!XiUrW_lWa52Z6SyFVv-QsFfLyqS__CgaUR6OMr=
ziMJ7mU0H6IHuWUsUlMlgqK4gFTRXAqFfWlwBCEnuvvZc$=20
> Reviewer: Martin KaFai Lau
> Date: Mon, 27 Apr 2026 15:19:53 -0700
>=20
> [ ... ]
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> See: =
https://urldefense.com/v3/__https://github.com/kernel-patches/vmtest/blob/=
master/ci/claude/README.md__;!!GjvTz_vk!XiUrW_lWa52Z6SyFVv-QsFfLyqS__CgaUR=
6OMrziMJ7mU0H6IHuWUsUlMlgqK4gFTRXAqFfWlwBCf2uNDbQ$=20
>=20
> CI run summary: =
https://urldefense.com/v3/__https://github.com/kernel-patches/bpf/actions/=
runs/25314425016__;!!GjvTz_vk!XiUrW_lWa52Z6SyFVv-QsFfLyqS__CgaUR6OMrziMJ7m=
U0H6IHuWUsUlMlgqK4gFTRXAqFfWlwBCGL7F3Rk$


--Apple-Mail=_40102A48-D8C4-4A49-935A-DB7FFF0CFE07
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkxMDM5NTVa
MC8GCSqGSIb3DQEJBDEiBCA53+TqKlj0XZCuxTxAxKwyYl3LCkpH9RQV35gbimBcjTANBgkqhkiG
9w0BAQsFAASCAQAOiP1QCDJk93gp7CwdFqW6wH0eardA3W7ApeG47XZiemVHxKnA4RZBFpEl6tbK
88U7rA3URPz61R79wfKn98BeOXfQlMNxVNaW2UqsBj7qDloAbqyC9r6MShDsUCQYiLfw4MTt0d/+
EakVIdJQIcESf4l/b6vFoRXetA3r+6tgddnp9IHm3sPY08u4rQ3stuM4mtSUWx/5LZWlDQJ+BUgf
oGHrOsy36MsBSu9BKRQJqjZES2X1mh5ReM2OTJUO16F3MdDZYNAifST4jmBA8C4WkMgGTCdeHOSd
NNH0JHrahZqV8bGczMSOUld8Bms4RDWBUqsPA2uUArTUDkj5R+2eAAAAAAAA

--Apple-Mail=_40102A48-D8C4-4A49-935A-DB7FFF0CFE07--

