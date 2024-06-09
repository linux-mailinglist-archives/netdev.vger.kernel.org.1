Return-Path: <netdev+bounces-102110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53283901759
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A47428144B
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CF47781;
	Sun,  9 Jun 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jCI+jY2E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I4rKW1du"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA363C7
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717956500; cv=fail; b=V+mrff0PWWtWjbJ70J0BaobXUBLnbxy0ckRQ/j1P4tIUMl7k9Ng6gYHATvwefQQB3R5igFyx3o28FWt7/Rt6ziOOD4Wff/ZEHcW5lLe01rYVPWPoJIu1Y9JH1HrIPSQJurULzyaOdu50MdAH0eS1ElTECCd+f8yOlR3OP8Oyx0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717956500; c=relaxed/simple;
	bh=y1vm/KDTqdZVseCr8Vor2fh0/gQ18Fz3q6q6ngb9860=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gnd5q6iUrgeJVZKx7b1/Lw4M3MpChWNUxt+yaXMowCTAqM69i7LC4C3th0FQEZSThjrNgTFPbWA0r1cFOHzqKzvzYys/xEfD1JKEwvbs81VCJ/8UgePmpiQpN3CgpmkGl1oFExvmS+kkuImQoPVCztyZyp9AWP61XVaK8GR8XFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jCI+jY2E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I4rKW1du; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459ClOqf023918;
	Sun, 9 Jun 2024 18:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=y1vm/KDTqdZVseCr8Vor2fh0/gQ18Fz3q6q6ngb98
	60=; b=jCI+jY2EpP5m9F7BQFAaBWN5kv6o7xXZQ8fI4iUIJVgZqJCv+msjKxNNY
	+q+GyteBvQjk/lIkeKXqsq+AH5gh09n063giK7LK/9Tf63Hjof5LhhpDS4M/+IeT
	MZ/hETYPWyhDFeWk1NtPrrEsqfCMD4lqcI+rN+w0P3hLvnK/OMj0qeZDW3Q2mRwX
	UQ4ZNUCl+61M6PqEyK5WX7/oJy2FoW30JeS4g5aT4QQLE95yLMi+dUlYx4PTxlHK
	eK0LD4rMTDR+yFVVBLUz/oqkx8JInicfzEEM1UAzmEzBrs4kBd/ORraGo1xDNKP3
	j2zzSOQHrdip8bdVbszlgDQvkMfxg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dhb3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 459GwNJ9012449;
	Sun, 9 Jun 2024 18:08:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9udxpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em4sV2RKDuxDq1mlkpGATdYssHLMFDLxP091U5oFixlef5oFN/soPCercPWZS2Wvd5ubbIdFUcc2xO0cxvVqNvSOHSPtDKaAICDJCnn5+SIshjTylP9RuW3ouo6jnVzjfDfhBjEwo80sFzsDKp2Su8rmBUh5MC2Za8dZMuZEynEKXa8XvxUU2Z/2vnNFMte+dd1Pnms6R1loy+YJ2hbeHZme3WhJ/6BnxGOweRd53VQt9+VWC5ZYRfo4NQuRTMeLNLpoJGu1r6WMZ//LPQFE9PMrI0Rj8LdlsqOVPX4kG9SdNir6h+4nUvDiHIEzsg7TbMdPZplQ4FYFVo/o+N87ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1vm/KDTqdZVseCr8Vor2fh0/gQ18Fz3q6q6ngb9860=;
 b=XCSnaUeRa9ivegnsv46KY0L7DGXKIqQohAQx+jiWek8sUFPNqvbjlv/UNgm23sbVe6TmfrDmseaBUxXHAa3rF+uuA37ZQarJmrKmWZOvl2fKjPuqqGUjEX1w5erS9FHHN5BmMftgO7Quu8nzpOH5xU6RLzCG5knJxDu1ihoAREfUwZ9rNVgUxFzlXfGOwKrOPCfX6djbT4I+ueMV+bSehSaQiqUaKAG5iXliaSNemIo1wNp+VhypnX3yTh7lafO4RBrznsXFH9yPbgkdRwH4CVriOEbMgzpz2kG/cdA3S/e6e2f4gt8OYFSSIoW0Tc29eI2R0DsKgn9SZG3cKo74+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1vm/KDTqdZVseCr8Vor2fh0/gQ18Fz3q6q6ngb9860=;
 b=I4rKW1du1PN5OF16PG5pSCRRed6aDvjIYW6EqXF7bb+XdX6EnIsqAGA7EGLXtkfnSIDdi4FTPL/v0LwD4T7C97gtUWCzx0xolVchgkHGog3tHCdz8K9dX29wjOCvsHyGBPCEwpcx1db0tTVKzvuB93qzSKkqHDCTCypMAdqRy3I=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Sun, 9 Jun
 2024 18:08:12 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 18:08:12 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Vegard Nossum
	<vegard.nossum@oracle.com>,
        "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [RFC net-next 0/3] selftests: rds selftest
