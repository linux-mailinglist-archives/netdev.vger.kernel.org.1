Return-Path: <netdev+bounces-171299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA51A4C6E3
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5518D171688
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225A22DFBE;
	Mon,  3 Mar 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMMJwDgo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C772215065
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018443; cv=fail; b=VUZfS0PQy2TiTmzfUgYIzSHBTmMZx53DsDczcyxrLJegwKNOD6wUPMNXfUAH6TIgm5va9cCtHzvkn7m2UlT4SDYCvl11+3qmlHDQJXalqaDn+q2IF2Ahq90FGYKuXjVwYlYw3EGzv7rHFo4vdCv68QuvJ3h68RynCHVRx2BXV74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018443; c=relaxed/simple;
	bh=fliqJnpAyL80wqzXGSanK9wToGVWK6SPNqNE3RzN4sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=us1Bw5xteWjULwUEZB38gkJ9zb1U35r3Rx3bB+I8Zum/ii4j1ve57UJcm0Wd9iPfK+8Rn5VIpQJefM6Ko5/1qeGydtuw3pxdRe2t3lj5aM9kkEMF3QuZi3JMaaFh3qrS2lNLDVTh/UQ6ElV94NoDRME34raqbW4E4RSZH7fE95A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMMJwDgo; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW+/e0nc906Of7kRkSLtNVznjx494tOJ9iS7mVpUcZIsXq77hkXpXqp++hVIWj8/LhR4UiDAFDtNx7wXIUg7v+RD/kRzZm8jepD4IVgKNanEEfPOeytmIx+Ix4x3rS5KrYElK77XB/oN5xHX/qCZ7U3QB+bG+QhCksfVonbTeFtOmJUYYmdZyDCvePy+pEZD1ji7xj2DPCRbsCqrFTIARaHYLqrRHbkeqC/cDEuF6ojWHIGd9c3DNso14xm90oAiem14S3Uw1wpc8b/3EJIX2VQBOqWVWy3JUj6wQ9NgWUzhYgC1eV/u/8+QcY5CJGUx8tAMAbxIzRelfp+BYCwtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u3sienot18OR3i0pvYADTXqEf7ONtbNtaS96ExKp4w=;
 b=lRlUgaZ3g7V+A5jjRCpjtRBR+JDDByZO+JiM5YvWB4ObbrgwPjeDuM15PSJ2wS1HhpFAVRh2V1mmIaNBv63Ki/X1iSggBume/L4unrP/0Dm0z4sqE5j2Fi3zHkDZ75GjQ8Dz0cGreiiB8TK6IzZdydIvm4SL/9mLQ2HHNDrWknaHFk8KJ1ohFeHeJMml7qtWIR9PdwizFCOLz/JDB2zTAj95gZHWwkwMobNObpJH9Qzhtbo7TKViJDp6M25y0tCXpFwULL/YIiJv+ViOZBYqT8ex3OlEiSy4AA4zbFyBSb8ZuSuAV0VvWIfUqPJWk4H0FBbUMzXE/Nbmo037pHkhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u3sienot18OR3i0pvYADTXqEf7ONtbNtaS96ExKp4w=;
 b=ZMMJwDgoALbWLwcEUGI3OGpRQZzswEMxgOiXZRvD5vUZXRbyIMCd09/k4V0ERP7Vtjry5UNqbRoNhYaORP5//eiRDqh0rgrc/BEL/fRFG2asPyjtF4u8kDnWw/1lQTDqmPVHRUPsG9pn4Fb0Us4uKKIBQ8ZXtD8rVrOpgWJTzcdmQCNAO3ckv+GXAXHi5gVBcWRQ49WVLCOaDUD51cJUm8mCHiGm6pZKQwgd8is+HZnxr7wxBH9caU0vNp7r/NC7SWZp+EYgeC4I/hq79k3H53hT0m3doIIeWXwuep0TQsT0jp+tS8yjK5XiO9IyxYbIMxlhcDKadCTnvTIgTK370g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:13:56 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:13:56 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH net-next v4 2/3] ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.
