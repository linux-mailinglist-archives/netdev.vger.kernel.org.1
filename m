Return-Path: <netdev+bounces-203905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D3AF7F87
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B1916ABD6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1563274B43;
	Thu,  3 Jul 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n6JMCxbk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEC25A347
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565795; cv=fail; b=RXBfuw/fuT4U1lY5a5FSFIKCM4oEEKb7qf2L/ToyhYCLmZqeTew6DqUOfHewIOie6WT5GjmoZ4Nvwf+7oiNlyAw5MbQxEk5qccCCxmrUISQ9Ck/WvX/RulSJ0aiKY0BTNd+ECqLTN+9KbU2HH156XaSYhgLP4NiDop3yztj4n94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565795; c=relaxed/simple;
	bh=imP80j4TbEdowB6hByc21kBYuMKRWnu7GLKjxkn8yrI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qL+PmLjB4riZU5SpLLFL3msac7SGkh1VOZ1HEcqyuXvXiG+2UkTYdrSW9LJUNFZyv9XIMibkleWj8HWyncn6ziu9RwTGb9SglUtbyoSpsWNQ/kYNmJHysL0X1+BSvyvTzR8ltyvQFvOEdZr+VqiV+H1icfvDbbNn8ZaKR8U2DLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n6JMCxbk; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563GxIuW015498;
	Thu, 3 Jul 2025 18:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6d3XzO
	8ncoY0bWMBNQ4lhP0k8ZTYpDV4a0VOIJaxK0Y=; b=n6JMCxbkrLypNvQ+QGKkky
	ru1e4JLNIm7jQ2NblxAuegX3Rpe/1uzq5Z0QGuFIW0/fYDCCeDPwKkJYepQypNCT
	Bggqs6ac4YRXQnn0iJxReAyMaz9rFwhwmtySe2NyUt3+Yx2tzcCuhO7xGKfpkoc8
	XweVuswrXj+2YyQbEhu1rw+s8LOifB2D831vyD0swK0W7GzOD9SgEOKCq0bWozMC
	1ufJxbhCHBrbaey4h28hUQxfwn9L9qMu70iY7AkaEUlc4FkA80KmLCUNyvDx/ELP
	bseNPSJ84rzb1aTHZyNlIjmvVSdu4X9KA5ccLqDopAtAhGHcCb8gsAAwRYGWc7Hg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrwjky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 18:03:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563Hw4tP025145;
	Thu, 3 Jul 2025 18:03:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrwjkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 18:03:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO2Qv1V+tpv3AayrT07CaYXcGwUQc1YDVLtF3dvB0hONdIIy5SrwFRNOCyJIZnPobfCxz7zoHIBL8dW5sBAt45cGUtXpEy6AJ/xIoQVe0uXn5pBu/AJYdK0GfTfLWg4Ck8VAEHKnnMYzmzWp6q4GKT/sLY3s9Nd0UJ6zdNOuq51q+39dSAOf38/LGakEfGPc6uxilaPIm60fvZm9bcwdaxAlO/hdkLF9Naeh08ZZyIpDrp0yiWZllYx2EOMVRog/JY9fWQCCctE81gCBGWvdpQ25hevrwWi/E90U92jvmv231CWDDdFJKZbmPyTW611/1rIo430g+JZj2h9QDvwUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d3XzO8ncoY0bWMBNQ4lhP0k8ZTYpDV4a0VOIJaxK0Y=;
 b=fAEHZaPrJ2MigPZqMkpuX6tFnBPzsurrw9THYswcpDbkvONfrFPOxBQKuGMUZNCHMiiEMP67xKrkY5NhQlxfWk7nGN7koMNpOLfDyxsOGNxaiKaMaHSDiYoQTTlRyEdjuss803Kimhxf4njwlKzMrO1HG6HbJv6gLRw5GvLX1CcCJAdgIymzgFdyUNipm1/IdGjVm2FAhGR7ENakpU9yleYv+7sK+XG8lY+itY0J+62J90omq8d3yW7hDZSCBbRxRc2sV52b3+JajzVVg7f5qCJkPmyFcjaz0s8NxnaPRIbaS8QmF8ItVktqrQ8llNxfVGm3lxCgCuITda34xq9uZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by SA6PR15MB6525.namprd15.prod.outlook.com (2603:10b6:806:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 18:03:02 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8880.034; Thu, 3 Jul 2025
 18:03:02 +0000
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
	<haliu@redhat.com>,
        "stephen@networkplumber.org"
	<stephen@networkplumber.org>,
        "dsahern@gmail.com" <dsahern@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH iproute2-next v1 1/1] iproute: Extend
 bonding's "arp_ip_target" parameter to add vlan tags.
