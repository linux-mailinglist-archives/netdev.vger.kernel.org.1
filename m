Return-Path: <netdev+bounces-216343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFDB3335D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 02:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D24A1B228D7
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 00:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C71FC8;
	Mon, 25 Aug 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="AFEIJJys"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EB1FC3
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756080231; cv=fail; b=tqehK/Zc/Y4yi1fgMMqx9uZFyv3LAZzXLlQRsnrFPeAks9vJgba177dXxIsVVEJ+X2BY/6evUF0ZUyGmi3FsbsiEMDD6mUr/TKl6VGSumz8F7eVItcSGLe2n41ozM8saoNB3SjFaivKNsYl49buJqQvkTkAGBs7hcciohz7GQBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756080231; c=relaxed/simple;
	bh=/iNFoBNhmn3zPL96FkFyIj6ahmVbArQVU/NvnUKETzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LBlch8Px9PeBk5/zCCR8Yv/fsJkLrIRWP1N4GjzB3bEW5hpwwWTBmbaQd71CqUuO3QzO+xc6HMhC+lDIgHlMBrVU6/aTndCMMwiNpAiWEZ/rmGr8nTjWI4oCOAyTQW9vwVulf7a6DWAkEGQiI+rkNt0yMsj9RroXaP4N5W82IhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=AFEIJJys; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756080229; x=1787616229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/iNFoBNhmn3zPL96FkFyIj6ahmVbArQVU/NvnUKETzE=;
  b=AFEIJJysjHmN0STUhBC75XGy/Ye2Fa3Gu8tgA1mJYHe3+mhgJ6y8JUD6
   4EVZUSV4Wr16F1h/mOeWFb8UVfKCPTnFlkCj1HDvqcNIWTbQvh+JzlV37
   s9u4oU+ZxmQ6yrQ4u92I1+mXpCURJFtkVIfkvSSbIFoaIbKmBvrP4n2FB
   E=;
X-CSE-ConnectionGUID: Yt3maP/5TbGL3nLTdXInlA==
X-CSE-MsgGUID: rV81KUj/Qzm7DRzX0FBwZg==
X-Talos-CUID: =?us-ascii?q?9a23=3AFfvTYGvtWomlHU0XrLDo6luL6IsUbibYxU+XfnO?=
 =?us-ascii?q?yJkIyTpmpRW+x/qdNxp8=3D?=
X-Talos-MUID: 9a23:m1L3CwagUjfvquBTrQG83RJfNoBR8aHxJHofoc0okda2Onkl
Received: from mail-canadacentralazon11020110.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([52.101.189.110])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 20:03:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7xHO7KpDdp4SvmEDu/fFiepT6rxm95VAp32+B879ddAWmH8zV+y8dpL5DOKWbUfIoYiRe+uT0XbokrLx9/rtTsf7vv+Nx3NMvYgwcvOMlK0gKQmKA9YzMTDf4CPFWUQ42To9BEwZhkfLMwCDScxIcAd0tY9DHVE4tbaJn7I5MG3jhZ9cMicsiXD0paDFqaZUVrvqas7q8q1fjYxqhAxvCf5K313GOblBpC+J7J8InwWPhXTJAA28YA23pX+6gPzhi13XMiLCI4IK6efdQ+DvG7LD7P3raq47om3Aedy2zeLNWkRDkxRz426f+Da8NQ5JWbSP5wYdhK4IXJV+zSbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbx7LcKwYCofN2fJJLLZVEKYiO9/zeZeLcq77AXnAco=;
 b=NGiZYwjZ4bv2WTjrIB19VMwawuIAv28uGvACgrFJh772wXh1/Koq824Y0dE7z47AURD4RvbK8163NpCI4r1CP2yy+ewcZ1Q7n0frmNOzad5BJnZhjBn3rOuJPSzzTO2tuXiCD2K42fZwYIrF0l6oMudikZe64eQl6NVd0fE+BDMoLnAtdeUbwxwDlxmvAUvoaagdePgW109Gp3fkGcFN+9F2dOq/eHnBHYRL5yBh++BkuUILPgapGB2JvDipj/Ghg9nC/P+H29KCYah4WLchBcWH4UlbDcfXIDZgZZZ+JxMqXfQxocgnqa1a5vKkKBVB0ZX3HpiZUbzE/tIJYtF6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT6PR01MB10863.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:11f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 00:03:40 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 00:03:40 +0000
