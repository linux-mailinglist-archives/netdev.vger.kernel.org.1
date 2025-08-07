Return-Path: <netdev+bounces-212073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5638B1DB92
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91342565100
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30B25BEFE;
	Thu,  7 Aug 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Arw7Vt2V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1011A0BFD
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583887; cv=fail; b=DjPGoRIfVgzTIsuKZWOrbzzzcITGeElq7LLS0VI+3wp3CquGlymMs0bEqf4yyFk4kp0K1J8o7TNyrgmFIcGkA2Y/ITgK5xD3KlWas9iiwbDCBJV43AFfaK/nvh/gJqQkNJHxseiTwlS+FXBb3RDG1yy7AlBMJYv9VMBmh9j8vJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583887; c=relaxed/simple;
	bh=cW74SsijqWb7GN8ZlEyYpN4amRDQt1/BZnVr4+y+J4s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ZEW1pLqi0Acz9q/b9GSpNm7GocfK7xSfhcGMZoyc8GDAMWAhGc28qnkfY95m6s002MIXDC3tH4Ypjv8PnmCAE60AAjp9Jpav2U3FYHoOiadcMC+t16uKBIJL8526pfnivjfccu9OKXxhnZqi3xo6q4quzHtueC1X7KVE9aWdgZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Arw7Vt2V; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777F13c028209;
	Thu, 7 Aug 2025 16:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P2mNzc
	/5NhABQAvkXjoZr//1+wHW2wBPhW0ZSYGdMKU=; b=Arw7Vt2VRn8eZkMWEQdiJ5
	4l7G0vVGWO0s4VE3qr4j1pLtFtLSq1RWZu0ySLzcv1C/AB52B2UQjPlZWNouBWt0
	pHzv1xRh06PVKNh/tXEfVHLT8H2TdZCpH96Ebsb6G53r6hW13rCN+n8jhYJYn90y
	wwvbjc/qBPVeh+OghZM/AWUGYvK/pT7VOCTt5/ZK6BawWFghgtpjrLqdoYwFc1er
	9MOBdOrmeBeuEHhsbya0PEmEQqtEkTpiYgTnRr9dSp4Nd+DtDvBfhcU4yUcHhR2Z
	iAEzNkwkI+qcWMKShwy3HosaLdPKlHfQ1e73kPUxBAdXa9oRdblX26aT2Qz/ZMjA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq613eav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 16:24:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577GIHMp011049;
	Thu, 7 Aug 2025 16:24:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq613eat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 16:24:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsA1Y2lDjpkunUIBMkn0B/XZGgshWueAs2N9/qnlp7Oxx9aumztzTWjznDRsCK7kOdDnSlW3/h4NjMApYF2kKWYyr7riZfmLOGLzYTlC4ff9mMronjkgtem6H3c5RpLVVI5kLVv6rlQUh/BXZevBtp08Dgmnjjl+E61OVFjr9tKyxrSVU/Lb+a+Fq8Xz2Jq86BfJtG2AEWYxsGyZsW5iMrDj9ec0B+vOSSHKaU1Z43aJMtzICMIH+xFMipflmAOXiBi8/M7XC8KysiHRo8p0AAHzEoGbQ87TfKpj65XXpnsmVRtdi8MT0udt/x7EJ1cQ4uEPd/FSgmBr/LGyiJK9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2mNzc/5NhABQAvkXjoZr//1+wHW2wBPhW0ZSYGdMKU=;
 b=qJUfxq9MNeVfjHREj92FqYGodh5ADLWQjYRjDMPGv5dCELpgFp4HQNvVFiXqOj2XfSkYLwxLUGtt0ZNn0YawFcENh+mUhZl2gfJ1wKDhr+eJJfbufNbFEMrWwDT5otApnYlDGwifPGuLScXk1+RRH4kSSwwJxskJ64JtEcRri0UnpOMZvFE+VBoVmQ16+kKm9KUal4bEgb8WLokWEfE/EJgKOQZWOf8gEVNyvflGSOqL5iowkB3IbSOgBjNIhpoklLTPauD+teGl0skCe5MxXLIaoI+1QfxKNpNppMrFPPU5nUtSA8DJZoWV8UL6gPq4E5xfQYZzb1Vt8pZEAKsBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by PH7PR15MB5173.namprd15.prod.outlook.com (2603:10b6:510:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 16:24:35 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9009.016; Thu, 7 Aug 2025
 16:24:35 +0000
From: David Wilder <wilder@us.ibm.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend
 arp_ip_target format to allow for a list of vlan tags.
Thread-Index: AQHb56DNA1oUWT6TH0auSxBsTshb3LQbgW4AgABZC8mAAQV0AIA5+xmAgADCZAY=
Date: Thu, 7 Aug 2025 16:24:35 +0000
Message-ID:
 <MW3PR15MB3913268E49B5D040CFF75107FA2CA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
 <aGJkftXFL4Ggin_E@fedora>
 <MW3PR15MB391317D5FD3E0DCE1E592EE0FA46A@MW3PR15MB3913.namprd15.prod.outlook.com>
 <aGOKggdfjv0cApTO@fedora> <aJQtzYe0XyFAEKFz@fedora>
In-Reply-To: <aJQtzYe0XyFAEKFz@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|PH7PR15MB5173:EE_
x-ms-office365-filtering-correlation-id: 70c1f2a9-331c-4f01-30ef-08ddd5cee5b4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?fmPth8YD25olhvnqja+8SSjcmcTvn2CzXqBxAWTxmsjAfzLWVxL/FT8t?=
 =?Windows-1252?Q?hfgywCOPsRca9l3oGWXhL0IAYqKumSyU8tQaQHSnHXWuc6PmBMUOiiOY?=
 =?Windows-1252?Q?DOckJxyHqToJr+VNmPcZYS6dy45OcxGwp6PQ5SKxcLrz76DVrQLTiJvE?=
 =?Windows-1252?Q?bIFmviiTAnjWklEhRr87Xblj9r2RZd01f2p5mdof/qk7TkRHIcOn1+eb?=
 =?Windows-1252?Q?MsE7FjattTxwA2iaGovNwn3zYIPo9ckbdjyFQrUaFQ/B53H7vJg8c6Ny?=
 =?Windows-1252?Q?64Dj7zylmyU29f3s/arX4wnOnA/X81J0Hp4yqKHYzZwsiHE1itavQgpc?=
 =?Windows-1252?Q?BwWtd6gZCodaKT+KgaqVu03mMc7pNvgNQVTdpJO4qyZz2cyU6SR/ORV0?=
 =?Windows-1252?Q?KUcsKvB+k+qukunP+JEPR6ElGMQyat29Id2SXvc+gIwoZ/StRdxxBhDt?=
 =?Windows-1252?Q?tkNB6UvVrDvMO2T1vfGWwjCzDIRanOhzE/itD2CiVYHYEfCqGGVbwJrf?=
 =?Windows-1252?Q?yv2FzS4KFzRQD4zKSlbZFiGXYyNiP+wMZJd3rny5rWluLj4ksIUlJdbX?=
 =?Windows-1252?Q?lJ1ZjGqkYo9cwVdHoI2/shQ82gKxt65VATD6mKbsYQoEd1G7VgFYMz4p?=
 =?Windows-1252?Q?eN2gSoQzdY+AmpJtP5fcoM/sxRarbQ6wyfS2mCoCme4XRGmlz2QCEPwk?=
 =?Windows-1252?Q?5+iGUOntuhbN99Jq1dHyLfgp63CIV0py5o0o5VJcUEzdkdyXVVGjjpzp?=
 =?Windows-1252?Q?YJ4OMvImD6hxsxDbXSTk/88BnOGf1mGn/qwSDIyFoN3IhfHkzABXZmBk?=
 =?Windows-1252?Q?/AcFyh9fY9yn4kN33Kfb9x1nYgScRptfzkUbl/8pwOcAZx7zVhIN6KYZ?=
 =?Windows-1252?Q?DGxY0xTWYwdzvyo0WOkEaolweow33ul1jjPNPlLcimiOcz4ClW2Ns+Xl?=
 =?Windows-1252?Q?Av47YrN5nxuhfBdlfue+s7WPJYpadGmIy3tGFP2ENmEXlHrLJzyVvGNC?=
 =?Windows-1252?Q?MEQBAnw+T0rL2bJGM9QjNUUZ+tDhD5qMqzI9fHBGcgfAS+K5d1oNQZfs?=
 =?Windows-1252?Q?umD0R+kmKAEScFnsj/IKYyQwc5uCzHYZBr9rFhCyQMhPFmwdEBg1/N7i?=
 =?Windows-1252?Q?3KoiuhFXKOeExXnqblfvAhcpq7/P42ze1u0BE4HTgzl+ljosRPwaM4fm?=
 =?Windows-1252?Q?fjN1X8MosKsMSPMyD8s5ZJK7pn2TVJ7iWnRkTyA+5E6NkzgklwT582nV?=
 =?Windows-1252?Q?WHS7jHtQKm+/x6hqHN6LBOat+y/79BAd16taVuAI9z4vfNQi71nR+JT4?=
 =?Windows-1252?Q?MhU3RhVhZ5f/hfiZnFBq7lI/QqLeC8BXLuGjJWv65jFhAvNb1JiKHY03?=
 =?Windows-1252?Q?Wy7uJiUvI8fw0ANnuLePl2+3/LDXmZ7NJiLyM4g3fx+BMKxBESNrRTGJ?=
 =?Windows-1252?Q?hIiHtotBmcTfVE9ovLmoLlR9/1E+ojnIcj06uEIFmmF3mri3OdRvVTm6?=
 =?Windows-1252?Q?3WQp9IbiuRUhwF9+hvjp4WvECUZGMeqIzE+LQXawtxtvJ+l+hGoCZ1Ub?=
 =?Windows-1252?Q?9TNC5xoiaD4NOQKPrwU1jvF9kwsH8IWaLrFx8g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?CNzkYqUoJEvA/ZX8M5cWM7BAgwDsuTx7Ge/YJEbupG34lggXDZCtMqqH?=
 =?Windows-1252?Q?LJr+bJRdeTtBmttSK7JJA9+TiAB3Fs73johwEYZ+Ou9hLcYzdSU9wkRj?=
 =?Windows-1252?Q?yuQuCATUGmUjDkA7BwpEk8FZs7YGXDk1fe6j1ezn3WbhZH/ObR6mhj4+?=
 =?Windows-1252?Q?lf3cDvEwVOK1dwTpSY+VwY7A0lNuvfA/rZJVvXcbbZh6b42yw/2U/mP+?=
 =?Windows-1252?Q?+1XzhU9kpzOZHOE8lJglrhyP3oQmnvvFnlJOxXL63SBMNFghMxFAtyaM?=
 =?Windows-1252?Q?X5stUlcnV3T5ydb0cjDGF9YsX7iJGACORCff9H4Y4NeUXZrolUghOzGb?=
 =?Windows-1252?Q?weFnVLyITnUneLvh5Oq22NOX/pGKriEcTbH5XJo389NCuq4ZR7vGgs2p?=
 =?Windows-1252?Q?rtPC9KQGCvdLXF1hLpaHv13vg94ROvt2Hu2L2mcMU4RUywiP88AkeDyB?=
 =?Windows-1252?Q?VrPwKJCckptn+Tvy5J33iwR+8Dg6/A422KcQvrKTJvCfu/89U03KPYyt?=
 =?Windows-1252?Q?93lcIZrYT4BYQZehKV/xeF3Wuq7DP+vuBb3vMEtrPums/avKRlBj9IsT?=
 =?Windows-1252?Q?FdEDImdK9U9zhmRJg38P6/lrqIiKCoXaOQHKqe6KxowDUAJuobBckU49?=
 =?Windows-1252?Q?xB1JoSiyNYNZNSC35lwf7D2YFVj2+1QSC9yTs0Ak7LFy8sOF85203DuQ?=
 =?Windows-1252?Q?ytswimC1JATqql710JD+f4tr8qo1nhKhqUrSPIXvL7bthNbbh/HuqlK+?=
 =?Windows-1252?Q?UaCN+eCLNiAoD19ADfqgqzff4Msfxte+96M5a/jRA9HHwUKddqhgFnpQ?=
 =?Windows-1252?Q?FCGV9dtET/trdjsvS5WF0ZbRqraB/Msn+vfaOB7YMxLV2qUfqxAfB7Ez?=
 =?Windows-1252?Q?tt77JzRWnD8LQ2ULjkOsAQ8eFthnRgXWGEpqkgmt4xk4lYiAEr9rcnL0?=
 =?Windows-1252?Q?ssHG8jwpiWwzrGiRGjjMldCxVuF2anUkOH9u7eudhjyGQ1YlJD2HPh0T?=
 =?Windows-1252?Q?5ryAmmikM6XaLWVLhEWIORjaCYRcoGjmgbDxYZy+ps6iumYVjCk+2i5U?=
 =?Windows-1252?Q?ICqiZ9P3AAF2UjicZheB/c9Mp4pleoaC8m8sq7F89oqvEbsM35Oz0JA/?=
 =?Windows-1252?Q?UOIum8gjs+6mSD0Xy1IdjmwXIwhw4qdua0FT1lfIu96FD3QwXfvbj0wy?=
 =?Windows-1252?Q?1BR8dTL81RudXC0hAq2eSBTrPgZJdcYr5/o69TeD3K7fMb/Ik5uQYbAi?=
 =?Windows-1252?Q?vNhUPpxT6roIWIPNTjdk8aS/LvhetpsyE9UPgnrUc2k1BM1zi+M3ExT4?=
 =?Windows-1252?Q?jN6ISzrNZY1G62jX6TcDpGdMUwJD7Fjo++jV2lYSfefX1cxFrIgqs7P4?=
 =?Windows-1252?Q?ogtvV+UD75IH3EvBgMU5P+3D/ZtxZBarNrImZI/8uFzvSH2AJRuNmpsv?=
 =?Windows-1252?Q?kR9xx6raUCWECOz72vVH1VW2l1xP4izhBQjOuujk43rWoBqzgq8CH9mR?=
 =?Windows-1252?Q?pYXSZ4jO8ZA9iWSdo9xFhFgA47h9hZlqWRq7KGKywd/0rPhb9t1o3uhc?=
 =?Windows-1252?Q?Z2PVXD7g79lFj6YYlRkk2utwlulRvwNridUu6FLzPumFRdvAVUDX/xnm?=
 =?Windows-1252?Q?w/ViWpndnEtay/w27AkcyCjSm1V4IAab9fcBLU9dUf3pmISy0XBHpHHm?=
 =?Windows-1252?Q?oZtfcS9qxGI=3D?=
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c1f2a9-331c-4f01-30ef-08ddd5cee5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 16:24:35.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHTn9/xVTGtE9XvmRgS8YHqKOcPQOD5qzGFTieCIJqULXpIsH7+U2dwnuFgAgSihStDANBTMHVUnwy+RP5CrdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5173
X-Proofpoint-GUID: ywIvbH8GcTowMJ49ydYbfJPxPTJOAeI7
X-Proofpoint-ORIG-GUID: QxnJSCoC3pVzqObRliZ9j_migZxRTR1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzMyBTYWx0ZWRfX+V7ys1lIvRuk
 p3L79dZFjSBM033oN04bz/Sn9zieLhtLtQ8h1egyqLpUVK9xhhNttbJtaNEPiG0IDn0BPaDEAuf
 nhydjtEnLpX7lY0IL30KZUHbRGcVOUgKomOEcfZLPXECSihSfdZJU6JD1lE9rTQK5TUTeQHfJom
 TnwUlGZ5tm1wwrt0XeSoBeh65ow/9pHZUol4Bq+yChG+xS5ebX9kxdwSRSO0kUZz8vhH8bBIj2S
 bs/OQ5l8s5lPXn4Z/VmFfBquI0RfqGo0DIuvsOPlain/L+7RsdUzCUa2tjF1aiZxF0UZBOZ+zLO
 OK+heg/u5U1SIdmmE84PPTJ7PtBmEkDd56jr4tGuE/6aYAl8wR/umdJIrqRPH6lckoEAV/3VgLN
 6Pu3BIDTbpOAVpOvVEMY/6Trx+BUy03FYeD6JuiWCgLShzB/LZ2Veh4/hIbYDy+MhkMDtX7i
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=6894d346 cx=c_pps
 a=IacuwKDKzXDKEBxwMeC/+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=wTSae9ZTrx7r8reO:21 a=xqWC_Br6kY4A:10
 a=N659UExz7-8A:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=_mpddBh3Pyg1y56bIn0A:9
 a=pILNOxqGKmIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
Subject: RE: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070133

=0A=
=0A=
=0A=
________________________________________=0A=
From: Hangbin Liu <liuhangbin@gmail.com>=0A=
Sent: Wednesday, August 6, 2025 9:38 PM=0A=
To: David Wilder=0A=
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; =
Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_targ=
et format to allow for a list of vlan tags.=0A=
=0A=
Hi Hangbin=0A=
=0A=
> Hi David,=0A=
> On Tue, Jul 01, 2025 at 07:13:06AM +0000, Hangbin Liu wrote:=0A=
> > From: Hangbin Liu <liuhangbin@gmail.com>=0A=
> > Sent: Monday, June 30, 2025 3:18 AM=0A=
> > To: David Wilder=0A=
> > Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.c=
om; Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbi=
n Liu=0A=
> > Subject: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_=
target format to allow for a list of vlan tags.=0A=
> >=0A=
> > > On Fri, Jun 27, 2025 at 01:17:13PM -0700, David Wilder wrote:=0A=
> > > I have run into issues with the ns_ip6_target feature.  I am unable t=
o get=0A=
> > > the existing code to function with vlans. Therefor I am unable to sup=
port=0A=
> > > A this change for ns_ip6_target.=0A=
> >=0A=
> > > Any reason why this is incompatible with ns_ip6_target?=0A=
> >=0A=
> > Hi Hangbin=0A=
> >=0A=
> > I am unable to get the existing ns_ip6_target code to function when the=
 target=0A=
> > is in a vlan. If the existing code is not working with vlans it makes n=
o=0A=
> > sense to specify the vlan tags.=0A=
> >=0A=
> > This is what I think is happening:=0A=
> >=0A=
> > In ns_send_all() we have this bit of code:=0A=
> >=0A=
> > dst =3D ip6_route_output(dev_net(bond->dev), NULL, &fl6);=0A=
> > if (dst->error) {=0A=
> >         dst_release(dst);=0A=
> >         /* there's no route to target - try to send arp=0A=
> >          * probe to generate any traffic (arp_validate=3D0)=0A=
> >          */=0A=
> >         if (bond->params.arp_validate)=0A=
> >                bond_ns_send(slave, &targets[i], &in6addr_any, tags);=0A=
> >                <.......>=0A=
> >                continue;=0A=
> > }=0A=
> >=0A=
> > ip6_route_output() is returning an error as there is no neighbor entry =
for=0A=
> > the target. A ns is then sent with no vlan header. I found that the=0A=
> > multicast ns (with no vlan header) is not passed to the vlan siblings=
=0A=
> > with the target address so no reply is sent.=0A=
> >=0A=
> > The ipv4 code is simmiler but the arp is sent as a brodcast. The broadc=
ast arp=0A=
> > will be propagated to the vlan sibling (in the linux vlan code).=0A=
> >=0A=
> > This could be a testing issue,  I am unsure.  Can you help with=0A=
> > a test case with the target in a vlan?=0A=
=0A=
> I looked into this recently, and you are right =97 ip6_route_output() ret=
urns=0A=
> an error dst. The root cause is that we cannot get the destination IPv6=
=0A=
> address through the bond interface, because the source IPv6 address is=0A=
> configured on other interfaces, the VLAN sub-interface.=0A=
>=0A=
> This is a key difference between IPv6 and IPv4:=0A=
> In IPv4, it's possible to get a destination route via the bond even when =
the=0A=
> source IP is configured on a different interface. But in IPv6, the routin=
g=0A=
> mechanism is stricter in requiring the source address to be valid on the=
=0A=
> outgoing interface.=0A=
>=0A=
> I'm not sure how to fix this yet, as it's fundamentally tied to how IPv6=
=0A=
> routing behaves.=0A=
=0A=
I am thinking that we don't need to do a route lookup as if we are sending=
=0A=
from the bonding interface.  We only need to find the interface we should=
=0A=
send the packet through.  As if we ran "ip route get <dest addr>".=0A=
=0A=
David Wilder=0A=

