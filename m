Return-Path: <netdev+bounces-151206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F400E9ED72C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C43283690
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10D42288D2;
	Wed, 11 Dec 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BiHceka3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527120A5F2
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948475; cv=fail; b=PX/FmAJat2bohA5Vvz++MQQPZyPerWPPjG7O760fGusn5vEEWBHfhOxe/XOdPxyLivbuBglphZqvxrMk3kiyrORo9P5nZBfyObv1FBPiqfpm5S6QtZR08dIfBQdR+6l+S9Wb0fIgYBnhQr0EpSeGYckmVtqmVuqrAr7JxRQIgag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948475; c=relaxed/simple;
	bh=429m0YuEWElN6xO8adBG5mRjM/pTLhmTKu6F/IHqjbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ClnNf856p/wlFEWZTYKzFUiFe/ylag7KUlhTq9m+TLgMdxL6jMzfi5ke2PgeR0xA/nYbfzfVSWB3bqdqJ0mIjX/Bz3e5E4h7iMSfX3DR/gqf9HN/IgOscbeiorfRxaHdUS60MccoTrff7lEoMzhK6TpKE3lN174B+t3K90zgr/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BiHceka3; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rT8v3PfWmvXTZOVYDdN3X5R4qlKX+VB4BQrhReSDbRb20nP+u9+aCfhqm18qpmaq6IAXHy5FtNIhhCTSSVZs5xm0VyWCClFzCJsdgrNJT/pq7CqTGkEQ7mUN7yy/WbVEWi/usGWOwfrVuoYzvFKwcyoFfGpp0BlmacSOPHirQ8FN/y07yNU1FifXYubc7SqIvgWgAr2oeB62Iubw1VCQ46KQ4ySVD3jspbQDqNaWgkc8PvYqgO7zcbjMoQ3BTGdOOS7vtg/93SPZDTXI+4oU3a+Uy+Cqhjo5RZUa7Xs6/tJmc4KJxh7LodQi25r2ulntfnIIXSXqRKl41ou/jBeQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOoc24piTLhvQPBLFj63p+yv4PpXQoVViJOSsL12k24=;
 b=vq1imRKous1ABbbuAfWTaIvtJG3CSuM5J6Qv3Lq8QWwSXPqE5GTkAKTkf1eKfH5TRk1AYg8LdK0gUBE0qB4zLJjSVQObJEAu6IqWU+/yNvWv1bsK7CieXjf4/QbPlaDD3lJg8FwJ6KsJ4CpCuQHMZ5viQZ5uzy4wC9ZJwhwSOPoPDpHPlNEQrP2IEIYvy4OKts+3Yd40QEjukE07HZkt4Fw6ccgLjUWzFJSNJRLSq0Bvnni73pLiJDFWrteu/Lb+9gHBFAB/qwOA1lJkJ+dFcSoPyGyUag2JFQlpzj+imaS1ZGlNjhdmoXqPn9LiWQLq9s3xwau4aWbzHyTees+ZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOoc24piTLhvQPBLFj63p+yv4PpXQoVViJOSsL12k24=;
 b=BiHceka3e3OPSUDJ0fpto6pKnYeGev//jFtm2nhTDj1hMclnXqY5mcDT7utxP+tXhNRvR2CTbAJn9hwGCPogfRxKtbCKWxwgMPuSXbUoqtQc6Po+1jOWx9U8bC0Ci/x8Ii6hoRMTWQKOnTvhDhgZgn2hwDwLq0KFrFZ/OaLVz5efXUU0stXh5PlidY+SJO+aPTBWn5FqmgFUvUT5HYGwLRTrQzA449jgYoLE0mGSzfDnoeI71XuGMYcnEcl4Yjs49YVmwb+0zCXrON5iDVK0sQ9STBHGyyBzqXhAUTovpwaXEtR8HmaRXKTk9zBZ3Oma/u12Qw4itmbrjUAEZq+Rnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB6774.eurprd04.prod.outlook.com (2603:10a6:20b:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 20:21:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 20:21:09 +0000
Date: Wed, 11 Dec 2024 22:21:06 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v10 00/10] lib: packing: introduce and use
 (un)pack_fields