Message-ID: <8407a1e5-c6ad-47da-9b41-978730cd5420@uwaterloo.ca>
Date: Sun, 24 Aug 2025 20:03:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250824215418.257588-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250824215418.257588-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT6PR01MB10863:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b2528b-a0f9-49c4-4d53-08dde36ad8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?allGYnZMdWxVV3JxY1E1S3B3a0F4SUpTa0xTdVBNeU9hNzQxZEMvUEd0SW15?=
 =?utf-8?B?SEUrQTExS2JvVElaYnc0ZHpJaHY0VVozUFNrSHhzNm9KUDNJS0JTdWtsZUFz?=
 =?utf-8?B?dVFsdVhqM3hMRnBGWVErcHF1RjVIVE1WVWV0WTRTVmFFZ0Y3aEFKd2xmcExB?=
 =?utf-8?B?Q3d1OWRCU0M2NSt6dzhTNDhvRzRYcHFiY1QreEFhekozWUdFdHJISkVMcWo4?=
 =?utf-8?B?SU8zRWloWTllYnRxemg1eFhPeHBNOGM1dVJrZTZKeW5RNVg4ZFMxUTBXd2FX?=
 =?utf-8?B?d0NWcVR6d2JxM1FDSnM4TlFKNDNXb095SWQzb0duQjI4WTZrMDJHL0tDRVRM?=
 =?utf-8?B?TXgvRXdJTE5xVHN5QXRlWXFkTGFkT1IvUG1LQ1JNS3k2RFZBMnhuMmJtNDJD?=
 =?utf-8?B?U3QyQWpKdzVFMzdDZDhESkluaC9oQU5NOXloYXBkc242aG4zNm1jcDMyRHJH?=
 =?utf-8?B?ZCtyZDFSL3dnMW9iOFhVNmtyQTIxaTNRbHRZZXRudmxIM0paZjJ3M2NqRGNW?=
 =?utf-8?B?R2VOaTZFb0poUm9BQUZ6dWhOSFMrWXBWaW5ONnVsUUxNUGErZThaMk8xK2Ey?=
 =?utf-8?B?bEMzQ3RWZlo5bElnWUNRTlNNbFM5elM3Y01mQ2FieWhZSGxUeFpUMVdiM1ZW?=
 =?utf-8?B?S3RpSGo1VHFaUmFmYy90YVFZaEI0Rzdyd1hwWTZyMisvbGtWdzZWeHFBV0Yw?=
 =?utf-8?B?Z2lyMndIZTRFRmw2N1JSNi8wN3pYQnkwU3pjNzBMNlpxbUpPZkpsQUF3WHRO?=
 =?utf-8?B?K0o0ZVBVbFhhc0ZKUXRqV0FNV09FUkRnbElKL2NRU1BTdktBM2NpY2kya0pL?=
 =?utf-8?B?aU5jMi83QnVDY1ZLRjdWNDhlNWNHMy9FS1p3Q1VuNUgxemhvREZBSXJ3SHk1?=
 =?utf-8?B?dEVSMFZTVzFUNzluVnY2ZjZ4MlRBRXlGUFpuckE3WVlmYTNSZVI3K3p3UmJm?=
 =?utf-8?B?S2l5V3ZLVXg1K2l0SEl1WGdYR3lZVjZUNTQ3M1NxeVZ6T05wYTVaeTlKT3Rh?=
 =?utf-8?B?c3cvMnRLalhQMlFaMmdqRW0rTzI4R21aWWVrRU05TGwzS2dLbDNkRmt6cjJm?=
 =?utf-8?B?cDViM1hNRXliV2lNUUp1STNjWlhlRVI1UzlBSlJ3dVZhTFk0alhIY0RFS1hh?=
 =?utf-8?B?TjNwMUF4RzVCTnVEaGoyMStBYkNhcThud3cwMzFYY1hSSjBERldvVld6c0s5?=
 =?utf-8?B?UnZNMFoxdUYrL1gvQ1ZtczZyeUFGTDJRRzAyL2lWQmYzZXo4TEI3eG92dHFY?=
 =?utf-8?B?eU8yaHppa09tK0d5Tjlld0ttdTBzT1pBSUFSZkNvS05lQVlrK1hvb015UGdK?=
 =?utf-8?B?Q1hqZHdWdEFudHBtMnA0enQzeS9peFJxTXNCcndhRS9QelZyUVQ1VUNMbEdq?=
 =?utf-8?B?MWpYQitVTnZmQUE2QmY1U3c3RmQ0S1dTUUlFMkI2a2QvcE9Ob2ZwUithSVpT?=
 =?utf-8?B?bnYxWEZBZ1RsR2lNZ2xBMUUrVGo2Z3EwTnNobTNqNDQ4K0lvMlJ5Y3pIclhI?=
 =?utf-8?B?cWV4dnNHejB4VUR3TWpmaFJySlYwT2M1NENQeHhBd1I3RytyaU9FeGZ1YzJF?=
 =?utf-8?B?blJlekY0ODdWd2FxMmQ3WTk3SU9DSFJiOEtsQVU2SWJuOXI0TjQra2R5UVVh?=
 =?utf-8?B?RnhnczJZb0pYTmVXaThxWXBRdVdGWXhsQXowR0QxYXFKZ3ErQ1RBU1M1Q0JM?=
 =?utf-8?B?WHhCZCtxOWVlQXhWNm1ZWis3bnlZTFZ6NmFlYUV0bXFSU2U4RjhBMWVXYVll?=
 =?utf-8?B?VlIxK09PZ2lrWGJmcS84SlRKeGtXVXVjU1Y3R3U0b0dwSHNjcmNNQ0NtUEtE?=
 =?utf-8?B?WVlwVlJBMmhUYlRvVHlQZlNyZ3BRUnlOZThDd0NQdjlyaTVLbGkxV0REQXRo?=
 =?utf-8?B?cEpMR0YyUXg2WkVLZG1XMWRPMFhJZ0FvYlF6ZnVhVjFRSFBPVmJpb0RqU3gw?=
 =?utf-8?Q?Oe8dWIgnE0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUZRQWpDeVhsVlBheFRSK2c0UjVRUHNnSEw0eU0reHlJN1hueFY4VGdwLzhT?=
 =?utf-8?B?ZTNFSXVsVzd3ZTlsWm9LdjFOVmNtOE5zU292dFA1eHR3UGFXa21LMTlGYmtT?=
 =?utf-8?B?dUlwUkFFR3VPdHRVd2ZlV1RaalA5bk14MlBXVzhxUitRUU9vbW0yNmR5TlB6?=
 =?utf-8?B?a2ErQ2VEWGxmcnRKWHJLVW5tSjZNMUkzeHltVHRjVWhqa3l4Ny9jZ2hkL0Zw?=
 =?utf-8?B?Ump5M2xEeDVYOHdwN1pvSitGU3dsMXEwUmdtRE4waFQ0UU8rUGFsd01pME9B?=
 =?utf-8?B?ZFl1d2t2NFpTcVhZS0FZNUtNMTBYUVk4SEFwbTViUE14L0dYV2FKSkovYndO?=
 =?utf-8?B?T1A3V3U2bkhtWTA3UWlsR1FHUjBkL2dmODNmR0FqMXZsOXQrb3hSWmt1dnNn?=
 =?utf-8?B?UW80TndWOTJ3MDkzTzNXMGdETXhmQmd3a1habmluYTVoNzRRSkFZZDRiYXFW?=
 =?utf-8?B?eDFmclhqM0dDWnJjY1J0L0V2UHdlL2lWQkxvRGIvMzdXVHdCVUVrRURTRnlo?=
 =?utf-8?B?SHlrcnBtMHlkRkVKTklKc2J5YXZUb0pIOVUvaCszWkpwTTBIVXNpUVJXYzk2?=
 =?utf-8?B?RVFMbWRneUFwblRjMlgvVDVheDdMeWNjdFRpT0tSbXZraDhET0FhWUtiZm43?=
 =?utf-8?B?aG9ZQkpzRTFuWmhLSnhLN0VLZnhjZ0g5Q0xsd0FZQlp3MlFMbytsYm41M0hL?=
 =?utf-8?B?MXhMMTc1RVNtZHFjem9LTDJpR0FKWkJ5MjNjaVA1QTZpSUI4OW1vTU9wQ3RG?=
 =?utf-8?B?UzQyWUxmcXFXSXpxN2Z6OWNUVEwvVk43czdQVElJcVVPdGpMek02anlUZHNn?=
 =?utf-8?B?cUEzeCtpYXVkNC9xaS9iZEhnTFV0WnN0bnpXa0poam5FOXY4MHh4NDA2NW5r?=
 =?utf-8?B?UWhMMEtVWisyQis3L3gwYm1nSllNdUQ1SlBib3JIVWpxKzhyQlVya2FxNVhr?=
 =?utf-8?B?MzRKQkgwVCtQMEdCOUg3MUxyN0dNWUZLVXMzUDZBYnl3ZEtXTzdaeHRSRkdw?=
 =?utf-8?B?b3cxeWVPaXIvNzdEcGZ2WTFsSUhWVm5sL0V4SXZ3aFNMV3VPN3ZnaGlQSVRE?=
 =?utf-8?B?UHZMSStkY1lWZHlLbTMyRDJrcGh0bG9DcTc2UzRJdDRheVd5YW16K21QR0Z6?=
 =?utf-8?B?NFB4MmlTQTJJTi9yTGVXYVUrRmNkODNnS2h4NU8vY1d5dzJISkV5YVJpd050?=
 =?utf-8?B?UHZTZDhtbjFnNVZ3anNGK0MzOU01MGNNekZ5c21RYnVKemZvb2pOV1Q2VnRP?=
 =?utf-8?B?NnVyek5FOGpzREtFbCtqR3FUSkFwZ3dWbHhDNG1jTEdMYUR5bVVmYXlWTkYv?=
 =?utf-8?B?MTRyZWU2VnUzY0M5Y2pOTXlRNldyaEE0RERBYkNSSEdCd2VJYnJIV05OOXpE?=
 =?utf-8?B?bWc5R1dDSFNuTVlJR25ub2l0L1p6R0Z4UVZyemxmQkM0Ky9weDFEM1VwVEZV?=
 =?utf-8?B?b1ZIemNVU0JsNGZXQlZZZDd0VEVkTE5GVDl0b1kvWFkyR0FUNEI0c3lMKzk5?=
 =?utf-8?B?QU1pc2dRZ2FYTjBxN1lrNGI1Vk1OenlGYTlUMVpBTGFZbEpDWjRvMC9WcHYw?=
 =?utf-8?B?QWdNSE1UdmNEZUNESFMrdlBBbDJqSHZ5S3BYQzcxYTl3VlZUYThQVWJhdTJS?=
 =?utf-8?B?Q2hXb2k3THlqS1dIdGVWVlFXTzJ2dWpuRWR2TXlVb1k1M2xERGJUTkVCVGJC?=
 =?utf-8?B?cGcvWkM3ZnY2aHZBb2czKzN6dXAwTzJJSldISnhwMVVIZ0hrbytjeWFtNGll?=
 =?utf-8?B?SzVsYjdHWHMzREEzaWZMVUhub1ZJVi94UXdySXN1SW5PbTViYVFFeGt2ZHl5?=
 =?utf-8?B?bzJsNENVdkkyMEpJTE9UMDZEV29aMkc0MDlVbjVScUg3c0p6bXBZTlBsbVIy?=
 =?utf-8?B?bG95dCsxYU1HamIzYkVVTlg3b3hUdGV0L3R2RUZDUHBMSUx5MUZlc2lReU8v?=
 =?utf-8?B?eUV2YjRKMEcxMWlCUGl4YzY0NVd5a3VtekJodWZGNS9PcmNHL2tHT3o3Mlgv?=
 =?utf-8?B?NDhRRXo5aTVnK1l4UmRCbnZvdWVBTHBVQ1lDRk1acnJYRVZlRy8rNi9IV3dn?=
 =?utf-8?B?eG9nYmtiN25MK2IvMHBaSnh0aGNFTlZFZ2hXZGRrRlcxVHJhak5QOGIzL0tG?=
 =?utf-8?Q?1d5zUFzJKQDABbJmRt76ml8yG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xYrq7w2/N3qB+eAkmHwJO19Qih+c0/tpAoHnaSbcJa6eBFaSNmniVq/G5L7G8BjjLG1R2C2JX0SXwMjxc6oWIbAzc8gVpYA0ecJGk4f45ZjRlGfMLpmUAtuPRoicWMVWaIRaGXkwyTsk3bYqXk4BlKjmI7LCsBO6OzHchMA/z+HkA0irJ4CM/PALYiukypOkUEpGNlZH7Qytnf5oY6Wyx1dzruFG+yhwdqOhmi4U79UeZeks27db5cpn7mbgDIamyg4LZYa9HEzcDTy7onhDFuWKfB03YxqmpwnYkPRBryLX9tcFZ8GQOA9Of+C7NJAiHqGcr3nJovWtf5wA96RQyocuFgoGccXPVodGWMN26pRHzU/9cPKeRHnGQETSxaSG6gz9caOCyf0d5VIOfKRD6d9Vlh6tocAgMtgnwuShwpzYXVHj14L+JJ+DSs6uEuR/uG8gCNUDR6aDels2aOQyU/KOcohlPshXB82ktrxPzdTOYrGb8A6NVcx4SorLjWuMdHagwCCSOtkbOsmC8i3XKGU0OUDLq/IQuJPwbdJuez7WHhTycOZQk1vTNApSawEEgRMc70YC0do0WXDkg19nBILlPChz8UuMQRyTy1d3MZffY+T4AQqNJcf4JWzDIVHd
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b2528b-a0f9-49c4-4d53-08dde36ad8db
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 00:03:40.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: facVwvu9ytzBR8Fo4GamC12mks7sLuiP5JQ71Gpf5O3P23dHeQ2isEB0xWZVSJRONEDCFu1G+2+g3LvCwSiIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB10863

