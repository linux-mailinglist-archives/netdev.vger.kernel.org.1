Return-Path: <netdev+bounces-221776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C24B51D8C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3445C16B872
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909FD334714;
	Wed, 10 Sep 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kGkpr/id"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82B19C566
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521394; cv=fail; b=t1wvvs26jxF4WSmtt2Lbd516cGCBb5Ota7C9tx9L37VR1ncbpNkZQAOuD/LBTHIsIcoB/dgFomLeoz3jFfoqIOf51Rtk+LR0rjlFNPjPKM2qhws9sv6Yxq2Ix96KW9iSrC973HEFWJry6UN/o1+OAshW//fupzvF7Xb1unirYXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521394; c=relaxed/simple;
	bh=usE6APhO1XeGh0JSp0CVQeMXsXSY19U8rNAvahe15Qg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qb8DeqTY3wKW3uf1ryaPXlYzKuisJgfNhGlvPugJ1yeWp6gWx/JuC+9cCx3v7l5GrAxPiixGFpo5skozeaaEILZyPoTJnyTNneEs6oMNR/5rWE5TVPMNfFi+JPlNBw4FX87QBVZREjS6/m8aWQMiYvIeKnyzN2zTHp++KZDFopA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kGkpr/id; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9ggWa000389;
	Wed, 10 Sep 2025 16:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=usE6AP
	hO1XeGh0JSp0CVQeMXsXSY19U8rNAvahe15Qg=; b=kGkpr/idMqQYfPXVlID1Vk
	/TE958WbRE6qVoyXiJTtFiPGL1nwah2n4gXLGDUDcYCCM7GdESp677IjRI2uOlqW
	t/s4Df/1DwypLc+Na+AjMxauypovb/FpNAw7iwSloBBI+FyQKWRnDLpQiGNOd1fS
	NY1hBbLb1VgqQcb8XlxeshU4WzZdzk0C82hQA266WAFBbJNHgvns+OPICEZfaF6s
	HDm0w9FCWRiUBJJDw52RxeDzCTO+6o0bhdpn5L3IYtFl8bVSj4DPl+/lUGLebM7s
	uf6+hqkfVygdMuRiYA8et8WHtkPXdChjH9Ct/LH7eCOMG4E647JbTwxLhwwOQicQ
	==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr7315-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 16:23:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7bhgAR3hH8UF9kqsTrUHNmerIeMJznGPIvB5V5Hqot+a42BJpQ7o0v7XplQbXCiFpTiGvzbrgrYYL3nFdiEVQ0Q46ghafJKPboTFLREka/m74q9vHk9uMybC/tnnJNYlUbODXunYGldQed48CV/p7SUEAKa/oiGwbb9B8kW1bNyd+Q1EZ0mZS/sF/jjratDtiilwPC5wXR0i6djUnIzuMsP1ngOuWNj84A+b1W1XiO1Cervzy/Gbq4nUdxxhp0RLy8rAqYEs+dyznb5VgCbpgVjcUZM+Qz+qOUY46+x2ZblHSsZ/0mJPGaMLiCMLbr5Xege1idZcfmD0qVN/AvYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usE6APhO1XeGh0JSp0CVQeMXsXSY19U8rNAvahe15Qg=;
 b=Hfjq3KQ2Pv9BjHUPQa2nYPVlm45vG6BlIPkIpGTzE4i9KQfipSk7Qs/QWWNshHEyIaAWl7Mz4wpdFC0/7vV/6AJ03IV/upc5b5LhTCt3TVRTKN8f6WZGb6FjWPehpZLpPH7ZF266RcfeBebkVTaaJjkMTjdarcQhdCdiAKXIrG+Efo7aOHFOJ4g/BZUtVEy4FBAA6B787mNRAZr7K4uwIRmfY4/rIBTU1DIgxAxAXirYUuCgrSZylp1XJoNjYlKaghfXXvdicveiviioh52B7vOe9gAwGQ35CQsYfulipdo7lEGUiANJx1+AmLzC9u+QPLAnCsy3sjnbkRk1qIDAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by DM3PPF99786A2D1.namprd15.prod.outlook.com (2603:10b6:f:fc00::430) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 16:23:01 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:23:01 +0000
From: David Wilder <wilder@us.ibm.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jv@jvosburgh.net" <jv@jvosburgh.net>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v5 2/7] bonding: Adding extra_len
 field to struct bond_opt_value.
