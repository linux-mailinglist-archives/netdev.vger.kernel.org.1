Return-Path: <netdev+bounces-203906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E9AF7F8B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE63BF721
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5952278150;
	Thu,  3 Jul 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QwDqEpEH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C83257440
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566073; cv=fail; b=Y/ZbWCzdXqypT0KI8SxsdRwk1yHYBsVN+3bK0aisLRMASMZo1UcsdPq4s+Ill+MSVQrLKMhEy7TWPe8RA9rtWIIbKbSTgJjYAw2xySsR8woCqvEq93si/VdJFc0caWMcHQDGIvKM27bkAI7NEGeZ2UkygdNpVjBtoWGRzZwx128=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566073; c=relaxed/simple;
	bh=XxedsdPQ2AG5K4TH7Yge2PVYpwB1oDQ/4qqNlPekuZY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XVEwSKX1dNyjgaHofVH1g0txzChADGYlruCEItQ/APaK2lhjbP88SEQM97KK6+jxI7HU22vjWXaVyYeLPi3dUzEUie2vUdNWw9u+AXVuZCr5WrwW/OMqqjVRsliq0Uyl4kq3nyuclMt2FUUEU7KrBaagIn6AvdYoxbCFHe3tqBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QwDqEpEH; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563FL4Bl031469;
	Thu, 3 Jul 2025 18:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9UoBKV
	7D9nOqUrWZX1hC0PzrW+H43WRxn1KgPJzsbO4=; b=QwDqEpEHvzRtZCB9ecZyC4
	vo7NKBal7GDkjV1yv7u4qTlOEok78xzZz76Z27OYbkDGvccR1DOFEF9rkf1JO4FM
	ZBgaWn9CH6p0ux6mn/f2/1BmZBCseSJyamuo+cHvSNHMfSs2VSl1O4kbz/UVwiu6
	lNh1+dfkTIkJvW5+cXtzuQk9vRKuPYrdZ5z4+67zxUPLv1D7FTt9u7NiCfUeoqOG
	Um0xCSk735bf8n/clXWOuMdUXa91tSSuesiGCjx2ze4l2TS+RaErprr/5lvmNvAK
	pWWG7dRoCTsuMKpOEfqrOk72zoAor8tN4swENE2GmbZQVPsSD5bkGLga9bbkfwXg
	==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrwktg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 18:07:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoprV2pQmAiPZPOxCsV33lreFDT4uCBbLSY2wCOyQkOUus2y1PtfST5P4dBj1Oe1nSSbfAm8JvkcHjmg118iR8EL2bPGIhRW/WWpOQu2w4LOAYFgQPSrSnfed5U6gwZ32wx4TFFiqvEthHtiiIa2lnSMvdIzadwZpN8VL2RxzxirhUHddqqkaGT/mOLR4l5yrjWQ8P9DyrE6PIWq71QGjVieqm6MCGKmTXu6o9tOLbTv4wDLnAZgu+SdahLbAxn5PIQZhuixdK7cVnejbtjbaHiqHqBUgumKL+PdVKl6P5l6PNTkSW4AEJxNnt14UMOOFtVR3NPsAF2za5SqCsHqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UoBKV7D9nOqUrWZX1hC0PzrW+H43WRxn1KgPJzsbO4=;
 b=omuuZw7RkX5sajNGxIn3O3aq5zq/zOMCm/wk5//WNExzgnRSUjcRBg+y3Ly+J6FQeDguQV8RvuCIFoczW/yF4ZRPpBxRBYtUZznjWvQxKCEMdbfEWCl0zO7Z7cdtsyBnc+5pKo9SDJQAjuGDUdFTK2cwhOdvgDDV0eN0PKZlfg6t+JC8C9vL/KNhVYqIMV/lMnmj8eGeJgSm+IEXb9ss4ODbTx8ZvjxugLkVNHzofGUYqXJvw91sU5s43fVJSDoLuIzusvqljyzKdRN8ejQX+swLqT8YRpgZzk+qOlEg99+sxv3vuJ50dUQATTYEgeGyReZzHBloOKUIFSRI7W6OXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by MW5PR15MB5145.namprd15.prod.outlook.com (2603:10b6:303:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Thu, 3 Jul
 2025 18:07:41 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8880.034; Thu, 3 Jul 2025
 18:07:40 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jay Vosburgh <jv@jvosburgh.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
        Pradeep
 Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org"
	<i.maximets@ovn.org>,
        Adrian Moreno Zapata <amorenoz@redhat.com>,
        Hangbin Liu
	<haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 6/7] bonding: Update to bond's
 sysfs and procfs for extended arp_ip_target format.
