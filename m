Return-Path: <netdev+bounces-212257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8DBB1EDD5
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B93C3AE26E
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8513B5AE;
	Fri,  8 Aug 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LAO4uazH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938FD528
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674335; cv=fail; b=NmhfAMv/YAIRDoxicj/bAIm7OcSUFkChASglcSir37WSgeRu2pQIcN1Ad6YQ86gO4NSE09WQciKZJen1I54GL2k/5krk/cwRHNempjZ90NuNoJHVNBpMpyHLE2gmoijZboBbtdWwLk2IaXRN1bAUwUE2tWVqIrOlHAcvVP4DQ7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674335; c=relaxed/simple;
	bh=ICAeSNngCQ+wyEpPSXXHw91fbugujZz77wOFaWhk0Uo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=PR1nbiD/vXdvNTwbPgN1q6b0X8pC57sQafSdIJW5ocmf5hGg5JdfPYTubtOLgQEkrqtxZVpA8O0huRvRzy5Mr7A8vREVXiNvwsLfkNKPbpHpEXhvZciMd4jPqNGUUdjbLYIKj7D0EpBww0pSeCyNTDRWk7MJPNquYpB9E+r6OAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LAO4uazH; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578BrbEI028661
	for <netdev@vger.kernel.org>; Fri, 8 Aug 2025 17:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XwdcVN
	TchZXdpQ6jO8N6OCA9ZyL694gi1vixpTislz4=; b=LAO4uazH1j0SESERd8yNIP
	gnmQbsbRxVV8nphHROd2oCvjX6SbJPpFWM17zrpDZqW8MvEBNBBbygsY3TzCtNl2
	I9ywNfeVfMxZapvOhp1CCoMd80bV6ZIVsnNYpmltRRKWJUfJKY1ifqeN15QUHQF+
	bB+dcLkkTRujqBjUxG63AW/ZidTakmivL0pNdZnhsEQT/Hgyc0NCZXmtHwSV8G5f
	KRL7uYrqxIqhC5NqTv9v+64ltyFX3ISVbJO+StLLe426gxVYAiSWNcDQuCnnFj2i
	pBN4h520sRANNCE9K1vm/wz9hg1Vk1LwPd+TQFA8+MTmh8EeIiVMRYE2EGvJfx+w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq619x7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 17:32:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578HP7fo025194
	for <netdev@vger.kernel.org>; Fri, 8 Aug 2025 17:32:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq619x70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 17:32:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPmmBORGCftiFXeoUgYsBZ2SPQVrXh25nbHAbNrSrQSQP3F+p6zphvWXHP2BiLj8ZSZ4r8tZM/UvgOUddvrG4Zw6ngjcSetoNoa53cewCoKSzwmp3/ScWn6abJr647gNpOfCmGh+nIJS+VOst7QLcoohrys+YbhmrKjh9xZgk8DC4QdSIKeAA4cNtjnAAVXK4BABbTxioUtODRplcoC2jvLvW7bo6VMEhFWlhIShuCwX6u4ueMMR6sEGs8ft3ic9ct6YqDhPrUxktGLPHo52g6io2+1ikByIQ4b/1xonF1KYp4IHtBfmOvk23t9Oc3A7xfyy2tQiuJO0AJ4XDpR2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy5meB2pb9xqz4Dtz/denJ3eLymBQvqjUsJtJjeJnJE=;
 b=DBVW0KnZes8EeNHOr8usuVg2it80k3354YL0TG+rP48JxiGSEM+gS9t0dm3THyVyyI/Tcdjiqfp9G6ITqYpSK95dd1/FGJMTwTIG4H7hBPLB2NLwhyKucnX52m1FjTUszia1kC331Mxs9D+mK3qn4q8GJamvTmywt5pEGP2s4j+BD0TEqIg52i7SH/0+mCizSb+j1eyLdIQG0e6rnDRhjkp3x499VYYNrEwB7pFBheSrcwrh/aI0TYQCEDM0uKmgSEHGP2e+4sNKnF+u4WI1aKCNtsJFID9jnwW+nWr0vL9ZUbY6leZIP6B2xaKoYbTEa+5GqcKHNEwBkBLkzM4Gsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by PH7PR15MB6058.namprd15.prod.outlook.com (2603:10b6:510:241::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:32:09 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 17:32:08 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
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
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 7/7] bonding: Selftest and
 documentation for the arp_ip_target parameter.
