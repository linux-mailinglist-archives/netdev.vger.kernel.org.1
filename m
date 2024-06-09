Return-Path: <netdev+bounces-102112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B390175B
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A88281472
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3129C47A74;
	Sun,  9 Jun 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YM8pCkY8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ch8IBbzO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03F481CD
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717956516; cv=fail; b=MZ8pO28D23d84drBycgXIhxDJL4K1egEty8mxNkirvLiW2sf2CphmqZkyWrKDFhHUTJTa9mV2TxbSjUB34pnZOcbz7KB3sNput9LaaazYhPuxuMjeZ9kW9PMRfugnzWgqv7N3eboDC1ro2K6i8emtSlZOLkbwd+rzAMWcIushrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717956516; c=relaxed/simple;
	bh=JxP5fsTt47+FHSEnzjd6PHNtxnEbMz5nec/CfAJNF0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhFfdtDjFE6yutqG/t3UmsEY+mtxHfrgJjc6wveqhgBVZ9LarfNs9AtpxEgkL0W0YmhI0iWb0nWhPGeNmTj8BRGruuJ4jp5Wecuq61y2CFafCjnrzktz97N64Z0xZ9nfi2JwkXxt0rEYa8CamLDNbuTE7QsUHZqzhqRHWcCJfSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YM8pCkY8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ch8IBbzO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4595KBUo003977;
	Sun, 9 Jun 2024 18:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=JxP5fsTt47+FHSEnzjd6PHNtxnEbMz5nec/CfAJNF
	0I=; b=YM8pCkY8oDHNlvMcV/uj/UEdLjCHn26KFRgPkzZ9lvM00Ki3xMyLGCE1+
	S5yAiFmSJ0T8IzQNCaIMg8dunDbc/O5LSVNaYPkjK6Y2mjioHRCdaAs1E4F+zuEk
	iXMx4UhavFdbabL3gfMZuPjeD0+jswcbIcUMfDdOTSG8U1dBRKLwOJG8l8QTCz9B
	wQkgYUsy7v4KbhXExin8dEJ3QlpPAg4KHXAFz5KqL6NuwAXll7E+mMD+a20mgqIp
	o8a5+i9BBnxmxepdhsVT4rYZsT1yT196vfQqgqqFEzz9yDTomEg9Y1yfRZiLOPx6
	Nbx3YXCS+chWX5VEJ8WW+XRMlO/zQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dhb3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 459HFU53036553;
	Sun, 9 Jun 2024 18:08:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdtwmf1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JimvevYhD+/zwAccAggUge2nmDRmid4V+V+EbCm4MIQOgvkxpT1kB/eHZvECHZACD3XmWqhPJxcUmkYiYVKToeoGA+ZSyyOW+sI/2KD0hu/T1xJEoSw0qH31hE/kz4YyEugDz93OC9NyxsU4idKEFsIrXOrTJGnc0UdoM4vycZSUp4JsoovNH5DaT4jOuKZ0tJKZKqox+8/grz+b2/99qnkgRbD6VQZZu6hjHO07FghiVCpDeli3sniiPAL8mNAo+U0yvqABBdKY0jhwEFb2ATKbEOwwUcpiFfRYXj5adPGLMSkozSSMmlVob6DmO90qiVZu4Azt3wTMHlvvX7jayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxP5fsTt47+FHSEnzjd6PHNtxnEbMz5nec/CfAJNF0I=;
 b=hPDxzEyt4ejYxS2dlsh/aLBymkcqp9lTs418K/yfb+SmRk5j4SB+QF41aD1EMAT9fFUAiFZT3mXPFTo/7twdBLR+gP85aSGul0xNLfzx2PZdSfRR8Y27XnJj3zsBWr7RoiGocqL7zizb+sEmshj6875CDVxE5P8S1qZMmw6Zb6lecqk8qv6DTWKhFS3f8fPI+cr9nbL/V5RQP3NfwjFb46ZKU1/c9kEOiwCIcPxaikL710DBiLJISmzMzEZGVZmeB0v6TK82b7637XUvMSx1wrG9Wmm++8LkotEwgv+kEPa1EYPwpOk6eI9NjNfPhg60/IcB9Fp0DJJFHkpbjXCjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxP5fsTt47+FHSEnzjd6PHNtxnEbMz5nec/CfAJNF0I=;
 b=ch8IBbzO2We0c1zzduLWwH6eRLeMw7u8bbwLJIxMgIwQ9MdjRBXg/PreXKw8cIEieTJnqxuCVP+MLK5eHlT/GbOSMzQJV7dKANux3XHoDlUA+p1C5x/++BNH9TVxeFaLLOQ34yUvgi0Md3AH8R2WKFjsrHsYtg2frTjEnxFxuvw=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Sun, 9 Jun
 2024 18:08:27 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 18:08:27 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Vegard Nossum
	<vegard.nossum@oracle.com>,
        "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [RFC net-next 2/3] net: rds: add option for GCOV profiling
