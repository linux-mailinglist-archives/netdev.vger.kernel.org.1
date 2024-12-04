Return-Path: <netdev+bounces-149163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC19E49DB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4171881BD8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2E207DF3;
	Wed,  4 Dec 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MMBdjD2M"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FA2B9B4
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355127; cv=fail; b=JTPbMLJ5rsOzIDOOFLvl9pL41UylD1Ju8fzr5IED+c2JUTDXL9SylFA/DPsRsBbmpK1GkvQJMxmKR9iWqp19+HYcwlCOtfULLNATjrP5yJ50MV4UTE66ltTiOAMpf3RZ3G1rxypa0c/eFV0YjpJjV4WaI9YXuzXTlf/fANdprfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355127; c=relaxed/simple;
	bh=YVzEj2k1AMVl1nk/CURsUdVtE4L7DabcoyonFapzuJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IsODYR92FZLyvDxrIFlB/w+M49P+XctDxV1n+GCROl9QpzKliv8T6ZkOjdH/FUT885JOKEf0fj6xv885Qz8xX8PsYg/QZj+9CDjTjea0Z2y4S/HxB/ACFOs1EgV6Sf20mCMZcFV/ZPKnrsUkkpSokeYpx2/8UHnM90QQwAhZkgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MMBdjD2M; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmBJjM7Ivk58ycki2RdhViC204za9WLmlIfBX9OZrNTsChPsXCR4yGvx23vPMAJweotT2x9N4GuN8AJuphWRPIQun5CNSqX+lETNNd92/53Gs7bCowCEygEsxHseDEvUBKDl/jmldl1GuRJYMPghLVkeHBXo6Jf65xdsr+NyzjPL1YwMrkVFW+71d7zUqWPu7gL634FP8YPLoIoKAhwWWs0cn5N/LQUa0VHmD+WsAxD6tEvV9ytzRGUdmgTJcLEZqrgiLvCE32yD3SgQRZKLOimZxYpJ2j9LZe6E9FDaAPrAQkfxKLfR+V09gBIU7H7PUCgVil1TnchqQQJnVz1Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCy8d3r8exWvTkVo9bu8IB99Jl3LPacxSTlSyGGtY9g=;
 b=PsBjdxyAypjQUau7aWvxV0Eyb+tWIFpLYkc6e/H3IY528sR6kzsIDFm3kSUhAW6YWVrenpHSl+sHnxMBsbedBxyWQJD2wSwMWw4odca6dEUxUbvMCuLOfErVzbXIlnrpLVwnw/Ra6p3bhWGr594vjDXVJslS0471AxNtX53E7oa7R7PR41LhK7K3l9pFVA8+1Oq4SFxJm1vrtJ605LLpMHHIcY2W9jJ1lqxgoEz4mE32KSGJe9aZWcaWoxXdph/M2xXYTxPOFmY6zuhn247VgTJHbCnIwPRVmnHtAVPTpqOZ7CLGFxg81KcYO0xyJ3NAuDtpTmfzYuXmojjS3D6kZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCy8d3r8exWvTkVo9bu8IB99Jl3LPacxSTlSyGGtY9g=;
 b=MMBdjD2MTpYNxRT69YOB+vn6aX/ChQIai+lEELR8xLFr62v9SdOQo7q+Y0zgjVeHiCYct01vY4BTHbk7JyauNPsyyGwi8avrP8dZ6IUryZuufUPAQnDQuS/wLAM4JpCvkpwJwzxYUxOsVhu9LS+kZK7Hl5JrcTJ3cNKFgXtpvsotrDH1FTb3pEa0loKVhjjMa66yhB4ESnd5Y+fK8r65vB83K0TnjxfhlfCgPI2M9XZJmhNL3pUnmZfPELdHcftPk/kFEt5c/pqYgbej2ylTtprOe8H9tiaYm1sa/ABW+apunrt8RDbiBAQ0S7cImKXdSyjgt+NyMyU9qrKMQsyTaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:32:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:32:01 +0000
Date: Thu, 5 Dec 2024 01:31:58 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v8 04/10] lib: packing: document recently added
 APIs