Thread-Index: AQHb+CplwNRQMj38hkSi0WfLDuwVmrQ4qdqAgARPRPGAAAzdAIAcGUrK
Date: Fri, 8 Aug 2025 17:32:08 +0000
Message-ID:
 <MW3PR15MB39137E1CD22773D13515DD5AFA2FA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
	<20250718212430.1968853-8-wilder@us.ibm.com>
	<20250718183313.227c00f4@kernel.org>
	<MW3PR15MB3913774256A62C63A607245EFA5DA@MW3PR15MB3913.namprd15.prod.outlook.com>
 <20250721130800.021609ee@kernel.org>
In-Reply-To: <20250721130800.021609ee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|PH7PR15MB6058:EE_
x-ms-office365-filtering-correlation-id: 0fd734ef-84c5-4216-e617-08ddd6a1806e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rZApKFgZVxGjWxvywoA3HZDdkBp23iNWnJo/fab3iXwmUEFIbtIJKqWaQj?=
 =?iso-8859-1?Q?pMkUrXf2EUn1UkYjqd+1u4lC9HecU3w3PAXSH7cJF7MrCk3hSOdyyediF8?=
 =?iso-8859-1?Q?xcG/eDZn7jYhXOMUPRTlurMq93F9Dvhqq9TO7GKUCov5FE9f72qO5hs8x1?=
 =?iso-8859-1?Q?u1ICoSBs3PMfXeYqWDytDJU0KHWXQsjgvh2J4f1NayejkZXu7dKFQE4IR6?=
 =?iso-8859-1?Q?HlNzLvu9y7tE6r2ZEb5wseSVqHfmw9/LfSvbPFyHWi8DwxlX6PTZJkqiTd?=
 =?iso-8859-1?Q?l5bWafB3ytvlM6nkRvn20Ds+QLxeQK2S+Pyjw3cswhqBCIxUiR0+OZ+PPO?=
 =?iso-8859-1?Q?pnR3thNf94PMhFk6Ob8F9JXLxus/tnGkeucxpSvV5J3troSgdd6x1jcuHj?=
 =?iso-8859-1?Q?5VRhBSTTPsXYQTtjmnDGT0Zr6G65NZyM2czZXoIN1QGtqm2nwQScpss6im?=
 =?iso-8859-1?Q?sG1KRLdU85pJIbRdG7UqahrzlGN/49q8iPQ2cmBBBiCqWLP4UIcDIksIzl?=
 =?iso-8859-1?Q?GKy2pNVrkjHCF3ha8NAThND4Rx8onnwGWPjeTA9Rjfr9+vsw4gYkXktaAv?=
 =?iso-8859-1?Q?dDmZ4gfYSFVQXUZdeAN2UsuD+6BSAt9L6DZfxQTlzOOy8K6nwry7C1jEnQ?=
 =?iso-8859-1?Q?b+ncMR+mNB9uekj7ZE/n8uVh4th/3dob8Rrgz6umuRzMRDuXRJZL5ceTGe?=
 =?iso-8859-1?Q?H5v+0cDWxVyq6fGFUX+ANgCD4KzINpozfwehegZWHt4wRq5o8q+A5zvVFz?=
 =?iso-8859-1?Q?+CZV+gMtOX/pK5duIAx5ggaS9zHuno6iCSc5j/2hQQO1q8lJFd7J7OmK3F?=
 =?iso-8859-1?Q?YGr6vnIq5caLmtxULbbmwK3F1Yqi6OaBdweeenemfRF7rqXeapyL730O+Z?=
 =?iso-8859-1?Q?0MJmGIb/gsBNJJw0Snsq4g7TSEf6G+afsZ7Ye9zHYHlMU18RqshO1y/ROp?=
 =?iso-8859-1?Q?t3H1+AUkappm5nkgjqWpgXDSHB257ndiu/6Vlmkg4CV4ubceQUlmyKSbsD?=
 =?iso-8859-1?Q?XVsY2atVLHw1/gFxa+pj02d5mXvAOFnPnLLJIIEqY00dt4yEgtYf2jABqe?=
 =?iso-8859-1?Q?ZhW8R5AHAIEkmib2xDYoctTc2fiHKDtlr2KAAWipfnZ0rEbMsHE5nnCx09?=
 =?iso-8859-1?Q?ekojRf2Pqp9gWl4W448ucv3uHQwfvb5zreRIG45jW05nhTNyT5/aMSM2d4?=
 =?iso-8859-1?Q?j+EtQzdthLUnBO02TbwPlKoQV+l16gV8WkC0D+X4xyeTz0Z66ek4ISvV/H?=
 =?iso-8859-1?Q?A4k9qsJCfCWHCOXoMfWU1Z5Vrh2aRdwAK1eqCkhCBRe/QWlsO9TjVVVTJo?=
 =?iso-8859-1?Q?/hoaeXcIFUl6eWZl9tIwFb3iUN3okn//b9KIFO2/d+L+/qhvpcWDz4yi+N?=
 =?iso-8859-1?Q?XtDUF9Gpmk9rtzU22ul7Bs+WI/UUGQC3ODQOiG69S2kZmgdUtw9pHaL9C3?=
 =?iso-8859-1?Q?N5ionIRCj6e19ETLuFcriAdKRyke+r8hCi3iyVyjVwXkjhgbgNJA5Rmojr?=
 =?iso-8859-1?Q?g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ss0CTdLLYDItQG4XZZ1QlBBmj6VN0wf+wc32obESKdZQTyk0GC/qGCn/4o?=
 =?iso-8859-1?Q?Mh8a4BXEweBzicx9bhxymClaKDYAbkTmikJhO64xptMKTO5VPmwMzwMHbZ?=
 =?iso-8859-1?Q?LhJs8gsVI6o2UGeqLvRbavlxC4Bz0mUGr999L6apr84ihKOlqoSKL7+uyP?=
 =?iso-8859-1?Q?KmBYRWQteTgbUpcSTsimERI0yUnLPErpm9iMhT6HoamrpR/qEhYLEpXKvo?=
 =?iso-8859-1?Q?H0pFdSahy/EO0PN6brb+GPPX+ddISx4IyEDO4lmbMdXwrjMWmt7DJNMVI8?=
 =?iso-8859-1?Q?JV5acWNLE0+IKoda2J1t9BfRCd3cf7VFRf46yjlwB6LCEa/zBbJVgRxcaw?=
 =?iso-8859-1?Q?CffbLLCxzM0b/oJ1/Ww5MjBDdVAP0Fo+f62+B0hqYxZROPveUjh6Tr4ZYo?=
 =?iso-8859-1?Q?e63TySZU4JY2vn7a+amXSM6jawmUxPzjv9KHgZPwBL5OHTvW3KmxzuA8zh?=
 =?iso-8859-1?Q?AWH9KUm49YSGU8SDg5eiYvSnVbakVtJ2kmT/4DqJDkZqbfor9v2aueF87j?=
 =?iso-8859-1?Q?rRxkKoKDl3k4Cjl8iuZKyXV5Mq5riyYIP1w6Frfd3fL0hVAF0eLWndqf5/?=
 =?iso-8859-1?Q?v9XMjroLnUWvzS/g7NW3irJ/3lORdLVZ+MOlog+Ql6lyh/aHXzJVojSZPk?=
 =?iso-8859-1?Q?XkWMEChDBzgvP2e2EBB6cKzhkV8ijwP6Q1E0u/KFdRS/McwXTvAZcMSkaJ?=
 =?iso-8859-1?Q?Ad90cwCOcZt+kwbivgP5zdJ9VuHDSCn1415MoOUO2zWCMPxYFFgKzZdavH?=
 =?iso-8859-1?Q?JGl3kHYDxn6kKlVjvn/XQRU1YOZCrUlcXvjJ+MDGU9mUwIMzqP5R8dfiOz?=
 =?iso-8859-1?Q?jzgblzHHbndKPKbukX/eUYCl5NPo5+CxrRupa5yqIa2j6GvtOqWPWWj1S6?=
 =?iso-8859-1?Q?wvYA3KWKZjZOriRRDhUoBiH1kuysuKVPEvqunDWX7XKCLBSCTz5MrJR+lE?=
 =?iso-8859-1?Q?dfSbtwgCScsxthmZMtOrLPW1bu2ZtISJduelqVpUF3FP6OU5rR6RhXV6Ew?=
 =?iso-8859-1?Q?bkE4Bq98b/Don/FT0t+BYmg/chkj2v/UhqnlTfYiBbHuFSgd9QNbFeLHJU?=
 =?iso-8859-1?Q?4l0cw5bH9B1mGyK3It7zzSJmYxbwvdOct9wmCG5+1B6N0YNja6F4o+ofYP?=
 =?iso-8859-1?Q?RkKlEOUfYTiGtdfuR/ZPN2FW0g1P9ePRofdNOqQlqksr9rIqwv0woiRtiE?=
 =?iso-8859-1?Q?UvkcnR2UGozIREpI+CpS5uwrvUem4OFxYKocM4sj+9Sp/Nsk3uKI1Mu8jb?=
 =?iso-8859-1?Q?13T3OGqpUh8uVcTBEAKsS9Wtqd0k7l9UQXBLwcHLiJdpWE7Gbh2jn1Ry09?=
 =?iso-8859-1?Q?3be6sB/LWfn08vVPDChqnQxCrECXq/rzO3oGjPglCsyOKNMDuWCPadNZIH?=
 =?iso-8859-1?Q?cjXN+XxB8QoEQHxJJWKs2HqUd1IWre3rZTeO9fCVRrxWVogMVnlbWcEqWg?=
 =?iso-8859-1?Q?5b0BH0Mv6wXxJ9lDrBjD9L9GG7jmx6bMNMXpbjxotL2HSQK2GQZhimnx/5?=
 =?iso-8859-1?Q?A/WKOBfQoD/l8KYIEB+NFWMh8o8PjNYh8Dg7HCwcUfz66yYFLRWP4BNyiy?=
 =?iso-8859-1?Q?M4JADt3fkPtvXdu3V53d+eGmSUPIkvZ5qOGosmPi70JJDQG/p6NXmDPfwc?=
 =?iso-8859-1?Q?4eADg7ldQrl2iOiw4UZNaaP7QV6bZFsyZYYs1fg5pEbzcVHGA4zYLKmOhL?=
 =?iso-8859-1?Q?fuv6sXF57Gkqj4Awmb0=3D?=
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd734ef-84c5-4216-e617-08ddd6a1806e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 17:32:08.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkDQ62mxHuQccl3Zg6k1EC0SLfq3vVxOdkckCyDDjI1Q2YyPAygG6VyLnWX0hq5erLH74NqzvfgL8P9ET8m2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6058
X-Proofpoint-ORIG-GUID: 8ApSN5_4E6Yv32b0mJdw7jMPZYJYxban
X-Proofpoint-GUID: 8ApSN5_4E6Yv32b0mJdw7jMPZYJYxban
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0MSBTYWx0ZWRfX6/Fd2zUSOo6g
 HxEPhT3afQulxLQ4whX7ZqWRYo2ua/9fvdUUMKerBEawhWeZ5LRuANWf9ap9nN0hRw6Omhfj+cA
 s/8U10nvEDsGpv6bQAUXkWv4y/tfAyw8lQb+ez4ojNRhnLgVDwiSOr2z9sDLWnk3yXfy8sRWHQz
 it081JS1+PaXyaOMFyS4ShCUih7QOpxjtBNPQxru3pLXM3rPHG7BX/ZxPm6Nd7oy0gTkhMkp86i
 +RrP+y1i56024+OsAJ2Xu8R0YXVCAYsQKWPkwaSDn0Us6e6C4rpyCGUjNemlLJqo+0ABatn7mAu
 3Bi9PJMHm/e2/JkqXDdJfPCDHVLz+zTt0HHW6Om6LgoNYl1uiOVfAMQVeaCUGtOgSiOk9kZZ3A+
 QsDEaahi+n9+noNsaaT9ydsvOKVkgdze4R+yyO+EeR769rsrmKLKTFGeRyAfq6SqUjX5YPmR
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=6896349b cx=c_pps
 a=cuPJWEzJpmcHvA/7N1z2Ww==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=QtvRY4xpf1MSlWN2:21 a=xqWC_Br6kY4A:10
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=9R54UkLUAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8
 a=jZVsG21pAAAA:8 a=oDX4dzLNNQvbhd9vYb8A:9 a=wPNLvfGTeEIA:10 a=KN3gYJeSjaMA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
 a=3Sh2lD0sZASs_lUdrUhf:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH net-next v6 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2507300000
 definitions=main-2508080141




