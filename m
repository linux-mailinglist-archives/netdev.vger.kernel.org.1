Return-Path: <netdev+bounces-109031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47662926921
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82D11F25497
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0813774C;
	Wed,  3 Jul 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="AsQolFtc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F81DA316
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036007; cv=fail; b=HA5trVFkbNZjtF7gsUld4D1GLdV494UlcV0UH1hqL5GCD34RaPVFBUPFH3Dg3sAmzaIvCKqNUd0EyaJu2yTNHcwZkbjv/lnLnN5PVaGlVojIlGGuEJJmHKwJf/E6Vn6xrmv1hYjA7Z4dorFXfCD4S2/6bBVlVajMA1et1mQUVuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036007; c=relaxed/simple;
	bh=1bQMhbRBZjoeDKzN+Tv6ghe/9V1h2kjAk0QzAUufJCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sl3g4/tE+rtneMdNDSXWx1rPxWF/Lji27vJbQUd6GUM+5u/0/zbvBZfM8A/bccbtFDER1FmHu7KPBeIo/J2sAQkkjv7KQk/16J2mp61RERYOPhkwm98qoOccC5ab6kKvWb4L3+rQxPc7vE7oZoNrINhoWi4ghJZdL6KMl6SmqKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=AsQolFtc; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463IGZBv019554;
	Wed, 3 Jul 2024 19:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pps0720;
	 bh=8a2eDxBiZlvbHaBL6ek3Y5R8Z6d8w8hXS3l9jKf4fps=; b=AsQolFtcgR5i
	S1IQMaNoBC7nsZN4UfHjJqxXwz0nfaTzq6SpNP1UHag5Y8esV5l8hqpJlBxPG87t
	Tq4pTjq/rKw9p3h+VCtJz4bnc+sx5yWSIJtUJUk/zIKkofyLh1vUDs3mLbk928O1
	lL3XRKkjabnIYq2v1nqZJucKmvZU3e08Z3JN5GwfeKwrK2HYJ7uQGstNmsgpAC+n
	P6sfEl3H2+9SIqaBDyCjqrasSJ4omasaM/7YrtsebyvoFqtbXJYMM/72OCsquRbt
	Ko+HiiPipKnoS9I70P/NcfE8yzAU88OEBniWds9/KgazPAnpyyQP7tahKuM+4SGg
	5P1BzGTWBg==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 405bs7gmgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 19:46:40 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id BDA6612EB1;
	Wed,  3 Jul 2024 19:46:39 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 Jul 2024 07:46:39 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 Jul 2024 07:46:39 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 3 Jul 2024 07:46:38 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 Jul 2024 07:46:38 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+7b5IsDD1S7RzYpSvshIeL6lBX6urNS178SXla1Gs13BvHkVFESzW5X0JTV67N4n+pvof39w9cWZpoos+leUdbgw6kuHD0OCWj5qeN6PT/kJ1q+f/FqRgEWSOkCmwSprQDOUXMh9010vK93AiM2zaov9MiflacsQeikH0j5+NwMXcQSMPND+n7qCBbYGGgsmypVTxHjw3l2H3Xq7FEbEhIWZl4gTUdHaPO9d+6S15d+kAyVgqX4LhsEx7y5xVvPAsiGm3fP0WyMLiLOln16LrqmlhAe4zhw3S0RXiKhubcdxKPjR0+MFZlLewZDGeWuPAiMtG0A9bjp0HUKSqHo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a2eDxBiZlvbHaBL6ek3Y5R8Z6d8w8hXS3l9jKf4fps=;
 b=kB8C0cW0ire1V4TSJLTQuWSxP95hCPMdNU1BVE6bNc4MuQqpud113Igt132RxKjWOJdmC1SAihuaGZg9SH6gneU5OUJorV7XIWO7HIFQUD+phcFqu7DapZDu6nMg4tGv7/nhuLMOE0gssnnN0nAdEgWEuOJV1kdHXvLj5yPSlovbdPN9Y6X5Knte5OJ9HmSRxyQivNMN9ILysMLknrEc2Eu29yy2rYIiubwnjskhR+JlX3ai+nkdXa1JBsQ+BUOPw33kDwb+IGntB5qZttQtKF0XatS+pCK0ekLjfBoELNjTU4tsOMyObUiyeHNqxwDFNQmxqxFGMpe1fBrE3uZqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by MW4PR84MB1970.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 19:46:36 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 19:46:36 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: "ip route show dev enp0s9" does not show all routes for enp0s9
