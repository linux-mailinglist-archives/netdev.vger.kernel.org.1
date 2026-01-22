Return-Path: <netdev+bounces-252332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OklOVsZcmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:34:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A25266B1B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCCF1763D0D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7E34E765;
	Thu, 22 Jan 2026 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bnbOI2tT"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464D330D26
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084146; cv=fail; b=qIr1g8XQMLXOclTTVK3sZhiEY/H/sDOPutbONJlljPy2tMJt5Tt3xKIjWFfcqLRRCXQ3T3BrY4+y1MPeiIM1nM1CcyrjfWWH/EEyJUfodBvtI5iCiPP+wpVlUPL2vqUEnyrWcaun5lC6PxC7pLTP6oWtOo/wG7PE9Mr8r22uoqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084146; c=relaxed/simple;
	bh=6scX0ECxuuuuoeUBZhT70OC0G0dtQoNW63XzKrZtgS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ug9TPK90ULcdIvC7pK2UgO25cFEtVi1Y0n3bAIDxXRlbcZz5REicv4jSRDo0RW2Aa/sEjOkMLxlVDzOhTOdHzd71EloL2MfFnLwahwHOhho0koUJpyhpryuCkZow69sjYwj1WZrInBZAWpCdOyjGAdZ4vRTf2Z1iKcMzLSYlw9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bnbOI2tT; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bwyrpr8x1+cgZv/vPmAU7o4Gt9j9TqknM1XWd5CCzBMo8AQZnbsUONH7sDJMMy1stipMh437iDvie55wCdGammnaI/u+N35vouJ+qFtwTWXIMdkXzr1HamDwWYipfTneEI0kaal8t9/uWAzsqIUs/jsi8OLznWzdN2L4ofSjNftmMt1GrokCVXtieV6zaWiyegTXJUQEiZ3nzmm1rLBE5Fje6ywSiur4KKd4kSdzKVa1lXSUaFrI6x2v9i8jVA2d0eh0FB6FvXGx1gL8OsP7v1ZiBmpZEYd8zHNFvTm7TTh01P/pidU8V6u+Z59ZwPOh0lreO18yrmSb+5FOY5ofoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6scX0ECxuuuuoeUBZhT70OC0G0dtQoNW63XzKrZtgS8=;
 b=xHqq60OFZyvt7AqHm/6CKHHewHtfABs5Ctw9ex7DqraIAWLZgQEySYoi4v4oSsyvi5djaMrp72IMf0keG9IQFX3LC5xfPEIBor96O3PD2ibSH7Bp3aJkXNGq7RV1nd8pJaRWn6FeDPGXi4Ncqwl6lvVIgIYKAGaiVfTIfh/Lfgu+hIPZqSgGwcfYGy9Z6OjFfCONCu6SN+V6ssSnzTdyDiUXtC+VA1F4L8D5iEunEyHFXwHOnOwrRvlvZfpZs8YoA3utBL0bc7885kCcr73bCw5O1XGyDQye38yI/Thz86Nd+rc4zzNLJFnz5vcvETHt8U6Zj9xR/VuF4OMrT9KNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6scX0ECxuuuuoeUBZhT70OC0G0dtQoNW63XzKrZtgS8=;
 b=bnbOI2tTk7Z6mbcLWxcpxAR1ss56TZgtafWmFNiXM1GWck9Qh14j6TXHlyKczKEv8xY5q7o80bpkT7Smn2+t6Aj5eixhUeCKcg1cqBV/4/R+JU4QDchOe/pO/ksxxnO36KdEb4YsFAfzRCB4UZ9ysUNx3L9d3y5Yab56szAFPiyCXMQrRt1MDLlHOcgr/9s1jNzaK6i4Gqj8Em4oj7rXfpSz3axPGhZp+XOSl8yVzeqErIC/fBIU9hpcp16FEaVC1Io5bvuKfJwehSLdu3tW8/r0PLv8246+l/XVN0FNsG06cw/rzRcNQht69vYoMqhUYZkUT2S2arnyIWmCOZ/oDA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS0PR12MB7770.namprd12.prod.outlook.com
 (2603:10b6:8:138::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:15:37 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 12:15:37 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Dragos Tatulea <dtatulea@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Topic: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Index:
 AQHcf8MYq0aPKotsqky8aDx5Wvpp8LVJpWmAgAAUJACAAAe+gIAAHPgAgAIn0QCAAlfUAIAB2Z+AgA36kwA=
Date: Thu, 22 Jan 2026 12:15:37 +0000
Message-ID: <cbd86da13416db43b018299bfe3a93707f301311.camel@nvidia.com>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
	 <aWDX64mYvwI3EVo4@krikkit>
	 <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>
	 <aWDvTx9JUHzUKEGm@krikkit>
	 <611d927472c46839ebe643bc05daa2321bd183b9.camel@nvidia.com>
	 <aWLWgrL8UYJISOsu@krikkit>
	 <34305da7654365c3c8ade9cde07cb992f7270634.camel@nvidia.com>
	 <aWZa-6WUc3h2AboY@krikkit>
In-Reply-To: <aWZa-6WUc3h2AboY@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS0PR12MB7770:EE_
x-ms-office365-filtering-correlation-id: 7560f32c-a0d2-4512-e064-08de59aff3ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUtYeXVBaVEwREpRd3pNeXY2UTY2Nkl4SVVrTVlFYnNTNlBtZStncU00QlRP?=
 =?utf-8?B?ajlwaUR3dHQ4eTBnbXRseS9JR2gxRXlWRFRDb2k2dm9KS3dBd0QzZTI1N3lt?=
 =?utf-8?B?djRuTzRoZ0RCaVBsYWRtVkxkb0xPd2JMSDIxRGlnMHJWUDFPR2NKclV6djlD?=
 =?utf-8?B?akZNN3MxVzZNSnZhS3lKbzhyMWZ1eWZ2ZVFreHlJL1ZVMW9XUEp1c2tON2RY?=
 =?utf-8?B?WGxZMFMxenp4bFZSc0VoclVEOXVIUmMzQStkT1hVV0RoZUMvUmlaakVHdXc1?=
 =?utf-8?B?MU81NmRlcHB2ODFob0Vvb1BmYW9SYlNMemErNTkxb2xCQWhqK1ZqL3lnTzZK?=
 =?utf-8?B?UDFjVDJpNFpuNURIek1POGEvZzdtN2xnZ2ZKOHdOTjN3eWFqTVk0WTU5T2dE?=
 =?utf-8?B?Ym10SHZUT0Q3Y25NTWJtbkRVcGVtUkxlVmtsNEdWRjNjcjFZM1B3eDl6SWdI?=
 =?utf-8?B?SkJnc2RvMHgzeW4xK3FjQkY2ejN0SzdoaGh5OHBxTi9YTmwrRGg4MUU4UVo1?=
 =?utf-8?B?MlZZMUgveTZRamJSY0FkTWtIdTJoN2w0ZjFlcUt5UHNZck9vUDlQN2w4MkdC?=
 =?utf-8?B?ZUVhaUlBOUtWLzZYcFlJUWgzR2l0b2Y5cjVqbTZFZlVySVhncFVxc29vRW1L?=
 =?utf-8?B?bFA1dWcxWFM2U09nYlo1bmdqK29hYjQxVnpnZGtjWGRkbngrdEU0ampCWjVi?=
 =?utf-8?B?T0VIcDMwUGJXdTl0RExQd1E5ZE5KbGdxdi9ESmV3ZzIvVkZXckU3MlJTa2dr?=
 =?utf-8?B?RlFRQWtldDNLRFpyZjRZN25MNHZzeWl4WExldnRrVVhaS2pRenlvUDJYRWR5?=
 =?utf-8?B?aGdHczdvUWphVmhTYU5ZUS8rZlBxRmMzakU5VG5lU2VubDVONzJ5aHR2cW1V?=
 =?utf-8?B?U09DWWY1T3ZZdkVsTUVPMHJMWGJ4dE1aUFJMUTRQSE5MRHNCL2hub0RqQm9O?=
 =?utf-8?B?YUVZTktXVTFteXZUVDcwZ2FyZUZhS1VWNTlqZ3RLNXBub0gwVGlqSXVlRTlU?=
 =?utf-8?B?d0Y0ZFlpYWRpTTJ0M1NCWnZEOFp1cFJLd2phaXlJL1BjNFp3TFcyVTJJRWRn?=
 =?utf-8?B?YXFmTVlzSXpobUpxV3cvWUxBOVBOUzczSkhkYVhYK3RVTEtBRjhuMVNiQTh4?=
 =?utf-8?B?bnZ0amFUNi9xWTl4c1VyRCtjcGxicHptSkN1aUwwdDk2MEJWVWtIQ2F5SXBs?=
 =?utf-8?B?Nks2WnpKaGtzMHJsRGU5ZDhaVEQwbUUyS3Vmd2I3T1lYaFgwdzlwMnZzaGIv?=
 =?utf-8?B?R2JCL0grVGxsTDJUQng5T0c4Rk9CdWNxcjJodjdUL1NDUXp3WDFocUVUNFJQ?=
 =?utf-8?B?S3EwclN4N003NmJjeGZjRDlaanZGeFd2S2dpdTE4L0ZiTmZ2UFEydXlCMXlQ?=
 =?utf-8?B?Y25Zc29kLzd4eXVZc0l3YTVWeWdrTENRWjNZR3RrZEdBckJLdjhBRUhXc3g3?=
 =?utf-8?B?Z3RRUTVFK2Z5T2pLU3d5cVpMeXdRVk1XUFFQOVNhd0hKOVYrTUx1REFaVWYw?=
 =?utf-8?B?dy9rMUlIK2dvRkdkRm1yYXZCNC9VdDhrN0ZyeUZ0YlVLY1VCZHk1VTlTNUtB?=
 =?utf-8?B?T1h4VmFYSnh0WXB2YVgrd29FM1IrRG9hU2xCQTFscmx1ZWFGWGY1MlhIN3ZT?=
 =?utf-8?B?R2RnQU0wR29oRUtXRkMrK3dEUnVZT0kzNlFENGRzVEtJMnVxWXFrVkJuSVBt?=
 =?utf-8?B?OU9xbFN2T21Kd1Fyd29Ea1pVaG5PZUdjdkt6dWQ4SUR4N1RHN1JQN2JYb05O?=
 =?utf-8?B?OVd1WmFyUlhtdURXdi9BdmFJd0JvQVlQelkxUzJrMFlVZyt4QTBLMXR1TGRC?=
 =?utf-8?B?bWdNTGZOZDdENHU5YVgwSCtlUlFHcmV0ejVBN1VEQWNSZHpZRkh5SnZ4cVJs?=
 =?utf-8?B?cXNHUkxTL0pjM2N4NkJNaXVBc3RHWGk2RDFkWStQNitkL2lwL3NKYTV3Uktj?=
 =?utf-8?B?NSs1QXRaT3hlakNCdXFaOU5zbE9rL1VWVVNjMmJCOERJelB6dm50KytGc2ox?=
 =?utf-8?B?V3pYNUhtcEZiWk41VFBSTlIyQkp3elZncFJSV3hPOXd4YXVicGRDTGQrYnUy?=
 =?utf-8?B?R1VNTFRVcFBYeGoxSUZxeVF6WkpiOXl3MDhVQTJLWjA3UStoYUxGZXVtNVIy?=
 =?utf-8?B?L0hLamNwdjVHcDlrT0hMMzh4elJQL0kyU1oyVnFjbnp3T0ltNXhEcnN3eUNH?=
 =?utf-8?Q?ogOIVNZ6qo81Edw5cGwi5oE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0RiQVdQVFM2N21BSWVvbFhWbTJtWWFSTVVnbkxkWVhOV285NklsKzk1amRw?=
 =?utf-8?B?V3ZFNnpnTThPWHl6cGpkL0syTTNPWWlOYUZTeTdYaGlmMkpPTGhkck9OaUpv?=
 =?utf-8?B?cE1iam1xZzJ0cHV4RlZtdDhMVUFYZDBCaG9yRDZqS1p1b0h1U05pa1Z2cW1W?=
 =?utf-8?B?ZHRzT2dKYWlJdVUrOG5JM2NVTFlZZzlJZEdrL0Exd0NDWjZSdEFHOWxtVGtF?=
 =?utf-8?B?Wml2d3VQR3FmMkNuYWo3NnFpQm85TUhPUTZZQ0M0MHFKaUxNcUJMQS9oUGNM?=
 =?utf-8?B?REh0WFB6WnV2UDhPeGM0cCtqTXAyc21jalBoQXNSN1lYaEJuREQzZkViWkVM?=
 =?utf-8?B?b0tBQU9kVnQ3dG5rZ2dyMlMxNWY1SldieEJoNDE4V2ZOT1lieWZmMisxbjJS?=
 =?utf-8?B?N0NHMk9NVC8zOTQrMXNvQlJwcHpnZ2hRT0JXMTkvUHBBcTBKUFgwMW5GZ2lU?=
 =?utf-8?B?L3lrOHV1eXBmUFBaMW9JTTJzWm1SbjNuWWZSL2RTQ0lESzRMQVpjQmwwaktB?=
 =?utf-8?B?OWk4aFl0eENKR1BpemoxODU2T2h1OTM0YmJBdDcrU2kxMUdaa1U3aGx3eWJR?=
 =?utf-8?B?K2MxNHdULzk2TDBwbFM2UW0wMDNUSGY2TlRTVHZNVld4MHBmZ293MkI3Ny9p?=
 =?utf-8?B?aDRwUGZvTWRQY3BFaFhVNTZGYzRiV2wwM0c1cWhHNVFpT2VTTERrbzBRLyt5?=
 =?utf-8?B?MlBGNWN6NTNtVDZteHYyd3Z4SGdSMU5adURKRkFNSVRNWXNaR1NobThjZ29S?=
 =?utf-8?B?T2VFa3lCaHc3UnhPTWs1K0VVbGhuV0ZQTWVGZFVVN3BoMUtiU2RSRFVDWXBh?=
 =?utf-8?B?NGJpUTF0UHJCWGxNN28yY1dFMGoyaEJ6ampqckU0NWpzakRIZklqWWlUQ0M0?=
 =?utf-8?B?MjVRRW1lZW5XY2w4aVZQSGczakROa0pnREhXWG5PT3ljNVY4MTFicVFKbWpR?=
 =?utf-8?B?eG9PM0hQT281NHFVYzhHdVFHazg5TURSVnMzZWdVdUdQeHBmbjI1aXVjTXhD?=
 =?utf-8?B?TUJxZXZlempTbDIzb0NwSEV2eFhBOFU3MkQrblNWdEh2b2dLSWZpVEJtNVkx?=
 =?utf-8?B?cCt3UnVmZVpFd2RFbEdJOWg3WXh2emNKbkF6bVpqN0tjcWx1VVpZZHZhKzky?=
 =?utf-8?B?OVJHMmlJSFIvOFgzdFlreWorVUlJNmZzbm5lVHYzeHlLdGpSV2hYVTNudUhY?=
 =?utf-8?B?S3VERExHajMwb29ma2FhVTFvZDc5eXBscDM3U1JyTkcvelpVeVhLNzdkd0tZ?=
 =?utf-8?B?TXJmcnM0OW52b0FHejUrQWRqNWVSOGY0K2ZLSEh2VHNLazQ1dkhST0dra1pF?=
 =?utf-8?B?U0VHdnpHQ3FRa2lOeGpRQzRSU0RsajQwaWtyOXF3bFA0MTJCaExVem9HZHNl?=
 =?utf-8?B?TE93SURYcWZQTm1ZUEJoSW5meDlzTDl4R2lBWDJZTkNnVlh3Q1pmaXkxVUdM?=
 =?utf-8?B?WXBCK1ZpaUVGMnhPSkhHWnh6NzM1bWNyakVRd3RkejRlWnZaYWQzZi9VdGk2?=
 =?utf-8?B?QS9RbEJmNFpRRmVVYkJ4eEV5QlYvL216allBUk9tNTJiVStMQWlpbGFJQ1VM?=
 =?utf-8?B?VVVXcVNpMlYrVFFOSDBUS0wyZkF6SlQ1YVM0NkF0RklxQ3FvL09mNHk2Z2Mw?=
 =?utf-8?B?YWZkK3NXMlZVSTFWd3ViZFNyRG40bkQrNzVLVU5NRW1ORlM5QXowWEpYUXdu?=
 =?utf-8?B?S3pZTlVJU0ovYWd5eUdRc0c0QjhROTJKbzg3Y3ZTYWF6VUxOZmdnWHZ6dk82?=
 =?utf-8?B?dVJmaEh5NE5mK1pzRThCZmNtTGR5NWFhalJpb1Q1UGxlTXZVYytySHhCM3lt?=
 =?utf-8?B?U0tBeHEzbEhyZkpsQTZnU250U2hPZVdOK3JYKy9vdkxMR05qbXdLRHNoSE9a?=
 =?utf-8?B?L0FwM2FGblBQby8yVXBJZXFJZkZRSlZwQlhHVDNPNXJTVGExZ1cxSzZZb3hW?=
 =?utf-8?B?dEgxRzMwNFJ0MXFPWUhEa3c4U2JrUG45SmJLZ0JMM053QUJ4MXczUUU3UHJB?=
 =?utf-8?B?cTVPQlJ0ci8rOFdsb0R5b3diMzNTajJvWGNiWnk0bjRsTDIwNUVYOWgvdzVo?=
 =?utf-8?B?NC9GdFFGbGRCdE9FSWJERU01WXA5WkZFYTlnTUlrTEhmWGJUQzVQSWltM3ZB?=
 =?utf-8?B?U1VzVUx0Y1ZrNGV6cEh3eUJPN1A2RlNqQUdLVzhpd29IZjFHK29XQXRCMVg1?=
 =?utf-8?B?OXhDc1RqSGVvdGtuY1Z4eks4UnBmazBwNnJUK3ZxZHR6bS84NXcxZUJNZUM2?=
 =?utf-8?B?cElUUEluS0RhcjNLWGtIek43MkRKYkF3ZVZkUG5ZWjdldXJYNGZxekpHTmV6?=
 =?utf-8?B?U3d2RGZpL0NpdTdNTW9UalVhM2dFYzZ3TVRzc3ppVTgxczRWWGhPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43A2EA363C77BE43923010CB928AB253@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7560f32c-a0d2-4512-e064-08de59aff3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 12:15:37.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nndZMVm0p8CgWSyvH+Thz8whjxL16encdjJnVabKorh8yPJSbvInDAiytRXqOi7U4dZTp9JSIyQ0RbAjgCVe/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252332-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:replyto,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 5A25266B1B
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAxLTEzIGF0IDE1OjQ3ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDEtMTIsIDEwOjMyOjE3ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
UGVyaGFwcyAidW5kZXNpcmFibGUiIGlzIHRvbyBzdHJvbmcgb2YgYSB3b3JkLiBJIHdvdWxkIHVz
ZQ0KPiA+ICJ1bm5lZWRlZCIuDQo+ID4gSGF2aW5nIHRoZSBlbmNyeXB0ZWQgVkxBTnMgaW4gdGhl
IGxvd2VyIGRldiBIVyBmaWx0ZXIgY2FuJ3QgZG8gdG9vDQo+ID4gbXVjaA0KPiA+IGhhcm0sIGV4
Y2VwdCBtYXliZSBhbGxvd2luZyBzb21lIG5vbi1tYWNzZWMgcGFja2V0cyB3aXRoIHRob3NlDQo+
ID4gdmxhbnMNCj4gPiB3aGVuIHByZXZpb3VzbHkgdGhleSB3b3VsZG4ndCBiZSBhbGxvd2VkLg0K
PiANCj4gV2VsbCwgaWYgYW4gYWRtaW4gaGFzIHRoZSBmaWx0ZXJzIHdvcmtpbmcgYW5kIHN1ZGRl
bmx5IHN0YXJ0cyBzZWVpbmcNCj4gcGFja2V0cyB0aGF0IHNob3VsZCBoYXZlIGJlZW4gZmlsdGVy
ZWQgb3V0LCB0aGV5IG1heSBnZXQgY29uZnVzZWQuDQo+IA0KPiA+IEJ1dCByZW1lbWJlciB3aGF0
IGhhcHBlbmVkIGJlZm9yZSB0aGUgbWVudGlvbmVkICJGaXhlcyIgcGF0Y2g6IHRoZQ0KPiA+IGxv
d2VyIGRldmljZSB3YXMgcHV0IGluIHByb21pc2MgbW9kZSBiZWNhdXNlIGl0IGRpZG4ndCBhZHZl
cnRpc2UNCj4gPiBJRkZfVU5JQ0FTVF9GTFQgc28gaXQgd291bGQgaGF2ZSByZWNlaXZlZCBhbGwg
cGFja2V0cyBhbnl3YXkuDQo+ID4gU28gdGhpcyBmaXggaXMgc3RyaWN0bHkgYmV0dGVyLCBzaW1w
bGUgZW5vdWdoIHRoYXQgaXQgY2FuIGJlDQo+ID4gdW5kZXJzdG9vZA0KPiA+IHRvIGJlIGhhcm1s
ZXNzLg0KPiANCj4gT2suDQo+IA0KPiA+IFRoZSB2bGFuX3tnZXQsZHJvcH1fcnhfKl9maWx0ZXJf
aW5mbyBmdW5jdGlvbnMgc2ltcGx5IGNhbGwgZGV2aWNlDQo+ID4gbm90aWZpZXJzIHdoZW4gdGhl
IFZMQU4gZmlsdGVyIGZsYWdzIGNoYW5nZSwgdGhleSdyZSBub3QgdXNlZnVsIGZvcg0KPiA+IG9i
dGFpbmluZyB0aGUgbGlzdCBvZiBWTEFOcy4gVGhlIHVwcGVyIGRldnMga2VlcCB0cmFjayBvZiB0
aG9zZS4NCj4gDQo+IEJ1dCB0aGF0IG5vdGlmaWVyIGdldHMgY2F1Z2h0IGluIHZsYW5fZGV2aWNl
X2V2ZW50LCB3aGljaCBjYWxscw0KPiB2bGFuX2ZpbHRlcl9wdXNoX3ZpZHMuIFRoYXQgaXRlcmF0
ZXMgYWxsIGV4aXN0aW5nIHZsYW5zIGFuZCBwdXNoZXMNCj4gdGhlbSBpbnRvIHRoZSByZWFsIGRl
dmljZS4gVGhhdCdzIHdoeSBJIHRob3VnaHQgaXQgbWlnaHQgd29yayBoZXJlLA0KPiBidXQgSSBo
YXZlbid0IHRyaWVkLg0KDQpMb29rZWQgb3ZlciB0aGlzLCBhbmQgSSB0aGluayBpdCdzIGV4YWN0
bHkgd2hhdCdzIG5lZWRlZC4NCkknbGwgZ2V0IGJhY2sgd2l0aCBhbiB1cGRhdGVkIHBhdGNoIGhv
cGVmdWxseSBzb29uLg0KDQo+ID4gSWYgSSBlbmdpbmVlciB0aGUgZml4IHdlJ3JlIGRpc2N1c3Np
bmcgaGVyZSAod2hpY2ggd291bGQgbWFrZQ0KPiA+IG1hY3NlYw0KPiA+IGtlZXAgdHJhY2sgb2Yg
VkxBTnMpLCBpdCB3b3VsZCBiZSBzaWduaWZpY2FudGx5IG1vcmUgY29tcGxpY2F0ZWQsDQo+ID4g
YW5kDQo+ID4gaXQgYmVsb25naW5nIGludG8gbmV0IGluc3RlYWQgb2YgbmV0LW5leHQgY291bGQg
YmUgY2FsbGVkIGludG8NCj4gPiBxdWVzdGlvbi4NCj4gDQo+IFN1cmUsIGlmIHdlIGhhdmUgdG8g
aW1wbGVtZW50IGFsbCB0aGF0IGluIG1hY3NlYywgSSB3b3VsZCBhZ3JlZSB0bw0KPiB0YWtlIHRo
ZSBjdXJyZW50IHBhdGNoLCBhbmQgZG8gdGhlIHRyYWNraW5nIGxhdGVyIGluIG5ldC1uZXh0LiBJ
bg0KPiB0aGF0DQo+IGNhc2UsIHBsZWFzZSBqdXN0IGFkZCBhIG5vdGUgdG8gdGhlIGNvbW1pdCBt
ZXNzYWdlIGFib3V0IHRoZSBvZmZsb2FkDQo+IHZzIG5vbi1vZmZsb2FkIGJlaGF2aW9yIHdlJ3Jl
IGRpc2N1c3NpbmcgaGVyZS4NCj4gDQo+IEVpdGhlciB3YXksIGl0IHdvdWxkIGFsc28gYmUgZ29v
ZCB0byBhZGQgc29tZSBzZWxmdGVzdHMuDQoNCldpbGwgYWRkLg0KDQpDb3NtaW4uDQo=