________________________________________
From: Jakub Kicinski <kuba@kernel.org>
Sent: Monday, July 21, 2025 1:08 PM
To: David Wilder
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; =
Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Li=
u; stephen@networkplumber.org; horms@kernel.org
Subject: [EXTERNAL] Re: [PATCH net-next v6 7/7] bonding: Selftest and docum=
entation for the arp_ip_target parameter.

Hi Jakub

> On Mon, 21 Jul 2025 19:23:19 +0000 David Wilder wrote:
> > >This test seems to reliably trigger a crash in our CI. Not sure if
> > >something is different in our build... or pebkac?
> > >
> > >[   17.977269] RIP: 0010:bond_fill_info+0x21b/0x890
> > >[   17.977325] Code: b3 38 0b 00 00 31 d2 41 8b 06 85 c0 0f 84 2a 06 0=
0 00 89 44 24 0c 41 f6 46 10 02 74 5c 49 8b 4e 08 31 c0 ba 04 00 00 00 eb 1=
6 <8b> 34 01 83 c2 04 89 74 04 10 48 83 c0 04 66 83 7c 01 fc ff 74 3e
> >
> > Hi Jakub
> >
> > What version of iproute2 is running in your CI?
> > Has my iproute2 change been applied? it's ok if not.
> >
> > Send:
> > ip -V (please)
>
> iproute2 is built from source a month ago, with some pending patches,
> but not yours. Presumably building from source without your patches
> should give similar effect (IIRC the patches I applied related
> to MC routing)
>
> > Can I access the logs from the CI run?
>
> Yes
>
> https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-202=
5-07-19--00-00=20
>
> > Is there a way I can debug in you CI environment?
>
> Not at this point, unfortunately.
>
> > Can I submit debug patches?
>
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style=20

I am able to run my tests in this environment, but sadly I still cant repro=
duce the failure.
Can you tell me more about the environment you are using for CI?  What vers=
ion of GCC is used?
What distro and release is the environment build from?

I have made some changes to the function that is failing In an attempt to f=
ix the problem.
If the problem continues with my next version would it be possible to save =
the build artifacts
used in the test (vmlinux)?

Thanks
David Wilder