Message-ID: <20241211202106.ic2nlfj7ep3j4f3s@skbuf>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: b42686c9-b023-499a-79cd-08dd1a215968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Ku3Dd4vfOPuilFcg9rzICOBEnRQWUJitVfXT5VSwmzJchkslrqViQ2Keavq?=
 =?us-ascii?Q?XrKVxd9Aap2/Qtg26pR51LG4isa/AxjibSG5VC3gGXBosuMMTS7+1ZJCFtMd?=
 =?us-ascii?Q?xL1SodU9KQvyrmU7PtweO24KV1FcJzn0ypfOZqFWiaZwlNBbpDdfEwL6nGlh?=
 =?us-ascii?Q?iZg122g6u+66HmzsEKz+Q9bMrot7QQ2P6KoJcDvda+l5Gk15xysMCnhSOYh3?=
 =?us-ascii?Q?+6vs3+MDyHbpNZu5zC94LUygT0hFTNQv+lJX21Dugy5Zn+eVW4WenmP0upm1?=
 =?us-ascii?Q?tT/q1lgAYYss26kRUbqsvK3jmqhISmnfpl2I6UYqZMrjdGdrJbm5XRQMy3Iu?=
 =?us-ascii?Q?fl9Fib9OmJAbvy5r0oyLNqSCzh292QztNDDC+L17XZtYUs02PNxzGhDaIjf3?=
 =?us-ascii?Q?H0WDEQvXPtFWxySSDBN/7LuIojAU0jj/kikGq9d53OK2P2IE5Zu8FdB8M56x?=
 =?us-ascii?Q?H3yoEW1wQcM/9DcNCURA7m8Y9nZgLCqK66tYQpL4fJzZDK2AsVtWFxZEuwG7?=
 =?us-ascii?Q?scbbuTzWEhSO2ZE7xCNrhcmAUdy9Im8NMUNSpPNaMzyiwrqRV1ykow+EeWOz?=
 =?us-ascii?Q?bTJ0V5gvyDTXCz5Pc+vg4D0j968q0+6sK5UyrqFyj3jyGN/R6a+spSGBCGHz?=
 =?us-ascii?Q?YXQ93Kj4B/Gfv3Hg+p5JgYn8Jmu+sLLDu5qi5FowVOPVniz1rSTnBYMWQ9dU?=
 =?us-ascii?Q?nXg4LZPCojnQT3QntOUA2QzhmXRaW8D6UF4Fjzn/mQn1HZN9VdOAfCxxuAoQ?=
 =?us-ascii?Q?Rksuwmmyby7MAgbI6wxkg7a0p8uzS0QCgLBNbLq5PhtZSdaGnwhuM0d5mr3s?=
 =?us-ascii?Q?7uRy52B/pVVPqPKx2mTJaHhqiYMmH8i0USeCWeyl0HArKg/GXlBnTegIFiTI?=
 =?us-ascii?Q?1Sh21aEVWcRszTDYAWLmGja/KEyr9Q+Odi0xJ0zQVu/mJiBkjRGslDglbEj3?=
 =?us-ascii?Q?A0Cfr+C1Tc6D81no50eyY0OsMsDmfiL5Zlnk6L1rET/vqepDCu2eUCu/obf0?=
 =?us-ascii?Q?YiraS36UYu366fz2e0iXtIfccfuNyqZacK12MXiqxqI9Voqbzk06W7Qyar7A?=
 =?us-ascii?Q?mvMd/aNnvHJ3LVWzjJ0p9lJOHciNn0WPPQVxkqHmY2/Y85LZ/rdJPOeBUDZA?=
 =?us-ascii?Q?u2iEhsSYECaf5bv2F4cqp3bLUGZHZ5Tiyfu5jG5Oh50GwrETqit2jPylecXn?=
 =?us-ascii?Q?I4hfMZUDUdLDS17uXd+X6Pu1sfmnnZsi0+VffODWVR4xhMCRB7xfuDikNyTR?=
 =?us-ascii?Q?/QkErrUchJSY0s1YCLNXeunDtdag+l7mb0CYkt/ZybNoyM2SkzhkL85xNKsU?=
 =?us-ascii?Q?wX7X+1J8gA8zL5hNwXKx6v3JWLNbjZP54PQRlDy29KcxPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IC2ayKV90sJq5pgr3CHVFDeadZ+uPOt839jaj2YqrJgEJyCcRc8wK18+RGSk?=
 =?us-ascii?Q?bbTObQNg2Z2DQbUutF3S+rvyNDOW64pSlFnCKJTbpRZpeDcmQc8B+j4VNVuX?=
 =?us-ascii?Q?bPk7xMDW21lmTNfwH/Apcndofi0vVxs4YgE9MTDqmfo3NTNKdEbNiJu6hZhC?=
 =?us-ascii?Q?YZPL6PtHXcOIeCEYzT+n/4dEMmabFsmjl2/Ho0SfpfQOUxONg6dhk3clmWkr?=
 =?us-ascii?Q?gjmLBMzH5Lh1lNtoGnzvByUVDKIepuUqVJA12saP4eZh9kSUJP45VTY9+I0P?=
 =?us-ascii?Q?hHuf5v/a9QzLXFUo5chUV3PCg0tSUA0zUcjtjROSJX5VZcGY5a9ogSS+m/b7?=
 =?us-ascii?Q?iBvokAUd7/PrmRkGQCi6F5NIxa0V9MLRnfpjLxAkp6++tbWdW+qt7lUXi5Hw?=
 =?us-ascii?Q?pLMuH/y8LznQhvnxdwwl9eDe2UVR9RbxS17SrHXJfGjivguc+A4GeQx1VYCL?=
 =?us-ascii?Q?zfZ9OIJDGp+u6gzhenFjnAwbOM81v8iX3EOIATFy+eNY94finbIdJXBWobX9?=
 =?us-ascii?Q?g1ZLfwidIZNUjPoX0H7pyemdmh0r1Hgjftwhd4S83pIzC+hVy16RIfkz2cvw?=
 =?us-ascii?Q?BgoYZi75re94YBXW0LWIKKo9GVw9pzkteaW+0GobZjop6RhHEydzaUsZ7FzE?=
 =?us-ascii?Q?uMZoppLMC0ReeKajSxAfDHLHRfvX1OYqk0Df2sFpXkAmqFTFuBBiwK2/d6iY?=
 =?us-ascii?Q?Jq3g6HUrhDdyn91A8qP4DGIw4xsKFURCGeM4mPYPeRRdXVMR3a7vB2HGL69h?=
 =?us-ascii?Q?BlIYpgoOSuqr/RR7p4MWDvLMOwE5LmOn7laczQyi9HQMTHmFAlNqQOoDAIwN?=
 =?us-ascii?Q?OrPDpchQp67A5Vn7GUhGbcXppmPNGkepYU/ynuSXIBtxdbuP+9l4xmj8v6ss?=
 =?us-ascii?Q?CbgbIEDEX9eEQ76sUTdh12GANgdUWKlYaTbItWOA0PdenN9u5XVPnaJycoH8?=
 =?us-ascii?Q?LXpOFwIurR/PmktNKmpj+tTCwl7H1Ekf3d8mjUUoFZ4NGrW6LSdAKBL16Y8o?=
 =?us-ascii?Q?Jzd2udmnuHHINKksKBLIUw8vW9Bexf7VRWB3iATzZxc3I0J99BS40JzzXbJz?=
 =?us-ascii?Q?FBrG1OJaWr1/cc/JQddCNTl6q6WUxibAkWEPctDOf3hoqGimGpE2NtNhJr2Z?=
 =?us-ascii?Q?F1y/d2L+PJ90CB8aUxtKZmHcjadTMvvMAza7iFq6V4gtat/401G4njri/JoE?=
 =?us-ascii?Q?U9tdmB2nEj/bJhjutWp2mPBFw8Zlo0pkEhfhNFOoHZHU5DItBSCE+LBhHF+f?=
 =?us-ascii?Q?WfaldwWZMpu7GQITTimBXqoE3+nNlb4RIVLj/0fYFNAsBNNCwaP8IkiK9s6q?=
 =?us-ascii?Q?tVIn+m/EDL/6NqcgAvW+oGyl57HJ6Mp0KY5iukF/QfQPKbWzYCcLh4k730dY?=
 =?us-ascii?Q?uvTx55DHCL2rg9BZSZ+ZPHeH6tpbemhvUe+J8hVVQ6snpuZ0Gk7t7cUnGDWx?=
 =?us-ascii?Q?CJ1wHOP8fGxy0mSFVKFDXpXY5BMY0RnE6+j94ohGFodBS9APSTkKiYk+grg7?=
 =?us-ascii?Q?B7VjwXx9W/Cf48Q5I+bCqi5U5Ua7JkI3s4ToXddN3s/MASdqIgbnrPxBiyuv?=
 =?us-ascii?Q?zuI+uND8hUZWRVN9kORRIceIvTVgvbnJRUpq+0jmj7+22qdZLu3WljzZucGq?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42686c9-b023-499a-79cd-08dd1a215968
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:21:09.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keXs3DtLBRLTE8BipLJHgu8Bk6I96MRZMVl93FIMAOzxvFtZM5LtNsDNSRvwOxelO3BqdDGG1/tKAyxhVyyCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6774

