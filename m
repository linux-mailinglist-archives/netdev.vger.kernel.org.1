Return-Path: <netdev+bounces-236702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BADDBC3EFE5
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A74E28E7
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905B3126A2;
	Fri,  7 Nov 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="j6PPgw0D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="FuVKb3S9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6CE311C2D;
	Fri,  7 Nov 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504940; cv=fail; b=Fp2vbstddJW5LoJOsaDukc8OlZgWL5WRujF3LLSkc3g1bwWTj+qOFGq5SeXx2iuu+TetzRBCAei4H2qirJVZcRqueZvuasILNCjCd7OlbVGIrk6o6j2U8UdCHQHdHRkrq1/O9M+SfnZQ3+58lcZjQpNu8UYatt82B5hyH/75Ve8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504940; c=relaxed/simple;
	bh=0yzysfTb+uQ4DPVFwRKjV6zQLGYAJQx4p+jPsF9gADM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IycbdJmwd7S0hPLpfMWq1gUnR0S8r7f1x6YU9x9ghZxUb4HRyGI6pdXLxy2vSZ57iDlJrZVZwAciqLiCFr1B0wp/1Rn8ukUMBVHJUkgVd56U06EN1Baw2VOy0+TPG7A33/NXG06PmOelGtWZuxaDG49Pyde4cTcwbSvEnjcnhbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=j6PPgw0D; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=FuVKb3S9 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 5A77Zq7g473328;
	Fri, 7 Nov 2025 08:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=uGZgBvd3g3trrPoQqFuKS1
	LuayW3prMWRyFI75+WHCA=; b=j6PPgw0DrjFHD7HYl6ff+Q2SmWCYlnoCFrOxU2
	VExErBi9j82ApkhnY4ISQSGSWpU87VRhiDTZIFhqWvHd/cbdBoBlAZw8hDjFh7Hq
	JelhpoSsKhaOrtqfSBZNaDe7jDZ0/sU9ADWi5tlibiGTLWe0QmUpYzdE6gXMql7m
	dCbYcs+Y4k1Hd3FuUkJtIU3RSVkr/a09EcDTBZXagvPXxWDYX1a3A2UwZqhGFe+M
	z8WGyGASMRSs7Oo0S16dOec8hdRZ2BjR3hXTBgv7imqw3klSE3v3Tl7jwedUfHQD
	uTToMr3fTkPphtNbknsdAW3wvkgdUlneVE1w4YUKrLDi8Nbw==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4a8v2d4fay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 08:41:52 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5A75CgTO005198;
	Fri, 7 Nov 2025 03:41:51 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4a5dhwpe1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 03:41:51 -0500
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 00:41:51 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 02:41:51 -0600
Received: from DS2PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 02:41:51 -0600
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by LV3PR17MB7142.namprd17.prod.outlook.com (2603:10b6:408:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 08:41:48 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::a7b4:2501:fac5:1df5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 08:41:48 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Jason Wang <jasowang@redhat.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Topic: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Thread-Index: AQHcTzUYbStDQZGpZ02RBRZ7L04vCrTmfCWAgABqGYA=
Date: Fri, 7 Nov 2025 08:41:48 +0000
Message-ID: <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
References: <20251106155008.879042-1-nhudson@akamai.com>
 <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
In-Reply-To: <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|LV3PR17MB7142:EE_
x-ms-office365-filtering-correlation-id: 5be376bb-0c69-4d26-376e-08de1dd97d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700021|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?Rmd2YXJWUm9iT2QrSVU2b01SbDk5bXZ1TzEwSkMvSXN2cDRncmwrcFU4OFhC?=
 =?utf-8?B?ZG5iTE9NYzdobVIvc3g0UmhFSGhFY0RCeHRYVU8rQ3I0NGhEd0Z6dUFENXRM?=
 =?utf-8?B?NCt3VWZiTnJrSlZkREZZM000ZndQWTNuMFBrR0gzUzhUUDF6RTc1RFdIZTBR?=
 =?utf-8?B?V2xOdnZYTkJxK0pNbjBMSHdvNHZBMnBvQW1xZlZaWFNIZitiNDRvbEtBRXhJ?=
 =?utf-8?B?RGxYL2IwTHFjVXZZVHZ5aHhqUjJhN1JDZzZEWENKTklHZkFmT3lqWGpwTU1Y?=
 =?utf-8?B?UXFsNVlrSzNqWmRNK1dlQ3V1MUdRR09ZdXZNNzBTanI3TTlwejk3SlBreVll?=
 =?utf-8?B?YzFXMjhwMGhRZDdtSU9JNGpwNzFzYm9uQXpPc1JueUVNOFk3ajB6YUpyWkpU?=
 =?utf-8?B?RmRsbHZHYk9jZHVBRm9BLytNK2hxQ0xraXdHbjJJOStqWmtaU05BTUh6bmdu?=
 =?utf-8?B?ZWw1dkE2ZWtFV1FrYkt0TU81Q1ZLaUUyR0dETk01QldkeXVUZWNHdWJuWXp0?=
 =?utf-8?B?RVNjdERZTTEySXZTcXFwSG43ZWQ0a0U5ZnJxVVFOajV0ejRiQUkva0RuN043?=
 =?utf-8?B?MTZCT0JtOE1BR3poWnhXT1p6dzEvYmxMKzdnRTRYdjJFQVJ1bVpEcVJEd2k4?=
 =?utf-8?B?eS8vWUtJRU1OVXovbjRBQmh0aFdUc0d2L1o3WlRDdHI1NWpnSTl4WUc2S2F5?=
 =?utf-8?B?ZkNERWg0Q0JvM1JqM1I5RXVoZVoraXI4YmNyZDEyVEJ1NG84NUQySm9RR0Rs?=
 =?utf-8?B?djF4OE5sTXIwc1E1TGwzTkpwL3NTT1VLWVpYOTVheGlDYkwwQW1PVnJpcWpk?=
 =?utf-8?B?VVE2RHBmb2M5aEkxNFZ0M2M5SkE1Y2NyZncwU2JjbVpvNHNBbVNoelR6UVVq?=
 =?utf-8?B?NHNmdk83YkpLYXczOXl4em1PSnU2bytrNjNQRVVWa0pWdWYvcE1CRFdmR29r?=
 =?utf-8?B?RHNoVWhXQWsrek1hSWVXcVVyT2M0U3dQN1Z5c2tEcnZTWjJRWlZ3Z1B0cmY2?=
 =?utf-8?B?NVRtWFFzY1NxWFNTbUpsTTliK0grT1p0a25QUWdWRjhKWlU5cTFVZURPdDhJ?=
 =?utf-8?B?ZUQyTzF1MGxRTVd1TC8zUGdiYWRLeEpzRlNRSFdYOXFtNmVJQWozZ1JBQi83?=
 =?utf-8?B?RVhCalZIdXJhMElLZlUxdDFJTHRONFZCMXRHbjRyM0xvQTBDOEozRnFDTFhU?=
 =?utf-8?B?eXNQV05xUHRBcUlpaGsxbFljWnJRMmVaUzNZb3grUlFkWVNMZTNud3NDUGNy?=
 =?utf-8?B?L2lGMVRtZWo1aXQwdmpVL0NXVnd2NDNJSU5WZ2xja1UwZU1oQ0tZZHEzYjc3?=
 =?utf-8?B?NDRZK3MyVmxTanliSTJZUnR3Q1N1VDEyL1BrMUdxZm5JdjJZSy9VQmpEa0N1?=
 =?utf-8?B?Ny9aN2FvcXRXWjNVSmxodmh3VU1wYjFJUWZWUGRqd3JGYXNUMzBrRDY0VzdZ?=
 =?utf-8?B?RVpLVGRNalVMK1JIR3N4Y1VjcmtaZ0lnVlgzemF2anVnUmE5bElld3V5ZXV1?=
 =?utf-8?B?Yk1KMXBZU1ZEUVBpbWlDSjdBRXhkeXJGdmZ0eUFtS3RsV3JZQzNldzQ5Q3lj?=
 =?utf-8?B?RE9rS1paT0creGo2dCtnaU9hRk9rMmR6cXpyWVMzdHMxTExOcEk3cjFZM05j?=
 =?utf-8?B?Mk1mUm8zQUVVS0VCSFg5bHQwOWtMS0w3N3VMS3lEWmFMN0dmbG5xbU1UN3JB?=
 =?utf-8?B?N3g0TmJHNzNscjE0VVFHelg3N0h5TFFqVGg4TUlweUdSU1FvNlV0dXpnZmM3?=
 =?utf-8?B?dGFZTlRBNUExeENzanZNVWdpWEROeUUyek5ac0s4UEo5cXJ2OUFsMXY0b3ox?=
 =?utf-8?B?NG92ZmhaTy9QWjhFVzZ0ajJDTTRLdW1WVTNnRmtlY3R3d3BOb29TSzRWOUtF?=
 =?utf-8?B?MDRlRVBlYzhwcUtiWjFMd1k2dThRM3VJYldjTHJucWlrSDNGdnZGNVhGY043?=
 =?utf-8?B?aDAwRlZLNDhtWlhVWThTRjFqbEpnYUMwSS92STZIWFlQWGRhRmVGdkkyK3k2?=
 =?utf-8?B?aWxueklXTlhabGZnR0l1aWxidlJ0dlVVdzgxdmRmekg0dytnN2xFYUxpY0Mz?=
 =?utf-8?Q?0ZeKKG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDFzci9PV3dSNEFtcTJvczVJTXJZdjZIVUwrajJETS9BT0pOanhPd1ZBTklJ?=
 =?utf-8?B?bEppQ3pwMzBiSUhzS1d5TXFqRGNsQnUvWEJmN0VOeDNRQ3NaYzAxMkkzUHI2?=
 =?utf-8?B?OWpvNHR5U05QMUhqa1ZvT0hGR29mUk5KUkxHeUVRa0dNYzVlTVhzL0xqUTFZ?=
 =?utf-8?B?ZGZOSDFhOTRncDhzdERvVzVRZjdWZGlvR0Qya1JkOEhNWVlyOUQ4Ymk4MmdI?=
 =?utf-8?B?eHhKVHZZWnozTVNMSEF6SmEvUmI3QW9lcHJVM2tBNm5rT3VqWDJMVmI2L1Rr?=
 =?utf-8?B?cFFONktoUVFiS05OTENKTkFkUHdJL1pSZ3hVYk1uNm9GVEp0czFPWWptdkdt?=
 =?utf-8?B?Wnk0bEREZTZBTmZEOHlBaDVhZ3lHUUZxdHkwRWV6VmVFVmRRaFlDdGdGTmNN?=
 =?utf-8?B?akZ0ZDloR0Jid0NPNXlBSmRFek1DZ3RDM3hGeDlFV0pEZDlCVnZYUzBVN0hz?=
 =?utf-8?B?Ymh1cElvQ0p4RFAra205QVJOeFlMdnZjZ0JXdUdVdks4bDV0RE1ZSXM2T0Ro?=
 =?utf-8?B?WnBRQm1RQktlSzBMcUJyd3M1Q05hZHRRMVJiakJodzdPK1FtRWtKaUZxY3VL?=
 =?utf-8?B?Y0RTaXIzdWZOWUpkVmNBQ2JnN1FsY0tCRmxEbzlxUDd3TmJ3K0F6My9QOUtj?=
 =?utf-8?B?OGFPNHl1NHNRdU5ISkp0Vm0rWVBlaWlFMndMdWNMcHdVM1ZyR21VOHlCZXJL?=
 =?utf-8?B?L1NmUy8zSW5Rd3RRTmFublBublhreGlZQzhBUlRwUFE5OXV5SXdNb0hQUVhD?=
 =?utf-8?B?WkNyM3Q3eDgzcUtXQVBjWDczVVpXL3RKSkQ2d0xTS0plVVdwbjlLOVFuNDZt?=
 =?utf-8?B?Tk9RbFNnRjdWbjVRNlpNWmYyU0FVbXcyZDhrUllGSi94UWI5TmM3QzN5aFAz?=
 =?utf-8?B?OGhlYm93TURRVzhKNjRqR3ZOQUhQaDJjejZGbWVHL0lyejMraTBqd3RyTngr?=
 =?utf-8?B?cjIzNmJybzBkS1RSeUE5WXA0Qy94SmNmeE5Eb2N4YlR5RkRVK29sRGl3M2hR?=
 =?utf-8?B?Wmo2cW1oUmdOckNSRDA5K25aSG9hR09UZ0R2T3BLOHRGT29XVUJkeG0yQnNW?=
 =?utf-8?B?NU81d001ei9nRE9RSDlBVFRyU204OFptdC9YTDlYbHc0ajMyUWdsQWNvM0FX?=
 =?utf-8?B?bWdqbXE0aHh0b0x4RVZRbkhIdmZYRzdwaE0zcitlU1ByTWh6Sm8vcTM2dlMv?=
 =?utf-8?B?RkJjSnZwd1h0UldnVTlIZ1hDNmlnS2ZzdThkanVsY0lKTUpLRFFMbzVNVWZS?=
 =?utf-8?B?QWZ4emxkYTlvR1E2K09sc01pM0FmSm1raDVpVm41U1haejZtTzBFcjZ5d1Na?=
 =?utf-8?B?WVVxSFdBcXN6UzNsQWY5Mi90aDBueEdtT21SYUpybE4wWW1nUjRnU2Fpdjcx?=
 =?utf-8?B?cDl3eW03TG1zOXNPQkVBLzQvOUVYQnkweE45RTN5a2s1Y21KRmRqUEgvYkIz?=
 =?utf-8?B?eVVuN3p0ZVVycWMwa2kwZ3hVRUROb3A1cml5a3djOTRZZ2lLMkV6czJCSmdi?=
 =?utf-8?B?QVdsSXdGT2J1QStzVUVFbVhlNUh1SWhIckdrU2hydGdCN2ZXS05UdVg1dkht?=
 =?utf-8?B?V3JabjZhZ3JTd2tUZS9MMkczZ29jdUxVR3JKMGF2em1mLzM5cHltR0tSaUlz?=
 =?utf-8?B?V1lJMFdweEYxZzMvNVdzNXplQVIvYkdPNHNkRGdGWGNaejB1SUVQaTFsdm1u?=
 =?utf-8?B?Rk5zc2FwY0c0ZzJtQXVNd0x4TnVXSnQwamJlRTdDSEpnOXNjRlZCaGsyY3B6?=
 =?utf-8?B?R01HZHJITi9PZGxkTXFxQkNvQ0hYTmFKbzhGcDZ0Rld0WDViNVdPSE9Ga0lI?=
 =?utf-8?B?VXU4Rkx2NFRjSU5mZGJIdnFVZUh0clE3QzlDYTVrQk9LYzVINHFmZlBaMmFj?=
 =?utf-8?B?Ly90ejJMTXZHSEFnckxIdlNRYXdnNk9JZVNCbUV0alB6TjlLWEpVY1BzRGly?=
 =?utf-8?B?YTN1bTk3aWFnK21GYmpxQUlNM2hjWi90c3lyQnVXYXpHM3l4MjZacktUQU0z?=
 =?utf-8?B?dFU5VHhrVVBNeE00bGRaYWRnUnRJeFVLbCs4NDNQaVdyS01LYXBIRGNFZXdY?=
 =?utf-8?B?ZzZkTU1tbllESTYwcUxtd0JibWFCNXdTM1N0UndONDFWYjBvOHlhNmhzMFdv?=
 =?utf-8?B?ZG9vOElqcENZQzh0WkpIRlJhcHVJVVJGcDJDYitHSXJsc2Rtc2dKQjFvc2NR?=
 =?utf-8?B?RzVoZjA5Y2FLNTdvQ3BCVzd3aWFWcmUyR1FLbER6b2c0aDJOdUh6cGtOUkVC?=
 =?utf-8?B?N1VHNGNzS09PbTZsSjFTd3VEdTl3PT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM/64L+hW7fv9Os+2wWb+DdR3WklzFL9gWhiNSezix+TDpaLrtCZ8N25VvOPNgCUzbsdD5SfL6tChg5nGWAP1bTwbsY23/BV9mS8CYE7q0UYeUpD62hyQKnRqAACnhxFbgIYZjPBA+A1GnY8ZOcgGM85L4BLjSe2wXOtOZdhOkOtZyYt8IrztyDKzl/OWkX3LhMdzXFvpYAoHZMYco1VT80aPDJvwGN0K6sRb6IvgU0NfXxc7RNjLypjOsXoVt/IyPd00wPGPieWX7Tp0ZfrtlfICCDueRzAubIrkoZeH2W5VhPLsVSwlrZKdJXUF0HUQYUS+YHIC5URB80RW25CFw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUawHqdxYmk4goOU8OKxK1lVCUZCg1do38knExTFfjI=;
 b=hjgho+Dy31X1nzRvP6ixSZpRG68J3wd7AWCROuX7enSoVKltYfAIcwKz3B8P25kYooIjbx+MbGlF8ClErkWG44x7kUHjR/AZvG7B/4nP39C4euhSnvhHIozZHQg1jqMaOFfOTWyyOabymDZnlMysb7GnabiUNga1MIbh7RvrmBhoD48XAlvYSDWwiiCa/AdZ5ZBE+WOAdJnzSyeiYC02iyFIv8rTfoyyKONh7JgQoeHJ88f1ZCGy5YCJSdvFnoDKtxtJOipKs985C4ekG7vRzwqJRHnlQPQizl8emRzItnmMp3lwZX1EYmkwCjxPGc/m70pAkWXGeYR6QvnW+QlwOQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUawHqdxYmk4goOU8OKxK1lVCUZCg1do38knExTFfjI=;
 b=FuVKb3S9XIgh3R0ZdUDyFNprPUi7l4GX76AGC7pAaqGTZTQHoJUI6Q2NndZyAc1t/Di9ZGe1SlC7gSfuVFXDdSczvAc78NDVpxMj+A0U3yIp98BoufdJK31mWhe1R0P+ItbprSPH2adKtorgEvMEgUrceMq9B97T9J83aL2p2WY=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5be376bb-0c69-4d26-376e-08de1dd97d70
x-ms-exchange-crosstenant-originalarrivaltime: 07 Nov 2025 08:41:48.2246 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: AQZ0tpIJBT6PqssUn8OYv9Jbge1YhHAcKym5iSiMeZ7zvcWUtABbUp/fWNtcbJvUiNcGxKtkC7S/GZ/+m3cnag==
x-ms-exchange-transport-crosstenantheadersstamped: LV3PR17MB7142
Content-Type: multipart/signed;
	boundary="Apple-Mail=_22B57FB0-AEC4-40CA-A13A-0D75EE3E4B6A";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070067
X-Proofpoint-GUID: 4u33nHRf7UeJ5ZLT_QmA44JSBiyfyecv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2OSBTYWx0ZWRfXzmEPm7GKiF2F
 UV5rQG5PgaQ4Trf//E8LECZ7LQ2YwLDxKdnwwwUbBlLoyJYuO5ZcxUgRkVnEWVBcBaH5k6ovGHE
 3QpYnQmg2ibizg2hncB+wOTrAYcJo8CFHO4LF93D7GUQvB+9p/GMka1EznqFd2b1T4nTGwFFbL+
 qk2w3NGHEHhKHGYxFzVF4L39uqR3VEBCZ1hSI4aBbZerkoHUvZluUIIOqsOXgZek5ZpocgXAvo6
 pRkRSt6H1ZPw7kft+vwuIMNb4Y91FpPo6t/pLbRCixcy9nrHwBsJknIyzTKmZjsDnTgWoTkP6k2
 OSuHfa+huTnSOE9pKb1MI63zYIQ8Mn7cd4YUTRO08MqAOxpAgJXwQ41dUHwOGp2mTH+nVa9KAP3
 uvKu/dStL0SpuMoBaXSeARfE1zfhOA==
X-Proofpoint-ORIG-GUID: 4u33nHRf7UeJ5ZLT_QmA44JSBiyfyecv
X-Authority-Analysis: v=2.4 cv=WeABqkhX c=1 sm=1 tr=0 ts=690db0d1 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=X7Ea-ya5AAAA:8
 a=C5fj9gR7LNG9JQ1NMG0A:9 a=QEXdDO2ut3YA:10 a=wqFnSJPP-FBafd8uH9cA:9
 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=kppHIGQHXtZhPLBrNlmB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070069

--Apple-Mail=_22B57FB0-AEC4-40CA-A13A-0D75EE3E4B6A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 7 Nov 2025, at 02:21, Jason Wang <jasowang@redhat.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> On Thu, Nov 6, 2025 at 11:51=E2=80=AFPM Nick Hudson =
<nhudson@akamai.com> wrote:
>>=20
>> On a 640 CPU system running virtio-net VMs with the vhost-net driver, =
and
>> multiqueue (64) tap devices testing has shown contention on the zone =
lock
>> of the page allocator.
>>=20
>> A 'perf record -F99 -g sleep 5' of the CPUs where the vhost worker =
threads run shows
>>=20
>>    # perf report -i perf.data.vhost --stdio --sort overhead  =
--no-children | head -22
>>    ...
>>    #
>>       100.00%
>>                |
>>                |--9.47%--queued_spin_lock_slowpath
>>                |          |
>>                |           --9.37%--_raw_spin_lock_irqsave
>>                |                     |
>>                |                     |--5.00%--__rmqueue_pcplist
>>                |                     |          =
get_page_from_freelist
>>                |                     |          __alloc_pages_noprof
>>                |                     |          |
>>                |                     |          =
|--3.34%--napi_alloc_skb
>>    #
>>=20
>> That is, for Rx packets
>> - ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
>> - vhost-net threads float across CPUs do SKB free.
>>=20
>> One method to avoid this contention is to free SKB allocations on the =
same
>> CPU as they were allocated on. This allows freed pages to be placed =
on the
>> per-cpu page (PCP) lists so that any new allocations can be taken =
directly
>> from the PCP list rather than having to request new pages from the =
page
>> allocator (and taking the zone lock).
>>=20
>> Fortunately, previous work has provided all the infrastructure to do =
this
>> via the skb_attempt_defer_free call which this change uses instead of
>> consume_skb in tun_do_read.
>>=20
>> Testing done with a 6.12 based kernel and the patch ported forward.
>>=20
>> Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 VMs
>> Load generator: iPerf2 x 1200 clients MSS=3D400
>>=20
>> Before:
>> Maximum traffic rate: 55Gbps
>>=20
>> After:
>> Maximum traffic rate 110Gbps
>> ---
>> drivers/net/tun.c | 2 +-
>> net/core/skbuff.c | 2 ++
>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 8192740357a0..388f3ffc6657 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct tun_struct =
*tun, struct tun_file *tfile,
>>                if (unlikely(ret < 0))
>>                        kfree_skb(skb);
>>                else
>> -                       consume_skb(skb);
>> +                       skb_attempt_defer_free(skb);
>>        }
>>=20
>>        return ret;
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 6be01454f262..89217c43c639 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -7201,6 +7201,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>>        DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
>>        DEBUG_NET_WARN_ON_ONCE(skb->destructor);
>>        DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
>> +       DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));
>=20
> I may miss something but it looks there's no guarantee that the packet
> sent to TAP is not shared.

