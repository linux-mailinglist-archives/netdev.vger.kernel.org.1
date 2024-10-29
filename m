Return-Path: <netdev+bounces-140154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2759B5643
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2DE2839F6
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9C2076A9;
	Tue, 29 Oct 2024 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="ASmJbkox";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="QAUJR2nY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000e8d01.pphosted.com (mx0b-000e8d01.pphosted.com [148.163.143.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C41E7676;
	Tue, 29 Oct 2024 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242891; cv=fail; b=ZG7SuRMHAsGogRLM1vfAGIrp0CYYaKS6aXJVCSeOar7NArjzOExfJOHh53Gc2DBtaqetYpGJLxY6lqOef6ZxU7gNRtvNWEihOzhZ3YQOPy3HB+1JwYtgFaLkkrRiHXixdTc8A8sn8IEoj0QQ/HLyD0r+uN9iQp7wLVrthlskxFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242891; c=relaxed/simple;
	bh=fMYExE67cZUUFpQ8EhxH8WKEWcegs62TVxypZfWhc7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZkR2crXbWpgeWy/sB4rK0zWuKo4WTkPoVsFiAw5pP3ejRskeMQu8e8XkPE2BJDOzZzaP4P2nHg+n+u9T0SUHh5FNHm2V93SLMWMvFCI91ngw3s0WmJsgGjsFTYvYNMdIgjQibA6fAV5IR8RjMba0/P09ig8ENl87zulGxiKQ6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=ASmJbkox; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=QAUJR2nY; arc=fail smtp.client-ip=148.163.143.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136176.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TJvpf3028000;
	Tue, 29 Oct 2024 16:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=caJ1w
	PZmYQZgt0N3w3VQ2xIl8rUsNwgEtZJd2ClePfo=; b=ASmJbkoxxWB1WOZot7UzB
	dEdskSCfOxCEHhJd5lV7NyOLKVu18haj526srO08RnyaKiy1C2PWOClCJf89d7LU
	eoyK+/rBrV+VWDHF4io7UQj61FZ3Wv0+KEzBDy7+FQuJ/qpTNs9JJMNxqWAJyIgu
	rUqmq+jf/ncZtnmwy+1SDCWvNCgk3a6yIVv9qGdqMj2Dlw8EgBank6nQd9nTlqI9
	tDFfYNnEK93rAkOZ+YW6ygdO9iy4pIZeaGTfGj2uyBZEMKWQUVT127k6YnZMLMVD
	aEM8lyV6yliF13vsuJmBIgnozGEW47ts68wF5ilQ6+4/Na7DcQydsdt4NyulJvxz
	w==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42jxquggmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZCaQKUEY+QgHI4O4ycrEehugjfX2ZQzikAJfcrDA9UoO6n3Z+e09fYJeBYNBsQ8zpl2gN9Z3c22A+jmVXsVbB4JdC8ejd8F2sNLRWMLZpxlDknDbajuQZlVDR1jZV6LoeAG4WyoeO20NB6z0Wna+F8EDfuDhqi1mg4COfDjRKGtnD3r7rI3jHFcSSnzuRG7BA5fJJTYuTcXskDf4fBIQGTV/1z4o7zEgp9KhH6vpSfZMBqMo2JaQcTJxzRBQUx1OSnBngZxQDtKVn9QeSgFISD5mbJgSnJPmvCGLSBgLDPkWXgP1glo3N/Tqnj4wN/oK1JlyNPfcTqUrMjfUWCRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caJ1wPZmYQZgt0N3w3VQ2xIl8rUsNwgEtZJd2ClePfo=;
 b=aoRDLlN2j2EMUtrynEin8uo8m1ejs2JDGyYukrAInpbT24p5WF3GddQstrI5TMlxz+ucyLIU1LthVK56vhbEI3dnF0NL/hSdaJNEQSZQ/48LXRbPhg3UPU5loedJOJkXSZCTBtDqTeZIhTeQ9YJUUyX8Pf/P1wXEFzl1CK8z6XRarEejesl0Elpq8aKnc6vbj/XNIjSP7bRBL3I2y/6PKKohAZznwoM1+yQC/HGkFphkj7L0KlttfpPtq/hMZwWo+RYOkc0LO9FHwdjDBdgZuWAUZsj7OZL2+ORHJRJhGPNhncC8ZqMuQme5LuZT26Dn2n4+LAH8oEwAE7lO8NlQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caJ1wPZmYQZgt0N3w3VQ2xIl8rUsNwgEtZJd2ClePfo=;
 b=QAUJR2nYQJo4NUWU/3MLrQaCBFhC3pgPV1Kt46aCWUo/RRngQBFGCuHkfrFVxQ7Rjm9tDZKl1lVAAAM36vXUis4bEKo9mlZclhL64FfdftmQkOy1XxSqfx8vUgUOjvo+GM8bl8GcXhItDrsmz/AsiV5O/gB6S3RQIvTjQAYzMfEGdCSUciA+qXV816Evk9bIFEZ9vwn2gQBNr3d81F5vErYVBbaK6Xodwe6HKe4WqsAuTRbnXTAryfpFaWElmvKR5bSdosKhwWXadOxtM1mrb6W5vYYDXHeOa8ZkOc1f1nuNbBTr2ZfiHYyp1PlWehoM7+Nhe2baLK+HD8NYFYd6IQ==
