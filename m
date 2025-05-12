Return-Path: <netdev+bounces-189870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD33AB441A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7F719E4E49
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C3296147;
	Mon, 12 May 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jERXJqbP"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5E258CC1
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076036; cv=fail; b=T33hjBw4OpZ5tqDPU87SjzTS3kasCXXsUxIV3Ibi2OS7iPw1R8nqrqlErxJRpkEeLLFm9PEo/AgefTZPcN1wHpNNMC9S9tPhD1ZP9m1NVYQtnhuCxryLRJxJKDH1THl1MtfOPypeWhlzdTB1MLRzux6jq3+f0N+eq+0+ti1W4j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076036; c=relaxed/simple;
	bh=BZIYxlx6Hy4M5/qx5//keoCEZ5Hrpz+RdlWGp8mQQYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j2h44PTBU/SdZjgHzrZcE61kCA+CXy354fkxW0nVycu5qVeseVd5J+BJW3i1Dt6cILSH+RTrc6TYjdZcAGp5x3tPnSfl25uh/Wy4NQ3z/SvdY9VfGQQL8EN0Fxhcb4vVRs7ib38Z4juymcJpcbNnKR4lrHL5GCHhB4TQxvK0J4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jERXJqbP; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpIoFEil5HUdfmScPWlMcRWaWyn/BliuUmuPxqKddl9KR4bL3jzIduVnwD5/lYWtN/KOdW5HLPnOvRDZdQO50KdB2DayTOD/quBXO0gybX/0eruSEyHpGu/ApFgQmYaSz+mMuFpm+O8Y4oVfUxRQwowy9S+Ok4Xgl9kHh1wv7v1OAI3KlvwnK92Mr0ElKvddqLn2wQo9FBrj9RyH52MGBdAUIrokBTpcFDrB6XqVf0Tr+0LX/UzXHlM1nGNTRC2LfzRnWG7XtB3vobgHWKZiC8qaMbSymPvepqVkg3rMjfe0u8jMzSTxZfwoBNpdHz7oTB5VtTp1lUUtzw78ITjihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0m850nmCsStNSkplQBqanGKCYnD233KZdkzziB9UCY=;
 b=ELmJIaXcnERBlULzDJILtc0hWPT6IEZbHye7ZsYjsl3WA2/hc9Id5ZS6+zSsFISzUjzd2KV1dDJz3UJ16j6e1l0r3CZwU3RSlhTlmZXtrLqFGB2gbBHzXuxZ+FzyJnGZa+nj5I9QaQ6I9NmM7Hj6vFoNxE0fWPMMCt+81yAU+W5k3I9h6eA4Ky+8jP0Hyi3EejSutZjBktMH8WoQvX3NYnuD6odvaxRi6uAZO53mZs5mKLfnK3TcreEqiYokGdKQqv7dYeAmzxpifIpCFBn+xXI1LE+/dSJtAaYqmfUozHXe23bQFTaO4W7STr4WI0YMcEJsCnta9YzurAYMxsudPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0m850nmCsStNSkplQBqanGKCYnD233KZdkzziB9UCY=;
 b=jERXJqbPPq9Q5M8GwcHMuXGUlmQkBnVQXslK9ohV10GFlksp8FfYzwZcPKXr6QLaWCPP/UQ2iwQBcZ90mWXvaHB6QVCPw+oF29RSdMoXBr2Ysvq8VWbu5lTegXM4qkgOKwZWQuLf5Ca1iIwLGvbQ5bzjKuA4GkLiQfZqTirs+aNAW/6rsqSkf/gVTI0/H97ElW3c43Siu1/nuc+SDxtDEIVt6Xw2wKIWZvnRvXPd07YLhFhhOAsBKdLKmPl0vi0HRZZ94DQUKZTWqE5PhucQ9VrHQ1tKObrUfvkMKPBqusKZpE5rHzvUU1AKMZS0kf5+HDEQNK9plAYCq5jyNl/Lsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS5PR04MB9894.eurprd04.prod.outlook.com (2603:10a6:20b:655::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 18:53:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 18:53:49 +0000
Date: Mon, 12 May 2025 21:53:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] ice: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250512185346.zxy2nk3kexhqf2px@skbuf>
References: <20250512160036.909434-1-vladimir.oltean@nxp.com>
 <f557afc2-32f5-4758-9c68-dd319ce508ba@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f557afc2-32f5-4758-9c68-dd319ce508ba@intel.com>
X-ClientProxiedBy: VI1PR09CA0169.eurprd09.prod.outlook.com
 (2603:10a6:800:120::23) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS5PR04MB9894:EE_
