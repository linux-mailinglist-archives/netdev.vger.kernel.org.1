Return-Path: <netdev+bounces-168820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA9BA40F05
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 13:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AC63A4597
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E607205ACE;
	Sun, 23 Feb 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mydSSW4Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342719C542;
	Sun, 23 Feb 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740314632; cv=fail; b=Y6UpCnKL77FhogBuuiR2lSISyBjnVKcspf2Hdb+tyJ2aYlPoZajFmuYB62AWn5+R21LYWcRwcBAHzxPKUcBvvaJ0nzNmZP7YjWTJJR7FKBz3WLKT0J5yNQDpeAIEwORIAMKGK5+Vxs6aP1VsJ88cBqzx1nh8MaAeUmm9r8jzD3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740314632; c=relaxed/simple;
	bh=Y7psj6FnIdjv+DsQN0s2hE0CQlt1e+2FSmWbofAozsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PYDzB6JOUqzM6ZE9gZMrGhe8ZF2/LyJl/Kjj0mDNjyM/GR3xKpjixEnzHrJyFT5VxXM4AD++CIr9SSiDQcTgDypU3HWHdVjPxNbnPhDYZHjj+uD463xjDBT7K1sq4PXbSF+ZdThKa0Z3vwJLswvVv+nzvBFXknyvVXjltg0j09g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mydSSW4Z; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok0p/8mz0XKI3QUn1HEePaW8xLhirS7i0umfuzPNF9orqhO26mEvrtcfvHzbYIIg0TJ5Q6jPzeUfzRcQXXmikhZKyVaaAhF5rsD/GURZemSxJVEZUlmBxVIpbdyadMvdOIO49SWYm77Hwc4iKIPEAyJR9l6wZyRLFMRK9tsZp8iyVPS0YqAwQAR2eBQtTHDdxFtNjUEuhtz+PJsRI29zOYY7URRUrVZY/3oIsdcCRA/SSin7if/tRLOhJFww19Au182FCYl9QdX3CqZkaB2aVOe0JL7481Xzk8usoyEVTQ/rO5OZgQwOq7+3atDliqJhFm7Gx01MsP3F8z0yJ/+lDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoPE0ldk9F8RI4CJSLlYskQ9A6KVrMEDLgWnVWSCv+U=;
 b=L1jkxyXt5v7LTmhOyrPrj6vmYzXEUp9BXwxRU7r2WZ+UH8d/loTaVhtuPmDBMPHbD4Oi0eJ1aD6H7UuVmRTKeXNxo5nmHqrB1K9u9bisq4bGIhE7ahxyVQS8b04ILOFFa5v1LoN8XRjUghQ7cuuz2zIExXlaO/1QtsihFqyT1eNjZifX3Xl7u3nETVHtCdJjliEOvP6Ula2uu+hgG0/8OrMRp4o3OUWnvNw8NRwO8UgkGSDXgPFKulJsO6yHtknnAXchsn467kp3vIkQ+8I9xG/aMpiMamGzjLsy0IrWsp/5Yk9WmCKn6mQT7OvLnWZ669kQIaV7jgj6Fc7sa21ong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoPE0ldk9F8RI4CJSLlYskQ9A6KVrMEDLgWnVWSCv+U=;
 b=mydSSW4ZEEcpGbRKpVp2raTV1MNuZUwBfmZhhzSY4v6wsLWFl6eIEG2M67aUOuWhb+Yt/N4nk4YKSfFDEb55pozzXU+RNKiekeNIXtn2iMjyR465clhP8hKE+q3raCfe9XpcHTASuHjwVc+11hB0j4uFG6SaqLVy8U5i6BpLLopTWAj6ecoNYoJZN1O66PWgHpkqBl0rMTJYsNQJB87053b+/GBJKWWfmzTbPhP5Wm2AxnP9YIm9rrKSKGbC1kQnezG2LKD6ODAChC7EO8ieAMCCbF/ZRVgIaiYiOB5T0YuxecGbE+q4JIQllubKRDvwWIT5UaV9+yIRaUR63hCjfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Sun, 23 Feb
 2025 12:43:48 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 12:43:48 +0000
