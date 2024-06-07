Return-Path: <netdev+bounces-101599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568B88FF8AE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBF1C23A19
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1D1843;
	Fri,  7 Jun 2024 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZ4gnG6L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HIsyrRbT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148719D8B9
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720602; cv=fail; b=FiPUGWAjZAwSafbsT1uwikaxikwXU09pIVsNum06p3G6oOPD9gWn1RjpLBeO7kSj8Y6whjXzgyr1mNtX0yN+SdFf8CJO17JRia5F6vQBOZVA2DL1jS4vI6l+BA4ZYoDaNsgltPPBU5OwAQfHGSjHWpVKeyyPfT8BvXSEJrSTyBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720602; c=relaxed/simple;
	bh=mEJ8QESYptLte7v+DViVL5kEU1MQvt/hUyC28W5LJJw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NoxknCIr+e+xt1zbt5BTUIlBs8lyxrdV2rCHnAYbBUNz71Na/CkGqcPwMuP9SJXVzbufi+OGnh4ZAExl05FHInFpPqEe3dabIMCeXK8lL5vrEk5x6UhO6Cmxymba9eVviC8816e7dDS+GHg4Z0YZu4y6bkQCL+ftg5IoTCIsbh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mZ4gnG6L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HIsyrRbT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HwjVS005621
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=6g/Y0ooV8va51Cv+UVH3yTNh6tws6d4m/wYs1HBr/eU=;
 b=mZ4gnG6LJHSAwc3RY46kyes5VdGg9BK5IThBMaC4sRm0coixmEh6Auvjh4GUh/TkPOp3
 UtTSvJn5V2hjOk2qY/cZpadQxwAnjogJsQZ2qnbPGs8AaRXBIOLuIb8S/+mnCTNuYHz5
 HzTf/quPKUnAYpMS8GF1833ZMOk51p7b42op5HWfF7bahCMd4W1+vlAoiY/119yUDJqe
 WXTA9IRWbnIePQPHdPw0yug20mUPwNYQj6oS6Dp8MF9Blq8TBrZ0WOxUbr9eHkLVSORa
 wYjHVi1gW40f1Wl7N2Vox5skYzzWpW3BO64GrIf29O2iF1XooKOLWWK/ljJfPxnc/AKh KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbusvm69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45708Sgv020558
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj5vqfv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPaBI+wH1BAmUguvsD6pKVAz29GJDkn1G8RyEu5DeJGJfPEcJv6ILLIeanEij3YSrahWiXDU//oLy62kCCh6BF7w3vvKFTkS0cIKaFisINwVu+2ynYd3hF9H5ZElzsWyv63RsvxXtXSlKw4e7W/TkMvg9KZ1+p0m9tIUB3TC0SDQMW7mz5igmf6f5YCODlXnb1tvqdHz2s3OgVxeuCq4SDVw/0L8ON2jLT6AIABiqV4voggWZ6S/+k/MSu8BokFSV+j8/IySM+Nd2rMAK6zAaYuIF16Rh5bcODnmPVRBEoYW5SN1qX8AAf210P7Q7VlptGL6GiARKMQ8pDm47WQj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g/Y0ooV8va51Cv+UVH3yTNh6tws6d4m/wYs1HBr/eU=;
 b=WtigUAKP6Rt1P9zkvOhI/7VTEzxKrtg5ovtcgsYEk6xxoOF2hIRFkOat3lNqf3pXZLBwquzImBETwXccarsrGn7DwZS+XAIMFH/xlaGEqJU0D02YuLiY7mqIHG3rbTnVW1mnJMbuFlzqCGA5VM/DeA3erVOOVr+EBDF0ZlCx8q4oxgyAKAqd4QVn4xjfjrzpcMCS7Y0epJx9xVxEfau0rnmCa/VCMVwjtOOE0crF8Xf0UbZmd0KZdfVtisq+ZK2k6oTtOLt94FNC/EloT5x2NX8wwnm5R7j1KMQmfoThVmbhROc4qP2+r3fO1vx4VSeF78kP2SZdLWD24vvnh8ntRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g/Y0ooV8va51Cv+UVH3yTNh6tws6d4m/wYs1HBr/eU=;
 b=HIsyrRbTRJKu1FICPYVErnz+SoZ0gKiQAJkSK7srg8438iAy5WpAPt08ZIFFYukVUiHJ2xCMxEaTmDXCrL7JE9x1EIGoCSrqxPc5Teh97W35gQzz1T2wuLs7erRDkrQWMBZDD7jL0gd/iDNgXUMtGWb2ek0VWRqyuOxEyicierI=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 00:36:35 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:36:35 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [RFC net-next 1/3] .gitignore: add .gcda files