Thread-Topic: [RFC net-next 2/3] net: rds: add option for GCOV profiling
Thread-Index: AQHauHLBymI1Pj/VZU2CRQLnktO03rG/vyeA
Date: Sun, 9 Jun 2024 18:08:27 +0000
Message-ID: <3e6bb697af96dcfd23c10c2f09ce7a1707e08f98.camel@oracle.com>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
	 <20240607003631.32484-3-allison.henderson@oracle.com>
In-Reply-To: <20240607003631.32484-3-allison.henderson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SJ0PR10MB7691:EE_
x-ms-office365-filtering-correlation-id: 3abd4044-ff83-41eb-a24b-08dc88af298d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MDhkcU90OThObFc3alFrY1pjUVgvUnJ6NFUyTnZPMVBJYnVUVEdxMmsyTzMv?=
 =?utf-8?B?TzI0eVBwdGRnUlVpUnErSUpaSmJ4Y3VERkhIRXI4b2J1Mnc5b0pBQ2x4K0Jy?=
 =?utf-8?B?M2lyVDQ1eFJURGpzUEF4WGdHODFxWG91MVUzMHlTYy9FNmxCbEVnRUIzWk1P?=
 =?utf-8?B?bktzRitPQnExYWJiaXhyWXpWVVlFSDFmajE0R21QQW44TGE0OHJtdkF6Vi8z?=
 =?utf-8?B?ekloNDFMY0ZZSE5OUlZFc3RmMkp1UVhtU215WUNFc2NZNHl4NVIzRUpuK3M1?=
 =?utf-8?B?cjVnVzJrUU9COVJyMVBVUXF5SWhPWjVvSzlmeW96dkJUaDhITmpEQlhrdmlT?=
 =?utf-8?B?VHVoWVhzb1I2ZzRhOXY2aDZSdy9UVEZ3bWhZMHIyeDlhV210eEF6Q0IrQWVr?=
 =?utf-8?B?MzE1c21ydnFPaUhVbFdrTVJheU9WZ0R2K2xRYVVpK2V2d2NjaG9oaEx3RFZE?=
 =?utf-8?B?UFZiNzkrUGFPdzBOQTA2Y2VvR2p6TjNuRnBTM2ZOUThrWEx5K2hDUUp4SS9y?=
 =?utf-8?B?SVpUUk04aXFmL3dwTEZiR2hId2dOcXVnTkJKUkhOL1l0Vi81Tmo3WlVJUmpu?=
 =?utf-8?B?ZGZ0VEZQbUpUVW5ZcGZwTGd3R04zOCsycUFGK0pYeTEvczQ2d2tNY3dHZW9k?=
 =?utf-8?B?Zk5iZFE3WkJURXdidjhSY09hWk93RDlXUHcrZmtrSmlxendPZWZEMGVYbUV1?=
 =?utf-8?B?TlB2enZ0T3l0UW5FNWh0L25HVndsK2tFdExwT3lyelVHTTZPdEdQTDVnR3JZ?=
 =?utf-8?B?K0xPU2RtM0dTaktlUHN6MCtycUsySjRDZjg2aVBjRStmYkpmbzRGb2R5UTg2?=
 =?utf-8?B?azYwb0t6NnZRTFA2WUNQQUJlNnFnQ25wYjd2cmgvSW10d21EZWNpWnBLQnMz?=
 =?utf-8?B?bWhLaGdMS28zbDFKMlFsVTVOaWFyMHVRYmdpQnhnZlJLOFU3YkwybVo5L3pS?=
 =?utf-8?B?S0x5VHdWZ3hQaHpWWWJEdXpmcUdZMDY1NHhrVVVkMUdRU25CTTg2SmJjKzZE?=
 =?utf-8?B?RG8wbFhHQi9BV2Zma3hSR1VZdjFvdUhBSFgzMU42QU1oN2xGdHNCN3cyajZT?=
 =?utf-8?B?RnFIOVJKcXFPYnk2Y3R4ZmVITERybG53ajhZanJwd1lIK2JZSUx1MzY0ZUtB?=
 =?utf-8?B?MkQ5dHRmK1FNay9wT1BXMlVYT21vaFR6anYyTjJuRk11NkEzWmh2a1picC83?=
 =?utf-8?B?WkNhK2gweEwwMUltNjhoQ0QxekdvcitlOUVLWW9iTnFmZlFyblFXalkwMG5v?=
 =?utf-8?B?ZFFNS1ZaeGdidXhtRCtDdU5wK3hUUmNaWE9aWGJ3dUswOG9nb1ZMc054STIx?=
 =?utf-8?B?VjZWakp4cElQY0p1b290OEcvSnNFN2NiOHVWQ3hZWFRxVXRmeDdHcE95Ky9y?=
 =?utf-8?B?Q2pTS21CZmNGWmZnclZIY01Oa3VZdms3dTNjT1FNKytaQ21LNkdSYnRXV0hx?=
 =?utf-8?B?dis3RTRHMzZ3cTV3Qit6OFhTSStnS2Zlc3NpY0pUcHJUK2laQ21zbjFHdUdq?=
 =?utf-8?B?S1pNODNiZVJnUDJqK2Y5TThPc2dpWVUrYWJSK0Yyc2txcmFzRlBlbjZDdDVt?=
 =?utf-8?B?TEdJdDQyTkwrTkxEb3FrTGtSMHNRN1haU1lNK0ZYY1hZUUVsRm5hOGsrVFNN?=
 =?utf-8?B?czRSU2RWOUZMMkROUlI4MDFXSm5QdmlIK0tGU2xBQXBHNHZSdHNSb3ptV1FS?=
 =?utf-8?B?TE5LaEZ1NTlxeVpRa2xKTHJxa0JrOTJvRVJvcStZcVplUWFBKzRTME1pbURW?=
 =?utf-8?B?NDgyL3Jsem5lRm1ib0FjUjZxdWhQcTNHWXpFeHB4ZjhnSUFibHg4VGdlNXRB?=
 =?utf-8?Q?iv27u8Pbwa5YQB+/aaOwMt9mzR8fS9nBQDRFU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cjVjUXZMcjg5U2xEd0x3SnRtYnBYS0wvOC9sZzBDc1R1bnlnVTdpdWxGN2pm?=
 =?utf-8?B?Z2t1eXdWQk1PRW1PKzNyUGRTUlgyaEk2ZGVtTGswY3dPYW5lZDFLOTF5RitL?=
 =?utf-8?B?Vmh3cUxuYlFMY0ViMXFRQ2Q4N2JmY1RGVDNHZVNqUVo2VzdjNEFJWFpiS3pt?=
 =?utf-8?B?bmpZck0yQmdsN3BqUmZWZTQ0SWdSbGl6NU9PMzFkbW5NWGdObFJDODV0cGZF?=
 =?utf-8?B?SEhLdEdHVE9yRGJjdXU3UG9KQ3dGMG9lek1YYzhET0daemRvQlZFd1hPckNu?=
 =?utf-8?B?VzlyeEJZOXZKQ3F6cWxLblI1U3E0NlFpWU14RWJkU1ZlRVhSZG0ySjJPelJJ?=
 =?utf-8?B?NzBCa2VvZEhiS2RkdW1BYWJVQUd6Uit1TnRSU25mdDB2ODZBK3JZTEg2VUFi?=
 =?utf-8?B?aktuaVZ4em9MaEwzRWQ5Uk9aWHpmRWtuSjM5ajBoSjBSdWZlcDJ3Sk1CKzFh?=
 =?utf-8?B?VHVzOHVmMzBPTWVFTUd3bjBrdUhWMnJzN0hjVVdZZXFiRm1XMnJoZmh4TytX?=
 =?utf-8?B?TUI1VHdPUjk3Umxyc2Q0UCtZRmhXeVF0a0dzV0ZMK0kxbGhRM3Y0NXJFQlB1?=
 =?utf-8?B?U0p5TlN2U01HWExiS0VmanJQUkMwcUxoYThWKzhpMGo5RjZobTdmbDQyU0pk?=
 =?utf-8?B?RW1PSCtGNUpGQWx2N1pSVVlkSmMyQTJlcENWdm93MmFRamxQOVFhY08ycktP?=
 =?utf-8?B?SlhyT0plRmhQdUFERlNyOUxyekYrS3dDOGx2VVNHSUF1Z0hVbVlzeDJKUHpS?=
 =?utf-8?B?eW85cXAyZjExVzA5Qy96amx1UHdtWjQwTFJPdExXcUpvQ3p1UnZvSWNlWXpM?=
 =?utf-8?B?YUNORDJRL0cxRHp2VGQ1OFp2ZE9MazlSNkRVdnFsUzZybEJXcHNpOHA5TGtz?=
 =?utf-8?B?NUg0NTdrckVVby9FM1RqK0E4WURBR3BFaWdQaHBuaGZzRnFvWWxjRWREK3Bs?=
 =?utf-8?B?VVl3aWF4VVFxNGNBZktBb1BodW5wV0Q1T1A1V2srbkdJQlA0UmVDbkpYVUNy?=
 =?utf-8?B?ZHdtNnhIZHg3WHY5Z2pIR1ZzVE9UZnlOQjZjd2ZrYUF6L2Y5OUNWeUcyVWdp?=
 =?utf-8?B?QUlIajdUNDAycEVNWkxTNVMxWk1IenVzV3FKT2lDTzYyYWJWb3RrS2hwWm5z?=
 =?utf-8?B?ZTkzdmNSa3hxOHpNaGh4Y0wrS3U0dDFaajJJdnlJVUpqM3ZtUUVGUk5HbkQr?=
 =?utf-8?B?bzdlM2VRUWZqUlB3cFN6dXVjeUNDdkFudGVuaXJybmtBOFpxdlJocFZaZ1NH?=
 =?utf-8?B?Z1pHZjFNbDNROVV3NmtJL0JYVGthVHVVMTg3ZEhiTmNtSDdJencyY0RNTHVp?=
 =?utf-8?B?LzAreG16MUlRQnhhY1VjZ1NKN2RrRW05UXNxN1lLV1EvVDFBVVJrdTBPM21Z?=
 =?utf-8?B?aG5qV0xta3NaTWZLRGhHQ1NManQ1SVRoT1gxNzdNK0VPcXp3SnFzU0lnaEl2?=
 =?utf-8?B?QlZJNjZnTWduNG5NZ3k5bGNnR2p6dDFZdnhOOVZUT0VYcGt0R2xTRlQyU0U5?=
 =?utf-8?B?QUwzM0pWSCszUnVpOHMxS3JJS1dRWjRSTFlmSTY0S0VYOUlDZXdCOGF2Y2o1?=
 =?utf-8?B?TVFiZ09HMTl0Mi9TSzFQcVpkd2N5dzJVcGUwN0xoRThqREMwSm93MGlORW5G?=
 =?utf-8?B?NGphaGhuRVlHVDJPd0h1V21YQkh1dnFBcDZMOTA5S05WeWYxcUtBaS9PdDFw?=
 =?utf-8?B?Vk5kNXZpRUR2ZDlUam5ObUxQakxZSjIxUXZKcXBlUUFsUGhVaXVtTWZicURw?=
 =?utf-8?B?VW45OGZqcWRHWDJKNEV0bGRVUkFDaWxTaENIU0pocUZuWEhuSGJ1TkE4NkpN?=
 =?utf-8?B?TzhwSm9nclg2RXA3NC80R21Yb0czN0xZc3BDQ2h3SnQ3a29UQnQ2MGJxVlJa?=
 =?utf-8?B?VVNYU3JWNVBFZ3QxZDdNRldWT2kwZzN5WXdyMTZ5MTQydFhhR21Jc0EwVFhv?=
 =?utf-8?B?RmtrWFRleGZVYXZzZjJ0aEhMZDVTQ0R1T0JZNGk4UERBczNDNm1KRTYySGsr?=
 =?utf-8?B?WWo1VncycFBSTmduQWpWV001bDllU3dUcEJONkdRTWkzaDdlWjF3TTBDT3ND?=
 =?utf-8?B?OC9iWHBMeGVKcGpBbW9sYkg2Ujk4R2NURU1pbEdTbnRQSmJIUHRsWXVPeVM4?=
 =?utf-8?B?eGV4VWY5MWdtbWhxenRUTXNiUGZhNW5mZHNGQ0hFc0pxck8rYkNUN1U4ZXV6?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5781C11F2EB98498FA4AB8D599B8E01@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aj10IjixsB992sRv3gp74QZsVaAbXdf5bk3sf03P+NFNW8oRjRVHwaluznkfKMQy5H4ez2RbuYozYyExlwG/RLjuXUc7L7xaNDQuXhDG9Tmmaw65PwDZPe0z5vOVKzU2kMXLozJCvrNTNpv6p2Pw3rhNv4DuB7cCaQmoen3N7kM3B2EvvAAnxnvAl8AX5Wb7DjsrfyqOy4mZ29qeLCV9zbhmJuOjYLjo8RVmrKCPDStNE0QBhA3FTUFqCJsBVK4q8oj71pP8Mw+bYvPFt05lfumQaWHvZ42MIzyI8zzORsoBkx/RWu/+gMyzFXPiasSAuiZ465D/s8UM9hCwgEXOLx7E/ntwtRxdSTjGFgv3VwovnrVnetzOvKDcY6NkfeH9myFb0btaNIbOftwSbpsG9ayhTATCY3MWLAOw4hNim1lpU4a89fN89nL+639Be2iaF+aig6efNjgaELonQ4ayumh4Oabbjgt53o9UW5voiFd8u5yxEIEfqzMNnWDl+gh00YVNXOzUK9YGtxz2Vnu2cMW4IR6P9pGvP7pUevkAr7h3MS9QPnDL1BNo3ZtJqL70JmMem3ulO8lhB4p4AHOIOw8gC6LkaVfkl4QXp+uxKK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abd4044-ff83-41eb-a24b-08dc88af298d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2024 18:08:27.7472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQk7Ie1MmR6Uz035VJRlMP0/0tBSFkxLaI81Vn2xNHK5lWqZd3viZGSl+bFM1ZylSe5H3qKL6B1R9yPTNN/qYxa8lO4H2FXHLjbtvTewy0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406090142