Message-ID: <a3dde0e4-aca0-464e-a93f-8721b0919e69@nvidia.com>
Date: Sun, 23 Feb 2025 14:43:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] selftests: drv-net-hw: Add a test for
 symmetric RSS hash
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-doc@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20250220113435.417487-1-gal@nvidia.com>
 <20250220113435.417487-6-gal@nvidia.com> <20250220180351.7e278ec9@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250220180351.7e278ec9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 139eae95-acff-4e8f-6b70-08dd5407b793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlUydjVrSHNNZVVRbXd1elVYNTVrMjZLaUJXYW1zTjJXdnVtbTIxMkdYa2or?=
 =?utf-8?B?YkFwTlJIaWw2NVBTMUVVaFlScU8raXBZNVNPRUQ5UGNVYnRyV0VRTDlpRXd6?=
 =?utf-8?B?eXZuTXJCUFk2Y1Y3SzVCREw5alRDRy9WeWhBQnB4aFgvLzNWRkxYNTRIOFdy?=
 =?utf-8?B?UWFXTTlkTjZSNGU0QTduQXlxamhubHBFMDlWTnJ0bEdhQm9uNlA2Q1dKemVK?=
 =?utf-8?B?a3AyS0pVSloyZmg1M0JidUI3cjN2K0tadE16d2VpMnAvK1J6c1FmOHdONG5V?=
 =?utf-8?B?K0h1SkZ2TnhPc2hxSDR3aTJsNXpOYnhHUlJaTHlQOWRKYjNnVzlhY0FvREZE?=
 =?utf-8?B?ZGRWWlZna0JCSFFZb0twQ0lRNjZIOUlnOTZxT1hiaGkxU2NSNjVZcTdpeGxk?=
 =?utf-8?B?RUhrYXVPUUxoRTRvVlB1d1o2a0M2ZmJtL0dQcFZvR3NLNlgwMll2Mkx1TWli?=
 =?utf-8?B?SzNQTys5Vm55Q2JFaU9zSmRLZ00vR3dWdDBpMGJiazEvQVBWazVJQk5IY1hP?=
 =?utf-8?B?MFRFWnVRcmpaSVZCUEVQUjVmblV3a2lYUGZabno3OEE2NnZUNUYrOFMxaXMy?=
 =?utf-8?B?T0dQSkduc1I4N2VwMEwvT3gzc1pxaUg5dEVVeEVFeS93OUxSdkhGOGZxMHNE?=
 =?utf-8?B?VzE4dU5mM3JwUkJZQTRYU1BPQmQ0c2x1L282NVZUTkJWaWg2YUs0ZTlPQ1dr?=
 =?utf-8?B?enQxcWZMSEV5UGxJanJJRGt1UzZQZ21PYnB3Y0IwaUdLbDdlYXJibS9KbmlH?=
 =?utf-8?B?SzZPb09KS0R6ekhiVDROS1RYTGtGNTRQVC9zMlVzVG14VVBZYlY5OVlrYmtp?=
 =?utf-8?B?a2xJdC9qZE1xUHF5d2QvSllxUHNzcDBFNWZMUTZ2NHpTTTF5RGZrQlFTY3Ba?=
 =?utf-8?B?U2JjTHN1c21vNUN2YnBXTWZVUXZKMWYwbUVIVjRIdFJWYlBiM3FvRTVZcG5H?=
 =?utf-8?B?Y1JjYWlEU0NzS0JoRlhLc2p5TDVwNmU3YlBNT0Ezb2Fsd0ZJUEs0VE94ZjVq?=
 =?utf-8?B?WGlkZFlCbTlPQm9sNE01cEtCOHJRb0dWR3pKSlA2SWI3eWdDOG1ZTHBZOFdB?=
 =?utf-8?B?V3U3NC8vU1I2M01yVWoyWWFpY0tvanpzSEV6VEViM2xVbDc2d2FpMkNab0pG?=
 =?utf-8?B?ZWJoc1IrZFE3K3RzUHNvS1lVVDk1NlRSd3VYMXh6MHVjQUxhVVZ2bEd2RjQ2?=
 =?utf-8?B?UWVHQW9IYkVqN0FGeTdhQ0ZMR3BHQTlCMmJKa2oxRVhVWFpjaFM3WmNWeStQ?=
 =?utf-8?B?YmZrSnFRUmRsb0phQ0pXS2VTT2lIMzZSbnUwbFRPWmpVczd2eWlMUTdaMitz?=
 =?utf-8?B?em5INUtqZE91Tm1mK3VRZ1ZPRGVxNHZqdHBBRFR4ajBHVzh1NlVUdU0rbnRP?=
 =?utf-8?B?MHVtaitydm5GMmhpaFJmaVZxRHJaRURmOHJmRVhuVlRibE9lMjk3TTFTb29W?=
 =?utf-8?B?MVgzTnJMV0RubHRzUFBjcGorbkZCMWIxamMyeDhhTWh5ME9mZk5sOW5NSzdU?=
 =?utf-8?B?R3JTQ0tkZ3kxMFdVNGVhak9RZUJIaTJPSUJjTTNSazlia3JKQ0xzekVoREFx?=
 =?utf-8?B?eXFackxqdHRPZzErRTZ0S2R1UklkbTZDdWJ0dGJ1YWIybDd5VzFFYmFUZ2hl?=
 =?utf-8?B?NkFsY01rWndBcml1NmhPSGdnaUJ0MFIvQjdZWjVJWFNCWmtxUVpiQUV1bHZR?=
 =?utf-8?B?cHp1YVVvR1hySU14TXN1Zk9tOGJ6KzNLNGd1Y1RNRXcya25xajhMcnNpN0t6?=
 =?utf-8?B?Tk12VTMyUi9ZSUcxMStPQitBNVFOMGJMSW9XOWdmY3lhRzZPRVFDbXhxcjB5?=
 =?utf-8?B?N25ybVc5UGdIUzUxWk5memhmOExXRDFrSU15Lyt6VkJuTEtXZ3JzRVpKeWlZ?=
 =?utf-8?Q?an6EGL1WeOkAI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkJjOU5CeEJybnYrbTZzb0tZc3E3S2JucXFlNnlpTk9TbXNPVXY4WVpsQ0xv?=
 =?utf-8?B?L1Y4NUNIVndMTkZaSDNtdDcxUUdoVkQzbGM4WXpvY1VGVGVUbkVWNWVtRHRq?=
 =?utf-8?B?c0d6V25Nc2s0TGs2cGNPZXlPcFY3VTltS2lUOVpQdlVXVjB1c1ZKWmxFS1Vw?=
 =?utf-8?B?RktXeGx5bUQ1UWl6RUFRNXNwRWI2dG96eUMzK2lKdUdhWnZPOEF4VXY4dHJu?=
 =?utf-8?B?T2FUVEc3Ync2anVDMzhVejREOFRLblJ5amhBVHcyL2xtaC9KUU9SUVN6eFRa?=
 =?utf-8?B?MTRWRFcxcjBtUVNnT0pjRkRGeExmRU5Zb1V0U01jL25sUE8ybHpaZmRvUVZo?=
 =?utf-8?B?VUM4bGlrRmVDYXVMVUdzNU92ZVZpQndpRWdiQnp5UForMjhNYUtvQzE4bURv?=
 =?utf-8?B?V1lxT00vU1VpbVNCWUduT1NaRnlUQ2dwRjAvenBqaXhSU3BJMEtlOUNTUmpl?=
 =?utf-8?B?K2VUbEJLdmNNaDZtK0hyaEs0M3hPaG5CSmtnelZ3U2V0U09oYVRNS3k4Uk5i?=
 =?utf-8?B?Q0JUL3BSMzNSb3AyWXpuUWN0MUc4QlU5WU40MnFjQzhCMkRPdDJBWGFyMTdl?=
 =?utf-8?B?VlFvVTY0dVBQV0oyVjA1Y3lKQkVCeXFwbVd5clA2cHJUNUI5dk1sUnN1QlR2?=
 =?utf-8?B?MTgwUEY4bmZQVkIrZDlsWlJjUVBrNUptcGxLL3U2VnVOc3pmSFVvdi9wVjcz?=
 =?utf-8?B?Wk5hVGxPUTZ1S2xUWmx1SXpiSGovSGJzWFF2anJHTXFOVDFOUEJXQW9uVFRh?=
 =?utf-8?B?b29WRmpwSUxpMUlONkRpVlhQclh1clZOVDBlRnlvdE1RMnhjZTI1VnRLbWNj?=
 =?utf-8?B?eTQrM09jcjZCWFpmaTl6aXlpRWRQMlUwTUgrTUlEY2w5S2ZTSm5LZWJxcEU1?=
 =?utf-8?B?UGRlaVJFbXA4WEUrMUtJTWlZUWJrR0RjdjJ4YnZlbWJFbjBMR1p6TldOSzd2?=
 =?utf-8?B?L09YdkF5TmlNOWxrcDQyMjkvRVlZazZHS2dGN25CYVRGTG1GcENWS2xpUy9t?=
 =?utf-8?B?c2RRS1REdGxsUmo1SFFQbUV6U0JtNDNrbjFHSk5MY0h0a1YxK3dNcHNnWVlj?=
 =?utf-8?B?SEYrd2tQalNyQ2NGR3BnTmpVMzY0eHZLNjBKOGFoWUExM05SZkRuNlRHVHN0?=
 =?utf-8?B?c0ErWHFlQW5EelA0MGMyalFjbHpxcXlHajd4d2FqLzFhZ0YwMW5yUjhOeXRC?=
 =?utf-8?B?bnYySmthSEdDNG5zNUorcFc5bTlQTjZxVnNBYVhNbVpTSmVSWndsQTU4clRt?=
 =?utf-8?B?R3MyeGZHWDV1QlZhMVRwK3g0OFoyMG5VSFJGOHNyYVdqQTRtMUVHM2lXT3Vl?=
 =?utf-8?B?YjFpS3dQU3RhcmUyb1dxWCtmL2tEb0dTVExqOG1jTkpEQ0N2YlpuVW13UEpK?=
 =?utf-8?B?dGpHNlNENjRDWm50c2JlZFoxQ1dpeENycXZIT28vSW45bkVFUVJTVUdnbFFs?=
 =?utf-8?B?QkQ4WVRlaks5WkhQcWpQNkZuTzlKcjNEdzVsdVlmNGwzM1dibVpNNVRMVjRJ?=
 =?utf-8?B?QjlCUktZcWMwRW5SUDA4d3VoakxuanhMUTQ1cHJldGVjN04rSjdDUFpUQ2Yy?=
 =?utf-8?B?SG9QSjdVVGpOWVBodlRUbURLT3l6cmIxSWtKd0RtQ3FYMzE3Y0c0eXZnWHdr?=
 =?utf-8?B?bU5FQXh4dWJpTDZvYmVrQ0UzWEp0Z0NueURBOXhrQVhKZkhwVzZQTEcyZVQy?=
 =?utf-8?B?VmRrdG9VZzJUdmJFZEI5blhsRTFnakRRVWk4ZU12azJGcDc2RDRTcUFKZTBG?=
 =?utf-8?B?MFhBYVFyM0I0KytkYWFBMU9oWTJTelAvc0xnaEcrSDdkMjNXUFZYT3ZtQm1q?=
 =?utf-8?B?Z0RHeVdOZ2k0YmRJK3o2QVNBOVpaMHROcGtnSzZSVmV5Nzh6ZEsrWWFJU0ZN?=
 =?utf-8?B?cmlGbWd6Lzh1clNDcnhKQm1HQmg0Ym9rQTkvY3pXNzJhLzNNbmRnTFRUT3Ni?=
 =?utf-8?B?eDNZRTVxR3RiZjhYSm9lWlZYZXorMndpRTNIbU8zckJ5dG1TUVFIYXBoL2Qx?=
 =?utf-8?B?MHhZalg0WGhUakJtclJ2SXJXVitsQ2k4VzlkdzJEcitaUElTeVF5anlvTkRw?=
 =?utf-8?B?UWVIN2ZBc01oYVZvOEtNYStMbkNqK3htMnZDQXE3ZS9LRVd6ZTJ2VUUwQVJo?=
 =?utf-8?Q?VCVGAVyzG+4J67eV7URJBk+GA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139eae95-acff-4e8f-6b70-08dd5407b793
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 12:43:48.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFBi8RXbc70GJSAF8Ua6ArnM7Ivnp6fPNF+NehsSuhCYPTcEGdaynkun8MQi0XEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436

