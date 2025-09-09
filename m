Return-Path: <netdev+bounces-221449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CDB50867
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284481BC3159
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9722627EC;
	Tue,  9 Sep 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQwt2Wmz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EA253F05
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455068; cv=fail; b=av5u338EebRqUnVB7j4gL1wqqu1mVnw9/7zr95FcIZ7eUsnzihG00VRYhA/NLJhv5GuorJbcPiNcEREPUwU5q7lSmEvx7to2BpiTCTd7bAyIldgLFAMZ5d+qGGFN8zy/1FatZAGrAXMBWekgh71R5TBQfro3HM1RvhaXTLLRFsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455068; c=relaxed/simple;
	bh=Kf1hNMA8zI+K4Pt6tIUrST9TcpKWpdqT2s6yvSTqwRw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=D9GvBLHpdmdXXBGUUV3gSRJAl2PwgWJ4cQoUU8a4GD6zLvANU9+FP4VeG65YSTBhYjEBSM+YO6w39BU5HYEwDxhhymCLaxMU+XD0vvHfinNnvscuPMK9AgLE2lh7NzYn4eXURhJlEn8XHnj2g8ZsouOGXXGu1wqX3YMz6wTI+6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQwt2Wmz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Fgkdt012159;
	Tue, 9 Sep 2025 21:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JmmY8H
	mgV51uyJcbQTNOhD30s/hGWbHnzJYfbOiP870=; b=lQwt2WmzMGCKdPNKmwoV0v
	gjKEhZFDNAPUcLjNBc3w9MCvCBTb7wxWpvrKltNvKsH3NjRr9mRWvIdUw11l0NNA
	NMwbNXTX3nq3jY8wudZcvzQXQM5i7Fh5B6pCYcUCoSL1gasnvFkK8oPkF0pBF4wG
	LWqjVMElpPOKFCxhU8N+Fw3vtQY+9xttQEyKtd+dKRsoerSweuF7sXrrCPaMrPVY
	cCAA8jfz3eKFnBEQSl8ADhLvM3XoBIZVJSiEH3Cy2eZIF/yMzoPXTjtvKnFtfEM+
	19fO4y7nWDNyrCFKuicYL8fvha756f9OP2aKloFo4vDVxjZfhdjdClHaGGy6dxmQ
	==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycyc7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 21:57:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6u69LNrJnGiFxTISrlE24x9ap3SazXwbfvSWpcTnO41FkfhK3cYDyryXKctIWgvt9St8dzrCtgGLpD4ia9Ih0PkB3eIdt5yda1v/Er4ly3sgIgNLs+n7luXJG2YGww1rsAaWyrOu0oMcp3OmHfdlQfA+eWuXCIO/dMqMlb96ZN0FvPX/R1y1GOMr1cLTVBDBEon/dCZ1ofTaveIEf9EBHPeriA+cHUtotftbm/PrGxpu8j7o2dBfPQ2oZbdqP5hYwyqH+EZEsIJWmq4g/EevsuwfmiXU8G/7Y40EVje0dbC+w3VCJectlr9l8AQLU48z8+lHWH2BBwM90hU+g+mYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmmY8HmgV51uyJcbQTNOhD30s/hGWbHnzJYfbOiP870=;
 b=d+JYCMeFv2AqFaeyvcTd+2MYnOnDWXT005Q6KiTwEdYjHuTEa1EESgC6zZcX0N4T6KW4urKZ4vYzou/6UoU5okqSK/Arv0X5N+r9Li/h0e13ZgD2kEae5U19vyPDxtWx2yYoSSbUkrLWxHT0PISQd1Y34yj2JxhzEeMJfhCBHnwTAmpCL0tjDSL3Wb+c6yX1Z1kHDq0xrNAFLsiXJNAWfTvIhsrLhJPjoRyDHzLjHRdn3NLVS/ec/Q8w/argcoi49NYP9EWS4iNfyM8J8lGbbvhJH/8GVG/LBx2qSOFi6J/sdgZfgrnH5dBcBj7B0S4BBzVB3zA2IA6Mo6NU6JN8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by BL1PPF69EB7281D.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 21:57:24 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 21:57:24 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jay Vosburgh <jv@jvosburgh.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "horms@kernel.org"
	<horms@kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v10 5/7] bonding: Update to
 bond_arp_send_all() to use supplied vlan tags
