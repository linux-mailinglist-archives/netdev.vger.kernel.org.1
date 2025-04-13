Return-Path: <netdev+bounces-181940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C0A87073
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 04:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89254189A84D
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 02:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7384B10A1F;
	Sun, 13 Apr 2025 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="syn41PJR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68076522F
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744511854; cv=fail; b=F4oqrqjuW2PQ+LE7uWCT2kwyOV9qzR2EJuiEWiGfMQwFck1CdOHFCdaTmCZX0nWZdzzB5vy2hB+7TZZEx6+Yq7JdyiHtEewhvSw5iIGhXOD+0EiQ0Wn6xBQ2/IgF9nTzjS2dy1LpJwIJZ93NpO0y+9724uLI5xe0UmSceSvmBpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744511854; c=relaxed/simple;
	bh=1GVr2FYA3ZktQqv3V7euxMwFoMVXux1niQbsqpwISWE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cVqvAvoBVASffSk8vLUfzAtRsbOGIKe3mtRvfnJ/6fGlSutTWFUW5GRN319srAQg1t0ZAUmyPImUEq6k7CEAC2WS8ovDDehG8NblyZc7O65h5UjLDrZzffI8E6fKfCDbgEdRQEH8N57u5rSmjh/B36KLjOilg3oCknyg+W5IyYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=syn41PJR; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CLghFG011360;
	Sun, 13 Apr 2025 02:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PlhWT7
	ki4u9glMcmPt+zXSS+1GKsfGa3aYv16nyatkA=; b=syn41PJR37CQ/HYc6yU4mR
	1qv6PY3l8DtXwLNtmStOC8P4YMCq24+HVQP4t3OdvXm955coaNXvEJYMl2YpeBlr
	3S9Y4gy84ifY0axQz8GDLIvVupHhLCKBoQXdVrDgVCeatIq1SS89c5DzdYCIYAJT
	CUA/vrQ2MDXXfdXZKssgnQ7yZAp2A7mQrwm1LFezxpGnzPZMBjO8UHCvZv0kAV/e
	F0L8vSsuWuS4Ud7m3IP2pAnAYyeRiGP9LP8On6Q0IjAdLNJSGsTVmJsgOOWxftlK
	/Gf9uL6CpIrqL+a3Xq+gLFPn25zQH9cxDbPrj6adN8ZaRetiRHr4vKbCBtKrHkJw
	==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4600ashb8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 02:37:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJawdeu3UGrFx54OfMhJOJetmgc1rCKHje/AahqLlA2rem+NBwYDEilJpHBkhr+eTOxjOEUVsKZEA3ZEs/qQzHl/b7xYMSLXvbRnxpDwyHb1njAXgA5XmkuWU9DnVGAIN7p4P6qNzfoXvoLK+C0Gb8SMqzchTqum4NXQ6JWxvyLTK/d12crnxg//Vcmtj7WoQhwOC3WHmqKVZLEaKG/o5TZabRFhdsBnzszeWzT33HtYBUWpegVgGw+MANbQ24Rih/ZnYogOp50717XcllscPn/7G9jggNnfDJIxhR45NwB3W90gStwrQvi/vmjAoIMVCRUYNZ+2gGMVLbMQ88BCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlhWT7ki4u9glMcmPt+zXSS+1GKsfGa3aYv16nyatkA=;
 b=d+xj6QH91O17sbMcGJFA8DbrMVnCcCVicHI+QNdhHeTjxrsOxfkYnWddAiIaaJ3AS7lCnMzzIjiJvk/V0qae4gU3R3+DWqiCx3F0tvDchE8COIrKKX4D3ix3T+Q2HDho0TfLSNA75zru2OusUtCXZIt1nxCnCsfdwOwFMzzPUGTXhYu4hLNOLDCVYuV8NUGvaA3N0DZMQl9noxqi2+f7IIlJ8sj98IG8H/PLKj6it+AZbeWnwsgxp6nFqE0/tixWNfBQoUmTziUMCA3qENCizS9Z12K79m79b+Gl/DOUEW3OI34rdTzXqOhDijXT6kucRZm5jBw1sj87xFpae2Tgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SA1PR15MB5140.namprd15.prod.outlook.com (2603:10b6:806:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Sun, 13 Apr
 2025 02:37:21 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%5]) with mapi id 15.20.8632.030; Sun, 13 Apr 2025
 02:37:20 +0000