On 21/02/2025 4:03, Jakub Kicinski wrote:
> On Thu, 20 Feb 2025 13:34:35 +0200 Gal Pressman wrote:
>> +def _get_rand_port(remote):
>> +    for _ in range(1000):
>> +        port = rand_port()
>> +        try:
>> +            check_port_available_remote(port, remote)
>> +            return port
>> +        except:
>> +            continue
>> +
>> +    raise Exception("Can't find any free unprivileged port")
> 
> TCP and UDP port spaces are separate, I think your checking if the
> ports are available on TCP here, and then use them for UDP below.
> 
> We don't really care about the 100% success, I don't think we should 
> be checking the ports. Pick two ports, send a A<>B packet, send a B<>A
> packet, if either fails to connect or doesn't arrive just ignore.
> As long as we can get ~10? successful pairs in 100? ties it's good.

Ack.

> 
>> +def traffic(cfg, local_port, remote_port, ipver):
>> +    af_inet = socket.AF_INET if ipver == "4" else socket.AF_INET6
>> +    sock = socket.socket(af_inet, socket.SOCK_DGRAM)
>> +    sock.bind(('', local_port))
>> +    sock.connect((cfg.remote_addr_v[ipver], remote_port))
>> +    tgt = f"{ipver}:[{cfg.addr_v[ipver]}]:{local_port},sourceport={remote_port}"
>> +    cmd("echo a | socat - UDP" + tgt, host=cfg.remote)
>> +    sock.recvmsg(100)
> 
> Could you use fd_read_timeout():
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/net/lib/py/utils.py#n20
> 
> In case the packet got lost?