Date: Mon,  3 Mar 2025 18:13:44 +0200
Message-ID: <20250303161345.3053496-3-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250303161345.3053496-1-wwasko@nvidia.com>
References: <20250303161345.3053496-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::23) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8566cfe5-1eb0-46a8-4722-08dd5a6e660b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3JHM3Qxc1RGMkdQSy9VOC9TMVhvamxUZTVSMG1zWUVaR2xrajZ2RHlReEw1?=
 =?utf-8?B?OVNYV1FYeGZBa3V3c09ORzIwdDZCWDdzSFJOL28yM0RBTUZhcjdHaGE1U3lL?=
 =?utf-8?B?VThrVTlRVWhnejFHQUlhL01LUHJIc1NSVE0xYUw2QmRleTV3YlJpQW1vR1k2?=
 =?utf-8?B?Y0R1c1RsWm5xSEsyZkVkYnE2alJoc240N3hSMGZHeW8wNHY3azJZalhLS3Qv?=
 =?utf-8?B?UVliYmRaR0FoRVhBNW9NN1FHOHk0LzJxZUgwVG15cjR4aWU4VDZ2LzBTOWtn?=
 =?utf-8?B?MUZsTS9Ld01udnNTQTJLNnF2TFBnd2YwRTJKa3F4K213a1c4eFBXWWF5TkNM?=
 =?utf-8?B?NGwxWWRSQ3ozbU1KRUlrRUp5ejNHSHFxWjU4UUw3T1IydUNoNGZxdXJmUklj?=
 =?utf-8?B?U3ZBN1BxQldtSEFpb1Jrc2ZsOHZweUZETEQxM1RmYVVTc1JyNU1VbFMxbzFW?=
 =?utf-8?B?RFBTZDdOOE9ZbEFhZG5DeHlNbjhTdE9ZdjNLNmJTSDJvNStyR2swUWdHNWhU?=
 =?utf-8?B?bkRlTytYOWJ5cHJQWXlkYUE3dEEvMG5ZREx4Yng0UVJDUUlKaGsrWGdZUDdu?=
 =?utf-8?B?ejZUTWFwYXhCSW9uQWlteERLSEYrbkxOQnYwOXExS0tvanU2UDNvellPdThr?=
 =?utf-8?B?UlRHU1RqY09hVEk1ZnQ2NkI2a3RtZFRlTVpNWWNEMFQ4MWRVNk95MzN1WkhB?=
 =?utf-8?B?dWx6VXQ3Z290NnpRTDdqbDhYMzl5dE9QMHN3Zys1Nkg1QlQ5VG1vN3JLWVps?=
 =?utf-8?B?bXhQVVBtMGdPOXh5R01MTjF4ZXpEVE1nek9Say90S0ppK3hMN2tHek1oR3FU?=
 =?utf-8?B?UWlLYVlCY0NKQ2RPUmtGZGlXZ1FNUTVYbUtsKzhjRFcyVklxdVFvWGs1dStV?=
 =?utf-8?B?ck1UTVVnZXdONzliZW1JbCtDU0g3ZVkvSkhkUEtqSytrOC82ZUlJTHJPenpD?=
 =?utf-8?B?YkxQOUFzZU1ZZFY5R2JxQnd1NXlDdUNnVGdjZjBCbmRuR0cxYW14Yzc1Yzcx?=
 =?utf-8?B?cXFzSVNDaCt5WUJJRE9wYjZaTXFsQ3J1SzB6WTlJZTZ5WkJuaFRWVVQwR0tJ?=
 =?utf-8?B?cnRURS9MV0JDVmkrSnI3eHRVY1VpV2VqbWdIZVFPWEZMQ1pRcG5XWjZzbCtO?=
 =?utf-8?B?ZGpxck40b2V2aU8wMjdjdm5pZHg2SWNRMFZIMUwreEMzOHFRTlBMaEpYR0Jz?=
 =?utf-8?B?cHMyNjF5SUhzd1lpb0Jrd2JTZ29ZMTUwR2JzRFl3T1JoMmphUEdvNmwwSEdZ?=
 =?utf-8?B?cWE4WWdTazhocXZFRGtvTjlxUDFSOEl3ajZXWGhZOUU4eGJiazJzRlZFbWJY?=
 =?utf-8?B?SnBsTWlYNDk0cmRZYXRnQVpCclVkL3k0Tk94eWFteFY3UWUrQXNQaVhaODZ6?=
 =?utf-8?B?R2xTQ1orK3J1RUFiaGZoVUJpWnhGNWVRbmhnaXVPVmN0Nmd1dExvbEhEODFY?=
 =?utf-8?B?ckJUa0l5N3JlQVRkRHJnV0YvZWpsckVSTkJQeTAxYS9LSEJJSDMwam81Tm1H?=
 =?utf-8?B?VUx0QTlSRElYNHYyZ0p5bGpQeEhHdDExcXdtcHlTWE1aMnBaR0NCVEYwdmNl?=
 =?utf-8?B?cnpaUWZ3TmxxdWc0YXBRS085WnBtUlAxMU9pVWR1UUJtM2NNMGYvUmJ1Z0cz?=
 =?utf-8?B?WHRPa2VxQWsyM1lsOGdFQUhRV2JVQW1TOWlrdkdUSi9mUWRYNDV3TVhRM2Jk?=
 =?utf-8?B?OU1DeVNLQ0p2RDJyN2ZwemRaMnV1VmZJcG9JS1RMNThNa1JnQ0ZEbmFDaUF6?=
 =?utf-8?B?R0NDZWNkRndEalArN1VJUDBUVzZxbm5GU2NLaExLMk1nTkM2ZVhueXNJZUgr?=
 =?utf-8?B?NmhCVlVZWE9lZWRIMGFxSExoWml4eDAwbzBKRWdJcUROcm8wU3EvZ2NPOFFi?=
 =?utf-8?Q?kBOrevDNZih59?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RThPNUJjeHpEa3Q3eE5nSkNjeDhuSEpsZmFqTFhFT0hDeERrTlBQVUlXZFVy?=
 =?utf-8?B?Zjhyd3dYZmNzNGF3VGxtWFB6ME1IK3RwRjJWbFpwVDdmeE1TeVJaOGdiSGVE?=
 =?utf-8?B?M05hRlRrZGdQaGRBYVRQVDV4MjRZWHhiUzFnWVZZcVJTdm01dElSRXNwekN2?=
 =?utf-8?B?Q1VMQStzbVAyN1lmZm1mcGlwL0VFK05uQitMVFhTSllWbndxZFdsV2ZOZ1lk?=
 =?utf-8?B?WU1KNW90OFB5UElZUG1ENnBVS2w4ZUZ2NW5YaGkwUHNFQ2F6OUp3NHl4SnZr?=
 =?utf-8?B?Q0NCaDI0TWhzV0ZTdXI2N2RETVQ4NmdYSVE1NWs4LzdiWUpZSldFSzRjZ1ZL?=
 =?utf-8?B?VVFFN3dFNkFSTHRzWUUrT0ZhTml1UTY4dk1nNzdCQkw0b0Q1R2Fsd0dYRVhG?=
 =?utf-8?B?dk03Rm5lQS9KN3NmdTFSY1lHTTZMTk1Bd2gzR1lBdVBMUVZTcEZIUlF6enk2?=
 =?utf-8?B?ektjU1poTUs3NSs0QWdROTdEOEpKWnZOV0lPR3RxbGwwK3RjNVY2bTNFRkhP?=
 =?utf-8?B?NVFHekEwdUNtU1MrZzkrdnF5YzRpVmpqYWQ2S3pTRkQ0c2JzaDFkNUFKYzhs?=
 =?utf-8?B?QlRXaUcxVklSdzhlM3VGWmt0OXZ3VElIVHJhWVcxU2Z4Q1l5a2tBNnNkK3BQ?=
 =?utf-8?B?YWVEdWF6VlNpR0xoQm5SSlFkUVlySGRQUnN5QjJicmlUdHFaWmFpZFZuRUtD?=
 =?utf-8?B?ZUFzaU1abGhSK0l2bTUvaklobmtwQjB0TmZ0RkQvM2ZzL2I4aEdpUm5ERE5O?=
 =?utf-8?B?MkoxQXpNaHV6ZllhcGF5OExTNVJ2SGQ1NXBtWjUyam9EbEpxNjNsTGRBbUpJ?=
 =?utf-8?B?Mm5mWC81N095UmJZK0NqOVFqT3JCRVFtWGFza0FESzhnclFOaUx1R3Fndm45?=
 =?utf-8?B?NXNuMGRtRHhsUHdVVVRxTk5XcVpRYXNpbUZkVFptMWwzbWViODZ4RExobkFt?=
 =?utf-8?B?L3NiOEp2a0JHK2I0YUFXSHJmYk1jMmMzNHpObyswMWVNWmVSOEZxRFlPT3Vo?=
 =?utf-8?B?azFFeFQwTmorWHNjZjdwcUlPYjFFUDJtZ1V3QjFQYjNmbU4wZ3c2YXRiUTdL?=
 =?utf-8?B?dnpFUGZBUUZmYjRGRVRlOUd0WkR3TmE0UlI2Q3pZWFN2WUZONkRrUi96MHVP?=
 =?utf-8?B?YkZMdm1CNVYyRGRiMElMeHptZ2NreWdqenBVdkYyc01wQkd5SmpJOWFvNEF6?=
 =?utf-8?B?MG4zSTlwRDF3ZnpuOFlQSjJBbld5emQvTHVTaXRXTVg3c0Y3UlJ0VXFEZldx?=
 =?utf-8?B?aTVIU2JvSEtrOFBYZG41Zk9hdjlGOWpGaTRxd0haN2F0TURuNWtBRUpRVlRh?=
 =?utf-8?B?d0pmckJZRjJTQVdGZnArV0JTRThrdXpsTUZSQWppWUpDcm5xMkNIVUszb1U2?=
 =?utf-8?B?c0sxdGR1WGtjSXJmVzJmRFBWTXFlR3ZzZ0paTFhtZzlTOHdsOThSa1lVb09m?=
 =?utf-8?B?VXNIaWVKOTNQQUVGcUk4L3VXaVNObkJ2MmVma2Q0Z3F3SW9rL2dYdDQvYndF?=
 =?utf-8?B?NjIxRlpWL2lXenNsV2crL0ZOdmZtV3lOS1pVdG1QZmw0WlBKWjlJRGQweDZ3?=
 =?utf-8?B?RFNkSmNiWFNkTUVhdGoyM1MvQi9iRXRGQ1owRHJMRzdZOGN5bDNET2tEbmxl?=
 =?utf-8?B?Vk1LWUF3S2EvN1hHdS85d211WG5HbDdkSnZGUCtWeWRCZERzZ1NTempyM2cx?=
 =?utf-8?B?MlMvczNTTFRzT0tWNXJHVkdQOXZYOFc5R3lVQWZyalFkdW1MaUdxemFmNkox?=
 =?utf-8?B?Z0YzL2ZOZWtrNklwSjJXcDdzNlFFQzV3OVM0U296eTRSYTliS0hJUWdEbEdu?=
 =?utf-8?B?MEZmd0ZENHVEc0FhWGJOZXEwczFVZEc3NGxERWYrYWZBdnRIUzUwdnVHWlBJ?=
 =?utf-8?B?N2xJSFZHSjNJVVU5bXd0S3pVeDdlaktzUjlTaUl5NGFOZHYrbFJFU2paL241?=
 =?utf-8?B?YVB4V2pyTWw0NU1sZWZ6cVdLQVg5bWxHSExFRzlvd053MHZMOWtkY1FWS2hB?=
 =?utf-8?B?SFNhdm55SnZiVWltTGcrcWExc3hGb2NBZjdqc3hjWXFHQkg0N2JTVW9OY2FL?=
 =?utf-8?B?endVZjRTZDNZd3BGVmNBQWtxUXA5SzBMeHNTK3BmR3o3SVNoYm0yaUhFZExv?=
 =?utf-8?Q?Erlqx7MyWv5pOaPNkI4ZEp83P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8566cfe5-1eb0-46a8-4722-08dd5a6e660b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:13:56.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWiU+SSGdORjYcAvx/nyCVYcwi7EtYc6O+2FI3B5T0See+Kb4A9ryeyN366+yOU0BGSrSQCt68ymzoJGx1aKhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