From: David Wilder <wilder@us.ibm.com>
To: Ilya Maximets <i.maximets@ovn.org>, Jay Vosburgh <jv@jvosburgh.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
        Pradeep
 Satyanarayana <pradeep@us.ibm.com>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v1 1/1] bonding: Adding limmited
 support for ARP monitoring with ovs.
Thread-Index: AQHbqwoTrDjAZh6IzkG7iJ522lMXdLOfJPkAgAAI5oCAAbHmBw==
Date: Sun, 13 Apr 2025 02:37:20 +0000
Message-ID:
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
In-Reply-To: <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SA1PR15MB5140:EE_
x-ms-office365-filtering-correlation-id: d3ec6069-d093-4cc6-8e69-08dd7a341d89
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?wRPPWA4qvgO1JYEEOEw9DU0CSrBcUywgJxBfTr/dmqNwLi0jSrClttfUc8?=
 =?iso-8859-1?Q?VztyNug/PhgNT67aIzd5kjbvzdTvEDaIuKF7mUSNndOR1FQnGuU9VFeYs9?=
 =?iso-8859-1?Q?WPdrwNMLX7hSiXmNtiinGQULIBdRTy6aKAhofHeobdCuuSldSsvylnBjR6?=
 =?iso-8859-1?Q?07ReZ2rU+iR3BD9fiFHHgumcgw30Mv76wXE+m8Rl9HSispg1izyqkvuRWL?=
 =?iso-8859-1?Q?/pE29G3gmYv33Ecfsz/8JPIRPBKCtMceKR7bsPYLTez9F8EY4oUYGhk3DY?=
 =?iso-8859-1?Q?05Y5p1ld/EjZe2olgh3Bk0Jl/vW5ZijnWr3CqXUeWGwf3wBOelQ+/Ain1F?=
 =?iso-8859-1?Q?ihDsDcS7EqkZZ+pALl6KzWXA7sMSsf+6LWPMM0OXBQMF/Y1icPiO48vaEB?=
 =?iso-8859-1?Q?3mqq2VueNuntbOErFGsijZGL29xNzhj611on39qSRBy5D9Wy5T08wjOT9Z?=
 =?iso-8859-1?Q?AjpU9aympn88zm3ytW2mkocuo0Q342iH7gkq042q4OYlfNi+leU3D7Ysa+?=
 =?iso-8859-1?Q?37xhMNHlNoCylbdTz1TbWGymyS5qgzTfNrA9wyEko7eJc448xRN0rk3p1B?=
 =?iso-8859-1?Q?jjybw/xK4aXZM9vRuAo2KpjPD8dtDnGtRMUS5LDuzT+kd7MJ1LLb0ox2Ws?=
 =?iso-8859-1?Q?Sl1D02DAKMIlzl3LSEKBFKUT4waoB9nffryESr+SdFjNG68YO/dm5PoCCj?=
 =?iso-8859-1?Q?K9PY6+D701BYAY61DlJqFg5ydDL9xQpkV8n7BAA2YDLnTPGhjzZ2hHZ4JC?=
 =?iso-8859-1?Q?UqVnKU/2bUmFwHqoh0qZksv6fhZ6tZqKJoYNRn8ACVa39v1w2jw3hdW4ko?=
 =?iso-8859-1?Q?LOiXKgsOn8a7UE7TfYNWG7QykggSYxoRouY9RssV62N+6IPkI5zJOwUQlj?=
 =?iso-8859-1?Q?ofkX/AkSwt3K4ewK9KBToevzIU/ajnoyZgHHrV8nMdjTp0B1eOBXkR1Eu3?=
 =?iso-8859-1?Q?/SriwfYCnJZNyI/UZnj8jfWjJ71dZ5RnrmFv+DgwaGDdaLYjN3cUqxxRMs?=
 =?iso-8859-1?Q?VMD2Frrwpe6GxMpyWkCrZOmQYuTy/dDH0BhJEqbUJrRpixuWqqvBMovFSb?=
 =?iso-8859-1?Q?vfpfWLXEmpSwODQWtrvr0OCJnN2XcGZE6vT2pSH5EmiUXtWv7RIo9WkBRy?=
 =?iso-8859-1?Q?qPuPtH729aYQpii9pG/YyzFwc4fMfiFdo315f+BRi/dL3LZ+yGIbr4Jys2?=
 =?iso-8859-1?Q?rVd/B6aYzDUUFdxhoYpaGz9mWFpLH/wY1mdsiPKzYtxHiYk4FpEnF69gPv?=
 =?iso-8859-1?Q?pPyTmb92aOV1/VQEgpCO982CLK0Fy4dg808mdL4Nu/5UEtmSGtru3cFo3Y?=
 =?iso-8859-1?Q?LA7JXbIZ/JD53Jj/wnwOKJAXuG7Gdb50ItE+8pI82zp7rAx51CObcMolLy?=
 =?iso-8859-1?Q?tbb32pCkj2vef1kJhv5Y754u75A6cnHSOmAhHalZtjBGzEAGRH1PoYtQmk?=
 =?iso-8859-1?Q?1vD/nl3hp8e7Pmls+kb6C3U/dtzB15BiTrZxonktiChBK6OjWCwZqDkUYP?=
 =?iso-8859-1?Q?22kTM/Izf7J/pktVU8nQKerJX1nYL2WMJKUplv2dRlZ4Ri8t6wUHRxeyR0?=
 =?iso-8859-1?Q?K2VvTO0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mZRa9R0DMFSqzSyPZW7AHo1IFBbFJY8XaadGjoCD6g3FhFEYM7HtoCWOHD?=
 =?iso-8859-1?Q?Zhe5cIoqtFxyNffzPbmS2QU9Onz5a/+BwxOqn6FHbZgG0vSAUlMR/sXrtJ?=
 =?iso-8859-1?Q?jwizfRqRK9o3fvndals3beeiQeCb5B1RifggVFqPlBSCxljziKK8+DDPhU?=
 =?iso-8859-1?Q?espaKg1J3Ygb86QLUtixLt0IK2LYai/izjZqb32r1X+OHmTGenFOC/6OiQ?=
 =?iso-8859-1?Q?dQISVLuadR4WgIlQbNS46cz71K6YqNa/98RmN9Lom6+ETZwfWsbRK2ePl+?=
 =?iso-8859-1?Q?KZ316dYOuMrkghN51+P/Q9XkhOte9Hn3EUXvCJjapUpAsfnNjBpkErlgqh?=
 =?iso-8859-1?Q?iBSJ6wdwB6Q6pB70fG23vGlEWIiVQRT6WyCr9yCWAJTXIaQAZ7gGKxOO8N?=
 =?iso-8859-1?Q?uidR6oodz8i9rXsLarPtc+rchdoNdKt34xqjqsIAlBkIQzaVh3kpyQST8Q?=
 =?iso-8859-1?Q?CTjDtqkfhe/wszIi6NpwnCsgo01mABHAL34vXVpHIUfEoTexv+MhNkxo/E?=
 =?iso-8859-1?Q?J40Oc0lstZzbtSeEdQ2lKjSOrUJbl/6z9hb1C5e0SlWWmIbMfp4vL6pDDB?=
 =?iso-8859-1?Q?dnyv1Ppo8hUdwM8a+nduuomuCJGrDU/HJvSyDiH/yo6QIbpnIjwWehx/7p?=
 =?iso-8859-1?Q?sfFjDwZLZxhodB0b6Xkfd43IOngUHH+IRMa3NBDB+a2I7X4oDWVLmpzbkx?=
 =?iso-8859-1?Q?K3N9FfdxlqYOP/ptqauEVwWKMmq0DGc9Z1O/i6lGSyQT1KrDaKX97yGTM4?=
 =?iso-8859-1?Q?jqskgPKtE69UEktE7CrJssbbmaLTD6WEI/SHU4a+mUR6FpAplToKwWXH7T?=
 =?iso-8859-1?Q?eN541locjLCXVvtrGRucGmZjlRuYt3GmCLevMQ6M4uA6IIXZz+NGmcTBIN?=
 =?iso-8859-1?Q?39rGVuS6ClRTNZA2WYdcSEKUCkzgsXoxKpe6raj6vyHlbbZjuHdRU9zkMw?=
 =?iso-8859-1?Q?JtdrBhzK4SRayPg2DPMRRuOuc8vnzxOxBKdekWNaux53zi32vPo4TB87Cv?=
 =?iso-8859-1?Q?/e3tW3oHHYAau7XRQjVw/y977SwWpuUnxh3fO0DcohHnAlO+/37WNV5Xh/?=
 =?iso-8859-1?Q?08/ePLzUW8n4FAzAFNKbiZnAsfPElAxR7udQbnyhr/7vYi0ZUzeuHbed79?=
 =?iso-8859-1?Q?/wR0Q6kRyqVFJ2877b0bOpbUSYadQD/NxYj/VSNKSorAs2K8TQIlMX+SnJ?=
 =?iso-8859-1?Q?DFWHDyHfDjoo5Hq7ScgLUnSOxoGBFt1+06l3SeHPOvgHUbmAV3PMEHNyyl?=
 =?iso-8859-1?Q?vWHt1CaRcY7HAaZsjekOcs2znwA3Or5nOZtphvqg1W7uLUaWm7jbtggqUX?=
 =?iso-8859-1?Q?n/M9JxkuaXtMPuPerScnHVow7RgosI/DrFBwecItTUCROcNiYqb3rKtvk3?=
 =?iso-8859-1?Q?Pb+VixiKmyekRlqO4n5eH6mCVlL/+JR8EeAy90hYdS5/5imZGkc5ewEomT?=
 =?iso-8859-1?Q?t7n9RpemHXJeUydmFtplxaThRKaiiebQlHUbWKCekYQ1EL8qsQCbdecp1a?=
 =?iso-8859-1?Q?qNIL9DtAHA5HynyY7SdV4MIU7822v3VZbs0YlU5suS31MwXVVkj0Pb4kRi?=
 =?iso-8859-1?Q?F9GqZwISR+9O+qQ/QxUAMjr5gBMyIt7Llrcdt25goSPfkBn50A+BZtE9SB?=
 =?iso-8859-1?Q?qw1IV1ABZaWpw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ec6069-d093-4cc6-8e69-08dd7a341d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2025 02:37:20.8415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vNWBV0V/bZiLpAS3Wn7+9b8jra52AyQfuskvVMceOoNCIXkqgskTi471bfDO/YN5O2PfmBErD1fwMS7EWIsxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5140
