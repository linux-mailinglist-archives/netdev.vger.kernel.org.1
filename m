Return-Path: <netdev+bounces-149323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84D9E51FD
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018F22840E7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677919007E;
	Thu,  5 Dec 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oaj/f0mn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197C78C6D
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394029; cv=fail; b=gTAQnAbNYpj8L2V2flP68gnV2ChyY3Sx3VmTmW7EmISYqvLVdFz5zq33pnZF0P+XwUsVnUPmxsHLXHY8M04E1ZEqdHuG9GB1SPMQoMR2krQvc1eARVHJ1bPziieU6a5hK4YD3ByEyJglftZrwAi04oao+vLfQbd0QlMusPi5jZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394029; c=relaxed/simple;
	bh=JBpJQtm/B+VTV+mY456XwiWK06xevYs1S4eR6OEyy8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NckQRXPrxjPQJ8lIQPXhLep1RgM4UTEt21guzd5cnan2IRbrUGAM6xyCBlplY2MNqIxWZb6+NBguTLeYgP+0arlVp7eH2Vf6Z+C8RvYwa/WfvAzf6nHMgIa34NbnZDVE7tM8Lf9QSnl1AkW6xwePCUMNK0l4ozx8U+IneGrjAQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oaj/f0mn; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx9geRkcL9P9v16MaklwyaF6yWjCElZ60/6lUrMjSUWG6bD6GgQGFBSXKq4z57c71WBwAHOyfFcN57Hg0IqtzruJCYqksv0msrcfEPoGfKuNkRkxZ9G5riOEXXapn3pZpCPmzz/qKqTqT47xy0iFHjediRRA4sDVn41EmhK7suoayTihmVi2t9MHwYeT8tCA/KNuojKHUza3FqiUChz4/xVkUOTIqPsjxdhw9TrS9YYDLwGgiMrnhPrd602BQg3m0rilgxsNZgBXk0MFmxrAQtGEJAaiEnZi+sJgYyELZj4W1+sGM5XjQiWIra+lSee4KSeHY67S4yeW2FrKJF2h4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifQVUpNZ7MRLoZnwNLwzfsMcHg8dN1+L353oFWgq4Xg=;
 b=cg2AAKL+1FAshjSvt45M6su+cQW8OqAG5fde/b/9Gut6CxrY0KoWWQF50e1M1QJHpL6MWd6pLMcQQ3zXRwry/BUGxAVQhko8oTLwQtA9kXvg7v01Wa/2KFcOEC1/7vs0CSVcK4XrtaTrxp83vvRoQsW9zsB3eyZzDIdKqeZtQjj/qAiKwxD+MPGUsQk5y/P5d4xl8v4ke/nzn+QwMPtg/DsLEfJJS1zQ6+ps93TDFeX4Vn1+HmALN+lZTcQTHNY8kUt5oOtQJvFAzMCEnxGfh6oP2nT4gACG/AxZv92OJYUlzBwRr81H/JdvMgJl+z89LLTU90tOB2Gg/UA0dFTUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifQVUpNZ7MRLoZnwNLwzfsMcHg8dN1+L353oFWgq4Xg=;
 b=Oaj/f0mnYR7+0jYq96PFtfCBI6YyM2n9Ml2EeV+HyaxLsC/iQK/mX/gRav6lOAKRSYRe3VmjAt15mjs7cY5twGX92mBDKJKcPH26NkulMArKTwbDEH/4ysju3f8uWaZYKwCDDNzUFDLmaztIXndu8uoVxWz+RXbl3+k4+25Te6VTK/7xVlDexMnC8kXcbx4bL7vKXftFezSxwVcYvKRxZCSx2z4st1enTtwBEbfv8Q4demacIRBVWlfyzDxVHUhawaC8zcUO7J4WNmAfMKeif/Wm6km9HGFpg8wT8/S1AaRblDPoggC5Hw8KyVsKxjcmZAB9Xd/eKZeHNRSGvgMi2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 10:20:23 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:20:23 +0000
Date: Thu, 5 Dec 2024 12:20:19 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9 00/10] lib: packing: introduce and use
 (un)pack_fields