Thread-Index: AQHb9RJwiWGMTUSghkeROKI/Fitd1bSLL70AgAG7a58=
Date: Wed, 10 Sep 2025 16:23:00 +0000
Message-ID:
 <MW3PR15MB39134B21681849AFF5F1431AFA0EA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-3-wilder@us.ibm.com>
 <8c0b5b0a-60ee-4ed4-b439-11d5c106ac6e@redhat.com>
In-Reply-To: <8c0b5b0a-60ee-4ed4-b439-11d5c106ac6e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|DM3PPF99786A2D1:EE_
x-ms-office365-filtering-correlation-id: 0509c74b-8762-40fd-12c9-08ddf0864fb9
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2VvjWA4/9BRWLa8NNwcPQDaHp9uKylOMz8tgxT2/FtjMKMsxWNLLwTiQTv?=
 =?iso-8859-1?Q?JLZob9JNAEvPx4b3uknh3/7Vuf+dX753T0c6wUU4d1cFol3qh9Rcxn+GAP?=
 =?iso-8859-1?Q?UQxQ+EK1wz05/IetwAjy8gnNjVd4tPMsk2oq/MHeQP7S9mL2PZEoBTy7Y7?=
 =?iso-8859-1?Q?40940p090VVTiIvtoM1CfFl7lPEOoNOPWu6nnBJR1uattAQda+BVQ0zv2R?=
 =?iso-8859-1?Q?mza/rQGxaHNLrd5r0Xq53I1TxKRiOIsBmppRhlRI7siJuZqAb131NNNCwQ?=
 =?iso-8859-1?Q?Xm2WwBaC609RQPsG9JAkSeZi3qJfHhTupQkLoOX8qX4khjbhpGIgoCSAki?=
 =?iso-8859-1?Q?4lLC2Mmt6LWrHT76ETyTsJ7xGVQ27OtT56/WB3ZUhAVs2/pbuqpUgaAle1?=
 =?iso-8859-1?Q?A6Msllr+FDDufu5dkdQuo87zcxyHORpEbV9nwYURBb9uU8ZM7PRU+ioM4b?=
 =?iso-8859-1?Q?r3sluoxikyAUH+Z2BRsrlH2aip60S3QDeA45wD6D0Qk1Ats4hWoPWyZGQB?=
 =?iso-8859-1?Q?JLVG44Z3IPAAMI67AdWyTZ4Ve+sYtzF/f3FMpCh7TMx2192GO69yzDZwO2?=
 =?iso-8859-1?Q?wvqOzVN5Wcmu4eLVgQY33GrzHpVeJJIz6bsZErL6VPEW07lm0wwF6kp/WX?=
 =?iso-8859-1?Q?Kmz5VDKcH+CJxeWnM/LTSV8tezj6Upb7h8exQrfH8/HBSjxVpNlyyuMhEy?=
 =?iso-8859-1?Q?Zp0gnfcCsKRwP1hlRMiIHoOk1D4ovROwxSmmoBy/PyYzOu/uY/CuI2vFFl?=
 =?iso-8859-1?Q?ROed/L0b0X8hKPBbnF+NBagqClPOaGgTSEl+Qr899RGhttvOB5h3L28s7b?=
 =?iso-8859-1?Q?hnStU34GG3DtW1hKxd2DARjYdZo+/9+QsBFiivnq4RH+GTJ9neUrJ2PKvB?=
 =?iso-8859-1?Q?mcwG20QVURoCjF4BzkQzrA162q0gsTMTAXw+bYyGh77zpY0j9zPf4oSxTR?=
 =?iso-8859-1?Q?asMC2k8qkhQ5XyQx7u4iOSpJKykjCZb6B3Q4D7qlFjh1Z7Dti5mjizOOHC?=
 =?iso-8859-1?Q?0dyzAVMiICyljYT9GliwhJmHVQEvmHNkRk463F3xMH+6LwWqqG8H7CgwY/?=
 =?iso-8859-1?Q?y9OMc5R58C44wxqX7glBuPL0SIl1GIXyAvfB1hf/zL5pnkJhVf/pRCVY2j?=
 =?iso-8859-1?Q?IZD4DbkV+3bVRZrPoXjvTsYBhRnXlnljKbDWvLwrxdz8LBMF03E7UDJllm?=
 =?iso-8859-1?Q?RpN/M4AbFOfl+NSNgzoeDI7xn2OWKPcDPl7d2bqpEYV0MrjpTnKGmGbL90?=
 =?iso-8859-1?Q?Q/z+OTkDqjO3TdWORns0M22c0L9KR5JyFCMHN2TgvjBJHCDLmfHhodo7dw?=
 =?iso-8859-1?Q?Yk6TBBlmWPMVi8JcsRdJf9RzhZvmlufVOqTR1vwusBN9OXsHenWRKmTnaj?=
 =?iso-8859-1?Q?Trw6Hqr77XxaIyrKOZPACQl7hUzRvQB+pOk6nybc+0PJgMVTZ97eA8gDH/?=
 =?iso-8859-1?Q?22jYMOtMDUBPKuWsmFyYASuX8da6kCxKuUoOvzp3PDzCnbqA5bl6jRX2pd?=
 =?iso-8859-1?Q?LOkJZrjwXJ4pfUyAJzrYj9eT/UcWZ70OnHmlcqDFK0xA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rXIQSQL8LpYn4LqpATyQ5qX6WYDLkUE1XBzDYQFW2v3mrEpXefeNBd+Oqu?=
 =?iso-8859-1?Q?gAiIbPvauX4FQQ9GIC4WR33//KMXg3i3OJFJukDzNpeWQJnL/rEnTh1BkN?=
 =?iso-8859-1?Q?y0rJVXX6RKzpvC5zqO5E0U+RRjVy2749Wehjj4r/fTXDguuMFoUMcsyPj5?=
 =?iso-8859-1?Q?sJd2NwhS91I+fYWeGqo4eKp27aA0fx8LNullAtW412mbl07vLFxcM9gjOZ?=
 =?iso-8859-1?Q?adWZaQDiastGCDNg2dAE2MT87fIuGYI+4UE073Kw/GfBYEUe7EqH8I/2WW?=
 =?iso-8859-1?Q?ZNsRe6i016AtE2sLlAkWsNooYHK9HlNiHJwk6JlcXdRHbNrikmBLP1artk?=
 =?iso-8859-1?Q?CklOF1YABDRRVvq23M1bYjaQbZR/9n3zBOEi31PavYVMuVifhLVfmYkzDa?=
 =?iso-8859-1?Q?8/bG48JP+KBpSdzN5yLgNiUNr8Ebo9QMKahLDE1eOWErUI+4DbMBXMc1tn?=
 =?iso-8859-1?Q?YqdoggG7xIa5HXLWUJPv7/2E2BRTNDoL9vyOJJtMY0JNhHj5sT1pIJcayr?=
 =?iso-8859-1?Q?VribotZgwjPdLNDAJPzLbAzCXjbIpeqNtyaqiakLVfb5fSu3+5ZlZxAnEI?=
 =?iso-8859-1?Q?dkKUMLa9+2nsc8vrNpTNfMyzgNky/I3dWtGKXDibuW7YlsCr10g3sIMSD0?=
 =?iso-8859-1?Q?dgv4ksyGas5XFPynlPhH+901ushX/Ibz/eRZtc1gjjWywOVgSjuSMPXNO7?=
 =?iso-8859-1?Q?Kid3JYFX7gv5/Xu/BdbZEVEfskJQWwitQbup+MY7Mwt6VZR3vlwrmLkszR?=
 =?iso-8859-1?Q?b7FlhU6tDiljNAJ2Fzug5204JHk4mnkhcYcZNc1CcvhJtTdUbc6N8NX5tR?=
 =?iso-8859-1?Q?K1f9p9ZHitOJVwljeRHn1BWTzNruM8eyzIUkeUi8/hJDxjHvXacLG53+qg?=
 =?iso-8859-1?Q?AT2u7JluNJNDSO/ETG+VXMZ9vzDPqdgw8ko4bRZH/fPZbGOt0v4gWXF4eI?=
 =?iso-8859-1?Q?Bp42DLVj4plLw1PxzUAYwmXmKru9+UeFiDjQaHklpXF480W0XLqBMsO/AH?=
 =?iso-8859-1?Q?/Ozu1m/gdcsTUN+BP16re1YI5LEKpO/hCBGsYbBM8RPlqDwzWmKwb+M1JE?=
 =?iso-8859-1?Q?WAIzJ/VJq1+BoWhXLuRlYaNN3KSrORfPNhNslxIsp2luAhZPq4+AsCrWE9?=
 =?iso-8859-1?Q?Hq89/rlFVVzTDzngIPABR9hD95mJISwlVoyk5yR3nlWUsfaj9keZg7Qaw8?=
 =?iso-8859-1?Q?ll6DKRdHnxeQk7mDqeXxyYWXNwrVVDTaWuvfEkIxUxG8cZL4KBqe8z80Pi?=
 =?iso-8859-1?Q?8pM9h3UHwtexN6q8aMdVyorS7LeWMtG71vov5siMQognThuwKvkg+p44Qa?=
 =?iso-8859-1?Q?yqEdNlFWHJgOtV7K6T+uy0L5Plx2O6FwcPwCLwJtCLr0ky5QWwjOPorTVP?=
 =?iso-8859-1?Q?zdLSX3P0NGyUxpopFk3/L56Rp64VjcYkp9V+bQAuYcZe1+rqHGdpbfKFtU?=
 =?iso-8859-1?Q?CJajQuaA6ZcKb+wU6y99+QEtguZDPr+HXiJnjNdHc34Uekti1z344GXGoX?=
 =?iso-8859-1?Q?uWnTb1AXNElzzkcb94mYOJbtkMc0+X7GJwSH6iKWmx/CubTprXsKdnyRG1?=
 =?iso-8859-1?Q?CyQVrCrPNZynHzHqpH3jOo0LtaucGUrfSiGT9RY+fQhOm/XSo1vHBRbMFj?=
 =?iso-8859-1?Q?0kDgJeJjPvidaMNV1Qsa4GMV3gXTX2GEFO4RSuGrL8bJw3qmTkSE8qPg17?=
 =?iso-8859-1?Q?7of4P8ZdeuJdJKQJMt8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0509c74b-8762-40fd-12c9-08ddf0864fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 16:23:00.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e636+467ekdHwu9b3yCNNlRd8UEOLD6RvvP8dHyQSmO6x5QfVQZrs5gurlqEAWyXufCqL/W3+8cIihYQOxVZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF99786A2D1
