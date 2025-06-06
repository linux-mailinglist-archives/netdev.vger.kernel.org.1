Return-Path: <netdev+bounces-195429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D49AD0247
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DF5189739A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944FF288517;
	Fri,  6 Jun 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="HC4OH4e0";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="IF3dNaLl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D176288514
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749213361; cv=fail; b=N/tuKVAW+BK14GI3u9zKlytmst7kiWwqOp+WonJJEWsYb/2LiN3seJ2Jm9b1L6tsqNg8A6erNb+LpM6kP+lAx9Q3FtXN9ntw0RPtIwNWOJh4SpLZzM9FUlUmbu0mahOKbbFdR2cxoCBu2kltE5iJ7YUuvQN9HVCYRzpkLDDfXfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749213361; c=relaxed/simple;
	bh=bC4aKficXzaqwezxg4SHSZHpxo6If9vmxOTmagnv1GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbsZCvBjY/c4qH6AQRC9BY6/28EaVJJb9VQqOO7NT+UVIBKxdC5kb+aho+GAJuSD8bLYXJEKR967oNeS83VuGnaNZkUi0x0czX4fVe1v8HIC0/7saPSlb235a5ttfLa5AbAuDKiS/oKl5pAhhpgZRJwUICBzaSvuaVthNHUjQ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=HC4OH4e0; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=IF3dNaLl; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5561VcDd023024;
	Fri, 6 Jun 2025 07:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=W7hv7r6dXgbqB0zXDOKoBr+qtXFAx7j1Y0kLyXJc0So=; b=HC4OH4e00Dft
	1L6FW8BYwFGnNksOMzP4FcjE2tzcIOWF3HtXfPBmY9r0hndMnQpK6IkWwLgeyrLB
	g5Da7ROb/RzFqA+J80fbDfWhdsqJ/dlvpocxcvSy07FyxzgdfGdoNa4oK96xTG9l
	9aAMl/XAAmgvmGG8v+WxhXghhQbGzmt7J8aoY5oUrwwOj/F3SzfrX0LzqMmhGn8o
	5i/ueTKi8loZrSNzsWxUfoQH1apokpF/rBEFXkHu6ONXXorXWMRQ5/qQ/2Xf9Hkg
	hdtgRMKFWgH2gEVapXXLJADHLYZmduI3TR/SEVz2rn8LmSpWZ/gdjJedzshBdGfu
	iLeuMaFNsw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2102.outbound.protection.outlook.com [40.107.244.102])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 471y3f7cf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 07:13:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtMmCHPwnL5oZ1OZEwhDlFFpL/z7DozKc+swd9GhEjKYIVS4g0XbYz7BZ6KFBnHP00caH04O64cXPVgERtNrFXSHCbzo43A+hebBERXwKp4Rjc1+wIx07TxIa3ghnYqD/fvEcMdAbksoR5PqguJOj1oSP35363d4CN8IhK1Yw5V36QlMHd0TwZZ166fXP3/JS6ZgAGXOCX6HwhfX2XEqlZJCrqRRTjgeDjGSohCD3KBLNyMfG5rW4ST7FG1VAB9oJo6mtXisu3rVMHwSdZEpMnNB8umKPWYtVz71JiyrYz/64onOC36CZLwtBOvXlKC/NEiE1Rjz6aj9mSUD29bo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7hv7r6dXgbqB0zXDOKoBr+qtXFAx7j1Y0kLyXJc0So=;
 b=sXgTkdOCyPwR0iE+wjXcOrdOQmdWhky+SgRqim9Mt19S1HsN6Yx6BKMys+bf2X9RCHrauUxWMSroqAU4QT0fGhT/TAg51R60B5nvM3ardqidJMYnSsr5ZH6Q9Jjhz8RmvBCXPAl2fBqTVZIC/oykSTlNtcT2i/qJAXBZmMJzFYDPH3fhsWWb6ACSexwh0Ng08lu7qCeUsb/+Ip27PjcE4pUEPOWnTKKyG1QtCW9QMWLQr4QYgpspQzdOVpx2XUlKfN1lZW1oVKZCotzTJX6ti5jGLP01/MhbXFF19s3loZH4kDaMrMwAkWMyCJHGc3fEEk1mnSL4A4yaXmRJx61N3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7hv7r6dXgbqB0zXDOKoBr+qtXFAx7j1Y0kLyXJc0So=;
 b=IF3dNaLlpFoVt2zhHmp4ThyeznrJ9GtgPv+sAUP6Oh+WeJfp5bzX9F8pNLT1rcES9RLDvau7RJz00lrrZUzjxykh5vzWr7qwMbJflKebP2SyO/4CdYIOVNEN3Ez0HRYWJqWRKh3SE0fVhLLDiSbP2TkxmjdP/07K17V80lX97eA=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Fri, 6 Jun
 2025 12:13:22 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%2]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 12:13:21 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: netdev@vger.kernel.org, Petko Manolov <petko.manolov@konsulko.com>