Thread-Topic: "ip route show dev enp0s9" does not show all routes for enp0s9
Thread-Index: AQHazQzrlzyIoaLhaUabsTp2xC3ZC7HlaD0g
Date: Wed, 3 Jul 2024 19:46:36 +0000
Message-ID: <SJ0PR84MB208895DD86DE621AE337CAB2D8DD2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB2088D9C951AF8B39C631950DD8DD2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <20240702225007.33b0fe3b@hermes.local>
In-Reply-To: <20240702225007.33b0fe3b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|MW4PR84MB1970:EE_
x-ms-office365-filtering-correlation-id: d7fd9ac5-3d51-4f22-4df5-08dc9b98d978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Sj/CmTGe/YFRiOzvED+6sfrzMwkXyPgnOMKL4k0hS4dmMF8CnZKxXxpcPu0M?=
 =?us-ascii?Q?tHtFtLAAHDBPwOZ4fHErAsy63dydqDKNfDwIkJMLBbF8fvekaA4lY9QN3qEr?=
 =?us-ascii?Q?tZYtuFi1vegKOWUKT9e/SaXbByyUvqyd0vJMNzkpmjW5Wnk08zTS7SNHEUwR?=
 =?us-ascii?Q?7Mju6Wy2Efu3h/+qlANYJ4c7RSA1BLfuIDeUT7LMmt0L0tlL+8upggkzLpw0?=
 =?us-ascii?Q?9CEhssUHM9uvlvUQ71vUdjci5sX+irm4Z3PM0p83WhzEY8x83oFeHKJgpbnJ?=
 =?us-ascii?Q?PxGAWMQVKq9aPpeITFqvlI+hg7znwFgqKLvTm+7dXhCdNxseasUYI+X0KOZC?=
 =?us-ascii?Q?REhIdCYauZ+opVNWsQsgced2ocRJMhUWCNU3E2EumX1Ow3qaVYeu54CNHTkd?=
 =?us-ascii?Q?8tLOCBl2hVB8IH2bmHWQ+JiAL0uasXD5+QbgafgbYwd3PNIGu4EJc32xjOOn?=
 =?us-ascii?Q?Uo8N1+eoQTjlkrxTj7aLoyeZuoIcbl0tWgnJrW4FjR8THAzarr2Va0XZxrdR?=
 =?us-ascii?Q?qXkKOYBcNiUnsZp4++mGDM+zC4MLJO8OJ0w66Qd3kbEUewZxJ5JBZ0Xr0sls?=
 =?us-ascii?Q?xPFCAiDMbrT+jh9OghqlRdjP26n1kkKeyB+NRXhnDLYZk0H0hZPBLRIGkHOy?=
 =?us-ascii?Q?oEmhngy5RyQiPK28lE1lgcVMUT5NQC+dnCqsNMM51kkVFB27ugx3awOla9RD?=
 =?us-ascii?Q?hAa2qYKUAfEZ5XUmQIKCeh1fNbc0Plj2F2ZTgesfZ4VjyamyfNXqgxNzSRxn?=
 =?us-ascii?Q?55IXLqaDByJTQgWXH3mekO9BhxGSrPkVe7V3qZmHRXBF2EyD9g09THGBzvN1?=
 =?us-ascii?Q?CmEZY240ZY5hwD7rByRiV05zV0zemnjSFCwXKKWbZ6h1c9Rtmtk5W0Un4zw7?=
 =?us-ascii?Q?josGM7xbOtWqX4BVr9XUKeSXdKq072r4qQd11YauJ0WMNoafPnH3R5KtPAk+?=
 =?us-ascii?Q?1T8vfJfHHXz11BObBmmLcxvfSHp1ix1eLw+WHQ2JbGbs1UHtlJLr7f7UFrau?=
 =?us-ascii?Q?6kkBwo3ImDHByDLfkpolOHukWmDBvXJHM2jPqtPwaZB+WOqisu9XVSaczfzh?=
 =?us-ascii?Q?eKj9VtPZgfmPQvoOpqzvLuBhZcMCxQvCEWPtz1lTDbVpoffakJ0ibH2Onb9f?=
 =?us-ascii?Q?uhVZrHXw4FSAQyNiC1cjCWK1Kfx4TjQdq/JdY+n9IKQTZTWqnrVyi698AUf1?=
 =?us-ascii?Q?mzgkc9AYjhnGZDo/DP5k68TZ9H8OTRo0ck3PX5kXMwQ/gr9QjCO11u6Qh8sG?=
 =?us-ascii?Q?tnOxVVFuy/Ue5EeVqkOeQz4bhrm1R1he5+fqoquAgXgfkH9ZFv8y10hlOl7V?=
 =?us-ascii?Q?pSlC/Ka7zQ/Y5wttEBNtDeAJKO9eBaRMq1QRq2sXz8pq26kb9l6hX8wuc1o1?=
 =?us-ascii?Q?Oi2CJKM2f5YfjzsJcmp5q6Qk/O1DdJpYInhEzyMmqSbo3/YIfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H0kJkNPEgKGTaauQeNybSAWbAa7zBazh1sYhGNCaAGkYUW4hSDXt7r55zgyc?=
 =?us-ascii?Q?2me/H+VR772dwVCUgToWA8EDbl28LNfefRfA1LllxPxrAPGuvpblj8XBLTfb?=
 =?us-ascii?Q?mVZrePLTBxaDOVJnFL15dlbCqIUevULVHDcOrys0wThcBm+R92QPfZ+KZj2D?=
 =?us-ascii?Q?Cb/oucN+EG6BFUBC1rLbhspAL92WkUKqyoSNy3JJF6D7KbGuQL4ke5HMgBLW?=
 =?us-ascii?Q?OFKCLnvtf9Bq4h5u5mZZIkhgvwaWZ6p/+hWosGgzeJTTQbqa5+BxSYTaMLLE?=
 =?us-ascii?Q?nG/Tr8g7qeYUz8LYUJOR6MUy560uNuPlRPduhaBRDm31J+G4Qw5YYq36KOSe?=
 =?us-ascii?Q?/VMyxWv9XQO2NFY0XoTev+Py1jFhuUvBpj9uvflaXNJ/43t0KCZO0TIYN7Jt?=
 =?us-ascii?Q?d/LOFEGPVgsa7uPBjvZKwx5vtnWxjcxRj5Whb7sVv1PZuPjeHtWExn+vUuWt?=
 =?us-ascii?Q?8tgebtaXWrB1T6hsL6W3B8FihBUTprf9L1XqqX6b+PO/rekppG7Q+kg84Q2B?=
 =?us-ascii?Q?fFFB33kIWkt1v+phOxcnsl/g1Zt8LoeBj7TYPC7IaQVP3HidnQ8iB1R7usBn?=
 =?us-ascii?Q?p1DEHwmNTrARRoadV06hKVrBOgrjk9ncHXbBY4NnTKTWmNETYMidFb7rB2zD?=
 =?us-ascii?Q?26+RvyNFxeGRj0D74eUbG9Vh3CH5sF765heuICYCQlbmgT52SZeq7IjMRBey?=
 =?us-ascii?Q?68rJRu4elG8oLqsbSltSdyVGN64aku5R028VEBd3ueW0bk1ffOrLXhp3MfRU?=
 =?us-ascii?Q?X4LY5xJofDKW+ks5g5gteaPvS7zF5d79GX5zDPuZV+1mkrwv46cYWHBUKSQm?=
 =?us-ascii?Q?Zl2IqHD3AnwkEYPVQ/1IwAYv+yDvRYwb2rGrUXk5ijlevHsDblRnjfI4V9Aj?=
 =?us-ascii?Q?F01HL7Z423z4pA6pxGfM5ju911lYuVkMEAqemE75KbVWccK80wHebAaP8Eds?=
 =?us-ascii?Q?14mKaKBx4jYkOugL0EDYYGVL4Umw4qI3o3BALfjNJG23Xj3PoG4PBOzifH/4?=
 =?us-ascii?Q?NMrhq7Hs87NlPYWUTY/0BKyPy3QgRUyFTy1gMJ1lPeclOytpzmTFGQIC8bHZ?=
 =?us-ascii?Q?yQ5siD7IjtLEWJjiN9EM80wBd3Gy4uBRXYwpEcJQW5ruWzTQ3jsma3+KJ7o7?=
 =?us-ascii?Q?tt+3rEWo6uIxth/XxNeA9OJ79wj2nveuPDG0GCEqN2S3uHE4TVxkobyIvFol?=
 =?us-ascii?Q?lffJ4DBWPLayjbceF1pJ4Ou49Nb13mQlcDdbQUdold7SbNYcsAJIMrGExB+9?=
 =?us-ascii?Q?nnKssXsEd6a6ROkAVbCwmTP6UfNmZMYczjZu0EalGOp8bxa6wIKz7BL19t7V?=
 =?us-ascii?Q?9H9KAzgMW1Zf33wciPMEfxKT2QuITR1u1hG56oG1esS0iiCo+kMOrix2cUOJ?=
 =?us-ascii?Q?tYlfddAtsAYZ9CynkTuDLoFCy3XYe6u+yjQOLl9I47aEeKm+slFqoUOOIlRR?=
 =?us-ascii?Q?fKRSW7KI+EWoVIrbwMYlTjJGTPlAU4VWXsHUzz+rNRWjlIPDaAnWDC0juC4n?=
 =?us-ascii?Q?zJSC5apxor3olcPMcyq1kK6v+B5TXoROBZo3QX6ZGV6PqnFPrns19FESt+/V?=
 =?us-ascii?Q?JscBU1nv1UhCxQm+dIhbPfZcAoYCSSdffwz5l1gv?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fd9ac5-3d51-4f22-4df5-08dc9b98d978
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 19:46:36.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTVEQdNxmwo+HHVPifZSJBYvDVGdQ3SuUvHKvH9x6oKy0bWk3+8Y5nyrnxNaRs1qyK5M9yYK7WLEhxD6k6oWNKhzrXpbUx4qwZsNsZ2tfrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1970
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: MSveEtGu_TuIdLmTtd63orXWHp0frEVH
X-Proofpoint-GUID: MSveEtGu_TuIdLmTtd63orXWHp0frEVH
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1031
 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030146

> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, July 3, 2024 3:50 PM
> To: Muggeridge, Matt <matt.muggeridge2@hpe.com>
> Cc: netdev@vger.kernel.org
> Subject: Re: "ip route show dev enp0s9" does not show all routes for enp0=
s9
>=20
> On Wed, 3 Jul 2024 04:00:44 +0000
> "Muggeridge, Matt" <matt.muggeridge2@hpe.com> wrote:
>=20
> > > On Sun, Jun 30, 2024 at 09:23:08AM -0700, Stephen Hemminger wrote:
> > > >  Good catch, original code did not handle multipath in filtering.
> > > >
> > > >  Suggest moving the loop into helper function for clarity
> > >
> > > Thanks, looks good. Do you want to submit it?
> > >
> > > You can add:
> > >
> > > Reviewed-by: Ido Schimmel mailto:idosch@nvidia.com
> >
> > Just wondering which repo this will find its way into.  I sleuthed
> > your repos and the iproute2 repo but could not find it.
> >
> > Thanks,
> > Matt.
> >
> >
>=20
> It would go in iproute2 but was not an official patch since it was not te=
sted.
> Since you are doing multipath routing, could you please make sure it work=
s.
>=20
> Suppose a test with dummy devices is possible, but somewhat artificial

I have tested it, and it worked.

# Using my distros "ip" command
$ ip -6 r show dev enp0s9
2001:2:0:1000::/64 proto ra metric 2048 expires 65480sec pref medium
fe80::/64 proto kernel metric 256 pref medium

# Using the patched version of "./ip" command
~/work/iproute2/ip (main)$ ./ip -6 r show dev enp0s9
2001:2:0:1000::/64 proto ra metric 2048 expires 65478sec pref medium
fe80::/64 proto kernel metric 256 pref medium
default proto ra metric 2048 expires 538sec pref medium
        nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1=20
        nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

All the best!
Matt.