X-Proofpoint-GUID: R_mC5JjoRo3G2FcNva1cMSQZRUlQY6eA
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c1a5ea cx=c_pps
 a=M0FciYcAf0Byp7bZVsDZ2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8
 a=P8mRVJMrAAAA:8 a=wEIICEw4zELclUKyJzQA:9 a=wPNLvfGTeEIA:10
 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
X-Proofpoint-ORIG-GUID: R_mC5JjoRo3G2FcNva1cMSQZRUlQY6eA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXxDnZNgjiNh/R
 nY8NgC2zdVS5flhLNAIXjS4e7wPBlPBC6MGv0DguetaeXgGwNVbLqopaH1TUjA/4kIEJNpzV9Oj
 GXEfsQCQbkZ/outP+cpSj/Po0RWnSSP1NsGnh4uol3jeb4nlyaoXHKMf62NV3kSLlrwpnwYP5DZ
 FL8hUkyxwWsN+Bwi38NdaXtcegreI0PMMD0sZlM8jnDbX9yauBF62qzQvRh5PUsNrVT+OKKGzVC
 y8YpBVQbuaDsXdmuAiXXBuMxh2cMOsWE8s3T5qQaoro9NXdMp39fpLH5vOzZFNkO89UTLay2KJo
 tfrQ1YSFjsbtHB1M35uhsyMIguyuBESxv9s1vNwE51UoG69JSil2MGR2BRS3FaKm5sDwZSuwY7h
 bleN6NTu