Cc: David.Legoff@silabs.com
Subject: Re: wfx200 weird out-of-range power supply issue
Date: Fri, 06 Jun 2025 14:13:18 +0200
Message-ID: <2328647.iZASKD2KPV@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20250605134034.GD1779@bender.k.g>
References: <20250605134034.GD1779@bender.k.g>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PA7P264CA0338.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::29) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SJ5PPF2F7FC4EE6:EE_
X-MS-Office365-Filtering-Correlation-Id: d343156d-5789-4b2a-99d1-08dda4f387a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?CiKTdG+G68GwoG55GMti66LWUoEJKpWqpnpoReriiVVPBKsUi3lrg+HPqa?=
 =?iso-8859-1?Q?ImM8Jd5k3xzP8kqRoKpcpF8eKWaK1q7EdSc57LaWBUnCk+WyGT9togN1YY?=
 =?iso-8859-1?Q?YLbRjSUXCumcthvxrpmswe2L3EYBceuf7NUEErbnbV1+kwvGPhaHPvok12?=
 =?iso-8859-1?Q?65I0FKUhwMhA/5XADWFGhPvvRoystuQiJgIWV1NPDQVOydGEaMPRYLvqNw?=
 =?iso-8859-1?Q?Lzm5US5Ok5DT3eytMg71RBDJxFaJBK2tKSJ0f6/Z6j25Z1+2KfI5Svv/t8?=
 =?iso-8859-1?Q?V01bcHvJq0VpljxpKoQSkgy1sssEj5eqt2KQSqDkOWqNjx8+IcTYtZQGwX?=
 =?iso-8859-1?Q?QGgRpjkZmfhHZX4mjrJCMO7I9WEQwBL1CxhgeLAYfDpnjLqGC/LuTkG3l7?=
 =?iso-8859-1?Q?uVUowM06jnsye/MNmdLYZuOe6nm1UsCHnWOOOkFpwsv/ld25sGkNMoovfH?=
 =?iso-8859-1?Q?RuaHiDpXlNAlH+efxgS5+jUE/MenV3Iw7uREmImZkVj3gsJrwuXmzddpUj?=
 =?iso-8859-1?Q?ozZNZfQEmrqS7wZ+8xsFP5qH9WKU+WK7I7M5bx7ceN0fGf1fZSm3iJAURC?=
 =?iso-8859-1?Q?CPbvs6N6/gAW3Ysaxg2r2G1leZqamzBmkq/m3n/okkW2i7BVEhH4s+kwcT?=
 =?iso-8859-1?Q?ZrExmCN7N165kHg3B7cNrH2FQeE8Kyj2atFMIWG23FRJhUxH417Qa3Rk7H?=
 =?iso-8859-1?Q?NCHiGQL9tx9pFsAR8Ukrk+dXLoFEntAViE11TmN74Wjd+KgRrjKbgmqoLj?=
 =?iso-8859-1?Q?oAzfNuei7E2HKxRM5guG/8YYLmUKppeC5pkALfh5Es4iy4pk62fW6c8we7?=
 =?iso-8859-1?Q?GBctKbDfXfF/Jh7wCFl55oiuy2y9gR3Sk1tnC9ygBghhhN3kHFQsOCc5yk?=
 =?iso-8859-1?Q?hChjwbc1akvec3VwV0v4IgC3btplpifuHTe71fFMdV7CETiMzD4y47a5Fl?=
 =?iso-8859-1?Q?wRM3YEnIByTeGdu9eibDAWwUPGEhHFpmg8/VOej2XBq1DW1aUPiT3PLFwU?=
 =?iso-8859-1?Q?KeHV4u1HB5yELaoNXUgpOuRhr3wzM3jFFndG8T1dPIWt9ryyypePycisxl?=
 =?iso-8859-1?Q?F1ObYqGZFPrzb237IKDifgzoMFGxkIwty4CZ8+pc5o7hP/Z5U56hIi9ngx?=
 =?iso-8859-1?Q?yHNgJiNddvKe8wAsJyjQZ35ahOhBETtJZL05+vRp1yiX9ROPL+FPbJAqCq?=
 =?iso-8859-1?Q?YIZrFFlnf5CvWlSK3QmM5re4+p0pMruWr7Tdd2Xif34a9DSLHndd62n30X?=
 =?iso-8859-1?Q?adN+eAjPDFdPSsAFvUYcSX8801B0ZRVOhVgq6rJEJIBW4hW9MWvR5v526S?=
 =?iso-8859-1?Q?WOJyoo8s/IqotBtXfr9r4826Fysf43ORpXks4gOWesihnaF9zW4/d+CvJa?=
 =?iso-8859-1?Q?AdHNn34LSKoWQvuHbGmr7TuCHLmYyDORK4XCgUb3knjRwBYddXnbeFXe1T?=
 =?iso-8859-1?Q?Cnz2Cv2LniO00Js3tEcii0aU69Y+WKJ0MS4WKDIOu/rELAStQIuJNFN0/E?=
 =?iso-8859-1?Q?cHyVSKo/PvZKzqj/cZDwtSv9gIH1PZaY5I7kqzhpmXzF52buFhMf+9k5vL?=
 =?iso-8859-1?Q?r/Zfkx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Ti+eA5wWAMURygfDqjj+FdRyKmnLn1MekKfs4pJGp2k9R4HzDmUP9uDkR+?=
 =?iso-8859-1?Q?wM90RC550LpKx7+H2mWK85yVdvQ2y2koOos0amU44uNgglbL3ELWhibq/v?=
 =?iso-8859-1?Q?mU/U6UfbgY7lV/U/6bIRrK+f96TJtb84NI0/65asXHRfBzowcQf55cEw3r?=
 =?iso-8859-1?Q?xZpcHuHMITLjSLiMA4NoEA3OwJAkGvq5j+Uqpf+mK/fYsG4b/13ewGGGmb?=
 =?iso-8859-1?Q?uwyjE979/leiCqCGZKC4+935l5kCSVbaKYWUZlG0Qo0Vb4SM6MPvWx+Ve1?=
 =?iso-8859-1?Q?8E6Dx9tFKb9gxtwgqgDxMh1ul4Rf9qvrgMnkHqCc87h1INKP/GhqYVfTTu?=
 =?iso-8859-1?Q?e7DTgsu+rjY7YJZwGEmsWMySL8f+sag6YJMAVBGeyNBBk49NoSqIuGAlQ4?=
 =?iso-8859-1?Q?01p96EkmJ+xw/2DT4k+Np+iatuFAH9ncIFGRp0oslpDbAcrG2asXoCpCMm?=
 =?iso-8859-1?Q?4etRS7ZiNKGx9o3MYg+PLbl7ZmGJNX2RwOiFFVllN8GYGsNbq8qhFvHk1q?=
 =?iso-8859-1?Q?lKotmNzHIVK7PxUjgYI6MR4Ug4vroyGMCMFy/K05pJD1LeQgtKs8pyYRYG?=
 =?iso-8859-1?Q?PMpCJqlpW0gdou2+TidclRt2xWIILJoaSQkME3HcUtpjx2Tf2wcLu94ZdX?=
 =?iso-8859-1?Q?Hyi9/gTo55//of/VyCMv1GCEY70qy+LIr4jmsAcPkW0FAFajZlUR2TUdK7?=
 =?iso-8859-1?Q?Bh6kZbqkKwSYe6waKKwlMGuJ2qEU/Ro6PD1bUmJBW7a1/esluTqZGs1Eq6?=
 =?iso-8859-1?Q?UZuaSUHLeq57zbEewnJBphO4fO3IN5Tv5hve+e6wkDopyRCv78btHmTnga?=
 =?iso-8859-1?Q?ZHfIbljuX+nPEcnTy2FZOJVh/55SnlsPa9yD3+ovriz8jgM7mj5PvtFpBf?=
 =?iso-8859-1?Q?fVwLZFLidr97ZOLqLqNddPvK4yk4v2R/OrxbkWY+ZrsGSjTpCjKnuhPqT/?=
 =?iso-8859-1?Q?wez5mVwY37zyBvyJzEccnoRtX6Q1kWAYja2l3pTFXRtaufG+DkmCW8dlew?=
 =?iso-8859-1?Q?8NejYwQqcSQvDBI4k5IAs3yXqxyE7MDZe/Ffl0dk0RJqnU/ueFUspqBpdF?=
 =?iso-8859-1?Q?et2ZV9xrPoTfShpvx26kri6cBERQto/Oq5DCLl/UqST7WV5JfH/L+NQ3of?=
 =?iso-8859-1?Q?0ERtnmAEi6n6XLIwv48lZFKYNnAIzv3pnnmC20wlp6UZRyWFs6vdMXh90y?=
 =?iso-8859-1?Q?Jb0ZqLTMhiiZQM42vRvrxaAq2Nj+HP4W/HFHXVAssdNvf3Ks59vH9jI1Na?=
 =?iso-8859-1?Q?i5dwPyg2p+hF57dNxCCD9PAKhNVIlMcVRrP/6nKyHvl5E0IEBXvEOBX1Bz?=
 =?iso-8859-1?Q?ECEw/nqEIS1uo/UL22RppSNpv7Dsr2grSxIj0ivokaHMETgOXSLrnJglGX?=
 =?iso-8859-1?Q?EVE4zEPoL8k0uPEn9XXLQraRJcc0Un42hqKiN66ew9PvtaB+UBLBi4P82F?=
 =?iso-8859-1?Q?C4xg+MvRgyL3EybAAN2xCDZGFMltbNC1/NGnC2dQcoUmts+bK/+Kk7ODjO?=
 =?iso-8859-1?Q?Pym5P2gX/62Y4AUP+4+mt+tr9O3+OaeXF6O4gdGPmn8ReXR7ihAQM/EBJs?=
 =?iso-8859-1?Q?6xdg7mP5TAxbxOueJzIgErY1QZ6gMuwpy5byk5j3SdLxU5oaeP3ThjTu0S?=
 =?iso-8859-1?Q?xx86rwjBVrshvBeczE6aXpP3ZTlWUn+dJt?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d343156d-5789-4b2a-99d1-08dda4f387a5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 12:13:21.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWOvdGOUoj0i6Pi+NPQwvDFfUs9pfXQbb3Q6JtVhz4HQg43z8cf//lsQUj7hn3LPN2HiarD8QwqSYwokK3sfUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F7FC4EE6
