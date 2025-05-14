Return-Path: <netdev+bounces-190384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7636FAB6ADF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C3E4C110E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8A270EAE;
	Wed, 14 May 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hcgeqaZj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558E235040
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224109; cv=fail; b=fXRsge6vfUCFOkL+r1+Ju5uSb0GnFQlzbbjkgF+8c3s3NhmD+KGl/2KObyWVAAn2FR385NKUTbqTIIg90U9FY7XSXAetW6EwdexuGH7LMwgRsU397QDbdrp39/Ea+oe6i480KIPHPpDTIF/rjM2QoIGpbcUQnNw0sddX/dpj9U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224109; c=relaxed/simple;
	bh=JWtYICPQchscXOYGvshWXpsABJHordmeAgga8GSW5pI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sib+EbphCmPBhcLLLNa5vgewMBCHkawiQOYP6BhVTeexuepXnI7fWk36w4dQUgHt8L+n9U5mtQpT+1REwU4m3Ny7BiGSeUKjHBcpBgr3H6Gvs35EnMw7qUu/MZ2uIyky7h+rz4jzDbzT6W0icRC3GJ23+CZvAFjqnATAtkdiEOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hcgeqaZj; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAGmAvqJvYvu1NpUR6nTVvYsZqD5BBEksSyKxnXI+rlXEd03jG+leCITKK4pB44QDNIeB3XoOvLkXbI6r5wHk6wIAV1Kzlh1rPmZ4m1btPu8TPAHqBVVkv9o7V+hbnzDD9XDjm8ifvDYLD/TovsJMfvHbMSMy4P9hHwDt/uwc69HKwsIGd/mk3ufQmkWeVgm+9b3NyRWgfejoBACTl+hBt460FO4YAEt6qHI9AWTDAgHtlndGq5qsuBbERjqL38Kq9JJhKgRYknlXS+ZJC/5LzDxnYjAyVwT2xegRVwfAsp2FZYROEbCCQIcSvM9EuY7o2d873pn+C9tDCPp0h8XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1OMX7M4Hm+U7S/rqdFsflEMMo7eIZ0jJ/3TzshMHyA=;
 b=l6lZ1Yd2UjbTxeofJWBb3vXVuNDJqDF/L5gJJFsj9Qk9QkwJTlqVzJcPwQYJKgeAG897Bmw750gKjgUfC8mmEaABBsUpKMogrA7h0SZciR2QdIWAmA2/86FyVF138TVa+GFe+e81isXCHUVT/r9F6+8rMst+p7+I+oRhxVatxbkR76+RckcTsCr6IVH61fMucz9yDvjuG1vQa38K3whZlOlqN0Gf5XNqrLU1MTNOnq6Lp/hxoVs5tb81Pzk1lm3boVqYl04iQ2oe89uHqqQQ5DRec175eiWqLRM2nAUy1MsYEb4QFc4ywd7TxwflMmAowANfeJb+6zU0UNhUYWSVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1OMX7M4Hm+U7S/rqdFsflEMMo7eIZ0jJ/3TzshMHyA=;
 b=hcgeqaZjzr1QzOjWpXslpF1dblfbdJaS3VOcUKrRQt3a10Td1T90GxrhneEsgnByL9jevd8WCAlWVCBGkTwRbbCVR/PeBCtRNfe0+6hGrfLkzVXO3HH8lB7WKgf0Q1KYIpympJjD/ZmS99K1xrxXn1zaw0NmmcEjZEEeGmlofjMEZtmA8Hh/2icHAq0EDsI0mvWMP3DbnmDG0Tlm5kf4vbGzl6ljYdOAogG3i/JPHM6mHn3j3bMBJJN9zO4mKP6fZpo9Q17NR5FUkGJlCeMLyxubev7tQ03DfNjfi5AgC1dYqlTNbHShOB2tecMdo3QYx4/yPLQkbTraXnaj9F07lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Wed, 14 May 2025 12:01:43 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::bc8b:fb13:be0e:baf5]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::bc8b:fb13:be0e:baf5%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 12:01:43 +0000
Message-ID: <da372ddc-bc00-4e14-bcd8-4e9c607cc1d8@nvidia.com>
Date: Wed, 14 May 2025 15:01:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink port
 function