On 2025-08-24 17:54, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
> 
> Once enabled user can fetch the PID of the kthread doing NAPI polling
> and set affinity, priority and scheduler for it depending on the
> low-latency requirements.
> 
> Currently threaded napi is only enabled at device level using sysfs. Add
> support to enable/disable threaded mode for a napi individually. This
> can be done using the netlink interface. Extend `napi-set` op in netlink
> spec that allows setting the `threaded` attribute of a napi.
> 
> Extend the threaded attribute in napi struct to add an option to enable
> continuous busy polling. Extend the netlink and sysfs interface to allow
> enabling/disabling threaded busypolling at device or individual napi
> level.
> 
> We use this for our AF_XDP based hard low-latency usecase with usecs
> level latency requirement. For our usecase we want low jitter and stable
> latency at P99.
> 
> Following is an analysis and comparison of available (and compatible)
> busy poll interfaces for a low latency usecase with stable P99. Please
> note that the throughput and cpu efficiency is a non-goal.
> 
> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> description of the tool and how it tries to simulate the real workload
> is following,
> 
> - It sends UDP packets between 2 machines.
> - The client machine sends packets at a fixed frequency. To maintain the
>    frequency of the packet being sent, we use open-loop sampling. That is
>    the packets are sent in a separate thread.
> - The server replies to the packet inline by reading the pkt from the
>    recv ring and replies using the tx ring.
> - To simulate the application processing time, we use a configurable
>    delay in usecs on the client side after a reply is received from the
>    server.
> 
> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
> 
> We use this tool with following napi polling configurations,
> 
> - Interrupts only
> - SO_BUSYPOLL (inline in the same thread where the client receives the
>    packet).
> - SO_BUSYPOLL (separate thread and separate core)
> - Threaded NAPI busypoll
> 
> System is configured using following script in all 4 cases,
> 
> ```
> echo 0 | sudo tee /sys/class/net/eth0/threaded
> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> 
> sudo ethtool -L eth0 rx 1 tx 1
> sudo ethtool -G eth0 rx 1024
> 
> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> 
>   # pin IRQs on CPU 2
> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> 				print arr[0]}' < /proc/interrupts)"
> for irq in "${IRQS}"; \
> 	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> 
> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> 
> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> 			do echo $i; echo 1,2,3,4,5,6 > $i; done
> 
> if [[ -z "$1" ]]; then
>    echo 400 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> 
> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
> 
> if [[ "$1" == "enable_threaded" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_poll
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>    echo 2 | sudo tee /sys/class/net/eth0/threaded
>    NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>    sudo chrt -f  -p 50 $NAPI_T
> 
>    # pin threaded poll thread to CPU 2
>    sudo taskset -pc 2 $NAPI_T
> fi
> 
> if [[ "$1" == "enable_interrupt" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> ```
> 
> To enable various configurations, script can be run as following,
> 
> - Interrupt Only
>    ```
>    <script> enable_interrupt
>    ```
> 
> - SO_BUSYPOLL (no arguments to script)
>    ```
>    <script>
>    ```
> 
> - NAPI threaded busypoll
>    ```
>    <script> enable_threaded
>    ```
> 
> If using idpf, the script needs to be run again after launching the
> workload just to make sure that the configurations are not reverted. As
> idpf reverts some configurations on software reset when AF_XDP program
> is attached.
> 
> Once configured, the workload is run with various configurations using
> following commands. Set period (1/frequency) and delay in usecs to
> produce results for packet frequency and application processing delay.
> 
>   ## Interrupt Only and SO_BUSY_POLL (inline)
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> ```
> 
>   ## SO_BUSY_POLL(done in separate core using recvfrom)
> 
> Argument -t spawns a seprate thread and continuously calls recvfrom.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -t
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> ```
> 
>   ## NAPI Threaded Busy Poll
> 
> Argument -n skips the recvfrom call as there is no recv kick needed.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -n
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> ```
> 
> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
> |---|---|---|---|---|
> | 12 Kpkt/s + 0us delay | | | | |
> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> | 32 Kpkt/s + 30us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> | 125 Kpkt/s + 6us delay | | | | |
> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> | 12 Kpkt/s + 78us delay | | | | |
> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> | 25 Kpkt/s + 38us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> 
>   ## Observations

Hi Samiullah,

I believe you are comparing apples and oranges with these experiments. 
Because threaded busy poll uses two cores at each end (at 100%), you 
should compare with 2 pairs of xsk_rr processes using interrupt mode, 
but each running at half the rate. I am quite certain you would then see 
the same latency as in the baseline experiment - at much reduced cpu 
utilization.

Threaded busy poll reduces p99 latency by just 100 nsec, while 
busy-spinning two cores, at each end - not more not less. I continue to 
believe that this trade-off and these limited benefits need to be 
clearly and explicitly spelled out in the cover letter.

Best,
Martin