Thread-Topic: [RFC net-next 0/3] selftests: rds selftest
Thread-Index: AQHauHK+4vD6CxMIw0i0xqv/V180rrG/vxSA
Date: Sun, 9 Jun 2024 18:08:12 +0000
Message-ID: <c03b8bf87f6a1a1c19647832db0e3fa294eec773.camel@oracle.com>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
In-Reply-To: <20240607003631.32484-1-allison.henderson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SJ0PR10MB7691:EE_
x-ms-office365-filtering-correlation-id: 566feb89-1861-46bb-1f47-08dc88af202f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MkxDRHRqbldpSUxOWnViVCt3MGg5cDM0bUY5cEk1ZkZ2SmdOZ1JWd2h3ZUc2?=
 =?utf-8?B?dmw4eUlsVHhOSFIwUDF1WG5CUDc3Zloxb2NWUzNzMFNGbFFTVThnUm1EZkty?=
 =?utf-8?B?bWRJdjEwQVBkM0U0S2Y4QWFPREJpVU9BWFk1bTQvczZ2ekV1TG1hN3NiSWJ6?=
 =?utf-8?B?ZHVMekwvcmoyeTkycFVhVXIrRDdwTHE2T21mS0NSY2Z2UmE0aWxYSFY0VGRo?=
 =?utf-8?B?bmdJTy9ISldDWlpMMUkzRWNiMHhyZG5OMnlyWk5abVdtS3Y4RDhIcXBUUUtP?=
 =?utf-8?B?MFJ1R05HQUJUcTR2cm96L2RoUXQ4UXJiT3pmb2ZSWVJyKy9Hc09CVko0aHdX?=
 =?utf-8?B?N080eERjSExmK1dtazlnRUlESWlKR2lkODNicE43WnR3ZUQ3N1d1U1FySUxD?=
 =?utf-8?B?QmpjSkV2WkJQeVVoR2JsMzB6bllBa0tKek1TRUprQnFuUFNVKzV3UHVoOXJV?=
 =?utf-8?B?ZE8rWkhZa0tOMTRHWE1xNlJJcU1ja3BYS2EvZ3RTemRwVFkxSWpla0RjVjF1?=
 =?utf-8?B?UFVGdnBsMG14MStKS3pVZnBhSEk5RXlMa0JTU2ZnQno5R0lvdEcrTkQ5ZGlZ?=
 =?utf-8?B?M0hlNUlrWVpPQVRydlVBbDAxaEtZY21WLzlSNXBhTmNTSDE3QmltYjhkeUhz?=
 =?utf-8?B?MWlFRjY2eGw3alRxZ1Y3Y0p5NnBZZjdUSmRBWSt0SGJkMW96bDh3ODMvWG55?=
 =?utf-8?B?VG51VDMvMlVtR0VVakFKTlBZZHRHMU5jMGhqNWgvdE5kWHVrSFAwOFFoaVNX?=
 =?utf-8?B?WmlKYkhyRlptaENxcW1vRGRZWS96aDRtcDlIdnFaZUZteW5QMnVsMWNFQmJn?=
 =?utf-8?B?T21NOVJLOGZEQTN4L2F0bWtsWWd3d1Fvb3pkcE5GbjBRR3RZejkyU1Z3Mis0?=
 =?utf-8?B?SStWdlBHN0J2T3FVT3pmRnhKcFVKdWQxZk1QQVY0MjQrR1lEeUF6amQxREpw?=
 =?utf-8?B?ODNsbmp4VGtCaDduQWZjdHE2NWtxcFNVUnM1dlFCMVhTOFhPSFdXRUd1Q0R0?=
 =?utf-8?B?VG9oQ0hDYzRsNHhNaEtJRVF3MkNGTHNxajlEMmpKVk9SYlo5b3d4eTBYUzY3?=
 =?utf-8?B?OVY1VWxJam1zVWpOWFBHTXJUQ2JnbTRobGdXUjZnb0xXYlluNjdKSmxMNTY1?=
 =?utf-8?B?TlRjV1MvWjJDbEZpVVJzRW9jeW1zNS9HeEpjbk9nMVpFYXhxTjVYVUVEbG5J?=
 =?utf-8?B?TFhUdCtRaXNmTTJ1enczRkxpc3FhNWxMazBjRU1lNncvQ2FGVDM3RHhXRXBN?=
 =?utf-8?B?SWRWL0ZMTTR3cm4vcW1jS3lWektqM01LWm0yWkg1NWJaUUtkVjR1NzFyZUVh?=
 =?utf-8?B?TmR1YUlqTXA3VzZmdEk2S2RkRmhLbDRvYzVWTG1tcmh4ZGxCWE1wUURDTTgz?=
 =?utf-8?B?V0Vhdkt0SjZKWlcxcjh0dHZyc0MvWFovMU1DZ09NVnJQWXRTOU4vQXZKRTNH?=
 =?utf-8?B?Mno2K3lTcTg2dnhhdkVEM0dXcUVGUUFzNHVFSjJycEZPQ2M3RlhCVWNldW5Q?=
 =?utf-8?B?dkRjSXc2N0JoeXRtZmtnUWh1OEJwZEIxOExXa25lYy81NUM2elF5K2xLbjdT?=
 =?utf-8?B?NE05ZnQ5NHQxMUlNZnJaTElkUmU0RWxKWkE5MXExTy9XMDZRWkhqcy8zYUhL?=
 =?utf-8?B?WlNHdW00TEdxL2haNzNkQllneEdwWGUwUFB1bWtORmxsaGZ2THh1Q0F3cWNU?=
 =?utf-8?B?dE9PMGtHSTBaUktMSWtBM0lEVmR1MitKSzY4M1d4eDJ6MWtISm15bFQ0d0ZF?=
 =?utf-8?B?azRsQUh6d3d1dCtzSit3L3V2NWRQTjJ3VmRxTkp2clV2dnlFbXFsb2p2SHRz?=
 =?utf-8?Q?3VXmpqTfU8pCPIad2W4Ujx8WsaNl/uxxP+CQI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YWZuKzNObU0veVpuR3NCSjlYQUw4a3F1eXljZ2dMVlpsd0R0YzJaeG1nSVBN?=
 =?utf-8?B?SDBLVjd1bEp0ZUxkSVRQbDN1dXJpN1hxVDRlc2tUWDdaeThxbWgvYWJjUnRp?=
 =?utf-8?B?SHZBMXpmVC9HOTlRR1RZcElsQWdCbnp2cTdCVGMvUzFUUWcveW5rM1UwM3V1?=
 =?utf-8?B?QjZoc056OGNZVUtIWW9VRnQ2ZElIQTliR3p5aFdHNSszRzlEbGU3STYvcXpB?=
 =?utf-8?B?ZDY4K2JzckFMRjM5QXVwY2JCYWhCeXFFazFnb01ScGI3d3lEVFJZNUpVVjkx?=
 =?utf-8?B?QTNxNUdzUTFReUU1MUw5a214ZmVPUnNtVEhWZlhRcmVhK0hxOE1CcXBNK24r?=
 =?utf-8?B?T2RsWVhJekY4eFVQRy9zUjMvWkl2UEpMd01rR3MrMW1Lc1lHR1VFWUN2YVBn?=
 =?utf-8?B?dlNKTTlZblBOZnNQN0hhWUwwSmFNR3JVamZZYkVHOFE5SEp1NU5aZzhralR5?=
 =?utf-8?B?Q2QyeDZ6YWk2cENHNVlZZUY1eDVmTEtzbGtFd1VwdkVSKzh2bjdEQS9ETlVj?=
 =?utf-8?B?aDl5ZkNXTkV2R2M0cjJwRTlhazFtZlcvREwrMG5NVVFKZXh6QWIzSlY4UFJj?=
 =?utf-8?B?R2pkRU9YblNZWGh1VzRkVW5WempaS1B3UVF3K0JNcU9yNFpSM0l1Y1hkYlpU?=
 =?utf-8?B?L1hHQjRyUld3dXVlaDl6TVZWdFd6REhwRnpiZTlNUkR1bTAwU0dYK0NsajJa?=
 =?utf-8?B?U1ZSalRZQ09UOXZpRzQrNjUwNStTazduZVNyZkRQdmRpYzAxV3FFVzVobURh?=
 =?utf-8?B?UDR5dHZrL25lYXlHeUpOR2VnR3cwR2liNHZyUUdxalcvWEE0WVptcVo4UmpV?=
 =?utf-8?B?ZGVuQXpHRVVubjA2OEF3NEFDcjNHMFhjVGFqL2Z0MnAyWHlOMVJQM1BvV3hO?=
 =?utf-8?B?emNCWndrUEhkWDVNVDFnQzYzcFViNHpuNEdEYVNRQ0dZQlVyUmNiTit4WWk3?=
 =?utf-8?B?eDAzU3N4VjVoN24rSFFocnZCS25YSHZBNkhVOUEvWUFaVnF4SkNzY3lSOGp6?=
 =?utf-8?B?OTNIM2pYcWh0NzkwdXc2T0FhNk1GNkZVZDlvTkZ4NWQrSDBkQkl5amtSbG1u?=
 =?utf-8?B?Vm9PRG01em5ESFZDN2RqYUpVcmtUM1NYZmZLMWpMVEtuKzgzVjV1SkdFZ3RO?=
 =?utf-8?B?NURCMUtWei91YTRHMHk1UmNVSnJERGdZdTFCdzhHWFdiT0xXVk9UZ1FaYjlH?=
 =?utf-8?B?d0IwcHVrS3lSZU1sSVo1enJlWHo3Y1RPK0ZlR0JDMlk0Z09tbFBldnRqTkE5?=
 =?utf-8?B?NGdnRVhubFd6aHZ2cGpuQjVkc0V5dnhaRFEzeVlVZGlxc1Zialg5MmxhZEY0?=
 =?utf-8?B?SUo0djNycmQ0ekM5cU5lR0lJRnRsQ0IyVGFVUnJPTlBsYk1pUTF4Y1IweXVZ?=
 =?utf-8?B?OWp6bU1jUVZPSkRud0w1cHkzektXcHhkN24yeXowQ1ROczYzUEJnR2xTY3Zv?=
 =?utf-8?B?Skh1Nk9JcFhZRDFGVkFhUG8vYmxNVUExaUF1SmpnWWxZelJlREtQaUpXbFNF?=
 =?utf-8?B?TzViOUhUT1V4R2lqdFE1ZmVGZGpPL3JkY2IvNzJ5dmc3WGd3UVdCV1hhdk1M?=
 =?utf-8?B?cjhrakRGU3ZGVWJNUk8rbGh1RG16Y0UwMnhJd0N0Q3hYOXEvVnhJZHViUEla?=
 =?utf-8?B?YU4xNmlHZ3J1TWVJVTU1OHRTYzVMdUxYWUJCNWVFMllFQ29STmg4N1dFUmRG?=
 =?utf-8?B?M0l6djQ1Y1NhM0pQYllPNFhRSkFJalFwanhGdCt1U29NYWxQb0pORXZhRG1R?=
 =?utf-8?B?MWFiWGdXNjFZak1SVUY2NjRlQkV1bHpTdnNDcHBFejBJaDllSnR1Yml0SzJQ?=
 =?utf-8?B?eWhmbEl5cFVENmgxOVBPTUdKUjQ1WVhScEhUQXRUQmk1NFBTUzgvVFNqa1Fx?=
 =?utf-8?B?ditLK0dwR0VLcndibk9VVGlLVFJCY0dyVVFKRENmT1hQNW5IaDdaQ2hIT3NW?=
 =?utf-8?B?ZndKbThWcEF0TEVJbUh6REJscXpZeC91OUJtZjBDRG1ZWFo3UHVzS0ZhZEJq?=
 =?utf-8?B?UTNkYjExUU1YczQxOW9mcEN5Z3lnak9PUXRkeUxNeVJTd3RUNnFaQkJqRUx2?=
 =?utf-8?B?U1pvRXRkS1VwZmJQRTFZL1pHR3QyYVlha2p1WnZ2bTAvSmFZUXFpckgzV3E0?=
 =?utf-8?B?RllFWXZZZlVyMW41eHVLK2NGVTkxNUpBdHNsS1l5TGtPemgwK3E2amV1WmF0?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D9D74BD087E2744A778525998A55BB9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LYpN+vKYtwMjRSoL4GhVm9MS2/PzBu2NgOkYzOtosUNswGKarqExU6TXGRmjdlyLUG9AsBskmnzBICGFQVoIdjHqyfyO1TZNmnP4ayic2d5TnX2xTyzi2LGf2b8uNj+42UAkvNjTSuI0KmkOGFJs8jKILZt9zCGgltGv2UWNQByixJTOYmLHEnVeq/nGAkfeDkSJcDio7007GsXhDXic4jzO4fcwQUj0+1hvWMMK2ll+AKvnNkdxCFt0VWeIYkzL5wdNwR/cJmHxY5krgXzRbhgSNiw1AYW+mHS0V1ykVg/ZpaO08J+IBCncRvJHRFESCNt6rMdh07MycIxilGQq2XJupyYQET+VHpoPd1sl7b/Mdc4LiyPLUiEp2eCv+saAHe0fSmN2yM+6vtn2t0wxE8VOiLawiExHf4s2jnIfcmJCz9Gr21C7vJjYb6l6/99jJ4PUhY0/ZxIc1/cA85w7ieTEt/j+JISzaFV2zQrgmQg8pyrHWEwrWNuXCLLOz+uVorUgtS7NrRyep3CMJDy67UhUnzBHYgoFCpsOl4KHQKuxMwV2t/EarN2mhGL6DcgzGdF3D79BkTgIhj5J+zZbLaWOzEmFqIb53Zb/WWClcBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566feb89-1861-46bb-1f47-08dc88af202f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2024 18:08:12.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoLfaiqycybRSmoW9G5H+Zvf+VoyatkYS0tA3IHkTCVszXMZ/1+lV5m3MBskQC6AQdLxqmZNx6ldYjyrlwsHNLb1Am3EpsL6OjbyTFK6eBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406090142