From: Mark Bloch <mbloch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
 <95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
 <20250428111909.16dd7488@kernel.org>
 <507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
 <20250501173922.6d797778@kernel.org>
 <d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
 <20250505115512.0fa2e186@kernel.org>
 <c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
 <20250506082032.1ab8f397@kernel.org>
 <aa57da6b-bb1b-4d77-bffa-9746c3fe94ba@nvidia.com>
 <20250507174308.3ec23816@kernel.org>
 <bee1e240-cc6a-4c30-a2ae-6f7974627053@nvidia.com>
Content-Language: en-US
In-Reply-To: <bee1e240-cc6a-4c30-a2ae-6f7974627053@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 589e4331-e7e0-48c1-b8ac-08dd92df17a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTYrNlp3M1ZxZFkzYlpYOEdmNHcvVHk4Y0NVbHlKK29yMk9UcVh1Umdzdkg4?=
 =?utf-8?B?YytwbEFYa2ovc3FIaEROR1VSVzRoQ2tQYzNZWDJQa1YvSHNJeGhRUFp0TzN1?=
 =?utf-8?B?MXUyQ1drL3NXRFpyamVFbThyQVBmVUd1WlJlMFllZFdvaDE4OERjZzB4VFgw?=
 =?utf-8?B?ODU5N0V4VUk3dzlqVitBRkg1VU1wWk5ocDYzYXJ3MldQdHdzdSs3NSt5YUN1?=
 =?utf-8?B?YkFVRGl2aDBSSGRnUHM5Yk53c0ZTd3pVamdERnJ1eXFRYTMvRzk0R0J1R3RB?=
 =?utf-8?B?aS9zVG9ZUTlDRyt2ZkhLaUJ5UEd5QVFheitBRFQzUGFETFlvait3L00zWXhy?=
 =?utf-8?B?MmQ3cUwzcjB4N1IxbDl4OC9oWUVGTzk5TjhBSVhMTXJVeldhZzVEd0REM0Jx?=
 =?utf-8?B?OGMrUCtxSldUblBjV2R2N252RDdKNCtuQXBaNVBoemkyQkJnUkY1QXVxYThO?=
 =?utf-8?B?NUNzZkpnLzdIV0lINnk3dk4wN0F1RGVzRW1VTTIxR1N2UllwN2NDeDJuU09F?=
 =?utf-8?B?dHZsNzlRekppS0pPU0h2aGhUTXVDTE1BK0FMUUV3T1BsS1NjUks0SVFvREVQ?=
 =?utf-8?B?aXdRMlVrUC9iWVhpWm9WL1BSMm9Dck10UkhiQSsza2FoYmJ3NzhpYlhiYmNl?=
 =?utf-8?B?R3pwb0tvWTBHQWJxUUZkYlhpL2RpWTBRbWZwQ00zL0pQOEdXa1EvRldDeVVq?=
 =?utf-8?B?ejhhQU04Um5hL2NoYVdnZ29OYlovTGZTazBPTkdoSHNkQ09rZDQ2MllVd3pU?=
 =?utf-8?B?SWhMV1VRZ3ovODMrK2l2Y3dXMjVOaC9RcmtmTVJXYWtNMm9neDJRZnFTVUZw?=
 =?utf-8?B?VTVDMUljVW5uMEJKZTFOS3VzcVhaL2k5OS8vWjNSM0VIcWp5SjlvSkFhb1dQ?=
 =?utf-8?B?c250NUFzQVJTSVJkQWNmTXA1cnhOYkhKRnlOaEtvZFoyeDRGYWdUNnJndVZI?=
 =?utf-8?B?ektBOGlyVG1GQmhUK0dwNDQ2TG5rYW1vTW5LTDFVRGZGNkFXcjRJRG13b3la?=
 =?utf-8?B?MjNIaTBkOWtwUmw2d0d0SFJLZW1meUxWMmdwTVdJUTBQZVF4WWFIdUk2TDVW?=
 =?utf-8?B?cVRxZ2tjcVRBMHVrZC93Q1pydUFHZ0NYaHhYNjhBQ3cyUEp5d2dTdXB4NTRl?=
 =?utf-8?B?bGw5TURWK09ENDFjMVBTWHFRcDZycjBmdzVrZzQ1dEJEVk42NGNCR3lPQXFC?=
 =?utf-8?B?Q1AybmhrZmdQL2E1NVRqOEhwZ01vdzFITTdzOW9aTkxCblZEaDl3MDBZdGI4?=
 =?utf-8?B?T3IrZ0sveGpYZU5rc2hKUUwrQ21FbzdUa1Y5K3dLWGlxU3NFeUpINXRxM0ZG?=
 =?utf-8?B?ek03d1FWS1VIU0NISFAzeXl4c3JValkwd20wU09NK0hublNEYkJuOHZCTThy?=
 =?utf-8?B?V1ZLN080cXU0eE5iL210anJuSjRMRGZSd0lFWnBrQ1U3bzMrZlZ1K1piT1pO?=
 =?utf-8?B?UlBuSldEd1E2Z1VJVmFWczNXSWYyV0VNWHVlQU01MzAyaEZuOGdmdDJaS0RW?=
 =?utf-8?B?Yi9VTVJPVDJURnB2ZkRqYUlDcVFzZ2t3UnUrSHdzN1g5OHR6Q2lsRDVkM3pX?=
 =?utf-8?B?S3NsOGczTTY4dXMydTRYTjhidWsra3V1dmRqMWgyMDBoemVpODBaV1pieFBI?=
 =?utf-8?B?eFN0ZnNWOUVSb0FHRndIcE80WThoVzFwaUVLZnd3SXVzeG5BS2k4bEU1VTFH?=
 =?utf-8?B?NHAxdDdCOWx6eG5CcXJGdVhheUJDcXFPVkJpaXBVcXFlOUwwVSt3b2wrQ3Nr?=
 =?utf-8?B?VytPYlhVMU05WEZwQVp3bFhXckVVenhZbGwrdUJqL1dWR2t3M1k4T2ROVlZK?=
 =?utf-8?B?RWNHN1JDZks3emQwLzU3WENJY1R5ZDdlMzNxVTk0TkJLdE1ZWFVlSDJDakRo?=
 =?utf-8?B?WmJjS3hpVTd6NUtlSFIwY1IwUFlSN3pKKzBxSnRidlJGelBYSkdkRHdDU2x6?=
 =?utf-8?Q?2pGkhwNEJuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm1wMGVuckRsa3VqcDhYbm5uYklXQ0JwRFR4RzkyeS9ZZFNoejk5Sjd2ODhj?=
 =?utf-8?B?dVRwWGVzbERCT00wU2FnNlJNZFFyaVV3WGthbmMwaGxObEV4ZGV2aGtGd2Ft?=
 =?utf-8?B?Q292clRwbW1oMWRzRmxZcFhWZHlJdUk1TG8vdk5qdkRaM2xkd1NpMzNucDVr?=
 =?utf-8?B?ZU5PT1dVNDlzckdjQVFBdDFiaDZqYnBsL3pIY1A4ajZvcEdQSkRRQnJ3bmZh?=
 =?utf-8?B?azhQZFhmS2tiTzlRN1V6ZDZQL2lSUGZUTzZISytLVWJyeE1UNkl6ektVaFdM?=
 =?utf-8?B?T05YZjlJRnA5UkE2alpCV211dGc0SGEvSzdLbEFpV1gySDZEeVc4bHo1ekVj?=
 =?utf-8?B?QVN2Q3ZJYmx1dlJLT1l0dzZwcVhyRW9qRmhURVZ4YWQwNjg3b25aelIvRnhB?=
 =?utf-8?B?Zi80UEhuREZHL2FIWUtxOUQxcjZFaU82ckpNeDlqZmJQUzlIc3RBNnZOcG8v?=
 =?utf-8?B?a0tEeGF3ZFdFK1VyUUgxWFhZbXpaS3NrdmpBc0xMN2Y5M2lvWUJTY1dLOXZ3?=
 =?utf-8?B?TllhN0hCYkRESk9yNjYrZndQRnVleUVYb3UxZ3E2dWxCUXVZUlVpUWtpTVo2?=
 =?utf-8?B?ZmhkQmU4NDQ0QXcwaDMzaXJicWRJT2pCZzFzKzR4ZVBrK0hheTd0bldYOU9t?=
 =?utf-8?B?OE5Vc0lKYW9KSmJjREhoRWp6elAzbkkzanNycFlkS3daekh6SVA3dHU5Vlh5?=
 =?utf-8?B?K3RMRmlsSkF1VEZPdnMzanZPWEdSWGVtWU1BdmQ4NldhY290ZWI3WWtudlRF?=
 =?utf-8?B?eHpjMkRqZFlMMmdYTWxJWXgwei96UStML1BJbHBUbnVIa0lINlBsZnZ0OVZ6?=
 =?utf-8?B?WFRpUjF5UENHZkIyaEpDc1llT2NLNmQyVVI3YVJqNkpxVTEzcFlXNUVOKzdi?=
 =?utf-8?B?cmNPYU04Ulg0MGF4cHFDbVBJZVhTVHVoNWl2WCtJNlZEeTJTMXRHTXdzdzY2?=
 =?utf-8?B?NzgvYXU1VUQvejhXT1V1bWNwdjJrb1FTeXFFZ3hVcDNJcmtoQkVmNE9mSjFm?=
 =?utf-8?B?TFpaRFNVV2k0TThLeENqS3NHM3gvY0Vrek83NEtwVVlGYjBOWExaZ09QNTIz?=
 =?utf-8?B?NlBXT2YyR0djNE1QbVA1dG8wUVMxYklHQkZFZ2Q5dXp1dmRXS1NGdjFqV1hE?=
 =?utf-8?B?dk1Nd093WWhNVGI3ZnpOakdTTzlPWGtsVllXUHVLTlJYdHdmbitGeHVQNmV4?=
 =?utf-8?B?Vm5oNnJKK3MwUDA4d3JieXpPV05JWWpUU3hoQ2thc0VuZk14U0NSMG9hTVoy?=
 =?utf-8?B?VklqdTdtUUVNTzVEV3NuWjBWd1N4RlJlamxQa0RCRWNKRUJuMWs2ZGtwZmxu?=
 =?utf-8?B?NXZRZXd1ODNDTFdKSWV2aWo4eGtDMEs5bEtiK2pTazJlSXZZby9wd3k4OHBL?=
 =?utf-8?B?cjNMWHdCUU1WdzQ3QWZZdTlGZ2JVTEpnWkFlOXBUNGlBOUN1THJDR01yQUtJ?=
 =?utf-8?B?RDJKLzJZYnlhRzNWWVF3UFArdm5nUEY4T0lZZE1nNU5NWHFzL1B6RjNGdFY2?=
 =?utf-8?B?Vm5DU09QNUFrem9zZ05OMERnT1hCQWtJczZZTUdzVlVRdExLdVAzMHF3K3RS?=
 =?utf-8?B?MWtQOEtQSzh3SnlLWFF1VmxUQTQyU0Qrd1U5bXQzU3NoNitqbzIzRWp1U1N6?=
 =?utf-8?B?Qm5pTHN3cmE0Vjc3UVVuQUw0R0QxcE5pM09LN0dGcUJUK2pHc2NjOG94U2pD?=
 =?utf-8?B?MzRSS2U1NzB1T2lKU3V4NGdZenVRdUN5VXhWY2hPMWEzTXd3T3NUR3VnYTFl?=
 =?utf-8?B?Sy9UdTFiZ0lmUkRYd3UxQnFvMEZ1dzRmZGVISzAzb1VaOVpWZ0ZIQlpmNW5n?=
 =?utf-8?B?OHZUK0Q3eXFyazJ6ekJFbTl5dVZCQVFsRklPbDdJQTAxL3pvbnRvRlZkeHZ3?=
 =?utf-8?B?a21iN0MyWHpIZ3NLL09RTS9qYkR1cDI4bStuT0lFVXdiUXVMNUVBeDY5TjZm?=
 =?utf-8?B?S1dCdUxzWVFRbDNac252OGZYSVo0bXNuQUVQL0lhV2N6TjBIdUJFdjN2eGZI?=
 =?utf-8?B?dkJKUFlyeU1RUGpCWWZhb3hyTm8wL1VWMlFLb1lXKzB2VXFnWE1iRWFKNDNa?=
 =?utf-8?B?YS8vdFpGWlJCemQ4eERuWW1EUXF2WDFpWmYwWUNaRW9EMVgybk43T1VzSWVV?=
 =?utf-8?Q?MX9b/eZPCqGvxcvCt6A8Jm+te?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589e4331-e7e0-48c1-b8ac-08dd92df17a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 12:01:43.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb7bFTSQtS7cq0HWyPnnhPXhv7qtx/sOJXU0pes7cuwmM18ZkoRlMHzj+kcOGojHfv4XWSoEf51jpHADO8V3NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795