X-Proofpoint-GUID: FkmYDSGQrqoRe0JuNWrtffVayRL4CK1I
X-Authority-Analysis: v=2.4 cv=Qdhmvtbv c=1 sm=1 tr=0 ts=6842db66 cx=c_pps a=9gLQ5x8al0JNtgwQaIz4mw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=LLPZWm0_0O8A:10 a=i1IsUcr2s-wA:10 a=YaDLGZMsjepbsrSaYhEA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: FkmYDSGQrqoRe0JuNWrtffVayRL4CK1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDExMCBTYWx0ZWRfX4/8o2+jHUQis ctFWX7fTxBNtvZLKYoiWCabzkT9fQW6X9bIyNVeMOG4cB9SVBmvIRrqhfUt8sisGJKd5CU3hrkJ 31DAgB2tbjpNAlu39eqG75Jo8MX3oG1rcIW/7fblhQRurwNiBRZCpDGsQn89DU/Hc4c/8LYzKmZ
 0T5N+CAi9qjhjiOlwquy6WOKhXGXiKUnpeNhZcb0GwQ1q+zu1DqzdCbPGCJaL9GM5sZVrtlfpn/ xm2zefmdyD4VIUhZRs8U6tsxj15EctSl8sTGXUBKvERlHHGqIIimHGdPcSlpsohiYLJ9caB0BMu vp+uL25DWEUXssOpZEgY+dDLfCu0X4P4VpR71rzMpozFgad0OpxPL3AHhgCW31PNe1suycEXrnt
 TC2wrld4Ql8mgVyKpuI1R1UuvhBwWguKitT+kgf0/M5SwV3N/gnL98I8g+seRJ2wCi+rcVvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506060110