Many devices implement highly accurate clocks, which the kernel manages
as PTP Hardware Clocks (PHCs). Userspace applications rely on these
clocks to timestamp events, trace workload execution, correlate
timescales across devices, and keep various clocks in sync.

The kernel’s current implementation of PTP clocks does not enforce file
permissions checks for most device operations except for POSIX clock
operations, where file mode is verified in the POSIX layer before
forwarding the call to the PTP subsystem. Consequently, it is common
practice to not give unprivileged userspace applications any access to
PTP clocks whatsoever by giving the PTP chardevs 600 permissions. An
example of users running into this limitation is documented in [1].
Additionally, POSIX layer requires WRITE permission even for readonly
adjtime() calls which are used in PTP layer to return current frequency
offset applied to the PHC.

Add permission checks for functions that modify the state of a PTP
device. Continue enforcing permission checks for POSIX clock operations
(settime, adjtime) in the POSIX layer. Only require WRITE access for
dynamic clocks adjtime() if any flags are set in the modes field.

[1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html

Changes in v4:
- Require FMODE_WRITE in ajtime() only for calls modifying the clock in
  any way.

Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 drivers/ptp/ptp_chardev.c | 16 ++++++++++++++++
 kernel/time/posix-clock.c |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index bf6468c56419..4380e6ddb849 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -205,6 +205,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_EXTTS_REQUEST:
 	case PTP_EXTTS_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.extts, (void __user *)arg,
@@ -246,6 +250,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PEROUT_REQUEST:
 	case PTP_PEROUT_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.perout, (void __user *)arg,
@@ -314,6 +322,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_ENABLE_PPS:
 	case PTP_ENABLE_PPS2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (!capable(CAP_SYS_TIME))
@@ -456,6 +468,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PIN_SETFUNC:
 	case PTP_PIN_SETFUNC2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
 			err = -EFAULT;
 			break;
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 4e114e34a6e0..fe963384d5c2 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -252,7 +252,7 @@ static int pc_clock_adjtime(clockid_t id, struct __kernel_timex *tx)
 	if (err)
 		return err;
 
-	if ((cd.fp->f_mode & FMODE_WRITE) == 0) {
+	if (tx->modes && (cd.fp->f_mode & FMODE_WRITE) == 0) {
 		err = -EACCES;
 		goto out;
 	}
-- 
2.43.5