Subject: RE: [PATCH net-next v5 2/7] bonding: Adding extra_len field to struct
 bond_opt_value.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

=0A=
=0A=
=0A=
________________________________________=0A=
From: Paolo Abeni =0A=
Sent: Tuesday, September 9, 2025 6:23 AM=0A=
To: David Wilder; netdev@vger.kernel.org=0A=
Cc: jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i=
.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v5 2/7] bonding: Adding extra_len f=
ield to struct bond_opt_value.=0A=
=0A=
 On 7/15/25 12:54 AM, David Wilder wrote:=0A=
> > Used to record the size of the extra array.=0A=
> >=0A=
> > __bond_opt_init() is updated to set extra_len.=0A=
> > BOND_OPT_EXTRA_MAXLEN is increased from 16 to 64.=0A=
>=0A=
> Why 64? AFAICS it will still not allow fitting BOND_MAX_ARP_TARGETS in a=
=0A=
> single buffer, and later code will try to do that.=0A=
>=0A=
> /P=0A=
=0A=
No need to fit an entire BOND_MAX_ARP_TARGETS entries here.=0A=
IFLA_BOND_ARP_IP_TARGET is a nested attribute, only a single entry=0A=
at a time in this buffer. One ipv4 address + 5 struct bond_vlan_tag.=0A=
32 bytes would be enough but I am planning for ns_ip6_target changes.=0A=
and I am paranoid :)=0A=
=0A=
David Wilder=0A=
=0A=

