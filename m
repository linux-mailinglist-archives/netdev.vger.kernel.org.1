Return-Path: <netdev+bounces-102113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85090175C
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223C3281477
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 18:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB772481CD;
	Sun,  9 Jun 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cK7E2UNC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F/sOI04b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37550D2E5
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717956547; cv=fail; b=OprlTWZu60HHchwIe4anWT6kaA3sw3lrNp0+zy8RMGyDUqKVL4FCI+MSJdhiEIcwyRtZLAMYHWUCrn99SztNS9I3moEIbuPk46Y2YAie5VLWIqFsFD6HkPZCYfUicyu3qriKnjOgusAPmrgW2Oo6irtkHOJ6IBs6/ZTH9vf4KHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717956547; c=relaxed/simple;
	bh=UpsE3Ca1EtbmezJy6y3tsbOag3jagBYmZJt84BDk0BI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HzpgCTNENXfdYbD/cjbYN9HBjd4EBp5AuStckDZweIUS4Zeqi/cmSz6nvBO1hYQNDSm05a//sp/YUtCN5fJn78qHjSH/PtdaKFkfshyQ3A3VWVnDe4jfJQ6eX/ivO5QtiqRYKZQwc6s6F+YxgjYkZp4cPOk2ZKCUPHZ2JdfsP9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cK7E2UNC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F/sOI04b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459Fu4hE014290;
	Sun, 9 Jun 2024 18:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=UpsE3Ca1EtbmezJy6y3tsbOag3jagBYmZJt84BDk0
	BI=; b=cK7E2UNCigkSi7Sxqj7IRus0F3e9ltgD5f/UL713JKctmFcqxgT9SeWqs
	sqcBewAChKgCmKjM00qhk1y9wwsnq7/LUpX7DsejDQOuzzJISt4IAOBihQIGJL9F
	xpQVCQQ8JpxRV5tImvgqw8m8PP98SOGwBNxkl6/OUzpAWGuGAp0rbZOfIKzk6LZg
	ELwKI2CB3ABP23Nqe9qeTj305Vbb8RSXsJvdppMr3YuwHOIrAlV5nZrv+cDze9Gu
	b+cKV+WRHchnECIc6znzhH4EQJXI8zIacZjxesEISyfhsKqew2e5Arh0QuRNkjZM
	O2Khy4gJZGC3RMA+X3dksDRo843Vw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1m9c37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 459H5gCE020154;
	Sun, 9 Jun 2024 18:08:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8uwsxy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKI+zxUyoU8yNRZmUFnQoOMbK5FRsu5h7Zdz+G5zkKEkXlNCiSQYdQxIOd6FGJZVp6ovevFu/xbP9QiJjzfjeYc19DQtcFjLuAhv3Jy7QsdzwX8srAHg8grKaG9djnAJFzM2/K3cPGg4vAJNeQcQEyDqbqKD1xgACtUqdfcpEXY0YabcBJGA/JVknss7h52cIt58/TEEduPlwO/mbOFauIdshBpTy68PynJKU3ZzbqC+TIAyH2hJJAv3w8wtqspY6jq/+l3nqnUgQdyfaCQ3okwphdBQG38Q8/QNR4ygOwbhvIurA9tu7z2r40503u2suSU6elAjFw6hHzQuzMicoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpsE3Ca1EtbmezJy6y3tsbOag3jagBYmZJt84BDk0BI=;
 b=AeFsDUUSw0Ib6mHWiKOe4Vhp1FElytCCI/U6+AV7m6t5yAvHyovsqk77HUtcUlpdf6snhe4Na2otHbC3RJQzPWo2gYzhpxeU1jX9hF34dQ4SZ9P+g7E/hzLWJA9gjiwfpB6n27JLMEX+XfqxQc23GZfqkpFnYVqmo7UE/0tnAe1st9AE5aGTvdyRpdndxc6MWJKSzA3abtxtw+9KRAzTraqeuRS9ChE1+0KdzScopam+4JM9NkM8d75nlYxfAiJbAiCGAPehI4hNwV26qcnPpIAxaZV2/CfnDPHS5fOEVsNacGpbsWNV/IQIXLXZppNmCplU/HT/TWaBoj9q69VNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpsE3Ca1EtbmezJy6y3tsbOag3jagBYmZJt84BDk0BI=;
 b=F/sOI04bHKhzhjz9KpV4HGYkSkRFJn3VXdgz1QFU0ZKKoEF2COWJzwbj3DgtMBcRt1zKhBSdcsKgSlWMYCZev6tSfkkrfN9Y9YRuBPWxDIVUmhu1A/ER5phhvnGrgI7V+aSPFeOKIQFCXRTbKxu8lUXFHhvgDsvC1tInq1lpJW0=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Sun, 9 Jun
 2024 18:08:55 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 18:08:55 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Vegard Nossum
	<vegard.nossum@oracle.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [RFC net-next 3/3] selftests: rds: add testing infrastructure