X-Proofpoint-GUID: EDCEssBFEKgbzYuCZn9q9qPiU1r-8Rff
X-Proofpoint-ORIG-GUID: EDCEssBFEKgbzYuCZn9q9qPiU1r-8Rff

T24gVGh1LCAyMDI0LTA2LTA2IGF0IDE3OjM2IC0wNzAwLCBhbGxpc29uLmhlbmRlcnNvbkBvcmFj
bGUuY29tIHdyb3RlOg0KK2NjIENodWNrIExldmVyLCBQZXRlciBPYmVycGFybGVpdGVyLCBWZWdh
cmQgTm9zc3VtLCByZHMtZGV2ZWwNCg0KPiBGcm9tOiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNv
bi5oZW5kZXJzb25Ab3JhY2xlLmNvbT4NCj4gDQo+IEhpIEFsbCwNCj4gDQo+IFRoaXMgc2VyaWVz
IGlzIGEgbmV3IHNlbGZ0ZXN0IHRoYXQgVmVnYXJkLCBDaHVjayBhbmQgbXlzZWxmIGhhdmUgYmVl
bg0KPiB3b3JraW5nIG9uIHRvIHByb3ZpZGUgc29tZSB0ZXN0IGNvdmVyYWdlIGZvciByZHMuwqAg
SXQgc3RpbGwgaGFzIGEgZmV3DQo+IGJ1Z3MgdG8gd29yayBvdXQsIHNvIGl0J3Mgbm90IHF1aXRl
IHJlYWR5IGZvciBzdWJtaXNzaW9uIHlldC7CoCBCdXQgd2UNCj4gdGhvdWdodCBhbiBSRkMgd291
bGQgYmUgYSBnb29kIGlkZWEganVzdCB0byBjb2xsZWN0IHNvbWUgZmVlZCBiYWNrIHRvDQo+IHNl
ZSB3aGF0IHBlb3BsZSB0aGluay7CoCBTb21lIHRoaW5ncyB0byBiZSBhd2FyZSBvZiB0aGF0IHdl
IGFyZSBzdGlsbA0KPiB3b3JraW5nIHRocm91Z2g6DQo+IA0KPiDCoCBPY2Nhc2lvbmFsbHkgd2Ug
c2VlIGludGVybWl0dGVudCBoYW5ncyBkdXJpbmcgdGhlIHNlbmQgYW5kIHJlY3YuDQo+IMKgIFNv
IHdlIHN0aWxsIG5lZWQgdG8gdHJhY2sgZG93biBhbmQgYWRkcmVzcyB0aGUgY2F1c2UNCj4gDQo+
IMKgIFdlIG1heSBzdGlsbCBhZGQgYSB0aW1lIG91dCB0byBoYW5kbGUgdW5leHBlY3RlZCBoYW5n
cw0KPiANCj4gwqAgV2UndmUgYmVlbiBoYXZpbmcgc29tZSB0cm91YmxlIGdldHRpbmcgZ2NvdiB0
byBnZW5lcmF0ZSBhIHJlcG9ydCBpZg0KPiDCoCB0aGUgdmVyc2lvbiBvZiBnY292IGRvZXNuJ3Qg
bWF0Y2ggdGhlIHZlcnNpb24gb2YgZ2NjIGluc3RhbGxlZC7CoCBTbw0KPiDCoCB3ZSBtYXkgZnVy
dGhlciBhZGFwdCB0aGUgdGVzdCB0byBvbWl0IHRoZSBjb3ZlcmFnZSByZXBvcnQgaWYgdGhlDQo+
IMKgIHJlcXVpcmVkIGRlcGVuZGVuY2llcyBhcmUgbm90IG1ldA0KPiANCj4gwqAgU29tZSBkaXN0
cm9zIGFyZSBzdGlsbCBub3QgY29sbGVjdGluZyBtZWFuaW5nZnVsbCBnY2RhIGRhdGEgYW5kDQo+
IMKgIGdlbmVyYXRlIGFuIGVtcHR5IHJlcG9ydCwgc28gd2UgYXJlIHN0aWxsIHRyeWluZyB0byBm
aWd1cmUgb3V0IHRoZQ0KPiDCoCBjYXVzZSBvZiB0aGF0DQo+IA0KPiDCoCBNYXkgc3RpbGwgYWRk
IG1vcmUgZXhpdCBjb2RlcyBmb3IgUEFTUy9GQUlML0JST0tFTi9DT05GSUcNCj4gY29uZGl0aW9u
cw0KPiANCj4gUXVlc3Rpb25zIGFuZCBjb21tZW50cyBhcHByZWNpYXRlZC7CoCBUaGFua3MgZXZl
cnlvbmUhDQo+IA0KPiBBbGxpc29uDQo+IA0KPiBWZWdhcmQgTm9zc3VtICgzKToNCj4gwqAgLmdp
dGlnbm9yZTogYWRkIC5nY2RhIGZpbGVzDQo+IMKgIG5ldDogcmRzOiBhZGQgb3B0aW9uIGZvciBH
Q09WIHByb2ZpbGluZw0KPiDCoCBzZWxmdGVzdHM6IHJkczogYWRkIHRlc3RpbmcgaW5mcmFzdHJ1
Y3R1cmUNCj4gDQo+IMKgLmdpdGlnbm9yZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgTUFJTlRBSU5F
UlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAxICsNCj4gwqBuZXQvcmRzL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOSArDQo+IMKgbmV0L3Jk
cy9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNSArDQo+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvTWFrZWZpbGXCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gwqB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9u
ZXQvcmRzL01ha2VmaWxlwqDCoCB8wqAgMTMgKysNCj4gwqB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9uZXQvcmRzL1JFQURNRS50eHQgfMKgIDE1ICsrDQo+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbmV0L3Jkcy9jb25maWcuc2jCoCB8wqAgMzMgKysrDQo+IMKgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbmV0L3Jkcy9pbml0LnNowqDCoMKgIHzCoCA0OSArKysrKw0KPiDCoHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL25ldC9yZHMvcnVuLnNowqDCoMKgwqAgfCAxNjggKysrKysrKysrKysrKysN
Cj4gwqB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL3Rlc3QucHnCoMKgwqAgfCAyNDQN
Cj4gKysrKysrKysrKysrKysrKysrKysrDQo+IMKgMTEgZmlsZXMgY2hhbmdlZCwgNTM5IGluc2Vy
dGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bmV0L3Jkcy9NYWtlZmlsZQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9uZXQvcmRzL1JFQURNRS50eHQNCj4gwqBjcmVhdGUgbW9kZSAxMDA3NTUgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9jb25maWcuc2gNCj4gwqBjcmVhdGUgbW9kZSAxMDA3
NTUgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9pbml0LnNoDQo+IMKgY3JlYXRlIG1v
ZGUgMTAwNzU1IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvcnVuLnNoDQo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvdGVzdC5weQ0K
PiANCg0K

