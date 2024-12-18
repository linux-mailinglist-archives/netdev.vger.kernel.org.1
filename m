Return-Path: <netdev+bounces-152837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF149F5E6A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 07:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5727C188C0A7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 06:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FAF15382E;
	Wed, 18 Dec 2024 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WCXl/bo4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C14191;
	Wed, 18 Dec 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501828; cv=fail; b=GLSvcZY4/7crv3X1yBbEmOIuvLKSkkz95sG3A1ShSqOBblksilupgWRo0sMb9iUimQOtmfJkFgGc6Hw29Jbd+PQ6foc8ZLCA8vGBxN+xj6/cC7W1V9ofwjk10OlHFCu4J1P9KkkcbgX+rxQfOfi6BxCuAwRsFERq3p3IW2ACgGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501828; c=relaxed/simple;
	bh=8zk63dz9S+3+rWaLjiWg0O3EQIED7XB2NwlFlakhj88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BIwxYvCxvcrNr6XMrW+3ZEBZWzv6Apn7gMjp8ejgvrB4WlAhcYCJ0+ZFbv11eTU6M1vK+4LA+po4DFzRKM5b6ZXjbJ6rOjIhZW38XGtk+R63nQJp04lblPK1a3k6x4DBoEwkfuvx9b/KM/A/Tgp7qJ5A9Zhq1K6lXq8fnF/mvP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WCXl/bo4; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI5JDvh009247;
	Tue, 17 Dec 2024 22:03:18 -0800
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43kqug83ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 22:03:17 -0800 (PST)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BI63Hvb015493;
	Tue, 17 Dec 2024 22:03:17 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43kqug83ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 22:03:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEk1SNqE0mf3ljASwhLWup4zCEHkk9q6/L3yDk8pOeO4W1j1uxVHJfjMXtNw8SRAfwrg2PVhacL7P/pD072cHuWpFXHNmPhS4XawnNXltnvPBkAVyzl/K0/ntBvFffanD03X9cdOnnR8kC0AT+Z56cIaCZd2cozrJ9jcLYieEXV84X/BNJj+HDQ7dmizHRHByex7BdNQqMZqdvoGbkrdeFIeJv9JBXZljBoEP5jLvHfCRFHzZd1C7kin3KtOIDwsnQUWeLq9RU0raRi6t6l3vuHpFynXcfZFObTGst7JdCiplcLHrVpaQJjf/jxLqdKvlstxJOrN/KqwlA4QNiJwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zk63dz9S+3+rWaLjiWg0O3EQIED7XB2NwlFlakhj88=;
 b=jINMMSIqjc1MSjHcBPaMtnkLDSBhWz1G9RNiyk9nx7EAEdSBS+eqocHUlDT67Q0Zg1mPIQUixZ3CwMRVjWYKBYI47bJGgLM2dLWjfI0h4TmvTWUx88IrmBpHFb5XtFFpAbHGM6yrqrHon4f/66L2FHaPw6QW+obFriWzpySYNpqEBQmOxpIuafk3cxe6B5tNWgcSe20kAx8lxf8hJ7NzKZs092w6MNoAoxHVcqEL+QrOAKxw68NIAfgdUuxUNlUMhNsmUfaGUat4JxdCrLIsL5inrN5OPJelufC/N/2WcEDddkznmLU0fK6fxSS3ey+HsZHDGxdKhcCRfkorY6YM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zk63dz9S+3+rWaLjiWg0O3EQIED7XB2NwlFlakhj88=;
 b=WCXl/bo4Ikysee1uqKXmLg/roXz3EUWVY0YpHzGSjaE3P6NX4Vgwe4BNTEB83NQzNOXmG1NdtYmNuyOqA+PfK6PW+F2pTIRybeemKr++dbSgVsvgmgOSV5W+UAvUUYxXPnsrOCbVYFIArySaZ1GSskeBIURJT76vC7ZynIGHABU=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH7PR18MB5180.namprd18.prod.outlook.com (2603:10b6:510:15a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 06:03:14 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 06:03:14 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "error27@gmail.com" <error27@gmail.com>,
        Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
Subject: RE: [EXTERNAL] [PATCH net v2 1/2] octeontx2-pf: fix netdev memory
 leak in rvu_rep_create()
Thread-Topic: [EXTERNAL] [PATCH net v2 1/2] octeontx2-pf: fix netdev memory
 leak in rvu_rep_create()
Thread-Index: AQHbUEPdJ9B7bjzYeUirssZrsMPMNLLrhCbg
Date: Wed, 18 Dec 2024 06:03:14 +0000
Message-ID:
 <CH0PR18MB4339046C2D3690FB297B093DCD052@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH7PR18MB5180:EE_
x-ms-office365-filtering-correlation-id: b3948f0c-f015-45c0-b9b3-08dd1f29a8c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDgvSW05ZFNDREFZNWFyQ21xdTM2K2cvZjhHeXJGN3l6bzVRUTQ2VldjcFJE?=
 =?utf-8?B?UDh0aFYxNG1qa1N3TTZvVGhUQ0VGVzhHK0xYTWRoYVpTSzZoclNPN3RYcXVh?=
 =?utf-8?B?Z2VBOWhMWm9wSFBjUUNta2RzdVJNVm1KaWZGMHd3NE5rZE5iUERxWkh0Nkl2?=
 =?utf-8?B?R2lFM3VwdVNzVTVHa0dlSW1iVjh4ZzFsakhiVEl4aDJIc0J5ZjVFOEQwb1hG?=
 =?utf-8?B?UmUybVRUR3lYQVZSRmNLMkdwYXRKTnhMc0Nqb0hWYXZTUkk1cFM4dDhVUDRI?=
 =?utf-8?B?UEVvdHg3RFNQaEIwdDZGN29OMjBGaUg3Wm02anN6c0RDY1dRYUtSQVVMMzNY?=
 =?utf-8?B?MUtiRElpejVsVVNmejc0UG41cmxwNXVRN25OUGZYaDRRdkF2NEVWaWFxby9y?=
 =?utf-8?B?YUNOeU1JVXlKL1JjdVFiSmVjeXAxcmlOQUF6Rld2ZGNUTDB6bS82bEV0S3U5?=
 =?utf-8?B?Z1F3T2h3TXdnQnozc2srTTFrREJVNjZJaHd2ZUFhSDVBenhZdWdZamlOMXB1?=
 =?utf-8?B?RnRnZ3FQSmxKVk9HWkNjbkowTldyRjJreSt5WmNzZmpJR1RNN1ZXbXlsRG5s?=
 =?utf-8?B?TE9mdllhaHU0Skl2dFFIVlQ2VGljNkxLcDhmV3R3Zm9qTjVVUkFlZUhsVFhB?=
 =?utf-8?B?TkZGQkI4R09iTDQzdmJTRG1DQ1lVN0F1RG85cFU3UGd5VFV6YjVLL0xkaGJ3?=
 =?utf-8?B?RXNSNjlQWk1seTFOMGE1ZkFjVkFFZHFmZ2V2bE1DVGtwR0ZJam1nMFRyQkFJ?=
 =?utf-8?B?cFZEVTBiaVRKTU5ST3dvYUxQa3FwMW9mK3RVZjlqem5xWlU1c1liVTBIRFc0?=
 =?utf-8?B?cEc3S20zNm5lZ2Jjc2RGRC9DWnJ3eFFvNmwybmI4Zlh1SE1wd3N0YnlQTTgy?=
 =?utf-8?B?dTJSRTVlN1FTQ3ZZTjMrYjFzMlJQNDFVWE9oUUhoL2FwbnlIMUVwSW1KMTJZ?=
 =?utf-8?B?ZytQVUQ0clVGd2M5bVlZY1dIblU0dUpyK2c1L01uOU1wK24xdEovYkdpRTdB?=
 =?utf-8?B?WUJZYXFWUktuUkU3NlRZamM5VDE2RlAycW8zYlRQRElqc0xtaXJwWU16L0Nh?=
 =?utf-8?B?WTlIRXVYQTU2dU5PcGRXS3pJUHFzRWNHMk5kVTFaL2RkbW8wY0dpdW5tR2p6?=
 =?utf-8?B?SzlNdXlwdmY1eGJaYWxpbGFzUnkzZXpjSXdDQmdZeXVoaU1sZlM1N0creGRH?=
 =?utf-8?B?dyticUYrY0RVU1p2Z3hIc3hWelpZd3N0Rll5MVB1anhnWkxIS3JuYWJvN1RZ?=
 =?utf-8?B?Y0EreUlpWDJyMGxKODA5ekxxeFNLaHdpdEsxNU1iWmMzQnY2U0FTbm95WE9o?=
 =?utf-8?B?bzJlckJsSHhWWG54NUthd21VM0J0UUdQTnpYUHBPZlExam1GOWUvVElmV2Nx?=
 =?utf-8?B?M205RWY4TlJZUk9ZOWtxM3ZQZzBJUHlOSVk2NG1FY3NzZVI2VXE1ckpWc1Mw?=
 =?utf-8?B?aDFUL21pQUt5Y2xEbGplZXMyMTFGRTFRd0V0RzVjWVc3ZHVQZ1MyMndrUURh?=
 =?utf-8?B?MGs5N2YxV0VxK1F2TzgrQnp1Z1VhMDVQcmdST0FaLzVnUVZDak9GbzdtYWxD?=
 =?utf-8?B?L04rZ0Zrclg1cnlYNy9ackxGRWtjc0VTSktmUkFIc0tXSmhhWjJ2WUNBY1g1?=
 =?utf-8?B?V2szN3FnVjgxRENOZ1BSMUJ6WktFMzR2WW1NMXRENkRvbGY4aEIwLzMxaFBB?=
 =?utf-8?B?b3d5VXNZdDRkVTlNaGh1dHBTQURMUC9YY08veHljRFlmMTlyQzhSZlFNaDBZ?=
 =?utf-8?B?VTVnMUFOaERaeUsxU0hIcklLR0VoOGtNVmcvM285ZDI1clBlVEdPYnRQbFFF?=
 =?utf-8?B?WUFMT21zSFFEODk4dTNZMnJXUGRmUUx1cFhLWTJTeEM5YUtja0N6Rk01aytK?=
 =?utf-8?B?VW9hWm1HcUx4ek9nYURORHptNWtjSTZpT3Zoa2VrczVYY3NSS0RYZ2d4M1pJ?=
 =?utf-8?B?cHdwWjM2TVBDbkdnOFNHdW90VUNaQWRNejU2dEdjdlRSa2s2dWE4V1NFMEdB?=
 =?utf-8?B?TW5MM21kVCt3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGNWV09UZ2g0UFp5WXJKWWxPQzdxYnZKdzMwOWt2MHZKeUU1cVB6bHM0eS82?=
 =?utf-8?B?eG50RE0vQ1pLYVg0bWs4SHBodWRWVnliODIyQVR6Ull0U1dJbzlUSTRjUlNi?=
 =?utf-8?B?cE1vYzduTFAybWlSMXdDMnJPdytvSzk0Q3lhS0phZ2J5djBDRGwzM0pjNDAw?=
 =?utf-8?B?ZnVuZjh3QUozZFZwc3RhdUxvSWhBU2tOVTFBRjVuaHZxUmlENU5XUE02QXl1?=
 =?utf-8?B?YXhGMDd2U2FuS1RVbjhobDlZbVQ4VWpvSlZDYVVVY2hvUDFjcDRSM0p4UnVB?=
 =?utf-8?B?by9Ic2QzRW5LOVVLcXFQN0JIMkFTcnFqUzRhSjc1SlhlT1pyQzZDNkJkV3Fm?=
 =?utf-8?B?blJoUUtVR2c0TWhEbWp1UFFLR0ZWejhpOGQxcXU3NlQ4cWE0LzNrajdpNklI?=
 =?utf-8?B?MEVEN3BJd20zVXRxOW1FVlgzUkN5VmtScnZCTDluSFZaaFZaT21CK1htVmJx?=
 =?utf-8?B?RVVVQktDS1dGU0tuOTAvSStSTTEvYkZIQVE3b056bHlvRnJ4Z1UvQ25jQ2p5?=
 =?utf-8?B?Umw5T2hPMHdiZWwreFM4UCt6MUdwaWxHeEtZT1hTMnRoampTU3VraHZ6dDRV?=
 =?utf-8?B?alZQV3d4ZklhVmFFQjZiYTVMbnV2NEpKTi85TjNFZTYreVVRbStvNktnd0hz?=
 =?utf-8?B?Zkx1azlubk55dHBPcHJTR20yY215T2lCclp4RDdnWllEMDlVMlo3bTlpL3hV?=
 =?utf-8?B?bWhWbU0ydlRra3NlV25hcERnb0VCN1hDOEhYMzYweWpvQTkzTEh4ZzlyRE5U?=
 =?utf-8?B?cW1UYzJveXBsK3k4QmpPVHk1SG5KMTVvMVdzUEZxZGlHRUpVQ3RtbE96ejMz?=
 =?utf-8?B?RWxzTlE2UkkrY1hPR0xWL1dSL3pPMENYNzFTWjczbGRSamtZclpleW9LMXVX?=
 =?utf-8?B?TG5GQ1oyWTg4blV1MXEyQ2JYNFljZjBSWjN2YTFxZzk3SkN0RHhoZnhhc29s?=
 =?utf-8?B?WENXN0RSTExDaCtLWUNFSjd0aEQ2QzRYMms0ODJzQlYzMDhHRGdKdFBqWFJi?=
 =?utf-8?B?NllyZmRnL2JoL3h5SjZOVGk3ci9pcWgvNVZGSjZGNUJwTHB2UGc3aDdJWlJP?=
 =?utf-8?B?ckZQbmJMQzMvWlpvaVloaTVYRnpyN3NEM29ORUxyRm9VTnpFYnBualEvb0tr?=
 =?utf-8?B?dmxtd29mb2drZ1BCOVBOL2lNa1c5VjdwUnFsb3hBRXFiZ1pWb090bFBzZ0NP?=
 =?utf-8?B?MHIxNmFiaXNIb1lwbDdndEFyZzl2Qmk2VlZ0bWdkQVUwRVJJNHh3cHh0ZWp0?=
 =?utf-8?B?V080ejFDNHd0YzZ2R0RyUit6a1JRRWpMMTdVSDg1L0JTQ0NHSWFOS3ZlMmRu?=
 =?utf-8?B?aHQ1aGdLWVpqSUJpbmN6R3NVZ0lCMnNWUTZ2aW1tczVDcEdLNTJZL3ROUGNX?=
 =?utf-8?B?dEFVclF1SnNJeStXSmdmQklqazVoaXJpbUdhM3ZhUnhuQkd0RmMzMXJ0WFFJ?=
 =?utf-8?B?ZldzVUtid214b0JUS0lvOTJWbDJrajZ4UGxGVWFKNWI1bDZGTTBsbzdIZWly?=
 =?utf-8?B?a3RGNEl6MEJNVGxZUEgwRDQvYU9uUVVCVVpKajg3TlFpdHNSeFRzWWxnRWhl?=
 =?utf-8?B?TW05RGNiZlc1eDRxZHp3TUFZSkZvTTNIcFQ4TllEWFBmSmo4WWZraUhFNEtj?=
 =?utf-8?B?UFBnWVhMbUJuUUpmdGdpVk1PdVdwUXpFUFNIS3oyWG15dmZrNlppcElhYk1L?=
 =?utf-8?B?SFhDenpLNklJVzEzRG9WT052c29JM1p1eTJ5YkhkTTQ1YmhKK0xwNTUwQ2xr?=
 =?utf-8?B?R0tBU1YzUENWU1prY2trc2RqR3N1ckRjWm1OT283Y0Q3UHc5NjVCam51ZjZ0?=
 =?utf-8?B?a3ZBQVZPNWxmY2dweUpsUnNkZlZ6c0lFcmc2YjlXa3Ria3V6UkRBMUoxK0VC?=
 =?utf-8?B?K3JZeXpWa05tTkwwdzY5Qy81WlpUcS9YdE5pbUROM0NZUm9yNlFWbVJNOUhu?=
 =?utf-8?B?YW9YdG5PQ2E1aDA2eDNlM2xkenFDMmNIdzNhcloxZ055TS9hdUpFMnQzM1hZ?=
 =?utf-8?B?SFBVTlpka0hDMlk5bTFXVm9wcDhwQ2hQeTR6Vm5EM3dXcVl4M3d5Yzh6Zjd2?=
 =?utf-8?B?bFcycXFjMzNsYkRuODVDOFArNG5ndFRQL3luTnZRRzdiTmlqeUoyTDl3QUl6?=
 =?utf-8?B?T3FoWU5KZnk2aUNlK0VRTGROUUdiNlptWHVtVHhCN0U1UnhWWHhYeWdja0sw?=
 =?utf-8?Q?K+HfhLwRfyo9QKyz1uX44Kdu2CINxS1nMYMuO+hSc/kk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3948f0c-f015-45c0-b9b3-08dd1f29a8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 06:03:14.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VcdTiVzV9s8kggSc7kuwMLus+oYdlK3JPZQWctmaRclewm1AEOAxtHL0mRShFePIUgZMg/sBzNTIVddWry7D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5180
X-Proofpoint-ORIG-GUID: EWIIJ69PKcPLUe5eldV4BUdBusOIW1xD
X-Proofpoint-GUID: E9GWeJ0vorV909YUrdYKGHZw6SO6do-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEhhcnNoaXQgTW9nYWxhcGFs
bGkgPGhhcnNoaXQubS5tb2dhbGFwYWxsaUBvcmFjbGUuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIERl
Y2VtYmVyIDE3LCAyMDI0IDEwOjUzIEFNDQo+VG86IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dv
dXRoYW1AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YSBBa3VsYQ0KPjxnYWt1bGFAbWFydmVs
bC5jb20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+Ow0K
PkhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47IEJoYXJhdCBCaHVzaGFuDQo+
PGJiaHVzaGFuMkBtYXJ2ZWxsLmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2g+OyBEYXZpZA0KPlMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpl
dCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uDQo+SG9ybWFuIDxob3Jt
c0BrZXJuZWwub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+a2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPkNjOiBkYW4uY2FycGVudGVyQGxpbmFyby5vcmc7IGtlcm5lbC1qYW5p
dG9yc0B2Z2VyLmtlcm5lbC5vcmc7DQo+ZXJyb3IyN0BnbWFpbC5jb207IGhhcnNoaXQubS5tb2dh
bGFwYWxsaUBvcmFjbGUuY29tOyBQcnplbWVrIEtpdHN6ZWwNCj48cHJ6ZW15c2xhdy5raXRzemVs
QGludGVsLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBuZXQgdjIgMS8yXSBvY3Rl
b250eDItcGY6IGZpeCBuZXRkZXYgbWVtb3J5IGxlYWsNCj5pbiBydnVfcmVwX2NyZWF0ZSgpDQo+
DQo+V2hlbiBydnVfcmVwX2RldmxpbmtfcG9ydF9yZWdpc3RlcigpIGZhaWxzLCBmcmVlX25ldGRl
dihuZGV2KSBmb3IgdGhpcw0KPmluY29tcGxldGUgaXRlcmF0aW9uIGJlZm9yZSBnb2luZyB0byAi
ZXhpdDoiIGxhYmVsLg0KPg0KPkZpeGVzOiA5ZWQwMzQzZjU2MWUgKCJvY3Rlb250eDItcGY6IEFk
ZCBkZXZsaW5rIHBvcnQgc3VwcG9ydCIpDQo+UmV2aWV3ZWQtYnk6IFByemVtZWsgS2l0c3plbCA8
cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBIYXJzaGl0IE1v
Z2FsYXBhbGxpIDxoYXJzaGl0Lm0ubW9nYWxhcGFsbGlAb3JhY2xlLmNvbT4NCj4tLS0NCj52MS0t
PnYyOiBDaGFuZ2UgdGhlIEZpeGVzIHRhZyB0byB0aGUgY29ycmVjdCBvbmUgYXMgcG9pbnRlZCBv
dXQgYnkNCj52MS0tPlByemVtZWsNCj4tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvbmljL3JlcC5jIHwgNCArKystDQo+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL3JlcC5jDQo+Yi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVwLmMNCj5pbmRleCAyMzJiMTA3NDBjMTMuLjllM2Zj
YmFlNWRlZSAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi9uaWMvcmVwLmMNCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi9uaWMvcmVwLmMNCj5AQCAtNjgwLDggKzY4MCwxMCBAQCBpbnQgcnZ1X3JlcF9jcmVhdGUo
c3RydWN0IG90eDJfbmljICpwcml2LCBzdHJ1Y3QNCj5uZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykN
Cj4gCQluZGV2LT5mZWF0dXJlcyB8PSBuZGV2LT5od19mZWF0dXJlczsNCj4gCQlldGhfaHdfYWRk
cl9yYW5kb20obmRldik7DQo+IAkJZXJyID0gcnZ1X3JlcF9kZXZsaW5rX3BvcnRfcmVnaXN0ZXIo
cmVwKTsNCj4tCQlpZiAoZXJyKQ0KPisJCWlmIChlcnIpIHsNCj4rCQkJZnJlZV9uZXRkZXYobmRl
dik7DQo+IAkJCWdvdG8gZXhpdDsNCj4rCQl9DQo+DQo+IAkJU0VUX05FVERFVl9ERVZMSU5LX1BP
UlQobmRldiwgJnJlcC0+ZGxfcG9ydCk7DQo+IAkJZXJyID0gcmVnaXN0ZXJfbmV0ZGV2KG5kZXYp
Ow0KPi0tDQo+Mi40Ni4wDQpBY2suIFRoYW5rcyBmb3IgdGhlIGZpeC4NCg0KDQo=