Thread-Index: AQHb56GBNutcjQylmkWposPblhytX7QfrmMAgAD4VuY=
Date: Thu, 3 Jul 2025 18:03:02 +0000
Message-ID:
 <MW3PR15MB39133DDF8FCF1FED3798DC0BFA43A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250627202430.1791970-1-wilder@us.ibm.com>
 <20250627202430.1791970-2-wilder@us.ibm.com> <2156542.1751508276@vermin>
In-Reply-To: <2156542.1751508276@vermin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|SA6PR15MB6525:EE_
x-ms-office365-filtering-correlation-id: 84a3e81e-4787-43be-85b8-08ddba5bda20
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QHjJelFv9uLe2KeM/0w3CgHfnnQC9kOOxOEWKr7wZpthLy2C03wVB1ti9G?=
 =?iso-8859-1?Q?R+lHoP8qs3fKBefEgShvDtVd1hcZlQrGNxmvWPdqiHm93imIXSsRmp0lh8?=
 =?iso-8859-1?Q?SQ/265Hwk0xjz74HHyH4VE/688jdzSTjPaQn3QgvVjOlrg7SV4PgA3J6Y/?=
 =?iso-8859-1?Q?K4m+BLEOaKtB6SjEiKr1UtzuUN9IncjhaqNgoz4RijV/0+assOYRn3ifiR?=
 =?iso-8859-1?Q?ppnGI89CizOlUHomGbL0CTqtCu3bGFyHKZvMm7Tyh6lmq65n3pmmqqMGIp?=
 =?iso-8859-1?Q?s2aMf64uqt3sdFku4J/YW9eEf9UTbPaDxSVfRLe9CA6pTf89PbyprPjV4h?=
 =?iso-8859-1?Q?6nsrCCzSp+ISRrbXODbFOFv3eJJHRH9K3kHmfJeNYQHCoPmZH9KA/mocuz?=
 =?iso-8859-1?Q?5DkrpNDiqSB9suGR+UpFjF4QVodmg9iE7t/UjkJ1Gck6QjTO/5IqssgKug?=
 =?iso-8859-1?Q?+WVVLuPVQpw8jEULaUTXpRRMYtb5lYznY+xiQDct9sOr155BqZHyeB7riY?=
 =?iso-8859-1?Q?0a6MzNN2AH9MPfs2aR1cw7Q3Rq/YaNL+8K+wvryLTIOQcSTropWa3SePtQ?=
 =?iso-8859-1?Q?uWV11LWg661+pRrKE2O5HTUBuKHzIaO5r3poj2meJjVgZbL8anP8Ex8oSL?=
 =?iso-8859-1?Q?7B6Rv84rfHlSwAgV+nwOe8xnMvsUBRto+7lWlM58lXFe0k0rMhGJ5afYOd?=
 =?iso-8859-1?Q?mrIDaCh+RwNyLnrSZnj4a9UJyItkZX1MxH6tovQ+0rPObwznTHjhOgvugh?=
 =?iso-8859-1?Q?ay79mBWQrBPUzMY9AZU32WMsL6VevpcXTdxD8zM3Pes5wXDQqG4VSwjWQp?=
 =?iso-8859-1?Q?YmSCvPPuIRZ3J0hdP4VkHWzdO6eSn83XdrFbWGFgzlJJvej/0ThZqZNPcV?=
 =?iso-8859-1?Q?b7xsbxz1DOHCGsczrd6pYBvpV8qgvaqENQxEgklZMHdV/8vjHZkPhuNe7A?=
 =?iso-8859-1?Q?d2YPpXXR3vy/b9TaR/eCgeYOXGNlzGxjA+6qpviy7H7v5ODMSs3D7S8u6z?=
 =?iso-8859-1?Q?9ISe4zp5ALXAKs3UAXDX9yssIBzV4gW3oHnDEf/YpJxjMuqqei7A4vlxq8?=
 =?iso-8859-1?Q?fzwOB4RwAiN3VRlPDPKOBkSyX3uDBx0H9iB2o1fhd6UJcAMHBgNfoxmiOa?=
 =?iso-8859-1?Q?QYjJWHasQUmuHjc9vLmYSwSGfZyGTHifxR3q9coRuDwbuElM3JrHPV59B8?=
 =?iso-8859-1?Q?owjEODLIg87x7qT1tDz5Q4PqIziMr4VenE50x7xFDTwCqMXxj/qNUSBZYn?=
 =?iso-8859-1?Q?i41dc6Na9UzaAb3MuXp/KZjOBlJB18MERDkTiGtbMQ0tOhmWsHvl1hHsPq?=
 =?iso-8859-1?Q?UQth6I6OfgkMzf0RoZFjmwPloXCnwhCY+mT3XQ7cWiTJZ6oehpAM6fr3ne?=
 =?iso-8859-1?Q?rH8sbyIOD1wvwdOblvJ/WThYwBML/ZEufwwrBKC9HeE/WnLZiS7bWeAFUs?=
 =?iso-8859-1?Q?iIWGXKdcaiflcGnAsGxczfnU8IFC/UvN5VTz5l9A4Uk9mEdfHiNq9xfzmB?=
 =?iso-8859-1?Q?oPsL8lCm9sRFtH2kKjiWmh3MgIfema+OAiYyuZtr8XwA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?09DHleighXr0e1uNCEiQfGanundsAT/u0dAfnrUb4DEonsqAU6b6CzwQwM?=
 =?iso-8859-1?Q?vzUC07CjA1eQ4uQqg/V0t+WENIYkfDERSNa076AnCcAeIQ6ixhIyUhhL1J?=
 =?iso-8859-1?Q?wwhADIkvaDLOMh5RTR1/3CK0y1KTJlEPpIvdMy7Az19Bni3Thuu1oZKk+0?=
 =?iso-8859-1?Q?UaZQo2Q5jEC2y1s2XOq/QdBRIy3IO4UFYVa5oaThtKRzONN+MbHbnVbOWI?=
 =?iso-8859-1?Q?SM6FB/QnoFsEb13dPo4urHXWb3C+r527tmZePthdjrirglRecE5G5qRWaC?=
 =?iso-8859-1?Q?UwyAoPKHMUZE7nObf32z6uLzPFASbakyCK1S/bLLeulmH1v9MBjtR4XZRv?=
 =?iso-8859-1?Q?Tn8TVwBG0JJIW6p6v1k1IOhOn5LWa+wP9H08871Q0HB8rM+ApgqKq3Uonp?=
 =?iso-8859-1?Q?XQGeSsLDBljQCso/Fw6JFbyveKfWBuh6OPBwliCltiC8NN89w/FeFMmrDY?=
 =?iso-8859-1?Q?np03B4IyHWat2UtioTsWE5q//vV1Fz/US2reASYDGTx9zQ6z5NxmL5L5hl?=
 =?iso-8859-1?Q?VK6GExVZSEtxWLgeY9wLKEmbVXlIDhBwbAkLJRIeqU+isAWYAJ4hO1+QL1?=
 =?iso-8859-1?Q?KiLwBiHSJmobodkw70rn3PTBa+jHJ+yGlCh3Qo+czSDHD9rgT0+0nn92Vi?=
 =?iso-8859-1?Q?VSS3cNZohe9CaoCrKRAgviW+5hon4afPlu6gMauuOkirmQFEILTMuPKLZM?=
 =?iso-8859-1?Q?DW3NEgvrsGitzyjsQLFpXRe7lynaA5q8B/F8DX7qzpKUe43E8jKvGQSP1w?=
 =?iso-8859-1?Q?2cs4cG38Gv3THnDhb1og+pL7Pa3nFLnHBJwGvvu6bP5/vh6EwEFoKjwj5Q?=
 =?iso-8859-1?Q?FwiGcfug4eWqfWxCynf9zYvGDZeEQF9P/mNPsEwcIj5LOGDpmjKohn+Nma?=
 =?iso-8859-1?Q?MWC0NuqKHr+0cVP1s7xCELiPFQMxIgrhfTrSq9f26imIu9N6Ct0MdY7RGv?=
 =?iso-8859-1?Q?NvAJRWg3k8XqnAg/l2j4Rr3ESLvizP7I9kGM2hnyTmfnyH0cyrC4WrnBn5?=
 =?iso-8859-1?Q?ECpkcjq4JGuD6bQAMlVs7TTqaTxK615OJrSBP3O7lOM6OBHGALivXcMTfY?=
 =?iso-8859-1?Q?2nVpLJGrIvTbkvcjCZXjqIlM/W4hN+sFXGyRKUb0W1YCNXWtnq+ir53ePx?=
 =?iso-8859-1?Q?FhEFKcGdy0JXW/EsJOyn+eOA25IxcXCd2oM7fuAkexuxaUX33r22PAMHF2?=
 =?iso-8859-1?Q?pwBPBW/Ea8WEezaQsF56heuhCYJ1HKo24kYbWjcHXR2qyTTvgKXkXKPg5i?=
 =?iso-8859-1?Q?WH/UxAMkPOMVeOrnPy3zVwNlELq2laByhjSjPiv+ErWBzgxjUiQAqDgLgR?=
 =?iso-8859-1?Q?stGEs+OWekujT3WwCTuuzTmejQr1BxqLeNq5EWhSDamLopIAtxy0Dkd9mD?=
 =?iso-8859-1?Q?faz9QT/xMdsFqlxxnaE1vhAy2riWCjawxZzB9mUGyfUpfFOxDTIpF0vsAh?=
 =?iso-8859-1?Q?C+n3wGrnjnw9zaIlbAl9RL2SiHtJsc+vLKuBlbLQYiGP4C17wPoqRW2zje?=
 =?iso-8859-1?Q?l9078qZn6izhZtDjV8YC58A2fxIXpAr0KJWlYwttj5rKMaLpy2k1NOE05z?=
 =?iso-8859-1?Q?1cFNiVFx4VLuzyVwmdeCX1IST1PnN9EQfllipLOiwUZ/qqjJmchcrIkuSw?=
 =?iso-8859-1?Q?9CM9dlQq3/Tq4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a3e81e-4787-43be-85b8-08ddba5bda20
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 18:03:02.0714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddyb1eIadL5A+TB9vKbv0tRCv6wIuJgPgdzNK13h5gcZgJm+FMCJaBOPZDt75VKGH52AyO3GaUAJsa1FzZNy0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6525
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=6866c5d9 cx=c_pps a=gXZ/wpAWB1oytwcVMRVXYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=2OjVGFKQAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=pGLkceISAAAA:8 a=GPMZbzH33hYHH8_cDikA:9 a=wPNLvfGTeEIA:10 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: IrpGgv6q2gOrQVj1B0sHn-iMCZbPqYVa
X-Proofpoint-ORIG-GUID: fb_yvi3okskiM87o3MHQeDLMhv9exJeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE0OCBTYWx0ZWRfX6ZiAbzQn5uG2 RbJeVSPTr2DArhyO8gr5XMGGZ0XSWw2KuSfzfNsPguXs9tqPllisTTNhWp2UhA19OGfZiTctqFo vYhaQKOfEkiigwysJPURFeLMtxYNFhdaPOXXdobxQ3m3pcLFDbmovIStEO8REcSs66QJOoWDsFj
 2zmoR91dV0xoZ2geKMian6COfDshV/pjM0dUjlpVhDGNOjywa/WXhiMHnpA5XVpyP7jV7gID+g+ 1gopxpM4aReaBeJki/qEqVQ2r3YssPhLwh8bVEEtUud2393uCDKZBBiVh9pJoHjqLj5jJMXyi5R ozRkxIrWVWTf6P5Np5fMY0gUr/crXvhXr9BkmBeF1TiZ0J2rymLF0x02yByYHqmJngs6XGDCPro
 I9ju0o7ZMGSgbv6QnkHX7pMZOAUYg7cpKtNMo3UBrbpBPz2yVlcNXIaWb5fO0346ti1O+OEw
