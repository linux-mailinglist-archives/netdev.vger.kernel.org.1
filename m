Return-Path: <netdev+bounces-131650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D342B98F23B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24020B22526
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3051A0721;
	Thu,  3 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J/xGvUzi"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E17197A65
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968400; cv=fail; b=bdAG1zPG8Bh3nSXDdbBivPFxavEwIdOdNjUCJCIxY5CABbQjClzTlSn8ytp0T9z71j92dr7Yla3+K+d/h8nSl9rBx1JUP4l7EFcnUe+pzQ6wb66AisXHgGW1NPv7JgNjRikdbaGkQQ9DVNHq6LYhzZyTGyApzZLNxQY0SOeLCZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968400; c=relaxed/simple;
	bh=Po6iZnLf3Hn5Y58l63z7GJxPS3Kx5oPSc/M1fz3RHPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/NVPLNSQ+89MEUg4hfQpav+3etMJROCSBfPuhXWYhKuNw2eN1uM/A34IuQgpZmaGHki3o09WuHueYjATi/DmRvQklVbIIzq+FrNhBGrmHK9fnRx/BI27eyUlUOfrISDXOk1gLTcTtj9P/WNbLQQOprer6S47iXIGBo7G3GqdM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J/xGvUzi; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivLLHfspyOyvYzy2HPnMhsvISf+NLWzMYDB9x1bzHoHRuXaVCtmDGZdfYzWT4W+HMAu4Vt5GuNHMbf8lvUKuxJrgQmhq38+L2ls0sfuczw/HxkUkcZ2lTf1HG1eWX94q0C/raNkMZ+lIFyQWqXp+9CPzlpZrXKD7eAzYwIn/yqnLVgEcjf3ZoiGxBhWKonKPQ/P7LE4NIzpEWmxTzHGe6YpPbiLtDtgvdK8uy0EJB6TRoz1kedvVIljdCXYdUW/1Id6dHLrqx3ZHBQTadJoX+jLpuMzL2nonlLNteJE7wFnB1BAysDVkneziB76KGRcQEV4AOBMpPOKbrwU1OPfthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jBmR+C42UQNo7mSbYL5ibObC2H2flxfKOpaAgg1uNs=;
 b=UfEcvgu4yVbuooO72Uah3RxkxG1IIqd+/iGRImefla3YT2+fHeCZbRra7zWF9IkSDI+XKysApA/OmhLHtQiXfgWz2axVBBRhWQlLA0Rw8nAldz4S5ud624CpUFxjx/35fqMPwXqmQk5buJSRkpt954PQmE0Nplnnu3RlSnoIOnZ4pXqCLFuTQJo7YxBLYy5BkfeZh5ZsPM2cUkMEqZ/BV1d8Jqf96G1QVy3WMPrmx5Lx47YuQrc9yru5icVl3jUn3w7b1Q67mskCrd0W8veqC536h8/ImJNJ+Ic5X6HJRuGR6YeRat+mvEMUUafDUtPMkqOY47Q2eSb5jtb+ItsdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jBmR+C42UQNo7mSbYL5ibObC2H2flxfKOpaAgg1uNs=;
 b=J/xGvUziuGuTl2AX52R71u1PRTu0pZW5X4b1DR8lH4Xa6VYefHVaREN3m5zi3yyBgO/fF6ZhDtRj5WxDI6Lhh1LaDMHBnQnuTfiomizUPP/XCWv7rybEwvcoOgh5TCazqmGRjN/p5Ufgh0gKq+E8Jd9/uRcsq4h63+EXGCL2NHLtAWWC+yVoaVnGyTI2WxbK49NRsadzWPFbGSKh/HHPI1GY4OYo97l4QOegU7dg3CoNs4cEgc2Of/fiHMr630CLwzoBHetIWOREROVifKpXflrk9MeCTB0OEJ8hetHqLV4WGk/0EPDiB+X2oHlpnYzPFo0JdFy/uB1HaT2VUmdDfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB9589.eurprd04.prod.outlook.com (2603:10a6:102:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 15:13:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:13:15 +0000
Date: Thu, 3 Oct 2024 18:13:12 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 04/10] lib: packing: add pack() and unpack()
 wrappers over packing()