On Thursday 5 June 2025 15:40:34 CEST Petko Manolov wrote:
>         Hey guys,
>
> Apologies if this has been asked before, but i've searched and didn't fin=
d
> anything related to this problem.  So here it goes: i'm upgrading the ker=
nel of
> a custom stm32mp15 board (from v5.4 to v6.6) and i've stumbled upon this =
when
> wfx driver module get loaded:
>=20
> wfx-spi spi0.0: sending configuration file wfx/wf200.pds
> wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage: -2=
0
> ... a bunch of "hif: 00000000: bc 04 e4 15 04 00 00 00 ec 00 74 76 f7 b7 =
cd 09" like messages ...
> wfx-spi spi0.0: time out while polling control register
> wfx-spi spi0.0: chip is abnormally long to answer
> wfx-spi spi0.0: chip did not answer
> wfx-spi spi0.0: hardware request CONFIGURATION (0x09) on vif 2 returned e=
rror -110
> wfx-spi spi0.0: PDS:4: chip didn't reply (corrupted file?)
> wfx-spi: probe of spi0.0 failed with error -110
>=20
> Needless to say that v5.4 kernel setup works fine.  The only difference w=
ith
> v6.6 is the wfx driver and kernel's DTB.  Now, i've verified that wf200 i=
s
> powered with 3.3V, in both cases, so that's not it.  I've also lowered th=
e SPI
> clock from 40000000 to 20000000 but it didn't make a difference.
>=20
> By looking at the driver i'm fairly certain the above error is actually c=
oming
> from the wf200 firmware and the driver is just printing an error message =
so i
> don't see reasonable ways of debugging this thing.  In short, any suggest=
ion
> would be greatly appreciated.

I believe you should have a trace with the firmware version (starting with
"started firmware x.x.x"). Could you provide the firmware versions?

The issue appears when the driver load the wf200.pds. Can you provide
the wf200.pds you used with 5.4 and with 6.6? Normally, you can't use
the same file since the format has changed in v5.17.

--=20
J=E9r=F4me Pouiller