Date: Thu,  6 Jun 2024 17:36:29 -0700
Message-Id: <20240607003631.32484-2-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607003631.32484-1-allison.henderson@oracle.com>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::28) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 157ffbcd-29ee-47e8-a6b1-08dc8689e2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UMZXCUWEQG4NCwF+0maF84Z6UOEnQcgdA0XLSsRmxhGKw8J65CwMbQKOw6Nl?=
 =?us-ascii?Q?jd1Iu8siICbt39fHjKW8Ay1iKd4yHS5vVfi0F//at7c+yc9LnInWkjzXvbOp?=
 =?us-ascii?Q?es6TSL4PCYFIBimb1vQCkA7hRwcOWsRGEZfi8LucfblOMtv1mNB4d6r/BtYn?=
 =?us-ascii?Q?REZw3bZOuU81397QSoMx1IhHILRcuNCkzq0HIZqA53BqHIknTtFXTC6zD6Zq?=
 =?us-ascii?Q?SKcLlSeFGuQaaI84nGiUDd0TEnh7gMHGefvnIa5kJ9/RYT9cUzk5RtCrOQIY?=
 =?us-ascii?Q?x/Uu1kgyOmDyufejxT2U6lYpSS/56mBUgad9CHV6TyQVwdz4KU6rTk+fhXel?=
 =?us-ascii?Q?45MmAXHGdO3v1/zEiX+MWRP9C4JMICQCn5f/e57/EXMJj5p7IcP1bm3XmXjf?=
 =?us-ascii?Q?5LXhmdtZipjvOgeUo2xRE5T3nx1Bphm9kH53Y+LnLVhVKRdmimEU5E+3NFV0?=
 =?us-ascii?Q?nkgXbspeobsJkfc25vL7SzrZ+bWuiZfiZFezUUxDeVmlsvSuHPtWrK2EnPb6?=
 =?us-ascii?Q?sMuI4RQVBThDQO8vKUNQQKikFf5BsickndwPYMjUbK9LhQbXXUBmr6tcz/Z3?=
 =?us-ascii?Q?snNWL5MfRpgYuE7i2Ql43SWEvzalHAuaAnm8ELqr5yk20rNU9XWW+6LRG0M4?=
 =?us-ascii?Q?s9rrcoaLQmk9wprFWqoJDyF4bM2xyFe52IC3t11BJFsH7acFDiiSQU98EXZB?=
 =?us-ascii?Q?sDtkCcJTcCz4NBO6O/tbBMBBBeXpr23scw2t2h2SlVxykvOJtCrpRsCcAJFd?=
 =?us-ascii?Q?SHyHab0jcFXA/ZDbPVL/510PEk+xBKVdQKuayUzqB+yQyW9zg3wDWey0XvnE?=
 =?us-ascii?Q?7n0idZJfaWK285n96oEXhVksGAexfwl38NKOyjtjGtq5b7b9hFo4AbJ/JvrP?=
 =?us-ascii?Q?rYCdi1XeD3xA/qveBdLKrB3eDlNe0i8ex6J7faI+NijhOZ2uFejT4TyVGPSS?=
 =?us-ascii?Q?EuzE5gcvBWbaSileFrPsvq31rmTgJAXb+/jbGJGNXuE6sL0y6nEOIi0U+tfk?=
 =?us-ascii?Q?+73cqJaZq/sNcUwYkxh/upeqnnT9xSuLkoeTdOzo/qsUVoSQwrxXn8ccNT4V?=
 =?us-ascii?Q?qHd6A155wDLnlCgWpeI1+1NxOFXAtUio4/6Zmvzv1ntFT7EiiswFN0W3LUkv?=
 =?us-ascii?Q?9xlQW7iWfP17MFqdvJK60rMNimo6EXdb/tA6D4yDLU/3fVDl9hg/ri0GyAZJ?=
 =?us-ascii?Q?6zksf48AZrgRVHdvqGFbJfajZk3vUrvcGkz9RhGWQkPJd3S32yrMhjceIf4g?=
 =?us-ascii?Q?POMha51Fh1tLZMizJQvODh+7NW6ZmCwMC+d1Eef6gbK5vY82H9A23kAQRCWr?=
 =?us-ascii?Q?KIc2zgYuHM3PliLNFHMdJh7w?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X16lFui7DgTmspCvbEn5ZkfVCgK0UxUqJ0yI/tXtokltdsgNSiVFBCqJPuye?=
 =?us-ascii?Q?8f8SSltziBrmQGfV38TnNPjmLLlyTHBh8oPvpSlZ77McVsLX8FVKrIJlTTqI?=
 =?us-ascii?Q?AhdVyqspz8fIncj0A4heXH4KEu1kinEx+wpGOVIFBVWNEonfeGCx6zWLSsQH?=
 =?us-ascii?Q?p8GYNOEBzIuq829GWxyy/TyXEAoOv0s7FfUpEgW2d13SSstDL96rA7sS61gd?=
 =?us-ascii?Q?eThNAiKYHYSAXHULKIfdtu9uPsxKSaV58bB6oUdvwNalrZYjsy+oxu2kJM8p?=
 =?us-ascii?Q?xeVno1lRwEZi5cK8frEOr/e2BqivFDUkcYaveXCVdJf4fz++4fZWN9mNyd0r?=
 =?us-ascii?Q?PnOad/9SItSH+Wrxupzp+ly0ySax4zhrZmZf8wPjvVu8q7c29MyMARzUjqRP?=
 =?us-ascii?Q?07+k51YPz037gM1YOkOg+XMHK2xIGSS6L39jgLojIxZ+XM/gDuhSNSIIZyP5?=
 =?us-ascii?Q?BsrAny/I0FQLOhxCnThu5or7ozGHlasSdeM2xS1UMmnNhC/XeEhqwLUrAfaJ?=
 =?us-ascii?Q?LyX7hJdi4qVHbtE6GEdCN6pRfsiJExmdX/IRgyvTOlpajUN7Fs+xMabJRv+z?=
 =?us-ascii?Q?JqSeJzEusQbT3nmUheXr1urghtOAB2ArOBtJaXhSB4eal+3GPghPAzDHTO0C?=
 =?us-ascii?Q?wO+EJkhgM3I0z8YFvmuj/pRkLVjyvWQAQJEr3i6ULeq18kZgcWMKbC8gCRr9?=
 =?us-ascii?Q?OhJ5Z1Xd2WklXsnHaIKBLFzeOiZMEYJAEf9SFGv0TrUFiUR61wqT7MhjtNyx?=
 =?us-ascii?Q?GbLheO9o3yaTDVyyCXuYTT8W7Vopr4Mz+LAXZuw/ivneFBQ9FGvo7Ps3diZD?=
 =?us-ascii?Q?l1X6Vp6+qUKtCQSxs2db4hDbPYqJAkA4GM8XcAaFTGKoArBrGrHM6+9dfTgo?=
 =?us-ascii?Q?tAldPoONESdNOmsrdssCxazgyeGPu/3l/kgbELWbhp1kHJO6X+6z5ELZ5EOX?=
 =?us-ascii?Q?f/k/o+86uvSUtJQNe82Yh0LRB1egKOucqhLqFDG2ySNugT/MR6bbO9FGUZHr?=
 =?us-ascii?Q?j+4jAseOM1rBZaynlPlmUmGhVXa5NyVR0Qiuet/m1/D4FDjX33XMyQrz8uG1?=
 =?us-ascii?Q?z10FDVa//Sz+b93JruRD5bVJWv+BwrEgTdQza5RPYZIfyTAfSrPuHMlr0xez?=
 =?us-ascii?Q?BwlxbkEjyqiA8bMk4NntecLjfdi0c0vLHIK4RzG9AVA1fy9VzWfTnTSHdUI7?=
 =?us-ascii?Q?Et6bIh2Y71xAsN3DZgXaYQ0r6F2poLGpriuKS9YPnxB2Ql7C8cseqPRpLgOS?=
 =?us-ascii?Q?LSzoLuQ/muDPqiUtsniDuMH/qsRw4bU8g/LI5gJarBh4NOpLhtDlGHQpabQr?=
 =?us-ascii?Q?y8uNJzT0A+K7Iwn+HbfhxWfgOepooqzdiMDrhn+fzRaEMD1VmeEvoCpyUFBP?=
 =?us-ascii?Q?dSe+FHyTB8NOpeEO9beVczrfPdQLGGPIRZxZ1eduAl+lkqICCJ27jJCJuGUC?=
 =?us-ascii?Q?i7LRAPMuI3z8hoET9WXIg2ZgAlHxUSoE4h13sAdzu/5qXigE+UsbO7L+Agk9?=
 =?us-ascii?Q?TJT1ekP2hX0McX+ezv8y5Hh1WZDy4MzwOAAaAZIt+VoV0ZmtJjiYoPDgOBjL?=
 =?us-ascii?Q?/T75ZSfqo0qwnQfYHWQqH5w5+0xGvN2Qp5PSONdxQ1R3xhL4PDzIcvd3rujw?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	53s1Om6lyDdoMFRsI1EDJ42fqYHHwf9nh6M7zfNBGLwSefLhoI/zUW5INL3zQIHi0tIO2psGziPkR+1qjELrWRCrmEqrEenZgiBXs6L6n6UmyXHqD/kuRoD0YluyivwsmpEkTHi5ubVurw1g3dxEzwVPlXsPC9M7hFFUJqdEdOFwfJg2gzi+20j9eAlaGxtGYBw5OaPnDsy6tU6sTEI4/0u4eNTU8JhyC8MCcB4lbwAvmZ/NbFoX+h1CwvBiXelZFjZ+/idj7EHhodCaBXnNp5B7K35DWjNL93iWFcIyZEoBpXZbfUsiR4KJoYGEq+Cew26UO2uJdT9D6TpryaaYuJuSA79KwgZyJ+ZWnQkRI44h8btl35j+ibf78VAAZCten47Mvssre7D/i+GhoD9i5kgCFMfVl28um0kkDhVCPQ7rnVO37KeRk+cuF+nJlRzFhCwXZT5iE7MqluPaLkJwlRpjP1FMsETOCg8z0yIWJiDBzwip0qfPiySgte9DFW+bUC1RHAbhbLreffQzERBRdYk51YcCmp0eTGUoAH/DPMU8GLOAsoF0uhSOQfEN4wQf6zPLaBgq0HN1YS+ofoKtcQk98kJYmR/Jn7FM/A7rpHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ffbcd-29ee-47e8-a6b1-08dc8689e2aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:36:35.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgw89qEOeDz48mXStcqXpztdXKcn6fkzYOR9ZXcKJPvbp/BI4KL2thlebxAbr5ij555Solu8+KsSvaMQ7sfgi174SwQ/gz2tuo8MnbceOCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070003
X-Proofpoint-ORIG-GUID: gzL5r44mr7t4Dp9QFIHUD9I9rQt26WOl
X-Proofpoint-GUID: gzL5r44mr7t4Dp9QFIHUD9I9rQt26WOl

From: Vegard Nossum <vegard.nossum@oracle.com>

These files contain the runtime coverage data generated by gcov.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index c59dc60ba62e..8ff1b4138c56 100644
--- a/.gitignore
+++ b/.gitignore
@@ -24,6 +24,7 @@
 *.dwo
 *.elf
 *.gcno
+*.gcda
 *.gz
 *.i
 *.ko
-- 
2.25.1