Subject: RE: [PATCH iproute2-next v1 1/1] iproute: Extend bonding's "arp_ip_target"
 parameter to add vlan tags.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030148

=0A=
=0A=
=0A=
________________________________________=0A=
From: Jay Vosburgh <jv@jvosburgh.net>=0A=
Sent: Wednesday, July 2, 2025 7:04 PM=0A=
To: David Wilder=0A=
Cc: netdev@vger.kernel.org; pradeeps@linux.vnet.ibm.com; Pradeep Satyanaray=
ana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@network=
plumber.org; dsahern@gmail.com=0A=
Subject: [EXTERNAL] Re: [PATCH iproute2-next v1 1/1] iproute: Extend bondin=
g's "arp_ip_target" parameter to add vlan tags.=0A=
=0A=
>David Wilder <wilder@us.ibm.com> wrote:=0A=
>=0A=
>>This change extends the "arp_ip_target" parameter format to allow for=0A=
>>a list of vlan tags to be included for each arp target.=0A=
>>=0A=
>>The new format for arp_ip_target is:=0A=
>>arp_ip_target=3Dipv4-address[vlan-tag\...],...=0A=
>>=0A=
>>Examples:=0A=
>>arp_ip_target=3D10.0.0.1[10]=0A=
>>arp_ip_target=3D10.0.0.1[100/200]=0A=
>>=0A=
>>Signed-off-by: David Wilder <wilder@us.ibm.com>=0A=
>>---=0A=
>> ip/iplink_bond.c | 62 +++++++++++++++++++++++++++++++++++++++++++++---=
=0A=
>> 1 file changed, 59 insertions(+), 3 deletions(-)=0A=
>>=0A=
>>diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c=0A=
>>index 19af67d0..bb0b6e84 100644=0A=
>>--- a/ip/iplink_bond.c=0A=
>>+++ b/ip/iplink_bond.c=0A=
>>@@ -173,6 +173,45 @@ static void explain(void)=0A=
>>       print_explain(stderr);=0A=
>> }=0A=
>>=0A=
>>+#define BOND_VLAN_PROTO_NONE htons(0xffff)=0A=
>>+=0A=
>>+struct bond_vlan_tag {=0A=
>>+      __be16  vlan_proto;=0A=
>>+      __be16  vlan_id;=0A=
>>+};=0A=
>>+=0A=
>>+static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list=
, int level, int *size)=0A=
>>+{=0A=
>>+      struct bond_vlan_tag *tags =3D NULL;=0A=
>>+      char *vlan;=0A=
>>+      int n;=0A=
>>+=0A=
>>+      if (!vlan_list || strlen(vlan_list) =3D=3D 0) {=0A=
>>+              tags =3D calloc(level + 1, sizeof(*tags));=0A=
>>+              *size =3D (level + 1) * (sizeof(*tags));=0A=
>>+              if (tags)=0A=
>>+                      tags[level].vlan_proto =3D BOND_VLAN_PROTO_NONE;=
=0A=
>>+              return tags;=0A=
>>+      }=0A=
>>+      for (vlan =3D strsep(&vlan_list, "/"); (vlan !=3D 0); level++) {=
=0A=
>>+              tags =3D bond_vlan_tags_parse(vlan_list, level + 1, size);=
=0A=
>>+              if (!tags)=0A=
>>+                      continue;=0A=
>>+=0A=
>>+              tags[level].vlan_proto =3D htons(ETH_P_8021Q);=0A=
>>+              n =3D sscanf(vlan, "%hu", &(tags[level].vlan_id));=0A=
>>+=0A=
>>+              if (n !=3D 1 || tags[level].vlan_id < 1 ||=0A=
>>+                  tags[level].vlan_id > 4094)=0A=
>>+                      return NULL;=0A=
>=0A=
>        Two questions:=0A=
>=0A=
>        1) Do we care about 802.1p priority tags?  If memory serves,=0A=
>those manifest as VLAN tags with a VLAN ID of 0 and some other bits set=0A=
>to provide the priority.  The above appears to disallow such tags.=0A=
=0A=
802.1p should be ok, the tpid is the same just an added priority control fi=
eld.=0A=
Could not the priority (PCP) in a 802.1p be different between=0A=
flows to the same target?  In this case we are only defining the tag for=0A=
arp requests the default priority 0 should be ok.=0A=
=0A=
However, Do we need to support other tag types? For example 802.1ad?=0A=
I would like to avoided making the configuration complicated with too many=
=0A=
options.=0A=
=0A=
>=0A=
>        2) This loop appears to be unbounded, and will process an=0A=
>unlimited number of VLANs.  Do we need more than 2 (the original 802.1ad=
=0A=
>limit)?  Even if we need more than 2, the upper limit should probably be=
=0A=
>some reasonably small number.  The addattr loop (below) will conk out if=
=0A=
>the whole thing exceeds 1024 bytes, but that would still permit 120 or=0A=
>so.=0A=
=0A=
I will add a limit.  The existing implementation has no limit,=0A=
although bond_arp_send() gets the order wrong with more than two vlan heade=
rs.=0A=
That's a bug I hoped to look at. I found I could workaround that by specify=
ing=0A=
the vlan tags in the wrong order :)=0A=
=0A=
David Wilder=0A=
=0A=
>=0A=
>        -J=0A=
>=0A=
=0A=
>>+=0A=
>>+              return tags;=0A=
>>+      }=0A=
>>+=0A=
>>+      return NULL;=0A=
>>+}=0A=
>>+=0A=
>> static int bond_parse_opt(struct link_util *lu, int argc, char **argv,=
=0A=
>>                         struct nlmsghdr *n)=0A=
>> {=0A=
>>@@ -239,12 +278,29 @@ static int bond_parse_opt(struct link_util *lu, int=
 argc, char **argv,=0A=
>>                               NEXT_ARG();=0A=
>>                               char *targets =3D strdupa(*argv);=0A=
>>                               char *target =3D strtok(targets, ",");=0A=
>>-                              int i;=0A=
>>+                              struct bond_vlan_tag *tags;=0A=
>>+                              int size, i;=0A=
>>=0A=
>>                               for (i =3D 0; target && i < BOND_MAX_ARP_T=
ARGETS; i++) {=0A=
>>-                                      __u32 addr =3D get_addr32(target);=
=0A=
>>+                                      struct Data {=0A=
>>+                                              __u32 addr;=0A=
>>+                                              struct bond_vlan_tag vlans=
[];=0A=
>>+                                      } data;=0A=
>>+                                      char *vlan_list, *dup;=0A=
>>+=0A=
>>+                                      dup =3D strdupa(target);=0A=
>>+                                      data.addr =3D get_addr32(strsep(&d=
up, "["));=0A=
>>+                                      vlan_list =3D strsep(&dup, "]");=
=0A=
>>+=0A=
>>+                                      if (vlan_list) {=0A=
>>+                                              tags =3D bond_vlan_tags_pa=
rse(vlan_list, 0, &size);=0A=
>>+                                              memcpy(&data.vlans, tags, =
size);=0A=
>>+                                              addattr_l(n, 1024, i, &dat=
a,=0A=
>>+                                                        sizeof(data.addr=
)+size);=0A=
>>+                                      } else {=0A=
>>+                                              addattr32(n, 1024, i, data=
.addr);=0A=
>>+                                      }=0A=
>>=0A=
>>-                                      addattr32(n, 1024, i, addr);=0A=
>>                                       target =3D strtok(NULL, ",");=0A=
>>                               }=0A=
>>                               addattr_nest_end(n, nest);=0A=
>>--=0A=
>>2.43.5=0A=
>>=0A=
>=0A=
>---=0A=
>        -Jay Vosburgh, jv@jvosburgh.net=0A=