Thread-Topic: [RFC net-next 3/3] selftests: rds: add testing infrastructure
Thread-Index: AQHauHLCjVPuuTncB0WyF1fOp7jB47G8wF8AgAL+6AA=
Date: Sun, 9 Jun 2024 18:08:55 +0000
Message-ID: <a84cdf6d300fac678f3de433e561ec569bc79585.camel@oracle.com>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
	 <20240607003631.32484-4-allison.henderson@oracle.com>
	 <20240607202402.GI27689@kernel.org>
In-Reply-To: <20240607202402.GI27689@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SJ0PR10MB7691:EE_
x-ms-office365-filtering-correlation-id: a1937383-5167-43c7-61bf-08dc88af39e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?clNPQzE0bjVoWmlpZy9CU3FDWlVTV0NhV1JKOG9PTE9VOXB3ZFhhTE1MWFJx?=
 =?utf-8?B?TGRVdTNKcU1BVStQcnZBQXlvbGJEMjJmRmJ4Tk4xaUxWRXF3WC9HaXNBUW05?=
 =?utf-8?B?MWVwMy9GL1I2dUY0ZVBsdUlxVWlpK3NLa3JDQit2bUc3VFhYY25mUm1qTTdw?=
 =?utf-8?B?eVZkelk1NmtRRlQ2SUl2L1JCSzVpRm0yeERlTUhZbDg3VmJ0M0ZOaG5keTE2?=
 =?utf-8?B?TXFBU0ZpOFVTTytOdFA2K0p6Zjlsd2x3UGoxL0RUMk8ybzNManJWeXhKOER3?=
 =?utf-8?B?cS9Oa1JER0x3NE9FYzF0WitiMWJKU2xLVGx1RXEyc2tZa1JUY25ZVVJrczQ3?=
 =?utf-8?B?S2c0REM4dmxzOGJKNU1ENHBwaDFTWEc0VzV2RjFnaExTNmtJbnlhbnNFVEhR?=
 =?utf-8?B?MnlQRGxDM1FRdkJYOTlZQUdqMWFQVi83dzFlTjR0ckJVdWJ2VmRURkxPdnlY?=
 =?utf-8?B?ejBCd1pNVGN1YWViZE9kQ0syRWdNaGRHc1EyTGh4L0wvKy9QVVUxU01vaUsy?=
 =?utf-8?B?RGZtUFVTUW1yNlpJQWVGQ0ZVdlcraGYvUTlYalVPcWE5UXpKRmNLdy9qbW9t?=
 =?utf-8?B?TlRUdnJ2cUQzRVJCNEl6aWZveGViVzNTTW5aN2pHd1EvcytyNlc3N2MwcDli?=
 =?utf-8?B?OEhMSDhZZ1c0R0g4Qkdld0pOcUZsTTVSOHkvNXdWOGp0dlp3MHlEWUE0UG84?=
 =?utf-8?B?N1UrVWdjVzFhUk9BWExPY2hyNVRwVlNVNzdvdks2Sk5zOVdMMWw1cjJ2clVj?=
 =?utf-8?B?aFIyTHp4WG8vWXJhOVpiQzBLSHNSNFI1eUlBRXp2ZkVwTGZWbGhBUm83dU9G?=
 =?utf-8?B?N3RrbmlPMURrU0c4RWVZL25WVmpUMFdNYURZNUZ3cjMyazZUeXNuYjR4Wk5O?=
 =?utf-8?B?c3pkNkh5WkQ0NXNaM3gzaUE3c0F2YmpyaGVpK29YZlkxSUF0VnpQRzI2ZU1O?=
 =?utf-8?B?VzhyRmdEOXc1NUErb0JYL25yOS8wTk1zTVdnZkF1cEFFdTdQWkVacVgydU81?=
 =?utf-8?B?eHNTNjBDdFlHdGdEOCs3WEJZRHFzak9WZkgyVlRoV0J3V3B6QkRFTDN6eXg0?=
 =?utf-8?B?Q20zK3FtbDNBbDFUZktxbStnT2FaVnlyeGQyWU5mNkczVkVJc2NQWEY4Zlp5?=
 =?utf-8?B?bHprOWRoM0svSWE5eUZ3RDNTUDh1OHpVWEdLdEpvZW9GcmlqMVNnWTdWWmtG?=
 =?utf-8?B?TWg1MnAwQXBSQ0E5YVlTNXBRVENZc0hBa1Bqd2UrUm1POEQ4Qytjb0F2ZmhC?=
 =?utf-8?B?dlo1c1Z5YXRVcHQzSDdlS2dCRXg5VldlUmE3ZWZGYWVCTjExUVBlSEhYN0My?=
 =?utf-8?B?V0ttb2pYRFFUb0JSVXFrMlJXbCtrMjJPK2RIMzJXSS9CSnBjb3Nhb2k3TFdU?=
 =?utf-8?B?dWczdWV6WHA3cVRGYXJPR0hGMWZIK0NLc2N0ektLS3R6by8yckJYa3Q2ZHBi?=
 =?utf-8?B?Tm5EcFB6enI5VnlIcUFnSE5xUlVCSVplSmlmd3pJdlN1WUZNeGk1K3hvb3Er?=
 =?utf-8?B?ZnNSRDZleFN3R04vUkVaZ0VlUEhyR2djclFZSXFoMWkvdWdRZjJRMi9vaGFp?=
 =?utf-8?B?SVdHK3AwNEdBQVJEL3FPcmxUQ1Rta3Yrb1E0WGNEVjQ5N3JSaU1ZSWttanJQ?=
 =?utf-8?B?WGFBZVNoRCtpdHRndUxpNGhuVy9OZVdtc1JpbkxyVDB5R2FXZjBpbWhLTi9i?=
 =?utf-8?B?KzMwclQwdytkYzk4SHJWK0tkT2tUK05DSW5NbmFndjlXUHN1bVVaOTVLTFdj?=
 =?utf-8?Q?6pPXDh/xXkUdGvFypEM1/lp6GKWXzhGmDLsd2lX?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MGR2QVo2aFp1QzRhdHVYcVArRHZ2WTI1UVNtVWNZLytUeDVMYi8zQWVHZXFj?=
 =?utf-8?B?Q3laZVJNRjcvN0RFSzRVQ05GWEp5M3hlUVp0SjV5NWdCYTVpdDFMcnNnQUx6?=
 =?utf-8?B?TXI0QlVWekswaGlLWUhDYm43RlNsRFZrWUVWUCtEcUpoNzJQWUIzejVmT08z?=
 =?utf-8?B?dlBlRUo1MlJjUWg5aU02Z3FsbXZwN05CL2x0SUtwUkVQUkZ1Wit2MjYvRmZi?=
 =?utf-8?B?YXNSZ2lTdHRlWWM1WTV1QkkzSjBKN2lKZ2M2ckQ0cEJTSklwYWp4OVFsbWh5?=
 =?utf-8?B?d0lnT1VhbStDT0RIeTc1U0M5UEtoSXUxWDdmQURLNnkwZUNtdWxrMXFUTmc5?=
 =?utf-8?B?WTFKYnl1ZzBBQUhJSm1nNEY0UzQ0eGJlR2c5elF2OVRGT1BlVXlWQUVzbWFE?=
 =?utf-8?B?eGxDM3FxR2RUUnF5L3J5NjBWU0ZvZ2tnZFVQWFBWaTJGM0t3ZDJTOXN6L1RG?=
 =?utf-8?B?YTNFSHNlajZFTTlYZW16VlpNT2R4YVR3c2RFeXRiTTRidTE4VFk4eEtZMDlH?=
 =?utf-8?B?T3dGZkxwUE9yVCtKOW41aTdZSUxRV1kzRkZreXRLNlpsR2dDME5kb1NpNG1l?=
 =?utf-8?B?Q1FTSHF5MzYvZFIwVHZRdlkwb29iYnN6TkFPbVdTZG96UHdjTUtrdzZ1WjI5?=
 =?utf-8?B?RUpwYmV1ZEhadVVrUE02UjZ3RnBGaGI0UHo3RVJBL0MyM2djSDJGZVh0VEU5?=
 =?utf-8?B?ZzUxdmV2L2FvZ3oxbFFuWkk4cHRrWVU4cjJxbm9tYUo0UXVXNFo2WUpEUmZX?=
 =?utf-8?B?MUlveUFKbldIb1JzNGp0ZzFZU3NMOTd1eGJZZ0ZDczNnank4MmVJNmJxVXl6?=
 =?utf-8?B?Q2c3WDNmK3BDS1ZsdmpJc0U4U0lmZTJyYnE1ejdVWnhzSXJvazJkR215UHFK?=
 =?utf-8?B?ZStSM3ZJRVJjYkNMTUkxNkIrU3B3aEI1MUY5Z3VnNHllRnhyM1VVdit5MnV0?=
 =?utf-8?B?U0ZvRGthVVdLQldQd0FwTzNla3YyRDFnU09HRmR6Y1YxZWRSdnNiVzQvUUhM?=
 =?utf-8?B?NWdhWmdMS2I4SGZCNGRXVGpEaVYxdUR1MWFoc2tvL2dqc1Nua2tveXZSb0sx?=
 =?utf-8?B?WDAwZTM3T3ZicGErQm9PSFpWSGlteHp2TTBHT3poTnZRSUZkcFpoc0YwZkY5?=
 =?utf-8?B?Z21wRnFnOUIrNG83cFVNSGdZRlFYT05zbkZlV3lxRTRKMnI3NHE5em9KWWFO?=
 =?utf-8?B?YVZHNDdwOVFJVUl0c2p3RjBLaUhEaHdYVVRLNzdwMGFYSXpmSm4xQmFKM2or?=
 =?utf-8?B?K2hLR2hHS3ZtL3JGL3htODhYYk1nUTI4YVpwRzcrSTREdHE5L0cydUhSU2Np?=
 =?utf-8?B?YjJjNWp3YmZqQUVybnF4ek84L0RvVzhsckxuVlFxWlVNc3kzSDdpWTNBTzZK?=
 =?utf-8?B?Q0VjTmptNldZRTlOeGhCaHlkUWdPd2wwWDZQSjR2dk9HQmh2WWw0V05MLzBr?=
 =?utf-8?B?UjVUTit1Q1VDMXZUU1pwVGpNWTFVNkt4TWl1T2kzTEh5RUQ2ekxVT1JpQzVM?=
 =?utf-8?B?T3E1Qk1zSmlwdWFPcFRSZmNTVmIreHJLYms4YlVNb25kYlZXZ0NUMzdYQkht?=
 =?utf-8?B?R09GWVNrK0lqbFRmV0FKeFBIeVpPNEhvc1FzeHNpQ3JEcGI1UFNjTGJvUzNF?=
 =?utf-8?B?Y1U3UCtXTFBMKys5MEttcTZFK3cwQW13bzY3ZDBDRkVuOEdMVEthak5VTG1W?=
 =?utf-8?B?SUJmVlpXUm1hampOaWIvZkRkZUJRWTAwaW1EYzJnZHA5RU1ZMUZ5S3BYamdp?=
 =?utf-8?B?NG5EeXBrMWNqYUFLTWgvb25kQ0dUR3lmS2t0WU15K3JhcTNDUy96ZEZYdXRV?=
 =?utf-8?B?MFlFdlJtc3JnYzNvek1hZU00L0M0c1UrQU40NXJjNks0MW1jNDVNVmg5aCsr?=
 =?utf-8?B?YUpXNmQzU3I0cUZGOFNIVUdVcm1hbVlSVWppekdOOGhSWUhvQjJkUVBsK3BS?=
 =?utf-8?B?czNYd3RvWTVwZ0kvZHVMdkwwZW9OR2ErVVIvd05qamN2SDBFbWZqRElVNUNR?=
 =?utf-8?B?akNyengvakxHNk1CT0xqRjdYV3RzVTlFUWhUeEk1MGVoaXh3VWo5aTNMRWtL?=
 =?utf-8?B?VkE2QkczRUJ5SVZ1MjJZcWVQRkJnVEgxZ3A0SU5sbndqeTkwWVk0K3pzWlVP?=
 =?utf-8?B?TWs4VHY3NzA2Z3Fka1psMnAySE5IODZaU1FKcUNxUUNrOEp4Q2VvY29ONG5z?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <952632DC1C3AF8419F2C225C03A49B05@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jnlQOtxPsDBw5VCSLnGRj7e086Z+EE0U9NMFdiqbXEteZtGBilvfrjaCxB02cCPZGfTmGCYer7Vq/3TPJWaK7oXKnpJb2O3SRtfog9vBE2E8/HQ0OM6pLpSFhbo5NC1wDiY1u+2sauM80PIHvOoBWIStFPItq4Ek79dlZtAIVYgVI5qrt1+TX2VU85ufDBPcwH47pQ8IQ9LZIHSDIAf41LeEH99gKZB3pkT1/jMQvFZRR5UO0F3cYSHm3SA1brVwROhHcGN7C/JI+8gOyhtW9BKjLnnQPbSL96VdCi78jXlLRKOAMEEb/7r5zZheQC0067Ju0vjkUcDR/zLlah914y+lU9CAJSxfVFDevA4dPF/+PtjB7KKtSWWW+gY7CpjaDtXIBrVsrEB7tYenSgS4l7IjcSPKLpfYg2kFiovnLECN39zVYg90t/un7sSlrBhCh7hzvymnBGYlzun3qNs5LHEuWHsw/PaV9SmQ2eKQrYHmhOxp6+8OCIt3PTs1zS3ofPvnlYsY/km5F81HWEnOOxU7PJmGj9gBFoNAjsvb4TITA6xBGkun22vXZvYB43vEkaAbCg3F+1wA249YJRuIZOl+hOT9zrx9cLNQjX+9vKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1937383-5167-43c7-61bf-08dc88af39e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2024 18:08:55.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pODwfZqZhqTIrbVNg1VrfF68Cq+lMW05uQY6H7v3VTEXhvUD5qcOUn0sDuujO7KA82hE87WOzjXNA72mEUgYUzW6sODhxJEZsVbxNzmAW/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406090142
