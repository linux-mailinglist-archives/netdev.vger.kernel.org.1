Return-Path: <netdev+bounces-131647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676298F219
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96B2281781
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235C1A0721;
	Thu,  3 Oct 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D0OhiGON"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168F823C3
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967961; cv=fail; b=bKNy4NMfrhRcwfVnlc/928HPF1gUzbAtWatL9YBBlY03UwmIiTZsRXnF4CtXyYxI60WhMEu5YItAHyx1bWySikvIKj5UbhvWG3lv/NoK/K7sSkyIPp3jwb15wHr1gxTKlFRtzhxcIly4el4USjeBQHnXl6rblKAquT5h4TeTmcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967961; c=relaxed/simple;
	bh=MozkYIpghu/Ss/nwybGY9duVKl4u2ZN4itgIngHJdpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M9oHltM2hw+79T1bIynMYGfP9SrnvFEDAVSus6pGMsq+iMf+hxJ0KXh1p+WgVysrtt9D+ppX0rR1kniVjCdLikmS3s0ACRUYkhbD2f7Wan3HUsTPPMgwFznq91eGP1w4GKKMyByDKfUdm7BGxQH/J8dBf/HY42wLpdEl30gCtL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D0OhiGON; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV5BAgSWMX7WgjHD4FQFzwKwND+0XohRXXmfPs22Qlqk3BX3/bGCQ7Coa02AudD1yNmSjsCX7P/gjWWz08k/Lbb9TDPMgN5bbGg3/Xps+J8tBxhsen4tuF0E0o2D3Vs48PiSVrCyeUfCPdZmioiyhq109o3ObDxdvE1OPIhlkN+/Aao1AVWnAHE5gosGIwOQCMiQQBe0LdkebcCd8PvdmbyounB4+0czUEN/y/5uzfO7jknPtYavLBus7wsbPM+lQha4QHXfcXNNAda3jQUKhmsigoHj3DgD1WvH9ZxR740V3EUUPHuTwypiczUpBQqwaNyZ+tohCkRAQIEwjlf/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=267sJLQ55ukrrSTmXx3CUsv+3RYg/BP5pq0kT9vmHos=;
 b=eT5ZpQgX9VwmEt9VrNrwo0PxmGj4y8+R7N0k2JcBi3IEb05Kt61Sq2I7UyeQJsMkRwZIxVSo3BCKVNzUzLcPuZQ1eF1m2bv7fPZXZJXJ1fD2Jd9N2GjVy0UmnmS/msyHxvKh5Gat9kvUnkF5VpSqCIXoqowRp73kGtFf5vLdIfxI87WR6QVTdbl3S1ogbUaJqNmsI4AIY5wppLSQLu09PW75IRxvn73vuG/l3tUGQKyAdqGj3BDrdZeARPmlysZtJVCp/JBBWueABGWjrXtvrJ/9BNuz6PrLdkRl5IY08zUdbJmKEvdAYDzZoIOiBtWkAQCSiChM4uPURDXCI3UXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=267sJLQ55ukrrSTmXx3CUsv+3RYg/BP5pq0kT9vmHos=;
 b=D0OhiGONqJwquHzBIuVm+FeBnWJ/a/zFOHnobUC3aHRMxsNfFlO3BlOd3BI3SRH03hSu3PVL6GhvI6ATpwOi3bi6PfitB39eLxtuQWFXkMz1VqC5nYHkUYv9/jO22HK4CsZBp02wjFfCicOiZrnu5L8D31AUZuFyb1P+j5X7nwXYEq/ARBw3pDErMOnkdQhQo+KfppjWIoRWjCcjbY8SpwFBsVMw/+q4BnZlJZmyM2v886oEZp7ZEiuRi/drvrBTLcaKtv2s3hCxpeCgwYpgdlYCKyP6V11K3L2j0nIsS2Xucv5SvTkKojOUo0HaH22j8vMS+oi0UPqWUT1fMIZpnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 3 Oct
 2024 15:05:56 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:05:56 +0000
Date: Thu, 3 Oct 2024 18:05:53 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 03/10] lib: packing: remove kernel-doc from
 header file