On Tue, Dec 10, 2024 at 12:27:09PM -0800, Jacob Keller wrote:
> This series improves the packing library with a new API for packing or
> unpacking a large number of fields at once with minimal code footprint. The
> API is then used to replace bespoke packing logic in the ice driver,
> preparing it to handle unpacking in the future. Finally, the ice driver has
> a few other cleanups related to the packing logic.
> 
> The pack_fields and unpack_fields functions have the following improvements
> over the existing pack() and unpack() API:
> 
>  1. Packing or unpacking a large number of fields takes significantly less
>     code. This significantly reduces the .text size for an increase in the
>     .data size which is much smaller.
> 
>  2. The unpacked data can be stored in sizes smaller than u64 variables.
>     This reduces the storage requirement both for runtime data structures,
>     and for the rodata defining the fields. This scales with the number of
>     fields used.
> 
>  3. Most of the error checking is done at compile time, rather than
>     runtime, via CHECK_PACKED_FIELD macros.
> 
> The actual packing and unpacking code still uses the u64 size
> variables. However, these are converted to the appropriate field sizes when
> storing or reading the data from the buffer.
> 
> This version now uses significantly improved macro checks, thanks to the
> work of Vladimir. We now only need 300 lines of macro for the generated
> checks. In addition, each new check only requires 4 lines of code for its
> macro implementation and 1 extra line in the CHECK_PACKED_FIELDS macro.
> This is significantly better than previous versions which required ~2700
> lines.
> 
> The CHECK_PACKED_FIELDS macro uses __builtin_choose_expr to select the
> appropriately sized CHECK_PACKED_FIELDS_N macro. This enables directly
> adding CHECK_PACKED_FIELDS calls into the pack_fields and unpack_fields
> macros. Drivers no longer need to call the CHECK_PACKED_FIELDS_N macros
> directly, and we do not need to modify Kbuild or introduce multiple CONFIG
> options.
> 
> The code for the CHECK_PACKED_FIELDS_(0..50) and CHECK_PACKED_FIELDS itself
> can be generated from the C program in scripts/gen_packed_field_checks.c.
> This little C program may be used in the future to update the checks to
> more sizes if a driver with more than 50 fields appears in the future.
> The total amount of required code is now much smaller, and we don't
> anticipate needing to increase the size very often. Thus, it makes sense to
> simply commit the result directly instead of attempting to modify Kbuild to
> automatically generate it.
> 
> This version uses the 5-argument format of pack_fields and unpack_fields,
> with the size of the packed buffer passed as one of the arguments. We do
> enforce that the compiler can tell its a constant using
> __builtin_constant_p(), ensuring that the size checks are handled at
> compile time. We could reduce these to 4 arguments and require that the
> passed in pbuf be of a type which has the appropriate size. I opted against
> that because it makes the API less flexible and a bit less natural to use
> in existing code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Any reason why you aren't carrying over my review and test tags from one
version to another?

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