X-Proofpoint-ORIG-GUID: 54HOjuQYtGzMIClv3jG_F7RrO6qE4n0p
X-Proofpoint-GUID: 54HOjuQYtGzMIClv3jG_F7RrO6qE4n0p

T24gRnJpLCAyMDI0LTA2LTA3IGF0IDIxOjI0ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQor
Y2MgQ2h1Y2sgTGV2ZXIsIFBldGVyIE9iZXJwYXJsZWl0ZXIsIFZlZ2FyZCBOb3NzdW0sIHJkcy1k
ZXZlbA0KPiBPbiBUaHUsIEp1biAwNiwgMjAyNCBhdCAwNTozNjozMVBNIC0wNzAwLA0KPiBhbGxp
c29uLmhlbmRlcnNvbkBvcmFjbGUuY29twqB3cm90ZToNCj4gPiBGcm9tOiBWZWdhcmQgTm9zc3Vt
IDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+DQo+ID4gDQo+ID4gVGhpcyBhZGRzIHNvbWUgYmFz
aWMgc2VsZi10ZXN0aW5nIGluZnJhc3RydWN0dXJlIGZvciBSRFMuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogVmVnYXJkIE5vc3N1bSA8dmVnYXJkLm5vc3N1bUBvcmFjbGUuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUu
Y29tPg0KPiANCj4gSGkgQWxsaXNvbiwNCj4gDQo+IFNvbWUgbWlub3Igbml0cyBmcm9tIG15IHNp
ZGUuDQo+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRz
L2NvbmZpZy5zaA0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9jb25maWcu
c2gNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzJj
MzY3NTZiYTFmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL25ldC9yZHMvY29uZmlnLnNoDQo+ID4gQEAgLTAsMCArMSwzMyBAQA0KPiA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKyMhIC9iaW4vYmFzaA0KPiANCj4g
IyEgbGluZSBuZWVkcyB0byBiZSB0aGUgZmlyc3QgbGluZSBmb3IgaXQgdG8gdGFrZSBlZmZlY3QN
Cj4gDQo+IEZsYWdnZWQgYnkgc2hlbGxjaGVjay4NCj4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL3d3dy5zaGVsbGNoZWNrLm5ldC93aWtpL1NDMTEyOF9fOyEhQUNXVjVO
OU0yUlY5OWhRIU9qTHlTRlA2d05FbTZ3V0s5MGhWSkhhOVJYQVA4MzEwdjhWMHVLTFE5S3ZPRG95
RDhoVUhYMENSTFpwS0JsMWpRR3dmUi12WWNCSTV3OHdSd0FJJA0KPiDCoA0KPiANCg0KQWgsIGFs
cmlnaHR5IEkgd2lsbCBnbyB0aHJvdWdoIGFuZCBmaXggYWxsIHRoZSBzaGVsbCBjaGVjayBuaXRz
DQoNCj4gPiArDQo+ID4gK3NldCAtZQ0KPiA+ICtzZXQgLXUNCj4gPiArc2V0IC14DQo+ID4gKw0K
PiA+ICt1bnNldCBLQlVJTERfT1VUUFVUDQo+ID4gKw0KPiA+ICsjIHN0YXJ0IHdpdGggYSBkZWZh
dWx0IGNvbmZpZw0KPiA+ICttYWtlIGRlZmNvbmZpZw0KPiA+ICsNCj4gPiArIyBubyBtb2R1bGVz
DQo+ID4gK3NjcmlwdHMvY29uZmlnIC0tZGlzYWJsZSBDT05GSUdfTU9EVUxFUw0KPiA+ICsNCj4g
PiArIyBlbmFibGUgUkRTDQo+ID4gK3NjcmlwdHMvY29uZmlnIC0tZW5hYmxlIENPTkZJR19SRFMN
Cj4gPiArc2NyaXB0cy9jb25maWcgLS1lbmFibGUgQ09ORklHX1JEU19UQ1ANCj4gPiArDQo+ID4g
KyMgaW5zdHJ1bWVudCBSRFMgYW5kIG9ubHkgUkRTDQo+ID4gK3NjcmlwdHMvY29uZmlnIC0tZW5h
YmxlIENPTkZJR19HQ09WX0tFUk5FTA0KPiA+ICtzY3JpcHRzL2NvbmZpZyAtLWRpc2FibGUgR0NP
Vl9QUk9GSUxFX0FMTA0KPiA+ICtzY3JpcHRzL2NvbmZpZyAtLWVuYWJsZSBHQ09WX1BST0ZJTEVf
UkRTDQo+ID4gKw0KPiA+ICsjIG5lZWQgbmV0d29yayBuYW1lc3BhY2VzIHRvIHJ1biB0ZXN0cyB3
aXRoIHZldGggbmV0d29yaw0KPiA+IGludGVyZmFjZXMNCj4gPiArc2NyaXB0cy9jb25maWcgLS1l
bmFibGUgQ09ORklHX05FVF9OUw0KPiA+ICtzY3JpcHRzL2NvbmZpZyAtLWVuYWJsZSBDT05GSUdf
VkVUSA0KPiA+ICsNCj4gPiArIyBzaW11bGF0ZSBwYWNrZXQgbG9zcw0KPiA+ICtzY3JpcHRzL2Nv
bmZpZyAtLWVuYWJsZSBDT05GSUdfTkVUX1NDSF9ORVRFTQ0KPiA+ICsNCj4gPiArIyBnZW5lcmF0
ZSByZWFsIC5jb25maWcgd2l0aG91dCBhc2tpbmcgYW55IHF1ZXN0aW9ucw0KPiA+ICttYWtlIG9s
ZGRlZmNvbmZpZw0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQv
cmRzL2luaXQuc2gNCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvaW5pdC5z
aA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hMjll
M2RlODFlZDUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbmV0L3Jkcy9pbml0LnNoDQo+ID4gQEAgLTAsMCArMSw0OSBAQA0KPiA+ICsjISAvYmlu
L2Jhc2gNCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsNCj4g
PiArc2V0IC1lDQo+ID4gK3NldCAtdQ0KPiA+ICsNCj4gPiArTE9HX0RJUj0vdG1wDQo+ID4gK1BZ
X0NNRD0iL3Vzci9iaW4vcHl0aG9uMyINCj4gPiArd2hpbGUgZ2V0b3B0cyAiZDpwOiIgb3B0OyBk
bw0KPiA+ICvCoCBjYXNlICR7b3B0fSBpbg0KPiA+ICvCoMKgwqAgZCkNCj4gPiArwqDCoMKgwqDC
oCBMT0dfRElSPSR7T1BUQVJHfQ0KPiA+ICvCoMKgwqDCoMKgIDs7DQo+ID4gK8KgwqDCoCBwKQ0K
PiA+ICvCoMKgwqDCoMKgIFBZX0NNRD0ke09QVEFSR30NCj4gPiArwqDCoMKgwqDCoCA7Ow0KPiA+
ICvCoMKgwqAgOikNCj4gPiArwqDCoMKgwqDCoCBlY2hvICJVU0FHRTogaW5pdC5zaCBbLWQgbG9n
ZGlyXSBbLXAgcHl0aG9uX2NtZF0iDQo+ID4gK8KgwqDCoMKgwqAgZXhpdCAxDQo+ID4gK8KgwqDC
oMKgwqAgOzsNCj4gPiArwqDCoMKgID8pDQo+ID4gK8KgwqDCoMKgwqAgZWNobyAiSW52YWxpZCBv
cHRpb246IC0ke09QVEFSR30uIg0KPiA+ICvCoMKgwqDCoMKgIGV4aXQgMQ0KPiA+ICvCoMKgwqDC
oMKgIDs7DQo+ID4gK8KgIGVzYWMNCj4gPiArZG9uZQ0KPiA+ICsNCj4gPiArTE9HX0ZJTEU9JExP
R19ESVIvcmRzLXN0cmFjZS50eHQNCj4gPiArDQo+ID4gK21vdW50IC10IHByb2Mgbm9uZSAvcHJv
Yw0KPiA+ICttb3VudCAtdCBzeXNmcyBub25lIC9zeXMNCj4gPiArbW91bnQgLXQgdG1wZnMgbm9u
ZSAvdmFyL3J1bg0KPiA+ICttb3VudCAtdCBkZWJ1Z2ZzIG5vbmUgL3N5cy9rZXJuZWwvZGVidWcN
Cj4gPiArDQo+ID4gK2VjaG8gcnVubmluZyBSRFMgdGVzdHMuLi4NCj4gPiArZWNobyBUcmFjZXMg
d2lsbCBiZSBsb2dnZWQgdG8gJExPR19GSUxFDQo+ID4gK3JtIC1mICRMT0dfRklMRQ0KPiA+ICtz
dHJhY2UgLVQgLXR0IC1vICIkTE9HX0ZJTEUiICRQWV9DTUQgJChkaXJuYW1lICIkMCIpL3Rlc3Qu
cHkgLWQNCj4gPiAiJExPR19ESVIiIHx8IHRydWUNCj4gDQo+IFBlcmhhcHMgaXQgY2FuJ3Qgb2Nj
dXIsIGJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgd2lsbCBiZWhhdmUgYXMNCj4gZXhwZWN0ZWQgaWYg
dGhlIG91dCBwdXQgb2YgZGlybmFtZSBpbmNsdWRlcyBzcGFjZXMuDQo+IA0KPiBGbGFnZ2VkIGJ5
IHNoZWxsZWNoZWNrLg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cu
c2hlbGxjaGVjay5uZXQvd2lraS9TQzIwNDZfXzshIUFDV1Y1TjlNMlJWOTloUSFPakx5U0ZQNndO
RW02d1dLOTBoVkpIYTlSWEFQODMxMHY4VjB1S0xROUt2T0RveUQ4aFVIWDBDUkxacEtCbDFqUUd3
ZlItdlljQkk1MDA1d00zayQNCj4gwqANCj4gDQo+IEFsc28sICRMT0dfRElSIGlzIHF1b3RlZCBo
ZXJlLCBidXQgbm90IGVsc2V3aGVyZSwgd2hpY2ggc2VlbXMNCj4gaW5jb25zaXN0ZW50Lg0KDQpO
b3RlZCwgeWVzIGl0IHNob3VsZCBwcm9iYWJseSBiZSBxdW90ZWQNCj4gDQo+ID4gKw0KPiA+ICtl
Y2hvIHNhdmluZyBjb3ZlcmFnZSBkYXRhLi4uDQo+ID4gKyhzZXQgK3g7IGNkIC9zeXMva2VybmVs
L2RlYnVnL2djb3Y7IGZpbmQgKiAtbmFtZSAnKi5nY2RhJyB8IFwNCj4gDQo+IHNoZWxsY2hlY2sg
d2FybnMgdGhhdDoNCj4gDQo+IFNDMjAzNSAoaW5mbyk6IFVzZSAuLypnbG9iKiBvciAtLSAqZ2xv
Yiogc28gbmFtZXMgd2l0aCBkYXNoZXMgd29uJ3QNCj4gYmVjb21lIG9wdGlvbnMuIA0KPiANCj4g
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vd3d3LnNoZWxsY2hlY2submV0L3dp
a2kvU0MyMDM1X187ISFBQ1dWNU45TTJSVjk5aFEhT2pMeVNGUDZ3TkVtNndXSzkwaFZKSGE5UlhB
UDgzMTB2OFYwdUtMUTlLdk9Eb3lEOGhVSFgwQ1JMWnBLQmwxalFHd2ZSLXZZY0JJNUVzX3F1d0Ek
DQo+IMKgDQo+IA0KPiBBbHRob3VnaCBJIGd1ZXNzIGluIHByYWN0aWNlIHRoZXJlIGFyZSBubyBm
aWxlbmFtZXMgd2l0aCBkYXNoZXMgaW4NCj4gdGhhdCBkaXJlY3RvcnkuDQpOb3QgYXQgdGhlIG1v
bWVudCwgYnV0IGl0cyBhbHdheXMgcG9zc2libGUgdGhhdCBzdWNoIGEgZmlsZSBjb3VsZCBiZQ0K
aW50cm9kdWNlZCBsYXRlci4gIFdpbGwgZml4IDotKQ0KDQo+IA0KPiA+ICt3aGlsZSByZWFkIGYN
Cj4gPiArZG8NCj4gPiArwqDCoMKgwqDCoMKgwqBjYXQgPCAvc3lzL2tlcm5lbC9kZWJ1Zy9nY292
LyRmID4gLyRmDQo+IA0KPiBBZ2FpbiwgSSBndWVzcyBpdCBkb2Vzbid0IG9jY3VyIGluIHByYWN0
aWNlLg0KPiBCdXQgc2hvdWxkICRmIGJlIHF1b3RlZCBpbiBjYXNlIGl0IGluY2x1ZGVzIHdoaXRl
c3BhY2U/DQpZZXMsIEkgdGhpbmsgc28uICBFdmVuIGlmIGl0J3Mgbm90IGFuIGlzc3VlIG5vdywg
aXQgd291bGQgYmUgbmljZSB0bw0Kbm90IGRlYWwgd2lsbCB0ZXN0Y2FzZSBicmVha2FnZSBpZiBm
aWxlIG5hbWUgd2VyZSB0byBjaGFuZ2UgaW4gdGhlDQpmdXR1cmUuICBXaWxsIGZpeCB0aGlzIHRv
by4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3ISA6LSkNCkFsbGlzb24NCj4gDQo+ID4gK2RvbmUp
DQo+ID4gKw0KPiA+ICtkbWVzZyA+ICRMT0dfRElSL2RtZXNnLm91dA0KPiA+ICsNCj4gPiArL3Vz
ci9zYmluL3Bvd2Vyb2ZmIC0tbm8td3RtcCAtLWZvcmNlDQo+IA0KPiAuLi4NCg0K