Message-ID: <20241205102019.lzntcfpsvzop4ncc@skbuf>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
X-ClientProxiedBy: VI1PR07CA0240.eurprd07.prod.outlook.com
 (2603:10a6:802:58::43) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6041e84b-23ff-40fa-1767-08dd15166d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+iIf7kr5VvyY5CCP8xKT6MBHfxV8ZWnB5cHOhwbhvatA0zLC/Fg5TzT9lET?=
 =?us-ascii?Q?a4WbJHZ+fnHb3s7x2B/b21SV/qEz3LBwiQJ5Y9Qb75fy6liNsYo3UkERxf2T?=
 =?us-ascii?Q?hPMV8eyg7go2CjQGuU4sP4rliOtPY7Wwbq5Gv52xBq1eIL9m9Euvp8t0Epbl?=
 =?us-ascii?Q?us2T5Ogd5e0Sge7JDI2J4lFQagK2WW/XqY+YOn9OiRX3LudL+m6gHHP8HUtE?=
 =?us-ascii?Q?bFQPUP2jHmoKABGAwh9tIikZV9u/MkKMZDPzRnud2w3JWIr3xGAHkagY1Edy?=
 =?us-ascii?Q?a/inxOC5Z9fXCK+XjCwEizGhikfjo8FHUkhhVNdJnSo9OZWTvbHIZqH8j084?=
 =?us-ascii?Q?H/Lav/cvW4lDTnuaYDYdQSBJ7mHPbbwZrW43tLsFVcY1fUQdkjJz9W+Bm6VU?=
 =?us-ascii?Q?LewDRDDs3zu51dAmpfI5jCpMr5i5YwOy3rH6ldg2ldixxiqxMf+zDiQP4a/o?=
 =?us-ascii?Q?zZHIMFWfpoh6AsPP4ywYDjlttSuoG4tlrNVxdoIvBHTOCu0uNv4hIKK9y4YT?=
 =?us-ascii?Q?CaFsr+rlbz16B2DyGveUN5KnQSXcVX6TrmNtk8oHaeNgGGLdJU+Xvsm72ksw?=
 =?us-ascii?Q?gBjABRcrMrqPziOVF/dcnsrZhrp5Of6A701TVEI7S85V7IYUFZfy7fq6NICS?=
 =?us-ascii?Q?Yc7K4Y+q92slZSQAKFFQrPu5qgYB5+vv7dIl7hWXsi1PWJjrtN5fxwSofLUJ?=
 =?us-ascii?Q?zCNMYvdjXzQwPPh4VaRVqZIz+dMqtCGHEZhtRmmLuqUhIB2tWu0Y6/Osqpet?=
 =?us-ascii?Q?sJD0bpXfx1CPPMCsPxPN9PYmUKfXk4Tlyf9p3EEKylsRwOrwyLmG69DoA4Jo?=
 =?us-ascii?Q?NQORNv5ExNmf7Ac7eR/L87r+gz4qmWbU0TEhUGa6HOr2cXmY1tA3fsgcT4ZG?=
 =?us-ascii?Q?qfrJVI1JlSXNJOC3KS291TD1OPXSVdfNOjJLkYUXx/dwP/9K9CRvIKPFQEho?=
 =?us-ascii?Q?J1caWGqgWC+qL02KZW+310esnHalH6sdYaqjb9/2h1ZuSRA6kuDMWVgnFp4g?=
 =?us-ascii?Q?LTpRujkacboDwfEQIdpKwgw0AS5uii9BQcITjCtyGBJZPX9C0GRf6GDddIuZ?=
 =?us-ascii?Q?gn+yxwC78gylw/WXn/l0e0oDhojkHFuXddWt3Y1WUJXKuhU1h8aZLPgYH7/L?=
 =?us-ascii?Q?YyuB7ycFtV1qf4GcwSwHYnvlWR2JqIElKRD72YJPipHdW7w+qiw96y7J+e8P?=
 =?us-ascii?Q?2+XhokXH48MFOsFiPXnoL9b2OplRUDkV8BJBXIc2M5/cb0NwfUJHyq8e9PkQ?=
 =?us-ascii?Q?zHSQNXJf7kG0YPbwNrVgTLGkszEs02jS0mSElCkZaPUPI8BhiOpARwYM2JG3?=
 =?us-ascii?Q?puE1mgf9eiSfhwvS3aTopy2C8sPXZ6/tIUHRnJPAwgr4OQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjTi/rCd4Z4BYhSrwCuSFrhdQt6XBKg0zWvst5CJzAPziBWmFTFjGeEEZ0rK?=
 =?us-ascii?Q?GihFbmrmLIVY3tt7WaE2466bKHbpZcWnWBUVNX1AFp+pcMYohKYJW1Kt6gZe?=
 =?us-ascii?Q?szCrvHivE3UqVZX+hU3DLqxN3ILSeYJgGcPS82MGGD2sZ+YjNphbLaMekBvd?=
 =?us-ascii?Q?w/TsLLkGBPNKF9BKqzb8Cca9H9M/wONnYT4FsfLuXGVi1SXXVqm3Ho3mfutz?=
 =?us-ascii?Q?TSOaLjiPG5KpbbsR/ijMGDTMjg0CyVRvExQ44cNEtyfm1tq1/R3qNpsHXFZE?=
 =?us-ascii?Q?Zsy0SRnyYKs0Hu/ynL3Pm/QRJ0a2iFWf33ReC3zQ4FFOuLjpmzCAXxx2Prst?=
 =?us-ascii?Q?1gNvtwQqAzDn8jYYGOS8Zl5lpt0wnOw0F+ln1QT/UV/zTVHQiBdSpbY9SkLS?=
 =?us-ascii?Q?M/dCFzC1LI3qGIsYzjbwDbnbVQZPYhB/Y2VL1lCAYzozZWYE1qM3YX7N5mGt?=
 =?us-ascii?Q?zdpDuH4p1ZaZPtKJbFfxik1PxYqOpBg8HS5R9kF6n8c3Cj8F8Br1eNiWZdgz?=
 =?us-ascii?Q?NwoYi7mHB9tyqOqoFoEYygoIWc9kK+e/k1CzgRMLcbmp9im5F7eEHdFKrWFb?=
 =?us-ascii?Q?qtP34gAbePoWbmXs1EN1/7gLdULcQbquogHUx4IjREftqBcgpdpbqTampT8N?=
 =?us-ascii?Q?YlMmNHVyNlGERqAinDGkl3/OoInu1686/jg+RjnOHSQnnXBKT67R3tKbAe9H?=
 =?us-ascii?Q?9LdxLSKqLt8oOf5C2Ek2t7jGQjXLqRTBOvggIYJ1vlPd2KiGPH+/VjAcds3x?=
 =?us-ascii?Q?E2pMM9auLLQiqhHEhPHnbse35zUh4Av3woleOfHL9gITRNWer3ZmLkmmB4kg?=
 =?us-ascii?Q?1TEYlKNdhd687RPJRnjAA37aw50hizEYYXlt23gE7jUrQ1PMyBUUSVtvhMCD?=
 =?us-ascii?Q?XZ2l7vYEn1NciZF0+xHzXDAmlj/t+t9iFGFibRe3065PXZx3k1QlPgJCSZJs?=
 =?us-ascii?Q?RdPeOgzi3AtfH9ozsKGqGWoRMx4NehcVxRKIlSGFRcGlrBNKMiQxFQlupGZz?=
 =?us-ascii?Q?whowR26U6f8AI7TqLT6a0yk2WenX/eukJ8PBxnRv3zKWaKQHlrn/p/6TmUUQ?=
 =?us-ascii?Q?lPbCz8jc3r0OspamOndjwAOysVron6lfO9sGV+rhqAS2/v9tReVzfJpge5UB?=
 =?us-ascii?Q?CTc8LjZWAvmlxV9V0t2ymEn2Hb9NVZXLFsC1gy180FGHOe0X4bAFQMFNeaKb?=
 =?us-ascii?Q?c2wDNdmBIH+DRLQTdkxHEUwbViQQwOA2of0XIXvtQdBaZZ4IndX9CSwVk17g?=
 =?us-ascii?Q?TD9DwFxC7Xd8brTM1qRNYEDNSoDnSpawAQLoZ8fqZ/zT2sSfGnKh+3pRhVGa?=
 =?us-ascii?Q?muc2I6YE/F7IqXg45QvKtQyGy54yMmWUANCEPHldL4JUTWsxYBCCqPFjFdIP?=
 =?us-ascii?Q?O2912nkxY4DpEamLuS3jK4ErKjQ6QdvP3XAxZw/I+t2n/oI78KrXhqh6xbyq?=
 =?us-ascii?Q?7Hu3+dsIdxtsxchlirp1ZpoCX7rPkPX6BXC5HUxi3rsHxJC6BkavM8Lgh97Y?=
 =?us-ascii?Q?Jph7QelTeLV0E/4o3R8+pOJYw3uqInYfEJPK7jbB+iVaOaHlbxKcV/4zF4I/?=
 =?us-ascii?Q?PlcXvwneBVNX4fyC5nflW+Wz5/AzyUlbRbj2ybJx184iwJY8eVRd5KXjGk+a?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6041e84b-23ff-40fa-1767-08dd15166d95
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:20:23.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heUqkutxeUIufRQ/IQPys5Qe1Q9m5J75F7carmSUmyjhxTJUm5D1cmm4yfwE7mSLChlVJKNrsqd2up64/MC0gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

On Wed, Dec 04, 2024 at 05:22:46PM -0800, Jacob Keller wrote:
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

For the set:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thank you!