Thread-Index: AQHcHeoTd/w3FJfDVUK7Sfp8Rl7C8bSLOtGAgAAhGQCAAAQlAIAAAbns
Date: Tue, 9 Sep 2025 21:57:24 +0000
Message-ID:
 <MW3PR15MB3913ABFC23FA77CD46B61A4AFA0FA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-6-wilder@us.ibm.com>
 <2c0f972a-2393-4554-a76b-3ac425fed42b@blackwall.org>
 <2921170.1757451242@famine> <2921828.1757452132@famine>
In-Reply-To: <2921828.1757452132@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|BL1PPF69EB7281D:EE_
x-ms-office365-filtering-correlation-id: 4cfd8d7d-ff7d-4650-3796-08ddefebdc2a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ChVueoDkKBx2k4L7m0vN8IpbMUEBxMXHYYOz2tjRInEapyn2i7VATEFjX/?=
 =?iso-8859-1?Q?3B2CavbULVg+U9UWRVJQcgoB2TlJZq1N4EDwgZhNsXKom8A86RIMfYlyrl?=
 =?iso-8859-1?Q?Dr8X1qvupNE4KSDDdgirL2Er5048n74nVSQcJGF1IjrTApPefkVC+S0hCw?=
 =?iso-8859-1?Q?VKXN7PFDPAfbKEoxwVGPQ90oMza+JtuM4s31oLVGRqILOYKG4AO8GunlwK?=
 =?iso-8859-1?Q?4hHQcXw6tZIeWS4QUvfMO0UMdEBAd72hXHKTDgHiP4gKASdddzjpU2N9qz?=
 =?iso-8859-1?Q?V6Rgl6gD/4xDxvWCmIxM1Sz+YIPR3shuZclTLDuh/hHnhHYhF2JRAIT3Fz?=
 =?iso-8859-1?Q?Qe6CtdO16d8RzcpA4fnknrbV0vOkeFK4NXs5kj15dbV2SU/nd7wy8E/XEV?=
 =?iso-8859-1?Q?MvrmheJmFJSyrWPd+D81b4eCTCWq6TDct+/cJ97rEZTc85KzrF7xWe+xFG?=
 =?iso-8859-1?Q?Y5Rea3RSncGlnWwTCxO/tmBzMAJlQM8Hbigo06unHG2sFitMTXjw1V/BLY?=
 =?iso-8859-1?Q?M3oqUjEIlFpqL6B1O0svfgMwhT0di4ah+YAHPoSbO9p1BU9/1QI2ayl9mm?=
 =?iso-8859-1?Q?uNiCW3Lx12ZhvxSqE8IIByCCDCBme4TaKcrezWjM1Qn0mfw5StntIRrcvf?=
 =?iso-8859-1?Q?8UOWT2nKDL1zx8hFxJ7MnEZGG7c/LI6QpZiM6fDY/Usxy81RvKkob3SKFJ?=
 =?iso-8859-1?Q?AbDMttRT7qGflpUvRN6oMybPKWDLUwAuPoF29i2PLzsOJG0tjU4I8zLTsi?=
 =?iso-8859-1?Q?ZFXx6T2ojE9L5nxfWs3jcAu11g3FEqkxNaJ6xPf5WDNUwvn35r7nwEgVd/?=
 =?iso-8859-1?Q?QJVzgySf5PqycCuury15pnlbOcs7zQbSB+NVVpRy1Ya33mAc6A/LNAxhXI?=
 =?iso-8859-1?Q?YGfngt38Yoq5t20ZDuuItDhlba23uxm48BOQ5iDHU9h4PvxdkJJmm9YqOc?=
 =?iso-8859-1?Q?ZXOFXNkiB36XydRwDfEcGgk1aSJItVNudvpdz1Ra5ZANnf7aG4oATUNRmp?=
 =?iso-8859-1?Q?4SaofGzTKGQvAuRHUIqOdFvB/hHczQIv+fQWDAsXjEsuf4npylBlgX31qo?=
 =?iso-8859-1?Q?LVjhfaNUCZz7Lf06bEuMFP0UGoPyI2hoWxqa2f0mCQ8IbFubD7cml3mJO0?=
 =?iso-8859-1?Q?Scq13UrBv3b6od6UzJUhwyJMbNl71S7AEf1oRPAjUi15P50dlCKlHZrKDi?=
 =?iso-8859-1?Q?J/SMAgk63nBBKzz7jInRlLmxIdIJ+6odtbppFj4NZX9LkayDVQe3pn8aHM?=
 =?iso-8859-1?Q?i2Qu/H7fGDNxzF8lIEbfRmakubhK/+cFPEDC6szMIGasxXWCScMNTIQenA?=
 =?iso-8859-1?Q?OnZFrzvAtscmDysWPkP7o9xBxiiGOZDM2dNDkgcRwfvA+R/1CGhu+oz0PI?=
 =?iso-8859-1?Q?kMcaK+D0FvuunX6cuw/vH9+WVAep4zI339jvSDzJYbljEGk9gh1LEpqyjq?=
 =?iso-8859-1?Q?0tB9PS19A03ZYdj+exPTIorpUC+TSOOfWBEjBjlcXv9fgxw1tTtQCcbMmL?=
 =?iso-8859-1?Q?Rwx1ijxyqWFehpKfMCcAyam8CLVSyOWzGHzaJjgPBpqw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NjoqSKrD7hLKzW7Dcln0k4+GwlqQL3Pwzr0TVgpl1sFt+S8Mb4teslWTky?=
 =?iso-8859-1?Q?l7gQBNPElYLKl2sYBtq341MpNde7HuPY9xqcZm+Sl12Bhw8n/izAnRfRTE?=
 =?iso-8859-1?Q?RQKL1BhNgyrkoG6Q/vwoX7Zlg8v9Putdyd2f/KCtPOpvlwpFcRfNYiQ+Td?=
 =?iso-8859-1?Q?BT4mtVjlIaNdMKFbFD2OurogOglvtzyEpv+jSzU+efNB+fTsk6G/TI4kl7?=
 =?iso-8859-1?Q?FUsA+UQ4REKq+a+1akqERWDHkF5lI6BSqKlyGjeury2WEIJBuvyOc1UUz8?=
 =?iso-8859-1?Q?dfD/An6c2epeOSJDgJMuoebh8uL6XzJ3uFO7e4Ol1n2nASSDBX4w0pR6z3?=
 =?iso-8859-1?Q?4eOn0wuu5c5XsBqQN5U/XTNl44Yq+PF2wl7/kXkw92sq6RCZl6t46b9X7R?=
 =?iso-8859-1?Q?CxqASVhphj9Vc61HpEPhnj87LuNmDAXgsrql+r/UpDclePXg1kjtOPly/Q?=
 =?iso-8859-1?Q?MwdY0ZFArBmMKDFR7XnZo8yX+1hjPAa/7nxf0/VVCPlafE00urZbnU854h?=
 =?iso-8859-1?Q?Haja0IKYJrYTArfdquSkpYhCova/o2RDnaxukmCDfmw/oVUOnFZcCn4Q4t?=
 =?iso-8859-1?Q?c83u4LGmgzgtHFBnsO7Fun/5b/pPVL7tkQYyFT+mwYuRt3TOuMCmA+5+L2?=
 =?iso-8859-1?Q?rIF0Sgd7sN8MT9pNdf2mVOB3fCD/f+zovZjv0/hrGNdhK9qEL0xlojGM/I?=
 =?iso-8859-1?Q?EpuMmhZiS8Sm+PuDgbB/AwyebWn1bCgaKfCV/qiVwZXwF84wtNcdu1vATA?=
 =?iso-8859-1?Q?+jp1f1SGY++E69nhRdKK2+dNbIFSCQliy2+j8P7MHcWlk4hTGvsfOhcfET?=
 =?iso-8859-1?Q?lFKXKE5QOlveQUnydeuKYpGfs2qH2ardpLPrOUplMTEIVlrQs2pHzvPIWv?=
 =?iso-8859-1?Q?d4WT31eF4nPUGYgA4iHlqVRymAZqRZ59gqZtllaE8HVQlcBuY+kaLFpROs?=
 =?iso-8859-1?Q?grJZ5xkIdg2wS2QxF/MM4EPVBCqx81yvfYX9iAytvOzpH0m4ojii7Vk9FD?=
 =?iso-8859-1?Q?rEl6wZwxfH6u+WHF6SE4YMxvCeigHrgReYILo0h0U2HNQ78vq4LwmSKyEh?=
 =?iso-8859-1?Q?eL0nt/k8Scxpi3kDYaSfT2xTZi4au2xmiuPpwWycM3hhbW0M7mmDHxz/OH?=
 =?iso-8859-1?Q?o9OJOgxLKzbag1t000EZur6Bj2FgtSintxyyFsn7bJmKwHTh0aHUsdhVpl?=
 =?iso-8859-1?Q?iLa2cMcvagBcmrrdo2q++vkVe5u0zm5P5iS+uG4J5Tec9N+OqAc7BJjzK4?=
 =?iso-8859-1?Q?gpxFw7wfp5Vp2wuktn4EyHxvN70JQ3TFVj6nr1N7x5MV0Id46KjCERWaGp?=
 =?iso-8859-1?Q?a5bxtq5Ea1Z7tL9V79kYeVjB//mUWdfNZSrEEOBky9egfml6lx0eyoRpDp?=
 =?iso-8859-1?Q?BXsi6OyPxZ6J8745A8t5L1986tCiXoDod7/LFB7BUXuarLHw6QM8SjCouh?=
 =?iso-8859-1?Q?qbStmntDoIWmaoF9EKNan0ndNuEQVqgdkISU16a8cuLD1tr61z013ST2UT?=
 =?iso-8859-1?Q?ta60u6hRZ6P/fvkZhnj1elwr0+YnQXLr7enrJuUFauryGtGkcmBy1hatKT?=
 =?iso-8859-1?Q?298jN6iOtoCRY+8Qdz7/po6duN75J6wywP6+HpXMgeTypLofi0qy5+RDRZ?=
 =?iso-8859-1?Q?84ODSwnFnqNve37CHt+OSkKdVW1HBq+nBVmVA/Vbmly9sH3LPQvHZ2zRGK?=
 =?iso-8859-1?Q?Yc1cxfTyN+j87+6wp44=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfd8d7d-ff7d-4650-3796-08ddefebdc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 21:57:24.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uttCm5kwZ9DOIxja0aqXpXq/57muFb/KUyzJOD8m99vMqlJABKGzbRfWtTHbpPY2k2foRLzaL8yelMCDAJNFhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF69EB7281D