Message-ID: <20241003150553.h4nkoauzgv4b5g55@skbuf>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-3-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-3-8373e551eae3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-3-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-3-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5277cc-6c42-4fab-935c-08dce3bce1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eEDCz2IG3CRsBKz6E/77t2Zfg4qWdr+uvsGUnEL0DyrtRgHstmJh8Su61Nwn?=
 =?us-ascii?Q?1j3vhnU90p/+k2L4Vt3kpu7N+REA2aK5fZNY6U9O/hOt/j30RO7xJPjj38Gk?=
 =?us-ascii?Q?T/pCZ9RlE1d5HsENXbmamQqsQNDiX5dlwLB+0XUlY+WUgVZedrP+pq7BL8w6?=
 =?us-ascii?Q?qvaSV5E3/D+4Z0/+vVweIA5XzoOJHy44FvNBRY8tNJvIOaMt4GFdiqiNtZZw?=
 =?us-ascii?Q?20LHjyNbDtK8H6J9Vu6nWeKSD8dBK0s1X+ohg96fYJ/pljbscqKGe5yQ907G?=
 =?us-ascii?Q?GVUqV3XSX/dk5Sj5kCVRAuZqJKLWlZc6NHBabQLTgrJvwmlkFrzn2s0zv5Rp?=
 =?us-ascii?Q?TLHlH5vkGSbL+w0IkY3dEodJJ7Fv/94CoDEDxRAO1V/FMFQoNANNvZz3tQD6?=
 =?us-ascii?Q?ah9lhK0iYwUL3ELRtkeBoPsFVBkjadMOmmfNj5+6gy2QudVgalkEDjmYoac/?=
 =?us-ascii?Q?rqdGv0hLJozw8m5wUsBYzJngqd62TdjV2M9Vqs55gQgMk457eQVMpvWdy8ZI?=
 =?us-ascii?Q?J/+A0fK+iBaQNcSrX89WVCC1dv/4Jn5QWFZnMDZLSgJ9BIRFm3DaQwvoNx2j?=
 =?us-ascii?Q?tka/rUv028H9gvakgz78zAQMuYZixALuMG2VLYlPyEImNJZ5v1EETAM34jEA?=
 =?us-ascii?Q?4irCH2tMMD2VtZFZedqS0Jcd4TZzixM0jACRVhMo5NPQf/a8mXwoWYmWysIJ?=
 =?us-ascii?Q?QvRoRQEOJfrSahr6azlnlo7Lr0wM8ncPo1KMrd7dq5YabqK+X9ePc7CF3jXV?=
 =?us-ascii?Q?I7kQXU4z3rldqd5EsnJAoQZq3LdVbGGf4o8Suifj5oF3FlkNpn9K//e3d8AR?=
 =?us-ascii?Q?AbNCdeSj/2SoNdmMztJmqpPVC9AACRO76izn1Q9+OjQRD12C4dAWl9/2FAuL?=
 =?us-ascii?Q?rFEZfKm2BlvTnfjl6Q8pD6KudjLQ18vJv8WDjA9mzw6pkByeaTa+/bUjxnTs?=
 =?us-ascii?Q?NjRCVsTSBAvZ0Q30zqCgoKyDzOcU0gPfTAbquo9YSFti2FuFBYAtFcdc7OpE?=
 =?us-ascii?Q?SGuUVSjB35eIabFiRoS2C1EDi5KiI+w9NwhZ/Q9+1yamSCJzkJ8Ku2FcEIMq?=
 =?us-ascii?Q?Spdt4a/FmIa/YyzwQMCl13y4TQxXXhMHnUPDJ6+52lr9vCiLSemwSwZNBwuH?=
 =?us-ascii?Q?Si94/r7gfiQqjyUussa9zI2el1lmG5SYy8XCacwpOJnAr36fywLhFPSEZ2QH?=
 =?us-ascii?Q?e6ujvTzBwkynh3k0D8FpPGQ+VHMFSoRg50Roawv5qYnIKwkuluXMh3E/6XUI?=
 =?us-ascii?Q?c0aKzqx3NV0KLdH0HVMKLHcjw2BEN+4nsUq+ymWhBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?twXWT6/RYBRRwYivncBNhnnJlwi5FTU4ERHdkPUF4LmsVH077UlXWSUQI+P8?=
 =?us-ascii?Q?LC2EWvkId84FenLp/SEp7oqTF17qgszfB6d91y0RDyRHpZpNa56d+iXe31UT?=
 =?us-ascii?Q?J7VpJkTvyewE/z6hKYFQ81YHWXyy2Iw83tDEEXj2ZJyu2kgPoWguM2RFij7T?=
 =?us-ascii?Q?fy1XF880RNLtsgA9Yvk3IPMqmYgZGTlybWprswyqLdIAjlu7Fb+gK6o8SYR4?=
 =?us-ascii?Q?Dl5DbtIOeY6e3oFjABihz7zAWwjnebhYZGC2MjZQ3VNPfC7yjfDBqPytP6/d?=
 =?us-ascii?Q?jYorNtT9ELWUFa4P8Ul0FXLGA1jfsOnR570XfcVby07cYJvR+s8shwlUHzUe?=
 =?us-ascii?Q?l9ywNUmhAatl9eeyMtOlByialYdDvRB+yc5I6FerbxrJxsuWM80gilt1OdEy?=
 =?us-ascii?Q?xJP7lw0FxRw6edfeOftfO0gEpqwAVigOZ+VsP7SXX7h2ggCDsckJlYU44iJc?=
 =?us-ascii?Q?ddLF0ht5Hyvk2eH5yQMO2tAxYzhYPQzP9tXxPPmR1iKZ1ZlNkao2ksa/Kimw?=
 =?us-ascii?Q?2KWxU/y9AZBqzrtiCdbgnuvW2s4U31aaQCNVl6Ee8DAb05fIsTQg6xy2h9pi?=
 =?us-ascii?Q?oJI/RMSjyXjLxKsWcn1CN01FLKIhVSAnqTBw13mTRfM5uerQDKdN0ylqG+ng?=
 =?us-ascii?Q?Na8pLCNqTzyVwi3sPsQ8EWnNwff2cQvl5pR/8ZlhnXUfiOqY0Kj8zCB9LE3q?=
 =?us-ascii?Q?cRq+WjyoJfXCPtOWfGzZ1bPfnv1ACFXNHHhGWlSLKsA72qNsdu8JaHuYLp9z?=
 =?us-ascii?Q?HOG40+lk8SczexXTgoIdcFGr+iXRD/CR9rHfRjcu88S289Or161NcitlSVAI?=
 =?us-ascii?Q?pF6izarheDJ+1lqDMz6dMYR2iJOANUcscs+z9krBqAVdXITWUpHKfeBQRqo+?=
 =?us-ascii?Q?jB4axkfxN1v7RKxvCRMtUxXJw8kStx//pyzC8Hk1qnwjyhLbwFuIRNmc97QL?=
 =?us-ascii?Q?oJtssINsEunDfZlQsofI2OyPY94fOEoXM2cEe/zsxeQGzwEOQCO6KEvxA3np?=
 =?us-ascii?Q?v6neck4ld/OHbDzs5ndLnHvYk+21SHM6vdSmGAOdpZPpMapTvKPyXsygz6TW?=
 =?us-ascii?Q?pbt1Ltvijp3q8ofMEEhl+P+OBG6YAkKZnMcUmJ6CArK24jQax7C1GPaUEiQ/?=
 =?us-ascii?Q?W2wV3lzj/r/fRvJdpcuGPHzWjfOTpQ6CuxXW9cxHkaN6ONoOIVAvzCxGFy7p?=
 =?us-ascii?Q?zK02JDWcOhN6GOIHngbe9KYIrMzjcEIX/ubm6EFcxALfd4y6zZBJVvLACTfn?=
 =?us-ascii?Q?AdS09Yv4hy3GxJK7rSguoqw4xjaq65XEonzSMPR7KUs/nyIYeI0k/Hts38Aw?=
 =?us-ascii?Q?J2pbA++CvJZqvzlbv7za6Jvy5so8/3TQEDs5i8d/qsT2QUh606+PTk5Fx3Sd?=
 =?us-ascii?Q?L3D3XYv2cD4Q2uIBRYMoWKQEwpnzh1a3fTCyHuaYF/fru0lCAEz5hgGhADU5?=
 =?us-ascii?Q?2Ymtfu32ad7+6I0KrrWy/jJGVX2O1jPgk2CjhfCvOr0kh7vaPNPXlJ4c1kVH?=
 =?us-ascii?Q?/msUYY70f9oll2SFyj0eozIBNaYiLvVLPkXgnZEcAqSlCg1hNyKRLvbqthoe?=
 =?us-ascii?Q?vbnOdgETLUaElMY0BoPogfZNkqqyLB2zzcADU2yVXBRVKg19HeRUmiz/HO0n?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5277cc-6c42-4fab-935c-08dce3bce1e9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:05:56.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HGMsItU8Sy0g+mhg2jY5bewfE3M7nCCtZ0A07ukAe4imm1+2DfQM5YRJ4LjXPlvvqwVFKCT2iZW36zoxj1bIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

On Wed, Oct 02, 2024 at 02:51:52PM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> It is not necessary to have the kernel-doc duplicated both in the
> header and in the implementation. It is better to have it near the
> implementation of the function, since in C, a function can have N
> declarations, but only one definition.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