On 08/05/2025 12:04, Mark Bloch wrote:
> 
> 
> On 08/05/2025 3:43, Jakub Kicinski wrote:
>> On Tue, 6 May 2025 18:34:22 +0300 Mark Bloch wrote:
>>>>> Flow:
>>>>> 1. A user requests a container with networking connectivity.
>>>>> 2. Kubernetes allocates a VF on host X. An agent on the host handles VF
>>>>>    configuration and sends the PF number and VF index to the central
>>>>>    management software.  
>>>>
>>>> What is "central management software" here? Deployment specific or
>>>> some part of k8s?  
>>>
>>> It's the k8s API server.
>>>
>>>>   
>>>>> 3. An agent on the DPU side detects the changes made on host X. Using
>>>>>    the PF number and VF index, it identifies the corresponding
>>>>>    representor, attaches it to an OVS bridge, and allows OVN to program
>>>>>    the relevant steering rules.  
>>>>
>>>> What does it mean that DPU "detects it", what's the source and 
>>>> mechanism of the notification?
>>>> Is it communicating with the central SW during  the process?  
>>>
>>> The agent (running in the ARM/DPU) listens for events from the k8s API server.
>>
>> Interesting. So a deployment with no security boundaries. The internals
>> of the IPU and the k8s on the host are in the same domain of control.
> 
> The VF is created on host X, but the corresponding representor appears
> on a different host, the IPU. Naturally, they need to be able to
> synchronize and exchange information for everything to work correctly.
> 
>>
>> So how does the user remotely power cycle the hosts?
> 
> Why should a user be able to power cycle the hosts?
> Are you are asking about the administrator?
> 
>>
>> What I'm getting at is that your mental model seems to be missing any
>> sort of HW inventory database, which lists all the hosts and how they
>> plug into the DC. The administrator of the system must already know
>> where each machine is exactly in the chassis for basic DC ops. And
>> that HW DB is normally queried in what you describe. If there is any
>> security domain crossing in the picture it will require cross checking
>> against that HW DB.
> 
> You're assuming that external host numbering and PCI enumeration are
> stable, also users can determine the mapping only after creating
> VFs. But even then, the mapping is indirect e.g: “I created a VF on
> this PF, and I see a single representor appear on the IPU, so they
> must be linked.” That approach is fragile and error prone.
> 
> Also, keep in mind: the external hosts and their kernels shouldn’t
> be aware they’re part of a multi-host system. With our current
> approach, you just need to provide a host-to-IPU mapping
> upfront, no guesswork involved.
> 
> Just thinking out loud, once this feature is in place, we might
> not even need a static mapping between external hosts and IPU hosts.
> 
> If VUID and FUID are globally unique, the following workflow
> becomes possible:
> 
> - A user requests a container with network connectivity.
> - k8s allocates and configures a VF on one of the hosts.
>   It then sends the VUID, PF number, and VF index for the new VF
>   to the k8S API server.
> - Somewhere in the network, a representor appears. An agent detects
>   this and notifies the k8s API server, including its FUID,
>   PF number, and VF index.
> - The API server matches the VF and representor data based on the
>   globally unique identifiers and sends the relevant information
>   back to the agent that reported the representor creation.
> - The agent attaches the representor to the OVS bridge, and with
>   OVN configures the appropriate steering rules.
> 
> This would remove the need for pre defined host to IPU mappings
> and allow for a more dynamic and flexible setup.
> 
>>
>> I don't think this is sufficiently well established to warrant new uAPI.
>> You can use a UUID and pass it via ndo_get_phys_port_id.
> 
> phys_port_id only applies to netdev interfaces, whereas this use case is
> broader and more aligned with devlink. We believe devlink is a more
> appropriate place for this functionality.
> 
> Mark
> 

Hi Jakub,

Just checking in, have you had a chance to review my earlier email?
Would appreciate your thoughts or guidance on the right path forward.

Mark

