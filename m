Return-Path: <netdev+bounces-192938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3CAC1AB6
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 05:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5717F367
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229AC13DDAE;
	Fri, 23 May 2025 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b="JkRggacX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4B2DCC02
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 03:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747971709; cv=fail; b=ELcXgVyD5HXeMnXf1Pnzg2jKcpjRSmJTwRdd7bpK+5TW65hlnGLwvqiGwQS44DLF1ed7AQXMmpJw7bwYNxaWcr3CqNQdtbJEMVDQdtw73miMlAsG1I9TE+L6U4hbt5goz0wzeo94V3YquBMlLT+Hm1QgrShpMM9UhXfVPu6n//s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747971709; c=relaxed/simple;
	bh=ZX/XtQM/FUyn0Q51ZrXDeGiHpVWQFQTIgsnQLhOKMSg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aK0j0ru6pk+RTlVZr+kllwpMUEDaHeyFPHJdUI2g2Miajz7wTxM+7XxescCz3Dhsf/vW5MoMoUtN5paPoO2E5fTaDGpNlSRQQQVQlfnOkjYnPFr3xondGef3Z4HFdS2Khc1tE6efoownB8yW+PbfPQO5wHe7Io5Zk5e4gR8rOr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenlayer.com; spf=pass smtp.mailfrom=zenlayer.com; dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b=JkRggacX; arc=fail smtp.client-ip=40.107.244.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenlayer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenlayer.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGbA0he8ADbNMI6pavZA5Yl6BvDupiJAftol9kweCFhkbTT58//vqUcfUDHNbAkcyfYikB74Wwv9ctT1SGQ1Pfu7VlUs52MUC7KGJQCdvJNmDTlH19OrhznyLsIfmIMhBsuiZQgdY/IDPAgghvC++CAO2KSdUMGl2uJsRgCQ1Z1ueYzCaFpMylq48GIEtuO0znfu7XjB1FPqc6+GI7OWL9HiwAd1mtseImSdbeJ+3UHLGLKIoY+PrVqo35y7NvFtoPL9vMwMAFkhozANrEX1GTNG44i8ghMOhR45ADQFXRSWIVacM4WnBBKc1nXarntEDo5Pu8y9YzBY39I54HTgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX/XtQM/FUyn0Q51ZrXDeGiHpVWQFQTIgsnQLhOKMSg=;
 b=g29MDyOhFBzB8wOCJNUusIlrqQMb58IQgMc6/euYO6uwnsl7tn2r2iAmSmY4M7aJU0ovwH/LVypN1zzvWVH5dxuZcgt4EoGBkj3DLSv+ZatFnUZ/8QvmBrDHonneaYfj2bhbrFlJMjkXl9C7xJU86iTgUePKJRQLVAoPUZCw1smSA3pc2V2SrHl00MuavjEyjxNVVXRL8vVTn0Cf/v8/a7CoLfcqB08Fi5HmLwd++vsfsc0l15dI0wg0tZ7hRahbQGWbWzWsGp5tvYX1uIICbVYrsHXhIdT/nK6vlo+J2rC/XcBvtWAqrns1SWv6g68T+TO6TXq/taI9JtcgW2ktbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenlayer.com; dmarc=pass action=none header.from=zenlayer.com;
 dkim=pass header.d=zenlayer.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zenlayer.onmicrosoft.com; s=selector2-zenlayer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX/XtQM/FUyn0Q51ZrXDeGiHpVWQFQTIgsnQLhOKMSg=;
 b=JkRggacXAaAm/qs+QHp2BuJMiuSa7M5CmCbeevGUht8CAN6A3sXr+ogimlMlRTAtVcw4/mS+I1RmKCgUqWql0FNavsOzqR6qRBnA0UTqXHhGOqNJQ98uhSEQTVuuK8FNVYYraW2qlQaQ49bbY/JrCOTRrHMj8Pm/I1BYxBVeLdw=