X-Proofpoint-ORIG-GUID: 296vNl-ZBx0dSlpYyx9kP322U_x_s96v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX7L248NboNT2E
 VAqxAvyId9ZGQ83v4djKF03JdQ9bppOc7EfnmhGIvVRFxKcw5+ePaMMBP+g6Z3R8AwGoG2EOcOv
 RG1PMXK11O6B1IeUadmcLpXfPLmaI7Onh4vpU5CdUkwuwTYmoGrbsB1OBwLqxrFabElScgKVe4L
 W03q7fVY2c34iIyz+gwbvngzUl3vBF+weMd6hP7I5S6CP6bX/xeW73ujaJXj786MUXlfn/tyKnR
 K+iP5x7Z4uS6dJuPYQ/dkUPul57nDMdA8aFYAZcvANuDvNYLv0a53JeLGIAPjxwM7jJTDFaz8TD
 PKVoVqmfoyFeJZtDcbxSUUOqgTdz3e1cd/uzmr2Qx66zuDqsuwUbR5aCSrAHjpjT2vytocIlRtG
 h/YXWQ7c
X-Proofpoint-GUID: 296vNl-ZBx0dSlpYyx9kP322U_x_s96v
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c0a2c7 cx=c_pps
 a=YI3xlNmR6zTlXLRhjlhBkQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=br0wEIb2B_8_S_Ky:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=2OjVGFKQAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=vr0dFHqqAAAA:8
 a=-mu6OIGoLKCnK-Nqn0sA:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22
 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=P4ufCv4SAa-DfooDzxyN:22