Yes.

> 
>> +    return sock.getsockopt(socket.SOL_SOCKET, socket.SO_INCOMING_CPU)
>> +
>> +
>> +def test_rss_input_xfrm(cfg, ipver):
>> +    """
>> +    Test symmetric input_xfrm.
>> +    If symmetric RSS hash is configured, send traffic twice, swapping the
>> +    src/dst UDP ports, and verify that the same queue is receiving the traffic
>> +    in both cases (IPs are constant).
>> +    """
>> +
>> +    input_xfrm = cfg.ethnl.rss_get(
>> +        {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
>> +
>> +    # Check for symmetric xor/or-xor
>> +    if input_xfrm and (input_xfrm == 1 or input_xfrm == 2):
>> +        cpus = set()
>> +        for _ in range(8):
>> +            port1 = _get_rand_port(cfg.remote)
>> +            port2 = _get_rand_port(cfg.remote)
>> +            cpu1 = traffic(cfg, port1, port2, ipver)
>> +            cpu2 = traffic(cfg, port2, port1, ipver)
>> +            cpus.update([cpu1, cpu2])
>> +
>> +            ksft_eq(
>> +                cpu1, cpu2, comment=f"Received traffic on different cpus ({cpu1} != {cpu2}) with ports ({port1 = }, {port2 = }) while symmetric hash is configured")
> 
> the cpu1 cpu2 values will already be printed by the helper, no need 
> to format them in
> 
>> +
>> +        ksft_ge(len(cpus), 2, comment=f"Received traffic on less than two cpus")
>> +    else:
>> +        raise KsftSkipEx("Symmetric RSS hash not requested")
> 
> Flip the condition, raise the exception right after the if, then the
> rest of the code doesn't have to be indented?

Ack.

> 
> I'd also add a:
> 
> 	if len(cpus) == 1:
> 		raise KsftSkipEx(f"Only one CPU seen traffic: {cpus}")

It's covered by the less than two CPUs check, I added a print of cpus to
the existing check.