X-MS-Office365-Filtering-Correlation-Id: 05004be4-16f5-419a-8428-08dd918654f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2SUlZTEOQyIw4IKKQ1vKUyPBM/hrLwKxekzndrkzwG16RXYNsAH61YjZRL+c?=
 =?us-ascii?Q?i2Gb5xDYuyd94S6m0efJKTMq3jJVlMi768VyWVc0fuEoQanvP738yqB8ECmT?=
 =?us-ascii?Q?7BZSG2qAYA/bqY9qNVAC1EVKEZ+fYXft9ad9acQ3/ajGqpsJ+8YAc8Bb7gDy?=
 =?us-ascii?Q?BsqzvpMLGTHt2jB8KRPLspT6LQhyqu9ccYDeuz6FvdnV/myHwQs/0A7bq1vk?=
 =?us-ascii?Q?JnDLdt4/MR0p9QMfI2n6PdA8h4t6RKUgpvxrPbFc5RRfU4wsArIkUQLOInes?=
 =?us-ascii?Q?Gh0ezN/AqolEeO+nDxfiBDlKeAI7z8myQytyywxFVTtgVAXLoxDOuI8nSOyc?=
 =?us-ascii?Q?+KeLNaWjdtmMCUCw0iyiNM14A0Jo8BruosEdQn3M+VcKWaNYPocBa3jKwfZK?=
 =?us-ascii?Q?mNpGC+ApOBh3VJa0v0Q5ls24SW8gKg/MM38OrITd5xjNsHGYCKjpLEbWZC2z?=
 =?us-ascii?Q?e16icpfuoWmuBgFxFFia6TAv4azHZqtytL/KyKEFDxho/e/gBRcDR1nwDZJw?=
 =?us-ascii?Q?5qyYKmDM3cObDYwyLkT2V2gMbri3X1FLxlEhWgfHNd1ES8Uir+SL+dLzq89G?=
 =?us-ascii?Q?k3FNt+ZocUCL+jZTlwtOsutzBRm4JwQfnp2R28cYO26SqJcEPerKoZXAd+zb?=
 =?us-ascii?Q?Fl4dWwqqGVkRm3/DFSv7vz4m6brKKVEZP+pRW/qT5C000BGQwls3bsXZ9e53?=
 =?us-ascii?Q?7p4qxMMqPxw3E5OhLyIJjPSK5X5Kv64yKQUq5FjUE/VpF84G1ouEGSRj3RQV?=
 =?us-ascii?Q?Vbw1UD/0Kq6FVKk6wdNVGKoIrI9zpM/GcdquN8+G/wj/TEMFojKy/c2c4lB1?=
 =?us-ascii?Q?xyhUkLo2lMvpNetnBfaCNclROFFBjvhPJnCRL+ORm1E1rBpI7jlQjfIMGEO3?=
 =?us-ascii?Q?49zMPp1QslYVgn+c9pfGLq1pw5i07+JhzDMs+DWnBFA+9Og3IQx9H4zSzkcJ?=
 =?us-ascii?Q?j75sEuB+8v680PnasJV2Bd7w/+g2+9ZNCUQ+XUJ6ARRnvR6K/kwlo0mrx8xC?=
 =?us-ascii?Q?aDHVLWldlo3n0syqnKJj8PlCp8Ap9A3HRolKeOqY0+Z4QfSpItuFJvb/2Uwm?=
 =?us-ascii?Q?rARi2P2DkYI3A165/hZcouNsr8oNM/n+ZbTeg4JBBqkdLqlk7R7hB9PR1YKB?=
 =?us-ascii?Q?1Q49mM10zH86cbPo66RLV4ytfYsuuOyRKvmlHhcUVNhq3jHcMLl48Ch9rhzo?=
 =?us-ascii?Q?JrPyvPsNOarK7IhkmrpFqZdGo2Hr0yqQAqb0FCvlY+bWVCTGaWoQQjefN7nc?=
 =?us-ascii?Q?CLai/vaeitUFJSkhBm9kywQrcxZAX0My5N5rzbCNZJou17P+7TSSZbh9G5AA?=
 =?us-ascii?Q?zH4CyHw1Q1vn+TH6LgsVH533Q10SrfAy2b4QOmm3XzaEnOMFE0IooEUB9OZI?=
 =?us-ascii?Q?B4iq/l69UHs7I9Mb1jFNN17kNqdegRI2Y2dl36YtXBH7Pez6uzPsGnuX2pfd?=
 =?us-ascii?Q?fj5Swdn0lzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ePRPaHetgCJ7xJCrqylHEFi+2WxYTvtVHNCWvQS52L5NAa8JJN4TLonsPIry?=
 =?us-ascii?Q?bedo7Y35vUy7xk0do441bXytOJ5GG8rSTRwm9t4kpnnMaGkuZr8hxGvNsp8h?=
 =?us-ascii?Q?qdHEfYg9KtlYBeQj5ShuQM0qvqA+Jv4YpwFqChv5XWRaaIjZJq8NavmonXyz?=
 =?us-ascii?Q?YrjI9u9DfP/Rk0HeLYlxKa7CcURIwXV3GjmdTZPCHopOxD9DjyNKkOa8Pmtz?=
 =?us-ascii?Q?+i25sJ27MrNERbCMSwthx9b3kBPAwUaMl7Ke4ZOH+OrrMp3F6IAKoqW7JQg+?=
 =?us-ascii?Q?+BQpJGJCFtpdyljg1HoyBLKOhpNV4M/15FjgxZXLDrtrNtWGzLm51Yx3IpnK?=
 =?us-ascii?Q?30lEyB3HUcX9CpKS5KofVgcl2KA5gdrsVuq3J9zDOxXBtTvCpft7mGTzCt96?=
 =?us-ascii?Q?4XY7C6iNKqaCTSPPSvEP7sr1h58UewU8rZr6G2fasJCkphv0YO3MhPVyNeVZ?=
 =?us-ascii?Q?klkwiLmZiW/xBVyhNKsDof5wgMnhI6tOM+dLAe/o0rWiSvR+Gvu+pRsRSp14?=
 =?us-ascii?Q?326fHidXgjq+ASqIC6CKa9sBNPPGs1zZQ79a9vxlhn25gu0Dd+uDTZHOhOXQ?=
 =?us-ascii?Q?nmiIACCZ55fBioUD7yVnRu72PxkaBUV7c95rlTdWYHjiycjYL/4eGrrpaOlx?=
 =?us-ascii?Q?UGfoNmmtbIjqzsZg4OHZuF/CkFytwFjwjzVHc8niHKNAhdA7DmQhlT/or51P?=
 =?us-ascii?Q?8VUulr2j30x4OKzMvF1F5rRTYtEpAeXbTBdXHl4WtftjoPdgkYcwOCAy5aFo?=
 =?us-ascii?Q?22kn1OGtUys77wDzQL5OWTmBY8UIs+bPGbmOFiDfNhQtn5nuwTv7KbClaat4?=
 =?us-ascii?Q?Cia1y/OGqOI3Lgd/kGJHF7xoESoXtHuhrEIS/6jC2FMGvjxw//lDbOnOtlw4?=
 =?us-ascii?Q?0kHPQ2nBmnKuFe7qT6MSpS14GF02xjGVTRQvrSeiR+EfnXRUSPCekma02Lhq?=
 =?us-ascii?Q?yUg5i1lpC/Xz1zPhFjPbSUS4fSFdrLP9JjNhDBAQa9/KQUH5gxGiRHBiUucq?=
 =?us-ascii?Q?lL7+kG2vIdLkjWgs6Tf6QB2w9dPLJ2S6X4ePQk5dldf3lvDlrFWb7tS3qVEM?=
 =?us-ascii?Q?iX6Mv57/6SCbIdIgv3T4yWDiCHpTD5xLLtEQhzyWRLPJNBzmhSVKYAJtr0fI?=
 =?us-ascii?Q?e6qg62JvNl03Emd4aLc5wfefeGokMq7c8VfR2bT2vgLl7r+t4rvPMEXZJnFh?=
 =?us-ascii?Q?tVa5h5KURw3IWn/sBjubz+l8VGLp8Tg/D64rDC4CfdL3zTFS9N/ucoiublWI?=
 =?us-ascii?Q?uCiidqobcSTsDTeh8or5Qo0b0kmzpmPkq7GaTYd8gqVYLBO8mC+AIO1/yeF+?=
 =?us-ascii?Q?+tDeYb4OLOAB07YiO5gORL9pHolnxJsA3fHKRCZ5Mh1AEbnTPKY59fXCBaZA?=
 =?us-ascii?Q?Y8hOoy31GYHcv7MonZo35dPpKiblBvwbbiTS3yrtDZr2Q73LADXvEXVHv9Mv?=
 =?us-ascii?Q?IUWpkRAIgRBZNLV6YLu6VXXgmw2B/oq7AQ2jb/xsgHqGfv8jkElNDNBEs5n2?=
 =?us-ascii?Q?bABiCqQSfHq7CFOSP9+nIw1hsWN+X5jg8gKYo6HqmTewKY3en2MyGIekq8KA?=
 =?us-ascii?Q?2rcwXLXsD2nvQzlOaqvP3UU+wkJKtfuPnXFPmqjE71UV6q3uF3G0yPj8Veec?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05004be4-16f5-419a-8428-08dd918654f5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:53:49.6065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOAygqpBe/3VNJFr0zlixyTTAOWyoWGLvz/CGPRqw9mOYbH3ngx5yjkb9zaSL+AxDnYVaBpzSNFudEIqH84lRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9894

On Mon, May 12, 2025 at 11:38:17AM -0700, Jacob Keller wrote:
> On 5/12/2025 9:00 AM, Vladimir Oltean wrote:
> > New timestamping API was introduced in commit 66f7223039c0 ("net: add
> > NDOs for configuring hardware timestamping") from kernel v6.6.
> > 
> > It is time to convert the Intel ice driver to the new API, so that
> > timestamping configuration can be removed from the ndo_eth_ioctl() path
> > completely.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> 
> Acked-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Thanks. This has been on my list of nits to cleanup but I hadn't gotten
> around to it yet.
> 
> I'm covering for Tony for a few days, and will queue this up on his
> dev-queue today, so that it get get through our validation cycle.

Ok. I have 3 more Intel conversions pending (igb, ixgbe, i40e), but I've
put a stop for today. I assume it's fine to post these to net-next and
not to the iwl-next tree, or would you prefer otherwise?