Received: from PH7PR20MB6088.namprd20.prod.outlook.com (2603:10b6:510:2a5::20)
 by MN0PR20MB4837.namprd20.prod.outlook.com (2603:10b6:208:3c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 03:41:43 +0000
Received: from PH7PR20MB6088.namprd20.prod.outlook.com
 ([fe80::c4de:594:2932:aa2]) by PH7PR20MB6088.namprd20.prod.outlook.com
 ([fe80::c4de:594:2932:aa2%6]) with mapi id 15.20.8699.022; Fri, 23 May 2025
 03:41:43 +0000
From: Faicker Mo <faicker.mo@zenlayer.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "dev@openvswitch.org" <dev@openvswitch.org>, "aconole@redhat.com"
	<aconole@redhat.com>, "echaudro@redhat.com" <echaudro@redhat.com>,
	"i.maximets@ovn.org" <i.maximets@ovn.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "martin.varghese@nokia.com"
	<martin.varghese@nokia.com>, "pshelar@ovn.org" <pshelar@ovn.org>
Subject: [PATCH net v4] net: openvswitch: Fix the dead loop of MPLS parse
Thread-Topic: [PATCH net v4] net: openvswitch: Fix the dead loop of MPLS parse
Thread-Index: AQHby5SZhH9qitJGx0ufDQVcba9dJw==
Date: Fri, 23 May 2025 03:41:43 +0000
Message-ID: <259D3404-575D-4A6D-B263-1DF59A67CF89@zenlayer.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenlayer.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR20MB6088:EE_|MN0PR20MB4837:EE_
x-ms-office365-filtering-correlation-id: c635330a-039c-45ad-a98b-08dd99abbc57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L21vRXJBSmR5KzNvb3IyUEVFcDY3dWI2RGxoY3dHUjF6V25jRVVNWW9FQkpR?=
 =?utf-8?B?YmtlRzRTcjVzNExRZTh3MHcyTUxMcTNvczNmUitUMzlwS3VIaDFtMVlGbmdt?=
 =?utf-8?B?SXBsbXpaZEUxWlVhaktuWDZiTFFTTFU1WXJFdGNucnFBckZuVGgxMWVycGdR?=
 =?utf-8?B?c3VWVUx6NmVxNUd1aEZCL0dMUk54NHhiUTRsNWIzNkRQVWRmdVN4dzh5VXow?=
 =?utf-8?B?UGw2QzNWdGZZUmgyUWd1UEJPTllRQ1Exdnptcnd3b0pZV1Z5TldWL1NGOGlH?=
 =?utf-8?B?ZDhXL1ZTUVRWRDJFSEZtazhxa3MzSjE3cHFXSkU0NUtpbkpxaURqSi9ONGxO?=
 =?utf-8?B?dHQ1eGVsOXptc0xoaWdNZHBvUU1ZZlR5cFJSUnZlK0ZYSXltamNaL3UyRTM5?=
 =?utf-8?B?NVkzMWo0OUc0TTZaK2pkWnZCM2pFekRTQ3MwOURRdndXaHY2ejFZT2tydThG?=
 =?utf-8?B?TXRLZ2pEN3FyN2cvV3FLaVhSMWNCMjMxQjRPbXoyNWoweHNkM1FDVnRxanM3?=
 =?utf-8?B?SmN1L1J3aXFLV1VBNVZYdlZxTXAxRldWd05WdVdld1hlM09sSE0vZDBxWXNU?=
 =?utf-8?B?VWVaeWN6S0cyeHN5di90WXFFcnRraFFUaDl4UjkvaXhFb3UycHRxbS9rTTRl?=
 =?utf-8?B?RjVBTDRISU5sdlJpZnMzNnc4bnl5TGZZRVlnMkFQS2wxRzZzRjNYTWVXclRp?=
 =?utf-8?B?V0pvQlJDRXJmc2FadTJwK1k2UHI0ZTBRTUJtWUJtaSs4WFUzMG02bzRHSXlR?=
 =?utf-8?B?V2pVYzJNSEVaZlFWZXF4dFk2UC9aTTZDNzdCRjdOaFA0VFNhVmhCcStON0FU?=
 =?utf-8?B?dkw2MTZtRjM4SHdlNUVTS2R3U1p6RG5FMzVJc1dRQlErNEJ0bWFDUXpsbWZh?=
 =?utf-8?B?ZnJaNWYwNTREc216WjVpUllIV21WbE04aEFzV0QwcGlzQ3RUdDlkcnZFc3dB?=
 =?utf-8?B?MmtYS2tIUnIxa25QbUdOWTB5NXF4Q3UzeS9vWllTMnhLL3UyR2p6OVZISFhq?=
 =?utf-8?B?em5PT1FkeWZnOHJ3WlBBSzhHTk1jQ3hXNHFtcDB3L2c2SDVweDQ5ajYwbTJ2?=
 =?utf-8?B?TUJNS3l0NnlURzZLRUJGOFd1aFl2eW40QTgxVUxlQlAzSzFQZHhDd3ZPRGZX?=
 =?utf-8?B?V2ZXbnBPMjBHbHg3V3pZSjVqYUxieUhURGRPVUhLbkVUS0RTZ0hCL0tDOUdU?=
 =?utf-8?B?MytYTXpPTGJtb0hRaW13OThTOVBrOE0xdlF1cHRETEZLd1gyd1RnU2lFY1k2?=
 =?utf-8?B?SjM4M1pwVzB0Vm9zdzVzbmJ6SE1lQjVlNjExeVBua3Z0Nmw0WXJGMVBHeENB?=
 =?utf-8?B?T24rV1BBbjNwUGUyczhFazVwMnErc3VuK1lJU3pjeUxEWHBOWkJ2bEJHRklr?=
 =?utf-8?B?c1didWZ0REVXUFZDbURTOFdMYkhrZXNhK1ZXY3A1TGx3ZThGeEV3bUVIOGVm?=
 =?utf-8?B?TlB1Nm1TeUtVbERaZFVTS21PWTRBNC9mUE5aRFBlMUxXWGRZUWhnd1ZnTEVB?=
 =?utf-8?B?dzJBOTZ4Vkk3b2VVcXJJZE9YR3JsOVo3c0RkOEdXSGhrMEtPTGFPK1BCYmlh?=
 =?utf-8?B?UCtjVjB4QkZXZk1PTzVYTW01SXlLbXNncm9kOEhvZ05MbFlSekdnd2lSZXhF?=
 =?utf-8?B?WFlxc01PODdEVWdabHBjSEcvZ0RzUW82dGtiSGQvOEtSTFdzRXlrcjZFS0Q3?=
 =?utf-8?B?ZWVWLzdDM2RWRHAwbzg4eGNpNENJUGNkMXBlWG12ZHBvb1JtQ21FMkkrcjQ3?=
 =?utf-8?B?RUZjaUREenhIOWxYb1JXM0FXWFVhMmI3Z28reFI5VjZXU2pZVjdsOUs5ejFr?=
 =?utf-8?B?VStyeGpLdTVXRWNocmpEQWhuRkJiU1MvZ0d3Tm1YZUtmZ1RRVGIweGN0N2Yr?=
 =?utf-8?B?NXROZVJHQmovZ1RUT1Zjay9lV0lENFd6S3ZiUXozYkdLVDE1cHh1alhuRE85?=
 =?utf-8?B?VjRLdDZmNlErQXhXWmsveUw3dGpiWGk4R09ieHdZdGtlb21wS1Q0b3N6Tmpi?=
 =?utf-8?B?Qk54WkdSektnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR20MB6088.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXRwK3JQK3R5VkExakF3QkhlVnA2Qm8rQSthS0hpUmc5alUwUDN1ZXlIeVRQ?=
 =?utf-8?B?NmJlVFF5L2FiZUQrTXZseGF2eWlJUzM0cHdsczV4cElrQjh1RVZqa2UyMEJP?=
 =?utf-8?B?S3JTR1QreWY4cm9WV1pibDhhZ3ZRQmJqWTUveHhEdnJ1eVpmSzY5RUpUQThU?=
 =?utf-8?B?Nk5GNXUzNTlSYTByS0U3d25DSVNqdW9SQjRWMjg2UjJISWVRYXpkeWpHcS9n?=
 =?utf-8?B?ZjBFdVZ2Nm1maHhXeFlwOTd3REFwRDkwOFY1amc0Titzam11SldCalloMVZs?=
 =?utf-8?B?WUNCQU93LzR2eVdSVytxM1JheUJ0aGVVYS8wQlJyUXB3L2d5eVVzUWFUbE9P?=
 =?utf-8?B?OTdjeUF4RE1ZeDdnM1p3VHp4M3RqWCs0YTZVblQzVkx6TFkzSzJpdjNVWUNS?=
 =?utf-8?B?ZmdhWnVvMUliY2lYRWNvMGpkZFlLVmJSNGpEQmdHT3JCWkJuaVNrVEUwN0cr?=
 =?utf-8?B?RW80WFFTOU1PWDlTbk9BVkplTVIySHZPVUdNMnF5SzN6aGxGVU1yOEtlWW5u?=
 =?utf-8?B?aGc4aE1zeGJHK0l6S2dxdGpLNklldUtkZGhKWWNLVVBWNE1sVVNwS0M3Vk5i?=
 =?utf-8?B?aUlKeGUwNFFQZWY5WkpsSEloamkwYS9yR1RiOURkWWUzYTFiT01UK2NyVmJ6?=
 =?utf-8?B?SWlHbjVoc2wzUWM4MmtIUEhBK0JCWXJzczhKZnFPRVFzNzQrU3dNYzl1M2NB?=
 =?utf-8?B?NVhKTHZUcFpIZnVuRTVQKzUraG0vaEJyRjhSZTlua3U2L3llUXpDQVYwZWNU?=
 =?utf-8?B?Y2dQVEp6WisySmdiV3JUbk5aWXVSclJpMzlSNWFjUk53eE9mNUtlRVk3dUZs?=
 =?utf-8?B?cWpCQVFsNHN5cGNWNk5TOVJyT1Bkd1FWdTBIV2l3RDNKaXZSL25CRml1TzhW?=
 =?utf-8?B?TUZjUjl1cCsvdFpLTFZ5YTNDY1JtQTRHZWN4RkJXYWJZYWpCb3JkQnk0Qmcz?=
 =?utf-8?B?WnkzTUFhVHo2bUxEQm5pOHcvZk9Ca2o3Y1JGRXlhaTErQmh1d3lpeWJrc2sw?=
 =?utf-8?B?OWp4aExGL24wQnZiNDlCZkhVbzJLSnVmVFRqbnJOS01mVUtWUUV6b0Zub0F6?=
 =?utf-8?B?UkxzaG1BQnVtOHNXOUMwSFpWSHpRN2dhWTdmOStkYjg4SkZ3U0NvK1RuUFdn?=
 =?utf-8?B?Ry9XWFcvSWpRNmozVE5sQXU3MUtOQU42RXNDcCsyLzZrRnJ2eW5lYlk3RXJ3?=
 =?utf-8?B?WlpHdTYwSHNXRGNkQ3FIS3g0YjNGa3V4K09rMUJseFp3cWhpRHFJU01aZzRS?=
 =?utf-8?B?V3dSUFpNQklBNU95TmthYmlOTVRGYk4wY0JISzBSRXUzdW9ib2FHZWFDK1ZI?=
 =?utf-8?B?cGZYZmZjMWc0cFEzTGxOZ3pyZmlwSFFkajd1Uk9rNnp5YU1nenRzbkdicGpu?=
 =?utf-8?B?MjJYYUY4UlIrU1p3YmtzTHBBNS9SNE52R2Jqems4NEV2YnhpcUhoTTkzcWNa?=
 =?utf-8?B?VWtZT09OcnR0azVMcG9LVi9pU2JSOElHR3JNdDljSVFMaUZnWkpuZVFnNi9C?=
 =?utf-8?B?RTNGY2hCSXdjV1E2dytYNktydnNUdVZxM2xiTGE3b0U0WXVjYWt6THMrMTZX?=
 =?utf-8?B?Vk5xMU10dHNmODJXOTBFQnhEMkRvR1Q2YzdYa29sNjM0eE8yK2k3VHc0bVRK?=
 =?utf-8?B?MnNKWFg5YXA1ZXJLM0xjb0ZsODRmbUxaU0FoWUhJcUZJVm9NNjRSdzA2WW5U?=
 =?utf-8?B?NlpkejZaQy9QcUNkU0hQVFl2V0pTSjlNdW5oRGExZSt6UzVnSnhBSW82aHJ4?=
 =?utf-8?B?aEJSQ21yZG5ZeXpzM1RmUmxWeks3MUluZ0ZCNG9RaDVHRWw3Q0FXSE5CbGxk?=
 =?utf-8?B?R1BzdHNJYzlPZ1VTeXpRSVliaWdLOWV3SFBINnJRMUdQY0kxTE8ycDdnMmQr?=
 =?utf-8?B?WmRPMlNuTlJKK0hFdTRkNWRicERYMjRROUkvcFZrMlhyU0U4ejBpdVVXdmFj?=
 =?utf-8?B?Q0pTV0N2aGx1S1MrZTU2SG1tRmNhVEhxaDNCTFhJb1RtZWFIMlJxSE54anJ4?=
 =?utf-8?B?VkFRZjFtaUFKd3QxMFNFWEhjMW5hczdmVjN3aFJUOVJzbFFTMzVab2pCdGZW?=
 =?utf-8?B?UnZ2TWFBc2drdHJlbG9JRGJIRTRTMWRlNjJIYitDcGZ2NVhjY2xSaVdZUUtx?=
 =?utf-8?B?WDdCbHdORjI1UWQrOWNkMHovM0xHV0dkeC9DYjdadkp6K3ZrMDZDODF6eUhF?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95868C68517C194CB8940ED270645267@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zenlayer.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB6088.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c635330a-039c-45ad-a98b-08dd99abbc57
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 03:41:43.4709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d27725c-b11d-49f0-b479-a26ae758f26d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4DEvoZRaz3uchne2pIFhcwQ4oOfdEiyR7KlDxVO2AuwKbOqUqov8cc/f0ZUB4qiFUXrs12timSA70gwC9AoOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4837

VGhlIHVuZXhwZWN0ZWQgTVBMUyBwYWNrZXQgbWF5IG5vdCBlbmQgd2l0aCB0aGUgYm90dG9tIGxh
YmVsIHN0YWNrLg0KV2hlbiB0aGVyZSBhcmUgbWFueSBzdGFja3MsIFRoZSBsYWJlbCBjb3VudCB2
YWx1ZSBoYXMgd3JhcHBlZCBhcm91bmQuDQpBIGRlYWQgbG9vcCBvY2N1cnMsIHNvZnQgbG9ja3Vw
L0NQVSBzdHVjayBmaW5hbGx5Lg0KDQpzdGFjayBiYWNrdHJhY2U6DQpVQlNBTjogYXJyYXktaW5k
ZXgtb3V0LW9mLWJvdW5kcyBpbiAvYnVpbGQvbGludXgtMFBhMHhLL2xpbnV4LTUuMTUuMC9uZXQv
b3BlbnZzd2l0Y2gvZmxvdy5jOjY2MjoyNg0KaW5kZXggLTEgaXMgb3V0IG9mIHJhbmdlIGZvciB0
eXBlICdfX2JlMzIgWzNdJw0KQ1BVOiAzNCBQSUQ6IDAgQ29tbTogc3dhcHBlci8zNCBLZHVtcDog
bG9hZGVkIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgNS4xNS4wLTEyMS1nZW5lcmljICMxMzEt
VWJ1bnR1DQpIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gUG93ZXJFZGdlIEM2NDIwLzBKUDlURiwg
QklPUyAyLjEyLjIgMDcvMTQvMjAyMQ0KQ2FsbCBUcmFjZToNCiA8SVJRPg0KIHNob3dfc3RhY2sr
MHg1Mi8weDVjDQogZHVtcF9zdGFja19sdmwrMHg0YS8weDYzDQogZHVtcF9zdGFjaysweDEwLzB4
MTYNCiB1YnNhbl9lcGlsb2d1ZSsweDkvMHgzNg0KIF9fdWJzYW5faGFuZGxlX291dF9vZl9ib3Vu
ZHMuY29sZCsweDQ0LzB4NDkNCiBrZXlfZXh0cmFjdF9sM2w0KzB4ODJhLzB4ODQwIFtvcGVudnN3
aXRjaF0NCiA/IGtmcmVlX3NrYm1lbSsweDUyLzB4YTANCiBrZXlfZXh0cmFjdCsweDljLzB4MmIw
IFtvcGVudnN3aXRjaF0NCiBvdnNfZmxvd19rZXlfZXh0cmFjdCsweDEyNC8weDM1MCBbb3BlbnZz
d2l0Y2hdDQogb3ZzX3Zwb3J0X3JlY2VpdmUrMHg2MS8weGQwIFtvcGVudnN3aXRjaF0NCiA/IGtl
cm5lbF9pbml0X2ZyZWVfcGFnZXMucGFydC4wKzB4NGEvMHg3MA0KID8gZ2V0X3BhZ2VfZnJvbV9m
cmVlbGlzdCsweDM1My8weDU0MA0KIG5ldGRldl9wb3J0X3JlY2VpdmUrMHhjNC8weDE4MCBbb3Bl
bnZzd2l0Y2hdDQogPyBuZXRkZXZfcG9ydF9yZWNlaXZlKzB4MTgwLzB4MTgwIFtvcGVudnN3aXRj
aF0NCiBuZXRkZXZfZnJhbWVfaG9vaysweDFmLzB4NDAgW29wZW52c3dpdGNoXQ0KIF9fbmV0aWZf
cmVjZWl2ZV9za2JfY29yZS5jb25zdHByb3AuMCsweDIzYS8weGYwMA0KIF9fbmV0aWZfcmVjZWl2
ZV9za2JfbGlzdF9jb3JlKzB4ZmEvMHgyNDANCiBuZXRpZl9yZWNlaXZlX3NrYl9saXN0X2ludGVy
bmFsKzB4MThlLzB4MmEwDQogbmFwaV9jb21wbGV0ZV9kb25lKzB4N2EvMHgxYzANCiBibnh0X3Bv
bGwrMHgxNTUvMHgxYzAgW2JueHRfZW5dDQogX19uYXBpX3BvbGwrMHgzMC8weDE4MA0KIG5ldF9y
eF9hY3Rpb24rMHgxMjYvMHgyODANCiA/IGJueHRfbXNpeCsweDY3LzB4ODAgW2JueHRfZW5dDQog
aGFuZGxlX3NvZnRpcnFzKzB4ZGEvMHgyZDANCiBpcnFfZXhpdF9yY3UrMHg5Ni8weGMwDQogY29t
bW9uX2ludGVycnVwdCsweDhlLzB4YTANCiA8L0lSUT4NCg0KRml4ZXM6IGZiZGNkZDc4ZGE3YyAo
IkNoYW5nZSBpbiBPcGVudnN3aXRjaCB0byBzdXBwb3J0IE1QTFMgbGFiZWwgZGVwdGggb2YgMyBp
biBpbmdyZXNzIGRpcmVjdGlvbiIpDQpTaWduZWQtb2ZmLWJ5OiBGYWlja2VyIE1vIDxmYWlja2Vy
Lm1vQHplbmxheWVyLmNvbT4NCi0tLQ0KdjINCi0gQ2hhbmdlZCByZXR1cm4gdmFsdWUgYmFzZWQg
b24gRWVsY28ncyBmZWVkYmFjay4NCi0gQWRkZWQgRml4ZXMuDQp2Mw0KLSBSZXZlcnQgIkNoYW5n
ZWQgcmV0dXJuIHZhbHVlIGJhc2VkIG9uIEVlbGNvJ3MgZmVlZGJhY2siLg0KLSBDaGFuZ2VkIHRo
ZSBsYWJlbF9jb3VudCB2YXJpYWJsZSB0eXBlIGJhc2VkIG9uIElseWEncyBmZWVkYmFjay4NCnY0
DQotIENoYW5nZWQgdGhlIHN1YmplY3QgYmFzZWQgb24gQWFyb24ncyBmZWVkYmFjay4NCi0gY2hh
bmdlZCB0aGUgZm9ybWF0Lg0KLS0tDQogbmV0L29wZW52c3dpdGNoL2Zsb3cuYyB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL25ldC9vcGVudnN3aXRjaC9mbG93LmMgYi9uZXQvb3BlbnZzd2l0Y2gvZmxvdy5jDQppbmRl
eCA4YTg0OGNlNzJlMjkuLmI4MGJkM2E5MDc3MyAxMDA2NDQNCi0tLSBhL25ldC9vcGVudnN3aXRj
aC9mbG93LmMNCisrKyBiL25ldC9vcGVudnN3aXRjaC9mbG93LmMNCkBAIC03ODgsNyArNzg4LDcg
QEAgc3RhdGljIGludCBrZXlfZXh0cmFjdF9sM2w0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVj
dCBzd19mbG93X2tleSAqa2V5KQ0KIAkJCW1lbXNldCgma2V5LT5pcHY0LCAwLCBzaXplb2Yoa2V5
LT5pcHY0KSk7DQogCQl9DQogCX0gZWxzZSBpZiAoZXRoX3BfbXBscyhrZXktPmV0aC50eXBlKSkg
ew0KLQkJdTggbGFiZWxfY291bnQgPSAxOw0KKwkJc2l6ZV90IGxhYmVsX2NvdW50ID0gMTsNCiAN
CiAJCW1lbXNldCgma2V5LT5tcGxzLCAwLCBzaXplb2Yoa2V5LT5tcGxzKSk7DQogCQlza2Jfc2V0
X2lubmVyX25ldHdvcmtfaGVhZGVyKHNrYiwgc2tiLT5tYWNfbGVuKTsNCi0tIA0KMi4zNC4x77u/
DQoNCg0K