X-Proofpoint-GUID: uMtF_T28n8jJ1lmR4ZDuxcrzwxyqk0Ut
X-Proofpoint-ORIG-GUID: uMtF_T28n8jJ1lmR4ZDuxcrzwxyqk0Ut
Subject: RE: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504130017

=0A=
=0A=
>>> Adding limited support for the ARP Monitoring feature when ovs is=0A=
>>> configured above the bond. When no vlan tags are used in the configurat=
ion=0A=
>>> or when the tag is added between the bond interface and the ovs bridge =
arp=0A=
>>> monitoring will function correctly. The use of tags between the ovs bri=
dge=0A=
>>> and the routed interface are not supported.=0A=
>>=0A=
>>       Looking at the patch, it isn't really "adding support," but=0A=
>> rather is disabling the "is this IP address configured above the bond"=
=0A=
>> checks if the bond is a member of an OVS bridge.  It also seems like it=
=0A=
>> would permit any ARP IP target, as long as the address is configured=0A=
>> somewhere on the system.=0A=
>>=0A=
>>       Stated another way, the route lookup in bond_arp_send_all() for=0A=
>> the target IP address must return a device, but the logic to match that=
=0A=
>> device to the interface stack above the bond will always succeed if the=
=0A=
>> bond is a member of any OVS bridge.=0A=
>>=0A=
>>       For example, given:=0A=
>>=0A=
>> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1=0A=
>> eth2 IP=3D20.0.0.2=0A=
>>=0A=
>>       Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparently=0A=
>> succeed after this patch is applied, and the bond would send ARPs for=0A=
>> 20.0.0.2.=0A=
>>=0A=
>>> For example:=0A=
>>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported=0A=
>>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.=0A=
>>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not support=
ed.=0A=
>>>=0A=
>>> Configurations #1 and #2 were tested and verified to function corectly.=
=0A=
>>> In the second configuration the correct vlan tags were seen in the arp.=
=0A=
>>=0A=
>>       Assuming that I'm understanding the behavior correctly, I'm not=0A=
>> sure that "if OVS then do whatever" is the right way to go, particularly=
=0A=
>> since this would still exhibit mysterious failures if a VLAN is=0A=
>> configured within OVS itself (case 3, above).=0A=
>=0A=
> Note: vlan can also be pushed or removed by the OpenFlow pipeline within=
=0A=
> openvswitch between the ovs-port and the bond0.  So, there is actually no=
=0A=
> reliable way to detect the correct set of vlan tags that should be used.=
=0A=
> And also, even if the IP is assigned to the ovs-port that is part of the=
=0A=
> same OVS bridge, there is no guarantee that packets routed to that IP can=
=0A=
> actually egress from the bond0, as the forwarding rules inside the OVS=0A=
>datapath can be arbitrarily complex.=0A=
>=0A=
> And all that is not limited to OVS even, as the cover letter mentions, TC=
=0A=
> or nftables in the linux bridge or even eBPF or XDP programs are not that=
=0A=
> different complexity-wise and can do most of the same things breaking the=
=0A=
> assumptions bonding code makes.=0A=
>=0A=
>>=0A=
>>       I understand that the architecture of OVS limits the ability to=0A=
>> do these sorts of checks, but I'm unconvinced that implementing this=0A=
>> support halfway is going to create more issues than it solves.=0A=
>>=0A=
>>       Lastly, thinking out loud here, I'm generally loathe to add more=
=0A=
>> options to bonding, but I'm debating whether this would be worth an=0A=
>> "ovs-is-a-black-box" option somewhere, so that users would have to=0A=
>> opt-in to the OVS alternate realm.=0A=
=0A=
> I agree that adding options is almost never a great solution.  But I had =
a=0A=
> similar thought.  I don't think this option should be limited to OVS thou=
gh,=0A=
>as OVS is only one of the cases where the current verification logic is no=
t=0A=
>sufficient.=0A=
>=0A=
=0A=
What if we build on the arp_ip_target setting.  Allow for a list of vlan ta=
gs=0A=
 to be appended to each target. Something like: arp_ip_target=3Dx.x.x.x[vla=
n,vlan,...].=0A=
 If a list of tags is omitted it works as before, if a list is supplied ass=