Thread-Index: AQHb56DRmB+AlXJB4EOcG/QxFj7ItbQfMAMAgAGKQAY=
Date: Thu, 3 Jul 2025 18:07:40 +0000
Message-ID:
 <MW3PR15MB391314E9DCF1857511DF11D3FA43A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
 <20250627201914.1791186-7-wilder@us.ibm.com> <2140656.1751481136@vermin>
In-Reply-To: <2140656.1751481136@vermin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|MW5PR15MB5145:EE_
x-ms-office365-filtering-correlation-id: c1812c5b-c30e-4175-ff78-08ddba5c802a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mgmJ/9gZSd3SK6rdC7/nJgB92gGCD/yaL4X285XBeQ4DEwL3vlRbQz4QGK?=
 =?iso-8859-1?Q?SXVTzmIa9lVg+XTrHPNOl/o5rMhVGm4RB62H+2bHzNwCextskuU8Dw64Tt?=
 =?iso-8859-1?Q?eMtVWyrWYJueofzB9mGjQWOxoZXhTW758wzH8xqLp3KzR889V6z0WVlieH?=
 =?iso-8859-1?Q?t0a3xitlmyCx5qtgEvC1ByPlcaa9P7fgev9fWW15SLSwNhil2V1D9kvrHV?=
 =?iso-8859-1?Q?BhpXYnhd//qkcdVhWkefAXMeG/ueit3GcFMOdyXY5n3uPfKMXBhB1pWx76?=
 =?iso-8859-1?Q?dfHvNy7w6kC+j7of6XJDJUUYhXOHVka2H2+aEBCFPKLGZHR0g89iONXPkB?=
 =?iso-8859-1?Q?sliMI0F0U3cftG49J2SGb1yBzccfZMVT2QyvofSwIb3Z+RQ9PIZR8abmcV?=
 =?iso-8859-1?Q?16MfmGKY//RvSQL6h6olTkNmMr2bWCzBFM7UaHN2HoG54W7PXhVhdQ6RR8?=
 =?iso-8859-1?Q?8GTlx0BUX/EVMIJe3SoPEAYJGzU+yzwSXMgL7K20JsqJB2fhp0lQQ2Ldt5?=
 =?iso-8859-1?Q?ojVc/PP7IsKNJbPwGjEGtuJ0IWKmCAewBRdY5PsvAlzFLgtwyUxntkfKDf?=
 =?iso-8859-1?Q?L+RZOYt1nx5xBdo9VrNtKX2dbr4CO88Y1j5GX9zg4zLHgzvJhbsXAMBo/9?=
 =?iso-8859-1?Q?0fzjXlPcaWY3tKHgi8WQ6u69Ychhjk5nTmBfGuvgbv9nnQF4gb9zWT0MBz?=
 =?iso-8859-1?Q?KNeniFAx56FMCbnLzZNtnVpZtcsXwO/+2qFhx4R72PAo4b6cIOmwm+vZyb?=
 =?iso-8859-1?Q?J7UTxMwWkqQGWcn26iJqk5vNrq6kWtyVQ/PudoGOlVLbHVGWsE5ggSWNk0?=
 =?iso-8859-1?Q?VSrM5hasQoAQLitd68g4sy/eCVc+VN6oR4ecVrNOylegTwrqO5StSf7SAS?=
 =?iso-8859-1?Q?nD6tzChbNr2wNFGO3jyLegZQlU7QaODCs2lc+LvnIH1vruBpzizkEVG1YD?=
 =?iso-8859-1?Q?2YD5vvO5sVMHGGPl6safnde2gP3p6bSb3W9Rupd92GoEWolk4KYCTFhSJO?=
 =?iso-8859-1?Q?bauZD3nUKQaj8CGBaug3Zldgdd/JUyH5xARryc8pPdBfqDF3Nl+RjhCEj0?=
 =?iso-8859-1?Q?sf3LOi5YsWKWCcGlHORV3ht1/F7mVQx831oMTApT2tpLHfyvWg5YLXw9k3?=
 =?iso-8859-1?Q?e8jIxwQnp8zJBXf61j+uIVu3ubULQvpzazMSps24YR8VMEId8GgX1L21pq?=
 =?iso-8859-1?Q?+yJksyJ2VkD38rZcuymwLmVstlyCqBedF28CtrtDj+AuttcJlIwu5tAfeU?=
 =?iso-8859-1?Q?sGMYvOwZGWmwZQV4ah6uzqtiBDu1NAL/T4eg/2Z5hSf3cMgQyj70yvfmp6?=
 =?iso-8859-1?Q?BMZJT2HTuK4W2F5eK8Vdcqx1qH98xuS0Cr5gf/P+u7UKeOGv3S0dG0JjXc?=
 =?iso-8859-1?Q?H1/MSkD3Jdt12asF9ZptjdHeeMHA3w3ZmxsPyQqPP/LlJjsB9LcOm0FZHJ?=
 =?iso-8859-1?Q?ZEik4f9st5jI5hgInpVSDl6B6iFSK5p9Lgn2HEYPMUEpUsZsmV8kXXpGWC?=
 =?iso-8859-1?Q?Tj/Sr/TvCq9lOic+aWR5vpUdn1vCo22/ayK62ZWdY4Sg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gzTarS9hOaNiUXpLcpnD50qUoQuXH61+MdM9cbYe6WL3YFkJPhIdhryCr8?=
 =?iso-8859-1?Q?5pRGfyhuK2kKmxkcuEOEqWbqprarfpkJ+22cEjrE4ZoFVjObPz5S3zX/hY?=
 =?iso-8859-1?Q?4e7GZI/6Td3XZy0t8OGIww7tIeIWCWAZsPaYSJk0xe+CMCuzrszyl1tck8?=
 =?iso-8859-1?Q?CP5vE/xkrMOi9/U+CJ5ynKys5JKhiERlpDdwlt6/8fPn4xxRyGN2tRtk5z?=
 =?iso-8859-1?Q?n0Sxa4F3j1IVeV5JK4HCEVCj+YsOJNDgaWslbLYGg/C5rM2KEa7s9THib8?=
 =?iso-8859-1?Q?Gw9yhf0Ri8F6X0wD2j0Godk25RzIM3+U9VKZwZp6xvrORO4jQnJwvZv8cW?=
 =?iso-8859-1?Q?bk4zZKxUuakLzqchf2BlWirTQJPg3QCdWontiLo0q53HpjGKDDIgGUWUFi?=
 =?iso-8859-1?Q?X1geOF7irD/KdKufQil56AtVSXK9aGTSZ/NOAHcD+O8DGOrCHULrCUyTkg?=
 =?iso-8859-1?Q?Jhp7vzrQrz2upwqFNk5On2ZnKp4qypfcI9X3PWW8IICfYq2iN5IkVBBwMh?=
 =?iso-8859-1?Q?N6NrouukfAmIrsHI2LA0ladQbtHsoLqjCmW1iXNf3dopourbCigIZA66MO?=
 =?iso-8859-1?Q?SVmiuAQStuI0/f1V2sEnvPp+MXMURS5dLSRot+pjNipSvyAQ3895dACiSF?=
 =?iso-8859-1?Q?CAS5Vxar+KSdoS2SV7QopzUXVddh4i0fPEMphxwSYpZjBHGT8HZKaSI5sT?=
 =?iso-8859-1?Q?kU9OQKHhTdH4Cdb8vmnDMHR5R56SY8uPn7C3AUTNy0VZ6NuQh7AUfwa7IN?=
 =?iso-8859-1?Q?Hrn0ReoGpwJ8bO8ToP417zxz42OAgxGRT4sr4WyQ6Sg3FK1FFuG+e69NcE?=
 =?iso-8859-1?Q?N54ZbsWCiDX23u+R8Z1TDrkBOVgLh+aVEpQ2xNaGS2CISU0qxoFuaPVu0t?=
 =?iso-8859-1?Q?SXOqy16tbWjUjNKOBxdVeuiqa3RLYpAGcGs6NKY2vlyHmmSFnmblNj+Xwm?=
 =?iso-8859-1?Q?D+CnbXEqFzyokXfhoOlZewgXgWkVHvPVF8Uniu82hF5jF4mslEPjGHEDxg?=
 =?iso-8859-1?Q?/iCIQBk0XLH8Mjv9dM6ILkF+dxt/cqvw0Hazd9OcOLPihVPWCsMs1QRVmz?=
 =?iso-8859-1?Q?JvCCGgJF3Wg4PXA+C369WQJXtZEPVBSTWe+C8yrL4MW4jEjZopIs//b61J?=
 =?iso-8859-1?Q?CMQG4eAIc9iy4H+fY7WG6v1bBmGEBW797Bl06X7aeQXyycP5/LrssVaH4c?=
 =?iso-8859-1?Q?x6/IjzbHMNeNunxKc+8EKx16V93dFbeP74KbZEHEeu5srAc4uuJi5KURys?=
 =?iso-8859-1?Q?NSwpAlR3Zkxw2V5NC/chBYwkt/ApmEDNxACD0l7aViVKKoM2ifkoL6yhoi?=
 =?iso-8859-1?Q?IhnR/AvlgDjx3VwVtZ/EF8uMBESONLxoeeuIhH63J7M/5MSN04nzApMzTr?=
 =?iso-8859-1?Q?G2YbBuerk/cJ+u2IjI5bPDQDox0mHk6IcYwYhWyHHxIkR7fmbUgrO3mh5D?=
 =?iso-8859-1?Q?cqTmaRNI3y4uMl8Vhaymu/E2xQINSdiwujSouYSlen4thP1VNaCdX8Ae0y?=
 =?iso-8859-1?Q?SLcE/pqlYslSBdgTnZSPtePgtIA3EOk0onMTd9RqwaSVuum84QNITGDT+o?=
 =?iso-8859-1?Q?jQyOIkNB99KrhUwLPBRgcF2FQcUtd8ighNn57bblpZiYmJMhRQKt1pNVry?=
 =?iso-8859-1?Q?AlDFf2cJ3tVzE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1812c5b-c30e-4175-ff78-08ddba5c802a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 18:07:40.6378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13s2f513wGvVO9wA571i2KheZ+mCdhtKFLLkuM6ajNxFV90TFap4tAP1RU52tlGl9c9BN1qqgYH68JwlWtGsiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5145
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=6866c6f1 cx=c_pps a=KqyQ1c2F0axk0YoGbn20nQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=-4jYLz8tYmzewAd6:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=2OjVGFKQAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=0x2VMApR1apL0wsx2IQA:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
X-Proofpoint-GUID: UjSW1MNXH3VzGNR9vOsyv-V7hNCh5c7Z
X-Proofpoint-ORIG-GUID: UjSW1MNXH3VzGNR9vOsyv-V7hNCh5c7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE0OCBTYWx0ZWRfX7llDxOeaccQk EXBVNTtEOW7mjkYgkf/w43PDrf2nxq1qs66ZuvpJEmfd5B3+7+Pn0Qc9keWxm4ugaOl/WiZ1Ww7 kuxOUx9YXagy+pyE+p6lEnK4F8BFQLe9a+BXEY8yTo5DDhNT7NjET7ZPj1HWxg4XdaIA9BNE7vu
 ve1l+jHdA89FjeHwSr8Q1x2aplBtvc4H9BTCIaDy9opdKnzRt9xb+oveC8fXQFTmoJGdwOdlMRZ Buow5ZAbe4lNUmUzfP446ap5BINqt2Mp8aLpzLBGLcmdZBBCXvlz2JSeu6wENo5tAAR6zKU4eEH H1ciuuC58TKNIUCd5aH54BqI4Uu7LTzIaR0s8bBIksJfc84GE2WhoZiZVRcvMmlHBu5PtOJKFxE
 9hl+5t+QH/wOruiAj1O2ocKRbx51ruzrtw6N1fxtGMGJWVLBZmN4pmyKe2KW0f87/d75uJEi