Message-ID: <20241204233158.yhdbio7dxqabo4sz@skbuf>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-4-2ed68edfe583@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-packing-pack-fields-and-ice-implementation-v8-4-2ed68edfe583@intel.com>
X-ClientProxiedBy: VI1PR07CA0261.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: aff3df2a-e5d4-4c36-f398-08dd14bbda94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sj/TT2lt7J8EKENsm//6w8ewGroDeiE7TknZR4sy9d4DrBEBvt3yZfCTjx9?=
 =?us-ascii?Q?PnhsslY3kr/QGjVKjX5SAyPcNOkBTpXiAz5kzYHXEQ0G4P9PvcRdApPjRvnf?=
 =?us-ascii?Q?2i8wanaR4OMPGuP5PENT4SBlbFe5t9NyOt1AfvbKB+xxTOEzKhr0YuLsKptx?=
 =?us-ascii?Q?vL4sFkngrNqghNzKqwYFF3Vncx67jDYTdMe07POjt3XDL1wzxGY2QJbzJwJW?=
 =?us-ascii?Q?0Uu75A9jk6N1ZXErf4efoFjp127eDFdV3p1vZbm1Bz3iEJQyJ3oxKWFk1Sx0?=
 =?us-ascii?Q?qNMIzsRlFgyCaeoMktFcLDi5YEq9EQ8Ejcv0kdnavLRrx+a8xuu89Ev6T0Fw?=
 =?us-ascii?Q?0h9VVHvhkjwM+DkLsYWs6nvaGRGghcHnvzbjfxDegb7Ke2YimEy4B3NZJQwj?=
 =?us-ascii?Q?Zv3kJpjwwZRbQ6oIYWJrCUWr0rbyUdKkCFOcNYTm6AF+tsAV+kdRAr5p7V0D?=
 =?us-ascii?Q?/Arh44BwqxIEYvcRC3B5B9JZeDh7ZzO+ZRdIUXf99+KTmXFxf/sj3c+lfJ4b?=
 =?us-ascii?Q?9cqIau64VHswmGHyfKufmoKV8MYgkwvy8NfFBOjKg+8nUg9outcAWDynniF0?=
 =?us-ascii?Q?/ovb0UaJCO0wfxClAnjhNhPkYHTplppzS8jDRuBFXn3tGI0bFOD6dMBf8Veq?=
 =?us-ascii?Q?co17Hn9SS93X88kD5dIGfu8agPz4UMgbuqZvIPChqBmRGA0hkNXrs1TpvKIF?=
 =?us-ascii?Q?gPvgJGzzeFo+xHepIKLygs+f8W/B4Y5MdLayTdf6oXE2hvPXVMFaVqJWNJov?=
 =?us-ascii?Q?gyGhptZT0WyLopkh2RzJrkwNcE6gRTHPJDdiqYq8SF2h8YX5ayED9FUXcx0Z?=
 =?us-ascii?Q?RkgCCo8bjdZeU9/qS4EqGpuDl9CrV6IsDxP7uqOC5Pj7sYD6dG8FZDBgbGU1?=
 =?us-ascii?Q?OGr/70bwBUgvmheLWgOD3vqPPigKApWB4b3YalfaJ0ftx+do7VS/ANQ39Jsh?=
 =?us-ascii?Q?uzLdjh+JhJ9AIgxawofYTR6bx5VjfQ04FCWty4yXgCkXat44oJTzT18INDdO?=
 =?us-ascii?Q?fWRtUWqoyyhFf1wa+Vi/n+NOb0cHiPJuc5BHBNf3S58KtxAzB78beY70n7P/?=
 =?us-ascii?Q?CjvlXBVU1t7YHIDQs2Z1MKthBCOG2QaaB04QtFzpFubd30YG4Gip+RwgQa4G?=
 =?us-ascii?Q?59DujoBSO+dmXOmOoinXcZuZ+fDUQwBCaEwX7oe/R9xA9vwuSwGcysqH5wiM?=
 =?us-ascii?Q?60+S3y96d6de5daPZ9hJKGU82K9fCN0sza7tJb4CD7mTlXtK6T2BK1m0jwFm?=
 =?us-ascii?Q?kSLLrgkHmZExnZCcHpLu+q6yl+QQShecln7/z0Ba7A1uQJAs7pyjid0qlVRs?=
 =?us-ascii?Q?sob+wGmhAkzjbaTe1j9K0W0FGgveoCuMF5z8x1YiYeZf7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iqbO7j1ffP2TpZwfRHUm5CWPhTvPpJqVTTDip1H/nckpXCBsj1YLYVZyxli?=
 =?us-ascii?Q?9a6r4YL/gkQPvMumhpOn2DzSOppbxBpjjqHn5o9xIIXEvj8GSKm5JwUl+NMY?=
 =?us-ascii?Q?ILPgwAwh5b8d2k6i0RP7TMVkjacLZi0nKI+6Rb5aajXXIDbzJz3tibDLAaRv?=
 =?us-ascii?Q?tQCKXt/FFfKuh/qZ6W0D3hs8U3AXiEsklw+laQXEtFe9TrnIbo7lDuZKvB4e?=
 =?us-ascii?Q?sVWprHNYurW5LB/kaWWWu2PbQH7wPOuYV3h3ykua0IaKHoo4hYcGnQkLXaGo?=
 =?us-ascii?Q?0N3i5FkExZ/RgiPBHZEG9G0iflKIl1uQvaartOx3mfeifJ2vih733wThNSYR?=
 =?us-ascii?Q?G6sCtskMATKBgZsieKx7FKlG+CsNWxXdCmJ5lKTDX0Y+kdtjPdOlIcobC+N7?=
 =?us-ascii?Q?RUOgEs+PSiz/6q+KU90+AjFlTjb3KZuv4Gxctk/9EX52vKy5j0KRikP0qCqK?=
 =?us-ascii?Q?ezDtLjNjp8KtsmnGVVfxAKowGR4EmZug9UQ14lDDLvzRvCB7ARWkyjehK2MO?=
 =?us-ascii?Q?fLJpqyIAFP7TP3VdM/c6YTrlYz3MLom7A4OjFPjja7so3D5fNtRKFsLioChB?=
 =?us-ascii?Q?1i68toZykJodYCuxhrqUvTaL+APBO3KL1hv3dWbcMf6o1aQ9GwhJKd3q4dRy?=
 =?us-ascii?Q?9Axgx0PK9jFAtSZNS3G7qWX0HnSAF23JmMyY+SwV3hUwYAGixgCDYIa4GZeR?=
 =?us-ascii?Q?jBR1vsK3w4t+gye56lYLP/HucrZ67GdBhYr8FRM6Qzm0NSUl9THgjAA/ihQh?=
 =?us-ascii?Q?vuORhMX34Ry+gkHjA3i2mpDjYaMFwe+DPPRhmQrh5s6oQEPPp7xUeV6kKGtL?=
 =?us-ascii?Q?ctLvDULtbnN3cUuxwoG0Q7zgkVNNR8hruxjBrnJslndSqBXDsOy5iSa58KvI?=
 =?us-ascii?Q?usqh4XwWM/fH6HqXZyR8RPUGCGTxOlWdlmSGlJnFy+9DpyWI4ElEb4m49Lqa?=
 =?us-ascii?Q?P1y/qbJQRZxvRwErU4kaE3MH2QwEOMBbagUOmSnTVnGgl771kpAN7AtmAVi7?=
 =?us-ascii?Q?6v8H/JC83OUpJfFQP36MH/PTsvO4VZz1l4EXRNoRxR8ohbKYuBqW8y2wQmwy?=
 =?us-ascii?Q?FNplkqdYcjSc1X2nNVBGY4OJKU9SZS+OpJ+mQfG0JNzDkWhHLkwwVA/tCeUD?=
 =?us-ascii?Q?dE5uHzfduyYhRIFtCGRjYLOfg5Yzh5iXRzJ/gU49jzO3q+DIZMAF2338+hwE?=
 =?us-ascii?Q?7qK8BVXvT+vtJtsm0i2YMpP736UYVP9IRqZamB5ZlUggE6Se512xDlHNqH9l?=
 =?us-ascii?Q?xgObfZm8HgKwNZz2HO9CDQ0bBgukpAA1WXzBjdWn+n4PM05bLTacWTMUmKo/?=
 =?us-ascii?Q?u6aSjp5tCujE/U8mI05c2uCLYYiu78kHPwaJ6aI3rLxXwHhIlvuryHBjQC9i?=
 =?us-ascii?Q?OKtz+LmmmtMMQwGE04e2bOzVql+D9F/X7gTxCk9bw/n0LUkySdUpXfYWP6Ot?=
 =?us-ascii?Q?Eq4QWmjKokUtVXRVZyy+rP5FYT1Xp43DQ7cy3uMbKyxT+TA5Q4nPvebQFGRd?=
 =?us-ascii?Q?F9ka0wH5BEcXkaoK78CO/SFXP9J+/dgN2pbh1qebgKOQmxJpzP0hbqTShnHi?=
 =?us-ascii?Q?GOE/vZojiZvXgwQhgQAt3rfdFGuq3IJ95welm0OZDziTK7QmEdhLKrI7ectl?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff3df2a-e5d4-4c36-f398-08dd14bbda94
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:32:01.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo6Yccj1AmZWUgUZxos6TjWrsE8w/anfmfFRHW9qcorSHuhCveTWGvLA6WtP1B3UkcJLlKt0ps3V1Ju8+7ETMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273

On Tue, Dec 03, 2024 at 03:53:50PM -0800, Jacob Keller wrote:
> Extend the documentation for the packing library, covering the intended use
> for the recently added APIs. This includes the pack() and unpack() macros,
> as well as the pack_fields() and unpack_fields() macros.
> 
> Add a note that the packing() API is now deprecated in favor of pack() and
> unpack().
> 
> For the pack_fields() and unpack_fields() APIs, explain the rationale for
> when a driver may want to select this API. Provide an example which shows
> how to define the fields and call the pack_fields() and unpack_fields()
> macros.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

I think this combination of Author: and Signed-off-by: makes it unclear
what my role for this patch is (normally you'd expect that the author
coincides with the first sign off). You could add a Co-developed-by:
before my sign off and it should be ok.