X-Proofpoint-GUID: C273T4lJxQrrA5OUB1QOUqeylM5NRTa4
X-Proofpoint-ORIG-GUID: C273T4lJxQrrA5OUB1QOUqeylM5NRTa4

T24gVGh1LCAyMDI0LTA2LTA2IGF0IDE3OjM2IC0wNzAwLCBhbGxpc29uLmhlbmRlcnNvbkBvcmFj
bGUuY29tIHdyb3RlOg0KK2NjIENodWNrIExldmVyLCBQZXRlciBPYmVycGFybGVpdGVyLCBWZWdh
cmQgTm9zc3VtLCByZHMtZGV2ZWwNCj4gRnJvbTogVmVnYXJkIE5vc3N1bSA8dmVnYXJkLm5vc3N1
bUBvcmFjbGUuY29tPg0KPiANCj4gVGhpcyBjb21taXQgYmFzaWNhbGx5IGltcGxlbWVudHMgd2hh
dCBmdHJhY2UgZG9lcyB3aXRoDQo+IENPTkZJR19HQ09WX1BST0ZJTEVfRlRSQUNFIGZvciBSRFMu
DQo+IA0KPiBXZSBuZWVkIHRoaXMgaW4gb3JkZXIgdG8gYmV0dGVyIGJlIGFibGUgdG8gdW5kZXJz
dGFuZCB3aGF0IGNvZGUgcGF0aHMNCj4gb3VyIHVuaXQgdGVzdHMgYXJlIGhpdHRpbmcgKG9yIG5v
dCBoaXR0aW5nKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZlZ2FyZCBOb3NzdW0gPHZlZ2FyZC5u
b3NzdW1Ab3JhY2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxp
c29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogQ2h1Y2sgTGV2ZXIgPGNo
dWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsbGlzb24gSGVuZGVyc29u
IDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KPiAtLS0NCj4gwqBuZXQvcmRzL0tjb25m
aWfCoCB8IDkgKysrKysrKysrDQo+IMKgbmV0L3Jkcy9NYWtlZmlsZSB8IDUgKysrKysNCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQv
cmRzL0tjb25maWcgYi9uZXQvcmRzL0tjb25maWcNCj4gaW5kZXggNzVjZDY5Njk2M2IyLi5mMDA3
NzMwYWEyYmIgMTAwNjQ0DQo+IC0tLSBhL25ldC9yZHMvS2NvbmZpZw0KPiArKysgYi9uZXQvcmRz
L0tjb25maWcNCj4gQEAgLTI2LDMgKzI2LDEyIEBAIGNvbmZpZyBSRFNfREVCVUcNCj4gwqDCoMKg
wqDCoMKgwqDCoGJvb2wgIlJEUyBkZWJ1Z2dpbmcgbWVzc2FnZXMiDQo+IMKgwqDCoMKgwqDCoMKg
wqBkZXBlbmRzIG9uIFJEUw0KPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdCBuDQo+ICsNCj4gK2Nv
bmZpZyBHQ09WX1BST0ZJTEVfUkRTDQo+ICvCoMKgwqDCoMKgwqDCoGJvb2wgIkVuYWJsZSBHQ09W
IHByb2ZpbGluZyBvbiBSRFMiDQo+ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gR0NPVl9LRVJO
RUwNCj4gK8KgwqDCoMKgwqDCoMKgaGVscA0KPiArwqDCoMKgwqDCoMKgwqDCoCBFbmFibGUgR0NP
ViBwcm9maWxpbmcgb24gUkRTIGZvciBjaGVja2luZyB3aGljaA0KPiBmdW5jdGlvbnMvbGluZXMN
Cj4gK8KgwqDCoMKgwqDCoMKgwqAgYXJlIGV4ZWN1dGVkLg0KPiArDQo+ICvCoMKgwqDCoMKgwqDC
oMKgIElmIHVuc3VyZSwgc2F5IE4uDQo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL01ha2VmaWxlIGIv
bmV0L3Jkcy9NYWtlZmlsZQ0KPiBpbmRleCA4ZmRjMTE4ZTI5MjcuLjNhZjFjYTFkOTY1YyAxMDA2
NDQNCj4gLS0tIGEvbmV0L3Jkcy9NYWtlZmlsZQ0KPiArKysgYi9uZXQvcmRzL01ha2VmaWxlDQo+
IEBAIC0xNSwzICsxNSw4IEBAIHJkc190Y3AteSA6PcKgwqDCoMKgwqDCoMKgwqDCoMKgdGNwLm8g
dGNwX2Nvbm5lY3Qubw0KPiB0Y3BfbGlzdGVuLm8gdGNwX3JlY3YubyBcDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRjcF9zZW5kLm8gdGNwX3N0YXRz
Lm8NCj4gwqANCj4gwqBjY2ZsYWdzLSQoQ09ORklHX1JEU19ERUJVRynCoMKgwqDCoDo9wqDCoMKg
wqDCoMKgLURSRFNfREVCVUcNCj4gKw0KPiArIyBmb3IgR0NPViBjb3ZlcmFnZSBwcm9maWxpbmcN
Cj4gK2lmZGVmIENPTkZJR19HQ09WX1BST0ZJTEVfUkRTDQo+ICtHQ09WX1BST0ZJTEUgOj0geQ0K
PiArZW5kaWYNCg0K