Subject: RE: [PATCH net-next v4 6/7] bonding: Update to bond's sysfs and procfs for
 extended arp_ip_target format.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030148

=0A=
=0A=
=0A=
________________________________________=0A=
From: Jay Vosburgh <jv@jvosburgh.net>=0A=
Sent: Wednesday, July 2, 2025 11:32 AM=0A=
To: David Wilder=0A=
Cc: netdev@vger.kernel.org; pradeeps@linux.vnet.ibm.com; Pradeep Satyanaray=
ana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v4 6/7] bonding: Update to bond's s=
ysfs and procfs for extended arp_ip_target format.=0A=
>David Wilder <wilder@us.ibm.com> wrote:=0A=
>=0A=
>>/sys/class/net/<bond>/bonding/arp_ip_target and=0A=
>>/proc/net/bonding/<bond> will display vlan tags if=0A=
>>they have been configured by the user=0A=
>=0A=
>        I don't think we need to do any of this, the sysfs and proc APIs=
=0A=
>to bonding should not be updated to support new functionality.  Netlink=0A=
>and /sbin/ip must do the right thing, but the other APIs are more or=0A=
>less frozen in the past.=0A=
=0A=
ok, I can remove this patch from the set.=0A=
=0A=
>=0A=
>        -J=0A=
>=0A=
>>Signed-off-by: David Wilder <wilder@us.ibm.com>=0A=
>>---=0A=
>> drivers/net/bonding/bond_procfs.c | 5 ++++-=0A=
>> drivers/net/bonding/bond_sysfs.c  | 9 ++++++---=0A=
>> 2 files changed, 10 insertions(+), 4 deletions(-)=0A=
>>=0A=
>>diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond=
_procfs.c=0A=
>>index 94e6fd7041ee..b07944396912 100644=0A=
>>--- a/drivers/net/bonding/bond_procfs.c=0A=
>>+++ b/drivers/net/bonding/bond_procfs.c=0A=
>>@@ -111,6 +111,7 @@ static void bond_info_show_master(struct seq_file *se=
q)=0A=
>>=0A=
>>       /* ARP information */=0A=
>>       if (bond->params.arp_interval > 0) {=0A=
>>+              char pbuf[BOND_OPTION_STRING_MAX_SIZE];=0A=
>>               int printed =3D 0;=0A=
>>=0A=
>>               seq_printf(seq, "ARP Polling Interval (ms): %d\n",=0A=
>>@@ -125,7 +126,9 @@ static void bond_info_show_master(struct seq_file *se=
q)=0A=
>>                               break;=0A=
>>                       if (printed)=0A=
>>                               seq_printf(seq, ",");=0A=
>>-                      seq_printf(seq, " %pI4", &bond->params.arp_targets=
[i].target_ip);=0A=
>>+                      bond_arp_target_to_string(&bond->params.arp_target=
s[i],=0A=
>>+                                                pbuf, sizeof(pbuf));=0A=
>>+                      seq_printf(seq, " %s", pbuf);=0A=
>>                       printed =3D 1;=0A=
>>               }=0A=
>>               seq_printf(seq, "\n");=0A=
=0A=
>>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c=0A=
>>index d7c09e0a14dd..870e0d90b77c 100644=0A=
>>--- a/drivers/net/bonding/bond_sysfs.c=0A=
>>+++ b/drivers/net/bonding/bond_sysfs.c=0A=
>>@@ -286,13 +286,16 @@ static ssize_t bonding_show_arp_targets(struct devi=
ce *d,=0A=
>>                                       struct device_attribute *attr,=0A=
>>                                       char *buf)=0A=
>> {=0A=
>>+      char pbuf[BOND_OPTION_STRING_MAX_SIZE];=0A=
>>       struct bonding *bond =3D to_bond(d);=0A=
>>       int i, res =3D 0;=0A=
>>=0A=
>>       for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++) {=0A=
>>-              if (bond->params.arp_targets[i].target_ip)=0A=
>>-                      res +=3D sysfs_emit_at(buf, res, "%pI4 ",=0A=
>>-                                           &bond->params.arp_targets[i].=
target_ip);=0A=
>>+              if (bond->params.arp_targets[i].target_ip) {=0A=
>>+                      bond_arp_target_to_string(&bond->params.arp_target=
s[i],=0A=
>>+                                                pbuf, sizeof(pbuf));=0A=
>>+                      res +=3D sysfs_emit_at(buf, res, "%s ", pbuf);=0A=
>>+              }=0A=
>>       }=0A=
>>       if (res)=0A=
>>               buf[res-1] =3D '\n'; /* eat the leftover space */=0A=
>>--=0A=
>>2.43.5=0A=
>>=0A=
>=0A=
>---=0A=
>        -Jay Vosburgh, jv@jvosburgh.net=0A=
=0A=