Subject: RE: [PATCH net-next v10 5/7] bonding: Update to bond_arp_send_all()
 to use supplied vlan tags
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

=0A=
=0A=
=0A=
________________________________________=0A=
From: Jay Vosburgh <jv@jvosburgh.net>=0A=
Sent: Tuesday, September 9, 2025 2:08 PM=0A=
To: netdev@vger.kernel.org=0A=
Cc: Nikolay Aleksandrov; David Wilder; pradeeps@linux.vnet.ibm.com; Pradeep=
 Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; step=
hen@networkplumber.org; horms@kernel.org=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v10 5/7] bonding: Update to bond_ar=
p_send_all() to use supplied vlan tags=0A=
=0A=
>Jay Vosburgh <jv@jvosburgh.net> wrote:=0A=
>=0A=
>>Nikolay Aleksandrov <razor@blackwall.org> wrote:=0A=
>>=0A=
>>>On 9/5/25 01:18, David Wilder wrote:=0A=
>>>> bond_arp_send_all() will pass the vlan tags supplied by=0A=
>>>> the user to bond_arp_send(). If vlan tags have not been=0A=
>>>> supplied the vlans in the path to the target will be=0A=
>>>> discovered by bond_verify_device_path(). The discovered=0A=
>>>> vlan tags are then saved to be used on future calls to=0A=
>>>> bond_arp_send().=0A=
>>>> bond_uninit() is also updated to free vlan tags when a=0A=
>>>> bond is destroyed.=0A=
>>>> Signed-off-by: David Wilder <wilder@us.ibm.com>=0A=
>>>> ---=0A=
>>>>   drivers/net/bonding/bond_main.c | 22 +++++++++++++---------=0A=
>>>>   1 file changed, 13 insertions(+), 9 deletions(-)=0A=
>>>> diff --git a/drivers/net/bonding/bond_main.c=0A=
>>>> b/drivers/net/bonding/bond_main.c=0A=
>>>> index 7548119ca0f3..7288f8a5f1a5 100644=0A=
>>>> --- a/drivers/net/bonding/bond_main.c=0A=
>>>> +++ b/drivers/net/bonding/bond_main.c=0A=
>>>> @@ -3063,18 +3063,19 @@ struct bond_vlan_tag *bond_verify_device_path(=
struct net_device *start_dev,=0A=
>>>>     static void bond_arp_send_all(struct bonding *bond, struct slave=
=0A=
>>>> *slave)=0A=
>>>>   {=0A=
>>>> -   struct rtable *rt;=0A=
>>>> -   struct bond_vlan_tag *tags;=0A=
>>>>     struct bond_arp_target *targets =3D bond->params.arp_targets;=0A=
>>>> +   char pbuf[BOND_OPTION_STRING_MAX_SIZE];=0A=
>>>> +   struct bond_vlan_tag *tags;=0A=
>>>>     __be32 target_ip, addr;=0A=
>>>> +   struct rtable *rt;=0A=
>>>>     int i;=0A=
>>>>             for (i =3D 0; i < BOND_MAX_ARP_TARGETS && targets[i].targe=
t_ip; i++)=0A=
>>>> {=0A=
>>>>             target_ip =3D targets[i].target_ip;=0A=
>>>>             tags =3D targets[i].tags;=0A=
>>>>   -         slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",=0A=
>>>> -                     __func__, &target_ip);=0A=
>>>> +           slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func=
__,=0A=
>>>> +                     bond_arp_target_to_string(&targets[i], pbuf, siz=
eof(pbuf)));=0A=
>>>>                     /* Find out through which dev should the packet go=
 */=0A=
>>>>             rt =3D ip_route_output(dev_net(bond->dev), target_ip, 0, 0=
, 0,=0A=
>>>> @@ -3096,9 +3097,13 @@ static void bond_arp_send_all(struct bonding *b=
ond, struct slave *slave)=0A=
>>>>             if (rt->dst.dev =3D=3D bond->dev)=0A=
>>>>                     goto found;=0A=
>>>>   -         rcu_read_lock();=0A=
>>>> -           tags =3D bond_verify_device_path(bond->dev, rt->dst.dev, 0=
);=0A=
>>>> -           rcu_read_unlock();=0A=
>>>> +           if (!tags) {=0A=
>>>> +                   rcu_read_lock();=0A=
>>>> +                   tags =3D bond_verify_device_path(bond->dev, rt->ds=
t.dev, 0);=0A=
>>>> +                   /* cache the tags */=0A=
>>>> +                   targets[i].tags =3D tags;=0A=
>>>> +                   rcu_read_unlock();=0A=
>>>=0A=
>>>Surely you must be joking. You cannot overwrite the tags pointer without=
 any synchronization.=0A=
>>=0A=
>>       Agreed, I think this will race with at least bond_fill_info,=0A=
>>_bond_options_arp_ip_target_set, and bond_option_arp_ip_target_rem.=0A=
>>=0A=
>>       Also, pretending for the moment that the above isn't an issue,=0A=
>>does this cache handle changes in real time?  I.e., if the VLAN above=0A=
>>the bond is replumbed without dismantling the bond, will the above=0A=
>>notice and do the right thing?=0A=
>>=0A=
>>       The current code checks the device path on every call, and I=0A=
>>don't see how it's feasible to skip that.=0A=
>=0A=
>        Ok, thinking this through a little more... the point of the=0A=
>patch set is to permit the user to supply the tags via option setting=0A=
>for cases that bond_verify_device_path can't figure things out.  So the=0A=
>tags stashed as part of the bond (i.e., provided as option settings from=
=0A=
>user space) should only be changable from user space.=0A=
>=0A=
>        So, I think the way it'll have to work is, if user space=0A=
>provided tags then use them, otherwise call bond_verify_device_path and=0A=
>use whatever it says, but throw that away after each pass.=0A=
=0A=
Agreed. Sounds like caching the dynamic tags was a bad idea.  I did not ima=
gine the=0A=
vlan to a path could change, if that is a concern then simply removing=0A=
the caching of the tags (and freeing any non-user supplied tags later) rest=
ores=0A=
the original behavior.=0A=
=0A=
-                  /* cache the tags */=0A=
-                   targets[i].tags =3D tags;=0A=
=0A=
=0A=
>=0A=
>        If user space provided tags and then replumbs things, then it'll=
=0A=
>be on user space to update the tags, as the option is essentially=0A=
>overriding the automatic lookup provided by bond_verify_device_path.=0A=
>=0A=
>        If the tags stashed in the bond configuration can only be=0A=
>changed via user space option settings, I think that can be done safely=0A=
>in an RCU manner (as netlink always operates with RTNL held, if memory=0A=
>serves).=0A=
=0A=
Agreed, I was depending the existing RTNL lock to protect configurations=0A=
changes from the user space.=0A=
>=0A=
>        -J=0A=
=0A=
-David Wilder=