Yes, I did wonder.

How about something like

/**
* consume_skb_attempt_defer - free an skbuff
* @skb: buffer to free
*
* Drop a ref to the buffer and attempt to defer free it if the usage =
count
* has hit zero.
*/
void consume_skb_attempt_defer(struct sk_buff *skb)
{
if (!skb_unref(skb))
return;

trace_consume_skb(skb, __builtin_return_address(0));

skb_attempt_defer_free(skb);
}
EXPORT_SYMBOL(consume_skb_attempt_defer);

and an inline version for the !CONFIG_TRACEPOINTS case




--Apple-Mail=_22B57FB0-AEC4-40CA-A13A-0D75EE3E4B6A
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCdAw
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
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJzCCBMyg
AwIBAgITFwALNmsig7+wwzUCkAABAAs2azAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyMDEwNDUz
N1oXDTI3MDgyMDEwNDUzN1owUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1lMOTEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAw+xt0nZCcrD8rAKNpeal0GTIwS1cfPfIQXZHKRSOrSlcW9LIeOG4
E9u4ABGfGw+zChN5wtTeySgvvxE1SIwW13aoAscxyAPaS0VuEJGA6lUVsA2o+y/VD7q9pKIZj7X2
OxHykVWBjXBpRcR9XFZ5PV2N60Z2UBlwSdbiVp0KBXzreWMBXnHKkjCSdnbVuvOj3ESrN706h3ff
5Ce7grWg7UWARnS/Jck1QAEDqIHLSxJ3FhgbJZBt6Bqgp28EqkP+dQxzp//vnUDIwxBzpSICAMsk
d9I0nsdVvHV0evJSjqDgLF9gw7/4jjjQGW/ugHBytYSBEjDFuB0HOat0va8SjQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUWgue6rVjEAcBSPcAqJXWGxAZi9gwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
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
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0kAMEYCIQDg4lvtCdYN
NSoA7BrmrnhzqPrsFhQejDMGHCeY7ECV5AIhAOV93F+CcxakPdapxskTdtiTYz7dbj7AVto5kQkB
66NEMYIB6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAV
BgNVBAMTDkFrYW1haUNsaWVudENBAhMXAAs2ayKDv7DDNQKQAAEACzZrMA0GCWCGSAFlAwQCAQUA
oGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTA3MDg0MTM3
WjAvBgkqhkiG9w0BCQQxIgQgdYWgzXzhq8/crmJikFMjXHohryZuyqz3kzYgTbEfJJ4wDQYJKoZI
hvcNAQELBQAEggEAg+St4Kb0fD7DFQPDtBqXG9J21TtTsQYZcLPpAL/YZBkTobUmggZ5O6450IYH
YSxlcglM94wOq0X3YNCwRFiYS8oBWOYQ02GzNANQb+vrdHlAps6qv9ZMK6gGbNFUrpxsyjEYrP24
4Vj/yaE/+qWbg6FsjvTDnsFw7VvUpfJ4nuA28IksiBQyii5Fy0UBMI7WLhzFQe0EyrBbaBHBi9WQ
6WO9l7t+v9IcGNWeCDlsncfBQNft2Q+YHJugoZasMJ/DBtDUXKp8r3+6I7KVk6ycZyecsf3w+Uya
xkkvSM6kG+bw0Z6jchdBtZv9kMePoqAdm51P6uVrTPNTKV4UZsIIkAAAAAAAAA==

--Apple-Mail=_22B57FB0-AEC4-40CA-A13A-0D75EE3E4B6A--