Received: from PH0PR22MB3809.namprd22.prod.outlook.com (2603:10b6:510:297::9)
 by EA2PR22MB4826.namprd22.prod.outlook.com (2603:10b6:303:25b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Tue, 29 Oct
 2024 23:01:21 +0000
Received: from PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731]) by PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731%3]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 23:01:21 +0000
From: Robert Joslyn <Robert_Joslyn@selinc.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "lee@kernel.org" <lee@kernel.org>
Subject: Re: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Topic: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Index: AQHbKYm0/z4P1lQS/k6ewHCARnYgRLKd+neAgABdy6w=
Date: Tue, 29 Oct 2024 23:01:21 +0000
Message-ID:
 <PH0PR22MB3809834A1A62CB9B635733E2E54B2@PH0PR22MB3809.namprd22.prod.outlook.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
 <20241028223509.935-3-robert_joslyn@selinc.com>
 <76147be2-9320-45a1-919c-4b41992fd7d9@wanadoo.fr>
In-Reply-To: <76147be2-9320-45a1-919c-4b41992fd7d9@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3809:EE_|EA2PR22MB4826:EE_
x-ms-office365-filtering-correlation-id: e0688b76-3d21-4907-0d1b-08dcf86d9add
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aiU4zrTa4K40TlhmLk2GuQsjb4VLRB0T7FknkwjHUN8Ir1u+5hyWNCu5Cb?=
 =?iso-8859-1?Q?60nsLAmxbxh0I8B+wSvgh8e2KfHpayjz45yiu4JkuFBH8lbzNKEkntwKvT?=
 =?iso-8859-1?Q?yk4RvTI/mPZlmZsMciDP7WVEcvstZY3yw0tOFSOnveFbqS3WGesAz6xuwQ?=
 =?iso-8859-1?Q?Iws46PpMfhd04hqI/G0k21t01fbADWET1jB9QF/tnrMqtjWGdJ6xsBfC2U?=
 =?iso-8859-1?Q?wffl1EKYcME8rSuNEf2BnexYYSIHKs/6obUgmgdIZvv/6h7RiHApwV+7Sa?=
 =?iso-8859-1?Q?+EAl4mdYFI0TK/gyRZj3atsG/WMdxUCUe11GYBFfD2JH1WmdiENM6gWxP4?=
 =?iso-8859-1?Q?TBzRiSbZUjbG1mA7RA3IKjVjR+ldQGYqIp9mEPwdYavz3p+ZqCSLXCttka?=
 =?iso-8859-1?Q?miFYpIfwjNr3mCDjQIBVIEGslEIK7ICvRIy/tPeW92U7nNF6k0EF5hXIEv?=
 =?iso-8859-1?Q?uytgAWiTAfbO77GnDl2GRf6oV5oRGuKk7CLJW+ntoYIYqrJHpMprHQoIZM?=
 =?iso-8859-1?Q?nCopOAml9Fh7IYH6IYuD3AhyloTaW4pLSFrW3PCZYDHcdzFMuBXXKQfqya?=
 =?iso-8859-1?Q?T930RxF5InudCBkhwrNWTOdqUeGkMs2u728xeQlcB+qzoKjTunLxbQOxbB?=
 =?iso-8859-1?Q?SW+rKxIUJGfQ6EEvsdcWtZz/KQ3uxQXlisUmPAP0aO+H6yEW1gBfPyxb6u?=
 =?iso-8859-1?Q?AORn0j3B4STqt5NmzIq1CAwkZGjwV+yRMMtxfJ3RGxaDc5YIZfDNnebQa0?=
 =?iso-8859-1?Q?eFFSy2hWrmUF47iDEgWcOMAHoUykgMrGO1JXXXLNlUVEx4oHgHSIJzlrMK?=
 =?iso-8859-1?Q?kC+CXjliJ/Q6oneRetlOEhX5hU7cb+1/NnhFOo8QZNBzEBJW3gbioSYaat?=
 =?iso-8859-1?Q?MUlfoxkW1r9QQ4zW/S1FthWbVDMcBqzmAFuiQJTZhSyIOrDYo6O76BopWE?=
 =?iso-8859-1?Q?5yrdaxEtc8ZooN2lnvVu5vwNUK/6QggPEMQv5/Npuq5zkDZzH2DMKcv+mM?=
 =?iso-8859-1?Q?iVdO7CNVxo89ZfhSNP7Ti9y8duIcjg7YYKl2LP+tsgi8r8PJEZhZzcTChl?=
 =?iso-8859-1?Q?nvukIc9qvB1b6ECGNiJrOUrbUY3nXbMacGRSgYL6Hfkb730kScmpXWuJwg?=
 =?iso-8859-1?Q?sADhs3eMzxuoTpEJ358Pp+8ccPgp/g+CCMnGvHh9yxhr+kQGjflqBJPMJk?=
 =?iso-8859-1?Q?D0SOn3gpth/EAeKrvV5Fpb6j0a6+zsRXR/LBoJO2VTJXOXXgHolFDSbzew?=
 =?iso-8859-1?Q?+prJndM9KxT8fqCfW8p/9JcnXwnWIQm5js/JpFfwYWSI7qBqDzx07OAmKQ?=
 =?iso-8859-1?Q?2L+gbIlD1NthJJGUUdkwKFu1je74NuWqmx/i5D10mxlJmXM+9o7GCNcufm?=
 =?iso-8859-1?Q?5FA/rze+NMmFkbR6/NhQFgqnBrwvvZi01/j8aVyGxQIYWZmU6wGbc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3809.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TOYZyhmyRRBXHtKwb8JWfruojCwIEVL7YjiHukyBCPfx07sWbIjIE1UTDb?=
 =?iso-8859-1?Q?neIMwlCakhulFNhkzuLD5w6P9s2mxB32xWc8t5Y4B/S/+4c+fAqxIr8gw3?=
 =?iso-8859-1?Q?otJkIMKTXz+7vqjndp0YDkCQUkCg7YZxx/3lPG0vKeTD3OnGnm7WHLgkCT?=
 =?iso-8859-1?Q?DEEVFrqISydRBDs2DPuWoPl/cmUHXlp2qiRkYv0JD6Q2iGlBAiLh8wNaD3?=
 =?iso-8859-1?Q?rWCI1FkwkwaQh9517b1Ej8icH7ho8eNRgl2fPWbe/vptpIKOHi8eDz1fPF?=
 =?iso-8859-1?Q?Hsn6Lydn7SCTLVONAXBePdcuqw5lNbTRVmmJV8NmV/1/T2lMmOXb9LT6to?=
 =?iso-8859-1?Q?faoupdKduFUPVcIRcN6go66yAxwTemAYTljCPbgmkSPMG+f9rGQIoY5oYg?=
 =?iso-8859-1?Q?cpMESFHxrWnNuroqr55i+j66BHNnzFiJE50UIL7+e5FIjrb8BoMKoFuIUH?=
 =?iso-8859-1?Q?vAGQT7IdQ6Qd1oQU/BYSItkZmnagY/dwr0yERfa6KUzQScI5Jav3Hw7iz0?=
 =?iso-8859-1?Q?U+bGAOebfRZHvPapOlON1sO9oBQG5rd9Nf7cZx1inRdZVMKYSMJd8WjzJh?=
 =?iso-8859-1?Q?DZY2omWL4381U2k2OzASd32MzOAbbcws4qCZzST58AA3srG3M9vcBXNPOK?=
 =?iso-8859-1?Q?Ev977DzG1R9jynLgUu2+szUxBkAWM5jMd16p/lsnCOQC6MUuZ899B0byLS?=
 =?iso-8859-1?Q?uIdA8r9cd3tqH+R8QnmOvXLUpCKkmL7Fg5LQh3WGMH4H1Ys1cSlMYTpliP?=
 =?iso-8859-1?Q?bCBC3bQDMtq3DU5baHiMdHx8rKsx1Z+g39k+ht27PomPKHl2o3ulmfBgnR?=
 =?iso-8859-1?Q?RyICf7zENxxiswAuXE49NBl1EvM4ZeWlsOslbAqIAOb0aNqAQkulsTIBkU?=
 =?iso-8859-1?Q?LL3yGlYgQA77TLqrrzDEBbBrvCAZg71XMC4c1PLPFE8e5wJy+sFKy0zvBi?=
 =?iso-8859-1?Q?y2WNuYXopCb8KZ+/nKkcpg5WtWRNChXMB04fJhl4Uss6Jzgp+YBmTEVXA/?=
 =?iso-8859-1?Q?T6JgO7UzrhQoxKBC1ntYuLJlJM3x/QdsjuO/c4jss0NKm+5gwfQTOxnfjM?=
 =?iso-8859-1?Q?rnBRIaj5E4mdu5fE7Qruj2W5B0BEIFk5kUHkwKc5F/jPjzlq+BbQSOTm2K?=
 =?iso-8859-1?Q?Tts4nezzX/dkwGYIjcD0tltywF4+Npditc35kS+79fRo8+bN4BW1MVTFQg?=
 =?iso-8859-1?Q?loLDPLCqxN4eOIpa1KlMiLjl+xrzMIBRP96YZTibsGPGujeQC59YdfZTWn?=
 =?iso-8859-1?Q?iw4axD+pHKtZd6LonWPsm/NBKrucnQGDdSFFscAxWuudSqO8EDZpro25sk?=
 =?iso-8859-1?Q?1uRB7RJvpaqhxeXEYDQe1zpKA+kk45ot8V/ap49ACo/hWELzsjoPgkdQAh?=
 =?iso-8859-1?Q?OazyiEQiJN4rEpWRo+GEEyRuwPFJGdt0Q9gv5q9Eu6AptiuOx7do7RIK0R?=
 =?iso-8859-1?Q?ppdNG4hbxNb8s6iHEmZmhK9Q3AyMZgMooZn9gQMEAuJo9Gu/aMC0lQSIzo?=
 =?iso-8859-1?Q?ijosZrwPpraTguddGBNZXpXoOrWJfRSWprsbSNaSyahG9IHFEiqwzXN1y0?=
 =?iso-8859-1?Q?Gdh6ecoUN+bvpt6MKl/4oWtJmYYc7lvzp1+RzEo9t0mSvVrnuFyqz2w+Wh?=
 =?iso-8859-1?Q?QI5mcoUPbufsYaXhx7XNb1zdsVNOFzH524?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3809.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0688b76-3d21-4907-0d1b-08dcf86d9add
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 23:01:21.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5u7RGUA5mARJy58/Pooxd1E1ZTx1+l5G88SwJtryheioOAYtt6QmmXlWmrL2KGgEQnWB832d9FboJmVN1GntQriFTovP+zsnY098zQTWe4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB4826
X-Proofpoint-GUID: HvCnWJ6EYWeZjf9WXmyO-obFpTPp8NwR
X-Proofpoint-ORIG-GUID: HvCnWJ6EYWeZjf9WXmyO-obFpTPp8NwR
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=868 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290175