ume we know what were doing=0A=
 and use that instead of calling bond_verify_device_path(). An empty list w=
ould be valid.=0A=
=0A=
>>=0A=
>>       -J=0A=
>>=0A=
>>> Signed-off-by: David J Wilder <wilder@us.ibm.com>=0A=
>>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>=0A=
>>> ---=0A=
>>> drivers/net/bonding/bond_main.c | 8 +++++++-=0A=
>>> 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c=0A=
>>> index 950d8e4d86f8..6f71a567ba37 100644=0A=
>>> --- a/drivers/net/bonding/bond_main.c=0A=
>>> +++ b/drivers/net/bonding/bond_main.c=0A=
>>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_path(st=
ruct net_device *start_dev,=0A=
>>>      struct net_device *upper;=0A=
>>>      struct list_head  *iter;=0A=
>>>=0A=
>>> -    if (start_dev =3D=3D end_dev) {=0A=
>>> +    /* If start_dev is an OVS port then we have encountered an openVsw=
itch=0A=
>=0A=
> nit: Strange choice to capitalize 'V'.  It should be all lowercase or a f=
ull=0A=
> 'Open vSwitch' instead.=0A=
=0A=
>>> +     * bridge and can't go any further. The programming of the switch =
table=0A=
>>> +     * will determine what packets will be sent to the bond. We can ma=
ke no=0A=
>>> +     * further assumptions about the network above the bond.=0A=
>>> +     */=0A=
>>> +=0A=
>>> +    if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)) {=0A=
>>>              tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);=0A=
>>>              if (!tags)=0A=
>>>                      return ERR_PTR(-ENOMEM);=0A=
>>=0A=
>> ---=0A=
>>       -Jay Vosburgh, jv@jvosburgh.net=0A=
>=0A=
> Best regards, Ilya Maximets.=0A=
=0A=
David Wilder (wilder@us.ibm.com)=0A=