Message-ID: <20241003151312.ewo3dpadnjmv3beu@skbuf>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-4-8373e551eae3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-4-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1PR06CA0204.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 407aa28b-e850-4667-d387-08dce3bde750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vRKWMzKV3Jmc9XbVE1F4pZAeeH+r6EtK0TUE7T+Z4lLmRhiDT76gdwCluik6?=
 =?us-ascii?Q?MupyJ0rOhBhbk5CxkbQ5brR0yCwjTylGhsiJW5fEXp3AOK/EC7qPHvDLM0Zf?=
 =?us-ascii?Q?q4QMC9MaVMQJAVEzoGo1d25o93EjPlInaeZxdXbdIjBKDMoGYbtztc6sPx96?=
 =?us-ascii?Q?3JrsnsLpySEgD7MHla6hrIVH1iWK07r0hxDhR2l4dZ/gh1T/mOXQpeyfl2ad?=
 =?us-ascii?Q?dBJ5nv7NNBzkOKJE0PxdIpXYY34qy+kIn5WiAzvVPgAv/JuyVEWBETDWRDLA?=
 =?us-ascii?Q?4CJJkwZPZ7IhQJbtU7C2drm6mTc/Djk2HtxtK1AmwgeqSqZf6sQnxDYtMTb8?=
 =?us-ascii?Q?Xp5UtYf2m2qHHIbaqV59tUv19KUDpBT+FPG0qVu+QJE0uc9dkvN9SalpBc7A?=
 =?us-ascii?Q?BPpym3cxo/UEGbJvtp2cmjX5hLM1H68jwv8VIF5EaDtcYZaolfU1LUQ6WZTZ?=
 =?us-ascii?Q?v//GLgXrQwYkk8ouf0+je6jSnZcx5GdOb6GCYuG20xg1rpPShnqgsYqSTVK3?=
 =?us-ascii?Q?aluI8nIausNSPBLzBv/MOIg771n4SgLk+UzrnrEqI0ff+GcGz1+Rc4bJ8t6Q?=
 =?us-ascii?Q?7ExqnY9JOZhQBhgU1Qqmw5OM/VE5GP+7Xg4NEVD71CyqzEPWBn0fMVfxdFLm?=
 =?us-ascii?Q?vcsZK/+h7LXpJ4IWgAGzFAMj32JnAZyVCnwdzU1oFzZgIuoquhv95iMR+W1k?=
 =?us-ascii?Q?KrJ7E7c6Y7yYVD7H/T66Jy0ARIGgqFC8hzK0wcQfcnv3tw+210IzLHo1Vn0B?=
 =?us-ascii?Q?PsKMFXv4SHbdWRVv9+bMt4ipx9bANJS+K++gax9KZsdKqhvjpSX4BIR/oo8V?=
 =?us-ascii?Q?1AWMPlNC0QZTEiAB3V/PRhy3Y3BL5gAGOHZJr7ptMXD8txLyGAJ43dFsdeeT?=
 =?us-ascii?Q?AyhtGhXdykzVh483fi4k4voq/zzdLmsBR/NRcDVWSYAE6GY1VQm04hgCe6jR?=
 =?us-ascii?Q?cD5trWB9j+Jb0LvYLBsM4asDulM+w8KieY/vo9YSKRcBXC3PlskwYnGZr60H?=
 =?us-ascii?Q?f3+07YRtA8m8xiKCQjwUIf6pebmApKvQ5jmgs8upJjfilHdMCZxfoi7hMxzK?=
 =?us-ascii?Q?AuW4yT6YLW497sjNgJi0aW8e+yetViaRXiQvlB6vBGBdkVzVCHjX0Bm5X3QN?=
 =?us-ascii?Q?dZOUVMzmqSCED/lhn+1p9b5pozJ/yNqkgJboDSHaiqS75pUlEiDo4qyoRXa3?=
 =?us-ascii?Q?o3qShyd/Blgb9okDxUks+O4cx/tSk5XQQ0FoCMMw223twFt2FJG6FAHfct+V?=
 =?us-ascii?Q?D7ujQWDsOWtxHC2KR6bEMB188pKH4+nqzUUAaQv6Iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4HRWFkxW3aTzC+tNbSTk4e9H3i56tzIyuK79mKIqHUkzWANMBBA/jb77yAn?=
 =?us-ascii?Q?G+OoPvK0SiZWxUMopzBTSh+R+AwmL8UeVo6vl7ATDuBzxuQZgeAG5Fe2EOS/?=
 =?us-ascii?Q?6J0QT293RYEXb9m/Axz8o2KyZa6y/Nh3F4lCaXbF1r7GJzeKetpOatn7jisj?=
 =?us-ascii?Q?5T3qfa7cF9OWsUOcxs7XsaATYe4eclpZmb4tIpPnfNelTy9MM7YLQUQEjP0C?=
 =?us-ascii?Q?7hbS5A6IqlmTieLfKd0Fj9u6DjaQN4v+kmspaEvHcwrZcjldbms6mE9AVGIR?=
 =?us-ascii?Q?+iet5D4VNT7xj4O7uDOC0MAHp7tibSkcAd9iJMKNzJuERQUtCEr8FbZhjn3f?=
 =?us-ascii?Q?LWzEpqwgaAYl6wO5Ro2mYxCWwCuAmAZq5zv7Bgi2vXZ030beEZ95cCRsNbzW?=
 =?us-ascii?Q?6BKN3KuCUL9j04l2lD67BBMqpzs3BmWKuMe+MzpMsN9yi32GwabIx0aZkh+8?=
 =?us-ascii?Q?WaZL8lobkAhmSUb6grl0UFabBAdiFYmEwEHh5peURFYOtXFpys5KGfyvTnor?=
 =?us-ascii?Q?JPLRHzqXxFADJoR0TA3u/JjrLzYNAJJWDFbec2sgjVHOXs8CHFujJVJtfEFV?=
 =?us-ascii?Q?51nYhTjP+nffQf2RNTs+asjzMFXk9jo8CNjfZS1W4CgsdmtAnIZ8nNJlg00m?=
 =?us-ascii?Q?aszwglaUBakfrh1ZpNMrxLgiydiMLkK0n6vEa/oQZ0rhU13vnrD+jvRBYYqF?=
 =?us-ascii?Q?HpnorfnkPBYD0X2eWBeQES+i9KKEEnXng4SieJS7/CA8Twer0i3KLJEES96k?=
 =?us-ascii?Q?JUPqOkCAMfnwp205nHxJL9oJYoP9j1A2FRYRRvrwm8FxCTT0dPpNSgQ+Pjzy?=
 =?us-ascii?Q?3dQu10ZJUG074IH0IG3KLyCDtpNl4FU3V2P/pGhM2auCOTSww0tEop+hUluR?=
 =?us-ascii?Q?CFWUXxqCGZXJFflFB0nhwQNzXhXzlB61CEe8987t2rcRJZViBBUBeD0lauag?=
 =?us-ascii?Q?JQaqsGgMF9YiqHQjpyl+zaGmzcBI1XB6q5ftKRc6i//kJmq9RhVwSkrZLnkB?=
 =?us-ascii?Q?5ejcCmlJ8DeLDRRmHeN+IExkab+LOKjfBmC9SzFIAFNsAWe7W8YOyO75jReG?=
 =?us-ascii?Q?Rti5KPxcoioiCYbBe8tgB/WLVXzySjbqk2o9w/hXW9hsdflrpDGHVbbVRslM?=
 =?us-ascii?Q?tnOAm6EQccywYH2XgmCCWKn7Z7NManFpavZWf27JcqeQ1URM69xUu9SY/g6h?=
 =?us-ascii?Q?1tCRncyp9V4DXZE58LVmgl0hnE19BcHOIoINRAnqBxl292iRx4BjNV0vrd4O?=
 =?us-ascii?Q?OQExOrwtat22jHf1zqDMav69bvHwtt2iBq0TztlAplqAZqGqqsv/5OSzCDKx?=
 =?us-ascii?Q?HQWY3MOpwPl7hpePuaLkqkxExNQm3wdv53/DrrIXn0rHTuQLvS/chKfbHySh?=
 =?us-ascii?Q?EeQldeBmextLdHdoZXceLbmiPdqQkfXEYYB+M+Du5PiNu3HfhaScjl88cicu?=
 =?us-ascii?Q?nzhtPyFrlukV34f1mKAFMYF/XpmlyWRX5vIraJZOYRqqhE5U3YT/v6/k1r+t?=
 =?us-ascii?Q?RqOQG8dT4Qhlc1hWgwDUm4IrJ1kYILvX72XYqBQmweDgZklVTV0+WOhUYg03?=
 =?us-ascii?Q?luBmY5VYgU8kxYB0vuc4ZQJN59GG/JoPNRGQcvlA8h+S5duV5G2bS/q8BzSp?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407aa28b-e850-4667-d387-08dce3bde750
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:13:14.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzMY2Y4Zem8H/izl0VNViclkeeODFgPHajC/xQAILHJMTw28k86W4zyKlW6EZcL04lEJKoFwcCpoe8BLb8pUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9589

On Wed, Oct 02, 2024 at 02:51:53PM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Geert Uytterhoeven described packing() as "really bad API" because of
> not being able to enforce const correctness. The same function is used
> both when "pbuf" is input and "uval" is output, as in the other way
> around.
> 
> Create 2 wrapper functions where const correctness can be ensured.
> Do ugly type casts inside, to be able to reuse packing() as currently
> implemented - which will _not_ modify the input argument.
> 
> Also, take the opportunity to change the type of startbit and endbit to
> size_t - an unsigned type - in these new function prototypes. When int,
> an extra check for negative values is necessary. Hopefully, when
> packing() goes away completely, that check can be dropped.
> 
> My concern is that code which does rely on the conditional directionality
> of packing() is harder to refactor without blowing up in size. So it may
> take a while to completely eliminate packing(). But let's make alternatives
> available for those who do not need that.
> 
> Link: https://lore.kernel.org/netdev/20210223112003.2223332-1-geert+renesas@glider.be/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