>________________________________________=0A=
>From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>=0A=
>Sent: Tuesday, October 29, 2024 10:19 AM=0A=
>To: Robert Joslyn; linux-kernel@vger.kernel.org; netdev@vger.kernel.org=0A=
>Cc: lee@kernel.org=0A=
>Subject: Re: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe netwo=
rk adapter=0A=
>=0A=
>[Caution - External]=0A=
>=0A=
>Le 28/10/2024 =E0 23:35, Robert Joslyn a =E9crit :=0A=
>> Add support for SEL FPGA based network adapters. The network device is=
=0A=
>> implemented as an FPGA IP core and enumerated by the selpvmf driver.=0A=
>> This is used on multiple devices, including:=0A=
>>   - SEL-3350 mainboard=0A=
>>   - SEL-3390E4 card=0A=
>>   - SEL-3390T card=0A=
>>=0A=
>> Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>=0A=
>> ---=0A=
>=0A=
>Hi,=0A=
>=0A=
>a few nitpicks below, should it help.=0A=
>=0A=
...=0A=
>> +=0A=
>> +     WARN_ON_ONCE((ring->dma % SEL_DATA_ALIGN) !=3D 0);=0A=
>> +=0A=
>> +     memset(ring->desc, 0, ring->size);=0A=
>=0A=
>If I recollect correctly, dma_alloc_coherent() returns some zeroed memory.=
=0A=
=0A=
You're right, I walked through that code and it does a memset to zero inter=
nally.=0A=
=0A=
>=0A=
>CJ=0A=
>=0A=
=0A=
Thanks for taking a look, I'll work these suggestions into the next patch s=
et.=0A=
=0A=
Robert=0A=

